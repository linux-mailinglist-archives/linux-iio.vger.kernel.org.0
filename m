Return-Path: <linux-iio+bounces-14912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2CCA2583E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27DA1889A4D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E446202F67;
	Mon,  3 Feb 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaooIsLm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD641D618C;
	Mon,  3 Feb 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582505; cv=none; b=Xh88CVW30OEHIiws5KQEujdHEqCADoqJeaAC8mXt/yEPMPaBABGC/DQT6v8sJn25z39P5gAHp2Vmx/Bf3NvQsTnQQngaTIx0YguqJg1rKcG8RtKOt1yGix8rLngwT9REnr91rsxNodil8C2jkc/ytgX/OYNnF6Un3YlKy3/SQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582505; c=relaxed/simple;
	bh=ZZC112jheDFQ7cKlLTubHT5MVGGREXP43bHGLV2neSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uonHfeVcuLjbUWy6hM0zheLLBEuOR48jUurL+fC6SoNl119jDz95hw/DZ667qhA2QpGSlcF4I7aSI5cTFkM4+LA+LthtIV+ihzuzflphhIB3FCk2YqjbJCBN615Tnu9DTIPSviNrcN6Eu7O0hgo3CxlmItH+UwsAONPPKHllFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaooIsLm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e9dd985dso39422585a.2;
        Mon, 03 Feb 2025 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738582502; x=1739187302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7kmQU++zCjecKOuT9us00kONsOTq8yKlvsXZdzel4M=;
        b=GaooIsLm+aYxLIlWbWTkYPRstUCuils+aweLCCt8Vv63rQF43I0kiB3zcZ1peUqnW1
         cjF7cbTNPYIV2tsWUbAD4f17yM/pQSfi7gYNvzE2Oq8pLAZOlqlOst6S2lOc3BsPZubN
         EqDlvS4OEEanBMi4XnalIcKplSvlu4c5A3o/kDNx7uK399SptCQtYBKAULXaVjJwB5DE
         2cJCoTCi12w+ic/vldSXPL9tHXmSDyoA26UyvM0P31+kljmiKB/tAOL0UD1rhKiUdFBE
         hjHWFsoT7na4AKwaUV/pV+2/MLG8Wk6BpUOPcvNBef1aN2V08/LHqj9V2xdrhSBJA5rb
         N1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738582502; x=1739187302;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7kmQU++zCjecKOuT9us00kONsOTq8yKlvsXZdzel4M=;
        b=TRI9rsA1OeOO9xNGpauVdVAgiWAsLLcClpUUp84Z77HJ+8i9P+0364cRZHpQmDvh8y
         /w+BSjR7P/k/XR36FvK+4M7JB6aHu8RuJkx84uFj43iNbqNueEpHz5SR41v4C2fznG17
         C0FBxxJnFxxfcwfpImQbesjbxlANJc/9ACIDl+3XaSLgGJM1cs4YnEJp3Y/78hbDa0kz
         XGzcCAiPTMJJivfMxw0h/YRjn1aJt2ayVjTq+4cr1s2SxwIHEWwMAeVfSuArRyw1TVv4
         eMs7tdJ8h9tJASKiAIVHkqmvXopyr81J/2QczVZ+ScDHRkvz8wybup40cV7guRdPhCZa
         jMkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt9E3IeGgCyPg+OdbVrLwISRyusPS912FMDAJb/rHPmXCoVcmqf44EH6vv/tLpZPiWJOkJrtv4xegiHzSP@vger.kernel.org, AJvYcCVk31nVHqNJg4ztGFpy3YI2w9/QrR7xA1aTvS4Kmro09Qvcd+dCNqPU0fqjOC5yIoXAeTUPLKvq9kei@vger.kernel.org, AJvYcCVqJabWsBl8MYr+KSSo170iEQDb35/dbAFd12OzCuuVjw77CYy/l4Drja24DdlbdXkXGW+/A/FtHvDX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65kPbp61555vooAFTBBMPC8rwcJazpUNsUlcGDelrTnTz6iv8
	VhthLmLeHLjLkS4gv69eZBvJ9WLs8igvOHnTN9swHxL4EVwP+tbi
