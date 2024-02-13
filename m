Return-Path: <linux-iio+bounces-2507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A27852C0B
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 10:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D0F1F215FC
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0643E21A1C;
	Tue, 13 Feb 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnTfr5FS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605922612
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815500; cv=none; b=IBKh8DnyJekxJbUB7n6FEkObEtghhrWhvlZs+v6zRFKonhmgrezcJI2/vhqaTBMfLQamiCLfvbkKpNp3e1lHEzBDOxfoTMq2QHBwG52fWge8QFaIEun7+H1HiqAyIoBIKn12Sx7JcbB43g3bqvgCcyKUhlYDeURqGXo6oN4cN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815500; c=relaxed/simple;
	bh=a93euNNAC/VSB1Vo/b7iTZRBldEwZRNPc6O9YMcu4fM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ID3sKrn5gXJW5K79GgOdBmg3TAw7cU50kR8myvemCqkSLOV7+aOpONjEsHqvLq64J5IhngLQ1KF6AOnaWf9FWlLBxZ3uZpWiEPC7dlNYDcMJiWIq8zJlWmaOlMAkbJ1PEcuSua8JtP72bRRZ0gRvQ8N2ZOb+030bE74nVb/mKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnTfr5FS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso4480656a12.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 01:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707815497; x=1708420297; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a93euNNAC/VSB1Vo/b7iTZRBldEwZRNPc6O9YMcu4fM=;
        b=cnTfr5FS9UMl30VfjyaDLo1YESnPve9JSgsP4kDtlmN8qXDbT8kq7ggZ8qJxYK0je3
         3SpzDpssx3E98HEIBZg5LzN/diWgnyHfry1hxTNN6kHuCZJ47ZKVBKAyozVhYd+cLX7S
         mI+LNgf2PLpqCBOimkKl08sO+GlGIuqCBDECaEYRUSgLVn+nhxzRLaUAlty/ITRfuQka
         KUmi5J8JTcY0aOLUUJTWWj21/WoDUL3R95avggKdoKj2jSUDFKba+RHtWqj8lJP/yWPL
         4yYPOES/XUxaMbvsBRZhABEKemXXlRykOZCd9lTNrpqUAg4EgZrhB29i9k8+UIzGzFic
         pK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815497; x=1708420297;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a93euNNAC/VSB1Vo/b7iTZRBldEwZRNPc6O9YMcu4fM=;
        b=r+boiLqIgdFrslIpKIvJOoV2xhM5m/8NZBS1afjp9AfsYYtvWzmT2ybxpzuxxLEUH+
         daT4Eo/TF06e6IWrf2+ZuN5p3CnWWV42oGMHmU5N8B9LS7rrk3ZF1fZnQy82wh1clVUU
         uw1DPNFd3sFRDBe3gnLnnkzLlyYQYtu/lOne7Tp/JS6iNuBJLRlEqzJYtpFxY/3MDTWl
         EsxPAI26wS0x3J0c/adElWELHE+WXc2rXD5wiqoQueo7jASZxSZLPKb+4/uFQCBUMxsT
         Jyx56Oth//XQKI1qDpi0X0CS0AW41IO93+85aID6H9pN6lV/gDwuttH6ODG7/YmOaLTd
         rK9g==
X-Gm-Message-State: AOJu0YwmK2kmmepoJhNRLXhYAqLkiV79OsWjcNNYAcpF9f3ZCpYUfZR1
	Lz/FFblaSLBx/XcyjheMX8zjCDhltTjHfKVEfvwAiI/NAYjRbLgtq9Ml062HtSAr9Q==
X-Google-Smtp-Source: AGHT+IEBAH4rTAaq7BylRVdiIyoclHHazJmSHfZCiJ8X59vkO35f1fiWRwieTYKx+7TJTS6MxaLwdw==
X-Received: by 2002:a17:907:bb96:b0:a3c:8002:3eea with SMTP id xo22-20020a170907bb9600b00a3c80023eeamr4279861ejc.43.1707815497187;
        Tue, 13 Feb 2024 01:11:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKoFGbLZYp8KujQotiqf1wqHAybBboxDs3FKqSlHBRo4jr28j7wEwLdclZXdDPXll+n4bo8dJvoyQb0foZgCnGs6zBdbjGpLJjTs2a1PFDlAr4hh4gMhW54G5nJn6uH+17A5tT3A==
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a3d12d84cffsm177889ejc.167.2024.02.13.01.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:11:36 -0800 (PST)
Message-ID: <7b1d8ba23916a3d67f20a91be3dac119a8bc42da.camel@gmail.com>
Subject: Re: [PATCH] iio: core: make use of DIV_ROUND_CLOSEST_ULL()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen
	 <lars@metafoo.de>
