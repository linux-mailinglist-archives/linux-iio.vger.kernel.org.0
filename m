Return-Path: <linux-iio+bounces-13466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39269F1F9E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31B4161BA4
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393861A8F72;
	Sat, 14 Dec 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSiC3YP/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCC1A0700;
	Sat, 14 Dec 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189390; cv=none; b=kg3Be3Ge6A2Z6JHGkkrajGdIeeAlr28lz3lmXfbZTaflwyI+w1nw79Bqk/mfnRwYDw1yrApEohP0BzdXbsDOD0H4VIDtU2F5Yay3EqN7nBdvrmHFJsWizg3ZoVCMQkPseQIRjDl1M1m8tRuxvSlvV5uX7nWmYKTeedlZW17P5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189390; c=relaxed/simple;
	bh=BWvK3U1CIWg9LcX3W21o5tsKZfNdnh55oTlqnwLp1Xc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b0xzlpXO5q9Y09fIUsgkAP5rcyy1pYXCL3T8BDYx2qLpVkIWYnYv3dEEhwost7AgW89iletETsLlixsllq7s6cyj9A2GqoFiVZPAITnu2a0O6s1TE+UmlOoM6kjbUTdYmo4zAXIZjqgGfzxrDVG59kaQFbmm/JsjobgpU8loOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSiC3YP/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso10851615e9.1;
        Sat, 14 Dec 2024 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734189384; x=1734794184; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E3Emzcg2tKB9CFmyIgMQvl5U8sGNCEkWi+a0A2Q4Ag=;
        b=QSiC3YP/AB8KUdXsNfe1qMlFsQ24sMZrUjAdanv9ukOO1YNoWhXtbqzzdJ2dNPIS6Y
         punjCu0YmvHBgDvEIc9n0JtngkdOjTbGp6UFz7obN33S6Exj29+pPpPfqp7RFbW6idjN
         agT5WYzDObpLTptU0sna7MMs2iuzF3qskU8oBHoJBFBxoCCizJAY7liHood8rU/Z/151
         snOltVwjE+nOOt3RDRi+fQw+R9XX39j5n9yPSCsibwjx4MnYkViiE31HTYAxg8vdmzyG
         vYHBSc50mcg77Fwyqkt8Ow0RNPJ2ovLmpBJK2k2yoRgXjwpSXLxPnp9xO4mMbIDoLPLq
         0E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734189384; x=1734794184;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3E3Emzcg2tKB9CFmyIgMQvl5U8sGNCEkWi+a0A2Q4Ag=;
        b=kLvuoX+/cHY6yH1uoOjtf0rAU+EWTthXrYd3IYa0ZGfsy/4Ok/fCfVo6YPMO38DkP7
         Z0PkPPj2GR4/zjTM3bkqWbyNnuq1mlaOhrtwazcwQ4yj6jQU5ZhjUlJUIVQW/azxovk1
         f8ZdXHE6BK7AZxN0wUZXViIw15VVmDwg0JgVT35YwarC1VSc7T/79fCMiv2RPjf8qeBn
         /66+GOD2izmKOqlV0uWakjk65A7v8NjfpLqwfLYJVldX+EhtetUMJV2hsXCtsT2wq4Ha
         tHZN1w7C/bJi/Lkr57ivfn3ZPPCuA3obFslLObJUspdHVZ0gQvWzYQwNXxQljBnWBCgU
         tg+w==
X-Forwarded-Encrypted: i=1; AJvYcCXP5PtmKA0eJc/Bqlxvf9fqLY3qjTeRpCnkOVHtIm/xjhkcaGzwKYJdHvNi9hzG7ICizN5rmeDMY+4=@vger.kernel.org, AJvYcCXQ0tzrrB/OM94ylK2PEUmuZw888x3+Jsg0BZ398j4Ur/nAYG4UDsl4zbTKFH24KGKP1Bcq58iUykzZxVJk@vger.kernel.org, AJvYcCXj0a4Evf2X7OTT/w/irseXTT17Y/zfh6XfV13AwUBdzwpfnM6s9XLc3koL63v374ehyXzHwaFr@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkWvSpbmPrQh/7IcfiGB6Kk7GuuHAM2pHskIv7efpUqfqLiGk
	IbciMH/JMZhyOV4GOvC8trz3/HJt2mk9UjivT0Cr07Ns6ZTcp2AF/dZQHA==
