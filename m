Return-Path: <linux-iio+bounces-13795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36669FC61A
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A987163507
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7809519644B;
	Wed, 25 Dec 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUNAKEKM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CE11CA9;
	Wed, 25 Dec 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735145986; cv=none; b=LcXnZQLJ7UYhoVgR884jExkprsjZGVsXixNV8f7EONlqH7fiaL8PDKYE8ccYtJjJjHYsB0MKdImjqrKYazCOkVRh3lLBMXyCLOpneCXNHwKm4f7umcFm/9RtBixzZFu4BEuFOMvbhQIpPkirWoJ3UwbKQMTh8x1CGGfSgiyPFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735145986; c=relaxed/simple;
	bh=j1o/hw8bflEa0TZgPKngWMdQrkTzrNk6GETFPsmrdYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzAjaLrKtMm+/Qj6r2EzhBb1p4B/mybHNoOyEaBSmajnryCTNSKOQdA6cqtps5aBG1c9LULQbxwy9u5Ze24Om6jgDK6WCPHybwtvHWD7X17aQ81OmPg6N6/mX3VXwTv8efEURYiZppztoz/fguci8Abu6ZGp+WJi0IdOGiC5nnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUNAKEKM; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3337b09c9dso703358276.1;
        Wed, 25 Dec 2024 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735145983; x=1735750783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D69dMxCe2r8ybEC+ykVA7Ojy/LCple3VOOytq+HPxA=;
        b=eUNAKEKMSn1jstcjSN5KqsTmeLlmupcbC0ZL821/3RbKHbLdYXyJvAXmHuDXXK08WX
         iyxLTRwFULiaRYqXLGoC7zTeBsOFjTUcjukOcrEDioX0Qjrmk88DALckLMXZ8N8XEHHA
         l8Dx30CCyv/XgU55p37Kn9Gfa2TaIqT2CRAbwO0zaKyaU8oBxtwwskW9FyY0uap3Ppta
         qaCIiuG4Gn6ux7LyjgL+EzBM3T/ZjoLpk2XAunU1ubwkDEzp1ELTTY6t116OEFWkkCH4
         qQj0QC6vl22rmbNUrzCtJEi1rloSDx6egGzErHwtR924seYoUQY9zDjO0Zzxr+fzOlU4
         mUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735145983; x=1735750783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D69dMxCe2r8ybEC+ykVA7Ojy/LCple3VOOytq+HPxA=;
        b=UMUW4Nf/ZmvGaQkWO2H+vcmYBEI6xdHwfCwUS9+2nLSChhpt6Wl7+qTcu8A9bAeIqP
         FrDBKvGbbKTBVPn4r+HsfIhIKbx+cts829EESoAYdQTK2cb994Mw6cmY0siXn8ojJS85
         fHaAuqWEuo0gtlCybG1pKkfnMfXIbgjN/8EA7Ku4Km9Y7zaS7WmCd8hRElEaxoimC8VC
         EB3PyLaXGoQbzWCXAz7T/7H1R8XRVIPReVxKendP1iBn/y6Utt+aLqgw+5DIYiOKjyNU
         xfEMk+9jD8o5Pug8qC1gw2LcPgufwFhrIwf6BIaVvCGEho/lidz+5JjBf9lCH6RQkDaj
         JkoA==
X-Forwarded-Encrypted: i=1; AJvYcCUsnvBdFVxfYZN9/ts9kLdgmIEnVyOYIEYIV+/EKezP5JCq/1fBJVevab9oQD6eR8vk+lw6+nFU8Kzw/jSe@vger.kernel.org, AJvYcCWXe+VSHP51OmAissgf55jdWJXHwdEFYzZ2MWf2VuqsCRoPFvlQJwB5EUCWb4j1fYQfcLatlg43VrWe@vger.kernel.org, AJvYcCWs6O6w4VMsmy9qDQr64ogf3A37DV4G5/J0vxC8/ZKikhbAynmGC7UV0bDpqfakMBSnbtPU3jx+kDek@vger.kernel.org
X-Gm-Message-State: AOJu0YzpeUhtOINal699L6ef2XWHjRDrm4d/6p7mrPVS6EsXWCgEhM64
	cGPMlbxleCwmnneILcN40nyxEPG6vejspguuJU8zDY6JvNXVD1jt7P+VS2Xi1biUQsz7NbOLHtG
	1lnmvUg6GHvmP3vttmpHpJlTyRXo=
X-Gm-Gg: ASbGncvFTHzLVNFLxzNSWafUgwk4YViJUsRLTjfe+BTlofq4t0BpilZNDiKX0QCa3g5
	8czYLWv+ZUBaIeAGJAsI+Ie1QrKLaG58WdUZX8w==
X-Google-Smtp-Source: AGHT+IENMcwE9rdf7AyaWVGKmuc0ZMtHWq/rtv3DPBhNbGkGSBYYY+FPdCHRRfCaRm6W0WjXLHFUOavfXEGcnN7i+wg=
X-Received: by 2002:a05:6902:2603:b0:e47:f4e3:87e9 with SMTP id
 3f1490d57ef6-e538c232e70mr5262257276.4.1735145983404; Wed, 25 Dec 2024
 08:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213211909.40896-1-l.rubusch@gmail.com> <20241213211909.40896-8-l.rubusch@gmail.com>
 <20241214123926.0b42ea59@jic23-huawei>
