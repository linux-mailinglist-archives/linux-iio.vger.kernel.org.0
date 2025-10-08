Return-Path: <linux-iio+bounces-24863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD500BC69B9
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F91420234
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 20:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4A208994;
	Wed,  8 Oct 2025 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="srZmrjVd"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021072.outbound.protection.outlook.com [40.107.130.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BFD1EB36;
	Wed,  8 Oct 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956391; cv=fail; b=nzpYxy+CfpkPwXST4Ru6K6oujWuS4IreeTwgyj+cKWFkhbvxn2JNPDgZWG+wNo2CbbpGQtv4+T91kUFDwHqfT5VrM4qXXUOuFJSF/mAgczF+Hy5UnOcHSYewKxIAag5JFZD6s302HLKmeL21ZMss9Zw3KB23fLSaqQM7F+XiEig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956391; c=relaxed/simple;
	bh=rRClyo0HbOEqgvw8UX91rcVhqX12SXScaopllw7YGYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljMeYE+KlKCAOBsv1LRgUKYWnRe2bBbO6CF7Rc4Xn1K3fnwbN3OMPMV5f57qRoDG81oMizGmbNRJVX/g3jTtOYsajY+5VziQ0RTdooevhIbryYHrR2C1eUKtm7EvyqA/yge2n/8ogk/u9r6D3/2r4J07YqxJMNxAqoO6qDqYH9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=srZmrjVd; arc=fail smtp.client-ip=40.107.130.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHUXiVX6Hz5CN8W72Eh16HrOQbDsXPPH8D+lPAKdrF+2amDa0BLP6JsEfA0fxS16xURAdR3CBi7SW//ffnVZDfz7/j9Iap3VtHUEjmnK31jfaBcDYZLnx+ukfGxWxxBtwiG1z8O0e6t8Xo4tncpirhPbFkldVf6PeAMCfncMMovPQjsR7+JjEhOlZJXdhJ2GPU0RKaHFe+EpXLPEe3xdtFJ0228ekwHX4zmBhH9QHhGF+2XrVrt91SDbHnwdYLsHEWPlzLg9J4EmBMUC50hnkNEmXXkyFxsD4RQB1CqPXHxyWhIAMOIuwX9OsR88JZGwdhiVH3tmjtSzpd74rB44bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLw7LAl3W9Gfi3zx88F0A8c2LqwMzoBMxjou/u43v1w=;
 b=tc7IHvTg17V4L1eJ8g6mPK/CAKIzC09QWck4cOVLp+dgsl/9artvTV6UfdY75rPn5cbZvysBrogAkqrlR9zi2ZXn6MpEKEOtcfwgrd71xU1ubDWVLWdi/5dEIBBCTslH1EGixqjWMbZsSIaPUKiIu3z44ZaMFmKVEzk8+RbjOf6zPUVvf9OvV0SbeWdOPv9cw2xSARJHo0tpHWq1xzAXugDt4UgqryM9IZxtmnZpW9qYfO33mQOApJgXNWh4RqOrPUof6fy47YzbCt+WRqqXDRknDHnsMMZ49Y/LZzkdX91Eh1o+WF59k3kNvzsIb2KIaouUBGC/vAAKKqevLnW+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLw7LAl3W9Gfi3zx88F0A8c2LqwMzoBMxjou/u43v1w=;
 b=srZmrjVdo0KwjY2uLrVk1jOjrX8rVEOxkq6iYHbATP6R/N62438VA3+csPVW/1QI9tyI8O+8mO4wO3AGvXinJg7lZI9p7KrnTQuzyT9Ifv/fCoxpbLZU3Z4qx/ajNol308T5ufe0Pfjn6OR/T4AkM3JAbh8l70Xnoy+TWjh2BmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from PAWPR04MB9806.eurprd04.prod.outlook.com (2603:10a6:102:389::22)
 by FRWPR04MB11151.eurprd04.prod.outlook.com (2603:10a6:d10:170::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 20:46:24 +0000
Received: from PAWPR04MB9806.eurprd04.prod.outlook.com
 ([fe80::7619:14c3:6aaa:fae5]) by PAWPR04MB9806.eurprd04.prod.outlook.com
 ([fe80::7619:14c3:6aaa:fae5%6]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 20:46:23 +0000
Message-ID: <ee87c8c2-eaa2-4fb2-98b6-1da0cabee056@sch.bme.hu>
Date: Wed, 8 Oct 2025 22:46:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Kamel Bouhara <kamel.bouhara@bootlin.com>,
 Dharma Balasubiramani <dharma.b@microchip.com>, g@tpx1.home
Cc: William Breathitt Gray <wbg@kernel.org>, =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?=
 <bence98@sch.bme.hu>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251006-microchip-tcb-v1-1-09c19181bb4a@microchip.com>
 <ijigaljlomxtyoy6ha2czocr7gnjqfdxs6kuhg3w4jxlwj4cr5@yum4paorabnm>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence98@sch.bme.hu>
In-Reply-To: <ijigaljlomxtyoy6ha2czocr7gnjqfdxs6kuhg3w4jxlwj4cr5@yum4paorabnm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0012.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::25) To PAWPR04MB9806.eurprd04.prod.outlook.com
 (2603:10a6:102:389::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9806:EE_|FRWPR04MB11151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd8b9e9-1f38-494e-e83a-08de06abbdd2
X-LD-Processed: 79f0ae63-ef51-49f5-9f51-78a3346e1507,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|376014|366016|1800799024|41320700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXpYYjFKdDF4SkpXU1RrQzE1M0FneUhCWTZnOFdQVDNLNnJrNmpwZm1EeXhM?=
 =?utf-8?B?ODVNUjF4QmNXbVl2R3BBT1IxMHlDYlM3SVJDcnpZTVZaTUNpUCs1OVloMjVK?=
 =?utf-8?B?S05wOGFEdWdyVG9JU0MzZnpyRXRZVEJ0U2RSRFlmRjlGMUNmNjZsMlNwOUh6?=
 =?utf-8?B?OW1OSjZnYmw3bldTRFpxMHZoTlJJSHRYMFVvUU1xR3VXcW5rWkx1VVFjekdL?=
 =?utf-8?B?eEEyakMvbkdTRWI3WndNcktuYXYzSkFIOGt6OURWZFdzaXBYOGJZcjBhTE5V?=
 =?utf-8?B?TDhPUXBMSmtidG9ic1ZBUER0Q2RtZWw2cmJGenpYSU9idGJERW1wOHdzQUc0?=
 =?utf-8?B?RTdTN3NsRDBEWXhaK3JkamZJQ1RYSVN3NUhmNStXL2hXdEdKSFlKS05lWVdZ?=
 =?utf-8?B?QnBsdlpFc29ydUN4b3kyWUdIQmNtbkoveTNOUHQvclR3aVM1ZXhGVi8wSlVy?=
 =?utf-8?B?U2VPNXY4MldOcFFuUkFzZGh4MVdIbW91QTBNc2RPLzRWWGlOVUpSdDBRYnJq?=
 =?utf-8?B?YjUrQ0hoWit0ejJhT1cweEo3aTlXNzhFN3dSKzFXSEZSYzB4czFMTHJ4aEVJ?=
 =?utf-8?B?NG9kcXpkcmlQTnlMb2Z6RkJHREtRQ3RHSkh0QTlNdEVLVmdsTWZCbXpIanQ0?=
 =?utf-8?B?OHl4eEV0RjRIaTB5OFlXVVFkMEZ3blBHOWtTeWlZWWhsWDRQVDdDQnNjUzFm?=
 =?utf-8?B?V0dnRmYwN1pqUFhxVzdTUFlMSFY0b0tkRE1CbFNHT2RhblV6eHBqMGtkWU1x?=
 =?utf-8?B?UlQ1ZW9jZWNOS2hZT3ZkRUE1N1Q5SHp4ZXJYRnRjdzRVUjA1ZGlOSStOWHgw?=
 =?utf-8?B?UEN2Tnc0UWkzaVYzaVNWNWNXZzhQTW9MdFQrbzZydUtKVHd1aVRnbmtucTdD?=
 =?utf-8?B?ME1ESWx4YnVoQW91MzRMTFgvTHR3YTR3OVY0Z2QwRUpIUW5LcDY4am1YU2gy?=
 =?utf-8?B?SDFDQzRyZldzbUdCeEhvQ0N2c2lqYm5mL2plUFAyWERCVm0wOGw3Z0NpTWRP?=
 =?utf-8?B?QWdPazFSUmFMaXNpZU5UaHVwRm5EMTR6NThJOCtISElVU0FscFBJL2pZVzdo?=
 =?utf-8?B?Nk5qMkI4cXE2WTg3M2tZMmZqOEs5c3hXdTBqVWpzMTZncWphMUp5UGkzTDMx?=
 =?utf-8?B?QTh5TVZVcVNKWndKSVRtb0o2eS9zdk9sME1SZ2x2em5jRjQzdHFCNmtqNE9k?=
 =?utf-8?B?MjBCNDVoUWwvWG54QWdXbHJpZm45TDBRbUdhaG9nMExTVmlEMnp1QWp4RWNx?=
 =?utf-8?B?VGVIVDJHbTJlRUNWMmJtUjd2NmJXVWxvSXdHUDVZNjRmTkUxZnUwME5Dcng0?=
 =?utf-8?B?U3BxZ2VVQkZ6NnpWZ1p5NkFRbm1WMW1UOUtNcmhPUEZPZGdpdHJvS3R0M1Q3?=
 =?utf-8?B?WHNSMHhTV0MxODNaM2o2OFByd2E1QjJmOGE1YmFuMzYvNzA5Zm5aRThPWVRo?=
 =?utf-8?B?OXZGU3QwNG02dGRCR21vZGVGSUNRSGpGanB2UmpwZi9OcU10TkFZeHRjS1FV?=
 =?utf-8?B?dG1pVDFpL29DMm1XYnJVRlQ1SWVlMWpZaC9kZTVodG9naGNsZitKeVEwVGQ1?=
 =?utf-8?B?L244V0RaSm1rckt2TVIwL3hNT3hUV2MzZWZtUmMyNTBaWGpGSjRaVlN4MHBo?=
 =?utf-8?B?TENhdzI3RUlzdXJMZGFHcmpUQ0lnRjVwczRsd1IwL1FHRkdjWCtIQ21zbndP?=
 =?utf-8?B?SHhMamRKeTdtdGlDekdlQjAxWjdUYVBGaE8yT09FTDg4cEJmQTRqcURTRlFK?=
 =?utf-8?B?ZkNKTkx1OHNOcVZFSTZzTEMzdEt3ZGFReGw5NWhsYmdmM2RrTE1DNTMzRk9l?=
 =?utf-8?B?YjJKVmhLTmh5dDFFb1RUWCsxditlcHZnOURWM01oWFdneSt0T0o3S2U5Qjd6?=
 =?utf-8?Q?qyExixs75vraf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9806.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(366016)(1800799024)(41320700013)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anBvUnNxOE1zSHJNeWhVaUJYMTBSNTZ5cTdUOTl1cDNiQnRjNmhzK2E5VE90?=
 =?utf-8?B?WWpjU09KYzVpSytUaVh4b3ZEUzExa2lqTng0RldvWTIwT1VEWW9PSWFIR0tK?=
 =?utf-8?B?R084MGJULytQczNvUHA2dUYwL3Zrejc4U2dWOUE2SVhhcTkrQUplOWtHYzEx?=
 =?utf-8?B?N0JlaWZTS1RaMHpHMUcyclpBNGZZb1FFZnowVzBCQlBoanVoV2d1VTF3OXdO?=
 =?utf-8?B?K2dZdCtncld5aGpiWjBvZHkzdFpuSlF5eXB5bG5ZTjR2ZXJXVis3bG5hbk5q?=
 =?utf-8?B?N0JRVlUwTkhubEdqeXlITFNQSTVrZk1qQ0gzbkxWT3JrZXZ1b3ZhTzRiWXgz?=
 =?utf-8?B?Sm9CWWhMekJ1ZHB5VWRIZ2JCM3dJS2JmS3Z5Mmx0bmJEVmVGbVl5Y0dKTVA4?=
 =?utf-8?B?YzVsaHZXckp1QVRDNjJ2dmpFSVIwNnlqQncyYkFKT21kVzdXOFNtMFloYmg1?=
 =?utf-8?B?ZE56dWd1ZTFMeXFFdmdZcU9vUExYZlF0SnRpME1lczNMbVl6ZGFodHlCKzZw?=
 =?utf-8?B?YlkwRndJa1pYL2lwWnpiVDhHS0FrWFlPbzdxcTNHL3RIT2tyWktTNzl5Yklw?=
 =?utf-8?B?dVV1VGJWRkZGbmtWZW1BSWJtdnB5RHFoL1J4UEsrazI3UTZld0ZOYkpNQ1lk?=
 =?utf-8?B?ZHlDVkVlN1dWY2NMQ3B3SEZ3N1pMR2xEY2l3cFBIK0ZJOTFGVUxyYzkrR1ZC?=
 =?utf-8?B?VFlWbDdqZG81NGRyT2FmSVJIUGJINUUycG9kL2xPZGV6MzZWRUxEdXB6TXZF?=
 =?utf-8?B?S1piSmRkVitQL0EwNGwzMFVSNEk5bWt2N29xbGJZUklWZHR6ejhFV2I2OEpu?=
 =?utf-8?B?S1Y2OGVZVGJzUW5hOTdFcmhpbXZuUGVaajFPSVE5MmJ0QXNUN2xzbXB1OEFS?=
 =?utf-8?B?Yjg3SXZKVW1vWitadldXdVpDUFU0NEFteW43RHZvK1JISW53OXFHUUdVRTZi?=
 =?utf-8?B?WEk2c1p5ODcxOGEvN3hIdUFNK05IRjNnelFDNHk4OGxvVGRNeHBtU1hZd21O?=
 =?utf-8?B?bGxFb09tdjVmcCtwRlJZQnIzK1NzMlp1Y2ZncnlMQXRYZW9iTWdGU3VaREFC?=
 =?utf-8?B?UVhad1JMcTZaa1FpSFlqY09zaWFhTkpFbVVwcmpmc1BHOVF6bGYrTzlmdENH?=
 =?utf-8?B?amtZSUMwRy94enlGdEp3bmh5WEgvUUJEN24wTXlYYlVwc3MvOXVIS1JZN1FQ?=
 =?utf-8?B?bjY5WDJaVGZ4OWxGYkdzRzhIWHIzYTU2a01EWkdFNE1ucjVNeGdvb3NNZVJj?=
 =?utf-8?B?cXh5T3o1L0dJM0dDOC9lc2NNUVNvcTFMc3hnMlNhbVRFUFZrWXhaWk5UMWNn?=
 =?utf-8?B?MmhWdlpJQUNVWnk1cWQ3N015MlVkVGNHRXJxeDBpR2FhSzZaT2lpejJIM3ZG?=
 =?utf-8?B?bEVaWFlZc3g1OGUrQ1FRWEliT0g2bzFuSlBvTHdsUDN5UldBS2F5bzVlSy9J?=
 =?utf-8?B?K2hGeWFIaDlBSUtCemNydHYrUGZuWk1Gc0kxekplQmxUQnhkc1dnM2ZBTnBU?=
 =?utf-8?B?bDRjQkt6U2dZOFBFVnltSkV2bU1rbTRBR0lJbUlUY3M0SXFKUnVvbmlVT1pP?=
 =?utf-8?B?K3NpNlpEVE8vSWRKSEIySDRDaExJSkF4cnBhc0pFOTd3WERHVGFvbVI5OWRJ?=
 =?utf-8?B?OVgwRDMzdHk3WWpwWjUvSFROQW4vUzZ6SlVEeDc2TGFXODFzY204Q3MrN2Fy?=
 =?utf-8?B?NkEwZFJIenBlUUpsYjhiRVArRzNBQ0JLdHJieWtXTUNhM3dwSTA2RVp2Y0N4?=
 =?utf-8?B?OFg3VWJIeDdEOTNIcmk5YUNYWUllTjV0Ky9JRmdGa0JFQi9pR1FYU3RsYUxJ?=
 =?utf-8?B?enIxaTluMUUyZjRkeXlSQVZsS2ZNS3JFTkNtSFVDNmpRUGNDdW00WFRhcEVp?=
 =?utf-8?B?OU1kRlNRWFJCeDF6ZklpRGt2MXlLLy8wZjVBbUo4U25yaHo0S2JIRU1MR0My?=
 =?utf-8?B?SVp2S2hNREZ3K2JhaFdGRytkdnpVekRqRm1XczVJVUFJV3BDc2RWWGRKQUhV?=
 =?utf-8?B?ZStidmpPa2pyS3pKRVR0RHAyc3QzcEh1NFlYbDFVQWxRYitRaWwzNGxWODVm?=
 =?utf-8?B?cjdLd0dGbXFDRmNUbFJ2dW1MOFB4SmZlM1d5RkxCVGFQT1RmNXFjcGdYZ0Np?=
 =?utf-8?B?RDg4Q2ZQVVVmaWpocWFQaUNINExNbjBtQW9uYnJCeElpSVpwUDdxdkNKVWNn?=
 =?utf-8?Q?u9sIUQ1B/mYFsJ0ugS4KpSk0A2/3Mp7gjchELLgk6Z6+?=
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd8b9e9-1f38-494e-e83a-08de06abbdd2
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9806.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 20:46:22.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xo9g+dfK6y4QCt8TMYlL4TVrOxfgG9AELNwdjZ3qqnd8LeMU4WEBI7DP+Rn4QO873zrLgOGyztF5iT5eFtomhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11151

Hi,

> On Mon, Oct 06, 2025 at 04:21:50PM +0530, Dharma Balasubiramani wrote:
> 
> Hello Dharma,
> 
>> Mark the interrupt as IRQF_SHARED to permit multiple counter channels to
>> share the same TCB IRQ line.
>>
>> Each Timer/Counter Block (TCB) instance shares a single IRQ line among its
>> three internal channels. When multiple counter channels (e.g., counter@0
>> and counter@1) within the same TCB are enabled, the second call to
>> devm_request_irq() fails because the IRQ line is already requested by the
>> first channel.
>>
>> Fixes: e5d581396821 ("counter: microchip-tcb-capture: Add IRQ handling")
>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>> ---
>>   drivers/counter/microchip-tcb-capture.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
>> index 1a299d1f350b..19d457ae4c3b 100644
>> --- a/drivers/counter/microchip-tcb-capture.c
>> +++ b/drivers/counter/microchip-tcb-capture.c
>> @@ -451,7 +451,7 @@ static void mchp_tc_irq_remove(void *ptr)
>>   static int mchp_tc_irq_enable(struct counter_device *const counter, int irq)
>>   {
>>   	struct mchp_tc_data *const priv = counter_priv(counter);
>> -	int ret = devm_request_irq(counter->parent, irq, mchp_tc_isr, 0,
>> +	int ret = devm_request_irq(counter->parent, irq, mchp_tc_isr, IRQF_SHARED,
>>   				   dev_name(counter->parent), counter);
>>
>>   	if (ret < 0)
>>
>> ---
>> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
>> change-id: 20251006-microchip-tcb-edd8aeae36c4
>>
> 
> This change makes sense, thanks !
> 
> Reviewed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
>> Best regards,
>> --
>> Dharma Balasubiramani <dharma.b@microchip.com>
>>
> 
> --
> Kamel Bouhara, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

Looks reasonable to me as well.

Reviewed-by: Bence Csókás <bence98@sch.bme.hu>

