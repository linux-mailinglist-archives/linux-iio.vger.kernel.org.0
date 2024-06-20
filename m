Return-Path: <linux-iio+bounces-6645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5469112D4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 22:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2F282CD6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2324A1B9AAF;
	Thu, 20 Jun 2024 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="sfC1EMz1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262331AB91A;
	Thu, 20 Jun 2024 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914483; cv=fail; b=Qr8BuGLSKXppPXHF7pASXv18ScX9826rmHkjY8qauaSTTvTsTSOuqqsM3Z33MFkyfQGw25QbkXci8es3eDnW5L5XVaC2uPnwcFpV0VLc1X/rRdS1zdlZ4d294RiWw2XRG2a57/zHaNGmsmeATT8DurUf1yOI7TVu3reYUDXBraU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914483; c=relaxed/simple;
	bh=IVS3QtrZ5ykuYfZDIOtkSxISvzbGialR/XOeIpA2Fn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qOZ2lbB58IlInfD1rlTZWauUZt6i922VMGoDyG2Lby2XjExqgiQ01Ezs3m+3tc/tu+s74r2Gx6SnZWN+T6cjdP03x22Qv35LXzbnyRQJwK9Wo3ZCgbBQv86VhQXtA84IUgVwLY+jWjABRwoGylp6GHc5cRlMETcakQlBIfZZxcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=sfC1EMz1; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KIiLle011007;
	Thu, 20 Jun 2024 20:13:28 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2176.outbound.protection.outlook.com [104.47.7.176])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yvrk8g248-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 20:13:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP11HT63IZLzHvbkGi533VFufDz//bRlyrndgfxe85zoNjlnQqxmuKRfYgwb3c8bXuH8yUgFRocz1F2q5QLH/nhqtUUIhM/5J9t+8upCjVqXQx60H/suFG5oE+eyMFIkOAQQ3EKgDFpkN4aBX/U6cjMCd00VzTUYZ4gwFVhzmhG3edb1xjYrh8M0bb2/XN3nik57BA534ce8x3WmHM0OESiyP8c+bsn5oRDX1GL6dqroj7/Leohnwh1FFw0o0ginUvhwmOM1AH/kf/2uke2nr77pvUZQ2OPnria4qbvdMYQ/Q4XKC1pDGtI+QlaRJzs7En6vaZKad73vyKOvcXWBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp4sE+F+gnNfJMiIHxZo0O554zu1HvlVpR71krwypAU=;
 b=Zy7UvFKEhAbemjNGPs/dNbYVQ6hb9uptGeEeVreBxKZr8G+hFxt6PiPwDvTN6FNRqSwRKhkUkhdPxpWJU0ecTPVrVj3gzOrMIIa+cn9UFBwjEitw6RC24dpaCc7WJnWDSjaEwEG4iNGGMdQ4ehXsQwIiXFllMR9bs5uHonWczfFvrn2fuhBw7tiaETKxe1/PUjte6jpjMY3j1RpPd0nNygMHwgXC7Z4zdF7dANXeQJi8hDeu4hkvk0QkdTsCUofiGf4dhpftngiRd0Z0et4z1ftNS01XUiMQkC3dvIYUMUXoI0tDH4onFZlmUKmAdttq77ZeQfEtNFGSb+yZVSjRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp4sE+F+gnNfJMiIHxZo0O554zu1HvlVpR71krwypAU=;
 b=sfC1EMz1HOU6cAAUrZW8JMOBsNBYHTNX52qze0dPssN7d3NEUxey4wKWZpdCyIsH48BwhIKEOViJZNfftbHkbxO2o18JrsKXXT8ROzuMX5C3XG9n5joWHQL1WjQ4/9GwAalQTmOrp67IHXBncbiw+rEarfGwWyo0CNFEOc9JBbEp7pvGyfXJQct5s3rfLskEmkU+9r6xrLCB6jCDIO+FFY4+4NcZEEfNnVhS81l9FkueOyDpzl5bn/mCAzs9puThoL4CPx66xasDuPes79fU44rObsnv4SL5AgMsSaRnInLosOtqc7VDiMSdgCsmGvSNUpC9y99kDyqTPKaw91i8uQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB4503.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 20:13:21 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 20:13:21 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Trevor Gamblin <tgamblin@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Rokosov
	<ddrokosov@sberdevices.ru>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
        Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome
 Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>, Crt Mori
	<cmo@melexis.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev"
	<imx@lists.linux.dev>,
        "linux-amlogic@lists.infradead.org"
	<linux-amlogic@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 27/41] iio: imu: inv_icm42600: make use of
 regmap_clear_bits(), regmap_set_bits()
