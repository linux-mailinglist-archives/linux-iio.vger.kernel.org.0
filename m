Return-Path: <linux-iio+bounces-15710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC16A3871B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68943A7B94
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120A21CC74;
	Mon, 17 Feb 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="UvViiWXN"
X-Original-To: linux-iio@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022086.outbound.protection.outlook.com [40.107.149.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB021B199;
	Mon, 17 Feb 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804219; cv=fail; b=jOKt0Aawp/+Aq/STD1dd3evo77B20Nky0Xycj/7Ub0CO115E52j3VhtE5Fvi9tkdd5UniFoDXT1DGRPpslJiOR2dtrdEezg680Gf0ldoS5VK+a4IB8VkisEkxJHvUbdtmSoqTFAVk0UbGINoeQ4sfuaXwEw+iR1qHXFyN7YQauA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804219; c=relaxed/simple;
	bh=olo20qZqLYJ2OL4JAK4FFJew4tDM6Hgs4XHnM1UiOUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJElExyhb0YVav8aqW7QSsu8dFE7BGxEP3bFuImTjVfPnJ1Zlnfz615Pw7jaOHxsa7fBuQqBf97hfIsw29aWL3XcEp/LHuidYinDzSLC+g7hSIbC5ihmkedyTk6NpQM0RD2fkkbaNvIeBNU63j5T/5aCbBtxDbSFjdPRiWjjvig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=UvViiWXN; arc=fail smtp.client-ip=40.107.149.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3D6OIyxS0UZQAJa7FdDF2E4Oz9lZ7PcyXUkrF/C0pwOMD8a6j2LX94a8aVK6TsWYO23igfod0xkyyUqk4JfaW1DN4ARqX4SYsIgd3wZnvVZIUxMsEbfbWaAirKYSrD/Fk2qsE119sSmlvea4wsy03lizsO3WkH+Xg/HuoUB8mflTmimZkvoIU+hOwwMJOq5tMwszZKNBfTZSgF8AkDub/CdVU/cWLFyIYkX9Y0wJBgdngRYMxnvLlInGiySewtMz8ebrlnX6fJC3AXYMzsEm5Rz1UBS01QkjwNtjyOvvLGeJpf/jtwnDrQrn9WeUZc4vVLms8YbV3o5QRYvzrGmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olo20qZqLYJ2OL4JAK4FFJew4tDM6Hgs4XHnM1UiOUY=;
 b=SNbtGtFF+IaKE04L6C4B6e4gUgKOfIpGoPo7265rahXFdfaMXxs4RmgkvA8F69V4y08fL90vKT9U5RDX+njrxzMh0groeEMPc29JjndPFxLlNS3P8eWiphNOsiV6Tw1J+PNFW2vY0+Rj9pg8PR6NzfQST5ZkGrMnZb0b6FuNRPUhh0hg5dmtuvcCg1fQGGNzcvWhjw8hy4aOYOB//FbF6Fv0gnp0h6+bD5Ffs+2MBvU+Dcm9jF4Oo183nEb+jvIsh0K6NH7YYanOu2Ovi7vtf10k780q7GWG14fpBZjeIwkKLy27FYkGtrn3vmoSw+S0/CKnRgeWtJAIYKjXVWZcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olo20qZqLYJ2OL4JAK4FFJew4tDM6Hgs4XHnM1UiOUY=;
 b=UvViiWXNMOXKaHX/8J90si1R66IS3nczXMgEIB3SSpfUFdsrW8eYOqdsIggYBECnXpMy9p9LerWIKG/6a+kbE7I/E2wDlZfQmRjsxN9GMPnNaP95p71BgsLKHzA2exY3sV7tYtgSaBz6Df4fMaiRkBAP8kHaCS1csMkz6QJ+Wvbz7GnvNyyJbxaVPiP6afkeOAL5iVrHwImxRmq7T4DcKaLkGFokQjrT3zvV0E+WXqxRVK0PwlggsLTpAjFwgmGmqBDkNL3t6hbHBz1ETXxgucpB6EMSbyNKiuxQ/tZb7xUyM7r5Q8ryUkxaSSNfAr/idQO0Pvk/LKqsypYcWYUwNQ==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 BE2P281MB4621.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:c2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.20; Mon, 17 Feb 2025 14:56:53 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 14:56:53 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/2] Support for TI ADS7128 and ADS7138 ADCs
