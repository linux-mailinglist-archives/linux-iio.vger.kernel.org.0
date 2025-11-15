Return-Path: <linux-iio+bounces-26242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90269C609D4
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB0784E3308
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F5303C8A;
	Sat, 15 Nov 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiuBfvvo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB4265298;
	Sat, 15 Nov 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763230069; cv=none; b=MBZyjsiDmO/02dCXrGCChfaTH5Cip52Y8PRCFe81TJ2YYd7bnl7d7e4V+/1a5AoljeJUGyxH7l4ViuAMd44H+Fe4pII/FSEFQQBOVj3+IsNbNOUoRUMqk51qGLEvZqeBPDxxBWY52D+f9hQ3Z5UZGUR0gBFiwSYB2ctVv4ooEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763230069; c=relaxed/simple;
	bh=QDCB3pj8AsIK8KSSIDiA4IYnMavrKLw3NX+M7OciO9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghyASIZN/KHdispDV9QUR2OP07eeqGWvz4b6WZvUQNavSkl1o7Mg16SzK9ZkUGY/JwcLpLo75iekbQMfZow78XcoEnXF6q5axe5YALFusaXq97j8L1IsSok6A/o+jiE6PY4JAqAUsTncfCyGfEj6m/SZEjNCyQwi8CvPyK+AKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiuBfvvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD52C4CEF7;
	Sat, 15 Nov 2025 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763230068;
	bh=QDCB3pj8AsIK8KSSIDiA4IYnMavrKLw3NX+M7OciO9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kiuBfvvoe4mO5j6nd3azpiJDmpuaynPAJDNWW6UPU/gqOK6ogrHQfc89j5We+M/88
	 s4B+SFyQYwLbPD3iPvS8X1SwGuxBHUmD0wp6/PxSwEQEEnVFTrwKKsra/XGO/TIpJT
	 AR/vkLueE6FFR38LqaTU53YFiTXUCIp32PHWrxasM9+d51+hCQolwvz1L66B2H8TXE
	 lMsGy4VWPdvRj85xv9aLSWlYxq1+hrIS/2ca/QQjvRjBnKnFkGRRkSbprlOue7391i
	 uTTBM7SjVZ6CDf1T8O+N9Mro6RogfXU93TSriJoCWlzcnhLxfdhLAwJiiMPROo0+BA
	 03sTOjHqoM72g==
Date: Sat, 15 Nov 2025 18:07:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: mpl3115: support for events
Message-ID: <20251115180742.75ea99f6@jic23-huawei>
In-Reply-To: <20251112225701.32158-1-apokusinski01@gmail.com>
References: <20251112225701.32158-1-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 23:56:58 +0100
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Hello,
> The mpl3115 device can raise interrupts when a pressure or temperature
> threshold is crossed, this patchset adds support for them using IIO's
> events interface.
> 
> In v4 mostly some minor variable rename changes and a comment in
> read_info_raw according to the review in v3.
Looks good to me, thanks.

Applied to the togreg branch of iio.git but initially pushed out as
testing to let the build bots poke at it and see if they can find
anything we missed.

Thanks,

Jonathan

> 
> Kind regards,
> Antoni Pokusinski
> 
> ---
> Changes since v3:
> (patch 1/3 "use get_unaligned_be24() to retrieve pressure data")
> * commit msg: "get_unaligned_be24" -> "get_unaligned_be24()"
> * read_info_raw: renamed "tmp[3]" -> "press_be24[3]"
> * read_info_raw: added comment at pressure val computation
> (patch 2/3 "add threshold support")
> * interrupt_handler: added sizeof() in a i2c_read_i2c_block call
> * read_thresh: renamed "tmp" -> "press_tgt"
> * write_thresh: renamed "tmp" -> "press_tgt"
> 
> Changes since v2:
> (general)
> * added the patch tidying up the pressure data retrieval (u8[3] used)
> (patch 2/3 "add threshold support")
> * includes: removed unused linux/units.h
> * read_thresh: fixed comment formatting
> * interrupt_handler: val_press is now u8[3] instead of __be32
> 
> Changes since v1:
> (general)
> * squashed the cleanup patch
> * added the patch with the documentation update
> (patch 1/2 "add threshold event support")
> * patch description: explained changes in locking
> * read_event_config: replaced switch with ifs
> * read_event_config: return as early as possible, got rid of int_en_mask
> * read/write_thresh: pressure: calculation changes to comply with raw ABI
> * interrupt_handler: reordered the INT_SRC_* bits in if condition
> * read/write_thresh: used sizeof() and values from limits.h
> * write_thresh: replaced `u8 tmp[2]` with `__be16 tmp`
> * dropped the space between casting `(u8 *) &tmp`
> 
> 
> Antoni Pokusinski (3):
>   iio: mpl3115: use get_unaligned_be24() to retrieve pressure data
>   iio: mpl3115: add threshold events support
>   iio: ABI: document pressure event attributes
> 
>  Documentation/ABI/testing/sysfs-bus-iio |   2 +
>  drivers/iio/pressure/mpl3115.c          | 234 ++++++++++++++++++++++--
>  2 files changed, 223 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 1d09cf18cc91d29f650ad9811ed4868d9304d6c7


