Return-Path: <linux-iio+bounces-26593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD781C9728E
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 13:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D28874E1C7F
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4CE2F6597;
	Mon,  1 Dec 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="thTWzQn5"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020108.outbound.protection.outlook.com [52.101.84.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454512F6169;
	Mon,  1 Dec 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590408; cv=fail; b=PQySpIbf4fXa3F7QOj5cCEB8QCPOH4QVEe3ZbY1QTsJsYTfLoIkJcldGnESe+dA7IWFDttiOtyfKp+yB36odOpFx3Tr1wDuZ2rDIq3dPVkD88y+szUDteBvjrfNc7WGLmkaDTG4XOkZzrGECEn7cGf5gdxYJktthfx0w71dRXbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590408; c=relaxed/simple;
	bh=204+Yz+5xMgytFHds7rw8ViqMxuvDGBs4sEiu0ZeY4E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q6XXT2vmyqsZwE29IaB8KSOJE5We1Skh3HT1RqIqNiIdnA+DqiolOjtHMDcRu7fMZTB2CXs/8p/uZBFHbcavGXKAX8VslH+dRyshti5G+9gQXL7pn44ZZGfLGfaXL2HwX0+v9hUVrcZizdKAJ5ZjCUQErCLw1CpUpUgP05RcsEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=thTWzQn5; arc=fail smtp.client-ip=52.101.84.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKmORCta5x8ritU/hoXHK4JE3iJW4uWBun4lpioXWdmD40NmaEaEwbKkCNNFMb3+tC6t3mllJ1007nTNxFwOd/EsvL84+SatrD7RUPVPQ3dzKhv8wl49Eqij27LBuNbwI6I7k20Scy6oTbTeHxIW8tCRU8Q1/h2t+G2djOQP5jPQqHmU9YYcibRlcyBsgnHlN935HakORZhaUI8OhL9PG0fGnJaKu/OR7Dtj6+Zf7C/lD/BPn6d/4bFgS9JD6khKh/6V50hb3bBe9McWzjhrgjvxPz2rY1jwlBza9anMyzLXGv3/E1P2nZTLpV+vOMAZBFHXlCR7ABo//1arva34fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sEdZmaUGhtc/6yTzEpyeb6jN8ErNNGDqMW1XfQpGt8=;
 b=Jvh5MxVzZ21AhxQKnXz3PnZIPZ/s4VzKxYVMDTt3fK67BjNi2XQPtYoCvvOEBbtyuiJKaX1bEGpOXUb+W1ynLTpMzP1gyHBKiYc4dhm8RVpZp7UJfbn+dSSpVPQzzk8DUsrNecMvWtqkrN9DtaXvdvgne0f4xWNKQs8r/m0DHBdsO/zNlkn1GE0pwiE7o1EzlZ+DB8qqhheiEjg3VTv0QlOQiPvoN6MaSbREHAl+5DQXZfLEco2/wnfQ3++HQ1+n8osD+7MbiyG6EcS5Hq/zOKB69GAQJIi+xriGdpVZrDARIX5xcgEtBS3zUHN0ScdV9ZGf+h56oeOmIunhMWbXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sEdZmaUGhtc/6yTzEpyeb6jN8ErNNGDqMW1XfQpGt8=;
 b=thTWzQn5ObPFDDCzfZ9/ISUWiXLyMJmg/4dhrXxjsEq5Vp88Aw9vx8LEg2WSsBX7W4CpWwPI7QhHZfkFEu8f+VT+Kkxjgbzt0ztxMe+hWU9wB5FchNRNYXqo1YQesxnMXMWk/oShycT8VhKsand5jLKK7lXBi5tSRTzd6kYX6Si1Gsyhra8Ts1nnUz0AKh0HN32Da7+tHVOqWNZpMrqarzmYUIDKk3Ly1TOuEqFFmWEDLRIjh96ErAIxIPe3QfThPbiiqgmIY8EgLSyoMr+ux7UpAJ2kcsSRsrpBwYv6N+o1mswmcX3rKTyGv9mVAa+yrUxISSB6FGls3cFP39ZZ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GVXPR06MB9203.eurprd06.prod.outlook.com (2603:10a6:150:1c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:59:58 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:59:58 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Mon, 01 Dec 2025 11:59:34 +0000
Subject: [PATCH 1/2] iio: adc: ad9467: fix ad9434 vref mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-ad9434-fixes-v1-1-54a9ca2ac514@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764590396; l=900;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=204+Yz+5xMgytFHds7rw8ViqMxuvDGBs4sEiu0ZeY4E=;
 b=p8OQ0QZaiXW2s+E+rpIlXKb5CrIelVZ+mhIs1Rgv2X4r0wp9mIbEjtAbYcrGa86BZNbd/L6qm
 EY7TdenaGvCDiuedMlHFSHY3GLjZQPEV4xRGoyQfEjwnutHOKxbpAiT
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
X-MS-Office365-Filtering-Correlation-Id: 17e4bd7f-3744-4f1e-ca9a-08de30d1262b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGJkbVdvVGRMQVhPRk1PaVdYamRoWE55U1VqR0ZQanphSDNBMk5Pd1dxUldR?=
 =?utf-8?B?aHJBazZ4d1hobHRnMS80TElFNEk1cTVOZS9zZ1hkazlSSXpaMlIrWFp2dWlx?=
 =?utf-8?B?WTlJU2ttZFZIaHNMV2VYNk9NWkI3clRjNHQ3TndidmM5aTVKYVhzcHVsZEF5?=
 =?utf-8?B?YTlvVlhTUU9qZ2pXWHBGclZXK2FOZXptazljSDd4dGJDYWhlYnk1aERSVjZW?=
 =?utf-8?B?bVNFSXRMQlZKU0VTRkNFSWJYNXRvTDBJMHh1NHVrOVpSY1FoOXFCOFM5aTRH?=
 =?utf-8?B?UjdaemJnYXVYSXFDVno1d051ejhETkZic2kvNjhIZVI1Y05KclBSQ09TRWVp?=
 =?utf-8?B?WHZCcGJHbWFmaGJVQ0RmQ2xucG9INEFEeldieklBZVRpQjJ5bHVWZE1vQkp0?=
 =?utf-8?B?LzhtQWtKOGh4WENndkxJZ3g1V1daZlE2UkVFNksvelREMGZuT2EzSExwZEFW?=
 =?utf-8?B?NkVVdUFCVlYxdEFTOSs0b0JMVmI5Mm1XMGozeWplTU5iVEFWamwvMGNDN0xt?=
 =?utf-8?B?U0xyd1lWQXExUFdYSlpZOU5xOVFja2hpeENIWFZ5L054S1M1YmxKQ2xwWHVP?=
 =?utf-8?B?dExlNkM4ZzVNcHBRUnVwbjVleGswRGtmQWxzbTVjQTZhdFB6dXFvdk9FTVNN?=
 =?utf-8?B?dWhsQUpiTmZzaHJCUVlPd0lQU3ltOC9mRC96OEhoem5RN3NhM0dNT1hUM245?=
 =?utf-8?B?QkdraGRQOUZqWnBVQUxRU2FJRi9sdmdVa2labzJlR1hIV0dIdm5hK2ozeWJj?=
 =?utf-8?B?dWF3dFFHMU1XRkU0MERFRk5ublZ5RGx5NW9WdWZZVGp3WW1rZkwxNjVDZFFT?=
 =?utf-8?B?MWdxYlNXMWgvNFNvTW5Ebm5ZcUZaeERlNkFmbFExdjdpQTVaWnFrVkRMQkxI?=
 =?utf-8?B?TTJKTlZka3R1OUhpTUNWZytpWVBiMEU5Ri9HREtKSytoWGgyaFhnSzg5QXNZ?=
 =?utf-8?B?QXY2M0VmZStNdThXV0R6b2ZZK21pbUdXbTVxSU5NWVdtbmdRQ1VHVjlocjQx?=
 =?utf-8?B?TU04Ty9SOXdyaHcxaDZsRWthNFp1bkpHYW1zdHJCZ3lyS3FXT3JuOGgwa21k?=
 =?utf-8?B?OE4wcnMrM1ZpSFZ0RGs2UmFZSmlBaGlOUWJGOGQzT1p0Qk16OERIaTZ0d0hF?=
 =?utf-8?B?a0R4QzlxdEcxamR1YUxxait1ZlY0aXZqdnZNWjY4Y2J2bmtZcnpyTGN6d0xM?=
 =?utf-8?B?Q3lRRWlwL2Jmb1BLSVdiK2pZZTU3S2kwSU5wYzY0aEp4T1hGejNRalNwWmlG?=
 =?utf-8?B?MGlPemltUnZINHdEd3p1eWFrOHR3SUtCVWUza0w0RElhU01oL3B0SXdIQm5h?=
 =?utf-8?B?YWlXNnllUmthejdvSkwzbGtIcjU0ZThET0NYY2RDeGJndG9VSDVaTWlmbkdo?=
 =?utf-8?B?NlE3c2tYeVM1c24yRVlCQXE0SUVDcXpHNks0QmNodHVucGVtWWtJZDJFVWh3?=
 =?utf-8?B?TWt3eklyYjRVMmdNWURsNEk2NDgzL3o3eTVhK2crTUNjUkZxbzRUeC93blFI?=
 =?utf-8?B?eFc3SUk4Slpqd2hLYTVMOXlNd1BXbjZ2YjI1VUZYdWtmNGh2VmRoMk1OQTI4?=
 =?utf-8?B?TUd5NEFTMHdVaDlxYlFIS3ordkp1dHA4STBUeDRpUEVGaVYwM2NkZklDYjZ3?=
 =?utf-8?B?Q3lidkI3Wk4yTUd2cmNobW5VVFJKbkx5Ymd0c2dnMXNZVTZwcDd4RUJlNE1X?=
 =?utf-8?B?Mjh3U2s5a2NaQ2hUYit2MHFLZlFmbXIveUFyUVhRRlhDaVVLcjBhdWdOK3B3?=
 =?utf-8?B?ZnNvNUQwNFY2RkwzU3JNWDJaL1dseHhKMURjWTFOaStFL0lFNGR1aHdXUVk1?=
 =?utf-8?B?TzBCMFVaVmZ2dFFSbGFzeEFUQ09JOU5hSGRObW1zRFMrN2Nmb3VLU0hHaFFy?=
 =?utf-8?B?elNIaU54TFNRbng1czFyQS9WbVY4MURBQWNCeVgrTUh6SXFXNGZ3eUlOMXR4?=
 =?utf-8?B?by9rMTF6OGJNV2dudEZzVldXUXRuUTZqczhydmdtOTlPdkxWWmx4OHQxUFVX?=
 =?utf-8?B?eFNDMnNxSEtmTUpBV3A5eGRUQnFYZkVhb29kTU96V3NMQzI3Mlo4VnJnV0Jo?=
 =?utf-8?Q?1MEorj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhFMXZnNWxkSWxmY3dBUXQvYzBGckJxb3gwOVlFSUEvNTcrNktGUWN0b28z?=
 =?utf-8?B?ZHdrU1ZYcHhPYkxadGFOS1Irbk9XWUJOa3M2QVUvY1ltRXJ2cTRIS2kzaWZ6?=
 =?utf-8?B?Wis3VnZmWTNoak1sUWwwZis0TFZUQVRNU3VLalBNa3NBblI1WkhlVVVndmZS?=
 =?utf-8?B?L2RoaXh3dEo3VmRRakpkcXVFa0FZTlJtcGEvdmpCWHJiR1B4c3VseWg4OFhX?=
 =?utf-8?B?L3Bobko1UDJXQUpHTHZ5V0kyMnM1OXVUdnR4N1pUd0lzOXNDb3M3RlROTHpV?=
 =?utf-8?B?NHplWWZKWHNsT1lESGVacXo2VlYrSjhJdHAyWnJNLzIxbS9xb0NicjJYUVYy?=
 =?utf-8?B?RkRCejdFZFd4YUI3R1ZGcEdUK0RXQzM2U21ob2J0VGF6OVpYeGdlWTJFQ0lD?=
 =?utf-8?B?Tmlqb0RYOFoybFkxelFtb0VHbFpmWGRKdE9RUjl5czdIZDd4K2UxYThvd2k1?=
 =?utf-8?B?V0traGt6RFRDTWhDOC80OFFYSy9IS0tpUnZFZks2a1hxNVNORVY3ZmNTMjkv?=
 =?utf-8?B?V09QclJna09wWWYvMHV6bHZ0SnB6V1hUQ0RuajNUeHhxNzRHVDZ5aWF5U2hn?=
 =?utf-8?B?SVBJSXhOSmdZbEdQdll0MnlyeEY2RHkydllkb0lNaVBNdmtuM2lobVBwNlZu?=
 =?utf-8?B?b1E2UzRyR1FRSjNheG53Qkt5QXp3V2syQzRTbUxYZEFrdi9uWW1YaGVUQWFH?=
 =?utf-8?B?eTdnbkUyOUhFNno0aFpBWlQ4Ykp2eThlMVFxMmJ5MFU1RktRbDhaandGZEV5?=
 =?utf-8?B?blpqY0ZCVHZrb1hRaDk4U21JdWMxVktlVkI1K1hBU0VTNWREZFhJUndBdWxY?=
 =?utf-8?B?eWE4Sm5pejdFTVB2TjIwZE51TVdCZVpzcTZjdm1LT3lzNjI0NTFnbEcwQW5w?=
 =?utf-8?B?UTFFMXI5WHlJQ245cEhrWmcxRGZSUllrTkgwNzV4Y1F4d3dzS3JvczluZk5L?=
 =?utf-8?B?VEtLSTJUSGFLTnV6Z0wwMWhhQ1hXNXdvblA1NXBjK1lUQjVkdEF5dDc2TFNl?=
 =?utf-8?B?TzFnNFovMEt6b0xQZVBNV2FpaitFbHJjZnU5cDRsdUQraFMrTmxmNjVMYi94?=
 =?utf-8?B?bFV6YWNCVW1HelBLUU9QODBlcUhleGpML0dUVklaTGpSU2FDM05ScUVUbjRC?=
 =?utf-8?B?Q09WcDRhSE50UjdoNmM2UjFHMEw5STFVQWE0bmNqejY4cDFsakY5LzllVWlD?=
 =?utf-8?B?OTc3Z2tBRVlGYkd6ekpMdmRMK1RvZ0ZBSkRjeEMrcHFDOXR4WkVVOS9tdk1a?=
 =?utf-8?B?ajJKRm9TdVRlWlNaRVExTGZFb2lKY0Uxd0FWeFU4YlhReE1FLzJVQXRKc3I0?=
 =?utf-8?B?T2R5azNxTE1EZklJRXV5YjFjRnROc2tYRkpIWC9uOWgwV1JQakphWm1lMVhi?=
 =?utf-8?B?NWFMV0hkMHdzaTBFRzIwSkJmaHg0bWNkVWJQUWl0THJndmtuOVZHNm1TaUtZ?=
 =?utf-8?B?UzhHMm4wMXJJSXNsSERCYitLSnFscno5MWE4dmdLQnN5TEhVa3NhakZIZ1U4?=
 =?utf-8?B?VDdycmhjM1J2R00vVTU2ajVJK3U0elpkZzN4V2dJQ1d0YTcxZEhySDFueXVL?=
 =?utf-8?B?MEZSNktPOVJ6MnUyVm4xblJZRytiVGN3ZmRhcjM5RVpHZXZKNFZoaGREbzMw?=
 =?utf-8?B?T1ZXLzRhUW1tZFppalZmRG5RT2gydnFrNWN3bUFoS0J5cUQ3K3puVVRpRVYw?=
 =?utf-8?B?NjZRSzR4NFZJNkVDbWhQN2xUZ3lkcDJvdXVKdVNSMkxxM01ZMDBGQjZ2ZGkr?=
 =?utf-8?B?ZHp2b1Z3TmtzY3dtTjJYeEpuUkpvcjNZQWxPSDRFdzdDSCtCRmxOdG11VzhM?=
 =?utf-8?B?KzFlc0g1NDR1Y2FDUVlPTUJQVC9uUmUwVXcrZFl4b2tXcXNWRXh0ekFJQmpy?=
 =?utf-8?B?UEh4TkdwRm1YVms4M1RhUDROOENaY0xHcmh3V3M2dExZb0t5NXA0RjBESmRm?=
 =?utf-8?B?WFpEL053L3o3MGc5TVdPZ3BEUm82Yko4Q1NENlpUbnlkZTZWREdjaWR0U0Jm?=
 =?utf-8?B?czBSbUhtUEVYVHNiWm05QkVhREplSWVENy9FU1M3TkxXaHkwSzdaSjVVcHFV?=
 =?utf-8?B?UmxFSm1hM0p6VjVWblF3L1RpUG1iOHdNWVcwU2JNMHY3VTFPN2g3UHpRQXhz?=
 =?utf-8?B?YTFwdnA5VTh6dkpobTNBUTY0eGYvbVNIK2RtTHVFTVF1Zlc4d2FGc01YejdY?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e4bd7f-3744-4f1e-ca9a-08de30d1262b
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:59:58.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAxy354+7Re0hmcoMNfs4bCdlw2aI0wKopLf9/IflovTt/Ah2LLqZFc2z7VQ7TR+IEc/hJyQv51JOGjQI0rDwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9203

The mask setting is 5 bits wide for the ad9434
(ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
from ad9265 were copied by mistake when support for the device was added
to the driver.

Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed ADC")
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc405e25f312197df4b2131871b4bc..2910b6c5b576d101a25c0b5f0fb9024f0b4da63d 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -95,7 +95,7 @@
 
 #define CHIPID_AD9434			0x6A
 #define AD9434_DEF_OUTPUT_MODE		0x00
-#define AD9434_REG_VREF_MASK		0xC0
+#define AD9434_REG_VREF_MASK		0x1F
 
 /*
  * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC

-- 
2.47.3


