Return-Path: <linux-iio+bounces-11603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF049B6006
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 11:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A811F21D4E
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA71E284E;
	Wed, 30 Oct 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLq8gaD5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882571E25EA
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283931; cv=none; b=D38mW1H7EXVeh6Dj+nGwhVV+SGg9KdWcYeg8oD7e2NA3rxsaPRmYwM8MfPy1DW6oNTCH/Gk+vzkXn20qVV0D14XBmYH0tkvTu71z5wxK4wHENUlsCz2UNKtwccoiTZFOdZDCTGZu9dm5CC1HBMXFs7vdc4o0HXk43/RmGjfyOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283931; c=relaxed/simple;
	bh=HTN8G5taw8sJn/bNYVBZv4bsWp5RhIKqC13MC3vFKLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+TfsmRWWJiBmii1iLX9PsBGFREG2fT2dirVWqKCYjX93kDpFU68KwffyU/7bHIjuHwV/Q+GT1HqhgQtwCCvBqvE9gU1ZtNu7K4bC98xKJyGtwtHYnB+w4WDk88xudsgWjmyTKLlsiXInj1G4xhrQYvKmJje+iRAiUN7sIUl7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLq8gaD5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso892051866b.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730283928; x=1730888728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BTqfOT+dTxjWVd0Rws0nIThlpBz8Z0nNEH7E88R7OQ=;
        b=SLq8gaD5j4L3jASFFDDKQvS9xtYEcPtYM/OS5VxjXdnWuBLTUE9ApoHH7AiFY4Jj8K
         krHemLyqupb4N7Z2Bh5RAEaNiZBpQAQzaK0ks16OyQZAPNaC+hREX28Z15qbmNAJ7u/U
         GB+pDa8K2r8UGtx3wTpyaet0KJOSKPpqiVToERSfddXE2K9Z0u+SC8SDj83M2qxfZsXG
         ei/7EzyTLdO/5OsjlBjt7BDsi6xKvrFgkFDgwRqGpA7dY7HhloFVnJi2KXeTino0XQjz
         i8jV/e46IDL9gzHNT+bmbVDdGBr/zYEdXT4lw/F3xb3/CEWenXnhIV6qZHwPUq2qHFl1
         /dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283928; x=1730888728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BTqfOT+dTxjWVd0Rws0nIThlpBz8Z0nNEH7E88R7OQ=;
        b=K9pPJtmcTWN3MySds0EVeSO4i6Ij4rDqhXfuiAaXuVAwfE2zHEhprui6hj1USRHmoL
         DHInAlqafmIcC3Kss6P7/JiRZfcJ27Umx7B6b93BjcGBEYNXUBT1AwRHGfU76cX0GZHA
         P0/VDgNx3aOAIE946kc5tZ0Qw2++aGhLwIFMLJVNNJKDF2VC9mpcMRwaug4mMKxg3zTm
         bVdPvsMlvu0kE6Xfpxy4AXohFoFl7Zvv6AX1Li/wJ2gH89oF7R5w6qwTcvrY9fcPW155
         qHUfrQREp4JdP3X0mQ9Spusy+AlJczHwvcLeO2bENjvlptEkkdjS7jYHdxdG3g/d0M5B
         KoXg==
X-Gm-Message-State: AOJu0YzKAgTyN2mryWY+HMn1geqhqSqkJLJsU9SRqq7KLxAYwfNtG7pa
	75Vs/mkBlh07pua++sUHnw2beAgKLGUrxsQgjVK43vitNCnhiMmGhk0iJg==
X-Google-Smtp-Source: AGHT+IF+GUpkdxjPhYo9xO4UzQE74wl3UIZP2swgGSPSxDZp1dy0gV3OT/ICU6kkuH+VVouvHsx7aA==
X-Received: by 2002:a17:907:9446:b0:a99:f619:d365 with SMTP id a640c23a62f3a-a9de5f6e257mr1210500266b.30.1730283927620;
        Wed, 30 Oct 2024 03:25:27 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029559sm556860966b.58.2024.10.30.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:25:27 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:25:25 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, jic23@kernel.org,
	vassilisamir@gmail.com
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: chemical: bme680: generalize read_*() functions
Message-ID: <ZyIJlcYb95zGy1Rm@vamoirid-laptop>
References: <13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain>
 <ZyIDKdX7NKopqT4W@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyIDKdX7NKopqT4W@vamoirid-laptop>

On Wed, Oct 30, 2024 at 10:58:01AM +0100, Vasileios Amoiridis wrote:
> On Wed, Oct 30, 2024 at 12:26:13PM +0300, Dan Carpenter wrote:
> > Hello Vasileios Amoiridis,

Adding also Jonathan in the thread.
> > 
> > Commit 9b4071ab8cbe ("iio: chemical: bme680: generalize read_*()
> > functions") from Oct 21, 2024 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	drivers/iio/chemical/bme680_core.c:760 bme680_read_raw()
> > 	warn: passing casted pointer '&chan_val' to 'bme680_read_temp()' 32 vs 16.
> > 
> > drivers/iio/chemical/bme680_core.c
> >     738 static int bme680_read_raw(struct iio_dev *indio_dev,
> >     739                            struct iio_chan_spec const *chan,
> >     740                            int *val, int *val2, long mask)
> >     741 {
> >     742         struct bme680_data *data = iio_priv(indio_dev);
> >     743         int chan_val, ret;
> >     744 
> >     745         guard(mutex)(&data->lock);
> >     746 
> >     747         /* set forced mode to trigger measurement */
> >     748         ret = bme680_set_mode(data, true);
> >     749         if (ret < 0)
> >     750                 return ret;
> >     751 
> >     752         ret = bme680_wait_for_eoc(data);
> >     753         if (ret)
> >     754                 return ret;
> >     755 
> >     756         switch (mask) {
> >     757         case IIO_CHAN_INFO_PROCESSED:
> >     758                 switch (chan->type) {
> >     759                 case IIO_TEMP:
> > --> 760                         ret = bme680_read_temp(data, (s16 *)&chan_val);
> > 
> > The bme680_read_temp() function takes an s16 pointer but we're passing a s32.
> > This will not work on big endian systems and even on little endian systems, we
> > haven't initialized the last 16 bits of chan_val so it's an uninitialized
> > variable bug.
> > 
> 
> Hi Dan,
> 
> Thanks for letting me know! What I could do is instead of reusing the
> int chan_val, I could use a local s16 temp_chan_val so there is no need
> for typecasting here. How does that sound to you Jonathan?
> 
> Cheers,
> Vasilis
> 
> >     761                         if (ret)
> >     762                                 return ret;
> >     763 
> >     764                         *val = chan_val * 10;
> >     765                         return IIO_VAL_INT;
> > 
> > regards,
> > dan carpenter