In-Reply-To: <20241214123926.0b42ea59@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 25 Dec 2024 17:59:07 +0100
Message-ID: <CAFXKEHbHEGFPKp7nbFA2u28a5n0aA+0SFaKR0-3ys81FP9pMAA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] iio: accel: adxl345: complete the list of defines
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 1:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 13 Dec 2024 21:19:09 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Having interrupts events and FIFO available allows to evaluate the
> > sensor events. Cover the list of interrupt based sensor events. Keep
> > them in the header file for readability.
>
> That makes sense for now, but longer term I'd attempt to restrict the sco=
pe
> of these by moving them to the top of core.c
>
> The two bus drivers don't use any of them that I can immediately spot
> and if they do it is likely to be very few.
>
> That may be a good first patch for your next series.

I understand. Actually in v1 of the series I had a patch to move the
defines into _core.c. There were bigger issues, though. Thank you so
much for all the feedback the improvements are impressive to me.

Best,
L

>
> Jonathan
>
>
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h | 57 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 51 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index bf9e86cff..df3977bda 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -9,10 +9,35 @@
> >  #define _ADXL345_H_
> >
> >  #define ADXL345_REG_DEVID            0x00
> > +#define ADXL345_REG_THRESH_TAP               0x1D
> >  #define ADXL345_REG_OFSX             0x1E
> >  #define ADXL345_REG_OFSY             0x1F
> >  #define ADXL345_REG_OFSZ             0x20
> >  #define ADXL345_REG_OFS_AXIS(index)  (ADXL345_REG_OFSX + (index))
> > +
> > +/* Tap duration */
> > +#define ADXL345_REG_DUR              0x21
> > +/* Tap latency */
> > +#define ADXL345_REG_LATENT           0x22
> > +/* Tap window */
> > +#define ADXL345_REG_WINDOW           0x23
> > +/* Activity threshold */
> > +#define ADXL345_REG_THRESH_ACT               0x24
> > +/* Inactivity threshold */
> > +#define ADXL345_REG_THRESH_INACT     0x25
> > +/* Inactivity time */
> > +#define ADXL345_REG_TIME_INACT               0x26
> > +/* Axis enable control for activity and inactivity detection */
> > +#define ADXL345_REG_ACT_INACT_CTRL   0x27
> > +/* Free-fall threshold */
> > +#define ADXL345_REG_THRESH_FF                0x28
> > +/* Free-fall time */
> > +#define ADXL345_REG_TIME_FF          0x29
> > +/* Axis control for single tap or double tap */
> > +#define ADXL345_REG_TAP_AXIS         0x2A
> > +/* Source of single tap or double tap */
> > +#define ADXL345_REG_ACT_TAP_STATUS   0x2B
> > +/* Data rate and power mode control */
> >  #define ADXL345_REG_BW_RATE          0x2C
> >  #define ADXL345_REG_POWER_CTL                0x2D
> >  #define ADXL345_REG_INT_ENABLE               0x2E
> > @@ -34,20 +59,40 @@
> >  #define ADXL345_FIFO_CTL_MODE(x)     FIELD_PREP(GENMASK(7, 6), x)
> >
> >  #define ADXL345_INT_DATA_READY               BIT(7)
> > +#define ADXL345_INT_SINGLE_TAP               BIT(6)
> > +#define ADXL345_INT_DOUBLE_TAP               BIT(5)
> > +#define ADXL345_INT_ACTIVITY         BIT(4)
> > +#define ADXL345_INT_INACTIVITY               BIT(3)
> > +#define ADXL345_INT_FREE_FALL                BIT(2)
> >  #define ADXL345_INT_WATERMARK                BIT(1)
> >  #define ADXL345_INT_OVERRUN          BIT(0)
> > +
> > +#define ADXL345_S_TAP_MSK    ADXL345_INT_SINGLE_TAP
> > +#define ADXL345_D_TAP_MSK    ADXL345_INT_DOUBLE_TAP
> > +
> > +/*
> > + * BW_RATE bits - Bandwidth and output data rate. The default value is
> > + * 0x0A, which translates to a 100 Hz output data rate
> > + */
> >  #define ADXL345_BW_RATE                      GENMASK(3, 0)
> > +#define ADXL345_BW_LOW_POWER         BIT(4)
> >  #define ADXL345_BASE_RATE_NANO_HZ    97656250LL
> >
> >  #define ADXL345_POWER_CTL_STANDBY    0x00
> > +#define ADXL345_POWER_CTL_WAKEUP     GENMASK(1, 0)
> > +#define ADXL345_POWER_CTL_SLEEP      BIT(2)
> >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > +#define ADXL345_POWER_CTL_AUTO_SLEEP BIT(4)
> > +#define ADXL345_POWER_CTL_LINK               BIT(5)
> >
> > -#define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0)   /* Set the g rang=
e */
> > -#define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2)  /* Left-justified (MSB) m=
ode */
> > -#define ADXL345_DATA_FORMAT_FULL_RES BIT(3)  /* Up to 13-bits resoluti=
on */
> > -#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6)  /* 3-wire SPI mod=
e */
> > -#define ADXL345_DATA_FORMAT_SELF_TEST        BIT(7)  /* Enable a self =
test */
> > -
> > +/* Set the g range */
> > +#define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0)
> > +/* Data is left justified */
> > +#define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2)
> > +/* Up to 13-bits resolution */
> > +#define ADXL345_DATA_FORMAT_FULL_RES BIT(3)
> > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6)
> > +#define ADXL345_DATA_FORMAT_SELF_TEST        BIT(7)
> >  #define ADXL345_DATA_FORMAT_2G               0
> >  #define ADXL345_DATA_FORMAT_4G               1
> >  #define ADXL345_DATA_FORMAT_8G               2
>

