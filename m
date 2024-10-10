Return-Path: <linux-iio+bounces-10390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B3998831
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 15:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B214FB27D85
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A93C2E9;
	Thu, 10 Oct 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqpPwiEp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DFD1C1AD9;
	Thu, 10 Oct 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568034; cv=none; b=k00ppDaud20ISRHM9+RAVq88/CS9b/YXpmbfaEC+JDvz4BpHr5yeRIl0G/zXxnv7sxR8Bacd6ORLdp7OQrhqRQjV3PXH6A5gzOf54OdT7wCrSMdJm+Uk70IRU+eEI62y+WdQ0sOT5tRTiOgt9QQhKaD12cmVTrlWmyuSISapmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568034; c=relaxed/simple;
	bh=8h/6BRj1/qFeM41n0i3fXU8KQPXHbTSbHhc7eX0HScE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3WngrLmXH8kh2ZnsMHebDuA/Xfov9HL5anAi1w5mcO7ycBDVF37lCO1X1APMCqTtrp1qy4S/3YagYmdXzFuap3FRvZprczlPGXlBKNNrDK4FyKqv2nzMpiTP+g24GNWNDdIctYpUeB2rnsWzroeaAEoLgM5ZYPFk0gt1CgcBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqpPwiEp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d3ae4a048so589352f8f.3;
        Thu, 10 Oct 2024 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728568030; x=1729172830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PnnrcASqTD7cUC0GU+w1CNWKJYemmBY7IAu+q3FusQ8=;
        b=GqpPwiEpUKBd9Ql/zmGFN5Y9YwhMMXRU6sVkGiwgH0Hhv65NpuVOfKxDpvEkWfmjIi
         inIOkQWxgc2tgoHDhIs6ocWJWnpjiKs8tTyJb9RAn+hF4K1s13qxTcO7JH9/18dW9DLi
         2Yp6wRer0F2LH4CjG9nOLIiy3NZj5qih0NTXM3RuKn4W9xQn0KDZzIAgvQho6wU2ACS8
         nUflvJsg/NXAEZg6DMoyTGBly2Fjr0W7wSjfsu9BIrQNMpCEF++9Ottzfn8UDqK6679n
         FuXvIuuUxqeGrPtwcRQKXzpv1qoZbEuJmghGRvAKGayKHQswVkb7U1soTwII8UTotp9Y
         xNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568030; x=1729172830;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnnrcASqTD7cUC0GU+w1CNWKJYemmBY7IAu+q3FusQ8=;
        b=NElWBv3o4sCkuIktNgQWE+NJXLfTYNImZ0sdGfi7TCYw0H3fo/kWBzENfUsO4ycY8w
         E32v/wcVKBEMv4chcG1ajWTPPsRXNeczPSl68SUz0i2e6Da2WIU1JsYvXADoTA2BULIu
         JyVytEMw5u24zRQqvN3WKCMWhcwAKSYmci9AJIaUYcImj+m95WHmFeQwcJAAR7Ml5Ayl
         +svpbAQWsJui4Mk1npRqNNswzPBDZoGtXQ4XQy7sHsHSrkwRpJsuGl3uW9bMK9lFiOUN
         fC3vQoiL12cWLLlVgH8xcGVSoQlujyzq7NYT0LfJBtUovOpqZc8DQRRYB4JwJqH9J86n
         nQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF1LPUzW3e9oKNqh5g28+obiSK5oN738GYZ2vFqe7ssW2bOouD2eWjYY7JRynJKOm+pvn9ELmZzUS3@vger.kernel.org, AJvYcCVArZ8dm/DxUzjVKtzUF7Qj5cJuBZ7jGNjjtu/Xp/9cmNl63+dlEsod1IcvrGtjBgukPlFGBUvb3fYf@vger.kernel.org, AJvYcCXW81pD9gX2XIdwc2dId+vcScSLjxXwXp820m96YQ/4e5mv/cLHVP7o1uuWz5nLXrYff/Wl3NVfLo6WX4pS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//doo14j8wu9fLGd3P5JcxL/Ou4XEqbm7cPHsgLSXrPv8yPc2
	Y7nMuEm0sJKurKm7c3Lj06BHwuH5aEZD0aRKt0qU3quKuRIzFnFb
X-Google-Smtp-Source: AGHT+IElBNS3GT9WdEzTxZBoFtZBLLR5J8k3tDFpw4HvJRXU1Nz8AuUZuM363Sh01v9kgMfa5y4ojQ==
X-Received: by 2002:a5d:47ab:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-37d52821440mr249473f8f.22.1728568030217;
        Thu, 10 Oct 2024 06:47:10 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8a7fsm1615913f8f.15.2024.10.10.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:47:09 -0700 (PDT)
