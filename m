Return-Path: <linux-iio+bounces-10947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8642F9AB5F6
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 20:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD9A1F241E3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 18:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF591C8FCF;
	Tue, 22 Oct 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwIiTn1P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669B1A0730;
	Tue, 22 Oct 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621695; cv=none; b=NZ0+c89l79C4vvUfhKL5E0Ea2rvJfxwic4QG2hg5vThFPRdO5qz+I+QYWHEsW1+ET81LjQ9vmxMyXiimZOxhfg98GApnXFbvCdtm2aUyKUbmdD9tYrXi/uL5Hrn4v2g+89028D0iz6fUCjEZcuQshO2MO20QHhTnmXZPQXBxWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621695; c=relaxed/simple;
	bh=9HTaRlNc3F7aUB1JN8jCLA7QnnrU/kxWD5dEdPEaZck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+jKKzsZvLNcqeXttBJ0At9MzUno83zVxBxCTA40+T6e+0Q11Lef9iYP/AJG/s8ThRFfpv+CvkmRMQEFzExRFOqC6e5FF0HTFsDAZDyC1IWnoulTbtTjOhKBCz84f4Blw8G6T57pD5pIwwek+lC2Nm6u/Qe8JpRNnjTKzld5W0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwIiTn1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F88CC4CEC3;
	Tue, 22 Oct 2024 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729621695;
	bh=9HTaRlNc3F7aUB1JN8jCLA7QnnrU/kxWD5dEdPEaZck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwIiTn1PATpmK2j9j+bwDfhobi9knZ1qsNDU+S6WK7wfFrFiX0iGor+edD1o5ZWuZ
	 qz4tVJ27RE4vPnP87ze1glWX33qY/tC3W3zcRMpQdypWlO0x5I8MwVk0MEHr3WTECG
	 Gezf2ka22hfyIWhURQk4lHKvPjddkY0mLb+vj+i8QM9hFnY6a9MOqqYsVBceesGsko
	 uMyJIcLTOW3O5b5ytaXPWmtbT4UXAVxyifr2be/PoBJoCgyaTGfQFOgoX8wfG9Up7c
	 tnUnGVwa+QNaF5rPmZ8CqQDv99HTGyOyT1cZREpc5yuwapP+qMjnma3HZNzaoJl0SG
	 fn/DBPjUdzVfw==
Date: Tue, 22 Oct 2024 19:28:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: add support for veml3235
Message-ID: <20241022192807.2f83dfa1@jic23-huawei>
In-Reply-To: <7323ca4f-2f79-4478-b2b0-2cfc350af7f8@gmail.com>
References: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
	<20241020-veml3235-v2-2-4bc7cfad7e0b@gmail.com>
	<20241021193933.59c2d2b6@jic23-huawei>
	<7323ca4f-2f79-4478-b2b0-2cfc350af7f8@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 22:21:22 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 21/10/2024 20:39, Jonathan Cameron wrote:
> > On Sun, 20 Oct 2024 21:12:17 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> The Vishay veml3235 is a low-power ambient light sensor with I2C
> >> interface. It provides a minimum detectable intensity of
> >> 0.0021 lx/cnt, configurable integration time and gain, and an additional
> >> white channel to distinguish between different light sources.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > Hi Javier,
> > 
> > I missed one thing on previous review...
> > There is no obvious reason this driver needs to provide raw and processed
> > values.  Unless I'm missing something, just provide raw and let userspace
> > do the maths for us.
> > 
> > Jonathan
> >   
> Sure, I will drop that for v3. I added it because this driver took the
> veml6030 as a reference, and that driver provides the processed value. I
> guess that the veml6030 should have not provided processed values
> either, but it's late to remove them after the driver was released.
> 
> Now that we are at it, what is the rule (of thumb?) to provide processed
> values? Those that can't be obtained from the raw data and simple
> operations with the scale/offset/integration time/whatever userspace can
> see?

Yes. If the conversion is linear, then leave it to userspace (with scale
and offset provided). If it's not linear then in kernel because currently
we have no other choice.

There are some historical quirks where a processed only interface got in
then we had to add raw later (typically when we added buffered output
where scale and offset are important because processed values normally
don't pack well).

Jonathan


> 
> Thank you and best regards,
> Javier Carrasco


