Return-Path: <linux-iio+bounces-9368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D859711CB
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D93B22DDF
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 08:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2E1B14F3;
	Mon,  9 Sep 2024 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LACesbrH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406A1AF4DB;
	Mon,  9 Sep 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870145; cv=fail; b=DD0503o3J2VseL5M5zzDLTJphlxiGVaasi+Xv3zeABeLk9uQMuadiC11UmJfXE9Ca9r4zLIXFH+Y4lsodcSxjX2Ul+RS/gRWtfFVCWh3GwNQhn6NPcWxmEcZoaH2kClkxqC6IkliZLgaaA8lRGo8j7IS4Y0jee8pZ91MTM93lAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870145; c=relaxed/simple;
	bh=jfTxhYriM377uthV49CjYQm0xzwAAn2dBCNtFUrBlYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UtelZLc2m1nepu5A4MrdluU4W0LH5CO6jOSUL6QhvYtOzT3pQzQSfvXYyfDwspJd1Qq5g4QXQowbAKs6Mf7PhjgMRgfwtonYKx6yUZIzimwaKaaCiQjJWS4KqCLDM6ez4WWCgsFJVDkEuiNgoHcThHnIzX6Kt0wtx1tbc31KJuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LACesbrH; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489693Di029638;
	Mon, 9 Sep 2024 04:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jfTxh
	YriM377uthV49CjYQm0xzwAAn2dBCNtFUrBlYc=; b=LACesbrHvroJ7Xcl/yxgm
	Un/GdDAMgnh7jIcMSu+AWhk7f4jBBrbt359Ali56PVlWUWc1pnAY2VOhpJOPL5KR
	G3V1ZoShbCfq8+Gz2omrVCHDvwFMHz7oWuiDi13hUHZxm9VfV0EXSv4ZYqCf+rtY
	zZ2xngdWVm65nG8vp/BjKiSRgNHyibkGfcTY53nsUo8SdKq1iJ8e6NzNeBDsUHqf
	v9S4tKq7x5Jh/g3kRWRaVP/DXpD+hxz+hoWOHhCU/FYgsBWK2fcKiWcteqs4VYZA
	wbVyosipZjl8j4ZaWpfU9NBgP+CFv+WM9cdPkoowwTUhKV4kteYvBAGoREM2LH2r
	g==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41gybputef-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 04:22:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br7skc1GW5/frmZhWD5Tf5nG8cZF9BcbBLCtVJivCut7isYg1FtZV1BX7HSKxXrE7F/ErAZiCJgWzTiZNk/AXE2QwKhHEA7FhBB2PMNk2imEaaNprytxuLEcKwVfwGa5WYVblHfTybF9SzCTc1vqNTwvPzpFGPMm7XqD7XthBavmtuwA0MmwwCnQLm71zdIFXf4lsMD9lUnTvQNOdyF6JJERUiy4WHo6ALB9VBX8EKYQ/6r/5pN1h8QdloGaXg4ohh1XcwEPtUHXE9i031qHHM7IR2XehpBKzl5r+RWLYPjj7hN8KesjTWXJqGDWjDAtt947BgWllEhNbMLd594I9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfTxhYriM377uthV49CjYQm0xzwAAn2dBCNtFUrBlYc=;
 b=Vx4KyX1MVqO39A3/cUcRwRRKVO7SOIE3KF2nJKc+4GxmpqUGS3rkzWj4IsdxRw52UW04wrluvT6FrV4ZSH6LSlSReoUeFDmhMGLV6ZurKaVIf0N5E9C3Pyb4yiaP4mgNQyCoTNB2DPudWds9JbOqtIn9M8zjs4RQuTF1yC5xPhf0A6Ce4d12PxpJ5UUUxHHI5oCdr6gRdccGYMf4zmnM26hiZanNyJcikzKlIZ/w1JDOm15fG6oK85E3JjvjZw6SI9nOCEZiePFILq7zvhjDoQkOgUaX/DrO5/v83CL6/0hSSx6qHQo9uVNR4u2cnRY4Ykcj4NZPqU5Aez4aaB6dfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by BN8PR03MB5091.namprd03.prod.outlook.com (2603:10b6:408:d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 08:22:04 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%4]) with mapi id 15.20.7897.021; Mon, 9 Sep 2024
 08:22:03 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Topic: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Index: AQHbAUlxuvHFtAhgrUCJdsSVU6qZdrJPEDfw
Date: Mon, 9 Sep 2024 08:22:03 +0000
Message-ID:
 <SJ0PR03MB62241B8DAC3C45C192819ED391992@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
	<20240904023040.23352-3-Mariel.Tinaco@analog.com>
 <20240907181449.1453bd41@jic23-huawei>
