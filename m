Return-Path: <linux-iio+bounces-3119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EE868CB5
	for <lists+linux-iio@lfdr.de>; Tue, 27 Feb 2024 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628AE1F24B0A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Feb 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70E13698B;
	Tue, 27 Feb 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bZ5NGxN1"
X-Original-To: linux-iio@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2047.outbound.protection.outlook.com [40.107.114.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4A56466
	for <linux-iio@vger.kernel.org>; Tue, 27 Feb 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027554; cv=fail; b=CjYW7EC6tzRTSPSSCSCGj50bebLh6jmwoYK6DxpZMPFIRGW2RCrKk1zABnRGRXirhZFgp4gRbM3ozluKu6eHDbPLdyWN5wR8oKBhr87VfrHZMxWAskuiryE94qZuPLHrKEtZDo3BBZIUfEI9HGsLbt3Ch1CcNhmaYh79M8wCVqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027554; c=relaxed/simple;
	bh=hno1w+U/yPAX1qI2vPR2tLWYKKfAdD7M+qV5bx44eF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhH0SioHjv0tPBUxEm9QzArmO4mey80ie1/gER3IsvwU3QSvtWqVrCcS9zP/kwHn1fIt5VLH1ipuyra/c04JZVCfIJZsnG7rQcmhmfT9rGuc+pgmMzOHLzTqNMUwY3LAZNECRWl7DQu+TJb4OsIwY4LgNWBvSd7AgBBIOiDrFTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bZ5NGxN1; arc=fail smtp.client-ip=40.107.114.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VujGk9XnBK+p9rKViw9W2klTJeYbiyVVywmdqmCQERV5E1FXHCmpZXUYjTP8xHhZ7RvKFdY5hCs1dwoVeMankSEiJSJLGWjWof7K1o9kF4zrEqIS4nbvC8fU/nsJkKNt4qd9r9FCPYE0Fes0qaVsw+Hnw1ERxD0v6G34XlRLTQalJrVQIiD5jGyYxzp113FpM2OW3W3ta1slqjdKcz1QU1BfKrI0Skkb+rRwz7e84o3JrOgAmAl2yDAkLvWHx885S41HtsjWu3GLBbHTSNJd2ZVXRW8KERXAPe6AXyj/t5ufBvsDz50HXHz30/kFFW/Hkb7lj4EO6UMykryWwHR8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtfvxA/g7joCJPHbLDmCOWWDDfx12pa2bJvGiMwmOHI=;
 b=a3KfEu1fXrn0pIHtpWkcN8LSTl+2klcWrElQwY0zXESgenFaJg8KTyj5rBhR60aN9RofjZCAbfumk+DbQpVb303tORP2B0rRlHOzBb/nJ/+Z6V397V0eJwizO4Y5aZMOh39O+glbH/+293VZtMCZkA481BxUYOeIHYK2eR2KoX/wFewRJkf4tUxNsO03+t++bRNEd5V4M5GEjfd5vyt0hpGhzwop2hg36yzsMe+ORGZg4B4k15OqeBepRXi9YAs+Oc5+NUB+pD2pTVUBpTu5JynPRbOygyjWuatyCFFdF8VnRA0OB9jDCDprgcorxpRLD2IDbhTX4aDpEnSdk/vHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtfvxA/g7joCJPHbLDmCOWWDDfx12pa2bJvGiMwmOHI=;
 b=bZ5NGxN1MmJpa+VnIxfaRp5tOw4IJFC+90/DvVBphZCLRvX4N/D+3/jBVG3185pPhckCta+WkfRx03+uLeDXQe40uLkkdAvRL1V/Py3kMR4oOK9zaEGQbxoV4Ft1R5LM7LkcQPsDJROLF46Gwi6nuqT1kIFHIWuRPO0Idx81WeI=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYWPR01MB10459.jpnprd01.prod.outlook.com (2603:1096:400:2fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 09:52:28 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f42b:6df2:8510:635b]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f42b:6df2:8510:635b%5]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 09:52:28 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
	<mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>, Marijn Suijten
	<marijn.suijten@somainline.org>, Marius Cristea
	<marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v5 4/9] iio: adc: rzg2l_adc: Use
 device_for_each_child_node_scoped()
Thread-Topic: [PATCH v5 4/9] iio: adc: rzg2l_adc: Use
 device_for_each_child_node_scoped()
Thread-Index: AQHaZx2YtWli6kUFuUO8TOZtlimw8rEd9tmA
Date: Tue, 27 Feb 2024 09:52:28 +0000
Message-ID:
 <OSZPR01MB701960E650277C6390C0A722AA592@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240224123215.161469-1-jic23@kernel.org>
 <20240224123215.161469-5-jic23@kernel.org>
