Return-Path: <linux-iio+bounces-14592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A855FA1D330
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 10:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F6C1886D1D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7FC1FCFF4;
	Mon, 27 Jan 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Z+XB+g9O"
X-Original-To: linux-iio@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010045.outbound.protection.outlook.com [52.101.229.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB01FBEBC;
	Mon, 27 Jan 2025 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969468; cv=fail; b=cObheNTl0beCnPW5LxVTf+lTVzjcLTJpWTMQe2D3dU2+4wSqg8uXMJCVMjP3Jg2UZSeGcMyt6x4COX9G/m1KiCxJb2b9BRM7GQ4ym6SODSakKhjrYP4FZfpaRn3l6kPy636hqawxdhWSYTbyogCPOMgSHb1/i7u/URFmaEIEhhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969468; c=relaxed/simple;
	bh=SRMx8EPEPUrfG0UrZ9WSJowSt/9Wk9gIM25AIic5u4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jZhzrYEVov8Y4PUPV4wBUwc2xzv7U91srwozDZxkiKT1n0IAPX+7uqndtTc7HT3wcS+8Fd0/mt9ommTeuASUHQjhMA6wc7EjiZwOOsMkqCMi8E3BNMZiRsb2OJs//MOV5KxcWx+TRdnkMsK0ZjO7X8wPVKFfhkPMm2HV2w307uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Z+XB+g9O; arc=fail smtp.client-ip=52.101.229.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy33un4BUq8HSr1lHd8G2B7U40ItmfTwXSBHKSHauqHrhkbhI17qLwviy07S4HzOz/lknK9g65fPqdVG8FXr9eHdDaPv/4t01F60UBaEHP3dhs+9UpD8/M1KP7R/nkswTifbbQqQNp8gvVX0lopoK7R1r//p5EOSlVYDbSscGd8MOJp8cqfTSCqhEqMFSh85zQ35z97flXRpee5Ot0UN9Y5ejOIemee3S5/g8h3F6Bq8fMwjVP/zZo4nUpxXKhXAfsVN7SscKanYm/SYPSaZn7eYb1Xp1JRWLuJh1GTHe0GuYetbMmLO9hSEe45BA3u+QFG9ppQUrmciGwtme74HHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRMx8EPEPUrfG0UrZ9WSJowSt/9Wk9gIM25AIic5u4g=;
 b=XrnvxfHXVTfnntXYg5B3G5oWEsLwUIyVTVQL1obkpzuTgThGpc7el0zw55w6Cy684z9TPuEYv5yAuQplyuZfCVC9W2nMcdm/qLAIuIbbP1suD+NLtP2LC8rAwqXQYlDyd1SrhT04u1S2Az5IzvT9hZ1gcc5t/TvlM232u2EIbn4qVbe2DeuZSYqqLQ3AUArLtmI4i5SQPJIFw0iH/BVz/EpPO2EWzxr/53sXthfobVdnWOMdruqkwmOy+gtUO1QcA0Res8ZwaueXUpZADBzCm3HEjtibrvTIq+k7B2hJV047NgGuxFtEm7EvQxx3PICSHKWvn5QhGesN5/B4MxgUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRMx8EPEPUrfG0UrZ9WSJowSt/9Wk9gIM25AIic5u4g=;
 b=Z+XB+g9Oj39ljQd+tks4P3AaVwujVFEPWFphUXXqrWKMjfksnCrEfU6Gx/4Om7TH0VcUb0z6d0c9IacXKDGMte9AXs69/fXBZERAhuumM6YDQQBbfllenpweI5ijPlW2ZdAfs8Hr/a1NN/HwF9OSnCGBy4t+BD2jN18WaN+cPT0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS0PR01MB6116.jpnprd01.prod.outlook.com (2603:1096:604:c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 09:17:40 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%2]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 09:17:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Jonathan Cameron <jic23@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "open list:IIO SUBSYSTEM AND DRIVERS"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the
 Renesas RZ/G3S SoC
Thread-Topic: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the
 Renesas RZ/G3S SoC
Thread-Index:
 AQHbbLiRZuuEzRuiPECSqOFFElutJLMnbQcAgALlrICAAAYRAIAABENAgAABo4CAAAA+gA==
Date: Mon, 27 Jan 2025 09:17:40 +0000
Message-ID:
 <TY3PR01MB11346C3FC03D5878035C4E5B586EC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
 <20250125121826.6abbe7de@jic23-huawei>
 <3c7f5a92-254c-4ce1-9813-80c98c1f549e@tuxon.dev>
 <CAMuHMdUPPTyuJuWDEuHFT8EQCTVpy5=UtDh9GajdWUvZBNqy0g@mail.gmail.com>
 <TY3PR01MB113465C742C78714F7BC09D5786EC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <3efa204f-ed98-42a4-a708-828bcf1f976a@tuxon.dev>
In-Reply-To: <3efa204f-ed98-42a4-a708-828bcf1f976a@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS0PR01MB6116:EE_
x-ms-office365-filtering-correlation-id: d1e59175-fe75-4e91-b7ac-08dd3eb37310
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFJ0aEpmaDJOMGY3SHIrd0t6ME9XbDhMZ2ZhZUQ0amZ4bWpDeUNybHNoeEd6?=
 =?utf-8?B?RkVtbWI2dThUQWJ0dFRFWUdsaDZPSzhocVJQdFBnVnZSWU0rNi96Wjg5NzhV?=
 =?utf-8?B?QnhpV0YrVUdsc3l3OHhnZXNpTWt4dllVNWJkTXJJR2RMTDc4MmpVc1JscS9n?=
 =?utf-8?B?MWVVRGhHazllYnlNSWxQWGdlNG5BZ3RpalJnU3J5UFR4WldKWkI0Y1h3RWEy?=
 =?utf-8?B?RG10dHJhMWxmbnEvcng0SW91cFljN2Y4ZmpvcTc1cExkYUJmSUJxbTBaalhy?=
 =?utf-8?B?QjFLRFNoWGEycXd6ZmF5TmVoVlpyMzdDZzJWc0tYSlE4ckQ0ajEvUVExdUJB?=
 =?utf-8?B?V25TbUNkU2tiMTFJRXBYUDF2S21sNkI5Uy84alBabThxcEozd3ZNTUlhNGVw?=
 =?utf-8?B?dDdKRkpjRG1YT0phVWpsYUZqQkw2T3BlNzdxWnZ1UHdiazUrYVRFZlY3MTRM?=
 =?utf-8?B?NVFmR0czTHJKeWxHMzlrV0F6TGRKREwweXYrNWEwd1ZYRDdvRlhzNHJMazYz?=
 =?utf-8?B?Q2RPbmpwU3RuSjdpUTBhZ00xMzl4VXgrbjRnQWo3RTkwQUdqSWt6dVhyTGlo?=
 =?utf-8?B?N1h2MDA3WUFkNmZIdkk3TDVFY3BwRE5lMkQwdWdKSFA2SXdLUjlNQUYwQjhJ?=
 =?utf-8?B?Wm4vWisrNXJYb2lrSE5ways0cktGYWtyZ0g2UHVVdGNjamtqREZ2NWdSclp4?=
 =?utf-8?B?RGQwMjhRUEg3UFBSM2dlUFlTTUlUNDdraEwwM0JraHRJTkJQV0x3Y1dPbklE?=
 =?utf-8?B?RGNIMFJ5NXoraTBGMDJjckIwYkFXMWJ1TWxZM3hNSng3ZVNYZU9qUjZrMTVn?=
 =?utf-8?B?Ylg5MmhKVEMxNGprTDFtMmxEVFlsTmthY25zOWt3K2VvdEJLUzcvOTROZk50?=
 =?utf-8?B?bGdYcVJ6Zitsa2oyMkdTclRZLzlBK1o1TUl4OGcxaFRZS1VrRXlPalVrMGV6?=
 =?utf-8?B?cFZQVUpZbEhVWFZuK200bWtKVDZjRGVUbFpZMVhRU1NUY0tJYzVwcWM3WWdv?=
 =?utf-8?B?ZFFqSE5DT09tM04yRGQ4ZXJhMDVFck5ISWxlTFdlN0ovcXNNOWRhMTNmRlEv?=
 =?utf-8?B?aHlrV2JZR1ZwQW92YkpyZE5GdTdJeE1lODBsSzBMZU82dXRFeDZsNHVFblBL?=
 =?utf-8?B?UkMxOVMvdUZuYjJCOE9GZlVta0R6cjRHMU14cDZZM3M1VlduV0l3aGEzRnlH?=
 =?utf-8?B?eFJjYmRrMWhOOVRUK3FRTk45aktIbkpEOXpNYzY1c09kY2ZHYkRGTkNlQ1BZ?=
 =?utf-8?B?ZzFkRG9Yd0Vqa25nVk5MVkh0SXRCcUNvRUNlVWtJZUplSHJJamFmVFlWOGor?=
 =?utf-8?B?MEpZQjl1ODNiUnZJaXh4R0pQWXFvS2xYS2lJVXVZNjMwOE1zcUJwbVZEUEZm?=
 =?utf-8?B?REdPZTl1Y0xadENja3k1N09aKzF4TGZmUCtTQlUwMGpZb3lxR2ZWODBYcFhy?=
 =?utf-8?B?RVVVS1ZIMkFlN3VVcTg1VXJaangxK3BJUm82SUtJTVRmZTNyamkvM3JQNDdo?=
 =?utf-8?B?WC9mUVA4cHB5czg1LzFoUjlsUnBRS2Y4RW5XdHJ2cFF4cCsvbHRIUFJHV1Yv?=
 =?utf-8?B?VjRZRnNnUnUrVlhaZjF3aVA0OS85VDBTcTc2bkFpQjVxVFEwelBrbEJiT29n?=
 =?utf-8?B?bTRIRjloRk1rMVlYdUFNbGpremxzS3MwWmNrdmZSYkdRak9LTHN0Z1V1dmcr?=
 =?utf-8?B?bi83akVOZE44cnZna0p6NldRaEIySUluNXViWkd3bkp2cFVCcTY1RndkVkw3?=
 =?utf-8?B?VzRVaWl0TC9sNU5yaERYVStKMWp2anVsNlJ6Ukt2N1l6ZWFVM1R4czZtTXY4?=
 =?utf-8?B?Rmg3MWZnWUc0ZDM5YWwySFFOVm1FNEV3VzE2OUZ2VE5ENTZlL0JYdzBhMW5Y?=
 =?utf-8?B?MjU1NzJFRkhZSE54Z3VOT2hwTy8vbHRqWFg5eHp5SjFZdTdPRTUxR1dqZHU1?=
 =?utf-8?Q?KIdUgRc2M+1u5MFlrAtyqu2taKD/H42I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emVIaXk5aVZtb3BBNDFQVVdlR3VVRFBIY1g5em9OTEt0UE10N0UrOE1Ib1Zx?=
 =?utf-8?B?TGRtZ3I3NFZrSm1VMnVjczNkOWtqcUJrV3p2WEs4VW5xUEEyL25kTVUyQWdl?=
 =?utf-8?B?VU9CdDlqbXZBSlMxdGRUaEZvbHNGZGM0cHBpRVFIYjJQL2QyMWJkQkc5aWJ0?=
 =?utf-8?B?S2I4ZkhQUVZJb1JValVwWTRiMVQ3TWdEM2VFY0Y0V0plUkZSZG1iL3NTck9K?=
 =?utf-8?B?OGIvS29HL2VuMG1sSXBJdDZzcEEwK2dVVXMrZU54amxWcG0vdXBXV3Q1d1NT?=
 =?utf-8?B?VTlxWnRNa1VNNTRYR1drNXJpZGdiK3VUZmM2WlZEOFpJcUhuNVROSE9jK041?=
 =?utf-8?B?MVNrZUJRRWppaUtEMDk2QUoyQy9ObWZxVG1qblVIM1huTlhZdEd1aEwyZTB5?=
 =?utf-8?B?eWtJMW5jeWZCMWtja3QxMUpzVWVuSkZTanpuamhxcEEwczVTcldqdk1RTGVI?=
 =?utf-8?B?QVlmOWNCQkhkTWx1TFpXdXY5S3dvWVBvTDRHOGRPTGt6UGdMdDRHRmpVQ1lO?=
 =?utf-8?B?ejh6Q25VamlLbjhPZjN3SWZYOG5ocGVyUVFueHhQRjFFTzZ1Rk9TV1UyL2FQ?=
 =?utf-8?B?d3ZpUGtWV2VEeVovR1ptWldKdCtZNUVGc0F3dFExR0d1L2xnTzZPTHVMaWk4?=
 =?utf-8?B?bmxmeTRDanVqcGtsbFkveFBLNGc5ZzFRMmtqTEpPQmNtai84RFV4bk54SnZy?=
 =?utf-8?B?V0FVYzFSYTZ3NjQ1SWlYSlA5c0Fqa3lKQjArV0dpeEVmUUZ2YTVLOFN2MlQx?=
 =?utf-8?B?ak0vSnpLYW5NUVduWUNCR0dxTTF4TUwrOHlJN2x3YURWTEY2WkZURlMrZ1VJ?=
 =?utf-8?B?aVh2d1FtVUFXRUgxVG9rbVlOV2JNbTdHZGFGL0FsRmM0dVcxUE1GZHFucHFZ?=
 =?utf-8?B?QXQ0NG1NRDlJWGxnb2hyODhwVmpwZWdpQ1d0SlhRTVJLY2x6aURBeGd6L2pk?=
 =?utf-8?B?QkdsZVFmeXdRdGRXVTRSZFhrUnAvazVsVXNxZVBsSW5yamtjTmxTZTFRL0tl?=
 =?utf-8?B?d3BlN2ltNC9yc2U1SzhLNzBIaHljZ0x0RzFOV1pXNVNpS1lSY2N1dllFQVJv?=
 =?utf-8?B?T2UvWjFxNWx0dnNKVWF3eGhYYlE4K1BqZ1lKd2Q0YlRMbnlEYnNLNHZCN2cr?=
 =?utf-8?B?ZHUrRE5RNnJPRG9UbDdrbGFaL2dxT2hCa2tqMWpMUHZzZTFiY05rUWxQZFdG?=
 =?utf-8?B?T20wajliQnZTYngvUHdRQzQ5ZmtBQW5xRXFMYk96SHRodGhFVnBYOWFLL0tt?=
 =?utf-8?B?T20rRGFOcWNCZWtNQTNsaXlBd3JwdXJta3RNaFJtTkpxdmZuSVJLTjQzQVND?=
 =?utf-8?B?bWF6d3dVMXFQTk9JVTdUbjJrS3V0WVNQUHkvMUJPRU0weDBNSU9za2pOZE5I?=
 =?utf-8?B?U2l5TGN0WUxFaE5wYmwxUU8rMGZENzhMRGR2Y2RxZlZkVVI0VENET21Dbzgv?=
 =?utf-8?B?QUpkcytQcXVjMlNDdjgzcHQ4MURtU0RONmlaTHRESzZLcUpBSG8yd3p5bXFP?=
 =?utf-8?B?M01vdTlEMklBNUhHM05zTlFyVzYrV3RUd0NmSnQxcUtOa0RxT0h6cWNWdG1U?=
 =?utf-8?B?RlA1RWE2L0NlZ29mVGF4SXJ6cWRUekFsbEN6Z1hWOGYxSk1WVXdIMkVZcmtl?=
 =?utf-8?B?anRaeWthaVFidkwzNUQ5eGpmUWRYdjF3R0lhR0NsVEdCWGRNZFdjWUUreVZS?=
 =?utf-8?B?dzZ0TE45UjVVejF6THdRdC9sVTBad2k2T1ZSZ2dVWVFOYjhlUHQ4cm80Zldn?=
 =?utf-8?B?cnBDSVFveVhCajBzZklJcnk1SmNoOUdFT20weVhaaGxkc0NFdTdhS2JTQTdv?=
 =?utf-8?B?K2F5Q2ZuaDFyL2JzRE90QmU2U3h6YVc2QjZvdUZsMEpPOVFxOEhzZnBhMVY2?=
 =?utf-8?B?TlJaaUlyeGdMNWVXSEFCWEFpNU9mN1JZTVp2cUxqd2VyOEdEajJnZlJMbjhG?=
 =?utf-8?B?T0trbTF2L3RTQ0R2U1Z1WGFOdjY3a3FtcFcyd09RS0dnTUdGQlVEekY3c29Y?=
 =?utf-8?B?U3ZkdzJRemxKMjBIK09KN0FUZEdpR1BWNW9iWHNhNUFlRitkSWZZZTMvWmhv?=
 =?utf-8?B?bE1NaE0xRFNmcmI2b1J5VXZGZjlkaXYyOWt4VVAzT3RFSEhVbFJEMnorODlI?=
 =?utf-8?B?TXh5TW0wckxpSUt4QmtiaGgvL1ZDamljZWtYWmlFZG1zcUZidVhVaUtac2NF?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e59175-fe75-4e91-b7ac-08dd3eb37310
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 09:17:40.6392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAJimMmnYvbbL5QKfsRYXrAFmHGVuF6FIl3aSHG95yvd9LjHVxc7v8IEcsT2nergPI1AThbkYG8+yPZ5wpoZoZpOIPgNE+ZefH0fROV4eXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6116

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAyNyBKYW51YXJ5
IDIwMjUgMDk6MTYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzZdIHRoZXJtYWw6IHJlbmVzYXM6
IHJ6ZzNzOiBBZGQgdGhlcm1hbCBkcml2ZXIgZm9yIHRoZSBSZW5lc2FzIFJaL0czUyBTb0MNCj4g
DQo+IEhpLCBCaWp1LA0KPiANCj4gT24gMjcuMDEuMjAyNSAxMToxMSwgQmlqdSBEYXMgd3JvdGU6
DQo+ID4gSGkgQ2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+
PiBTZW50OiAyNyBKYW51YXJ5IDIwMjUgMDg6NTUNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCA0
LzZdIHRoZXJtYWw6IHJlbmVzYXM6IHJ6ZzNzOiBBZGQgdGhlcm1hbCBkcml2ZXINCj4gPj4gZm9y
IHRoZSBSZW5lc2FzIFJaL0czUyBTb0MNCj4gPj4NCj4gPj4gSGkgQ2xhdWRpdSwNCj4gPj4NCj4g
Pj4gT24gTW9uLCAyNyBKYW4gMjAyNSBhdCAwOTozMywgQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQHR1eG9uLmRldj4gd3JvdGU6DQo+ID4+PiBPbiAyNS4wMS4yMDI1IDE0OjE4LCBKb25h
dGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+Pj4+IE9uIFdlZCwgMjIgSmFuIDIwMjUgMTE6Mjk6MTkg
KzAxMDANCj4gPj4+PiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3
cm90ZToNCj4gPj4+Pj4gT24gRnJpLCBKYW4gMywgMjAyNSBhdCA1OjM44oCvUE0gQ2xhdWRpdSA8
Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2PiB3cm90ZToNCj4gPj4+Pj4+IEZyb206IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4+Pj4+DQo+ID4+
Pj4+PiBUaGUgUmVuZXNhcyBSWi9HM1MgU29DIGZlYXR1cmVzIGEgVGhlcm1hbCBTZW5zb3IgVW5p
dCAoVFNVKSB0aGF0DQo+ID4+Pj4+PiByZXBvcnRzIHRoZSBqdW5jdGlvbiB0ZW1wZXJhdHVyZS4g
VGhlIHRlbXBlcmF0dXJlIGlzIHJlcG9ydGVkDQo+ID4+Pj4+PiB0aHJvdWdoIGEgZGVkaWNhdGVk
IEFEQyBjaGFubmVsLiBBZGQgYSBkcml2ZXIgZm9yIHRoZSBSZW5lc2FzIFJaL0czUyBUU1UuDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGFua3MgZm9yIHlv
dXIgcGF0Y2ghDQo+ID4+Pj4+DQo+ID4+Pj4+PiAtLS0gL2Rldi9udWxsDQo+ID4+Pj4+PiArKysg
Yi9kcml2ZXJzL3RoZXJtYWwvcmVuZXNhcy9yemczc190aGVybWFsLmMNCj4gPj4+Pj4NCj4gPj4+
Pj4+ICtzdGF0aWMgaW50IHJ6ZzNzX3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikgew0KPiA+Pj4+Pj4gKyAgICAgICBzdHJ1Y3QgcnpnM3NfdGhlcm1hbF9wcml2ICpw
cml2Ow0KPiA+Pj4+Pj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0K
PiA+Pj4+Pj4gKyAgICAgICBpbnQgcmV0Ow0KPiA+Pj4+Pj4gKw0KPiA+Pj4+Pj4gKyAgICAgICBw
cml2ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7DQo+ID4+
Pj4+PiArICAgICAgIGlmICghcHJpdikNCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUVOT01FTTsNCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+ICsgICAgICAgcHJpdi0+YmFzZSA9IGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPj4+Pj4+ICsgICAgICAgaWYg
KElTX0VSUihwcml2LT5iYXNlKSkNCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRS
X0VSUihwcml2LT5iYXNlKTsNCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+ICsgICAgICAgcHJpdi0+Y2hh
bm5lbCA9IGRldm1faWlvX2NoYW5uZWxfZ2V0KGRldiwgInRzdSIpOw0KPiA+Pj4+Pg0KPiA+Pj4+
PiBHaXZlbiB0aGVyZSdzIG9ubHkgYSBzaW5nbGUgSUlPIGNoYW5uZWwsIHlvdSBjb3VsZCBwYXNz
IE5VTEwNCj4gPj4+Pj4gaW5zdGVhZCBvZiB0aGUgbmFtZSwgYW5kIGRyb3AgImlvLWNoYW5uZWwt
bmFtZXMiIGZyb20gdGhlIERUIGJpbmRpbmdzLg0KPiA+Pj4+PiBJIGRvbid0IGtub3cgd2hhdCdz
IHRoZSBJSU8gcG9saWN5IHcuci50LiB1bm5hbWVkIGNoYW5uZWxzLCB0aG91Z2guDQo+ID4+Pj4N
Cj4gPj4+PiBJdCdzIHN1cHBvcnRlZCwgc28gZmluZSBhcyBsb25nIGFzIG5vIGZ1dHVyZSBhZGRp
dGlvbmFsIG5hbWVzIHNob3cgdXAuDQo+ID4+Pj4gV2lsbCBqdXN0IGZhbGxiYWNrIHRvIGluZGV4
IDAgSSB0aGluay4NCj4gPj4+DQo+ID4+PiBJZiBldmVyeW9uZSBhZ3JlZXMsIEkgd291bGQga2Vl
cCB0aGUgbmFtZSwgdG9vLCB0byBhdm9pZA0KPiA+Pj4gY29tcGxpY2F0aW9ucyBpbiBjYXNlIHRo
aXMgSVAgdmFyaWFudCB3aWxsIGJlIGV4dGVuZGVkIG9uIGZ1dHVyZSBTb0NzLg0KPiA+DQo+ID4g
SWYgeW91IGFyZSBwbGFubmluZyB0byBleHRlbmQgdGhpcyBkcml2ZXIgdG8gb3RoZXIgU29DcyB0
aGVuIG1heSBiZQ0KPiA+IHVwZGF0ZQ0KPiANCj4gSSBkb24ndCBwbGFuIHRvIGV4dGVuZCBpdC4g
TXkgcG9pbnQgaGVyZSB3YXMgdG8ga2VlcCB0aGUgZHJpdmVyIGFzIGlzIGZvciBhbnkgcG9zc2li
bGUgZnV0dXJlDQo+IGV4dGVuc2lvbnMgdGhhdCBtaWdodCBhcmlzZS4NCg0KT0ssIHRoZW4gaXQg
aXMgZmluZSBhcyB0aGUgZHJpdmVyIGlzIG9ubHkgZm9yIFJaL0czUyBTb0MuDQoNCkNoZWVycywN
CkJpanUNCg0K