In-Reply-To: <20240907181449.1453bd41@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzEwYVc1aFkyOWNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MDVOVGN3T0RjMllpMDJaVGcwTFRFeFpXWXRPR016?=
 =?utf-8?B?TWkwM05EQTBaakUxTWpOalpUaGNZVzFsTFhSbGMzUmNPVFUzTURnM05tUXRO?=
 =?utf-8?B?bVU0TkMweE1XVm1MVGhqTXpJdE56UXdOR1l4TlRJelkyVTRZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJeE5URXpNaUlnZEQwaU1UTXpOekF6TkRNM01qQTVOalUzTnpn?=
 =?utf-8?B?MUlpQm9QU0ozTTBGWFRVRTNhVFo0WTJwbk1sWTFVa2xzV0dSYU4wZEpSbEU5?=
 =?utf-8?B?SWlCcFpEMGlJaUJpYkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNT?=
 =?utf-8?B?RlV4VWxOU1ZVWk9RMmRWUVVGRVowUkJRVU0xV1ZOR1dXdFJUR0pCWlZWQmFE?=
 =?utf-8?B?RkNLMjVGUjBvMVVVTklWVWcyWTFGWmEwUkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlNFRkJRVUZFWVVGUlFVRlRaMGxCUVU4MFFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUlVGQlVVRkNRVUZCUVROTWFGTm1aMEZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVbzBRVUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFX?=
 =?utf-8?B?Tm5RbXhCUmpoQlkwRkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21k?=
 =?utf-8?B?Q2FFRkhkMEZqZDBKc1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpz?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVdkQlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RD?=
 =?utf-8?B?YkVGSFRVRmtVVUo1UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdR?=
 =?utf-8?B?VWhOUVZoM1FqQkJSMnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlVVRkJRVUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFV?=
 =?utf-8?B?ZHJRVmgzUW5wQlIxVkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5?=
 =?utf-8?B?QldsRkNha0ZJVVVGamQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJUelJC?=
 =?utf-8?B?UVVGQlFVRkJRVUZEUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUVVGQlowRkJR?=
 =?utf-8?B?VUZCUVVGQlFYcG5RVUZCUVUxQlFVRkNUMEZCUVVGQlFVRkJRVWRGUVZwQlFu?=
 =?utf-8?Q?BBRjhB?=
