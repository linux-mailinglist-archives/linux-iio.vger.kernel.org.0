Return-Path: <linux-iio+bounces-25584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E87C15441
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73511580DE3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F652E8E00;
	Tue, 28 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bp2SWn42"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFED25394A;
	Tue, 28 Oct 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662961; cv=fail; b=fT0e93jeMHtOcTBDT4RaWfyReaon4eQ3r5/PLY0eI0Hj0HA9m8MM1FjTM/0l6KFiWl5w4VIy2RsKj/Ln4VYh7iFV+ESNgVpIpGwKempgQzGzO/8x8ME59iVD1PlonxwiS0CN6eTQwvex0YtGZjJYe5RBsFz8/HlTUvUITSDGTRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662961; c=relaxed/simple;
	bh=kiz0h+IRhU06rrcguAPPO80fRH4/7xIavJfYa+bi+Qk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=huMvhxfZzntxgUt1GPY6Eb3HxiXuqtZh0dHEh9Fegbd0wH/mGSoLk+/I72SyIwin/yG3aXPiJKiSeaGz4f5gSX5oYNIBjAjy3iitbABPQJAacuubtTYWnAz2jQQm9GFPg1AvoZE5GKDrSPrtNtWfgoXdCpyvox3UiUUywW+n4qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bp2SWn42; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP7w5H86aBmjbXKd3WeKj9nOAhInyifyGaziMWTHsKCAEfoo50W0FbiS1s29bgFTNGe1F6mR1K38c1UpnweXO7TgoUwsFg11v6QkbapWTFisYTlkk81TaiIYigVGJSOouDZu5FhAPQ9fHYZTNuhVwF8YJ2AUUUSIJCX+G3fUUw8jqu5jTc+nWXjy4dAaqGzQF4858g5Xl3HMpw9kQ3FkYPcdHrJvSEinksVUI5irsIyyFgXB6Qbx1quU/j/j4yNBtePBs50Oyj1bX6IQWobhgh9mSRDT3D65XHeCzaWEmUL17w7aiFB70oBo4OAO9T+LsO/gWEDjwObvtwUinNvmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHmB4RTtCBTP8Y0inLuKbzAQakhAJu7hXLKC9eMHD2k=;
 b=vxd8yuQHkRo+gvj8avC+Gdr1c7JYV35Pk+N4OBWEYOk5qGxH0kuzBK8wXHLlSI+uJBmEKUyIav5R3ok8qk+wLUYrAjJ9JzjyEyduxZ8gRwqdwVI/oZcEDqthECrhYLStLTV9MbPLt6CYDpkqP4Bl/uVgeg+NHJKK6WJ4muk9ToqPrP35GduEb1OYIQ3x4fdDcjmgv0f5fncwDJvUMtCqo+QwS90scuITpw2lF6v/W2KH4YnMumbsks6ZUxWCRdtj2R55gmDVgrAN2IHs4Bl0hfHfS4FDyX+MtncFYduOAdrnodiABCAcl90Q8jKWYR0B2kYUVkBotoO+X4raUqX+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHmB4RTtCBTP8Y0inLuKbzAQakhAJu7hXLKC9eMHD2k=;
 b=Bp2SWn42JTHSnQa/yWRiI8mFhvjcims+qxEnFcfWyD8SNOXhPEp7l6O4YjOLQBS7X+EPYM2E1x2DxjExcCmtDt54aym+I9VwVG0ETKMpC7G8scxXVxxiVUqjHfz8OMYmyE/6x1pG0+9BJEbIwOO8NQIzpObQ0CDF9K/RPmqTISq5BAnI12Mowan5uw9gIrzFWpkEbStDu0Fa/Kt6zaUG7oCq54JVdv+Jat3Qhi5kVL9zVLP27zZF7EOMZUzdegrgtbT7OnSODfwyCjowHaILZxXh8C1lyXzkdZH5kqYHAIqHGXDR2yHk0s0sZUREXFk15JlZQldwWkfcz9PZE+/wxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:49:15 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:49:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 0/6] i3c: Add basic HDR mode support
