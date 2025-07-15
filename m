Return-Path: <linux-iio+bounces-21679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95327B0561C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 11:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A66818901A0
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19EF2D5C73;
	Tue, 15 Jul 2025 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="JFpTMSNw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884A272813;
	Tue, 15 Jul 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571149; cv=fail; b=cdLWtyx4CzpeZt9ma3GcQMNyeyJz4qTnAjMquoXa4wExCB8kSSwNYGHfHj1V4Jqh4jbsJZbMBca+yo7ompxGMFuQIvU2u/hEXHEb6qWzjl83nWaKNDkGMl6W43VbeoHqBtgqRm/U0A6kTWME2MUwXWRSpax768pZPWjHbmhx33M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571149; c=relaxed/simple;
	bh=0KqkOs+KUCBCnHUxDZvSNCLeZrFsXPTXMEDdRHMrVIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9Da0esw0Okjn9jTH0Ao6vKOEwB6+Or7xYN6kwqMxfbSwTLnG/sDEz9K1nqhje6jcRqQ6ehGJMc8p+Dbwo2YjmlaI09JmWKHnhNtfqINDIobpCy2WtO6ByrLFJ7J84Az0SsgFKlWchcy/qumECKYWj/CnmyLvl/7fk6lSyZGuYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=JFpTMSNw; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EMwOSC010934;
	Tue, 15 Jul 2025 09:18:57 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010020.outbound.protection.outlook.com [52.101.171.20])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47uft5t2jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 09:18:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzQ1j29Y2YaOWZQsH5XPTw33Jt9a1uSDIlSEtcuo6vrAwh5yqVAonzFtNaf+4OLCLtdNcsdMGGNYq+woWeUhbzTpxaokFyqyO/0s7oAtprzhz8BqVxOyc/aUC0cjByvzwX/UrSh6BjZj9DIMC3s6H4ZC2g9ArUH3htAqHlRQIqitEPkvTN3LfMIF/74nvsVKEN1WPZKXXk5A9kaAdvjgwTvLDJwP6jDq0qreYTsOqExnlVja5cdywTjvlNG7+j3KiRJ4+u8p+WHDrYefZi9B6zpuWajHff5y4Yq4d5gznhEoldjmCk9s4XhQkoUKo1L6BRs4d4+lHhyozOJP0Q9Jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KqkOs+KUCBCnHUxDZvSNCLeZrFsXPTXMEDdRHMrVIk=;
 b=x751FqwHPC5l1rf1PCt7pZxao+PiZE7piVb3OX5hFf6GdNUPN3XbJGQlpsykascgiDWbEEB7hniIPijGR3e+RnZdJY2qLvuWGG3LQHohRZz6osyyj8P5decTV0JXEsVZD4USfEok8PBkF9fk1bqrJAl6/Yd4kcvj/CnxDKE8M9hA62viyLbOnJ84/rgF0Q25O1wBjTaPEcZ8KpmjIcKkl8QLZnIizBLPSa97txffgN7cBIN7ymH4GDOHDHifaE+YMwCfoxPdRKnzqw5xFP9v3PmQgfdTa+Bvq/mkpWG8VeBsZx58abkIb8rzrbhwmIsDtfnu9YRc99gLi7Q2sjVTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KqkOs+KUCBCnHUxDZvSNCLeZrFsXPTXMEDdRHMrVIk=;
 b=JFpTMSNw5pBPSpvrZ8mjWdtM5fSxok/pAw1jDgGSGSJ+Zr9Uvjy1Q74ug7Nt4z8hZxvypS85PtG8FLDHD2R67iBvEwO1q+T8zYvISJhHf1P85kmT198MTDbly/noBuEmBUHte3Toy4zyQRuhW08xCLoJRC7GuC3jXjERatYEWzXDiIApVlxW5+eux1umr6SCIC9Cy3cU7jvrKxokQGY6IGSQNiGO2xTTwNwpyegcwRVRiNQfkx5YRyryBHq07YMAXX2eTCYRNe8aeK8g64pUKN7A+m2oTfUdqmN5F3VB9v/0toYxtuy5/QXf224hUirMj7aLDWDjM9BzYyRkxuIxSQ==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BE0P281MB0163.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:12::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 09:18:53 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:18:53 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        kernel test robot
	<lkp@intel.com>
