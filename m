Return-Path: <linux-iio+bounces-18353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975BA94608
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 02:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF3A3B42A7
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 00:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9FFAD2D;
	Sun, 20 Apr 2025 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHDam7kb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A64C92;
	Sun, 20 Apr 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745108727; cv=none; b=CDCGazD5Y5yhyjVXE5gh9Nwxb5sk/3DdFrUclNWLyMIVjjrTFSCS2iNEtmLec1bveOT40+CzPJYDi8t5bG+rENb9PsPmLyHD1lhOsXK351V+8gECFUWJCmzbfQvUpytYYIWO1/jJamT+y8zFiHZMkO2V3cI69A4J/KO4bu68Jd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745108727; c=relaxed/simple;
	bh=6PByxcc4Td8BBzc0VGIKPud0vFBe8ka/3jiUWf2Xm3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uy6uI8pP3r+t9vQigCdaxLvPKLUG18nL4kKUx6rsuDPcLmAg4WfTjjy/Rrc+U84H+y0Hy14tDmImO6oRAcxeMFPhRZT6N3R/RRNaA2PF9SIvGUujbmVqisGEBnFSB41x1QDvwKHEE5yt168Y40yzti/uM19zds4qVEQyUwTa1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHDam7kb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476a1acf61eso29015631cf.1;
        Sat, 19 Apr 2025 17:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745108725; x=1745713525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XV1imopr04k+GMqsWaTVJVnHaSrZQmxg+CiKNjaZJm4=;
        b=gHDam7kbCTGp72P1eEgX/O6QcljGpIZXTxjeS5MUeusgOLlFf61EvwmNy1zgH0Ow3O
         pol1kg0NCwwqHIKdveqVlVwqA0vgR835lfBWbNMU+WEtvApZn6PislNjP+WXPIo0vyk6
         jIKICs+5yMvZqD8k3fFFw27yOILqw+u7rBa4jGY9bk0YR5JHJYTXswEm2JJODwXas1sI
         Tq7mlET7BrhZe5n2xnbvS3yqbGlhHJdkrPbu3k7q1x83+cn44xQxFSaeiDIFA1C6DDdK
         tDwbLc9Zbpk9U5kXVpe5MZu2EpgeigIqWpkRJocegOG1zVZZKfk6SMklPd6ZCAYrGb7u
         rB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745108725; x=1745713525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XV1imopr04k+GMqsWaTVJVnHaSrZQmxg+CiKNjaZJm4=;
        b=xSSGqsPCcX7o0K4AX+hltTjPvvGQ6Ny8X4+8m2MZYDloRQIyPOFF6hACj8Gkwj5Wdd
         m1BVbWGz8tRUgDUCm/f9S3JgUH0fp0eDF+c5oDc36fTeQa9cQ/oWZzuqdSi3QKPdsZtK
         s2G3Ile18sM6Aj48ksOoyJsH/tspbZau/d/z9y/tFqDgRQAMjKrsyIm8eJAxwVHirpLX
         EO3l4rq8mHhNKnKgUtr0y2kTlXVeCVwZg8MnPeZ8VLEmeTsucxhfa0d+WQ26neilGsX6
         xQKp2ZDLHilOVT/PVcS2LIsGszPTlYenMgvygMo7Yd1hK8PTRAXZYMTpp2Vu6dKI3myF
         2QPg==
X-Forwarded-Encrypted: i=1; AJvYcCUVlu1NVLJbjcdbbbpwQ6C4SeroUtY+plFKrCKKeUU9N0A2a2MyeiDfyn/2NPy5X//LFLSGlvlqEDs=@vger.kernel.org, AJvYcCUqMBBr+dWETE0fhG8cteoI9jjvIyhy578cvGk2RZwrOfeaadG8km0KVtWPBG1p4J9L9GIKOy8B@vger.kernel.org, AJvYcCVmZ2xzA1wv5Og+kU6B2ZBY763FTVjMat/xeaO0Tda5gsw4MpJgYEJk2l/CbgEZd7/H63PgfPMst/qyNK/X@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9p4LIK7CkDZ7KeXC9HdBhcxDBg7Pa6CwYMXMeytseELHjTR+
	L1GMN3lTHp6AVuKA2s4uNCC2x5E+QNKLHVqPpURBH7QuunKdkbgwdBHd5iJkSK8C3B8g/vbO2pE
	fWlLFUxztUplkziMy/o3YXpzcUQMwm49rrxWLIg==
