Return-Path: <linux-iio+bounces-9480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9238D97796C
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8B628919E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313931BC088;
	Fri, 13 Sep 2024 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NrRNolY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013020.outbound.protection.outlook.com [52.101.67.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB877107;
	Fri, 13 Sep 2024 07:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211973; cv=fail; b=LUDPV/ZVnzx4aqlAdezvOqRKp8BVxau/dKgXCNUF/91kjWTE4rRsihWNGPd7I02IU8CFx68Oa2U5Sa0R+a2jtQfzQEvqy93+VwSNoHoXvtnnchGwFgtzXEa8/jiqGC3fu80vI9fkizEZO6B3ef3FKR+jjQiPTlM41wrozkUAEQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211973; c=relaxed/simple;
	bh=zZKY8L0lHf/YKBHW/t6BN6SXgdiFW/uJfucfnuDSo2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D4R1kzzYVZGi54NYBWigmRJYQkLBOgn3vHA4Bjocj51Dk4wuFxXnk7ua8ZDqHlFrL2lbYMZtNNf0Goz759pyZTz32b2xXHsXjYG4qmYse8KCh4hFph+dIQBRGHmHpppYswHzPOl77+HRzJApKPIcSFdGogSqbDTKcQcT6KjgOrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=unknown smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NrRNolY4; arc=fail smtp.client-ip=52.101.67.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxPSWOFOyDZe92rPe8bUhDJTWKBozThTJQXlTtXFr30Tzhm26wYN7idsfvC3Rzsy0ihyBvtQcgipTCwP/f3DXXJOsyl2rgrOfwkxwDYy9EC3OXIO+rRJAHZx0mNRWJcC7UpakE4qKPtEW8oMOoqgCOfz5IzeHxWZiNlpo+dQ0fex/7GvmvVCy8Scj2CzI6hfeMc0XPpWdVgGHc9rGD3DDX9mdX+syC3qvtXm2N5ZmvsDwqkTwWGFeCijd+WzwlEBoZJrU6jICN4kTZfyzZT9BTYyKRaiYoSkKOKjuWqBN4xTkO7fhouC3nt2FSdmfa57o/8zpEpL9++ySAMRNlarsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZKY8L0lHf/YKBHW/t6BN6SXgdiFW/uJfucfnuDSo2s=;
 b=gJbhSnry1rLXLl23VVzluy6YMl6qFlBdRKqtD/SBJM2vjMSDDQx+88uQgU5aHxS6ECgjEC+139TLm+EDcDwmj9c3/uzM3bM3zkBuDoYs1SUj5WewDAyVUX+rB8xhnUtGlbL63obEoKIKQFkuTzoz2hGkYjrdYFU/WsAiKUFEGoSjNzu6hnd4WMfYPE2D47PfWHxH7+xdgNbWbReF5sxWeX2kzX0olil9tqZGNFuShjYW7fXiK/pYd5chnyZ/uQ5Xd+A1JCGrsyhNIW49xsU+gXYFPhkkDY8qyZBADSKMdId+fsKiYTRAyom6tin4fk/wtGzf/w5BBdeMJdCK7w2uEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZKY8L0lHf/YKBHW/t6BN6SXgdiFW/uJfucfnuDSo2s=;
 b=NrRNolY4m+NNwvlVw89gQEjMuGCsFeJlLEJ9cjbNBTCHsYXFPeotciNqKtGhA2LPykQwcydVyeUzYNyi3WP8lOEA5FOZr9MbSutuvmNi+XJfw+CAY73Rj4AjMtL7zd9hLDYhE2eEsNypnwt9xWDxoteA6wWnN3yuJOLxbhPD25c=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by DB3PR0202MB8962.eurprd02.prod.outlook.com (2603:10a6:10:43b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 07:18:49 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 07:18:49 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH 2/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Topic: [PATCH 2/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Index: AQHa/312frF1bpxddUKg2DUrEwzCVrJMmaEAgAKCWgCAAL3TAIAFgY+A
Date: Fri, 13 Sep 2024 07:18:49 +0000
Message-ID: <7c08bcb758d032d3fe37afb18fa31d052026006d.camel@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
	 <20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>
	 <20240907183518.1e8ee0bf@jic23-huawei>
	 <8361d77321d503b9690c40bb4f4293782c7ca5b4.camel@axis.com>
	 <20240909201346.5ee793d2@jic23-huawei>
In-Reply-To: <20240909201346.5ee793d2@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|DB3PR0202MB8962:EE_
x-ms-office365-filtering-correlation-id: 6b7468da-e31c-4ee9-4f42-08dcd3c4505a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejRMVllWTmloUHNnbWZyU09SeFk3MXFHbEppMEFxTG93ODFUYWd2S2xZOTl1?=
 =?utf-8?B?QURJb0p1QmlkVkovY3lsd3l2S0VDTDFOL3pZWXBYSFUxc3MybDBBSkFNcGVY?=
 =?utf-8?B?QjA4OVFmZnNHcCswL3VoUnhTYXYvenJJYnpoYTNnVjBPbFZ5UjdaWlRJRVpE?=
 =?utf-8?B?UWtRRE9WRTZiKzBoc25EQXh1eWRxbUZvZmdOWkd2ZkFEWk1zQVlaTEJadDZn?=
 =?utf-8?B?ZlM1N2k5TXg3U3Z5ZkhyamJwZFo2L3dTVDRsVE1TUmMvenVlRlhrUVdyWWFm?=
 =?utf-8?B?dkc0bkpjMzhXdGR5YWI4SEd4QmxDdHZCZlR4bzB1d05kQmF6a2dlRUZ6Q08w?=
 =?utf-8?B?WUJ4OHpsd3NuRjB4bmNJbmJad0N1aE9NMWtIQ2cvQ2ZueU1nWk56bUxGOWFX?=
 =?utf-8?B?WVJMdEtnaG1zNWdZcEFYMXFJZmRtWFNaRlpBb0hmQ2wxVmNCY1dvSXM3VEVY?=
 =?utf-8?B?YUU4aEFuNitja1gwVUdvREVrSHJHazg1dGozSnh6YkVaQUhVN28xQlV4cFlN?=
 =?utf-8?B?V3ZaaWI0eWxiajZtaURjL1R3SnIrclBhWCtwT2NMVHRuMFl4aGx3STZGVkwy?=
 =?utf-8?B?YlZoYTE1OHp1K1h6Rk5mZW13em15RzNxNEFTeWpQK1JJcEJYNlpIMDF6cXNP?=
 =?utf-8?B?ZkROMEtoV25SUXJEYTBTNnl3OHQvSVpZeXhjenk0UHFsM1REQjZyNk5pU1FU?=
 =?utf-8?B?aTNIQ1ZCdndoZHBwSHgxZmg0WW10UGMvbVI2WWxrWTlMbEQreXZKQWlZMHFK?=
 =?utf-8?B?L1ZCblBDU0pFTU5oMVNsNVQxZ2w4cy91a1NnWHhwUzhrYUJrTjZ2NXp6ajR1?=
 =?utf-8?B?cExySUhOR3BZaWYydk42WDlvOXZTVTZBS3VrOXpMRGIwaTlvSWlaMlFiOGNV?=
 =?utf-8?B?VXFyR2FtTDBObEQwV0NwVjVWQ1NSVkhTMlZJV29MZlVwdVZlWFV4aHl6SzVz?=
 =?utf-8?B?SzBHOWdWSDdhekJybkZJakpxbGEwTDRURlg3S3RtZzM2WHA3SHozbVdSRTl4?=
 =?utf-8?B?bTA3WUlESTF1YTJHRE81dFpnUlhySklNSUhMY1JPdG5GSVRpTUlOUzU2dmRT?=
 =?utf-8?B?Sm44VmYxWnJ0dlVMMzFFcjBnTG9IeS9YWlgxMlhzeUxRU0VGMTNuSGxsb1Ax?=
 =?utf-8?B?NnBidEVDZFN1UWVyRWpCeElCb1JpTUIrWDV5dS9BSlhhYXY5UjFxZW5rR0Ni?=
 =?utf-8?B?OXZsdUd5NGNsdk9mYzBRem8wN1pZTzlodFJUYUE0OXh4bHZBeHE5Z1lXazli?=
 =?utf-8?B?YU5CYk55MXZXZW9pOU53dFVNT3VKSHVOWFlMNzBVNEJDaUhZV2YwNHdORVpr?=
 =?utf-8?B?ODcyd0JLN3djRWlrbU54Rkx3bnZSaDd3YXFOOWs5a2N5MDVobGJCeTRIZ2xG?=
 =?utf-8?B?WGRjZFNoS1ZkMmpkZ3orczNwa1ptbFZXNkdBU2ozNWdSV2RtUXpoamVUYkhW?=
 =?utf-8?B?eGk0WUV5aENvMHNYcGR4RGorSXpEdXdXYkdOZ1N1SHhvM3dmNUJZZE8xSHRo?=
 =?utf-8?B?c1RPR1UzNDFxM3dnRG12WVlmSFZNeTc2S1llY3R4dngwMjBNUmpkdHo0eEJT?=
 =?utf-8?B?dXpxT01PaGVMcjNwMitwZERMc2Q1endVSjBkTG8zZE0xSHJBODlVSEtEelFQ?=
 =?utf-8?B?RGhxRytiMmtJejdQR0VMNWpYV2VwVkZtZGthRzhlaTgwRnMrYXZhaGlvMkpG?=
 =?utf-8?B?TkNNa3VKclhjb3RZckxlb1lRejZ3UUR5UkZGdFFDeStjYUJQVFpEUytHWlU2?=
 =?utf-8?B?d0JWK3A2TytVTGljZ25ZS3pvSitObThQNlFJcUF6Q1p6dEc0c2lSNlJtajAy?=
 =?utf-8?B?bllycjBHa1lXYk5NZ1YrYkZSdmlWdlZxQTVXbEx6bG02Sklkb2wyY1doSmdC?=
 =?utf-8?B?N05sR0ZsQVFYWDNDMUdubmRKbFE0RTBFQXZDMC9sV2VaTHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVV1czFoRjlJUlFGY255NTNlQ1ozL3V6MkplTEswbEFBT3JZWGl0ZzNWclNF?=
 =?utf-8?B?Ni9mTjN2THlxS2svNzVFaUpIdlVjT2dLSGp1UEZpM3A4TUVBY1hxd016TVEr?=
 =?utf-8?B?L3psRVNLaisvVDNUcUZCeGJXenRKT2FnNSsrd3NPNlpZdUkwMlZVUEhLQmwz?=
 =?utf-8?B?Wk9HdVAwU3NlRXE3MTU3ajdiVGxTeVNYVUhtaVJHYVZTNkhFS1U4aEpYcitt?=
 =?utf-8?B?MEh2akZ6TnZ6M1JvYlNKbTdteENvOGN4cnAzUGRLNlRVYWxLR0s3Unh2NldW?=
 =?utf-8?B?VFlNOUFaTDN3YWQ5ZzlaY0Znc242Y3NBVit0d29BbzZiTVNRRmozbldmWUNj?=
 =?utf-8?B?dXE5VDJMbFozME5QdC9ya0gvMjZncDBkYnM0SEVlZG1nQjhkbzkzRTFJcHFO?=
 =?utf-8?B?RlZIOXltUUFRTXFtY0JpanRzdzgxZC9HLzFkYm5HaVhDOVd1WGJCTUVnNWJ1?=
 =?utf-8?B?c1Jnd1lLU0FTRVR1eWh3akduemwyd0RoUWxySlE3RnJ4R0d2c1JTNFM0SHA0?=
 =?utf-8?B?QkdjZ1AraGtCKzBGTlhaWXF5MmxHeEhuNHI0cGdEYWdZakJrMG1jSkFQNmlE?=
 =?utf-8?B?Tk9Yb1hRQWF4d3lkOUMvN25wQ3IzY1pLNGhqVE45QkVSMC85bDMzeHhSOXFq?=
 =?utf-8?B?MnNOSnU3dElHK3lIZytlancvTmwzb1hsOHkxbzkrY1N2cVgza1I3VDBRaTJw?=
 =?utf-8?B?cjllNXJkZi9JZFJ5eEZ0OXRCVVV4b01zajdBYVoveCtGMW9ncTF1TWdCQ0hk?=
 =?utf-8?B?bVhhSU5qVVU4bTZJc3dmT3hKRkx1L1VQR2E1UEZ5bk04S1BJSURvSy85ZFMz?=
 =?utf-8?B?LzBDanRVU1lLREdaZUsvcWR3TjRTMmVQN0g1UUlucWFXVktTb2hMaVAwSHRz?=
 =?utf-8?B?a3ZQMFh0U0phMXU4RDFpUDRxUE1TVThBdmdmOUg0MElTNlBDUFMvaS80dktX?=
 =?utf-8?B?QXhKSk5uS1hETUk5MlFwdmlzYUFRZ1RNQ1RyVENGSTR4b20wN2lWdjRJZ2tv?=
 =?utf-8?B?NlBiU2tMaU9pTnZPN1hybUFVQVFnOVlaZ1N5aDJBZEtDVEhKVXhYOTdSSEha?=
 =?utf-8?B?d0ZKQkI5dENPSU1IazV3Um5ZdkoyK2d3cUpFUkhzcEZXUVg3L05pQlRUYmI5?=
 =?utf-8?B?a1JlQzZtenFDeVNZaDBDdXFoK2JOcmtFZ3JlU1RhN25jTHJOOWlmejczd1Nz?=
 =?utf-8?B?YkJKUmtEUXNpQXpDOGJOV1NxNjl0dHVJT3Zlc09KQzVhTDdYRDRURWNmTncz?=
 =?utf-8?B?VGxXNlhpSW5HUGtKTHBaVGdkSmxRM0c2WldMNVlXdGJoL3BSYjNhRi84UWsw?=
 =?utf-8?B?d2E1SEgvRzlNYTZGMjYxYWlVWlBYRmQzdjMvZVUzeFZFVTZ6SVZlWVVaL3NV?=
 =?utf-8?B?UFVVQ0lSVHByUGtPbXowVEU2Um1DOUN2ZjFTOVBXTEFBR21Kb3VOdjB5WEV4?=
 =?utf-8?B?QnpwM0U0MDMxUWJ4UU1wYm1ZbjU1aGRYaHBxc3BFYjVuNkNTbmF5RE5WOUZ3?=
 =?utf-8?B?S2NnY1IvbHFJMDIxZXdvQnVmNzZJa3hlbmMva2xuODFhK1h1SzM2clA5cWFw?=
 =?utf-8?B?MWNicGtLNStIa3JLZFkrTjE4Q3RVY0dpRlltTmEyYjc4Z0RtcjB6bUFJR1Bm?=
 =?utf-8?B?UEZJdVI2RWN2Y2hUL3hvazdEU0d3UisyN3VXdnAwR2JIamhJMjRWTjhWa2R3?=
 =?utf-8?B?QzNOWEN3NDA1alo2aHJCaEhoSXpJMUYyeWxhKzRJcUFCMUsyTzFNamJxbDhY?=
 =?utf-8?B?SHJtdTdsc0haTlMxZDNsOC96YWFsV1lnc3JZRy9BRzNJcmJwQjVadXZnb1VG?=
 =?utf-8?B?Vmx1N3dHU2FURWR0RU05VGFOaEVQek15bXo1bXl1QXZ5cDZOSk5KZ3JkeTMz?=
 =?utf-8?B?Z2J0bzNHSjcxMHRCK2dIMnhPQ1dUK0xJT2F6eDVwWDA3RU9kY1dHYXBQbUdS?=
 =?utf-8?B?TDAyS1VWVG1mVFZkM3hXT2lOYjMxZHJNbzdud1NPaFdib20yS2w0Q3I4amN6?=
 =?utf-8?B?eU1kRTh1blE0VzJ6bWVIcTdEVjF2SmorZER4U0tBcSthTEVyQ1prQjJOcDU1?=
 =?utf-8?B?eElHMUJ2eFR1RXJ6Nm5xVmNNNk1TTEFFN1h2QXVDb3RaYUhpalgxM2RuWUJl?=
 =?utf-8?Q?M/CS9/aA3ZN+mjRBzKZy8s5+1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E15849A2A36C254B8427601452CAB0D2@eurprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7468da-e31c-4ee9-4f42-08dcd3c4505a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 07:18:49.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8HBnfCvbPPWnfbUuL9Jiyeno7U+B4OCnUYjgTnZHD9XkIRv/p1wDAr/L0rPKDjk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB8962

T24gTW9uLCAyMDI0LTA5LTA5IGF0IDIwOjEzICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBIaSBFbWlsLA0KPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0
L29wdDMwMDEuYyBiL2RyaXZlcnMvaWlvL2xpZ2h0L29wdDMwMDEuYw0KPiA+ID4gPiBpbmRleCAx
NzZlNTRiYjQ4YzMuLmU2MDk4Zjg4ZGQwNCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9p
aW8vbGlnaHQvb3B0MzAwMS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2xpZ2h0L29wdDMw
MDEuYw0KPiA+ID4gPiBAQCAtNzAsNiArNzAsMTkgQEANCj4gPiA+ID4gICNkZWZpbmUgT1BUMzAw
MV9SRVNVTFRfUkVBRFlfU0hPUlQJMTUwDQo+ID4gPiA+ICAjZGVmaW5lIE9QVDMwMDFfUkVTVUxU
X1JFQURZX0xPTkcJMTAwMA0KPiA+ID4gPiAgDQo+ID4gPiA+ICsvKiBUaGUgb3B0MzAwMiBkb2Vz
bid0IGhhdmUgYSBkZXZpY2UgaWQgcmVnaXN0ZXIsIHByZWRlZmluZSB2YWx1ZSBpbnN0ZWFkICov
DQo+ID4gPiA+ICsjZGVmaW5lIE9QVDMwMDJfREVWSUNFX0lEX1ZBTFVFCQkzMDAyICANCj4gPiA+
IA0KPiA+ID4gV2h5PyAgSnVzdCBtYWtlIHRoZSBjb2RlIG5vdCBjYXJlIGFib3V0IHRoZSB2YWx1
ZSBmb3IgdGhpcw0KPiA+ID4gZGV2aWNlLiAgQWRkIGEgZmxhZyB0byB0aGUgY2hpcCBpbmZvIHN0
cnVjdHVyZSB0byBzYXkgaXQgZG9lc24ndCBoYXZlDQo+ID4gPiBvbmUgYW5kIGNoZWNrIHRoYXQg
YmVmb3JlIHVzaW5nIGl0LiAgDQo+ID4gDQo+ID4gVGhlIGRldmljZSBpZCBpcyB1c2VkIHRvIGxv
ZyB0aGUgbW9kZWwuIFNob3VsZCBJIG5vdCBsb2cgdGhlDQo+ID4gbW9kZWwgZm9yIHRoZSBvcHQz
MDAyIHRoZW4gb3Igc2hvdWxkIEkgaGF2ZSB0aGUgY2FsbGJhY2sganVzdCByZXR1cm4NCj4gPiAz
MDAyPyBJIHRob3VnaHQgaXQgd291bGQgYmUgY2xlYW5lciB0byBoYXZlIHRoZSBpZCB2YWx1ZSBh
cyBhIGRlZmluZWQNCj4gPiBjb25zdGFudCBpbnN0ZWFkIG9mIGEgIm1hZ2ljIiBudW1iZXIgaW4g
dGhlIGNvZGUuIElzIHRoZXJlIGEgcHJlZmVycmVkDQo+ID4gd2F5IG9mIGRvaW5nIGl0Pw0KPiAN
Cj4gR2l2ZW4gdGhlIGxhY2sgb2YgcmVnaXN0ZXIgbWVhbnMgeW91IGNhbid0IGNoZWNrIHRoZSBt
b2RlbCwgZG9uJ3QNCj4gcmVwb3J0IG9uZSBhdCBhbGwuIFNvIGRvbid0IHByaW50IHRoYXQgbWVz
c2FnZSBmb3IgdGhpcw0KPiBkZXZpY2UuDQo+IA0KPiBGb3IgZnV0dXJlIHJlcGxpZXMgY3JvcCBv
dXQgYW55dGhpbmcgdGhhdCBkb2Vzbid0IG5lZWQgYSByZXBseS4NCj4gU2F2ZXMgYSByZWFkZXIg
aGF2aW5nIHRvIHNjcm9sbCBhbmQgcG90ZW50aWFsbHkgbWlzcyBzb21ldGhpbmcNCj4gaW1wb3J0
YW50IQ0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCg0KSGkgSm9uYXRoYW4sDQpTb3Jy
eSBmb3IgdGhlIGRlbGF5IGFuZCB0aGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uLiBJJ2xsIGRv
DQp0aGUgZmluaXNoaW5nIHRvdWNoZXMgb24gdmVyc2lvbiAyIGFuZCBzdWJtaXQgaXQgYXMgc29v
biBhcyBwb3NzaWJsZS4NCg0KQmVzdCByZWdhcmRzLA0KRW1pbA0K

