Return-Path: <linux-iio+bounces-17019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C301A67157
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 11:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD7217D1DF
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B89820469A;
	Tue, 18 Mar 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh865Mg7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE641F4E38;
	Tue, 18 Mar 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294013; cv=none; b=YNLMvRFat/dUeuG8o4BefAfKL1+ATnWxST7oD6faaFWDRr9l+yxYjah33vgfSXOf42iYpWsAu62V/nttn5r/S2HPSIU5dWjjqV4sHHrj/H9zewPQ1q1tW/q8ZZo4RoD66Ybh0khJEUJvgXFLI4eqFmBQtTO0pb/qkX3zrs3Sg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294013; c=relaxed/simple;
	bh=G4i4sTE8q4SvedSzBTT1esCwnEQReq/hMn67xuypJO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SII1PGJe4wNl/iWD4cuJdRTIdEXZPqsgqsBs2PpAmvW48wuA61dmUQY1WK6bZeQdOJduxidQPOqOJQvxUkFlfzxlnvSGDkW2HjbKcg5lkFDKjyUOkWOqcBImSpuyuJ82J+SyXzeJdw1U857pv2wRSPxXPNofvnE3SzkzHbArZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh865Mg7; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e636630da89so672798276.3;
        Tue, 18 Mar 2025 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742294011; x=1742898811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA1LUYYfbqtQP1h//DZ6W5809Oh0Z1YBlg0tTf/X5N0=;
        b=Xh865Mg7+vIYYjL8nR9yhjPERiA24BGJyxHAPjhe19MZZgImKtYvBvDkHhifrWJnQV
         g1lut7QdWh4qsDp5uXew3Yoz4nBTPK7O0ADeGvJUI0Z/Fijzb9AwFjMNv51/5CSXTQlk
         AcNiLOBsfWWj5HXbIPsPCjgUUUcqjd7DlXLT7fc57BJyi/OqtHRMDZGWRszyS8q9S7fG
         XtYD+0GOC9PC1NCDEUqliQnhplOFZOIX0wgkW7l5Vr5uV2B9FE7NelaRGaqZq/BE4VOL
         gqFoWzD79Z7NU/NN4ZFkaxHcTf4dotm9AR2HFkRh2mvqlUY4NBMWH3nceJLwG/UpPMZA
         WVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294011; x=1742898811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA1LUYYfbqtQP1h//DZ6W5809Oh0Z1YBlg0tTf/X5N0=;
        b=UfQiI2B5eBcup5oM6BcakM1K1kRv+wXjsKAdyhUxfy6capWE7LUfd8frmrXUZ99CNg
         QMsqr7uquKhlABCfPZZLbYAmSytB+Ee/e1BZwQxXlaO1PMUb6xdp6AymveGK/2xjzHSF
         YhJQ5AkG2HNUrK2S/z1mJjnnsP/v1XF9zPKR2+g9H53bu1cvW6v0o7SXgJSrfekX3Znt
         TDSoA8ZpVHT5qi1rVsuBlYUcGMDabexzChzTJS72VMxmyBgXZie7xNUe1nA5hlw3R1NX
         NNSwxkxZlYC/iJ7vCDTg+84ULeX7O8OZIS/J3GqJLOy26nQMvlGD4vqx1q/aYVtSA97n
         HL9w==
X-Forwarded-Encrypted: i=1; AJvYcCU4NB0d2gAJL/0kzTi9IDRybt9v0FjgcrOAl192eefzcWEJsASYsru6Hcf3g7efCJM8BGnz4wd8tmM=@vger.kernel.org, AJvYcCX3pOhXRuBeKMeHged0iC8kpzNK+hPmBXSR2o5j9qaPR9iKNrRRdZPYE5Il+hqW5FhmbG0jRN+qZyLZODqB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+elNOXcAwX7tvmfBCuN9lEuvcDQd1gOlb+DfvYczZ0xnee/pA
	w3+CGpwqGct/Ui85YW4ptphRlBu2TY44F3oL7JQ+jdhr9YRG+5Wnji+OpXCww9mWcRSrCq5JtzW
	0GG4C9iF36EC9Hy7OKwCsQKFNYPw=
X-Gm-Gg: ASbGncv7YhFfuE/vWmyWsVyQVbxUdHJlI+yasffcpFC1bN4vrvtpCfnlJPyFO2DwhSW
	wOQN6DlP5FzTOFTrO26dYIE3vodE8TUT0jS7genpEm5L0zk4lmL8Df9fipDFbFLjQEaCwZ2oMPR
	c2B0hfNMlA5s6PuewZf/CT9TVD8g==
