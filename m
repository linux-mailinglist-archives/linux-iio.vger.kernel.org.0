Return-Path: <linux-iio+bounces-9328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5152970853
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964EB1F21851
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6F1714D7;
	Sun,  8 Sep 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0XT9e3m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F68A52F6F;
	Sun,  8 Sep 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808307; cv=none; b=JxEuJ6NUkebnMJFAQNTtrgpWiaC0tpgm/R3nPWu659blEYw1WpLJlgrtMIGivd5WVdlUSoj5+k3kumnQFpstumx++u+iroCUDCq2r9mixKZ6uTKi7wt0iyTZ0AXghr4OywkxDF3U7SBNLKV4QLvSVUJfNE/bx6QJgD7iAXIqTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808307; c=relaxed/simple;
	bh=e1uBFaapULMIxGobskK7ztZK5fdksEFqE32XmKUFWIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYvgt5Qm8TLVhlspVLSHS7M8fOSMYFpjVxT638ThTtC5SZCCpi8i4QZWFzqvMU+FE5PbDo0UO8dm/amhcghg7D/IZioWH9QdJHVhjG01SOCkb60BWxNAN5xDfiP4FmW/HGg0MPhhxP4y5OT1XZinwbuWjgYKDfJG+V26owneFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0XT9e3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B3FC4CEC3;
	Sun,  8 Sep 2024 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725808306;
	bh=e1uBFaapULMIxGobskK7ztZK5fdksEFqE32XmKUFWIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F0XT9e3mDBpyQSRTnwIXnmD7FyrXIAyaZNscyj3Juf+tK/ro94iwF4BUGT7iA1uL/
	 v9zkdnmG9y54A2g+AMZyhXfVgHGnBWUjnG+SRhKQ1Q55Dezhv8DIfFumdu6rUWWVrY
	 2Z/e61++CNegTWlNhUQIaeKyMaF+IETGh4zYK5PCmvzikgJmlwZMhKY16gFVsukaiF
	 bvptpOVUcGqSnnd23YRzlpP9rYlCOXbhJufZMTltBJOPumb4wZGI0jvMD8lUYiALJt
	 OUqamlmKaY91sNQTEtY7yKl1bezui5ZysXALeqmASm8XeskDiQnGxzqkJQbd8xUlht
	 pZgJZjZD7dC3Q==
Date: Sun, 8 Sep 2024 16:11:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 3/9] iio: backend adi-axi-dac: extend features
Message-ID: <20240908161136.501a9c86@jic23-huawei>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-3-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-3-87d669674c00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Sep 2024 17:17:33 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Extend DAC backend with new features required for the AXI driver
> version for the ad3552r DAC. Mainly, a new compatible string has
> been added to support a DAC IP very similar to the generic DAC IP
> but with some customizations to work with the ad3552r.
>=20
> Then, a serie of generic functions has been added to match with
> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
A few comments below.

> ---
>  drivers/iio/dac/adi-axi-dac.c | 267 ++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 257 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 0cb00f3bec04..cc31e1dcd1df 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -44,11 +44,34 @@
>  #define   AXI_DAC_RSTN_MMCM_RSTN	BIT(1)
>  #define   AXI_DAC_RSTN_RSTN		BIT(0)
>  #define AXI_DAC_REG_CNTRL_1		0x0044
> +#define   AXI_DAC_EXT_SYNC_ARM		BIT(1)
> +#define   AXI_DAC_EXT_SYNC_DISARM	BIT(2)
>  #define   AXI_DAC_SYNC			BIT(0)
>  #define AXI_DAC_REG_CNTRL_2		0x0048
> -#define	  ADI_DAC_R1_MODE		BIT(4)
> +#define   AXI_DAC_SDR_DDR_N		BIT(16)
> +#define   AXI_DAC_SYMB_8B		BIT(14)
> +#define	  ADI_DAC_R1_MODE		BIT(5)

Bug?  Either was wrong before or after this change. I've no
idea which.


> +
> +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg,
> +				 unsigned int val, size_t data_size)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	switch (st->info->bus_type) {
> +	case AXI_DAC_BUS_TYPE_DDR_QSPI: {

...

> +
> +		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					  AXI_DAC_TRANSFER_DATA);
> +		}
> +		break;

Can't get here so drop the break;


> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg,
> +				unsigned int *val, size_t data_size)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	switch (st->info->bus_type) {
> +	case AXI_DAC_BUS_TYPE_DDR_QSPI: {
> +		int ret;
> +		u32 bval;
> +
> +		bval =3D 0;
> +		ret =3D axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0,
> +					    data_size);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS,
> +					       bval, bval !=3D AXI_DAC_BUSY,
> +					       10, 100);
> +		if (ret)
> +			return ret;
> +
> +		return regmap_read(st->regmap, AXI_DAC_CNTRL_DATA_RD, val);
> +		}
> +		break;
Can't get here.

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}


