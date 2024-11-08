Return-Path: <linux-iio+bounces-12051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE39C277C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 23:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AD81C21DEE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA471E2308;
	Fri,  8 Nov 2024 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EtRdtVJT"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84811A9B51;
	Fri,  8 Nov 2024 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104834; cv=fail; b=eyL8pvaB3K+P/MTA7TGAa/9D8dK+1oHxAD3LIeEiQrEsCZ/+btqiyDwlMkZbysj1kBHOMcvZ2EMcOMpW9ridbSvfcO+Z5burnnIel9ZCV7TIGrOYKvDSPGfd0+6dRn6Bn0uvMvZO1sDHrdbBNTRkXX1rKJvu49KniA+60z1P8Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104834; c=relaxed/simple;
	bh=BLHxuTpkG7dbYt5XzYkJ0Yu4vp5qkdQIMDw2s8yg7oM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=I+Bpa2oX/nak7nJs/k8rdagfTL2rJzYSoWnaj/uHeJ2Eo+FsOjrPixGs6wEA1yfNvDq8dOyKezE2cY6mlPwgiNOinoSqezMVbQ7Cg0D/SpcGwnCKHC/ITZ6mJ3DfWIzPq2oCcO7uFNlFZ/ILPhYFBAard04XDawmGQ9HV6rZ598=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EtRdtVJT; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O13PNJrQ6a6/vIngKY0hF/ubxk2YNF4YE5vOwyps4L/oOJi6EjPfCkNsqGuEfNDUTdKcTcM45t3W61RQJMwV6c6yUqRCSzA3FGLx9RKSQL/j1eWk+NQy7oWrOh0JVWG4BVx8AvcMTN0eeZrS3WZgpOnn47CmCROJC+IRuiBuxGZ6rnigZECeQ2oI09ozLZAum/qbIpL098Bdn30WS5MqsQ+BhrSXXrw1+aXotg3+unTKz2POynZvx3xFW4L3L4I7Hydc4JAd4nGmQfMGZROlnOox5r4OL6jaYcwMK7PdVj7x7eI6HUxyQsfsPcPOyf/+9PsAVZQjPPDpSbaL2Ekylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUWUjvklvmhUM4e6C1cwo9elC3NLt9e4u0YRiU7aHp8=;
 b=m3UG6tcvEcb+6cy+NnQu25EQZO/Or81uLr9db8R2BzxspXjqHoD+a/4K5bt+6qcxz2Q0D7XDyT8HG/V9lWe+0Q1qA3wPaFJ9t6y3d19Ttg4eTgsmBsJvkF5Nsl2e+eL/i2WQ4uxvT+6StuHTBewluSJyewP5YHnjqIevR2VyGnKVpQ234ufx7mxZL+XMIRU4sL9eDZMpfP9/QsIcWY9675NtgZfMTnbxsfsJ+CnviWcTJoQTZbX5ojfJ5ZmjV4+BdxjI/lY1pd1W7fZGLA7/wyQWtcy39GjWd3kNctcLmEjtT7AUGZUilBldcmuuVAKlBvICrg0MWYodde2OB96rlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUWUjvklvmhUM4e6C1cwo9elC3NLt9e4u0YRiU7aHp8=;
 b=EtRdtVJTO1PbMHd7eZGyK5L9g+O8gmrymhJ0Ll7mBB1VbVnhjytPZjTk3q94ySBxf5GnZGxAsJZfYwV76BCAPmhSrrxMVpnjusbrw13VM+SiKBYcWWszN5n+lKrgcO8KKQWsF9WtQD5ldNl44jxqoAg255ORO2uF4cWtocglS/mvMGi2StQCR6FRkauLhFt8CO7rH58MU9MVFVcOZAQiLeQWzg8hdF2a9sQIkRXgKq1osBkgNEk33hpAbA/Enfefh1vqACkLPRhi/f0Q1248zAuq6VHAJxb4eHzsoc2Pis4sFJgmNBgdDtmZad/J3NE8D4WZysp3XDCYHYCq5s3zQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 22:27:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 22:27:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] iio: temperature: Add support for P3T1085
