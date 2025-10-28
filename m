Return-Path: <linux-iio+bounces-25585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA85C15453
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B626558268F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11E3314CB;
	Tue, 28 Oct 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ggy0r32A"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9662FF679;
	Tue, 28 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662964; cv=fail; b=og7GasTifMekHq3vsqgT+2umQFI1umKn/Kjre830/BrJbTMVqyC8+fXVg067dXeeU3oqp8mzmMpJEsqyxPHB+fJ1lrvgwEOb9+SDQTPpwAkUgZGHxP4KihOHP5SepXaR0m7dVwDxesXSjyfV3TQxUWE7rT25AwUp/6PBmv2idG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662964; c=relaxed/simple;
	bh=puWuZ7nueMsmt7t7Il/yMFRFqRrx46I19P4Iko9qxq4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uFn3BsqnMZORCgF+a01drA0KGFlJh3dIPm6gdMfrPs3qh0u79cip1lyqhLTevX8ed1Bc/w+s6/ZIMdBlYZRFRfS9Tv0M86Bexx2KWNQb6rmUc1hmDf4+GiqjjR4j/G0/INtORPZcHSSsbkKbxTS71KhMnBvBjFTq0SAXJu0LDfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ggy0r32A; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KanSV1Tdbk1vrRElw0epNhSVRV0oYJdqbEyzjQZNWYvFpmdtnYXxl+SuM0yPLMEDhLnBnphGoLfpOl5hxfIrRRtbE8M6vZb9MPfUGqEG/kTWfOpE+pH1vEX1Wl6Mix7iWLASkWl/u496EGmsm6OpNxHoXotVwLZwWXIg2sCoUAHT7abqM+KLzYt4SR4uRovf/2FJWO3iqwXqg09KFpjVByf3+02h3BMIm7w2EJj7CGfQS0Mt++pZmBlliR7apLath/oTePorUX5HctwyJLJDKGUqQ3gJ9NvpcqKq/LkwRvuBCbWIhQjcdRPjxrT12CGAPL64m43rYeW7lD5hJntCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvKbtTb/Q5BXynuGwoSh4a9r7ynLvFjAKjDRDZBmE3U=;
 b=UeaRZHF1mUxYWzdcKC95TEsopybTXdrGsE4tdLry41wDLVwaZoiUU5FhFRC+Zgy0VzeQWFNTaV0gNHsAfR2u5jMEpidV/p/VZ9wT/mhqPLSIZHhxD466Q9TP6ZQeDIynbDrPp1piAyGyO9+ypvfc4zjZKge7wFwamyI0o150E+CO9wxzKOIlg59zwdUWXhJLoojyKU08lRRCqB91jL40OOUlFy9cj8UkRPGCLp6rydhdQ7UKu8sWXvVE+ppMR6bOzG43H/TElF+79924ODsqbD3yamWzBN+eM0Lf/5Ycgz+7BePn69Z+ezcbIqywIC7mcrSpnPkqKzB0mzpCtiMN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvKbtTb/Q5BXynuGwoSh4a9r7ynLvFjAKjDRDZBmE3U=;
 b=Ggy0r32Ah3VZb8R9dxDZTh17QGWvqHl2fosfV0+EVmFOsfQ6l9rd4sRUVVK1fjK9RhlUFNnrJ5ijwhKafYSaMxskZ2JvgX5FIcwhpNRggll8i4WuJP8WSDe0QEbw7kC5Dgu/Fs7NEVWj9n60iBQuG3bRBrUKt2ih11bDbNOU1y63aPBe9gMPLln1LHmdDDeSJbLDYaZySD4qFi/UA/7W8ChKIeTEHnZXCteEJHgS8i78K7LLH+8CAZbcuQRMJogG9mDn/x0w135Ypq2zujva0Gke9JaSrY55ZovNHoNwokyMMPvAZrFigF8OnkhKaDliVmuYyjis3+rEUxiInySlyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:49:19 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:49:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:48:57 -0400
