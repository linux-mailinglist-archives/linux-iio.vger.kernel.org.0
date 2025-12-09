Return-Path: <linux-iio+bounces-26973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C593CB06BD
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 16:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A90BC301B750
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9DB2D6E64;
	Tue,  9 Dec 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="fKG/jSzz"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021074.outbound.protection.outlook.com [40.107.130.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631B2FF177;
	Tue,  9 Dec 2025 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294773; cv=fail; b=EbPxA97IYyK34Ysug4WLODwhCNK6CN7zin6y2J4u53TKWGvMJqY2j2DJ1K1ejCchMGHtx4qn3LohoAIkNBdkI04MtifSgaaOQNAIaIz0AA/tWE8mVyGn66GdlBvQtCdrWoh/psOnAN1zPmqYW164X9TEIt1wXAbgOCcFU79auCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294773; c=relaxed/simple;
	bh=qQFXLd/1HLUgGgD2R9Ovh3VMZ0+uyVBKLm7O3c7y8fs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sqkl2zDvhhwsvIAADMtBhMohNVEvSgGQRWjMz3UtHA3mmfN6otJquZRU2rzb1lD4a0OsWCx7r+A/Uj3+n93axyrGbe/gBz2byOHgRVM/lRpyr7gA0XhPBOuorTmIHh5JmHMpvUuaKTMSYPi9c/Ye9Y56qVUJ8chQGGFVgGycTso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=fKG/jSzz; arc=fail smtp.client-ip=40.107.130.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1jpZI/S5IttWVpJAImQSG61l+X/oNCE+tZqmfhOjQE3KkS6SThZW2B66RdLqgH0Q8Rut2i4FaT8CRDG3vTQ3Vl2viObJroAvUbtogMicg6sKK81QjoUcqs2FghQCN3qYYb4y00LzFM9TKQ8GdUmFw0dUbtDuFrnPCgm0fN6u68Xp85D2dLtEDzrYTKSrMVYxyv3JE3RNL0VLGp3+ZgJa71cRmWORS6FtrVueMctRu+RQZg6C2Q37rKrGCgRyRxMeK9bEdzCi4o9gKsGe531+6eoBq1PQtXpBLtcmSwPz5Kycr6KKzvotJP6wnNKLvbH2kcC1M41DALludNbudEKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y69jlb9fKJEKTcC0dDjn3PMpNloG4mY7BkkeKC4djNI=;
 b=Pt9nbtRLhENxqMlRswlOjhnl5abGO7W5mClNEv3rB+YojhRe+186x5MBy6+dO4Xo+arGjB4eRSdbNTjnhBiwwR3bCoi2Pf1xp1MDlHz0Q4l2lSXyCvHiOBJQ1aTzTDjXaj2gAhtz7y27Mmn0ZnOxAi3iDe1Zf7AfrYhSzIDrDyC9rnWH7gJmiHNz/Sp6+5INJiQRra8RyF2E6O7P82qu/0us4NyjNm2rU5fWAZTWOjFPdu86X26ORmGX0PqSJaKQuBSOMEiLRACxnF20hRAJbxkaF9ACAnXFXjM65U4QQy38rUZnfHMSVj1QGsRS+s8O64U5beTFPQiBJgOlWtHtIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y69jlb9fKJEKTcC0dDjn3PMpNloG4mY7BkkeKC4djNI=;
 b=fKG/jSzzLpO233jnXO8V0vmnmZgxGT+NmqfJeHzyGNr+B01gE7ED/+jtCWnBSSnsNFku1i0TmN9yL5NtkFweNvbw2wXZRoW0O7y2jXwwlHKwFjO0NU4zPNHDgJUg1zf31AY/7aR2DR5FGKbUxj9E9sExM6iOG+CfK19Q+s1eOh/MwXbUkwMJHadFLq9t1eHuK0BVkv9fnGZs3CMB0oTK2czzuVfTOD0em2fDgHChYR+jbMz4VGb5+xfYIN5XCdwWNgIqqv625yunlU4tnmQQm5gQzA7/+VNYM4xAB66DEeppTPmjSbbCQtk21EUkYpIcEy37Q43RwpmL7+qGRse4Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DBAPR06MB7047.eurprd06.prod.outlook.com (2603:10a6:10:1a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:39:28 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 15:39:28 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 09 Dec 2025 15:38:12 +0000
Subject: [PATCH v5 3/3] iio: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-add-ad9211-v5-3-8da056eb62e9@vaisala.com>
References: <20251209-add-ad9211-v5-0-8da056eb62e9@vaisala.com>
In-Reply-To: <20251209-add-ad9211-v5-0-8da056eb62e9@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765294730; l=4657;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=qQFXLd/1HLUgGgD2R9Ovh3VMZ0+uyVBKLm7O3c7y8fs=;
 b=VXkRevPl+YddAYB9IDHsf6uhqQD+1nJeSM6PngNvqNcPp/S01Q+dp92dXTiAXR8nrBRWYDSnI
 61PWbps23uXDpKfy3Wl2aT32EWqjK+294dKXeo8vTrY3Sbc3Yw7D2ek
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF0000366F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::38f) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DBAPR06MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 32aa4753-ff19-49b1-4962-08de37392355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU5Rek1xYS9jQ2YyUVVwMWFLR3lPanVLRDNwVlZlUmxwMWJrKzNGUzQzcy9J?=
 =?utf-8?B?SWY3NEpWcmJrUjl5YnJGYUF2VWpMMG9Ib1lEZlVwMVYzazBGcllZSG0ybU01?=
 =?utf-8?B?cGlDY2VtN0RmVlBpU3VrMmtiVTdkcXBMTGhOT042MmUrUzBYR2pRbC9BYjBT?=
 =?utf-8?B?bnB5Ujlld3h1Y2I0aXBlOHJOSlIrYjQvK3IvOVVCUXdldzZCS291TE5qQ0di?=
 =?utf-8?B?OHY5Q3JYK2poZmdzMzlhSlBGNHg3SUhCdW9sVkFRUTQyMUR4ZHV5V2toUXVC?=
 =?utf-8?B?c2pTODJDbnFUTTVVV0llcWowbzBsb0ttc1QvUGJEWlQ0OUxPaGYrNjFnUk5L?=
 =?utf-8?B?cnkxaTFpRVY0N2JibzlMdll5TmpCK2t4THJkb2RlMjhHTmtiVnAxa0FmenJw?=
 =?utf-8?B?enFsSzBZNFJ6ZnhIcEZkOFJXY2czczhmZ3lGVVZrS0Q3NUVrYk5iN3MxQk9t?=
 =?utf-8?B?OHJ0T0F5YUNXYWVMU0tXUTJiZ1FqaW5hdkFiU00yYnBjVW1YdlNwYTBReklP?=
 =?utf-8?B?djNibWYrcXdwa1dmd1lSMHpaL3QxRzRTV2NaQ092LzdaZ3hoaldDMmtjWkNm?=
 =?utf-8?B?aXhHY1RMNlZuNnJwcHlFV1lIZWU1YUZIV29YWkZVY0lLSGhJRUJTdHFhTGts?=
 =?utf-8?B?RlY4N0tTV1hZSVBwb1RkTmlUWkhkWVVTZmVjc2cxWG5VMnhyeXZVUGdMTjg5?=
 =?utf-8?B?TXl6TXRHYjd1aUxJZ1MxRklsbnRJZFNLVGNUWExzODBBZDFIaklLYU1SZTR5?=
 =?utf-8?B?WHpPRE5rOG9RR2oramFzd0FjT0JkcEYzVnVtZzVnNHU5aHF4NlpmQ2VleVRl?=
 =?utf-8?B?UXZZYzBMWFcvcExmYUg4dktaVm0xK1VhMU9zN3hlSTI4QjdCajRVNk9mVVpv?=
 =?utf-8?B?L3ArSFdvZ0xzMFFXSFB3RXIvMHZaanhJS2Z3QmFXaGtVNGJFazZKejlGbTdy?=
 =?utf-8?B?MjNHZFNRWGFrQnFISGh4T0JYTHlWUkVUdU4yTEY2UVlmUDltQW83VGVFQy8x?=
 =?utf-8?B?ejlCc3pscWdXT3RFeHBPNnZMeXdCQmZ1OU9OZHZEQXdaUXlSV08xNnZGSEFm?=
 =?utf-8?B?QURTSE4zYmdqbFlTWVpacVA1TXdUS0J5MUFDUXRRK2o3U2hWRGthRjhGRUZD?=
 =?utf-8?B?KzNNeUdma0p6ZTdTRXR6UFBrUUc5M3A4eklFLzh0Z3o0K290UERITWlEWmI2?=
 =?utf-8?B?VjBJVzEvSWtET2JCQ2U1OU1aWjZhVFlSUkp5UWNON2xnVG0vUStZQTMydnYz?=
 =?utf-8?B?WS9vL2RQWW1DZFF1WTJZNGxEcWYvcCtGVHhZcVBQalNwLzd6U0lZakRubHJy?=
 =?utf-8?B?blArNURwRU5vQjJHSmNHQ1h1c0Z5NW5DUG1rQ3J6a3dkY2dhdnBBQndRK2Nz?=
 =?utf-8?B?M0R6RW5LYlJRTFd3bVB2a0o3VitZYTY2RE91bnh6OFZUdHhWRlpCaDlwYWd6?=
 =?utf-8?B?bUQ5anZySzVoR0VId1NrSngxTTRUOVgzVkNPcDd6M1VWWlQ1bTdLWnVNZUp5?=
 =?utf-8?B?UFlkVzRqQVUwUWFsV1JwdE9ZZWFYQkFmR1FzZlBVbE1uV1Bpa1V2cEtWazEx?=
 =?utf-8?B?Z21sZWFwZDRlblNqS2haWUR3b3dxa25IcjZMT0F6a0RxTmFid2RKeE5DTzR2?=
 =?utf-8?B?ZUUxMmV2aVg5OVAxQXpyZzVielZueGMwTzBFZUxjeXJPWndUWDVvZHU3a3JE?=
 =?utf-8?B?Z3BYdUVRNWk0Y1JtQzhGOFBCSzZYWkRUVmcvSDM1RE8zT1YrQWpDRlV1ZGVv?=
 =?utf-8?B?alNFdHlzTUZBbEpuV2NHbEZwSytYOUdSMUoyRnF4d3JhNUdobm1LZkFEeERi?=
 =?utf-8?B?TjNSNzlwODE1L01GSWhlOVR0THVjUlNPVFpmSmQvdEZEOHBLbnpJWkNmV3Vt?=
 =?utf-8?B?YWRJUVNYL2FRL1NtZ3JhWk53OFJjSS90RURmWFJXa0YwMS85eTl6V25jd0RD?=
 =?utf-8?B?bGw3eGtyR2VHNE96T0tRZCtEalJHQ01SRy9mUlN5UllkQUkzVnhrVUlNUWVO?=
 =?utf-8?B?UU8xQjljOUdNZ2ZuTmM2S2NpeklwSjdUbTV4czhzckNocHFTbW13VzA2RWU5?=
 =?utf-8?Q?ySdH2V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWFZTWU5U2RjMFg5amlwcjRPUG1RbXhnSXdKdi9lUTB4dWZJb0U2OVNHeVVY?=
 =?utf-8?B?TXpRb2FlWWFWc1lSTUdjU09OMWIxdCtkRldUWDRJcGVhNEx0UDlhYm1ITmFj?=
 =?utf-8?B?NHErdFRGOExKNC9pZ044NDVpR1VBaEQ2Wi93SzhiWEN4anEzZXhEWTN2R0Z3?=
 =?utf-8?B?a2hDYnV6Y2tjVW0zNmdZcTR6WmlZTTRPM2pnLzdPdVd1Z2JoYjNUMFlnTnJn?=
 =?utf-8?B?cWpicEhkcndiQVVOQnJsa0tIRmZYSTYyUG1scXAycVZINTZQMWF1V3MrWGtx?=
 =?utf-8?B?cGVJdTROTkQrVzlneUIzdjdpcllVaGpMTU1hdEdiZ0FYZDlYRFRZeFkyZ1dK?=
 =?utf-8?B?THZuV2p4aENmUG8zSEsxL2lHTDJVeDkyaDNvalNPSW1ER1U5bElOTlVleUkw?=
 =?utf-8?B?VktLSXQ3Q1NLTXptOEN0dlZPREdNM29zWE5QazJ3SkZob0VXbnJiRFJ2MHpu?=
 =?utf-8?B?b25CaEFsRFZidHNMUGMyM2lpdEZwYWlkdnh0ZFRaR0dQOUVPRlZtQ1FkR09o?=
 =?utf-8?B?TUlRYVN5c0lMME5uK2cwRSs3OTZ0K1lhODdtVmM3STVOcWlNS1JHVXg2VTZE?=
 =?utf-8?B?YVBJdXRiQXhWVEpCbWhJSmZ2ZzVPYlNNeFJuaitEai8rUU9rWTdyMGtIYjlk?=
 =?utf-8?B?MGJlRVNoQUlTMEtjbXZMeTRUZDJvcnVhSlBmbWNnYitaZ0RDQ0lYcEUrYjQw?=
 =?utf-8?B?RVpoMDVNV042dkNXVlBaL1l2SVlhZ2lWTWcyeDZ3OTlHTXd2Y3hIVS96VUdm?=
 =?utf-8?B?TDRJcnJ2KzJvdG5rQTcwSisvTmZicHZrSWdDbjBtdkhGVGg2QkZjN3RHMDdV?=
 =?utf-8?B?RHA1eDRGdnp2OW5ZaHg3TzFxTHVoUFJrOXJ3YjRiTU9GUnFWeXl3b3NwcDhL?=
 =?utf-8?B?aE0rd2QzTFIwNUN3YXFXTDAwZWdOd1pQUXlLUzIzUzBDWEYwVGQxUTJvakVs?=
 =?utf-8?B?dzRIaHU1QThzOUhzWnluU2RGZE16N0ZyRmhzQ1F2bldSbmVoN0hLU3pCK1ha?=
 =?utf-8?B?NG54NGx3WGpLUFgxM0NrQnNSdGpEUnh2S0dyZEhaRCtpSVpsSThlaWlzcVE2?=
 =?utf-8?B?Ulg0eEpXblFiR0hlejRNVkdCTWR0eXZCb2FYVEwzV2F2U240OW45YjFCQmlI?=
 =?utf-8?B?cWlxOWJQV0xmdjB4aExaRUIwWGF5RmRjK3lPUno4MGgyaVlBNVpwMlkzK1Ur?=
 =?utf-8?B?TlpVUWlER3p5cSsxaExiVUxFbTQwMGI2Zkp2VzhuanFIcVVjQWYzU3dyTlVF?=
 =?utf-8?B?dkxOZlZUYURyNWhUcnF5SWlCa25BVmtsYXVad1V3UXdyTFJPTzZtUTdlRHJJ?=
 =?utf-8?B?a2NSVUJMeFphNnd4bFd0RXhRcUNlOGl0UE1mNWVrSzU2aGVPSkdzaU9hTkdX?=
 =?utf-8?B?WGc2cVhmeCt4bHBCTUlxNVlPUkVGb2owVHdFK29sY0EwVy9LbHk2RW8wcHFK?=
 =?utf-8?B?MStKdmhtYjZRem1rbGl2bU1QOEE2NnpicnJxUEVvZEEwbzhFa3ljQWd3d0V1?=
 =?utf-8?B?WmlJQ0hPbUFFYjhLNE10Qld2Tzh6cGhyQ1hCbGNmN29idW5lSmpOWTdxOEJt?=
 =?utf-8?B?TUlNMkwxblowSTN4ZnprWHM1Ym1LWlIzR0VaMDZwc2N0dlUrMFM5OXNHQWlp?=
 =?utf-8?B?Q3VSc0V5RHIyRDV5WGxPK2xCR1B5MnZ1Kzd3N2RRaVk3cmtGY29MYjhEQXEz?=
 =?utf-8?B?bWpiNXlRZVV1Vk1NSitMSm80Qy8wQjhBOElKUzc5b3FUUG5FYkUxM1gxZXlt?=
 =?utf-8?B?eFpUcERaaTYzMk9QMFBwRDNzeThYT3R6M3JMVVY1c0VHRThzKzRDR2xaRXE2?=
 =?utf-8?B?aTYyazVBdzRidm5WVHFnQnlWU2lpeXBNemRXVk9iODkvSFFqeXFQcmg2OGlw?=
 =?utf-8?B?bUljUS9oQnZnSlkrRlNJNTJneExKWW8yczlIdmU3ekZndm1oQ0prNU9rZUt0?=
 =?utf-8?B?TzdhYzBNaTZrYWdpb3h1SHI2TFU4ZWgvV21kR2hyL2RlTmlBWS82VDdxOGNL?=
 =?utf-8?B?UUZHQ0ZMcDBxcmZwTlRSZzZpS2p6a3RiQ0dFTVpYclhmMFRQcStGbEdJSGJs?=
 =?utf-8?B?cTAxbFBzQ3ArUHBHVnNzSG5maGtKMkhRSWs5S2htNkpBY1Z5N1pZaXVlWVR3?=
 =?utf-8?B?aDVRU1QrendRczRYS01ueUZaVHB0U0h3c3UrQzU0UmxYL1Uzays5bVRKUUlK?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aa4753-ff19-49b1-4962-08de37392355
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:39:27.9404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so8u9VQRoIQG/CStV9OqWDa/chh5RATrdMRtO1Jhx0lnfNVCs44YnbuL7j2q6JUMER1LBlFw1ZxSm7uFy34w+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB7047

The AD9211 is a 10-bit monolithic sampling analog-to-digital converter
optimized for high performance, low power, and ease of use. The product
operates at up to a 300 MSPS conversion rate and is optimized for
outstanding dynamic performance in wideband carrier and broadband systems.

The scale table implemented here is not an exact match with the
datasheet as the table presented there is missing some information.
The reference presents these values as being linear,
but that does not add up. There is information missing in the table.
Implemented scale table matches values at the middle and at the ends,
smoothing the curve towards middle and end.
Impact on end result from deviation in scale factor affects only software
using it for scaling. All the possible hw-settings are also available with
this implementation.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 54d0c500cfb6d2ed8ab664c7f0641ee531007fef..9f274822a89bf20b975c16ab3f89c6402fe630ab 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
@@ -79,6 +80,14 @@
 /* AN877_ADC_REG_OUTPUT_DELAY */
 #define AN877_ADC_DCO_DELAY_ENABLE		0x80
 
+/*
+ * Analog Devices AD9211 10-Bit, 200/250/300 MSPS ADC
+ */
+
+#define CHIPID_AD9211			0x06
+#define AD9211_DEF_OUTPUT_MODE		0x00
+#define AD9211_REG_VREF_MASK		GENMASK(4, 0)
+
 /*
  * Analog Devices AD9265 16-Bit, 125/105/80 MSPS ADC
  */
@@ -232,6 +241,17 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return 0;
 }
 