CC: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 6/8] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Thread-Topic: [PATCH v2 6/8] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Thread-Index: AQHb8XjHfuYKc7axh0u3tRjGg76GDbQsXRWAgAAUugCABn3HoA==
Date: Tue, 15 Jul 2025 09:18:53 +0000
Message-ID:
 <FR2PPF4571F02BCFAD85EB34A3830AF75708C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-6-bf76d8142ef2@tdk.com>
 <202507111201.r62j5rb6-lkp@intel.com> <aHCqoCNhXPqdKZId@smile.fi.intel.com>
In-Reply-To: <aHCqoCNhXPqdKZId@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BE0P281MB0163:EE_
x-ms-office365-filtering-correlation-id: f0cbf848-0598-4924-0431-08ddc3809e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|19092799006|1800799024|7053199007|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3VoQTZEWVpjWCtlQXEyMDNsaFdtUnZFcFBPZDdRV3l4OVRUVytNNFRpNW9Y?=
 =?utf-8?B?bXdzNVlONWFwUFNvc0l2NUV0aU4vOFVJL0FMcDh2VVI4cHFkUVRDd0VUajFv?=
 =?utf-8?B?VFRUSll3N0g4QnlBSHJoU0UwMmt3UXlmZVh0VE9iMENVTlpjaTM2QW1vZHcz?=
 =?utf-8?B?dld6SjkwRWNlcjNBZmFKKzdrUkY0VHNTaEpiT2V5NXRtdGFVWTZxMFpIR25K?=
 =?utf-8?B?UnB1WmF4UDNBOUZUOVFGcXlJQjIrRzRwY1pPT1VMU2xLUVRQa3FFdEVuY3Br?=
 =?utf-8?B?OXdWcW44YzNnejRuM1FDbWV2QjRjZmpNMnNuRFJ5dWRqT3NnQ3pGRGpJK0VZ?=
 =?utf-8?B?Ung5eVljODVIa204c0F1LzJFZ0RCSE1TL2RvWDNWRnRkTk51STM5UFNzQ1dD?=
 =?utf-8?B?eGVHN2ZEWkhyUFdOT09kZzdnVHhWZEJSRjhFQnFhcUNYRTNFUmhBbCt6Ym1p?=
 =?utf-8?B?WDJPNW1GSmtnRDVMTThQa0ZqZ1BXenh3bXR2NFN5b3ZLbDZwcVdzL1l0d1BO?=
 =?utf-8?B?UXlWS2hPSVNIL2dRN0VvbGxpYUEvNWllaU1ubkpJTVZ1bHQwME5QQVlMdElt?=
 =?utf-8?B?MEFMZDRKMEpDa29yNHlMUjQ4NTQrZlJuNHBFQmhGYis4RUtOMEZFcndlTkYv?=
 =?utf-8?B?U1M2UndpYVpTMS9CSkx0emdMVkxUVHhxN2U1NFhaUzN6eU5rb0pLSjJmVWU4?=
 =?utf-8?B?NEpHMll2eG1HanRVbXFyRU8rMXdvM0pqUGlSdFpqMjhpSXNlZ0ZKSlRaemFV?=
 =?utf-8?B?QStqK1Y2WFZQYXVWZDEzNzNMd2lTTTh6Rm1tNUIxNFFnV0hITUtPK2hoci9l?=
 =?utf-8?B?d2JscUVRK3VKMUxjT1BoMEVpU3I5Z0NTekxMKzNOd25mMFZrSGVNNGUvQU8v?=
 =?utf-8?B?ZzFqVHdMNlV0WVVhNGJWVFRvbU1EUXA4blpvQklqOTBPdFl0WnNadkhlWDFu?=
 =?utf-8?B?Tlk5U0FEazk0dk5XZW9WSy9QUkZDRmdILzRaeDY3VXR6WUtLZFBTOGdBWXc4?=
 =?utf-8?B?Z1VxZUdDajV5TEg3cXhpNnpqR1FqN21JcWE0aURuQVF4NUNScUk0ZGNOa0Nq?=
 =?utf-8?B?OFE3RU1FVWNodUpUbTNLRGdzR1V0MDY1WEVmTG4zNklHK01SSUNaQzlUV1ky?=
 =?utf-8?B?ZGNBbjBMZ0xyWnRHQmVqcksyV09hMThQcTVrMXlFMmNUalFvNnNOUTdPekwv?=
 =?utf-8?B?SWhoMUdhcllCcG83bTFCeDk4RW5sbXQ1bzM5Y0F5U2hmTEw2MXk2K1V4MUlH?=
 =?utf-8?B?akxrY0NSYzAxK2hlNGdaOUl2QUFsYzVJNWVMUjZpMTRFTjhxQjlWejczcDNL?=
 =?utf-8?B?bWc4UUhJNGoxZi9JMzkxci9UTHovZjdhWkhOeHRORVBRYTkxV0w0ZVYxS2Vv?=
 =?utf-8?B?RjExQU1SS1BFZlgwQmN0bzBtNVN3OVlTTG5qTGhmK1FPM1g3dzkvTTE5MXpp?=
 =?utf-8?B?MldMczczZWdPN1VXOFlFd0YwdDVtZDMyWXVSekErekxFajdxbjRaYkswWE9y?=
 =?utf-8?B?RjV6aGtIQ2x2MkdOdzNsTGF5UStJWm9jQWFaN3dCdE04MWVScDVVaUVtZEkx?=
 =?utf-8?B?U292UU43UnFYWjl4amFyb01yaTVSaExqK1RuYkhKdVZiN0MzbFdWUkhVU290?=
 =?utf-8?B?NDBEQ1hwKzVNOEYrNWJtTDFFMkZQWC9JSnVwRUFtaE5CTnlWUFhhVnBwMWk1?=
 =?utf-8?B?Y2RBbHFoMDkzMytUdGRwOHZzK2J6OEM2VFVnRWlWSFZ4ZXJFSkxCRVV0bWpG?=
 =?utf-8?B?OHJ3SWRoOXluUWVmajh5WTJweTlaSkhwbU1VSGZ2bEZ2VDZyanNJM1UvVi9n?=
 =?utf-8?B?Rm5tY0N0U2M0RFd5T3Z6eW1IdlJGKy9HTFRLMXNJYVNGQkhQVkZVcVk2U05O?=
 =?utf-8?B?L3pJVTZhMEhPMGNGYzFadVBmSlJ0bXZ0S2JUV09qT1p3OUFxU0VxZit1VHFr?=
 =?utf-8?B?Y01wWkh6VGRLVmVRQ3dKY1VKdmxZMGZoNFdUb3R5QURWTDRzUVhNdTczMExv?=
 =?utf-8?B?UXJNZk02cnJEd3Z0NS9UdFdmVFRyaE9mZlZVdFBvNXhJOVdZR3A0MXBHTDVP?=
 =?utf-8?Q?EcQFgw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(19092799006)(1800799024)(7053199007)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmExZ2l0K2szYjhGODdmcHdsSjBJVUZUbDJOZHFIUDVTTWMwejNOVW1yemJv?=
 =?utf-8?B?T3YwZDN5eVY4QUFRYjJMbFh5RmZWRnlGeVhKYytRZUc3KzgyUXY3enJoMVFV?=
 =?utf-8?B?MEk0em5LOW1FOXI3Y1BYck5MNmhDUEVRNEY2ZlpMN2tSc1RZNkxhN0dzWFQw?=
 =?utf-8?B?M3lPTCszM05FWk9TZmhwNVhWZGh5SHdMcER5TnBOa1A5UmRjSmdCaTRtckRw?=
 =?utf-8?B?djVmSUV2c1RENUpFVExabDRLZkx1ekc0MU83bWpaU1FqbzVHc0c2L0M0UFJn?=
 =?utf-8?B?UkZ1QWY4Y2JxU2V4WklSdytZMHdrN2dUQUtSRndpRUhicmdpRDhOUWVWNkJU?=
 =?utf-8?B?Y0M0YThYR2ZIclY3K252SkN0MmQ2UlNqVmFnZnFLb0N3eEF0UnY0MGVWMVlX?=
 =?utf-8?B?ZExSYWZCa0NQM016ZmdpZEZ4endvZytzQlV1S0w1V3g0Nnk4QVA4dkM3NG54?=
 =?utf-8?B?ZGg4cDJzOCtid2c1Zmo1VkhXRTh2bVkxTEd5c21MSWhCT3NkT1ZIZWZmUnpU?=
 =?utf-8?B?S2tsYTVBMU5VSG55K1ZHdzNNVThOMUlsQjJvMFc5UEd5WVA3Zmo3c3ZGeWtj?=
 =?utf-8?B?VHVUUzlEZ0ovUTNHc0JzZ2g3R0hVV1VYNW1vVkVLcHFDVGQ1dEZiamRlbWoy?=
 =?utf-8?B?T0FEdVVRSjBGWCt2eEJlMURIQmhkWElNRStBeXFJWTl5NVdJRFo4c2E3MDV6?=
 =?utf-8?B?M1UvM1BBRk05bHRLVnd6cEFFOVNoY2hqeEQvTDYvaWJpdmx4dkR3azZzL2xy?=
 =?utf-8?B?TGxaaTBZS295bWlrOUtxTkZ2OUdUSE03elNvUmk5eE1Wc3lLTGs0d0ZrWkRF?=
 =?utf-8?B?RlpjVU9pRHFlOXFOcTFSVDJsV1ZPUzR4bUYvN0J5a0U4eUFvNUcxa2JyYjhP?=
 =?utf-8?B?TlM5UHMyam8wWXhVZGI3UXlhL1ZONXJ6Tm9XUVA1V3k0Um11TTZqUEx1R2lR?=
 =?utf-8?B?YTQ3dkJkSTAzbVV6dVFySDdMVGtvOVhpNnFocVQydVpnR01IcCtuTWJueU9U?=
 =?utf-8?B?bDNvMW5Yd213VnR0S1lQejhvZ0FkaG8zRUVmZW5BM2h6d0tTRkFYOGxPRkpj?=
 =?utf-8?B?M2FZV3IrODllN2dMWVBpM1MvNVFEMzBHdFJ2NW9jTm8xWTREYnRLTVlhQWUw?=
 =?utf-8?B?dEFJU1lCem1mMmk2MnRMQVU1c1NNelNEaUh0ci9qS1h1RzFoN1NEZkJoYlhW?=
 =?utf-8?B?SWxJak5OWlpraU9rN1NiaGhXYlVDUUtSMlphWXk1VURhUGh3R1BSR2pFMFZS?=
 =?utf-8?B?K1orSlRUbEZvUmFYQ1R3RU8ybm5hWms5VmRhYmlxUFl2VVREY2hUM0xUdHBo?=
 =?utf-8?B?OFNSQVZ0aGY2OXBBdXJ1RU5VSm5vOG9tYm00Z1B4L3RITForb1Z0QUdOS0FF?=
 =?utf-8?B?bStHYnA0M255Njl6djFobktsZEVVOXhnQXJwT1AvcmJxKzlIVHloS0pMK25t?=
 =?utf-8?B?ZUJVcDlaT253VHZCcnUwOE5KclgvWHZpajRLcGRJSjBkVW1Ic0lGR054SWp6?=
 =?utf-8?B?UzNyYW1EeG0xeUVpVllnVVg4TC9vUDRiQVRuM2dQRFZYbXNDd2RZU2hkQ2RJ?=
 =?utf-8?B?UE11RjF1ajU4T3NybG4vZTRiNWFuWnNCVWhRMTAwSFpVWXYyL0xpeHlVaVFS?=
 =?utf-8?B?a2FkYVphNzVrWW84dlhOK3VvOVU2cFRsYVVVaFRGRGR3MWo1dTQ3UVpJMFpu?=
 =?utf-8?B?bmtBMFJ5YWZjVmZZQkxZZzNEdGdJUGtJcFV6eTZoWUxmWm1OMUpEemhxVEZZ?=
 =?utf-8?B?azdBZTg2cHg3bE9HZFVjR2MyZGVwRUpqQWhrSTNlei9QYjFubkhCZyt2N09t?=
 =?utf-8?B?cko3ZEhxYU5rVEdqeXZuOFIxK21PLy9NK1p5RVFXWHlNdTJXVDlLVTZsRGR5?=
 =?utf-8?B?YVlzMjZJNjU3b0NnOXdGSUNLTGt1V3IyaHZYRGo4UTUyT0FFL1lGQXhvSjFM?=
 =?utf-8?B?L0UvQjFoZDVDcGtZWFJ2bVBNNzhyWllmM2E5RWF0bzRjYmhVajEwNzJRT3FY?=
 =?utf-8?B?SVo2bkxjc3NXbnFXeVpkTHJ3b0M3TWRJWkh0bXBvZW9ML0c0dTRDSTE5WHpr?=
 =?utf-8?B?Um56M0xGb1BKd1liWTRkYXlQQVE5YWx0a240blVaMXpkMUZQQ1JuZHpyM2xx?=
 =?utf-8?Q?prFu+M5TrQ554yUvNoWQQrNqy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cbf848-0598-4924-0431-08ddc3809e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 09:18:53.6996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqgL0HQZoUlcJPlY96IiICSoMd35+nmRAklFP9aczVV/J16kfgoBjZJD6syrMXINLXvpLlmPBgmFs4SlFPnl3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0163
