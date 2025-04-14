Return-Path: <linux-iio+bounces-18076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB1A87FE0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 13:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A7C7A3312
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19D293462;
	Mon, 14 Apr 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UELLLcKD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFA18DB1E;
	Mon, 14 Apr 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631925; cv=none; b=aHfswJUYXZxCwjENmfhLOxbxZeftnvPH1HliuOoaGvL4FLhXGiJS76uB52ULQp2NOvIQ+1G0+ES2yY50O+0fpmex7dIFdE4fJoULFjV9wrCK59wUZsE7TNDQGeCQoabV1cmfs3lzhz4u5h75XPlBoRJybxj7BmXv9IKjjP9Kqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631925; c=relaxed/simple;
	bh=p0hGLbGgu1jLONsCJWAOLw4+sUxI4WfIBSsvqjmso4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSDcv153VBGwlTcyJPzwJXN25HXKbMvSV79hvarItUmqTvr53PbDyU0Fj+pGbqia2wVOC9+HTvsrgAFqAXJtU+0ZP21XtYM59L11RKibghfpdRm0sP7j5fmn+xLyc8eIdWHLYZ7z/6JOqlY51V0h0XnuhlGKSi7RCG0wAX8qC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UELLLcKD; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e638269b1deso499732276.3;
        Mon, 14 Apr 2025 04:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744631922; x=1745236722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M46YccT3MF0DvncrxUNZwzbhc/mDYvaIcE3Z7FSsvmo=;
        b=UELLLcKD0JVwkerpV5873du0AKhdzUjuMhtwnjODXpXO2ZgSvLlHT93HC/3MlF5wDF
         +pLtxdnkdNJZDapiFJj/DnsdORuuiVB8+hfbUY+WZpRWuW2ZhLTO5XQQeMNXRG0SBEXW
         29Xyf9qpaJ1Slsqs4s45rs4nlGSUWNRlfGFJDrq/kENpFhwrUBjsFED3zlHnFpNNHL6+
         OAxkIvgjORYMUo/bizwuK7hqktmKM9RP3fxdLLOUm6p22udLxOsPbLdYzqJBRRqju0hq
         DWzcnRIi7QB1XEXCNRAljArDvuo7/Bf2aefWJ0oKJvEHQTJ8d6eU8W0d+BevFh1+LsBo
         tjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744631922; x=1745236722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M46YccT3MF0DvncrxUNZwzbhc/mDYvaIcE3Z7FSsvmo=;
        b=TUgUsNhHu/Ue0MhsGnP0+KFxU0/NT5vQCJcDXq9lqrWGh7NrauEA1Vgb+M38tRWkVp
         ctMBsXi++ebAEkB5jIykf5EgQKTBQd7CATycIMFV3nAg/1+hp7qS05BVFHxTLoLdF5r6
         Ne3q8cp/Gr8ehsSAJgwhiBlFrCO4/2CMWC6yYpeKYY06QKpA21x/vwyZLv2VJg0uR99/
         HSVxCp6X0dQk8LXreok8RBfGm/qhXwBAjnGtPip2P2jXSQJvc28zSi1ZfUIC6+IJZQ5q
         +b1zBmqFd9WUhQrY+zn+yx4MuxTp2kxCNLIpJ4T9dE2wd69HXW4s5TMQuHZKAOx+ewkj
         kN8A==
X-Forwarded-Encrypted: i=1; AJvYcCWQRk80grnkbi73yDU+mOGU65Qm2aHEgd9u1g0FVs4ADfF8g6Tast/v/zUqvAcz7CvA4nE5hlXlpFWM8zde@vger.kernel.org, AJvYcCXGQkz/klttfwuT0zuOWpBuBqJ9+rkzlNp+vRy6sXx3G/X8zj1feehrwfICK3D71wQ4uSb18qeRu5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZ5LFke2sv2D8ScPwuiomhVBMsrw6bMV7xUFQe7Twb3ZplwtH
	qilSSFnG3gnIkZW11agVrnRyMTcWJzmY8S/IvJJFRWkjVliAeGjA38LwR1iz0d/KNxXOMwCrEcS
	RZnghrK7MPgUMtylRSPU9bw8uc/Q=
X-Gm-Gg: ASbGncsH9B9bqNV9AHEC4SfBqC1eiTEoSFipPXxJuKDp4RgkBSqgC4pIw+8RsPW86Ir
	3THw32liP7Uxtt7SJxhTYL5LLwSjRkuHA7b3OtGj1FfBfj8VWSLbOAXmpTTzJs9LUlx2mhBTTtZ
	ATNHhPuYV2hYQ7Wv53XHHRtw==
X-Google-Smtp-Source: AGHT+IGchwMv5md/5rNHB4RGLUBmwvHCTSP5W/iq/RcKNa9Gji6iVSutuVLmUL4QpJ9ChvSOy/7AbPXH2+N2WrOwHjU=
X-Received: by 2002:a05:6902:cc6:b0:e60:aa9c:8c94 with SMTP id
 3f1490d57ef6-e704de9fcacmr7658828276.4.1744631922347; Mon, 14 Apr 2025
 04:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318230843.76068-1-l.rubusch@gmail.com> <20250318230843.76068-9-l.rubusch@gmail.com>
 <20250331114029.2d828b19@jic23-huawei>