X-Gm-Gg: ASbGncsDZkOAOIc5jBzNE1fZxzmoTVyhxIjiwQN2QiiIs3BOeW53XID80IZ+QXOYPW0
	LvDhsyn5sYt6upbUh6L4QbDbfS908Qv4xye1drc865wGITHgtsYk2pWqcHYsJjINR1EKYbVB0q/
	Y1josGejgqQMoMsDNZyfB33HkHPF6CfYgH8yTQhyc2yJoHozU5i+rdG2RQcMSfD+rHrJwALJaNQ
	ZRh/1gMbec0sND7l5nHdgq3N42G9hcfxLvpw2SNPEAYpCeGeYOEw1a0UBhNWoRkO0fI42xD49IX
	ElJfqRv4IQaPMfnCQU8rK217/wFUxI1mRNwtBU0zAkLruKYL8vk7OCCXAgn2PH3xrE5DoFzDDCw
	Q
X-Google-Smtp-Source: AGHT+IHfclEaSoADB5/v+XdsN5Dn9CTN83YsZGxIn6fnmCxJH39svoKWHbW07lMnyyrUYa3Z7jojVA==
X-Received: by 2002:a05:6000:4616:b0:386:1ba1:37dc with SMTP id ffacd0b85a97d-3888e0bd631mr4417117f8f.47.1734189384235;
        Sat, 14 Dec 2024 07:16:24 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-330f-5008-acc6-6cc2.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:330f:5008:acc6:6cc2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804a34fsm2840467f8f.76.2024.12.14.07.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 07:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Dec 2024 16:16:20 +0100
Message-Id: <D6BITV4LNT71.O2XWAQNX16MV@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Christian Eggers"
 <ceggers@arri.de>, "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3] iio: light: as73211: fix channel handling in
 only-color triggered buffer
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241212-iio_memset_scan_holes-v3-1-7f496b6f7222@gmail.com>
 <20241214142221.3412ad9c@jic23-huawei>
In-Reply-To: <20241214142221.3412ad9c@jic23-huawei>

On Sat Dec 14, 2024 at 3:22 PM CET, Jonathan Cameron wrote:
> On Thu, 12 Dec 2024 18:56:32 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>
> > The channel index is off by one unit if AS73211_SCAN_MASK_ALL is not
> > set (optimized path for color channel readings), and it must be shifted
> > instead of leaving an empty channel for the temperature when it is off.
> >
> > Once the channel index is fixed, the uninitialized channel must be set
> > to zero to avoid pushing uninitialized data.
> >
> > Add available_scan_masks for all channels and only-color channels to le=
t
> > the IIO core demux and repack the enabled channels.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 403e5586b52e ("iio: light: as73211: New driver")
> > Tested-by: Christian Eggers <ceggers@arri.de>
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> > This issue was found after attempting to make the same mistake for
> > a driver I maintain, which was fortunately spotted by Jonathan [1].
> >
> > Keeping old sensor values if the channel configuration changes is known
> > and not considered an issue, which is also mentioned in [1], so it has
> > not been addressed by this series. That keeps most of the drivers out
> > of the way because they store the scan element in iio private data,
> > which is kzalloc() allocated.
> >
> > This series only addresses cases where uninitialized i.e. unknown data
> > is pushed to the userspace, either due to holes in structs or
> > uninitialized struct members/array elements.
> >
> > While analyzing involved functions, I found and fixed some triviality
> > (wrong function name) in the documentation of iio_dev_opaque.
> >
> > Link: https://lore.kernel.org/linux-iio/20241123151634.303aa860@jic23-h=
uawei/ [1]
> > ---
> > Changes in v3:
> > - as73211.c: add available_scan_masks for all channels and only-color
> >   channels to let the IIO core demux and repack the enabled channels.
> > - Link to v2: https://lore.kernel.org/r/20241204-iio_memset_scan_holes-=
v2-0-3f941592a76d@gmail.com
> >
> > Changes in v2:
> > - as73211.c: shift channels if no temperature is available and
> >   initialize chan[3] to zero.
> > - Link to v1: https://lore.kernel.org/r/20241125-iio_memset_scan_holes-=
v1-0-0cb6e98d895c@gmail.com
> > ---
> >  drivers/iio/light/as73211.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> > index be0068081ebb..4be2e349a068 100644
> > --- a/drivers/iio/light/as73211.c
> > +++ b/drivers/iio/light/as73211.c
> > @@ -177,6 +177,12 @@ struct as73211_data {
> >  	BIT(AS73211_SCAN_INDEX_TEMP) | \
> >  	AS73211_SCAN_MASK_COLOR)
> >
> > +static const unsigned long as73211_scan_masks[] =3D {
> > +	AS73211_SCAN_MASK_ALL,
> > +	AS73211_SCAN_MASK_COLOR,
>
> I probably mislead you on this :(
> Needs to be the other way around as the core code starts at first
> entry whilst trying to find a mask that is a superset of what is turned o=
n.
> here that means it will always use the first one.
> See iio_scan_mask_match() - strict isn't set int this case.
>

Thanks for your feedback. I copied your suggestion, but it was my fault
that I did not make sure it was right for the intended behavior.

I will send a new version with that fixed soon.

Best regards,
Javier Carrasco

