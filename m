Return-Path: <linux-iio+bounces-13536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAEC9F2C18
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44DA1672FB
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E619D1FFC41;
	Mon, 16 Dec 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Vtar4fQt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF011F709A
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338446; cv=fail; b=T1AqDLuFO5fo9cerO6cPDWtQNiuiaZAwsK2o4roVxMC2963kzqYes87GoqDrenVGzeXer4rrZEcwcaEkXZoHNsRgZeuM/ExbCn2/CCoi0WWu1ySPZ2mt00gtVHaOx/NKoeiBTlYqLWuu0sbHwyDF27UKfjaLYhTh6No01hUgeyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338446; c=relaxed/simple;
	bh=sOev49cFwA3saEB79OFmo59w9tN03n5JyT384vfP8Ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYt7IIv9S4JL6wqcU0x3Sj0wqzPF+MGL4JDzYVMKtKwU953shF5i8AuM5PelncvG8te+QM+rzKe+nQHrAhHJCMddy+jy1Ga3YC5ZC1aDhh4pyVHS5Sj87zQXYX2L88TP42ZLlg0CN5rFiHrdYdqr08r0y7DzpQwQFyvbyoelMIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Vtar4fQt; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFMvSRJ025145;
	Mon, 16 Dec 2024 08:31:24 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012049.outbound.protection.outlook.com [40.93.78.49])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 43h2xx126w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 08:31:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYwMwFYwj/TqBmLmlx5Z1m2E+S9+JBnHZVbVpTdBGlT8ddoOzidk0ZznwueJqWJlom3iH3e9gq/Kg08c6WaK/Wt7AFh2VhxLfr2+yQLBIR3x1iQwRi6xJS/YtXZzNUCP/8mcdRWXiUl1QHXMXT04nG7LONUh7uPjjnPCbrlG+VAA48j8CuaU7FA/M7xihGYGRT1U96BK+MG1oIz2YY87oo8N8oEIvig/9T/aOmuMZC+KgiUg+z4Ud4v4zeElGuX+AEqQ0bd5U6i6Z1vysHzQDto3VB5eT1AKP6yV6syxigSZD1fXmcISBWwOCckPJ6tCn4+9Q3Hht+Gd+DR2YgOiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVHvSvYqJgI6vT5zHud7qKUySOLgPTXtZqV6ilkzcz4=;
 b=uqodDsHQWbz8/bc6qUofbeUdcPmBnwoQx/9d57TzcRAmF0v+61BUhL+tYxucRS/clxyvz6fLgg8DNtDKe7e1yNhs7FcN5/qt/1dpEyVaskNvOrChyyq8+6Rxg1Q6HJZpq+aXHc8oyMTUP2+qUUKghpCbSM7gnOOuEOIstu5BQzjqq7FXuGgMWpEvv3HToOPLMIwWLKAiuHlBeNPVgkUFZMXZv6MoepdvHEK7pk6drmxuFD+Y+utrHJpbyJnunwjAqRuQSm9pDZ0Znw4N6FnfwpxSlURZhyCerQo78rh7zgzqyXekwBRbnfUcNP3hAZzGM4q7xUrJdW91wwLIPDRUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVHvSvYqJgI6vT5zHud7qKUySOLgPTXtZqV6ilkzcz4=;
 b=Vtar4fQta2EoZTaT1yTKPNp79frp1TqnnZm9bsk+F/2l0X+Wn/psYEkI1qlzLlC6Enr7jQ365cW2EESm2QOhFhtY6vOQEDpwm5DO7IqRxPnhq+nEzmqYuhUd8La7rzzk9h1c+WTbmqt4qxTl0V+As25/vTIeDie2w0EMmQSE5VNlKb2y4K9+cRrLf8M8ElQUkNCvpc4xtJ9tlD8kw4wXrgYMPlPtx7f/PPyMyRKWykSiizR76CkK1FosNdxy40nmp+w2tklWtodyXQejl+TZysHQfVWSG3cr3XAko55GQsTdDEYk2ZEzbzLEJ0MjttjpvL8u7lNXkgKsg+aheAON/w==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3P281MB1792.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 08:31:18 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 08:31:12 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: David Lechner <dlechner@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 18/20] iio: imu: inv_icm42600: switch timestamp type from
 int64_t __aligned(8) to aligned_s64
