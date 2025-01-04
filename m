Return-Path: <linux-iio+bounces-13890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86628A014EC
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 14:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652773A3278
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07871990CD;
	Sat,  4 Jan 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg/JiIjs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696532F5E;
	Sat,  4 Jan 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735996164; cv=none; b=sKhWxxPFia30QJvOpBxt68y0RCjc0mFz3P388UlZORDF9LquC+PIhnar6qC3gzdsFePsd6hLcXD7BtkNxDd3qj4VhBAeADIANVr1bszOvmGd2ftIL4iHQHmGo8aNDYc0zFSKn03zE4ihLfl2F8M8uDkHj95RI4zBUDtpEexU6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735996164; c=relaxed/simple;
	bh=wjxmpQRbg9G83a7io9mNUBP25RKfsMpoVdpWbVR7zpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oflQ4JKQrEgm4P41M04yKTFJ7vvroZzbVZceGO9MD9AMvf1ULHgmv/1PY4IF1miuSLHgEMykWpf4BNyRdYTTjcmpFGjLbtzmAMfNfYt+87MPqAvinLcQghFB+WsJ5zR3Wa3lKYEe/WaklZRjORel2FH93qjK27grM2yzaFw/xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg/JiIjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475F7C4CED1;
	Sat,  4 Jan 2025 13:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735996164;
	bh=wjxmpQRbg9G83a7io9mNUBP25RKfsMpoVdpWbVR7zpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fg/JiIjsHcu9HXS/fJrEmYxkjEigaAkx7RGHwKmWJvTWHP80OOAeCRu1MoDgJUF0w
	 ydvcGGNzw+xTIJiP8+LMNRVcFJxr6VRu0btCEmytb3snZ4eSnfp9q0M25UZClE6s5x
	 ueYzvA5aa+wKNtZnpz1KBnjcntTTkB95M/bNJBaNl2MpcavmpnYajIFd23ruV4ePde
	 Vnrzs0dzjMrePy38m+cpOsQHtp0Kn4oEkrKlWYhs7gSGHIDqiZ3XWAdQTIOydMzg+x
	 I+W3PApSw/cthM40aFx2JIUkoxDUG8ERr3eQc03eyrM6iJ9TA9f+FzMolyOFus+Vc8
	 ckLgJFRrOy6IA==
Date: Sat, 4 Jan 2025 13:09:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v9 0/4] iio: accel: adxl345: add FIFO operating with IRQ
 triggered watermark events
Message-ID: <20250104130916.5a25b5bd@jic23-huawei>
In-Reply-To: <20241228232949.72487-1-l.rubusch@gmail.com>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Dec 2024 23:29:45 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The adxl345 sensor offers several features. Most of them are based on
> using the hardware FIFO and reacting on events coming in on an interrupt
> line. Add access to configure and read out the FIFO, handling of interrupts
> and configuration and application of the watermark feature on that FIFO.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Series applied but with a tweak on patch 3.  Please take a look at the
testing branch where this will sit for a few days,

Jonathan

> ---
> v8 -> v9:
> - move FIELD_PREP() usage to a local usage in adxl345_core.c
> - remove ADXL345_{SD}_TAP_MSK macros
> v7 -> v8:
> - remove dt-binding quotation marks
> - add DMA alignment
> - fix indention, formatting and text alignment
> v6 -> v7:
> - reorder dt-binding patches
> - extracted FIFO specific from constants list
> - reorder constants list in header patch to the end
> - verify watermark input is within valid range
> v5 -> v6:
> - dropped justify patch, since unnecessary change to format mask
> - added separate dt-bindings patch to remove required interrupts property
> - merged FIFO watermark patches
> - reworked bitfield handling
> - group irq setup in probe()
> - several type fixes by smatch and tools
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
> Lothar Rubusch (4):
>   iio: accel: adxl345: introduce interrupt handling
>   iio: accel: adxl345: initialize FIFO delay value for SPI
>   iio: accel: adxl345: add FIFO with watermark events
>   iio: accel: adxl345: complete the list of defines
> 
>  drivers/iio/accel/adxl345.h      |  77 +++++--
>  drivers/iio/accel/adxl345_core.c | 338 ++++++++++++++++++++++++++++++-
>  drivers/iio/accel/adxl345_i2c.c  |   2 +-
>  drivers/iio/accel/adxl345_spi.c  |   7 +-
>  4 files changed, 404 insertions(+), 20 deletions(-)
> 


