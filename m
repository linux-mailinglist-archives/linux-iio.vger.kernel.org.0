Return-Path: <linux-iio+bounces-4834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85858BCD06
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DBBB21C32
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4090C6EB51;
	Mon,  6 May 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="CnVt+EZb";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="CnVt+EZb"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022019.outbound.protection.outlook.com [52.101.186.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395201DFE4
	for <linux-iio@vger.kernel.org>; Mon,  6 May 2024 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995842; cv=fail; b=aAX2LgGhc24+KP7npSf54VdLw7gyECtHKTT4EVdjM3vzR/MiBDpnt32yphHVJo0QEcckCX5R25OFZjwaw/sJivB4CZShrPuoOmwOeGkVKBAnWE3TH5BIpR1uBmhqn/x0EqvqB9U54zCjVTMMUxH7XbxfPz8pUtYj3TpVj1tAvqs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995842; c=relaxed/simple;
	bh=kHRov5QxNfSL8hQEDlblPHZt0i/2hBmS+IoA6dI32AA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QycijrSnY62U66kiS2nZYwSnKG0GOk0FPuoBD/9k0In1OJTEzJSjxFaqP6np3AB3ec7IharoBGyvM5/9luTS4KvDKC5qIXs3rVdyQGm7WZ7j2p61y5B1CuiKXHW1bAyhK33IrDdz2ZCsZ5JYnB9/Xc6a9tDd+6BG0uR4mCn+s0s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=CnVt+EZb; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=CnVt+EZb; arc=fail smtp.client-ip=52.101.186.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=fUQzgJYZW84IqLg1fvCUwCH67clCLi/cHbyAtH6qrdXZVhgtJFYclTfjmSuid/H2ydhpzZ1qCCoEhKP1SrQro/38YvIgZ3OQ8lOzUaZxtfQ0pmHXRf6KTj7dj3Vjqf8K67BhBuibE/evaWu2cluGW/dODnRkRujAXHTNbiENvXWSKQz+qMW2OAbet4VZ4SdThnQujmRwm210ZNcysEWYFh5hRe+6o/38xBq6Ed3qz+tAwFzEQIbkSEoiZejI1w4voUACslZXZaZ1TTsPdzCZUGq16PMNkzmXHoKIauQklfndNi1le2ANeDkpUszhdBmxDFjV7dpzi/JJc+RFFDkkPA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh8PC8fxrdGGFChO8Z32Gh0ibOPKVMRmJZqXGbL3Ljo=;
 b=cylAmIv4UJ+HC+GeoblvKMjSVB1HIxNHcdaar9DyJ7xX9IdyGS59bDdFkoVJwoYIC/ah5iIy3WpCfIAwOsf+l5V5DjuehtIdbiyTP+0w+2VBNtJJGt5THPZ7tlOlK6ZM1LnM8orSES/Qgug98I5PbiMxX1ulcKhYnZIVLS7/wwMU+BKfJF/rMNw223AkPdqzRpBxUwHoJkzpHZCFQucrPlP0m8rt9oRiMfpcBkvKH1ScK337CYPQbQfMu7K0wxPWbiHymU5Xspmun1ZH9/ellAjZrOCYus+AScKAEJFY1azauJBk9rRgotEeT98ga+0w9uTHpbZidzTOf2c5zjEmAA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh8PC8fxrdGGFChO8Z32Gh0ibOPKVMRmJZqXGbL3Ljo=;
 b=CnVt+EZbR2mHkTjcuTtSS/GFMs7j3IedkBDL7ts/nT8qj+cS+c/QsI4sDsjLXBSL6KlV7ZImARcVeDr5X3wOm9DK0STkPuds+ixuPOg3lfYoPUmHerVsyAqxbLbnwJgSQWmA84/Uf3UUu/RbKc8R6XbgyrgiSLVrJbg7qkVDS3E=
Received: from DUZPR01CA0143.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::8) by GV0P278MB0968.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:54::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 11:43:55 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::2f) by DUZPR01CA0143.outlook.office365.com
 (2603:10a6:10:4bd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.27 via Frontend
 Transport; Mon, 6 May 2024 11:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 13.74.137.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.74.137.176; helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 6 May 2024 11:43:54 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.10) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 06 May 2024 11:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbRRzP8RFw55LC3kqSuZIMyrP7+51GiTdAtap9quxelpiEwaJbhr0vOhV9AhCsa/2OKHgqIgMjoAZEkbvOS0Qz7Lc/BpV7wTH7wk4ggYu1ohsqQkyI9/wAiVmpbnEod/dP6ib9Uuf4ELMaqVBjkR33B0pP5d5pAP2YF7zR6L2+JG2vgiAGjAxikREWPycO2JbKSVLQTvHCO2MDrKsJ+Zgwg5R6FtkKgvLNxH+Mpe7zPqqEAGQaXWm2fiVRTJdxKCJaTmNsT/9bboLxdZa0EvBz9RLcp+8qP6USjBuoVl5pgiu8cy/HkxFzPcHLEAeluDtRvHW4qhpKqQszq8xMVPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh8PC8fxrdGGFChO8Z32Gh0ibOPKVMRmJZqXGbL3Ljo=;
 b=HoVwHnisp/RAszAQo4xZHpgdxTvpd9coILOPn1JsdPfxzgcufPtecGIwMQ/Ojuv76qwJXsvRbK3w7TVo9etJSxgISe1Wgy9UAg8G8NN0csz6Nw/IaoQBVQ/uoNlUaEhAGrUP3f1hSiJPsuVlPCjY/bQ9jDYbBpniR0wJpXqzMkfF2Cu7qSinhgaJVy5hytUx5KrJU7rE2Q0Q+SKnVHX01AkEPbpNY99HzO0Y/ujmiJNut5yw5napasz6Wi9FG8CfcQO/w70rijwErQlvZTPRcI6HoIAxNIdFAa5OHlAj1r9vAk3ZjhhDKGB5Ut+PFhHD62MI5g0tLTNbu8RfkcY5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh8PC8fxrdGGFChO8Z32Gh0ibOPKVMRmJZqXGbL3Ljo=;
 b=CnVt+EZbR2mHkTjcuTtSS/GFMs7j3IedkBDL7ts/nT8qj+cS+c/QsI4sDsjLXBSL6KlV7ZImARcVeDr5X3wOm9DK0STkPuds+ixuPOg3lfYoPUmHerVsyAqxbLbnwJgSQWmA84/Uf3UUu/RbKc8R6XbgyrgiSLVrJbg7qkVDS3E=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by ZR2P278MB1053.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 11:43:52 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 11:43:52 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH] iio: light: driver for Vishay VEML6040
