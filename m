Return-Path: <linux-iio+bounces-25586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8163C15468
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D10422CA8
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275333A00C;
	Tue, 28 Oct 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkFFf4Of"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CF3328E5;
	Tue, 28 Oct 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662966; cv=fail; b=ICWc7WEbKl6osXW1sg7QLkNgQRP4SgE0033meEG7WB4sd8kfD7jQWo0un4AQiRZZ/M80r5itP6e7/StbZ3RStpviMTuXqCaDAfLKmlBp3w5glVmWAdLOrWs6pVzGwAECmKnyQWTH48L6IAczQJ1zRN8hEr/uEGDDC6t31Mqh7MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662966; c=relaxed/simple;
	bh=5vasvYWn6j296foC0KD1do8HEXNE6j61yOhJlnouXFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=er3J2IBa//huCyoEDlzhgfdhiD8kMM3Q0sRiehPG1mGuc2hw3bzU2+rAEMwxjSG2M94CJHDdxopdl0QCCAYa4oJ7uEnyOVPievTq/cpKAz45UVQk36WqfZkiiOalgznsfT5hW+JIPhkreenAaFrR3c16KC5mGvjIUiLigtW35DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GkFFf4Of; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUXx4/K8jaisqa+56eiPtNKzB/sCY2V/0ZCFSw8KxiCdxBR53t4JwCP9OueYmRPSyR0L0c4RDWQSTeZUXIvmkcY8Eds4/+r/+9rIPLAj8XhogMKeva4FF78qpTLapcB7n4NAIoAz2gJ3r2w+By02FoWtEG+rPcHOVOzlqU80XONZkxShadk5QI9q4F3wCwJJqiKLpbl32Ko4lim8d48oBe/OMWdeAvYdCV5SgwCW+4MLvhsLNMpUZNj/TSirIHmm5YM3dWVZtWwzfylaaDU2to3X1B7A19XHkOysqzbCwwlQnqjylIdOz+OQwOn2v80ipYHKetywy0MSITRZ8DcyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XbezMuE/5oIEAd1wLivMnBG/K28HshgVytpSww3aDU=;
 b=XVOfLNcpT539xoPc3wDVmEHYtbj2YLU7j7VimtLNJWci2oLnrnOD9rc0ib5NFk+lgb3DAlU8FGLnI/mFBxe6FOGfYHNPCEEMP67wGFNvPrQE5t2alhPLtMKBOQKwmYjKUF+jrU7OGjs+sI3Uq/g3pHu8/LOdC6KFpyqF1VVFlNnmgeLrRwPLRr7xjACmaEILuz5PVAq3MRvtKql2w3+0jlPqxKXpI+o2/4mEZasNc3I/yechNsl5OcllEyprW6MMjMEOY8KvWxRuMmkyJgkHfeLifql2cIgtK6P8hxRZuBx+xPOaU3XhdG3HbWfY7/ylt78WDp9pqXHijxYnJ03HJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XbezMuE/5oIEAd1wLivMnBG/K28HshgVytpSww3aDU=;
 b=GkFFf4Of26y9SCEQk6AR72+iEahjrVmxJ9TE6zUlJwZmrjOnbR3wrLJIexRwABS6VHWaMR0WZO59oGRzFn2lH1c4alXuLmfnB1rJK+/dynBqMV/a2+5Fn75+F6bybemdbTXqUVlmBssAY7wqF5Asv5hLasAhFPOW/HcKxuffZRgGAT8s5rCaZQaO8YtFfbLxLf6se6pZGwWKsUB5TZCptEb9U0a+QgNxlF8TAIloMoxCPEIU38V4lAftaqFPPQWH3hD4gBZZB4VSyFSY+eQKS/wpaRcvqIJC9uDBVoOSqaVvz5ej1+Ka8F4xe9sXgmxN8yzMWp0PQwwNKl/2Jz0VRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:49:23 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:49:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:48:58 -0400
