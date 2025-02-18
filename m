Return-Path: <linux-iio+bounces-15751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0EA3ABAA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F2F16A2A1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC791C1F12;
	Tue, 18 Feb 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4WaTPFP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A22862A5;
	Tue, 18 Feb 2025 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917825; cv=none; b=buW6T10lobNnHsqTAv9mwkYRVkkP7EdD5SAUeIuj45R9i4UeD82XCk8sNhJGdCcqZjeQLw8QDlsemtsjnVQ6xdWAatmyV1btboN2Lg7BuzV4Xchjtb2MMTkX2gP5/puN2tc1UXjoSFnRLBqYbVZJcoBuTJTYbozavp3pXpzL4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917825; c=relaxed/simple;
	bh=axuO/bgb4a9u82P0rvNZOgyAoie76/dMy6HvFmThlgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDcizju1Wa6rFfpXZclhiDkP5rWR9xPQaaa8mSVlrab1Vmr2C8+73oMC8E+AxzlJLdI8evjPqcs6BBpB0jfahPg8SB3FIagUrUgR8xbXv/tTNAWdfgilXqoRKvpLHTIlgpO9Z0/EQumTuuwlwW53YkXlDQdKx0p2J9N9Iw5neeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4WaTPFP; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5e02e4db08so111965276.3;
        Tue, 18 Feb 2025 14:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739917822; x=1740522622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=si1H8XSMOMxRh6bZAdV2fbSzTyyk2PyI/He5XZxEvnE=;
        b=G4WaTPFPAScnhBKCCEI0P/BGBa42pZPGe16P9NXze9lyGkVtEh0puDwL8I/b6lzF/X
         NypDHGKVBzSbawyj+qmDQodh24eiVm3J5igCsPthYuoLM2ECuQ/PwtybtggI47kmkLnm
         9u2cZWNi2X9uIgff/n5bI54rYBafOS74m7lmAxHVPOFkGb8hJBTq6bETpPvMzQp7WolK
         ATwIcQRAKQTTf5Ry4Ung7Drt/KGRa/b48ckgz4ZT3LP8O//+l+/cTP65J7YX1LHce5qW
         8gf8gtgv1by5hgMw8KhIc/kGT7eUpe6rqO+gwKKEfwBbEwNvZB1R+g9nD47EyXhnijX8
         UPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739917822; x=1740522622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=si1H8XSMOMxRh6bZAdV2fbSzTyyk2PyI/He5XZxEvnE=;
        b=J+47tbL70x2+9EbDdRkfkUwCtYGOw7wPBeMP6UQ6/xr8xWBthG0RBV95yYmQKREvSH
         YBVYuBTYzQyIMbCdNGdAz11g/k9APeGzPwHB9eVvSvMzFg6jTiJAAnQMQanUANi+q+XU
         wZwaUQUXd+cqxtWPT4xzybyDyfH7dFFM0oSJRl3Bgjtq+xcnoEp3O7uBG1+2ycSX7+9C
         3MyLHkd4NAcfltdFn3oC5XdIwR76wdxWDyigwICDmaCQcZ3nWADA/7lowabymu6uhM3U
         6zgjCoULEPmu/nf9mjXhM6EapVOwOrhDklnh8EhVduhCWtKk7Mb90N6w306tpcIY7ElB
         vI7g==
X-Forwarded-Encrypted: i=1; AJvYcCUAzcqfIrDTSCEwTqex8SYIN/c/RrniIvzSuTOCgmGvFiWbVvKkpB6eKQT/aiptf4FRhwHtC39R567i7vCJ@vger.kernel.org, AJvYcCVwvWAg6JcEyMyQ8JPM+1ihXjeApDgIajTcwdbK4127QB2RSS3jUROVb6mi0GeQ5EuM0XzLzU5DsTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxObo5TXvaOTNf35pEcPDDY/SAK9QreoPKW/Z2/EB3YA26Vcd
	pSBZQqVNSbRjb+09xzzgGA7V/R3ztPLiFlU9GFVJAJsADFPeGKhFqjK1LVbXQGEExWmxRNusnXO
	2uYpqzDmZyXjTw1QYWNaf81q0nEs=