Thread-Topic: [PATCH v4 0/2] Support for TI ADS7128 and ADS7138 ADCs
Thread-Index: AQHbfjA9cRoIl5SFokmErreVOmBo87NKGccAgAGCMyA=
Date: Mon, 17 Feb 2025 14:56:53 +0000
Message-ID:
 <BE1P281MB242028CC2123871D0FD167A1EFFB2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <20250213-adc_ml-v4-0-66b68f8fdb8c@softing.com>
 <20250216155436.239a4b35@jic23-huawei>
In-Reply-To: <20250216155436.239a4b35@jic23-huawei>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|BE2P281MB4621:EE_
x-ms-office365-filtering-correlation-id: 334d21c5-5d44-4931-c8d6-08dd4f6350d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlIrWE9LeGtPTE9rTSswZWROUC9KK1BYQzdvajBxZnhDKzlmdlk3QlhRYk9K?=
 =?utf-8?B?eExJUE41Ynk5bEd0VlJINHNmY0pFR2xCNGNxeWJYblk3dXY0Vnd0Rzc3bmhZ?=
 =?utf-8?B?R0MxRVg2anhQREFvemQwSVJRZEtNUmN5S3dTd1dWVkJtOUcwQWMvN1d2bWJT?=
 =?utf-8?B?ZEZSWkhFb1hrdTVSQ0JlYVpvallNVHgwdFhKQU9obWFNQzJDTlBKRWJBdlpQ?=
 =?utf-8?B?ZityRXFZNGluZXNpdGJtdWc2OXdRSlkzUkhuZzl1N01rVXR6c3h6T1ovbUFx?=
 =?utf-8?B?c01rN3lsRUlRbWZkSjdqbXEvUW8zdXNLL2VEZTdoNkl4ZWpZYzNWcUZ3OFZa?=
 =?utf-8?B?akFpQ3pVNmlIRjkzY0J6QUlQQjA4VUZ3MWp2a2NEUWVhdXZ5ZVBKdk80SzFU?=
 =?utf-8?B?Y09NdTROdkxMQ3RCNGxQeDQ0bU40a2xWaDF2QXVxaUQzQjQwYWM2Q3NWNHMv?=
 =?utf-8?B?dnJORzNZVy9TaXJFcDlacmRsZElpODNSN0UzeGFwamhsWDJUb0JwblRpaGpI?=
 =?utf-8?B?Qm9oUFdlSWR1Z3k5QWFrZUlUWnN4cTJBMzNkZWxlYm8vZFpVVlN0R0dESElI?=
 =?utf-8?B?eVgyWGFIWkJtRmhTR0MxNUxqclpick4va0o4V3BmS0FEMEozcXk2aEpYNEhQ?=
 =?utf-8?B?QVcvOWRWUExJM2ZDeFpnWnRSaFFLcjdpTFBXdUY4c2pvSmxWOS9hMjA4TVhZ?=
 =?utf-8?B?WHZySUtMZFBRWGlUT25GTEM1SmJpUHUzeUhzYzVuMGlDQ0d5R2JyeG1wMEhz?=
 =?utf-8?B?UWpkR1BPendJckVQNy9qT2kyNk51ZTZZY1dBR2tCUHRlWkFOeW4wbWZaLzBR?=
 =?utf-8?B?ZVZZYUVkOFdOWmcwaTNQbGtMeXhaa28vaVRrbWdoNk01Qk5ady9wMHNacWpY?=
 =?utf-8?B?N3g3M1NwYjExMmVuWU9aRXd1aFZETWdRZzc5L1lzcmViVzI2SzN0djhpYlJL?=
 =?utf-8?B?SVNmMjFseWFOcjU4ZWNwQlpFQW5ob0RobFluM0RucS9JdU5ydWVPM2NEMk4r?=
 =?utf-8?B?ZUNVbUo1NWtHMmFXeUE0QmV4eFRJOXVEVWlSVENCZ0VoY0RuM0EyQTF3dEJH?=
 =?utf-8?B?Sm9oa2RrU01DQ2FBalJaTzZxcU9HMy9JdWxhQWNNNTVlSWx3dkhSVUFMZDAx?=
 =?utf-8?B?MEpsQ2ROQ0tENXJtWTB5SUxORm1pdmtWYmwxT2J2QXhSakJiay9Pb3BIUk04?=
 =?utf-8?B?ZnJUVUxrT3dya09YdVczOEwrQitFZjRUY1gzQWViMWEwZ2p2N3VCb0NzejU2?=
 =?utf-8?B?TzI5K0pEbGxTN2tuNW9tRHUyeVhEZjNLZGtzWHpyYmVQeTJSV0tTbjlDV2NZ?=
 =?utf-8?B?UThYS2VudWdpUXNUZEUzZVh2VVcyQzdBSGhDZjFtbjBJRHgwUVlNdXo5VCs2?=
 =?utf-8?B?Z0Q4T0xzUWZNTEZyTmpzZnAxSDN4QUtzMWRaS2N1aWt4UTFWdE1iUjV1cnNi?=
 =?utf-8?B?Rm1iREk4U0NROVBjKzVrQ2VLcmthOGhPeC95a0FDRDJGS0MwMkdqV3RSeFdu?=
 =?utf-8?B?L1oxN1N2SzB1RnB0R09NcHg3b2lQb3lSaThVUGZKc0dzNkZjNVlUenEzTlNG?=
 =?utf-8?B?VVRjSXB4b0xDQ3E4OHRGcFJRMzVTOURrTmQxb0J4YUhvYUJROFBoWlk2ejkw?=
 =?utf-8?B?cVlFMTdFVzhCa0kxUWRiNmZLWXZ5UHNXZ2JETHNNY0RDQlFoK280TzVnaWxH?=
 =?utf-8?B?UXpaTTQ5dnkwVWJrc2w1SFZZajlkQnplZFpSb3lXRjZKSnZoeW9vQXZFRmU3?=
 =?utf-8?B?TnhOb1QzUUFVVlZvZldLTlZSSVg1c2JSbnhNTFg3ZDNpb3IvalNDUzJuMmRl?=
 =?utf-8?B?L2RObFg4cGhwQWNubUpMNWt1eGlZRDZScWtEQ1llMStZNU5kMnJBSGVjcVZr?=
 =?utf-8?B?R1BqVDRKQWtvcmtvRUxicnBiYythYWNRRStRMVEzQklhSG04TUpVU2lDNVpx?=
 =?utf-8?Q?yZKnL5IAvYC87ZuCjEtEkXNmV0Os9ggw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVBjT0NRZVhWTENKUkxRVGZxRGZuZEtFbXJaSTBIT3Vtd1pvWGpieThxbmtE?=
 =?utf-8?B?SmhQbVQrZTVPMHEyRmU1SEpoT1FPaDlVM29STEhyMnlkUDUxWWFEOVRJQWZp?=
 =?utf-8?B?TVNNSFYyUEpqa2tia1ZHb2YxcU5jaGNvcTFLdlhraFhaMU03OHZpQU9JdWw1?=
 =?utf-8?B?aU0rZmxPU1BOQ1M4UGlnTlREdGk1TFFsTXlaNUF5MkJJKzJGWUNpbHI5THZw?=
 =?utf-8?B?Z2hJbjJabTc4Qnh0VTQ4TEhGUStVVndiUGMwMTNuajZDNVFjb0VyWFF5WXY3?=
 =?utf-8?B?VHVNTTczY0lzUmtjbmZRbGtCQVpxOG9VVGgwT0h4MGdRTEdkdkZ3cUdpL0pF?=
 =?utf-8?B?cDFTVm9JWHkvcU5TQXZOeis3MW5HdTcwUmY3aldsOVUvZEY5YUo1YWlvRTB5?=
 =?utf-8?B?dEUxcE5SR3pHQ1J3VEpkdnpTbWl2aEtwK3V6WTBjaVc3OUtlNzJLWmVFUDUv?=
 =?utf-8?B?YXJ6U2dJdnZ1TThkb1YrU29sdHdhalVjTWVtRFZUMUlOMzBueDFUNXBGa042?=
 =?utf-8?B?eVl5SkovSHJab0hRR1lSUmpneFRKRXJ1M0Jtd3ZjOS9HYmlWc0VyTVVjQWxD?=
 =?utf-8?B?UytnY2I0UW4vdDFjcXl3alRZZGpLL1FLNE1OdGJ6RmhOaGRlVVZUcUQvNWlS?=
 =?utf-8?B?aEkvT1pHMXI2T2hQRk85U2lPT2xsN2llUjFUajQwemQ1T09XSXNkMzl0ZjFk?=
 =?utf-8?B?ZElsWTJOVk5aN3hBY01TblJFSElPdkJoWW9vMWNPcHBBK1dnTXRSNlNhWkRJ?=
 =?utf-8?B?eC9FREhPYW00b2ZQSkxVSmo5TllsVmwzTTVFTXpVcXJWN1BmY21OUkFwRm9I?=
 =?utf-8?B?OG9hMCtkN3pFTmtPYkdRVWgrTUtsZTh5VGNaR0VrOXF5cVkxTzMyR2hYaElO?=
 =?utf-8?B?dklFTjlKczZsd2s5MTBDZm0xN0pLc0tERTQ4eklDWEVLQStNNE0zc3ZUeWtY?=
 =?utf-8?B?SHBEL2RraHlnR3Q1V2MzODFab3BWWVNTTjJqNy9wZU03NFdDSTRkMHFlQzB0?=
 =?utf-8?B?NzIrYkFqYjFSSmplUldNc05RRHAwbHNmaFNkNVpEYkhOZU44MjIwVVBndHJR?=
 =?utf-8?B?UFNpVjJYUGYyU3lUaHo5WCt4UXVpRXc4VVJZZkEwM2FTM3pYVFVCRnk4bmZQ?=
 =?utf-8?B?eUNWc3N0aXlxSGJZUUIyWlFaMTlCdkl5VEQwNEU0d042SGlFaW5DdGZZUS90?=
 =?utf-8?B?VVRpNDZoSk8wcnR0UjFzSkMxbE82VnVwa1JOTDRLd0NEeHJJZVVaUmJtQk05?=
 =?utf-8?B?WjZXcEt2THFYb25zSkI2YWx6L1pXY21WRlpRc0QvclRTcU5rQS9uY2t4SWli?=
 =?utf-8?B?VUphaU5qYzlmYm1rMXNEVEJDMkVFV3g4Yzl2ZjhiYzBNMC9pK3hoWk9VOTVK?=
 =?utf-8?B?NEphc1ROOCs3Q2oxdFFweHM0ZXh1S0hGNmFYdi9xSGhKUHorR2VFN2kvbTBY?=
 =?utf-8?B?VXBsaWhUdWtRNk5MdkljWlpFOVRiNWtqL01lVDBmT29aL3lrV1g0TU0xaitH?=
 =?utf-8?B?aFIra1ZPeVdqaTk2dlhRNFpsVmt5cXREVU1qNzY0Z0luNklPL3U5ZnhTWjR0?=
 =?utf-8?B?Nk9CQU5nckZxbzRrRE5xNkVlcFVwNXArTTA4akRtMFAxQ3dsMzRvSjF2cUYy?=
 =?utf-8?B?alBMRlFZQ2N4b3BmVDhHcFlhLzhzMjczbzlwbWEzaENHTVRMdzAwQTFJMXov?=
 =?utf-8?B?MHRqZGsreUNSSkV2UC9NMmxIMVdOVFZYRHBiQVF5eW5XaXNmOVpnY0Mwd1NF?=
 =?utf-8?B?YzJjVXBNS1FNcDZXMi9IRVlyTXpING1FK3FjZjg3MEdRdFluSEVaWEE1Q0tt?=
 =?utf-8?B?cXhYdFArLzlocUVTd2ZkYklpazdYWlRzYURmcXpXaENmZWRVVmRQUWdvdWQy?=
 =?utf-8?B?MS91RFlSNWZlL0QwcXQwdVJudkhrSC9lSHNkSnQ0b0ZlZm5kNGczeTRveklC?=
 =?utf-8?B?Nm81NnNLTVkrSTBDOFBTSnBwUjBzc28rTjFOZXhuQXNMekYxQmVHUXVQN25t?=
 =?utf-8?B?SXNjQ3g5VndhYlpySkt0KytRQkRhOFhSeGFpbGRISWhYK1BlSlRHSVB3cGtJ?=
 =?utf-8?B?SE9DbmwweHNBTm1mS0dOVEtqbEh1QnREN0N2SnE4bG9nK1pmT0R2UUxIdEVp?=
 =?utf-8?B?YWJTVTVjQjd4VEx0ZTBzUVRydCt3cm9QODZrWXNZcUx4cFRuenRZdE5VVDRR?=
 =?utf-8?B?NCtOVmtYVkpwbVFxMWNHRVFTMHFLWHhuS0ZreHJhaTJvMFZ5SDdPVWdXUjR2?=
 =?utf-8?B?RWtUcmpudS9xaWZSUFdVc2trdUdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 334d21c5-5d44-4931-c8d6-08dd4f6350d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 14:56:53.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F470/NKJ7nwd9Ohdok7bP3yDArqaGTrSFQ7wrDHqNXqNqWsD5hOpNjf1IisEFWznXG8Ia1NLE1IICjiCjsVF3zLu15f6WAIYQVvFMpZNVPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE2P281MB4621

