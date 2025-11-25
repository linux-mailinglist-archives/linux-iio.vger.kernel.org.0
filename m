Return-Path: <linux-iio+bounces-26461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9921C8634B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 18:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0114E90C4
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21BA329E78;
	Tue, 25 Nov 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y0iYSgkN"
X-Original-To: linux-iio@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552524A046;
	Tue, 25 Nov 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091537; cv=fail; b=JU8f+J5T2TwH0Uud+PtsPXd2Kam2GnFHOf3kvto5JLHUoX+s/OpAWnc9tmkgad4eIvmFjleOrQ6A1IobxYBIkXkE6Y1YnnUuoxc3q4bt0gp2NQOMaeiJVZOb1KNtejW8HdLBTVjQf4d2PJoQzWKELePBU/ydcdyGOog6HffSBII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091537; c=relaxed/simple;
	bh=zcYF/o9f6BORBB4hGh/WspRjPoYzvbxUru5uA+KZM6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQ9UlypJ2bVsVFeAIF5hxU9ppHNkY/oznJ1NpUhEyXFWBN24oEVZ9B3uJQjSrFjqG46YNvx4nSI6TPHrTHA5DdSyqSet8Z8UhiL6/cyxG5bslPhcpl2Sx5OzJ/cRgzFudKLH/Zy9L1bIlzKtazH5pdNtQEmyb47+0nZzrzXvKDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y0iYSgkN; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1OTn/2bo36bds+npcQFrwzQkzZ3QuPxlus3n488+x+fpuBvEclUWdVDoaUUMOBGMYlaD0dlFieoBwgrI8/LdJJX7k8J2nGZ+prP+aHt31xoPLF8gEx1WatvRxV8j4/R8h530pEeKxb4YOfJVFu7spHU0Sd+IZGCDZmbwCl8/Tv1xWwLGSqsgyxpifdh/me+1jsmnU38qY9A8rgM9rbTGjXdejCDEGf+snWkiJs1CtxsMmBtsxZnHOr3kk2hDWfLyQoH36f4YjHyxj7kQ2DzZjizhZ9jTwCxgt0n7dajTx0DMS6mm/jAAuHkuPBDePQsFo4JsBeCwyGdU5QbBH30fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcYF/o9f6BORBB4hGh/WspRjPoYzvbxUru5uA+KZM6E=;
 b=oiU6W4+eNmLj64GdujRucQkSBzIwHCxb9O5aM+wbqI3KUe+KREdEVJG+WX4Pge2kTFG6f+aygmw+J4ESxs/sMYBkjrW4hR3IUoB2Ko0jQmqlrrp5PlxXj1CxRr0oCftPB1TVD8B5m4UbU09VCAVaSyO8pDkQOPJqnH5bIzh1zTX7vr7Agum49xRWEVMP3oZAcXDQ7tvc28hkLMaLgoUEAzGTfhPmRosWPxbQf4NAzcOAjzXku0bQLSQtM4Er10on7RLJ9F9pZoUIfIOEjZFEFWxhgwqqZDOtZ9W1dH3UfHAWCLYidtgaNtcSGlFEJZyHOdPgZY511/uc1INVdyBNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcYF/o9f6BORBB4hGh/WspRjPoYzvbxUru5uA+KZM6E=;
 b=Y0iYSgkNT2OskJrSSnpbrayqtaCXLCzdAbDMnvfFBiJm+5gRbAVx9GKP9cU7vQek6l9yn4jNy/PRuDXztWOhovMoU8W/5AK2i1QLSuJDX1xz3bgKYTnKJ93DsWhzCVL18N+Ud5Snqzl5PzzxG61QnVdgPYbqN9UMU6xfwo924wpPJ4FchkUhrEFJmYI/8iwEMewTpO0coXCPW6DojR943+Mw2X0EzqukAuB2R/7hdDSmgEh/UzWCT48jZzhF9B2CBRkaXDoa1RxfkP6LENeYQyAvQ7jxwicLcNPRIrWs2msR7dQm2dsSVVzW4r8wBF2SnmSBkc0Ew2nUbie83oAeow==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Tue, 25 Nov
 2025 17:25:30 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 17:25:29 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding support for PAC1711
