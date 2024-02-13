Return-Path: <linux-iio+bounces-2502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E17852A42
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 08:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A7D1F22853
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64647179A1;
	Tue, 13 Feb 2024 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Ci30tQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AEE1773E
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810488; cv=none; b=Y25huWuKNq66ZnkUaYvFJ/l4GceDZlSzAP4on+nHwMD97EoVkKBHi7R9Y+n9GbCyTsIUfUJYGGPiPiFfY+vSVURZhg/w0+U+TJfH+w7BdU12rSdnG/eQ81qEAeDlIPBI4gqZUBoNvRMyqr3DnNjms5A9LpFp8Gjdr/kiGswpm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810488; c=relaxed/simple;
	bh=sPkVWHl3iN98UwA8A/jpLSHw8mLzzdNWubMMdz+w2Dw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKDMLoeEGpHtPIuF8ygQTEmPBrV1f7uWVjvfhIhK6gqK0PAnBg7mRdItFz0WVf878XNR7cwv/0nYl/6Bs/L27+zb4kUwy2mqzPUzLkyPlDGNGiEFMDJ4/axNAO1tHJv0dX9rGfT+wHceZXydBzurCbt/RVRhBhd28BZiFzuxDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Ci30tQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a34c5ca2537so510513966b.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 23:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707810485; x=1708415285; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sPkVWHl3iN98UwA8A/jpLSHw8mLzzdNWubMMdz+w2Dw=;
        b=E1Ci30tQ0z46J7goRpWcIDd2o/7kAGHsDfphyaIDSsq6gyl+ZXIWFF8+GHgbiIs03k
         Srj0kqPVfa5hI4KiNNu50mG9jiWzz6c06GRTPtfcyIyTAOleP3tGmX54wQK5c9Mk5QdA
         RO2bySiN9AWW2e14V9d4nA4EYZ/SfPHWlmk4k7G9uakRGenn49Bs10dOcChi7TzLLDZh
         ahHz3u981pgdCudZx+YgFQ0CmO0jZ8Bm4M4k9BUW0YoWOS/5bxbicrSZ3uAOd0WWsq1o
         7K1lfryvKQCYR5IvywOkDY2L0WKZ0xIPSvIk02mdouklf6bkcAm4aQXy/3G30Bee2OtT
         yRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707810485; x=1708415285;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPkVWHl3iN98UwA8A/jpLSHw8mLzzdNWubMMdz+w2Dw=;
        b=ngN/0nfi5Fav3FTh0pBZ3WMhEYyjzkKeS64YvQkmLL+jUSOLpf1yGgyONvPp6qpWH5
         UlnBii+mj4DOI6cSt4V/eXT9Qw26BT1mu0IQP8grxBlT1BOEAn3DdNsubfouE8z2xxN0
         is5wcQ6qu3f3QrhhkeK1qso/8raWCP4MnLBAG2XOijjS7LR+gt7VF3+C3fUU8kX8aQYN
         P2zgYwn0LL2+7vDFiDMEvCuFTJd8EERv9Uqr2hvsBCTz2ljMHJaNg/z0xgVZCfYxcURf
         jwmG/miyIkIKb5kPvzw8F14wjI50T60gJlD9KEbs42tPcZlr100CGlPJ85swxNoIVbI7
         NXsw==
X-Gm-Message-State: AOJu0YxnkKb4KdDtAAlnqNcBbOjnRupm3uualEUxwb4CxHK+TuXn6lsA
	eviIObbeSjolVxQgrHDxPhHfvcXOODfyHtRNjevVUy9hvp/Yp9Oh
