Return-Path: <linux-iio+bounces-12145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DDB9C43BE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB8A1F22587
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA781B86D5;
	Mon, 11 Nov 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WG1QeB+U"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9871A76B7;
	Mon, 11 Nov 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346372; cv=fail; b=aHPjuIR4876ak8Dwmd/8xxDoxqNArHmQFYhF3KQpP7shs1iVZMeef/dHmjr1TviUUsEKhBNe7v4dU3pN/y4Ds+XvsBC6qEMk8YbrLKMObTh/Trpeo1fuh8UghxkBuQYjM7X3LunoJrC6l3lnFoxKZ56tyFLfOXgZg7SkG1tAgeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346372; c=relaxed/simple;
	bh=pHdcouA8YK+jThZXHKLq4J7wOSdvJ4TG+3dUQln/lGc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rv66S4+L4HEzHJKhPG31LUC9Zo/KhnusUndCfU8ny3sByn0qkLL4ITadfaJeyRTMnSa/swlHO0dwsOSNUFses1fSnh7Mhz/UR115fyyGQIewXsxO34GMSBaUjwJRtFaX0bMHw0Nbux5PAt+IQBsRsIxv8CsxRc0U1wd7yI2aLRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WG1QeB+U; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojY1LZkljoTykY4b21t90ct9xOcNjNzR3YW2mk+4yA8ux5yuIYng86zBKzW1r3W/qOa4ew+WDkm4XGZg966UykJ+HGErucWBYDXBawXxENo9j31XOUOAZWmK7AVJm0eoxi13x5ZblsUbV1gSmGDlEtrt4usQ2t3xxrvetWtB9O7HAHFU2lyD25ajoVGbaQBefwSF1F9uC/mX71ywEUEsQk7SOh8rhNXjkG+CxcUBsgEr6yCw4FYmVYt1GZ52TmNndJ349r8tGUP4DLmpFV1rqchLYvDAl98ZHiwhfS2mWLX7qgzmuimGadR5fRJFCXCxJQ8YPm8HXHKSCjLyZ+gk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTxUcGEWHvp7e9+sBMtLPKUzbzbsN2et/K/W1RTGWtc=;
 b=FRzHwrhOWSc2MvV3vUxPH1kckMeEbfAhxJ2EJmOva0+BMwecne3f1NbhdXuNhzeRImZ2Y9okq2/s4c7AlLns646Q+mjzhFCsH+1Ocm+C+zR0EdHPJHxNPuytue5IynMjtMRjLE/CVPxjUcZ1cM2O1GROoEjF5z+kF6eTLBkE79af8511JUlHtMeS7nhhx7ZGYekaeJTVBgTeVl2ga1rqK69VFiHtvXcfQtnDOUTo7L1EQz8GTsaNOc42SynI1CwlIa7KTpGWE92XvImF89zMq8pBQOF0u7jFoY6qNxj04PVe1KdECtfW2vApHKblfy4M5gGuI5WnZvpmXp+ixmx0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTxUcGEWHvp7e9+sBMtLPKUzbzbsN2et/K/W1RTGWtc=;
 b=WG1QeB+UEg1XlxaaWCI/xbQUYlqfUu9NEqg6dfgaziunwdxENhmFGIykLvusZ5wSrbUF8FiuEQEEZc9NGMo9wXc5/DerhX7k2YHaxpKZm160LXVpuSQAZryOULUazSokqaFl2Wqzx7aXykzFN1zO5KMYHL1oXaDyx1SQC02Ng6A0rRGOiO+UKTLPXVenbJqx+ApmzDQeMwDWljdZMKBr8tF4G78Iqhbb8/POVYunI7uuLZTcpyp8Q5X4NPr2Qjde1800W7OIk0XT0lWcB7sLibiopoEg3ctvCZ3E9wwjxqXEe4/IcYcF7ZueYP9/yzSZVFd0u4+5M+57pM/RWty0CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10086.eurprd04.prod.outlook.com (2603:10a6:102:40d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:32:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:32:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 11 Nov 2024 12:32:00 -0500
Subject: [PATCH v3 3/5] hwmon: tmp108: Add helper function
 tmp108_common_probe() to prepare I3C support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-p3t1085-v3-3-bff511550aad@nxp.com>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
In-Reply-To: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731346348; l=2743;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pHdcouA8YK+jThZXHKLq4J7wOSdvJ4TG+3dUQln/lGc=;
 b=bfBhmVCVa2weYkbM23SlmsWKV8wviDQ58GykbkhfkF7BK5o7FeV+W+zLf+XAnAn/1MZhpsDse
 3vfSaAEoqS4CudrQBUDTRBAM3YOa8RNH9NNssuY+9Pj5fHRVmW36XY9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10086:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa1bc41-9873-4ece-36b7-08dd0276dba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnBHbC9BdXBjSVcvUWYzRU9kYjBlSzVFMTE4U09acHJ2d1lwbXNicnkzWWNW?=
 =?utf-8?B?QVdrdGluR3ZGcU9Hd0lqTER4UzZ4Mi9LbHFTL25yMG1wd0Z3VzE3OVgvdVRQ?=
 =?utf-8?B?R3FTbnd4VnRRb01la291ZXZrQ3BFZmhHNGk1QXl4WG9qWllSNVMvRmZFZGJi?=
 =?utf-8?B?VEtMMzFRWXdaRERVS2haRHhKTEdUTmJSNE5HZ2tEQUdFeDk2NmROMWsrS0FJ?=
 =?utf-8?B?MFpSLytoZWNSWkIrY2pyVUMwU1hGOTdPVHk3dkE5OUhUdHN1WmtueUZkNXZs?=
 =?utf-8?B?bTkxUzRQMlNVZFcwVDNrbDMxUUtVcmRQTnhoYWpPNzhZZ3dtcjBVdXdaUEN6?=
 =?utf-8?B?RTFsRXNscE9mc09WY1RYT1BoNkV2ZFRNVDcvRVNPSnhzWElNL0NYdTlXazZN?=
 =?utf-8?B?MU44QjUvUFE3cGd0OE9CdHJyTnZoaHhkZVRnb21HNGpBTklKV09HZFRoZWhT?=
 =?utf-8?B?ZDFQOVN3a1Vza3JoSm96VmgwVENIb0VTZlI1MS91NEhVMFZjQjhtRHZRZHZC?=
 =?utf-8?B?REpraForZnVaMTZXcnRYSGluRVp3YkQvaFBCTnNTK3JGNHd5YVd1ckNBaDhO?=
 =?utf-8?B?UTlaMk1FSTZkMlhOd0lFbUNhWEFxbS9xL0JVY2hVVU4rell0L0FPRWhyUGtr?=
 =?utf-8?B?Ky9Zd0l6dW9IZ2FNd0prWDFtUGxYb3B1aTdaL3ZLNnFBVm9Od3dTMEdSUFlI?=
 =?utf-8?B?TGN2NW5xeXVncGlmdCtzRXdMTExPMzFkUHJMaWhBTFdLQnBLSGxlN3hQVjVv?=
 =?utf-8?B?WmltSnZqc2NycW5Yc3FRRHBWdnlCNURUT3ppTE1GVXdMZEM3Y3NhM0RjQXJa?=
 =?utf-8?B?UXB1OVRYRUMyMVYraXVKU3ZMUFR1WWZtTytJYnVMYU9GTjJQUVd1UGpSaG1n?=
 =?utf-8?B?MDR1UVJoZ1BPekdQR0czTU5SMVAxK20xL1RKSW5SNFRPc2JjNGJNaEFMTFRK?=
 =?utf-8?B?UXQ3VC9GUk56dERXOEc0aTBYWlRqcmNTRkU4WjFXMzVDWFVUaktXaVkvRWdM?=
 =?utf-8?B?d041NVVZb3RPMUx6YXpVQllpanZZKzgvYVRMWmVuYWhBVmRNVWxvZHArUUQz?=
 =?utf-8?B?NDRDN0lZaTJKb2p3d01tL2h0Ykp3RVlxRU9nQUx3VEJmN0h0YVBvcFF4STBa?=
 =?utf-8?B?L2Q3cm43ZzhaWjBmUm5xb3I4WUxabEdTZE5Tc080UGFNTWloMlZWaXBXb1p6?=
 =?utf-8?B?bkxJMXhkMkNyQnVweWR1VlU2ditkMUhjZGNWZHQvM2dXUWhjZHhjRDRUbW9p?=
 =?utf-8?B?ZDJCRWZJamRmWWtGbHBLTzJaZXdreVZkVUJEanhpUEcxd3JJaFdkV1VTVkNZ?=
 =?utf-8?B?MVZueEpSUXdualN1Q2JoL1ViR092SG56VnN2Yit3SFhkOWpxNjl4VER3dCts?=
 =?utf-8?B?UzNGMmlKZGJKdjlwTlYxS2ExU2luRlN0amZoS3FFOFVRc1JBd2lsYThCYTJ1?=
 =?utf-8?B?UmticXdJRjB1UkpoRzlOSnk4RkpGWHRhUlFrejhBWEVuSHQwcVUrMWhobTNu?=
 =?utf-8?B?eWNCTW9Hc2tOSk5hZE9YY3VlZnljbEdsLy8xYUpER1dzcmU0aXBwRGdVaExr?=
 =?utf-8?B?bWxFM2FlaVNYZEJ4bWNVNWlMRzBPTnVFYk1MaXJvK3h6d0lzd3htNDVYeHEv?=
 =?utf-8?B?VU9FWE85bWx0VllGS3NGU0lObjVHT2IwNitucXZ5aTlmL0Rkb3VRLytPWGNa?=
 =?utf-8?B?SmcrdFRJak13MVRIcFJDQmRGOGhEbTRva1laNUZIWm5UeGdXcG1NMkxwMXBn?=
 =?utf-8?B?Qld5SDJ3eWM4cFJmZ3VmSjhoZFVmS2hDQ0c5VXozaGZzV3V1T1NpL3NWbGtL?=
 =?utf-8?B?M01nemttc3VDSmlIMzdyUWlFemNoWlRjLzU1TGF0dlJyMFFrbHZxNUZrc1FN?=
 =?utf-8?Q?4ZqE4wPe0MKMP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjh3MG9qUkdIb1JvenZWZDNZQUxJeGhhWHVLTCtlLzJCM01Nc1U5MTc3NTlP?=
 =?utf-8?B?RnoxV0h0L3BMRUE0eU51WkF4dldDSjJ4SXpPd3pNd2NDaTBqaGZaSkRXT3Aw?=
 =?utf-8?B?SUVyNkFBdms3VHVza0JZQVQwVnVYTHEyVGh3ZGZNcWFLU2lxcXVuYi9iZUlV?=
 =?utf-8?B?QThKM3JJTmRxTUgxYUF4UHA5MDNMdkM3d3R0OFB3Qll2dG1xbFZWR2RhL0hx?=
 =?utf-8?B?OHFyVEQ5Ym9Gdy9ucmRBaHZqbjYxN0NrT0thWWNyWU9nQzJObng5eGFGWFMx?=
 =?utf-8?B?OHJZMGY5d2hYQlI5amR4dWN6ZHBGcnRodyt4MFQ4QlcrTkNSRzlDaEE0UnEv?=
 =?utf-8?B?anVZYjVpS2lQQ2F0QUJCWFVUeitiNTJBSWZsYjFVMDBFVFpWWi9ZRUxuUDRO?=
 =?utf-8?B?SFo4djZkcFJCcXBjakhkVFJBblU1TllXa09QNUZ5OUpZOURsblV3QUhETUhv?=
 =?utf-8?B?ZjAyL1lMRnVpU0J6R1hKWTJyckZrNlhBRjh3RGFYd3d1dVYxWkN6UURxU3dF?=
 =?utf-8?B?amdKUldQei94TXpMRk44NElMR1p6cERIZlRuN0Y2VVJJTENHYXlqeDJ5UmVk?=
 =?utf-8?B?VEtqRTdKb0xVdCt4TmJPVFA3WDJqSmFuRjYzU3l1elZhYzN4UkkxQm9NcFo5?=
 =?utf-8?B?d3dmTUZmVXZKUzZlR1ZENW9SWVRYa1NqS0dVRjExYkRObVV4MTNPam1TWWp4?=
 =?utf-8?B?MEo1Y3hWdmlSRldLOXJ2Y3BPVy9wdTVna2RUNjhlRVUra1p1K3BrMk9pcjNH?=
 =?utf-8?B?QjgvY044WDRoQkh0dWhGYXA4VHp5Y2dxZHZRQmxta0lnTncxd25sdVVSNGcw?=
 =?utf-8?B?ZWZPdHY3VnVJNjRjS0pjcmt6ZmR5VE5pck43azNvZVZybndDcllNR1lCNlpm?=
 =?utf-8?B?eHdvWk5seDl3UUF0N2VtNTUrc3lQQkhiRk1uWFhCMFg5SStkb3lKUHYxVXdh?=
 =?utf-8?B?Q3ZBRWJWUk9ZWitYR3hNSUpsY2JqdFMzUldrb0xLTkJHSElkMEI2K0dZakNW?=
 =?utf-8?B?WjBob0xXdC9QSGN6bWlmR29Td0ZyUFF4bHJvSjNSQ1Z2STl5QkkzVjJtbUth?=
 =?utf-8?B?UkVEL2xxbEY0eG5COTNGU2duRjR3dzZqRm9rVmo1Q2Zmak0xYzhYRy9ITE5Z?=
 =?utf-8?B?VFYwOGcxejdZS09WdzdNUkNILy8rUW5pckwvVkZkWEcxSk5vRmk4dnNjMmRz?=
 =?utf-8?B?WXpvZmtUa3AvOHVIQndQMTJTVG9RK05pQnkrYnZNNHNWMWxwb0c2SWtndXVa?=
 =?utf-8?B?N2N0NUFmajc2Y3FNeUhUNUFRR1c5UnR6aTBKSnJ2Qm8zMkJGVTBXaTFtNDl1?=
 =?utf-8?B?VzZNYTZQaER1VHdIREdCN3AvL0ROQUZna3JDYjVpU0FQVVVPWHJ2cDhKNWZu?=
 =?utf-8?B?OXpMN29mRDM5bmtHeGk0YS9GdjRtcW1GV3Fhdm5EaWFGUGJnMWZpUFRJSUc5?=
 =?utf-8?B?RkpmaDZrTFZsOWI0Z290Ymg1eVJ1YmhKZXlKVzJWN3Bhc1JWcDBhMkJFS0xI?=
 =?utf-8?B?dnk5UGI2U253Nzl6MkVjbUdrWncvZ2pOdzNPc0M4c0VTckdvY29GcUpnRHMw?=
 =?utf-8?B?SUJyclFjMkxNcnNIaVpRYThSQ3pLelN3bTBjQVdQL04zL2wzS3UxalZISmt3?=
 =?utf-8?B?bkJHVU5aYTlNVnBLMFJ2ajl0Qzl5UklmZlprbjcyMXR3eFUyOFNzR1B3ek9J?=
 =?utf-8?B?K1VkaVNrY1YxTUIvR1lNZytSZS9maHF5MkR4cE44RlFJaVl2Nnl1T1QxNStF?=
 =?utf-8?B?VzRNVUJaMFNXWGxRaUlPbzdscWhyRUhqVmNva25wWlBVNmZmUU1WRUdnY2pT?=
 =?utf-8?B?di81MEV2TFFhLzNVMUpMc3BIc3ZuY1kxODlvVTZzditubjdiOE4ycmlXelZJ?=
 =?utf-8?B?SytVQjVlejVjZkpXT01PdzZ2cnBpSUYyVjV6akJQYnYyeHNsME0rbk5wTmp3?=
 =?utf-8?B?VmlKSFZhU1V5WUM2YWtxU2tJWlFvb1JaWTh3V0FTQWNYbFVZOVp3eXUyc1Fz?=
 =?utf-8?B?U2NhU1QzOFlpNFhNMjBYaUxPMTdyUEVXelVRcUJ2L0FFRkVrWEUwWmJoUUll?=
 =?utf-8?B?UEl6V05qRVYvWGhDMXg5MUZDaDBXcUpZUjArK0luVEUxUXhMcEtxOFR4S3F2?=
 =?utf-8?Q?rIztA9MQIaz0G+zy3VZxomTO3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa1bc41-9873-4ece-36b7-08dd0276dba7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:32:47.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKyzUccjz1Tx9AqMIz2hU6EBeSdfGorlqxUv1MuzgznrGOdmAP+0GAHoDZ5cC1loUJinnBpecQpVknmdx9+fJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10086

Add help function tmp108_common_probe() to pave road to support i3c for
P3T1085(NXP) chip.

Use dev_err_probe() to simple code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
dev_err_probe() have not involve addition diff change. The difference
always list these code block change regardless use dev_err_probe().
---
change from v2 to v3
- update subject by add  prepare I3C support"
---
 drivers/hwmon/tmp108.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index b561b452d8d39..bfbea6349a95f 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -323,33 +323,19 @@ static const struct regmap_config tmp108_regmap_config = {
 	.use_single_write = true,
 };
 
-static int tmp108_probe(struct i2c_client *client)
+static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *name)
 {
-	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct tmp108 *tmp108;
-	int err;
 	u32 config;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(dev,
-			"adapter doesn't support SMBus word transactions\n");
-		return -ENODEV;
-	}
+	int err;
 
 	tmp108 = devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, tmp108);
-
-	tmp108->regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
-	if (IS_ERR(tmp108->regmap)) {
-		err = PTR_ERR(tmp108->regmap);
-		dev_err(dev, "regmap init failed: %d", err);
-		return err;
-	}
+	tmp108->regmap = regmap;
 
 	err = regmap_read(tmp108->regmap, TMP108_REG_CONF, &config);
 	if (err < 0) {
@@ -383,13 +369,30 @@ static int tmp108_probe(struct i2c_client *client)
 		return err;
 	}
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, name,
 							 tmp108,
 							 &tmp108_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+static int tmp108_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -ENODEV,
+				     "adapter doesn't support SMBus word transactions\n");
+
+	regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return tmp108_common_probe(dev, regmap, client->name);
+}
+
 static int tmp108_suspend(struct device *dev)
 {
 	struct tmp108 *tmp108 = dev_get_drvdata(dev);

-- 
2.34.1


