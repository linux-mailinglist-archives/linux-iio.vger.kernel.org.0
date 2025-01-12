Return-Path: <linux-iio+bounces-14153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4AAA0A702
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 03:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F413A7E53
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 02:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207FEEBB;
	Sun, 12 Jan 2025 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4f5JOri"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC0139B;
	Sun, 12 Jan 2025 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736649739; cv=none; b=U8w9Wv/+mhJi+p2cZW4c+Dd8ewNczQGyGjyNevw356TONZuR19ERz3XwPvD/YiYdQCfs0HzLd9+0ITThHzK38CkUQvQaHsBOwvrcseV1ATs5qKhIzwv+KkqCus6U0Jc+t7r4M6R7TGIKckD1AriN5KucJL2PKgtj/+bSSP1yFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736649739; c=relaxed/simple;
	bh=sLPNNzafKv0wKQ3d5oB+jBdBTdI1YNvAiD2Xs9OxTTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBaIJb/qq1KGCaJaWWyeVZch5wvuNYnBT6fO0tAi6jkrWGGjFiWMFVbBzKZS330hUgIvmf1Z+/Xn/5VB146rF4vPXMoCTy1lmX/puU5375MrSQ9v9t92eURqRTNH4WgaQoBrMNzcCHa0OSORTbIAtaoqZTpGejwGnGm3n46OMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4f5JOri; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ebc07d3d0cso274162b6e.0;
        Sat, 11 Jan 2025 18:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736649736; x=1737254536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddya6DNVBks0IBmVUJBafyuBzSAD5GZrC3K5vLvyXBw=;
        b=c4f5JOriYjCBfxAwpWK5hgPqQRDM1jMKplr+iAIHEspdEiPyRZiIrEVBLoyOROoj+a
         lAZbpm1QLTT0bhWvuY3l5fkdhv314NPsn2XoikoGVJMhsfhBspfZu1OMxU/ZAWlbW+VP
         vcyyGwSk/VqMCmk4QmgBJiOhYVfAVs/ybbsb3E0qHBhKdJRu0XZd1Zng56+ajeUNctHj
         3Vg/U/xT429QqJZx+zZpsdSaFXEhT9WOVvjm7JWwwJPYPQtu8RNxAdNLmlrR5J3wp4L0
         OXc56iAuy9xfAflR9lGWsl2Lzura8bJb3wRvWTfzwkjWbTXiwOeSvWeaKYxgmZ0MfzvP
         8q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736649736; x=1737254536;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddya6DNVBks0IBmVUJBafyuBzSAD5GZrC3K5vLvyXBw=;
        b=he/knjlkgG8kirHHkrdr9yq+ml7DXEl/61Fq8Lu53W6mMNZ9DYsqgm3dPcajVaK61D
         JgjO8+2IE0lfghmDeD9uWJ3KoY7X1Fpx8biwhbCz49UxA5+/fjUKpo/H4I2B27kNYg+K
         Ba8H0R6li/HTUgVQKIX5BXcaU9pnUNTbac0exP4JebfoxRK9TuTFy66ETcaVGLafJtkT
         utUDcqCEJB63pcpusD+2N2tSyzg4WOZ2xxJT6wlIeJTewC1NG45iYc1Lk/4QZXz0F7J5
         xv5n3aVPi1MZ9nbqF5MmmeC+0YKA5GLDYSqRty9V46u1VD/VSCUMV9p1FTZ9f/hfU3e6
         Qo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3yOQYqiCUhfruifxC7Fj1WsuLotXDNRCQCgbjBAVVdl7P4MaOSLQhBgUEQd/eThJMi+R+OP9YmFnb@vger.kernel.org, AJvYcCV5mtggnScRnU+KyeRESS/MKCwsyI10P9lsPdPdrVs4HbINDGSBBbMeFxqymkvQ7dTgaASb39YKcUpHBBm7@vger.kernel.org, AJvYcCVrwDNPaCCHY3a3O82vExQHkFRkBpJ5gFvKtBuTHcFgxiBjdhgy4LHmqHSy4EFkq8oJCIJbBt3+AMev@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNK5RR8GtHaRp1P8C0SPAgRwFxslPNIxTlY32p/re6WbqA84V
	JexXqV14LAoz7KPGCgSSKrfWfEeS54ynqm8ruChqh2chNumtcCKk
X-Gm-Gg: ASbGncvn28EURYZv1JXnvIuwiE1JLL3tOZLVwsSyOhDyeIPpfOfldjNfSZyp5qOP9yL
	EtTywiwtxHqfXpSHshr27F2fMm698kWKzq36QMfHbhGQb5ziStoQ1NSbisfYx/dQOH1oug+jjww
	VdvahIOCNFycjScP8ux7hM6w9ONNwAyJ12DDPGUapNIbR4SvOvxSOFBSPvQccNwc7kw1xksWf47
	Lgfs8AjdIo6C6ahCWQwpTesVPQCMqKaRuUS+CX/vz2k9NzU6e4CS/aVy1bT1BH76jLaIGaL6LF4
	IA==
X-Google-Smtp-Source: AGHT+IH7XpI1vFbwS945BK/tGi8JAQicbaWr1r9zqNi4f/Uy7FIwTYmbyU0H9JBsxyRtXKGuSA2PUw==
X-Received: by 2002:a05:6808:144d:b0:3e6:3867:b8c2 with SMTP id 5614622812f47-3ef2ebbaeacmr3512614b6e.2.1736649735899;
        Sat, 11 Jan 2025 18:42:15 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f037612434sm1983410b6e.3.2025.01.11.18.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 18:42:14 -0800 (PST)
Date: Sat, 11 Jan 2025 23:42:10 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 11/15] iio: adc: ad7768-1: Add reg_write_masked
 function
Message-ID: <Z4MsAk0BtpbgGgaW@JSANTO12-L01.ad.analog.com>
Reply-To: Z4GgdxU-EuR_xYrJ@debian-bullseye-live-builder-amd64.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <67649c43050d161621bc0494638bfa71fed82ea8.1736201898.git.Jonathan.Santos@analog.com>
 <Z4GgdxU-EuR_xYrJ@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4GgdxU-EuR_xYrJ@debian-BULLSEYE-live-builder-AMD64>

On 01/10, Marcelo Schmitt wrote:
> On 01/07, Jonathan Santos wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > This commit adds the ad7768_spi_reg_write_masked() which is a helper
> > function for writing specific bits inside a register, without interfering
> > with the other bit values.
> > 
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > ---
> >  drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 574d735f2c3a..675af9ea856d 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -242,6 +242,21 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
> >  	return spi_write(st->spi, st->data.d8, 2);
> >  }
> >  
> > +static int ad7768_spi_reg_write_masked(struct ad7768_state *st,
> > +				       unsigned int addr,
> > +				       unsigned int mask,
> > +				       unsigned int val)
> > +{
> > +	unsigned int reg_val;
> > +	int ret;
> > +
> > +	ret = ad7768_spi_reg_read(st, addr, &reg_val, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return ad7768_spi_reg_write(st, addr, (reg_val & ~mask) | val);
> > +}
> > +
> ad7768_spi_reg_write_masked() should be added together with at least one
> user of it otherwise it leads to build warnings.
> Though, better if able to convert to regmap as David suggested.
> regmap_set_bits() and regmap_update_bits() come for free.
> 

I also think David suggestion is better, i will convert to regmap. Will
make our lives easier later as well.

> >  static int ad7768_set_mode(struct ad7768_state *st,
> >  			   enum ad7768_conv_mode mode)
> >  {
> > -- 
> > 2.34.1
> > 

