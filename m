Return-Path: <linux-iio+bounces-10922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63EE9AA223
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590CE2827D1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 12:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021C19D06E;
	Tue, 22 Oct 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKC6Ky+k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A70196DA2;
	Tue, 22 Oct 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600350; cv=none; b=Vre4FIlGGqi9ixgQoPaoDImDl7cY79IN8zAtOZvRdtLEMOQ83qblnpLolQgpqZt7ydCAwXC/YRPUkiBpKws3i+6EWzI8Z5s8kvaoZselJiRf8e09MxY8IM2t6c/etcQd2kDgjfd1hEGAWxb9Xtovf3QSoZ34RhZQ33VdMhoh6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600350; c=relaxed/simple;
	bh=k+jpDQnahPrkSggAQOSFvwgBzXb2YgGE8Ftt9blvxBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dvNRmJEAG2SFY8phs09rraRUQG49QbMt1GOh06V2bX4J3vHzaD173b2LH7JGuRaLXW48tlOPxZd8H8+MhAdkT/TyEjJBKf5GQSX98LaqG8y78ugpuyfSkvQNcwC/FOUNkoILrysR392ePY9OfBpPx63hZeMXlMJNENc0uz9TEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKC6Ky+k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso55826395e9.0;
        Tue, 22 Oct 2024 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729600347; x=1730205147; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y8fcMdOyAYaIN7KKTKRLuuBVSda70TZz4y7GMjXOwZ4=;
        b=RKC6Ky+k4Q1k1p/buYbKvSauwPQ8QotLvRTs1w3xw/iIZNrlYbGN5koal+wKDxF5k4
         554uPXjMAdc7SdAztpwCAs5oNAm/aHFJNnmCDEGc9SiTg8m3KcDjrm39cf4tw67j1ZiS
         hfK65OnM/mTJM+JMaTL5GP/motp7kohOBig1g7RjKs10ezAH/JcbYa1VUz2D1Iczr1gZ
         PfV3/cEGv1ACX1JmNgTyWiTbzpQyxS5XvMxJUhBU4CN0z2Efm9NmnquKGxNiylLd/VZq
         nfDMfhtKbsYBNhUP+wYKA1+5e0OskMSARCfUWV8CJmyk5LasEwIsFRhHFVfsfr6PkD4H
         aDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729600347; x=1730205147;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8fcMdOyAYaIN7KKTKRLuuBVSda70TZz4y7GMjXOwZ4=;
        b=IlI2D7hDDkfmddihJwlqP4s04Kd4npLcNC95oGdFqHkeKDjWFD6/acDWLGYd04prxR
         +VTpJRyyjwfZf/xaAu26vW0gLnlK7obMTRAtyEUBaT3vYy1qAaICUk9MDxsaCcJ9XnAx
         yiRzW8RrglbN0ArygPhHANoYQWzxClTTJHGfJX/N+akn5Eo5t0f7PsBcxsK6dd7UKbVE
         1tYUItG7xlRB0JP/GEzu25nI4dFCza3zgSb4Ml6tvg5N9dcTSBRlMLMfB8DIDcYsOVLK
         jMzLMUz+ENq2yn2edV7FJ2QipPBmcc5NyY/2MZrib0jMy4Nvn0886m9AEtPpw/blFczM
         tosQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYqQf0ozi8BADtrl4efqnD9/PQOtVcd8ThCjxD2+/nEClszKBCVA7frVD+cr2i/dkZZDXY6gc6gHn8j7G1@vger.kernel.org, AJvYcCWGJgzCPM0Hwu2YoUiiB/DH6tHianUDptzE2c0WdwzgL5+yArtB+o9uGkZUE+0dhQOL/36F/RjI59ZX@vger.kernel.org
X-Gm-Message-State: AOJu0YxABG9b077TRy2o/06RGxgsTJwpOZuUCrQcD/tlmCFiYKawUybH
	XdhcgZNnn8dSoCmZsmasmQocLyvM53NL5RAzXUHKv+oFaIB7X0j5
X-Google-Smtp-Source: AGHT+IFu6mJ+NIedCq7KY7T+JJZIHHd///LfaBCFsHxQeK94bdigpxIE15SuHqd00PZurZMvPp4wyQ==
X-Received: by 2002:a05:600c:1d99:b0:431:59ab:15cf with SMTP id 5b1f17b1804b1-431616595bemr106452735e9.19.1729600346965;
        Tue, 22 Oct 2024 05:32:26 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc401sm85709325e9.43.2024.10.22.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 05:32:26 -0700 (PDT)
Message-ID: <b1ac7d51280caf729d192ca871c26260fdf3697c.camel@gmail.com>
Subject: Re: [PATCH v7 4/8] iio: dac: adi-axi-dac: extend features
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
Date: Tue, 22 Oct 2024 14:36:44 +0200
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
References: 
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
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
> Extend AXI-DAC backend with new features required to interface
> to the ad3552r DAC. Mainly, a new compatible string is added to
> support the ad3552r-axi DAC IP, very similar to the generic DAC
> IP but with some customizations to work with the ad3552r.
>=20
> Then, a series of generic functions has been added to match with
> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Looks mostly good,

one minor thing that (I think) could be improved
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 269 +++++++++++++++++++++++++++++++=
++++++++--
> -
> =C2=A01 file changed, 255 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 04193a98616e..9d6809fe7a67 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -46,9 +46,28 @@
> =C2=A0#define AXI_DAC_CNTRL_1_REG			0x0044
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> =C2=A0#define AXI_DAC_CNTRL_2_REG			0x0048
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> =C2=A0#define=C2=A0=C2=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> +#define AXI_DAC_STATUS_1_REG			0x0054
> +#define AXI_DAC_STATUS_2_REG			0x0058
> =C2=A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> +#define AXI_DAC_UI_STATUS_REG			0x0088
> +#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)

...
=C2=A0
> =C2=A0static int axi_dac_probe(struct platform_device *pdev)
> =C2=A0{
> -	const unsigned int *expected_ver;
> =C2=A0	struct axi_dac_state *st;
> =C2=A0	void __iomem *base;
> =C2=A0	unsigned int ver;
> @@ -566,14 +780,29 @@ static int axi_dac_probe(struct platform_device *pd=
ev)
> =C2=A0	if (!st)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	expected_ver =3D device_get_match_data(&pdev->dev);
> -	if (!expected_ver)
> +	st->info =3D device_get_match_data(&pdev->dev);
> +	if (!st->info)
> =C2=A0		return -ENODEV;
> +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> +	if (IS_ERR(clk)) {

If clock-names is not given, then we'll get -EINVAL. Hence we could assume =
that:

		if (PTR_ERR(clk) !=3D -EINVAL)
			return dev_err_probe();

- Nuno S=C3=A1


