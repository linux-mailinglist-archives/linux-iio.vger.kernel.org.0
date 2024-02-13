Return-Path: <linux-iio+bounces-2513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D04853499
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 16:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE81F24DB6
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE285DF2C;
	Tue, 13 Feb 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r0I02VdV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDD5DF1F
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838094; cv=none; b=uhjx8Ihppgxk2AMw2RheK5eX/Xvx6RWO4KbwvYrHCh7TCoO6gpQef6d8ntBPamTkQ/Y6co6nLbbCwNHkN40Xtao1v06bhGevIJrd1QKQ8c9c651LOTwjdzGkxbxLSsGwR9PlfrnpQW/RjCDrVaiTrZ7K56hRkwhPFVcaQ4eq+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838094; c=relaxed/simple;
	bh=KGR8cBhrRdf4y8P2TLGPhrpUyRSfOFO4v9dE/xVr0xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLfHa9Avi6lQu/3206u31+mYSvf8RrpLNMbQTUN+Dj3Lz/wUCmqAwOhVkqXt3nFpUo6os53RHsVbTqVToYlXHw5zIW/qnfH5azCoVAbFn6K/tZdnhe5oDtQzFi5V1XB3KF32g/wYToc5s5ge8R2kuJ9zip+WsDcUXBf/5hDNO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r0I02VdV; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d073b54359so66179071fa.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 07:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707838089; x=1708442889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ygk6/cDOkwUw/NJeAB8ipuDaGxiTdarNFVMbQnymP4=;
        b=r0I02VdVJHcrGah3/2p+9+atp023WtI8mtsb7Vi0gcMMfXaqIXp8KxLWphDAS6qzl5
         vcW8IiXx+3rNobxko+G7CYmrWzhENDaTHNN3sO+N8KW4JFTRHHHiLXGGhxVqoHppjang
         19Qgr3em1rRj+D1W1Bq7WhjXDt4HvLTbDYWNN/AmU6knad/x/TXeURwYkUShvWCCck2j
         TZoXFd1FLuWiQgA0phrk/OrFueiu6qurzRDQuF9WgDrq4RT+IFHz1VYVxl9K/XPN0iQC
         rsDkKfUMtXs3vyVJJtNpnw8lo9WQdALD7ChQPYyIWDfBPjDmgwU1lQJVY1dJPDhRnn/O
         DHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838089; x=1708442889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ygk6/cDOkwUw/NJeAB8ipuDaGxiTdarNFVMbQnymP4=;
        b=ZjvV9j1JEizp+EwLDUJ1CZFpwbOwT9V498pkSV4ILi22LQm4PKJ4VHpK4fslQgyGDp
         Lj4MG3b3ca5tFl/mjiLpCbjhWeu8x9Jf4dNn86UuG/A+dGDcBMZFaIeYCCOoMEQHpyj9
         bNxbMsSxDIKKxPchBdI0hid2vCWepREcfR3ADPa3dwEVZT0u/pCqIVYo++TS/Jr2z9OL
         P0gYNtLbS0nKD5a6SHRomV9HgkxXnHMJ/Gy+SvFguqMrpcVkDxXlz45QkU1GdnjWTM2v
         0VVcBmW6JJuiR5nKmYaSbjc1+kQUJqI47qlS1EBiu8yN0yL8DJOP0QYNdvmP3LaHLbgD
         eq1w==
X-Gm-Message-State: AOJu0YxqmXzdMokZAUE7yhFpRF++PEw/w5OfSMQBmBld0NzLnLRk8CAQ
	2grQsEhSOVvSbk2YpHyxARGzGKV7OH+917gSZfIg0Gg7Xl/AQXX1Sxha5Jx7wp/R3V32YY1snek
	atnzjciZ0CGxQuBgTrVD6cEnqMBY2WjJvLqWhRA==
X-Google-Smtp-Source: AGHT+IG01ij/IVy0hSByNzSy26iGI4SuB13+tw+QvBXX+3JkeX51jqeUndyf9KdenM1FhyxlUzQas9cWZ1padoUdZB8=
X-Received: by 2002:a2e:8755:0:b0:2d0:a6ef:651d with SMTP id
 q21-20020a2e8755000000b002d0a6ef651dmr6311505ljj.47.1707838089550; Tue, 13
 Feb 2024 07:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-5-a2373cd72d36@baylibre.com> <c06dfa1ecf88b07ef467ad7c08667d0cab400613.camel@gmail.com>
In-Reply-To: <c06dfa1ecf88b07ef467ad7c08667d0cab400613.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Feb 2024 09:27:58 -0600
Message-ID: <CAMknhBEU=iMzpE_P0KePL4cZZktBOGHRXaEox5a7XcVjXDT+Dg@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: adc: ad7380: use spi_optimize_message()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>, 
	David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Mon, 2024-02-12 at 17:26 -0600, David Lechner wrote:
> > This modifies the ad7380 ADC driver to use spi_optimize_message() to
> > optimize the SPI message for the buffered read operation. Since buffere=
d
> > reads reuse the same SPI message for each read, this can improve
> > performance by reducing the overhead of setting up some parts the SPI
> > message in each spi_sync() call.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7380.c | 52 ++++++++++++++++++++++++++++++++++++++++=
+------
> > -
> >  1 file changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > index abd746aef868..5c5d2642a474 100644
> > --- a/drivers/iio/adc/ad7380.c
> > +++ b/drivers/iio/adc/ad7380.c
> > @@ -133,6 +133,7 @@ struct ad7380_state {
> >       struct spi_device *spi;
> >       struct regulator *vref;
> >       struct regmap *regmap;
> > +     struct spi_message *msg;
> >       /*
> >        * DMA (thus cache coherency maintenance) requires the
> >        * transfer buffers to live in their own cache lines.
> > @@ -231,19 +232,55 @@ static int ad7380_debugfs_reg_access(struct iio_d=
ev
> > *indio_dev, u32 reg,
> >       return ret;
> >  }
> >
> > +static int ad7380_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +     struct ad7380_state *st =3D iio_priv(indio_dev);
> > +     struct spi_transfer *xfer;
> > +     int ret;
> > +
> > +     st->msg =3D spi_message_alloc(1, GFP_KERNEL);
> > +     if (!st->msg)
> > +             return -ENOMEM;
> > +
> > +     xfer =3D list_first_entry(&st->msg->transfers, struct spi_transfe=
r,
> > +                             transfer_list);
> > +
> > +     xfer->bits_per_word =3D st->chip_info->channels[0].scan_type.real=
bits;
> > +     xfer->len =3D 4;
> > +     xfer->rx_buf =3D st->scan_data.raw;
> > +
> > +     ret =3D spi_optimize_message(st->spi, st->msg);
> > +     if (ret) {
> > +             spi_message_free(st->msg);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ad7380_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +     struct ad7380_state *st =3D iio_priv(indio_dev);
> > +
> > +     spi_unoptimize_message(st->msg);
> > +     spi_message_free(st->msg);
> > +
> > +     return 0;
> > +}
> > +
>
> Not such a big deal but unless I'm missing something we could have the
> spi_message (+ the transfer) statically allocated in struct ad7380_state =
and do
> the optimize only once at probe (naturally with proper devm action for
> unoptimize). Then we would not need to this for every buffer enable + dis=
able. I
> know in terms of performance it won't matter but it would be less code I =
guess.
>
> Am I missing something?

No, your understanding is correct for the current state of everything
in this series. So, we could do as you suggest, but I have a feeling
that future additions to this driver might require that it gets
changed back this way eventually.