Thread-Topic: [PATCH v3 27/41] iio: imu: inv_icm42600: make use of
 regmap_clear_bits(), regmap_set_bits()
Thread-Index: AQHawL1erbL+I6YUckuaYoNX5CJs27HRGp6i
Date: Thu, 20 Jun 2024 20:13:21 +0000
Message-ID: 
 <FR3P281MB1757B426C8E184F5B1C8A334CEC82@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
 <20240617-review-v3-27-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-27-88d1338c4cca@baylibre.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB4503:EE_
x-ms-office365-filtering-correlation-id: d9f9fe65-6bbb-4580-cf90-08dc91656eb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|1800799021|366013|376011|7416011|3613699009|38070700015|921017;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?XpPKK7QlWfjW1+hBau+ZWXB7PBj8QGUjUnJnVaGl8yXN0SgqaX30NZzmWn?=
 =?iso-8859-1?Q?0P+ZoOv+ZuWfSLxLVltaYbKT5HQsUxjdmdGfssGqQ3zRsVEZmJxGsI6f31?=
 =?iso-8859-1?Q?uqI5VOwD/vWgmgzK7xk/M20G547CyAckSWcUcBP4hUpLFiSPV6SU31CD5d?=
 =?iso-8859-1?Q?WClcJGrWCcbvGsELF7KWIRqRn8RPQOO5Hsw9rgMyvg3iieMocr7JTld5np?=
 =?iso-8859-1?Q?VQ7f88KPFLBKM0xC6VvplRF9cS6vxpwSJK9zdcU8q2EANZ2mz49Hb6F9dW?=
 =?iso-8859-1?Q?DGGuHeLdjuoPcgeUEyzQ6xNVs0znV/OhyhiE+IBDVjxPnWutlQmwEQAizv?=
 =?iso-8859-1?Q?qERkRe0ciruEYr/GXpag0Y80Wt5+qsJO7L+/+9sJmxo1oIKOFGZR/ffBPx?=
 =?iso-8859-1?Q?LKNs0mhZmZc8KaieNtKiDGUpvR2GUjhEaZwy6CHBy4LdtgaHqrHz3JdwaR?=
 =?iso-8859-1?Q?btYYR3b4QIktEFDtGRf64sl5ZsKjDQmELjV9mQlIAtVeanUM+rfJWQtx+J?=
 =?iso-8859-1?Q?3p5FSxNZ08aPUZz3iqHd9OlOrJwFeVQY/4VN2qVZ1TQHhAfieEDbwp2Uql?=
 =?iso-8859-1?Q?SDx6wJGFdIlpkxwFUxrJSEvA1i3tbPIcV843zPIJnf0PgAXtNgrswBH/aX?=
 =?iso-8859-1?Q?/7Xnfk5xx9lnskvJIuteZMjyQopvQu9s19Gka0zX2Owyifx3dk/PSFKlrN?=
 =?iso-8859-1?Q?JnWMEptlN5FM7Lythm6EQRHY2DFtcZ6h2JBOiSC41X8WnxagjtyMMkkiND?=
 =?iso-8859-1?Q?keJnsVwAcpiCYC2lJIEKMyHsJiWJaaw8Rneml/1uqfHAFAOIf47Rxkl59k?=
 =?iso-8859-1?Q?kMSuHETwFSVq6WQNTdsY9RZQi9wKhAGCyegK+Plgz+xMnvxZdLwVgy1NMX?=
 =?iso-8859-1?Q?r+0jGxEork1GJXm46dj8Xr629I9tUk23fFHQCz8F/sVDn4/rcj11+HlGh7?=
 =?iso-8859-1?Q?W0lXsnV9s9n3ux8O93ElRjelCwdO95Ypuf7xMjxu5BJeSIdJYaEEHvtTei?=
 =?iso-8859-1?Q?+/ktaCdlu9k/vjitJe9Alz1K0KXbsxn3dLtRj9jKkX2ovwDcEXXWK+6wxs?=
 =?iso-8859-1?Q?8tjgcFnOOxMEeb+tF2Gs4MqduTycU/yDFNMFiU6z3aGwKmsPf7GIIhHvLc?=
 =?iso-8859-1?Q?7+OtwR01cSrdLEAi5+HgtOwqfgZQb81KAq1Aw5WMfF9ADIZibQgtF03KGQ?=
 =?iso-8859-1?Q?YfjjtzNFFH9XNzneG/lQXU9g82Y0Utw2u4QtYgtRoNWuBCWw48Op31m/yl?=
 =?iso-8859-1?Q?CIh4rJkDCSjD3sotNYsYmfp5YHjzHdr2NnhKPGMneCZNrgIeygqyW7IPzM?=
 =?iso-8859-1?Q?KgvEQx013p3p8MORLQmAYYAcNVZ8jCXtPdXBrgO+kn2SNBTasDOKEZuTD5?=
 =?iso-8859-1?Q?dn0XtOQ7NkdW5z+sl705yucP3OPxhqV6JyaLtUsgCnaUzfSE6XbxLPE2JK?=
 =?iso-8859-1?Q?MDhJePrBHdhxRijeMqdSAHueDhy25vHOjacweiAFIUoxte4tOZoVd1OKaX?=
 =?iso-8859-1?Q?Y=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011)(3613699009)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?nPexuniFbU+nt0OnsFlZ7w3h+y3NNFJyZx+Ba71rCFqVLe/cMX2Uv6I7JS?=
 =?iso-8859-1?Q?jL/r5GzdkX1Om/YKZXAHdd16hCt3Za7SySQbegyTf9Ef5lsMU4I/eNXetW?=
 =?iso-8859-1?Q?J45Ij1ZHKmdDzZcugK/pDTkFzzjtkpHYijRObY1GxSz2P7rN/w+sgDcRmZ?=
 =?iso-8859-1?Q?UmEmV7sqFXVWsB65USrRxRSpDmROIWvF8MRraoKgvCjAkG9+i0kO3fHhJy?=
 =?iso-8859-1?Q?MxBg3D1Y9EAML5/H9PEGlK/3r5rSsLazC2HE+hH2p2rv0zlFBhB6PNBWjw?=
 =?iso-8859-1?Q?a+fZPgp6uqgVHogt4eNtNk4wbNoUAxxXHedolS4Pw5RERW52tNy9m87l9a?=
 =?iso-8859-1?Q?4Nvim3ScE+Y0sbPCgOpa2yaWV1kehtgoDo1BBWjMCyv9y/0ovKIPQAZLip?=
 =?iso-8859-1?Q?/3MFTcfIMs95fDFjPDLfl2ZxJuWCK1khDrbOa/11b2Gtw1TPH+wBtefgkV?=
 =?iso-8859-1?Q?6xl8RAgVjuROVLn/1BghCAy7V9qCWp+KNhCwU97JVQ8RN3/aHwlVS9zSot?=
 =?iso-8859-1?Q?TTEWfLrrP1TYEPMjpa5uotie7VqhTmZBPrOgZ6cAXnvTrd2p8Ux/H6aTPL?=
 =?iso-8859-1?Q?nuTumsegVHW/E+MjDl8GmFiHc0zMT8ChUGbv7f/h1KJaw47Cb5IAxYTntu?=
 =?iso-8859-1?Q?68LyqrzfgBd36mOZcFUiY9CWnbPKgod5SizyWJzOBuVXtH7kXRLtXQH7yC?=
 =?iso-8859-1?Q?p57zoDbVr47DgoESRe3if5YflyOFgyYeSiiVY/0QJuUvh/LaNWTxg+hERK?=
 =?iso-8859-1?Q?Kjcx+RsMe9XC0X70e6JGdKyQOaOF0hZx+4PEapOupoyHFPTBkGCCPjmPPV?=
 =?iso-8859-1?Q?dp6gqIwxd+pLGGnjzaQLyImoRGNnVSeh0U0/0Lw7FjCJWrI1iokwhd9fxK?=
 =?iso-8859-1?Q?y52OKPefTFy2QNCUD09RGdNzGdiJrOc/DG2q/Lmrto1/wOvGKYEh4r2zOM?=
 =?iso-8859-1?Q?WhGXRVF5l9pALzuZXZIRFnLCoUEGeWAAwNQGOWdrpf0TNpvZVMyIiwS3sf?=
 =?iso-8859-1?Q?idxKuMNu9p/99ZXoXBKiRhcI3eKTyLx5jp03OAylJatU/12TZvBiLssGG7?=
 =?iso-8859-1?Q?kFBZbEr55I+/4qlznf530RAUBPHLU7zJibpFcPUNgjs1654G+foaMT3/Tw?=
 =?iso-8859-1?Q?5HS9B+SGyqftZzzPp/V58dlGMpnFAC0fIasvAOTaoFJ0QDLBmkbD448Bin?=
 =?iso-8859-1?Q?+oPsmQHVdBbgiZebis9fnU4HJl2/FVa1fiNrjwURS4/g4ptm/PUmUBqx3u?=
 =?iso-8859-1?Q?aFwZVW5jjLdnXR4XSOxIzBsXdKM48zasHRJbuYPTNIM09KRa+XBdBzr9E1?=
 =?iso-8859-1?Q?AOrkJLvLP336f7Y6zaGhAjdckaE3WRnjEuuFlk7ynGUrXgzFyCQJHG8gBW?=
 =?iso-8859-1?Q?zyYL5mWARWK7D4EMKHAbvyEskg4AuU1VWVHM1U4EGzG73UuRyF7kIOkL3S?=
 =?iso-8859-1?Q?OoZYB97v5D5qNI2BWCwrDSd/gkePJ/Q9o9mPfn1YQ3hJLqJELrfe5MuYSl?=
 =?iso-8859-1?Q?M6rxN70bJ/DM1+uUf6PgjeLMB1ILF4aXwugRQId4xnGcKMxpOnb9N6HlQF?=
 =?iso-8859-1?Q?Re0hLOXcfdzoiypGKPXGwK4B2BdBaAJ1sUoFw+nRgkzboGpwr54TsVyiz9?=
 =?iso-8859-1?Q?EE3dsPlqsshQMWUbcFaKTHr6vz2gGtpABjLda4p3bkKCcVy/ZiBd1BTPQz?=
 =?iso-8859-1?Q?cs/kZGPfiYKypNfm6W/hHGVHyakA6FM2Z7Z6KrQVI8cabKSlviQtR/mBrm?=
 =?iso-8859-1?Q?wdmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f9fe65-6bbb-4580-cf90-08dc91656eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 20:13:21.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVtp5SQE3hsDt6YUjdiE3wcAtmW61zqG4/Ldp63k+aEgNbcPNCrTRavUbqK+v3cgaUFu/dW/yb0DEm1JZT8OjbzKaNNMF0ylfPMFVVv6sLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4503
