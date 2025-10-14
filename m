Return-Path: <linux-iio+bounces-25050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9611BDAA75
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 847FA4E9BCD
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB1D302CC2;
	Tue, 14 Oct 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GNo8JYb5"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB030274D;
	Tue, 14 Oct 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460027; cv=fail; b=l4YzmcODeE1jkKxgrx+bMm+aQYRVVkVoy918Eh0oX6gruaYCwU+FY49HPZzcmXhGce3YFa/f2s9pq7aY2rnH6rEBnKi1S8J2nfELUyNJVDdfgJI3U57eflK+LVqgSm4pKT+0TzNLrE2cbD4wU4r7grV4NDZzx3h1seVt8qc6ijA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460027; c=relaxed/simple;
	bh=t/ks1HyTkSKTnoBW7DNJFT84uI4whbnkk/phIzBB83E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SZPYnt75GByd/q1cNsJQfdcm94kWog1jmQ3YmTLKtLG0ggGs+Zq9MeI9ZyAVjtHh5UZ4Ua1UdUS5lDjpEbEOLjOovA7j6tNKyyxj5Add1v9Zh16yB9a5KcWFekO3ML1ByAqxOP3OThUqKKK93/EP3Wt7CZF2SB6Wp4bwM72pD1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GNo8JYb5; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFyOjd4G8cvFbnrH61NyWBlfKi8NDoOTQ/OzFwhBwC1Nm0igk/LWjsXtgP+vQUXqQHlt+1Ta6+v9YYBn4z+lInsTFWfAS9X1cx/8fnMdOmWhPqzQSVrm495tTf2zNzTrVHVjjhY/Z9IbwHzhf7xWPDoFT7s8ATWRXA2w0Mq7lZip9kV94P8gQ4NCS9zBoMWHN4UKv/ty5SG0mW0UJcrOv+ueGJILkXMlherIqLjvihQoULEZ6cy/v8jcQGalj1lJXwc4viDZjpOBiK9Jj8hPJymJHbAYouxQtQNA3BRRChXFLw3fMJEPO/laS5P/SMZGit0CQATf1JddKT3ao02jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn1xb0X0zJtTo8fc7ampgSiav1gL2yhxNfPULx9M88Y=;
 b=epsQx3j8eMM/1ojQeaAOd5mnWhk3Y0nDO7QHiXPq5kH4aNiv/eF4ikswnf/wN0sTdsACDh9UWaSOXB9778K4bfb+WnsqOL3DMY+tdeNEKr2igIp2es9DtBD5wc2GmRtGknoDER2Hq+FYd+kK5ZYe31t0EdFkvR0GL6c69yNej+2zkjBInJrhUSB4giryP1lywYIJnR5jKMXewA4pvb8QK318Oaha5FNDr320AFYWzYg87aDPHafgyRI5guLGnHuuHQfFywLdC4VVzRTVsyMl9hbFh+I8ddqt/VO3iSA0lW2bjOMn0o/p3OJ6nShmN9KMBlikfLVQhwGpAHiILpZ0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn1xb0X0zJtTo8fc7ampgSiav1gL2yhxNfPULx9M88Y=;
 b=GNo8JYb5XB6+kywjr0/ffEsDHhDs6Ti6+WTgcgbrj/kAbarSHb2Zjuw1ZiIlibaldIe4+rkYmFSx1B2Oy/Qae3d3u2E8XPdmxnnGV0oUh8bo5DjFaGBPEnnEvus3G4tAx+VYiUlq4LLTWsZQnF8ri/eer53aQevXHmdskH0JAHgZ3Ps4mRx9MBo+2Hajx29lSXAOOFnhtYPAnxZuHADUpwExW46lTuE+resWRt7EaTP4vTV4xSrnyudsSymoUiVKb/FrIg5arJ+H8Fu2DTEXFPN1U6ksxBOYr5IwdXUt4fwz21drvSJmFgRvFPc2z2GCA0S6Hoo9z3m/KB5rQXUPAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10946.eurprd04.prod.outlook.com (2603:10a6:150:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 16:40:22 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:40:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 12:40:00 -0400
Subject: [PATCH v6 1/5] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
In-Reply-To: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760460014; l=10203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=t/ks1HyTkSKTnoBW7DNJFT84uI4whbnkk/phIzBB83E=;
 b=xfgxaeHNKfwmiq3D6k5aOq8KRjJcxJbdUKJ5LmHoWkR18unJbuWaEvSXcnixe28IVunEpm6kS
 4v9buh9hdjABdBPHOGTCD1TojIyrahQusVPX4QDrtCoXmECLnvJYaCi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fa5f5a-8cdf-42d8-00dc-08de0b405e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVJVR3kzalFXbGJQR3RPbTJDUFcrM3RyRW0vbThOVGtPOGx3QVRNMmZUUXIr?=
 =?utf-8?B?bC80VFFRTVRhY3lEVHVndUhlZ0JqcFhZcGdGN2MwQ0taaFM3Ry82NlNQckpD?=
 =?utf-8?B?UDdVc2txZkk4U2twTXJwT2xaM2l5SzFWd21XeCtTL3BjUmdMQldQZ2h5emkx?=
 =?utf-8?B?V0hhNEVOQk50d0ZCbHpvVFpvNFFLRDNhcGFjNVFSNGpDVHF3NlJKNmNMQk9l?=
 =?utf-8?B?L0lQWVVMNXdTOWRrcTlSc29IOGloNEw4amNqTG5qUXZVaTVsZzI0UDY0QWtO?=
 =?utf-8?B?azQ0NXAxVlBUNXBYSjhFVWFxRzdnMW9mc2t3aitXZTUxOUZCUzd0UjJwNldr?=
 =?utf-8?B?SFFYd2RlSU1KWm5aemlzd2pCSW9wU3U3MVFvWUJFeVhtTWNnWUlsNmJuMnpX?=
 =?utf-8?B?NTRYQjVZYTE5SEVKYlZVV0N0Q3dablNqSW5pTDBFRjlEc0w4WTdQeE5TdkI3?=
 =?utf-8?B?aFF2TGl2RmhVbGtHdjJsNWhFNVJNY1A0cENBUWc3TExhUCtkZXY0cTd4SXc3?=
 =?utf-8?B?RmRwRENhUlh2RGlwMnlZU2c2Ulc2VzNYdTVKMFRaWGErOFk5QkwwQVdabXhZ?=
 =?utf-8?B?WWwvaEdFNGxhbVRHaFBtMCtrMWhUNG9wYVg3Wk1hRVpzUmNoRWZsUzR3ZnRQ?=
 =?utf-8?B?Q0JXL3lobHAreVRZOFFUMmRjYmF0aU82em1kbzA4cHF5RWNqTU5jSmJGWE9N?=
 =?utf-8?B?YWJaczhNRHVsTE93VDBNSGV4Lzdta2xHb3FNMWtUY1U1VS9rM2VWQlZETS9j?=
 =?utf-8?B?ZG1obGRBWXJGam1LZTJmdG9HYjZ0UDZ6MDh5cUlpa0x2Y1pIRm1kNlRKMCt2?=
 =?utf-8?B?amdtNWdaSDlVYkpIT1p3aGNKV1NFRm9vVzBpc2ozWHAyUStwdms2UFBMOG0w?=
 =?utf-8?B?Y3phN2svRGhXRnhqRnBHM0ZMb29STmdQNUdQV3U0ZHptOTl3WFBPOG8ycEcv?=
 =?utf-8?B?WlJMNllQcXpSZ3VQRm5DTE5zTnRnNHpJT21ISTNpWjRIbWpqTm15WUp3azEx?=
 =?utf-8?B?QlJ4UGhpcmszVHkwSDBEc21FcEpaVm1oYTB1NjZBSkx4MGh2RFBobURsc1Yw?=
 =?utf-8?B?VnpyNlVtWXk2aVNqbW95SlZ0c2pmd29jZjNuUE1BaTExRll2NlpxbTJNSEZk?=
 =?utf-8?B?WmhBK09tRnhOeGVIMkdPa0c4WGhlVk9QNjczUVl3dFpFU1lmN0ZxYlBqK29J?=
 =?utf-8?B?RHhFZkhWeERuVXV5NHBKVktFUTh3UWtUOWZtaW9Ic3ZQWW1sUHVtMWUxU1BV?=
 =?utf-8?B?RExkS1F1K2VyVTFVYWMxcDBCWkxkaE56czkzcGxNelN4WnVneE91cVFJcCtp?=
 =?utf-8?B?NVhkRlVSUDN6MERwMWdZN040TW9SMzVuUGQyMW43cnh0UFA2bUs1TStjOUEw?=
 =?utf-8?B?WUV4NzZlcnYrVHIyRkZJK1JNNFBDekRFbTh6c1NKYWlMQk5SWDFaSHByZWor?=
 =?utf-8?B?bW84Sjl3MTRCaE1RcFNmQjJlYkdLQjdrTHFSbVBOdmJzNDhINWpoamNHS0ls?=
 =?utf-8?B?ekxvR1ZSZVh6bEVkVGgrd1RCY1Azbnk3cEhlV2tqRzNyUENxMmszcWZwYlBD?=
 =?utf-8?B?a0hic0wvRlAyeE96aU4rYmxJa1drTE1BTFNKOGRGQTl2OVdvNnlVRjNETFd5?=
 =?utf-8?B?V0d5cWR2VjBVVzlrV3J5SDI5NW5SZFlDeG5Da0dZc3BDTU5MMUNHUDlsRlhy?=
 =?utf-8?B?MmlwbWNtNlY3UmtORDdSYnZ4eHIvSGhyZDVsdUZKbSs3VURjVGxEaG9DQW1D?=
 =?utf-8?B?TktCT1FENmxWTGVBVXpZbUVqMGZvM0ZyM2w2UFBMTmNFWXRVT2JlMlJjaXRS?=
 =?utf-8?B?WW1PK1UxSVdMZWNGV2lLTjdFZzdXZ3B1cWRWY3ZkL2NCd014SDdXakxFZzZ1?=
 =?utf-8?B?U0VwZXA4VnJ0TU5JNEJQcWFVTk5Wa1NTN25YMXNNb284UFRWRzdQdG0vc0hu?=
 =?utf-8?B?MUloR1g5M2hoaUJPUXEyYUcrL0dheDJieE1VSUtGZTlqUFpZb09IV2I4eEV0?=
 =?utf-8?B?MkZyM0F5cHR5UEVnei9ES3N5dFRIWndjZTBHcmw2Y3BzbUsybVRTZGVWVW02?=
 =?utf-8?Q?dDMJAy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUt5RnlBR0JBSHY5Wko0eGtWdDlheEcxTUlmbU54cm11WGlnSDRZYmpUSzZ2?=
 =?utf-8?B?cTlLOCtpbnEvUUxSRjcrQzc4em1mTGpXQ09CbkQ0ek8rb3NFYzJ2Z2ZFdlNi?=
 =?utf-8?B?OUtvT2hnbkh4TnczOVVZaWFFcy9zUHFya2JpclltV2hsR1pnT3M3eFJjK3o0?=
 =?utf-8?B?K1Qwb0RBc3VTNEVYeUlIUWhZQ3ZPdzh5SmpwV010SHl6cUpFK0h5cXoxeFNG?=
 =?utf-8?B?RTJCaEVmNkFnSlkxczJ1dUExNjR4UzU2UEV3a2hOenAwUm1Sc2tEbUxPWlJQ?=
 =?utf-8?B?TzZhZ2ltWVlNVjloNGZ6bVQ3K2gwQkhpQ3pmZzBQenNuTFVTUmpBdTFBNnkx?=
 =?utf-8?B?aDc4aXM3NEozakFSNWQrKzI2WlhsQW12clJGbDFkZkM5MytlUDRzb0pocURw?=
 =?utf-8?B?VTA5dzZMYW9KckZQSndjVVhCMVkzNWd1cmlQbnVlV3VTYytxWDRFMHBVbjFX?=
 =?utf-8?B?TlozN0JsWXk4eEJPUmhVYWxJUUZsUGFWeTdMc0ljelJJclJ6SHNyWXZRQ2Vy?=
 =?utf-8?B?endsZ2pkVkxURERxRm4rOVA1TGdUWHlsTnBkN09qN1RqVnh1Tkt0K0tYemxY?=
 =?utf-8?B?cHdlalJxUWYxTGJGUzc0UXBzWW9NeEdwTmpIdkN3cTJqVWV4WFEzMGtOZUdJ?=
 =?utf-8?B?R0UweXdVWFgzemI3T0tveDUyY3N4QlFLUUlxTDI4Zk51RlJBMU5kS0Y1NGt0?=
 =?utf-8?B?YXJXNEh4OHVOYlE5OVUvbmVYMDBtcDlwQ3FBTWdtdFFQMXBOb1hpZ3lyeC9t?=
 =?utf-8?B?c1Q3WVFIU1ZvSWovRDMvVDljUXJTWG8raHZIWlM3dDdUenh1VnphU2hBZHIr?=
 =?utf-8?B?RWt0R2tFM2RQbG5tQTA0MHdtNk5iTUpWeWcxd0dBOGMzckRHRWNGMzZsNURM?=
 =?utf-8?B?c0RxUERIOFVUU1ZhMzVXYWtNRHNmL1M4ZWxTRm16ZjFtWXNkS3U4aXBGNEsw?=
 =?utf-8?B?ajAvZ2laTENoUm9QNmMyT3ZucjZpMWRoWHlXTHpPQlFPY1UweURsaXc0YW1i?=
 =?utf-8?B?ZnVocGZmZWdPWk80U0R3YklXY21qMXRGeG5yU0lpSFBEWGluKzQwclFnVDk5?=
 =?utf-8?B?aUQ1SWRneHd0SEd6OHRXNmREMGpVaGlaK2FnWFNmNGlReTlBckdNQ1FucnpF?=
 =?utf-8?B?d0xKdnhhWmI0TjA2MXVDYmNpOE9xLys5LzFhN2ZLRHhIVDRQZHc1UmpGQzNw?=
 =?utf-8?B?NFJlVjM5U2ZtMGJFOXhYWkNPQVlMdE5KMXpRSG1NTGlCRThDbHZWWFdidklv?=
 =?utf-8?B?UFVWMzVMRnVTK3FWelhvQ3RGeHpiWnNqSnk0M3kwMTVELzEwc002bWJvMytU?=
 =?utf-8?B?R3Z2Zjg5SGp5N0ZZYkYrTFlWZklWakx5RVdtdmczUVlNTVYreGlLZ1ZaSDhC?=
 =?utf-8?B?SU44Vjl4R2NhakcyaHlXUlpnUTYxUGRwOUxsK0x0NVE2V1l0TURQQ2YvMkRH?=
 =?utf-8?B?aEZlZURoNG9memwrdlJjTnpYTGQwRWMraVRxUXB2SWh3VWVHU0JDRVZKZGg4?=
 =?utf-8?B?TjYvYThzQUxGcmZoN1locW1jUjVXeHlRWk1SajJFUmJxU0VEaXlCVDFqTWJT?=
 =?utf-8?B?WGJRNWRaZlIrWnE5ZGdFZXQwVmFQcVhPVmc1dStBTUlLMVlkS0FMSWdERmt2?=
 =?utf-8?B?Q285QUJreTEwVWgvcUNkUmNlRldHU0dQbTMzRUpaMTBPdUZlRWpwMWlxNDhM?=
 =?utf-8?B?WDRaamhRMmFkdWNSQU1XRHl5ck1ic2FBRTlJUzFmNncxV2JrTDlQcWlPK0Vz?=
 =?utf-8?B?V25BekVpQzVHN1JHMDBnWmRGS2xnR3FjUmU4WG9Qbm1nckt6YVdKL2NLcEEv?=
 =?utf-8?B?aFBSWENvRHg4ajVFVE5UOXNUak9Lb3B5Qjk4M2Fab3lpUlBGcS81cHlCMzJE?=
 =?utf-8?B?UUlFNFJ4MjRKUzZNWmgyWGFTNmEvZmxmMEw0VEtqRUtEUWpYKzRTblFRUWM0?=
 =?utf-8?B?MkpaNXFnNE9KU1hNeExrM01QVVJ4QnVqT0g2c25Dd0F0MEJ1MnJEVFU2VWR2?=
 =?utf-8?B?YzJlNG50LzFaaWNSM3hlR1lTK1l2SVA5aFFZOE5yWElhZlBPcXNERlp3dENj?=
 =?utf-8?B?U2wveDlrY1N6dGJ6Sk5xeWRZRkxrY3pZaVY1NUtDNW54MGVoWmVJTEVqL3li?=
 =?utf-8?Q?LS31eZH/Mjja0Iic/AGvJm+x0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fa5f5a-8cdf-42d8-00dc-08de0b405e99
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:40:22.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7ljW+016OozGb4+VeZ5o87TywFkvu7hK838i6L7cQh4lMek0byiuWB2ch91R/a2rLdYmk/bEa+f+7hMQTu+Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10946

Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
Technical Overview.

i3c_xfer will be used for both SDR and HDR.

Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.

Add i3c_device_do_xfers() with an xfer mode argument, while keeping
i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
with I3C_SDR for backward compatibility.

Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
'rnw', since HDR mode uses read/write commands instead of the SDR address
bit.

Add .i3c_xfers() callback for master controllers. If not implemented, fall
back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
all controllers switch to .i3c_xfers().

Add 'mode_mask' bitmask to advertise controller capability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed in
one i3c transfer. for example, can't send a HDR follow one SDR between
START and STOP.

i3c_priv_xfer should be treat as whole i3c transactions. If user want send
HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
instead put into a big i3c_priv_xfer[n].

change in v4
- Rename enum i3c_hdr_mode to i3c_xfer_mode.

change in v3
- Add Depreciated comment for priv_xfers.

change in v2
- don't use 'priv_' since it is refer to sdr mode transfer in spec.
- add 'mode_mask' indicate controller's capibility.
- add helper function to check master's supported transfer mode.
---
 drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
 drivers/i3c/internals.h    |  6 +++---
 drivers/i3c/master.c       | 19 +++++++++++++++----
 include/linux/i3c/device.h | 34 ++++++++++++++++++++++++++--------
 include/linux/i3c/master.h |  4 ++++
 5 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 2396545763ff853097d9f0173787e087f7a6e688..e6add862645196ad41d0c91d3d7103c877a1ef5a 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -15,12 +15,12 @@
 #include "internals.h"
 
 /**
- * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
- *				specific device
+ * i3c_device_do_xfers() - do I3C transfers directed to a specific device
  *
  * @dev: device with which the transfers should be done
  * @xfers: array of transfers
  * @nxfers: number of transfers
+ * @mode: transfer mode
  *
  * Initiate one or several private SDR transfers with @dev.
  *
@@ -33,9 +33,8 @@
  *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Section:
  *   5.1.2.2.3.
  */
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers)
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode)
 {
 	int ret, i;
 
@@ -48,12 +47,12 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 	}
 
 	i3c_bus_normaluse_lock(dev->bus);
