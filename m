Return-Path: <linux-iio+bounces-24411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0BB9A3F8
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2229C3A96E7
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519C3305946;
	Wed, 24 Sep 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ELhaPlm0"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7415C0;
	Wed, 24 Sep 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724222; cv=fail; b=dmj/zLedcXzpoNcY2LHI3ZG51zs3kziBL9S3JnbJ9quQtRli8+8V6Iw0+3psEPc0iSBOgiEnmZOEs7OEOsaFOtsbDq8yfOlztbA2b6pScaGi16aBQxnkMupJwC90hgcC4czTL4Dfjok5T86diq5Vk6TKO6NUjAkpColDXmKwQAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724222; c=relaxed/simple;
	bh=x+vfteEN20fSvs+vx5KAROlZV0aVBG9w6WPcN+FXNEc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BEPLKXjMcMK5Ky4gEIXsQhuyZYFP8u5wWUgJLTEIXcYbNrUFX7ujVSvOsMAmg4MNOGRxvBJSrMFtP+4DOYgocZ+a+8uZcDygvUdY1IcEPFYRZAb7GQz0ogUcHDAPYJJhS5kmdKJqNfv7tiDZ32VDSqtaysdPmckSl68NLWAPd5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ELhaPlm0; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTFS5bV+wDH6PXUOapboVQjs9GSLGOQNZeO9z1cgIhoGtKGLKpU+4yoCixzAo7iYO9+kK1gWzrPp2nOHaKskMiZ5j57sFruGEFACChUDhyfp460NDJz+lDL4vDBXyGC+8HRvN0wZbc9VzlOHEXsOAaDWpwTjTkwbGNVV2rTjytUQKM3qg9uKuxcMv/Um0jHz7OJlC7PytegJ9W+TkFtS8Gh+zY8A8CiVxhPoum7HhXuBEe6nTSTZ7Mer1CaBHpcfRZovKU7xRMTDD/vVc0+B9dKkU5Jmj4wWFDQaHyVJXPEGCiTc6pqD64edgwBEaNcYzrR8zGOLn4lmF2L7AHTCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f6aD6PzPV539hc/RaLhyOQDvCWNGWs3WKloaVtp7gA=;
 b=SWVumQJgXRAGL1ku/36VPwaNATqbtx6J6TeNgE5nEzW13Gl0uiKlgB3LhHHtSOhuUrrdwl8jqygoQ3hEWv6TioTlT7sutRwY/dpHTinK/ARhHqCVJg+pLb47FwTFq1gjivANyjik+9va3N6WnY4dxkfxZteeuNiCOBp5LssMPKctkHY0xOohejoPG8uqxVAnu3tVdu2duW4m6EclMs3Fp0ifCbUM8UkIcBxIrYCrJBrBjTnnobrYR3ZAWrahuSwpjcE2uHchwIKrCR19+P2gaBYKYgZCJ4U186BY/qDi0LrCG3oY6pf+vj5ZDu/OG6sLljFsmBZ2qpCxxsCgnHvFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f6aD6PzPV539hc/RaLhyOQDvCWNGWs3WKloaVtp7gA=;
 b=ELhaPlm0Qp5Efj6p8JIM4nvZxndiLkZsdtGMIxGACTbFHRiDColfMEYGN3Dfp6mZOLIeD+M7YBuPS1SmTJykOSTAOcQrIkpNHWUvuV8XKOQEY0vSPeFxitEg0Bq1HUVMxUWDKlHTpa7oCnbfQ9ZqEwZtVxKfcbg45cBUdGa8k/+n12odS+zJ6ygFl2hGlOEIR2XOoK0vZMfGUEBk89TGdRZCjrApVdPNSi/pOVCJKubh9TrQ2E+wOJ5a8GehqHkfziS8/sMXfFpl56JOKQt12UGYWMBRQAEyG6LeaKwjpggEQ1Sv/Nz2+UIgg7Mi8aWLzBfNAnO+qMOwVdI4R0WIdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DBBPR04MB7818.eurprd04.prod.outlook.com (2603:10a6:10:1f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:30:14 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:30:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] i3c: Add basic HDR mode support
Date: Wed, 24 Sep 2025 10:30:01 -0400
Message-Id: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkA1GgC/2XMQQ7CIBCF4as0sxYDFCJ11XuYxlAY7SyEBgypa
 bi72K3L/+Xl2yFjIsxw7XZIWChTDC3kqQO32PBERr41SC41F3Jg1Lu794nNQitjBi5wNtDea8I
 HbYd0m1ovlN8xfQ64iN/6bxTBOOPS2IvVXvVSjWFbzy6+YKq1fgEAecR4nAAAAA==
