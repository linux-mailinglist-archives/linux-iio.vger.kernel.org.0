Return-Path: <linux-iio+bounces-12531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF839D6987
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09237281BB7
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AA1BC49;
	Sat, 23 Nov 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2i9jlGp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A929CEB;
	Sat, 23 Nov 2024 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732374177; cv=none; b=QYQlNwyZ+l8wt2o66RXQJ0qRyhTFpuTQ8M50MXLiqU+o8+vFlAZc9/6f1iuZOY6GS8ePGOQDsdyx5F9DCDgBW1igbyRAGgVkHu4fkgpaaN8dMdKQO+vxl/uzpHrkT+d2q2nnYNIuQxjCmQAEux8MhWsqr0RIWRzGK/s7kfaPp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732374177; c=relaxed/simple;
	bh=P157WcS5ohYQAn6edzPl90GuO3alev9bLB/aKLVAonA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkCz/K7/bSyF+I7I9pcdKoeW/VoCfJCb1DgX8ayEuM1WmEoD21U1uL1dRpttwsXMeykghmcSkhqV9DqahuoSvgsUN4wTlTgdlWTxnbI7q3hFHEWqg2gYO7E7xzjiIN3YrpUHQTENa63cqbucr7WfEKZDPF0ajSEjv94pMPnarro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2i9jlGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D12C4CECD;
	Sat, 23 Nov 2024 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732374176;
	bh=P157WcS5ohYQAn6edzPl90GuO3alev9bLB/aKLVAonA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a2i9jlGpP4BY6M3sO6UvZGtTn48iTlYRswftLo6T216t08sIJe8jGSigKCHnMe0LP
	 /DCUGBZ4MPSDbU/CS9GdyV1H+/prcZ+6O/6jrvC1YGrL0bHHcSF/vONpdWnZPC4Z70
	 lQItjByFZ+PXk96ckzl6Nd2+ghTQQFeCZHJOKM/l0JKqmvnbnS2AHAk5gtOw77FGOk
	 qYGE+/yHOTQjHX523ydlcgUTBD3L2156BZP9Glret02gBGijXBajFBY9ms9c5YIQeE
	 ZcFlgRH4L8968l7+vzPNW5vlWIgf426zAhTWzlV+hiimoLcMnmEcZFEA8JX9peP0Mk
	 +hDck6GqSJF7Q==
Date: Sat, 23 Nov 2024 15:02:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: lars@metafoo.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tgamblin@baylibre.com, fabrice.gasnier@st.com,
 benjamin.gaignard@linaro.org, lee@kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
Message-ID: <20241123150247.718ee116@jic23-huawei>
In-Reply-To: <CANeGvZVxte61_FgrrYEt_oTRXXzCESrvq4q90xSWz4JqpMAtYg@mail.gmail.com>
References: <20241108200900.44727-1-jiashengjiangcool@gmail.com>
	<20241109133846.53d7ef06@jic23-huawei>
	<CANeGvZVxte61_FgrrYEt_oTRXXzCESrvq4q90xSWz4JqpMAtYg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 14:15:43 -0500
Jiasheng Jiang <jiashengjiangcool@gmail.com> wrote:

