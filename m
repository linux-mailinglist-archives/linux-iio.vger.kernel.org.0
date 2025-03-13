Return-Path: <linux-iio+bounces-16785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386D5A5FC7D
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0113AF2F2
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41321FAC30;
	Thu, 13 Mar 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwV7nezJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C884126C03;
	Thu, 13 Mar 2025 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884466; cv=none; b=aTilB/1whKPqMF+zVZaWXmyfurnGMCLOIXB/r/jzTAA1+Fasrae8Z6cWE6u/8iumpRFoSPdJYN5PhZ95uBacxabfbht3Q3YZR7GDxy1J1pe+dev3axfJ3zqhkwQX8v3r+PmXnckLpZahjCpcZrxXRwMeaiEl80Pa3lKpub6sAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884466; c=relaxed/simple;
	bh=5g2/bcJFxzetQ5Z89mvaC23u3B8DW3Ez9OXKAPaqN4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krypWBNZ4lJCD8FuUBMUoSlL+JDXHahEkheKwJMtx/bL4TN7pZgZr8NXQpYV1YnvUir2QZXzjChksQv4q7555iQzuxGq/A3n+wxBgEFjNzayDw+R8S+FFCmvx1lK5jawsU3R2ZJ7Ywo5NK4QOgls7+KknJuvX2dAj7sjMfv6gnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwV7nezJ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e634949074eso153224276.1;
        Thu, 13 Mar 2025 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884464; x=1742489264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s6eQ4zcP14m0ASOVWCXiFKRHZFfHjNhLuArM6tbgeU=;
        b=SwV7nezJ7pDUIjyw5tB6BY4N/K7uHn+dGkjsnik9vngPLSQ3kn4lhS/+PlS+LxsfMf
         LzKubdypybjUH8/4JRiM8fVIFuKqM7N6M6iYR4dmuFBddv/kNG2tBdSjhHLaEhjWVCfT
         MYz8gWtqjS2RTFuKYlVIch3zjRFzlvWItYR8zou+9/huE0V09M4hKsfyWR6q4haPZiEW
         +jremhxXA6OSr3KSJUh1RTZFOhypuzMrUiIJtuaw5LLvoyFxcIFg6viqz44l/p75uYw7
         KsfuO29cO6M10ALOWt0EH+0Ciszxq7A+YXkJmX3E724GZQGa9xcmqdnKZyNz17FMGc7c
         at0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884464; x=1742489264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s6eQ4zcP14m0ASOVWCXiFKRHZFfHjNhLuArM6tbgeU=;
        b=LAn4xfp3k+79KhpsDqVgZznEpmdum7dnTSrLB2WtNSTblBckied/BhLVPApVx74465
         KdMNoofJvwIhfIg2n5+fXmGX1rO1zGCy0LTWAHbQtVcfDYLDTgZQdwZZSXGKPbuiie7Q
         1OlDJ5KkNv8tHxCAS0uTX/6fwcE6XuKlRppseGyK/pCCJBYpfRXlb3j7HZwmasRLVk4W
         2VWclU+dXpoGkVmj17/iyOfvE5aFLDw7SXzx8H6TUy22tRIZNEQvfJtcMXw6913vpjHu
         KBnRx4AwuDPjVMOPiSvt+Fa+s+/xVWrEfrBdlZN/lWayqimMB92kExA4+EXvcx70fK5A
         i2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVMP8ffvEpNHIKxxRqA/M2dMDophHg3HXB+PdCgW+SBADtNBKE5VctHNY0ViFwQSVtOnGXojS1DgLI=@vger.kernel.org, AJvYcCXrRUnbJafVqqeYXnzhjgEd5JJHMq4zKfvrG8/+gtRBysu5OhXCmPqtpaVAI7zRBdVlZd9JDxl4Tp+MDH4T@vger.kernel.org
X-Gm-Message-State: AOJu0YwJB044Has3OrOGgatze1rEYFFq3y9TobT/LqKGkA77cyk0k2vB
	NtV9qQe046UnRvG5SoNjK6RkyUp58Igne8rYMgwJR3YnjkPbrTZN41tjQGunf0XcmoRbz3GMUg7
	FDxB4dk7q3G76RSX+bLk7Hhb9aNg=