Subject: [PATCH v8 1/6] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-i3c_ddr-v8-1-795ded2db8c2@nxp.com>
References: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
In-Reply-To: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761662950; l=10560;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=puWuZ7nueMsmt7t7Il/yMFRFqRrx46I19P4Iko9qxq4=;
 b=aHkCf5yGyjfImoA0v3arZozviRmu9BAQKE7eDDIImE5dWrMUlKGMdJxUcXUm9tOAUq1FucyxW
 yS2lx6c8yggA1UBjzGSJncWpsxQ0+v1ORouz8O+h5O1+NuQmULTPnme
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f75b6d-da72-4391-c137-08de16312c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUllSjJzZ2o1cFY3UzRWYXp5M3hpam1LckoyREgwaUhwVHAvR3NZZVhtNExj?=
 =?utf-8?B?RjBKcERPRTdUOUxueTVSRysyaTk0czR5UEtJWnEvYks4TzF2U1R0M1pGTy9U?=
 =?utf-8?B?dk85YzViSEdVd1NpVDMwWDdFeFFnNE9CbWI1a2xGUkY2N09OSkxwWnNueDlj?=
 =?utf-8?B?RkUvUldHamxhL3U5cWdCN0FaMVNVMmVKSGF3N0pFOGxDWEdTeldJamwxOVRT?=
 =?utf-8?B?MGd4ZUdZYUV2QndnMC9nODBlWURGamxPZ2s2S2dSNGl0Yk1ZaTlSNnZjbmto?=
 =?utf-8?B?amIzVmlhRjVaSGRzaXMxZGQzaVhKdWVCTG9PWFBub0p1UkZEeVl5RkRhL2Fr?=
 =?utf-8?B?aVNMbmZzNm5aZmJwYWNGeUswTW41T2dzcGNkT3luT0dsL3gyc2trMVFsRjhh?=
 =?utf-8?B?alFWQ2ZLenlnL1hHV1FpenRqSXZhNHRmQVhCQUY3M0pwanpWWVg5TmtJd3RR?=
 =?utf-8?B?M2xEUERaMERUZTJZL29vYXpqSms0NE9qLzNRVGU5cVlJSk0ybjBxQjdmRWRn?=
 =?utf-8?B?MEVweitnQlNsZUZtOGZkN1lmbFh5S2xlcThnRm90ZEM2RndlN2dwSUNTMUtQ?=
 =?utf-8?B?eU5ZYTM3NWg3QzJxQ0l4cHlGa21vb1ppdGVTQmlGM0hnaUc4UXVOM05Fb0Y3?=
 =?utf-8?B?REhubG01U2N3bXF4WVBFeTZvbW10ejFWVEI4akFaZ2xjZ2tFYlc0ekM1UHdW?=
 =?utf-8?B?VzFrTU9aK0x3Y2hjbTVDVXROS1B6NFhDbkRuQW1OMXRmbmFMWXY5TkdvZVhs?=
 =?utf-8?B?QlA4cENldjduN1NRUkxmLzBOZXY2aGhLbE40MGJ5WkVqL1VpaWVXY0V6bitz?=
 =?utf-8?B?MStJWmFMQVhCekQ5cW5idmFuR2F6c3ZuY3dNT3dSUEtUaU5oRjV1VXhidDNL?=
 =?utf-8?B?ZnRmN2R4TlVCT1pweW1MZDM3dzF4SkJpc2kvU292a3pYbVhRYVVqSDJhZU1R?=
 =?utf-8?B?OFUwS1F5cUdpeHo0b00zeFEwUXhYeGRiekxja3cxVG14Z0dzb2xWMHZTQnlY?=
 =?utf-8?B?RmpSSjdrRjhOcGd2cHg2cXE4d2RhWW5ZZ3FpU0lzTHgvbktLckpFNTdEdTJL?=
 =?utf-8?B?WWhPY0psUC9jd0cyTzVGb2RWWnlhNXFQaDJwVUFCT0tFVjU0cWlsYk5Nc2dU?=
 =?utf-8?B?MWxQdXYydFgyYTJtWE1nd1JxMzFISUlkbklpaTZDcCtwTDliTUU1U09ma3Iz?=
 =?utf-8?B?aWJ2NmJlTUN3TTFJTm1hN1lmNzZJUUh3bXNBWmswbEVhMzkrQTZneVRSOUVz?=
 =?utf-8?B?SmQyUC9jZkYzUXVWUS9qTEpBbGFhcFdzWXAxS091U1MzRHI0dnhTKzVkZm8y?=
 =?utf-8?B?NGw1RUZRb0Z1T2czTDJuenh2OHlKT0JuTnhYSUR2NS8xZVdWRFJ0dDhCc1cr?=
 =?utf-8?B?bUlidGJ2UVVnM3huNVlQOEV2Q1MrSnJ2N0VmQnZCL2tOTk5sSTZxUFVDKzhz?=
 =?utf-8?B?a3k3L0FnVXVaMGpWQ0hMVnNsQ3JIOHEwZnBaVkxNZGJ0VDZwb2F4VlY5ckFD?=
 =?utf-8?B?ZEFTNDhoYkZobVBudThyUXFIajAyOU85VWY2c1pSakJmbVU0ZFpDZ0xMbDV4?=
 =?utf-8?B?V29mV0xIZmJHTmVab0FjQzlIRTVCTXdad1F0enV3MUlNcU9WWTZHV2h0NmZY?=
 =?utf-8?B?Q1ZCRjNSL3JMdDJXbFNncmJkUjgxRWlNOXNaQnBjUnBxVjcvVjQwZ2V4NWhj?=
 =?utf-8?B?ZXVsODk4S1VWREhLODB3T3BSZjc3cHNsMDdRM3p3UC9uc2FQVUdRS004OTVh?=
 =?utf-8?B?MzU2a2x2YjJTajV0eW5xdTZPb3hGUnBBOS84R2F4K3VrOHd1SFp0MVZoYVQr?=
 =?utf-8?B?R3lYSmh1M0lmc2N6TkV4amFuU3pLM1JuU1Q1MkZGZ0x0TEtCbHlwSzU3ZVcx?=
 =?utf-8?B?Nm1hRXM3Q2FYQmxxNmk0Rk05OVFGaGlDWEVuV1ROc2pqTHUrMXo1YXpwWVl1?=
 =?utf-8?B?MlJZbzZ2UUJpZjhqNXoydGNueGVCa3FSNmllV0VsdGxOaHNWMTNEeXplcEtp?=
 =?utf-8?B?WWJKdjFkZW1OcUJtSUUySXM3UUc3NnVrKytFLzRsVGxoUktaaWNGMndnRXRl?=
 =?utf-8?Q?DwinBU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzB5Q3FZcTdrT2FoSU9xNm0vV1JLcEx6aXNYWmNCNXREaXRZKy84VFFBWGF2?=
 =?utf-8?B?b0R6VzF3dVVkQThDQVI1SXA2Ly90bVArdU90YUhyRC8rSjF2bUVqbFZmUGJi?=
 =?utf-8?B?NTFIeDJha3F0dlZzZXk0azBuZWJmdUZ4NWp0anVYVmZVVnQzaWlwdHRMS2x4?=
 =?utf-8?B?Ykx0RUpaMXdkdHQ1bE1VYnZ5N3lncUZLamlzZTJJdnV5aW5PdHUvbzlZTC9x?=
 =?utf-8?B?c2Q5RWdTSXYvY2RJN3cxTGYzS2hLVUI4WGtZSEtzUWNKT0NTVWQwekFhVEk2?=
 =?utf-8?B?dHRMOG40Qnlsbk9WR2gwL2tCa2pWZkVJd0tsR2hMcTUyeHZtS0FxZk9hSUt6?=
 =?utf-8?B?OTdxa0JJUkx0UTdTUS8wbDhDLzBZancyaGlOVE1kMUdwVFFwbXVnN3FQWCtu?=
 =?utf-8?B?NXdRclJqbDBSK1pmNnJ1MHk5R2o1VzRBV2ptYlNmNmlRSkJUWjhsQnBUNWVW?=
 =?utf-8?B?WlZOYXNPbTNmdUlBUWR0RUwyK2pHTmxBRExOdVdhOHZHem12YkJ0VTNKelFO?=
 =?utf-8?B?c01oTGxnb1FVbzZuVWR5TkU5THRUVUtENDV5UW9tUVdzdHRhSzNXOEV6eXU0?=
 =?utf-8?B?bm1QcjNneWtKaVFsbHJIdnB0eU9VVFV5TGFSL052alpJeHhJMy84VHdCbUdD?=
 =?utf-8?B?VGNWUzNTSWU5Y1RGSmc2c3JZYlpJc25iVmxDeVV0alNhLzVrMCtJOTZ3UFl4?=
 =?utf-8?B?N0h3K3p1bEJjQ2RPL0J2UzRaSFlGVHllK2lETVFhNGtGMnlXbkZ1RGdpaHl0?=
 =?utf-8?B?RTN0M3djaXJkejlSald1b2pCS1N1LzBXc2c1R2V6azVIeGxFV2VCVVhVVmgx?=
 =?utf-8?B?aHQ3T3dzZmtNM3F4UUFwUTBRcldzSjNNdGlFZDBIYXYxRDB0VWVzVmIwK05W?=
 =?utf-8?B?NUw5aDVqVHd4d05rTXNCNjc1T3dwRWJ5TGpLNjMvOHhRNzFaeWdEVVNOcVV1?=
 =?utf-8?B?aDRGeDVEWTQ1bjB4OE5SeWpqVW9EdEZtQkJxaFc1K3AzQ2twcmNJQ01CRERp?=
 =?utf-8?B?dDhrRUpHdzY2aEM1SHd6K0JHMTdWeXpVei9rWFJqWTh1MURqa0xpMlZ0SHhH?=
 =?utf-8?B?SHpaYzFxNFBRK3h6eFBSSGdFb1BPTWRJMkNJajBzRmdic1hldWYrdWxtSlRV?=
 =?utf-8?B?VmpwYnZYcWg2R0ZpbnNLcklzTmQ0MkZOaHBiZ2wvM2dkUit6Y2Via3R2U1g4?=
 =?utf-8?B?SnlqWEF2OEdONldSNStrNHhxeWZjdnR6Y1hqU1ZnaDhDb3NRK3E2OHByV0xr?=
 =?utf-8?B?cDV2YnZEZG9LMkI5QkFlNW9hTUNuMjFNMjNJNTNYNGFWMlRzR2VKanVGZHV3?=
 =?utf-8?B?cjZXSkJGR0ZnRFVJaEhUN1lDK1pKUW1BOVg5czNhczBDZFU5eW5IejVxY0x4?=
 =?utf-8?B?eXJUTXdSQnlTWS94bkxXVkxlL29Jb0c2V2ZCcVFZK1IxVlROOGErUWg4cXQx?=
 =?utf-8?B?Yk5IckVxUU85Rzhzc0R1YmJCamk5d2VoZUY3amRpTG5HREdldjhEcW5qOERD?=
 =?utf-8?B?aGRaOVJnaHFvMkJQa0QxdzFGamFHSE1qQlV3dERhUnF4UGJENHZPYkV1Y2pk?=
 =?utf-8?B?VnBVSjU5ZlV0dDMxRWwvZi9EdVFZZEdMMnlrMi9la0dCdFMzdW5sYmRBQ240?=
 =?utf-8?B?aDlTQ1hUN2F3ZFA3VTVobFFvMUtwbDIvbEhpN0ZIVUlYRGlYN0h6RW1GaWlt?=
 =?utf-8?B?MGdRenVxR0hkekpxYllXUUtSNHF4ajRXbUFRbmJNUWw1RTlpdmJLaFlqREZq?=
 =?utf-8?B?T3RCRWIraDBZM29vSWk3SkJZaFM2M3h2TTI4SjVKRmxyYTVxVVNnRFhYb1Rj?=
 =?utf-8?B?dDBGa3VOQUw5QUJVOHd5Tjdkdm9sTDM5a1lkRE9nSi9OK3RSNWR5YWpZNTVh?=
 =?utf-8?B?cm5JeTNXcTIvd1VUQlhwSlA1b2tFcWx2UDNkSVl5b3RJenhoUkp3OUs1cGpm?=
 =?utf-8?B?d1l5Z05qV3ZaNERlVnRaYmFCNUpNT1BadGx0SHVoQmpBaUpXbEdQY1FCcTFq?=
 =?utf-8?B?eVNBQnVYSmN6RVFwVm9yTm5mbFlrWm9lM1hwa3lUeUtvYXRFalZlVjFEQkVF?=
 =?utf-8?B?TldFZ2hkZ0NtR3Y1YlZtUklTVHVzZmVCTy9WMmUvS1I0Q0NGVjZaOW4xOEhu?=
 =?utf-8?Q?Vu+P9+Xy5TQ/fWCbti/HH4FEg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f75b6d-da72-4391-c137-08de16312c7f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:49:19.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGgt26Fkz0gl5ECp30Arf2TzcvzSEBMMtoLKEN50Wr100Gu79E4tr+/DDzgudVvj3rNCS7JQOxnJ6A4W+VJoSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

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

