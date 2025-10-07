Return-Path: <linux-iio+bounces-24824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C919DBC1E99
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB73B4F593A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84912E5B09;
	Tue,  7 Oct 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hSSUydaA"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAAF2E5412;
	Tue,  7 Oct 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850571; cv=fail; b=XKBSyPWjrJnrB9YryNsm5YPqlpe1vkS4vbjPIGgqaFrk3xtFVckT+CcBkP8Cq8klwTMvNDzFMTsgsDICgmIVbL/1j8uCw5s0DH9E8JMWzgm3EOJA/BLWBbLnra4Vxj+MidGHZ6zeq33P1lF7dZFTvKiCAo6LO82XGxrLyeiloO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850571; c=relaxed/simple;
	bh=mqtkllF958q5+5bMyzLRxVkTsMAIGqoNSUia9n5zNbg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=paPtUWlAYfqBJE3xyuPPj5so8VBzaA3lZ1d/kt+MG37TirPmjKgqJRx6hKi289hPXZddCVin0CoVy8ZeIiQ7QUN1RuhzoFCW3OxAzrmueOt6ZY5eszzfJ0iRqD/KJV8Iai+LwZABMFlFN8dfOAn0Zk+fuPcdzKpu27SPGkcD8iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hSSUydaA; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0+cYMMPaR8eY6faigTqrrNML8y0fGjCChUZQGphZliDI2QRypI5i12RwnxIjfUb0tsQhe8DcOnDSm9roi31MJfx0zniKasvNs8ut0HUJNAE94IyBI/qd6dxD8c+c4beLLr3CA0fNGNO3vCd+eqZKq2sPxHprSvBLpTvmtzGoQWfA4+UBXLh2pFE8r4pNr8lmuNFDZxD8EYNX0V56p+c+Am3W8wLWBXvWMfbnARH2duL2JiSkX8mbIiw/8zFOTy1ycSrI+s2bjlwYR657vhXuFQ9D4kfchoOepqG6W1sjMc5Y2/yg6FMTgm7pg9QaAAiHqcFLl+vV3ovbOutdbU4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+vXyhOCLXlnCQ2/VdRVm7+26Viph7dya001yB2zVQ4=;
 b=aUuGebj1MA1+Z/2NEhV5vLRfQQN5CeoHFlYtSeK1bdopL95Ffh5dFyDAywCfXHoRkN9ir2uWurz/asdquJX87A3Anb2SlPLpEcVZRUysgfJuCL6OLYTpXb/qrAopuZNSD+DlKaTMN5jQrO4FMcw754/bsAnr7tOBohUo+JhloqSjVP7dggPew4yucJABNAhfZX644MfwoQpFXFTvTGFAENj1hKByEDTEqes2GFUzMydktnYZf96kubXKE+kmUFfXVMwPz7LWUVI+6zet9anLrUo58UKuKxx6rqNl2S7jU7djeRm6JXZxwg461nuRo1auOPr9Ih8gc+VCF6M5s31jtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+vXyhOCLXlnCQ2/VdRVm7+26Viph7dya001yB2zVQ4=;
 b=hSSUydaAHaWbP9uphsYKnoErLFXYa1875Zf+4fLBTGNpupEJ/nFrsRKqgD+nV9X0nYvjn9Mi/9FHkSb5dkSyEVT5u1vr2nQT4dzJaVdgaEPc4w/RLhLZmZ/EvMpDe0y6eAe0XO0WifjRlmzPk8WGctW29tLaVGSAEjMbnKEuc+v8JJX8jh1D4QQaJIvulCTEd1yS6CadwgodGWhO+xEokeVoSEJFlW6tJKY68CErVJLf6vPdhG6BClNAytV5Lao90u3AhSbvlF11tXBT/nJtuKLdlGF1GcVgjOi74JXm7oqnAoeYZ8n59Xwnmq8C7hzKz7QTyOAX5Q3/N5yo9DRcog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:22:42 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 15:22:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/5] i3c: Add basic HDR mode support
Date: Tue, 07 Oct 2025 11:22:14 -0400
Message-Id: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACYw5WgC/2XMQQ6DIBCF4asY1qWBARS76j2apgEZK4uqgYbYG
 O9edKNNl28y3z+TiMFjJJdiJgGTj37o85CngjSd6Z9IvcubAAPFONTUi+bhXKCWK6l1zThaTfL
 3GLD101a63fPufHwP4bOFE1+v/43EKaMMtKmMclKAvPbTeG6GF1kLCXZVg9wVZFVqMAytAFXBr
 xIHJdiuRFa2hMo1gC0/qmVZvsAIieEIAQAA
