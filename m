Return-Path: <linux-iio+bounces-13801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87879FC647
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 19:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7325D1883467
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BEE1C54B5;
	Wed, 25 Dec 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edROBbKy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC21B415D;
	Wed, 25 Dec 2024 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150437; cv=none; b=GIOqXgNbLJ0wtGn2saLkSfKoXmGmj7eXqZjgcCVrxYBtxQGasdXZlRTR83RgezGh4olTDXxa41OUKuH4SSsV4sTmyArRvHjfPgaqX/t0GOKV5i6JihskOaaD/2xSRUQnx/p7TrqeV/j+Bk7pFtdnMDLtYwfMDq3ucacq5qqp/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150437; c=relaxed/simple;
	bh=NhHTBHqeLmuClqpkKectfF/r3nQyuOLjXAJDXNb6sqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8OWaqrCMk0iE1y+/FREB0WtOr7Vj7+yBV9caZqBQZF2afGTnKSYnn40kmvwmZe6vaUtCUu2xSR3QtawslrUP1Viu+UvnuU8AgT372h6a3FSLv8QFvjgr9yGfOdADUJXjv/UMI0rndlfK4+/Ku25d1V47DrNWRej4uWRRvS3z50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edROBbKy; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e39a1af8379so803099276.0;
        Wed, 25 Dec 2024 10:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735150434; x=1735755234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbMn/qwkF1/CN92E1bOr/oboiyS7/4nz0Wl2bVMpWGc=;
        b=edROBbKyK8fPAbsQB0wwD1RtaqzkT53EhdFZL6vSKLN/hUVftrmfK1cekPfLdyr6w0
         JS3JdBZNpV0QIVuWzc4kDlPl02RbzZQctB16h1SsOFIzaS7Mg/YHjaDJvClGbUtUJNqy
         lJyR0t9C71QBJQXrj4nndt+g1n+CAXovRYt5kRXmvKR3dtSYwQINIE8NcXITBtMRlAnQ
         eizvLxSweD3P0KgZAP47R9rNkdvHQwTBBRdMre2zq0b3reXJ1CjmrGn4noMQ/O0qyxN3
         b0pxurfqTXGJt3loPy8JvzQPMPTdGzbMC4mnKgqQoDh3OUvGYRc4inNgrY9ZN4fqKo3Z
         EWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735150434; x=1735755234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbMn/qwkF1/CN92E1bOr/oboiyS7/4nz0Wl2bVMpWGc=;
        b=NVReEnbMrCdLzJrbBOl8tYBvuxZEcaUoPwywM54mwUOa6hjpIZ3tRwX6dqf2Iq053A
         Bb2MnGUBRTyp8XjTD9NZ/35XujH1sv6RczSqINkvEUrGWABK0CA5Vr5yUmr4g0igKkR9
         YaZTcDX7mFrR76F+oG9FPiK9MhTsM+FCTxFKFEiU3HP4hShnqOQfk5PYf4m5tmz1EPtn
         eLVVqYmQ2Qgc0+x5xiQ1M0WXAp5uvWADZtuii5QRZbeGkLbUWS6x1k6qyKk1DwtQU+Mj
         8u54px4jTVXeapKuAlrxVP5/89hxlUBNeje3XOK03PckMspWdElZpoDaurdBLM2BR+ir
         j5jA==
X-Forwarded-Encrypted: i=1; AJvYcCV66WKOPOkP8jy6UNz/R+VOCvbS55t9yXpD4PsDbJlbVyDCJfRn0Vfo/JrRJeWzO35MdjBgls7qound@vger.kernel.org, AJvYcCVjAZnvbBYibg+QunJp5XqVRzbjayGrINeKBX9G3St5BijL3qYSDXPPVqCVtkuCI543vyGicrBpMkjLyC+C@vger.kernel.org, AJvYcCX6uHUIcq58PXJCafSdOV03e6CeIj2+tufoo7RETPo5sndLYaSUQ7qCaDOYEhOD/zzadDCtxcQs0dVM@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbkoHWggLWKI8OmZMWLxpM7HAfbgGWEEtNtxQllalgiVwMGrY
	7TQcsxRYtFC2Sxa5GuJ0x608ap1SfvdgXcODAVbkmV9MeDZlIRTWH2ZCi7tmEBS8Ka7/32uDgO8
	mIzcF3sApdZ5VIi0h4KsWZQ6dq2o=
