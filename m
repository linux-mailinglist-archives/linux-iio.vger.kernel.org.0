Return-Path: <linux-iio+bounces-27669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B697D18A67
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 13:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E95D30471A3
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDA38E5F8;
	Tue, 13 Jan 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="xNKZZyJz"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020134.outbound.protection.outlook.com [52.101.84.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15792346FA7;
	Tue, 13 Jan 2026 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306388; cv=fail; b=VWfKsPOP92IhX8lqrBHthN2nsoN3MwzSwLY2nMgDUVz++hadZMc9J7hR9RE5x6SjQVTedv004cNmCEgTpczZSt16OJKbf+v3FxHq/KFzQfwyOrn7LW3pOkIsYjbYhxJ6qa0HZ5CyTY0xZnE39iCDYlbUN5nU/YwMLiIx2dGGaRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306388; c=relaxed/simple;
	bh=VgTme1n5niZ9JaCAhfE6fyFAx+LfDfFVl1zL+sedRfQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=UkZgO4ecXcJtVwn3Cx2tnBf6OHdTnbknbzxVdkZ0kj/+LWd+D91Cw+6lgdGaV2DL6FYGOGMNYkpSvK2UY6QsXgCzwqgpT0w9dRKXVSnc9GYisywJ917cdZ1r6NxWdBWog/CQZ6N2/7L9181REHz2WZ4Gf+xTxD2n03da7PjTdQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=xNKZZyJz; arc=fail smtp.client-ip=52.101.84.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhJouTMGsxeLMH9RhkqLwItFR4SsWP8o+u8+JCHUUp66X8mueW1VwQ2pbEMFjEXzDr8LgQDtUoBqZyUe4xUv3isWH22NDvVOlMn0Z95mBhLUebJ6P2uls9YWtEPSHm9tZxhTX9sx2NOwE1uFKP58RlvQJrqGZd8wsBhGsUq4UeE2Zhc/5z8JGy0T4nW/xKW578xJ9+6piOFAfAaGg12+Xquw81nCAlxfFaOt6gOKYLVt2qUGYQD3H9WYAeN0eAqh6vfdeX+VfwqFmQovNJN3+ava6SuZ/Jeb1TC1lRdC+eL4F2sNytGeIfYGHCF1SPZtdx+RqtgkRK6877eeWolmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhKtCSyXU6m6YhcqI6HIhDmwZ34+iAVwHbSXXJ28+xo=;
 b=t1eUE8EabjbIT1tGIByhmY/KnePVYwtZbO/CHMN/iwAti1HexJTc6gdhmes5mzuCkztMPrxAjs2POo/gVjFXPcBsgR/zO/Xaqzknlp3Ukv16c5NH5vLjcf6tTvsSnNXmTjhoFmN9YQpfOQdg3AuQmJFJMJUbDDnE8JdShA/hBIX+D16DLc5O8Bw4+AtQ/ka+IhZjYz937fIDasnJfSDAapMDsw1M/ZR3+j8liN30MtEt56iYVzGQCzUIGUBYzHlYTlHXxu+r++xKdhRW0fHWFzdjKmF/1Y08DIWAGcn1bOr0O3WiSJwyNFG3Cgd2iiGxl5Kur+ZtHdaGZ01kyxC26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhKtCSyXU6m6YhcqI6HIhDmwZ34+iAVwHbSXXJ28+xo=;
 b=xNKZZyJziFQfkWK3eLZ1RUhxWDs35HlXOpSyRPuVsJBa15tHacs97OZ+f6RKLtJkHncdBENy6U4PwRz2309mCqW5LqyMRVl5azAejUgkiasFV7PVPD5jOmn50K7lIQStzLbDM2+dDbIMDVfXqpy6/WMjGFxstYIOY8TLyZyMES5q0XcTF49J01ISVsCmFgE47vaDlqvfiErWDnUTPTBtqf+6bAcACs+gItwAsGwEXSsTlVlhts2rDchHuFfvqpgdN1ZBfFIruASBApIWYtGWPrV34c2OWCLv9Hk0kz+ZfCu90U9BvNa/fXnns3Va2lRqCA3EjxN0olq8K4aKURl1VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV2PR06MB10036.eurprd06.prod.outlook.com (2603:10a6:150:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 12:12:59 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:12:59 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v2 0/3] iio: adc: ad9467: Support alternative backends
Date: Tue, 13 Jan 2026 12:12:46 +0000
Message-Id: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL42ZmkC/33NwQ6CMAzG8VchO1tDxwDx5HsYDoUVaVRGNrJoC
 O/uJPHq8f+l+XVVgb1wUOdsVZ6jBHFTCn3IVD/SdGMQm1rpXJeosYTOANnGVDW4eUnH9ICO+jt
 PFnQxYN40zMbWKgGz50FeO35tU48SFuff+6+I3/XHVv/YiJDDqeAKywJ5MPYSSQI96Ni7p2q3b
 fsATIVdO8YAAAA=
X-Change-ID: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768306378; l=1591;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=VgTme1n5niZ9JaCAhfE6fyFAx+LfDfFVl1zL+sedRfQ=;
 b=hapsJSc35qCioLpw+gs23c4okCTe+X2Kg5o4XwSZ/Zeu+907famVwo6iOATlgcqEnajfOfpml
 ZJm5dvOQQGDDw6BpWdOagdym2yaoCs0l9Ntn6z18PWhcSWM8ciw8h2e
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF0005F6A1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::129) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV2PR06MB10036:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce15803-3ea8-41d7-8b17-08de529d179d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXRhL0NnbXBYSmRDbUMrZ3krSTdBdTQxMm9lSkpzMm43ajVpVENrUFo3MWVV?=
 =?utf-8?B?MVZjQnRIMXdZZlpHS1JaenRYNVozanpQWTA0dkJNbUVCeW1GY29oMWdWUk1o?=
 =?utf-8?B?aWptZlVOL1pCMHBVdzMvdmdmcC9mbmpyeEVKbjdpNVU2a1Zzc0Jkb1lFc0xN?=
 =?utf-8?B?eGduSUhwa21GKzZHSzdjdk80K041d0JjaWY1MnYxK0pKWUJlQTdpc1ZRYjZs?=
 =?utf-8?B?dnlEMHRkWHBLL2hpbEg5S0RkREFyNXl5bWlqWEFpMjExcTk1VHJjeFpPSFRQ?=
 =?utf-8?B?THZNVG04T2pxUndDckwva29DYlJTNEd4VUgwakpNOXhKVitmM0tSRWlyWldF?=
 =?utf-8?B?Ym5zVTRDeFl3UDQzSDM0NmJoMHB3MzlGQmg5Y1Z4UUNkN1p4SEYxelU0RXVL?=
 =?utf-8?B?N213T2hjQk5EMjM3VFQxdWdncWpiaTU4NzZodi9JV0dvaThUNmtjTmlYcnVm?=
 =?utf-8?B?MzVGcnkycEVJM0ljVWQ1VmRlUDZWZngzY2tkOFB4VFErTkRVdUxKU0liYndU?=
 =?utf-8?B?Q2U4d0NuMUFyM1NKUE93VGZDb2xqVEQzb0FRYkZEUXB6aHZNTzVNSTBIZW9x?=
 =?utf-8?B?OXhIK2NnUlhlaVBQTllMMjN2dlNybDM2dWZvRFI0S0hWQjJzbHJZVjNiN0pR?=
 =?utf-8?B?ZENLS2crTnV3RHV0NmU3S3JUT2hINXdiZVFrOGRSeFhIdDR0cW9GcE9BU0dD?=
 =?utf-8?B?RFlneGd5WWJTYkFXYjU1K1d4UiszanRybW1sSk5pZkViZGV4MXJQN09TTFRG?=
 =?utf-8?B?SE5wdHJhRG04NkdFSGNkeU9GWCs5cTJYWmRTOHp3SzNZMHdzVzhuL1U0cENs?=
 =?utf-8?B?OCtUSzczODd6VzBQVExoY3ZFTnZ0TjU3RTErbTcxeXZ2MGRwdTYvSnlDQVNW?=
 =?utf-8?B?TW1idW01emlRa2NFY0plamRNbFAzQjUvNmVTcHVsaytoOUxMWkVQcWJGaDBp?=
 =?utf-8?B?NndweGJTVi9oRllZY1IxSUhWRHg2cWp4VWZsN0h4S0MrOXdlYitSS29zTWRt?=
 =?utf-8?B?cFVmMXNYNnBPbUlrZUI3ZDRXZ040eTROY1FoTTdnMERHY2t4aW0ycnFEeGFT?=
 =?utf-8?B?dk9HRXNiSmhEYUZLS3ZiQjFubW42UVk1bVI2c3kvZ3hpcXBJNVlYRFNQb0M4?=
 =?utf-8?B?UFNPWHkyNTNZeEtDa1EwQ3YxVXJkTUZMSmhEOFRsYnpXSVFQQXF4a3ZINVU2?=
 =?utf-8?B?V05aSG1aYWpaR3pqKytlYXBubXJNaU1nSEIzZTJWZ2lrdFZrdVNxaHVVZlpF?=
 =?utf-8?B?TnB6bU5EakN6RVNBRGpLZFc4RHhZRWJPL05HNkxPWGZDZkZBdm9XWW5tR0dh?=
 =?utf-8?B?akI2enFrM2xTTVo1QnVmcmFTK1ZXdkl3UFU3WXlHbUtXSXMrWENoa3paTnpq?=
 =?utf-8?B?Q0JZRFUrckk4TTFCRzRkckRYZWxZN29HbUpGL05Kem5XcW9GREhkSDh3SldU?=
 =?utf-8?B?bHFQc05ySTRDVmxhMDJuOHBDRTBUdXNJSFU2T29LRDdMK1ZzT0FIVWpBbTVv?=
 =?utf-8?B?bU50MWpZK3lzY0ZZSlJVVU85NTEyaWxyL1JVRTQ0SlhGVUZkTUc1UUdTaGNl?=
 =?utf-8?B?Sll5UW40Ukxhb0xMNXgxSE5UaW8venFnbGc3bjZkVVI3b2dOSERsQlEyOGpt?=
 =?utf-8?B?ZGxWNGhJckEvOGJTZVJFRW9QSVQ5M0dkTlpwckZuU0RnUWp2Sk5SaVZxVWpX?=
 =?utf-8?B?V3V4WGxGa3MxVlZXQlQzZlhEeit2R1UrWnRBaThicXBNaFdDTVZ5em9PcUdH?=
 =?utf-8?B?a1dDYTZDSmpEemhWVjVXcVdhS0daV2J2bFpQbFRpRXBjWnJZQmd3WnFEcWZy?=
 =?utf-8?B?NS9BZloxS3AzcWlwdlpEZXkvemdoeWxRS3BpM252TUhVd3FjdDc0WGFvMytJ?=
 =?utf-8?B?a2FBY0VYQ296dkNpL2c4UUVDbG16TTl5cHd5Rzh6VEpGbEpGeXhnK3BjU2lP?=
 =?utf-8?B?S01YL1R1SFRDQkFZeFZJNnlwcFByVk1hNyt5ZnpRbnJ3RzNTKzRBdEp4OFN2?=
 =?utf-8?B?RW1LbEdlbm1pMnl0aUowakg5Y0xlS2d0ckFYcG5IVzg5Wkt0K21sZlllTm1p?=
 =?utf-8?Q?kcKO9M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnEyUkRXdWw2T3ZIT0l2NUZHU3ZTbWVqQ3FLQ0JsRUl4dXMxNk9aQXlZSXRL?=
 =?utf-8?B?ajhkZVc1OUE0cFF2SjVkVGwvRUozWE80aUJUQzh0LytZWHdkbDZFTkVQeTFH?=
 =?utf-8?B?Ui9YZlFFdEptNEtPWGM3OFZIekJRU2VrYWwzMVViZkIzVWczMWp1YkI4cHQx?=
 =?utf-8?B?Ym41V2VPTm9nMW9YZml6T0dkZlhaL0hVczd0cy9DSXFzZHpGODlJVXlwaVds?=
 =?utf-8?B?dkhlYXhMeG9BZnlSS3o4WVppejIySVRxdWhlWnQ2ODJzRlNBZkNYM1QxQ0FY?=
 =?utf-8?B?ZW8vdkIzM3V4dUlIWm85NGlLVFhUdFlpUWdicW95SmJRQXlQZDZaYTZVY3lr?=
 =?utf-8?B?RTVVYkNUNGFSSnkwQkwrZmJ1NGJrV0UyUDRScmlQUEkyditnU3JGRE5nbndG?=
 =?utf-8?B?ayt4MndBTXRQWXFWNjJYa2pTUkZ1MU05N2V2QzV0bDM5VEdoektGNkdvV2VP?=
 =?utf-8?B?R3hnVExUSFZEdkNoOE5KUDFPRVExZ0JlMWVCM1h2T09zQ1dEdHFUMGJ5N204?=
 =?utf-8?B?TXFLVFIyRVBqQ3pzaU5lWEJGdGVWbjluM3RSbUl3aVEzblQ3RTU1eUtrMUlC?=
 =?utf-8?B?TUhyNEU2WWxjWnl0NEVjS09jNncyMzM5UUVlMURaOXE4NmdrbGE3d2JoTWl2?=
 =?utf-8?B?ZkY1dEtsanFZbnV6aVMzZXlsci93QWwyTGNZd2VWTlNrVDRvSnVQWElkLzhR?=
 =?utf-8?B?RXZDakVscDJDbjRSaDBEMnQ2dHRaNnorWHB3c0RnazFWYzdVQXBMd2RmbTIv?=
 =?utf-8?B?VjVmMXN0ZXdhUXgzRUhOR0JEbHhWeGVvMnNWQWJ6QXNJM0VMajRLQk9FdGFK?=
 =?utf-8?B?SU9WeTAyTHdndS95ZWNYdjJtNmpQd3duWmE5T3JmbXdLTG5qSmxIMUJTUkV1?=
 =?utf-8?B?clgzWVZMOXJtSHd6Z0VGam12OXNPL2xHYmVnWHd6UThDeG0rK1plVHZVWFpS?=
 =?utf-8?B?MkxyVDJoOEZodVY3eWFUMGkxNnBzaWI2dENYdHJtMEhWYkVwS1dTYmNhWk51?=
 =?utf-8?B?dmxNc2ZKYjY1UnNqU3J3YlF3bHg3VXZyWTNZcVZmTXZ4WGI2Q2xVa2czcXJQ?=
 =?utf-8?B?eXlYbkZqVHQxRnI0bTF2MGdLQ2M2c0JyTktrSXFnQWQ4dUUydzl5R056WENa?=
 =?utf-8?B?WFZJQnNyTTRmUy96dEFJUGFKYWxqS2RMU3RhVzAwZ0tXNW9zTktLbnpFQWF4?=
 =?utf-8?B?T2l3V25LYjBHTzlVUWgwRFB5elJyR0ptdDJsSDlhUEpIUHdLUFdJWlVzVHEv?=
 =?utf-8?B?bkJ6bEpsRlRzUTBtek92NzhGeTlWTWNyTEU3cVAzMkdZbjUzN0dWZmg0S2RN?=
 =?utf-8?B?M29iUW9HckJBc2NiV09LcDRqaGZNTHZMZ3BCenpPaVFZQy81YW12RlptQ0Ro?=
 =?utf-8?B?MGpwVE5UL1B5Q0dGU3VkUjROZ0RSK1V1dUgzS1Y3amhBeitxYmFxaG1UYUla?=
 =?utf-8?B?TG9TT3JGYUVpSXFRUTZ4ME14dlFSVWZ6eVppNFZuTG5IMHFXNDQ2UEJhZnpN?=
 =?utf-8?B?bmpYZW9uNkdIUjhOclBpVUd0MWxKck92dnI0N2lPU3lvc0MrQ29TWVRqaWRt?=
 =?utf-8?B?SmhWYStoS0NTSVV4UUdDK3ZqdERVVzZINVZVWkZ1QnMwSnQyeEtTR2JCYytB?=
 =?utf-8?B?TkZtelgzL0M4ZUVwREhKWnVLcnR6WG1CcE03ajcrR2JTUFFTUEh0N0ZkVUhz?=
 =?utf-8?B?UmRhN2x0WlpOM3hCTldqSUEwVnVRKyt1VTB1VmxaUU80N3JkODR3MGNReko2?=
 =?utf-8?B?UGNGS21DZkVYc2pNeTRnVzQ0c1oyM0h1MndON2g0akMzMStUV21kUzNyMUw4?=
 =?utf-8?B?clMyUzN3OGlPQUxid25vV2dWRmtRR2pDUTArMEp2SmFveE5UeGU3ZmNmNnc0?=
 =?utf-8?B?Ukc5OHQ3ZlAyc0w4a2RzWXBtQ3pOWFpJWVkzWTg2NW9ncmtROE54eDdxaE1Q?=
 =?utf-8?B?eGozbisySHkzd3ltK2k0MGNZcWNyb2lHSWdQeWJPM1I0dXBzSWpGU2RGZFVH?=
 =?utf-8?B?RUR0MEJnTnd3bzVGcUExTmNkV2dpVG1NdkJJMm56bDhTNzNXaEMvQjV4bTBh?=
 =?utf-8?B?dk5Nb0x5aUIzZithL2Fva3RBTEFwWE1Yb0RycVFTT0JSV1Nrd2JLMGJTR0Z6?=
 =?utf-8?B?ZThMOXBUU3ZKQmZNdnE3KzAyT01lMUxWRlpLbDBDenhIYmtuNUY4T09OaXNC?=
 =?utf-8?B?dzdTd0hiSlZUNFVrbU1wSkhaM1c0clo2RHR5MkZWbk85cDZVRy9OMzB6KzRt?=
 =?utf-8?B?ZW9KbStrSXk3Ykt5dis1R0ZOZDV6R1B4VTdGN0tlLzhMSnpEUHEySXF0TGQ2?=
 =?utf-8?B?M0d1dDYwSS9yQm1tbVFyZWFEZVN3Nk4xamFNckYyRHZNNm5iODFYRXViYXZD?=
 =?utf-8?Q?hXEs0hUlqRpmewKU=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce15803-3ea8-41d7-8b17-08de529d179d
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 12:12:59.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0jZPIBb5lrp2bBJBr9rtQE9Z8wYFk1f2BSbq4/3bMZQrbv+GkxkOsOFdc/0qWi77dKrbCdcJ+X5gw/cc0a8vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10036

To facilitate backends with different set of features, add support
for defining capabilites provided by the backend. These capabilites
typically extend beyond a single operation and are therefore not
directly linked to if a single function call is implemented or not.
Furthermore, the capabilites determine if a certain set of operations
should be attempted, or skipped by the frontend. This way
the frontend driver can work with a minimalistic set of features and
still have the device in fully functional state.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v2:
- Added industrialio-backend capabilities feature
- Removed acceptance for fully optional backend, instead require atleast
  minimalistic backend to exist
- Switched to FIELD_MODIFY()
- Fixed kernel test robot reported failure for missing bitfield.h
- Link to v1: https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com

---
Tomas Melin (3):
      iio: adc: ad9467: include two's complement in default mode
      iio: industrialio-backend: support backend capabilities
      iio: adc: ad9467: check for backend capabilities

 drivers/iio/adc/ad9467.c           | 42 ++++++++++++++++++++++++++++++--------
 drivers/iio/industrialio-backend.c | 10 +++++++++
 include/linux/iio/backend.h        |  9 ++++++++
 3 files changed, 53 insertions(+), 8 deletions(-)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


