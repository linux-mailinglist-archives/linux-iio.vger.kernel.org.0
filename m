Return-Path: <linux-iio+bounces-11463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AAC9B3193
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD58282DDE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EBD1DB95F;
	Mon, 28 Oct 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBxmVBIE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE538396;
	Mon, 28 Oct 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121705; cv=none; b=fIncyFq2vGXs5o7ztXmkVIvKJ85nMD6AuLtMEvKPsgVi2a2TCFxVNnfBktOCWQZIkvusZvE4E/Ugfq2WaqcC4o5+eEMt1ch9Oo9+Kw3kvPOOTpFr6wdApZA0za/9GguqgwTA5dNqcnGZLcWTua+Nd47DfzTvIkQ041QRTWGq964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121705; c=relaxed/simple;
	bh=7TuPc3feWSvvQhQIz+bxMMlQTvI0FsbZ2ScG8u6EvtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugn5Ejn6SQbe15xOE6liNLmBP2wWSBybwFKxqqYl9u3ey9/FClWTJVHPBug4x2rQ9LKPFUBAMIj1gTw7dRAD8hV01GqlFpbqB+t45kVzwwjDcFOSXLCMKdvDXvYtIYix15ldzKcxpSASlAYNRFCJUTm5pAssP9ua3BfaEl4upgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBxmVBIE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so3053508f8f.0;
        Mon, 28 Oct 2024 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730121702; x=1730726502; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BG3wkrWSDrRhF05VtR0jwHgzIBr9FFDY8I+sNxfXSRM=;
        b=fBxmVBIEhd3daO2x+Y81QlDxI+/wavNQXuLJg9NJ8ls8w/I0xXqNAF5kv5kTx0y3h2
         PzwjwB2WE/TUPYf3D0FKIjr5wjidmuznNkzaj4hRFXF5+Kw3udo1lmUw23KMXZtpiN9c
         RzgX6w8YvLsH+GtEiyUlGcmSouI55Eb2LXfhicrJLnW/7949nuh5LBAdOsz7x2tWEN9g
         u1jOl0bwhgMxYbujmOJuOjg7QXX4+WhEVI3YR7XkmwVEQhXoo0omnMlRKsPA+jMZ1psL
         e6v8UiEj4wWeAVNJInmreFgap48L0M+Wbzj49ssM0I6JOMjOj0Vk4jB3op4GFMJrin2n
         LacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121702; x=1730726502;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BG3wkrWSDrRhF05VtR0jwHgzIBr9FFDY8I+sNxfXSRM=;
        b=bLPERYZWNB0eapeHHwhLyhr+Zo2HZn+vuLmK+KsDu5iYmryAWfl9u2q0WbBeDwRPCC
         hd1Xv7UL8Ut5E7B02pOOk5x9hE/d1Vy9kp1tm4OkoJTORH/Jq0nnqa5qhzkSeCw1TLgS
         BL+jhu0UyD33uMbGupmZTaFPbys2TcKWyUkSsCXurDTHgbBb4bjP8XX1YY27GE0bB+hZ
         eWy8jC5VXMUgoqQOhV6DNjcHErUBs8ZetkZuba9yolOG6a1+sRlxm/5tIy9QUrgKuLdd
         QC3GbkNSbtjMKR5li5QGy8wuia0VHEpLjZQaeC/bw64EfYUIwS+n+CDZLbsD7tKLpWbe
         zRPw==
X-Forwarded-Encrypted: i=1; AJvYcCUFv/gQCduph3CsjMrdYGsw9N6FmagJxuWNiGPMrvIjUAJp8mAUoThij2CVnV5KotAdA2X4ZXPwZImR@vger.kernel.org, AJvYcCUbPoJcV3dFbb3MssfuiRtvS5882KqeHantBZaVFo9G6u6eYE6pr1VJTaLTNbZY4S54rZl44a8Oby0cHh0/@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+nHXuQIVwj4/6PcSAPStbLDNr+Qv/aYX4oy2F6S/cwhVPZet
	U/yds6/tZhA8BX0cdZoMt2x2qtYIdjjGZhBy/tbDnTp1GQnNnd0m
