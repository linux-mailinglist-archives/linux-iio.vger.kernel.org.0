Return-Path: <linux-iio+bounces-5483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F78D47F3
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1561F2492D
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799515219C;
	Thu, 30 May 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="tGa0p2c7";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="tGa0p2c7"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022019.outbound.protection.outlook.com [52.101.186.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD44D8C8;
	Thu, 30 May 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059622; cv=fail; b=ddfpcWEJqJUSXSRxEtWVznxk+0wlTW7aSX81dmjo26kKXHNCT1aw/5FmgJ4yF8vT/DQybWZeG+z6L/mzoQ4ueZo1YCO2XrTlFiT9BHQYN3sXkvK23X0z95MfIp+TPj/CPsZLiyy2AbNYKITv5ph4LFSdsCxEZohmYxHuP1LUrAI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059622; c=relaxed/simple;
	bh=ULICh8LvMHpVUW+hqB3bm3N2gr880ZlLS54K+VlUzDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5Xrmztk3uaTO+FmPb18iYlkk83mZGgOvxdm4Ny7g1zXFuoaL23Y4xYhdde7qWKBmEuJnMdOCiyuf/lPvrA6xuY4bsX37T/AvEmmF4bz3A5qXg5TMKT6PWEZdvwYRPjX3Kwm5eI4vnwkljOf0T1WaUYVuDtEWSPQmxCvpQ4yGfU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=tGa0p2c7; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=tGa0p2c7; arc=fail smtp.client-ip=52.101.186.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=RY7O6CHNEVFrxpf5kgiZyhOPZHCDyj26l7nf9S9nXH9svwolijVh5HcYprjO1FmHCIp587i1ag/bvLy+27gNcoALkPeDxHpoZJnH3IKzvtEyQaoUtEnSlIZgrl+0ILuuw4So7E5haMY/tOHlyTt4D+B0y4uIalUfayS9otbNP2EWBEj8ElHUIFosvk+rMJ5/sxbgwFRvWMNnsk2O+STqZ2wFM4yeiL8O7IM1O1Y4a3EcKS1Qva0uFo9xKO9uMZmmQ6n/jTj3U96Ec2uSrkDA+QJ5Ufvm/3MOKgtW5fJcMGsEdWgmci/YamnNZGV5jF/Nd57CgKjJmiLdZrTwu1iRIA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Sw9WhDIG69rQ7X6Mu71H4gZtbZFL4qqXZWFWLSCCI8=;
 b=lvtutviqldZ2Tqm5v2f7y9MVxOd8Bh/RkbGmNdr1FRcZw0PgFknmhLyhxuIXYlDTfp71dm0r+76wY974Zw23nfbnL2jg442SHlHDE+SJoxChO0xNtlCUmzTrJss/RAAHy73yKGVMzLC+3xDK/BQo9vq3FFmJVC5SEf5YygS+tKlZ1XxcvkCCGO73SvYQHKjHho4vTkbroq1/OoE46EX0rvH5Hk+C2TJEmCMNc0nSr1oOIW4gG3prXW7EQFTreNXP9HOhkLN8OWIRQgPS+3rMD88PYxvSrAj3ybJasKc+WQYeU4fT+iIoeR8jqALYhGaNZQ+ZG1usFc50r7WbetX4aw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 52.138.216.130) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Sw9WhDIG69rQ7X6Mu71H4gZtbZFL4qqXZWFWLSCCI8=;
 b=tGa0p2c7gscaVL7jslVKV3azka+YzlLpuCSeA0ZGTZgHD4f40I+2adyqtZUMvGyH9zWxe/s/BqmczHggImi2S0TpBXvzxVV3i2nW1fmGJzutYRtpl2u+yYvFo6bflNY/qOrsNWPY1xiOpPmvuTD6YXzc4blg1dEYXUplDa9hdhc=
