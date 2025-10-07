Return-Path: <linux-iio+bounces-24796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC162BC05A2
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 08:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B38188FDB7
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C773224B15;
	Tue,  7 Oct 2025 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJN4QDrn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607022424C
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819200; cv=none; b=YT5pwwYsjidKX8joOvhUZCZbW8+UQqYCwzsU+oTFGqMCWzRKLz4a27Q/qRpSpr4dF9q7p2Ie9SnHV3MpJZPSlwy41aiofiaecuRFoklBskiJBgCjxKfwhn0OQgQ5XGHSbgSCkBazjxyjBqrHGX1TOyyhjgP9IGw0BP2lRLkmDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819200; c=relaxed/simple;
	bh=MlmgKlgZw6bNBNDPZ4yL2xiVLmJkWvwQdwG0hDFUJWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uag7GOEGfLmpLz5N4dTdUpKyUIlIK/DnFKMgGLZRQW5obUJ9krFMuUi6E9/lNQIpKCgqzzmf2mCd3TtKvl3FYLN8SQz0TCaiX/FS1ZGj/8AI75XNTw5ulxyT6m/Q2cRA6KC0+Xb1chNU3Ed+vaqXe4qUBkaIfS7aw1856zUjXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJN4QDrn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36a6a397477so58233731fa.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759819196; x=1760423996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0C4GwIKNXewQdfdWCoaJErCN+2dpt6b5L9PgeLMaFU=;
        b=lJN4QDrnvR9CwZ7SpJSDivoNXJZQUN9cG1CmFmEaU/kaSAdEXivt6IvUybTKXfnBB+
         MFvN+2YwOKtgVEERT8iosuGKEFtJijBoeDuaDJ7ZQEduyg7wiRvBkVFLl6EBRhyeRjkM
         P31GyNILH65/WrKqdSXpUaOw9Ye6ofn4Z/zTwyKntT+bDFJ6BR8aSQsPkVMGz4qM5iGo
         Yhi/Ipb1+LMb0DSZo0XMFvWCSbh4sHEogm6OhUVexUmo2CWPhvOlc4csmrMbqWw7jagp
         MyfXk1JryYezHS/nA397lIi2BaPMxBry+8KwmoaEkS6PuF4tj3QvtsMgVl0Jrdu6QuFy
         zWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819196; x=1760423996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0C4GwIKNXewQdfdWCoaJErCN+2dpt6b5L9PgeLMaFU=;
        b=oEkvkhMbSfbR/FIYxq8VLn0Wh0z3nOBYf2qotYEMS9cys3xO+SjjcJ2Hso58TFOTZZ
         Y05TA5H/3vYD87Ne6VPcjYFrUYlL44ANmQ3+ueQNHpOnX1TZN+qdvbeTd3S9jgVFWgcq
         lksRs2sd9V/c1NfV9BkqiOEfH1T6A2fdhvULEuD4UEGjRvAtuB/EDOZbjVnWH571e/6J
         gecKq4Sv30sRUhvXAba2TwRfTmqveHtJiSEfgCed4raAFCgVlYjKPqCJGAWXDu872JNO
         Xs0ft/+mJxV9xITlhZzNa4viXx4CipzDOkcs2RAJ51WlZFav+0KbZwYNM1GZnQFyI0fn
         TVMg==
X-Forwarded-Encrypted: i=1; AJvYcCUMpwGpqTM/SiCHv6j5YqkdBNhPsNLmxIZl6VvGXF6UzTaZoil7mYJVLbhMCmQCdDQEtpAiYHIe71I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2v3fjrk9vZ44oAUFuLewBExgETAPLsVcM+5jwq1yFcruHvhlx
	MaqKMra8A7DBh3Nlzbt2pzoUnWnIfitrgDvTWtsSSRhp3DTz2s4YOA4vL7mMxhi16X8B5pPaxMN
	a1/IjnmtbVCCM56cUgBclPwevf1NH2oo=
X-Gm-Gg: ASbGncuMc5iwEyAye/ofXcZv+xc9CTdOz12AcugVxh8aycdRxb3kPOXn7bHqbUGaCfT
	PUFgZikpfs2Nx386xSKdaBIuZJY76vH3zDrf/6sNLQNH83xUJFAiOgvhNz8R7Vz6lI4UI5HBM0N
	8e5tJUUylZIcHE2m4o7TaST8U2H42D9i2hnaWUR0Sw50j/nLyMd9dOq4EmPWzoEUJh7SfjQsrn7
	dQdWRvdHq6DSk1rAdHDbPlsDciB0pw=
X-Google-Smtp-Source: AGHT+IGw2e5PJUM70ofjlrSrlE/TrJc1sbv/DAC3CPfjTqSP9CziUjjExiazULBlK6HV0Ait4DXZWb1MD8cvC0xI19E=
X-Received: by 2002:a05:651c:1c9:b0:365:253e:535a with SMTP id
 38308e7fff4ca-374c3828d08mr40434751fa.41.1759819195890; Mon, 06 Oct 2025
 23:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
 <20251002184120.495193-2-akshayaj.lkd@gmail.com> <20251004135312.41858380@jic23-huawei>
