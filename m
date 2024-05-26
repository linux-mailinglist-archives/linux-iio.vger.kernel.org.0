Return-Path: <linux-iio+bounces-5316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD968CF46E
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D531F214C6
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518E1095A;
	Sun, 26 May 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cxKGFPgG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3AE57F
	for <linux-iio@vger.kernel.org>; Sun, 26 May 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716731615; cv=none; b=QJPB046owpAjvQBK59H+7i4huFZo5WMghzFQhOwWh3WRBOkCkp1+bG2JIxtg6Hye4RnWZbGWvIGgn4KpdD6w/kjR2NG0ZMPpSKH1j0l6WJO1wmj99CkqPUYXTj2/n+tgfQs4i85k3rwJc3N4RB+yj6gfdmdhPkFTytxsZman68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716731615; c=relaxed/simple;
	bh=4DUJdEjkxUJgbaVeUQ4R/vAmvDf9VaruCLYklc7L/oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBuFOdzqAqluH4U/mk/IZe/EgEjyGWMn933LFzUbCPuu4Orp1pUJcT34roWmpqLSM8+K5kD4V1R+XX28Ma+aXVJfulHQwXlq0zazknOGOGlzSI1id+jbFNEAtuffyzS6y/B8YgVu6/eceTxBlCkypxP5sUI+Cu6jJk+TXdg35CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cxKGFPgG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e8a8ff4083so42429271fa.1
        for <linux-iio@vger.kernel.org>; Sun, 26 May 2024 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716731611; x=1717336411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ+eNpUujXQv/I2aShP9JWthU8Vec/B5xvxOzvo8tV4=;
        b=cxKGFPgGZ68mZSWsYvec53i7XZroE2awZLgXNTFhBzx1hDU6epJ1DWpwRGkvXGpJLh
         Bp4XLvAD4dT3VM7ewDJbaF8Pu6u3hqNZWKHCdJf0xVUa91WFcXpc8lVuJoHtize50iAG
         TMdOMgnQiJKyI0VDnqIN70/E33H4uUn7fMCwhu7pyBu/G0rho8lSTM6Wi8prGQK1Wk4X
         eaCcKA2sKMuqtZ44tlifKj5coSOzR9+xpnXunH2+1tYHE+PAgj8kINSqHf8L4U/OwaxW
         k6rYEJJ8IMx6xyQjkwbff9VOQ860L8R3yoD5w1yrW6NPWXLvboNfi1ZYNASEEqRZNV13
         ++Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716731611; x=1717336411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ+eNpUujXQv/I2aShP9JWthU8Vec/B5xvxOzvo8tV4=;
        b=OZmTQXhXL8KPP9+i1QdyfupwJoKy7bjxIt9h2uxs5tShKJ3HN5PnDQWL5PxLnS9SKO
         Xr1XlnaBfFRWEMvUxGwcBE2pofCVhxC5KGrIV1m9bYBxJjEqxehmG7034nnRpT8U+Tl1
         Fc+KZKBte+c8qnDM/cMlR96YHvGjHnRnc5/GZrP2wJeKp9vxLTzGzozAG9ItmABbvbqE
         hJyELJoEm2qdxt4f3rQej3s+kS7eGpdFUCF784nhQXvEekDeBiuuvhfr4KD7ixINAvg7
         S0mHVbEFt9lsdUZK9W3WFxMJQl1lDSxjh5HL781KVTy42Ai+nNSrrjV2j4FpxbNRn9Rv
         blMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTXRu3kpeFO2wHpyCbBKftZpwu1yqUawIEJ4ZBF5HT1u34jhdpeDfQlxFX5yBIaeE7idhKzT/9Y7CRBk5wn86HXdkLKRd8p/yK
X-Gm-Message-State: AOJu0Yy1gkge+aF8OD0/+cKG4UELsUcjsNW5CX0uesua5ZrjYhb8Ulfg
	824OSAwYvABzUTH5XcQnygo1CTJc6BAL7kQKEItnmZcxhgWJmZGrhZ9OrdGE8VqvODVl7mtkQo/
	Pu+zSDUyO+SbK+43ISb398iTR2qv4Y8kckAiB9Q==
X-Google-Smtp-Source: AGHT+IF+3IQbVc77xxtstsfMGHkyaHT/cjv5L3bC7b2v9W3j5znvEb5jOZ19F7ugtzBYR5T7s4xn9B427/FHrhZj/nc=
X-Received: by 2002:a05:651c:383:b0:2e4:dd5c:933b with SMTP id
 38308e7fff4ca-2e95a095ef4mr21960481fa.2.1716731610673; Sun, 26 May 2024
 06:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
 <20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
 <20240519201241.7c60abac@jic23-huawei> <ebf18ed1-a82f-4c0a-9a63-2c428b5aee40@baylibre.com>
 <20240520171205.000035b0@Huawei.com> <5cf036d5-1eb3-4f63-82f9-d01b79b7fe47@baylibre.com>
 <20240525171408.36bda583@jic23-huawei> <003d0998-dd25-45ab-9bb1-feda2d0f91a3@baylibre.com>
 <20240526131018.40c772d6@jic23-huawei>
In-Reply-To: <20240526131018.40c772d6@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 26 May 2024 08:53:19 -0500
Message-ID: <CAMknhBGhk5VNG+L-HyT3=b2h38k0-dGwTfoWzxLTZfsKuidvtQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] iio: add support for multiple scan types per channel
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Julien Stephan <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 7:11=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 25 May 2024 12:04:46 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 5/25/24 11:14 AM, Jonathan Cameron wrote:
> > > On Fri, 24 May 2024 10:56:55 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >
> > >> On 5/20/24 11:12 AM, Jonathan Cameron wrote:
> > >>> On Mon, 20 May 2024 08:51:52 -0500
> > >>> David Lechner <dlechner@baylibre.com> wrote:
> > >>>
> > >>>> On 5/19/24 2:12 PM, Jonathan Cameron wrote:
> > >>>>> On Tue,  7 May 2024 14:02:07 -0500
> > >>>>> David Lechner <dlechner@baylibre.com> wrote:
> > >>>>>

...

> >
> > Maybe we are talking about two different things but calling them the sa=
me thing?
>
> I'm not sure.  Sounds like we both think our point is entirely obvious an=
d clearly
> it isn't :(
>
> > > Key is the complete lack of
> > > association between what is returned by the get_current_scan_type() c=
allback
> > > and this ext_scan_type array.
> >
> > Why would the caller of get_current_scan_type() need to know that the
> > returned value is associated with ext_scan_type?
>
> Because you are validating ext_scan_type, not the return of get_current_s=
can_type().
> They may or may not include the same data - to make this a good interface=
, that isn't
> error prone, get_current_scan_type() must return one that has been valida=
ted - i.e.
> is in the ext_scan_type array.
>
> I've looked several times and maybe I'm just failing to spot what ensures=
 the validation
> is sufficient.
>

Ah, I finally get it now. I was having tunnel vision and it didn't
even occur to me that someone might be tempted to return anything that
wasn't a pointer to the ext_scan types array.

> >
> > >
> > > So either:
> > > 1) Make it do so - easiest being to return an index into the array ra=
ther than
> > >    a possibly unrelated scan_type -
> >

This option 1) makes sense to me now.

Do we also need to validate that the index returned is <
num_ext_scan_types in iio_get_current_scan_type()?

