Return-Path: <linux-iio+bounces-2068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83288442B2
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 16:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88A51C215CC
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72D784A2E;
	Wed, 31 Jan 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRh9IE4f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C484A26
	for <linux-iio@vger.kernel.org>; Wed, 31 Jan 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713825; cv=none; b=F2K+s3lj5N3hwI/OJ50iWjtmNXDKki61zGtsi2vmozclf2Lv0dc21Hi2TFWXK1P/FRuZhdQOjyLoA9T/Xm45DS4QcD92kmZCv4Y22C8lfix9fXPTLCdOuamvoABohz0kMife/vhTel7caiQ8QpEACN4aIjIU4lewNSI7LddT000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713825; c=relaxed/simple;
	bh=0/iJefaAJf2oWDzCJ8UE6x+51GC/FK1SSjAUFOIrvlo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZHtt0TdGOPrhBDzCGxokYbQSHQlwdMsu7kv4uyUWKxr9zBbnmrujNdj8dO/ADOKb09YY+EZoMUwne/VtyV0RQxGupZXbZBmeB1Vrv0eHWZH6uABE7DnSffzBsMTraf7slj0XIGhR6xKj3HWOugbUDXJxF9j2EQtxajHcq9umFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRh9IE4f; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso6277924a12.3
        for <linux-iio@vger.kernel.org>; Wed, 31 Jan 2024 07:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706713821; x=1707318621; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyOjRtC/w0+EgkN822hXLBFVOn9Rntkyo6SO6+Co7k8=;
        b=iRh9IE4fViInwJY+sa+X9OMDnxJoM9HTF/iVbyNBHp28VDbQoYC1prH03YIWTZRldn
         kkIpYVK87cqof0aTJzB8GP4rqGdo9Nxhq/SO/OIDMVKhfhZYRxtWBKAA8Wsqi4WLOI/3
         owF59w6z9VAvjzXkVPv4gq1PjQylZWP4ishwTmfKR/B0JXyCEbmz5YJc859SWx2qlBhf
         FUaZYjVMiwFMgGU7ahI7zmkf1+jlxrfBUpi2N94jfN+QOd0R1b0yQ4Wc8eP/u05gUx6r
         IQxH5+S9t1K9EKyOl15cA2Y2WIWR12mW+bS6rz11kORc4d6tjbHIziuMenVTkT9G2BCI
         wSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713821; x=1707318621;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyOjRtC/w0+EgkN822hXLBFVOn9Rntkyo6SO6+Co7k8=;
        b=kaoRrYmBoXRLlCHm/E1tmQSRBIdluQrkWncyszaot4EMhksYdYhodsq1EMG+87qx1B
         QPTXC4uZz1uwX+9leEc6/I+l7VeYtXcXFMpYlPJqoQjHEKZG1POwXR6Qb1EYhQ+ZA8Dy
         S4DeRsQwFCAU46hyQrnkDfwFQoorUPnJ6CvXEElTKgVAaWO8LJBbDQb3KBuAEvBtkpFX
         tssFA0iZVbTqgzCjlui9wUOy1MYw8r4G5+J+G90xC3GOxwPfWLJenk46Vyz7g2eRXBew
         mXYZaS2sYV2SJodEbzWhOdkWyM0xBNdd9uw5db4iWcjb+sK6duwqsAmjHrnxSi+kQTLD
         nTng==
X-Gm-Message-State: AOJu0YzMCv0IzeAGxsUTZYSr+jTS3/+4jaYzr7E6Jo0+Th/4m1puM9xO
	NguzEJ3msfomkIp3wrOiB0s4PT6kuwScFWW5m7B3D36Nrqf9GZ1o4ddzo2SgjKSpmjC5Cre4lyv
	A2Iar81K7kdS9kPF4LvM3fxpI3W2cd50g35ThXDcyd0U=
X-Google-Smtp-Source: AGHT+IFt9LWhYp48XU5YL4fTQmr3HcbeO7mEZaQFdql1/u4eLdW4F9TUpfzblxzV6o8X+FzQ7YNWH6V8WxwrrcvdzUM=
X-Received: by 2002:a05:6402:4491:b0:55f:8c38:36a9 with SMTP id
 er17-20020a056402449100b0055f8c3836a9mr1590334edb.42.1706713821308; Wed, 31
 Jan 2024 07:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikita Mikhailevich <ermyril@gmail.com>
