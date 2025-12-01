Return-Path: <linux-iio+bounces-26594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AE9C9729C
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8040D3A4206
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF1B2F4A10;
	Mon,  1 Dec 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="A3Y5BFRE"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020108.outbound.protection.outlook.com [52.101.84.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0E2F6901;
	Mon,  1 Dec 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590411; cv=fail; b=qF4hsrP66lkEcqX9eAEO7okni4WDfmzfmLYHZI30oxyh2+xitZt9ozTg+C/IOrKIlJc9ElJpYYWVPdFLXmq82qLjQGAvpCgzjXUTIjQMK2trJzhR2h/8RvhRDq1L1hMZM0tZwZEe/sAbGtDrzyHXykDoDfZ+bcnGJYivLr5gY2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590411; c=relaxed/simple;
	bh=eGytWO50sN+NjeaOJDzT0U2BQBy3KA0fZF5EGeJY2Q0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y+Hlp5D8CldguOjxfxZtY/4+aX5q4VoL4kwWRsbN1IEft1BhPgbYQxERI9s5t0WIsushSgIigHQzRLJSw3qPG3fSaEMeZeEpkBWGL8ktOz+L7BwkUHR3FwNZajn5cLtU1rqTZIj9inIXmiU8c7LVTt7Rzeqg1NVPLNeshizxvvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=A3Y5BFRE; arc=fail smtp.client-ip=52.101.84.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0kex4ZFRFVIcX8k+yaCGG6JdftrduosTWeLI2t9weZL+2RFcDLOHpY+S8YarCXWoqixvUtZNQS6QTXHxuw9R+DF/pHLbKBF8EDyFumIJPp/W1GmiUq7x97Y8SjjWAddabLj4k//CyrCnWcIxW79O70ggpFpiUe5QwHJeLftT22nDym2eUUt3U4kzmtdH0vS62Oo28kkx8dZw+epZJ+T4eEU/kcsF88MRNz9Hg+MXSqOa6ioivptrerLM9RG63VmMuww+AR6BhmNwAj6rUu8nH7PLVywKHiXy0QnbB5TXEhhSaNzvpZYOBe6VvTC0+v2CHaA0//M1wRMrmTCOGuGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0VN+OzBkfQVRbMmsHUyT908NNz/Ll1eFiq9D13hJkE=;
 b=BJLwfD8DondbliuxB/OCOPWENabBpQZfS5EDszxnMVHi3jXHildKvIntWRKM6sA3dGA1yIW2swrWflKjpbV62KEKEET/7mnLMxZaN0lPeInuzZYk+Tm2hC57gu9EdFLFh4oV7RSZyADXUSZGPB6+FLQ32mv/UbZm8dldwxvxY6656ZtxXq0s+Akq6Qs1/gnnL1mRaIAuL8Bi5YXAP0YHNe014ngzNiiofnlabLTfbVofjIw7H4saYhn6z5GiWd7x8CZOOkt/wOpBHm8NZRyJoR4zR2BRIQUFpmX1xeEnN9JBz8DXBNyMfARX0TIrrft7YCsc6Umzhf5cs7arWQK2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0VN+OzBkfQVRbMmsHUyT908NNz/Ll1eFiq9D13hJkE=;
 b=A3Y5BFREVnO4n8HRW2JYtil+aXl1B5k2L/2UWTIFxsD0cgD+Ke4eeln1f+5qfJQcUDVQ9jKdFIXGD6wFRj2yC+JVzoDMJxsaX5N2lgRW0tXywWmfmcCFJqucpxzQ5bJm+M4zVXUmU4bZaCtxaM0CN5GP12hR+qixOAcGs81IM3dT+oK91in3l533HjFvDSYbqEvYhq9IPJAIU70gZTJeTKbqADMStyTNhgYOisLYX/DeIhgcaAtMfr7eTKhKSkQQABexRRyGsRwDJGytJuH4YgXt4ebnhR/Plu8gCiOl0X4svbjg0RPKGhB6F/uHs3qzr8kQcSS+kPoOvl+e1jCYCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GVXPR06MB9203.eurprd06.prod.outlook.com (2603:10a6:150:1c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:59:59 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:59:59 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Mon, 01 Dec 2025 11:59:35 +0000
Subject: [PATCH 2/2] iio: adc: ad9467: support write/read offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-ad9434-fixes-v1-2-54a9ca2ac514@vaisala.com>
References: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com>
In-Reply-To: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764590396; l=4262;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=eGytWO50sN+NjeaOJDzT0U2BQBy3KA0fZF5EGeJY2Q0=;
 b=U9Kfb7L7yNQy9SQq1ruG+Doh6aoxTbYqa5g/NS42G6C2L1y0D7SiAJcg6PQDXeD4hr61gdTya
 2UtoCOzkAAqBHDe3m4WSkAm6lU6r0olfRBAlVspzQDIWBYrkpI+Os+D
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: HE1PR0401CA0118.eurprd04.prod.outlook.com
 (2603:10a6:7:54::47) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GVXPR06MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be69110-80f9-43e2-1cda-08de30d126ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elZFc0hXb1VEUDVobXJHbFFDWnJocUpiMHJmckU5QmRBazMvSjdtNFJjZTMz?=
 =?utf-8?B?dXIvMGwxMlhzTGorMGxTOFN0dFhka2VERFFTZXEwWnBOekJnYVNSbWlINWpM?=
 =?utf-8?B?dE5GSHk4czYyOXp3dThPSllnMXhsSk5ERDNqSHdHS1JrL1BZYXZsK2dmM3pZ?=
 =?utf-8?B?STB5K2EydzB4VEFVNzJBamZWQ1pHeGtpMW5Id05DWmU2OUpVVzlDUlE4N1dV?=
 =?utf-8?B?aW9HWEUzenlkWTFQdHN2Tk94YTdVdllzRFNvTXFWcEtGSThVc0Y0aWpYUkFu?=
 =?utf-8?B?MGlMWWo5S3l4Q00zYjc4OVI4SGNNOG5Nd1RiYW1ITXlTek5rU1A5SkcydE5m?=
 =?utf-8?B?cWdwc1FUU2xSdHJzbHVMbElEVjRCL2Z3aWg0ZGJUeUxFbUhweG9Ya0ltOGhm?=
 =?utf-8?B?cVJRRktxS0RnbkVzVXpnYXpHdkxWbm9YL2daTWZpM2RFWTBJWUNkMUFJQzJG?=
 =?utf-8?B?dVdJSXMvcjZ4d2JuMUFMNklYc2Vwb20wRmdsRjBlQThMVjNrYzZ0VWk5Rmd0?=
 =?utf-8?B?VENyaDRMVy8xeXB2WnJuQUZrSzBpVFVTYWVQdG5NL3lZN2dYSS9MMUlFYVJm?=
 =?utf-8?B?NmdhSWVNU3BPTXJWR0tNUWcrVTRjbnBCekhBUVpYUCs0MEN2K0ZManp6K0VO?=
 =?utf-8?B?YktzZFUxWk1iam9xRHBTZS92Nld1UFlSSUl2bnBoQ25jM2x1d21HdGgxNXRL?=
 =?utf-8?B?MnZLY3AxcTlucTNVZGtBWE85Y3JQeW40aHFhZTJRSHJrb3NGd0ZVOXc2VmVK?=
 =?utf-8?B?a3ZsNisxQXhNM3ZIZGkyT2Vtb3VEdW9xUmczc0RnUXpud252QWlkVFZUMWlZ?=
 =?utf-8?B?THpJUkJFWVV4VjNNeSt1Wk42L0Y5NVN5dWlZQWhaSGlGSUJOaE84U2p4RWNm?=
 =?utf-8?B?YVI3eXZHemdYc2lOQ3NHd3VNTjExOWVQYmxPUmJoWnowRTQ1bVRBWGJoSFFO?=
 =?utf-8?B?VkY0Z29lZGFVMEVncFZWaEFLYjJpV3hjSldMejNnb2U4U285V2h5UEE4cGV2?=
 =?utf-8?B?VllsQmh4VmhUcVFDMkFCaWJzZ1RQZ0dzdTJoU3RrN2pOcE9Vb09RbzBwRzBo?=
 =?utf-8?B?ejVHYlhZQVBQenFKNjh0bi9XVDE1dVVSU0lHUCtEaUFxL3ZjM2k3VEtJMElI?=
 =?utf-8?B?R1IwQjJDUDNnQU41dHE2dDY4NGpvNDlNMXRFeFBDY0YxazlUS1dJdXVuVUdq?=
 =?utf-8?B?TDErNSttYlNXQlJkOUhqcFQ3c2pEVll1R00rNnFTN3FTS3RuTDJJVDBWYkhU?=
 =?utf-8?B?TmR5aXhMV2F3VW41VWJLNHlDVGlnTlo0ZDk4bWtiN05WandzcUk0MmxaOWk0?=
 =?utf-8?B?S005TzVBdHBsOThRd1poWkNZdHZQVnlmK0NRMEZCN3RmUlozTXNRY1hGVkpY?=
 =?utf-8?B?UmU4bEdpTlhISWdWOWpSbC8raXZVL20veGVBMFR4N1lmY2VaWnJNaU1yRWFv?=
 =?utf-8?B?WCthUjd5bWFab3dvQ3FyR2diMW9SVkFuZnRKZUE1NlZoN0FZM2EwMlE5eHd5?=
 =?utf-8?B?d2pndjgxclNIZnV4NTd6ZUpta1VDZEY3Vk5KNkxrWlRlT3V2Z2tZb3dLaVk3?=
 =?utf-8?B?d2RHMm5NVDgxVHMyQ1N6NlJNUWJJWkJTd1NMYXAxZXFRY3FTdnBpc01HM08r?=
 =?utf-8?B?Z2phZDB6UGlBUnpPd0ZaTW4xN3RZc0xaY2RrV2hSYjU4UE5nTFoyendFbE52?=
 =?utf-8?B?VXhnK0w5N1hYTFh6bVdOcjdmZ1llVHczallJaEtVK281RkpyZjBtTUUxSDNO?=
 =?utf-8?B?R1hFb0VBd2dKWjVZTVhiVVRSQ0hRRWdQNkpjSm1mc0IyYVcwSUVic1ZzOHIw?=
 =?utf-8?B?ZkdTQ0svemdad3ZlcGtlaUIweGVsaW1PUzhOWVlsK1VRcDdQQmlQeVJZeEM5?=
 =?utf-8?B?eUg0aFd1QlUrcXRNMEIxMU9OeUpRNXNRazJ2cUZEa283R01NS09qVXV0S2I5?=
 =?utf-8?B?WW02cHp6eDZYR3h6QUtJTjBRZjF2aTNqWWsvMnBUTDBTTWVGRHlmeGVjMjlQ?=
 =?utf-8?B?WEd5U28zU0pvbDJHV2h5TnVVTWtDRURMekVmVmw5WEkrR2MwZm1LUUFHU0lJ?=
 =?utf-8?Q?AmFP5G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enN3THdDeTR1Lzd3ZE5Ra2xLY25SdHBqOFRFN0MyY0ZYaGVwVkJ5QTJPWW8y?=
 =?utf-8?B?MXVCWnBVVGlRbWxIdFFOdWdhVlNIajFzejJjL0ZBNHVaQ1I2MlZoS0xSUUlS?=
 =?utf-8?B?UWdyRm9tWHBPWDNNTU5MdzhQU0ZGR3FSR0lXSmo4eGU2QXN6OEdKbEtyeXFt?=
 =?utf-8?B?bUc4WnAzcyszRWZUcE1kRS9QWWsyZ2ZyQ3pWOEFGNk5PVGg0YXlmUERZZlJn?=
 =?utf-8?B?ZXZwdmdUQ3k3UEdISXp2Znd2YjRzMUtPWEZiYnRaSml0RTRHWHVmQS9TeEVP?=
 =?utf-8?B?dmlrQnRsZ1dNL3grdG5mQTNoamt1M1M5SlhzMHR3ZUNpaENxbXlUS05nWmV6?=
 =?utf-8?B?ak43UGx5RVpCaUQrb3BmZnQ1Z0FPMVhtMmdMaURwMURBV0l3eTVNc05rejhX?=
 =?utf-8?B?cExrOUxDcXYvMWt1d2k3N3FNelI2WVpJcHNxYVppMFpnTVdaOFkrMTRlSm5v?=
 =?utf-8?B?SDF4MmE4WkpqVGpPRk9lYVpSTWtYcEdsVzhxT3Zoak01YnZib0t2amxMMmNS?=
 =?utf-8?B?eTVWRkVsbUx4T3Y2U0VGQm1PRTRBb2toSW9DVmk5bnJwNzRpQmJzSTFrSlda?=
 =?utf-8?B?M0lOZmRvRnRwM1YydzZoR01tYlY0bFR2VCtoeFNyQTU1UkxGZmlvZ3hPZXZD?=
 =?utf-8?B?YlhOREtDeGJKYjBDeVJTdmJTbGpGZ3VqWlpNaUt0NTJWZ2RibjA5Rzd2eEhz?=
 =?utf-8?B?bUdid2sxZmdueFFMSEs4eGtJcGhLZEpOQ0dwSmlDZkM3T3NGMFRFSTd2bW5W?=
 =?utf-8?B?RTBuNkYvek9YUFN5a1dyLzBhbVlpVmJXcG1YbVlMbEU1ZG0yZXJuczYyaVRo?=
 =?utf-8?B?c1NQZG9sRE8yd05ZandRUlVKQTRaLzk2TS93WC9WSGUzZDVCUm5abmhGb0hM?=
 =?utf-8?B?Q083bzJzcS9lTDVXUGRTQThqblozR00xcXIwNGw2Q3JnVk5iUWwvU1ZkZnhM?=
 =?utf-8?B?d3NmZHZhRkxLQmdtc2FLc2FkRW9nUHVoL2tKdU1nd2dDajJhQjdoVXhxTFBO?=
 =?utf-8?B?K0pQSEc3bTlwQ1hkVnljZlpPakpSbExCUWszRy9FcDVIdFZMU2l0ZTNHZDlx?=
 =?utf-8?B?UFE5YzA5RVY2NWNNeERXOUNpMVkvUERyZlNvZWF2NHQxSVN3VGlMSTNreEcz?=
 =?utf-8?B?VGViNzdTQitSbFJvWCtwNGhiQzltMnFsS1dWcmRieEEzMHJlejZoZXVuYkMz?=
 =?utf-8?B?NVZWbkordWhFRU9FU1llcSt1Wm1xS0djL2cvWlZhSnBabk5lcUpqWlptd041?=
 =?utf-8?B?YWYySFB5cXVBOUVnOXYxTEU1Z2U3Q0Y5YWpLRTE4WHhsYkRuVGFRL3JiL0l6?=
 =?utf-8?B?WFVpa294R3hEbTlvWHR6YlFXd01oc0Z5UGx2TEZmbHV5aytjR3ZCUWhwQzMw?=
 =?utf-8?B?WVliemJPaUdtL1lXRGUvY0dwRFRmaElFL21IRzc1V1NSMWJiS01XZ1lhZFYr?=
 =?utf-8?B?ZDdoenpaNThpVUg3c2dTZVJIQ0V3djJHb0ZxdGdTRUJuZmxtYU1lQVgyOW05?=
 =?utf-8?B?ejJtaEVKMWdrcVFoN25uOGJOcVA3eThveHBMaWVFWGZadFNoMmdZUDBldWZB?=
 =?utf-8?B?SDZzVEhsdjNFRDRYdTVsejZvSXhPSFNhcWlEeGVISXlvL0w0amlKWEplNnpF?=
 =?utf-8?B?Zk1PQ1ZKOWZpTE80SC96NVhGNGtNRVN4QjFxdHp4UlZOT0MwdHVBWkFsQnV3?=
 =?utf-8?B?cHZ4ZUE4K1UrUStNR1Z6dnhsbnZDUEdvbkp6YVZydXpQWmVjdUgrekhsR2xQ?=
 =?utf-8?B?aWlLbWhMYjlFaS9NWlpUaitkOEcwV2h2YzBUM1FDYXNIRkJ5RG9HY2FreVRo?=
 =?utf-8?B?TXRVblF2Skk1emZ5QmNVZ3h5VHIzb29qaHJ2WGxiMTVacjJlUURxZUFFNzFT?=
 =?utf-8?B?MVlab3Y5d0dxVEdpYnVDOEhwNC9TekphM2hkU1JCK294amVwU3lnZFBuM1VV?=
 =?utf-8?B?eWd6c0djN2x0M3NzTUpDb3JQd25KMkZFVFh0RWVBbitsa0JIcHZyVUZBak8x?=
 =?utf-8?B?MFdpaGJJR3A5cnFSTDEwU1hpYzVvK0tqUG5qbXhVMEJ5ZXRXUFY4TnNOak9E?=
 =?utf-8?B?RVJ5WC8wZnRWK1I1NklzS3lRN1NBZzdzQnpQMER4dFNES2s0RlhDYUNSaGE1?=
 =?utf-8?B?TDhuMVJ5bUtLejlTQW9xRnUxRGtHcy9LdEVKOHVnckN0NUZaYkMzV01XUzdy?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be69110-80f9-43e2-1cda-08de30d126ac
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:59:58.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Io2gnXWCAttTAO9HX5ALdNtQLiMLP0wsjgtyqT4b70+BWllrcOww+AY2+SJbp7Q/4mHiZWu/5BsEeVdEeGwjVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9203

Support configuring output offset value. Among the devices
currently supported by this driver, this setting is specific to
ad9434.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 2910b6c5b576d101a25c0b5f0fb9024f0b4da63d..41b29e9e765b4296358bb277d63993889ce46290 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -145,6 +145,7 @@ struct ad9467_chip_info {
 	unsigned int num_lanes;
 	unsigned int dco_en;
 	unsigned int test_points;
+	const int *offset_range;
 	/* data clock output */
 	bool has_dco;
 	bool has_dco_invert;
@@ -234,6 +235,10 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return 0;
 }
 
+static const int ad9434_offset_range[] = {
+	-128, 1, 127,
+};
+
 static const unsigned int ad9265_scale_table[][2] = {
 	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
 };
@@ -281,6 +286,23 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 	*val2 = tmp % 1000000;
 }
 
+#define AD9434_CHAN(_chan, avai_mask, _si, _bits, _sign)		\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = _chan,						\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
+		BIT(IIO_CHAN_INFO_OFFSET),				\
+	.info_mask_shared_by_type_available = avai_mask,		\
+	.scan_index = _si,						\
+	.scan_type = {							\
+		.sign = _sign,						\
+		.realbits = _bits,					\
+		.storagebits = 16,					\
+	},								\
+}
+
 #define AD9467_CHAN(_chan, avai_mask, _si, _bits, _sign)		\
 {									\
 	.type = IIO_VOLTAGE,						\
@@ -298,7 +320,8 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 }
 
 static const struct iio_chan_spec ad9434_channels[] = {
-	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
+	AD9434_CHAN(0, BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		    0, 12, 's'),
 };
 
 static const struct iio_chan_spec ad9467_channels[] = {
@@ -367,6 +390,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
 	.num_lanes = 6,
+	.offset_range = ad9434_offset_range,
 };
 
 static const struct ad9467_chip_info ad9265_chip_tbl = {
@@ -499,6 +523,29 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 	return -EINVAL;
 }
 
