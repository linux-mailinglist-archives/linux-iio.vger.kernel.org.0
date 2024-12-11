Return-Path: <linux-iio+bounces-13339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5219ED5A5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA67B280CAA
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D9C2510B7;
	Wed, 11 Dec 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df7rvhNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC22510AD;
	Wed, 11 Dec 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943210; cv=none; b=Z5uURm4Gjg13eGfwxEe0NbidW+Hz4FlG5EdR5+X/H/QF4W8PJtv1KJ5AQj4F5q83nJJRxFb/wrO7ef2kdIwqWiVhCQPhKPbAObLPGG/RGZLMj4laaEVd+fCtj/ccKqy0wdnyhUYx6jCVthaIvEQ0Zapm3du/OIJTOaJI33wBigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943210; c=relaxed/simple;
	bh=Ko1y4V+r9B+sbfKlQjRHM0LQ9tg/BC7t1nwxOzz3AEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT8OYtCqMhazn5woCVmlSLrHDH5wxFQCHbtkhAUfqY7eLq/t23TLGsovUbreuq2h/6fjHBDU+05jVf+5hNuxqI/Cvig9iNwlAKSxdqxeKSe5R2RggsA9/FZsW7vnt41RwY7R6pbpgFhJS3h72TthYoJ0r9asdEZernDWJHuxdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df7rvhNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFB4C4CEDD;
	Wed, 11 Dec 2024 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943210;
	bh=Ko1y4V+r9B+sbfKlQjRHM0LQ9tg/BC7t1nwxOzz3AEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Df7rvhNolNMMzTuknRhQPXZ12UBtgC8SAijwMzxPXYQDqcRDzjmr3x3/YlSvOYIlL
	 yQL2Ln2yM5zAqVylNxxdTWGMC7/YZgzU+czu3J5UOm0tvwfz/z+rFQcwWEXGA7Xr3W
	 QTLk/6bKN5kLA32Zj++Ac7P+TDTYLo3zMzQ0MNyIsLpKivXZmGsyuK+3wkje16YxxR
	 OiIXLt/qkqD4HpE453Rv5kUglXKO+NqsfgS9CqFMk6VLnktlGAOkXti94Xc7mL7V7h
	 WnOJvDmM/8ju3JPaAKGNmX/Zg2X+bVIMrO4wMIoCIHdO027XoFaowE2g4a5DPQdsn4
	 vCUeguADhdvhA==
Date: Wed, 11 Dec 2024 18:53:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 00/10] iio: accel: adxl345: add FIFO operating with
 IRQ triggered watermark events
Message-ID: <20241211185321.7d1ed407@jic23-huawei>
In-Reply-To: <20241205171343.308963-1-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:33 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The adxl345 sensor offers several features. Most of them are based on
> using the hardware FIFO and reacting on events coming in on an interrupt
> line. Add access to configure and read out the FIFO, handling of interrupts
> and configuration and application of the watermark feature on that FIFO.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
> Although I tried to implement most of the requested changes, now the code
> is simplified and clearer, I still encounter some issues.
> 
> 1) Unsure if my way reading out the FIFO elements with a regmap_noinc_read()
>    is supposed to be like that. 

That is pretty standard looking.

>    TBH, isn't there a better way, say, to
>    configure the channel correctly and this is handled by the iio API
>    internally? As I understood from v2 there might be a way using
>    available data, also in iio_info I see now as buffer attributes an
>    available data field. Where can I find information how to use it or
>    did I get this wrong?

Could you give a reference for that. I'm not sure what you are referring to.
if you mean available_scan_masks then that is used to allow the core
to demux data if you have to read all channels out (or some subset) rather
than any combination.

We don't have a bulk put to the buffers. Have thought about it in the past
but it reality it's not that much efficient in the core because in many cases
we have to reorganize the data.




> 
> 2) Overrun handling: I'm trying to reset the FIFO and registers. Unsure,
>    if this is the correct dealing here.

It's a tricky corner. Sometimes people just drain the buffer on basis device
recovers, some other devices need a reset.  
There isn't a good way to communication it to userspace though.