Date: Wed, 31 Jan 2024 16:10:09 +0100
Message-ID: <CAHoRnbRjtAOE0xKUUZh8zfALzGnLPCjrxUE15jJ_y7i1dQq+Uw@mail.gmail.com>
Subject: iio: accel: mxc4005: new ACPI ID for the MXC6655 accelerometer?
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

I've got a laptop which has an MXC6655 accelerometer, but I couldn't
get it up and running despite the driver being present in the kernel.
When I was manually doing modprobe mxc4005 - nothing happened. Journal
and dmesg don't have anything relevant in them.
And if I was trying to run monitor-sensor and start iio-sensor-proxy,
I was getting a following error:

Failed to claim accelerometer:
GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name :1.609
was not provided by any .service files

The device in /sys/bus/acpi/devices shows as MDA6655 instead of
MXC6655, which led me to try applying the following changes, after
which the device started working properly:

Signed-off-by: Nikita Mikhailevich <ermyril@gmail.com>
---
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 82e8d0b39..0928b6e13 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -472,6 +472,7 @@ static int mxc4005_probe(struct i2c_client *client)
 static const struct acpi_device_id mxc4005_acpi_match[] =3D {
     {"MXC4005",    0},
     {"MXC6655",    0},
+    {"MDA6655",    0},
     { },
 };
 MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
@@ -479,6 +480,7 @@ MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
 static const struct of_device_id mxc4005_of_match[] =3D {
     { .compatible =3D "memsic,mxc4005", },
     { .compatible =3D "memsic,mxc6655", },
+    { .compatible =3D "memsic,mda6655", },
     { },
 };
 MODULE_DEVICE_TABLE(of, mxc4005_of_match);
@@ -486,6 +488,7 @@ MODULE_DEVICE_TABLE(of, mxc4005_of_match);
 static const struct i2c_device_id mxc4005_id[] =3D {
     {"mxc4005",    0},
     {"mxc6655",    0},
+    {"mda6655",     0},
     { },
 };
 MODULE_DEVICE_TABLE(i2c, mxc4005_id);
---

Please let me know what should my next steps be, is such patch legit
and should be submitted properly, is there anything wrong with the
code or are we able to mitigate the issue without changes in the
kernel, using udev rules for example, and if so - should we? (that
will leave such devices still broken by default)

Thank you,
Nikita Mikhailevich


The following are the debug commands that might be useful to
understand the situation, they were taken before rebuilding the kernel
with the patch above

$ journalctl | grep -E "4005|6655"
Jan 17 03:25:38 nixos systemd-modules-load[388]: Inserted module 'mxc4005'
Jan 17 10:11:08 nixos systemd-modules-load[401]: Inserted module 'mxc4005'
Jan 17 10:23:12 nixos systemd-modules-load[422]: Inserted module 'mxc4005'

$ journalctl | grep -Ei "iio"
Jan 21 06:00:22 nixos systemd[1]: Starting IIO Sensor Proxy service...
Jan 21 06:00:22 nixos systemd[1]: Started IIO Sensor Proxy service.
Jan 21 06:00:22 nixos systemd[1]: iio-sensor-proxy.service:
Deactivated successfully.

$ lsmod | grep 4005
mxc4005                16384  0
industrialio_triggered_buffer    12288  1 mxc4005
industrialio          135168  3 industrialio_triggered_buffer,kfifo_buf,mxc=
4005

$ ls -al /sys/bus/acpi/devices | grep 6655
lrwxrwxrwx 1 root root 0 Jan 24 22:57 MDA6655:00 ->
../../../devices/LNXSYSTM:00/LNXSYBUS:00/MDA6655:00
lrwxrwxrwx 1 root root 0 Jan 24 22:57 MXC6655:00 ->
../../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/MXC6655:00
lrwxrwxrwx 1 root root 0 Jan 24 22:57 MXC6655:01 ->
../../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6e/MXC6655:01

$ ls -al /sys/bus/i2c/devices/ | grep 6655
lrwxrwxrwx 1 root root 0 Jan 24 23:23 i2c-MDA6655:00 ->
../../../devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-MDA6655=
:00

