Return-Path: <linux-iio+bounces-21788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D6B0B7B0
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 20:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2F1898E8C
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 18:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072821C9E8;
	Sun, 20 Jul 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ+dmip1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0D1459FA;
	Sun, 20 Jul 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036608; cv=none; b=tvGMenJ+sqAJSzyeT4ngJpRtutXyGX1DTlPDYpBxW59TjyNl1s8g+QrRzirJ/yTmap69YZc7s7Hr1K49ZcE0enJkvsgjlbhDHoSlE6UbnCCyy9JfFoCBvTraJjTqYOSZzjmD2vszJx1ILWnvvHb9PZ80D9odgSMc/mgBi/BD9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036608; c=relaxed/simple;
	bh=DJ8fpwvqGbH0eiKdcuuzCSyQZ51thn4iGXRCPZTCASU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM4rQSkD9Ve568eyP9qwDNzd2yuX6rrfNuxCgAC7qasaHBoA8F17+zgxpUKQCuqvIBRyg2iXOoCkuBKKp1bsjJYP10kibOaGurh0xDWsK0OwsGFuapdTWozYV7fhU8+LKzGbPkxK5ZkDxXn+iSDUdOppnysxIHMygVqVt75jDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ+dmip1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-717ac642cfbso3712267b3.3;
        Sun, 20 Jul 2025 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753036606; x=1753641406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEnR0xjEBXLuUSkPPs3JYg/bzf1JdRSdDrp8t3GgG8I=;
        b=VJ+dmip1mZcRAD/8O8sUiXdLYv9TZ3V5c9p1Mnynaa/D7aMPPYnfnur+hw9WcE8Ajh
         4eOxxJ5wBoyA/rNEw6gjS7TqsKQDUZR3P7G6Sghdv0waNAdJeLXDyRirbKiERTXOr0+s
         b9q4c1pvuu+vJ6OKVQVpyFORNsL7rFC+dOvglDLfggYJYK5pyDvUtV8JWHGNaOoJs9tv
         1JAL7s5QadEt5cE3HMGN7zu0MTXn/QCdL6UwF+Ab8Bwy7uvSBtcrgGR9+WCqzoR1oc6G
         zvrCI5aXzX+SOHicwG3iqXLhQ6ZhQF8Yy8L9f/N9//ey+m0hRBCC16oHPHUi5zLWC2rr
         h2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753036606; x=1753641406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEnR0xjEBXLuUSkPPs3JYg/bzf1JdRSdDrp8t3GgG8I=;
        b=L95U6rRH2DmNwF1UIQzEIBs2M3v9v77ycjzi3jwxP1tyDq0ryVAXm/kMkderCu1/0J
         NMTq83hj5BGaU4wgpPgEvA47wwLstL0Eeg0VyZF+HQrrj5UCDLniUJ62qk47igN305C2
         XzdqKyXsskG+MDt5wckp4wbjin9DHulxDV1qMY2nc9uDzEIU2mCko5k6uHw4UfFJzjsf
         bOhfVXBEnzhvlpdQNW8o3h9Pn1V6rfY4OZPg+l4N9oBnJDM0T+/hKJF+cQ70nu6flXHN
         Y4HaJd//befo+oBXrkNlCBva14xvb38vSkcO02X6dkv43tG+9T9E1I36KkcWOPwaFr7w
         5TGA==
X-Forwarded-Encrypted: i=1; AJvYcCU7af8tJCnnQavaIKn3XfQ3NZU12Ts0vyPU6wdtIntWh1RrXls5qiPMeEzKc4akYqeTJEly2DGmgiDO@vger.kernel.org, AJvYcCUhmGhvHa6G2PRB+OaQbJW2iqk7Kh54Ui0F6n4Bqmfiz8gEoqpKKvCilG/0rqrU72YZMq9nYrXbtgs=@vger.kernel.org, AJvYcCX90d78qT2cYC4bx4COPnfNXrUD6U4y1XN232PR2GX2jCuoSWwkUZ8me4Np269Wfm+77RHJ85i559ZomQzz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xTh1nCrDDTY21ZW9G+FD424v2Q0pRf/MnZzpihn6HacGSQTb
	a5MQeq3RPoH6je6gH4EIJTERa0OChUzh26TtermmXQY3Pq0J2Jg0ZD3/FQbWb3vid0/Ujf+Swgk
	NxotIEk6luev9r9Zt0VO/Q23eQoGwO+A=
X-Gm-Gg: ASbGnctTmWY6cYgDEKb0BgFz0m2vwFc5g09ggzAxjhDJZV7plQu5Q9PM0cpcqyw31fc
	p1dUDtiQMJV3TKYL3HwgrmQ/5qwbby6p0SCsxWpt2j8R4spYVK+X4Y0znWIZdq72MJPD50tXZdH
	wffVkfmw79cwo7JPo+sw9AsvXwcUHLv5VIQzAGfU8xqdyZ/yXnLQPGi2uuKXo8Hic7Y5hnQ6vjV
	XAQ7ik=
