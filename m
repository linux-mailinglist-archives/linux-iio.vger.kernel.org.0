Return-Path: <linux-iio+bounces-24829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0853BC1EC1
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED0994F792B
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF932E5B0E;
	Tue,  7 Oct 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fFPucQvy"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEE2E6CC4;
	Tue,  7 Oct 2025 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850590; cv=fail; b=JhnAn1+CU3d/mEmToeIXsNjDQAy98nJHVu3/lSHaRpRgeV/zeLbEMUmTIg9ZwFzGTHMjzjss4trYVCQODxa3+36eccF/qeTNjTjDrcvV2LYRIxhw6uKf8ryOZF6VHtRpfd9jqY9nN/mXWiQNbw9sty9sW8y9FScVhUPaMqcIqTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850590; c=relaxed/simple;
	bh=GonrF7xXq/NBENSVkVqI32qPT3KoP3ONBxKZ91a29lw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AtE5Fbwf8SSJm8WKxl3LLOVqdi6i9dZFg6PxZZe6dSioeJNt88UIyNahjQD0pEL218iYmph/r0XLZghJF5k9Dt0864VC8+95mRnHyfEJI6PA+W9wfjxB5Tjh2BXzrtEJ+NVTX4z0c83YYIYGa880FYyvT3Xrbq6qNM9uxx/qRpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fFPucQvy; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kflNZ6QiQmr60edIbIInyCzau3+Hy69CdmynSRZqBNiiULCeJqYMYGZN2i3QCwC2bXkqk7KK3TSqXflJ1cGnHl0vFs83qbC+Jh0VFcfLXQhjf6pofhUsu+UZ/x6zoU/txPuzAHNXISzQ+drAO7PIzzx3MNwgT4POQ/KcANqwtL4OS8C5nYCU/PGOwED6rJntgsoQ+1dhctIh3NNv7lWJMRb5IerOhOU6X9iZF6zSfr5c6bi1TFvPOsD2pPoSa/jJz8Y4qU4seCClRF4Vb3gP7EOumQZqq8cTgEObKxR2Flu60H3QdaWjlIVJ1CHYFLH6hUTxpxMKHXgGmAm76UDp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EETPHlYxu/a4U13DvTn3DOpboUJqgR5EGs46++4fTeE=;
 b=C25PmGTqBTI5u4NlIPS5d2VrIO0ASaoaUFMgxl10NXvZO0dxJPmoVhNLbrSL2hJNFastKeFSb+cn5Rzcyd2NNpge1r+caJBb4q8PLx2kA00EvA3nyWO4cp87f3pUHTwGz1LzgGhvNaCbahzzx+bb27IovzvPcTqFs2kBLrJJbxNdocbB9JTx5OpalG5iCGooJ5ggjqtC32N28xsJEdP1jPszNiPcYrbcZ2PbvI8tp6ALuFzMpW1FTLjHYLoQ8EPWjfMzsX9gQa84WPRwT+r6xUFgNlvD58v3qxmwHkzX/FWohqSwThF4JcDuZM3XjaN/azgf9ZKHZtOoTYvluYbDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EETPHlYxu/a4U13DvTn3DOpboUJqgR5EGs46++4fTeE=;
 b=fFPucQvyg6vtvkQSv9UNAjOky6W2TMuxrxEbZj2raHa8Bj768lPo1ix89DZoaklKe4oD9qmMm2o5CZzjubn/aHh3zxp4qGUewQyfuh9LuPh5wh1ICodw/tRQNHfZ1HPLdDQRc2BTejBhRFvuPINPZxEnfJ0J6yvMZyF4fYuhIGWkgpgM1k9ROfoEmTRD8DXHaFyOojVxy7nde4tixWdvgAVI2B81KQAlIME3rUi1i03CRaxB3Pc17WfNDZBSr7ynaJX+/m+Tm2RXU97IKIgL4UUfHM6hq9stmLmFX5fVBzQlPnuC6kcALXZPYw23czJO4o1l1mm7m7VnWQKTi8rb0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:23:01 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 15:23:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 11:22:19 -0400
