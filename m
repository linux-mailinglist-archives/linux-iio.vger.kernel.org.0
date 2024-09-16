Return-Path: <linux-iio+bounces-9605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD297979BEC
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 09:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72310282CFF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 07:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064C17E59A;
	Mon, 16 Sep 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="OiugAsXK"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811381CA8D;
	Mon, 16 Sep 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471064; cv=fail; b=jcx3Ji76g8JS9q+ygtmM02ru8NX+4ETueMEn1Cljk1jXFKr9lER0/iNCMvyPV+D0yydtfK09NTUVGcHalJReaNRvVz32mLQXXobTuyzN7XNfgUZWyhU7SnbwmBnlZoM3bDDKirbWb7iIJ/iyKLY478dDBEBFIKAEJW35nhm+5/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471064; c=relaxed/simple;
	bh=Z+QRMERAyZyCN5vYKHPhH9RE0eam9B173Oi9KyxLI1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVxJmwM/fET6BgTRET08v5LlP57Qb45dF0wWcBa1JSf/VZyg2bT3slX9Q9c7ZNVgoYOGmsEHAI7uifmuCpPsN1Xp8BNdRKBtN85VLOjhU0hDeIsE3Vnl0JmEIe4vWprME71gJxzcvyi/jSrXDcVGehm3IeggOBK8z9fKoXA9ykY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=OiugAsXK; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNduaNHo4P35eeWDrufiSQtLU3+FdoTqz2zeDcphZ/tH+3kKu9cCOK0lB52VdETTKVuGR/Dq6/yGj3PcYt6uhs+lWgPSKFnfagmB3/OVvEthS5m1SmowtLYSGYcYVvx4lVkBo/5rVbeJGvMroxAIbgmUjPAcfVTSh4swqNLICAoE8dwHWIDl8+drUKbtrcFYmLKCRBiKN30f8YYgFwyMhJRoxVUPIIkQhOpzLJMRA02qS2zq4t9YrRGctHrgsWhchiYLdi2IzVRR48m69p0ia836JaCRkiLd90//JPWUxJEX44++4igcCc0hF4LJ6aXoLYjWlG33GdSPpZMTv1TOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+QRMERAyZyCN5vYKHPhH9RE0eam9B173Oi9KyxLI1M=;
 b=UwYsc6Tik422i/h1e151aCU15zA2U+4eIlShQaJliDckOLeQjB+PFmXg7nxgO+U2Eir57KUDkUZxeeRniLK1la2NIA0grLDdpMqcgSHgaDIcstj6lEym8vEZYLu/kqhhSq55VJLzN5Q0RZNX4KbPj3ijhIoFllNAs00apQGtdc8FuUqqg27NkopUuqzWOI/5azXOyyl2T33HNzTXbtH9LgstNnqJANnX1UqeS6A0gOJqUQyprKM79OXbEN/nTNojFsajhaMlXZ//9fwAerLOWaOZFGUaVDgoT9z7RcPv/r1uAACbOvlAeIRopjpfeOKe4puKoj3PfV46PpfqKGHnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+QRMERAyZyCN5vYKHPhH9RE0eam9B173Oi9KyxLI1M=;
 b=OiugAsXKzXYLGTh/KTpRx3973byD5KZdeEXEihdVc1RPDMK56GgeoESnhnO0VdN/ZwoYUrYWQib8nfqCVbCA1RxfKkjqKN1o2SIojU2jaSQpqf2VMi+8yqj6h906zGXjzW3ahrGGTKwAkGiRPN8XpZhFfaRN7tTd5Chvh7ykvyw=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by PAWPR02MB9126.eurprd02.prod.outlook.com (2603:10a6:102:33d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 07:17:39 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:17:39 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v2 3/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Topic: [PATCH v2 3/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Index: AQHbBcNWHxg79/hM70ungBlNk6Zqz7JXeCsAgAKNUwA=
Date: Mon, 16 Sep 2024 07:17:39 +0000
Message-ID: <ffb90ad1b5426a987f4e644a9fa663d96a0d31e7.camel@axis.com>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
	 <20240913-add_opt3002-v2-3-69e04f840360@axis.com>
	 <20240914171918.4b29e847@jic23-huawei>
In-Reply-To: <20240914171918.4b29e847@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|PAWPR02MB9126:EE_
x-ms-office365-filtering-correlation-id: 05b3a6b3-e538-43fd-3584-08dcd61fa5e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXlFYWt5L3J6T3VrVGZpZzV1RXY2eVVsQzU5VlF0aGRlNlFUaDM2cGp4Zlcr?=
 =?utf-8?B?QzMyVUtRUENlUWhiWkg1ZXVXZ3Z3MktxZGRpMmJkalc2MngxY0loZUFOWDN2?=
 =?utf-8?B?RWlFaXhqZHQ5THE0eUNLTis3Smttc2JBSUZCdW5yT29SeGpMRVJlVzF4WXpJ?=
 =?utf-8?B?c2YrSVFnaldGeWJkVkNCNEdUT2xtc2w1ZTlLTWQ1d01MTmR4TzN3MXZ2eFlt?=
 =?utf-8?B?QVZxeStDV29DTk1ZTXd2dmtSbkhxSzVPUjBKcmNWZk5oMEh2WXUxYitreXlU?=
 =?utf-8?B?Y2RGdGg0K1JEMlIxZ0IwOWR6WW5zTjJxMU81bkg3Y1dUUDYyWU0xU293aTA4?=
 =?utf-8?B?dVJEQWl4NGJqQURIeDUxY1VZOGwwMWo0bGZSOWh1UGlCdEs4T2VXZzFockYx?=
 =?utf-8?B?Y1lXUkdRbWJmL1NlSWZkUEMyL3QrR0NkeldwckFPOHYzWERVbzY0ZVdQZTZW?=
 =?utf-8?B?bW5TZE83Yjdadll5Y2hWb1hWbUl4d0tzV1hwVUd1aDI4YU50eFZuaWxFdVFj?=
 =?utf-8?B?UjExVlF5SnRjcXc2Vkp6NmZTQWVUMFltT3Fsano2dVNlTHlXakZiV3NrOVQx?=
 =?utf-8?B?eFVRQkFaNFhyNDMwTHFEc3NQNWVkRjl4Zjd3Rlp6dHprZXNqYkZQdURBM1JF?=
 =?utf-8?B?MVluUEhpMC8zVUhpa21LbCtvTDFBR2xWSW1vZEZpZi91OWJXOERhYnY1Rk1n?=
 =?utf-8?B?VTFrVUMvZHlMVVhrQU0yUUJPTXdnK2Q4SDRvejRXMnRDVEIvd1ZqMXdlSjl6?=
 =?utf-8?B?UER5YkJsSFVNM1p4cktWaTcwTnJHR2dZczZaVWxGakZkN1NmUk5scUpKcHI3?=
 =?utf-8?B?cWcvN0pWWitHL2h4bjFpMTZnV1Jla1VHaUhkcDdoa25pVkt1cktReWlpRFpt?=
 =?utf-8?B?OFlGdmw2N1ZQY0ZzVjM0WnJmYXdmZjl2MGNIanFaaWhYZWxZbW1OdlF3SVdl?=
 =?utf-8?B?dG45anF2TkpMWno0YXJNTTd4ZWNJTVpTVGlidFRnaHJ5em5lWDFpZXhVMVVy?=
 =?utf-8?B?YVZTM3Rrc29iYWlJcGFQbTdyaERlTmFrcW9nUm9VRTZMbEhZakh5WnA1RVJX?=
 =?utf-8?B?Zm1NODU2TGU3OFRtSHlTZjh2OG1tNlRKVFFjNkpFMHFBNUphbHUybStFZFJD?=
 =?utf-8?B?UEpMVlRHRHBBZW5XTXhsd1Z5OWIyUFg0UEszdlQ1eVFFaGVmVTVxcTFGazRs?=
 =?utf-8?B?S1dLZC95Qmx3b3pncnpaT2QzSUtrYllqaWtXQkdoZllYWGRCc1dxZG8xcmRJ?=
 =?utf-8?B?MXZza1hhWW5jdE5RbG1JRlN1RlNJZlREUGFlYldwQ1RCYWNqaTRwc3BvL2JJ?=
 =?utf-8?B?ZkhIRFVaWEt1dkFyOGk5clNCNGE0N25obzNPRG50ZTQyZjRUL0pDK0FUVVpD?=
 =?utf-8?B?Y3VORWMrTW8wSnQ2eE5Mb1dZL3E1VkFrV0dZVzZYNWJIdkZNMmthQmhydTND?=
 =?utf-8?B?c3NFcTc2WVlHWm5nWkFuOEVzVFB6YnJHNytpU3ZkZGwrOXBJb2h4ZTVydHpT?=
 =?utf-8?B?Tzdxdm52TUErYzFCZlZ1YmN6RnZrQ1NleHdvZVFoaTE0V3FvSU1sbkZ0WGdN?=
 =?utf-8?B?YkVUdTZBdjV2QW4vT1VZR2VHbTErU0RicnJaMjQ2TUt4UGhTYW1UaERkVldv?=
 =?utf-8?B?RjNIZmFiTkdtWE5TYjVsMkc4WDNFaExjbVAvR3F4WG5xd0Njd2RYbTF3azN0?=
 =?utf-8?B?MXJva1RGMnN6cEZ4RWh0U2RnbVM5RlVKdmUzSWdHWUtrVXRaQ3pzNHNkSUh6?=
 =?utf-8?B?dzB4bklOU0VDY2JJZTlISEhwUW95bUV0SjFrQTFsZjNsSlN2aFMvS1lwaDRp?=
 =?utf-8?B?TVJpQmoySWRsZHhUaCtsVStjdUcxMk9kUGJNelVyREtxaHJmTTRSNllNUitR?=
 =?utf-8?B?c3lyQVBIZ282SjlvVlhqUEx4Y3B3eEVkZW5zZWZNTFhqSlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akE3ZHUyWjE2djMzdlZjdm01aU1MK2xpUzNZVGsrNlRDZC92WU0xVExoS25T?=
 =?utf-8?B?Nm85amkyMHlCVTZTNndYTDJMUHJTRDZDTzRORGlZOS8zWEpQeHBDNzhZb2Y1?=
 =?utf-8?B?TGYxQ3FTSnJ4UjYzZnloaUpsaDhpRTkrSkR4OVkyNUMxa3lpTVJ3VUhsZS9j?=
 =?utf-8?B?RG50c1dlWHZJOXFZUWtJUjFsN0Q0ZzZOM2JDTFdJNGFPR3pyR3ZuUjEwQlFO?=
 =?utf-8?B?clFiNG5mbGtKckFiWVoxcFFiUFJmdzFzWVJxRDJvbFp1MG5BNjB4bzRNRVM1?=
 =?utf-8?B?dHRVVjZnZGNza0VieXZBRGR3TlFMT3J0UldJVXJzY3Q5VnRHaXRZMmlqOThh?=
 =?utf-8?B?ZW9PcnNSSDRSNVJWaTBLOFlqR094Tmx1a3BkdGRWeTZrZjhoeHFzMEprTStN?=
 =?utf-8?B?cngzREFKT0FMYU10dmRmWWlMSE96TE5YbDh6M1ZoLzNDNU0rWFBQaFhocEs3?=
 =?utf-8?B?U01UZlVEUXVNb1ZrQ05XdWFBV3lha00rVGREWHRiZnZ6Mll3U2dqcVlqZ2Nr?=
 =?utf-8?B?YzNBZHIwNktLTmtkNjRzNHFFaVViTUdNZnVyd0tOdHNoZCtIM3RxWjFuWkxI?=
 =?utf-8?B?K0l3aVQrcHdVL2kvSTFmdlVMOURUMnRZOWI2bE9xMEVHcXovd2dKWFZtZ1Jj?=
 =?utf-8?B?R2RCL21CK0pYdzZYeXh5Q3F5MEh2N0RXdGhKcGExM3B4Q0RpcGpUbXpIWjNS?=
 =?utf-8?B?cU91L3ZpeW1qQ2J4YWg0Mm5ydi84SStZWVFLSjhOSFFVNmFnMVhhK0loU0R0?=
 =?utf-8?B?dVg3QjBGUDMvZzdRS282SzRhRFpPNlBrZWFtaWM1VE5MUDk4MlpQUjhTamVY?=
 =?utf-8?B?MWhFOWx0QytiajlvUUdSeUptVStUMmhhdktkc2R2NXpRRW56YlNHKzdwR2Rp?=
 =?utf-8?B?MzljN20yTldzYUNEVy9pZHoxVEwrUkN4UmE1WjRGWWh3cHZCOFNZbFZOeXRL?=
 =?utf-8?B?VUF4K1dTUGNjc1p2K3NvVGRoRk5XcFM5ZUp0ZDVNZVgvSnorOEZ0czRta0dL?=
 =?utf-8?B?cWgyeU52eWhjMll1QzNNQVFBa3NxUHUwZHJxVXlzUVN1eHFRTy9oVzM3ZjB6?=
 =?utf-8?B?cG54ZUpIUGJ0S3BxWGVnaG5nOUVCUVpaK08xWE5iODdoTytieXluUlFaM2w3?=
 =?utf-8?B?TkVuWGFNSnptWC9QREwvT1ZDY0RjU3g2WERIdDdLVnEzR3JOTC9mYVpLNHZ3?=
 =?utf-8?B?RU5KUnVBQ1lzU0w5all6KzdnRitGaTdGTTk1QXRJK2hoOFdTWlVQMUtOenlr?=
 =?utf-8?B?S1cxS3lYTnNmdkFvSVRNVlFXMm8zdmo2dXRPZC83Q1dtbXYxRkFrOEw0aE80?=
 =?utf-8?B?NEdhZ2J5QVdEQktsaGI2VC9XMnVkZXlyd3pqUkpsSmxGOHIzRHYyeXE5Umow?=
 =?utf-8?B?UzU1ZzVoU1NaSzA3amsyWGVmZnBOSmE3TnFaWjJoaUVYVFNRTUFxTEtURzRP?=
 =?utf-8?B?a0FCWHBMaFlVeDdqekpCNXJDU3FzamlvNm9FMXI5dGxnZjRFZWlJcFFENTY5?=
 =?utf-8?B?NTd6K09EREc5akJXVTNpNUJxZnhSMHF5VjkwS1FNR2t2eW10K0hQK2Zsb0dl?=
 =?utf-8?B?UW81MkhLWjJTbERJNjlQYzh0VzU1R2p4M21TOTF2USs0bjNxcnp1cUR1LzA1?=
 =?utf-8?B?NkJXS1gzSVpzd0VCMDZkajh2MjNQbmJmTlRhbEdsSXBLdmZYd3VmbGpVY0R2?=
 =?utf-8?B?YjdDV3dkZ3lIbkVhcnhVMG9JSEQyMVkxenBNNFg5RStGNy8wdk1rNlhGcmhl?=
 =?utf-8?B?Vkh1ajV6MmlrSFRDS3o3d1pPb2NlOGhFT2tCdUwwd1BlaGg5NDRYWGtrZ25w?=
 =?utf-8?B?cCsyUUExa3NvdGlTMzZwTXVvUWwvcHdXVU9GMEJFQ1RSSlZMVCtmUEs4ZzdC?=
 =?utf-8?B?SnFQWHhCaW1yTUpuMWk5Mm1BQ3ZxZXBQZHd6S210cS9BbjJacis3MHBKZkk5?=
 =?utf-8?B?WnFib2kyRXhqRjNSN2ovSkRjWDU0b3pzaGFjc0NOUzErQWJxdXlGTUZER09U?=
 =?utf-8?B?ckpXTVB3aHpSeURQYThDTGZPbzFwSTF6ZGM0enJZckl2YXJHZnJLMzQwWS9D?=
 =?utf-8?B?cHhuMWxtS0RkcHJML1lTVmtZWHF0enZCeWxQYW1ncXBDUmQzMG1BSHg0WHl3?=
 =?utf-8?Q?SsIwS0yU5NuxzebWFChutZERI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AEFDC43663F4A4CBD8B48F722D349C3@eurprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b3a6b3-e538-43fd-3584-08dcd61fa5e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 07:17:39.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VM93w9jG63VkVI2GMdGKtQgbC1LWBMU8MhPBdqEOrQhuXQmwM9Q4Fv1ycHugOgID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9126

T24gU2F0LCAyMDI0LTA5LTE0IGF0IDE3OjE5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDEzIFNlcCAyMDI0IDExOjU3OjA0ICswMjAwDQo+IEVtaWwgR2VkZW5yeWQg
PGVtaWwuZ2VkZW5yeWRAYXhpcy5jb20+IHdyb3RlOg0KPiANCj4gPiBUSSdzIG9wdDMwMDIgbGln
aHQgc2Vuc29yIHNoYXJlcyBtb3N0IHByb3BlcnRpZXMgd2l0aCB0aGUgb3B0MzAwMQ0KPiA+IG1v
ZGVsLCB3aXRoIHRoZSBleGNlcHRpb24gb2Ygc3VwcG9ydGluZyBhIHdpZGVyIHNwZWN0cnVtIHJh
bmdlLg0KPiA+IA0KPiA+IEFkZCBzdXBwb3J0IGZvciBUSSdzIG9wdDMwMDIgYnkgZXh0ZW5kaW5n
IHRoZSBUSSBvcHQzMDAxIGRyaXZlci4NCj4gPiANCj4gPiBEYXRhc2hlZXQ6IGh0dHBzOi8vd3d3
LnRpLmNvbS9wcm9kdWN0L09QVDMwMDINCj4gPiANCj4gTm8gYmxhbmsgbGluZSBoZXJlLiBEYXRh
c2hlZXQ6IHNob3VsZCBiZSBwYXJ0IG9mIHRoaXMgdGFncyBibG9jay4NCg0KT2theSwgSSdsbCBy
ZW1vdmUgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiA+IA0KPiA+ICsNCj4gPiArc3RydWN0
IG9wdDMwMHhfY2hpcF9pbmZvIHsNCj4gDQo+IERvbid0IHVzZSB3aWxkIGNhcmRzLiAgSnVzdCBj
YWxsIGl0IG9wdDMwMDFfY2hpcF9pbmZvLg0KPiBXaWxkIGNhcmRzIHRlbmQgdG8gYml0ZSB1cyBh
cyBtYW51ZmFjdHVyZXJzIGhhdmUgYW4gJ2FtdXNpbmcnIGhhYml0DQo+IG9mIGZpbGxpbmcgaW4g
Z2FwcyB3aXRoIHVucmVsYXRlZCBkZXZpY2VzLg0KDQpHb29kIHBvaW50IQ0KDQo+IA0KPiANCj4g
PiArCWNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjICgqY2hhbm5lbHMpWzJdOw0KPiA+ICsJZW51
bSBpaW9fY2hhbl90eXBlIGNoYW5fdHlwZTsNCj4gPiArCWNvbnN0IHN0cnVjdCBvcHQzMDAxX3Nj
YWxlICgqc2NhbGVzKVsxMl07DQo+ID4gKwlpbnQgZmFjdG9yX3dob2xlOw0KPiA+ICsJaW50IGZh
Y3Rvcl9pbnRlZ2VyOw0KPiA+ICsJaW50IGZhY3Rvcl9kZWNpbWFsOw0KPiANCj4gVGhlc2UgdGhy
ZWUgYXJlbid0IG9idmlvdXMgd2hlbiBqdXN0IGxvb2tpbmcgdG8gZmlsbCBpbiB0aGlzDQo+IHN0
cnVjdHVyZS4gQWRkIHNvbWUgZG9jcyB0byBoaW50IGF0IHdoYXQgdGhleSBhcmUuDQoNCk9rYXkh
DQoNCg0KPiA+ICsJYm9vbCBoYXNfaWQ7DQo+ID4gK307DQo+IA0KPiA+IEBAIC02MTAsNyArNjkw
LDcgQEAgc3RhdGljIGludCBvcHQzMDAxX3JlYWRfaWQoc3RydWN0IG9wdDMwMDEgKm9wdCkNCj4g
PiAgCXJldCA9IGkyY19zbWJ1c19yZWFkX3dvcmRfc3dhcHBlZChvcHQtPmNsaWVudCwgT1BUMzAw
MV9ERVZJQ0VfSUQpOw0KPiA+ICAJaWYgKHJldCA8IDApIHsNCj4gPiAgCQlkZXZfZXJyKG9wdC0+
ZGV2LCAiZmFpbGVkIHRvIHJlYWQgcmVnaXN0ZXIgJTAyeFxuIiwNCj4gPiAtCQkJCU9QVDMwMDFf
REVWSUNFX0lEKTsNCj4gPiArCQkJT1BUMzAwMV9ERVZJQ0VfSUQpOw0KPiANCj4gSW4gZ2VuZXJh
bCB3aGl0ZXNwYWNlIG9ubHkgY2hhbmdlcyBiZWxvbmcgaW4gdGhlaXIgb3duIHBhdGNoLCBidXQg
SSBndWVzcw0KPiB0aGlzIG9uZSBpcyBwcmV0dHkgbWlub3Igc28gd2UgY2FuIHNraXAgdGhhdCBy
ZXF1aXJlbWVudCB0aGlzIHRpbWUuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGluZm8sIEknbGwga2Vl
cCB0aGF0IGluIG1pbmQgaW4gdGhlIGZ1dHVyZS4NCg0KPiANCj4gPiBAQCAtNzU1LDEyICs4MzYs
MTQgQEAgc3RhdGljIGludCBvcHQzMDAxX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQp
DQo+ID4gIAlvcHQgPSBpaW9fcHJpdihpaW8pOw0KPiA+ICAJb3B0LT5jbGllbnQgPSBjbGllbnQ7
DQo+ID4gIAlvcHQtPmRldiA9IGRldjsNCj4gPiArCW9wdC0+Y2hpcF9pbmZvID0gZGV2aWNlX2dl
dF9tYXRjaF9kYXRhKCZjbGllbnQtPmRldik7DQo+ID4gIA0KPiA+ICAJbXV0ZXhfaW5pdCgmb3B0
LT5sb2NrKTsNCj4gPiAgCWluaXRfd2FpdHF1ZXVlX2hlYWQoJm9wdC0+cmVzdWx0X3JlYWR5X3F1
ZXVlKTsNCj4gPiAgCWkyY19zZXRfY2xpZW50ZGF0YShjbGllbnQsIGlpbyk7DQo+ID4gIA0KPiA+
IC0JcmV0ID0gb3B0MzAwMV9yZWFkX2lkKG9wdCk7DQo+ID4gKwlpZiAob3B0LT5jaGlwX2luZm8t
Pmhhc19pZCkNCj4gPiArCQlyZXQgPSBvcHQzMDAxX3JlYWRfaWQob3B0KTsNCj4gPiAgCWlmIChy
ZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+IE9ubHkgY2hlY2sgdGhlIHJldCBpZiB0
aGUgZnVuY3Rpb24gcmFuLiAgVGhhdCB3YXkgbm8gbmVlZCBmb3IgdGhlDQo+IGRhbmNlIHdpdGgg
cmV0ID0gMCBhYm92ZS4NCg0KR29vZCBwb2ludCwgSSdsbCBjaGFuZ2UgdGhhdC4NCg0KPiANCj4g
DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBvcHQzMDAyX2NoYW5uZWxz
W10gPSB7DQo+ID4gKwl7DQo+ID4gKwkJLnR5cGUgPSBJSU9fSU5URU5TSVRZLA0KPiA+ICsJCS5p
bmZvX21hc2tfc2VwYXJhdGUgPSBCSVQoSUlPX0NIQU5fSU5GT19QUk9DRVNTRUQpIHwNCj4gPiAr
CQkJCUJJVChJSU9fQ0hBTl9JTkZPX0lOVF9USU1FKSwNCj4gDQo+IEdlbmVyYWxseSBpbnRlbnNp
dHkgY2hhbm5lbHMgY2FuJ3QgYmUgcHJvY2Vzc2VkIGJlY2F1c2UgdGhlcmUgYXJlIG5vDQo+IGRl
ZmluZWQgdW5pdHMgYXMgd2hhdCB5b3UgbWVhc3VyZSBkZXBlbmRzIGVudGlyZWx5IG9uIHRoZSBm
cmVxdWVuY3kNCj4gc2Vuc2l0aXZpdHkuIFRoZXJlIGFyZSBzb21lIGRlZmluZWQgbWVhc3VyZW1l
bnRzIHN1Y2ggYXMgaWxsdW1pbmFuY2UNCj4gdGhhdCB1c2UgYSBzcGVjaWZpYyBzZW5zaXZpdGl5
IGN1cnZlLCBidXQgaWYgaXQncyBqdXN0IGludGVuc2l0eSB3ZQ0KPiBub3JtYWxseSBzdGljayB0
byBfUkFXLi4NCg0KT2theSwgSSdsbCBzd2l0Y2ggdG8gdGhlIHJhdyB0eXBlIGluc3RlYWQuDQoN
ClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLCBJJ2xsIHN0YXJ0IHdvcmtpbmcgb24gYSBuZXcg
dmVyc2lvbg0KYXMgc29vbiBhcyBwb3NzaWJsZS4NCg0KQmVzdCBSZWdhcmRzLA0KRW1pbA0KDQo+
ID4gKwkJLmV2ZW50X3NwZWMgPSBvcHQzMDAxX2V2ZW50X3NwZWMsDQo+ID4gKwkJLm51bV9ldmVu
dF9zcGVjcyA9IEFSUkFZX1NJWkUob3B0MzAwMV9ldmVudF9zcGVjKSwNCj4gPiArCX0sDQo+ID4g
KwlJSU9fQ0hBTl9TT0ZUX1RJTUVTVEFNUCgxKSwNCj4gPiArfTsNCj4gPiArDQoNCg==