Date: Fri, 08 Nov 2024 17:26:54 -0500
Message-Id: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC+QLmcC/2XMQQ6DIBCF4auYWZcGsAp11Xs0LhSHOosCAUNsD
 Hcvddvl//LyHZAwEiYYmgMiZkrkXQ15acCsk3sho6U2SC5vQnDFQrsJrjtm50Ur2ZvZcIT6DhE
 t7af0HGuvlDYfPyecxW/9N7JgnN0nVRXd9aq1D7eHq/FvGEspX+mn4A+cAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731104824; l=1682;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BLHxuTpkG7dbYt5XzYkJ0Yu4vp5qkdQIMDw2s8yg7oM=;
 b=Ja3Rw8obmdjQFiM80qvShFyeQrluBETbHoWK/ZiUJvmPLZXKVMhbm1kUjBghtnfZP9ltrN6Rm
 3Liz5hSSwMkBLQn0a+ORsIh221DiA4++6DEZkJIdqlL7I8w5jVBXeKJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 6566fabe-82a2-484a-337f-08dd00447b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFZ1RTFDckMvZkw4d3RrdnpGNFdPb3UrdTIyQVdhNDVRZTFpR0tGTUtFelVN?=
 =?utf-8?B?QTQxbGRRc1VCODlwUXpiaE9aMFlJNlJjcDNLS3VVRUU4aHBmdlVUeVpBbE5M?=
 =?utf-8?B?N3NMbTZwZ0M5clM0QW1uWm1nOUNDSkMyMXpFdnBUdDYvTTZpSlJUenF4d1Zv?=
 =?utf-8?B?QnA4S3EwalBLZ2ZYc3I1QzQ0ckZaU25mY3krbm4rUER2eGI5bXRkK1grcGJw?=
 =?utf-8?B?OWlLclFVTC9ZdkFBdVVNTk9rOUswNmtuK01WeDFXS0dWZnRpUFVxbHlTNEJL?=
 =?utf-8?B?OE9vOHoydUVRTW1FMmlENFRTbVJhcDgzeG43YjE0enpqTW4zZkpTSHZ1VGkv?=
 =?utf-8?B?MFZLY3dYMitiZ2NuZS90Q1NiSmlzdDRPSmhrUUJjMHJFcG9Sekt4MXdrWnNj?=
 =?utf-8?B?cjBEdUl1WkpOeW12bUowaW1xV0ZMeERzZjg3djFENkdJTmdwRjFJQVYxWENk?=
 =?utf-8?B?VHZZNXFFWGtGQS9rdk56SHhxYy9JR2IxZENnSzhkaXVxVnQ4bHVZenhBTjd4?=
 =?utf-8?B?N3hkOG5FRG1jUlJEOE02azduS01oSUdwVy95OTFvNXhYZmVqZXVQalVmV2o3?=
 =?utf-8?B?Q3lvWENXOWtPeEdxV1Y4MGxBdWhNRHZwSjJPSll3UUtGYng3bDJsWDZ5VHZn?=
 =?utf-8?B?N3l2TXd5OUVWd29CMzZuM0dXRG9CZ0gxK2lqN3MzQUp5OTg2VFJuMklQVGpY?=
 =?utf-8?B?Nmo2bjhsR0hnbEZFM1J6ZGQ4NWtNZ2MySFVYZ01KRjZhYVl4NC9UZzBLWnB2?=
 =?utf-8?B?dE1yaHB0WW9lSHdNNDNCbGFKL1dobHlQNFlCSGppM1dKU21Bb3JHYXJUTGpI?=
 =?utf-8?B?RkNlLzdRc00wYWFwOHhVTU40MkF5K0h1OTZHZVQ5TVhuaFAwNTN4RXI0eWZI?=
 =?utf-8?B?V29ubTZERGdkNWdISmdkSVFkYXNrN013UG5NQjBCdVByaUNmNXl5VDJabldS?=
 =?utf-8?B?ZXJqQUNaeVUxMCtBMVdtNDY1UGpHYmhjcVpQM2FDblVMcE9WbnlQOFBDd0RM?=
 =?utf-8?B?L1J2MHROaUk5YndtNWFhRnYxUUZjQ2lFKzVDMnNJbGtTMS92NmEwSFRiUStI?=
 =?utf-8?B?djJLZU1UbnovS21LQmRHeHVickZ2cmFVV1F4N3RWNnYzZ2VyVlRGYWpLeW9B?=
 =?utf-8?B?OFVVRTd6UHBoT3ZNOExrL3JHSEpCM0hQYkdQWFRYTFRHakRUVzdLdmhIeFcv?=
 =?utf-8?B?QmZML25sRWRJM3g5N21Mclp4Q2dXbHRVdmczYWNtRndmK2FuMGtnQzlnL0Z3?=
 =?utf-8?B?TnorUkJMenlpVDk3L1RCTGZ3a1ZGSmRoWk5hcU8rSVQrSmowZW1WVXU0b2x1?=
 =?utf-8?B?UkZzbFVySUFGVkYyaEFhTEVleDk2Slp5djFMcjB5MGdmZGNTb0tSdXFZK1gy?=
 =?utf-8?B?VC9XNGdkeUd2UUJMTWlPeTZ1UDFIY0JrbGkwaFdmcmUybWd5WmlZc2pac1Fp?=
 =?utf-8?B?RVZxbWFoQU5XUEhaQ3A2SkdFTGlRaCtkN0pvc0RxcGJ5ZkZEK1FneDh1RlhQ?=
 =?utf-8?B?bnhubXBNWGxnTUNRZjNjUk5CbTRYVFd5amNmd3BSVTAzb2ozZGxReHBEVys2?=
 =?utf-8?B?NFZRL09PemVaRURBVmwvdHJjK2NmaUFpRmV2Q0doSGdxMlFteXVKOGVVM0JZ?=
 =?utf-8?B?b283MzJ1RTIyVU8zOS9MK2pndWs4NlpVYVA0bjUreFFFU1FEUFJ4RmZPNFJT?=
 =?utf-8?B?OGhWM3Z2TzVVMWhrd0hxQTNCUElSTG12S1VzdEFHakJDOFA2RG1aZHJCYlZ5?=
 =?utf-8?B?VXc4dVhhN1k0aTJZZGw5TXJjOGQ2RHEvZHpjbmJJWUFpSFhuclUwYzdjcnBB?=
 =?utf-8?B?L0F6SWx3ZVZhY3h1amhTVmE0TUpXNjR5NXdyYVBsM2phcWdPdDBWNWkrbXJi?=
 =?utf-8?Q?2k1j4BBXwRghW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtHdEljMDlFR0Q0ZFVrbFhDTzVWOVArSHRsWXhZK3pNQS9vUFlLcVRNb1Yz?=
 =?utf-8?B?Sm5XWGg1Tm1qK3c5NWpUV1BJSVZVcFBPbXptcURwbWVhVzgzRm5ENWovMjU0?=
 =?utf-8?B?K0lLcU15MXNReXNUREF6VjFRVnc4dGRQUiswVnhSd0NTNEJwSWxPTlhQajZU?=
 =?utf-8?B?U0VuWmhJWG5ocUd2bExvWWNvWGIreGVZZlZhNUoremxpTTJROWRseWl2TFZU?=
 =?utf-8?B?YmZjTjI0T0V3U0tTVUpRQ2owUGVRT1dsRzBObWNFUHRMQTBoSTRxcGZRTDhq?=
 =?utf-8?B?WkZXNmc0UEl5Rjd1bEd4ZHZNdWNZYnhCNjhJbFcyOXJNUjBBc0l3cytkRzNp?=
 =?utf-8?B?OElqMDRRVitPcXVHbk9qYi9SSUFGeTBkMWFlWUhSLzFKdnRsbWszQWxEaUdo?=
 =?utf-8?B?STMzZk9jbW1Yc3F2NFI2Q2QySU1meUJncTVUMHMvT08xeTA1RVoxUlo2Y0x5?=
 =?utf-8?B?YnpKKzRzbXovbzZMRk56QU5ndy9iRkJFWUM5N1JPbmhGOTR6anNnUHFzNWFw?=
 =?utf-8?B?VjVTZUJvZmtSRU5PVlFkbnVqTnRGQXBORWRsUUFpRXJDdmp3R0RaelpUQ3Bl?=
 =?utf-8?B?ekJVQjUvK0Z5SEROQmtSdkU4N0hyRU56YnlldmM1WTg5L3RHN1VhcmpUUXJ1?=
 =?utf-8?B?WmFUdVFabDlmeEtmM1AxaUgvWTlCV3poZFgzSEcyMmpob3g4d3h4Qng0c24x?=
 =?utf-8?B?TjZPQlF2RzRsdGs3cUU5dFpJTkVURStMVnMrc3JDNEZoR01QZ2ozdi85MGVy?=
 =?utf-8?B?VGZ0QUtYeEVpTGRxVGpMWHc4NHpiWW5KcVJBNnFHZDd6NHdWd1FYWWcrWGcz?=
 =?utf-8?B?STg0aDg4ZnpxVnIyQVFmQWtHSEp0R3NqYWRRNnAxckloeThIck5kdjIvN283?=
 =?utf-8?B?Tkk4NnNqVFpQcVBXWXRDV3dUZTVtcHVkeWZ6Y1Y1RkxwWEMvdkNEazIvZkdy?=
 =?utf-8?B?Qm54d3JqUUpYS1NCTkNzaWd2VVMwdnRqdkplekVjSEsrQmMxYnNOdU9IZWR3?=
 =?utf-8?B?WUI3Q3crTUFLNXRVWjhEZldPRGRkL2wyanI3V2o1UmRYM2YzeUdIWEFwWS96?=
 =?utf-8?B?ZzNDS2RnNzBhNHdaVGw3cm1ISjZ1WTJYak1aNGFKZXVPcVpnSWlFczFsSmVt?=
 =?utf-8?B?MVJBQUh1VGtnMS9PNFRSQWRPcGZTTFFlMjRNUzE1TFFFUHQ1WFRra2dla3Fi?=
 =?utf-8?B?aGRBMDdLVzl6QzdvdXRvU0k0VjBsN29vUFlmdGVyd1hpZ1dIN1BDSGJtODB5?=
 =?utf-8?B?NFhIczFOUk01aUNXeUp6VVBjLzZNQlFnWnpiYytHSzBvYkdhSk8zWWR1aTJS?=
 =?utf-8?B?OGRnTC84YzZvZkNFRjZrZEo5ZGJVQTNIcFBQN1U5S0FiTGVKbGFYcVFFTm1W?=
 =?utf-8?B?eE9zV21IWWxpb1JBWE1YNnVYU0s3R1RHYkc1Qnk5QS9ubzFTelZnOXVyV1hj?=
 =?utf-8?B?OFdRK3doTHBBQTB5SHZlMGoyOEpJMHVLWWRtYzl1R3JFOGx1dkI5eGdMWW83?=
 =?utf-8?B?L1pQem93ckFaN3VJaHA3ZlFicHBlOUhEcXBOaXp5ZDVTWlRBTzMvaGdUUkV0?=
 =?utf-8?B?Uk9CbXEvZkJ0NGJhSnVJL1VSUXFZT1M1Y0Jua3dtNnVwRWg0VnB1dGF3eXFD?=
 =?utf-8?B?ekEyN0NzWGxBZHk3ajRpZU03b1I2VXhOWEMvbG5rVFVCcEEwSC9WR3J6aWx2?=
 =?utf-8?B?by9GSWxWdjFvUFk1ZmhBU1FEeHVxcU5WamFKaC9NN0JPQ0FNd0phRGRZeXJJ?=
 =?utf-8?B?QnBmb3BTV1kzYlhlb0tCTGx1LzBkcElIUTh1NS9MVVYrM0ZOSWJEY1JOOWc0?=
 =?utf-8?B?UkMrY2FoVjY1NGNsQlhES0Nvd0hhdzZWSW1xa3NmTkN6T0U1enhFSkh3YVNl?=
 =?utf-8?B?dkNxU3c0ZzFYbFpKcGpFbG5DRHN3N3JsbmtyTVFtQmhteC9NcGdSaWtJT0JE?=
 =?utf-8?B?bm1sMUdsNFluWDQwZmRLL2ZqamhyZitTQVViQVNmaTVERmdBWTlZYm9KNWtE?=
 =?utf-8?B?U0dqVy9mR2VFS1ZRSzhTWGltUVRDT3JWdmdkYzVpZXg3SmNpUVFtckJseW80?=
 =?utf-8?B?ODRVdXU4Zi8xWW9rVW4zTlJncXNPSUJUMUVneW9DZ1lVUGVYVDJJQ3A4UER5?=
 =?utf-8?Q?Ctr9dTg3i/Q3gSP50lP7Tdm4f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6566fabe-82a2-484a-337f-08dd00447b8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 22:27:08.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgVk4/ma18OUlkVAETxl+082iL434rEmGlDuhfDcGsSo/A8DzIYaCkSXXUxJUiBBZ8Ct1DG1DEBq28xwb/EcFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318

Add basic function support for P3T1085 temperature sensor.
- reuse tmp108 driver
- Update imx93-9x9-qsb.dts

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Jean Delvare <jdelvare@suse.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>

Changes in v2:
- Amost rewrite and reuse existed TMP108 driver
- Link to v1: https://lore.kernel.org/r/20241107-p3t1085-v1-0-9a76cb85673f@nxp.com

---
Frank Li (4):
      dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
      hwmon: tmp108: Add help function tmp108_common_probe()
      hwmon: tmp108: Add support for I3C device
      arm64: dts: imx93-9x9-qsb: add temp-sensor nxp,p3t1085

 .../devicetree/bindings/hwmon/ti,tmp108.yaml       |  8 ++-
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts    |  5 ++
 drivers/hwmon/tmp108.c                             | 71 ++++++++++++++++------
 3 files changed, 64 insertions(+), 20 deletions(-)
---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20241107-p3t1085-fbd8726cbc0e

Best regards,
---
Frank Li <Frank.Li@nxp.com>