Date: Tue, 13 Feb 2024 10:14:56 +0100
In-Reply-To: <587e7de71aa8131a9a54a8f6e31762aa8ec1d22e.camel@gmail.com>
References: 
	<20240212-iio-improve-define-dont-build-v1-1-875883bb9565@analog.com>
	 <CAMknhBGEKJa_q2MD1q++mTAOP9SrJ_WVJv_CBP+s_8PiBgz2eA@mail.gmail.com>
	 <587e7de71aa8131a9a54a8f6e31762aa8ec1d22e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 08:51 +0100, Nuno S=C3=A1 wrote:
> On Mon, 2024-02-12 at 18:02 -0600, David Lechner wrote:
> > On Mon, Feb 12, 2024 at 3:07=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >=20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Instead of open code DIV_ROUND_CLOSEST_ULL(), let's use it.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > 1) For some reason IIO_G_TO_M_S_2() does do not a closest division. N=
ot
> > > =C2=A0=C2=A0 sure if there's a reason for it or just something that w=
as forgotten.
> > > =C2=A0=C2=A0 Anyways, I left it as it was before.
> > >=20
> > > 2) This conversion could actually be required. In some experiments wi=
th
> > > =C2=A0=C2=A0 it (in a series I'm working on), I actually realized wit=
h
> > > =C2=A0=C2=A0 IIO_RAD_TO_DEGREE() that=C2=A0 we could have a 64bit div=
ision in 32bits
> > > =C2=A0=C2=A0 archs. I'm still not treating it as a fix as no one ever=
 complained.
> > > =C2=A0=C2=A0 Jonathan, let me know if you want me to send a follow up=
 email (or v2)
> > > =C2=A0=C2=A0 with a proper tag.
> > > ---
> > > =C2=A0include/linux/iio/iio.h | 9 +++++----
> > > =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index e370a7bb3300..3ebf9fe97f0e 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -10,6 +10,7 @@
> > > =C2=A0#include <linux/device.h>
> > > =C2=A0#include <linux/cdev.h>
> > > =C2=A0#include <linux/cleanup.h>
> > > +#include <linux/math.h>
> > > =C2=A0#include <linux/slab.h>
> > > =C2=A0#include <linux/iio/types.h>
> > > =C2=A0/* IIO TODO LIST */
> > > @@ -799,8 +800,8 @@ int iio_str_to_fixpoint(const char *str, int
> > > fract_mult,
> > > int *integer,
> > > =C2=A0 *
> > > =C2=A0 * Returns the given value converted from degree to rad
> > > =C2=A0 */
> > > -#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
> > > 18000000ULL)
> > > -
> > > +#define IIO_DEGREE_TO_RAD(deg) \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DIV_ROUND_CLOSEST_ULL((deg) * 3=
14159ULL, 18000000)
> > > =C2=A0/**
> > > =C2=A0 * IIO_RAD_TO_DEGREE() - Convert rad to degree
> > > =C2=A0 * @rad: A value in rad
> > > @@ -808,7 +809,7 @@ int iio_str_to_fixpoint(const char *str, int
> > > fract_mult,
> > > int *integer,
> > > =C2=A0 * Returns the given value converted from rad to degree
> > > =C2=A0 */
> > > =C2=A0#define IIO_RAD_TO_DEGREE(rad) \
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (((rad) * 18000000ULL + 314159U=
LL / 2) / 314159ULL)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DIV_ROUND_CLOSEST_ULL((rad) * 1=
8000000ULL + 314159)
> >=20
> > Is this supposed to be "," instead of "+"?
>=20
> Definitely! Obviously I did some mistake preparing the final patch and ou=
t of
> confidence didn't even built it... Curious why clangd did not complained.
> Anyways, thanks! I'll send a v2
>=20

Ups, actually lets forget about this... Most users of these macros use it a=
t
file scope (if not all) which would bring us issues with DIV_ROUND_CLOSEST_=
ULL()
(no statements allowed at file scope).

- Nuno S=C3=A1


