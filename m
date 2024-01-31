Return-Path: <linux-iio+bounces-2072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A98444AE
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C665A2860AD
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99838DE6;
	Wed, 31 Jan 2024 16:38:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3512AAEB
	for <linux-iio@vger.kernel.org>; Wed, 31 Jan 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719128; cv=none; b=erF/oWwuA6zuDMLbj9xI4zywDv+Lbsu2Uedon8VUuML76qUyMXyPZCbZR3coC+EMps36ARhxbTgTRTTaD1JToSqcper4ZrocBNR2j496bhEbrUv3RU3GwlsIQ7jfJqkYs2IDTGnHRmAfQ1y3y9cywb0RWv2nd6yhwlHQwAvq8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719128; c=relaxed/simple;
	bh=hJ5Td27H6gjrg3w5zSOd5todnZqL5ZslKB9SuMId2Xs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWXFBHZmY1FwmdymHOFhQ3gcyVpvCPiVf/JHclsbbdhvMKEkmkzo8hZizJTaxLv+QF2c6B2EOZl/H41pK8lU6TIh5EKrA0S9FNHxB2gyjW0a+IVJ2xWohyLM3L46tx5Ns29Gp54+B15MdBzZjb7Fs7MG6WweZzNaI+1jjs7eKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQ72B4BmTz6K5rH;
	Thu,  1 Feb 2024 00:35:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E5DB1400DB;
	Thu,  1 Feb 2024 00:38:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 31 Jan
 2024 16:38:42 +0000
Date: Wed, 31 Jan 2024 16:38:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nikita Mikhailevich <ermyril@gmail.com>
CC: <linux-iio@vger.kernel.org>
Subject: Re: iio: accel: mxc4005: new ACPI ID for the MXC6655 accelerometer?
Message-ID: <20240131163842.00003c64@Huawei.com>
In-Reply-To: <CAHoRnbRjtAOE0xKUUZh8zfALzGnLPCjrxUE15jJ_y7i1dQq+Uw@mail.gmail.com>
References: <CAHoRnbRjtAOE0xKUUZh8zfALzGnLPCjrxUE15jJ_y7i1dQq+Uw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 31 Jan 2024 16:10:09 +0100
Nikita Mikhailevich <ermyril@gmail.com> wrote:

> Hello!
> 
> I've got a laptop which has an MXC6655 accelerometer, but I couldn't
> get it up and running despite the driver being present in the kernel.
> When I was manually doing modprobe mxc4005 - nothing happened. Journal
> and dmesg don't have anything relevant in them.
> And if I was trying to run monitor-sensor and start iio-sensor-proxy,
> I was getting a following error:
> 
> Failed to claim accelerometer:
> GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name :1.609
> was not provided by any .service files
> 
> The device in /sys/bus/acpi/devices shows as MDA6655 instead of
> MXC6655, which led me to try applying the following changes, after
> which the device started working properly:
> 
> Signed-off-by: Nikita Mikhailevich <ermyril@gmail.com>
> ---
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index 82e8d0b39..0928b6e13 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -472,6 +472,7 @@ static int mxc4005_probe(struct i2c_client *client)
>  static const struct acpi_device_id mxc4005_acpi_match[] = {
>      {"MXC4005",    0},
>      {"MXC6655",    0},
> +    {"MDA6655",    0},

This is good.

>      { },
>  };
>  MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
> @@ -479,6 +480,7 @@ MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
>  static const struct of_device_id mxc4005_of_match[] = {
>      { .compatible = "memsic,mxc4005", },
>      { .compatible = "memsic,mxc6655", },
> +    { .compatible = "memsic,mda6655", },

Don't add this.  As far as we know it's just an ACPI ID, not a new
part number.

>      { },
>  };
>  MODULE_DEVICE_TABLE(of, mxc4005_of_match);
> @@ -486,6 +488,7 @@ MODULE_DEVICE_TABLE(of, mxc4005_of_match);
>  static const struct i2c_device_id mxc4005_id[] = {
>      {"mxc4005",    0},
>      {"mxc6655",    0},
> +    {"mda6655",     0},
Don't add this either.

>      { },
>  };
>  MODULE_DEVICE_TABLE(i2c, mxc4005_id);
> ---
> 
> Please let me know what should my next steps be, is such patch legit
> and should be submitted properly, is there anything wrong with the
> code or are we able to mitigate the issue without changes in the
> kernel, using udev rules for example, and if so - should we? (that
> will leave such devices still broken by default)

Submit a patch formally adding the ACPI Table entry you have above.
Include the device details in the patch description so we konw
this ID is definitely out there on a real device.

Thanks,

Jonathan

