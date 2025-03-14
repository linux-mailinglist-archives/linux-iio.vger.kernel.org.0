Return-Path: <linux-iio+bounces-16831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2D0A60D1B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 10:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EBD1751E0
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69521F03CB;
	Fri, 14 Mar 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nq88oBdP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="d0ToN0Bh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367D1E04AC;
	Fri, 14 Mar 2025 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944102; cv=fail; b=l/fPXrEgGcKlY2iao8JbdrYRH0RFYoxUNRHq4uPqvP2vgDqqmIlBu2tIgNev3tKheJGt+EUZj1MCZSUqFQpf86eIwSb02Iqihd6M1AaFZxY+VbjDcBr2GSsjF3PiFGgzo6H4GZ8qWNEA/Pe3cuzpv/dqAjHzNRWJGiBfH1laJ7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944102; c=relaxed/simple;
	bh=18dhHqjVPVz7pq3PSgr8a79pLVPBK2mxlBgyJKY1HY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ijVty8rdpgz/pb/6kDx9fc8P7ApI6IoGnYTGJTFfafMCF0smECHuQPx8Od1ZFe+ql72ZdbR4QJDz//l5bYfOdvuv+y1POWmFpqBwIcPCfBlLlf60P3vkcyCwoWgsEI32W0CNj2oQpPzZ7S0Pqaf6/As/8yYQH31mBRWKRgq329A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nq88oBdP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=d0ToN0Bh; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b8fb9a5e00b511f0aae1fd9735fae912-20250314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=18dhHqjVPVz7pq3PSgr8a79pLVPBK2mxlBgyJKY1HY8=;
	b=nq88oBdPmvytkoMpKqUuje22P2mDTujEEOf/pRB/FbDFIC0K0sxhnAHYc+HZS9RksaG6+f9jbnGhVYyMR7Lr65sgiZXfTsGlJOcgGAAbT6oRdBecbm71VWzUk+aEtZVwyGTuaHmG4v7ij4PSDutGaFmnRxjjqW1K5FTbnISghPQ=;
X-CID-CACHE: Type:Local,Time:202503141705+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6136f48e-6e78-484b-acf9-d3e7dff2edf2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:0aa556c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b8fb9a5e00b511f0aae1fd9735fae912-20250314
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <lu.tang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1471991949; Fri, 14 Mar 2025 17:21:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 17:21:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 17:21:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xgy0pgxyeWGRn9NJvwWGKHzORcmRaijQJPz/1YcFuoIhRNTxdFVjWezVxABuntX9bs3svKZP/kWTRb1eT9OwFExTA60uvOj+D5ybwSwsT2W54005+PgkjSlR0+L8NjPUdMlRL/tnQK09fwst052B72OwaR+2zDv2Z9XyRb1MRklUoVvWr9elvfxyRnwcOdxRZVxfYwzfSwAc5CDvM7T2vE16KUmcZIx3Q8RIOncA+bXcQx5g7ZydJpOTkDgcCMFw+HhMaEM+BGUS56HM3rlGGuAkr+cuZPoyENIP6F6XRzDeREPqISCtwxRnNkLz86/xBixoOL4vHvp6pt8xI0Xjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18dhHqjVPVz7pq3PSgr8a79pLVPBK2mxlBgyJKY1HY8=;
 b=VBIWj1GP4zrOXP6Dcx5e7PYKFIxsSrzyIb2c6JukPYnmv2FYyAxx/x7nMhXKsviQP1N09FYjQMilg2bkHMOQAXRAgLTrgvTL9hdrUwwh4igA1BV5NRa94oXuWu1KGK8ON71DL2zyFe7tYAe2crX/DGXRDJzIFkyF+A0Tzphn1XpuDGDbff9onYVnoseJVz5SFtDc3PNyADPsMcWg1yudKoGoQvnCaDjAV+L7OUL3UWmFSF2nvfplbbg6pf0T0ThLfLfVZlH+kpoDJxcEPlLX3ed7FxeOqi44hAWBf1NtrFd1FTHop9zZdc1esZhNmn18rjnWiMi0XIRVSyU4+Zm2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18dhHqjVPVz7pq3PSgr8a79pLVPBK2mxlBgyJKY1HY8=;
 b=d0ToN0Bh6X1lDGdcSIgUEvDjXjSdTdGKq3M09ySx+GHg2JUx4T/rHK52VYL6MRjNFMMggB97Y0gv8NKkouaYcBBXpkqh4h33YPnYyXYyPONAsEG02pKl7nCs01AB4zz7l6waAiIMlMyX3gfCwHvU3HN+NSzUR1N5EOHp11GyObk=
