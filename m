Return-Path: <linux-iio+bounces-24894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F00ABBCC155
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9454F4EF6CE
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA9627A10C;
	Fri, 10 Oct 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="LPym3mXG"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524426E6F8;
	Fri, 10 Oct 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084006; cv=fail; b=kKvSGi+V5+5esZemrR2D9rH8wNO231gMb7LY9vlop3hlivEAT6iKPwIRq/78nAyc0JpZmpYMAlA3Wp1tAacdVHwmmi2Jwgo7L2hJ0q7v2MuBpQUUYJvJ/pzvSyC/UEd2jbby0LjVd5ILPQqxl9uBWQ0HtanWLyzWSTSr2hzboMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084006; c=relaxed/simple;
	bh=a0a4C0Bp2qodMS/VsBoDMoMZBwf4V+ltiDSctLTWIOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BMyOe0BRiAikdDlU3u+jjwlBYpRWwTlqakfhIBSxwoJzy8xVGK0QPsBhIKmUxRVNLeiFl6oBqXVCjZeoVCqO29a/k9no14hw6gD3faIQpVv0Wmn9z/Iz1oHDy+qZmgabumsZ8kfSFaz2NcJ3DZkn2Dy/Hl+DhoP8NAUpnEc3Isw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=LPym3mXG; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vf0IJ0GoKldzJRFuBLsXTXYWSlRIpCka70Mz911EZsFQAMjVar/K9SJ2UlNhIBOSJPQo2qxxhK5WgOBN3roqSdlTRMu2ZhXGHChmHTF0U15NS04zEBzqIHIZD1erBjWmzh5DjotX69GYd4AAFJVDJi9na4I3hE3+8GuQboVfUb3miJcKSOfXEFsUt11L5gq29yyvbzXoSrwpo6IRfrG9ZJbJA+qk0y1pR7h3uEIfCWuXaS3LfEiZLkaybx4Izc2Pa6tt/wF97iHpHD0WTcgIyDETeDzLuyz96k1mCfIR6yByuIZYf5w8WZ4DMflFGucXdlAxmpxbc6F7yYvtkJ4ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGIz7d2n470ntx/udpbTnQpNHgxqTsfxh4kV4VvB35Y=;
 b=LCDn6PceE17tmONNQVx3s8LbbBj0dBpN5LkWLZ+ql4suCDSbVFlg21v1XYxoGwVB9JI2ZPqqAZPkGMbQ3X0VHKekaKjOV2uKp+GqFpyhcsYyWToigBU+VLaROAg3TIPWaXtL4QkoGCc1LCgPMdnLayKkaXcwqdIPCiZ3uCGib8l2wKhUkYi8HN605y3E8kefB+RhymJaNw0zgZ07HHJK7L+b7Yc230sM8cMmQAkuUOK/aprQLCK3gQR3d0yJblRyZXIPISTBB/cVWHnDng/WpNneeO4p5z141sMBITCF7rYWPVfzBvh1OgNJ6CD/GXTrf+d9AiclDSun0O28wUE86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGIz7d2n470ntx/udpbTnQpNHgxqTsfxh4kV4VvB35Y=;
 b=LPym3mXGv6+8uyiFpbMlOz3e3p+IRHJYE4gvdos1rdmIRgpjDniH93PSO1iyjH2hIafZm5iY4S9wGeguyhuOi28ChPB0jpqDW0OsjEQPh+drN9OjMvUIJDt3L3ujYazhP5xQpI6NsHAQS7eJ21kQlwl9tLZTF/abnDajwiC00YiKOx5CocpxfZxHrLDsR+1tLXJpqb9G8mF9JNK8U5usK9tBRH0vdIj4A1uVqacNJearL0bRFlIUPIftzOOt6IM5XYqoy/ZJHo/gQGgLGMUeFPezkAr1aqpTqKm0qNlXiOUOcmdXuyAm3c+6lTi/qlrFomh/hNV7N+0pgtQ5LCaEDA==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by AM7PR10MB3128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 08:13:12 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 08:13:12 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dima.fedrau@gmail.com" <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3 M/PJ-AIP)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: AW: [PATCH v5 1/2] dt-bindings: iio: imu: smi330: Add binding
