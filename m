Return-Path: <linux-iio+bounces-24428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658FEB9E339
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 11:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03107B0C26
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0F27B335;
	Thu, 25 Sep 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U0jBN9dn"
X-Original-To: linux-iio@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183A2747B;
	Thu, 25 Sep 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791351; cv=fail; b=b5iS5LmXkbNx0YZ8GJ0SFM43uzt2y+3l4CveVxdd9R2u7woBb6suSL+GncbloUT3fRCJrH9ZjacCtzAEmPmZgNT41Mj0Q2ishQDZBYn5YISnZN8d56WbTRgNSy71JZ/NmvwS7toJgiUk/+xOfd1QjRBDHAiUthz7PYzQoN3//Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791351; c=relaxed/simple;
	bh=seIob0Scfeehkj4n7sVresD2dClCwUQs3bVB66BFkSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IjvBgGCgAODlFHx/OzuXEAGY5lLCWp1aWQ1YMNkVW+jPHE+i7NkcJcYEdazP7x5a8yii9fOW5TAHtXpWYXW5zEOVB5Glc3SLf9B8xp17H7IJwLhayn81oOiYOJrUqsn5CmxuzYakfOej7dwNDL+rA/0tUMDxXZfnZ3SIcAeD94s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U0jBN9dn; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXkKYInQs3i2DiDtY446p3oFr69N2ckUGYYV7pgI5AsGXBM8ptexefV9JEkpg6wivUpd/w+i/E7/jvq1zm858nmXc5DjfrNFTS63f6b1ABZtxeVzowhcL3AWhQRnRsLaXmQlj3/03mw+6AeegbqmUkrSjzTusyP9CEX4RZSzOjOgTeMBQoYnZ6kTAQnDMQxnIIhvrw3l8IQC9JdKLUQs62f7xDyE3bKr/hsn3VjNCJNBoSkQ3Lgi8jqb7Yqfu7AM16vRoUeVB1moZjH5AfzCLozeVvqzuUjB+DbDCrl8yY84wsddW85GmrWCqw5AOukddp/XcluPRyEwAwdjhPrOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seIob0Scfeehkj4n7sVresD2dClCwUQs3bVB66BFkSI=;
 b=tMP/SnToHfwgW1OXdRXIuABITk8fsiqLvQSOskXtckj/bLWum1rxpN+mwktNJLvfV/vdh6NSRJKe2NudLApuqyBS1KXO97CXcfnwabxrRZ76irrTDxnDOTczNCGaxf1i9Y+UFMtvbBa/EPVe8bYNbkMHegJ7sZyW4sH2FuUW0CQisHSzDDFDYF96mbJ6vYnCZ9WEBtCiju8JuFkZW+Q2ahuYQ6+sTB/3UHoSbL/jK4Vy9JzLCMwxjEFDPDY5Q9WkV7Clo+3UViYw5z4TnlP5jn2w6bjl/IzudjynK7ce5HH2FZVQ4ebBlc25Pt21RptQkHNuGuLBtfqrUbJMao6Cng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seIob0Scfeehkj4n7sVresD2dClCwUQs3bVB66BFkSI=;
 b=U0jBN9dn6mUavbfBYmf8y9W96EIstuiqGYAuEkfasWelO3Co8JDUouw6vCbnfRAiTepvKLNwtfP6vYzMwMVNAeToy2rlfUsbWnEtOxHPDve0xOtlo1Mm2nu1X231UB1BA96wyyC7YuWE4LraFzXfioUcTXQPSMUwmhlHNtf8iwW5f205V1MLo/EtEHD9kOopWU+yXlJXNw/VtcSYeZojChRc3GBUeI7hEYtPSENIzgINju8jryjMgH8PB0LRHaReVxYt/+pEULNtfbGgkX+vXIHppb3/b1fdswt+aQwAAfJiEaUVI1EydFZa18tEI94+KJP+q9h8axJPB04RDP9Vvw==
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 09:09:05 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae%2]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:09:04 +0000
From: <Marius.Cristea@microchip.com>
To: <linux@roeck-us.net>, <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <linux-hwmon@vger.kernel.org>,
	<jdelvare@suse.com>, <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH 0/2] Add support for Microchip EMC1812
