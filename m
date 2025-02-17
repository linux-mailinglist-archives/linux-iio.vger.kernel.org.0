Return-Path: <linux-iio+bounces-15618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F8A37C36
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 08:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EA2161EF0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33C195F0D;
	Mon, 17 Feb 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ps3mzZOe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A6190665;
	Mon, 17 Feb 2025 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777355; cv=fail; b=AcAe8mOLgVPEMqY97tyMmHdf1bX7mgVwuENFwCbLnOJh4z+DwswX5LQQwd1r42k7+pN242IMwcxHeXRVcINGM3TcKr/Qawhxi2HiLcCW58x/67WKgWTb5BwU3ZH63OljJyQwhFFjsmiLoVNXMKuYUznZO2Q+zFfGXp1XvgXZINs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777355; c=relaxed/simple;
	bh=HapvVaPOw9w8aYr3jfA37FnNDKddt1vy+QyvJEMsFV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EVUDLaU2Cq00hWhanDpzMqtnEV8aKgmyRquDYtcmdapERAk5PHppyXC2ll06g58nzIcnFetTbijWiYbfzOy5bjzQVSM6ShiNZ5oHe5HY5CgOd4XUfuy0VfigYoPESTwKOmYyGb9L6pHmKlx+EJbrwbr1k/LIm/rnVPT/WGUCEUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ps3mzZOe; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H5LlcG018548;
	Mon, 17 Feb 2025 02:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HapvV
	aPOw9w8aYr3jfA37FnNDKddt1vy+QyvJEMsFV4=; b=Ps3mzZOe193sb7jff5uuw
	Oi9+p8wNocdm1UEPONPQG3Bl3mt+gylVCtWozSx21360d/MQEpX5zUvLuYLwWGTN
	NACZ8Zyccs4/SbikcOan2DUMs/8cGs7DlTB4qwpiEv1czwTmQWAkXjzCdCqpxs5+
	6cj63wTtVqih8/7djg6+3f54RC27Vb4EGiTDB4FijJIvMU+XcSlVsb/EdQbL0thr
	39XiVRFefqdrqtZnjqoSWPm9g3qgYWfkGWLRxgH094/g0g+8hDveCwhlqsfj90ER
	M/fsx/Jlq18WHvuAspIgQ71CNDBjgzXxZsgu4KW0WNpd8V1pMxRSTnOmp2/9zN+0
	A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44uxwa0af0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 02:02:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgwFmHvfoJfHWejkdx7aIDD9ahLSKod8BeB/kc2ZHGVM7ZbQs5HkWKZYIUNEc1yM+1gLprVvEuqcBZmsAa6ORkndVPBXjQ+QarcV1w/BZD1HZlpt9Lq3VHHhZoBXEb5tSHtyFkY1SGmoOPrMuwznkHvoPAKBUvjAdOFPUHeCddDWLGJLd3660no5V9Nh9n7jsv5WfYrmaxZSYjcNN5VwPNl9pEnRJ9zND8Uggmjq9Qnyc4ugZlDfJSUi08/Oaiqq7HpR1smSTmAxdCjY1sxq4UF3DwjbgiUp7HleOzbZ2bRPLSBpRWsljksGNqN8SH8FGLfBa/US/Vs81UBS4iQIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HapvVaPOw9w8aYr3jfA37FnNDKddt1vy+QyvJEMsFV4=;
 b=pfIyae1YqJXSj8O55W2mKF/LkpBapAtfemjVbxKDVhK1GkVVANQQq04kuwSKF35mdcF46SsR24v87AeEWc2pI1Ob0oBOK2INUd9lU1fCNUtro3Qt7C1Bfe944zA4vKP+qRhBt1EozLxdpOk0hhT9wwm1Q4wySHqvBj/07g1gucKRDz1EUqT5GYQsFKSmJJlocdrGVb1TlPsHQTu+eqUvwJ8Qil3EiSOgmOCyXX635R6aceHxHALLDmfJp85hPB/5vianA1A/jIJG0aU97klAul3nwvc1OnqVfcxs0dkT++g8avdNm/JJ9YYpVD7O19EIEI96HLlNNq4lZyQS2NNjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CH5PR03MB7885.namprd03.prod.outlook.com (2603:10b6:610:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 07:02:42 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 07:02:42 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] gpio: gpio-adg1414: New driver
