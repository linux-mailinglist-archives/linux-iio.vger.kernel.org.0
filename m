Return-Path: <linux-iio+bounces-9632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B69D97B92A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71480B28E6C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8217C7D5;
	Wed, 18 Sep 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Mbm5hfx0"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29C17BB25;
	Wed, 18 Sep 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647267; cv=fail; b=dovD9fNEb7jirq4p6WqV//UvgMTiG4434A4u8uXvuI4xH1fqxwLFNUEjRza0jzucohbgyVsyO0Cta+NRxZlmEgxcgQJKUTjzpGfy5OXg3m6ckzMkJpkICvgpStr0op8UnDYFLDrW6pbzbZOadoEyAfjRkH6+aFXK/yC8L/Lg50U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647267; c=relaxed/simple;
	bh=XuysIU0O3iozMecVhwewC1vcpFM2LDEuRvZMinhD+Fo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kxq4CCamvjm6Pha71PmDcRLXh44lTZSWlCbU4VukFv7vqNzXgC6upvKRq+cVJjWvVc/OqSDc9XX2Y0tV4jT73fk1WpVjwvBul5RN1SNip5/pc2Uqqp2TxPs37E85qSmM5h/WHW/+7UcdvS63Biw/QXEfGfbiXvuYYFY8GIfCU6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Mbm5hfx0; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVQDg76z1wK+DLqD5w+Z9Qb45EZ+92Q+7Uz871N55LW0otcpWsRiCrDmlyhmH1KNXQouB9BRLaEzgMbE0gq3HVEiU+Vkta58rW19NIsbAamSGffKuMFRYMLuE6S+H6PhB0+slyRDfhxKMNsACeFEMnoxcOQhw+ghKOQ4dJzJnf4vLlTmptoufuXB2ZWjAjp59I9z4W+rbmyzTtZoG3x6AolJgqJkLveLAk4zMzpu/gX6dHG/rvNZ88L4p9B8CpWRI+zspVTAUcXEev2kkpqTfpf7TaqMsx+kSZd5gfibsIlDBE/qV+YZGe+EWZRKzo3dLpb+SW6X9Q72sL011oXbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuysIU0O3iozMecVhwewC1vcpFM2LDEuRvZMinhD+Fo=;
 b=bZnB0PEN3O3YK1pdL3I0Cimt62xRekCjrMp/mX2L0HeO4sNxpfPZsP5tKvwVQ0dBLKwDQ29Cvk8qEv96tGnHQPdkvxrgfn09d/r0isYOnuxY2Jvc9GTyfTdA0MpmHKchpLCBTE631OvswL1+AUtjT3ikbksOofw7u5p4TrqQWF8+POglHmh1qZe1sKQrArJDTmyYXWHQc4acst0DmX7w5XpCMszW6TIJJNnZEoc0jaGDG2v69y8cN+gRrNJ+EfJruSoYzjW8STW3lboq4Ah8JanxV0/5nlraadvVeJHPzg1vRfKIgTIW9V64M8/YqTs2pm6wX/hTAWU1jMsgn9wvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuysIU0O3iozMecVhwewC1vcpFM2LDEuRvZMinhD+Fo=;
 b=Mbm5hfx0g/OUS+fFn8vemRYh1ZG1xW0hjUnnuk4ggafBPrOrcsAvS8XnK2kXe5Qfj9zCsVBBAGLgwB7Oxoqp8fU3/i8tT93SBF5PtR/T31XY0YAPb16Lx6A9IGHMg8c0Ti8ugx/zCEzg/g/Wzq2WvWBEORYjRAwsCI33UH1GsHnsy87UY9ehDdvRoecAKHIzFqgZNdI1YeSCV6BOon2bx65CbIKe1yUkuOZMcTJNu85rTjCabCLodnAUyU6++3eqyLpTvutI1EZ5zIiSZbnn16n/wDb1XdeBM0wD5ZFMF0AC8vZ5IW2+8l/toIl1aLTcQwfhnLQfdEfuiDfKS2356A==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by GV2PR10MB6281.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 08:14:20 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 08:14:20 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
	<dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH v7 0/2] iio: imu: smi240: add bosch smi240 driver
