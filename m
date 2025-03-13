Return-Path: <linux-iio+bounces-16782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85778A5FBE8
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32043A2FCF
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6A267B77;
	Thu, 13 Mar 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIbldObm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AB1FBEA8;
	Thu, 13 Mar 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883711; cv=none; b=mD05mfuI7uMiwgPGrf/27PSzDOjGbPz+oedD+oZvzMrL4vgjUC4CpsYtjKR58M1We+nxRxlvmtolxWStRX67QDNtq+0/l0HjkPD4LpoF8Gu2hNTooMv/BiD/DOlIlu/ogwmj722UW04eUQ3YnwyHjaj1TjGRPazLiaGugm9GxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883711; c=relaxed/simple;
	bh=EUFN0+/92DTuuEPqcXSlkiCvxxoC8sPdnSBFP/qw8JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL7pT61C3I1isgG/gSxZVAG+krajrM+9/c3D0AHgH0cb301YNZtxmr0lnTu9E+FOx1roymYz+2JBd27mNPvwhnu8OJulAzA3Z3QALr3VBTV9TsB1OEgaLPt1tambg0n9i5LBHDT0b/TbxwE/uVtBGV994U+JH4Nsghc2SDan71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIbldObm; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e63a7403c4cso137395276.1;
        Thu, 13 Mar 2025 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741883709; x=1742488509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAQy2kteC6dBKbppouJhbhTfreKvLdgeuUyc0o14mVQ=;
        b=MIbldObmlYuOuoz/H3tbiQFzEFGPicRsxm9H19nBIWZ5d+ql2pRHYp8oOlqZrEbT0T
         zrE06IyS09PLkZHUSHsj2uNokG+s5c5WE3oXNdY2xUhLgDixNNvkfSm75MQ93Sn7h8VH
         1V2bbY7pbG+HOw/sNBpbrQB89dAqzlFK435kKJH3O7QiYcqQ3QGcoQ9T2lfrFW6rnimY
         uWXmBerLghyu/QTaFNbHDamd0E8UdzqG8+7xGSsubN1YZcwnHmLTE6qNgCq+PRG2+O/o
         t4Pv5rmjEvxbNx5FgCheQlH6BfiyM4XY7/8+EB5loY0YioYBzNPYQtXV7kUi2q/DOi3l
         9NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883709; x=1742488509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAQy2kteC6dBKbppouJhbhTfreKvLdgeuUyc0o14mVQ=;
        b=NeBrlYW8JwDFgcXKfMouJqhNIomPRZoBqorveoLUcZOehO61K3Xa/zWSyeI7sOPOxL
         R+IzVkuikBahj1KStWu+0FOQAR1D1hkeZJBwrP2o3Yea6fRk76j2q1KN0dDvyNwOzzrP
         yK3XZDkEFX8Gphh65h4PKE1udimmGaH8B49Gr5Lc9X3fECgTw0J1D1/+s+yudRHr2J/s
         gylDBAaTkpVhOwv6MQBdAzsNtQR47eXj43XLdsiRN8BVVzARJyZxeVyPg6jHqvTkvdAK
         eZ3OY5uKegW656OiME0GySng4KwXypRkgFQnlSV1eNzdkgoeaAegExaYr2UsKUoEf6Z0
         d82g==
X-Forwarded-Encrypted: i=1; AJvYcCUS6Yy5Ou6DjJN9ptHdzEEjkICu8BpoJmXHfkSVSVduFwpQ6SVB35kqPFmPhTd0xxdfXsS4la/Tk0s=@vger.kernel.org, AJvYcCUwZmtQQrkREe9WyTRZy/XybLoj+5qIeVAMm2ECawor2boCZXRDto6XvnP4KkYT47HobB3zr32KokAxJRvF@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPGHCnh1rZVMuc80TJKURTxe9Kcc0gCnHMK/oVa08ExC0Y2dO
	DVcRKuYx8EQ+EnZWamtvfK7aLlVFZqn++0p0t9IOC81IYUo/9tXes+oRWywHxgc5gTYun0kEU6K
	OvVQMyl78U8U95QNTdL0WF7zO6wy/LuAo
