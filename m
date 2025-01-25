Return-Path: <linux-iio+bounces-14565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B3FA1C311
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55481165469
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE58207E18;
	Sat, 25 Jan 2025 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYD3h+lk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656C207E0F;
	Sat, 25 Jan 2025 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807521; cv=none; b=afciZFncbYjDdfg6INmiX/nXoJUauKdseRIFtJXSLnixrbI5lplys4AiOJVM33jJo1UvWjaS4a+enSDPE+1/QFYQDd1PU/XUIFj8hzw/CpS27uDwoHN2IYmDmY3NAAAuxctpK+bBL6ZkBEM4bXZmtQc582n8Fqt6NCxoXn/xboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807521; c=relaxed/simple;
	bh=DtuhUQo6cIIxFbScvGXGCdL8XY+9bxpDxjbA4P0hs2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MS5ARvEtjys2ovjSBixAIZf64Fi4Knywg973xtdlrwl4dL/Lp7nelos+KE7M1P+AKtGPwlHr3dqnm0Cfc7GRke+yhNp7ABw6YcPm18W8mFP118lDES+wpf7NjTHLasJOXvA+MDGfLKiffE9/HLJuuXiJ1DSQ3KQ0l0l0ps2BQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYD3h+lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911EDC4CED6;
	Sat, 25 Jan 2025 12:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737807520;
	bh=DtuhUQo6cIIxFbScvGXGCdL8XY+9bxpDxjbA4P0hs2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cYD3h+lkMGNnzm2VvMEKLWI+anIFSrxSQ7RBx+ZOOJXsShl7H/nUZJqoBauhxSXzU
	 Je3iHX2RhK1J9lB+CvirOwsPzXs7kIQmGu7KqNSVA88klIgAkuycVFLeo8ToRsZ1V1
	 fZdRXkCqs4C0T5VQ5AZvYDukgddGsgaV7j4MiJ5WU7/hB8D1qGiYfwLkBRMYx3RZfy
	 DIBWhJKQ148COISM891tm1GK4pGPcx8MrQWpzJljcIJG5dfCMZm6slB5Tyg+sa/aA6
	 Pl9Byz7ftZLewvj4v9gsNtMsaCB0ynxhoXFphvRLETZ+hiyK4k0IN2y1phL+lRCBuO
	 WV4t2aLZjAf/Q==
Date: Sat, 25 Jan 2025 12:18:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the
 Renesas RZ/G3S SoC
Message-ID: <20250125121826.6abbe7de@jic23-huawei>
In-Reply-To: <CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
	<20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com>
	<CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2025 11:29:19 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Claudiu,
>=20
> CC iio
>=20
> On Fri, Jan 3, 2025 at 5:38=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
> > the junction temperature. The temperature is reported through a dedicat=
ed
> > ADC channel. Add a driver for the Renesas RZ/G3S TSU.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> =20
>=20
> Thanks for your patch!
>=20
> > --- /dev/null
> > +++ b/drivers/thermal/renesas/rzg3s_thermal.c =20
>=20
> > +static int rzg3s_thermal_probe(struct platform_device *pdev)
> > +{
> > +       struct rzg3s_thermal_priv *priv;
> > +       struct device *dev =3D &pdev->dev;
> > +       int ret;
> > +
> > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(priv->base))
> > +               return PTR_ERR(priv->base);
> > +
> > +       priv->channel =3D devm_iio_channel_get(dev, "tsu"); =20
>=20
> Given there's only a single IIO channel, you could pass NULL instead
> of the name, and drop "io-channel-names" from the DT bindings.
> I don't know what's the IIO policy w.r.t. unnamed channels, though.

It's supported, so fine as long as no future additional names show up.
Will just fallback to index 0 I think.

Jonathan

>=20
> > +       if (IS_ERR(priv->channel))
> > +               return dev_err_probe(dev, PTR_ERR(priv->channel), "Fail=
ed to get IIO channel!\n");
> > +
> > +       priv->rstc =3D devm_reset_control_get_exclusive_deasserted(dev,=
 NULL);
> > +       if (IS_ERR(priv->rstc))
> > +               return dev_err_probe(dev, PTR_ERR(priv->rstc), "Failed =
to get reset!\n");
> > +
> > +       priv->dev =3D dev;
> > +       priv->mode =3D THERMAL_DEVICE_DISABLED;
> > +       platform_set_drvdata(pdev, priv);
> > +
> > +       pm_runtime_set_autosuspend_delay(dev, 300);
> > +       pm_runtime_use_autosuspend(dev);
> > +       pm_runtime_enable(dev);
> > +
> > +       ret =3D rzg3s_thermal_read_calib(priv);
> > +       if (ret) {
> > +               dev_err_probe(dev, ret, "Failed to read calibration dat=
a!\n");
> > +               goto rpm_disable;
> > +       }
> > +
> > +       priv->tz =3D thermal_of_zone_register(dev->of_node, 0, priv, &r=
zg3s_tz_of_ops);
> > +       if (IS_ERR(priv->tz)) {
> > +               dev_err_probe(dev, PTR_ERR(priv->tz), "Failed to regist=
er thermal zone!\n");
> > +               goto rpm_disable;
> > +       }
> > +
> > +       ret =3D thermal_add_hwmon_sysfs(priv->tz);
> > +       if (ret) {
> > +               dev_err_probe(dev, ret, "Failed to add hwmon sysfs!\n");
> > +               goto tz_unregister;
> > +       }
> > +
> > +       return 0;
> > +
> > +tz_unregister:
> > +       thermal_of_zone_unregister(priv->tz);
> > +rpm_disable:
> > +       pm_runtime_disable(dev);
> > +       pm_runtime_dont_use_autosuspend(dev);
> > +       return ret;
> > +} =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>=20


