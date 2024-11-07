Return-Path: <linux-iio+bounces-12011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AB79C1231
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 00:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53AB8B22B2F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D021832A;
	Thu,  7 Nov 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e/AG9f/l"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522C322E;
	Thu,  7 Nov 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020599; cv=fail; b=cY+XdqwyMAkkxtFugTF6XKvYDIIeNBaCgVH/c5tWQI7GBCAJujZXtEVrspVD2rJoRtipnHrlWjGdS80exwTveK5Cl/M+VbDwTn63GB8hgxx90CkxZqIOulG5DWTh5eB+6Thk8j+ifx0rJMPWR220h3rDJqjLcB3NfUDwcygM0Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020599; c=relaxed/simple;
	bh=ugUf7LXDuQ1++QqLWN64clcLePqHZHxg5norw9ccZSs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=R7a65XDGmr4v1EMs3Dj7fuzVQYGx1agj2enQpEHn4EBpgCzGNKr1iwWVNxLFIwSdW4JGltzTmUakQ1R29eLENvO4K+sk054AwvkiKrVwqtmZ79lsSAwQQQcWf27KBEvugOIop253DXXUD7nghqxjtuTl6COfnIEbubbUaIp6x+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e/AG9f/l; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np0ujMAvoISQ3Sv0/1LqQ7Th1+jkk01oiwmj0Aslax0nkL6O7B0o8WIFBczaKxwCF+yfClAejQfDptU2LCaY8ZtCFVQXEdBPB5lIEcwHTIyucBFarisfMokEe9s8Ry55FZuZXuGoD9sq2yhs09hyVEui0UujM9O9LLuu9Vj3osvAT0WiWfaQqHJYj3Hb1+HOY+SRmUlrUYr+4iG85IIOvIoDlBNH3+OniMkW/QXwT+mHD3xlvgdv6TwHyhKmEwXksNN4c2KVdqgxW1TRhc5Oy6TZ/XfzvYGUC0OqNkTZHJ+8olxYLTsLc2CJwpkhdi0d4sxOPElFkecNuWJCfUPP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k7ybGQWeQbkRAnZeryM7CGSkMB1SjtatAYTn6jx0kc=;
 b=Geuoc3eXM7zQz1QF18hUgJQf/qnyCDY7t5VqAxTA630lBeWXmNNnE9Eayr1X3p3Xm+lPERYA61Wc7c+W5SqjvV1vk74tbTof0068pa3skUg9H5fUCj7zlX3yX0LlxPRx6UGPD5QIQ1ymSi+RBEZdy9MMfcI+hSrqNjCEOtc5+9OC4RCPCH5Hd7jjR3GSa+GSJAi0VTsNTu2xDkKbFT+EQBnQQm3pZ/2wMRadlR9QhXkIGYxt2p7TZnDjoD2jz1uebQodkkHvfIMTg5XBygwFrIwp1HH+0yTOo1rP7zHJDRmGPWIYE954NaNCmc0/pckVBKy2z1IyM1NU8awL56pe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k7ybGQWeQbkRAnZeryM7CGSkMB1SjtatAYTn6jx0kc=;
 b=e/AG9f/l1WAHwkArV/+SpmXwrrs+CcUAHkZWmTfn4LKtmBvntSxb3m4ZdHACCLzOT54b2Q2u8bkUPf6qGFL6X6WBct1AgVeOcwL6sbpKe3al3Uq4mYCeYPepJ8kjzszamMX8AkrNBJgnEoTsavDBDFPVxvpswQ4i1fgeuQLYvEHsKdXHH9CRkwZifk9CHwomQwbtGWIkOGxHSb79u7c6JSMbSLePIMMb01FqWZ9m6peeYnUxW5kDhYnzQtaXT7f5Hc17/HfnXzgUl17QmIgpdVuR4npE3PzBGHIKHt0tSCafmj5QWijz4Sr0lme+y7ENAw3AknHtgN+U37dJYLNimw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 23:03:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 23:03:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] iio: temperature: Add support for P3T1085
