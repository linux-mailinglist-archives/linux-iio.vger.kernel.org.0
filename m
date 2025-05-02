Return-Path: <linux-iio+bounces-19007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC974AA775C
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2959A1BA584C
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21C025D90D;
	Fri,  2 May 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cjAX5Wp5"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D421EEE6;
	Fri,  2 May 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203528; cv=fail; b=YmBfd72KMNHug3X4BICPOIEwkpxupUQzR0xCJ5N7bmHJTSluFYEjaWBT7/cmolZRiVCEHgNz6ePI6xoMlXDQrmln/7ZNSGqfWpSINW0RjmMhsGYFvBJw5V6WWmV631O83s38BcmnsxXyT59W88zqMDzmMXYPZKRjDxtqH4w+J98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203528; c=relaxed/simple;
	bh=ItVoR9ZUG+ECfwliYNVws9ngVBOmeR2HjKgJflLY284=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ewuHdlxzn4P7ZEORb4WsnZuHpfC5JqoAY5dDrgGurXmbQWoTM2GdQiohY1d1Mw2JiV00vpMh5/HOtiSLCMerFGkWRM+KyCKY/eysNw0IbREv5LXzvf177ZfxR1BsA0i1Ul4IvZ3vgBfh1AHC5Ngi7ghozT8kvIH76ACL/UiXbpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cjAX5Wp5; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAKmtYerrZ2XuU4P/J7TAtdcLTy0TjxvruJysJZh5MTMlHcj8HMpHJZble1FK09AUoMg1qpxvcQYPovP+DjIj0a8JXQa8F/g0Nka5pyJqizO0Pafq9Q6WmFIGmBNIZjtBilyW8Ww/EnnPwEuiRERJwtGQhWyoIF2ml04hxqKtiZ3az0+UFhF8AycwzZPEuHUxvkRLReG3rB1J42yOPmltjpvN3KW620/yK+vTR8ePaECz9A27eATvbcfSdaqLVram1xc1cHc+zp9wncDveu1BCrLRPdSkTFONJbyXqdBPZB+u6n2ybrtrmST2k20sppzzhJsc2XVUKP50uqs81Drcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItVoR9ZUG+ECfwliYNVws9ngVBOmeR2HjKgJflLY284=;
 b=QDlfo1mFt3Tc2t3Yp2JzRO6XK3Cp6bisxEJMlbybnR2APbm6U05iAprp0bd8AT9UFaZ90A4i1ULfE0olQymIwTnSDl21s0hKifD+15s3eoL+mnIE0aA8HK+QotApmcQm+VhJJjRcrDNBin8R6ZnxoCxl1ErTDg4jagl3Ng3gcXkvY+dmRxoXb1gxike5z6bORdGHrxEgsGpFRZP2gmRRqgPIsxvDUSI8rfd930JSRgk7FcQCG8jXCiW6kqxZe26iDAydsF3hUFtF1bapYINxl1nISrm1Tq3+j7ohP7rsZiHg2P4Rol2bLXQNFxAO3JsT1UVO58ktEKeFGq+hBKET8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItVoR9ZUG+ECfwliYNVws9ngVBOmeR2HjKgJflLY284=;
 b=cjAX5Wp57MlPLWXaWzEsxRF1OMo0GwP7RD2WZn9NucZGXjXbwW1JvklgYi8xTg2twpnkS3bo6RxNsvRmDPrrNqGpHlCwJyb+DHwmZQ+SyisFCnW4Frfnj1iGbOtM0C0ZV1JfBEl/G1AP/Lf6SWk83X0Wz8TQ4AbPWrA+/FuMeNwFn5ICfTTNOm2GaZ1sjuEi4oe3Xa/FUeZpk+WNxfTYgelEa8ijcURDTGB3wm4OZZ0zb+nYSlhKAKOEPDTnbUXEEa5yIayxvsdtf/aL76RYwaZnLwYoq7LZzSrsXCXOjqomZCcHYhNOXn1d28Vtkc9ntdNxSwowEIQh84kvJKeVaA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GVXPR10MB8528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 16:32:02 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 16:32:02 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "wbg@kernel.org" <wbg@kernel.org>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Thread-Topic: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with
 mutex
