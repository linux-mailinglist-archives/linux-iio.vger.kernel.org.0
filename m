Return-Path: <linux-iio+bounces-14914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93192A258E9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF781881A0A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06883204094;
	Mon,  3 Feb 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df2rOXWn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436151FCF4F;
	Mon,  3 Feb 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584209; cv=none; b=rfjoSWpiDMZoIg/25tzvFw5z4rjC871IPWbXm3MhPJqmEv1FLkrRNOVfmhkS/YkwkCg7tHmUzvMsI7LCThZSaa/AgRsleLWQ5zI84bSDawvkcAITROZt8esz+K+Dr4w8DdGRsBWl3oJik+KF4pHsMl/wI7gvKL6bonkGdPLC0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584209; c=relaxed/simple;
	bh=FamOOCUFm3NRarEU1KK0g2LOZ/2bn3n/zihztU6lesM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDsrWgcuu+4mGou67NrBFps20xOhrLS3hApShaM3bYGsWl0tJfsFDGssGeApgFKQ9unAYi8oquXphss7a7liN13zQRzcQ+yuLiH30lsIlMU0DCE92QWTL4J4VUAdOZ+Skv3npRX6VGxZ/sv6iaDJgP46zRjAZhgWzhMqLy9lCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df2rOXWn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6fcf01742so40841485a.2;
        Mon, 03 Feb 2025 04:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738584207; x=1739189007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi6lD+pIbfx374l0CnUPRRk4Jv13XwUAHByC02hR2sg=;
        b=df2rOXWnBx9LMpAdaMXBJvX1m6Ohnsj3R0sB5ACknfMi8L5B8bWll2a6zs6j1irJ1E
         B1k3+ZKVnkR6hhGafiJ0Nk8poSGqT8eNpVJDQPxAdouPScaIDu5uU1L6o52+ihU7lDnF
         Z5huQRkn91Dlb+rGewn0zS3BXFqEDVEualWbRP90xTA2HyMkf893ydhzftaOxMTHMrk9
         CjeMciD46gql0U/fF10B0c0RdkvfRCO6ben+dq8haPf2CY/sD+u1yZuCYfHk/yxIRSdv
         e0EIV0wvklSZLUQBwcRuUyEulcsBASN9K2YIyOOVEWAPwUWYhvV8/99SxnDDhyCfHHuh
         f9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738584207; x=1739189007;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi6lD+pIbfx374l0CnUPRRk4Jv13XwUAHByC02hR2sg=;
        b=S/t+FZN/HWbzq7Z11A/mYWwfwDo5q46uZO45fhDw7KkMRjwT2wLsvg9g5ktQzbHCP6
         CX4oum+9QxIZrXj3CDhoORRILAv4NUfTagfyI7z3iZZtKMM97FKnfP7W01FrbCxt44E1
         pfptU6m5EKVAbeOjgUaWtx9Bm13KubWNCjnLjNhIa2KaGsh217OpCrPO8KRym880u+cR
         8ukQGzzuKSLoJChcRyH7zic+hqClZkIM1F9tmdu9PyXhVoAaFSnrFcia36uE+ZbOvb9u
         uzXZO+jDG1eGFLGg3N2NL55oRkXSBMltK0EEJVQjPO7ytKWgMVoE+mdI/AfELFbcWCPT
         +aHg==
X-Forwarded-Encrypted: i=1; AJvYcCVASO9sMHj9UemWyXrUMvbVSQHDVHkG/u/IkBHftlcpSGN1PM5BziTWteWJKeDpoAMtoER+uF3QAT5+1Pr6@vger.kernel.org, AJvYcCVPB/feUINfQNoL3ZfIiriYaAtDm3qPDGfOfpWXKaRlwfhaPb0O/Jo75cNkmq84l6qFR01ezXQo0s9S@vger.kernel.org, AJvYcCWokuNXHyO6u0znO8dlfU5aeVGtGP4Xo8GdJ0a7OzQT+up4OzhIydjn571aS3saRb56oGDOV4UJ/X4N@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rVtkgid6JNVMRbsQ/FsTne3vBk8HqyY5d2cVpsHYoB+psjeG
	NHL4p7M48sWifv+Vgv+wK6Fz3bt0xO87sXDk3lDgXa121kYiI398RDwNn1b4UlU=
