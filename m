Return-Path: <linux-iio+bounces-22089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF3B13753
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 11:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4471798BD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C0222B8A6;
	Mon, 28 Jul 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+MuaV4J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D521CC49;
	Mon, 28 Jul 2025 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693922; cv=none; b=drQjhHkv2AYFW195wf7v95I1KCj7aIKqo1veUbzIL0tkz30zZfwcxKtqxzpYo10AjpbIaGBsafYB07MOkuy2IUpyROddces1u1WTp8LLYFsoHDhiFgskxyIlssyx8WA1bAwEDxCcCsKJsHS04b+xndk/jLO4gT7aryIYqd//aTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693922; c=relaxed/simple;
	bh=0gSQ24/p4HRUPOHRsyobhPrSNgYDn4mi1ZqXF6Iocyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhMQ7vIEw9ovS4BEzDkamIDXAxI0zivRyEYYMbuAIYUx1Fe+mpqWDr2/bVjYEXRGXBv/TNyljT47hmhQU7ksYBRS63zOb1SOnXuA0/JklAKLTZxQA9GCCu6YwoBV4RBb0GKCtbVrPQHCgX7/lCzilfTWq9S7j6U73qw3ws7+0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+MuaV4J; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4f2f2f22c1aso2362504137.0;
        Mon, 28 Jul 2025 02:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753693920; x=1754298720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2SYCb8FDUa9FDjnH8D2qgYFn8gA2NGM9COLDxTOfYjk=;
        b=V+MuaV4JuOd+g7IdWIlC/IGzNu5jzf1gMv8vuoVQkRptpXvQ+1cLTwYaBg1OHP5G1o
         DWIJfzP59WhqPc6qLa1ksmFGNypH8aeqor94/Si0rvNJCOShVGHwKnIgkYBLVGSxzgHF
         a7lAECOX310To1bNPWJMhG3K6EVoBtTrYa19OYxK7zRZM+enr5Ol88UtAmFYP0mJJXY2
         fzm+Pb2qs272QJ60ga5oVDnWZZnqzg9J3DSHmyOCLtTwNd4dQvh++ue63FrvUph7CDQ1
         l8uLrz83XYI6JKqqR5MqFtrPtfyIBDzHltsVtHtgWgXuvGwSVqo4K9FCt49ksGsxiAXR
         Pcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693920; x=1754298720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SYCb8FDUa9FDjnH8D2qgYFn8gA2NGM9COLDxTOfYjk=;
        b=dEPZsQdDPhgWaE4GISw8LYiQ70YDOluJweORJu6+OfnFbZXkWKVBYftrz9+FhEg/Ky
         tG3lKEqjb45AXegNpBrcIch1/M0EzR/AV3U8Us5W4aeQ8wvg+32+j52rDseN4G02qiG+
         hUsljgsFtL1V2netibjlIIr7irS3l7PDFGSkIPnmYfrClcZuzTir7Zv4E8Oq/Ai0gAJJ
         pErurBy4/Y6yIy1r66Bn4elA8nIv9bd49AnPW7kjTlAvyV6nrvugbZyw92/w5cLhk8KG
         RLL3UYDt+pT4iigBw5aOxrcWngIKMHAe5ec8sMJ/55FS4VrmVn18euHifqKquF3NaCIu
         EJQw==
X-Forwarded-Encrypted: i=1; AJvYcCWLyPaxuxDFLIE9tNlH0bSeV0Jb2dvVRGYaAR3MAeb7VAu9wWNcWYPta6I/ybkFubdIhGFh/FurM6fdPJqT@vger.kernel.org, AJvYcCXvAHpD7DDkSgnT0Vc7ddYMLnx9IYIR82Cgoi59pTLBK7idgqRmGxv7ttY9hdRYPx1cHs/w+vt4ojo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2TAc6ygGCRZrvMDY3cP7IEj3c48Prv4q2RCyJt/woiHu9RJK
	6K89E4C3ZXEVlYpEsKig8Svr5y/ICNionK/to1evs9BTKT+u5g711N8D
X-Gm-Gg: ASbGncvUyOrI1Bw9WocLr84ALKw0b97uK5VJw/onOwoxcOQVjmEHymkYWszR7p/Bvg8
	lqIQ/XFrMRdknDjWRTRcufw9WCdUxkvMJpWFgHhiIcJVC0KoE53ntOu/YzCufd7Ws3NAax8RvFH
	j2e1Ho3AO42pVkdstRLMc5fkelyUx0SdpPP7vZI9P4Vnn3lQMZv+qP2GmUVJTG/ZitAKwRrpOG/
	Mk+9AEigZ07FFTJsB47Br/4n3nxbqBgA0o7wb2+J7VIB38/Fz3w1NGyXEisOS7UmkYqEPII28Aa
	IouLM6wLS5mpoRLiSnIIrcxaDNU7muDSC9Uyr3pDgwASBbBdFx3ogHXdc4SNSaSMdyn3qp/cmtE
	nBp8fROfm0CZx