X-Change-ID: 20250129-i3c_ddr-b15488901eb8
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759850558; l=2385;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mqtkllF958q5+5bMyzLRxVkTsMAIGqoNSUia9n5zNbg=;
 b=NjrKqZ/cZiv6yE4hpApWn9T33QlnRoNEpfPM/fgrXQkVmf+Z8hg5V2M+WkAwsX4768xUsC2a+
 iWhZ6Wrq8qzDT8sSONzGZh/7u/gc9v62je8bkPuJctxXQJVZt9SmrVq
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
X-MS-Office365-Filtering-Correlation-Id: 5d574ab0-a977-454a-59e4-08de05b55c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czQ3RHA4TmU5ZUJGTWs3eXJja1IrQlBpcys0ZGx3V2lPYk1xTUNyRGVKV0VT?=
 =?utf-8?B?T29rUzVBTWNmeTFIUEt0UWZNS0UyU2d6Vm9DQUFVOVVHemsvV25pNkVlbG1t?=
 =?utf-8?B?dXgwOWpmc0dMOGpZVXhLNmd6VVJnNnZLckthQVB2bHQrMlBaNzdGZTBvUVVs?=
 =?utf-8?B?Z2RGZUlJQWxwTTFPZ2hZenM3cVlBZ2ZqbnZMM2Z4b3Q3aGxoVUU0M3N3eUVB?=
 =?utf-8?B?OUdxZFVaZFcrM2c5WEdIY1ZZcjJjclFNQlZIY3IyVDBEWnBhQTdWODBBcWdz?=
 =?utf-8?B?SVQyL0haYkpIWURsMmliMlRrTWUxRi9hMzBzTEFPbGlCWEtmRkZKOFNDTDUw?=
 =?utf-8?B?bXdZSlhiYUIzTUg4N2c2dXpQUm1zMTFzWUdlQXUvWUVyOTUrdlpQS2lzMHVu?=
 =?utf-8?B?d21VVWRGTXB5RjBkTkF1aXNVQlRHNWdONXdCWE4xUFVCZWNwZEpxbmVGcEpB?=
 =?utf-8?B?QTNUL3ZCNEEyYlBMTFloWVhKUFppQmN3VWhiSHg1YzJXZ0htcnc0Z0VyWDVn?=
 =?utf-8?B?d2ZmWmU3WTRPWGY5K0RMbk96b1pHMEg5SUcwdU5oQ0pUTVh4NmRtQnlXbDZR?=
 =?utf-8?B?RE4yTWhTbEpnSDVwaUhycWxtcXFBdmRNMGdTazlDQ1JwWnRHVlBLUFVJdkwy?=
 =?utf-8?B?TUZmU0dkeG10VmVLTHhlZkgrUkRPaEJrWlJXbjdtRTZBSzJJMmlSaGpQczRW?=
 =?utf-8?B?S0lxV2Z4cWQ5VkRlTkluTThhS0NadTJVQ2RMbjc5VVRJQmpEL3JNd1VLRW14?=
 =?utf-8?B?dDc0azluS1F4SVVWYnhqSVdwcFdrYWV5UjNqMTBFRURRYTZKQzExMGMrbUpO?=
 =?utf-8?B?TC9PWkdDR3hFdkg0MS9UQ0M1cnJJUGQ3REJBbFVObEZ4ckhrSElPZTVUVkhY?=
 =?utf-8?B?QjNvb00wVGY1Y3ZRVGsrWVpnSXVBRkhaY2hlZE1ybGc5aWtySGZ3WUFNdE1O?=
 =?utf-8?B?Zis1U01BUDY2MzVJZWUvVTJxbGFLN3gyWEsxaW5rdkdQRzFvblI0aWg2Zkdo?=
 =?utf-8?B?cDBOWTdLZHd5OGY1RDMyc3JZeFhSMS9kMExUaHNqZFBRMWlqdnBmd01keTZl?=
 =?utf-8?B?SW5mc2taMXZNcmNTTytvM0VIMlBRQzJZUmc2eDBrdWlsUGN4dXgxR2pSaXRq?=
 =?utf-8?B?VGhZMnJWNXkyQjNDM3Nib2dXVVErMTF5Vnl1blFlRU9NMVhwRVpKL2VRWWZo?=
 =?utf-8?B?dFphQTloNGNMNlprMkpEWUNpWU04VjFZQUo5VUgwVGlUbXh0WWszQ1Byc3J3?=
 =?utf-8?B?RXYzTkZzbEhJeExFS1dJUnk1MnFNYk9PeTZSdXpBUFZVSGFWeTNqZWNDbzN5?=
 =?utf-8?B?azcwS0lLVW9vc0pMb2ltUnk3MG9TWDh3QmdqV0pUSUZpL1NxTTF2Q29jRnhi?=
 =?utf-8?B?WTJMYTF1TERDYTRzV2wxbXRaVVlmaFd6cjdlWnFydDRRZW8xZkg1Z0hQdExo?=
 =?utf-8?B?czRvc2hQWDVKQWRvK01mRXJtUjBpTGNleHVieCs2S3ozeE5XTWRIdWJVRHJZ?=
 =?utf-8?B?Q2NqbEdHZm1OUGpWemkxWFBOZHpIcERhQ096Mk1SOTJGTVM0dmpUWVA2dXNF?=
 =?utf-8?B?VFJYZHd4VFFhTWJwcFVvdGFYeHdmSmtUNUE2TUNBOElLellDR0tOcXU5T1p0?=
 =?utf-8?B?a3VXYXhQMTNKZGlGV0VRdFk5WVVZSXFXV1ZuTmJOUWZFZHB1L2Fmck1VQW1N?=
 =?utf-8?B?UXUxWkZYZ29rangzbTNOR0hmVkdXOTJFNmtYTWpZSUVFMjVZZmVSSlJKakRm?=
 =?utf-8?B?cGRqUWRiU0dseHlFWUhsZENkYkJhN1ZHanh3L2kxVDVpR0VVeGRXMFFuWmJO?=
 =?utf-8?B?M2xjdE5HVTBPcEliZjN4Nm44T2wvUFhPeGMzeE5MaG0yYWFOQlJ0TjFjL3Bx?=
 =?utf-8?B?NXk3L2hsTGpsdkl5ek05ajFZa0xMNGFaMW0rNFRKNDJwQWIwQmhjWUVzcjFv?=
 =?utf-8?B?cUJjOTA2MncxUnNiNnpjbXNINDFMeXE2S1ErVmY2S1d2V243Q1hFeTcyQWIx?=
 =?utf-8?B?ZklYdWVHTmhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEdPckdZeHRCNEpTV3JNSE8vajN5VE1WK3hRRldtK1pUMWl0OUVRK1JXQ2NI?=
 =?utf-8?B?dEpmeWJhQXNkOXI1emFraEZyUE9ic05MWU5vQVFyYVdwVHU4Z2FjZ2c0SDc2?=
 =?utf-8?B?OHpmNlpXNFNOVUthajMvRFZjVGdkWXYwU1ZBMWh0VHJjVW03YWxqaEtyelpv?=
 =?utf-8?B?dnVKWmFMUjdKV2FkT0loZEYxcjQvc2pDbm4vcEhpRUhncEFxcnVFZEE3UTFs?=
 =?utf-8?B?by9yY3RpMjFwekF0T2NxcmM2NjVnMWVIV1dHUG9TelBZaGxreGlEdHc4YXBq?=
 =?utf-8?B?czFjd2hzekkzaUdIZHhhWW01Qk1IeGpVNWQwWTYzVC8zVWNBVWwvSGU0TjEv?=
 =?utf-8?B?RWNqaW1qOGpiVDNsTXFrSkhFSU5BUS9wbENuVVJWSEpBQXo1L2lLaTBZMHg5?=
 =?utf-8?B?S3VtY2lHdzY5blRxWFlEMXpwMEpKblhISm8vSjhpWW05VUVnaVoxWnZDcWx3?=
 =?utf-8?B?cWVaTW5FTjZhNDB0RVZLcjNFaXgxOWQvL0ZrY2R5WVl0amFEVzJLcEpLVjN1?=
 =?utf-8?B?VkdBS0FMRU80aFNOSXNoZFFKR0Vtck5pYjUzSXd0K0U4eU5xMFdtNzJMS2Ux?=
 =?utf-8?B?Tnc2R29ZSWdoakVEdEt5T242c2xYS0VIZlF4NUtZR2xzb0FrdUgvYlZCdjJP?=
 =?utf-8?B?cC9yckdVbjJjQ09jMXZ4QU10cHNhS0JWT25xaVZEdkhiSFFUbTYzM3lNVVVu?=
 =?utf-8?B?RlJtV241cVpON2praFBwL2p2QWoxUVl5ajYzSHFsdVNjN2ZGd1ljMXltcXAw?=
 =?utf-8?B?ejQ1SWo4bnd2ZXdGOFg5Z0wremdnbWloaGZUYkVTQ1RrUVNSZEgzWG41Wmd1?=
 =?utf-8?B?L0Y1ek9mYm9WS1dTMHdzUi8ycTBVMCtQUS9Ja2dtaTV4V2dRNzkybW5lSVB3?=
 =?utf-8?B?YnY3ckZHWURwL3BoVU1oUE0vSTVHME9nR2FwcFYwc3hpYUxCcWNtMFhkUTBX?=
 =?utf-8?B?Vlc5ZHhycEozMlFIOUYrMDJUNkRSMTJBdi9PMVFWTzl5d1dXeVdPMFpiVjRG?=
 =?utf-8?B?TXM0QTdWdUw3b0Q2Z01GOTVhT3JTdEl3NkhVR3ZGcVNtdldTWTNqT2kwc0hR?=
 =?utf-8?B?UmM1TTRIaDZCMkpzSXhqQTBRVE1zbnhBTTNTRVBHbk00V2ZIVi9qbWx4VGt6?=
 =?utf-8?B?Nnhxa2RZRklaYkM1Z3k5eTkxVExwaDd1R2lNOGc1NnlydDVsWFJMSjRRcTRV?=
 =?utf-8?B?SmRTeldyaVQ0YTN5Vmp1d0lDK2pBNmZ5UGwvMzBTeXYzMGI5dUpta2QzUU1F?=
 =?utf-8?B?OXQza3JncjlObERkU0JoakFXMEFLVDJYMk9zUDNQNlJibjBtVVN3c3N4aHV4?=
 =?utf-8?B?bnloTjFHTGJZSnZQREFMMDRsSlkrSjlZeWdCVGFURFdONmdaK0F3T05IdVJl?=
 =?utf-8?B?MGFKeVdLTWxlM253anRETEY4N0JxNTc3Ym5IL2ZxODlQVWt2cHU3cUxrU0o5?=
 =?utf-8?B?S29la1VlQkRFTE5RZURQaUx4c2tLaGRHVDg3REt5dE5iTXE3TktzWnRxWi9r?=
 =?utf-8?B?OE9IZXlUR05VVDVpbzF1aWlEa1pJRGNIaWZJektLSDI1QkREeTN1TzZjN2dv?=
 =?utf-8?B?MGR5Q2VreDN4K0k2NllWSm4wekJMcnlPVVlDU3IvZTNqaUU4M0lYYkk0THZl?=
 =?utf-8?B?Q2JsUGpaRzVUQXFhUG9mbnc3OE5VOFVuNW9JV01IdXBWUFNhSEl5UHJvY244?=
 =?utf-8?B?S2NLc0p4UVQ1cG5BQmZmVStjU0gvRS95ZVRsVGhlaHhtWDNWSTBwRXlUdkMr?=
 =?utf-8?B?Z1h3MkE0cStMblVtOTNhS2ZCb2djNzhNaktXalRtbkpZUVpqZ3hoRUkva283?=
 =?utf-8?B?Vk56eXcwK05MUVRwS1A3akJEUFBBWll2Y3ZOM01EZmxMUnZqWkNGa2w2T0RQ?=
 =?utf-8?B?RkRjK0F1b0lpbnFmYkxwdmdzQXVnZmRBc0g3aVpvc3VlTXU1dFY2dEU5emRh?=
 =?utf-8?B?MUZOckRUTDdmS3ViTGZ4bDYvbGZnTlA5aEcxVENjV1RZdFlRREdYYUV1dGF2?=
 =?utf-8?B?bTVxRnBYeEtSUWxJVldzNHhjd21rYnZxV3hUT2ttaXVuZlBsZ09YVk9MbnV4?=
 =?utf-8?B?eTE5dzVXaEtIYTJ5OFQ3dGdYdXV1TlFkbkh5YVlwWlJJb005NzJ3ak5LUHdZ?=
 =?utf-8?Q?/lkfJPpSG+QnnMd7SwGVFc27C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d574ab0-a977-454a-59e4-08de05b55c1c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:22:42.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCL8W2GirwCmL4iRAIGY5QQ6jAgQQ8AqigkrMgmn4Ty+mFyo7nvl51JVJ7IKzFyZnZGIdbpwB7a0VtiKCLBUoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

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
Frank Li (5):
      i3c: Add HDR API support
      i3c: master: svc: Replace bool rnw with union for HDR support
      i3c: master: svc: Add basic HDR mode support
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 drivers/i3c/device.c                               |  27 +-
 drivers/i3c/internals.h                            |   6 +-
 drivers/i3c/master.c                               |  19 +-
 drivers/i3c/master/svc-i3c-master.c                |  96 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 579 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  34 +-
 include/linux/i3c/master.h                         |   4 +
 10 files changed, 745 insertions(+), 37 deletions(-)
---
base-commit: 5248ab97a6dd1dc6856422f6b1595baaf4fa85ce
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


