Return-Path: <linux-iio+bounces-10045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F7B98F0C6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 15:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95481C212D2
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C547719CC27;
	Thu,  3 Oct 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="V3zE2C83"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B14154C12;
	Thu,  3 Oct 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963269; cv=fail; b=jq+n4kyc91AtNXjhzjmz/7MGJpseXRyfZ9NXmfBpXlrh3V4pGRep9zCAt2jtpWpN4aki+tFiRr8wa6cJ0sQtkQDDFr8uIsDSDegA/hrwdymZCvVMhgPxAF4TZnKqzCShAhwJzOFh2BdBjSNHMgVLqm0Dk0EUd13/lIGLkYwGnsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963269; c=relaxed/simple;
	bh=a/NPT5SZ3F+lBcvdjhnjZgJfpra1+SXtSDxjeYt4Rtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MwrIWawF/zWSxaTPUZlJatF6sYLISvNSVaJ8VucWWeporYhOpKzyLU1NLTumcIYSdNmShuD4zsasMqXlACryGpTDy/ASRq16tbXYXppmTz5qUBrprT4X+15Pmey61hbOjlWb0gsmszm4a9vv+tBDc0ji9yAieYXpn6LBPWrsasc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=V3zE2C83; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493AsZee015518;
	Thu, 3 Oct 2024 12:50:00 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012051.outbound.protection.outlook.com [40.93.78.51])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41xb5jbjv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 12:50:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB6+BxpyEOFXT7oC1xLDJT48n1NnTbkaR5u8LRhj4ag+hO7pRx+fl4R+6sjmVIxo2gOL1V3xxJXMFW73uYR+s0mmlPz9/BxXTw8OMAC1mPfKLvjVdm/NnKVY5KR8ZVIELvqWxigNfWbLa4RAuSkfzR9Cq9VoMILlcTdkYRHANZ3OH0LT7niegPIA9FS1P4FgdZTJqCCwZmkueVJm1jXlIuC1Zr8Z1syPdM2/m7nWq9b12BT9ISqHaRUbu8oCFZnyv2lK9a365IrYIv0q2CmVwk7ruf62yS+botHQQEg8az//AEGQp3WDxjBgd1YLkYl5Jr6C2Ad6G1sabyyeJ6gLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/NPT5SZ3F+lBcvdjhnjZgJfpra1+SXtSDxjeYt4Rtk=;
 b=oGRVNzxRFHSYOyTgCEWeKB1vEZsmzTe8y5/v+WKoIh13gWVV5bh3hFARcvEfwf6Kn+3DtLx/EwhdX3sWLrI7wx8Qc1LQHvOla9ODgy7Wk1uLQv5ftOTRk6srIrGSBKJe04j1Zjr0vtI6iiIEl//PmVTCxdLV2AXq7MPEUWOksNENXcZiv66OEP1rBaFRH3jxHwAFjTy9Z/ImbzfgQXpobvTF2aEPx3j8eLaEKfPvILeL0UbCIp3PJALpy6mTBvQigbtZAtq2ccZibgXj7hbXD8NE6oGOUbjF185hqaslKAE5ZW9nCBFswcm9dfLUNPxe6IMJOtCAmJSBIAPVMUlZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/NPT5SZ3F+lBcvdjhnjZgJfpra1+SXtSDxjeYt4Rtk=;
 b=V3zE2C839ywdsMwyCzPYxb+hr0vTGBaKNkkFu6I9glkBCOIJXdsG9GxDuOffnBcPodHijh9NjzWEJ2n7L/wbT4djbc9iS5ZY52mlf6vj95visJCnFgM3H3yUKGfqoyOe8/FfxGP2h3DAen1R1E85GAq/MTntZoeCkCqr77PIAvOfkjTHtXjigW3+PBfbV7l8QPtM6blQuClgMWgrw+5j0A/s/VAelpnQ9ePILewMcTaE5aAFMxeXKCN21W7dPIxCTKVUlp8iawHiXxhwPNI3HnwXTNT9JV1dRPJ/IhpTW5kf37luMtbSXsyUcSqOP6kP9ZEHV+z5a2LXtx4rUR1fUQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR5P281MB4583.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 12:49:56 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 12:49:56 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] MAINTAINERS: iio: migrate invensense email address to
 tdk domain
Thread-Topic: [PATCH 1/3] MAINTAINERS: iio: migrate invensense email address
 to tdk domain