Thread-Topic: [PATCH v7 0/2] iio: imu: smi240: add bosch smi240 driver
Thread-Index: AQHbBcPtZLp38xTPBkGhZSF83dxRsrJcOlEAgADxvAA=
Date: Wed, 18 Sep 2024 08:14:20 +0000
Message-ID:
 <AM8PR10MB4721D6C1ADE1D0ACF14BF701CD622@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
 <cf53cbb5-104b-4f60-8890-98a53c27d176@kernel.org>
In-Reply-To: <cf53cbb5-104b-4f60-8890-98a53c27d176@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|GV2PR10MB6281:EE_
x-ms-office365-filtering-correlation-id: 7aa1a3cd-ec98-4939-fb57-08dcd7b9e5ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVJvNXlqUkRSZWZPOFlONy9VTTNOdnhSaXZpUjB4Q0FKMnpIcktGbXFUSTJP?=
 =?utf-8?B?VHBDdUhqQnpWMWdoMzhROVc4REtlWFkrcjZMcGMrc2pIdnhLdGpKeHBGUXFY?=
 =?utf-8?B?TnZLTVFoN0o4cTBrQnVMMXhNNE5yUFN4RTM0OTFyWE1Uc2F0QkRYRkJHSlc4?=
 =?utf-8?B?Z3ZJSSsvMEtVZFlac2FpQktHeDd3UGZYWlhrekQzWTdsWllxb2xvcUZ5cTVB?=
 =?utf-8?B?dEZCaXR4bDFPNGcya2R1N1hsdlBLc2FROGlSdllYZy9DQVV3WFBRNUJEYW9M?=
 =?utf-8?B?bUhZWXF6NVo3bTJvMkQ5ZkFZb04wY3F4UG9hSEd0OE9wam5yRU1UU09IdUNo?=
 =?utf-8?B?aC9MNkZ2VUo4R2dUNUdnUDNDdXpQMnU5aUdjOG5ldEVTK0l5cjBiekkxNTR2?=
 =?utf-8?B?enFLV1N3Y3ZIMFA4S0tSakRxTXVkZTdGeGZXYWFLWGo4dkhoU1haMG5naFhV?=
 =?utf-8?B?clZFMytIMDRFV1FObjlzUmJCMzV1a0ZLeUFTdmNJV3RXUlhrbWsvK1hTS3M1?=
 =?utf-8?B?YmRhYTFsM2xtVzJCMnk1SjdXSUF4cElmeVBHRnY3S3FwM0RSVW1IbFdoOXY2?=
 =?utf-8?B?NGVLWWZsWHMrenZtZWxKd3NtUXpqYjNnQUdJN0FhcHNESExMQTljRnBiOG9y?=
 =?utf-8?B?ZHJrOUdZRElUYThxdEJZbEdiSDZWRVFFSXhibk5yWS94K3luZ2NZSHZjUXYv?=
 =?utf-8?B?YTlMNDdKbzVQQ201eDB5aGw2Yjl0WGtZcWNadDlVTER1cGFBTjFiaDB4YUNP?=
 =?utf-8?B?UkJkK2twK1lCa1dZN3RFYTJDWnlmbFFzSjA5VUl2aC9lN3FreW1MRU9Hazd2?=
 =?utf-8?B?b3IyUGFyTWtaR0oxLzhUeDcxZkh6dytOYjU0a1JYMExwNzUxdDBSaGYxS2dN?=
 =?utf-8?B?NXdFSmZzQnVMbjZTbFpIQThja3BSbmR2dHFoeWJUMnBKbzVYazdkUWZFM2Va?=
 =?utf-8?B?SkRSREJodE9rTzJTbU91SWxrMmxXbjJ3MVVLTjlTcmRPaEF3cTJiNENKUEV5?=
 =?utf-8?B?cHhTK1lyVXU0LzdydmgzUGNtUXJmdmhCMGw5TDVQUnFLbUxNWWtGVnVwYTV2?=
 =?utf-8?B?ek5wS2IzRVdtQ2kvaVljdlp2eFZRY1VLM1pvV2JHdUZ0Und4V1EwWjFsYzBW?=
 =?utf-8?B?NE1mRFpCTnNLVFVHeldQb1g2L3V3NUhZTHBxdW1GUmRaS2FGc0pKcmxtaW1u?=
 =?utf-8?B?REoyVFZaK3gzQkh1Sk03WXp4cm9QMlpDeUhjVTFqOW5QK3V0YlpHVHV6ZjI1?=
 =?utf-8?B?K2c0dmR2M2FoeW1rbENXU0t1RnZUUWhyakIyQ2JGemROd1J5Y09xNTE5R0ZN?=
 =?utf-8?B?Zm1VRTNIZXl5eG5tZi9DaVRjREFQK3NuZ1RqRThybi91MDZ3WkRMZHowaDFz?=
 =?utf-8?B?N1FLOFRwL3FIc1o4Y2hvKy9SYlhKRWpwa2dMMTFnc3BtSkJWdUFXQURWTnl1?=
 =?utf-8?B?VHpDblNPTGVjVHE2UTdjNmthaG9kcnNMRGFYalMxeDFqZjE1ZGxsUnd0eUZJ?=
 =?utf-8?B?WmEyRUxwTCt0VHplV2dOQ0ZDMlpVVS84NFN4RXdKQWNhbnRXQVlPR3pSQVoz?=
 =?utf-8?B?WE11ejZWTy9hTjNGT3FyUFlncjI3bnJsNEpMbDdOUVM4ZGh3L0FpMFF0OWFr?=
 =?utf-8?B?NXhNWDBvVVByRFlQSGFOQ0V2ZHJCOHVmTTVianQ5dkQ0L2F3WEhqNG1hZ1ZC?=
 =?utf-8?B?a2c0N2JoN2RnNEZxeHRwZGFyYmk0c21lNlJ0c3RqbnFKSk04bVVNbkRDWHQ5?=
 =?utf-8?B?cnIzOW1yV3R5NHZ1WkF2RHhtR0NPbnFOZzNLWi80R0lqc1h5Y3Z4eWFSM2pS?=
 =?utf-8?B?b2dRUmFNNDc4QWpJT1JnNEVqQjc2cDc1aTZmekJ5V3FjdTVucGZTcHFzcTVM?=
 =?utf-8?B?K2NVZlVRZCtWZVllSTFIY2dFTzJEbFRpVnNRcTFJaGRoRlpXTlhvSWp3TWw0?=
 =?utf-8?Q?fSVlLf4KYHs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2ZkTUx0d05iV2ViaEFBdHd6bVJ6Q0Y2anJHeWJRTk8ra2s3S3d6UlVINy9j?=
 =?utf-8?B?ZWh2RVV5Mks0ZDhNNXFnM1RwdkRKaTQ1Q0RrSWQ2aUR3Sm9BVE5KVWdCN2Q2?=
 =?utf-8?B?R2s1ZWZPV3B6ZUsyckNnRERVZkFBeDkyNVE0RjhkL2M0akZJSmRabUZYUUIw?=
 =?utf-8?B?U3hwZkx0TVRkNUtMSitmOEJ2ZFlNYWdqVHhvOTg3NDBZZHFOcHl1T1c5U1Jr?=
 =?utf-8?B?REwrWjM1dm5kenRoeHpocU1ZSjNnbW9NMHBnTlJpVDQvclFmZVR2dGpKajFO?=
 =?utf-8?B?b2FnOGNDN3l6K0RCR1RSMkJWcDFjcklqVUtzNGx4OTRYbG5TQk5raVUwVjl4?=
 =?utf-8?B?VkZFVVZ5bUkvMVJld256ckJLWG96STlmM2FlMWlZVjY3Um45V1U5Ym91T3Yz?=
 =?utf-8?B?QkV3WDk1Vzc5NWErVURJdGFqeXVoazhyMWx5b2xjd1ZPa2srcEFaVE9zeVhz?=
 =?utf-8?B?bHRncVJWK2FJRk16b0VlNjVhV2dWa0QrSWdqK2E4ZDF2VlBhRXlOUjFVUk5F?=
 =?utf-8?B?TENacTB5YVRSOXdUV05SdEx6ak1jY3NEYWRzeklzWmYrZy9KcTFoSnRyRXht?=
 =?utf-8?B?ZUhjRitDUDdjbXpBWjJCNTdZSlZ0VndYam9YZWFSM29jU05ldVd0a3pkZFNM?=
 =?utf-8?B?bHZrVjlrc0FsVFpHTWgvM0Z1c3Q2Sy9OUEhqMVE4Wm15M2Z0MEd5RG1zbWp1?=
 =?utf-8?B?eVQ3SDU3NDY1MjRDT1pZbjcybC9uN1RkK0JyRWNhMDBOY3o1UGxrRmo5OVpN?=
 =?utf-8?B?cHhDR1NHUUhPSzRBQVFaY2tneC9wbFNCNlR5M0p1Z3laRERvOTRXSEgwNUFZ?=
 =?utf-8?B?QlkwTmpVak5wUVFnTy9oaXl2TnVOSUpxcmtpL0UzNDdIeGQxN2RRQVFOVGVW?=
 =?utf-8?B?YlY3eWFTSC9KSjU0ZnNoNExhMmNNTkxtV1d3Vm1XaGh6ZlJKM0JUWHpKVVFt?=
 =?utf-8?B?Y1M1blVQQ1hjTWs2cmNVZEZ0TzRIMlBtZjVlSEpPVGgwV2xsSVduTTRHYzB6?=
 =?utf-8?B?c04wMk1CenNObGxWTW1QR0JIbFFqWnJmVTZ5T2lrcm5UWm52TitQWjYra3d5?=
 =?utf-8?B?bnU3U3pYakd3SVBnaEwwa2pDaW1ENEFaTTdQZitFYWdVL3laUkFuZ1dORHBU?=
 =?utf-8?B?aUlLWXdSaFhWUDRzQXhvYUxtaExpQnJmK0Ixd2F2MWRBWWpVLzFhclFHY0I5?=
 =?utf-8?B?UjhjRitGa1hIelJmZ2gzb2d2NVAzRWI1NU13VjlsSXFMQmgvQ09OWTZrSWN1?=
 =?utf-8?B?V0loSHNiME1FVk5oRHRkbEp3Y1lIM09yOEs1THpXUVV0N2pCRTJhR2ZIZXBC?=
 =?utf-8?B?ZjZqNThjTVQ0N1Y1YkVoRTdkVzQ1RHUzdXh4QUU0c0tBdTJTaFZMQWgzN1dl?=
 =?utf-8?B?cXhLdEltUjF0RE40WlJYWDAzdHpRSmdwNXhoUW01c2JST3RxRmFrQW1KL2Ex?=
 =?utf-8?B?UXNZN2dmMXQ2L0xzdzhWQ0JTTi9oRlUxQjBiNlNwd3ByTmVGSHdvVVM4elR5?=
 =?utf-8?B?cEdNdGZwVjhjcXBqSjFlMXU4QzUrbld1alAvbkFUY1RGc1RLMllIeU5SUmtz?=
 =?utf-8?B?Qm9wNVl2c3FiQk1XeFR3SDhRaFpwOW1BYkROMncwN2c4R0ZrMjBKajBFYkpu?=
 =?utf-8?B?MXpQMnRTa1BUUW1FQzJaQTEwajhTeEhPZG9GaWJDclRtNTRodTlSQ2hLRDJP?=
 =?utf-8?B?NUw0L3hELzJHL0NBck4vK3RFMnMvRTY1WGNVTk00cmswYXgzdUdvcy92VVM0?=
 =?utf-8?B?c1BxblBsZHUrZkJVSDRvdHE3SmVkTGNaYy9jTlJLZis0Ri9WSmVpNGQ4c2ph?=
 =?utf-8?B?R3FtM1lwekdlaGo1S0NwMnVZTk45OFZEQUlCUVF2cGppWGtoRlJYbXZ1SDRi?=
 =?utf-8?B?d2lZSDE0dXlvOHVRNVYzRkxsQXExWWFETFh1aFRGV0I5OU1zV1dqUVFQUUYz?=
 =?utf-8?B?VmIvUWpicEFOWitONVNpUzMxdXFTbDluQmtobGZoRzV6R0h5Z1VNeHY2aUhG?=
 =?utf-8?B?U3ZlTW9xb0xTcndBT29iNDBpbjMvaDZSbHZzUWMzQnM1Zmc1ZFE3RnlpbS9V?=
 =?utf-8?B?SWoxQi9LeGFZYmtLbVlZekl5WXlrRXBLM2FCYTRNeXNTOCtEVnNGS3JMRjI1?=
 =?utf-8?Q?/beY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa1a3cd-ec98-4939-fb57-08dcd7b9e5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 08:14:20.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCxEv1hKGDURf3+r+nGJTqcTs/ovW8wXAVJXPNHsp+aPTRQQqPEwXE4Mbcsg2J0JIYdA1vBRVgBvqLRWUEbwpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6281

