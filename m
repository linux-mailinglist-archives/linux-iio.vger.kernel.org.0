Return-Path: <linux-iio+bounces-12223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDBC9C7CA5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 21:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD2282859
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53869206072;
	Wed, 13 Nov 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="ppw2t9Ne"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4B204F66;
	Wed, 13 Nov 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528625; cv=fail; b=L+IiqbsL4u7QrTcd3RSyqvBhaWQy6IKAbg6WuZKZ9yOvs1jgD4NaloLwgMR0zQEdiDUgV2ek9IVj7phucVu2rJc4gw9VmSNgmJyIBrxdYeZHLUrhlBP8MpXXYJi4hL7dcC45CrC8oY3u6vLpjTJqpZiq7BSKxreOUbyXttcVwpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528625; c=relaxed/simple;
	bh=vxRbguiCXBaD0AKyCcGKn79tzutGVhuP8F2aa+508mA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lDOyQ1xMW8PPtjJj4e4PVZoJFgmCCCp4ju3XudyUgtc3EQtCoNxKkev0zzP06t3XXxn1ysbwWaVpu5dXx8sNmjzEEnRJ3LoU/e8pGvay6wMPSTV2vUSUvQ2bSWcJxfsqOae5uIpKveY2GTKWYFAophhzzpag3hm7c6++7VnYyIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=ppw2t9Ne; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIF2Y0024001;
	Wed, 13 Nov 2024 19:28:08 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010007.outbound.protection.outlook.com [40.93.77.7])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 42sx3ybawh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 19:28:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBO6ULFIlHHf6eb7L0a+953EFkCmJ2HhluBo8SqcOtFCT/frx1UpS96JwK+/CTt+xM+uksNwzQzW2+nopImTI6CbxZe9Gh9Gwh7lhoEmZdcgtKtBE1ZignTBFOMyGI0rXaxxjM0tSRpyy+kGYMqfvuTTJLA8cr0xT9kl2KUlHbnpo8vkavDEtxzeTpgpgME545krUAsCERC5ALAPszmZIVdx4RfuyRsWUBCYGAyfeNJYpcm7V7BtYLdaUdzKVM39ZlcHPkWd9cRl3UIyrC9XlUN+ip0N0xosbq3DKV6827RiqsbMa/WKmFA1w02+ohXYZD8yf0+SSFnZDvj85MVFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUrDbUFhOMrbFYefX59y0OwWGcD3Q1K/rXl/UKAT9Pw=;
 b=E6W68Ka95pNjPIV69sWfVJlRh9+AZ4bfs1DkZQt889UKflO4h69EDOKZlTslqNn+4LGzMG8AzreRL3KcsFAewIDlrBXrrwtrK6y+axa4ARPXufx3or2xrAWfJqM8Uzug5YhC0dQC9+g6IsDr0TPR/Mn5y8LpGJw23GRFigOne0UIo5nximPMH8pub5cou7OsQG0JiivMEZYFsRIsa+x1/TYKFPbiAUGXd5YvXmZQk5bgZRTUZPMG5nFPJ6JZqwgvYezYu6PqXnF7pEg9xEMXuXOV2v8PVBvUv0diEo1I85Q2wmvbLi+L/H+xxXfPhQzscT/Rq6Zi4f7GP4A8wMtTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUrDbUFhOMrbFYefX59y0OwWGcD3Q1K/rXl/UKAT9Pw=;
 b=ppw2t9NeCek27m2LNeXvmJfzc/8Waaz1tDifta7plGwnbnPMfYxhGiZcNLyiabrHyyVJXAGhcEJ7g097RfnlIgMKu/QtmoFsc+7P2Dnzb+RUz0Vv3Z/J3yBvNk/N6FxQeFBet36RRJkOLN4ErXDpdkIo9eLwrp43X4Um63kezUM+hQ8YLqj9hspdb9Jv2zBge4ypYIJrjlYVsn39YLDgy3rvXDIAT7hqRmVzWoQ01THaAqeOUB++F3vC2eXZ7GSe0oUowsiah3Gbq3RzFdnxFWwSOvJGiO3YxPLlNu5WifSiIIAiTbbhMkWzc3aF5uU0sGk2zEmqq79oZADGzLrIgQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB1925.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 19:28:01 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 19:28:01 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Han Xu
	<han.xu@nxp.com>