Thread-Topic: [PATCH] iio: light: driver for Vishay VEML6040
Thread-Index: AQHan6iN9MdWOVBjQ0y2Op+4FC4vyw==
Date: Mon, 6 May 2024 11:43:51 +0000
Message-ID: <ZR1P278MB11173CC7CBE3840843443776811C2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|ZR2P278MB1053:EE_|DU2PEPF0001E9BF:EE_|GV0P278MB0968:EE_
X-MS-Office365-Filtering-Correlation-Id: f43e020c-5681-4000-61bf-08dc6dc1cf04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?nO7IUjZOpFLlf/ZgLdR378Ozz3krgMJScJJA81HOeSgukyVDUrSxbU29ir?=
 =?iso-8859-1?Q?H8/z90EeADcTXu5xbu3nlzdP1ZRILI/N86TTpNxbXPbq5P4mWAoo3W2oAq?=
 =?iso-8859-1?Q?9NMsRDSfT7QVjnlTTL7EqaYwc5YdYlx9kHcBKmQuJ+b8E0qEUf/i7GHnCi?=
 =?iso-8859-1?Q?F5DlYO2tspjvuNuTy0YerfGEhuOUQUEj4cgDR5PPZLtYKkadiH6nHJQFZV?=
 =?iso-8859-1?Q?cec875y2BBEZlJApvp02zK3U4rgoirMpuHviJqb5q/yfep/0Ls2Qr6wgBg?=
 =?iso-8859-1?Q?F4uJ7snoDPq20a/R+zTWmdzr0E6NNMw5AzQ//TNaglW/kWYSZ3AqTyRW60?=
 =?iso-8859-1?Q?EcVKk/x6Mqt09WcIqjMi03pJp/i0DoxDS/fDj5T7RRKTOCCv2DIuF0PwFq?=
 =?iso-8859-1?Q?UBlt7n+usdu87jjURutwxtSZ481LeLJRVUlZiKWbK4/NBd1jc8WJdzsAiJ?=
 =?iso-8859-1?Q?idHZ/6pRygVTJucdJkZebe4AbUyARlm/5zdSs87PFA4IbeJUFBNurtjrhn?=
 =?iso-8859-1?Q?joPY5GDznOAvz4FfoO9khe/9mi7ziJWMf0MDkiEJqUsZLh2uVAP+zdeRgQ?=
 =?iso-8859-1?Q?T8wRS7IvRhbKss0K2NhEOvahfwyOmSRa9Pv4dL+OHCzUadSnzBRCaIOg85?=
 =?iso-8859-1?Q?LHEHMC0IB2ZrT4BCH9VPfqe+7t898bfbNgieUNDZfBEhOmBqyz3Nhy9qdg?=
 =?iso-8859-1?Q?PZTOzDjaXeDXhVF7fgEPlNZ+DyxBX1ObWPcaICzo6Sch/Z7+F5Lpv6c3Pd?=
 =?iso-8859-1?Q?2NMvM8b6DOWtOCz2Nny4W8samn/1Gpke6GWeK8zOUPh27YxuTOJG1ciy+m?=
 =?iso-8859-1?Q?ayYNlo4A+WVSvlX0Mnc0bRkDljC6DzUBZfwd8dEMeISxl6L81QbaP4t5jU?=
 =?iso-8859-1?Q?XgbT5nEVSnaAweq30ZFHMccIvCiLJi5LQQZXvshNVOIHogHJ41N8FBWSoN?=
 =?iso-8859-1?Q?ADk/VD7E9lMxFfrkyblyYfwzXUBmOysOddayn/Fj3uQENf72iOwfzV8mSi?=
 =?iso-8859-1?Q?s5gslAOQqbtNHWDSJTMq5rC1BUiFbLlEUDcKi1k20BURI1NID43JWZXlFk?=
 =?iso-8859-1?Q?UN+ntqStDZW9chNEtqxuf/3DB3UeMXqTCK7rf/ye2cLDxzML9iz6r5NR2C?=
 =?iso-8859-1?Q?InZAErNlc5MPzS1jRE68gcaKqH4arqCdmDnRzSN4W9N3I89W9sZ9LcNBwv?=
 =?iso-8859-1?Q?sxEl3HQe85Wa6dLtDK9wcMmhKm5ZPl5s/M+o+gLBoyVkTf5Hq98HhAAFhU?=
 =?iso-8859-1?Q?lwGFJJK8DYTtWel+QSJWDj4PL0eWs7oPJ43dnJ+iK4dKXcSFXpd9dBq6kK?=
 =?iso-8859-1?Q?YjIsnbmLtFjqDnbMlbxr7nLc7Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1053
