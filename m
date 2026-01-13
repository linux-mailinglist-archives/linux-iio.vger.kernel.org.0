Return-Path: <linux-iio+bounces-27670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26124D18A73
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 13:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A0A305CAC8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DC938E5FF;
	Tue, 13 Jan 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="iRJCJmG2"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020096.outbound.protection.outlook.com [52.101.84.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9D38E5E9;
	Tue, 13 Jan 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306391; cv=fail; b=XPk3Z03aUgfHZcG1Ws1BBIdYG0GoaHVAvcxRLl1Hn8SqwvCa1ms86Skd0qTKAlNJG/USOE0AFFV5vLFaYwuOk+TcgIwtweKTcC+FbzCf3tdQISB2kedPb6+h9G2EOlc4mUZ9y5T4FBhhhfy357jQdDGchbUiccoDcF60LYKH0oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306391; c=relaxed/simple;
	bh=Tsvdxgnl3p8Vs26XTl6yfezdc6vA26x3+u8ySZwd7tA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MQaICxrUZfzbMU91FsogO6wwE27QrgnuyLyC6Dcp+2KaFu3rUNLjch92avJbGnfL+fCeZbLcTmbZmoIrpHdboFrocA8pDiWziVThC2iIGPK+KhDVzIwfqr+s40ECvxJXTDdAlZlsgrXO8maghZV8vKH5elB8AKKl4uAbWfIj+EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=iRJCJmG2; arc=fail smtp.client-ip=52.101.84.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF9mXwlCqEvAqfRCljfC9e7dQgD5w709lcbYqRcOP0LIHzz/cGlMqkN0TX2hQ1iRYZWcb6mU441eiCtA6A8TZlbkJIvSNvj/A7D7cpG/FbHxNvf10nFAF9XzIU7rmzXSa9/u8O+uxEBx72E3f1EQfGq//TyxHkR77tAPimFEuSFlkl8S2B8tUFFWeQokPK1P01LTsH/S9YznXyoHJWYKDmORak+lHciFQI7i1u4uG1kO7HuVJp12PMoP+f8zKqBsEkOX+GgmL6esDMx02uqaGKB4tfeFPLT9uZtTAWUu/ux7fz6r2VvcT2Pt3uvkrpxfOwCU4TzLviuwWb2St+z7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UuWuz+3oFIh3Wf5sapqyZDeDgsG3VXwpAQjktR/BxE=;
 b=O2N6ZYLZdjpE/FjOY43BAgWN2oztdhyJb5f1pRS/wP0JPWRWFrwk8FwioqSRnvp/3W83gzAGJPbHMh1i484xUcrsv73OesxUXj8ryx6y4qOWTk0ga6rptAnJCDWG0t1aHiN2l0+WZzTiDJ0elQYdgaGYdTMjvvDzzqO9mf5x7EISKIEnuaw99SOwU9e/OeiI/fhK48JOwubVO/ipkdWc3DaztI7KymirDDAiMsl18OIIoo04p63p68xc7c847fC/f20ev11K82hFqN8dI7IEKJE2NEJ00Uj03hYhGSeGZyv+6Zwpg2ntIMQ+FHjLXP1NijTtMT9a8LhSO8MaqNN6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UuWuz+3oFIh3Wf5sapqyZDeDgsG3VXwpAQjktR/BxE=;
 b=iRJCJmG28o3df1jC7XxQgQGRpoD14VueZLSWOzj3Y0wbe5EbBk7BDM5pbvYwbhG+ZK7vwjZscu3nk/DBtYvs4lgbAWw2he8gfdOznB6O0tzVKveqvzjjfBDRKcdZrCNdNy/kmbn+Wc4j+ypv+9Xn/JTKrT6ZuIyMAIiWiw+ivFvyG61jAYenDp+nRBltpB3vpMDA+O8H8dR73hJYQTu0RzVCYwTGOJjj0GIFBF7MSAP6BtnkRtwJqa/ts3vQIJr/z0b+kNM1fpu4+4F5Rme2M9gTTyjxdsIxNXoh+PI6YcHXIMuTHmF0R4LYYYo13FUmoDxsfEdhS/lmxzxq8lu+hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DUZPR06MB8963.eurprd06.prod.outlook.com (2603:10a6:10:4d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 12:13:00 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:13:00 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 13 Jan 2026 12:12:48 +0000
Subject: [PATCH v2 2/3] iio: industrialio-backend: support backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-ad9467-optional-backend-v2-2-0a27e7e72f41@vaisala.com>
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
In-Reply-To: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768306378; l=3143;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=Tsvdxgnl3p8Vs26XTl6yfezdc6vA26x3+u8ySZwd7tA=;
 b=d20+lXecN8XbM8a0mzvqpRhHQ10vkiDPkljFP9RyLeyz/hlWXobI+INkE/H3y5YDR70yY/3zm
 2ubzoCaruK8C2mBPl8Vn8Vez9HhRFtVPW8j6LLshFdX57vwfBumZm81
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF0005F6A1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::129) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DUZPR06MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 77395586-b953-4222-9f87-08de529d185b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFpsamNPYnZpbWhDTVhwWE5HbFNlK0tSVVJGSVpEYUNTU0RDdThCcWFqeXdR?=
 =?utf-8?B?b0ttaGpqalhxWFhzSUNtNVM1WnBUTHN5U3ArYTY5WXdJN3k2RDdjQVN6dERa?=
 =?utf-8?B?ckFEakdVc1JUdVFldHJCQ2J4MzVSRWlGUWlMSmczNzdxeDczZnVqNkUzY2lo?=
 =?utf-8?B?T2ZUb3V6azk3V1ZmYm9WZ3NRLy9id2FNT3U2Q3h5REt2RjlJUGpDbFpWWHcx?=
 =?utf-8?B?UFFBUm53NlFjZTVEU2s2ZkRsVnQydUc5SnN6Y09DY2wrSTZmZGdyTmZzbzhY?=
 =?utf-8?B?TFBxcDlGYU5zcmI3TDFqTnE4N3dwV3ZsbWhkd0p3d3ErMHRLVmFSVk5LbE5N?=
 =?utf-8?B?dFBmNWs1cU8ydVh3SjRVTkNWYlhhdTROUi9Oc0xERUVhN0pwL3JWTFhXRnJH?=
 =?utf-8?B?QXNvWEliUzlUbEEwNWl1UTZWS3JKT1dHOUQya3dKQXI5UW02NkxXNDlFOGJE?=
 =?utf-8?B?UEJJa1IvdElHcS9iZnlSZ1QvKzVBQzhjOVhETmZYc2xHYXZtR0F4VEFiYmFK?=
 =?utf-8?B?TFpuSTNuelZRQ2kzTVI3dUR2SkRoWnpJcTBZVzhkbzJUaWg1UWhhcno3Y3VU?=
 =?utf-8?B?T1dDcTA4TVRhNUwxWndpK01wM2VQUU1laVRSeUNseEFEbHJ3NnUvYjBZR3lZ?=
 =?utf-8?B?MEFCYTBvVW1iTGJzalo5ZTBQcEhoaUJabk9jRzdMTzFlbWg1RENRc2VLYUJy?=
 =?utf-8?B?Q21mSlJwWkV2bWEvd0svNWx2bGc1K3FJRnB1UVhTNFpoSVhqTlFaeTloMkJT?=
 =?utf-8?B?K3ZFaW0ycC80bldwdXE0Y0k4ekdqZ0VHTE5HdktSV09vVWhpRXAzY25CeHhn?=
 =?utf-8?B?SVIrU1QrTXpnU1VWbzR4RVlmT3d5UFZpWG5tanVvRTJxN0R4cFNPRlRZR2c1?=
 =?utf-8?B?V1JBb3gwV1pIWFA5dktvQnVPMnhNVTZYVUhic2d4M0dEaitHazZEbktqY2xt?=
 =?utf-8?B?RDZCZm9kVzZ2MlB6L2sxVG5UYkJvc1BqTGxCMXg1MEIvWkg2RHZhd1hPcExT?=
 =?utf-8?B?Y3R6WWlscXZVVXBGYndMRURxR29oaUNLSGpBblIzR3lmVlFoZ29CK2piazEy?=
 =?utf-8?B?R1pCeGx5ZHoreUJVVUs4eEZhcklqVE5NbUt4bzhPaHVFL2J6SHVobmRPWmM5?=
 =?utf-8?B?Q2FqeFFxWXB5YzRnZTdKeG9CVjBrNUlsdVJnOFRhUHhqaVFIWm5Nd0NITGU3?=
 =?utf-8?B?dHJpRk1kblIzS1Q2dHNUaDR4MWdYSDFZY1N6dXZDZlZMRmZsQitlRmlMVnhW?=
 =?utf-8?B?Wk96L0loSkpzQVBnV0lVQVp6cXV6V3NDM3ZLVmFZaHhuQ1FwdlptRXFobk9U?=
 =?utf-8?B?SWpwS09DWU4yNGc3ZndvVWt4VWJ6TXhkNVVuYzVXYVVUZnBzWDRzL2Zpc2FW?=
 =?utf-8?B?djhWWHY2VW5sYzd0TzFldURpV3dSSVUzaSswb25jcThJN0dxS0hUcWxBd092?=
 =?utf-8?B?MzhsU2ZrbmY1NHIyLzFlY2hHZk5vYjNzRmtZRGFwRng0RWcyL0k2VEJjU29i?=
 =?utf-8?B?VXpUN3dOM3o5a0s2OXdndGRCTnZudGdqYklaS1NHSitmTUg4M2tuUDgrM1FS?=
 =?utf-8?B?QkdhZUZRL3lVQmxEV2hKczRxTXlwMTdYdmRob2J1Wm1sRi9KbnpZS1pjUmtr?=
 =?utf-8?B?Y0FVZXFoSHlrK25ZalBwN1FGOHh0SkZpR0FHNFV6RnRNYktvaFRrT3c5Ukgw?=
 =?utf-8?B?dFBtN3RrbW9wM1lZR0FVWEx5bUpZZWR1YzQ0L0R6YWhwMTFneVZvcUU0TXJY?=
 =?utf-8?B?WGZnVkp4ZlFPV3VqakwxOUNKQlE2ZUhSMEFmWk1OdTYwUEZVYXlhckgvL0lv?=
 =?utf-8?B?Zy9JK2pFYnRTSHI5QzFjeDFIQ1RZdmU2NERYeGhBcS91c2hwb0ZnVGRvZVZV?=
 =?utf-8?B?VUFHaEdwRTJIamJlU0t5TFVyUm5XUlRZWFJFUnJYZE5mNUJkVzc3Sk12dVBN?=
 =?utf-8?B?Y000ZmxaQVlpbDFBRHdvQXNYS2pFbnE5ckJrYTlhM2dSRGlERVNxUFNiRmVv?=
 =?utf-8?B?NytaZVlGZDJGWHlQcWhyN1ZjYVJZdVZmYTdtU0JUdDRpMk1VdlRuSHNKQ05X?=
 =?utf-8?Q?f1SidO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzJZczlDd0VwbmNVeW1McDRMNXJqRDgwOGRNM1VwaXpESWRDWHdpT1FaNTQ2?=
 =?utf-8?B?VVVMbWlpZTdpd3BaRUt0eXFXcld3MXFHMzlkWWNhc3I3enF4KzhVQjFvV3N5?=
 =?utf-8?B?SHVNc1NzYVhIMGRkSUdiT2FlNXoxK1c2ZW1lZjFXbnNIUWFMdkhpbzdoVVdC?=
 =?utf-8?B?d1hub1V2NWJFK1pUL0hPZzdSRmlaeThuSVdORmlSYTFrR0VSOTR5SlFhZFl6?=
 =?utf-8?B?OHdyMU94cnJ6eWdBbEIyeVRxZExKQ3dYS1JOWldzZ2pkQnpXMm9GTURGOEtz?=
 =?utf-8?B?S2NjeTdicGJnT2Y5WHpOamFpU2ZMZjhZTkYyemlPdVBmSmdvZGVTZXpuVFIx?=
 =?utf-8?B?R2VTZ2x4dFZlbG96RExtMCtGUHg4dU1qUkhnNUI5Mk81OFhtSWt1MVhKUTFP?=
 =?utf-8?B?Z1hwcnhUSnBvK0pNdmVoeFpESFIvYzIxSXBwRnIyOWVtSFovZjVxbVZBQjNq?=
 =?utf-8?B?NjdxODZBRG43a1JxcU13blpSK3k2d243eVl2NDVrZEJkNzFVMGpzMnJWMjlI?=
 =?utf-8?B?V0FMYWIrSWFvZUpnRlJ2bXlPUjJWQUtlSDZhSDZWUEd2VS9HMHNHemZ2OUcr?=
 =?utf-8?B?d3Q2VWZOTG9iV0FJM3JPUXdOMCt0RFF1cmpWWDNoR01UU1FuOXhJVS9JUlNC?=
 =?utf-8?B?NWtKeGdlbUJRMlIvVGM4dWRYMFRuWDdBdUdRc3JoTTRwSXk2NWdHaFA0RitO?=
 =?utf-8?B?a0w4NWR6S2cwdE9JS0dpWElhaFJaamF6WlAvS3V0d1l6N05PTDNhWlRGcnZw?=
 =?utf-8?B?OHlpTVFremRzcGdHRHVYS0VLVlJpUTU1a1VTM1BpZlVoSVMwWXk2eXZSeGRw?=
 =?utf-8?B?eWtBN2RSbGRkOE81bWxuc3FrbEVZWC9yOEZvMjBHOThyTjBJUzIwbWRmQ0h3?=
 =?utf-8?B?VnN0bGl6MXF0bGhibk1YaytNNHI5V2dFMHRKcVVQYzFlM1M4MDNlbnBqTEFa?=
 =?utf-8?B?MlMyRHlYdDJ1eVVZWDJleVowT0JES3VXaGFVaEVNQVF5a0xkbTNLV09kK2R5?=
 =?utf-8?B?RE1wZVpkK2ROUUt1Wm1EUkdwSzdFNkFYYXpLYWNuSlJWOCtqR0FGOW9JdjNz?=
 =?utf-8?B?QzZZSlBYbTd2T3lCaEt0NEcrZFFKYWJxaHJ1cklCZnF6ZDZQa0dDTWk1bU55?=
 =?utf-8?B?WVlyYmJ6VWtmRHc4dmdpL3pqU2lzbXZnSEhaMWhna2xhMFdYeE9FUWRLVSty?=
 =?utf-8?B?TGxDNVczbVYvU1d3UTFWWG8zUHBXK2ZwMG5tb2Y1TG8ydkxWWkdzQk03TStO?=
 =?utf-8?B?T1p5bmo1a2dSb2RjOVhQeldXVzQxNVZKNnZyNVRzTDd6VHIxbDNJdjlSNzB3?=
 =?utf-8?B?RERHQUdOOE4yVWM5ejBmYkZYUGQwVUE2SXRrZTUyazEwK2NMam8wYzhVenc5?=
 =?utf-8?B?MVcxS05PQnlNVHdJaFZ0V0NjOFZ1ZGp5Um9sRjZvUGRtMU5SbUIzQmtLRnBp?=
 =?utf-8?B?WGY2Zy80d1Z0c1V1Z0l1Y1BQbmttZUNpU1pGZnBydC9vSGxxd1JteWZUbTBB?=
 =?utf-8?B?cjMvTVcyS0pBZzczcm9nRDdMZGc0aWZidXNDcWovaVhYdTREQUFqMWJjMWQ0?=
 =?utf-8?B?bXVZUXJvTmtQcksvZHlqOHJ5ODBVeXlISm5HWmNScjNRZUxndWNjc2hnWTRa?=
 =?utf-8?B?V1l3RGJjVXhTc2hVQ1J2Rk1lSENiSUtWSGh3aDhndVJrenlSQisrcEpMRlgv?=
 =?utf-8?B?dndkSTF3S0RZUDkwem5nRmkyQlF3OGw5RFk5OTZNMWIyUWJKb0dENDlmTi8x?=
 =?utf-8?B?ZW5WS0lWOXY5elo0dXEydmg1SENnV3JuUER5Slk4YzIxdGppZExZMzQyRHB2?=
 =?utf-8?B?ODhNdFNvSStOeDBjak90TlZJNTlIRFpyUGJQTnJ3bysrR0l0L0NydVlhVlVj?=
 =?utf-8?B?ZWR3QjRpOFNUdWMyRWY5bTZGTTgwdkdpM0FqWmlIVHNIbEo5VUwyVkJSQnVh?=
 =?utf-8?B?WWhBN0xMNitSZ2x0SXd5TmdERDIxa2hKZzZDODNqUFFzVEJrd1hReU54ZFJs?=
 =?utf-8?B?TC9EUG1ld1RmQzY3Q00zbThDVm9kU0dydkNkSGMxemxxL1V5VjdSTWhhUUp0?=
 =?utf-8?B?NVlWTy9yekNieVliSFIrcDc0cW9lWXFUcm1tUlBWdFpncUc2eDFqZXNGWkhy?=
 =?utf-8?B?b3pRTk5yeWlLbkY1d3AyWTdMcUJaTWl5bVRML0Y2TWZaRk9sZGhmQUhaZG4x?=
 =?utf-8?B?QkdZQXhxTDA0dllkZnpDeWVXUTROVHArRlMrWENtTVUrOWh0UnVDZWRwUFRU?=
 =?utf-8?B?WXdVazIvS1FVRFc1Tmg1VWNWZW8xRzgxdkJ5ZmtlMS9WMUhqUFc0L2lwWXBK?=
 =?utf-8?B?TysybEFERkVEaGZYWjFOamN4aDJRU3lNN1lvdHRwd2JzK3JhRDdKNHRjeVd4?=
 =?utf-8?Q?xfUPxbjJoPTEqmKE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77395586-b953-4222-9f87-08de529d185b
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 12:13:00.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0KK1bIdAHWoK02Gp1jQsj0qeFQ1slbCoBqvOR8T7UtvaKwUQ6jeLCaZAXkVo8HWzGTJS4FMnii+VNR+OIwVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8963

Not all backends support the full set of capabilities provided by the
industrialio-backend framework. Capability bits can be used in frontends
and backends for checking for a certain feature set, or if using
related functions can be expected to fail.

Capability bits should be set by a compatible backend and provided when
registering the backend.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/industrialio-backend.c | 10 ++++++++++
 include/linux/iio/backend.h        |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..997ec743dc67e7cf420ff667af33b4f6a71a5377 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -62,6 +62,7 @@ struct iio_backend {
 	 * backend. Used for the debugfs directory name.
 	 */
 	u8 idx;
+	u32 caps;
 };
 
 /*
@@ -542,6 +543,9 @@ int devm_iio_backend_request_buffer(struct device *dev,
 	struct iio_backend_buffer_pair *pair;
 	struct iio_buffer *buffer;
 
+	if (!iio_backend_caps(back, IIO_BACKEND_CAP_BUFFERING))
+		return 0;
+
 	pair = devm_kzalloc(dev, sizeof(*pair), GFP_KERNEL);
 	if (!pair)
 		return -ENOMEM;
@@ -774,6 +778,12 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
 
+int iio_backend_caps(struct iio_backend *back, u32 cap)
+{
+	return back->caps & cap;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_caps, "IIO_BACKEND");
+
 static void iio_backend_release(void *arg)
 {
 	struct iio_backend *back = arg;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..c020bc48cc05d6fcea00d23e471b12a29b5c0551 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -84,6 +84,12 @@ enum iio_backend_filter_type {
 	IIO_BACKEND_FILTER_TYPE_MAX
 };
 
+enum iio_backend_capabilities {
+	IIO_BACKEND_CAP_TEST_PATTERNS = BIT(0),
+	IIO_BACKEND_CAP_BUFFERING = BIT(1),
+	IIO_BACKEND_CAP_CALIBRATION = BIT(2)
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -179,10 +185,12 @@ struct iio_backend_ops {
  * struct iio_backend_info - info structure for an iio_backend
  * @name: Backend name.
  * @ops: Backend operations.
+ * @caps: Backend capabilities.
  */
 struct iio_backend_info {
 	const char *name;
 	const struct iio_backend_ops *ops;
+	u32 caps;
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -235,6 +243,7 @@ int iio_backend_read_raw(struct iio_backend *back,
 			 long mask);
 int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
+int iio_backend_caps(struct iio_backend *back, u32 cap);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,

-- 
2.47.3