X-Google-Smtp-Source: AGHT+IGFpCFwFLpD4YMqUWtzH7u8MC3ScHb+AzrjGdRxkKrji597zG3dpMKDi595Mv309tQn0g3xqCQSiww+ZRfpWas=
X-Received: by 2002:a05:690c:6c0c:b0:70f:9fcd:2eb8 with SMTP id
 00721157ae682-71834f5507fmr109984767b3.1.1753036606068; Sun, 20 Jul 2025
 11:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702230315.19297-1-l.rubusch@gmail.com> <20250702230315.19297-4-l.rubusch@gmail.com>
 <aGaSkQHQKCqfrVXF@smile.fi.intel.com> <20250706170916.17417514@jic23-huawei>
In-Reply-To: <20250706170916.17417514@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 20 Jul 2025 20:36:09 +0200
X-Gm-Features: Ac12FXwzCJKlmymgO6Tj4uf0ucI0vUrdPmbW2MJgwWMNCE8FGoBeble7gcVJpVY
Message-ID: <CAFXKEHY61+OqwpOUJau+9afn3C6dya6AkAjfmrf+F=2bnFE-vQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/8] iio: accel: adxl345: add activity event feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I appologize for late replying on this topic.

On Sun, Jul 6, 2025 at 6:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 3 Jul 2025 17:24:17 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Wed, Jul 02, 2025 at 11:03:10PM +0000, Lothar Rubusch wrote:
> > > Enable the sensor to detect activity and trigger interrupts according=
ly.
> > > Activity events are determined based on a threshold, which is initial=
ized
> > > to a sensible default during probe. This default value is adopted fro=
m the
> > > legacy ADXL345 input driver to maintain consistent behavior.
> > >
> > > The combination of activity detection, ODR configuration, and range
> > > settings lays the groundwork for the activity/inactivity hysteresis
> > > mechanism, which will be implemented in a subsequent patch. As such,
> > > portions of this patch prepare switch-case structures to support thos=
e
> > > upcoming changes.
> >
> > >  #define ADXL345_REG_TAP_AXIS_MSK   GENMASK(2, 0)
> > >  #define ADXL345_REG_TAP_SUPPRESS_MSK       BIT(3)
> > >  #define ADXL345_REG_TAP_SUPPRESS   BIT(3)
> > > +#define ADXL345_REG_ACT_AXIS_MSK   GENMASK(6, 4)
> > >
> > >  #define ADXL345_TAP_Z_EN           BIT(0)
> > >  #define ADXL345_TAP_Y_EN           BIT(1)
> > >  #define ADXL345_TAP_X_EN           BIT(2)
> > >
> > > +#define ADXL345_ACT_Z_EN           BIT(4)
> > > +#define ADXL345_ACT_Y_EN           BIT(5)
> > > +#define ADXL345_ACT_X_EN           BIT(6)
> > > +#define ADXL345_ACT_XYZ_EN         (ADXL345_ACT_Z_EN | ADXL345_ACT_Y=
_EN | ADXL345_ACT_X_EN)
> >
> > I'm trying to understand the logic behind the placement of the masks an=
d bits.
> > To me it sounds that the above should be rather
> >
> > #define ADXL345_REG_TAP_AXIS_MSK      GENMASK(2, 0)
> > #define ADXL345_TAP_Z_EN              BIT(0)
> > #define ADXL345_TAP_Y_EN              BIT(1)
> > #define ADXL345_TAP_X_EN              BIT(2)
> > #define ADXL345_REG_TAP_SUPPRESS_MSK  BIT(3) // Do we need this at all?
> > #define ADXL345_REG_TAP_SUPPRESS      BIT(3) // or actually this? One i=
s enough, no?
> > #define ADXL345_REG_ACT_AXIS_MSK      GENMASK(6, 4)
> > #define ADXL345_ACT_Z_EN              BIT(4)
> > #define ADXL345_ACT_Y_EN              BIT(5)
> > #define ADXL345_ACT_X_EN              BIT(6)
> > #define ADXL345_ACT_XYZ_EN            (ADXL345_ACT_Z_EN | ADXL345_ACT_Y=
_EN | ADXL345_ACT_X_EN)
> >
> > (Yes, I know that the mess is preexisted, but try to keep some order in=
 the
> >  pieces you add here.)
>
> FWIW I fully agree on keeping field definitions and field break up togeth=
er.
>
> The ACT_MSK is a little odd as thing as then we'd expect there to be bits
> within that. So that FIELD_GET(a, ADXL345_REG_ACT_AXIS_MSK) would return
> a value from a list of things like
> ADXL345_REG_ACT_AXIS_VALUE_A and similar.
>
> So I'd not define that as a mask a tall but just use the
> ACT_XYZ_EN for it as then it's clear you are checking for any of the
> 3 bits being set.
>

The reason is that ADXL345_REG_ACT_AXIS_MSK is used in the evaluation
of the incoming interrupt status register for "activity" events, and
ADXL345_ACT_XYZ_EN is supposed to group the enabled axis, when
enabling the sensor feature "activity" in the enable register. At the
end of the day, using only one of them would work for both, but
there's a semantic difference.

Given this explanation, would you prefer to see a separate
ADXL345_REG_ACT_AXIS_MSK and ADXL345_ACT_XYZ_EN as presented here, or
just one ADXL345_ACT_XYZ_EN covering both cases, i.e. the evaluation
of the interrupt status, and enabling activity axis?

> Jonathan
>
...
Best,
L

