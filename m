Return-Path: <linux-iio+bounces-24412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCB7B9A3FE
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B3C17E31D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB634307AD7;
	Wed, 24 Sep 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DE9HGDrB"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B664A8F;
	Wed, 24 Sep 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724223; cv=fail; b=maOzUY+WHgTRj/ErJFzBBJ+U+2eeobNVARlzWpx4qCTHxqTyyNQmvFfeeHktbGLCWv5ZtPPM3IZOVU1SNZ/w0NayJoX1U5YEelf9num66t0yCq+35xj5PbvVjqaNKcCAf1q2YynmGbxk9fWUtEOHkaA2EhfflAEsiScSKM0Xgrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724223; c=relaxed/simple;
	bh=xHn1w2w/R6DiF5At3PU9+7/x+R4x1YAwB7xQObmupF0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OfBWVNHlmB044o/Au7nEGA9kcECqxjQx8p3bYuM1L2CGhvNy31LOBD2KArYYIe5QBo9HqowwUnD4xYocFkePFeL+usI3ahcRs2skZwJNDu67vsEGFjL9dN3q8ESzV0lsTIaKnDU0OMZmhysIWN5qzM40zHHId7FKo5A9L/mWD+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DE9HGDrB; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRsa6pPZ/bkaOWkGfPq9wuDpSn0q5eFR1SEEDCsj8hiKQkLsPF8XpXFiYxjQpt8Dzg6f2AmStdahCZiGiUJzWfsHoOGEmtCFHX3lgupLyODdSnVhOEKpbpKsVJOJ5h0H7hThjpUAJJ14+k8QN+fIYpLfhqNEalMILPNvAVKwZdjMvt6r6/pQsgGfIzc8OR2HMcbsX+Wh1c/6MvWA3MrwzLnf2p+6QXw/SLnakZxYyEhfs/zDMEnbA9965KoTYwBab6pLXE0M/nMgFqiyFRCjNsVoq6L5znXDjUghTy09WeU/BZePngSc8Dfr204mOM93Sco8Vys2V4pFMv6pfOOCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUFTncXjS9e6+w4rCFFXvOpMU9oWTa4EiiGIbJ4vl0w=;
 b=ibgtotEZOF7zFM2Fzt7kI8aQiRSeyLeU7zw9JyR2+RS9ug1iyl3rYY+tVq/7mVNA19kN5u9YZm5OAo/cJ7zEWASJ2wMxTiBwLwEjdZxuxywFfHIa2NcSPCLF0FEldbTphypsebH9xr1oGXAjFxy2bAu8S5a0SZ46EIE8BfSsBMyKNTJfRbGRVAhRgt2DJ1XEi+SUnQH4InarwI+ziQBw1eIq065upUL32c8G4e1JtTH9xaCOX6bSxlQE1UCNkS/buqaPoJfu/eOSKj7izYA2Bmdh1KdE4nKauUXFgW7nCHi5O5QAj3mIhQlL4EdA+USifAHH/UrnqH7y82LARZ+vTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUFTncXjS9e6+w4rCFFXvOpMU9oWTa4EiiGIbJ4vl0w=;
 b=DE9HGDrBBWBk0n2EsK1wK3HqWSFv3d91/l6JSEF6+hjoFnJ2laOpo3VUMDrs+uKqJzCYNLQkjivW7M+KiEVbwXCEh6hxPd+oppsRBONmLWRq7y4fRqgqJvFJI3n3mDM8CfMdhkoLzJRH2LO8CCFUvQvBEQGP6e5hxPcGJh9KXF/V0hCDv7hTsAWtDLwuIYeSi9e62f3Fl+i40g8qyKt00L7OgTHsS2W/aoIiMH1Oz/ceeAMmeMj5ya3GC+2PVQX2MTnumY06Q2E/IJ6h8U+uhzcdhrqsL9t71WvdF37iUM3Vx1NfmgqdwlfunXvWiDMgTDWC1BhbzGJ7NnArZ4PHLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AMDPR04MB11299.eurprd04.prod.outlook.com (2603:10a6:20b:6cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:30:18 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:30:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Sep 2025 10:30:02 -0400
Subject: [PATCH v2 1/4] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-i3c_ddr-v2-1-682a0eb32572@nxp.com>
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
In-Reply-To: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758724211; l=10567;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xHn1w2w/R6DiF5At3PU9+7/x+R4x1YAwB7xQObmupF0=;
 b=JIr2vOS79FSRFY+uZ7yXKt8tICYbCdDEt7tbMq3TsIs6nhLIGNOJ+YQK6+FwYkwMYlAmfPYtZ
 0l6oqRCadrtATGyWUYoJoaKpHQG08gNcomzwJEAoX08hBeplto+NTkg
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AMDPR04MB11299:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c8eaac-119c-4183-ba93-08ddfb76e215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3pTMktZSVJwL3ZPMVIrL0lRMzdheFpNT1hSMkhnTW5LTVVvd1FTTFlHUmpD?=
 =?utf-8?B?aUxUNDFFQU1Md1BxcjZZZzVCNEYxUFhGYXlqMTl2TFUxeHJkb0dZRjNJMEV1?=
 =?utf-8?B?UEY4UVZ6enVlRUdQOWtKa0JVM0VjVjRDTFdpcW81TElmemdjVmlXdmFqT0ZK?=
 =?utf-8?B?SDU1SEJxZUN4RW9pY0JyUUxjK0FUWEZGK004VlV4RG00bDJxRTc5MmFnRjBP?=
 =?utf-8?B?cXdnVU9RUXhhZGlHMkNkclZnRmd0M1VjMUtFdk5weENiR2VJRWt4OTZ5Tkpk?=
 =?utf-8?B?UG4xd1FUZnRNL1JpVTBFamxZeUtTUlViY2N3aHVaQVlQV3BUcVZBaFhoUGRp?=
 =?utf-8?B?MitxWXEyRXkwaU81MGJ1Y21SUVpGYW1UWmZDNmtRbnNoc3NTRCtXMTQ5UFc1?=
 =?utf-8?B?YURwaGg4OXMrYWhmbnpiWkhrOUNTamVOWlVKc0FRMFViMTFJNFRPMTZhV1RK?=
 =?utf-8?B?WHliUlRaZ0xjVTU2RXZoalVFT0xmR1JpS2dhR1VXdEhEZ25oTjNqVEVZeHdR?=
 =?utf-8?B?TWtaVkM4enZwZ1l1ZHN0RE9DSjhrbk1RQ2ROTWJHWjg4R1NUS05aMDVLcGpE?=
 =?utf-8?B?aTlzRTBtVHQxQkZ4aHE0ejdwQkhvWXBoSHNnaUpWOG5scW9SSExwcUU0OEJn?=
 =?utf-8?B?VktqZEJyM0NQaHNGdFVrL094blNwNDFiYmhzSFVzWE9UbWZvZXU1MzdkOUVL?=
 =?utf-8?B?NklOdGU4UWp0N3loeFB3VmQvRkJaN2wwTEtqV0c2azhkT2Z0RHFSMzJzb3di?=
 =?utf-8?B?d3hmMnllaDNoNlByVEtkMEhwSStkWm1IYmlZZmFnSWhzeXRzVnhNdXloa2lm?=
 =?utf-8?B?U3BCaklabVJoUUNZcG4wR2FjbTdGMERYUEpsZm1VR2pNNTEvUit4OWhQV0pZ?=
 =?utf-8?B?cFJBM0hSOFQvNEtoZjVrelBDK3pzblg0V1FFKy9lTDN0TEw4Z0F0ajlZalNP?=
 =?utf-8?B?VUM2WS9xQm1lY2NFeWZhY3orK1V5TW9xTkR0aXFLRzErczl6cWR5N2Q2Q2lv?=
 =?utf-8?B?Y0VkN2RnMUdxMzZKN0EzSk1ua1VNODQ2d25YT3ZqTHRTQ2UvZ1l4cmF0TEJx?=
 =?utf-8?B?c3lLN3FNWklvV09hNXhkNmhyeUFOZlV3SmlXWTNMb0JNWVQxYlFyWlhKMk5w?=
 =?utf-8?B?c3p6UzRlTUd2Nlk4ektpeGFTdEkyVEhmNS9oa3gwMDRCdFVpTjB6aFU1MWMz?=
 =?utf-8?B?NmxPTDBtNVRTWG5CcUZsQ1JNM0UvR2VBV1pLbW5rVHNxQnAxdHFHcklBOFRu?=
 =?utf-8?B?RDF1V2J0V04yVmxkMzh3aVh6TFQ1QnE4OVBPOFJOQ2xVdjFibDBYMGRHclB3?=
 =?utf-8?B?YzBXZkRXN2kwQzNaNjRtd0hNOGNRdTEvNzNtWmJMYk85RFZGcDg2c2lCK2Zy?=
 =?utf-8?B?Q0VWS0p4TzM5VnIveVI5TExzU3lWYVNvcTdKTUwxVmkzYTcxTGhyYlpha29Z?=
 =?utf-8?B?RnE5REFCdkVGWXluT1hQY2RXejZIdmVSRzNuVUhISXZSRTZaMytLM3pqaEla?=
 =?utf-8?B?NmZXa3d1dWdUK3E5QkIwTDFzcFVRNUJBOElvNEZLMTN2NVpCSjdSQUswNEdm?=
 =?utf-8?B?dDg3djU3M3VyelFXVHJMWkh0SENGOEZNb3JHZWpFVTF2SU5zTXp2RkZ1N1VF?=
 =?utf-8?B?NU9RRkN5Q0w1WFNjTmg4RlA1a1kwT2w1emFKS3pGSnJieGVlc0hzZk9qKzY2?=
 =?utf-8?B?S0xiMFNJM1IxMnVtdTNxay9pSnNzVCs4eFM1TFFtZkxUM2syVFlEaTE0WDRQ?=
 =?utf-8?B?TkFheXBTdlRMS09hQ3Q1TSsvRExOc2cya29OOThhZjFBeFBaNlpLbVRxWVJz?=
 =?utf-8?B?RHlCZWpqSFNuNmxueG4yT2t2bllaUytZeXEyeDFzVHNMT05HYk9waVJnSm03?=
 =?utf-8?B?Q25UTStXcFY3aUs0OUdsTGxVa0NoK003cDhEZklFcWxOUUl3UzVTSmN5YTRr?=
 =?utf-8?B?QTdzTTVCOVU1WUlqdk1vMjVBL04zS0JEakNCRmQ4NHJaVTBYTWswdU1hZ20x?=
 =?utf-8?B?c29IMmYvZllnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXdoeHNnWjNObi9IeGIrd0ZneDFEV0lRR1NhVHpRUWc0TDdydVdHR013YUZI?=
 =?utf-8?B?Z1RUSFNqTDFRemx6a0RiUlA5TE4xdU53R1lRTG9qZDgrVWVsODBHejl0UWRY?=
 =?utf-8?B?T3BTSFIvNWRDblJYMkp2cUVHV214bG9Bb296S2M0SHFmTWU2VjVBSjhkN1dU?=
 =?utf-8?B?aTA1ei9FYUllazZ5c0t5azJNRDRFUG42ZDlzRmtNUUZxVUVUSE5kQkkwR1c1?=
 =?utf-8?B?ak1UV1JxU01SMTNTN1NPOElJZnAwMkUweTV2TXVqcFJaZ2JjTDRacTh6ZS9S?=
 =?utf-8?B?eXlGSjN5b3ArYXM4WmVOTCtwTEhSdDEwRVE3L004MkFFcE1qYm4vQlJSZEFi?=
 =?utf-8?B?bW95Mk5JODlOVHN6aENNcGgrVkhRN2ZGZGNxNklDeXFJUFp3b1FUNEs1dklM?=
 =?utf-8?B?SVdXSVJBQkpQNFpReXJRbzYzUXQ5WWNhZ3J5Y1NlaGl1STFpUklWVXhtOEZH?=
 =?utf-8?B?aXdnSDVWekFRb1FSVHZPSlNFYVdFUFZ5Q1NNTlRHY3ZwaStXeXh1SEl0V1JD?=
 =?utf-8?B?R0J6R0hMVVgrSFJPbnJXRmpDVm11dlVvTERnbFRsTVgvUitKT012bFBqdEov?=
 =?utf-8?B?NUd4TFNFV1hwV29oSEtJTlFDRGI1WHA2MkdaMjhGSitPdUU4T1IyK2lMczNT?=
 =?utf-8?B?RzJpSDhKNzl0ZXlWTnVWVnN5Tm40S3pHdVd0OVNmak14bnVINzcxOHlocldt?=
 =?utf-8?B?d2hGb1FPMXZqK0RHT2R0ZmlHWTF0cjlTNzh5VmRpeldLYzhQb3RUSW5IQ3ky?=
 =?utf-8?B?L3pPVkxJcFR3UmVvQzZwUVQ0enp0OWR3Qk9hYmZjYSszbjRRWEZHOUxtNVgx?=
 =?utf-8?B?aTJIcUZUWWRMNnk2eFF6ZlF4SWtiKzdLWGI2SW1qd2pUMWZiQTN5S293b21U?=
 =?utf-8?B?OFRyV3RSMnArZklMRGszUWFmU1hqVVB0SjU4RVI3bE9wK3owTDlsc0V6eGZp?=
 =?utf-8?B?RG43S2U4Mkw3MFNNMVFITFE3NEMvT1htUWczZ2lVZGVIYjkvV2VsazdDbTRH?=
 =?utf-8?B?OW10VmFQU2hrazRVcTVzQmFyOTdnVkZQMmdZUEpTaTVQcEFabFoxb1NZVmJH?=
 =?utf-8?B?YTQ3QmZFa1JIK0E5TkVFb1dRbzJ5VlJFdW5Sdm1Dc1hWb2RFTUxwMTZkT1lL?=
 =?utf-8?B?Lzh6c3EvWlpnQmxkeEJ5SEx1cXJOeFExUC9oaTFDcWZQdmNiTHVYdEs0cW5S?=
 =?utf-8?B?Q1VmTHRwekNMNU5JZldTTTRwMnJwQjh6dktocmdmVmhIWlc1aHBFTTJpM1hM?=
 =?utf-8?B?aEZXeW9yVW1MaTdodXM3M2UyeTlVekpLTExFR3dFNlN2OWltS3VSQTY2SXND?=
 =?utf-8?B?Z0ZSRjNWMEduRnpyc2wxMlVEMGZ4Z3E4bDV3ZDRWZ3J1bFZWbkROOU9YR2dN?=
 =?utf-8?B?KzVoWEhqTUhvTzZqSDdiNjZKNWZ3Q1o1d09maStPNm9ubWxKamdKMGhOZ2xD?=
 =?utf-8?B?R25wU3VHcWlOSzMyS1Q0OXVVTzZKeW1ESTVtZmtyV0IyTmVDTzBOeCsvUmZU?=
 =?utf-8?B?bWlsQUIwbWk3cWtpbENxOU5JYWswVmt1bm82cHVjclI3YXVQQnkrdlM0QXN3?=
 =?utf-8?B?Y3drR2VsK3FRTjdhbkplZStNODBjNWErR2p6QnE4QStUa1owdTB6bnFCMjZ0?=
 =?utf-8?B?WWpNZEY4bXpubEt1cFdtSTA2WW9GcGdhNUJvMmtsUm9XSDE2YTl4b1VhSlA2?=
 =?utf-8?B?SWV4Q2RMTUtGOElNTU9PNXU2SjVFcHJBTEViMWtpK1RPbHZTdWtReTZRVUJI?=
 =?utf-8?B?a2xMclhRb3dDSWovOHlkdSs4OVh2T2ZnWnhnSXJpMDkzV1E4OHRKaFlhSVlE?=
 =?utf-8?B?ZUkyaVVQeWlpZjN5Tk02TlgyZXBJVG02bTZrNzBIK3RTaHZjdGNZYmJWUU5n?=
 =?utf-8?B?UnZwRUVPTzV3dUtMYk5EUmdwaUx4YmtHRkZxSEp6enVuaWt3MEFZb1FaVE13?=
 =?utf-8?B?bko2RGdHYTRvMXNaaGVrQ1Q1cW1hR2o2SjJLWTd5YmhQN1dVMHJrUDFwRkNO?=
 =?utf-8?B?a3ZGaWN0enJHZGpNdC9Vd1MzQjRWUXdZUkllZ2JSaktyUldEaTBVaFpKOGRM?=
 =?utf-8?B?ZWlwbng5ZVJTKzUvdjBLWksycjZrcm9JcDVUbC9uSzBDc3NHeTJkWnBwSU5z?=
 =?utf-8?Q?9mVPSiXVxQZpwzb3YQ0/YWz6N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c8eaac-119c-4183-ba93-08ddfb76e215
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:30:17.5976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7RWWxUxqKt4HKnlB/KCDZxSJ/vQIVietUm2CCI3nKCLTeRir1+y7es+z34380zLrnlBjfl5tm1uEhuJGrMWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11299

Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
Technical Overview.

i3c_xfer will be used for both SDR and HDR.

Add i3c_device_do_xfers() with an HDR mode argument, while keeping
i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
with I3C_SDR for backward compatibility.

Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
'rnw', since HDR mode uses read/write commands instead of the SDR address
bit.

Add .i3c_xfers() callback for master controllers. If not implemented, fall
back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
all controllers switch to .i3c_xfers().

Add 'mode_mask' bitmask to advertise controller capability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed in
one i3c transfer. for example, can't send a HDR follow one SDR between
START and STOP.

i3c_priv_xfer should be treat as whole i3c transactions. If user want send
HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
instead put into a big i3c_priv_xfer[n].

change in v2
- don't use 'priv_' since it is refer to sdr mode transfer in spec.
- add 'mode_mask' indicate controller's capibility.
- add helper function to check master's supported transfer mode.
---
 drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
 drivers/i3c/internals.h    |  6 +++---
 drivers/i3c/master.c       | 22 ++++++++++++++++++----
 include/linux/i3c/device.h | 28 ++++++++++++++++++++++------
 include/linux/i3c/master.h |  5 +++++
 5 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 2396545763ff853097d9f0173787e087f7a6e688..00706b47758bc164178a5578a018b36c5c433f5f 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -15,12 +15,12 @@
 #include "internals.h"
 
 /**
- * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
- *				specific device
+ * i3c_device_do_xfers() - do I3C transfers directed to a specific device
  *
  * @dev: device with which the transfers should be done
  * @xfers: array of transfers
  * @nxfers: number of transfers
+ * @mode: transfer mode
  *
  * Initiate one or several private SDR transfers with @dev.
  *
@@ -33,9 +33,8 @@
  *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Section:
  *   5.1.2.2.3.
  */
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers)
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
+			int nxfers, enum i3c_hdr_mode mode)
 {
 	int ret, i;
 
@@ -48,12 +47,12 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 	}
 
 	i3c_bus_normaluse_lock(dev->bus);
