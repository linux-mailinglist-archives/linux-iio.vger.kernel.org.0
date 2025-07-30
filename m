Return-Path: <linux-iio+bounces-22144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62480B15E88
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9081518C5B6F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848CE293C4A;
	Wed, 30 Jul 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PeyAOHeB"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A722949F1;
	Wed, 30 Jul 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872941; cv=fail; b=dHFi+Cnm4pjhZfUGfgcPIIc2asvIYz26BYI6nVoV97xrGSN8CUGNC/sUHM/W7e3tsSSf2h/OSQTVxXSsrYi4ZhWfrH/cxXObu9aAqRRekK/k8rjihJYLUVF6XH/RGhDKtIc90rUD21YnUXm3NxysIKNGh6/vCHunwqRFuWourvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872941; c=relaxed/simple;
	bh=gzTNwxcbDPp7FweBro9hZfVwgJl/orhpvLSYqDgGqXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MDbJq264lVGWfGuGExRb2oe1OQJvIPKKqJmOKu7MM0nXoc3slWlPK8keGouY+nX2hxCY0OjSiCUXKGZtWSNJBi/yf3DW16IVOhB4HpJJZFbb/76234nROdWl4fuCwTHHUZPRb6b2A7j4piXKS1attFFuPkJMS72bRjihG5pt5VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PeyAOHeB; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAmgB+GuKCiA1p1tbHFaIfc9xg9TiKJXT4GaMOTZMex8GixUuYKwTvOwjtbfpd2dg7tRkpD+uKZguIFSWxL01teIs7cjqqEoAsb3qe7Aq8k0fmShiecZqTB1FRkZY6ntp+F0WzddgdKnQyePSyiMM/1WubjstYftal5fUAqcAP4r4IPxWKukapT70JKC9ofQqE53yWZw5j9x7dJp/be/Wfc9NpwZXGjZ+org5OUgZcM9cDgYsevBqSUF/3B6XYKJgWV05AETJQthNbGldkZetWcT/zisPevrNs/s4aTsTXXGha+uKs7C/zEHM+w6cI5XRTA8HrYzNzD5eEHA/V1UVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/E8q38LqUZN8GyGcHMxocWkfDT+RSPgbK8YhzzhHfc=;
 b=ZGeQlmFnizJxkgpsu9Shrr+LhAKmYsClLmHhSq+OImr3q/W0d5XGBAuOThg8B2gjsGDPpvr0BwMdkPZ2Ij2+bGEBng1fzg40vyy6p3rs/zoqV5QrRHWhRMsuq0yR7PdJuP11s/AXnzar3XSuZ4//gZkKL4e+ur0p+5XdujGtW++rOTaCfBDqNH3KGMdrhFxrJZLYLbBIusXBT4uIAD0k3pvfaMNsknD0X6Nesi9sp3HCuDPVOiB7SMC88/+OAUBGkX4+D9y/jaa5YIa8DQ6NjSkHW4C2fsOrMnfQ6B02gPGTmg9NdileZ2GsdiKmTKl2ORhbpW409IWnMO+wjvf5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/E8q38LqUZN8GyGcHMxocWkfDT+RSPgbK8YhzzhHfc=;
 b=PeyAOHeBjbRINrNGx2VndAvrXLg00iXJYPPuyPOuFJaumHqL9JnBow8a4Y7+ef+/UQKBodsQo4EVWr0jyqCp3kLNqOLNmmphJUZ+HCDN9X4oFDaMKmxU9h0cgP5faRybIGixtRhHs2ojM+40qCFrbPey5x9TwsYTkZyoM1yYULg=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 10:55:31 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0%5]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 10:55:30 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron
	<jic23@kernel.org>
CC: Sean Anderson <sean.anderson@linux.dev>, "O'Griofa, Conall"
	<conall.ogriofa@amd.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <andy@kernel.org>,
	Manish Narani <manish.narani@xilinx.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alarms
Thread-Topic: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alarms
Thread-Index: AQHb9R/b1tmWBACI9EytyB8y8tMvrrRBdgiAgADeHACAA9wKAIAA7csAgAN4QLA=
Date: Wed, 30 Jul 2025 10:55:30 +0000
Message-ID:
 <IA1PR12MB7736A3924239D1EF35DAED089F24A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20250715002847.2035228-1-sean.anderson@linux.dev>
 <20250724163219.0098ced6@jic23-huawei>
 <3a77d5db-eeb4-43df-9de0-e6bafea4d9ea@amd.com>
 <20250727164336.385dda93@jic23-huawei>
 <69a99252-4f1e-4197-8914-a6fc1c6c7027@amd.com>
