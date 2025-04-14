Return-Path: <linux-iio+bounces-18075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4DA87F6C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 13:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D767AA89B
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D5298CA8;
	Mon, 14 Apr 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8Uo6uZe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F417280CDC;
	Mon, 14 Apr 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630920; cv=none; b=jH5qUybvKKton1mRNJqKO52eLbttZTYy5liWNFJOkNfHZjk2f+fdMwHCkqy7QvplakyKO7BB/wjU3Al+sGuEQqXpoZHk6eMPUve1OdFr84sKsqqiQjzbeC0Cv8yUUBwRphyqul6r5D7XjXrqJNnXbLwdpUt8Wb/TVLPiblUGQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630920; c=relaxed/simple;
	bh=+flCr9B8P37u4bBFb3aOCmmw+SZCIGiAOZIqkNB3dU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asKPde/59VNjgPbeKirBVA2Hu9CBzT/6UVTRTFMusRjG4Eh21mcjF2ocAUg4Nw0YO3smvwAa62UrsxvpCgWrf3XRAQQir1DuLIeUn/b7z4Hh4CvAEqXtcIM1s6cLWzZ4K0mgLiNysSNfKBBANGSc5zqCveOIpoBVAAyKfg6QiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8Uo6uZe; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6e01e8f4cdso530179276.2;
        Mon, 14 Apr 2025 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744630917; x=1745235717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0evTumqrDq5rgQu+eyGkQcd4gB3aTt7ZM+UWsJy63Qg=;
        b=A8Uo6uZeYPj1rQzlqOIw+ZGnSzftDojEHVlwV+P8B+n6FjXQkrjepsBPnc1uwsMvss
         r337kgFaxjdXySjdMZoSW/EaMZ6BMwb+0sZbNvYotGHYphavJkS7kj1Ol7+cG4vVh8ec
         HlrhAiMdoeKW+/gSNfR9TTPGE22gdaNb/ioT87ceM1w3z6yACUFCxQuGqSltVM2FuRDe
         tAW/GCVLGPr7v616OQvUkGuato8A9CeQg7atiT1XkdMidbiYJLqowcNsduCiLwrleYWP
         sgsGhLVdABrf4HCbhRqVc/RSjsW0aOhjfkBSDhu3kZZPkGQAExq89N1GVX3vOKjnCGhH
         5kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744630917; x=1745235717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0evTumqrDq5rgQu+eyGkQcd4gB3aTt7ZM+UWsJy63Qg=;
        b=XfhInPEjh1lQ+JuKbK+FO/uZz9q1rPYt6/33/7rKjSty9FGEcuhSshzEw63UIq7jIN
         TObqZ36laIgmy2ufy6ftRvA7SiqB3PtAX2CW0EYWczO0LZNZVdoRs4NA0AIBbph8c8Lh
         ves0Dic+s5iN50PGv5rrOadqA/htyjahJfZV+t/zqLu4uyo0S/0R8elRGYJiOpbE58w8
         CMplLJO3vWuBTQ8LZlya34GFQDS21NiJhuge+CKSsaEdsy0fne0qUJo2WtUlrVtnnJip
         t06Mvh6+t5aJmNcnMIZ37VxTwBnKwKr3ybaDPOzinBZd+hlbRCrn5lXNig2nqIyTZ61a
         M16A==
X-Forwarded-Encrypted: i=1; AJvYcCV+yQEIkUwqp9Xj84Pd+rPhOJQ0MiUMIEAdp+1h6TTpSD083aU0/ixuhO4t8ivGoy3b045QXH1Hh68=@vger.kernel.org, AJvYcCV5eX+l/T8W/N3ilHz3e7Ga3B8AFSADMiDOv5dAOi4e3YguWj+IGSp4wzTq6gU98FVpzPXrtFZSMe3Hh63d@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhhfqTgPt6qh2Ftw+vpNZVgu9WE5Z3At+qmETTnjyJCB8DdOa
	kpocjfLfzB59gMktXyS548sS3GXsjlxTORi7SA1jbK+EgBOwvASQXneGoNiywgMCU5m8BNrREwK
	sAeDSLixTmPWrgBPqmMYQ7izCQAw=
X-Gm-Gg: ASbGncvYnVaYtx9M/GStrCWqbcR3L2Ac+QoGzTkudjEQnRAXYO/xuMjxxPg3JYRE8oI
	T0MTSpMSG2hZzoQ93N4HTlPxSlDDA/WOWn9q5blSaikXU3LShV3WgY2yL793p4kgMAeOGlLUcaY
	WBLuyc1PJlcESBLQhNp03sag==
