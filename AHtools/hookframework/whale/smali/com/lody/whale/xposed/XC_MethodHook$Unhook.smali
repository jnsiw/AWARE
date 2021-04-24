.class public final Lcom/lody/whale/xposed/XC_MethodHook$Unhook;
.super Ljava/lang/Object;
.source "XC_MethodHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lody/whale/xposed/XC_MethodHook;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "Unhook"
.end annotation


# instance fields
.field private final hookMethod:Ljava/lang/reflect/Member;

.field final synthetic this$0:Lcom/lody/whale/xposed/XC_MethodHook;


# direct methods
.method constructor <init>(Lcom/lody/whale/xposed/XC_MethodHook;Ljava/lang/reflect/Member;)V
    .locals 0
    .param p1, "this$0"    # Lcom/lody/whale/xposed/XC_MethodHook;
    .param p2, "hookMethod"    # Ljava/lang/reflect/Member;

    .line 160
    iput-object p1, p0, Lcom/lody/whale/xposed/XC_MethodHook$Unhook;->this$0:Lcom/lody/whale/xposed/XC_MethodHook;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 161
    iput-object p2, p0, Lcom/lody/whale/xposed/XC_MethodHook$Unhook;->hookMethod:Ljava/lang/reflect/Member;

    .line 162
    return-void
.end method


# virtual methods
.method public getCallback()Lcom/lody/whale/xposed/XC_MethodHook;
    .locals 1

    .line 172
    iget-object v0, p0, Lcom/lody/whale/xposed/XC_MethodHook$Unhook;->this$0:Lcom/lody/whale/xposed/XC_MethodHook;

    return-object v0
.end method

.method public getHookedMethod()Ljava/lang/reflect/Member;
    .locals 1

    .line 168
    iget-object v0, p0, Lcom/lody/whale/xposed/XC_MethodHook$Unhook;->hookMethod:Ljava/lang/reflect/Member;

    return-object v0
.end method

.method public unhook()V
    .locals 2

    .line 176
    iget-object v0, p0, Lcom/lody/whale/xposed/XC_MethodHook$Unhook;->hookMethod:Ljava/lang/reflect/Member;

    iget-object v1, p0, Lcom/lody/whale/xposed/XC_MethodHook$Unhook;->this$0:Lcom/lody/whale/xposed/XC_MethodHook;

    invoke-static {v0, v1}, Lcom/lody/whale/xposed/XposedBridge;->unhookMethod(Ljava/lang/reflect/Member;Lcom/lody/whale/xposed/XC_MethodHook;)V

    .line 177
    return-void
.end method
