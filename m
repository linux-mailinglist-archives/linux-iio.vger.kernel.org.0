Return-Path: <linux-iio+bounces-18357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8DCA94625
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 02:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0323C3AA5B2
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 00:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20701078F;
	Sun, 20 Apr 2025 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8v3xtRP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D842C80;
	Sun, 20 Apr 2025 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745110639; cv=none; b=GrVGfbK0PMGIrzAY45+O8BhSqHgtb5XHaEuI2UOs88AVF6hiK2kmoarTPx6dZwcW2HB86R5pAJrOx28EakazhGHpAwqwahNgJ11D9JjgpTxdpbOpvTk12zhahXqWfnDRmI2BoRn6bZIQq4mIUglJ8+Mpy91QL4NWdZXvCjgntRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745110639; c=relaxed/simple;
	bh=aziHOJ4GqSOMl4BVkfbsB/+BfjqVBr1GfZSrod5NdOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVK2mFt8Pra9447ySdsG35/B7YspVrQ6HRZbUVqNXpDxqMpC2zok/wW1APQyz6yuDxUyO1nu5Av9MTyh+D4inpx5fQ79FLKwcYknkQnjQrAVFGa+km7EVlq7AGET2o0nLvzcIOM5W2mQMSGJZYfsb3e17YgeA/ZGEhXsp70H/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8v3xtRP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47662449055so14792551cf.1;
        Sat, 19 Apr 2025 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745110637; x=1745715437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOHAhJvT2EGpYPBPHQW+Mj9H5MSMsb+eawEeMqiJDsg=;
        b=P8v3xtRPtHK0mDPEmaRHBryVEMenID2J188o+/i1+4Rc32T23zoW+1UWvkeXbApptn
         S74Trqgr2T1fhskJcEiHzq05u0a5cFimxGbT/zAA+7ziQnhys55JtC465j40Sfh5hDJU
         VJdQoOO8Ce9OU3Tdb52hpY9w3jN3VRN8b492aBWyaQhn9cqYcEY71U/WSogZS7+CeFZB
         lQ74RaQ5UxFoDvHjc70uWq++q8mQ8SxCnjp7UsZZFO4oS31K+TgtYvkua1EWjbeGb5sV
         9bxYTxoGaF63YgBfTtP/dGc9f+9hv1smGZDkRsa2v8ph3WrstviltK0fOx2JtO7wzKc0
         m2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745110637; x=1745715437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOHAhJvT2EGpYPBPHQW+Mj9H5MSMsb+eawEeMqiJDsg=;
        b=h8yaSRxxsIlJVPTuqBcXx+dU1hpACiV2/abNupl9vFyibXYHufux3a4J0E01tWOggl
         vYR5WM+vFG9RenaSQWp5npz+UhJe3xOkIbcBz4JJd8ie9iAjJ9SaARDX+B/fT9tS2kx6
         xjEYeqnaqwL5tXZgE8uzLQKJe1uevO0u764zk90Ql25Ywp+GeoXjmy2KWcX8+JHy4IO5
         CDrIt1rev2IBetyZwxaJJ4fz0ajd820gh535O6L99EDzh+SIs6st5wLtV+6KZ2cXarN+
         qwiz+sidEMqIKO8OqPzxuTX9qefqPG9C5OmW1OJUh2fwJtecRfiJQ6zgJ4XFw3ufDNm1
         Osqw==
X-Forwarded-Encrypted: i=1; AJvYcCVnRqVfIeGlz0v6Jj/UDjQB24OUDNjn1c38ul6Cn0Ar0PVs8tlMkGX5bkJDrGXrETPNXJHDPKuPT5YlqQcA@vger.kernel.org, AJvYcCVpGpUGgLKYbv2jakY/GJXxVBGCbVGTW1NiWbS6uVkKWCuCv/SWDgaUR/BH00SkXMkmVpe62ouM@vger.kernel.org, AJvYcCWd0D3nwi+xAcqo2sR3VeFHq2r5yKGoubgbUahe7CtdyTh6Dfc35ashopn37djEvl0VqhqqVxPSbEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZRE+/zYoBFh0jzGiZOxPBnjESNIX2HUrD+HU9Tv4Taz02L75
	U9UcyKQppqrTjWZHyVy3+VrCdo6k4KQuv6SQyZm98YU52KKId26GYsW7r2jFHvmykso+TZp330n
	12EsCPKMfGDfOPPMUHBVpJfl63AM=
