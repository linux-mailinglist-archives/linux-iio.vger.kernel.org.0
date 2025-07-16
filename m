Return-Path: <linux-iio+bounces-21724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5EEB07831
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9D03AA31F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A0220F2D;
	Wed, 16 Jul 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="cJMXw0K7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58223F9C5;
	Wed, 16 Jul 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676342; cv=fail; b=RyjbDq0k/GjgauhhK4l5+3lTY7PBfxmZuB7Ice0zpcbzXC4FijefXDeZjOBVCcku9rzGHggAdpO9wED7Z8n2LcZwj9HoFNj+lbObgzQs8zn867ZSwPlrBMw6Ia45bNR0SiM9eTgJesjwdFw/rnppVxn31Xgd904yROhN1D+lDMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676342; c=relaxed/simple;
	bh=wxwKXirQ0wIzvuPPTty9RcnLY6JbdxtsWl4NZUrOtAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=md1UvvMkniXVNobqxCFcAUJMaKXlCnvwxhhrJHU+5ur6MiejQBgaim3IZt4bhM3MFsv5I9WolWg5WeIAZpvjG1kkIVdS4INJ0ri+i50r+J1lLtzGZolv2gZNELU9wiMVMOR50IHk6sD8+5ycVFmeX6nds2TwOKCKYXM/AgZt4Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=cJMXw0K7; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FNONdZ007210;
	Wed, 16 Jul 2025 14:31:39 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010061.outbound.protection.outlook.com [52.101.171.61])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47uft5u627-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 14:31:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTP5EQ36oTc6oO/EtlSHYjS1MZDHqVHbvVvBNS7UmEFz0yqmiHaYdgM51twHVRIhpvTfmM+lIBT8OEH/JVhqRgKCrzdTUL235DHQ0Nk7WUItIVux7QroEMxrQt6Ie5MML4IqAWJodd5/6a5fczR84cRnp9TFthgSZcYugw+9hzkBYOInSYDLLrqhA8CJswLSGvGfjGlMUwWLaGq8bqgsNV3FoMEw2k87ZQHDQGJdhgV33CCTOKB8ExhOTSQpTG6++bOfDUGTLwAmby+gFUUzmL1H+wdzAR7UvkJ/pPystF+TpmaZBdqTt1yrM2rUuC+p66TyR2nlP1gAWw7Sg3w1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxwKXirQ0wIzvuPPTty9RcnLY6JbdxtsWl4NZUrOtAk=;
 b=CdttcAF0hNj73TSYUHhjje2uF2d+i9nYeP2BhIkrpTF94QnuW2V7pEKgC9xiUH7/AgwkCQ5s8ADVlIDT5nrPDPxaEfMVfByI3iYDgqtmJrrGEj5qEUnQNKibWJ2pFWaP6m1MFtW3L6ssR59UYpcil3WY5Mp3anPT4oT1AVUlwp4hiJzOGV+L7VMGMadks01P+K+T+80aMafgF5rCZb7AUOMi4R2Ylb7iwFQZ2N3Q+lva6HzPig7G3V8w7G8rOq2kG9GSqbcwmWIOmyIx2B5r43bc/fakypcXuja058BWSQgCtk2u+7p0zu7j6ENE5xdZMkQJOYcFG/fF3qsRbFRZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxwKXirQ0wIzvuPPTty9RcnLY6JbdxtsWl4NZUrOtAk=;
 b=cJMXw0K7U6zMBQA+atbT92J49yigUz6QEnEk88g5p3GYw7txAIDqrG2Qw/5lvA6mhyM5Nnx5GySUoWalc4Kpw4OTcWzHV+NwbnxQhKKjdQyjdu8urkkUaguZUgdiqWhcAPTsM0wQBtYg8XTlUcQNVnutJL6EDKci54xvkB8kPS0eNQskZo8w5CP1ZPOSmsEss8ngfaQZ6Z/I8lMzNtUete/GwSWm6LO5kVWlCjataArrYEWdtZpAe2vLk7gP7bGjJz9t5lPwrlvw0piTTeSfGKjsVd/Vakmc8dOKq31q7g4jCWRK7+AINWcYD3VuLTsMrH+P2M3f6Bu8kXdJk30dSA==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR1PPFE895A10B6.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18::fa6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 14:31:27 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 14:31:26 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Thread-Topic: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Thread-Index: AQHb8XjGNSzfw0LPWUy8flLtSCneZ7QxIDwAgAG8biCAAETjAIABtrUg