In-Reply-To: <20250331114029.2d828b19@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 14 Apr 2025 13:58:05 +0200
X-Gm-Features: ATxdqUH6TTBkHd9LLMeHElK5gcSWAYTL3Fs_VX0A2M5aUyxE5VARfQkapTN1KiQ
Message-ID: <CAFXKEHY59F54Wq7Z7MXc4cnDBq3E2gCNM6Js7CS7K+CarbwSiQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] iio: accel: adxl345: add activity event feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:40=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 18 Mar 2025 23:08:40 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Make the sensor detect and issue interrupts at activity. Activity
> > events are configured by a threshold stored in regmap cache. Initialize
> > the activity threshold register to a reasonable default value in probe.
> > The value is taken from the older ADXL345 input driver, to provide a
> > similar behavior. Reset the activity/inactivity direction enabling
> > register in probe. Reset and initialization shall bring the sensor in a
> > defined initial state to prevent dangling settings when warm restarting
> > the sensor.
> >
> > Activity, ODR configuration together with the range setting prepare the
> > activity/inactivity hystersesis setup, implemented in a follow up patch=
.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> > +static int adxl345_is_act_inact_en(struct adxl345_state *st,
> > +                                enum iio_modifier axis,
> > +                                enum adxl345_activity_type type, bool =
*en)
> > +{
> > +     unsigned int regval;
> > +     bool axis_en;
> > +     u32 axis_ctrl;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis=
_ctrl);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (type =3D=3D ADXL345_ACTIVITY) {
> > +             switch (axis) {
> > +             case IIO_MOD_X:
> > +                     axis_en =3D FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl=
);
> > +                     break;
> > +             case IIO_MOD_Y:
> > +                     axis_en =3D FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl=
);
> > +                     break;
> > +             case IIO_MOD_Z:
> > +                     axis_en =3D FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl=
);
> Same as in earlier patch; axis_en is never used.
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     *en =3D (adxl345_act_int_reg[type] & regval) > 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_act_inact_en(struct adxl345_state *st,
> > +                                 enum iio_modifier axis,
> > +                                 enum adxl345_activity_type type,
> > +                                 bool cmd_en)
> > +{
> > +     bool axis_en, en;
> > +     unsigned int threshold;
> > +     u32 axis_ctrl =3D 0;
> > +     int ret;
> > +
> > +     if (type =3D=3D ADXL345_ACTIVITY) {
> > +             switch (axis) {
> > +             case IIO_MOD_X:
> > +                     axis_ctrl =3D ADXL345_ACT_X_EN;
> > +                     break;
> > +             case IIO_MOD_Y:
> > +                     axis_ctrl =3D ADXL345_ACT_Y_EN;
> > +                     break;
> > +             case IIO_MOD_Z:
> > +                     axis_ctrl =3D ADXL345_ACT_Z_EN;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     if (cmd_en)
> > +             ret =3D regmap_set_bits(st->regmap,
> > +                                   ADXL345_REG_ACT_INACT_CTRL, axis_ct=
rl);
> > +     else
> > +             ret =3D regmap_clear_bits(st->regmap,
> > +                                     ADXL345_REG_ACT_INACT_CTRL, axis_=
ctrl);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(st->regmap, adxl345_act_thresh_reg[type], &th=
reshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     en =3D false;
> > +
> > +     if (type =3D=3D ADXL345_ACTIVITY) {
> > +             axis_en =3D FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl=
) > 0;
> The > 0 doesn't add anything as this can't be negative.
>
> Drag declaration of axis_en down here as only used in this block.
> or just combine with previous and next bit as
>                 en =3D (type =3D=3D=3D ADXL345_ACTIVITY) &&
>                      FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
>                      (threshold > 0);
>
> > +             en =3D axis_en && threshold > 0;
> > +     }
> > +
> > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > +                               adxl345_act_int_reg[type],
> > +                               en ? adxl345_act_int_reg[type] : 0);
> > +}
> > +
> >  /* tap */
> >
>
>
>
> > @@ -1347,6 +1542,14 @@ int adxl345_core_probe(struct device *dev, struc=
t regmap *regmap,
> >               if (ret)
> >                       return ret;
> >
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_ACT_INACT_CT=
RL, 0);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, =
6);
>
> 6 is a fairly random number. Add a comment for why this default.
>

My general intention is to provide +/- reasonable default configs,
rather than leave it all to 0 or undefined, to allow to turn the event
on and already catch at least something. In many cases those
will be the default values from the older input driver, to keep a bit
of a compatibility.
Particular cases have actually recommendations in the datasheet and
differ slightly to the input
driver. I'm aware that the input driver probably is not a golden
standard, but it worked at least for
my tests. I may leave a general comment on the section, pls have a
look into v6 if this is ok.

> > +             if (ret)
> > +                     return ret;
> > +
> >               ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, =
tap_threshold);
> >               if (ret)
> >                       return ret;
>