Thread-Topic: [PATCH v2 2/2] gpio: gpio-adg1414: New driver
Thread-Index: AQHbfhmY6+J30LybxkOClRRKRxq2Q7NF4NQAgADomwCAAKj0AIADoy7w
Date: Mon, 17 Feb 2025 07:02:42 +0000
Message-ID:
 <PH0PR03MB71419BE3FCE2DAE8AB72B79EF9FB2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250213-for_upstream-v2-0-ec4eff3b3cd5@analog.com>
 <20250213-for_upstream-v2-2-ec4eff3b3cd5@analog.com>
 <CACRpkdZR8X17Bn-i2anqjxf0Gk60V175F7Xfwytkhy7_K+LsSA@mail.gmail.com>
 <880631da17a6d8ed4afe5a8c453fd4f7d0e4fca5.camel@gmail.com>
 <CACRpkda+CDRMYKmjw7kewenkteLhPYb040E4B=ZG6pgdy=65pg@mail.gmail.com>
In-Reply-To:
 <CACRpkda+CDRMYKmjw7kewenkteLhPYb040E4B=ZG6pgdy=65pg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB5WTJNMlltVmlaQzFsWTJaa0xURXhaV1l0WVdJeVpTMW1PR1Uw?=
 =?utf-8?B?TTJJek0yUTJObVZjWVcxbExYUmxjM1JjTW1Oak5tSmxZbVl0WldObVpDMHhN?=
 =?utf-8?B?V1ZtTFdGaU1tVXRaamhsTkROaU16TmtOalpsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STROalU0SWlCMFBTSXhNek00TkRJME9UTTJNRFF3TnpJNU1Ea2lJR2c5SWpS?=
 =?utf-8?B?eVprdFJkMGd2WTNwelJEVTBUemx0ZUZFeWFWbHBhMUVyVFQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVOW5RMEZCUkU1cVVpOTJRMWxJWWtGamJUaFpaa1JPUVZaRFYz?=
 =?utf-8?B?bGllR2c0VFRCQ1ZVcFpSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVJMFFXZEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlVHZEdNMEpSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSm9RVWRS?=
 =?utf-8?B?UVdGUlFtWkJTRTFCV2xGQ2RVRklUVUZoVVVJd1FVZHJRV1JuUW14QlJqaEJZ?=
 =?utf-8?B?MEZDZVVGSE9FRmhaMEpzUVVkTlFXUkJRbnBCUmpoQlpFRkNjRUZIVlVGalow?=
 =?utf-8?Q?F4QUFB?=
x-dg-refone:
 QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CH5PR03MB7885:EE_
