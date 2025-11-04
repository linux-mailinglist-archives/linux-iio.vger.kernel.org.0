Return-Path: <linux-iio+bounces-25886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE82C31EB1
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5180418C4C7E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A927FD56;
	Tue,  4 Nov 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITthcQjH"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9E278779;
	Tue,  4 Nov 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271254; cv=fail; b=sWqWea2eAbUfYs2GkiCxI9mYg0zxmBIAekDTKhUqLVJ5PWOG8LpIJNaCEtZLkiq6DQxYdxFe+R15JjrUAW6OK3alz6FrcMcha+1NgkHTFDa3c8hdK9g+Blxbd5+ixxKt0hx2CNHKZrpwcHS3Rv6k3U8xUG32NsIG+V9+59VuM6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271254; c=relaxed/simple;
	bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ECEfEmIWBBra2oDdCS+c7YrTvy7LrDjX+m/Txu+BMIWMCE7ZHceq8IKa+VlVVUo2kKiIoiMi4KwObxR/Ojl4dbK0VZJ3uKx9Ux2Mf+a/kMr0oP5xMaxL+Cvw6nyjAvi+w+/nvkGS91qBmH3yskrLbLWtSpQmLxu6UYBAWwLrKVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ITthcQjH; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yO2Evl4ZslMDoNGVYl4TVNj+nLEN0ruhFsGLXa0Tyjoa5VYUJcOA/Sah1uL/QW/swbbM7JZ+Zk9TQ6JQdpDxYbegrHT+JYcg0AtGMF+Cko7us6vz3Jee5lPTH0zfgRB1fCoSvwQIRowqrM984DxYnRWIPoDxxYpN6SNmRuo6N8/0vyzM7aGLrOeWskbJq1iB49q5WuYMyUZA2Pcr7CLbGS6kueI5UaV7wLTGeK6mj2i64fI1ZBVrk6iCwXC3ARaa06Zv3YB1FlW7ZO+l8fHmQWaQXTugL1+h9cjcPDivxs/y4eev6ZonaXqSd8JW16Usq+h88DH+ICKVcCTLpEK92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=nK2352lfhU4RANSY+pz8OyZ/cpkEMmS+2jkjnE6V0/vGO87W6cC7VOIhHY1hVst8ttrHYcyi2Melf1Sb0TTaqKeP7Y2a4nDRMV8QMjvDj/1CCg+4fPCshXaAp+E8reUID4PCMNp38vlhvrFpPbGiOMwmAgVFizo2YuikFT8Cq5/qfF4fX/g2uvP/OAAkDUp0uMrJTbR9hPsAZWqF1fSHjTOCdb2hfhDCq/gCYQc/zzVukMWcdtzP/QPcIkqRzq8ybyDoc+TjwMcK8YQ1h2dMTejYYGPl3DAv9slt0CrffKO8Wr76f4LvJRRk6ZACQMu9M38PxqMIF/LnXcH39D6wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=ITthcQjHLl94HO/A7NBnCsLf1kdi+onbjf9XyadnyMN/+wOVVE35tLw6JGSgZhLWOkWCbUk/VE4ojNbre96tZASE8ApSol8NfEYpcAxciLXG1cqnVnB/bGATIou5VnSCydTXvtoKbjuMqXKJ4W1widSY1bsTFW9gSqNsGvfrvWWWpRDSS3XmKFfOldAXaWAohmAYfUxgcPUyqJcj7VXfY2XsokF3ioRCy5Nmeslywu7f8e0bTAYKOMwG8P/mO9j53YUq2H3idAE6F6EeyZebMDps5NPFFv5UFwYjB7tI+UP0NC43p0omjoqocH3KrndDBbEMvmGrLBBlDqMpgjTlbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:47:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:47:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 10:46:41 -0500
