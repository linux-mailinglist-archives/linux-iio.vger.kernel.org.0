Return-Path: <linux-iio+bounces-3462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC08C878581
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7AB1C22517
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A851C4C;
	Mon, 11 Mar 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bah56hbL"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6E537E3
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174655; cv=none; b=cA8qSntZiYdB5ESQrQPFlnDzYN4xVJBQty45X8Z/A+g8i04eAFlzNCHGyHsaYqGFu9yJcBoCcMtnbPO+1DwiRxM1n+k7GqGS5pykz2FvzxChnVwIFaIoxfP6cVT9GLuWG7fKaX9S1Ml4+8mtHEDemCVuYEvywq2Mx422UbFyzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174655; c=relaxed/simple;
	bh=KwxzH5naHfE6wHdizxXEVGM2BPEIZkouheow3wgkYIE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UoFbP4eYxXgi/1rAHEUPJfAnAS8VfeTvvsRHci3eOwIZkM7NWLYiTF/NiZY5uhmbY+RWT0JMvUBbnx3FjTejy8JMifQtyXovBK5UvK5xGyy7eeCfIvWYOWIYQFsYVXgb/XDbdUTA3sJ49SvB5ZnBU9C2TnlEEzJVe8E6AR5X9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bah56hbL; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c2e912df-a84b-4cb7-9221-d29cae182aed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710174652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhucpk8+s6nnIU/rfJr0jep5WX5DR2EJ/KZln53/P8o=;
	b=Bah56hbLn/w4SGuiw9WsRcG5jm60zOxekMKINHA7H3vx3X8UdjiZCzIbBXDiZlEQFF10bG
	JMWL/u2+ej+SSAcKwot38pXeB2ke93IsplXoKxBL5+IGSrfGs4hLqaPzBfvGUwxDvV6rEx
	FkUvsa2H9U4j5yfIqoluWi8syL9dgok=
Date: Mon, 11 Mar 2024 12:30:48 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: iio: xilinx-ams: shift-out-of-bounds in
 ams_enable_channel_sequence
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
 "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <a6dd3a2f-c3e9-4781-801b-8e8e72ac9beb@linux.dev>
 <20240309190649.04be7261@jic23-huawei>
 <0eb0b1b0-179b-424d-b0e8-94343e0344d1@linux.dev>
In-Reply-To: <0eb0b1b0-179b-424d-b0e8-94343e0344d1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/11/24 12:11, Sean Anderson wrote:
> +CC Conall
> 
> On 3/9/24 14:06, Jonathan Cameron wrote:
>> On Tue, 5 Mar 2024 12:30:53 -0500
>> Sean Anderson <sean.anderson@linux.dev> wrote:
>> 
>>> Hi,
>>> 
>>> When enabling UBSAN on a ZynqMP Ultrascale+, I see the following error during boot:
>>> 
>>> [    1.447628] ================================================================================
>>> [    1.447832] UBSAN: shift-out-of-bounds in ../drivers/iio/adc/xilinx-ams.c:426:16
>>> [    1.448019] shift exponent 66 is too large for 64-bit type 'long long unsigned int'
>>> [    1.448211] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.6.20+ #90
>>> [    1.448368] Hardware name: xlnx,zynqmp (DT)
>>> [    1.448475] Call trace:
>>> [    1.448547]  dump_backtrace+0x9c/0x11c
>>> [    1.448655]  show_stack+0x18/0x24
>>> [    1.448749]  dump_stack_lvl+0xac/0xd4
>>> [    1.448853]  dump_stack+0x18/0x24
>>> [    1.448947]  ubsan_epilogue+0x10/0x44
>>> [    1.449051]  __ubsan_handle_shift_out_of_bounds+0x98/0x134
>>> [    1.449191]  ams_enable_channel_sequence+0x22c/0x23c
>>> [    1.449324]  ams_probe+0x570/0x6d4
>>> [    1.449423]  platform_probe+0x68/0x108
>>> [    1.449530]  really_probe+0x158/0x3b0
>>> [    1.449632]  __driver_probe_device+0x88/0x1a0
>>> [    1.449747]  driver_probe_device+0x3c/0x138
>>> [    1.449859]  __driver_attach+0xe4/0x1bc
>>> [    1.449964]  bus_for_each_dev+0x78/0xe0
>>> [    1.450068]  driver_attach+0x24/0x30
>>> [    1.450167]  bus_add_driver+0x110/0x240
>>> [    1.450271]  driver_register+0x60/0x128
>>> [    1.450376]  __platform_driver_register+0x28/0x34
>>> [    1.450500]  ams_driver_init+0x1c/0x28
>>> [    1.450609]  do_one_initcall+0x78/0x2c8
>>> [    1.450714]  kernel_init_freeable+0x2f8/0x59c
>>> [    1.450831]  kernel_init+0x30/0x150
>>> [    1.450932]  ret_from_fork+0x10/0x20
>>> [    1.451073] ================================================================================
>>> 
>>> When applying the following patch:
>>> 
>> That channel definition looks suspicious. Anyone shed light on what the channel scan index layout
>> is supposed to be?
>> There seem to be substantial gaps in used numbers.
>> If I read it right the offset to jump over the AUX_CHAN is too large (22 - should be 16) but
>> that still ends up with us going above the range of supported scan indexes.
>> 
>> The PL Sequence mask used is GENMASK_ULL(59, 22)
>> 
>> Whilst the bits are set, nothing actually reads them that I can see.
>> So why are they set and how are those channels supposed to work?
>> 
>> So agreed buggy; no idea what it supposed to do!
> 
> OK, so there are three groups of channels in this device, as set up by
> ams_init_module:
> 
> 	- CTRL channels (xlnx,zynqmp-ams)
> 	- PS channels (xlnx,zynqmp-ams-ps)
> 	- PL channels (xlnx,zynqmp-ams-pl)
> 
> According to the comment in ams_enable_channel_sequence,
> 
> 	/*
> 	 * Enable channel sequence. First 22 bits of scan_mask represent
> 	 * PS channels, and next remaining bits represent PL channels.
> 	 */
> 
> and indeed, the following code only touches the PS and PL registers. So
> I think we just need to add a check for
> chan->scan_index >= AMS_CTRL_SEQ_BASE, like in ams_read_raw.

https://lore.kernel.org/linux-iio/20240311162800.11074-1-sean.anderson@linux.dev/

--Sean


