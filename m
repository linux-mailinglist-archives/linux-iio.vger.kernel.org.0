Return-Path: <linux-iio+bounces-25989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D0C3CE31
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 173CE4F364D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038334C98F;
	Thu,  6 Nov 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CFz1pOKN"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DB2DCC1C;
	Thu,  6 Nov 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450592; cv=fail; b=aJlqsn2l0W9o87zvU3qnVN0UO00vmAyBAHdavQ0AVqCEj0IPUrXoNnM1ZxE+6SThgaaqEe5gIsxc8XeDAxjE2WfHlGjMpoFd5YTt2EdfX7an01JUrxII+Hh4MQs+sPSh+Q29etBCEQ5eJ1lK9KtAO9lAFH4tbvHsV5xnexXsIeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450592; c=relaxed/simple;
	bh=axkRrkf+Teli/2xFNFPj1iYrpssU6hayqrigQuApKiU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ahhHem1dkm7OFQve8aALqQQBowkyp84NUdDnwivnA/WCsKSSMIRRq9PEBiMh3o7WQruoX+/XDA6pnbNLr+UOePzEaFyVhVWzEZeaGfu5+3sjBkBAULAnM4a0ewAEtl4Mw3ZINbkrdejSh3hqMLgTJSTHNilY3JvuZxb5/T+Nlls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CFz1pOKN; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlKYG6utApf/PRVp+I/2FUCKOWo360Ne685ZffFJqP+Q+xjU7UODmR2Yuy9fjTUse+pdzfARqFqs0OCEQqSgZ+hVwtlc8K/o3COKg4oYW0EvHQmaZI7c5nYf40YhH+hUwLSn5KpCIcfq2PrSl4f+O/MV1x+dR49xxVa6hQ2RoavA5fOicRqb1jWGc8CQmg8EHzP2y5XKJKTnhpq8PDNP1mgmlcfQqgiTsH7Npb8nl3VI1UsuWOV6hF9P8STUeAHutcHX6Ig41sSYKrwrpvrwVqRjoZvecDLlVtscqI+I1GUsLDm9Trjx5M+2phf5DQlUyCZYjTpz6+RdjxqW9pvI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMrwmi5i48O3DBiUSp0AOmgF4h343gTsYMivUrxP7ZY=;
 b=kmcKrLnJtd+lizBmlEC99/G5TtaJk38A2Yzd4zcOjwIARP+n00VLsoS8ZS7RmUC1bDIMsRjFfiMgBIGPkN+hiRHUV7KPMjXd6inZ0/1k/QjxdaUj+lsjIIqlzxRiMLkRWX9FiItf+Wn/82PLqSL8HTOPtVgdqJyg0a1KEzt5GPD4vc8CqxhucX72cxRoKZSfOqRJe/5zALqQFf6f46E4tuX7G2hSOW6qzSLtapXqfg5OSOfFphnUAfYz49ia6H1qydjuZkqOBgbam1suf9x5EWGUsSQLXXMraL42wtVtuAvbjRPc8bHsmVp6TarV69HDLmSfggcenbKtcJrYB97cdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMrwmi5i48O3DBiUSp0AOmgF4h343gTsYMivUrxP7ZY=;
 b=CFz1pOKNIvkw2QA1oMaSMlrnkjsvSI/wMM5/SQaIUcgheCQTMJXvccSS3iSMKe+zR/J7v+WEo+/2fetpQRpQp872x/5nQrtAq3UKajkOdNant5fuAoqsisJoQRKaBekFIF+G9AE0aQDu8FD5fq8sanjGRiaF+F34oNp7sZF63fNfTA+6LIHzz+K5ssNTFFCI2Jm0/i7t5Lm4whWGV+RLgXEvUGEXJhG6c7MQtBWcQBjIoQzPTSE6kRXoBd/bb+yevZa0mz/ES1GBdABvvN5Eo9FRx4XUsljsZ6U1YlvD/tuZBbnZjmT5KxsICPq4W0C74KtSsbSwNTM59LizQopqZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10989.eurprd04.prod.outlook.com (2603:10a6:150:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:36:25 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:36:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v11 0/6] i3c: Add basic HDR mode support