Subject: [PATCH v10 3/6] i3c: master: svc: Replace bool rnw with union for
 HDR support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-i3c_ddr-v10-3-e3e4cbc17034@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762271233; l=3017;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
 b=hv5vnj+AkQ9nycEsiDNerF+82x/cFImwMIBrdJ98eROKPsu7Bt+2VOonkYM49VxyY+sbRIusy
 qlVQcJgEAypAGOaiUBtzGjSiM0UjUJz9BRx/LXCy8JuZkEMx2SeMDyh
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
X-MS-Office365-Filtering-Correlation-Id: 1db61945-c933-486e-ac04-08de1bb975a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnZ5cTNzQU9vWjJqNFpIcWRDVUMxdFpDL2VRZXRBM0pvYkttMmRYNkh3YURi?=
 =?utf-8?B?WnhaYmlXZHdjNW5PNnQ1QU1UZ1lZV1M3dk9lNVhpdFNOcXZPZ1JZZGRRVSsy?=
 =?utf-8?B?aWVBck00UEk4WUU0aGIxb1JUaFpucHJ3a1BRem5jaWQzRk52T2FUOUVOdXBm?=
 =?utf-8?B?NkRzRHFxbU9qVEpyaU96b0E5c0dkbnVkdWsyZlY4bGZKeTdETG5TLzM4QU43?=
 =?utf-8?B?WnRQZ2pVZm00S2FwTkg3QURtUjZJZVB4SDdSU1ltVk81YUExSjV5dWY0dzB3?=
 =?utf-8?B?d0VIb1dUSUpuSzNOWVlUWXJOL0N1V3pwV1c2RzRIcEJibUEydUdhS2k0NWhT?=
 =?utf-8?B?OGhCSWlQMlpRNUNXOWtheHJML3RoQWJlRUk3Sm9lb21zSTdLdGQ1ZUxUd3Jw?=
 =?utf-8?B?VXNodUt1WDRreW1nb2hYcnErUWpzUllsbjEzdXVmNzc1czdQMWpUN1h2ZDZw?=
 =?utf-8?B?S2VYMzV0MDBCdXdmYTRac2tpQ3FwY1pic1N3elF3WDdBQkpoRlpnMGlQYTlm?=
 =?utf-8?B?VE92T3hKTk9jQlVtWnN1WnFTTVVuZTI2ZFg1empXMmwzQzJYdzZCMjAwelI0?=
 =?utf-8?B?UTVsU01BSTdQQ21HQURWN0U5dit2bXNvWm0xaXNlQjNVWmh4aHh4Q3hGbVVK?=
 =?utf-8?B?bEZocnNZeWptNnRyZkk0THJ5NDFGRGUvYmF5RjJWSVkrVVBXMzIxNmtlQlIw?=
 =?utf-8?B?cHhhY3NCVi9wU2tKYi9wS1BMOXlBRXZyLzA5bk81VXlTUmtTRkdUMzU4RS93?=
 =?utf-8?B?UnpFSWVFc3pZMXRhNUdyVHZ1S0JsSnZZdVZEL29UNnlaVlh6em8vZmdOd1Rs?=
 =?utf-8?B?ZmcvMjF2ajQ3THFDNGRLMmxEMk9qZmVMenBQWnZkYStJTS9XUmlHZWc2NS9a?=
 =?utf-8?B?Um1aK1crWmZyT3hKYVp3OUFTbVFYRDdBVkFYT1Y1R1JIdVM0TnVnbUdiZEZV?=
 =?utf-8?B?MGoyL1dpN3luSkJiR0lBaCtTWi9xMnVuSlRFU1JWRzZKd09YMU5TZFdlRm5I?=
 =?utf-8?B?VFRHL2JSYTJQVUNyTWJRZHJtaTNLRGF3L0ZZQlFXSnBaT1ZRVHM3bWFJR0Qr?=
 =?utf-8?B?UlhuV3NzSUhnUStRRTdqemdmM1N1Z0tYNkdOYXRlTFo4VklhYWlpYTJZQW5s?=
 =?utf-8?B?QXRQUHpsd1p1VVkvam16QjBWMlcrZTRTSHlFZFhsL3d0cWlPU3VuRkV3SnFt?=
 =?utf-8?B?SFk4KzNnK2hWMHlNSk5DSUhHOFB4cVh0YzhudzR0NWp6NEh1Vit3dkVqUmdh?=
 =?utf-8?B?SmNXTFYxN1RFRnJpanFUeUJTNjZBdUY4RWxveDlIZ25EQVRsNXU1N3dZT0pZ?=
 =?utf-8?B?VWQyZUFZNm5ZRzdiQ2dQek5wZzFMRVN0blBPU3c2YlBicHRUZEVyZXA3NGw5?=
 =?utf-8?B?cFpSVVkrLy9vSVFGczRRVFFmaVk4NlBQNEQ1TkZIQ0FSMHFhcUVtbkVBZGZH?=
 =?utf-8?B?Z1VNOU56aWVjWVJlamtXbmhXWklxLzg4R3ozUmZvWTdzdkRjQkZ1THo5NktN?=
 =?utf-8?B?eEo1TlBMS3hmNU1jVjd0VGNSNGZKNnhGZllROXpDU3A5b1YxZG42eWlGbzNY?=
 =?utf-8?B?N21kMTVBQzEwV0pGelJDN3ErN210dEpqYUdwTXBpRUZPbzYyYlJFaStDWm1J?=
 =?utf-8?B?cm4yQUpMNWxjRUY4QlN0ZnVoQlFjdUNtdU9iSTI4dHNZZ0VxRGxNSHpFcXBM?=
 =?utf-8?B?RVhBQkRYYnluWCtxQ2NPVlR2bms4VjAzZ2VISFJJUlEzbFJiUFN2UlRNOG4r?=
 =?utf-8?B?YUMxc2tHUnU0Z3ZWNzhqNndtaGJtRkVRVEVVeFJQc1Z5T0VUVlJEcGNMY3U0?=
 =?utf-8?B?eEpQVFE5SFprbXB6U3F4bXZ6NnR6dTlPQ2ZqeXYweWdQbXpHZ1FiLytrRE9q?=
 =?utf-8?B?ekxQL2tlRmxldW9oQnlySUszd21KS3QzSDYzaHZSdVcwMkhvRnRpbmIyM1Er?=
 =?utf-8?B?TEdzNXNOSUtGU3FtZVZCZW1rbjdlcGRvTEQrVGVTdVQ4emp5WkY4c1VTK1F1?=
 =?utf-8?B?MmJsbGFlNzMwQnlTWnlHR1BYQnVHMGJyTkNoVTBKQ2hlRjROMTJ6eElDeWNC?=
 =?utf-8?Q?44uMUr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09kSmw2d2xVK21VdnBwVzZlMXVKcVFuM2ovQ2VHVTBrR28yMy92Vm1tNFZv?=
 =?utf-8?B?SCtIYkthZnJtc2xCNllxM1RkTmphdzdrSSt2VFQ1ejZXUnAxSnV5bjBzSFV0?=
 =?utf-8?B?WlZXT2l3bFUyYlFoMC9IVzY4Y1dqTWUwbW1lRmx2OGNFdXdzVEJJalI5aU1v?=
 =?utf-8?B?VjNWbFdqc3U0STNvSEliY3Ywbnh1WGMwdWtHekpuNnpPMkJIazg2OC8rNXR0?=
 =?utf-8?B?NDYyZ1RMVnhPVVlsNzhPU1Zyc2w3dWJrZldCWklraE5WRjhpZWF5SysxOGF4?=
 =?utf-8?B?RWtDbkttc0doNFVZWWR5a2RkWjRKaitmTXVkbENjS0RRMjhnUGRBdndEcm5U?=
 =?utf-8?B?ZDhxeFpJWTdHWTU2T3BxNVNPTnh2Y1FmM0JOMTY1c2liSHBVNEtPcVNOU2Rw?=
 =?utf-8?B?Wkd3Ky9wUmU2UThhUUdCcWErUjB0Ymp6R29VbU1GVEp0Ly9FcDRtRVNWaklC?=
 =?utf-8?B?NnpQVXJZY2FEY1N1Z2MvUlF6Z1NlOGJaN29jb3dqSGZwaDBVSDhhVXdOSTlV?=
 =?utf-8?B?ZGZpVFc5bUJSdFljMEU0eUQ5bUxSZXVTdnVhS3ZvMEl5bnE5YzVmU1RqVWUz?=
 =?utf-8?B?dzkrbkswWWlyK0tQaHZWTUxieG1lSnFpS05QZUN1aUpxNWZPZzNlTTMrRm1k?=
 =?utf-8?B?M3VYb2FRYWVRS3VmOU4rUDVpdzJKT1RIKzI0cHlwWE9EWi9NWGRVQld0Sm5l?=
 =?utf-8?B?MWFEVEJ5QWExOTNPT3I2cUcvZkdPd2JJdVR0TStpeG9pWGxiUVIrblphMk52?=
 =?utf-8?B?ajFFWWRLZXEvQzYra1A4R2ZIaml6dVU3NW1BcW5PT1REYTBONFowdGo5dlor?=
 =?utf-8?B?Yy9hemJRZWxJQVA2eE9aOTJNS3NmL25salR2ZTZwTE9qMHpvS2dJbzBQT0tt?=
 =?utf-8?B?YTExS2tMZUlUNE9qWTFzU0J1R09xNnE2a3lyOW9uTGRjVHA4aHhyR1NuLzZz?=
 =?utf-8?B?OTI4MExtOGthSE9CQVV6R3BqVk1Xd3VkYUNpTHNIZkdGMzNjZ0tVT0ExaFFE?=
 =?utf-8?B?VitrS2UyOWNlMHhGRVMzd29oNUtONWw3czFOU1NnazJ6S0p4Sm9CTUQ0UWh4?=
 =?utf-8?B?UXc0QVZSa3J1UXM5Q2Z5K3BaVC9XRlI0b1E1ZU40YmhqaWtRWVlhbzBBQ283?=
 =?utf-8?B?TnBLekpJa1NITVh1NUplZHpzOUZKYUFuc2szbHVvcU56YS9HQlhGN2FSNU1J?=
 =?utf-8?B?Tk9QWHlaL05OUFBiSE1PVkZiZ3BOMStZRlExb1psM1BHZDhBWldPNmRYYXNY?=
 =?utf-8?B?aGdZSFZQVzVQZXhuaWxRMytuZ3p1RFNyekE0ZHZpVlVRVDBJR2cxaHhpaUly?=
 =?utf-8?B?N3lxQUdhZmdTSE9qcmwxSHZ2YkNzRXZrV21kb1Zmb3cwT3NweDNmVmszTFpZ?=
 =?utf-8?B?WFBrL3UrWDc5cFYxYitFdHB2UXpjWnduOHNQWWlrSDQ4RFFpeU9SeWs3QTRT?=
 =?utf-8?B?THBRZGwxUGNTZDNSWXlhbFNLYmF6Q00veEdzaUFwUnNGdW5RQi9aVEt6RjJo?=
 =?utf-8?B?aXFUVU5NcHpyTkF3bmV0eWZXMXVyKzVVMldlbUJsNFJWbDJXaUN5UkxlSGxw?=
 =?utf-8?B?QUMrOGRnNzVpanNmRkdkKzVyaDNqSXJHbTFtZzhXdVlhTEVoVHV1QUI5ek1p?=
 =?utf-8?B?WUtaN1kzSFJWVWJyVVhpWnNzbmpFTVJnZ08xRitzTWZoaUM0VitRd0FsZHkz?=
 =?utf-8?B?QXJteDduQXBybjg3eEJac0JZQmd5U0Ryd3Z0MCtFNVRZQVZqdzhxTEZteDdN?=
 =?utf-8?B?NmF1cURHQ251QXlQZzZJbTFobmUyVGx5NEIwUDIrREdrd013eVQvd1JzM3Y5?=
 =?utf-8?B?emtuSStzSEh0b2pLVUdiVSt5RTV3VlBJb0FGTTdTdDRMNUd1TlA0NUpKdFE2?=
 =?utf-8?B?LytpS3c5WjBGTWMvRlltUnovb2V1b3FzMnR1M200UzhaaDZnZDdUODZ5RVVZ?=
 =?utf-8?B?Mi95ekxlaUY1eTFsVWRKVGtMZ1p5RTYwZVN3VVNvZ0pxWFpBTVQ0LzZibnp6?=
 =?utf-8?B?Z2xpZGtNemc5aEt1R28wNnE1YW16RUIrdFI2amNSeDdWVmFkKzRXZkl5SEVx?=
 =?utf-8?B?TUJvVENSRVYzcEMzaHVXUk9MR001bTQ3Y20yOVE3QktreFh2WXgyMkd3NUkr?=
 =?utf-8?Q?LZTo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db61945-c933-486e-ac04-08de1bb975a1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:47:29.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKHkboaBjeKx1qcylUez3JcvlMK1CCrf5RTQT5oaITz/8v/cB4SF09COClCHxZ/Gv5JYBTMkw4g85J77ID9w9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