x-dg-rorf: true
x-dg-refone:
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|BN8PR03MB5091:EE_
x-ms-office365-filtering-correlation-id: 3e615643-d835-4461-7ae6-08dcd0a87c4d
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eU8xeUVScVppaGtVZ2tLS1VrL1BxaGxjeksvdHVORU1ITEJwZTNDajNKUEMw?=
 =?utf-8?B?b2RNRTRSWFNZcjhJcUdrS3ozVnhWNEVwRGJuR3B6YnczdU44M0RYOG0zT1dE?=
 =?utf-8?B?QjVFNzQwWklaUUovRFNMa0RYejRPQjJGNFVaRjNsSldGZ0FGWXFCVnV0bVRB?=
 =?utf-8?B?cStHQ3BBMTE1T3FBL2J2NXNidnRNYWJ1c3VWOS9UdlJFTVltNnZSWkttV2JN?=
 =?utf-8?B?ZVp0R3JBdzJhNFQ1bHZIaUh2MVVxR0FFclBraTBZVE9DOG1XOU04WSs0TGRM?=
 =?utf-8?B?bWRTTTR3amVYME96NGNxV3U3c2RPQmNJZXdoNWYraEJDQlJOM2lvYTgxeUU3?=
 =?utf-8?B?VGsyYnJHL09Lcm0rM0QzcVpsOVVia01kNitRNnVyaVM2SjJQYzFnUTVCUTBp?=
 =?utf-8?B?THd5MHRTdGhRM3pYMnBTaHlhdjNVK0hoZDhnNGhsNTJTeGh2SEY1cFFuQ2Rl?=
 =?utf-8?B?Wm5EbVovekR5OVlYK3NBbjBObm9WaWdZRG5TQ3BmT3NIcTFDeDhzTlpoK1V0?=
 =?utf-8?B?UHp4bmhRUHMrV0M4UFZEU1dZREtaY0MzZTRZY2Qvcnlua2JaS0lVWTNiK1RW?=
 =?utf-8?B?OWxHVjEvN2dRdlE1L0JiMUZHeWZwRm9obitHZlAzYk03VVBOamR6M1Vock5X?=
 =?utf-8?B?RUszeE5UNVF2WmdvSzJQakxENU9QenZWN0dpSzR0TmlLRjIydGhkSW1RMnlt?=
 =?utf-8?B?ejVGV2c3NkVObzBaalcwelFGOGhTOXdreFpVS0g2Z0RDN3R6WFRvYWN0UjBh?=
 =?utf-8?B?YzN4bUFsWjhESUNsRHF0TmF2a3FGT1dmeTFvb2g1YndPYUFjSWFxYWY0a1pF?=
 =?utf-8?B?YjZYT3NPQ0czOVJvTGI5QUw1RFA0NEJyZGRTSk5idXhIMDMveDFoVWtDc0JQ?=
 =?utf-8?B?R1UwL0NoMlljVVNqZFlzWlFOU0tlU1dLbEVEMks1Mmdla0ttNUcwemtORFFp?=
 =?utf-8?B?eXlhRUpQenZLZ3p6cHk5bWVMamo2emdtTDA1ZC85aEVUeHlPM0FucXFMTDJY?=
 =?utf-8?B?NmlpbEdhRzZmK29hSGpkNWg2UzJVQy9lK3NLZitMMU53S2JjQzVCTU03SmNK?=
 =?utf-8?B?dVB6VHFjM3NrYUxRZWtQamVIVW1ZUHdIVks3QTNSV1BPdDV3b3J5VXd6TTdQ?=
 =?utf-8?B?UVJjRFJVazFMNGpKb3U4ZktnL3R3cDVvUkZSSVR2SG1EbXFkRXBQNGlydk9N?=
 =?utf-8?B?dWdrVEhJQzRMQlB4Z1VBQ0R2TmE0R0RPdW9MSytjSHhLVTFpOVJBTUcrOThu?=
 =?utf-8?B?bUIva3NyVWkxZjFYcFlmUVB3OGxGZnhKdXRucTd5c3JrcXQ2UEFYTGdRdzBq?=
 =?utf-8?B?c0JjcU4rYS96VzMvOTluUkVlRnhjd2Uvc1Y3cUdTMUlSdUtrUkNndjlzdWFG?=
 =?utf-8?B?OFdIdVk3MlExUGE1WlhaMkI2N2hjT1ZybWQvUGxKbi9mRnlxZkxvM29jZ1NB?=
 =?utf-8?B?cjEwQ0dXaU0zVElRQVZ5U2lTZXQwNmQweVowVEdLakJleEpXc0hubWlDT0hR?=
 =?utf-8?B?SmNvUndmVm04aGhMRFlPcXFYUUxXV291Zk5YYUJrUTRFZEV5WnVwZHI2aXFr?=
 =?utf-8?B?cHpxbWw1VUptSWhZS1FYMzk4bDMrVWpJQk5lZjF2NFNJcHVJNWdDZy9HbmdC?=
 =?utf-8?B?aEh5Z2tDaW1hUEpWbEluM09aTXNQSWlwc0YvOVIxZ3NzRnBJSXBua21EbFNB?=
 =?utf-8?B?NGhZc1dIQnZoZWJOQkNPN2JYVTFaRCtzRHdkNmVhMzcwVkxEdU1WYjBncWxX?=
 =?utf-8?B?bXliS2EwUnZ4QnJDRWQ3TFU2cUxHdmM0a1BTQ0wra003eVhBL1FOdW9saWxC?=
 =?utf-8?B?TEMyZ2hEVitVaWVQbjNZbmFjeFpjblludzVYZ05wditUUFYzOWFoVHJ1SjdC?=
 =?utf-8?B?dGJHeU93dnkreStEd1NTbVd2bk9PeWdWbnp6ZTJlTGJXVkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmdmVThoTXlnRVRjZW50Wk9LalpnWmFTMlJpbUtTV3lSLzJqM3FURnZleldO?=
 =?utf-8?B?K2xOeGdwWURXNVZHR1ZNdjNNdHVoUFNXNkMvMHR4UGZPckh3TG1qS082NHJV?=
 =?utf-8?B?ZHR2VjBaNEZuSHc3ckYweHpBNytodzBwR0podDFoZFEwVDlUVmZDWS96RklW?=
 =?utf-8?B?dk1ESEx3bFNla0hVdTRzbm84ZTlZUmo5U3hPd2xTQW1xcGoyY1RUUGdpSjZG?=
 =?utf-8?B?aUc5TEJYaStoL0NkTE1tME9qY1M0WVIzMzFOd0crOUxIVE0yZS9JN3VJOHJk?=
 =?utf-8?B?bDdiNHZxcVNaVlJ1d2lmdnRYR2NrWmNLemNpSFpIS3N5NzdrSWtPSGtMKzE2?=
 =?utf-8?B?Y0UwblIzazIyS0lodkJPbDREY05PYW0rWUNSMWF6dWZ2aTZpNHpFN0IzUHlL?=
 =?utf-8?B?eWNiWG91Smg3Y0lXanVZMmRNa21qWkJuKzZqYkgxSzFWZGRsbDVTTFVKWlFO?=
 =?utf-8?B?Z0RkUVlrc2gzOVFHNGdYbWk1Sk84c0ZpU3g4VlFRVHV3WFlzWHJRZFZwc3pU?=
 =?utf-8?B?SC9rMG5lYS9PZ3B2dGpYeHhTNk9RQkhmRTVtdEt1OWZmQ0dDSjRLY05kZlpD?=
 =?utf-8?B?bzNRUU5QZ3g5VnV6VWRoMC9SbjIwbjRMQW1TNjZHNm5lQ0o2RVAreDNoVE5n?=
 =?utf-8?B?dy9ZVENUY2xyRVV4Vjg2Rkd0VVpvSzRCTlM3OW9tY2trOUtMNmxhUHkrRGM3?=
 =?utf-8?B?WTFwaG1BNTNkWkYydFFvVXJOQVVaMVNNRzVrWktWdVNkYVkyZFJDcURidUlB?=
 =?utf-8?B?dGwvaHhlUURaRDVPT3Q0VVNtcmlheHNPbEE5V3ZoTlcvTHlPZmtmczVrWndi?=
 =?utf-8?B?WDZIZXY1ZWFqU3E0Q3JVNncrcm10OVBsanRHOUkzOHBjc1VSZFhneGQ0OTNm?=
 =?utf-8?B?R01qYWJUa3A0eXEwUU5UaHpCcVZ6cGpkZWRFRXBVcUFCZDFkT1hPODhYb2dO?=
 =?utf-8?B?ZS91MmNiTXd5aFlldW82VDBZVFdYVEUzenNrRThsSjBzeXczVmRWeG0wMDBZ?=
 =?utf-8?B?aFNONGxFcytWbTZSUG8xcDNHZFdGUTJmbXZHb3Rjd21WNmR2cUhMdjJpWU5G?=
 =?utf-8?B?ZzZYcGxhWHBSRWdPa3RFcmtmY213SjdxVkFueEtLa3hSZTFVRUtWRWJlQ2Zz?=
 =?utf-8?B?SzI3TEZPcEl4NjZZR09RdDFmL2RWT0hkOHlNd2grT2Y5c3lKSnJJNXBJK1J1?=
 =?utf-8?B?NnUweklFVGlnVmZGdlNCaUVnSnJFWVgyQ3piTDNZZmlLZU1zclkrVFhONDVu?=
 =?utf-8?B?SHZzZHFiMGxjMlJMRFV6MkhlRFFMUk8zbkliMUx3bVpWdFE3TnF1eW1LOTRz?=
 =?utf-8?B?K1M2R0hRQkZPN3VNMXlPalBsb3NxUHNiZXB4NXptTDRva3pWL0NqQnN6dTdZ?=
 =?utf-8?B?R296dXNXcjF1VXphL0hZZFE3bGNOTzg1bndHQVg4WXRUUzZDU0QxcDJiYjJr?=
 =?utf-8?B?elFrbWlINHRVeE9TOVNDTHdGQTc3WHVOVFg2dDljcEV4QzJFaEFZQ1kyc0JC?=
 =?utf-8?B?QjNmK3VjcG4xZWJUWnRmQlZFQm5ubVZ5U0d5VGdlOS9BaEkzcjR5K0tKLyt3?=
 =?utf-8?B?TmpIeVRBeHhnMUhTMzVmRThBZ3B6ZXRoc3VOcG4yaGdUQ3dwQ1RBRmZUOGE3?=
 =?utf-8?B?RjdLN3ArQzV4RzJNNHBMbTJERjZZRVZLbWZnTGl0T2RBMjdqemkzaTFSQTNu?=
 =?utf-8?B?TkpMZzJsbkt2ZHBSbEdXM09aSEtBVHpHU2ZQRTYvblk1bnpNblBlNzJ3TkVZ?=
 =?utf-8?B?VU53NUJxUnJEbE5zd1pYU3NzcHIrd1NLTXk3cXlTY1lqalJMS2gyZkRRSGdz?=
 =?utf-8?B?bnFCSm9nVUIwWTYyVnlqWUhYVWFMSlB4WlIzVDN0TFY3a2lCcE9OK0lWQmU3?=
 =?utf-8?B?U09ocm4vNHlWSXppaUoybmxKdkFlN2RHK3crRzRpT3N0UTFkQWREK2xhR3F1?=
 =?utf-8?B?aXNNeW5QOURNU3FTcUVTbm5EZHNiaFN4VnBVV0lsNzVjbjJNdTIyMk9ZbGMw?=
 =?utf-8?B?OWc0UlRzY0p5SGczb1lLbTJsdjhZUno0QU91a0JKejZhMWkxUVZzWEl4NXNT?=
 =?utf-8?B?dm50bmN2Vk83N1JJcnhMRnF6cy8rRlhQa3Q0eThEcjI5V2ZoZnVtbUtneWhM?=
 =?utf-8?Q?UhwWxTLB0bGwoP55voA1ujVQ4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e615643-d835-4461-7ae6-08dcd0a87c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 08:22:03.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQLwey6wUreuz/qxG/eppDzd5ttzVbH2/Csim26k9aPWlwLmn4JTDraEW0e0X64FyqK/MaTmJFy+/z9PkktDn7s7vIck7R1BJm0skCEIxrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5091
