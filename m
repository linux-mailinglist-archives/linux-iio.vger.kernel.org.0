Return-Path: <linux-iio+bounces-10456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D483C99A3D3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 14:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBB2283ABA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55069216A3B;
	Fri, 11 Oct 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAMfP6F5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7635D209662;
	Fri, 11 Oct 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649626; cv=none; b=ocBD2f4JU7Zcy71tNgeydBJyFSR2l6+y4uQQhlROwCST0eJRoQEx80idvDTyAsBRwftgQ9C3xGGuj2WOVsVkUMxy6f4sH9lcXjX7hsxIVpeXPj+VHj2eemLrD0RqOuXZIh517L8h7ZcGoPNN1E5qS5L6WgnaoEZqJRxVTugOQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649626; c=relaxed/simple;
	bh=6GPPNQBDfqFw1nrENpvoZrZGhGeZ1bDGnK0Ri68Nz6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dbX4ZRfXFtR4q7+/5wOvjhhE4UpG7LJcc9MaKnlM87GXIrKwmrnTpvpVpwjjOLW+PrBKl9VDXIgtQVuyuinR46ZxZeDqo1ReQWcSXGe7I3guSqWsEm/PrHgRurYjpsAB8Q/ToUldjycRXGgUMqsjMkbC3Nzcn0QfnHnmeErJPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAMfP6F5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb806623eso16710135e9.2;
        Fri, 11 Oct 2024 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728649623; x=1729254423; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FizCtb5qWKRVpo+706XWFGZGPKWEwJd/P8uFS93BCZs=;
        b=OAMfP6F53VY3jUySEjB86xlc93fe40ETnbtqF7eclrcUVcmV1wPIqSjCHO4pj0ZVw6
         ZSL/IVYCpJb14ZAXGOOed1aHtQ9oFfSjaGBoGNh3bQDXk+FwElKumA3J+HyxsUDpESjy
         OZw0eGLP56XSIGrbPzmIzJtEzbJ+h7wjeQEik9wfp5gdLlJcHvw+AfrZiXS626WFePyO
         t6LD46yijFUDHH/f+zGhTZR9lELYjWWz7HKF7BEoy2X/ZUGFAnoUbX7QklDJuDZSzl+S
         y0BQhfsR4pJE26xDHMQDlN53TYjPJGR81jEsoG3cNRdNz9Xo31KsYvRm32Icm76uyT+8
         vreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728649623; x=1729254423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FizCtb5qWKRVpo+706XWFGZGPKWEwJd/P8uFS93BCZs=;
        b=GKE3e3xCU7ML8vJ0BoHmePw2cn0BYDkhZk9wtnKEynO04NVxok5O1JWULc44THUQvp
         g6piBCdP192+Tuxpmp+kx4ObEQRVKqcKkPewoIbhw7lh0F64G34LlvYTivOCPZpzQPlR
         BQP9y69v7cA7j5x6x/zlwhlSU6xDfWIshBZnJLxUeIL3gbgEgQwlfglChd/CDkbYwyGN
         7wItA4kBDs/WiNdhSq8/HWwFpToTzUUCaoTcszMTpnYlur4hl8p/ZwBOFUETQOZBCStn
         yKQnP98Yg87mcGQ7qcoSwJvNNpZhLa7EQblv+EwY9WHY+rNvFzRWhX5eMIoumcubxFeW
         gzAA==
X-Forwarded-Encrypted: i=1; AJvYcCUsNGqbIiGnZKt74GpzZ2UTyWzIaY4eSTnspmZJks1Up5ujKCBjBHLzsaOM0UXcqrrXpJ5m9H9gR89BSreT@vger.kernel.org, AJvYcCVtDYIPdkW5gbGnvAsUrvhWiqWbldY6HU/QJBl+BXX9v8+jvUoy4iCEZQY6MuUOiy5VnKffRWf+tEEK@vger.kernel.org, AJvYcCWwPg8W3vBJ8HsqCATU0cryRNwj8PVjEHkD+iwHBwylaX4UcVr5F5iiTCfPDAeirrH5WaYjs9/Vizfa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzl49IHMG6oPVO/DOnYbt/vYAliIDiJbnRx21lWZye2iGrTRB1
	CR89ElX32k5aG0KgFU6mqVRokaTRa+viYMASQlhy3DaSct4cXKMu
X-Google-Smtp-Source: AGHT+IGxL7m8CxkF/SsoOKG04+XptfKKRYh+VNgI3P2UxUFZYY5btHT9KXPTVj+te0Ua5scVjOznOw==
X-Received: by 2002:a05:600c:3589:b0:42c:b961:c902 with SMTP id 5b1f17b1804b1-4311dee688cmr18793605e9.12.1728649622616;
        Fri, 11 Oct 2024 05:27:02 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d445sm73501505e9.44.2024.10.11.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:27:02 -0700 (PDT)
Message-ID: <dd66a22d63b5b835b06604916e95b9a68cc26542.camel@gmail.com>
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
Date: Fri, 11 Oct 2024 14:31:17 +0200
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

also device_set_node() for this

- Nuno S=C3=A1