X-Proofpoint-GUID: N1DwC2eve5lEQqFMTjTOok00M2G4Vbzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MyBTYWx0ZWRfXyeylENQGXWhV
 kEPy/BrMpEgv4Y5MuL8/5Vr44Pa7j4d1IJMvQAuXg7Gd9VC2LhpuyoWtTmW9caPmae65FAz0MVl
 U+b6GqcNzJgV/qmlGe0P160ttULhAtuGxzzUYpuC6jP+eCWE7S1S/P3a9jNl/1sTSiB/FS2JSMW
 66jL34rBv5TMkkGLq8ecozaNLN8o1S7t3iOa4MTzCAGm5CatKcRarVez8yb07jXQz7a1vpqhE4y
 6ybpRSkimOOW52tCpeGnGZuSpw3VoMC5IY8mz92YWZmjDKgysYhS5fOc41y6LPGGUtFk7nmLr90
 Vpjd9RJMyFrtHjN/Ba67+ns9v9fS9iH/ppBRnlEO19d1oANuu/QwxLV0vjDvl2K0EOJjY9L5yIM
 Dv8Su5Uo7BGJdIlzCXry6Kh9K7W23z3+LMJlzObT8nBGHup65h4lVmi6o8VoBEUcFeZB8DIX
X-Authority-Analysis: v=2.4 cv=QLxoRhLL c=1 sm=1 tr=0 ts=68761d01 cx=c_pps
 a=IxrI4HAsaM/rue4H2PuiTA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=In8RU02eAAAA:8 a=a_oFa5tOQqE05XSChVYA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-ORIG-GUID: N1DwC2eve5lEQqFMTjTOok00M2G4Vbzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150083