Subject: [PATCH v8 2/6] i3c: Switch to use new i3c_xfer from i3c_priv_xfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-i3c_ddr-v8-2-795ded2db8c2@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761662950; l=1345;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5vasvYWn6j296foC0KD1do8HEXNE6j61yOhJlnouXFY=;
 b=6sJzsRIU3EE7+5jCtDy80neafNsIHquWsn5bLI3GCsvaRkuxcFQnNVo6kk8oDIRsLxasS6Sem
 60tq3yujRkHAILmXBgSJjkQNE6FGG8UfHgwHGCdzzaqe58BhGKMQIK3
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
X-MS-Office365-Filtering-Correlation-Id: 22b54418-0816-4b1e-3f99-08de16312f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0d5bkxGb1pQSTdWYk9pWVpHTEs0dEp3Sk55SGNGMy9WWjB3QysvdWk1ZlRu?=
 =?utf-8?B?UUExek4xdGxlZmUzbjdjMkUvQnFZd3dUVXNQdWhDSW81N2lpV093ZDhFQ283?=
 =?utf-8?B?NXl2dm02b1lnazVrNzlieXdqcks3Z3pSaHRTMm1jaW1wTXlmcWQvL3JCT0lR?=
 =?utf-8?B?TDNndlpTcEhwdEVlYUlaV1AwT0ZZMTVmeVRQSC93aFdQQVZKbmtxNHM5NGVZ?=
 =?utf-8?B?RlY4dHlUN3NLWWN0ZUlYVnRHTGc4WjFvd0N4NGloT2w4bUtJTDQydEY1NFcx?=
 =?utf-8?B?NDFkQmtRV0pGVnB6MmpFQTJlOHl5NS82RFRKaVNNc3UxQW1HS2FxM2J5UWly?=
 =?utf-8?B?MjRMSjBDd2xtc2NHbEovN3pvOUYxWFZrNGhNM3B0TDB2U3ZZcWMzdUNCcDh5?=
 =?utf-8?B?dkxKcThTMFp0Z2lkdW8xOVNtTGVmUjlkTFBXTk0zTDFXNEM2OW8yQWZPcFpj?=
 =?utf-8?B?WENDd2Jrcm9zbHgxRmROQm43UmNnRzRndjV1L0V0NmwxbUNmZ08xSXFPVDdv?=
 =?utf-8?B?aDRLRHVpRGFSVGJLemJ3Tm5xZDAyUzBYM0QyUUhXbzEyeG5RSHB2SHg4a1g3?=
 =?utf-8?B?YkQ3bUlxL0tuQW1hNzJiZ2x1V29nSldPRzFEaE5kK0E1Vy92am5tc1YwVDZG?=
 =?utf-8?B?Q3l3ejBUcExBelY1WnRUYklBTXFMNXg4ZW5PbjFQcW8xdDYyZnpZTU1vcUtj?=
 =?utf-8?B?d0dFYlBxRlRjUEoyN3NoSFFSRTFvbUNCM2NBVURLTHBUQTFkOXh5WGdweXIx?=
 =?utf-8?B?L1ZHdDd2cTF2bUh6T0l5V2tVWVNDbUFabmtZQ3ltZ1RqTGVsQTU4djV3blRi?=
 =?utf-8?B?UkFXQXF4dE9JZERGbStCdjFPNlJLenErTjFOM1NKSFFTYk41NkxFS29EVEFq?=
 =?utf-8?B?ZDFPdWlWOWcxZ0tIRldkdlVQNDVvUWV4SmJJMUExa0pSWngxSmhhL3JBNmxx?=
 =?utf-8?B?bklDYjBTcHRRaUxCcWZ4b3dQQXhHVXQveEpEU3dKVWdOeEFvNGVDWFFaM2J0?=
 =?utf-8?B?MXMwK2djT3g2Tm5ZYXVjS1EvQ0JJRC81TXhoRGNxUzViU2xDRmtnQ0VyZjkz?=
 =?utf-8?B?S2dOYmZPSFZsZHh5amdmYStEMnRVYXBUOUxvbkFXUVpVbXU3L1pGSDA4K3Zh?=
 =?utf-8?B?b1BKWjlzSmNRV2NYSmxJc1p3aTMzQnZKUFVXUHBFdXA1WDB5b2YxemhGVWpt?=
 =?utf-8?B?bjZrS0F0M2xsUjNGYjdBN3lZbTM1WjQ5c2hhbjBWSytPQUE3cU1KdlhySGxT?=
 =?utf-8?B?WjUzQzNGb3Jyak9zUk8zVG80WkxZL0xoNHlEMXVZcWNuc04valBnVkpndTdZ?=
 =?utf-8?B?OTNGRE9XMkxicGtuOWNMMjdRZWJIL1ZrYkNhWkhUMEYvdERFNEdrNzN6OVVr?=
 =?utf-8?B?bTBkYStBQndxVkcvTUhlQnJOeG5Mb1hlZFNEeEhjUXdoaDNGT3hHSUFPTEYw?=
 =?utf-8?B?cERoem9wMUdMQjZ0bEVORi9mL0JMZVhxbnpvdmRhei9vNUlRY0lDNzVKbncr?=
 =?utf-8?B?TW15UWZzRmQ4a2Vzc1FySWRLKzlpQndzUi9HMUZydE9ITUZjenpxUEk4WXI1?=
 =?utf-8?B?NHhYdXloYzZrOTNKQWthbTVrZlpEUjF0ZmNzR2hoMGhjYTc1UEg0SklyU2kz?=
 =?utf-8?B?bXJCUFlReGFYN2hvWENhUkZ5emVyYVROYU40Sm15aTR3MHhTQW1PMkhxTi8z?=
 =?utf-8?B?ZXEvYmhnWlY0N1ZjL2VPQWhzbmFjQno3R3A4M0gyN1FZdDFtYjFTeUpnV0ZJ?=
 =?utf-8?B?TFJ4bXF4R0Rod0JFQ3gwNk8vdXVIWlBZaWVoY1lrNDRhejVpSWtHYVVhd044?=
 =?utf-8?B?dzNtZmVQbnpaQUx2ZFFXUTQrRnFqcmQ2d1dtMkllS3hLNEE4K0ZYMjVuTU1S?=
 =?utf-8?B?QnE5bzJ2aFdUMENMKzRyT29xUU9nRm92ZHRVMzlNNk1LZ3d0QkllQ0tzSXFT?=
 =?utf-8?B?MXhzR0I4TDdBTkJROUtaWFRhMGJYdEsrTkNpYW9WVkc5YlpwQ1NDajZBZWhJ?=
 =?utf-8?B?ZENyV1VDL1BkU0R4T3FTYUNpTkc4NVAvQW91NWFxWlhLNTlaZVZLc0hBamtJ?=
 =?utf-8?Q?+uQHYc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHNFN3BPZHdKdGxGMlVIaS9nM1NLRzNIMVU5NmlBZlhqQnVSWWNYWk1nQ0ZH?=
 =?utf-8?B?UWx1RGYxY3cwNVpwcEVpamJNL2FGbDZOM1pjeHdUWjBwWXBVN1p1N3VmNXV4?=
 =?utf-8?B?dVpzdnZZdTE5Vk9QSHU0YmxYRnZ6NHBkM0p2aUxqUklNYXpoeHBuVjM5dWVG?=
 =?utf-8?B?azQvd0poY1AwaS9Ba0Y4S0h1a0tTRTB0UlpmdlE4U0F5U2lUWWVXVEtpUitu?=
 =?utf-8?B?SWJaTC92WjhzL3RkRnFzWmlMQVNpem40QWJUOFVIaU4wcmtib2E5dlMwWHh0?=
 =?utf-8?B?Zzd2SjcrOWJvaWhtSmJuN241dytCUU9WcEhGWnRoUVRnVEVFOXdTM1pSYXZw?=
 =?utf-8?B?aS9ldDZQQUdZdmR5WVQzSEk2NTNCUHJiSzM4WllLT2l4bXJoTXFMY2tpc25Q?=
 =?utf-8?B?M3kveUFrQkZ3ZUxRM2syU0pObjV2ZVplY2VaY2NWbm9ZRnYxZGtlZkh4Rlpy?=
 =?utf-8?B?TDd5Nm10bjVNSlBITkxuRkNoeUFqd0JCZGsyVHlmSVFHenlRM2UrdU12MDdV?=
 =?utf-8?B?dWRGeVlXVFFCbCtVTzFqc1RoOXR4VStSdm9sdHRQY3BYTVRnVHFVZCtSMkxF?=
 =?utf-8?B?SzV1SEp6bTM3RHdsZ1AxMHRKZURCRG9CRzV6aUI4VmxZNkNLazZaVyt4OGZK?=
 =?utf-8?B?YzVNUzBrR0s0RERBNnBqa2pWajRkT2FwdHhiMkpzQ3FGbHVkc3d6NU51MkNt?=
 =?utf-8?B?Nzk1d0ZtMjVORWtmVWthcWNDU1NsVENsSFFISm13QWc0RFZ6VU8xUEN6OUFi?=
 =?utf-8?B?aGo1YnRBYU1SRzRCempaNTBId3FXV2lYWno4UmdqS0ErVnU1Ynh4Q2xvdWR6?=
 =?utf-8?B?aTFmSlRIZXJEOWJ4cDAwbVkvQlQ0blAzRjczVjVSSEtYK2RvY2NlaGQveGhh?=
 =?utf-8?B?OGtia0l2UVl2MWJEVU1TVjZXbWJpYXR2eTBlODZUa1AyWm5OMVo4QlJTTk13?=
 =?utf-8?B?UEVpK0lZeUEyYVFpQ1RRb2NMUHdhUXJWTGhtRVk4VVJqeUZWWGpPZmFHQmJU?=
 =?utf-8?B?Uy9IVXNieHZJY3Nua3pJak1ydGhFaThJMW4ra2JiWkNoTWg0VnBSZUdNMElh?=
 =?utf-8?B?d1JPYVJ5VDV2TlYrclFUSzRqUlYwT2RtaER4SkFNSnlhNWZkRkcxeUNVbU41?=
 =?utf-8?B?Q3Q0dE1taC9hZG1LbzI2Z1l0ZlJoczQvSlVuKzY2TUNFZWFjWVF6Y2ZPTE5a?=
 =?utf-8?B?c3IwaC9zLzAxRk5UYmhybkxlams3V3c2STZ6TVZ4cTZoSEx0MzFzUDhFMWt1?=
 =?utf-8?B?VVd4eXZoSnpHT1pkVDZSRVBlaWgwVXNMSWJHYVdrL3dzTmhFUURyRzNTdi9j?=
 =?utf-8?B?d1pBM1N1L1diWW1WSmVxNFladER1Q3hZaXQvK1ArRU5EYWNBcUtsS3ZlVzMy?=
 =?utf-8?B?ZUEwRjVHSXdpQnhpeWpqRUhxTUhja3F4TDJjWVdlVHpvelJGYi8rZWJ1UEVF?=
 =?utf-8?B?cjh2cktObTNFY0d4ckNZdGdCVmhHWXZIQ0dDMzVlenhENi9JbzI2SmN0T3Zn?=
 =?utf-8?B?UnFxbndHdGx2cHlGR1VjZGZqRjRlMUtKek5oQStwNGRTWURRNDVRMXduaHV5?=
 =?utf-8?B?cG1QcWtrM3lsWStPaHlBSkYxK1lveDhId0RraG1RQWZTNHc3Zmo0emV2QWxP?=
 =?utf-8?B?WnA1UGczWmNSYjhTSXhsYXpTWnhnVU11MmcxSGo5bjhPOWtySTNaYlVHeEMz?=
 =?utf-8?B?Q0lncWVQM2NIRlJKMS9ZRDNEWGVyU0U1UmkwWFU1VlZXYnh5a0EzUU0xNXFT?=
 =?utf-8?B?ZVFIcUx2c2VxdmdxRmhSVHdjZGxJNkJTRmlERlVJS3hwUDBwclVUYWtldWFy?=
 =?utf-8?B?UnJBMWZINXN1RmdvREJLeXhIR0dVUVBYOVNueitnRnd6U2FtTitkNjIwbXVu?=
 =?utf-8?B?YnVMbWlPWFJ6RnhvaVZJYlR3U2pONU90bFBOWlNYNGFmemVTVmVaTHRYc0Ur?=
 =?utf-8?B?RldWMzBPTmNkNlp0blR1dXBYYXliSDJJM0lqalRoMWw4ZitQRDJ3VjJ5ckw4?=
 =?utf-8?B?Y0dEMDFORFNpbWY4T2hBT2gvSDRhYWUyZEIzYjFic2dteWNwVEwyYUxhVjM2?=
 =?utf-8?B?Njg4T2hIQUVPQWJ0Qy82MzFKT29yQUMwVGhHaDIxRlhadnRvNFdQQ1U3V3ha?=
 =?utf-8?Q?YXugUzNXKMp/DcDva3FVWjrou?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b54418-0816-4b1e-3f99-08de16312f06
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:49:23.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw+dArvzKbinFU6eK2Dfq2ZMCbH1vcJhe/xuUs1gm1mC0Zn4BT3BbR3WvOqCL7aPSjsQCMW0qZiv+h56Vus9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

Switch to use i3c_xfer instead of i3c_priv_xfer because framework update to
support HDR mode. i3c_priv_xfer is now an alias of i3c_xfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v8
- new patch
---
 include/linux/i3c/device.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f7738041f3809e538816e94f90b99e58eb806f9..ae0662d9d77eb3fa0c976de1803e9c2ff9547451 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -27,7 +27,7 @@
  * These are the standard error codes as defined by the I3C specification.
  * When -EIO is returned by the i3c_device_do_priv_xfers() or
  * i3c_device_send_hdr_cmds() one can check the error code in
- * &struct_i3c_priv_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
+ * &struct_i3c_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
  * what went wrong.
  *
  */
@@ -312,7 +312,7 @@ int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
 			int nxfers, enum i3c_xfer_mode mode);
 
 static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
-					   struct i3c_priv_xfer *xfers,
+					   struct i3c_xfer *xfers,
 					   int nxfers)
 {
 	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);

-- 
2.34.1