> 
> Thank you,
> Nikita Mikhailevich
> 
> 
> The following are the debug commands that might be useful to
> understand the situation, they were taken before rebuilding the kernel
> with the patch above
> 
> $ journalctl | grep -E "4005|6655"
> Jan 17 03:25:38 nixos systemd-modules-load[388]: Inserted module 'mxc4005'
> Jan 17 10:11:08 nixos systemd-modules-load[401]: Inserted module 'mxc4005'
> Jan 17 10:23:12 nixos systemd-modules-load[422]: Inserted module 'mxc4005'
> 
> $ journalctl | grep -Ei "iio"
> Jan 21 06:00:22 nixos systemd[1]: Starting IIO Sensor Proxy service...
> Jan 21 06:00:22 nixos systemd[1]: Started IIO Sensor Proxy service.
> Jan 21 06:00:22 nixos systemd[1]: iio-sensor-proxy.service:
> Deactivated successfully.
> 
> $ lsmod | grep 4005
> mxc4005                16384  0
> industrialio_triggered_buffer    12288  1 mxc4005
> industrialio          135168  3 industrialio_triggered_buffer,kfifo_buf,mxc4005
> 
> $ ls -al /sys/bus/acpi/devices | grep 6655
> lrwxrwxrwx 1 root root 0 Jan 24 22:57 MDA6655:00 ->
> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/MDA6655:00
> lrwxrwxrwx 1 root root 0 Jan 24 22:57 MXC6655:00 ->
> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/MXC6655:00
> lrwxrwxrwx 1 root root 0 Jan 24 22:57 MXC6655:01 ->
> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6e/MXC6655:01
> 
> $ ls -al /sys/bus/i2c/devices/ | grep 6655
> lrwxrwxrwx 1 root root 0 Jan 24 23:23 i2c-MDA6655:00 ->
> ../../../devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-MDA6655:00
> 
> $ cat /sys/bus/i2c/devices/i2c-MDA6655:00/modalias
> acpi:MDA6655:MDA6655:
> 
> $ cat /sys/bus/acpi/devices/MDA6655:00/modalias
> acpi:MDA6655:MDA6655:
> 
> $ udevadm info --export-db | grep iio
>   - empty output
> 
> 
> $ udevadm info --attribute-walk --path=/sys/bus/acpi/devices/MDA6655:00/
> 
>   looking at device '/devices/LNXSYSTM:00/LNXSYBUS:00/MDA6655:00':
>     KERNEL=="MDA6655:00"
>     SUBSYSTEM=="acpi"
>     DRIVER==""
>     ATTR{adr}=="0x00000000"
>     ATTR{hid}=="MDA6655"
>     ATTR{path}=="\_SB_.ACMK"
>     ATTR{power/async}=="disabled"
>     ATTR{power/control}=="auto"
>     ATTR{power/runtime_active_kids}=="0"
>     ATTR{power/runtime_active_time}=="0"
>     ATTR{power/runtime_enabled}=="disabled"
>     ATTR{power/runtime_status}=="unsupported"
>     ATTR{power/runtime_suspended_time}=="0"
>     ATTR{power/runtime_usage}=="0"
>     ATTR{status}=="15"
>     ATTR{uid}=="1"
> 
>   looking at parent device '/devices/LNXSYSTM:00/LNXSYBUS:00':
>     KERNELS=="LNXSYBUS:00"
>     SUBSYSTEMS=="acpi"
>     DRIVERS==""
>     ATTRS{hid}=="LNXSYBUS"
>     ATTRS{path}=="\_SB_"
>     ATTRS{power/async}=="disabled"
>     ATTRS{power/control}=="auto"
>     ATTRS{power/runtime_active_kids}=="0"
>     ATTRS{power/runtime_active_time}=="0"
>     ATTRS{power/runtime_enabled}=="disabled"
>     ATTRS{power/runtime_status}=="unsupported"
>     ATTRS{power/runtime_suspended_time}=="0"
>     ATTRS{power/runtime_usage}=="0"
> 
>   looking at parent device '/devices/LNXSYSTM:00':
>     KERNELS=="LNXSYSTM:00"
>     SUBSYSTEMS=="acpi"
>     DRIVERS==""
>     ATTRS{hid}=="LNXSYSTM"
>     ATTRS{path}=="\"
>     ATTRS{power/async}=="disabled"
>     ATTRS{power/control}=="auto"
>     ATTRS{power/runtime_active_kids}=="0"
>     ATTRS{power/runtime_active_time}=="0"
>     ATTRS{power/runtime_enabled}=="disabled"
>     ATTRS{power/runtime_status}=="unsupported"
>     ATTRS{power/runtime_suspended_time}=="0"
>     ATTRS{power/runtime_usage}=="0"
> 
> 
> $ udevadm info --attribute-walk --path=/sys/bus/acpi/devices/MXC6655:00/
> 
>   looking at device
> '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/MXC6655:00':
>     KERNEL=="MXC6655:00"
>     SUBSYSTEM=="acpi"
>     DRIVER==""
>     ATTR{adr}=="0x00000000"
>     ATTR{adr}=="0x00000000"
>     ATTR{hid}=="MXC6655"
>     ATTR{path}=="\_SB_.PC00.I2C0.ACMG"
>     ATTR{power/async}=="disabled"
>     ATTR{power/control}=="auto"
>     ATTR{power/runtime_active_kids}=="0"
>     ATTR{power/runtime_active_time}=="0"
>     ATTR{power/runtime_enabled}=="disabled"
>     ATTR{power/runtime_status}=="unsupported"
>     ATTR{power/runtime_suspended_time}=="0"
>     ATTR{power/runtime_usage}=="0"
>     ATTR{status}=="0"
>     ATTR{uid}=="1"
> 
>   looking at parent device
> '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c':
>     KERNELS=="device:6c"
>     SUBSYSTEMS=="acpi"
>     DRIVERS==""
>     ATTRS{adr}=="0x00150000"
>     ATTRS{path}=="\_SB_.PC00.I2C0"
>     ATTRS{power/async}=="disabled"
>     ATTRS{power/control}=="auto"
>     ATTRS{power/runtime_active_kids}=="0"
>     ATTRS{power/runtime_active_time}=="0"
>     ATTRS{power/runtime_enabled}=="disabled"
>     ATTRS{power/runtime_status}=="unsupported"
>     ATTRS{power/runtime_suspended_time}=="0"
>     ATTRS{power/runtime_usage}=="0"
>     ATTRS{power_state}=="D3hot"
> 
>   looking at parent device '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00':
>     KERNELS=="PNP0A08:00"
>     SUBSYSTEMS=="acpi"
>     DRIVERS==""
>     ATTRS{adr}=="0x00000000"
>     ATTRS{hid}=="PNP0A08"
>     ATTRS{path}=="\_SB_.PC00"
>     ATTRS{power/async}=="disabled"
>     ATTRS{power/control}=="auto"
>     ATTRS{power/runtime_active_kids}=="0"
>     ATTRS{power/runtime_active_time}=="0"
>     ATTRS{power/runtime_enabled}=="disabled"
>     ATTRS{power/runtime_status}=="unsupported"
>     ATTRS{power/runtime_suspended_time}=="0"
>     ATTRS{power/runtime_usage}=="0"
>     ATTRS{uid}=="0"
> 
>   looking at parent device '/devices/LNXSYSTM:00/LNXSYBUS:00':
>     KERNELS=="LNXSYBUS:00"
>     SUBSYSTEMS=="acpi"
>     DRIVERS==""
>     ATTRS{hid}=="LNXSYBUS"
>     ATTRS{path}=="\_SB_"
>     ATTRS{power/async}=="disabled"
>     ATTRS{power/control}=="auto"
>     ATTRS{power/runtime_active_kids}=="0"
>     ATTRS{power/runtime_active_time}=="0"
>     ATTRS{power/runtime_enabled}=="disabled"
>     ATTRS{power/runtime_status}=="unsupported"
>     ATTRS{power/runtime_suspended_time}=="0"
>     ATTRS{power/runtime_usage}=="0"
> 
>   looking at parent device '/devices/LNXSYSTM:00':
>     KERNELS=="LNXSYSTM:00"
>     SUBSYSTEMS=="acpi"
>     DRIVERS==""
>     ATTRS{hid}=="LNXSYSTM"
>     ATTRS{path}=="\"
>     ATTRS{power/async}=="disabled"
>     ATTRS{power/control}=="auto"
>     ATTRS{power/runtime_active_kids}=="0"
>     ATTRS{power/runtime_active_time}=="0"
>     ATTRS{power/runtime_enabled}=="disabled"
>     ATTRS{power/runtime_status}=="unsupported"
>     ATTRS{power/runtime_suspended_time}=="0"
>     ATTRS{power/runtime_usage}=="0"
> 
> 
> $ cat /sys/class/dmi/id/modalias
> dmi:bvnAmericanMegatrendsInternational,LLC.:bvrDNN20V2.13:bd09/05/2023:br2.13:efr0.15:svnCHUWIInnovationAndTechnology(ShenZhen)co.,Ltd:pnMiniBookX:pvrDefaultstring:rvnDefaultstring:rnDefaultstring:rvrDefaultstring:cvnDefaultstring:ct10:cvrDefaultstring:skuDefaultstring:
> 