X-CodeTwo-MessageID: 902d3f41-4d8c-4a18-8fdc-8b480f0bca37.20240506114354@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	896c6b24-6ea6-44dc-229f-08dc6dc1cd44
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|35042699013|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Cwrt5pr5riMBX6MmLl1W/Oxglpvo0fgLBU/1904Ds+KwnpsOOmseQaK1Cs?=
 =?iso-8859-1?Q?0+/EHUycACxunefjrsJEZjD0COc3pYuKE5kQR/uKN5xuUA7552nENHbpTa?=
 =?iso-8859-1?Q?hPz//90bBU/9u+HGfUOMFpGG32Y5Oi33nHWTEM8mfnlKsmO43buUYB6mwq?=
 =?iso-8859-1?Q?zainW6fE//bjsrB+tlbFXma30H35qoKv91uPJ7hg35ZwnQ+Nzh56I3NYDn?=
 =?iso-8859-1?Q?M3xZ8VxnKUSx/yD6JavYeoxVwm1/Ugp+9lm6XFXVTKeg5iPNO1p8K6mCtd?=
 =?iso-8859-1?Q?g14BCtu346CJrF6bwGzZua0vMnYrmeIJIcAIvGsIQYIzDBuoPC7Jjd5zil?=
 =?iso-8859-1?Q?d8i6xJrxNOQv2brXmYqT9MGiq6hlQ3WU1Ngw7YQ/XS/1oHHlC5ukuZa6hq?=
 =?iso-8859-1?Q?cEC9tUtXBAnF9+KrqaqErgFTSEOnDzLIoQ5AcUDzNA31zrCBKrqNoc29uX?=
 =?iso-8859-1?Q?wIeMG2qofCc14uQck5BFBPGM5SSEuqRy3aBEdjs7TwxgwJDcdo8q70+1pq?=
 =?iso-8859-1?Q?pv9vrLgIKAGB4ZqHcmoUEda6Qz4SimgmuWojQKmqVDPA2SU9rbvDW1UzUO?=
 =?iso-8859-1?Q?jLF0SrBnrgSqk/NC26l8JjfcfAqQ6GAXLbhsUGSn3cIwVRaZ9/6zPMVKgS?=
 =?iso-8859-1?Q?b/M6xjAkcBit9O0DrEE7hQ1rrayTal8SX5D5RaEUPVzhrJXaUwFFbPOl8C?=
 =?iso-8859-1?Q?yndeEm/JP4VadFajgZfCVwV3k4jNxzH3BP6s+shWI6MZetLjnbSnOELrkk?=
 =?iso-8859-1?Q?/72z65Iq7qYyh54JECEaf4qxAf/MNDqU/xdaa3tX3ErUU2GBCo9h27pp+S?=
 =?iso-8859-1?Q?AkzHVBQ0eYWORGbdW9czjq6M4zpqSUfyYaAN4cAywJcq+BywdH4FYTI1lI?=
 =?iso-8859-1?Q?h3sVD+f7PnLNbeH6dkWzb+LgEvYOsqbO9fmIvwaLXJWsVpZS8lwL6glMlI?=
 =?iso-8859-1?Q?5kzAl5vJ9VYNeWlJKo5iG0eHXfsiIDiS8Xg7T77pSNDUWJsgLiYrdS2RHN?=
 =?iso-8859-1?Q?uuYozX1MD4zeUFAaEe9CduNL/3Mpd0RRnlNMd1DO5lnSImaWbmeNsEyOZr?=
 =?iso-8859-1?Q?xGNhbyaFMBlZD7rlAjvXxpTILcb4TtZ2YVxhORo39s03bRhHa8evFt2cHp?=
 =?iso-8859-1?Q?gmdPjz8QnOYYUdlgZ6CBiCJ7oA3iR07Lww1xlUDSfjLHR2L+4M6tV0utjI?=
 =?iso-8859-1?Q?OXL3kfS9qDJTQ+eF8qzmbhCzmUQBWc/oVRAWfVMWarPFqJE3x4C1Lj16Ie?=
 =?iso-8859-1?Q?pZXSffk7yxgQpR+mUJt8XUXuL0Uv0IWcgJaz8+MESFmXdsOtKsHNU8k07B?=
 =?iso-8859-1?Q?0QsBhM48vD0dbo57y4hN/CATnCIMBciWXfu/5lWbtiiBb2XK1rVbpy1NNI?=
 =?iso-8859-1?Q?4Iejet0MXL?=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(35042699013)(82310400017);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 11:43:54.8429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43e020c-5681-4000-61bf-08dc6dc1cf04
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0968