+static const unsigned int ad9211_scale_table[][2] = {
+	{980, 0x10}, {1000, 0x11}, {1020, 0x12}, {1040, 0x13},
+	{1060, 0x14}, {1080, 0x15}, {1100, 0x16}, {1120, 0x17},
+	{1140, 0x18}, {1160, 0x19}, {1180, 0x1A}, {1190, 0x1B},
+	{1200, 0x1C}, {1210, 0x1D}, {1220, 0x1E}, {1230, 0x1F},
+	{1250, 0x0}, {1270, 0x1}, {1290, 0x2}, {1310, 0x3},
+	{1330, 0x4}, {1350, 0x5}, {1370, 0x6}, {1390, 0x7},
+	{1410, 0x8}, {1430, 0x9}, {1450, 0xA}, {1460, 0xB},
+	{1470, 0xC}, {1480, 0xD}, {1490, 0xE}, {1500, 0xF},
+};
+
 static const unsigned int ad9265_scale_table[][2] = {
 	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
 };
@@ -295,6 +315,10 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 	},								\
 }
 
+static const struct iio_chan_spec ad9211_channels[] = {
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 10, 's'),
+};
+
 static const struct iio_chan_spec ad9434_channels[] = {
 	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
 };
@@ -367,6 +391,23 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.num_lanes = 6,
 };
 