Subject: Re: [PATCH 2/2] iio: gyro: Add support for iam20380 sensor
Thread-Topic: [PATCH 2/2] iio: gyro: Add support for iam20380 sensor
Thread-Index: AQHbNeX+15WWhwMA6UqGkDM4ORzW/LK1k0sE
Date: Wed, 13 Nov 2024 19:28:01 +0000
Message-ID:
 <FR3P281MB17577C0094A72EC546A21AC7CE5A2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241113-iam20380-v1-0-cae690c4674d@nxp.com>
 <20241113-iam20380-v1-2-cae690c4674d@nxp.com>
In-Reply-To: <20241113-iam20380-v1-2-cae690c4674d@nxp.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB1925:EE_
x-ms-office365-filtering-correlation-id: 8817b66b-5b58-431a-f184-08dd041949be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7Yk98T8mHxpUsFutCv5LsZi1bGGNrUuTm1/xVc09o2kB4DoazH010rqW74?=
 =?iso-8859-1?Q?iB1+5TS5Ui9cMuM5cNdhC8LOr/5nVIYBHAlkX5jo3a+z2vWHW7e1F2SLoK?=
 =?iso-8859-1?Q?OsHE77/ndaC3K0/ERof+Btr+lzWm6gb5yLIueRK/XHiCO0+f1ZnAsX3gjq?=
 =?iso-8859-1?Q?pdDml2ExLcnhUjyIcr+THXtDulgfbPrh6WzcbLdF1j1jGj+kOPowP32s7N?=
 =?iso-8859-1?Q?QIUm/BulmrcUdS7ADajr8Wqm6qLBIigzvGDg0oCMBkZjsKgeFk5K5Vy3pk?=
 =?iso-8859-1?Q?SW0rj5eyqWnLRTmlnyo7daPWZxJEAPzk8A2BD5r4qpzyI0IYp7eZM06I4e?=
 =?iso-8859-1?Q?q3XbsZ39rswUpaRc4ViFxpPpluDDOQjnyn41VTWIYx9qb1bBnP4JYMjGG6?=
 =?iso-8859-1?Q?GvhYrcRDvQlhUC75K/tdyWlMQWnhqJt/YDwNyeIoszHLRTfjT+2TcSWmUI?=
 =?iso-8859-1?Q?ViTUmn5FIXRjD0BAVuRkVeFRtg1IHnSic6ji5vzTACP0gpIVsRLdgiS90Y?=
 =?iso-8859-1?Q?TKAHyNgetxpBQnvNtHYNFRsQg4BH38MCGztSUzZhHWXUaJvQho9EarWE34?=
 =?iso-8859-1?Q?VPp0Awj2KkXGSsJxWM43DAzXCwuBYhLuExUOQ/KO21oK14Xa9nBpk/Oan0?=
 =?iso-8859-1?Q?4B2GtnSvnYOTEAFh6aUcL9KyRkX0HEx+8PG4T5Oe6MXbnZOcGWbLWI12qa?=
 =?iso-8859-1?Q?5QlxicUdVcCXxuVhk9dOosK0n6aFY0Sbj5F2Udej0i9/ixYMa8TgXs3A5A?=
 =?iso-8859-1?Q?6jreGZ/WV4UEnt6KRn3CA/tk4cBlabKXP56fokFFDPc04yNlUsgHE//R/d?=
 =?iso-8859-1?Q?u/hz90YmEAZaNMw6AcTj1qv31XMEzBRmVtRcgoGvnEkXzzNjsoKEnVKrDn?=
 =?iso-8859-1?Q?mw43mFjOUWxluPkSzCjDjwsiHqyZhi4yoWV3Xivq175QHvzAnhLp57bKO7?=
 =?iso-8859-1?Q?4ljRAJ1oWukcsc79GQsS2PLApvS196ff6yetqPHCOFAJnspnohqsuLgUCK?=
 =?iso-8859-1?Q?kbRpB0+8SUwYJt0SVpEcQFzR45Hk7hjE1wJ4GOYNhBqoqwrp2pTgqVkaTB?=
 =?iso-8859-1?Q?iqCbI9RxkPnkLXI7b3WPSIfdhlp0l6AGWy7+LcSlV8WlIigwGJXrM6rngi?=
 =?iso-8859-1?Q?iPUg0DXvAPCzEsR2lKXOfORKLl8cfk4zGaYRp6k2mei8RvCrQUfWprOAk2?=
 =?iso-8859-1?Q?mad8JQW78zvUbsxIPROtA9Xm55l9QR5SCNmHEP5S1SIrrV111lZWlm9COv?=
 =?iso-8859-1?Q?Xnr+ey4dXSwtUR/fjmZNCz2lIVp23jESPhzyPbpFri9lPYuHfwxGK6ZJ6m?=
 =?iso-8859-1?Q?TGwTq1zydb4M9MJIZ8mkAAfP1AotSLwlkjRU5r2dLCs1ZMFtmTvcz0KX7z?=
 =?iso-8859-1?Q?t4rouvfzT2o1yOiiey/3xFuDQpgpKcKouXQ7kv3gMPrzQQdshSRxI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wSarSDKb0wxyoS27ng5LrtvU/52VhHJYFsTeCPDn6M26X6EI3/jI96W54x?=
 =?iso-8859-1?Q?iElaLYxlNAfCTmSJ8l4SsPEzU31qlGKTUqnwiOjlev9HlsmF7Gflzvd71B?=
 =?iso-8859-1?Q?t2ULmicXAcotPoXSmyAfltSySeMtbxQIQs8nHmoGNtrmwvxocD/cvYrak3?=
 =?iso-8859-1?Q?RPfGdNRm8A2pxDFCERUpbi6isqsL5rr+Ld4912zeK7J8mTsf7lPcHtQRnI?=
 =?iso-8859-1?Q?Y8uycsUjPOZLWxPA3LgSssD0bnuGo4kRRtGFtUJwuqwhLeOUI3H3Qx4S7I?=
 =?iso-8859-1?Q?Zkzr3S8GgiWUVfBQPJ1rG8pWskwSTQcX3KQUz556h7nAPxSdCyQiTpTTLe?=
 =?iso-8859-1?Q?tCthZL8YevxhT0V+kzZbsJvDcdDUq2xIxxgrH0pP5l2b9LmAnTPbK6YQGM?=
 =?iso-8859-1?Q?JhJJYqNzh4/llQTJViNzx93JtNPn/F8W4it2qIi2JW2GEGS9trxvDH6gWF?=
 =?iso-8859-1?Q?9XYLeTalujnntJrGTKGzcWS+nLjAXkuBxByxvV8bIU2Lzf5EJPRcRb52PM?=
 =?iso-8859-1?Q?dA80s1NY9O6h4W0vTRsfLEJEd4fA91u1+s7Qf/RwTqquqCk9luZ0IjBcvq?=
 =?iso-8859-1?Q?kbwnuGCfJJypnlbvT3BUBPvo0DHUCiBiioC/+FJz+pdtx6U6NoGE3D0PBS?=
 =?iso-8859-1?Q?HiWdiC/Kq26XlVGTzBdb8rhILIohD1eod7PI0Unit5etDHaMwDKQIo9dkg?=
 =?iso-8859-1?Q?0JVEd8E9B5yCNuehykiWW+wfh9CE0GODG+A1a4QV4xuGz4AQJF6eftTvn1?=
 =?iso-8859-1?Q?3fVTYrnuA2iKy315z1R1FFMW17dCTaF2e5lqXaRJQ7/+r/5WSkvH1NhnRw?=
 =?iso-8859-1?Q?5rC9TlqK/zRW85yCW5y79a0VuKoIhLbP8e/cuTY/KTZInqOJ9A4XkckH9X?=
 =?iso-8859-1?Q?xhKsNVxvN/5sFzuOfgKgTCL8QEpNaahd/5QDRfnvHsdiPuBMfgbtzIDK72?=
 =?iso-8859-1?Q?qXMIwWfRkhDhpROwzvTng7vonWDcIHGsErEXnaPWdSLF54p3GcJZE8Vgz2?=
 =?iso-8859-1?Q?lCm62TZ1GsMxgjSXMGo2AqTZVD/S+CAnkfI9dM2NsIziPQsZ+/pQ6JN4kY?=
 =?iso-8859-1?Q?PElZ6KREacE6Y1I2EsaXPqI6U3vEuf8fK2pnsRzylOgZVI2LPDOBJBb82f?=
 =?iso-8859-1?Q?acVQKpmAQQR78c9XpdqIg4bvyJy18Dtw/gdcw5khTMFqboiXDnPyV/L44T?=
 =?iso-8859-1?Q?hagIe3k/Iy1AW1/3TrjHkA1HvD6IASUzbuM3I6C+lEEXb1tFczCzvq9KbG?=
 =?iso-8859-1?Q?j7OX2WG491WRSnjVGjnSniuAD5apAX47Y13pmByXLDfaA+1ztwzIEbcfdf?=
 =?iso-8859-1?Q?x5exn4qr3zllRd55o7J9jY6C7tQmwrXV0MMaLut0tI5yweCuSAHfQHK1Ib?=
 =?iso-8859-1?Q?DdZYgarTW8k0aaVk25lYWB1vL/oBrzVomIfhZ9tcudMNVy8X24Yhsc9jHv?=
 =?iso-8859-1?Q?p0tRiH2hC4/D1xb/l9YZa5LjvWFbzDadNZRRxm7I/2z4QTWKzJKSDJQIw7?=
 =?iso-8859-1?Q?WJdL+X+4VaRe6ApC33v8BLawCgtLuGYyiTMwXZi+sehreCTndCXxdYBO+s?=
 =?iso-8859-1?Q?0r3so1WsfJrOXh4/w9r5e2f/G71QPyETFGPMYWy1dOrSzS/0CFnLym9jBt?=
 =?iso-8859-1?Q?+yg9F5oUhecy7cebwezcp1p6xiP3ZrNn6gePdjpD3Z6jQNKZSONHD6vwP6?=
 =?iso-8859-1?Q?oQSfRxVRzxDAJ5yyW1uNOyLWwnzukrK5jwYb7+7E1vwErfhOQgO6wzdPZv?=
 =?iso-8859-1?Q?P2Hg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8817b66b-5b58-431a-f184-08dd041949be
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 19:28:01.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGz2jD1aAduKugvE+oPrT+ihU9rCvNBYVKIZou/iACCPax32QUI5QSX0wegDG/o42pbk1c9ZVat9sjdmkS1gTC1HKtZg+z/ef0t7ALOgQhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1925
X-Proofpoint-ORIG-GUID: K8E0bhP4qE8NPzZEcSMx3EVTSQtPcGSk
X-Proofpoint-GUID: K8E0bhP4qE8NPzZEcSMx3EVTSQtPcGSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130159

