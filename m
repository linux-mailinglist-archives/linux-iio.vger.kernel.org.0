Return-Path: <linux-iio+bounces-9624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E297ABCD
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 09:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C511F237ED
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA4E14884F;
	Tue, 17 Sep 2024 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="mVFMlbnf"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB184E1C;
	Tue, 17 Sep 2024 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556803; cv=fail; b=UUh3iZwau6EmXeUwuzEwcrP/Y8jZNbHo4BNyK3USjJ/mCVeGfbk0cV9tMWgbE0gcUD2JDd5x+kHW3ULtGhPgpZYyG5/uUMy+Ded+HxByuW5fSoK9uQWoexaRVUxVGM0eoJNSv5XhEEb6rONzSVmGYdl3RiQj+NGCf53UYE/dptw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556803; c=relaxed/simple;
	bh=1ritdrXikZoblSgnKKA7h9auE/N19oZramJUGM2oIY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvWmZubykRhfymOu/PXIwgk9KY9WOkA8rkvohhSQDFYf6NPz6Pn7x9teXqCAXH1NWPxMho0c/o+SbgEuz9aSujd7JvJ6bukxD1EG7D49DDhBqYeDFsUz4GJBiaYNQ8FsB6l9W4z6UQe9gH3exd/mu/IyK3BP+nPAVazYPnL2ap0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=mVFMlbnf; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO6k/0QYta+3DjpQ6xyn8C5N8If7FluMx3MPzG8u02aIIOtRYsb29c7PcNMwY7zzyLQzWauM2cvUHUVPgmTJNK5kip+Sl6DML9CfD/lOptZ8Mg5vXJd1ZvVGS8bwogrcL5UbAgr84KJ5fIP4yINH/VRIBRinh5UAzT69uVkOrmVCa/RmrNh7780Nva6yB6UCy2Lo1YN0Ueegw4bi5lCZ+jee5jZ7LcaaLjcR+6nQuN+Hs+ux8zV3+MugecgSE3xr/ZdSzT7jSWreshySWCdanzeW2gUwVsFmVzKwDZv0hcFwXbv/XpC5INyVJvlVtNwwW01LBE7rn5Uoml5cIzLb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ritdrXikZoblSgnKKA7h9auE/N19oZramJUGM2oIY8=;
 b=xlUfM6L0QoBU+LW1Gupdk4fnXJG6FIsJC1qXlJQn3m0L4e3+dVfWS6NHN0oeFSNIHq4rrx+LXTYTW+GP9Jnh33fr9r3TUz2rDSOyjRX6tefWMkRKs+Uycg6LAeB3/5AkY+bo8vZDWw1PFnu2YH2LlxfkV6SmR9h8gY/ynUmMvvKmo/LmFX0XBgT3LW4nnyBe4FWuqnsgHXRSrAioz3FicbBEM7zmbD8p+OIYnwdOxZgdz6XHaT7xXKQ46Iwg3H2qH72CM+F6f3rvoaN4ojQJMq/kyGQEONrcn3ND8RdNDD54J0a8vMEKIt5MzdtytOyth5KGv6KeUe7KsB7Xotzaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ritdrXikZoblSgnKKA7h9auE/N19oZramJUGM2oIY8=;
 b=mVFMlbnfnTBBL6195WuiNbqzBy1pSvT26WZFbXoaCoQ2kM9k3YPc/4Kn4dcBS4+lPRcDlPMbxF0mwxS/cKXefzzAvMqhm/vB78+Mgb4zZ5zGPkF8pLYFJm/x8AXMzBcqdI5tDDFyCCA+/XkEEspZon6WgnnVVmWJwTyr8EurHeA=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by DB3PR0202MB9202.eurprd02.prod.outlook.com (2603:10a6:10:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 07:06:34 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 07:06:34 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>, "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Thread-Topic: [PATCH v3 2/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Thread-Index: AQHbCEjIdfDSPyDQmkW2YV/5V0u1zLJaiIkAgAEHJoA=
Date: Tue, 17 Sep 2024 07:06:34 +0000
Message-ID: <d04a25a90d079bbf973e09df9e1ac562aa8b4fa3.camel@axis.com>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
	 <20240916-add_opt3002-v3-2-984b190cd68c@axis.com>
	 <20240916-hardcover-vertebrae-1ca1fd387daf@spud>
In-Reply-To: <20240916-hardcover-vertebrae-1ca1fd387daf@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|DB3PR0202MB9202:EE_
x-ms-office365-filtering-correlation-id: da5e4456-b9ee-4c06-80a4-08dcd6e743c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1pTcXRxTEcveXBDRkovbG81M2RNRkpOei85TFZtOHR1aEhMR3V1WWJmVGVB?=
 =?utf-8?B?dmlIUWFPdTdzMjR6Y3QxeDFRekV0Q3o3OFlkR0dZS2FnSXBrdmNlSkRUcGJG?=
 =?utf-8?B?cXpuaTRaL0xlUUJzbTc5Yi9sbFlkelUwWHlRSW5BMTByaWNDRExtbzI1TE1U?=
 =?utf-8?B?aUxBendqTlR5dHUvUWdUV2pQNmJjcnM4VENJZmUzbDVaR2wyd0h4UVFwOTBy?=
 =?utf-8?B?UTJ3WXBEUTQ3Y1FTZ1p4NGNERWlEQzRFS1NWbEhGakRjRTRlaFF1NTNtbGRD?=
 =?utf-8?B?RzVrVU1YR1F6bGV3czRvRXRibkFRSURTTldWMVA1cVdVcTFBUEUvdXVrell2?=
 =?utf-8?B?R3VRZTRQUVdvcEdDazhRczdDZC9JNFgxMHhobHNhWDZuQkY3cCtLcnQ1TkFQ?=
 =?utf-8?B?Yk9nYUJ6VFVINzFSeUQ2SE05YkdGamVLdlhzNHRLbnp0K081VE1zN2k2aHg0?=
 =?utf-8?B?WGh3QnMreXFkK09jOFlRck13S3dDZUdqVHNNak1qUGlDcUhIZXJEd0Jvdisx?=
 =?utf-8?B?VGJ3TWd1Kzlqd2o2NlNJSVlqRFQycWpYMmM3d3czeFAvQndyRHVxT29weFZP?=
 =?utf-8?B?MWs0MXBWWVdiMEZ5TnlWNzJ5QU5KMEZSMkllaWZTU1JsbEdVR0ZSSk5CMDBw?=
 =?utf-8?B?U0RMeDRvMHVVOVRVbE1HdkhWb3ZZM2JZYzFKUEZEQlpBZHZZRDNxNVRhYzgx?=
 =?utf-8?B?Y1ZsK3RoTFQvWTBaSDZTb3lvMDhvU0Rva3k5S3UvbGd4YktBRFZDRGhIekdY?=
 =?utf-8?B?a2wreVJabjBtN3p5WkdZdzdSTGEwdGVzSFhLYm9lZDZvNm9MM0tCQXU3YWVq?=
 =?utf-8?B?cUZOc2NIWEM3Zi8vQVRJajhWV2sxZnNXNGlTL3VibWRQTGw5VkZmRDVDMzli?=
 =?utf-8?B?aEF6T0dDYXhjeVhoMVdpeWpZZ2l1aURPSnkyVkxjU0YzMWh1L0RjSm5QU1pG?=
 =?utf-8?B?NlZlYTdydDNGNFV4czJlSWhLK0tyQ2U2c3BGeFREMytrVXQvY1BKQkhhN1Ji?=
 =?utf-8?B?YURBY1BwOXlnSVVxbWZSaFBHY3ZIUVJ5YjFRc3NHYnEzbWdwVDQwNHNNcXFG?=
 =?utf-8?B?T1pwcDhvaFAweWFINnVPQWljTDYzR0xkWFJZRTl3cnFlVzZuUGpQRXhUa0tR?=
 =?utf-8?B?OFNjc2ExcjNaZU1IZWNMZFJtK0l0OUJjQjhSZVdiVG1RRk1iSWhrUjBoQ3Vt?=
 =?utf-8?B?Mmk3TjNrT2NGN3JTdzdxRTlHRHNJQnpGalhwVUI0MmVJN2xCdmxVcEtYNnRn?=
 =?utf-8?B?dmNwek1kdTVZeXVFa1FvYlBhcDdjRWhkeEhuZW1Qa3FwRGVJTEJwRTdjaW9I?=
 =?utf-8?B?SnVreG5JNmc4N3lvK3oxSE5JSWFiUlNwWis4MWtVK1FobXg5ZklHdC83NEUv?=
 =?utf-8?B?dVRFeWplUVkycU5JSTYyMCt0MTMza0dDaU5Vc3FXZUE5ZVgxWDRKdUVXNWxV?=
 =?utf-8?B?ZHNwSW44NkZKc0ZOWThURE9mcGFoQWlucHdBWmVtU1lkQ09TY1dxY200Q1pG?=
 =?utf-8?B?Yk9tM0dtS3FOS3dtLy9YSVQ5cHJYQ09sa05MRTNIN1J2SjVYOXdzT1dZRmFR?=
 =?utf-8?B?aVJQVXNwL1JxU3JUdUp0V2xQNCtJczFBcTJ0dVlDZkRUME5FeSt6YmZMNDlp?=
 =?utf-8?B?MVI1WnJMNTQxTmFqWGFMZi8vUmNFL0Q3eW5BQ3U3U202RENkYnVyTFBQeGk3?=
 =?utf-8?B?QlM4a0hnbFFuUlVrb1dSd3lwaTh3SWdLaEFDNGZTZjQvTzQ3Z210RWNCcHM1?=
 =?utf-8?B?OUpNR2NEd0QyWW5yMEhtVkhTTnU5N0w4dTVTME82MDlac1l0elAyNkdtU3V6?=
 =?utf-8?B?RXRhL2hQeUZGQ3V4N1l3N0hRMkJ3QWswVjZRR2pxTWQyUHJRY0VJV1EwWkRB?=
 =?utf-8?B?L3BEbHN2MmFvekJUVTFyTW9jQjhhS3BCdHNValZoKzNNVHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDEzOVJUUmtwMmFnUDRhWW5NR1FGM0dWSUU2TU1YZUNUUEdDaU5PUXlwTU1Z?=
 =?utf-8?B?VG0wSC9YWEszQzd3dE92c2NXRWtrSXFaVlNGMDBvTEIwaTQ2dVZBVE00dElW?=
 =?utf-8?B?VHoxWENDa1MxUkFybTRqUndTcFlmR0tnSWJZdjg2SXZqYTZnUkdRY1lhRVpT?=
 =?utf-8?B?Wi9MNllxZVhLZzk3bnBJbW1vM1RSNVdIZkRrSG92RngrcFVncnczZndLa2Nx?=
 =?utf-8?B?WlFRRFZEOE9xbU1FbEVwd2N3QUVaTWt1bEQ5TmlyMTA0VUJWZVBUbmhuY3Rv?=
 =?utf-8?B?aloyOHNkL1VGS3prSmM5TXVIMTNBNTJ4cElmUkVqTyt3NzZhK3NjWDNRTWFM?=
 =?utf-8?B?ZDBYZVUxdldSQW90TnhVTFpoQmRudS9uY0wzdFEzQ2pDSGdmQTAxS0s3QlJp?=
 =?utf-8?B?QzFsY2RGbUlrd0NMaDJLMkNJcU5jbzVPM0MvQThSVmgzL25COUpIUUc0RXdD?=
 =?utf-8?B?NG1pOWhieWpGOWNYcVdxM3FCZ2FqbkM4Yml2bzlmcmMxeUNZRU8yY2JoMFFX?=
 =?utf-8?B?SWpyWlE5T1lnaWdDTWs0MFhxaHJYTUNLaW1Jc3lueXBaSmlFTHc2WW9PQjVP?=
 =?utf-8?B?QmdLdFFZMDNYQzY0OTU1OUV4c09YZ2NrdGxneFRFY0lSQkk0VXFINEtjTHli?=
 =?utf-8?B?eE55YjZDbFVuNGd4aXFrRGRYc1VmQW5MU0IrdThUZkFEdUU1cHhuVVNtc0c5?=
 =?utf-8?B?Wm1ONzFUaXhPR2ZXQ0RHUVJDUDFNbFFXNUJQMVluUkx0WFVITXFTcXo0SzdL?=
 =?utf-8?B?VDY5c0ljM0dUVXQxdGwzOUJxajdBMUNwVGlVV1dWYTd6QjZ4QjF4aWxOaWxQ?=
 =?utf-8?B?M01DOGZub3ZNNTcwTU0rVGp3Q3JUOUViZGsrcEhwYk1mTTYvZk9sQmtDL0pa?=
 =?utf-8?B?cVlENjd6WWN6RlM0a2NvajYxTUpzdm9ZMDdxL2hxQnVicEtNaFBYSHljOTlS?=
 =?utf-8?B?ZzBNbDR4VTRIUUJxbkk1VkhOVHQyeFMvUWhzVms2WVd2ZmFSWE5aWTliQnhq?=
 =?utf-8?B?aTNGR1Eyb0k0d3ArNnpFRnc3QVNKb0RHWEhHeXpqUDBLYkRVV00xMHcxZ1Jj?=
 =?utf-8?B?ZjFoK2tWMTVWZW4xUVJRRkUzcXJUaWJpS1Y4akg0K0R0MjlMMVFOYk03TEQ3?=
 =?utf-8?B?dnhFeGJrVHpYQ3FWTnpldWJ1RW9kMmlNUkxjSHJMWXpKWkNOY1BoeDNIZ0tH?=
 =?utf-8?B?UDZPYXFON3VuNU15VElnNmMrd2VaNHV2ZEprQ0RuS1duay9McXB2ZjVhakw0?=
 =?utf-8?B?eTFGRFg4Ym9RYkVWNW1mTFI3Y01qanhINk9PMzQ3cGdXSlVBYVJ1amFMaFRJ?=
 =?utf-8?B?YXAwbmQ0YzRhMCtQOExFbGxFUC9TWll6MG9Bbi9tZU05MFpWZTh0aktsaElH?=
 =?utf-8?B?ZEViaDBwZnplV0NqejFZSG8wSzRKSWloMXFFbWdTcEQ5VWVNNjVrcGswdkZq?=
 =?utf-8?B?V3lYYmZGNjdHS3JSNzhyMnlxSnBUYTE3TXhwWnVSTmoranRwUEZ4N2pQZWtN?=
 =?utf-8?B?Z2NLM1cxNFl5MTFTc09GZ1NsVmxhNTFYZWUxcTFOdUFJb05GalpQeC9HWGY3?=
 =?utf-8?B?enZycDNob2FlUFVuUytGUTdGdGE1ZVQ0d1ZnQmRvMUNVL2xmcTJqeDBsY1lW?=
 =?utf-8?B?WUtQMkFCeUd3U3ZKZW9yWVN6WDlReHNJaElYUUxhTGM4N1RlTnNWYVVTTTFq?=
 =?utf-8?B?WmtPdVlZVm9vaHdzMnBlcFowZHVHdHNNVytIYzlLSU5ZaVgreCtta1dXYmd0?=
 =?utf-8?B?UUF2RC96TUc4VEhOeXV4MUk0bzU3RnFCQ2hxSTkzR3Q5eXZMQjVleGFNaDdi?=
 =?utf-8?B?b2x4bWVNbFZYMzNiWHNmanZDMHNpZ28vWHhEY0ZHU0hqVHFaRG5EYmpudE13?=
 =?utf-8?B?dHNLb2VicnpUQkdiUDBLckF6ZHVpNld6OFdLcGpZd3ZJREU0Wkt0ZFo2Rnk0?=
 =?utf-8?B?MVRGLzNrSUxkV25CbVRtdm9IR05XY3Jyd3FpU2FaRWYzYVlqWWJzSG1Dakc4?=
 =?utf-8?B?TnJFd0YxTEdoSSs3ZFdWY0hJUzR5S3pBNnhVd2hHbGo5Njk5a0R6NitZN0ND?=
 =?utf-8?B?bUliTldFSURHNEhQUE50VVNlbTZpbWl2T2JjMjJNUjBMZG9kYzZ5UnVPSzZi?=
 =?utf-8?Q?rCwFkuNG6YLfjMf+IkSOJrCVu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DECD89FC28B1A4287D57E8B5434ABB1@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB5784.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5e4456-b9ee-4c06-80a4-08dcd6e743c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 07:06:34.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMaVnYri1pc634NObC7jIPNWLr1hD6ml7VCQ3wAmu7sXPM/CnVIlW2cEt/27/4zx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9202

T24gTW9uLCAyMDI0LTA5LTE2IGF0IDE2OjI0ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIE1vbiwgU2VwIDE2LCAyMDI0IGF0IDA0OjU2OjM4UE0gKzAyMDAsIEVtaWwgR2VkZW5yeWQg
d3JvdGU6DQo+ID4gVGhlIG9wdDMwMDIgaXMgYSBMaWdodC10by1EaWdpdGFsIFNlbnNvciBieSBU
SSB3aXRoIHN1cHBvcnQgZm9yIHdpZGUtcmFuZ2UNCj4gPiBzcGVjdHJ1bSBsaWdodC4gSXQgc2hh
cmVzIG1vc3QgcHJvcGVydGllcyB3aXRoIHRoZWlyIG9wdDMwMDEgbW9kZWwgd2l0aA0KPiA+IHRo
ZSBleGNlcHRpb24gb2YgaGF2aW5nIGEgd2lkZSBzcGVjdHJhbCBiYW5kd2lkdGgsIHJhbmdpbmcg
ZnJvbSAzMDAgbm0NCj4gPiB0byAxMDAwIG5tLg0KPiA+IA0KPiA+IEFkZCB0aGUgY29tcGF0aWJs
ZSBzdHJpbmcgb2Ygb3B0MzAwMi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbWlsIEdlZGVu
cnlkIDxlbWlsLmdlZGVucnlkQGF4aXMuY29tPg0KPiANCj4gUHJldHR5IHN1cmUgSSBnYXZlIHlv
dSBhbiBhY2sgZm9yIHRoaXMgYWxyZWFkeSwgcHJvdmlkZWQgeW91IGFkZGVkIHRoZQ0KPiBhIGRl
c2NyaXB0aW9uIG9mIHRoZSBkaWZmZXJlbmNlcywgd2hpY2ggeW91IGhhdmUuDQo+IA0KPiBBY2tl
ZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IENo
ZWVycywNCj4gQ29ub3IuDQoNClRoYW5rIHlvdSENCg0KUmVnYXJkcywNCkVtaWwgDQoNCg==

