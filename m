Return-Path: <linux-iio+bounces-9928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415198A5DC
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 15:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C267B1F24470
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23B18FDCE;
	Mon, 30 Sep 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DqLeMazQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2021.outbound.protection.outlook.com [40.92.90.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B918FC89;
	Mon, 30 Sep 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704172; cv=fail; b=P/Foehyr2IinimJI3HGbicJTHIQXHDzdus8miEiX68qy9PNfQG+fM/oTAX4iSmsTP7oxLJNq+iQt6awmJDK3/HA4Ui7GEDJtBVuHxPzwF8Lmdq/dVpv1EgQhfG2+sM4ZSXyDw5HCueNMQEqAjgA8C8VPHDlPmpqsYMRpnSyh7t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704172; c=relaxed/simple;
	bh=Y3VF2F9vDBNiQW9T34PNuViNeBF6IInbAAvMfRENS8M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nBlCeYZWFKqDI6ztZRX3vl8lfcmno6M5fyKwPqsUgvDRE9wdpBno1nwQJ63SYkqzUK6BI1f7n/3+FKkpQjUrq9n4VnnWy1uRKUkMKBtvopx9KKcS0/mgazUEZBTSN7LyiGtkKZvQutavgs5Vvb38dybZUBNPWrfaprYEis6HIWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DqLeMazQ; arc=fail smtp.client-ip=40.92.90.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzYQhbNMGcABFJUXAnxYZ6VjEYp0dKi7mglE63mBXpKkIjV60SjDFmjd2bqW94MqutV6kMZgcDo7RVovtQKII7DSOd1WC9jF1xdNOhIJ3Aa40YHyZtttX827sV3MtbnNbvAK3Boofse7sBVy6mQN7FnOxEpdB/L3aa1Xs9yHTUKExPeP+ZypwbamcNQ93jbl6Ed4WnONJWa3o9pOR1c9Bh6eRC5NY4k/gqZ9Ojv+kcrUmVs4pMvqTgJi7BudG2NorPZoAf0BEf5kbC/hsxROHz+QbTjVJxVRRwRTpSTbWqqgK9MQr5fgw1pvWB67ls6WCZxV/ya49h6juIlK7RjNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUu8nPoH8wKjvWpQJDNizd9kRmpEDtWKRXia6WEu6LA=;
 b=cahV3lbWuCqANFXGknRpsfvJjW6tpV2tS/y/skUY6TCUyJQlIpgRcg4GrnNFHICQgxdXbtmEsBGzcRfumVWFoemlJ5yuQOx6d4skI3nyP/zqq8fUvrFOvEr/sN08SkZPTeErqVYTG2f7/Cvw7sX2FGushPV46v+J2hDex0D5/2g8G9cA8UbMzJhvGlMYe07W/s2BErTOean6GVx/VreIdPDNY5O4hxtNlqcLHb4HwP3ssMIGgHz0HIzmtop8no5gSWZQKuQ16UnUFCWu+8zfjzIYnJns/nnLgxp761QvryABVgbpWfeGmfMIDkbFyTb6OKqYwc3KykwBoXdZWJ6FZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUu8nPoH8wKjvWpQJDNizd9kRmpEDtWKRXia6WEu6LA=;
 b=DqLeMazQBFPyKKCz49xPaWFgjICk3p7Mt1N601BqvTSt3mfauaRNr87zEIPyiUoe/M2w4HEnabXS1/tnPgWtimiSvJJLZc2mdStTlcY6ixUwj04aeQA+LiRlz9c/3Xg2aUV9mwwPJFTgLR0jXbISG+fRghrG+YjfQChIg/DUNrq5NSMOT+2d+STKFypGoCXJVO6ZUr9CxLUwZIdvjWuETe/SLoZ3P+OEsgaoUNF+rlOSCiLA4Mry345hOarxiFBqPjfsfGAkxAO355OwvuHXHKVLRIx37USDiN4DD6plAYN2S5sAZ1xxF1GTro1I9+dJBPRa5mhUCDL4tMcMv8RmnA==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by GV2PR02MB8893.eurprd02.prod.outlook.com
 (2603:10a6:150:bd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:49:28 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 13:49:27 +0000
From: David Binderman <dcb314@hotmail.com>
To: "jagathjog1996@gmail.com" <jagathjog1996@gmail.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Subject: linux-6.12-rc1/drivers/iio/imu/bmi323/bmi323_core.c:133: Array
 contents defined but not used ?
Thread-Topic: linux-6.12-rc1/drivers/iio/imu/bmi323/bmi323_core.c:133: Array
 contents defined but not used ?
Thread-Index: AQHbEz5DpI11X2LptU2CBQ9iEjJSmA==
Date: Mon, 30 Sep 2024 13:49:27 +0000
Message-ID:
 <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|GV2PR02MB8893:EE_
x-ms-office365-filtering-correlation-id: 0c0b849f-9cd8-465f-2503-08dce156b3c0
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8062599003|15030799003|15080799006|8060799006|7092599003|3412199025|440099028|102099032|21999032;
x-microsoft-antispam-message-info:
 JBRVSjjKuE/slZUakSckL6xXvKmMq3gGsRGwuUxqdTWxd2K5E82qaVhbYKTwmJzoQG2VMf2FIusZictu4OWwYGg8qWgyCUfGDGO6SGfJ+kP4faEUxPjxh5qnvs4Ty67QHjShM7d4FhDj8miM9EpvyIjURk9ed3jIJ55M+w1k/uGs1RmO7zSKLUL43ROVn7l+uPs35h1BzmV+zC8L8YS7ljKNKGg6322eg77SsSsOeaYKrleDfiqwk496ahLpsZmbZ8YNsoVv7LCsu2CMa5QK4N11gY9YkBxHhXiZ5Ay5T6A9UpAX9eWB0b9oCCe+nLCqjMFAXdsayjvTGr66G9LDYUBcMjB+4t0u4/0VHlAWeMSg2BmpxHS23THYnvBIAy/roxEonB2pvL659AVQ05E57rcmU6eHE1SU+TXxlfDHkixxZyDuitALfjH+Ozj/cSCWs6kXlZdl9XXcIGvfuhLJ7Etv9QCPhdoubUSgUtJ1tbA0zEz4CeJXAMHBQvbQitXIRvkpvXf8+6NNwssHVmQ0lNbvU+FjATiOjA2/yH0bEIZuckDsO7Ee3VbEaHGHHnRLd6yh+Y6ZcFoYh7ftvlVjoKOJQXw6vDNwq9ONqXcO5tcBrJCi7wx5jSP364oYNx180bM6hEPfQAUTNxcrI2qhiX0BSzyRO9gc697JEWaZBvRe/v+Upxp+RsaKfNNnfY0obO4TwKOhcmx0Ono56JhtRsIEVWNzrcFkaj1aNRJTE1IDik8npAlHJb959wE563DKO6bdMpCUM0iGRKQPjljaHw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3O1f5NSxTsGiDbmL3qXOva0k7glCBGiO5yMY+eybLsFnZKGOEaL7Te/d2g?=
 =?iso-8859-1?Q?aZVIs475h/3F7pFSR4XABFK3PdZaWaIWvmLmBSTagC8vKGqEXvcKhcrT7C?=
 =?iso-8859-1?Q?seOsmo4M5tih/3C7LqEkge/gD7a4g67y34/MOsRUbekTiuCjFUxQI4nUX+?=
 =?iso-8859-1?Q?1SxFs/hSl3wFEIWqknqGDShxBwNmye5bfdz2OmSqScohvjTjW5AR6HFAfa?=
 =?iso-8859-1?Q?yr1kWrJnZO8pdKAwtHK8x5z/jJhjGMgKudS3svxJUiQulZEiw3wgk6H0Oj?=
 =?iso-8859-1?Q?fL5bme9s4IPsD9AyQN2dE8a0xjjXXDzrs7vvk6kQQWQirbV0QFISZlIS5R?=
 =?iso-8859-1?Q?CFu7+wlFX+lYJ7BUtbB1u6oGsVXm60JunityFllplaU/RLtwJ9xglG+eJE?=
 =?iso-8859-1?Q?W4E/18IroDysmBd7WwwfLqaKdinRCCvR4QJG4wgJg6WDsj1TWr0h19O30g?=
 =?iso-8859-1?Q?rPWaeLxQP8Yd81vLs8MJgdZBa0jVg0mtsS+JJaJZFGji/w/dDLzUsvXaVO?=
 =?iso-8859-1?Q?h01Hx1EMYd4fbDcoqGVdp+YIqffPfmt9AcEABom05vG0bfmXH7+muPXw/T?=
 =?iso-8859-1?Q?pQtIsDtXTvOFKjSeFe7Fm1QPZQzPBVQcDbbyS5RYTqBF8NzQvigSknrWk4?=
 =?iso-8859-1?Q?L9P69Q4IO7q3Of3KkZbX73WYZ582VVvMBwaNq5MelanCey7qPDhJv/Y7oX?=
 =?iso-8859-1?Q?GqY15bGcTBEhj9v5lGVXjNsQufW8Vxyvs1L8pt6bEr/NLTovKmgwrW7eGR?=
 =?iso-8859-1?Q?/jo5KHP3UcxoBXUD+K2+WJpHv0A145qB6hBn77Y7euAoqLIjIRf74JaH0d?=
 =?iso-8859-1?Q?kZDZ69xPJLVNxI9twBT7xrZ5AfTW++0QV2T1IpWzrTZbo6oW1R1TsM/cNb?=
 =?iso-8859-1?Q?zOaIN/Z0hezmcfJrrjMRDcdhpSKTqucMHCY8kQ9QVTsQfFdFSRcHANtVGK?=
 =?iso-8859-1?Q?HKcsy+RPf70SQNg15UzqmeFyiQ0le940zTeRXezGWxrEJBM+j1Ni9bpscD?=
 =?iso-8859-1?Q?OF/QKeLS3JjQ8JcI7lshcM3ifAtKyA4r4/7CIvzViX73jKQlnz2PmxwKvd?=
 =?iso-8859-1?Q?sEORdJShrXZ50PUlM+nnTkPQ5sr5NKCHH+V1mU/HR7caPIcdXIEsNw/Pe/?=
 =?iso-8859-1?Q?LwRq1HzKrclyRn0SVqcJXimzs3bUzQF2J5uwnvx7nE3ZwgAWA9x4MVRkwc?=
 =?iso-8859-1?Q?WwJM1kR2lpgecSAr7tsEn4U07y6Gpv4G1JYGGlj1SoP2ubzpobdHmbVLYt?=
 =?iso-8859-1?Q?IaIuDtjxgD55zzYn+hKQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0b849f-9cd8-465f-2503-08dce156b3c0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 13:49:27.8795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8893

Hello there,=0A=
=0A=
I just tried to build linux-6.12-rc1 with clang. It said:=0A=
=0A=
drivers/iio/imu/bmi323/bmi323_core.c:133:27: warning: variable 'bmi323_ext_=
reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-d=
eclaration]=0A=
=0A=
A grep for the identifier shows the following strange results::=0A=
=0A=
inux-6.12-rc1 $ grep bmi323_ext_reg_savestate drivers/iio/imu/bmi323/bmi323=
_core.c=0A=
static const unsigned int bmi323_ext_reg_savestate[] =3D {=0A=
	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];=0A=
	for (unsigned int i =3D 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) =
{=0A=
	for (unsigned int i =3D 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) =
{=0A=
linux-6.12-rc1 $ =0A=
=0A=
I see no mention of bmi323_ext_reg_savestate[ i]. Is there a possible=0A=
cut'n'paste error in one of the two for loops ?=0A=
=0A=
Regards=0A=
=0A=
David Binderman=

