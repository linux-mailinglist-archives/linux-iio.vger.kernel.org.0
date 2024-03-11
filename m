Return-Path: <linux-iio+bounces-3460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B858784AD
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 17:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2BD1C2136D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 16:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30FD4AEC5;
	Mon, 11 Mar 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pnTp9zKF"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569C4503F
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173476; cv=none; b=iJyNnuj7CToyRaWblOw8JrY6wxm6tN8dorP2svFPxdBSncevzGyCUR/S+YiZQg/0rhPA2+jxslIg/m0RQwITmyOga5GK4nD7CYoo1962jQq+eeboWDiWwxi2FqeTUzFtA1Znjxwc3YGWAvODw3XTPbbJ+EWFpfgSDgHeSAIjnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173476; c=relaxed/simple;
	bh=gso66/ofdYwULnuaPHyqxP/aUYtVeWn756F/WHyy11I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToECJ8Tmuzl3gEUIVpbAxSZM02I4iMy6xO70PymYZyJnXA/KeGxBW47AHjJx0B1bgAQYXB/P3yAAcuOVxNlG99mI1lFXNkbpQcMNWOqVOP53lGeBiEnrm9Z8kjZJVct4aewcu7ymIJhBmX1RWhyIQiNahJ+8CyEnY6Hvg/lP5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnTp9zKF; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0eb0b1b0-179b-424d-b0e8-94343e0344d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710173471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHjqRiTIb2AdvHgyz8LZNL3DBS7ibVhQk6e8xFjTu10=;
	b=pnTp9zKFE0BS+IyN/hT7jfPFkE8zIcx7pYWRQMU+ZnDvi4QFAyg/RvuqWaP8l/62kzmROU
	w5qtXnTUjut5BGiNkbcMFo/nl6+y1+tWzKwuBry2K84Rhm76U6FBCdSErr571mtEpxULgb
	mMbhNiedkVmOxt5+6gxXAmUjitmq+rI=
Date: Mon, 11 Mar 2024 12:11:07 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: iio: xilinx-ams: shift-out-of-bounds in
 ams_enable_channel_sequence
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>,
 "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <a6dd3a2f-c3e9-4781-801b-8e8e72ac9beb@linux.dev>
 <20240309190649.04be7261@jic23-huawei>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240309190649.04be7261@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

+CC Conall

On 3/9/24 14:06, Jonathan Cameron wrote:
> On Tue, 5 Mar 2024 12:30:53 -0500
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> Hi,
>> 
>> When enabling UBSAN on a ZynqMP Ultrascale+, I see the following error during boot:
>> 
>> [    1.447628] ================================================================================
>> [    1.447832] UBSAN: shift-out-of-bounds in ../drivers/iio/adc/xilinx-ams.c:426:16
>> [    1.448019] shift exponent 66 is too large for 64-bit type 'long long unsigned int'
>> [    1.448211] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.6.20+ #90
>> [    1.448368] Hardware name: xlnx,zynqmp (DT)
>> [    1.448475] Call trace:
>> [    1.448547]  dump_backtrace+0x9c/0x11c
>> [    1.448655]  show_stack+0x18/0x24
>> [    1.448749]  dump_stack_lvl+0xac/0xd4
>> [    1.448853]  dump_stack+0x18/0x24
>> [    1.448947]  ubsan_epilogue+0x10/0x44
>> [    1.449051]  __ubsan_handle_shift_out_of_bounds+0x98/0x134
>> [    1.449191]  ams_enable_channel_sequence+0x22c/0x23c
>> [    1.449324]  ams_probe+0x570/0x6d4
>> [    1.449423]  platform_probe+0x68/0x108
>> [    1.449530]  really_probe+0x158/0x3b0
>> [    1.449632]  __driver_probe_device+0x88/0x1a0
>> [    1.449747]  driver_probe_device+0x3c/0x138
>> [    1.449859]  __driver_attach+0xe4/0x1bc
>> [    1.449964]  bus_for_each_dev+0x78/0xe0
>> [    1.450068]  driver_attach+0x24/0x30
>> [    1.450167]  bus_add_driver+0x110/0x240
>> [    1.450271]  driver_register+0x60/0x128
>> [    1.450376]  __platform_driver_register+0x28/0x34
>> [    1.450500]  ams_driver_init+0x1c/0x28
>> [    1.450609]  do_one_initcall+0x78/0x2c8
>> [    1.450714]  kernel_init_freeable+0x2f8/0x59c
>> [    1.450831]  kernel_init+0x30/0x150
>> [    1.450932]  ret_from_fork+0x10/0x20
>> [    1.451073] ================================================================================
>> 
>> When applying the following patch:
>> 
> That channel definition looks suspicious. Anyone shed light on what the channel scan index layout
> is supposed to be?
> There seem to be substantial gaps in used numbers.
> If I read it right the offset to jump over the AUX_CHAN is too large (22 - should be 16) but
> that still ends up with us going above the range of supported scan indexes.
> 
> The PL Sequence mask used is GENMASK_ULL(59, 22)
> 
> Whilst the bits are set, nothing actually reads them that I can see.
> So why are they set and how are those channels supposed to work?
> 
> So agreed buggy; no idea what it supposed to do!