Hello Frank,=0A=
=0A=
thanks for the patches, but there are several problems.=0A=
=0A=
I think there is a misunderstanding about the inv_mpu6050_chip_config struc=
ture. The values here are only the default value at startup, it doesn't def=
ine if accel/gyro or mag is present or not. It is just for setting values a=
t startup.=0A=
=0A=
For disabling accel, you need to change the IIO channels by defining a new =
iio_chan_spec table with only gyro channels. Otherwise, it will still be po=
ssible to enable accel in the iio device.=0A=
=0A=
You're also missing SPI support. You need to add the ids and compatible def=
inition also in the inv_mpu_spi.c file.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Frank Li <Frank.Li@nxp.com>=0A=
Sent:=A0Wednesday, November 13, 2024 17:05=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Jonathan Cam=
eron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring =
<robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <=
conor+dt@kernel.org>=0A=
Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vge=
r.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>; Frank Li <Frank.Li@nxp.com>; Han Xu <han.xu@nx=
p.com>=0A=
Subject:=A0[PATCH 2/2] iio: gyro: Add support for iam20380 sensor=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
From: Han Xu <han.xu@nxp.com>=0A=
=0A=
Add support for the Invensense IAM20380 sensor to the MPU6050 driver. It is=
=0A=
similar to the IAM20680. But IAM20380 only supports gyro and WHOAMI=0A=
register data is difference.=0A=
=0A=
Signed-off-by: Han Xu <han.xu@nxp.com>=0A=
Signed-off-by: Frank Li <Frank.Li@nxp.com>=0A=
---=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 25 +++++++++++++++++++++++++=
=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 ++++++=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++=0A=
 3 files changed, 33 insertions(+)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 40271352b02cf..f6e41ee14298a 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -140,6 +140,23 @@ static const struct inv_mpu6050_chip_config chip_confi=
