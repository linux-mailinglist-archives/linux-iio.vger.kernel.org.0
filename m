Return-Path: <linux-iio+bounces-23774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC11B4580D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DF63B7822
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB134F47B;
	Fri,  5 Sep 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="bx072upb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB12E8B9A;
	Fri,  5 Sep 2025 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076292; cv=fail; b=uiaVfo36WHg83xEyjrI9ATKL73x1boP7ZHWDifZM+gE4a8FYqXf14G6TxU+BAl+1I2Rm3oa1qzhIRWQfKDqIj2GY5drKnGSMBSC77Fd+/h5mzmknpvx8jk0iPqYhKo+8FBztT+/ow+srzMvGBUnpE3hNsjOgENAZQeOMdQTMe6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076292; c=relaxed/simple;
	bh=VmTNs6aIx7fwJfEG+Abpu/UvgT0h3oEk5iV0DUBBj2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=piIUOBkWBdwHKffWkbfeFdxCbKBmH+yZFCiBvU+/eBu+X5TmzUcdi4+tWG4MBZjKRbX1BW0A2avoPerpRsQWNKdTvc4k+6+dSqG4D+xafnnxSfNv86BjHcQJF9+PdYg8TnO8LYSICCpRxJ+LMPguvKXNYK35vglvmVKpXWuXH4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=bx072upb; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585CH4ID022534;
	Fri, 5 Sep 2025 12:44:31 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010069.outbound.protection.outlook.com [52.101.169.69])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48y0m8shkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 12:44:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmI0ky10fHeIOenlbDhjsGCtOQBrTxazvOEeJIdlF/8cGzLvekWvZTEDwIzvfZKfNrMoldA5GHSICHuh5vP7uN/tvmRe8H1eVDuGP9CdPO48AoarBkNma50WcmPoyocY5/f8tRcYBUok+e9ZV77v89F0XhU95Cn5GH5kAmAun+IUAMSVCWnPp53+ithBd0rpYiEkIciBUdoc9wE8RqkV69sINVa4YGW9VuGVRRadkUspAQT2bGw7k7vabvBS+oK9yyBrY9qcnqvW1ek8YWpypkCmfPqGKqKf1FN6Cp7RpZSgojCymgz2HDuZCL7dmin60aoIPBmuUbdEj0BJpS2a4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmTNs6aIx7fwJfEG+Abpu/UvgT0h3oEk5iV0DUBBj2Y=;
 b=rizOULLJwTuEholNLuqLAW83KH+nJLbe+cAbrWHQVPRyRfLRISwFjnZ1Ubo6BvH1PDK4gwu1ZBBSmFwfNBw1hG2Mjyi3tobr24yjCIrDqUR5QvyggZ3JRg6MfrdgJKR+E6ZdOR7gQC60Ece1XXgYrm6LBjjs/LO0LMapuAElVlfrPmNMcsouoruug0pTxchD9A0zP6w2aIfgCaaCxCBcTVIP45LSAHLISOrXXt+9LZLbPFc6U57xeYbYdkgjOIdOmF1/expHKJWfwRNiputgSfh5/xszEIGeL2tK6n6A4JLFwbOBOrx5lbgRiFodauuA7OBOZUGO4PtzKpwCzGl64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmTNs6aIx7fwJfEG+Abpu/UvgT0h3oEk5iV0DUBBj2Y=;
 b=bx072upbW7K8D6A2vG7laR0WTeCz+wEEiMQdtqZLZvf1ZSLmby0/8iv83yE5MDCEPk0vM47y5TFzNCEqS3Bh56Dtxy9x1nijmC979+dqnt+F7xImvgleHby5wSBcnyD38jRjvktlojllV4DlU3pwwPWT6QBovcUwVlwzlN3x7YJHIiQ43TYM052T7/6RemjCR84i6wazqn1wd3yA+yrp5RnLbKDpabFvi9EWnmW2AJGDUi8Sm5mYU2bheOAAl+U8gLwxpoFocbvpveaNzHb4ST2VfFRmlGmoBTIe/C1boJzjFMoynoRGzqle2khvrAVleBTWG8Y+bZlbPr/rPELlNA==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR6P281MB3914.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:10f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 12:44:24 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 12:44:24 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Frank Li <Frank.Li@nxp.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Topic: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Index: AQHcEd4ztutuCFLUl0eAj91guc48ZbRs1gyAgBXxAsCAAFqbAIABf+Hg
