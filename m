Return-Path: <linux-iio+bounces-20743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E0ADD139
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C644618945CB
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE62EB5A7;
	Tue, 17 Jun 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r1RTY4xV"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097AF2EB5CD;
	Tue, 17 Jun 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173711; cv=fail; b=YRAxUMREaWlwDQRqqHzMg7CSjEkTlNRjwyTNeQtAsPyQeAGqsthS580928OH2sQeuzLq31C7rAiv5BN9xfQkn7DGt0Omr/r+zcl0gpU24zU5LvpV7IAFYX8DADXwDudZ8qznEQh97N/Pif/wtkBimtrwfWB7nrnEQn4s3ugL6+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173711; c=relaxed/simple;
	bh=M6SQV+2E8mvY4J7sbwNzwHEKcogTVGv9C6Gjsyhjy9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GEeAxhYSXFFjB4ZNyNtpYSZP/qgMaJSyKy74vbVZPEHeXCRGebNfx26FFKKd+hylHxUI6Ir7UO7kt9iAMCLzJ+xaY5HNpq8+fDLyw1F0E6pLZBuSp8QJbjJC+/zyby19DfZlczy6bDyWYffrsDV8CvTWjATNGEMG97lyaWygL/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r1RTY4xV; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtVP5qGniAeOkq51hg+Gowg2hwBcCDBVRO3UxHRlYc92ragROw0vR4LdPME1kOF/a+TZzJ1YinuIl4wOb1BBOP29xCsU2GHMLICXaL0unEp7jkq9PWn3RFiCQbgtKDpzJ/FoYjFcTbiUAM82S5O4oxy22Z99v5Mh4uBg939KOUvcaiy+VEeXTufjkkz+BzDAC2isNswPlKKfEfPR7ZrxpbV+kfJwKT4haNr6MKN5tAqsJWcHAQDqlKJhuGQdC1tLLuu1T4Y0+ijFX6+R2DIfw+bAaIa7ooFSNQbroKRUfyNz5AbK2DF3iefPvpM1LEc0QGZnI2d/JhHlVou7ADQX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6SQV+2E8mvY4J7sbwNzwHEKcogTVGv9C6Gjsyhjy9s=;
 b=s2iD6iENdPbQeS1Cb/7usADeOeMFmslVIdilBv3yCV/v557mt9POYMSFujDqqeneDbpRrLCLxuUXMx6B0RMnBmvpUiIWcFXhhZnxJkqc/uO6qrBydG3RnqwuNqD5QLKhWkZmGb1UF2qYXZe6OoMAyEiyCiVGJIxoTn7yRuhVvlEUFVvQSPwpGxaP8F/pn/qm75DcUq+ABwA03pJ+vE31DDEFBCWz7xqDG2s0W3E5fZORfiBEtYtE+M8V6bTx6yLdiPCX2rlwU7koLmYyEYrmufsnpzS7+lRUgYHEc9rfouHCcC0ifoyehZ+nP9392C+L3oErRb7JcWIgVdL3oBUjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6SQV+2E8mvY4J7sbwNzwHEKcogTVGv9C6Gjsyhjy9s=;
 b=r1RTY4xVdZH3zwaLDWQ9i1KHZfes1sOwMrmQKlrwX7E0MNn77SZSo8Dmb/8WjoBM/rPgXWoFER4bFba1BoFiJaHPfgF5pO6lR2R0yk7HvJnYO1m9/yxYb2F3xG8tTXPclVWomCrQU62OKr1y0yO4vJ1JNghb2LomKiOgh3+VQlGQs0tGuS7S4enR+Q9TDTFvaU/GW/MiYb+dU9izFjvlvw+whM/UuezwQkNm/mahvnqR/VM1Lany3GWxLQR3+o+FgiEEa+JVa0mJLvrhqf7b/tn5j+oLkg2vS5QqllwYGxGQvlE8Th5XN/FdE9QkYJkp4pfYfKQ702JC6weFRYrPJA==
Received: from SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21)
 by IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 15:21:46 +0000
