Return-Path: <linux-iio+bounces-5454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8478D3AC6
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10083284A97
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7871802B6;
	Wed, 29 May 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0ctH5Hgb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B317DE0F;
	Wed, 29 May 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996363; cv=fail; b=WZmojn3DsdpKEWeW9kSZlrFri6EQNpF3bHZ/1bqZdVNcVYFgZNTHsVtKe41SjEUpgE4DkSu4/XJTtCgMtnL0riWwy7XMLEq4PUkYRtviW2b8ITHb9It6+pOzMDRXTG32jskqAEm8Ln7EYdI43sOE68XPCSCmMGBXzyevHq3MJys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996363; c=relaxed/simple;
	bh=zu8vZStklLH1PToP3gMqHG3cPOZE2qrHM4aM1ge9t4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fLosE263OiptowuY0yTEgJG7DBN0La/8nhLvr4GXBOj8uwZrLV/nfMzXScYh/7zGr+zuFi0F79jA5/YNLhNV3pg4kCQXHx9Nej9LjmKCFdt3Fsdz/g+SELAeSPmqfjbi2mp5Ax9MtY5uRjIsucjvKgcDeHrChqeCCrhVIU27BpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0ctH5Hgb; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TCT1ZS031084;
	Wed, 29 May 2024 11:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zu8vZ
	StklLH1PToP3gMqHG3cPOZE2qrHM4aM1ge9t4k=; b=0ctH5HgbjVOH5ExvqGo9+
	I38P3QwB2HfhIkzH1vUfkPEYngWYLCaJA+oINTROfrB/+WmkvlOpT/MzeuM6kSwi
	GGlymM02UBeCIt9gz8MVy4zaSWgY/AaIUTUXKaeLfBWs11kmwDUX9XhxIsfd2SgA
	P/MxCKF4rp/dZrvlRDpuPW5a8MHCtz0U2zWaKiqs81gLzMBYCLEvZ6SNv/WsMyF3
	b9FLNogEVCZsLjuq97y46Erg/QVJcrlCtkOxWxt8yOXKoE7Ntnf2AHKcH6X60Q/B
	xLbbIMZ4zmq/mLtepYRdSf7OIHijidqfGkrS+eLp6+YTG77YymEzoJmFYsab121u
	g==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yb9vpqt3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 11:25:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDiXSrAZsvB9Oopbv0Nk+ffu9N1Jp5hNdWwT8+XqoLG0Mxv2g4A0LzU65CdXK74aWElqX09vFPOjEqPCzQkH6e9UkSZOlHvnd2UlimvLs2Xb4K5SSIFtx0ixLJ2KWRJmpzgC+16+HITzehHuZQQp/6XL6gYe6J6jjMDHwEnaPt+HsNGoy/aTlWhxELxpjJruTlOs/v41iGe34UhqkUhiqGrmQV4cPLkPbbYaXCDgFXBkBF7Rq1hml5EJOf/iE2Qn19KZQk/6fw8sF7ctoUHqxSHAR54ei4p7kay6w1hd2mVnT1zMA2WlRa4f/BC5ympIdzj9+8e8GW7Ii8W7PIPA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu8vZStklLH1PToP3gMqHG3cPOZE2qrHM4aM1ge9t4k=;
 b=f8ucPhL3g9zMuV6nNgMrVbhQ9dwJkzyeA6KcCTA0noqY3CetxUwa29axk19oOAfVnNPMR918MHPpNY0/UoGLFAh3xUwqVrM5S9E64HFPUG02LtBRK7s8Nx3cg8X96VYJmrIwSVl/M21Jq0Tvqyg/5AETJJoGeoR1E11Y4jVA6Ke7Aq7vgixPN087Lsgv2Hg/l1qGbRFGHjKYC0pkRdeiVDIzwf7JEfiJV3UXLJMQbbIz6oxxsJSQzMR0YXhxvVaZmu14g9Akow44bvWU3vo0tPmU6bzkTkSkUn+fU0FordyGjvqg74g8eFFFhESyvRo5ATX5NyglpHzQA5QK0uP6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by PH0PR03MB6739.namprd03.prod.outlook.com (2603:10b6:510:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 15:25:38 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 15:25:38 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: iio: adc: add a7779 doc
Thread-Topic: [PATCH] dt-bindings: iio: adc: add a7779 doc
Thread-Index: AQHarD/tfbO/GiZ2gUGrOSLHW8/0a7GjQOMAgAsaK0A=
Date: Wed, 29 May 2024 15:25:38 +0000
Message-ID: 
 <SN6PR03MB4320A1D0DDCFBEED28319815F3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240522120208.18575-1-ramona.nechita@analog.com>
 <efb07835-8894-43d0-9fe1-14cb865db135@kernel.org>
In-Reply-To: <efb07835-8894-43d0-9fe1-14cb865db135@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY201bFkyaHBkR0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFpTWpWbE9EYzJOaTB4WkdObUxURXhaV1l0WW1Jd1l5MHdNR1V3?=
 =?utf-8?B?TWpJelpXWTNOR1JjWVcxbExYUmxjM1JjWWpJMVpUZzNOamd0TVdSalppMHhN?=
 =?utf-8?B?V1ZtTFdKaU1HTXRNREJsTURJeU0yVm1OelJrWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhPVFkySWlCMFBTSXhNek0yTVRRMk9Ua3pOekF3TWpZMU5qRWlJR2c5SW5B?=
 =?utf-8?B?MlNtNTBaakZOVEROS2RqRkZlV1I2TUU5TU5GRkxaRFpXV1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWtKc2NtZ3dNMHhJWVVGWWVYQnpNMnA0V21WVVRt?=
 =?utf-8?B?WkxiWHBsVUVac05VMHdSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|PH0PR03MB6739:EE_
x-ms-office365-filtering-correlation-id: d53c4441-3adb-46f8-b615-08dc7ff39811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M2xWVEVUeGVuV3RDMjFtZEpaV2xRaExzYzN5YlMzaTdGT3MyVnd6WXNPRHB3?=
 =?utf-8?B?NjhIazBtV2lRSXhKY1lZZnluOFBkVzF1ajdqYzl1L0RJMUEzVkRCRGhmb0RE?=
 =?utf-8?B?TzFId0FSb2VWaUhVQzErQno1WFRLUTg2Yk5EdXFTMWQvdEc3cG9Tb2xyaW5U?=
 =?utf-8?B?eVFXd0ZWVDFKc1N5alpsRm03amV6VWVrc2ZxZHRkd3puV3haQ0lCSGpmaUZu?=
 =?utf-8?B?enZVUUY1SjU1S0NUNGdXeTJyUDE3dWZQQlFmdSt5d3BhLzlja210UDQxYTVs?=
 =?utf-8?B?NHZTRE9WSWJPcUxDNjBsTjdjeVNEZEhpR1RvZ1pySU8rLytWdjZrVWRqYjVr?=
 =?utf-8?B?Z3Q1TGtHTUlxd2o1WU1KT01HTzYxL1VHbXN1TGg5Qmh3eTZ6cDgyVExKM2VP?=
 =?utf-8?B?QTNsVGYvUTl6bFMyYnVWNUhMQjNET2JIREpsQXFkZUp5cUtvN25vQVc5WWd0?=
 =?utf-8?B?cWpXYTR3QXRyMFpVdkE2ZzU3ZTJ3VUI5YXMreFBvNkJKbTNWZUIvbWplRGd2?=
 =?utf-8?B?LzZSSSsxUitITmQrT09jcTBPQnI0S0wydG15SDZ4WEgzOGN4WUlRZVZNbjZR?=
 =?utf-8?B?d2F2WGFHQlAwS1VsSVJIVnFRVVIrcUozaXE2VmxIeUFGSU9VczlOUk4waENG?=
 =?utf-8?B?bzhTeUhid1Fyb01xZy9TVmVmYk5qOExmVk0zREFJV2gzMXltV05ic3RPWUlN?=
 =?utf-8?B?TnkrSStWeFZaZnFnWlhteFdkbzB0YW9oUlBFUE5JOE4yMVV4NjNnb2V2Rk1L?=
 =?utf-8?B?N3R2ZE52eDcwMVVnNmxXaEpkazJiaG8rQ0UvZ0g2Q2NsQ0VFcXh5VFhBdHdW?=
 =?utf-8?B?QzIrR0tEcHNvaE5tcElVUERWM0todzVSMWk0Q0VOQjBSREp4MmhBK3BZNkk1?=
 =?utf-8?B?NDU3Z0pObE5WSzBvNzBQU2xCWndYMXFGNEoxZE5XcGxmU1hFY3hKRkRKUTVW?=
 =?utf-8?B?K3RyTXFuVXlYNWlDdFZ5UjN6TkQveDUwUmE0b2pnVEpvRXZiTlQ0NVBLaVJK?=
 =?utf-8?B?QlBDOERJWnhVbGtSZUFsUytYcVREZXRuaEtnREp1UGVkc0NUWWdoSGFHeUVC?=
 =?utf-8?B?aEpQbXRscEFQQys3TkFkZzgya0V4bGNjZ25MNXV1Um5LRHpjelR5ZS82Qjdl?=
 =?utf-8?B?N1BBNTdVeDV2ZWlOWVo4RzBrUHhyaG44djYrOVkwSStYaTE4WFl0V0tlZGRK?=
 =?utf-8?B?QU9Bci9KWmxjcWhHOWw2eHNFUER3MTAwWkZMWGRFSldYQXgzUklwclo4RWEr?=
 =?utf-8?B?cEc1dmlyRFNhYk1HcEZkeXNqUjNTcm5ueHdJdkNudkVUSHM5b2ZDN3crRFQy?=
 =?utf-8?B?ai8vOXl5Zm1NVHhJVHMxRXl2M2Y4bEJOWDQ5TnZOL0xzdWFGczdhZG1pYVZx?=
 =?utf-8?B?MlRVV1IrM0xqNGh0RGV4N1NMbmVUQUx3cFB3aVc3OWpaSnIzUTVud1FGRUVI?=
 =?utf-8?B?UjBmY0lNY25MdVZwcDVENTU3K3o2ckFXSWM3cU1YYjVYaDRtM21tSThxRGla?=
 =?utf-8?B?eEtYbXJ0cU1HWUpkZ3ZERlR1akM2OEtuUVcxbzY3YmxNMmFUOVg5ZTY0OCtB?=
 =?utf-8?B?aGVyODJuT2wzWklvcGE3OE9odTYySXlKcE1VT25HT0tDNDRsemsrNjlITExy?=
 =?utf-8?B?VmJEZFJPU2dlZXlMKzdnTFJVT2N6YnN0aXRGVVc3WTN3dzJjajZ6WVphRlJ4?=
 =?utf-8?B?NXh3U1FPdk5ROWkvNjB2VVJCOVRYSzZuZVdHUlc0cnNKYjA1WERoeGhDeVNR?=
 =?utf-8?B?QmE1Q2hDK2QwdWxDMHlOa0VRK0poRFVyQ0Z5R3lpM2J6RHExakRYdDMxRjRu?=
 =?utf-8?B?bjQ1ajFDeWhtcjI5Y2pyZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aGpPVk9yWms4UURicnZBRTROYWhyVmExTFdMRC85bFo5cTh5SFNFbURqVWdp?=
 =?utf-8?B?U1A3YVI4K3paVFQ2RzNydk55UzZhUGIxdWZSSlR6Q0tPc0hXTFZIOHR4QjVi?=
 =?utf-8?B?bmZMbjNvclNiVExoOEpsYmx5Tkg4K01VVG1PM1FlMGM3ZU5DeHpWRjkzODJW?=
 =?utf-8?B?VXJiYkI3SFJkOHErRTNJNEozTkxDOTkyelhpUkpxa2hFK2ZlNGtJZzlyVkhp?=
 =?utf-8?B?REk2WmlUTlRxN0xPRG9jOGFFNFRBRlRYTlRRZnR4Z3NMN2RQWlA4N0FBZ1Iy?=
 =?utf-8?B?MHdYZ2hKYlNTN3RNb0xYMjMvTWwzS1FkVlV4WTJJekZCUHlGcDZ3eUkvQ1dD?=
 =?utf-8?B?czNzV2k1K0lQUnNvcU03WHk5WVJnRkhaeHlGUGxCT2RCRndsZ1ZNVnhNU1hZ?=
 =?utf-8?B?ckdQaVZ1T09PM1g4YjUveTFHNzdhZXNtZFRQQ0ZrN25SQW1OK1hyekljaFZH?=
 =?utf-8?B?dTA5YmZ0ZVJmNVVSK25BbllQWVhSSVRBZE5iVFlHamNORTZ5emZBekpoUGUw?=
 =?utf-8?B?bTdZUUVtZHZ4ZFJxWWY3S20xbDhQZUVRSTNIUlIzOEtjL2hzMW5VVVBRRkJ6?=
 =?utf-8?B?a3pxQUZrdGV5bE84VG5pNTRvRk5YUTRQU0UxTjEweDhFMkdWbHJUaFZ3QnZS?=
 =?utf-8?B?RUx6NXZnMCt6bFhRdEtpdVJaVkZyM1dBd00veGd2QnNPRkFFM21McWRQKy8w?=
 =?utf-8?B?NVk4WWwyaTRxSmJIN3ViZmRFTDBUYTI3RmJJUU9KV2tJVjFSZlEzNG80MTBi?=
 =?utf-8?B?c21UeWcyVFN3SUlUNG9hVFAxa3dJbnZ0ZEdISEZLWXRGZ0hvckFRTGk4Y2J4?=
 =?utf-8?B?SXZWU3JRV25WWjF6ZDVMZVgzRmZ1QUtkVmV6MnMwajF5Ui9JNEdVQmQ5NWQx?=
 =?utf-8?B?VkVESlNWd2k4U0RBSzZsSHBwZlh6Y2lHK21BaVdCQWgyNXY0cEZqYjNVd1p2?=
 =?utf-8?B?ZysrS0QwdUlGbTJvTER3NDBmUkVzcGEyMkhyUTR1YlBuQmFqS1RESlNaakMy?=
 =?utf-8?B?RHB4ZFIzMHJIa1k5Z0ZxU0Y2S1NCaUZPdlU5ZUxBU3UxdFRXTjcxSHh1SEJN?=
 =?utf-8?B?Z2gvSEFTVDQ5dkx4ajFERko3T1JnNkZMY1UrM2tZUDNMWVB1RlNtODNPSlhE?=
 =?utf-8?B?MDN1NS9hM1dnUWwvRFVGMVgzdWE4QzFHUXpEMzRyWDAwajRlcTFMeFEvK0RP?=
 =?utf-8?B?U09FUUFXMWpLM3FJUE95OG5iWWFSMnR0SDFvUWxQUHU3Y2FDWDh5Mis0a2VL?=
 =?utf-8?B?NDIrYm53RVFHdXNTdTBRVVRyMFNzOWJ0dlNIQkZCNXlWNnNpcHJCYWNReDlY?=
 =?utf-8?B?Z3huemJYQ2xTQmRtYWtBdXkveXkxRnd3a2d2Y1pHRG9Nc1FySFVaWThMeVVw?=
 =?utf-8?B?RHJDQnpSQzNsWHFQMFUzMFhBdUR0YWlzb0lGemNhMjZYNFU0TWJXakl4VzIw?=
 =?utf-8?B?ZWFNWDV5Z01uMXV4ZHBhVnJBeEVBL096c0Qzb3BiNStwTTBneEdCY3NZVFA5?=
 =?utf-8?B?SWZjRWNIT0xwNXlDYVRNcHNZblRGQ2pkem0yb0JpSDl1eGpOb3hoVVNiZTZN?=
 =?utf-8?B?a01rQ3N3TE1aZVVWWHFuM2tKNmp4emY2bE1FNTN3d2FWQkxvS0w0S0lBbVE5?=
 =?utf-8?B?UXNtd3M3Z1JwZ2hpamlzendXV3FZOEprT01QOVZnV1NYOUVWR1FOMUFSR3pX?=
 =?utf-8?B?YjlyL0h6cGVOeDdqYkF3eGcvVUpxbGYyMXpsZm51RlZyY1FEdDQ1eXc3MkRI?=
 =?utf-8?B?dVJaSXNvcHZSTDFVVG5YcldlS3hxM2RpVlhsOFNsclhCZ2VWVitnM3dUdWJ6?=
 =?utf-8?B?eXRQY3R5YlVQOVdLb09QbjRZOTdUNmRYRUc0dXJEcTdiYmwvdHZHaTFVTDl6?=
 =?utf-8?B?UU42N3ErTFkwZXZmZWF2UG5BV2hQTG9INDlMWUdsZlRvUFpLMWdSLzRiSlh6?=
 =?utf-8?B?emt2Z3QyNWtPVHk3dklPOVM3Mktxa09mTUJqSkxhditLcjZEdWJnQ2tQRVVO?=
 =?utf-8?B?UjRyRExicHE5UUNabms2Y3VkOWhxZmJSVGVJR3FpK2s4OVIyOVpUd0psbTNG?=
 =?utf-8?B?YWFHRlA0QzZLdWZQTVVhU1NjYW5vYkdvejRKUkc1UWZVUDRCNSs4LytrS0JQ?=
 =?utf-8?Q?4FhvjNzS/A9y+pQeaVsjckdbP?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53c4441-3adb-46f8-b615-08dc7ff39811
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 15:25:38.4294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyrhr9QiaYZNbIRJiBSS38ACefk5uZq/xYhXRysZ4fJlLbjP4O/kvgYMMp51z2i6repLkGTHtGW5Vt6muo2nheb/nLXPr4kGMa8sNOcksWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6739
X-Proofpoint-GUID: Bt6ILK_9NAxxOcfuaYSKoelSLCrwa-Mv
X-Proofpoint-ORIG-GUID: Bt6ILK_9NAxxOcfuaYSKoelSLCrwa-Mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=923 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290106

SGVsbG8sDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcuIEkgd2lsbCBzZW5kIGEgdjIgc2hv
cnRseSwgSSBqdXN0IGhhdmUgYSBtaW5vciBtaXN1bmRlcnN0YW5kaW5nIGJlbG93LiBJIHdpbGwg
c2VuZCBhIHYyIHNob3J0bHkgd2l0aG91dCB0aGUgY2xvY2stbmFtZXMuDQoNCj5PbiAyMi8wNS8y
MDI0IDE0OjAxLCByYW5lY2hpdGEgd3JvdGU6DQo+PiBBZGQgZHQgYmluZGluZ3MgZm9yIGFkYyBh
ZDc3NzkuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IHJhbmVjaGl0YSA8cmFtb25hLm5lY2hpdGFA
YW5hbG9nLmNvbT4NCj4NCj5BcmUgeW91IHN1cmUgdGhhdCdzIHRoZSBuYW1lIG9yIGlkZW50aXR5
IHlvdSB3YW50IHRvIHVzZT8gTG9va3MgbGlrZSBtaXNjb25maWd1cmVkIGdpdC4uLg0KDQpEbyB5
b3UgbWVhbiB0aGUgZW1haWwgc2lnbi1vZmY/IE9yIGp1c3QgdGhlIG5hbWU/ICBUaGF0IGlzIG15
IGdpdCB1c2VybmFtZSBhbmQgSSBoYXZlIHVzZWQgaXQgZm9yIG90aGVyIHBhdGNoZXMvcHVycG9z
ZXMsIGJ1dCBJIG1pZ2h0IHVwZGF0ZSBpbiB0aGUgZnV0dXJlIHdpdGggdGhlIGZ1bGwgbmFtZS4N
Cg0KPg0KPj4gLS0tDQo+PiAgLi4uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tYWRjLWFkNzc3
eCAgICAgIHwgMjMgKysrKysNCj4+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3Nzc5Lnlh
bWwgICAgICAgICAgfCA5MyArKysrKysrKysrKysrKysrKysrDQo+DQo+V2hlcmUgaXMgYW55IHVz
ZXIgb2YgaXQ/DQo+Li4uDQo+DQo+PiArDQo+PiArICBjbG9jay1uYW1lczoNCj4+ICsgICAgaXRl
bXM6DQo+PiArICAgICAgLSBjb25zdDogYWRjLWNsaw0KPg0KPkRyb3AgbmFtZXMsIGl0IHJlcGVh
dHMgd2hhdCdzIG9idmlvdXMuDQoNCg0KQmVzdCByZWdhcmRzLA0KUmFtb25hDQo=

