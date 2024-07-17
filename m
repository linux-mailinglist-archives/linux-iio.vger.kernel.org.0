Return-Path: <linux-iio+bounces-7654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B50933D4C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE771C225D8
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F017FAB4;
	Wed, 17 Jul 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xK7eqjjJ";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lMDPTwpM"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8F1CAB1;
	Wed, 17 Jul 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221376; cv=fail; b=tS4FWN+P84MMitapt7aUQgpVY8Lv2m74g8zI0NViEdQ5Sn2OOZu3NP6r+uXa4oNThb3op8Jp70vUoTf5aN4FcxNsFs215kK3Xr5QeTB2psR4cppNLrFzv+5PB21nHnSPxNP4HL3P8WjkSc4v+u31W2JKYsW76RnQJEnXPXRqlZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221376; c=relaxed/simple;
	bh=KFxqMEDPJzPaEro9nSpsnKVucuVixwfWaVBZcgnIqQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFsQfPlfSia0ulUKtdBP/IYqVR04VPwd0jrwVe598dQYQ02pKrPxrrHRZKXt5tjhNhHm4Fa6ulPIpaX9cfaJZ+G2vIzmIxnvRKNWHsn7Jlv6JEmMnHI1fKYIGuejL3BZC8sMZ1+3NNCgqgw3bqw+hq+aWbDAWE1q9M1zA5ODmoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xK7eqjjJ; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lMDPTwpM; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721221373; x=1752757373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KFxqMEDPJzPaEro9nSpsnKVucuVixwfWaVBZcgnIqQ0=;
  b=xK7eqjjJugku+ZhpQX7mF+0dHKCIakVBf35XWrxYQWHRaukfPIdQCqSn
   DYPstZUnEcxCTvZREsp1sg/2F/BocCCAzbbyi1P8y9dGOEAsurWgnh2AP
   DCKxOrAWEtzOVp3rxZAl3vn6oyz6uU2BmhXqVw49sJgWhGof3Sb4mv3nZ
   xpABPlBZkioqxxJXPwOIeW//EU+M2FsZxhbDdVxXvDsrcNqHgCXD0k/DC
   gKl3dZOzOGbH0d4WA9YuEc5EJjgfzt8XgXNtqR10TPJ1EmehXeZkZTyPW
   dkyeY+EUBC5c7NXk9oERjOz+2GoE1TciHD0QpSoaPTUSNXzd7EingnpI8
   A==;
X-CSE-ConnectionGUID: XIeazs0+SCm3VHF1v3GTCg==
X-CSE-MsgGUID: ip67IpHdSTal+Mt11CEkCA==
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="260238902"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2024 06:02:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jul 2024 06:02:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jul 2024 06:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCeVh3UC5xquhGi2JENPcadB+lo03twiSGtAQ+jn5MQAn500yHBufeHoAzuMTtjI2qKmFRut2uYtu77p+hidelOLcqzkNEln0vzritS+lqVjQ0CejIm/XCLQANYaUZdGgcGf1X0OjV2iWW4ybH3n+1TVwR0B/1wiutIoIAoxXhlzHRH4jhwAf4AfTj6oHHB/WfiTb66pDuM7yhrCK1w64CM1WlMNPExPi59BMazdYcds9HE/OmoB9f4KzWVSijKp1NLUZkqX0LvM1a1qmoJuLk/JDOJqmhs87Q/q038uO7oj4gKg0MnCuqobJAisbdKaEVQxYJHiRrbLsGEY9K43gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFxqMEDPJzPaEro9nSpsnKVucuVixwfWaVBZcgnIqQ0=;
 b=eBERznps5qWZdHqG/Nk4Y92g1eEY1HiaALc4uTW1HkHOpFgOooI2LAqYrhxu536sGUVfTJ7LA3Xa0Qipv9EGHiD10phHH2jfBuG4+lmgIveW05Uks4TKYWh5hC0PEhjB8MJ45+Ss8PGu7nGCu+3kksbZ/mgLyZfKTdlwhNM0O8xU4gLh+ngYY6rIzlIZlFO4W/usmXHya5V0p8tynNQ5V7imecjIb9G+nftu4bZ3SAjGzjHlMDARySx3suiLF5ineRVYqVYHJj2qMDzrjNGJGgdK0eNloVhNt3wGCEtsVcZvH9BG43ULLv/ZnN6alvGvZvmQasZuu35F3etDhQYSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFxqMEDPJzPaEro9nSpsnKVucuVixwfWaVBZcgnIqQ0=;
 b=lMDPTwpMsUvKxP9bTzDUkZDaBW/gkNmWPGCT2N4Pwd8OJJXkQIdXxvU4gmvxxgnsvJ0kwt+1LE+qXse1Yya+PXPHxlZIf68U9xGrDCk+rApQLzjRvUTb/2gkT4rbxJn/9dI10p0Y9XHA/jlrtOW/vmcfm8UxKHWStmMceiwmhyL1zZ9AvscYsNdL0BzVwGOlZWyQWZkiHssMEy1SnHyqHL9iAMb1abX1OwYFLHWYgor/ZKh4homRv0/z6SmLEKvdgkdGVkMF2itJHzZq0hNvaIiQI2LtAfGpBWs9v3RI4VKzobrIyAX9WT3j7CEnDQkLsBAMnfkG9fcKWnE4IjLwRg==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Wed, 17 Jul
 2024 13:02:40 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 13:02:40 +0000