$ cat /sys/bus/i2c/devices/i2c-MDA6655:00/modalias
acpi:MDA6655:MDA6655:

$ cat /sys/bus/acpi/devices/MDA6655:00/modalias
acpi:MDA6655:MDA6655:

$ udevadm info --export-db | grep iio
  - empty output


$ udevadm info --attribute-walk --path=3D/sys/bus/acpi/devices/MDA6655:00/

  looking at device '/devices/LNXSYSTM:00/LNXSYBUS:00/MDA6655:00':
    KERNEL=3D=3D"MDA6655:00"
    SUBSYSTEM=3D=3D"acpi"
    DRIVER=3D=3D""
    ATTR{adr}=3D=3D"0x00000000"
    ATTR{hid}=3D=3D"MDA6655"
    ATTR{path}=3D=3D"\_SB_.ACMK"
    ATTR{power/async}=3D=3D"disabled"
    ATTR{power/control}=3D=3D"auto"
    ATTR{power/runtime_active_kids}=3D=3D"0"
    ATTR{power/runtime_active_time}=3D=3D"0"
    ATTR{power/runtime_enabled}=3D=3D"disabled"
    ATTR{power/runtime_status}=3D=3D"unsupported"
    ATTR{power/runtime_suspended_time}=3D=3D"0"
    ATTR{power/runtime_usage}=3D=3D"0"
    ATTR{status}=3D=3D"15"
    ATTR{uid}=3D=3D"1"

  looking at parent device '/devices/LNXSYSTM:00/LNXSYBUS:00':
    KERNELS=3D=3D"LNXSYBUS:00"
    SUBSYSTEMS=3D=3D"acpi"
    DRIVERS=3D=3D""
    ATTRS{hid}=3D=3D"LNXSYBUS"
    ATTRS{path}=3D=3D"\_SB_"
    ATTRS{power/async}=3D=3D"disabled"
    ATTRS{power/control}=3D=3D"auto"
    ATTRS{power/runtime_active_kids}=3D=3D"0"
    ATTRS{power/runtime_active_time}=3D=3D"0"
    ATTRS{power/runtime_enabled}=3D=3D"disabled"
    ATTRS{power/runtime_status}=3D=3D"unsupported"
    ATTRS{power/runtime_suspended_time}=3D=3D"0"
    ATTRS{power/runtime_usage}=3D=3D"0"

  looking at parent device '/devices/LNXSYSTM:00':
    KERNELS=3D=3D"LNXSYSTM:00"
    SUBSYSTEMS=3D=3D"acpi"
    DRIVERS=3D=3D""
    ATTRS{hid}=3D=3D"LNXSYSTM"
    ATTRS{path}=3D=3D"\"
    ATTRS{power/async}=3D=3D"disabled"
    ATTRS{power/control}=3D=3D"auto"
    ATTRS{power/runtime_active_kids}=3D=3D"0"
    ATTRS{power/runtime_active_time}=3D=3D"0"
    ATTRS{power/runtime_enabled}=3D=3D"disabled"
    ATTRS{power/runtime_status}=3D=3D"unsupported"
    ATTRS{power/runtime_suspended_time}=3D=3D"0"
    ATTRS{power/runtime_usage}=3D=3D"0"


$ udevadm info --attribute-walk --path=3D/sys/bus/acpi/devices/MXC6655:00/

  looking at device
'/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/MXC6655:00':
    KERNEL=3D=3D"MXC6655:00"
    SUBSYSTEM=3D=3D"acpi"
    DRIVER=3D=3D""
    ATTR{adr}=3D=3D"0x00000000"
    ATTR{adr}=3D=3D"0x00000000"
    ATTR{hid}=3D=3D"MXC6655"
    ATTR{path}=3D=3D"\_SB_.PC00.I2C0.ACMG"
    ATTR{power/async}=3D=3D"disabled"
    ATTR{power/control}=3D=3D"auto"
    ATTR{power/runtime_active_kids}=3D=3D"0"
    ATTR{power/runtime_active_time}=3D=3D"0"
    ATTR{power/runtime_enabled}=3D=3D"disabled"
    ATTR{power/runtime_status}=3D=3D"unsupported"
    ATTR{power/runtime_suspended_time}=3D=3D"0"
    ATTR{power/runtime_usage}=3D=3D"0"
    ATTR{status}=3D=3D"0"
    ATTR{uid}=3D=3D"1"

  looking at parent device
