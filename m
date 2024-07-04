Return-Path: <linux-iio+bounces-7314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A19276C9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 15:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E88284479
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA82A1AE84B;
	Thu,  4 Jul 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="htHifnGB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140E1940A1;
	Thu,  4 Jul 2024 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098284; cv=fail; b=amq/zYnnjVd74ph3DwDH5Dc7YPRUmnubjrq159KZka2xyjwXr70uSnQQ+xrRug4EGinszUs1snygI5md/HJSlLLrZkHhNB7WzK0K5LDBMSAViZYSQSyrmiHZt9IGC4meHxSdcZkDWmwgNxbV8qPS5MjXT9pNU4dADrKAll8tGb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098284; c=relaxed/simple;
	bh=IxWPyLtIZSzxLzd01gofe4IfnlOF/+SWEK/inFht18M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cg5VBsOsAvBzFX094SUDbDBZiAqX+HlQth7cU9RLJ9fpenCKH6IcD/u7Gmlg+s3t1hvO5nOFobRXgdZTrzVgGHqPhSoBRextg/9lDlO5aqqPYdImYc2sL7t0YQoyrycOgHoCSm5iHInwdbKc5X+zZ/a6WLBb8yvfLvgIpOcfRvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=htHifnGB; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464AkBEs006884;
	Thu, 4 Jul 2024 09:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IxWPy
	LtIZSzxLzd01gofe4IfnlOF/+SWEK/inFht18M=; b=htHifnGBgJLSlnQeJi/K6
	07B17aPVDravcrsNc6WvRUl9qRdHkcpf3VaWCJmvqo5lqjGbezCrdulCnOJQXyJP
	2UGKaZiGccVbdMB7e/YWghtq0VgyVXy1VvRJfo1QDYUGNy9Cbo4aEapZ/D/r+9TJ
	ivybQuteoEeHYNneJQQWKJk5ADv2P8+KP1iaQOYW9f8gRXLhx4HDjEvxxSttXQEl
	OduojsPeBTHCtMEQKFehlJ1uFuKZkfYn3X4vzHKf2Pix4OPGol3fo9kW16GBEzBs
	KFP6Rl6IbOEJlW63n+7uW6fT0DsPYx3LJ6UHisRk6Zojg7mpIe+92oxaWVzmNe1n
	A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 405n2p1fpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 09:04:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSG8/+/zaLoBrAyNjb2qdluryM5au9luxL7IK5Qddllhh7bCHFXJ6NH9vyIRiSRFhfRpoFcJzHnVBcXZacMx9tkmjiSdPt6AQ6MvoLM5tUqa02ACqvzoTKlGMqv5rmVbPk+iLTh6/Ve6YP2pLPvKiccUXzVzOsQzG0IZ7W/7nfkMTYRS2ZC55fgKXcjlhC21MhuQ1GHrOQVxPSn2J5Vltjtp55F/MrJog1vI7dlv9EwqjycmhtFGN0u4roDrMwoP4ftlVIm6hU4z16UrpqC3yDYRGmnInl/l/eOiOKDGf4YD1EkCHf0OEeqIICdC1wrn/PafmCCAUYzOyiLs0hVO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxWPyLtIZSzxLzd01gofe4IfnlOF/+SWEK/inFht18M=;
 b=WGwQrEwizwWhh1rmX8v60YUoPBwUn/7KH8jDKZi8kgh1RhLqLWIHckQiENW55d0ecPiePgVt+A046FDzMCSCqNujmwZMxMdKqqOorfQR2zO+JQlwqYVSEVwGcKHPnliaaobbSAg455Zq7rgSAT7uAKJMmERMA+loOT5Sd03p1fjkh8aXBn3yIV/qZ/pLcuR4+mXNVuO3c4h7k2YUeBHnbbMeqSVYTvjGI2WGoOkxVqzeOAsHRhjG0c1NYGTl+2XkIbcw+y/Pq/SMra9+dGB4OJiqTKlDAotCcZ8N8wUeziJq8/bI3ph7XpYXiNsoqOCEd5VMeokkm/oB/pwqNhuDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DM4PR03MB6935.namprd03.prod.outlook.com (2603:10b6:8:47::11) by
 LV8PR03MB7374.namprd03.prod.outlook.com (2603:10b6:408:184::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.33; Thu, 4 Jul 2024 13:04:22 +0000
Received: from DM4PR03MB6935.namprd03.prod.outlook.com
 ([fe80::d6b7:7e76:5dee:e2dc]) by DM4PR03MB6935.namprd03.prod.outlook.com
 ([fe80::d6b7:7e76:5dee:e2dc%3]) with mapi id 15.20.7719.028; Thu, 4 Jul 2024
 13:04:22 +0000
From: "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        "Tanislav, Cosmin"
	<Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Dan Robertson <dan@dlrobertson.com>, "Sa, Nuno"
	<Nuno.Sa@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/10] iio: adc: ad7091r8: Constify struct regmap_bus