Received: from AS9PR06CA0379.eurprd06.prod.outlook.com (2603:10a6:20b:460::12)
 by GVAP278MB0119.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:00:17 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:460:cafe::5a) by AS9PR06CA0379.outlook.office365.com
 (2603:10a6:20b:460::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 09:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.138.216.130)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 52.138.216.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.138.216.130; helo=eu22-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu22-emailsignatures-cloud.codetwo.com (52.138.216.130) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 09:00:16 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.10) by eu22-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 30 May 2024 09:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSnph2MCHPdg9z0+EpZUJWAun4D1mNciB+SMRW9jheWCHyjDjiSaMzzufATyp3n5s4gJNsdObh64jGlEMGC33gU4JSEPFAxRY7Nx2L9EQyXJ3I24MsFFhgn51DZXw6XlKWKCoVNWk+0ZMGBN/NIhXdvFNwtStfUEnxaaybfAfE/Uho1trHqsoC45QjQZkmyYwMi02mErHPDsVBGq3iVy6Zj/E/VfCeGmNz9fkZgbhI+LJY2hH19KMBdBXhcysUbjOQ7J3h+IzXnJngjBrB9tS9AyUsT827t+HT5gJm2k32wq7n0/6Rq9epEV7S1shlNQY6ofx/KAGqjLfdZoCNemVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Sw9WhDIG69rQ7X6Mu71H4gZtbZFL4qqXZWFWLSCCI8=;
 b=TYWSui28D5hkDPLa9N+0ziqkhbFhm/XeXvpionFQmxHJ6DmUqWG0xQwQUoAtj9TAKfSmRtAcEaGmqIJSZNWVCU6XaGBWSKqqjyRZZiWyyk5tCc1sdp+tcReGkBgvlkmJpcz1nkP2y88HHmP8EChR9EiBBZMoEv9NON6HiMNT0bkObxMLs3LsvMpjnEgfTsqHpEwpD+7wEG66cw2C5k4qMja341uIWKMk8/9rw7rmsnHatSJYkfC2ST+yZF8fqqXVe2l0+dl7a8mKFos0O3TxcKIYCBs30xf45W7dXzM4vDgth9lvPBKDLirR0kqME4FOstbx2yiEkq4DvyTTg2Vwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Sw9WhDIG69rQ7X6Mu71H4gZtbZFL4qqXZWFWLSCCI8=;
 b=tGa0p2c7gscaVL7jslVKV3azka+YzlLpuCSeA0ZGTZgHD4f40I+2adyqtZUMvGyH9zWxe/s/BqmczHggImi2S0TpBXvzxVV3i2nW1fmGJzutYRtpl2u+yYvFo6bflNY/qOrsNWPY1xiOpPmvuTD6YXzc4blg1dEYXUplDa9hdhc=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by ZRAP278MB0112.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:00:11 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 09:00:11 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Topic: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Thread-Index: AQHasFNmHVhgVh1W90aWHgpQzkaiXLGsPRnngAAvTYCAAw/Qgw==
Date: Thu, 30 May 2024 09:00:11 +0000
Message-ID: <ZR1P278MB11179C2F1599C28A19FA438481F32@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
	<20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
	<e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
	<ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
 <20240528110511.00006fe5@Huawei.com>
