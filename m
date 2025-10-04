Return-Path: <linux-iio+bounces-24721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5BBB8F49
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACE6F346BEA
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF69F21FF29;
	Sat,  4 Oct 2025 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcVItWMc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43F8C11
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759590449; cv=none; b=KvLEg/NsJ/1CPArxI5/URkb1vOimcfwbG7xKXW42llJGRI0665bfbEwjp27KFSneHovO4iRufbXlQgc5VtmYUUyksqFaDukvEaVDcrQk522AOYHXYWsDn2OXTINALN3WSQktZjfk3SAwjnImJP5mcUMhBq13fCu7AXWkyy2W35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759590449; c=relaxed/simple;
	bh=ZmTx07p6PRHLn8q+RS+MpQ/c1IY7A6owx6FEPMqpl+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYEG68SXULuBBBCoqXuKs+XyFaOzgIGm4pZ14jQ5Xb1z2XELhpB0bYmMVNrLv5b4D+n6Wo8qSjFzE5XDiKDabo9/6+P1+d3R7m0U8vzyhckcqfcTIcpC8NgtRO8v/iRmbd8gHgTJgKqi78Fju8h3yM7jKfmFx4x+iPCAOcO8GKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcVItWMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D87C4CEF1;
	Sat,  4 Oct 2025 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759590449;
	bh=ZmTx07p6PRHLn8q+RS+MpQ/c1IY7A6owx6FEPMqpl+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WcVItWMcO7oanygiD9SC0p3f+5HWchp7e5wyXBybnyc2Y9yZrnVnA2zN9WNxGcXlh
	 BPi/HI4ghakg7nRLwipLX8NLvvkk2B7v7Ts76oa2Wurpn/mLVuC1HCE7+Z6S1z1d14
	 NQWeBcMz42syYS10uyuyNQKATT733AO37LvvcRusB/AArR8DMcWHVH1sj9fwL2NyCe
	 WcO+SJervMp/gGRcprIGTR8WapNVmBlFxgCnmPYun8GvKVJBNtrk+fdSi36uCJZ3UO
	 ar0VLBfvCNUOqO1eIdvBVfKD5suUlK/rHOwouO+DfJ5M0gqif6pVvdc0LmHKoc2Iwd
	 YxpPUFaML8u+g==
Date: Sat, 4 Oct 2025 16:07:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v3 0/9] Fixes and enhancements for the bmp280 driver
Message-ID: <20251004160721.4c6485cb@jic23-huawei>
In-Reply-To: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 19:26:27 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Revision History:
> =================
> 
> v1:
> 	- initial proposal, incorrectly prefixed "bmp280" instead of "RFC PATCH"
> 	- patch series presented in the order it was created
> 
> v1 -> v2:
> 	- prefix as "RFC PATCH"
> 	- drop channel switching
> 	- rewrite to present patches in smaller units and in logical steps
> 
> v2 -> v3:
> 	- incorporate comments/suggestions on v2
> 	- clean up
> 
> With v6.13 a change was made to the bmp280 drivers to use MODE_FORCED
> instead of MODE_NORMAL.  This broke userspace functionality: reading
> from sysfs interfaces no longer worked and an error was thrown
> "Measurement cycle didn't complete".  This series fixes the underlying
> bugs affecting the measurement time calculation (patches 0001 through
> 005) and implements additional functionality (patches 0006 through
> 009) not available for the BMx280 devices previously to allow the use
> of the sysfs interface in MODE_NORMAL again and control the
> corresponding parameters.  The implementation follows the already
> existing facilities for the BMx[35]80 devices even though the actual
> functionality of the BMx280 hardware is slightly different.
> 
Hi Achim,
A small process related question.  Why is this an RFC?

I'd typically expect an RFC to have a cover letter with some open questions
or another statement of why the author wants comments rather than the
code to be merged.

Jonathan

> Achim Gratz (9):
>   iio: pressure: bmp280: correct meas_time_us calculation
>   iio: pressure: bmp280: implement adaptive wait for BMx280 devices
>   iio: pressure: bmp280: implement adaptive wait for BMP380 devices
>   iio: pressure: bmp280: rename wait_conv() to conv(), factor out
>     measurement time calculation
>   iio: pressure: bmp280: remove code duplication
>   iio: pressure: bmp280: enable filter settings for BMx280
>   iio: pressure: bmp280: implement sampling_frequency for BMx280
>   iio: pressure: bmp280: implement sampling_frequency calculation for
>     BMx280
>   iio: pressure: bmp280: test longer autosuspend (WIP)
> 
>  drivers/iio/pressure/bmp280-core.c | 504 +++++++++++++++++++++--------
>  drivers/iio/pressure/bmp280.h      |  26 +-
>  2 files changed, 387 insertions(+), 143 deletions(-)
> 