Date: Tue, 28 Oct 2025 10:48:56 -0400
Message-Id: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANjXAGkC/3XPwU7DMAwG4FeZcibIdpw43Yn3QAilbcJyoJ1SV
 A1NfXeyCdEWxPG3/P2Wr2qKJcdJHQ9XVeKcpzwONfiHg+pOYXiLOvc1KwKygNTobLrXvi+6Rcv
 eN4Cx9apun0tM+XJven6p+ZSnj7F83otnvE3/dsyoQQP5IMH2bIifhsv5sRvf1a1hplU1xKuiq
 pynALE1ZIX2ymyUgVWZqlpH0ncUE/5W/KMQQFbFVZmQYqhzK2L3yv6jbFXMjJ6TCNm4V26jcPO
 X+77FjYhBkL2SjaLNLanKOxcgJUkdu1Uty/IFIn8ZzeABAAA=
X-Change-ID: 20250129-i3c_ddr-b15488901eb8
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761662950; l=3184;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kiz0h+IRhU06rrcguAPPO80fRH4/7xIavJfYa+bi+Qk=;
 b=PovGy5QT52AXrd9bOp3YS6FWfnPjaZ3OhWlbqrrZVw5REP+m8Q1OWMs5pYb4PzmUlD4e7qN71
 uI/giBZjImjAm+DxcAxvCoTEbj3gL9Cs0jLIPFI+evzFNM/SWnynX+M
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 046c463e-55fa-481a-0264-08de163129f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzZKU2NKZWwvREVWYjRlYkp3WjBNTER5b3QwUng3bW15TEtjaVhVU2F2Q0Jh?=
 =?utf-8?B?OW94V3p1UnR3MXFUYjBXQVBRVTRnT0c3UEp0aytTYXR4OE1wVFNwV3JJQmZY?=
 =?utf-8?B?RDNlUlR6N1J6a2FUV1hEZnlPV2RXdGgyTkttU1VNbHBsNHc0dEtXU2dSQmk3?=
 =?utf-8?B?S2pCdHV4ZmVvN01WazMyRXRrNG9pU0plL0lpRHpPNm5ZV1p6VTEwRmlJMjN2?=
 =?utf-8?B?WktWT1ZKa3lwRnI0RWFmSnBxeFJVMmNRY0VzSGgxbE1HSk5JTVdQQ0hKbjhk?=
 =?utf-8?B?anIxb0VZa1pXbUFiUEc3VFFaMis0N2gyQkVaQUJtNUZXd1pIaUpySjRBSU1F?=
 =?utf-8?B?MktWQ1l3b3QzY2c4NFRvYm8vc2dQZFF6TVloVlpjaUhPblBXVlZqWnYydmd4?=
 =?utf-8?B?Z0NsczFZR0dlWmJkWTEyS3M5bE5JWjEyMU53WER1V2ZGbFRxYW1pelg1VHVr?=
 =?utf-8?B?MEtnckYwbkVZcDU2akxESUNhT2d1cmNvak1wQWNDbHZJM0lGeHF6T1pmUmx6?=
 =?utf-8?B?NnlLd29aSHpNWFp0WVlyZXJURVhXWkJIWkkrUi9oRFZZVTBKclg1UWRWaDBv?=
 =?utf-8?B?RXN3ZkJqU3dQM1ozMFdWMUVkS3oxQTFVd0RBS2dkZk9PUllwdTZlRi9sd3VC?=
 =?utf-8?B?NHFlcVB6Y1FBWm5UWkhTVkRTL2J1d3M3SVFoU09UWEtqVzBXa2J0NlR5VDIx?=
 =?utf-8?B?YkNXR3Z1aEZPOThZNlJsb0ovMXFCNmVDcFExVDBQQlZFWWFHRkMrQ3prWk1W?=
 =?utf-8?B?SHlvZExNb0ZjNnd6NUM2T24xa2xuUWhZRVA5cjJNQ3R6QXNoc2RqZUFkTlVy?=
 =?utf-8?B?VjdVVjJINmpnV01Nd2drQzFrdDJBM1J6T2FZaHhvSGVxYVVDeTBVUWQ0Z0ti?=
 =?utf-8?B?cFh2MkxwZ3JNRHVpREc3aVJzcXU2Z2d2dmZBamN2dy9SMzEyeWhQWjR3ZmtN?=
 =?utf-8?B?UkJiSVVmbDN5NklsWWVnVUNWOG5jRzBrYzB6Q3NTd2pQYXZUemJaTjNHZXp2?=
 =?utf-8?B?OVpUcXd1TXROUFVXd0xDclNQaWdmazF2ampidjFYaUlmU0RFYmhzWXphSEt2?=
 =?utf-8?B?bEsrdUtvQktGRWlrMHA3WnpGSzAvZmNOWXJtT2F4c1RYMS9VM0EveVRqZGZh?=
 =?utf-8?B?WXV4aWhzb3RDSHFTQkdEM1BpT3UzRnZqTGFMT2hQMUZtb3Q1aHRIa0JkUDVT?=
 =?utf-8?B?YUpkbDdRcjVCVkpjbzJ3MkhHVlZYNHUrMWU5c3VnbUlaZm9QV0JwajhoeWhK?=
 =?utf-8?B?YUdKL0RZS29rS0VBUjR3cy9XeHE3cUlCOGFqYjFCeWdlWnpMc1crcUpVTCtX?=
 =?utf-8?B?b1lhVTM5Visxc0ZaNW1ISkFXVEhMdDJSYkhNOVd0UUVlcys4TVdKbWt4aE5o?=
 =?utf-8?B?NjlqWWhWZ09FZ2oyK3RNTVVnL0ZocTM3K3dYYUt3cFdNRGtOcTlGZUYrNHpD?=
 =?utf-8?B?YW9UVzZKSktRS0l2Wk4rSmxmeHJHK2dHRUtGa3FqekNKUyt2c1BQZHhhNVF4?=
 =?utf-8?B?bUJORHhwZzJqZThJcWRpL3VxTFd6dktidmtwaUlZdmRUczZ2cWNvZENIWERp?=
 =?utf-8?B?K2N0c1pscldSUmRLR01kaW0ybk9PUW16THY2c1ZXM3IvQkxQbkFMc1lDOWNZ?=
 =?utf-8?B?TGhZVHFjeEZvMnBPd1VMZlo3WHB3WFc1NTJzNi9NRnlXSHJyaFlUSGZVajh4?=
 =?utf-8?B?VjNTRWFkcExxa0RSZTVza3ZFaVpZMXcxalhjSjNWWG1DWnZkTFFTTnpUREVm?=
 =?utf-8?B?S2p2MWE4RkxXU0kwR1RDc0FPcDZmYWNEdWJ2US8ybU5vWmJaTGJNYXV0T3NS?=
 =?utf-8?B?TVdvcjVnekhzV1hFZW0waTFEd0pOaDNLTFVoQTF4SEVTREV6YlY3MWhCUFd2?=
 =?utf-8?B?bjl1M1FpV1pVa3hsVFZiSGhFUVdJZExzb3pjV3hsNHI0UWhOWnRHK1J2UHdJ?=
 =?utf-8?B?UlgvVXJ3TEZFNFdqRmIyTm8yR1ExN1c3RHdyQWJyTGhoeVlyT0Q2YUprUGlH?=
 =?utf-8?B?T3E4clpmU2lCUFQwb2hHb0dJZ0xLaVE1QUhadTBlUTBhdHFqM3NWSnVLMU52?=
 =?utf-8?Q?lrlaVv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SitqWVVUUFZJTVptQWR4YVphMEtDYnh0RWpSZWNmU2FscDZZRFpEaUxiWThH?=
 =?utf-8?B?VkdLWmlGdjlHMWVsQ1JDZkQrQmpacmdjU0g5a3N3bkZBV0pIaEtwQ2Fta0xr?=
 =?utf-8?B?NWFrTDlvSHN2SmlHbGNVdHFRYVZnajJwT2tmL3grNjgzZ3FidUl5azNQQ1E5?=
 =?utf-8?B?dkFyRDllZlU3SE9VdGZkZlUvOURraVh5TkJOSGEvQkJvT3BBSTNheVZSL2k4?=
 =?utf-8?B?TVdiU0E5NU42U1d6Wm1zcldQZ3ZMTm9EZi9uYlRLc1NQTDZvQk5EaU1mYTIv?=
 =?utf-8?B?UCtKdWdoTm9vNkNMMFNWWHU1WFNRMXhTZmg0ZlBzOFNGVm5acm5LK1kxQjdQ?=
 =?utf-8?B?eXJSNEc1a1ZBbFJqRFpmdmhBK0VXbndRS3ZtV0c5L1JuRTdudW5VWmZGT0p2?=
 =?utf-8?B?V3lwL25uWndRWUZLRE1NWmRNSGJCMDUwbFFrTkRpRVUyU1lPdWhGZTZWQmVj?=
 =?utf-8?B?MXhLVUEyQ2dHNXJjYlZKb1hUeEF3ZDNYMC9PdmxJdTUxRUdFLzVtM1BOUVNl?=
 =?utf-8?B?MG5iTU05RzVVZTBXUmpPQWVxZ1BMVnRpdzJNS1U3SHB2b3FHV3NFS1hRdTZB?=
 =?utf-8?B?Skp3ZGhJeGd2eDR3dUlOUWhlRmkyajhRRWRHTmt2QjJJR21kc3BrcUthWVlW?=
 =?utf-8?B?bmwvYUlNSEd2R3RxK2c5dkhWcVBnNzdBVTh4SEtqcDdhQzNYNTZza29yeDVV?=
 =?utf-8?B?djc0V2xaM1dNL1V0WVdwcVdNci9wMmFnNzFXWkF5TjZ5aThMd1ZDVWwzMnlM?=
 =?utf-8?B?allJZjRZWTNiUUx1Z09FSDZRUnBZRWpKT0pzVUZkWGExc0RDaGxIVkhKYmdu?=
 =?utf-8?B?aUVOSmJTV2dKUjJab2tDN2VBcTJVdWFpVG9Na3REdXFUVUl3VGdkOFNML2R3?=
 =?utf-8?B?eUxvTkZ1K2d0NFFyUXFNU0thREdIS3crRWduQStKSW42TXFza0xkbkExS2Z4?=
 =?utf-8?B?Vkw0Zm02MkFmcEwyNXBESXpzR1pSRHQ5RkxleXRJWHF6T0JLSWFhOWVmR2dx?=
 =?utf-8?B?MXdTZEE2Zk84czZ0QU94MVhzUThqYjVvWVpLR2x0MmpJM2o5M3JXN0JSWkJW?=
 =?utf-8?B?emVySXhwSmEyOEJQc0s4RDZrUm1QRUw5VXpDYlhxdmJ0akw3aU96czRqWGs0?=
 =?utf-8?B?dURNOHEyZGpEdjhHNjhFb2xKakNiUFRiQjFTQlFUTG5aSHNwN2dHY1BMcFJZ?=
 =?utf-8?B?bUl4RHdvd0ZNTXpMTkRBam9hUldhTDI5aWVid2trRDh6Wmpkc3ZqZ0ZFUDV4?=
 =?utf-8?B?K2Njdy9ETHY3b0c4SHpHN0lFUkNwR2R2dHVFdzFtNmV0NVFaQzNMYm9EVGxB?=
 =?utf-8?B?ay92UlhvaGE5RnBGWUpnUmZ3bU5FRmhIck5MTTRQT1ZmS0ZudS82NzFBcmsr?=
 =?utf-8?B?S0RpUitvL0hsWCs5Q2FPejllTEVqeDNtdkVpUnNBSGUyMTF6WnBvY0lHOGNt?=
 =?utf-8?B?UHFiUG80MEpObysreitZclRnMmhKWVZDbXNoOVBnT2ErUFdBMWJnV09mZ1dv?=
 =?utf-8?B?ekhOWXVTRGVqOEZROGxGWG1lU0Y3OElXbm5wSDZCQ2FDNDltR3pyRU5ZQlNP?=
 =?utf-8?B?Z0dTZ251Ri9xdkJKd29pY1lHNXZkNE5qTzVVbWRiVFpDS3B1SUoxSU9ZMmhn?=
 =?utf-8?B?VGswaktNOG9Yb0dsSmZuQlAxclcrMndHS2N3T1dUTUFoeGYrOTA0MEJQNEdz?=
 =?utf-8?B?MzdUcVZjbjIzSVZoL1BUNUlSQm1FYjBvRGZjSkc3TzNBQWV3RDZLTm1CZFFl?=
 =?utf-8?B?OUUzOU9PNVFyM0V0RENsblR2TUpUVUJNbVBZM1dlVml0dGFHT1lKc2ZXbyto?=
 =?utf-8?B?V0ltQWtSOFBZWnZkOE9md0pSczEySWxvVEJ6bEwvR1FNanRzZ3Y5SVV4L2R5?=
 =?utf-8?B?Tm9YR2QvZGdxdkU1bHE5dGRWWUgwSnBjODJMNlZMU2t2L25TYVFNSTNuSzRT?=
 =?utf-8?B?WDV5NjJXTDF1dHNlV1JKRUFrRFV6bUJZWEpyRjU4VGJNcWpycHRxMHRNZnpQ?=
 =?utf-8?B?SVVEaXBlL2o1cStLQ3hSSzcybGhyTWtVTnNhS0VYZ2dZeks1cm9oc0pvS1Zm?=
 =?utf-8?B?dHlWV0YxRFZLUHpKWDZRa1lqeVVrNnpFQ0l6clQ1YkVyMHZxNmoyL1U4cHcw?=
 =?utf-8?Q?MKqKAoThqqkc6AszI4FJGR+g1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046c463e-55fa-481a-0264-08de163129f9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:49:14.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtcP/jLisGzfyWMwHdCKIaUjPwJcsjxJzopYVsa03BrEHDTgkrOZfnlt8ofwtg/He218KJpdnOxjFE6xY8sLSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

