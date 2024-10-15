Return-Path: <linux-iio+bounces-10594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8899DDF9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 08:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C68B21F16
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 06:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACA18871F;
	Tue, 15 Oct 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVYICq4e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0C178368;
	Tue, 15 Oct 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972711; cv=none; b=fdpXN/CjnQqAHD+M83G63/LsudPS5urLPdnY/Hdd06j0YhRNfRuwWZRrdRCf1W1H9gxd3tk/9JxhFRJAPlH0iFncWhMqdg/3Vj7kR+36ov0nH7vLJd+PG/AmN94a1Z6JuDo+kBAThz7P0JoMQ0POZTgtC6uBR6N93Y9bWv3/SCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972711; c=relaxed/simple;
	bh=hkeq3zwGZFJludYSl00w71Jj7zFOyMGvC/pKRV8aUFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mv9YOl5fu43FBkjSt1/s1A9Uxz1kyXSIQVe+iJyGBMQHI2dcsAh+xrCYemkbyRMOQ/9S6bZ5YhY4Nwruv8nPVOGwlT7EkNuJ8Rs969zD3TV+55aON8cuzf4iams8fhzl7aiobBvKpQJs8rX0lKSRSSTNjwxhpsvA6it/T7JDRns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVYICq4e; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43144f656f0so452805e9.0;
        Mon, 14 Oct 2024 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728972708; x=1729577508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0HUrqoBMuEVSoBDU5Uz3PBW7d42IZPXJjlta5F8EbHU=;
        b=AVYICq4ekBiwCQcadKJyV3ZmHWk0EzlPypVpJSO5jQ8Sqli+p8u9RTUHAXxdtvbi6S
         GokDxbjODixVIaNT8YIbgZZcsuncwPFkjxMXfHDru+l628oNg450zwqJRCerErUnBtUT
         7UpOyiJ1m3mHxSg/8Mahm3V7RerHWkWiKtRKct8ztj+fZFCSuguYfhXDrnOqz95VzJli
         3HoRnr219GVCObn6HTKyds6teIe+sNe91O6kGncb8SgPrUaVwwaNSWr64m7zIZ/AFHPd
         cu0XjNuE2OXEAojfosUcx8pCz7MveB7TbGuuALADWXfzX+1nTcxYLJsA5l9UL/GMVAKX
         fEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728972708; x=1729577508;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HUrqoBMuEVSoBDU5Uz3PBW7d42IZPXJjlta5F8EbHU=;
        b=MqgOSKQkkPUX4bVlM8TF2X576lYOigcdtsY88LN82nnAz7GGcHYmH8CkTrmG7cmjTZ
         9HLzYweXPOjqMhyidPSPFgE2lm3Y6A98fqunagl5fB8JXKBZwqgqbaI4NyaCaIO3eqli
         3d6C1HxU1wjBFpuTY9OZglqbgq5MJKL309LvOKDRG5WC6wnGEek8yh8NM9V1Ty6piyZl
         nUb3/xMhVhK2pyc0S5bXjFVfNOYlTRXiqxVmO4K9NjwwU7ZC5aR+ACa3DBR60c7wE/iv
         SdTxkVsSeRSwIoczywYg7I3EzYu+4OeiM7bTYawlJo9fQ2kADkLt+iJ8QTl/Hb/wxgxJ
         eWYA==
X-Forwarded-Encrypted: i=1; AJvYcCUDaJ6bMbpfFSu1udfO3ua5ngAsqPBPz9q65FNqFsamIGdXHIgfhLv20pMdJP8S/vPw+zW5FzkB1wsX@vger.kernel.org, AJvYcCVX7p8Awt0xeebavn67RoGJIePHDaFhWZFWj2WYjA8CYUrZKduhjnjZaZv+/7JVT0yX4Ig7k3IclWlK9177@vger.kernel.org
X-Gm-Message-State: AOJu0YxIt8CgZBpaLamkroaLuNicdOZmstMa+9EzfFvp/SjlTSF5JPug
	lDjzBZJqo8/7aXZnCYxfTSk9rzbmbtHNcGNr03OINbIPc92ThvOf
X-Google-Smtp-Source: AGHT+IFuAPQNG1GgrqmXlejvYbn6rQvKYC/U5bJYnuRs7Yntp6o5EUWi2wEP06/AD/kV58t0VvAinA==
X-Received: by 2002:adf:f806:0:b0:37d:5143:c695 with SMTP id ffacd0b85a97d-37d552d92b1mr9760420f8f.53.1728972707712;
        Mon, 14 Oct 2024 23:11:47 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87d48sm674852f8f.32.2024.10.14.23.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:11:47 -0700 (PDT)