> On Sat, Nov 9, 2024 at 8:38=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Fri,  8 Nov 2024 20:09:00 +0000
> > Jiasheng Jiang <jiashengjiangcool@gmail.com> wrote:
> > =20
> > > Add check for the return value of clk_enable() in order to catch the
> > > potential exception.
> > >
> > > Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com> =20
> > Hi,
> >
> > In principle this is fine, but I'd rather we made use of guard()
> > / scoped_guard() rather than adding the explicit unlocks.
> >
> > If you do that as a precursor patch in appropriate places
> > in the driver then this will be a little cleaner.
> >
> > Note I'll not be taking this until next cycle now anyway.
> >
> > Jonathan
> > =20
> > > ---
> > > Changelog:
> > >
> > > v1 -> v2:
> > >
> > > 1. Remove unsuitable dev_err_probe().
> > > ---
> > >  drivers/iio/trigger/stm32-timer-trigger.c | 32 ++++++++++++++++++---=
--
> > >  1 file changed, 25 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/=
trigger/stm32-timer-trigger.c
> > > index 0684329956d9..e1e077122f73 100644
> > > --- a/drivers/iio/trigger/stm32-timer-trigger.c
> > > +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> > > @@ -119,7 +119,7 @@ static int stm32_timer_start(struct stm32_timer_t=
rigger *priv,
> > >                            unsigned int frequency)
> > >  {
> > >       unsigned long long prd, div;
> > > -     int prescaler =3D 0;
> > > +     int prescaler =3D 0, ret;
> > >       u32 ccer;
> > >
> > >       /* Period and prescaler values depends of clock rate */
> > > @@ -153,7 +153,11 @@ static int stm32_timer_start(struct stm32_timer_=
trigger *priv,
> > >       mutex_lock(&priv->lock);
> > >       if (!priv->enabled) {
> > >               priv->enabled =3D true;
> > > -             clk_enable(priv->clk);
> > > +             ret =3D clk_enable(priv->clk);
> > > +             if (ret) {
> > > +                     mutex_unlock(&priv->lock); =20
> >
> > as below guard() for when the mutex is locked is cleaner.
> > =20
> > > +                     return ret;
> > > +             }
> > >       }
> > >
> > >       regmap_write(priv->regmap, TIM_PSC, prescaler);
> > > @@ -307,7 +311,7 @@ static ssize_t stm32_tt_store_master_mode(struct =
device *dev,
> > >       struct stm32_timer_trigger *priv =3D dev_get_drvdata(dev);
> > >       struct iio_trigger *trig =3D to_iio_trigger(dev);
> > >       u32 mask, shift, master_mode_max;
> > > -     int i;
> > > +     int i, ret;
> > >
> > >       if (stm32_timer_is_trgo2_name(trig->name)) {
> > >               mask =3D TIM_CR2_MMS2;
> > > @@ -326,7 +330,11 @@ static ssize_t stm32_tt_store_master_mode(struct=
 device *dev,
> > >                       if (!priv->enabled) {
> > >                               /* Clock should be enabled first */
> > >                               priv->enabled =3D true;
> > > -                             clk_enable(priv->clk);
> > > +                             ret =3D clk_enable(priv->clk);
> > > +                             if (ret) {
> > > +                                     mutex_unlock(&priv->lock); =20
> > As below. Prefer use of guard() so we don't have to handle the unlock m=
anually. =20
> > > +                                     return ret;
> > > +                             }
> > >                       }
> > >                       regmap_update_bits(priv->regmap, TIM_CR2, mask,
> > >                                          i << shift);
> > > @@ -482,6 +490,7 @@ static int stm32_counter_write_raw(struct iio_dev=
 *indio_dev,
> > >                                  int val, int val2, long mask)
> > >  {
> > >       struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
> > > +     int ret;
> > >
> > >       switch (mask) {
> > >       case IIO_CHAN_INFO_RAW:
> > > @@ -496,7 +505,11 @@ static int stm32_counter_write_raw(struct iio_de=
v *indio_dev,
> > >               if (val) {
> > >                       if (!priv->enabled) {
> > >                               priv->enabled =3D true;
> > > -                             clk_enable(priv->clk);
> > > +                             ret =3D clk_enable(priv->clk);
> > > +                             if (ret) {
> > > +                                     mutex_unlock(&priv->lock); =20
> > Add include of cleanup.h and swithch the place where the mutex is locke=
d to
> > guard(mutex)(&priv->lock);
> > then remember to drop the explicit unlocks. =20
>=20
> I found that cleanup.h is already included.
>=20
> Moreover, since labels cannot be followed by declarations,
> I encountered a compilation error when using guard().
> Therefore, I switched to using scoped_guard().
Sometimes it is better to just add scope for blocks in switch statement
with=20
case XXX: {
	guard()
}
because then we don't get the extra indent a scoped_guard() requires.

I'll take a look at the result in this case though!

Jonathan

> > =20
> > > +                                     return ret;
> > > +                             }
> > >                       }
> > >                       regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_=
CEN);
> > >               } else {
> > > @@ -601,7 +614,7 @@ static int stm32_set_enable_mode(struct iio_dev *=
indio_dev,
> > >                                unsigned int mode)
> > >  {
> > >       struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
> > > -     int sms =3D stm32_enable_mode2sms(mode);
> > > +     int sms =3D stm32_enable_mode2sms(mode), ret;
> > >
> > >       if (sms < 0)
> > >               return sms;
> > > @@ -611,7 +624,12 @@ static int stm32_set_enable_mode(struct iio_dev =
*indio_dev,
> > >        */
> > >       mutex_lock(&priv->lock); =20
> >
> > Perhaps scoped_guard() is  appropriate here.
> > =20
> > >       if (sms =3D=3D 6 && !priv->enabled) {
> > > -             clk_enable(priv->clk);
> > > +             ret =3D clk_enable(priv->clk);
> > > +             if (ret) {
> > > +                     mutex_unlock(&priv->lock);
> > > +                     return ret;
> > > +             }
> > > +
> > >               priv->enabled =3D true;
> > >       }
> > >       mutex_unlock(&priv->lock); =20
> > =20
>=20
> Thanks, I will submit a v2 to simplify code with cleanup helpers.
>=20
> -Jiasheng


