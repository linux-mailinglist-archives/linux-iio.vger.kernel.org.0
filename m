Return-Path: <linux-iio+bounces-17469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F00A766AA
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 15:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B30188A658
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1848211466;
	Mon, 31 Mar 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea0CNQcW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2B154426;
	Mon, 31 Mar 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426973; cv=none; b=WAR4/ckvfJSZenD++DfAPfsT/8R3eMCHXowP0zr+oRS+hFYfyb8pusqK4HViupOvaMXpJUu65yppvV7rikrm64oLmpA6A5uLABvwq4PS1yVtozgwbFlBtuSbfyo9au50oD8CfdeRrRgChaD4uXKQCZNKa3epY9XmF0hZY4zQb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426973; c=relaxed/simple;
	bh=rWfEuNwcKHtCIL0c17eLn20Nora+MC+za1Oc/I7rVtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+ol2RoEx06ioZyqb3b/hqSRcmqRqaPgxIVkkFpfVbNy39cEqRrMnX39rXF+s6yGRIi9u+rId4mjSa+F/3IQuiUUcKPp8UFyRlG1Bn6+UCH0ukoiFsXAjzZpUezT9zaAjmTcw3ItEiMXQxTpPqb493vcKGnb2XM6A8/Q8QgOH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea0CNQcW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47745b4b9aaso7614631cf.0;
        Mon, 31 Mar 2025 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743426971; x=1744031771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEdh5n3v4O9CUTz4DVjNN2gzKd4SqkS8/2Z3RLisCe0=;
        b=ea0CNQcW0CyfWUTnomWolxZxmHVcm2diiQilOKcJUnw1ddJPUWC1OySI7D2nD/kyjf
         kli6OZhOZFqQsGsexLjjiL0DJp0HFuTNJrOy04/lDXTdu4cfApTd29D+drgY9CspxPdF
         IHVRJxUMGOHHmv4gmmpPzqf5PiqDUpsF/axWDZjF9511azLccUN6pcO4dsy3mU1T2TJO
         M8VCqsqcibFaa40jsCN62JolupJ87igvfRbcVeO0tHjrcWZfZNonK5e3KFi2FrSwUoGu
         JhMuFqSKVig3B134NOh/FoDaUwzT/bD7fSiJsR9VFV/9P1iU5g9dF37kV0a3LPQzbZjl
         rVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743426971; x=1744031771;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEdh5n3v4O9CUTz4DVjNN2gzKd4SqkS8/2Z3RLisCe0=;
        b=W8xoRJMTnnmIxQorDZfg66xiefohPwJp5AYl4KU2X87CRN2zOz4x1JvSlVSrX/iw0U
         573pOUmrNdvR6aMJ9Vej+CPnvk7NNjhg3nmpwVoTRrkyeoVKGC+FkWGAYKEZ2Nwq6pLc
         rymkbQAIPOOkfEqaJureDF54/XQpyDJvyDvm/wSx4xOCbTpzexv8tIPSbswUqZ2HY3nA
         FFo7CvqzNRgt1TXES5NMzOaKwSwC0LtQD0yOS+u6i0hFDB37CxhkF8l6nJe9E46MdMqs
         +XIOuLxhauTdiUOPaL2+wr2g5MzNiW3snP/5Z5guYcXbk78zbFHYyx4sVoX6ubzALmCq
         h5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUP7AgGE9JZox2sH8BSD/HiK/0OfEpcWiFU9xbXTB1U/fhCexG7yJ6v/ujtXFn3YKKzoLTmQn/+McJq@vger.kernel.org, AJvYcCVUaYhFY1RwhbgiCFBltvPP/fo2Xnp/fdlKtP1D4oXzNVWplG+Jyln0Jq9c0yGShFb2IV8Alb0FZE2UzQ==@vger.kernel.org, AJvYcCVjLZsFxaxhEKIgcMfRKf/SPbGrsf5aXP4bJjfcH2tDF30pbw5/daEVkVPA/HbdjcqoGssFKrhYLuq436mm@vger.kernel.org, AJvYcCWXgvlQwPdIMEB/fL5m7uJTEMBK+FaacYQero/RyQDpSiR9dmCkHfpQU1r1CUDYAJnV6LUmX3iBhjZD@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDUfDOjoGAZ3CGMPNNo3M1Kj907EIzbgEeTVFAAT1jk887SMf
	0LDt0C05kmzwm067BXubc8+U+Ra+ru9eySWcp5r04Aftg1VqgFdi
