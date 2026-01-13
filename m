Return-Path: <linux-iio+bounces-27667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9CD1890C
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 12:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89A4D3003878
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5138BF80;
	Tue, 13 Jan 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="aQU5qhLt"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023075.outbound.protection.outlook.com [40.107.162.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A562C026A;
	Tue, 13 Jan 2026 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304970; cv=fail; b=W6CqlfXS0lBvpVQr8ZvihpFXCrMZFDk8m83Hs+RCWcRu3K1nQbP7oVtmCV6A7Ss0Im5mgI/L+YKswEAkqGFChaVLgZ5MQ8gGEzIEEZWbcfu8gnV3NkQNDnyGmkM9Clm1m8Hy3lpLAocVcPCUrtW2HPOxv8FVMFrOn0qMt7PfumE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304970; c=relaxed/simple;
	bh=R061p3ed3DC143GVCnHBzlQweSDkZmZXT9ZG19xCdHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bo0ngXSATTKfUdSUXkFAyXaSV7rHNugw1RJyrUMRSR/eNuBKpJm30dhNcwE9VGHcYHNsqBoDDjbVYYNX3TsvfUoaAdNzDvjMhzihhQknlFwNkD0z4Yt39VztZpgIq7v0Lh931fd+fhxNWcH7Fl9d6nvjKRReJNtqGBFg7VJ/Uxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=aQU5qhLt; arc=fail smtp.client-ip=40.107.162.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W719jhVdy5+mhU4BU3kIMffNZYXHaPSIa1hU9RPVgsl8PZkeAKKOAz37eUAi6+Lb/M66DqXLJbull/8zumIedhM6uyWcYIOjm2Cxflxty+20fsHXAQXWCQS2qUnJisMgfmSzWvrRwSy/IPp/d3CxSni/SznChgQotpsKv9ckRrURvvG76P/V5ja5DnrkPBeKPGbE7vt6278cL62bDSic8am1YPRtWC27zygTgfaVePVXWAUroFIkJPEh7vSzYEghQqJhqTQqFI2TVwcNAYQkJUIvDyE2GGifslUxn0F9dP8WeezmOXY2Vly7YPjUG5+CFnoAOEVKnRTU+c31YB53cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oggmrz2qoF922sVMG4WrhpwnUmF7KlPdP6y8YuMhmpo=;
 b=vmSfgyrZ/JGyO886hTchTYPXDv7YkBl6l0vJWxBbaGbltzOzQllj7YS2Zk0AqYLICKXugFhaMdxcnX58D7xRzv9wd8HxczFyeukAab/37QR0yuTak8E4Ck6f/Ip178i51KSRsp9WmR8lmrVlLVLHGod17Z/dRtKtXBeKCPw2xgWASdzQ6qg4AulhB4DMk555ieX0OOJew9UZzikyKnqfriVaaIngKQFl19vHfCVnVSzU1ihDIMkksNKr8yURd3XP2MUjlOgsns29cZ89b5KCQwtCoaIondI53aMdHGwVTz5bKGITzhheLI/s4RQF2NgCpMO61QsvQDVAZfJwIdYGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oggmrz2qoF922sVMG4WrhpwnUmF7KlPdP6y8YuMhmpo=;
 b=aQU5qhLt6UOz5ktXPx3U2zHQXu1IZ64dPt3F5B4M0wXEd2vDQFAEXRTrCms/1LyKcC1/3V1g/rSf5Bz4elBMsXd/9ZcaDHe5JETEdeCFc+G/0rWr4i2bh7li+1pK0NIoCNsqCXY1mYy25CnmMrSsve5YS+eRq3T+6BqPbcwe6YM3IYnvL0785gceLip5xvX72iaRt9L83X98MseEepWWM7opzDxrzlRN5odLv6537ynvpSby5TT4sVL8kXMIXRY2uAQnuaycjn1jInR4ycGyTanq08ffa2+ML8oXUfTrbmBppHEnCN1O4z7Guqj/iX/RnxR5hNat+9mRKe1IrL60SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS8PR06MB7638.eurprd06.prod.outlook.com (2603:10a6:20b:33d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 11:49:20 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 11:49:20 +0000
Message-ID: <39f4b68b-0bbc-4c41-a8ee-206209900a66@vaisala.com>
Date: Tue, 13 Jan 2026 13:49:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <20251221200014.29af7df8@jic23-huawei>
 <356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
 <997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
 <20260111114109.28b01266@jic23-huawei>
 <d36d38b2ae691371c653927fcba310bc525e0aac.camel@gmail.com>
 <51085acb-91c9-43ad-8f7e-94f1e9c995ed@vaisala.com>
 <f4cd3b85c47b2829cc54c514dffd254433f796e4.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <f4cd3b85c47b2829cc54c514dffd254433f796e4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0001DC0E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::26d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS8PR06MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e75bc5-01e1-4f15-bfc7-08de5299c9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXRQNlZSMitoOFpjN2lXcm1qaWlqUVB6MmpHN3puRDBXUHJHZWhVdmpjZi9H?=
 =?utf-8?B?M0lRdmFSTElNUkNubFJVYnJMaHhsc1lPUzhqeHVFSTM2eUxFZlltNjdqRmRC?=
 =?utf-8?B?Tjd3dWtJeUxCSXE0bmI2a3M2QyswODU4LzRrZVBHeUxJQ25OOHJxTUhyVTFF?=
 =?utf-8?B?TUdZeHd2bVhLbktRSkxIRm53aWxmVVRLdVNHR2lZbW1YOFNWZ1VMZUNWMThx?=
 =?utf-8?B?NytJZkoyS3RIdXFhRU9xemp4cWRIUmFkc09pV01JOVdMdElkYk9LOFRUdGps?=
 =?utf-8?B?Q01TakxEelA0REtsVXVQbFZBSE5lUk5QWnZqYlI5RmV4L25oZUxGVlhPSGtI?=
 =?utf-8?B?TVNQTlBURGpHYlRrSjZYcTF4TS83TDFkRDVheCt1RjBFRWpXS21tS051MlN2?=
 =?utf-8?B?cVhrYWN2UnZaTy9WQk5vS012QUN6dnNib1k5WlA1c3V4VytEaUdBYVl3UXRU?=
 =?utf-8?B?UjBQVUJXamxOSHV4clpUOVRQS1JaV0F0U0hOWnlDdWFrZ0phaGt6Wk9TZzl5?=
 =?utf-8?B?OWpkM3JyWFRPdHI1SldCZ040N2RVNWJ0ZkJZYytKbFVqemZmUHZ5eEo4WmNH?=
 =?utf-8?B?UDAycHpMd1NhbWJBcXNlK3ZqYXV5TzlkSXhObklSNVU5V1diMUVVSmxkVXNo?=
 =?utf-8?B?MHhWbnQ0ZysxQ0NWakZLUER6cnRjZCtWRlVwdFVHYWJwY0NpcnRENlZCYWVm?=
 =?utf-8?B?REx3RVM2VDd4aWZBZ1Z4TitoUUx3NExDK0FleHJNNnMzdUVvTk45QkI2SFhE?=
 =?utf-8?B?eGFjTittYzF1emRST21UYVlJSlVyOGJmOElPOTdBU2tZZmZXM09JWFE4aG1E?=
 =?utf-8?B?ZmlVQXF5cHV0ZzFGaEVQUEtGK29ra0VQaHhzOFZmRXU2OGJISjFFVm9FenhB?=
 =?utf-8?B?N1JQMXRpS2FBOVdlUFI4Nk00d1JtR08wQU10NVVlVW53UkFFQXlkcnBJc1lK?=
 =?utf-8?B?T0dzSmFIM0p5MnRIQ2FrNWlXOHZUYVRINXJqeGhZWW1zNlloYnRYWmtheFIx?=
 =?utf-8?B?QVlzZUI5SXg2K0VmSHcvWlg2T0lSTklaRlZ1S2JQNWU3eDVWSXFRYzdCWktr?=
 =?utf-8?B?UjZLcnJGNXlMYUw1THRIYnFjdW02R0pGQkVtbU5EOVMyOXJJOSthOGtLY3Qr?=
 =?utf-8?B?SzRpOTIyUmprSE5ydGt5cGl5d1E2VlFKdzZ0eUVzTWJTSmlNR0t5QjJ6dWtj?=
 =?utf-8?B?Z3pXNUcrbHFBa2xFb0MxNlMzK2tvcytHdFl5MC9Zb3hBWVBaSlBla0ZCZHk4?=
 =?utf-8?B?akVoSXJCTmEzVTArVmdUSXNGQTE3TEtBRzNDaDl5OHZHbmFEMDBreFJSbENw?=
 =?utf-8?B?YWpBdFdnQzBIOXV4amcwLzV4M3V2MjZXTTh3cHVCMmxlUnIxcGo1YTliYkNH?=
 =?utf-8?B?K2pnZXJQOUg3N25SUUVJY2N5Rm00c05UbTB6RlA1SXpuMkNWbENYZnZkQWhn?=
 =?utf-8?B?UThYZDlWbFNGT0ZoNDV0eG5Kc3IwNURZOWlEL2hXOXRDR1VlbmNoUmF3QkNl?=
 =?utf-8?B?eFY1bVQwNjFHcVAxZVVDaUVBSkxjVE9aTThJdEpVQUhsQXBQRkM2NXhGb1JH?=
 =?utf-8?B?b1V3OUtTc05qVUVpdzNDdEF5SGRraVZVRzJKS3UxbUNCWjlRK25iZjg5Nlpn?=
 =?utf-8?B?MDZHeUhYSEtSMFBMemhZczJaZnRwWDhmRHl2cUt0MjVGQ3AvM25EblJqcnNM?=
 =?utf-8?B?Wlg3c3VnaGZEaEM2N2JYYkxzSGUrVkg2UGJqQWJtMFhRY3JpVzlzL1VZK25T?=
 =?utf-8?B?b1ZSU0dNWWJSYm02SlUvUG9vV3NTdXJOSXRCbll1WW1HTDN0MlVnU0tyQ3li?=
 =?utf-8?B?eEtzdDhjU2luWm54S3c5cXhpWDJBR3RwbVdOekRObnIyVzB6cldSZWJKdk03?=
 =?utf-8?B?SmZUemx2WU94WTJmVmFtL0JVaytOZTlQNHJ1Q1V4eUZWUnAwT1FRZWhwaStl?=
 =?utf-8?Q?MfMdCuQgwYG2C0CwKrjcH3a1n4NSTn8r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW5sSVJ0R0RpaG1HR01jZVAxUDhBVmlJQlJRdTBQTnFiSlFWMEZlb2ozWlRy?=
 =?utf-8?B?ZmRBT0xGMmJPUDNtVEVnMHFLM3BDNjE5WFdwbzZjLy8xTDNRSVRrT2o5RERR?=
 =?utf-8?B?MGk5RWFKa0RNRDZ4VWkvaThsM2JVSHYzNjVDZ0VQK3JTb1RBaUZEUitzbWMw?=
 =?utf-8?B?aGk0aWFVWjlCZ29hckJGQ21OdWNvVDBtV1MwT2RucC9SNXgwL212Wit4WEhu?=
 =?utf-8?B?Q2tCZjdkcmJZZVQzaitpMEpoS0hFUWFNZDZqNnZIZmQwOGVvZzhoTElhNlhN?=
 =?utf-8?B?aGZTMzdvRjRuNmsxajIyQ2NMWE9DbE5oV1VDU3ZPYzlTMm1vbVZ2K2hnUlRX?=
 =?utf-8?B?MWtKbFJNOXJ0UU54UTRsVU9Od29yMll6KzJXQ1ZyVms0T2pnVm5Ya1FRSzJr?=
 =?utf-8?B?Ky95R2M0dEx2VVFYU3BSR1lmbnYyT0ZlZ1VZdU96Y2NOeXJEQ2lMQmxpT2RM?=
 =?utf-8?B?bTRwUlVsSzNYMERFRUpqV0g5N3pFd0ozeXROcHBoenowYnRoMmN6TnN6T3Ju?=
 =?utf-8?B?ekRWWTdhT245OVU0bTdMUWFoeURnZFJ2ZExpOXVMMlhPZ0tyaW5nN2NOdjly?=
 =?utf-8?B?S1RWd3F5YndZckRjNmdmeUw0MVRsRVV3aW1ZaGFSOXVRTHJnQXNTNGNrYkN3?=
 =?utf-8?B?N3p2OEZjSkJxYjdGRm1JcllETnBjTEJ4dHZodXZ0VjYvVTFQVUc5Mm9zYmtZ?=
 =?utf-8?B?RWdrblExclV3a1pxazJSdTBEODlIeDhBT0tHdzBwVXNPSTVkYXJNa04yRG53?=
 =?utf-8?B?ZG1VaGZjYnFCaEswUGNDOFlhRmFiWUpVLzRCM1h3TWExQmttM08rbWVWamV6?=
 =?utf-8?B?L1d3a1NWWmcrZjZEdmluRWo2OEQ4SzNReFhnSXFQR1c2d0ttWjQrb1Vxc0tq?=
 =?utf-8?B?ZlVEWG40MzdoRmJVbkZET3VhZkF1aUR2VXdlUlJjNGE4cEx2Q0Jkc1pCaVZB?=
 =?utf-8?B?Y3ZFbHBWR0hEbVFKRnZVcm1yMEhpOHRRZjBnSDF6dkdSeXd3VlZQL0JiSTBM?=
 =?utf-8?B?dEpmTzdMNHJwN0ZrTzJOVDNlcVVSa3RTdWN0b1NJWGxPT2o1Z1NyWGhTbUhi?=
 =?utf-8?B?M3FtN1ZiMEtaRkFmMEdGZHM0VlNlSkc3L2tSSFE2VVEwNll4c3ZObnlDdmk2?=
 =?utf-8?B?WWYrRTFiclNIakxPdXJ5aTgvSW9PUlRkWndqajVzZzhVbTYvUHpSdytsS0Ft?=
 =?utf-8?B?d0pHTmdjeW1VUGNLc09zWUNjM1laMGlEeEEwVWlTTk1FNm1WS3J3dVE5QmU3?=
 =?utf-8?B?SFY5NzNoKzdDb1l2VFh6aTRLNElKRGZFK0N2S0V1L3JOc1JjWkhjdVoxVndo?=
 =?utf-8?B?K01tRlg0UCtxZmcrUVMvVnFvQ0pPaC9yR3RQeWN2ajF5SUJBMmk2S0NPQysy?=
 =?utf-8?B?QUJLOEllei81anBOdHJBRVJFZ0ZBT2s0cWM3TGRZcVZGcjVqdVdBOTFnWkVv?=
 =?utf-8?B?WTNGODVIZjFQNGU3WnBmOUhMUTdjN2tpcnRxRTArUGtBL2Fmbk1PajJlLzVo?=
 =?utf-8?B?Yk9nZWlVTk41cXo4V3dzTU1BNytpcjJBbmt0OGFoanJ5QWNXMkZzZXlxdmZq?=
 =?utf-8?B?b3VsYnNWWmNRZHB1UWdHNnFUVkM0b09QczE5YWdnSzZBbTAxb3BHRjYyWlY2?=
 =?utf-8?B?U1JkUnluTWZxMEJ0Z2ZZbVpBWXI0YmhMMFZyblNybUFRQ3JJTVRUc1JncjYz?=
 =?utf-8?B?bUFyV01IMVFNYVlFQVFvbzBpZTdFdzBEekFET2h1WUdOdm9yY2ZuWTlBbEI3?=
 =?utf-8?B?c1BLdjRzSE93NHZTMWlUSjk5UjZzTkhmZVRMQnBycG1XMTB4ajJIS2xoMVRB?=
 =?utf-8?B?aUpReGM4Yk1oaFRKNkh5UUtDcFpBN0FIZ3F0cktrbEc4Q3dmNjg0WXg3cm9C?=
 =?utf-8?B?RU5xNXFERklHMk5zT09vYzlqa3dqKzhEN2huNjhJUlhpaEpzbmZFNnBSMjJT?=
 =?utf-8?B?cHhZRlkwVWkvUmpsUXpOS3ZxOEpkUTZvcC9MWUFzTXhlaGl6ajNwczJoVUkr?=
 =?utf-8?B?bERrYTlVYStvYVN3ajdOdEk4S3BnUjh3Qm93SU8vL2JNb3VyRUtIdzVhbXNX?=
 =?utf-8?B?dUlJWk5ZbCtZazZRKzRLUVNtQ1gwaCtiVFluSHQ1RmMwdU9Ib1JPd1g2ellW?=
 =?utf-8?B?RlorZStIT1RVL1NlUjRzVEhXbmV0bHJLUWlkWUxHcGNCN2poem5LYXROSGZU?=
 =?utf-8?B?RnBiOVJoTGlHWFJ6WXpFMlpBcWY5eXJMcFY4UzltdndTalZ6WnlpZS9GSG1u?=
 =?utf-8?B?K1BFUS96RFRwbHZicmpRV1NEeUdOZ1ZoVXQwaHRCK3NWcWRvTitWVVRjYWgr?=
 =?utf-8?B?aysxcGNxZHRMaTYveEZZTmZnSE8vb2YzS28veVNXVXg0a2dmYzBSVHo5V254?=
 =?utf-8?Q?T3Qz/bf4UUnfqOpQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e75bc5-01e1-4f15-bfc7-08de5299c9f6
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:49:20.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKbuaIC9qcJV8VdiICWJcjfJARfHehxK07V7DsvnoSNpjDtvTHknYIcdGZIATqNbrB/jwEKNiB22AB/02Apaeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7638

Hi,

On 13/01/2026 12:52, Nuno Sá wrote:
> On Tue, 2026-01-13 at 09:47 +0200, Tomas Melin wrote:
>> Hi,
>>
>> On 12/01/2026 15:21, Nuno Sá wrote:
>>> On Sun, 2026-01-11 at 11:41 +0000, Jonathan Cameron wrote:
>>>> On Mon, 05 Jan 2026 14:57:02 +0000
>>>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>>>
>>>>> On Mon, 2026-01-05 at 13:06 +0200, Tomas Melin wrote:

>>>>
>>>> When we say the backend needs no driver, where does the data end up?
>>>> Is the idea that it goes into some processing pipeline and sent to
>>>> some external path that we have no visibility of? i.e. We configure the
>>>> data capture in Linux but never see the data?
>>>
>>> Yes, that's also my assumption about Tomas's usecase.
>>
>> The data becomes available to user space but there is currently no
>> immediate need or natural place to create a separate instance to
>> function as a backend device.
> 
> So do you have some completely different data path bypassing IIO (just curious)?

Yes, IP handles data reception and data transfer outside of iio context.

> 
>>
>> But that being said, I'm leaning towards thinking that perhaps a
>> minimalistic backend should always be registered after all. That would
>> keep the idea of the backend always existing intact.
>> But since the backend can be missing a lot of the features defined for
>> the current ADI backend, capability handling would need to be added to
>> the backend framework to make it functional.
>>
>> Looking into how this could be achieved with reasonable impact, I have
>> tried to identify capabilities that we could add for starters, and then
>> have the frontend behave differently depending on what features are present.
>>
>> Something like this (added to backend_info),
>> .caps = IIO_BACKEND_CAP_TEST_PATTERNS |  --> backend patterns are avail.
>> 	IIO_BACKEND_CAP_BUFFERING |  --> backend has buffering cap.
>> 	IIO_BACKEND_CAP_CALIBRATION, --> backend supports calibration
>>
> 
> Looks reasonable but I'm still a bit afraid to open this can of worms. But as Jonathan
> pointed out multiple times on the backend code, this is mostly inkernel interfaces so
> it is easier to deal with bad choices :).

I understand this concern, but would anticipate that there are only a
limited number of capabilties that need to be handled, so it should stay
fairly managable.

>  
> 
> We would still need to "combine" these capabilities feature with a dummy backend that
> would dummy implement the more common/expected like (chan)enable/disable and so on.

I think the dummy backend is probably not gonna be needed as the current
axi backend can advertise the available set of capabilities. The
frontends are then free to make use of the capability bits as needed.
In my use case, I need to implement a limited backend that does not
claim any capabilities but only provides a minimum set of functionality.

Thanks,
Tomas



> 
> We can then decide on a usecase by usecase basis on what should be a capability or what
> should be dummy implemented.
> 
> Bottom line, I'm leaning on "I'm ok with the above" since I expect usecases like this to
> be fairly rare (famous last words :)). And It would be nice to have more feedback
> on this one.
> 
> - Nuno Sá
> 