Thread-Topic: [PATCH 04/10] iio: adc: ad7091r8: Constify struct regmap_bus
Thread-Index: AQHazYywPdseR8FFiUebYRtJ3zCUdrHmiF9w
Date: Thu, 4 Jul 2024 13:04:21 +0000
Message-ID: 
 <DM4PR03MB693592DF53C9419D7BF3DB9696DE2@DM4PR03MB6935.namprd03.prod.outlook.com>
References: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
 <20240703-iio-cont-regmap_bus-v1-4-34754f355b65@gmail.com>
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-4-34754f355b65@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYlhOamFHMXBkSFJjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFsWXpjMU0ySTNOQzB6WVRBMUxURXhaV1l0T1RBNVpTMHpZMlU1?=
 =?utf-8?B?WmpjME5qUm1Nak5jWVcxbExYUmxjM1JjWldNM05UTmlOelV0TTJFd05TMHhN?=
 =?utf-8?B?V1ZtTFRrd09XVXRNMk5sT1dZM05EWTBaakl6WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpNemt5SWlCMFBTSXhNek0yTkRVM01UZzJNREF5TkRJME9URWlJR2c5SWk5?=
 =?utf-8?B?MWRrVjZWRGM0VVhKM2FIcDBWbVpNYmxVck1tVmlVVU5NY3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVRkV1pYVjFSWE0zWVVGaVlta3pVRXBOU1hrdmIz?=
 =?utf-8?B?UjFUR000YTNkcVRDdG5SRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQk0weG9VMlpuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR03MB6935:EE_|LV8PR03MB7374:EE_