In-Reply-To: <20240528110511.00006fe5@Huawei.com>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|ZRAP278MB0112:EE_|AM2PEPF0001C709:EE_|GVAP278MB0119:EE_
X-MS-Office365-Filtering-Correlation-Id: c88c3428-a032-4df3-b73b-08dc8086ecba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?PbZiQOGZuMrR6hv/U0txdPSPtLSlhLK1fJ5pvKi4VnqESKYe7acQlZUAtV?=
 =?iso-8859-1?Q?2f2LX/YDid0YTBKa3NiK/txJ/H0NUUOI+4GmunpzhZUPGO6kXDVToBGhNV?=
 =?iso-8859-1?Q?GHGvtIU+1f5wkbgadTZlhjtA8hw+sFfT8dnqoVAnelduXUhDmH/ZVVDHql?=
 =?iso-8859-1?Q?T8nzfDIf2mLAgKUSoujf2tk6L6iJS7NF1NQSJpj1FZaJqnk40EZmaetIX6?=
 =?iso-8859-1?Q?ee3o6zCZaTmSY5+lAyI0/qeEVdod6XwtNHfBe9Ti5kC6RHXwk8/r4CmEBl?=
 =?iso-8859-1?Q?sP9wEBoGYBYawsNx3skYWSyKSSUn+3CVBrDPh5umN8o88mil45Y76rpxn/?=
 =?iso-8859-1?Q?yBMUCs3D9nDnnv3UeV5nVQbug/c5s3BvyUWL9wnhlBaZaKjETbCNGS+LLP?=
 =?iso-8859-1?Q?FWCxYIk8skxLy1/7flJ1xSPjQa8dApLYU/W2ya23YCPHVsmNFPGzlLDXg9?=
 =?iso-8859-1?Q?+XBA3GYmgs41PnfMgMBmnOAKd9lcyhWSNLKOr45btaxAppVumz0nUUNEs8?=
 =?iso-8859-1?Q?5x/yGez/zPX6HlXlPv+xirqDWFamDvFSwI8oEAX1xmbtx+Y3A7eRtSbykV?=
 =?iso-8859-1?Q?nUz1tO0OLAMicdkuQQc6xM4JLVJRTTuWZSzmMqcu/24FZXNU8PbwJpnAJ/?=
 =?iso-8859-1?Q?+14dANGVbTsPfqX2U7T0zT+X2dLM0wKrfGmU4uwwB4nArNE74NGseCizdp?=
 =?iso-8859-1?Q?A0ZGTcvk296ADq5i05wDdeia1BxGB/ayqsS7EP9mRIYl9HWAcdgo1SHbSN?=
 =?iso-8859-1?Q?OGhv71W9lme8FkZvbHouumtSFTqgaW6Pi5tbN1E7c+vZhJ+7czYP29c2b/?=
 =?iso-8859-1?Q?R6dV4Rw5ZgK7oWlGl+3RAzx0XnronM/U9KRmjAEcdRR3g0DwFtZIHMtUL+?=
 =?iso-8859-1?Q?6rjJTq1BYaPbqZPpco3bWbjqqjI2wzdlI5M814R2eCBf2XJ1nt+82MBwgO?=
 =?iso-8859-1?Q?dncm8HcXzpYcIENJCAD/osOMkJUxdlrJlltaHPczeVrd78O+48e3TapUEd?=
 =?iso-8859-1?Q?8Q0dTV0mL+SySrXYMdQ8wQXMWg2Ijbxxikr1AD2K2H5ALHve+VcBlTv9x8?=
 =?iso-8859-1?Q?Kq29EJr0dD4VMoy/zgS1YjTqI9G6I6puhjmCC1wbvzWid2itf9iXF0XB21?=
 =?iso-8859-1?Q?le4tgsOZXfqJavxmaeRQxyS1AEyYXMywH+dyGFK1A4lBYR8/Q3K3i66oCP?=
 =?iso-8859-1?Q?ReWDGlMx6ZrUF/iPQ2fSqElnw8aswygARK+E5XbhFK9qKn9NMilf3l2XKn?=
 =?iso-8859-1?Q?HRlHHSpFWW2g0lBhs07ZmhlnUMxGXN7iodravBIbEPI5HDJkmapEu/k5ES?=
 =?iso-8859-1?Q?4Q+YJsiWNMRS7W+pcYBOFv6MgjZm4P871y3hqvw4NCnRr+dm6vHSnM0+qO?=
 =?iso-8859-1?Q?w5COmnlf2QroceZJkzrB/f1UcMqQ0tRA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0112
