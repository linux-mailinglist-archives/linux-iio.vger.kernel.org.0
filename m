Return-Path: <linux-iio+bounces-11601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A154E9B5F96
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 11:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A6D1F212D5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBFF1E2618;
	Wed, 30 Oct 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgVPRn2g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF105194151
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282287; cv=none; b=dNFP8HiwtE3rlC6YNUrGvLcLRoAK9+w/c7hvUOJgytgcMZ0Hy6lPOnYtrR+Z/6+kpn+K+MaxCXfHsTEfDiJBoA694onSjqf1cVhV996nIs0tbtIJhCNBlGzo7C79PhHNP1mJoMvT38NxltEk6QR1E6SPxPcZ9TRnKVGxYUVcVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282287; c=relaxed/simple;
	bh=cdblxGztPJzu5+WvkgT/n0QsNB1ieq4mA/SuIyCDBzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieEXMnRQk2l7trl08NDrdI2YKN38Uf91cVhfWEOIK0lK+PuOA6VR/sTzvaZgW7mlgAF5N0FJ/vJm7MGPiFd40ElZxHhaxQ73FFtQQV2UrFGxxiuEHrk0q1mufzzOcaH724dUAiq+CY8nq3MeEf0d2VYWP7TbJrS+7Kpy+AFUgE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgVPRn2g; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso940922566b.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730282284; x=1730887084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vl6lnQTwg90A2yjCJ5XaXJgbf18xnHCYTZ+Gnq0N/NA=;
        b=hgVPRn2gI8NGq2+FlupbqC1+ruweaCwG8NNMDpQX3MEDZaSHnzImqxi7ICKw84VV5B
         EJb+lyZd/6oeh6WltlV990HgjAD+uZrFikYwJncPLsmx+P3nQciIsy9bYLkpNUkPoWeB
         xW/ymN0/+OjNXgXvt6yiFi+il66Y5coV+m4MARqpfnImU4URwYK0+o83ZXqd1RLag+6e
         Sqg5vZwEO1Ln8mKwCnc955jZI51uuLSXoX77lNDSExWebx4qiAHl7fOP977nBmmVLyje
         O0yPp7i5hbwIYC6pF8jlVGPaITWu6NaHgV8fMViS+tzUJ970MADS03c17QQqLjN7Ur1B
         bxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730282284; x=1730887084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl6lnQTwg90A2yjCJ5XaXJgbf18xnHCYTZ+Gnq0N/NA=;
        b=h0kkwyQLks1MppngLTqoF9WRtdzdU2bVDqCO8cX768rRGFE2iCud6/WTZw3b2QKGzi
         91k6btz7R3DSn64Qu+5xu9GtQJCgB2quG+CnciypjMpnIQs1FiNIBdR6a5nX1krOFiTq
         2P5vey5aPYcrv6N1cRe6jSWcGkk3X6XPDKy6jC3twZsR315/v9z+P4Ir82VWzif4XRQe
         615Hzkhp8Yj16JUgIPXwkt+Gf4RcecsZETUqrcq2UdG6Kx6RIyaASIEdksIzFupsNFpR
         OURVkLHhWNIVExXrvODMj8KMVHmrJmPJGiW4A7Yk6+kiLu4p8AbbrC67YoU63GPs+kns
         6GDg==
X-Gm-Message-State: AOJu0YzNsvhQqkryMa5DP6ShPj2lCnWGoJE30c5oPHqu+EWXfBUoi35e
	cTqhQz8iPDgd9CzBK2Zx0LH15N1/hjYwKSJm+03CnohUHeokYvOk
X-Google-Smtp-Source: AGHT+IFuqoK7gE2fVjx5HU21eoL42aC6R+KG9W34nhXCLCRPgtWQUZyJxURKIFt19QH+1cxyrWYYgA==
X-Received: by 2002:a17:907:7d8d:b0:a9a:1e4d:856d with SMTP id a640c23a62f3a-a9de5edb084mr1454777166b.22.1730282283835;
        Wed, 30 Oct 2024 02:58:03 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0298fdsm557179866b.54.2024.10.30.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:58:03 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:58:01 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: chemical: bme680: generalize read_*() functions
Message-ID: <ZyIDKdX7NKopqT4W@vamoirid-laptop>
References: <13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain>

On Wed, Oct 30, 2024 at 12:26:13PM +0300, Dan Carpenter wrote:
> Hello Vasileios Amoiridis,
> 
> Commit 9b4071ab8cbe ("iio: chemical: bme680: generalize read_*()
> functions") from Oct 21, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/iio/chemical/bme680_core.c:760 bme680_read_raw()
> 	warn: passing casted pointer '&chan_val' to 'bme680_read_temp()' 32 vs 16.
> 
> drivers/iio/chemical/bme680_core.c
>     738 static int bme680_read_raw(struct iio_dev *indio_dev,
>     739                            struct iio_chan_spec const *chan,
>     740                            int *val, int *val2, long mask)
>     741 {
>     742         struct bme680_data *data = iio_priv(indio_dev);
>     743         int chan_val, ret;
>     744 
>     745         guard(mutex)(&data->lock);
>     746 
>     747         /* set forced mode to trigger measurement */
>     748         ret = bme680_set_mode(data, true);
>     749         if (ret < 0)
>     750                 return ret;
>     751 
>     752         ret = bme680_wait_for_eoc(data);
>     753         if (ret)
>     754                 return ret;
>     755 
>     756         switch (mask) {
>     757         case IIO_CHAN_INFO_PROCESSED:
>     758                 switch (chan->type) {
>     759                 case IIO_TEMP:
> --> 760                         ret = bme680_read_temp(data, (s16 *)&chan_val);
> 
> The bme680_read_temp() function takes an s16 pointer but we're passing a s32.
> This will not work on big endian systems and even on little endian systems, we
> haven't initialized the last 16 bits of chan_val so it's an uninitialized
> variable bug.
> 

Hi Dan,

Thanks for letting me know! What I could do is instead of reusing the
int chan_val, I could use a local s16 temp_chan_val so there is no need
for typecasting here. How does that sound to you Jonathan?

Cheers,
Vasilis

>     761                         if (ret)
>     762                                 return ret;
>     763 
>     764                         *val = chan_val * 10;
>     765                         return IIO_VAL_INT;
> 
> regards,
> dan carpenter