x-ms-office365-filtering-correlation-id: bf3312d0-6ae9-44b4-ee75-08dc9c29d28e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K1FkWkV1VUVFRThQa2dzMnhrSW9LL1BNRUtLak4vamxhOU52aUFWZnFlUCtE?=
 =?utf-8?B?bkQ5bzc5UFE5WjlkT3ZjOXE4azNzcVowbnZ1dnFDYldLYUpJUDRuWVNmV2xy?=
 =?utf-8?B?OVhVRGxsRTNLaUdtZ2crVTEyUG9jMEllUExodE5XVlBWanMzMnFkNVh6TUVY?=
 =?utf-8?B?NXcxR0tUZXhEVjNscEQ3b1hwSmxST3FJVnZEVm40eU1ZLzZPOFVCUnprcVdZ?=
 =?utf-8?B?eE9lT3ZjT0FBcnJLaTFzbUlGRDFoNldKajh6NEFZYzFLNkN2MXBQV1YzeVIy?=
 =?utf-8?B?STlrdjh2RmtJOVNTVDM3NUN3eExFYWh6RUpDR3lzMGI2SzBOOW9CQmRsUmdO?=
 =?utf-8?B?WUZvTi8vbmo4OFYzYUVSblVFQjJydENZQVE0VVFIdWxielVsbFRFK2hKaE85?=
 =?utf-8?B?SHFEWmw2ODBycmNHVEo4UDRCR1VBbHNYTklIQmJCWDJ6ejBLd3F3cnVydFdv?=
 =?utf-8?B?eS9Hci9MRE94QkdUcHd2bVNqK0NrQkxVd0ZQc3psOTM2dVZoaXRqUy82blpR?=
 =?utf-8?B?SDl6MVh3cEJHSjBCYjd2bDJzZG5kVXFIZXVWVW9rZzlsY2wvSVdncDlzNnB2?=
 =?utf-8?B?cVNOQ0JzNThyVG5FbnpuQ1QrR0JzZjE1UXNnaE9yVkJ0UmZmeW5HTUlTME0z?=
 =?utf-8?B?a0xjbjZOd0krRGpvK1pSamFkdTNkTzFia1VsZHZod21Ra09lK2JRdHk5SStZ?=
 =?utf-8?B?ZnR1akhyRDV4OEFtZmU3NmkrV2ZNMWNvdE1ER2dCSkg0RE1IWUlzRlJ2UCt4?=
 =?utf-8?B?czdrOXJnL2pCR3pUZmJBT2NpRnFxbjBIbjJKZ01VOFAwb3crMk9maWU2b3l2?=
 =?utf-8?B?d21RSzludHMrYk1YbnpTZ1FESVZoNUxwT0p5NUV4QitjK2FWck9hSDE4MXRV?=
 =?utf-8?B?bVovc0dvZjR6ZjJhSEhZdEtSQkJiT1gyTnZxaTZXb0w1RTdsOXZTU0VxZlVk?=
 =?utf-8?B?UFQ0aDNDMU9IR3Jja0lxdHVMNlZGRUtyc3dRUjczczd2OW55WjhWK0lLUk5w?=
 =?utf-8?B?NHJ5bCtPU3c5NDVCUmZmR1lRQzVrTjAvVXM2NkNqNVVjN0IraExmUGppMVVn?=
 =?utf-8?B?OXNUSjA2L2NxTlhTQUJ6SUkrSmdhMG84Z1EyRXNKTXA5UFJRSDlobDhGWXVs?=
 =?utf-8?B?SktyZXZVQkdFMFpqMkN3OUVBNkJJYUN3SHl1U0lsUlJ6Ny9IcmJHeVl3WVVM?=
 =?utf-8?B?aGpjaWpRR20va1R5N3VOandzKzZyTE9ONk11cUhkNGJyd2ExamxPbWNKelJx?=
 =?utf-8?B?a3hKTHo4Unl1aWh5WEIwMnRsNG8zcEREODQ3UzZrdHRoTGxpNktxbE45YnVX?=
 =?utf-8?B?aGtpMTlqbkJraFAwVmJJdE5CUmVKQ0dLM0k1dm9Wa1pKa2NhOXVPeEl0dU0z?=
 =?utf-8?B?VnJ5VUFDT3VhSHFuQzdBZ2hPUzRQbTZxRUw2WDlSVGdueVUxRDZseDVHTkZV?=
 =?utf-8?B?TnFrNUFZdmswQWdNNGlSeGFQcFJVajFYYitaQWhPcGJvbHRRc1RqWkxBbnZS?=
 =?utf-8?B?d0dHUmdrNStxTVBlc1phYk9FNWk1WU5SblFkNzF2OGNIYzk4MXVGN2IxQ1dr?=
 =?utf-8?B?ektJWk5IWDhaNTRWODR5S3I3QUdiVnRRaTRJTENXWUlOYksyYUZVL3hNMllV?=
 =?utf-8?B?eE12VlBrOVo5OEQrb0xKK0dlV1JKdTYyVTU3YVZTZGU4cFpiRzliNlVSZS95?=
 =?utf-8?B?NmdxZ3NVR3EreWwzYUhBT2lHbzgrQ1hqUVgxT3RVVHRIYUJwdDkvSGFTbU9E?=
 =?utf-8?B?cWdBbTBwK3ZhaHRJdG9YdXA5bTM4RkRDOW1RTitCak5JajhNc2dQTVlrb0tH?=
 =?utf-8?B?UG8vN0Y1RDdXYWpuWHhxQm9ub2F6OFBkOTFVN0cxWU1ZRWFHNXlFUTJ4TjVB?=
 =?utf-8?B?UTJicStXbGpXcnk0aXVNSStmTFRNcUMxcXA4ZGluSDhMelJpZCs4c0RSWjJh?=
 =?utf-8?Q?clJpdYG3Dk4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6935.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MXFtU29jV29vNjRxK0tEc0F4eTVxMklPbVBiSTFiUHAyRWRVbE9RLzF4SDQ0?=
 =?utf-8?B?V3BSQ1lLR2dFUE1TQk40MWpPeWxsV0JTZkZoSm9pV0hnZ3VmTmZZdjlMMkRE?=
 =?utf-8?B?MkZyYmdHOGVoWEpwV3Ryb2kzcEFTdUhiWkIvdEF0UDFhN0hVYW4ySDlQVGpB?=
 =?utf-8?B?ZkZaMUNoRS9VWC9jWmdkeGJDMFhuYkp4aGxWaVhiQzNxSnp2bUhJbEJDZ1FH?=
 =?utf-8?B?MEhvNDN4aUdzWE5ncHpvOXFDL0p3bXdRYWplUXM4TmVsMVhpQnhCT1BXcDcw?=
 =?utf-8?B?QVYrUThXWmV5YTRyNVhuQ2M4WmNhUitDdTNod2pZN0hUck55dFQzWVhIbm5y?=
 =?utf-8?B?QUxZRHVMalg2bHplWGhwd1k4VXIvellzUHA4K09DbEk5TzJyTzV2Rm5JTlE4?=
 =?utf-8?B?MjRpeWlYaXJsSy9nRHV2UThzUkUySEJDWkVrYkxoYmRsVWhPSzl5UkQ2Qk5S?=
 =?utf-8?B?b2MydzhzeEI1VHpwbEdTY01OQ2dSVnVKd2VETzRKUDZoSHhrVEtMd2p4aGsr?=
 =?utf-8?B?SkxkcmZ4ZFE3U3pxZ09xNVFzWnBrRHNnUkVCYUhjYjAvbDVyZ3NiOVQxamRL?=
 =?utf-8?B?OFhBdFZkMy9SdXhuTnVtSks5R2paZktuV3NFcUhqdmZYOXdsUVcwNURQdzZB?=
 =?utf-8?B?aS9PaGV5akFxQVJBbWd4WFFkYUdGRS85UktnYWhIZER3QTBNSWtVZWx2alkv?=
 =?utf-8?B?amQ4ZTdwYTIvTWIvY0lkTGxRWXB2OTBTS3RjZWNwNUFKU21XUTg5NkxYdG84?=
 =?utf-8?B?cUd1QkgvdENZaGp2bkg4UUpGTnN3N2RwN1R1TnlRSEJlVHl2L0lCRlN4YTlN?=
 =?utf-8?B?K0dmdVQ2RUdxWVl1dmtFdDlBZ2xKRDJjYlk1ZEo3Mng0Q3JwVUlIRTZZZU1K?=
 =?utf-8?B?N3NXNWZmQ0hPamI2VTVkWDhMbWxrQ3plVkZ0OEZHUzJrbHNTTVVqMGRYWnc5?=
 =?utf-8?B?bXFuMnZUMmY5RUhOc2VsQ0JJNHhXWEVvRzdLUnBCVVVNSWlrMGxGV2krRFJa?=
 =?utf-8?B?Q3VJRUdwT0dvWE83eWV6VU9CRWxqd2pmYUZGMnd6QUhhRHl2Um1YZHJOQm1Q?=
 =?utf-8?B?bGQyZi81RnM4UTB2aERudWtlZGo4MnIraTdya3dSZXByN1BEeWwrdkx5aHJ5?=
 =?utf-8?B?T2p2V0MvWElFVHIzQkN2dXMxZk84V0hmZERwRzFiaHVSMjRkSTJHczZiSjZU?=
 =?utf-8?B?TDVtVjJEa1paUUVIb29LL09HcjRxRGNCLzNPcmxMaGtPcTVzYWxTZlJXUmlu?=
 =?utf-8?B?RDZGYjR0cGNNYkQwWUYxTFZtUTN1eFQ2c1hPMnBwYXR5SzdLcEhBWm00UUpC?=
 =?utf-8?B?TnpnRWtkY3I1TldTK3M3SFlUc29oK3VTakN0bUZ4N04yaW5FUjZadEt1N1h4?=
 =?utf-8?B?YjVUM0hrSnB2ejJibzB3TWs5WU1kTzRTRDR4YUJVQkUyWUw2Y2wxV1lLRVQz?=
 =?utf-8?B?ejI1eWtmRHZic0lIT21xc2JjQTdMa0JqcmRnOEZsVmVJYS9FblZnWGpEbHhs?=
 =?utf-8?B?SUJYVjA0aDN4Q2hRNjFIaXhLLzJESVJlSGFKcnAycXNMQnozQlRISVFYQlgv?=
 =?utf-8?B?Qlh6dDY2aGM2SzBVbldmRVhiSTJSdW5mQWNoUWVqZnUzcDA3S3VuK0NwM0Zp?=
 =?utf-8?B?UHFGMGs5TExjZXByUXdOa2JsdzlnUzRnTVAvd0J0RkVyeFdhczVnTTFsaXc1?=
 =?utf-8?B?d3o5eXRVeGFpSDgvUm9DaDVXUThZem92eFFqbERTc2NyeHgzcWdXUnBDUWQv?=
 =?utf-8?B?dGl1elNVNy91ZjdtYnBvQmxzTWRWOWQ0UkVKSGFLUkt6SGFLdS90OU8zOHYr?=
 =?utf-8?B?L0l6MnBjaE5KaUhON2h0eFRqSHlRR0NDeGRtTXM5RHNvTkhFS3VHZFRaQUxt?=
 =?utf-8?B?UGZqSUhvdlRvMFBxVVlBQm5tQmFXYklLY3lmKzg2bFNESW9BTXRFVGFnbHRC?=
 =?utf-8?B?VTNQdkZZM3piaGRVQnlqaFVmUTAvVEs1NFM0Z1diS0VESS9Qc2xGMzVMaTFH?=
 =?utf-8?B?em5XVkM1anZYYy8ySUo5UVIwUFlFMXpzNlVzS29yS0RZUjROeDBpUStLdGts?=
 =?utf-8?B?cEF0L3h5U3E4dzByS1hEY2VFNTZ2S2pYb3dYS1ZMVE1PQXRVVzNyOG9ZRXJ3?=
 =?utf-8?Q?417FeZtHHTbBqObYjOCCmVrA+?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6935.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3312d0-6ae9-44b4-ee75-08dc9c29d28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 13:04:21.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8q78k1wXO3rbhuoPdg7A1uEZ5WhC58gk2ksbkod3DsV3XXCn49ypOFt5jNnoidPwBl7kiYRYHmSAX5yuzsULuujumaNAprwOZb4W8MyxAcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7374