Pg0KPg0KPkZyb206IEFuZHkgU2hldmNoZW5rbyBtYWlsdG86YW5kcml5LnNoZXZjaGVua29AaW50
ZWwuY29tIA0KPlNlbnQ6IEZyaWRheSwgSnVseSAxMSwgMjAyNSA4OjEwIEFNDQo+VG86IGtlcm5l
bCB0ZXN0IHJvYm90IG1haWx0bzpsa3BAaW50ZWwuY29tDQo+Q2M6IFJlbWkgQnVpc3NvbiB2aWEg
QjQgUmVsYXkgbWFpbHRvOmRldm51bGwrcmVtaS5idWlzc29uLnRkay5jb21Aa2VybmVsLm9yZzsg
Sm9uYXRoYW4gQ2FtZXJvbiBtYWlsdG86amljMjNAa2VybmVsLm9yZzsgRGF2aWQgTGVjaG5lciBt
YWlsdG86ZGxlY2huZXJAYmF5bGlicmUuY29tOyBOdW5vIFPDoSBtYWlsdG86bnVuby5zYUBhbmFs
b2cuY29tOyBBbmR5IFNoZXZjaGVua28gbWFpbHRvOmFuZHlAa2VybmVsLm9yZzsgUm9iIEhlcnJp
bmcgbWFpbHRvOnJvYmhAa2VybmVsLm9yZzsgS3J6eXN6dG9mIEtvemxvd3NraSBtYWlsdG86a3J6
a0BrZXJuZWwub3JnOyBDb25vciBEb29sZXkgbWFpbHRvOmNvbm9yK2R0QGtlcm5lbC5vcmc7IG1h
aWx0bzpvZS1rYnVpbGQtYWxsQGxpc3RzLmxpbnV4LmRldjsgbWFpbHRvOmxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IG1haWx0bzpsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBtYWlsdG86
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IFJlbWkgQnVpc3NvbiBtYWlsdG86UmVtaS5CdWlz
c29uQHRkay5jb20NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDYvOF0gaWlvOiBpbXU6IGludl9p
Y200NTYwMDogYWRkIFNQSSBkcml2ZXIgZm9yIGludl9pY200NTYwMCBkcml2ZXINCj5PbiBGcmks
IEp1bCAxMSwgMjAyNSBhdCAxMjo1NToyNVBNICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4+IEhpIFJlbWksDQo+PiANCj4NCj4+ICAgIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDU2
MDAvaW52X2ljbTQ1NjAwX2FjY2VsLmM6MTAwOjIwOiBub3RlOiBpbml0aWFsaXplIHRoZSB2YXJp
YWJsZSAnc2xlZXAnIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5nDQo+PiAgICAgIDEwMCB8ICAgICAg
ICAgdW5zaWduZWQgaW50IHNsZWVwOw0KPj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4NCj4+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwDQo+
DQo+Rm9yIHRoZSByZWNvcmQsIHRoaXMgaXMgdXN1YWxseSBiYWQgYWR2aWNlIGJ5IHRoZSBjb21w
aWxlci4gWW91IG5lZWQgdG8gZWl0aGVyDQo+Y2hlY2sgZm9yIGVycm9ycywgb3IgZG8gc29tZXRo
aW5nIGVsc2UuDQpUaGFua3MsIEknbGwgZm9sbG93IHlvdXIgcmVjb21tZW5kYXRpb24uIA0KPg0K
Pj4gICAgZHJpdmVycy9paW8vaW11L2ludl9pY200NTYwMC9pbnZfaWNtNDU2MDBfZ3lyby5jOjEw
MDoyMDogbm90ZTogaW5pdGlhbGl6ZSB0aGUgdmFyaWFibGUgJ3NsZWVwJyB0byBzaWxlbmNlIHRo
aXMgd2FybmluZw0KPj4gICAgICAxMDAgfCAgICAgICAgIHVuc2lnbmVkIGludCBzbGVlcDsNCj4+
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+PiAgICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgID0gMA0KPg0KPkRpdHRvLg0KPg0KPi0tIA0KPldpdGgg
QmVzdCBSZWdhcmRzLA0KPkFuZHkgU2hldmNoZW5rbw0KPg0KPg0KPg0K