Thread-Topic: [PATCH 1/2] dt-bindings: iio: adc: adding support for PAC1711
Thread-Index: AQHcPe+ZUQj9Zje02UW+PpK7+KUCybTJMv4AgDqROIA=
Date: Tue, 25 Nov 2025 17:25:29 +0000
Message-ID: <77443ac90eb95fbf355509a7f060c05ee1d24d37.camel@microchip.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
	 <20251015-pac1711-v1-1-976949e36367@microchip.com>
	 <20251019100454.6bfbc3c7@jic23-huawei>
In-Reply-To: <20251019100454.6bfbc3c7@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: ba30a70f-3fd9-4eaf-9863-08de2c47a188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkYzN3RwL3crWjhxR095Z3dLenhORHk4amZLK3JjVStaSzVqTkhmNVJndUVm?=
 =?utf-8?B?Vk4xNkNua2hJVUROTXpDYTNKOWlQV014QktZVHFYL2YyTTJiZ1M5eUJOV242?=
 =?utf-8?B?Nkw0cG0zRmt0d2dzTWhBT0lmVk5hN2ZWZmU1VENRR25aZSs3WDVZc1JhUDlR?=
 =?utf-8?B?Vk5HUXluTlRzaEEyNjBrM1FTRDlXa3VNVVFEM2FkWmFTSEtsOGJUWUFYOTVm?=
 =?utf-8?B?Q016SjVOVHplYStqTzFSMmxDUHdUelN1MjJ3OVhqK1pOdjVWV01IcVpBWFBa?=
 =?utf-8?B?eFo0SjU0N3RKWDBreU9pZWNTR2JST2cxN3ZFRWdNS0Zrc1gwQVB3bUlHaG9x?=
 =?utf-8?B?RG5CVGJDSG1xbFZsWDM3K3MwSTFPTjlBZHZibWtFc1BzQk1Hc003eGkxbTFT?=
 =?utf-8?B?ZGpMOVNZZ3BRK0pwaktBRiszZXB5UEhaRU1LKzZhNEtSUERWcit0NEJpM1A4?=
 =?utf-8?B?bUZsdFNxT2NCWTVzNVJyU2hXYVBIT25YTnVZQjhaczhaeHpkQld5WWJHZkRu?=
 =?utf-8?B?UGJyUGJZRVUrUHRMMlpxdUs3cFFqT1o3alppOHMvb0tUYjRheXc1Mkt5Ylor?=
 =?utf-8?B?ZmRPS29TRW0vdXhaMVRmQWdIQjVnaldJTUJIM1BxTXljb1IwbkEvcmRUeSth?=
 =?utf-8?B?Yjhkay9SanFSaXViRlRkSGRIYVh2VFZDb3UzYkZiYXZORGxqYll2akZ2ejRO?=
 =?utf-8?B?eDU5bkFDMDRud05nalhiU1JHYjZodmVFU3dPdEYxaFl4YXdSOVcxZzB4VUNa?=
 =?utf-8?B?eDdtV2Z3SGs2SmVrK1BXMzU0K21RS3htRnpVb1FhNXR0Ri82bVgwRVdFc1ZD?=
 =?utf-8?B?MFN6Skh0NzZicEFFc1VxUVR5OUhPQnVIbW1rTFI2UzdhOVNYUks0M1dCN1BQ?=
 =?utf-8?B?QkJoaGtRaUQ3OU00TloyN0hJR3h6TFBWVXhqbFFaVEtsZCtkMEV6M1pyUkty?=
 =?utf-8?B?NWxDZ1ZsNkJBUGtTVGJzYWJRK1BqNHdLZnZuL0Q5S1pWclYzZ2VUSGRCNWUr?=
 =?utf-8?B?NG5UeFQrRFlsaFBnOUExTFY2bGU3NkR2NUxNVUlONlVVYTN0MDlSbU1lcXo3?=
 =?utf-8?B?ajd0djNLN1djcmFEY3FyQTBYdEQ2T3dXc3BtU0hqWmFLWFF6R3FVeCsrbFFH?=
 =?utf-8?B?UzVqSzFLVDNZSVNnK3FkR0d0akFOLzhDcG9BcXJld25wUzZHMndMNUxJVEw3?=
 =?utf-8?B?YmFjLzZpK0NZcDNGaCtJWnh3QTRPMUNtVDl0TUhrd2tod1BCT3ozQ2twR1Yv?=
 =?utf-8?B?OFcvWHRQODZPWG5Lc1QwUldkWmdSQVFTc1FvcWNiV3hZREJRNHFXQm14a2Ir?=
 =?utf-8?B?T3BqazJpcUpMVzdCTWY1MzhxNGNNVVI2Vk8vMFZHa0xpRlc1RE9OZ2xHY2U5?=
 =?utf-8?B?VzhHNHhIa3k1MGk3d0pXbk84MjhFLzB2Q3FRY3lqVUVydWFjbkpYOFJrRTVC?=
 =?utf-8?B?RmJzVVVVcU8yMjEyUmUyeHcyNUQxN2hNUk9Hc3h0MzZ3Z1c0cmJwUHJmdWVO?=
 =?utf-8?B?WVExZGJmbk1Mc214ZzVub3ExcWlSWnUxcFlEK2N5bHpzZHUvTE9kUjBGS0I4?=
 =?utf-8?B?YTE2dk5nWUd2Y0sxdEJzTjFGa0Y5dWtVQWpxbElzUmpoUU5YWldCTFJZMmtn?=
 =?utf-8?B?bmc4VkpnTk5CbU9zQlllSVdib1R2N25aK2xRR2dkRkM4bDgwTnJkaU05cjNQ?=
 =?utf-8?B?a3RnNlhMVFdKaTMwYjluU085VjFscW1tRENzTGZva1FvdkJNWUg2SW5FYUhP?=
 =?utf-8?B?cmUzczAxZ1owZzdsSGxUZTZ6bnh5YXZqSUNzQmVzanBmblVyUTdKdTRFYlJw?=
 =?utf-8?B?N1QrM0FaQmJ0TDBFM1ROSGthWG9vclpDZ2FFNGFuc090eVM0VGpLQ1VQVWF4?=
 =?utf-8?B?bmZLUW5nNFJHSzJ5T3o3U01pWHQ4SkUxaFBrZE90dUd3eVNZTENuR2xzWjVs?=
 =?utf-8?B?YTNTSGZpYUZOeDA5R0sxRzNpL0hkbHJiS2oyZk9TYVBNcU0zdTkwTnVYWm1i?=
 =?utf-8?B?YTNHNjdmKzU1NGNnbjUyelNhcC9tZDRkeVIxNXA1cytTajZJZmdUazJTbFM5?=
 =?utf-8?Q?Dafsn5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnNyRnRtSXVGaVlmRXNteGhLVTdsOHVsSWNmYWx6N1VCdFRvOTB1RlUrU3dx?=
 =?utf-8?B?a0czQm9rMUJ0T09PUXFIclhkdmdPV1I1WVgxRHNGSGdlSHZaN3dpSE1DbnVQ?=
 =?utf-8?B?RXY4RlJSRVpzZkNBbE9OZDNuMFdrcUJhYzFQb0x0SWQ1UmNNVmJROHhBV0dl?=
 =?utf-8?B?eTg5RWRyZ2J0QWxudzVDTTljRStMYm1MRmd4ZTh1L3NBYmhlSGx4akIwSzlK?=
 =?utf-8?B?VC80WlV1R1NsbWJ3TFg4N3FMc1NCdDUvUG1mcTE0aEd6UDdDR3ZoZDFyUHdM?=
 =?utf-8?B?dGFuNTF1cndUbVJUaFVWeTRmY2diZ1BhZXhqM05qa1k2REJ3YS9VcmVscGdP?=
 =?utf-8?B?VzlicmZ2ekF4TG1yUEFUZS8wT28vM053VGdIUzBiZHNCdVJKa1JYS1AwVTNW?=
 =?utf-8?B?eEVHR25UTk1xTUVJTVB6UGJvK2M5cWJ3VnVWSldlZzVMYVRteWQ3eEpWK2Zl?=
 =?utf-8?B?S0VEanV5Qys5eGoxZER5VEh3ZmtXdm5SL28rR2k0UStNNTluOG53TjN3dEto?=
 =?utf-8?B?aG5FWFJXTVZOWTF2bG9TaVBXREJ0NjJMU0Fxeld2SlRCUVNFdkJ5c25Xd2sw?=
 =?utf-8?B?VktleHd5dWFwcGxhUzFvRkRmUjNUUitsMGhHU2JsQTlicjdKak1tdysycUxL?=
 =?utf-8?B?VVAza3NaeUVYaXZOSUowWXRlYzJRUUtGMWxOODVVVlJVTDczT0p1QXl0anFy?=
 =?utf-8?B?cmlqbm8zOWt1cXFuVXRDUDY5MEtocFZaWGFtMWdmNW5KMWw0V2JEVWtvNTJF?=
 =?utf-8?B?T0o1T3BNQmgzbFRJaTR3TlprOVY3aXJTYllPMFpmdXJGMUZ6eS94YTFCTmln?=
 =?utf-8?B?TW5VaU96bHZjOXVmUWluaXA5c3Z1ckRRVnZlSS9lSElESlhRRU1sRzVNTStI?=
 =?utf-8?B?N1VBbTZCZnN6MFdYWXVOdjcrbTRVaVpTeUFqRk5sMk1LbnczdEtxRnJGbDBK?=
 =?utf-8?B?NEFCcjdOTXF2akkvTm5vbHJETE05dTh2MnZDcmVzcmNLN0pwZjRRdzFabWhR?=
 =?utf-8?B?enBxV3BWRVZyTGowbXR5WXA0STZXUHo0VmxvOHBCc0FSM0R5L1dmeXROTkJk?=
 =?utf-8?B?RXQydHMvenJKQWVLbUF5VUV2YkNLdWNlSVZhaHNZU29zV0ZuRzNzdUJEQi9q?=
 =?utf-8?B?MXZnNngrTXBWZEdNMkZqd1FpcllmckMxTnZIODJSQnMyT0NJeVVBQlZhdHZH?=
 =?utf-8?B?Tm1Dek50NklwblRjQStEZnZhbnE1bVdkVllURDF6T0p3ZllYcytPYm5uNVBu?=
 =?utf-8?B?YXBKNTduZEg0Ymx2dStIUEJPb1dqYUp4eEVqK2h0bFI0QmVuZFpReU1na3Zn?=
 =?utf-8?B?MkNnd2FieGovV2RIc2N2OUQ4Sm5ibzJLTm9sZy83ZEZyY1ozOG1reWlta2Jl?=
 =?utf-8?B?cU4wbjJJTVFKOGhndTRjOUFPNjZ5TlVNR3J3U3AwTVp3ejF2alVkNXhRZkxz?=
 =?utf-8?B?aXVPQUlSWk1FeFR0WHkvSWQvYmVTb204b09wV3FDVG9oSDNOT28ycjVwWGUz?=
 =?utf-8?B?WFkxMlV1M0JKejVlU2xTRS8vU3dUeUVQWG9EZnFlSTFia29reExEVWxkd0Jj?=
 =?utf-8?B?YmhFa1V2bmpNVzZQOXJ5c2pnM0ZFOXVBSm1IK2luT01SMzRmUFYrOVdLVVF6?=
 =?utf-8?B?MDRhN0F6UkZQN1hjS2RWdHRpcndkSUYyVGYxQW05YU5zK21oOHVkMEs3alMx?=
 =?utf-8?B?UlorblVVN3FRQ0hSMVlrR1F4VDA3ejdoanZQQU9RRGJHYW5JM3ltWE9oMEJI?=
 =?utf-8?B?NkJCTS91c1VBYmVvNUN0OWEwcEMwUVZqSTFoUS9pMEpBd0lJYjUxMksrQ0lz?=
 =?utf-8?B?S3dybUFlZGVCbnNRS0NGbHJ2MkpKbWFYRDYvNFpTVURFc2pad1E4OTZJRnFL?=
 =?utf-8?B?aU5Ga3BrWWFWNTFiTlZ0TndmSjlMNE1sL1pWSUpWQllTVExaR09JMlFtVVlq?=
 =?utf-8?B?Qnd4MFduMU42Tm9qaGxxbExWeDFXdXdid1p4d2E0Z3c4MmhYUXZ4cXBpV0hi?=
 =?utf-8?B?Wk1ZaHhLUTlyemFmQ3g5bFBWaUZlc2Jsa0RQTGpQdkIvYU9hSDlGQTB2cUNk?=
 =?utf-8?B?cmFKaFdHdnpzeFFseVpqMlJ3ZzZDYXFqRVRjb29ZUjNyTVlMYnZEZmtrbmxQ?=
 =?utf-8?B?Zk1ISU94MTRuaGVSZGFQRGNreEVFc3JGRE55aVFINlg1eXdzN0lUcmw0UmNJ?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35153203DF217247B407FCADBC7F2144@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8251.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba30a70f-3fd9-4eaf-9863-08de2c47a188
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 17:25:29.7292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTKiqYvsNhQG/8ruyYb4/2olAzbtnYvFJIMw40GxOgB5fVnN7TPHpUviGWblkhshd/RCm/I8Ib21mV24ktER5oP32VHh9s6NcADe1zVlxFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611