-	ret = i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
+	ret = i3c_dev_do_xfers_locked(dev->desc, xfers, nxfers, mode);
 	i3c_bus_normaluse_unlock(dev->bus);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+EXPORT_SYMBOL_GPL(i3c_device_do_xfers);
 
 /**
  * i3c_device_do_setdasa() - do I3C dynamic address assignement with
@@ -260,6 +259,20 @@ i3c_device_match_id(struct i3c_device *i3cdev,
 }
 EXPORT_SYMBOL_GPL(i3c_device_match_id);
 
+/**
+ * i3c_device_get_supported_xfer_mode - Returns the supported transfer mode by
+ *					connected master controller.
+ * @dev: I3C device
+ *
+ * Return: a bit mask, which supported transfer mode, bit position is defined at
+ *	   enum i3c_hdr_mode
+ */
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
+{
+	return i3c_dev_get_master(dev->desc)->mode_mask;
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0d857cc68cc5d473db733b12ffcec0c1c28d9def..2adba9136f3d147b82c58bd9b491d6d1bc6bfdf7 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -15,9 +15,9 @@ void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
 int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev);
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers);
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev,
+			    struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_hdr_mode mode);
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 2ef898a8fd8065032b68c97c52dcb12e771525a4..1ba21fd737a31386704e47afb3026c4fc8fc7305 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2749,10 +2749,13 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -2808,6 +2811,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 	master->dev.release = i3c_masterdev_release;
 	master->ops = ops;
 	master->secondary = secondary;