X-Google-Smtp-Source: AGHT+IGFRP1E139kvcKZaUiS7SC8amQ3FKCTb4YeXp8evu/1O2si2ZXks1XT6fcxVLtrDRP7bGxETg==
X-Received: by 2002:a17:906:af87:b0:a38:99ae:da8b with SMTP id mj7-20020a170906af8700b00a3899aeda8bmr5587589ejb.56.1707810484202;
        Mon, 12 Feb 2024 23:48:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVH9f4EmwKWMmJgTxNdfSQz4FuMeFEaw9OluZrNQAfV01EEc8sWRhHumLUvtCjvDaMn9sgLcrJwyx/cjJFvtGi/QxRiPepDoyfidb1cc7qGqiWbLtye1bcsPMkrsAq7g1PWTJ+eiQ==
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906279700b00a3881262235sm1015558ejc.78.2024.02.12.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:48:03 -0800 (PST)
Message-ID: <587e7de71aa8131a9a54a8f6e31762aa8ec1d22e.camel@gmail.com>
Subject: Re: [PATCH] iio: core: make use of DIV_ROUND_CLOSEST_ULL()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen
	 <lars@metafoo.de>
Date: Tue, 13 Feb 2024 08:51:23 +0100
In-Reply-To: <CAMknhBGEKJa_q2MD1q++mTAOP9SrJ_WVJv_CBP+s_8PiBgz2eA@mail.gmail.com>
References: 
	<20240212-iio-improve-define-dont-build-v1-1-875883bb9565@analog.com>
	 <CAMknhBGEKJa_q2MD1q++mTAOP9SrJ_WVJv_CBP+s_8PiBgz2eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 18:02 -0600, David Lechner wrote:
> On Mon, Feb 12, 2024 at 3:07=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Instead of open code DIV_ROUND_CLOSEST_ULL(), let's use it.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > 1) For some reason IIO_G_TO_M_S_2() does do not a closest division. Not
> > =C2=A0=C2=A0 sure if there's a reason for it or just something that was=
 forgotten.
> > =C2=A0=C2=A0 Anyways, I left it as it was before.
> >=20
> > 2) This conversion could actually be required. In some experiments with
> > =C2=A0=C2=A0 it (in a series I'm working on), I actually realized with
> > =C2=A0=C2=A0 IIO_RAD_TO_DEGREE() that=C2=A0 we could have a 64bit divis=
ion in 32bits
> > =C2=A0=C2=A0 archs. I'm still not treating it as a fix as no one ever c=
omplained.
> > =C2=A0=C2=A0 Jonathan, let me know if you want me to send a follow up e=
mail (or v2)
> > =C2=A0=C2=A0 with a proper tag.
> > ---
> > =C2=A0include/linux/iio/iio.h | 9 +++++----
> > =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index e370a7bb3300..3ebf9fe97f0e 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -10,6 +10,7 @@
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/cdev.h>
> > =C2=A0#include <linux/cleanup.h>
> > +#include <linux/math.h>
> > =C2=A0#include <linux/slab.h>
> > =C2=A0#include <linux/iio/types.h>
> > =C2=A0/* IIO TODO LIST */
> > @@ -799,8 +800,8 @@ int iio_str_to_fixpoint(const char *str, int fract_=
mult,
> > int *integer,
> > =C2=A0 *
> > =C2=A0 * Returns the given value converted from degree to rad
> > =C2=A0 */
> > -#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
> > 18000000ULL)
> > -
> > +#define IIO_DEGREE_TO_RAD(deg) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DIV_ROUND_CLOSEST_ULL((deg) * 314=
159ULL, 18000000)
> > =C2=A0/**
> > =C2=A0 * IIO_RAD_TO_DEGREE() - Convert rad to degree
> > =C2=A0 * @rad: A value in rad
> > @@ -808,7 +809,7 @@ int iio_str_to_fixpoint(const char *str, int fract_=
mult,
> > int *integer,
> > =C2=A0 * Returns the given value converted from rad to degree
> > =C2=A0 */
> > =C2=A0#define IIO_RAD_TO_DEGREE(rad) \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (((rad) * 18000000ULL + 314159ULL=
 / 2) / 314159ULL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DIV_ROUND_CLOSEST_ULL((rad) * 180=
00000ULL + 314159)
>=20
> Is this supposed to be "," instead of "+"?

Definitely! Obviously I did some mistake preparing the final patch and out =
of
confidence didn't even built it... Curious why clangd did not complained.
Anyways, thanks! I'll send a v2

- Nuno S=C3=A1
> >=20