X-Gm-Gg: ASbGncuBSgiZJioSq3utYo6f3tST6pvmaY/FZb9943S66Ln2P+X5YzQJmo3yN6ylkX5
	ts+6U8gdRZgw40i5OhNDnww1afPkpK3jENr4QDxXvnZoCZOLYsiRFClb47S04sPQKp8MJIzfPN1
	r/Pz64jmNgjKv/DBMWLBk6uZyRvRIf7M46ejxpaexL86qPS6pMeC89Ng==
X-Google-Smtp-Source: AGHT+IEZ6JrdsM+X6/oFiMELcQZOnF5rOEZgJb6IzcMXMMfODVI7x3d168v1mEgadxYfIgeevyRoHP44LTPpiWTt5To=
X-Received: by 2002:ac8:5f89:0:b0:477:4224:9607 with SMTP id
 d75a77b69052e-47aec3a6358mr115518641cf.12.1745108725089; Sat, 19 Apr 2025
 17:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416142219.554938-1-gshahrouzi@gmail.com> <aAPEUUAHsG2CvFbr@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aAPEUUAHsG2CvFbr@debian-BULLSEYE-live-builder-AMD64>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Sat, 19 Apr 2025 20:25:14 -0400
X-Gm-Features: ATxdqUH4YSXlCHUZbebFf0oSKBKSNCeNe5rwbgvi-T6eASenCZbI8CI1A1SqyhU
Message-ID: <CAKUZ0zJoV6pLEFh6mEjz5awousn4o8Mq2D9AL8CfvqqW620X4A@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5933: Correct settling cycles encoding per datasheet
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 11:41=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi Gabriel,
>
> Probably a thing for a separate patch but, would it make code more readab=
le if
> use masks and bitfield to set register data?
> See comments bellow.
>
> Regards,
> Marcelo
>
> On 04/16, Gabriel Shahrouzi wrote:
> > Implement the settling cycles encoding as specified in the AD5933
> > datasheet, Table 13 ("Number of Settling Times Cycles Register"). The
> > previous logic did not correctly translate the user-requested effective
> > cycle count into the required 9-bit base + 2-bit multiplier format
> > (D10..D0) for values exceeding 511.
> >
> > Clamp the user input for out_altvoltage0_settling_cycles to the
> > maximum effective value of 2044 cycles (511 * 4x multiplier).
> >
> > Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 =
Impedance Converter, Network Analyzer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> >  .../staging/iio/impedance-analyzer/ad5933.c   | 21 ++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/=
staging/iio/impedance-analyzer/ad5933.c
> > index d5544fc2fe989..5a8c5039bb159 100644
> > --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> > +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> > @@ -28,7 +28,7 @@
> >  #define AD5933_REG_FREQ_START                0x82    /* R/W, 3 bytes *=
/
> >  #define AD5933_REG_FREQ_INC          0x85    /* R/W, 3 bytes */
> >  #define AD5933_REG_INC_NUM           0x88    /* R/W, 2 bytes, 9 bit */
> > -#define AD5933_REG_SETTLING_CYCLES   0x8A    /* R/W, 2 bytes */
> > +#define AD5933_REG_SETTLING_CYCLES   0x8A    /* R/W, 2 bytes, 11+2 bit=
 */
