Return-Path: <linux-iio+bounces-13059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61CD9E2EDF
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771C42839CB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCDD1DDA3D;
	Tue,  3 Dec 2024 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISLacKa7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20501FA84F;
	Tue,  3 Dec 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264073; cv=none; b=PSLkPkPg+mx0NzlpMO6noygDb1ecrdg314IT0Vtikg/nLwzMAzJB1wNt8zG+GfGUWEhRsfbBKXrW0HYAJEu+jL/Aa0fkIUS2uoQ9XXLYb1vwqjvHpBpdDqp2weA+lLqVix6F91I64Lpe7FZan3b8h/ZMmEdORy1mSZKIYeaVvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264073; c=relaxed/simple;
	bh=uPJe1PLra4CQK5SdJPdBzE3oonO1F1+GBrCkrCvazcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMb2vF9bV5lR591OWTfBGYnGW/sUTa7PjzbKbGH4Vyfu1QMYG9L+J6jSI6vvF0k/djQRfrSzofBO2/7y+i/rB0WfV4FOYe/Coc0WVA/HBaAhuJsy9utY8tg8wsJ2ZrE9ZRCSlsxLZAYg4hunomXa8rgArvp1DYqPRIJCW1AC3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISLacKa7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385ea29eee1so2418225f8f.3;
        Tue, 03 Dec 2024 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733264070; x=1733868870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEKd2KtRYUftLCzklvlf03oHPrrEzWAjMeO8mfAXl9E=;
        b=ISLacKa72TUs/OWZDGhhBiUuCiU/icvYe04bbmars6jqOnlZVS1N7Jj1aOtILSgwjw
         O01CltVx6Bn+hnd7DCBcDeyk7Xfqy7xRdf/RYJZBr3WXpvFwHeS06Dyif9lbR/kSC3eU
         MVvRcs8/jSE21N3bnmFhN3WYD5l3lAg6ja5cv5+eASoMi739alyhkB275zlVavITRbwb
         72KbTiy7L1MmDWpLzb426Mh4itfDMIWQq9Np2WgTGWa2k8RG8Mp0fh4R2h9aZjofEEq/
         1itnIKtOxnAn0ddNKbezZcz9vYULgGzlD8IoWvadccF+KVpyh347vWysgbKgAdr85pGM
         NxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264070; x=1733868870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEKd2KtRYUftLCzklvlf03oHPrrEzWAjMeO8mfAXl9E=;
        b=bhs1I6vw6PUisPYppLa81dDVgC1+cnS+1qzQEoG8QsN6nKz+OAnt8VEQwj9KmcYbvx
         r4OAJLM/xkk5FAQj47urNBvXHYayDE2kBHZJKarDIbYc6yU6ry0ot2PFQUNYsprbn0hX
         vKx82KXJ9ZLqrH0urf+H+D37J5woFqJY2X37cZuK/dfBPIArWnYiLYPGyTKde5LGIRGV
         g6xNVq21HcthQK+lBY5RY5E7CkPeNaR8qLZPJC1+Bwaph1mQFoWTfZEvKtR+PhK8oFMb
         TNSFPQ8RnjTRV1GM99DxyL9WvLlE2SEqYlBgRvu5zZmf9J6FWD9JF6PycaJ5RlG8xGDJ
         ASzw==
X-Forwarded-Encrypted: i=1; AJvYcCVRRNE3qLSZsDDJ1NoAhQb5pEzuvpRTsHLN35IN5B/KElQmZCg/6d7ZOst89ArCkxvfqSryVfKzu0E=@vger.kernel.org, AJvYcCVzVFVr/Qxxs0UjP79gL0xGGkxjVvXCH4Kfz2R/cGT6TDaPyO2Brg444L636aZtXkf66dSG5yrrxInwWuRh@vger.kernel.org
X-Gm-Message-State: AOJu0YwhogheUKe6RRUrPAKpZLODPSTcfnNfdUeD+85Y3meNIZ4rKjKd
	Gz/xmQWAiOPiqwfibR9dMMo4MlnrF88AA7ss0Pknn/R3/Ko9csbz
