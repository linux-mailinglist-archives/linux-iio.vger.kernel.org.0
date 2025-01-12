Return-Path: <linux-iio+bounces-14149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4658DA0A6B1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 01:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E701A3A12BF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 00:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194CD4A35;
	Sun, 12 Jan 2025 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdVKmThT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C97819;
	Sun, 12 Jan 2025 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736640062; cv=none; b=sIoXIkeSC/wyygFsmPo+8+LsF0jKYLuLB9asieHVyb/wZZI9WiYrDNnJ9cnZYaeGArH6ZtiMUh3/TiLSe6ioqa4P4EPyCgF0JHKBUsySfczuCUYoQJ6M85p6e5hPie+UXwfsS4+b6GNE3mHs4ZSNLkL3Jpjc8swgx1nBiESiWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736640062; c=relaxed/simple;
	bh=FxH0cllwR1HPI/Hq0JZ72sZwNkw/QzoeKvTAn9qTgNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5irTiQkdWq7v/BN3b6R705t5jCbvY4e/6DIa5cCvQJdRyoXUIZol6r0InGoSM+lvL5P1kYvNEP9r5hSrF2rizeVM6FXtQZ/8vWGedK5siNvmddcvze8UMiSSDt2Va9jm7RIvZFgbQZN1UDqsEAdPNhcl3dojd8519kZXyZstBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdVKmThT; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e3c7117e8so69521a34.2;
        Sat, 11 Jan 2025 16:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736640060; x=1737244860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViMxrOr6TBlIcv8Q9XOTTtXutX4mRftVRSACLwo6Z9c=;
        b=WdVKmThTooXV6uj0yFupgVv08MOHUqgx71lhHLOsZS2iKaWM+y6TEMKrsnHZZxgam/
         7fsnza5ICjMRfrM2Vfquwb3WIctyj9qbrA/FKabFNCV/X1iX2D9hnB6zsTr+h8TsMh3m
         Euus0UGl/YSb7zU+45ios2eCwEMBzidASuRGm1GuIDa/9d5TIiLHgYbPxr/P5jXQ8Da5
         5zCiek3uBOWBv1Mpl4kL9N5zBJE2BU97ZKOP4wXkr72+bvwhQ5q0EZFcFRSJwhEkT0pG
         Y7iaPnsOTWANA3oaDC80IFg5MOyXZlaXht2q6mVxLSGEusBmhyZCaC+4fWnGc+KkR5R0
         JlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736640060; x=1737244860;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViMxrOr6TBlIcv8Q9XOTTtXutX4mRftVRSACLwo6Z9c=;
        b=mKu4k6Vx6FZ/dUj3WkkwDaJRBqB5Ensp2ucnZa0Z3cMyDXJGddCqyiwjSzvqLvFgjI
         LoA3bBJ2OiaMwDB+tyQvI2JOMLGgRrar88rPYpJKFWrmMY+y/ujERIVcH2NErp6klwjj
         4orP9HaolBxj0IWGIz7FvSQg5FQuRHNq+a8t+lUC9HaEpI0TH58lzJYD98icBQTuYkub
         oZuTkdhTQW5DQujg7EeT5sFpuC06YXsB6+2qf79/i/tUgYcutoFiAj7AaPX2fY9oZjJO
         iqvcsJ9mMU+OiZ7WCGSIqnqu5bGHWj9wGOg6KUstBRvc2BzF2QAtd3OsbE/9WHde96gg
         rHxw==
X-Forwarded-Encrypted: i=1; AJvYcCU1UDkicvxnxGUctiuCJm5+7wdOjMK6NcfvMeT5nyZybcy+lApOh79HGXQ0uIsYV0sSFwkP4A5Gq+y4@vger.kernel.org, AJvYcCUrbJdrOUjwYvwZlX/TQpOxTVahblsGpkOcm35ESxaXoGwJDZpqq/iapwL5bg3jCXpxdH99vgsa8mLoPvXL@vger.kernel.org, AJvYcCXshqeRMgt3bDJMi3+N1UdiabjLvq3tkg8NyQX+GEssVfcOS319cOaB7stR0sFHA167mTt0SJBQCdV1@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmZp63AV/Lugjjrqr0W7P6EvNnY440ashXNJcpVZxYD289zjt
	TRdW61lWpwE0J+rsqYzDFiaYGf1g4y4HhJfu/h2Jk/ZqHZ9zLlQ1