Thread-Index: AQHbols1IQCg12nyIkObbOMtTeq9k7O/Q0EAgAAm0wCAAFCrgA==
Date: Fri, 2 May 2025 16:32:02 +0000
Message-ID: <f1e4a1db585e58aca766d0f48ebce3a28986944f.camel@siemens.com>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
	 <jir0aD7w3brmbPDdhC4xAhaEKCp-g08TBmtdn785u_Z5M77ZHMhsK7UoamaROSznl2WmcUmPSnocgVnCSYmUYg==@protonmail.internalid>
	 <8394ef31a75fdf9122331ecb97dd6f986d5026f1.camel@siemens.com>
	 <aBSv1pJ1mulT78gn@ishi>
In-Reply-To: <aBSv1pJ1mulT78gn@ishi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GVXPR10MB8528:EE_
x-ms-office365-filtering-correlation-id: 70ff6a7e-085e-47f1-c07a-08dd8996de6a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0lZSzZ0NFhMUEUwT3B3VXRFd1djZXJ6d3cvZEoxRE1kbEhFTzJ6SDZ2V1Vm?=
 =?utf-8?B?NzFlVUhocmlxZ2VTOUxRYk5BMnpEU2R6WnpDQ1ZrSFEwZ2xPNVFzSktydVNY?=
 =?utf-8?B?dmJRWTN5Y0JnRzNSU0FWN2pFZUtBQzcxbjV6Njd5VnplYUJXNjFkL3FXYWlO?=
 =?utf-8?B?a3JIYVNPMS9LV2plNlJmR2RrVW5ITUZrWUFXajhYNFVVNGh0c0Z1eXMvaDBj?=
 =?utf-8?B?OGQ1RlRtT0xCdXdTdEx3MXRseWlKa1hJTzJzeHoxcGdiWDJVTU91cG5vZlR1?=
 =?utf-8?B?RHMwN1BIaDVaZFZ5Z3BWY3NPM2ZSQWcrTUF1elZ5YWZKNFdYYnlLeitBSkg3?=
 =?utf-8?B?elg4OWkwRHlzbWJod3M3VXdDVmRaVnFyYXM4Vk5ONnZET09yYmQyODYwYnFE?=
 =?utf-8?B?SWNpVmh5YmRYUGQrNDZlVWkwZTBWUXh3dUZnVVFkSmVzbXNtYUNQelQyOFVC?=
 =?utf-8?B?U0Z3TDlaYnNhK1dINGtLSUhJbzJwOGw3eDVEcTY4dUVvWDUrVi9iNGJNWXA2?=
 =?utf-8?B?TnRINy9SOVZlTXNyaXhZTHBseFE2NkU2Q2U2ZE1aaWJpaWkzQlZSTy9sMkdT?=
 =?utf-8?B?bi9SM0dnelhLUkJJZnRmUHQ1U1lXa1pwTW14MU5FTURTdkFVTDd1bVRYQU9E?=
 =?utf-8?B?RUlVamxFKzBmSFFDcFkzbER6TndqSXlVN1lpeitsQmtnQ3FubU5UZkxUWktT?=
 =?utf-8?B?OWJLNmhaRmpOd0JoUXBEcVhDTVdXeTcrMXhuNzRaTnB0MjdlNXJkZm5YUGFj?=
 =?utf-8?B?cVgrbjlYaEVYMVFWVElCY2dpdi9mMjJNQ3pJSWsyMHRiUXpGTWlLYzBmM2VX?=
 =?utf-8?B?U1NLTXV1bWFMVFR5SWlmN2RtdUxQdVJtcFNDN2RoUU0vOU9KSngwcEtJY1dV?=
 =?utf-8?B?aXJwNCtFaDJWU2FCdlNUa3RsUTNvVG9ablhSc0NXaXE0dDVRbUE3YXU5QVZv?=
 =?utf-8?B?ZmloeTdUNTVyQmFaS0NvUnE2cHRHaUV5M3ZFVngyVjZwemZMR2NwVGtmYUM1?=
 =?utf-8?B?OWwzVDFRaVBuTHpkRmNkUkdwSklYN3hpdlNzLzh0QU5PNDI1UDZNOHJzeVB6?=
 =?utf-8?B?bmQ4ZmU0c056cmhGWkpPaU9IZ3lqL1hYOGM5dnhiQVFMRWRYcFUvTmEreGh2?=
 =?utf-8?B?OFljRnY0K3Y5a1J5dEF4YnJkVlloL24veEJ2VnJCS243dUtBcVI2NXNhTENJ?=
 =?utf-8?B?ZGlQWVFkb2Y3MDVObllyeVpTa0w2ZURyRFJQT0RJOHVhRkRYdm5UWmEvVTND?=
 =?utf-8?B?TWhMVnRnM3RNNlhEWHVNdXVGZHA0YTlmbmtqbFEzV1dsd3FDVkNVSW5ZVTFG?=
 =?utf-8?B?NHNyeHRka25BenRyL0haMVpESWxkbDJqV1N2L3M0SUdOZVZkMjMzbitkSEwz?=
 =?utf-8?B?TFdBSkV0SHpFWThrbDlUN2xoSjNXNnlsdk9SeWpsdGNhbUV2aE5XVFB4dW5W?=
 =?utf-8?B?WUVnNmRnTEQ2eUZ6YlVOd1draEtKMmpwQ2hmS3p2U3hpYjZndDdnZW9VeE1W?=
 =?utf-8?B?Z05rU1lpbURTS3AzamRYYnUzZTJZL0dudXk5dVZad0tGTmFncDVMUURsMXAw?=
 =?utf-8?B?WnluNGVHdWZBTU5VTXpvaVR4YnhPc3pZY1YrQk1GRlA5SDBlcHZOTE9CMHM1?=
 =?utf-8?B?b2RZbmN6aGhLZmJvb2tNcndkVXhGUzRab0pDSlhVdVpGWms5YWMyTkpkOFR1?=
 =?utf-8?B?V3QvemlEUFMzVGxQWEZ3MFB2cnovRTBrcGxvMzZMNkxHUUZSa25FL2ZUdVYv?=
 =?utf-8?B?eWJuL2ttYzFldVZYV1NrbzM5dnUySktXcHYrK1FDS3ZGenR3dUVvRWhHMVZz?=
 =?utf-8?B?YnBTWGdSTmNzOEtxdWwwMXRjL2NYaWZjVGNlZS9wTlVnRzNNcVdyellybFoz?=
 =?utf-8?B?dW1DRFYvNHhDQkRwVEk0VE9UejdPS1FCTDZPVjRYa3pweXA4WHpyMnV0Zncy?=
 =?utf-8?Q?aueRQepS6Bs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3ZGMWVEK2ozOU9EQ0pqdE5oSjhMR2c0MEREK1hBL2FLYm9wRVZmME5xVzhU?=
 =?utf-8?B?NlI3UExSQzF1T1huU21sWXk2U0JrNUVxVUp2MjB5dXVIQktBdkJjTW9zVTNN?=
 =?utf-8?B?RWIrT1JRZGFDSnRQRkJWRXpiRlNwM3BEcWRIbVJaanlKNnludkRES25ZejFG?=
 =?utf-8?B?c3Q1VWVxSEZtUG5wOWhrdi9BNGhpejRFNDJacHBnU0djYmhpUHFoU0xuWkpv?=
 =?utf-8?B?NmpPcGJyVEs0L2dCOTloSFQ5dHlkVjZGbGprQWR3NDVwYjdvOFBhcVg5cS9k?=
 =?utf-8?B?YkowMytpY1lwL3l1Rk9ETzNCb0NVQzM1NnlFYmtDWUMyK2ZkNDgwVnFIWWhw?=
 =?utf-8?B?YXFHRXl6V0J1YTVQSU5GOHJMeEZMTkVjRW5yaVZxZ0NOdnMxdEJiMzl1WU1N?=
 =?utf-8?B?K3kxK3hscUVibElJSVVtSldSYzVJL2M3YVlTK01iWFJtUnRHemZhMDdtb0NS?=
 =?utf-8?B?VXk3VDJYRXhvcFVPeVppeHl0RzBRejRySVpmSUdDRFh6Lythc0t2YUVKWFZh?=
 =?utf-8?B?dm5QalZGcjkzMHVnaXBxZFBiYXArek1LZVFlNUh4dG45Rkw1YUNCRU9qME1U?=
 =?utf-8?B?NHEwZUp6dHFmSFhkak5iSENCTzdnZXU2REg5VnJ6R3VKcTJDaWJLK09CTFBP?=
 =?utf-8?B?R21ZSXNQV09XckdNQmJaKy8yYTdLOXlzajUvSHp5M0lUdnlqKzAwZ3RicmVD?=
 =?utf-8?B?TzFiZnZvU3diTVhyZUw2MVNiZ3BkZWtzM0xyVUlUSk9UTXJqT2hObC9tajZ2?=
 =?utf-8?B?dHpKZ05BTFhmNGhEWHFpNFFxcC9yK0NsOVJzUDEzN2ZMWkFzMHVwUld4KzlH?=
 =?utf-8?B?KzVYcVlpL2xubElJa2pOMnJMc0Y4VXIralpEeEFWRkNJbStVVC9SVDNxOHZl?=
 =?utf-8?B?Uzg2bk94SGUzRk1udlcrdTM1d0pobGc0Q0FpTzRvN1ByNE1Na3F1NUNnMzU4?=
 =?utf-8?B?bmVXUWRjME5zcEIwQW41dXhhTWIzMFZJOWkyaUQzVUdXQ2RYNFlWb0VudDNE?=
 =?utf-8?B?cWVGQXZONHJMODFSZm14VC9hVjRMcloydm4wbW1Pai9iTW53ZlpwVU5qOVk3?=
 =?utf-8?B?MFN0eWxaczdGdkdvTEFVczI0a0p4WlBnTCtGK1lNeWRCQkllS1lYalZsOExL?=
 =?utf-8?B?NlE4WlBsa1dpdmhjNlBMU291RERXWjRKQXMyeXhJcUF0VnYxN1p1QmJmRUZv?=
 =?utf-8?B?a1VuKytVa3pSMUF0dTJBemJZWW5lTktSVGh2Q2pQV2pZOXZrZXN6QStoVy9E?=
 =?utf-8?B?eEZYQUtQV3VwQ0lDaTVScmN6bzV0L1FtRVREZWlPbXpsaCsxTjJQZmJLa1pX?=
 =?utf-8?B?WjdXSGlxWU8yaTFKekNFWjhiT0ZJYTdpbjBmLzc2bTIyclkrclk5Z3ZmVzRD?=
 =?utf-8?B?RWZWV1dkT0ltMWdQdi95MVFoRVlkWjZXQlhJSFhKNXRBUFRZV3NHd1ZQMG1N?=
 =?utf-8?B?QUJQbDFaREduSHkwRWE0NS8wekk2Qnk4aENqVWl0SUc1RWlaZnNWNVlBeWlN?=
 =?utf-8?B?QVdsbGRGQkhpY0E0Yy9BVGFGNVFWMjc5OE1QblBvZnUybW53UStZZjdsZ1FD?=
 =?utf-8?B?NmVETlo5UXNkWW11TklHcnFrQmhBYlpVdzlDdEFqMjJVYnZtYVFER2VkYnRM?=
 =?utf-8?B?bVpwQzFzbDVyZnFPbEIxdXdYaEo4Y0w3dEJVWWJHZVRvT1BIdUlrTE5iR0Ur?=
 =?utf-8?B?NEpUdFY5ZzBIVXl1Nm5Nc2lFV1FYT1ZseVZDWDhjUktTQXJVNlJIZ3ZvVFkx?=
 =?utf-8?B?Z2d0VENESzZRaklrTTlSQVNnQncxTDViZ1FiM1JWbStlUkNxcDF0U1RjWkNq?=
 =?utf-8?B?cHpYcHJWaXlkZ0tUYi9TSUluOWhPbjVEUFZPRkRWR0tjN0FrNjE3RUN1ZmQ4?=
 =?utf-8?B?aHdZRTh0UE9Ic09idTBXdjcwMER2Z3dCZm83Nkw4NHdWYVMxZllkQUZyNDJV?=
 =?utf-8?B?VFZZQ0E3WU5hSkg5a1p1WFVXZ3JmZzhjVFUwakxDTi81OEZHeE9JRXF5ZnRO?=
 =?utf-8?B?UXZ4Yk50SnJhc0t3SE1udzhMaTdyWGdoWkJEUHhrWTVUZVB6Y3MwWTdxTkx4?=
 =?utf-8?B?bElLUUVYTXFBT0h2Y3NDMDlHTEcrTzRKNUdzOTAxQjM5UWJyRTZHWTNaNXJZ?=
 =?utf-8?B?d09WU043aUJFSTZDQ243cUViYVlYYTJqNUFCKzdqRmREQy9LTUkzVkUzcEJZ?=
 =?utf-8?B?NlpxUC9OUmU2RDVKRWJmblVjcWdsZnZ2T1RKZDdwN21kUkV1V1F3bEtkZmNo?=
 =?utf-8?Q?avvWglNTnkPllyto8amtz/KcQhW18fLzpDKRUZtEgo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <648021003B284642B5ECF7FDD0A9FF6B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ff6a7e-085e-47f1-c07a-08dd8996de6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 16:32:02.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKQavA+wu/f/sy5BxVk03WF7RabCSTO4JLg2ObyGOTqp+QexPQxuY5tKwzjKVnRmcqv1cgT5cX4SgGaNs2P3WeDL4GmcSXzDSeSttx8GLzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8528