In-Reply-To: <20240224123215.161469-5-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYWPR01MB10459:EE_
x-ms-office365-filtering-correlation-id: c9560542-2075-47c2-f823-08dc3779cf2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1hunO+qS9OAORbqHhmwzlqHbdlFgJcDuyovL4Ja+QXzKQCVptdgFW/uJ2WeWPFR0so8WmCtn4SqcPE0nyQz5zkxllWaL79Z4MtxGkRD95KcV9v0OzpoV8TozYytXefS4++cxvEAIyGYKgU+6g0XW2TeTp2J2MQcLRXapUyHJzU7j77OEWEC6WLgy16GXG3Ep29vQ+KACIjjQa1OiiIsI+2x/+IT97XodIG5fWCsbXVuDUimL19ZNnhJ070ms3AfhjqAjNnoE8D6VizeZmHN2GTGcj9GGTILx5Dahcl/H2hcPulZcpIGsKo9NZjZirTC+rtgGUbBrfOvmjX7zbYFyswIEEfSZgNKpbTf/Fd4vup9SDHiF7yP3CoheX1G59HtwCyFi1Ik6oOZ7aVlBDo4VyC0nbinZZsEXST51ofBwSWBMmwR0lav2KWaIcY54Z7y77Lio1FVcB4BO+l4M+PRIJaMGTMwEaRmTnTRa7R6wMfM+fl67OlwlnaSAxON+CWZ4OuSw0gqQtRM8239f6HqoOZN/+AP9b1vaYzxyc9zPwxYZW7+7/8U/6MN9APAySYesj5ASANyyJnUU1qwy3Zu/t46I+5KbM9J8qLkJvGBY4sagXhIxHllNwexIL9zfAiGeE88X7e963tykhyh3ecrOnhDh1HQc98A4clD7rHClKUnguJIb/ODMlBycKTMa/CVkajKWR8QdcI6Z9t371Xi4OdvbvjFAfxR93wAez3Iceno=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Wrx0LwoYHygexJFUngmlQJ4PNaIiUSzfQF7lSxijUWCIgrmF94bDBzi9/j?=
 =?iso-8859-1?Q?npgeLfjmZWeuB4XL7ix0ucI4fxak8Gua7vxNg0J574Clxdie81QPx8Dquz?=
 =?iso-8859-1?Q?8F6vBdS50qk8rMyGId6MuwU5w5SGTRlBPIuv7/a4+Lrr2/WQgNnWrrV0M7?=
 =?iso-8859-1?Q?yinfBOBY1Ur0+D1QyDV/LS/4iEDvDLkLCtWHJHvkGYlEhJ/R/yrlV9sB4X?=
 =?iso-8859-1?Q?9g6nS4yJ2H8RD1eyhtWXE8NJHh1NHD9i+Yj2bXtAjTEuL7aL/eDgGwhicp?=
 =?iso-8859-1?Q?4lPeFm/j8nMXfMyJQX2KAltCXNs4plotMcCjpVLSw/7yoNTW/jjqxSo7is?=
 =?iso-8859-1?Q?CkfaOtEh8HvgkXq1015Qjy0o+eut8WEWMPHg/ZOAWGlpJcyOyyw3LMUzA7?=
 =?iso-8859-1?Q?Itrnid7ii+14dv8lUeMTfFt97/ginWY1fP25rCaQl1A3wfDxabRuSjR6Ym?=
 =?iso-8859-1?Q?SgGCAQM1bzHYeGM89Il1RmBIgyBNLoAhnH/EurPW3kdBGXe8FGiZfDidwP?=
 =?iso-8859-1?Q?QZNedpf8lR+wEuMBy49gqN2SbVqRWcgsP7tIU/qI3zGmATmU+sXbamAHD7?=
 =?iso-8859-1?Q?BjYG0MXyAzH3zRYdWjyTWGr5pAcLa6tsXEeZh6euLr+QcfjaoNN33iZl/g?=
 =?iso-8859-1?Q?d2Ud+gRqJsLuWm4rvlCabNTVyVPNrwj8Urxc7H9lbSbb3jLhG6h5GVzsj7?=
 =?iso-8859-1?Q?BfyDLqR787PAyJqHnMdlKc4RIZGSv51A5QdageUOlklipMiSatSFvi281o?=
 =?iso-8859-1?Q?Kcn42hxoDUwugmWtEgi6Ct1VHZqRxgn6EF5YGrCSaRWQOFtgsFFZp157oR?=
 =?iso-8859-1?Q?BxgDW9fm6f1zgZqJygsNhDEl4UEl/BHt6Iob4lcXNt3QDwJHaovgPeryif?=
 =?iso-8859-1?Q?gxT1+4n9JpS8ms4xDZeIZsskGFrVwnqNLILtkj753MAtXOV+uz+7DbfjhT?=
 =?iso-8859-1?Q?jgoQhwc7jpbf3T0LH7fZqQPbAj28Kko5D988DKS5UvMp4GX6+LJkQ15rLG?=
 =?iso-8859-1?Q?JAW5c4uy6N+ZqJJWymnwkKeI3kiQqlCGhdtBcl/hKYfWbXcP2ndcWAjtBO?=
 =?iso-8859-1?Q?IrVqu8EISK9DC3g9ke9RFx9fJpyYradRod8vPa6/wVUKsHRZaV+RNnjHpK?=
 =?iso-8859-1?Q?LyK1tEnd2Pe5XDpb5cNVVIqTDPUpQGL0S3Cwsrx0J0OaxwLG48EPaeQGTs?=
 =?iso-8859-1?Q?QOIKiLYW1HhrRNE+YPYZ0Ox7KBadTFBgCMkBrT83T/kmdgQwLxyTjottHd?=
 =?iso-8859-1?Q?4msQMP7ghQotvwcg9PkMpfQnC7xT9z5sBQNDz3k+va4xx2yRe3rDGFEn/k?=
 =?iso-8859-1?Q?ERbTtQ1kZjSY2b9uYn28aYXYvKYjjbfU/xMdou7VvI+JgGJfkqAXmeQsON?=
 =?iso-8859-1?Q?C4feYqRSF7m3sEYwOVFN86N3RyGhWAtOOPmymEdoqeij6YSN8EybSdUnCv?=
 =?iso-8859-1?Q?Of9KuAqA7T5aiwqvoCigOkrSPr7/aeO3f9w57Qlbww0QrjQ4dEnX1B8laS?=
 =?iso-8859-1?Q?dxDpSkQz0QD80yxKF5eMBtZj8UPXRL/+ISzLDV+JJ9W/lC7NNtueb/5D+F?=
 =?iso-8859-1?Q?8YwRigHeWaVDBdpSTosGaYGBr8QeJ52t8pV/QaaUPyrkLaHv+le2VfS/av?=
 =?iso-8859-1?Q?n2BhSn22VGSSMICRAvAfAufybvUnuLevnn/gsDI8a+53J+exhL0sdgBfEm?=
 =?iso-8859-1?Q?smNXCS1YSGwVm423ebM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9560542-2075-47c2-f823-08dc3779cf2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 09:52:28.5844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuYidsm1qAAmYQKtoXy5WunzOtYjsmImsXBEIjWKuW2Ds1/v+pnOXogwLy7cZkafHyteRqZxJj6ZMcb6KmW2Ev2udzRAtJM6inpyoAucl3XiF5qjhLVCVriEaDoQmt5r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10459

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Switching to the _scoped() version removes the need for manual calling of=
 fwnode_handle_put() in the
