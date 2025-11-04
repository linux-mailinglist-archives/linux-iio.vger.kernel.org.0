Return-Path: <linux-iio+bounces-25885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C23CC31EA8
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAED74EB35C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD12741A6;
	Tue,  4 Nov 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lFW0JY4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0A273D68;
	Tue,  4 Nov 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271252; cv=fail; b=Q36NuObbNBcAyLpHUCLJueDp9GiZqtBbBgIV9VmivvFyA+ofKcOGVC2G8USitJTRL7Ka8AaJQ9MMQXUp8D3NSplHla/wkhk2NnpzvAIKivy+eDfVeKZ5G5w8cAA+XKZ21DDNHgx4RuJP6cImt/ujCfsEA3k8+w8NMYUkrRr9S/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271252; c=relaxed/simple;
	bh=5vasvYWn6j296foC0KD1do8HEXNE6j61yOhJlnouXFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eriChYpPBi/u8lh9sPx7zP75SleOwSg+a/rDxDGCnAKqNHewZjGakBQT2xf+A/0JCwOtQbRvqX/1y4iVlqAIQE3lEHKauwD1a0I6GQ9r2dOimgFwhelwLcBGf9hxRVJ9kzT6C4Qpg4g0H7azwrKq8+JIUPXtb/MDMhN9MTbTG/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lFW0JY4K; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+xdBAbNyI2aCyP3HHJLmJQ55rJOXj/p+/YLQOl79apNkF2YVemF4wlHN2Y5F8tOT0IU2z45BVKCXmKWeoacC2vCzDFFQH0DMEQ7PAyJCSTrvvIh/zpPf/RNt5WOfbEK9rg08hfvEWHv77pY1heiC5Z3rtIKaqBJ61cMgAIMBUaAyHiOhSe0MeKTFV5U53l7ODingHh96KzPhHEDwoL1K8XTWrUzzG+8f1kT+yYxdtfo2Vc/Gxu9UCosVDuOaXZ939owiJ+hyOQjFsLZ5Fb07XPuFd8POFAo4jnx8nWo4PDskKXh3s5d50ebssbG2MMPAb5tbrbDUgciC7DNzvlyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XbezMuE/5oIEAd1wLivMnBG/K28HshgVytpSww3aDU=;
 b=QHdEbXCSjgiaVgxn9ANO6dI2EipHbfKlcfukbW6DyQ10d/SJ6rQBua6idTgz8/zVL/mgLDLHwfU9Ab5+WVh9ovUosBHvr6awMJP19MydT+ieDgI+KO5mEySGXtXK/8iMe/ge4Lv62AAsyaxTT9WOh4FTbRuyvKBrwMNmk/xK33g2t6DJm33TgIcvYur7e1rUVCeAbEFxZ+q8yjNMNS+JBNONlYvfPBvWwihOgIATBIxX7Kv0K8ghTC3da2hAqNdGM65er++KJ9QE6hOmyKu6V6axsCfO5wsdK34jheizMP16jJmM7kISPW+mqBtY6gizXF81CrPXx5XoXQ/Af8yZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XbezMuE/5oIEAd1wLivMnBG/K28HshgVytpSww3aDU=;
 b=lFW0JY4KxX5inNsLI7Bo+wuA0L/I9jw3As6ZmPJiDlb4pQ6TqXjgIEQGC9pIiHfbfl2RzVLFQfKreF4eziDB+7V3vWcMFBWu9xdvShrTbo0rTpVgwyVjrXWfXooYWxgAAxw7hLK3N4xukOptWvm1Fto3g/jRUh8wVmzrBog5l+AgGo0c5JdC/9Fa4hyRLXz2Qfe68s9UfMfc+sMf6UkKTS5R287x/zRuGS4qwgk9Lmt2smVFR4gW5S/lic9AdbOOgOcvz+6Ak9zLuY9to/Kan16J67uPLQDWVar07FvRS/CRx46McPEvs8gJCGHyydc2pjPlfeMJq1Yh0NLeLFcbfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:47:25 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:47:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 10:46:40 -0500
