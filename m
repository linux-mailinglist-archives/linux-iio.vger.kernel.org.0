Return-Path: <linux-iio+bounces-26937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2402CCAD262
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A0D53021F62
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE33112D0;
	Mon,  8 Dec 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="rkCUU4qD"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023088.outbound.protection.outlook.com [52.101.72.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87D28D82F;
	Mon,  8 Dec 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197083; cv=fail; b=TMJIxkGne7hdCMN1ltOntBBQbJbg1EXQtB6btlSKfA2bTEwynmV4EphtXHQK9Luzmyaj48kwfnCQpJTYRAmeiL9EGQwdVHA6tZWZ9n6E7d87SUixi+strl2MDE8X4Su/okqSnVhOc2uvdws5C+OU/raDSfa0s6MLkncR8vYFkSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197083; c=relaxed/simple;
	bh=fSmPX2m5z9M7hhXsJiDZjpKd7i92Fx411JTM8qXomP4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SANleQohDdHHKlvusl7rIbAaeR8GPDLLI9LNvCrN7q1/1L/lKb+l4rax/oxsjHvIB6dyn24d9dk4McpTtuy2mp3Xi8NOVmpEN/fsquOUQWfhGi3haXQ6FBGUHnSCvoebSkeameGIWpY9CMMO1q3NC7x5S4p/fFgCCrkZ/2Okmmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=rkCUU4qD; arc=fail smtp.client-ip=52.101.72.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHK6ZT+tWPmgoMmweWcWm9kVYzlMjilup/1obx6DhPna1Cyxt/+E8hJd0o7HTjm+cZOc+NcdgVDXfiqomQUpjy/Yg7fWheCBmJa+ow1LV/36CwjrkWcXnGNECurMq0jKEJcLcTF2mU0GJfJ5/GELb+JbGhNT4Jrqi9lIV4o+TVGhG60fKQw8YXRGz75hWRA1g6rxa2wZbM8L1K0A7KxrBdUY011jjlo/VoAm9v2DaOEnjS2uU5qHFM/rr28iSjArgkRo40q4ag+3BGIMqK5D5S3X4/VCfitpoyscE/dcpjiZSpb4mtRu/krE45nq3c+0bNPghE3zJDn6UHzLVif8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K86oCe+6H6hB+etscf2DFxFIDI9ZREdz3QBn/1moG3M=;
 b=EhxkWccBRTCFkGmTxDrOSVWzSgG8e1czmyUASIPfPToTw3QE+2LS8vgf+2nGETZym/ceb3pclPGAJrGyfBHDVIe2HaUEP2D/OYkCGV56pFjMlyPeO1EMC4MgO9p5awvXkPNCXtmgW6gwPiErBitSRqMzc6NS1YxSAeaxymf/ATw7OP5Z9SawZTPo8wHGD96ICgH0ENtyS0xhwyt1mf4+7mz4ihAKHJDSVBIbjfzMPyBjAVEyabCc7JavuiGg6GXt1HTd6hJDx0QBiXDohLs4zIjulsZ9Cim5nw2OGANHwkvE+EesoSlonSlPf2cKxkYy3ZehgdZ9UX+hqn8fTt4OVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K86oCe+6H6hB+etscf2DFxFIDI9ZREdz3QBn/1moG3M=;
 b=rkCUU4qD+I/Rt1MvpGT145zoBpevP6lCK86r0VSfC8ZWaw1dpf6d3p1T+T6Yw06A7P6LML2NV5e8n/kE5G2OkR19PEdTPRGuVu/YLy3Rhipb7Eruc+EjFBPvLXtZkW7AfGoYhLhpzM5jqPSkueL4mSi58C2VbqIMMrNvqZgT4Egu1L56rgmgfWgbo9Q2UvE1nWEImU6lowZcHwtMEZAz09RY82pKbaT6zDHxseLVQEsDuJQFqEhouVJa6XpTmBUQJ/eEjlSkO+W2dFbdEg874LYzvDNIdy2tx5Zcvi+GiZpthqCn21A87kO632nmHQCNYj6nrXlbQMddIi00Z03/SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV4PR06MB10452.eurprd06.prod.outlook.com (2603:10a6:150:2e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 12:31:10 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 12:31:10 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Mon, 08 Dec 2025 12:30:59 +0000
Subject: [PATCH v3 3/3] iio: adc: ad9467: drop kernel.h in favor of
 array_size.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-add-ad9211-v3-3-c49897fa91c4@vaisala.com>
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
In-Reply-To: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765197067; l=727;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=fSmPX2m5z9M7hhXsJiDZjpKd7i92Fx411JTM8qXomP4=;
 b=3xerb34ZUIItAzvn/wV2c9z2/kJoH8rPWKGD3kbIOQr+9cCnaeXA9DhE+2UculrEU+sHvm0Hr
 4Xtj7J2dmgaDSgkdnlRmmOdS5FJFgWzXBbP5HweVu+NvUvo67JlppZQ
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF0004F092.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::62d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV4PR06MB10452:EE_
X-MS-Office365-Filtering-Correlation-Id: b03b2f14-0b36-4401-19d1-08de3655ab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UytRQ3gwbXFoSElnc1lFaWZhYkNNWDZnNCtMZEZhN01DTDdQbkRUQSt2RGly?=
 =?utf-8?B?UkhjWFRhR3l4TllsY0dGWUZWT1M5a25Qbk9kOW1raitiZFBYby82Y1A4eiti?=
 =?utf-8?B?dDQzMFVIb0tVK1dyK25BNnk5WWRwVEdzei9qNWRoUUtQWmxLM1N2MGxMMmd6?=
 =?utf-8?B?djZZOWxIcGYxdm9NSlhyL3VyRHpjQ3A3Q2NtU3BQZi9mOTNUdk5zcG1MZGpY?=
 =?utf-8?B?NDk2UHF2RlgrNm9BTnNYeWUwcTdacnV4OHpXR2QvdEU3RXpidWtxOEp5OGZ6?=
 =?utf-8?B?bEJJMXZNUnRMeHJKeXpTSGF6RHhGU3dqSisyZEN1MWpXN09yTFIrY2NQS21v?=
 =?utf-8?B?ZmtIWUhzVVdoK1Y1VTJGS0NjMVpIOFByTTZzYWlZYjU1bVhCVkpHMERSNDMv?=
 =?utf-8?B?TTY4NkNXTWhQR1czekNYYUEvcUFIclFXUDU4WTJsaldtL25ubDhkeWdkV0pn?=
 =?utf-8?B?RlFQZndNaGM2VG5uUTZEekgveElJSVpJVmJXWlFWN0djck1Bd2RzNXlSd2VC?=
 =?utf-8?B?SE9wRElEclRGNFFXeWZJYyt1cHdQQlNva0JFQ1VMcWFvMVJ2OFVxZ0pBNTUr?=
 =?utf-8?B?emkwRTcwUlFJd3Myc3UxaUtudjhxVTdjUmoxYWJ3aC8vSTVrRmg2TXVXV1pp?=
 =?utf-8?B?dlVOYUk1dU5BakNvbThFWUhDd2NJM1REYVJXZ21RdTRRSHlJMndvOFQxRUFi?=
 =?utf-8?B?NEhIbVFFb2dnZDc1ZTFObTFQRGQrODZ4TzZ2eWNnbkJ1UkNXbTVVVHFGLzE0?=
 =?utf-8?B?N1JXRVAvWG9kcjAzL2pzeHl3MTJCUVI0ZDNmbzRLWmI2R3dtc0pVa0dObzl0?=
 =?utf-8?B?SmxiOWh4STNZaFloNDBFQXNWOXhoZVRZalY2bzBEYTB6Z0FmSXM1THhJWTA0?=
 =?utf-8?B?R1dKeXpROGRVV2FCci8zMXJtMTRsWEpXSFpVallnRkQzWkhjWnBFS2tJQ2dX?=
 =?utf-8?B?VUsrVlhMc2NXeDZzWkVaSEJCMnJNUEpraDlxVXpCbmcrVWY0NjFsOUdGSWYw?=
 =?utf-8?B?NnU1eDNZOXdLdzRDYi9YVVFpM3NKRlZNY09mMGJJMW1vd0wweVpVc2duY0Uy?=
 =?utf-8?B?Sms2TDV4M3ZxS0RvZXhhMmMvRlc0cGh1NHk1THhyU1c1OFZ3L1F1NzAzYnpM?=
 =?utf-8?B?NzlIWkxIVkdYNE43d0F0ZzBCSUt4MVF2MEd5UnhpNm5JQzVzbnpvNjgraXFo?=
 =?utf-8?B?KzdKSWZnZVYvQUI4dU5KM2ZmcjhsV1hhQWZVQVNrQUhKLzkwMXdpK3NZNVRO?=
 =?utf-8?B?NkQxVXQ4ZjVRYm5zeUhWUkJFRmk3YkwzUTZRQnozc0N3bU5MRkp1N2tUNXFl?=
 =?utf-8?B?cW8vdlNtcFN3T0dmQ3dBYmdZNzlBb1phQjJ4WUhDQnAzR2c5WDQ4NFlnUGFs?=
 =?utf-8?B?QnIrMElKVjJHT1RDeEhrSzMzc0djOUZ0U05VTTdMcmY4aWhyNUFhVUtJYklm?=
 =?utf-8?B?Y3JKWFA0QXl1Vjh2NFJlSFF3ZHl4TVAyb1doMU5rVUpia1YrZkluVUhOUWpD?=
 =?utf-8?B?S1RKdEtXUmhzdSs4RjhGU2I3dHc0dFJMRjVYY2p4UE5ld0dNNUxuTjBLOTJN?=
 =?utf-8?B?M083QzRNVnJwNzZWQ2VRSFd2c0wvZVhkbENEWTdqVFptYWJYT2V6Nm9CbzJY?=
 =?utf-8?B?bTNDeXB0RUMrcmxDZFNhK2t6Mks2aDJlVDJVT2Z5UWRnMEpKMEtyN0NpcFpW?=
 =?utf-8?B?MXg2QVcwQ3V1d1FoUVA5ZjVsemtwWnFKSmRHM3RTQUxScUdlTHBseVZYMnhw?=
 =?utf-8?B?b1EwZWlBSVNod085dmVJRlhiMFdkREZUSE9lSC9Jay8vbWNOUEljRldkZnNE?=
 =?utf-8?B?UDdCMUpCSXFYbzQ0dVNpK25wY3F4VE5abFovVVpFejdKNzVZTXdIb1p2MDIz?=
 =?utf-8?B?UlFOSm0ydXRLOTFSOTY0M3orY3hTTkR6ZTZiVTJxY0xKTUJTNmZ0ZThJU3FB?=
 =?utf-8?B?ZDhGcVZIank0ZWRJcWdPZmdJaEozN2p3aVkxSHRvblAyWnJ5YUZPWmxLampL?=
 =?utf-8?B?d29Sb0lxMnl1SnVyczJrU1g5dzE4VXEvajh6TW5HUVVhODdScE8rWnlkWnA5?=
 =?utf-8?Q?Uf2mgP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzdjWTVmcDBFL1VKb05XdVFvN29FSFlRTmRkVkdPYlhNckg1RmZyaTdFWW4v?=
 =?utf-8?B?aEtvOWdVdHVQbGJhV3pCc2dRM1E4Smk3N0plallCV3pOQ1ZIaHRIbFVzN3Fv?=
 =?utf-8?B?dW5rSGYwTTJ6SDFzRDlIdm9IVnlLaVR0SWVWdGdEeVN5dHZPVitNOVFWQm1S?=
 =?utf-8?B?cUhMS0NEVGZIUzgvRzJld1Q2S2NEc2xmRm5ZVlNwR09oZHlKWXNiUHRtWGJ3?=
 =?utf-8?B?bklqNysxNFl3NmZxeUlTbE9vS3NqNDdTcE1sUFE0amhFNytWK21nU1prTzBO?=
 =?utf-8?B?K2pQQWN0VWdkcVQrNnUzVStLYlJGbi8rbHI4NERjdzd0QXBNYXpkbHdjTTFP?=
 =?utf-8?B?aUoyem1QS1ZQVjFmcG5JbmZrOTR4OWZzTDhOcE1ieHVXbWR6VWZXcUQwcXRr?=
 =?utf-8?B?MFpwd000bzN6cXhEbHJSazRhZUFRdHNHcTZyWDk2V0hEbG5PeEtCdWRqRWRE?=
 =?utf-8?B?alpNeUpNcWJraXlJUDZqYUZHS0NLbFRlM0hTN0MwLzhLa2ozb3plQkdvZFFO?=
 =?utf-8?B?ZDl0MmRpRXlsVm16ZnUySTg0NXM3cThTSmJOSkg2NjlBNWZ4dzl1Q0JqaWdE?=
 =?utf-8?B?aGV1bU5tQmQzQWlYY2dja0FtSkhXSlE0aStKbFcxL1VRay9maE82alp2bjhW?=
 =?utf-8?B?b3BTVnlrQWd3T1I3T1pYRDJJSXpyTjBmbktFYWExM0tqai9qVEYrSmR4MTZw?=
 =?utf-8?B?dk9wTi9RRG52ZENGWWlYd1BkQlI4VkhSOTNkeHEyeGhBZDBjQXU3YmJRZFR4?=
 =?utf-8?B?bGQ1SktKQjlJRmFmSTdIVjV4NEEwMGdldFloRm96L1plWWdGYkY3K1hmQng1?=
 =?utf-8?B?UG9LNkp6WkQwWDhHcUw3RE9vVFZoVHdTdHF1WW1RaDFrZmk3czZPZjJTU0lL?=
 =?utf-8?B?L1JjNVREVjFndUJMV1JZRkJLdWNmYXZHbjIyYkJCVTlmMGVEUmtJR1NOWWRK?=
 =?utf-8?B?dm1ua004SVpoaU9ua000aEY3d2haV042OHp0KzZ5TkNZaXNFZEdiS05odW9B?=
 =?utf-8?B?N3Q1cmdodnc0V29mUmlYU2JUOVh3dFJrVGNWUXpla0tRNWhMekVrM1UzcFNT?=
 =?utf-8?B?bTk5VE1JQUFCcXUxUThmb2IvQThhWjZ1ZXRCNTgvU2VGMXAySGp3RlNRQkw3?=
 =?utf-8?B?ZGI4TlN5NE5sTTB4YThPWXpIeStZUFRSWHhuQzhjZFd2UnpWc25JVy9FUkxV?=
 =?utf-8?B?VXVEMTByaWdkWnRjdXZRUWR3VnkxeTFrK0cyL0pUdmtaVllRYzRiSnZrc01N?=
 =?utf-8?B?RjY1R3hqZXh4MDdGcGR2MElwZmdKcWo3UDA2WEJubVZLUkY2TFFVKzAvK1ZK?=
 =?utf-8?B?UWNLbFNxaGF4MUpXRy9mbEh2NDBwbUgvNkVUN0JXdHU5eVdwWXRKUG9LVGhY?=
 =?utf-8?B?NFpEWmhsWjhBTTEyOXcxNDhxNzdSYTJUUjFMcTk2cXJpSmdWV3kwQlBlS3Ra?=
 =?utf-8?B?N2VQL2pBVzM2QXUyYUdVUXFTN29hOW9kOEhleTcvRVFNSzFSeTRRTWdTNXZv?=
 =?utf-8?B?bVdCWHVZYzR3ZENPNGtzMmFJZXJWdkQrSFNySFlMQ0VFRW1CWWoxTlV2UXB2?=
 =?utf-8?B?NVRRbUVYdG1ZWVZmK1hMYXlqTTl3cFJJemxYTG5sc29UU1RhQmp2aGtmRENs?=
 =?utf-8?B?NHBHT25sSjhHaUM0S004N2NrUjIwRzhsTjFhM2hpblJUMmMrR2N2eDluZ25B?=
 =?utf-8?B?Mkl0Sll4QmJNY3dwOERzSC9KOFNhNXVrbEV6dmNPaU5jZHcwRkFFdFM1bDIv?=
 =?utf-8?B?UVdPTG4rcXZKNk5kRld1a2V1eDcxT3BRSFZFRFlmRFk1bS9tMnNoMCtKclJy?=
 =?utf-8?B?YXFkMlBMNzdDekhlZWFIRmxTSmlDcXZ4RU8rcUpFbTdkUndrK0Q0K1NibXFr?=
 =?utf-8?B?NXNITm5acVNRZDUwSHR2ajF4cEtYMXZWUDFXQ0Fod1BTc0hxZkJ0V3ZBRXpj?=
 =?utf-8?B?WW1lVE5LdFBCZm9YVXN1MDhXYjhLR1RDRnB3ZmRpRVVGMFpuUjFDdEpkam5Y?=
 =?utf-8?B?eDJHSVIyYVc1TFJlaXpKdGFqUXFEcmpJcWovZ1o1b3AyVGl4UkRMRkNxUXMv?=
 =?utf-8?B?NWtIR3ErOWdrZ0tleU11eGlDb1VXQjNEb256b2RMa1Zpd05Xdml0NWdCK1FZ?=
 =?utf-8?B?Sk00VFRRd2dFRmxOSlRmb3pBc2crbEltdS95aDh0RzE5ZmRqSmpobTRzdXc0?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03b2f14-0b36-4401-19d1-08de3655ab3e
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 12:31:10.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ow73bJvMh/LfxSCjCEVLprp7ErR+3EiRDPx29j+Asny6HE9MSZRONn4ICNAcVQzu1hfHoAQzfW+4xahsnyrHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10452

No need to include the entire kernel.h when the only thing needed
is the ARRAY_SIZE macro.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 5840bef795daae88518b23ca0dec4da0c5fef07f..e1a89806713835ba73acaa5029de9df481399e5c 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
+#include <linux/array_size.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/seq_file.h>

-- 
2.47.3