X-CodeTwo-MessageID: 7869e822-3427-4303-89fa-40c0c5ef2b0b.20240530090014@eu22-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	30c78d87-9b0d-478e-6db2-08dc8086e9d6
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|35042699013|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?1Q0LwRdRGFJjIqfXioZCPRzOkC4RKFE2cib/67AXqjb0nIt8A6AyBnQ5cI?=
 =?iso-8859-1?Q?2xZhaKfZlcFMXfRiYmEtwYdbFMR6iAAdl3dugu30C0eWNIO2OWbkw4NlS+?=
 =?iso-8859-1?Q?EC6mDT15StAE/gjLYYKNcVXRpAET0eMwdA0Qay6JcHsEOlcrat6LLKwMsU?=
 =?iso-8859-1?Q?EP9YOKB2uI00Dzef6IVf4aMfUuiYzM7tgTiNhjTsa92wB7qnaLHTTQFtgI?=
 =?iso-8859-1?Q?qa7WAMGm7x9DMx4F9Ico4/OfNmfxBasaO8k50w7EQT9mDKXz5BGOzk7vqP?=
 =?iso-8859-1?Q?XbWHzUD3igIEu3dL2IBlivSQB8RAoqFpadndjQRkc1gEX/vgfq/pAf8LRk?=
 =?iso-8859-1?Q?o5Xy88sGx13QjqpGDD+q6JgTXpLWjgoMsj3PS1TX6/UD3kYhrWm4pdIgV3?=
 =?iso-8859-1?Q?/rgzd/2l+5qi0oaWCy/5OcL5Rj0rHyprqKaL+r42d7eqlgngp1oBgMe68e?=
 =?iso-8859-1?Q?3RWLYnSGOTSK4iftRUjhkdo13UPBmHbkowC2L63kngVDTLGxZA5HbeOVun?=
 =?iso-8859-1?Q?3sp0PGxNVYZIaaZT/Fg/ZlcSSmQ9MzbHd8aRbgkvPR37MjMjnjE4ATtLWI?=
 =?iso-8859-1?Q?YIApibgy6bNcZSb7GR6oMY/fNdACA2ktdJ1yRulUmNNemDJANO7t/pjpdT?=
 =?iso-8859-1?Q?nfNGJVSAPSJ5Sth17vRj2UWCP1orwbMPn4FXYpDWsbZHm1x6rWEEkI+0Ix?=
 =?iso-8859-1?Q?zwxYuS2fNrzL1HKMkbavU7jZG2sEaFVStDmqHGgoS9xifWu/yIK6HOLhC3?=
 =?iso-8859-1?Q?AZ6Mr74hYAy+edjnNET4ulPBhEIywE8Z1ZIec74QZVu4kZzO1bALCa9mt9?=
 =?iso-8859-1?Q?bCFvZuWoU7e85262js168OFsPEjqlnWdWRuoiw6g8Ssr5T9OnGkJP1klia?=
 =?iso-8859-1?Q?Hy3velWeubKC1VuvmuJ9hG5V5mcMPcRfFTuxjxn0HqO1YICj6E5bNINmWu?=
 =?iso-8859-1?Q?QeV+87GOKoLa34gxb7kBJz9/Sx1wkUXPfQKaUqI0Hifnl772sPxQ1ad5JL?=
 =?iso-8859-1?Q?rG3Z9bWnI6EAA3zI3GNErdxZSQlWe5vuOOmnjplpHsZzTr57pJV7MhIN2f?=
 =?iso-8859-1?Q?aqrMBR8staeEY7QBdFvqnvuVwLTYQfmGc6Q0teyADSwJluTXqfHiWIKmjv?=
 =?iso-8859-1?Q?mXYN2NJ8YxZaxqyIJGE1IwcNHRe5gt90n2fc+8jM+vCRIaATQ4lAyB6Tbk?=
 =?iso-8859-1?Q?4IT3LCDy8+o0Aaipn10fd8znZ5IX7Ja5ujBSqHJYuLmz3tE7dREIFtz5dE?=
 =?iso-8859-1?Q?ZRVTlYEyYAW6uSjO82SeEbtziAQW+EZpwbod4xeL6vTI7huwuroMhjRmbw?=
 =?iso-8859-1?Q?WR5sewWNGN/qK5vGE6F4kR1WoeFpVTs1ffY+1n2WHopirRR9g7He6qOki8?=
 =?iso-8859-1?Q?ev5AVl1DsLzBggBMjEd5dw9aUu/VPZ58bqg88N+e7jID/s2+M2ZzhtOA81?=
 =?iso-8859-1?Q?g33jbZEHdFQ752sn?=
X-Forefront-Antispam-Report:
	CIP:52.138.216.130;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu22-emailsignatures-cloud.codetwo.com;PTR:eu22-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(82310400017)(35042699013)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:00:16.3212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c88c3428-a032-4df3-b73b-08dc8086ecba
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[52.138.216.130];Helo=[eu22-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0119

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
> Sent: 28 May 2024 12:05=0A=
> To: Arthur Becker=0A=
> Cc: Krzysztof Kozlowski; Jonathan Cameron; Lars-Peter Clausen; Rob Herrin=
g; Krzysztof Kozlowski; Conor Dooley; linux-kernel@vger.kernel.org; linux-i=
io@vger.kernel.org; devicetree@vger.kernel.org=0A=
> Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VE=
ML6040 RGBW-LS bindings=0A=
>=0A=
> On Tue, 28 May 2024 07:23:03 +0000=0A=
> Arthur Becker <arthur.becker@sentec.com> wrote:=0A=
>=0A=
> > Thanks for the Review!=0A=
> > Right, I wasn't sure if and how to add the veml6040 to the veml6075 dt-=
binding file.=0A=
> > I'll modify that the next time I make adjustments to the driver.=0A=
>=0A=
> It's absolutely fine to have shared bindings even if the=0A=
> drivers (because of different register interface etc) are completely=0A=
> separate.  It's a good way to keep bindings aligned between=0A=
> similar devices.=0A=
>=0A=
> Jonathan=0A=
=0A=
Thanks for the answer, I'll keep that in mind!=0A=
=0A=
Kind regards,=0A=
Arthur=