Thread-Index: AQHbFWcw5EzX7ero20u5ra4h2G70GbJ0pY+AgABTgEI=
Date: Thu, 3 Oct 2024 12:49:56 +0000
Message-ID:
 <FR3P281MB17576E4FFFDB3B61677BB1C8CE712@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
 <20241003-invn-maintainers-email-update-v1-1-7e4062ad68cf@tdk.com>
 <b8a359d7-5043-475f-95c2-0bad2a9f6f92@kernel.org>
In-Reply-To: <b8a359d7-5043-475f-95c2-0bad2a9f6f92@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR5P281MB4583:EE_
x-ms-office365-filtering-correlation-id: 10147006-840d-4860-9955-08dce3a9e270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pkAXJs7Ozq5hDTXU+d8cRozymIq8cd+zmehiijx+d41SH9p16KDgN0Rcf+?=
 =?iso-8859-1?Q?AfDw44X5JH23IfBZcpngJwGBMcqzC2zx2PUPUS6Hqlr80W+nRK9WiSMsWt?=
 =?iso-8859-1?Q?Y3qhiQNGu7mKv/xS849mYD4hJdGix1e8NJlDRgMcB+qv2hS5pEhV/Up55i?=
 =?iso-8859-1?Q?THnRWpuVJI9dlw1v7+gmaV0Y9EJARqnsALTFIkj88K1m9afIiIUya9nnWL?=
 =?iso-8859-1?Q?9GswtRkSMILke7tryQPtdEvX85f38sJC3kNmZ7OHT1uQ+wgIOUrGi/u+6Q?=
 =?iso-8859-1?Q?a+KsRIG4H7FrXaRt3Q1hpxzJDBgY1Xrj5X9vSy9EnJ5S+OFLep/cF9yEAA?=
 =?iso-8859-1?Q?eCmnV0kaV4HJ9MbSsAqlloY32rsSLSXHu4bq+GYqM0n7XGt8ZlOtfRDAUN?=
 =?iso-8859-1?Q?FWHl4vH/ypXyE5tMl4/ohdO1UnJtBcQZ0YFr3Z0m/fQZZ/UkYeNjA6CKX/?=
 =?iso-8859-1?Q?L629AQJTI0MvLaUMDV95LbntB7CywdIYwL1bUWNz5XY2jpI9q70tjZN9ZD?=
 =?iso-8859-1?Q?SAZn5bApvgJaltJIocXKV3/pxoPbfEdCEoqqzt9tJtrfkkkOtKysAKJccB?=
 =?iso-8859-1?Q?frjGwhEwZAkWlMl2ClMYtardvHGDTst4TOHm/oPPK0pPqLAnDiBzt6o22x?=
 =?iso-8859-1?Q?EngD3lOPdoLsfJ2ED1DtRmHBswuQiVS13YY7ze23+S/RYO19yxMzA7HZdC?=
 =?iso-8859-1?Q?lNuqsbwwzArXKbtqLHeGHrM+Zl7T1q93LhMDAis1dSlooW0HiY1PmPGuKR?=
 =?iso-8859-1?Q?pZII8D34g30B5TII0H50/w5PBJ1AJmSsmmpdm50zXvXdkzURRg7tJwWuHD?=
 =?iso-8859-1?Q?sLP/J3Gub1JswvzPzl2Pcx28xjqn3o5pj/gTohJt/Fj/FYwlQsri41sGde?=
 =?iso-8859-1?Q?w08wycjZqhr5GO4skJ0qqtQFYBYDB3ygogDDlhslLdOGSdyfgQGheo+j86?=
 =?iso-8859-1?Q?liZYVe8u5ANHCPaIMdoV3vcxx6Ea5PGjkqODQFPYZc5oeD82zi4kPiv2de?=
 =?iso-8859-1?Q?DfnNLUY4w92iZoiS6l+bJgPpQqaIIT2yD6eg05LRU/9TrWFaEdHhMgTYsg?=
 =?iso-8859-1?Q?RiA3JNJFizlwaVjCFW3fz7LEZW4DMYnIrstV+sIhx12h4bO6+olU3ZlL3Z?=
 =?iso-8859-1?Q?uE+TwUellGK+2k/V2Mu7Lpx/D3LZyn/rGlTBQtHjF32Db4URKGeHydSQF8?=
 =?iso-8859-1?Q?QZ3NJGdmDEUAHHD6UmSJO/k4JGefugHVCNCBVuGqBDPqoJ/nefzq13Ccts?=
 =?iso-8859-1?Q?oTGVKLBzOhX7MkrCRYWTsoG18Nmq+E1uZTlG5U7fz19c/Yewjlf2UH2Q8J?=
 =?iso-8859-1?Q?kdkCbFQ5DdXlNpRH2BxH1bGvHSqZKUnolYeVK0uVSYWSeSKs79qLfDYb4o?=
 =?iso-8859-1?Q?nO1Xf7hMif4yRNw7cLJG6no783RGlKXw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pf6s2FoVloubFzDWXijTe8vxAyMtyUAiCUwIT7TGHXBbHV5cAp/zaJmKpX?=
 =?iso-8859-1?Q?Yf+v2HNkz73q8duo4647F2KeQAaIwG3ILzyB5dPR2zArpfAwkoWssDcEFN?=
 =?iso-8859-1?Q?Q28iqviPeMHtzRZYOA+kK7iZWZjYPPyG6cooGuh2xm09WpUyvej8ODvqqu?=
 =?iso-8859-1?Q?KnxwM4gm19xrwmgdrzD0MTCQwwcakwJX4b0PHOXlEZkikciaRdpwTJMM2O?=
 =?iso-8859-1?Q?TV6VqPyyJVgwBxjt5PbeaH99vK9pIiKhbguBsGySHqly7pMP7a5vHhRNiN?=
 =?iso-8859-1?Q?Oz/zE5Xy6fF1rdtmTuQsEbzCBziSZSvuIqJsiu+un8DIgRvitIuL3Pfpq3?=
 =?iso-8859-1?Q?De3tVlVlOA/kvzMXfkEgvElZ4t+TDlIbuvWop7uyOjwQnepj/mksZPoF8r?=
 =?iso-8859-1?Q?4GGl3/zAeuhBuvUjRQDbiCWEr9QLedina6CbfeZYqfKBIaxwWKxgonWY7G?=
 =?iso-8859-1?Q?rnk6xI5AyoNK+Znp5rIvXtKxOMU8ZqFLaNu+/PqRXLdCMEC5tT/8MCifuC?=
 =?iso-8859-1?Q?Q0O8kMd/uJCf22k+Ngiz4HT55CSbQGwn1a44KfVxVYpKyyh50rxFVEMtkq?=
 =?iso-8859-1?Q?rDrQdYlZtCcthfTS+d0/HSSXwahdFGRvby2iMccF5rjGvAQxrkHz7N+mZr?=
 =?iso-8859-1?Q?cOq4ufEUW9MOfN+jYbwyGmqJe8yHDUcfCe8W+FjRyn0mZU4Do61t4jX10A?=
 =?iso-8859-1?Q?Inz4tps++xSWJJMKwoxQqVm6W2XA/EsusIllnxeZlGD9o72XhYKvLTbZGy?=
 =?iso-8859-1?Q?S2vgMIFN9smgeJ73lXC+Qj+TVFxd2LkX1WtO4P2B2Z3iQq63AwWJwRUm+Q?=
 =?iso-8859-1?Q?W11O2bN/K2kF0TTZxH5XkwyvP0K/AUX2gQ7YX4KLCT8v9QntGa0j1Dlmv3?=
 =?iso-8859-1?Q?YG4fjIaROof6Ia0lYF7pNi1n1x698E1gwp55+zHLhM8siZIuNwD/+SMHQO?=
 =?iso-8859-1?Q?xHGngONQ2If3CUyhRgpj4S0PJE7jlRo3BPcfgwzv+gNWQcRfkABRtWbIFn?=
 =?iso-8859-1?Q?yB6qxl9QMls2xFQP0I+1OEc6Dl4hjVwFTLx+puhJCKq3rQ717M2eM58S07?=
 =?iso-8859-1?Q?EM5LwU6GMd13PkiR3eT3VJdFw/JY6B+Nb6yeVTyhHtwFY5bTCTAoc0JswX?=
 =?iso-8859-1?Q?/LMqb9oWDkMhn8f+PLadly0YrlQr2+SGblIs9Y+oBsZzvvvp878gXxaEG2?=
 =?iso-8859-1?Q?+1t4ebHfbNHlBkFnOkuKLUAbz9ysn/yOoH8iqwmW3WEntTyST5/tbDOgUy?=
 =?iso-8859-1?Q?9HU6HNVAmopRqkGK+Yg2xUrXqX1gFereRgYfw7htT8rbkfs/+Bcsl/sZlj?=
 =?iso-8859-1?Q?B1qhrShQSMXOICxi8fTskaHJJhp4vkvWGd5A43Fmlxyd2PzekMXM63b8Vi?=
 =?iso-8859-1?Q?SYqDqfzkZP+hkCsXgPrc020XGjwi/3SqdHQB2f2CO+dEBxMKECEhqr8yJ+?=
 =?iso-8859-1?Q?UPHvWWRnxjc4jEq2zpzoBtaB9HyNV6l8sxSr2PT13FKP7NcJRc1cF0PiIe?=
 =?iso-8859-1?Q?Zx7+RPFUZV5qFNMzH36reOLT2DCcxr2oToS+JGyVi4AUVCdBhkg94Py407?=
 =?iso-8859-1?Q?e+zPDPUpBVs2wkOshn28guNq3YawPEGVN41YEecwynSbsouv6wmVW79iSB?=
 =?iso-8859-1?Q?WskSSe9zb4B/ibX/4ELSDSaTzhUM0pz2En0GH5scsXLTrgOmwvo0UmDA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10147006-840d-4860-9955-08dce3a9e270
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 12:49:56.7455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUmZiR3q5huWl/Nd0bfiuhYMN9okqcsN71bKiuvHVKu/ESREwxiCXo2qIvvLd0azSxFMJ1g7Q5ae4hfF0a9YdgsN1sKobyYn42uTybSw/NM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4583
X-Proofpoint-ORIG-GUID: Ulr49mSILIJwfp9XBBInD6cQd_eBq7Ye
X-Proofpoint-GUID: Ulr49mSILIJwfp9XBBInD6cQd_eBq7Ye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410030093

