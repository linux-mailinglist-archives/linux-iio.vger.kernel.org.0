Return-Path: <linux-iio+bounces-20732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5670ADBF76
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 05:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4641B173FD7
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD522AE7A;
	Tue, 17 Jun 2025 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GASaUkve"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764A186E2E;
	Tue, 17 Jun 2025 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750129637; cv=fail; b=rEByNUdeFX83NlG6qhh2HKUUR5IhwHkIB9+7RoubjPBA/rd87Ihc+qMvEtPO9zfYaCupCfIZdQvICT6aPPg/4yFH3/gnlAAE0x/T+iyC42JCiexxWSn0+NF6TOJw7D62upvnhYVxw9vX6rQC86PKMMZf/uN+9obzkwTHEagMlCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750129637; c=relaxed/simple;
	bh=QpcmXr67hefMnVN4X4x9+5DnBmrMLOWID6QE0HgZh/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U/T8Rmy/D4ykS1b1/IHwZI3SGY/wAcHzwVeosB3yCMp4zLQTbaFLmIWWe3LlmQ37iHsR0sc0rPYrhqScphxAzpn04Sv316alU7nQJvqcle8R1IpGxdBjLR9yBVNcFlwNmP0x+xiMinddaOA8M01/QwIimEGQxFwTG/ey8W6B1Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GASaUkve; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wvr9oMFIJUgYiJG2gG6GCvRdzuxD8hoqjVOjRH90HnBcPqgtv0C9vbPa+VGNgboTh64mqph8x2UdqxoCTPSznDsdJuTuW9zlHs5j/p/8TCikfT4Syx0fxJVj+mkh3Xv/CcKiF7WUy1ApjFsLfKQJ3jLmkK0pkR3mnX2rjGRAvnCFkRqlatCZQvUycwYEIa/+cx3itqKjMakLplGCuMVnLeeveob1/ekVyveczMQHBuhxnMRbww6bAKIa8Ey5wQ3t3m5DAEFoOjU0fh4AxotPVwPcupr2kIv3k5ZMY6CQ+PsXw+mZ5XcVqSv6rKGICPmookU+nACZg7S1ke+RKHX4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpcmXr67hefMnVN4X4x9+5DnBmrMLOWID6QE0HgZh/A=;
 b=jjceWAG0LUFF1PeIOoJVhKe/xfTmoWmV+BcCZOeyGs12qaE6lOwUqNAQITla+PVYSe10BZMhzXJZSLFnTayY40x4JeRzDe4FMSccCJ8yK34r4SZa6aDOGh0Rqkx3+R61Bb59D1xlD+/Ko/uUx3/wqKPY9SKVBwaySXEi6ez7JDQaVJTR3sWfM79guaiPZkeZELvmJ0v9UMD2egRC+/p6TpQxykTZ6PTTaeZLAQo1ES9vIu5hHEmPoq+CXevWRa4SX489HYQVpyL7aZLXocqDYBLRAUkNIdsyPWyMe5QJxQvNFL0XSBanHcdt3hMLvtLmigclzRgB9Ld0imuVjzxC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpcmXr67hefMnVN4X4x9+5DnBmrMLOWID6QE0HgZh/A=;
 b=GASaUkveR6aZi+xVO/ogiop9atrosBAVCIFpncpYIz/CGjMKcmjtDuKpPHZU5OgRaRJF97zoq6qyYxYDE1R/J5ynn9956FZj+Nr8oOrMTO1JZAIfR6Fxh3MBfO1+ogGvaoJIGg4gPxv5rdlZCwPMNvdeDXE9L1XDnS5kTMuRxqIfsTlOMf/dQhOSQ/M+DjxyHGD+xoPUp1w6rXzbv859m8inyIQ78Ce6obhiD/97rdB5pndaqytVp436YFHx+aYH3WePqDOcOqelxdaCBismYyOss1PPJGQGdFkWFPlAfMwnYE+lblpEKNvcNyN0416ngIQwVYeRd2GrQgcw94gPRg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB9254.eurprd04.prod.outlook.com (2603:10a6:102:2bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:07:11 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 03:07:11 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: imx93_adc: load calibrated values even
 calibration failed
Thread-Topic: [PATCH] iio: adc: imx93_adc: load calibrated values even
 calibration failed
Thread-Index: AQHbtCXgJqu9eggsy0WsgRqrVmHGkrQHAUYg
Date: Tue, 17 Jun 2025 03:07:11 +0000
Message-ID:
 <DU0PR04MB94962C741E378CAC3F8910E69073A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250423-adcpatch-v1-1-b0e84c27ae98@nxp.com>
In-Reply-To: <20250423-adcpatch-v1-1-b0e84c27ae98@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PAXPR04MB9254:EE_
x-ms-office365-filtering-correlation-id: bedf4d67-a750-48d1-4507-08ddad4c0d7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDJLMmpoSWVlRDR6U0pqQ21za2NCS1BES0NYWEo5SDhhQkxVSEZQdE5xaVIv?=
 =?utf-8?B?MTFYYklZMVgyeGRnQkdaUU81VE1sWjdNb2R3UThxZy9zMFBSVU9QeDdkUFc3?=
 =?utf-8?B?T1JhQkgwMnFLRitzWjJQVHBESWVMYnUyREtvNmhMTE1XR0RHeFRzalRCMGRY?=
 =?utf-8?B?QWVUREEvQWl1MXRVeW5BbFh4bXdkMThRUUtwNFgxTy9Zelg4MDg5TmsxaGFq?=
 =?utf-8?B?WHN6enhKUVk4Sk9MTUpEaDNVM016NGZoWUJTVGtMSlNOOS8vOXF0NUZnNjFx?=
 =?utf-8?B?M3VCMW03U05GM2JiRis1RzFTMzNjeDVmZkxoYVNYMHpWdTNyK3lTc2ppeDQ0?=
 =?utf-8?B?K1Y0aTNRUGdrWWJUNXJCN1YrVno0NDFtazlBMU1neXc2M3pOVHV6bHNydFI0?=
 =?utf-8?B?N0Z1WEVjODkzb0dZMi8vOUIxa08zVXpSZk5DSlJnVEYxRllremhqMlR3Wk81?=
 =?utf-8?B?L2F5VGVyd1pLWWZrdmtaMGJudzBaMFoyMm9zUDNrS1NYbHRvaFhuQ2NKWEEz?=
 =?utf-8?B?MVR6MzlWU2xHaHRTK2hNZSszSWNIR25ldm5YU2NKODBDaHZDbWlBcFhqWmdk?=
 =?utf-8?B?OGJKQnpicWs4Uy9GcnExL2lhaEorS1M0d1piWkx0OHV4UkFqT3BJTEhsRFpn?=
 =?utf-8?B?TFN2YjZEM2lDS3pzd1BHdFRXeE5oVXNEZStUUm96Y2FITkFYWkxEcXdobG42?=
 =?utf-8?B?bWthVE5DdnQ0UUtyNU84N0szWGExRVVrdXJZTm4vTStEa21GejkxbUZzdTZR?=
 =?utf-8?B?U3k3T2k2bXkxbWJlU3oybytpWnFaMzloVTdEYkxacVYzdXpOdkMyNHptclA4?=
 =?utf-8?B?THA5bmVMVFNzQ0JLZWdMRHNlRVBjODBwRzRRSzd6dTMxWERzc2xtYUFqUTdR?=
 =?utf-8?B?SzRlZDNka0FTYlY4VW5WaVoyenl4ejZ3VDhOSXdRUjZjMHVlc0hObkE4RlVs?=
 =?utf-8?B?TzlyWHp2cjlZT1FSano0dnRrZHowY0UvK0ZSdENQamhraDBrb0FRYTRhZE1H?=
 =?utf-8?B?bTd1cUd3VTQwS2Y3bVM1OWZLbWFrN24wUW9PSDZFak1OT2N6My9qbHpDd3Fq?=
 =?utf-8?B?cmtwbndaZHZ0RnZ3c3VZbEppVUJ2SThIOE5VcjA5RkR0N0R0OWkvZ2NqRm5w?=
 =?utf-8?B?ckNuZUk3bHBKNk5NOFNzWGpqVUp5NXQ2SkZrUUFEaTE0UUhuT3RZTmxrM0dV?=
 =?utf-8?B?Tm9VbW1UM040T2NPdVI1UkhNVjhsd2JxMWRVWEhzZVlnb28yRklXQTcrNUQ1?=
 =?utf-8?B?V3cweTMrRDBJNExVNzJYeDM3c3ZjcTU1VlJubWIxUktLbFVWTkFvM0ZkL1pO?=
 =?utf-8?B?Z0hSSzMydTBBZmthMWQxQkgzQnZ4L0ZVdGpLQTdCcUR6a0xKSTYyZmN4TVA5?=
 =?utf-8?B?akpzZEtTQTFPTEI2b09qY0tZcFU1TFJ0clptNzNzbG5vRUN0Wk9OZkdHaXZr?=
 =?utf-8?B?TlMzcUNpZlEvam50R3Y3MkQveElIemxHYXFER1BRNkhSVkFIcjA5cE5pSzNn?=
 =?utf-8?B?RmxRZER1YjNrd1kwWEVnZ01JSWFNQXNnNmlpWVdQMStydS9FMnNBUDhTSkRo?=
 =?utf-8?B?REV5MEwzU1M4aWRSaDFZVjlMT294VVRPNVRlL0ltR0xVWi9FTGF3VnI5L1k2?=
 =?utf-8?B?VGVreE9aQ0pSUkNtWGVtS0xxWHVWRnVLYXB5RnJNeklDTTJXOVBlZnkrZjdn?=
 =?utf-8?B?dXVFdG1jSi9TRVFNUVJMK3Q2SXpUYlNaSjVkK2p3aGJueFNKQUthWlNUaVF6?=
 =?utf-8?B?aEJ1MjZmbTNDQkk4RmkzNjZITXVSQzBwcW9xQ2hGSllqWWNVK21id0VMMU5z?=
 =?utf-8?B?YU1JZlJtS1U1c2l2dG9lVTBzVkZNbmJwOGdUUHhqR2ZTK0dGa21Cdjh6UDlX?=
 =?utf-8?B?U1doRWN4cURuYTcwK25OZWNuaHZyL3dUcW4vUGk1eVBENDd5bmx6aVg5Wjc0?=
 =?utf-8?B?OTdqb2Nsa1U5Ny9mZmN6amVPRTZVVlBHZkRkeS9VYUpJWFJNa2dvQXpFdHRa?=
 =?utf-8?B?MG1mNDVoTFFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ak1XQ1FMVktORnVQLzJFc0YzTy9BYU9HTytDNUlkbWpuSEFtSVQ5RExjdGlS?=
 =?utf-8?B?RzF3Tytnak9pZi9oME5uaENDTUN2dGhDR0Q4K25MbThRRVpFdjdkUnpKR0Mz?=
 =?utf-8?B?Y1lEWllCb3lBWjFpYThvdUsyL2Z5Nm03OTVkaUFnNWl4SDlNS3pCaVc5R1hu?=
 =?utf-8?B?cHl3MjRxbC9PRVhicHlkOHZaTGl0ekxMU1VsRkkvbjhmSjZjV2NBeloxeTEy?=
 =?utf-8?B?bkpubERkSjM2aXYxM0hCRVR6QTJXTVpBN0ZTZFpMSTF2MFR3YkFEQkh0dHY5?=
 =?utf-8?B?WUFRcE1YQ29VV29KTVlxL2NDM2REaUlqVkhwMzhYTzdpaXdjS2JGQ2pNREN1?=
 =?utf-8?B?cDN5MzlESUtBYXNOdFk5bERpMStZVnAvNnZVWGRFa2RLZ2d2OEtmYlE0akw1?=
 =?utf-8?B?czNYUTJ6d0RQeGZ4MGlnZ0JmbUs4aUtmOXRiVmk3K2VORUl5bm8xYUNNUU5R?=
 =?utf-8?B?aktCbzk2bTdJaUdkL2RlUWZWTGg1MlM3QUlNcFJnOUNtQ2ZrMEV5ME5XTitm?=
 =?utf-8?B?WjVxZSsyN1Z4YmwxSDl3c1l4SDAyRUNHRXVaaWNTSlpNMStDKzd1ZVBPZll6?=
 =?utf-8?B?d0EyMzlwZHVKbkc0SkpuU1l6RjlIcUlJWTNQZGpiaTlrdlhmM2I4aFdGaXgw?=
 =?utf-8?B?TW45bTQyZFBVQW8waFp0TlJTWDg0RlFRL3JCMUtaQ1Y1NUhmM1ZtQno1aE5o?=
 =?utf-8?B?cFlZN2F1SUpsNm5ZczFkd2MrcHowNHMxMityaW1zRmEzQlNqdzVmdHg3Yzda?=
 =?utf-8?B?UFR3eTcvUEpPUmJ2eDltSVpLcS9uQXljN2xQSmRRZDhscXI4TFBWcmNGZWQ1?=
 =?utf-8?B?RlgrZktsSUZyTk5YNFFMWDhXT29QK1U0dzRQUHdlTVZnNDR4eEpSdFFOQ1hQ?=
 =?utf-8?B?eHNDWkI2dFl0REhFM0JsVEU4bS9WWEdzdVNoNDVQK05BOHVUemFPNjlVMjND?=
 =?utf-8?B?dEUyQWxrSHhyc3BSNHJYSTlwVm5pTUlUYmJQMkJtOHNKVU9pTUtjQ2tWaTZ4?=
 =?utf-8?B?WGwybmM4VU5LUzFtNGI4dHdud1JQNFdjS1dnSDJhTEE5NkFiV3AzVlhPQVNy?=
 =?utf-8?B?NEtiT3ZKMm5nWmRhcEZCQkV0OFg0eWFOQ1R3cWx4Z1Z0ekZNODV5U0ZZallH?=
 =?utf-8?B?RzhwdE96SzhsWFhCZ2lSay9WSlFFdDdnd1NjaloyaC9OeG1wejlvZWxZLzVJ?=
 =?utf-8?B?TFV3RWZnY3BYaUxYSkdLcEE4eWpnU05tdUgwWVhsZWE2V0RDanc5VGZJUjMy?=
 =?utf-8?B?aVI2QnhnYjIxT2laWFlHdnQwUSt2NUhEei9iOFRKL3pObFY2UlprN2Fhamxr?=
 =?utf-8?B?RG9aTzZOZUZxNVVDaHBtK01YNFlDOFhmY3lUL1UyUTZJS1Y3eCtaRmRMaWRJ?=
 =?utf-8?B?cGl1QkVWVmpHRkpoU2ZMZWFoaTl1alJjSHZnc1NuVUVtTFk3Q2lYVGdZLzBK?=
 =?utf-8?B?RUdydDZ6OXMvcCtMK01ZV1VyR2loNXBFVkZ1ZzhBeGNYMUp0WUYvY3dtTXFl?=
 =?utf-8?B?dFY1YXd3clQzV0U1ZHZXQXpMbTBQeWlQZjJXTGtkZXNvV3NNbjRHUE1WclBt?=
 =?utf-8?B?QWlYTGZpSXUyZ0NYRW9zUXJOWUpIb3ovMStIVEZOYVUrV21keVkxeDdhVUNU?=
 =?utf-8?B?SE1helYvS1R1N2w1dFgxSmI1VUlva1BQUm1vbWVKV0J6a1F0SEJjZzNUcWpK?=
 =?utf-8?B?MXFVNEg0bGtBYWUxSGdEL3BjRmNqb05LMEdHdFBRV2lYc1VrUStTZWJpQktj?=
 =?utf-8?B?Y3FseWs4L0pTYUt1T0hyYXRQOHNibGlxRFB3Yko3MnVEZ1V0Y3RzMFA0N09m?=
 =?utf-8?B?RHViY2pmOEdYM1hGbnVKL3VwV0VlWFA1RXdGVG15Y1J5VkVpK1NBM01VSWtE?=
 =?utf-8?B?TENQZzN4RVNzRlJJQzFLVVFGek42Uy9CeWswaEJGNldZU25HcEROTU5ZU0tJ?=
 =?utf-8?B?ajFQYXlxZU9uVS9vcHo2VXVGcjJLSVVHSjk3dTh0S1NWNzZZVjhYQitsTGF6?=
 =?utf-8?B?a1Fab3pFRUFwYXpjUFdrQlBybUdlQk93NXA5NloxTzBZQlNGNVgyZEhUTGFh?=
 =?utf-8?B?TmpSRFhhcklaQVBCaFo5MStPcmdYL3llZGExMHlxcmFTOFBSaXdoRWF3dlJp?=
 =?utf-8?Q?azCA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedf4d67-a750-48d1-4507-08ddad4c0d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 03:07:11.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMhJkOCt9SumJk/M2bQKhz78iRLteO84Xb28Tz8lSMofRhlZXqu6P5VZmYt/h/xu98jfukVMIDq7Dvo/qqlP5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9254

QW55IGNvbW1lbnQgZm9yIHRoaXMgcGF0Y2g/DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBTZW50OiAyMDI1
5bm0NOaciDIz5pelIDE2OjAzDQo+IFRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwu
b3JnPjsgRGF2aWQgTGVjaG5lcg0KPiA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6Eg
PG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5keUBrZXJuZWwub3Jn
PjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyDQo+IDxzLmhh
dWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPGtlcm5lbEBw
ZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gQ2M6
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgQm91Z2gNCj4gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0hdIGlpbzogYWRjOiBpbXg5M19hZGM6IGxvYWQgY2FsaWJyYXRlZCB2YWx1ZXMgZXZlbiBjYWxp
YnJhdGlvbg0KPiBmYWlsZWQNCj4gDQo+IEFEQyBjYWxpYnJhdGlvbiBtaWdodCBmYWlsIGJlY2F1
c2Ugb2YgdGhlIG5vaXNlIG9uIHJlZmVyZW5jZSB2b2x0YWdlLg0KPiBUbyBhdm9pZCBjYWxpYnJh
dGlvbiBmYWlsLCBuZWVkIHRvIG1lZXQgdGhlIGZvbGxvd2luZyByZXF1aXJlbWVudDoNCj4gQURD
IHJlZmVyZW5jZSB2b2x0YWdlIE5vaXNlIDwgMS44ViAqIDEvMl5FTk9CDQo+IA0KPiBGb3IgdGhl
IGNhc2Ugd2hpY2ggdGhlIEFEQyByZWZlcmVuY2Ugdm9sdGFnZSBvbiBib2FyZCBkbyBub3QgbWVl
dCB0aGUNCj4gcmVxdWlyZW1lbnQsIHN0aWxsIGxvYWQgdGhlIGNhbGlicmF0ZWQgdmFsdWVzLCBz
byBBREMgY2FuIGFsc28gd29yayBidXQgbWF5YmUNCj4gbm90IHRoYXQgYWNjdXJhdGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9paW8vYWRjL2lteDkzX2FkYy5jIHwgMjEgKysrKysrKysrKysrKysrKy0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvaW14OTNfYWRjLmMgYi9kcml2ZXJzL2lp
by9hZGMvaW14OTNfYWRjLmMgaW5kZXgNCj4gN2ZlYWFmZDIzMTZmMjQ2YmQwYzMyZmVhOTkzMDk5
MDBiNWM2NTA5OS4uZWJmOTc2ZGI3NDZmMDI0MzFhMzE1YjFmYWENCj4gODZmMTUxYmI2NzEzMmUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9pbXg5M19hZGMuYw0KPiArKysgYi9kcml2
ZXJzL2lpby9hZGMvaW14OTNfYWRjLmMNCj4gQEAgLTM4LDYgKzM4LDcgQEANCj4gICNkZWZpbmUg
SU1YOTNfQURDX1BDRFI2CQkweDExOA0KPiAgI2RlZmluZSBJTVg5M19BRENfUENEUjcJCTB4MTFj
DQo+ICAjZGVmaW5lIElNWDkzX0FEQ19DQUxTVEFUCTB4MzlDDQo+ICsjZGVmaW5lIElNWDkzX0FE
Q19DQUxDRkcwCTBYM0EwDQo+IA0KPiAgLyogQURDIGJpdCBzaGlmdCAqLw0KPiAgI2RlZmluZSBJ
TVg5M19BRENfTUNSX01PREVfTUFTSwkJCUJJVCgyOSkNCj4gQEAgLTU4LDYgKzU5LDggQEANCj4g
ICNkZWZpbmUgSU1YOTNfQURDX0lNUl9FQ0hfTUFTSwkJCUJJVCgwKQ0KPiAgI2RlZmluZSBJTVg5
M19BRENfUENEUl9DREFUQV9NQVNLCQlHRU5NQVNLKDExLCAwKQ0KPiANCj4gKyNkZWZpbmUgSU1Y
OTNfQURDX0NBTENGRzBfTERGQUlMX01BU0sJCUJJVCg0KQ0KPiArDQo+ICAvKiBBREMgc3RhdHVz
ICovDQo+ICAjZGVmaW5lIElNWDkzX0FEQ19NU1JfQURDU1RBVFVTX0lETEUJCQkwDQo+ICAjZGVm
aW5lIElNWDkzX0FEQ19NU1JfQURDU1RBVFVTX1BPV0VSX0RPV04JCTENCj4gQEAgLTE0NSw3ICsx
NDgsNyBAQCBzdGF0aWMgdm9pZCBpbXg5M19hZGNfY29uZmlnX2FkX2NsayhzdHJ1Y3QgaW14OTNf
YWRjDQo+ICphZGMpDQo+IA0KPiAgc3RhdGljIGludCBpbXg5M19hZGNfY2FsaWJyYXRpb24oc3Ry
dWN0IGlteDkzX2FkYyAqYWRjKSAgew0KPiAtCXUzMiBtY3IsIG1zcjsNCj4gKwl1MzIgbWNyLCBt
c3IsIGNhbGNmZzsNCj4gIAlpbnQgcmV0Ow0KPiANCj4gIAkvKiBtYWtlIHN1cmUgQURDIGluIHBv
d2VyIGRvd24gbW9kZSAqLyBAQCAtMTU4LDYgKzE2MSwxMSBAQCBzdGF0aWMNCj4gaW50IGlteDkz
X2FkY19jYWxpYnJhdGlvbihzdHJ1Y3QgaW14OTNfYWRjICphZGMpDQo+IA0KPiAgCWlteDkzX2Fk
Y19wb3dlcl91cChhZGMpOw0KPiANCj4gKwkvKiBFbmFibGUgbG9hZGluZyBvZiBjYWxpYnJhdGVk
IHZhbHVlcyBldmVuIGluIGZhaWwgY29uZGl0aW9uICovDQo+ICsJY2FsY2ZnID0gcmVhZGwoYWRj
LT5yZWdzICsgSU1YOTNfQURDX0NBTENGRzApOw0KPiArCWNhbGNmZyB8PSBJTVg5M19BRENfQ0FM
Q0ZHMF9MREZBSUxfTUFTSzsNCj4gKwl3cml0ZWwoY2FsY2ZnLCBhZGMtPnJlZ3MgKyBJTVg5M19B
RENfQ0FMQ0ZHMCk7DQo+ICsNCj4gIAkvKg0KPiAgCSAqIFRPRE86IHdlIHVzZSB0aGUgZGVmYXVs
dCBUU0FNUC9OUlNNUEwvQVZHRU4gaW4gTUNSLA0KPiAgCSAqIGNhbiBhZGQgdGhlIHNldHRpbmcg
b2YgdGhlc2UgYml0IGlmIG5lZWQgaW4gZnV0dXJlLg0KPiBAQCAtMTc5LDExICsxODcsMTQgQEAg
c3RhdGljIGludCBpbXg5M19hZGNfY2FsaWJyYXRpb24oc3RydWN0IGlteDkzX2FkYw0KPiAqYWRj
KQ0KPiANCj4gIAkvKiBjaGVjayB3aGV0aGVyIGNhbGJyYXRpb24gaXMgc3VjY2VzcyBvciBub3Qg
Ki8NCj4gIAltc3IgPSByZWFkbChhZGMtPnJlZ3MgKyBJTVg5M19BRENfTVNSKTsNCj4gLQlpZiAo
bXNyICYgSU1YOTNfQURDX01TUl9DQUxGQUlMX01BU0spIHsNCj4gKwlpZiAobXNyICYgSU1YOTNf
QURDX01TUl9DQUxGQUlMX01BU0spDQo+ICsJCS8qDQo+ICsJCSAqIE9ubHkgZ2l2ZSB3YXJuaW5n
IGhlcmUsIHRoaXMgbWVhbnMgdGhlIG5vaXNlIG9mIHRoZQ0KPiArCQkgKiByZWZlcmVuY2Ugdm9s
dGFnZSBkbyBub3QgbWVldCB0aGUgcmVxdWlyZW1lbnQ6DQo+ICsJCSAqICAgICBBREMgcmVmZXJl
bmNlIHZvbHRhZ2UgTm9pc2UgPCAxLjhWICogMS8yXkVOT0INCj4gKwkJICogQW5kIHRoZSByZWF1
bHQgb2YgQURDIGlzIG5vdCB0aGF0IGFjY3VyYXRlLg0KPiArCQkgKi8NCj4gIAkJZGV2X3dhcm4o
YWRjLT5kZXYsICJBREMgY2FsaWJyYXRpb24gZmFpbGVkIVxuIik7DQo+IC0JCWlteDkzX2FkY19w
b3dlcl9kb3duKGFkYyk7DQo+IC0JCXJldHVybiAtRUFHQUlOOw0KPiAtCX0NCj4gDQo+ICAJcmV0
dXJuIDA7DQo+ICB9DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGJjOGFhNmNkYWRjYzAwODYy
ZjJiNTcyMGU1ZGUyZTE3ZjY5NmEwODENCj4gY2hhbmdlLWlkOiAyMDI1MDQyMy1hZGNwYXRjaC1j
YjU5YzUyNTU5NjENCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gSGFpYm8gQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KDQo=

