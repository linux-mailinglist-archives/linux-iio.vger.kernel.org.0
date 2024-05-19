Return-Path: <linux-iio+bounces-5125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A748C95AC
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DA81F2117D
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0050285;
	Sun, 19 May 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlw/Ln1E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93245C1C;
	Sun, 19 May 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716141241; cv=none; b=pyTOLxVy/Hc3uiQymzJ5FJSmaXpa25dIW9hAGgvMzdScpiW5McRopZKj7snC3NH28Uh7chFKnAq12zSurYEfnBjk4zokEoIm1XBDp2JtNMWhVyDrzrxeQHxRAza+8numPbcx/l7lbALOWhRz88gVKrZf8jts9uV4i8mnEWipdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716141241; c=relaxed/simple;
	bh=Psl6s14Q/uZmJDpMUryavaz13jKlxId6dobvJt+7uwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPBo++lDD4Yd215cEZwDQMjk7U7Qz7bcdydNjZ8mYXZGNaHZqyQf6wjaUm8TnrgdGKqzVLsZbE+j0yODg/8y+vi0ClDO8qHQXoM4AoedZJFRlETZGfG7Hx3SkNsyMIFp9ubQbujmIjhKxcEhH/BK6lqGFJadc3dsOxWrXPXeofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlw/Ln1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05014C32781;
	Sun, 19 May 2024 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716141240;
	bh=Psl6s14Q/uZmJDpMUryavaz13jKlxId6dobvJt+7uwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xlw/Ln1E96E2SMqs8LiQYc+76WnUKrmW+CqtybCn2A21+63KHBRN6S+Y9lGzGRM+L
	 ff368j3o08DxQF8ZX59OD0eqXnZMtVEc0wQSRikYmffP34udzULlq67nXASreNC+1v
	 TirFwXlX2pr45dL5EJFsKVeapGf8mFQZx36WY5zJNIwS0iVq51KukDzBm4yYEMo0m2
	 zUH5lQAq+Q1Mm5GiogT/V4UrsSzHQtKE9p9q9DFaclVL5NCGgwiZ5rKbWUhUi55z2z
	 ZM0f5t3q2hqK2i5K+/Y/wNfEami36chglimbh+0utOs31erQCbo/NR5d6zGEkxvmFo
	 fdJNYuPZCsfdQ==
Date: Sun, 19 May 2024 18:53:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, nuno.sa@analog.com,
 marcelo.schmitt@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com,
 okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
Subject: Re: [PATCH v8 3/6] iio: adc: ad7192: Add aincom supply
Message-ID: <20240519185346.01092b44@jic23-huawei>
In-Reply-To: <ZkNjYZew7Mko7iPX@smile.fi.intel.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
	<20240514120222.56488-4-alisa.roman@analog.com>
	<ZkNjYZew7Mko7iPX@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 16:13:05 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Tue, May 14, 2024 at 03:02:19PM +0300, Alisa-Dariana Roman wrote:
> > AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
> > in pseudo-differential operation mode. AINCOM voltage represents the
> > offset of corresponding channels.  
> 
> ...
> 
> Possible cleanup with the help of
> 
> 	struct device *dev = &spi->dev;
This is a good thing to have as a follow up as it applies much more widely
than what is visible in this patch. In ideal world it would have been
a precursor to this series, but I don't want to delay this for a v9 just
to add that.

Hence I'm not going to tweak this whilst applying.

Patch applied as is.

Thanks,

Jonathan

> 
> 
> >  	struct ad7192_state *st;
> >  	struct iio_dev *indio_dev;
> > +	struct regulator *aincom;
> >  	int ret;  
> 
> ...
> 
> > +	aincom = devm_regulator_get_optional(&spi->dev, "aincom");  
> 
> 	aincom = devm_regulator_get_optional(dev, "aincom");
> 
> ...
> 
> > +			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
> > +					     "Failed to get AINCOM supply\n");  
> 
> 			return dev_err_probe(dev, PTR_ERR(aincom),
> 					     "Failed to get AINCOM supply\n");
> 
> ...
> 
> > +			return dev_err_probe(&spi->dev, ret,
> > +					     "Failed to enable specified AINCOM supply\n");  
> 
> 			return dev_err_probe(dev, ret,
> 					     "Failed to enable specified AINCOM supply\n");
> 
> ...
> 
> > +		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);  
> 
> 		ret = devm_add_action_or_reset(dev, ad7192_reg_disable, aincom);
> 
> ...
> 
> > +			return dev_err_probe(&spi->dev, ret,
> > +					     "Device tree error, AINCOM voltage undefined\n");  
> 
> 			return dev_err_probe(dev, ret,
> 					     "Device tree error, AINCOM voltage undefined\n");
> 


