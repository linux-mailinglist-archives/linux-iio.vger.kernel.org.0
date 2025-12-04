Return-Path: <linux-iio+bounces-26724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4FCA2BE3
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 09:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E30A9306B64B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C632721B;
	Thu,  4 Dec 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="trvIJ+Y5"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023109.outbound.protection.outlook.com [40.107.159.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05D325704;
	Thu,  4 Dec 2025 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835315; cv=fail; b=JbXw48mV+oe0iFrfUy+rryOgIfVEp0j6Ls9R0RGVCYR2+hScXdbY90Rxv+tI1dHquZbXBQloQe6bBt6GfAvE/MR4wg88kFGsvKKqac/xo8tt2dl9SNiy4tqMaRVFK/0DPXdPZyZ3niuD65Znp8291ovD5BloD5kT0xrqp0zNDCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835315; c=relaxed/simple;
	bh=6Eh2+qUIsq6NfjAILJYM0qqirBK20XZsNYgf/OQUriU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SSPANHRe22Ir1pR7A7BaWcpI1kN9f+1+q5UE10CrdSr9ctd673EnH7CicK1KGwZJQEi/wiGLKmS8x+z1dN0DMOKP62wwpYZprgzNBBGr6aXkqLHDVYtjQ4U/bfDNMcBV29zWT+gZ10EARkrZhRSfV994zrsnyL/rD1D5f+4NfJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=trvIJ+Y5; arc=fail smtp.client-ip=40.107.159.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXHWvO/RG7ETwQhyzwGyOivuihCsbB4aSEVf2smB51pQk3EhhXZwcZKMz9d6BsUEW5UGUA8UkvXNdypOtI0Fis4o24XWH6uRsPUOHUVPOwfPV0cT5bIRuvREDgXULdHUSnn0Opk/NEQFFu2rn0uOFy7MCWGWH6QymCZr0gJLT3hSseGHLR3D9uuoggP0YBbdNeNhRrP6BIKY6zPRp4PkQz9xC0baXN94w831XPy+YQ7/3wtRkv6vAp/Ri1cPN6bx9GINJz0dgTs5UVIK7PABYabFz2JIVVJWZKCfXP8gFA2c46P1FCOnBpXsyqfSwrHulIQG2yJ9Px2IGxITwHu61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDacp39Kq7v74MoBxC10LxYwS9UOLlYr9sDRsUxk5l8=;
 b=taDwpN7QM7vw3MX/Qn8mssJ4u0s0XRJB+OEKub9tGI24FJG2btYMwWcF8Z1orhlf+yxLasXev5YvfZ9FLwA6givgoY/o5n5JIYQGkrd1eQwomLqQr9Um8sMhjHAgEfyD/ZxZMmivz1nh3upvpvQFyK3UHhnSdt3Qc2+3K4SUmELATQCxSM9Ggi3e/9wwiIWLOOBqYNKrjF1R4wfHr+KEqg46uMfQg8wyn8i3+gHQM10+/qOD4LbIKfxXKMHV+X5xvPwNKJKQBiS/teUVZShbg2AQpVLU7/Q4irSiL26T286QpOGk/81sAmEvaCyrsLCqKJVPD9yyvE/TSTnPH6+oaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDacp39Kq7v74MoBxC10LxYwS9UOLlYr9sDRsUxk5l8=;
 b=trvIJ+Y5VLHw6FYfBKcIfwMGONA5Co/of1zJLsjBmXfpkledWPDGuDITAoRhz4pN/tMthWw2wrp6VYsqb0W1P68dtbY6hBJESG/F8bzy3CaDxYNjZAafVxOICoYZ+Tu+Bah8iHiXivnNGW4nRcEssPDadN93bfhAQMJ4f1wBCnLHgdK22KjRtZNids1pZ8RmWY7zJ6ptzmD6NeB8zEwv4fiRg+u0mBC2YvmW6IjIn6j9B+bqbqYXspKwT6GxKw3detFqVSrec2z5w5gHoLvjlZW2S9//4560FEMjU3QP0dUCvMFH8GP9DsO3ZS15fK6dv0tP9N/smQu6l5VFIuLjhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VE1PR06MB7024.eurprd06.prod.outlook.com (2603:10a6:800:1a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 08:01:19 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 08:01:19 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Thu, 04 Dec 2025 08:01:04 +0000
Subject: [PATCH v2 2/2] iio: adc: ad9467: add support for ad9211
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-add-ad9211-v2-2-a1561f977ee5@vaisala.com>
References: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
In-Reply-To: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764835276; l=4573;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=6Eh2+qUIsq6NfjAILJYM0qqirBK20XZsNYgf/OQUriU=;
 b=5qHtu/rtrpJ62www5HN9T78LcFFkYBjVd3kAfihnHOtzmEDTcdbJ+3GZBVFl2IhKo8FqgYibv
 3BMzCJkTE43BD0pQpBF/NRQ6Z0sKYtd5a7nkwlT7g/YKbnddlaBqaLH
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV2PEPF00003857.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:17) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VE1PR06MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: da39c336-a617-4326-ee9b-08de330b4e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDZIVkVIRlF2MEQyRjZhSytVWHNMZ2V5T05qZ05kVWtTWVIyMHZWRmV3Mjg2?=
 =?utf-8?B?VGdaVUd4Z2Q0TlN6NHhtZXcwdlAyelJ5VFY5NWVsU2J2REtCTG5uVkNmdDNY?=
 =?utf-8?B?TGk4d3NPYzhZL3h3MTFPNzVZQTdWTWhPcXB6UWJpNG1zdzhrdlYzQWl0aWx2?=
 =?utf-8?B?UUp3N2hXMCt1T0tJRVJ5aHFvZi9UYTM2QUwwK3IvbjRTWEEzbGJncC9RSFBr?=
 =?utf-8?B?V3FjbzhvU2RjM3d4RzZiOUVCcXlQTXk3MU4xckh2Ykh1d3RCVy8vdVRzci9N?=
 =?utf-8?B?akk3R2JGczBBbm9VWFFoZmQrcGwzb09jTVhhb204OTk2czJMOUhRa0dVU3Jk?=
 =?utf-8?B?bUlnczN6UDdUR0FMZGVKTlpwT0ppYlNrVmt3cGMycmNDaGZhbkQwRVVNMzJQ?=
 =?utf-8?B?Wkw4VWYzWklyeVVXcEJzYUtOOGJpRUdnUWZmY0xNUnl5REZSdjYvWEpPK2xW?=
 =?utf-8?B?T1hzWVBhMUNoQlc4UmFqTlVmN0tsdkR4UEVEbDdRQWFFeFlrVmJTTTk4KzY1?=
 =?utf-8?B?MVVVQ0ZhUTU4My9XM20raXFRZmU5VUFZRC9MQkRYNEg3cHBWNHBIOC8vRjVD?=
 =?utf-8?B?TnRnQUZjUFVhVWNKWWhaYzRiY2RNRERwRi81SlFsRWhRTGdCUFVvSVFSK1lT?=
 =?utf-8?B?U2VPSFZZT2VhTGgvKzZwTisvamtoaDFNRXlrR3BBZ1k0T3NNSGkvdzNxUTZy?=
 =?utf-8?B?RlhLdENoQVNUd25EalpQb3dtNTZwbGtrcmRVRWkzc3JJV1U5bDA3RUJTVDRx?=
 =?utf-8?B?RGJDaTdobUpod0J1NWRQRTlIQXJRSmdVckZkcWhEUlZMK2JRS2J1aHpVb2s5?=
 =?utf-8?B?dFM4eHRRUEVxczlqZ3ZXK21JNXdWMSt4WEVWK3Y4Tmo4ekJZSVJ2VHV5UzNk?=
 =?utf-8?B?TUVVNkFTR21XeFIvZTNGTGlNOStMUENkYzJ4dGRTRmMrNEpVdFdUbEkxekMv?=
 =?utf-8?B?a3VuSGloSkVSY0ZEdEZ2cElEckhuN3IrY2k0cm9TVEpwM3d1aEVPY1ZGVUpz?=
 =?utf-8?B?MmtaZDZLWTNwUFA0SUlWUmlSemMybVluT3JLRm9LLzBEQkNtTXAyeGh3eXlK?=
 =?utf-8?B?cGkzWUJuMjJsQTZDUi9pbEJYUjR0VDFZUE44d1JNZEYwVHNNb2srWnhwdTRW?=
 =?utf-8?B?MndGVHB4SXNONkhidE9OaVhRVWg4Sk84UmJBT3Yza2pLOHBBUldzUW9COWEy?=
 =?utf-8?B?QVM3Y3B6Sy9Yb0YwdlAxT2JkMi85ejFvcENIM2k4TE5nTG9PbkswMHhiWFBX?=
 =?utf-8?B?SHRIS08yeTdBcEVuT21naTBaRE9jeGxvMG5kOUZkL1dEajVqN3JZMkJ6aThE?=
 =?utf-8?B?VW9JMytPTXl4YUlKa2M1SmtrMlAxWm8zZmpTemVrcmxVWHlqQ3RYSXc4cVhx?=
 =?utf-8?B?bWhqRmVmZXBtb1hud3IzOGkxR0R5dDRYVmtQN28zSmpwRHk1WlNic3VLUVR5?=
 =?utf-8?B?a2xNRFJkcXVnT3BjalVRblZHRzkwSnNXY3pHTmFkU014U0dmckFkNm50aTU4?=
 =?utf-8?B?bncybTBHY2J1WUMrZk5PU1dlNXZUOGtwNzJlbTlsY1NEY2R2d09Vd3g0Vnhu?=
 =?utf-8?B?d3pVZ2VUMUc4RkZSMFlDdCttelRFSzd0bWlMNUMxQ2ZLbng0TFRyb0hRWTFL?=
 =?utf-8?B?Y2F4VE5SQ1llZ1VhMkE5RzN3L01Ca1lUenRQSGw5UTFUVFJGa2dmeCs1UGVh?=
 =?utf-8?B?c2FmY0greVRWaW1KTzRQdUV3U25EWlVRVmRnYnhzNTlZSm5tZ1pDRGJVNCtI?=
 =?utf-8?B?ekVPY3Q5Z1Qzb2UzNFl1Um9SOFNKSkdVK3NqK3RiNk5PTXljdFFkRDNBVm5a?=
 =?utf-8?B?U2QzMFJzMjhBUVBDMGhVQWV4My8zYlNXNytYcGtuYnZ6UTJVWGZiemtXQU45?=
 =?utf-8?B?TU1tZGVJN20yUWNKYjI0VHl0WHd3YzU2d3FGa0VPUHhrU2FWU05NRlgybkFq?=
 =?utf-8?B?emVqV0Y2N1l1a01yZk5ENzdHUlhiRnRFQWx0WUV0SVhyejBac3pvUDJNbk1k?=
 =?utf-8?B?L1FuWS9LT08vOHIvUExzMFFJY0xuYVliVUNha016YTNDd0xxbjhrQnQzYnBu?=
 =?utf-8?Q?G9iKdU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGJVazBDMHRqUjVuSWNkRjI5SnR6dTlIMWtaMXpuTk1ndDNVa1p2NGFOUUhE?=
 =?utf-8?B?M1o4K0laZm9YYnNrMHNOK2pIL212aDdkeEFaUG5PbFhodU56R1BLd3JKN2Nm?=
 =?utf-8?B?cU5mZUcvdHRIaUxjZXphNVJzZmtRQjRyWGNVM0t6SStlaWV4YmFkbU55M2Ew?=
 =?utf-8?B?OGdBM0ZNdTdweDN6bi9QUDNtcDA4RXdIZVpkQWc1ZlZwSjFhYk9DS3VWMzVt?=
 =?utf-8?B?Q1lTaC9yd3FyZkNYZ0ltakczOTZBcXhoL3k0N1lnUUYreUdXNDQ2NWczanpH?=
 =?utf-8?B?TDRZa1BrYkpFQVc5V0dGS2czRnNieEdSVDhNYXNqdVFpTWg5ZFZUN3ZnUWZJ?=
 =?utf-8?B?YURiRk5NTTVmektBZ0hyRFJocXVkaHZPUWh2Y25nYUJNelQ1VWRqcTlVeHpP?=
 =?utf-8?B?cVo4cEx2VWZhL2FSM2hmMDAxQThWa0lXMmhWbjBLOFViRkNnZnNOU3U5SlRo?=
 =?utf-8?B?ZTJ2M3ZlWmc3WS9IcEg2L2pnSmY4bTNpdFhkS2g3RGdYQWVYLzJjeVE5M0VV?=
 =?utf-8?B?L2RFdC9MM0xoWlg1cGFhRDl1UGIvSlFZNHZrSnRGd0l1WXU4MlpFdm92RE4y?=
 =?utf-8?B?Rm5MWVdRb2IrcHVLalV2Y3F0VVBiSDlRS2dhZytXWjJMMVpnNUhlRXN3Mkl6?=
 =?utf-8?B?OEJaREF6Z0syYjBta2o5ZUYwSXhsZnlEMWVQMkpMamN4RlpZUnpyN2NrbCs4?=
 =?utf-8?B?YmlRZHUydjFyTXhzd0p2ZWZUMXVuK25hbkhCaU9YY2Q5STBEVWI0d2pRWFRT?=
 =?utf-8?B?TnNaUU1iaTc0Wkg2emp1WThNWE10WmRlRldpMUswNjRyR3kvSENpdW9VQ1VH?=
 =?utf-8?B?dFNqbWhLYWhKRk9kcGRGcnZBZ3RyUHVUL3lPK2J1VjZSSVRMaFRzaDlkN1hP?=
 =?utf-8?B?L0gyMmJaV0o3eVNWQzhVc25oYXNMd1QrRFZ3dGVhNnQrUnJrWjQ5YWtVMFJk?=
 =?utf-8?B?UkUzdGRiKy9wSExuUk5JWTEweWtzYS9Ga0daY3FOZW12ZCtDdnVRMzFraEE4?=
 =?utf-8?B?Z09JMDJrZlhKR1U0Z1A1NkJLR0sxb1hyR1VETUNDd3NweVpJVE16ZjByckZj?=
 =?utf-8?B?RW91VmFwQkdYNDNuWS9QVm1aR1hqNVBOelZ3QkNTMTV0MTh2bzJEaER1THRm?=
 =?utf-8?B?ckwxK3YvZExBVmxVNFBGRHNyaTVuTGtYZmI0TXBmcXJhOVhKMmoxWkRMSHZR?=
 =?utf-8?B?TUFkZ3BpYXlPWWtEbmJEMEQxdVNWK0FSTjUxZnE4R0RieUcxOVBHbXhML2k1?=
 =?utf-8?B?VFcxYml1L3p6WExVRTV6bVQyQWNQdml6VUpUcTR2Sys5eS9TWlQ4Yi9vT0U2?=
 =?utf-8?B?TVhUU2NrUko4eExlUmhyck5tQ2VwQm13N2RIeldwQ0tKMFFLdnk3OUc3QmlR?=
 =?utf-8?B?SVIrS0huSlNGT2Q1REp1SDVkZkt2Sm0vOVhGckZsd3YzSWhSS256SnYrT0xB?=
 =?utf-8?B?Y1dUaGVoOU9OQWhJd0ZLdlQyK2dnbDNIU0NvWkVyZXJNUldmNXJmaEtlUEUv?=
 =?utf-8?B?VXZiZW1pbm5CTllQVUdKMHI3ZWZTT0tOMFN5dmw4RXhIalVIWEV5L3hNejFV?=
 =?utf-8?B?QnM4cjhsYllSVHd4MWNLdi9aUEtWUWd6b2JUK215UHQ1VzFUMUw5VDMzVUdr?=
 =?utf-8?B?elRYcFVMeGh1dWU4cGpETWZlVTBDendXTWtrbjFIbGhWRjIvTHpzcERrUEFp?=
 =?utf-8?B?QXJpbXRyRDdhUWtCa2NkbHU1NTNsMGJiQVR3V2l2OTc3SkJ5RFZpSTVnSXRi?=
 =?utf-8?B?K0d4V0Y4OUo0NmVTZFI5dE9xS1NFL3Nsd3l5TUJNWGMyTlpheHRmU3doektu?=
 =?utf-8?B?eFY4bkRVWU9NaWFqTnA1SkdPY2FoMkFzRlFGbHZjRXpwNHY0eHhYY2Q1NFhE?=
 =?utf-8?B?RUJIRm5vY0VTMFF5UFMzVUhvNThieDY3NGFxOVNFaEpxZXVvZHM3bTAxTDBI?=
 =?utf-8?B?NXJISzNLTWpyL3hjWWFqNVZmVG13RDZXSXcvdDZPeVd3V3ZOd2ZJK21BWisz?=
 =?utf-8?B?SzJWczdiSmpSVlhaUlFhUFJQU1BlY2ZFeTdsU200VnhOVEVHZERKVWV4clly?=
 =?utf-8?B?THljM2ZBek1lZ0wrUGUyNHlrSUlDenNnUzhmbG14RG5xWThaemxScDhwTWV5?=
 =?utf-8?B?VjdEdThCeDVOeWdIVXhTeVBhL25aMWdyYXFDM1hZTE9oQVMzZGVPOVVsZG9K?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da39c336-a617-4326-ee9b-08de330b4e8c
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:01:18.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixDO3IOjg6T3CUBL/Jl6f8ITH+qKGNcT2yRqOqjCD+Kczw/TSesZiRpstUgSpSwAJi5BXuYrZn+udxfMV21D/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7024

The AD9211 is a 10-bit monolithic sampling analog-to-digital
converter optimized for high performance, low power, and ease
of use. The product operates at up to a 300 MSPS conversion
rate and is optimized for outstanding dynamic performance
in wideband carrier and broadband systems.

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
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc405e25f312197df4b2131871b4bc..b2a9ddf06c0d207e82361e2de322e74f85e4c504 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/units.h>
 
 
 #include <linux/iio/backend.h>
@@ -81,6 +82,14 @@
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
@@ -234,6 +243,17 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
@@ -297,6 +317,10 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 	},								\
 }
 
+static const struct iio_chan_spec ad9211_channels[] = {
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 10, 's'),
+};
+
 static const struct iio_chan_spec ad9434_channels[] = {
 	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
 };
@@ -369,6 +393,23 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
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
@@ -1264,6 +1305,7 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9211", .data = &ad9211_chip_tbl, },
 	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
 	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl, },
@@ -1275,6 +1317,7 @@ static const struct of_device_id ad9467_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
 static const struct spi_device_id ad9467_ids[] = {
+	{ "ad9211", (kernel_ulong_t)&ad9211_chip_tbl },
 	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
 	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
 	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl },

-- 
2.47.3


