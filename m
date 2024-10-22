Return-Path: <linux-iio+bounces-10920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC469AA193
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3C61C21075
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF519D06D;
	Tue, 22 Oct 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyygpwv1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796719CC21;
	Tue, 22 Oct 2024 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598310; cv=none; b=Zc7aeeUjW/ZhXih0zMbW7aXudBDHNTr1F7IGsrpgHagkHyfmbq7RwgHXiEalzMSNxrrLMgy2TW6XvcKIDt0zbOzKTiytCnPs/YVbsn9axuby4U1wJh+CHuW/kxQ1tanNDHOgKK9Z5HcfE9YpERWoOLBT3ElU55SKeyxkIBptcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598310; c=relaxed/simple;
	bh=BTDt6qlSaNzWRwuddcIgmNzyQuQyr8njKeq88csMu80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClKzQarUVc9d2RqlQ4TfTTm7nMt8tzNH02EtvWRT30QtL+Qx5WZ1zAI2JK9PXjjUIuhkGc5a/IbWK0D6+8FM/tZEy5ARNT6EgVWlLCYDHWVs9U2BwceYwQ1fLPMVx9GQpNGeRSCeZB83dcD3kBSpcH/VBguUhxBfQE4Piqtt280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyygpwv1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso4390197f8f.3;
        Tue, 22 Oct 2024 04:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729598307; x=1730203107; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WxrSMO536EXZGmOr3kpv23n7knkK3n2HcDHnFXznw88=;
        b=Wyygpwv1TM48KTsWDhzGRuFWSXYWHhg2Dz2eaaxVWbV728uph/q+6vMmC/Dz7Oyvys
         3rKhDpthISnoXTDuEDOe+ByUJ9XoMG5IrpGxe93gEtXFPODSMZ/PnWChtEEuc5LttGiw
         OjtDcMFpvp1r2sNSFdb7et2tyyvRI6X7cJTYLUhoB90VugEcc2gk7YQKC1GJSI2kM5DI
         mF7EAUFsnGcjctQlRfcCi/W4WwxfIpf74t/LKk+MS3M0r1+MRu7vKpRpp31+SGjWqAA/
         TbuiVqUaCGE5PI9O5TjkI+STvWi7+HJb0CFQicZqcEwBZzm4D4gzqoNOfHic1BlX7Ugw
         aKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729598307; x=1730203107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxrSMO536EXZGmOr3kpv23n7knkK3n2HcDHnFXznw88=;
        b=PCnW8TYwyx5OciUXWdZnabtLZ2c5IIGuvDbZjOQrzTV8HQQIfSsB6DzXC/KclKfJuj
         HfMsM9Q3rTwCqqrqfuZF/Pd25TiVPSkVpjwAtCVN+WcKgUItoZZxX/GBVQprkhE/5Cvl
         gYbYoyY5ibJ544QbsOeSo1PLhkVPPJj2vgYqqpoBgo4nk6PFrURVeChRtgyQQvZ77jux
         KdO3+Yq6Xm6RAQcrYnCf9L7k+q/E1M9mFKgoNS8vMBP01v9aQsSXWu4G8sJpUKB4R4Fq
         KbcwnY5CmwCyNJfslGDnUeLol4jE+6ijH0ZGoU6Er4NEjQXWXrojt6EQAp7jhZhIW4mi
         m85Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3Y2B8nSgRSo3fcyT77kctY6E4y3HbBv2A2FhCOvs1WSya1CZ/NqR1PFp313xbDN7CO4IbO8lVMozLXJD4@vger.kernel.org, AJvYcCXYpdIKNoid4IW7FbmB+kk3uh0SdYeOxNL3VlYQfPB/WtsIucTTFKd80bFvL9u7yw3OP/Chmfc135UN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8frtSSa4eq8z6HDlWkn/WoIN5iz+stVlIdc8HaAF44b4n8szh
	+ogHe2gSDwK+N9G4XTPJpniSgsdyvNHJvl+Z1OrdZbmKbuA81SaZ
X-Google-Smtp-Source: AGHT+IGFZtwZol0FwtPPFXHWKs+IKkc4ogJP3Moca9EW8gM4QQqFPt7Tq5HUvO5M231nm4Hgv5fAHg==
X-Received: by 2002:a5d:6b90:0:b0:37d:4e74:687 with SMTP id ffacd0b85a97d-37ebaa7a72dmr8894108f8f.41.1729598307045;
        Tue, 22 Oct 2024 04:58:27 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2d2bsm85376615e9.34.2024.10.22.04.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 04:58:26 -0700 (PDT)
Message-ID: <8cba678ee61eb221f8d5deb786a69b547371f11c.camel@gmail.com>
Subject: Re: [PATCH v7 8/8] iio: dac: adi-axi-dac: add registering of child
 fdt node
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown
	 <broonie@kernel.org>
Date: Tue, 22 Oct 2024 14:02:44 +0200
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-8-969694f53c5d@baylibre.com>
References: 
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-8-969694f53c5d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
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
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 53
> +++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 9d6809fe7a67..7f7ef3e219ba 100644
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
> @@ -723,6 +726,35 @@ static int axi_dac_bus_reg_read(struct iio_backend *=
back,
> u32 reg, u32 *val,
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
> @@ -865,6 +897,26 @@ static int axi_dac_probe(struct platform_device *pde=
v)
> =C2=A0		return dev_err_probe(&pdev->dev, ret,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n");
> =C2=A0
> +	if (st->info->has_child_nodes) {

I would prefer to not be silent on possible misconfigurations. IOW, moving =
the
check inside the loop and error out if (!st->info->has_child_nodes)

- Nuno S=C3=A1


