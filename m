Return-Path: <linux-iio+bounces-20482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B52CAD5F9D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A29F189BC4D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADCC29B23D;
	Wed, 11 Jun 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEOoeZ7g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105EC8FE;
	Wed, 11 Jun 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671955; cv=none; b=djQER8+uH8uYEk0xz0T3xouvmQlBJNgQ9eC2+xM9Iw+m377H/frILjjReLwwnbO7iCi2ipGh8ChN/pmLwxzKHk23xFMKWFlp3yxuF6MGFmClu3lrDzfa7vuwvBqShSwOYhVXCzbYFmVgB9RkxAaj44YrBbEtHXwDkHqOMB6ItXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671955; c=relaxed/simple;
	bh=g5ZYbYOK1aUC0FTjWb74OVx65hmXOJFd6WWlyHG+nsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6qPDbmCyFkmUneaqg0nNjqZiReQ2lwjQWFdzg/q/USIlAjlD4gI9+C8TKRsab0uuSO8DfEx71FtSGqAkjQSlLQ78YWtycD3h917olbEtU4dInFLJCvRy5RRo5LLyrrxgiT0R+tjdCrDOvWSlR1yi8Qonn7CrgwooDbFiD/fS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEOoeZ7g; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70b684670e7so216857b3.2;
        Wed, 11 Jun 2025 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749671952; x=1750276752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxFme6q2BwhARk9P34NIeJ60XrHXGwqFtKOjSld0rp4=;
        b=PEOoeZ7gaLVjb/OaWMqDSwuaNAoCif3iRcbQsq+R+wxKqSQ5+TO7zwvsocTyihgby3
         Ek3Dzc2u2BNF17bUzsHGPWHgV918OOftsuBXRAryEhvu+MGjXZBEUWCPp56idHP5vHrO
         RaZX2FwWY7v1ZcYxz+rhFC0zsnpjihr9MrUN+63D5hWELUkvEi/bzKcCNGgwVcZsvD34
         6TJycGxwIWR5zGoVgB/CNG3wrZom8Lqt+3OMetJX+EP9fsLvKjaY5YHJSACKEZXZbiu1
         /72tFYasPzjwIgplkNQSUs6YPEAtHt+YELew3x36ySgCzr9A6BU3aemekFz37XW+JJnu
         E4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671952; x=1750276752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxFme6q2BwhARk9P34NIeJ60XrHXGwqFtKOjSld0rp4=;
        b=m3FIQ3JHoWFZAa0mWPjsDhBkwaVZfGkGCL+YzuGze54LJuJH1zSOzAV92Fg1ZY/EFi
         HOB6ePydVvvjUN8IGKglB/uCO3kcLJpCOftvct0Qn9Ezb/sIslCK+b9hye/s4DiveIdZ
         uBhaPcTO6BD3DU3NZS8WJRxrq4AMq294czu3V/ejBRsJO3lWYoTZHAyIfKMDiEETPsch
         W2bxNUVpaTkqbuk+GiV2Bcpf8jFxgJ59YFgHlbcWZg8m5ioMNWXvCyYz6Y0psMTfKn1W
         9aoYTqbfVnbETPJD9mJaICM6LALKmD61VvuM9jdmPTM40rFb3abjQi3nlsXf2OGo96/o
         gdGA==
X-Forwarded-Encrypted: i=1; AJvYcCUBP3wUGfJuZgPMi22lmKcxDa4jqYUb0z+lvHAHKv/w1Jd6ArB0nC0TtDvP8ITPdxXKHM5S0NwHBhk=@vger.kernel.org, AJvYcCVjtezlUz0T70aepLpSsqeN2kfYvkuluTKRsH4NboER7rN7HWWWBhln2MlfKWZOkBa2GmGVyzAk8Rwg@vger.kernel.org, AJvYcCXGlhA9TU4YDNwi+RQtC/UkW8pbpsmKZVKxjg4DZPO6POIHsyJajQbcZsY8pdzEh5OgMAy6vip7tMuF0CKg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5hKmPz9q0+AHWG9bEJj2ZPsjOSgcIEl+n4d4bUVYeyQXKtKh1
	699xe4jPv0I9gAjS4A/p1Cqcr5lhCP9rXHAjySrE7+hQpR2MGyYrXGbyYHBIDmUJo0EuCzmOkeL
	lMd3xrjIOSUSKHJFhw1OXywEjQsRT8R0=