VGhhbmtzIGZvciB0aGUgcXVpY2sgcmVwbHkgV2lsbGlhbSwNCg0KT24gRnJpLCAyMDI1LTA1LTAy
IGF0IDIwOjQzICswOTAwLCBXaWxsaWFtIEJyZWF0aGl0dCBHcmF5IHdyb3RlOg0KPiA+ID4gRnJv
bTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+
ID4gPiANCj4gPiA+IEVuYWJsZS9kaXNhYmxlIHNlZW1zIHRvIGJlIHJhY3kgb24gU01QLCBjb25z
aWRlciB0aGUgZm9sbG93aW5nIHNjZW5hcmlvOg0KPiA+ID4gDQo+ID4gPiBDUFUwIENQVTENCj4g
PiA+IA0KPiA+ID4gaW50ZXJydXB0X2NudF9lbmFibGVfd3JpdGUodHJ1ZSkNCj4gPiA+IHsNCj4g
PiA+IMKgIGlmIChwcml2LT5lbmFibGVkID09IGVuYWJsZSkNCj4gPiA+IMKgIHJldHVybiAwOw0K
PiA+ID4gDQo+ID4gPiDCoCBpZiAoZW5hYmxlKSB7DQo+ID4gPiDCoCBwcml2LT5lbmFibGVkID0g
dHJ1ZTsNCj4gPiA+IMKgIGludGVycnVwdF9jbnRfZW5hYmxlX3dyaXRlKGZhbHNlKQ0KPiA+ID4g
wqAgew0KPiA+ID4gwqAgaWYgKHByaXYtPmVuYWJsZWQgPT0gZW5hYmxlKQ0KPiA+ID4gwqAgcmV0
dXJuIDA7DQo+ID4gPiANCj4gPiA+IMKgIGlmIChlbmFibGUpIHsNCj4gPiA+IMKgIHByaXYtPmVu
YWJsZWQgPSB0cnVlOw0KPiA+ID4gwqAgZW5hYmxlX2lycShwcml2LT5pcnEpOw0KPiA+ID4gwqAg
fSBlbHNlIHsNCj4gPiA+IMKgIGRpc2FibGVfaXJxKHByaXYtPmlycSkNCj4gPiA+IMKgIHByaXYt
PmVuYWJsZWQgPSBmYWxzZTsNCj4gPiA+IMKgIH0NCj4gPiA+IMKgIGVuYWJsZV9pcnEocHJpdi0+
aXJxKTsNCj4gPiA+IMKgIH0gZWxzZSB7DQo+ID4gPiDCoCBkaXNhYmxlX2lycShwcml2LT5pcnEp
Ow0KPiA+ID4gwqAgcHJpdi0+ZW5hYmxlZCA9IGZhbHNlOw0KPiA+ID4gwqAgfQ0KPiA+ID4gDQo+
ID4gPiBUaGUgYWJvdmUgd291bGQgcmVzdWx0IGluIHByaXYtPmVuYWJsZWQgPT0gZmFsc2UsIGJ1
dCBJUlEgbGVmdCBlbmFibGVkLg0KPiA+ID4gUHJvdGVjdCBib3RoIHdyaXRlIChhYm92ZSByYWNl
KSBhbmQgcmVhZCAodG8gcHJvcGFnYXRlIHRoZSB2YWx1ZSBvbiBTTVApDQo+ID4gPiBjYWxsYmFj
a3Mgd2l0aCBhIG11dGV4Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIg
U3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBJJ3Zl
IG5vdGljZWQgdGhhdCB0aGUgcGF0Y2ggaGFzIGJlZW4gbWFya2VkIGFzICJDaGFuZ2VzIFJlcXVl
c3RlZCIgaW4NCj4gPiB0aGUgcGF0Y2h3b3JrLCBjb3VsZCBpdCBiZSBhIG1pc3Rha2U/IEJlY2F1
c2UgSSBuZXZlciByZWNlaXZlZCBhbnkNCj4gPiBjaGFuZ2UgcmVxdWVzdC4NCj4gDQo+IEhpIEFs
ZXhhbmRlciwNCj4gDQo+IEkgY2FuJ3QgY29tbWVudCBvbiB0aGUgcGF0Y2h3b3JrIHN0YXR1cyBi
ZWNhdXNlIEkgZG9uJ3QgdXNlIHRoYXQNCj4gc2VydmljZSwgYnV0IEkgYXBvbG9naXplIG5vbmV0
aGVsZXNzIGZvciB0aGUgZGVsYXkgaW4gcmVzcG9uZGluZyB0byB5b3VyDQo+IHBhdGNoIHN1Ym1p
c3Npb24uIEknbSBob3BpbmcgZm9yIGFuIEFjayBmcm9tIE9sZWtzaWosIGJ1dCB0aGlzIGlzIGEN
Cj4gcHJldHR5IHN0cmFpZ2h0LWZvcndhcmQgZml4IHRoYXQgSSdsbCBiZSBoYXBweSB0byBwaWNr
IGl0IHVwIHJlZ2FyZGxlc3MuDQo+IA0KPiBXb3VsZCB5b3UgcHJvdmlkZSBhIEZpeGVzIGxpbmUg
c28gdGhlIHN0YWJsZSB0cmVlcyBjYW4gcGljayB0aGlzIHVwIGZvcg0KPiB0aGUgbmVjZXNzYXJ5
IGtlcm5lbCB2ZXJzaW9ucz8NCg0Kc2hhbGwgSSByZS1zcGluIG9yIHdvdWxkIHRoaXMgc2VwYXJh
dGUgdGFnIHN1ZmZpY2U/DQoNCkZpeGVzOiBhNTVlYmQ0N2YyMWYgKCJjb3VudGVyOiBhZGQgSVJR
IG9yIEdQSU8gYmFzZWQgY291bnRlciIpDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVt
ZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

