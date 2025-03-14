Return-Path: <linux-iio+bounces-16830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C0A60CBC
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 10:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867E719C37BB
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0011DED5F;
	Fri, 14 Mar 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F66of+jK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sI0WlvrV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744F17E;
	Fri, 14 Mar 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943184; cv=fail; b=R+Mq+YVtVSM/YMk+SpzIhmqq1YbPSRX97RqyI2u7J5l5AErcgf/oXLFl+zjS6LCTHMlANkbtGSPoIPYn0KonukdQo0RJT3lz7afdR7fwjQBpMz6YmSWR9fakF/2oevsv9XxmyeFOkGU58yA2rTmc5iTEMhPrevVle9Pw85qPDz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943184; c=relaxed/simple;
	bh=n0s8to3MKh13DfRUrEVTH6NQxfyuXQq/AKdSJIb6rkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmgpH746AMU/4DmkynAppRKGHiU0RFfmzvIuVGYblkhgKNfNk2huBLWgqfySqEfopM8PYGraImAOlZQDppek+3Fj3LqnU8a0ZkTwYdpHhh9LRVRB6W1pckgJ4/nrtd4IiFVM83HAicgMgy/c18fm7UIuP+7hBbgwBPzqD/2WcRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=F66of+jK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=sI0WlvrV; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9720cbd600b311f08eb9c36241bbb6fb-20250314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n0s8to3MKh13DfRUrEVTH6NQxfyuXQq/AKdSJIb6rkI=;
	b=F66of+jKC8B7G3wXI+MPFRcE879ryJbSF9a6gKU3Kpm2pWbtK5diCJq4loT/4KPfdYstrNmu8a+jXS3/dEdgI5Gt2BmqrrLhtat3spuOSoX4Re8aDWi8kIhNSeK1lty9e2fAzPq8EJotjy26VQoZFd+53EB5nVtMPIchT0kBGp4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:a76da141-d2ab-4c90-bc29-f7958c2abcd7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:a5221b4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9720cbd600b311f08eb9c36241bbb6fb-20250314
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <lu.tang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1845999512; Fri, 14 Mar 2025 17:06:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 17:06:17 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 17:06:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VH1TDRPH1nAtNOFV+kZhIAufXxKbI6s6xSjcxZ7749sO1O//v8p3yqvbZILowJTzHEcGVsVytVv9R6L20QzP0U0LX1k4rYdVmHLYramXxh0PUcHEZpldsfjVPHulVRogmdsc5tPImc04iIh8n4AE/WRslF+czBsXX9awrsKG/+qSir7dvfAlbII+mllCu8KbZ2JrkYn/K5nucGSywP8R0cBF37K6AvbAOvGrSNed93IdMgpYwekxSJ3zIWdxcKPrtlUp2IK5qO/o6J8RfKLa4yuhvN+dEmXRleJDRsP9YHPfnlvUwBRZWuPqfzDfPYWOsxwd5FKe9gjee6OKzTCkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0s8to3MKh13DfRUrEVTH6NQxfyuXQq/AKdSJIb6rkI=;
 b=Ykz78TJu0R1WM5UMk0tMHIt8IgJcZ+7n1J+busZDbTIM6sQJYrVQcyLnbu6jdid/EGz/zc4nbH3Z1vxbHhsftAbEVKpDt9vmDtstg8mELOj2w6t/ZuvgNvKsyTPOjDoP8Z3L7Dk7Vvdg5lerwkbRPIHkkhwwc6i+Fb2g6vTEHseWoVCkRaSuc4jiYtc5zzgkkdEj0EuEgtUqpXXuVUvVo5LvQdhmHJC7lTwL3ZdKxF55TF9hpI5CVPdQ/wrt7jIx0IKFrtcSQjfFST17SSYERkot174Yy9BrrVdvjEFF0qvYO6Jf7vG+yM4pmqGG2MiSPLMyv+SwK/WKPt2UPxIN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0s8to3MKh13DfRUrEVTH6NQxfyuXQq/AKdSJIb6rkI=;
 b=sI0WlvrVKJ1YgiVipWtzXO7QGA8jynXQ5Ph6xwORdPLk1YiIlqF0JXl267PtLog3YGy2GMBncmRIDYO4Nw13zSclc7hPU3I/hLLZMEd+QuBPT6Lmgl7kdAJHWrsi+qOT2ANaqIOAHLHm5TSZp3L7WkfjitrJZrVqU75q/DNfm7w=
