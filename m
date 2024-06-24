Return-Path: <linux-iio+bounces-6789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5D914109
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 06:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C59AB2287B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 04:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950B2F9D6;
	Mon, 24 Jun 2024 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="plN0MetC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F5DDBC;
	Mon, 24 Jun 2024 04:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719202868; cv=fail; b=f5b0Wt0vUITGnkfv976b0YlvtppVbqLFeBBa05VyuOsFGwCGMdRvVEl2RA4JCQXu6b2Ql1ytNvGLu8pXHRhx54eveJHyTQJe/u3kAlzsP6Db/3pIv5C8TmUhHRFvkMByE5b1e7I2Jo9mhRq7jYqvYFEzCg+ViIyx/axiQJnMA3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719202868; c=relaxed/simple;
	bh=Vmuy++UdL3ncNFK7kNrJtU4Ww0xoxE1dCgXnlf7u6mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnwdE6hJLqChgtn/CsLDUppNjjPHIjpottwCBxVwE1Te1SklnO/XAcsc9YFy3KpHEP2+SjvqgOXcw97hD+FiuXSmCRDANfYSnPZuKygzNMwk5i2+wzW67wTNUgiGBDTvJSmnlxddXM2rEdIZTJ3zlEpAfDOi3ByFZE4ktuvYxnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=plN0MetC; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O2Foc4021814;
	Mon, 24 Jun 2024 00:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Vmuy+
	+UdL3ncNFK7kNrJtU4Ww0xoxE1dCgXnlf7u6mg=; b=plN0MetCLoG2LQ3+tIcCx
	g4DuNsxiGnzzbW7XQuLsD53t+pJh+boixUDw2ySoUxcwa0IVhh5o0RGcMrWnGmO1
	XXVJARlj8x+kfMwDvPbQ98DiKl+C1gfKncCL1wEtiP62ymEk/yK/II8vxsemrKFL
	7f6Xn/nd/b0sDdCyiSe2XRcjmJtV2c8m2fskFivTUMmrjEPHXOwWVyEnbr6l+QHs
	rq5lj3crMmDct9x2r8M2T51aDepwXfjTUn+BPUJw4RbWqeBEVDikfm7bF4muudFd
	qAwZjQPCjj2S2ND9x7bQNtb+wor6Fn0ZQ63+vcgYlBLdSGP+sBciLLbfRb8HFKgl
	Q==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yxcxhtgqs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 00:20:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQzmHfyaoBx9WJxPE6EDIElZARn3WDIMHmr1CAVU//rnCa/tyVume5rgmdYd8xlO3NNfrWa/JvCw00POlstGFARShsCZglesU0xVlJHU5VXkxjP9zEOLFIbTJHmoVgtMCH1v5wdXBoLUq3ymiGV9mioFagnNOaC/Z9kCb40/Srxj06h3nK1PIchyTzDkDplISbwm/vrWZAqhQMatu8GDj1Ze3T9msoLC+kmIDngytmX2rET8t2X6+Duw+k2w/KeUZQ4xA/6V26nn3QiweK9pNDdE94xWiP7sYC7XDdF3eqRDgNlHsieRMEBYsWgVAmrBk4Waoy+GCeN1xTqyBJdVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vmuy++UdL3ncNFK7kNrJtU4Ww0xoxE1dCgXnlf7u6mg=;
 b=O2z3E/3gOvd5iJz0/GZq8SCRRJiaiJVeukbqpeHgdIQopw7WSGeARwaG7WPQmYX8fggdTo/mxWx9I6KHnp5Kv8F5zcYLxfbw28AB4vEMM3Cr7IwgvOde7GQwAsHVIKumfnGcJkhb+biepSV4Dq8oSOp0S4n1C5+zxO3hmtnxd/mVcgHBdFG7k98mQJj+sYKyy5NN93TXc68df6IlrEX3qSwd1jJIwe1Jyg9MjIrpFLSKR3pcci+SXV9r5NbcjuImowXGZZHj2vaRLWIH2cGNE9sOYN5zpG1y71TnRh+/HbBfIg1oji1QnDksyrWWmoodcApyc6Bw2En4kUjD9o0R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by SA1PR03MB7097.namprd03.prod.outlook.com (2603:10b6:806:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 04:20:31 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 04:20:31 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH 1/2] dt-bindings: iio: dac: add docs for ad8460
