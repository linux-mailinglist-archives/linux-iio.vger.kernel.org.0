Return-Path: <linux-iio+bounces-7643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D5932F99
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 20:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD32E1F23E1A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 18:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B781A01A0;
	Tue, 16 Jul 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+/F+O79"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B51F171
	for <linux-iio@vger.kernel.org>; Tue, 16 Jul 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152882; cv=none; b=mO1RKrkaJgLjTxET63dhiyh2vusPZNn3yciZx6RgPjaXRCHHCRJIkGuaCPd/Lh+jAlmm9JW1t5XkpqGP/LE8xNvLC4oJIJNI0WQudMY0/qDjd8Zh+Dr7QWIIhbBj4M2/bJvHuKhNpYJQyvMwg7rQsdkpxd3cgwYUCwI0vnC2FbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152882; c=relaxed/simple;
	bh=L+R5G3Z09RCdsELLkSTwx7SWLFa8opJgQjedwqh/bLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGgEtsEi2CQpTNbN1/J2pSiUDaQsI+54hzvNKg8uKwWHUQg32SQf9Sc2iDr/SxPgd8ELjKbHW+vKvmLmDIMVn4dwdsqJkTehXxjGQ+zKM/B5tHJLuIswHVPYlvxdyrhOxtLbq2ZszCYt/cB26i45RpBVgjnXP9aCc1290fTydXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+/F+O79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A001C116B1;
	Tue, 16 Jul 2024 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152881;
	bh=L+R5G3Z09RCdsELLkSTwx7SWLFa8opJgQjedwqh/bLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+/F+O79pYvxgxpBI1jPGENWjvihMEUZD1Bb4DzzxLumbTXC4Qb6fBR3WvmxDrYgu
	 0UWsGQV/rcjjuIaxbdVGEGffZispcA2r3LJ+aNPSKUqI/u3sGGy12fpuxjf+LtLBV3
	 r+YlSgUGCp8QaJvDrTiWE+kXd1kBqehsy0aWeM/+4wJP1rUU1G2/On4I5qSC1A4JnX
	 T3Og0WlVTelMiHa6PtRZsikbqHhriEOQWajeTf2IH4ZsKk0GfMTReRz6lb17cF43+L
	 tRH1zr23KHfl+/ftCxE92Fw955j+YUBMOfX9Ts4G5NUkTpclp+80zA2XeRH0i1uTSd
	 zIGTjU9FcDiaQ==
Date: Tue, 16 Jul 2024 19:01:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Driver for AMS AS7341
Message-ID: <20240716190115.3e565521@jic23-huawei>
In-Reply-To: <hix5scxn4hdii2b2nlaxha4ao73frko6ndzpbuyvhwcl2hveaa@o7zzkkk2fkk3>
References: <hix5scxn4hdii2b2nlaxha4ao73frko6ndzpbuyvhwcl2hveaa@o7zzkkk2fkk3>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 14:38:29 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Hello,
> 
> I am currently developing a driver for the AMS AS7341 spectral color
> sensor [1], which provides readings for 8 color channels.
> 
> In reviewing the IIO channel specifications, I've noticed modifiers are
> specified for red, green, and blue light intensities only.
Hi Gustavo,

We've always known the current colour approach would prove inadequate at some point.
The previous discussions (might find them in the archive) included
trying to actually describe the sensitivity in terms of wavelength.
Perhaps that is revisiting?

in_intensityX_raw
in_intensityX_wavelength_centre
or similar?

I see the datasheet conveniently provides a centre value for each sensor.
Maybe it's worth considering how representative the full width half maximum value is
of the data that we get for light sensors.  Perhaps that ABI also makes
sense?  IIRC we do have a sensors with strong dual peaks though which
makes this sort of description tricky.


Jonathan


> 
> Is it ok to provide an extended ABI for this sensor or expand the
> existing ABI would be more suitable? What would be the best approach in
> this situation?
> 
> [1] Datasheet: https://look.ams-osram.com/m/24266a3e584de4db/original/AS7341-DS000504.pdf
> 
> Best regards,
> 
> Gustavo