x-ms-office365-filtering-correlation-id: 7620e753-81af-4bee-c1fd-08dd4f2112e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1JhT0VyeDJpT2t4Sm40ak9KL29Qd1Y2S1B4bk8xbnE0b296NXYxTmhuSWNI?=
 =?utf-8?B?emMxZDQ2U0paSTNYWmdVSG9SK3p3Q3ZWRGJJeHJsZU5ZVmp0R043a2R2aDdH?=
 =?utf-8?B?V3FVZ0MyR3VEc2hFV0JDelR1Z3AvTDFRMCsvOHFvbVd3V3lZQkpuM0ZpUFNw?=
 =?utf-8?B?RGdrSXhmOXpiMTM5WXZmaXowMUFhVXlQbEtUTmR0K3VDYU5aVTF0ZGs4TVZo?=
 =?utf-8?B?YWw4cVdyRU5SMm9HUnlXME0vUHZmeUhGV0doaWFxZERJU0FHVWRzM0xjUml4?=
 =?utf-8?B?Y09NeWp1b012YWlWM2lkZWhUZkFDVXZiTU1oUGl1VzJDbFRya3g2REZUOENH?=
 =?utf-8?B?YXdtMGpZdklQUzFud0RsNUZtYjgrWDY2OGRwZ0FLbGloRXRMa3RKb0ExUlBw?=
 =?utf-8?B?WnZMSGV0aWlyYXd5WVFJejB2TTQ4N1RYRmU0azhlYVp3VGh0YlQ0TnZ4TGNW?=
 =?utf-8?B?K0htV0lMbkV6bENOZzdXUm5ESU0yOE4rdWlDdHE4cGJ4dUx4aHRWS0Q5bTFT?=
 =?utf-8?B?SUUwanJlUGgxOUVBOE51RmdpLzlSaEFaNndyb3ArVHpLdWpReE9kYmdXdmZH?=
 =?utf-8?B?U3hIdFBLZVJhaisyVVEvS2dqK3FNdXZPQ2hoZTV0VUxkRnM1TnRZMWQzdkVO?=
 =?utf-8?B?dmhVVzZXL0JzSDBqaXg3UG4wZVgxMXN6ZmRDc0Iwa3dmMzVVRjl5NzZJVjlC?=
 =?utf-8?B?VlpCOEFsY0R3bFRwY3gyNEJPdUhSelh0VDNHQ0Q2SHB0QTREcUF1M0Q3d2JD?=
 =?utf-8?B?TGZkeHFrVkNWZE1jV2ZRUHFGcW9XOGJDdExlVGNabHFKbEl1YjFxdmFDMW54?=
 =?utf-8?B?VXZqbUFtWlZLemdPY0tHRW5pWkhOaVNkckd1RHdDekU4Tnl2VUhONXdqWHB3?=
 =?utf-8?B?SEZ0bTBXS01WM1ZTK0VielJPVGFIREN1bnhzSzVFV21hclNCMmJVVlVtYlpT?=
 =?utf-8?B?cXFMU256U1VSV0wxcjRJODFiZjFMdENPWlVFMGFjRzRRMDJnWUlYR1JkcWRQ?=
 =?utf-8?B?VFFqMldNTm95ZW1VU0FzRFJJMmJpT2JzUUM5bU1VanFFSENFb3NhSnVFRzIy?=
 =?utf-8?B?VEp5SFYxT1lVSlNmVTVvRXdRSzdxUnV2cTcwblB5K25xbzd6QnNrNFBKSGR0?=
 =?utf-8?B?RmRMQ2t5V3EyLzdLeFFmUkNlTm9lRUhsRmpVV20rcUR6cVAyQzQzNU53R0F0?=
 =?utf-8?B?WmdoRTFaNTJzK295QXI5djRweHFKa00yeDRDenlXbUZZWnBzT3Q5Z2x6cXQx?=
 =?utf-8?B?STZoZ3d2Y0hPdjU1NCs1T1J2K1VZcmlRRHV3aW9NMUkwVTQvSzJSbWxnQ0Rq?=
 =?utf-8?B?Y1lBNnZwK1h1SUs4YlVLalhSUHp1Z1daOEZ6SkZHdmFJUENsVzdNVHRhTC9U?=
 =?utf-8?B?V29iZ3lVYjFUcFMzL0JNR1JDMGI0MW5XVjc5MC9qNk1WUDNBSG5vQVFLWklw?=
 =?utf-8?B?MHhxOTlDU3pvdWJjN3AveFhacFc2WkZDNlludWF3THo1ZVVUdzdEMzgrYmh0?=
 =?utf-8?B?S1d5SGFYSW1KNUR5c0FXaHNvWGVReHBLSDlTTmhlS01Mb0k1cEY0TGVoUFBr?=
 =?utf-8?B?NUN6VWN1TDZNRmZvYklLV3FUSWp2MjY5dmlUVHoxdmh1VUhEd0w3dHBnVGN0?=
 =?utf-8?B?eWNIRFVHeGU3Q2FhdnNBRFdKMVlRa0V6Sng1My9jVURiZ2xMUmJqd00rM2RO?=
 =?utf-8?B?R3pBc3JyczZCbEgrL1FoTXdxd1dsb1dkWVlwTksxcXhXNFI4YjkrWjZ5amFJ?=
 =?utf-8?B?elhiOWpTWWVUSzhXNzJwRkh3UDhGWHFiRTZNK05pbVZGMi9rZ1lqK0pHdDFw?=
 =?utf-8?B?dERlSzFTUjRNWVJRRTFCVGZ0MGRNSTlURUlnWDM2bmR2QkYrZUsva3p0MTVQ?=
 =?utf-8?B?M1JEbmVJUzhlRjUyZk5NMkQyaSs5N3QwSllWNjh4Wm44MGxlV1NSY2FFTHFT?=
 =?utf-8?B?WFkxdWlNNy8rUTMwbWFOUEhvbmJIcU9jZTNsZVBUZnhLcGZCeEZncU4vLzNB?=
 =?utf-8?B?dHFWMXczZElRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3llbGVuNEd0bGg1M2Z1V3lqZ3hMVGZtRzJsbXgwYVpESHpGM05Ua1hzTmh3?=
 =?utf-8?B?aUNPMDlVa1IybnU3cWE4YTY3eUlOSGV4SzZ1b0Mrd2NyMFJzQXp0WXVDSFVt?=
 =?utf-8?B?TXFsTVdSOWFGTHFqVVJ5MkZxakFUSlRNWWJDQzlmYWtsYW1oMlJvZnR3RHRi?=
 =?utf-8?B?Z1VXcXl6eUhHV2RsS2dCQ0JnZ2JvVERYbEYxcmN2TWJpdVhNcFhSNGtNdW9r?=
 =?utf-8?B?amI1VjhNOHFJdjE4eUdPNUxnU1o1OTM2bHp0ZHpGRm5EdFhWWWNYdTZhcVRP?=
 =?utf-8?B?SnFxNy9lcG1tNlViSzZtREgwYjNwRHR3YzVqWHN6SC9IVXJCQ1A4Ynk2M3RG?=
 =?utf-8?B?ZTZUK1hJcDEwRmhnaHR0SGsrWU1RRDJuM2lNcXdHK0JOd2lvdzJ4R0lSQ0tH?=
 =?utf-8?B?ZUY2K3lGcE5aSjNUNExGeFplenlsQWdZb1J2SDB1ZWZPblBpd0U5K1JVNXV4?=
 =?utf-8?B?eXN1a3BkUTlwUTh4ZXp6ZjkrTmFIVFEvWHZRdERZcEcyNWZqSS82TVIxQmZn?=
 =?utf-8?B?czFQenNMV2V0WjFJbVpGckFwU1prYjUrYks1YUx0dHdEZHNRaWRKdnA5WlVv?=
 =?utf-8?B?aG42aHRFb3Zmb3VndmY2engzMmo0TEcxeEZOU2hDcGQvUVJIVUJUU01UcllM?=
 =?utf-8?B?QVVsWXRRSVNsMXMybW9hclM4WDMwRm52NG1WVlJvZTNSS0dLdUZYRlp1OExS?=
 =?utf-8?B?cjVWSmpvUnpuWnQyejBROTJyTXpGdFU0MzVPRWtuZTVzbndTS3lkaUVTL1Zt?=
 =?utf-8?B?MHM4cjBITHVVdktmR3VKUWVXQjRDOXBOZEVWNE1GQlpHZHN6UDZJSm9BR1Bq?=
 =?utf-8?B?N0c1bTR6WDljUUY2WnlaNk1pYzJMUHpZaXBINkYwSnY3VWxLR2d4UkM1bS9z?=
 =?utf-8?B?Z0p6VnJWRlBjTCtLTDlOQ1ZTODJKL1JkYjNBZVJGRkJoVFNOZG14cThFZjZK?=
 =?utf-8?B?RkFyRDFIcnZnd1FKWC9lN2ZJd2hpUWFjNlpzcTFVK1ZTZngrZ2QyTE1wdFpO?=
 =?utf-8?B?ZmtWMEord2hHZVE2WEpHcWhsdC9seDQ1VlkwMFNIS3c3eXlvZTV0VGJCeHlP?=
 =?utf-8?B?a0V5SjJ2WWlwRWJMSzRSNXBuR2ZPRThudDdVMStZenpXUVBEUFMwVVMzWU5I?=
 =?utf-8?B?NEhyWVJFSTRQSkdjTGpJQ2swWXphSDl1RWhxdHJWTGNmbFptVlluazNtM3No?=
 =?utf-8?B?UG5IaWZiSkJvUnI0NmRkd2xmQzFsUE1YSTlZMUJ0eVRzTWlxYkhhSXZvWFBS?=
 =?utf-8?B?TnkrZjJwZDZCWktyMzF2TXRDVzZKOUMrTGRaVGo2Y1ExZElROUNiMTlyTGl2?=
 =?utf-8?B?YkVrbXBOdTVDbXNKZHphS25MdEFBZnV3YWpNWmU0c2JhaUludG52VGtvZE5N?=
 =?utf-8?B?Z1RxU3d6UklBeGdETG8wbFc0VmRZUnhRSzBjV3ZROWhOeXk2d1NSVUNaYXNZ?=
 =?utf-8?B?QkliOVdsVHJvVjl2bkNUWG5Da3NKUWRyTHlLanhsM3JPUWpJWUREdFhaaExD?=
 =?utf-8?B?SC85OC9uRjdlTVRzTytpSEJpQXZXbTI0Tjh3L3JadGRsTG1OaStwNVU1SFJP?=
 =?utf-8?B?NGNwUURaMzUxUlJuaHhITThmcGczbXJodDhVc2FQREtGcEZjMkZyTUI2Y3l4?=
 =?utf-8?B?cHkvNjBNZHVtRFhGUlhUallaM1plYXVYZjNzTm53QWJPd3hQa2haeEp5Q1JN?=
 =?utf-8?B?WElyNmFHd0F6TVlQT1dsK0U4Wmt0bFFVM1NLblBDb21TQTMweVJHblJtelRu?=
 =?utf-8?B?ejk5SDk4MlZKRVlOVzkvVUFTT0tlOWFhU2toQ2NiZGg2WWZuWmpkeWt0T3No?=
 =?utf-8?B?UE1aVW84NFdYcGZuT3F2YUllVGhDaVNOTFNqcmdlTFZaWElZclV3c2NrR2NN?=
 =?utf-8?B?bWN6R1ZLKzVmTEFjUkNCbEorS1NmSW1ZUWp0bHIvVHBTc3pTaFhpaS82ejhJ?=
 =?utf-8?B?eVcwZ2l1aEdUbkVnczMxWjUvZUptMEcrRk5yWUp6TnAyeW94elkxTytwNDBS?=
 =?utf-8?B?VFBqVXVTSjB6bVQzQzlVQW9MemxwM1d4SFZsWTNnN3R0OCtPVzVHYkVBcmJh?=
 =?utf-8?B?d0lBY2RXY085TTU0Z2doYW5YUXV0ejF5OEpsd2ZBSnJuTUk5b2Q5WXczN0FG?=
 =?utf-8?Q?QaZa842iSIjclXwsYWbY4ctqN?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7620e753-81af-4bee-c1fd-08dd4f2112e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 07:02:42.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaDXp5jtRaHUjt27/ux587B28QabNTQrLC05846YzC21giYxugVaDFGgb0ESNVMzAcue0L2oLtuEFitOnlW89ipCNZnisawFrpuXTJaAxV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7885
