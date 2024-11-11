Return-Path: <linux-iio+bounces-12143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF4F9C43AC
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 18:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83371F21781
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BA21AA788;
	Mon, 11 Nov 2024 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DD9/OJrf"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC31A9B3E;
	Mon, 11 Nov 2024 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346361; cv=fail; b=uuU67T7kvVbHmA+lPRcbIEBvTER8RntsnQS366RZAyJoXqEOmLekLQ2e/sqWYomRo6tw2TiLe81NH6wWTYMj9QQ5S5O+HhYPb7r3974miL/qZ0T+90kKEgnI1Rxye8buEIaWk0w+eQD9YyShCtswarqsI0WhYr1RFJVmTlj6QSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346361; c=relaxed/simple;
	bh=AL7GQT+3dmj3cCM9uDw2/MFhuWJloDk1rOWcYbYCFiQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WBFh5qe+8seSRhQ4FhPAfHZzvG1i9daPzJioh3ewDe3s6iuDiTbTUDDrAaoA4LRR/rYHNnCY+MRW/n6BK/BmqI3jUoVNHZbA0LJBHWKZaFofBinOiACKWULVQGDxRHxtkmnW6yLyWxwHwy2Wi2R+ElTDbZceL323CuT25j32DiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DD9/OJrf; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDjqUpNsnDSmos98WFNRjTaeWZdiXOCgJtbuHQTtalEbUqeJrgm5hKRNToP+izeJvHqFZInSRjYUDUMpjMHUEjplUlIEr/H60VcRaWwx8XHIfPQBjol285KaEJY3kIkkcnzhIGS1g99F9DQIBd2iGyHa66dcCOacUanZbTDyPNnAEf8Xp8I7b19MThdWj1evqsKgU7IZOwLEtj0t1Niv8XlExj/MFIfyauhQhQpmOEF+1Jl519Yno57Hp5NJJmr8CqdUZ6y5EAMQDfr+4j70ko/xKaeD8e5RATgmi4raclDzi/qJG1vzN/hPopUHf1abh8ADnxGU5ejzOHz2+LIyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6+K4HUgHzCu+Z5TKBEE2IIRdarF/i4jNqDhpHc9/AA=;
 b=ZjqtXAHqiy97qrBPWeExLQEW+LraPiLIVjMsbRxOlWK+iD4r7n8a1C0r1AsS/ucHH35RM5pelmN8WogNXjqSFoPzeFHW9WKpbptRZ08ZVgJm3Pms1sPJJX/7BaVcMXiWmWaX5TBnNwU4BEK6j/zBBrTKqM/PxtaSroZcxHF30sULclEEkZVL36sr2jtRBsacMuOpt44rehdGvqmoqKwrms0xNW5fnXB7FKMQ17bYqdJcNjdlnHtehBqFBEgk8vPPLwheyH8zzfWQK8+vSnnTJk0tO+BPFHygdftXZAVGW79T1MBRNt5P1aw2h4FqcSVjkA8D6XeG6brCW8fBajK69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6+K4HUgHzCu+Z5TKBEE2IIRdarF/i4jNqDhpHc9/AA=;
 b=DD9/OJrfFhvHcA61MW9iSpRsROsKd2c8aBky6BIx1JhljY3WTytIPh5v3UvypORVSM9dIounpaXoKcG1TR1lODICjsj2QKtZ4n02kdmjgeOd5g6vwq99G0imG+Ci02V6xQtZ98bIsFC+cCihdHBYoHOA/DKgDzkj6YOjfmmW5Pr8rRdxecmYQdj4AX3Man3hk335x2bNn9/G0LEQlFcE6epT0ZjcjBd4ZdvOJSIHB0OwrTnMpjPZmEt8a+AMGNCEPCMg986EjPjHohYF+jv+3RTxuDK0TKjuwd9fD3fBw/GgdHxhbZ9ZADNoswDI8F3bOSInmHcnR4MXM5WK2HUybg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10086.eurprd04.prod.outlook.com (2603:10a6:102:40d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:32:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:32:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 11 Nov 2024 12:31:58 -0500
Subject: [PATCH v3 1/5] dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-p3t1085-v3-1-bff511550aad@nxp.com>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
In-Reply-To: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
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
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731346348; l=1527;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AL7GQT+3dmj3cCM9uDw2/MFhuWJloDk1rOWcYbYCFiQ=;
 b=ldP256BbOOkrK/rMxA9i9w0LMouZVEJ/eqiazplMTTUgGIuIwjD1k97xsCU+LP7pBhKWUCJet
 GTU9rn2vltWDbe0mvCiZ0u1YItdUSm81n/mFtRH7kkJEaFYl2/VoRBv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6415ece2-0041-4d28-7b54-08dd0276d603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm55M0hGengwKzZ5dENOYWRuS2dnQ2xxbndSV3hmZDZOWlFvdGpxcWEwaEln?=
 =?utf-8?B?cDgyU01tc2wzd0VxUCt0SU9sZThsZENXWFo1bGhNaHo1cFZsaVNIVktRb09w?=
 =?utf-8?B?dDI0a1FPeGN4T3p5a3NJVmoxbTNJa0lFVUFFaVZrN2xER25DYTU1M2VSU2JO?=
 =?utf-8?B?bjdjU0hjZjNXMkxKZG5jbUFCR1ZDbk9GVFFCVFd2azRHRkpwQXdKSVJweTgv?=
 =?utf-8?B?eE5NRVRwblJzNVZDUEZ3Q3l0bmVGa0Q1T3BVVXVVSnNZT1BOTzNlNENoUVZW?=
 =?utf-8?B?NmhCcEZtYTlaZGoxV3pMQ1EvK3BSaWhabGFLK0I1YkV0L3grNEJvbmVBWm1L?=
 =?utf-8?B?ZjZwS2lPbDh2cFRhNGJZY1lFRXV1UWFCRG53WTR5T2dyOGFMSm5RbWlBOGJs?=
 =?utf-8?B?N0x4eUhZb0tsUGhIbUFWSCtDWndWekdSTCtxOXU5NEREcUFGTkkrR2oyNEFj?=
 =?utf-8?B?UFNqWnMxYUlHeEVhdUdIV1NLU0ZNSU04dkNpckJnY3M3Zm9nRHhPYzN5UUdW?=
 =?utf-8?B?MTBreEhxQVp1dW4yWmRIL3RzcFYyQngxWWJERVQ5UzEvbklaYUVtY3BObVdV?=
 =?utf-8?B?UVJwTG9EUXcvYzUyUHlMN2xsUm0yeUNTeGNFdU9DT2Yxc1l3TmpmZEJFOCtw?=
 =?utf-8?B?NnQ3MkRqdU9WMk5lUk9LdFlzV3laYUxDbjRSdVdJNGIrT1JyZ2swbWFlVjhF?=
 =?utf-8?B?dWR6M05pMHZVNm5iWmRYZytWWWVhR043NlJTOW14Z28rOGZjbzhGbTIwYmN3?=
 =?utf-8?B?TmhmNTlTZS9ZMkh2VUdCZWVxRE8zOTlUL1Z4SzdMV2dpVGFQbU5aeHd4OHRy?=
 =?utf-8?B?NERFVFQxLzVEU2JlaG9IK3pGd0NhUzVDdFFpNWtOaWZxd1BpVTh1TzErNE9m?=
 =?utf-8?B?RmNqOGdLUDR3cGVmRjd6Y3o5SXFLdnV6dWE2MENyTEF4QnNUWGpIem5XV0lL?=
 =?utf-8?B?QTh0SzArUllNcHNhYTM2bUlmYmJyQW1pUExtM0lyQVRiSWtMbmNEWXVzSjdT?=
 =?utf-8?B?TXZsZllrUGV0c1RlQlZwL1JuYm4ydElJTFMyZml1bFUxUnNCRUV0NytKeWto?=
 =?utf-8?B?UVo5QW5QZFZ5clQydENXVGt3YWNjTTcvKzgvR1pBaTZWano1V0s1V0FXSWRn?=
 =?utf-8?B?Q0I1UWpjU0VISitZWms5a1YvRE8vOGlPZlRWMEwvdDNIV1BKVm9wZW54dmk1?=
 =?utf-8?B?TkhyZGYyRkJaM3pqTGZkZ3dsQ2lWL1ZIekUvNjA4K2t3WStNczBXaENhRG9z?=
 =?utf-8?B?UG5UM2JDOXl6MEk1ekdsR3RCc0VjdFlRL1BvYWgzRmhXUHNlN3VDYURndUN4?=
 =?utf-8?B?YU4zdjZHV2xmYVo5Ym9XaWo5RjVDUW5XTXJ3S1VucTFiaFBLajBQSjdrbGlj?=
 =?utf-8?B?dk1tVWhiZEJDUmZiaDgrNlRTQmpwa3dkb3YvMmFoL3F0M205SXVBUGV6QzJC?=
 =?utf-8?B?OUhDTVBpaHRRb3ZGQjd6dmYwdEN6NzV4MjRaM3g3NlVUQ3pJRytqY1FyUnJr?=
 =?utf-8?B?SWtqNFhmZmM3eFNNbU9BV01LMFc3TnVocktKSXZvdXNwOXp0R3EzeU1vUnkv?=
 =?utf-8?B?bExzQ0x2Q2V4Q1B1Rk9CMmNIS2hxczk5SmpaaGZRcnUvd1U4Ymtua3VkbHBk?=
 =?utf-8?B?c0x2cU9IN0RiTGJtTkdQYTZCeVFhcityUHpNM2J5ZXp0N1p2WGJvV1ozWmU5?=
 =?utf-8?B?amtYc3NVUEl1TWV6aTJPb2dVeXJUc1FKUFNBN0JNL1ZaRFlkQi9RZ2daQ3RK?=
 =?utf-8?B?Vi9SNllvSk4xRFBEVDhpazlWS0hmbUVkV0FDMFJPdkNwbG1qelAzd3pxdW5a?=
 =?utf-8?B?TUlSMG4yc2JOTDRVbmFUdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2hQdHlzMW0xV0FhQkNaSUJpbEVSaXdUWUVaNktFZHhnMk9MVERGRDI4UG90?=
 =?utf-8?B?OTc3TWdpSjZhY0tQcDJFN3VacGM3dERxZkEvZ2ZEaG9UYUVDL1NVQ3hqUk9U?=
 =?utf-8?B?TWowVElQeWR2ZmNCMVRWMzBRbC9lYkxDcXVhMW1IRmVhQk1KeDFxWVRKTWtl?=
 =?utf-8?B?MDRSamRySjd1NkpNY1J5KzhuZE5SamRPaWRBR0Y5RmpDajBqTVRJSmZ3QTh3?=
 =?utf-8?B?SXBXdVl6Y0l2YUlYU1o3ejlGenFtYVI1ejcwSGJZbGRicit0NXdUN3VKWVRz?=
 =?utf-8?B?a205RHVmenErU1RYcVVlRjhHcXZmWVNzelNqcWdBTXN6UTlWdDk2VXdndm81?=
 =?utf-8?B?UFBuVHdRa004WUlHSUJvTE8vOFhlajl0dVpTUWdhU2R6enIzQ0ZXYnNPZ0dI?=
 =?utf-8?B?bDJkV01wbnIyeEE5VTNVQ282MXBaWmpLSUxFcExIQUxXQlZoanBCTmhvZURY?=
 =?utf-8?B?MGNsNENZQVY3UUZaZUQrNUoyZnM2bGs4OE1MTEt3Z00zSDMwQ0x4WEVWQ1cy?=
 =?utf-8?B?WEVZOWVhcWg1MTBOaS8vQXdoUnN1alRRTTNkV2ovNkdjZVZpN0s1K3FvU3Zv?=
 =?utf-8?B?TWtlNTlGSGUzT1BKWWtZeFUyM3p6eTN3RzIzTWVoMDdOK2Joak9acG1UT3hL?=
 =?utf-8?B?ckdXdmZhTERhVWxQNmlBMTRNTHV5Z0hyRmR1N1RiN3FFVVdTMVVvVHFTZ3cx?=
 =?utf-8?B?SWwzbEpyd2lwK2p0SVU0NTF1RndqZUdtZ0NuR3FTNm5ocnVhdmtpK0xMTCtp?=
 =?utf-8?B?eEF4VE04R1MvSlpxK1Fub25PNDhzbksrZldUa2FvR2RrWktWY1lyRmpybWNp?=
 =?utf-8?B?MkZ0OTliRzJybXZreFJiakxkU2t3SWVvR1AwQXJYZnE1LzlGUFJLVnpKK0w2?=
 =?utf-8?B?RHBTK2gyVVNoSXRVd3pZZWFIQVVMRVdtMDA0SmtiT1d3cTlJOWdvVlE4Q3Ny?=
 =?utf-8?B?QjdoTDFzT0hXc2VrbGdCRjNBd2QvUXZSM1UyMG9QM1F4N1BjbTluRW9GM0Jj?=
 =?utf-8?B?MGpQSHRnQUNjRG1NMi9ZcW0rUkNOeXJuVzZHMU1zY3hhbDd3YzlGMFYvdEJz?=
 =?utf-8?B?MCtWUkJvQWQvbVNRMEV1bld5TWdlUmR1M3M2eStraU5DdkhaVmVxNEozYjVu?=
 =?utf-8?B?QUtZU3Q1cW5oOTRXOFE4d1V1dE9lckZ2UFprSVdMVEpvaEFTaW14d1hmVUE4?=
 =?utf-8?B?aWtXOCt2QkNLRklWTklweGhOeWFWbVk3aHo5cU1ES0QzSStEQjA2YlJPbUNU?=
 =?utf-8?B?UjMwWSs5SFFNUFBMWHZ2WkZlZkhGVEYxTGliMitKbHJlK2JwcEoyMEdsOTVS?=
 =?utf-8?B?K29wcThwM253SEdsRzMreW5XczZsWWp3R1QvSVBJS0J0MDBwdU1qWXZzOGhP?=
 =?utf-8?B?RjZvSzRmNGZLNHc0VlZIdk9KTEhleFZCZWtMYjZxcldkTGdmQWYzRERNeGE4?=
 =?utf-8?B?elEwd2R5KzBhMFI5OXBJMFhyM2xSSEI0SUdDTDA5VDN0bDVmdVlaYlJpK1dB?=
 =?utf-8?B?K2cySi8xK2Mwb210LzFudi9iK2NYNTIrdEk3cHpiWGRjZWRzQWQvdHlmK014?=
 =?utf-8?B?d1YxRDVTSGp2T1ZMNVJnVGxab21NV1dOSDU4VWJxU1Q1M0NjcEtTYWlSTHZw?=
 =?utf-8?B?enBtdW1UN3liL0VuZy8yOVFTSjFQak9rRzVxWUd0RU5BeDRpNEw2Mkh1R0JP?=
 =?utf-8?B?SlNKd2R2VG5abEp4dzhBSDF1MXRRR1hreFRKdi91bmxwdWNiUnFEV2hETGNt?=
 =?utf-8?B?cjZUYUdtMTZtemx5Z1V0ekNtVC9NeHhLZE9RVmoxOW51L0c1dXA5cmxqUXNT?=
 =?utf-8?B?bE1jNVBTNTdHYjhaemsxbzRHWjRET2R6bnJ6eUpRVkQwemV3d3JBUDY3MXpL?=
 =?utf-8?B?dkVvQmdQZkZmbEFSZmFwSE54WVFFRWIxYWhPUEZyVnZsMFJFQlFacmpiWHhn?=
 =?utf-8?B?MjFhcUZZSlNCZ0hlR3NNUEFBTThrYzdySk1SOUV1djBiZ1pjcDEwajl5VE9T?=
 =?utf-8?B?emovYVBwQkpYUEpaemFNdU5YMmNyeklEd3lPNU9MRFRLcU1QUzFVV2pPN0VT?=
 =?utf-8?B?UVBlTUFobEJvRUd5M2FuN2lWdHI3K0NuYTRhQmdXTEdLbVhTaWtvSmZRU1RL?=
 =?utf-8?Q?q8niw6AQF+YDbjVakBQUUuT9i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6415ece2-0041-4d28-7b54-08dd0276d603
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:32:37.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPkcBgl30y7hmjSUsKGOgOIy+q+NORpiesE7lS8YVYpJ3otCf0SO98V4ciaq94hMT/GMRy4w4HdU1Ip+FAqlYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10086

The register layout of P3T1085 is the same as ti,tmp108. Add compatible
string nxp,p3t1085 for it. The difference of P3T1085 is support I3C.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
- add Krzy's ack tag
---
 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
index 0ad10d43fac0c..a6f9319e068d4 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -4,22 +4,26 @@
 $id: http://devicetree.org/schemas/hwmon/ti,tmp108.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TMP108 temperature sensor
+title: TMP108/P3T1085(NXP) temperature sensor
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
-  The TMP108 is a digital-output temperature sensor with a
+  The TMP108/P3T1085(NXP) is a digital-output temperature sensor with a
   dynamically-programmable limit window, and under- and overtemperature
   alert functions.
 
+  P3T1085(NXP) support I3C.
+
   Datasheets:
     https://www.ti.com/product/TMP108
+    https://www.nxp.com/docs/en/data-sheet/P3T1085UK.pdf
 
 properties:
   compatible:
     enum:
+      - nxp,p3t1085
       - ti,tmp108
 
   interrupts:

-- 
2.34.1


