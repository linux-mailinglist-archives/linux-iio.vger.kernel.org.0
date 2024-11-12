Return-Path: <linux-iio+bounces-12185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0329C5DD1
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 17:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8922836E3
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C7214423;
	Tue, 12 Nov 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XZknItbC"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676020E307;
	Tue, 12 Nov 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430361; cv=fail; b=NcoHRZfL4ydnDi80JhnYYRSbTyQN489Nee584TszJt7TFXkCTvojh9PIf/uo2RQj8e7VgbcyrmnaSCTiezw2wjjOEB3umeW7VPmg0OQkHbnHL3iSuVgP0tvaU5gYD/lKqEjX4mz4pR8CF8vqCMjc2u4VXYIeqJG0kM2A3qxKvSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430361; c=relaxed/simple;
	bh=kFxt9dtkDU0Y3RY9oVvdu1BMstpufdDdNMTqBmUK6g8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YQIi7+LRhgZCMWHLFujcxO0O1OyAYr5r5quz+cgEPpzk8SCquXjNFMhjcTvLqUAPf6B8XSw12TieL5ENJh2yV+c4ZNtkh0EEr+Svswi1EmFZz1DZ49hDkh/QYyCAupKBJOa4UcodlG5tvfKxFZsFzLoUUWWg/Sb0XueYh3zgbRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XZknItbC; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYb5BLRoGrcJlkvr8nJRd1BjitlKwZ+/xNRtTIxeevxKfJwG2Fr2wPFQYlIARDJjiwFyvO6XB9vh0fwWqNFUFPuiFhm4wcckuLNl/zTZr41LbzYNVZmQZMNvRQZljsS8UrtewSU7PJWS+SL0jvz8AueQAUg4deJwL8sLT7BW8P5dwNaHb89sAuSKcC+MBLJw/J4RHhankRRPQRNXH8KnsZPj7pNwGakmHa97ul2gnXF4Q7PTWr1CzbdM13KZ++sI/P14SL8hZqFiom2AYmCniBJOoEjHMeBTBbZGt3DN8+ZryruWJ9obxbzoHQw/703ydRhT5bhpIpuLA+PFyEZ40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC9IS6hnaMg8q2h5PuNaWDtU19rB1dExXzbSlG/8fkI=;
 b=HjWlxOSi229v9c+pw8ocC6XFuZ/JojYgHM/ynpofEBXj5TSyD2Co6LFbUjve2NKvA7+6BpecE7S1NcJRygrSLrSNFY0CotQ6+fu7OEtBuBcaw1Zc54xA3q492vdxx2GaOoLlSEZTn+05Ec/DeTstjPM0li09G0EodrGDnRXKNNDGegp1O221uGF0MHu7PqrNOVzfLxNHDa0pWQTMcI+L7zb9BIctXdYI8bjufp/OHJTQ83tr/fS91jpcCDyU+DC78LDXfhLczoDN6SckwjQvR5XfoVV+QWmTIJ9pIET1DWtelOqS5vQ2cWrF7S5BfAmuaYq+oBeZyRd2Wrvvz1VEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC9IS6hnaMg8q2h5PuNaWDtU19rB1dExXzbSlG/8fkI=;
 b=XZknItbCZSCi9EpY2tPjmnSfIC3OZp5Hj72riMRp0n/9f/T6lFJsCkgbGANzdCJLXyZ++Fy1ixh7PXqhmn3gW6Nv3bGQI53sile/TjfGsbXzX14j17xLVZrBpnfwv9cguGgffsLBw4ewXKbsk8lPK/3QZt2W1WQmG+niSXsgdb9QJ1GXkHAroluP9JyvZtZF6wK3nJvSsV3lSjoku49rNNtPqjpnZJzoFytsOWktC86orw13wOwuCyxaeVlTm8h3fYE688Jm6rcnoSXXd5QX3RMtrOlLJyFzO+IAB/nAHhiQFtZk3mhzfPl2zub4n9mL6K5NDw4yRJudnUfvNliLpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 16:52:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 16:52:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 Nov 2024 11:52:01 -0500