In-Reply-To: <69a99252-4f1e-4197-8914-a6fc1c6c7027@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-30T10:53:51.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|CY8PR12MB8065:EE_
x-ms-office365-filtering-correlation-id: 0530d73c-174d-4c97-a1e5-08ddcf5799d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AgEUMOmFEYvLMohDWGSZRucMocRlCDqMv+/Mk6grVNQI/egFMJTlkQH2b+?=
 =?iso-8859-1?Q?GtATD4hGLwunlnUHeMcP5QTsWxlVzfRNcGIyK4iYGO8EHtcn4bk47yU33P?=
 =?iso-8859-1?Q?aO+Y/W/EMPffqB+77EFetxxQt/UlxXUQ8U0wsPvr35GRvQFpyg/QNlu4vp?=
 =?iso-8859-1?Q?xEJ4kyCeh5WDjl1QwXdAVIml7K5ffnTY3K7hJdAvwOJ89N1yg5Pmge8rdP?=
 =?iso-8859-1?Q?R/WrLZKPW1N1a9M7Bmg/K9LsMFTQYUyid9xZCi1T6uWkM+zj9DPT6fwzO5?=
 =?iso-8859-1?Q?i2VebAyQincnRTHs7PA41+x1I7ef65Kg/88A/oIZQqumC+/e+LS1l7/a9u?=
 =?iso-8859-1?Q?8Uirhn3l8ZzijnhNQkUIsw6OzISvnWlD0nTMIq2qQYK+KqMNfN7p7d0KKB?=
 =?iso-8859-1?Q?kp4TnLORlGyB+XyD1RLBk+LvHEF0ufdGipE1Gyw5AE1sEz1Dm1EJzajcRb?=
 =?iso-8859-1?Q?A0FI4IPBLOogoiZFyDZW3Hv+Cm/TTnzY+zdumQl3ewR5n+IrS7K0gAe44j?=
 =?iso-8859-1?Q?ZyrIHZTOHHNJraMElbPOJvvKAlNrlugCIImZTtiPla4axAKPh2XU1nK7LU?=
 =?iso-8859-1?Q?s/b2cH6jgNGbc9TE/rVSidyR+ZorKEANRbhp7gl32T6x1NIuldXpZDbBDS?=
 =?iso-8859-1?Q?ZSFoxFOS70xEUPWQPGn5jydtkpv7LG/y4ycQgto1bAGLOUiUk84YRdWUzq?=
 =?iso-8859-1?Q?eRcF8Hqq6BypJruNkRYHL75Clc3ketpPqNvPQeyu9ATPnKKa0u7SwruPHk?=
 =?iso-8859-1?Q?BK7TtpL8+yovRmAGlB2U69Fi1H+xuSZzLd9YJT4crVYlEKBdSeQCMaVzK6?=
 =?iso-8859-1?Q?RRXw2uwE0rovSQXJnyOq0lNqrZFSwJZMPRSUjvtePADGTfdRw/YN6HiAx3?=
 =?iso-8859-1?Q?PPMD7hM5M4Jx2MBX/HhlfRkJCKEIiutKjXnD4Q/2LUiftprU/+XF8qCVVc?=
 =?iso-8859-1?Q?yy/Kh/ewfuRj2QTJIKrI9oTgUA3EHAZZxbGxt2Zcu0DFjBwsKDVdVrz4I+?=
 =?iso-8859-1?Q?JPuCPnM3ieOwE17AkMxborv90K1gwCqlCblqU+iVoDGh7ieBik38tzgizA?=
 =?iso-8859-1?Q?220dLwzGpXVnCNNyBLQm9GuV6a9/MRSU7NyQxv/1u9365TsDEO4x9daKp2?=
 =?iso-8859-1?Q?wOANYUJBdYvuow1GGxeMuHVZISxRfmCGWGw8mcaDaIqsctRkxfzH4KLu7Y?=
 =?iso-8859-1?Q?VL4HkLR72t3h8GGZxylmQZU3esOl/Qr4C92G8beCFnNIz+X4MEDE8rFEA3?=
 =?iso-8859-1?Q?Ik7PVq/HLGL80lJflidFy0/p7yWPEL+bTUCOjWhl7ZjwhBg1WE9ICdfAHD?=
 =?iso-8859-1?Q?OlTRQaDdR1ccM+Ef025FivvQonH1iQORuL7VTHs0sSwzoBqZcnReM6pgyj?=
 =?iso-8859-1?Q?+v6lgFqNwahNU8lJZyAm0oDcHIWmvU8CjHVjLpAXPqOvTLbO2quMr9fUIm?=
 =?iso-8859-1?Q?L/DeuxDhAd5lBnWX8DpRsFpXy1aWejd3n0nvavGO0lhRwc4ovrmg1bmCwi?=
 =?iso-8859-1?Q?U2K3I8GZqYFWF+hYPruW4x4WYN7kIv/2msZno/+nOBdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7Khh60YXW6iNFmBOAwpg2kkXVFQp9JtuZiLOOsEGkPJSBd+wiQcVdT6UWh?=
 =?iso-8859-1?Q?q671QJ/XLc19B5Bed9HsWIsN4biLPmdsDkK+Nj3+mJcscZXnRiSKO2N8H1?=
 =?iso-8859-1?Q?B49vaeLxS93enSENq1tg3DyZHqFcw3VoXOkMjSPkvKlYzGRwBkw5363RzH?=
 =?iso-8859-1?Q?wXVRoThOus4u7gm76Vl+AG8t4JMwZUIz7dSPXXrfy4QbQ/TYoXPx5POg7l?=
 =?iso-8859-1?Q?yamggXfBta9hKg9CekBMMGucGRPZRZM5dAwpn6yDgtat+C3Iv1T05RABkr?=
 =?iso-8859-1?Q?a6SrWEx5+4VkxS9XvMZ4fJpj9NmUpwFjv65pkGrzmeGru6B5qSZghk1MIc?=
 =?iso-8859-1?Q?/BOfF6zlW78FYUbJn1mIzZxMdsZDh1iPA8g1mFuo5cJtzaNCy+UBPAzEM3?=
 =?iso-8859-1?Q?OoPFOHA4ZGWNmoYajA+Zql1YePLfrnp6+Fxke+iBN48ribX5SOo04cm50n?=
 =?iso-8859-1?Q?GqCVQH/erfFNV84+RtEEP+KPpogQniZK+oU4loSMgKQhPnhwPc0Two4wP2?=
 =?iso-8859-1?Q?AuAXZZXg639wa+KmlOvkDNZFZbakq1W95iid7fUunEsxKE5t67z52efe2Y?=
 =?iso-8859-1?Q?NlPReuisdu1LVtsT2ZAsZlQ4ebXdtQwWFwBOPQKgw/23WOprgpFjdRxtaN?=
 =?iso-8859-1?Q?IMCcnaUA8xyskFwXAQpYoT+sOfbK/D1sU1pJb0aUxhgWdVs4kKPWptg7Lp?=
 =?iso-8859-1?Q?41xSPUIdAKyrL7HIbW6DkNL8YQ8Z3lb3xrf6C6cu3OEZAD9516hWc2TMmp?=
 =?iso-8859-1?Q?DsV/0h4Z3kG5Rz1GF8PK54pASev2xbaXLwIB0+0L743zvAJ1W5TTGci6XT?=
 =?iso-8859-1?Q?HelUz4kWc9Lc1yec20imSuSNvEk2lqCaQueN36c+hzvZulH+daW+gQo4g1?=
 =?iso-8859-1?Q?18WPYEcbhulCLUNSlNBKYUzqX61HW4NTzYX87GnafG12IDQLrUjypyxV1z?=
 =?iso-8859-1?Q?S/eCuYnUG5vlEDdSQQkesos3M1/LL2wXIP7IO2Xe4ckq+nEic0Im1zcLKX?=
 =?iso-8859-1?Q?Xrko3aAV6BVlgbyziVvHLOQHfxUyg4OtZmHegGdeexSC9SgjQzB/zqzmqM?=
 =?iso-8859-1?Q?8LU/wbkiMwFchYXN9Tf+3hbXRBP38kNxCUzjNKx1r59IpQ0jBBFYrYspDQ?=
 =?iso-8859-1?Q?qq2FUiX4bYghewRxhqks++jGtBop2dU5B8r/idxnqxZaYF1//jRESbcTVE?=
 =?iso-8859-1?Q?xO3zFwKprRu0mFavzMrdM1KvcmTHC7GP8giO7DOcgqDgguMAAnAsmdTdY7?=
 =?iso-8859-1?Q?Vvxm7/Xg4FlXfEsGh+Bc1oUneN6m1s/LXRBemptPgk6jD7PnJ0pknjbwLq?=
 =?iso-8859-1?Q?3BVEfVrAlfGpjb8M+3pQAXwPWTv+0Ne3FW9lA8BgFObnIyib5jGDrBLw1g?=
 =?iso-8859-1?Q?j1c0gVMtpB8jdUNMm01KsEn1N0Q0zJHxo5uxI7hk9LZFO739pkT+NYOWrD?=
 =?iso-8859-1?Q?/K5J2WgC7HMrepdG6K6a5Frm/75DNWIt7ocRNrMAb76ocNwM1tK+SMrtFp?=
 =?iso-8859-1?Q?+La9kR59R4gfuyO5tYhxAaZFQpCDygfwaTB0nDOeVPkcfgg7bgrtMiAeLO?=
 =?iso-8859-1?Q?FhHgbYM0MVMeis6lUo33xsiYRRDrk1Li1Ye1RVNs2LbOsrUzGCOVdkIQrT?=
 =?iso-8859-1?Q?TH/F4qUsbHA8g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0530d73c-174d-4c97-a1e5-08ddcf5799d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 10:55:30.6255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YHKdcJP56G5aM/7GIruh2aYvNYaRncc4dwihOM3G3teB/Xj2GdlEHVajR3Gbdpk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,

