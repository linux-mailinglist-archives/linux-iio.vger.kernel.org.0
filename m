Return-Path: <linux-iio+bounces-26673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A8C9EF74
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 13:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36F3534889F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16B2E7659;
	Wed,  3 Dec 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="jr3TLZ2r"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021103.outbound.protection.outlook.com [40.107.130.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CC2D7388;
	Wed,  3 Dec 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764764476; cv=fail; b=cKn+BRaFg2qMNurdn1xIQVCQILVkNJPtKGYueCYCvM9PExs5j9qfDHufe5bKztBiUDn/eOYbVxMVxsrkl7ovHOXskDE8l1XaGAJV1CLmNqsfNoF6ja6gUX/IX9L6qM4pec04Tt6nsopKnQatBuUqVRvtjez8MTktlkHsIA6Topg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764764476; c=relaxed/simple;
	bh=Jox18+41/B/ZBphFDiC3gcQ3nMRBxyth4vBMscUvNXQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bLfcWtTKk5iH7nSMi0cw7QPuVOxG6ZtzN/vUCOVSf9ajwDuenvkalj+7jJXHnsvmH9dDwl0wcNKXx+jWGOIpibB+4lBDdG+DUTx+lv4tfn53Nfzs6GQ4pdF8I8Wl4+S/5zoTW5r9gnC7kTjqboRNATecSREWPxWXYJTag/p/yyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=jr3TLZ2r; arc=fail smtp.client-ip=40.107.130.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODAYdlOaqOT7/iAFpVgaDTbzJEzfjyWvTeYMRdcAvDce3HWriFJmPrcO0PCmU8xsDZ4pLhzMztw5l6DMflTdDLUVsfVCnZ9TntoXNXaj2E2fA7wnZPnapP61vYoKZrJG0K9CHvwwQ4J50uvfFe/Zp1okDwoygUZHlNy8iBNuKn8HuYac+xU7OdXn2JN8ZX5i5FpQNdCkZz2hTAINnplv1Tf2PPXIaDDPppV0u+e8Bq09f04pu/UChjZJX7/081eteqFJUnm3fPXET5kiiLt0HJZOBREPzccEsEHu2czHI5oTwW9cLrXcTijmw9/Ckx6s+Sg1T9FLLdWlUCoK78HdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkTOTxGlm+c2jT8JpmzwXO5vZmE30k9aEI7/ImoyP1Q=;
 b=tBHTWtL+93zENnj2anXuS8GF1/JZJwr2jlkHLPc9YX7idQj998aAuLI37dnmP+tsO0HtIbQOyQm5G9aP1PJ1XN9ViH5Qzw7iaoNBJ6Z1r/MOZ/HZJG17m6VHQIJkdEXkCzuDrGguKCGFu0o+jnKgP/cUtx1wLfk1MM8YeDOloP7cqrrRimSQxK7hgeXGb2JhXh2ibaevdvhb4ouAru2Q56K8yZx9QdXhOOdd/QNJTQTC5j9IFCWNNFEFIQReP2GBlnEw+u/z+H1F2TvjIQ50GUANBdJEyzfljBwWpuk8mR0LO8drdziCOr1QnuTMcNkl+sjkHzYUB2GZdTyt+JwERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkTOTxGlm+c2jT8JpmzwXO5vZmE30k9aEI7/ImoyP1Q=;
 b=jr3TLZ2rn7p/tEpNy8A/fg+9wTPWtemcA3trNgfUYthNrAbDws6vnD+INUAoM8OcXkTpRgakOG0vJ4TqI7tVreVY+SpogMD9gH8OJP43uEf520Rndn88CQebZVyq3T22T0Qo3Eaqoad7SNJ69lAF2KVHCUEm174haZfaUrsFj7+n1FR0CGbpDFF3/0lcbldWX7iTZDgl9VW2mCCF6PxahmvPpVQZH0Qm4ysi2jTiGqNap5xzm8rQENP5C1LwYduIe7CnTd+RwvuC61gAwboRd3xmsO1A2BsT57bsLuh2PN50gW8n4XpH4onO2FWfMlfisoeQD1A1S1M8DaPq85OMig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DB9PR06MB7257.eurprd06.prod.outlook.com (2603:10a6:10:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 12:21:04 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 12:21:04 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 03 Dec 2025 12:20:33 +0000
Subject: [PATCH 1/2] dt-bindings: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-add-ad9211-v1-1-170e97e6df11@vaisala.com>
References: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
In-Reply-To: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764764462; l=1286;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=Jox18+41/B/ZBphFDiC3gcQ3nMRBxyth4vBMscUvNXQ=;
 b=5aL/+zRFi0yOyTKgUQzg3Kl2JJGlfoJhKS4PMgVI8fXEhzoDGKlI83iFRdLeUxhCRJVVLWHBx
 Pdyx4GZn498C5728XY+synK9ZACFtXf4HMineXThRs7EpVKcMSFRKY2
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVZP280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::15) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DB9PR06MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7040e8-6282-4491-be4a-08de32666d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUZESEpIT25LbTZUTCtMUEhDcjF4RGkvalFwd0tJdmE4dWtzMjJtSzUvclQ5?=
 =?utf-8?B?TmpJdGNGRUs5Z3BlM2lJSmp3LzdpeVpidmtvR3F0WkNSaTVnWk4vM21iOC9E?=
 =?utf-8?B?RGVXbVRNMDJ0U1oxaDJyZWRNNDRWMGZnYVlacXBJTk9CVkU4WmJpN2FQWW05?=
 =?utf-8?B?OENkQUF1NkRGS0xGWjRsVmFqRmVxTXVVNERTK2pYeGhHQ0dnenJrUFVqUGYv?=
 =?utf-8?B?M2xpRDl4S2VuTHowWXdGSy9MbkJrNTNIcDF6NG40SlhvNlAvcU1KV2VZd0dj?=
 =?utf-8?B?R21qa0MwVVNHQUJPWmFHNjZLdkVORzJKbW1DUWtVYi9xYXQ5SmJVMW1KZGJ3?=
 =?utf-8?B?OE4xSFo5V3JjWjIrWlRrV0lOOWI5TkJVVkxCTjNmOWh0L2RVOWlaKzExSlFW?=
 =?utf-8?B?SVFjR1JqZ2ExQm90WG5BQnI1YXRMZVdwSXpoYThUL0hablNWMU5FeTluYUpO?=
 =?utf-8?B?NlkzRytVdW9qZnd2ZDFlc0UxQys4Nzl3MjVsUVEvRVE0aUhld1FzYUwyVXp3?=
 =?utf-8?B?Yk8xbXZsb0IyYy8yZ0lDUmpsblNSeGt2TW1aM3BDaG1VVkpHRlh6NUh3ZU4r?=
 =?utf-8?B?dDdPeVZRYW13OFVvRG5sOUpPREY2TFRiOGRhRktOSEFrTFAwQTVJTkZhWXNu?=
 =?utf-8?B?bFVzL004bktQVXV4R0JCSk5Ra3ZUc0lsMVZYQ0hTZ0ZZV2t6NE5uOVhtUkhl?=
 =?utf-8?B?OGdBbjZYdzhFN2pER2lKODFwZ3laUmM5Y1dCMkVsTnd3czBpUGRXNXJ4Q0U1?=
 =?utf-8?B?b05mSUo1OEoyNDRTVGorRVU0eVpRUVlIR1JDSkZhUHVtT3VJTkcrMFlCY29D?=
 =?utf-8?B?UTBaQWlodnFQbkZ3L2NnM1FmaU02dUNRUE1xdnBBSjZNbndQLzRlaVB2RU5u?=
 =?utf-8?B?dVRsNUdSdWFPbXRNLzNIWS95VjNzWUpGSGw3bzEyZi9CdXRsMWRZekhiKzBP?=
 =?utf-8?B?WkRIcXp5Sk45bkUvb3pSYUlPaW9nTHdXMHdnUlJRb3U3NTkwTEZlWG11ams0?=
 =?utf-8?B?TVJ3Tm4zdlFiam53TG5odC9NTjBRdkZJWFcxN2dZMloyNS8ySE5YWHBTYjFD?=
 =?utf-8?B?aER5OWlSdDV2RTBxdkFqQXZyM0N0TUt2TTdINVlPQTN1dTVXUG5lZkE4RXJJ?=
 =?utf-8?B?WkRJODRqK1ZHSUxZdk5lbHM2RUtiRXFzSUFWWXVBSjNna29oOXRTU3F2TlNX?=
 =?utf-8?B?MXVvVEtoTjZDV2RxdnM0bWpwbk56eW43QWFlQ2FNczkrakFXOWk2ZmduUWU5?=
 =?utf-8?B?N1o3aEJndC9hMDB4YUduSWN2OGlHVFc0dTNPNWhNdWEzQWJ4OEk0aXZUMUh6?=
 =?utf-8?B?Q2YyeWpzZEUyQ2JVRTJmb0dDUVNKOSsrRXRsRHJBL2p4SmhsZXdaQVFET0dv?=
 =?utf-8?B?UkNya1dWdGhGTU40OWtUOC8vbHRXV0c5OUN0TlRJNHBjRk1CakZ6TXZCTGQ2?=
 =?utf-8?B?aHBCMGZXRDNOQ0c2Q1dWaVRyblY0ZGxWV1FocFd0M0VtZTFJYXRXY29aRUN2?=
 =?utf-8?B?S3dIaFovcWg5V2s0VDVYVk9INzBYZmQreHd1V2ZXL2E1bEg1NXZsd0FIN1lF?=
 =?utf-8?B?bktQVTlMNlhrekxsWkdxZEdMUnlHL2RLRFBya3I2ZFpkR0w5YVE4V1FUU3ov?=
 =?utf-8?B?clc2OU1kUkdFaU1NVjZsUFhId2I0WUE4Tno4a2Z2Tkk1bTRsQTNYTDI2Ukhq?=
 =?utf-8?B?cFluaVltek9YS1VCcVFHN2hySVVSR25RNlZSQnhjTnJTTWN5Q0lNMW84bHM2?=
 =?utf-8?B?ZWIwQkVOcVBHYUV1RTgwb21NZm1QOWE5R1FLTEZUL3A2RHV6MzRCWHFzT1Bx?=
 =?utf-8?B?TUI1aVRNL0RneXRjWjV0aFpza1pCK2g4eENBY3llZFBiVGNsWCs2WGFEdk03?=
 =?utf-8?B?bXR3NHBRVGQrZ3UzMVJTc252dHdTdC9FbFB6NEJJb0gwUk1Ea01SQ2Npb3oy?=
 =?utf-8?B?RlZ3Z3R6S2pNcjZRQlg1SWM3MzIrUU9UTmZiaWdLYy9BYk1EM29iRTdEdTV3?=
 =?utf-8?B?QXRjeEx0QkNyREQwcGZJNy9SVGVVeU9vNUNFR3lDaEcyRTQrRUUybHZ0V0hh?=
 =?utf-8?Q?P37qud?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlpmRm5kYzczUm4wM0Z3dXpmeVBKcnB3bk5zOTVHczcwL05kczhVb003WTJ1?=
 =?utf-8?B?Y0s3U1ZKUnYrSUc1Z2hwSHZNYTFEQmRRN2dTWHZXTTBKVDFoRDJQUHJaUERV?=
 =?utf-8?B?T0MxbHhlS21VSVBQQnI4aExZZ3VQT21hZ1JmZjVHRjZCUVFXRnp3NWNNT2Nz?=
 =?utf-8?B?V2NhVUJTMUd4WFBlMFd5UmduWSsyT2FOblpXV1E5TmZHa201WEptbEZaUllv?=
 =?utf-8?B?SzVyOU1ja3lNalJyOG1qRk9DK1E0RjJUcUlmWFg3T0RVc2NLY2xHM1FweDRT?=
 =?utf-8?B?R3BMNUVscTlOUE5jM1dJZmF0YUFNV1dLMVFPdmdBRTlJOU1Bei9JekVJay9o?=
 =?utf-8?B?SVJXRmJYOVZsbHVIYmtqMW84dDl1M1hDeWdKaXRYbzZLTHZsUTVUT2p5Ump4?=
 =?utf-8?B?VjR1anJRaHBTOFlzUGZHYUtOMUtYMkZpNHh6TTNpcVQ3L0VLa2pXL1NaSm1K?=
 =?utf-8?B?TW5ER0g0Z25mVXpBaUUvMlgxMWg4VVI1SXkvQ3ZvcDgydEo0V0hQdUV5a1ly?=
 =?utf-8?B?azNJNSt2RDBCNE1KMGFWNmtxR0pJODFDazVSRHB3OXZMWEo1UHh3WEhZTkhk?=
 =?utf-8?B?eDgxQVFxSXNteVBZbGVBdFJLaFpkTUE2N3R1bDh0MzN1dXlKUXNIdHJhUnJi?=
 =?utf-8?B?VFdveFNwSktSS0FqTXBvaUJGV0VGdFZ6Vkgwc0JPMi8xY0x3eTJsL3lrZWd5?=
 =?utf-8?B?NW9RSkl4VmpyZ3hQUHFRVWpmcmVaTURYclNjMGlJakxYbzdoQlY0Q1ZRcExY?=
 =?utf-8?B?R3JUL3VxREx5dnU5YURzUnlCRFBncmtia3dYVmVmSm9SQTlpVVRQUituMWFT?=
 =?utf-8?B?TXZ2aGk4QXNxUU5SbWI2bjNDOFZwZ0UrdFA2azRYdWNKeklRdXpHNzVIZlBY?=
 =?utf-8?B?dU9FbHZuL1RGcXNkUFl4S1BXMS9JVGk4WHlwZ2lmTVAzZDczaHY4SDA3anV1?=
 =?utf-8?B?NVpzRXBISHlhbzh0bkNjQmFjNmdIMURqcjcxa0JxZmVuRFdRcER4RzFzQUFn?=
 =?utf-8?B?eFNrREM5WUxySkVPRHBWV0hYRitWempvT3ArRDYwMTZoeE5Eb2ZnZkhnY294?=
 =?utf-8?B?bjBQcHprNW5kZHpxZ0xoMVFzZTZ0RmhYZ3k4a2F3aTZ1YmpWZFE1WDdJamlT?=
 =?utf-8?B?VFo0UGJGT0NwZWtJNWprbHhSU20va2ZhMUw5dzBRb0NHa214UGdRTUR0cko4?=
 =?utf-8?B?NEt4blVucG9kbGFSR0NZV1pOQWdKSHBTekwvb3p6cWRPWnM1NGZXSHNjenFt?=
 =?utf-8?B?WUgya0ZQSksyU3ppWHNoVlEvQlcrZ0dkS1l5aVJ2Ty9paHRXZ3Z4dlNqTUNO?=
 =?utf-8?B?bUVORWdGUkJYMzU5TEh6emE4ZUtOK0thUFhVRVRCd2dwRjZBUEVYL2VuK2pH?=
 =?utf-8?B?eXY4MHJmRnIxTGZabHRydHNZZnI0V2xZU3FQeDFLY0o3QWt4eThtOVdEWElM?=
 =?utf-8?B?M0dKbVo2cW1ZQkkrL2Y5N2JPYnp6cjkvaEVjRE0vUnJ3UlpBQk9XbUdXaFYv?=
 =?utf-8?B?dGNTSk9OWmZ4SFZyeWRnSmZEcEQ5YlJqZGliQXA2YTlwb09pMm9CNXJnWGFp?=
 =?utf-8?B?VTNQaXk5Z0M2TlZEa0t3U3RNNnRRWEFyMU8rVGZKelZsa0hFWVEyOThhdGUv?=
 =?utf-8?B?MjYyZ0RxVXAySVJGRG5yc1VSSlQ4QWFENjRMOVVTd2hCV1BhcUNXam8xeEJH?=
 =?utf-8?B?S1h6Yi83aFplNFFDaDQ3Y0wrcUxsZS9laGVOOUhtNG9yV2pkUS82N0VwcXRu?=
 =?utf-8?B?ajU1OU40bDJiTVVhWlRpNUFEM2ZDd1lHMU5CNEQ5K0x1NEtoRmpabGRHK2pB?=
 =?utf-8?B?ODd5Wm4zaUNra3pRNGIvb1FRUkFUY0NjdnlKMXZhSzhweUF6S3RFdlFEM2VH?=
 =?utf-8?B?NDYvMm10STJiUWhDVk01N0ttUnhBZm9CWElCV2dGMnRrK2NyL3VFYVQ1aXJr?=
 =?utf-8?B?SEEwd25nUTI5NkJTdWlxWXVyOTA4c29OL3VETnFOSm1Tc0lZUjRhcURQZHdN?=
 =?utf-8?B?SmpkRTVLU1FqQXc5UWx5bEZHamlCT2VRdmNUQXJzNkVva2tveEFvTDAwUDRO?=
 =?utf-8?B?T0FVNHBRSnRwU2xTUHRLaWp2V0M3NTJIQUhQTUNhakVFWWRJRGpWY3RWZngz?=
 =?utf-8?B?aXZ0UXJ4dkQ2MFFCRFY0K0REcG9jUkx6UUtrS3NRSGRvUFY4bVZlVklYZnBa?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7040e8-6282-4491-be4a-08de32666d94
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:21:04.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4dgsShFvcH8RqlN7bC1OELsUtQn5DngmryaUAtkkA1xfF3PQv3kl0DKPECsowKLjABb5TU1W5t+L4T3rYYO3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7257

Document ad9211 variant as supported by driver.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 2606c0c5dfc61fd65cd0fb2015b3f659c2fc9e07..5acfb0eef4d5cf487adaa93ce5bda759bb4853c9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -18,6 +18,7 @@ description: |
   All the parts support the register map described by Application Note AN-877
    https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
 
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9265.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
@@ -25,6 +26,7 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad9211
       - adi,ad9265
       - adi,ad9434
       - adi,ad9467

-- 
2.47.3


