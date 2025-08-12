Return-Path: <linux-iio+bounces-22612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22DB2204E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8934916AF09
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7F2E283B;
	Tue, 12 Aug 2025 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hMhrUry+"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201A2E2820;
	Tue, 12 Aug 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985949; cv=fail; b=b99j5Sg3W7PEL8TA4xJs36wv7qohXdxbtq+enzb8n9jJ41f5Dg0THFXDpLWst23AdPOgIS2bY79aY7B+yrIhJnaPGWpoewpZYLGHYHjVWZCIVY6OFiTTPifmfIUawYgDB1EymwqBXH8OD2DfK1NaHfAsBcKo4onyW8j2G1euJJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985949; c=relaxed/simple;
	bh=BuYplVtqwSF4/83X8IuH8y3VzFoZctiAVrDGj6armCQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fZWWydhUz51v5hwjS6sWs5rBsdcaAEHE4qyTz9lWLN+BkAyrwMXVeNI/0UVZ9nuQo6FgHf2q8JHl4l8x5a58jFBhNtmw3UKdsNXX3gH2afh026ge3Spdgd6JHsNIlD/Unu9GcBaaVzjq9vhxUwzZpi4R3+wUzCMVOmGHJQ5wkXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hMhrUry+; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWaE/kjJLoBIoFZ2kgWCppn+42kbftsW10MfOyKmqUt+BTZZv1xIn+9BRRrO6lcgCln+3LjPw9tdl8U9u8lAJ3EmpcmFeeaErkLuRamuVS6C6MmBjlOOwJV5kexvxjqrxw5F+RUiSe+Uz/c+p9MIku3vvtzriJYlRFOPaO2L7ljuWjXdDzAnr3y5xVl4YDchoo65/8DwxDKVPICfRuc2gYGzk+cTKQDzLlzUkBH92tLkbfxwuzCPfJ/e1X+2IR3nT8HV6PuBsMZR3JZ5yMoiEzw6yE82LMVOwKwAPvUssxGxd6tF3h+rJPLq/X+j1b2bgv6zpBNPEGLS7utG5nL9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmKR8JpPWfv4WaNwQVhdrBic5IcFl/bs6GFja7W2eT4=;
 b=WsXTkAXS4ya2WA3Bxzt8BYvWTuoCU1DZgMdk1NjXCkTjZV5ESP8wGOCqC0aakoiBTEbkfRVCmQw6hVWbl6sy6dHyqiGTcrYC62D0WsVenZmxtL4MuwJUkZUCWsz2Qw4Qc97W1WJ/C3+RTyppHEQtRcUCRo7YT06DMFY6iZ+zHW66vWHr8hHQvp8tK+68Luj0HHURGxuRB47FZ2YKE9mICQEbnOYm4otfPp0dDsXo6pi0gBfRRzODnde7yliko0PdRNAYN/bhSDmc9oQo3mdz8E5+TY3r/QPsF1KyJdJ9SfdMy4TcU0mDuDK4meCiYWdAMluye6P6i/An/4Z2K/VonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmKR8JpPWfv4WaNwQVhdrBic5IcFl/bs6GFja7W2eT4=;
 b=hMhrUry+nw/wlK/gaEtr2JvJPId1B25V4ujNM26mu5UvRvNLRnGzKKpMc5QcfOP4BPHnRiGVvTjgnzIfduuT5duDeZABVYXl1F3cHZViA8JORIj7XO1FRkEXlHJyxs8EuUQl1JC0q0elNHrgDA24R+NlpOpIL1UYWQ70pPapdvNXAZLjo7Oici0T+xbJCOsoa3sqDvzUNml1aQ+st5q5A2W5gQabn6fC84YTWg2I8ZAiW7IN/GbqVfz9rHSJykGtUT2d/EWUyok8yJ5foYr/A2L4dabvoqcj2KbdWNLoIikA1A09aPpyCZZcFtovXMWMKC9fD1L35TKOA7uOD5YJrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7984.eurprd04.prod.outlook.com (2603:10a6:102:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 08:05:44 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 08:05:44 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 12 Aug 2025 16:04:23 +0800
Subject: [PATCH v2 2/2] iio: adc: imx93_adc: load calibrated values even
 calibration failed
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-adc-v2-2-0260833f13b8@nxp.com>
References: <20250812-adc-v2-0-0260833f13b8@nxp.com>
In-Reply-To: <20250812-adc-v2-0-0260833f13b8@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, primoz.fiser@norik.com
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754985925; l=2548;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=BuYplVtqwSF4/83X8IuH8y3VzFoZctiAVrDGj6armCQ=;
 b=SZm9LdkxIH5kkeabHttNkMZ0wGgT4s0T188Ss3Ag5Qrd394NZoteJ9neN8YNgB6DsHz/9zIlh
 DjqNjpjoel2BHI9sDFEon9PSU98SL/aXisDV+nrSeA0NC6pGzhYUQp3
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA4PR04MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: ada7a0e3-17e2-4047-7222-08ddd977097f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHdwOENDb3U3ZTVaVUNEMkkvb1VBbGhvdklyOGtDWlBUbEluU0tTZmxjQis1?=
 =?utf-8?B?MFpXTTk1V1FTYzJ2RmxrUzBtTEFNWU5WRHFSYU9WVU9MTVhGVzVGUk11WHhM?=
 =?utf-8?B?UEE4cnZialJZRFYxTkNIYkxVYVlNeXlrZ2xLVmV3S014eTBlYnhGYk5JQWQ5?=
 =?utf-8?B?OFQySlkyNVk2T2VoUS9iY2dFT1lVazU0c0pYaG55TjZwZytQK0MrWVByMzRK?=
 =?utf-8?B?bUQxdEZqL0gxc1JITDhpUy83WlVEamtUemt6Yk8rLzB0cVoyTEJBTFlYdlpQ?=
 =?utf-8?B?MEMvbXprcXZkVHphNmE3SlVLQUp3TVduaUcvWENCWHNBWFlWU0ZMaXJaMktu?=
 =?utf-8?B?TkFTYjNLZVlRQXUydFRIekFyZmpqUlMxazZ0cDBYdDIwZmlkUThBODFIMXVh?=
 =?utf-8?B?eUZyeHAvK2ZGSGtxVVNxSXErQ0E4bjhhbkhCdlRTNkppSi9jY2pJZTRvajhq?=
 =?utf-8?B?TDJuMG51bndGL2ZDYU1GbjJSekY2RTdMM3k3a2FDdnNkVm5uTjFZeWJqUWRv?=
 =?utf-8?B?cTduL3Mwa3R5cEV0MFBYaUdiRzNqYlJCbGpJNW5xU1c5NHgzYTJxdldDb0wy?=
 =?utf-8?B?Vlk0aHVudjF0TElZUnVEU05kL1dKdjA2RDB2MmVodjlWdjZLQ1BUQlNCb2t2?=
 =?utf-8?B?TzJHTXJ0bSthQmpCME9nSnd3QUx4MzFONU5LMXBUT1E3RnFFOHlGblQrTTZs?=
 =?utf-8?B?K2pjQVlrMFpoZ0xJYWpYb0xxZWNhV3lkclVFQ1V3WWFCdlB1eGZhMkp4RnJn?=
 =?utf-8?B?Y0U1Y2dac3NyWGxkcmFCVm10REoxUnNUYWlKOEx1UjFYVkpydGowb3ZwWUNr?=
 =?utf-8?B?RTYvYjdoVnc2MmI2RHN3T21zQ1lUZU1mQlBPbjlOeGliOGVtbFhlMnBPenA4?=
 =?utf-8?B?bWhacDc3d2JxcVZBazFDTDlEenQvNkI4RkFYY3NwcDJXdzNjTW15MkRkSS83?=
 =?utf-8?B?dUxFd0RwYjlZa3lzU3pNcEVsNVFGb3BhMmRmWHlaQmJXNDY4Slp1QWdwL010?=
 =?utf-8?B?QkYwVzZ1c3FWaG5tTzk5dG4xM2YzUjcyZVZpM0JmR2EwQTYyRjNPZThnRlMv?=
 =?utf-8?B?aGRBaUhPNlFIWHFKaytCb0hTTTlLcVZIQ3BZRy9RWjl1WEd2Q1FkbHNtS0pj?=
 =?utf-8?B?aG43WDgvWFcxMU5DOXdjY0NKRE1abDc4djN0T1VGc3NQekxHV3UyN0JnRStz?=
 =?utf-8?B?SnlYeEMyYTQwcklEMktTTUtaeDJvWkx5cFlmd0xaNGRCVmorZnBGTzRVc3hF?=
 =?utf-8?B?Uzk4TnFicU1TMVlQV24xTWJIc3FId0o1N2ZqaG0xSFcyYUNrZTNEMXEwa1dp?=
 =?utf-8?B?RTI0ZDkveUl0ZjFOLzZpWE5lYlp1SUs3ZlYrMGtHaXNkODZmanRsRGF3WjBo?=
 =?utf-8?B?RWJIRUVnRy9jU2RabUx6SjdxUDc5ckRsdWdqc3QyZlYxWW5OM3Y3WDlMcU9C?=
 =?utf-8?B?QUs2TUNEYjMyUkQ4Q0p4eTNYenlwSDNHTkpDVlo5eVoyOHY0bklaMTRiZWww?=
 =?utf-8?B?cnZOYUEzdVRoRmFxRzU1N0hiMmRkbnBIUjVDOXlPWDM3aUpsWlkxMi9GamRV?=
 =?utf-8?B?YUZIS1NzVVhXYnp4NmpESTJhbkRQS3Vsd29jQzgzNEh6SXFjWkFBY3EvMlBV?=
 =?utf-8?B?ZzRlbXA0bHh6bzZKTE91dFhIbWh2OVNXMWlLWUlEcVZETW40VUVCV3IvTnhz?=
 =?utf-8?B?VHhpYmswL3Z1NzIxaHpQd1JZRmpVVGk1KzY1endBM3lHUlkvRkdOeUdhS0g0?=
 =?utf-8?B?SFh1OEF4UjR5aVdYSjVCaUpmRWVLTjZva0doVTMwdi84MHVaRjA0bGxTR2Fn?=
 =?utf-8?B?b2ZGTEc1WVJxRGhpcXRqZ1lpTW1nM2R6aC9CSUo1cy82dm8xRkprRngyT2o4?=
 =?utf-8?B?REdWWnMzdzVtSXpaM1FxLzRVMU1oc2FseXlDaGtwMm5NM0pTOHRhTTRIMEYv?=
 =?utf-8?B?NHFQTXJpeVVUVWRGc3B6UVU1QkQyaHhWMkg3d0liMFFwb0E5L2tJTjk1RHZr?=
 =?utf-8?B?UjFxTTBubHlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZGcW1HbVljbGdvLzNTd0Y5dDY3YjlYa1l0ODR5ajVUaUNwazNuL2t6aXNK?=
 =?utf-8?B?L1BmVjNjMzhMVHlha3Y2UjlDaGlweHVoOHdLNEZZNmhuM0JWTGNLMmR0cG9r?=
 =?utf-8?B?cTdZWExjZ0tHdEhoZ0M3enBQcVZFTERZbks3OXQxSXJFRGdYWm9TQVV0S3Nv?=
 =?utf-8?B?THN6UmZzSXVxNXI0dklDbkttV28zM3BkL2ZVUWE4R2hvWWx2MkRZNU5uUE4z?=
 =?utf-8?B?SWY5Q3F0MWVNY1FreWNmSW1yeWkxNnNqZlllTjRyaHlEL3duZGRxQWNTQ1pC?=
 =?utf-8?B?Zk9GOEk2dUJpZTQyMkd2WTdzYnFUVmpsS3RYUmRUVlRMNDJzbmVZSHRDVDRB?=
 =?utf-8?B?LzFBdVpwbnNsU1JHM0VVZitobHNDL2g5UWZWL1NvYzJPWXVNQTVmdlFya3RY?=
 =?utf-8?B?RTA5aFppMXgyeWhhbU5ndTBxUDU0STVCcWt4dU53OWVwSkx3NlRUZm1tRGlm?=
 =?utf-8?B?bjdwbmJVTllmWWVOWitMK1hCeHVxaXQza3RpcThPazk0cUpmSURxcXVxSVgv?=
 =?utf-8?B?QStlOXFsZzVsdXJSak90alFLSnF4VjBpUjR3dEF1dWErQ2E1Q1RuQjBxNERo?=
 =?utf-8?B?S09GdmE5RE1KKzdicHAyeG91Y0Y4R0RWcVdDVlBhN3dvMmdRc2NqYVhLM0dZ?=
 =?utf-8?B?NW9MN0UrUFJIREJTQ0p4Mm05Szl2aURlWjJGNWtBNy9TQTZvdzhWb284aXBM?=
 =?utf-8?B?QmUvalhJblNFVTJxWUlDdVlwSGZJRVBYUlhiK1NLL0svNWN2bnV2T1dCMHRJ?=
 =?utf-8?B?L0FOVVNBSkVmaXlMcGlyV3RRRWx2SUc2SDluWEhhUGFaTzN3VlNKKzdzekFj?=
 =?utf-8?B?QVJDQkZwVUk0YnhRQ0FwbUlsamUzeC9QbjU1SFNKYksvbFVxK3krT3h4WXc3?=
 =?utf-8?B?MFVuTElqSmh5bHJOTWJGVzNmUzcwY0lKRHJGQTFMZHRCODZLQ053d3ZDUHh3?=
 =?utf-8?B?dmRnSm5Ic0hUUGQxQ253YlhhMUdpNkcwb3pGK0l2cHY5SmlKb2tXbFFjRnhB?=
 =?utf-8?B?d0Q2dW1pbXMrc3Y3ZVgzb3NJenVPbDJZZ21ZSkRQRXFZR29mcGxvbFpqaXg0?=
 =?utf-8?B?YmpPbnBpUGs3d0FoeklzQ1c2ZlF1b1l1TjViRjZZUXlEcTZUWG5jN1FVV3dS?=
 =?utf-8?B?eFlJZ29RVGJVSHZ1MXYvaVlnYUJ6eWhGSWQxdDc4aG5oQlFkTXFBK2tRNVZH?=
 =?utf-8?B?SnhmaEdYMUtrajFhbS9mcGN6S1kvMXpjcHpydm40NnNNQUtMaTFBQW05SXp2?=
 =?utf-8?B?c0I4dWt5S3ZpUlZTbE5zYWo0OGd1T2hLMXNXNktzYjFOckFvb0lMbUJ6KzFw?=
 =?utf-8?B?REtuT0l1bVpKQ2VZNFpOd1pjREVTbEVCdVlHb3ZvbzhYMFh2VGJrUyt6cC9z?=
 =?utf-8?B?QWpDQWhpdGxhY3IxbTYyVTIwaXFXUnBseXA4eHJKRjRwSDM2M0wvSVM0c2dx?=
 =?utf-8?B?V1l0QVV1WlRucjdkaUJ0VGNqdzlwRS81bnNrRXVoVHFyL0ZTam9NZmJybFhP?=
 =?utf-8?B?aW5qa25vZ0pCWTYxcU9kMmwrdFhLdlRjSFk4eW5ua3RVYTd5RXk5UFRZTjJY?=
 =?utf-8?B?TnpaSFp3dEtjcExWODk1b3JoNk9VRHhqb2Z6OWpSaVZyU3Q3VG44REdvRlZr?=
 =?utf-8?B?NlBkaW5Hazdnb1NDM1Jzd1Q5VVFIaXdFNWVEQzZ0eTVIZWxOeFJpOHZ0SitK?=
 =?utf-8?B?ZCt0bEYzVzFjVWhjWkpNcHRVQytlTHI3eEZraVM5Mm1wanE4OEpKaHpWU0ht?=
 =?utf-8?B?L0xyK2dBMzNXbDJYTFY0MmhSVU9RZHhjOGJNRWpxc3JpY3Vza1ZETS9WeGc5?=
 =?utf-8?B?SEpzaXN4TzYydFFLWk9qUUdhaDIzMmthZjVLbWpTUU5NUndhYlZBYWJEZ1lM?=
 =?utf-8?B?eUpQRWxaUEg5b0szeUhJWlRsUTcvSXVSOC9RZ1FGcWtOUVBLcTFqb2UwQVFi?=
 =?utf-8?B?eG53WUt3NlhmaGZHN21XZE9ZVGdJUEg5Z0J5bTFXNXovMVphVFFld0pNUHNJ?=
 =?utf-8?B?dUFwTnczK2NBOFdyckIzRkRzWjNvMThDc1NJM0tMOC9zYWxkSUlkVnRpd1hS?=
 =?utf-8?B?RHhuZkpITTI1VXh5UTNzZFJQTDlZZ2EwUW5jQVpiT1ErcEw5aFUwWW8wR2FP?=
 =?utf-8?Q?pJ5tjqYnkpxUum03YzoXo/Tl9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada7a0e3-17e2-4047-7222-08ddd977097f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:05:44.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3VtX6YBWRFltTFWljhVu7vdUuEljEgPZhSkiU2VKQe9A29oTXI8ugEtBIY0w2Yn6FKCV9tYqup6ON/Grp3WJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7984

ADC calibration might fail because of the noise on reference voltage.
To avoid calibration fail, need to meet the following requirement:
    ADC reference voltage Noise < 1.8V * 1/2^ENOB

For the case which the ADC reference voltage on board do not meet
the requirement, still load the calibrated values, so ADC can also
work but maybe not that accurate.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/adc/imx93_adc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 8471737ac04a2bac0417a6397f20865f6a2c01ca..17b0a2548b0a3614ac537b01e28bc3144d17d6fc 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -38,6 +38,7 @@
 #define IMX93_ADC_PCDR6		0x118
 #define IMX93_ADC_PCDR7		0x11C
 #define IMX93_ADC_CALSTAT	0x39C
+#define IMX93_ADC_CALCFG0	0x3A0
 
 /* ADC bit shift */
 #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
@@ -58,6 +59,8 @@
 #define IMX93_ADC_IMR_ECH_MASK			BIT(0)
 #define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
 
+#define IMX93_ADC_CALCFG0_LDFAIL_MASK		BIT(4)
+
 /* ADC status */
 #define IMX93_ADC_MSR_ADCSTATUS_IDLE			0
 #define IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN		1
@@ -145,7 +148,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
 
 static int imx93_adc_calibration(struct imx93_adc *adc)
 {
-	u32 mcr, msr;
+	u32 mcr, msr, calcfg;
 	int ret;
 
 	/* make sure ADC in power down mode */
@@ -158,6 +161,11 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
 
 	imx93_adc_power_up(adc);
 
+	/* Enable loading of calibrated values even in fail condition */
+	calcfg = readl(adc->regs + IMX93_ADC_CALCFG0);
+	calcfg |= IMX93_ADC_CALCFG0_LDFAIL_MASK;
+	writel(calcfg, adc->regs + IMX93_ADC_CALCFG0);
+
 	/*
 	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
 	 * can add the setting of these bit if need in future.
@@ -180,9 +188,13 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
 	/* check whether calbration is success or not */
 	msr = readl(adc->regs + IMX93_ADC_MSR);
 	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
+		/*
+		 * Only give warning here, this means the noise of the
+		 * reference voltage do not meet the requirement:
+		 *     ADC reference voltage Noise < 1.8V * 1/2^ENOB
+		 * And the resault of ADC is not that accurate.
+		 */
 		dev_warn(adc->dev, "ADC calibration failed!\n");
-		imx93_adc_power_down(adc);
-		return -EAGAIN;
 	}
 
 	return 0;

-- 
2.34.1


