Return-Path: <linux-iio+bounces-7418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E2E929A3D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 01:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7442F1F212FE
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A46F079;
	Sun,  7 Jul 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CEt2xUbw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A32524F;
	Sun,  7 Jul 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720395029; cv=fail; b=JAfpu7UbIKFD2NDZQdbQEK0+t0KK0fkJP9yFQVJcqr92FPRbTroobLS8A5fCqDOf2p4EhcRawpIHrYBAayDaFcQy75/3jP5XKzQ8U51CvXOxunYoaEO8M5pPGjTcxqTEKtfygy1YBHkRvk3ih7xVdnTFgMheLT1McuWZA3G79Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720395029; c=relaxed/simple;
	bh=uU3eXlpUo4mea9Zh3V2UfYix0SAoF62t+HSzjSS2CRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c3LqARbWBU5szlgBeBVpmwSW9u3GEuAoWe6Bl+CNLiAKwWL1PM20V35g3yvY3s1Y3iIGeG18cuoTgSGEzsz1BWhYUxH1q4HsyM0Zfrs7333+F8914QazIiZT4kYNmmEzViDWZCv8y0Y0zg0iqGWl17AuYmZOywfj0HYGhhvgeOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CEt2xUbw; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4678vbSL014726;
	Sun, 7 Jul 2024 19:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uU3eX
	lpUo4mea9Zh3V2UfYix0SAoF62t+HSzjSS2CRc=; b=CEt2xUbw/qYTFRGP4tT/p
	9JQveuaPkSPtYmZzqLjoCgwcPmh6SgiOclNg0cFLXhXb/qcwUSEOpyzxsUTeUmqc
	/yC7HVLNVwuLjBldMVmP8Jz3vzC5SAXwpW7m7n0IVvrtm2K+kUkIMjdVJiqrdUxA
	UeFMVxN65qIQUx3y8JBCcxJbbrvuTW72KBudTu4MsZzm+8IItMN5wO2CI7/3k2Hl
	f4tJSI5qXzCPMZN42CdN0czRbqSLyU1hVE/HpaDwppV7JBsEaF/HxNgYBrFHct62
	zkwjAvflzijEXD6UCfey+2S8YjbIxw8oFfDun6vOjnfZkC+a2ENCUttrFi+SherV
	Q==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 407qyf16b0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 19:29:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdsvgT4cEJCHRcTBHms9S+MSeLOxs6K5BeOxNiS2J0WEU4WlXpRcRJKul2erxOJOhWbBJW119F8+BY1gbHnxvghAGywwkzLsJT+Ow/2NGXc1XzgRdCRLG9+tWjmRyQXM3vr4qZr0jDRJo0PoQ1/U7WpP6u7nd0nk1fUCgqa5XFP1qZiYg2+FVEUJFarP73wB6dASquwuCn4HW3CFhLJdMUnIv0dCiB5oPqNWXstN136GXxBgExHj9ERgh8yvgs22sxaeUUrSDhjW6EHuMVntrC2pcnNcfgn/c0GHryi2X3ZqbsIarTprgooz7kHZIPCydbonSJu2i+Rldhaf6cY7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU3eXlpUo4mea9Zh3V2UfYix0SAoF62t+HSzjSS2CRc=;
 b=mI+B3CthEVUwU5mQ8c/3nXnvBiuSTgreobNC5ELv2MQOzhAlKLmj0qClwJ4G0mDptnFA2JQzZZur9/ITyi0rHS9PteZp4numXDAFymvVuveRsPPCAyS2VUgsiFa1+u279TA5eBH4R9eh9jlE8ELGbAg7JCpb2MKFoH9QBE5Nu3tJzqQt+kcYMNz4qvLU1EaHlD65HIBTC8zUKXTP8YK8BJkIGDHqlbRixJZSf0pKYkNzC3Nbs7TYxUZiyu8vd3dfaAgeBWhSQlR1+flJMzrEUtAhyveuvvk7p8ylarUkRleBZfnuC9UDL3FV3ImtnkZoQAkP08Qo3CxK0mZdQgo6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DM8PR03MB6213.namprd03.prod.outlook.com (2603:10b6:8:39::15) by
 SJ0PR03MB5695.namprd03.prod.outlook.com (2603:10b6:a03:2d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.34; Sun, 7 Jul 2024 23:29:44 +0000
Received: from DM8PR03MB6213.namprd03.prod.outlook.com
 ([fe80::b2a3:6794:84a4:b6b1]) by DM8PR03MB6213.namprd03.prod.outlook.com
 ([fe80::b2a3:6794:84a4:b6b1%6]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 23:29:44 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH 0/2] add AD8460 DAC driver
Thread-Topic: [PATCH 0/2] add AD8460 DAC driver
Thread-Index: AQHaov/UvoT4VTfrXk2cjEw93f8nFLGSOK2AgERdG9CABzlaAIAOdPrQ
Date: Sun, 7 Jul 2024 23:29:43 +0000
Message-ID: 
 <DM8PR03MB62132D6B31F23A7E8406EC4591D92@DM8PR03MB6213.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<CAMknhBHd2XCJH4rgYDq=vbCL5E_tM3FxFPWbNy9PvxLCJL4tcA@mail.gmail.com>
	<20240511172155.08bc0987@jic23-huawei>
	<SJ0PR03MB62242BD5117C5B2026CCC5D191D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
 <20240628193954.2f3dfc55@jic23-huawei>
In-Reply-To: <20240628193954.2f3dfc55@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzEwYVc1aFkyOWNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MWpOalpqWXpjNU5DMHpZMkk0TFRFeFpXWXRPR014?=
 =?utf-8?B?WkMwM05EQTBaakUxTWpOalpUaGNZVzFsTFhSbGMzUmNZelkyWTJNM09UWXRN?=
 =?utf-8?B?Mk5pT0MweE1XVm1MVGhqTVdRdE56UXdOR1l4TlRJelkyVTRZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJMk1qTTRJaUIwUFNJeE16TTJORGcyT0RVNE1EYzFNak0yTkRV?=
 =?utf-8?B?aUlHZzlJbmhGVWs1eFUwSXZlSE16UlhKYWRtRlJjVWR0TW1ORmF6TXlPRDBp?=
 =?utf-8?B?SUdsa1BTSWlJR0pzUFNJd0lpQmliejBpTVNJZ1kyazlJbU5CUVVGQlJWSklW?=
 =?utf-8?B?VEZTVTFKVlJrNURaMVZCUVVSblJFRkJRVGxXTUVkTGVHUkVZVUZtYlZObVYw?=
 =?utf-8?B?UllXR0pUTHl0YVNqbFpUbVJrZEV3NFJFRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGSVFVRkJRVVJoUVZGQlFWTm5TVUZCVHpSQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZGUVVGUlFVSkJRVUZCTTB4b1UyWm5RVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlNqUkJRVUZDYUVGSFVVRmhVVUptUVVoTlFWcFJRbXBCU0ZWQlky?=
 =?utf-8?B?ZENiRUZHT0VGalFVSjVRVWM0UVdGblFteEJSMDFCWkVGQ2VrRkdPRUZhWjBK?=
 =?utf-8?B?b1FVZDNRV04zUW14QlJqaEJXbWRDZGtGSVRVRmhVVUl3UVVkclFXUm5RbXhC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIwVkJXa0ZDY0VGR09FRmpkMEpz?=
 =?utf-8?B?UVVkTlFXUlJRbmxCUjFWQldIZENkMEZJU1VGaWQwSnhRVWRWUVZsM1FqQkJT?=
 =?utf-8?B?RTFCV0hkQ01FRkhhMEZhVVVKNVFVUkZRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZCUVVObFFVRkJRVmxSUW10QlIy?=
 =?utf-8?B?dEJXSGRDZWtGSFZVRlpkMEl4UVVoSlFWcFJRbVpCU0VGQlkyZENka0ZIYjBG?=
 =?utf-8?B?YVVVSnFRVWhSUVdOM1FtWkJTRkZCWVZGQ2JFRklTVUZOWjBGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkNRVUZCUVVGQlFVRkJRVWxCUVVGQlFVRlBORUZC?=
 =?utf-8?B?UVVGQlFVRkJRVU5CUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUZCUVVGblFVRkJR?=
 =?utf-8?B?VUZCUVVGQmVtZEJRVUZCVFVGQlFVSlBRVUZCUVVGQlFVRkJSMFZCV2tGQ2NF?=
 =?utf-8?Q?FGOEFj?=
x-dg-rorf: true
x-dg-refone: 
 d0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCbUFHRUFiQUJ6QUdVQVh3Qm1BRzhBY3dCcEFIUUFhUUIyQUdVQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFESUFBQUE9Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6213:EE_|SJ0PR03MB5695:EE_
x-ms-office365-filtering-correlation-id: ef216c2f-4033-42af-a38b-08dc9edcaea9
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Rk9KQWpYSG9ZK1dIcEd6Y2cySFpSUC9Qbmdkei9YYkU5dWFGMndoRkJia2JE?=
 =?utf-8?B?dCtQVmJBSHdLVlhjKzlFbWZEYVNkTTdDK2wrS3A4ZTRiWkZzbkw4L2MrYzVP?=
 =?utf-8?B?SGxNem9TY2JhTjhkRGZQR0sxWE8xZVNYZHpTRzN1UnBGdDFDSlVxUmRNYys0?=
 =?utf-8?B?RWZZTEJZeVZLQzZ3MkY1QVdWRFdSOFNMRTJac2dRUk1FSCtMSUhtcEJJWllV?=
 =?utf-8?B?YlZLRjBRNmNZcStuVEFrQ05jb25QT2c1Zm80M0llMmZRVDRIU2JqSy91TDFB?=
 =?utf-8?B?Zk83NzJhYTlZNG9EZ2dDZ1gvZ1p2ckozWG55U0lVanBwRFFxNUF5aHowU0xI?=
 =?utf-8?B?M1UrVEl0Z21ibDBEbC9YVTdHbVRkazY4amRjSFZ4Mlprd3VuamdjVU1rakxZ?=
 =?utf-8?B?ZzBiMm95aXNIYllSaUV0ZFhiZ3R1NWZHWHlIaE9WTUg5UUxScitGMHlzS3p6?=
 =?utf-8?B?dGxFelJZZ2I3N2pMUWl0NDRubkJoTjhGRE0weGhoVjdrZlRLRWYwTExUY3dr?=
 =?utf-8?B?c0RwMGV5Q0dFL1VJSVEwL0dvbEhTMmFBcVZSb2dMVE9hYVJ0L0pRbkg0N3RG?=
 =?utf-8?B?MVhkVm5qTXhzeW1VNFlXNlRraE1DeFdNYXNXTHZOK3UzbUhNQTM4dC9OeldM?=
 =?utf-8?B?Qkg3NWIyd24zaDRXdkluelVTNEY4aXJyVkJkMEdUVW0rZDlWaWhZbTZOK2RZ?=
 =?utf-8?B?Zk5EbUZsQVZCRGkzaTREdFJ4VXZ6enlST3NUaXhWS3pGdThSQ3dLSGUyY2Jv?=
 =?utf-8?B?Mll0ajBxaGxuQThCUlUvM2I5QkFWeXVpS2RKYVltSUJNM0wzWFlveVp1TEFa?=
 =?utf-8?B?SHlDMVo2UCtYVkMvSHFac293Nk1zZXMyVHZ1Z2dZS0dBdWtHL0REVityNWFs?=
 =?utf-8?B?Mmw1Y0wrMU53WVZabm5rdTgzZ3UyRmtyQW5GNks4M0tnSUx3MUN4d3VDc24w?=
 =?utf-8?B?aVRHckZjaGp5anBpSVRXd2drWUhxQ29GV29LTjJIWDVvMWl6VXJ6VFltVFlW?=
 =?utf-8?B?eGp6NGFITitRalBuTG5sS0NHemdWejJKcE9tc01wWVBDWjE0YlYvdmo1THZ0?=
 =?utf-8?B?MzI2Y2EzOGhNRlJsR3RtQlFxQmlUOGJTZGcvUDFYMVNjblU3VW1nOUhNYW1D?=
 =?utf-8?B?dWdVdStvY0JWUHVOTWNBeVVaU3kxY09HRndEanBqME5vTlBnR1FsbHJJTjNH?=
 =?utf-8?B?TFJwRHRRNXl5YjI5ZG54VmRGMksrRmlreXJFRnVNNkFZVm5oOE9ERys1UTh4?=
 =?utf-8?B?aWgwT0RPS3NraUhLRkVkdi85VUJ0djFlbmQ5Mm8wTFVaeE92clRFcVhiYmJQ?=
 =?utf-8?B?YWVlalBZdDUzNTMvbUEvV0M3cXA3d25BRVBVWDN5RzB6b0k3WEVoTmYvVVZF?=
 =?utf-8?B?eGNVckJXWTMySWR6cXluM0RMQ0NsdjVVZkJNR2JSa3JCWUFxYjFHUm9DeTlI?=
 =?utf-8?B?ckxGeUg0VU5RQnJ0VTlFMnIzdEtLUWYveTZKT0pkNTZLK1FwbG83NEVtaGt3?=
 =?utf-8?B?UFJQZm9xLy91UUtWMkR5YWxLK0dnUis1Z0ppT3U1WFRFcnl0QXZOalhEYWhM?=
 =?utf-8?B?dzJvOUtTdDBKSFlQMkdSVFZWd2o2Y0xRMnhlZFdZZld0RkczcFJjWUQxTm5W?=
 =?utf-8?B?N0JLalAyeFFrd016T3RMczZhalNSRlE4TjdsTjkvMnZoM0V3aEQxK0REQTZ6?=
 =?utf-8?B?NjZEUERuWTFXRUhEZ2hxTzJSN2xKNW5Eb2RVNURQajhOb1Z2S1R1cmw5bGhy?=
 =?utf-8?B?Ly9meTJFSGJmSUVUdEtYNVZRT0xoeUdyUkxPNUx5eXY5VjkyRFpVb3FvMGxn?=
 =?utf-8?B?QVRTc2YvdXU3eWtJTDFNOHdjUVV1eEVCUmtXVjVYWWlHb2VBazF6UFVQNTc3?=
 =?utf-8?B?VDhIUEcxZmc1a2orRFFGUEJJNS9ORUxRZllydTN4NlZDUnc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6213.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S3VHa2V0OWNUZEN2S1JpaTRabi9VL3VGQUtua0RsSmxlekxKM2FVaTBzcTdF?=
 =?utf-8?B?eUN3c1k3UVQyYmhPQnUxQ1Vyb2Z2SGJZb1RHS2lTTGxNMFlsMVhuVmMyMTJh?=
 =?utf-8?B?TWJsRkFUcHd5MzFvSmZ6K2FDT1RiL1ZRT3VKQUttNjdRTVk2dG1tUlFtNzdB?=
 =?utf-8?B?N1hnQUYrdVVjU21vaEpVcURtNzh3aGZUL1dQRHdYZE0rejN6NWlaSFRaUUYw?=
 =?utf-8?B?bnZlY0tkWk1QNUNmV284cUdWMEYyY0VHQ3RFSno5WEFuUVgzd09YS3ZFRXRX?=
 =?utf-8?B?Nk9RU09IVWVSQlFIWXVOVHBZTlhzZGZaY0I0UHk4RjJsOE1xR3BiUTFMUDIz?=
 =?utf-8?B?TjI5NHRLeE9MbURuTlQvbUVDV0g1KzZNbWYremNSOG11ZksvbCtNakg1Q1Bv?=
 =?utf-8?B?czhUVVN2TldwcGpUdVZYZWdDQ2xyWkcxQVhjUzVuZjdRUFpZVHdsTU5XUEVO?=
 =?utf-8?B?bVpLREhpeTIzRWRSWno4bC95Yk9xZEVZamtWSEpyOTlBVWVRSjZhN2IwTTBG?=
 =?utf-8?B?Ti9pVmFhcWRpSW5XTFV4VUdEaHpTclpuMnFOSk82czcxZUZ0cTdubTZTMUZG?=
 =?utf-8?B?MnQ0N2hHaWdET1lHOWlEMmxnVVUzd0h6OTVjOE5WbUNXdFBlczJ5cURqRGNx?=
 =?utf-8?B?SW1sRzMvcWh5bmFCTW81OEZyOCs5bVNIcDdPZ2RpeTNGREJJdENsZ3k1a3Z1?=
 =?utf-8?B?R1FIM0hKMlpjRUhsSlhKci9vNFpPNHhnWHNsUFVyaHdqVW1oZE5WYjNYMDZP?=
 =?utf-8?B?aitKZXI3QktCTzRPQUlTZ05ieGZTRGFKa1I1R2IzVWtmYmZBK2IvU3h3L3Q0?=
 =?utf-8?B?d3F3NHJ4bDV1RXhnRVJoV1Bwb0hSWUFTeFJsWE9RNG8zeTFEcHo2Kys3MXNz?=
 =?utf-8?B?cHI1d3NLTy9rVC9pUUp6elhEczFZdjJLQXg5eXduLzRZcWkxa3JvUStsN1VH?=
 =?utf-8?B?MWkvY3B5TXJFaGhGVWd2VmN1ak5LSG9IS1cydWNnS2pCQXBjUmFKc0VMaVNa?=
 =?utf-8?B?c2JpZUNCYjlYZHhzYXpleDk0ZGhPMGx1SlJEQjhkbjQ2VGY0dVNodlY4MGZE?=
 =?utf-8?B?a1R5bGgxd2tScCt1S3c1WDFhZDhWSDVCOHZNZEdHVDdiSUVTRG5vdmNLTUdL?=
 =?utf-8?B?ckpxVmpZU0RiY3lCeUh4dTE0QlZuNHpsSXNjVHlMZDVyNlByWWJPOFd1NFRT?=
 =?utf-8?B?QlZTNjdoY3hZYTZHSmFFZndXNzdabjNNWHhaalR2REUrZWRCbzA0OTV4c09S?=
 =?utf-8?B?OWt2UldoY3I3U0s1S2NQUUJRb2ZuNHlJS01SVThwVFZ5TG9tOUU3ZzZNN1U1?=
 =?utf-8?B?K1pVV3NzNVVVR1VEVXlJVmhRS2p4RWRBZDJUMlh5bEtlUldFS0Y1TkMvSmZG?=
 =?utf-8?B?a1I3cEJlT3F2UmoyelpodkNJWVBJRlpUeG9jYmNVRG55MktmMGREcXNxdHRF?=
 =?utf-8?B?ODZOTTgzdzNCU01waFV0ejFHaXpUUWZCdG1wMWo2TkZOL3hBYS9rZlZYOEI5?=
 =?utf-8?B?OEIya2hFd01BNzdFTHBQUmVyN3RMU0N5aGlSYjZLZDNuRGlsS0YzbVROejQ3?=
 =?utf-8?B?WXNvWmRIU3M3UnpEVFZTQnJaK0hiTWJlcE9jZTFUVTIyWFhuMXYrL2VnVGtF?=
 =?utf-8?B?UC9qN2owMUFiaXlhNjNiTW1aVHdTL2pJajJJaktRU2ZWSEhGRjlYdDBLamta?=
 =?utf-8?B?MHJzMVVBczFRNmpiSE9lNjhJYUF4U2Y2alNMeldOTWQ0YnVSanE4RFFuZ0FP?=
 =?utf-8?B?SFBTNXRsSWQwdUdVcXMvV3B0MUlhMUthMUZJRnNLbm0xcjhiZzk1K0RjUVJT?=
 =?utf-8?B?MEIwM0pIbnZhSUZ3TkhUSFRSSndJcTF5MTNKWGFwWWYwci9aK2NMWDB0cHBm?=
 =?utf-8?B?Yk5IbHZmSGhVdDhrZ2tBcDBRWFJiYytOcTVoTDZXbU9GYU45OVVOY3dvYzlz?=
 =?utf-8?B?U1RPd0RudGdvbW54cjdFbTc0WHJ1WDlwbnRKc016aUcxT1lhTE5NUFo5NEha?=
 =?utf-8?B?N0dnenZROUdwcHlTbFp6L2I0WG8weGJlc1M2S0x3U1ptT0FVK1g2alZIT2Mz?=
 =?utf-8?B?RlhkV2d6R0lycThRZW5wOEJMeGw0TTlmdjFGcC9aL1o1dThXY0pGVG9vRWkx?=
 =?utf-8?Q?6dpBPhHW6yaIKGldWuf+jTl/t?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6213.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef216c2f-4033-42af-a38b-08dc9edcaea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 23:29:43.9964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjF/asSzTaOd4sOpAK7cX+SemBK9cXRorqvb2CdpPcYuv7K8QKI15r4Cof4Fvp4sLeZALDD3sITSXVHgjvvfxjkj5gQcPPspSpX8snpH+9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5695
X-Proofpoint-GUID: 6R4S16ySIQ7F97aDGihU41t4DrEOgmLs
X-Proofpoint-ORIG-GUID: 6R4S16ySIQ7F97aDGihU41t4DrEOgmLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407070196

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgMjksIDIwMjQgMjo0
MCBBTQ0KPiBUbzogVGluYWNvLCBNYXJpZWwgPE1hcmllbC5UaW5hY29AYW5hbG9nLmNvbT4NCj4g
Q2M6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IGxpbnV4LWlpb0B2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPGxhcnNAbWV0YWZvby5kZT47
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxr
cnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBM
aWFtIEdpcmR3b29kDQo+IDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgTWFyayBCcm93biA8YnJvb25p
ZUBrZXJuZWwub3JnPjsgSGVubmVyaWNoLA0KPiBNaWNoYWVsIDxNaWNoYWVsLkhlbm5lcmljaEBh
bmFsb2cuY29tPjsgTWFyY2VsbyBTY2htaXR0DQo+IDxtYXJjZWxvLnNjaG1pdHQxQGdtYWlsLmNv
bT47IERpbWl0cmkgRmVkcmF1IDxkaW1hLmZlZHJhdUBnbWFpbC5jb20+Ow0KPiBHdWVudGVyIFJv
ZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBhZGQg
QUQ4NDYwIERBQyBkcml2ZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiA+ID4NCj4gPiA+
ID4gPiAgICogUHJvZ3JhbW1hYmxlIHF1aWVzY2VudCBjdXJyZW50IChvcHRpb25hbCkNCj4gPiA+
IENvdWxkIHByb2JhYmx5IGZpZ3VyZSBvdXQgYSBzdWl0YWJsZSBjb250cm9sIGZvciB0aGlzLCBi
dXQgSSdtIG5vdA0KPiA+ID4gZW50aXJlbHkgc3VyZSB3aGF0IGl0IGlzIDopDQo+ID4NCj4gPiBU
aGlua2luZyBhYm91dCBpdCwgd291bGRuJ3QgdGhlIHJhdyBhdHRyaWJ1dGUgYmUgYSBzdWl0YWJs
ZSBjb250cm9sDQo+ID4gZm9yIHRoaXM/IFRoaXMgVmFsdWUgaXMgcmVsYXRpdmUgdG8gbm9taW5h
bCBzdXBwbHkgY3VycmVudCBhbmQgYWN0cyBhcyBhDQo+ICJtb25vdG9uaWMgYnV0IG5vbmxpbmVh
ciINCj4gPiBtdWx0aXBsaWVyLg0KPiA+IEEgcmVnaXN0ZXIgdmFsdWUgbWFwcyB0byBhIGN1cnJl
bnQgbGV2ZWwgZnJvbSAwIHRvIDIgdGltZXMgdGhlIG5vbWluYWwNCj4gPiBjdXJyZW50IHN1cHBs
aWVkLiBJIGFsc28gdGhvdWdodCB0aGF0IGl0IGNvdWxkIGJlIGhhcmR3YXJlIGdhaW4gYnV0DQo+
ID4gdGhlIGdhaW4gY29tcHV0YXRpb24gd2Fzbid0IGV4cGxpY2l0bHkgaW5kaWNhdGVkIGluIHRo
ZSBkYXRhc2hlZXQgYW5kDQo+ID4gdGhlcmUgaXMgbm90IHlldCAiY3VycmVudF9oYXJkd2FyZWdh
aW4iIGF0dHJpYnV0ZSBhdmFpbGFibGUgaW4gdGhlIEFCSS4gU28gSQ0KPiBzZXR0bGVkIHdpdGgg
cmF3Lg0KPiANCj4gSSBkb24ndCBlbnRpcmVseSB1bmRlcnN0YW5kIHdoYXQgaXMgYWN0dWFsbHkg
Zm9yLCBidXQgYSByYXcgY3VycmVudCBvdXRwdXQgbWlnaHQNCj4gYmUgYXBwcm9wcmlhdGUuDQo+
IA0KPiA+SQ0KPiA+IFRoaW5rIHRoZXJlIHdvdWxkIG9ubHkgYmUgYW4gaXNzdWUgb2Ygd2UgZXhw
b3NlIHRoZSAicHJvY2Vzc2VkIg0KPiA+YXR0cmlidXRlICBCZWNhdXNlIGl0IGhhcyBhIHBhcnRp
Y3VsYXIgY29tcHV0YXRpb24uIEJ1dCBJJ20gbm90DQo+ID5wbGFubmluZyB0byBleHBvc2UgdGhl
ICBQcm9jZXNzZWQgYXR0cmlidXRlDQo+IA0KPiBJcyB0aGVyZSBhbnkgcmVhc29uIHNvbWVvbmUg
bWlnaHQgaW4gZnV0dXJlIHRob3VnaD8NCg0KVGhleSB3b3VsZCBoYXZlIHRvIG1lYXN1cmUgdGhl
IHN1cHBseSBjdXJyZW50IHRvIHNlZSB0aGUgZWZmZWN0IG9mDQpUaGlzIGF0dHJpYnV0ZSwgdGhl
biB0aGF0IHdvdWxkIGJlIHRoZSAicHJvY2Vzc2VkIiB2YWx1ZS4gSSBkb24ndCB0aGluaw0KdGhh
dCB3b3VsZCBiZSBuZWNlc3NhcnkNCg0KPiANCj4gPg0KPiA+ID4gPiA+ICAgKiBUaGVybWFsIG1v
bml0b3JpbmcgaXMgZG9uZSBieSBtZWFzdXJpbmcgdm9sdGFnZSBvbiBUTVAgcGluDQo+ID4gPiA+
ID4gKHVubGlrZWx5IHRvIGJlIGluY2x1ZGVkKQ0KPiA+ID4NCj4gPiA+IElmIHlvdSBkaWQgd2Fu
dCB0bywgdGhlIHVzdWFsIHRyaWNrIGZvciB0aGVzZSBpcyB0byBpbmNsdWRlIGFuDQo+ID4gPiBv
cHRpb25hbCB1c2UgYXMgYSBjb25zdW1lciBvZiBhbiBJSU8gcHJvdmlkZXIgd2hpY2ggd291bGQg
YmUgYSBzZXBhcmF0ZQ0KPiBBREMuDQo+ID4NCj4gPiBJIGluY2x1ZGVkIHRoaXMgaW4gbXkgY3Vy
cmVudCByZXZpc2lvbiwgdGhhbmtzIGZvciB0aGUgaWRlYS4gQWx0aG91Z2gNCj4gPiB0aGUgb3B0
aW9uYWwgdXNlIElzbuKAmXQgeWV0IGF2YWlsYWJsZSBpbiB0aGUgY29uc3VtZXIgQVBJLiBNeSBx
dWVzdGlvbg0KPiA+IGlzLCBpbiBjYXNlIHRoZSBBREMgY2hhbm5lbCB0byByZWFkIFRoZSBUTVAg
cGluIGlzIG5vdCBhdmFpbGFibGUsDQo+ID4gc2hvdWxkIEkgc3RpbGwgbWFrZSB0aGUgdGVtcCBy
YXcgdmFsdWUgYXZhaWxhYmxlIGFuZCBTZXQgdG8gMD8gT3INCj4gPiBzaG91bGQgdGhlIHRlbXAg
cmF3IGF0dHJpYnV0ZSBiZSB1bmF2YWlsYWJsZSBvciB1bmxpc3RlZCBjb21wbGV0ZWx5IGZyb20g
SUlPDQo+IEluZm8uDQo+IElmIG5vIEFEQyBjaGFubmVsIHRoZW4gcmVtb3ZlIGl0IGZyb20gdGhl
IGNoYW5fc3BlYy4gIFRoYXQgcHJvYmFibHkgbWVhbnMgeW91DQo+IG5lZWQgc2VwYXJhdGUgYXJy
YXlzIG9mIHN0cnVjdCBpaW9fY2hhbl9zcGVjIGZvciB0aGUgdHdvIGNhc2UuDQo+IA0KPiBKb25h
dGhhbg0KPiANCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBBZGRpbmcgbXlzZWxmIHRvIHRo
ZSBjYzogaGVyZSBzaW5jZSBJJ20gaW50ZXJlc3RlZCB0byBzZWUgd2hhdA0KPiA+ID4gPiBKb25h
dGhhbiAob3IgYW55b25lIGVsc2UpIGhhcyB0byBzYXkgYWJvdXQgdGhlIGZhdWx0IG1vbml0b3Jp
bmcuDQo+ID4gPg0KPiA+ID4gSm9uYXRoYW4NCg0K