From: Arthur Becker <arthur.becker@sentec.com>=0A=
Subject: [PATCH] iio: light: driver for Vishay VEML6040=0A=
=0A=
Implements driver for the Vishay VEML6040 rgbw light sensor.=0A=
=0A=
Included functionality: setting the integration time and reading the raw=0A=
values for the four channels=0A=
=0A=
Not yet implemented: setting the measurements to 'Active Force' (Auto=0A=
measurements off, and adding a measurement trigger)=0A=
=0A=
Datasheet: https://www.vishay.com/docs/84276/veml6040.pdf=0A=
=0A=
signed-off-by: Arthur Becker <arthur.becker@sentec.com>=0A=
---=0A=
 drivers/iio/light/Kconfig    |  11 ++=0A=
 drivers/iio/light/Makefile   |   1 +=0A=
 drivers/iio/light/veml6040.c | 338 +++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 350 insertions(+)=0A=
 create mode 100644 drivers/iio/light/veml6040.c=0A=
=0A=
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig=0A=
index fd5a9879a582..7ff517b728ec 100644=0A=
--- a/drivers/iio/light/Kconfig=0A=
+++ b/drivers/iio/light/Kconfig=0A=
@@ -654,6 +654,17 @@ config VEML6030=0A=
 	  To compile this driver as a module, choose M here: the=0A=
 	  module will be called veml6030.=0A=
 =0A=
+config VEML6040=0A=
+	tristate "VEML6040 RGBW light sensor"=0A=
+	select REGMAP_I2C=0A=
+	depends on I2C=0A=
+	help=0A=
+	  Say Y here if you want to build a driver for the Vishay VEML6040=0A=
+	  RGBW light sensor.=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called veml6040.=0A=
+=0A=
 config VEML6070=0A=
 	tristate "VEML6070 UV A light sensor"=0A=
 	depends on I2C=0A=
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile=0A=
index 2e5fdb33e0e9..ae957c88aa0c 100644=0A=
--- a/drivers/iio/light/Makefile=0A=
+++ b/drivers/iio/light/Makefile=0A=
@@ -61,6 +61,7 @@ obj-$(CONFIG_US5182D)		+=3D us5182d.o=0A=
 obj-$(CONFIG_VCNL4000)		+=3D vcnl4000.o=0A=
 obj-$(CONFIG_VCNL4035)		+=3D vcnl4035.o=0A=
 obj-$(CONFIG_VEML6030)		+=3D veml6030.o=0A=
+obj-$(CONFIG_VEML6040)		+=3D veml6040.o=0A=
 obj-$(CONFIG_VEML6070)		+=3D veml6070.o=0A=
 obj-$(CONFIG_VEML6075)		+=3D veml6075.o=0A=
 obj-$(CONFIG_VL6180)		+=3D vl6180.o=0A=
diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c=0A=
new file mode 100644=0A=
index 000000000000..7effb712820f=0A=
--- /dev/null=0A=
+++ b/drivers/iio/light/veml6040.c=0A=
@@ -0,0 +1,338 @@=0A=
+#include <linux/err.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/iio/iio.h>=0A=
+#include <linux/iio/sysfs.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/regmap.h>=0A=
+=0A=
+#define VEML6040_DRV_NAME "veml6040"=0A=
+=0A=
+#define VEML6040_SLAVE_ADDR 0x10=0A=
+=0A=
+/* VEML6040 Registers */=0A=
+#define VEML6040_REG_CONF_RW 0x00=0A=
+#define VEML6040_REG_R_RO 0x08=0A=
+#define VEML6040_REG_G_RO 0x09=0A=
+#define VEML6040_REG_B_RO 0x0A=0A=
+#define VEML6040_REG_W_RO 0x0B=0A=
+=0A=
+/* Bit masks for specific functionality */=0A=
+#define VEML6040_MASK_IT GENMASK(6, 4) /* bit mask integration time */=0A=
+#define VEML6040_MASK_SD BIT(0) /* Shutdown */=0A=
+#define VEML6040_MASK_AF \=0A=
+	BIT(1) /* Active Force (Auto Measurements 0:on, 1:off) */=0A=
+#define VEML6040_MASK_TRIG BIT(2) /* Trigger Measurement (when AF Bit is s=
et) */=0A=
+=0A=
+/* VEML6040 Command Codes for Integration Time in Milliseconds */=0A=
+#define VEML6040_IT_40 0x00=0A=
+#define VEML6040_IT_80 0x10=0A=
+#define VEML6040_IT_160 0x20=0A=
+#define VEML6040_IT_320 0x30=0A=
+#define VEML6040_IT_640 0x40=0A=
+#define VEML6040_IT_1280 0x50=0A=
+=0A=
+static const int veml6040_int_time_avail[] =3D { 40, 80, 160, 320, 640, 12=
80 };=0A=
+=0A=
+static const int veml6040_int_time_codes[] =3D {=0A=
+	VEML6040_IT_40,	 VEML6040_IT_80,  VEML6040_IT_160,=0A=
+	VEML6040_IT_320, VEML6040_IT_640, VEML6040_IT_1280=0A=
+};=0A=
+=0A=
+enum veml6040_chan {=0A=
+	CH_RED,=0A=
+	CH_GREEN,=0A=
+	CH_BLUE,=0A=
+	CH_WHITE,=0A=
+};=0A=
+=0A=
+struct veml6040_data {=0A=
+	struct i2c_client *client;=0A=
+	struct regmap *regmap;=0A=
+};=0A=
+=0A=
+static const struct regmap_config veml6040_regmap_config =3D {=0A=
+	.name =3D "veml6040_regmap",=0A=
+	.reg_bits =3D 8,=0A=
+	.val_bits =3D 16,=0A=
+	.max_register =3D VEML6040_REG_W_RO,=0A=
+	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,=0A=
+};=0A=
+=0A=
+static int veml6040_enable(struct veml6040_data *data)=0A=
+{=0A=
+	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,=0A=
+				  VEML6040_MASK_SD, 0x00);=0A=
+}=0A=
+=0A=
+static int veml6040_shutdown(struct veml6040_data *data)=0A=
+{=0A=
+	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,=0A=
+				  VEML6040_MASK_SD, 0xFF);=0A=
+}=0A=
+=0A=
+static int veml6040_set_automode(struct veml6040_data *data)=0A=
+{=0A=
+	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,=0A=
+				  VEML6040_MASK_AF, 0x00);=0A=
+}=0A=
+=0A=
+static int veml6040_set_forcemode(struct veml6040_data *data)=0A=
+{=0A=
+	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,=0A=
+				  VEML6040_MASK_AF, 0xFF);=0A=
+}=0A=
+=0A=
+static int veml6040_reset_measurement_trig(struct veml6040_data *data)=0A=
+{=0A=
+	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,=0A=
+				  VEML6040_MASK_TRIG, 0x00);=0A=
+}=0A=
+=0A=
+static int veml6040_trig_measurement(struct veml6040_data *data)=0A=
+{=0A=
+	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,=0A=
+				  VEML6040_MASK_TRIG, 0xFF);=0A=
+}=0A=
+=0A=
+static int veml6040_set_it(struct veml6040_data *data, int it_code)=0A=
+{=0A=
+	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,=0A=
+				  VEML6040_MASK_IT, it_code);=0A=
+}=0A=
+=0A=
+static int veml6040_read_raw(struct iio_dev *indio_dev,=0A=
+			     struct iio_chan_spec const *chan, int *val,=0A=
+			     int *val2, long mask)=0A=
+{=0A=
+	int ret, reg, it_index;=0A=
+	struct veml6040_data *data =3D iio_priv(indio_dev);=0A=
+	struct regmap *regmap =3D data->regmap;=0A=
+	struct device *dev =3D &data->client->dev;=0A=
+=0A=
+	switch (mask) {=0A=
+	case IIO_CHAN_INFO_RAW:=0A=
+		switch (chan->channel) {=0A=
+		case CH_RED:=0A=
+			ret =3D regmap_read(regmap, VEML6040_REG_R_RO, &reg);=0A=
+			break;=0A=
+		case CH_GREEN:=0A=
+			ret =3D regmap_read(regmap, VEML6040_REG_G_RO, &reg);=0A=
+			break;=0A=
+		case CH_BLUE:=0A=
+			ret =3D regmap_read(regmap, VEML6040_REG_B_RO, &reg);=0A=
+			break;=0A=
+		case CH_WHITE:=0A=
+			ret =3D regmap_read(regmap, VEML6040_REG_W_RO, &reg);=0A=
+			break;=0A=
+		default:=0A=
+			return -EINVAL;=0A=
+		}=0A=
+		break;=0A=
+=0A=
+	case IIO_CHAN_INFO_INT_TIME:=0A=
+		ret =3D regmap_read(regmap, VEML6040_REG_CONF_RW, &reg);=0A=
+		it_index =3D (reg & VEML6040_MASK_IT) >> 4;=0A=
+		reg =3D veml6040_int_time_avail[it_index];=0A=
+		break;=0A=
+=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (ret < 0) {=0A=
+		dev_err(dev, "iio-veml6040 - Can't read data %d\n", ret);=0A=
+		return ret;=0A=
+	}=0A=
+	*val =3D reg;=0A=
+	return IIO_VAL_INT;=0A=
+}=0A=
+=0A=
+static int veml6040_write_raw(struct iio_dev *indio_dev,=0A=
+			      struct iio_chan_spec const *chan, int val,=0A=
+			      int val2, long mask)=0A=
+{=0A=
+	struct veml6040_data *data =3D iio_priv(indio_dev);=0A=
+=0A=
+	switch (mask) {=0A=
+	case IIO_CHAN_INFO_INT_TIME:=0A=
+		for (int i =3D 0; i < ARRAY_SIZE(veml6040_int_time_avail); i++) {=0A=
+			if (veml6040_int_time_avail[i] =3D=3D val) {=0A=
+				return veml6040_set_it(=0A=
+					data, veml6040_int_time_codes[i]);=0A=
+			}=0A=
+		}=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int veml6040_read_avail(struct iio_dev *indio_dev,=0A=
+			       struct iio_chan_spec const *chan,=0A=
+			       const int **vals, int *type, int *length,=0A=
+			       long mask)=0A=
+{=0A=
+	printk("iio-veml6040 - read_avail\n");=0A=
+	switch (mask) {=0A=
+	case IIO_CHAN_INFO_INT_TIME:=0A=
+		*length =3D ARRAY_SIZE(veml6040_int_time_avail);=0A=
+		*vals =3D veml6040_int_time_avail;=0A=
+		*type =3D IIO_VAL_INT;=0A=
+		return IIO_AVAIL_LIST;=0A=
+=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
+}=0A=
+=0A=
+static const struct iio_info veml6040_info =3D {=0A=
+	.read_raw =3D veml6040_read_raw,=0A=
+	.write_raw =3D veml6040_write_raw,=0A=
+	.read_avail =3D veml6040_read_avail,=0A=
+};=0A=
+=0A=
+static const struct iio_chan_spec veml6040_channels[] =3D {=0A=
+	{=0A=
+		.type =3D IIO_INTENSITY,=0A=
+		.channel =3D CH_RED,=0A=
+		.channel2 =3D IIO_MOD_LIGHT_RED,=0A=
+		.modified =3D true,=0A=
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=0A=
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+		.info_mask_shared_by_type_available =3D=0A=
+			BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+	},=0A=
+	{=0A=
+		.type =3D IIO_INTENSITY,=0A=
+		.channel =3D CH_GREEN,=0A=
+		.channel2 =3D IIO_MOD_LIGHT_GREEN,=0A=
+		.modified =3D true,=0A=
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=0A=
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+		.info_mask_shared_by_type_available =3D=0A=
+			BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+	},=0A=
+	{=0A=
+		.type =3D IIO_INTENSITY,=0A=
+		.channel =3D CH_BLUE,=0A=
+		.channel2 =3D IIO_MOD_LIGHT_BLUE,=0A=
+		.modified =3D true,=0A=
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=0A=
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+		.info_mask_shared_by_type_available =3D=0A=
+			BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+	},=0A=
+	{=0A=
+		.type =3D IIO_INTENSITY,=0A=
+		.channel =3D CH_WHITE,=0A=
+		.channel2 =3D IIO_MOD_LIGHT_CLEAR,=0A=
+		.modified =3D true,=0A=
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=0A=
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+		.info_mask_shared_by_type_available =3D=0A=
+			BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+	}=0A=
+};=0A=
+=0A=
+static int veml6040_probe(struct i2c_client *client,=0A=
+			  const struct i2c_device_id *id)=0A=
+{=0A=
+	struct veml6040_data *data;=0A=
+	struct iio_dev *indio_dev;=0A=
+	struct regmap *regmap;=0A=
+	int ret;=0A=
+=0A=
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {=0A=
+		dev_err(&client->dev,=0A=
+			"iio-veml6040 - i2c adapter doesn't support plain i2c\n");=0A=
+		return -EOPNOTSUPP;=0A=
+	}=0A=
+=0A=
+	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));=0A=
+	if (!indio_dev) {=0A=
+		dev_err(&client->dev, "iio-veml6040 - Error! Out of memory\n");=0A=
+		return -ENOMEM;=0A=
+	}=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &veml6040_regmap_config);=0A=
+	if (IS_ERR(regmap)) {=0A=
+		dev_err(&client->dev,=0A=
+			"iio-veml6040 - Error! Can't setup regmap\n");=0A=
+		return PTR_ERR(regmap);=0A=
+	}=0A=
+=0A=
+	data =3D iio_priv(indio_dev);=0A=
+	i2c_set_clientdata(client, indio_dev);=0A=
+	data->client =3D client;=0A=
+	data->regmap =3D regmap;=0A=
+=0A=
+	indio_dev->name =3D VEML6040_DRV_NAME;=0A=
+	indio_dev->info =3D &veml6040_info;=0A=
+	indio_dev->channels =3D veml6040_channels;=0A=
+	indio_dev->num_channels =3D ARRAY_SIZE(veml6040_channels);=0A=
+	indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
+=0A=
+	/* Initialize config register */=0A=
+	ret =3D veml6040_set_it(data, VEML6040_IT_40);=0A=
+	if (ret < 0) {=0A=
+		dev_err(&client->dev,=0A=
+			"iio-veml6040 - Could not set Integration Time: %d\n",=0A=
+			ret);=0A=
+		return ret;=0A=
+	}=0A=
+=0A=
+	ret =3D veml6040_set_automode(data);=0A=
+	if (ret < 0) {=0A=
+		dev_err(&client->dev,=0A=
+			"iio-veml6040 - Could not set Automode: %d\n", ret);=0A=
+		return ret;=0A=
+	}=0A=
+=0A=
+	ret =3D veml6040_enable(data);=0A=
+	if (ret < 0) {=0A=
+		dev_err(&client->dev,=0A=
+			"iio-veml6040 - Could not set Enable: %d\n", ret);=0A=
+		return ret;=0A=
+	}=0A=
+=0A=
+	return devm_iio_device_register(&client->dev, indio_dev);=0A=
+}=0A=
+=0A=
+static const struct i2c_device_id veml6040_id_table[] =3D {=0A=
+	{ VEML6040_DRV_NAME, 0 },=0A=
+	{},=0A=
+};=0A=
+MODULE_DEVICE_TABLE(i2c, veml6040_id_table);=0A=
+=0A=
+static const struct of_device_id veml6040_of_match[] =3D {=0A=
+	{ .compatible =3D "vishay,veml6040" },=0A=
+	{}=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, veml6040_of_match);=0A=
+=0A=
+static void veml6040_remove(struct i2c_client *client)=0A=
+{=0A=
+	struct iio_dev *indio_dev;=0A=
+	struct veml6040_data *data;=0A=
+=0A=
+	/* Set device to power down mode */=0A=
+	indio_dev =3D i2c_get_clientdata(client);=0A=
+	data =3D iio_priv(indio_dev);=0A=
+	veml6040_shutdown(data);=0A=
+}=0A=
+=0A=
+static struct i2c_driver veml6040_driver =3D {=0A=
+	.probe =3D veml6040_probe,=0A=
+	.remove =3D veml6040_remove,=0A=
+	.id_table =3D veml6040_id_table,=0A=
+	.driver =3D {=0A=
+		.name =3D VEML6040_DRV_NAME,=0A=
+		.of_match_table =3D veml6040_of_match,=0A=
+	},=0A=
+};=0A=
+=0A=
+module_i2c_driver(veml6040_driver);=0A=
+=0A=
+MODULE_DESCRIPTION("veml6040 RGBW light sensor driver");=0A=
+MODULE_AUTHOR("Arthur Becker <arthur.becker@sentec.com>");=0A=
+MODULE_LICENSE("GPL");=0A=
-- =0A=
2.34.1=0A=

