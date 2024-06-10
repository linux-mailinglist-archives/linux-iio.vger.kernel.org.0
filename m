Return-Path: <linux-iio+bounces-6142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFA4901DBE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE7285D75
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8974C14;
	Mon, 10 Jun 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KvpNhpWY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E03558A0;
	Mon, 10 Jun 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010053; cv=fail; b=I9o5sy1Tq2WHS1xa7gsjBPIcHJPpo7EIlHd73aRydWsy7FI5L5H1aQwoSlQZj80oES/wsCBmLTrYRWtZZLZUDYMtDNx7A7m542WihIXLZ6paW7J61Y3UpYDkaZq44gZLOuaxyvmn14ZHoTP9NuyZ/CiHacqi0fbZJn6QrJwgSRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010053; c=relaxed/simple;
	bh=SgwmLaVrdkpfUrik7ln9QF9x9VTvSKdt849UyvN/A5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ef8N9bFdBvbjQYqdm62vqSaQBr/UjbygOXMUm5TXdrtirHLDICamh0AQ5lJa4ePClZY9Nx3u2GPGB1VUPm+eJQvm5w3YO/5sr9t4CL2tWuSsIaExojAVDRZCI+xouIPeMJrSVsuAD4M7WTh/yofj015YPTtzBEffjVTdfcM9nik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KvpNhpWY; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A7rIpD001670;
	Mon, 10 Jun 2024 05:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SgwmL
	aVrdkpfUrik7ln9QF9x9VTvSKdt849UyvN/A5g=; b=KvpNhpWYDoPFxacNMqXyi
	6I/pL4KX9DXWSCSv8m/KkjMNqLi1YIOnPzZIhUbKOlJH/jXQ2Pe8mq0EbjGWnJYQ
	nH2+F2xb8cAG+U+6Uc5D0v2XFbmbx50obNat0q3Zk+t6Z6UwKQ18IRbR71lP24Rr
	eYDPgKVknRvWZvpuLBq4ETQG/1/gg3yINBCgKX7f6cFSocGd0X8e7k/7qcejEPn1
	Dcjv/SLI6WUff9Bhg4qfkZhDEKO6XHIMQluUKbRqahxfe0o7O9YEVHOub1Kor9Vx
	BIj425pOGcl6bDuXqS2adlOOuEFwUb5bByidKYLnnOo5P1V2HGLyisVvJzdUa5y+
	A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ymh52ntxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 05:00:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdgTy7Sj7un8cH6hg6NQ02qmbb0mm54ocFz47EuINs0LoY8tZRlTKiEIAT+9AiuSrHScfmec1CBdtWq7//bgy0fuBGEZDCV2Lny96kKbPRvKnrIsgK8vjZNFF0suNA+E2tWBv28QZriLfr7CNwMk/k1cdaCH2+ubhN7Xg3B6Zcs7KcTSEOsWkjhPNTJSVsi/KLdXK9Z1UexpELKDRye2GSjIU4/6QQ69fwK2hFLx6KlEzm54tRctVL2kkvHfrH1BeO9aoO3GhxEjeT4Hmsi28o3SH+Rkc3YTUgew3IVu0wfYlegv4737MOSB0VbZjN+M50A0LQ9SC2ytNq+KYlXvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgwmLaVrdkpfUrik7ln9QF9x9VTvSKdt849UyvN/A5g=;
 b=fTXjcEhoLFmbN1XMB51NOXFG9aUbQRWkpBJSh66b7sv2j23xPW8sFr21r55FF/WzZAl5vCBVew6rUnPXGPkG3TRDDWyyCvGVm93IoQbQ+XbT/z3unN0LI25lg6JKynBTYFnFpmLjuQmpKJJXJ4v7G7fgoEdwU5yJzd+jnMowhi/4R1AOOeawe2LyPDrr4APkmKWmB5NcQyp+CV+4TJG/Vo2aoS0L1V1umgxLm5yit6C7daEcQI9a1jNtr5wDYdx/3ZPQC4slqi6skkVPt/wdz304oB/HR/MwvleGnWf5Y8HLc19UfLfhrOCv3hDkmEx1hd78pYdbXKuMgaJMkWFMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6512.namprd03.prod.outlook.com (2603:10b6:510:be::5)
 by SJ0PR03MB6963.namprd03.prod.outlook.com (2603:10b6:a03:431::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 09:00:28 +0000
Received: from PH0PR03MB6512.namprd03.prod.outlook.com
 ([fe80::c8b5:7953:eec1:cb28]) by PH0PR03MB6512.namprd03.prod.outlook.com
 ([fe80::c8b5:7953:eec1:cb28%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 09:00:28 +0000
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
CC: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iio: frequency: adf4350: add clk provider
Thread-Topic: [PATCH v2 2/2] iio: frequency: adf4350: add clk provider
Thread-Index: AQHauMFHWY74hPwHdkaxp7CfkH/VPbG8JIsAgAHVbQCAAp0ioA==
Date: Mon, 10 Jun 2024 09:00:28 +0000
Message-ID: 
 <PH0PR03MB65124D46BCFF1833DADBA0E78EC62@PH0PR03MB6512.namprd03.prod.outlook.com>
References: <20240607095806.3299-1-antoniu.miclaus@analog.com>
	<20240607095806.3299-2-antoniu.miclaus@analog.com>
	<751abd157213736e376ca43ef1082362a4ca1149.camel@gmail.com>
 <20240608160838.16a2a04f@jic23-huawei>
In-Reply-To: <20240608160838.16a2a04f@jic23-huawei>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYldobGJtNWxjbWxjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFsT0dRd1pERmlOeTB5TnpBM0xURXhaV1l0WWpobE5TMWlZMll4?=
 =?utf-8?B?TnpGak5EYzJNVGxjWVcxbExYUmxjM1JjWlRoa01HUXhZamd0TWpjd055MHhN?=
 =?utf-8?B?V1ZtTFdJNFpUVXRZbU5tTVRjeFl6UTNOakU1WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STNOamc0SWlCMFBTSXhNek0yTWpRNE16WTBNRGd5T0RnNE1qY2lJR2c5SW5W?=
 =?utf-8?B?R05GUlJWRk5KTDFCaWRXdEVhMFZKY2tGRWRIUTJWbmRqY3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVRkS2EyMXlSa3gyWVVGVFRuRlVRVXBhYVVkdGJF?=
 =?utf-8?B?a3ljRTFCYkcxSllXRlZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB6512:EE_|SJ0PR03MB6963:EE_
x-ms-office365-filtering-correlation-id: 56181aae-a0e8-4980-bf41-08dc892bc63c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NU0vOHNKS3FvWkE4aWxHOHZWWmVJU25SMkp5eC9sZ0NkM2VHdGxhL3RvYWV1?=
 =?utf-8?B?dy9IRVcvNndLNWwvQy9QeGhaQTdSVmw0YjM2UmVpTytad2hicE9oUVNJWHZp?=
 =?utf-8?B?a01lMzJDSWlZZjNRRHQyLys5ajlIaUs2QUR3a2xBanZPQ3BVTkcwRmdranVT?=
 =?utf-8?B?b3hveDFSMEswRjYvSmJJSTNOT1RETHJSdDhDR1NiT3BkWTJ4NkdwSmhONmFD?=
 =?utf-8?B?ay9OMlhSYTVaQkUwN3BHb0JCalBJN0RzaTc2RGg5WUM5R3lHWDJ5WE54RGps?=
 =?utf-8?B?ekJwbVp2RmhXTTV4bWQya3puSmZPWGw1NGNQWjFLY1JId1kxUHVtcjgvWWZS?=
 =?utf-8?B?T1dYb3AzeHFWM3J6QklaNko5SjVXWmRZbHlzdHpRakhKTWhkbm84SjRwcDJk?=
 =?utf-8?B?bXkwYmphNTh0MUR3NjdjUUNySnVucEo3SjJ2c0VYMTJMMWVzcFcvV2Q0NkVT?=
 =?utf-8?B?a0M5aEs2dDUreW01THZ0blFMYlh5eEJKUzU1WGpzS1R4S2xBZnhSbVVGRU1o?=
 =?utf-8?B?TUs2cjZlb1Q4Y21OUW5nbmFIcksyN0tVcVg0TStPbmppaVBsVWtyWm9Pb3pY?=
 =?utf-8?B?Mk9qcEp1aW9jY0dOSEdBQWlOZzhrdnNXQzRoa05reG1KZVhOZEtqcTNGL2RW?=
 =?utf-8?B?aW9PaUgvOHVmS3ZVemhnU1BVeDRiZHlJTmwxMk9xVXBkemlsQzUvSUNsWkVl?=
 =?utf-8?B?dFdnMGR4VktWcmJ1aXZNM2RFakprZ1RHSG96VzRzVDVBY0FEeGRmSWo3NEhm?=
 =?utf-8?B?T0dERHlkT0EvTUdNaGdXSTRIVCtlRXdLZ0xodFlKQkVsL2xaQmpqUVhWY3ps?=
 =?utf-8?B?YXJaTTlSN2ROVlRzVUJkUUl0bk5iNGhtd0FDcjFCa1o0eURYY0JaMkN2ZElt?=
 =?utf-8?B?TFdCaHlsUG1ocGVBcWVtRmlCUTBnU3pLNVcvR0RvS0JUM2RwSFErTCszWCtG?=
 =?utf-8?B?SUJDQjh3Y1NjK0RMd2FVQkI3S09MbTcyalpLUXY5ckV4L2pwdHlWb24zbXZq?=
 =?utf-8?B?dFZDc09OMEtsZCtpbVJpa0tWZ2xLL1BiYnM5MGRWV1E3UTFTQVJvR2FvQUIr?=
 =?utf-8?B?eTVCZjlGR1Bzemt3N29nTHdhbHJMVC9SUmI0UklQQ2pUc3pBU2k3TitscG9s?=
 =?utf-8?B?dnRwckFOQkNJM29FekJHOTJrbngvSXJFRGhnQ1MyS3BSRFJ2ZDRkcjhlVlBT?=
 =?utf-8?B?UEtWaG0zc2k0bTg2ckJFWnZkd0hZRi9GNVA2TzVTMzQ3QzljMFpCVkNvaVMx?=
 =?utf-8?B?WmhIZk15UUFueXAyZXRGeWN0SlBwc09veG45RmJjR2l4UWFIakVHN2diZHRi?=
 =?utf-8?B?Qm1nVzFnd2FHa2FoOWxjQzV2Mzl0S3doTHNWVlg5elJFM1pPdFJ2bjFuR3Qv?=
 =?utf-8?B?ZTdmaVRUVlQ5YTB1TGVDQVRVZHc0djVVQVg0M09MdVhiZGRVVmllWVdWQlow?=
 =?utf-8?B?WWlxYzVEamJJaGRrYnQ5TGh1RjBSYUN3czdhdWNwdi9adGNpMlMwVFVNNEVC?=
 =?utf-8?B?d1ltVkVsRmxFT2ZtejJlTSs3QzlFdGNUcnFvY29wdE5CWDVxRHNUZFZPZUZQ?=
 =?utf-8?B?N2ZCS3ZNRHNqNXN6Sy8zUTJGTlQxYnFtV3Vxd3ZzcGVaWHROb1FPelJpVGpR?=
 =?utf-8?B?d1FTNE9DRUcwdEN5ZkJNckFSSjVmdDJvODFoKytURVJwS3hETXBQSWVsaVlM?=
 =?utf-8?B?amxzQzFrYVkvWXgxRC9wNG9RdjhrZnNPWTFra09rRHpodk1BZmdrMkdxU1hY?=
 =?utf-8?B?b09qVjVldEJLcFBTcGIwS2drcG9KK0xFZUlHWGJPY2I2aEZQQ1liQ3puT3NJ?=
 =?utf-8?Q?lbs7AzUBtxwqJC6z8CDdXZwg17CsEDODM2RIk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6512.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YVRvdndqMmUyM0ZvRUpxU05UMG5adDJFQW8zcnFOS09Xa3N4MStBZXVEVkhM?=
 =?utf-8?B?THJhaXNrZCtRWHU1OU9HSzVPdXNuR3l3QnVkcGdIc290TDhaZjUrZTNyNDNB?=
 =?utf-8?B?NmhzZ2RkOWF2Q1kyZTJKUzdGemxlMUE4UWlFLzc4aFd4R1kwbGJ2VXAxTTN4?=
 =?utf-8?B?VVkwTEVaSG0xQkt3YnVzbGcwc01mTmR6c3NmWUlmOXRRaFJ6OTUxZHBDRW9C?=
 =?utf-8?B?MTFYOHV6eHdGa0lWeE5yS1RLU3ZEM0p6d3BIbGZRMzArdTBRVXEvTC9RSTZN?=
 =?utf-8?B?MWZLdk5NOE8vVjFndkRBbFJYSmRYZEU1MGY0SGc1blJybXpFWVBPcjVSNFNz?=
 =?utf-8?B?RVNiR1NUbE5YaENEV2xVOEpyOVFFaUtWUHlqbWNtNjJ2ZWxXTjQ0TUc0VVpP?=
 =?utf-8?B?ZDlLeUY5NEo4M1RQRTVqZXByblVJVGhrMFg3VWdxeFk0SkNPZStKa3RxTlhQ?=
 =?utf-8?B?U1VxdHMrR1F5VVFEVnd0L0RuUVJObHNHMnhieU1GRXNsSlNHSEFWWmUrSnFp?=
 =?utf-8?B?YTZVMy9kTXlLbzZ5N2RzMnRjb2IzVFU4SFBxVmQxL1hXazZnekdJaGFsZlh1?=
 =?utf-8?B?L0xvcWVnaE1jeXcyNjNiWThTNTJxY3VtOUlHSEFEV1FybDFGYzlJN1phdlNl?=
 =?utf-8?B?cHZTb2ZoV2hQV0poOXV6b0Q4S0lENDYwb1hrUDV5NGN0ZGpYNStnWWdidFZo?=
 =?utf-8?B?dkFZKzhPdDN3VGpVb2s5cURaSTJ4K0Z0UGpRdWJ1Y0lUSFByUzg4Ykp2R0pR?=
 =?utf-8?B?WElhK0F5TE9VVnlsWG4yTmlZaGJXUitPV0ZVRTJXRnBHVFV1cXVKVy9nTWZN?=
 =?utf-8?B?VVJpSGtLd3pqUWFScXFKNjlFZjBZVG4veFE5S0dqVDJLMUZKT01vMmFtRHdI?=
 =?utf-8?B?SDByL0trakIwVDZqbzlSakQraFd6QW1WdENqcFVOR2hxekYwcThyc1hzMFhT?=
 =?utf-8?B?U0hObXZZbGhHenZhdjNXcmlKZjFlb01qa3BPYm9zYitINTFMMURTb1VRV1Rh?=
 =?utf-8?B?dDlFMU1OcUs1NVBkME5NZzNJR2xRYmdFU1M3OGFYRVpya1RlMS9mMVkxM0N6?=
 =?utf-8?B?TVB2WlRzOThZd3Y0NTYyaGdveDg2OURnTnVDdWJHYnZ5YTNiNHcxL0ZmTGt6?=
 =?utf-8?B?bkNvcEg5a2oxbk5JOERCV0NMVGcySjBiaTBSQlFlS2FQbTdyODhOTHNrVVFG?=
 =?utf-8?B?SHBDajcrQUlNeDZER3hWN0VyQUlLc1llYUpvK2lwVGN3MG43OWVVTklURHJI?=
 =?utf-8?B?dDM3bGtTWHFGbWhpR2F5YThZcmZIRHorZ2h5NitjZW8xTjRPcGYzQTR2Y01l?=
 =?utf-8?B?WnphRGpLcmk5NjlLNFVjSFpodWJEWFlKdEh0ZmRkTzlBVGRTaGhrWUFBYy9y?=
 =?utf-8?B?V212KzVmQ0dzN1crcXdnMFU2ZDR5eVl1QnZPUkpTUnlRRjNZOU5qNlBZV3Jh?=
 =?utf-8?B?TEdpb1Z1L3Q0RkxhL1c5RlRidkFIZFdPK1Y4L1FoaXVqRnFPSTUrNk9ZQk5v?=
 =?utf-8?B?MXY0ZDlGMVQzOHd4bHlXU3lhMWhnd1JBSWQ0U0J5emlHMUFQdzhHMTRDb3Jm?=
 =?utf-8?B?YmozSVVSNUNQckdxdTE3NUdZcDFmbDlJeWw0RHZQelVORHlKb3ZzOFFiOFE0?=
 =?utf-8?B?L0Q5UGR1NWdRWmVVeFIzMXI1MFhGZWRkanJzcStSY2J5NTJiNWRjNWx3OVhE?=
 =?utf-8?B?MUhJOEpFSXhpQzNVRUVmTWFmajZsUDB4M0YwTDM5U0JmVkJKYTl1czkzZ3Z2?=
 =?utf-8?B?VDc5Y1ZYb1dVdVFoZm5BNnFYTVBrRmRHUGZTd05lamhESjRDYkgxWHgxa1Fu?=
 =?utf-8?B?SUVMdTJoWjJQQnlrVHA3ZDc3a09idDFmZmZsUG4wR01sWGE4cm8vZGtsSEFR?=
 =?utf-8?B?L0pIYjZXWCtUa1NGckt4QVovaHo0dDdlTlF4VnNrYUFOZUZpaFFFQXY0Smdr?=
 =?utf-8?B?bkJYS3FtNnJDWUtRN2ZTbXJCeHFxVEZpTVhmMTVFNWdaR1JMWUIyU3VOc2N3?=
 =?utf-8?B?VHI2R0JQOXd1NWN2SVNDUll2L3BUVG5ac1pWRWVkK0p5di9kMW9uemNKTXZT?=
 =?utf-8?B?SjJ4L1FVMlRxUHBWcG11MFd6NlNLY2ZZeHh1Ym1oNzRHWi9SSWNTSzNJd0Vn?=
 =?utf-8?B?VmhBdkdCSTBMajdTM0NpU0VRTXZWR1VKV0VhQ3EyY3F0RUxIMW84dk1IU2lD?=
 =?utf-8?B?YWc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6512.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56181aae-a0e8-4980-bf41-08dc892bc63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 09:00:28.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5l3KwBKiCQyZn7KUYCHOP5BSq6ynTEZ2hApMqlBK4pWKMIFLkvAPheH4zP3oPrPJAXRlwJvTgXVO5xKEBvMLkS3s+CUkDTpABU9fGsjBOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6963
X-Proofpoint-ORIG-GUID: ITdhe2pCqfKH1iYACyVk0teaBl9I3BLj
X-Proofpoint-GUID: ITdhe2pCqfKH1iYACyVk0teaBl9I3BLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406100068

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgOCwgMjAyNCA1OjA5
IFBNDQo+IFRvOiBOdW5vIFPDoSA8bm9uYW1lLm51bm9AZ21haWwuY29tPg0KPiBDYzogTWljbGF1
cywgQW50b25pdSA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+OyBMYXJzLVBldGVyIENsYXVz
ZW4NCj4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5u
ZXJpY2hAYW5hbG9nLmNvbT47DQo+IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+Ow0KPiBDb25vciBEb29sZXkgPGNv
bm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gaWlvOiBmcmVxdWVuY3k6IGFkZjQzNTA6IGFkZCBjbGsg
cHJvdmlkZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiA+ID4gK3N0YXRpYyBpbnQgYWRm
NDM1MF9jbGtfcmVnaXN0ZXIoc3RydWN0IGFkZjQzNTBfc3RhdGUgKnN0KSB7DQo+ID4gPiArCXN0
cnVjdCBzcGlfZGV2aWNlICpzcGkgPSBzdC0+c3BpOw0KPiA+ID4gKwlzdHJ1Y3QgY2xrX2luaXRf
ZGF0YSBpbml0Ow0KPiA+ID4gKwlzdHJ1Y3QgY2xrICpjbGs7DQo+ID4gPiArCWNvbnN0IGNoYXIg
KnBhcmVudF9uYW1lOw0KPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoIWRl
dmljZV9wcm9wZXJ0eV9wcmVzZW50KCZzcGktPmRldiwgIiNjbG9jay1jZWxscyIpKQ0KPiA+ID4g
KwkJcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArCWluaXQubmFtZSA9IGRldm1fa2FzcHJpbnRm
KCZzcGktPmRldiwgR0ZQX0tFUk5FTCwgIiVzLWNsayIsDQo+ID4gPiArCQkJCcKgwqAgZndub2Rl
X2dldF9uYW1lKGRldl9md25vZGUoJnNwaS0NCj4gPmRldikpKTsNCj4gPiA+ICsJZGV2aWNlX3By
b3BlcnR5X3JlYWRfc3RyaW5nKCZzcGktPmRldiwgImNsb2NrLW91dHB1dC1uYW1lcyIsDQo+ID4g
PiArCQkJCcKgwqDCoCAmaW5pdC5uYW1lKTsNCj4gPiA+ICsNCj4gPiA+ICsJcGFyZW50X25hbWUg
PSBvZl9jbGtfZ2V0X3BhcmVudF9uYW1lKHNwaS0+ZGV2Lm9mX25vZGUsIDApOw0KPiA+ID4gKwlp
ZiAoIXBhcmVudF9uYW1lKQ0KPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4g
PiArCWluaXQub3BzID0gJmFkZjQzNTBfY2xrX29wczsNCj4gPiA+ICsJaW5pdC5wYXJlbnRfbmFt
ZXMgPSAmcGFyZW50X25hbWU7DQo+ID4gPiArCWluaXQubnVtX3BhcmVudHMgPSAxOw0KPiA+ID4g
Kw0KPiA+ID4gKwlzdC0+b3V0cHV0Lmh3LmluaXQgPSAmaW5pdDsNCj4gPiA+ICsJY2xrID0gZGV2
bV9jbGtfcmVnaXN0ZXIoJnNwaS0+ZGV2LCAmc3QtPm91dHB1dC5odyk7DQo+ID4gPiArCWlmIChJ
U19FUlIoY2xrKSkNCj4gPiA+ICsJCXJldHVybiBQVFJfRVJSKGNsayk7DQo+ID4gPiArDQo+ID4g
PiArCXJldCA9IG9mX2Nsa19hZGRfcHJvdmlkZXIoc3BpLT5kZXYub2Zfbm9kZSwgb2ZfY2xrX3Ny
Y19zaW1wbGVfZ2V0LA0KPiA+ID4gY2xrKTsNCj4gPiA+ICsJaWYgKHJldCkNCj4gPiA+ICsJCXJl
dHVybiByZXQ7DQo+ID4gPiArDQo+ID4NCj4gPiBJIHRvdGFsbHkgYWdyZWUgdGhpcyBjaGlwIHNo
b3VsZCBiZSBhIGNsb2NrIHByb3ZpZGVyIChtYXliZSBpdCBzaG91bGQNCj4gPiBldmVuIGluIGRy
aXZlcnMvY2xrIGZyb20gdGhlIGJlZ2lubmluZykgYnV0IHRoZXJlJ3Mgb25lIHRoaW5nIHRoYXQg
Y29tZXMgdG8NCj4gbXkgbWluZC4NCj4gPiBTaG91bGQgd2Ugc3RpbGwgZXhwb3NlIHRoZSBJSU8g
dXNlcnNwYWNlIGludGVyZmFjZSBpbiBjYXNlIHdlIHJlZ2lzdGVyDQo+ID4gaXQgYXMgYSBjbG9j
ayBwcm92aWRlcj8NCj4gDQo+IFRoYXQncyBhIHJlYXNvbmFibGUgc3VnZ2VzdGlvbi4gIElmIGl0
J3Mgd2lyZWQgdXAgYXMgYSBjbG9jayB3ZSBwcm9iYWJseSBkb24ndA0KPiB3YW50IHRvIHByb3Zp
ZGUgdXNlcnNwYWNlIGNvbnRyb2xzIHZpYSBJSU8uDQo+IA0KPiA+DQo+ID4gU3VyZSwgd2UgZG8g
aGF2ZSBjbGsgbm90aWZpZXJzIGluIHRoZSBrZXJuZWwgYnV0IEkgc3RpbGwgdGhpbmsgaXQncyBh
DQo+ID4gc2Vuc2libGUgcXVlc3Rpb24gOikNCj4gPg0KPiA+IEkgc3VzcGVjdCB3ZSBoYXZlIGFu
b3RoZXIgIm91dGxpZXJzIiBpbiBkcml2ZXJzL2lpby9mcmVxdWVuY3kgOikNCj4gDQo+IFdlIGFs
bCBsb3ZlIHRoZSBibHVycnkgYm91bmRhcmllcyBpbiB0aGUga2VybmVsLiBJSVJDIHdoZW4gdGhl
c2Ugd2VyZQ0KPiBvcmdpbmFsbHkgcHJvcG9zZWQsIHRoZSBJSU8gdGhpbmcgd2FzIG1vc3RseSBh
Ym91dCBob3cgdGhleSB3ZXJlIGJlaW5nDQo+IHVzZWQgaW4gU29mdHdhcmUgRGVmaW5lZCBSYWRp
b3Mgd2hlcmUgdGhlIHdlcmUgcGFydCBvZiB0aGUgbW9kdWxhdG9yDQo+IGNpcmN1aXRzLg0KPiBJ
IGNhbid0IHJlbWVtYmVyIHRoZSBleGFjdCByZWFzb25pbmcgdGhvdWdoLg0KPiANCj4gQXMgdG8g
dGhlIHJpZ2h0IGFuc3dlciBmb3IgdGhlc2UgdG9kYXksIEkgZG9uJ3QgaGF2ZSBzdHJvbmcgZmVl
bGluZ3Mgb24gaXQgYW5kDQo+IGFsbW9zdCBhbGwgdGhlc2UgcGFydHMgYXJlIEFESSBvbmVzLg0K
PiANCj4gTWljaGFlbCwgdGhpcyBpcyBvbmUgb2YgeW91cnMsIHNvIHdoYXQgZG8geW91IHRoaW5r
Pw0KDQpXZWxsLCBJIHRoaW5rIHRoZSBzaXR1YXRpb24gaGFzbid0IGNoYW5nZWQgbXVjaC4NClRo
ZXJlIGFyZSB1c2VycyB3aGljaCB3YW50IHRvIGNvbnRyb2wgdGhlIExPIGZyZXF1ZW5jeSB1c2lu
ZyBhIHVzZXIgc3BhY2UgQVBJLg0KQW5kIGp1c3QgbGlrZSB5b3UgcmVtZW1iZXJlZCwgYXMgYW4g
SUYgZm9yIGFuIGV4dGVybmFsIG1peGVyLCBldGMuDQpWZXJ5IHNpbWlsYXIgdG8gYSBiZW5jaCB0
b3Agc2lnbmFsIGdlbmVyYXRvci4NCkFuZCB0aGVyZSBpcyBubyB1c2VyIHNwYWNlIEFQSSBmb3Ig
Q0NGLiBTbyBJSU8gcHJvdmlkZXMgdGhpcyBBUEkuDQpPbiB0aGUgb3RoZXIgc2lkZSB0aGVyZSBh
cmUgdXNlcnMgd2hvIHdhbnQgdG8gdXNlIHN1Y2ggc3ludGhlc2l6ZXJzIGFzIHJlZ3VsYXINCklu
IGtlcm5lbCBjbG9jayBwcm92aWRlcnMsIHRvbw0KDQpXZSBjb3VsZCBhZGQgYSBnZW5lcmljIEND
RiB0byBJSU8gcHJveHkvYnJpZGdlLCBob3dldmVyIHRoZXNlDQpkZXZpY2VzIHdoaWNoIHNpdCBp
biBJSU8gYWxzbyBoYXZlIGFkZGl0aW9uYWwgZnVuY3Rpb25hbGl0eSB3aGljaCBpc24ndCBhYnN0
cmFjdGVkIGluIHRoZSBDQ0YuDQoNCkl0IHNvdW5kcyBzZW5zaWJsZSB0aGF0IHdoZW4gcmVnaXN0
ZXJpbmcgYSBjbG9jayBwcm92aWRlciwgd3JpdGluZyBJSU9fQUxUVk9MVEFHRSByYXcgc2hvdWxk
IHJldHVybiBFQlVTWS4NCkFsc28sIHdoZW4gaXQncyBhIENDRiBjbG9jayBjb25zdW1lciBzZXR0
aW5nIHRoZSByZWZpbl9mcmVxdWVuY3kgc2hvdWxkIHJldHVybiBlcnJvci4NCiANCi1NaWNoYWVs
DQoNCj4gDQo+IE9uIHRoYXQgbm90ZSwgZ2l2ZW4gdGhpcyBpcyBiYXNpY2FsbHkgcmVnaXN0ZXJp
bmcgYXMgYSBjbG9jay5JJ2QgZXhwZWN0IHRvIHNlZQ0KPiBzb21lIGNsayByZWxhdGVkICtDQw0K
PiANCj4gSm9uYXRoYW4NCj4gDQo+ID4NCj4gPiAtIE51bm8gU8OhDQo+ID4NCj4gPg0KDQo=