PiBWb246IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IEdlc2VuZGV0OiBT
b25udGFnLCAxNi4gRmVicnVhciAyMDI1IDE2OjU1DQo+DQo+IE9uIFRodSwgMTMgRmViIDIwMjUg
MTY6NTg6NTYgKzAxMDANCj4gVG9iaWFzIFNwZXJsaW5nIHZpYSBCNCBSZWxheSA8bWFpbHRvOmRl
dm51bGwrdG9iaWFzLnNwZXJsaW5nLnNvZnRpbmcuY29tQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0K
PiANCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIFRleGFzIEluc3RydW1l
bnRzIEFEUzcxMjggYW5kDQo+ID4gQURTNzEzOCwgd2hpY2ggYXJlIDEyLWJpdCwgOCBjaGFubmVs
IGFuYWxvZy10by1kaWdpdGFsIGNvbnZlcnRlcnMgKEFEQ3MpDQo+ID4gd2l0aCBidWlsZC1pbiBk
aWdpdGFsIHdpbmRvdyBjb21wYXJhdG9yIChEV0MpLCB1c2luZyB0aGUgSTJDIGludGVyZmFjZS4N
Cj4gPg0KPiA+IFRoZSBkcml2ZXIgZXhwb3NlcyB0aGUgaW50ZXJmYWNlcyB0byByZWFkIHRoZSBy
YXcgdmFsdWVzLCBhcyB3ZWxsIGFzIHRoZQ0KPiA+IG1pbmltdW0gYW5kIG1heGltdW0gdmFsdWUg
Zm9yIGVhY2ggY2hhbm5lbC4gSW4gYWRkaXRpb24gc2V2ZXJhbCBzZXR0aW5ncw0KPiA+IGNhbiBi
ZSBjb25maWd1cmVkLCBsaWtlIHRoZSBEV0MsIHNhbXBsaW5nIGZyZXF1ZW5jeSBvciBhbiBhdmVy
YWdpbmcNCj4gPiBmaWx0ZXIvb3ZlcnNhbXBsaW5nLiBJbnRlcnJ1cHRzIHRyaWdnZXJlZCBieSB0
aGUgRFdDLCBpZiBjb25maWd1cmVkLCBhcmUNCj4gPiB0aGVuIGV4cG9zZWQgYXMgSUlPIGV2ZW50
cy4NCj4gPg0KPiA+IEFEUzcxMjggZGlmZmVycyBpbiB0aGUgYWRkaXRpb24gb2YgZnVydGhlciBo
YXJkd2FyZSBmZWF0dXJlcywgbGlrZSBhDQo+ID4gcm9vdC1tZWFuLXNxdWFyZSAoUk1TKSBhbmQg
YSB6ZXJvLWNyb3NzaW5nLWRldGVjdCAoWkNEKSBtb2R1bGUsIHdoaWNoDQo+ID4gYXJlIG5vdCB5
ZXQgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIuDQo+ID4NCj4gPiBSZWdhcmRpbmcgdGhlIEkyQyBp
bnRlcmZhY2UgdGhlIGNoaXBzIHVzaW5nIG9wY29kZXMgdG8gZGVmaW5lIHRoZSB3YXkNCj4gPiBo
b3cgdGhlIHJlZ2lzdGVyZXMgYXJlIGFjY2Vzc2VkLCBsaWtlIHNpbmdsZSBvciBtdWx0aXBsZSBy
ZWdpc3RlcihzKQ0KPiA+IHJlYWQvd3JpdGUgb3Igc2V0dGluZy9jbGVhcmluZyBvbmx5IGJpdHMu
DQo+IExHVE0uIEFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgcHVz
aGVkIG91dCBpbml0aWFsbHkNCj4gYXMgdGVzdGluZyBmb3IgMC1kYXkgdG8gdGFrZSBhIGxvb2sg
YXQgaXQuDQo+IA0KPiBJIGRpZCBub3RpY2Ugd2hpbHN0IGFwcGx5aW5nIHRoYXQgdGhlIEtjb25m
aWcgb3JkZXJpbmcgZm9yIHRoZXNlIFRJIHBhcnRzDQo+IGhhcyBnb3R0ZW4gc2NyYW1ibGVkLiBT
byBhdCBzb21lIHBvaW50IHdlIHNob3VsZCBjbGVhbiB0aGF0IHVwIGFuZA0KPiBicmluZyB0aGVt
IGJhY2sgaW50byBhbHBoYW51bWVyaWMgb3JkZXIhDQo+IA0KPiBKb25hdGhhbg0KDQpPaywgdGhh
bmtzIGZvciB0aGUgaW5mby4gVGhlbiBldmVyeXRoaW5nIGlzIGdvaW5nIGl0cyB3YXkgSSBndWVz
cy4gOikNCg0KSSBjYW4gcHJlcGFyZSBhIHBhdGNoIGZvciB0aGUgb3JkZXJpbmcuIFNoYWxsIHRo
aXMgYmUgYmFzZWQgb24gdG9wDQpvZiB0aGlzIHBhdGNoIHNldCBvciBqdXN0IHRoZSBtYXN0ZXIg
YnJhbmNoPw0KDQpUb2JpYXMNCg==

