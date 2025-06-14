Return-Path: <linux-iio+bounces-20657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C0AD9D3A
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C5D16C768
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F12D9EC6;
	Sat, 14 Jun 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCRC4S0k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDCEBA49;
	Sat, 14 Jun 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749909339; cv=none; b=NfgtoZt+t8obwi+Tx3GYUv/2Pgpl6Y/fJ6AJbQ0gJB6/55+yq0aBAmJ7yYoJ1DGKLGBRmBaOhCTW4Ar6sPUSCfsD0eH3ZzgVW86fIUv1786Writm3GqvfDCUd/qjttoWDmGYko1AKFc7PP1mbFa3w4CgOXwFdlApHuxfLGRTNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749909339; c=relaxed/simple;
	bh=JqHroRaPIZ1gTIUiaDNbVC4qhhpntCTbc576QHjePxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFzrw5tIzcsFuLUSiuP3UFdw6F/0HdRxFJJP65Me05pPUHO+YcSaMQt4nlLUbr/VEKQwWEHtzzSNQ3dUESuROoOTjCGFv9pTusafSoKgFV13QQabBWaSybRslkQxcR0CzjC14SyPQX3bLgnPynxgW3mR2piivBF5uha9yHMgTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCRC4S0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8614C4CEEB;
	Sat, 14 Jun 2025 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749909337;
	bh=JqHroRaPIZ1gTIUiaDNbVC4qhhpntCTbc576QHjePxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WCRC4S0ks5HmPF3xlz7DZUPn60D0LPazpDN6fXKSrxRazlSJHIJIR41r9LcrEm1hM
	 K7xonPNLfQ2I095IfXuKJrgm3/CHf8ZTyHCpkBZ7TRc+e7KITgGFcfUsZx1r30eVwx
	 u7AeDwgDx5eQBMy+qhzNyIYBbBdbxRvkwLd+NT5TskBzkGTUfxCQU0Uv2fQp1HyJoi
	 rhCUAD9k2puAntilDZNT4tuF92eo9/AO42Xw0wdmhj9QWHsOf/V7DjBw7fKC05WTXl
	 d0BulSgIpsp0UOTUiunl0ajIqIz5V1GpnsI9kYA0yjijGFhDADNeVoeTHt5Z0/LLHN
	 CpZ0i2gc4l4uQ==
Date: Sat, 14 Jun 2025 14:55:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v9 08/11] iio: accel: adxl345: add inactivity feature
Message-ID: <20250614145528.2fb9bf3f@jic23-huawei>
In-Reply-To: <aErE0xmlm4qBHg03@smile.fi.intel.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-9-l.rubusch@gmail.com>
	<aErE0xmlm4qBHg03@smile.fi.intel.com>
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
> 
> >  	if (type == ADXL345_ACTIVITY) {
> >  		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
> >  				ADXL345_ACT_Z_EN;
> >  	} else {
> > -		axis_ctrl = 0x00;
> > +		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> > +				ADXL345_INACT_Z_EN;
> >  	}  
> 
> Now this can be as simple as
> 
> 	axis_ctrl = ADXL345_ACT_X_EN;

That flag is only set in the activity case.  Confused with ADXL345_INACT_X_EN?
(initially I thought you'd run into a bug!)

> 	if (type == ADXL345_ACTIVITY)
> 		axis_ctrl |= ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
> 	else
> 		axis_ctrl |= ADXL345_INACT_Y_EN | ADXL345_INACT_Z_EN;
> 
> Yeah, I don't know how to make the diff better (it gets worse), but the end
> result is better.
> 
> One way, which I don't like much is to previously have this conditional written as:
> 
> 	axis_ctrl = ADXL345_ACT_X_EN;
> 	if (type == ADXL345_ACTIVITY)
> 		axis_ctrl |= ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
> 	else
> 		axis_ctrl = 0;
> 
> ...
> 
> > +	ret = regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
> > +				 (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK),  
> 
> Unneeded parentheses.
> 
> > +				 en);
> >  	if (ret)
> >  		return ret;  
> 
> ...
> 
> >  static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
> >  {
> > -	return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> > +	int ret;
> > +
> > +	ret = regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> >  				 ADXL345_BW_RATE_MSK,
> >  				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* update inactivity time by ODR */
> > +	return adxl345_set_inact_time(st, 0);  
> 
> Okay, in this case the initial form of
> 
> 	int ret;
> 
> 	ret = ...
> 	if (ret)
> 		return ret;
> 
> 	return 0;
> 
> 
> will be better with the respectful comment (as Jonathan suggested) in that
> change that this is not optimal as standalone change, but it will help reduce
> churn in the next change(s).
> 
Worth noting we (reviewers) may well forget about this and moan on
some future version. If we do, feel free to remind us!