Hello,=0A=
=0A=
I apologize first for doing a top response, but I'm stuck with an email too=
l that doesn't allows me to have better response than that. And sadly, I do=
n't think there is something I can do about it.=0A=
=0A=
In fact, when trying checkpatch --strict I don't have any warning on my sid=
e. I was using in fact checkpatch -f which is for testing source file and n=
ot patch. I tried upgrading git to latest version, I don't see any change. =
b4 is version 0.14.2.=0A=
=0A=
=0A=
./scripts/checkpatch.pl --strict test/*.patch=0A=
--------------------------------------------------------------------=0A=
test/0001-MAINTAINERS-iio-migrate-invensense-email-address-to-.patch=0A=
--------------------------------------------------------------------=0A=
total: 0 errors, 0 warnings, 0 checks, 8 lines checked=0A=
=0A=
test/0001-MAINTAINERS-iio-migrate-invensense-email-address-to-.patch has no=
 obvious style problems and is ready for submission.=0A=
--------------------------------------------------------------------=0A=
test/0002-dt-bindings-iio-imu-migrate-InvenSense-email-to-TDK-.patch=0A=
--------------------------------------------------------------------=0A=
total: 0 errors, 0 warnings, 0 checks, 16 lines checked=0A=
=0A=
test/0002-dt-bindings-iio-imu-migrate-InvenSense-email-to-TDK-.patch has no=
 obvious style problems and is ready for submission.=0A=
--------------------------------------------------------------------=0A=
test/0003-MAINTAINERS-iio-imu-add-entry-for-InvenSense-MPU-605.patch=0A=
--------------------------------------------------------------------=0A=
total: 0 errors, 0 warnings, 0 checks, 14 lines checked=0A=
=0A=
test/0003-MAINTAINERS-iio-imu-add-entry-for-InvenSense-MPU-605.patch has no=
 obvious style problems and is ready for submission.=0A=
=0A=
=0A=
What are the errors you are seeing on your side for these patches?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Thursday, October 3, 2024 09:45=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Jonathan Cam=
eron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring =
<robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <=
conor+dt@kernel.org>=0A=
Cc:=A0linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-ii=
o@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.kernel.org <=
devicetree@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH 1/3] MAINTAINERS: iio: migrate invensense email addre=
ss to tdk domain=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On 03/10/2024 09:37, Jean-Baptiste Maneyrol via B4 Relay wrote:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> InvenSense is part of TDK group. Update email address to use the=0A=
> TDK domain.=0A=
=0A=
Please run scripts/checkpatch.pl and fix reported warnings. Then please=0A=
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.=0A=
Some warnings can be ignored, especially from --strict run, but the code=0A=
here looks like it needs a fix. Feel free to get in touch if the warning=0A=
is not clear.=0A=
=0A=
Best regards,=0A=
Krzysztof=0A=
=0A=