OK, so there are three groups of channels in this device, as set up by
ams_init_module:

	- CTRL channels (xlnx,zynqmp-ams)
	- PS channels (xlnx,zynqmp-ams-ps)
	- PL channels (xlnx,zynqmp-ams-pl)

According to the comment in ams_enable_channel_sequence,

	/*
	 * Enable channel sequence. First 22 bits of scan_mask represent
	 * PS channels, and next remaining bits represent PL channels.
	 */

and indeed, the following code only touches the PS and PL registers. So
I think we just need to add a check for
chan->scan_index >= AMS_CTRL_SEQ_BASE, like in ams_read_raw.

--Sean

>> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
>> index f0b71a1220e0..1ced8cff461a 100644
>> --- a/drivers/iio/adc/xilinx-ams.c
>> +++ b/drivers/iio/adc/xilinx-ams.c
>> @@ -414,8 +414,17 @@ static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
>>  
>>         /* Run calibration of PS & PL as part of the sequence */
>>         scan_mask = BIT(0) | BIT(AMS_PS_SEQ_MAX);
>> -       for (i = 0; i < indio_dev->num_channels; i++)
>> +       for (i = 0; i < indio_dev->num_channels; i++) {
>> +               if (indio_dev->channels[i].scan_index >= 64) {
>> +                       const struct iio_chan_spec *chan = &indio_dev->channels[i];
>> +
>> +                       dev_warn(&indio_dev->dev,
>> +                                "channel %d (%d %d.%d @ %lx) has scan_index %d\n",
>> +                                i, chan->type, chan->channel, chan->channel2,
>> +                                chan->address, chan->scan_index);
>> +               }
>>                 scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
>> +       }
>>  
>>         if (ams->ps_base) {
>>                 /* put sysmon in a soft reset to change the sequence */
>> 
>> I see these additional outputs:
>> 
>> [    1.447457] iio iio:device0: channel 0 (0 0.0 @ 60) has scan_index 66
>> [    1.451280] iio iio:device0: channel 1 (0 1.0 @ 6c) has scan_index 67
>> [    1.451446] iio iio:device0: channel 2 (0 2.0 @ 78) has scan_index 68
>> [    1.451612] iio iio:device0: channel 3 (0 3.0 @ 7c) has scan_index 69
>> [    1.451777] iio iio:device0: channel 4 (0 4.0 @ 80) has scan_index 70
>> [    1.451942] iio iio:device0: channel 5 (0 5.0 @ 84) has scan_index 71
>> [    1.452107] iio iio:device0: channel 6 (0 6.0 @ 9c) has scan_index 72
>> 
>> Indicating that the issue is with the ams_ctrl_channels using the
>> AMS_CTRL_CHAN_VOLTAGE macro.
>> 
>> --Sean
>> 
> 