I am really busy right now. I will look into this within next week.

Regards,
Salih.

> -----Original Message-----
> From: Simek, Michal <michal.simek@amd.com>
> Sent: Monday, July 28, 2025 6:55 AM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Sean Anderson <sean.anderson@linux.dev>; Erim, Salih
> <Salih.Erim@amd.com>; O'Griofa, Conall <conall.ogriofa@amd.com>; Anand
> Ashok Dumbre <anand.ashok.dumbre@xilinx.com>; linux-iio@vger.kernel.org;
> David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com>; li=
nux-
> arm-kernel@lists.infradead.org; Andy Shevchenko <andy@kernel.org>; Manish
> Narani <manish.narani@xilinx.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] iio: xilinx-ams: Unmask interrupts after updating al=
arms
>
>
>
> On 7/27/25 17:43, Jonathan Cameron wrote:
> > On Fri, 25 Jul 2025 06:47:16 +0200
> > Michal Simek <michal.simek@amd.com> wrote:
> >
> >> On 7/24/25 17:32, Jonathan Cameron wrote:
> >>> On Mon, 14 Jul 2025 20:28:47 -0400
> >>> Sean Anderson <sean.anderson@linux.dev> wrote:
> >>>
> >>>> To convert level-triggered alarms into edge-triggered IIO events,
> >>>> alarms are masked when they are triggered. To ensure we catch
> >>>> subsequent alarms, we then periodically poll to see if the alarm is =
still active.
> >>>> If it isn't, we unmask it. Active but masked alarms are stored in
> >>>> current_masked_alarm.
> >>>>
> >>>> If an active alarm is disabled, it will remain set in
> >>>> current_masked_alarm until ams_unmask_worker clears it. If the
> >>>> alarm is re-enabled before ams_unmask_worker runs, then it will
> >>>> never be cleared from current_masked_alarm. This will prevent the
> >>>> alarm event from being pushed even if the alarm is still active.
> >>>>
> >>>> Fix this by recalculating current_masked_alarm immediately when
> >>>> enabling or disabling alarms.
> >>>>
> >>>> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> >>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >>>> ---
> >>> Anand?
> >>>
> >>> This seems fine to me, but I'm not that familiar with the hardware or=
 driver.
> >>
> >> Anand left some time ago. Salih or Conall should be able to provide so=
me input.
> >>
> >> Thanks,
> >> Michal
> >>
> >
> > Hi Michal,
> >
> > Thanks for letting me know.  Would be good to have a MAINTAINERS
> > update patch to remove Anand + ideally add someone else.  If not to
> > mark it orphaned (will still be covered by the top level IIO entry).
>
> Salih: Can you please send a patch for it?
>
> It is also covered my fragment that's why you don't need to explicitly ad=
d me there.
>
> Thanks,
> Michal
>
>