From: <Marius.Cristea@microchip.com>
To: <kent@minoris.se>, <jic23@kernel.org>, <marcus.folkesson@gmail.com>,
	<dlechner@baylibre.com>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/6] iio: adc: mcp3564: use
 devm_regulator_get_enable_read_voltage()
Thread-Topic: [PATCH 5/6] iio: adc: mcp3564: use
 devm_regulator_get_enable_read_voltage()
Thread-Index: AQHa1HUoMPn4vtMAOkKM9TM9X1KyfrH66kmA
Date: Wed, 17 Jul 2024 13:02:40 +0000
Message-ID: <87ea4041b5e5569389a2c5301f41f37340ad25cf.camel@microchip.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
	 <20240712-iio-regulator-refactor-round-3-v1-5-835017bae43d@baylibre.com>
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-5-835017bae43d@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|SN7PR11MB6969:EE_
x-ms-office365-filtering-correlation-id: 6adb3803-5850-41ce-aa5a-08dca660bd4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c1d4TzJwaXFZWGhPVUI5L25weDRBQVpZeDd3cGNXSWxTaUd1NVRkcTlmenRa?=
 =?utf-8?B?NUV1M0puMkdBYlRyMHVxWGpySFNPcWt0a25QRTliRzErWmwzL25MUXdIbjZH?=
 =?utf-8?B?TUk5U0pVNVlLL1R6ZXBoa2NnQlVUNktNNU5kSVpHcFYvWHFRZ0ltT0loMEM3?=
 =?utf-8?B?Qnd5UDNHY1lGYU95QlhzL3hrYXhzVENnTzVwUE9kU3pGYUdBbVFjWmk0Q2ZS?=
 =?utf-8?B?bU15VncreW5Qekd6Z1F2eUlBZmt1S0NhL0NBMWlMUlFWSnVidllRYnhCTldL?=
 =?utf-8?B?cGE0djNJV1VidDNMMkYzdlluemxBaXJXNDlZL1dCb2F3MG5RRysvWGVUOElw?=
 =?utf-8?B?N1F2VW1meEVvYUZCeCtwaXN2cU9QZlBJTTdNSUsveWtoWmZYRkhIVjhJUUZO?=
 =?utf-8?B?RC9rTmFLUCtNVXl0Y2xkNmUzNUIzai9nNkp1M0lBR1BLOWVIS2lXVy9VbTEy?=
 =?utf-8?B?WmZFQTFXdW54d1RPZ2xBWk16d2xRMjgzNU0xbHZMK1p3UlVOc2JJUWRUS0Vz?=
 =?utf-8?B?aE5IS2tjc3JaQjVVOThwVVg0dFJlQWZNSVVsNkNkQ2pScG42aU9BQXA5VDVU?=
 =?utf-8?B?UlpkWjh6OVFBUEU2anZFY2dhUGxJTW1MYVlmbnJVc2lTSTUxOVhpZFlqTWRK?=
 =?utf-8?B?ZnRxV09ybXRBUWNNY25EVU5QQ01rK0Fab09jQ2IxN0J1SWg5MitwdDZ0dFdj?=
 =?utf-8?B?eno2dFZUSUxqRmVxYlRMdlpnQXhGY3k0ellYWDRUKzEzSGdnb25IZnZKcjZu?=
 =?utf-8?B?YUV0UklaMjRQZXdLYmQxMUJYNGVlQkRMbmM3bnJRL00wMytpa2tkdFZYOEUv?=
 =?utf-8?B?OEZrcElkWWVlV1dPeTA4Vmd4RmJDZTFDN0t3cUpkd2tDd0NZSGRqSVFmWkVT?=
 =?utf-8?B?R2RPNEd4QXhhcVVtRUIvaDkxU0JiVDhyN3IreTZTVkJUUVk4WE1JT295K0tn?=
 =?utf-8?B?MXg5VFVZM0ZVcjNsM1haWHArNHEzbnlnelNuTnplelZPamVkSHJYWS9ScjdJ?=
 =?utf-8?B?OXl0UkFmM2R0aTR6K2djT0R4RUFRakVuK1VBRExuVGUzQkJBZVlCanVFcWgw?=
 =?utf-8?B?cHhDUGpaTjBZTFkxdDJZVjhNWUpYWTA0Ulk5U05Rc3h0cXE4OTdUUGoyV25j?=
 =?utf-8?B?NVBXSDlWSWFwZjRSY0RnSVNMQXRCSmk3djlneFEyRkpoYjRFcHZPOEZqYmE5?=
 =?utf-8?B?RXZxNUFwTzdMRUdkRmNjV1lSNmVIOWYrQnFzdUZLYnFIcG5YaXlaVjIyYzdK?=
 =?utf-8?B?RTI3ZmxZU1dpY2hjd2Z0aTZYbllPZXlPbElVakl6a3RLUzlvRlY4Z0tBVHVy?=
 =?utf-8?B?bTd0Y3VRRjB2VFgyRTdKZlRsWDl6bDZIVkVYYzEwUHM4SGZmb2hTMFkrUlJk?=
 =?utf-8?B?TkhRSkJ0ZE1DSmlEeCtDK3dnNERtUW5INlg0M092YXlUczNnaWZrQ3VWUmpm?=
 =?utf-8?B?QllMSmlLaWJQYXB6ZlVpaFZUak5CaDRRcVFDWitERks2enBwT0RNbnBueXpW?=
 =?utf-8?B?WE85bm03MHBjNlJic0d6RmM0emJZNC82SmkxMFhqaEl3Y0xvT2loUy9RV1pK?=
 =?utf-8?B?cFg2aHZNa3RvRXl0Wkl2WGMzTUp6b0M4dGtEK1R0MlcyY3JTVytYbHZYYitZ?=
 =?utf-8?B?OEYrVTE1Z1BnWWNiV09MQ0VQRVJ6c0h4NzJDeitETUFLY0dXVExablZlSzYz?=
 =?utf-8?B?d2Uyazd5dnVVV2hjclI0VlpXdHZPOVU2UENsd1M1VnA2TWR0Z25XU2t4SERp?=
 =?utf-8?B?Q3ZkQmN5di9uYWFOK0lBTmFBdjBRUlZwQ3Z0czJMTXFZR2hlckxNbjJ3OEtm?=
 =?utf-8?B?bHNRbnZJeit1aG9IQnNEYzZuUHh0dkpMcG1BTHRKNXNXTmYyeW5BS2JlRExw?=
 =?utf-8?B?N3dGeUJEVm9ScHMyc0JyeVRZM0xMdE9vckJ5MDBlWDVQOVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmg5aENURkExaTN6NzFIYWZJV1FRZHo2b0tkdit2NkFUbHZHT2Z4Z0pianor?=
 =?utf-8?B?VE1oN0EvQS9TL2FFZDNWa0JhZEVJelpLa1JseVF2WnhRK1JPQmlJOGdTeHUr?=
 =?utf-8?B?aW4yVWEvSEp1ZDluNWpLaytYTlNHQVZzMFErUWVpb2hQUUg2Y1VQbG1zSVhB?=
 =?utf-8?B?a0NVUXl3R0Y1M0xFQnBCd3VxbHNiSlp5eGhqTzhmMGRKNXFxaGxTRzNKWGlq?=
 =?utf-8?B?ZVRBUXV6ajNFUjQxYk5jS0o5RWVucFVaRk5vQXZueG44WVR6RDkzY2ZteC9S?=
 =?utf-8?B?ajdCZ1dHTXh6TWdrZ0tzbHF5RXgzb0ZETGJpaUZtbWlJQkJxR0Z3Um5EZnlr?=
 =?utf-8?B?S2llN1RoVURqWjM0b1lwb3lodDQ2RFhja0R4QTM5QlBhOEcvRlN4Nk9nQ0N4?=
 =?utf-8?B?UTdKemo1UWt3elJMY2dQQmtvWFRDcU5lNmlGeE9xNjBOWmU0c05OTTIxcEc0?=
 =?utf-8?B?aEpIckRBeGN4U2I0b1c4TXQ1NWJDT3NzSC95Y2J4V2hLOGV5R3BtejFxRnY3?=
 =?utf-8?B?ZzYrci80M2dvYy9RZnJ5Ym8rTjBST1E0RUhHZmNWYlVNdU9KSkNTOCtBYVBx?=
 =?utf-8?B?cVVySXdmSmk3UkhaMUowQk9NVXR5N2VrYUY5aXF1UGN2cmNTaFpqQ3RxclJN?=
 =?utf-8?B?bU1qdFBqeWdVY0U1SE8vZ2NIaXBJbFZYeHRNUmV2b0xNRG12Q2R6SUFXbjFY?=
 =?utf-8?B?V1p4QW40ZFhLcE80ek5HSVhIdEN3cVYyL2g1U0ZuTFYzZzk2MUREN2hVZGRS?=
 =?utf-8?B?dDl3ZkhUZ3g3d1BMV004aFpGVXRVcGxGSzU4dUxtZFUyek9jV2cvZXBxditW?=
 =?utf-8?B?b1pxbW5GYmJNd3NKUUR3R1daaW5lOG9oRDQxYlR4N1d0NGZLdS9JUGJOUVdG?=
 =?utf-8?B?YWhxV21rUy9GNzF1ZkJTUDhtOXV0bVlXdGdMTzI3RzZHUnFRVUhmanI1M1Uz?=
 =?utf-8?B?YkhiRFd1dFRxdjJOczNFS0NGYWVVTGoyd0g2K3RrN2Q4V0FOaGk1NDlGRDcr?=
 =?utf-8?B?MUs0VFM5SkNIR1VuM1VrUlNCVFBQdHJ3QWwwbjh2VG9Ca2lpM2NCQkJocVZM?=
 =?utf-8?B?ODZueUZJWnFXL2ZtMWZSY1MyOEpSWWxSQ2ZHTTVpNjlhRE9wb3NGOE9LMTJ6?=
 =?utf-8?B?K29OK0taT0IwdnBmNEVUM2VqYktNbm5KRmh5ZS93eFloV1ZHdFRRbzdqWWl0?=
 =?utf-8?B?STBtU0dCT1pVNnRTUWlTczhoT0J0U1lxYWd4NUpVcmZJOWxuOEdPaklyN2N0?=
 =?utf-8?B?VGkxM1FLRVRlak5mbVdTb2hjNnkxRDl2MXBkVVU4aEdleFBJVnBsVFBndjJ0?=
 =?utf-8?B?VTE3aG54SjZMK2dua1NyVHAzU3VBWVRtSHc4R1dqM0VjT0VTQnBBRWFaK0Z3?=
 =?utf-8?B?SVJIeUJ4aWxyZUxrTjdKY3F2cEREaVkyVDNuN1k4SXZ2RWp2YlFwWVQ2ZnJm?=
 =?utf-8?B?NnZuZW5XM0dLbDZPZ3BKamZkYTVYLy9vdSt3V0hITC91Z3djN2dJTkFFM1Rz?=
 =?utf-8?B?V2NYb29vVXpuYU1XLzMrUzRUSUhSN24vVXlIRXFGZk5nMGV4TG1NdjVEdVhD?=
 =?utf-8?B?dnBtSENoTjIxcmJhL1dzZC85WTY1RG9PRE5hLzBJNVFtWW5yK1V2TjFnRW1I?=
 =?utf-8?B?NHgvN1d3ZGZpS25qeEx4RkR1UVJjRmpneXNtUnlHN2FCYk9rMkRERG0rVEpj?=
 =?utf-8?B?ZnhtUEYzMlQ5eTJDRE4weGdIdTdrUHkxeFlMeVh0RjZFZGZhQ1MrL2xCdk8r?=
 =?utf-8?B?Y0ROYXpydHBnckQ2OXBwS1pKSTJGTExvUE96YXpuQXh5MDJteUlzeFRpMXpX?=
 =?utf-8?B?bzJtM0t0ZUtETkQ2WGRGU0FDTkY3UGVXRklTY3hsVXBJNDVDamVvNkQyTUxj?=
 =?utf-8?B?aU92aXVQQnhTVjJOL1FCbTBPRGlVS2VpakRHYXlLK0JMRytuT3B4VDlzUEwy?=
 =?utf-8?B?MmVxd3ZuU0M1aDE0SDFZbUc5VG56NnpidTRVam1RT0FzQjNQM1U4V3NCTmkx?=
 =?utf-8?B?UjJFUU0wSVdFeFdMbnJNdkcwZzV3YVdYRTNmQjRDT0dxNkViSkgySS90OEQx?=
 =?utf-8?B?QXo0REgrRFQ5YXcwMFpPeWR4azE1SUVtK1Q3MzVYcGtHRWRyMzBkdDc5OUxS?=
 =?utf-8?B?VjdDVXZmMVQ2NmIzOUFUemR5VlR5MFIvY1hWUVJLdE5WYU5IcWVtd3k4Sllj?=
 =?utf-8?Q?kEcLl12nbj+oUYFsXuznX5o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DEC154C08281F43A7FC02FE50854528@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adb3803-5850-41ce-aa5a-08dca660bd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 13:02:40.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6fAzk/7VBHX3DcKkfv6tCw+F5Qx1CYKGhIG2BoUwOc/ANBeDvL1Orf3NBudbYP1arJzEfXXV+sGMLJcC28KXTuYh1BPLnlmicqcqjpnRsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969

