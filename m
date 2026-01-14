Return-Path: <linux-iio+bounces-27766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21703D1E417
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAFE330CE4D5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81939449D;
	Wed, 14 Jan 2026 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="PNg8SKHX"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020129.outbound.protection.outlook.com [52.101.84.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1F394463;
	Wed, 14 Jan 2026 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387622; cv=fail; b=motjbRaAnwtJQO92gMAmQR1A5wp9uPylGm0LVRrChjhsa6ieU6qGTiYN3qUJckOFYeHUYcKLLDXq43QxCG1Yp8YnAUrwr7ukHXuEdsgVMpPd7vwXVcMvdFtxS3MIDYUzNaW5hqHnhmdPDL6wjafzBEX7+ErH5/vWptlhwgZuAts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387622; c=relaxed/simple;
	bh=77F6gRkDKUYREb1rdQdATnPv5zlG4pfD8Sub1UwbfAc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EPTunCzQwiHVpPJ9UJbIyj6YrVyk5CalOYhtzLAy94wOzdqlkWT20UBwzKfzxXHNxSci0Ryj4tAVyCRYZEtcCFJB1hd3gxO4Us4aPJQphtw971MHvOXT5WP7+IFQTkxv1G8MuiPOefepW47NKO75z5ch/im6t1MDaOgIi2E3lKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=PNg8SKHX; arc=fail smtp.client-ip=52.101.84.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm+JO/UcxrCRVp0moIn2Dp8RXDhLXNCvkJ2dCSuYW2m2NrF9eKFWQReNxTvMHbQS++keKqvVyteOjHdqRNsy1WOvJ49h2ErujXH980kdTrJBKXmkFIv/pAUxWI3y1vp2UDOr0HWzkzzj4kgjaiaMvLnsTZr3tL3+1yqtOgYbkVtsJ3F69N7heZE3pTdu/uJXB9wS7BlultPtVQ3PBgStWRV0oxQgtlxVrp8Ju7w4YWqMVNN/Z9G0XLTZFZzDE8RoyODtZiVVvUTcv+WRs8bad5f6H6fyQqYU38NFsGTVUmFMzZLwSRMLVarypqcoGdVAZscId1dUr82hh0FMu5m+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABPLUZAvvyfINgLwFvPpnjGbw/N6BrTKsKAry1N5JzQ=;
 b=nSw4uIvYfvCXqULlEHMrZdp7XRKi6E4TH1fFw49fIlwJUdLmSHq5ALu/KibKliQlN1KpPv8cwKVojsa+T5DzKeRbyNlzNc2WPFDKbPubX+fdz2igvGHWm6PKGS1iBwstRB1YaHK8qJaGkrXBhNfXDBQGBh/FsCI7kXKzI/YdkPknPKpk0yFXuLxaDxMxiaaT0OrkBWIpHMANxUw/YB5TPxrMcThwm/XZXa+bT7km8xV26wY/zpWiFx1JdNDjyUSJhxZTC6xpMM40r6l4dy5mOrppOeOvXMhMoI3Dl8T5TOa5lGpwfnqp1nKlkFaz4A9VybQA7LHaH1ScDPZwR52HYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABPLUZAvvyfINgLwFvPpnjGbw/N6BrTKsKAry1N5JzQ=;
 b=PNg8SKHXzAGRAouBxaCUdMEauaOddjyHGWzqIGvlsoD3qTBJy277LDzhGrObdq3Dvhib3Y0Qt8Cf2vMb4r9+motiyM4f8PtdcCxI+5cEBUaaRuIeWvCj7dDhst60wrlyGlTKAb0qeYR5slEu36jUHfdiTpYujcBLW+UO9rGfz1VZLVLT9oaVPkiJ2NEI5pP/eaboti28WSdoh7tM/MO7ZQKiXRDFqwV1xHufONz/4W8qapbMiuCWJl2Zyi5eBe6ozqZbEMNeGeIPhbbC9oO2DANmPon+HaGJai5zJ70VapSt1/rQ6k7KoxE42hMhO7PQFS72nqUSoDvFbos+lWC/og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS5PR06MB8943.eurprd06.prod.outlook.com (2603:10a6:20b:655::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:46:11 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:46:11 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 14 Jan 2026 10:45:53 +0000
Subject: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768387568; l=1661;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=77F6gRkDKUYREb1rdQdATnPv5zlG4pfD8Sub1UwbfAc=;
 b=QuGbrkKv3bUY8owljBF1U0BxR8utfXIh/vWp7zy1LG1JqlY3m1JmR17e+jz7T4xhYc6Y+TMnJ
 9jF0OdRjv8eAIU6oSQmEkgZODN2keFD8LNIk4aWw5B3MkSWLZKv++TB
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
X-MS-Office365-Filtering-Correlation-Id: d37f552c-977e-4b97-e8b3-08de535a2218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHZmb01VSzREYVpRL0g4SUNUa0traHdnK3JoUlRiV082MkJNZzJ2RUdDTlMx?=
 =?utf-8?B?TmJ0SGpDcmVCcHZPRFFjaTBoTEdPOWhwcXAvUVpTdHZKNVhMUE1iZzJWNWpM?=
 =?utf-8?B?dG9VWUoyN0J5bHRPeVBGVTRPYXBvRzY4TjlEOXVqR1VSU3FYcEFVbk0yays1?=
 =?utf-8?B?TzdWaithdmo2UXpjd0h4WjduWWRRSTRnTnU1SE1TblBPZkREaDVEeWZ4WTlE?=
 =?utf-8?B?L3ROTDRJSC9rWmdUaGxLQUNyeUtXTEFEc1ZHNzR5U0NITTUwVWhtdVFvQmFJ?=
 =?utf-8?B?dFo2bnpiN1VpRzF3TlN3UE9wNUQ0bEY2bDBBOFNhcGd1emU3U0ZtRGY0RlJw?=
 =?utf-8?B?c2FxWThmK214UU40NjRUUlpTRTJETUJJODFRa29RSlBQcWFuNkRQMXNCYWpR?=
 =?utf-8?B?MU9qU00yMnhsSzBRYlBrOXI0NDRhMUxMRkhHci8wUFMrZzJrZnpGd0hYUE1I?=
 =?utf-8?B?aGlGYmpXbStPYmlqQkxOZmd0SVlaVXNaSWxGY3kvejNZeWRyVDVESTdYdlM5?=
 =?utf-8?B?K3BldVFITFp4NldCc2ZTZmdQQnNxRFZzOStSVVQ2OGFPNEVQNm5INDJFb0tJ?=
 =?utf-8?B?L05jSzhVeUlOek1nY3htcXIzdnAzbVU2YnFqOFVNZTNnSDRJMWg4bzVZejRT?=
 =?utf-8?B?Mm55RWd3V1Iyc05XdXY2dVpjdW5BWWZFSUVpQVdkaTM5ekV5QnFhdWdEMFl4?=
 =?utf-8?B?T1FmS0ozQVljMEw4QU5tTi9YZmd0NFFRZHMrVEdDMEhYQ3YzUTNUNU5neEJN?=
 =?utf-8?B?cGNLcnBXT1dZMnlVUSswZUt2dmhLTDdpblZnNU1GaFRTRGtseWhLMzNjWStS?=
 =?utf-8?B?eDByZnR5VFpMbDgzK2lINGNCQ0dQVmN6QkxYZUVsQVhPUUtUditFSExjOWo0?=
 =?utf-8?B?VDBodDFFdU50dWpSWW9yZWF4TWR6blZwdmsydzNYWjZYOXd0Wkk4aUhlR3Zz?=
 =?utf-8?B?aXlzbFRRYk1wakhhVEh4K09HMWNwTGlkWXFWWVhoS3AvUS84RkY5VWNCdWJl?=
 =?utf-8?B?V0hBa3lUZjlMR0RyOUNXbUorVmQ5ejhjNUJyd1hOT1dRSkQ2aVEvRDdBcCs2?=
 =?utf-8?B?S1BUUlpzL3BmV3JNQlpnTVRBR1FURHVXWXFMaVZpbUx4anBMQ2dGSTNHNzlM?=
 =?utf-8?B?Y3NLV2lRVEJ4VEhzdDI4UG10UzJ6em5zY2EyZUNLemExVndzUDRvbzFsTkZ5?=
 =?utf-8?B?bENWY0pqNWtZbytpMzNCT0NHTjlxUjlHRE5MWHhiQURVOStDUnhNNWF5WkU0?=
 =?utf-8?B?MTJ5RFpGYWJHdE9oNDVZbkFScHNVUFh4V3BUZ1RTeTJseS95RjBtdEJOR0tp?=
 =?utf-8?B?ZXNWdE1iREdLemFuaitNeHV4M0ROck9ha1czWkRqU05NYm5SdTBQMkJtK0I0?=
 =?utf-8?B?V0RPc1Q4a3BrTHJTZ3FQN3oxc05ITUwydmw3L2tWRjF0V3hrVm0rYlpYOElH?=
 =?utf-8?B?Q1Z6cmNDUVpDbC9hWm5zbXppRkp2b2I4NTdaZ1lVT09TK2RKVkMxVHUzcWJq?=
 =?utf-8?B?UzJXVUVtMmpyMkVhRnp5Z3ZzS2JiRFBEU1JJeHliRkpIMTlGMDhhOXNsUjZG?=
 =?utf-8?B?aFEyMGdybW8zbGl1TmN2Z3JWamhwU2dicVdoaytwSG1kMURjR1QxN09UNjhH?=
 =?utf-8?B?ZDFQVmYrRGVha3BpRGFpSEhuNGsyQzZRVFZ6bndFWFAyelJBZlNEaVByTmFC?=
 =?utf-8?B?eFAwd2d6WS9OMTF6YitwMmhsQ3lEZnV6SlF3cHBLY0EyRVRoTUVoZXhZUTlm?=
 =?utf-8?B?WFMxaHpiM2F4TUVaaG54V2VEUHhxZGRBbHF6T0g1a0FkbVF3cU0yTnQ1MjM2?=
 =?utf-8?B?ZnJNV2k0ci9rVUhoWnFFc1lkV0lHbUFUbTduZzZrakRrNDcvM09XcGZOQUlv?=
 =?utf-8?B?d3hkeUc4Uk5tT21WZVoyeEZDeHFvcUJYV0VuTlY4NnA5aU15WVhaUjVXclN3?=
 =?utf-8?B?dUhzTXc5eUhxUTh1dmhjVlRORDM1VVJLdi9jS1FRUHptaDlaVVIxbE1IcUFk?=
 =?utf-8?B?ZWtqZ3kraTV1aStheGVsRXdFK3R5OXpjY0NxMUZyeWNrb3JVbVIvT1VSMWIy?=
 =?utf-8?B?UGRMNERIcVQ4U3VFczA1NzdOMmpXS2dIVnRrYnJQU0NadXdsTmV1b3AyR2RR?=
 =?utf-8?B?ZmRMZ2hTQzZmNGxJM3ZDejd2YWZjUkdRd0lEcThXcHVPL3dDWldwclBCZjhS?=
 =?utf-8?Q?dKBkdDaNyIOVi4LmcdloO44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zno3RmJKZkZ1WlF6bm9pWldFNEpLVm9aUFIwZ2hBTVMrSTFNOEdHb1BwYzVP?=
 =?utf-8?B?d3hPL24vT3FUWnZQUDh4cGlieUI3YjNzOHdoMVY3M3RzbDVVcUV1STNySXM5?=
 =?utf-8?B?cFVsakNGelR4M28rQi9wTXZldGZKREkreUUzVGZURnNOemlXNlR5L2FLeTZp?=
 =?utf-8?B?eWd2ZmdWYmsxODVvN3kyTmpnNTZ6aUtzUktEaVRYS0IzcFhEVngwMDVYSjVn?=
 =?utf-8?B?U0QyM3FLeC9aN1ZaYWdyb0NUTEw4a0taSGlvaHBzUEEyV1JaUERpOE41clkw?=
 =?utf-8?B?RnpLUUtMZHZKMFNrWVBvd0JXVVRXVjlxbW8yMDJ0b3ZXaU1lV0FqUUNOSlRQ?=
 =?utf-8?B?TjhHbzBjTkFtdG1zVUJaMCtlbEdlOEo5a0M3bTJiOTZzRkxwdnVzcEFPT3pj?=
 =?utf-8?B?NGVIZEEvbHJvWk1LZXJQaitscHVrVlBmclZVenM1cWFUVk00ZU96U3hVUm9a?=
 =?utf-8?B?ZDQ0blZvd09wVyt0NWhoZG9nSnhnR2cvc0hGbTNldDFBeXhGN1IwRlJtM2Fu?=
 =?utf-8?B?N2lIVEVaaGh2dVpMWFI1NThPOWFRZVhLSU42Zi8rZDJWaTBTem1CdGtBb1Vn?=
 =?utf-8?B?akVBVWRVeUZMNVdVTHZneEplRnJQYkMyUUhXN3hoLzY2czJzN0FPSnd1V2Jl?=
 =?utf-8?B?VVRHM2QyL1p5cnJDdnliWUNRSHYzNzBCSEpoZFZNRDNuSnhFc0FJdyt2UkF1?=
 =?utf-8?B?bHlZZjFrdUNCV3hkNzM5VXJGUzJxTHZhN3VseGZqYWd0ZWxGbGpremt0OCsw?=
 =?utf-8?B?SU1qYjBab1p1U0IrZm01ZFdqNkxXeGxjS0s4aExsMVk5VUVTTk9KekgxTGYv?=
 =?utf-8?B?N1FiTUpsU2N3UlFGMXJlSVBhL1JhQUNGRy9tSkJxTjhnWThRRVJMMzFxK2Qw?=
 =?utf-8?B?UlRGTk5vRzN5MUdGdkxJSEUrQm9FRGsyQkxTU1BoNXVDTVNnM1p3T0dGRllP?=
 =?utf-8?B?bFBDb2plMHc2U2dncS9xWmNmVjluUXZlNkxkY2RlQkIyNVZsR2h5VmZUZlgz?=
 =?utf-8?B?N0RGYWdSQjkrM2xON2theUlBbStqRjFxL09CSndWNG5RbGpNNkpDZVRnbmNK?=
 =?utf-8?B?LzA3ZW5UNU5FMFUyQzFCSVJ5cE9QNXVUTGd0Y2Jhd0VuNDVYa2J1eDVhcEZq?=
 =?utf-8?B?SFdqcHdiUjJKb1d1aWVLUGRSdXFGK1ViZEFyWHdPTXhkY0h2OVpnODhlcFBB?=
 =?utf-8?B?QVVIeUkzMlVMcXQzTGlYZFNod0k3RXp0cUFsRmRLb2VIcHlCZnRzbnQ0MEpJ?=
 =?utf-8?B?akw4NXZGY2hPQ3Fka1Z2LzZyUkoyUFZxZFV2ZlNGT2oxWXNhVE9lTEQ2UWVQ?=
 =?utf-8?B?b1I0WmtmQWRicmF1dUJQODZrd09JNGZLREhjZ3Y5em1KeVNtTi8wUnpEamov?=
 =?utf-8?B?K2luOWE5b1loRHVmNjRHNHNaNlR5MjBQazBaU3ZJbE9zaHVmSWVKTWorWnFx?=
 =?utf-8?B?Uk43RFM5b1FIZ01uVFI0OVUvaXVhYS84dm1mLzBHMW54VC9SalhmYy9oRXFu?=
 =?utf-8?B?R05EV3A5UVIrQ2srb21UdWl3cC9kZkVsUFVkTmY0SDF3dmJQRFMzQzBvdmtu?=
 =?utf-8?B?WDBxM1FIU3I1TGMzcTdTRFJnNUswSFZ1eGN4VDZCT3RWb2xQQVp6YXNpTnBv?=
 =?utf-8?B?V0RpcjJ6QnNGT3luS29xdzhUWDZybzd6VTFkY0VaMmtYa2VxL2dzNENQTlV3?=
 =?utf-8?B?UUsvaUR1Wnh0dWVnQzJRUmg2akMrcU1yRTlrQVhDMWVTY05yL0wwZmczakFP?=
 =?utf-8?B?b2tuZUNMa3U2Vy9WNVR0UmhSWXpMRy9ZUzhSaVpuc1FNOTJLOE9nZWJoTHpp?=
 =?utf-8?B?d3VrUkxzRjRNcm5iR0dGa3VUWmxIcXNCdVpvZFJ0ZUhHczFaN3ZoLzNGbVly?=
 =?utf-8?B?ZzgyR0RPeWVmWUZYZkF1LzhJT3RtQWVGb1o1R0lNNDlHbFVvY3RHc2Nyd3Fo?=
 =?utf-8?B?MlJrWmNUN2dyMUs3Z1hZdWVNQXZYa1pTaWgreVlCOXZPK2xqUk1GcHB6Rm1L?=
 =?utf-8?B?U2x0ME83VDk0bVpKdVUrbllGZ3V0U0FxbVd5YWlrUysxR2VlOTA3bzBCZTBM?=
 =?utf-8?B?eFdTZUF5MytUc2QxcFdaVXBiT3gyLzhWbmwzU3VqLzI3Z0s4RE5hZzEycVhX?=
 =?utf-8?B?dlFESGN6NHBIcnFUaDFFUlBvMmt4QVY3L3plbmUxeTdDcjVwRmFlTllXUFFP?=
 =?utf-8?B?WHF1alVhZEVPcjQ2b0xzeW9mVjZzbjVER0dPSXNaKzVIcXk0ZVBBTE5ocUQr?=
 =?utf-8?B?MVVYNDNGRWZNd2Z0QTBBcWZ5V0xUNWNremVCVEEwb3JPenZlYWhMTy92QnAw?=
 =?utf-8?B?b1RyQ2l4bW5DeFl0UENSeFRxZ0NNWktoaVlBSGFialpLZVMyQzd0NXZGY1lB?=
 =?utf-8?Q?clQOAscNHt2fR3Sw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37f552c-977e-4b97-e8b3-08de535a2218
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:46:11.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztZ9wGtzpBE2y9YV22Bg3CfVzBuD1X+R/dltL9cGHkYdM1/opO5CAWkf8t31NdsIj1z387avzlIhYsI7J2LuHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8943

Add capability checks for operation with backends that do not support
full set of features, but are otherwise compatible with the device.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 9cfe66425d4e91e215cccc40e24a92c5e99e9b87..349779a049ad68b4c9f72abfc40154b4a3f2e095 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -645,6 +645,9 @@ static int ad9467_backend_testmode_on(struct ad9467_state *st,
 	};
 	int ret;
 
+	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		return 0;
+
 	ret = iio_backend_data_format_set(st->back, chan, &data);
 	if (ret)
 		return ret;
@@ -665,6 +668,9 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
 	};
 	int ret;
 
+	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		return 0;
+
 	ret = iio_backend_chan_disable(st->back, chan);
 	if (ret)
 		return ret;
@@ -807,6 +813,9 @@ static int ad9467_calibrate(struct ad9467_state *st)
 	bool invert = false, stat;
 	int ret;
 
+	if (!iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
+		return 0;
+
 	/* all points invalid */
 	bitmap_fill(st->calib_map, st->calib_map_size);
 
@@ -1357,7 +1366,7 @@ static int ad9467_probe(struct spi_device *spi)
 		return ret;
 
 	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
-	if (ret)
+	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
 	ret = devm_iio_backend_enable(&spi->dev, st->back);

-- 
2.47.3


