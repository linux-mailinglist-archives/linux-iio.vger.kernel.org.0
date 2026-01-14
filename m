Return-Path: <linux-iio+bounces-27764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D439BD1E355
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7822B3054B18
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AA13939DE;
	Wed, 14 Jan 2026 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="hvlCx2oM"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020129.outbound.protection.outlook.com [52.101.84.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9715393DCE;
	Wed, 14 Jan 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387610; cv=fail; b=pLq3eQWmE4+EhsUWRDY1NlEovcRiv3SO4MoRyMUm8unS6X1mW0v+aLlLvU2ND+8d1jnP5QKViPaKXvdkByuNGZdiq5QPN3JJ4kfMvkb0fVKMTT+aBbaRTP/SLtGFgbVumacM1omnYLqVX7ip082oe5a5Grr3qLJpN3NVF46PvVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387610; c=relaxed/simple;
	bh=+a/eM28x3qgPNDxnEBpZjGiWhvdbODJ5C6oMXveCMdY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TsoB2k231ZZ0zb2/qyg8M9xrrKj8AKz6diCZ2PbQKji7xygAkHT6J8Z8onZYKs6BCU7Vsft1hi0+MDdTV/IreeUio7FYw7TXKsbMUsFUZjTLGB3rDy8tx7AlwnLojJsNnDGIrOax62gs8qokPu7HduZuwKUg0FHe9qBD3OJPw40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=hvlCx2oM; arc=fail smtp.client-ip=52.101.84.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHS2u8Ms1QPpjdroisRylaAOJwqM/eT3kCD76fwvTKsstIioalUbEIfjCNJugSsI7tbVsEZPk0Z6CSpRgqU9ST57DdORz5OqTShvAOodxXJH70tjChoppe39TR41Z0vnJ5ffAoIH/AHDQXhyvN/To94m9Dodlny/rZFBNv+MrgJp7U7xuExWLf0xafbHNDaSl5NLbZdltM1IxRtUnF7E6FI2P2lmcevgDf+gsQlM0TRF4Mc7BX1Nt3lze1525vnWZOareJPV9V6QCUIlWsgiQRjtLb9g8GIBcPd0xFRoY9sBRACq08tjXN5DM6RlOtzKTeHVXA3aJC03dbMXFB0LhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3w9wDiRBJgABpsjUjpnMqb85Z5DzYqklguDL6XzsCQ=;
 b=wHkne9BkKZBw+qq5mthvYTSvgsSQbnnDkS3MAhW7yKmbdYbM0yzozFw8CofdQ0/UnEbV7Qbn2u2oWeYuTc/dgP4VtYrpXdY71Q3rD1HtbJD0YIuIiCm322DO6lcq6ebkUa7f2tEdajKOB/ne1LG9b4dGeZi1HnCr84fvGmNdWrDA+ZiYpp6mw/geWbWcd8CQLOedoiM7oD3m2r7tO7GHdhZG6kZrTV1+x+R/DrpSUTVvNSVfu4E697hrZjE7REsYTYSFg+H/+je7KbI/s8JaOVaZZCGPIsJsvj89TQex3m/envPg05ZanxzjyuFdNJA1HYLWqR4ZjlF2cyFio7L+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3w9wDiRBJgABpsjUjpnMqb85Z5DzYqklguDL6XzsCQ=;
 b=hvlCx2oMWIp9cHKPTRd9h+IzegmNUi69gRtwVPLljq0TAjCQc4gwJYqH8JTpEAozHPjIjMt3Uw1PHacWZlBRcMMg8Nfy+xJJPmK/i1RzW7/D3Q/oNleYvmc7ZnA3yw/4FvzcSh4aD4M8u8Vq6ZSbCg70ToOPHn1J3MfbUNNbntDwVVEqbJ7S1EAs9LkGUG4eSIjOkAucn+qSyp34N+PIP8jKLg1sptTxuJNc0WDTVjwKm7IzL6nKWUqtuZsLE4+m5AQ0VncR51zA71UL0RZjaq4VrwPo6jktO3NWNxje2ZIFRJdhzylye+qTRoHwG9hXV2NBKDCpXG3hRCPe3bX/Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS5PR06MB8943.eurprd06.prod.outlook.com (2603:10a6:20b:655::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:46:10 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:46:10 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 14 Jan 2026 10:45:51 +0000
Subject: [PATCH v3 2/4] iio: industrialio-backend: support backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-b4-ad9467-optional-backend-v3-2-d2c84979d010@vaisala.com>
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768387568; l=3960;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=+a/eM28x3qgPNDxnEBpZjGiWhvdbODJ5C6oMXveCMdY=;
 b=/+WuLSh9ZdU7ordpl8kmqkdtZ4nilKRFTqxdze4MzHtpujTDpJ14Mw2PHw+0XX13ya24xUGla
 raA+7r/TW7KC35gU7JOaDWFfsdu38TcItfiZDi673Dk5GilqSYpADKG
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVZP280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::13) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS5PR06MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 627e337a-fe40-4173-511e-08de535a2132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmgzUCsxN1FUa0IrMG0xQ1QvNGtpVllNZkg4MlhNK2VpQ1dVNmNNMnFUU2s2?=
 =?utf-8?B?Vll1aGJBTjNRTjJjc25QZGZ5b3Z0WStZZzErOGtRcTFLWWM2NVZ3VDJNNVhQ?=
 =?utf-8?B?VkJHNkJMZlNGZUJqellUcnUzNFJ4blh2S3lOL2duNVpqODF4enpvUHh2Mzc5?=
 =?utf-8?B?Ym5URUY4MFgyVzM2cE95eDVtdlE5WFV0S0FJaHhHQ3hQNDlxd1ZSbGJHWDdm?=
 =?utf-8?B?STlDbEUyUk9ZeGlaUlhTZTViUVVFcUZyZ3FlWTlmeWNnbWdGV0J4UFlVTytR?=
 =?utf-8?B?NGNRSm5YVVlqcUlkMm5tNlZxdlJ4QzFDQ2VMRlAyLzJVaUt2M0R1Vy9KdHNI?=
 =?utf-8?B?WU44b2l0alVULzRzc3pqQmhqRC9yMWRlQ1pRYWlkdGxoSUxpT3hEM3grSmVM?=
 =?utf-8?B?eVFyNTNIK0Y4NXVaK20rWkhKa1ViU3R6dGNtQWs1RUE4UGNXZHRSSEVwVGFl?=
 =?utf-8?B?OW5GWVRPTUpxYWhjakh3OTVIcGo2ZXZQT3FWSzhrS2pxMVlOQWlZTUJCZ2dk?=
 =?utf-8?B?c2RXdlU4TVJzQ3MzNzhpQlFmUnU5UFY3OUFWdUorQkQwRk96b0diellUVmpG?=
 =?utf-8?B?Ly9EUy9OMUh5WDY3QlRvNGZ4UFpMaEJqNmVGQXoxVGV1SG1xNjhybGIwQ1Nz?=
 =?utf-8?B?eTM4RFpJRWlxaFBGc1QzY09sMkEycW9HSzB5Z2MyMk9LcjdkQ3JUZVdEd290?=
 =?utf-8?B?dFhCVzhBRDE3SmJ2THdXK2VxdWxiU0I3aC9vcU5WWkZjdDdGZmJWSG1rV05n?=
 =?utf-8?B?amVpdEVhZGQ5RzZPd3VhMTh4djUzb3BtR3hTK0dVQWdudHFDTFExTmY4M05Z?=
 =?utf-8?B?SVBuUmE2ZytRSFRXVVpPVmN5b2ZEVXZSN0JxcUllbXlxVENwUHhqT3FFekpJ?=
 =?utf-8?B?cEdwMENrbEREbm9LTXdhekF1bzJoeU14VWFISzQrS3hEeWdFNHZDZjNJWjlv?=
 =?utf-8?B?c2FZajI2Qm1GNHN5TGNSOVlicEdVdjNrMllGTitmeVVNR01pbnNPRy9qaUZw?=
 =?utf-8?B?QlNISUZMV0RwZG55K2huUnNybEFjL1BNSTUrZlhNQkoxWVdxRkJuVDFlVGZ2?=
 =?utf-8?B?bU5jdWw2QkxHWlVJZGJXck9NUzJXQVdaL0l3T2dLelJkYXFWZDlTMHAvdnhU?=
 =?utf-8?B?bEc1NWFGbGZsOEdDRWhQY2VORGVOSk5HbjVzTXVHaFBqd0JCNUZJZ3RtL1Vh?=
 =?utf-8?B?a2VwNm1zMzRsazNtTWprY3V6MkZFb2pqamxMQXlQS2JPQVlqYkludnhZWFRI?=
 =?utf-8?B?V1V2eTJibkFUakl6eGlQd1pISGRyelk4ekpqYVc2ZWNqVWEvMis2SGFmb2pT?=
 =?utf-8?B?MEpRZUdCejNmL3lNdUNrbGlwZ1orQ1NsWnNyWFJXMDB3RU5VTmRFdUVEZlZI?=
 =?utf-8?B?a3pmUFVwRlBxc295ODdpV3ZpQUFSamhaa0FjQ2lNZ1NDdU1QY3A4TkYxV0xL?=
 =?utf-8?B?TE15QXhVQTJHWU9ZcjhadUxWbWV6eGMzNDU4RXlqSEZSaVUvdmpTRFFCYlp3?=
 =?utf-8?B?N1JXRDVqcEFaNi94TkFEQjNHQnFYemVOaHVqUkNYbENQWjhlc1Y3aGVVb01D?=
 =?utf-8?B?WVlaV2pTemdqMWpTQmE5YTgxMFJ6TmhvTkYwcE1QMVVIM252MVJJd1J4Nmx1?=
 =?utf-8?B?Y0lSOXBYNzFnUWRsSlZUNlZjOHFZeC84RlJBQUJEZlgrV0hKOUdXcnhiZzZG?=
 =?utf-8?B?YmFTYlM1TXhCZWhIdWJidVdLRU5oTUJrV3pvTm0xOTNmM3BIa1FXMzVML3FV?=
 =?utf-8?B?c01jQkVsNW1YU1I5TmRiM2hpUEdITncwUzFPVHlSb2Z2NkcwSjZIbEdaYWFM?=
 =?utf-8?B?UFhNQ1BMcXdxYVlUOGs5ejB4YTR0K0pqYVpKbU9wT0RpNEd1Ylc5YVJLV2Ey?=
 =?utf-8?B?OXRxbDVMNy9FVDBxVHBJdFhDWjk1dFM2aWFQOUFaSENOZGkxbkE2RHNSL2xM?=
 =?utf-8?B?aDgzaWRLa3Q5Vzc2STJyUWhuYXdvY1g1ZTRwWE4yeU5YeHpXSE9QY2dibW1p?=
 =?utf-8?B?MTdtdXNValVrQW5EMU9mRnlITWdGc2x4OXlxNUp3Y3JWa203TGJ6OHFhYlNN?=
 =?utf-8?B?bFppbmJQV1VJZ2VrMzEzREdJTzVvTjFJMjdXRkw5UUJzRlI4eG1rN2tHL3gw?=
 =?utf-8?B?QmE4Uzd6RkFMWEcyL2Q2WnhBUUJBNzNEYitnRkl3N0xJUkdsdFBDVkU0NmdM?=
 =?utf-8?Q?wFoZoMd97mc73ksX8DLwUbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTExaXFaWi9xQ01Rbm45N2xYZlVtd096SEdRQy93ZytPUXIxN1JtdXpoVWxZ?=
 =?utf-8?B?K0RtMDJQQUtHaXJlckJyUlZ5NVpwYzBjclh1U2ZHM2JDbmZMbjJsd3VxcEpF?=
 =?utf-8?B?a3dxU1NScVpaNHBmOTFOdXFkQnNzUzVoL3REN2NXZEY1a3hBWHB5bHZPZGxn?=
 =?utf-8?B?WTVScVQyTng5RHhGWHpLWHRpMFp5K1kvOVArbnY0d2VSSHJtV3ducnprSnFq?=
 =?utf-8?B?ZWk2TThIRlZ0aDhZZ1duQW9nL0VNd2tMZldaeEhMUDU2dWhyWThPS2ZmeWZm?=
 =?utf-8?B?K05zdVNlSHl0dlhiOFBwUE1zbW44QWhEZGhmYmJ2L2lIbjU5NnFXcHZzdzdW?=
 =?utf-8?B?ZnRkbWV4N3FKWm5XYlBFM3hkWWZGZXYxbnc0MCtLczJkVHhML2RPSXA4Ry9X?=
 =?utf-8?B?cjV0U0tqM1V1TlR5dVVlUEFqT2orZFY3MGplSFdxTmFwMlV6TmdnMFVmUmhI?=
 =?utf-8?B?TzNFSnFBbHlmWFpwenNWaldacFhFMXM0MXFBTG5HR2k2Vm1JcEx5NU5xL05v?=
 =?utf-8?B?UE9USDhmTmxBTElqUlJaRHZYWUxwTVI0blRaMHRPN3RmUUFpU0tvTGEyU1Q3?=
 =?utf-8?B?OGp1bDJ0TDBBbDFZYmhqeFRhNzBoV1grdExDMThkV2JNQnYrT1BiWVFnV0ho?=
 =?utf-8?B?Z05ydWU5OGtNTmQ1RnRrV1JldlUybkhJR1M2bUFEWVNyWm9GNlVJWi9jWlRL?=
 =?utf-8?B?dEp4QUZYdXVNejJLdGxuUEJRbmZjekRQdnlKR1ZyMDZvRVFLSSt1QlBuK1Fp?=
 =?utf-8?B?V2Z6Rjd0ZnZzTElkUUdCOXc3Q1RCOUxyaDZ1Z3VXTDZlbmVKckJiN2pkd3VD?=
 =?utf-8?B?ZzRoNVdRU3ZJVmR2aXpzaHVmOFliNTE4NnF3Mk0yeDZHdUxLQ00zdzlUMEdE?=
 =?utf-8?B?Z3JtU1JlbkRpbTdOUGZDcUx3OXF6aVorNGpGRzdwYlNpYy93K3dRd0NKbmhW?=
 =?utf-8?B?WVdzNlVFdFR0OUw2bWpObmxJdXFqZXNGVGxTQkV2VzVUTDdNOFV5ampOSHgz?=
 =?utf-8?B?SUdFM0tDMzdSSDNwOE5ZemZoRjVsOEZZV1FZQ1pGYTJ3TXF6OXBTVWdsZzQ3?=
 =?utf-8?B?VUdudmpCaCtjeTRkQUJFcnV6RlJBcnVEMkpPTlk5K283WGNVMlhKV1NydUNI?=
 =?utf-8?B?cDZSN1Y3NnJZRzZnQ3V4OVIrVEZtQkZUVGVSeWFsNkZ1QnJJMi9lSk1QZ1hw?=
 =?utf-8?B?YXE4MjBpd3JXY0xQYzRHWHY5dFlsbTNJQVBteGwyWUkzWk5WRnM1WnNIelBn?=
 =?utf-8?B?UHhBVFRXTTlzOFBBUkUyQTNEeFhYcWJjcWx5NjVxMTlBMlZvcWhDbjB4SDdV?=
 =?utf-8?B?a3NuSWoxYnR5NkVTcEdLTWEzTUNOTnRtSHhueVBLeTVVVlA5bTc0SlMyT1hj?=
 =?utf-8?B?OGEweWljeXRGcGt5MVYreTkzaEhuVTA4NUYyVVZSNmZVQXhNS0s3Z2NTWHN4?=
 =?utf-8?B?OXlvZ2c4UjdZZzNuNVUvZjZ0cEZTcTgxL1hHUG9pdENuVEF2c25rWlFrc0ho?=
 =?utf-8?B?YXlFT1VkOEJCamQwVmVBUERmMnJlYmVrZncrMG5CdzJUdG43bjQxQkwwU1Fv?=
 =?utf-8?B?ZmJYMVBRdm93bndCSFdKbStRN2xzQmZ4NFROOUtPMzBkTVc1eDhhcHFiSmln?=
 =?utf-8?B?NzBpdDJOVmlMYkJ1ZGxQZ1UxczJ5bjY4OXdYdXRRUFprU01tY0RoMjNmd3hM?=
 =?utf-8?B?N0g2alJaRUFGaVRmWTVBcHVoK3doL2lXaHMyZzdoZ0ZSNzBNU2JzdkFQSlhn?=
 =?utf-8?B?Z3dOeXUzb0VMWU1xRnFkcU5LQXdqZzJiRmQ5bEs4b2dIN1RxL0Y0TkFLWGJm?=
 =?utf-8?B?T2lxQzdORUFHL0JUenhYWXJabWxrU2Q4MFZGK2pvdm84RVV4SThUK25NdlBR?=
 =?utf-8?B?UXBXcFZ0dWN6WGVZbHhRK0N1ZEh1emZubmpmUms5ZDZXYTcyR2NuQWZoRVN5?=
 =?utf-8?B?NTZPcWtiVkQwNEdxREFUQmJwMWlWWlNkOFdBcGVFaXlmNmt6am9ZTklUeEN6?=
 =?utf-8?B?NzFYVHcySFhySC9MT25IU2dRanlYY0dJK04ySy93KzdvdE5FMnptaDIzWTBm?=
 =?utf-8?B?Yk95K1laRTNUdjRkMkpRdS9kZU9ISnRIMFBoQng4R01WekpFK24yVU9MSndp?=
 =?utf-8?B?Q0lpV0JqajYyQmtEVW1ZODlOeVo0R3crSm5wT243dmIwQ3BqVmNCWDhzYzNI?=
 =?utf-8?B?QzRoN2hpWWtBc3Y0NmkreDJtMTVPTnlhNjlHajJKYkpZWlo2Z2JnQXNidjZ4?=
 =?utf-8?B?MjVWKzBzRnR3OUR3d2prd2FJT0N5NVFSQzNWdmJFRnVJM2tSYTYxcjhTVWdp?=
 =?utf-8?B?ajZvWDlvZm9KeU4ybkY5MnAwNFlIbWQvSTlOdnhpc25RUFFhY3RwREhkOXU4?=
 =?utf-8?Q?qvcIBbpxPAYHD5Ac=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627e337a-fe40-4173-511e-08de535a2132
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:46:10.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1M52fJw5MMIJHWGgDRUf3fa+QPoS/xVsha+Vvq/qeLJ6hhuRewg8Z4CQ+dFJq4mJRYu4inKyUejZXcXRLPxFiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8943

Not all backends support the full set of capabilities provided by the
industrialio-backend framework. Capability bits can be used in frontends
and backends for checking for a certain feature set, or if using
related functions can be expected to fail.

Capability bits should be set by a compatible backend and provided when
registering the backend.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
 include/linux/iio/backend.h        | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..0a98fdd5df9db6cc233af819ac5243ba8cd5266f 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -56,6 +56,7 @@ struct iio_backend {
 	void *priv;
 	const char *name;
 	unsigned int cached_reg_addr;
+	u32 caps;
 	/*
 	 * This index is relative to the frontend. Meaning that for
 	 * frontends with multiple backends, this will be the index of this
@@ -774,6 +775,21 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
 
+/**
+ * iio_backend_has_caps - Check if backend has specific capabilities
+ * @back: Backend device
+ * @caps: Capabilities to check
+ *
+ * RETURNS:
+ * Non-zero value if backend has all the requested capabilities,
+ * 0 otherwise.
+ */
+int iio_backend_has_caps(struct iio_backend *back, u32 caps)
+{
+	return back->caps & caps;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_has_caps, "IIO_BACKEND");
+
 static void iio_backend_release(void *arg)
 {
 	struct iio_backend *back = arg;
@@ -1114,6 +1130,7 @@ int devm_iio_backend_register(struct device *dev,
 
 	back->ops = info->ops;
 	back->name = info->name;
+	back->caps = info->caps;
 	back->owner = dev->driver->owner;
 	back->dev = dev;
 	back->priv = priv;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..8a0df8e980e910ac2d5398275963dc5adf077c8a 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -84,6 +84,20 @@ enum iio_backend_filter_type {
 	IIO_BACKEND_FILTER_TYPE_MAX
 };
 
+/**
+ * enum iio_backend_capabilities - Backend capabilities
+ * Backend capabilities can be used by frontends to check if a given
+ * functionality is supported by the backend. Capabilities are loosely
+ * coupled with operations, meaning that a capability requires certain
+ * operations to be implemented by the backend.
+ * @IIO_BACKEND_CAP_CALIBRATION: Backend supports calibration. Needs at least
+ * iodelay_set(), test_pattern_set() data_sample_trigger(), chan_status()
+ * and data_format_set() operations implemented.
+ */
+enum iio_backend_capabilities {
+	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -179,10 +193,12 @@ struct iio_backend_ops {
  * struct iio_backend_info - info structure for an iio_backend
  * @name: Backend name.
  * @ops: Backend operations.
+ * @caps: Backend capabilities. @see iio_backend_capabilities
  */
 struct iio_backend_info {
 	const char *name;
 	const struct iio_backend_ops *ops;
+	u32 caps;
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -235,6 +251,7 @@ int iio_backend_read_raw(struct iio_backend *back,
 			 long mask);
 int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
+int iio_backend_has_caps(struct iio_backend *back, u32 caps);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,

-- 
2.47.3