X-Gm-Gg: ASbGnctoVP3tc5H7efMz4UcY3GwjvEtOL/qASJ7buR5JBIAn9UD4LryZlg9JUM8ZMAX
	K3H0dYemk3PtPAZFgsQ+5HT4v4qvWz3CFmSsO8N0fqbpr5jVLh0BY4ydjk7lLKYKV/uqfd/26ix
	bpUpzu1V7PGlMDhodf4lYM92inJQ==
X-Google-Smtp-Source: AGHT+IH1+WBEwmBZW3PmilqWpln4lPKb6NP8lfia9DAsa0W/TSQjS9ROzwC+hDgwGzG7yn+UZNSN1TtOhctu4wmJWiA=
X-Received: by 2002:a05:6902:2202:b0:e5d:fa5d:c630 with SMTP id
 3f1490d57ef6-e63b522982amr7071149276.7.1741884464054; Thu, 13 Mar 2025
 09:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104234.40958-1-l.rubusch@gmail.com> <20250220104234.40958-12-l.rubusch@gmail.com>
 <20250304134033.656e4a6a@jic23-huawei>
In-Reply-To: <20250304134033.656e4a6a@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 13 Mar 2025 17:47:08 +0100
X-Gm-Features: AQ5f1JrVq9DmOhDLq8WO6yCEe6V18MM9MDBrFdpjSRezWqEqnDOKJCtyBgI9KyE
Message-ID: <CAFXKEHYNAL2vRgBo6H8JRHemvGj2vT30y01T_0-jhY-hkumyMA@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] iio: accel: adxl345: add g-range configuration
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 2:40=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 20 Feb 2025 10:42:30 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Introduce means to configure and work with the available g-ranges
> > keeping the precision of 13 digits.
> >
> > This is in preparation for the activity/inactivity feature.
>
> I'm not really following why adding range control is anything
> much to do with that. Mostly we do this to improve accuracy for
> low accelerations.
>

As you probably saw the connection comes a bit over the link in
adjusting the activity/inactivity
parameters (times and threshold) by a given range in the follow up patches.

If the question is rather why at all adding this g-range control. My
idea was that adjusting i.e. lowering precision, less odr, etc might
also help adjusting power consumption. In other words
from a user perspective I assume there is more configuration
possibility. I did not pretend to tune
the implementation for lowest possible power consumption, though. It
was just an idea.

[Also, I was curious about implementing it here. My patch here is
rather meant as a proposal,
if you strongly oppose the idea, pls let me know.]

> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
>
> > @@ -483,12 +518,48 @@ static int adxl345_set_odr(struct adxl345_state *=
st, enum adxl345_odr odr)
> >       return 0;
> >  }
> >
> > +static int adxl345_find_range(struct adxl345_state *st, int val, int v=
al2,
> > +                           enum adxl345_range *range)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(adxl345_fullres_range_tbl); i++)
> > +             if (val =3D=3D adxl345_fullres_range_tbl[i][0] &&
> > +                 val2 =3D=3D adxl345_fullres_range_tbl[i][1])
> > +                     break;
> Similar to case in earlier patch, maybe set *range and return in here
> so that any finish of the loop is an error.
> > +
> > +     if (i =3D=3D ARRAY_SIZE(adxl345_fullres_range_tbl))
> > +             return -EINVAL;
> > +
> > +     *range =3D i;
> > +
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_range(struct adxl345_state *st, enum adxl345_ra=
nge range)
> > +{
> > +     int ret;
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> > +                              ADXL345_DATA_FORMAT_RANGE,
> > +                              FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, ra=
nge));
> > +     if (ret)
> > +             return ret;
> > +
>
> return regmap_update_bits() unless this gets more complex in later patch.
>
> > +     return 0;
> > +}
> > +
>
> > @@ -558,6 +634,7 @@ static int adxl345_write_raw(struct iio_dev *indio_=
dev,
> >                            int val, int val2, long mask)
> >  {
> >       struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     enum adxl345_range range;
> >       enum adxl345_odr odr;
> >       int ret;
> >
> > @@ -581,6 +658,12 @@ static int adxl345_write_raw(struct iio_dev *indio=
_dev,
> >                       return ret;
> >               ret =3D adxl345_set_odr(st, odr);
> >               break;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             ret =3D adxl345_find_range(st, val, val2, &range);
> > +             if (ret)
> > +                     return ret;
> > +             ret =3D adxl345_set_range(st, range);
> as in previous I'd have the
>                 if (ret)
>                         return ret;
> here for consistency with the other one immediately above this.
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
>