Received: from SA1PR11MB5900.namprd11.prod.outlook.com
 ([fe80::2701:d09b:709b:953]) by SA1PR11MB5900.namprd11.prod.outlook.com
 ([fe80::2701:d09b:709b:953%4]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 15:21:45 +0000
From: <Marius.Cristea@microchip.com>
To: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
	<andy@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC194X
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC194X
Thread-Index:
 AQHb1sb7EyODSGnwD0KxSyH5e3G/VbP2SOCAgAY2XYCAAAoyAIAAC5CAgAAI0YCACuuyAA==
Date: Tue, 17 Jun 2025 15:21:45 +0000
Message-ID: <8afdba49fbb3750a64313ac351a855a58b0043c5.camel@microchip.com>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
	 <20250606093929.100118-2-marius.cristea@microchip.com>
	 <92c36ad9-5f8e-4ba7-9af4-9cb640f0aa5c@baylibre.com>
	 <d364524bad53f5c665071287f55a96e28dc9b231.camel@microchip.com>
	 <db78ac20-9b58-49d1-ba38-cc269eaff254@baylibre.com>
	 <a9902463d1f29993f13ce0bc87fcfb05472624d5.camel@microchip.com>
	 <9fdbcb45-ed9a-4449-9248-9bc1d5593fa9@baylibre.com>
In-Reply-To: <9fdbcb45-ed9a-4449-9248-9bc1d5593fa9@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5900:EE_|IA0PR11MB8419:EE_
x-ms-office365-filtering-correlation-id: 2b28d936-adfb-4131-dc5f-08ddadb2abe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2IxYnBzOWxNcFA4OWdpQy8vZis3NVJ3Yk5iMjE4SzNFc29tVzJTSTFTWVVP?=
 =?utf-8?B?TWphalpCWVE3UnpXMUdBU0U0SG5XWkwxOG5mWjVvVnU0a3RlbllGOEMzMDB5?=
 =?utf-8?B?VmNBWFU4NjJEaThLYWVabUYyN2xGeWF2WWsweGlRTzU4SjFKN3ZEVzYvTlds?=
 =?utf-8?B?VnB0aGl3UE9POU0weS84dTQxTjM0UVNwMXZlQVE2aXovMXhUdEMxTHp3d2cx?=
 =?utf-8?B?d284NElZWWcwd1IrWHVPT1Vsc0g1dGdoTXNCWEhRUUt4OHQwUHhnK2F1Vnc3?=
 =?utf-8?B?M3ByVWhZcFBvNy9vZWY1czB4WGNuUC91MjlNU256UVdVQWxybWMwSktHRGdQ?=
 =?utf-8?B?N3JobWsrVy9DRlNuRXdEc01tSUtnaFo0WmgwWUN0d1ZnZ25uQzRPdERvbDhP?=
 =?utf-8?B?MDlVNlhRT3Q5NWloYnFBZG92QXY1UktYb3NNS2FGUjJKZk9CU2RBaWFWZ0V3?=
 =?utf-8?B?TmZ3alFzeDNNUGtEdlFlQVpVV3kyZTlPODAvR0xzK05DbFpwMXlmaFlDVE1Q?=
 =?utf-8?B?a2NLaEVUR08vajNMR2tyTldxWjVtZ3VOKzNnNk4vMVY3RTN3L3VoL0RvRDd6?=
 =?utf-8?B?TlIwdHp0V1F1cHV0czZrOWpuWFlPb1VtVEdBWGp0eFlhWDVUSXVqSi9iQzBR?=
 =?utf-8?B?bkp0d01lOS9JYWxkQ05SVVorRW9hV1dvZFZXcHNYcUJvOWZDSDZNU1plS0gx?=
 =?utf-8?B?bnlNbnA4MG9IbVZhUnRmeXBOT3A1elYwZ1BWek1NL3k3Zm9BT1FqUFliYm1O?=
 =?utf-8?B?RlZIeHp4M3dIU29RU0FOSTVjcE1rK3B0Vm5zdXVBdTN1azZSbVBITHNIaG1U?=
 =?utf-8?B?dURtS25DaVF4R3NFbWZsTzdRREpzeTF1ekt0OStPZ0JRdEl5blR2eUljVUFK?=
 =?utf-8?B?cCtGdWFFblBqdXlZVnVWQldnOGlZeWtmUDduRlNreHV3K1lFRXlvbnlua2o0?=
 =?utf-8?B?NkJnRGozekR6UkF4cjBGSkNZQnVqMTRTd3UrN0F6Yi9wUGxTZVpXcC9xdzFD?=
 =?utf-8?B?NldJTjVIeTJXdEdranRsaXY4NnovZmthWFROMEp4RWtvRzZTZ3R2WkllU3dR?=
 =?utf-8?B?Z2JNT2hIdHMyaVNlVnBvSVN4UkNROVR5ZHdwSmZUazN2UytQZXVYVXJ3Y2g0?=
 =?utf-8?B?czdJYWIrcVlwQmFZSFE2MVA1SklJbVd1VktJQ1B4N3BCZDFaelFPRDRJVGdu?=
 =?utf-8?B?QW9yWlRZVStKNlBOWTJmZkdSUjJnaElpUFNKaURQOXEvMSs4NnlvT3RkVzdl?=
 =?utf-8?B?UEJmOEcvYXVHekt1eGN5OUZtMWZxaFMwaE1sNWJkanhOaXhqZVFyNjhBdjVr?=
 =?utf-8?B?SitMamZ0Lzl2SWNhQ3VYVnl0L2dDQ3Nmb25oZENoUjlZc0tnREdHMXhTcWpn?=
 =?utf-8?B?ZWVkcjdzd0dEQUN5cUxpRTFzcUVRZ0pLbGoyKzZMODBjNHNKeDlyV3dGY1pW?=
 =?utf-8?B?bURXT2pHM1BzL2ZGWEZleHZYMUJHZVcwUDlIMno4T0ZQMDVLaTF4ZHpsWkxG?=
 =?utf-8?B?NVZIMnZPVUcwM2l3QUpVV29HYmNiZUN1c3NySStRSVdjakV0NCtnbyt5dnI2?=
 =?utf-8?B?YnM3SThhMVZ4cXczSzQ2WFdLNFp5Nng4RHJHRDNCa1BOVXZWMTZUVnpUcE5Y?=
 =?utf-8?B?bFhBV1pnUUVDNnJ1RXUzS0hyc3ZINDI3Z2tFUW9FdndjY1dxUGxsZFIzc1hw?=
 =?utf-8?B?dGYyTm95T05laEpzc05ZMy9OdXg3SWdmQWtZckF1cWNaSnBWVHhSMVZTSkho?=
 =?utf-8?B?YlVXamRyaVBxU2dhYjlVKzJVT0NyUFhQUUhNUStxd1daYXppMkRCd2tZVjJT?=
 =?utf-8?B?QVJ2a3p2UFFTRVpzcFZlTEJBMVB5TVB2NWpQMEszWEIvbFdwN1UzVnZVUUhr?=
 =?utf-8?B?QTRKSXhNaXV5alRJb0J2cTRKaU4xZGFIZGxXNFViU2dsclNVVys5WjZkdjVT?=
 =?utf-8?B?ZmhhVGtIUDI0aHhpcFNpc3R1cXJTMGgvQlBrMXJqM3RBcDhEREE5NDhwM3VK?=
 =?utf-8?Q?BfbkszN8PpuOSZqULNgswm5Y2qV7OY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUJsWW5ObVBUNUlKM0t0Rm9KUW5LQUtwZW9wU1dpQTkrYjRyUTRiZU81NFgy?=
 =?utf-8?B?ZGdwVm15bDlBcjBpeUlzcGt4QW1RMzMwSGV5bVBzWTZldjg3QXpyVzlhZXFS?=
 =?utf-8?B?VGtzdWlnZE9OejJjRklJVVB4V2NrSkR6a2NtMmJYRUNiSU9wQXYzK2h4ZzJY?=
 =?utf-8?B?L3JNT3FHS3MwUGtqRTdQQldJVE11a3FjQ2JaWGMvWWJuNkIzR1Vkb1NDTURt?=
 =?utf-8?B?ejAvalluaTFUZEx5UzlZTks4M1lZeUVmb2ZsQ1o1MGFaL1dCSk40cEY4cjRW?=
 =?utf-8?B?N3RxR2tRK1hVUENod3lqUGFuazJYVjFWcUhyV0ZFaElDOTF1K1NlS08xajVl?=
 =?utf-8?B?WVM5V3RRNnhjdjZGdVR6emVWWk1mb1IzcGJKblppWkFZeGJiWThKK1MwN2hp?=
 =?utf-8?B?RHNsR2tGeTZaRUhHTU9paVRpWWJ6WkhLYmZCOEg3SUo3SFgvUnArRXFkRmt5?=
 =?utf-8?B?Y0JtSENTZjFsK3lpckZFZWxLQ1d1YTZTQmRIb3hVTVVkYlg3MFJjaDdNSExq?=
 =?utf-8?B?Qll1MTRsbG9zMkhzL244OHpHbUdseDdsNFk0Tk1kZFpkKy9EK05yUlRMSjd0?=
 =?utf-8?B?bllOTjV1YzU1TG5oc3RleGdWZFlYOVdIVlIwcllzelJ5OWFxK1owRUFvNDNY?=
 =?utf-8?B?TlFSZXVZVjBUZlhEd0kxSlBxNzlRNFdOK05FU3VGcTVOQXlwR21xUTFraWk2?=
 =?utf-8?B?NDJDdStCbno1Tk9jTUJPeHJwZ1hvL0RNenBsQWVScUtuZGd0SjQrK1VGbDR2?=
 =?utf-8?B?ZkM1Y1psWk1JRTJvb1dKSmczdW9HY1dWSCtIOHNXZm1tWWR6WkZPQThjMnhY?=
 =?utf-8?B?SmhmdkRid1lrc1ZBN01lOXdSSitQTU82Y0NTd29VbVRmOTZuN3Y4cUZWUG9O?=
 =?utf-8?B?QlpCMWJYbDZORDBhRTNUcmNpZmtNT3E4VGI2QUtyTXpWRDRxcUpWYjcrWG9R?=
 =?utf-8?B?VVZRTWlBSDNNNjhkbVZHSlNMR1ZCQTg5YjRuVG5sVE9kbmswd3V2ZUFqeXY3?=
 =?utf-8?B?L3VhZ2dsNHdKZ1hnb1VOdVVPQ0VJZ3JaMU4yLy8zN3NsaHpUZmZISFhPZ2Jo?=
 =?utf-8?B?WmtIS0ROWmJPTi80aFd6enAzcy9JZjc2UWpKU2VxUFNkUnlTbDZxWXNxc1dS?=
 =?utf-8?B?RURzSk4rNTdrR0ZOUFJ5bnNRbWhFb2xCL05DN1dldExQc3NIV21PbzI1RTRK?=
 =?utf-8?B?S1hIejUvcWJ3d3Q0TGRLYkk1WTdjWHpvTmtURDA2N01vbmxDSGsrdEFEdkRz?=
 =?utf-8?B?ODNxbStEVTYzaDUxMWl4Qlc0SGY3OUFONEdpL3c0QjV2S1lnVll5TkRLVU8r?=
 =?utf-8?B?VHlCR1hCVjNST0QyaEVCSklBcmkxMUZUbEFQQXNBU2FGbm80eWg2VXN0V2Ro?=
 =?utf-8?B?bDJUK25VaWtHWlhhclFqYlBUTnVNVVJ2YWF5SDdCTE13MFN0NFQ1aGJvU1hQ?=
 =?utf-8?B?c1VTSmpsYTIra2ZlZWVNVTRWanFWQmkxR2FDOHZSQTdGRXF4NnVKWm1SK0Zu?=
 =?utf-8?B?QWlxNUVZWmVZeEEzcSszZk96MkZEZGVlOEF0aHpQR3lDSlQ3d0kwTGQ1WG41?=
 =?utf-8?B?T0tUdVViWEJZR0FCRktxM0M3R0t6blBZU2hWQ0crTVI2dnZxNy82MDZhSjFt?=
 =?utf-8?B?aXppT3NFZUI3Vy9rdzlqdWhhQmJnR29mN01PY1JsbTN0ZEdSSHBQVlRDTmNy?=
 =?utf-8?B?VmN2SVU2TUFxSmxDdFhLeWZzZks2Mk5kaXJzaDVzejFuTjY1aHN6dkFIT01J?=
 =?utf-8?B?a2lTYzJXYk9wNmFPU0lkWkxzUlpYa3h1Sll1NENyVUVrYzBOWnVmUUUyZFdC?=
 =?utf-8?B?ajQ5TkkzenFETG40bUwrUEZGMitYTkJrWVBpSE03MTVWWXpKVVZ2cmRYSkQ3?=
 =?utf-8?B?NFVURmladXRqcFVkb2VLSkUxNFh5SFNaL2hFd0MvcHpteUVmbWd4MGl4UXlI?=
 =?utf-8?B?S0VQaUxlaEZMRkRnVm5nTDJRS0FwQUZaYzQwQUI3ZE50SmNjYjFpVkVkamxX?=
 =?utf-8?B?NTREREZxOFBIdVZrQ3JNbEhHNlYwanI1N0RpOElaRC84K3E4enkvVWw2VVV4?=
 =?utf-8?B?dHBReTdPcUdzblVCTHNoNXdHQWVKd1lkUVRXcGhTd3JMYUl3RkRmOEZZSTFG?=
 =?utf-8?B?eG4veTdKb2RZNUVQQW1qY0VLdVZlMWpjb3ZxSkVLTitWdXVTYXcrK25rV28r?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEF84E40F0FE4344BD603D77FDA8EEF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b28d936-adfb-4131-dc5f-08ddadb2abe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:21:45.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQdd3PfzhHzpdIrfUrCBJNqaQUdr0vuXSMNdcv6joy1JZwyle+5OLTWAo6E3u4IF5jQRT7CDJb3VHBBqofTm9vcwzNPUTu+OZglLb2gI4Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8419

SGkgRGF2aWQsCgogICBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLgoKLy9NYXJpdXMKCk9uIFR1
ZSwgMjAyNS0wNi0xMCBhdCAxMTozNSAtMDUwMCwgRGF2aWQgTGVjaG5lciB3cm90ZToKPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IE9uIDYvMTAvMjUgMTE6MDQgQU0s
IE1hcml1cy5DcmlzdGVhQG1pY3JvY2hpcC5jb23CoHdyb3RlOgo+ID4gT24gVHVlLCAyMDI1LTA2
LTEwIGF0IDEwOjIyIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+ID4gPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQo+
ID4gPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUKPiA+ID4gCj4gPiA+IE9uIDYvMTAvMjUgOTo0
NiBBTSwgTWFyaXVzLkNyaXN0ZWFAbWljcm9jaGlwLmNvbcKgd3JvdGU6Cj4gPiA+ID4gSGkgRGF2
aWQsCj4gPiA+ID4gCj4gPiA+ID4gwqDCoCBUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4gUGxl
YXNlIHNlZSBteSBjb21tZW50cyBiZWxvdy4uLgo+ID4gPiA+IAo+IAo+IC4uLgo+IAo+ID4gPiA+
ID4gCj4gPiA+ID4gPiBVc2luZyBKb25hdGhhbidzIHN1Z2dlc3Rpb24gZnJvbSB2MiB0byBqdXN0
IGhhdmUgYSBzaW5nbGUKPiA+ID4gPiA+IHByb3BlcnR5Cj4gPiA+ID4gPiB3aXRoIDMgZGlmZmVy
ZW50Cj4gPiA+ID4gPiByYW5nZXMgdG8gY2hvc2UgZnJvbSBzZWVtcyBzaW1wbGVyIHRoYXQgdGhp
cy4gSXQgd291bGQgb25seQo+ID4gPiA+ID4gcmVxdWlyZQo+ID4gPiA+ID4gb25lIHByb3BlcnR5
Cj4gPiA+ID4gPiBhbmQgd291bGQgYmUgc2VsZi1kb2N1bWVudGluZy4gVGhlIGRlc2NyaXB0aW9u
IGNvdWxkIGJlCj4gPiA+ID4gPiBzaG9ydGVuZWQKPiA+ID4gPiA+IHRvCj4gPiA+ID4gPiBqdXN0
IGEgY291cGxlCj4gPiA+ID4gPiBvZiBsaW5lcy4KPiA+ID4gPiAKPiA+ID4gPiBJIHdhcyB0aGlu
a2luZyB0byBhZGQgdGhlIHJhbmdlIGZvciB0aGlzIHByb3BlcnR5LCBidXQgaXQgbG9va3MKPiA+
ID4gPiAoZm9yIG1lCj4gPiA+ID4gYXQgbGVhc3QpIG1vcmUgY29tcGxpY2F0ZWQgZnJvbSB0aGUg
Y2hlY2tpbmcgcG9pbnQgb2Ygdmlldy4gVGhlCj4gPiA+ID4gZHJpdmVyCj4gPiA+ID4gaXMgc3Vw
cG9ydGluZyB0d28gZmFtaWx5IG9mIGRldmljZXMgdGhhdCBoYXMsIGVhY2gsIDMgZGlmZmVyZW50
Cj4gPiA+ID4gdm9sdGFnZQo+ID4gPiA+IHJhbmdlIGFzIGFuIGlucHV0Lgo+ID4gPiA+IAo+ID4g
PiAKPiA+ID4gVXN1YWxseSwgaGF2aW5nIGEgY29uc2lzdGVudCBiaW5kaW5nIGZvciB0aGUgc2Ft
ZSB0aGluZyBhbW9uZwo+ID4gPiBzaW1pbGFyCj4gPiA+IGRldmljZXMgaXMgbW9yZSBpbXBvcnRh
bnQgdGhhbiBob3cgZWFzeSBpdCBpcyB0byBpbXBsZW1lbnQgaW4gdGhlCj4gPiA+IGRyaXZlci4K
PiA+ID4gCj4gPiA+IFNpbmNlIHRoaXMgc2VlbXMgdG8gYmUgYSBjb21tb24gcGF0dGVybiwgd2Ug
Y291bGQgcHJvYmFibHkKPiA+ID4ganVzdGlmeSBhbgo+ID4gPiBpaW9fcHJvcGVydHlfbWF0Y2hf
cmFuZ2VzKCkgaGVscGVyIGZ1bmN0aW9uIHRoYXQgd291bGQgc2ltcGxpZnkKPiA+ID4gdGhlCj4g
PiA+IGltcGxlbWVudGF0aW9uIGluIGRyaXZlcnMgdGhhdCB3b3VsZCBuZWVkIHRvIHVzZSBzdWNo
IGEgcHJvcGVydHkuCj4gPiA+IFRoZW4KPiA+ID4gaW4gZWFjaCBkcml2ZXIgaXQgd291bGQganVz
dCBiZSBhIG1hdHRlciBvZiBtYWtpbmcgYSBzdGF0aWMgY29uc3QKPiA+ID4gYXJyYXkKPiA+ID4g
bG9va3VwIHRhYmxlIG9mIHJhbmdlcyBmb3IgZWFjaCBkZXZpY2UgYW5kIGNhbGxpbmcgdGhlIGhl
bHBlcgo+ID4gPiBmdW5jdGlvbi4KPiA+IAo+ID4gU29ycnkgZm9yIG5vdCBleHBsYWluaW5nIHZl
cnkgd2VsbC4gSSBoYXZlIGltcGxlbWVudGVkIHRoZSByYW5nZQo+ID4gaW50bwo+ID4gdGhlIGRy
aXZlciBhbmQgSSB3YXMgd29ya2luZyB3ZWxsLCBidXQgSSBoYWQgaXNzdWVzIGRlZmluaW5nIHRo
ZQo+ID4gcmFuZ2UKPiA+IGludG8gdGhlIGRldmljZSBiaW5kaW5nIGFuZCB0aGUgY2hlY2tlciB3
YXMgZmFpbGluZy4gVGhhdCB3YXMgdGhlCj4gPiByZWFzb24gdGhhdCBJJ3ZlIGRyb3BwZWQgdGhl
IHJhbmdlIGZyb20gdGhlIGJpbmRpbmcuIEFsc28gSSBoYWQKPiA+IHNvbWUKPiA+IGlzc3VlcyBl
bmZvcmNpbmcgYSBjZXJ0YWluICJhdmFpbGFibGUiIHJhbmdlcyBmb3IgYSBwYXJ0aWN1bGFyIHBh
cnQKPiA+IGludG8gdGhlIGJpbmRpbmcuCj4gCj4gV2hhdCBkaWQgeW91IHRyeT8KPiAKPiBUaGUg
dXN1YWwgd2F5IGlzIHRvIGRlZmluZSBhbGwgcG9zc2liaWxpdGllcyBhbmQgdGhlbiBsaW1pdCBp
dCBieQo+IGNvbXBhdGlibGUuCj4gSSB0aGluayBzb21ldGhpbmcgbGlrZSB0aGlzIHNob3VsZCB3
b3JrOgo+IAo+IHBhdHRlcm5Qcm9wZXJ0aWVzOgo+IMKgICJeY2hhbm5lbEBbMS00XSQiOgo+IMKg
wqDCoCBwcm9wZXJ0aWVzOgo+IMKgwqDCoMKgwqAgbWljcm9jaGlwLGlucHV0LXJhbmdlLW1pY3Jv
dm9sdDoKPiDCoMKgwqDCoMKgwqAgaXRlbXM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgIC0gZW51bTog
Wy0zMjAwMDAwMCwgLTE2MDAwMDAwLCAtOTAwMDAwMCwgLTQ1MDAwMDAsIDBdCj4gwqDCoMKgwqDC
oMKgwqDCoMKgIC0gZW51bTogWzQ1MDAwMDAsIDkwMDAwMDAsIDE2MDAwMDAwLCAzMjAwMDAwMF0K
PiAKPiAKPiBhbGxPZjoKPiDCoCAtIGlmOgo+IMKgwqDCoMKgwqAgcHJvcGVydGllczoKPiDCoMKg
wqDCoMKgwqDCoCBjb21wYXRpYmxlOgo+IMKgwqDCoMKgwqDCoMKgwqDCoCBwYXR0ZXJuOiAiXm1p
Y3JvY2hpcCxwYWMxOTQiCj4gwqDCoMKgwqAgdGhlbjoKPiDCoMKgwqDCoMKgwqAgcGF0dGVyblBy
b3BlcnRpZXM6Cj4gwqDCoMKgwqDCoMKgwqAgIl5jaGFubmVsQFsxLTRdJCI6Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHByb3BlcnRpZXM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtaWNyb2NoaXAs
aW5wdXQtcmFuZ2UtbWljcm92b2x0Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9uZU9m
Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGl0ZW1zOgo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IDAKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiA5MDAwMDAwCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC0gaXRlbXM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLSBjb25zdDogLTkwMDAwMDAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAtIGNvbnN0OiA5MDAwMDAwCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC0gaXRlbXM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBj
b25zdDogLTQ1MDAwMDAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAt
IGNvbnN0OiA0NTAwMDAwCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdDoKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXRlbXM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiAwCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAtIGNvbnN0OiA5MDAwMDAwCj4gwqAgLSBpZjoKPiDCoMKgwqDCoMKgIHByb3BlcnRp
ZXM6Cj4gwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZToKPiDCoMKgwqDCoMKgwqDCoMKgwqAgcGF0
dGVybjogIl5taWNyb2NoaXAscGFjMTk1Igo+IMKgwqDCoMKgIHRoZW46Cj4gwqDCoMKgwqDCoMKg
IHBhdHRlcm5Qcm9wZXJ0aWVzOgo+IMKgwqDCoMKgwqDCoMKgICJeY2hhbm5lbEBbMS00XSQiOgo+
IMKgwqDCoMKgwqDCoMKgwqDCoCBwcm9wZXJ0aWVzOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bWljcm9jaGlwLGlucHV0LXJhbmdlLW1pY3Jvdm9sdDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBvbmVPZjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBpdGVtczoKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiAwCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogMzIwMDAwMDAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBpdGVtczoKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiAtMzIwMDAwMDAKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiAzMjAwMDAwMAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIGl0ZW1zOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC0gY29uc3Q6IC0xNjAwMDAwMAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC0gY29uc3Q6IDE2MDAwMDAwCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGVmYXVsdDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXRlbXM6Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiAwCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiAzMjAwMDAwMAo+IAo=

