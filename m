Return-Path: <linux-iio+bounces-9361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C5970F66
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 09:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C981282872
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7C1AE851;
	Mon,  9 Sep 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="b91TrWR+"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4E21AE025;
	Mon,  9 Sep 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866116; cv=fail; b=Tek4RM0mE4/JsFROIU0KsJgcMANgXqog5bDEOLLUwN5Fl2EkYfrdKTClI0aKTdywMDXtS5+UhJxLoxVnCO8AUa4xpb8cTPRgW3flnfRYIE6YaAVlCwln8bOEdT9LsF/74R0y/7JVhd+INwCJhhdtlnSBZohkyYfdy04yvVHQpO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866116; c=relaxed/simple;
	bh=d9qIVfkYmewqIoPPY4Qx+nQB1937UHLjEfWz+L8X7EE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iktXLVr6/6RK4puJf1PO10D072WDR8Fb9rkO9fjAquLXlqZ5jf9IMlfHMrH5iPrzSTPJQDsdhSBQ7jNxKBoCZiEA4s/uY2JBJaTnUHPOfk8hN9fpZw6dKHa+Ukx7GLWWB0ysE1FRhz1Nifoo1sdlt7jFJeR0E3BMkv05mpxAlKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=b91TrWR+; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f95yypKcfyAsdcgQYtj/jwCrbbtSxg7hoCJwZzEdzuxxx2/Ix8vJNwOiqC7Nxqi/WztjsAhkms2e8Nr8hkjxKWQzpnLr27nXaeOHEvz2lOYJqrg/kg40yW8owhmVXeDz6F8NHqXtaAL0RnvZBYJ7td+QY1f9wMQzsVM2/8TW87/Qp2xYXrNCWkE8FTUw3y1ExcjjdSq77xF1kNpaTHYghAmWTVf6yOQ4PxYGsEBy0PNHStm1zyh5n+N1/nGEX1IqleCPpbQITj8JYJuPp3Rw5Tl3H1rPfkjFk3ofa41LkuILVoT0f3zAajXEMeR32a3ob9Dik+ED8aZwHc40SDkKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9qIVfkYmewqIoPPY4Qx+nQB1937UHLjEfWz+L8X7EE=;
 b=feHFZt6hXbzJP5KkiRu+YV0l4SIx0QcXa9xaROYBZhowi1iDEuYas3rju26Exk6+staXNKadLa8WN5d8jmnvxdzJWL0WY+0YaKDgQe4apCOUjxF9q9HGkaqgbVIucNXO9LotWjVezv94R1wA2RqRkYKM/oJ84Iu5nLaoJmA80H0Arux7Q8XK9Us9QFSCLivxqYW4NTOTGGyAowgOpGqSf4Cl8biII4bgViLABEp0jPuC1lwnhzjAXxaUDaCuTkqAnKEbZHlR/XyuCpDmJZzuL3mvG4QmhmTWtpKIfT1vFbqw8Iiagu764XLHRxkdDBqqm8ngJb3SSLHI8+9BLkaNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9qIVfkYmewqIoPPY4Qx+nQB1937UHLjEfWz+L8X7EE=;
 b=b91TrWR+SAuqivfbp1noVtjsNkY1uOdzkWPKxiHurtByvRFswQjB2xk3XziaCmaMjuGgfx1ebPvS9AK1QvXYIcp6suRPgOey3TeLgffuQS+RFEmeNY4iPFeGgA7e5P3ok6NDA4ik9NXjFwjmX4qf88N4LGczwWsDklGQHow3m9A=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by PA4PR02MB6847.eurprd02.prod.outlook.com (2603:10a6:102:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 07:15:08 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 07:15:07 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH 1/3] iio: light: opt3001: add missing full-scale range
 value
Thread-Topic: [PATCH 1/3] iio: light: opt3001: add missing full-scale range
 value
Thread-Index: AQHa/312ydxRmau8fUOVc8C2DiT+YLJMl7QAgAJ5UIA=
Date: Mon, 9 Sep 2024 07:15:07 +0000
Message-ID: <a9021ca8ec6b52cbbac744ccced14aea605a1da4.camel@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
	 <20240905-add_opt3002-v1-1-a5ae21b924fb@axis.com>
	 <20240907182824.56396b0a@jic23-huawei>
