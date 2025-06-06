Return-Path: <linux-iio+bounces-20260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245AEAD0047
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF951893DD5
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60FD286880;
	Fri,  6 Jun 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSBccEjm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E083234;
	Fri,  6 Jun 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749205234; cv=none; b=qPxaPq2u2qtzitvP4R+zbjul7g1F5iwDHbsaqsVCN2WtjrrYx+sqtLxRiCPWYmE1TRHZqZMSR0xdNBt0htwC34NxTh30Asdt47InKMLVNcJ73yurZjvV8e8hi80qNbEyQy8PON0rcLFDxseBdcTGqsNCLoDA3JSuIZMv+BC7PJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749205234; c=relaxed/simple;
	bh=AI9QxnSNlM1JhP8O648z9WCcHecmjP9gRcEPyx816sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tegrCi5E7x57Ndo/AUVEeju82upAxtEZvR8uX9uL/b6jtjscyPJ2okbfmV21c7oW0ToyV7vqQR2t66XCpa59b2OwmjugCW7wtuFvFVkjIQkKidwQAuzoQcFJ/mSscmHLHaQ9CaTNhRskRwBQM4fDA6IrxwCFq3VfMep+rqqL0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSBccEjm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1186012a12.2;
        Fri, 06 Jun 2025 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749205232; x=1749810032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETuL9D8RSnjYVVX5ojRIWsdvRALWmvbl6BZ2BJtWtAA=;
        b=VSBccEjmiLIAmYLByxwObE8+PcsAhzQH0uyNzG2mrXaVjlWAbwg4+ZXjy+Ako87+K5
         sbiGsfC328QyydzZKE9T4TgBhjPDjlop90iY/73OcnWdexOrzFh/WFjb/7DfRHdiZaY9
         jRnMkLF1kb9e1bXwcQtQpVtWqjz5D8VbxqmA1ogCmcmfRipspEqgNk6KDaCYKT1jNIIB
         MND+bsqqoWLC5w+QSzSnZi/D0TRnfa95/4K2sySwpZuCKTD4cVy0RSBTxxup1QrDoBy/
         s6WGchTcsxATtqAeXOTVJlRNzrlPME24qMJ631yXgU59S1UEfczKlB5t8j0RTqwvUCFp
         XR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749205232; x=1749810032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETuL9D8RSnjYVVX5ojRIWsdvRALWmvbl6BZ2BJtWtAA=;
        b=j1ZpIGWYtjhCTqmbl9zxaH4RIUeBM0THKFEIi4U6nYEo4cLvEwYOzmM2FRJSzZhW9M
         eHlVnB0ilJagZkJej8Q1SddsNNWONOG9SBn2y8/2Gyc6/f1kXPQPL0/iqbEY5E1FQd3C
         MsN58Qob+qn3d4JnxfvFed95Op+VH6HQl+oSPDeRJav39pRq6yokHzSSEmC9CJXvgLR5
         PGyAGEg+LxtNshC8BqZ5tA8hHRahTPM3ytyFXc17oKT6rhF6ct6rMN37BhLPsF8mrZFf
         mNioiKr1ZNqLuxa9prgqnT87YmGGQMt0uhcYza6BjIFYYigjoOkoa0U9PPpL0RZULO/J
         591Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOXgksaAVb5IjauRWb5w7E+YOikf4JZgLwV+nYHDKTM6PDca+l/uuRrrc+wJX/EceozcnJDHmwKOQaHSEc@vger.kernel.org, AJvYcCUped54cfgt9cmxkvKW9utAeFr2HYRqWwMAMA93bm9c0gsTYKZJSfZdklDDKjruyhaPaHPIBEv5mkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq47O/T6UBc+GP2BVuOBFrQjROBQVmVSvbGY/9sMVcX7Za1Rll
	m2E+bEJWbvO5+oUAY/Y2ouN/uTcFML38iRRLHbTUCNMsctpg5tljUpWMuNO7I4A7QDWaBF7lvlG
	QbKueSuvlHLdsX74PnZzTRZZ3vfaky/Pgz1ok
X-Gm-Gg: ASbGncsL48u8GLRD2PGgwRVKljlnLN3VLmuMjXV+ixfvLu/G0wdbBftDzhRvNbjStZN
	cWwNOiHd2zzJKj0J1SBotN7rb6weRVwj/3ngIODaZwZQH+8JtlZFrPwWvWYW649wlNeFLsnHR81
	DHvGaf5+5yztcehLuZ1jm887j/Q8IhExiEozmcGyXWgRtTiwa9tzLKNmc=
X-Google-Smtp-Source: AGHT+IGITB9DBn7CmTh1MRgISUua3cg7nL0VseDHA+PSfOIAybb0qSIsTuS4UM+XJFXPczOmhY1Qh5TlzqXxjNy32Bg=
X-Received: by 2002:a17:90b:4a45:b0:311:a623:676c with SMTP id
 98e67ed59e1d1-3134767ec60mr4449882a91.27.1749205232170; Fri, 06 Jun 2025
 03:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
 <20250519-timestamp-v1-9-fcb4f6c2721c@gmail.com> <20250531191446.1b1d2e2f@jic23-huawei>