X-Proofpoint-ORIG-GUID: WlgyWFQOY_wOpF_GdnmiR7OdqVE_Piyy
X-Proofpoint-GUID: WlgyWFQOY_wOpF_GdnmiR7OdqVE_Piyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200147

Hello Trevor,=0A=
=0A=
looks good for me, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
________________________________________=0A=
From:=A0Trevor Gamblin <tgamblin@baylibre.com>=0A=
Sent:=A0Monday, June 17, 2024 15:50=0A=
To:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo=
.de>; Dmitry Rokosov <ddrokosov@sberdevices.ru>; Michael Hennerich <Michael=
.Hennerich@analog.com>; Cosmin Tanislav <cosmin.tanislav@analog.com>; Chen-=
Yu Tsai <wens@csie.org>; Hans de Goede <hdegoede@redhat.com>; Ray Jui <rjui=
@broadcom.com>; Scott Branden <sbranden@broadcom.com>; Broadcom internal ke=
rnel review list <bcm-kernel-feedback-list@broadcom.com>; Shawn Guo <shawng=
uo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel T=
eam <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Neil Armst=
rong <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>; Jero=
me Brunet <jbrunet@baylibre.com>; Martin Blumenstingl <martin.blumenstingl@=
googlemail.com>; Saravanan Sekar <sravanhome@gmail.com>; Orson Zhai <orsonz=
hai@gmail.com>; Baolin Wang <baolin.wang@linux.alibaba.com>; Chunyan Zhang =
<zhang.lyra@gmail.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexan=
dre Torgue <alexandre.torgue@foss.st.com>; Nuno S=E1 <nuno.sa@analog.com>; =
Linus Walleij <linus.walleij@linaro.org>; Jean-Baptiste Maneyrol <Jean-Bapt=
iste.Maneyrol@tdk.com>; Crt Mori <cmo@melexis.com>=0A=
Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@v=
ger.kernel.org <linux-kernel@vger.kernel.org>; linux-arm-kernel@lists.infra=
dead.org <linux-arm-kernel@lists.infradead.org>; imx@lists.linux.dev <imx@l=
ists.linux.dev>; linux-amlogic@lists.infradead.org <linux-amlogic@lists.inf=
radead.org>; linux-arm-msm@vger.kernel.org <linux-arm-msm@vger.kernel.org>;=
 linux-stm32@st-md-mailman.stormreply.com <linux-stm32@st-md-mailman.stormr=