Thread-Topic: [PATCH 1/2] dt-bindings: iio: dac: add docs for ad8460
Thread-Index: AQHaov9yao6eFqhiPEOus/HrrILWXLGSOYsAgERb8dA=
Date: Mon, 24 Jun 2024 04:20:31 +0000
Message-ID: 
 <SJ0PR03MB6224EF896B41933AA0BA052B91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-2-Mariel.Tinaco@analog.com>
	<CAMknhBFXk07HbP_pPg5wkW-9Ah2-66kGzZFvcvBNrbjfguHb4g@mail.gmail.com>
 <20240511172500.718fe12d@jic23-huawei>
In-Reply-To: <20240511172500.718fe12d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYlhScGJtRmpiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVEUxTVRNek9ETXlMVE14WlRFdE1URmxaaTA0WXpGaExUYzBNRFJt?=
 =?utf-8?B?TVRVeU0yTmxPRnhoYldVdGRHVnpkRnd4TlRFek16Z3pOQzB6TVdVeExURXha?=
 =?utf-8?B?V1l0T0dNeFlTMDNOREEwWmpFMU1qTmpaVGhpYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?RXlPREEySWlCMFBTSXhNek0yTXpZM05qUXlPREk0TkRRM05EQWlJR2c5SWtS?=
 =?utf-8?B?YVJGQkhNVU16YWtkaVYwVXpVSGd4U0cwMWFqRllZVlJoZHowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWtVNVoweFpOMk5ZWVVGVE1WWkpZU3RCU3pncldF?=
 =?utf-8?B?eFdWV2h5TkVGeWVqVmpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|SA1PR03MB7097:EE_
