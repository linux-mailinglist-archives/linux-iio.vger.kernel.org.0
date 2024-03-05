Return-Path: <linux-iio+bounces-3350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63CD8725B1
	for <lists+linux-iio@lfdr.de>; Tue,  5 Mar 2024 18:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217AFB2879E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Mar 2024 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BE5168DC;
	Tue,  5 Mar 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qf1C+UWQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF54168DE
	for <linux-iio@vger.kernel.org>; Tue,  5 Mar 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659860; cv=none; b=Fsr+gDzMcMUnaCcgZUCOYLAlowxi/xDzT6yLDPNChsEmWSQscR8vO25818lUNyRzOT6RLk7D+8hN7RXFmR0hDkzGK8pt/acDNvYm2yxbNQh6hBICf1YZo5kRh8Gic5VoEXgwQvc+Wc/48Bgp8y7e1N5+AQg3rOffgPwVWraSrXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659860; c=relaxed/simple;
	bh=UaOmO8SpYU9i/76t/HvdY3WLm++tEdRouo866ZjPa6s=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=rHQD2i9ecYBFNLaNtA8DUruuLI+UnMTyWP943lcRZM3VFEYAF8NgZz8FPKVxFAv6qVLLc/fBRu5m2K9miV/oYfT/rgRfIxOzWoRuXlNKOy3r6y8+QSAw9DVD3URzuoIiC9kJwOmu3sLLoJKzKZRMFVvVKzqEUZxIzg4uTVnhEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qf1C+UWQ; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a6dd3a2f-c3e9-4781-801b-8e8e72ac9beb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709659856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l5PyDBmcaGExQ3fLdD1dlRH6dRmDjoSn9owqotsyAB4=;
	b=qf1C+UWQTf57gBwVuBcVNfQOwnZGvPG0iyUfphNAbOZd89aF+8OTu04PDX37mpw02ZREbC
	k3lo9oqt/WCMqIXty5Cicl1Z7oQ6RaLseSbhpE9zFL79vPEklEnMvtNnQc4yDRV0Nat8ix
	70hjx0djDclyHznfd9t38s6Gygl2Adw=
Date: Tue, 5 Mar 2024 12:30:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Manish Narani <manish.narani@xilinx.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, linux-iio@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: iio: xilinx-ams: shift-out-of-bounds in ams_enable_channel_sequence
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

When enabling UBSAN on a ZynqMP Ultrascale+, I see the following error during boot:

[    1.447628] ================================================================================
[    1.447832] UBSAN: shift-out-of-bounds in ../drivers/iio/adc/xilinx-ams.c:426:16
[    1.448019] shift exponent 66 is too large for 64-bit type 'long long unsigned int'
[    1.448211] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.6.20+ #90
[    1.448368] Hardware name: xlnx,zynqmp (DT)
[    1.448475] Call trace:
[    1.448547]  dump_backtrace+0x9c/0x11c
[    1.448655]  show_stack+0x18/0x24
[    1.448749]  dump_stack_lvl+0xac/0xd4
[    1.448853]  dump_stack+0x18/0x24
[    1.448947]  ubsan_epilogue+0x10/0x44
[    1.449051]  __ubsan_handle_shift_out_of_bounds+0x98/0x134
[    1.449191]  ams_enable_channel_sequence+0x22c/0x23c
[    1.449324]  ams_probe+0x570/0x6d4
[    1.449423]  platform_probe+0x68/0x108
[    1.449530]  really_probe+0x158/0x3b0
[    1.449632]  __driver_probe_device+0x88/0x1a0
[    1.449747]  driver_probe_device+0x3c/0x138
[    1.449859]  __driver_attach+0xe4/0x1bc
[    1.449964]  bus_for_each_dev+0x78/0xe0
[    1.450068]  driver_attach+0x24/0x30
[    1.450167]  bus_add_driver+0x110/0x240
[    1.450271]  driver_register+0x60/0x128
[    1.450376]  __platform_driver_register+0x28/0x34
[    1.450500]  ams_driver_init+0x1c/0x28
[    1.450609]  do_one_initcall+0x78/0x2c8
[    1.450714]  kernel_init_freeable+0x2f8/0x59c
[    1.450831]  kernel_init+0x30/0x150
[    1.450932]  ret_from_fork+0x10/0x20
[    1.451073] ================================================================================

When applying the following patch:

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index f0b71a1220e0..1ced8cff461a 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -414,8 +414,17 @@ static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
 
        /* Run calibration of PS & PL as part of the sequence */
        scan_mask = BIT(0) | BIT(AMS_PS_SEQ_MAX);
-       for (i = 0; i < indio_dev->num_channels; i++)
+       for (i = 0; i < indio_dev->num_channels; i++) {
+               if (indio_dev->channels[i].scan_index >= 64) {
+                       const struct iio_chan_spec *chan = &indio_dev->channels[i];
+
+                       dev_warn(&indio_dev->dev,
+                                "channel %d (%d %d.%d @ %lx) has scan_index %d\n",
+                                i, chan->type, chan->channel, chan->channel2,
+                                chan->address, chan->scan_index);
+               }
                scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
+       }
 
        if (ams->ps_base) {
                /* put sysmon in a soft reset to change the sequence */

I see these additional outputs:

[    1.447457] iio iio:device0: channel 0 (0 0.0 @ 60) has scan_index 66
[    1.451280] iio iio:device0: channel 1 (0 1.0 @ 6c) has scan_index 67
[    1.451446] iio iio:device0: channel 2 (0 2.0 @ 78) has scan_index 68
[    1.451612] iio iio:device0: channel 3 (0 3.0 @ 7c) has scan_index 69
[    1.451777] iio iio:device0: channel 4 (0 4.0 @ 80) has scan_index 70
[    1.451942] iio iio:device0: channel 5 (0 5.0 @ 84) has scan_index 71
[    1.452107] iio iio:device0: channel 6 (0 6.0 @ 9c) has scan_index 72

Indicating that the issue is with the ams_ctrl_channels using the
AMS_CTRL_CHAN_VOLTAGE macro.

--Sean

