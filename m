Return-Path: <linux-iio+bounces-27094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE3CBF261
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 18:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3734A30B3FD4
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D69B33FE20;
	Mon, 15 Dec 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X8bgPGTB"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E233FE13;
	Mon, 15 Dec 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817502; cv=fail; b=ISHAao3Drifid+jYehn6pZMxHNoe/4PulWq9zw1zf170Qn05WGoWXLMCbQeztgwhdfxEsRu75USaIkocPDEwSzKn04lWj+dmBenQmvXqaOYXQfvArxbWoGkm5EyIglvUPABYQePxNeu+nG3oM1/x5UfLGGZr3LlQ6moa1aYmjo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817502; c=relaxed/simple;
	bh=anQimOeJzrXr5UYXGKdewIVHAKPren0hdLsICCRdcP4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J+ixYMJOApesiak3Ir1YpvMpL2Igpkxuk3i3h9lG6nes0BDgAjfFbyUEIRPhg0dGtV+Kwg+DBEaU4eubdbT6dJb2ZRJcMT75lOppzmPTlRVR0cZYq61Bpenz5cueiUOAD3dn/7pIWD9CbA58DcrTn2kn/MjoMXZS4bsLYMGhBXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X8bgPGTB; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLihNsQlNRLWOMoYNszK91sQg6nOKvfgDC9Wu9Pm0lBgVufpHOPOS7apEB7bToVrn7w6sRT2fRT7yQ1brE8E3GvqsuF1Y7Q5OwouJsv+HElmVstKMLBqMBjZXNM0jay5v09MCfbdbvkNNxTpvgrKaqzvubQlgFK9Haupk9YrOBryj5Ff7kkEzZVHko2AuD9L5b+H7HvFZlTR7rvwqbwTelt3+Xk7eoutPcDH9Usy1bRu/rrAIGLi6lxG23XT3jVPpF4zlwR5R1y+2QtgLbsvLP5XoIKXc2JlzB38vEC4wlEGcxUF7reyFvMXQgOHTsPGMIjIuaSXYlWOuJEckE7AHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RsDXIj2lTjYkzcPoOY059aoGN8v3PdCa0e/mCxRvMk=;
 b=o/0iP0S191f1uzxuoqNzRHuIPdlOeWnSNt0bIXnV3Gd0vf8aPq8+XEGtkW0tTcNZxRqDJa6aIAka0HyQ52tQlqk9o6vw/+I44+kpYZmqdIth0tSt9NB8ics2czfjRTx14334jNC3V5AG1l+AacsPZWGKTj88CzC0qdwNbK1jUOafQfj+NFeMImwh7scJPPtmoGezydvsQQmK83M5oYcWFnn3NnHUBPd2AMv5C6CD8DugptfAfJHjR9K60PmsmlwMjVtnYfof9l8Ac2g1IZMJ2dGj1yC9jy/o3J5QfJffDgAhm16i8q2UvqkK/jMXK32v+39DifV0jm3+694zfXdDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RsDXIj2lTjYkzcPoOY059aoGN8v3PdCa0e/mCxRvMk=;
 b=X8bgPGTB4imcpKnQlTtIIxTUGY9AwtaS0AsIhN42fEq9F4JQZLkfaPZEE9fakttQ6ZqOwD8FQci25Ac3RPXjiM9WMLOyBikIDhA13RHSkqxbWVWFVvJW654tn0aZjpWioL75I5jKxKkRDu0mF6c4dxdXKfIPZGRPEIs8QhhD1jKNQ22S2Quv8PFiB/Hp2k2NNenlJxL3oLXno+Jj/3czGOXVMSL4GJS0Z3ZZN6ADNNUwQH8jz47rUTiC+noZxZXX/aI6WL05PrXIj20rGD9iLYC4bEP7vzoEwtn5ur1Vl3VD/ZpIrEwCq7PVg9ko/0mP/gOiaH4uZJTLZYYOPdJS9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:51:37 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:51:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Dec 2025 11:51:11 -0500
