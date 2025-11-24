Return-Path: <linux-iio+bounces-26399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CACC7F706
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B58D4E3FA6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF602F1FFC;
	Mon, 24 Nov 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd0gYwv6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1EA2F12AD
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974654; cv=none; b=p3CFrLGsHB0qgRCTUbOJKz/BoQyQjU8ES8NgIwDDZLghWmOzep1nVM8S/0ac9E1kd2x51ijvcEASufczNx5PghxnB9vtNLdnKpO7h4vZahevF4XdfMV2Upq5VEMf7PxZT11FYbDmmLebdJpFVl2KoqcOKcrXiv4CnqYn1Vg4tSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974654; c=relaxed/simple;
	bh=0AX8ikb3o4EvRfATnP1q7RYE34mOvktGMpe4j6p64os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swAMxQ2lV+/g92H7FQIb7k3C1VSaWATO71veTOi/4DOSBIINBsyMAS8Ugm/ezByYyyXWo0lvHOfQogn90W0CROv1haaXEv6wdpDaa9ud2wRLMQ5J2+FBX9XNPuObNPediWKYk2GxkAv79YspxNJsbBKKgO23WKqxiTMoSFvt750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd0gYwv6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b73875aa527so629034966b.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 00:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763974650; x=1764579450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxRRZFjB1lIqcawHfAYFmVJWZp4LMXEe6DiIUrAIjIM=;
        b=nd0gYwv6236F+2brovwyy4y3Ei8biyuBL5KCm26dT4OuTVqomRgpnCodYKLTsrVyqh
         wK4v/lBT/LtOTeiq+zTw8kIzcR/o54JlUIiYGFtC/FRl5dsy7d2zIYvN/lh0G9paq760
         ZNnxzbO/qzBrPCHCZBGaMt38foP2Ilc7QxR1EbsDG20BeW36SPhdH98dMU/3r9qRbKVX
         rADRsSuHFh3mOH6WMgHtFOrdI4ZSPWqMpVUgSKTH7ZhViTMZTwxSW43tura2OgtB1+W8
         7BrkT89EedYCVNPqDsCx6cda1y+fUH5Y77sK83CEUdt2wsg3IjnMFhFpNaNpwF7D87Ul
         XsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763974650; x=1764579450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxRRZFjB1lIqcawHfAYFmVJWZp4LMXEe6DiIUrAIjIM=;
        b=V2sWtJBQ9NzaIw8oQ3NPSyd5tw3GKAqPpxI3EQj679qmkTv+qvWYUkQgGMbNpx9E73
         YLrd/NbttuKviy4AsiH+FWnAyy8bhF2pH2iScWIAWX/dJPZDurrEGZPSLRUKV3Kn6NBo
         uq8B5lrr7QPEuSIMF1tfkllKLP3m1W3vFj7horlUQ0Pjsmqpvu9HIpaYi2QkN1oVe2Na
         Tvuq4xO00n2y8/AR6XYsBwQZOWyXh31xn1d2RUVKFvL53W3XvKsbRagy24mgvsO9BPLm
         oxU5TRfnaVhuCsldHs/hxuhX57NuwCd/uNqm9SQvvreSBnL0eapX/14b/miY6xh4Bjpi
         3uDw==
X-Forwarded-Encrypted: i=1; AJvYcCU22A8Vt60JyZCQfri8NQgc8iM/mDcUVrE+a5EZWFCwWX0tRCHsjE6/b7wSpwy0GnOgRaklZKYgjQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHbJdcRAD+W17+lNaOmO7gAGRHkvgNT6Eq2LAYC5Y59GtGAIO
	hwNrSF+eEAmrlS6lttHRK/f3tTOT9NBtLk3ZFcMHAsLTj3t2O7PnPwVf
X-Gm-Gg: ASbGnctKtPeDB5aH91GULG77pmMInW9PIHo7fENz0bEBqMZlHLMmYCgWcKmixjcXEza
	FZkyaJDX5+kq8VLhm8NxnxjBU0bu9XX2lTWVpkmDwWfjbsSsPBYz7HyCIHKJobYgaZfHJhYzgHB
	82mpPwt9691PdUqrsM9P7pBXzUf3kPeVSyZIWwc7i7GytuocG+ttDzM6lWzMNxdXQUZSNbnkXax
	wTd9/c1gwkfZfk8K67I0SJMSiIkIEj/l/D48mk+yHH8jWxY0fwScGXBwhEi+b1jflw/d3pvp9wy
	86Yc3snwAVGznaLitNes/6oYyZBy/CTHOTkoPZIM8aNdwc5KxWOG6bb2Z3uApTk1vVApWrGcFyk
	gjhEb4x8Pxdot2RazYHr/pnE7JNxlzK0d99+TZDa/qTFmYURiOePAqFsm0XxkrJzXeB4NkkcmTL
	LNOkeCFcQDM7FLzSPkV7XgcJi64+f76yXgGQBuVHqCb0ILZfaXQB85ph7009YYMj853KXfv09hK
	VhccH0=