In-Reply-To: <20250531191446.1b1d2e2f@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Fri, 6 Jun 2025 19:20:21 +0900
X-Gm-Features: AX0GCFsHqzI1dazPGDMbPbzMFgCJGMuZ1DrDeWG1LJC8Ri66fX2V3xX0UHuQhuk
Message-ID: <CAKbEznvpL6Wj9oOqZkcw5fRzjgDa4zx3Mk+=cj5BQmkLPZHNDA@mail.gmail.com>
Subject: Re: [PATCH RFC 9/9] iio: rpr0521: Use new timestamp-related APIs
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 3:14=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Mon, 19 May 2025 23:26:01 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> > This patch is an example that helps explain the previous series.
> > Now there is no need to handle timestamps differently depending on whet=
her
> > the consumer is attached to its own trigger or to another trigger.
> > And the own trigger of rpr0521 can simply pass a timestamp to consumer,
> > using `iio_trigger_store_time()`
> >
> > Not tested since I don't have the corresponding device.
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
>
> Ah. So this is what the trigger grabbing timestamp thing is about.
>
> I'd just ignore this case for now and solve the simpler one
> of what to do the the pf->timestamp stuff.

Yes, since they can be logically separated, it seems much better to
split the patch series as well.
Thank you for the review.

> That part of the patch set looks promising to me.
>
> Jonathan
>
>
> > ---
> >  drivers/iio/light/rpr0521.c | 22 ++++++----------------
> >  1 file changed, 6 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> > index 92e7552f3e39..32981db18428 100644
> > --- a/drivers/iio/light/rpr0521.c
> > +++ b/drivers/iio/light/rpr0521.c
> > @@ -186,7 +186,6 @@ struct rpr0521_data {
> >       bool pxs_dev_en;
> >
> >       struct iio_trigger *drdy_trigger0;
> > -     s64 irq_timestamp;
> >
> >       /* optimize runtime pm ops - enable/disable device only if needed=
 */
> >       bool als_ps_need_en;
> > @@ -416,7 +415,7 @@ static irqreturn_t rpr0521_drdy_irq_handler(int irq=
, void *private)
> >       struct iio_dev *indio_dev =3D private;
> >       struct rpr0521_data *data =3D iio_priv(indio_dev);
> >
> > -     data->irq_timestamp =3D iio_get_time_ns(indio_dev);
> > +     iio_trigger_store_time(data->drdy_trigger0);
> >       /*
> >        * We need to wake the thread to read the interrupt reg. It
> >        * is not possible to do that here because regmap_read takes a
> > @@ -446,15 +445,6 @@ static irqreturn_t rpr0521_trigger_consumer_handle=
r(int irq, void *p)
> >       struct rpr0521_data *data =3D iio_priv(indio_dev);
> >       int err;
> >
> > -     /* Use irq timestamp when reasonable. */
> > -     if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
> > -             pf->timestamp =3D data->irq_timestamp;
> > -             data->irq_timestamp =3D 0;
> > -     }
> > -     /* Other chained trigger polls get timestamp only here. */
> > -     if (!pf->timestamp)
> > -             pf->timestamp =3D iio_get_time_ns(indio_dev);
> > -
> >       err =3D regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
> >               data->scan.channels,
> >               (3 * 2) + 1);   /* 3 * 16-bit + (discarded) int clear reg=
. */
> > @@ -464,7 +454,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler=
(int irq, void *p)
> >       else
> >               dev_err(&data->client->dev,
> >                       "Trigger consumer can't read from sensor.\n");
> > -     pf->timestamp =3D 0;
> >
> >       iio_trigger_notify_done(indio_dev->trig);
> >
> > @@ -867,8 +856,6 @@ static int rpr0521_init(struct rpr0521_data *data)
> >               return ret;
> >  #endif
> >
> > -     data->irq_timestamp =3D 0;
> > -
> >       return 0;
> >  }
> >
> > @@ -984,6 +971,9 @@ static int rpr0521_probe(struct i2c_client *client)
> >                       goto err_pm_disable;
> >               }
> >               data->drdy_trigger0->ops =3D &rpr0521_trigger_ops;
> > +             data->drdy_trigger0->early_timestamp =3D true;
> > +             data->drdy_trigger0->trig_type =3D IIO_TRIG_TYPE_POLL_NES=
TED;
> > +
> >               indio_dev->available_scan_masks =3D rpr0521_available_sca=
n_masks;
> >               iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
> >
> > @@ -1011,10 +1001,10 @@ static int rpr0521_probe(struct i2c_client *cli=
ent)
> >                */
> >
> >               /* Trigger consumer setup */
> > -             ret =3D devm_iio_triggered_buffer_setup(indio_dev->dev.pa=
rent,
> > +             ret =3D devm_iio_triggered_buffer_setup_new(indio_dev->de=
v.parent,
> >                       indio_dev,
> > -                     iio_pollfunc_store_time,
> >                       rpr0521_trigger_consumer_handler,
> > +                     true,
> >                       &rpr0521_buffer_setup_ops);
> >               if (ret < 0) {
> >                       dev_err(&client->dev, "iio triggered buffer setup=
 failed\n");
> >
>

