Return-Path: <linux-iio+bounces-20075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEADAC9BA9
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6036F3BD643
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3436149C4A;
	Sat, 31 May 2025 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8cw/xQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C515E96;
	Sat, 31 May 2025 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748708134; cv=none; b=WsIS5jXpi0gfybGWvNigJYYWa8mY3nRnNVTP7ib8Qjkt2TjOOzEjY1ImvUYBOcFzJTyftpJMn2zakdy3jWsU+wrpoEhfqM/jxuWDJLt9Iuul7R8U84pUY6f+wnOUpxFvOtA54kPlMyBVaaTNTAsvwMF2JTMS9/iyAK3KfWkcXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748708134; c=relaxed/simple;
	bh=triALQDZdrI8N+OpvJBoFVb40OEfCWpbOrTjgR0NXnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HogDLR2SELeQYkJmuA40kysHyYbZdZsh2bpYbhml4TES+0sz0Ej9xAm2HfFbopOkM4mzygmyTbWBcX5cEetIG/AkxO1acfjsEsq054H7Tou27TCbhxFcdmKocPIg7gX89CUN+3gAQ4AEGcQ/8ejNuvo3DjdGTxZzXHQar0jqayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8cw/xQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DF5C4CEE3;
	Sat, 31 May 2025 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748708134;
	bh=triALQDZdrI8N+OpvJBoFVb40OEfCWpbOrTjgR0NXnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P8cw/xQcV401k5Qj6Q11ydVwR0q0Xk/4pK9q22OSv79CcDQBV4k0L7TmMXYX9LKwK
	 6mPYCwT/eFmtnTtmWab4ybLK4McAmUWUMHU7qVlsp+hQmfQgJmDJ7PAYRpD+87KTLR
	 arf/HsvGUtGkiZr7brhsibduwaZ3wtIay3fgumh19vXxZqp+x2GRihfc13F7W/teg2
	 KxMKOulwiFQ9Uy2rn617OZYqDaWL4DUr4tf70bFZFtfT4Gy/MjAI2yKFWDE3wwtSYZ
	 HEaJy/l8KJ4k2Hl4qI9xXZGTPQvMnUS+57LfhaqtTsNM0I3kJzE7sxT8KBW2R+wBMJ
	 NL7r0SHWSf7MQ==
Date: Sat, 31 May 2025 17:15:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: add enabling of optional
 Vrefin voltage
Message-ID: <20250531171527.2b12b2a2@jic23-huawei>
In-Reply-To: <73be8e49-3130-4dcd-9286-689ef55badd9@baylibre.com>
References: <20250530-wip-bl-ad7606-reference-voltages-v2-0-d5e1ad7e6f14@baylibre.com>
	<20250530-wip-bl-ad7606-reference-voltages-v2-2-d5e1ad7e6f14@baylibre.com>
	<73be8e49-3130-4dcd-9286-689ef55badd9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 10:39:27 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/30/25 9:27 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add optional refin voltage enabling. The property "refin-supply" is
> > already available and optional in the current fdt dt_schema.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Tweaked and applied. 

I also added:

Note that the driver does not need to take any actions if the supply
is not present because a pin strap is used to change the behavior
of the device if an external reference is connected.

To the description

(applied patch 1 as well)

> > ---
> >  drivers/iio/adc/ad7606.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index 3bbe9c05b5edbc11e8016c995c6ab64104836e7b..4fd9638eb6e56f800c7c97425e45e04f269e3df7 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -1335,6 +1335,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
> >  		return dev_err_probe(dev, ret,
> >  				     "Failed to enable Vdrive supply\n");
> >  
> > +	ret = devm_regulator_get_enable_optional(dev, "refin");
> > +	if (ret && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to enable REFIN voltage\n");  
> 
> s/failed/Failed/
> s/voltage/supply/
> 
> to be consistent with AVcc and Vdrive messages
> 
> > +
> >  	st->chip_info = chip_info;
> >  
> >  	if (st->chip_info->oversampling_num) {
> >   
> 