+	/* Spec require must support SDR mode */
+	master->mode_mask |= BIT(I3C_SDR);
+
 	INIT_LIST_HEAD(&master->boardinfo.i2c);
 	INIT_LIST_HEAD(&master->boardinfo.i3c);
 
@@ -2942,9 +2948,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_hdr_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -2955,9 +2960,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master || !xfers)
 		return -EINVAL;
 
+	if (!(master->mode_mask & BIT(mode)))
+		return -EOPNOTSUPP;
+
+	if (master->ops->i3c_xfers)
+		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
+
 	if (!master->ops->priv_xfers)
 		return -EOPNOTSUPP;
 
+	if (mode != I3C_SDR)
+		return -EINVAL;
+
 	return master->ops->priv_xfers(dev, xfers, nxfers);
 }
 
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..be7d9e4c98e09ec29357d19dc73d1f050d7bde1e 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -40,19 +40,22 @@ enum i3c_error_code {
 
 /**
  * enum i3c_hdr_mode - HDR mode ids
+ * @I3C_SDR: SDR mode (NOT HDR mode)
  * @I3C_HDR_DDR: DDR mode
  * @I3C_HDR_TSP: TSP mode
  * @I3C_HDR_TSL: TSL mode
  */
 enum i3c_hdr_mode {
+	I3C_SDR,
 	I3C_HDR_DDR,
 	I3C_HDR_TSP,
 	I3C_HDR_TSL,
 };
 
 /**
- * struct i3c_priv_xfer - I3C SDR private transfer
+ * struct i3c_xfer - I3C data transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
  * @len: transfer length in bytes of the transfer
  * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
@@ -60,8 +63,11 @@ enum i3c_hdr_mode {
  * @data.out: output buffer. Must point to a DMA-able buffer
  * @err: I3C error code
  */
-struct i3c_priv_xfer {
-	u8 rnw;
+struct i3c_xfer {
+	union {
+		u8 rnw;
+		u8 cmd;
+	};
 	u16 len;
 	u16 actual_len;
 	union {
@@ -71,6 +77,9 @@ struct i3c_priv_xfer {
 	enum i3c_error_code err;
 };
 
+/* keep back compatible */
+#define i3c_priv_xfer i3c_xfer
+
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
@@ -297,9 +306,15 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 		      i3c_i2c_driver_unregister,	\
 		      __i2cdrv)
 
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers);
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_hdr_mode mode);
+
+static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
+					   struct i3c_priv_xfer *xfers,
+					   int nxfers)
+{
+	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
+}
 
 int i3c_device_do_setdasa(struct i3c_device *dev);
 