X-Gm-Gg: ASbGncunvlV9G67YjNwCgxbOW4680wcOMOQO81VBoKeJAsFBnA3nk2Cft8AyxY8l6Dv
	/gQo6zEGYucr2iucmpuUVc30m0wrnP88X3TU3DO851UvZYlhbzzM0yNYhsR0CahOf/oVVE7eigg
	cmI8OKl+cxi7q3r5+BMw9fHrE+67AYWQSrWgTWVA53zvs1aCgK+TB1ILHtUmQS0e1IogE2v8sBz
	gONWXUSZ541X5RaepMMBtqsEAq1U9ow8nsEWI/iTULlSertulZM5OmfcfKC335qmW1p/4Zaxt3v
	XugStRr+dW7i87+DlxJ/Aj7b84beCzvPTb++
X-Google-Smtp-Source: AGHT+IFoAGBvXqmeHO1EF/ECKXnY77Xf5B6XwoV6dB0M6LSTKJWD748ue/S2nHch2ISm+35takjgrQ==
X-Received: by 2002:a05:620a:394b:b0:7be:3cf2:5b46 with SMTP id af79cd13be357-7bffcd08abcmr1159991085a.8.1738584207012;
        Mon, 03 Feb 2025 04:03:27 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bb957sm517156785a.14.2025.02.03.04.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 04:03:26 -0800 (PST)
Date: Mon, 3 Feb 2025 09:03:21 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 10/16] iio: adc: ad7768-1: Move buffer allocation to a
 separate function
Message-ID: <Z6CwiaEhudvbbbT7@JSANTO12-L01.ad.analog.com>
Reply-To: 20250201153539.5617b5b8@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <e39115cee88524f05c8a628b0d3836928c6cc190.1737985435.git.Jonathan.Santos@analog.com>
 <20250201153539.5617b5b8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201153539.5617b5b8@jic23-huawei>

On 02/01, Jonathan Cameron wrote:
> On Mon, 27 Jan 2025 12:13:19 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > This change moves the buffer allocation in a separate function, making
> > space for adding another type of iio buffer if needed.
> > 
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Jonathan, this one needs your sign off to reflect that you handled
> the patch as part of it's path to upstream.  I can't apply
> anything that is missing such SoB.
> 

Sorry about that, I am fixing the SoBs for v3.

> 
> > ---
> > v2 Changes:
> > * Interrupt and completion moved out from ad7768_triggered_buffer_alloc(). 
> > ---
> >  drivers/iio/adc/ad7768-1.c | 44 ++++++++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 5e2093be9b92..8487b9a06609 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -599,6 +599,31 @@ static const struct regmap_config ad7768_regmap_config = {
> >  	.max_register = AD7768_REG_MCLK_COUNTER,
> >  };
> >  
> > +static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
> > +{
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
> > +					  indio_dev->name,
> > +					  iio_device_id(indio_dev));
> > +	if (!st->trig)
> > +		return -ENOMEM;
> > +
> > +	st->trig->ops = &ad7768_trigger_ops;
> > +	iio_trigger_set_drvdata(st->trig, indio_dev);
> > +	ret = devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->trig = iio_trigger_get(st->trig);
> > +
> > +	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> > +					       &iio_pollfunc_store_time,
> > +					       &ad7768_trigger_handler,
> > +					       &ad7768_buffer_ops);
> > +}
> > +
> >  static int ad7768_probe(struct spi_device *spi)
> >  {
> >  	struct ad7768_state *st;
> > @@ -669,20 +694,6 @@ static int ad7768_probe(struct spi_device *spi)
> >  		return ret;
> >  	}
> >  
> > -	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > -					  indio_dev->name,
> > -					  iio_device_id(indio_dev));
> > -	if (!st->trig)
> > -		return -ENOMEM;
> > -
> > -	st->trig->ops = &ad7768_trigger_ops;
> > -	iio_trigger_set_drvdata(st->trig, indio_dev);
> > -	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> > -	if (ret)
> > -		return ret;
> > -
> > -	indio_dev->trig = iio_trigger_get(st->trig);
> > -
> >  	init_completion(&st->completion);
> >  
> >  	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
> > @@ -696,10 +707,7 @@ static int ad7768_probe(struct spi_device *spi)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > -					      &iio_pollfunc_store_time,
> > -					      &ad7768_trigger_handler,
> > -					      &ad7768_buffer_ops);
> > +	ret = ad7768_triggered_buffer_alloc(indio_dev);
> >  	if (ret)
> >  		return ret;
> >  
> 

