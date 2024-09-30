Return-Path: <linux-iio+bounces-9922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9334989DB0
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CE01C20859
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BA0187FF2;
	Mon, 30 Sep 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="PE2HnGB3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C188184539;
	Mon, 30 Sep 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687482; cv=fail; b=mbnofFxGZkeRc0HARcLfsc6V5wpU/Ia5JQFosO5RCe3KxlawJ2/CPGbYxTAutDYBlNMEo30Y4SpD8yzlsevvagZOPG5AK+Gdlu7hQAJn9UkHSlRWRaegvXPVdAasqM8G1szk3E9kW5SHcUe3cWBZ6/CTE/HL1t6kIrTSEOT+dUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687482; c=relaxed/simple;
	bh=boEnjbuq+gXOUHO+78wO557xz9mCbn0k3aWD6Mlqphs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tspoNCgJ2BrmE8Ji5bVMlip6SjQKtX3YKny9Zwboy+38WcyedCD4nI9NEUZU5qmcxiDskJZGi2f516xETpVdH7w7lvFi+BbpKAwpXSXQCC/Ba0SdBwDluti1iAb1Gf8HyB7N4/XazPkrhsFKWdzDVguoSb3rB1eLzJp5AOTqpLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=PE2HnGB3; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48TN0rBm012029;
	Mon, 30 Sep 2024 08:46:10 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazlp17010001.outbound.protection.outlook.com [40.93.78.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41x86016mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 08:46:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTBsqb1J81j5yHvgoKmLvlu4C3wfxwp31LiCwvwXZkwKPVW52FIwqKaJeBavUjl/DGuZJT78huhgmeHNOdSWeVeUy+djRI+vUHkSrACpuTo7JIHG+ZAi9O7FK1L/9haJO8v9ouSR/7axRe7GYhQgwX7YvwklNFZaKPc6GsWdQv95/8rfhocRE0HtOPzxv9BA+yfmF4aep1LPcvb7ZHWCRvZfzqxrpoAtBXtXgUltqbr8K+hU77PqV0Deq8K0HI2a8DuJJZFIe3Qv8dF6BgZaF/xu1tI2sE18hA/2hAwqMkrPmQUvj1hgqJgwOlwNUpC+Umt/w8svgyHjvuGH6zfwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIdyfimIWynm9oD/RGrBNPc28JAXuxoDVf3Jkd1Oa+U=;
 b=sUy1EdnID6W+shw0vEkIu0qHsfXFxlIjk7NpnGAtzkz41KdeioDVAJBrlDDs9S9joMyVIkvBvfAmg2QcPrHCBfX/AAN9E+KVMq5+Mqeh44QBZmq12Chijt/tcsOf+C+va5giEllzQFpQVNhVPFWD2gMG4gNxUJyOWrbUOFlAzaubVtGu0P+P3snt1brv5/7NGpQogUbKwZNnK71xmiTcN0W8B7n/mO/Aw18dLvAGG+tJG8iW640zqIzprA6xOhi1zXw8v3bX7tdWD0pnPZlvXpfA+kaUbjw+L9qRUDhNvJghETjmOGSpFElAuQAN124/3JNvD1CTXO+3rbWKYsvT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIdyfimIWynm9oD/RGrBNPc28JAXuxoDVf3Jkd1Oa+U=;
 b=PE2HnGB3i6DhHfiGLYyAIJWVD7CETBQ3c8qRq21WGLFdWp7b2z6UrVzNeK2hFPPsG5D+xN1//7WNzDpHKooaTbu2nPpKXIrpFgubbJO42mJqWmg1YD4M4a6Ovq6sZ+7eP+1b54dYT5x+cYzssLAcFsxOqSrjSXrbqdkGsMHuDe7jHxalx5Mq/U0Fiw2v5defcSPUbeiaWo0hioZz3ZsGzX36BokZEIzw3DfdPh25WS1+6FSoDE0FPnK/DOEtBwyESoZoSRSlIGc/555/pFtRrVdaJF0WcSHyod/uZaWzffgFh10rHfwKzxZJDmeSZa/mD5FZlE4HI6OCmAbn7/g77w==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3P281MB1504.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 08:46:05 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 08:46:05 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Thread-Index: AQHbDchgTmVaicLoc02Cv68VulgeHLJlgccAgAfuaACAAp2UTQ==
Date: Mon, 30 Sep 2024 08:46:05 +0000
Message-ID:
 <FR3P281MB17575FC03AF60D690B67452CCE762@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
	<20240923-inv-mpu6050-add-iam20680-ht-hp-v2-1-48290e0b9931@tdk.com>
	<685c0c28-9439-45da-8bc1-19c2c56b2053@kernel.org>
 <20240928174550.47cec40f@jic23-huawei>
In-Reply-To: <20240928174550.47cec40f@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3P281MB1504:EE_
x-ms-office365-filtering-correlation-id: 893fac70-a384-4c5a-ccd8-08dce12c5269
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8t2Ck8jJfi/f2MBdaX/wgJ3I16B9F2nEsEjyauBw9uRneG1wSND38Th3ve?=
 =?iso-8859-1?Q?Q6TVtgnH8vYAQgr75di73Wy7x7Vqxt14j8XUld7kdNC9RLuDsFbPuxw/cv?=
 =?iso-8859-1?Q?Pm22TUJa+6JNPpdCc5vUfDeSGJmk3mZkvG91PqSJ2m/f0R2dWA2A3AkGRS?=
 =?iso-8859-1?Q?Sq1A/XWBl4MR5g+WnHWjMjn3LAXeMCRubl4F6P1qL/QkLZCoJHe6SfCWKU?=
 =?iso-8859-1?Q?LQ9z8pmU7gCLYj8NZvI0KN6bnqZRd9P080zBoVULZMy9JRBUSZ0wBTM4+q?=
 =?iso-8859-1?Q?NxQowiYBWaLvvvoY/bVPkNJc9/yH9E89+ODMkeoIJ+txuQKIjNHYJ87U6B?=
 =?iso-8859-1?Q?llTOqKsU0cV9hPC2X6BQoZRF/q4jtD4g+U28zxLhdnDkAcLymnHJqPxjv4?=
 =?iso-8859-1?Q?3tcletHNw1uaqwlmnLfHiX6ox41JMixCJ2v1CA93n7eNq55IUVCqROU+Bp?=
 =?iso-8859-1?Q?8fBPV4X0hXEWvgnIwZvMy4qvtGMmEJGGIRgleh9qknW4xzg5nayv3O0ci9?=
 =?iso-8859-1?Q?s5GdYRLoaIFCPpu0unKfJmFVbg8sHHFwx8YYUSiXK14vtF5or3Vn5bne/+?=
 =?iso-8859-1?Q?gNF6VFVIfiPVga6OSvIElgK9LJzA1fcitquMCr16b5hkxgN0tenvaoKybV?=
 =?iso-8859-1?Q?dkh3o7OZju2DoEU1jfN+7zQ5iFikUFr0a8om/UNDmDubEcaekAETatq01z?=
 =?iso-8859-1?Q?rHjfJl61diw2axfA2Tw6ZtaYkNUhMOJar9jC/iqZL3NuxZnMpcaR36gvGp?=
 =?iso-8859-1?Q?BypvNOhhnhxdXmmBk/3SZpL78X+AMEeKV/kkx/AgbD3NBIwyJ+4p1LTPgt?=
 =?iso-8859-1?Q?Mv9OL05+H99i4VnPVbCLTXY2BfHjFsN67A4eQGdT+6YxaTT5f5sI5cV4f+?=
 =?iso-8859-1?Q?s70+WjIVKPV6LVrBIhoBhCu7dsBO3SN1xxawhd6Lt0/mS2sbKs/Jtrp3hg?=
 =?iso-8859-1?Q?HQQCsTfNNf+NIMTXuNwgrVHqzgAM4f9ghvI2VbYRAUpL3EfmY8cF8l0Vld?=
 =?iso-8859-1?Q?t8WDH3YpZujdUpzyzcaLm8BIpz7jBeFRCu6yXptjILkpGkFWX/mxL8N1Xy?=
 =?iso-8859-1?Q?8BJAhsgy61mwXlbtB4n4RiQGMdr/3mr/pmI4si7zmsKLEx0LmwIO0H334F?=
 =?iso-8859-1?Q?DZkIN1jLfl8tR5C6xLvfXgEzUgzIuVADE9vWo1HRlkGGWQ7feErSuVwtLX?=
 =?iso-8859-1?Q?3Sel3Wn8xw3ULIAdMX3EM6+PGCw7irQE0TVjaXsn8MQr9F7vDmTXaZaEFE?=
 =?iso-8859-1?Q?4+QqtOu9iCGiHBk50k5tNTw9YJPyXJmnBWa8X3nIp8WfIcNppeNO7yNDQx?=
 =?iso-8859-1?Q?WpLaaT40xEBTZ79vzIgkjHr7DuWRwc5RJQgMs5v5Ex9jW/7+QQAgGjTeoL?=
 =?iso-8859-1?Q?VDGzqWGAxPcU819k+xljrPjP1VwufBJw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ute1VGv9SJ5W1uhHh5tyz3mcyn739uq/cNhIOVnVvbB1GmDgeL1aqf7cyv?=
 =?iso-8859-1?Q?9NPFjAThTYktbff5DE9byesR8osqx6kztr3r245LyrKCswZfAB4Gb4Ag+N?=
 =?iso-8859-1?Q?77A1zN3MbsmkEvPomb/apC4ph/bsP+TjlAy9CwtNJYAhUDgANoX3HXL1+j?=
 =?iso-8859-1?Q?r/Oom8INOUj0A7C9h8Kq96A8o592CIoEd6AV5jlXyQ/IxkUv8ZrSeeHPpd?=
 =?iso-8859-1?Q?FQeOtBmYLCf4fi2kezslre4RpiGyj6upvGOw0K2LvHvRFdiRsf5hirN80E?=
 =?iso-8859-1?Q?+H7xzU42TQwYgJfYdNNWlDFroQ9ZmqbERkxq85vfc0xa4ofMu4pqVUYa53?=
 =?iso-8859-1?Q?LpRxzmOqxcPT/Xz6lMyoFBR5ILADcBRjx43eJ3bziBS9XKiwTAvOxKCRM+?=
 =?iso-8859-1?Q?yMy8gkOWXJ+kMzjKhndKwKG6n43pYPq6xz0XMGqO3gxxEhsa1dhFcj2xua?=
 =?iso-8859-1?Q?Qy8sUlJFl8dr48/BU59kLX6yUjJyaNdWqkLCo7jC6vbVZTO0p1BsFaIEg9?=
 =?iso-8859-1?Q?GqZe94BXXk5AcYY2BsHq0AjN3A7MnwAUg3sgsv3R/VUfX1Un5apRA4YwW3?=
 =?iso-8859-1?Q?r+fdQHDWDpEssrs/rjzWLfaMMAPG6q1CqZBHjoAMNQkOhamLBmUPCmnUSK?=
 =?iso-8859-1?Q?ixRouQHQAJ+mNZyvINHYq+/ygwYX4Rc4cE8TBigECM/twJyxtar71np4tA?=
 =?iso-8859-1?Q?zTDN06fIhxLcwMBV3odVI+zb6JJXmaA36s3hEOEXL6rpkS/0rTAYHzZqeU?=
 =?iso-8859-1?Q?+DopAUZINpad3mVjAqiMrSf5c+FYL+05aExmt05X6uhZ9hhI39xDCjGagP?=
 =?iso-8859-1?Q?D/Mpr6HvbBVLaroxmlmNDKe0sfsCWrRFtOV3BwrQgrGrRm7VwkBKPgN279?=
 =?iso-8859-1?Q?QlpCPe253UcI81b2+Egt3/QDNdBDbz37WbLg5woPgQU1ut8jT1TIttm1bM?=
 =?iso-8859-1?Q?VcEb0oSXA4H+uhvCy1C6/E0yvk6mE2vK35YHUg1taqli+mjKHx56dwTCNm?=
 =?iso-8859-1?Q?ibRbM/YPTrxdM3UVCRQgQuVehjVjRRXFFwkTu4PLfid2GbhxRaF7fReYQP?=
 =?iso-8859-1?Q?kimv130iL1VT+lMyUTfIDHIIsMiArQWB+NvsWQzrslIohky0LhO4tJ0y9E?=
 =?iso-8859-1?Q?/PUIv9lu3VlFGnX+3dOkbwU9zDgee4Os2gA/own3JXqlR8s8aJu2V6x5qS?=
 =?iso-8859-1?Q?stiVLZhArIci3GN7WLaYLhHj/yX7T22BHZxKmsVX0iLJJX86ZnJgkKI8zz?=
 =?iso-8859-1?Q?69KcB9ua2bmrxWV5NCZSqmH4yqzeb8aEVBXrvwIcGlXPeGOVLSeE38OfPr?=
 =?iso-8859-1?Q?KxKQOylGkIRbigwM/k78vMfcqSzEatrRrv+vgW7pQ6VLN9+ynWSFgasYy9?=
 =?iso-8859-1?Q?mADN1/owyU4Tt4l1uvJgbt8I6p7SVkVFJneZ2f3KjldRm6Pixe7pp+Cbit?=
 =?iso-8859-1?Q?SSElbd7c5ApDW7NsCrmG26ObOWMyIofRMnBWCa6F5fHtSV0tAZcHBdJxC6?=
 =?iso-8859-1?Q?huqknhRAnlJES9mA76Cg+bRKF7QGOMsyvU4FjvfJ1OcLAFwj7uZ+GGoc0h?=
 =?iso-8859-1?Q?/KG8vLV9oPsqbUGrDQh8MpM9Ix84MRvJSAPeYYP4G8O7VPIUUPkX/h1C5A?=
 =?iso-8859-1?Q?utnyX8apvB3BVyXuhP7Ogc/7isW9vKkPOdPgu8Q5ZGJs8RIhtxna3uAg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 893fac70-a384-4c5a-ccd8-08dce12c5269
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 08:46:05.6948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niOO5wIzT1HnXPR3MX1aZcX3gT2X15sS1uJtF8SNr9t020Lu3cSq1lfn66XBQQdAs8z5U2PolCbE3ce1s6RNIYxBbj2fYD8nQYCnD1G3E68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1504
X-Proofpoint-ORIG-GUID: s-d9bxOV6d8EtWOF283f_N9avSFkiy59
X-Proofpoint-GUID: s-d9bxOV6d8EtWOF283f_N9avSFkiy59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409300062

Hello Jonathan=0A=
=0A=
for the explanation, the chip variants at reset have a FIFO restricted to 5=
12 bytes like the original one. You have to write specific bits in a regist=
er to unlock the FIFO to its full size.=0A=
=0A=
The driver is writing these bits only when you configure the variant. Other=
wise, it will behave really like the original one.=0A=
=0A=
That's why I call them fully compatible.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Saturday, September 28, 2024 18:45=0A=
To:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Cc:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Peter C=
lausen <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowsk=
i <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Jean-Baptiste M=
aneyrol <Jean-Baptiste.Maneyrol@tdk.com>; linux-iio@vger.kernel.org <linux-=
iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.or=
g>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680h=
t/hp bindings to mpu6050=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Mon, 23 Sep 2024 17:38:44 +0200=0A=
Krzysztof Kozlowski <krzk@kernel.org> wrote:=0A=
=0A=
> On 23/09/2024 16:53, Jean-Baptiste Maneyrol via B4 Relay wrote:=0A=
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> > =0A=
> > IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.=0A=
> > They just have better specs, temperature range and a bigger FIFO.=0A=
> > =0A=
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=
=0A=
> > ---  =0A=
> =0A=
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
Ah. I missed v2 as checked by email address.=0A=
=0A=
As per v1 review I've tweaked this patch description to say they are=0A=
backwards compatible rather than fully (as the fifo size is not=0A=
discoverable)=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> Best regards,=0A=
> Krzysztof=0A=
> =0A=
=0A=