X-Gm-Gg: ASbGncvhj+HvXkwUXBjJGdnB2dy9UXAeTQqZtjfk+MIJ+AEdibykFlGxQtUItbugbvf
	eGyj48JwrG7jVdAz2QPDz9FeFwZhYMfezbv2OyA==
X-Google-Smtp-Source: AGHT+IG08uixnMwYoiadPIngqGHuBvD5Xgko2kdBVFNfZ+gEGqotS6uc+hA62DgUml3oWG6kzugBrd1e52qG6+iIvp8=
X-Received: by 2002:a05:6902:140f:b0:e4b:25c6:54e0 with SMTP id
 3f1490d57ef6-e538c38c299mr6384126276.8.1735150434359; Wed, 25 Dec 2024
 10:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213211909.40896-1-l.rubusch@gmail.com> <20241213211909.40896-7-l.rubusch@gmail.com>
 <20241214123641.6ab3e4c4@jic23-huawei>
In-Reply-To: <20241214123641.6ab3e4c4@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 25 Dec 2024 19:13:18 +0100
Message-ID: <CAFXKEHYpzL_xQSmgr_8+NxZe7kZRo93YUeZ=Gyzrut22P7hu3w@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] iio: accel: adxl345: add FIFO with watermark events
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 1:36=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 13 Dec 2024 21:19:08 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add a basic setup for FIFO with configurable watermark. Add a handler
> > for watermark interrupt events and extend the channel for the
> > scan_index needed for the iio channel. The sensor is configurable to us=
e
> > a FIFO_BYPASSED mode or a FIFO_STREAM mode. For the FIFO_STREAM mode no=
w
> > a watermark can be configured, or disabled by setting 0. Further featur=
es
> > require a working FIFO setup.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> I missed a theoretical bug around the dma buffer in previous reviews.
> A few other minor things inline.
>
> Thanks,
>
> Jonathan
>
> >  /*
> >   * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index fc4f89f22..e31a7cb3f 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -15,9 +15,17 @@
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/kfifo_buf.h>
> >
> >  #include "adxl345.h"
> >
> > +#define ADXL345_FIFO_BYPASS  0
> > +#define ADXL345_FIFO_FIFO    1
> > +#define ADXL345_FIFO_STREAM  2
> > +
> > +#define ADXL345_DIRS 3
> > +
> >  #define ADXL345_INT_NONE             0xff
> >  #define ADXL345_INT1                 0
> >  #define ADXL345_INT2                 1
> > @@ -26,27 +34,68 @@ struct adxl345_state {
> >       int irq;
> >       const struct adxl345_chip_info *info;
> >       struct regmap *regmap;
> > +     __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1];
>
> Ah.  The old corner case (sorry I missed this in earlier reviews!)
>
> In theory at least regmap makes no additional guarantees on how it uses b=
uffers
> on top of those provided by the underlying busses.
> So we need to treat bulk reads the same way we do for those buses.
> That means we need to allow for direct DMA writes into the buffers
> we pass to bulk read.  For that to be safe on all architectures (and not
> accidentally overwrite stuff in the same cacheline) we need to use
> what is known as a DMA safe buffer.
> Long ago we contrived the data layout in IIO to make that easy to
> do.  Just move it down to the end of this structure as...
>
>
> >       bool fifo_delay; /* delay: delay is needed for SPI */
> >       u8 intio;
> > +     u8 int_map;
> > +     u8 watermark;
> > +     u8 fifo_mode;
> this
>         __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(I=
IO_DMA_MINALIGN);
>
> This structure already has the appropriate alignment (there is padding in=
serted
> in the allocation to make that true) so by doing this for the element we
> ask the compiler to make sure it adds sufficient padding before this elem=
ent
> to ensure nothing else is in the same cacheline (if required by a particu=
lar
> architecture).   C also guarantees that the structure itself is large eno=
ugh
> to ensure padding is added after this element such that the overall struc=
ture
> size is a multiple of it's most aligned element (this one).
> Thus we end up with the buffer in it's own cacheline and none of the mess
> of non coherent DMA can cause us problems.
>
> If interested in learning more look for Wolfram's talk at ELCE a number
> of years back on trying to do DMA into the buffers passed to I2C calls.
>
> The 'in theory' bit is because last time I checked regmap is always bounc=
e
> buffering the data but there are obvious optimizations that could be made
> so it didn't bounce. A long back we asked the maintainer about this and h=
e
> said definitely don't assume it won't use the buffers directly.
>
> Note on arm64 for instance there is magic code that bounces all small
> DMA transfers, but that is not enabled on all architectures yet.

