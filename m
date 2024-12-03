Return-Path: <linux-iio+bounces-13057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4939E2EAE
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6E92836E4
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B2A1F76DB;
	Tue,  3 Dec 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1CNli9O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAB1DF27E;
	Tue,  3 Dec 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263706; cv=none; b=lwxeTEfSrlqNVdaYGGqrB0rXfhZDbELt3eeQxdtLaw/FAvyTJzOd8wkhUAcpPX2yAecWinT06MkQFdBdTAHfiSf6DDLVYocoP8aDZI31R8LHKfNJuaLCUkIqA+WCu+Ueu4e5gPoBnJFhMja7qoLScZ/Bcqd+GFzT/4v+CVND2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263706; c=relaxed/simple;
	bh=VXa02M2bOoTSZ7ie+aiT5+/ZS6gTPHLCPXgEwfBIXa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciJiuzRWOpwzDeBvEllqxtW+Mk5aSJAz8OhPW//s5PQoJcg2OiXOmJDblSXYMdPO+Ni5PAbIt2hDnxfCk6vLMEEwWLSdJhKZ5lUB/zykrTnjRSpofFtc16nnqmgGnvHxVy3cC96FfcFFCzd0uBnf9CokeApMV7WJnbO6Lax1Ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1CNli9O; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e87b25f0so153096f8f.0;
        Tue, 03 Dec 2024 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733263703; x=1733868503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTMTIhFkJliXtjLotwueIZgPO7+0P79jKrSoxu+rgGQ=;
        b=C1CNli9OAgPWBN6ecii7cXXh9lA8Lb4W41npWyTCXPi4RPk6i0w/p05mXHgoXp75d7
         g+PVyLjXO2zpUaIkzeSm8zv9ttBceRUyk2SHTJShnwKlR3LYVfdX2j+G8DfNtQ8n30AY
         kq9lvd8tFAGhKItnjIYiYRrj2ZbfQszYO+xRDOXUUIsvB347fip7wGl3wvkkxxlwVpjj
         W82hLxkWXYdI4hzekEiXdi/gKkLQ0qOGI4JK3yyzjWGIYHv2l1eJIDKqwpnHzGRJIqId
         slMlk3ieUQXFWrJFD3SjA5IoP03tT+gH0mInAKcoHyIqzZTptFlv8b/wl6SaFv+bu0Ng
         yIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263703; x=1733868503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTMTIhFkJliXtjLotwueIZgPO7+0P79jKrSoxu+rgGQ=;
        b=hzn8OeYQLlhYkDaquyBMb/b+N6ag6V3HfdDO7uTE4uXaVVC5jMxpYHyiwIB5VsV8DI
         MAUuK9GmuERN3A3ElapQZSetTpPRuqfBYykOxQyeuMAA3F77M17uU6SVXlBWxREOgT/f
         80u8WznBqG+99RafMbzdGk8ZwCYjID38d7a6HBF+zVdff/kF+WGFAKsgGGzIHmdMd+hs
         0XPgt1Y5a+PXx5s4Td/PnwOfBgiio3YSv+bUvAuS9M60flA2rENp2QyNEEfkVg+R3qHo
         gVe/XE0RgDiX1062f4VLeqHk8VW5GHuWl0PVy7rc0Q075097Yb92yNUBz9lymWpmDYDq
         bOcw==
X-Forwarded-Encrypted: i=1; AJvYcCVeXy71/YJSz9tuOgQVYJz6JNpA2htOuD5wTqQ31/854j6Fgy04CmNYXnNUxpC20/IbfhXwsE2xGlD4cPXo@vger.kernel.org, AJvYcCVia+nKhoCkKC5dXvTyGt5EdqeqjE8t7SB6fCI/N8g9f9H86DaNEqb88nE9k10Pi/mVdcFsZv4j718=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjrT05Z+sxkuS8H6fgW5YyPuNxIAm1X/kaABhdTOnZRHDm5S4
	jhPI3V0Zlia0uX95M0PYU+4D5/my2+/VJ0gTG0gPkRKM7Bn0lYeD
X-Gm-Gg: ASbGnctG0KRftJPzxe5gWgq98jkytF38iAthox5Lekonz15uuIAloejZoOHnlGggVJA
	4m9I6Wlr/yCSX3QdyBkHWl5x6NLg/yn+BKgu2BcVPM+E89VdObTIt4qJlD0XxDo3b/E1WqPJFRk
	HcyBw+v7tqn820XvBNqmQ+VzLIl4bSzCr1kDr6fwd4KqXVdNnXX02MHVpGhmi0TZC6NVCZU0SSO
	YP8NHaVqIU9d+pSmNOBV5i1ElPmAk5f0s4g6UztVrcE4YQe/EiMIS5FO50a
X-Google-Smtp-Source: AGHT+IHO+Calp6AWFoCwIw3sQBLAOxR9iYhb2hsuSBTqx4JSSOV3Lz+YVoeIb/4AIVwo0hFWomXayQ==
X-Received: by 2002:a05:6000:1787:b0:385:e90a:b7de with SMTP id ffacd0b85a97d-385fd9699d4mr3440982f8f.5.1733263702623;
        Tue, 03 Dec 2024 14:08:22 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:56d9:cf1e:faf4:54e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d97ab259sm14838650f8f.95.2024.12.03.14.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:08:22 -0800 (PST)
Date: Tue, 3 Dec 2024 23:08:20 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
	jstephan@baylibre.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/6] iio: adc: max1363: make use of
 iio_is_soft_ts_enabled()
Message-ID: <Z0-BVKSCL-Pak9eA@vamoirid-laptop>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
 <20241130002710.18615-5-vassilisamir@gmail.com>
 <20241130140948.1e0f1082@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130140948.1e0f1082@jic23-huawei>

On Sat, Nov 30, 2024 at 02:09:48PM +0000, Jonathan Cameron wrote:
> On Sat, 30 Nov 2024 01:27:08 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Use the iio_is_soft_ts_enabled() accessor to access the value of the
> > scan_timestamp. This way, it can be marked as __private when there
> > are no direct accessors of it.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Hmm.  A younger me one ;) 
> 
> A simple allocation that is always big enough is going to cost
> us very little.  Should almost certainly be using kzalloc.
> 
> I'd change this driver to just stick an array of size
> 12 * 2  + 8 so 32bytes in the iio_priv()
> (12 channels, possibly of 2 bytes each + aligned timestamp)
> and always use that for the rx_buf.
> 
> Both a simplification and probably a performance improvement
> as well by dropping the frequent allocations.
> 
> 

Hi Jonathan,

I see your point, I can implement this as well.

Cheers,
Vasilis

> > ---
> >  drivers/iio/adc/max1363.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> > index 9a0baea08ab6..57d9aff729f4 100644
> > --- a/drivers/iio/adc/max1363.c
> > +++ b/drivers/iio/adc/max1363.c
> > @@ -1473,7 +1473,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
> >  		d_size = numvals*2;
> >  	else
> >  		d_size = numvals;
> > -	if (indio_dev->scan_timestamp) {
> > +	if (iio_is_soft_ts_enabled(indio_dev)) {
> >  		d_size += sizeof(s64);
> >  		if (d_size % sizeof(s64))
> >  			d_size += sizeof(s64) - (d_size % sizeof(s64));
> 

