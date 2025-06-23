Return-Path: <linux-iio+bounces-20913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EDAE43B3
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 15:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6EA3BF603
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731DF253B52;
	Mon, 23 Jun 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="BlphiPHL"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022089.outbound.protection.outlook.com [52.101.71.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5B25394B;
	Mon, 23 Jun 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685272; cv=fail; b=mJuACmeZWuZxOdufkcgVh+vurVkKIhZwCGxKvCKWwzFs6wNgII9io2xBjiyqMr1UaS/N/ha2XyNdnGFmPu6ju6MKK0Mqz/Y/XqH8M0vsPc2PpeIa09nOa6gVI0xyXu/Ngd/R7p9ddvaOlSw24czbMzsLb+Uyw0H0FCxBGD12GMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685272; c=relaxed/simple;
	bh=bl5h09Io0yqCr+bekHoP1eTDVi451S9lD/wPzGa4+yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ikUAEt9tce2ertLA1WUyVMEw2VDx0NQ0GBlhDGGc5ZNibr+9BRrvlx6eWEaStbBO1/GMoU+To504AKzBaS+JT5h6bOm2BNJlGCY5OFpLUU/NKTyGGb1jC2G+vHy8v91kRWDTrCVITLKtuKn0XgbOy04e+Ja1rLQgcICgrvNtFuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=BlphiPHL; arc=fail smtp.client-ip=52.101.71.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seICpVVxfcI9YQPoG+LkeIHz+9UR3qPEhjAR2qrDCjKDS86OhUbZL7NYwzdNeU0ssOuYkAZfSy7hX+LTuWID8Ful2qqErSP+rgVRXchn8fm0d5N9u6DjBR5EdZhRBNpgvlx1/UjaJXF0/0A9MDoFn5l9njvWvWlPG3qIR8IKKdRxqP70aT49bycWAjQc/KrWc6Fl9QGUH/qRio01tvdEaiLtzBnW0r28JWMRRy3bHMXH0w1FQrvzpsNzKSOXyrmZE1xJkAytQWwY8X94Q9zVfv2MQcpK1p99FskGn7iG2a9SNtae8hjVcLbm5zC43GGmmUSfeu5cZ2gGKWTgy19/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC+gwqz5KmhURuu8TfmmMlIWeIAl6jEQgU6P5c4YdlA=;
 b=VeFdaLhTySBbg2eI+DyEcm1xacCILTjelaAH751I7SbALAij8Q0GWyZvkcYTUtykoS+mqb2fQoRgCTuMBJVs5KaK5wsOTT2FNYZ3Cda2H6w2QyDI1AlpTPhzV/dOE1WULeP04os/SOY8c9MxZKILWVHDMP4/l79hynJgmQIzo1sWAz3HRkVoP2r8+JicBc4EY1rQeyZ372RCsCL7iO0ILiSSJ9qRjyd8PHEcFF/MnQv6+c3JCdq/wwKuDPK/JuQYSL2cknuE25tSneLKmNXtSUf+ylv3hIvpwLx4NfsZf+FuzSoRLXVJXNeIK5JYbfmZrW2Z5ghTJnvGBQLHFei4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC+gwqz5KmhURuu8TfmmMlIWeIAl6jEQgU6P5c4YdlA=;
 b=BlphiPHLS/VSrBacRUtcmcBU46PIce9z47mlrgmuCN/neFHWjXjXloVjhzUTQ3oHFytP7Q+gzsW5KfvREtPDoCmfH4D3BNaJhfkXGKx7IRzII0OXNI8at5cYK8MYC3dHvqMcVVL31TcA3c73PhkdBdzL7nvcyls1aCn0TnQnM9cWkqNf/b7GiVzNtKdlf+KWwWd8y5GOzNdUOfIa5dohIxHTZkUHO36Zw0bnMFtg2WxJx7Z4/4HhFNOtvuyStUnvw2U+9+X994hbEqnMOpyAUWGg0znTV7rrGTbTeyWJ1MVHlmubGsa/aoXiwOQTnOwq5JMtmEK9doBdOPdHvoMfSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 13:27:45 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 13:27:45 +0000
Message-ID: <5fc05140-76cd-4f19-bbfe-e27e90f21983@gocontroll.com>
Date: Mon, 23 Jun 2025 15:27:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iio: common: st_sensors: Fix use of uninitialize
 device structs
To: Jonathan Cameron <jic23@kernel.org>,
 Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Christian Heusel <christian@heusel.eu>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250527-st_iio_fix-v4-1-12d89801c761@gocontroll.com>
 <20250531180319.21365159@jic23-huawei>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <20250531180319.21365159@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|AM9PR04MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bfdfa6-8bcf-450f-8576-08ddb259bd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUs5Mk9TazZqeDBwODNOZHVUc3BQZldjaWJsSEhsaDRZTytEYk9MaWhHNmVk?=
 =?utf-8?B?NEJMNUVySjVkWnErZTEyRllTT2x3SFZuZHhYQWhoNDlHSFlFRkpOWTYxNmNK?=
 =?utf-8?B?Q2xYUWhSTmQzWnBZU2Y1VEsrOWRzelVNckxQMWw5Q09rVDMrbDdma0M5bldh?=
 =?utf-8?B?ZExvV2xmWUVKTGluK3c1bGdJeGdGR2lEUnJyS0RHcURqRUd1aVBXMDhtTGQw?=
 =?utf-8?B?WnhjdFRGOXc0ZTUxcGpxajRpZGZBWkphU0JPZGNQVVdpdWU3dG9tV1B4OUs0?=
 =?utf-8?B?R2FxcFpBWWcvZFhaWTJXbkp2ZCswdUlVMGRSdEcrZGxSaDFlNUMzUGdsS200?=
 =?utf-8?B?UjVPNWd1TFJZZWFIZUI1dTFZVUlCR3FIYkV1K096N3JraXBJQ05EaU96NllS?=
 =?utf-8?B?dHlUWjVKUUJMUzI0TGZoeFc4akFrT1pmc2FLTUhKMWpjNmlTWHZiaTVvRE9C?=
 =?utf-8?B?bHE0RU9pWWl1ZVJ3ays3TDE2OWtubW9HUWF4dDhkSmhWL0FkYXY4NlhybC9u?=
 =?utf-8?B?ZVNPWDEyUWtmQk5reG95ZTlaYm9Ra2M5L21pMUoxNU5iS0dxZDhzemNvTUdy?=
 =?utf-8?B?eWNWSzFpUWRmcDZWa2ZaZ1M0MlpUV3h6WUlUbWg4VncyRi92N3JWQzRGS0dK?=
 =?utf-8?B?amlETGRFaEJxSHN5Q3Rvb1ZIb3pUdHJTYjZ2MUgxQWIwWlhxNUZqcnpweGVu?=
 =?utf-8?B?bUZXYldLTnJXb1ExMFAzSWgvUEhoQ3k3RUVCcTg2Y2NZN3JxTWJQWm01M21o?=
 =?utf-8?B?RFZjZEFWakZha1B2bkd1SGtGK0Q0bGk4YUNobktOUmkyR29KSU81ZTl4MHdz?=
 =?utf-8?B?TDFsVkYyV2NGTGtkTzU1N2Y4QVRQZkVEZm5uMjFld2k3QUgxUXdVRkozclBO?=
 =?utf-8?B?bzlCcnZLcWJZRTRQZVJjNy9sL3k3dEtzdjFBcDVxUmp2ZkxLamw2R3FEdzdI?=
 =?utf-8?B?cVlWOGV1MEVCbWZzSU1QSVd0K0hRbGpIN1JmblJWY25QN2pSNElOVm9JU1M0?=
 =?utf-8?B?UFIraXhjcG5zZDJNeHpiOHdsREVRQm11SkRoSnhJSkZ4OFNUQWpTZ28xL1RT?=
 =?utf-8?B?WjErWGl1UW1icHhIUTFDMWFHcGpIUTY3RTd4bExDQ1RIUVBKR2IzZlJmalhn?=
 =?utf-8?B?M3JVcW14SzNVQlFxaVRKdXVoZ1RMUEVmN05CeU1UNHh3K3R5anF0MXJXWVRB?=
 =?utf-8?B?aEN0bGdmUnNjOEc5Q0Iwa0tpRXB0NTVVWEMxTGJ4dFZCT2pScmNqdnpuMVR5?=
 =?utf-8?B?Zk9MRCsybnRIbHhVSVI0NS9hVDdsaUZuMHVNV09DWFJtMGhrdGpHeDRnL2xG?=
 =?utf-8?B?NVBuVmxWdmhPaVJtNFNSTGtMMHN1dVUxSlltNFN5dzlEYVF0RWxwK2pZTWc4?=
 =?utf-8?B?WnRvbFBnL1dvOHNqTVlTMngzdllUdDI5ZitHeEFTeFlwYjJ6SzZTM2JjWmh5?=
 =?utf-8?B?UXVrTWxFRWZXT2pOWjZtUXJBYmlxWFFXcGhTM1lrV1o2S2NDMkVsVjAycXp2?=
 =?utf-8?B?U2VFSUlzNVAvbjFTOXg2V3FJYXliM2FXNnVVNzRmSng1YTlsUDFMZjZER3Uy?=
 =?utf-8?B?NERsK2NzclV1Y1plSmh2QU1VMVZkZlE2MmJJM0ZXSXQxWEpROWEzRGh1VHR4?=
 =?utf-8?B?Ym8yaUFKcUZ6Z1dxeGNUdGZFa2FTVGVIb1FSLzVuaHlaVnliODRXRGJud2pa?=
 =?utf-8?B?KzUrUksram1WQlpCUFl3d2lHaXVsR0ZaN2VBdk9kdUZmTUt0T3VMMUUzS3Js?=
 =?utf-8?B?MDRtTFBVUi9uenhtMC9zVmdSUitMQlR5Zmg0VDJESkhXU0ZEVTNSd1AzNjlr?=
 =?utf-8?Q?rCZc+u0jctOe9e1JLrX3oOUEoJGEypTzla1i0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nnduakt3OWZLczB5ZUY0OThtdzJncmtIczRLM1pXTWtuMzE2amYvbUg1L0Jy?=
 =?utf-8?B?cDNlQTBYdDR2aGlmVlRIdkNiaVpkQTJ6aVNNV0sxSXk3OGFIUkxyN2tpSVJH?=
 =?utf-8?B?cTJrbURiWHNXdldsMGNyOWVNY0pMcDBkbFd4UWY4cDJHRmcyUy9odFgrMC9m?=
 =?utf-8?B?REZyb0RBWWUrbUNzWE5RSTVMOWpESVpsU0c4Y3ZNVVZWQjdLdFRSNFRSdFhk?=
 =?utf-8?B?dzNFWTZKNzY5QTdtV2N4WXlNZXJreDBVUnh6TDVHY292M1lvTUNaeWNGaHVN?=
 =?utf-8?B?TWxDbEljczFwUWxNeGdocG45UzNSQmd0RDBoYTFhYnNWbkNwd0d5SmlxSG0w?=
 =?utf-8?B?L21Ubm9LWmVEdG12OGQrWWRuYTJmaUx3QmtkSlBFVlBvbW5WaSt4eHVZWWl5?=
 =?utf-8?B?WjBZdk44My9CZStEcFYvbkdWazNrcWpLMVdKaGlUV2RDNmtiUFFVaUlFRDlC?=
 =?utf-8?B?bGlQTjk5ZkxLeURNUmZneXQ2aXFDdnB6OUV3ajdraGthZFVBYXpNa3lIU1Ft?=
 =?utf-8?B?Umk5K0lONkRsSTNFd0VYWUNYTXg5YVNucXM1WDNuME1wOGIydkM4Z1hrTGpp?=
 =?utf-8?B?TWJzT09PaUFHbFp1SXgrcWczd09WWjZtZWpHK3F3b1prU1Fwd0pnWWh5MDZI?=
 =?utf-8?B?ZlBZaC9JSnNOczdESVlGcFpmRjNzUlhsdms2M0FLRUxBcDFoYmNzRkpURmgv?=
 =?utf-8?B?bEg3WVU3MjFHd2pOQmEwTnJPd21sdlNjN29ZOW1Qa1FnVVJTeVdaL0RvUTgy?=
 =?utf-8?B?czFhVzF2K1BGdXdNVEVvQTg1RlR5S0phdjMrZCthL3lDZE9xVTFIY2FJbkhw?=
 =?utf-8?B?TWxYV1NDeHRKSTd4UFA2TTRvZTZzazRIZFdBaElUa0xlUldWWnMvMGhnQS9M?=
 =?utf-8?B?c0hHM2M4ZGc1Sk9BaC9qZ1h3QldlWHlkZmh3S1ZhZC94MndhbHNydkxNY3Z3?=
 =?utf-8?B?ZG5VZHRhSEtDbHpEQjhKU24zYkFmR0tST0xvNHdMY0EzdVJvV1ZhVGFkNDlI?=
 =?utf-8?B?WlJ1NFRqTkh5S0paam5ncXJueWhZd0s2MlNqbXJrUC9HNmZvYkFzcytGZzMx?=
 =?utf-8?B?aWg4Y0JDV3FsQ0JvSzh1ZE9NMmN1bFpBNm9Jd1JkTVIzendocEJMVngzZExC?=
 =?utf-8?B?RGNIV09zdTIzMmxQM3pJRURyVnJvSHl3dXExaytzQ0Z0dlgzczQ0eXdjTWdF?=
 =?utf-8?B?NnI0TVkzenp6eUYrU1BzVWR1VWRGOG93OFFydVNweVdlS2MrR0NqWENSM0x0?=
 =?utf-8?B?elg0Y25UcEEyNGlwNUd6RmF3RFVVRml3K1I4STR5RGo5VE13RjArdC94ZUs5?=
 =?utf-8?B?VnR0dE03V2krbW9pYm9ZWjZ1eFQ3YzhTU2pKOFAvd1pUeGFod2dDb3hXdkNv?=
 =?utf-8?B?WG5BMmRKcjNZYThJdkJGZllhVThqYitSQmk2OE5DZ3dLZVhQNnlkV3ZYNXFz?=
 =?utf-8?B?RnNjeHFrUkhVNkhBNTZvSTVCZWQ1OGtOWXBzUi8xWG8yTmNPR1FGaWVrNDlz?=
 =?utf-8?B?NzZnSDBVN0VUNHBKNXYxTXFrNjFiamxLTzFoQlJSQkR0VzlxR01MRVcyVlVZ?=
 =?utf-8?B?VHNOWHI1K0pQV0x3dGpKWE9DcWJxVnVKRm5zQmhPWDdTSFVFOXRLL2djVkFn?=
 =?utf-8?B?ZTBDTUM4c1ptNkFCdEhtMVg4bjNCN2loZ3A5Z1lMZGlOSzRSQ0doVlIxNFEy?=
 =?utf-8?B?WitKQ1U5YTZlNTZZVlM0N0FlSkRmZmh5dC9rVjJMVXJwOUVyOXJ2V2FWTmV3?=
 =?utf-8?B?MTZUTGtmYUtWSzlVOS83UEdkSXgweE53QWMzUmp1dW12MVNnZDJ4NWFvYUla?=
 =?utf-8?B?Rzl5K3ltQmpLVWg5MFFDZG9LeU1pbEYzQUpxNC9oNEFuNDRDQ0xzVVFOa2JN?=
 =?utf-8?B?eEJWTFVxSlNXMkFQbTJINmUzTG8zNWkwSDBRZXU1WEZHSUZ4Ukg0ejBISWto?=
 =?utf-8?B?eE9IMjg0bDBJaXhVNWJnTnBmMmhjUEViOVJqc0F6cFNhdE51RGpHNDhDS3ZL?=
 =?utf-8?B?aFJ2TS83UDU3VG5yYnpQa1VqMTlwdTBVV1dxZWg1NlhPeFk0RFRjR0g1WWNu?=
 =?utf-8?B?TDFENituYmlITUJYS0hxRDhpd2picFNHWllTSFRmZmNFNFlqZUVxak5ZRGR3?=
 =?utf-8?B?S3JlbStlNWIzZWwxWS9xNDlIS0VJRE1XUmt2VHgzZ3loLzNtb1VRTldrdXZZ?=
 =?utf-8?B?cnJxbjRqaGladlh4WFlGOTlYdzFFL2VXdVQyZUxvRXVRY1NTK05tNy9QRHB3?=
 =?utf-8?B?alovdW1FVHRJMmtzY1l1MHpsaytRPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bfdfa6-8bcf-450f-8576-08ddb259bd0d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 13:27:45.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3MTygcBvrZ94Leg68br/tvBDOLXhcukVuGgYpUTfY2O6M7zhOWzBzBotCzME45DjQ1eU6Ehd2zPe3Iz4sHBmBaVq43vvkZZ1gOSF+75gvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8472

On 5/31/25 19:03, Jonathan Cameron wrote:
> On Tue, 27 May 2025 08:36:08 +0200
> Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org> wrote:
> 
>> From: Maud Spierings <maudspierings@gocontroll.com>
>>
>> Throughout the various probe functions &indio_dev->dev is used before it
>> is initialized. This caused a kernel panic in st_sensors_power_enable()
>> when the call to devm_regulator_bulk_get_enable() fails and then calls
>> dev_err_probe() with the uninitialized device.
>>
>> This seems to only cause a panic with dev_err_probe(), dev_err(),
>> dev_warn() and dev_info() don't seem to cause a panic, but are fixed
>> as well.
>>
>> The issue is reported and traced here: [1]
>>
>> Link: https://lore.kernel.org/all/AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM/ [1]
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
>> ---
>> When I search for general &indio_dev->dev usage, I see quite a lot more
>> hits, but I am not sure if there are issues with those too.
> 
> For probe error messages I'd like to see them all moved over to the parent
> device but more generally it may make sense to use indio_dev->dev
> 
> As per the earlier discussion I still wonder if we should harden
> device_set_deferred_reason() against this condition just as a
> defense in depth thing.
> 
> Anyhow, this is a good change in any case. Applied to the fixes-togreg-for-6.16 branch
> that I'll rebase on rc1 once available.

Hi, I've not seen this patch pass by in the stable tree or will this get 
submitted for 6.17-rc1?

Sorry if I am being too impatient.

kind regards,
Maud