In-Reply-To: <20251004135312.41858380@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Tue, 7 Oct 2025 12:09:43 +0530
X-Gm-Features: AS18NWC4DBQPzOO43N_0Yc0srozIYyViGAOB23dtOFSiGEp-TJrRgHMm7rZ1qYM
Message-ID: <CAE3SzaST=w7f0yM1C2iGfD9fw7smzMDven5kOoSQ0jMMZHMkWw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] iio: accel: bma400: Reorganize and rename register
 and field macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>This is much easier to review. Thanks for breaking it all up.

Hi Jonathan,
Thank you for the review.
Keeping v3 feedback in mind, I have floated a v4 patch series.
Have some follow-ups in some comments. Please read below
for those.

Thanks,
Akshay.

> >  #define BMA400_INT_STAT0_REG        0x0e
> >  #define BMA400_INT_STAT1_REG        0x0f
> >  #define BMA400_INT_STAT2_REG        0x10
> > -#define BMA400_INT12_MAP_REG        0x23
> > -#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
> > +#define BMA400_ENG_OVRUN_INT_STAT_MASK               BIT(4)
>
> This is an odd field as it applies to all the INT_STATX registers
> However  I would still try to make that connection with a name
> such as BMA500_INT_STAT_OVRUN_MASK
The connection is still there Jonathan.
The name in the spec is Interrupt Engine Overrun.
BMA400_ENG_OVRUN_INT_STAT_MASK can be read as
Engine Overrun Interrupt Status Mask.
Here for Interrupt Status fields, I have intentionally taken a little
deviation from the naming convention established.
Original convention:BMA400_<reg_name>_<field_name>_<suffix>
Convention here: BMA400_<INT NAME>_<INT_STAT>_<suffix>
so that it can be read as <INT_NAME> Interrupt Status mask.

I would understand, if you want to adhere to original convention.
Will make the change in next version.

>
> > +#define BMA400_STEP_INT_STAT_MASK            GENMASK(9, 8)
>
> This bit is a little odd.  We are treating INT_STAT0 and INT_STAT1
> (but not 2) as a single 16 bit register. That makes it hard to
> associate the field with the register name. I wonder if we shouldn't
> break that and just handle it as a pair of u8 instead.
The spec talks about doing a burst read for such multipart registers
to avoid reading one, while the other one is being updated.
Hence did not touch it.

> >  /*
> >   * Read-write configuration registers
> >   */
> > -#define BMA400_ACC_CONFIG0_REG      0x19
> > -#define BMA400_ACC_CONFIG1_REG      0x1a
> > +#define BMA400_ACC_CONFIG0_REG               0x19
> > +#define BMA400_ACC_CONFIG0_LP_OSR_MASK               GENMASK(6, 5)
> > +#define BMA400_LP_OSR_SHIFT          5
> #
> Should never need a explicit shift. Use FIELD_PREP() and FIELD_GET() to
> allow the MASK to be used in all cases.
>
done

> > +#define BMA400_NP_OSR_SHIFT          4
> Similarly on this shift.
done

> > +#define BMA400_ACC_CONFIG1_ACC_RANGE_MASK    GENMASK(7, 6)
> > +#define BMA400_ACC_RANGE_SHIFT               6
>
> and this one.  Might be a good idea to switch away from using the shifts
> as a precursor patch as it's really a different sort of change from
> the rest of this.
Added a separate patch for this.

>
> > -             osr =3D (val & BMA400_LP_OSR_MASK) >> BMA400_LP_OSR_SHIFT=
;
> > +             osr =3D (val & BMA400_ACC_CONFIG0_LP_OSR_MASK) >> BMA400_=
LP_OSR_SHIFT;
>
> Here is one of those cases with the shift that could just be
yes, fixed as stated above.


> > -             osr =3D (val & BMA400_NP_OSR_MASK) >> BMA400_NP_OSR_SHIFT=
;
> > +             osr =3D (val & BMA400_ACC_CONFIG1_NP_OSR_MASK) >> BMA400_=
NP_OSR_SHIFT;
> her as well.
yes, fixed.

> >               ret =3D regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG=
,
> > -                                (acc_config & ~BMA400_LP_OSR_MASK) |
> > +                                (acc_config & ~BMA400_ACC_CONFIG0_LP_O=
SR_MASK) |
> >                                  (val << BMA400_LP_OSR_SHIFT));
> FIELD_PREP for this one.
fixed.

> >               ret =3D regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG=
,
> > -                                (acc_config & ~BMA400_NP_OSR_MASK) |
> > +                                (acc_config & ~BMA400_ACC_CONFIG1_NP_O=
SR_MASK) |
> >                                  (val << BMA400_NP_OSR_SHIFT));
> here as well.  Anyhow, from a quick look it appears that getting rid of t=
he _SHIFT defines
> should be easy.
yes, fixed.


> >       ret =3D regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
> > -                              BMA400_STEP_INT_MSK,
> > -                              FIELD_PREP(BMA400_STEP_INT_MSK, val ? 1 =
: 0));
> > +                              BMA400_INT_CONFIG1_STEP_INT_MASK,
> > +                              FIELD_PREP(BMA400_INT_CONFIG1_STEP_INT_M=
ASK, val ? 1 : 0));
>
> Could use regmap_assign_bits() to simplify this a bit - but separate chan=
ge
> so different patch.
regmap_assign_bits calls regmap_set_bits which itself uses
regmap_update_bits_base similar to regmap_update_bits.
Moreover adoption of regmap_assign_bits is not much in drivers.
Hence would request to keep it as it is.

Thanks,
Akshay