Thread-Topic: [PATCH 0/2] Add support for Microchip EMC1812
Thread-Index: AQHcJ83I7JlWojZXD0qSt55n2ZNIxLSb9TcAgAWsJICAAgccgA==
Date: Thu, 25 Sep 2025 09:09:04 +0000
Message-ID: <e6ab5becf5908d83857fcfd57823ffd259e6db90.camel@microchip.com>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
	 <20250920123340.1b1d03be@jic23-huawei>
	 <a97486df-9f15-4280-8cb3-d77f4cf223df@roeck-us.net>
In-Reply-To: <a97486df-9f15-4280-8cb3-d77f4cf223df@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6005:EE_|LV8PR11MB8557:EE_
x-ms-office365-filtering-correlation-id: 0b8bc581-c5b7-4c35-493e-08ddfc132cfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmpVRkdWaGE5aXNwTk9UUXVnRjh6cnY3b214WXFlNVJtRi9hNlVyUVFCai9t?=
 =?utf-8?B?dXZrUm1YM3hLdzU1S2Q3bDYwNkVxMElzbjMvWndlY1dhYnVOMi9kZFdWUFJj?=
 =?utf-8?B?UjByQzNSaTh2OE1nby8rc2xOMk93dUJMZDFRK3lkdHFlSmRKWHkxVDBaMHVD?=
 =?utf-8?B?OFBnbmtCY0FNalE3VEt0b3dHL1dDNWhHWEJtbjFOK2hyQklIdzlaVDhCckhy?=
 =?utf-8?B?YW5ncUpFQTdSWStyOUFJRnpjS05jK29BRVdXdERjS3dkdHlaNjI0TGdmZVVt?=
 =?utf-8?B?WmlGbEpHaVl1WUFtTGc1Vm13cHhTRVhCUXBYbnRHejVPWHE0T1BUc01Qblhz?=
 =?utf-8?B?d0FiSDV3MEJheU1sd28reGZHOFRhK1F0bFB5cnpNTmJVM1BpNVRkdDNSaVZj?=
 =?utf-8?B?bGFUWjBld3g4UmZtWkVGUE9IbEtxNVpQM0pQT200c3lzZEpIeXV5REEycklC?=
 =?utf-8?B?cExpMDliemFnTXdHeWdsdEUwcksyemNNZmNNVVJTT2J5WWdXeVFtNEhFTTQ3?=
 =?utf-8?B?Mllyc1NvbnZsMnhOZUN3ZUpPY2Z3anFNcHV0cGtxTE1sR2ZLK1ZDOWdvaUN2?=
 =?utf-8?B?QlNXNXBnTEVmN3c0Wmo4NllIaHVEbmxjUzdCVldnRHErYkNhQ2tLQXNwRFRx?=
 =?utf-8?B?Z1hSMklsazNiTXEva1dTeUVJWmVRYmw3UE1iNU9BY2dKTWlGZHMwc2E3RE5j?=
 =?utf-8?B?YXEzUFpOZWZ1ZjlZNjhOeXh4ZGNiVVFPeXMzMENVdC90ZE1NRWxiY1Qxakhl?=
 =?utf-8?B?aFhITEU2UDUxYVpzVkcyRGpNQm1SMklPeitkQnJ3WHlQNWplTnRJV3lkT1ox?=
 =?utf-8?B?cGRQSGVmZ0J6QVlwRU9hZXV5NStrdVRsZzNUajhTK2RxcW9lRldlc0xMTFlX?=
 =?utf-8?B?SGliTXAvbU01NGkyZzNueE9VQzJNWGpvQ21Pc3FseCs5S2tTaCtXYk43YnJB?=
 =?utf-8?B?Zmc1YkdkSi9kU3pwNUk1TGxteVc1SEZ0eWI4aVU4bUF3R2x3YnkrejM0di90?=
 =?utf-8?B?RlVGYzhJWG85enVFcmd0UmZGZnlpSTdSMUQ1R0FPWm56UmZKbTAyakxSaERZ?=
 =?utf-8?B?dWRueC9LYytrWTUwSi9DTkRqcC9zSDFiTlBSeXhMbEZ1ODVlc2h0WUtTM1JJ?=
 =?utf-8?B?RE41eitwSXNEajFzWFFhTG1GRDYyWnRLeGhmWmhOZnlORDBCZzE2Uy96cFV2?=
 =?utf-8?B?TlRtbzFzQllaeDIrN1FMWkFOQk9ZTlJHeHVGa1lVYVlRSXZXNHBPVmVVOXZV?=
 =?utf-8?B?VkVkbEp3SE9FWm14cGJFdEh4b0pCMkpZMDVyR3c3cDAzRFNOM25DSWYxY2Zw?=
 =?utf-8?B?Vm5RZXFvNGVYNmZqaE9rb09QckNqemJFUU44M0d6WFZrZnljMytzR2NyelU4?=
 =?utf-8?B?UUo0TW9tbEoyQWF4NkVPQ2d2UExLVjhIaHBqSytZZXRVYklRTlI5RlMwdm9K?=
 =?utf-8?B?R0RqTTc5bis0OGRSTjlNV2hpaVFwVjdOYU5rRTlObDlPSmNxNUtXQUVCYUlp?=
 =?utf-8?B?RHFzWmpaUzZ5RGd1RE9Sc013Y2ZqZHBCOWd0eEtHTEZ0NWpsZWlNOEZMMVVj?=
 =?utf-8?B?Sng2QU5DMXVzVDdmM3pPWDFzWXVCRWtCMElpV3dVcjBxS1Z6aUdRdGF0UitN?=
 =?utf-8?B?WEU4eGJXcktqY2RDSjRISExUdFdickVzeW4zV2ErRTZnK0VsNlREUDZHVFpX?=
 =?utf-8?B?R1F0UXZjVlB5Sk00aEdyb1lESEczWWs0M0NqMUt6NjdxNzdZRnlxRTJNc0d5?=
 =?utf-8?B?eTJ4MXU2UGlJS1ZDSnM2ejdIYktRYnBoQmg4QitpN0liQ05TZlpaU2V1QWcz?=
 =?utf-8?B?WGkvbjhzYVVuekJsK1ZYRVBOeHh6eElMM0M3SndyNDlEVERmMXpJTmZtN3Fz?=
 =?utf-8?B?ampERzl4ZXFtSGZOZDVBMWlibDdJd1MzQUhMN3gyNW1raDZBOFFpbmNKb0h5?=
 =?utf-8?B?dEZ1eHdFWjRYeWhqTWlkeEVpNWNIYmF4b3NuWjd2VVhndVFBWGFBSDJFcUJO?=
 =?utf-8?B?NWxCTm0xUzZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnhuSXJRb2VOZzBJQi94L05STFJwYjNkd0pkRmJGZHVSczd5eVc0SEVNcjl2?=
 =?utf-8?B?V0hjZVNQS1Q2a1dnbWRvVnlkaS9rVExuQ1RKK1pKRmMyNHJKY282aE9uYUVr?=
 =?utf-8?B?OE9nR1JKZU1PNGxQTE14TWVvVXZyOXV0elgwWFZRTlNXWUZqT0hnYnJHd1pG?=
 =?utf-8?B?YWZIN2V0ZE1ZTnhQRjlMV2lFcHNPTlI4VHNqMHk2a1F1Z2J4cWViNGxwWml5?=
 =?utf-8?B?Ull5ZEpsNSthVHE2eGdHb3grQnJXSjA5Zi8rRU93cmpMbHRNUVkzRlRveWxU?=
 =?utf-8?B?TU9jQmNOWFYxQ0ptMHZjOHVrdFpud2pQdjRuSG1uOExFeFZSRDQ0YUdqTmJy?=
 =?utf-8?B?RkdjUWV6OHEyWmwwaHVjMEJldXFjRGpUaVdVU05nMmtHek1wNlhpaUxGYU5L?=
 =?utf-8?B?MzAwaXV5WnhOclEvTlBjMlhXbmMyMm9CcVVqSnlrb2JIcmdHNEUreFBTUCtT?=
 =?utf-8?B?L0ppOGZhV1FXQlVWdkpKVStlb3ZpeUZaTmwyRmlaL2Z5a3Nmemw1eVRhSHg1?=
 =?utf-8?B?QXNocng1aTd1Z0VJa1FwSGRveUdxRldWWkNCdXc1Zm9tVzZyZUduZnF2cXgv?=
 =?utf-8?B?M0hlUzI4SytTRzJjVko1YVdvN25ySGdvQUtWNzhkZDcwOStiSitCVHE3QzlO?=
 =?utf-8?B?eTBHQU1ZWjZucGh2VldRTDEvaUdaRy9pRDBLeVRFU3Q4bENOUFRpUjBDWmFP?=
 =?utf-8?B?MHI2WDRiU3p2UVRSYy9KUkJlZitKbFNOS1BJMXV4QWU2UzZmbEtOTDdma1c2?=
 =?utf-8?B?VG9vdEZ1YnhQQ25IaUd0T1JIRTIxRGlwWjllckRNd3pvbHI0ZVEwejNIRmZt?=
 =?utf-8?B?ZjNZQStac0I5MWRQVk9WbzRJd1pZOXdyWnRyZ2hPT0lBdzNXbDVhRmR5bzJ1?=
 =?utf-8?B?eHlnQWdNVXNpajUzTVJxZmVCVEFZaDVyc0tSaTB3b0VlUDNLTklGRjNSUzRy?=
 =?utf-8?B?YTVyREFvWGxkRnVOVmZGUlQyU09qdzYwTHM1UnZzK3ZpRlI5Qkh5L3VjWFQ3?=
 =?utf-8?B?cWcrRlhjU29qSEhvNFJDVmduK0x1ME5IQkhXQVplQ1IwbVJRZ1BHM3AyYVR3?=
 =?utf-8?B?LzdWaEprQTZ6NGE1QU9aTGM5T2c4MzVKZFlkMnN4UWYxU1djVnliZThUMllS?=
 =?utf-8?B?eTlqYlNISGppcEJyOTZaWHFZNG05RHErTUJwcjg5T21oUG10NlpzVUErWFc2?=
 =?utf-8?B?REcwMjNnaGs1VkpuaURiVFpiQ20xM0t1cGxRRHVnMGRTM2psaURpR2toNUdo?=
 =?utf-8?B?dUlOc3l5ZzY1TFFSQlBXZC9ORFk4Q1NhMWNmUm0yUERwamVReGM2Y1Q0UE9Z?=
 =?utf-8?B?VzNTVU9KZ2pNckFTWTlkWUtYWjl0Ynl3cmpnakFmSk1ueVJoYkFLVEN6TkZD?=
 =?utf-8?B?Q29id0xXeXByelQ3WHgxT0ZzaXFvRVA1V1ozM2NxeTRUMlAvZnloL0t4d0pu?=
 =?utf-8?B?RWZnZ25WZ2ora1F5ZkZJdk1SbEdvaXZ6K21YVkhWL3RpdnVFQUpDQTZrUWlo?=
 =?utf-8?B?WUc0OGpLUmh1U2NOWnZqck1ObEhGM0ZzMjZDQ1Q5ZlVGTGJMWFdBWlR6MFJ1?=
 =?utf-8?B?RWhzdlZueCtGdXVYZkhpZnN4SXpkQmJEc2ozeDBlaFhZM2plR09LdWdvaG5t?=
 =?utf-8?B?U1ZWaVhYM05QeEpRcDRFUTZPQmpldlJFL0VwaEdlY2xycXVMRXk3cGNxaUZu?=
 =?utf-8?B?am1PeGVoSlR2a0psOGZVVGM0Y1BmdnlZdEIycTgzeGthTU1LMi9LNTIzeklu?=
 =?utf-8?B?bzVuUlZiQVkzRTg3aG1hcEdkL3RIYmRycDlvcHNzVklTVkNkSE1sU0NrWnB6?=
 =?utf-8?B?dDhoci9WeXJEQkQ4MzRjcEEzNmRvTkVReUhzdXhzZGdHK0xBRWI0T0JJYVlK?=
 =?utf-8?B?VWxoZDJkditoaEFvWUpVNys0L1dBbC8zbTNxS1V1SDgydm81WDRBYkEyZDBZ?=
 =?utf-8?B?Q3Fzd3NYYldBS0lQQWU0VG14emUvQzdaRHZqUmpnUisxa2V0Q1RTNU0ydkhN?=
 =?utf-8?B?VDBRanl0cThwUEdjdGF4YUxuRUxYSkdoT1RkMU91dkZzQXVGTUZKc1VsbDNC?=
 =?utf-8?B?YThxOHBMWHZiRTVQSnNJcnd0UEo2M1ArbWZDQ1R5dDBCQWU1OG1NNmlzcGhY?=
 =?utf-8?B?bmx0bmRtc1EvZmNZdjhScERtTXV4Z2IxcG1zb0I5eEl3L2pkSmtOa0FubG96?=
 =?utf-8?Q?zKKla47TgPdBwB9DnyyrHCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A12290B978F13E4EA19237C62E835464@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8bc581-c5b7-4c35-493e-08ddfc132cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 09:09:04.5562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiQsfEF0b45RgmyI/1D+dOS1/jK30lp1HxyhoVFlCzbZVq0O9Sg9uRbLV2AHXyIOCsvBTeVvwbEKgfcpGaQoL9/DhzPx/w7VnDG1dlyJvVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557

