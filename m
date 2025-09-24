Return-Path: <linux-iio+bounces-24415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC4EB9A413
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 16:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7094C4188
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E83081BD;
	Wed, 24 Sep 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hy2yMkps"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FB64A8F;
	Wed, 24 Sep 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724233; cv=fail; b=m5xikQISYlOIeegD/Af1FaTOqRrXJclvOS2BamwArM72k9nUCu0HrsIXfitdAzvwqdVhqKZfPvt47MXMNGsLkii4aO9JusN5VyAPWPZD6N6zEggszc1w1amr+ci89YvEBl5t9VSpJgFBN6KvgCD86aYMmoESpCEbKtWL3OkaGj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724233; c=relaxed/simple;
	bh=mGVJS659wK9160cSVNdJWdGl9B2DwE4hJtduv1xkEm0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VyyLCqasm1wUJmhb8l0x/stQxPgBsjr4PCQutZgm8MU2vmLh2pgLT0bgi9xsDjYvnv7DStcxHlaS2GYSsIM7fX21yDsKQl+Qu71NoXl30iYEGcOsdbPDlLv+ksmBR9rZsE/oGCcj28yjCXYTlNFV0I3qkR7Gh13GyGH47tN6EGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hy2yMkps; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0CWpVmPe9lsIRXs+Pc7nwG6fITt/PtsWUATNs6qcs9DXi2XQIuYSBdLG5Ntx+XZgK5UPUtla22PrJQG3FuMk2NCxhz8RXOOKCATjsUWDAu1iw+BHsFWlW0FmJ6+7OzKIXD6a/QkCBnd8v94DAAVYy8HMOzqauJ0tXPJcyKPnW2/GVUXRmHlUD7LMOQ2F6XACNjrboLJCk8pm3lvhjUiUf43NA4D7dMaIl/11DlpYFpO0EjsNMJnQYSEQLubpmCn0P8cOCIY9R7/x4HGNpbe4rWXJmobOHs7nTOkESnoldiB0/MX9WVi1KiKz7ZH1gn9YC7sd3t1esZlBsBFECyPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z6mgzIjKqt+0BKgGXkrDBWw/Lh22xrK4HCubO0lQuM=;
 b=We8fSAqrWZaWDaX55DSQQgQOT/GKKNTH6tj2sNOhG8SBQA8NWKKLLYNETSvvwzIW3W+JXOhhC0FxYrR3hg+hzI+Y1fscLL3XDsz/3VD/8Scnq9OMa/ONsbj6ytsSPbfQohR4btRNpggvRiuD/lTrx4T2xXIWQISbyWRlUq1CTYU5e/lAeNTVGwa1vtV5s8XrA9jMHLCyCFpEa/zIIZb9WO5l7QqPmvqot8KCrDkRq9xX+ZcLjW0853nAK2Pfc8S46GpoUF2IKudAsJGC5c+t6bGHG5x7gDaRCbPzCbIkUdVVLRqTz5kodIOKygvYyKbIJz9zQorb28tH5qgR/+dF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z6mgzIjKqt+0BKgGXkrDBWw/Lh22xrK4HCubO0lQuM=;
 b=hy2yMkpsyTwwHTrazHdpzcpok7oQMR5FfPmZasUNTN8Etqj6z9QHg82aQ5GwbwHBsyR15pPHcjygWTn+n0lNr8hqfElWhmbkQ00Any6XGJ3JcM1ctPT4eSkJr9GO98+SigG+PWnBqrv8OMMaefbQ9Dr2kqH/S4SgsDL/mX3LMpPx/sKF6TMr0J7eLaW11h26M+/gfQiBeMXlSJRt6mvgfrbJPzrz12jtroxgOt9kuzOVcZdQoAK7vuf4SaXmwya3NlfH8d3gXczIMSN4iQ1cdnYIr578fuVVyiiO8Q+KWy1pvg/n7fOpisCkBhRg0oIkxHjsUSXH/yZZ2e9Gtog5hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI2PR04MB10192.eurprd04.prod.outlook.com (2603:10a6:800:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Wed, 24 Sep
 2025 14:30:27 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:30:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Sep 2025 10:30:05 -0400
Subject: [PATCH v2 4/4] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-i3c_ddr-v2-4-682a0eb32572@nxp.com>
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
In-Reply-To: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758724211; l=15984;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mGVJS659wK9160cSVNdJWdGl9B2DwE4hJtduv1xkEm0=;
 b=RIJ5xwUzaH51OCbtUQnckh3DqvFuFZCqi5tSCiwaMovIdmj2ENS8nBE7XzClzAce/bkL0mpt9
 CUCVlWcI/+CAfsnehDJcf24LPRNtkI+6mj4LPYzORdn8FeqNKQx5AgD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI2PR04MB10192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcc47de-6586-46ce-f02a-08ddfb76e7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RS9mZUxyQ0Y5V1FpMnN4Z2MzdVdBZHRVbE9Eckt2RWNHOWtCTThkUDNzOVhn?=
 =?utf-8?B?RXI1OTZzQ0FwOHJHWkFsc2FpSmd0bEk4STB2Q2J2MGNsUG8vRzhDRjhyNDkw?=
 =?utf-8?B?VzhpZ0ppYmJxeUtUUDZpa1lhL2hjRnpMUzV4TEowcjNWSFdLeTlScitNS1d6?=
 =?utf-8?B?L0ZEZUtvVkRNQUJwWDdJWnJsQWVLblVvdFF2UWZZWGRoZHJhem82OHdmd0NY?=
 =?utf-8?B?T1R1bnZNNmxpZlo5TDdDOWE2Q2ZuSXo2b2Z6NUlyeklBTHZxRklDcVkvL0l1?=
 =?utf-8?B?bHlNWERrQ2xxWDE4QzNKem5Yb2dGdE91bEJOblFhMk14MklyYjVoWTJUTkNK?=
 =?utf-8?B?djFYakplTTRHMWVmY21UYTl3ZlFJSWJBT3lWNTRYNE9CYUxiOGxjWjMxMWZw?=
 =?utf-8?B?aElRbUsrWldRT2JZQjQzTW1RV1RUSE8vSW1BS2kwQVJlQUtHMW53OFF4aERz?=
 =?utf-8?B?NFBSWmZDQWtMRDhhSGlqTnFNTlRJanZQNERlN1lTZ2ZyMG8vUHhCUDNGUldn?=
 =?utf-8?B?cHRSMzhZdGZLNVJjbVAvZStONmtJL3BrMXR6bkRJOWpSMk42blRjaHI3ZDM5?=
 =?utf-8?B?bTNSL2ZXbVpQZWkvQlRseG4zU2owSHZ5TVRJbjcyZVZnbWx0Yzg4MEI1UGla?=
 =?utf-8?B?REozNzRESjBzclFkdGM2T2VmcHZGQzJHTEx4RWh3MFFxb3lRRVNkZjR1ckQ1?=
 =?utf-8?B?WE9FZ2VZLzJFNkdtYjZrVHQzalBRS0I3clF2RzhnRFNpS2ovbWVOQnkvVDZz?=
 =?utf-8?B?dFVGSlhHZGw4c0VqLzgwTTh5K0MzcWFja2N6Sko3SnRFUE5qajFLcEJxVCsz?=
 =?utf-8?B?T2hFWVd6cVRtdzJ3U3FrYTl1cElTWGg3VE1TbTdKdGNrQzdHelNPUGJUWnJP?=
 =?utf-8?B?dk5va0htZE9tUVRhbmY1b3R6U05sMjFyaDA3NkxOM1hnMTFXTGM0cHZUWjBq?=
 =?utf-8?B?L2g0VmlEMHFTeEt2YmczblVGUjE1WHAzbmd3UW1LNVNES2lnemFpeHg0UmtW?=
 =?utf-8?B?dVVXVDVWR3pUMUhnYURpNnhMZ01SaGNIRnYzaitsUWhnVytmQ2R2bk1tSUh3?=
 =?utf-8?B?WERYcjR4UWxFVG1HSWR4bWluZVo5bGpSalRsK0M4SDZSYUs5QVgxWFRjdzJO?=
 =?utf-8?B?Unp0VVRPYkl4bnlQL1lqQXlLVGpIaGd4anA1aG5Jd0xGT3dXeTVoWXRzbHox?=
 =?utf-8?B?ckNScmxVbDIzbTg1RndDWGw2M1FwbEpQWkQvS043WXMyb3FvY0RIdDE4U3VE?=
 =?utf-8?B?Y05reTJLMmJUM0plZzdKbUZlTjJOUUVLY2hwakczaDY0TitHZTR0Qmpmc0M3?=
 =?utf-8?B?d3VKbzloSjNCVm8xQUorVXFLRkZCeHVUamxZOHc3YzRoVWx1UjVCaWZ0elRs?=
 =?utf-8?B?bWlMZER1TENBczBveTU1d2tTQ0tEb3kxZGh4MFNYcUZ3OTN5VXhpWm9FTWhm?=
 =?utf-8?B?MThWTTlwN0swalh2eDJlZE10RFU4VzJlemdRRjMzWXB1UjBZSmM1eG9GUitC?=
 =?utf-8?B?V3pNcEFBb1B2VndIQTkweHppaEl6cHJLSlJHeTNmMGQ3TkE3blZZV2xBU3hI?=
 =?utf-8?B?UHBPSXh2U3VUNWMrSXA5K0tUeHEzM212Y1pKY0FBMlNUSG8yYnRmTlBENXUx?=
 =?utf-8?B?ZGNMYitZUUJSK0VrN2R5Tm1FakV2dFFIVHYvNjVmUGZ6NGhXVVp0b0FTSEph?=
 =?utf-8?B?dmpMdEtxUkFrZS9MSnlCaDFRRmp5TGNCU2MrOXNoMXF2RFJnaG54dk1VRk5E?=
 =?utf-8?B?WG10VkoyRlRqTHBGSkMzNEFPbHMvR0pjdFFFK252UXJWaVJYaE93ZFBSMDV3?=
 =?utf-8?B?RFR4L21lcEtoRGpXa3BWU2VSbC9lb0VDbGpQTjdFbE1IOU9sMzd5WmJ3QWtJ?=
 =?utf-8?B?Zll5ZGlFN0V3QTN3cGlCdlZRRUxPSjAxMFVnNHdGTFBWdmRLRm1FVkVDK1M1?=
 =?utf-8?B?ZG94SCs4dlZnSThleUFkVi9ZamRrQ05uZEw0MU1LMkZ2TElQYVZKM2VhcGlh?=
 =?utf-8?B?TDc5NlFMRTVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ampjanpueUgwNlRwbFdPQlRFSnVxWCtmRGlyN1N6NVRtQkZwWWpWZDBEY0dk?=
 =?utf-8?B?SnZlbFpJcjVXYXI3RG56ZUFvaGxzYjg4NjVrUG9IRTJDUkFZOEdzb3crbnRy?=
 =?utf-8?B?dUlmOW5QaHVhZ3I3ZTNwRnZhZ0t3V0VhMEEwMm1yTXNHaUg4b3VtVk1ySytJ?=
 =?utf-8?B?OExFQ2dzRlBnRU52VDJ5aWs0bllma3lxZk04L1NQK3oyNjZEcXVFZG02ZU5v?=
 =?utf-8?B?ZFJkcXhucDJ5YXhHZEFmbHdoQ0ZhV0NpTUp6U2lBc09vbDVNNktHdlRWV0M3?=
 =?utf-8?B?SWlvMlJSQ1YwS3hRU2lZNE5IUFErQ1lFVXpqUmtTRnpiaU5OUmkyOE1SVVNU?=
 =?utf-8?B?RE4xRHorQS8rVWxaN05VTlV0OFNXT3NyUTJuVlJaV2pKOVkrbWpLWkhkOVVp?=
 =?utf-8?B?ZHBOdDFGamxwWCtmSmlIajZVblIxRFdsNDErSk8vN2R2dnI1VDNvV2JDNTlB?=
 =?utf-8?B?SEF6V2xCRElReUhtOVVDcDRVOEIwSEZ2YnlrOWpmMExSR3JLRVFhR1cwWlg3?=
 =?utf-8?B?MnhHR0ltaVhMVUYyK3l2MVpkRkMrWkNDaXNvOVFVWFY5ejYzbmZSbzYrcE9C?=
 =?utf-8?B?TSt0SG4vZjhBL05BQnNSWUNreXNDTTk4YktYMmk5bTBVMzlqVmNVaEViS3Nn?=
 =?utf-8?B?V0FhTXNHZmQzbmNHUE5pRWNOWW0vZVJKZ2ZVQkdkSEsvYTZMUmcvMmRPUzFW?=
 =?utf-8?B?cUJmNlZBbnl2NkVIbG1jbGVFZ3B1alBrcHpRWTBMQTROOHpsSmlTUHdZdU1U?=
 =?utf-8?B?Tnl0dWFZMWs2c1J0ZGxuZ2tJd2x1NGZRdGxOOG9Hc01qRC9QTHdWdCtVbDEw?=
 =?utf-8?B?Tnk0Vlhia0tQMnBDTGhBRkc0STVPU1VveTRmMTdlTmpOV1oydWVrNVdhNEZQ?=
 =?utf-8?B?S0Z2djYyUHNQUUdMOFJXNm43amR3N0pWbUpjbTg0OW93N0k0Z3U5REhhNUo1?=
 =?utf-8?B?QW9LcE9uK0lnY2h3aVQ2dDh5L0U3SkMzc2xmSEFkOElQYy9TT0p4U295QUZL?=
 =?utf-8?B?OStJM241Sm9RRUt3STNDaXNraGlJcjlibjJTTFJVZ2NERTBmWktrWWs0N0o4?=
 =?utf-8?B?WlZxc1hOclFHbVJMbk9KUE9qK1NqKzNZdVZhYUZrYlJyS1N1WW9PUEJzczho?=
 =?utf-8?B?N0M3ajZnSUIrR3FmUVZ6WTlSNHpWQzRZQTRrckljc3VWVkMyZTdtclgxanpG?=
 =?utf-8?B?Mm1DaCtnNm5uWnpHSlNsbmd6YUI1VTY0ZmlvS2lpSEc3RDhiaGpEOWVkRTI5?=
 =?utf-8?B?T2ZZSHEzemR1a0N4alBJblduMnZGTnY2bm1mVWN1d0VYKzhhRGsyZ2xSUk9T?=
 =?utf-8?B?OGNBcWw1Mko3Q0hWaXJQUVJyeDA4MjBIYlRneFFhc3VzK3hKK2o0T0hLZzRh?=
 =?utf-8?B?WnZRYUd2TWtlRDk2S0NqTUZnSW51SDRJV1JsdG15SDdHTkpxaXJzVFF4TVJm?=
 =?utf-8?B?OTgyazZqM1lTMnNGc3JxQmVaRDd0SmVkRFppV3VGYTJQSnNwNE1LT3duUHJQ?=
 =?utf-8?B?WXhMNWxmT3VyODErWXVZVHlHaGdBK3poU25ubHFseVBGUFA1ek1OT0g4V3Vz?=
 =?utf-8?B?Nlh4S0FCOGFhOTNidGlIMWJEQmY5ejR5cG1KaXc4SGFxWGovb2w4bTBPT25v?=
 =?utf-8?B?YVBXeUVBVkp4cTd4Y2I3ZGhjek50THl1NUlKVlpTa0tIUUNma0c4cklxMXpn?=
 =?utf-8?B?R3NSbXBtQ0ZtWGFyOGxpaFBsTkZTRndEbnRpcGsyQURETnhYNkVtczE4Um9E?=
 =?utf-8?B?STl3bWV0UGZ6Y2x3ZUFUekxMU0NBbWU4Y01SSDNMckJJd2QzR1hTakpTMG54?=
 =?utf-8?B?MUVrd3hUTEIwOVZyMUxHVFJGenZ1MVNwdVFNRXdNakFtS2Mwa0RIcUJ5ZlZw?=
 =?utf-8?B?ZEpCZHJEeU82RVlxR2FLVm5hRHVaWFVmalh4MXBpcWNLRXg5MEo2RmxOSEMy?=
 =?utf-8?B?d0VUUEd4dSt6UG1DMGFjM1RROFBrNUxMZUtUbDZxMVJJZVFBSU5peURReXVG?=
 =?utf-8?B?OEZoQm0vRUVvUFNzdjRvakgxZkg0cjM1YzltME8xN2pMN201K3pZaE04dXVT?=
 =?utf-8?B?MUVpMEtUZkE0N0xzanlHK0o0QXBXd0tnRTF1QXdOckZ3R3FrUmpJL2NRcC9S?=
 =?utf-8?Q?zzkJIKSqj04+SajbTYuPLU0ns?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcc47de-6586-46ce-f02a-08ddfb76e7b8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:30:27.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHB1ZWqExD9D6gPM8CuZzoZ5dXbpLd1ZCWT3tGsJaLjXMlEGOhgFUpBNUolWMF19OQoM1wQfC4GScPfwBMCSZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10192

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- new patch
---
 drivers/iio/magnetometer/Kconfig   |  12 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5633.c | 543 +++++++++++++++++++++++++++++++++++++
 3 files changed, 556 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -139,6 +139,18 @@ config MMC35240
 	  To compile this driver as a module, choose M here: the module
 	  will be called mmc35240.
 
+config MMC5633
+	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
+	select REGMAP_I2C
+	select REGMAP_I3C
+	depends on I2C || I3C
+	help
+	  Say yes here to build support for the MEMSIC MMC5633 3-axis
+	  magnetic sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mmc5633
+
 config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index dfe970fcacb8664b293af84893f7d3e3e8d7bf7e..5bd227f8c1204bdd8b8a43da180833eedca1457b 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
+obj-$(CONFIG_MMC5633)	+= mmc5633.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
 st_magn-y := st_magn_core.o
diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
new file mode 100644
index 0000000000000000000000000000000000000000..b1a6973ea175634bbc2247ff84488ea5393eba0e
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5633 - MEMSIC 3-axis Magnetic Sensor
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ * Copyright (c) 2025, NXP
+ *
+ * IIO driver for MMC5633, base on mmc35240.c
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
+#define MMC5633_REG_XOUT_L	0x00
+#define MMC5633_REG_XOUT_H	0x01
+#define MMC5633_REG_YOUT_L	0x02
+#define MMC5633_REG_YOUT_H	0x03
+#define MMC5633_REG_ZOUT_L	0x04
+#define MMC5633_REG_ZOUT_H	0x05
+#define MMC5633_REG_XOUT_2	0x06
+#define MMC5633_REG_YOUT_2	0x07
+#define MMC5633_REG_ZOUT_2	0x08
+
+#define MMC5633_REG_STATUS1	0x18
+#define MMC5633_REG_STATUS0	0x19
+#define MMC5633_REG_CTRL0	0x1b
+#define MMC5633_REG_CTRL1	0x1c
+#define MMC5633_REG_CTRL2	0x1d
+
+#define MMC5633_REG_ID		0x39
+
+#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
+
+#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
+#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
+#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
+#define MMC5633_CTRL0_RESET		BIT(4)
+#define MMC5633_CTRL0_SET		BIT(3)
+#define MMC5633_CTRL0_MEAS_T		BIT(1)
+#define MMC5633_CTRL0_MEAS_M		BIT(0)
+
+#define MMC5633_CTRL1_BW0_BIT		BIT(0)
+#define MMC5633_CTRL1_BW1_BIT		BIT(1)
+
+#define MMC5633_CTRL1_BW_MASK		(MMC5633_CTRL1_BW0_BIT | \
+					 MMC5633_CTRL1_BW1_BIT)
+
+#define MMC5633_WAIT_CHARGE_PUMP	50000	/* us */
+#define MMC5633_WAIT_SET_RESET		1000	/* us */
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0X05
+#define MMC5633_HDR_CTRL0_RESET		0x07
+
+enum mmc5633_axis {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+};
+
+struct mmc5633_data {
+	struct device *dev;
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+	struct regmap *regmap;
+};
+
+static const struct {
+	int val;
+	int val2;
+} mmc5633_samp_freq[] = { {1, 200000},
+			  {2, 0},
+			  {3, 500000},
+			  {6, 600000},
+			};
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1.2 2.0 3.5 6.6");
+
+#define MMC5633_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				    BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5633_channels[] = {
+	MMC5633_CHANNEL(X),
+	MMC5633_CHANNEL(Y),
+	MMC5633_CHANNEL(Z),
+};
+
+static struct attribute *mmc5633_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mmc5633_attribute_group = {
+	.attrs = mmc5633_attributes,
+};
+
+static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
+				       int val, int val2)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
+		if (mmc5633_samp_freq[i].val == val &&
+		    mmc5633_samp_freq[i].val2 == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5633_hw_set(struct mmc5633_data *data, bool set)
+{
+	u8 coil_bit;
+
+	if (set)
+		coil_bit = MMC5633_CTRL0_SET;
+	else
+		coil_bit = MMC5633_CTRL0_RESET;
+
+	return regmap_write(data->regmap, MMC5633_REG_CTRL0, coil_bit);
+}
+
+static int mmc5633_init(struct mmc5633_data *data)
+{
+	unsigned int reg_id, ret;
+
+	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret,
+				     "Error reading product id\n");
+
+	/*
+	 * make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET
+	 */
+	ret = mmc5633_hw_set(data, true);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(MMC5633_WAIT_SET_RESET, MMC5633_WAIT_SET_RESET + 1);
+
+	ret = mmc5633_hw_set(data, false);
+	if (ret < 0)
+		return ret;
+
+	/* set default sampling frequency */
+	ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+				 MMC5633_CTRL1_BW_MASK,
+				 FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mmc5633_take_measurement(struct mmc5633_data *data)
+{
+	unsigned int reg_status;
+	int ret;
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_MEAS_M);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & MMC5633_STATUS1_MEAS_M_DONE_BIT,
+				       10000, 10000 * 100);
+
+	if (ret) {
+		dev_err(data->dev, "data not ready\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mmc5633_read_measurement(struct mmc5633_data *data, void *buf, size_t sz)
+{
+	__le16 data_word;
+	__le16 status;
+	int ret, val;
+
+	if (data->i3cdev &&
+	    (i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR))) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = &data_word,
+			}
+		};
+
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = &status,
+			},
+		};
+
+		struct i3c_xfer xfers_rd_data_cmd[] = {
+			{
+				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
+				.len = sz,
+				.data.in = buf,
+			},
+		};
+
+		data_word = cpu_to_le16(MMC5633_HDR_CTRL0_MEAS_M << 8);
+
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val ||
+					(le16_to_cpu(status) & MMC5633_STATUS1_MEAS_M_DONE_BIT),
+					10000, 10000 * 100, 0,
+					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
+
+		if (ret || val) {
+			dev_err(data->dev, "data not ready\n");
+			return -EIO;
+		}
+
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
+	}
+
+	/* Fallback to use SDR/I2C mode */
+	ret = mmc5633_take_measurement(data);
+	if (ret < 0)
+		return ret;
+
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
+}
+
+static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
+{
+	/*
+	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
+	 */
+	*val = buf[2 * index];
+	*val <<= 8;
+
+	*val |= buf[2 * index + 1];
+	*val <<= 8;
+
+	*val |= buf[index + 6];
+
+	*val >>= 4;
+
+	return 0;
+}
+
+#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */
+
+static int mmc5633_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	char buf[MMC5633_ALL_SIZE];
+	unsigned int reg;
+	int ret, i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->mutex) {
+			ret = mmc5633_read_measurement(data, buf, MMC5633_ALL_SIZE);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = mmc5633_get_raw(data, chan->address, buf, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 62500;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
+			if (ret < 0)
+				return ret;
+		}
+
+		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
+		if (i < 0 || i >= ARRAY_SIZE(mmc5633_samp_freq))
+			return -EINVAL;
+
+		*val = mmc5633_samp_freq[i].val;
+		*val2 = mmc5633_samp_freq[i].val2;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		i = mmc5633_get_samp_freq_index(data, val, val2);
+		if (i < 0)
+			return -EINVAL;
+
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+						 MMC5633_CTRL1_BW_MASK,
+						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
+			if (ret)
+				return ret;
+		};
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5633_info = {
+	.read_raw	= mmc5633_read_raw,
+	.write_raw	= mmc5633_write_raw,
+	.attrs		= &mmc5633_attribute_group,
+};
+
+static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_XOUT_L:
+	case MMC5633_REG_XOUT_H:
+	case MMC5633_REG_YOUT_L:
+	case MMC5633_REG_YOUT_H:
+	case MMC5633_REG_ZOUT_L:
+	case MMC5633_REG_ZOUT_H:
+	case MMC5633_REG_XOUT_2:
+	case MMC5633_REG_YOUT_2:
+	case MMC5633_REG_ZOUT_2:
+	case MMC5633_REG_STATUS1:
+	case MMC5633_REG_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct reg_default mmc5633_reg_defaults[] = {
+	{ MMC5633_REG_CTRL0,  0x00 },
+	{ MMC5633_REG_CTRL1,  0x00 },
+};
+
+static const struct regmap_config mmc5633_regmap_config = {
+	.name = "mmc5633_regmap",
+
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = MMC5633_REG_ID,
+	.cache_type = REGCACHE_FLAT,
+
+	.writeable_reg = mmc5633_is_writeable_reg,
+	.readable_reg = mmc5633_is_readable_reg,
+	.volatile_reg = mmc5633_is_volatile_reg,
+
+	.reg_defaults = mmc5633_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
+};
+
+static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
+				char *name, struct i3c_device *i3cdev)
+{
+	struct mmc5633_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = regmap;
+	data->i3cdev = i3cdev;
+	data->dev = dev;
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &mmc5633_info;
+	indio_dev->name = name;
+	indio_dev->channels = mmc5633_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = mmc5633_init(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int mmc5633_suspend(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+
+	regcache_cache_only(data->regmap, true);
+
+	return 0;
+}
+
+static int mmc5633_resume(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	regcache_mark_dirty(data->regmap);
+	ret = regcache_sync_region(data->regmap, MMC5633_REG_CTRL0,
+				   MMC5633_REG_CTRL1);
+	if (ret < 0)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(data->regmap, false);
+
+	return 0;
+}
+
+static int mmc5633_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return mmc5633_common_probe(dev, regmap, client->name, NULL);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend,
+				mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5633", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5633_of_match);
+
+static const struct i2c_device_id mmc5633_i2c_id[] = {
+	{ "mmc5633" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
+
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
+		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
+	},
+	.probe	  = mmc5633_i2c_probe,
+	.id_table       = mmc5633_i2c_id,
+};
+
+static const struct i3c_device_id mmc5633_i3c_ids[] = {
+	I3C_DEVICE(0x0251, 0x0000, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(i3c, mmc5633_i3c_ids);
+
+static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
+}
+
+static struct i3c_driver mmc5633_i3c_driver = {
+	.driver = {
+		.name = "mmc5633_i3c",
+	},
+	.probe = mmc5633_i3c_probe,
+	.id_table = mmc5633_i3c_ids,
+};
+
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