Thread-Topic: [PATCH 18/20] iio: imu: inv_icm42600: switch timestamp type from
 int64_t __aligned(8) to aligned_s64
Thread-Index: AQHbTx9tByvXp22NO027AbPD1ptj2bLoizNv
Date: Mon, 16 Dec 2024 08:31:11 +0000
Message-ID:
 <FR3P281MB17577F86CDB48E269394C19BCE3B2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241215182912.481706-1-jic23@kernel.org>
 <20241215182912.481706-19-jic23@kernel.org>
In-Reply-To: <20241215182912.481706-19-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3P281MB1792:EE_
x-ms-office365-filtering-correlation-id: 00804863-63be-4994-fd22-08dd1dabff6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QMWt4Ystk/4UjHww0JYQapPzBjAfOIgmyqtOSZqA5ZMWLWqkcpqSKItI1c?=
 =?iso-8859-1?Q?8jne58uxj37iC6UZZMANfHQu/9CFlc7so5pPTOhVGF1aqqxnUD0+JYwcrJ?=
 =?iso-8859-1?Q?o50dDoWWi/cMjRaYIyiOhnF7piv9xOTff4rsyr+oxvxo5Wdo4REfY92nx4?=
 =?iso-8859-1?Q?1fkOoxbllj0Oh2dQfyHOKPZSFchsShfOYPIcWKe2tXvlfsetTSlVqxvjnI?=
 =?iso-8859-1?Q?rFvAmbRthQi2c5P339EVsMRigfW6fyc4uBulRewXK144P7qBwwIYdRl8Ha?=
 =?iso-8859-1?Q?eaZkm8tO6ezg1oCTItw2S4XaZG/ONIqqtREa03rjTUi3hxWI4iIRUEYXyT?=
 =?iso-8859-1?Q?Mf/1aqJGAiasyR0Ohr8MQmwp3TX5mQhPya0Jwmoi+r/N6jIvMrZAHvJBb3?=
 =?iso-8859-1?Q?weolSiRPq0/2i/+4u+xowWxy7lEKIg/MXBz5kuYODTV8qR0vDkGri7Yxdp?=
 =?iso-8859-1?Q?kMV9WSKP+9H8vpvDESx1caqHRS3VBb4HMR6O4cQZ4pVDvW4UOOtsUU8pA3?=
 =?iso-8859-1?Q?05s02t8SrUWAk9XYs903+5pd08lQXO2emMetKWqpwhVDyrTt/xIEv0BT7k?=
 =?iso-8859-1?Q?c9It6rx4XXsyG0AAXhX34cCGn8cvylDlxudqJlEYiTMubVro0d8Ki0BOt+?=
 =?iso-8859-1?Q?xZDMdz+VwVfdocwD/406HuasD5clIvV9dCg1p8QhB1f4PI4Ot9ItSD/4kL?=
 =?iso-8859-1?Q?dt/7/ccRgLJslgAej/fTMf0FA2JsBA1PizdStmsChrcykJh2Prp9gI58Hh?=
 =?iso-8859-1?Q?M9NeX1+6kUbFB6HC0lfQhAVaLobWLV59qjYwh7w4KWzcXDlCOfEaBSEl9m?=
 =?iso-8859-1?Q?h3mSiQvMLG8kfNbFkcDxuidUC8jDUFWlCeucEBkxvgGx/Cx2pVpc7CG0Hi?=
 =?iso-8859-1?Q?b8ElH8+YrvcXTZi2uooU9+GQ3SrlEpjk1akwRnaufxDl2sOzMSboPYY8r3?=
 =?iso-8859-1?Q?YXIYLG9sWDiYppn9/AlE/yHs8Yg1YkVvaOGl0FCs+xWqTGofLB6L/V3gXm?=
 =?iso-8859-1?Q?xcmatabR9/YfSJ4ce+ShsGcAn1XxjJraIZInRwPgLwz8mnmHGqkNlDGkce?=
 =?iso-8859-1?Q?2tFKcrc73Iou0Tw1RAhUQQuZGpQJ10flb7HhiECSdfR6115/O6NT7X//lP?=
 =?iso-8859-1?Q?E8NSDdU4XBN+RdyA/rYqdtspm5Fwg2STQX/gCeZQJgQbH5fkf4NQ5z1f/O?=
 =?iso-8859-1?Q?pTk2pHyNIJ//11/alLQTApD9iaJyEqBF/JHm5ROB1IUFuaz1hijesmNapz?=
 =?iso-8859-1?Q?CobpekPmsqBvoNTiTO5xRiZXClbBMSZXSELAj8C/t4lsjh/+Tcqx3If0vw?=
 =?iso-8859-1?Q?IUtksiAzeBvETNW2ffd5So4OPNYxMcwYLqi+QsxiwyTLy+UDVqaj3SZcGV?=
 =?iso-8859-1?Q?I9otlZZMGjx5C/N6gUBHYUTTXSnh0L3Vui2Az5ES0JXuMDtMYf5MXGLPKR?=
 =?iso-8859-1?Q?9kfcilwx21LwonvlypFSbv1R66rEJG7kCyGpeJDOOv9enKVqFGMLU5pclc?=
 =?iso-8859-1?Q?rYXu75++0j8PVWGS9csH+N+pDxjhm/eVAnAgSu3HySMg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?33QsSwDfw3paC/0ZhvN9L524SVWZpC4pHT+yJRKbOS8o/2Qu4d8NlaB9B2?=
 =?iso-8859-1?Q?9QGhO65M27W8SlBf8IS12K3UyTXEd/RDxPu+3wQ8txnpkR2bwFWN5vTeFJ?=
 =?iso-8859-1?Q?g/+Q55/CI8X3iAB3N/bsMXlqQ/bvoKRYNXY6eDIK2mkKfSdNV9WOUdqsay?=
 =?iso-8859-1?Q?+2Vf+YRTvdSFa3fxlvyvd8dfjzSgJQkmODufk2ScCk8yp3V2N0OyZ39sK9?=
 =?iso-8859-1?Q?Vg+4DXAJXqDl3fA/GH5bx+TjoVVg3OcnvxtxMKwDRGfV/Pdc4/ZtF0rdmk?=
 =?iso-8859-1?Q?C7xnodWMKcdyQlhr4Ft6ibv4gSaGGKYo2IA/z4EiV9VoZ3w9365f7/RXdX?=
 =?iso-8859-1?Q?5GdOKu4MYHWLKkwnnxnqDzwEzyV2IkIIEF/EedrO4qOvN9jmGTh6EK+w7J?=
 =?iso-8859-1?Q?iy7uIJjixVwiMirEVqavy7KZxpRVHH8TtWG81JQzYdwGvOUOKAI/YGvUdh?=
 =?iso-8859-1?Q?JwJixqaHHz6DsMRMh/QzkSoSQ/KZysU8ESxjo+E3YQcyfDbfszsMyPDoAF?=
 =?iso-8859-1?Q?C4wh1QSIFP/AUp4RLh12wCoHRTrXV5/KJ8tpxuJRPqmc/9zbRdDTUEEWpF?=
 =?iso-8859-1?Q?N706V8RLZtwAnxcpIvMEN+JN19xdyWYOOIqjNJ7RgaQTtCZQR/aZIqOc6f?=
 =?iso-8859-1?Q?nhafG50+EKFpeRFjvvaB6a6ZR5MD6vDJm0zlpH4ezUEJypFwsP6b483VJJ?=
 =?iso-8859-1?Q?t7Lw1+BA0Y9fYXMkHR0DiDYzdyIWyBa4iSRzM1dtviD8QV2OQBEIfA726o?=
 =?iso-8859-1?Q?nTeRrgrfna2HjXwtHtIfRpIQ22P1aZ7FHqTWgywC+S/0Nl6eYog2sZnasS?=
 =?iso-8859-1?Q?YwBe4xEFrnu/qiRgTHBmaETb5TEaJuLmZciF8dewHFRplfZFpyj8ZCKOkP?=
 =?iso-8859-1?Q?qOqTCKAw62x7tnpJrM+yVgi2ztUQEU3koeOHTq+3Lupi1lj/eK7QuL7gak?=
 =?iso-8859-1?Q?ePD51tsZfLKfC7vO76mCqttRiw1ojVMPpXUPAlCKilE2TrhxIvTCiiqU+X?=
 =?iso-8859-1?Q?ySHwVaMv4SdB+qWTGkZ6Q8nYG/cR0IwI08wzJBM9F3hO/LwwXoilj2xe8G?=
 =?iso-8859-1?Q?UjzuOWpnDtRL9DGJ44wa+GEzyb7ZRTstdUcDOrap7ULgxUgktKueNmFu0p?=
 =?iso-8859-1?Q?9L2GpuzPbQCaSXmEmYd97DA011wKnDmX4SddINy9rsPGqPRSOXuM7qfSxm?=
 =?iso-8859-1?Q?afsoGd+hHX6wAaZOG4EJv+wsok25pknhfdMB2+JnLdABhwPUnm3A+Fn0xD?=
 =?iso-8859-1?Q?w6Ve5KCs+WJ5cK96Ga3bYw5u5M3b3/b317T/W2gZXGJR7UtAAlqqZ0+IzD?=
 =?iso-8859-1?Q?ZZogEmzFwxLSl3XBvGxriEEarmcelGjRlPpJhfdVisCRRhiCaf5lTxgb/B?=
 =?iso-8859-1?Q?ha61tJsb+mdddcLZUpIkuTMMvtrohlmUx6m5J7vAa4IXGJgHkxJdLIrsnO?=
 =?iso-8859-1?Q?w8n6yY3mymGuUFeiwszk37ILBvO9ug3LiRdCUfksxFlKBLPeq4GU4EkVW2?=
 =?iso-8859-1?Q?syIOncvc3VwyScQry6xO8qnPKovuIFvKtU6Gqflfo3S0vYNK0U8OWijcNb?=
 =?iso-8859-1?Q?rIv+IPuUakn3n9kul+lBx3wBMb7KrSKzjzz0yiisgJc0clW+7yu/yUDumX?=
 =?iso-8859-1?Q?UW63GMgnjktCLm2WC6S0VqSyYMOXokMzol8xzsuA2mhhMhUKXL7sA39w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00804863-63be-4994-fd22-08dd1dabff6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 08:31:11.8241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00rlS220FHnVvEwuiIOjjo3Bin3Q5FnXELXkoNqlZ9lapzS6gziotXnFJrWaRlfx7C9hjYlWXoVx6ZXHSFqeT35K7/DCwQGaOcdA7wtEocI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1792
