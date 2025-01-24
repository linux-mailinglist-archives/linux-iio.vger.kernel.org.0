Return-Path: <linux-iio+bounces-14554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0473A1B872
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520F61884DEA
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266314A624;
	Fri, 24 Jan 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="nu8dwiYb"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2413AD20;
	Fri, 24 Jan 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731339; cv=fail; b=QbukMbTyhjLxgU7F+qFj1d1JzC6CFGKa/E34ZW6PWha+8uLCVpgAibqz7e9HtOsm8al12HBOkJXL/hcGiXcfGvRnSjwNjsfOUcU8tHmVWZBWO1MrUzTpxICNgkZe1j+MrejtnWSVrGzEFV2gnUzHFAtnuo65kkm6X57TxQ9Lj9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731339; c=relaxed/simple;
	bh=5NuNQ0c8D+vLwnnpR2muXeIhoiT5iD7YTsP4Zzc1hH4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FvClIP9RdxSSxh+fyYKalKoL2WJ/nZpJr++gRsWB2gX6B3QShILTFXao31NlQhARhfpAwf0ZCjgLoG62lvbWQ3IGrxfM+pTWisHRLIC8k+9c5nwvFAMuyjRWiITbjCy/4SS5gDvUmyQzAjcKDWOiH3v0Jj4rSCqdtgKA43oS8UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=pass smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=nu8dwiYb; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frjlhJYBl2tHgDcbM2H9fQ4OOHMS7RUVrAbZ1T5HydDy19J+g+XEJpCRz0C12sPTL6SEMOsGjGTH0Bk38yBKiYvdvsJzTMwGTGI93QzWw69luJuuBPMu3lyuX/ZlPqi47QAik34FwtY2YgjeVXG/z351SbbhOv9Xs3b4Rrxr/CrtVQIu+Iy/VQsx7MzFxOGL/UE4qkCLyIHknOsSLuEtQ9dW7L85h7E2IEwWAcjmdvZ24h9a6wKLOoK+ORKPwdcug0oBlmR7djcBodMVnsT8S6YsVPITgXub5bCj5i/K2KPenQgRaUHX2qOmbIQkmlzO7qFzU5aVf5XYB1GclOOg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCcQMGyf8M4UR3tUKSETD1uDLqR3FodT1tlRePVY7XA=;
 b=bJYyBO1ckbfb8ng2m7H2zN5awKBeJXiWjFhg2nqdPnQUBDBRCsq1vbXg2jNcCPCYhZhm7aLMO7gPEHASbV2W+TQ6BnoOw4C5ujGirtKAGt5YATl53N75ORLuEepd3L/49BvgsLVSvqDhK1etezYzgH4izekjS9o+3I51/5eV2TXAer5asXtN+nsIkAUaO3eAHNQ+4OFtQ5fXhPxZ/pdFk4WyB/8++DQu65Uw+iI821ca2rJNtaJ+LSH+PPz/YaKv6xvDPUH2h2KlhZPIdXW11uCDjZWJSVCTvUD1BqWCN1n3KRySUtz7fnE4hDoNyEs+P4pf072mQuWUvr3306Zwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCcQMGyf8M4UR3tUKSETD1uDLqR3FodT1tlRePVY7XA=;
 b=nu8dwiYbhA502Fryue5UkU10AoUBH/UYhiszBuoDABJQTxkBiqpDl+pL3b2kqDByXUJ8MJzCLvuwUrCCYWHvZ3PNYr5/9hi6SsljIPEZ0k+UhhGlMg+qcPoH9O0M0N5gXwjNqZm030o4v2JTFOdAvAsj/0424ga7YqP0UWtzSCMEjdTrnQFUskKjGbgwW+Md9wjlNbFL5vXR7RWyevlmjt23dJ/JCnzP9v428kA8aLYAdW2nk9TLzby0bCJuVFKiLQWiY71vhiarR2onX+jLApabaabUYmY/0IwDovVpZovnF8C5K3LhlLmbBf1mM4m0WKs6wwBcGwRkBnxP61KZNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5399.eurprd03.prod.outlook.com (2603:10a6:10:f5::22)
 by DU5PR03MB10423.eurprd03.prod.outlook.com (2603:10a6:10:51b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 15:08:54 +0000
Received: from DBBPR03MB5399.eurprd03.prod.outlook.com
 ([fe80::2fec:64f5:1893:f53a]) by DBBPR03MB5399.eurprd03.prod.outlook.com
 ([fe80::2fec:64f5:1893:f53a%5]) with mapi id 15.20.8356.010; Fri, 24 Jan 2025
 15:08:54 +0000
From: Markus Burri <markus.burri@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Markus Burri <markus.burri@mt.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2] iio: adc: ad7192: fix channel select
Date: Fri, 24 Jan 2025 16:07:03 +0100
Message-Id: <20250124150703.97848-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::17) To DBBPR03MB5399.eurprd03.prod.outlook.com
 (2603:10a6:10:f5::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5399:EE_|DU5PR03MB10423:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a8611e-f6c9-41a4-3a41-08dd3c8904c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFBKb0RtZW8vNlIvMnVVd0FhS0xBS2tZMENjQlllSXpoZUZwT3U0T2toclpp?=
 =?utf-8?B?SU5VTi9sTlBUZFVKNEpZVUI4T0J2MUhURnhtYXpwSmtPOGlRby95bDRya2FY?=
 =?utf-8?B?N3g0R3l4ZXVwYmJTdnQ3UHp1emljalN0QldCK05YaGM4cDdXaW5YTUNNWUZw?=
 =?utf-8?B?a0xpVktabmZsNXkzejVPblNnZXU2T0R2TEx5dDVaY2VraDViODMzSko4VGx4?=
 =?utf-8?B?WmQxVWZkN1hPQVNQZUJjNGJ4WVoxK3VYK3NkNEtzQjdJWk9WQ2xqUmxqNGZD?=
 =?utf-8?B?bkxiV0NzalMyZlFEcFJoZjRMd1lkaUlPa2FPeW1GcVhiQXJVL2dONmp6elJE?=
 =?utf-8?B?Sk5pTVh3bXJVTGZZR0xmdEVwOFBVOTNpRTk1amVmcjZUSkhHQzBLOXBFSUhY?=
 =?utf-8?B?Si9Kd1JjY2tHcGNQWnN1RG01VDlXMWUxVkZ2L2lMUE9XRmZhbitPOVdNRUxr?=
 =?utf-8?B?c3M1N2FJVDllYUlBbW45ODdVOVYrblFMc0R2YUJyVVMwQXBHUk9UdDBTWFlo?=
 =?utf-8?B?L1VpYWM4bmphQS9HVWt3MVFzd0YzZnZXemhYZ1k1TGc0SUVaOW5FQ0FxL2JC?=
 =?utf-8?B?WERja0RLYlU2UVJoWFZTekIxN2tVcEhaNEV4N1Z3RVN6WUE2b25MVG9HdFAr?=
 =?utf-8?B?WkphYWpDK2ZqZnA4cUIrNVl6cU5ETlJ0SUpNYURiOFBCTVZ3WUJYSlZEU1g2?=
 =?utf-8?B?MThWUWlwRjlRenZnbmRoODNxazNGSjdPR2xyU29MZkRvTld2WFdhZlpGbUhs?=
 =?utf-8?B?alh0MWRvU2ZoTTVETkd0RmhncmtrdkFhMi9EWm9sbTFtUHVGaFBXMms3QUpY?=
 =?utf-8?B?cXNDMFFGTFhvQ0pvaHp0ZjBLbFBQOHEvMkRIRnJVSEh6K1RDYktHNElGamV5?=
 =?utf-8?B?eTFIL2FEemlPelBVcWJmSXNMTHdMMjNYaGpjSStsVXk0QXEzUjA4QzdLRmZw?=
 =?utf-8?B?YUxFdmh4Qk5WNmwrUUJqRFZTZFBlcWVITm5tNFZJVDdYbDNQT2Q5MXA5U1do?=
 =?utf-8?B?RkhCVFN6anBHTTNVNCt2cHJOTWNYT1dGUDdYTUhWUHpSWjk0UXdoU0dFd1ZO?=
 =?utf-8?B?T3M0d3ZsYlh6UDE0VjFIYThVSDRWM25qeEdudGF6cGEveCtvQms4MVRaNHZa?=
 =?utf-8?B?TlNEY0VwbG9YR0ttdDI5b2g1cFVpM0hVa2hXMDFCSWhMdjhxVXNmNDB1elBV?=
 =?utf-8?B?NXBIeURJSCs0T004RHVaQnFmaTBGMnJuMGF0T3V6aU9aYzdsMFVwMlVwNzdT?=
 =?utf-8?B?eDRNdWR6azM2bUh3NlpFS1hBRzZMTTlhdTdNTEpVbmI2ZFpuSGRKcTBOaDRv?=
 =?utf-8?B?Q2x6Nm94RDNzYml4SysyR2tHbmVSRlpmTmhGYkhPSWdmci9VMzdrLzBqWitE?=
 =?utf-8?B?QUt6TWFNWnE0RzE1cmR1em5XM1dnc2I1cEZORmlRazE4MlRDeHRUTW5ZOUV3?=
 =?utf-8?B?NG5tS0pZZFJFZyt5b3RZZU9MOUtHVEhnbUNhWElyK0R0NGU0ejJCaTFJdnhj?=
 =?utf-8?B?Vkp6cGxtWlNjUVF6UE95YjcrUlpyNWE4RGpQYVdZZk1wNUlFN1VYcWJVTjlT?=
 =?utf-8?B?NU9IK2x2dlFhOWxQQ2FhRVRUWmVqbWphc2pvUnM3bm1nWTRzQ3gzNHhnQktP?=
 =?utf-8?B?Y3kzbFZseldWL3FLV1RTV1JUVmxyTmk5VFlML0lKRXhlTDYzUDhaaTFjZ3ZV?=
 =?utf-8?B?QkUrcStCME5NNDVPakZ5VnZLNkF6MXhjSXVBMDVudkc5OU9yQ0RGZVZucnVE?=
 =?utf-8?B?VlpCZzEweGxQUGZ1OURseEl4dW1iakxsYnZ4amJhT2xRaG44aEYvd0hrbTFE?=
 =?utf-8?B?VzAzSzc5MTJ1cTluQUlZNnNFb0xvaTErM3dVc0VyRDhjV1ZuUTQyLzNlVVly?=
 =?utf-8?B?UTlva1N2MXhqcHFLYXFsTXdLbGJoVlBCOWUyVkEzaUlGL2dUdUZxRnJUSmI3?=
 =?utf-8?Q?dSFwRG+9bzs+eI9NXh2gmyOB5BioyjVR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR03MB5399.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0hEb3hGNFZYTThjWUhFbjgzSGUxUG9KNmRoQjdCMHllekFMOC93RFdWT0NR?=
 =?utf-8?B?S254ZTYyRzJOSTNZWHhlWm5DbDVkd2kwMFBHZDJOTEx0MlQ5Ky8vdldQNTJp?=
 =?utf-8?B?QS9OVGJLQXB5dEhVeHg0KzhyNTZiL3JTZURoZVlrdEdpMk1YY3Zlc0ZsRSto?=
 =?utf-8?B?R3dtWUZYRXRvN2lUbUZvTlRhaUg5cmNxT1IyMnBGZmNESzFPSVZJd04zNUxi?=
 =?utf-8?B?UFlxSHZOR004VFhqbjM1ZHVaRUQxMXlRTHAvWWtkKy8zZHBGSFV3Tkd1VEYv?=
 =?utf-8?B?R25Bd05hOEVhKythTkNnRHlXUDYybEJybENpTUNYVW9EUjFubHNiS0wrZ3Q2?=
 =?utf-8?B?RlVuQ1pTOXFDdUJWUjRiblU1M25mcVJLV1NhV3c1VEN3aStoOGYwTXVNaXZL?=
 =?utf-8?B?bUpDKy9JYnFIVzVxWGE5WlR0NzI2c3lpQUNLdVh6Z29DMEpzdzRUYzVsblBQ?=
 =?utf-8?B?RXAxd1pXVmhXeFhDcEc2UnFCZk5nQ0EyWm0yNHZUdnRkTU11ZXdyZzNVNkU3?=
 =?utf-8?B?WjBIL1YzaS9ocmE4UkxpT2dGMk5CUlVCZVN0Zk53dEFXWlpRQmw4dk1JTDBh?=
 =?utf-8?B?ai9ocGN5QkZlRy9ZQ0hJZTdWTExITDY0eEREeEZIamtLY1gwb2RRNEhuSGlZ?=
 =?utf-8?B?dTFCUiswVzZXd1prZjV4bDNPSVRwNGFMeGZJT28vbGVjSHlrY0gvTzJzWjBk?=
 =?utf-8?B?Y1lzeURVb3RSWDdoL295U1FUQUc3OHFwd3dGS0twdEZBb0xmVzRBUEF2dW9j?=
 =?utf-8?B?b1BvTUFiTTRWMXdPQXZtTnhxYnZoR0Z5OWpjOFhpRnkxSlBFQVljcE5HRjU0?=
 =?utf-8?B?ejUvOHZybWsyOUk4YmltNzZkRlFLd2dLazl0THk0WVYwNW4wYTJiMEMwVEx6?=
 =?utf-8?B?VVpIQlh2ays1WU1NejZzYVFuSTdadTV6aTRTRWVqTmtGT1oraUhSY2FjWE5a?=
 =?utf-8?B?dTFpR2s1YjI1S09HSXVWSnRPZGNSY0tjdEVhVjlEKzArbVc3VTN6K2F0Vk9q?=
 =?utf-8?B?L3N6WjZocDZFQ0p6bDZ3K1pvZVBMY0tHUzVXc0xUYVBvc1VsMHRUaHoyY0ND?=
 =?utf-8?B?OGdTOEVmTytSVndOQXphOEhDTmFtVGFKREhYNGdLekR0SGFnZEhaY0Jtc2RE?=
 =?utf-8?B?VHBoRlBscHQ0Wnl6QzAyNUJxOVBLNEdoalBrbWpvUmZHMzZJSEpCZHNFdU5H?=
 =?utf-8?B?ZzQzYU9KR1Bzc01pcjBBY3hyV0U1bU1rTVpsdkFJZnJ4MG9WSUZxbDhPaU9m?=
 =?utf-8?B?K0xka2dpVFNyNWdqU0NVMG9IbzJsbW9kOUtwYndSOTRSYVBtdm9DVkxTQmpm?=
 =?utf-8?B?cXJKeVRnYy9zczhNS0NoZitSQzQwUHlHNnNrSTVDc3RmK0JWUmFFSjJUWkpQ?=
 =?utf-8?B?ckl5eUFiMHdTdE1ham5DUUgrZEtVbG1wQzJ1Z1VmTEd5M3p6UDJuK0RWMENs?=
 =?utf-8?B?UEI4ay84VzRFQW1tb1RTYk1heGRuZHV3MVgybm1iSmlyQVd4UzFvcVB0VG5i?=
 =?utf-8?B?T3orQ0tFWXkyY29VaDlScEVTb3pzNmtXYWlRc2JlNVhTU2dNOUJKVk8rK0Jr?=
 =?utf-8?B?WWgrMzgzQlJ0QnZwRmVmOGVzdnNYd3d3Mmdta29TRm4zTzY4ZEpYODdXTXpq?=
 =?utf-8?B?TXlic3RyQlJnOU02ME5VZkZEWUYwdVZhMVo5ckJ5ZWxjZE8xZUM3aWQ4aEY3?=
 =?utf-8?B?aUpWV3RZcitPaWU3S2I1d1VTN2dKUEt2SEVUdWhNSDlvQTZWQldpK3l1TGFS?=
 =?utf-8?B?K3BlZmFYdjhtcmdDdFlZWHg3VWtLem5qRjNGNGpiTGdVY3o5d3AwTW1jd3VJ?=
 =?utf-8?B?dFA4bm9IWllEcHdsTEFYWjFYZzNCQXNraUZzaDhPN1g2dkNKRU5DRUVWL3dv?=
 =?utf-8?B?a2szWk52NXpqZUZMUmIrR2ZpdVlJVmVacnJLZW5oZVlKc29mT25mRVJhRC9G?=
 =?utf-8?B?cFBSS1RUT3gzczI0dDFJRjQ1bzg4eTg5cld5ZGg1L0FqQnZhSzgzWFFCUFpH?=
 =?utf-8?B?MElsMVExci8yUWlkWkxlZUpMb0pKSE1pUGtMZGRrajJRMStWRHpvNTVPMXc4?=
 =?utf-8?B?ZVpPZHRDeWxmbXF1eENsdUxuTHJhaU9oeGg5NDNrRHdEYjlrQlZNNWF2T1V4?=
 =?utf-8?Q?P67oPd5FWlOi/QslgSkdStoLq?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a8611e-f6c9-41a4-3a41-08dd3c8904c1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5399.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 15:08:54.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC85t+j4j0ZzgbHBLU+UC19U/0Xp/xfLLzMLh9o5yvBikxDVwveERP61oW2Q95hSUSmFQpRL5yQHx2XruCubgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10423

Channel configuration doesn't work as expected.
For FIELD_PREP the bit mask is needed and not the bit number.

Fixes: 874bbd1219c7 ("iio: adc: ad7192: Use bitfield access macros")

Signed-off-by: Markus Burri <markus.burri@mt.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 1c87db0e0460..c4effe8429c8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1082,7 +1082,7 @@ static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned lon
 
 	conf &= ~AD7192_CONF_CHAN_MASK;
 	for_each_set_bit(i, scan_mask, 8)
-		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, i);
+		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, BIT(i));
 
 	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
 	if (ret < 0)

base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.39.5


