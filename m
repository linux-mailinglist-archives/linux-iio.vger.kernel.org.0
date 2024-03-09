Return-Path: <linux-iio+bounces-3424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81962877370
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 20:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B8B1C20BED
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D34AEFB;
	Sat,  9 Mar 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSgcYCY3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0324A2A
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710011221; cv=none; b=mSi7nBKK31/swDCxbVXwvMaQTbtlPepoftG+Ci++8753YOxXohnjaC9weZ8XcGpRrVO8oxezRI7F1+YNkZpViX3tvUtOaafxIdFehW3efQw5SqFaUKfeWG/r4WzTwO5Aja5S67ENXVwoQ6D5TdVWJ9FXuD7/SxJfv//vIb418/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710011221; c=relaxed/simple;
	bh=l+E5knTm106NChr1G+H7nQsZfmww+heyhg9acaF1kfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmLGoSwck1TL4fM9xY7OXuDAK+rcU96OdoylCQS1+TtG/UFAocam9M5wUYL3zXmkcJ6wuXWbzf73mGgJo3ksn3h6AoYX4S7G0L4omhaX+xXx4/PV6FjKc1Dbyi2pbmxZkUZhQuqgR9r+d6PsCvC+xHoTLxW7IdMxCcZZ3mddppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSgcYCY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849E4C433F1;
	Sat,  9 Mar 2024 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710011220;
	bh=l+E5knTm106NChr1G+H7nQsZfmww+heyhg9acaF1kfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RSgcYCY34PspTvuxX9KdKgFbJ+vI3O3hmhvmLvd9ShKlgBXn4MMBhg0eA4e1d28Du
	 UCI8aJfjfvWuQa3Up1lG10H/HnWcgkZAnPWvyQpP0gFRiBYyFaOrV6jTiMcmuFBn23
	 o43ABCkDQN+2SSkfb5oGHRb/Il0UeEz8uIZypIv5YQMbNoUMby+HNVv/P0ieiAoImm
	 2vejfXfL0nWjEQer0dH/cLVs8wAo+Af604YMM4WI9S5U7themxy4md3/MNwKiXbTnJ
	 gPciJygbDjlU5Y/S/ev0AzlFchwnMPuNa8l4a4SOEtODXOs6NIE0rvaCJeK1igtszx
	 1ffXfjnBj4Fng==
Date: Sat, 9 Mar 2024 19:06:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Manish Narani <manish.narani@xilinx.com>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, linux-iio@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: iio: xilinx-ams: shift-out-of-bounds in
 ams_enable_channel_sequence
Message-ID: <20240309190649.04be7261@jic23-huawei>
In-Reply-To: <a6dd3a2f-c3e9-4781-801b-8e8e72ac9beb@linux.dev>
References: <a6dd3a2f-c3e9-4781-801b-8e8e72ac9beb@linux.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 12:30:53 -0500
Sean Anderson <sean.anderson@linux.dev> wrote:

> Hi,
> 
> When enabling UBSAN on a ZynqMP Ultrascale+, I see the following error during boot:
> 
> [    1.447628] ================================================================================
> [    1.447832] UBSAN: shift-out-of-bounds in ../drivers/iio/adc/xilinx-ams.c:426:16
> [    1.448019] shift exponent 66 is too large for 64-bit type 'long long unsigned int'
> [    1.448211] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.6.20+ #90
> [    1.448368] Hardware name: xlnx,zynqmp (DT)
> [    1.448475] Call trace:
> [    1.448547]  dump_backtrace+0x9c/0x11c
> [    1.448655]  show_stack+0x18/0x24
> [    1.448749]  dump_stack_lvl+0xac/0xd4
> [    1.448853]  dump_stack+0x18/0x24
> [    1.448947]  ubsan_epilogue+0x10/0x44
> [    1.449051]  __ubsan_handle_shift_out_of_bounds+0x98/0x134
> [    1.449191]  ams_enable_channel_sequence+0x22c/0x23c
> [    1.449324]  ams_probe+0x570/0x6d4
> [    1.449423]  platform_probe+0x68/0x108
> [    1.449530]  really_probe+0x158/0x3b0
> [    1.449632]  __driver_probe_device+0x88/0x1a0
> [    1.449747]  driver_probe_device+0x3c/0x138
> [    1.449859]  __driver_attach+0xe4/0x1bc
> [    1.449964]  bus_for_each_dev+0x78/0xe0
> [    1.450068]  driver_attach+0x24/0x30
> [    1.450167]  bus_add_driver+0x110/0x240
> [    1.450271]  driver_register+0x60/0x128
> [    1.450376]  __platform_driver_register+0x28/0x34
> [    1.450500]  ams_driver_init+0x1c/0x28
> [    1.450609]  do_one_initcall+0x78/0x2c8
> [    1.450714]  kernel_init_freeable+0x2f8/0x59c
> [    1.450831]  kernel_init+0x30/0x150
> [    1.450932]  ret_from_fork+0x10/0x20
> [    1.451073] ================================================================================
> 
> When applying the following patch:
> 
That channel definition looks suspicious. Anyone shed light on what the channel scan index layout
is supposed to be?
There seem to be substantial gaps in used numbers.
If I read it right the offset to jump over the AUX_CHAN is too large (22 - should be 16) but
that still ends up with us going above the range of supported scan indexes.

The PL Sequence mask used is GENMASK_ULL(59, 22)

Whilst the bits are set, nothing actually reads them that I can see.
So why are they set and how are those channels supposed to work?

So agreed buggy; no idea what it supposed to do!

Jonathan


> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index f0b71a1220e0..1ced8cff461a 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -414,8 +414,17 @@ static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
>  
>         /* Run calibration of PS & PL as part of the sequence */
>         scan_mask = BIT(0) | BIT(AMS_PS_SEQ_MAX);
> -       for (i = 0; i < indio_dev->num_channels; i++)
> +       for (i = 0; i < indio_dev->num_channels; i++) {
> +               if (indio_dev->channels[i].scan_index >= 64) {
> +                       const struct iio_chan_spec *chan = &indio_dev->channels[i];
> +
> +                       dev_warn(&indio_dev->dev,
> +                                "channel %d (%d %d.%d @ %lx) has scan_index %d\n",
> +                                i, chan->type, chan->channel, chan->channel2,
> +                                chan->address, chan->scan_index);
> +               }
>                 scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
> +       }
>  
>         if (ams->ps_base) {
>                 /* put sysmon in a soft reset to change the sequence */
> 
> I see these additional outputs:
> 
> [    1.447457] iio iio:device0: channel 0 (0 0.0 @ 60) has scan_index 66
> [    1.451280] iio iio:device0: channel 1 (0 1.0 @ 6c) has scan_index 67
> [    1.451446] iio iio:device0: channel 2 (0 2.0 @ 78) has scan_index 68
> [    1.451612] iio iio:device0: channel 3 (0 3.0 @ 7c) has scan_index 69
> [    1.451777] iio iio:device0: channel 4 (0 4.0 @ 80) has scan_index 70
> [    1.451942] iio iio:device0: channel 5 (0 5.0 @ 84) has scan_index 71
> [    1.452107] iio iio:device0: channel 6 (0 6.0 @ 9c) has scan_index 72
> 
> Indicating that the issue is with the ams_ctrl_channels using the
> AMS_CTRL_CHAN_VOLTAGE macro.
> 
> --Sean
> 


