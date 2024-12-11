Return-Path: <linux-iio+bounces-13343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4D9ED667
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96206165994
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E6025949D;
	Wed, 11 Dec 2024 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnSMQeE2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B7259483;
	Wed, 11 Dec 2024 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944811; cv=none; b=YvN7wJ1AqUBGLGZPqaUPurnuZuulKiO6+v8mzdvjO3HLVhhymKkPey9rvB2oMLAyaOY6dsQNAZmjnm8a7zTWdTzqjsljfKbT72PoF43kpLcv8fhc20KiW9UycRPiOaJTBIxYJtP+2DAcMMyL2pLD6URMC6Z9MljDpsgFMVNfuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944811; c=relaxed/simple;
	bh=p/Xx8QnAWy25KqreG9RP47kRg5CpGfys4XG+Zt9wH1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkRHQOYbURZasQFozZn4Zh/rVRJEAZgW9Q+imVPAQeKeW/1IYGGk0tezmEtkKewzc5NYRxlxY86DTs6NjhZS1s/UO/3/+VoJcmiIxuA9yOl99AXrZobPYoGk6R3/gsCzrVQ8j13/1Mz7QzJFFQo1vfRWfzx0Y1jmkA/lDow7Il0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnSMQeE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A02FC4CED2;
	Wed, 11 Dec 2024 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733944811;
	bh=p/Xx8QnAWy25KqreG9RP47kRg5CpGfys4XG+Zt9wH1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GnSMQeE28iiBAoTlFlEkuubq7ZCxcwkuZVmI1nhrUExXDEBn0PGwm1yZ7bliKHOCG
	 7xAfbyR2w2kjdIWx53Uk6vdLc9I9doib4OamCQaFAPEYFOcv9PHKXJOtQHE/3oZoAG
	 RKXC1ehP4B2qWe8PhaZ9CcDnImHgRV7YRg/Jsg9ffAJ3LbSgMwYBcSY2lT/YVU3tel
	 MZ0H3j4F3l0RdnvmDwdYcvdHPUiro7y3gJpILC7Fds6QkZRCTFjfj+EnTbjjyhmlYG
	 4ajGraJy6ETiPGx5ZSCnlz3cfqWRe2OD09r4WE4DbTMD7j/q61txCgXTxsXso5GWUr
	 pvemXYzevXmMQ==
Date: Wed, 11 Dec 2024 19:19:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
 magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 11/15] iio: adc: rzg2l_adc: Add suspend/resume
 support
Message-ID: <20241211191959.3bd377d9@jic23-huawei>
In-Reply-To: <CA+V-a8vHovd7L2bcY61n_Ox_hKvTvhUZMZPKgHFtd5DHQeZNMw@mail.gmail.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
	<20241206111337.726244-12-claudiu.beznea.uj@bp.renesas.com>
	<CA+V-a8vHovd7L2bcY61n_Ox_hKvTvhUZMZPKgHFtd5DHQeZNMw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Dec 2024 21:35:50 +0000
"Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:

> On Fri, Dec 6, 2024 at 11:16=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev=
> wrote:
> >
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The Renesas RZ/G3S SoC features a power-saving mode where power to most=
 of
> > the SoC components is turned off, including the ADC IP.
> >
> > Suspend/resume support has been added to the rzg2l_adc driver to restore
> > functionality after resuming from this power-saving mode. During suspen=
d,
> > the ADC resets are asserted, and the ADC is powered down. On resume, the
> > ADC resets are de-asserted, the hardware is re-initialized, and the ADC
> > power is restored using the runtime PM APIs.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >
> > Changes in v2:
> > - none
> >
> >  drivers/iio/adc/rzg2l_adc.c | 70 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > =20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks.  I've updated tags.

Jonathan

>=20
> Cheers,
> Prabhakar
>=20
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > index e8dbc5dfbea1..2a911269a358 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -88,6 +88,7 @@ struct rzg2l_adc {
> >         struct completion completion;
> >         struct mutex lock;
> >         u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> > +       bool was_rpm_active;
> >  };
> >
> >  /**
> > @@ -527,8 +528,77 @@ static int rzg2l_adc_pm_runtime_resume(struct devi=
ce *dev)
> >         return 0;
> >  }
> >
> > +static int rzg2l_adc_suspend(struct device *dev)
> > +{
> > +       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +       struct rzg2l_adc *adc =3D iio_priv(indio_dev);
> > +       struct reset_control_bulk_data resets[] =3D {
> > +               { .rstc =3D adc->presetn },
> > +               { .rstc =3D adc->adrstn },
> > +       };
> > +       int ret;
> > +
> > +       if (pm_runtime_suspended(dev)) {
> > +               adc->was_rpm_active =3D false;
> > +       } else {
> > +               ret =3D pm_runtime_force_suspend(dev);
> > +               if (ret)
> > +                       return ret;
> > +               adc->was_rpm_active =3D true;
> > +       }
> > +
> > +       ret =3D reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
> > +       if (ret)
> > +               goto rpm_restore;
> > +
> > +       return 0;
> > +
> > +rpm_restore:
> > +       if (adc->was_rpm_active)
> > +               pm_runtime_force_resume(dev);
> > +
> > +       return ret;
> > +}
> > +
> > +static int rzg2l_adc_resume(struct device *dev)
> > +{
> > +       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +       struct rzg2l_adc *adc =3D iio_priv(indio_dev);
> > +       struct reset_control_bulk_data resets[] =3D {
> > +               { .rstc =3D adc->adrstn },
> > +               { .rstc =3D adc->presetn },
> > +       };
> > +       int ret;
> > +
> > +       ret =3D reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (adc->was_rpm_active) {
> > +               ret =3D pm_runtime_force_resume(dev);
> > +               if (ret)
> > +                       goto resets_restore;
> > +       }
> > +
> > +       ret =3D rzg2l_adc_hw_init(dev, adc);
> > +       if (ret)
> > +               goto rpm_restore;
> > +
> > +       return 0;
> > +
> > +rpm_restore:
> > +       if (adc->was_rpm_active) {
> > +               pm_runtime_mark_last_busy(dev);
> > +               pm_runtime_put_autosuspend(dev);
> > +       }
> > +resets_restore:
> > +       reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
> > +       return ret;
> > +}
> > +
> >  static const struct dev_pm_ops rzg2l_adc_pm_ops =3D {
> >         RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runti=
me_resume, NULL)
> > +       SYSTEM_SLEEP_PM_OPS(rzg2l_adc_suspend, rzg2l_adc_resume)
> >  };
> >
> >  static struct platform_driver rzg2l_adc_driver =3D {
> > --
> > 2.39.2
> >
> > =20


