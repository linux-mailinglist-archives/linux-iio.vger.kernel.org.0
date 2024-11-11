Return-Path: <linux-iio+bounces-12142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685179C43AF
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41267B20E85
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DC1A9B3A;
	Mon, 11 Nov 2024 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mztcw0VR"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5961A726F;
	Mon, 11 Nov 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346358; cv=fail; b=NN2pGfrceFA07v8DpIPF+AtJAEtzu1AiVnAXAfmm3+uV5n0SfUyrhOYXkOQOwinymQyqv0eG3fhTSz+xYqyOi7Cu03aJyRiwby8Umq1H6N1/hpc8KEi4yQxsFtFG7OHhK4ljmKHgKrjx7SLQnbhCHUgS6CVUnEZohKJK7pGe2AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346358; c=relaxed/simple;
	bh=F2mWwmqB3xPTWDFgjnxmtdJotRfdAqd6ua694pMuTzk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lpeUGnXoIiXwomOWOQAOM7TWwB71W7P8+Z2JydNFcx6c7Y8DFP9Tatp96wOvg9kACpUCtW3eoRn248Fl9yJHfOr/ku+In6Nvhxv86RRVcO5dkvL1Stqvpa4+rHrmg3ciH0AUBS2qwiL5lhu/emjBHxwWZMC1Wr3Fa3fFXcAG9ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mztcw0VR; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFe3z4zrDdJ9UKFq6fVFAz9Ig2u/4ZAdIYz2gYs8VzaniKTsll0lVAE9N/ijaE3rYx7ABkdbtWP1Qi2lXEokF9eNlAZJQd8776fh0geHo6Kb3jW64NQ1F54R2e09lyNuaMkwwm0Ul7UwaLIisQrSZlfOI2VLhh930whAqkVqeqeTAuBdH2PYPosdoibILO+S7ui4rk4tDYf6sLCwCupYNQixDh5VeOHYDn4iA8x1LI1J940AANckHrM+/3u6FDDy/W+EWiJByZjG+NM/6SkDW7PZNIBM8R2z8z5Yrer4G/ljPh1Av3VVxSmM1rjJ1SKznu0acnPdW/huZ18kcj6GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciOGcGZ37BURX/8k0A7rCT+Zcsjte+FzS7u5+nVm2lA=;
 b=AJe5ZpsDDQN6Bm1oIS/ISvkrGoOl+IYe3Utws3/RwXfamL61OSH1pKO2oSu0e/JkIsvy1/mKsnNosivqMRpkLpuExpFDedQKxCGBQI3lAYukQkqpEgo8xDfCcOQAT7UTKCXoEsDJh5MAgeuDIx5A8VziezRv5mrs3Ya9TOU3Q/WDniUeKB6+9+Kdq625+My0wRwOpHDKT6pBRo3QGggsw89P1/oJFfSPtGgakyuJoO0wzyW2mBBp7xu8jNaaqdCm0sP3stn7dU3yvzwM5pCwYu3n62dCyMdRbGTVj23ypVBfrJlrvPbgt9B/tQD4Euea8I1nrdZcZtZ38DVL840Zzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciOGcGZ37BURX/8k0A7rCT+Zcsjte+FzS7u5+nVm2lA=;
 b=Mztcw0VRmyj13OtvZNV+O8op4mH7beXTQs0j4e5WlP6pKXEfHtQ8lSYxxnpeYqlVKqd0F90zkbD2ESQIx3xWB+KE4Hay9JMeoWL4Bb36j9er8jRNM7/RtrIjuFanm6lYaJUXB5S64SweiCY7/tLeE/KYY75ZS1fLoaGk+NtFeHIol3SNL00cyt2ys/mc+8e/WBmQ3aziX5+aVkRAcZrQ+lNyaR9+6H/lg4/cwRzd1RZjU1uBJvVJi/rK/vZSGGdkZugYyOAT1MsnjMK+cRxcZNdaaAZI1ns7HatUppF0/sOe148Ko5HwHBDgBnCRLI/dgYDdhfIsOAV5jrypxspvVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10086.eurprd04.prod.outlook.com (2603:10a6:102:40d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:32:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:32:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/5] hwmon: tmp108: Add support for P3T1085