Date: Wed, 16 Jul 2025 14:31:26 +0000
Message-ID:
 <FR2PPF4571F02BCA9042E1EA1B8FAD5116A8C56A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-1-bf76d8142ef2@tdk.com>
 <65d7009e-dc4a-44b4-88fe-b5c7e1ecdfc1@kernel.org>
 <FR2PPF4571F02BCBA3AC546A6256C7F95B98C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <986dfe45-9d1a-4128-9e1a-d2acef15ba54@kernel.org>
In-Reply-To: <986dfe45-9d1a-4128-9e1a-d2acef15ba54@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR1PPFE895A10B6:EE_
x-ms-office365-filtering-correlation-id: f9292bd9-abb1-4667-b7a2-08ddc4757275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S05Pd0JiOGcwaGNYcm9ZRFNoekk5U0tkbWM0bFhNVWhYdnFjNWRqdkhualdy?=
 =?utf-8?B?QmprTW9Ebm1BeXh3Q0s2d3F0UUh0c0pucnE0NVJYK0FzYk8wRUNZaDh1a3hZ?=
 =?utf-8?B?d1laTUt4SVpLL0RJOXE3bnhIQzBIZ2dOSStReWM1Q0J4ajhwRFdtS3EzUmpM?=
 =?utf-8?B?Wk9RRm9vVU5KbElzQUFPOGZCNWRVWkVSOHBwazYyUkEwaTBqcDB1TVV6QjdY?=
 =?utf-8?B?MDZWaWRNb0xZZ1AyNGw4dmU0bml2K2xlZ3dXR2lTOHFqK2lub1ZoYjBaeFJ3?=
 =?utf-8?B?aHp0V09oaUpyTW1NVGtMdnBDUS9yRDlXZUVGa3ZETklFV2ZCWENwbWVtZFE0?=
 =?utf-8?B?bno5YlRFeWtKZXdUajNQS25HcHZqMU9seVRoc2NvRkhZcitoTmVtd3VVK0R0?=
 =?utf-8?B?bDJBb0ZTS1VwZWNYVGtrd2p5ZGN0NmkvRkEwa2cxU2pDYzlNdnpQNy94SWR0?=
 =?utf-8?B?SllmNXBXdTZKOG82eDByQ245cDJXYVR3aHlNVm53dEc5bW1taE5LVXB0QVdp?=
 =?utf-8?B?RDNtTUNTb0tBdTdsWVNNSCtrWmhkU3ZFMDhNT3ZLY1BGSW00ZXhsQ0F5ZU9s?=
 =?utf-8?B?MVd2clhrcG8xakN6L0R1SDB3c1oycjIyT1pqZDBaNFJJTG5OVEg0UGM3dGUy?=
 =?utf-8?B?NW1wZ0ZCenpXbDJpY1ptV2hVdUZmWk1QVTlwK2xpeklzWGpQRUFUcWNPWldH?=
 =?utf-8?B?Ym9OT3F2VE5zcHdxQklQQ0k5MFhXblF1WHpNMUd0RXB3UzFqZ3hKL3FjY2Y1?=
 =?utf-8?B?VkcreW1RcXh1dFM5RGhTQlFCclM0dC9lQmdGaTU3YmZjazlMNHVFRTR6Tndk?=
 =?utf-8?B?NDVWUElycnBsRkhrMDh0R0YzY21pZUFjNDRLWUhRb3IydU1SM2c2SXNhc2w0?=
 =?utf-8?B?S0dmcG42THlLQ1UvaExZMVdHaVBBZVpWRjBybjkvTXNhbWpFNWNnVGhGZEF5?=
 =?utf-8?B?b3FYeEpnbDdocUNTTnAxb21pTXNNbTNsdUpsVGdCTVMwME1tTjNaN0ZFbXl3?=
 =?utf-8?B?eDNnTVZBRi9udys0Q3lwTnd6Tk9KU291TG1COVNyaVh1MGQ5ZXlpUkdVRitH?=
 =?utf-8?B?NWFWQWVwYWFUb1RZcnIwMmxMdUp0OVRqcC9PRExZZHpsSlE5d3F0c202WitQ?=
 =?utf-8?B?MWFma3VjUmlSYy84eFMxZllXUmhmRDZ1TE8zNlFPdGpwODZVc2FvQnVlZHFC?=
 =?utf-8?B?N3RkMjcrMEZEMzN4VjN3ZGREQ1FrK0JLV09GZVRVZzI4VytWN2ZjcDRBQ0FH?=
 =?utf-8?B?MENwbWloMDZZK0tlVHRBQkpsREREWFgyL3g4MmRJaitEWFdsWDYvODZMVThk?=
 =?utf-8?B?Y0RzMkVpVUhoVUtidVJQWmEzWmcwM0tZUG9MaUdMMzBHdjhuUGwxWVZ3eXdQ?=
 =?utf-8?B?S2JzVlVjVFF6Ny95a29RTFFtUjc5YzRmSGsvTlZ2ck82ZnhndXFDUXl5UW02?=
 =?utf-8?B?L2RMZ1kvZkI2dEs4cjE3UFptVndFbTR2SWhhdHQ1WlZiaE1CSi9ITHVIV3BH?=
 =?utf-8?B?RFE5c0VvNnY3LzJGdkwycVJBMnU0cDg4a1doVjF3K3crdjlvY1JydkVHQVh0?=
 =?utf-8?B?elUvYWc5YkJOM3YwZjA4UTE3dEIwaVJnem42Z0psUk9YQkJ1K0k0V2JSVUp1?=
 =?utf-8?B?Z0tueTBkN1B4Z0RQOWd5bVZrQjJDZWR3cFE2OEVHSHdwNVZQYnlsYlRCd2JI?=
 =?utf-8?B?T1dLb0xmVHloRGFqQ3JQRU5GK1BlbG1PTHd3cC9CblIzdUZETUxyVHNVTW5D?=
 =?utf-8?B?anVDWmJXSzBlRjhYNVV2VDBvOVZyWmhFOXBoR3RXN3hLNzRvd3RVb2FJZG1m?=
 =?utf-8?B?KzVjUFhvSkhNaHpDMFZPbVg3QTQ0YUcyRGIvK0hIZlVpRXM4OXo2K2pYYVVs?=
 =?utf-8?B?WCtzbjc2MURoWnJQSUZ1MWthR0pVMm5RODh1bXlBZTkvakxsZ25hWXg0cmZW?=
 =?utf-8?Q?CyEH04sPH/lRSL7i/HEiDj0BYWYDZsON?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NE5CS2RFTGJjbWhUak84UWlrYTN2MEc0UVhpVFIrUE1HNTQvcVhkRUVPNkk0?=
 =?utf-8?B?QWxJYnc2NitibzlNd296V3FUS1NUakVmM1hMY2ZMS09IMjJvWHV3RlI4a0FE?=
 =?utf-8?B?WUVBSzk3VkpITlMrUTdCWjUwY1JoRldTU2g3TkdWLytPMTdYR0xlbU1MM2Jv?=
 =?utf-8?B?K0xBY3R4Tmtqay85cVVrSUJTOTNPcGtJYjNFUFZuUWllSGVkcnR4VkxabGwy?=
 =?utf-8?B?UmhxS1BCVC9CZ2I2VytPWEJYWk1Rd0ZwTDRDcTNSbUkzSTJVaFVoSmhIb2dQ?=
 =?utf-8?B?Q2w4LytNdVI4K1hHSW4xTk1NZThSUHo2TU5jM21xM2xnK1ZBM2MxMGk5RzNB?=
 =?utf-8?B?SWhGS0JtN2trYnRoVTlrbmJqRXlVQVBHYkZhN05neUppVGswK2U2UmYzOEpG?=
 =?utf-8?B?M3VITUN2OW5sdlRmOFNwZEY1enhxSDEvRXNBdW9UZzBacCt5MVR4WC83aGdl?=
 =?utf-8?B?Qmw0WWMzVmdkelNhUXZUOEVGL256dUw3TmRYVTB0R0ZqVWdHZzYwbUtHc09T?=
 =?utf-8?B?dGxpTHk5dzhncTlHaVZFUWw4NXBXY2txeUk4cHJyblJhY0xNNE4xM1RFcjVF?=
 =?utf-8?B?endtc1puMi9DYW9oWktGV1hkd1NUaXp4dkQyR3lYczRRTnNqZDdmN0NYcnFQ?=
 =?utf-8?B?OXBkRFRWRU1WUlFGb1VCSjVyclVaLzV4Z21QQ1RDZ0toWUtZUmF2clk3a21i?=
 =?utf-8?B?V1JSSE5vNXNZVFA5Y0t5bnlGeHNLeE54Z2VINWd6bVova3BUamdVM01lYm95?=
 =?utf-8?B?ekxudXJoaDcxcnBmWG85SElYRWRxWVF2U0l2SWhNMzNIejcrUi9JSXZQbzJm?=
 =?utf-8?B?WnBLenVBdEwvcGJCbUtTby95Wm5IRnlLTmVoQmtCK0xDN1pSaTVJeTF5blNV?=
 =?utf-8?B?WC9TTW5EYnRBZnVRN2hqMHBIcnVpNkVxVkhQbXdTTkFiLy82ai9UT2YzZkRP?=
 =?utf-8?B?dk1raHljZTltMGZ6QWNCNE9xOWhwbU9xUFRUR1cweEpEREtqWkdWTjVwU2xm?=
 =?utf-8?B?eHNxSDhNZVFRYjVZNEwzZk9jRVVoTGhRd3BNKzB3a1ZvYm01Q2hkTlVPeEQ4?=
 =?utf-8?B?VUt2SUV3OUcyN2hLbjVGbThHVXJOTmg0NzBPMkc3VFdQeVpBS05RV0VIRC9m?=
 =?utf-8?B?SWU2T0ZXY0Yybm04TG9MbEQwamYxQ2VyUFVNdmloeitBUXQyMTBmOTE2amZR?=
 =?utf-8?B?dnRIWWYzelB0b0FvYzYxcUNSc2lURmlzNnBFaVZjR3dGcE8zRkFBemFNWUVH?=
 =?utf-8?B?RGdrM1hhN3M4d1BoS3Z1OHkwY0dVcEhQWjhBUWhDd2kvd2ZoZFpLZXI5bnFD?=
 =?utf-8?B?QzlWazd0eURHcW1QUEkrd2xxUDdxc0lIVXZTQS9ZZzhRajBSTjNESlk0b0lu?=
 =?utf-8?B?N1hZZk05b0dSeXdXdy94QkZucExrTTNwMjFNbC9yYUtiLzNXQ2lnbXRGbzd0?=
 =?utf-8?B?bFhoYitIVTFyaEV4RmJPN3pZcnNraHZBaTdzSlMzNFM3eWtYaEZrQU55Wlg3?=
 =?utf-8?B?NjBReFAvVEVGaGswWWt1NGdaQlI4R1Q4dGtsV01vK3ZPS3M3MDNObHFSMTJ1?=
 =?utf-8?B?aitmUFZ2K1kvUUNWTWYweU5CT29rQ2FxdHB3OFE2T0xTZHBBM0xlekFJZ0pz?=
 =?utf-8?B?MFR1b0EwbWtIQVVyRVZlM2t4UnZnc0NQTXRoZkd3L2tnblliV3hpbE42RlFx?=
 =?utf-8?B?by9VeXlVczU2ODQ5eGQyVERHMDVyc1pCNUtQYmFzbklNWHYzNjJRbFBLZm5W?=
 =?utf-8?B?TWZacWtYZWo4Szdab1BhTW54UVQ3YUZPL0Y3dWFFdERiWFJKN3F6c3ZyK2lK?=
 =?utf-8?B?NUFEMzhWZnI2dVNqZEozNFBvS3RkZkx0TjNlYjcrQlZBUDE3UFJIUnNYMUZI?=
 =?utf-8?B?VEZyeDdOS0ZBVXUzaWt6NEE3eXB4TUgvSDNXa3pIejFBTmZ1RXhrc1NyLzls?=
 =?utf-8?B?WVNZekNjeHRhY3ZMMkpwWDVTK0dPcHhOaTRqSGQzazNSRjd0bkJzVVpnRmxk?=
 =?utf-8?B?eERZVFJNeWZDQzdwNi9sRVBVQmxlR25ZalpueVNOTnY1SDJMNCt6ME8wVzE1?=
 =?utf-8?B?MTQzSVkzbzJNV3NtWDNGNEFXMTBTc2U4NU1TUEp4QzlSMGt5Q3RzRE1IT0N5?=
 =?utf-8?Q?fKHuAwJHXKqA1eLCSYxLf6MtI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9292bd9-abb1-4667-b7a2-08ddc4757275
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 14:31:26.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCodx967NlX65565K2KP4SGWZ8B/xBQK7hQTlVuBh5tvhplTEFE1ZB+FN6jrGL+1qj/VWfFo3+TCYh2rnbo5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR1PPFE895A10B6
X-Proofpoint-GUID: 0J7qZM1IyE-P8OYsi_qbzUOIlT86m4tX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzMSBTYWx0ZWRfX0F99frO073br
 Wa4PujpLE3gp/KfA6kvAiqWXRJnXSnX6QF+JxPCmcYeAAcSsuoPzvQI/+bnrsLYH+OTBfb0Z+lN
 L/m2PgEnRadmWTTL0joz/Dblaaj1y5lg1lTlyzMsqu0Ps78zry7rpyFI8oeR1VWx87pkl3Vu5kU
 0jwZBKZoBdnwQWkezG508T2I2G2f0J4kTT+q7MJr3AvUVO2ocAXRSX6+ZuKqAFUs4Ada3vEqu9X
 5D6up8u5QReFb6mVQWqPfeoQ4wbZ5EghSJPrsnH6GPaUhSstFpguJwWDk7c2dIy5hbZHXONeIMq
 CHxMsA8dm9AkFGtnOGnwGG+EfpRccIt4gfsbCyffBLj8wqW9UTQtYPJ9NQCohILqve5lKIbYcxt
 nEVgjY0NbnLb/SzA0lUrKS0EPUe45ALMb63fY1tIiNKWwnn9Qj6dy50PHgz6vi4s+DadAeYq
