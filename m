Return-Path: <linux-iio+bounces-17903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25381A83F05
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 11:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712263A2934
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A325E443;
	Thu, 10 Apr 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="h0+ze9rx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A681D63FC;
	Thu, 10 Apr 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277601; cv=fail; b=F2kTowEwXPLYSEhZ2somQl+4f1Fjnb97vqfDoChSEMwZv0jO0ObHULFyNGbH4eosU59KRBMBFniNtZz8+Tj8NkFyt9VFaWNvSeaxXuOUCCGtOSK2Fj4RlUhw4KZ6dpu7i7AMNj8qtj5VNaLv7dsv8mUG3aL/vveT9ivnHQcTgJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277601; c=relaxed/simple;
	bh=nhMPUNSCvwlNRXZSSKnlPZSBkb+f5FIwjMVSodNg6Ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nZKv7yZqHecU9ERNGLiKJQHAJUTwtiQXY/L2bWS1jjZWw1oPbXpjU4JhUYu3MjPlK0/WWjwMP1t7Z5CJdPFf1Rlv6qFM6KZJ78d+tr8ZWP51dzEFM33S0XI4wLFElM3e/1N5q3S9ApzC/CMUVdX5nMT0LnlnaFhyXgZG3KBILWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=h0+ze9rx; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A4iDs6026092;
	Thu, 10 Apr 2025 09:32:31 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010005.outbound.protection.outlook.com [40.93.77.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 45twvmcd5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 09:32:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzCjEaJBdSoKr1yRJHJdERr1CBVyf6IIAdYQosXpXh9r3cMFoGiTwD0/V6Ex6bwAXnVprNLDR1HSmU+HhZUVeQ/BxcQQD63h2/Bgm6sB2pUpW5YXMoMux8FDEbsOly/4wxKLAOGl50UTbSVRYb6p6xP8WGC/p4nQLGfK6RIw5l2RBzkoZIn8Rk6EDu74i4ZlR1v6/ykH+G0RW0kSlnuCQDbaBNfWk51fdGqsYsZZuR6iQrXVam4ONEjk82WrXNoWl7nz1LzJJGB/Avs487fkOfmAk44m656tt3eV3Y6lxp7TDEJvLBlx4Akotlf9qaeS9FHMLi2ubMffYVCTDcxP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW0C1sVfQ9Cr3EFOHTP2vOd58JQiJM9yq4Q+k5DyP9E=;
 b=gxU+y4GUWwvoWOWUc3S+93FqyD0ifkCBIwlmbWjxcol52u00dU99pPQt43Ay+jNoEVZi4KQLr4P7f6B0AVEAKthA9TNIfumgAoVZb27lL3i0x4vfT2Rg4FN/WY4Cmq95CMlmYfLKDqsjOanbVKXVx8QIqU1Im0Jfi/CxtQxBBnvLP3pEN7qTx+jp280wwC8yKZWMQKMDmz5rH4ewfwfDDHcaxu7EsJxBf0HV0lVQKtEAQCAOyOfXpx1+9/WHOwU4tAVRuLiHytO8bt/MR5dKRARGUrTNm3NUYOE/i5TZCSsc286ACEjGlE4tGr+ZDGKSkwAPw4fd15kAT0r66yTD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW0C1sVfQ9Cr3EFOHTP2vOd58JQiJM9yq4Q+k5DyP9E=;
 b=h0+ze9rxsYFv1L46wPEJ1DvOqI1z7vvC0RXgYU8gUSJrRwUQm4FjrvLkQBcgfC215MAguxIww0qgJ5+Lje+pnfPNZoZj9vti+TfDEanh2NmcTmqOqEW2GpsfmF2vljULi5WTgy49/pNOE0w2sndxKebLsJdxTbuieSac6g/WhPh9SjpKwuMdgDFeR5fHNACJ6wo3zDWk/JvZPIqXKP55M3IgKnSBF9plG6Lqc28zLE4Bk9PE3J4rxFcw349W8/YQF3fsjkenSwFTsRv5/eKUXXrYtvNh4LpPKMQZdoreUN2Gd/9ed9Hld/44CxlPkwxJncaLqIbidT0kQpl3eqUQJQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB2069.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:46::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 09:32:27 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 09:32:22 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: imu: inv_icm42600: switch to use generic name
 irq get
Thread-Topic: [PATCH v3 2/2] iio: imu: inv_icm42600: switch to use generic
 name irq get
Thread-Index: AQHbqWIo0M0xeG5w80yikoDGKznqwLObkQyAgAEPTi0=
Date: Thu, 10 Apr 2025 09:32:21 +0000
Message-ID:
 <FR3P281MB1757EB72B134982F58BA23F7CEB72@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com>
 <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-2-dab85a0a7c2b@tdk.com>
 <Z_apXw_HoD0EHHY-@smile.fi.intel.com>
In-Reply-To: <Z_apXw_HoD0EHHY-@smile.fi.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB2069:EE_
x-ms-office365-filtering-correlation-id: c8428b42-b247-47b9-f6a8-08dd7812981b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pxQ/fhyTIJYqkDO8upMjXSvak7lCwJn3b9XpiYuZjdymfHOcNPPbXNYFNF?=
 =?iso-8859-1?Q?uNHayM5f6TSyh471nNjpusm/asWr8vJyZ3+ivvdDUAr5FLc7tvpUilVViB?=
 =?iso-8859-1?Q?cJHgrx/s8DzbgdrD91ysOeq6mnsFHXWICPCO/VAVM9Srv3CFGDx/IKhqYG?=
 =?iso-8859-1?Q?2olHkp1HXLb7APyjnvUOi5QHS7VgW1LXMDN0KmuPR+k3bor9sdSeuzQhxr?=
 =?iso-8859-1?Q?diO7AM2P7Hrdetvag4CYbwwItzbfsBf9h1E4l8zEgpBsvEpg7qwY+fN4Ix?=
 =?iso-8859-1?Q?QX8DA+M/29rluCZTp1t4t5X2STr2HPT3pQEfmGN0hVjFRVPGd2nMZ3FA8F?=
 =?iso-8859-1?Q?BL0u44Hx8IPI/wwZRVJJokIJ7z5BVUPIdFVaZu4103Gncv/MhJVEGvtUm6?=
 =?iso-8859-1?Q?ZYnQDQ9heAteCxI6ix0P0fsDt8rYcdAJirpwFNM4IydcTAA1e4vySiYxFc?=
 =?iso-8859-1?Q?cjYEFjhN7/bdatIEuBdBafzjahMY4lH0nLBlJfPnkpQ80uR66uLdsMoTg/?=
 =?iso-8859-1?Q?EpB5EPsYjMTL79WPIfYxkA2ZbYdSx8NdlyaaWpBAP9HorIrV3y35poGVPR?=
 =?iso-8859-1?Q?cJ5ulLxu4KWQU2uacRXxXmdTtqPRf1mi+7OajUuiTKid7uj9lpM1UsiB9o?=
 =?iso-8859-1?Q?z//V+a4PYfFeawnMxN52STu9Cruz/EhpOj5cxceN7rwOkrLI8MFNXpzWbn?=
 =?iso-8859-1?Q?TfkQWmAE+N1BkZe9ZX0kXoVbhnLBLOsuoTunzOtKYmg8RT+81fmujONo90?=
 =?iso-8859-1?Q?Rq0v0KR0F6KjJXJH0ix08xM/FPJibvNd/3Usbt2zsx72UyLOX3Wu6HVPya?=
 =?iso-8859-1?Q?r3i+uovRo+mBm/g7G7DW5vTWLaoHSrQdgfyWCoU3wSldUTaGnxYhioBNwL?=
 =?iso-8859-1?Q?sH5BcOvUXRvnKCMbtUngVMZH3Kr21/Sq0YH7BmrxIaMtVD6MvF6+BF4Sow?=
 =?iso-8859-1?Q?tKHdtthIFr18tEV67aYvayonGWHOUsVaxL0skBENYyxpxNqP0zUsgqjsW5?=
 =?iso-8859-1?Q?/hPx2Nx1YSfZkIxft3vCDuXFNGzWOViE415ynhDCxgcaJ8a84r1EouVccF?=
 =?iso-8859-1?Q?0RFGVaFqUjsIzkmIG+SQ4k1PJHHUCK2XAH5C7w8pTiHVQS6phUDZpIcVQz?=
 =?iso-8859-1?Q?2bmvBi88GRAGkFZ8zyhMvbhMiQLeO7RvsAgVfTCngbDdZ3IfUA7GHMrqOa?=
 =?iso-8859-1?Q?DHxwFM0AbIHkcPiPR6qGhnmKn4qzRM0i/sg4iL3AGnxu+w4PPg8gAbDGpJ?=
 =?iso-8859-1?Q?hBMxsl9zLG7K4KlOVfQAe/biP6dNbT4Gh3jyRF7JO09SKuaZ6Z1u6mcxG8?=
 =?iso-8859-1?Q?i8J9DdbPdIXHlVbN3VD4slZrtH2sqUtd/EQzjsJMBRtr6xNPa6ZP4cw9x5?=
 =?iso-8859-1?Q?sYWGK1T+gsyNEEHBC+wbG5JRDX1aGsb6yeSr9Qirf8q0uX6LdVZ/scnofz?=
 =?iso-8859-1?Q?E2xlhOhQbL+e/W3BmufDBvI4jsnJSdrtBR0rA5n4IUzSOWa+t2tlrZdpVS?=
 =?iso-8859-1?Q?5MH/LDcTCFpsAVMtbPItLPgU4QT9+Q4lZQO/6UYUeDiAj1Ztpt9E1kSs6N?=
 =?iso-8859-1?Q?qB6XlLi4KqAVt3mJSgpbJ79XqoXi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4WZSvYhEfzCXSGDM49IR8pmS57PV8HUQOgZoTB8FEsF5jdk/ppyMYo23bB?=
 =?iso-8859-1?Q?yKxldb54XFgcilcrj0Rn7+qMDfp7qqBP8/empxXqNy5L13BpamzaGDEnmf?=
 =?iso-8859-1?Q?j/+TsaueX1IX6OKrLn0uNj6FiIn6eXDjK79V2m02w6eme69WbnLDaxBLp5?=
 =?iso-8859-1?Q?3ZfXW4gWQQM3UTE0q3WZfJ0dEJyb/TvlapzZlC7J65Wfh9IKHJIlUinKzc?=
 =?iso-8859-1?Q?4eKsF1/+c7UMZ5yXt6NoU0PldyaKOeeG02WKHR1CNo4mvmtC4/0/6sUaaK?=
 =?iso-8859-1?Q?aErXry638sB4Yifh8G9bcrhdD0Gb0d1Yhn/mu+ztgZ0MrnBM3cE1qbPKYJ?=
 =?iso-8859-1?Q?2ahHj2eJlqXlP8ylh0JH9JyYe0JpNp5FBWrD4NyRguMiuZHUhAdU3Y2uZW?=
 =?iso-8859-1?Q?95QoK+ONFSciJNY1ZP3KFaAGyGlpxP4bS6v4WVmYmzUbmjZ9jkifmXdoVi?=
 =?iso-8859-1?Q?kWXNyneB5QzD3A4bt3b8GFfytGjlyXeOY0V+hrrXc00Kr7yGE72K4Gkx6C?=
 =?iso-8859-1?Q?PJ21MpQt1vVojn1CDkNQ5MqzhHU1ELRBOFHbGuH9UKkjazUtiZVukZ1CrK?=
 =?iso-8859-1?Q?ZUhrgulpCDaLztPZBSEG37qZobkx9rJvyQ5dlP7/sJS/XNeCswT8dK+aNg?=
 =?iso-8859-1?Q?Vc+IFMO1cYwoDdy1DsiIj8QyfyFt0PLYi+zp6AlYgAS+osSRynCjYH9XPH?=
 =?iso-8859-1?Q?+BB1nR/9lXMz6AR+NN9NQ9tXmCqoocyWh/DWcn8u2ied4b2IjxD/pDY9PO?=
 =?iso-8859-1?Q?8I4K+GtiS22BVO1ZcEYImf0DmEUfnjNK8keRCiRM7HX5Y0X7EV5AFNza1U?=
 =?iso-8859-1?Q?yIa9vKHYyn5fy/SEyiSgpr1hnNJzw+6W6S+KHMiAYh/9RaF3S0/eTOze6s?=
 =?iso-8859-1?Q?7z7VqutQMoWBdPvJZOlRmlCf1FZ7xoHNe4NhzcpQnVpB40ym8o4qSTmsh/?=
 =?iso-8859-1?Q?Ng39H1l9yROulZgaruu6Blag7WP7Cl5mEloIJf+gixDd20rHtqnAjG4Afz?=
 =?iso-8859-1?Q?in9t86qZlgqqpxrgsJviLFIRGPCPUx5bSeQmuLPFgVYxv8vqBsL41pjPGw?=
 =?iso-8859-1?Q?uGzm599u1LlwuZln/Mj74wag2zejb5xx20VRqxRFDivINQgj01w/LQXFsi?=
 =?iso-8859-1?Q?jj8To4HNDqkNo69QRDq2+NiiRoeqR8FBpCmxtpw7l5nkKaO3ahpUReSCRl?=
 =?iso-8859-1?Q?M++hD8nHXbU29yvMRxgLBigRRiHDz02QQvf1iUMdT5VpAC1ySnAa7+dYPW?=
 =?iso-8859-1?Q?v6r3Sx4pFrlufNwxRo9WvhjbkzyxK0buKTDT3kP7Yi7wHiYrRjr4hO/bkG?=
 =?iso-8859-1?Q?HQlWiufOQcgykYm3n8ja64wRQFbDsKG+1zYFOBnbVl95W9DxidYgJMe8HW?=
 =?iso-8859-1?Q?Cj5AAj5Kv3o5xJUCmulHO32j/P+yJQnON7ZuXmud12JsHyajEVKpWL6qFU?=
 =?iso-8859-1?Q?xUsHU6UzK78Fotb0Y3oOk66oZ0QzO9v14lcf4bR+bU5ax2gX+grOCWo/0K?=
 =?iso-8859-1?Q?IPDWIOjXQP+Qvff2qwj0vmXTD2CB2KIRMiK0TFSpPrtLQO4B1DkPGfD15l?=
 =?iso-8859-1?Q?MCFUjkLoHOOwpiCX1u826IW4P1w8h5OQvCTh7gngkf7rTLv1oXRvKlKqyr?=
 =?iso-8859-1?Q?vi6dAfAJjYDYUGuZV3aH4WzlDPNG/APVn9F57YSjM1ZZrFnSsLo32Tjw?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8428b42-b247-47b9-f6a8-08dd7812981b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 09:32:21.2848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkeBmejI62zY1x7TaQiakV7RJRxf1c6iOzajKTfZw3PVGxP9xWBGL6/o4FOGaN/3ye+1HB08bhHpgDIZlKcdImZlZePVMmKwUIuvETx4ZME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2069
X-Authority-Analysis: v=2.4 cv=eOsTjGp1 c=1 sm=1 tr=0 ts=67f7902f cx=c_pps a=R7FP+GcjGvC27S5kEK8ApA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=ldCMts-hAPDVDOvJ1vQA:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 5_fAQSc7kQmbeyQLX2C7P2qIQvpBi69S
X-Proofpoint-ORIG-GUID: 5_fAQSc7kQmbeyQLX2C7P2qIQvpBi69S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100071

Hello Andy,=0A=
=0A=
I tried to respond inline, but my apologies it is not working well with the=
 email client I'm obliged to use.=0A=
=0A=
To sum-up, property.h is already included and I will simplify the fwnode us=
age to use the API calls directly.=0A=
=0A=
I will just keep the over 80 limit following Jonathan recommendations.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Andy Shevchenko <andy@kernel.org>=0A=
Sent:=A0Wednesday, April 9, 2025 19:07=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo=
.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.or=
g>; Conor Dooley <conor+dt@kernel.org>; David Lechner <dlechner@baylibre.co=
m>; Nuno S=E1 <nuno.sa@analog.com>; linux-iio@vger.kernel.org <linux-iio@vg=
er.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; li=
nux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH v3 2/2] iio: imu: inv_icm42600: switch to use generic=
 name irq get=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Wed, Apr 09, 2025 at 05:14:32PM +0200, Jean-Baptiste Maneyrol via B4 Rel=
