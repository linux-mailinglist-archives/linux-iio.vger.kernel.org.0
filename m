Return-Path: <linux-iio+bounces-24456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6805BA3A7E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 14:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E343BA0B5
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47512EB866;
	Fri, 26 Sep 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="EQranucM"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011056.outbound.protection.outlook.com [52.101.125.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453718C02E;
	Fri, 26 Sep 2025 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890519; cv=fail; b=BPnmE00mc9xgYELCUEJbgRyGh9qAOJdVNlgin6a+TxhPrpCh5GQANtzDNIVUZFcAveRlI7dj1lmdy7Gb745PB6ZiwX/Q/rLuhYoCCbB5KOScuDxg2l3fhVY1syYqQtKooV3Agh4fIR3N63wg4xXJ967cPwtNcb7wtuvKqw1y/C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890519; c=relaxed/simple;
	bh=0ZH4vcS3xfMIcb6H9UcRUMq1SNyX3lstVYM1mfbCDds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWYDCr9Dyta3/knLNDj/qt9PnSP4DVhLSPJpnlEWrLbkNDjhV4RwE9+aZYVuTQ69qiZ0w181t0UtUWEaa+EFEpqV3iu5KFN/ZcORkJTL8A9NmDr5jDWyxX4+4giyhxkGgtpLeNwd4yu6f6pQpoPFFJJrKRm4hXdfQB4g+ztxtek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=EQranucM; arc=fail smtp.client-ip=52.101.125.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfjTTtBTzfFnY8AkpW2ONPTrGffVGhIv4fVD1pW+P5Fb3hcGm5METvaTHEpDJ8y6y3U/Fi1Np8NnLDnXGSdLHoDBeEVaKHQWUUrOeRc5B6yLYmoAdA8A9o8XTKahQSz251d8QVc8VRiuecRwMcGzANHL0fKFtYS338DAyD/EcBwavXsX2AXQiCUEW5TRpVgI1pKjjLl7j3n0S3m+2CI/4pFN7lXPNpWjYpSwf5p3HOM5xikxaBUroQdgnj68aN6g9fz2qnHh8o6nRlSOi7rOnlDQwpYFy7WkW1JAyskNaQH/9Rt1RRanBY3xazPYIPJPz8vtH2oKNKP5lMTNnGiZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZH4vcS3xfMIcb6H9UcRUMq1SNyX3lstVYM1mfbCDds=;
 b=OMyhLFQpoIx8zvbNjuUfxBwywRsc60ZaXkd6vvWWzJvjhUPN4j8wP8+Y7OiVBalkmQ3wUXC9AmI7RCZfZWzmEnGnF3P1ZCoj2xbgFVBoWb9EDDdsbiYacyKsW+pZloc3kGy/nOXfIoZlx8AzZmUpBe7Bj7zwtnuBb49ZIiv6Vhtkg7BvHZidBuQL+PWUQPu/ZAwD/Iz4ugGj4TCndIq991G/a594qWSOi3nHtn/Tf098QjTHZSudPdadyV8sVZgVPht1JEn4w9k2euaBQ818kWLkif8LFt5Y0QI4ogud6EvMOKJkpwvdM9R3WgY5eKmBx0t3OEGk8eo1tB08+dQ08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZH4vcS3xfMIcb6H9UcRUMq1SNyX3lstVYM1mfbCDds=;
 b=EQranucMPyyg3vhGD4hO+oaexXc2dXs4XGz6wMSc0bWBumljZKDs+KqX3b633+LMbuaUGCQoJhewaSETKvX+En2y/XfUkZPF8ti+7GrGpXHtMurthNaHbZgPcLDv+na0V6wVirYV2Av9KsS6yLR7gV2960NazOBeEEMb8ebZTjU=
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OSCPR01MB14679.jpnprd01.prod.outlook.com (2603:1096:604:3a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 12:41:51 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 12:41:46 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
Thread-Topic: [PATCH v2 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
Thread-Index: AQHcLm19C0G+Tb0RvU2pF43sbuhWT7SlYFWAgAAFc9A=
Date: Fri, 26 Sep 2025 12:41:46 +0000
Message-ID:
 <OSZPR01MB87987A7D3F418A6E7A24FC41851EA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
	 <20250925224013.2146983-4-cosmin-gabriel.tanislav.xa@renesas.com>
 <3550caed57f460a3d28ed585eda2d955bd846930.camel@gmail.com>
In-Reply-To: <3550caed57f460a3d28ed585eda2d955bd846930.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OSCPR01MB14679:EE_
x-ms-office365-filtering-correlation-id: ea17a716-9342-4211-fc80-08ddfcfa0e41
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0RGOWE2R3E3RGtjZW1vQk91cVdZb3lKa1N1Z1BydkFWbThlT0Z6VnlpNTBL?=
 =?utf-8?B?M0RrL1JiaHZPaWMxbkt5V1FmYU9yVS9FaGFzWU5QaWJpeC9tb09acGpWeVBx?=
 =?utf-8?B?UnVScjVYS2puT2J6S3FXSmFpQ0pJL3RNdzlLNGNvbU51MHYxUS9YZnhDazJz?=
 =?utf-8?B?N05nNC9VQ1NnVmROOE5kcWIzVU96ZG9qY3FqOFpuTGVEQW5oMkxmV2cxQTVh?=
 =?utf-8?B?ZVlsMG9Pa09Ca2NxSWhlNzFJTzVCYWVaeWZ1L3J1Vnp1K3ZUdlRHdkZyUmE4?=
 =?utf-8?B?YXMyQ0NFREtwSWJSTXgwTktkdXlzdFBTSGkzbmdaSjlSOTA0aC95RG9xTUsw?=
 =?utf-8?B?eHlwTXkweTZYcm1YSTF4b1UvOXJtT293VXo2TzhQb1htQ3BCdWl5QlhqMXRN?=
 =?utf-8?B?YUg1anFOa3NwWWF5dFpTODlYQXE5cHczaCtscG56akVGMmFXRGc4UTZsdkJJ?=
 =?utf-8?B?NVZBQ0taalluc2c2VlZhV0MwZ0N1YnE4elJRdytHZUVUREI3YktUME02azlG?=
 =?utf-8?B?YjRhSGJNUFJHTzFGNXJBZlhGMGVIQU56TFRCTkZJZm5Oa1lUck1TSTZScHhW?=
 =?utf-8?B?U1pyTzJta0hES0t3UHhCQkhrOVdQMkNFQ01yeDQ1aDhZOXVaQnRNMGtTci9v?=
 =?utf-8?B?VWc2ZlFDQ29jNWtpK3dlYW52U1ZKUHJZYmYyNmd2Q3FwR0lLb1hXYjFEV1pF?=
 =?utf-8?B?QmhvTDE2T0JBb1J0eitFSURqOTd1TEhaOHFVdXBIQzZ4aEI1b1JlWXdGTDFl?=
 =?utf-8?B?UFpPbUZwL2tiU1ArdDJwNkZQMit2U09LNFk0MU9yQ29BeFMzVXBYUVdsMXRm?=
 =?utf-8?B?ZmJjb3VBWk9CcEhzc09NT3g2TENmZUtFVnVtaVlNamtXaGFXUlNSams1bG4v?=
 =?utf-8?B?cDNiVU5ZUXN1TWtIRUEwb01zZlJxOVpBSStrNnZDV1lwMi9uVUVhN3NEcEFD?=
 =?utf-8?B?K2xkdEg3clRkVnpUY2hYbmQ4bUhnMitORy9UVW00dFBoTVF2TmZaMkRKVFE0?=
 =?utf-8?B?a1Y3ajI1QUlBYmdBYk5FRjBCS0pZMGk3QnVENEY0V2E3WEZwTEZvZ2hhZHhr?=
 =?utf-8?B?WVFkV2c5YTZwZDB0RisvNXREZmdsbkY3VmRUUTlkeFlqMjk5bFg0NWlOTTda?=
 =?utf-8?B?MjdMQTlyd1pwS1ZWbS80Mm1MQnk4bnFnQVRrNCs2UHV1K1dYK3pEUDFuY2NE?=
 =?utf-8?B?RUE1VThEajBjdDRCWURoTW1JaFZ3c0JjQUFEQ0haQzJrZ0hhZDFIV3puaU5j?=
 =?utf-8?B?NGJlaUR5TXRzY3RnRUhZR05uM1ZrTzhHdmtPZmxweXNCSGZNOVg4WGpUWnNF?=
 =?utf-8?B?alg0c2dwVEFsRTFkMVMrcHpLSm9kNFFFUEdyaHFnWlJ5QWJZR1ozR1VhcDZB?=
 =?utf-8?B?M05LZ2hKK2hRem9HYjlZcVFhM1NWa2FSSlJSaHpoVWovcmdZcUhjaHlaME5J?=
 =?utf-8?B?MENQMlVrUWNYcXVzbEo1V3pUYUlLSVpTUndiYnlCVEhpS2JKUVhxalFZaTRm?=
 =?utf-8?B?ZnRReHlQWW1QYU1XOTl6TEZMNmI1OGIvNUNFOWFPVkFoczNyS05aYWhmbEs4?=
 =?utf-8?B?dk16djBzTlM4OEZWWDZaSGFDS29mT1JzUWF0UkpJeUdWNzBvK2hGVWRKSlhT?=
 =?utf-8?B?SmRaSnVvU2VoNWl5dGQ0TjlOL2lCY2F4MFhoMzVhSWh3SWZuMVEvbmlhZ21u?=
 =?utf-8?B?OHhmQ08xZlpxQW1XR0J4TUFLdjFsMXVtditxK01pRnd0dWtLS1U2ak1TcjNJ?=
 =?utf-8?B?U0F1R1Fja24zMGhjT3NPbkR6b3BtRzJKeDZKMDMxanMrYzY0RytCK1BtNnRK?=
 =?utf-8?B?enhlR1cxWFRpRnF0WTVaalRxb1dSdDUwa3IzTkFBN3JMSFlJdEVnZzBKZHNs?=
 =?utf-8?B?TTVIKzVZOUhVZ0RTT285SEREeG8vS3lMT0Q3UzJ2Wlk1M1NmeXlBQXE0OE51?=
 =?utf-8?B?b2t1VzlzYndWWmM1MkJPWWJCL1dyT0tpMndoN0R6WS9RQVhHVm5xelJSMk1R?=
 =?utf-8?B?L3NaNWZFRmVabVgvMmdkOG1kM3Qra2ZBMXZKVk1LUTVWUlllVHRoYXVGNTVz?=
 =?utf-8?Q?IldarM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFVHcDMyVDE2OE5PZUNYaTU4Rko1enNJU3k5Q0szY1gxb1hxM01ncFdnZHow?=
 =?utf-8?B?OTJvbHpPOFAzVFlpUmVvOXFuNWpiRkcwZ1o1eFFwcTEvN0xpRHE5dVJIbE56?=
 =?utf-8?B?N0tIcE1lblJUWGtsTEFNNWZ0THRQc2o5eG1kUGlyckhoRitDamw2S1JZQlcw?=
 =?utf-8?B?OUlxUzZuYjlkN1FwbHZBL3lySitNZWRhYnFHYnZRTkQ0OUg1Z3lwR0ZvSTY2?=
 =?utf-8?B?d3UybTFodHlCQkpiS2dkYkZNdDNZWWlSV2N4bEcyTlRXQ1ArYVpid2o3TFdw?=
 =?utf-8?B?ZDhCZFlsWnhQV3Q2Y3o2QXBURkM1ZW91dDg2K1hUQnZPbFREYnE0cGEvT3JS?=
 =?utf-8?B?YUJEY2ZrL2tPb3FHUkNNVDkzSmQrcUZHQ2VIc1BQNmszSkR1dURBbXBzTWF1?=
 =?utf-8?B?WWp5QVg3eHloa1V5WUo3ZFo5WmJKYmFVZjhjRDQyRDJyRHRDQ1NUMi9NM21w?=
 =?utf-8?B?dTFNNEpzdUdoSDVCYXNhaE40TSt0ZFVNZTgzckZwRkJZc0VUckQycU5QV2pF?=
 =?utf-8?B?aUxFeU1HWHQyVUo0UTBVb0lsQUh2NDdLRHFIanp5MTRVYU9xMmp6MUw4N1ZJ?=
 =?utf-8?B?Tnl0MlFGOWcveVduRFl4QjJtZUVOZ1M2VmN4c3JxUWhJQmpXNjdVdVQwdll5?=
 =?utf-8?B?Q0huWUg2eU1tV2xENXVJZnhCNWJGT2xFNWUwN0dWNmNtcWU4Z0E1bm1zZS9W?=
 =?utf-8?B?Wlk0THZKajdNRFBVNkNoM0F0VFBVVlVjUUFOOEZ5enNYZVFaQ0ZOcjYxRlhW?=
 =?utf-8?B?c3A4Y2oxQ3BmbHZPRzFhTWx5Mys2ZElzaDluSkY4YzRoZk5EeEo1aUc3Ylc3?=
 =?utf-8?B?SVFXd2M3T0FKTDNVUjdJVThhWXJtSHF1VTRrZGxOdjI0czJUaG9TOGNHRHA4?=
 =?utf-8?B?UlBIc2t3aUx4S0JpMitMcTdUcmM4TmRBWkgrbmV6cjNuODZtM1pnZFI5VmV1?=
 =?utf-8?B?RzFoclJEeFFXOEJuVytSVXdZcVNCSDZWNDNqTng0WHlzdzh0MDhlcmJpaTc4?=
 =?utf-8?B?STVGR2VqL3FhRzFYYnJ5NVZub1JSKzQvcDd4a0xER1JOWElWRzB2ZU9kZGVB?=
 =?utf-8?B?cXdVQVFudW5TemdLY2F1YUtBSUpWNFU4ZFNXTE43RS85c1lLMVVNdHp5QzNE?=
 =?utf-8?B?S1BheWFKYjhMNTk0L3J4UjE5djBLQUdHcmZxSU5qYUJZdENvSlViSWZPLzFr?=
 =?utf-8?B?bTM0NElNNU5nWUNQemlGbVJIajlvTi9EOGVnK2MzdjU5d3czUG82aUhhSVVY?=
 =?utf-8?B?YUJ6ZTBKcjRMaUpsdGdFeTI2Q1c0cWcvZUxaY1d4WVpKcy94VU9zVkVmM2ZC?=
 =?utf-8?B?RlNZdmRqdWVoaDd2RkhDam9lTllaaFVUT01TdjJhU09oRndOQklpcG82c01C?=
 =?utf-8?B?bS9MZHh1cFlWRk45RHVCNDlOK1gyVVlxS0RvNUYyMWtGUmtCbVVpZUZ3TjJC?=
 =?utf-8?B?cXdYRXQraThZMkZ5cVk0VDhGSXEwMnFKeVo2d2dnR1lYM0puQi8xM3JMSGY3?=
 =?utf-8?B?TFU3Mk84aWRvUkEybkJ3eVVTYkE0SUFEUzRJaFpGQTAyNjNJY2I0bUFEUXBP?=
 =?utf-8?B?aisxS05tV3IxWnE2SlAwNnNZaWV2cnpPcjZCSmwvRlpnSjJtRlVVTWVjZEtC?=
 =?utf-8?B?VFlJbGR5UnozTjFhYTFYSU9TVTFSRUR2RDVaSk1aUDYwR2dFcHMxdVp2dEZs?=
 =?utf-8?B?YlRVT2pJM0lFMnVNd1grdUEyRnpMM1pOeVQ2K3FURmYvZERzUmlkblQ4Y2hk?=
 =?utf-8?B?SHhPcXpUbXJSenJ0SWQ0NkRWa1R1QTdxVG9McTlveG90N2Z3cE45TzhBUGt4?=
 =?utf-8?B?ZWFUdUxLakd6cWVZeHRMTWxYNis4MkdtTWkyY01CRUQ3UVlXbjdER0pvVG83?=
 =?utf-8?B?Zzh5TmxZTGk1Mk5VcWpHeDlqNzlKdXhucU1KRkVlaWh0RHZjU05oVVQvcnFU?=
 =?utf-8?B?NDE1b2VUNElyOFJhVVFmVkxIYzVXUE9NL2pGeTBDbGRMRi93MHUvYURrNnpZ?=
 =?utf-8?B?RmE2ZDdDMUU0aUYxRi8yd04rU0tiS3hBdjBkYmlMMGhESWF5MEVhZm5TMnlV?=
 =?utf-8?B?b1BrbG9GRUdGbGRpSVFYRTAzNmNoQlBEYVpkZ2thVVRydk5kZVR3Qkw1dnp6?=
 =?utf-8?B?Nml2dHlzVVgzUVVkeFBqb1hQTjlUVmhEMEF2NFB4NXVJOUVCZWw4OW9CT3gy?=
 =?utf-8?Q?bSAD7i82/ZyrgO2fdoZ2vjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea17a716-9342-4211-fc80-08ddfcfa0e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 12:41:46.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FQx5y0wa6Ul+Zh9o0fkkOK57TEPVePzsScrIqaPrPEkyF1r9sdUm6RAV2INQ+Xik7zko9W37hWRk8KnLt+XRJXR3rS5bFvxkIDO97XC3nHf7xnRi6vohRTi5/0Abu6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14679

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBTw6EgPG5vbmFt
ZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjUgMzox
MSBQTQ0KPiBUbzogQ29zbWluLUdhYnJpZWwgVGFuaXNsYXYgPGNvc21pbi1nYWJyaWVsLnRhbmlz
bGF2LnhhQHJlbmVzYXMuY29tPg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhDQo+
IDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxr
cnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBH
ZWVydCBVeXR0ZXJob2V2ZW4NCj4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgbWFnbnVzLmRh
bW0gPG1hZ251cy5kYW1tQGdtYWlsLmNvbT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiByZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgMy83XSBpaW86IGFkYzogYWRkIFJaL1QySCAvIFJaL04ySCBBREMgZHJpdmVyDQo+DQo+
IE9uIEZyaSwgMjAyNS0wOS0yNiBhdCAwMTo0MCArMDMwMCwgQ29zbWluIFRhbmlzbGF2IHdyb3Rl
Og0KPiA+IEFkZCBzdXBwb3J0IGZvciB0aGUgQS9EIDEyLUJpdCBzdWNjZXNzaXZlIGFwcHJveGlt
YXRpb24gY29udmVydGVycyBmb3VuZA0KPiA+IGluIHRoZSBSZW5lc2FzIFJaL1QySCAoUjlBMDlH
MDc3KSBhbmQgUlovTjJIIChSOUEwOUcwODcpIFNvQ3MuDQo+ID4NCj4gPiBSWi9UMkggaGFzIHR3
byBBRENzIHdpdGggNCBjaGFubmVscyBhbmQgb25lIHdpdGggNi4NCj4gPiBSWi9OMkggaGFzIHR3
byBBRENzIHdpdGggNCBjaGFubmVscyBhbmQgb25lIHdpdGggMTUuDQo+ID4NCj4gPiBDb252ZXJz
aW9ucyBjYW4gYmUgcGVyZm9ybWVkIGluIHNpbmdsZSBvciBjb250aW51b3VzIG1vZGUuIFJlc3Vs
dCBvZiB0aGUNCj4gPiBjb252ZXJzaW9uIGlzIHN0b3JlZCBpbiBhIDE2LWJpdCBkYXRhIHJlZ2lz
dGVyIGNvcnJlc3BvbmRpbmcgdG8gZWFjaA0KPiA+IGNoYW5uZWwuDQo+ID4NCj4gPiBUaGUgY29u
dmVyc2lvbnMgY2FuIGJlIHN0YXJ0ZWQgYnkgYSBzb2Z0d2FyZSB0cmlnZ2VyLCBhIHN5bmNocm9u
b3VzDQo+ID4gdHJpZ2dlciAoZnJvbSBNVFUgb3IgZnJvbSBFTEMpIG9yIGFuIGFzeW5jaHJvbm91
cyBleHRlcm5hbCB0cmlnZ2VyIChmcm9tDQo+ID4gQURUUkduIyBwaW4pLg0KPiA+DQo+ID4gT25s
eSBzaW5nbGUgbW9kZSB3aXRoIHNvZnR3YXJlIHRyaWdnZXIgaXMgc3VwcG9ydGVkIGZvciBub3cu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDb3NtaW4gVGFuaXNsYXYgPGNvc21pbi1nYWJyaWVs
LnRhbmlzbGF2LnhhQHJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPg0KPiBKdXN0IG9uZSBzbWFsbCBu
aXQgZnJvbSBtZS4gV2l0aCBpdDoNCj4NCj4gUmV2aWV3ZWQtYnk6IE51bm8gU8OhIDxudW5vLnNh
QGFuYWxvZy5jb20+DQo+DQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ID4gIGRyaXZlcnMvaWlvL2FkYy9LY29uZmlnICAgICB8ICAxMCArKw0KPiA+ICBkcml2ZXJz
L2lpby9hZGMvTWFrZWZpbGUgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2lpby9hZGMvcnp0Mmhf
YWRjLmMgfCAzMDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgMzE4IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvaWlvL2FkYy9yenQyaF9hZGMuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL01BSU5U
QUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gPiBpbmRleCBlZWQwOGQyNWNiN2EuLjIyMGQxNzAzOTA4
NCAxMDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+
ID4gQEAgLTIxODM3LDYgKzIxODM3LDcgQEAgTDogIGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiAgTDogbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnDQo+ID4gIFM6IFN1cHBv
cnRlZA0KPiA+ICBGOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9y
ZW5lc2FzLHI5YTA5ZzA3Ny1hZGMueWFtbA0KPiA+ICtGOiBkcml2ZXJzL2lpby9hZGMvcnp0Mmhf
YWRjLmMNCj4gPg0KPiA+ICBSRU5FU0FTIFJUQ0EtMyBSVEMgRFJJVkVSDQo+ID4gIE06IENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vYWRjL0tjb25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZw0K
PiA+IGluZGV4IDU4YTE0ZTY4MzNmNi4uY2FiNWVlYmE0OGZlIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvaWlvL2FkYy9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcN
Cj4gPiBAQCAtMTQwMyw2ICsxNDAzLDE2IEBAIGNvbmZpZyBSWkcyTF9BREMNCj4gPiAgICAgICBU
byBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUNCj4g
PiAgICAgICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgcnpnMmxfYWRjLg0KPiA+DQo+ID4gK2NvbmZp
ZyBSWlQySF9BREMNCj4gPiArICAgdHJpc3RhdGUgIlJlbmVzYXMgUlovVDJIIC8gUlovTjJIIEFE
QyBkcml2ZXIiDQo+ID4gKyAgIHNlbGVjdCBJSU9fQURDX0hFTFBFUg0KPiA+ICsgICBoZWxwDQo+
ID4gKyAgICAgU2F5IHllcyBoZXJlIHRvIGJ1aWxkIHN1cHBvcnQgZm9yIHRoZSBBREMgZm91bmQg
aW4gUmVuZXNhcw0KPiA+ICsgICAgIFJaL1QySCAvIFJaL04ySCBTb0NzLg0KPiA+ICsNCj4gPiAr
ICAgICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0
aGUNCj4gPiArICAgICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgcnp0MmhfYWRjLg0KPiA+ICsNCj4g
PiAgY29uZmlnIFNDMjdYWF9BREMNCj4gPiAgICAgdHJpc3RhdGUgIlNwcmVhZHRydW0gU0MyN3h4
IHNlcmllcyBQTUlDcyBBREMiDQo+ID4gICAgIGRlcGVuZHMgb24gTUZEX1NDMjdYWF9QTUlDIHx8
IENPTVBJTEVfVEVTVA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvTWFrZWZpbGUg
Yi9kcml2ZXJzL2lpby9hZGMvTWFrZWZpbGUNCj4gPiBpbmRleCBkMDA4Zjc4ZGMwMTAuLmVkNjQ3
YTczNGM1MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvTWFrZWZpbGUNCj4gPiAr
KysgYi9kcml2ZXJzL2lpby9hZGMvTWFrZWZpbGUNCj4gPiBAQCAtMTIzLDYgKzEyMyw3IEBAIG9i
ai0kKENPTkZJR19ST0hNX0JENzkxMTIpICs9IHJvaG0tYmQ3OTExMi5vDQo+ID4gIG9iai0kKENP
TkZJR19ST0hNX0JENzkxMjQpICs9IHJvaG0tYmQ3OTEyNC5vDQo+ID4gIG9iai0kKENPTkZJR19S
T0NLQ0hJUF9TQVJBREMpICs9IHJvY2tjaGlwX3NhcmFkYy5vDQo+ID4gIG9iai0kKENPTkZJR19S
WkcyTF9BREMpICs9IHJ6ZzJsX2FkYy5vDQo+ID4gK29iai0kKENPTkZJR19SWlQySF9BREMpICs9
IHJ6dDJoX2FkYy5vDQo+ID4gIG9iai0kKENPTkZJR19TQzI3WFhfQURDKSArPSBzYzI3eHhfYWRj
Lm8NCj4gPiAgb2JqLSQoQ09ORklHX1NEX0FEQ19NT0RVTEFUT1IpICs9IHNkX2FkY19tb2R1bGF0
b3Iubw0KPiA+ICBvYmotJChDT05GSUdfU09QSEdPX0NWMTgwMEJfQURDKSArPSBzb3BoZ28tY3Yx
ODAwYi1hZGMubw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvcnp0MmhfYWRjLmMg
Yi9kcml2ZXJzL2lpby9hZGMvcnp0MmhfYWRjLmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNmE0OTc4OGE1YzY3DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9yenQyaF9hZGMuYw0KPiA+IEBAIC0wLDAgKzEsMzA2
IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKw0KPiA+
ICsjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2NsZWFu
dXAuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2NvbXBsZXRpb24uaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L2RlbGF5Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9paW8vYWRjLWhlbHBlcnMuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lu
dGVycnVwdC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiArI2luY2x1ZGUgPGxp
bnV4L2lvcG9sbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvcHJvcGVydHkuaD4NCj4gPiArDQo+DQo+IC4uLg0KPg0KPiA+DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgaW50IHJ6dDJoX2FkY19wbV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArICAgc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsgICBzdHJ1Y3Qgcnp0MmhfYWRjICphZGMgPSBpaW9f
cHJpdihpbmRpb19kZXYpOw0KPg0KPiBOb3Qgc2VlaW5nIHRoZSBwb2ludCBvZiB0aGUgcG9pbnRl
ciBhcml0aG1ldGljLiBZb3UgY2FuIHBhc3MgeW91ciBkZXZpY2UgcG9pbnRlcg0KPiAoYWRjKSBk
aXJlY3RseSBpbiBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YSgpDQo+DQoNClRoYW5rcyBOdW5vLCBJJ2xs
IGRvIHRoYXQuIEkgYWxzbyBoYXZlIGFub3RoZXIgY2hhbmdlIHRvIG1ha2UgdG8gdGhlIGRyaXZl
ciBzbw0KSSB3aWxsIGhhdmUgdG8gc2VuZCBhIG5ldyB2ZXJzaW9uIGFuZCB5b3UnbGwgaGF2ZSB0
byBnaXZlIHlvdXIgUmV2aWV3ZWQtYnkNCmFnYWluLg0KDQpIZXJlJ3MgdGhlIGNoYW5nZSBJJ20g
cGxhbm5pbmcgdG8gbWFrZSwgbWF5YmUgSSBjb3VsZCBrZWVwIHRoZSBSZXZpZXdlZC1ieQ0KaWYg
eW91IGFncmVlLg0KDQpXaXRob3V0IHRoaXMgY2hhbmdlLCBwbV9ydW50aW1lX3Jlc3VtZV9hbmRf
Z2V0KCkgaXMgaW5zaWRlIHRoZSBtdXRleCwNCndoaWxlIHBtX3J1bnRpbWVfcHV0X2F1dG9zdXNw
ZW5kKCkgaXMgb3V0c2lkZSBvZiBpdC4gVGhpcyBpcyBtb3N0bHkgZm9yDQpzeW1tZXRyeSwgYWx0
aG91Z2ggaXQncyBub3QgZXhjbHVkZWQgZm9yIHNvbWUgc3VidGxlIGJ1Z3MgdG8gYmUgYWJsZSB0
bw0Kb2NjdXIgd2l0aG91dCBpdC4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9yenQy
aF9hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9yenQyaF9hZGMuYw0KaW5kZXggNzA4MDI5ZGM4OTQ5
Li43OTA1M2JiYzcxYzkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lpby9hZGMvcnp0MmhfYWRjLmMN
CisrKyBiL2RyaXZlcnMvaWlvL2FkYy9yenQyaF9hZGMuYw0KQEAgLTgxLDkgKzgxLDkgQEAgc3Rh
dGljIGludCByenQyaF9hZGNfcmVhZF9zaW5nbGUoc3RydWN0IHJ6dDJoX2FkYyAqYWRjLCB1bnNp
Z25lZCBpbnQgY2gsIGludCAqdmENCiAgICAgcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dl
dChhZGMtPmRldik7DQogICAgIGlmIChyZXQpDQogICAgICAgICByZXR1cm4gcmV0Ow0KDQotICAg
IGd1YXJkKG11dGV4KSgmYWRjLT5sb2NrKTsNCisgICAgbXV0ZXhfbG9jaygmYWRjLT5sb2NrKTsN
Cg0KICAgICByZWluaXRfY29tcGxldGlvbigmYWRjLT5jb21wbGV0aW9uKTsNCg0KICAgICAvKiBF
bmFibGUgYSBzaW5nbGUgY2hhbm5lbCAqLw0KQEAgLTEwNiw4ICsxMDYsMTAgQEAgc3RhdGljIGlu
dCByenQyaF9hZGNfcmVhZF9zaW5nbGUoc3RydWN0IHJ6dDJoX2FkYyAqYWRjLCB1bnNpZ25lZCBp
bnQgY2gsIGludCAqdmENCg0KIGRpc2FibGU6DQogICAgIHJ6dDJoX2FkY19zdGFydF9zdG9wKGFk
YywgZmFsc2UsIDApOw0KDQorICAgIG11dGV4X3VubG9jaygmYWRjLT5sb2NrKTsNCisNCiAgICAg
cG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoYWRjLT5kZXYpOw0KDQogICAgIHJldHVybiByZXQ7
DQogfQ0KDQo+IC0gTnVubyBTw6ENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cg0KUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgR21iSA0KUmVnaXN0ZXJlZCBPZmZpY2U6IEFy
Y2FkaWFzdHJhc3NlIDEwDQpERS00MDQ3MiBEdWVzc2VsZG9yZg0KQ29tbWVyY2lhbCBSZWdpc3Ry
eTogRHVlc3NlbGRvcmYsIEhSQiAzNzA4DQpNYW5hZ2luZyBEaXJlY3RvcjogQ2Fyc3RlbiBKYXVj
aA0KVkFULU5vLjogREUgMTQ5Nzg2NDcNClRheC1JRC1ObzogMTA1LzU4MzkvMTc5Mw0KDQpMZWdh
bCBEaXNjbGFpbWVyOiBUaGlzIGUtbWFpbCBjb21tdW5pY2F0aW9uIChhbmQgYW55IGF0dGFjaG1l
bnQvcykgaXMgY29uZmlkZW50aWFsIGFuZCBjb250YWlucyBwcm9wcmlldGFyeSBpbmZvcm1hdGlv
biwgc29tZSBvciBhbGwgb2Ygd2hpY2ggbWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gSXQgaXMg
aW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0
byB3aGljaCBpdCBpcyBhZGRyZXNzZWQuIEFjY2VzcyB0byB0aGlzIGVtYWlsIGJ5IGFueW9uZSBl
bHNlIGlzIHVuYXV0aG9yaXplZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCwgYW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlvbiBvciBhbnkgYWN0aW9uIHRh
a2VuIG9yIG9taXR0ZWQgdG8gYmUgdGFrZW4gaW4gcmVsaWFuY2Ugb24gaXQsIGlzIHByb2hpYml0
ZWQgYW5kIG1heSBiZSB1bmxhd2Z1bC4NCg==

