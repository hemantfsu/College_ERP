import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { Student, Payment, HostelRoom, Exam, UserRole, NotificationItem } from '../types';
import { mockStudents, mockPayments, mockHostelRooms, mockExams } from '../data/mockData';

interface AppContextType {
  currentUser: {
    name: string;
    role: UserRole;
    id: string;
  };
  students: Student[];
  payments: Payment[];
  hostelRooms: HostelRoom[];
  exams: Exam[];
  notifications: NotificationItem[];
  setCurrentUser: (user: { name: string; role: UserRole; id: string }) => void;
  addStudent: (student: Student) => void;
  updateStudent: (id: string, updates: Partial<Student>) => void;
  addPayment: (payment: Payment) => void;
  updateHostelRoom: (id: string, updates: Partial<HostelRoom>) => void;
  addNotification: (notification: NotificationItem) => void;
  markNotificationRead: (id: string) => void;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

export function AppProvider({ children }: { children: ReactNode }) {
  const [currentUser, setCurrentUser] = useState({
    name: 'Admin User',
    role: 'admin' as UserRole,
    id: 'admin-001',
  });

  const [students, setStudents] = useState<Student[]>(() => {
    const stored = localStorage.getItem('students');
    return stored ? JSON.parse(stored) : mockStudents;
  });

  const [payments, setPayments] = useState<Payment[]>(() => {
    const stored = localStorage.getItem('payments');
    return stored ? JSON.parse(stored) : mockPayments;
  });

  const [hostelRooms, setHostelRooms] = useState<HostelRoom[]>(() => {
    const stored = localStorage.getItem('hostelRooms');
    return stored ? JSON.parse(stored) : mockHostelRooms;
  });

  const [exams, setExams] = useState<Exam[]>(() => {
    const stored = localStorage.getItem('exams');
    return stored ? JSON.parse(stored) : mockExams;
  });

  const [notifications, setNotifications] = useState<NotificationItem[]>([]);

  // Persist to localStorage
  useEffect(() => {
    localStorage.setItem('students', JSON.stringify(students));
  }, [students]);

  useEffect(() => {
    localStorage.setItem('payments', JSON.stringify(payments));
  }, [payments]);

  useEffect(() => {
    localStorage.setItem('hostelRooms', JSON.stringify(hostelRooms));
  }, [hostelRooms]);

  useEffect(() => {
    localStorage.setItem('exams', JSON.stringify(exams));
  }, [exams]);

  const addStudent = (student: Student) => {
    setStudents((prev) => [...prev, student]);
  };

  const updateStudent = (id: string, updates: Partial<Student>) => {
    setStudents((prev) =>
      prev.map((student) =>
        student.studentId === id ? { ...student, ...updates } : student
      )
    );
  };

  const addPayment = (payment: Payment) => {
    setPayments((prev) => [...prev, payment]);
    // Update student balance
    const student = students.find((s) => s.studentId === payment.studentId);
    if (student) {
      updateStudent(payment.studentId, {
        feeBalance: student.feeBalance - payment.amount,
      });
    }
  };

  const updateHostelRoom = (id: string, updates: Partial<HostelRoom>) => {
    setHostelRooms((prev) =>
      prev.map((room) => (room.id === id ? { ...room, ...updates } : room))
    );
  };

  const addNotification = (notification: NotificationItem) => {
    setNotifications((prev) => [notification, ...prev]);
  };

  const markNotificationRead = (id: string) => {
    setNotifications((prev) =>
      prev.map((notif) => (notif.id === id ? { ...notif, read: true } : notif))
    );
  };

  return (
    <AppContext.Provider
      value={{
        currentUser,
        students,
        payments,
        hostelRooms,
        exams,
        notifications,
        setCurrentUser,
        addStudent,
        updateStudent,
        addPayment,
        updateHostelRoom,
        addNotification,
        markNotificationRead,
      }}
    >
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within AppProvider');
  }
  return context;
}
