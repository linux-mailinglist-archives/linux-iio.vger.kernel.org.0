Return-Path: <linux-iio+bounces-4540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC9F8B3B5F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 17:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBE3B27387
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABB1DFFC;
	Fri, 26 Apr 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Osh/Kb/s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21B4685
	for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145206; cv=none; b=gy3HWh7bHRTE1FMsor/EW/xobFwIjGxPbA7SXTz8dYwRdFc8fZ4Zw2aaJuFvDgkiurarIJUB04MGOIswPyyYq+kKyPt4+RyjcMmquhKQCO1l3//0KBHKji1HejbrSdZVxsD5V7IOw2k4RTjIfkDGRnJYAK9NVWQVpj0OSGBIVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145206; c=relaxed/simple;
	bh=AVVZ5WrV0O90cPI1zVj+G1z5pclK2g+nTkMkPWRPIUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMmPQ6pbagGx95w5dJUs/EUzwZBYJDHBjF3ihkdtJkjPwnOt1dTv34AlsJyDQA0IZhJEdrBVCrs2OZS+NrGYztAkc+R0+qqG5as/j+j+H2Oe8gjmuvK/kavD+MmNeAGppx8YUKhQ3vgQSpHwS6dc/CN1/5exddBBq5sdYDQzaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Osh/Kb/s; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2def3637f88so19694701fa.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714145203; x=1714750003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbd496awCmr7HV9PAhWCpLFPL9uks2P0WpKxk3j3S2c=;
        b=Osh/Kb/sDUqFHAft7yYxdcP3ROoBfig7TwCiR5gQqrJBIJcqoQU6KBah0RqGPqE4ht
         7UwMZSbY1QiFUOULO1h17RhetS31VxY5DLWPH2rgcGjvBawlpc7jdrqsLQYNGzMmDqkg
         m9QJj9MkqHJjsL6b63CBiGg2OfoRFlhrn6c00NTTdPmKVwhpq4mN9Isq2Ns6JjfCSQn0
         j8+bh2UKW4rlGWVdwQYBOp9wXGuSGy9Ej7twzts+z4P8GfIFHWHoJPMalYx+rrIPWxMw
         d6iSGsvRAYt4wpqcODcPlsC6eYE+K1IGcOCenLH9VfKZLv0Wyhe3VsyOhJdr5YXiRVt5
         Vysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145203; x=1714750003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbd496awCmr7HV9PAhWCpLFPL9uks2P0WpKxk3j3S2c=;
        b=sGXfLnXv35vGzi1bYNQRGfgHDF7IJDBQNt+XXl3lXqe3Eu/qOoh1u7fqRQ66Xz5hbv
         7PfHntIkyueoeNDFCDjju4BYI/AV4wg1Qseqp2ATbID1ZeiGrFtTshiPEDib40EIVZmf
         mZLd9kfMBqaVv2KYNIX7PqGMulFk7sWVwMG7JONU7FbwU3Mc3rbbWgC7/A9Xa1+w/mpF
         OHt6MUpNxlCxpT3LTDw1SF2BoeXNs7bUUj4aO+tx7XaeeUg+c04MW4qKQw3miRC54WJA
         dtyWJDTz6kcwPP91PoPgRTaswM4yBbzML67tnxolPcSwhPpqmsoPfbe+L3oXVxq2RRXz
         9nBA==
X-Forwarded-Encrypted: i=1; AJvYcCWg2/6K6VOYBpqCJc/RpSsMqyrRbdqPPs/UUipzHD5uhsCncQJ1W7tGvxfAPp23wMABtaGVP6Pw1cibxnLU832P4V2zEADkz6r2
X-Gm-Message-State: AOJu0Yzv5OxxkfYulroDBwyd4QgU2VcYc/uZSp2bXL7goxWiuoxEo6Dz
	jWgKfZrdN8rKjxNAN/Q9Btmkhbq9cPoNUsUsbADEn1ZF8SuUDfSwSUmmi9/V2i4qfuVJmT7DAn7
	/rb0asglsf2TeV9yFIYfDQJLaDdByVog8iPXN+/rqGNzeIYGo
X-Google-Smtp-Source: AGHT+IH6bJsIpLONbn6Ung3Qp+BKBgv7mt2AD4Ou/ORighgXlV/9uin6jCJ7tuPKYhAsygqcEvDbEhvhpwLHHZkypR4=
X-Received: by 2002:a2e:7c0e:0:b0:2dc:f13f:8a96 with SMTP id
 x14-20020a2e7c0e000000b002dcf13f8a96mr1122749ljc.5.1714145202834; Fri, 26 Apr
 2024 08:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
 <2630ef8c8363b4fa772a2ff2c95cf115ad3c509d.camel@gmail.com>
In-Reply-To: <2630ef8c8363b4fa772a2ff2c95cf115ad3c509d.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 26 Apr 2024 10:26:31 -0500
Message-ID: <CAMknhBGQB4MC8ejEs_uLgb=iKehXkoetgHjZnCvCKQbuua5kfA@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: cleanup masklength usage
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:13=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Thu, 2024-04-25 at 10:03 -0500, David Lechner wrote:
> > While working on other patches I noticed that a few drivers are setting
> > the masklength field of struct iio_dev even though it is marked as
> > [INTERN]. It looks like maybe this was not always the case, but we can
> > safely clean it up now without breaking anything.
> >
> > ---
> > David Lechner (3):
> >       iio: adc: ad7266: don't set masklength
> >       iio: adc: mxs-lradc-adc: don't set masklength
> >       iio: buffer: initialize masklength accumulator to 0
> >
> >  drivers/iio/adc/ad7266.c          | 1 -
> >  drivers/iio/adc/mxs-lradc-adc.c   | 1 -
> >  drivers/iio/industrialio-buffer.c | 2 +-
> >  3 files changed, 1 insertion(+), 3 deletions(-)
> > ---
> > base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
> > change-id: 20240425-b4-iio-masklength-cleanup-86b632b19901
> >
>
> Hi David,
>
> Nice cleanup. The patches look good to me but there's one thing missing :=
). As you
> correctly noted, the field should be internal to the IIO core and drivers=
 should not
> touch it. Hence, you need to make sure not driver is using it so we can m=
ove it into
> struct iio_dev_opaque [1]. That's the place all the intern fields should,=
 eventually,
> end up.
>
> Now, quite some drivers in the trigger handler will read the masklength f=
or looping
> with for_each_set_bit(). Hence, the straight thing would be an helper to =
get it.
> Maybe there's a clever way...
>
> I know this is more work than what you had in mind but I think it should =
be fairly
> simple (hopefully) and since you started it :), maybe we can get the whol=
e thing done
> and remove another [INTERN] member from the iio_dev struct.
>
> [1]: https://elixir.bootlin.com/linux/latest/source/include/linux/iio/iio=
-opaque.h#L42
>
> - Nuno S=C3=A1

Sounds like fun. :-p

I will look into it.