X-Proofpoint-GUID: Vp7OYt5-r6uwF7rpcgZCMlvA0B4mbhNN
X-Proofpoint-ORIG-GUID: Vp7OYt5-r6uwF7rpcgZCMlvA0B4mbhNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090065

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgOCwgMjAyNCAx
OjE1IEFNDQo+IFRvOiBUaW5hY28sIE1hcmllbCA8TWFyaWVsLlRpbmFjb0BhbmFsb2cuY29tPg0K
PiBDYzogbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMYXJzLVBldGVyIENsYXVzZW4g
PGxhcnNAbWV0YWZvby5kZT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBIZW5uZXJpY2gsDQo+IE1pY2hh
ZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBDb25vciBEb29sZXkNCj4gPGNvbm9y
K2R0QGtlcm5lbC5vcmc+OyBNYXJjZWxvIFNjaG1pdHQgPG1hcmNlbG8uc2NobWl0dDFAZ21haWwu
Y29tPjsNCj4gRGltaXRyaSBGZWRyYXUgPGRpbWEuZmVkcmF1QGdtYWlsLmNvbT47IERhdmlkIExl
Y2huZXINCj4gPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhIDxub25hbWUubnVub0Bn
bWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBpaW86IGRhYzogc3VwcG9y
dCB0aGUgYWQ4NDYwIFdhdmVmb3JtIERBQw0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gV2Vk
LCA0IFNlcCAyMDI0IDEwOjMwOjQwICswODAwDQo+IE1hcmllbCBUaW5hY28gPE1hcmllbC5UaW5h
Y29AYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoZSBBRDg0NjAgaXMgYSDigJxiaXRzIGlu
LCBwb3dlciBvdXTigJ0gaGlnaCB2b2x0YWdlLCBoaWdoLXBvd2VyLA0KPiA+IGhpZ2gtc3BlZWQg
ZHJpdmVyIG9wdGltaXplZCBmb3IgbGFyZ2Ugb3V0cHV0IGN1cnJlbnQgKHVwIHRvIMKxMSBBKSBh
bmQNCj4gPiBoaWdoIHNsZXcgcmF0ZSAodXAgdG8gwrExODAwIFYvzrxzKSBhdCBoaWdoIHZvbHRh
Z2UgKHVwIHRvIMKxNDAgVikgaW50bw0KPiA+IGNhcGFjaXRpdmUgbG9hZHMuDQo+ID4NCj4gPiBB
IGRpZ2l0YWwgZW5naW5lIGltcGxlbWVudHMgdXNlci1jb25maWd1cmFibGUgZmVhdHVyZXM6IG1v
ZGVzIGZvcg0KPiA+IGRpZ2l0YWwgaW5wdXQsIHByb2dyYW1tYWJsZSBzdXBwbHkgY3VycmVudCwg
YW5kIGZhdWx0IG1vbml0b3JpbmcgYW5kDQo+ID4gcHJvZ3JhbW1hYmxlIHByb3RlY3Rpb24gc2V0
dGluZ3MgZm9yIG91dHB1dCBjdXJyZW50LCBvdXRwdXQgdm9sdGFnZSwNCj4gPiBhbmQganVuY3Rp
b24gdGVtcGVyYXR1cmUuIFRoZSBBRDg0NjAgb3BlcmF0ZXMgb24gaGlnaCB2b2x0YWdlIGR1YWwN
Cj4gPiBzdXBwbGllcyB1cCB0byDCsTU1IFYgYW5kIGEgc2luZ2xlIGxvdyB2b2x0YWdlIHN1cHBs
eSBvZiA1IFYuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpZWwgVGluYWNvIDxNYXJpZWwu
VGluYWNvQGFuYWxvZy5jb20+DQo+IEEgZmV3IGNvbW1lbnRzIGlubGluZS4NCj4gDQo+IEpvbmF0
aGFuDQo+IA0KPiANCj4gPiAgb2JqLSQoQ09ORklHX0FESV9BWElfREFDKSArPSBhZGktYXhpLWRh
Yy5vIGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvaWlvL2RhYy9hZDg0NjAuYyBiL2RyaXZlcnMv
aWlvL2RhYy9hZDg0NjAuYyBuZXcgZmlsZSBtb2RlDQo+ID4gMTAwNjQ0IGluZGV4IDAwMDAwMDAw
MDAwMC4uNjQyOGJmYWYwYmQ3DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMv
aWlvL2RhYy9hZDg0NjAuYw0KPiA+IEBAIC0wLDAgKzEsOTMyIEBADQo+ID4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKy8qDQo+ID4gKyAqIEFEODQ2MCBXYXZlZm9y
bSBnZW5lcmF0b3IgREFDIERyaXZlcg0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIw
MjQgQW5hbG9nIERldmljZXMsIEluYy4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8
bGludXgvYml0ZmllbGQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2NsZWFudXAuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGVidWdmcy5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2RtYWVu
Z2luZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvaWlvL2J1ZmZlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaWlvL2J1ZmZl
ci1kbWEuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lpby9idWZmZXItZG1hZW5naW5lLmg+ICNp
bmNsdWRlDQo+ID4gKzxsaW51eC9paW8vY29uc3VtZXIuaD4gI2luY2x1ZGUgPGxpbnV4L2lpby9l
dmVudHMuaD4gI2luY2x1ZGUNCj4gPiArPGxpbnV4L2lpby9paW8uaD4NCj4gDQo+IEdpdmVuIHRo
ZXJlIGFyZSBsb3RzIG9mIElJTyBzcGVjaWZpYyBpbmNsdWRlcywgcHJvYmFibHkgYSBjYXNlIHdo
ZXJlIHB1bGxpbmcNCj4gdGhlbSBvdXQgYXMgYSBzZXBhcmF0ZSBibG9jayBhZnRlciB0aGUgbWFp
biBpbmNsdWRlcyBtYWtlcyBzZW5zZS4NCj4gDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
bW9kX2RldmljZXRhYmxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPiAjaW5jbHVkZSA8bGludXgvc3Bp
L3NwaS5oPg0KPiA+DQo+IC4uLg0KPiANCj4gDQo+ID4gKw0KPiA+ICsJc3RhdGUgPSBpaW9fcHJp
dihpbmRpb19kZXYpOw0KPiA+ICsJbXV0ZXhfaW5pdCgmc3RhdGUtPmxvY2spOw0KPiANCj4gVHJp
dmlhbCBidXQgdGhlcmUgaXMgbm8gYSBkZXZtX211dGV4X2luaXQoKSB0aGF0IGRlYWxzIHdpdGgg
dGhlIG9ic2N1cmUgZGVidWcNCj4gY2FzZSB3aGVyZSBtdXRleCB1bmluaXQgbWFrZXMgc2Vuc2Uu
IE1pZ2h0IGFzIHdlbGwgdXNlIGl0IGhlcmUuDQo+IA0KPiA+ICsNCj4gPiArCWluZGlvX2Rldi0+
bmFtZSA9ICJhZDg0NjAiOw0KPiA+ICsJaW5kaW9fZGV2LT5pbmZvID0gJmFkODQ2MF9pbmZvOw0K
PiA+ICsNCj4gPiArCXN0YXRlLT5zcGkgPSBzcGk7DQo+ID4gKwlkZXYgPSAmc3BpLT5kZXY7DQo+
ID4gKw0KPiA+ICsJc3RhdGUtPnJlZ21hcCA9IGRldm1fcmVnbWFwX2luaXRfc3BpKHNwaSwNCj4g
JmFkODQ2MF9yZWdtYXBfY29uZmlnKTsNCj4gPiArCWlmIChJU19FUlIoc3RhdGUtPnJlZ21hcCkp
DQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKHN0YXRlLT5yZWdtYXAp
LA0KPiA+ICsJCQkJICAgICAiRmFpbGVkIHRvIGluaXRpYWxpemUgcmVnbWFwIik7DQo+ID4gKw0K
PiA+ICsJc3RhdGUtPnN5bmNfY2xrID0gZGV2bV9jbGtfZ2V0X2VuYWJsZWQoZGV2LCBOVUxMKTsN
Cj4gPiArCWlmIChJU19FUlIoc3RhdGUtPnN5bmNfY2xrKSkNCj4gPiArCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIFBUUl9FUlIoc3RhdGUtPnN5bmNfY2xrKSwNCj4gPiArCQkJCSAgICAgIkZh
aWxlZCB0byBnZXQgc3luYyBjbGtcbiIpOw0KPiA+ICsNCj4gPiArCXN0YXRlLT50bXBfYWRjX2No
YW5uZWwgPSBkZXZtX2lpb19jaGFubmVsX2dldChkZXYsICJhZDg0NjAtDQo+IHRtcCIpOw0KPiA+
ICsJaWYgKElTX0VSUl9PUl9OVUxMKHN0YXRlLT50bXBfYWRjX2NoYW5uZWwpKSB7DQo+ID4gKwkJ
aW5kaW9fZGV2LT5jaGFubmVscyA9IGFkODQ2MF9jaGFubmVsczsNCj4gPiArCQlpbmRpb19kZXYt
Pm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoYWQ4NDYwX2NoYW5uZWxzKTsNCj4gPiArCX0gZWxz
ZSB7DQo+ID4gKwkJaW5kaW9fZGV2LT5jaGFubmVscyA9IGFkODQ2MF9jaGFubmVsc193aXRoX3Rt
cF9hZGM7DQo+ID4gKwkJaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPQ0KPiBBUlJBWV9TSVpFKGFk
ODQ2MF9jaGFubmVsc193aXRoX3RtcF9hZGMpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gQWRkIGFuZCBl
bmFibGUgdGhlIHZhcmlvdXMgb3RoZXIgc3VwcGxpZXMuIFRoZXkgYXJlIHByb2JhYmx5IGFsd2F5
cyBvbiBpbg0KPiB3aGljaCBjYXNlIHRoZSByZWd1bGF0b3IgZnJhbWV3b3JrIHdpbGwgd29yayBp
dCdzIG1hZ2ljIHRvIGF2b2lkIHVzZSBoYXZpbmcgdG8NCj4gY2FyZSB0aGF0IHRoZXkgYXJlbid0
IGluIHRoZSBkdHMuDQoNCklmIHRoZSBvdGhlciBzdXBwbGllcyBhcmUgYWRkZWQsIGRvIHRoZXkg
bmVlZCB0byBiZSB0aWVkIHVwIGFzIHdlbGwgdG8gdGhlDQpQcml2YXRlIHN0cnVjdHVyZSBqdXN0
IGxpa2UgcmVmXzFwMnY/IE9yIGRvIEkganVzdCBhcHBseSB0aGUgDQpkZXZtX3JlZ3VsYXRvcl9n
ZXRfZW5hYmxlX3JlYWRfdm9sdGFnZSB0byBpdD8NCg0KcmV0ID0gZGV2bV9yZWd1bGF0b3JfZ2V0
X2VuYWJsZV9yZWFkX3ZvbHRhZ2UoJmNsaWVudC0+ZGV2LCAidmRkIik7DQpJZiAocmV0IDwgMCAm
JiByZXQgIT0gLUVOT0RFVikNCglyZXR1cm4gZGV2X2Vycl9wcm9iZShsdGMyMzA5LT5kZXYsIHJl
dCwNCgkJCQkiZmFpbGVkIHRvIGdldCB2cmVmIHZvbHRhZ2VcbiIpOw0KDQo+IA0KPiA+ICsJcmV0
ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X2VuYWJsZV9yZWFkX3ZvbHRhZ2UoZGV2LCAicmVmaW9fMXAy
diIpOw0KPiA+ICsJaWYgKHJldCA9PSAtRU5PREVWKQ0KPiA+ICsJCXN0YXRlLT5yZWZpb18xcDJ2
X212ID0gMTIwMDsNCj4gPiArCWVsc2UgaWYgKHJldCA+PSAwKQ0KPiA+ICsJCXN0YXRlLT5yZWZp
b18xcDJ2X212ID0gcmV0IC8gMTAwMDsNCj4gPiArCWVsc2UNCj4gPiArCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBnZXQgcmVmZXJlbmNlDQo+ID4gK3ZvbHRhZ2Vc
biIpOw0KPiA+ICsNCj4gLi4uDQo+IA0KPiA+ICsJcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRf
dTMyX2FycmF5KGRldiwgImFkaSxyYW5nZS1taWNyb2FtcCIsDQo+ID4gKwkJCQkJICAgICB0bXAs
IEFSUkFZX1NJWkUodG1wKSk7DQo+ID4gKwlpZiAoIXJldCkgew0KPiA+ICsJCWlmIChpbl9yYW5n
ZSh0bXBbMV0sIDAsDQo+IEFEODQ2MF9BQlNfTUFYX09WRVJDVVJSRU5UX1VBKSkNCj4gPiArCQkJ
cmVnbWFwX3dyaXRlKHN0YXRlLT5yZWdtYXAsDQo+IEFEODQ2MF9DVFJMX1JFRygweDA4KSwNCj4g
PiArCQkJCSAgICAgRklFTERfUFJFUChBRDg0NjBfRkFVTFRfQVJNX01TSywgMSkNCj4gfA0KPiA+
ICsJCQkJICAgICBBRDg0NjBfQ1VSUkVOVF9MSU1JVF9DT05WKHRtcFsxXSkpOw0KPiANCj4gWW91
ciBiaW5kaW5nIGhhcyBhIGZpeGVkIHNldCBvZiB2YWx1ZXMuICBZZXQgdGhpcyBpcyBhbnl0aGlu
ZyBpbiByYW5nZS4NCj4gV2hpY2ggaXMgY29ycmVjdD8gIEJhc2VkIG9uIGRhdGFzaGVldCBJIHRo
aW5rIGl0IGlzIGZsZXhpYmxlIGJ1dCB0aGF0IHlvdSBoYXZlDQo+IGxpc3RlZCB0aGUgZXhhbXBs
ZSB2YWx1ZXMgaW5zdGVhZCBvZiB0aGUgbGltaXRzLg0KPiANCj4gDQo+ID4gKw0KPiA+ICsJCWlm
IChpbl9yYW5nZSh0bXBbMF0sIC1BRDg0NjBfQUJTX01BWF9PVkVSQ1VSUkVOVF9VQSwNCj4gMCkp
DQo+ID4gKwkJCXJlZ21hcF93cml0ZShzdGF0ZS0+cmVnbWFwLA0KPiBBRDg0NjBfQ1RSTF9SRUco
MHgwOSksDQo+ID4gKwkJCQkgICAgIEZJRUxEX1BSRVAoQUQ4NDYwX0ZBVUxUX0FSTV9NU0ssIDEp
DQo+IHwNCj4gPiArDQo+IEFEODQ2MF9DVVJSRU5UX0xJTUlUX0NPTlYoYWJzKHRtcFswXSkpKTsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzJfYXJy
YXkoZGV2LCAiYWRpLHJhbmdlLW1pY3Jvdm9sdCIsDQo+ID4gKwkJCQkJICAgICB0bXAsIEFSUkFZ
X1NJWkUodG1wKSk7DQo+ID4gKwlpZiAoIXJldCkgew0KPiA+ICsJCWlmIChpbl9yYW5nZSh0bXBb
MV0sIDAsDQo+IEFEODQ2MF9BQlNfTUFYX09WRVJWT0xUQUdFX1VWKSkNCj4gPiArCQkJcmVnbWFw
X3dyaXRlKHN0YXRlLT5yZWdtYXAsDQo+IEFEODQ2MF9DVFJMX1JFRygweDBBKSwNCj4gPiArCQkJ
CSAgICAgRklFTERfUFJFUChBRDg0NjBfRkFVTFRfQVJNX01TSywgMSkNCj4gfA0KPiA+ICsJCQkJ
ICAgICBBRDg0NjBfVk9MVEFHRV9MSU1JVF9DT05WKHRtcFsxXSkpOw0KPiA+ICsNCj4gPiArCQlp
ZiAoaW5fcmFuZ2UodG1wWzBdLCAtQUQ4NDYwX0FCU19NQVhfT1ZFUlZPTFRBR0VfVVYsDQo+IDAp
KQ0KPiA+ICsJCQlyZWdtYXBfd3JpdGUoc3RhdGUtPnJlZ21hcCwNCj4gQUQ4NDYwX0NUUkxfUkVH
KDB4MEIpLA0KPiA+ICsJCQkJICAgICBGSUVMRF9QUkVQKEFEODQ2MF9GQVVMVF9BUk1fTVNLLCAx
KQ0KPiB8DQo+ID4gKw0KPiBBRDg0NjBfVk9MVEFHRV9MSU1JVF9DT05WKGFicyh0bXBbMF0pKSk7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRl
diwgImFkaSxtYXgtbWlsbGljZWxzaXVzIiwgJnRlbXApOw0KPiA+ICsJaWYgKCFyZXQpIHsNCj4g
PiArCQlpZiAoaW5fcmFuZ2UodGVtcCwgQUQ4NDYwX01JTl9PVkVSVEVNUEVSQVRVUkVfTUMsDQo+
ID4gKwkJCSAgICAgQUQ4NDYwX01BWF9PVkVSVEVNUEVSQVRVUkVfTUMpKQ0KPiA+ICsJCQlyZWdt
YXBfd3JpdGUoc3RhdGUtPnJlZ21hcCwNCj4gQUQ4NDYwX0NUUkxfUkVHKDB4MEMpLA0KPiA+ICsJ
CQkJICAgICBGSUVMRF9QUkVQKEFEODQ2MF9GQVVMVF9BUk1fTVNLLCAxKQ0KPiB8DQo+ID4gKwkJ
CQkgICAgIEFEODQ2MF9URU1QX0xJTUlUX0NPTlYoYWJzKHRlbXApKSk7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJcmV0ID0gYWQ4NDYwX3Jlc2V0KHN0YXRlKTsNCj4gPiArCWlmIChyZXQpDQo+ID4g
KwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkvKiBFbmFibGVzIERBQyBieSBkZWZhdWx0ICov
DQo+ID4gKwlyZXQgPSByZWdtYXBfdXBkYXRlX2JpdHMoc3RhdGUtPnJlZ21hcCwgQUQ4NDYwX0NU
UkxfUkVHKDB4MDEpLA0KPiA+ICsJCQkJIEFEODQ2MF9IVkRBQ19TTEVFUF9NU0ssDQo+ID4gKwkJ
CQkgRklFTERfUFJFUChBRDg0NjBfSFZEQUNfU0xFRVBfTVNLLA0KPiAwKSk7DQo+ID4gKwlpZiAo
cmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJaW5kaW9fZGV2LT5tb2RlcyA9
IElORElPX0RJUkVDVF9NT0RFOw0KPiA+ICsJaW5kaW9fZGV2LT5zZXR1cF9vcHMgPSAmYWQ4NDYw
X2J1ZmZlcl9zZXR1cF9vcHM7DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2bV9paW9fZG1hZW5naW5l
X2J1ZmZlcl9zZXR1cF9leHQoZGV2LCBpbmRpb19kZXYsICJ0eCIsDQo+ID4gKw0KPiBJSU9fQlVG
RkVSX0RJUkVDVElPTl9PVVQpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIHJldCwNCj4gPiArCQkJCSAgICAgIkZhaWxlZCB0byBnZXQgRE1BIGJ1ZmZl
clxuIik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGRldm1faWlvX2RldmljZV9yZWdpc3RlcihkZXYs
IGluZGlvX2Rldik7IH0NCg==