+static int ad9467_get_offset(struct ad9467_state *st, int *val)
+{
+	*val = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
+	if (*val < 0)
+		return *val;
+
+	return IIO_VAL_INT;
+}
+
+static int ad9467_set_offset(struct ad9467_state *st, int val)
+{
+	int ret;
+
+	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
+		return -EINVAL;
+
+	ret = ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
+	if (ret < 0)
+		return ret;
+	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
+				AN877_ADC_TRANSFER_SYNC);
+}
+
 static int ad9467_outputmode_set(struct ad9467_state *st, unsigned int mode)
 {
 	int ret;
@@ -802,6 +849,8 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
 	struct ad9467_state *st = iio_priv(indio_dev);
 
 	switch (m) {
+	case IIO_CHAN_INFO_OFFSET:
+		return ad9467_get_offset(st, val);
 	case IIO_CHAN_INFO_SCALE:
 		return ad9467_get_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -836,6 +885,8 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		return ad9467_set_offset(st, val);
 	case IIO_CHAN_INFO_SCALE:
 		return ad9467_set_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -874,6 +925,11 @@ static int ad9467_read_avail(struct iio_dev *indio_dev,
 	const struct ad9467_chip_info *info = st->info;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		*type = IIO_VAL_INT;
+		*vals = info->offset_range;
+		*length = 3;
+		return IIO_AVAIL_RANGE;
 	case IIO_CHAN_INFO_SCALE:
 		*vals = (const int *)st->scales;
 		*type = IIO_VAL_INT_PLUS_MICRO;

-- 
2.47.3


