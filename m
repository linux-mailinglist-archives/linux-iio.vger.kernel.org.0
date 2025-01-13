Return-Path: <linux-iio+bounces-14305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE6A0C21F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 20:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F6E7A42F0
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD261F9425;
	Mon, 13 Jan 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFFP9iMB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F701CBE94;
	Mon, 13 Jan 2025 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797946; cv=none; b=Fe10Q6oKY8ABs3V/erBM75ZV/tQyqCJoeiaozCQQTf5WNVYTQ31MFhBw8tlOkG1Udqmhmw5bxQvd/SNKEHP8RZfHWrs4IochitMpJWifiJGgDGLK8fpMDfmF8Y285LxOKqef/Xv5s+vnxZyQwuuNBHtLUGsbmvjQvflKEWFi308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797946; c=relaxed/simple;
	bh=FvQVFUEqo1HtRv2yeQ50dV0q4grxNt+tHPcwWPGoiTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S68mCMdal968eQfNSxFItccbHKsEMwHfvaXLs+Sv25QnHvJXg0ak68stASfa3lvnXpl/5NFAb8bAIQI6CYuLchgwHQJfSM3O6/c9n2wOpeX5G8VtOcgrA23h0/4M3MkCn1wiT9LSTArHjqHL4M9V7wgtxRiEbs1RJoJQ7Fotg5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFFP9iMB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f42992f608so6523368a91.0;
        Mon, 13 Jan 2025 11:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736797943; x=1737402743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Sx3ERaQPo8wUxj0rATSW+FojAtTZh725KgfBgbCQv0=;
        b=HFFP9iMBlwYE098f5gF6ZbG3NGcXKlVVFncvTUCh6JPsSKiad6eDVWzyccihmb7SGv
         4VOqdQInYHw8qDtwKmvLmmWYwNs7zsZLhLdgEmMgvTvodVNzRgVvTLcDA+nC4hVftq3K
         qYJpxEy9ruvvXWjsO1NW87cYcfp3x9q3u9Mij7NrH61NsksBi/QXrXrjMX2imqawOIXh
         h61xlUEGZXcGNyOsNLIU/rXryw9/ufI9Gl4MhYbRIPyTqdRiMIeALix9yoq0hkEbZBm1
         a0mwxiibslJGaE8aJRU1pLhu1oAta5iAWl44uF0Lg4FfmAFWH2etvbs4maocyP4+GktW
         Giuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736797943; x=1737402743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Sx3ERaQPo8wUxj0rATSW+FojAtTZh725KgfBgbCQv0=;
        b=voVlcuZbLpQGHHxEgHK1bHg+P9GgOyoldGiLGyW/fPxYiLts5x84D+tQtXXIn19Sp/
         w56wLL7Pqa1a5ufvkNi7mOLp8XHsWrv3twMJbSYs1Za+WGHpd9ZZl06GJmqTjDJSdV1L
         HieoZ++csR9mEqSZtv4mS7OY6nhg/iBZnr5J2Bz3t25UCx5FJBduyCNQ3YiOdtRRxJlF
         SrpZCTZaLgKb9seoZy1pwLUGlUte9b08VASjoFBteRQ6yokVfFLVB4NJUqaK+WpYMaIP
         TKH3ppIga1hiYkQrrqk3E0kkbeQaUt7B+i6OIT5Ex496aE2d7MceSxMRBX/D0ljhC6x8
         lRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOizh8RF2E52gNy9msXBonCAWaYMcqJq1IPVDNzn6DJtyJ3I1t2pzcbjb0qmhG+0GzRu7CoStdKOVmueGW@vger.kernel.org, AJvYcCXX/JY+HIbi9Z40ksm63VLH4ZBmSSArlwOophJdB0eMjaj16zByW4eN4vkFYdpW6uNQoQqeeLP7cY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJzIuv2JSxejSzC/eyzcHzQr1qKlp+owKNStosuMGlNoL0UT7
	U/elbzUPtA7f9665EsrpMDPRvR3BpuqLK+U+K6btliDen6ouv4uLAhfSH4xCkOyDMx0bOUhpL+V
	HbqJ2k9B1rE25+7nO7ep4GSn3Xqo=
X-Gm-Gg: ASbGncutbAT0l+qRX+ZrgWE73ZbymxniXnOhLQ/PqNi9446GvTUWuiHtYE3RZa6pTdk
	J1nxgn0uflXPEcFtzCW0ufLMho0/DmKWUFlJk
X-Google-Smtp-Source: AGHT+IHJUXbDbGWysQ8IDMqV55ROZB4by+cpeOFQ0BIKlCteKDs7+fB9dknf67dTNZY7JsnW3MO4xh3GfPnl4qp2/5s=
X-Received: by 2002:a17:90b:4d05:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2f548f426ccmr33380137a91.33.1736797943518; Mon, 13 Jan 2025
 11:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com> <129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>
 <D711DZJWGQX5.2D4PLVQN7NB8Z@gmail.com>