x-ms-office365-filtering-correlation-id: 408915a1-2988-4af4-3f0d-08dc9404fc4f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|7416011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QzNNT1VJbnJsR3JybDVaMWhaMmo3MHJnemxxSDlaQzlUUG1oSVEvcDVNNlJJ?=
 =?utf-8?B?SHN0eEZjSjVGaVVlSS9KVnFyZW1HVzlTcGplY0U3aWdBanNHTGs2OWU5L3J4?=
 =?utf-8?B?OENGYVdGRGdKRG8vT0cwdm05OW9reHhBVkRMNGdNVHZ6L2Y3V3RvY2lJbk1w?=
 =?utf-8?B?eWZ6d1FRaGgxQ0YweHM1UHBPREp6YnhPWUNOMS9YMUpOOE5aakUxMUpJL3pu?=
 =?utf-8?B?bVFJamdwVnJoQUlncGN0emRZSU4xTTlrOGI4UThBMDdyTU9vUkJCZ2p4NUYy?=
 =?utf-8?B?cDZ1MTU1OE1MODZiallWMStLT2syYmhkTTJpbzRHL2x6K090Y08xOE5qUzZS?=
 =?utf-8?B?R2FqZjNac1dOQndmaW81OHpvcHFiVW9rdzBQR0pQa05tMXBSWUhONnVwS0ZU?=
 =?utf-8?B?dk5MWXZFWmNvQkZkbkgzTTVRaHZSNVIxem9TeldSejdKNXJKWEVyR21icWVy?=
 =?utf-8?B?S2dmYUplR2J4R2g4WThKVnpCU1Y3ZGdmZW9EVWRtSHVjakliVzRnMGROV0ph?=
 =?utf-8?B?ZEpLUzV4SFJSOW4yQkRod29JRjBjL3UrZkdweG5OMUV3VUdoc01QcCtrOFNG?=
 =?utf-8?B?SHVrYWdvWUgzUklmOGU5N29MVzRCZ3V1NXJ0enpKU0ZxWUk2ZWNuL1JiV2Uz?=
 =?utf-8?B?ZWx4aVZiL0Q5MlJUdkFGL2d1NHN3WGZJaXl2UGNqZm55a0twak1yVVkybnpa?=
 =?utf-8?B?M25aN0w5N1FRTjBzT3pGWldwM2RNbWl0clZrdWRIMHBucjJyd2gremw2TVdU?=
 =?utf-8?B?dkxzZ25rMnBqRWMzalAzc2RUNHplNzYyZXhEbm8zZ0FzWjIzczJTUUUyRmRx?=
 =?utf-8?B?dDJLTzJxdjRaU3NpWHl1Q0s3a20wTnpmazNlWUlpSGZkL1ozaHNaZGlPQ01I?=
 =?utf-8?B?VEtPb3oyTlM4SEI4aDhBWE41ZDJ0VEczdkY0TjRtQTNlY3RhUVhTVkFQWHJE?=
 =?utf-8?B?d2FDZ3dMbEFRSHp0ZmRMdXZudUZxNmx5ajVQbzdiQVd4RllrZWpvQnQ4bnpF?=
 =?utf-8?B?SkFURitHZDArM0RCYVhPdWFWWkE3QU5nUWx2ZnRnWS9xdzBJeXVYOU9TNVZa?=
 =?utf-8?B?TkI5SmFxUkdJeTVkMTU4azhiVFYwWTZZS0E2K3JqWXpabWZYQWQ5NXdHOFhF?=
 =?utf-8?B?dk1HQXlsRXU3Y1ZyT01LTHZTVVNxSzZZc3NUeVpKSXVQa1pQamZ2UDRiWktZ?=
 =?utf-8?B?YllqUmhwdDJyNXd2bEowbzZVcE4yZWIrNkphTG03dndYRHVaZHNGUE9rUzVD?=
 =?utf-8?B?QTJMNXBSN09GUEo3d0l0dEEyTVdyZTJJWHk2QkNWSG02aHJsa3B4SHdCMzVx?=
 =?utf-8?B?MHZSS3k0TFhwaFdEUFAyWk41ZjRDMGF6THRLd3d4Y2x3c3pUOUd2cUpRZ3ZS?=
 =?utf-8?B?WVdSVjhaMldmWTNobndIS20xWmczOHQ2QlZNZnZFUVBwSGxGekdJMGFOaGoz?=
 =?utf-8?B?UUpEVXVWZnZIcmlMamFWMlN5ODk2VEJac3IrVzFTOWk4elJmR3RKR1pOeWQx?=
 =?utf-8?B?RXBmY0NJbUh0dExLUitlT09XTXU4MVJ5VnNBeW5ybEVJVm1mUnFJc01LdjZK?=
 =?utf-8?B?bVlKVm1oZ1VsZ0tDKzRsZ1RCK2F3cFU1UWlsdUVEUkg4MmpTQ1NqYUdnSmdL?=
 =?utf-8?B?YXFwVjlheEwwVXJDNUZRRmpqOXdEdEhza0tKSFdET0JJUFRMeDA1dVBIM3No?=
 =?utf-8?B?b25OblhGeDVwOEFlUDJyTExGWVZlS0kyY3pXWndXaUx5UllBcUxrdzZQZ2NS?=
 =?utf-8?Q?o9kAWyaFBit6XjMGAaGRKTDM7KpYCA3woKRz/nl?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MGVTZGZvYi9ieFZuT2pGYjVlUUZncG5yNE5NV2JGRVNtMU4veXN5Z21iZUYr?=
 =?utf-8?B?S2VRb3dNcVRwOWt2cit5dHRsaWdsZnh5VEh2RnpYaFpzWnE1NEMrcTd1SG55?=
 =?utf-8?B?c1g5YnZHemhpMzMwbVhpWHUvQXZjUDZlRWxNUmZub1hoSDdVZ2NJWlVsTk9z?=
 =?utf-8?B?djBJOTYwdWtrc3lCNy9sRkZsU0RJOGNPQTlWWnEzRU11SWdmWE5PWm5SY3dr?=
 =?utf-8?B?K1RINm56RXFUZjcyN3FieS9ON2lhekhuMEZzcURnVFBjR0JRdUFCT2o3N0Js?=
 =?utf-8?B?dmhPSXBqYkQrU055RUlGVGJvdUo5ZU9tUHFoY1lQS0MrT2hBQ1lxT1lqaHFN?=
 =?utf-8?B?WFlEeUtLdXRCd1lVQ0RDMHVkbVQxRUxSQkg1OTJMTlBjUzlNSittMCs2a0tr?=
 =?utf-8?B?eUF4ak1tcXQzOGVHT1hOdUZLRUR6dmRPM3paMWUwV2tVMEtyWFpiRERDTDBS?=
 =?utf-8?B?RlRoaXFmWWZlTGJBRUV2M0hrcWtwM3ZVdC82UllLM2J5RE9ORE1IQ0xLS3p1?=
 =?utf-8?B?SzlKMU1JSEZCQzQ0bWJVd2M4T2UxSVErZ21md3g1Tnk2M3BBSm9iekNwQlZN?=
 =?utf-8?B?eWhzOXBpYVVSbkJuak1lM0VpdlM5c2FBSUtuZ3laUUNYcFU2bjFIZThqUnJB?=
 =?utf-8?B?WTYyNnpESnBxYWdXRVNodSthLzdnUXVSb0o1S1ZjVC9RQlUxT2QxY1VPQ0Y0?=
 =?utf-8?B?ZW81RTdSNml5c3IrdmhFQXhHZTZwb1VTZ2YwZ0lLdkkzZXRoT2w5Mzk4SStH?=
 =?utf-8?B?OXI5cHN1QjJFZVR0Z25VSHczLzAvbE03OUh2bHVYdWpFR1BQN3B3SnB3aWlZ?=
 =?utf-8?B?THN5S1UwZkZ4NFZmdlc5VDZiUTBJM2w0dENXU3ZWb1MwTmxmNGZwUGtPelVk?=
 =?utf-8?B?T2xETDlacVV2QkhNbFJOUDhMVXppU3Z0aThjNFZCTEVlVDZRZWFDeVBZazVl?=
 =?utf-8?B?ZDBDV1U2azJHN0JJWGxIQStxeEV4OS9UOXZaZTcrTklyTWEzQzdqS1N6MEN0?=
 =?utf-8?B?ZG1YRjk5TkpTUi8xL0t3cXNYb1k4RnFzQ0xybDQyMjRaVjlsdmpQSU5hZ3I3?=
 =?utf-8?B?UkFybFg5ZDR5eURTS2wrYmFGL3hteXZ1WHgvYkJEb3FPQ2hBWnhsNmNYdzFD?=
 =?utf-8?B?aVBvekJ6SnpCcW95Vi9DdDhXQXRhL3BMUThiRUtGbnFSbmFDa05yRURoM2Zk?=
 =?utf-8?B?K2ZPOFdaT1IzbE9LSitteGxKYmZGcG1zd1M2Z01ldXRqdzhQUlRmMXE2ZUhs?=
 =?utf-8?B?WWJKd25Vbm52dzBJZDRRZXhTTnRoczM2YXd5dUlJS1RWRFlzejc1SWhXZXkz?=
 =?utf-8?B?djdPcFVXamZtVWZKZGF1Q0NJeE05eFdNeThCWVF2QzRzVnNLVHVwRDNzam5Y?=
 =?utf-8?B?aEtTOFVuR0RNUGdlRE1XTEVCSjhmamdmNnZ0OHIzOFJtNnRCcTZrMlVrSzla?=
 =?utf-8?B?a1RsbGFNT3k4KzlKbUpjQS8reUdRR2RJL0RhOHNFaWZ1ZUd2dmdURjhXc2t2?=
 =?utf-8?B?RmFQWDAxNFVTbGRWRFFNeWRYT0dmbkN5MmlmV2pCMGs5Q3Jnb1U0MUUveS9u?=
 =?utf-8?B?czJKalFNeFpqeW1zK3pxRjBUK3AvMHFVajd1M1N3VUVicmNhYjJXSHE0RHBs?=
 =?utf-8?B?VzU0ZDhIaTZiL2Q2Z3ByTjd2NTR1V3RUdUhUNGZLSHl0WUhhZkZFS1J5bDZr?=
 =?utf-8?B?Y0dwZDhLQWE1cXlZb0NRclhqL1hwdnMwemRYNWlyTzNjRWtDcExJYjQ5SzBU?=
 =?utf-8?B?aDVtMXRSblNDTzBveFV2Z2k2RVFGVHY5cFZFVStqblhOVzZYNmlJMjdkOXla?=
 =?utf-8?B?dkd2TUk4Q0QvakR5a2FFbkpGSEZWNTVscUhlKzlEblMyK2s0Sm9EMG9ObjhF?=
 =?utf-8?B?ZG9Eb0p6NWEvOFFzOHlEVEhpeFBIdnNZSEJ5dFFZZ3VkaHVGekVZeXFLczdq?=
 =?utf-8?B?TnNKdis1cDFlb1BZMmd2eS9zTjlzTHNRRXVkMGovaTIzVS9CcTZRSnBxcHF4?=
 =?utf-8?B?U3NPeXV4b240QXdUNXJkSXN2TVRSNEM3b1RaN0c1Rmw4MjVUMEMrM0VRckZC?=
 =?utf-8?B?QzhjWmdUUkV6QVM0akZIYnloZW9jakhFT3RIZ3FsRzUvTGpQVVhVeDYvYjFl?=
 =?utf-8?Q?RCvcSp+dPAIa05ccxbTvp5myX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 408915a1-2988-4af4-3f0d-08dc9404fc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 04:20:31.3475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x24eBFQUBZaLud4GZhe3TogaZ3WQcfByTi93WVwAmf7LnBk5mFWR184pjuQR8K8RAXzeCFBIbqedWswCpX/bjFSgHVKS8URYU77DzanNjfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7097