Subject: [PATCH v4 5/5] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v4-5-3afea5105775@nxp.com>
References: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
In-Reply-To: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759850558; l=18088;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GonrF7xXq/NBENSVkVqI32qPT3KoP3ONBxKZ91a29lw=;
 b=iOf/w5bziXZCIdrOgfu6CzjXjllDzQDcOWccRoI9bpdnJ7edvywXDvkhZii2/KZQs05p1DxPr
 JtGLd+UNmCkAEoPiHDY3+xS0yp7dpPA8rgV+ErF2CSOzNlj4RkjKgFi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: d856bbe1-4a38-4cb6-1185-08de05b56700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWhUeldpSGdXNHhmZHNHK1l6ZFdkaUFWbnJKbmR6aFp6K21VTWl6TnlzVnUv?=
 =?utf-8?B?ZHpod0N5R29ZWU16RkVpMzU2NytERmNIMVVqdkFJWW5SNXR2YXhPcmoxNHBV?=
 =?utf-8?B?T1UyU0pybnRyMlR4d0l0SmZTOVNham56dTNHUnVaaGw5RW1DY002bEpzbWpl?=
 =?utf-8?B?QUdQQmlaY2NNN3N6US9pa25IRVZhUFF6YU5jZDl4Ulo4QzJ1ZllQOVNMSVIx?=
 =?utf-8?B?NElFWGVxbFhPdGVEdkFqZTBnMHFicEhvVVVZSHRxVmVzeXgyS0NFcHVIYnBu?=
 =?utf-8?B?Q1hzSXVrbEpsdHd3blRCd00rYU5qbXcvY1cxbmRCT0g2RGVkcUc4YUlOVG90?=
 =?utf-8?B?Mi9HU3B5YllIakp1VEdMeXRwNzVIMDIrRVYxbURqUDA3MXFCY25XOUptNi8w?=
 =?utf-8?B?VVorbHYvOHBBYXVFbU1jQ3dCeFlyU29rUDRhaDh0bkJpUzY1bjZIbE9aSzcy?=
 =?utf-8?B?eG1kZnRGSnlORmQ1UDJYWm1HM1Q0LzArdk1uOE91TCtXTlBVMllpbUxEWlkw?=
 =?utf-8?B?RG1ha20rMktBUUQ4YWNGU1p0VCthZ1pVbnIvZ3JZM3k3YW01YkZXdFhvRzQv?=
 =?utf-8?B?ajBPNXhlY0ZlU0taUVNHSFNpRG4wQlFuTzN5dk1rZXdZUlhzWVcvSnQrdlMz?=
 =?utf-8?B?Zm9QazNrSktheGhaYTRCZHUxTkJFWnpjZ1VGaFJvRHZhMmxldUpqbzNlQzRY?=
 =?utf-8?B?RitRSUN5cnFreG9IY3VRVDg1bmJ1SGJKSWdZM3hFSHJrU1EwM1lTYURUWjQv?=
 =?utf-8?B?MUkrRWtHZVlIWjFHWTVoUk9pRU5US0Zsam1KbXFLZGdJNG9icFpSVytRTjA5?=
 =?utf-8?B?TjQzQ0xBc0FrZERWRG1PSDhZRTl2WmlzeHZPaXhmenh1SHJrcVZxVmk5azRO?=
 =?utf-8?B?SkVNK3JpWUhaYmpNV2RSaGltQ0p0dlZvSzExemFrNFd4aDJPenRsUU4yUTEw?=
 =?utf-8?B?RDJBSEoyNmlzWlEwbXFncTQyT2xLRUEwSXpkN01FbWk1S093QndDczc3QldN?=
 =?utf-8?B?SUdMNnEzbE1SL1hWSUhtNm9Ud0tucHUwSTZpUHlYUDlZZ3I4NFk1WTR0dlhB?=
 =?utf-8?B?dzBhME1HMTErMnE0UysvU1FYa25KNUE5K1JBcXh6ZGRPamxIVlphQ2orMHlL?=
 =?utf-8?B?SkgyRExNN281OFgzcmEwaXpjdWZnbmpmdkprcm4weUkrak1tRHZnbUN1VGN2?=
 =?utf-8?B?SmJqYUFCSG03TXpIMkttaEEvb2dQRVU1WksyRHBiQy90MkZJSEM0bjlhdUY1?=
 =?utf-8?B?MmdmaWRzMUMwelo4L0dKUUpNQkNTdks5Q1JUeWorV3ArQUhHVTgrVmdDKzFl?=
 =?utf-8?B?WTVTaHkveHd0ZUVMNEZCZDcxMEpXMC9Hb3pGQ2t5ODR6Z2N6UnJ6OFR1YVFQ?=
 =?utf-8?B?N0xZU3JBK1FUZW1oSnJENlNNQnBSM3B5OUhvbHV1YU41bU43SDI3UklPYkdV?=
 =?utf-8?B?YVluRDJmcUpZZXUvdXpqcTQ2RmZjbXNwSVdmSXB6WlhlYUdhRG02d2psY05z?=
 =?utf-8?B?Zk5FME9taDdabzYyendiZjZuWjBVelYyS2U1cW1EVEk4bi9tK1BkbDM3amhs?=
 =?utf-8?B?U0RPUDdsSW1QUU1Fci82NXp6QU5aVjVrU29nWEZVUzJ5ZjhOajdYWHhJZEMr?=
 =?utf-8?B?OG9ud2ZpaGp5UzhsellPbEZvYjB4NnQ5bDhkYkhTQW9BZk9TemRVUlEza2NI?=
 =?utf-8?B?QlJxK09BTkpwSjZuTnptVVdtTGRsNytCVFo4cUpvOXdEWnRxRUNrUlZsM1Fk?=
 =?utf-8?B?VWtZVnJDZTFVM2NjNFNsN0hZem9vM0hkYW95YU0zWDMrb0pOMlYwZ2ZUSy93?=
 =?utf-8?B?UnZQZWxsLzNwTHhvdVFCeDBtckNFVXRTdGpJaCtMdFpFWTViY3EycnExOWls?=
 =?utf-8?B?RmpEdy92QkF3dkE3V2VaMW9LRmtrQTFkVkdZOFB6UlFGMnhHNXgralVzMC94?=
 =?utf-8?B?QUZldVhwV2lPZVlYZjZRdUlBR1hKTExVRWZvek5zKzFHODlMT2pmeFBmM0do?=
 =?utf-8?B?VlV5WFZGZXJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVFTMlpZeWNENlF6blBkSmNOekx6SjlsMEZTdWNWNEo2U2ZZbzVqOTdick00?=
 =?utf-8?B?MGpDRmc2RXlQS0NXdjV0SndKNlZETEM2R1ZNamk3c2Y0dWpGa1MwOWRFZU9L?=
 =?utf-8?B?S1VLd3FJb1lWWnJIL2JjVzdvalU2RGtoa1RwQU5tYTFldUJPbGQxT2tvcTlz?=
 =?utf-8?B?WFBpdHlrRjAzb04wUG9RQ1YrSXdFa1Z0d3RkS3g0cVdqYVR5SU1tZDZFaFB6?=
 =?utf-8?B?MVAwMjE2NkJSNFAyYnBhRmIxR1NMejlZYjZ4cjV1QThKTGk1MTFwSkxzVmhv?=
 =?utf-8?B?ZmhoMjZtM1hZL2ZQZEFjanBJWWZaeU9YOG0xRlkxSlQ3cWlZWGc3RytLVFZj?=
 =?utf-8?B?Y3ZRNWJ2WnNLdnM5eWpGczFraktETjFSNmVTZ09DQ05UZTVRdkZPL0dkSTQ5?=
 =?utf-8?B?MW55OHBPZFNndmRLY25GbURqREN2VDd5b3R0bFEyWVdSVWVtTnFnWCtpc1hS?=
 =?utf-8?B?ZGhyeU1YLzRlWjcwdGd3My9QNk02QzRJSHFIZ2lKL0NIVlBER0o2Skw0dk5V?=
 =?utf-8?B?Y3Z6TWxTYWVmRDZvRStCNDNldWorZ2wvQlluMkhYdTk5ZFNRbmlCVElhRG41?=
 =?utf-8?B?cVd5K0lGQ3JpN0lrekNSbjVQSkNCSW8xWnBkN1Fncnh3cGt6NmgxR0w2VWR0?=
 =?utf-8?B?bkFvOEpNM2M0d2cwZmNxT1ZqZjEyS2licC9tVVdiclZ4Y2J4ZWQ4ZHFJWnR5?=
 =?utf-8?B?RkhnbXVKbDltOEdVTWZTTWZEc2p2L2tVb0dsZ2hKWWg3V2cza2hRQTEzcGIx?=
 =?utf-8?B?K3AwY1JienFFdjJhejRINDkzeldueWgxeEUyUDVnRlQyTmYvU1RadjdudzhY?=
 =?utf-8?B?WG10WnpiOFBCRXovMzRFa2NlTlpUaTBtUXpNS0kwSXRUVjdVTXE0VGFZRWti?=
 =?utf-8?B?aWVNcy9OeU40K0NIa1p6TnRrVTh2TS9sZjQveENkc2pFZzR0TkhmTkQ5dCts?=
 =?utf-8?B?OTNGeDk2aWYzWmpKdFdFUnlUOGtrVXV3UDVFallRUWxGYjdvbUxWdjc4emVT?=
 =?utf-8?B?MG93ZjF3TGZsUFlsUWgydllDV29wbXQvdE5iRVZFbDlDSmFmdWtyWDJsL1BI?=
 =?utf-8?B?bVlvOGhOVS9PNVo5MjhiV1NXaXRSY3N6NFl0UndydnNVRlR4UGNtTkV4c2FV?=
 =?utf-8?B?WFVRWlVqNHM2WVQvZElFZHlwRWdNSkRody9rVlA4OWlydk11eGxMcXBNb0M1?=
 =?utf-8?B?YXZBNElxeStMcll5WlZybENWR2laQVZ3dXh3TkxxR1RIcFlKbk1YS3Y0Q1JS?=
 =?utf-8?B?RlkrYjE5RWZTenUvSGlvRHU5bldMb01iWW10djlJWlMzRk5ONSt4RHM3NDJM?=
 =?utf-8?B?M2lDTTJZZm4vaERIR2VTTHUrWTB4MzhtNDYxTW5nMFlZMHdBcndFUGhleHA4?=
 =?utf-8?B?aUpXdUFWU1BSTHJER1REd3UvcklsaGc2UTJOcmlQOHpEQkpyYW5XNXdDeTNC?=
 =?utf-8?B?YUdnbGpPMXZTK2lRVm1kRzVmYlcxano1M2RIY2l0Yi9oSTBxQmx2bDRBQVdU?=
 =?utf-8?B?bEl5Vmc0S05qYzgrTTY4b0ZnTFNuZFJENmZXOUdIakk4ZCtMNmZ6ZWh1SjV4?=
 =?utf-8?B?eCtUVW1xcWtYMElRL3VraDJJbEp5MWV1Si9rZWtNMlJFeDZKRk9tSFpKdk1S?=
 =?utf-8?B?NjV6WTNmL2w5endDelFnUVlNSW04L01DaklUUkYvZnlYcHNvK09GcVUrTGVY?=
 =?utf-8?B?SEhYNVJvMlgvVXNmSDhuZFRxeTFPZnN1NkJGMGxtRGlGYTlxQmVrMGJkaG13?=
 =?utf-8?B?OXFiRU9wNkxiVXh4Q3lkRm8vbVhjd2s0R2MvM2pEVW9UMEs1bSs1V21xSUx6?=
 =?utf-8?B?RXFZckZISmhPMHA2MW5yOGt4b0dmakU2SzJvYXBZaDV1ZmRoUi8vaEgveXpC?=
 =?utf-8?B?R04wT2grTEgzRUpVdjRpMjZ4YzJPTHk1TFZ0MXVYVzNtTjgxSC9DK21TRzRK?=
 =?utf-8?B?bjFYQjNiemRhY1I0OGhvOFRHYXJZNkpXWWt5Y0syVHNFY2V4S0R0NW53ajB5?=
 =?utf-8?B?Tlo3M1dsVW1xNi84cW9OcjRIS1ZUeC9oVmV1VklmUFJSQ3MxVUdMOEtkSjVM?=
 =?utf-8?B?eUxxZ3FBd2NhTVUrU2tCWnM0Nlh2Z1BkZXZKZjNhaENqRklZWTg5djR0R25J?=
 =?utf-8?Q?et16IUIg+i9/IgR3TjSkXw2Hu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d856bbe1-4a38-4cb6-1185-08de05b56700
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:23:01.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBGsDWjR48gw67d8x+82mStLMrXehopTJEB4vczz7CCSCzaEsHWxS1bGobvDq6r98N/ma9KR0R4vfdxYkOcsXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in V4
- use { 1, 2000 }
- Add _US for timeout
- Use GEN_MASK for MMC5633_CTRL1_BW_MASK
- Use { } for terminator.
- remove !!
- fix mix tab and space
- add mmc5603 (merge https://lore.kernel.org/all/20251003000731.22927-1-fluturel.adrian@gmail.com/)
- add tempature measure support

Change in v3
- remove mmc5633_hw_set
- make -> Make
- change indention for mmc5633_samp_freq
- use u8 arrary to handle dword data
- get_unaligned_be16() to get raw data
- add helper function to check if i3c support hdr
- use read_avail() callback

change in v2
- new patch
---
 drivers/iio/magnetometer/Kconfig   |  12 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5633.c | 579 +++++++++++++++++++++++++++++++++++++
 3 files changed, 592 insertions(+)

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
index 0000000000000000000000000000000000000000..9b04cba6dbf633b7e0d136629a5aebffd072a68d
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5633 - MEMSIC 3-axis Magnetic Sensor
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ * Copyright (c) 2025, NXP
+ *
+ * IIO driver for MMC5633, base on mmc35240.c
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
+#include <linux/unaligned.h>
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
+#define MMC5633_REG_TOUT	0x09
+
+#define MMC5633_REG_STATUS1	0x18
+#define MMC5633_REG_STATUS0	0x19
+#define MMC5633_REG_CTRL0	0x1b
+#define MMC5633_REG_CTRL1	0x1c
+#define MMC5633_REG_CTRL2	0x1d
+
+#define MMC5633_REG_ID		0x39
+
+#define MMC5633_STATUS1_MEAS_T_DONE_BIT	BIT(7)
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
+#define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
+
+#define MMC5633_WAIT_SET_RESET_US	1000
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0X05
+#define MMC5633_HDR_CTRL0_RESET		0x07
+
+enum mmc5633_axis {
+	MMC5633_AXIS_X,
+	MMC5633_AXIS_Y,
+	MMC5633_AXIS_Z,
+	MMC5633_TEMPERATURE,
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
+} mmc5633_samp_freq[] = {
+	{ 1, 200000 },
+	{ 2, 0 },
+	{ 3, 500000 },
+	{ 6, 600000 },
+};
+
+#define MMC5633_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = MMC5633_AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				    BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5633_channels[] = {
+	MMC5633_CHANNEL(X),
+	MMC5633_CHANNEL(Y),
+	MMC5633_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.address = MMC5633_TEMPERATURE,
+	},
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
+	 * Make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET.
+	 */
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
+	if (ret < 0)
+		return ret;
+
+	fsleep(MMC5633_WAIT_SET_RESET_US);
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* set default sampling frequency */
+	return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+				  MMC5633_CTRL1_BW_MASK,
+				  FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
+}
+
+static int mmc5633_take_measurement(struct mmc5633_data *data, int address)
+{
+	unsigned int reg_status;
+	int ret;
+	int val;
+
+	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
+	if (ret < 0)
+		return ret;
+
+	val = (address == MMC5633_TEMPERATURE) ?
+	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & val, 10000, 10000 * 100);
+	if (ret) {
+		dev_err(data->dev, "data not ready\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static bool mmc5633_is_support_hdr(struct mmc5633_data *data)
+{
+	if (!data->i3cdev)
+		return false;
+
+	return i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR);
+}
+
+static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
+{
+	u8 data_cmd[2], status[2];
+	int ret, val, ready;
+
+	if (mmc5633_is_support_hdr(data)) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = data_cmd,
+			}
+		};
+
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
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
+		data_cmd[0] = 0;
+		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
+			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
+
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ready = (address == MMC5633_TEMPERATURE) ?
+			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val ||
+					status[0] & ready,
+					10000, 10000 * 100, 0,
+					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
+
+		if (ret || val) {
+			dev_err(data->dev, "data not ready\n");
+			return ret ? ret : -EIO;
+		}
+
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
+	}
+
+	/* Fallback to use SDR/I2C mode */
+	ret = mmc5633_take_measurement(data, address);
+	if (ret < 0)
+		return ret;
+
+	if (address == MMC5633_TEMPERATURE)
+		/*
+		 * Put tempeature to last byte of buff to align HDR case.
+		 * I3C will early terminate data read if previous data is not
+		 * available.
+		 */
+		return regmap_bulk_read(data->regmap, MMC5633_REG_TOUT, buf + sz - 1, 1);
+
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
+}
+
+#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */
+
+static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
+{
+	if (index == MMC5633_TEMPERATURE) {
+		*val = buf[MMC5633_ALL_SIZE - 1];
+		return 0;
+	}
+	/*
+	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
+	 */
+	*val = get_unaligned_be16(buf + 2 * index) << 4;
+	*val |= buf[index + 6] >> 4;
+
+	return 0;
+}
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
+			ret = mmc5633_read_measurement(data, chan->address, buf, MMC5633_ALL_SIZE);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = mmc5633_get_raw(data, chan->address, buf, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_MAGN) {
+			*val = 0;
+			*val2 = 62500;
+		} else {
+			*val = 0;
+			*val2 = 800000000; /* 0.8C */
+		}
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = -75;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
+			if (ret < 0)
+				return ret;
+		}
+
+		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
+		if (i >= ARRAY_SIZE(mmc5633_samp_freq))
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
+static int mmc5633_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals,
+			      int *type,
+			      int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)mmc5633_samp_freq;
+		*length = ARRAY_SIZE(mmc5633_samp_freq) * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5633_info = {
+	.read_raw	= mmc5633_read_raw,
+	.write_raw	= mmc5633_write_raw,
+	.read_avail	= mmc5633_read_avail,
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
+	case MMC5633_REG_TOUT:
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
+	.cache_type = REGCACHE_MAPLE,
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
+	{ .compatible = "memsic,mmc5603", },
+	{ .compatible = "memsic,mmc5633", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5633_of_match);
+
+static const struct i2c_device_id mmc5633_i2c_id[] = {
+	{ "mmc5603" },
+	{ "mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
+
+static const struct acpi_device_id mmc5633_acpi_match[] = {
+	{ "MMC5603", 0 },
+	{ "mmc5633", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, mmc5633_acpi_match);
+
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
+		.acpi_match_table = mmc5633_acpi_match,
+		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
+	},
+	.probe = mmc5633_i2c_probe,
+	.id_table =  mmc5633_i2c_id,
+};
+
+static const struct i3c_device_id mmc5633_i3c_ids[] = {
+	I3C_DEVICE(0x0251, 0x0000, NULL),
+	{ }
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