> 
> 3) I can see the IRQs coming in, and with a `watch -n 0.1 iio_info` I can
>    see the correct fields changing. I tried the follwoing down below,
>    but the iio_readdev shows me the following result. I don't quite
>    understand if I still have an issue here, or if this is a calibration
>    thing?
> 
> # iio_info 
> Library version: 0.23 (git tag: v0.23)
> Compiled with backends: local xml ip usb
> IIO context created with local backend.
> Backend version: 0.23 (git tag: v0.23)
> Backend description string: Linux dut1138 6.6.21-lothar02 #3 SMP PREEMPT Wed Nov  6 21:21:14 UTC 2024 aarch64
> IIO context has 2 attributes:
> 	local,kernel: 6.6.21-lothar02
> 	uri: local:
> IIO context has 1 devices:
> 	iio:device0: adxl345 (buffer capable)
> 		3 channels found:
> 			accel_x:  (input, index: 0, format: le:s13/16>>0)
> 			4 channel-specific attributes found:
> 				attr  0: calibbias value: 0
> 				attr  1: raw value: -14                          <--- CHANGES
> 				attr  2: sampling_frequency value: 100.000000000
> 				attr  3: scale value: 0.038300
> 			accel_y:  (input, index: 1, format: le:s13/16>>0)
> 			4 channel-specific attributes found:
> 				attr  0: calibbias value: 0
> 				attr  1: raw value: 6                            <--- CHANGES
> 				attr  2: sampling_frequency value: 100.000000000
> 				attr  3: scale value: 0.038300
> 			accel_z:  (input, index: 2, format: le:s13/16>>0)
> 			4 channel-specific attributes found:
> 				attr  0: calibbias value: 0
> 				attr  1: raw value: 247                          <--- CHANGES
> 				attr  2: sampling_frequency value: 100.000000000
> 				attr  3: scale value: 0.038300
> 		2 device-specific attributes found:
> 				attr  0: sampling_frequency_available value: 0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200
> 				attr  1: waiting_for_supplier value: 0
> 		3 buffer-specific attributes found:
> 				attr  0: data_available value: 13
> 				attr  1: direction value: in
> 				attr  2: watermark value: 15
> 		No trigger on this device
> 
>   Above I marked what keeps changing with "CHANGES", that's what I expect. Then with readdev
>   I obtain the following result.
> 
> # iio_attr -c adxl345
> dev 'adxl345', channel 'accel_x' (input, index: 0, format: le:s13/16>>0), found 4 channel-specific attributes
> dev 'adxl345', channel 'accel_y' (input, index: 1, format: le:s13/16>>0), found 4 channel-specific attributes
> dev 'adxl345', channel 'accel_z' (input, index: 2, format: le:s13/16>>0), found 4 channel-specific attributes
> # echo 1 > ./scan_elements/in_accel_x_en
> # echo 1 > ./scan_elements/in_accel_y_en
> # echo 1 > ./scan_elements/in_accel_z_en
> # echo 32 > ./buffer0/length
> # echo 15 > ./buffer0/watermark
> # echo 1 > ./buffer0/enable
> # iio_readdev -b 16 -s 21 adxl345 > samples.dat
> # hexdump -d ./samples.dat 
> 0000000   65523   00006   00248   65523   00005   00235   65522   00006
> 0000010   00248   65522   00006   00248   65521   00005   00247   65522
> 0000020   00007   00249   65523   00005   00249   65521   00006   00248
> 0000030   65522   00006   00248   65522   00006   00250   65522   00006
> 0000040   00249   65522   00005   00248   65523   00005   00248   65521
> 0000050   00007   00248   65521   00006   00250   65522   00005   00248
> 0000060   65521   00006   00248   65522   00007   00247   65522   00006
> 0000070   00248   65522   00006   00248   65521   00004   00250        
> 000007e
> 
>   Am I doing this actually correctly?

I'm sorry to say I'm guessing here don't use this tool.  I'm still stuck in using my own tooling
(mostly the stuff in the kernel tree in tools/iio) that predate anyone writing nice
userspace code :)

What do you think looks wrong?  You should have 3 16 bit values.
You haven't turned on the timestamp so they will be tightly packed
That hex dump looks plausible if it's storing the actual raw buffer data.

To convert that to real data you need to apply masking and scale factors.

Jonathan


> 
> ---
> v4 -> v5:
> - fix dt-binding for enum array of INT1 and INT2
> v3 -> v4:
> - fix dt-binding indention 
> v2 -> v3:
> - reorganize commits, merge the watermark handling
> - INT lines are defined by binding
> - kfifo is prepared by devm_iio_kfifo_buffer_setup()
> - event handler is registered w/ devm_request_threaded_irq()
> v1 -> v2:
> Fix comments according to Documentation/doc-guide/kernel-doc.rst
> and missing static declaration of function.
> ---
> Lothar Rubusch (10):
>   iio: accel: adxl345: refrase comment on probe
>   iio: accel: adxl345: rename variable data to st
>   iio: accel: adxl345: measure right-justified
>   iio: accel: adxl345: add function to switch measuring mode
>   iio: accel: adxl345: complete list of defines
>   dt-bindings: iio: accel: add interrupt-names
>   iio: accel: adxl345: introduce interrupt handling
>   iio: accel: adxl345: initialize FIFO delay value for SPI
>   iio: accel: adxl345: prepare channel for scan_index
>   iio: accel: adxl345: add FIFO with watermark events
> 
>  .../bindings/iio/accel/adi,adxl345.yaml       |   7 +
>  drivers/iio/accel/adxl345.h                   |  90 +++-
>  drivers/iio/accel/adxl345_core.c              | 427 ++++++++++++++++--
>  drivers/iio/accel/adxl345_i2c.c               |   2 +-
>  drivers/iio/accel/adxl345_spi.c               |   7 +-
>  5 files changed, 478 insertions(+), 55 deletions(-)
> 