g_6500 =3D {=0A=
 	.user_ctrl =3D 0,=0A=
 };=0A=
 =0A=
+static const struct inv_mpu6050_chip_config chip_config_6500_gyro =3D {=0A=
+	.clk =3D INV_CLK_PLL,=0A=
+	.fsr =3D INV_MPU6050_FSR_2000DPS,=0A=
+	.lpf =3D INV_MPU6050_FILTER_20HZ,=0A=
+	.divider =3D INV_MPU6050_FIFO_RATE_TO_DIVIDER(50),=0A=
+	.gyro_en =3D true,=0A=
+	.accl_en =3D false,=0A=
+	.temp_en =3D false,=0A=
+	.magn_en =3D false,=0A=
+	.gyro_fifo_enable =3D false,=0A=
+	.accl_fifo_enable =3D false,=0A=
+	.temp_fifo_enable =3D false,=0A=
+	.magn_fifo_enable =3D false,=0A=
+	.accl_fs =3D INV_MPU6050_FS_02G,=0A=
+	.user_ctrl =3D 0,=0A=
+};=0A=
+=0A=
 /* Indexed by enum inv_devices */=0A=
 static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
 	{=0A=
@@ -277,6 +294,14 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
 		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
 		.startup_time =3D {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_ST=
ARTUP_TIME},=0A=
 	},=0A=