Subject: [PATCH v10 2/6] i3c: Switch to use new i3c_xfer from i3c_priv_xfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-i3c_ddr-v10-2-e3e4cbc17034@nxp.com>
References: <20251104-i3c_ddr-v10-0-e3e4cbc17034@nxp.com>
In-Reply-To: <20251104-i3c_ddr-v10-0-e3e4cbc17034@nxp.com>
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762271232; l=1345;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5vasvYWn6j296foC0KD1do8HEXNE6j61yOhJlnouXFY=;
 b=dsx5bFOmTYMLOiG895CnXKJ3mMo6fRwQuBvbzinZEaCbnqgj5LmNyD272BMiy9Hl6uQALQiQW
 izHixQlkHplDkauNtc42nAdualPA+JYjoflNJGmKELsD/RzwN95YqFB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 95903849-1135-4a2a-b414-08de1bb972fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm9ueG9zOGYrQUw3STc1M2t6K2FiRFFiWFNNTFQ4NHZxR1NCRC9XU0M2UE41?=
 =?utf-8?B?TDZNWkJhSUU1dllNUldTaGJ0NEkxUHE4UjhVejZkYXI3TUFxTG1kT0JUZFNx?=
 =?utf-8?B?T1lFeEZxZFVDT1IvajU5aklwM1piMXZwMGJyak14Z2hmSFRyNjdUa3pxa3E0?=
 =?utf-8?B?S2hUTGszcXRpaUdsZXlyTTJ4N3I2TVdVd0pVS2xXS2k5Q29wTW9JNzdQWmc0?=
 =?utf-8?B?NTRDbTRjUVE2ai9mbnVza05SOGhVTlc0UjJkWDgrbmlPcHkxY1dRK21aWHZH?=
 =?utf-8?B?a0FjUldzU2V6WGJSNlFIcjJZaFJOL3dqblVtdVZFVlVwcFRGQ3NLSlZCVnI4?=
 =?utf-8?B?QzlTeEdBUmlOeGt0NkFiaFBTZXVvMnpMaC8wdklsckJST3dmblF3elpudFhD?=
 =?utf-8?B?UzFZeXUxdzFOL1pxMXpMa244cDFvWFJOajBBd05iQkJLNUYxVVA0Umo5NmpJ?=
 =?utf-8?B?dUpGWkdiWFFKbW42L2Q1QXluVmR5UzdVSlIvNG9qdWphZDFZNVlnaTdxczZE?=
 =?utf-8?B?QkZ3Mm1HVGhYZUIrY2tIaGtxL0VWaVQvVUpKdnlyOEgzTkxRYW8vZlJJZ3NN?=
 =?utf-8?B?UW9Samc3UXZrWlVLc0Eybk84VzNCUm9OZ2RiWS9iald6QlJPKzQ3bUxIMHl3?=
 =?utf-8?B?cjRmSnhsVVlrTFFLamR5VFRPem5LMlBZN3JhaHRjZWRsUDBxTy95R3NVUlpM?=
 =?utf-8?B?S2k5SzI0a1p0b0Y3anpWMXMrMm52MGZSa1VvdzZXb2UraEVHZTFrblFWdWoy?=
 =?utf-8?B?NG0rOWpaWXA5ZFR4SjN4TjB1VDNsYU5tTUhGZk90bGljeGg1bldIU2s4b0h5?=
 =?utf-8?B?MXhzS3ZmRjBXdkV3dUV0R1FEK3NiQmVrdzJqTzUwZDRTclJUK1JEd2FtdEJE?=
 =?utf-8?B?Vnk0OTh3dlc3V243L0x0bHRiSW02RWtDWXRjZWEyeG1HUTViQUVhMUFXa2tv?=
 =?utf-8?B?NFYyM2FFMW5zWlhNZk1jcTJrM08zUW1URTlaZXpxQ3lUM3dFYU5zSFUwMDh3?=
 =?utf-8?B?NEF2REVUVnVMZHE4M2JwZHo2MlNJWVhHUWtHMFdmUC9qMWhkeCtTR3N1NWFE?=
 =?utf-8?B?NS85aFJTNzI4SFcwMzRMS2E1V2pqMCtPSTF6bTdCYXBpTm9kWUVVSld2clU0?=
 =?utf-8?B?K1Eyc3oxdGMxMitDVUR3UEJaVDZ5TndWREs2dmtQY0RDRU05UU1yQ2dmZ1pJ?=
 =?utf-8?B?V21Kdms2clZWTU1yblBtdzRFWW9PZ2RzeTlEbUNtN3E1eVpZRnlHdmdvTG5z?=
 =?utf-8?B?VUpEd1NyUnZJMDFLWi9rK1ViZ05ua0czSGFOdS9ER3k5SHpqbEQrNE1mNWg4?=
 =?utf-8?B?MnJrMzE5eGdxSHE0UWprODdCYUR6N21ndTBnNTBROE1uelFBc2Y1L1c2S2V1?=
 =?utf-8?B?eDljMVJTZmoydncyTlNRZlNmZnpkZFpzeGZVY3h5Sm9xMzBsaGQxTXMrMGpM?=
 =?utf-8?B?Zm9Ld2xXcUllWGhKRXc2bCtxNmpWWHFMdWJRS25aVXBkU3prbmVBVEZFQnlj?=
 =?utf-8?B?RFBEUzZFakZ6SDU2a1lDZ0taekYwSnlzdlc4NnRtNjluUVRKSWxlS0FkY0xJ?=
 =?utf-8?B?b3pESUU2Z3E2bUwyWEdjRWNtMTBQTTUzUE1uelEvVHBxUnBUajZ3eW9pamdi?=
 =?utf-8?B?eXpjUmlJVEpNTHVuOEgwV3hCeGlRSFVTMG9kWjFzOUZrTzQvbWVhWHBlK1M5?=
 =?utf-8?B?bGtEdndMUi8xWGVYbDlvUHhsOHd2YWFBWGY4R0sycXVFTFdXcHBOOU5uR00w?=
 =?utf-8?B?aVBqUStkYVc2dGxROW1QaitadUdqSFUxTStTRzczeG95NG01NjlSTjhjZWpR?=
 =?utf-8?B?M3hLZmoxdVVrbEZCVmJlUlBIdzdHa0xseDM2OWYvcndtdHdFSXNWNTBQR29z?=
 =?utf-8?B?NVM1Zy9rdlJ0VEFrQVhPMDZDSDFqV3lVUVlvQVhDdXZVUzlNTjIvWkcwS0NR?=
 =?utf-8?B?ajhPK0VzOWcwQjFCOEdiTjVINlpiei84akxqcEhKd1Bkdi8vVi95Wjh2TExP?=
 =?utf-8?B?L1plMzdyWm1SYnA2N04xclZpUk5wODdKc1pJeXoxQVJ5elBXSWtxei9SWVBH?=
 =?utf-8?Q?kKJfGT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmE2MU1JSGtsNmNJQTJoRWgrbEpRT1l0TUV1YjdIT3g0bXgrdThodysvYVFa?=
 =?utf-8?B?VVYrcmpVUEcrMWJEaU5vcTA1Z2pBbTZhNnUzYkZTN2t0YnZqQXJodHdVVjEz?=
 =?utf-8?B?cFJVMHJ2WkN0eUVQQndKNFJaV0NLWUxMb2R2NUVNdyttNm9PRktremNYc3hE?=
 =?utf-8?B?NEtPVVdyUUtaVDgyU2lsMDVZN20venZyZ0dldFEwYTlNY1dMaENVUUczODBB?=
 =?utf-8?B?UzhmVnFMd0RMVW84NGpydERQa2ZwNWk0WnAraThsOWVJNUpkZkFVQmNrV2hs?=
 =?utf-8?B?VXRQUHBlUnI5M2gxOTduUys2WXNQV3pnMEdZazFsVTRYK2QvY3ExeGwwSmM1?=
 =?utf-8?B?elZ1STFNNjl4SkpucEJwU1NVQzVseVJpdGVSZXljcWI0TzhuNUU1Tm5IeW5w?=
 =?utf-8?B?VlpTVUFDUDBLcklNb1paYmpDV0pFNGNKbG9rK0pKeUtFZUlYZUVSd1ZLVERm?=
 =?utf-8?B?WE5vQ09ZdHMyMk9qUEVEL0wvMmpDSUorbUEycC9QOXpaNE9Ic2JKOGZLQVlz?=
 =?utf-8?B?Ry9YZ0NhMEZ5R2JVYTcvMGhKRGs5RUtncHNVOVhQQXpYQTlqeXBCMXFZZHp3?=
 =?utf-8?B?RC91cEwxS3FFU1NFRE1kYmt3WnpEN1QvRy9TWVhSM201T05rTy9rT1NIQjVE?=
 =?utf-8?B?MndMRHUvMEFMZFpMZnI1T1VWSk45aCsxNGUwTVhUNnRKbitYWFYydFJiWUgx?=
 =?utf-8?B?bTFNR2JvaTQ1UjFrTXRJVkFpL042ZEU3QUJPN1ZzVmtHUG5KVTZReUpSclBi?=
 =?utf-8?B?SlFMWGVkRHA5L3VrSUZYVFVXQUxDeWg1S2ZpUjBrVlVtSWh1ZWJEMWM0RjZn?=
 =?utf-8?B?OEljSThiRjJEUXlTWnNzbG5iZkhRemNpQlIweGZxQnF3Q0hoN3cvSDhqZWVQ?=
 =?utf-8?B?a3U5eVE3L21XSkZjOUdzVHN0QlVtTDRXb01qcTdsTmQvVjZ3dFBPc0NZcHlF?=
 =?utf-8?B?QWdhdlIzK0s2VXFTZkNnWlFUMG5JNUZZT0Z4MzZwUmJCVjlLUldZNVlibzV5?=
 =?utf-8?B?OVVSR0d0NUdRSTRxSlM4RmViQzE2VU03Y0Y0UTdod3FNUFFoQS9sSkZPRmI4?=
 =?utf-8?B?NWdxNVJaWU9xa1doRVZVWGEvbUlDV2d2Q3ZvaVpSd0ZqdFNIa0lMeTNxbFZD?=
 =?utf-8?B?aitUaXVtMldXUGIxdzd6Z1lqLzZybmV2MjE0OVJFMDgwNEo1K0tOQXNobWRD?=
 =?utf-8?B?emZZY0w0eWpYUU9rUzJLRWJDd0paQ2pSSk1NSGw1cmhxSXVkYWdoOU9ubkFB?=
 =?utf-8?B?anA1NWFOQzNDTk9LME01S0Q5Qno2QzRIOEtLMkh0Qi85YStMQ25DOFhPTEV0?=
 =?utf-8?B?SGdoYS9kRGZDcnVRUjJ1UXV0ZlkxR1gzdEQzMVhqTk5KajV2d2NRU0ZBQ2E2?=
 =?utf-8?B?Z09xekhjWTBNamY2cEVuTUZtSnpDSDQ4V1l1MkRYYTFnd05qNUFRVTd0ZUNj?=
 =?utf-8?B?aGhObnJSS3VJdHVzQ1N3NmFQMUIxeDI0K3NrU3l0TmNhYmM5SG1oM2ROamZM?=
 =?utf-8?B?bUxCQytsdGQvZzQzTXdwd2NXUVN3NlVxeXlTczcwMFB6cytFUjkyeHlDaWRa?=
 =?utf-8?B?M3RlTWJLMDF0OG5nMnAvemlXQWVlZEFJSi9ub3dyMjlvbDF2MlJsTFNScUMx?=
 =?utf-8?B?OEJ4cUJRaTRPMzdUZDZVZzlkQzZEcFZBbzdrV3MrV3M4NkRCS3EzSUVHQVY2?=
 =?utf-8?B?REt0WUM2NzdaVkYycFhsSDR5eE90dEpFWXU0MjVaRDR6b3BmZGlkYVM4RkJk?=
 =?utf-8?B?eGhFR3FTTEF1SnExSThiTUdzWnNDYkNYaXhqOHp2amFvcnhXWGtqQnB6UHFI?=
 =?utf-8?B?VWNvQjE1eHNzb2c3UFk1YU44MzZGdUNwL1ZHOGI5SmpTRVh6QmtsTXFwNmln?=
 =?utf-8?B?QjBNK0JxMXA1OUtHREN2WXdYejloNllwRVI1b1Fjemo3cGJrcVFWMkJMYjBJ?=
 =?utf-8?B?bThNdXdoV1hsT0tlS3V5Nm9GL3kxbzd1TUJxRjd0bmU3MjNwMjRib2JNbW82?=
 =?utf-8?B?ejNBRnNUa3dCTktIeisvYTZBTXFxNnozSmZCOEREYTltZUFBYkZvS3RZcEVx?=
 =?utf-8?B?bTB0LzBQcGsxSXNRTEdpZE5Xa3V1MTNFQW5qN3hCT0N2aEVveG9abWU5R2Vh?=
 =?utf-8?Q?WpO4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95903849-1135-4a2a-b414-08de1bb972fa
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:47:25.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zef9tSVx7SRIGgUgqlFLlhOwqfXSnhfFO+OtNI+/chSrn+xg5dd2OE3rQ/NBXYuANNwyLXD5nZjtNQQ3XJsHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

Switch to use i3c_xfer instead of i3c_priv_xfer because framework update to
support HDR mode. i3c_priv_xfer is now an alias of i3c_xfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v8
- new patch
---
 include/linux/i3c/device.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f7738041f3809e538816e94f90b99e58eb806f9..ae0662d9d77eb3fa0c976de1803e9c2ff9547451 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -27,7 +27,7 @@
  * These are the standard error codes as defined by the I3C specification.
  * When -EIO is returned by the i3c_device_do_priv_xfers() or
  * i3c_device_send_hdr_cmds() one can check the error code in
- * &struct_i3c_priv_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
+ * &struct_i3c_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
  * what went wrong.
  *
  */
@@ -312,7 +312,7 @@ int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
 			int nxfers, enum i3c_xfer_mode mode);
 
 static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
-					   struct i3c_priv_xfer *xfers,
+					   struct i3c_xfer *xfers,
 					   int nxfers)
 {
 	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);

-- 
2.34.1