X-Authority-Analysis: v=2.4 cv=QLxoRhLL c=1 sm=1 tr=0 ts=6877b7cb cx=c_pps
 a=S9uFRJX110uq3YNHEk4XXw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=KKAkSRfTAAAA:8 a=UXIAUNObAAAA:8 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=Yzs0EwRJJro4QrnXY88A:9 a=QEXdDO2ut3YA:10
 a=bFq2RbqkfqsA:10 a=cvBusfyB2V15izCimMoJ:22 a=a1s67YnXd6TbAZZNj1wK:22
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 0J7qZM1IyE-P8OYsi_qbzUOIlT86m4tX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160131

Pg0KPg0KPkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4gDQo+U2Vu
dDogVHVlc2RheSwgSnVseSAxNSwgMjAyNSAyOjE2IFBNDQo+VG86IFJlbWkgQnVpc3NvbiA8UmVt
aS5CdWlzc29uQHRkay5jb20+OyBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsg
RGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6EgPG51bm8uc2FA
YW5hbG9nLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVs
Lm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz4NCj5DYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvOF0gZHQtYmluZGlu
Z3M6IGlpbzogaW11OiBBZGQgaW52X2ljbTQ1NjAwDQo+DQo+T24gMTUvMDcvMjAyNSAxMDozNSwg
UmVtaSBCdWlzc29uIHdyb3RlOg0KPj4+PiArICBkcml2ZS1vcGVuLWRyYWluOg0KPj4+PiArICAg
IHR5cGU6IGJvb2xlYW4NCj4+Pj4gKw0KPj4+PiArICB2ZGQtc3VwcGx5Og0KPj4+PiArICAgIGRl
c2NyaXB0aW9uOiBSZWd1bGF0b3IgdGhhdCBwcm92aWRlcyBwb3dlciB0byB0aGUgc2Vuc29yDQo+
Pj4+ICsNCj4+Pj4gKyAgdmRkaW8tc3VwcGx5Og0KPj4+PiArICAgIGRlc2NyaXB0aW9uOiBSZWd1
bGF0b3IgdGhhdCBwcm92aWRlcyBwb3dlciB0byB0aGUgYnVzDQo+Pj4+ICsNCj4+Pj4gKyAgbW91
bnQtbWF0cml4Og0KPj4+PiArICAgIGRlc2NyaXB0aW9uOiBhbiBvcHRpb25hbCAzeDMgbW91bnRp
bmcgcm90YXRpb24gbWF0cml4DQo+Pj4+ICsNCj4+Pj4gK3JlcXVpcmVkOg0KPj4+PiArICAtIGNv
bXBhdGlibGUNCj4+Pj4gKyAgLSByZWcNCj4+Pj4gKyAgLSBpbnRlcnJ1cHRzDQo+Pj4+ICsgIC0g
aW50ZXJydXB0LW5hbWVzDQo+Pj4NCj4+PiBNaXNzaW5nIHN1cHBsaWVzDQo+PiBBcmUgc3VwcGxp
ZXMgYWx3YXlzIHJlcXVpcmVkID8NCj4+IFRoZXkgYXJlIG5vdCBwcmVzZW50IGZvciBpbnZlbnNl
bnNlLGljbTQyNjAwMCBub3IgZm9yIHN0LGxzbTZkc3guDQo+DQo+RGVwZW5kcyBvbiB0aGUgaGFy
ZHdhcmUuLi4gV2hhdCBkb2VzIGRhdGFzaGVldCBzYXk/IFdoaWNoIG9uZXMgYXJlIG9wdGlvbmFs
Pw0KPg0KPk90aGVyIGJpbmRpbmdzIGFyZSBub3QgZ29vZCBleGFtcGxlcyBpbiB0aGlzIHRvcGlj
LCBiZWNhdXNlIHBlb3BsZSB0ZW5kDQo+dG8gc2tpcCB0aGUgc3VwcGxpZXMsIHJldmlld2VycyBh
bmQgbWFpbnRhaW5lcnMgdGVuZCBub3QgdG8gYm90aGVyIHdpdGgNCj5uaXRwaWNraW5nIHRoaXMu
DQpVbmRlcnN0b29kLCBWREQgYW5kIFZERElPIGFyZSBhY3R1YWxseSBtYW5kYXRvcnkuDQpJJ2xs
IGFkZCB0aGVtLg0KPg0KPg0KPj4+DQo+Pj4+ICsNCj4+Pj4gK2FsbE9mOg0KPj4+PiArICAtICRy
ZWY6IC9zY2hlbWFzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sIw0KPj4+PiArDQo+Pj4+
ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+Pj4+ICsNCj4+Pj4gK2V4YW1wbGVzOg0K
Pj4+PiArICAtIHwNCj4+Pj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+
DQo+Pj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ly
cS5oPg0KPj4+PiArICAgIGkyYyB7DQo+Pj4+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KPj4+PiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+Pj4gKw0KPj4+PiArICAgICAg
ICBpY200NTYwNUA2OCB7DQo+Pj4NCj4+PiBJdCBkb2VzIG5vdCBsb29rIGxpa2UgeW91IHRlc3Rl
ZCB0aGUgRFRTIGFnYWluc3QgYmluZGluZ3MuIFBsZWFzZSBydW4NCj4+PiBgbWFrZSBkdGJzX2No
ZWNrIFc9MWAgKHNlZQ0KPj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93cml0
aW5nLXNjaGVtYS5yc3Qgb3INCj4+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly93d3cubGluYXJvLm9yZy9ibG9nL3RpcHMtYW5kLXRyaWNrcy1mb3ItdmFsaWRhdGluZy1kZXZp
Y2V0cmVlLXNvdXJjZXMtd2l0aC10aGUtZGV2aWNldHJlZS1zY2hlbWEvX187ISFGdHJodFBzV0Ro
WjZ0dyFEc2U2eklxZ1JtUThueHpkbXBDN1V1OTZXQlZ3TldicWxfNFduZlB3anVJU2JhdXY3R0dz
RE8yelNEVHE0VEV6U2ViMHM2ZmNibUZSJCU1QmxpbmFybyU1Qi4lNURvcmclNUQNCj4+PmZvciBp
bnN0cnVjdGlvbnMpLg0KPj4+IE1heWJlIHlvdSBuZWVkIHRvIHVwZGF0ZSB5b3VyIGR0c2NoZW1h
IGFuZCB5YW1sbGludC4gRG9uJ3QgcmVseSBvbg0KPj4+IGRpc3RybyBwYWNrYWdlcyBmb3IgZHRz
Y2hlbWEgYW5kIGJlIHN1cmUgeW91IGFyZSB1c2luZyB0aGUgbGF0ZXN0DQo+Pj4gcmVsZWFzZWQg
ZHRzY2hlbWEuDQo+Pj4NCj4+PiAoc2VlIGhvdyBvdGhlciBiaW5kaW5ncyBvciBEVFMgY2FsbCB0
aGlzIHR5cGUgb2YgZGV2aWNlKQ0KPj4+DQo+PiBJIHN1Y2Nlc3NmdWxseSByYW4gIm1ha2UgZHRf
YmluZGluZ19jaGVjayIgd2l0aCB1cC10by1kYXRlIHRlc3RpbmcgYnJhbmNoLg0KPj4gSSdsbCB0
cnkgZHRic19jaGVjayBhcyBzdWdnZXN0ZWQsIHRoYW5rcyENCj4NCj5JIGFtIHNvcnJ5LiBJIHRo
aW5rIEkgcGFzdGVkIHdyb25nIHRlbXBsYXRlIGZvciBhIGNvbW1vbiBpc3N1ZS4NCj4NCj5JIHdh
bnRlZCB0byBzYXk6IHlvdSBuZWVkIGdlbmVyaWMgbmFtZSwgaW11IGV0Yy4gVGhhdCdzIHRoZSB0
ZW1wbGF0ZQ0KPnJlc3BvbnNlIHNob3VsZCBiZSB0aGVyZToNCj4NCj5Ob2RlIG5hbWVzIHNob3Vs
ZCBiZSBnZW5lcmljLiBTZWUgYWxzbyBhbiBleHBsYW5hdGlvbiBhbmQgbGlzdCBvZg0KPmV4YW1w
bGVzIChub3QgZXhoYXVzdGl2ZSkgaW4gRFQgc3BlY2lmaWNhdGlvbjoNCj5odHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRpb24ucmVhZHRoZWRv
Y3MuaW8vZW4vbGF0ZXN0L2NoYXB0ZXIyLWRldmljZXRyZWUtYmFzaWNzLmh0bWwqZ2VuZXJpYy1u
YW1lcy1yZWNvbW1lbmRhdGlvbl9fO0l3ISFGdHJodFBzV0RoWjZ0dyFETlplUDBhN2ZFZXg4dDZq
UlU5aEhEZkpMM2hYYmlvZFBzQjQwYmpld3VfM251VWdmeDZLeVc2NW9EUktKRGY5aTdXZnNFejZM
d05hJFtkZXZpY2V0cmVlLXNwZWNpZmljYXRpb25bLl1yZWFkdGhlZG9jc1suXWlvXQ0KPg0KPihh
bmQgSSB1c2UgdGVtcGxhdGVzIHRvIHN0cmVhbWxpbmUgbXkgcmV2aWV3LiBFdmVuIHRob3VnaCB0
aGV5IG1pZ2h0DQo+ZmVlbCBhIGJpdCByb2JvdGljLCB3aXRob3V0IHBlcnNvbmFsIHRvdWNoIG9y
IHBhdHJvbml6aW5nLCB0aGF0J3Mgbm90DQo+dGhlaXIgaW50ZW50aW9uLCBJIGp1c3Qgb3B0aW1p
emUgbXkgcHJvY2VzcykNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24sIEknbGwgdXNlICJp
bXUiIHRoZW4uDQpUZW1wbGF0ZXMgYXJlIHRvdGFsbHkgb2sgOikNCj4NCj4NCj5CZXN0IHJlZ2Fy
ZHMsDQo+S3J6eXN6dG9mDQo+DQo=