X-Change-ID: 20250129-i3c_ddr-b15488901eb8
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758724211; l=1949;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=x+vfteEN20fSvs+vx5KAROlZV0aVBG9w6WPcN+FXNEc=;
 b=BMgN2nnKklgbjy7me7ySVb6Er+lmjk5op0UjsLiATYLuMSLDOfNKGY/nvSI4qoIln5NEx/c85
 vfSvWA0ia8TA/yK9ezm9ci3OyBGNmdb7ihiakArOxV94JpGFK5KJ0wQ
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DBBPR04MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 946d0887-81af-4d2f-bf95-08ddfb76e05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3o0eU1ialBQVisrd1lKQkNwdDJPOHR4eC90UGpLTHhrcm5PSTE1YWFZU0Nh?=
 =?utf-8?B?d005ZHFpUWtOeTJYVUxlOTRFV25LeTlFbVVGSkZUK3JXV1NEOU9hcVYvaTJ1?=
 =?utf-8?B?NXhZNmtxMzh6ai9VblIxNEwyOXd2T1U4L2NCN0JmZUhPTCthTnRyTHhYa1hy?=
 =?utf-8?B?S3ZPZWFVRzZyQW95WlZOdVQyZmVNQk5NRXo3UnUyRHptUlROYThRcXdRRDkr?=
 =?utf-8?B?K1BLb0I0VERmUHNCQjE3TXJMTnJWc3pIVjB3ZTQrODVaWjhnY0g2Q3FWZmhQ?=
 =?utf-8?B?ZWx0b25pS2ZQQlBGRVVCQjdpS0xwMzNGMlIySWNvOEljT2JDc0w1RWR2cVRu?=
 =?utf-8?B?VnF0dkJobURXd0NnYTVlVXhQdUh4b3hBOGJ1SUFMQXIwYXVCQ0RoWjdjNDhp?=
 =?utf-8?B?R3E2Z2hjY1YzdExDNThYTGdrU3hjN05tRW9mdHpHMHBOWWNQUGdPSlZjVng0?=
 =?utf-8?B?bkJJTTkzRXlmS0tPQXBFNG0yTDYrbzI4T3ZFa3dJZkxlSUpvbjJkOVFiWUxH?=
 =?utf-8?B?UTBuRUdWU3Jpb2xxK0NNQU5MRXBYL0RUakEvSmRVSjVyQXhGV0c5cnRTbXNR?=
 =?utf-8?B?Nk00U1RtTm9TTUx5bDkvSHlLdXdrTUF3UTVBak82QTdRS2toRERnZkF4NTJX?=
 =?utf-8?B?STMwUVVpTXpvV2ROV0dwSWh0YWEzZ2RwSlNzcm1rMWIvSmlHK3ZMMUhia05M?=
 =?utf-8?B?dWpUcUszcHFzSVpuNkJkSEkzQm9qL3B2NVVXNUY4eEdxUWRTbDhBbHFLbEsy?=
 =?utf-8?B?WVE4MTYvdk5jMTFjVDhPWjdENHg3cXp6Z0Uzd1ZKNjYxRTZZc2pvUVllZTFT?=
 =?utf-8?B?OTdvNkhOTVFqOGRYMnFmMHQxbDFhYzR1UzJBVGJ6L25jQWlpdkJUSmJHdGlx?=
 =?utf-8?B?WCtJWS9MdW1HV2xyMVJwRmNpRXNzMjBkVHNYTFh0Tjhrb1B5NGtDWExQVlJJ?=
 =?utf-8?B?YW5OMFVDSUlaZ1BEdjIxOWNTbEFnUElGcGFMVlcwLzBISVRIUGI0NEprOTNn?=
 =?utf-8?B?K2ZVWk1LU2VieGFqdFF4RGk5aXpaTjVFSXhiS3lRMk51MmZYcUc1MCt2d0hr?=
 =?utf-8?B?NXZScVBLZ1B4Nm4vbHkxa2UrdHh3T2tCZTIzcEtFd0tsdjk2Z1pDTkN1K2dw?=
 =?utf-8?B?VkloNGRRMy9YQmV0VlI0Q3BHV2cwVTV1Q29vcTg5V0ZhMW1lREtkajZvdFdo?=
 =?utf-8?B?WWVmemRMVjhzWFp4VC8yUjNuZ2kzWWQ2aEJlU1pCcDZEdlZJaitMNnFuWDdy?=
 =?utf-8?B?eExCZDBNMUlubldrb200cG95ZnFUbC9vQkpad2lFL3gzbG80RG5MWWJwajU2?=
 =?utf-8?B?SURLRVlHR1FPYlBaZmpsb2dVNXZHWWUzQmswSSt0ZEYvSUd4aDlQcWxYUXps?=
 =?utf-8?B?OFBGbUhKVFZHdWdnSE9KeFhSZUIvRm0weWR5VlBYY1ZvR2hkRktxR2lzNkJk?=
 =?utf-8?B?WkJ3NVdpRWtFaFhpZ0daaU1UdTdaT2NUQmtzSEdKQWNnOTl4RTRCTTE1bWhv?=
 =?utf-8?B?VzlMbjRiQzhuaWpmRXNTbXpuWlR2VURaY21PL0dUYlFsaHJDN09Da20zeFRz?=
 =?utf-8?B?ZlloZ3ZYVWhNZTRPWGEvVUhjMzIvRHY2NzBLRElsbGdKdXFuNURGOHpDaEZO?=
 =?utf-8?B?NllXb1hFYXVmNXpxT2N4QVM1MnhLTzVlRGJ2OG9kQlNhcE0wUmQxOFdpQks2?=
 =?utf-8?B?MkxIekRkMXJFZUpZZFFIMFpva0FwM2ZRam1TZkRyV2NMVEgzNUFBMVcyS3VH?=
 =?utf-8?B?TGhNRDhYNEdxdkZqVk9kc2ZtRFVKUGFvOVVaWjJsS3FYWWt4V2lrYzIrRC9M?=
 =?utf-8?B?Y0pJbC9wSVVCV3JhN3hKRzlKR1NxeGUzOG9jSlg4ekN3cjZ6RlBzYU0xa1J2?=
 =?utf-8?B?eDlBZXlOWlk2aXQ5cVhHbjhEK2REaTN4dGVmNzhzT0cyMlU4aVBGazVyWTZz?=
 =?utf-8?Q?9tRLAAHPNRI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajZ2aTJKb3hyb3hmTkxZQTVKQnVzbFU1SHlxTnRaQ3V6bVFhRGlmb2EydUo4?=
 =?utf-8?B?Mkxuek41VTljdTlLMWQwQS9LRUdNRjRFZW9YVTdoM2Z0cmhFZEZJajVUZnZs?=
 =?utf-8?B?amI4OHpPT0E1RjFhNHY0RVBxZ2lLNzRURzJvcWMxUHpqcTRNNUtnUDdUZVNE?=
 =?utf-8?B?VWZtZ1RKZTZGVXJZRzRvdXdxRW5xNUhKbE1adTNCb0JZZG0xVXEza0xIMU4v?=
 =?utf-8?B?dk9zeEd5ZzAvUk0yNjNNeSsyLzhwTjRLUHZ0VHlPejVvRjNzUnJlTjVLSito?=
 =?utf-8?B?NHE0L2Nuak15NkRmOVdRQ0JnOE1FNFBOUXZaSVlVWmpUU1VUb3duOFExOFBz?=
 =?utf-8?B?T0hMQ1R6YVRnb1QwWTV6SjZnVzBlZ0F3WHlPL0g1Z2N5RDBTVkZ5SC9GN3J1?=
 =?utf-8?B?ZndWeStJcmdzUXJyaHNTZllRV3NCZVpQQmcxRjV2bG02WERmOUswQ3hrSXY0?=
 =?utf-8?B?emcwd2NYRjhOb014M3JhSFk1YjJ2a002YklYc0VzQngvdWVzWWlOb0ZiZE1T?=
 =?utf-8?B?R3ZsZU9DU0g4OTFDUG1zTVJjU2ZSV1dlTEVkWlJtMzFuZFBrbVRXY3F0WEpK?=
 =?utf-8?B?VmMxZURkaVc3U0NGMnVkTEl3bEdLRGJTWEZwVnRNdEszaWxyRlJ3blBXY3p2?=
 =?utf-8?B?ZHp0QjlYSFN0M0MyY2VXa0lvK0NNNFg4emFNdjlLdjFLenlHa1BKNVJWaEVt?=
 =?utf-8?B?VkdXbmJ3c0FjTktiRG1Ka1BsY0NXdXhVZ1FpOG1mcUdnMG5LeDF3S3owaktw?=
 =?utf-8?B?aDV0eENmb1VvamdNblJ4bDlPU3VkZGgzRDQ5TVRySC9NSEFtdjYxVFZLcnRV?=
 =?utf-8?B?RXQ5RmNjdnQ0eTI2KzNVY0p6TDl1Y3FnOU4yWmFwS3Bna01GdGRqaW1GU0dI?=
 =?utf-8?B?dk9EUHJ2a1pUUENqanlPKzF6T1ppaS9uL2xCamJHMTRYVENERlh3Sm5Xb21L?=
 =?utf-8?B?UndOQzRZRU9OMzJBM25KL2tESGFCYXVVYVBSSzYzdlI1dVdJL1RkQXc0VVZl?=
 =?utf-8?B?bmZoVThCRk5TNjVpQnJPaTljMXhWZElEWHJHSFdleVFXLzZNYzFYWktCSlgw?=
 =?utf-8?B?QStPMEplK0VYdzBhb2txQm9RSE44Sk0zMlZhY1p0eDJyc2dJRzZzUUhhbGlW?=
 =?utf-8?B?c2VORytNQ28wRU10SkFXanNPSWFwTlF6TnhPanJXRERJWXpSZEZXQUVKdTB1?=
 =?utf-8?B?YTc2a2FROE9SY0JsVkVmamZFREprN05EdmlDZnpvSUFrS0JHYzhNbGg1dDRm?=
 =?utf-8?B?akpQZ1RMVHBIaFNvdUdLYkRkdk1iTmE5dllBcFhNbmh1Nkk4VTBjSTJhbjFI?=
 =?utf-8?B?ZGt4Y0w2aVFmSWpXODZQZW56Z2xTcjFwMW11UEFUbnRRNjBXYTEwc0FFNDg1?=
 =?utf-8?B?bjdQV0p6bHREL3k3ZDF5Y1A5RWxTdmd1OWNLUGtSN1VEZndYK05HMllLTDRM?=
 =?utf-8?B?dStjY0Z2dEYyTFdKT1JSMmhOWklPUE5uM2JYblI0YllxZXErUGR2Q2ppejBF?=
 =?utf-8?B?Q25RcEpGRXgya0RtR28xKzgyVWlDVS90REFtNzFyYmRaOE9OR0FmNDlLTUJH?=
 =?utf-8?B?TnR5amk4L0NQZU1HOVR4S2NTWFBJNm4zY3NlODhtOWNCaHp0OTlzUWtMdUxP?=
 =?utf-8?B?ekhUUzh3Nmo5eS9hck03b0RLbFJQVXpaMWNtbFlJUkFHSWFaaFBlV3dOdTBX?=
 =?utf-8?B?bVA4NzVRSGk5cEVTYS9xMmljSzZYWWdhVTBOU3IxM1lhNHpoRU1rVnVrQjZw?=
 =?utf-8?B?bnp2VWUzc3UweXB3WUcxRnVwVWtaK2lvL1FKRjNxdE1oVHZPYzZHOTEwdFUw?=
 =?utf-8?B?akZKOVAxOWNNUlZtZjlTUXQweERTcVJJLzVuS2ZaT21xSEZCYnVpc2w2aVg4?=
 =?utf-8?B?RDBZaStOMmVjZWhra2NVV3dHbVhWSDl3S2oxV0N1QjZqT2lLVWRwSU5ZVTJ0?=
 =?utf-8?B?eUZPc2tKMjU5Vkc3V2RuTDI0TU45TzhwMDhJeGRySldIOENGMHlzN1NhZ3Bh?=
 =?utf-8?B?VUNZRVVmMXJaUmZXVjFXVHdHNld2THp3MVQ5MFdVR0pITUJGeEhjOWNIK1ZB?=
 =?utf-8?B?WU9WZERTT0kvaFdISlJBSDBIdVFCSHpkdFd1Uk5LdlBhQytkSkttY2hNb0dt?=
 =?utf-8?Q?0Ti9+ifAVK+P4uHRbNdQQiPe6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946d0887-81af-4d2f-bf95-08ddfb76e05c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:30:14.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jVNST1FvxoUHRV2KXzKPn5a7cXc86pi9+z8WAPTsxCxNh+M5pdlKZRK7WWK4EKZozDh1Pw1xSpBUYgUy0DAiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7818

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
Changes in v2:
- Add sensor driver, which use HDR mode read/write data.
- change priv_xfer to i3c_xfer.
- Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com

---
Frank Li (4):
      i3c: Add HDR API support
      i3c: master: svc: Add basic HDR mode support
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 drivers/i3c/device.c                               |  27 +-
 drivers/i3c/internals.h                            |   6 +-
 drivers/i3c/master.c                               |  22 +-
 drivers/i3c/master/svc-i3c-master.c                |  95 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 543 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  28 +-
 include/linux/i3c/master.h                         |   5 +
 10 files changed, 702 insertions(+), 39 deletions(-)
---
base-commit: 5248ab97a6dd1dc6856422f6b1595baaf4fa85ce
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


