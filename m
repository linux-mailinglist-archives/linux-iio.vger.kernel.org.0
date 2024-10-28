Return-Path: <linux-iio+bounces-11516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A659B3B1B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EDAB21F38
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DCB1DF98C;
	Mon, 28 Oct 2024 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIvUSgvi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520D3A1DB;
	Mon, 28 Oct 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146112; cv=none; b=k+GHwWpiA7/DLIxDFQE11KCH0qkRjjD+0uxtxs+mXIKJCFdURcPLi7iVojqujrimLq2UQ1YVua1ZxAEuwR2+6OlRWyXEyloOzrjJqyAxqgSlQeMhV/khCGH3vCMXlrzocOKwgPOjUbWD4RwbIuk50pYXiPRlyS0oUymptJRAPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146112; c=relaxed/simple;
	bh=YYBduAiodVBGE/mYClDemJUm/gYazsQUftPMcKT2XLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZhnbuwwqAB/bjS27N9YgjH0sjh2Ycgky3HYUDYvKDNGnYpYPGLZCGXkM6v9j3Kbgpw4KnOmbFdUrY2liwuEqXQRBe08upa6S+r3Z0GKLxRPV5fGEiF+24tdJCaC2YbRtiQeK1vZMOPZabAMTvJYjLYwguXO0NeIpE4d5z8+y4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIvUSgvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB1EC4CEE3;
	Mon, 28 Oct 2024 20:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730146111;
	bh=YYBduAiodVBGE/mYClDemJUm/gYazsQUftPMcKT2XLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jIvUSgviZqW/VtLdVRfif9scI5k98G0Y3S0BhZlMjkAtcGRBN8G9f2xynCTrixZ/B
	 A+M6S32Tj+m7DVWsMjY1yNo8kaOu3WO1L2J+LvcYt/+x/BbvKg8M7S9W5UMitD93FA
	 c4SSJ2vpcI0HmjbrqHzqUff03SmqyTJRS3gC3ZwAYthjUJXJ8ddHS6i2lmA2n1lUom
	 Na58JdIaIxpqYCL2AJZefh8DM6Lz1Gr5TyUD2FlUdJjnidI11lMbOIyGoaEkm89s9D
	 iawx2341gLRbkEnlgpiACYhdvCVoJNYw31QZNrbyoAWceLgWXLiEMGWomqgmBnUntq
	 WCRMkCTy4I4ZA==
Date: Mon, 28 Oct 2024 20:08:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v4 1/4] iio: imu: bmi270: Add triggered buffer for Bosch
 BMI270 IMU
Message-ID: <20241028200822.0b981c9a@jic23-huawei>
In-Reply-To: <Zx9Ycjnlef1RJfGf@smile.fi.intel.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
	<20241027172029.160134-2-justin@justinweiss.com>
	<Zx9Ycjnlef1RJfGf@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 11:25:06 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Oct 27, 2024 at 10:20:22AM -0700, Justin Weiss wrote:
> > Set up a triggered buffer for the accel and angl_vel values.  
> 
> ...
> 
> >  	.channel2 = IIO_MOD_##_axis,				\
> >  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > +	.scan_index = BMI270_SCAN_ACCEL_##_axis,		\
> > +	.scan_type = {						\
> > +		.sign = 's',					\
> > +		.realbits = 16,					\
> > +		.storagebits = 16,				\
> > +		.endianness = IIO_LE				\  
> 
> Leave trailing comma here.
> 
> > +	},	                                                \  
> 
> ...
> 
> >  	.channel2 = IIO_MOD_##_axis,				\
> >  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > +	.scan_index = BMI270_SCAN_GYRO_##_axis,			\
> > +	.scan_type = {						\
> > +		.sign = 's',					\
> > +		.realbits = 16,					\
> > +		.storagebits = 16,				\
> > +		.endianness = IIO_LE				\  
> 
> Ditto.
> 
> > +	},	                                                \  
> 
Agreed. Tweaked whilst applying

Jonathan


