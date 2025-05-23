Return-Path: <linux-iio+bounces-19817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7259AC1AB5
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 05:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AFB17F3F9
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 03:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B932DCC02;
	Fri, 23 May 2025 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfN4V4JS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0717A31E
	for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747971518; cv=none; b=jy/2+oGhbj4/CdRZdtZdIvShh9J+yVAH4Ma+EfZ6mJJ+ZV9s3IGetpWiuy0D2zMlOZ5MlG1H8t4eUI7GDNyF8Yz9MxuwlqHvrnzzelCaYDXE8N4ph8n/AZNOJozWYYt7s/NelhBw5/VLePQIdGrk4xb8Y1Gk1IJlM2wwi3udlxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747971518; c=relaxed/simple;
	bh=gY81IBqdr2MJJpdeAjhACwU/lqkhSINg2XzYOOt5NjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rv6sAKiEBJLNpJGFTLTLjkCvUu0olbe4BzF58wY4nfPxx/k0z61j758X2QNsnYFjTW6gDLlG5DG7RqJ1DVKjQB9ABhO+sBTe3D3z8GcJ9Zl7cy9KdZy9QXgKx/hDIU6ugflt5MbCA5tUG7dTGGkfQxNCNwN1J5kAdagEnXdFhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfN4V4JS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a35c894313so5921123f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 20:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747971515; x=1748576315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8E8fs4w9nbh5X9DvFltT69S7NoWxtHx4dMDftWnVp0=;
        b=wfN4V4JSVn/vhE6YkEF5nHeb8wxue9Op32fMqORDlAmOKf4HOH/pXlYhEaROz2Sejr
         JIRb3YxyYFhHy4sUTYNJQPr6MbmIJL+4GV35B2iOaY64fvMvIAPbRVIPFvySolFFxgnB
         QrMp1Kb4bJunodFAoZ181zhKSym/yrh4gocj2kq/HenLni5jQme4GpeLv3+q/PWqMQi2
         s3lYwB33GVlwpKx0iUisd4sB8kucPdWm4Pg6/H52tPOGPIvBDFERAtwbBGPbxtsGUtFc
         YZ2kCMXXCuRiqC8DQyYjZLg6YiXg7JzzwoKOhXvfS7XBeQAX0V+McxW+M/RimJMa0SoH
         px8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747971515; x=1748576315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8E8fs4w9nbh5X9DvFltT69S7NoWxtHx4dMDftWnVp0=;
        b=adZtXR/lC+88cnmurfcLSGAZXnbUNAe7/LcLa07+JbXCn5PyZibWWy0Z/5FgYpwE0B
         JTrHcD7tvNTqXLykPmr9zthHfrS40vHtGyzRC03BSSCBumFiUHXGG545utUyUOXYXDn0
         LrUm3FrNI0z2rl5Ec9yPLYx7Y6ksYlXpMDwB7SQ7BmpcoeHYSD4lCpSs4tpttrNeuihX
         xNQyNjkCjVwrWCPIUIFg9Nnm1TK13yRGhdQ/p0lF8WDB2Vkvrw3qmIQvgGJbySl4bHFj
         ErVDYayDBIXvzsXRj3kekCU2/Ms7IRlzoIditw6SRSMqsSIATWX/budm8fr7kcZYVXCI
         gyCg==
X-Forwarded-Encrypted: i=1; AJvYcCVtQBzHm4p8uGFTgRNouhBmIs7YOXDXWIxZDz5t5ouSYtQvt2PILt6e/u7tb/uveLxGRMmhZ5Uq5Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyafLvx896zLIm9UTooIuoKDXsWEU03fjbS8huOdUHbqEvBlLbU
	T+uPxhNh6BGeOqsveT2quFcDSP/8M2y9ByFxQouylJDA46httW7kWWxbwLWx0gl7egFqEO4B2zy
	GeDEJ/tSGmjqEanZfpuujvzRzBJVbgbrRkDH0K+dg
X-Gm-Gg: ASbGncuclYCLum+zE9T0QEpU8Yu62eLay9KkHVrDyvfGYZ9OTNcpbrZtbFSt4DtH25P
	w8cRVcpOKg/EDUi9e9LDYw/K29i/u66+0HH+F2m1zbxCK/4UGdYZ+T3L+XJi5C/oWb/nH7nj32Y
	gSc8MwMAafQ0fhfAVbuoJzf1c6jTS2yGxdAVQD7eRx6xh+kcI44wyQl44yNQhKeclK6xqEfWCwj
	i46