Date: Thu, 07 Nov 2024 18:02:26 -0500
Message-Id: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJHLWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwNz3QLjEkMDC1PdtKQUC3Mjs+SkZINUJaDqgqLUtMwKsEnRsbW1APa
 zWK5ZAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731020589; l=1300;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ugUf7LXDuQ1++QqLWN64clcLePqHZHxg5norw9ccZSs=;
 b=bYpj+uWdoW3IuzuwJttEWoaqpm2Ho7rs8LYBlY4Hp5C1SvEiOw7F87OIHzqnN0hDRk2DgIS4O
 Nzvnb14xv8lDwJ/Dtcq8Ywv90q8TV1UU/vMIP8xOCNUsF38Pcsd3JN3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 295368e6-7026-4d5a-94b6-08dcff805bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUVjdEM2dEdETnFKWEhzNUpRNUlGR3RPQzQ4NzFlUitZNjF3NGZxOVlHeGVi?=
 =?utf-8?B?TitGQng1dkwyT3lnL2FJd2lkOEZaQS9lVzZ6SmlDMzZqQVAycE1nVmplRFQw?=
 =?utf-8?B?UFpKZEpNallVMVYxSXE4Y0hnVFplb3lQUU5EcmROSzRJQjZYNEVDUWZ1aWxT?=
 =?utf-8?B?a0hMVDlwZzU3b3laTWFQV1FOd0ZSMXRRRHNNc0crdDB1dXAvVEZoZjZzbEdB?=
 =?utf-8?B?RVppMURXVUsyM1cwN0hyTENOYVp0cVV4UTZnWXlXTHBhOGpKem55SGxFNzBn?=
 =?utf-8?B?MGdsa2FsSVpTTmdBY09jQU9CbURQR3VWZXlTMUpsM0Z1ZG5sZzc2Z216TUtq?=
 =?utf-8?B?U2FzeWNMb01WNFNIanZjU3N6SUcwVFJvYVpRcWZZQXJLMTF6YTZPTVBYQjRN?=
 =?utf-8?B?SjNZU0hJYUpTcTg2MUxBZkVuVmZzYjNFK1FoWFlFVXhwWU84S2lJSS9PVlps?=
 =?utf-8?B?Q25PbDdLNXZ5UUJXZ04rSHlIcnFHRHk4bHVZYkNtTmlkcWk1aTZtVFVydXFY?=
 =?utf-8?B?UE5xdkRKQ3diZU4vTlBBZm1nZHVvbkZ4b3UxU0lCRHRtWXdPbkZPQWR5aFAw?=
 =?utf-8?B?NzhySkhsankxUVFoWjM3Z1V5SWNMdXB2UmlLbXZ1WDRkTUVMQnJOMnhhV3dY?=
 =?utf-8?B?b0pESHYvTDZQZHExZzlKV0RFL0U4TFVoYjJyZ2ZJVGxFN1lxMWRhck02cllu?=
 =?utf-8?B?SmtiMFIyNkw1SUdJQXJVNFVpY0RCNCtVRnRlSHI4M0c5Tm4wcFpoMXZyb2Nw?=
 =?utf-8?B?am8zZ2dYQVd2eEp2cTR4TnZjTnBUSC9VeUQ4QUttL0xNbzJZK1pGSDIyVnlI?=
 =?utf-8?B?bCtFOVdjNGZwV3RkRkVuNDVTWEpWb2lVSGM0U3crSUdtdUQvcjY1YlBKZUJs?=
 =?utf-8?B?WDlOMFhXeEkwLzVFak1Wb2lWVVJiWm9Jci80L1QxUG5UL3BRZ3JrNkl3Zy8w?=
 =?utf-8?B?TFZXVnNSaEZpVks0WDAvdFNKL2swUWxLb3hjK0hsaG1MektCNGtnYjduK3hm?=
 =?utf-8?B?a3YvclBrdGVLTUg1UVFScUZNTlI1cytmMDBnY2ZIcGx2Z1hNc0o5T1ovY1lX?=
 =?utf-8?B?RElDazVjbzlOdlJDRjJOU0VkM0hwanMxWXVpZlBWTXl6VU5GbnV2TElhY00r?=
 =?utf-8?B?ZVUrS2FERkk3ZGZyWnRQSFQxRk05Tk1GU2xqZkNRWWh3Smp0N0JZS01lM2Jz?=
 =?utf-8?B?SUZlK2Y2SlZSbzg2cVp5QTg5V3BDRGlzckp2cFJySDFsUVpmSzBESmFXNDB5?=
 =?utf-8?B?L3MyVlpLRytwMXhVb2JaSzhBTDZQYURIL3FBTUVMVExPL2kybytOTXk2NzZ2?=
 =?utf-8?B?SFFzblMrWkFIT1A3dGwwaVM2V01SRVQ1dCtRSGpkSmd5Q0pLQyt0RWNrVjFX?=
 =?utf-8?B?aDYvbUJldVdkU1NkUVdvdTBiMUFjMzRBQ0dBMUJ5S25yRkwxS3ZSY0oySytR?=
 =?utf-8?B?QTROR0J0bzNWTlU5S3YyWG1tNzlQSncvYS8yTUd6L24vWHllNXZHbldKZWZQ?=
 =?utf-8?B?TWViRFg1aWxEcGQ0Y0pKOTl2SFFYMDZ6cXJvL0xZQ3pLMzhXakg3OEFwSGRG?=
 =?utf-8?B?WHhobHk0Qk5VYmlQb0g5elkzQlJ1ZW16TjlZK0hUWTRtSXpFWS9aK0MyWDdj?=
 =?utf-8?B?TVloMFJKZFhVdmVtRTJJc1BXSy9hMnBFSEZSNEl0MXVOZ3ljV2NpMnByRmVl?=
 =?utf-8?B?SWZMbEhKQ2VMbmhtL2czamYvTm9RRXVRbHNJR25OYk9nRERwTUw0SUN2QjFl?=
 =?utf-8?B?Vzk0T0hvVEwrbjNQTVpKUEFCZDUvREJUUHpRMnFSc1RhZW43TjdESCtUcHZF?=
 =?utf-8?Q?Seo0z6NVB456WlxjYanVNh6AxLWgomIL6iSm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlZSQ1J1MWg2RUtiWXdXWkp5VEhtaGRwcXdNVUhXOUI3RWJ4eVNOaEZMZnpZ?=
 =?utf-8?B?dEs0ejBSWTFKVG81MXM4bm15ZVRoNFZreXBJMnpQcVR4eloxVWVGVXZraElI?=
 =?utf-8?B?anRmV2dtMmVRN3hYNnlDMnBFNy9CYitwazFVTHFxNC9LcVhFQ011YWdobjRj?=
 =?utf-8?B?RXJ1ek00ZW04VHhvWmdZOS80UUd4V3VIL2g2bGNYaCtzR0JHVUdSeVZ1TDlK?=
 =?utf-8?B?S01FRHUrUDFBR2xwVDBmVDhtMUJhVmt0SnAxNXZZQWF5QTBVVUdYdU95MXFF?=
 =?utf-8?B?cW0zMHhocGw5aTBLMUJwcG9pRG84NlM3SnluZmNhY1NvY090NzJWUGcvSE5S?=
 =?utf-8?B?Yk9ncUg4MStKS2NvYjRxZTMybk5HNisvMVg4T0VuNUwvWlVIRDZhVWZTT2c4?=
 =?utf-8?B?Q09Ka29WbFZoZXo5Rm5GY1d1Um4yd1NwUjJYUmR2c1NRcVdQNE9YNFVvTXRQ?=
 =?utf-8?B?cEFkV1EvVmx1YnE1OEFLT1ArQStVZzhCRkNBTDFoNkRMU3ZjcVlEekk4ejVm?=
 =?utf-8?B?MW11MG80cUxkbXpzSXFvZWhpNkdRdU1uVkZra0pseUQ4amo4NlJSNEhXN3FP?=
 =?utf-8?B?TWZ2WkNhZ3R0d3FkN0wrd21Sa2JWNy9mbGl3dVlaVEZuQk5MUHRVaVdOZWQ1?=
 =?utf-8?B?NXpmZXJoRlpDUWJQb3dPZ2tyaGRNZ3Y1ajFBVDVnaVZCWTkzNDFlVC80a3VB?=
 =?utf-8?B?UGQxVzVMQkFKRUNGNmVCYU9vclF0Njljd3FQbktCZTlVaU1oa3hYTVdBY3hM?=
 =?utf-8?B?d1RvN3lvNHFiMmh1bU95azRjQjV6WFVETTgreTJJY0YwQTliNmY4THJBd3lR?=
 =?utf-8?B?L2ZjUURqclNXYm9lNVdSTU9XcSs4VFB5N3JSb2Z4MmlqaTlvdDNXNTYxcDdI?=
 =?utf-8?B?TFFiMmxEQm5HendOU0tOSFRsVmVndFdGOUNhSXdhWkdBZkVoeFRENHNZdVNN?=
 =?utf-8?B?UDZQSGtWVFVQRlpqaFV2VUtITUNVNDcxME10Z3VUNVRxVEJxSW1lQm1WakFw?=
 =?utf-8?B?ZTlLQ0xoZlpnenRLa2kzZFVOUUJmanpuaGYzS2p6d1hFYnA3eE0zSGVFK3pD?=
 =?utf-8?B?VWhmSi9lTFRHZlZtL3RZemorbktJR3pFdjBqZXhrTys0bm1Wb2RiaHNCQUlY?=
 =?utf-8?B?bFRnK0dQVmZDazdCeEkrbzBvN0EyaWZ5YnR3dE9kaWtZWXA4YmFCWkpVb2Na?=
 =?utf-8?B?WW0yaE9rb05tUjEzcmtzaUt2YUZwUC9DbnNYYmdzdGNMTGVpelNTQ3hUN0dk?=
 =?utf-8?B?SmhPbXBkS1JFMjVFemNxYTl2R0N4TEl6Y2dHaFNqNHd5OTNyVTF3ZkovYWh0?=
 =?utf-8?B?V2dKelpuSUR5WUhxWDF2Y1Q3cjBHZ2s0QjBnN1BkajViT1oyWklHZkVIajE5?=
 =?utf-8?B?NDFDc1pxcWl3azkvSHJmRjA2VFp6aXhGcTJ4RjNhK1RZeTVnVzZkSWJSeThl?=
 =?utf-8?B?V3dMS0E5OFpqemtKeTVxVG16WGhJS1pkVXNzS0NhSW9VNGtyK3dqS3VRdmJn?=
 =?utf-8?B?NmloUmV2OHJSNHN0azQxTHNROU5xQjR2L05UMDFXY1RYV0FoNEJJSXVwS25C?=
 =?utf-8?B?N3lKU2RNSi9PMzhXcU9KU1BIY1dOVXNVQkZieGNScCtYRXQxZ2c0NDJzaytL?=
 =?utf-8?B?WDN0eDBpN2s1bG9rQWJ6bEd4SXRobi9xU1VNUGNZWVBobmNLSkRneXprdENK?=
 =?utf-8?B?QUZ0cG5KS2hoTyt6T3pSZ25WNmtHS1pFSElyZy9mSno4MU56SzVsejFZWjk0?=
 =?utf-8?B?eXAwaWZDcVU5dXNMeUpMaW9pbXNnSWpjQzRVQnBkOEZyYWNrRUZJTWMrRFB1?=
 =?utf-8?B?eFJyMjRBY1Q2MkI0QkRSV0xaVWUzVFdwb2FzdURaTmxHUENkK1B0WU51Z1pD?=
 =?utf-8?B?eHFUVGhRWFdzNzhETmgyZnV0eXpHZ3FGQzViVVR2NFhGTG9ZbGxDbkJUc2hW?=
 =?utf-8?B?ZGxWYllScm5yR2FQOXkrazNrd3AyN1pMczdnZDZkZ251ZHJpS29LSzdkY3hQ?=
 =?utf-8?B?QnB1bGs0L2g5SzR3WDFlNEJna3hsdVFvZ1V2MTcrS1J3UjZVZ3V4cWpPeFBj?=
 =?utf-8?B?Y2ZCNklreTM0b1E3MTdnRktjenVwejRxQ1RzUWJ2V09ZYUJIN2RCSGVQVHVz?=
 =?utf-8?Q?ZwI3ULM+a9RE9jqGg6vSPF84D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295368e6-7026-4d5a-94b6-08dcff805bba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 23:03:14.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud1+7sd0Xd3b/HzDcyV3O9nZofGlxdWV8l9u57AFC+Tn6Q44TR7u5V7VOWoNYt6ZosHhSHsT6+6tpQphSGFMcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