Replace the bool rnw field with a union in preparation for adding HDR
support. HDR uses a cmd field instead of the rnw bit to indicate read or
write direction.

Add helper function svc_cmd_is_read() to check transfer direction.

Add a local variable 'rnw' in svc_i3c_master_priv_xfers() to avoid
repeatedly accessing xfers[i].rnw.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v7
none
---
 drivers/i3c/master/svc-i3c-master.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 9641e66a4e5f2da3bd84b30fa741e5e19d87465d..7c516e05d0a1a118479ee3d8ea8ae37ae19fea57 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -165,7 +165,11 @@
 
 struct svc_i3c_cmd {
 	u8 addr;
-	bool rnw;
+	union {
+		bool rnw;
+		u8 cmd;
+		u32 rnw_cmd;
+	};
 	u8 *in;
 	const void *out;
 	unsigned int len;
@@ -383,6 +387,11 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 	return master->descs[i];
 }
 
+static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
+{
+	return rnw_cmd;
+}
+
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
 {
 	writel(SVC_I3C_MCTRL_REQUEST_STOP, master->regs + SVC_I3C_MCTRL);
@@ -1293,10 +1302,11 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 }
 
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
-			       bool rnw, unsigned int xfer_type, u8 addr,
+			       u32 rnw_cmd, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
 			       unsigned int *actual_len, bool continued, bool repeat_start)
 {
+	bool rnw = svc_cmd_is_read(rnw_cmd, xfer_type);
 	int retry = repeat_start ? 1 : 2;
 	u32 reg;
 	int ret;
@@ -1484,7 +1494,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	for (i = 0; i < xfer->ncmds; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
-		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
+		ret = svc_i3c_master_xfer(master, cmd->rnw_cmd, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued, i > 0);
@@ -1677,14 +1687,15 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
+		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = xfers[i].rnw;
-		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
+		cmd->rnw = rnw;
+		cmd->in = rnw ? xfers[i].data.in : NULL;
+		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 

-- 
2.34.1