X-Google-Smtp-Source: AGHT+IEhEFClPDRnkTjmfTmB9xrTyx/+XWTKThHdsI0L2SWzd7xQqvlFSqgTaQWb1mU8t9ZBhNOwqw==
X-Received: by 2002:adf:f18d:0:b0:37d:4821:fa0 with SMTP id ffacd0b85a97d-3806120b2c5mr6374380f8f.48.1730121701671;
        Mon, 28 Oct 2024 06:21:41 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b49d20sm9413128f8f.62.2024.10.28.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:21:41 -0700 (PDT)
Message-ID: <90be82063f25f703a9a813122e08eb156843d981.camel@gmail.com>
Subject: Re: [PATCH v8 8/8] iio: dac: adi-axi-dac: add registering of child
 fdt node
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	dlechner@baylibre.com
Date: Mon, 28 Oct 2024 14:21:40 +0100
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-8-74ca7dd60567@baylibre.com>
References: 
	<20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
	 <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-8-74ca7dd60567@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 11:49 +0200, Angelo Dureghello wrote:
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

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 56 ++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A01 file changed, 56 insertions(+)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 148e40a8ab2a..dc9f881bf9ce 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -29,6 +29,8 @@
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0
> +#include "ad3552r-hs.h"
> +
> =C2=A0/*
> =C2=A0 * Register definitions:
> =C2=A0 *=C2=A0=C2=A0 https://wiki.analog.com/resources/fpga/docs/axi_dac_=
ip#register_map
> @@ -97,6 +99,7 @@ struct axi_dac_info {
> =C2=A0	unsigned int version;
> =C2=A0	const struct iio_backend_info *backend_info;
> =C2=A0	bool has_dac_clk;
> +	bool has_child_nodes;
> =C2=A0};
> =C2=A0
> =C2=A0struct axi_dac_state {
> @@ -699,6 +702,36 @@ static int axi_dac_bus_reg_read(struct iio_backend *=
back, u32
> reg, u32 *val,
> =C2=A0	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
> =C2=A0}
> =C2=A0
> +static void axi_dac_child_remove(void *data)
> +{
> +	platform_device_unregister(data);
> +}
> +
> +static int axi_dac_create_platform_device(struct axi_dac_state *st,
> +					=C2=A0 struct fwnode_handle *child)
> +{
> +	struct ad3552r_hs_platform_data pdata =3D {
> +		.bus_reg_read =3D axi_dac_bus_reg_read,
> +		.bus_reg_write =3D axi_dac_bus_reg_write,
> +		.bus_sample_data_clock_hz =3D st->dac_clk_rate,
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
> +
> +	pdev =3D platform_device_register_full(&pi);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	return devm_add_action_or_reset(st->dev, axi_dac_child_remove, pdev);
> +}
> +
> =C2=A0static const struct iio_backend_ops axi_dac_generic_ops =3D {
> =C2=A0	.enable =3D axi_dac_enable,
> =C2=A0	.disable =3D axi_dac_disable,
> @@ -840,6 +873,28 @@ static int axi_dac_probe(struct platform_device *pde=
v)
> =C2=A0		return dev_err_probe(&pdev->dev, ret,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n");
> =C2=A0
> +	device_for_each_child_node_scoped(&pdev->dev, child) {
> +		int val;
> +
> +		if (!st->info->has_child_nodes)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "invalid fdt axi-dac compatible.");
> +
> +		/* Processing only reg 0 node */
> +		ret =3D fwnode_property_read_u32(child, "reg", &val);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +						"invalid reg property.");
> +		if (val !=3D 0)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +						"invalid node address.");
> +
> +		ret =3D axi_dac_create_platform_device(st, child);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +						"cannot create device.");
> +	}
> +
> =C2=A0	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> =C2=A0		 ADI_AXI_PCORE_VER_MAJOR(ver),
> =C2=A0		 ADI_AXI_PCORE_VER_MINOR(ver),
> @@ -857,6 +912,7 @@ static const struct axi_dac_info dac_ad3552r =3D {
> =C2=A0	.version =3D ADI_AXI_PCORE_VER(9, 1, 'b'),
> =C2=A0	.backend_info =3D &axi_ad3552r,
> =C2=A0	.has_dac_clk =3D true,
> +	.has_child_nodes =3D true,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct of_device_id axi_dac_of_match[] =3D {
>=20


