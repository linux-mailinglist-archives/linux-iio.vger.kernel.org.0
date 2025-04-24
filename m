Return-Path: <linux-iio+bounces-18591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE2A9A4A0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 09:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B937A8FE8
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202420E328;
	Thu, 24 Apr 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+nsmLfl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BB1FCFF3;
	Thu, 24 Apr 2025 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480676; cv=none; b=hr3iVh+aBACyzx5ogqKaL+I0Bx4cI3IGPCJ4ZllNWQajOQSRlzjfvgt02XP+Pn2QM4MTtFfQ8y+bLkBrSHbIisBOkBdz4ih1Jhx93oVe9W6CgLXiYFqhS3daElRm6oiHVMboOP1zwZmUfraPclx8swxpgXmjdhz0zSWlxUGLsqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480676; c=relaxed/simple;
	bh=FFC4CWwJ3J/6ue2pTv1yj5qQxvmBEsYXmSdGmslQgWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmYP96kfpl9pOOwfL5y7lO1dyThGyiPC7Hy6YMpFXkmq435VU+CmR4H/0dq2sN5OF76U61wzILhpAQI7cjUo7zjH0bqAzq1eRRQPQV4Nc4gXQc/FLheD4o8w+7mmEpjv1WjBwZ/20pH8qLU4uNgPNRXXaf89oM9TpKiL8qNcY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+nsmLfl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so4069365e9.1;
        Thu, 24 Apr 2025 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745480673; x=1746085473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FFC4CWwJ3J/6ue2pTv1yj5qQxvmBEsYXmSdGmslQgWU=;
        b=C+nsmLflct4OPBhAo1ZvuRwsIcGw168Ti0BXxdX8Idm4WPGPYGdk3ioY18hMmqgi9K
         Bp5pYdZZkBF/Gnl+1F9GoD6mrWq3BjjCgvwMbF3cnHfnrftPN4Cs2AQ+T3pKtATkJVzM
         1+B9dsjdNVZgSGu5/79sII4mUudWDAV7kxPpMSFJR6+tew2wzQ+bgLLoTOq5uDZJLYJQ
         z5z8w8znWa52zYc/OihNu+BU/Xw5xtacO2y8p2TtbfYa2tZ0uTI57i0Q21S7vmPb/80r
         Uyun5DZTnLWurB/9cRQu1wzeHLxVUjKPfLXMvdE/eE9TyQtXLmQTcPjfXUUdFaHIk7Ii
         GMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745480673; x=1746085473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFC4CWwJ3J/6ue2pTv1yj5qQxvmBEsYXmSdGmslQgWU=;
        b=PsfWQSF2aqTdwZYppNy+eMQgM4+L2VRF4c+ciOH+bUeEN7bIZ0AyhrzAxPJI9LZTvP
         3vong+WWM+beeyupzeAfOXDtTtHY3jaCbooo8zW9JBNSRIdYoomBVo38eEGSB5VLW6gG
         3boCdAJXORo7rPsjsHVa8vTaGrU6nWb1+idsMP3OtsAhDFQsomOHo+Y26dWFa30BuJ9H
         XzZ9RwNcqkDYedsgKLo7s+Gm5XLtGb0h93nxBpFXGWjTAnb9pkk93FBx9Ta8QWJhFKKn
         XOo1M8WngjFObuXlIhMqCvtz1X7f+SXHf40x87AKxVOBMfLChzsVKeQYmC428AO0NZ2q
         gp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFR8GuW24N9QOIQorHd19cDF3SE6EkOE6rgYhzPD4HYp6IBgv/89TmGgExODOT9Tm8aarZCPWkoxU=@vger.kernel.org, AJvYcCXNCLfH58wzrl+ut5AcAE5ZB5+to7sTnS753u5tcLFhY98ek+/lepO5vd1j2sWOHmrQ73qhnVx/0PHlnI1v@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDxmjXvCWomMKh2l+JkQmAn/bHf00gOYBWFbQ7XPLraKsvgct
	o0alGxmiwOecZpmOrezn74O8vPgD7OO7ZvReTcfKPyey/qF8hYzA
X-Gm-Gg: ASbGncsgpCUFVP5JbcF9iOi+9S/I2ldGHcStGw3/Nx7os6crVdFI1FTsoRjHpKGMemJ
	/WQ8QQDpGQ/4FI0VvjfybtQlrtFRUbGJgZVA5SzbB3p68Ky6vL4horqLijttbY3Ky9WmW+m4Bvw
	njxDA1R3+RczkgS/Yc2opK9fi8SRSAw9O46sW9T6+vLprVho6RfVxfT6EmsTFH+ayjp/nj8/Fgb
	esFA1M7HDkXvzgF3EJi08vwZqd3Wqt8VuSP0t5V8rJ/GU/ZEPBVclgFeI6XKqf/jE2BsmkUYJtB
	BuuMdcFoM4H29DlqFrQot33EYaGjn+w3pr5oMGtOrnD6Ps6ni3SfU9MuEB53bzaLiiQP5oZS+uG
	V2nq0Qbl64ine
X-Google-Smtp-Source: AGHT+IFQ1Uepev3bF6DqMnMwT/ZztF4YDs7mV/bmiMaJ/9BB2oeeGflOhD/8srCT4ufJnyMLRmDzeA==
X-Received: by 2002:adf:e30c:0:b0:39c:1258:2dc8 with SMTP id ffacd0b85a97d-3a06cfb208emr940912f8f.57.1745480672986;
        Thu, 24 Apr 2025 00:44:32 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d54c246sm1124123f8f.86.2025.04.24.00.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:44:32 -0700 (PDT)
Message-ID: <3f3906e76ef6d87a12552b99d8f5bf9e34724677.camel@gmail.com>
Subject: Re: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Eugen
 Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Thu, 24 Apr 2025 08:44:36 +0100
In-Reply-To: <CAHp75Vfa0spzCW8WmR32N7u55N89kxywK5uuYMZDJUNHwSZoDQ@mail.gmail.com>
References: 
	<20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
	 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
	 <701bfc6a715046044dbc789f1c11c7f85395c7a8.camel@gmail.com>
	 <b4218efe-3785-4065-a3f7-57824e882f09@baylibre.com>
	 <CAHp75Vfa0spzCW8WmR32N7u55N89kxywK5uuYMZDJUNHwSZoDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-23 at 18:43 +0300, Andy Shevchenko wrote:
> On Wed, Apr 23, 2025 at 5:51=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> > On 4/23/25 4:18 AM, Nuno S=C3=A1 wrote:
> > > On Tue, 2025-04-22 at 17:07 -0500, David Lechner wrote:
>=20
> ...
>=20
> > > On the other hand, as I mentioned in V1, I think that an assertion or
> > > BUILD_BUG_ON_MSG for making sure 'count' is a compile time constant
> > > expression
> > > would be helpful. Sure, we'll get -Wvla but some developers might sti=
ll
> > > ignore
> > > the warning and send patches with these arrays. So, it would be neate=
r if
> > > we
> > > fail to build and force them to fix their code.
>=20
> > BUILD_BUG_ON_MSG() won't work because it expands to a do/while loop whi=
ch
> > won't
> > work in static struct declarations. But I can try to see if we can come=
 up
> > with
> > something that works.
>=20
> I guess Nuno is okay with static_assert() and TBH nowadays the
> BUILD_BUG() as is most likely historical.

Yes...

"...I think that an __assertion__ or BUILD_BUG_ON_MSG..."

- Nuno S=C3=A1