SGkgRGF2aWQsDQoNCiAgIFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIGNsZWFuaW5nIHVwIHRoZSBj
b2RlLg0KDQpPbiBGcmksIDIwMjQtMDctMTIgYXQgMTE6MDMgLTA1MDAsIERhdmlkIExlY2huZXIg
d3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhp
cyBtYWtlcyB1c2Ugb2YgdGhlIG5ldyBkZXZtX3JlZ3VsYXRvcl9nZXRfZW5hYmxlX3JlYWRfdm9s
dGFnZSgpDQo+IGhlbHBlciBmdW5jdGlvbiB0byByZWR1Y2UgYm9pbGVycGxhdGUgY29kZSBpbiB0
aGUgTUNQMzU2NCBBREMgZHJpdmVyLg0KPiANCj4gVGhlIGVycm9yIG1lc3NhZ2UgaXMgc2xpZ2h0
bHkgY2hhbmdlZCBzaW5jZSB0aGVyZSBhcmUgZmV3ZXIgZXJyb3INCj4gcmV0dXJuIHBhdGhzLg0K
PiANCj4gU2V0dGluZyBhZGMtPnZyZWZfbXYgaXMgY29uc29saWRhdGVkIGludG8gYSBzaW5nbGUg
cGxhY2UgdG8gbWFrZSB0aGUNCj4gbG9naWMgZWFzaWVyIHRvIGZvbGxvdy4NCj4gDQo+IEEgdXNl
X2F1dG9femVyb2luZ19yZWZfYXR0ciBsb2NhbCB2YXJpYWJsZSBpcyBhZGRlZCB0byBtYWtlIGl0
IG1vcmUNCj4gb2J2aW91cyB3aGF0IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHR3byBpaW8g
aW5mbyBzdHJ1Y3R1cmVzIGlzLg0KPiANCg0KQ2FuIHdlIHVzZSBhbm90aGVyIG5hbWUgaGVyZSwg
aW5zdGVhZCBvZiAidXNlX2F1dG9femVyb2luZ19yZWZfYXR0ciIgdG8NCnVzZSBzb21ldGhpbmcg
bGlrZSAidXNlX2ludGVybmFsX3ZyZWZfYXR0ciIuIEl0IGNvdWxkIGJlIG1pc2xlYWRpbmcNCmJl
Y2F1c2UgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdHdvIHBhcnQgbnVtYmVycyBpcyByZWxh
dGVkIHRvDQpoYXZpbmcgb3Igbm90IGhhdmluZyB0aGUgaW50ZXJuYWwgdm9sdGFnZSByZWZlcmVu
Y2UuIElmIHRoZSBwYXJ0IGhhcw0Kdm9sdGFnZSByZWZlcmVuY2UgKHdpdGggdGhlIFIgYXQgdGhl
IGVuZCkgYW5kIHRoZSB1c2VyIHdhbnQncyB0byB1c2UNCml0LCB0aGVyZSBpcyBhbiBhdHRyaWJ1
dGUgdG8gZW5hYmxlL2Rpc2FibGUgaW4gaGFyZHdhcmUgdGhlDQoiYXV0b196ZXJvaW5nX3JlZiIu
DQoNCj4gVGhlIHJldHVybiB2YWx1ZSBvZiB0aGUgIlVua25vd24gVnJlZiIgZGV2X2Vycl9wcm9i
ZSgpIGlzIGhhcmQtY29kZWQNCj4gdG8NCj4gLUVOT0RFViBpbnN0ZWFkIG9mIHJldCBzaW5jZSBp
dCB3YXMgZ2V0dGluZyBhIGJpdCBmYXIgZnJvbSB3aGVyZSByZXQNCj4gd2FzIHNldCBhbmQgbG9n
aWNhbGx5IHRoYXQgaXMgdGhlIG9ubHkgdmFsdWUgaXQgY291bGQgaGF2ZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0tDQoN
CkJlc3QgcmVnYXJkcywNCk1hcml1cw0K