X-Google-Smtp-Source: AGHT+IF7eVt0kYpi5bJtqaCQupLePEPQbTatmBLQkYhmxJBlR5P/QxBWZ0Gc9LnkJN6rBHjYeAf4FQ==
X-Received: by 2002:a17:907:3ccb:b0:b73:883e:1517 with SMTP id a640c23a62f3a-b76715e626amr1130898266b.26.1763974650091;
        Mon, 24 Nov 2025 00:57:30 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3033:267:9a21:9532:f12d:5875:dc2c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765502a9cfsm1199697466b.57.2025.11.24.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:57:29 -0800 (PST)
Date: Mon, 24 Nov 2025 09:57:26 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: adc: Add support for ad4062
Message-ID: <o4kt2of4xql4azufjgiecm4jzuexgm6nkvr7aghbwfk6qd7yqd@r4plggehzces>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-3-0f8ce7fef50c@analog.com>
 <20251018171032.144a126c@jic23-huawei>
 <ou6qwayt4g7qaoe5dm7tdg6jl5dwquslpfbok6on5r2q2wytyl@wlqxj5y6ircj>
 <aSQMjZbc75cQtFqJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSQMjZbc75cQtFqJ@smile.fi.intel.com>

On Mon, Nov 24, 2025 at 09:43:09AM +0200, Andy Shevchenko wrote:
> On Sun, Nov 23, 2025 at 08:48:09PM +0100, Jorge Marques wrote:
> > On Sat, Oct 18, 2025 at 05:10:32PM +0100, Jonathan Cameron wrote:
> > > On Mon, 13 Oct 2025 09:28:01 +0200
> > > Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > Mostly acknowledgements and explanations, except a comment on ACQUIRE usage.
> 
> ...
> 

Hi Andy,

> > > > +static int ad4062_read_chan_raw(struct iio_dev *indio_dev, int *val)
> > > > +{
> > > > +	struct ad4062_state *st = iio_priv(indio_dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
> > > There is a nice new
> > > 	ACQUIRE()/ACQUIRE_ERR() related set of conditional guards defined that
> > > let you do this using cleanup.h style.
> > > 
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a0abc39450a3123fd52533a662fbd37e0d1508c
> > > 
> > > This looks like a perfect example of where those help.
> > > 
> > > When I catch up with review backlog I plan to look for other
> > > places to use that infrastructure in IIO.
> > > 
> > I tried implementing, here becomes
> > 
> >         ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> >         ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> > 
> > At buffer and monitor, since we put the device as active during the
> > lifetime of the buffer and monitor mode, either I leave as is, or I bump
> > the counter with pm_runtime_get_noresume, so when the method leaves, the
> > counter drops to 1 and not 0, then on disable I drop the counter back to
> > 0 and queue the autosuspend with pm_runtime_put_autosuspend.
> > > 
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = ad4062_set_operation_mode(st, st->mode);
> > > > +	if (ret)
> > > > +		goto out_error;
> > > > +
> > > > +	ret = __ad4062_read_chan_raw(st, val);
> > > > +
> > > > +out_error:
> > > > +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> > > > +	return ret;
> > > > +}
> 
> I read the above code, I read it again, I don't understand the reasoning.
> The ACQUIRE() doesn't change the behaviour of the above code.
> 
> If you need to bump the reference counter, it should be done somewhere else
> where it affects the flow, or this code has a bug.
> 
> If I miss something, please elaborate.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

The part highlighted does not require bumping the reference counter, but
at the buffer acquisition and monitor mode, to not put the device back
in low power mode during the lifetime of those operations.

Buffer more:

  static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
  {
          struct ad4062_state *st = iio_priv(indio_dev);
          int ret;

	  // [ Some code ]

          ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
          ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
          if (ret)
                  return ret;

	  // [ More code ]

          pm_runtime_get_noresume(&st->i3cdev->dev);
          return 0;
  }

  static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
  {
          struct ad4062_state *st = iio_priv(indio_dev);

          pm_runtime_put_autosuspend(&st->i3cdev->dev);
          return 0;
  }

Monitor mode:

  static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
  {
          int ret = 0;

          if (!enable) {
                  pm_runtime_put_autosuspend(&st->i3cdev->dev);
                  return 0;
          }

          ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
          ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
          if (ret)
                  return ret;

	  // [ Some code ]

          pm_runtime_get_noresume(&st->i3cdev->dev);
          return 0;
  }

The raw read does not require this behaviour, when the method returns,
the device returns to low power mode:

  static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
  {
          int ret;

          ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
          ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
          if (ret)
                  return ret;

          ret = ad4062_set_operation_mode(st, st->mode);
          if (ret)
                  return ret;

          return __ad4062_read_chan_raw(st, val);
  }

I will submitted v2 shortly.

Best Regards,
Jorge