@@ -341,5 +356,6 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
 
 #endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 043f5c7ff398ff631f1eea6acfc54a2e871016d8..379e789637ae261c009d13601642f9a1c9199540 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -477,6 +477,9 @@ struct i3c_master_controller_ops {
 	int (*priv_xfers)(struct i3c_dev_desc *dev,
 			  struct i3c_priv_xfer *xfers,
 			  int nxfers);
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_priv_xfer *xfers,
+			 int nxfers, enum i3c_hdr_mode mode);
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,
@@ -505,6 +508,7 @@ struct i3c_master_controller_ops {
  * @secondary: true if the master is a secondary master
  * @init_done: true when the bus initialization is done
  * @hotjoin: true if the master support hotjoin
+ * @mode_mask: bit mask for supported transfer mode
  * @boardinfo.i3c: list of I3C  boardinfo objects
  * @boardinfo.i2c: list of I2C boardinfo objects
  * @boardinfo: board-level information attached to devices connected on the bus
@@ -528,6 +532,7 @@ struct i3c_master_controller {
 	unsigned int secondary : 1;
 	unsigned int init_done : 1;
 	unsigned int hotjoin: 1;
+	unsigned int mode_mask;
 	struct {
 		struct list_head i3c;
 		struct list_head i2c;

-- 
2.34.1