-	ret = i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
+	ret = i3c_dev_do_xfers_locked(dev->desc, xfers, nxfers, mode);
 	i3c_bus_normaluse_unlock(dev->bus);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+EXPORT_SYMBOL_GPL(i3c_device_do_xfers);
 
 /**
  * i3c_device_do_setdasa() - do I3C dynamic address assignement with
@@ -260,6 +259,20 @@ i3c_device_match_id(struct i3c_device *i3cdev,
 }
 EXPORT_SYMBOL_GPL(i3c_device_match_id);
 
+/**
+ * i3c_device_get_supported_xfer_mode - Returns the supported transfer mode by
+ *					connected master controller.
+ * @dev: I3C device
+ *
+ * Return: a bit mask, which supported transfer mode, bit position is defined at
+ *	   enum i3c_hdr_mode
+ */
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
+{
+	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 0d857cc68cc5d473db733b12ffcec0c1c28d9def..f8d68b9d6474cbc56640a643db3c2c4cd95dd26b 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -15,9 +15,9 @@ void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
 int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev);
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers);
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev,
+			    struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode);
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 8efec085d396cf0c7dd9ee35b636eea9664c634f..b36d4ffadeff20641a1eeb84b702178f05eb891c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2749,10 +2749,13 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -2942,9 +2945,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -2955,9 +2957,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master || !xfers)
 		return -EINVAL;
 