Date: Mon, 11 Nov 2024 12:31:57 -0500
Message-Id: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI4/MmcC/2WMyw6DIBQFf8XcdWl4VAFX/Y+mC8RLZVE1YIiN4
 d+LbmzS5ZycmQ0iBo8R2mqDgMlHP40FxKUCO5jxhcT3hYFTfmOMSjKLhVFVE9f1SvLGdpYilPc
 c0Pn1KD2ehQcflyl8jnBi+/rfSIxQoo0sFVU3Urj7uM5XO71hLyT+a6nT4sVqjNKamlqj608r5
 /wFbYdsG9IAAAA=
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
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731346348; l=2114;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=F2mWwmqB3xPTWDFgjnxmtdJotRfdAqd6ua694pMuTzk=;
 b=HqZbRshWjGeY00iXA1ngN1bcsmd3f8TlTr9+3EQ41XkPmZ05N0kUQLvUIBQAP5gYBYq/FHFp6
 V6XPayU5WWlCEohzW+YYP508mLAtgco+t8fPnYKadodQ0M5lUssAaKJ
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
X-MS-Office365-Filtering-Correlation-Id: 5bda78c7-730e-4299-c9f6-08dd0276d2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEtFNTIvWFhwd0tGNnVkRll5TEVqWTYzcTJNUmhMdkNFQ0VPQ2xzYndIa3Ew?=
 =?utf-8?B?QjNsazYwSW9PSDVXR1JEQW9LNC9VZDY2bVRqdUNNaVpxU1RiNGZQS1NEeTVi?=
 =?utf-8?B?cWE4UGxlU3gwekxpaUFUNFRXY2NwS2FhNEhEb2xKUkVwdFYvZzl4UVE1YVBv?=
 =?utf-8?B?dFpibnN3VDIxTWdjdFRuL0hQSW5xdjVuZzVaL1V6bVVBVlFMcmc2eFZTZFA0?=
 =?utf-8?B?VU5DK0ZMWTNYc1h1QldiZFlMZTdtbU1RbFpIUFZxa1daS1BzMFFlakRodGNp?=
 =?utf-8?B?RjVDWm54aENQYmdYZEN5SXZGRDlQQzFtMWR2M2hsWFcyYnVTSnZORllpZHNy?=
 =?utf-8?B?cndqd3Y4cFAxSThkazR1OWdxK0lkSUtqRk5xZlRhc2FPVklISU9MUC9HU21M?=
 =?utf-8?B?NlBMUjZPeThGc2xCR3lNT1NtcW0xV2t1dU54TVJ6eEF1NUM0T0dldGFJZUcy?=
 =?utf-8?B?S2hBUDloUllla2xLWDRjUWNna1dIMUVtYURvNm50Zkd0Znl4Yngzb3YraUkw?=
 =?utf-8?B?LzRyVDE1L2ZzZjdUYVU0L1RzaVg5MURhZ3VJZVczUDZDeTRpanN4UXhvczE0?=
 =?utf-8?B?cDVrUzhSY204OEIyMW9vaFhrWUV2SllBWkZ1eG9WTytwSzRnbUNacEtrT2JX?=
 =?utf-8?B?cEdhd1pLVW9OMVZmeHpkdkhOUVFQUm5ldDZESWhvVDh3N1kvNXF1MjVCZU5y?=
 =?utf-8?B?UDlHRmxjUjBheGJSblg1VVBDdGhxNE0yTnIySVNtQ203SldoODlwYVRMWVd3?=
 =?utf-8?B?aFhJWDJlLy9ybUVtbFQ4WWtFRnAvaWVVTDVvUDROWGFoci9xc3kxaGNoK21X?=
 =?utf-8?B?SXozTk0vNDBOT1l3WXBSVUtWaEJXNnRJbnFJVjNBMEZwYUxXZGxSSVRGaWJB?=
 =?utf-8?B?OFRZRGd4czBxY0o0em10cmpJYmxJSGt6ZzcxOWY3aUc2STcxbDdkQzBmSnVj?=
 =?utf-8?B?S0hPbjVPM0ZlWW1SNGx6am9TUUw2NVZsbEhuWlFKRzlkR3FnMy9LclVidUdS?=
 =?utf-8?B?aWpieXlSM0R4SzJMZS9KRVN5NWFrZ0MyNTdIdWdJcU8vRWJnNmNkRW9taUt5?=
 =?utf-8?B?aittTDBydlpaK3RFSFZSaUZEVTlzdHcvUzVTQnM2SHVUM1NPNXVjSENkc1Zv?=
 =?utf-8?B?c1ZaN2E5K2xZazNjWXNQaTEzME9qcnZaVmtqQWxhOEtDNStFR0w1TWNzZ3li?=
 =?utf-8?B?T1NkNFpHMFAxWXdVaS9BK1V4OE44OHRpOS9DQ0RGOVd1WlBpbGx6Q3JpY3FR?=
 =?utf-8?B?V3V5MERmZXJKMVU2WXpDMHhtbW94ZjRTTDVBQkdkcnV6bjd3dkJzRVZCT0lE?=
 =?utf-8?B?QmNJK1dkWW1tRnU0SG1lbGNlNGtUWlBGbEVDOGVLQzNRVUd3UUtlN2k3WG1F?=
 =?utf-8?B?TG40ODMvcElBU3pWNkdEYnJFdURNV2NlbkpIK05UVWNPd05pQTVvclZ2Ny92?=
 =?utf-8?B?SThhZHhpQ1RFVGpQS3k2WUc1aWFzR1I3RVFubFc3WktUTFdJMm55NlNCOURO?=
 =?utf-8?B?QzBkZE41SVpmbVBXdE1KUFVyYVJiMnBKMWo4MkU1WkYrNUVxSWhYeEFUNEJT?=
 =?utf-8?B?ZFRtU2VCQ0p0WGU3VDFHZGRWVWRCOC95ZTk0Qjh1WnFQRllLVkZVcEg5YndO?=
 =?utf-8?B?MVZBTDl4NnVWbmw1MnBBUkczOTE5cUIrdkdPZVczeUZaUmlEb2l2UXpENHA1?=
 =?utf-8?B?cnNxVStjSlk1QUxiLytVeVdOYm9YbGlFV2NaemQ3VW9WY0RUeSt4Yk13UHhx?=
 =?utf-8?B?aVdlbko5akVtM0oxVzFXSmxPaGtxWFoxeE81eFFDTXphTytheW91UDdsa3E4?=
 =?utf-8?B?TnpGVDJoTDJDbndwOGIvY1RTbWExdnBLRXZuNkhmeC9tbmd4cnptZCtRUjBw?=
 =?utf-8?Q?E1uQTJOpQW1hc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzdMVXJSUWQ5SmFaL29HVkNJZzVlek5CNXdUMUxETmtjYTBFUGMyTDdDdHhx?=
 =?utf-8?B?S2gxcXp4dnNEZ2EzUnh6YzNoRXhsZk9CcUhjcDJ5MzNpOVpWclc5czkxWjBz?=
 =?utf-8?B?eURSVXY5SHdQNmh1TjlIQk5LZGFtZ0ZJcko4Q0M5a1Y0SkRGSjNuN013V1Q5?=
 =?utf-8?B?VUYyMWV2cjVNekhxQk5EZkhNR21kTTIvbzVDV1RwelRhMWxidWNrUU1iekI4?=
 =?utf-8?B?ZjY4enF3VHpEM1MwM245Z0hnaGloRGk5T29UWjk4VFpmaWRwYnMxUXVxQklj?=
 =?utf-8?B?NFE2bDllN0RhMFpKbDd1aWdpTFREQnhUVmk5L1BuNEdYMUhabGJPUjhWM0Zq?=
 =?utf-8?B?Wk5adEh3d0RQTlhFTW0wWXlac0NIK1l2Ui95TVdwUjVjd0QzWm1mYUlNRy8z?=
 =?utf-8?B?UFBOVnhNYlZYbFdJdmNMZEt1M1A5U0xYcHdtWUlxa1VIUnVuZzJyRkNqa0Y2?=
 =?utf-8?B?SFh3eGZqQlZFOStSaHBQR0RYazNVQXN6T1hvcmhHRDdqWFpOQTdXQm9jTE5G?=
 =?utf-8?B?OURXekVYN2VJL21mVWpHdlM4Uk5vb3lrRTl4dzlWNEhRTnZEY25PQStndlRw?=
 =?utf-8?B?VnByaG1FL1FIVlYyMmhTS3p6RTYvWGNtQ051UFlUKzVvUnNlR0F2cGU0UXds?=
 =?utf-8?B?UlFjNE5MdEc1d3N5MnlBOEhDdkFncDkxekdBRTBYMGV4SjNHeTEwNWVKNGIx?=
 =?utf-8?B?UVU5eVFUOHJxcElFT0hIRUU2eGFQWXl5ZVZRYVBtVUQvQXQvVW5GSXo4QUYv?=
 =?utf-8?B?S0hVYVRYZ0x2YUhPdFgrZklVdWJRNFhTbklubzNPNHE4bEdvdkFMaUtGaHor?=
 =?utf-8?B?UE5xS2U3YjFaeW1WWVlzUjYrVmZ3djF5clVMaDhFUE0zQk5iaERCMXF3R3oy?=
 =?utf-8?B?aitmN29IUW9HenFzaVRseWx3Qm9wWEgxcm5Sdk4vSWlFOGRzZVFtMEJKQWl2?=
 =?utf-8?B?TVMrbS9IZWgzMVRNYlpXTkhOci9qRXZhZG03MkkrOCtGRUhBUnBoVTFFNWZT?=
 =?utf-8?B?dWtRSjYyejVqblg3dWhUcmJRZjI1WTJzSGNzZ1l0K1pIMG9HTkVpazNZdWZS?=
 =?utf-8?B?UkhrbnJUR29SaW9hQ1VrOTI5bExZVHFqdnBxdVdsOWpKay9JZmRRTkdIcWhk?=
 =?utf-8?B?bEE1OU1ldE15UVU0QUhJRVNQaklCdmxpL2ZXc3V2MHhtSFhNb3d0ZTB6d0dS?=
 =?utf-8?B?QXhVelVLOFpOckFsdCtzZU1zSUEwSlRiSDdhUnBjT1ZuN25qUlFzLy9CZ09N?=
 =?utf-8?B?WjlpUSt2eHFxZ3E3LzFWa2plOThxVWV5MW1zdWcxYTNzTFRxZmU5OUo2em5O?=
 =?utf-8?B?K0h3UnlCNk9mbU91SVJPR3YxUmsxeW1aUHpadzBMNmhYVE1aRjlBTCtHUFVW?=
 =?utf-8?B?RmNhQWdpQ2NONVgyMDVHNFczZDlCM0M1bzF2TWpyWFZ6WDFlRkNaWTU2ZCtP?=
 =?utf-8?B?L1lhZ25mQ2c0Rk0xV0VYbUdlK0xRazNkeGJIZVA5MG9zcUdWUUFpQXhHL09R?=
 =?utf-8?B?RzByNG5Za0xOWThCekdNMTR4U0p5MVN5RzhIZXR1T1o3aUYwdUpoZm1NL0o0?=
 =?utf-8?B?b0hNL2pQc1JVVXdnRWJPYUppS3hVZ0NmM2plSUtHVmU2dXZiTjRUZjlZS21E?=
 =?utf-8?B?ckgyQjdYWVBUNEl2RzRtdVMySWtmZFdrTEJHOXlyZy9jdmwySlR4a0pHbU1y?=
 =?utf-8?B?N1ZHKzMwOGJiWDFHYkhJamxHYUtSalhDc0VseVNXdVVEclNjTm1IZEhnUGdv?=
 =?utf-8?B?VkpuMVFjdFM4b2ZTdy9iVlJjNGhqd1Izc20yY3NubU0wYlVzemxUOGY0a01Z?=
 =?utf-8?B?T2pLRm9MUXlNQ2tvVWNha2VGVmRQNnVBYjBwTGZ2WGtCUmpka3lnZGNIT2hK?=
 =?utf-8?B?TTExc2RQaXdZRWhTa1BJcGdiYTlWdGJqOUVBdmJ4UVBLMGg1VHdPT3BYSmJZ?=
 =?utf-8?B?QlU5VkplK2h2UW5PN2h0MjdLRmZ4VEtWRzkraGhHTlZhVzNyVGVEdnRXWGEx?=
 =?utf-8?B?bUhzNjRMcVZUMElxejh2NU9FT05ycUJCaHgraWJoOGFmY1pNcFoveklWaHlC?=
 =?utf-8?B?SkJMME5ZUWw4V2dKTzBGOGRyOTlYbWdrQmwyNmJ1Mk00QXBjeGtRbStmM0Ry?=
 =?utf-8?Q?RN/w/z6Jqvafeztq7UMCUKG86?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bda78c7-730e-4299-c9f6-08dd0276d2dd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:32:33.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKGl7EvS8AcaAyBUQ3UPXc+2Dzz6hR+lGVbty5S5Kg4f1fYMD8WWa8GkfwRecPnl9EYEAXd5xLOAcJ5FbfUG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10086

