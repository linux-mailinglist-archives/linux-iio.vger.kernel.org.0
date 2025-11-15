Return-Path: <linux-iio+bounces-26245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D1C609E7
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAB05356E94
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90878284888;
	Sat, 15 Nov 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXRV3LGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76C61FFE
	for <linux-iio@vger.kernel.org>; Sat, 15 Nov 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763231132; cv=none; b=LeIpK2RXMG+xXXwVZ6f8wp8/9gax5WHhcQJOkdzOEkkhn19q7VP6zMb6ayRZYFUhL+I7QprqwyGwDQLGJXCfcilCKOmvhssd0dea2OFldy6AFrTPtb6r0kp+UQjH+7klGrfIxE66J6DpCNR2WDjjrJQXQ5uazqFHsNUqt3hMoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763231132; c=relaxed/simple;
	bh=SjzdQHKHGdPtIDV/7Scg+nBflGZQCDWzUgkKJ3s/Y/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orOBeV+kPsazl6+VD/uLKG/QSexE9SVhEqDR7+mmtPA8BbdNk0wcphn4O8Ct6NzRp/QuI2F7TVyYOoG2zZIiJtpG9SqnjJvp7lPb/teZnDl7JMtfrvfl6+X0Im+HuVZ9iqIBZExbyZSFYjOmlWqMHuqknGNBXl0z1ppGeeV84tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXRV3LGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C224C116D0;
	Sat, 15 Nov 2025 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763231131;
	bh=SjzdQHKHGdPtIDV/7Scg+nBflGZQCDWzUgkKJ3s/Y/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lXRV3LGtOQyfuyHRZ4Sf9DXWwO2LMya5S5wljbkkhW9IDBnBb8PkNTiLwf0a1IfzQ
	 TwYT4poIHHMIWLrsYtvIAD98L2EQ/lzctNaVggoKhksHCFus2Vxq6L4RFgsG5lKnFR
	 7S6JnCaoUBgYC7G0EEH9z02fj9Vy+mg89XZUFZODUb2XUzNSbIXiyjqerzOQ77lVEn
	 tGMJ4Ih5jPZCv7UNsub5lIBr3kvos7xf7wJFyapKq1N/rrve8dOCqQh2GZr2TnZ0a8
	 SspJEpZZRgQQhH8qzjEEd5TiXf8YZapzEgJNm/4lsBxJSbkQkA4ZQwXSKB3/vbRlJ+
	 ctGJyg7knu++w==
Date: Sat, 15 Nov 2025 18:25:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Message-ID: <20251115182525.354dc52a@jic23-huawei>
In-Reply-To: <bug-220772-217253-hKYWpHfSlh@https.bugzilla.kernel.org/>
References: <bug-220772-217253@https.bugzilla.kernel.org/>
	<bug-220772-217253-hKYWpHfSlh@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 01:46:52 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=220772
