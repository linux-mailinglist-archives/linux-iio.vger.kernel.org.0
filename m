Return-Path: <linux-iio+bounces-18104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132B7A88B87
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE5A3B4F02
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA328BA89;
	Mon, 14 Apr 2025 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTqHg4f2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92055192D6B;
	Mon, 14 Apr 2025 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656155; cv=none; b=F32nHFE02EMTH8NG+yc0uEnQuaz/xJIEZO5W31OZ3H1Y5K6/QB1jREczFKh8Anu7WXHpsDSHs9D83OOAUFkEB/Va4YSX5nCtgklQdCPbVKqQbzgYtpysY/lrzszqoOFYcLuzlzDJi3M8bLcLgsFUiAUJA5quAq437YXZA0S7HvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656155; c=relaxed/simple;
	bh=lm7gUm0R/Mv3PLgPYbMGJSstDs4voIh/QeUwm11ZtEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMusOouQui9bfJvpVRSIC6yqd9wIiP5WLIlx8ToyP5k9qhG2mi5M95erUNlaExASXOt0enC2Rn1Cj27EWnvxEMeKkx/Kl0SRBQWCkKvDIZw66Qiga7XhS99+xKJhnrdBlSeagzSdywsesKnwBgZqJHdRt3NvOi7AmVBl8d6ep4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTqHg4f2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ED9C4CEE2;
	Mon, 14 Apr 2025 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744656155;
	bh=lm7gUm0R/Mv3PLgPYbMGJSstDs4voIh/QeUwm11ZtEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qTqHg4f2irPR9LtcFjMewRc1xEpdIG7i/BxuXeEQcEOyozFsfUHdmOvinkVBU1RFn
	 CMXe+Lxygjs3v3s4wzOLaRHMNGEtrHgtyqZDr+S0ban3g8q3gigakBpkq6mWisb0lw
	 TzG64IuEdNnSroC91rw7glexnw4XxelWJ897jjgr9fPGdwFXycAfhC7sLF5lEYwIK/
	 PvSaDfxHEwBI6SGwAAcSmsUgKADRHGg3Zoddrbi9qX2pVY4qnMRGuTo2nqV58ru5gk
	 NJVJgPhpyeLOyI2eINpDlzXQRbipq0536R8+fQUgVpZHNQA+H7x38g71epKgEY3jrS
	 i6J067K6AUGOA==
Date: Mon, 14 Apr 2025 19:42:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ana-Maria Cusco
 <ana-maria.cusco@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 2/7] iio: adc: Add basic support for AD4170
Message-ID: <20250414194227.7a49301e@jic23-huawei>
In-Reply-To: <Z_z72J_gcZqW14CE@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	<5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
	<20250412174710.33afb04d@jic23-huawei>
	<Z_z72J_gcZqW14CE@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> > > +static int ad4170_regulator_setup(struct ad4170_state *st)
> > > +{
> > > +	struct device *dev = &st->spi->dev;
> > > +	int ret;
> > > +
> > > +	/* Required regulators */
> > > +	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret, "Failed to get AVDD voltage.\n");
> > > +
> > > +	st->vrefs_uv[AD4170_AVDD_SUP] = ret;
> > > +
> > > +	ret = devm_regulator_get_enable_read_voltage(dev, "iovdd");  
> > 
> > If no channel uses this reference is it not optional?  Maybe not worth the
> > complexity of handling that.  We have sometime bothered to do so in the past
> > by first figuring out which references are in use, then trying to get the
> > appropriate regulators with small changes for cases like this where
> > it needs to be enabled but we might not need the voltage.  
> 
> We can set the channel multiplexer to use IOVDD reference as diff chan negative
> input. Similar thing can be done for the other reference supplies. I think
> the examples in dt-binding don't use IOVDD but they could. Since the driver is
> supporting other regulators, maybe support IOVDD too?

That's fine. In a few drivers where we have muxes that can use many different
regulators, we allow for regulators to not be provided if no channels use them.
It may not be worth the effort.  If anyone comes along later with a board
wired that way then we can relax the requirement at that point.

> 
> >   
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret, "Failed to get IOVDD voltage.\n");
> > > +
> > > +	st->vrefs_uv[AD4170_IOVDD_SUP] = ret;
> > > +
> > > +	/* Optional regulators */
> > > +	ret = devm_regulator_get_enable_read_voltage(dev, "avss");
> > > +	if (ret < 0 && ret != -ENODEV)
> > > +		return dev_err_probe(dev, ret, "Failed to get AVSS voltage.\n");
> > > +  