Date: Thu, 06 Nov 2025 12:35:59 -0500
Message-Id: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/cDGkC/3XRS04DMQwG4KtUWTModh7OsOIeCKE8HJoFnWoGj
 Yqq3p20QiRTxNJWvt9yfBYLz4UX8bQ7i5nXspTpUAuAh52Ie39456Gk2hAo0UjAcSgqvqU0DwG
 Mdm6UwMGJ+vo4cy6nW9TLa633Zfmc5q9b8grX7t+MFQY5SHSevElaoX4+nI6PcfoQ14QVmxpRN
 4VVWYdeclBoCLdKdUrJplRVwSKliJzhXulfBVJSU7oq5TP72jdEZqvMP8pUpbUGpzMRGt4q2yn
 o9rI/s/RIpEDSVlGnsJtFVTlrvcyZctR2q1yvXFOuKhpN4oQpuHj3G2OnFDQ1VpWBDSoOPpPbK
 pCNgewWg3rlgRXrGCKQVN2dL5fLN+aESAeFAgAA
X-Change-ID: 20250129-i3c_ddr-b15488901eb8
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762450581; l=3848;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=axkRrkf+Teli/2xFNFPj1iYrpssU6hayqrigQuApKiU=;
 b=mNoV+DXe2sGOI1v2QVDWUJti2W8ImoE8NUYqmja45Nt+C88FTzopUV6SXNSJxIqfkhEBNQBzM
 m8gTTEn2ZdDBDh9T3jMPBEoadHCzntOonKuHG4o6UCUKPG2qmSlOwea
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0111.namprd11.prod.outlook.com
 (2603:10b6:806:d1::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10989:EE_
X-MS-Office365-Filtering-Correlation-Id: 101628e2-543e-4841-2641-08de1d5b025d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3dwQU5NcTVjRDVrc0ExVllpUTZ0dG9xVjMyYUVUKzd4TFVlaXRWY2Y0REVO?=
 =?utf-8?B?dVdtYitnYUlqVG9rNSttS0k3UkNobE9PNjNHQ3MyNE1OaStIQnNPQXl5dElT?=
 =?utf-8?B?R1Jvc2N1MFFFK0x6RlowbHd2dC8wdDBsbTA0Kys1NEl4dWJpRW0rYnJDYW5l?=
 =?utf-8?B?WjlSSGE0YkN5S2hoTDUwV1dJcDVJZkVPdkw0SmlVMk9kQzlvUFJES2FRL2lS?=
 =?utf-8?B?VkVlNE9lbllsZHRnejhYQUphbXZoWjVKbWppSFc3MHhyY1Q2anpIckV5YmhC?=
 =?utf-8?B?dGNGYmhaSlQ1ZXRoR2JPc096RzFsUm5sTkVKMDlHWUdZY2xqN3plNnJSb3N5?=
 =?utf-8?B?RU9WdVlCUVFzS3hyWlRURFRwRzB5NUhQcjdRTXZXZjRBTkFIa0U2aUloeUtK?=
 =?utf-8?B?ZUVmR3hNVFg5a25kUDBUWXJYVkVNTGdNc1BOa1BXd29sZ2hVS2FOMTBiclJZ?=
 =?utf-8?B?VktRQjJVelo5Vlhpd3JYRElMaFJ2Q1hTUnNiU3VHRkpLVk1MLzlXNW9ZQTZn?=
 =?utf-8?B?cm1GOE9raWFyNjlRamJOMnRnTkQ3Q3BVOUJTOWo1NW41RU5BdVRiV1E1Nmgz?=
 =?utf-8?B?OUdtdTB0SnFGNEFSY2pDMXJKRG9zcHMxOERub1M0VVdmU3ZlWUtvNmtrdk13?=
 =?utf-8?B?TzNuRSs5endsRTNRVjF6U3VHR2pnUGJEL2wvSHYyTzBvU1ZLQ01JRmRNbVVU?=
 =?utf-8?B?THdFQ0FoOWdLNk4wS2V5dlRZQzQ1YVRSUHRuYll2Q3llT3J5dkhMT3l1bnpp?=
 =?utf-8?B?T0ZWQkRTSkNuc2owZXpmeDBOUTAvZ05DckcxMmNhUVFJQW9LTVdlZmdoeFFm?=
 =?utf-8?B?RW9rTmVpS3hTOFZlbDRmWkswallkek41OEFPL1pQQitOQVpDRVNUSHN5MlJ3?=
 =?utf-8?B?T3VIRXpFN3RrNnA1L0pLNEhNRHZQUHRBa2dYa3prbFJXR1B0WnNhZU5HZ0dy?=
 =?utf-8?B?MGZaNnNFaGZZcjcrTC91amF2K1N3RlM4aC94T0Q0bjN4Ri9DL3pseWdPdzMr?=
 =?utf-8?B?SFl2WlNGL1RIT2piMUszQVZ6VVBGaVJ3aFp6VC9tcXV0R0NOTjhNSW5TcmFx?=
 =?utf-8?B?OTZudTF5eWZCdTluYlZpRFZMWDNDUkpHT1pINWZtRG13UzlxWjI5NWEzVC8z?=
 =?utf-8?B?ZUtTelVhdGtEMTBtaXc5czgwTDZRSkdya0dJWEhYbzh2Wi85OTNUazFaRWQz?=
 =?utf-8?B?MzJaTnY4MmhWZjNMN2w0MWpDTC8vWkUrN1hxb3FRZmZRVndOMjdwQVljL3BZ?=
 =?utf-8?B?UnRIc0VTOExFbG9hSXRTZzhRYU9OU3JIRG52b0xiWFErRmd6U2JKcHdlcEFk?=
 =?utf-8?B?UnphSzgwTVlHTVhXdXppU3RudzhGNjdrbTg4aWxBczNGSjZGMElJTk9kbGNP?=
 =?utf-8?B?QnBubzJoeGdZQUhJeGVPM2FxRDE5YzAyeStET1M4ZmlNeHNMbFpzWDltVzBI?=
 =?utf-8?B?ZTUrWXZGc2s0SVU4YnNEMWdRTGtxY1FYUkNPR1pTZTZuZTR3aEpsSU1hTzZE?=
 =?utf-8?B?b0ZYcEQ1TkgrVDJ3clB4dDhlS1MvMHVlVEJVS3hJWXlLdnJlMDJ3TDRCaWEv?=
 =?utf-8?B?NTNIUUFoSm4zYWsvem5ZanFEVHc1aUxnR1NLdlB6V2tsR29NdG1BVUgvQURi?=
 =?utf-8?B?MkZrS0tndHZrclBCR2xvTytRci8xSlI2cms3aWxQRjN5aGYvVmJmT0xUaVZU?=
 =?utf-8?B?WFhTMnlyZE5MRFliMjZrSW0xMnM3azg4VnZYRU9KZkFDazJXRGxINjNXb09h?=
 =?utf-8?B?QWtCWk1UejJRYmVzVjI3WGRmSXlQMUN0aThWTXpURTdKRTdkVld5ekZSNVZv?=
 =?utf-8?B?aFF1UkVmcE9mNkwxTUkvRWJKVExzU2EyZUZvZlV3bnk2U21uRXlnZDFNa2lL?=
 =?utf-8?B?cEg0ZytTdWluRVNJUTJ4WTBZK1psZi9UcTZrQmxMME1vRHorK1Z6MXg0c0Fm?=
 =?utf-8?B?WjU4dU8wUUlFd1ZlUGVtTmhCd0h0ZVdSQU9rL24rTUdtbENpaUlpZ2VHQysy?=
 =?utf-8?B?UXB4RS9qWlFoZ2M0ZU5Xd3MzU2JsSFJKTGJWeE1uNGxMQmxNZEJIUGFhUTJv?=
 =?utf-8?Q?mkTyzK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVJOUdFTmptbVJBbk5FdmZVUExWN3VaVzJNOGc3NVFEOEtnRGxQb3hNU01E?=
 =?utf-8?B?eTltbXRyblpkd0l4R3pZSlBNMGdQMzN5MlJPUnQweUVvcm02UG9PYWRGRk9P?=
 =?utf-8?B?b2Y0Vi9TVnFCcE5DRWViczBSVmtVWEpITGlicHN1cHVvcGRQTSt2NlJ6M0F5?=
 =?utf-8?B?MFNnOEpSMUV4L0ZtKzRlMnJzamx5VTFBY1kxMytkd1FtSkx0Ty9lbVJmbW85?=
 =?utf-8?B?djJ5TitjT3lUNlFteWZMR3hubEdBUC8xejZUNEc4TlJGVEtsZ1RKL09JUnFE?=
 =?utf-8?B?aWtsNzNJR1hqaUt0bVpEemswOWhlRFFFRWYrRlUxT25Ob0NhMTduUm40NUdy?=
 =?utf-8?B?VFAvV1Z2NHlIeFVyWXRrVms1UnNCRUw5cVZJaGs4VkRCYVlVOFBYMHR5M2hY?=
 =?utf-8?B?UWwvS1FBZG1VSythU3BIdUU5YkI1OGZzaUtmNk01ZjR1UkFyYjdlSDR1bldk?=
 =?utf-8?B?YXlvbHc1OU96VEl2dnZTQ041WTBCeU9tMlJRcEh5NURLQ1RuMmlFMit4bldU?=
 =?utf-8?B?b1Znc1IrRThxRmtIUkR6Y0xWN0N2SnpyYk9rY1pCREZYOGt1L0hxZzk1c05L?=
 =?utf-8?B?bkNCNDNHT3RadWFIKzYrVmJuWDdRbUl5UWNSWHRIOHNWbnAwZlZ3emhqZ2Q5?=
 =?utf-8?B?QlUxNmZ2OHprc0pTa1FTUlpqT3NHMk1UeStoaHRTNUtNTS8wRVRoZG5HV0VU?=
 =?utf-8?B?djdFZ1NIdDZCQmpJSEpWUGV3UVRsckJQbThycTcrald0c09QakFXelh2SkFq?=
 =?utf-8?B?TngzQkIyMDRnWlhiWkR4cHJEc0Rab25Jem1XdW5KeGlPNllNNXM0YTRpaVlx?=
 =?utf-8?B?Mm41SU5HTFRiRk5CdXlYUFRCWFphOW5Wc0tmaXFoVzBFOW1GYXpSK2wvWWNF?=
 =?utf-8?B?dE1teHJ4TGJWcUV2azY2ODZPcUtxNXNjUHlHVHliWmxkckpYdG9wd0dhZVhX?=
 =?utf-8?B?WG84UTF4d296UlhsdXdIYTJHL2dHUVhKSDVlYnNOeHVPQWhXZzYySE1oSzlV?=
 =?utf-8?B?VUJnRnV2T0V5S3BTUEl5L3BEYmMxbndTUjIyWDd2Q2FBdTlPNWIwZ2Jpblp0?=
 =?utf-8?B?VERrNkNOU0pNeWducTkzT1lHV3ZWNHJxNTM1SXp6bFEvekNHTnVwOEpPdlZt?=
 =?utf-8?B?VW5Fd1REdC9VdnE5SjhEd1BuU2tHUnRaQ3cxVkw1d3VBNHJQRHdHSWFnWFgw?=
 =?utf-8?B?L052a0grUC96dHFOc1ZrdlYwL3YvZTZZZmZucWxnRFV6NzNsNTVNNHYrbXpZ?=
 =?utf-8?B?SHkxSkpOeEpIMEZlamxGWWhlakRRK3A3eGdudXJodWcvZXA4VnVpSzJUakR5?=
 =?utf-8?B?c3Iva2RVNkEycytvTUU3anJITWxibW5KNzNKMTY1blZrRGxReHBQeTJEdE5a?=
 =?utf-8?B?MGx3V1lRZHFKMHNTb0QxUjBhSHJSMlgxdzJTSzdqaUhLend3RWNBd2VyQmxh?=
 =?utf-8?B?Qm1xSTVwTjdiQjFZZXlJNlk1TlF1ZDcrZytyNG1wU2wzam9hdzN0Q3YxNHVI?=
 =?utf-8?B?R2grQ0Y5d3FKekZnUncwVS9qemRGOUJzZnJ6MlZkRm54QmNFbUhqQW02NlMr?=
 =?utf-8?B?TUNidFRya0xKUU0vdGg5U051ZUFZV3ZRR3YrcGxnWFZ3R0ZFeVRzRVlqQjFT?=
 =?utf-8?B?RThCYkcvOE9wdGxESmdBQnBvaXBHZHFENnZ2ZEtHektXR3k1YXIrcCswNHpn?=
 =?utf-8?B?QU1OMkVIazhjQVlUTDRPeG9oY0JxOUl5aFZxQjAyMk8rZG1abmlZMjM2b3Vz?=
 =?utf-8?B?N2Z5U1hOK1hCM0k5NUpBUTY3SzZZdGNZeG5PbXpYbXBKdTM1MDBMUXhvTzkr?=
 =?utf-8?B?cnVXbUhFSWUwQW81ZmdQMW13cE5vWVBtTEVOd1ZqNjBRSjFsUXBnak5GMXFF?=
 =?utf-8?B?Ui8wcnhnR1dEMEhtYmxKcndLZmF5SXFNQmJjZHZMVURXaWFwSjlQalUvTzZK?=
 =?utf-8?B?UEY0Mmk3eGd3MzVNMnU4dk95aDgxOVcvbkhDaWVTOURDQWY0djF0K0IvWERq?=
 =?utf-8?B?NUMzbVRBbDRiVGdrdnVrZG5vM0srZHd4YkpKbUthZ1FBakExNzN6ZkIyQmcy?=
 =?utf-8?B?LzFtL3l0MEFWaERoaVdWZHNEaW9QTWlJcEI2QjFZcUlOZERBTTlXVWRnYktC?=
 =?utf-8?Q?BPB2uHZewZLpZXiYRyPtntttC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101628e2-543e-4841-2641-08de1d5b025d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:36:25.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mw+5fz07ad9n5sgsJy+8KtH+CiIHNyDoeXAjLSIG9y79vg1DVfRotkO4DP1Rryzq/xS+wTvGetPXzotcHKcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10989

Add basic HDR mode support, only support private transfer, not support
CCC command.

Update i3c framework API to allow pass down mode and extend driver callback
function.

Implement HDR transfer in svc i3c master driver.

Simplifed HDR flow is (ref i3c spec line 5514) Figure 129

<--              SDR            ---> | <--- HDR
START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)

                                    ----> |
HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT

Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
read/write command.

svc hardware can auto issue SDR part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v11:
- Add Andy Shevchenko's reviewed-by tags
- fix some nits at mmc5633, see patch's change log for detail.
- Link to v10: https://lore.kernel.org/r/20251104-i3c_ddr-v10-0-e3e4cbc17034@nxp.com

Changes in v10:
- remove !! at svc patch
- align datasheet register name in mmc5633
- remove reduntant regmap_attach_dev()
- see patch's change log for detail
- Link to v9: https://lore.kernel.org/r/20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com

Changes in v9:
- remove reducated check for ops->priv_xfer.
- improve mmc5633 (see patch's change log for detail)
- Link to v8: https://lore.kernel.org/r/20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com

Changes in v8:
- Add cleanup patch replace framework's i3c_priv_xfer with i3c_xfer
- Link to v7: https://lore.kernel.org/r/20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com

Changes in v7:
- add explicit define for I3C_HDR_*
- add missed include files.
- detail see each patches' change log
- CONFIG_DEBUG_ATOMIC_SLEEP=y
- Link to v6: https://lore.kernel.org/r/20251014-i3c_ddr-v6-0-3afe49773107@nxp.com

Changes in v6:
- remove acpi part
- collect Conor Dooley ack tags
- Link to v5: https://lore.kernel.org/r/20251007-i3c_ddr-v5-0-444184f7725e@nxp.com

Changes in v5:
- Just realized missed CC mail list devicetree@vger.kernel.org and resend
- Link to v4: https://lore.kernel.org/r/20251007-i3c_ddr-v4-0-3afea5105775@nxp.com

Changes in v4:
- use master's hdr_cap to check HDR cap.
- add mmc5603 support.
- Link to v3: https://lore.kernel.org/r/20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com

Changes in v3:
- Add new patch for change rnw to union for svc.
- Detial changes see each patch's change log.
- Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com

Changes in v2:
- Add sensor driver, which use HDR mode read/write data.
- change priv_xfer to i3c_xfer.
- Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com

---
Frank Li (6):
      i3c: Add HDR API support
      i3c: Switch to use new i3c_xfer from i3c_priv_xfer
      i3c: master: svc: Replace bool rnw with union for HDR support
      i3c: master: svc: Add basic HDR mode support
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 drivers/i3c/device.c                               |  27 +-
 drivers/i3c/internals.h                            |   6 +-
 drivers/i3c/master.c                               |  19 +-
 drivers/i3c/master/svc-i3c-master.c                | 115 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 585 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  42 +-
 include/linux/i3c/master.h                         |   4 +
 10 files changed, 771 insertions(+), 44 deletions(-)
---
base-commit: df05ef50ada6a8e2fe758adf1b8fa35eea801b2d
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