X-Google-Smtp-Source: AGHT+IFDomMNYVsrWNhO0Ec+GPOxt3o6S//Vn3Jrwr6Xb1c+fiIJiCnf/nVaQcMB0WQLscuTGS6QO8aX6JkUHEsKsQE=
X-Received: by 2002:a05:690c:60c4:b0:704:3da8:f8cf with SMTP id
 00721157ae682-70559abb1b0mr85861067b3.7.1744630917021; Mon, 14 Apr 2025
 04:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318230843.76068-1-l.rubusch@gmail.com> <20250318230843.76068-7-l.rubusch@gmail.com>
 <20250331113300.08379a5a@jic23-huawei>
In-Reply-To: <20250331113300.08379a5a@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 14 Apr 2025 13:41:20 +0200
X-Gm-Features: ATxdqUFT2CFgzE3Or-cOLwHoJMOZ6Ky5yPqesU3WPs1SKmDmfbPBAjyLfLgpHGU
Message-ID: <CAFXKEHau6n2o_MPimiEkYRNvE3TO9f5j_tDH0FwJYsk6V5B9WA@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] iio: accel: adxl345: extend sample frequency adjustments
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:33=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 18 Mar 2025 23:08:38 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Introduce enums and functions to work with the sample frequency
> > adjustments. Let the sample frequency adjust via IIO and configure
> > a reasonable default.
> >
> > Replace the old static sample frequency handling. During adjustment of
> > bw registers, measuring is disabled and afterwards enabled again.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> One minor thing inline.
>
>
> >       return -EINVAL;
> > @@ -504,7 +581,12 @@ static int adxl345_write_raw(struct iio_dev *indio=
_dev,
> >                            int val, int val2, long mask)
> >  {
> >       struct adxl345_state *st =3D iio_priv(indio_dev);
> > -     s64 n;
> > +     enum adxl345_odr odr;
> > +     int ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, false);
>
> Why is this necessary but wasn't before?
> If it should always have been done for existing calibbias etc,
> perhaps a separate precursor patch is appropriate?
>

On the one side the datasheet recommends to have measurement disabled,
when adjusting certain sensor registers, mostly related to interrupt
events. Before the sensor was operated in FIFO_BYPASS mode only
without using the sensor events. With interrupt based events, it will
operate in FIFO_STREAM or similar. Then it seems to me to be a better
approach to put it generally in standby mode when configuring
registers to avoid ending up e.g. in FIFO overrun or the like. On the
other side, I saw similar approaches in the sources of Analog sensors.
Enable/disable measurement was done there in the particular functions.
In the particular case of adxl345_write_raw, odr and range values are
going to be set and I implement enable/disable measurement directly in
the write_raw. In comparison to the ADXL380 (different sensor!) where
this is done, too, but down in the specific setter functions. I can
see a bit of an advantage, if something fails, the sensor generally
stays turned off. I'll keep this in v6 of the patches.

Pls,  note, I did not observe faulty behavior due to that or analyzed
it thoroughly if and where it is probably better to have measurement
turned off. At best, it won't make any difference and is probably
rather kind of "best practice". If not, I would expect rather sporadic
minor issues.

As always, pls consider my patch(es) as a proposal, sometimes with an
invisible question mark ;) If you have a contrary opinion and/or
experience, please let me know.

>
> > +     if (ret)
> > +             return ret;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_CALIBBIAS:
> > @@ -512,20 +594,26 @@ static int adxl345_write_raw(struct iio_dev *indi=
o_dev,
> >                * 8-bit resolution at +/- 2g, that is 4x accel data scal=
e
> >                * factor
> >                */
> > -             return regmap_write(st->regmap,
> > -                                 ADXL345_REG_OFS_AXIS(chan->address),
> > -                                 val / 4);
> > +             ret =3D regmap_write(st->regmap,
> > +                                ADXL345_REG_OFS_AXIS(chan->address),
> > +                                val / 4);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> > -             n =3D div_s64(val * NANOHZ_PER_HZ + val2,
> > -                         ADXL345_BASE_RATE_NANO_HZ);
> > +             ret =3D adxl345_find_odr(st, val, val2, &odr);
> > +             if (ret)
> > +                     return ret;
> >
> > -             return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE=
,
> > -                                       ADXL345_BW_RATE,
> > -                                       clamp_val(ilog2(n), 0,
> > -                                                 ADXL345_BW_RATE));
> > +             ret =3D adxl345_set_odr(st, odr);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> >       }
> >
> > -     return -EINVAL;
> > +     return adxl345_set_measure_en(st, true);
> >  }