Add basic function support for P3T1085 temperature sensor.
- reuse tmp108 driver
- Update imx93-9x9-qsb.dts

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Jean Delvare <jdelvare@suse.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>

Changes in v3:
- Change cover letter subject
- Split compatible string change to a new patch
- Remove i3c/master.h
- Update document about p3t1085
- Link to v2: https://lore.kernel.org/r/20241108-p3t1085-v2-0-6a8990a59efd@nxp.com

Changes in v2:
- Amost rewrite and reuse existed TMP108 driver
- Link to v1: https://lore.kernel.org/r/20241107-p3t1085-v1-0-9a76cb85673f@nxp.com

---
Frank Li (5):
      dt-bindings: hwmon: ti,tmp108: Add nxp,p3t1085 compatible string
      hwmon: tmp108: Add NXP p3t1085 support
      hwmon: tmp108: Add helper function tmp108_common_probe() to prepare I3C support
      hwmon: tmp108: Add support for I3C device
      arm64: dts: imx93-9x9-qsb: add temp-sensor nxp,p3t1085

 .../devicetree/bindings/hwmon/ti,tmp108.yaml       |  8 ++-
 Documentation/hwmon/tmp108.rst                     |  8 +++
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts    |  5 ++
 drivers/hwmon/Kconfig                              |  3 +-
 drivers/hwmon/tmp108.c                             | 71 ++++++++++++++++------
 5 files changed, 74 insertions(+), 21 deletions(-)
---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20241107-p3t1085-fbd8726cbc0e

Best regards,
---
Frank Li <Frank.Li@nxp.com>


