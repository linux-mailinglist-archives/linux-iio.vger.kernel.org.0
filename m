Return-Path: <linux-iio+bounces-10434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B220999D8B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 09:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08932832AB
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BB220967E;
	Fri, 11 Oct 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NEIe3vFa"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F3BA2D;
	Fri, 11 Oct 2024 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630731; cv=fail; b=gky5bnonlUDhkrA5FbpDg0c9K3ozYjeDUkCKIqIEQv14jca6jeS1/YddaoE/0s0NRveDa0HRhft95i92uJg77jEIaZKwrr0orZX82xKkbbHaea2fti4Ug3I4hn7SmU86nWGIP9rv5lbk9+lT31Vs4PweiAShvjZOnZethDHxPdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630731; c=relaxed/simple;
	bh=0tfjJ34POk2tmq3BUyDz2xmIl0Cegg//aoViq0AKOfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYBaDIji10b8GG3FxNGT8oMlY8tXHAy+xIiR66HG0VV3+8DcAERS4PYf5/92yjuFSkAPS5W3jj6WASikUFbRlaGn4cH4DJk4aEWcYo/C+EFlmunHEVAFBu4+8KK9uWf1yXKIbLYzz3Ael8JYrx605x8wf4AYuCZyK84TEHVqH8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NEIe3vFa; arc=fail smtp.client-ip=40.107.241.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJi2bHVDZsp9FAR0/trsS7dmhhSc3zWV6xpDPclMJfgaIujvEOmfzk6RxZeUo+yxoedpXeSRBtQQrghoPbctUaqma34s4poLruC0qRdacVQsclnpk8fDT5kAqgdLwZBOkUeiudt++XzVS0UbLb0lmVbxnNl+y1XCz5gpc50TUeZ4gVY9jAAcoNtVgx21iGWmzlaWiH2hm/M7DcVOmF6XZg8qW6aqe5ITpPB7oUEu2zd1DmfXC9AaqlHqpARSdDkydbZMX/CLYUdR2OGohZ8iG2wew0YbMp5L3uo2j28dI/NJrQpm+C0nKhssva+mgCNX313rQPftCC6DMhS09CS6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tfjJ34POk2tmq3BUyDz2xmIl0Cegg//aoViq0AKOfo=;
 b=zFyX756aO32iOuMuMiKy50tX6xVDn/MyY+2uohkrbVxdW4aHhVr9T4YlrVhjuU8FEnCyJMiyNJlu6BxHeV1C6xoM6CenrHC3mk7lZs+8871wXdOuI4j1KxumNWSpOeS7z2qAqrLrC5vY3RNMhWC7Dxk3L8u+m7ze/P2EDZQlH+MxFqaRzOEYSI6pHXK2s14Rx+Z/3QKFtugCDVyKxhk2iwhLMyl02024UuagQpXo6e5RBjeC7PYWlSXJ4h8zo426XdI4ApbXYlgvcofT4/mTwYtnTG+aiWKf5YubCCcnX2z2Qukta+6ZuY+ThfT4cQSbBonHcwhuUPF4XbfH1kfSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tfjJ34POk2tmq3BUyDz2xmIl0Cegg//aoViq0AKOfo=;
 b=NEIe3vFa9LZLgWJcZ7rrYb9LVVirAwnQzMjhxQXNd82Z9Zzdz47T52PHWNpoL/TonPkbl4zoHHUVqiduVPdO2IwvkFKWQ1aQpNyQuUeZsPzwjSR5fsAO7U0Og64gzEc/jLuMjr9eMMsB6mI5yM3x8RClVFOhF1nQTOVf9KQ3hQ8=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by AS8PR02MB9650.eurprd02.prod.outlook.com (2603:10a6:20b:5a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 07:12:05 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:12:05 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Topic: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Index: AQHbFY8HuXJEWWs0RkmgVD58ZYYY2rJ5uMQAgAEugICABWagAIAA4L0A
Date: Fri, 11 Oct 2024 07:12:05 +0000
Message-ID: <fab164228b4d567a147cd8d93150e687c6db0c70.camel@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
	 <20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
	 <20241006141624.3fa5bf34@jic23-huawei>
	 <b40d22b5bdf487b40207e676d35a0507c47cbb26.camel@axis.com>
	 <20241010184742.1747bfe2@jic23-huawei>
In-Reply-To: <20241010184742.1747bfe2@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|AS8PR02MB9650:EE_
x-ms-office365-filtering-correlation-id: 18541df8-d6ff-4ba7-26c2-08dce9c402eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXcxaDJVV0oxUkVjZm1MNGdYKzBleDduN0o3SUFoS2RBaWdzWTYxMFBBdnBB?=
 =?utf-8?B?ODdrR1pzaE9wQ3Z4WFhjb1p2QWRqLzFRYUQzeVRsWXJoRWdJZDQranlLQ3Bn?=
 =?utf-8?B?UFhldkFzNGd1bytJc3E2Qkc2Ty9URWFJTUNCSURSSkMvMktWKzZHSzBYdDdr?=
 =?utf-8?B?NDFMLzVBd0F1K2dZZDRwR0VHWmdHd09zcjRPZXVrNmVFekZGT2RJL01ZaVk3?=
 =?utf-8?B?MTVBUFh1WlBZakIvby9GNjRlOXZ6QlVXSWhuYXUrOEFzQmprcTBZOWFtSEJF?=
 =?utf-8?B?OTViWTM5TndnOHFxZHY5ZXNKUlJaSUhNUit0TExvYzVta2dGQ2wyeG9Mc0Rm?=
 =?utf-8?B?cDIvYmlVM1dWMERNYVAvY3VLMTB5UjFTZ2Vob1RQVVFhSU52YlN1aHAxQ2E2?=
 =?utf-8?B?YjcybERSZVhBWTBrbXUyR0Z0bitHcHZneEwzQmE0bGl1Vmd0Ti9TbzdneFJG?=
 =?utf-8?B?QnhNUVAwOExPZnlTQ3Y3R2UwaVFTYmkvT0lqTVFJTFhLYnpjQUJ3NkVnR2pa?=
 =?utf-8?B?ZEZ2OHRKRmlDd2w0SDM1OG90enJwa2Q3Z0dZVTJVbXgzY1dDb3FCSkg0OWt3?=
 =?utf-8?B?dFVHRElxU3F4NnhmbXNYSStROEZ2QWRmdVhpRkVDV2gwdmFSODVVU1lYTWFw?=
 =?utf-8?B?c2pnK0RNR1FXWm13NkVyUHVsZDI3SnFQZXFsQXNvREk4WTg1aXhrRkZST2Y2?=
 =?utf-8?B?elBLUW4wOFQxeEt4aGVtQVdsWlE0ejBheVFHbjMzVXJ5N2M0bmhUa0pCbnlQ?=
 =?utf-8?B?czdSd3VybGZzQ3MwN3lMK3dFc0t3UlJ1Si80cytzYTg0VW52dk9wLy9JWDV3?=
 =?utf-8?B?WkFwZ0JtRGpieWc4cklQc1pSNVduNDhIRmtxYWNzWTFOUXowZGRRbGkwMXN3?=
 =?utf-8?B?Y1VxQmFPK1FLVWh3SkN3YkRKQ0VZU05vNU1wRnZYclhLQWJWWHcvRkhieVNO?=
 =?utf-8?B?Rlp3TXF2MWh4TlF6eWQzRUpidlNlcmhMZWNDbkpTeFhWM2tMSTFjSUdYQlN4?=
 =?utf-8?B?V0dlajdKcWcxR1JMV2FiZlpiMENKOGhDTlcwV1BzQ243eW9wUnlVZzcwdWVD?=
 =?utf-8?B?Mis5L1lMdmwvOUdISFhqMkdnR0ZXNnlPN3RnSGRoNURQYjBXUkhxc0IxZGNC?=
 =?utf-8?B?RHJubnRiWWtFbzdaL20xR0svdVBlRDNzZjN2LzhiaHRFcVRwVEJDbnVXQXMx?=
 =?utf-8?B?T3lMa1Q5VFAxemRhNzRicDVJMWdHa1FoR2FzVG80a085QnExK3p0cXhTY3Uy?=
 =?utf-8?B?UEpXVS92a2ZDZ3Z3MjJmWVJpR3M3dVp1NzVLanA4N2lMNmFpaFBsZk10UEdt?=
 =?utf-8?B?Q2dWNEhRakJsbnpLQVBWK0VsaHVYTGNzZ2hXMjFRNEFmQkN2NGEvQ1kvd0Vt?=
 =?utf-8?B?U1BSNDF4WWpEbGNjQ3lsTGkvOHUycVdzQmZ4a1NUSGExR1B2OFNnREF1MDIw?=
 =?utf-8?B?d1drY29zNmRUS2FnZ1JzMmRMSE1XbDJsVTlxSDlCQXVrczg3cnZoUk51T2Z0?=
 =?utf-8?B?aUJhdnMxRStlY3BWUnVkM2JCWStYUDRSM0I0MjlPYkFvaldua1N6dStqNEFp?=
 =?utf-8?B?YlZrcXVWYm9zLzQ4TkZudW1XZ0ZwdldoQVZKMlIwMnl0UFg4N25QQXQ2MHJ0?=
 =?utf-8?B?ZndOVVB6RVhha1ZFK3ZQOGdUcG1FaXdtdlpzSlVWR0Q2ZHB2ZEcyOHZMdGdM?=
 =?utf-8?B?YVo1b24wOVo4QlRhYTVQdURwaEc1TEdNWnFtOHFjNlV3NDRBbS9ERC9Za0hv?=
 =?utf-8?B?VVVaazVieFZkakt2ZmxLNVlTMEFvY01HZHlKQjdyVmRJS2VGcVFpcm5wVkE5?=
 =?utf-8?B?aEtyUlBNNkVMVWtwMk9Vdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnFyUTFrZHFhbjFmelorZXl5S1JTTS9oVHl0RzNKbEJhVW44Y201bHJ4akFJ?=
 =?utf-8?B?eHpNTU1qSzRJcm5zaWUzd3Y0WTVOUEpsVzlLbEt4WWJadW0xWkN3UFp2N2ND?=
 =?utf-8?B?bFp4S0c2aVhObVFGL1JOc1k5RzVDRTJDM09GcWwxeUpHbHhDS1h1MHVPTFZP?=
 =?utf-8?B?VDNEZmFlb2xUckNYV3hCWlQ2MFYzVXorQUJCb1o4WHU1ODdMR3RwdHhVdjRX?=
 =?utf-8?B?a012YTUxZk1wK095WlBTdWVuU1E1SWpqUHVlM0FrRkZnMWJ4MjZ1MjdnZ215?=
 =?utf-8?B?ZzYzTTh3amJSM2lkTmVRMGF4WnAyV2ZzMm5VV01GUjBDSVBuS0JkSHFzY1FS?=
 =?utf-8?B?Rmc4bk13QTVaN1dHYS9zb2lJMjRkMUpXNElHK3p5SlVZSlRLeEhCQ0VxZTlt?=
 =?utf-8?B?YzMwbFdBM0R5UU8rQmY4R2hEQk12cEdNRDZneHFkZUZvSHE5eW9rMmdHdFNW?=
 =?utf-8?B?K3RqclF3NFVhY3VrVDFmU0xCN3U4Q0NReTd6b3orcU9RbTMvYTlvRU9URk43?=
 =?utf-8?B?cmVyZ01BWXVnZTVhRGkyWHhjNllTRUZNWFlURFBrUk1nOW9oREJzU1ZzVUpB?=
 =?utf-8?B?R01pV1d5d1JaVjQ3S255bFZ5N1NtUkIrTHIwaVE0Uzk4eU03dGpoZ1VDS2Yw?=
 =?utf-8?B?R2QwRFJ6VldkQ1JVSVRzU2hnd1lWYndBT054QXlITnJrblNxSitNUFU3dklt?=
 =?utf-8?B?RjNYaGNYOUNGYlh0UjAzZkI4L3pWQnZtRk9uSVZBL3owRHlGUmRlN25aUnlL?=
 =?utf-8?B?azBkczE3elk2Rm5JV3VaQ1hkcyt5eldyQU9aWXhGelFva3VGN25nU2pzVzQx?=
 =?utf-8?B?QmJqVDJIM2dvT3B1a3VVeFR0czl0a0RKM0JXTHhmaDFoWjR4bm9wT0U4bmhC?=
 =?utf-8?B?YXZHdXNKWkhJWEYzNUt2ZDlXa0hueXp2UzA5aTlCMis5SUV3SkgweG5QTVpx?=
 =?utf-8?B?a29tblZ1V3VSOHdocmg5eFFISXFONWdhVUJTSlVQcmtyUGhNTDZsN2pDY0p5?=
 =?utf-8?B?d2k1d1V3QUlPeVBBcWp4bzFZU3lEWXZxaUcyaEZyRndHeURUd2JMdHNTWWNQ?=
 =?utf-8?B?dmxCOUFaU1VsMDJhRVR6MkpWMDNpaXBad0UvT3ZuSmE0aDc4QU42dy9SSkV3?=
 =?utf-8?B?eW5icmpRcGdEOGhnWitieWNYUkxGeVJjY2s5SDlWWDV0Z1ZCTkQ5T1lqVVRm?=
 =?utf-8?B?UVdVaFBIOWwveE1YZzgxb1hpVFF5Qk9hc0RLYitIRTU5d1hWSW9zYWI0STF1?=
 =?utf-8?B?dHEwWDB6RzlodEd3UktxS3VtbkdXeVVvMnZTZVc0OE1EMmVpZ0F0VHNFdVdq?=
 =?utf-8?B?cXNFbGRGY0xONVo5VENrUWZuaGdHMGFMZ1ZHK3piNHkrNlpMUVhuV1BjMVM0?=
 =?utf-8?B?VVlGWVo4STFCZWhuZlNIdXNjREh2OFVZbVZUUkcwaldKWDFlRk5UZ0Z6RGhs?=
 =?utf-8?B?YVAwYmRmcGVmZmdrVG0wY3N2NGhiczFsWGtWcHJRT0RtbEdEM1FnSkwrdXFS?=
 =?utf-8?B?eXpUNWpTdjRtT09GSFJiZjZCeWd0aXRBL0xkS2RFeGZHQm81MWRNei85TWJE?=
 =?utf-8?B?TUZhVmdZaGhiT1hUS0dlUFlSbFVEV2lCcTdYTVJ5MWpiRXBlUjNBYlZxc2RF?=
 =?utf-8?B?VDRFVEhBTmRNUUhqWnhETGFHdFdWbXVMSWN4TVZ1d01Tdk5UQjZDRnMxMkR0?=
 =?utf-8?B?ampoRXFYLyt6N0d4Qng0SlBUSyt1Nk5jYlg1OWNPaTJsdVY1Ky91MHp0eGRZ?=
 =?utf-8?B?ZFNPNndubTZieWFRYnlSaHJOYU5FUHlPSlA5ZEFRVis5OHBDbFB6WkxtaEpR?=
 =?utf-8?B?T2E3UElqeWZOZ3E3emRnVUhFNU82eFU4N1JTWTdlbytvVWMvMFlwZ0czVTFM?=
 =?utf-8?B?RnlZS3REWXpDK2c3QnB0N1NaME56TVo2VHk3eXpQOHNPQVJaMWlBUW93bWZr?=
 =?utf-8?B?eEpPOC9ibU5SQmRVbHZYcEJPUjdka2lmMkZlaktIbUFYWjBxZDQ5K3QveDBa?=
 =?utf-8?B?NUxnVXlFL2czdnh1R1hOeEFuWUp4eTJpOTNXYUtKVTUwZmJzMWpkRkk3azR1?=
 =?utf-8?B?aU1DS01uWDB5SU1uOFdKUEdSUElLTUZ5VXFWRXEzTk5JdEE2SC9FbCtLWkVm?=
 =?utf-8?Q?956azzo9xVp9Pgo+DHxJUEU7o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC6B38FE4102C44197BB59F898F734F7@eurprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18541df8-d6ff-4ba7-26c2-08dce9c402eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 07:12:05.1181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buUDJamxnKvpeyD7qvylj5mkuLs4wkzZEUqpJ2FeP017d7CCg1ZYtGEn4xW8L0sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9650

T24gVGh1LCAyMDI0LTEwLTEwIGF0IDE4OjQ3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDcgT2N0IDIwMjQgMDc6MTk6MDYgKzAwMDANCj4gRW1pbCBHZWRlbnJ5ZCA8
RW1pbC5HZWRlbnJ5ZEBheGlzLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIFN1biwgMjAyNC0xMC0w
NiBhdCAxNDoxNiArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiA+IE9uIFRodSwg
MyBPY3QgMjAyNCAxNDoyMjoxNyArMDIwMA0KPiA+ID4gRW1pbCBHZWRlbnJ5ZCA8ZW1pbC5nZWRl
bnJ5ZEBheGlzLmNvbT4gd3JvdGU6ICANCj4gPiA+ID4gDQo+ID4gPiA+ICtzdHJ1Y3Qgb3B0MzAw
MV9jaGlwX2luZm8gew0KPiA+ID4gPiArCWNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjICgqY2hh
bm5lbHMpWzJdOw0KPiA+ID4gPiArCWVudW0gaWlvX2NoYW5fdHlwZSBjaGFuX3R5cGU7DQo+ID4g
PiA+ICsJaW50IG51bV9jaGFubmVsczsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWNvbnN0IHN0cnVj
dCBvcHQzMDAxX3NjYWxlICgqc2NhbGVzKVsxMl07ICANCj4gPiA+IFRoaXMgZG9lc24ndCBjb21w
aWxlIGZvciBtZSBhcyBvbmUgb2YgdGhlIHR3byBvcHRpb25zIG9ubHkNCj4gPiA+IGhhcyAxMSBl
bnRyaWVzLiAgWW91IGNvdWxkIGVpdGhlciBmb3JjZSB0aGVtIHRvIGJlIDEyDQo+ID4gPiBlbnRy
aWVzIGVhY2ggb3IgdXNlIGEgcG9pbnRlciB3aXRob3V0IHRoZSBzaXplIGFuZA0KPiA+ID4gYWRk
IGEgbnVtX3NjYWxlcyBlbnRyeSBpbiBoZXJlLg0KPiA+ID4gDQo+ID4gPiBKb25hdGhhbiAgDQo+
ID4gDQo+ID4gSGkgSm9uYXRoYW4sDQo+ID4gDQo+ID4gQXJlIHlvdSBidWlsZGluZyBvbiB0b3Ag
b2YgdGhlIHBhdGNoIHRoYXQgd2FzIGFjY2VwdGVkIGluIGVhcmxpZXIgdmVyc2lvbnMgb2YgdGhp
cw0KPiA+IHBhdGNoIHNldD8gVGhhdCBwYXRjaCBhZGRzIHRoZSB0d2VsZnRoIG1pc3Npbmcgc2Nh
bGUgdmFsdWUgZm9yIHRoZSBvcHQzMDAxLg0KPiA+IFNlZTrCoGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI0MDkxNi1hZGRfb3B0MzAwMi12My0xLTk4NGIxOTBjZDY4Y0BheGlzLmNvbS8N
Cj4gPiANCj4gPiBTaG91bGQgSSBoYXZlIGFkZGVkIHNvbWUgdGFnIHRvIGhpZ2hsaWdodCB0aGUg
ZGVwZW5kZW5jeSBmb3IgdGhpcyB2ZXJzaW9uIG9mIHRoZQ0KPiA+IHBhdGNoIHNldD8NCj4gQWgu
ICBZZXMsIEkgd2FzIGhhbGYgYXNsZWVwLg0KPiBUaGV5IGFyZSBnb2luZyB2aWEgZGlmZmVyZW50
IGJyYW5jaGVzIChzbG93IGFuZCBmYXN0KSBzbyBJJ2xsIGhhdmUgdG8NCj4gc2l0IG9uIHRoaXMg
c2VyaWVzIHVudGlsIGFmdGVyIHRoYXQgZml4IGlzIGluIHRoZSB1cHN0cmVhbSBmb3IgdGhlIHRv
Z3JlZw0KPiBicmFuY2ggb2YgaWlvLmdpdC4NCj4gDQo+IElmIEkgc2VlbSB0byBoYXZlIGxvc3Qg
aXQgYWZ0ZXIgdGhhdCBpcyB0aGUgY2FzZSBmZWVsIGZyZWUgdG8gZ2l2ZSBtZSBhIHBva2UuDQo+
IA0KPiBKb25hdGhhbg0KPiANCkhpLA0KDQpObyB3b3JyaWVzLiBKdXN0IHRvIGNsYXJpZnksIGRv
IHlvdSBtZWFuIHNpdCBvbiBpdCBhcyB0aGF0IHlvdSB3aWxsIGNvbnRpbnVlIHJldmlld2luZw0K
dGhlIGNvZGUgYWZ0ZXIgdGhlIGZpeCBpcyBpbiB1cHN0cmVhbSwgb3Igc2hvdWxkIEkgY29uc2lk
ZXIgdGhpcyBwYXRjaCB0byBiZSBhcHByb3ZlZD8NCg0KQWxzbywgZG8geW91IGhhdmUgYW4gYXBw
cm94aW1hdGlvbiBvZiB3aGF0IHRpbWUgZnJhbWUgd2UncmUgdGFsa2luZyBhYm91dD8NCg0KQmVz
dCBSZWdhcmRzLA0KRW1pbCANCg0K