> paths where the code exits the loop early. In this case that's all in err=
or paths.
>=20
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c in=
dex
> 0921ff2d9b3a..cd3a7e46ea53 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -302,7 +302,6 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_i=
d)  static int
> rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc=
 *adc)  {
>  	struct iio_chan_spec *chan_array;
> -	struct fwnode_handle *fwnode;
>  	struct rzg2l_adc_data *data;
>  	unsigned int channel;
>  	int num_channels;
> @@ -330,17 +329,13 @@ static int rzg2l_adc_parse_properties(struct platfo=
rm_device *pdev, struct rzg2l
>  		return -ENOMEM;
>=20
>  	i =3D 0;
> -	device_for_each_child_node(&pdev->dev, fwnode) {
> +	device_for_each_child_node_scoped(&pdev->dev, fwnode) {
>  		ret =3D fwnode_property_read_u32(fwnode, "reg", &channel);
> -		if (ret) {
> -			fwnode_handle_put(fwnode);
> +		if (ret)
>  			return ret;
> -		}
>=20
> -		if (channel >=3D RZG2L_ADC_MAX_CHANNELS) {
> -			fwnode_handle_put(fwnode);
> +		if (channel >=3D RZG2L_ADC_MAX_CHANNELS)
>  			return -EINVAL;
> -		}
>=20
>  		chan_array[i].type =3D IIO_VOLTAGE;
>  		chan_array[i].indexed =3D 1;
> --
> 2.44.0