X-Google-Smtp-Source: AGHT+IEJaEktgtgyt9q3yUhzR2G7nmOfMZxNVT3kv4+VFkzgEKvvFdgM7p2S4DqKo4aPHY84alinuUOiJAp/QCa7Z58=
X-Received: by 2002:a05:6000:4383:b0:3a2:561a:41f1 with SMTP id
 ffacd0b85a97d-3a4c20ef539mr1184990f8f.12.1747971514663; Thu, 22 May 2025
 20:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235108.2088274-1-gwendal@google.com> <aC6dLPFopj8lL_kE@google.com>
In-Reply-To: <aC6dLPFopj8lL_kE@google.com>
From: Gwendal Grignou <gwendal@google.com>
Date: Thu, 22 May 2025 20:38:22 -0700
X-Gm-Features: AX0GCFu_BZF3aBPGImWHmjWLu1DHuR7AqS4yOljLRbGRRdxyI2Gte9UZr1OzD6I
Message-ID: <CAMHSBOX9sZYMysbdv2Qt7h-R+1TMSjnr3kCfo3LnmcRfBfdOwA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros_ec_sensors: add cros_ec_activity driver
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org, chrome-platform@lists.linux.dev, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 8:42=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Wed, May 21, 2025 at 04:51:08PM -0700, Gwendal Grignou wrote:
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/dr=
ivers/iio/common/cros_ec_sensors/cros_ec_activity.c
> > [...]
> > +/*
> > + * cros_ec_sensors_activity - Driver for activities/gesture recognitio=
n.
>
> s/sensors//.

Done.
>
>
> > +static int cros_ec_write_event_config(struct iio_dev *indio_dev,
> > [...]
> > +     switch (chan->type) {
> > +     case IIO_PROXIMITY:
> > +             st->core.param.set_activity.activity =3D
> > +                     MOTIONSENSE_ACTIVITY_BODY_DETECTION;
> > +             break;
> > +     case IIO_ACTIVITY:
> > +             if (chan->channel2 =3D=3D IIO_MOD_STILL) {
> > +                     st->core.param.set_activity.activity =3D
> > +                             MOTIONSENSE_ACTIVITY_SIG_MOTION;
> > +             } else {
> > +                     dev_warn(&indio_dev->dev, "Unknown activity: %d\n=
",
> > +                              chan->channel2);
> > +             }
> > +             break;
> > +     default:
> > +             dev_warn(&indio_dev->dev, "Unknown channel type: %d\n",
> > +                      chan->type);
> > +     }
> > +     st->core.param.set_activity.enable =3D state;
> > +
> > +     ret =3D cros_ec_motion_send_host_cmd(&st->core, 0);
> > +
> > +     mutex_unlock(&st->core.cmd_lock);
> > +     return ret;
>
> If either activity or channel type is unknown, does it still need to send
> the host command for writing the config?
Fixed: argument checking now done in one place.

>
>
> > +static int cros_ec_sensors_probe(struct platform_device *pdev)
> > [...]
> > +     /*
> > +      * List all available activities
> > +      */
> > +     st->core.param.cmd =3D MOTIONSENSE_CMD_LIST_ACTIVITIES;
> > +     ret =3D cros_ec_motion_send_host_cmd(&st->core, 0);
> > +     if (ret)
> > +             return ret;
> > +     activities =3D st->core.resp->list_activities.enabled |
> > +                  st->core.resp->list_activities.disabled;
> > +     nb_activities =3D hweight_long(activities) + 1;
>
> See review comments for v1 too.  Moving the line just right before the
> following devm_kcalloc() for `st->channels` makes more sense.
Done.
>
> > +
> > +     if (!activities)
> > +             return -ENODEV;
> > +
> > +     /* Allocate a channel per activity and one for timestamp */
> > +     st->channels =3D devm_kcalloc(dev, nb_activities,
> > +                                 sizeof(*st->channels), GFP_KERNEL);
> > +     if (!st->channels)
> > +             return -ENOMEM;
> > +
> > +     channel =3D &st->channels[0];
> > +     index =3D 0;
> > +     for_each_set_bit(i, &activities, BITS_PER_LONG) {
> > +             channel->scan_index =3D index++;
>
> This doesn't look correct.  It generates some unused `index` if the activ=
ity
> is unknown.
>
> Moving the statement to the end of loop?  See review comments for v1 too.
I now understand the v1 comments. Fixed.