+static const struct ad9467_chip_info ad9211_chip_tbl = {
+	.name = "ad9211",
+	.id = CHIPID_AD9211,
+	.max_rate = 300 * HZ_PER_MHZ,
+	.scale_table = ad9211_scale_table,
+	.num_scales = ARRAY_SIZE(ad9211_scale_table),
+	.channels = ad9211_channels,
+	.num_channels = ARRAY_SIZE(ad9211_channels),
+	.test_points = AD9647_MAX_TEST_POINTS,
+	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
+			     AN877_ADC_TESTMODE_OFF),
+	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
+	.default_output_mode = AD9211_DEF_OUTPUT_MODE,
+	.vref_mask = AD9211_REG_VREF_MASK,
+	.has_dco = true,
+};
+
 static const struct ad9467_chip_info ad9265_chip_tbl = {
 	.name = "ad9265",
 	.id = CHIPID_AD9265,
@@ -1262,6 +1303,7 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9211", .data = &ad9211_chip_tbl, },
 	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
 	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl, },
@@ -1273,6 +1315,7 @@ static const struct of_device_id ad9467_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
 static const struct spi_device_id ad9467_ids[] = {
+	{ "ad9211", (kernel_ulong_t)&ad9211_chip_tbl },
 	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
 	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
 	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl },

-- 
2.47.3