X-Gm-Gg: ASbGncsuvAt9oCdqfyFNSulfzk5D2yjmdudSJLJP7/8usD8ATrEd9WH+jXJdZDLfYiz
	5Byb89Po6QLeiO9LhXx+nDG0bdkGEs8cRvr0b6lLYwwNqXCU5MUevFuGOTo8FO+4QPN2NbEB9nT
	QqX+Cw5r+Fyyw9wZJTlI7H1Oqqd5evURQHbTLzT4WqEt+4NpMGYj4ezg==
X-Google-Smtp-Source: AGHT+IGgnTLD9FiBr75NlfKlcMt5VyjwhnQidVERWleFWbPgSYjaA7xYm8HM59m3DuvQF61FZiTrWS8pj8XuscbbkK0=
X-Received: by 2002:a05:690c:60c4:b0:70e:86a2:9b3a with SMTP id
 00721157ae682-7114089c3cemr31099857b3.0.1749671952314; Wed, 11 Jun 2025
 12:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-11-l.rubusch@gmail.com>
 <20250608172317.63473b9b@jic23-huawei>
In-Reply-To: <20250608172317.63473b9b@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 21:58:36 +0200
X-Gm-Features: AX0GCFskRJiUUFIn6P0la-7-85XS-DoiKPtts1BFZLCEPQ5xBxG18pp3MvgD2mg
Message-ID: <CAFXKEHZj7nYOJA7Ztxh8xiOcPpwDNBzNyN830tiKL=7rL0fiug@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] iio: accel: adxl313: add AC coupled
 activity/inactivity events
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Jun 8, 2025 at 6:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun,  1 Jun 2025 17:21:38 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add AC coupling activity and inactivity as MAG_ADAPTIVE events. This ad=
ds
> > up an additional set of threshold and period handles, verifies matching
> > disabling functionality and extends setting the link bit to complementa=
ry
> > event configurations.
> >
> > This means, e.g. either ACTIVITY or ACTIVITY_AC can be enabled. The mos=
t
> > recent set will remain configured. Disabling ACTIVITY where ACTIVITY_AC=
 was
> > enabled is ignored, since it does not match (should be disabling
> > ACTIVITY_AC). When INACTIVITY or INACTIVITY_AC is also enabled, the lin=
k
> > bit will be set. Note, having the link bit and auto-sleep in place acti=
vity
> > and inactivity indicate the power save state change and thus will only =
be
> > triggered once a state transition occurs. Since there is a separate AC =
bit
> > for ACTIVITY and for INACTIVITY, events can be linked independently fro=
m
> > each other i.e. ACTIVITY can be linked to INACTIVITY_AC for instance.
> >
> > When one of both is disabled, the link bit will be removed. Hence, the
> > remaining event will not indicate a plain state change anymore, but occ=
ur
> > as a periodically triggered inactivity event or for each activity event
> > above the threshold.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> Minor thought on rereading this.  If we don't have the link bit set
> (and the paired event) the AC events are more accurately described as
> MAG_REFERENCED as they are referenced simply to whatever acceleration
> was going on when they were first enabled.   Only with the link bit
> set (and the other event type enabled) are they actually adapting
> (so MAG_ADAPTIVE).
>

Going by examples, I can follow you as practically I'm aware of the
difference between a plain inactivity setup and a link-bit enabled
inactivity(and activity) setup. Initially I thought of MAG and the
AC-coupled equivalent being MAG_REFERENCED. By your explanation I
understand why you preferred MAG_ADAPTIVE rather. But still all three
configurations are possible.

My idea is, the driver implementation supports all cases in parallel,
at least to a certain extent. I mean, at the current implementation
someone can configure plain activity, or AC-coupled activity, or
respectively, their inactivity equivalents - when both, an activity
type together with an inactivity type are enabled, they will be linked
counter events. I.e. "adaptive" - and auto-sleep will be turned on for
the inactivity periods. Built on using just plain IIO API w/o custom
API calls.

Due to all the possible combinations, this comes at a certain
complexity. In terms of configuration and for instance mapping to MAG,
MAG_REFERNCED or MAG_ADAPTIVE. Here I rely on your feedback. On my
side, I'll try to recycle the automation setup to verify registers are
configured as I like them to be using the sysfs handles (that's btw
the reason why I'm glad to have debugfs on board). So, if you tell me,
to change it rather to MAG_REFERENCED, I'll do it, but then AC-coupled
events will be all MAG_REFRENCED w/ or w/o link bit. Or we come up
with a total different approach, like putting link-bit AC on
MAG_ADAPTIVE and plain AC-coupled on MAG_REFERENCED, but then what
about MAG events w/ or w/o link-bit? hmm, I think current approach
seems to be a good compromise. Let me know what you think.

Best,
L

>
> Maybe there is room to use that to ultimately control whether the
> link bit is set or not (putting aside the power aspect of that).
>

