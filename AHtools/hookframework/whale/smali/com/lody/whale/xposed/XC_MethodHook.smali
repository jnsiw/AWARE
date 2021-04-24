.class public Lcom/lody/whale/xposed/XC_MethodHook;
.super Lcom/lody/whale/xposed/callbacks/XCallback;
.source "XC_MethodHook.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lody/whale/xposed/XC_MethodHook$Unhook;,
        Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;
    }
.end annotation


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Lcom/lody/whale/xposed/callbacks/XCallback;-><init>()V

    .line 19
    return-void
.end method

.method constructor <init>(I)V
    .locals 0
    .param p1, "priority"    # I

    .line 32
    invoke-direct {p0, p1}, Lcom/lody/whale/xposed/callbacks/XCallback;-><init>(I)V

    .line 33
    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0
    .param p1, "param"    # Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 69
    return-void
.end method

.method protected beforeHookedMethod(Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0
    .param p1, "param"    # Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 51
    return-void
.end method
