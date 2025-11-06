Return-Path: <linux-iio+bounces-25991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8ADC3CE3D
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0E644F89F7
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED634FF6A;
	Thu,  6 Nov 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDE1gtm5"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F434F490;
	Thu,  6 Nov 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450597; cv=fail; b=f18g33Idm6quykeMrtB9HrK1rbAkHUlfobYSMebHKmN9H4TmJjE9qSmMk0Ck6wOg1ZXbmd5m413jDcR7U0b0DNw5kA0iq8IaN9dBhdc643ZH2ANEIpOAqH0gKi7LFGL5QcLw7IPqIntyQtVg7G7UKmhr5qF5NKpIMKeUk08UTPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450597; c=relaxed/simple;
	bh=5vasvYWn6j296foC0KD1do8HEXNE6j61yOhJlnouXFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oF1EqlrZamktEiMqzEKfPYd41/bk/keYWV2Tw0mljrMJlJZjlUihRXlOX+uDxtXUVm8tLoYr5q4AxHS5N7aiOSiOYM1Kv/FD7sprGY1Oxj5HNdtN5VioZ/dWlwsOlBq6hcTF3qx82bO585AfvCggMblLrFwLzw37PTNtFnaIe84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DDE1gtm5; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQ6zvHoR9IPKQwojSBSRzmSh2B+WckdFFjQZ4FqHc2gVb6ulDIHgHFq9MtDWyy5XTregm8Ne1t4uVxY/msM3LDJ6LkPDAJ2SBrdShTQ7o4dikNKDcmPWp+1iuOcr5mI6TEnaB2KruHQkzogiU+M1KbWllE7bPIbY2MLn3D6Qgdr6UNLG7A4NkSgF42ryTGC7ByolHOSQmVIDUgXUdr/iTltUAGYhFHmKTgtA6H0INDy2afNw36TN+lf9gmgUd0Mq0vPlMLTt5D4wjHGofcTNErm+g4cYUaVrlWHvfrEmIliSmY4pDHxv4RRDgoR8cj8nq5/ZywAEo4aVUBajWDH63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XbezMuE/5oIEAd1wLivMnBG/K28HshgVytpSww3aDU=;
 b=WTbwEVt0tUl2SV8rfjh2rP948I8YBQOOO71hSQ+/HJA0Yrl3cont43pEOMly66JOpp/M8tf5WSl3lJk5xLPFKcBUGSdhybzZhnI21debidQYuu60r82OetCTq+dTM1xTipGJ8+bFUKPt1wLqdC4clZiUWn2vei9lvDywm5qH+dKsFkTCh5RCFxp+QO8GoDi/lancPLzTB829LiFe9w33YxAzaTS0XcEmDhiKi0MtnfjEZR3a6bG2p6pZMmSq3Dqj1fOzFMI4ZUhdi4WON8YmD7bIiiFqSqnkY/e2XSnkanN+NHE1DHIuaL0mA6YdbgFgOsM80i5qIQXlIY5WlPqFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XbezMuE/5oIEAd1wLivMnBG/K28HshgVytpSww3aDU=;
 b=DDE1gtm5SBUayO6bp5WJetqqFOIK6tyxItY6orO+8CXunfDRmph0gVvhM4SDixEEVwOokyejTEWa2bpyt15d3UJegzVwgrg0H6DWZ/K+Y9/oSHfv4ZiXRWKr0x7XXyz7gxz+W/n7U1KTFSU9U3AB1laaUWiK8eNXY3w7mo9S74t0rKdotLdvfis23DMW/ADIc8RM22CAGYbEqMWXBArV3nQMUpmochweykuLKe9z5kbNNDS/d9Wu3kAbDn10qXMZlewswzQfXSby3NjcClJvZ0KdQzQKg18rXIQ6df8YNd+5VVP0g3drxRbFu8faarz3oXC8WXRNJYwGkykNVDlLNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10989.eurprd04.prod.outlook.com (2603:10a6:150:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:36:31 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:36:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 12:36:01 -0500
Subject: [PATCH v11 2/6] i3c: Switch to use new i3c_xfer from i3c_priv_xfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-i3c_ddr-v11-2-33a6a66ed095@nxp.com>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
In-Reply-To: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762450581; l=1345;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5vasvYWn6j296foC0KD1do8HEXNE6j61yOhJlnouXFY=;
 b=ZYUcAtAIhhxb5qjq5ynYsqaZHezmxx2Jx29zCAX0/J9QbSDs6qmVCv0x/wVdNPpEsfPA+uGOP
 lap+Sg5o0XzDos6VuFP6BAzT3hNcfSggJEIhatideN+QTJ/H3ekm3Sw
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
X-MS-Office365-Filtering-Correlation-Id: 6371af2d-023b-4d0e-bdb1-08de1d5b05f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dElHM3JFUzViRjYrTUJrVytSakpkV09UL1ZDeERXR0V4MzgxMFBzc3d1Tmlt?=
 =?utf-8?B?R2lOY2ozQW1JeFZYdG9SNXNvQTlsZkVxaWdqY0JSQmxvcnI1T2dGYzJrUWFj?=
 =?utf-8?B?a1VCWTFSSVNIMlhuVzVKWW8wQ2xpT1lOU3NmN2hxODN1Q0RxNmdYUVdSR3ZV?=
 =?utf-8?B?bmtHREc2TVB4SXV5cktFeWJIb3hoMGNhVnBoUERiVTRhWlRZUnI4TmlYcFZp?=
 =?utf-8?B?cWZxOTl4MmFmL21FbTRISE96L2U5elJmS002QkUxZFlNblNqU1ZyMHlPT2l3?=
 =?utf-8?B?Wlo5aFJoMVhqNnBFaEtrOWhla3EvTGNwUkNtV0cwQlRFa1Z1d1JaK244eEd0?=
 =?utf-8?B?WDBDKytENFY2cFY4bE8wcVBFd05JVEVZOVRVSnhEQ1pNVWEzdk1VRUp5ZGRC?=
 =?utf-8?B?TW5XVUdnMzZFZUlNdVp5RkttWXFYN0Z3RDhtVi9sQkFFYTRQOTlsYnFVQUp4?=
 =?utf-8?B?bThCWGpNL3BYTndqKzgxcUV4Z3hrTUlzZVhLTW0vcVQ3VlVyekR6ekIvVjNU?=
 =?utf-8?B?SUVCTDhTVXh3VzE2YjNxV3BNT3JnVFZMUDdYREovSEJQemI0dlZYYVl5a1JB?=
 =?utf-8?B?K2ViNWp6bmxYSEFsd0tsNEMrdUp6Ky9GZml2WGhsWWRLNVRWemdyeU1vNlhz?=
 =?utf-8?B?ODZzcTl3VWtIeXpjOCtmcWVHT283V0U2UXdMc0hGVlFhNGVmV21lTzNXaFlM?=
 =?utf-8?B?WGdoREQ5bkwyQW5Sc3FSTjdXMEJ5WUJsSlFGQWJ0Y3hZTGo0Ry9xREtSMXQz?=
 =?utf-8?B?T1ZJazlmVldXMmszb2s5UlMyd3BrLzZnRGk4ZGhVZlgvczVLVGpBMmpZRytS?=
 =?utf-8?B?dUNqbVdwZzlRVzljV09oM0ZvK3ZxZWJlMjJDUlhhRWlyT21UT1pUMENvTmJF?=
 =?utf-8?B?UVR2eVlEaDRCU3cvT3EwNnRGc2JQWDJ6NlVwSERabEFjZ3V4SVNqWXhXdGR3?=
 =?utf-8?B?NnE4ZmcyUmZwUzk2NW1ONUZiWGpWM1RrT1NpT2JtOUxsNmxUSmhkSGltbEw5?=
 =?utf-8?B?NFF4ZkRSa1ZoN0laYlB1WmNwQktBNjZ2VDQ0VGJySEMvZE5qVkNtdm5wZUp4?=
 =?utf-8?B?eXFubnBoRllSaldFUkdZZFVYTGZQZUc1YVQ1d0Jsako3WEdZV3U4RlloNldQ?=
 =?utf-8?B?TWp6N0pFajM5VzB2UEhWSXVRajNIMEY4cTZ1cU9NUUZMdU5iMzFuVXhtMDBT?=
 =?utf-8?B?SWdQMC80Ym1paFJuTjVHSCtsWTNvZ0k2Nm1teUduaXdyQzlabWo1YU1nYWVD?=
 =?utf-8?B?c0J2S0d4NmhBL1JYMTllRGYyc2VVcUM5dmpkNkRiSDFjK1Z5VzV0OCtJbEdj?=
 =?utf-8?B?c0RRMXBSd0JYZndBQm1jRUxGT1EwKzRFK01jT0V3RmN1NEJoREo4U3M4Q1Rz?=
 =?utf-8?B?WGFBWXNVeWJYOE1NZy9LSFV5Sk1La3BGR0FPSkE4V1QxV1I4NXp1RGFzRE5u?=
 =?utf-8?B?SmtFaE9zOHlaSkpYZDR3UHZzUkRkYmFKREZNMTdLM2FGZit6ejhHK1RTNzBM?=
 =?utf-8?B?djA1Y3dyaGpGbTlaOGFuY1lZYThkbjZ6U0E4WittQ1gyZDg0Zno5QU5QaXpM?=
 =?utf-8?B?a3c2OWNEdXpvTHNTeWZsd2VuK0NnU1ZhUmMvWGFkOExqVkRtWTkrRmxsYXp4?=
 =?utf-8?B?MHlSOGUxQnV6Q0pYMVRnc1VkcDFwbVFLVTQ3dCtjbHhBYkl4SEkydmhNaWlJ?=
 =?utf-8?B?dXMvZ2Z1UWxXMU5OQmpMMld0SzZzNm4rRzNPQStuS0g4bkhaVWhvaGVHLzYz?=
 =?utf-8?B?cVgzRXVwdm14b2pIa2xPeTE2VmVjcVNyZUNTa04zMUxZNHFzSmlZcUI0NzRX?=
 =?utf-8?B?U3haVWNDTks1eEF0N3MrTzcycVEzb2d1MWJFVy84VU56d09lRU0rNXZ1ekVk?=
 =?utf-8?B?MTJqMDVyaU82N00rS1FhSzJUcndVTm92SEVCOEpmdmZEYThnNnBjWmNMbTYy?=
 =?utf-8?B?Y1dic0xHV2pRNGlkL2lINmFRb3RGNXNnbEdDRVZjcStXZkFwemE5bUhEYmIv?=
 =?utf-8?B?aEErUlVicFZmREZ4UzhGV0RrRk5hNWdIN3lkaFFOZmVrdTA2YVl4aEZ6a2V1?=
 =?utf-8?Q?CL6GIV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlEwaWZCMDE2ckN0RzZHYTZSZXIxN2srSTFLSHhBaEUvbm9GQnEyYkt5N1JZ?=
 =?utf-8?B?QXJ3RU9qeHZKOFRoS2hpSCtPM1hBc21odzhLb3JSZ1hESlI1TFdHL2dCSTJO?=
 =?utf-8?B?dFh4MXUxWUJSU2NCeTdYZmdKL0lnRm00bkppQW5PRGQrbHYrbDNkNnZHZGVa?=
 =?utf-8?B?bVhDM0plV3J6NHVmVFdCK3FpNWUxNTFjbDFMd0JJK25MZHZES1lvSnhkc0Rv?=
 =?utf-8?B?alU0alZONms3SGEzeUFRUEduZm9hSXhNbkRNaEVoS0xyZVpZNEFOZ1J1b21Z?=
 =?utf-8?B?NVh2TUZrL1hObFRodlNvRzl6T0N6S1oyUWplRDZ6R05JaXpSS2d1N0dsWFF4?=
 =?utf-8?B?RSthOUdVTTJvZUJCUmV3WnpNV0p0dVliOG5qdU9Wa3cwMnF2ajRPMlBoTEN4?=
 =?utf-8?B?TzViSTR3RFE1MnFYRUpWblV6ZldPaDI4Q013QnZGQnVVOGw0UVp4SUpXZkI1?=
 =?utf-8?B?N1YrS2ZwUTI1eHhib0VjT2pjZ3NLa2Vra1FaQnhWaXk3eENSQS9ZeHlkdU5U?=
 =?utf-8?B?d3RNSEovVnh5Mklac1MxR2x3ZEphRjJZMWQybVEvdkhUTVBZQnN3MTBNaEpy?=
 =?utf-8?B?M0lVMFNLUmUvV1cxdGJVSGt1TTB2R2VrUVhkR3FPZVVjUmRNVWdwTHBxeEV2?=
 =?utf-8?B?b2dEU01RN3pxZ25VTW4zemgyZEs2L09YaEs2L3l0bCtGWW92eGlMemM0dXVO?=
 =?utf-8?B?Y0JjWWV4ZzMyQmxiV2lUR2ZBL3VKUlNtbVNJeUc3UFBEWlJqRGhCRk4yTlMz?=
 =?utf-8?B?c3hHZUhrRERnMGtBcU5WMWZqdDk1YmpMVzZMY0xFTWx0bnNYSktjbk9OekFk?=
 =?utf-8?B?eWZTR1ZFWmV1bmRnSHNJSjZHVnQ3ZXJrOHd1UkJZNkdkeWNQQzJvSVF1SHNU?=
 =?utf-8?B?d0hLZ3F0dTUxbTBnaThKeGp3b3Z6aTFlN09hTE5aQTlDelBEVG1TZ2Q1NjZz?=
 =?utf-8?B?eWNUcG5rVU1xZE91ZWlQUEppNVoxYUtOdThnOHh1SUVycW5CczNiU2UzMUZN?=
 =?utf-8?B?R1h2MzJYaTZoUUw2bWRablh1aFhUWUtwTjBPNlFZUU40Q25NNHJ3ejMvMUQ2?=
 =?utf-8?B?aVZqRFg2dWJHNXh0NWhMMld6QjdWNVo0QXNoOW5Kdnp2WHJwdGgwekZQeGUx?=
 =?utf-8?B?ZTlOZGpsTEp0Y0t5K01GcXVKQ1Bvc0xwSDZkZU9GUEtibHpuVVBPRGFwdnNi?=
 =?utf-8?B?VHlyU0NQUGozWFBwTmc0ZGN3MzdRZit3SFB5cmtJWGdINGpNREpZTldrS0s4?=
 =?utf-8?B?Z0d0R1VackozZVlERkU0NEVCbzVhL1RmdC9nY05aV2hOamhUdGJlZ1lsdEI4?=
 =?utf-8?B?bGUvc3FVWGo0bDAvVWtqZ2hPUjZCL1VwQWZtMktOT1ZGcEZySEx2UXhXOEJt?=
 =?utf-8?B?bGdUT09vQ0FVZ0FCU0w4L20xWEhrdC9PYnFtZE1NOUVha2RrcFQ2dnJIRFJu?=
 =?utf-8?B?VlJGUnYxeWxOS1JhY2E5SU03MTBFQXVuUXNqblloVnFjTjJiREh1ZjdVcEVp?=
 =?utf-8?B?SklVK3pJUElhWUxobEFoaTVZNG1USk5VUjFwdFQ3Y2o0OGIzS1hCZk85SzJZ?=
 =?utf-8?B?NGpoMDd4Z1VHOStseUwwMFNhdWZCQm5XOS9xYi9LaUcrbURleHVCUWJFYkJm?=
 =?utf-8?B?cnZzZnFoNWFoTG4vQ25INGxhcThNYmxQRlIxeTg5Y0I2Uy9razJVRFU0dWJX?=
 =?utf-8?B?T1ZweldTc0ZFaGdQTjA5QjMzQkRnZlVGRWQyQkowSkpRNXlSU093Y0lQU2RD?=
 =?utf-8?B?RnpsRld2dDZxN1dNTFYxNjlCcDhsMnNMdUlMY1k3N2phVjc0WmZwYnNnbzdl?=
 =?utf-8?B?cTJUTjdxZTFwNWNFSlo5TkZlREJtMDV4MHNGeGU4ZkxPTXNPcTZlNFcwWWMw?=
 =?utf-8?B?a1p1eVQzNERyTGwrZlEwSTBnbGlWSGlpM1FKcXVJeE95YkRIeTVsdlpZbTVB?=
 =?utf-8?B?S0xWdEJpbzYwc2ttQ3RRcTMrNlZMS3JOaUh5UmNLalFlbEhpL0diWXl3aWtW?=
 =?utf-8?B?V0tlc05EdThjSXpFTUdxVUZFWkRnZXdubUV4VzJxV3BMbFJaekZ4NERKcFdI?=
 =?utf-8?B?VXBPSTRBbDFkZ0VKdkN6TXdxMXdkUkIySXJPdjBKaU9UNCtxMFZ3UmlNbHNN?=
 =?utf-8?Q?BGJd2ADgK7zpT8CVuz7pzLV/E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6371af2d-023b-4d0e-bdb1-08de1d5b05f4
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:36:31.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNPY86y4xsZ+4tJ4BQe8+pcbyF+/XsIcbbIiJiGhNBpAoGbfaOQBy+GzVy9in935ErF1bpgAjOl555bhFz3RHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10989

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


