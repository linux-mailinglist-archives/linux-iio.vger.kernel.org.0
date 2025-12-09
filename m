Return-Path: <linux-iio+bounces-26960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D164CAEF0C
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 06:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF17B304C296
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 05:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22279223DDF;
	Tue,  9 Dec 2025 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="kJLNRU1I"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023101.outbound.protection.outlook.com [52.101.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43C625;
	Tue,  9 Dec 2025 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765258439; cv=fail; b=JFKp/EVXFNAAM7esm7b0DoPJ0N7FgyfnQ/hOzotgubosSpWZ46w0ptqGGRym5F/9MqgnhU91gf09+kGgd0gY9pFSESY4wBKi/A8TLW2caCKQWOcEUdW5ilHHWEAvEZYsfgK8cjklw/r778omzMbx7Dpokn3RG1cOVa2wcrrgbQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765258439; c=relaxed/simple;
	bh=jkPs6SqrK8NnhO1muK1xSuEDEJAsN8Ta2d+qlPN0Zeg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YnvP85R3HOsI/ON073fbuqPbCkXzTElETmmB73N6th0s9kFn51YEisLqmIkVCRfBYdDM2SPxPaJlusvcSAx7kQDE8mCRrUnTmzzxkj1MCW1jXmSlczU1HBpu2WdQuwoG6yw3RgKpTOeBBrGHZhDo9b+JWDm0IhA4m2MFdqReG80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=kJLNRU1I; arc=fail smtp.client-ip=52.101.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUMLp0YzyqPe8AXr2IWqIzu49DJ4/YIJP+XiKiTkU3LS4tzqeJiPVtS0H2HyYZ63M0ZKaYJ5lMk2pBmY13XvJbBq3XRIsEtXJ/MlJTB1UdPt2vS73bGHDGSs9xIkML/OtpL5RRBjKJ+G8VgqaNsNsnFLrmnLYBlRhBJvRbsITmYi4iXV3U1Ulfx592/HpBOIrfLdvHSJLAnHIo4Adr4AtENn5YSI6VSfoBZc5tKfbISf8V5II1JIatBYb18/d4PnIZiin834Db5jlvrWaMbrUoT+brlDNjD9zafB3t7c9Sf4XVc1ieUrawlcenidQ+35e9YPSjJeN55xCGMRBoBGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGByndXr/mPXHXuph9nQ5QHMDEgnJnQMcsA5oel2nXk=;
 b=G2RCpQlv+OM6Sm45w9WQHmWiK/4zE6Y0HOL+vSwDyIqo0051K+JayRajm64TI3z09OWFtLKzdimuQsV1Ak3aFlZa8N16l2tuH12FisWN0MCXaG9JS1ONtBMlJgBSWwD9dzXXbpfIX2DgdQvMBdgY5fKAGezKEi79MseWrEzMS+bo9MIZKzTPZxL+Wk5udprilqLRrTwzmTek2chmszL8zwcC5haYzfiKaKx6l2ZxsdsjWBkx0mJIDUMnomapKbZNTvHdYM+xUPnvANFCyGZ1f8DFIxvaQPrI8nyb0Ku7sLdJoQbZh6rJWy4BboexmnMzhGP9FijezCC4/SezPHKIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGByndXr/mPXHXuph9nQ5QHMDEgnJnQMcsA5oel2nXk=;
 b=kJLNRU1Iw2Jnvq84C3qL1UXyOHAhRLlQU/ApRGramitJbZDczkf4PCBsYnVGTr+taXCT134CM4ffQwHLfsTYC6CXF95zbpww0LQd3rSbVS9RUrbvjyHn2nyC22at2nd0FD6xsPuBnvy4qU3WoGjEv7Ixxc3clx+8BxVS1BWrP+DF2sj6UIUPz4nbozxNIhgORRKnIm+Fvgx4J1GdVIViGuuileZiyrXJVmYU9OgBJy1E4kp08pHZviLfSCUcWvI1M5SUJYJSxU7j0u05UhgsOi3SsC1cT16k4MHU3rApuebPAOr+nyrCWTlM8NfZ7qMF4YKF+fcQCTQAyL7tb7LYDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VE1PR06MB7053.eurprd06.prod.outlook.com (2603:10a6:800:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 05:33:51 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 05:33:51 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 09 Dec 2025 05:32:26 +0000
Subject: [PATCH v4 1/3] dt-bindings: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-add-ad9211-v4-1-02217f401292@vaisala.com>
References: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
In-Reply-To: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765258430; l=1386;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=jkPs6SqrK8NnhO1muK1xSuEDEJAsN8Ta2d+qlPN0Zeg=;
 b=xrBuV86MnISVmbntKDOAKnzcc5KtsuWD4YNdqQ+TXUt3agf41G7+1RI96t5V1vCHNH3WbMoKX
 Mnsh+Mze6fEC4NQjCgByZ072flUOeL20omYdUBu9TBgFJ/PskNabM1w
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF00002E6A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::38) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VE1PR06MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db31241-7af1-4ab0-ead2-08de36e4894d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Slh4ZDZTTUhiL1Jzd3JnL3Nka0VmOHk1U1VSazZnWmFuYnNpL3JvcHJZelkw?=
 =?utf-8?B?Y255N3pmd2hiOFIyVWk5NUNzdDV6WU9XTmtranNUelExSC9nUjZZN1o0ZnAz?=
 =?utf-8?B?eUFaVXd1T2JtbXNSS3VqTzB1T3o4dEJwb1Q2NHFkUmx6WWlxcVhldjBIUjli?=
 =?utf-8?B?TEgrRVdIbFRRQnlLMnlmbjVGZDIrclFra3lPMkkrNDFJRGFJZkl0ZERzWkpG?=
 =?utf-8?B?YjI3NnZSV1VhUkcrMkd3MDdPUk5aYlJNeUtaZzVvODJkOHdDbVlVUWcyS1BZ?=
 =?utf-8?B?UkxkM0lJWGNBYUNscnVLMzFaVDdIcDBTU0t4LzQyNWJ0Z3JRUENxWkJubTJR?=
 =?utf-8?B?Tkl6TFVwSTJxeWJJcE42ZHZrc3pKNEpMTDBlNmhOSGNlSVJVK2l0VkRpbjZP?=
 =?utf-8?B?VDBwV25xWjhaNmtIQm11T0FTZk9BSmtnN2tUaXEzanN5QVEyQW0xOUt4Q0d4?=
 =?utf-8?B?aCtodG5aRVdNNzlWUWgzQ1NzTjIyVEJSYlRvRzNIVHR6cUh3cmx1R0JpZUhH?=
 =?utf-8?B?TnBmVWFZRXR1M2c3WUdSMjVQUGxRc05xTU5PTVR3SDlUb2JuYmk2c1c4bVBi?=
 =?utf-8?B?UTFOVFphclFlYlVFTHB4Y1drOFV2TnA3VXNHSmt1TUpBOTNhaVp0SEc1MGFh?=
 =?utf-8?B?anltRSt2NTFDTDFLc1RFTHArRVpyelVIbWI1NVVhaXJIZ1kvWUNUZWsyd1dW?=
 =?utf-8?B?bFMxdmlzTVlmSDluWXN0dXI4VWdzclBsTmxaNG5kdUpJR2lJMStneTI4Zmo0?=
 =?utf-8?B?ZGJERFhnWWRKb2NqZmVULzczNXJEMDVaUUZ2RU8yakVkTEtBdGVIL0RsMUQv?=
 =?utf-8?B?SitodnkzWWFsY28rRWRmdDFyQjNad1RQVTBXMFlmUlFIdWdEN0YxaGVzcmhN?=
 =?utf-8?B?UEQydGlDS25rUTZPSng1ZG01S0kzYkx1dEJEekxoUWVzNGx3ZVQvR05pUklI?=
 =?utf-8?B?UXhqUkdEd1FyMm9RSDBWZmFGQ3BCMzc3ajk0MFlsa2FRREVuR0RBZkdoU01V?=
 =?utf-8?B?ZjdIdFBIUk4xZ1ZTclJJUkt3ckZ3cVJxaXF6ekNkL3ZpZ0lIam9rVWlVSlA5?=
 =?utf-8?B?ckFSVG9MNGdINEJaY0l4U25CZjJySEpWSnU3dEc5ZURZeTQ0bnFSOHJRZ01h?=
 =?utf-8?B?UkpRUkUvY09FdXZBUDNOMzBmSXJiMzNpM1J0bVhPVG03MDJsVGltQ0VnUjNH?=
 =?utf-8?B?WjErUU5SUG5WVGxQS1lxTjVtUndVVU5XcksyVjk0OE9NZENxbVZFcndrbVA5?=
 =?utf-8?B?YjMrQlQ2OEozQTlTb1d4ZHdoZTBoR2J3STF4ZFRtMnFVNHh4dXZkMzJiY1NT?=
 =?utf-8?B?OTd2ZWkwWDJCMFFJYzFyVG1iQUwzOWh6ZUpsMkpOWmxSRTJCYkoyaEJXUDVy?=
 =?utf-8?B?ekc0Ylh6aEVOZ1dmZmJGWTg2QUU1Z3R0bFpNMDdpT2FsUkZZZS83Y3FtYll0?=
 =?utf-8?B?WGJIWWJMaFcrdlUwNkIyWlFBdGc5Vm44TVg4bVVDQnhlY2NhNmVQZDNMSURP?=
 =?utf-8?B?SDUwYkhQdlZEYkxCRThYVUNzZUMwRy8xRlgxUEtqRlVRbVlPcElrdlZEZHdx?=
 =?utf-8?B?NWY3MmU0WEJKWm43VCtNZm9aQXhXdHRSM3dQa3NDMjJoclM2eDJ2anRtWmhv?=
 =?utf-8?B?UEFvQ1g0dkVNNVd0RUlxTEg4WHB4RTBxVW0vdW8zejRSYjNBM2NRZ2diN3lS?=
 =?utf-8?B?dzZNS3RWQkhvVjExK1lqak5oYVZSOFlwdmp0RFNCeWpackR5N3c2R1JvT0pu?=
 =?utf-8?B?T0JER1ZqMGFSbDQwTTZVQ096RENMVHNUUGJnVTk2dFAzTmtyQ3dNOTRFMWxN?=
 =?utf-8?B?OGdEN0h5WnFPbW5JRGJ3Zi9XT2RlaFpFMENaZ1VtQzVXRDdxNm9lb1ZFTENq?=
 =?utf-8?B?L0lPajFueFc3U3VZb0ZGVlpLeDJpUEQraU1FTjh6c0JHcUlBaFRUcm5BdGpV?=
 =?utf-8?B?bkxrYlh2U3hRMnpqQWlrbkJmckNJQUUyNGk5cm9zM1J4LzlZVXZFanU4R0pp?=
 =?utf-8?B?ZVFodmloY242ZnBXeWxtMWxYRHdBR0hKY1hKYURCN29qWitId2RGTnJTai81?=
 =?utf-8?Q?p0rwE8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2lDK0lWQmdyTzhKcVBXdmU1cWRYYVNFQVNjSzRVWWtOUis1ZUg2MlZlMnVJ?=
 =?utf-8?B?YTJsdVZReVlMMDNJS1lYSWFxMHJVL08vZUZuUXQ2Mzd2YWkzSW5uQmZzc2hv?=
 =?utf-8?B?eE1hbnBjZ1Rxakt2M09udFQ0TGY4dk5Ybmk0LzFvWUpNY0NEU2l3SzQ1clNp?=
 =?utf-8?B?ZTNGUjFTekdLTEF5RldIUWE3c2dBMzdGSzVodUlVaTdHeThjQmYwTnk4QjBY?=
 =?utf-8?B?SDd2Y1RTcml4a1ZaOFJxVEt4WjQ2SFRvWENhMnQ1eEhDeHpNUGtZQ3ZZN1Nq?=
 =?utf-8?B?R29IVVNic29CZFV0ZUxCbGNMZEl4V0tMT3REZTVTZnFTUUthSUhadVVsdHZu?=
 =?utf-8?B?T2w0bmxtenpxUEJ0bSsza1N3MzFqaGNYaHBKMVcvbjVEZjhKaEY3alMyRlhI?=
 =?utf-8?B?TDRZTUFXcmRCbHJ4L3djdEFOVXNiY043enY5UWt3QzV5Y09FYXhIYktZelBp?=
 =?utf-8?B?ZVZ5aUowU09iWk13L0VPSEI4T2pIaitoTU5CNlkvMkowRWhzN1lzSzF5eW5r?=
 =?utf-8?B?Ukx0eEF6UXlnb3NVYlh1OXNxd0N0ZHlRcU5icVpOaHduRkZ2bGQ1QzB2dzE5?=
 =?utf-8?B?d1gzb2lwdlJPMEJLVFZKL09GaGFNRVFGK0ZuT3drNDVqd1M3Q2FvSlF5N2lY?=
 =?utf-8?B?enN6VzRVaWJqdFAyWXFQUmRVY1c4dEV0dUFYWmwyYTRyWmpsVkl6N1JycnhX?=
 =?utf-8?B?L2NCQmp4bmxES0d3R2hRelN5bVJKaTJrQVVQTkFvbnE1YXd0dGxBeWxyUXpi?=
 =?utf-8?B?Y001cHB1MFE5Vm1aeExXaEhnRjVuaEJwMXMvdjBUdHZYRzZFd3Y5SGZ4M3FY?=
 =?utf-8?B?QkFJOVlNem81cGFlM2s4OEpDZjFVRFY1dFh5S3Rjb3IxdWUrYWFpYkV5REdT?=
 =?utf-8?B?bkZBTGtobGJGVGc3ak53bzl0R0htd3B0ZS8vT09XdW8wYUt6NjVaRHRjYmFm?=
 =?utf-8?B?ZjM0T2ZxYXpscUZZNXZGTHRyOHZjZFVPNy9VRzd2SENid2I5VFhkdkJxMU5q?=
 =?utf-8?B?VW5lZWUvbUZKSnpoYWprYlJSdXF3WUV6bUVOQU5kem5ZZ1NkQUVUa05JRmJh?=
 =?utf-8?B?MWU0dXlqbU9zYXZXTytJdlE5QTl6SHI5WjdwR0ZYMDhrY1YzaUlJYVNwcWFM?=
 =?utf-8?B?MFl2amplOEk2Z0g3c1pGWXZySkhhTUVtaENna0d2OUlUREV4THRVbUgzdmlq?=
 =?utf-8?B?NXVxRW9oQXVoK3hHNkN4WDQ5UGpKWHR5ZUtjbDl5YlFNR3Y0SWNsUFRRYkVF?=
 =?utf-8?B?ZmJRVC9sUlhsQnZiSGROYmtNRExqQnFOSmNPY2EyVnc4bUdHaUE2cVJYV3o4?=
 =?utf-8?B?eTVMWUFRcjVnbTNHU3BFK0JHVy96S3o2MTJqVHpUK3o1eVFDRjgxYzNIdC9k?=
 =?utf-8?B?ZHFCWmhPN3BoME4yMm9TNTN6SE5lZURjMVF2eStFY05zUmFjUGg5ai9FTHZH?=
 =?utf-8?B?eTFaSDlHS3FMYWo2ODlxNk44TmRtNXdVd3hXOXkrME9EYWtueEltL29RV09p?=
 =?utf-8?B?Rm1ib2tvcTZhZTJQNzVnalp4RS8xMlJlc0x6K0pvT0tTa2g2TGJZa0pQOE9n?=
 =?utf-8?B?dEJLL04yNGtSWTE2RlVzcmhVWmxCNngrV0k5SVVRbmFpaVdWZjJDMXF4dzBo?=
 =?utf-8?B?SzJLVFF2bnlxZE15YmFKalRralhuT2xqckRUb1JDcllnOWxiTWR4NUtCOEMy?=
 =?utf-8?B?dVJmdGpVRkh2TlA4WG5GWWhoMDhEenl2Q3pJaVJjZjlncWc5bUcyM0RkVjd6?=
 =?utf-8?B?YlRDZURCdEl1QjdLc2ovWjU4dFFxa2FQNE9ZZjVEak5sWGlLd280U3k0dlhu?=
 =?utf-8?B?cTFQclJPa1FnNWlGbmpNSC83VHp2YlVKMFIrQUZFeEdGODBISnRTWm9PcWpG?=
 =?utf-8?B?VkhXOUdhRGprVlV0UG03K0FlTFc1N1BEM1FMa1N1bEloQnBtVmNFUzFvUlVn?=
 =?utf-8?B?YVhJTXQ4bTI2NGp4Q1luWVMwdklaWEc4RTZpNC9qejIvcDBFUnYwVDIrUmpO?=
 =?utf-8?B?bDk1MkVmbnVPMTFaaUZYd3NhT1BKNVVVbVkrckppM1lpSkE2UTZqTVFVT01C?=
 =?utf-8?B?cWhJc2oxbVhaaHBhN01KSFY1Q203NkVBYWtBbE5OZFBxU01DVXNqb3hhVE5y?=
 =?utf-8?B?TXFwSEJyUm1iUjBYaWJBbmcwUDUybFdmc0lNQ3JjOFExSDVXK3g0TTBJQm5V?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db31241-7af1-4ab0-ead2-08de36e4894d
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:33:51.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IA0pQtwAzRNs+hWM0LfRRbH9RYG0YrNvUtsB7No/aFYsUdNKGaKWS+q5GVlYqHMeg6sMt6W5Bpg+yMNWnk4PlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7053

This device has e.g. different scaling values than currently
listed devices.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 2606c0c5dfc61fd65cd0fb2015b3f659c2fc9e07..5acfb0eef4d5cf487adaa93ce5bda759bb4853c9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -18,6 +18,7 @@ description: |
   All the parts support the register map described by Application Note AN-877
    https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
 
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9265.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
@@ -25,6 +26,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad9211
       - adi,ad9265
       - adi,ad9434
       - adi,ad9467

-- 
2.47.3