> >  #define AD5933_REG_STATUS            0x8F    /* R, 1 byte */
> >  #define AD5933_REG_TEMP_DATA         0x92    /* R, 2 bytes*/
> >  #define AD5933_REG_REAL_DATA         0x94    /* R, 2 bytes*/
> > @@ -71,6 +71,8 @@
> >  #define AD5933_INT_OSC_FREQ_Hz               16776000
> >  #define AD5933_MAX_OUTPUT_FREQ_Hz    100000
> >  #define AD5933_MAX_RETRIES           100
> > +#define AD5933_MAX_FREQ_POINTS               511
> > +#define AD5933_MAX_SETTLING_CYCLES   2044 /* 511 * 4 */
> >
> >  #define AD5933_OUT_RANGE             1
> >  #define AD5933_OUT_RANGE_AVAIL               2
> > @@ -82,6 +84,10 @@
> >  #define AD5933_POLL_TIME_ms          10
> >  #define AD5933_INIT_EXCITATION_TIME_ms       100
> >
> > +/* Settling cycles multiplier bits D10, D9 */
> > +#define AD5933_SETTLE_MUL_2X         BIT(9)
> > +#define AD5933_SETTLE_MUL_4X         (BIT(9) | BIT(10))
> In addition to making the above a mask as suggested by Jonathan, we could=
 also
> have a mask for the number of settling time cycles. E.g.
> #define AD5933_SETTLING_TIME_CYCLES_MSK GENMASK(8, 0)
>
> Would also need to update defines to something like
> #define AD5933_SETTLE_MUL_2X            0x1
> #define AD5933_SETTLE_MUL_4X            0x3
>
> masks and define names up to you.
>
> > +
> >  struct ad5933_state {
> >       struct i2c_client               *client;
> >       struct clk                      *mclk;
> > @@ -411,14 +417,15 @@ static ssize_t ad5933_store(struct device *dev,
> >               ret =3D ad5933_cmd(st, 0);
> >               break;
> >       case AD5933_OUT_SETTLING_CYCLES:
> > -             val =3D clamp(val, (u16)0, (u16)0x7FF);
> > +             val =3D clamp(val, (u16)0, (u16)AD5933_MAX_SETTLING_CYCLE=
S);
> >               st->settling_cycles =3D val;
> >
> > -             /* 2x, 4x handling, see datasheet */
> > +             /* Encode value for register: D10..D0 */
> > +             /* Datasheet Table 13: If cycles > 1022 -> val/4, set bit=
s D10=3D1, D9=3D1 */
> >               if (val > 1022)
> > -                     val =3D (val >> 2) | (3 << 9);
> > -             else if (val > 511)
> > -                     val =3D (val >> 1) | BIT(9);
> > +                     val =3D (val >> 2) | AD5933_SETTLE_MUL_4X;
> then this would become something like
>
>                 reg_data &=3D ~AD5933_SETTLE_MUL_MSK;
>                 reg_data |=3D FIELD_PREP(AD5933_SETTLE_MUL_MSK, AD5933_SE=
TTLE_MUL_4X);
>                 reg_data &=3D ~AD5933_SETTLING_TIME_CYCLES_MSK;
>                 reg_data |=3D FIELD_PREP(AD5933_SETTLING_TIME_CYCLES_MSK,=
 val >> 2);
I currently have:
                        val >>=3D 2;
                        val |=3D FIELD_PREP(AD5933_SETTLING_MULTIPLIER_MASK=
,
                                        AD5933_SETTLING_MULTIPLIER_VAL_X4);
which assumes val only has bits within a certain range which I believe
is the case here but not completely sure. Would it be better to clear
the bits regardless and then apply said operations?
> ...
>
> Though, I guess it would then be preferable to use masks and bitfield mac=
ros for
> all other places where we handle register data in ad5933 driver. Probably
> something for a different patch (if worth it).
I separated the original fix from the refactoring so the patches stay
modular. I can apply the use of masks and bitfield macros for other
register data. Should the refactoring be all in one patch or spread
across multiple?
>
> > +             else if (val > 511) /* Datasheet: If cycles > 511 -> val/=
2, set bit D9=3D1 */
> > +                     val =3D (val >> 1) | AD5933_SETTLE_MUL_2X;
> >

