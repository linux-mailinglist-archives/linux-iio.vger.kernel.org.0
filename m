Return-Path: <linux-iio+bounces-17388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E6A75D8E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 03:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EA4167392
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3102CCC5;
	Mon, 31 Mar 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YuN1kips"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19833F3;
	Mon, 31 Mar 2025 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743384035; cv=fail; b=eIK1cW28gMeOFC1545HFAUX1RQI6OYv/uowEVfdo77jGP6uw0yOMCqNn0+NNWUg8sQoN0/J8Ibq0RlM5DQCW2eWHWEVTaGdle93wGKeIYugfGteeZ1xWJKqFgO+nxrsR5WtZhfdvQbxTYGnGutsx/OVBbqc7E2zekPCYssODLwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743384035; c=relaxed/simple;
	bh=CA3SPJgvRlmceCnkDCQ+Whhp9+0oSbf//HunEoG6ghc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UkWzgQ7UhMGrpSV+c9PDfPeWHXIS6B++QCRWVbVLlYFGSPC5k0AYjs2zNFQ12XcuXu9dPCWy5euLij/hcGtjrDG1P6ai0uVGyVpfPUDF7sBvlVfzqz3rmPa7dsjXatKbPoxdjcRBgesQX8H/FtuhnbnGB84e4kYHmYxEU1vrgd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YuN1kips; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UL12V5020874;
	Sun, 30 Mar 2025 21:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CA3SP
	JgvRlmceCnkDCQ+Whhp9+0oSbf//HunEoG6ghc=; b=YuN1kipskkqahCRRKIdo9
	RRvAdgC5mOigWim9Nxxktl21HIWl9ro9gize6pTr0IBuB4o0p99kDPTZmxREwRTz
	DpiwxswA9lFIS3/RxNOEmesODT+AfI8bNFKqSVZeHYEUfFHYcH++Kf6CHWhnOXvS
	Ha3WiprpDGLw0Mrl936Cs70EZVvJwHhtHDkl9RxcszH8vHfR4IDd6jQ9gVkxakQG
	eVomNk/4CjInoL4p/MnScgQfW1pBRZusqLbS17Q0lE3CQY8/WAeU1ARehaNr3di1
	wFMaTTaW8S8q69m7Q+TKy9BketYuY1gLo+mkx99C5BqdCdeEgXL+aQOty4F3HtYs
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45q2wha16h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Mar 2025 21:20:04 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SU75MkNqkbw+/mCdadip3Zz7PpRhfWn2k3dEtEY5MMJMu6nSxr3bwZ1+i07U+Y8U5fJpe96ZiWWKIzISceOAcC4YyQ8j/Tk5dmfz6CK7Qrq12o+ecDb9UzkKzBgNDUQr1oFRL35hKGlhYmccMWfoFX3UTrYokZD3K9DoLriR+x5FAalYDVBe0NtjMKR+erBOW+XsjF4o2hxnFpcLYHsXQ6QZ5ZAaecSCeywGX655UWIg4nJ5S0tvo1MBDHqO1KCpeIXZ11MQ2SS3ev+/YR8G+0g7IOAEhK56sVNJlaJdIV6/UU/Bqnv5FMqtUdxBTRIwh/22klatIQwH8O2d22F13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA3SPJgvRlmceCnkDCQ+Whhp9+0oSbf//HunEoG6ghc=;
 b=XjpFJHPL4WVTd2WlVnQq+CiYoXGCPnbSnstacDQJEivebVvWHWm6ZBhy/dKnObqTTmI/LMzciwMbusCx2m2ONHPAScjo1xMDsl7+YQhDqy1XAoSMBPdvDEaROVPwWRj8loEgQ5AoXVDx8MDdhfqPVSsMKg0TzH8Ll7DaOU750llEck1oDC+IGPPYeP/Yt3dGuvPF2kp8h+hW0n9aN1dNCKShAERFhRbuR9WF2sdlusgYnluOigCj+9OjRIp2sOg5BiDiRVFgiCdzd2YrGtHK0zLjCTAdJwSRxgmLvxOwFS69qL+rbYQ8CNhUd4gkcwwdzsjOhVuU/aCUAFQ0Gter3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SJ0PR03MB7126.namprd03.prod.outlook.com (2603:10b6:a03:4e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.48; Mon, 31 Mar
 2025 01:20:01 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 01:20:01 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] iio: dac: ad3530r: Add ABI file for the AD3530R
 DAC