X-Proofpoint-ORIG-GUID: WAnzwNv24rkYR9vgXTTDjY3bUpzjcXCB
X-Proofpoint-GUID: WAnzwNv24rkYR9vgXTTDjY3bUpzjcXCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_03,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240032

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBNYXkgMTIsIDIwMjQgMTI6MjUg
QU0NCj4gVG86IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gQ2M6IFRp
bmFjbywgTWFyaWVsIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5jb20+OyBsaW51eC1paW9Admdlci5r
ZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6
aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTGlh
bSBHaXJkd29vZA0KPiA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVA
a2VybmVsLm9yZz47IEhlbm5lcmljaCwNCj4gTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5h
bG9nLmNvbT47IE1hcmNlbG8gU2NobWl0dA0KPiA8bWFyY2Vsby5zY2htaXR0MUBnbWFpbC5jb20+
OyBEaW1pdHJpIEZlZHJhdSA8ZGltYS5mZWRyYXVAZ21haWwuY29tPjsNCj4gR3VlbnRlciBSb2Vj
ayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmlu
ZGluZ3M6IGlpbzogZGFjOiBhZGQgZG9jcyBmb3IgYWQ4NDYwDQo+IA0KPiBbRXh0ZXJuYWxdDQo+
IA0KPiBPbiBGcmksIDEwIE1heSAyMDI0IDEyOjI4OjE5IC0wNTAwDQo+IERhdmlkIExlY2huZXIg
PGRsZWNobmVyQGJheWxpYnJlLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIEZyaSwgTWF5IDEwLCAy
MDI0IGF0IDE6NDLigK9BTSBNYXJpZWwgVGluYWNvIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5jb20+
DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFRoaXMgYWRkcyB0aGUgYmluZGluZ3MgZG9jdW1lbnRh
dGlvbiBmb3IgdGhlIDE0LWJpdCBIaWdoIFZvbHRhZ2UsDQo+ID4gPiBIaWdoIEN1cnJlbnQsIFdh
dmVmb3JtIEdlbmVyYXRvciBEaWdpdGFsLXRvLUFuYWxvZyBjb252ZXJ0ZXIuDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogTWFyaWVsIFRpbmFjbyA8TWFyaWVsLlRpbmFjb0BhbmFsb2cuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2JpbmRpbmdzL2lpby9kYWMvYWRpLGFkODQ2MC55YW1s
ICAgICAgICAgIHwgNjcgKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA3ICsrDQo+ID4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4g
PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9hZGksYWQ4NDYwLnlh
bWwNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vZGFjL2FkaSxhZDg0NjAueWFtbA0KPiA+ID4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9hZGksYWQ4NDYwLnlhbWwNCj4gPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAwMDAuLjkyNGY3NjIwOQ0KPiA+
ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9kYWMvYWRpLGFkODQ2MC55YW1sDQo+ID4gPiBAQCAtMCwwICsxLDY3IEBADQo+
ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNl
KSAjIENvcHlyaWdodA0KPiA+ID4gKzIwMjQgQW5hbG9nIERldmljZXMgSW5jLg0KPiA+ID4gKyVZ
QU1MIDEuMg0KPiA+ID4gKy0tLQ0KPiA+ID4gKyRpZDoNCj4gPiA+ICtodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaWlvL2RhYy9hDQo+ID4g
Pg0KPiArZGksYWQ4NDYwLnlhbWwqX187SXchIUEzTmk4Q1MweTJZITZnR3M3S2JBSDNCR3F3TGNH
TTBZaWhkOVU0emRuY1QNCj4gYWkNCj4gPiA+ICtlUXpnNmVfZTVjTjRmbDJOblRZanJvNHIzRDJi
cXluS3VPSERUbkx3LWNCTjc0eCQNCj4gPiA+ICskc2NoZW1hOg0KPiA+ID4gK2h0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUN
Cj4gPiA+DQo+ICsueWFtbCpfXztJdyEhQTNOaThDUzB5MlkhNmdHczdLYkFIM0JHcXdMY0dNMFlp
aGQ5VTR6ZG5jVGFpZVF6ZzZlXw0KPiBlNQ0KPiA+ID4gK2NONGZsMk5uVFlqcm80cjNEMmJxeW5L
dU9IRFRuTHcxMXpjMk9IJA0KPiA+ID4gKw0KPiA+ID4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBB
RDg0NjAgREFDDQo+ID4gPiArDQo+ID4gPiArbWFpbnRhaW5lcnM6DQo+ID4gPiArICAtIE1hcmll
bCBUaW5hY28gPG1hcmllbC50aW5hY29AYW5hbG9nLmNvbT4NCj4gPiA+ICsNCj4gPiA+ICtkZXNj
cmlwdGlvbjogfA0KPiA+ID4gKyAgQW5hbG9nIERldmljZXMgQUQ4NDYwIDExMCBWIEhpZ2ggVm9s
dGFnZSwgMSBBIEhpZ2ggQ3VycmVudCwNCj4gPiA+ICsgIEFyYml0cmFyeSBXYXZlZm9ybSBHZW5l
cmF0b3Igd2l0aCBJbnRlZ3JhdGVkIDE0LUJpdCBIaWdoIFNwZWVkDQo+ID4gPiArREFDDQo+ID4g
PiArDQo+ID4gPiAraHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9j
dW1lbnRhdGlvbi9kYXRhLXNoZWV0cw0KPiA+ID4gKy9hZDg0NjAucGRmDQo+ID4gPiArDQo+ID4g
PiArcHJvcGVydGllczoNCj4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiArICAgIGVudW06DQo+
ID4gPiArICAgICAgLSBhZGksYWQ4NDYwDQo+ID4gPiArDQo+ID4gPiArICByZWc6DQo+ID4gPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiArICBzcGktbWF4LWZyZXF1ZW5jeToNCj4g
PiA+ICsgICAgbWF4aW11bTogMjAwMDAwMDANCj4gPiA+ICsNCj4gPiA+ICsgIHZyZWYtc3VwcGx5
Og0KPiA+DQo+ID4gSXQgd291bGQgYmUgbmljZSB0byBtYWtlIHRoZSBwcm9wZXJ0eSBuYW1lIG1h
dGNoIHRoZSBwaW4gbmFtZSBzaW5jZQ0KPiA+IHRoZXJlIGlzIG1vcmUgdGhhbiBvbmUgcmVmZXJl
bmNlIHZvbHRhZ2UgaW5wdXQuDQo+ID4NCj4gPiByZWZpby0xcDJ2LXN1cHBseToNCj4gPg0KPiA+
ID4gKyAgICBkZXNjcmlwdGlvbjogRHJpdmUgdm9sdGFnZSBpbiB0aGUgcmFuZ2Ugb2YgMS4yViBt
YXhpbXVtIHRvIGFzIGxvdyBhcw0KPiA+ID4gKyAgICAgIGxvdyBhcyAwLjEyViB0aHJvdWdoIHRo
ZSBSRUZfSU8gcGluIHRvIGFkanVzdCBmdWxsIHNjYWxlDQo+ID4gPiArIG91dHB1dCBzcGFuDQo+
ID4NCj4gPiBJIGRvbid0IHNlZW4gYW55dGhpbmcgaW4gdGhlIGRhdGFzaGVldCBuYW1lZCBSRUZf
SU8uIElzIHRoaXMgYSB0eXBvDQo+ID4gYW5kIGl0IHNob3VsZCBiZSBSRUZJT18xUDJWPw0KPiA+
DQo+ID4gPiArDQo+ID4gPiArICBjbG9ja3M6DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUg
Y2xvY2sgZm9yIHRoZSBEQUMuIFRoaXMgaXMgdGhlIHN5bmMgY2xvY2sNCj4gPiA+ICsNCj4gPiA+
ICsgIGFkaSxyc2V0LW9obXM6DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBTcGVjaWZ5IHZhbHVl
IG9mIGV4dGVybmFsIHJlc2lzdG9yIGNvbm5lY3RlZCB0byBGU19BREogcGluDQo+ID4gPiArICAg
ICAgdG8gZXN0YWJsaXNoIGludGVybmFsIEhWREFDJ3MgcmVmZXJlbmNlIGN1cnJlbnQgSV9SRUYN
Cj4gPiA+ICsgICAgbWluaW11bTogMjAwMA0KPiA+ID4gKyAgICBtYXhpbXVtOiAyMDAwMA0KPiA+
ID4gKw0KPiA+DQo+ID4gSSBzZWUgbG90cyBtb3JlIHBpbnMgb24gdGhlIGRhdGFzaGVldCwgbWFu
eSBvZiB3aGljaCBzaG91bGQgYmUgdHJpdmlhbA0KPiA+IHRvIGFkZCBiaW5kaW5ncyBmb3IgKHdl
IHByZWZlciB0byBoYXZlIHRoZSBiaW5kaW5ncyBhcyBjb21wbGV0ZSBhcw0KPiA+IHBvc3NpYmxl
IGV2ZW4gaWYgdGhlIGRyaXZlciBkb2Vzbid0IGltcGxlbWVudCBldmVyeXRoaW5nKS4gUG90ZW50
aWFsDQo+ID4gY2FuZGlkYXRlczoNCj4gPg0KPiA+IHNkbi1yZXNldC1ncGlvczogKGFjdGl2ZSBo
aWdoKQ0KPiA+IHJlc2V0LWdwaW9zOiAoYWN0aXZlIGxvdykNCj4gPiBzZG4taW8tZ3Bpb3M6IChh
Y3RpdmUgaGlnaCkNCj4gPg0KPiA+IGh2Y2Mtc3VwcGx5Og0KPiA+IGh2ZWUtc3VwcGx5Og0KPiA+
IHZjYy01di1zdXBwbHk6DQo+ID4gdnJlZi01di1zdXBwbHk6DQo+ID4gZHZkZC0zcDN2LXN1cHBs
eToNCj4gPiBhdmRkLTNwM3Ytc3VwcGx5Og0KPiA+DQo+ID4gSXQgYWxzbyBsb29rcyBsaWtlIHRo
ZXJlIGlzIGEgcGFyYWxsZWwgaW50ZXJmYWNlIGZvciBkYXRhLCBzbyBJIHdvdWxkDQo+ID4gZXhw
ZWN0IHRvIHNlZSBhbiBpby1iYWNrZW5kcyBwcm9wZXJ0eSB0aGF0IGxpbmtzIHRvIHRoZSBQSFkg
dXNlZCBmb3INCj4gPiBoYW5kbGluZyB0aGF0Lg0KPiA+DQo+IFVsdGltYXRlbHkgeWVzLCBidXQg
dGhlIHBhcmFsbGVsIGludGVyZmFjZSBtaWdodCByZXF1aXJlIHNvbWUgZGVjaXNpb25zIG9uIGJp
bmRpbmcNCj4gdGhhdCBhcmUgbm9uIG9idmlvdXMgdW50aWwgaXQncyBhY3R1YWxseSBpbXBsZW1l
bnRlZC4gU28gbWF5YmUgZG9uJ3QgbmVlZCB0aGF0DQo+IGJpdCBmcm9tIHRoZSBzdGFydC4gIFRo
ZSByZXN0IEkgYWdyZWUgc2hvdWxkIGJlIGhlcmUuDQo+IA0KDQpBZGRlZCB0aGVzZSBwYXJhbWV0
ZXJzIHRvIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5ncy4gTm90IG5lY2Vzc2FyaWx5IHRvIHRoZSBk
cml2ZXINCg0KPiA+DQo+ID4gPiArcmVxdWlyZWQ6DQo+ID4gPiArICAtIGNvbXBhdGlibGUNCj4g
PiA+ICsgIC0gcmVnDQo+ID4gPiArICAtIGNsb2Nrcw0KPiA+ID4gKw0KPiA+ID4gK2FsbE9mOg0K
PiA+ID4gKyAgLSAkcmVmOiAvc2NoZW1hcy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbCMN
Cj4gPiA+ICsNCj4gPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiA+ICsNCj4g
PiA+ICtleGFtcGxlczoNCj4gPiA+ICsgIC0gfA0KPiA+ID4gKw0KPiA+ID4gKyAgICBzcGkgew0K
PiA+ID4gKyAgICAgICAgZGFjQDAgew0KPiA+ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
YWRpLGFkODQ2MCI7DQo+ID4gPiArICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ID4gKyAgICAg
ICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDgwMDAwMDA+Ow0KPiA+ID4gKyAgICAgICAgICAg
IGFkaSxyc2V0LW9obXMgPSA8MjAwMD47DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgdnJl
Zi1zdXBwbHkgPSA8JnZyZWZpbz47DQo+ID4gPiArICAgICAgICAgICAgY2xvY2tzID0gPCZzeW5j
X2V4dF9jbGs+Ow0KPiA+ID4gKyAgICAgICAgfTsNCj4gPiA+ICsgICAgfTsNCj4gPiA+ICsNCj4g
PiA+ICsuLi4NCj4gPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+
ID4gPiBpbmRleCA3NThjMjAyZWMuLmRhZTkzZGYyYSAxMDA2NDQNCj4gPiA+IC0tLSBhL01BSU5U
QUlORVJTDQo+ID4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+ID4gQEAgLTEyMzQsNiArMTIzNCwx
MyBAQCBXOiAgICAgICBodHRwczovL2V6LmFuYWxvZy5jb20vbGludXgtc29mdHdhcmUtDQo+IGRy
aXZlcnMNCj4gPiA+ICBGOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by9hZGMvYWRpLGFkNzc4MC55YW1sDQo+ID4gPiAgRjogICAgIGRyaXZlcnMvaWlvL2FkYy9hZDc3
ODAuYw0KPiA+ID4NCj4gPiA+ICtBTkFMT0cgREVWSUNFUyBJTkMgQUQ4NDYwIERSSVZFUg0KPiA+
ID4gK006ICAgICBNYXJpZWwgVGluYWNvIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5jb20+DQo+ID4g
PiArTDogICAgIGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ICtTOiAgICAgU3VwcG9y
dGVkDQo+ID4gPiArVzogICAgIGh0dHBzOi8vZXouYW5hbG9nLmNvbS9saW51eC1zb2Z0d2FyZS1k
cml2ZXJzDQo+ID4gPiArRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vZGFjL2FkaSxhZDg0NjAueWFtbA0KPiA+ID4gKw0KPiA+ID4gIEFOQUxPRyBERVZJQ0VTIElO
QyBBRDk3MzlhIERSSVZFUg0KPiA+ID4gIE06ICAgICBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5j
b20+DQo+ID4gPiAgTTogICAgIERyYWdvcyBCb2dkYW4gPGRyYWdvcy5ib2dkYW5AYW5hbG9nLmNv
bT4NCj4gPiA+IC0tDQo+ID4gPiAyLjM0LjENCj4gPiA+DQo+ID4gPg0KDQo=

