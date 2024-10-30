Return-Path: <linux-iio+bounces-11615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0C9B6540
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 15:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401521C20BF8
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4461EE02F;
	Wed, 30 Oct 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OYA5CMtT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7DF1E8852
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297250; cv=none; b=H548mCmTXgB+tbF0k5eUw0kR/k2QObatrguc4QyJ3P8Bj1AnBneukdRB8BLkk/LXbs9i076cnaj3E2IZ9X4fApgZNccgOxYOeVtngPE8YbXJuC8W1e+lo1Wz3ZnrKeuoHPtn5O2Hgtrqj4ENAbuzA8p7Rdi0+RtLdofxIwkCtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297250; c=relaxed/simple;
	bh=tS9gZVMo0DMHq5x6JKzaSMafr+QNr2Vf29qkkZ3T8kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rx5UWH2uBjDIVvWqNW569q699RDy1Z/r8kMwCR6iDcTkgZYPcsMrkV0Y4jSlhHCDAKfkKm4UlWYXhImsg1WdtRP2RkPL23bxuVa5gjeNhpIoXInjLS5OjICg+KZbj+RxZlJgCNFyUaYrIxkzE7Qtiwu/33s3JXmcvKeFGrGcD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OYA5CMtT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9aa8895facso1101898166b.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730297244; x=1730902044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3cxArx0OrYLp8UXgKhkwUpA9R9yIJJmrM3fLHGs6bM=;
        b=OYA5CMtTkmRbhiTt/tLm6tDpmZU0Nx45YsxRIWuBoaFxFapQ3lYBIqJUz9uQJSjLhM
         NLVvz625IQ1rOcUdDiN1BGR3AZi5UoxPTkSjnMlqZkmP9SEGSw7hD1nwxKLD9a5V12yE
         fPZYXzvW2v1t8ThC6Qhv2d03CEROqbNLdJI73jxiY0aYnT9c4y002Sm9/61pNgwIZL7i
         V+7MMGU5/C0vjDfN2mEE9d69LVBUQyJcrOcxwzUuyqSEAmWIEI3WF1OrbnquRC9v/GsF
         Ci7etF3efD4Or/FWzhyIGxOUQZZgiPIDNWbfsssMONLp+5qJNW077KepAbwlLipFy4zW
         zqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297244; x=1730902044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3cxArx0OrYLp8UXgKhkwUpA9R9yIJJmrM3fLHGs6bM=;
        b=Kw76dY1HX18zp+s4Ba3LGXW4BIVV65UFkHMuHppoPaOLmteJwN6Sy/R351i2ajSl+1
         J7gUVKA9FXkw14D1FUwejkCkU8Qq6w2lGLedrxDfFfPmv/tzviNlaDltu22q2CWZWMYS
         VxWNX2Tz0n6PCCG3xwrTzrQDKnfX/yrIcWT7hmL7qCAJgtcBjIMscX7RTO4G279p0sdm
         IhY9Ra8IO3ztu7al1KIaiWuLobmqtvtWuiEnxI70Ka4zKy1xs6wN7wxvEEb40m7u2jtQ
         H6UOwjmsJDr9qrqnUy+kKO1id08w8xmisPzJCb1konQ8t3Bixu3ew0zRWysNrC8u+hII
         0V9w==
X-Forwarded-Encrypted: i=1; AJvYcCVsXj633MDXkIiupBm2lnlcpAiwcctLJ9ITZGjQT9GUwyGO93MYcUhFfdzNvhE2rjeYviokhzviprA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1RospplSjBeTmqQWm0rU/5+3G+V203hec7hILNI0nf9e0LGAU
	1R0e3gHN7bXcKmooDeDlKKurzDFjIJK1Dl8LDvFhgnpeVmvmn7cvhZWY9Hf3nt5Qgffa/UpDnEq
	N/NLkGBI5kL0nhM4FHB8vq9yEhyjdBr/G2P1gJw==
X-Google-Smtp-Source: AGHT+IGV3u/UuhQ7qYwfUMIB7Wlnz7uX1Jfu/zhOoV3oQPhJwcNFJod1TNlqJ635hL/TxLX6CXdp6RLsHBf2SusB9ns=
X-Received: by 2002:a17:907:7289:b0:a99:fa4e:ba97 with SMTP id
 a640c23a62f3a-a9de5ff9192mr1466264066b.39.1730297244074; Wed, 30 Oct 2024
 07:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
 <20241024-iio-fix-write-event-config-signature-v1-7-7d29e5a31b00@baylibre.com>
 <20241026135908.092c2736@jic23-huawei>