In-Reply-To: <20240907182824.56396b0a@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|PA4PR02MB6847:EE_
x-ms-office365-filtering-correlation-id: 11b1b8f6-4e4f-4b19-b396-08dcd09f2298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFh4UlQ2VUg1Q2hXeFZINjRoWDFuQ09mYU01NlVwODFscitLaTc1UmhxQkFS?=
 =?utf-8?B?ZUhvMHlnVWhRNXdJTktRNkE4eVFKTERJMmVVcjlpc0JMbXQvMm1zaXlWN1Jp?=
 =?utf-8?B?MzNUZkIyMFlMb3ErVjNyWTZPdFBQN284dGhVU09oLzhDQ3BGclZ5cFRvZ2d0?=
 =?utf-8?B?S3Y0ZitTQ29ubGlEM2gwa3ZnamhrZGkxcXVwUnIvTnNhQVFZeGFDQUg1TWpW?=
 =?utf-8?B?MmVkSkN3SXBwMG96V1NoRWxNVnVyOUttUzQxRElJYXFzU05hN2ZHdEEvaDhO?=
 =?utf-8?B?TitKSUVMUDdnVU1HYWM3dTgyMTllUzFMOVcrWXBmK0tMbGxQUHdMd0JIdlh6?=
 =?utf-8?B?d3VnZk5ybDBrTWZDTWdPZzk5ditTUi9OcWpKY1EvMVd3aEswNW5DamRPaXZz?=
 =?utf-8?B?cXQ3T0dOSllSdnBZT002cngzSkFWWEJXSWRwMU9xd21yOUdsb09wVEhNaDZz?=
 =?utf-8?B?TG1sTElUNk1HK1hscmdZRU1tTmRZZ3dsckhyL0ozL2JIZXVxYkxZdkdPZ2NH?=
 =?utf-8?B?ZkRuNXduMStJYXRVUnVoNFpyNVI1SEV2WW1iK0s0dm0rR2czQjR6dEloMnRH?=
 =?utf-8?B?NHhVV1NhRGhhcEtyT1ROZzRWREZjNVdZNm9mck1HWHppT1hkeEVOUzlSdDdG?=
 =?utf-8?B?cEdnNXpCWTBIMkdIT2JCQlRCMEFoTU5kL2ZmMEtOeEpBb09pemVHRkIyM1dT?=
 =?utf-8?B?TmI2ZXgxSXR2ODh1bmZaVUwwWUFRTENCN3psMzRHMG52RUNxOGE1eDlFdzhK?=
 =?utf-8?B?Y0lqc2ZCZCtQd2hENGFLNXcvRzg0TGNCWWNIRVhuTDFySytDcStuL1lGTnJv?=
 =?utf-8?B?azhvQzhRUm8vMWs1YXpFWGdWc1ZyQ2VZMGRtb2UrMUQyNEYrL21lOVFaWWFm?=
 =?utf-8?B?V3grdytTdmNqQTFWRm1QbDZjSGFPOVkyaDRWNDNtUnRrS1RhNkZhWnN4REpN?=
 =?utf-8?B?MWxURXc2WDNNQXFTQmorRmRxZmw4cW01bGVCMzl0SXgxS2k1SWNLWWI2TXNB?=
 =?utf-8?B?NkRGUXUzdVo5aEF5RTcrRGM0Q2RDMnQ3YThhYmVadnNQUUdGMTIwOXVOWjh1?=
 =?utf-8?B?dlQ0SmVEOXhqclJ6Nm9BZEpjcXY2SjMwM1Vxci82VnNueDNtdEpvdmwzVVdL?=
 =?utf-8?B?V3JHSG92V3pUaDU0KzBHa3B0emM2UWF0TXVnSlpuSUtTKzFVYzVoOEx3TmFQ?=
 =?utf-8?B?T1BnUS9QRG1ML2ZLeXhKRllpcFU2a1VBakVUU2IvY1Y4QS9GTFBMNmR5Tis5?=
 =?utf-8?B?amYwWnpUWkQ1ZUFHMkE5THU1YmxnemhIWnRKeVVSUVIyTjh3N0krd1p1L1lU?=
 =?utf-8?B?WjV5bXRrM0xTNHEvU09VTlBwUEtvVnB3Znc0dkZsa1Z2bFhnSjIyWFFlVXdv?=
 =?utf-8?B?aXpkbGVWYkRTZngxbHM5d1NqR0ROVXFGWjNGeU1GbW9QVHdLSGNUUVd3VnFa?=
 =?utf-8?B?RzQxbUNFWVZDbngyMXB3YXNqUTlDSy9ETXR6MVFFbUt0dHd2aHliUnh0eHZ3?=
 =?utf-8?B?bDlsR0Q5djRadEROQ2VHUGNUYWk3Qm4yOXNOMFRLZldNTWdHbnJWL0t4V09n?=
 =?utf-8?B?eTRmRDV5NkVIa21YcHc1QkRrUUhmZ1A4SjRYUTlmRFd4dUtjaVBTVGMwby9w?=
 =?utf-8?B?SExSK1ZHSndWRDFLRWp1eW44SHlaaHVaSlVZN3pUTWpSOHBWYnF1WG8wWnRz?=
 =?utf-8?B?REx2UHVjNlNRSzM5MnNSQUFmcjJCYkdHQjNtcGdIeVg3d3l2NUNvQXFWYVRB?=
 =?utf-8?B?SzNZQTVIRTR4YlAyQUFQMXZNK0RWa0svV3lQcVd0cmxTOTdCN1p4NzAwY1Ji?=
 =?utf-8?B?YjEzbWFWU3dhS2NPRm1kRllVbjRHZVZqN0M4L096N0FtenpzQlJhYVY5UVlC?=
 =?utf-8?B?OFlDc2p4WWx5aW5RTVl0Vi9HbzRDVXdCTjlHQWh4RWtzMFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEJJd05GSkJjLzBZendFQ1ZJdzIvcHUyOXBnVk1YZ2ZZc0FoT2xQNTA1eXVN?=
 =?utf-8?B?M2VmR0RJdFBhelpPU3piRWRTYWg5N2JoUkh3QUVFbmlocW9HREU2MCtzK2Ux?=
 =?utf-8?B?TFd4V1VCK3RaY2hxOXZ5aWhOWEN4S2FIbEg0Vlk0dk1wS2hqTE9ocHJyeUtB?=
 =?utf-8?B?NWJXcnNIU3dCYXkwSFl5WkozY0UxdU43ZFRjVjhvczJzWnpZSmo3RnNhekcy?=
 =?utf-8?B?aGpjKzRXSHVDTmpDQWZTRzRGTWNEWWE4K3NMRWZvdGJyNm1GMlhnNlpoZngy?=
 =?utf-8?B?VEJBWDJpK2pTSzBwa1N1Ti9mOEpqMXhSMFNVbUlQVmhEVUF5bko0ak5ZUURD?=
 =?utf-8?B?cVNiQlQ5dEc3NUd5N0UzbWJKUFllcHQrV3dORStpZ3pHeU9Kc1dtTHVCK0p6?=
 =?utf-8?B?d01EK0szdXFCUGt4d3pqTUZjdmdabjRLQk01d0Z5SjBzYXhTSjI3N3JycnBy?=
 =?utf-8?B?VUdMWXN5UWZIOWhCZDBCOWpYYnl4THhsV2tNZHZ4clVsc1Jac25lbzNsSTM4?=
 =?utf-8?B?YUhJdHgzaVRUVWMrTnVhdzBXaHdMY1VISml6VUNES2Z0VU8rZ2NleWpqVlZE?=
 =?utf-8?B?MUp1eXB4WERzNnVlNU5HOEtNYUlRZE1WTmV1YjNBcnE0MzBpWUovN293bHdX?=
 =?utf-8?B?T1NmR1o2K2FQejhvK1d0VWpwMjN4eHA5VHlBUkhpRnpTUmVGK3ROWDlSUEUx?=
 =?utf-8?B?OG5XbXBHcmJueS9GRkgyTGtVN216U0ljaGx0Y0gxaFI4NkNxWUgvZ254alVX?=
 =?utf-8?B?L2cxaW4rRWVva1dGMWR1WWNTS0UyNDFYblNvelM3SlBuMzlXbk9uVHRmSlZm?=
 =?utf-8?B?VlRDNnNML2FJT3NuYnZXdHR6MEVET0dQMWExb3JDZEJwdGlqdC9jVFpDNFoy?=
 =?utf-8?B?MnI5Sk4yb0MreGVEY0RIdjNTUWlVaE1kaVpXRTQ2dHJMZUNXVUFnSlFndnlF?=
 =?utf-8?B?UUVqc2FaM2FTSzhHTTFtUVMxaFB3V3NBelp4VTVHT3MrQTNSSDcrZ0ZjK2hF?=
 =?utf-8?B?VGxoUG1JY2ZoYlhhbStReHQ3RHJjc2E1RysxR21TWVZmWTlTdXdNbW9ONTF6?=
 =?utf-8?B?cDB1QnJlWUlKQVRDb1BXby9wMkJrbGcwUFhvbnZibjlrQWNtdFJ6TmdKcFBi?=
 =?utf-8?B?WSswTG5aWm9Xb21kVm9HM2NxTFpJT2s4VnN6Q2JTdk44RENYaEIzQk0zMHBU?=
 =?utf-8?B?SUg4NjhxbmRMck9EalBkaDhaMGhMNmMyZndhaGRnekViRWZoQ0hGdnBjSWFE?=
 =?utf-8?B?N25tVDNVa1hHK0FWVG43S1ZBdVlTSHJPd1d4Njh2Q3Yra0p6ZDZwdVBwTERS?=
 =?utf-8?B?TUI4dnZOVHIyWEpxcFZsU2RiMWk4TkZSUFl2NkZLTWFNQVhxaGpQMlRyZUxl?=
 =?utf-8?B?UVV6dEdoQ3g4VlByR25RamlkYlI1Zmc5MTJEeDQvRUZoQjFrOE94MWE4TnlR?=
 =?utf-8?B?VUNpWkdVREs5bkpMbmVnUVNVS0x0YWhTK0l3aW5uQ3p1VVdGRFJqUnl2eEsy?=
 =?utf-8?B?UGpvRlRURDNyWTRKTEdpVnFKQTdZYjZvZC9xQ3BCdUNHNFY1bUUzbE1VT1V5?=
 =?utf-8?B?UWcxYVVyNDVESWo5RFFHZngxYzRpdy9zSEo1aXFYWFVVSXR2N2JJalJzY016?=
 =?utf-8?B?U3pYM3NERnQvNTlwTFFJbCt3dWJkS2NqL1FqREc2WWRyaUorODRaSVpKbFRR?=
 =?utf-8?B?aG1BaTBuU3pOMXVFeGI3RzU3di9NYTJ2VXBnbG5PSU9QYWlIRmEvRHpsTlZG?=
 =?utf-8?B?YWlnVU40SmNDYk8yeXo0M0Q3ZG1YTTVpVXcxbWlIU1h1TTRvZ1lCdGNJWUVJ?=
 =?utf-8?B?b05yMXI5dmlRZ3F0TFJ3Sm1YaE5xak1pZXdDYU5BSUJkZWE3SFVTbGM0c0Zz?=
 =?utf-8?B?c1JPWnRFTC9scXRDb0lqV1d5SUhJTE1seW1tS3JoVHpLWDBWV1FwZnk1Yk1j?=
 =?utf-8?B?WUszcndZblMxaU81dDdRcm5iYzBzK3VOUEYxZWljTWlYMFRQbUNsUW9IZlRO?=
 =?utf-8?B?NUdEYis1Z0JVUzgrTXpqMG53MHFVaUkyQkhnR0tXUWt1cGdHUE1WVHJyS21q?=
 =?utf-8?B?ZzFzQTVPd0hDbHZiWWxrcFdOdzV1d3hEMXdpY2tKUjlaREpuZnMwWWdIKzlu?=
 =?utf-8?Q?dSWfBd7VpSiAdUmr/CotLPQ82?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B3095B6E13BAE49BD9242D8BC43508D@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB5784.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b1b8f6-4e4f-4b19-b396-08dcd09f2298
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 07:15:07.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+VFY7kezzYLp7DZLHhS3qbdOvOifHUjdfNXiu8It5nz8ypB2Fz+u4FIbHaZpV52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6847

