Return-Path: <linux-iio+bounces-25774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6996FC26300
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCE5D4F8505
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA92FB0AD;
	Fri, 31 Oct 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aITui5mu"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8C2F1FFE;
	Fri, 31 Oct 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928858; cv=fail; b=mD9peWiVyGVBx0lXJqsxv5xB71j2+QdD9tobOWcA2GOAqA5QA7i5HtNNNBHKMH5Wtf22TF8kEG3jdqbeRpOpkwENAyLYa7WzA2NpaELgjXsgR5PVO0t3xhMu85Fz1jh5+Smz5Vf9N2fXaVAIIVEKHaE19D+Ko7fet4/JxE+Az0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928858; c=relaxed/simple;
	bh=MtNipip3mm8U9aiWoQ1K+nU5RjAoMS9jieFnn0iQcOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DiLLpfsl8nIPvdzj+c5HW/8VZWJHqw4RU9I/8KoKU51k8884xZ72xex90vGrOtcmx34XnPFhDQ195zc2ALtRr5HI/82E7am4VrRStviqLbv4/dgLmQh2HdnVoPrzjx9VNXuCSo3VM8dWdF/9tflkWRs0CexnBdFC/W9l9Msk0A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aITui5mu; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaPGuzDKqlVVh9LZYrxl+nLbbyqADBQ3Xm30X8KkhRY0ZqkI/2YdVW0+ka7p43pquvz/eogve9a8r+z78Rb60mjomIuIij+OXaItk1S8LjmIb9wu0G3ToHKetflTrOiO3ZIxD5dI3LfVsxcIp11bv7sYEGyITWF3aex3up4j8k/U4lvQR7XPpRC9f0f+ZUQTRIR/g12nHPTCIpnzDw78yHDiWLkgm++rM3yVqVukWntGIFDpXVshy2Z7qS8LwH6O48ZPKVp18ndpwmNLa2P1a9WoY6KqQuSUTalqI5RVg9uLb+GeExl7mlZDRtgUOhaUn5PYzw0FeTZ7KYFB7X/yXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QG7k7+vQnOqD/I5Svlzbt4gIIDu0jDiCTGT7+NgEPQ=;
 b=pLBzt5JEoIZTGQvdYAUiNs43ayh+te9axxMXD8MFAA0Tu1Dv12rzkLigFDFbB1U5DZzGFR6ZM7F2x8I86kOLJhJPZq9mcPhcAwm67UwOB110AaK4qaug7iH7KogryJaS3oqWaMA+Ub/VIG98v5aWHBhG/aYeLOcNS0DEcT5ohKwgrr84ft6CAygrVI9NCvR1zNm6CAKjf/mpgQONIaEE+ph6o3iwIXorAF3n/XYmbrkGSKXy2WFkA0BQ/+rGb4K18JuWH+hXFYwN5ns4azwl8HhrRWuP1ei832MvxEQkrSUx5pEHgmBTNtCIFapZHY+H4rKmcMfDIhwPHAz/1LLmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QG7k7+vQnOqD/I5Svlzbt4gIIDu0jDiCTGT7+NgEPQ=;
 b=aITui5musTubpP96w6mmbRYyW11l4HQ/3p4P9PsmVlit0OkQyxl89EOzjrrgU8G/rtxRznlwKCb3Q3K06Jw9p77Q44Ax85fUEs1vip+Cx5wG1JSWIltSLRRN0Ymr/4inPzkXRjXZuj9yWSzYhegab+GCHbsyf+jXAnw3GfnHBaCRAI8AeJMW0wr26jxWKrofiG4kySyUDYMTxHnbHSyaN+eepwdQ2uIjpQ4+VzyEUf8YbYZiYNxkmnVP5lvKYbiDqcZ30bJQ+emozhNxc3nHpUgmSP/QHInkCF+LzX86h+QozDJkDrKu97ec1YveZ5nA2TbroYpDASp+nSLuVDDbVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11533.eurprd04.prod.outlook.com (2603:10a6:10:5e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:40:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 16:40:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 31 Oct 2025 12:39:18 -0400
Subject: [PATCH v9 6/6] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-i3c_ddr-v9-6-f1e523ebaf78@nxp.com>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
In-Reply-To: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
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
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761928780; l=19445;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MtNipip3mm8U9aiWoQ1K+nU5RjAoMS9jieFnn0iQcOA=;
 b=eWfk1CoWVrSFTKVZvucvyYVxOhzw+crMIUQZi4md3jOJ9nyAUnrduP5xVGrJHJdCuCCN88yhg
 KSwRJ3N7CXYDEgCUCj1QjuLVdQ643PTeA81glA4T+knsihaduo+H+ZN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB11533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9debd1de-fb8b-42c9-e75e-08de189c270d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVlEcW5UdnIwZlFqUmdWOGRvMzJsQUtOWURQV1V6aUU3NmJ0YW1may82eW94?=
 =?utf-8?B?TXJjaXNWaXZYK3JsQ0hwMStBL056Ui9pRXJFeUxyc2UrVnpobHVtdGt0ZkVC?=
 =?utf-8?B?Z3lid0w5TzFzakpxdkNZTmNsYnBzbEUxZmMzK2swcmdnTjdsSlNlNE5XdGZO?=
 =?utf-8?B?TzRqVVhDS0RSSmgxUWRNMFBZRFp0NTIzMHo4VVVDeVNJWnBKd0hlRHo2ZHNs?=
 =?utf-8?B?c09DNWZYY0VrZnlOd2Y2MEc4eUloeHlTdEtFbXBqQWdtaGJZeDVzS1BJZ1k3?=
 =?utf-8?B?WmF4YW01QnZnYUYxMFptNkdUVFhaV3hIWGFRUFN2bEkwY1NnUC9PeS93SWN4?=
 =?utf-8?B?ZVptQTN5a1pQRzJlWjJVeGt2a2FKcmhCc3JxNVlyY3Fjc0I5bU1NQUNPUkZm?=
 =?utf-8?B?a2lMUTJ2M0FXRy9hVThVaXY3MXZRUWM1bUhjbFNQTFhGZzE2YithUzV3NUsv?=
 =?utf-8?B?WmFJZ25rbUZDWWtDWjJHVUcrcUdWQ01CSmMzM1E4VUIwMnYyWXM2WDdQNGRB?=
 =?utf-8?B?ZlF0ZFdJUFkxUUg4Yll3Y3VRd1pRZGZtRGF5ZlhGeDBLbk9wUVFDcWNmNlpQ?=
 =?utf-8?B?RUtJNS9PRTA0YUgzNUQ4MUFXWFR3U0k5UGJBejZHdFBSdE92Y3pBMzB5Z3N4?=
 =?utf-8?B?dWdiZlFiMnNwckxscXA5MnhBMkVjUlg4MklFanVmVzNQdVBGeDkwbkgvQU40?=
 =?utf-8?B?RURyZnNhRkZGVFlwQ1ZKK2I2RG9FRlJtdUR4VFpBQUVJRmpQd1JEY0FqaGVW?=
 =?utf-8?B?SU9BMWpKZjkwdzZabXJWd3BWaVJOUS9KVTBxc1BKZXJTeHh3b1ZIbCtjTmRR?=
 =?utf-8?B?Y1YyVHBnQkxLWGJ5R0NmL2ZtVDc5eU5wTExBY3lEektvSGc3RDM0N1JETGJL?=
 =?utf-8?B?QTNEREVWZGtudzdaci9TVUdYNVVVNXZpd3FBdVRFMzd6ZWc3T3lzWnkvamJL?=
 =?utf-8?B?NXVCeGljOVNWdjlkVXB1cDJKeEd5ZFR4UFNUU25JUmxpcHZZSCtuUkxORVNY?=
 =?utf-8?B?dU01UnMvREVlckNKT1Ywd2RIYjdmMThDODlxNHptRHZEYTVTbDd2Qk9icmV1?=
 =?utf-8?B?OEptb0JPMDRXS2hac0tJVlkxR3FCcW5ScDZrK3ErbWxQTDkxdWlxYmJoejVv?=
 =?utf-8?B?VFIzRTJpbDZ6a08wQi9weFhvK21LU3BmTUNLTmZPOVJPeTBDcVdvbU1rWW9W?=
 =?utf-8?B?Ylc1YmIrdWhFRUYzb3VTUWdrMjA4QWF1a1JWMnVxMkdhY3F5cThhMWQzbitB?=
 =?utf-8?B?aDhYb0pxWjAya2ZuRkhNYzZZK3ExMkZIbjMxVWVCNytiMzhWVDZKWGtMZmta?=
 =?utf-8?B?SDg4Ry9naEcxYVFPem9nWTN2eGY5a0hScWlsZ3QrUE5OVnZSQUxEeEpuYjcy?=
 =?utf-8?B?SHVJMUlZb0ozWHB1dG5FM2tISWNsZytvOVNrSDJoRzVUZjRVOVdnQlpoNy9k?=
 =?utf-8?B?ME5qV1Y4MVlXNkp0dHZUWTZNekhDeGpqb2loWDk4QjQ3R1c1SHA2Yk44UGIv?=
 =?utf-8?B?NnVRdytmNzhRamlRQmpldHNaSElVOExKdHlaUHdlL3hFZExZOTJ0SWFPenRu?=
 =?utf-8?B?SHlFdjlWd2lvdi9MSm0ya3RTV3VpbytURlp4UkkwMXNDZWNKcTBKZ3RYNEFZ?=
 =?utf-8?B?Rkp1dzdkRmJTZE1nNFEyTlk5MmZQendTZG81bndQZGlsRXBHS0Jnc3VMOEpF?=
 =?utf-8?B?TG01OVpsK0lJczU3elRzTzRaVWhEc2k3ZkQvKzJ4cUhRWVlvSElTUytQcW1Y?=
 =?utf-8?B?TTdsODZSWGJXZHZ5c25QSnU2V0EvaTZTNkRlRGFSSTBQdmZrTTQxNnRja0k5?=
 =?utf-8?B?NzUrOUdSK0h0bDNmWjY5dUVLdnV6VWQ1TG1RNXMxRzY1MVpRR1VtUElFZFBv?=
 =?utf-8?B?VG5WUE1Vd2tSbXhvQllSTmh6Y1o4WlQvWDk2Q1NLOUI0eXI5UUppZmlaTnph?=
 =?utf-8?B?RUxmMkpnd1l3Q0k5b2lHU2ZGNys0RjNJU1EwN0szTkRrM3BaTmM2M3hsa0Ro?=
 =?utf-8?B?Rk1YUUFYdHdsc1c4bnJtaFlQbWt2ZWovR1NNQzVEVWVQOHlWSGJDK2YzcjlZ?=
 =?utf-8?Q?wLricS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHdWS0lCR1B3VzNMMDVhcHJycjArS3NJVGR5TzZvcDdDdkR5a1ZQdjBVd0VB?=
 =?utf-8?B?ZHpMV096RW1zRTIxSjd0QVN5ck1zbXBjVUVPR3FrU0k5RVV2dXJNQzBnZS96?=
 =?utf-8?B?Z3NQZUQ3YkgxSGx0cHVYaXZ3ckxTQ2ZZUDdXQzJySUYva0VWVFVsZ3pzdk8y?=
 =?utf-8?B?bEg2NEpDT2twbHQvcytQR3gwbUJuY1pPTVlJZmREbjJaalVrWjN1UjF1Y1Q0?=
 =?utf-8?B?TTdzNDdUdXI2WW9FTlNUMTVjVDZLWm1zVHFUbFZla0V4dG50aHVja1NPQTli?=
 =?utf-8?B?TDNKY2hZQ09KSEN6elQwU1NiU1BlbmFTQ3JpaUJzZFVrR2V1L3pMVGsyb3Fr?=
 =?utf-8?B?VDRUakxGN29oMWZQZTh4YVRmQmlMY1I5Y2NxZU50bTExRHN6N1dEOVhMSHpI?=
 =?utf-8?B?R3huWmdsL0t0OExKa3dWN0tFbTRaTzdqYWdza2I1RXN5OEVSUms3OHZLSDJJ?=
 =?utf-8?B?cHdEMzVvMWtyMnVpVzgzR3NVdzFUZVZFTEpRczhGZ2E4MStqVVRrNU5lMWhn?=
 =?utf-8?B?YWdoby8wSkdTMkxYNDJGcDh3WDkxdzBMV3pIK0JyeU51ZUkwK3l2RFVwTUFy?=
 =?utf-8?B?OEl4NEZLVzhobmNWN3FUaWZuejkzV0swNmUrMHkrMUlsUlplS2N3OHNxR0RC?=
 =?utf-8?B?UEtsN0NqaVFGbG94QWtzVThoWUs3SU1ndUpNVHFxU1V4L3lLQ3NCWENVUHN1?=
 =?utf-8?B?bThwZkhKd2d5SHJWcDA3YnU1UWdWOTlSdUluQ0R1VE9GWENidU11OXlaOCty?=
 =?utf-8?B?aGFTRzljOFpjM3oydCsrVFE2cThVTmNnUG9hU2xBMG9ia0RVMGR2MjJxUElS?=
 =?utf-8?B?ZzJHSlA4UjRwNHVNbDhnaUxWZ2dVc1c3c0dCdUZubW5pQmtodUU3NkFYN1lW?=
 =?utf-8?B?S3lrUGRneWg2SEx1aDA3dFYrdFBKVHhaNXF2QVphZDhXRmNQYlhhTWtnbm4w?=
 =?utf-8?B?U0UvcG55aGNwckMwd0VhQ0FNZHVFcHB2RjI2cXZOOVJHcys5ZFNnVkxPQmp2?=
 =?utf-8?B?KzZNZWx2cENBN0lMbm8yRGJDaHMwenhqUFJ3YVNFSWVBM0RnWVB0bzlBbys2?=
 =?utf-8?B?NnZkbEI0YkZaSnBkYUhObDBxNTk4Zmp6RndjdkkzSWVqMzhDTXMyaDlRZkZG?=
 =?utf-8?B?MlVleXZNTXBoTVJTWGRxY290VHNWcVZ3N1dZbENVcEhlZGNzQk9oQVoyRmRG?=
 =?utf-8?B?NjhPdTJiYzUxT0ZpWml3SnNQU01MK0kwcXRxcHRUU29TakN4VndtaklhUVps?=
 =?utf-8?B?S1hHWU9YYUZ4dkZ1QSsrNUpiTmhMc3c5c1BRcXlNeURWWHgzUWpBc1ljcjRN?=
 =?utf-8?B?ejFtaDJSN01URUN3STEvQUZtekVaaHJ4QjhHdDMzeldGcjJ1WDJ3ejZGMUxW?=
 =?utf-8?B?aEwvT0dYcG9LSTc4N1UvRk1JbFBSbjE4RnBHRzVuamRMSEYvTjg4ZThrcFpY?=
 =?utf-8?B?bVlIN1NxaWZqekFqa3J5ZFg2dDdEV3BQc05mRVo4R252OEYxT0JocVBXS2dM?=
 =?utf-8?B?amdsYmowd3JsN3JpK3ppZFRROXpVd2JqL1VCQjBheklJTnFieXhiT1pwUE4z?=
 =?utf-8?B?dmczSTl0aXJtZTFnaFp6MjlaWjFTWUhKdXpSM0RYVGN2TVVyZkg1RDlrcGdR?=
 =?utf-8?B?NnlJYUt5c2J6Vy9nN2R3ZlNIcTJodUVSVUJsZnk2YmFOR2U3bHp6TVBXTENo?=
 =?utf-8?B?dUhzSGc4UFdpK0ZVczd0cG5hZHNBUlRVMEhLR2Jndmh1TDV4cXpjNjhzKzhV?=
 =?utf-8?B?S1NzcjNsY3k1TVJBclhkMFZBTnpkTU1odkk5NG9PdjZySmU3UGxhR1FKZ09o?=
 =?utf-8?B?dVByTkdHdmVPS3BRdE9KdHI3enRyWm10S25iWDZONzZwSjM1WGQ4VjBIYzZO?=
 =?utf-8?B?MUd3WmNtM2M3Z1RpYU8wMDVqU0dNSkVHQjcyMTVkc1hiNWRJWFhpU3pmVGZr?=
 =?utf-8?B?UnkwckpOZk14YTVCTmZvaW1QckFoR0tCQmlTVXprb2EydVZGdnpMdFUzSzFl?=
 =?utf-8?B?SVFyVVJiTWFLdGhwaURIVTFURkxjNE1jc3RHdW5GSVE4YUx0Y3luN3FYZHpF?=
 =?utf-8?B?bDgyVlRUNHNCbzNFb0xsZ2tEYzRNbVF4K0Y2bWJhRktDWGcxWHV5VS92dVps?=
 =?utf-8?Q?nTME=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9debd1de-fb8b-42c9-e75e-08de189c270d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:40:08.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTrxXP4F/HJo60rb84B7GKUftUVspVZIDaseuxBHCgh/MhMxXlIWpvOlua9YZ7337vrz75lZn8Wdp4VGVT58kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
 drivers/iio/magnetometer/mmc5633.c | 598 +++++++++++++++++++++++++++++++++++++
 3 files changed, 611 insertions(+)

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
index 0000000000000000000000000000000000000000..55b5bd52abe85cd120ce2249ad2a2cfaad6a6a21
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,598 @@
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
+#define MMC5633_REG_XOUT_L	0x00
+#define MMC5633_REG_XOUT_H	0x01
+#define MMC5633_REG_YOUT_L	0x02
+#define MMC5633_REG_YOUT_H	0x03
+#define MMC5633_REG_ZOUT_L	0x04
+#define MMC5633_REG_ZOUT_H	0x05
+#define MMC5633_REG_XOUT_2	0x06
+#define MMC5633_REG_YOUT_2	0x07
+#define MMC5633_REG_ZOUT_2	0x08
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
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+	struct regmap *regmap;
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
+	unsigned int reg_status;
+	int ret;
+	int val;
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
+	int ret, val, ready;
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
+					val ||
+					status[0] & ready,
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
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
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
+			      const int **vals,
+			      int *type,
+			      int *length,
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
+	case MMC5633_REG_XOUT_L:
+	case MMC5633_REG_XOUT_H:
+	case MMC5633_REG_YOUT_L:
+	case MMC5633_REG_YOUT_H:
+	case MMC5633_REG_ZOUT_L:
+	case MMC5633_REG_ZOUT_H:
+	case MMC5633_REG_XOUT_2:
+	case MMC5633_REG_YOUT_2:
+	case MMC5633_REG_ZOUT_2:
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
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	ret = regmap_attach_dev(dev, regmap, &mmc5633_regmap_config);
+	if (ret)
+		return ret;
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
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "mmc5633(%s)", dev_name(dev));
+	if (!name)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	ret = regmap_attach_dev(dev, regmap, &mmc5633_regmap_config);
+	if (ret)
+		return ret;
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