Received: from SEZPR03MB6891.apcprd03.prod.outlook.com (2603:1096:101:a2::5)
 by TYSPR03MB8506.apcprd03.prod.outlook.com (2603:1096:405:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:06:15 +0000
Received: from SEZPR03MB6891.apcprd03.prod.outlook.com
 ([fe80::579a:f8c2:b6e5:c2b9]) by SEZPR03MB6891.apcprd03.prod.outlook.com
 ([fe80::579a:f8c2:b6e5:c2b9%2]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 09:06:14 +0000
From: =?utf-8?B?THUgVGFuZyAo5rGk55KQKQ==?= <Lu.Tang@mediatek.com>
To: =?utf-8?B?THUgVGFuZyAo5rGk55KQKQ==?= <Lu.Tang@mediatek.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	"AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, Sean
 Wang <sean.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, =?utf-8?B?Q2hlbiBaaG9uZyAo6ZKf6L6wKQ==?=
	<Chen.Zhong@mediatek.com>, =?utf-8?B?U2VuIENodSAo5YKo5qOuKQ==?=
	<Sen.Chu@mediatek.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMC81XSBBZGQgUE1JQyBhbmQgU1BNSSBkcml2ZXIg?=
 =?utf-8?Q?for_mt8196?=
Thread-Topic: [PATCH 0/5] Add PMIC and SPMI driver for mt8196
Thread-Index: AQHblLaAVdpBqhMwikajaB4gtXMjebNyVyxg
Date: Fri, 14 Mar 2025 09:06:14 +0000
Message-ID: <SEZPR03MB6891C5D6CBC04C756B78209280D22@SEZPR03MB6891.apcprd03.prod.outlook.com>
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
In-Reply-To: <20250314073307.25092-1-Lu.Tang@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMjQ5NjdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05MmY0ZDkwMC0wMGIzLTExZjAtYTlmNy1kOGJiYzEyN2VkNjJcYW1lLXRlc3RcOTJmNGQ5MDItMDBiMy0xMWYwLWE5ZjctZDhiYmMxMjdlZDYyYm9keS50eHQiIHN6PSI4NDMyIiB0PSIxMzM4NjQxNjc3Mjc3ODA1MDIiIGg9InhXZWJoYTUyUnc3SE9LOWNJZ1lIOENVYVpPcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6891:EE_|TYSPR03MB8506:EE_
x-ms-office365-filtering-correlation-id: 92727f5d-c556-4cb6-276e-08dd62d7794d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWF3NnVBaTJuTW4zQ2NmVEpsNnlzZWUyNTNLZ1FyZ3JRUTdDUEkraUhla1RT?=
 =?utf-8?B?U01WMzBjU1hmMEFFNitCSEdTL043N0l1bXY1SWxaVVdNNitWUjgxODEwVkxo?=
 =?utf-8?B?Wmh1R3N6ZEZaS0lnaFAvYXpUNzhIM1NXNE5UdU5NZk15L0FjaWs4S0wzNndN?=
 =?utf-8?B?c3pnSGx0SkN3d3M0Tm5ybDlXK096YlI4VUE2aGpsODZLb2tqeEw1K2tVZGVG?=
 =?utf-8?B?RkdxcExLRmV0QS93bnRIZUhad3NzOG9JdnhaR0NCdnJmYzVURE5HYUtlU0o3?=
 =?utf-8?B?Ky94TmRpeDFkWkNjdWJ1Y1N6aTlETW11NDIzLzc2Yjhwdk9tUjFIK3hXOCty?=
 =?utf-8?B?MVI1cENDMmJrbGNObGg0cGtCWlQ2c0g1Z0hjVGt5WElXTDlib3N3YWY1cnpS?=
 =?utf-8?B?TVFlOTYzN0ZoZ3ozNWM1ZUdjT3dYaWxLdnlmVncyZDBYbnAwcVVyOUt1b0Ny?=
 =?utf-8?B?NmN2amdjbXRnR3BuUHozaXRsb1pFRW05WmNkYjBxcm1tOXhkdFBEMitmS0p3?=
 =?utf-8?B?NStIYlp5b29ueTdXdmtmRDN0L2J0SXRFM2RrQndWTktLYjFGcVR6RjNMZ0Nw?=
 =?utf-8?B?Q2h0aGJmandKWUNTRjRzcEZuWnVSQnFUd2lEeTVUeHRtbU1tanpMRXkrRmt6?=
 =?utf-8?B?cHpMUTVJV1BNV3BMemRaTUp0VEk3M2tBUEdVcnJ2ckZOWjdld3JTMnpvL3lk?=
 =?utf-8?B?QVM3bXZjZUlBRUZEMlFwKzhmUlFrcm5scHdaT1ExZzI2QktoMlZGQWRCSnpX?=
 =?utf-8?B?K0I2bThLSW1RbEk3TmM3b3NoS2piWnU5eTJFV3NJMXF2V1k5SEs2ck93bklC?=
 =?utf-8?B?N0ZjZ0RhcEtwMEgxYjliSmV1VjFBU2Y1MkZSNHJRUmNSRVhIb0tXam5Ienhn?=
 =?utf-8?B?ZmV6S0IxbnhSQ2ExVDVrc3RaSExuWXdhL2U3WnhFallKTmJJNHNFb3pQMlQ5?=
 =?utf-8?B?YXJaMkhuMjlkWDc1cTdrQzdRY1A1amU4dnMxYkplUndwd2d1L1VXNzMxaHZ3?=
 =?utf-8?B?djlQNmRDVWRwN0pEemEvRjJEOVlpWGg1Mld2K1JyeWMwZXUrOFFvTmtHa09S?=
 =?utf-8?B?OFplRXhlRGpzdGZWYm9lci9EdzduYmRCOW9GRW1RRWFQM2RacFRQY3hXQUJV?=
 =?utf-8?B?L0szL2F1UWkrZGhoVE9kNGFRWm9oWlovQkd1MThGczNpNmFUMVZTVnM0QWlL?=
 =?utf-8?B?V2pNRnBGSDlHT1M5bmpZQUlrV3dJaU8vdjIzS2g3N2RuOGhUTldKVURjVGpy?=
 =?utf-8?B?RHduMXpvb3k0c3A0cG9GYVdUelB0YmlDUURtRXdHZktOMWpKTkNKOG5kVWoz?=
 =?utf-8?B?ckRzWUtUK3hzUGU2dXJ2NGtEMlNuRWtyM0N5WHJwUCswRjJKQXBKM0drTDVZ?=
 =?utf-8?B?VTV1elBOSFRmRXJrWXpvRk1XRmczaytaMzIzalRpejlaSkVSK282NjkrNEUy?=
 =?utf-8?B?RzJxbXoycnRvZjdJNEhmR3lBejlHQ1ArVllOdVl2TGFheG5pc1A3WHh6UVBO?=
 =?utf-8?B?a3BleTFEaDFjNG94UTI3WE1heVNNaVlDU3NwdkxZOHRQVUpFd1lHbTdBb1Fi?=
 =?utf-8?B?cDlqc2dveHpHY1J0Y1kvZXdYdXlxV0xFRG4vZEpqcFdnbVVoYTI4RnVzcm5q?=
 =?utf-8?B?NGgzcXZMWXgzRVlXKytFOWJnTUt4TGFBcHU0dzU3NWZabXk2OC9GRjRqOHRN?=
 =?utf-8?B?U04waE0wR0g5dGt3WXY5UC9CRW5LNWZ6MkptM1gzM3BWeXBWRUNJSmhLTXdM?=
 =?utf-8?B?QXIzSkdDcGEwNTJnTUdyU1hOZ2dTc2xKSGNlM1lrTDhiR0p0ZVk2SW1hUFo5?=
 =?utf-8?B?YXNSbDZGdmc2aTYvbFRlZ1R6NDY2U2c2dVB6bjFzSXRmR0F6UDlmODREVG9I?=
 =?utf-8?B?UWVTMnh4c1Znb3lQMkVrdldhUWRzek10NmlSc1ZuelVmQlZkcnFrWnlHcUlN?=
 =?utf-8?B?MUJFd1V4NkZuS3lMK1VINFdsWHpRaWowcmpmUXAvc3JENlV1ZjVTUFZoNlFi?=
 =?utf-8?B?WXl3UXQ2NEl3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6891.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWdpaSthaHNRKy9iN2x0OTNyaTJtK3NMeENmaktidldoaHlwMlFTOHdBSVF6?=
 =?utf-8?B?YkZxa2hveXZKQk5Gbm5uSjZSeUZBcVVUQ1BFREZsUWhEbWFhZkZpRVFQS1F5?=
 =?utf-8?B?RnUvSWN3WlhuWUxnVlFuVVVsaThxOUgvSEFXajlxcVdZQ1J5d0wzcFlUcnJk?=
 =?utf-8?B?cm1USkFoaUFTSDNlYXI1b0h3TFRydFljRTJOOThtNXVQOW8xTVh6cHFWN1Yw?=
 =?utf-8?B?V0xoZm5CSXhlU0tnQW84ZWpPcVovYmZ0OXRqZnFHUFA2Sk9pU1BRUWUxMHd3?=
 =?utf-8?B?andhVFhYSHRtYXRhazJTZXZpZTVlbkZIVUxTeUZ6OGRHQjVISGIrMll1ZWNt?=
 =?utf-8?B?UlBmUHpGRVkreDJKbTZaV0dpemdkQ0c5UHIxcmZsMzdWVm1UR3JYZDVGUk1Q?=
 =?utf-8?B?a3NOOUUzQWxUWFNQanp1OHE4MzJkOTV4RktRTkZDL3NNaVYrWWkzWW0zZTlj?=
 =?utf-8?B?bXUwaXJWWHF2ckZBT0E5VHZpR3FCSCtiZVVzRkdJN0Y3RHM3TFNFODQvQjlh?=
 =?utf-8?B?enZ0VDZVeENwdlJubTI4SVBkaUM4TnJiSTdWcmltem5xeEU1Yi9yZ2U3Y3ov?=
 =?utf-8?B?MU5oMjU3dkgvQ3ovYURVQ0U4WkNMMCtMNzZPWWsrSTY5T1I4VG9kckFRNHUr?=
 =?utf-8?B?ejNINmJrMWpUQytsTWV3VVlBOC9lTDRvZEU4OHhEQXFrSVpWUVQ5UWM3VUtN?=
 =?utf-8?B?RXg5WFVnNUw4Yis3ZVNocHJ3S1ZiZWRBay9wSm1xc1RDN1pPV1ovYjNsdWg4?=
 =?utf-8?B?UTJ6dUpqZEs5ckFyYmFvSVk2dE85NnMrQmxpVVBCWlltZFpJUXY3YXc4OVZU?=
 =?utf-8?B?bFQ2dGE5SG5kTWZValVFTWpRUzB0MzJDVkN1bWpXdG8yMFB0Z29KVGZGcmZP?=
 =?utf-8?B?QjhEZGZBekZEMWZpY2dMK1E3VGpxOXM4T0pZNVRpZ2pnT2poRURDTTEydGFB?=
 =?utf-8?B?SUpkSXljak5odEhYZzFwR1ZMTWZCYnpyYzI5ZXBtaXFHVkZCeXVkbnFyUlVJ?=
 =?utf-8?B?Uk41U2YyRHJDbHVkdTNqcUlMUjRWRzBmdi9BZWM2TTRyZHRvbDBCOFcyczI3?=
 =?utf-8?B?ZFRMaElGWG9mQVZpODhkSUFTUDZWWUh0blFTNlZzcU9JUVZTM2o5eDdDKzdl?=
 =?utf-8?B?Si9lNVY2bzMzUDZUMGlWaVU4RzZ3UW1iOUJrd3dmOXk0blJTSTF3Y3RWZG9l?=
 =?utf-8?B?VklDYzBWV0hVazlRK0VtZVNhTWtDcHVYNHoyOGVMeDBWR1RuOE5rRFVkQVhR?=
 =?utf-8?B?OFpQU1dQeSs3U0dyTWQ4WEc3YVlLM2Y1akJ1SFRWTThwcy9DeDMzbCs4RmMx?=
 =?utf-8?B?MFVKdHJCN3NlN3pHeUE0R2UvSUUvOFVmTEJIR1JCQTRtREMrM2FDeFFiWFZU?=
 =?utf-8?B?ZU9JVitGdml4T3pXd3RNNWsvYXFpWGNRSDFsdmlmRnJXK0hDVFhoT21YcGVv?=
 =?utf-8?B?MG1mamhNSjZVYlJOVldqSmlVWVUwWTRpREZscjBaSVBYR3hLZVBKSVVyVW9L?=
 =?utf-8?B?S0s3R0lURmxvZ0FQeG8rc3pVVTQ5ZklQRWU4Y1kvMFE3WmFHcDRoQVlza0U3?=
 =?utf-8?B?S3I0MjBjaUlaNVJIaERpUy9kTU13cWp5Zzkxd0NoblhJamFwODZjZ2MxeE1h?=
 =?utf-8?B?bkFTNTFrWTVpVkM2dncvelJ5OUtHRmFVTXZEbCsybUN0REdKZGwxN29mTG5O?=
 =?utf-8?B?NlMyRVJlQnp3N2dUNEoya0sxaVFWYmZMT00yQ1BlNXRiZDFWZldWYzlMZGVa?=
 =?utf-8?B?VlhtUXA0RDB6YU5ESThWbS9GMjZRb0FwQlo4bUhvR1pvelJ6R2lIYXFqSTg2?=
 =?utf-8?B?aTJjSFFzRkJOTXBsOFgvdm5jL05TZWhvREt5TnYzaEVCamVieE13NzJIbXJU?=
 =?utf-8?B?TVl2enF1dGc2bGdhL2RGd2pvRC9Ldy9pS1BFdFU1T1RZQ0pKcExqKzBacVdk?=
 =?utf-8?B?RWxTQVJjUlJPWmZFMWg1Um5vQ2FQQWZNVkVHKzI4RGhOUHdoUGxiQVVjTFRJ?=
 =?utf-8?B?TDg1dXcrMXFiM2VGQUw4MjZiY3VtbGhVVEdFYjRTMXV1d0ZNSXBpRzBsRGg4?=
 =?utf-8?B?QzVmQ0ZSa05vOGtpL1U4M0MyYzNoRTRCTjAzNXFGcEhWaHl3TkM2eXhyS3R0?=
 =?utf-8?Q?Xy9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6891.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92727f5d-c556-4cb6-276e-08dd62d7794d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 09:06:14.9010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fK0tnQSA6A3UHmnK0MtZEoJWHMatO3emEep0AMVGDLINq4xLhvXtKzM801Dv8PoBfzggiVNshv6+BAPh8iFkfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8506

DQpVcGRhdGUgZW1haWwgYWRkcmVzcw0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bk
uro6IEx1LlRhbmcgPEx1LlRhbmdAbWVkaWF0ZWsuY29tPiANCuWPkemAgeaXtumXtDogMjAyNeW5
tDPmnIgxNOaXpSAxNTozMg0K5pS25Lu25Lq6OiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJu
ZWwub3JnPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwu
b3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRG1pdHJ5IFRvcm9raG92
IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPjsgTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz47
IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+OyBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPjsg
U2VhbiBXYW5nIDxzZWFuLndhbmdAa2VybmVsLm9yZz47IExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZz47IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5l
bC5vcmc+OyBDaGVuIFpob25nICjpkp/ovrApIDxDaGVuLlpob25nQG1lZGlhdGVrLmNvbT47IFNl
biBDaHUgPHNoZW4uY2h1QG1lZGlhdGVrLmNvbT4NCuaKhOmAgTogbGludXgtaWlvQHZnZXIua2Vy
bmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgUHJvamVjdF9HbG9iYWxfQ2hyb21lX1Vwc3RyZWFt
X0dyb3VwIDxQcm9qZWN0X0dsb2JhbF9DaHJvbWVfVXBzdHJlYW1fR3JvdXBAbWVkaWF0ZWsuY29t
PjsgTHUgVGFuZyAo5rGk55KQKSA8THUuVGFuZ0BtZWRpYXRlay5jb20+DQrkuLvpopg6IFtQQVRD
SCAwLzVdIEFkZCBQTUlDIGFuZCBTUE1JIGRyaXZlciBmb3IgbXQ4MTk2DQoNClRoaXMgc2VyaWVz
IGlzIGJhc2VkIG9uIGxpbnV4LW5leHQuDQoNCkNoYW5nZXMgaW4gdjA6DQotIE1vZGlmeSBTUE1J
IGRyaXZlciBmb3IgbXQ4MTk2DQotIEFkZCBTUE1JIFBNSUMgbWZkIGRyaXZlcg0KLSBBZGQgUE1J
QyByZWd1bGF0b3IgZHJpdmVyIGZvciBtdDgxOTYNCg0KKioqIEJMVVJCIEhFUkUgKioqDQoNCkx1
LlRhbmcgKDUpOg0KICBwbWljOiBtZWRpYXRlazogQWRkIHBtaWMgYXV4YWRjIGRyaXZlcg0KICBw
bWljOiBtZWRpYXRlazogQWRkIHBtaWMgcmVndWxhdG9yIGRyaXZlcg0KICBwbWljOiBtZWRpYXRl
azogQWRkIHNwbWkgcG1pYyBtZmQgZHJpdmVyDQogIHNwbWk6IG1lZGlhdGVrOiBtb2RpZnkgc3Bt
aSBkaXJ2ZXIgZm9yIG10ODE5Ng0KICBkdC1iaW5kaW5nczogcG1pYzogbWVkaWF0ZWs6IEFkZCBw
bWljIGRvY3VtZW50cw0KDQogLi4uL2lpby9hZGMvbWVkaWF0ZWssc3BtaS1wbWljLWF1eGFkYy55
YW1sICAgIHwgICAzMSArDQogLi4uL2JpbmRpbmdzL2lucHV0L21lZGlhdGVrLHBtaWMta2V5cy55
YW1sICAgIHwgICAgMSArDQogLi4uL2JpbmRpbmdzL21mZC9tZWRpYXRlayxtdDY2ODUueWFtbCAg
ICAgICAgIHwgICA1MCArDQogLi4uL2JpbmRpbmdzL21mZC9tZWRpYXRlayxzcG1pLXBtaWMueWFt
bCAgICAgIHwgIDE3MyArKysNCiAuLi4vcGluY3RybC9tZWRpYXRlayxtdDY1eHgtcGluY3RybC55
YW1sICAgICAgfCAgICAxICsNCiBkcml2ZXJzL2lpby9hZGMvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEwICsNCiBkcml2ZXJzL2lpby9hZGMvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL2lpby9hZGMvbXRrLXNwbWktcG1pYy1hZGMuYyAg
ICAgICAgICAgfCAgNTc2ICsrKysrKysrKw0KIGRyaXZlcnMvbWZkL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMjYgKw0KIGRyaXZlcnMvbWZkL01ha2VmaWxlICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KIGRyaXZlcnMvbWZkL210NjY4NS1jb3JlLmMgICAg
ICAgICAgICAgICAgICAgICB8ICAgODMgKysNCiBkcml2ZXJzL21mZC9tdGstc3BtaS1wbWljLmMg
ICAgICAgICAgICAgICAgICAgfCAgNTE4ICsrKysrKysrDQogZHJpdmVycy9yZWd1bGF0b3IvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgIHwgICAzNCArDQogZHJpdmVycy9yZWd1bGF0b3IvTWFr
ZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAgMyArDQogZHJpdmVycy9yZWd1bGF0b3IvbXQ2
MzE2LXJlZ3VsYXRvci5jICAgICAgICAgIHwgIDM4MSArKysrKysNCiBkcml2ZXJzL3JlZ3VsYXRv
ci9tdDYzNjMtcmVndWxhdG9yLmMgICAgICAgICAgfCAxMTA2ICsrKysrKysrKysrKysrKysrDQog
ZHJpdmVycy9yZWd1bGF0b3IvbXQ2MzczLXJlZ3VsYXRvci5jICAgICAgICAgIHwgIDgyNiArKysr
KysrKysrKysNCiBkcml2ZXJzL3NwbWkvc3BtaS1tdGstcG1pZi5jICAgICAgICAgICAgICAgICAg
fCAxMDQwICsrKysrKysrKysrKysrKy0NCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNjMvY29yZS5o
ICAgICAgICAgICAgICAgfCAgMTM0ICsrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2MzYzL3JlZ2lz
dGVycy5oICAgICAgICAgIHwgIDE2OCArKysNCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNzMvY29y
ZS5oICAgICAgICAgICAgICAgfCAgIDk0ICsrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2MzczL3Jl
Z2lzdGVycy5oICAgICAgICAgIHwgICA1MyArDQogaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbXQ2
MzE2LXJlZ3VsYXRvci5oICAgIHwgICA0OCArDQogaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbXQ2
MzYzLXJlZ3VsYXRvci5oICAgIHwgIDQyNCArKysrKysrDQogaW5jbHVkZS9saW51eC9yZWd1bGF0
b3IvbXQ2MzczLXJlZ3VsYXRvci5oICAgIHwgIDMxOCArKysrKw0KIDI1IGZpbGVzIGNoYW5nZWQs
IDYwMzcgaW5zZXJ0aW9ucygrKSwgNjQgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbWVkaWF0ZWssc3BtaS1w
bWljLWF1eGFkYy55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZmQvbWVkaWF0ZWssbXQ2Njg1LnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9tZWRpYXRlayxzcG1pLXBt
aWMueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lpby9hZGMvbXRrLXNwbWktcG1p
Yy1hZGMuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21mZC9tdDY2ODUtY29yZS5jICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZmQvbXRrLXNwbWktcG1pYy5jICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9yZWd1bGF0b3IvbXQ2MzE2LXJlZ3VsYXRvci5jDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcmVndWxhdG9yL210NjM2My1yZWd1bGF0b3IuYw0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3JlZ3VsYXRvci9tdDYzNzMtcmVndWxhdG9yLmMNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvbXQ2MzYzL2NvcmUuaCAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvbGludXgvbWZkL210NjM2My9yZWdpc3RlcnMuaA0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNzMvY29yZS5oICBjcmVhdGUgbW9kZSAxMDA2
NDQgaW5jbHVkZS9saW51eC9tZmQvbXQ2MzczL3JlZ2lzdGVycy5oDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvbGludXgvcmVndWxhdG9yL210NjMxNi1yZWd1bGF0b3IuaA0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3JlZ3VsYXRvci9tdDYzNjMtcmVndWxhdG9yLmgNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbXQ2MzczLXJlZ3VsYXRv
ci5oDQoNCi0tDQoyLjQ2LjANCg0K