X-Gm-Gg: ASbGnctnYG+tCbGWzBGb5OhT3mlbvRMkrssj21v9ng6UoRmrkn8Z7XoCak2KY08vT/8
	4eg5t50ky2aOfJWIECmjJ6ahsIR0srSZAAbSbjt9Z2/1hR/H6bpoKtxclAW49VRo+DY+Khanlwn
	j5SDbrhWXIfH+Zsb36h49W9k3+aU8wr/bIvNS94I7bU7ORx0j9z55pnDOEaZEjqEYuQU53EWhF4
	XSZyl+mJCZ/bHelwH1tUrngM6R3wSP3td7HEcYg0ql5Ka9b5lmpLPTZl3sjTTXxYreSdJqLCXz1
	/QBoa2CO4/8qDB8rByiE59IFGfdkhTwPpXsBYD7BaH16NlDUhw6tmN6Jd/RXYrvoIA==
X-Google-Smtp-Source: AGHT+IFbQB72U31Q4YJeUMQOLjGE1lX5Y09sxOvcCF0DSUNo9Di2my+wxe5+TnGGeJSgg6MGYVqeAg==
X-Received: by 2002:a05:620a:29d6:b0:7c3:c406:ec10 with SMTP id af79cd13be357-7c6908c8bd4mr476835885a.14.1743426970925;
        Mon, 31 Mar 2025 06:16:10 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f765f94fsm498470285a.20.2025.03.31.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:16:10 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:16:05 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v4 02/17] iio: adc: ad7768-1: set MOSI idle state to
 prevent accidental reset
Message-ID: <Z+qVlYCj5G6j3FIS@JSANTO12-L01.ad.analog.com>
Reply-To: Z8rhWLz32fdySDyN@debian-bullseye-live-builder-amd64.smtp.subspace.kernel.org
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <c2a2b0f3d54829079763a5511359a1fa80516cfb.1741268122.git.Jonathan.Santos@analog.com>
 <Z8rhWLz32fdySDyN@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8rhWLz32fdySDyN@debian-BULLSEYE-live-builder-AMD64>

On 03/07, Marcelo Schmitt wrote:
> On 03/06, Jonathan Santos wrote:
> > Datasheet recommends Setting the MOSI idle state to high in order to
> > prevent accidental reset of the device when SCLK is free running.
> > This happens when the controller clocks out a 1 followed by 63 zeros
> > while the CS is held low.
> > 
> > Check if SPI controller supports SPI_MOSI_IDLE_HIGH flag and set it.
> > 
> > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> 
> LGTM
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> > v4 Changes:
> > * None.
> > 
> > v3 Changes:
> > * Patch moved closer to the start of the patch set.
> > 
> > v2 Changes:
> > * Only setup SPI_MOSI_IDLE_HIGH flag if the controller supports it, otherwise the driver
> >   continues the same. I realized that using bits_per_word does not avoid the problem that
> >   MOSI idle state is trying to solve. If the controller drives the MOSI low between bytes
> >   during a transfer, nothing happens.
> 
> When you say nothing happens if the controller drives MOSI low between data
> bytes you mean the data is still good in that case? Just trying to understand
> the device behavior.

Yes, it means that it does not affect the buffered reads and data is
still OK.

> 
> Thanks,
> Marcelo
> 
> > ---
> >  drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index c3cf04311c40..2e2d50ccb744 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -574,6 +574,21 @@ static int ad7768_probe(struct spi_device *spi)
> >  		return -ENOMEM;
> >  
> >  	st = iio_priv(indio_dev);
> > +	/*
> > +	 * Datasheet recommends SDI line to be kept high when data is not being
> > +	 * clocked out of the controller and the spi clock is free running,
> > +	 * to prevent accidental reset.
> > +	 * Since many controllers do not support the SPI_MOSI_IDLE_HIGH flag
> > +	 * yet, only request the MOSI idle state to enable if the controller
> > +	 * supports it.
> > +	 */
> > +	if (spi->controller->mode_bits & SPI_MOSI_IDLE_HIGH) {
> > +		spi->mode |= SPI_MOSI_IDLE_HIGH;
> > +		ret = spi_setup(spi);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> >  	st->spi = spi;
> >  
> >  	st->vref = devm_regulator_get(&spi->dev, "vref");
> > -- 
> > 2.34.1
> > 