Date: Fri, 5 Sep 2025 12:44:23 +0000
Message-ID:
 <FR2PPF4571F02BCEB6C4FA4B3641299A72C8C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
 <aKbk9WYtfb5L5la4@smile.fi.intel.com>
 <FR2PPF4571F02BCCFD984FDD99C69CAE7298C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aLmY2mKg_FsPOpsq@smile.fi.intel.com>
In-Reply-To: <aLmY2mKg_FsPOpsq@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR6P281MB3914:EE_
x-ms-office365-filtering-correlation-id: 143e9b0b-43b3-45e4-58dc-08ddec79f167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXp0VkpOUS9USXlFMGgydWcyaWZRcjZ0bjNDL0JqTzBxaXhMZEp3WUtMMTQy?=
 =?utf-8?B?alUzMlhiOUc5MjBvdmplZitYbUg1MWdLdWZqTWhhcjE2T0NnV3ByUW5FRWdO?=
 =?utf-8?B?a1NSamw0VGU0OFBnN2xNS0grbCt5OU5sM3ZvU3VYZGUwamhxNzhpK3JqNlhU?=
 =?utf-8?B?RmRWeTI1bGVpNG5pR2V2d0V1UE1HZW8zdGpXQ1V3cTFYenVTalBrbnY3azZQ?=
 =?utf-8?B?ZFhSSjFQQU44dzEzUXJVTENJa1lOMEh0bW5jOVdHZWhEMENUOWlON1dScWxB?=
 =?utf-8?B?bVkrb1daRzlzTXNuQ1BsaHl1ZTR6V3BBMEJnSXFxekJhWmx1ZVZ3dlBVZXkr?=
 =?utf-8?B?Z1BtYVFZbjFKTzUrYlN4eUdva200SGtzSU1xSCtqeHlVeWFhd0krWWZKSjEz?=
 =?utf-8?B?SlFSckhkbkxVVnZTUUlGRitlWTlrUTBtTGk4dVRhTExQWG85YVZuRlZYSUo2?=
 =?utf-8?B?dDhERlM4MmJJU2F4WHBsMWJDaERPZmJUVXRsOWU1RGhWWmRta1JXSElRaTIr?=
 =?utf-8?B?b3FTNG5uaWdZUkdkaDFQSjdteDFQVzFicmQwOTNpN3FSc1BscHFIRDNtUFE2?=
 =?utf-8?B?OUhxYWI0UlhHYWI3eiszOTBJSUUxbWM0L0xZKzgya1ZieHJnMUMwcUNhVDJV?=
 =?utf-8?B?Q1BSVjBNRG1GVWRwMC8xVmRsYjhobVE4alZLTjI4STNoOWZlYU5jNlpQQVo2?=
 =?utf-8?B?b2hpWnE0L3dCTWxIN2QzTzVqRlFhOHhYM2cxRHprcWlxeHZlMUJuM21SQ2JW?=
 =?utf-8?B?cCtNVzk5d212SVF1OFRENjlmZ3BMM1hFMnM5dnVxUmZtNk13N0J5NlFrNlZj?=
 =?utf-8?B?V0NjdERsUU1RY0pBdEF0ZVlxVDdkQVJBSUtxZFAyaTJpQnlOMDhrZmhvY0VT?=
 =?utf-8?B?bjVnMkw2ZHMzUGpBNEtNRkRxd2lPK0ZtZDNCT24xeEp5QUErU0RzUWltQjYr?=
 =?utf-8?B?VVVoOUYxN1dPdG85MWdHVEdBNHlkUmp3N25GRWlZSTljM0tyTENCdWJYR0J1?=
 =?utf-8?B?d2FvYzNuaU1tekFhZXdOUFpCWWs4YVIvc3Jqby9mRmFNVk5VeDRYcXM3THpW?=
 =?utf-8?B?YnNobHhmNGhkdGlQY29BVThQTy93d2ZEOUhUT1NJUXRCZDh0QWsxZVhrc2I2?=
 =?utf-8?B?T0hpWi9EU2t0YjFWcEJDN3RGSUhDcEM1OU1VWmdmc051Q1czNHdPM2RXekZr?=
 =?utf-8?B?cEJTeTdyQk5ZaGtmb3FFSE4xM2U2cWFnb0tTK1VpcVdQUTBkUE40TUVuSEJw?=
 =?utf-8?B?T1N1bU5TemtDbXdDd2VoU3JGUmV6ZXllUjVWaXE3MHFkQTZIdmhBWm9HQUdu?=
 =?utf-8?B?MGNpdDR6ZlRJbmFpYVhIeDBEWnRlcmlWQTk1S1VNWXNjVG9lYlo0WWhCV01s?=
 =?utf-8?B?MWdnbzFHQUtNZWJnNUtTZWtlQlZIVEI4RU83ODUzeG1obTJVczlsOXF4WVU4?=
 =?utf-8?B?QUVzckFIUld3SHVTYkpUOXo2bzk1d0R0SEQ0cjkvenViYUZmc3ZSVnNMb0U0?=
 =?utf-8?B?elhuQVduSnR3dTVJNk0xRi9xa1JYb3o2OWc1L04rcmFMYVlXZXBoQUJtcncv?=
 =?utf-8?B?SFY0WHRyR1BmbnZWTGVUdHZySnRBUmdua0FQYndqT0w5WDRteFFzMHNLLzA0?=
 =?utf-8?B?bWVNL25qV2lSQkNJdlZTSys0S0xNRU8xQlZncHFYdWxUcWRWYUpkTUx3ZTJ6?=
 =?utf-8?B?Yzg3WW5IUmptbHlYN3JGaUt6L3l5Zmg4cG1JQlBpQm0wa3R6S09SUk42Z3g4?=
 =?utf-8?B?cVM0ZkY4WHVNZGdCVmQ2UGgySVBmWk9ZWW5tZGg4RHpPRlFMUjVEZ0lUMGxY?=
 =?utf-8?B?elZmdEVBbVN1QzVjUjlvcDlLTU50em5jaTJQdWZ3Z0R5alBiR0thZUJCN1JX?=
 =?utf-8?B?UHZBKzFOYW1sVGM4MloyZ3ptM0dQelh6Zzhla1k2a0k1cmhlSzlJYWJFZFpV?=
 =?utf-8?B?ODlIaEI3OXNUalVsaWlxN2h1ZDdIQTFkUWZtdlRKLzNmM1dVbGRhZGpuTHVp?=
 =?utf-8?B?UnMza3NtdVJGNFZjL1preElxc1hTRWcvb1BoK0JlTi9qWmY5WlhLRkozTDBM?=
 =?utf-8?Q?CXvFYL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTZ1clcwS3pUMFJCb0VFb2g3Mi82SlpvM2lJYUdxb0UyMjhEZnFldGtsMWFo?=
 =?utf-8?B?Nm9oRnBQeCtCYmQ2UUdXNFBwUHpGMi9rdkdxejlxWm1PZzN4RlFZUFFPMXB4?=
 =?utf-8?B?dHFvNW9DbEt6WU9NQUk5RTlQUEE3aGtGeUsrdlVoRE9aRmY3NUIwVlBWeUhY?=
 =?utf-8?B?OS8zanRka0RVZW9aQTJxNVRFWk8rbjVhdzhnYm5vbGJJWHZ0MmNvS0k1TnlJ?=
 =?utf-8?B?VXFBdmR1K1JtdnFwMUxMTm9YYUlzQ3RaUW5lTGtzVzNoZWlNRU4zOG85VTVV?=
 =?utf-8?B?bGpTRmJrQVpKdkJHQmd1MGJqVHlkR0h5dkt6aUFUYUJNUnd2d0p2eVptOFFi?=
 =?utf-8?B?S2hrRWFNNCtsZmRyd0tDTXdEOVp3ZkY4M01GbDRYYUlkVzY5Ulpxc3doVTMz?=
 =?utf-8?B?UXVWSGNRZ01MU1lhdkx3V0xBaTB1a1lzcnYxSTFZcnBKYWZxSmc5T3FJaCt4?=
 =?utf-8?B?aEhpWHpKNWo4MjkyTW9uaEZ4cnhvd1l0VEZiRXVZZzQzY2ZTd0pEZnN2alkr?=
 =?utf-8?B?anNSZ0RvREtVbE1zMG93eWxsckpITXQzVlFETTc4bXBEcE8veWVlbXFMbWI0?=
 =?utf-8?B?UjN1bnpuMFVhVVpVT0tQMmFtZ1I0SVE2STRYQ2d1eUl0UWd4Z1dSZWpEWDhq?=
 =?utf-8?B?QW1TL0EwOXBWQUpSTi9ZYTBKTkg3V05iN3p5N2d3WkxjWnJENlRVejQ2TzBj?=
 =?utf-8?B?T2YrSUEwZC9xdUo5Tk0xTC9mak9KbGdWYThLSnU4OGZXdm10K1MvR0hJYkFp?=
 =?utf-8?B?MmsrQk1lYjBVTFhQSktzNWNiL3pCOHdHV2VsNTIxOWNxNkFDZzNtdFVMcXpQ?=
 =?utf-8?B?Y3ZHS1lNSldqSHNta05oY0VxalRNamNrR21qSE10WlprbnNoOTNYNEtvdVE3?=
 =?utf-8?B?dWgrOFFIZXlDMDlYWUpYT3NITTBvdmtyT1NCeWhNWUNBUExrS3hxN3JVdXJo?=
 =?utf-8?B?VkNvdStsT0lCK0tnR3kzc1pPcFNOdFYxRkhOZENjc0crVmpTcHJ5SzlScEhm?=
 =?utf-8?B?M0VnYXo3K1JFZ1VsWUlnM0RhSU1jQlVhRTE2bTdlNjU1YUxoKzd0Y090d25K?=
 =?utf-8?B?a1p4cGZ0VEh2Tm1FdDFjYWpRNHRtRk8wYncwRkpBVGlNVGZJc1pCSk9UL2x5?=
 =?utf-8?B?UC9nejNkdWlTd0lORkQvWDFyUWlnMTYrZ0NrYXJBRVo2YkJlaDdmbHYwNTVr?=
 =?utf-8?B?cjl0MWJhV24zL3c1LzQ0NGM4TXN2NEd4SmpLVzFtbzAzSzdzY29GZkhXQUMw?=
 =?utf-8?B?WUJLNW9SeUM1WVVVaDVPMGdETWUxK3hFSXR2RjlQelM2OFQ2Wkx5NnVvS0hh?=
 =?utf-8?B?WFg1SXhVWTlvOUdNL1J6QXRPSU5MeS9JYkNML1pPamQ1bWg0VGoxZ3FoaWtG?=
 =?utf-8?B?K2NUM2svSVRrTGs5VkJmTEtmYWZLZHVxOEErdVVEUnhUL1laTjQyamZpeXNM?=
 =?utf-8?B?eW12SU0xTUxrcFIvdFN2SjNLZnRhdDdhOVhndXhDVE1aMEpPN1NRMzZLVjZl?=
 =?utf-8?B?MUsvaTZtU24zK3NubW5Fdm92bHlkZzJWOWQzMDhERzJMeEhFelA3NklkbG5H?=
 =?utf-8?B?QWg5Y2NvWldTbmVSbVd1dDVCMlRTLzJJOERLRk1SL2N6MVl4MjUyV25tK0xk?=
 =?utf-8?B?U3dlcjNjQWNtT25hLy94bFQzNnlTYWpCZjhKVG42OERCbE5ocEpaKy9OM0l1?=
 =?utf-8?B?bUkzNXNubjZuN0Y5dU8vQzZsRTVzNnNYN1VOSzhybCsxdkUrRDhLQ2VZZlp3?=
 =?utf-8?B?dFMzY3VWODcxeGhMUDJTcnczVTczeDNhb09hTzExcjAwVFBYcUVhN3lhSTJE?=
 =?utf-8?B?c3VONWVIWVk5cW12UDVpbnRZNTQ4b0ZjNFVBc1dKZjc0SHZSNkRUTkpVT2lG?=
 =?utf-8?B?T08zaCt5RURsRGdWaVFQTXF5NGdlaWFyeWVBMnV3aU5TNjVmTFVGOFpHYXc2?=
 =?utf-8?B?akNTcGJSNHQwUlcyWDBpamJVSDVxelRrclo5SFRrTzBCN1JCaHVaUDNZbHMy?=
 =?utf-8?B?bjJMaURwSkh3aW1vOHA4RGhJZkgzR3hyemRGQXk2Q1NDL29oQjJTRWhmT0xi?=
 =?utf-8?B?M2tNeEdhMkQ2c0xWSDQxN1hyMXhtRk1OeU96Yk1lRklrK1IvUlV4eVZKcDY3?=
 =?utf-8?Q?CNEtge/1QUWv8yL4F9af1Vmtx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 143e9b0b-43b3-45e4-58dc-08ddec79f167
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 12:44:24.1527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ah1wgJlFkBZnPsQf21wTn8WSIkYZ0UqrbGutvlrfsoCHIqjWEqs6kFvQQxTu9mi38wTUeehoPYyjA7qrE43Sug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3914
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDAwNyBTYWx0ZWRfX1FyS0YJ+2+AH
 oRaD433W705r0/3E7uRvEvqxFqAd36oCT0AMIAU2wcFEO1Rh5Q1sU0jjUzh0CuT6pskObtWUlRe
 n4Tte+XTy8RLfC/60FGHX5YThr/lr7P2Wf1i0ZdXrx2PdD0DtgeffRI+xQvJ9KLfRpcmrPvA3Y7
 mR8y60mdCjwFMYidrjKfigTD3YnNsR4yCFf/21RQeTjK7b9pJ0wwPBH9NFD2Du8quUp/MntNTqI
 lbl2iUdySIN4zXg2VGEBpavOiQfXObfHTLKrLtmqapSrinecCjrK+fcE/6SAC3kS6p3+NNkuGH5
 qKurKBI8VZfBn6IQY3K/CbQOh0TVMmSODWFyU1yN38Zc0dGB6itLZst4ptrzPjWSeQSWpdPt+gM
 BYyI2XNB