> 
> --- Comment #3 from Vitaliy Tomin (highwaystar.ru@gmail.com) ---
> (In reply to Jonathan Cameron from comment #2)
> > On Sun, 09 Nov 2025 19:59:38 +0000
> > bugzilla-daemon@kernel.org wrote:  
> 
> > Could you share the names of the triggers under
> > /sys/bus/iio/devices/trigger*/name
> > and
> > cat /proc/interrupts
> > 
> > Maybe the tooling is using an hrtimer or sysfs trigger but the
> > driver seems to have a validate_trigger callback that should prevent that
> > so I think we need a little more information.
> > 
> > Thanks
> > 
> > Jonathan  
> 
> 
> There is no such files here:

Thanks. So to hit the buffer functions is must be in fifo mode
(which runs without a trigger).

Seems the conversation around the original fix should have gone
on a bit longer as it was correct as we do want to enable buffered
support if no interrupts, just not let it run unless a trigger is coming
from elsewhere.

Uwe had the right idea, I just didn't understand it at the time of
that original thread.   I've replied to that thread so hopefully we
can finally get this cleared up.

If you could test what Uwe posted in this message that would be great.

https://lore.kernel.org/all/6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc/

Thanks for the hard work getting me all the info.

Jonathan



> tomin@fedora:~$ ls /sys/bus/iio/devices/trigger*/name
> ls: cannot access '/sys/bus/iio/devices/trigger*/name': No such file or
> directory
> tomin@fedora:~$ ls /sys/bus/iio/devices/iio\:device*/
> '/sys/bus/iio/devices/iio:device0/':
> buffer                   events                       in_accel_x_raw  
> in_temp_offset  name                          subsystem
> buffer0                  firmware_node                in_accel_y_raw  
> in_temp_raw     power                         trigger
> current_timestamp_clock  in_accel_sampling_frequency  in_accel_z_raw  
> in_temp_scale   sampling_frequency_available  uevent
> dev                      in_accel_scale               in_mount_matrix  label   
>        scan_elements                 waiting_for_supplier
> 
> '/sys/bus/iio/devices/iio:device1/':
> buffer                   events                       in_accel_x_raw  
> in_temp_offset  name                          subsystem
> buffer0                  firmware_node                in_accel_y_raw  
> in_temp_raw     power                         trigger
> current_timestamp_clock  in_accel_sampling_frequency  in_accel_z_raw  
> in_temp_scale   sampling_frequency_available  uevent
> dev                      in_accel_scale               in_mount_matrix  label   
>        scan_elements                 waiting_for_supplier
> tomin@fedora:~$ ls /sys/bus/iio/devices/iio\:device*/trigger
> '/sys/bus/iio/devices/iio:device0/trigger':
> current_trigger
> 
> '/sys/bus/iio/devices/iio:device1/trigger':
> current_trigger
> 
> 
> 
> tomin@fedora:~$ cat /proc/interrupts
>             CPU0       CPU1       CPU2       CPU3       
>    1:          0          0         72          0 IR-IO-APIC    1-edge     
> i8042
>    8:          0          0          0          0 IR-IO-APIC    8-edge     
> rtc0
>    9:      10041          0          0          0 IR-IO-APIC    9-fasteoi  
> acpi
>   12:          0          6          0          0 IR-IO-APIC   12-edge     
> i8042
>   14:          8          0          0          0 IR-IO-APIC   14-fasteoi  
> INTC1057:00
>   16:         56          0          0          0 IR-IO-APIC   16-fasteoi  
> mmc0, i801_smbus
>   27:          0          0       5167          0 IR-IO-APIC   27-fasteoi  
> i2c_designware.1, idma64.1
>   29:        236          0          0          0 IR-IO-APIC   29-fasteoi  
> i2c_designware.3, idma64.3
>   31:          0          0          0          0 IR-IO-APIC   31-fasteoi  
> i2c_designware.5, idma64.5
>   32:          0          0          0          0 IR-IO-APIC   32-fasteoi  
> i2c_designware.6, idma64.6
>   33:          0       4921          0          0 IR-IO-APIC   33-fasteoi  
> i2c_designware.4, idma64.4
>   39:          0          0          0          0 IR-IO-APIC   39-fasteoi  
> pxa2xx-spi.0, idma64.0
>   40:          0          0          0          0 IR-IO-APIC   40-fasteoi  
> i2c_designware.2, idma64.2
>  120:          0          1          0          0 IR-PCI-MSI-0000:00:1d.0   
> 0-edge      aerdrv, PCIe bwctrl
>  121:       9054          0          0          0 IR-PCI-MSI-0000:00:14.0   
> 0-edge      xhci_hcd
>  126:         10          4          0         30 IR-PCI-MSIX-0000:01:00.0   
> 0-edge      nvme0q0
>  127:       7450          0          0          0 IR-PCI-MSIX-0000:01:00.0   
> 1-edge      nvme0q1
>  128:          0       5690          0          0 IR-PCI-MSIX-0000:01:00.0   
> 2-edge      nvme0q2
>  129:          0          0       5152          0 IR-PCI-MSIX-0000:01:00.0   
> 3-edge      nvme0q3
>  130:          0          0          0       6240 IR-PCI-MSIX-0000:01:00.0   
> 4-edge      nvme0q4
>  131:          0      10732      10690       1008 IR-PCI-MSI-0000:00:02.0   
> 0-edge      i915
>  132:          8          0          0          0 intel-gpio  306  GDIX1001:00
>  133:          0         49          0          0 IR-PCI-MSI-0000:00:16.0   
> 0-edge      mei_me
>  134:        883       1015        400        779 IR-PCI-MSIX-0000:00:14.3   
> 0-edge      iwlwifi:default_queue
>  135:         46         59         35          4 IR-PCI-MSIX-0000:00:14.3   
> 1-edge      iwlwifi:queue_1
>  136:          5         68          1         17 IR-PCI-MSIX-0000:00:14.3   
> 2-edge      iwlwifi:queue_2
>  137:         20         30         25         35 IR-PCI-MSIX-0000:00:14.3   
> 3-edge      iwlwifi:queue_3
>  138:         21        123        114        269 IR-PCI-MSIX-0000:00:14.3   
> 4-edge      iwlwifi:queue_4
>  139:          0          0          0          5 IR-PCI-MSIX-0000:00:14.3   
> 5-edge      iwlwifi:exception
>  140:       1213          0          0          0 IR-PCI-MSI-0000:00:1f.3   
> 0-edge      snd_hda_intel:card1
>  NMI:          8          8          9          8   Non-maskable interrupts
>  LOC:      87542      86732      94323      81275   Local timer interrupts
>  SPU:          0          0          0          0   Spurious interrupts
>  PMI:          8          8          9          8   Performance monitoring
> interrupts
>  IWI:       2334      10486       9187       2892   IRQ work interrupts
>  RTR:          0          0          0          0   APIC ICR read retries
>  RES:       1781       1199       1600       3146   Rescheduling interrupts
>  CAL:      23231      22621      16364      21816   Function call interrupts
>  TLB:       1208       1127       1072       1304   TLB shootdowns
>  TRM:        680        680        680        680   Thermal event interrupts
>  THR:          0          0          0          0   Threshold APIC interrupts
>  DFR:          0          0          0          0   Deferred Error APIC
> interrupts
>  MCE:          0          0          0          0   Machine check exceptions
>  MCP:          3          4          4          4   Machine check polls
>  ERR:          0
>  MIS:          0
>  PIN:          0          0          0          0   Posted-interrupt
> notification event
>  NPI:          0          0          0          0   Nested posted-interrupt
> event
>  PIW:          0          0          0          0   Posted-interrupt wakeup
> event
>  PMN:          0          0          0          0   Posted MSI notification
> event
> 