X-Proofpoint-ORIG-GUID: Alpt0f-8vJkHh-undJdvM1UUdWTKTeos
X-Proofpoint-GUID: Alpt0f-8vJkHh-undJdvM1UUdWTKTeos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 clxscore=1011 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160069

Hello,=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Sunday, December 15, 2024 19:29=0A=
To:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Andy Shevchenk=
o <andriy.shevchenko@linux.intel.com>=0A=
Cc:=A0David Lechner <dlechner@baylibre.com>; Heiko Stuebner <heiko@sntech.d=
e>; Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Subject:=A0[PATCH 18/20] iio: imu: inv_icm42600: switch timestamp type from=
 int64_t __aligned(8) to aligned_s64=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
The vast majority of IIO drivers use aligned_s64 for the type of the=0A=
timestamp field.  It is not a bug to use int64_t and until this series=0A=
iio_push_to_buffers_with_timestamp() took and int64_t timestamp, it=0A=
is inconsistent.  This change is to remove that inconsistency and=0A=
ensure there is one obvious choice for future drivers.=0A=
=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
---=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 2 +-=0A=
 2 files changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_accel.c=0A=
index 7968aa27f9fd..388520ec60b5 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
@@ -178,7 +178,7 @@ static const struct iio_chan_spec inv_icm42600_accel_ch=
annels[] =3D {=0A=
 struct inv_icm42600_accel_buffer {=0A=
 	struct inv_icm42600_fifo_sensor_data accel;=0A=
 	int16_t temp;=0A=
-	int64_t timestamp __aligned(8);=0A=
+	aligned_s64 timestamp;=0A=
 };=0A=
 =0A=
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
index c6bb68bf5e14..591ed78a55bb 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
@@ -78,7 +78,7 @@ static const struct iio_chan_spec inv_icm42600_gyro_chann=
els[] =3D {=0A=
 struct inv_icm42600_gyro_buffer {=0A=
 	struct inv_icm42600_fifo_sensor_data gyro;=0A=
 	int16_t temp;=0A=
-	int64_t timestamp __aligned(8);=0A=
+	aligned_s64 timestamp;=0A=
 };=0A=
 =0A=
 #define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\=0A=
-- =0A=
2.47.1=0A=
=0A=
=0A=