Message-ID: <b2687edd2cf4d0bfcd070e87971778ea72a59074.camel@gmail.com>
Subject: Re: [PATCH v5 10/10] iio: dac: adi-axi-dac: add registering of
 child fdt node
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dletchner@baylibre.com,  Mark Brown
 <broonie@kernel.org>
Date: Thu, 10 Oct 2024 15:51:25 +0200
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-10-3d410944a63d@baylibre.com>
References: 
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	 <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-10-3d410944a63d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 17:43 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Change to obtain the fdt use case as reported in the
> adi,ad3552r.yaml file in this patchset.
>=20
> The DAC device is defined as a child node of the backend.
> Registering the child fdt node as a platform devices.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 61
> +++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 61 insertions(+)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index e43d0ecccb50..754c4061d0e3 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mod_devicetable.h>
> =C2=A0#include <linux/mutex.h>
> +#include <linux/platform_data/ad3552r-hs.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/property.h>
> =C2=A0#include <linux/regmap.h>
> @@ -108,6 +109,8 @@ struct axi_dac_info {
> =C2=A0struct axi_dac_state {
> =C2=A0	struct regmap *regmap;
> =C2=A0	struct device *dev;
> +	/* Target DAC platform device */
> +	struct platform_device *dac_pdev;
> =C2=A0	/*
> =C2=A0	 * lock to protect multiple accesses to the device registers and
> global
> =C2=A0	 * data/variables.
> @@ -750,6 +753,44 @@ static int axi_dac_bus_reg_read(struct iio_backend *=
back,
> u32 reg, u32 *val,
> =C2=A0	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
> =C2=A0}
> =C2=A0
> +static void axi_dac_child_remove(void *data)
> +{
> +	struct axi_dac_state *st =3D data;
> +
> +	platform_device_unregister(st->dac_pdev);
> +}
> +
> +static int axi_dac_create_platform_device(struct axi_dac_state *st,
> +					=C2=A0 struct fwnode_handle *child)
> +{
> +	struct ad3552r_hs_platform_data pdata =3D {
> +		.bus_reg_read =3D axi_dac_bus_reg_read,
> +		.bus_reg_write =3D axi_dac_bus_reg_write,
> +	};
> +	struct platform_device_info pi =3D {
> +		.parent =3D st->dev,
> +		.name =3D fwnode_get_name(child),
> +		.id =3D PLATFORM_DEVID_AUTO,
> +		.fwnode =3D child,
> +		.data =3D &pdata,
> +		.size_data =3D sizeof(pdata),
> +	};
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev =3D platform_device_register_full(&pi);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	st->dac_pdev =3D pdev;

Don't need to save it in the state struct. Pass it directly to
devm_add_action_or_reset()

> +
> +	ret =3D devm_add_action_or_reset(st->dev, axi_dac_child_remove, st);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return devm_add_action_or_reset();

> +}
> +
> =C2=A0static const struct iio_backend_ops axi_dac_generic_ops =3D {
> =C2=A0	.enable =3D axi_dac_enable,
> =C2=A0	.disable =3D axi_dac_disable,
> @@ -886,6 +927,26 @@ static int axi_dac_probe(struct platform_device *pde=
v)
> =C2=A0		return dev_err_probe(&pdev->dev, ret,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n");
> =C2=A0
> +	if (st->info->bus_controller) {

I guess for now all child nodes that the IP has are for this usecase so I w=
ould
just assume it and drop the bus_controller. Let's deal with something diffe=
rent
when the usecase for it pops up. In any case, the flag is only needed in th=
is
patch so it should only be introduced now.

> +		device_for_each_child_node_scoped(&pdev->dev, child) {
> +			int val;
> +
> +			/* Processing only reg 0 node */
> +			ret =3D fwnode_property_read_u32(child, "reg", &val);
> +			if (ret || val !=3D 0)
> +				continue;

The conditions are not really related so I would not mix them:
if (ret)
	return dev_err_probe(); // some logs might be helpful...
if (val > 0)
	return dev_err_probe();
> +
> +			ret =3D fwnode_property_read_u32(child, "io-backends",
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &val);
> +			if (ret)
> +				continue;

The above looks redundant...
> +
> +			ret =3D axi_dac_create_platform_device(st, child);
> +			if (ret)
> +				continue;

Should we really ignore all errors?
> +		}
> +	}
> +
> =C2=A0	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> =C2=A0		 ADI_AXI_PCORE_VER_MAJOR(ver),
> =C2=A0		 ADI_AXI_PCORE_VER_MINOR(ver),
>=20