X-Gm-Gg: ASbGncsVwJA6+Yst2gQttpek4y2HMPM1zhUgFsgyL25iVN3VKvU0Swxf8EIZlPmCYoT
	GA773TctIweCFN/tivkeQ+K+USQYxtjPs8lgBHafXlPWpg8+UpX8Ql3M9PLCAD8rVvHKabZNWYx
	d9WGLH4iJK5s3Y7ZWlEtHm0ETBEIi6qstso9gCQhqXK2cbDEK8b+H12loSgDxkjw9zqP7O+cgJe
	GmEf4LO6+fBkbHA6/MUve9jSdy6qHeaMQcC83X28nCxOJ5aqr7FUmxRjfEh74KiUSsRzljPqc2e
	iw==
X-Google-Smtp-Source: AGHT+IF1Fq+N/UGakrZ4h80jKryj7M8L1Vv+uvDDr3m1UkvGL7n9zUVHCuXf3m932Y9dipoGq5dkiw==
X-Received: by 2002:a05:6830:6118:b0:71e:af5:4981 with SMTP id 46e09a7af769-721e2f29f30mr3386140a34.6.1736640060176;
        Sat, 11 Jan 2025 16:01:00 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231862a38csm2136656a34.68.2025.01.11.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 16:00:59 -0800 (PST)
Date: Sat, 11 Jan 2025 21:00:55 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 04/15] iio: adc: ad7768-1: Fix conversion result sign
Message-ID: <Z4MGNyDTMj0JBGod@JSANTO12-L01.ad.analog.com>
Reply-To: Z4GWpjnAoRKtexz2@debian-bullseye-live-builder-amd64.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <e521bb5cb60d413edbcd1ea582fd81073218eaf5.1736201898.git.Jonathan.Santos@analog.com>
 <Z4GWpjnAoRKtexz2@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4GWpjnAoRKtexz2@debian-BULLSEYE-live-builder-AMD64>

On 01/10, Marcelo Schmitt wrote:
> On 01/07, Jonathan Santos wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > The ad7768-1 is a fully differential ADC, meaning that the voltage
> > conversion result is a signed value. Since the value is a 24 bit one,
> Hmm, I think the reason why we sign _raw values should be because of the ADC
> output code format. There are differential ADCs that can measure a negative
> difference between IN+ and IN- but outputting straight binary data format (not
> signed values). In those cases, the _offset attribute is used to "shift" the
> _raw value so that output codes that represent IN+ < IN- are adjusted to a
> negative decimal value (the _raw + _offset part of IIO ABI to get to mV units).
> For AD7768-1/ADAQ7768-1, the ADC output code is indeed two's complement and thus
> signed so the code change is correct for it.
> Since you are probably going to re-spin on the patch series, will be nice
> to adjust the message to something like:
> The ad7768-1 ADC output code is two's complement, meaning that the voltage
> conversion result is a signed value. ...
> 
> With that,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>

You are right, Thanks! will do that.

> > stored in a 32 bit variable, the sign should be extended in order to get
> > the correct representation.
> > 
> > Also the channel description has been updated to signed representation,
> > to match the ADC specifications.
> > 
> > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > ---
> >  drivers/iio/adc/ad7768-1.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 113703fb7245..c3cf04311c40 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
> >  		.channel = 0,
> >  		.scan_index = 0,
> >  		.scan_type = {
> > -			.sign = 'u',
> > +			.sign = 's',
> >  			.realbits = 24,
> >  			.storagebits = 32,
> >  			.shift = 8,
> > @@ -371,7 +371,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
> >  
> >  		ret = ad7768_scan_direct(indio_dev);
> >  		if (ret >= 0)
> > -			*val = ret;
> > +			*val = sign_extend32(ret, chan->scan_type.realbits - 1);
> >  
> >  		iio_device_release_direct_mode(indio_dev);
> >  		if (ret < 0)
> > -- 
> > 2.34.1
> > 