X-Gm-Gg: ASbGncvzHRus5GcjLrEun/fDyVRH7yox24l3JlaG4SJ2zYn9NhpLBoLBxUOTzmZt9zv
	fS/yDatKqyf039xDwPyKu4nAdhWKwbwVbzBnw/cqehAyGuaKvfsq/6hRztsRqlrDEXSq39Ygpo9
	NecTBN1HzzslRq/Jbcnb2x3wRckwHD7dTHbRoZr1uHYiJTTEEnrRGYq5OIqarGNgr9ITc5uYSE+
	cvx6dqz3xGqbXkUUSkMCfo2x0JvquPzeo/qqHQhk62gMsOQqPii7QpjW8aG
X-Google-Smtp-Source: AGHT+IHLYgaBrFFuZ+yssHooipIVuaZYQnPn8gMyCZL9dYlY/sI/RHSvvFitPKH0IUHhbiTNKOqCbw==
X-Received: by 2002:a5d:5f8b:0:b0:385:f1f2:13ee with SMTP id ffacd0b85a97d-385fd53ed92mr3844314f8f.46.1733264069916;
        Tue, 03 Dec 2024 14:14:29 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:56d9:cf1e:faf4:54e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e5e3629fsm10599846f8f.93.2024.12.03.14.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:14:29 -0800 (PST)
Date: Tue, 3 Dec 2024 23:14:27 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
	jstephan@baylibre.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 6/6] iio: core: mark scan_timestamp as __private
Message-ID: <Z0-Cw-R1FJZCpnPY@vamoirid-laptop>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
 <20241130002710.18615-7-vassilisamir@gmail.com>
 <20241130141954.07423793@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130141954.07423793@jic23-huawei>

On Sat, Nov 30, 2024 at 02:19:54PM +0000, Jonathan Cameron wrote:
> On Sat, 30 Nov 2024 01:27:10 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Since there are no more direct accesses to the indio_dev->scan_timestamp
> > value, it can be marked as __private and use the macro ACCESS_PRIVATE()
> > in order to access it. Like this, static checkers will be able to inform
> > in case someone tries to either write to the value, or read its value
> > directly.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/industrialio-buffer.c | 2 +-
> >  include/linux/iio/iio.h           | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 8104696cd475..c332741f3cf4 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1137,7 +1137,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
> >  	int ret;
> >  
> >  	indio_dev->active_scan_mask = config->scan_mask;
> > -	indio_dev->scan_timestamp = config->scan_timestamp;
> > +	ACCESS_PRIVATE(indio_dev, scan_timestamp) = config->scan_timestamp;
> >  	indio_dev->scan_bytes = config->scan_bytes;
> >  	iio_dev_opaque->currentmode = config->mode;
> >  
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 5661794d1127..669b4ef1280d 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -611,7 +611,7 @@ struct iio_dev {
> >  	const unsigned long		*available_scan_masks;
> >  	unsigned int			__private masklength;
> >  	const unsigned long		*active_scan_mask;
> > -	bool				scan_timestamp;
> > +	bool				__private scan_timestamp;
> >  	struct iio_trigger		*trig;
> >  	struct iio_poll_func		*pollfunc;
> >  	struct iio_poll_func		*pollfunc_event;
> > @@ -908,7 +908,7 @@ int iio_active_scan_mask_index(struct iio_dev *indio_dev);
> >   */
> >  static inline bool iio_is_soft_ts_enabled(const struct iio_dev *indio_dev)
> >  {
> > -	return indio_dev->scan_timestamp;
> > +	return ACCESS_PRIVATE(indio_dev, scan_timestamp);
> If we only end up with one use of this (based on feedback on other drivers)
> I'd tempted to deliberately not provide this convenience function and instead
> just use ACCESS_PRIVATE() directly in iio_push_to_buffers_with_timestamp()
> 
> Nice work. Particularly by highlighting some 'odd corners' in drivers that
> probably make no real sense to keep ;)
> 
> Jonathan
> 
> 
> >  }
> >  
> >  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
>

Hi Jonathan,

Indeed, if it is only one case that this is being used, it wouldn't make
sense to provide an accessor. I wouldn't think of going directly to
touch the drivers without sending this RFC first, so it's good that you
like the solution of optimizing the drivers themselves. I might find
some time before the weekend to spin a v2 to discuss. Thanks for your
time, your comments are always of great help!

Cheers,
Vasilis