X-Google-Smtp-Source: AGHT+IFJdYInd3vcSVl7Wb2ND0culrX/w/55qkepuhg8Ua3GKi+uUJW0NsjpBP97JmiR3r/zKwpEQA==
X-Received: by 2002:a05:6102:1623:b0:4fa:dd4:6877 with SMTP id ada2fe7eead31-4fa2eb0ce5dmr5919865137.4.1753693920004;
        Mon, 28 Jul 2025 02:12:00 -0700 (PDT)
Received: from nsa ([45.144.113.55])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b8dcd2199sm1229210241.17.2025.07.28.02.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:11:58 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:12:11 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix channel lookup in syscalib
 functions
Message-ID: <nja2lfh3vnmsfvvvl4stxm4n433ktfeftdpb6g6criwslev2bj@ksqx3y7umo3c>
References: <20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-v1-1-b9d14bb684af@baylibre.com>
 <20250727133135.385fa7c5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250727133135.385fa7c5@jic23-huawei>

On Sun, Jul 27, 2025 at 01:31:35PM +0100, Jonathan Cameron wrote:
> On Sat, 26 Jul 2025 11:28:48 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Fix possible incorrect channel lookup in the syscalib functions by using
> > the correct channel address instead of the channel number.
> > 
> > In the ad7124 driver, the channel field of struct iio_chan_spec is the
> > input pin number of the positive input of the channel. This can be, but
> > is not always the same as the index in the channels array. The correct
> > index in the channels array is stored in the address field (and also
> > scan_index). We use the address field to perform the correct lookup.
> > 
> > Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> Seems fine to me and i'll queue it up, but I would welcome another set of
> eyes on this one.
> 
> Thanks,
> 
> Jonathan
> 

The fix seems valid to me:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> > ---
> >  drivers/iio/adc/ad7124.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 9808df2e92424283a86e9c105492c7447d071e44..4d8c6bafd1c3171054c72a0d2b13d6b1afc4e51a 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -849,7 +849,7 @@ enum {
> >  static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan_spec *chan)
> >  {
> >  	struct device *dev = &st->sd.spi->dev;
> > -	struct ad7124_channel *ch = &st->channels[chan->channel];
> > +	struct ad7124_channel *ch = &st->channels[chan->address];
> >  	int ret;
> >  
> >  	if (ch->syscalib_mode == AD7124_SYSCALIB_ZERO_SCALE) {
> > @@ -865,8 +865,8 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
> >  		if (ret < 0)
> >  			return ret;
> >  
> > -		dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
> > -			chan->channel, ch->cfg.calibration_offset);
> > +		dev_dbg(dev, "offset for channel %lu after zero-scale calibration: 0x%x\n",
> > +			chan->address, ch->cfg.calibration_offset);
> >  	} else {
> >  		ch->cfg.calibration_gain = st->gain_default;
> >  
> > @@ -880,8 +880,8 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
> >  		if (ret < 0)
> >  			return ret;
> >  
> > -		dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
> > -			chan->channel, ch->cfg.calibration_gain);
> > +		dev_dbg(dev, "gain for channel %lu after full-scale calibration: 0x%x\n",
> > +			chan->address, ch->cfg.calibration_gain);
> >  	}
> >  
> >  	return 0;
> > @@ -924,7 +924,7 @@ static int ad7124_set_syscalib_mode(struct iio_dev *indio_dev,
> >  {
> >  	struct ad7124_state *st = iio_priv(indio_dev);
> >  
> > -	st->channels[chan->channel].syscalib_mode = mode;
> > +	st->channels[chan->address].syscalib_mode = mode;
> >  
> >  	return 0;
> >  }
> > @@ -934,7 +934,7 @@ static int ad7124_get_syscalib_mode(struct iio_dev *indio_dev,
> >  {
> >  	struct ad7124_state *st = iio_priv(indio_dev);
> >  
> > -	return st->channels[chan->channel].syscalib_mode;
> > +	return st->channels[chan->address].syscalib_mode;
> >  }
> >  
> >  static const struct iio_enum ad7124_syscalib_mode_enum = {
> > 
> > ---
> > base-commit: e4d9886ad25adae72f38f2b12f41649b101581ae
> > change-id: 20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-e28c933ead2a
> > 
> > Best regards,
> 