In-Reply-To: <20241026135908.092c2736@jic23-huawei>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 30 Oct 2024 15:07:02 +0100
Message-ID: <CAEHHSvb9syR27k2b9vqm464tTtQqJ+tRZ6A-qYswq4WLfwG2Mg@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: fix write_event_config signature
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Dan Robertson <dan@dlrobertson.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Matteo Martelli <matteomartelli3@gmail.com>, 
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>, 
	Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 26 oct. 2024 =C3=A0 15:00, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
>
> On Thu, 24 Oct 2024 11:11:29 +0200
> Julien Stephan <jstephan@baylibre.com> wrote:
>
> > write_event_config callback use an int for state, but it is actually a
> > boolean. iio_ev_state_store is actually using kstrtobool to check user
> > input, then gives the converted boolean value to write_event_config.
> >
> > Fix signature and update all iio drivers to use the new signature.
> >
> > This patch has been partially written using coccinelle with the
> > following script:
> >
> > $ cat iio-bool.cocci
> > // Options: --all-includes
> >
> > virtual patch
> >
> > @c1@
> > identifier iioinfo;
> > identifier wecfunc;
> > @@
> >  static const struct iio_info iioinfo =3D {
> >         ...,
> >         .write_event_config =3D
> > (
> >  wecfunc
> > |
> >  &wecfunc
> > ),
> >         ...,
> >  };
> >
> > @@
> > identifier c1.wecfunc;
> > identifier indio_dev, chan, type, dir, state;
> > @@
> >  int wecfunc(struct iio_dev *indio_dev, const struct iio_chan_spec *cha=
n, enum iio_event_type type, enum iio_event_direction dir,
> > -int
> > +bool
> >  state) {
> >   ...
> >  }
> >
> > make coccicheck MODE=3Dpatch COCCI=3Diio-bool.cocci M=3Ddrivers/iio
> >
> > Unfortunately, this script didn't match all files:
> > * all write_event_config callbacks using iio_device_claim_direct_scoped
> >   were not detected and not patched.
> > * all files that do not assign and declare the write_event_config
> >   callback in the same file.
> >
> > iio.h was also manually updated.
> >
> > The patch was build tested using allmodconfig config.
> >
> > cc: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
> Hi Julien,
>
> It's a nice cleanup, but the challenge of this sort of change is the odd =
ways
> various drivers use what you are changing.
>
> So ever single case needs close inspection.  I took a fairly broad look a=
t it and there
> is at least one case that I think is broken by the change :(
> + a bunch of others where the result needs tidying up to not end up confu=
sing.
>
>

Hi Jonathan,

I apologize for missing some cleanup in a few callbacks. Thank you for
pointing it out. I=E2=80=99ll send a v2 with these updates.

Cheers
Julien

> Jonathan
>
> > diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> > index 9f6f0a45efce7981736c3a8f005f4fef83f05cfd..5d2bda1a6a783c3f5bf6dfa=
6830bc80cc7055e01 100644
> > --- a/drivers/iio/accel/adxl380.c
> > +++ b/drivers/iio/accel/adxl380.c
> > @@ -1386,7 +1386,7 @@ static int adxl380_write_event_config(struct iio_=
dev *indio_dev,
> >                                     const struct iio_chan_spec *chan,
> >                                     enum iio_event_type type,
> >                                     enum iio_event_direction dir,
> > -                                   int state)
> > +                                   bool state)
> >  {
> >       struct adxl380_state *st =3D iio_priv(indio_dev);
> >       enum adxl380_axis axis;
>
>
>
>
> > diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> > index fa1799b0b0dff35ccd811c4abee3883249c184da..0656e35a1c4e5c1268a4bbf=
7011fd9282053dbbf 100644
> > --- a/drivers/iio/accel/mma9551.c
> > +++ b/drivers/iio/accel/mma9551.c
> > @@ -225,7 +225,7 @@ static int mma9551_write_event_config(struct iio_de=
v *indio_dev,
> >                                     const struct iio_chan_spec *chan,
> >                                     enum iio_event_type type,
> >                                     enum iio_event_direction dir,
> > -                                   int state)
> > +                                   bool state)
> >  {
> >       struct mma9551_data *data =3D iio_priv(indio_dev);
> >       int ret;
>
> Good to push down into functions called.
>
> > diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> > index 87c54e41f6ccd2f9311653b757b2d794df1dd5d4..36cbfcbba04d6920ba68beb=
d70d21bc3898a044d 100644
> > --- a/drivers/iio/accel/sca3000.c
> > +++ b/drivers/iio/accel/sca3000.c
> > @@ -1253,7 +1253,7 @@ static int sca3000_write_event_config(struct iio_=
dev *indio_dev,
> >                                     const struct iio_chan_spec *chan,
> >                                     enum iio_event_type type,
> >                                     enum iio_event_direction dir,
> > -                                   int state)
> > +                                   bool state)
> >  {
> >       struct sca3000_state *st =3D iio_priv(indio_dev);
> >       int ret;
> Good to push down the state into the functions called.
>
> > diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi=
323/bmi323_core.c
> > index 1e6c083ea5c1bbddb878f08cd4f4be725c0e319f..76a88e1ccc1d89988eb52d6=
b1be8da0f5005f0e6 100644
> > --- a/drivers/iio/imu/bmi323/bmi323_core.c
> > +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> > @@ -785,7 +785,7 @@ static const struct attribute_group bmi323_event_at=
tribute_group =3D {
> >  static int bmi323_write_event_config(struct iio_dev *indio_dev,
> >                                    const struct iio_chan_spec *chan,
> >                                    enum iio_event_type type,
> > -                                  enum iio_event_direction dir, int st=
ate)
> > +                                  enum iio_event_direction dir, bool s=
tate)
> >  {
> >       struct bmi323_data *data =3D iio_priv(indio_dev);
> >
> Mix of types used to store state. Would be good to chase the boolean thou=
gh. But no
> need to do that for this series.
>
>
>
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index fb4c6c39ff2e157593f02513cc8e01cd7eea9bdf..caefa15e559b8808051ff1c=
7f82c3f36c947933c 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1959,7 +1959,7 @@ static int
> >  st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> >                             const struct iio_chan_spec *chan,
> >                             enum iio_event_type type,
> > -                           enum iio_event_direction dir, int state)
> > +                           enum iio_event_direction dir, bool state)
> >  {
> >       struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> >       struct st_lsm6dsx_hw *hw =3D sensor->hw;
> state is stored in a mix of bool and int in this driver. Might be a nice =
to cleanup
> thing but not strictly part of what you are doing here.
>
> > diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.=
c
> > index 2e0170be077aef9aa194fab51afbb33aec02e513..a36cdad113f774ef8733eb1=
aaef0f87d5d2532f1 100644
> > --- a/drivers/iio/light/adux1020.c
> > +++ b/drivers/iio/light/adux1020.c
> > @@ -502,7 +502,8 @@ static int adux1020_write_raw(struct iio_dev *indio=
_dev,
> >  static int adux1020_write_event_config(struct iio_dev *indio_dev,
> >                                      const struct iio_chan_spec *chan,
> >                                      enum iio_event_type type,
> > -                                    enum iio_event_direction dir, int =
state)
> > +                                    enum iio_event_direction dir,
> > +                                    bool state)
>
> This one is a bug, because state is used as an intermediate for other stu=
ff.
> Bad code, but needs fixing before you can do this.
>
> >  {
> >       struct adux1020_data *data =3D iio_priv(indio_dev);
> >       int ret, mask;
> > diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.=
c
> > index 11f2ab4ca261813aff04b8c25d4595a531fb43cb..95861b2a5b2d94011d89495=
9289c5c4f06cc1efe 100644
> > --- a/drivers/iio/light/apds9300.c
> > +++ b/drivers/iio/light/apds9300.c
> > @@ -321,7 +321,7 @@ static int apds9300_read_interrupt_config(struct ii=
o_dev *indio_dev,
> >
> >  static int apds9300_write_interrupt_config(struct iio_dev *indio_dev,
> >               const struct iio_chan_spec *chan, enum iio_event_type typ=
e,
> > -             enum iio_event_direction dir, int state)
> > +             enum iio_event_direction dir, bool state)
> >  {
> >       struct apds9300_data *data =3D iio_priv(indio_dev);
> >       int ret;
> Tidying up the interrupt state to all be tracked with a bool in here woul=
d make this better, but
> not strictly related to what you have here.
>
> > diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.=
c
> > index 079e02be1005210ddd30b384ffa1ff7feeb098d7..8adc74040db2bddf93fbb77=
3e3519abcc726b9a6 100644
> > --- a/drivers/iio/light/apds9306.c
> > +++ b/drivers/iio/light/apds9306.c
> > @@ -1071,7 +1071,7 @@ static int apds9306_write_event_config(struct iio=
_dev *indio_dev,
> >                                      const struct iio_chan_spec *chan,
> >                                      enum iio_event_type type,
> >                                      enum iio_event_direction dir,
> > -                                    int state)
> > +                                    bool state)
> >  {
> >       struct apds9306_data *data =3D iio_priv(indio_dev);
> >       struct apds9306_regfields *rf =3D &data->rf;
> This has a rather silly regmap_field_write() related if statement you cou=
ld clean up but
> that's an optional extra.
>
> > diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.=
c
> > index 3a56eaae5a68f2891d061871c7013f0b5447bb47..a7f0cc99f236685900f89fb=
c48de3be0e9a40704 100644
> > --- a/drivers/iio/light/apds9960.c
> > +++ b/drivers/iio/light/apds9960.c
> > @@ -757,7 +757,7 @@ static int apds9960_write_event_config(struct iio_d=
ev *indio_dev,
> >                                      const struct iio_chan_spec *chan,
> >                                      enum iio_event_type type,
> >                                      enum iio_event_direction dir,
> > -                                    int state)
> > +                                    bool state)
> >  {
> >       struct apds9960_data *data =3D iio_priv(indio_dev);
> >       int ret;
> Should change type of pxs_int etc to bool.
>
>
>
> > diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> > index ff6b5d8b582b33eba60b769dff529caa00fb7244..b67c811cdf54af8de3dec3e=
1713a41312fb238d4 100644
> > --- a/drivers/iio/light/ltr390.c
> > +++ b/drivers/iio/light/ltr390.c
> > @@ -553,7 +553,7 @@ static int ltr390_write_event_config(struct iio_dev=
 *indio_dev,
> >                               const struct iio_chan_spec *chan,
> >                               enum iio_event_type type,
> >                               enum iio_event_direction dir,
> > -                             int state)
> > +                             bool state)
> >  {
> >       struct ltr390_data *data =3D iio_priv(indio_dev);
> >       int ret;
>
> See review of patch 2.
>
>
>
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index cab468a82b616a23394977da1d8822d29d8941d3..13086048ee5ffae77c26db8=
cbd3cb7002e1a72e2 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -1081,7 +1081,7 @@ static int tsl2772_write_interrupt_config(struct =
iio_dev *indio_dev,
> >                                         const struct iio_chan_spec *cha=
n,
> >                                         enum iio_event_type type,
> >                                         enum iio_event_direction dir,
> > -                                       int val)
> > +                                       bool val)
> >  {
> >       struct tsl2772_chip *chip =3D iio_priv(indio_dev);
> >
>
> val ? true : false
> in here should go.
>
> > diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx=
9023s.c
> > index d8fb34060d3db88a3ba5ecdc209b14be8e42e8b9..8c2f1cf062033dd8580f8f7=
5649543289fbf9fb7 100644
> > --- a/drivers/iio/proximity/hx9023s.c
> > +++ b/drivers/iio/proximity/hx9023s.c
> > @@ -874,7 +874,7 @@ static int hx9023s_write_event_config(struct iio_de=
v *indio_dev,
> >                                     const struct iio_chan_spec *chan,
> >                                     enum iio_event_type type,
> >                                     enum iio_event_direction dir,
> > -                                   int state)
> > +                                   bool state)
> >  {
> >       struct hx9023s_data *data =3D iio_priv(indio_dev);
> Has a !!state that should go.
> >
> > diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/ir=
sd200.c
> > index 6e96b764fed8b577d71c3146210679b0b61d4c38..eded45a778737a699f8b69a=
d86a9909594e04b32 100644
> > --- a/drivers/iio/proximity/irsd200.c
> > +++ b/drivers/iio/proximity/irsd200.c
> > @@ -648,7 +648,8 @@ static int irsd200_read_event_config(struct iio_dev=
 *indio_dev,
>
> This has a !!state that should go.
>
> >  static int irsd200_write_event_config(struct iio_dev *indio_dev,
> >                                     const struct iio_chan_spec *chan,
> >                                     enum iio_event_type type,
> > -                                   enum iio_event_direction dir, int s=
tate)
> > +                                   enum iio_event_direction dir,
> > +                                   bool state)
> >  {
> >       struct irsd200_data *data =3D iio_priv(indio_dev);
> >       unsigned int tmp;
> > diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9=
500.c
> > index 3f4eace05cfc6a4679fe82854dc059aa4a710d6d..e7da02c59b753158c30c747=
3bdeea8886a2977a3 100644
> > --- a/drivers/iio/proximity/sx9500.c
> > +++ b/drivers/iio/proximity/sx9500.c
> > @@ -540,7 +540,7 @@ static int sx9500_write_event_config(struct iio_dev=
 *indio_dev,
> >                                    const struct iio_chan_spec *chan,
> >                                    enum iio_event_type type,
> >                                    enum iio_event_direction dir,
> > -                                  int state)
> > +                                  bool state)
> >  {
> This one treats state as an integer.  We should change that before applyi=
ng this patch.
>
> >       struct sx9500_data *data =3D iio_priv(indio_dev);
> >       int ret;

