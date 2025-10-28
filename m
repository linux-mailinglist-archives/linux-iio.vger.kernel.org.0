Return-Path: <linux-iio+bounces-25588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D19C15483
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E272461E9F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D833A03F;
	Tue, 28 Oct 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gehMMqVp"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97E305978;
	Tue, 28 Oct 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662979; cv=fail; b=rHE//l+syBzwMQc1nbOkgZ1SBg/+WV9P5EvfqC1lroZnC8/HuqF/pbT/Xm1Cy66QB5UkID4eBcca2rG2h4f8Vqh84H9phUpOJX9sQfrDOFxL0GYuwHY/EPCiRczlynREnrYjNh4CantrBfK+TdrzEFcBQnA7v+REfCtqtQnKD6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662979; c=relaxed/simple;
	bh=qTffBCdu8Mi22zZGCzL0uFmkILG2U6LbqIh7+jK2h4k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PAiXEbNAe8qqGRJ2F1k9O/DvR1VRl1DAkqnYahH+VyQE/23xMYjJUt3X+lE1wu9KAhZKz521W9OBsO1C1CAM6bXphzwrFjhJqNrdFtpuTfhhWouu6ho1mocIf8iKcEYAzW/Yfn0m8bxr+ZfdO10zckXHN7LCA5rqpd5yXaGP3Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gehMMqVp; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6yY1e/pSefw/e5/JJzij/ZXCd2ehocSnotAyQooiki8iLxY6inmwFiaPxfYlkvHfN9NH808gckdsvwk4q7lcgZnuu0Kwi4n6ggp3fCOdoqeaoimYDcVwQpFJmt7v+iYnVWa1jxcd2uZITcdRaITZUJtgBV6LJ3ADzfrFJS9xZD5WhRYjMo537HmvWD+UZ1fINNQ6oHtnmzsuwdXq8FQ8i08PjT4n8WkfBbIlTpfv/4GGAzkBMSVIBl4MSdKbIcQzN/QutKacCEWCdNC4Nz/lb1/jYWU3XeJn3Cxg//ABrJ09E3nAGorwpmTnrjQWBVzRY8QLv3wh0dPEYvAifgHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mizs44l9kM6gfuXuMhguTCgPiOcdxwSSLKRegAmEMuw=;
 b=RTl7VEDqNRYAVPD6vAIqpMTC8M5qusnS9xQj3rNQDuMONg6p29bIBE0+xemNTNgJU+DD/40YdThsqBolNAkD9i1nTKeNdD7JteCOe5erRbgSRByfv36n/mbypBvMwZOqUFW3TAztpW718wp/QWMW3t2C3fOuiX9KMCwxc2fofFDfZtZwr2bRwjxDhLvuk6XjisqEWZLYwzoR32bQaO6H5V8zNgSXPTHyGoUOG91xCHJLSJKE868He6zzbCyr3m7qevUx0StMhWIMFGo8CWqV62hpcCG1cFRyfvY7lMRG+vVl9TaOrJOYNlFwuvzHkpd04KybPu7+E6fTbj0I9nTTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mizs44l9kM6gfuXuMhguTCgPiOcdxwSSLKRegAmEMuw=;
 b=gehMMqVpdud2vOSzX7L2RQQ0C/qOrcct+1w4T3aV6KLCjjepJA8mZ6RsLyg2q/4T2wP16Ts0fV7JoH9ZmfjefX544xZOgmMO2548fcFAYttVkE6Adq5yEZo/Zua8YHNQbnff3Qb4dpYd0MVOwS5B7Ba/K0myIXgOYmyiQ1y06EM6S2OjRN/VFZc9Vp3zIIuopIaQpXeRduF5BrzM4/zuoitRMXVRbqYz4rZgVIsDJAHvpC6I0SlV/7OeZJJrg5NbZ+8n16tGUdZxG9/20OpYS5SVZ0lzcl+r6LgUdJx+gMf355X8V3bjqGEJdvAwvyMsf4YgC2njTlO4QqnCYYyo1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:49:32 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:49:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:49:00 -0400