'/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c':
    KERNELS=3D=3D"device:6c"
    SUBSYSTEMS=3D=3D"acpi"
    DRIVERS=3D=3D""
    ATTRS{adr}=3D=3D"0x00150000"
    ATTRS{path}=3D=3D"\_SB_.PC00.I2C0"
    ATTRS{power/async}=3D=3D"disabled"
    ATTRS{power/control}=3D=3D"auto"
    ATTRS{power/runtime_active_kids}=3D=3D"0"
    ATTRS{power/runtime_active_time}=3D=3D"0"
    ATTRS{power/runtime_enabled}=3D=3D"disabled"
    ATTRS{power/runtime_status}=3D=3D"unsupported"
    ATTRS{power/runtime_suspended_time}=3D=3D"0"
    ATTRS{power/runtime_usage}=3D=3D"0"
    ATTRS{power_state}=3D=3D"D3hot"

  looking at parent device '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00':
    KERNELS=3D=3D"PNP0A08:00"
    SUBSYSTEMS=3D=3D"acpi"
    DRIVERS=3D=3D""
    ATTRS{adr}=3D=3D"0x00000000"
    ATTRS{hid}=3D=3D"PNP0A08"
    ATTRS{path}=3D=3D"\_SB_.PC00"
    ATTRS{power/async}=3D=3D"disabled"
    ATTRS{power/control}=3D=3D"auto"
    ATTRS{power/runtime_active_kids}=3D=3D"0"
    ATTRS{power/runtime_active_time}=3D=3D"0"
    ATTRS{power/runtime_enabled}=3D=3D"disabled"
    ATTRS{power/runtime_status}=3D=3D"unsupported"
    ATTRS{power/runtime_suspended_time}=3D=3D"0"
    ATTRS{power/runtime_usage}=3D=3D"0"
    ATTRS{uid}=3D=3D"0"

  looking at parent device '/devices/LNXSYSTM:00/LNXSYBUS:00':
    KERNELS=3D=3D"LNXSYBUS:00"
    SUBSYSTEMS=3D=3D"acpi"
    DRIVERS=3D=3D""
    ATTRS{hid}=3D=3D"LNXSYBUS"
    ATTRS{path}=3D=3D"\_SB_"
    ATTRS{power/async}=3D=3D"disabled"
    ATTRS{power/control}=3D=3D"auto"
    ATTRS{power/runtime_active_kids}=3D=3D"0"
    ATTRS{power/runtime_active_time}=3D=3D"0"
    ATTRS{power/runtime_enabled}=3D=3D"disabled"
    ATTRS{power/runtime_status}=3D=3D"unsupported"
    ATTRS{power/runtime_suspended_time}=3D=3D"0"
    ATTRS{power/runtime_usage}=3D=3D"0"

  looking at parent device '/devices/LNXSYSTM:00':
    KERNELS=3D=3D"LNXSYSTM:00"
    SUBSYSTEMS=3D=3D"acpi"
    DRIVERS=3D=3D""
    ATTRS{hid}=3D=3D"LNXSYSTM"
    ATTRS{path}=3D=3D"\"
    ATTRS{power/async}=3D=3D"disabled"
    ATTRS{power/control}=3D=3D"auto"
    ATTRS{power/runtime_active_kids}=3D=3D"0"
    ATTRS{power/runtime_active_time}=3D=3D"0"
    ATTRS{power/runtime_enabled}=3D=3D"disabled"
    ATTRS{power/runtime_status}=3D=3D"unsupported"
    ATTRS{power/runtime_suspended_time}=3D=3D"0"
    ATTRS{power/runtime_usage}=3D=3D"0"


$ cat /sys/class/dmi/id/modalias
dmi:bvnAmericanMegatrendsInternational,LLC.:bvrDNN20V2.13:bd09/05/2023:br2.=
13:efr0.15:svnCHUWIInnovationAndTechnology(ShenZhen)co.,Ltd:pnMiniBookX:pvr=
Defaultstring:rvnDefaultstring:rnDefaultstring:rvrDefaultstring:cvnDefaults=
tring:ct10:cvrDefaultstring:skuDefaultstring:

