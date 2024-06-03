Return-Path: <linux-iio+bounces-5668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F008D7D3B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 10:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57B81F20B59
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986657CAB;
	Mon,  3 Jun 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="KcfsE2Jo";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="KcfsE2Jo"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022018.outbound.protection.outlook.com [52.101.186.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC24AEF5;
	Mon,  3 Jun 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403046; cv=fail; b=BKuawem1BJshFPCAEn3HtXBGBwbuxSj6Nxt5d9AkohGkkn5cOMP+5wPPLsW1x4XzKD0Wn/stY9rHgAh9JUXpXszspVG2EFrrar3inQOsPgjVOKuIpQV+Yhi8JuiP0C76TuIynBLs48FSXblBhy02Z+PiryCZjcUx9piUv3imlzo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403046; c=relaxed/simple;
	bh=mMrqv49Fg3X7QqV75jwQlyxqdna+IZ0v4GpcJVQiULs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7RXa+whD79IspfkOf0vEjk/nMdkZL6N7zhV+4BD2+g/YiznxkMyekfqs89+ni6SHcWbGAXqNcLZcGvI4OPFWfjYTXU07f9kLFzOF70AVXcBVeUC0HTjoLWtwuXV5anVbKis4+gIptRYJOrgFgkWIb/nPmSF2ErWrUes6dKmnRY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=KcfsE2Jo; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=KcfsE2Jo; arc=fail smtp.client-ip=52.101.186.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=EbZqFXYl/36OaM+y1REEzPA9z7mKT9Rxv/Y34UBWsrsbn39ciXURABU8Ksp+l0/fB7nzCnhX4/ZRbRqoBKDahSLbcZhEbLZetCv8kEpssZsu0nFtTlPKPjrRv8P8aQD+319FRXcpG997P5JJZH+Vko3uLzn6s515Y+BHfDxzBNnGBi53O9GLFXo6T5v68o8y3Az4Cpp/MarfQSnkGul4T95oOgZkwARXTqMqpP15KSHVHgM7yTtq25EMrSLAjnxAULesbWVVYSdGv0Aad+L6eUjyPN4lZHJKu47LSXqCvAh8AhRQZbsO12NgfYlQWbjY+7/hpbwRmBK9NAOUlx2s8w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMrqv49Fg3X7QqV75jwQlyxqdna+IZ0v4GpcJVQiULs=;
 b=AQbAgiJZm3YxZ4SBEG2RjKSbvJpc0/JyNOLuDTbvGeNijd6n08MrYVXFy8vyWA//4OrhsURzgU0hkBGL0RGw9uXXGmFCED7/r6RMlqVFv+xlNXhsWmR9eH5XtWTGE725uqnbg6H0xR2xFW8euuWkhARQgcAGsoRTtw18bWzBqLdeso56HYL26t2sJjRkW85vf5wdOI0FqvaM9c9OVQGl4+gHR6P5CIckI/gmr8ZEA1XhNs1yiI09R+pN1EZuHj8wU4Q++kIib/R9bt7TkWGSRE0agxryHnFZmaKhrpM6+pb8njyJd+6Lz/oBTRP6DocGsb6rUmER1PFRHNmogcFIDg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMrqv49Fg3X7QqV75jwQlyxqdna+IZ0v4GpcJVQiULs=;
 b=KcfsE2JoOT4m+JywyLkbai+/YGtdky85knSOlNGJ1P0VqUReDS6Epll4JCy0f+tcGxDsSfrhZS9DJbkLylsu82bKcC9rcANwOQ6IfFICUrW1RBk4Whd7ki9JceJIiqcqLyoRAjT73f7cahWhZT1BP5gORCdUxbZVUjEYAw93L6k=
Received: from AM5PR1001CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::46)
 by GV0P278MB1433.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 08:24:00 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:206:2:cafe::5f) by AM5PR1001CA0033.outlook.office365.com
 (2603:10a6:206:2::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Mon, 3 Jun 2024 08:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 52.138.216.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.138.216.130; helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:23:59 +0000
Received: from ZRAP278CU002.outbound.protection.outlook.com (40.93.85.1) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 03 Jun 2024 08:23:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQugNkwrSZRL97hAX14Io/AqzztBN9NF0w17Doa+xyI2ikCnQPTZmsx2yHgQBRB/zEX/4DpYqG2z93Jp7Nj7bjpamNhh6b2OgdJ5noEPf6qxdE0OytuEF5yyLGGlwj1kVbb300bTV7I0eZSLqyg9OoVigRx2qBjOUwiWdBcbRVzIwLFeCM7SmICPeWsfyKdeM4jFiU942hWmq2jGQaQpD9GBiihp2am2L30ytIkSic5eKqBdyQjx79gtPXUQLczc0KQK530zIlUAv215XGI1OWOk87VMnly1V0IuiE74ULkmTJFrTerRl0oYUbbUcDlm34ahRvYZTlTT83h0fKgznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMrqv49Fg3X7QqV75jwQlyxqdna+IZ0v4GpcJVQiULs=;
 b=BAvatZ8mYffr3FmKXXOVamVmWmWBPjU051iotORuqfTMla4m02hmxVn+YosutRPCQuyAk0hSJDNBrayhSQ57ro6VgdUDD/HXe+DBUVxhwHQO4PjYfeDMkOonmUZn0byTiDpGvLsVM6SA8VDpeNr+14OPMsqxrIVIv17dQbcNzxwzKI6OEDt2hyH+VvLpU1zJP6/ulViEeltWvKPc6DgF9XS0bEoQ1qpPHu3vKjR+VlTYeFRF1PJaJVteZlYrQdSKu6VxMosIDgGzNJMSTdKrupniQaiOR3SrtkB4t27VCqdh5K5agvJZPTzqcAu0c4YksoQ1POEmJ87kusbpjPh/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMrqv49Fg3X7QqV75jwQlyxqdna+IZ0v4GpcJVQiULs=;
 b=KcfsE2JoOT4m+JywyLkbai+/YGtdky85knSOlNGJ1P0VqUReDS6Epll4JCy0f+tcGxDsSfrhZS9DJbkLylsu82bKcC9rcANwOQ6IfFICUrW1RBk4Whd7ki9JceJIiqcqLyoRAjT73f7cahWhZT1BP5gORCdUxbZVUjEYAw93L6k=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by ZR1P278MB1412.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 08:23:55 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 08:23:55 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS
 bindings
Thread-Topic: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS
 bindings
Thread-Index: AQHatY9fGWtECmtpkkWZNgQDKGlpvQ==
Date: Mon, 3 Jun 2024 08:23:55 +0000
Message-ID: <ZR1P278MB1117EE8AFDD8891EE6459CEC81FF2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
	<20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
	<e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
	<ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
 <20240602141617.533558c4@jic23-huawei>
In-Reply-To: <20240602141617.533558c4@jic23-huawei>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|ZR1P278MB1412:EE_|AMS1EPF0000004B:EE_|GV0P278MB1433:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdb50d6-ad05-45ae-3734-08dc83a684e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?ojfcTNL/ETXZrSClK1jaPEDbdzu1aEGXCMKrp3Jb3DSWjny6xTvFVd6jyp?=
 =?iso-8859-1?Q?0BTSI5lHuwVjADn4KTdEOmW8YBb0qU/PfRn+NDhq5M9HrDZDU4sIYZf/+9?=
 =?iso-8859-1?Q?3TiTBDa6AgvleZ3td5myKTS1UbzNwqObqQ4l8SnBflKd2sMgxkIMJIyEZA?=
 =?iso-8859-1?Q?GAL6ff0vwL1xBvuNq9IcYidNlqxdV4hpW6uDzijPnMaKskBmRMBYqBkwxr?=
 =?iso-8859-1?Q?vE6e+HtMYyjTowN6oSKbXNWBZhnBk7x8V2ox+fcDIOxMH7U1WCbc2Nvw6o?=
 =?iso-8859-1?Q?HlQWDKk7Y/IpjVSPnCUtlMa48ZLqyQbrab9jWxZyL1P9avInxz/TlwyFMJ?=
 =?iso-8859-1?Q?5RzIlpNHNg2vPPN5RvldTGiHfA9P+iUHNKT5SOpLfHd/9ZuRwJpHE3F68/?=
 =?iso-8859-1?Q?XAM7zRSvUYDX5oK4QzA8ha9XUL0zzFrMWxKIC52eEvIPLDXroOMC2zBpyu?=
 =?iso-8859-1?Q?UQMPC6mQ4yyc67vysYiF2HfNagzBSJdOLweS7ZEJPWlkykkyLHC6vqB1hq?=
 =?iso-8859-1?Q?J9LzWB3uWW60w9HsqSMcPZMWKcIlHPdYnMIeEnh+vlOO2nRCBE0h9YjysF?=
 =?iso-8859-1?Q?hFJLzTlC86sOn925mVFBSbNAoTips5RgkinEb2sv3bN46AwIFTZvCc2Zzr?=
 =?iso-8859-1?Q?rboXIFQAeurMifjqlyyGSCmEvOYgWiWOOBQoTHXxL/VjAsuCeUh9PYTKvt?=
 =?iso-8859-1?Q?lWS3NIHmV7SdmLcu2bBOke6HaI707oNYYHfO8ctmP81B8xQ2sz36mEiTBl?=
 =?iso-8859-1?Q?/Ee+j5NE+vWZudnuLtqNVTfmndlbHWXhi4NoGgHZ4OqbKYM4qLt2vV82g4?=
 =?iso-8859-1?Q?v63Z30nn9B5DIbTu88vKX2VOp4aeRVYsT4NGc/L02I3xb2SRPJYEVqCzY+?=
 =?iso-8859-1?Q?aal0kAQ8KNcM6i4NV/A83G7zZ3paeYP8FlSdPpVohJ6v33UeY8zHsp08pD?=
 =?iso-8859-1?Q?zTxz7sqVrJm/mjXeXXXvcFJQIaRKssrrTrnS7Aaq0ktQwjQbjAaPwnScjI?=
 =?iso-8859-1?Q?VY25p7l+d2H7/pX+Lhf/W53T8s+7CfU354nI9mF3miDCg7ASH3gi4p0TYR?=
 =?iso-8859-1?Q?63HLpIEvE7FNRkMJYyNq4T33v0yGs0EgLVlQ7J6kkJqZ5XgVNjzATZB2qV?=
 =?iso-8859-1?Q?3z7oDER+cNpZv+kxdHpIURumrRiIl8GjblJKz5r4fg8zf6Jcdkzjm+6Nyg?=
 =?iso-8859-1?Q?npwUb33jCbAXd7X5fYAplZLgTVgOVxMd0QlaagL7Pw1ss6fEMSUcccDQqj?=
 =?iso-8859-1?Q?RwVBTUysk2xtrEFXj0T98jrtWM9mvTaIm/bitZ7hlSJ0vSKHASmV+jvhq1?=
 =?iso-8859-1?Q?em6EtjNeYNN9rFFUjZ2xLpqvFg63Ln9TA3+EEdK29OykF7wyaf7jckwtvB?=
 =?iso-8859-1?Q?oTcCrxH/+iQeMZUtjgHnO4ZEbeZ4bPmA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1412
X-CodeTwo-MessageID: ae5a84c6-b5fc-4a1d-989a-0d91855123ab.20240603082358@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a6922ae0-1d98-4128-7b74-08dc83a68266
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|35042699013|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?q8a/6Qy03qpEk/hI9tFPQvNPHCtWNoJhMbs85wTbDENwKcD9n1iyKhBNmt?=
 =?iso-8859-1?Q?H/jzOIJbA40VG/B2ugixd+LZmpTLCeHcAgBh4K+Y/CtUsB9mGJ0x7yv+tQ?=
 =?iso-8859-1?Q?GCk7fO0HRIOyIKgurO4vDVxum8eH+MErTgt+xdNWpo9ZogGaMK0NZ2LnYW?=
 =?iso-8859-1?Q?17B6j9g6btpCufcJ+MPN5zBO49w/bLK+T4MxxS28DC/aaLzV09uEoYzewd?=
 =?iso-8859-1?Q?YaVWmcU152gzSXR4eGPrPVrLzcZu3HjENNIhA7tyw6Clc6LeaMRlBKIH1D?=
 =?iso-8859-1?Q?UlkAf9KlRVxjonTKAe+4lv6QFzRZ+Gc/hMRq4uR7ODXeWM3c68OzTKnlSt?=
 =?iso-8859-1?Q?OWrcLblgnFhz2xaZ5TBn1uBQM4gM6rN2Kwtr93iawE+wjupQGZmWxPAEYD?=
 =?iso-8859-1?Q?QquvbeaQFD8h3q7+LteUy145vRnAqfC3H06/j5vrSwFDH6ROIG6yZV3UYh?=
 =?iso-8859-1?Q?1h+C4wjab+5bUVPXnQ9Yiab1b/ljgtJfjr4WTxg6to2+jIRCUfoiS33iXm?=
 =?iso-8859-1?Q?j67MQiLqKsq+YjD8xTzYvqj1HR+f0/55XEA+magtQz5e/PkJmN2w4ujf/M?=
 =?iso-8859-1?Q?MjkWsBGhJ6IM8WM88KEVFEwoT8KNQPMu2wC/oGoD57Hvp84v949aA4Et2l?=
 =?iso-8859-1?Q?f3IpmDj2+9XW0XdsrraqG2LHbGofm0ZPBGZGl2AvpKnox9ZLNbLRAiWPNu?=
 =?iso-8859-1?Q?wkombBNK8wrsXq0B90/QtsEF6l5xtTROY47hnb9KCGzec1AepN8bWvqJP8?=
 =?iso-8859-1?Q?YCm2Bv0ZWqp2XM18Ovny7mjAW5mBNZwfKTgxqSuDG6zGByAnaOuZtqChWF?=
 =?iso-8859-1?Q?7onWcktb/Bla6BYUYRXU28Vgg5vkoF6hrd6tZ4AHVJnmzD9b5J56o5rYRJ?=
 =?iso-8859-1?Q?ZuLX0t5BBxF99JPKLreNy2lrNvXQx6jtzH4bZgqivIwmZRHhLIWnu3VxiH?=
 =?iso-8859-1?Q?62INUhBPLqhnrPkcjpWdcw3uwKHVjW0ee22Zll5782GLmyRjj/tE/XV/XY?=
 =?iso-8859-1?Q?Ly4TewBajtI61JcmAOTHDAsh3CKFKH0FoMDKefRhrT+g6vQq5Jt1w7xgUG?=
 =?iso-8859-1?Q?vLcWedsmLCYhtMzjcGfoj/mkQKU8QYvl1n/8zIWfhybHQE/CA8Wqos+fNU?=
 =?iso-8859-1?Q?ps8bHjCqhyYR1j8H2MFmUhRWLOAK2MlcfEv0uOpmQHqrocUNuVqFa6MjTR?=
 =?iso-8859-1?Q?5mqPvHsZW5D+XfZODYBATyVwakPayRq1PZ3ADmFP0Ja+vK9gs5IzamafgH?=
 =?iso-8859-1?Q?Sx+eG0fZeAE+NTn/A8dYOuwk/mea9izBguCyvCs7bpwxzJ029tGNXvgOW+?=
 =?iso-8859-1?Q?YvfyzqgUnrkVx3ufc8vB1+aU7Z8iONtBhosrhWborXO2P/2Be2q+GntJ6d?=
 =?iso-8859-1?Q?VfadrM/TueyehdGUlKRmbHypne458sCY7mVc0ZQC3pgb/BXd7mWJI=3D?=
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(35042699013)(36860700004)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:23:59.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdb50d6-ad05-45ae-3734-08dc83a684e3
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1433

From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: 02 June 2024 15:16=0A=
To: Arthur Becker=0A=
Cc: Krzysztof Kozlowski; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlows=
ki; Conor Dooley; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; =
devicetree@vger.kernel.org=0A=
Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML=
6040 RGBW-LS bindings=0A=
=0A=
> On Tue, 28 May 2024 07:23:03 +0000=0A=
> Arthur Becker <arthur.becker@sentec.com> wrote:=0A=
> =0A=
> > Thanks for the Review!=0A=
> > Right, I wasn't sure if and how to add the veml6040 to the veml6075 dt-=
binding file.=0A=
> > I'll modify that the next time I make adjustments to the driver.=0A=
>=0A=
> Hi Arthur,=0A=
>=0A=
> If I read the above correctly you are hoping this merges as it stands and=
=0A=
> we come back later. If we are going to combine them long term,=0A=
> I'd rather we avoided the churn and had a combined DT binding from the st=
art.=0A=
=0A=
Hi Jonathan,=0A=
=0A=
I could have phrased that better, what I meant was that I was waiting for t=
he next=0A=
feedback on the driver to make the adjustments all at once.=0A=
I'll get to it shortly!=0A=
=0A=
Kind Regards,=0A=
Arthur=0A=
=0A=
>=0A=
> Jonathan=0A=
>=0A=
> >=0A=
> > Kind regards,=0A=
> > Arthur=0A=
> >=0A=
> > ________________________________________=0A=
> > From: Krzysztof Kozlowski <krzk@kernel.org>=0A=
> > Sent: 27 May 2024 18:31=0A=
> > To: Arthur Becker; Jonathan Cameron; Lars-Peter Clausen; Rob Herring; K=
rzysztof Kozlowski; Conor Dooley=0A=
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree=
@vger.kernel.org=0A=
> > Subject: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML=
6040 RGBW-LS bindings=0A=
> >=0A=
> > On 27/05/2024 17:12, Arthur Becker via B4 Relay wrote:=0A=
> > > From: Arthur Becker <arthur.becker@sentec.com>=0A=
> > >=0A=
> > > Device tree bindings for the vishay VEML6040 RGBW light sensor iio=0A=
> > > driver=0A=
> > >=0A=
> > > Signed-off-by: Arthur Becker <arthur.becker@sentec.com>=0A=
> > > ---=0A=
> > > V1 -> V3: Addressed review comments (v1 of the dt-bindings was sent=
=0A=
> > > along with v2 of the driver but not in a set)=0A=
> >=0A=
> > It's basically the same as veml6075, so should be put there...=0A=
> >=0A=
> > Eh,=0A=
> >=0A=
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
> >=0A=
> > Best regards,=0A=
> > Krzysztof=0A=
> >=0A=