Subject: [PATCH v8 4/6] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-i3c_ddr-v8-4-795ded2db8c2@nxp.com>
References: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
In-Reply-To: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761662950; l=9137;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qTffBCdu8Mi22zZGCzL0uFmkILG2U6LbqIh7+jK2h4k=;
 b=KdGZp28fhgf/oe73CUOt1KSXxfM9ukipisBZFmrIZD0Ss00Qs5OqudWnrdxITTdhzsHiZRpTo
 k71os30AWfBCUBz5U+QrlayipsMQ4+wahwPdvYOJ8eks9AOIfsvXJNG
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
X-MS-Office365-Filtering-Correlation-Id: f627e597-4d65-463e-2502-08de16313431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnRhZEh6b2pUR25EUVJ0UnhyaWIvc3FDY05JWkFlVVZieEpKQ2NSN0wzbHBP?=
 =?utf-8?B?YW44Unc3MERsSnZ0N0loMTl1aEx4U3VFN2QrTnNPRnFUaXRKbHNqcFFNYXNQ?=
 =?utf-8?B?SkNheE5UdjVKYlhjVTJZTDczQmNFS1hISDhZOGNKNFVOL1ptUG16bCtNbTNi?=
 =?utf-8?B?L1JVcFZ6VHUrRlJkQXFIRUJZVlA3eTQ1ZEF5aFo4WWpJN2NMTElhNW9qMDdQ?=
 =?utf-8?B?Z1pRQnZJaVQ3K3diWHVMVndmdkdzUGtPeXVHeEtaS0VOcEFJVmNlRVZ2cnJI?=
 =?utf-8?B?N3JFdFMvQnFFRmdGL3Rmdjhnb3FsQjYxeVNoaDJjZzVCYXM4RVVvZlFIS0FK?=
 =?utf-8?B?S203eDdnTjVWWVYremxzV1JIdkVVWU91Rkk2eU50R2dsTVJFK2ZuTFJpa3ZU?=
 =?utf-8?B?aWdiUmtuTmtsNktINlNrQXhWTG9qQmZPWXVwRHBwSmNKTUtNZ3hvRmtjOGx0?=
 =?utf-8?B?WXhyUWxiMjBPZzhNaGxuaEdRMWlUdnVLK3llUnVMSUxFcXlYbCtXdU5VVy84?=
 =?utf-8?B?SlFxQU9McHArVHg2RllqQ2Q5Wkp6NEVOSTdSTkZhV3NYZVlPdlZsWURyWTZU?=
 =?utf-8?B?OWJWcXNMMmNya0QvdzFJWmI5YVBmKzNmZHlEWG1Gd092QklhRFdtbUJUdlJa?=
 =?utf-8?B?Q1hlRWdOYkp0bVNickhnUG4rV0RoaE1nQW5aajR5a3ZGN3IvOE0vK3g2cG1w?=
 =?utf-8?B?blVnQmxReVlXTmpoY1ZVSWZLTjUzVHV2UWswYVUxZHdyWmxnMUZGdFkyWkRu?=
 =?utf-8?B?dmJieERFMGtDcUZHN2UwUWtvM2oveC9YNDhPeUExck9FY08yNFNrYUpWaXow?=
 =?utf-8?B?ZEZXVHY2TllqbHNuUXREZE10V0gzbWpOQ2VGRGhwbFUwa015T1dSSmpDVm5s?=
 =?utf-8?B?aG94VHU4blpOOUZHUi9kYTdTN1RZL0RkRXF5ODFCUFZFMzJzN3NtbktmS042?=
 =?utf-8?B?WG9GLy9ieXV4TG9YUXpOV2UxQWhORDdCRmhrQnl4RjJGYjF6OGc5Vk5pTUxr?=
 =?utf-8?B?Zjd3eHJReGNiOVAvUjIzdk9Lc29tWU5wWEk5OCtRWjcyTStwK3FvS1hQdmR6?=
 =?utf-8?B?bXdVNHNzT1laNWZSeW13WTNmRVBzTUp1VWFlenFTUVRoc09HNXVGZkJ3SHNE?=
 =?utf-8?B?S1paOTNhOEd6UXhoV2ZtSkdIYndYbGphWXNpQnJEWm1kN0FwOW9kQVlnV2tK?=
 =?utf-8?B?Ym4wMWt6bnorVXhTRThRMEtDRU9sWlNodWZGQlNmN243OElaQk9UeFJQeStP?=
 =?utf-8?B?UDFNM2pPUUNMVlFwNm9mWUxnaElocUs3dDY5bXVBYnBjV1Arc1lQbHo0dmky?=
 =?utf-8?B?S0pUKytDSFVXWUwwdTI1ZkRNTVJnTXRSV0lVWlhaSjRIZDYxaXNPS2I2VDlM?=
 =?utf-8?B?ZkpmQUtNZzhvZ3NEajVxM0o0UnJKTU9XbXRXamRoOGcrd3U4alpSRlp6eU1p?=
 =?utf-8?B?UnZFdk5VdDh3NUtSZDdpZVlGN0JoYUFTR3h3VGt4eTAvamNzdG9zYnVqWlRl?=
 =?utf-8?B?ZHBZbG5pdkl6MkhuRVBHc3ZHSVNSd0RaMGJkMHltUkFhMkNGb08rUzIyWkwz?=
 =?utf-8?B?L3Ria3o5allpOUhRcXh2VTcxZTVjZTNOWndFZkphWE5lem5mRjdWS2MxUDNP?=
 =?utf-8?B?RWh3WjM4LzZ2SEVZN0NkdEc1S3BGbGdaYkxTdVFWSDNDQ2U4LzZxTlE0d0ZD?=
 =?utf-8?B?MWxhM3hUQmRsWktjTjZxZHl1Nk16dmNlRkwremUwajFmczA4Wm9tbUEzY213?=
 =?utf-8?B?dFZFcmdoblZiS1FlM2tsMTZ0VDVIN1NXOEk5OVl4VFBaVjFVNExFZll0WkRh?=
 =?utf-8?B?YkJ1cWNVWDhOMDVUWU1ZNlFJTFB3M2FlSVlQM0RkcVIrR3hiMk5qRFdtZkJm?=
 =?utf-8?B?NzEwcUdwOUtYOFhFSVdZMEtsUlZUUzNqTllieWFXM0tHZXozM0ZITlJoTkJy?=
 =?utf-8?B?TklHYnprQVNMbjY4NlZjT0Z2WEdpM2NQNjBQcHViZ0NhZGhSSHFVR09qbGR6?=
 =?utf-8?B?UVFuZjk0eDZWbjhZRnd0SWlFOWhwL3QvZmN2dDh4TXhpQ1JRZWpJUG5uRm5m?=
 =?utf-8?Q?gZSpW1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2RpRkhaanFZeGVUTW0yOS9ocTMyRnR2TXZtRGRsQW5RT1hIcG9QL2RxN3lv?=
 =?utf-8?B?TXRFUGg0R0Y3RE9sd3VVeXRuSExrUkthY1o2M1B5TmxGTUZheUZqbis0Smlm?=
 =?utf-8?B?UFZzR25senFhMnJJRGs1ZnNuK2psd1hSZnhDd29JeGZGLzVUMittNTBGNG0z?=
 =?utf-8?B?enIyNkFNL2hjblVuR0lyVjgvajFlVSsyVExUWmpNNHRIODhRWDNYV0pZOWIy?=
 =?utf-8?B?YWZSVElEbHhveGFkL0ZES3M1MWN5NzQ0cGxsZUo3OHd2a1JOQmFaRVMwRHdx?=
 =?utf-8?B?eElMbkk1dStMbTlNbVNLSjZyTWFHVFN3RFcxZG1MUXg3V0YvZStacEo3YnRB?=
 =?utf-8?B?Z2ZWZ0Nsb0Q0cmEza1IwMmRpazg4K0VFcENPL2N4cE5MODVoOFVKWE1tRDY4?=
 =?utf-8?B?bjBsSTMwUXhFNU8yYjhtQlIrN0dFcEpnRWJmYWlvamZLbHNiUTVwdDNtQWNI?=
 =?utf-8?B?VVFHcExwY3Z3cXRmVFlGVVBKYWFkOFdOdElpMGk3M0EzVVlUaGlyTSt1YVpY?=
 =?utf-8?B?T1VCNUoyby9HSFlkOVhIWUJSTFhsYkY3NDFZakFrd1p5OHkxUk55a0srSXNI?=
 =?utf-8?B?YzhieXhFempkdFpZM2J4dWpPZTB2ZVJpN09UbDJoQWkvQkxHWHRrUitYeS9k?=
 =?utf-8?B?eDlZay9odGpmZXZKRlZETStMUEk3MDY0aW85R0ZmWVJOU3pEbWdieFFENXVB?=
 =?utf-8?B?MW1BT2lmaVlLYnJXenZxRk9hYS9CcGE0cWlEK2UzRE5kR0RsZ0lMUU81anVh?=
 =?utf-8?B?RVh4OXlvNzQvVjBVSDJqaWFiaFFzbkNNK3NXQlBtaHR3V1dwTVpCY1dScWpF?=
 =?utf-8?B?U05DRDFybDZQT2V5RythTldPdFovcCt5L3p5V3RmSnVqZENqT3FRREdQRGVr?=
 =?utf-8?B?dmdLaGs2WTJoWjU2R0JCR2ZsV29EZ1kydEtwSEIxS3NidHdkSzEvZmd5L2hk?=
 =?utf-8?B?M0RCUEt2aXRJMUxrL1NtalhXNWhnbkc4aWF3dnQ1QWJwN0Z4QVNYTFRrVzll?=
 =?utf-8?B?bXNCSjVNaHE2UTE1NmVvejZQLytjeitQN0N1d0x6di9sWnBLbXh6bTJCekVH?=
 =?utf-8?B?Y3hEZVBkQXlLa1R3VnJtSGNxMFR4Y25rcG5Ea2pRTDJvd3oxVWtLNnQrSVB2?=
 =?utf-8?B?TFU1ajJkQVI2d1lVMFRNMUNDS012dmd0QUJMeURObzlnd2hHeUlqeTV6QWdi?=
 =?utf-8?B?Mmo2eStOOEZDN2hxMTVzTUJ3NE8vbWpKUjlOWnFFRzljMXlTdCtMRHEzRU1o?=
 =?utf-8?B?UnUwNjZPM2JMUHZNK043d21WNkRUdXVPK2tFRk9aNUI0OUtxM0lPbktUQ2lU?=
 =?utf-8?B?RlVXRGp5RmZWeHVCdnhKM2VzcGZvWk8yMEtsY25uYThPcGNNVVJQeitpeWZu?=
 =?utf-8?B?Vk9LU28yQjVVV2NCTThoU05aTWIwTFJ0SUhZK2dLamV2cHJCZ3RDNUVFQ1VD?=
 =?utf-8?B?M25aUElzcEtXQnl4MlBQNkN5dVJDZEdONTdGc25yTkxQTEYrbUVMTVRVWDd0?=
 =?utf-8?B?MEg4TnlIVHAvUUtKeldGNUY2OU1jKzNzeUlRaU1xQkNrVWlvOE1xcnBlQVV0?=
 =?utf-8?B?Ykp3VmNuNWZlSmQ2eEx5a2RIcFJaTDlBR21GZm82K1ZqQ21tWlpxWGt2bjFP?=
 =?utf-8?B?eDBoWG5Kbm1zanJ3dlgwQTVFRmlLZHhhOXk1S3NPbVRnYnZqakZDaGFxbWs4?=
 =?utf-8?B?QnVJUkhtUVZrd0pnZU02TFNBYkFheU10dnVoRzJjYkkzZXhaUGo3eThTT3Ey?=
 =?utf-8?B?K3g1VCtWNzRLcVYwNGVsRGpLYnVGR0V6UkttSklabThxV3c5ZXFHUmJWL2lG?=
 =?utf-8?B?WUV5cWcxQXRHaURCa3dNZ3hZVldWOG1CRHg2TnhrUzNMdkRvbm1vR1U0VUJn?=
 =?utf-8?B?ZXZVaDBZWTNqVzdGYXV3Z1l1TS8ydjdPaFZyMytTY210TnkvbGdMSWJzRDhx?=
 =?utf-8?B?eEtjWmk2RFgrMFR1QUZqMGlNeWRoRVU2WGw5MXdZS3RYWll2QkZEQzJCb0tj?=
 =?utf-8?B?R0RKa29LOW04eDlLUjNVTStCS1hsa29JY2tDMC9CMFdtNDNENzFTRlg3ZVlQ?=
 =?utf-8?B?dXhrc2hPSjFkM0N6Uk5ZeFlVQU9Oa0xoR2FZczMveGtLeUJ6b3lIMWdsMVJU?=
 =?utf-8?Q?zTogcwJ4V3fhIy6kCN8cY8Ap9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f627e597-4d65-463e-2502-08de16313431
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:49:31.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJO+Qok8qTrg/WYG0CVya3NN2PrvXCOihYZtqXNNC7lRPTHsXhIA0dwOqzYmxZOySTV+PwMFLGWNMEsmuDCFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

Add basic HDR mode support for the svs I3C master driver.

Only support for private transfers and does not support sending CCC
commands in HDR mode.

Key differences:
- HDR uses commands (0x00-0x7F for write, 0x80-0xFF for read) to
distinguish transfer direction.
- HDR read/write commands must be written to FIFO before issuing the I3C
address command. The hardware automatically sends the standard CCC command
to enter HDR mode.
- HDR exit pattern must be sent instead of send a stop after transfer
completion.
- Read/write data size must be an even number.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v7:
- add comment about why need check return value readl_poll_timeout()
in svc_i3c_master_emit_force_exit()
- add comment about why need udelay(1)
- remove reg = 0;
- chagne to use readl_poll_timeout_atomic();
- replace all i3c_priv_xfer with new i3c_xfer.

change in v4
- use hdr_cap.

change in v3
- rename to svc_cmd_is_read()
- rename to i3c_mode_to_svc_type()
- use local varible bool rnw to reduce change

change in v2
- support HDR DDR write
- rdterm unit is byte, not words (RM is wrong).
---
 drivers/i3c/master/svc-i3c-master.c | 96 ++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7c516e05d0a1a118479ee3d8ea8ae37ae19fea57..a732443caaf15a2f6e54de46bbafdeb3fc9a9296 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -40,11 +40,13 @@
 #define   SVC_I3C_MCTRL_REQUEST_NONE 0
 #define   SVC_I3C_MCTRL_REQUEST_START_ADDR 1
 #define   SVC_I3C_MCTRL_REQUEST_STOP 2