X-Google-Smtp-Source: AGHT+IEvaz4NhkxwobgEK8ikUT7Kc2lcnhfuwErioQfLWAfaExY/f4zpCEYtArnNWu7S/0bhR+zRXl+Rq0uyvLmPxjY=
X-Received: by 2002:a05:6902:114a:b0:e5d:f9bc:1ba5 with SMTP id
 3f1490d57ef6-e63f64c3622mr9409312276.2.1742294010644; Tue, 18 Mar 2025
 03:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313165049.48305-1-l.rubusch@gmail.com> <20250313165049.48305-6-l.rubusch@gmail.com>
 <20250316112057.638626bd@jic23-huawei>
In-Reply-To: <20250316112057.638626bd@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 18 Mar 2025 11:32:54 +0100
X-Gm-Features: AQ5f1Jo4eKAgjvIEDD3ILFzPQBVX8P2XpLVDC75bSivh78-5Dcfeb5OxTpkhtFk
Message-ID: <CAFXKEHbxbjzNunauPFCFUwhn3k5F1Ki2sgVFu2y2HxxPot2MfA@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] iio: accel: adxl345: add single tap feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 12:22=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 13 Mar 2025 16:50:40 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the single tap feature with a threshold in 62.5mg/LSB points and a
> > scaled duration in us. Keep singletap threshold in regmap cache but
> > the scaled value of duration in us as member variable.
> >
> > Both use IIO channels for individual enable of the x/y/z axis. Initiali=
zes
> > threshold and duration with reasonable content. When an interrupt is
> > caught it will be pushed to the according IIO channel.
> >
>
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> Hi Lothar,
>
> A few things in here are from the discussion that was continuing
> on v3 so I may have said more replying to that.
>
> Anyhow, for now I'll hold off on applying from this point on as
> a few more things to respond to inline.
>
> Jonathan
>
> >
> >  #include "adxl345.h"
> > @@ -31,6 +33,33 @@
> >  #define ADXL345_INT1                 0
> >  #define ADXL345_INT2                 1
> >
> > +#define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > +
> > +enum adxl345_axis {
> > +     ADXL345_Z_EN =3D BIT(0),
> > +     ADXL345_Y_EN =3D BIT(1),
> > +     ADXL345_X_EN =3D BIT(2),
> > +     /* Suppress double tap detection if value > tap threshold */
> > +     ADXL345_TAP_SUPPRESS =3D BIT(3),
> > +};
> As per feedback (after you sent this!) on v3, I'd drop
> the last value out of the enum, or just use defines and a u8 for
> the one place this is used for local variable storage.
>
>
> > @@ -198,6 +387,132 @@ static int adxl345_write_raw(struct iio_dev *indi=
o_dev,
> >       return -EINVAL;
> >  }
> >
> > +static int adxl345_read_event_config(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     bool int_en;
> > +     int ret =3D -EFAULT;
> Not used?
>
> > +
> > +     switch (type) {
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (dir) {
> > +             case IIO_EV_DIR_SINGLETAP:
> > +                     ret =3D adxl345_is_tap_en(st, chan->channel2,
> > +                                             ADXL345_SINGLE_TAP, &int_=
en);
> > +                     if (ret)
> > +                             return ret;
> > +                     return int_en;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
>
> > +static int adxl345_write_event_value(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir,
> > +                                  enum iio_event_info info,
> > +                                  int val, int val2)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, false);
> > +     if (ret)
> > +             return ret;
> > +
> So in my brief reply to the v3 discussion I suggested perhaps
> factoring out everything from here...
> > +     switch (type) {
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     ret =3D regmap_write(st->regmap, ADXL345_REG_THRE=
SH_TAP,
> > +                                        min(val, 0xFF));
> > +                     break;
> > +             case IIO_EV_INFO_TIMEOUT:
> > +                     ret =3D adxl345_set_tap_duration(st, val, val2);
> > +                     break;
> > +             default:
> > +                     ret =3D -EINVAL;
> > +                     break;
> > +             }
> > +             break;
> > +     default:
> > +             ret =3D -EINVAL;
> > +             break;
> > +     }
> to here, so as to allow simple direct returns.
>
> I think that will make the code more readable given the need to reenable
> measurements and that you want to leave it off on error.
>
> > +
> > +     if (ret)
> > +             return ret; /* measurement stays off */
> > +
> > +     return adxl345_set_measure_en(st, true);
> > +}
>

Hi Jonathan, my reason to leave this part unchanged was the following:
As you can see above, 'return adxl345_set_measure_en(st, true);' - I'm
actually need to turn off measurement before changing values, then to
turn it on again after. In case of error, doing a simple "return ret"
would keep measurement generally off. I think I should generally try
to turn it on again after.

Alternatively I could do something with goto/label to turn measurement
on, but then return ret. My choice here was to use this ret approach
together with break, at cost of readability. Any advice?

