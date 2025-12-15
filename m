Return-Path: <linux-iio+bounces-27092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7245CBF162
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 18:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB1A33018B76
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1033F38E;
	Mon, 15 Dec 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bR91H+xt"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520C33F371;
	Mon, 15 Dec 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817495; cv=fail; b=ctVM/tF6JaZVzo9tNOn5j6yV+1JFEpPhQN8Oj0qwE10gYGU6NhXrPfhOz48MqJ15+kCLpedW/Z3L6APzcelEw7bR3LwiXBfRi9NCxUWdyC6bbFPCY0F5bdpF3lCGXxFlWzHj0IkK+JjI+5B83ToJA+REBpCcovTia1yuIuql52c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817495; c=relaxed/simple;
	bh=4HRVS5+STWD2ufFspkYYAuS93c//5Mm7gbSMM3b9qqM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Cgd5MO3jNDogx/fN5/BaFFil7n8RaAbeYPTdKVS8YGABjj5yfU1M/Wp7GAbkAAjqCNwp3KpOLtUaF7WZ/EbQofx4gaT97FBZ9XBFq3wEHbCv4Xa8iZdrF3qjydreHNSkekhOp5q4S4k1x21hSu1ShzOn2eBx++suKpptSi+gIyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bR91H+xt; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXwpo0YbLmS0XPYjwMxHsg+tI4wH1st53yXLm9nWhQNMhNm+8zmmzG/fcnIrreG4YgZTeCg9Xp4hGgVkHVvkF5QsX8tnI+SH3pcrt2NLS46c6qRAP1niBKvLXDqtWi4p3zfiyTFLa/LOJc2SfmCiEILYUGaqQOXO8HFHCHPViPYwRluHmwYPjZRAItIhog7UaSbdQsJbXPNyyAYbMpcmS0RJUgcBPqoQPKeNZnJYQ8vRLGq9IAPntCB+IfCJwX3a0J8ZRcpm5hI+Xxhme6ta6wKHj7ZbkExu4V62NFqIGAewdPIM++zEYodQME654i9jZTVoYon/y+r5sDg8Onq1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM+r3Od/leHPIt9S9y7YAbP7UAT1s4TjRAvuqqmG4Cg=;
 b=Apk3xGdmjqcxUvDH1wsxr+fwRfTmzUom6hULh6h6Nn++4DcR3/kLgb/zA1YD9iWg21U1jS1sKe2UBngAftJ1Vn0dCBlG6IrKhW3tRCl8KRbwDpW8iGNtuYdNbMWH1mtSPXF6ahkxzmsTeoRkGij2RDbPC/hr4B0PnntZBSiPux1avID1HZfxinGkyWTwhcHM84OeIxWqDWTnIZzX+cWgFaKBnnW4H5Xexq5A8Hj7ak3QMd1wLDEr2/kb61fb27kryfDy6g6mvIkdurQTdVLfoC9btFo97tVefB/zhbLi+elFacYfui5ET0ORJIa8kT4tZBHUV5ryy2N6kxGgZhbrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM+r3Od/leHPIt9S9y7YAbP7UAT1s4TjRAvuqqmG4Cg=;
 b=bR91H+xtxRTk8rgAF1PIlm6FPWAAPNT98ej+N3vMp3om9jUuEUrtDqk5BZ3RZB5wYqpj10cijy8CZcJl3hja2LCG4diVoHbwYtxyuTk6HkSCQZ1OZKtLAi2eMOHITSUV1Vs/XxtjOfs6A7v7RXp8LNprbTEP70SKVkxyoRZAHxOA5j4p3a6+vtb9MDjg/fKk7GSq5BCynEMQfjyMEXshRsRVJRKVjHDP2Gnpjs5a3PsFzjkBbuBRdiU/yTMejSjd1l0dBwIfSnDj2WZ+0O6mTZrTXK5MV1DsJoRwzJ94Sty9fFgQx6KQ1D/L9fYuVdUN8l04XrKZ0rtie8cT0UdZMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:51:29 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:51:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v12 0/2] i3c: Add basic HDR mode support (sensor part).
