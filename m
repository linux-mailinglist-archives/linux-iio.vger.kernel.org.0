Return-Path: <linux-iio+bounces-11913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E79BC80E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798101F231C3
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEE519882C;
	Tue,  5 Nov 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ov4FXIRf"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9F1E89C;
	Tue,  5 Nov 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795519; cv=fail; b=fpnAgx0vG/+bOWTlQOs/iy0VVTd3k5kLFilY/td3WyymGHlqMBHKeSmaryd3U37PDbuG/9/mt5cPSG5JiNvrgu7J8q683X6PkxOeyEo11fcBQY380V19Mr4avlVAupDDxTIVsyMDrq6bW4nAw8Dw3i34dnRo0pzwlf5Wecp09J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795519; c=relaxed/simple;
	bh=Lepyhi6JeR8TXWFh6lT5N2gKxf6xK45drJBvhKg4QmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kIGVlZe3HuvPaeejAZaXfzKmnKbsTnO+BR1FHD7RzkUJs62RLmBjZdJTvPIdY6twm/LFPIU7N2ySaqvaxhrAh0CXyZHfCSnskPtDj27wg+/7PUdEpXvSCZ7iUDc6yaUWx31sClBalN1YV+TnAIu+ivxNDJI1kc3op90YEwZe+IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ov4FXIRf; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nanf0F4aTu0HLEROcUr62FqbWBe+KKMfTBpCHq2E+upWsQOQBeBBGZwZTDkMbunfx4SlvWYkYghL8cfAtwCIg7y3nvyScqp/+uKUh6E1JdyzzTc0DYI+HYRN/0WlDwucsnDAbnjRjKQzX5KgY6B7JHNzDrXv40LpSaVedFXzGGGbZjF7Kpgz46l6dssXKpWeezsQMz82PFE1az50Jy5+IKuV53p8itup5geG/ofk6BO1pLrASd4UfgUwf0cJNM/U0tFgoRaI9DSQWmg8c5nEsWCF4GRn+ykJVV+evAIB29SdDKvpDBHjk4Fi3/vfKC1bn/KktS++pVdC4LPHsgx9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lepyhi6JeR8TXWFh6lT5N2gKxf6xK45drJBvhKg4QmU=;
 b=mxzBrFTBmS1PXK3RucOCYECacRwrIn0wUW+G8ayK+adWUCiGKNZ2IoD6g2IdaKtKcmqDONHGag8PPUAID2HaZyZed06aJPtD+jrQno/wM9h5Ttuya02XK7roJgjkg8Cpz+Sh+bGw5hKPBG5cvFB6QciXEbaPvrlGdg2FQrXCUvekGElSMPd1R+fLF+ojkES93/mjXHj57AlXVP/2u+1C6SGfOLHVrUEKksDJOM3SMibd1SINOnumTvOIrzakCmZAzuL+KWfdrEvrraMmIP6E5ik+oyddJ8tlsG9LLNB0YRNUvlKSazpOtQrqddleaI71cA8Jb2r8LrV+F3Nzxvz2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lepyhi6JeR8TXWFh6lT5N2gKxf6xK45drJBvhKg4QmU=;
 b=ov4FXIRfp6ZnNEB4h6N/0h1EgMNfudvD30Zi2dUm11fSRdcwNd/CjcUyKHRWxumXBHXNBfikxO5zreqTCdNfWf22RR6sOOKDXS7hPnLmgYYjmB/7HikipQKpe881GPKVGa4+QKnjzlY+nKWWL81Y2ofWkQ1J+u8hIkQrEBRA6tK7nvJfrZymtC4eU6H+5QLnWGgBEFeSRjLIfL7kiaqcWxhRk/L/Hbm1zyAwoTjHUr98g2GdP6iv1lP0sXqgY3a/2UduUvzB9OkZjYp0fIyhQYxUEKQgy9IHbXsyK+YJQf9Tf+6bmeuMoWPjh0y4B4g7AGuR9b5rc6lfYVEpJumXHA==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 08:31:53 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 08:31:53 +0000