SGkgSm9uYXRoYW4sDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KT24gU3VuLCAyMDI1LTEw
LTE5IGF0IDEwOjA0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0K
PiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgMTUgT2N0IDIwMjUgMTM6
MTI6MTUgKzAzMDANCj4gQXJpYW5hIExhemFyIDxhcmlhbmEubGF6YXJAbWljcm9jaGlwLmNvbT4g
d3JvdGU6DQo+IA0KPiA+IFRoaXMgaXMgdGhlIGRldmljZSB0cmVlIHNjaGVtYSBmb3IgTWljcm9j
aGlwIFBBQzE3MTEgc2luZ2xlLWNoYW5uZWwNCj4gPiBwb3dlcg0KPiA+IG1vbml0b3Igd2l0aCBh
Y2N1bXVsYXRvci4gVGhlIGRldmljZSB1c2VzIDEyLWJpdCByZXNvbHV0aW9uIGZvcg0KPiA+IHZv
bHRhZ2UgYW5kDQo+ID4gY3VycmVudCBtZWFzdXJlbWVudHMgYW5kIDI0IGJpdHMgcG93ZXIgY2Fs
Y3VsYXRpb25zLiBUaGUgZGV2aWNlDQo+ID4gc3VwcG9ydHMNCj4gPiBvbmUgNTYtYml0IGFjY3Vt
dWxhdG9yIHJlZ2lzdGVyLg0KPiA+IA0KPiA+IFBBQzE3MTEgbWVhc3VyZXMgdXAgdG8gNDJWIEZ1
bGwtU2NhbGUgUmFuZ2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQXJpYW5hIExhemFyIDxh
cmlhbmEubGF6YXJAbWljcm9jaGlwLmNvbT4NCj4gPiAtLS0NCj4gPiDCoC4uLi9iaW5kaW5ncy9p
aW8vYWRjL21pY3JvY2hpcCxwYWMxNzExLnlhbWzCoMKgwqDCoMKgwqDCoCB8IDE5NQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKw0KPiA+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgNiArDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDIwMSBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2lpby9hZGMvbWljcm9jaGlwLHBhYzE3MTEueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbWljcm9jaGlwLHBhYzE3MTEueWFtbA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXgNCj4gPiAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwLi42N2VkZDc3ODk4MWMyZjBlZDIxZGRhMDJmDQo+ID4gMTRlMzgz
YTE1MzE2OWIxDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKw0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbWljcm9jaGlwLHBhYzE3MTEueWFtbA0KPiAN
Cj4gPiArwqAgbWljcm9jaGlwLHZidXMtaW5wdXQtcmFuZ2UtbWljcm92b2x0Og0KPiA+ICvCoMKg
wqAgZGVzY3JpcHRpb246IHwNCj4gPiArwqDCoMKgwqDCoCBTcGVjaWZpZXMgdGhlIHZvbHRhZ2Ug
cmFuZ2UgaW4gbWljcm92b2x0cyBjaG9zZW4gZm9yIHRoZQ0KPiA+IHZvbHRhZ2UgZnVsbA0KPiA+
ICvCoMKgwqDCoMKgIHNjYWxlIHJhbmdlIChGU1IpLiBUaGUgcmFuZ2Ugc2hvdWxkIGJlIHNldCBh
cyA8bWluaW11bSwNCj4gPiBtYXhpbXVtPiBieQ0KPiA+ICvCoMKgwqDCoMKgIGhhcmR3YXJlIGRl
c2lnbiBhbmQgc2hvdWxkIG5vdCBiZSBjaGFuZ2VkIGR1cmluZyBydW50aW1lLg0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoCBUaGUgVkJVUyBjb3VsZCBiZSBjb25maWd1cmVkIGludG8gdGhlIGZvbGxv
d2luZyBmdWxsIHNjYWxlDQo+ID4gcmFuZ2U6DQo+ID4gK8KgwqDCoMKgwqDCoMKgIC3CoCBWQlVT
IGhhcyB1bmlwb2xhciAwViB0byA0MlYgRlNSIChkZWZhdWx0KQ0KPiA+ICvCoMKgwqDCoMKgwqDC
oCAtwqAgVkJVUyBoYXMgYmlwb2xhciAtNDJWIHRvIDQyViBGU1INCj4gPiArwqDCoMKgwqDCoMKg
wqAgLcKgIFZCVVMgaGFzIGJpcG9sYXIgLTIxViB0byAyMVYgRlNSDQo+ID4gK8KgwqDCoCBpdGVt
czoNCj4gPiArwqDCoMKgwqDCoCAtIGVudW06IFstNDIwMDAwMDAsIC0yMTAwMDAwMCwgMF0NCj4g
PiArwqDCoMKgwqDCoCAtIGVudW06IFsyMTAwMDAwMCwgNDIwMDAwMDBdDQo+ID4gKw0KPiA+ICvC
oCBtaWNyb2NoaXAsdnNlbnNlLWlucHV0LXJhbmdlLW1pY3Jvdm9sdDoNCj4gPiArwqDCoMKgIGRl
c2NyaXB0aW9uOiB8DQo+ID4gK8KgwqDCoMKgwqAgU3BlY2lmaWVzIHRoZSB2b2x0YWdlIHJhbmdl
IGluIG1pY3Jvdm9sdHMgY2hvc2VuIGZvciB0aGUNCj4gPiBjdXJyZW50IGZ1bGwNCj4gPiArwqDC
oMKgwqDCoCBzY2FsZSByYW5nZSAoRlNSKS4gVGhlIGN1cnJlbnQgaXMgY2FsY3VsYXRlZCBieSBk
aXZpZGluZyB0aGUNCj4gPiB2c2Vuc2UNCj4gPiArwqDCoMKgwqDCoCB2b2x0YWdlIGJ5IHRoZSB2
YWx1ZSBvZiB0aGUgc2h1bnQgcmVzaXN0b3IuIFRoZSByYW5nZSBzaG91bGQNCj4gPiBiZSBzZXQg
YXMNCj4gPiArwqDCoMKgwqDCoCA8bWluaW11bSwgbWF4aW11bT4gYnkgaGFyZHdhcmUgZGVzaWdu
IGFuZCBpdCBzaG91bGQgbm90IGJlDQo+ID4gY2hhbmdlZCBkdXJpbmcNCj4gPiArwqDCoMKgwqDC
oCBydW50aW1lLg0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoCBUaGUgVlNFTlNFIGNvdWxkIGJlIGNv
bmZpZ3VyZWQgaW50byB0aGUgZm9sbG93aW5nIGZ1bGwgc2NhbGUNCj4gPiByYW5nZToNCj4gPiAr
wqDCoMKgwqDCoMKgwqAgLcKgIFZTRU5TRSBoYXMgdW5pcG9sYXIgMCBtViB0byAxMDBWIEZTUiAo
ZGVmYXVsdCkNCj4gPiArwqDCoMKgwqDCoMKgwqAgLcKgIFZTRU5TRSBoYXMgYmlwb2xhciAtMTAw
IG1WIHRvIDEwMCBtViBGU1INCj4gPiArwqDCoMKgwqDCoMKgwqAgLcKgIFZTRU5TRSBoYXMgYmlw
b2xhciAtNTAgbVYgdG8gNTAgbVYgRlNSDQo+ID4gK8KgwqDCoCBpdGVtczoNCj4gPiArwqDCoMKg
wqDCoCAtIGVudW06IFstMTAwMDAwLCAtNTAwMDAsIDBdDQo+ID4gK8KgwqDCoMKgwqAgLSBlbnVt
OiBbNTAwMDAsIDEwMDAwMF0NCj4gDQo+IFRoZXNlIHJhbmdlIHNldHRpbmcgdGhpbmdzIGFyZSBj
b21tb24gZW5vdWdoIHBlcmhhcHMgaXQncyB0aW1lIHRvDQo+IHN0YW5kYXJkaXplDQo+IHRoZW0g
YXMgcHJvcGVydGllcyBvZiBjaGFubmVsIHN1YiBub2RlcyAodGhlIHN0dWZmIGluIGFkYy55YW1s
KS4NCg0KR3JlYXQgaWRlYS4gSSB3aWxsIHRyeSB0byBpbXBsZW1lbnQgdGhpcyBpbnRvIGEgc2Vw
YXJhdGUgcGF0Y2guDQoNCj4gDQo+ID4gKw0KPiA+ICvCoCBtaWNyb2NoaXAsYWNjdW11bGF0aW9u
LW1vZGU6DQo+ID4gK8KgwqDCoCAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOiB8DQo+ID4gK8KgwqDCoMKgwqAgVGhl
IEhhcmR3YXJlIEFjY3VtdWxhdG9yIG1heSBiZSB1c2VkIHRvIGFjY3VtdWxhdGUgVlBPV0VSLA0K
PiA+IFZTRU5TRSBvcg0KPiA+ICvCoMKgwqDCoMKgIFZCVVMgdmFsdWVzIGZvciBhbnkgY2hhbm5l
bC4gQnkgc2V0dGluZyB0aGUgYWNjdW11bGF0b3IgZm9yDQo+ID4gYSBjaGFubmVsDQo+ID4gK8Kg
wqDCoMKgwqAgdG8gYWNjdW11bGF0ZSB0aGUgVlBPV0VSIHZhbHVlcyBnaXZlcyBhIG1lYXN1cmUg
b2YNCj4gPiBhY2N1bXVsYXRlZCBwb3dlcg0KPiA+ICvCoMKgwqDCoMKgIGludG8gYSB0aW1lIHBl
cmlvZCwgd2hpY2ggaXMgZXF1aXZhbGVudCB0byBlbmVyZ3kuIFNldHRpbmcNCj4gPiB0aGUNCj4g
PiArwqDCoMKgwqDCoCBhY2N1bXVsYXRvciBmb3IgYSBjaGFubmVsIHRvIGFjY3VtdWxhdGUgVlNF
TlNFIHZhbHVlcyBnaXZlcw0KPiA+IGEgbWVhc3VyZQ0KPiA+ICvCoMKgwqDCoMKgIG9mIGFjY3Vt
dWxhdGVkIGN1cnJlbnQsIHdoaWNoIGlzIGVxdWl2YWxlbnQgdG8gY2hhcmdlLg0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoCBUaGUgSGFyZHdhcmUgQWNjdW11bGF0b3IgY291bGQgYmUgY29uZmlndXJl
ZCBhczoNCj4gPiArwqDCoMKgwqDCoMKgIDwwPsKgIC3CoCBBY2N1bXVsYXRvciBhY2N1bXVsYXRl
cyBWUE9XRVIgKGRlZmF1bHQpDQo+ID4gK8KgwqDCoMKgwqDCoCA8MT7CoCAtwqAgQWNjdW11bGF0
b3IgYWNjdW11bGF0ZXMgVlNFTlNFDQo+ID4gK8KgwqDCoMKgwqDCoCA8Mj7CoCAtwqAgQWNjdW11
bGF0b3IgYWNjdW11bGF0ZXMgVkJVUw0KPiANCj4gVGhpcyBmZWVscyBsaWtlIGEgcnVudGltZSB0
aGluZyB0byBjb250cm9sLiBUbyBiZSBpbiBEVCBpdCBzaG91bGQgYmUNCj4gcmVsYXRlZA0KPiB0
byB0aGUgYm9hcmQgd2lyaW5nIHJhdGhlciB0aGFuIGJlaW5nIGEgY2hvaWNlIGJldHdlZW4gbXVs
dGlwbGUNCj4gdGhpbmdzDQo+IGJlaW5nIG1lYXN1cmVkLg0KPiA+IA0KVGhpcyBwcm9wZXJ0eSBh
aW1zIHRvIHNwZWNpZnkgd2hhdCBraW5kIG9mIGhhcmR3YXJlIGlzIGludGVuZGVkIHRvIGJlDQp1
c2VkL2F2YWlsYWJsZSBmb3IgdGhlIHVzZXIuDQoNClRoZXJlIGFyZSB0d28gbWFpbiBjYXNlcyBo
ZXJlOg0KLSB0aGUgdXNlciB3YW50cyB0byBtZWFzdXJlIGFsc28gdGhlIGN1cnJlbnQvcG93ZXIg
Y29uc3VtZWQgYmVmb3JlIHRoZQ0KZHJpdmVyIGluc2VydGlvbiAoZS5nLiBmcm9tIHRoZSBib290
IHRvIHVzZXIgY29udHJvbCkgYW5kIGlmIHRoaXMgaXMgYQ0KcnVudGltZSBzZXR0aW5nLCB0aGUg
aGFyZHdhcmUgYWNjdW11bGF0b3Igd2lsbCBiZSByZXNldCBieSB0aGUgZGVmYXVsdA0KY29uZmln
dXJhdGlvbiB0aGUgZHJpdmVyIHN0YXJ0cyB3aXRoLg0KLSB0aGUgZHJpdmVyIGRvZXNuJ3Qga25v
dyB3aGF0IHR5cGUgb2YgaGFyZHdhcmUgaXQncyBkZWFsaW5nIHdpdGguIEluDQpjYXNlIHRoZSBw
YXJ0IGlzIG1vbml0b3JpbmcgdGhlIGNoYXJnZS9kaXNjaGFyZ2UgY3VycmVudCBpdCBkb2VzIG5v
dA0KbWFrZSBzZW5zZSBpbiB1c2VyLXNwYWNlIHRvIGNoYW5nZSB0aGUgYWNjdW11bGF0b3IgdG8g
Y2FsY3VsYXRlIGVuZXJneS4NClNhbWUgaWYgdGhlIGhhcmR3YXJlIGlzIGludGVuZGVkIHRvIGNh
bGN1bGF0ZSBlbmVyZ3kgaXQgZG9lc24ndCBtYWtlDQpzZW5zZSBpbiB1c2VyLXNwYWNlIHRvIGNo
YW5nZSB0byBDb3Vsb21iIGNvdW50ZXIuIENoYW5naW5nIHRoZSBzZXR0aW5nDQpmcm9tIG9uZSBt
b2RlIHRvIGFub3RoZXIgd2lsbCByZXNldCB0aGUgaGFyZHdhcmUgYWNjdW11bGF0b3IgaW5zaWRl
IHRoZQ0KY2hpcC4gIA0KDQpCZXN0IHJlZ2FyZHMsDQpBcmlhbmENCg0KPiANCg0K