+	{	.whoami =3D INV_IAM20380_WHOAMI_VALUE,=0A=
+		.name =3D "IAM20380",=0A=
+		.reg =3D &reg_set_6500,=0A=
+		.config =3D &chip_config_6500_gyro,=0A=
+		.fifo_size =3D 512,=0A=
+		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},=0A=
+		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STAR=
TUP_TIME},=0A=
+	},=0A=
 	{=0A=
 		.whoami =3D INV_IAM20680_WHOAMI_VALUE,=0A=
 		.name =3D "IAM20680",=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c=0A=
index 7a5926ba6b97d..62f7d16c2ddcb 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
@@ -34,6 +34,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)=0A=
 	case INV_ICM20689:=0A=
 	case INV_ICM20600:=0A=
 	case INV_ICM20602:=0A=
+	case INV_IAM20380:=0A=
 	case INV_IAM20680:=0A=
 		/* no i2c auxiliary bus on the chip */=0A=
 		return false;=0A=
@@ -187,6 +188,7 @@ static const struct i2c_device_id inv_mpu_id[] =3D {=0A=
 	{"icm20600", INV_ICM20600},=0A=
 	{"icm20602", INV_ICM20602},=0A=
 	{"icm20690", INV_ICM20690},=0A=
+	{"iam20380", INV_IAM20380},=0A=
 	{"iam20680", INV_IAM20680},=0A=
 	{"iam20680hp", INV_IAM20680HP},=0A=
 	{"iam20680ht", INV_IAM20680HT},=0A=
@@ -252,6 +254,10 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
 		.compatible =3D "invensense,icm20690",=0A=
 		.data =3D (void *)INV_ICM20690=0A=
 	},=0A=
+	{=0A=
+		.compatible =3D "invensense,iam20380",=0A=
+		.data =3D (void *)INV_IAM20380=0A=
+	},=0A=
 	{=0A=
 		.compatible =3D "invensense,iam20680",=0A=
 		.data =3D (void *)INV_IAM20680=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index a6862cf426396..211901f8b8eb6 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -84,6 +84,7 @@ enum inv_devices {=0A=
 	INV_ICM20600,=0A=
 	INV_ICM20602,=0A=
 	INV_ICM20690,=0A=
+	INV_IAM20380,=0A=
 	INV_IAM20680,=0A=
 	INV_IAM20680HP,=0A=
 	INV_IAM20680HT,=0A=
@@ -425,6 +426,7 @@ struct inv_mpu6050_state {=0A=
 #define INV_ICM20600_WHOAMI_VALUE		0x11=0A=
 #define INV_ICM20602_WHOAMI_VALUE		0x12=0A=
 #define INV_ICM20690_WHOAMI_VALUE		0x20=0A=
+#define INV_IAM20380_WHOAMI_VALUE		0xB5=0A=
 #define INV_IAM20680_WHOAMI_VALUE		0xA9=0A=
 #define INV_IAM20680HP_WHOAMI_VALUE		0xF8=0A=
 #define INV_IAM20680HT_WHOAMI_VALUE		0xFA=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