eply.com>; Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>; Trevor Gambli=
n <tgamblin@baylibre.com>=0A=
Subject:=A0[PATCH v3 27/41] iio: imu: inv_icm42600: make use of regmap_clea=
r_bits(), regmap_set_bits()=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
Instead of using regmap_update_bits() and passing the mask twice, use=0A=
regmap_set_bits().=0A=
=0A=
Instead of using regmap_update_bits() and passing val =3D 0, use=0A=
regmap_clear_bits().=0A=
=0A=
Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>=0A=
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>=0A=
---=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 14 ++++++--------=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  9 ++++-----=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |  4 ++--=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |  4 ++--=0A=
 4 files changed, 14 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
index 63b85ec88c13..509fe6a3ae97 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
@@ -262,9 +262,8 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm=
42600_state *st)=0A=
 =0A=
 	/* restore watermark interrupt */=0A=
 	if (restore) {=0A=
-		ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,=0A=
-					 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,=0A=
-					 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);=0A=
+		ret =3D regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,=0A=
+				      INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 	}=0A=
@@ -306,9 +305,8 @@ static int inv_icm42600_buffer_postenable(struct iio_de=
v *indio_dev)=0A=
 	}=0A=
 =0A=
 	/* set FIFO threshold interrupt */=0A=
-	ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,=0A=
-				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,=0A=
-				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);=0A=
+	ret =3D regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,=0A=
+			      INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);=0A=
 	if (ret)=0A=
 		goto out_unlock;=0A=
 =0A=