Subject: [PATCH v4 3/3] arm64: dts: imx93-9x9-qsb: add temp-sensor
 nxp,p3t1085
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-p3t1085-v4-3-a1334314b1e6@nxp.com>
References: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
In-Reply-To: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731430334; l=756;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kFxt9dtkDU0Y3RY9oVvdu1BMstpufdDdNMTqBmUK6g8=;
 b=pIiZiLd0SarijBCnVJARYnej6K5kNxNDMSGQqnFXss4iws/Crn5cMGaAtaWAaMF0PJnHeb9Ay
 WI6XGdv1tKwAJ/7wrEzW5x2JO7tiL57GVtBe/czl7Lp7irLw7EOLG5a
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 396d72bb-7e20-4437-62d7-08dd033a66b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3VmU0JFd0dCRG9uNkxzSkkxWmRZNEx0OWtaVEJFcGV2N1MyNHdJK251M2Y4?=
 =?utf-8?B?bjN2ZjkyaHYxNVFTbmtmbTh2dWRaSzYvR1Y3M2pvZ2l1OFZSSDJxOEc3cWpZ?=
 =?utf-8?B?czUzSHNJdGhLemdTempwK29oRHFmWGhOOEIyd0dTRUMwMDQxYlR3dFpNZ3ds?=
 =?utf-8?B?V3pYNkRDdWRXL2NLMHhLSUN6YlROVnE4OXBFZjJKUWRYMmJBbFg1VGtSY1Fj?=
 =?utf-8?B?S2xIOVQzMGdpZ0JRMlkvS2NFa09RVm4veHlyRU1KbUFQbmZwYXI4Sk54SGE2?=
 =?utf-8?B?Y0o5MnFyVkMrMVhQMy9ZR1h6NE12dXR3Y1NrVEVlWHdHQmdqREtVS2V4MGxv?=
 =?utf-8?B?VndEVjdaUFgwZVMwamVZT3Y3ZE9SUFJpRldXVitnbVNYaG03MDFXdTIzRjFF?=
 =?utf-8?B?akR4SGRxaVBUbDlWRUxMT3k3cm43Nkhmc3pCNXcvV29VUlF6THhhbWxaWXZG?=
 =?utf-8?B?enZlanhNZGZNSUo3dFZEaHh1MmgreGx4clQvai9rZ2tuZ2ZwZUlSbklnRE1v?=
 =?utf-8?B?dlVQUkVXc2FVMW1hV21HWE9HRVVaSXNWaVlJQ2RVeUExejMzMGRDL2VYaFdZ?=
 =?utf-8?B?UjhmZXdNdnJZRFRVVTlEaU8vUVV0WkZYZVFDQmhNZGV0Sk5WdW9Dd0lLS29Z?=
 =?utf-8?B?cTAyYzNvVnZIQnVDUDl0aVc3YjlNUnZUWUVaVWpPVjZwcm5NSC9CbDU1TDR1?=
 =?utf-8?B?MFVCU1BUSHpETmhLRGZTTlhWTitHdDVrOFpFb0U2R3NoaGlhVUZZT09yOEYy?=
 =?utf-8?B?ZVg4TWxIaFNrZ3pUK1EwMVV0TlBkbHFNc0Q4czNLYjJmL3lFSFVwU0lwYVpr?=
 =?utf-8?B?dkkyNUkrWkl3QmM3RURpWHlldkRPeVFUL3JHYkdidkpEZGxnQ0xVWjVsUFB6?=
 =?utf-8?B?RzhzeHJPYXI4cTBqZFM4UmRHNGV5RFNuUy9wSTdUbDlkcWdqWVRGQXZsbVNl?=
 =?utf-8?B?QjhjRGJRb2o2Z1VTVitlVCtYa1RqTUpDL3AzcUtoTFZJZlFYQ2ltcmVwRUZ3?=
 =?utf-8?B?c1A3ZGhBVHpmdVRZL3kxbVB3NXVGNmpVek53VTNNVkUrLzFLNXZEUFNMSGE3?=
 =?utf-8?B?bHE0WlQrQ3lzMXlpL3EvWDZNTkJNbVhmdEVTV3JlTVl5U0FhVnpXR01oWGlE?=
 =?utf-8?B?WmdFdDQzUkdGcVNEZ0I3a1o4VjdNaTU4eHliNkM0Z0lNN3diVGUzZmZJVXd6?=
 =?utf-8?B?aWpGb2FEUjNRVjFIY0tyMnB2ck1RVGY2YmlhWHJFWWFVTmRva25YcEsrb3Rt?=
 =?utf-8?B?STVWYkJxRHlZU24wNmNIQXlvczYxOHVCNUdVRVBJRDRFeFZ1WVNVZThHRFRP?=
 =?utf-8?B?RmNQMGpSeUtuRXliUGc1eE8xYnAzTkhXenVtb2hFRXRhaU5JOWthb3BKcVF6?=
 =?utf-8?B?VmhST1FRL1JTRlhhQ3MrcXBqTzluNzdxRkZ3M1JkcjNpeTFHOGJSVm12RDdM?=
 =?utf-8?B?OHpPcFIrN1hlUTNtSytzZ2NBQVFzcndQdWVZOWg4S0hIR3JTblZDNFI4WG1u?=
 =?utf-8?B?QVBwS1RuZE9Vdml4S1IycjhQeXNNRmxzcERwenZUejlIZTNTSXdISHhlZ1pB?=
 =?utf-8?B?dnRkV3Q0cFBqTUlUaEF0MUtEcldxejNOejY0bG5Wbm1TUXNOaWI2VTlpZmNX?=
 =?utf-8?B?S1Fyek4rV0d5Vmw4V25FY05GUnZjRlROOGVxWVI3WlBCdzcrSmFjOHBCYnM2?=
 =?utf-8?B?eUVMMDgydlFPS05pOHF0ZExzcFdwZ2FqN0xrSmZyWldLM1orL0pvOWM0UnlG?=
 =?utf-8?B?MWlFK1RNY25YaWRGcmRrejc0UUMycXpSRkhRWHZlMm9uNFdJMUs1aTJ3T2FC?=
 =?utf-8?B?ZTk2dkRDSnRtY21qTGo3QTdvdmMyWVcvckMrNnBCclQzZ1ZHWU5EUHJkTzR1?=
 =?utf-8?Q?E2SucIt91bq6s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDlZa29FRjBwWUZWQXZjMVI0UUNxREdhYm5JemVHZ1J4clh2RHZDK04zeGcz?=
 =?utf-8?B?UFFGcWlLaFVnc3ZkSDdGVGJrcTZIbXc4NjdhZC9WYloxNUJmREEvTVBFQ3cy?=
 =?utf-8?B?WmVoSDQyK0RMRzhNRWdacUh6U1Y2c05VM2ptV3ZlLzBIaTZhU2xFMC9oRFpl?=
 =?utf-8?B?dkhOdmJvWGpYOEJnVEcwL0dTUnZCdnNpM0VsT1BMZzUyV3F0MXBwK0d4Z0JW?=
 =?utf-8?B?UlZjdWh5WWtOZmkvVGdRNStETUhLUDB5L2JyakpOOE1TT1Naak1CTWJEb2Fx?=
 =?utf-8?B?bW1vK1VScFljZHR6TDgwS2daUSt6aVo5Nk9hMllKWWdPZEJxQnRBSFRsRWN0?=
 =?utf-8?B?M01LQ2dQMVB1STFmWUdzQ1c4WVhVZE1RNnFGRko0Nnp2Z0ZSend5c0NIMDZD?=
 =?utf-8?B?bERONXYrekx5Y1A2Y3h1YzVDb2lZaEVaMVlkU2ovaFM4aUY5ZlpQL1lsWDRk?=
 =?utf-8?B?dFFyZ0t3K3lTcTg3dkhzaGE3Y0tHUzI2U3ZTVEl5VkNSaURpQnBQbS85SUQv?=
 =?utf-8?B?WEtYMHAyKzkzWVNYVkNIQTdPWHVzbW80STRIRkxlRzBOUlM2RjVpUjN5Y2t4?=
 =?utf-8?B?UGNCTkdNcWRockdNZ3ZnMHZkcG1Ia2pQYWpmcDI2UEs3cTlHRnYxVHZHUWxw?=
 =?utf-8?B?MkYrY0tTYzRLUndQWW1xUFZoelpMZGhrQVdEcVQvRkh1RzhNQVlHeTBydzA4?=
 =?utf-8?B?NVpZZjhSY2ZzMUVGKzQvWjhidmhTOHdwOEZvZjZCVVdMTTU0VEg3a2JCREtQ?=
 =?utf-8?B?YVJXbWlhcTVqT2c4ZndDY0FhL015b1hxYXluTC9mNXVzZjhGUmdCT2QyS0ZV?=
 =?utf-8?B?eW94WlFDWVZWWUhVWThKdEx4aWNDR2xKb2Y5clRmRWgvMUdoY2hQWWZlMjRq?=
 =?utf-8?B?YUJpK2dVWE1iVTcySVZBdklaaytoVzFMbWFGUkIydWNhcmgwMnkzK3g4NWJM?=
 =?utf-8?B?WHpjc0RyVmpyTXdoa1pzanljM1dxbkxadmdtL09aeXIyTWRKSTFnTXRmWWEw?=
 =?utf-8?B?dGovNjczSlZ4TDV3Y0hlekt2UHNaYWRIa1JDY1RTV3NDVDI5ZDJiQnZ2dlBh?=
 =?utf-8?B?bWp6TkFHQzlZWHNZQXlpVHdFSmFIQThkelkxbllNK0NmSUVEa1ZYU0JEVUw4?=
 =?utf-8?B?bGloYnRSSHQ0blpxZk9pRytTZzlqUlhXL2JIalZEb2cvOG1ZWEhFVnFJS0Jo?=
 =?utf-8?B?Y3VaODkwSkc1bUJkMnZqODVEbGF6emZyMDBQb3FGSEpiMi9OK1J0RU94dW4v?=
 =?utf-8?B?aEttRGhwOCtEY3NJQ3R4dmJMSGJVdnpvNk1YeFRieFljWkR3d1NXYmZwNVI3?=
 =?utf-8?B?UERtMEI5aUoyNzd0UTYvUVFPYTU3Z0h5QWdJTzh4clp4NEduUS9MbDJpN3JW?=
 =?utf-8?B?SDdTYkw4cXhWSUxlNzZXM3NHTk5MNys0Sk5raTBJVXM3NjByWlVhMGJNRkxY?=
 =?utf-8?B?czRYRDh1Qm9zd2tTMnMrOGU3aWZWanFzamdGQ0g0RVQ1OUVnWUYvcU0veGVZ?=
 =?utf-8?B?UlVqNE5WNFVPL2VCTWdaNnlqdXhWQUJmaTBPSGFOQjRoNEVNdTdGeUwzSXhl?=
 =?utf-8?B?NWVNSkx6LzBvQjUzNUtCb3ZXYWhUaHIxNE1CVVVwZ1JYa1NkZE5vc0RFOWZV?=
 =?utf-8?B?c1c2R3BwbHFITzVKSkhwUUFGWnY2OWJIZXNDR0w1S3kzZkJtcGFuVVpaVDF6?=
 =?utf-8?B?TmJlWWkzSnpNM2ZGSmxHQUwwU3JoNzNSNE1uSGdWZXg1UVlYbzdBRy9BZWFq?=
 =?utf-8?B?d0gzVlJZWVVmQllQOGZtdFpTd2kzSFZvd05vNk1qT3FuSW9icjlpb0w5c1J4?=
 =?utf-8?B?aisrY0h1N3o3WUgwNFJRZzZsQ29rVXRKdzlkd3VFNnpIN0NyQ3NUZ3NTNGFi?=
 =?utf-8?B?cWRNaGpEVXBzZE1HMEpSZXhMOUZKeVlaeHhIN2tNc2hSWjcvcUNta3MxVWlp?=
 =?utf-8?B?OUJmdENqTkZMTXhaZGt3THNTNDZ4a1JaN1dnaUNxd3pnbCt0bDBqbkM5Q0hk?=
 =?utf-8?B?c3pnYmZhVXFlK0p3ODA0aXdiY2NpY3pMaENMRVdVbFhPTDE1U3BYRHRXNDBI?=
 =?utf-8?B?TFhHL3Q0RStSMzliSHFTRUxFWUEzK2Q2TU9WbVIrSzRXZUVsa1lHR3NEMCtY?=
 =?utf-8?Q?ipT7PH4IwAso06jw7+wZEiMy1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396d72bb-7e20-4437-62d7-08dd033a66b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:52:32.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSKQDXwhZhw41+feJrTRVRxqQ6BltWBXTOwUfLXiwxurcZvixmInyhbAtgFzsBVwkqeQ+4MOdQdZ3zeibPeTtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

Add temp-sensor nxp,p3t1085 for imx93-9x9-qsb boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v4
- none
---
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index 20ec5b3c21f42..36f2995acbe29 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -221,6 +221,11 @@ wm8962: audio-codec@1a {
 		>;
 	};
 
+	p3t1085: temperature-sensor@48 {
+		compatible = "nxp,p3t1085";
+		reg = <0x48>;
+	};
+
 	ptn5110: tcpc@50 {
 		compatible = "nxp,ptn5110", "tcpci";
 		reg = <0x50>;

-- 
2.34.1