X-Proofpoint-ORIG-GUID: QjcI1qL-zyYMpTFHtAxYS2mBuayd3rCK
X-Proofpoint-GUID: QjcI1qL-zyYMpTFHtAxYS2mBuayd3rCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_09,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040093

DQo+IEZyb206IEphdmllciBDYXJyYXNjbyA8amF2aWVyLmNhcnJhc2NvLmNydXpAZ21haWwuY29t
PiANCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDMsIDIwMjQgNjowNSBQTQ0KPiBUbzogVGFuaXNs
YXYsIENvc21pbiA8Q29zbWluLlRhbmlzbGF2QGFuYWxvZy5jb20+OyBMYXJzLVBldGVyIENsYXVz
ZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJp
Y2hAYW5hbG9nLmNvbT47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBEYW4g
Um9iZXJ0c29uIDxkYW5AZGxyb2JlcnRzb24uY29tPjsgU2NobWl0dCwgTWFyY2VsbyA8TWFyY2Vs
by5TY2htaXR0QGFuYWxvZy5jb20+OyBTYSwgTnVubyA+IDxOdW5vLlNhQGFuYWxvZy5jb20+OyBK
YWdhdGggSm9nIEogPGphZ2F0aGpvZzE5OTZAZ21haWwuY29tPjsgTGludXMgV2FsbGVpaiA8bGlu
dXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBDYzogbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmF2aWVyIENhcnJhc2NvIDxqYXZpZXIuY2Fy
cmFzY28uY3J1ekBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwNC8xMF0gaWlvOiBhZGM6
IGFkNzA5MXI4OiBDb25zdGlmeSBzdHJ1Y3QgcmVnbWFwX2J1cw0KPg0KPiBgYWQ3MDkxcjhfcmVn
bWFwX2J1c2AgaXMgbm90IG1vZGlmaWVkIGFuZCBjYW4gYmUgZGVjbGFyZWQgYXMgY29uc3QgdG8g
bW92ZSBpdHMgZGF0YSB0byBhIHJlYWQtb25seSBzZWN0aW9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKYXZpZXIgQ2FycmFzY28gPGphdmllci5jYXJyYXNjby5jcnV6QGdtYWlsLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2lpby9hZGMvYWQ3MDkxcjguYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpSZXZpZXdlZC1ieTogTWFyY2VsbyBT
Y2htaXR0IDxtYXJjZWxvLnNjaG1pdHRAYW5hbG9nLmNvbT4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vYWRjL2FkNzA5MXI4LmMgYi9kcml2ZXJzL2lpby9hZGMvYWQ3MDkxcjguYyBpbmRl
eCA3MDA1NjQzMDUwNTcuLmM5ZTAxNGQ2YTc3YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8v
YWRjL2FkNzA5MXI4LmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNzA5MXI4LmMNCj4gQEAg
LTE1OSw3ICsxNTksNyBAQCBzdGF0aWMgaW50IGFkNzA5MXJfcmVnbWFwX2J1c19yZWdfd3JpdGUo
dm9pZCAqY29udGV4dCwgdW5zaWduZWQgaW50IHJlZywNCj4gIAlyZXR1cm4gc3BpX3dyaXRlKHNw
aSwgJnN0LT50eF9idWYsIDIpOyAgfQ0KPiAgDQo+IC1zdGF0aWMgc3RydWN0IHJlZ21hcF9idXMg
YWQ3MDkxcjhfcmVnbWFwX2J1cyA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX2J1
cyBhZDcwOTFyOF9yZWdtYXBfYnVzID0gew0KPiAgCS5yZWdfcmVhZCA9IGFkNzA5MXJfcmVnbWFw
X2J1c19yZWdfcmVhZCwNCj4gIAkucmVnX3dyaXRlID0gYWQ3MDkxcl9yZWdtYXBfYnVzX3JlZ193
cml0ZSwNCj4gIAkucmVnX2Zvcm1hdF9lbmRpYW5fZGVmYXVsdCA9IFJFR01BUF9FTkRJQU5fQklH
LA0K