X-Proofpoint-GUID: X28KktJFQWqGQo_gMeJ3r8vDl234NQn6
X-Proofpoint-ORIG-GUID: X28KktJFQWqGQo_gMeJ3r8vDl234NQn6
X-Authority-Analysis: v=2.4 cv=KqxN2XWN c=1 sm=1 tr=0 ts=68badb2f cx=c_pps
 a=lWf2iTqpIylLU4dOpTNhsw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=Uwzcpa5oeQwA:10 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8
 a=P-IC7800AAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=vlFXYoOqsWEZmrwDMLoA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=d3PnA9EDa4IxuAV0gXij:22 a=ST-jHhOKWsTCqRlWije3:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509040007

Pg0KPg0KPkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29t
PiANCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDQsIDIwMjUgMzo0OSBQTQ0KPlRvOiBSZW1p
IEJ1aXNzb24gPFJlbWkuQnVpc3NvbkB0ZGsuY29tPjsgQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhh
bmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPjsgRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+
Q2M6IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBEYXZpZCBMZWNobmVyIDxk
bGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPjsgQW5k
eSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9v
bGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj5T
dWJqZWN0OiBSZTogW1BBVENIIHY1IDMvOV0gaWlvOiBpbXU6IGludl9pY200NTYwMDogYWRkIGJ1
ZmZlciBzdXBwb3J0IGluIGlpbyBkZXZpY2VzDQo+DQo+K0NjIEnCs0MgcGVvcGxlIHRvIGNvbW1l
bnQgb24gdGhlIHJldHVybmVkIHZhbHVlcyBvbiB0aGUgcmVnbWFwLiBTZWUgYmVsb3cuDQo+DQo+
T24gVGh1LCBTZXAgMDQsIDIwMjUgYXQgMDE6MDE6MzJQTSArMDAwMCwgUmVtaSBCdWlzc29uIHdy
b3RlOg0KPj4gPkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwu
Y29tPiANCj4+ID5TZW50OiBUaHVyc2RheSwgQXVndXN0IDIxLCAyMDI1IDExOjIxIEFNDQo+PiA+
T24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMDI6MjQ6MjFQTSArMDAwMCwgUmVtaSBCdWlzc29uIHZp
YSBCNCBSZWxheSB3cm90ZToNCj4NCj4uLi4NCj4NCj4+ID4+ICsjZGVmaW5lIElOVl9JQ000NTYw
MF9TRU5TT1JfQ09ORl9LRUVQX1ZBTFVFUyB7VThfTUFYLCBVOF9NQVgsIFU4X01BWCwgVThfTUFY
LCB9DQo+PiA+DQo+PiA+V2hlbiBvbmUgbGluZSwgbm8gbmVlZCB0byBoYXZlIGlubmVyIHRyYWls
aW5nIGNvbW1hLCBiZXNpZGVzIHRoYXQgbWlzc2VkDQo+PiA+c3BhY2UuDQo+PiBUaGUgdHJhaWxp
bmcgY29tbWEgd2FzIGEgcmVxdWVzdCBmcm9tIEpvbmF0aGFuIENhbWVyb24gb24gdGhlIHYyIG9m
IHBhdGNoc2V0Lg0KPj4gTGV0IG1lIGtub3csIGlmIHlvdSBkaXNhZ3JlZSB3aXRoIGhpbSBhbmQg
SSdsbCBmaXguDQo+DQo+SSBzZWUsIHRoZW4gbGV0J3MgYXNrIGhpbSwgYmVjYXVzZSBpdCdzIGEg
dXN1YWwgcGF0dGVybiBmb3INCj50aGUgb25lLWxpbmUgYXJyYXlzIGxpa2UgdGhpcyB0byBoYXZl
IG5vIGlubmVyIHRyYWlsaW5nIGNvbW1hcy4NCk9rIGxldCdzIHdhaXQgSm9uYXRoYW4gQ2FtZXJv
bidzIGZlZWRiYWNrLg0KDQo+DQo+PiBBbmQgSSdsbCBhZGQgYSBzcGFjZSBiZWZvcmUgZmlyc3Qg
ZWxlbWVudC4NCj4NCj4uLi4NCj4NCj4+ID4+ICsJLyogVHJ5IHRvIHJlYWQgYWxsIEZJRk8gZGF0
YSBpbiBpbnRlcm5hbCBidWZmZXIuICovDQo+PiA+PiArCXN0LT5maWZvLmNvdW50ID0gZmlmb19u
YiAqIHBhY2tldF9zaXplOw0KPj4gPj4gKwlyZXQgPSByZWdtYXBfbm9pbmNfcmVhZChzdC0+bWFw
LCBJTlZfSUNNNDU2MDBfUkVHX0ZJRk9fREFUQSwNCj4+ID4+ICsJCQkJc3QtPmZpZm8uZGF0YSwg
c3QtPmZpZm8uY291bnQpOw0KPj4gPj4gKwlpZiAocmV0ID09IC1FTk9UU1VQUCB8fCByZXQgPT0g
LUVGQklHKSB7DQo+PiA+DQo+PiA+U3RyaWN0bHkgc3BlYWtpbmcgdGhpcyBpcyBhIGJpdCBvZiBs
YXllcmluZyBpc3N1ZSwgZG8gd2UgaGF2ZSBvdGhlciBtZWFucyB0bw0KPj4gPmNoZWNrIHRoZSBz
dXBwb3J0IGJlZm9yZSBldmVuIHRyeWluZz8NCj4+IA0KPj4gTm8gdW5mb3J0dW5hdGVseSwgd2Ug
Y2FuJ3Qgd2l0aCBjdXJyZW50IEkzQyByZWdtYXAgaW1wbGVtZW50YXRpb24uDQo+PiBJMkMgYW5k
IFNQSSByZWdtYXBzIGFyZSBhYmxlIHRvIHNwbGl0IHRyYW5zZmVycyBhY2NvcmRpbmcgdG8gbWF4
X3JlYWRfbGVuLg0KPj4gQnV0IGZvciBJM0MsIGl0IGlzIGxlZnQgdG8gdGhlIGNvbnRyb2xsZXIg
ZHJpdmVyLCB3aGljaCB1c3VhbGx5IG9ubHkgcmV0dXJucyBhbiBlcnJvci4NCj4NCj5IYXZlIGl0
IGJlZW4gZGlzY3Vzc2VkIHdpdGggScKzQyBtYWludGFpbmVycyAvIHN0YWtlaG9sZGVycz8gQmVj
YXVzZSB0aGlzIGtpbmQgb2YgQVBJcw0KPndpbGwgYmUgaGFyZCB0byBmb2xsb3cgYW5kIGV2ZW4g
Y2hhbmdlIGZvciBib3RoIHNpZGVzIGNhbGxlciBhbmQgY2FsbGVlLg0KVGhhbmtzIGZvciBvcGVu
aW5nIHRoZSBkaXNjdXNzaW9uLg0KV2UgaW1wbGVtZW50ZWQgdGhlIG1hbmFnZW1lbnQgb2YgZXJy
b3IsIGluIGEgd2F5IHRoYXQgKHdlIHRoaW5rKSBtYWtlcyBzZW5zZSwNCndoYXRldmVyIHRoZSBi
ZWxvdyBsYXllcnMgYXJlIGRvaW5nLg0KDQo+DQo+PiA+PiArCQkvKiBSZWFkIGZ1bGwgZmlmbyBp
cyBub3Qgc3VwcG9ydGVkLCByZWFkIHNhbXBsZXMgb25lIGJ5IG9uZS4gKi8NCj4+ID4+ICsJCXJl
dCA9IDA7DQo+PiA+PiArCQlmb3IgKGkgPSAwOyBpIDwgc3QtPmZpZm8uY291bnQgJiYgcmV0ID09
IDA7IGkgKz0gcGFja2V0X3NpemUpDQo+PiA+PiArCQkJcmV0ID0gcmVnbWFwX25vaW5jX3JlYWQo
c3QtPm1hcCwgSU5WX0lDTTQ1NjAwX1JFR19GSUZPX0RBVEEsDQo+PiA+PiArCQkJCQkJJnN0LT5m
aWZvLmRhdGFbaV0sIHBhY2tldF9zaXplKTsNCj4+ID4+ICsJfQ0KPj4gPj4gKwlpZiAocmV0KQ0K
Pj4gPj4gKwkJcmV0dXJuIHJldDsNCj4NCj4uLi4NCj4NCj4+ID4+ICsJLyogRGlzYWJsZSBGSUZP
IGFuZCBzZXQgZGVwdGguICovDQo+PiA+PiArCXZhbCA9IEZJRUxEX1BSRVAoSU5WX0lDTTQ1NjAw
X0ZJRk9fQ09ORklHMF9NT0RFX01BU0ssDQo+PiA+PiArCQkJIElOVl9JQ000NTYwMF9GSUZPX0NP
TkZJRzBfTU9ERV9CWVBBU1MpOw0KPj4gPj4gKwl2YWwgfD0gSU5WX0lDTTQ1NjAwX0ZJRk9fQ09O
RklHMF9GSUZPX0RFUFRIX01BWDsNCj4+ID4NCj4+ID5GSUVMRF9NT0RJRlkoKQ0KPj4gT2ssIGdy
ZWF0Lg0KPg0KPkFjdHVhbGx5IHRoaXMgaXMgbm90IGEgbW9kaWZpY2F0aW9uIHBlciBzZSwgaXQn
cyBqdXN0IGFuIGFzc2lnbm1lbnQgKFBSRVApDQo+c3BsaXQgdG8gdHdvIGxpbmVzLCBjYW4geW91
IGp1c3QgbWFrZSBpdCBhIHNpbmdsZSBleHByZXNzaW9uICh3cmFwcGVkIG9uIGEgZmV3DQo+bGlu
ZXMsIHRob3VnaCk/DQo+DQpZb3UgbWVhbiBkcm9waW5nIHRoZSBGSUVMRF9NT0RJRlkgc3VnZ2Vz
dGlvbiBhbmQgZG9pbmcgc29tZXRoaW5nIGxpa2U6DQp2YWwgPSBGSUVMRF9QUkVQKElOVl9JQ000
NTYwMF9GSUZPX0NPTkZJRzBfTU9ERV9NQVNLLA0KCQkgSU5WX0lDTTQ1NjAwX0ZJRk9fQ09ORklH
MF9NT0RFX0JZUEFTUykgfA0KICAgICAgICAgRklFTERfUFJFUChJTlZfSUNNNDU2MDBfRklGT19D
T05GSUcwX0ZJRk9fREVQVEhfTUFTSywNCgkJIElOVl9JQ000NTYwMF9GSUZPX0NPTkZJRzBfRklG
T19ERVBUSF9NQVgpOw0KPi4uLg0KPg0KPj4gPmFzbS9ieXRlb3JkZXIuaCA/DQo+PiBZZXMuDQo+
PiBJcyBsaW51eC9ieXRlb3JkZXIvZ2VuZXJpYy5oIE9LPw0KPg0KPk5vLCBhcyBJIHB1dCBpdC4N
Ck9rLCBjbGVhciA6KQ0KDQo+DQo+bGludXgvKg0KPi4uLmJsYW5rIGxpbmUuLi4NCj5hc20vKg0K
Pi4uLmJsYW5rIGxpbmUuLi4NCj5saW51eC9paW8vKg0KPi4uLmJsYW5rIGxpbmUuLi4NCj4NCj4u
Li4NCj4NCj4+ID4+IC0Jc2NvcGVkX2d1YXJkKG11dGV4LCAmc3QtPmxvY2spDQo+PiA+PiArCXNj
b3BlZF9ndWFyZChtdXRleCwgJnN0LT5sb2NrKSB7DQo+PiA+DQo+PiA+QWgsIG5pY2UuIEl0IHNo
b3VsZCBoYXZlIGJlZW4gZG9uZSBpbiB0aGUgZmlyc3QgcGxhY2UgYW5kIHB1dCBhIGNvbW1lbnQg
dG8gdGhhdA0KPj4gPnBhdGNoIHRoYXQgc2NvcGVkX2d1YXJkKCkge30gdXNlZCBzcGVjaWZpY2Fs
bHkgZm9yIGxpbWl0aW5nIGNodXJuIGluIHRoZSBuZXh0DQo+PiA+Y2hhbmdlcy4NCj4+IElmIG9r
IGZvciB5b3UsIEknbGwga2VlcCB0aGF0IGFzIGl0IGlzLg0KPj4gSWYgSSBhZGQgYSBjb21tZW50
IGluIHByZXZpb3VzIHBhdGNoLCBJJ2xsIGFueXdheSBoYXZlIHRvIGRlbGV0ZSBpdCB0aGlzIHBh
dGNoLg0KPg0KPiJDb21tZW50IiBpcyB0byBiZSBhZGRlZCB0byB0aGUgZW1haWwgYW5kIG5vdCB0
aGUgY29kZS4gSXQncyBhIGZyZWUgd29yZHMgdG8NCj50aGUgY292ZXIgbGV0dGVyIGFuZC9vciB0
byB0aGlzIGVtYWlsIGFmdGVyICctLS0nIGxpbmUgYnV0IGJlZm9yZSB0aGUgYWN0dWFsDQo+ZGlm
Zi4NCj4NCj5CdXQge30gc2hvdWxkIGJlIGFkZGVkIGFzIGV2ZW4gaW4gdGhlIGZpcnN0IHBhdGNo
IHRoaXMgaXMgbXVsdGktbGluZSBib2R5Lg0KT2theQ0KPg0KPj4gPj4gKwl9DQo+DQo+LS0gDQo+
V2l0aCBCZXN0IFJlZ2FyZHMsDQo+QW5keSBTaGV2Y2hlbmtvDQo+DQo+DQo+DQo=

