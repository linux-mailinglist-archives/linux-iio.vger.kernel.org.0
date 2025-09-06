Return-Path: <linux-iio+bounces-23827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1187CB46CFA
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27AA582900
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5162E9EDF;
	Sat,  6 Sep 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="PBOyjgc7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDC288CB5;
	Sat,  6 Sep 2025 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757162543; cv=none; b=k+wh2Dw0xGYt3BsXJDFAj9mGLHkHPMrScgvXHek0mKnCZderNLNySIhv+gIZIXf6RVzYjo5WbFb1svumoRXl0j6BuvLN4eFnX4zCLYxv6ow6fKdym4griacsiOXnH3VlYSZs13yX2RQzOFXtLXUXt9P+8qbLV1xWSUhLX874kW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757162543; c=relaxed/simple;
	bh=Hm+GKKIWpg7dScyTlBsTiigjsE8UtZG9+Pr/DPZd9D8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=qlVCS7DIXnEHsZx7/XweVeXwJOVFcnq/pnDVVi2cIXhhNX3XuvJeJ5PbYHrJZss6G8siHM7oq9QJyZzfvEk6kDxCoRDfn4erqa3m/Qiatl3t+j4pL5QBil34oF0BcEZsjs0uv0DJq9k6vFu2kThEhEMNhyntsP30CZACXRLI8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=PBOyjgc7; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1757162486; x=1758462486;
	bh=v5ScnZ66jzFrHMw7Qn6lJeXlTaGjvDkyhTW+naUdbVU=; h=From;
	b=PBOyjgc7eBDCwad7MZRGBSbnX5lnoC5TWsEecCuJ9TT5sxH9IR7WvZjA31Z6opVzk
	 EwgbZkYodj21gps4eF62vqAXLDNnac4dvVAHjuh85dE0any8k8uFWZBmSoeVuilojA
	 3WucvzgNqewIG3xZhRDwxS4/902OTn2yUNOgrXURk75bAk39PTkEuPyLVpucmxUD2B
	 9RsbZP7XtS54/WzNBbkvy8exntCo963iGDCJz4tj9Ukp3IJGWd2g+gVHhh4UaCpBUL
	 sFFlhumE4mHhjQ3alSa0ZkXJAhrNHZh5xl1Jv4+mmonQi0+BEzX+heHtN0qfmVaiMG
	 WEwPP/ZxyA14Q==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 586CfHUQ082029
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 6 Sep 2025 14:41:26 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Sep 2025 14:41:17 +0200
Message-Id: <DCLQ427JYUS9.3EKILJ8O80RU1@matfyz.cz>
Cc: "David Wronek" <david@mainlining.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC
 ADC
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        "Jonathan
 Cameron" <jic23@kernel.org>,
        "David Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy Shevchenko"
 <andy@kernel.org>, "Lee Jones" <lee@kernel.org>,
        "Rob Herring"
 <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz>
 <20250905-88pm886-gpadc-v3-2-4601ad9ccb51@dujemihanovic.xyz>
In-Reply-To: <20250905-88pm886-gpadc-v3-2-4601ad9ccb51@dujemihanovic.xyz>

Duje Mihanovi=C4=87, 2025-09-05T13:00:55+02:00:
> diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
> index 85eca44f39ab58ba4cb9ec4216118ee9604d021f..38892ba7b8a42bbecb53621a8=
91a52a2fd70fd43 100644
> --- a/include/linux/mfd/88pm886.h
> +++ b/include/linux/mfd/88pm886.h
> @@ -10,6 +10,7 @@
>  #define PM886_IRQ_ONKEY			0
> =20
>  #define PM886_PAGE_OFFSET_REGULATORS	1
> +#define PM886_PAGE_OFFSET_GPADC		2
> =20
>  #define PM886_REG_ID			0x00
> =20
> @@ -70,6 +71,63 @@
>  #define PM886_LDO_VSEL_MASK		0x0f
>  #define PM886_BUCK_VSEL_MASK		0x7f
> =20
> +/* GPADC enable/disable registers */
> +#define PM886_REG_GPADC_CONFIG(n)	(n)
> +
> +#define PM886_GPADC_VSC_EN		BIT(0)
> +#define PM886_GPADC_VBAT_EN		BIT(1)
> +#define PM886_GPADC_GNDDET1_EN		BIT(3)
> +#define PM886_GPADC_VBUS_EN		BIT(4)
> +#define PM886_GPADC_VCHG_PWR_EN		BIT(5)
> +#define PM886_GPADC_VCF_OUT_EN		BIT(6)
> +#define PM886_GPADC_CONFIG1_EN_ALL	\
> +	(PM886_GPADC_VSC_EN |		\
> +	 PM886_GPADC_VBAT_EN |		\
> +	 PM886_GPADC_GNDDET1_EN |	\
> +	 PM886_GPADC_VBUS_EN |		\
> +	 PM886_GPADC_VCHG_PWR_EN |	\
> +	 PM886_GPADC_VCF_OUT_EN)
> +
> +#define PM886_GPADC_TINT_EN		BIT(0)
> +#define PM886_GPADC_PMODE_EN		BIT(1)
> +#define PM886_GPADC_GPADC0_EN		BIT(2)
> +#define PM886_GPADC_GPADC1_EN		BIT(3)
> +#define PM886_GPADC_GPADC2_EN		BIT(4)
> +#define PM886_GPADC_GPADC3_EN		BIT(5)
> +#define PM886_GPADC_MIC_DET_EN		BIT(6)
> +#define PM886_GPADC_CONFIG2_EN_ALL	\
> +	(PM886_GPADC_TINT_EN |		\
> +	 PM886_GPADC_GPADC0_EN |	\
> +	 PM886_GPADC_GPADC1_EN |	\
> +	 PM886_GPADC_GPADC2_EN |	\
> +	 PM886_GPADC_GPADC3_EN |	\
> +	 PM886_GPADC_MIC_DET_EN)
> +
> +/* No CONFIG3_EN_ALL because this is the only bit there. */
> +#define PM886_GPADC_GND_DET2_EN		BIT(0)
> +
> +/* GPADC channel registers */
> +#define PM886_REG_GPADC_VSC		0x40
> +#define PM886_REG_GPADC_VCHG_PWR	0x4c
> +#define PM886_REG_GPADC_VCF_OUT		0x4e
> +#define PM886_REG_GPADC_TINT		0x50
> +#define PM886_REG_GPADC_GPADC0		0x54
> +#define PM886_REG_GPADC_GPADC1		0x56
> +#define PM886_REG_GPADC_GPADC2		0x58
> +#define PM886_REG_GPADC_VBAT		0xa0
> +#define PM886_REG_GPADC_GND_DET1	0xa4
> +#define PM886_REG_GPADC_GND_DET2	0xa6
> +#define PM886_REG_GPADC_VBUS		0xa8
> +#define PM886_REG_GPADC_GPADC3		0xaa
> +#define PM886_REG_GPADC_MIC_DET		0xac
> +#define PM886_REG_GPADC_VBAT_SLP	0xb0
> +
> +/* VBAT_SLP is the last register and is 2 bytes wide like other channels=
. */
> +#define PM886_GPADC_MAX_REGISTER	(PM886_REG_GPADC_VBAT_SLP + 1)
> +
> +#define PM886_GPADC_BIAS_LEVELS		16
> +#define PM886_GPADC_INDEX_TO_BIAS_uA(i)	(1 + (i) * 5)
> +
>  struct pm886_chip {
>  	struct i2c_client *client;
>  	unsigned int chip_id;

Acked-by: Karel Balej <balejk@matfyz.cz> # for the PMIC