X-Gm-Gg: ASbGncs/BaSqutWGFpEFzoT/rx3hgDoyqXVcH7+kEx/e/GuS8y/M1R1j5recIUPOiD2
	RjmegsJvfpXjNQwcZWJxO6eRGi9KlfJQYi3kYQGz9mKljM3ON3A2VH9E78EkmeWF0LGMQtHIm
X-Google-Smtp-Source: AGHT+IGc4zyuxtJ1p+dDbPgeU4DdVInFhhVT96R3F/yrFDC4NwqlsdxT0BFDjqDYWBym5+lfH9on9qYUUXevhxA2M2c=
X-Received: by 2002:a05:6902:e87:b0:e5d:e371:78a3 with SMTP id
 3f1490d57ef6-e5de3717962mr2637263276.9.1739917822030; Tue, 18 Feb 2025
 14:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210110119.260858-1-l.rubusch@gmail.com> <20250210110119.260858-8-l.rubusch@gmail.com>
 <20250216172845.2fe98ea1@jic23-huawei>
In-Reply-To: <20250216172845.2fe98ea1@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 18 Feb 2025 23:29:46 +0100
X-Gm-Features: AWEUYZkhScovBLHKmG_u-H8znUgqYyAbGrh-BrwfICH2MLxYTE6gN8YIZ4XB268
Message-ID: <CAFXKEHY+ozW=r17fdvKYhyWDKkddZxptp5kFKdD9k4mwjutPbQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] iio: accel: adxl345: add double tap suppress bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan, find my answer down below.

On Sun, Feb 16, 2025 at 6:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 10 Feb 2025 11:01:12 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the suppress bit feature to the double tap feature.
> >
> > Any tap event is defined by a rising signal edge above threshold, i.e.
> > duration time starts counting; and the falling edge under threshold
> > within duration time, i.e. then the tap event is issued. This means
> > duration is used individually for each tap event.
> >
> > For double tap detection after a single tap, a latency time needs to be
> > specified. Usually tap events, i.e. spikes above and returning below
> > threshold will be ignored within latency. After latency, the window
> > time starts counting for a second tap detection which has to happen
> > within a duration time.
> >
> > If the suppress bit is not set, spikes within latency time are ignored.
> > Setting the suppress bit will invalidate the double tap function. The
> > sensor will thus be able to save the window time for double tap
> > detection, and follow a more strict definition of what signal qualifies
> > for a double tap.
>
> Silly question.  Is there a reason this function would ever be
> turned off?   Seems like a sensible heuristic that would not stop
> genuine double taps being detected.  Maybe we just always leave it on?
>
> Sometimes the best ABI is the one that doesn't exist as userspace
> can't use it wrong.
>
> Jonathan
>

hehehe..  you already mentioned this point, I guess. At least I tried
to put my understanding of it into the lengthy comment of the patch.
Well, patches with lengthy comments.... this seems to go into the same
direction as the wisdom of better limiting userspace interfaces in
general ;)

TBH you have probably seen far more sensors than me, as I'm doing this
just as hobbyist to learn and for fun. I only can provide my
understanding of the particular datasheet.
I think, to set or not to set this bit changes little. It influences a
bit how restrictive the latency period is handled at detection.
Doubletaps are detected with or without having the "suppress" bit set.
If set, AFAIK it could be harder to detect doubletaps. So to speak,
you could reduce "noise" in double tapping (?), or if one receives too
many double taps...(?) perhaps,  ..eh.. legal reasons?! Personally,
I'd liked to play with this sensor a bit, and I found it then useful
to have some kind of knob to change a bit and see what happens without
really messing things up.
As I'm not too familiar with the accelerometer scene and such kind of
"power user settings". I'm unsure if there are typical usecases here.
I would agree that usually one would leave that in one  setting,
turned on or off (unless he/she enters in obsession with double taps).

Perhaps I'll change this patch so that it's always set or not set (to
bring it initially into a defined state), but no sysfs is around.
Let's see. If you think I'd better just drop it entirly, let me know
then.