SGkgR3VlbnRlciwNCg0KVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2suDQoNCk9uIFR1ZSwgMjAy
NS0wOS0yMyBhdCAxOToxMSAtMDcwMCwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UN
Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA5LzIwLzI1IDA0OjMzLCBKb25h
dGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+IE9uIFdlZCwgMTcgU2VwIDIwMjUgMTU6MjE6NTYgKzAz
MDANCj4gPiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4gd3Jv
dGU6DQo+ID4gDQo+ID4gPiBUaGlzIGlzIHRoZSBpaW8gZHJpdmVyIGZvciBFTUMxODEyLzEzLzE0
LzE1LzMzIG11bHRpY2hhbm5lbCBMb3ctDQo+ID4gPiBWb2x0YWdlDQo+ID4gPiBSZW1vdGUgRGlv
ZGUgU2Vuc29yIEZhbWlseS4gVGhlIGNoaXBzIGluIHRoZSBmYW1pbHkgaGF2ZSBvbmUNCj4gPiA+
IGludGVybmFsDQo+ID4gPiBhbmQgZGlmZmVyZW50IG51bWJlcnMgb2YgZXh0ZXJuYWwgY2hhbm5l
bHMsIHJhbmdpbmcgZnJvbSAxDQo+ID4gPiAoRU1DMTgxMikgdG8NCj4gPiA+IDQgY2hhbm5lbHMg
KEVNQzE4MTUpLg0KPiA+ID4gUmVhZGluZyBkaW9kZXMgaW4gYW50aS1wYXJhbGxlbCBjb25uZWN0
aW9uIGlzIHN1cHBvcnRlZCBieQ0KPiA+ID4gRU1DMTgxNCwgRU1DMTgxNQ0KPiA+ID4gYW5kIEVN
QzE4MzMuDQo+ID4gPiANCj4gPiA+IEN1cnJlbnQgdmVyc2lvbiBvZiBkcml2ZXIgZG9lcyBub3Qg
c3VwcG9ydCBpbnRlcnJ1cHRzLCBldmVudHMgYW5kDQo+ID4gPiBkYXRhDQo+ID4gPiBidWZmZXJp
bmcuDQo+ID4gSGkgTWFyaXVzLA0KPiA+IA0KPiA+IEZvciBhIHRlbXBlcmF0dXJlIG1vbml0b3Jp
bmcgZGV2aWNlIGxpa2UgdGhpcywgdGhlIG9wZW5pbmcgcXVlc3Rpb24NCj4gPiBpcw0KPiA+IGFs
d2F5cyB3aHkgbm90IEhXTU9OPw0KPiA+IA0KPiA+IFRoZXJlIGFyZSB2YXJpb3VzIHJlYXNvbnMg
d2UgaGF2ZSB0ZW1wIHNlbnNvcnMgaW4gSUlPIGJ1dCBtb3N0bHkNCj4gPiB0aGV5IGFyZSBub3QN
Cj4gPiBkZXNjcmliZWQgYXMgYmVpbmcgbW9uaXRvcnMgYW5kIHRoaXMgb25lIGlzLg0KPiA+IA0K
PiA+IElJTyBtYXkgd2VsbCBiZSB0aGUgcmlnaHQgY2hvaWNlIGZvciB0aGlzIHBhcnQsIGJ1dCBn
b29kIHRvIGxheSBvdXQNCj4gPiB5b3VyDQo+ID4gcmVhc29uaW5nIGFuZCArQ0MgdGhlIGh3bW9u
IGxpc3QgYW5kIG1haW50YWluZXJzLsKgIFRoZXJlIGlzIGFuDQo+ID4gZW1jMTQwMw0KPiA+IGRy
aXZlciBhbHJlYWR5IGluIGh3bW9uLCBzbyBwZXJoYXBzIGNvbXBhcmUgYW5kIGNvbnRyYXN0IHdp
dGggdGhhdC4NCj4gPiANCj4gPiBJJ3ZlICtDQyBKZWFuLCBHdWVudGVyIGFuZCBsaXN0IHRvIHNh
dmUgc2VuZGluZyBhIHYyIGp1c3QgdG8gZG8NCj4gPiB0aGF0Lg0KPiA+IA0KPiANCj4gQXQgZmly
c3QgZ2xhbmNlIGl0IGxvb2tzIGxpa2UgdGhlIHNlcmllcyBpcyAobW9zdGx5ID8pIHJlZ2lzdGVy
DQo+IGNvbXBhdGlibGUNCj4gdG8gdGhlIGNoaXBzIHN1cHBvcnRlZCBieSB0aGUgZW1jMTQwMyBk
cml2ZXIsIHNvIGl0IHNob3VsZCBiZQ0KPiBzdHJhaWdodGZvcndhcmQNCj4gdG8gYWRkIHN1cHBv
cnQgZm9yIHRoZSBlbWMxODB4IHNlcmllcyB0byB0aGF0IGRyaXZlci4NCj4gDQo+IEd1ZW50ZXIN
Cg0KTW9zdCBvZiB0aGUgcmVnaXN0ZXIgYWRkcmVzcyBhcmUgY29tcGF0aWJsZS4gVGhlIEVNQzE4
MVggaXMgYW4gdXBkYXRlIA0KKGEgbmV3ZXIgZ2VuZXJhdGlvbikgdGhlbiB0aGUgRU1DMTQwMy4N
Cg0KVGhlIGJpZ2dlc3QgaW1wcm92ZW1lbnQgaXMgdGhhdCB0aGUgRU1DMThYWCBoYXMgYSBjb250
aW51b3VzIGJsb2NrIG9mDQpyZWdpc3RlcnMgaW4gb3JkZXIgdG8gaW1wcm92ZSB0aGUgdGVtcGVy
YXR1cmUgcmVhZGluZyAodGhhdCBtZWFucyBzb21lDQphZGRyZXNzZXMgYXJlIG92ZXJsYXBwaW5n
IHdpdGggdGhlIG9sZGVyIHJlZ2lzdGVyIG1hcHMpIGFuZCBhIG5ldyBzZXQNCm9mIHJlZ2lzdGVy
cyB0byAgaGFuZGxlIHRoZSAiUmF0ZSBPZiBDaGFuZ2UiIGZ1bmN0aW9uYWxpdHkuDQpBbHNvIHRo
ZSBvbGRlciBFTUMxNFhYIGhhcyBzb21lIGhhcmRjb2RlZCBjb25maWd1cmF0aW9uL2ZlYXR1cmVz
IGJhc2VkDQpvbiB0aGUgcGFydCBudW1iZXIuDQoNCkNvbnNpZGVyaW5nIGFsbCBvZiB0aGUgYWJv
dmUgSSBjb25zaWRlciB0aGF0IHRoZSBjb21wbGV4aXR5IG9mIHRoZQ0KRU1DMTQwMyB3aWxsIGlu
Y3JlYXNlIHF1aXRlIGEgbG90IHdpdGhvdXQgYW55IHJlYWwgYmVuZWZpdCBhbmQgaXQgd2lsbA0K
YmUgaGFyZGVyIHRvIGJlIG1haW50YWluZWQuDQoNCkkgaGF2ZSBzdWJtaXR0ZWQgdGhpcyBhcyB0
aGUgZmlzdCBpdGVyYXRpb24gZnJvbSBhIGxvbmdlciBsaXN0IG9mDQpmZWF0dXJlIHRoYXQgSSB3
YW50IHRvIGFkZCB0byB0aGUgZHJpdmVyLCBpbmNsdWRpbmcgZXZlbnRzIGFuZCBtYXliZQ0KaW50
ZXJydXB0cy4NCg0KSWYgbm9ib2R5IGhhcyBhbnl0aGluZyBhZ2FpbnN0LCBJIHdvdWxkIGxpa2Ug
dG8gYWRkIGEgc2VwYXJhdGUgZHJpdmVyDQpmb3IgRU1DMThYWCBpbnRvIHRoZSBJSU8uDQoNClRo
YW5rcyBhbmQgQmVzdCBSZWdhcmRzLA0KTWFyaXVzDQoNCg==