Initially, I just copied the buffer definition for the fifo_buf from
other drivers, inclusively the DMA alignment. In the hope 'probably
works similarly' adn without further understanding how the makro
works. Surely w/o knowing how to further verify, that it actually was
working.

When you remarked that my usage of the DMA alignment never could work
that way. I noticed that it was (probably) actually not even needed to
explicitely declare an IIO_DMA_MINALIGN, at least for my setup. So, to
not make it overly complicated, I simply dropped it.

I probably should have asked more questions, you now answered in
detail. I appreciate.

> >  };
>
> >
> > +static const unsigned long adxl345_scan_masks[] =3D {
> > +     BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
> > +     0,
>
> Trivial but drop that trailing comma. It's a terminator so we don't want =
to make it
> easy for anyone to accidentally put anything after it!
>
> > +};
>
> >  static int adxl345_read_raw(struct iio_dev *indio_dev,
> >                           struct iio_chan_spec const *chan,
> >                           int *val, int *val2, long mask)
> > @@ -132,6 +181,25 @@ static int adxl345_write_raw(struct iio_dev *indio=
_dev,
> >       return -EINVAL;
> >  }
> >
> > +static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned i=
nt value)
> > +{
> > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > +     unsigned int fifo_mask =3D 0x1F;
> > +     int ret;
> > +
> > +     if (value > ADXL345_FIFO_SIZE)
> > +             value =3D ADXL345_FIFO_SIZE - 1;
>
>         value =3D min(value, AD345_FIFO_SIZE - 1);
>
> Shorter and maybe a tiny bit more readable. (trivial comment!)
>
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_FIFO_CTL, fifo=
_mask, value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     st->watermark =3D value;
> > +     st->int_map |=3D ADXL345_INT_WATERMARK;
> > +
> > +     return 0;
> > +}
>
>
>
> >  /**
> > @@ -222,6 +499,7 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap *regmap,
> >                                        ADXL345_DATA_FORMAT_JUSTIFY |
> >                                        ADXL345_DATA_FORMAT_FULL_RES |
> >                                        ADXL345_DATA_FORMAT_SELF_TEST);
> > +     u8 fifo_ctl;
>
> Might as well make this declaration local to where it's used.
>
> >       int ret;
> >
> >       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > @@ -242,6 +520,7 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap *regmap,
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> >       indio_dev->channels =3D adxl345_channels;
> >       indio_dev->num_channels =3D ARRAY_SIZE(adxl345_channels);
> > +     indio_dev->available_scan_masks =3D adxl345_scan_masks;
> >
> >       if (setup) {
> >               /* Perform optional initial bus specific configuration */
> > @@ -292,6 +571,25 @@ int adxl345_core_probe(struct device *dev, struct =
regmap *regmap,
> >                       st->intio =3D ADXL345_INT_NONE;
> >       }
> >
> > +     if (st->intio !=3D ADXL345_INT_NONE) {
> > +             /* FIFO_STREAM mode is going to be activated later */
> > +             ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl=
345_buffer_ops);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D devm_request_threaded_irq(dev, st->irq, NULL, &ad=
xl345_irq_handler,
> > +                             IRQF_SHARED | IRQF_ONESHOT,
> > +                             indio_dev->name, indio_dev);
>                 ret =3D devm_request_threaded_irq(dev, st->irq, NULL,
>                                                 &adxl345_irq_handler,
>                                                 IRQF_SHARED | IRQF_ONESHO=
T,
>                                                 indio_dev->name, indio_de=
v);
>
> All under 80 chars (still the preference when no reason to do otherwise) =
and
> aligned with opening bracket which is preferred kernel style when there
> is no reason to do otherwise.
>
> If you weren't going to be doing a v8 anyway I'd just tweak this whilst a=
pplying
> but seeing as you are... :)
>
>
> > +             if (ret)
> > +                     return ret;
> > +     } else {
> > +             /* FIFO_BYPASS mode */
> > +             fifo_ctl =3D ADXL345_FIFO_CTL_MODE(ADXL345_FIFO_BYPASS);
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fi=
fo_ctl);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> >       return devm_iio_device_register(dev, indio_dev);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
>