Add basic HDR mode support, only support private transfer, not support
CCC command.

Update i3c framework API to allow pass down mode and extend driver callback
function.

Implement HDR transfer in svc i3c master driver.

Simplifed HDR flow is (ref i3c spec line 5514) Figure 129

<--              SDR            ---> | <--- HDR
START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)

                                    ----> |
HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT

Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
read/write command.

svc hardware can auto issue SDR part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v8:
- Add cleanup patch replace framework's i3c_priv_xfer with i3c_xfer
- Link to v7: https://lore.kernel.org/r/20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com

Changes in v7:
- add explicit define for I3C_HDR_*
- add missed include files.
- detail see each patches' change log
- CONFIG_DEBUG_ATOMIC_SLEEP=y
- Link to v6: https://lore.kernel.org/r/20251014-i3c_ddr-v6-0-3afe49773107@nxp.com

Changes in v6:
- remove acpi part
- collect Conor Dooley ack tags
- Link to v5: https://lore.kernel.org/r/20251007-i3c_ddr-v5-0-444184f7725e@nxp.com

Changes in v5:
- Just realized missed CC mail list devicetree@vger.kernel.org and resend
- Link to v4: https://lore.kernel.org/r/20251007-i3c_ddr-v4-0-3afea5105775@nxp.com

Changes in v4:
- use master's hdr_cap to check HDR cap.
- add mmc5603 support.
- Link to v3: https://lore.kernel.org/r/20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com

Changes in v3:
- Add new patch for change rnw to union for svc.
- Detial changes see each patch's change log.
- Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com

Changes in v2:
- Add sensor driver, which use HDR mode read/write data.
- change priv_xfer to i3c_xfer.
- Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com

---
Frank Li (6):
      i3c: Add HDR API support
      i3c: Switch to use new i3c_xfer from i3c_priv_xfer
      i3c: master: svc: Replace bool rnw with union for HDR support
      i3c: master: svc: Add basic HDR mode support
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 drivers/i3c/device.c                               |  27 +-
 drivers/i3c/internals.h                            |   6 +-
 drivers/i3c/master.c                               |  20 +-
 drivers/i3c/master/svc-i3c-master.c                | 115 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 588 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  42 +-
 include/linux/i3c/master.h                         |   4 +
 10 files changed, 776 insertions(+), 43 deletions(-)
---
base-commit: df05ef50ada6a8e2fe758adf1b8fa35eea801b2d
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