@@ -363,8 +361,8 @@ static int inv_icm42600_buffer_predisable(struct iio_de=
v *indio_dev)=0A=
 		goto out_unlock;=0A=
 =0A=
 	/* disable FIFO threshold interrupt */=0A=
-	ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,=0A=
-				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN, 0);=0A=
+	ret =3D regmap_clear_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,=0A=
+				INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);=0A=
 	if (ret)=0A=
 		goto out_unlock;=0A=
 =0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c=0A=
index 96116a68ab29..bb302f5540cf 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
@@ -435,9 +435,8 @@ static int inv_icm42600_setup(struct inv_icm42600_state=
 *st,=0A=
 		return ret;=0A=
 =0A=
 	/* sensor data in big-endian (default) */=0A=
-	ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,=0A=
-				 INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN,=0A=
-				 INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN);=0A=
+	ret =3D regmap_set_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,=0A=
+			      INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN);=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
@@ -532,8 +531,8 @@ static int inv_icm42600_irq_init(struct inv_icm42600_st=
ate *st, int irq,=0A=
 		return ret;=0A=
 =0A=
 	/* Deassert async reset for proper INT pin operation (cf datasheet) */=0A=
-	ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_CONFIG1,=0A=
-				 INV_ICM42600_INT_CONFIG1_ASYNC_RESET, 0);=0A=
+	ret =3D regmap_clear_bits(st->map, INV_ICM42600_REG_INT_CONFIG1,=0A=
+				INV_ICM42600_INT_CONFIG1_ASYNC_RESET);=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_i2c.c=0A=
index 8d33504d770f..ebb31b385881 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
@@ -28,8 +28,8 @@ static int inv_icm42600_i2c_bus_setup(struct inv_icm42600=
_state *st)=0A=
 			   INV_ICM42600_INTF_CONFIG6_MASK,=0A=
 			   INV_ICM42600_INTF_CONFIG6_I3C_EN);=0A=
 =0A=
-	ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,=0A=
-				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);=0A=
+	ret =3D regmap_clear_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,=0A=
+				INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY);=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_spi.c=0A=
index cc2bf1799a46..eae5ff7a3cc1 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
@@ -27,8 +27,8 @@ static int inv_icm42600_spi_bus_setup(struct inv_icm42600=
_state *st)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
-	ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,=0A=
-				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);=0A=
+	ret =3D regmap_clear_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,=0A=
+				INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY);=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
=0A=
-- =0A=
2.45.2=0A=
=0A=

