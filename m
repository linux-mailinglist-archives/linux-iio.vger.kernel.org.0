Return-Path: <linux-iio+bounces-13058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CFB9E2EBB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C68162479
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1711E1C0F;
	Tue,  3 Dec 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhJ51gTR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87C1DF27E;
	Tue,  3 Dec 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263856; cv=none; b=pUjtzW3IEkndXOPn2vC+kDT7Z6zJp5IIStic7qaMxAfCfDjqDp1NtqTEBW4L10DIkDkk/Vu0G2m41ea16+3VZY3lgeRSQp9ZB+GNCJdkW8RXWeURzHGemxE0Z3NyOVn9ReG5orUxBQfe1Qv3omvjtSTf1C3/w2oM2wvKb4QSVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263856; c=relaxed/simple;
	bh=wHlfAX2kRe9xsBlG4P9w6ycxPVwnqJJwCaiaCCTWBwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTg3dUEGt3wVzYKz1tQOF6mvCIkpodkgw/4mCCcmTYxc98rXxrLAJUOOA0v82jEVa3Eu1RGYkK7ZdJJsdPVG7swk/zuQ23BDuA79PTVaLCLvhFTS4PyFCN3WZ6/HKuLSjTaTdfoF7O9z4dIllltz0X3GUSLQ0U5Z6DEwZuPV3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhJ51gTR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a044dce2so74621635e9.2;
        Tue, 03 Dec 2024 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733263853; x=1733868653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGagANSepA+VInMMlnbrVfr6Y2VJf15ZTPExwn0QgXo=;
        b=WhJ51gTRoB+tajsogmd3rJO/LZoKIYpWAZdAC9FpiwCbcUwzXPxwHq9gZ85AwUIYb+
         DIu7PmwlonjyUzLwpJFfBqaNR7SIhGD4qWRIQsyXhdwSdigoKGJ4KRV0meJMrhWQP3hW
         l24LFPsqY4eFWb66ShcQdjNcwqOKHkRUu9aaBkEnP5MVAH2XSBoVrm310pCl9HP0RYAS
         m+pnOxt+InfDzxDMc5jM9DHuUfUT3NknD7PVsR7NXDBh7bsjkHefLb+1hUepk+dyyC7R
         67jTbgxusykvJbw/hS/dR24H03uQkj8qdKb3AQ0lMPpIph6y9psl9qGsijxVHp6XO0TQ
         OTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263853; x=1733868653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGagANSepA+VInMMlnbrVfr6Y2VJf15ZTPExwn0QgXo=;
        b=qUEkF0RFdCqLwngHnKB+GAhxBJ5tfdF8yoNZDubeLRUR7mZ6AqjwyPCerJK0aYpeRY
         RLpKkby6EsTd6GJIg0Urb4vWRx3B6Tq06s+/TfiFEUaJL/4M1I/5OMfhI+xyB/YCDiaa
         pAWDvab6KPno4jyVDzttH/lMqut5gsPQ7C+h9y4PQN/ScgRTyG0nqLgIGikeUTYlgmvM
         tpBEYGUl+qhXweWHOezoDuGCVBhH8wu5xcpmIsvb1uu67zwArrnJfPLfdbjrZofurCwo
         kCKpd/HtLwgTHoKxaD3UQ2D2/N78aj6PT+yHyxIClhnDvPAOaSyFzAaJkZC0veXpmmFw
         khJg==
X-Forwarded-Encrypted: i=1; AJvYcCUsXgjLkYDHZi/agcKUPV3vmfvrPUmatQ2NFRwP5R3+pSmoqWbosZBjbnJ3ADhACXHFXoKZL1pkLOXyg9Xt@vger.kernel.org, AJvYcCWiZvCAZu2sGLy8vdRuai/eJOYWMzv0yAwgbRyBM3EK9hT4KAzp9Xb0XSVXq7Y4KDmVcAEAWPDAHjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt1oHTolG0IA4uzkvYes2ENe6nF7Rfm9My4/5wWzhgMoZXmGU
	Nu1OPGxGoqMt/cbOLIlJt9bSnAVK1j5SaMQqkyuKHznWKVG78WkhA9vhAn5l
X-Gm-Gg: ASbGncszfN+qAXg3SaIv5qcpdwjosGLFunOjnQdsnCFxbQwS31uKaq7xfwta52FJ80n
	/uYyz9QY7bLrrWaNGh5S/c1Nn81RGOkXcn31G6kpiT+R2HaRn17FSNmNzeSytt9J82XYJbgduEi
	ZVo61NYQhkHtHX0wKDpq0N5BJsSoM3zzE+I6re+R1eT7vityb9wPGJFNji7URIbChX9g1zEwhc/
	mjO4yIvZC/VrSrdStpqlwA4xSBJ8iPeHa1i3TztAOwZtSUkmK2RXY3yvNKi
X-Google-Smtp-Source: AGHT+IE0ivTvyR1qJTzo67DIetzblhnkwh+Pkoln/fF3+NBaLbuYwSdwrZ0Sx9AGwLYmxpVupQ+sxw==
X-Received: by 2002:a05:600c:3502:b0:431:24c3:dbaa with SMTP id 5b1f17b1804b1-434d09b2e2cmr39774155e9.2.1733263853383;
        Tue, 03 Dec 2024 14:10:53 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:56d9:cf1e:faf4:54e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c12a4sm1462315e9.30.2024.12.03.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:10:52 -0800 (PST)
Date: Tue, 3 Dec 2024 23:10:50 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
	jstephan@baylibre.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 5/6] iio: common: ssp_sensors: make use of
 iio_is_soft_ts_enabled()
Message-ID: <Z0-B6q_CKcQ9gtlE@vamoirid-laptop>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
 <20241130002710.18615-6-vassilisamir@gmail.com>
 <20241130141714.7ef99a77@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130141714.7ef99a77@jic23-huawei>

On Sat, Nov 30, 2024 at 02:17:14PM +0000, Jonathan Cameron wrote:
> On Sat, 30 Nov 2024 01:27:09 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Use the iio_is_soft_ts_enabled() accessor to access the value of the
> > scan_timestamp. This way, it can be marked as __private when there
> > are no direct accessors of it.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> > ---
> >  drivers/iio/common/ssp_sensors/ssp_iio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > index 88b8b56bfa51..c38bf1dfb7bd 100644
> > --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> > +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > @@ -82,7 +82,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> >  	 */
> >  	memcpy(spd->buffer, buf, len);
> >  
> > -	if (indio_dev->scan_timestamp) {
> > +	if (iio_is_soft_ts_enabled(indio_dev)) {
> 
> It might be simpler to just drop this conditional in favour of always computing the
> value.
> 
> 
> 
> >  		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
> >  		calculated_time =
> >  			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
> 
> Good to replace this with something more modern like.
> 
> 		calculated_time =
> 			timestamp + get_unaligned_le32(buf + len) * MEGA;
> 
> Jonathan
>

Hi Jonathan,

I could definitely do this, thanks!

Cheers,
Vasilis