X-Gm-Gg: ASbGncvUcnuOstc+ryE/Zq6PIkW0bK4x83AuBLQmrBnHW5SN5ELp8mQQCEdoc/QEReU
	2M+YCRgTaFGvrIHR6swXX8i4+r9+FxLvCgapVMsIZBlvUkfXzB/il6YJzSB+5pQX7GTwJ9KgRs7
	gzIpUoo1n+18CuoEdlTEfqqm+crQ==
X-Google-Smtp-Source: AGHT+IE+3wvqQiUCiFN0C9/KB8zVg8TQLZYHVmyKzY8xspOea4xxIMsTYlci9X0Q6ixeThe/iV6Jv2BEGDpgSwwccRk=
X-Received: by 2002:a05:6902:2e09:b0:e60:a4f4:7f3 with SMTP id
 3f1490d57ef6-e63b521320bmr7246707276.6.1741883708733; Thu, 13 Mar 2025
 09:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104234.40958-1-l.rubusch@gmail.com> <20250220104234.40958-10-l.rubusch@gmail.com>
 <20250304132320.5caad2d2@jic23-huawei>
In-Reply-To: <20250304132320.5caad2d2@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 13 Mar 2025 17:34:32 +0100
X-Gm-Features: AQ5f1JqiITWP0W_H60EGGtAoCn-Qo5ipt0Bvjn02u-pIc8DoaCY08wjyEx8TUjA
Message-ID: <CAFXKEHb3GehCyNyLh3Z_8yVPNda9V_8KN_RF+hZvHdW8u9zr0Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] iio: accel: adxl345: add freefall feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 2:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 20 Feb 2025 10:42:28 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the freefall detection of the sensor together with a threshold and
> > time parameter. A freefall event is detected if the measuring signal
> > falls below the threshold.
> >
> > Introduce a freefall threshold stored in regmap cache, and a freefall
> > time, having the scaled time value stored as a member variable in the
> > state instance.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi, one thing inline.
>
> > @@ -855,6 +958,17 @@ static int adxl345_push_event(struct iio_dev *indi=
o_dev, int int_stat,
> >                       return ret;
> >       }
> >
> > +     if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> > +             ret =3D iio_push_event(indio_dev,
> > +                                  IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +                                                     IIO_MOD_X_OR_Y_OR=
_Z,
> > +                                                     IIO_EV_TYPE_MAG,
> > +                                                     IIO_EV_DIR_FALLIN=
G),
> > +                                  ts);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
>
> Seems unlikely to be right. Pushed an event without error yet this functi=
on
> is returning an error here?
>
> >       return -ENOENT;
> >  }
> >

"it worked on my machine" - Of course, you're right. So, I tried to
understand why this "worked". In consequence, I think the best
solution will be to put also fifo handling based on int_stat into this
function, which I currently made a separate patch, you'll see that in
v4.

> > @@ -954,6 +1068,7 @@ int adxl345_core_probe(struct device *dev, struct =
regmap *regmap,
> >                                        ADXL345_DATA_FORMAT_FULL_RES |
> >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> >       unsigned int tap_threshold;
> > +     unsigned int ff_threshold;
> >       int ret;
> >
> >       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > @@ -973,6 +1088,9 @@ int adxl345_core_probe(struct device *dev, struct =
regmap *regmap,
> >       st->tap_window_us =3D 64;                 /*   64 [0x40] -> .080 =
   */
> >       st->tap_latent_us =3D 16;                 /*   16 [0x10] -> .020 =
   */
> >
> > +     ff_threshold =3D 8;                       /*    8 [0x08]         =
   */
> > +     st->ff_time_ms =3D 32;                    /*   32 [0x20] -> 0.16 =
   */
> > +
> >       indio_dev->name =3D st->info->name;
> >       indio_dev->info =3D &adxl345_info;
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > @@ -1049,6 +1167,10 @@ int adxl345_core_probe(struct device *dev, struc=
t regmap *regmap,
> >               if (ret)
> >                       return ret;
> >
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_FF, f=
f_threshold);
> > +             if (ret)
> > +                     return ret;
> > +
> >               /* FIFO_STREAM mode is going to be activated later */
> >               ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl=
345_buffer_ops);
> >               if (ret)
>