Received: from SEZPR03MB6891.apcprd03.prod.outlook.com (2603:1096:101:a2::5)
 by SEYPR03MB8549.apcprd03.prod.outlook.com (2603:1096:101:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 09:21:30 +0000
Received: from SEZPR03MB6891.apcprd03.prod.outlook.com
 ([fe80::579a:f8c2:b6e5:c2b9]) by SEZPR03MB6891.apcprd03.prod.outlook.com
 ([fe80::579a:f8c2:b6e5:c2b9%2]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 09:21:30 +0000
From: =?utf-8?B?THUgVGFuZyAo5rGk55KQKQ==?= <Lu.Tang@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	=?utf-8?B?Q2hlbiBaaG9uZyAo6ZKf6L6wKQ==?= <Chen.Zhong@mediatek.com>,
	=?utf-8?B?U2VuIENodSAo5YKo5qOuKQ==?= <Sen.Chu@mediatek.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS81XSBwbWljOiBtZWRpYXRlazogQWRkIHBtaWMg?=
 =?utf-8?Q?auxadc_driver?=
Thread-Topic: [PATCH 1/5] pmic: mediatek: Add pmic auxadc driver
Thread-Index: AQHblLaJXX9H/Syj+U6AeRYOMKgksbNyU6qAgAAHanA=
Date: Fri, 14 Mar 2025 09:21:30 +0000
Message-ID: <SEZPR03MB68910F9B60DAF0060440503980D22@SEZPR03MB6891.apcprd03.prod.outlook.com>
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
 <20250314073307.25092-2-Lu.Tang@mediatek.com>
 <90d1c0f2-b037-482e-a569-f75b713e3a71@collabora.com>
In-Reply-To: <90d1c0f2-b037-482e-a569-f75b713e3a71@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMjQ5NjdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iNTRiMDcwNS0wMGI1LTExZjAtYTlmNy1kOGJiYzEyN2VkNjJcYW1lLXRlc3RcYjU0YjA3MDctMDBiNS0xMWYwLWE5ZjctZDhiYmMxMjdlZDYyYm9keS50eHQiIHN6PSIzMTE4IiB0PSIxMzM4NjQxNzY4ODk2NTM2MTkiIGg9InhPUE5tVXBQbmUrM012NUF1OVFWSHpFSGNnMD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6891:EE_|SEYPR03MB8549:EE_
x-ms-office365-filtering-correlation-id: 9577460a-723b-4066-bdc9-08dd62d99ae5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?S2ZmRDhWM3l1WG9idXRRSnZ0Q0h1cGl4Y2FTWEZFYStxVTFQNDY0SDZqNFc0?=
 =?utf-8?B?LzUxTkRUNXlETVp5blA1elVNbW5rOSt1Y2dXY3NnSFJrdFhmelpVdHBUMGJJ?=
 =?utf-8?B?NUJyVGp1eXJqZnptenFydGxHM29EdEtpQTVzTlB0L0QvcHRYM2EzUFlzYTh4?=
 =?utf-8?B?NUlHVWIyN0FXbGY0Z3FjRHhTUXI4VUg5RVdtY2M3OEZGd0NYekJJbnZvbTBG?=
 =?utf-8?B?b1dOaTgwOHFRaXc5WTdHT2JNWHZNeFkwd25mbFpaSlkyODRHMGVpQWpvNi9O?=
 =?utf-8?B?ZEZNVlN5Wi9OSkp6dWNRNm9HQ0hBSS82TjVsTy8rS2ZGR2NaMzhwbUw1L3lm?=
 =?utf-8?B?SXVXdWJnOEllSWgwejQ0aVlPaHN0VzZZcW13Y24ySmsraFBhVWRnUmJqejhz?=
 =?utf-8?B?a1Zpc3RWZG9CM3AvbHJWQVRzbE9MNE9WY0pmalNEemljb3IyRWpOdFZIcUFj?=
 =?utf-8?B?SGxYdExIc244TGp5OFc2QkVhVnN6VzVVamV6TDRPUlNqTTdyMnJUeDFOVHd2?=
 =?utf-8?B?UjR3ZGhTSHhrZ1FNVWt2NEZPaVlQVERLaWFRUjB6SEZzZ2t6VXFUMEI5V1JG?=
 =?utf-8?B?bHluTVR0c2xDTDhWQ3hOYStNUWN3dTZhUFZzbEF5KzNXUWpnd3pMNmFFcjJh?=
 =?utf-8?B?clN0S1N3NmpvWlIwMlJZdGJjY2dyWGF0RjIzQVpEYXNlWmhBeG5ZcjlWbFVU?=
 =?utf-8?B?VGJQMGpwN3lvdSszVmhEaGhTU0ZxVG0zZTZMQ1lmYWI4R05lbGVBa0NtTEtq?=
 =?utf-8?B?NyttU09nSlNMdVMzZjZKUkRQL1lIQjdJRnBJakcvR1hXenJQbGgyY21wQW5a?=
 =?utf-8?B?citWRUZHd2o5Q21pNVYwQXBBK0ZpM1RkVUs0Tkh4VHNLbE9GeVNXb29RVWN6?=
 =?utf-8?B?bSt6Wm5oY2ZuQzVoaGtCWHcvcFRORHdHcTg1OGxNSXlhMnlCK3o4aW1oa3F4?=
 =?utf-8?B?UG9KQTE5d2hyeHk5UnB3Nm1Zb0RRViszSjdkNGkrTlF1QVJUTE9WNW5QK2w2?=
 =?utf-8?B?UXZUdzZIcjlFeVJteVdPcGJoVVdwV3VrM1hseWQ3YXNnZkJGNHVaV0dieWRD?=
 =?utf-8?B?dHpKbko3M2lvVi9kVXlLT2JUMWIrL2Z2ZUwyNzJibXZ4WE56bUVWaHVrVW84?=
 =?utf-8?B?bzc4c3luV08wYUFvNnl1QUlNUWsyUlllYVRYQ3prN2F1NytHQmhGNFB6WmlT?=
 =?utf-8?B?ZVczd2VGR0JGKzJqQjdqUFJXZ2NFRDFFV05hVlNZK1VVbTI5ckFNKzBrNFZP?=
 =?utf-8?B?UkV3ckhwcEhYcWJ2aFBPbjJCWi9nN3d1ZGlubW9sd2xmdmdZa3kvYU5vaUZN?=
 =?utf-8?B?Qm9MUnBMcitiL3ZZdTh2akVTSTZtWHpPVDZMMkVrcXVWY1UxY2V5K2U0RDEy?=
 =?utf-8?B?RUM0ajVPelpDV0pZUHhIMDlTeGY3V3ZVa2w4bGNUcEkyOGxpZjJtVWpTaVBS?=
 =?utf-8?B?VGNuNWJZSnhCQldqRERnK0Jqejc2eURJUE10aUJuODZja2QxS2MxcGhwT05p?=
 =?utf-8?B?bnlXQm0yWHNxNkRlSm5lOWRPNHIveTQ3VWJYaWcrbEJwVnN0TEticXppbXpk?=
 =?utf-8?B?dC9NeFpISjZ6U2Fpd2pyUHFqSWk0Wnp3cUZDaHAwa3JPRVVCSmZzMElUdXBk?=
 =?utf-8?B?UlJGWEI2eStWemtibEhNY0lQeS9qVjhCR3BqVmhjckcranVZbnVBS3lSODR6?=
 =?utf-8?B?eHRpd1ZKSVhzdUlLa1FRZDFiTElLSytHckJvbnlyaVZ6T3p1SUkwZm1KWWNP?=
 =?utf-8?B?cm9BNGxLNnY3ZFR2L2tmbGJmdGgwZWRvanlWclM1cHQ2ekNEemxXdHlOVG1k?=
 =?utf-8?B?VDNNS0Vuc1hOSnBWNmdQM0xLSHdvaEQycU91cEtKaCswZThqNHIwTzlQSzNx?=
 =?utf-8?B?cExHYy9TaWNHV3BIUURFMVpDeURXTDhid0RDL1UvNUFCUFp5aTBZUzBNL2N1?=
 =?utf-8?B?dUF0RzlTSG1uQVFnb0lKQ0FMN3NoR0dQZFV0K2lML2p3WjdhZFhGbkx3aDJK?=
 =?utf-8?B?VzZXNkpiSTFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6891.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTlNQ2dUTkhQcnFzMW9DS2d6OG1rSlcwODgvRlZvVitYRll5b0RsTDhuZWZ5?=
 =?utf-8?B?MUNtbm50SVpRVklqb1hVM2RuaXY1T3h3YWZielIzVStnNWx6blVMNGEwbjhP?=
 =?utf-8?B?bmNqanp1bFNmUnlMMEo3RHFGa2JMR2YrSUxzb3lNV09RamZFTzFSRThWUENq?=
 =?utf-8?B?SzdXN0s5TFl0ZUlNUXlrTU53NHpreDhyM2R0WlQ4WFkvbGZUaXdYMFdrY3gy?=
 =?utf-8?B?VkV0ZkNPNUVVbVRrc1ZtS3dSVjdIUjUzTHBBazdtREJvOFdLcHVmZ1MwRnpz?=
 =?utf-8?B?S0RLQlljUVpDU0NwekdtbFBUNzgrYjB6a2ttTkxibGx1bm8yNWhvcUcrVW9V?=
 =?utf-8?B?MVp1ODcxMUlNQmdFRHMxNVNGQkR1N0FseGpROHlrRmdjbTlxeFBZS2V4TkIz?=
 =?utf-8?B?R3llckh3UHIrcTcxWnRkNTJoQXJKNTBBL1U4VXc5S2thaC90dm9jV2hiOXBo?=
 =?utf-8?B?UW5hTHhIZzBncStRTk1raUdjZVI1Snc0Z2pHNnBrbExuMk9zcXQzaE9HUEQ0?=
 =?utf-8?B?RXpQRk1GRWwwYmsyWTZvRWNwMkNTNGNWMldHOFRDaFd0OHBmSjFRMEhlQkxO?=
 =?utf-8?B?WCs2NlFWUG15dDYyYVkvbUJ3QUdvd3hMQmJCaWl6ZWFjR1lTNGxRaUVvVWRn?=
 =?utf-8?B?eVBpYjFrTHZ3TXNXSnNkSFRHdXFJdDhEQlI0c2JTNi83eWNMLzl3QXVrcXVV?=
 =?utf-8?B?RFJWbVdLMm1RMFoyMVNmSDNhMUdhYTd1SFRlQzd4L2tPc1B4NXlHOG0wNmt3?=
 =?utf-8?B?aHJvRkJ1OEdoeDg5UzVRS1krd3ZraFpLaDVtajBnQUV1aFhrelNSYlVDeEE4?=
 =?utf-8?B?bXBNbFMvODAxUGY2Szg1RTlmUjB0cCsyTzBJRUd1SFlpRVdCK0t1OEpXeVFQ?=
 =?utf-8?B?TG8rZFFKeFFaNGtNMExDc3dRSmd2dElCT2hSYVBUcjZZRlhZbENIUUpyZkh4?=
 =?utf-8?B?YkFmdjhEKzZuZktlTTN5Vm9YOHhTeVNjc3RNODZjbk5kcmdyV0ZuUUxyZHFY?=
 =?utf-8?B?c0FrZWU3bC90Ykw1VXJrTDJJNVZTanoreTJpVlJQbmZoV1Azb0wyTlhsTm5v?=
 =?utf-8?B?c0Vwdmw5d3FYaVFmRU1raUJ1dWZSOHlPWmFuVENMRC9vQXF6RUtvZEk2N0JF?=
 =?utf-8?B?aHdmcVlxQU1LYkdSa3hDK3UyR3F6YVZvOTRSRS91REtIYzVpR2xDSkN2bnBC?=
 =?utf-8?B?WnNrRW1DaEluek9lQVI3NzVoTEhUQ1hiS09ldnBXdWNJS0hxTGJDYkprelBW?=
 =?utf-8?B?K3M0SHo4N0RvSkk0OC9LbGRIY2svNWhWemx1U3V0ZFJUQ2dJZ1ovRmFmRitY?=
 =?utf-8?B?VlcxN3l0blVYNDczV01MZCs0UGxzcGZxWE1CVm85WFVWNHNzcGZZMjkxS3U0?=
 =?utf-8?B?QVMvRXpHMjFGOFduZ2psRzFCMWFwLy9WajlVbk95MUJ6Q0ZlaDZkU3c5NE9Y?=
 =?utf-8?B?djFHaEZhZ3FwMy9VclhyZ2xFS1NXZWdKTGJZU1hUKzZLM0E5NDRXR2d2MEZV?=
 =?utf-8?B?VXVpSnY4azBrdjdaQ2J5cHhJTlJWVkF4RUdGbFFFZCtOamhTUG54bVZ2WFgr?=
 =?utf-8?B?RUtBSzcwUUZGak5FMGtUNms3Mm1qd1NPTzhxYkFzTWJzNkUyRjRBczhnK3ZD?=
 =?utf-8?B?ajdoWGRFZC9PdHJBMk1waDhhWStOMWFYOTZSOGoycTk4THAwZDBoYW5SVGZL?=
 =?utf-8?B?ZnJQd2ZBUkJjdEJTekh3NXVhTzhTRlJCeE9xUGhpaVd0SkI5OFN3RGdHdDhv?=
 =?utf-8?B?L0xYbGpmYzFMWHgvNDZreW9xbFNjMEJoVjlyRkJxaDNhRHp5UUpYQVV2SXUr?=
 =?utf-8?B?WDl5dlFWRjVoanVtenJQZGRKY0RsV09nYllJVVBrcm1leUJZMmJ3OG02VURk?=
 =?utf-8?B?NTFFczBNbWowWHBKWFVpN3Q1L1BwaWRQREZjK3hYNkRYNU5BRi9SbyszOG5L?=
 =?utf-8?B?eWVwSzNzbFZZUDlBMkxuMDJxN1BrMmlzRkZDdkU5Z3dQam52Wldib1krMGt4?=
 =?utf-8?B?L3hsZ0VWdUVIZlhZaUlYcjBFN1dXMTc0cmRkVjZBeWlkUTRrcHdPZ0xaRkFm?=
 =?utf-8?B?RWh6czJyRU1lZkErMHhDVDZDZElzZlZwdk4wTlNNb1ZpeXhLcFZiVkNzS01S?=
 =?utf-8?Q?yCBk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9577460a-723b-4066-bdc9-08dd62d99ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 09:21:30.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbkzcGFV24V3a62xZC1GsaapVyuaid0ztogu9T0BH5sR8SZ6LebsXHILprOqYP12QwWGjF93jklD3t/expBz0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8549

VXBkYXRlIGVtYWlsDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3Jh
LmNvbT4gDQrlj5HpgIHml7bpl7Q6IDIwMjXlubQz5pyIMTTml6UgMTY6NTMNCuaUtuS7tuS6ujog
THUgVGFuZyAo5rGk55KQKSA8THUuVGFuZ0BtZWRpYXRlay5jb20+OyBKb25hdGhhbiBDYW1lcm9u
IDxqaWMyM0BrZXJuZWwub3JnPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+
OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRG1p
dHJ5IFRvcm9raG92IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPjsgTGVlIEpvbmVzIDxsZWVA
a2VybmVsLm9yZz47IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+OyBT
ZWFuIFdhbmcgPHNlYW4ud2FuZ0BrZXJuZWwub3JnPjsgTGludXMgV2FsbGVpaiA8bGludXMud2Fs
bGVpakBsaW5hcm8ub3JnPjsgTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVs
Lm9yZz47IENoZW4gWmhvbmcgKOmSn+i+sCkgPENoZW4uWmhvbmdAbWVkaWF0ZWsuY29tPjsgU2Vu
IENodSA8c2hlbi5jaHVAbWVkaWF0ZWsuY29tPg0K5oqE6YCBOiBsaW51eC1paW9Admdlci5rZXJu
ZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBQcm9qZWN0X0dsb2JhbF9DaHJvbWVfVXBzdHJlYW1f
R3JvdXAgPFByb2plY3RfR2xvYmFsX0Nocm9tZV9VcHN0cmVhbV9Hcm91cEBtZWRpYXRlay5jb20+
DQrkuLvpopg6IFJlOiBbUEFUQ0ggMS81XSBwbWljOiBtZWRpYXRlazogQWRkIHBtaWMgYXV4YWRj
IGRyaXZlcg0KDQoNCkV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQoNCg0KSWwgMTQvMDMvMjUgMDg6MzIsIEx1LlRhbmcgaGEgc2NyaXR0bzoN
Cj4gRnJvbTogIkx1LlRhbmciIDxsdS50YW5nQG1lZGlhdGVrLmNvbT4NCj4NCj4gQWRkIHBtaWMg
bXQ2MzYzIGFuZCBtdDYzNzMgYXV4YWRjIGRyaXZlcg0KPg0KDQpDYW4ndCB5b3UganVzdCBhZGQg
TVQ2MzYzIGFuZCBNVDYzNzMgc3VwcG9ydCB0byB0aGUgYWxyZWFkeSBwcmVzZW50IG10NjM1OS1h
dXhhZGMgZHJpdmVyPyENCg0KUmVnYXJkcywNCkFuZ2Vsbw0KDQoNCg==

