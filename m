Return-Path: <linux-iio+bounces-5641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C68D76E9
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7D01C21323
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5B5F874;
	Sun,  2 Jun 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="eWZ90Rk6"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2135.outbound.protection.outlook.com [40.107.7.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7802E58AC3;
	Sun,  2 Jun 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343391; cv=fail; b=TcRGgbK11v/0/Af3D1tEnUYiCnOwcpZKpEoOc6mjiS6K0bt6VhrRBg5Stf2Qsv4nbLKE5TfaWxBuqWpkGwfwE/H8MZaBh7Ic5lIBHE6F/f30ZGFiD6qfodkl6LPyrpqCQi7NG5y9Ij/ZRoKL1tV8V5IjhJLxNxoi0p0QKB3gv7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343391; c=relaxed/simple;
	bh=FKkp2b0c3eSXLbTl/8TKPdooRtp1MqkEYtupda+FJ5w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M95xOnQdBJaXssWzZhFt7lOu78/BwJbN9uBqqCqKHJmV4GWa7xXpI7JAh5d6ikH0gHBvs9mtkZ7csekepZur6tq3MC9GACP1VJZOBheZVeoUdw0NFDPyi4UvV1mkhfX/ixY9cLibdSBjxMNTI2qspxo7ZhMWb4kBJEGW+ZIgHz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=eWZ90Rk6; arc=fail smtp.client-ip=40.107.7.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE+CyJzHnW/Anr1DsHJ2hAOZv8s2VQFMTzQf1rzdxmeAQUPowNA09/VEI2/R6si66HfyXyDC1GIPZg6ZjK9faQPvNZBOSkgLTLwMvtXH/y5RMewdG0PBW6PRvk3khS2WKhjtrBWfQCqjcGOkNpnv7q1DhhY4OxMcTBOnFVlLh5v4oo4RHRST9n7WJyh1NhKlcXwmcD5PxPXwlfv+Jz42KGrbYSkmbvPIt/j0whPI+v1uuTuFMpGKFihPOtgKvrssIJeGazmzgqBbjVO4vqWc8EQSHNK5IsBuKXCAq7VPOAxiqLAkzZvLKmW3pYviGjQJpGumJS1MWRciZPFQHZ/YUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYWAqpYh6fe+fjcs9FOHhvuWGx4jThQuhkmel/RCxro=;
 b=XGOYV6EjLHukLs6utM+k5GeXW7Q7bXwiI905E3zCKLaoavlh/ROMtpuztJLOj119adrAIgDuDm2wPmVCFsu7iE8c++CLtafyWf+7TG/xWj6Ffq84XyEgfh5UNojueTJLo9nm6L2mGu+zWIO+E5qLaLhe/olIgiIoUCoudYCf1qiuqSr9vDBXkySRND6xUQXWnlWQfPRVBButUMMkQf5nOo8sxN9C4lorV61WsB7dDoiPI5FGJEyjh0P159KpgjjKSl2TO3z6hgFuqgltyPuhkPe4zB21JTJ1FyK7AU27B0egh+WCHCc01yIKRQhFPuPlKiQJ3z1AcWBfWoPjSXuNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYWAqpYh6fe+fjcs9FOHhvuWGx4jThQuhkmel/RCxro=;
 b=eWZ90Rk6sv8cGHpoVWEX6J8KKK/2YsLuQFM0n43K+bbb729gch4minnHJccOJpSf2fvWvFNXvJS0L6lk292FhuCC1134GrQa4VPdCd+kP0Pb37y4QMwHf8LHrmBnCslCxghyxI+9KI4NIYZ0OfJdz7qt6O3JjIco01NSJ87bc6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sun, 2 Jun
 2024 15:49:42 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 15:49:42 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 02 Jun 2024 17:49:39 +0200
Subject: [PATCH v6 4/7] dt-bindings: phy: armada-cp110-utmi: add optional
 swap-dx-lanes property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-cn9130-som-v6-4-89393e86d4c7@solid-run.com>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
In-Reply-To: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Konstantin Porotchkin <kostap@marvell.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 99550be6-2804-4202-4861-08dc831b9e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzV6MHN5Q3ZVSFJTcjlZQmNtd0htNE9KN0pBR0ltSVhiUExnN2hwZHF5ejhi?=
 =?utf-8?B?aXVFS2E5cDhJckE4RDVycjdrQitwTXpLbHhVdzJza2hWODM4ZWx0Tk9PbVRt?=
 =?utf-8?B?T3E4a0g2V2JMUG91NnJadXlaTlhXRE01akZzSnJsWUp1YVFraVFtYVpwVkpB?=
 =?utf-8?B?Z2NIVkYzWXB3Z2w0UGdleEl2S09aNnNXeEUvSEVJTWthVnlpKzdCaEN5Skdl?=
 =?utf-8?B?SjVBeEszcWdHYXdSb3VZekZxVTE2RGZIa1AxaHhKRElLeEgzM0V4R2thU1do?=
 =?utf-8?B?M2lnMk8wTXo0YWdtMmpCSXAxbGM3dzBBazBBYWpOaWlWUnVNUm1yejFyRkYz?=
 =?utf-8?B?c29UZ3JEalFXVWlUSnYwbHhuaTVHaDdjSHo5dGdiZ1M3SzRCNUxOM2ptclFj?=
 =?utf-8?B?d0xpOVJsRVRydGJCQzJvZE5XZWtDQWpLWHoyVVJFbGVObm52bGQ3Qkc1VEor?=
 =?utf-8?B?VC94a1Q2SjNDeWNseC9sSlFQdEZWdy9rZ0prVEhSMEF3ZDBFclEwNDNBbkJl?=
 =?utf-8?B?ckIzemplQVhwTXo5bkZ1VEt3YVI3OXhPOXRNWmh4TDF5T3RoWGRZZFhQWGlx?=
 =?utf-8?B?UWJzcjNCaHVjSmhzekpmZmVmVGN3bHN1M05uVnpTT05HV0x6MHFidk03S1Mx?=
 =?utf-8?B?M1lZQUNzWUNWYmNkMXBPUmJVbUx2V3JXSEVhS3ZjNlFVbUEvd2FKelpxK1hG?=
 =?utf-8?B?Z1R4N1FxY01Kd2NnWHc1YWJzYUE1M0VhOHMrdk5Ea3ZFTjJJUkRBNGthQkhl?=
 =?utf-8?B?RjJWR1FqVUl6Q0E5eFpXRDU0eDI0TVFQVE14dnl3dm1PbUQ2bGxNb2V6emU3?=
 =?utf-8?B?OHF6TXZBNjFsUmJrTm55bWhwbWF5V1hheWZTdk1jZVVWeU93c2Rndm93ekFj?=
 =?utf-8?B?ZU13T0c4czZ4a3FUbmhWdVZIL3FVb1UvaUdKTGNvVXV6ZVN3Z0FSOE9YVkVt?=
 =?utf-8?B?WWo4WDRkZjhLRUZubjdFV2VzR3hYdkdZbUZBTkpCV1JMd0pmemdFNGxmTUN2?=
 =?utf-8?B?Q3ZsenJCenB5QXpkb2p1SlFOU2NYVmorOVZMYkxBcWVhL0RCZmEzdnFyallH?=
 =?utf-8?B?RXQ4ak9XRk5wT0NtOVdidWUxQXA0VDhRTURCUEJmQ25SdkZMQ2tkZEVicm5v?=
 =?utf-8?B?blg1TzhMc1liaVJkOHVwZnJ2Tm5vdncrL2NjcTk3S1pYVWMzRmxCYkZkUXd6?=
 =?utf-8?B?R3BRREJFbFJOZDl4bGF5MUl2bDFidzE3NGxBLzMrTDBjM3VETVNLUElXUnlJ?=
 =?utf-8?B?UlkxNGFYbDBHQjhlS0ZjRkl0bDU0Zk93L2d3ejBBZUY3a3Z6VU80cDFjTFc0?=
 =?utf-8?B?Q202Ry8yUkVxQ2s4c0pMVllpTm1RSitEWVZETXVOV3lVSGU2T0RyUlErUytD?=
 =?utf-8?B?SW11OWFuMEZDeDVhdGxFV1R5TWtsS0VSMGFGTElWcDlHU2JZT2UvRXkrNHpZ?=
 =?utf-8?B?TGQyMGgwajdjMkpzUHRwUkZrdFp0L3VkbTFqNG8wNVRpbU93aHVUN3M5azRn?=
 =?utf-8?B?OTRMaWVjOTVydE03c2cwWGw1M3h5VVFzRUo1NDQ5K0JRbTRMRE5SRWJkNFNk?=
 =?utf-8?B?cFJUQWFwZ1Z0U3dvQjhOZGhoZXJUbzd0MEl3WnZaR0dJNmd6WFBmNFA4aEs4?=
 =?utf-8?B?dXBpWVBtUk1uSk1QbEFQWUdiYXpKaHIvVTl2SUdreVVhY3d6bmRqTVVRcStw?=
 =?utf-8?B?djVObFVVNGpvU0wzNU90WDJ3QWdXZ2JtZWRtUEhNVzczNjBGWWRES3VrSnBR?=
 =?utf-8?B?UmQ0T0s1NVFyWHo4cE1MSVRPRjhOS3k3bzA0UG9hNVF0V3AyNEg5YU1PVTBq?=
 =?utf-8?Q?Nevb0+WSZaEGV7/CoN32QWnGpbBXWQ7y0JGSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1ZwaTkxclN2TzBQRVhrcEtMd3Jma3NOVnZpRS9JcjN5WUN3RngvUmowQksw?=
 =?utf-8?B?R0srdVJ3WnQ3a05wdTlmWlBqbjdWSmZxWFhPck91SkF1Yi8zbWR5MksvSncw?=
 =?utf-8?B?cEcyTVFSTVRYTWFpSm53d2Y1eXJrN0RxYTdQSzJUeU9FK29SQndiWkJxb1BQ?=
 =?utf-8?B?Y1hNQ1FtRTJNNkswZEMyS0luTnI2ZCtwaFNGKzlRTXJZNlBxQWhLVlBOcXAw?=
 =?utf-8?B?QVhuM1ZJVGUwZFhpWDBMYXliQkFaQTl3RDFmSk1OZWlOYTUwTXNiTjZlZ3Zo?=
 =?utf-8?B?Qnpvb1E5TWcwb2xWcDU5b2hqVnVDa2I0ZmMrMFlaVWtoOW1RODJ6YkQyWlVp?=
 =?utf-8?B?clVibEZ0L1lRdGpOYVhzTHkwWmF0WWxhanJubGFVb1lHNEtBVFJSZ3pNL0pj?=
 =?utf-8?B?VXhiR0hzZVRPdjQxOGFyKzdTVTlsK3RXMU13eGNOeXNBYWxXWW1RTmNTckRO?=
 =?utf-8?B?WjVLU0xhajZHK1IxV0JFVVRndXNUL0RQMldlaTV1WFM4WFFNRnJlYlJGTjR6?=
 =?utf-8?B?TXlVaWpVYWpDeVQ5dFpqenlWUjZkZzc0d0Y3eDJDR0ZkNFUreVpGSDZkSTlO?=
 =?utf-8?B?TW5acXMzdWZ6Q1R4THJBQ3ZiYjQ5QVpHK1JhNCtlZTVzM2JQd0VZdmRLZXAz?=
 =?utf-8?B?KzZhYkFIVUtOdjBURURQL0Ftb3h4d200WUU1QW5rM1FEUUY2dGJZYW41WnFR?=
 =?utf-8?B?SzgzQnRvT1NKVG5xbUZVUDAvQ2M3RG5VOFQ0eDBoNHRjS2JEK1FDZEx3Q0Q5?=
 =?utf-8?B?OTJBQ0dWS0c1aTdiWlNvcnh2Um94OHJCMzBETWNTMkR1VlNFWGdiRURTS3RF?=
 =?utf-8?B?amY0NjRwVmx3alZhKzNEOFltT1ZIUzNzRDdZM3ZnMHpqRjRMQ2RHOFVFMzM0?=
 =?utf-8?B?QjJONllWS2MvNlQ1My9aeSsyNmM1Ymt6dXlzVWVIWDAvQ0s5MkV2MTRpamlF?=
 =?utf-8?B?aXErWmVTTlJxcmsraTJDNlE0VSt0b0RYRTlFVm9iZGZWV0pwV2ZpTWFRMWhE?=
 =?utf-8?B?L0JpRXArK294dW54YVk4SUpsVHRaeXU2YmJGZXdzV2tUV25KSGRWaVNyTFFD?=
 =?utf-8?B?RmFUMEdPZkhrYnpPQnRHMlRpcTRTbUt4Q084UlJUbkxxMnRQZ0doSll6c2Rh?=
 =?utf-8?B?RnFoYnkrTzd3SmhSRS95ZkNJa0h1UnVtL1ptVjBVVW05Skt4b0JSUmxtL1V0?=
 =?utf-8?B?M1lBREpTbUVQVXYvRk5LNEg4K0grNHBtMm1SeEZ0VHI2cUl2SnNXaGVac3pS?=
 =?utf-8?B?UmVJK2RvOTdoK01OdVpjQ1hCclNlWGlYZFVpWW9IU3pTcTNLQ1JBU2xLNGt5?=
 =?utf-8?B?ZER6NXdJZ2JuWEZZRjZKdm9FNWM3cSszZWtoRzVxZmZEMnBXa3JrMUN0c1Bx?=
 =?utf-8?B?LzdXTC9MWDlwS0lTTWFWdVkxQVNzN3BRZWN1Uzd6eGM5NEJWUnpUQUZwejBM?=
 =?utf-8?B?eFRwcTZuT2E0UjdWWXFGTTZZOXdnWFRIZHczVytydXlpU3cyQUlRU0gyV2pm?=
 =?utf-8?B?Z2dGNzJ6SnI2TUZqWTdxOGFJZmYzeDd2Y3B5Y09LQm51YXlUdnZMV3FYZzRJ?=
 =?utf-8?B?d0lLdWl4ZlJvTUs4TFlHbGV3RkhwWDJLYTVkbStkYS95ZGlKNnAyMzVrUnpU?=
 =?utf-8?B?c3ByK2pjYWdJdjRUenNYWHJWeWlDUVAyc05OMkJoRVllWXBwT1FwazlBeVBG?=
 =?utf-8?B?M0VlWDhpQTNuT3hDUWNWWFdodlptVXhzWlBaQklsTldrK0VMQy80RHA5Y0Ny?=
 =?utf-8?B?Q1g3eGwyTkZNQ1FtNm1JM1U4cHFwOGkzdTE3QkIzU0hzZmI2TXprK2l6Vlp0?=
 =?utf-8?B?YVU2T0kybHBmUlgxN3VrZjZLY0I4V1A4RUNzUFpRM3MwNUxkM1hueWNQSFd1?=
 =?utf-8?B?S2lOLzEzZlZmRDBLMW4reGcvV3VObE9tY004MkRQZ3lzSjhGMmdaVmx3NFY4?=
 =?utf-8?B?SjltdVJiaXJhbjFzRGsxc0NzeVVjNTN1WThYODZ0dTZUUndSckZBVmRnWitN?=
 =?utf-8?B?ajNLVm5TdXBSYThmKzNvMXlLKzNRbk5GNWFzaUFOWW05NTlkY0tTYjRpQTlx?=
 =?utf-8?B?R0F1N3RmR0lyelFHYkdiWWNoVU5COGk2M1plSzJ4RGZWS1dPRjVDL2hVM1Nw?=
 =?utf-8?Q?2Ev7Xx4bUcGOOyRALPID5MEwM?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99550be6-2804-4202-4861-08dc831b9e44
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 15:49:42.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBYLlNkUR03c+YbSAavPBf0JAHDI3I+fk+KRwlVGPo0wVCzDtg2uq/1aZBaZ066HTkloT7hmSXmJkKTJMAghEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

Armada CP110 UTMI supports swapping D+ and D- signals.
usb251xb.yaml already describes a suitable device-tree property for the
same purpose but as child usb controller node.

Add optional swap-dx-lanes device-tree property to armada cp110 utmi phy
with same semantics as usb251xb:
The property lists all ports that swap D+ and D-, unlisted ports are
considered correct.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
index 9ce7b4c6d208..2ef02aac042a 100644
--- a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
@@ -41,6 +41,12 @@ properties:
       Phandle to the system controller node
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  swap-dx-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Specifies the ports which will swap the differential-pair (D+/D-),
+      default is not-swapped.
+
 # Required child nodes:
 
 patternProperties:

-- 
2.35.3


