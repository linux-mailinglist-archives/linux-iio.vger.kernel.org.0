Return-Path: <linux-iio+bounces-25385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9273C02A91
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E1B3A62DF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F291342C81;
	Thu, 23 Oct 2025 17:08:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB325A33F;
	Thu, 23 Oct 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239318; cv=none; b=Jh9z/fniiNC3g/k41fWqrN2oW82LbUkh3KvrPjggA0YKyB9Oh2otglE7+9/TkNn+Atncz6PureBtYTzaRqrjeKfiSuqPHYYr1KuT0DP3EqXJ84Ol6uyN/z8fdLhN+LY/zOxOa5n4yypTq3f7om0cZuxqOr0CoHDC+l0P7Mb8m9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239318; c=relaxed/simple;
	bh=ItILAxRB6bnrfcBNKxZCG8bfo3smhQs3GfxTqQ51Frw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNIenzcsQRB5/U3bIWkDeVMY1t0VBzas0w827FTDWn095uK7bnjDNyS3WhZOQh46t/rsrOLMTirrJtlB+h07IqUyKMGcTyeJJiw9lMKzoCV4hlysjgpJrp20DJLsMf2AhKYhp8vnDdirjb2qbdL09W7bnzZLzjwPUeoHUUVNk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4csspX0h3Lz6M4hp;
	Fri, 24 Oct 2025 01:04:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E1474140279;
	Fri, 24 Oct 2025 01:08:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 18:08:33 +0100
Date: Thu, 23 Oct 2025 18:08:31 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
CC: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and
 similar devices
Message-ID: <20251023180831.000026ca@huawei.com>
In-Reply-To: <20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
	<20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 14:01:37 +0300
Nuno S=E1 <nuno.sa@analog.com> wrote:

> Add device tree binding documentation for the Analog Devices AD5446
> family of Digital-to-Analog Converters and compatible devices from
> Texas Instruments. There's both SPI and I2C interfaces and feature
> resolutions ranging from 8-bit to 16-bit.
>=20
> The binding covers 29 compatible devices including the AD5446 series,
> AD5600 series, AD5620/5640/5660 variants with different voltage ranges,
> and TI DAC081s101/DAC101s101/DAC121s101 devices.
>=20
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
Hi Nuno,

Thanks for filling in this missing doc.  I wonder what else is old
enough that we still don't have docs? Guess I should check when
I'm next bored enough (so that's not happening any time soon ;)

> ---
>  .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   8 ++
>  2 files changed, 146 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml b/=
Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> new file mode 100644
> index 000000000000..90fc8ca053fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5446 and similar DACs
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Nuno S=E1 <nuno.sa@analog.com>
> +
> +description: |

Trivial but don't need the | as hardly matters if these get formatted diffe=
rently.

> +  Digital to Analog Converter devices supporting both SPI and I2C interf=
aces.
> +  These devices feature a range of resolutions from 8-bit to 16-bit.

...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 940889b158eb..dae04c308975 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/regulator/ad5398.c
> =20
> +AD5456	DAC DRIVER
Tab seems odd here.=20

Hmm. For a lot of ADI drivers we have entries that would look like
ANALOG DEVICES INC AD5456 DAC DRIVER

Any reason for formatting it like this?

> +M:	Michael Hennerich <michael.hennerich@analog.com>
> +M:	Nuno S=E1 <nuno.sa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> +
>  AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>=20