+#define   SVC_I3C_MCTRL_REQUEST_FORCE_EXIT 6
 #define   SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK 3
 #define   SVC_I3C_MCTRL_REQUEST_PROC_DAA 4
 #define   SVC_I3C_MCTRL_REQUEST_AUTO_IBI 7
 #define   SVC_I3C_MCTRL_TYPE_I3C 0
 #define   SVC_I3C_MCTRL_TYPE_I2C BIT(4)
+#define   SVC_I3C_MCTRL_TYPE_DDR BIT(5)
 #define   SVC_I3C_MCTRL_IBIRESP_AUTO 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITH_BYTE BIT(7)
@@ -95,6 +97,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_CRC	BIT(10)
 #define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
@@ -174,7 +177,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
-	struct i3c_priv_xfer *xfer;
+	struct i3c_xfer *xfer;
 	bool continued;
 };
 
@@ -389,7 +392,32 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 
 static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
 {
-	return rnw_cmd;
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+
+	/*
+	 * Not need check error here because it is never happen at hardware. IP
+	 * just wait for few fclk cycle to complete DDR exit pattern. Even
+	 * though fclk stop, timeout happen here, the whole data actually
+	 * already finish transfer. The next command will be timeout because
+	 * wrong hardware state.
+	 */
+	readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+				  SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+
+	/*
+	 * This delay is necessary after the emission of a stop, otherwise eg.
+	 * repeating IBIs do not get detected. There is a note in the manual
+	 * about it, stating that the stop condition might not be settled
+	 * correctly if a start condition follows too rapidly.
+	 */
+	udelay(1);
 }
 
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
@@ -521,7 +549,7 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 	 * cycle, leading to missed client IBI handlers.
 	 *
 	 * A typical scenario is when IBIWON occurs and bus arbitration is lost