Thread-Topic: [PATCH v2 2/4] iio: dac: ad3530r: Add ABI file for the AD3530R
 DAC
Thread-Index: AQHbnK8/gGduFNJNyU2LKLvil0MISLOIRaqAgAQ0nIA=
Date: Mon, 31 Mar 2025 01:20:01 +0000
Message-ID:
 <PH0PR03MB7141A5DC2AD4A5D654EBA1AAF9AD2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
	<20250324-togreg-v2-2-f211d781923e@analog.com>
 <20250328085805.44122c63@jic23-huawei>
In-Reply-To: <20250328085805.44122c63@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SJ0PR03MB7126:EE_
x-ms-office365-filtering-correlation-id: a544fb85-003f-4223-2a3b-08dd6ff2290a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTAyTU5LQTBoaThwWXFONmhObW9uMDJBK29QWjNlK3JlWkxMOWVGaTVYYW96?=
 =?utf-8?B?L0V2eHgvR3p1WjRPREd1ZkY5eU5DYkdWMlJTNzJESmgwNnYzQXFRVW5PL2hj?=
 =?utf-8?B?TmZqdjA5aW55UlBNTmxEVkFYbjRYQnFBOGJXZVA4cmxCZEVOdGYwcXJrUVVw?=
 =?utf-8?B?K2g1RFEzL0FTZFN0K0RIQ1V1TW8vM0RtcmI0WFFUalh2czdHL0lBL3V1QmZX?=
 =?utf-8?B?YWVaUWNNUmdZdFp4dy9ITkg1RVhRUXczRWhXWVdKOWZHVGNiQkdBYW9JRGlB?=
 =?utf-8?B?RHZUOHI1Z2ZLSXhBV2l3czhqanBrZTdzdUtUako4NmNsQ1JlZzIzYU9PQWJz?=
 =?utf-8?B?MGxVWkkyd0JXd0RybUw3S3BSZk8ybkxKRitydzVCdjhjZGRiNjE0d0QrWUlo?=
 =?utf-8?B?ZWwvUGFsSk5QY1N0Y0JjS1VjTjRPZ1NlaVRDUC9PamMzMWUzZHIya2dkb1Jk?=
 =?utf-8?B?REwyanlqTEZCWmF3MEttNklGTXJNK1p3NXA2ZlZsMjdLY3FmeFh5OHVNYkFI?=
 =?utf-8?B?eVhvbm5zSFdLSTNhR1RDejAvemQ4cERLSUN4NEhTOGZ5RHB5WE9ibFhUQnk0?=
 =?utf-8?B?MVFJcWcyZHBCbWI0K3J3V1FFTjBVOUVXMnczdUtlemRRaUNGQ1NpZE94elRi?=
 =?utf-8?B?UmFlVWVWa2t6UjlUM0dFZHBvdXlZWkkvR1NiTi93NnVjVGlGUElFMkFHYUlw?=
 =?utf-8?B?dmM2NUcyNWhyU2lXMDNOV2s5UDVvYmt3aE1HSEJzeWRJZ2pmTnNHR3pmZjdZ?=
 =?utf-8?B?dWZtWnFDMzFoRTFuS3Z5ZHBTWWNyd3hXRHVtS3R3WnQxRUJuYnV1Q2lFUWJv?=
 =?utf-8?B?eFNBcCt3WVVnZkFiaHdkMk1zb0NFRFNpeGNpKytncTdScGpWQlcvaFIxWTlu?=
 =?utf-8?B?VFRlSHQzWTV6RXk1R0l4UmVhNGxUdmMzQUx5c0dXbTlPYWJ2VWZFZGh3Tmxo?=
 =?utf-8?B?SU96dW84RkNPeGhPNENMSExETVAyTGVqK3lEU3pNYjhSd0cwaWZhOGMrT1FY?=
 =?utf-8?B?bVJTbVZwUWVpMVlHYktoOWg0a2VIcTdrdEJOOHhUMkZsOG9UanJwTzFTeS8w?=
 =?utf-8?B?S3BwK1hmS01rclkxTGZjWnFOY1hkWlZQUUdsVWU3WXV6aVNJNVFIMTE5Vm9K?=
 =?utf-8?B?NHNDK3NhNHpZdUkyMzljLzFzZUQ4eXpxbEVxSU94bVJvRUlPQ2hiN0lNbUQ0?=
 =?utf-8?B?b3JPTS94SSthZ2l4akw1MytLR1pkcm91QUFlVDRHWU5rSDI2QWEyME1kZmNP?=
 =?utf-8?B?WkNSclQvazh5Snc1V3RyakowdzNiTlRlMFNtOWtTQ05IdzVvdFlnellJVVRF?=
 =?utf-8?B?WitWc3lxcjV0MGtXSzJIb3Z6T2dmWWlYdlV6ZytNYUEzd2JpSVNGZzlqVUQz?=
 =?utf-8?B?Ymhoa3FPSUlJNUgvQjFIVjZzMUZMVkJjZm1LSmNpaXhJOU1tYnUvMEdIb2RX?=
 =?utf-8?B?MXJsVHN3ZmkxbE5OV3hHVW9SaU5XVGV2MzdRbVFRVEtXN3g4UzU0N0RMT1FC?=
 =?utf-8?B?cVMweURTQzd6UWpGRExrd0JhTWd0cXlITGE3SWZGT0dPejRmaEo3VWcyR1Ju?=
 =?utf-8?B?djNwVjNITVA4NDJWRVlNQitjVmpzWUNTaWs4MVNJVlFIUUc3YWJKcUY4ZVlN?=
 =?utf-8?B?aUZKcGRZM3J4WmhJVG1KcnRIVVZIU0VFY1gyRDB4NEx6SEJaK3AzK3E5dDFq?=
 =?utf-8?B?REVxNjUzVnZSRHlUdHE1Z2hlZDYrNHY0U1lzUDZaMDBLQTk0K2FoU1dranRj?=
 =?utf-8?B?QjlvVkpaajJoQ3BFT1B5ZXFTMXZNY0lEN2VPNjJueFNIUERBSnhPR2ovZW5X?=
 =?utf-8?B?Mk4yUXdFbldJRUE3VjNOQW1kMkkvWVluU2NFWFlmVzNiMGluU1p6cGluUjh5?=
 =?utf-8?B?S2tNWnNBa1lPaG04SmpoZWVIY1BjRDQwWDJjU242WkVWM3JmRElzd2tHS3FI?=
 =?utf-8?B?RkhuV3hUeEd6U3FrdS9ERjJrYWhhVjRYS0t3OGhEb1lNR2pnT2pNbTJ6WHV0?=
 =?utf-8?Q?N4u7cWVmBMopcdkk30XwyiTTkhMYZs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWhmYU5CUTRPN2Fzak9MTDBNaW5CNWl0OGJYUjkxOGRycXQ4RlNob1diYVpI?=
 =?utf-8?B?d1E2YStjakFLdzd4TEFWQm5rWW9RQklXcmcrVjRBL09LK2tXa0pKeHFtYkE3?=
 =?utf-8?B?bDdtb050WmExaWFsYUlBT254TjNabHlwYUpTOHl4NVJjZW9qaVNFT1liOWoz?=
 =?utf-8?B?QjFZaTJjcDhtWnJGbTlqaERLVS9QV0FQbnNmZVc1ZDJXZXc4TXRaYXp2blQ5?=
 =?utf-8?B?b3NWcU9VRlQvQi9DeExvVi9RQkl6WHRSTDIvYzBON0V1OFJhbnB2eG5YNG1o?=
 =?utf-8?B?YzRnelBVUlpoMFlpdWh5UjExaFRiaVlpK1hwZFZ2K2pHNG1qME5oekE2S3h6?=
 =?utf-8?B?U2duM0FpUzZnSjk0Z3VJVUlxTWVzM1dab296ZnI0Y0QrNGlBU1Y2OW5MYjdL?=
 =?utf-8?B?ODVPbGZETVBsRFFTb0pQbHh1ZU5SRmlWczdBK1pVak9YMGJUeng0TU0vM3dU?=
 =?utf-8?B?cy9yM3Q4ZUVDa0hSZGFoWVJoclc4QkltemtDQmF1b3NuNE1kK1A2YnZHWGh2?=
 =?utf-8?B?N05JQVpLUXFSVVB5aWY3cFBHTGVQSXJBU3BZK2toUUJnNmlBMCtqKyswQnFU?=
 =?utf-8?B?SityMExLVElWaTFPTFdUOUlMMHhDbHFGZnNKSWxlU2xFdVNnR1luSm1UYWxQ?=
 =?utf-8?B?bmJyMWRsYVNacUUxY3Q1eTFMbGVkVWFNa2k4RlArc0x3S1VNUGpkazNpZFlL?=
 =?utf-8?B?eHBLdFZlRHEvRkRVL0ZhU0pZUy83SjRqT0RrZXFSQjkrVkpyWEtsZEJYTDZH?=
 =?utf-8?B?UUp6TFg2VDdjMWh1cXlVTkN6bFVWd2FDZ2RMejUxa0RvNitXblYyTThDdTc5?=
 =?utf-8?B?cDJCYUFxc2RtM3ltbnhYYy9DMnRmNTRLOEdQMjdXb1hTRmhRL1NSTnBtcUJY?=
 =?utf-8?B?UThRZEJBWlBSWTFWWGlWUytDTlpCSGY4eW03UkR3REtpVUpVT0YxOERlbjEy?=
 =?utf-8?B?KzlwenRGWDlpaEJOM1AvU3VXV0J6WkxJTm4zQmcrRzc3aDN2Q1NRZlV2TXNS?=
 =?utf-8?B?SWR1d21nU0tha214dWMvYjFkbFZPZkhNdFAzRDNvczMvMEdlaTJ3Y21FS2pG?=
 =?utf-8?B?Nk9scEJHMjErMlRYdERvVDE0clJNS2xIeTdGb0pWbWQvbWVTTlp2MmZGV3FP?=
 =?utf-8?B?T0NsUlltVWpsdWpPd0ZKdHh4U0x1eGJkMGpjem01VG9CNWRkOGl5Yll6VUV1?=
 =?utf-8?B?YkdweStyc3A3dXJMT09jZ1d6RHBINTc2Vm9JMEEyeGJXUmMxZHZ5VmRnQzdD?=
 =?utf-8?B?Sm5uYkxLZTBMeVR6M3hUVEZTcHdLRnZVRGphM0VYNXNkRmViSlpUVnR3cUxu?=
 =?utf-8?B?RVpwVnZ2SlV5OEMvQnB1NjJqZlFNeUZVKytwcVlXb00ybWU1MSsvQUwyaGsw?=
 =?utf-8?B?RE5kTWFPZDV6RE9WeGxiWXhieWpsOVpWUTNrM3EvTWEwM0JjTTNmRWNnZG5R?=
 =?utf-8?B?aW52SkMwWjVsNWxwakVVNjlMdjZIU0dHMnVwOUk0aUVTRS9uWTlzcTI0Y2xs?=
 =?utf-8?B?WUtpUGo3VVllelFFNmdxNWdTU1N2VXpXNEVMNnpjbUZnaS9oblF2QzBMSklJ?=
 =?utf-8?B?VjlGR3o0NGVkcEhwcDU4Wng5dFByVllKenpKMm9jZ0ZSM2NidW4wVUUwRVA0?=
 =?utf-8?B?M2RVSEhkRGFmM0NhUUhRaHkrQnY3VmRvb2FnQTFJQS90TFdXYXlEMlFBcTlE?=
 =?utf-8?B?enp2YjlmWU9Wci85Wi93TFJqWHZ0M0dIK1VIWkVXNXpQRXVsNjRzaTRoRGJU?=
 =?utf-8?B?MHBXRllLV2cwSnlMNDFFNmNDU25vUGdSWHZ2TlQyVVRQVzkxNUZaZXBWZDJB?=
 =?utf-8?B?eGZBYlFoT2poclBUZDVyMlRMaWpybGlQWDIwUVBNZm1nS2kzeGEvTUMvcCtk?=
 =?utf-8?B?b2dGallIZkhWdnQ0YklKS2Z2YjNQUnMxK3hCTllFUUtDSkdkaUpKZHhsaEZR?=
 =?utf-8?B?M3FSSWVHU3g1SnVJWEpZbEpqbDZ3S2p0c1ZHNE5QTjd6aVlZdU5WeTJvR2JB?=
 =?utf-8?B?MWNwL3l6RTNqckhWakhwdWdST1lXUG1rL1hFNGJoWU5uQUVxOVVOSm5idHJF?=
 =?utf-8?B?MkY3TG9aWkorQUFjQ21KWCs2Qjhadkd1OXA3S0pWcWJkT0wzZ0RtaXNmMm1V?=
 =?utf-8?Q?FJb9M4yclue3R6VMcD7pn1FQy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a544fb85-003f-4223-2a3b-08dd6ff2290a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 01:20:01.7487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLJ5e9PzO2ikbWpgV2uAIDjW4Es6PrmhMM4X2oX31Ebqdg45jNd5nbA5KmMaPO97lxMCX9tQD51CnIHYi6X9MRRR8q4nZAQHlDtIFqdmkuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7126