Add basic function support for P3T1085 temperature sensor.
- Add binding doc trivial.yaml
- Add basic read temperature driver
- Update imx93-9x9-qsb.dts

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Carlos Song (1):
      iio: temperature: Add support for P3T1085

Frank Li (2):
      dt-bindings: trivial-devices: Add NXP P3T1085UK I3C/I2C temperature sensor
      arm64: dts: imx93-9x9-qsb: add temp-sensor nxp,p3t1085

 .../devicetree/bindings/trivial-devices.yaml       |  2 +
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts    |  5 ++
 drivers/iio/temperature/Kconfig                    |  1 +
 drivers/iio/temperature/Makefile                   |  2 +
 drivers/iio/temperature/p3t/Kconfig                | 29 ++++++++
 drivers/iio/temperature/p3t/Makefile               |  5 ++
 drivers/iio/temperature/p3t/p3t1085.h              | 31 +++++++++
 drivers/iio/temperature/p3t/p3t1085_core.c         | 79 ++++++++++++++++++++++
 drivers/iio/temperature/p3t/p3t1085_i2c.c          | 68 +++++++++++++++++++
 drivers/iio/temperature/p3t/p3t1085_i3c.c          | 59 ++++++++++++++++
 10 files changed, 281 insertions(+)
---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20241107-p3t1085-fbd8726cbc0e

Best regards,
---
Frank Li <Frank.Li@nxp.com>


