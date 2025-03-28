Return-Path: <linux-iio+bounces-17322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE0A7526E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 23:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714693B1148
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BC1DF986;
	Fri, 28 Mar 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="3x0xrZb6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4419CC02
	for <linux-iio@vger.kernel.org>; Fri, 28 Mar 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743200393; cv=none; b=HHCDP0BX4AuiVCBXzSUdiwprCJsO3WlErJ4H7PLJ3NQHQv60mQJKeL0eAFLzdFpeisO7lI/EjKQrnFCYVHUHb//rmfz0SgSONlrTxL1YiNjSpo7wl8GEpU8uQN77MMMivQrCU+LELa6mCiMEfskQ2Of1SdJcHU8Bqlfi7qeTh6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743200393; c=relaxed/simple;
	bh=+8hCy1ilFECAjWK3ftko/iDo0lbbE/8poVNrY/JUJuo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=e7jIM114TiJUiU/i6udPMAyRcpz1AvtqpvU+4DtcvfE8bMb0xQcTS6iGuCLOITmHPyRy5AuxrFIByjaNFVcdxmPIkV7uQH4Du1CuAbGqToUv6r9PuHIDXP9GlyB+6erwTZgIoH+1XxED9X0g5aPtGMQXFNqDn5Niqw2CDwPcLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3x0xrZb6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=dBhx5zaFd5jx2LegvgPPBQusrjjjevQzGefgpUcEZss=; b=3x0xrZb6mFE6cWk/EJrfxCMnR/
	2AwpwaVhbey6ykwd6ewDu9fsWdrs91yuXbyDt0tfeWZW0U+75B73RwTHzRADb9o9b06t6FBnxD+VT
	ib1pG8Xq6doltmA/0/z7B7hzwXiu9fBFQvec20u3CVZ8fwLX3R/puIaRdjtrXiPYCPo6vZF46Iy5+
	S4KS0iPZnLpCTFwv6KkbnRzJkorPZkPcn/z4ACTzsfiXSMQ9C+5beIM5//S/j50UAIaPTEtNl4Bxm
	Qot1Alptnw4IbrN45zDBaLTXTqXXMDh2G5yCemg6as173sVlzZ9E3B/4MnCxIDjrYhnHB3Y29fLad
	DtlvCKJQ==;
Date: Fri, 28 Mar 2025 22:56:31 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: jean-baptiste.maneyrol@tdk.com, linux-iio@vger.kernel.org,
 hns@goldelico.com, tony@atomide.com
Subject: [BUG] mpu9150 magnetometer not working without powering
 accelerometer
Message-ID: <20250328225631.74b82927@akair>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

on the Epson Moverio BT-200 containing two MPU 9150 I see a strange
behavior where I see only nearly fixed values until I enable the
accelerometer or gyroscope shortly. I am a bit puzzled what is really
going on here. It is the inv-mpu6050 driver.

Some tries:
root@bt200deb:~# cat /sys/bus/iio/devices/iio\:device1/in_magn_?_raw
27
27
27
root@bt200deb:~# cat /sys/bus/iio/devices/iio\:device1/in_magn_?_raw
26
26
26

x/y/z keep nearly the same and almost equal.

root@bt200deb:~# cat /sys/bus/iio/devices/iio\:device1/in_accel_?_raw
5950
-1782
14156

just one read from the accelerometer and things change for the
magnetometer.

root@bt200deb:~# cat /sys/bus/iio/devices/iio\:device1/in_magn_?_raw
54
54
-2
root@bt200deb:~# cat /sys/bus/iio/devices/iio\:device1/in_magn_?_raw
61
57
1

a full power cycle later and operating at register level:

root@bt200deb:~# cat /sys/bus/iio/devices/iio\:device1/in_magn_?_raw
26
28
28
root@bt200deb:~#

force powering on the chip
root@bt200deb:~# echo on >/sys/bus/i2c/devices/1-0068/power/control 
root@bt200deb:~# cat /sys/bus/iio/devices/iio\:device1/in_magn_?_raw
26
28
31
root@bt200deb:~# i2cget -f -y 1 0x68 0x6C    
0x3f
-> PWR_MGMT_2 -> everything in standby

enable accelerometer axes:
root@bt200deb:~# i2cset -f -y 1 0x68 0x6C 0x7

putting accelerometer axes into standby:
root@bt200deb:~# i2cset -f -y 1 0x68 0x6C 0x3f

enable runtime powermangement
root@bt200deb:~# echo auto >/sys/bus/i2c/devices/1-0068/power/control 
root@bt200deb:~# cat /sys/bus/iio/devices/iio\:device1/in_magn_?_raw
57
59
-1

magnetometer working.

Does anyone have some hints what is going on here and what could be the
real fix? Same behavior for the other mpu in the device
head->scratch(); ...

Of course the accelerometer could be enabled in probe() but that feels
more like a hackfix. 

Regards,
Andreas