change in v8
- new API use i3c_xfer instead of i3c_priv_xfer.

change in v7
- explicit set enum I3C_HDR_* to value, which spec required.
- add comments about check priv_xfers and i3c_xfers

change in v5-v6
- none

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
 drivers/i3c/master.c       | 20 ++++++++++++++++----
 include/linux/i3c/device.h | 40 +++++++++++++++++++++++++++++-----------
 include/linux/i3c/master.h |  4 ++++
 5 files changed, 72 insertions(+), 25 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 2396545763ff853097d9f0173787e087f7a6e688..8a156f5ad6929402eb92b152d2e80754dd5a2387 100644
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
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
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
index 79ceaa5f5afd6f8772db114472cfad99d4dd4341..f609e5098137c1b00db1830a176bb44c2802eb6f 100644
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
index 66513a27e6e776d251203b286bcaecb9d8fc67b9..16a480865ff4a28857f1ea6df33dbe4a66d1468c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2821,10 +2821,14 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	/* Must provide one of priv_xfers (SDR only) or i3c_xfers (all modes) */
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -3014,9 +3018,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -3027,9 +3030,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
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
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..7f7738041f3809e538816e94f90b99e58eb806f9 100644
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
-	I3C_HDR_DDR,
-	I3C_HDR_TSP,
-	I3C_HDR_TSL,
+enum i3c_xfer_mode {
+	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
+	I3C_HDR_DDR = 0,
+	I3C_HDR_TSP = 1,
+	I3C_HDR_TSL = 2,
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
index c52a82dd79a63436c1de6a01c11df9e295c1660e..51c6654ac0f8209fd9b0e386f34a0add9fa87d15 100644
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
+			 struct i3c_xfer *xfers,
+			 int nxfers, enum i3c_xfer_mode mode);
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,

-- 
2.34.1