In-Reply-To: <D711DZJWGQX5.2D4PLVQN7NB8Z@gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 13 Jan 2025 21:52:12 +0200
X-Gm-Features: AbW1kvZh0A8dVLZI-DvqaC7-u4J1ZpuOyyANQNtl1Pru_uRLTf69AwSMk5K6cw8
Message-ID: <CANhJrGNT9H07MokRbVXRmDprZ+aV0XoDi=LhvrOkeSLzHnqsYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

ma 13.1.2025 klo 17.05 Javier Carrasco
(javier.carrasco.cruz@gmail.com) kirjoitti:
>
> On Mon Jan 13, 2025 at 12:56 PM CET, Matti Vaittinen wrote:
> > On 07/01/2025 22:50, Javier Carrasco wrote:
> > > The current scale is not ABI-compliant as it is just the sensor gain
> > > instead of the value that acts as a multiplier to be applied to the raw
> > > value (there is no offset).
> > >
> > > Use the iio-gts helpers to obtain the proper scale values according to
> > > the gain and integration time to match the resolution tables from the
> > > datasheet and drop dedicated variables to store the current values of
> > > the integration time, gain and resolution. When at it, use 'scale'
> > > instead of 'gain' consistently for the get/set functions to avoid
> > > misunderstandings.
> > >
> > > Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> > > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >
> > Thanks for the patch Javier.
> >
> > And, sorry for a review which is more about questions than suggested
> > improvements. I find it hard to focus on reading code today.
> >
> > > ---
> > >   drivers/iio/light/Kconfig    |   1 +
> > >   drivers/iio/light/veml6030.c | 499 ++++++++++++++++---------------------------
> > >   2 files changed, 189 insertions(+), 311 deletions(-)
> > >
> >
> > I like the diffstats of this Fix! :) It's nice you found gts-helpers
> > helpful :)
>
> I wonder how painful the int. time/gain/scale issue in ALS was before
> iio-gts existed :D
>
I don't really know. I wrote the gts-helpers as soon as I wrote my
first light sensor driver :)

> > ...
> >
> > > +
> > > +static int veml6030_process_als(struct veml6030_data *data, int raw,
> > > +                           int *val, int *val2)
> > > +{
> > > +   int ret, scale_int, scale_nano;
> > > +   u64 tmp;
> > > +
> > > +   ret = veml6030_get_scale(data, &scale_int, &scale_nano);
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   tmp = (u64)raw * scale_nano;
> > > +   *val = raw * scale_int + div_u64(tmp, NANO);
> > > +   *val2 = div_u64(do_div(tmp, NANO), MILLI);
> >
> > do_div() is horrible on some platforms. Or, at least it used to be. Is
> > there really no way to go without it? We're dealing with 16bit data and
> > maximum of 512x total gain only, so maybe there was a way(?)
> >
> > Maybe a stupid question (in which case I blame mucus in my head) - could
> > you just divide the raw value by the total gain?
> >
>
> In its current form we need the 64-bit operations to handle the scale,
> and it will probably have to stay like that for the reasons I give you
> below.

Still, I wonder if multiplying by scale really differs from dividing
by the total gain? I think the scale is inversely proportional to the
total gain, right?

> > >   static irqreturn_t veml6030_event_handler(int irq, void *private)
> > > @@ -1084,6 +968,13 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
> > >     int ret, val;
> > >     struct veml6030_data *data = iio_priv(indio_dev);
> > >
> > > +   ret = devm_iio_init_iio_gts(dev, 2, 150400000,
> >
> > Can you please explain the seemingly odd choice for the max scale?
> >
> > Just a quick look at the sensor spec and this driver allows me to assume
> > following:
> >
> > Maximum 'total gain' from both HWGAIN and integration time is 16 * 32 = 512.
> >
> > If we chose the 'total gain' 1x to match scale 1, then the smallest
> > scale would be 1/512 = 0.001 953 125
> >
> > This is 1953125 NANOs. This would mean the max-scale 1X => gain 1X would
> > not cause precision loss. (Well, I'm not at my sharpest as I've caught
> > cold - but I _think_ this is true, right?)
> >
> > If I read this correctly, the only channel where the scale gets applied
> > is the INTENSITY channel, right? Hence it should be possible to chose
> > the scale as we see best. (Unless the idea of this seemingly odd scale
> > is to maintain the old intensity / scale values in order to not shake
> > userland any more - in which case this could be mentioned).
> >
>
> The scale is applied to an IIO_LIGHT channel, not to the INTENSITY,

Isn't the IIO_LIGHT channel a PROCESSED one? I thought the scale
shouldn't be applied to it. (Driver may still apply scale internally,
but users should not see it, right? And if the driver does it only
internally, then the driver can also multiply values using (N *
scale). Well, I suppose you can as well use this "fitted MAX SCALE" -
but maybe it warrants a comment.

> which forces us to provide the scale as a value that multiplied by the
> raw measurement gives a result in lux. The maximum scale in that case,
> as provided by the application note [1] (page 5, RESOLUTION AND MAXIMUM
> DETECTION RANGE table) is 2.1504 to convert from cnt to lux.
>
> The same applies for the rest of the device supported by this driver
> (veml6035 and veml6035).
>

Yours,
  -- Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));