Thread-Topic: [PATCH v5 1/2] dt-bindings: iio: imu: smi330: Add binding
Thread-Index: AQHcOTH/CwAq9vRhK06ZvZkBIVaWKLS6BruAgACZXYCAAGFgUA==
Date: Fri, 10 Oct 2025 08:13:12 +0000
Message-ID:
 <AM8PR10MB472118D128FC27000C09C49ACDEFA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
 <20251009153149.5162-2-Jianping.Shen@de.bosch.com>
 <20251009-squishy-poem-ddb0fdd9583d@spud>
 <b4436b4f-a54b-4294-8dd9-7a4b95711dc4@kernel.org>
In-Reply-To: <b4436b4f-a54b-4294-8dd9-7a4b95711dc4@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|AM7PR10MB3128:EE_
x-ms-office365-filtering-correlation-id: f7512611-1123-44ee-9c1c-08de07d4db37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|13003099007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Fj2B5rI728o9zgiRbMqQ1/krAxPuR5+L1ZVvYm8OeiYqcBhi+limseu2E5Sn?=
 =?us-ascii?Q?5A7V7z977jaukwx5Y1pDMR+O3jdBtLMOU2+OKEc9pO5SS+4Tqsmhl5MX7UAr?=
 =?us-ascii?Q?dOPuAtuvzeXkuCLS4GBRUZ5rWVuZDzbsWiplaj5MxWhZzJ4eQhCQz42BEAVZ?=
 =?us-ascii?Q?EoyzbTSH6thYJJlDKKjKMj5wQ1o+L3Th5Ab3h+jbgeIA+heULKBtHaFNAFUu?=
 =?us-ascii?Q?UnEPJv/83HgOgPCx3Jft+coM1R8h9VC9Q8VHY3JjedlYnGtK2QTjqsbx8Uvj?=
 =?us-ascii?Q?yp4on1SJzJMX6n0bmpOBTClkS0T2AMqTcEopGrRnLlrEodFjPyyCWZmSL2hV?=
 =?us-ascii?Q?FDBqJFlGO6i4JOOmKKINf+albqM2NNYeH09ctdqj9fVtZSEs32Ljl1xTwWKV?=
 =?us-ascii?Q?uRgVw3JAnanzQkJ0ADK2StGXTQFfYEgBYLm+286RBXiN4NKNfk1ohLmp7Blu?=
 =?us-ascii?Q?IW0w6cifSwhhnxkKMKVh9MXwOiMKXO4HhoLVngINABptL9TiPxwGbbiQ/pFZ?=
 =?us-ascii?Q?YaEn/BV3hmFmx23p5DCOX8lrh9l1jwmIw3cnZWLj79EyC13XvLd2mCdQxCtH?=
 =?us-ascii?Q?0xVwXDOLq7uMGsfmLwOp27wJABjxovolYcDe/R1bn9pp2xYQ4heJ6v0CVzMy?=
 =?us-ascii?Q?T7eJdSQwuWJSCxMUo6l2mktT3VdvOLd06OILBVkZysy0UvWw+7/oyUi7I/y/?=
 =?us-ascii?Q?CeX1oaGoQtH9vAToxU6JGpSijZjXjhFFOMTdNZ/DMnrmNYvkPzKnFWZ/rLEQ?=
 =?us-ascii?Q?wLhcxZjEUT6a50forDhrYnh6ZsGSYBGU/xQTo2qHIrSmkaRXTCV+z6UOckFW?=
 =?us-ascii?Q?VnagnbvCNkgkEpMKd5AFI1pNyrNs4T16rUEJGSYtL6yZK68mem2FHOeV2dT4?=
 =?us-ascii?Q?QxU7F1DU3ekvVafACPJLRHaRj/SY2OJVkoqlUwIQTExLS9xNzA5ZcAB4CBcY?=
 =?us-ascii?Q?wkn55Pi4CYrFL1E9N9eIg/KLWTePJPqVcNk/LaIquv9g3tw7j/GN1q+qlwlR?=
 =?us-ascii?Q?gLb74DzZ7Gf6jAQ9+LTd01m7EpG4THSIhgMKJfP871+mS5O5kIU/aYINa13w?=
 =?us-ascii?Q?pI9ji5rjWwmEO5wy3noJ6v7RUP9oS7p5XlGSuBZiYW99sD+TUuwtu8ejfuWk?=
 =?us-ascii?Q?XTqD+WPmwfPqIfMAFUErPFGdgdz3nWmIvziOHXg2/tDsQHE/FdPjFRv/VpiJ?=
 =?us-ascii?Q?pPgfpOeRlmFSbCh6kvwGmkVKzf6dqHmwqAVzjszYmBGySVcuZGSQq7MazDXk?=
 =?us-ascii?Q?/SlkfE05qqwQRuCc2D7+obsUWEKXXN0BXtpWqoJIJZlQ2uqwsktMosCaLbNa?=
 =?us-ascii?Q?ZLeUpRvy7+SVu2wtA4bDd3M7xjSpXX/xOI8YqD3KX2lLMxLG7dWxShYobhYJ?=
 =?us-ascii?Q?cNQS5oX0SZ/se/sqSkv5JVe+GqnKDrWuGMUSQE27vriKEdpW9EqG4/PVbhD3?=
 =?us-ascii?Q?8IlO9IY3hUZkZBZXQD6wwg76oFdoy4dW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6HNk27acRAilikQBLYmXYo0bZq2BolmFpoQRcNwpcNYZ2xzqbrq9VdvcPFCt?=
 =?us-ascii?Q?h3YEu9udFPjq++rWOztkrwh3lMRnOjbCkmHZbCYaK/YaEvvMSVfR6MSgXj9y?=
 =?us-ascii?Q?fGFGlqs0/NdavU3EEy53i992aiOxOU4Dr/s1KoIUr65Tqt1Z6a5lrKgTpWMg?=
 =?us-ascii?Q?c32kQJwXba8lF46w3wbQP4ZJ/92g7q0t+wEmHSYlRHZ674EbdD3uFv3Dgd+I?=
 =?us-ascii?Q?HT837mXyUmGrHckDojo4aZ3mTJamq7YabcPjpd7+G429jT1LmPc8DinxaigL?=
 =?us-ascii?Q?JouhIjMonE7B31mwFsbzh4OTmV5anBVExfh3VSteEcqisTbsYNOtvfeOwNVj?=
 =?us-ascii?Q?AA2D1jR7fDnGZX44Mjxk9+rHn+ok0v2mwb3H/SzVnOG3vIQotR7CrR8kvu1o?=
 =?us-ascii?Q?J9HE6gUBfxrfG648SIZdBWdLoo3n0FndmZwvtea8qhHDAloY4E9QDBcDTvIN?=
 =?us-ascii?Q?2QjjlFX+gwesiG+qsAWI7TN3ylZVv6f5HwlXfvW6MAYac+qtJ2d3nOVQVDBa?=
 =?us-ascii?Q?bKjtGbLdASkpq4YDUy8UK20/074DevPq7HqYD+awNxtQP7ms+GMqivo5elTB?=
 =?us-ascii?Q?2YyP9qGxMlhKTmJS++Pj/z9MJvj7o+6ygXwyXre2VEPWXgiVPAKNORQIIYcO?=
 =?us-ascii?Q?/c6onVDDnSJw2O2t/Jn2fwwljZD13V+KKzDoqT4sBHuNw3L5WFFC9QuskZjZ?=
 =?us-ascii?Q?tLKZS8sXC0kcYOqtFwFUTns8KhVvD3nbhWUTDnqu33dA8ezc9FHDOvuJqZF7?=
 =?us-ascii?Q?iihYtvVyMZU0Lf2d50Jh0Td1AuowvOMPYmG3AbbxIaYVVWUdkxY3PADVZNoJ?=
 =?us-ascii?Q?Czlg8zq/HiBArDnxj851YyRBUQ8ysFcbrAthND4pIV5MN/Bj0VT8JOZr8ufz?=
 =?us-ascii?Q?2lhjrc4WTvIAnAmjlKHebMWnN+caQx5Cz75R0xTQfgmUSGxDpcWSd2wosqho?=
 =?us-ascii?Q?U5AYspegfmpJJPXBUTq41h5nYB2AE7QA7bn8wLMtToEpRq+4rDQLgmobkfof?=
 =?us-ascii?Q?6jalZrRMERNPXYSZU8mAdzGIvP2l0Fy+9kV+gMiH4ISabxrbTmPwdId3Gkkh?=
 =?us-ascii?Q?IEoXJRJST37bWYuV/YisqxUux0kcIO1YC4RFwd4n3HkvNChcZ8ceRfF8sa5O?=
 =?us-ascii?Q?mjzSJqgWryNA1RQSkcs5YW9ntxGH1iGK1AuBeRAM9yhmEPUCa/z3R+qcZFUW?=
 =?us-ascii?Q?4X7mray75KKDQigQhZ4WRQmVYwSOqz9koOatFt6iTrmMqOAxHsfOw0mDRlNM?=
 =?us-ascii?Q?5JyK26ooSIYHPZqBios7bOkktCA+eXnBloXODKCvPIdGyf4ogSilgSd4bxEA?=
 =?us-ascii?Q?94y3ghV0j9zqjd42GO25HjRTThy5czc4bW4WCPG9WRwLeG3RxOABSFCsrgsO?=
 =?us-ascii?Q?oDMOTAP46eq5vx8khEUQIt/x7lAnpieowfvXGpy55CW3/F1K+RRDlU3GxseV?=
 =?us-ascii?Q?jJLDBwEdMZ4Pqdl/K/BXzB501vt+F664RURewmP7nGdv17p0Eoulo2Ffn9ac?=
 =?us-ascii?Q?tMklwOYEmErk32X8SgVTkFZTvKN3qmYJcVNv8jZY9j/IURexyyDGJsPdweAe?=
 =?us-ascii?Q?rRwA4EKlV40own9oT54=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f7512611-1123-44ee-9c1c-08de07d4db37
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 08:13:12.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DET6brGZK6566dnfojTzaVcpMwZSfhxjx+2WiAZAeBBATuHbETHDsV8iIhinT0xiIAMziBo9ofG9pPjjorQ9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3128