Best,
L

>
> >
> > This brings in a new ABI functionality.
> > ---
> > Q: Perhaps there is already some IIO ABI for it? If not, please let me
> > know which ABI documentation to extend. There will be a documentation
> > patch also later in this series.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 82 ++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index cf35a8f9f432..b6966fee3e3d 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -34,6 +34,7 @@
> >  #define ADXL345_INT2                 1
> >
> >  #define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > +#define ADXL345_REG_TAP_SUPPRESS_MSK BIT(3)
> >
> >  enum adxl345_axis {
> >       ADXL345_Z_EN =3D BIT(0),
> > @@ -81,6 +82,7 @@ struct adxl345_state {
> >       u32 tap_duration_us;
> >       u32 tap_latent_us;
> >       u32 tap_window_us;
> > +     bool tap_suppressed;
> >
> >       __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(I=
IO_DMA_MINALIGN);
> >  };
> > @@ -243,6 +245,31 @@ static int adxl345_set_doubletap_en(struct adxl345=
_state *st, bool en)
> >       return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
> >  }
> >
> > +static int adxl345_is_suppressed_en(struct adxl345_state *st, bool *en=
)
> > +{
> > +     *en =3D st->tap_suppressed;
> > +
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_suppressed_en(struct adxl345_state *st, bool en=
)
> > +{
> > +     unsigned long regval =3D 0;
> > +     int ret;
> > +
> > +     en ? __set_bit(ilog2(ADXL345_TAP_SUPPRESS), &regval)
> > +             : __clear_bit(ilog2(ADXL345_TAP_SUPPRESS), &regval);
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
> > +                              ADXL345_REG_TAP_SUPPRESS_MSK, regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     st->tap_suppressed =3D en;
> > +
> > +     return 0;
> > +}
> > +
> >  static int adxl345_set_tap_threshold(struct adxl345_state *st, u8 val)
> >  {
> >       int ret;
> > @@ -616,6 +643,60 @@ static int adxl345_write_raw_get_fmt(struct iio_de=
v *indio_dev,
> >       }
> >  }
> >
> > +static ssize_t in_accel_gesture_doubletap_suppressed_en_show(struct de=
vice *dev,
> > +                                                          struct devic=
e_attribute *attr,
> > +                                                          char *buf)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     bool en;
> > +     int val, ret;
> > +
> > +     ret =3D adxl345_is_suppressed_en(st, &en);
> > +     if (ret)
> > +             return ret;
> > +     val =3D en ? 1 : 0;
> > +
> > +     return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > +}
> > +
> > +static ssize_t in_accel_gesture_doubletap_suppressed_en_store(struct d=
evice *dev,
> > +                                                           struct devi=
ce_attribute *attr,
> > +                                                           const char =
*buf, size_t len)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     int val, ret;
> > +
> > +     ret =3D kstrtoint(buf, 0, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_measure_en(st, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D adxl345_set_suppressed_en(st, val > 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D  adxl345_set_measure_en(st, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return len;
> > +}
> > +static IIO_DEVICE_ATTR_RW(in_accel_gesture_doubletap_suppressed_en, 0)=
;
> > +
> > +static struct attribute *adxl345_event_attrs[] =3D {
> > +     &iio_dev_attr_in_accel_gesture_doubletap_suppressed_en.dev_attr.a=
ttr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group adxl345_event_attrs_group =3D {
> > +     .attrs =3D adxl345_event_attrs,
> > +};
> > +
> >  static void adxl345_powerdown(void *ptr)
> >  {
> >       struct adxl345_state *st =3D ptr;
> > @@ -899,6 +980,7 @@ static irqreturn_t adxl345_irq_handler(int irq, voi=
d *p)
> >
> >  static const struct iio_info adxl345_info =3D {
> >       .attrs          =3D &adxl345_attrs_group,
> > +     .event_attrs    =3D &adxl345_event_attrs_group,
> >       .read_raw       =3D adxl345_read_raw,
> >       .write_raw      =3D adxl345_write_raw,
> >       .write_raw_get_fmt      =3D adxl345_write_raw_get_fmt,
>