Date: Mon, 15 Dec 2025 11:51:09 -0500
Message-Id: <20251215-i3c_ddr-v12-0-1ae31225b4d9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH08QGkC/3XSzU7DMAwA4FeZcqbIdn6ccOI9EEJp4rAeWKcWV
 UPT3p1sQjQd4mgrny3bOatZpkFm9bQ7q0mWYR7GQw2QHnYq7ePhXboh14QiIAtIoRt0est56nq
 0xvsAKL1X9fVxkjKcbqVeXmu8H+bPcfq6VV7wmv1bY8EOOiAfOdpsNJnnw+n4mMYPda2w0KoCm
 VVRVc5TBOk1Waat0o3SsCpdVe+IcyIpeK/Mr0IAXpWpSsciseYts90q+4+yVRlj0JvCTFa2yjU
 Km7ncTy8TmDUCbxU3ippeXJV3LkIpXJJxW+Vb5Vflq+Jgs2TKvU932wiN0riqUFVBsaSlj4X9V
 iGsDKEZDOuVO9FiUp+QQd/dGbF1rnHX/6F1dNE5yRCa7V8ul28CdoEQvQIAAA==
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765817484; l=3469;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4HRVS5+STWD2ufFspkYYAuS93c//5Mm7gbSMM3b9qqM=;
 b=17oazU6wz/zzMgJsERpZyqq4z+KfiWJ+HeY72psZBy4AFTAWMf9xKPOhzQQbpdqDZS5/C9v1Y
 ZBbTgxUNIPICtFNEUy4EvYTHbs9ix+MuZC8zOvt4HbowTiCv+zV5ewe
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
X-MS-Office365-Filtering-Correlation-Id: 06966abe-796d-43ab-eac7-08de3bfa3130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|7416014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXQzeTdpRjIrWWhveGNvUm51aGxEL01HSmxQSi9aNldQNGJoemlxaDI2eXF4?=
 =?utf-8?B?NUN2QTVXc0hyaUc1RmdXSGoxUVcwM0E4bW1CUzFNcUNxY053L2xRNlpaTklj?=
 =?utf-8?B?SUdQaDUxTmVFR21Xc1diNXZCeEdCY1o1MytuanN3VDF5NHgySVgvQkh3b0ZV?=
 =?utf-8?B?ZE1ER3U1N1M1NVBnVHl5TWlqL1FNNWdBcUFRUEl4R2pyL3ZmMTRCYnVZYTZ0?=
 =?utf-8?B?dG1KQ2pzL1JiY3JvbnJpSFdSTGhaWnhwMlB6Rm9FdUJpQzRQcDNzaGNHSjkr?=
 =?utf-8?B?TmtzNzF6ZWE5WG5BY2ljNy9xcEdETXQ1Z293V1d1NlZZaFpaRUdmRWVrZTk1?=
 =?utf-8?B?cWFlM2w2U1lTQTFCRjlZTU5tOFM0Tm5ML3RDVFZTTDBQM1ZkK1cvc3FWQ254?=
 =?utf-8?B?SXNHWlIvVjRoYmFWL3MzUjE5b2xDUGxYRFo5TGNLUU5XVXZLSFA0THFsdVF0?=
 =?utf-8?B?bXQ0dHRaMFQ1M3djQS9CWlkyNWFPcHhqRmdvWFR0bHJKTGdxcktDdHlOWUVY?=
 =?utf-8?B?dXIycHB1YVdraGxadmlqaUtuRmN2NTBYOE42dHJvU0tBMnIyVGFrYXNRdGxN?=
 =?utf-8?B?WGlKWE5TZ2x4YjYwdW1wSStiWGxBYU9FU3lhTGhhK1VhamU1WWxGQWVxZjhx?=
 =?utf-8?B?bmZGa0pla2M3cUEyOVM4NWRaWDNoajNaWFd5UGFiUEtJLzEzcmlnU0dBeFY1?=
 =?utf-8?B?U2lvY3E3dTMrT3Q4SkdoYzdUbU5QTmJuN1BOMnI3eEFXL0xjRVMrNStQK0Ex?=
 =?utf-8?B?MVNzUnpsR29RRGZVd094eWJrMXFrRCtiZy9Md1B4dGFGcmJreW1VWFJUcE4z?=
 =?utf-8?B?dXk2VFp4bkdRY0xwdWVBNlhKSEtZc2ZVRE84NWJhR3p1SEZnMFltMzRzdnR5?=
 =?utf-8?B?aHQvOFlJWXd4OGcrM0RUNDBUYzhXV0JjZ09YSmYremFST0YvRTltQmYxTDZE?=
 =?utf-8?B?TVczRHdnQzlwc3lGOTgxRERtR0F4RmszeHlNN0JENVh5UUxwWkQzTEsrVFdX?=
 =?utf-8?B?czBTTDdVVjhZY0dWVHdVQ3N2RGNwOSttMjJIRUxlVWludXIyM3lPd3NRNFZm?=
 =?utf-8?B?Rk1jN3FPbWl2Ums5cGRtZXZJVVhtNWFaSXVTYm10Ynl0cDNQRm00azJ5MUxW?=
 =?utf-8?B?Ny9HeFVXbzhpSENmZlJlTnJkTC9Tdis4UVJ6aFRiWnhtRGtFaUFTNW56NGpK?=
 =?utf-8?B?SDRaUVhSTWxLZ216QnYzTDQ0eWswbm4zTjhlQWwyTnlzOTNCbjQxMTIzMnFY?=
 =?utf-8?B?MmpZaG01dHdCNy9aL2tUS2oyNlliWVRVZzQ2Y2ord0g0bWQrZU9TMjkrS2cv?=
 =?utf-8?B?bWl6eFVRZjQyelpSQUd1QWRkRzZqZXlFRHVvUU9uK2w0M0FLKzlDZWR4MEts?=
 =?utf-8?B?MUxMTkpXRkZDV0V1Rml3TS8wU2d1VHRISXJGQmV3dFJ6cG9vVlNNSWJHSFhs?=
 =?utf-8?B?dkthVENtMzhKMDhWN1VkbnV5UkZyY24yZUYzZi9TZDJjL1VrWnlhTDFHOVp6?=
 =?utf-8?B?L3UzUTFGaFdRa25qVjE2bm1ROTZvQnFQQ0s4UGowZ1lWTU12bnoxMUk3R3RQ?=
 =?utf-8?B?ZVBMZ0xoZkRVdG5qeUs0d1JMY1B6ZjZybTJhVEt1M1p3OGNDUnJSV3ZFMDNo?=
 =?utf-8?B?S0x2eVBlZEUvVkl5NlI3RTBJNDNQeEYyWU9jZW13SVpNb1BpSUUxMnhaWWNE?=
 =?utf-8?B?VGNKcTVZSkdNMkFXRFV0d28xWHVUN0dkM0hUdUtRK1VhdTZzU3JTUFdMWllT?=
 =?utf-8?B?OWtzcXFaaTByTllQTStzcklQZTFJSFJDOWpVNTE5TmVFODJGMTIwZTRONG5E?=
 =?utf-8?B?bCtCK2d1bWJEL1VpZDZrSHpZTUlxaitMYy9LRXpmdm9vVWZZTVJKTVlFUE5O?=
 =?utf-8?B?a21iZWE0cFZxeU9qYlNaK3h5Y2tSNENubS8rdWNCNDFRTTJtWUw2ejVsVVBQ?=
 =?utf-8?B?ZEJNYWk1NW9YRTA1V1dScGtaRG45M1EwWmxXVUdDT09OMnQwWk14UVgwQ3cv?=
 =?utf-8?B?a0NVZ1ozdTdnUi8wNUs2ZWIvbEluOXRtWnZUNUxnMnJ0bmo5THVBZWNvb0JI?=
 =?utf-8?Q?zk5wb2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(7416014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlpjRU9PSnNsa2d5TzdudWhMVkdod2lkalRrTlNyVSs0WDRWaXRhRGJiMFIx?=
 =?utf-8?B?YXJkMjhIaExJMkE5YURLYy9XU0txbkdSVVdnUzgxaGlreElybGJGL0gzckN1?=
 =?utf-8?B?eWMvNHZyNTA3Mk9UZTNsWjhjUUVHUTEvblhQeTJ6SnJRVUZ5UFJIRVZOYVI3?=
 =?utf-8?B?Z1BQbjVaUnJGeDhwSG9GNzY3SlhsajNRY1NIVzR3WW5vZ2NaeHE4UjRvUFdH?=
 =?utf-8?B?K3Y2RS96UkhUenRlaThFZHQzNEFaditMdlNWRU1SZEpUbTJKL1VEdXpOU0U1?=
 =?utf-8?B?V3lLbHlZNEJYVFpMbVNOREtrT1BxYjZJUTAycldHRjlVdUhSbyt1Zm15SDRm?=
 =?utf-8?B?YVVIY0tZZVNtcVY1SUpBU0t1LzRUcUhkZFZFdE9sbCtxMjYwMWpBTDQ2OXBh?=
 =?utf-8?B?NWNSNy85SEdudE5QcXBCdUtLMTNRTmkrY1VxZXZLck4xZHN1Tlo4UE41K1Nl?=
 =?utf-8?B?YndyZ3ZvMUZtWXQvWXRWaElkQlFGZUNWaGIzV3R2OEd0ZnU0WkRER3JkMlpq?=
 =?utf-8?B?YWt0a1ErZVBmYVlaRFUycHVOeXk5R3gzclFjS2xpTnR3RmlUVGczZmlrZmE5?=
 =?utf-8?B?cHZPS3M0ZGltTHZvdFZHTkFJTzY2M1NwTVVDVk9sZ0U3TnczNUt2aU85Q3Nv?=
 =?utf-8?B?OGhldDVxZkJNVFo3WEo1blc3b3BXSzdwNWdjUGdHaDZ6c2tEVnZUdDJ2UCt4?=
 =?utf-8?B?OTI3eTZQRVlhdTd0dE52VVczazBOcDNEVjIwdWg3SlppUmtVTTB6dzROdDlq?=
 =?utf-8?B?RXhDYnRvYm5OWEpPY0VaRHdJZWlrV3M0bTRaZFdLWkVjMTR6TGEzNFk0ZVhx?=
 =?utf-8?B?YUx4TUlpSjZJNnRFa25rN1VBUktzTkNXZXdtWXNjaXltandyS0Q1QldJbTg2?=
 =?utf-8?B?ajVFRXlOdHp6TVFGWnNFOFRYa1lFMlh3K21LUlYyN1hLMXFlY3F5eVpOaVNw?=
 =?utf-8?B?NzhjSWluY2NPTFdIakhTbTIxbG92RDA3R1p2a2U4NFJWeTJGeElyc0VsNnd2?=
 =?utf-8?B?N1pNeVljZDlqZTRLKzlxMSt5ZEZ1WTBxcTBoR3hLY0NjQzd2Q05aa29nRjA4?=
 =?utf-8?B?N0dWaEl5Wm9qdmxVYncwdDdlRmx0MzVhbnFxOW9lVVdHdkJSRFB5WVMxY3NV?=
 =?utf-8?B?SlkwZ0NBRkNMNEtINUEzUTJ6RWlWem5mWEhWaGpuSGIzM29NbmlNb05xV1Qx?=
 =?utf-8?B?cGt2Snp0VWFWMjBldmRNbXZNTG51Q2xtOEtLSzB0cTFkMFA5TkVxRVZIbnhr?=
 =?utf-8?B?cVk4cnpibnhwQUFHWWplSXhrU29vdjFHYWJCZTlNa1ZFeVIvRU42eVExYzRM?=
 =?utf-8?B?d1YrLzRmMlliYlAvQ2xLVzEvVjFURHErVUk4Y2VQM0NHcVVZVWE5SWt3N0lG?=
 =?utf-8?B?TTFwUTlPS1pJUXRQTlBNYTJ6OXBFc3JvdzV0VG5BcU92RmpxR1RSaUlFSTRz?=
 =?utf-8?B?ZzlETVphNG9ZWTkyNDdhL3FsUThKdzlQYWNMTW5MKzNHaFFPV2JMRjMzcG9x?=
 =?utf-8?B?dmtaV3VCckRKVXdiUkxnVGQ1cHdTMmE3clVGeUdsZW5zcnN6eG1PL2ptMWRI?=
 =?utf-8?B?NDk2UGM3aC8ybk9lV1BhMERaUVhmdHgremcwM0d2OWJQWmRnb3RpRzROT0Q0?=
 =?utf-8?B?S0VzSDlIc0ZVbXVXZEE4LzczZDNKdmFWcC9QVVZNaXQ1L092OTJpajI1UzQ4?=
 =?utf-8?B?MVhEVnpWWi92b0VwTTVFYlMzOWVycUpOcWRPdVQ0M3RIOFJtN0ZQZDVHQmZY?=
 =?utf-8?B?TVUyMDRydEh3dTVrOUF3bjBRNlpuZ24zeC8wZG1oSnlJUjFndDdZbTVHQjRP?=
 =?utf-8?B?SkRGSjZHSGVjNUpYbWJtd21Ld1NjUCtvZU9Oak9CSUxRUGVwc3RFbVBGNGto?=
 =?utf-8?B?WXc5RXdqaW8rRkJjeUJyRGdFL2FvdEJVN2ZRaEpXL2w1TkZXeDFsU2pmN2ky?=
 =?utf-8?B?am5KMzdyUnl3WFNiaUVnNDhvYUdxR3RIL253VFJQM2ZkMU50Mm1IMzhSWlpN?=
 =?utf-8?B?TjJZUzFQdWhnR293SWMxVEVrbFd0d2F1SHp3WFR5N0NsTUI2Zm9kbEljOUox?=
 =?utf-8?B?d3VoNkY2SFI1MS9qQ3ZpWHkwbmtGNkFSU3lvUDNVQVp4UkxDalFnVjhmdHRW?=
 =?utf-8?Q?nGnBjCmxt8566LQLkwFtvwLnK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06966abe-796d-43ab-eac7-08de3bfa3130
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:51:28.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSUmaru2dREpJQMXClmIPzQD7SwlglZQWSR/9GClE0VVNHwQlC9ta8vunATq2touzXG1bAfCOa+jvROhdeV+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913

I3C part already merged into v6.19-rc1. Just repost sensor part.

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
Changes in v12:
- rebase to v6.19-rc1
- repost for sensor part.
- Link to v11: https://lore.kernel.org/r/20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com

Changes in v11:
- Add Andy Shevchenko's reviewed-by tags
- fix some nits at mmc5633, see patch's change log for detail.
- Link to v10: https://lore.kernel.org/r/20251104-i3c_ddr-v10-0-e3e4cbc17034@nxp.com

Changes in v10:
- remove !! at svc patch
- align datasheet register name in mmc5633
- remove reduntant regmap_attach_dev()
- see patch's change log for detail
- Link to v9: https://lore.kernel.org/r/20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com

Changes in v9:
- remove reducated check for ops->priv_xfer.
- improve mmc5633 (see patch's change log for detail)
- Link to v8: https://lore.kernel.org/r/20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com

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
Frank Li (2):
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 585 +++++++++++++++++++++
 4 files changed, 602 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