DQo+PiBBZGQgdGhlIGlpbyBkcml2ZXIgZm9yIGJvc2NoIGltdSBzbWkyNDAuIFRoZSBzbWkyNDAg
aXMgYSBjb21iaW5lZA0KPj4gdGhyZWUgYXhpcyBhbmd1bGFyIHJhdGUgYW5kIHRocmVlIGF4aXMg
YWNjZWxlcmF0aW9uIHNlbnNvciBtb2R1bGUgd2l0aA0KPj4gYSBtZWFzdXJlbWVudCByYW5nZSBv
ZiArLy0zMDDCsC9zIGFuZCB1cCB0byAxNmcuIFRoaXMgZHJpdmVyIHByb3ZpZGVzDQo+PiByYXcg
ZGF0YSBhY2Nlc3MgZm9yIGVhY2ggYXhpcyB0aHJvdWdoIHN5c2ZzLCBhbmQgdGlnZ2VyZWQgYnVm
ZmVyIGZvcg0KPj4gY29udGludW91cyBzYW1wbGluZy4gQSBzeW5jaHJvbm91cyBhY2MgYW5kIGd5
cm8gc2FtcGxpbmcgY2FuIGJlDQo+PiB0cmlnZ2VyZWQgYnkgc2V0dGluZyB0aGUgY2FwdHVyZSBi
aXQgaW4gc3BpIHJlYWQgY29tbWFuZC4NCj4+DQo+PiBkdC1iaW5kaW5nczoNCj4+IHYxIC0+IHYy
DQo+PiAgICAgLSBBZGQgbW9yZSBkZXRhaWwgaW4gZGVzY3JpcHRpb24NCj4+ICAgICAtIEFkZCBt
YWludGFpbmVyDQo+PiAgICAgLSBBZGQgdmRkIGFuZCB2ZGRpbyBwb3dlciBzdXBwbHkNCj4+ICAg
ICAtIFVzZSBnZW5lcmljIG5vZGUgbmFtZQ0KPj4gICAgIC0gT3JkZXIgdGhlIHByb3BlcnRpZXMg
YWNjb3JkaW5nIHRvIERUUyBjb2Rpbmcgc3R5bGUNCj4+DQo+PiB2MiAtPiB2Mw0KPj4gICAgIC0g
SW1wcm92ZSBkZXNjcmlwdGlvbg0KPj4gICAgIC0gSW1wcm92ZSBzdXBwbHkgZGVmaW5pdGlvbg0K
Pj4gICAgIC0gTWFrZSBzdXBwbHkgZGVmaW5pdGlvbiBhcyByZXF1aXJlZA0KPj4gICAgIC0gQWRk
IHN1cHBseSBkZWZpbml0aW9uIGluIGV4YW1wbGUNCj4+DQo+PiB2MyAtPiB2NA0KPj4gICAgIC0g
Tm8gY2hhbmdlcw0KPj4NCj4+IHY0IC0+IHY1DQo+PiAgICAgLSBObyBjaGFuZ2VzDQo+Pg0KPj4g
djUgLT4gdjYNCj4+ICAgICAtIEZpeCBjaGVja3BhdGNoIGZpbmRpbmdzDQo+Pg0KPj4gdjYgLT4g
djcNCj4+ICAgICAtIE5vIGNoYW5nZXMNCj4+DQo+PiBpbXUgZHJpdmVyOg0KPj4gdjEgLT4gdjIN
Cj4+ICAgICAtIFVzZSByZWdtYXAgZm9yIHJlZ2lzdGVyIGFjY2Vzcw0KPj4gICAgIC0gUmVkZWZp
bmUgY2hhbm5lbCBmb3IgZWFjaCBzaW5nZWwgYXhpcw0KPj4gICAgIC0gUHJvdmlkZSB0cmlnZ2Vy
ZWQgYnVmZmVyDQo+PiAgICAgLSBGaXggZmluZGluZ3MgaW4gS2NvbmZpZw0KPj4gICAgIC0gUmVt
b3ZlIHVuaW1wb3J0YW50IGZ1bmN0aW9ucw0KPj4NCj4+IHYyIC0+IHYzDQo+PiAgICAgLSBVc2Ug
ZW51bSBmw7xyIGNhcHR1cmUgbW9kZQ0KPj4gICAgIC0gVXNpbmcgc3BpIGRlZmF1bHQgaW5pdCB2
YWx1ZSBpbnN0ZWFkIG1hbnVhbCBpbml0DQo+PiAgICAgLSByZW1vdmUgZHVwbGljYXRlZCBtb2R1
bGUgZGVjbGFyYXRpb24NCj4+ICAgICAtIEZpeCBjb2RlIHRvIGF2b2lkIHdhcm5pbmcNCj4+DQo+
PiB2MyAtPiB2NA0KPj4gICAgIC0gVXNlIERNQSBzYWZlIGJ1ZmZlcg0KPj4gICAgIC0gVXNlIGNo
YW5uZWwgaW5mbyBpbnN0ZWFkIG9mIGN1c3RvbSBBQkkNCj4+ICAgICAtIEZpeCBvdGhlciBmaW5k
aW5ncw0KPj4NCj4+IHY0IC0+IHY1DQo+PiAgICAgLSBNZXJnZSB0aGUgaW1wbGVtZW50YXRpb24g
aW4gb25lIHNpbXBsZSBmaWxlDQo+PiAgICAgLSBBZGQgY2hhbm5lbCBpbmZvIGZvciBhY2MvZ3ly
byBkYXRhIGNoYW5uZWwNCj4+ICAgICAtIEZpeCBvdGhlciBmaW5kaW5ncw0KPg0KPj8NCj4NCj4+
DQo+PiB2NSAtPiB2Ng0KPj4gICAgIC0gRml4IGNoZWNrcGF0Y2ggZmluZGluZ3MNCj4+ICAgICAt
IEZpeCByZXZpZXcgZmluZGluZ3MNCj4NCj4/IFdoYXQgZXhhY3RseSBoYXBwZW5lZD8gWW91ciBj
aGFuZ2Vsb2cgaXMgd2F5IHRvbyB2YWd1ZS4NCj4NCj5XaGF0IGhhcHBlbmVkIHdpdGggb3VyIHJl
dmlld3M/IFdoeSBkaWQgeW91IGdldCBtdWx0aXBsZSBvZiB0aGVtPw0KPg0KU29ycnkgZm9yIHRo
ZSBjb25mdXNpbmcuIGxldCBtZSBtYWtlIGl0IGNsZWFyDQoNCjEuICBPbiAxNS4wOCAgQ29ub3Ig
cmV2aWV3ZWQgdGhlIFYzIGR0LWJpbmRpbmcNCjIuICBPbiAyNi4wOCAgd2Ugc3VibWl0IFY0IChz
YW1lIGFzIHYzKSB3aXRob3V0IGFkZGluZyByZXZpZXcgdGFnLiBLcnp5c3p0b2YgcmV2aWV3ZWQg
YWdhaW4gYW5kIHRvbGQgdXMsIHRoYXQgd2UgbmVlZCBhZGQgcmV2aWV3IHRhZyBpbiBwYXRjaC4N
CjMuICBPbiAwNS4wOSAgd2Ugc3VibWl0IFY1IHdoaWNoIGNvbnRhaW5zIDIgdGFpbGluZyBzcGFj
ZSBpbiB0aGUgZGVzY3JpcHRpb24uICBUaGlzIGxlYWRzIHRvIGNoZWNrcGF0Y2ggZXJyb3IuIEty
enlzenRvZiB0b2xkIHVzIHRvIGdldCByaWQgb2YgdGhvc2UgY2hlY2twYXRjaCBlcnJvcnMuDQo0
LiAgT24gMTAuMDkgIHdlIHJlbW92ZWQgdGhlIHRhaWxpbmcgc3BhY2UgYW5kIHN1Ym1pdCBWNiAo
c2FtZSBhcyB2MyBhbmQgdjQpIHdpdGhvdXQgYWRkaW5nIHJldmlldyB0YWcuIFJvZyBnYXZlIHRo
ZSBsYXN0IHJldmlldy4gDQo1LiAgT24gMTMuMDkgIHdlIHN1Ym1pdCBWNyAoc2FtZSBhcyB2Mywg
djQsIGFuZCB2Nikgd2l0aCByZXZpZXcgdGFnIG9mIENvbm9yLCBLcnp5c3p0b2YsIGFuZCBSb2Iu
DQoNClRoYXQgaXMgd2hlcmUgdGhlIDMgcmV2aWV3cyBjb21lIGZyb20uIA0KDQpJbiB0aGUgZHQt
YmluZGluZyBjaGFuZ2Vsb2cgd2UgaGF2ZSAgInY1IC0+IHY2ICAgRml4IGNoZWNrcGF0Y2ggZmlu
ZGluZ3MiIA0KDQpCZXN0IHJlZ2FyZHMNCkppYW5waW5nDQo=