X-Proofpoint-GUID: dAgT-GMRIyn1MVGHnkh-_zlDMTR0OA7O
X-Proofpoint-ORIG-GUID: dAgT-GMRIyn1MVGHnkh-_zlDMTR0OA7O
X-Authority-Analysis: v=2.4 cv=epUlzppX c=1 sm=1 tr=0 ts=67b2df14 cx=c_pps a=UnxCF3xIguukyKwtQsEHPg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=udXclQch7WkA:10
 a=gAnH3GRIAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=taAdssNnAwCDzfPkeqsA:9 a=QEXdDO2ut3YA:10 a=VPLJHTN0Tl0A:10 a=PnwojhMqxeMA:10 a=oVHKYsEdi7-vN-J5QA_j:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170060

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgRmVicnVhcnkgMTUs
IDIwMjUgNzoyMiBBTQ0KPiBUbzogTnVubyBTw6EgPG5vbmFtZS5udW5vQGdtYWlsLmNvbT47IEpv
bmF0aGFuIENhbWVyb24NCj4gPGppYzIzQGtlcm5lbC5vcmc+DQo+IENjOiBQYWxsZXIsIEtpbSBT
ZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29tPjsgQmFydG9zeiBHb2xhc3pld3NraQ0KPiA8
YnJnbEBiZ2Rldi5wbD47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2Yg
S296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0
QGtlcm5lbC5vcmc+OyBsaW51eC0NCj4gZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
aWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDIvMl0gZ3BpbzogZ3Bpby1hZGcxNDE0OiBOZXcgZHJpdmVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+
IA0KPiBMZXQncyBjaGVjayB3aXRoIEpvbmF0aGFuIENhbWVyb24gKElJTyBtYWludGFpbmVyKSBv
biB0aGlzIGFzIHdlbGwuDQo+IEhlIG1pZ2h0IGhhdmUgaWRlYXMuDQo+IA0KPiBGb3IgcmVmZXJl
bmNlLCB0aGUgZGF0YXNoZWV0Og0KPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3Rl
Y2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtDQo+IHNoZWV0cy9hZGcxNDE0LnBkZg0KPiANCj4g
KEJ5IHRoZSB3YXk6IGFkZCB0aGUgZGF0YXNoZWV0IHRvIGEgc3BlY2lhbCBEYXRhc2hlZXQ6IHRh
ZyBpbiB0aGUNCj4gY29tbWl0IHBsZWFzZSEpDQo+IA0KPiBPbiBGcmksIEZlYiAxNCwgMjAyNSBh
dCAyOjE34oCvUE0gTnVubyBTw6EgPG5vbmFtZS5udW5vQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4g
T24gRnJpLCAyMDI1LTAyLTE0IGF0IDAwOjI1ICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiANCj4gPiA+IE5vdywgdGhlIGtlcm5lbCBkb2VzIG5vdCBoYXZlIHN3aXRjaCBzdWJzeXN0ZW0g
SSB0aGluaywNCj4gPiA+IHNvIHRoaXMgaXMgc29tZXRoaW5nIGxpa2UgYSBzcGVjaWFsIGNhc2Us
IHNvIHdlIG1pZ2h0IGJlDQo+ID4gPiBjb21wZWxsZWQgdG8gbWFrZSBhbiBleGNlcHRpb24sIGlm
IHRoZSB1c2VycyB3aWxsIGFsbCBiZSBpbg0KPiA+DQo+ID4gRXhhY3RseSwgc2luY2Ugd2UgY291
bGQgbm90IGZpbmQgYW55dGhpbmcsIHRoZSBiZXN0IGZpdCBzZWVtZWQgbGlrZSB0aGUgZ3Bpbw0K
PiA+IHN1YnN5c3RlbS4gSSB3YXMgdGhlIG9uZSBzdWdnZXN0aW5nIGl0IHNpbmNlIGEgbmV3IHN1
YnN5c3RlbSBmb3IgYSBzaW1wbGUNCj4gZGV2aWNlDQo+ID4gbGlrZSB0aGlzIGxvb2tlZCBleGNl
c3NpdmUuIElmIHdlIGhhZCBtb3JlIGRldmljZXMgdGhhdCB3b3VsZCBmaXQgc3VjaCBhIGNsYXNz
DQo+ID4gb2YgZGV2aWNlcywgbWF5YmUgaXQgd291bGQgbWFrZSBtb3JlIHNlbnNlIHRvIHN0YXJ0
IHRoaW5raW5nIG9uIHN1Y2ggYQ0KPiA+IHN1YnN5c3RlbT8NCj4gPg0KPiA+ID4gc2F5IHVzZXJz
cGFjZSBhbmQgbWFrZSB1c2Ugb2YgdGhpcyBzd2l0Y2ggZm9yIGZhY3RvcnkgbGluZXMNCj4gPiA+
IG9yIHNpbWlsYXIuDQo+ID4NCj4gPiBLaW0gc2hvdWxkIGtub3cgYmV0dGVyIGFnYWluIChhYm91
dCB1c2VjYXNlcykgYnV0IEkgd291bGQgYWxzbyBhc3N1bWUgdGhpcw0KPiBpcw0KPiA+IGZvciB1
c2Vyc3BhY2UgdXNlLg0KPiANCj4gQWN0dWFsbHkgdGhlIEdQSU8gZG9jdW1lbnRhdGlvbiBEb2N1
bWVudGF0aW9uL2RyaXZlci1hcGkvZ3Bpby91c2luZy0NCj4gZ3Bpby5yc3QNCj4gZXZlbiB0YWxr
cyBhYm91dCB0aGlzIGZvciB1c2Vyc3BhY2UgdXNlIGNhc2VzOg0KPiANCj4gIlRoZSB1c2Vyc3Bh
Y2UgQUJJIGlzIGludGVuZGVkIGZvciBvbmUtb2ZmIGRlcGxveW1lbnRzLiBFeGFtcGxlcyBhcmUN
Cj4gcHJvdG90eXBlcywNCj4gZmFjdG9yeSBsaW5lcywgbWFrZXIgY29tbXVuaXR5IHByb2plY3Rz
LCB3b3Jrc2hvcCBzcGVjaW1lbiwgcHJvZHVjdGlvbiB0b29scywNCj4gaW5kdXN0cmlhbCBhdXRv
bWF0aW9uLCBQTEMtdHlwZSB1c2UgY2FzZXMsIGRvb3IgY29udHJvbGxlcnMsIGluIHNob3J0IGEg
cGllY2UNCj4gb2Ygc3BlY2lhbGl6ZWQgZXF1aXBtZW50IHRoYXQgaXMgbm90IHByb2R1Y2VkIGJ5
IHRoZSBudW1iZXJzLCByZXF1aXJpbmcNCj4gb3BlcmF0b3JzIHRvIGhhdmUgYSBkZWVwIGtub3ds
ZWRnZSBvZiB0aGUgZXF1aXBtZW50IGFuZCBrbm93cyBhYm91dCB0aGUNCj4gc29mdHdhcmUtaGFy
ZHdhcmUgaW50ZXJmYWNlIHRvIGJlIHNldCB1cC4gVGhleSBzaG91bGQgbm90IGhhdmUgYSBuYXR1
cmFsIGZpdA0KPiB0byBhbnkgZXhpc3Rpbmcga2VybmVsIHN1YnN5c3RlbSBhbmQgbm90IGJlIGEg
Z29vZCBmaXQgZm9yIGFuIG9wZXJhdGluZyBzeXN0ZW0sDQo+IGJlY2F1c2Ugb2Ygbm90IGJlaW5n
IHJldXNhYmxlIG9yIGFic3RyYWN0IGVub3VnaCwgb3IgaW52b2x2aW5nIGEgbG90IG9mIG5vbg0K
PiBjb21wdXRlciBoYXJkd2FyZSByZWxhdGVkIHBvbGljeS4iDQo+IA0KPiBJZiB0aGlzIGlzIHRo
ZSB1c2VjYXNlLCBsaWtlIGNvbnRyb2xsaW5nIGFuIGV4dGVybmFsIHN3aXRjaCBmb3Igc3VjaCB0
aGluZ3MsDQo+IHVzaW5nIHRoZSBHUElPIHN1YnN5c3RlbSBtaWdodCBhY3R1YWxseSBiZSByZWFz
b25hYmxlIGluIG15IG9waW5pb24sDQo+IChldmVuIGlmIHRoZSBEVCBiaW5kaW5ncyBlbmQgdXAg
aW4gdGhlaXIgb3duIGNhdGVnb3J5KS4NCj4gDQo+IElmIHRoZSBzd2l0Y2hlcyBjb250cm9sIHN0
dWZmIHJlbGF0ZWQgdG8gY29tcHV0ZXIgbWFjaGluZXJ5IChpLmUuIGludGVncmF0ZWQNCj4gaW50
byBhIGxhcHRvcCB0byBzd2l0Y2ggb24vb2ZmIHRoZSBmYW5zLi4uKSB0aGVuIG5vLiBTbyBpdCBk
ZXBlbmRzIG9uIGhvdw0KPiBhbmQgd2hlcmUgaXQgd2lsbCBiZSB1c2VkLg0KDQpJbiBteSBjYXNl
LCB0aGlzIGlzIGEgdXNlcnNwYWNlIHVzZSBjYXNlLiBUaGUgQURHMTQxNCB3YXMgdXNlZCB0byBj
b250cm9sIHRoZQ0KQURNRk0yMDAwIE1pY3Jvd2F2ZSBEb3duY29udmVydGVyIGRldmljZS4gQWNj
b3JkaW5nIHRvIHRoZSBBRE1GTTIwMDANCmRhdGFzaGVldCwgaXQgcmVxdWlyZXMgY29udHJvbCBv
dmVyIDE0IGRpZ2l0YWwgcGlucywgd2hpY2ggY2FuIGJlIHNldCBoaWdoIG9yIGxvdyBbMV0uDQpX
aGlsZSB0aGVzZSBwaW5zIGNvdWxkIGJlIGRpcmVjdGx5IGNvbnRyb2xsZWQgdXNpbmcgR1BJTywg
dGhlIGV2YWx1YXRpb24gYm9hcmQgZm9yDQp0aGUgQURNRk0yMDAwIGlzIGRlc2lnbmVkIHRvIHVz
ZSB0aGUgQURHMTQxNCBzd2l0Y2ggZm9yIHRoaXMgcHVycG9zZSBbMl0uDQpBREcxNDE0IGlzIGFu
IFNQSSBjb250cm9sbGVkIHN3aXRjaCB0aGF0IGFsbG93cyBzd2l0Y2hpbmcgb2YgdGhlc2UgZGln
aXRhbCBjb250cm9sIGxpbmVzLg0KDQpUaGVuLCBJIGhhdmUgYSBjdXN0b20gdXNlcnNwYWNlIGFw
cGxpY2F0aW9uIHRvIGFjY2VzcyBzeXNmcywgd2hpY2ggaW4gdHVybiBjb250cm9scyB0aGUNCkFE
RzE0MTQsIHByb3ZpZGluZyBzcGVjaWZpYyBmdW5jdGlvbnMgZm9yIHRoZSBBRE1GTTIwMDAuIFVz
aW5nIHRoZSBHUElPIHN1YnN5c3RlbQ0KdG8gaW50ZXJmYWNlIHdpdGggdGhlIEFERzE0MTQgcGVy
aGFwcyBhIHByYWN0aWNhbCB3YXkgdG8gbWFuYWdlIHRoZXNlIGNvbnRyb2wNCnNpZ25hbHMuDQoN
CkluIG15IG9waW5pb24sIHVzaW5nIHRoZSBHUElPIHN1YnN5c3RlbSBmb3IgdGhlIEFERzE0MTQg
bWF5IGJlIGEgYmV0dGVyIG9wdGlvbg0KZ2l2ZW4gdGhlIGludGVuZGVkIHVzZSBjYXNlLiBIb3dl
dmVyLCB3aGF0IGRvIHlvdSBzdWdnZXN0IG9uIGhvdyB0byBwcm9jZWVkPw0KDQpbMV0gaHR0cHM6
Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRhLXNo
ZWV0cy9hZG1mbTIwMDAucGRmDQpbMl0gaHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9lbi9yZXNvdXJj
ZXMvZXZhbHVhdGlvbi1oYXJkd2FyZS1hbmQtc29mdHdhcmUvZXZhbHVhdGlvbi1ib2FyZHMta2l0
cy9ldmFsLWFkbWZtMjAwMC5odG1sI2ViLW92ZXJ2aWV3DQoNCkFsbCB0aGUgYmVzdCwNCktpbQ0K
DQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K