T24gU2F0LCAyMDI0LTA5LTA3IGF0IDE4OjI4ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUaHUsIDUgU2VwIDIwMjQgMTI6MjA6NDUgKzAyMDANCj4gRW1pbCBHZWRlbnJ5ZCA8
ZW1pbC5nZWRlbnJ5ZEBheGlzLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoZSBvcHQzMDAxIGRyaXZl
ciB1c2VzIHByZWRldGVybWluZWQgZnVsbC1zY2FsZSByYW5nZSB2YWx1ZXMgdG8NCj4gPiBkZXRl
cm1pbmUgd2hhdCBleHBvbmVudCB0byB1c2UgZm9yIGV2ZW50IHRyaWdnZXIgdGhyZXNob2xkIHZh
bHVlcy4NCj4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IG9uZSBvZiB0aGUgdmFsdWVzIHNwZWNpZmll
ZCBpbiB0aGUgZGF0YXNoZWV0IGlzDQo+ID4gbWlzc2luZyBmcm9tIHRoZSBpbXBsZW1lbnRhdGlv
biwgY2F1c2luZyBhIGJpZyBnYXAgaW4gc2V0dGFibGUgdmFsdWVzLg0KPiA+IA0KPiA+IEFkZCBt
aXNzaW5nIGZ1bGwtc2NhbGUgcmFuZ2UgYXJyYXkgdmFsdWUuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogRW1pbCBHZWRlbnJ5ZCA8ZW1pbC5nZWRlbnJ5ZEBheGlzLmNvbT4NCj4gSSBhc3N1bWUg
dGhpcyBoYXMgbW9yZSBvZiBhbiBpbXBhY3QgaW4gdGhhdCBpZiB5b3Ugd3JpdGUgdmFsdWVzIGJl
eW9uZCB0aGlzIG9uZQ0KPiB0aGUgaW5kZXggd2lsbCBiZSBvZmYgYnkgb25lIGFuZCB0aGUgdmFs
dWUgd3JpdHRlbiB0byB0aGUgcmVnaXN0ZXINCj4gd2lsbCBiZSBpbmNvcnJlY3Q/DQo+IA0KPiBQ
bGVhc2UgY2xhcmlmeSBpZiB0aGF0IGlzIHRoZSBjYXNlIGFuZCBhbHNvIGFkZCBhIGZpeGVzIHRh
Zw0KPiB0byB0aGUgY29tbWl0IHRoYXQgaW50cm9kdWNlZCB0aGlzIGJ1Zy4NCj4gDQo+IFRoYW5r
cywNCj4gDQo+IEpvbmF0aGFuDQpIaSBKb25hdGhhbiwNCllvdSBhcmUgY29ycmVjdCByZWdhcmRp
bmcgdGhlIGJlaGF2aW91ci4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbsKgDQpvbiBob3cgdG8g
Y2xhcmlmeSB0aGUgbWVzc2FnZSwgSSdsbCB1cGRhdGUgaXQgYXMgd2VsbCBhcyBhZGQgYSBmaXhl
c8KgDQp0YWcgd2hlbiBJIHN1Ym1pdCBhIG5ldyB2ZXJzaW9uIGVpdGhlciBsYXRlciB0b2RheSBv
ciB0b21vcnJvdy4NCg0KQmVzdCByZWdhcmRzLA0KRW1pbA0KPiANCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9paW8vbGlnaHQvb3B0MzAwMS5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQv
b3B0MzAwMS5jIGIvZHJpdmVycy9paW8vbGlnaHQvb3B0MzAwMS5jDQo+ID4gaW5kZXggODg3YzRi
Nzc2YTg2Li4xNzZlNTRiYjQ4YzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vbGlnaHQv
b3B0MzAwMS5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vbGlnaHQvb3B0MzAwMS5jDQo+ID4gQEAg
LTEzOCw2ICsxMzgsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvcHQzMDAxX3NjYWxlIG9wdDMw
MDFfc2NhbGVzW10gPSB7DQo+ID4gIAkJLnZhbCA9IDIwOTY2LA0KPiA+ICAJCS52YWwyID0gNDAw
MDAwLA0KPiA+ICAJfSwNCj4gPiArCXsNCj4gPiArCQkudmFsID0gNDE5MzIsDQo+ID4gKwkJLnZh
bDIgPSA4MDAwMDAsDQo+ID4gKwl9LA0KPiA+ICAJew0KPiA+ICAJCS52YWwgPSA4Mzg2NSwNCj4g
PiAgCQkudmFsMiA9IDYwMDAwMCwNCj4gPiANCj4gDQoNCg==