X-Proofpoint-ORIG-GUID: YS9yVB9LyRVt8PHno86poaQim9KElbcD
X-Proofpoint-GUID: YS9yVB9LyRVt8PHno86poaQim9KElbcD
X-Authority-Analysis: v=2.4 cv=TKJFS0la c=1 sm=1 tr=0 ts=67e9edc4 cx=c_pps a=iOysuCQqHAn0ffzU2nlaNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=HLlcfFp4RRvHeHQfdhQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-30_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310007

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDI4LCAyMDI1IDQ6NTggUE0N
Cj4gVG86IFBhbGxlciwgS2ltIFNlZXIgPEtpbVNlZXIuUGFsbGVyQGFuYWxvZy5jb20+DQo+IENj
OiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFl
bA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBD
b25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBsaW51eC0NCj4gaWlvQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzRdIGlpbzogZGFjOiBhZDM1MzBy
OiBBZGQgQUJJIGZpbGUgZm9yIHRoZSBBRDM1MzBSDQo+IERBQw0KPiANCj4gW0V4dGVybmFsXQ0K
PiANCj4gT24gTW9uLCAyNCBNYXIgMjAyNSAxOToyMjo1NiArMDgwMA0KPiBLaW0gU2VlciBQYWxs
ZXIgPGtpbXNlZXIucGFsbGVyQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBEZWZpbmUgbXV4
b3V0X3NlbGVjdCBhbmQgbXV4b3V0X3NlbGVjdF9hdmFpbGFibGUgc3lzZnMgaW50ZXJmYWNlIGZv
ciB0aGUNCj4gPiBBRDM1MzBSIGFuZCBBRDM1MzFSIERBQy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEtpbSBTZWVyIFBhbGxlciA8a2ltc2Vlci5wYWxsZXJAYW5hbG9nLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tZGFjLWFkMzUzMHIgICAgICAgICAg
fCA2OCArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDcgKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgNzUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
QUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWlpby1kYWMtYWQzNTMwcg0KPiBiL0RvY3VtZW50YXRpb24v
QUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWlpby1kYWMtYWQzNTMwcg0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXgNCj4gMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMC4uOWQzMTI2OTUyZmQxYzUyMTRhZmI4OQ0KPiA1YzQ5NzJkYzRhODkxZWQ3ZDQNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1i
dXMtaWlvLWRhYy1hZDM1MzByDQo+ID4gQEAgLTAsMCArMSw2OCBAQA0KPiA+ICtXaGF0OgkJL3N5
cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZVgvbXV4b3V0X3NlbGVjdA0KPiA+ICtLZXJuZWxW
ZXJzaW9uOg0KPiA+ICtDb250YWN0OglsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+ID4gK0Rl
c2NyaXB0aW9uOg0KPiA+ICsJCVNlbGVjdHMgd2hpY2ggb2YgdGhlIG11bHRpcGxleGVyJ3MgaW5w
dXQgc2lnbmFscyB3aWxsIGJlDQo+ID4gKwkJbW9uaXRvcmVkIG9uIHRoZSBNVVhfT1VUIHBpbi4N
Cj4gSGkgS2ltLA0KPiANCj4gRG8gd2UgaGF2ZSBhIHVzZSBjYXNlIHdoZXJlIHRoZSBtb25pdG9y
aW5nIHdvdWxkIG5vdCBiZSBieSBhbiBBREMgYXR0YWNoZWQNCj4gdG8gdGhlIGhvc3QgQ1BVPyAo
aS5lLiB1c2luZyBhIGNoYW5uZWwgb24gYW4gQURDIHRoYXQgaGFzIGl0J3Mgb3duIElJTyBkcml2
ZXIpDQo+DQoNCk5vLCB3ZSBkb27igJl0IGhhdmUgYSB1c2UgY2FzZSB3aXRob3V0IGFuIEFEQy4g
SeKAmWxsIHByb2NlZWQgd2l0aCBpbXBsZW1lbnRpbmcgdGhpcw0KYXMgYSBjb25zdW1lciBvZiBh
biBBREMgY2hhbm5lbC4gVGhhbmtzDQoNCj4gSWYgbm8gb3RoZXIgdXNlIGNhc2UsIHRoZW4gc3Vw
cG9ydCB0aGlzIGFzIGEgY29uc3VtZXIgb2YgYW4gQURDIGNoYW5uZWwgZnJvbQ0KPiBhbm90aGVy
IGRldmljZSB3aXRoIGFsbCB0aGVzZSBleHBvc2VkIGFzIGRpZmZlcmVudCBjaGFubmVscyB3aGVu
IGEgcmVhZCBpcw0KPiByZXF1ZXN0ZWQuDQo+IFRoZXJlIGFyZSBxdWl0ZSBhIGZldyBkcml2ZXJz
IGRvaW5nIHRoaXMgYWxyZWFkeS4NCj4gDQo+IFRoZSBzb3VyY2UgdnMgc2luayB0aGluZyBtYXkg
bmVlZCB0byBiZSBkb25lIHZpYSBsYWJlbHMgYXMgaXQgaXNuJ3QgYSBjb25jZXB0DQo+IHRoYXQg
bWFwcyBkaXJlY3RseSB0byBBREMgY2hhbm5lbCBjaGFyYWN0ZXJpc3RpY3MuDQo+IA0KPiBJZiB0
aGlzIGlzIGJlaW5nIHJvdXRlZCB0byBzb21lIGV4dGVybmFsIGhhcmR3YXJlIG1vbml0b3Jpbmcg
dGhlbiBtb3N0IGxpa2UNCj4gdGhpcyBzaG91bGQgYmUgaW4gZGV2aWNlIHRyZWUgYXMgZG9lc24n
dCBtYWtlIHNlbnNlIHRvIHN3aXRjaCBkeW5hbWljYWxseSBpbg0KPiBhbnkgY2FzZXMgdGhhdCBJ
IHJlY2FsbCBmcm9tIHByZXZpb3VzIHNpbWlsYXIgZHJpdmVycy4NCj4gDQo+IEpvbmF0aGFuDQo+
IA0KPiA+ICsJCSogcG93ZXJlZF9kb3duIC0gTVVYX09VVCBwaW4gaXMgcG93ZXJlZCBkb3duLiBB
biA4MGvOqQ0KPiBpbXBlZGFuY2UNCj4gPiArCQkJCSBjYW4gYmUgc2VlbiBhdCB0aGUgTVVYX09V
VCBwaW4uDQo+ID4gKwkJKiB2b3V0MCAtIFZvbHRhZ2UgcmVwcmVzZW50YXRpb24gb2YgVk9VVDAu
DQo+ID4gKwkJKiBpb3V0MF9zb3VyY2UgLSBWb2x0YWdlIHJlcHJlc2VudGF0aW9uIG9mIElPVVQw
IChzb3VyY2UNCj4gbW9kZSkuDQo+ID4gKwkJKiBpb3V0MF9zaW5rIC0gVm9sdGFnZSByZXByZXNl
bnRhdGlvbiBvZiBJT1VUMCAoc2luayBtb2RlKS4NCj4gPiArCQkqIHZvdXQxIC0gVm9sdGFnZSBy
ZXByZXNlbnRhdGlvbiBvZiBWT1VUMS4NCj4gPiArCQkqIGlvdXQxX3NvdXJjZSAtIFZvbHRhZ2Ug
cmVwcmVzZW50YXRpb24gb2YgSU9VVDEgKHNvdXJjZQ0KPiBtb2RlKS4NCj4gPiArCQkqIGlvdXQx
X3NpbmsgLSBWb2x0YWdlIHJlcHJlc2VudGF0aW9uIG9mIElPVVQxIChzaW5rIG1vZGUpLg0KPiA+
ICsJCSogdm91dDIgLSBWb2x0YWdlIHJlcHJlc2VudGF0aW9uIG9mIFZPVVQyLg0KPiA+ICsJCSog
aW91dDJfc291cmNlIC0gVm9sdGFnZSByZXByZXNlbnRhdGlvbiBvZiBJT1VUMiAoc291cmNlDQo+
IG1vZGUpLg0KPiA+ICsJCSogaW91dDJfc2luayAtIFZvbHRhZ2UgcmVwcmVzZW50YXRpb24gb2Yg
SU9VVDIgKHNpbmsgbW9kZSkuDQo+ID4gKwkJKiB2b3V0MyAtIFZvbHRhZ2UgcmVwcmVzZW50YXRp
b24gb2YgVk9VVDMNCj4gPiArCQkqIGlvdXQzX3NvdXJjZSAtIFZvbHRhZ2UgcmVwcmVzZW50YXRp
b24gb2YgSU9VVDMgKHNvdXJjZQ0KPiBtb2RlKS4NCj4gPiArCQkqIGlvdXQzX3NpbmsgLSBWb2x0
YWdlIHJlcHJlc2VudGF0aW9uIG9mIElPVVQzIChzaW5rIG1vZGUpLg0KPiA+ICsJCSogdm91dDQg
LSBWb2x0YWdlIHJlcHJlc2VudGF0aW9uIG9mIFZPVVQ0Lg0KPiA+ICsJCSogaW91dDRfc291cmNl
IC0gVm9sdGFnZSByZXByZXNlbnRhdGlvbiBvZiBJT1VUNCAoc291cmNlDQo+IG1vZGUpLg0KPiA+
ICsJCSogaW91dDRfc2luayAtIFZvbHRhZ2UgcmVwcmVzZW50YXRpb24gb2YgSU9VVDQgKHNpbmsg
bW9kZSkuDQo+ID4gKwkJKiB2b3V0NSAtIFZvbHRhZ2UgcmVwcmVzZW50YXRpb24gb2YgVk9VVDUu
DQo+ID4gKwkJKiBpb3V0NV9zb3VyY2UgLSBWb2x0YWdlIHJlcHJlc2VudGF0aW9uIG9mIElPVVQ1
IChzb3VyY2UNCj4gbW9kZSkuDQo+ID4gKwkJKiBpb3V0NV9zaW5rIC0gVm9sdGFnZSByZXByZXNl
bnRhdGlvbiBvZiBJT1VUNSAoc2luayBtb2RlKS4NCj4gPiArCQkqIHZvdXQ2IC0gVm9sdGFnZSBy
ZXByZXNlbnRhdGlvbiBvZiBWT1VUNi4NCj4gPiArCQkqIGlvdXQ2X3NvdXJjZSAtIFZvbHRhZ2Ug
cmVwcmVzZW50YXRpb24gb2YgSU9VVDYgKHNvdXJjZQ0KPiBtb2RlKS4NCj4gPiArCQkqIGlvdXQ2
X3NpbmsgLSBWb2x0YWdlIHJlcHJlc2VudGF0aW9uIG9mIElPVVQ2IChzaW5rIG1vZGUpLg0KPiA+
ICsJCSogdm91dDcgLSBWb2x0YWdlIHJlcHJlc2VudGF0aW9uIG9mIFZPVVQ3Lg0KPiA+ICsJCSog
aW91dDdfc291cmNlIC0gVm9sdGFnZSByZXByZXNlbnRhdGlvbiBvZiBJT1VUNyAoc291cmNlDQo+
IG1vZGUpLg0KPiA+ICsJCSogaW91dDdfc2luayAtIFZvbHRhZ2UgcmVwcmVzZW50YXRpb24gb2Yg
SU9VVDcgKHNpbmsgbW9kZSkuDQo+ID4gKwkJKiBkaWVfdGVtcCAtIFZvbHRhZ2UgcmVwcmVzZW50
YXRpb24gb2YgaW50ZXJuYWwgZGllDQo+IHRlbXBlcmF0dXJlLg0KPiA+ICsJCSogYWduZCAtIE1V
WF9PVVQgcGluIGludGVybmFsbHkgdGllZCB0byBBR05ELg0KPiA+ICsNCj4gPiArV2hhdDoNCj4g
CS9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2VYL211eG91dF9zZWxlY3RfYXZhaWxhYmxl
DQo+ID4gK0tlcm5lbFZlcnNpb246DQo+ID4gK0NvbnRhY3Q6CWxpbnV4LWlpb0B2Z2VyLmtlcm5l
bC5vcmcNCj4gPiArRGVzY3JpcHRpb246DQo+ID4gKwkJUmVhZGluZyB0aGlzIHJldHVybnMgdGhl
IHZhbGlkIHZhbHVlcyB0aGF0IGNhbiBiZSB3cml0dGVuIHRvIHRoZQ0KPiA+ICsJCW11eG91dF9z
ZWxlY3QgYXR0cmlidXRlOg0KPiA+ICsJCSogcG93ZXJlZF9kb3duDQo+ID4gKwkJKiB2b3V0MA0K
PiA+ICsJCSogaW91dDBfc291cmNlDQo+ID4gKwkJKiBpb3V0MF9zaW5rDQo+ID4gKwkJKiB2b3V0
MQ0KPiA+ICsJCSogaW91dDFfc291cmNlDQo+ID4gKwkJKiBpb3V0MV9zaW5rDQo+ID4gKwkJKiB2
b3V0Mg0KPiA+ICsJCSogaW91dDJfc291cmNlDQo+ID4gKwkJKiBpb3V0Ml9zaW5rDQo+ID4gKwkJ
KiB2b3V0Mw0KPiA+ICsJCSogaW91dDNfc291cmNlDQo+ID4gKwkJKiBpb3V0M19zaW5rDQo+ID4g
KwkJKiB2b3V0NA0KPiA+ICsJCSogaW91dDRfc291cmNlDQo+ID4gKwkJKiBpb3V0NF9zaW5rDQo+
ID4gKwkJKiB2b3V0NQ0KPiA+ICsJCSogaW91dDVfc291cmNlDQo+ID4gKwkJKiBpb3V0NV9zaW5r
DQo+ID4gKwkJKiB2b3V0Ng0KPiA+ICsJCSogaW91dDZfc291cmNlDQo+ID4gKwkJKiBpb3V0Nl9z
aW5rDQo+ID4gKwkJKiB2b3V0Nw0KPiA+ICsJCSogaW91dDdfc291cmNlDQo+ID4gKwkJKiBpb3V0
N19zaW5rDQo+ID4gKwkJKiBkaWVfdGVtcA0KPiA+ICsJCSogYWduZA0KPiA+IGRpZmYgLS1naXQg
YS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+ID4gaW5kZXgNCj4gZmZkYjNmMjFmYzRmYjM1
YjM0OTQ0OWFmYmIzMGZlY2Q0ZmU3Mjk3OC4uMmQzYzMxYzc0NTk0Y2ExOTM0YzY3ZTdhYWQNCj4g
MGExNzlmZWVhYTM5YmYgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysgYi9N
QUlOVEFJTkVSUw0KPiA+IEBAIC0xMjg5LDYgKzEyODksMTMgQEAgVDoJZ2l0DQo+IGdpdDovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LmdpdA0KPiA+
ICBUOglnaXQgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25l
dGRldi9uZXQtbmV4dC5naXQNCj4gPiAgRjoJZHJpdmVycy9uZXQvYW10LmMNCj4gPg0KPiA+ICtB
TkFMT0cgREVWSUNFUyBJTkMgQUQzNTMwUiBEUklWRVINCj4gPiArTToJS2ltIFNlZXIgUGFsbGVy
IDxraW1zZWVyLnBhbGxlckBhbmFsb2cuY29tPg0KPiA+ICtMOglsaW51eC1paW9Admdlci5rZXJu
ZWwub3JnDQo+ID4gK1M6CVN1cHBvcnRlZA0KPiA+ICtXOglodHRwczovL2V6LmFuYWxvZy5jb20v
bGludXgtc29mdHdhcmUtZHJpdmVycw0KPiA+ICtGOglEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5n
L3N5c2ZzLWJ1cy1paW8tZGFjLWFkMzUzMHINCj4gPiArDQo+ID4gIEFOQUxPRyBERVZJQ0VTIElO
QyBBRDM1NTJSIERSSVZFUg0KPiA+ICBNOglOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0K
PiA+ICBMOglsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+ID4NCg0K