Message-ID: <df1cdac2c954d9a95b9026a400e68697e177787f.camel@gmail.com>
Subject: Re: [PATCH v6 8/8] iio: dac: adi-axi-dac: add registering of child
 fdt node
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Tue, 15 Oct 2024 08:11:46 +0200
In-Reply-To: <022be235-f028-4b6e-9589-b0066df5d459@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-8-eeef0c1e0e56@baylibre.com>
	 <022be235-f028-4b6e-9589-b0066df5d459@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 16:16 -0500, David Lechner wrote:
> On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Change to obtain the fdt use case as reported in the
> > adi,ad3552r.yaml file in this patchset.
> >=20
> > The DAC device is defined as a child node of the backend.
> > Registering the child fdt node as a platform devices.
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 53 ++++++++++++++++++++++++++++++=
+++++++++++++
> > =C2=A01 file changed, 53 insertions(+)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index b887c6343f96..f85e3138d428 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -29,6 +29,8 @@
> > =C2=A0#include <linux/iio/buffer.h>
> > =C2=A0#include <linux/iio/iio.h>
> > =C2=A0
> > +#include "ad3552r-hs.h"
> > +
> > =C2=A0/*
> > =C2=A0 * Register definitions:
> > =C2=A0 *=C2=A0=C2=A0 https://wiki.analog.com/resources/fpga/docs/axi_da=
c_ip#register_map
> > @@ -738,6 +740,39 @@ static int axi_dac_bus_reg_read(struct iio_backend=
 *back,
> > u32 reg, u32 *val,
> > =C2=A0	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
> > =C2=A0}
> > =C2=A0
> > +static void axi_dac_child_remove(void *data)
> > +{
> > +	struct platform_device *pdev =3D data;
> > +
> > +	platform_device_unregister(pdev);

Just do platform_device_unregister(data)... Or call the argument pdev for b=
etter
readability...

> > +}
> > +
> > +static int axi_dac_create_platform_device(struct axi_dac_state *st,
> > +					=C2=A0 struct fwnode_handle *child)
> > +{
> > +	struct ad3552r_hs_platform_data pdata =3D {
> > +		.bus_reg_read =3D axi_dac_bus_reg_read,
> > +		.bus_reg_write =3D axi_dac_bus_reg_write,
> > +	};
> > +	struct platform_device_info pi =3D {
> > +		.parent =3D st->dev,
> > +		.name =3D fwnode_get_name(child),
> > +		.id =3D PLATFORM_DEVID_AUTO,
> > +		.fwnode =3D child,
> > +		.data =3D &pdata,
> > +		.size_data =3D sizeof(pdata),
> > +	};
> > +	struct platform_device *pdev;
> > +
> > +	pdev =3D platform_device_register_full(&pi);
> > +	if (IS_ERR(pdev))
> > +		return PTR_ERR(pdev);
> > +
> > +	device_set_node(&pdev->dev, child);
>=20
> Not sure why Nuno suggested adding device_set_node(). It is
> redundant since platform_device_register_full() already does
> the same thing.
>=20

Indeed... I realized that yesterday when (actually) looking at
platform_device_register_full(). You just beat me in replying to the email.=
 Sorry for
the noise...

> (And setting it after platform_device_register_full() would
> be too late anyway since drivers may have already probed.)

> > +
> > +	return devm_add_action_or_reset(st->dev, axi_dac_child_remove, pdev);
> > +}
> > +
> > =C2=A0static const struct iio_backend_ops axi_dac_generic_ops =3D {
> > =C2=A0	.enable =3D axi_dac_enable,
> > =C2=A0	.disable =3D axi_dac_disable,
> > @@ -874,6 +909,24 @@ static int axi_dac_probe(struct platform_device *p=
dev)
> > =C2=A0		return dev_err_probe(&pdev->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n");
> > =C2=A0
> > +	device_for_each_child_node_scoped(&pdev->dev, child) {
> > +		int val;
> > +

I'm starting to come around again if some sort of flag (bus_controller or a=
n explicit
has_child) wouldn't make sense (since you may need to re-spin another versi=
on). So we
could error out in case someone comes up with child nodes on a device that =
does not
support them.=C2=A0

Anyways, I'll leave this up to you and maybe others can also argue about th=
is...

> > +		/* Processing only reg 0 node */
> > +		ret =3D fwnode_property_read_u32(child, "reg", &val);
> > +		if (ret)
> > +			return dev_err_probe(&pdev->dev, ret,
> > +						"child node missing.");
>=20
> Shouldn't the error message say that there is a problem with the reg
> property? We already have a handle to the child node, so the child node
> isn't missing.

Makes sense... like "reg property missing" - something on those lines.

- Nuno S=C3=A1