+	if (mode != I3C_SDR && !(master->this->info.hdr_cap & BIT(mode)))
+		return -EOPNOTSUPP;
+
+	if (master->ops->i3c_xfers)
+		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
+
 	if (!master->ops->priv_xfers)
 		return -EOPNOTSUPP;
 
+	if (mode != I3C_SDR)
+		return -EINVAL;
+
 	return master->ops->priv_xfers(dev, xfers, nxfers);
 }
 
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..563e63f6dd99a95d66bd80aff0b760c231b487a9 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -39,20 +39,25 @@ enum i3c_error_code {
 };
 
 /**
- * enum i3c_hdr_mode - HDR mode ids
+ * enum i3c_xfer_mode - I3C xfer mode ids
  * @I3C_HDR_DDR: DDR mode
  * @I3C_HDR_TSP: TSP mode
  * @I3C_HDR_TSL: TSL mode
+ * @I3C_SDR: SDR mode (NOT HDR mode)
  */
-enum i3c_hdr_mode {
+enum i3c_xfer_mode {
+	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
 	I3C_HDR_DDR,
 	I3C_HDR_TSP,
 	I3C_HDR_TSL,
+	/* Use for default SDR transfer mode */
+	I3C_SDR = 0x31,
 };
 
 /**
- * struct i3c_priv_xfer - I3C SDR private transfer
+ * struct i3c_xfer - I3C data transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
  * @len: transfer length in bytes of the transfer
  * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
@@ -60,8 +65,11 @@ enum i3c_hdr_mode {
  * @data.out: output buffer. Must point to a DMA-able buffer
  * @err: I3C error code
  */
-struct i3c_priv_xfer {
-	u8 rnw;
+struct i3c_xfer {
+	union {
+		u8 rnw;
+		u8 cmd;
+	};
 	u16 len;
 	u16 actual_len;
 	union {
@@ -71,6 +79,9 @@ struct i3c_priv_xfer {
 	enum i3c_error_code err;
 };
 
+/* keep back compatible */
+#define i3c_priv_xfer i3c_xfer
+
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
@@ -297,9 +308,15 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 		      i3c_i2c_driver_unregister,	\
 		      __i2cdrv)
 
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers);
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode);
+
+static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
+					   struct i3c_priv_xfer *xfers,
+					   int nxfers)
+{
+	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
+}
 
 int i3c_device_do_setdasa(struct i3c_device *dev);
 
@@ -341,5 +358,6 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
 
 #endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 043f5c7ff398ff631f1eea6acfc54a2e871016d8..ef1363122066215983d37c8e3ce062f3eefe48ae 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -474,9 +474,13 @@ struct i3c_master_controller_ops {
 				 const struct i3c_ccc_cmd *cmd);
 	int (*send_ccc_cmd)(struct i3c_master_controller *master,
 			    struct i3c_ccc_cmd *cmd);
+	/* Depreciated, please use i3c_xfers() */
 	int (*priv_xfers)(struct i3c_dev_desc *dev,
 			  struct i3c_priv_xfer *xfers,
 			  int nxfers);
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_priv_xfer *xfers,
+			 int nxfers, enum i3c_xfer_mode mode);
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,

-- 
2.34.1