X-Gm-Gg: ASbGncvr+TnKWQ9NaYCvdYams8hOC6uA5Y/gqfwZaywknABMjFA3L1cGezMiDY7ip3S
	iXtqWzrT2bky05EDQxKbjjVXu72y/M0PJvIWFG7aHJ9fM2Cx9NsHUym8zux2sFKDjtOYOwiPhod
	6PNbH6+90LiwhPhWV9icmui92qtZiaeYLKpH1XGl8L4EZwjNccGIRhdg==
X-Google-Smtp-Source: AGHT+IEl3pn8fOMMI5krWgbC9DkGmzCfM0IKmJTML4FlDjNgQq0v/3Xk0QIkwAXyeX1OouswOySf0C1Sla8KSTiLcfU=
X-Received: by 2002:a05:622a:15d6:b0:476:6599:dee2 with SMTP id
 d75a77b69052e-47aec40c9f4mr139115741cf.27.1745110637128; Sat, 19 Apr 2025
 17:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419125413.679290-1-gshahrouzi@gmail.com> <aAPoAESnjjyNsHI2@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aAPoAESnjjyNsHI2@debian-BULLSEYE-live-builder-AMD64>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Sat, 19 Apr 2025 20:57:06 -0400
X-Gm-Features: ATxdqUE5aGXDKHfL4Aw31qgdnmk7PI718cHPIofiUd_hT7dVEzx4CyyxvUyP1j4
Message-ID: <CAKUZ0z+cd6VREDjiqMVy5k8rpV=NC+-YGQvBFYwYfFZ8iQbL1w@mail.gmail.com>
Subject: Re: [PATCH] iio: adis16201: Correct accelerometer scale factor
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: himanshujha199640@gmail.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 2:13=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> LGTM. Minor comments inline.
>
> On 04/19, Gabriel Shahrouzi wrote:
> > The IIO_CHAN_INFO_SCALE previously reported for accelerometer channels
> > used 0.4624 mg/LSB. This value matches the datasheet specification for
> > the offset calibration registers (X/YACCL_OFFS_REG, pg 18).
> >
> > However, the scale should reflect the sensor output data registers
> > (X/YACCL_OUT, pg 15, Tables 7 & 8), which use 0.4625 mg/LSB. This is
> > also consistent with the typical sensitivity in Table 1 (1 / 2.162 =E2=
=89=88
> > 0.4625).
> >
> > Fixes: 57f9386405a2 ("Staging: iio: accel: adis16201: Add comments abou=
t units in read_raw()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
>
> >  drivers/iio/accel/adis16201.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis1620=
1.c
> > index 8601b9a8b8e75..982b33f6eccac 100644
> > --- a/drivers/iio/accel/adis16201.c
> > +++ b/drivers/iio/accel/adis16201.c
> > @@ -133,7 +133,7 @@ static int adis16201_read_raw(struct iio_dev *indio=
_dev,
> >                        * 1 LSB represents 0.244 mg.
> Maybe also update the comment?
Good catch. I will update that for v2.
>
> >                        */
> >                       *val =3D 0;
> > -                     *val2 =3D IIO_G_TO_M_S_2(462400);
> > +                     *val2 =3D IIO_G_TO_M_S_2(462500);
> If we do the math with more decimal digitis we have 1 / 2.162 =3D=3D 0.46=
253469010176
> Would it make sense to do
>                         *val2 =3D IIO_G_TO_M_S_2(462535);
> ?
Since the datasheet lists the scale factor as 0.4625 mg, I believe
using *val2 =3D IIO_G_TO_M_S_2(462500); is correct. However, I'm not
sure so I'll postpone v2.
>
> >                       return IIO_VAL_INT_PLUS_NANO;
> >               case IIO_INCLI:
> >                       *val =3D 0;