Hello Conor and Krzysztof,

Sorry for that. The patch is automatically generated. The ack shall be auto=
matically added to patch. For some reason the ack was not properly handeled=
 in the automatic generation. This will not happen again.

We have a kernel test robot finding in v4.   [jic23-iio:testing 119/122] sm=
i330_core.c:undefined reference to `ffs'.  The patch v5 is to fix this find=
ing.

Best regards
Jianping

>>> From: Jianping Shen <Jianping.Shen@de.bosch.com>
>>>
>>> Add devicetree binding for Bosch imu smi330.
>>> The smi330 is a combined three axis angular rate and three axis
>>> acceleration sensor module.
>>>
>>> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
>>
>> https://lore/
>> .kernel.org%2Fall%2F20250916-henna-rinsing-32a18a4d30b9%40spud%2F&data
>>
>=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Cb16bd41f74b6439328e908de0
>7a0
>>
>6a33%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63895658272275205
>1%7
>>
>CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM
>CIsIlA
>>
>iOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DdA
>%2F
>> lUR6HfaamYwPotYUdUrHiaG2LgGJm8LEcmRth%2FjQ%3D&reserved=3D0
>>
>> Why did you ignore my ack?
>> Didn't Jonathan already apply v4 of this two weeks ago, why is there
>> even a v5 to begin with?
>
>Not only v4, but also v2 and reminder in v3:
>
>https://lore.kernel.or/
>g%2Fall%2F20250514-deserve-marina-
>224bef5b2db3%40spud%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com
>%7Cb16bd41f74b6439328e908de07a06a33%7C0ae51e1907c84e4bbb6d648ee58410
>f4%7C0%7C0%7C638956582722772435%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
>0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIld
>UIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D7lgke1m7JvcNjIKigI4ugH4fffFSZBZgZ
>PQvClYsAsk%3D&reserved=3D0
>
>
>and here I exactly reminded what has to be done:
>https://lore.kernel.or/
>g%2Fall%2F1196da81-ecd7-487c-8afc-
>e0d3660fa158%40kernel.org%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.c
>om%7Cb16bd41f74b6439328e908de07a06a33%7C0ae51e1907c84e4bbb6d648ee58
>410f4%7C0%7C0%7C638956582722786576%7CUnknown%7CTWFpbGZsb3d8eyJF
>bXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI
>sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtoM%2BhpSCP6sNu8PU7Ed8iDG
>sQIRm6IvdYiWV8sdGjmo%3D&reserved=3D0
>
>which was completely ignored.
>
>So I can write detailed instructions and Jianping will just ignore it, bec=
ause who am I
>to say anything?
>
>I will ignore future contributions from Jianping in such case. It is waste=
 of our time.
>
>Best regards,
>Krzysztof