From: <Victor.Duicu@microchip.com>
To: <andy.shevchenko@gmail.com>
CC: <Marius.Cristea@microchip.com>, <jic23@kernel.org>,
	<matteomartelli3@gmail.com>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Thread-Topic: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Thread-Index: AQHbK2Fz1TpJ2WVOtUKNH6xsDs7z2LKkaYAAgAP6DAA=
Date: Tue, 5 Nov 2024 08:31:53 +0000
Message-ID: <11fc5bd7fcf5a4bb674ed167fbc9e2ce8f6cd565.camel@microchip.com>
References: <20241031065205.50154-1-victor.duicu@microchip.com>
	 <ZyaB9G1baF10FzZD@surfacebook.localdomain>
In-Reply-To: <ZyaB9G1baF10FzZD@surfacebook.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|DS7PR11MB6128:EE_
x-ms-office365-filtering-correlation-id: 3192ca92-df42-42bc-3667-08dcfd744d6c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REFRYi9qVm9ad2RQWXQ4MEVEbW1CQ01RbVdYdk1DU2NsOXFtMXIzUmZyNlpk?=
 =?utf-8?B?ZThydmVxWFNBcytlKy9UZk5KVkN4RERURmJsdEpCY3k5cUJRZlNDZjNCMWd0?=
 =?utf-8?B?ZXBiajN3TVorTUc3TnVjZzJvWmpVWUUxUGZkcHJBU21YQXlyMUg4ODlDQzRo?=
 =?utf-8?B?QUw1MjZ1WTFuMURockpyQ29keHJtR2x4aU1Yd1hHZlE2RW9XaGdBcC84NzBS?=
 =?utf-8?B?WXJWSzM3UDZjcG5HOGpERW11dHBHcDIzTE9BcHF2M3l6cWx6b240ZGNDalNz?=
 =?utf-8?B?V2tNSy9ZTXk4SWkxcHI4U2swM3h3eWpRMWpVSEVMV01xTWZJeG5Zc3ljMnVS?=
 =?utf-8?B?QkQvRVpIWi9WbWVkWUdGY2Rncys0dXZNSUZQZkNNaEFGT2IrZHpRdThSNkpl?=
 =?utf-8?B?N21SZkdxK1JiRTdyS0dadW1aZnJ6Rnp2TGtERUJ0ZnQydVdtS3owZzFPaGNL?=
 =?utf-8?B?S0I4UWIvZE1MOUxWUnNYaFdVVGVCUHp3SWlKUjRqekJlYVNZVjlNWW5pakpo?=
 =?utf-8?B?OTBWcC9yZ0QyOExaTy96TFh3dnBEY2lKZGxKWEVEZFRlWUhRd2FVclZqQk94?=
 =?utf-8?B?bnp1SnFtVDlyUlNCK1puRGJIMjZGUC8zQ3hSUUVPOVZYakxZMFdVbGJkRlIr?=
 =?utf-8?B?QVkvbEMvbEdBY3BndUxsYjlTYWNRVHZnMFdkZSs1a29JOFdxakk1S2Q5aHZz?=
 =?utf-8?B?THRaMm5iMVJUand1YmRCVDJYbUZnb1BVMndYRUIrUld6Ujl1L2QwV05mVnp3?=
 =?utf-8?B?STBDaTlmZU5uLzFpaVp5OTJRUngyR1d3eE5oZlVISFFkcnVlSFZWWUFwVlJQ?=
 =?utf-8?B?VHlXZktLRmd1Sy9GbzR4eXZuRTU1WmdFMkYyVVhsRGZKaFYwWG5BeXRmazB2?=
 =?utf-8?B?cGZubzhQOHpiOGVvamNtVXJjLzRpNVNhK1JXYm5IbnVsRXdGbWZTTXNWYTNY?=
 =?utf-8?B?RG5KUmZ1THdnRUFkeDVpd25oVXVQZUprMGd1SkdLZEsxbFdDbzNMSXBNVkxS?=
 =?utf-8?B?NEdWV2YvdDBlNFEyaUZmcThZTlUvOE5hemEwYnNXMjNSZTh2UEQ3bXRrdnRF?=
 =?utf-8?B?R2l1Tm9TUFRNc3Z4RzJFZzJYUHhVdU9VcStDcDZLSlZOcGEzWFdGbDZ6RmF4?=
 =?utf-8?B?d0kyYmtJU0VOZmI1aWdHeGRSNWdUVkg4d21qUUdZeUdvOGV3dTNiejRaejVP?=
 =?utf-8?B?VzZDbE5wV0FvOWZ1aGgxN0lCdGViS2QvL1RWTHBJZXZ3SlFqZWorVDAraCtJ?=
 =?utf-8?B?ejhhYy83enpXVE5QZWp2YWJvalZZTzhaMG5YNnZ6SFRUcVRGZ2JTbWxsa1dx?=
 =?utf-8?B?Si9CYUtaZHFXRTg4WFdEUHNqa2lZMEdCa1I4NWhBRCsyY3RndTYyanJUTVNP?=
 =?utf-8?B?T0Y5SjBJbG9Md1c3ak5USXBPUERUUTZNNHZCaC91TVJyWFExV0xNZXlJbG9u?=
 =?utf-8?B?SUxGTnp5RmNrRnZoSEdqQStxckR2ZDJRbjExNDdSMm81cFkzZXJxMytiSW1D?=
 =?utf-8?B?dGNuWkZNVld0WEVNNXlMbi9hMkJUYkcxaGNkblBwY0p2bXNveFBqSzVqN2Fr?=
 =?utf-8?B?aEtwTHp1WDErL3FiTnBrSWdNUjRQbVdGVUtSODFScG9HWmZISmV2RElNS3NY?=
 =?utf-8?B?VjRLbnBiL0xGSllxcHI4UE5tRGdGR2lxUEgzcW5MMEFSSEUxQmw2aXFMdEk5?=
 =?utf-8?B?blplOG9JbXp0UFBic2VxUEZ4M1ZFNUZkdkpQaEhtK1dQVVozMmo1TUxweTFK?=
 =?utf-8?B?RXdXVFZzTE5jbExrM0Z3b1pqMkp1SzdXTUIvSjdZWU0zcjdseHNtTnU0OEgx?=
 =?utf-8?Q?VyhN7Xu9kUKT7rxi+zrto+HFD0ginV2B2MMuk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ky9Mai9kR0R6V1ZvcEJvZVNpbTdpekNWa29ZYVdOaFd6Z2Zvb1p1d09ibWR2?=
 =?utf-8?B?bEFiOUVVaDJkTHAwbjVZT0phT29TZE1ydTRXSzk1Q0g2UVhES1lQYm92VHFX?=
 =?utf-8?B?bVZ3R3VBMVpLUFByeERGWmNpN21la0poUjV2QWNsdWQ1OFFtQmRxN0M1MTlU?=
 =?utf-8?B?RXVkODd4dlRBODZiRkQweVVQdGVoWlRhQ0txMmF3eWhobUNkSDZLeXZoTlVM?=
 =?utf-8?B?R2RoNFkvT3lCVG5SeDVXRm9uVTdPL1FpdHdJNTNGUGxDM2tPTUlUWjc1cXJL?=
 =?utf-8?B?cGN5TnNIUHVaOHJRSkgvbkJ0UkJpVVNaMWRZRWxTWi9CSWRONjhXZjl6VXFr?=
 =?utf-8?B?ZnZGUkJSWU1DUXk0ZTE4WFF5cURFZ2xjRVBvcFpZSldvUWdjTVNReEJiZEk2?=
 =?utf-8?B?RUJ6b2k1M21QQmFRejdiZkFPVFhITUFpdlZyd0g5cmRIcENjNnFnWHJYVWRy?=
 =?utf-8?B?OFQzNHRITnhDT1RmYUZhVVV1YTVHN2lXTXc0ZHcyenYzUlg5UGU2amZBVFBL?=
 =?utf-8?B?UUg0Mk5BR2x6K0lxaE5FdzNVR0ZBTTR5cVd5SnpFemtIS3c3TGQ5Y0JzWFdH?=
 =?utf-8?B?ZkNwNlJrUmtkeGNlaFFWaUpCRmhpREhTK1RPdVdrRjlaOHV3RC80VnVZUGdI?=
 =?utf-8?B?aHdiV2I0WElIbzBSVk9ORyt0a0Y2Y1JxcmhJeDNKYXhGM0Zqc004WmQxdWxG?=
 =?utf-8?B?UGtHMmkwMEd6S1RHbVI3N1E0NWdrMWgwcVNkN0M0K3l6QnV4NEdFZmVON0FG?=
 =?utf-8?B?aUNoYlRGYm1KazFsU2c4VzlyYk1KbEx3NkcxTjNwZnI3ckQvVFY0Ykhaa0NL?=
 =?utf-8?B?NEcrQmw2QnlYWkRXaEZYMER3QzIwdzM5RU9XZGc0V2pPVkJucStZMzlqY015?=
 =?utf-8?B?SVBCaXVlQllWUFVuOFl3aVZmREI2aG1XSVRnUDRHaGljTXRlZ1ZyVkZGQ3FN?=
 =?utf-8?B?ZS9GcjJrd0JRV2FWL0VDL1N2cno3VG0rNXQ4NEFucFZ0N3lmekdlZzJlNkxW?=
 =?utf-8?B?NVBXaVpuM0kwZWkyMHFJYVhJV21yS1U1NkpOWUlUUnEreEpLTk5LV2QwZU84?=
 =?utf-8?B?K2VMQ1Y5T2RET2xZM0Z0OWZNUlpHZ2VqTGdOU29Oc2tsNjJicDJEcG85dkNp?=
 =?utf-8?B?WXJUd0N0N0NhSEIxMjRMMXdEWVVSOHJaYVA1K1NrdmNscmxESFozc1JDL08w?=
 =?utf-8?B?UVRMbjE5Q0l5ZzEzQkZHM3JPQUV0cUhqV3Z2ZmxFMmg4TTQzSnVmUnMrQUla?=
 =?utf-8?B?Z29TQWRhYS96LzJpejlKbFhkWEhWWHIwVHpiaHNLRnZmbllMaDlKaXhwRjYv?=
 =?utf-8?B?S1NvZkJ6c0I0aE81R2hML0VrRkJBWE1ML1o3QVlkWGNwbW93TXY2QWdWSEJV?=
 =?utf-8?B?cGE1UDUrdE00Tjg0SDlodkplNUY5czRxNVJrbkVTS0xCajIxZ1NZakdUd1Zr?=
 =?utf-8?B?dGhtUTZCQU9kTkkxZnVlQmx5UEM2bjViVndNZ09UMGdzRkVFeHdYWE5IeHZm?=
 =?utf-8?B?T2RpbWlqT1E3S3V4Q0xoa1VPcEpKT0pza21XMnZ5c2dVNEVoT25uQTJhZWZm?=
 =?utf-8?B?WkdnREdEWTVlcVBVeTcxS2dTa3ZoZGFnYmdrMjZ0TDFhN3lod29sc3hsZEFM?=
 =?utf-8?B?M2p4Z3k4cXVQRndrYUpmUWVkVGUvM1h3UlhXdDh2d3R0VXBmSUxrY1A0dDZK?=
 =?utf-8?B?Wkl2MG94NzZZeEU5RXVyOVFGaDFFbzhmZmV1Y3pFQ0F3ekZ2bGFZVWJ6TUti?=
 =?utf-8?B?TmZBVkpMbzQrNHFPOWRHbmN4MjdnQzkwU0JYN3pTRzl2VG15bDNUMS80QUN0?=
 =?utf-8?B?RllJbzVBdjRvcFFLTlpPNFpLSXVFTDI2Tlpob2hickdsK3JRd0JlZE53R2Va?=
 =?utf-8?B?S1NkUkVJcm5NUzFpTWV1WUR2ME1wSGpyK2RGeEZNVlRkREkxZndYQUd4VWtx?=
 =?utf-8?B?Tm41WWJJd1pwbWJ5VmJwdnQ2TlB1YVlnYmdmak1zQStORjJrbUk1MHV0QnEz?=
 =?utf-8?B?YXBYT0ZtdG1uNGJnUWtnTHpwWUkzWldWWVVvWjI1U29JTnpvdW1IMVU5UlBJ?=
 =?utf-8?B?ZTl5eE1VRmpmRjg3Slg1bGFiZW1wZ3ptN1VwaDV6YnNjYlUwVTgvM2JUQTh2?=
 =?utf-8?B?MXk0QkpiWTNVMlprWjIzM2hYZFR1ZHo1TjBjZTVTei9CNUgvTGl2dGZBS0ZV?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE8B0A1A70A31842BDEC627BEBCEB74F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3192ca92-df42-42bc-3667-08dcfd744d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 08:31:53.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2d/d1RjPcF6oFTsNY7Ngu27Y4rAPVdoJL+YUVrvxO49Y4YACg6KwKqFkvG8fDzSOrUjDnIg3FvBBy5CcmGI5eYZNoelP5qNZHeB2pzvvsxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128