Subject: [PATCH v12 2/2] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-i3c_ddr-v12-2-1ae31225b4d9@nxp.com>
References: <20251215-i3c_ddr-v12-0-1ae31225b4d9@nxp.com>
In-Reply-To: <20251215-i3c_ddr-v12-0-1ae31225b4d9@nxp.com>
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765817484; l=19758;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=anQimOeJzrXr5UYXGKdewIVHAKPren0hdLsICCRdcP4=;
 b=QsRetOUQa/2TGv1OUN5QlFLLqC4LFYZM7rAnD6iJFbyDI1gSogsllOyCdAqtY7RG3FxXQHGJb
 i/TJuGvYzrcAXnVCyhA6U2Id/d67f0kNDpoy3TBiztvhx3P6Qc3pTcp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBBPR04MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4181c2-3906-4a51-d3d3-08de3bfa365b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|7416014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUZCUTdZN1dBOXk5NlV0SWdTaHdvUDRkU2VBNFRGeE5CV3hTbWhtRVFhZFVI?=
 =?utf-8?B?VU9yTm10YjF1Wlk0WE5ZSWpaSlZDWlZxRDNESEl1RWFtMjUyb3NKSlZsWVNr?=
 =?utf-8?B?UVNnNDVZVGkrQzhub2t2bzcyaHQ0RlA3ZWQ1QzZqYVVXTldCYzk5RzB3K2xv?=
 =?utf-8?B?dlVCd2M1dENFa1VvOVlzb083MVVycnFxL1F4TlhNSHlKTnN6dU9pUit0dEtL?=
 =?utf-8?B?VkJKVkVnZ1JLZ2JuSjhPOHliTnRlR00vUmdGc0s0VFNjV3ZsTVVLQnJPR2hV?=
 =?utf-8?B?aEhpZkk0TjlvSlhPWWUyL0NqM0ZEWVdYd2NsaFdSakdoYW5FMHJmWDZTQmha?=
 =?utf-8?B?eUdtODBEemU5Z2pzUVJvV2J4MjJaVHQzUG5BUko3eGYzTXNDRCszOU1WTlFz?=
 =?utf-8?B?Zzg4cmx1QjNvNm9yTFdWbnorNE5Ba09uWkJFTmRwZDZZeUU5bFZXcjYyUTZP?=
 =?utf-8?B?d1RFWlZDdXBGSFM0QUZ1Q1M1NzRGZ1NYdEpVWVM4L0ZkczZCcmxuQ3J2dFFj?=
 =?utf-8?B?OTJwZVlmOUlTOVd4eXhZanorRUd4eGU4MkV1QzdmcG02eU9XbEw2a0ZMc3Zu?=
 =?utf-8?B?SEFFQXMxWkNUVEo3SC9Qa1lXWVliT1FlcCt0aXhNRnVka1pMZnpuck1kcHor?=
 =?utf-8?B?TFlzNmYxNjJsRTFMOVVqSUc1ZEJaMC80NFAxcnhhMGFYSkNLcVZ4NFg5Y2c3?=
 =?utf-8?B?Zm5ZenJGd3VvY0FMU3pHeVVjRzloMzROcGRMRWlrWmhoT1AvTFBaVE1mZ0tp?=
 =?utf-8?B?M0p1Z01HMVVXRURlQnNzVUlHUldxOHNORndHVEVaK25kMWZ0QjZOVDBvZWFo?=
 =?utf-8?B?a1QwNGR6RFlSRnNBZ250bUg4TTlWSnRwSmRwOGNZSUhTRXQ2MzhJMVBoUEx4?=
 =?utf-8?B?VEQ4QzJ1bWkvTUlJeUxQQ2NEKzNlLzlOQS93ZTd3T2E3ZEgzT1kzV2xUdk1t?=
 =?utf-8?B?Q2Z1N1hlcDdKVERlQVRrcWlKVXl1M0Viek44RlpYMVp0YXhMTnBrenJ5c21F?=
 =?utf-8?B?MFVCQWY2Rk5hS1NlRlpBUWx4d3VqblE4cTFydnhVbTZiTXc4TUJRSS8xcjlw?=
 =?utf-8?B?cGVGSnkrVzF2RlljaHVXNFZ1cnozZFU4cTFYOHg4eEt2V1RzZ2NLc3NLR3p3?=
 =?utf-8?B?eW5WYU0zYml1TFAySjdXN1N0eU80ck5OLzBjZHV6RFNMTFNMNVhvQWZIMG1l?=
 =?utf-8?B?ZlhLbW40MGpPTTJnVUtFWnRjL0E5RUNrYlZWNlRsdXhQRjRyRHVoeDk0YWNi?=
 =?utf-8?B?T0FjOXg5NXIrWUNxWitBdEZKTit1VkNDb0JJZEl5Y2xJN3BkT2w2eWg2cm52?=
 =?utf-8?B?MCtaMkVXS0Z4UDNmTnJMSWJKbExlTDVaeU5WVm1nTW1hQXFWb0drQ3hKdzcx?=
 =?utf-8?B?NUlGYjZ6VFMwZGNza2tsdFFPNkllaXlOU285NDhtK3FhSmw3andVRmVxakNx?=
 =?utf-8?B?Y0ZENTZYTm9aV2t6NUxtSTEzNmRsT3dwcHhCeHRSa1c4T3A5a2JWd2R4cU9w?=
 =?utf-8?B?YXJHNThRM2NRSmFJa0lFa25Ydkx4Q3RpeFhmdDVlK0dhNXNDS2w4TW80WHVn?=
 =?utf-8?B?dm42SXY1UjVZQ1duL3VJdTVaQXF2Y29nYVVIRHpqZmkrbi9kbFZmajlnWlRi?=
 =?utf-8?B?ODA0TW9wTjZXN2YzWVF2U1FSQkU3STZNMm0wOUx4MFZ3SjNDZm16V2RvZjRN?=
 =?utf-8?B?RFlrdTF3aXB1TkJKVHJBa0pPTHJPaEVKNkdjQ3d1bzJURDd0WllNVVh0aFRn?=
 =?utf-8?B?RXRWL0d1U2c1MG5VSmxQeGY1VVdVTW9wTFphUGFMSGV6TDlmcGczUzhzZ1Rt?=
 =?utf-8?B?bW9veThMam9pbmkvT0RyTXpXc0xpOXdaL1ZtbDRnTDBBelFMS2hzL3JOY094?=
 =?utf-8?B?dmxsV3NhM1FySWZVdDRxdDNjR0tCSUM5UjVubGpHdWJhbFhmZWdKYVZUZzRW?=
 =?utf-8?B?K1l0Z2ZLc2RpdmVmVFEvWUVCUm9jMlJvUlRoNkdnUmZZamRsaWltcW5FVUZw?=
 =?utf-8?B?SHh4QzR2blFZcDk2VjJmSXdRVDlvamF1RzZnYm1pOHlaeHJFc2ttdSt1R0kw?=
 =?utf-8?Q?xADySr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(7416014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJQZ1JNRHNWb21uNlNBWWhSV0N6NHhvc1BOTjBkZ0R0dU5TY2VtdWJPcWF4?=
 =?utf-8?B?ZDJ6UHNQSis4akxicHozTUxldDloNHI2MHo3enNYcGJPNTZ6REgvNzhCR1k1?=
 =?utf-8?B?T3pNOXlSVWdacjhPaTM0Q3BCRnlhVEV4VWczSDhmaGJSMnlBKzY0T3M3V080?=
 =?utf-8?B?a2J2bzhMb1pScTRYeHR5V2ViWm9iRXJRS1A1SHY4d2ZUckpZQXBLZlQ0cy85?=
 =?utf-8?B?eUZvYnFRbHFROHRtQkVBK091YXJYODdqYm04bEEyaDBoU3RYc3IwUFJld280?=
 =?utf-8?B?N0NhZHB6RWlWNnBRRHQ5WGtOdUlnT29WWGF5SWFsWHU3RUV5K2QyYnB2NWFG?=
 =?utf-8?B?SmhBZERndkxDVWRQc3l6QTBkTlNTeEZOaUZYaEk1K3BnRVRIakE2cEZOeDRp?=
 =?utf-8?B?MjFEMDNtaXVYdysyRUlxbTZxa3k3VUV0aDk2MEM2SWVmTDZnRmFKbXJ1SGx1?=
 =?utf-8?B?RkFLSGMrSEhHN2VsdFVYQnVRcGpLMkxTbThmU08vVDhobEcwemphb1MvNHkv?=
 =?utf-8?B?ZFF0SHIwcnREVlRkeHBIcHB2WDhKNjJld21UQW4vVHNMSGZHM0tzSk5WWGx1?=
 =?utf-8?B?K0U3NlNSc2g3YjFaV01BL2RKelJDRU9rdFJ0MFhmV1RWLzUrR2ppTnJpOUxV?=
 =?utf-8?B?c0l2RW5TR0lLUjNwRm5ONmJXSUh0RG9JODI2ZU9NRWFGVE9iVTRiYWVZV2sx?=
 =?utf-8?B?RTdZRWhuMGs0QUFIRmlVSUs5S0RQdHBtK2pWTy9UNWhIMVVHd1diT2NZY3hp?=
 =?utf-8?B?OTFBVjNIOVo1TjhNZzB6V0VQVDREbTh6emNNa0NvYjFJU2xWdGxZNWR3K240?=
 =?utf-8?B?eHNyRTBYVExHZEZCdDN4dnNBVGx6YzBianFUWU5kRlJzMUpodGNCUU1DQ3Bh?=
 =?utf-8?B?VE1YR0xpREVpbC8wWmNxSFNPUHAxMVhQdEhXUFZHM25DU1ZBclM4OVlxWHBJ?=
 =?utf-8?B?S0ZycU8vbmdMUWxoelNKdElEN3UvdVdPYjl5V1FyZENWR3BhUjgxdmhmZVdl?=
 =?utf-8?B?OXMwQlF3bVhLaCtDRjV5VjRQVFMrWFJjK0FBa002c2pUTitXRVRQRndjZFVJ?=
 =?utf-8?B?MEJNM2gxMGVzZHhNSUZtMUI4RGZLM2FUTWJDQmx4eXkyK0hiMlFpSVcxbU9m?=
 =?utf-8?B?M25DZ1U3d2FpS3NjUXdVZGNQbHNSUTdiNVNubmxZeE04cTliQXpMblhrdkR5?=
 =?utf-8?B?RGJhbHNVTDhLQnFpVldLNnByZUp1K1FnQWg0Rm9Nc282STNWRGgrVDNyT0w5?=
 =?utf-8?B?ZGE0VUR2L1V2K0xTZUF0RUl4aE5QK1hvM3JiYVliOVVaQzl0MUpjL1phdUN2?=
 =?utf-8?B?dWFpZGx1V2JzczhhZyttclRDZ2RHZlRjQktPTTJTRGJOR2duOHRHRWhTYUhs?=
 =?utf-8?B?c1ZjNGNrbk84VlpiTllwZUpsWUkvVjFRRUtQcnplMjdYQ3o1eWh5SzZkOFM1?=
 =?utf-8?B?bHI2MHJGL25oWkVWOWdLeGt6UGRDaDVxMW45NStFWVNRR1FmQjdZWEVVNTlY?=
 =?utf-8?B?Y0Z4QmY3SnFiNTc3ZzRGd3Y2enN3eHh5WGsxc2JBcm1QSjNyTVFzTGZnM21V?=
 =?utf-8?B?a1RsZmROb2hOeG9NU1ZtdnRIQTVQRFE1aGFNVEQ2K3VObGxrKzYrN1BpelZy?=
 =?utf-8?B?QkJEbWo0VHhMK0U1aFo3Q1JIcGpCa2diVXNndis0d3d6MW4wR3JoR0U1UXJU?=
 =?utf-8?B?L210eFdVQUVjZ0RHWmVOT0FkZjhuaXpicndKQiswaTltdmRKVWptTzVtL2FX?=
 =?utf-8?B?d1lFUGFxK1d5aFV6eEFxWHNGRnFpUHJIcmdYVklGdTdmYTdFUFNta3NYM1pm?=
 =?utf-8?B?WVNMbUpCekc5WmpFNytOaEtqdlVtek9PNUhOQmx3R2w4Wk1nMnZDUW43Mjg3?=
 =?utf-8?B?YXJYdUM2UGs1dExackhUSzErcnhFZXk4WkJNMi9JQ3BDaUZWM0hSdVYyZ2hu?=
 =?utf-8?B?K04yVFoweXoxem13NFBkUGFvYytWZzBPMyt5UlRVanJqMGtRYjZ3dXVLMFJB?=
 =?utf-8?B?Ykt3TTF4UWtlR3A3dEVUTkU5aDViQTh0cTFOTTdabTZUa1pRL0ZrK1lYRUdZ?=
 =?utf-8?B?cjViSUFmSjduWXhIb2YxeHpRSU9SdHV2RVU3TlQ2aU9XZHI0aFRrUVh4ZWxM?=
 =?utf-8?Q?tcFv3AM5/p7J+M26sjicZrT5D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4181c2-3906-4a51-d3d3-08de3bfa365b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:51:37.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c55aHjMjGjYaULSv/G9TVGvJpr4cSWx1mIZPzgE69P3+2geFj9RKVECgDBQhoNzDtwGZ+ky6qgj2nvZwEnyCSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v11
- add andy shevchenak's reviewed by tag
- use unsigned int for regmap
- compact mmc5633_read_avail arg list to few lines
- move check condition to one line for read_poll_timeout()
- leave i3c_xfer as size 1 array to align existed code style in kernel
tree, git grep -r i3c_priv_xfer drivers/, leave to jonathan to do decide.

change in v10
- align datasheet register name
- remove reduntant regmap_attach_dev()
- add missed \n at error message
- move *regmap to first member.

Changes in v9
- add time.h
- remove dev from mmc5633_data
- remove struct {val, val2}
- regmap return value check use if (ret) ...
- 1 -> ARRAY_SIZE()
- use guard() replace scoped_guard()
- use regmap stored dev
- i3c device use bus assigned name.
- use devm_kasprintf() to combine friend name with device ID from i3c bus
  and it will avoid build warning to discard const return from dev_name().

Change in v7
- add missed *.h file
- remove reduntant empty line
- add comments about delay 1us after SET
- use USEC_PER_MSEC for timeout value

Change in v6:
- remove acpi part
- return 0 for success path at mmc5633_write_raw

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
 drivers/iio/magnetometer/mmc5633.c | 585 +++++++++++++++++++++++++++++++++++++
 3 files changed, 598 insertions(+)

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
index 0000000000000000000000000000000000000000..7b20ff3b063b026ab2ae0170fd8c021973428dea
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,585 @@
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
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define MMC5633_REG_XOUT0	0x00
+#define MMC5633_REG_XOUT1	0x01
+#define MMC5633_REG_YOUT0	0x02
+#define MMC5633_REG_YOUT1	0x03
+#define MMC5633_REG_ZOUT0	0x04
+#define MMC5633_REG_ZOUT1	0x05
+#define MMC5633_REG_XOUT2	0x06
+#define MMC5633_REG_YOUT2	0x07
+#define MMC5633_REG_ZOUT2	0x08
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
+#define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0x05
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
+	struct regmap *regmap;
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+};
+
+int mmc5633_samp_freq[][2] = {
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
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
+		if (mmc5633_samp_freq[i][0] == val &&
+		    mmc5633_samp_freq[i][1] == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5633_init(struct mmc5633_data *data)
+{
+	unsigned int reg_id;
+	int ret;
+
+	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
+	if (ret)
+		return dev_err_probe(regmap_get_device(data->regmap), ret,
+				     "Error reading product id\n");
+
+	/*
+	 * Make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET.
+	 */
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
+	if (ret)
+		return ret;
+
+	/*
+	 * Minimum time interval between SET or RESET to other operations is
+	 * 1ms according to Operating Timing Diagram in datasheet.
+	 */
+	fsleep(MMC5633_WAIT_SET_RESET_US);
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
+	if (ret)
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
+	unsigned int reg_status, val;
+	int ret;
+
+	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
+	if (ret < 0)
+		return ret;
+
+	val = (address == MMC5633_TEMPERATURE) ?
+	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & val,
+				       10 * USEC_PER_MSEC,
+				       100 * 10 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(regmap_get_device(data->regmap), "data not ready\n");
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
+	struct device *dev = regmap_get_device(data->regmap);
+	u8 data_cmd[2], status[2];
+	unsigned int val, ready;
+	int ret;
+
+	if (mmc5633_is_support_hdr(data)) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = data_cmd,
+			}
+		};
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
+			},
+		};
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
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd,
+					  ARRAY_SIZE(xfers_wr_cmd), I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ready = (address == MMC5633_TEMPERATURE) ?
+			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val || (status[0] & ready),
+					10 * USEC_PER_MSEC,
+					100 * 10 * USEC_PER_MSEC, 0,
+					data->i3cdev, xfers_rd_sta_cmd,
+					ARRAY_SIZE(xfers_rd_sta_cmd), I3C_HDR_DDR);
+		if (ret) {
+			dev_err(dev, "data not ready\n");
+			return ret;
+		}
+		if (val) {
+			dev_err(dev, "i3c transfer error\n");
+			return val;
+		}
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd,
+					   ARRAY_SIZE(xfers_rd_data_cmd), I3C_HDR_DDR);
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
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT0, buf, sz);
+}
+
+/* X,Y,Z 3 channels, each channel has 3 byte and TEMP */
+#define MMC5633_ALL_SIZE (3 * 3 + 1)
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
+	unsigned int reg, i;
+	int ret;
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
+		*val = mmc5633_samp_freq[i][0];
+		*val2 = mmc5633_samp_freq[i][1];
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
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = mmc5633_get_samp_freq_index(data, val, val2);
+		if (ret < 0)
+			return ret;
+
+		guard(mutex)(&data->mutex);
+
+		return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+					  MMC5633_CTRL1_BW_MASK,
+					  FIELD_PREP(MMC5633_CTRL1_BW_MASK, ret));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
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
+	case MMC5633_REG_XOUT0:
+	case MMC5633_REG_XOUT1:
+	case MMC5633_REG_YOUT0:
+	case MMC5633_REG_YOUT1:
+	case MMC5633_REG_ZOUT0:
+	case MMC5633_REG_ZOUT1:
+	case MMC5633_REG_XOUT2:
+	case MMC5633_REG_YOUT2:
+	case MMC5633_REG_ZOUT2:
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
+static int mmc5633_common_probe(struct regmap *regmap, char *name,
+				struct i3c_device *i3cdev)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct mmc5633_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = regmap;
+	data->i3cdev = i3cdev;
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
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+
+	regcache_cache_only(regmap, true);
+
+	return 0;
+}
+
+static int mmc5633_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	int ret;
+
+	regcache_mark_dirty(regmap);
+	ret = regcache_sync_region(regmap, MMC5633_REG_CTRL0, MMC5633_REG_CTRL1);
+	if (ret)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(regmap, false);
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
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
+
+	return mmc5633_common_probe(regmap, client->name, NULL);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend, mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5603" },
+	{ .compatible = "memsic,mmc5633" },
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
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
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
+	char *name;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "mmc5633_%s", dev_name(dev));
+	if (!name)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return mmc5633_common_probe(regmap, name, i3cdev);
+}
+
+static struct i3c_driver mmc5633_i3c_driver = {
+	.driver = {
+		.name = "mmc5633_i3c",
+	},
+	.probe = mmc5633_i3c_probe,
+	.id_table = mmc5633_i3c_ids,
+};
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