X-Gm-Gg: ASbGncsjBoMkZJQgntunho0e9aVbpxXccBxWWpPd2Jri1Y0TBVafdCOGqqH53/jZO0f
	kZXsN/kspiDKhcumoih/2lpS6pl3jF4ybUBCIdU1JdJIjDU0Us7G/GfBrAjIOC5uKG+jum2FKOw
	Sx35hPBn9Pj49EX9QbBj+JLW7QCca5jMGTg19W29Fz8ttOIkXHgxnHrSwXo4YEVv7NvdGxbEdhX
	5xeWtUVg05RMXIxKqmph+gYHiQVcqI8MxmtkM191xut8JRL1dZPGvnNq4oLxpttBhCPkPHDoJdZ
	Q8/A7CWh9kKvAE1bJ4eHknP3usxehmDIkGEP
X-Google-Smtp-Source: AGHT+IEEDOCixJL7mVcFXUgoPZ/4MU5nuObbCBUqhgV26fSUbJfCWdPgZYYhx8RrS7wapVvBp3Oubw==
X-Received: by 2002:a05:620a:248e:b0:7b6:c405:b586 with SMTP id af79cd13be357-7c009b382f5mr910804685a.8.1738582502282;
        Mon, 03 Feb 2025 03:35:02 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90558csm521006785a.74.2025.02.03.03.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 03:35:01 -0800 (PST)
Date: Mon, 3 Feb 2025 08:34:57 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 06/16] iio: adc: ad7768-1: set MOSI idle state to
 prevent accidental reset
Message-ID: <Z6Cp4ftJCl4F5Tce@JSANTO12-L01.ad.analog.com>
Reply-To: 20250201153103.60675555@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <b99ec75a9f8a47df72a0e8cf126d7e9312ce59c1.1737985435.git.Jonathan.Santos@analog.com>
 <20250201153103.60675555@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201153103.60675555@jic23-huawei>

On 02/01, Jonathan Cameron wrote:
> On Mon, 27 Jan 2025 12:12:29 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
> > Datasheet recommends Setting the MOSI idle state to high in order to
> > prevent accidental reset of the device when SCLK is free running.
> > This happens when the controller clocks out a 1 followed by 63 zeros
> > while the CS is held low.
> > 
> > Check if SPI controller supports SPI_MOSI_IDLE_HIGH flag and set it.
> > 
> > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> 
> Ideally drag fix to start of patch set to make it obvious it can be
> picked up without the rest.  I'm not grabbing it yet as doesn't
> feel like it has enough review yet.
> 
Sure, will do.
> > ---
> > v2 Changes:
> > * Only setup SPI_MOSI_IDLE_HIGH flag if the controller supports it, otherwise the driver
> >   continues the same. I realized that using bits_per_word does not avoid the problem that
> >   MOSI idle state is trying to solve. If the controller drives the MOSI low between bytes
> >   during a transfer, nothing happens.
> > ---
> >  drivers/iio/adc/ad7768-1.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index c3cf04311c40..95ba89435652 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -574,6 +574,22 @@ static int ad7768_probe(struct spi_device *spi)
> >  		return -ENOMEM;
> >  
> >  	st = iio_priv(indio_dev);
> > +	/*
> > +	 * Datasheet recommends SDI line to be kept high when
> > +	 * data is not being clocked out of the controller
> 
> Very short line wrap.  Go up to 80 chars.  If this picks up
> some review, I can fix that whilst applying. If not do it for
> your v3.
> 
Right, i will do it in the v3.
> > +	 * and the spi clock is free running, to prevent
> > +	 * accidental reset.
> > +	 * Since many controllers do not support the
> > +	 * SPI_MOSI_IDLE_HIGH flag yet, only request the MOSI
> > +	 * idle state to enable if the controller supports it.
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
> 