T24gU2F0LCAyMDI0LTExLTAyIGF0IDIxOjQ4ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGh1LCBPY3Qg
MzEsIDIwMjQgYXQgMDg6NTI6MDVBTSArMDIwMCwNCj4gdmljdG9yLmR1aWN1QG1pY3JvY2hpcC5j
b23CoGtpcmpvaXR0aToNCj4gPiBGcm9tOiBWaWN0b3IgRHVpY3UgPHZpY3Rvci5kdWljdUBtaWNy
b2NoaXAuY29tPg0KDQpIaSBBbmR5LA0KDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRz
IEFDUEkgc3VwcG9ydCB0byBNaWNyb2NoaXAgcGFjMTkyMS4NCj4gPiBUaGUgZHJpdmVyIGNhbiBy
ZWFkIHNodW50IHJlc2lzdG9yIHZhbHVlIGFuZCBsYWJlbCBmcm9tIEFDUEkgdGFibGUuDQo+IA0K
PiBUaGlzIElEIG1pZ2h0IGJlIG9rYXksIGJ1dCBjYW4gd2UgcGxlYXNlIGhhdmU6DQo+IDEpIHRo
ZSBsaXN0IG9mIHRoZSBtb2RlbHMgKG9yIGEgbW9kZWwpIG9mIHRoZSBkZXZpY2Ugb24gdGhlIG1h
cmtldA0KPiB0aGF0IGhhcyB0aGlzOw0KPiAyKSBBQ1BJIERTRFQgZXhjZXJwdCBvZiB0aGUgcmVz
cGVjdGl2ZSBEZXZpY2Ugb2JqZWN0Pw0KPiANCj4gKEkgbWVhbiBhIGxhcHRvcCwgdGFibGV0LCBw
aG9uZSBvciBvdGhlciBkZXZpY2UgdGhhdCBoYXMgdGhpcyBzZW5zb3INCj4gZGVzY3JpYmVkDQo+
IGluIHRoZSBBQ1BJKQ0KDQpXZSBkbyBub3QgaGF2ZSBhIGxpc3Qgb2YgZW5kLXVzZSBkZXZpY2Vz
IGZvciBwYWMxOTIxLg0KDQo+IA0KPiAuLi4NCj4gDQo+ID4gKy8qDQo+ID4gKyAqIGRvY3VtZW50
YXRpb24gcmVsYXRlZCB0byB0aGUgQUNQSSBkZXZpY2UgZGVmaW5pdGlvbg0KPiANCj4gRG9jdW1l
bnRhdGlvbg0KPiANCj4gPiArICoNCj4gPiBodHRwczovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25s
b2Fkcy9hZW1Eb2N1bWVudHMvZG9jdW1lbnRzL09USC9BcHBsaWNhdGlvbk5vdGVzL0FwcGxpY2F0
aW9uTm90ZXMvUEFDMTkzWC1JbnRlZ3JhdGlvbi1Ob3Rlcy1mb3ItTWljcm9zb2Z0LVdpbmRvd3Mt
MTAtYW5kLVdpbmRvd3MtMTEtRHJpdmVyLVN1cHBvcnQtRFMwMDAwMjUzNC5wZGYNCj4gPiArICov
DQo+IA0KPiAuLi4NCj4gDQo+ID4gK8KgwqDCoMKgIGlmIChBQ1BJX0hBTkRMRShkZXYpKQ0KPiAN
Cj4gSG1tLi4uIFdhbnQgdGhpcyBiZSByZWFsbHkgbmVlZGVkPyBZb3UgY2FuIHRyeSB0byBjYWxs
IERTTS4gYW5kIGlmIGl0DQo+IGZhaWxzIHRyeQ0KPiBEVCAob3IgYWN0dWFsbHkgb3RoZXIgd2F5
IGFyb3VuZCBhcyB3ZSB1c3VhbGx5IGRvKS4NCj4gDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXQgPSBwYWMxOTIxX21hdGNoX2FjcGlfZGV2aWNlKGluZGlvX2Rldik7DQo+ID4gK8Kg
wqDCoMKgIGVsc2UNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHBhYzE5MjFf
cGFyc2Vfb2ZfZncoaW5kaW9fZGV2KTsNCg0KTXkgYXBwcm9hY2ggaXMgdG8gY2xlYW5seSBzZXBh
cmF0ZSB0aGUgY29kZSBmb3IgZHQgYW5kIEFDUEkgYW5kIHRvDQphbGxvdyBmbGV4aWJpbGl0eSBm
b3IgZnV0dXJlIGFkZGl0aW9ucy4NCg0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGFjcGlfZGV2aWNlX2lkIHBhYzE5MjFfYWNwaV9tYXRjaFtdID0gew0KPiA+ICvCoMKg
wqDCoCB7ICJNQ0hQMTkyMSIgfSwNCj4gPiArwqDCoMKgwqAgeyB9DQo+ID4gK307DQo+ID4gK01P
RFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgcGFjMTkyMV9hY3BpX21hdGNoKTsNCj4gDQo+IE1pc3Np
bmcgYmxhbmsgbGluZSBoZXJlLg0KPiANCj4gLi4uDQo+IA0KPiA+IMKgwqDCoMKgwqAgLmRyaXZl
csKgID0gew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uYW1lID0gInBhYzE5MjEi
LA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5wbSA9IHBtX3NsZWVwX3B0cigmcGFj
MTkyMV9wbV9vcHMpLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5vZl9tYXRjaF90
YWJsZSA9IHBhYzE5MjFfb2ZfbWF0Y2gsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAu
YWNwaV9tYXRjaF90YWJsZSA9IHBhYzE5MjFfYWNwaV9tYXRjaA0KPiANCj4gDQo+IE1pc3Npbmcg
dHJhaWxpbmcgY29tbWEgaGVyZS4NCj4gDQo+ID4gwqDCoMKgwqDCoCB9LA0KPiANCj4gLS0NCj4g
V2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4gDQoNCkJlc3QgUmVn
YXJkcywNClZpY3RvciBEdWljdQ0K