ay wrote:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Use generic fwnode_irq_get_byname() for getting interrupt pin using=0A=
> interrupt name. Only INT1 is supported by the driver currently.=0A=
> =0A=
> If not found fallback to first defined interrupt to keep compatibility.=
=0A=
=0A=
...=0A=
=0A=
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,=0A=
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip,=0A=
>  			    inv_icm42600_bus_setup bus_setup);=0A=
=0A=
If you use 100 limit, it fits now on one line.=0A=
=0A=
...=0A=
=0A=
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,=0A=
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip,=0A=
>  			    inv_icm42600_bus_setup bus_setup)=0A=
=0A=
Ditto.=0A=
=0A=
...=0A=
=0A=
> +	struct fwnode_handle *fwnode;=0A=
=0A=
Do you need to include property.h?=0A=
=0A=
property.h is already included.=0A=
=0A=
...=0A=
=0A=
> +	/* get INT1 only supported interrupt or fallback to first interrupt */=
=0A=
> +	fwnode =3D dev_fwnode(dev);=0A=
=0A=
> +	if (!fwnode)=0A=
> +		return -ENODEV;=0A=
=0A=
Unneeded check, the below will do it for you,=0A=
=0A=
OK, I will simplify and user directly the fwnode functions.=0A=
=0A=
> +	irq =3D fwnode_irq_get_byname(fwnode, "INT1");=0A=
> +	if (irq < 0 && irq !=3D -EPROBE_DEFER) {=0A=
> +		dev_info(dev, "no INT1 interrupt defined, fallback to first interrupt\=
n");=0A=
> +		irq =3D fwnode_irq_get(fwnode, 0);=0A=
> +	}=0A=
> +	if (irq < 0)=0A=
> +		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");=0A=
=0A=
...=0A=
=0A=
> -	return inv_icm42600_core_probe(regmap, chip, client->irq,=0A=
> +	return inv_icm42600_core_probe(regmap, chip,=0A=
>  				       inv_icm42600_i2c_bus_setup);=0A=
=0A=
This is now one line (81 characters which is fine independently on your cho=
ice=0A=
of the limit).=0A=
=0A=
...=0A=
=0A=
> -	return inv_icm42600_core_probe(regmap, chip, spi->irq,=0A=
> +	return inv_icm42600_core_probe(regmap, chip,=0A=
>  				       inv_icm42600_spi_bus_setup);=0A=
=0A=
One line.=0A=
=0A=
-- =0A=
With Best Regards,=0A=
Andy Shevchenko=0A=
=0A=
=0A=
=0A=

