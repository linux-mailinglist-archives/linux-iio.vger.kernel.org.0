Return-Path: <linux-iio+bounces-26344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA08C7759B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 06:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7CA4360D2F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 05:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD12F8BD1;
	Fri, 21 Nov 2025 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZsk7Lyu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C52F7ACA;
	Fri, 21 Nov 2025 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702456; cv=none; b=dAVGlZ5QKHEHJpvvSFOtdjnLgg7uEwGXKiZBPB9sdtf5tBUqpl49iwIEv60rHyAaPPw9Rg4LMbaph01ljXCrdmHEwLyiuh0fLwMgbzDogzzG6sFc1eWFKVyIbb9UyMZ3VwY4fkWB0bas72v+xyDe3MyB6oHYuru9hw+fEP3n4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702456; c=relaxed/simple;
	bh=59fhQFZGoydaHxlMPuxXXLYxyde4wR0Kx8QXeefUfKI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=CjV35B+P7FvPwIJA5LM0vsTdTJTwO7kHvmixUfagHBN/sE/ChWnlgnpEcQInpNXXAIQTRJEu28OxYxVzEWImigVEsL/YrPmsxa26+o0/FvYdcQto1woJdGShuEtbMvRJfZ2bxhEAY+ByrloTht8MdCyB+OgM62RFol9YAk+vSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZsk7Lyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FE0C4CEFB;
	Fri, 21 Nov 2025 05:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763702456;
	bh=59fhQFZGoydaHxlMPuxXXLYxyde4wR0Kx8QXeefUfKI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rZsk7LyuN+Z0DDtMKnmRZDSu1SvHU56yTM8dagFD3IWv8IdbovcyvKGUedcxwiw1O
	 gyEfO8JoIwk7kGttMi27uuyiJEfLMsFjtnkjtty2ZYsDXiLkM91VirYiyh21ImzV47
	 r2jbOpI8NmVwHfIo1luC8gnFQ87AEdipjIZz3ovtOXpTd52R6N900IhlQtmxRDBbPm
	 oYtoGJQdCQHAHvroLRVRp5sye0CDBUGsMCH/GWjykfnYptVf6pF88JDfmwcq/s1PmA
	 1SMm3smBej+qLwc2Ur8nENCark02bRSTN2dpQNldW5wzWg3aNGUshhvCpRjvpEqbE7
	 C3XTogMZYshpA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251114120908.6502-3-antoniu.miclaus@analog.com>
References: <20251114120908.6502-1-antoniu.miclaus@analog.com> <20251114120908.6502-3-antoniu.miclaus@analog.com>
Subject: Re: [PATCH 2/2] iio: frequency: adf4377: add clk provider support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
Date: Thu, 20 Nov 2025 19:13:54 -0800
Message-ID: <176369483456.11952.769972703298837189@localhost.localdomain>
User-Agent: alot/0.11

Quoting Antoniu Miclaus (2025-11-14 04:09:08)
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4=
377.c
> index 08833b7035e4..08dc2110cf8c 100644
> --- a/drivers/iio/frequency/adf4377.c
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -929,6 +935,120 @@ static int adf4377_freq_change(struct notifier_bloc=
k *nb, unsigned long action,
>         return NOTIFY_OK;
>  }
> =20
> +static void adf4377_clk_del_provider(void *data)
> +{
> +       struct adf4377_state *st =3D data;
> +
> +       of_clk_del_provider(st->spi->dev.of_node);
> +}
> +
> +
> +static int adf4377_clk_is_enabled(struct clk_hw *hw)
> +{
> +       struct adf4377_state *st =3D to_adf4377_state(hw);
> +       unsigned int readval;
> +       int ret;
> +
> +       ret =3D regmap_read(st->regmap, 0x1a, &readval);
> +       if (ret)
> +               return ret;
> +
> +       return !(readval & (ADF4377_001A_PD_CLKOUT1_MSK | ADF4377_001A_PD=
_CLKOUT2_MSK));
> +}
> +
> +static const struct clk_ops adf4377_clk_ops =3D {
> +       .recalc_rate =3D adf4377_clk_recalc_rate,
> +       .set_rate =3D adf4377_clk_set_rate,
> +       .prepare =3D adf4377_clk_prepare,
> +       .unprepare =3D adf4377_clk_unprepare,
> +       .is_enabled =3D adf4377_clk_is_enabled,

In theory .is_enabled shouldn't sleep to match the contract of
.enable/.disable. Probably should change this to .is_prepared?

> +};
> +
> +static int adf4377_clk_register(struct adf4377_state *st)
> +{
> +       struct spi_device *spi =3D st->spi;
> +       struct clk_init_data init;
> +       struct clk *clk;
> +       const char *parent_name;
> +       int ret;
> +
> +       if (!device_property_present(&spi->dev, "#clock-cells"))
> +               return 0;
> +
> +       if (device_property_read_string(&spi->dev, "clock-output-names", =
&init.name)) {
> +               init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-c=
lk",
> +                                          fwnode_get_name(dev_fwnode(&sp=
i->dev)));
> +               if (!init.name)
> +                       return -ENOMEM;
> +       }
> +
> +       parent_name =3D of_clk_get_parent_name(spi->dev.of_node, 0);
> +       if (!parent_name)
> +               return -EINVAL;
> +
> +       init.ops =3D &adf4377_clk_ops;
> +       init.parent_names =3D &parent_name;

We should be able to use clk_parent_data here instead of
of_clk_get_parent_name(). It will require setting the proper DT
node/device when registering the clk but it looks like you're doing that
already.

> +       init.num_parents =3D 1;
> +       init.flags =3D CLK_SET_RATE_PARENT;
> +
> +       st->hw.init =3D &init;
> +       clk =3D devm_clk_register(&spi->dev, &st->hw);

Please use devm_clk_hw_register()

> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       st->clk =3D clk;
> +
> +       ret =3D of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_g=
et, clk);

Please add a clk_hw provider. A clk provider isn't typically a clk
consumer of the clk it provides. I think we have devm for that too?

> +       if (ret)
> +               return ret;
> +
> +       st->clkout =3D clk;
> +
> +       return devm_add_action_or_reset(&spi->dev, adf4377_clk_del_provid=
er, st);
> +}
> +
>  static const struct adf4377_chip_info adf4377_chip_info =3D {
>         .name =3D "adf4377",
>         .has_gpio_enclk2 =3D true,