-	 * at svc_i3c_master_priv_xfers().
+	 * at svc_i3c_master_i3c_xfers().
 	 *
 	 * Clear SVC_I3C_MINT_IBIWON before sending SVC_I3C_MCTRL_REQUEST_AUTO_IBI.
 	 */
@@ -801,6 +829,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	info.dyn_addr = ret;
 
+	info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
+
 	writel(SVC_MDYNADDR_VALID | SVC_MDYNADDR_ADDR(info.dyn_addr),
 	       master->regs + SVC_I3C_MDYNADDR);
 
@@ -1314,6 +1344,16 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
+		if (!rnw) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+			if (ret)
+				goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
@@ -1407,7 +1447,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
@@ -1420,10 +1460,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (ret)
 		goto emit_stop;
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR &&
+	    (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_CRC)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
 
 	if (!continued) {
-		svc_i3c_master_emit_stop(master);
+		if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+			svc_i3c_master_emit_stop(master);
+		else
+			svc_i3c_master_emit_force_exit(master);
 
 		/* Wait idle if stop is sent. */
 		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1433,7 +1482,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	return 0;
 
 emit_stop:
-	svc_i3c_master_emit_stop(master);
+	if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+		svc_i3c_master_emit_stop(master);
+	else
+		svc_i3c_master_emit_force_exit(master);
+
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1480,6 +1533,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
 
+static int i3c_mode_to_svc_type(enum i3c_xfer_mode mode)
+{
+	return (mode == I3C_SDR) ? SVC_I3C_MCTRL_TYPE_I3C : SVC_I3C_MCTRL_TYPE_DDR;
+}
+
 static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 {
 	struct svc_i3c_xfer *xfer = master->xferqueue.cur;
@@ -1669,9 +1727,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+				    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1679,19 +1736,32 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	struct svc_i3c_xfer *xfer;
 	int ret, i;
 
+	if (mode != I3C_SDR) {
+		/*
+		 * Only support data size less than FIFO SIZE when using DDR
+		 * mode. First entry is cmd in FIFO, so actual available FIFO
+		 * for data is SVC_I3C_FIFO_SIZE - 2 since DDR only supports
+		 * even length.
+		 */
+		for (i = 0; i < nxfers; i++)
+			if (xfers[i].len > SVC_I3C_FIFO_SIZE - 2)
+				return -EINVAL;
+	}
+
 	xfer = svc_i3c_master_alloc_xfer(master, nxfers);
 	if (!xfer)
 		return -ENOMEM;
 
-	xfer->type = SVC_I3C_MCTRL_TYPE_I3C;
+	xfer->type = i3c_mode_to_svc_type(mode);
 
 	for (i = 0; i < nxfers; i++) {
+		u32 rnw_cmd = (mode == I3C_SDR) ? xfers[i].rnw : xfers[i].cmd;
+		bool rnw = svc_cmd_is_read(rnw_cmd, xfer->type);
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
-		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = rnw;
+		cmd->rnw_cmd = rnw_cmd;
 		cmd->in = rnw ? xfers[i].data.in : NULL;
 		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
@@ -1890,7 +1960,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.do_daa = svc_i3c_master_do_daa,
 	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
-	.priv_xfers = svc_i3c_master_priv_xfers,
+	.i3c_xfers = svc_i3c_master_i3c_xfers,
 	.i2c_xfers = svc_i3c_master_i2c_xfers,
 	.request_ibi = svc_i3c_master_request_ibi,
 	.free_ibi = svc_i3c_master_free_ibi,

-- 
2.34.1


