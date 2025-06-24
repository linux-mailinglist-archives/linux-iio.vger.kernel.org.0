Return-Path: <linux-iio+bounces-20942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F99AE60A9
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C61619244FC
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548527AC2F;
	Tue, 24 Jun 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="aQ9l6/Fk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A623C50A;
	Tue, 24 Jun 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756815; cv=fail; b=lDxwnY4I3zbu+F2U5auGCo4iFVS9hDjMiJ4ys5O4TxN5pN1sp/BjrhbSvAPsOEEKK0jRul0hpbOQRA9Wtxsa4WNIcXxnDFKvCK4+diihcASUsEWjpt9SVb9c7E+nuJyk6Krbk/Zc4DTKQnseklCG7Yopc6cpKi77s1akyyBIRno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756815; c=relaxed/simple;
	bh=YDmB8rABuxWSWJr/BkLUdL/3XtTwgR0QCE8H4YiRBzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SxUutOLDOFg6Bvp8iOzryHzW/rz6rSx4VlQ4l6r8/1w5b/+414nol8M84Kse+keKZxNYxaJQ1fKEOf2NTnGyvFyy/keR1MpX6tTeeZWOid6zl22ZheJHVoNc2FWMu3f6TxdQS/ykH5Fcm/yBDhVcVlo3fsI6DSrwXvAJ65EsBgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=aQ9l6/Fk; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8EAix025175;
	Tue, 24 Jun 2025 08:43:45 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012001.outbound.protection.outlook.com [40.107.149.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47dp3nt14v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 08:43:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOvOm2UTAxU83RtfNmovivQNLWWa12fmozktoGQ3HYfK7Tmcum1x8NxccldyOarhSQIxAGDik6yLA9939E2v8vVGtgks/Tq8z9hysa+AKwh9ZW/Epu/cM2i/m6HI8qeS5gcVrOrWKWPCdUv8rpBs5k3sSTlCNmc2bDoJg4un9vGqB6TKInrHQ9rvSElYnWdl7GULnDel8eP7x81oNqwwZzuvgUlUEOOySG2jZ5scCJyUD4doDIiqpJE2Yi3Jr6INhIxG7pNDLHsxV1CPReVVSvlra3TvqlkD8XSKCncuBdbUhZgSLWv8M2rln9JqjqCoDwC66RJkfOIBWW76mBulog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDmB8rABuxWSWJr/BkLUdL/3XtTwgR0QCE8H4YiRBzg=;
 b=bzeMGp0Mfd1rsmGj+i0rsQhpMsLE0ZbKOgYi/9Gx+c7RaoZUccbFR5h2NGtIrUUumisE4olLBaaBUX8fcXpsKEAile2in0GhEuZE4OiVSIYr85ubeTfNr5ggHyX6XW6OTXyqS6tS4DUb/8b1IKyRPQ47XgWNH2JT7fp8gyhBjkVItfNv0VOfvJ/nFh/pkjsYJ3zoTUqVNMGbMRn5Xg7xoky7PDttKJVl4Bjj9BWAu1V0MeJiAqlBQUt9fHbAZv3JdarIgPNUFGqG+pm1Q/7mT2GGw6XTxoscDYUvFfJTAIA89sgXWIgQynodmhoWh34JJnQLzlGC00R/yjc+N1g+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDmB8rABuxWSWJr/BkLUdL/3XtTwgR0QCE8H4YiRBzg=;
 b=aQ9l6/Fk5ncILEfe3kYfUc1uOqCnX5IORm3oN4fNmzWWYtxb9SdhuoW1hWkPRHB13U/aVrTsepqdd662OjYK4SRFMAAYl95NBBk9zmVPP02NMyRN9NS8AkjuJv/njrA/FCs1i6wMC0gSu8Cgm/B1AN43Vl2vq1yabaINKl/5hgpECQQSb5uukd34INmTrdWTUsKqa06tQ56wkW7V0ALWDlsPjpy9BSDbT+i88eBAWndeNDfco2OQ5/TNFZcjpspgZl7sqhTXZjRavZ3JaEvfnzWCKPnaAs1v8s20RSgMVDrcBHVPbaVPCbtO0/md1QibOfEN8RY2G5vZ4816ZFNV8A==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB1474.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 08:43:38 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%6]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:43:37 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure DMA buffers
 at the end
Thread-Topic: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure DMA
 buffers at the end
Thread-Index: AQHb5D4xIaA8BNRtnkaK0s1ff0xtPbQRT6yAgACsDjY=
Date: Tue, 24 Jun 2025 08:43:37 +0000
Message-ID:
 <FR3P281MB175703F651131703019D7295CE78A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
 <20250623-losd-3-inv-icm42600-add-wom-support-v5-1-4b3b33e028fe@tdk.com>
 <CAMknhBEpkWrZdWSrhQS6E1GnENCipf+LxNNSNUyZrm8Gme2f_Q@mail.gmail.com>
In-Reply-To:
 <CAMknhBEpkWrZdWSrhQS6E1GnENCipf+LxNNSNUyZrm8Gme2f_Q@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB1474:EE_
x-ms-office365-filtering-correlation-id: 38933d47-bc1f-48d1-20ce-08ddb2fb3675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGx2QStZQTBycTRrYngzcklHb1ZOZHFRUUpnY3c4a2FkanM2bVhlWWdqWCs0?=
 =?utf-8?B?cHlTYWVMWEt4bTA0K2lWVm8yc0pudUFZaHJxREVxY1dJOTNBeEVPSlZmRTh6?=
 =?utf-8?B?VVU1Nkp4TkRUM1BIdUJ6ejhOakJmQ0t0cVFmNWs2THMrWE9ycnZLWk5QYXY1?=
 =?utf-8?B?clJSbWVqVWU5NVl3T0VHa0IwYVRwcUVScTYxd2x6YzZTYk44UlJyYldNdHNN?=
 =?utf-8?B?ZERXV1lSRENtcFFKZEF2SUdVaWprT3l6amJVeXFPRmRSdkROYktUQmNCMUJn?=
 =?utf-8?B?S0tVRWVDbExoNy9jeWprYkVUeVllVUs0VzdDdmhTWDh2ME5XYVBSd0lZQ1Bh?=
 =?utf-8?B?dERhYU9MRUlRazdkMDI0MmxrWUxhSStJTGF4L01GNHl3VG5WZ1VicXV3bG83?=
 =?utf-8?B?VmtrZ1Bjc3dGeGY1YS9NSzl1eEs5aHFQNTY5S1ZFRlNOM2UwNm9YdUkwcnI5?=
 =?utf-8?B?U1Q4b1JRUXZ1dDF3OHg4TEN3d1pFSmZUakp5RUxIb1R5RTU5S21kSWtOV0Ni?=
 =?utf-8?B?QTFYdlJUdHJDWXdYOXJURHJBcDlMS3NJdTFSVkhHYTVUSGtSQkJXNlhZZ2I1?=
 =?utf-8?B?RklpNjNuODRQYzhia01DREVWMVF6cVQvYUZvR3kxMEQ0NS9ZNjdiWmZMaTZM?=
 =?utf-8?B?MzFJQnpSU1FYeFpYcmhwL09wOVlGVGZxbUthV2x1cjlDTWQ4bElCdWtyZkZp?=
 =?utf-8?B?QnozemZQTU0vR2YzR2FoandxOFNwdzhwcHlkNXRQTnVlSDZsZmpnN0dLSXJw?=
 =?utf-8?B?bUV5T1YyMnNnV2NNMXRBMFdDUG15UGg5Y2QrQkYyMzZZWXA5Wnhld2FETmVO?=
 =?utf-8?B?ajhoeTRXUFVRY05PckhOOC9jbXVydmkxNHhUVFp3MXNXaStCUmpqTUt5cXJU?=
 =?utf-8?B?b1pBWWFNUFM5aHMvYXJ3T3p0eTZOOE5IdWpycVpkWGZydHlkOWhsWnF1b0Zi?=
 =?utf-8?B?Y0IwWmd0dWVRUVF3NTdSNENqVjBZV2o4a1p0WFJDNFZJOTM2VkZEdVpGYnlp?=
 =?utf-8?B?Mi9uWm5ick9CTnZJVFFDZVJIMmJvSnlIekEvaitTQUFFZWtWZ0oyaHNscGRh?=
 =?utf-8?B?MDBORE8vdVdIZGdka01QZHZKalRscmdnZVRsTzVjSGdUcWpOdnBOS1lnWmFV?=
 =?utf-8?B?c05KVTJ0WnozRkxPL1A4WDkzNkoxZ3lhL3E1ak0rZ1FUdzFiNWVLN0tmazh6?=
 =?utf-8?B?Ty9hS1liREp1dm1IMk9RSEtkOVUzN2RsaUVpQU5GMWNwZ1IxRkpjRmlQelND?=
 =?utf-8?B?a3UwVmFrMGdMVnhpeGczMk1VK05SOCtneXk5cnphL1RHU1NVZVhCYmRnVkla?=
 =?utf-8?B?YVpSQnczbmlzdXlxRXVNYkZGTjBkd2RHbFNVeHh4NGVZUmZRdkNCNG5sSm9R?=
 =?utf-8?B?UlhsQnlNSnZpdjRVaHJRZ1dmbTIyZVZ0dm1wWHErRHVWVG54cEsrcXhzT0to?=
 =?utf-8?B?TmdTZVRmSkRXUXFmcStpTmVUUDhYZ0p4UXptMDNKQVNEZy9USVZuQlJCSnJB?=
 =?utf-8?B?V1JHN3psTTRiYWN3eEMrOWt0SnZnUng1L0RSZWFzblZsaVdhWHdFelN2SlhX?=
 =?utf-8?B?MTcvVGhCcldyV0lLdG1CU1IxeEl4RU5LaGp6U0JHcVJYNVJCK3BlSFhka0dT?=
 =?utf-8?B?STlmcWMrZXI0dmZzYTFsWm83SkJOY1k1ZXNXZHYxS2l4eXUxT2hocUxQTitU?=
 =?utf-8?B?OGNnb0Faem5aS0tCZFU0YWRndEpIUUVtaUR3RDg3SUxOMFUvc0I5L2FrbU9J?=
 =?utf-8?B?RjQxZTNqTWVMWEtCOWZMNWNHNk8xbXBKUEhaRit1OWtYakdzazU4TVRYRlVV?=
 =?utf-8?B?UUErcWw3WlhReGF4YUFHb2Nkc3FOZWY1bU9zWXVmZ1QrR1Y0SWlORjZKUjM3?=
 =?utf-8?B?K2xFc1FRa1V5L2RIRnBVS2VtTWhUQ2ZZQmg0eGRFbVBGTzdzS2hldHMzSzUx?=
 =?utf-8?B?UEc5K2YzZjJKTFY3UGxqT2x2c0VoZXBqZWcra3dJNUt0ZG16dEJlTjVXT3V0?=
 =?utf-8?B?YWxHZHYrbmhlbGtteSsvZitNenpSZE01OXV1SWRmV2FIY1d2QnhmYlgxUUVi?=
 =?utf-8?Q?XpXAq9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0xsUy9FZnNvTjErZ0N2WXhKL0hIR3ZQNnR6dCt4K0JnMFUvYkQyZTN0NW5x?=
 =?utf-8?B?RTZlWFUyYjhkUTc5Z1RUQ0V4S1kxU1FMRVBvaURocUZFNmVSOTJWa3M3bG1w?=
 =?utf-8?B?cFZDNjRWZnV2b0FSWUVmdHprRyt6SEwvOFY3QkdiZW1FbUo2S2Y5VDlkcG9n?=
 =?utf-8?B?Q056SG9JeDFDZHdrMTlqaVhEZUlpNkdHVzczYVpPZXkvYzMySFdKU0JzY1I1?=
 =?utf-8?B?Znl5SU9zRnE4VytIanNkNjZSZE5QMit3ZWxGdEpDdnNRVlFlZTVpaE5LakFQ?=
 =?utf-8?B?QkdYcEhDaHlTeXp1VHdZcUUwRUh5cVBSQXZCNG5JMU13TTRpTS9Jckd5UnBz?=
 =?utf-8?B?Wm9mOHlnMkFNVVVsSjRGSU1FUWI3cVlUOU1jTysydVZPM282MXVQenZWOXdq?=
 =?utf-8?B?K25qOVhMMmVVMXgvbnRuWlVQMlNZcU94Q2VrcHhlNVN4ckZURzJxOXpOYUJu?=
 =?utf-8?B?K3RNbmc2WXBmQUxKZ3RiSE9nd3U5QStzRHpScWROS0lVVUFJY2hzSzZvREF6?=
 =?utf-8?B?Y3J5TkgwMDhuTjNSTVJkdnprV0phRlQxV2tNSEcvVXlCdTRnRmNyYUJxemVS?=
 =?utf-8?B?UktrRm43L2M0VWRKOEVvRlpPbm9CQXdBS3BqNU5UVjZKVndKRmsrMERRRk9R?=
 =?utf-8?B?WERrMGdRUVdnemFOTEh5cHlQY1pSMjZzMXVmOUVUOXErSTFNek95UVFHeUhJ?=
 =?utf-8?B?Ulo0NXlGQkU0Vjg1R3VvRVpzdHFvaG1JdEtaM0ZvbW4xQzVDbDBqK0JtMHNZ?=
 =?utf-8?B?ZjVaaUpweHlGWk0vRkNPOTlBa0NDZTRJa1NUN2huK0ZuUDNHYWlEQmZJNXpB?=
 =?utf-8?B?R2xqSFlrL2pacFJYeTBYbXNDbjgrZ1FDYlZ4S21qT0h4Nll1azVuYUtvbFZ2?=
 =?utf-8?B?a2JuaWlUM0hBTzdNd3Q1elBvbURBSTFrQWpIY3JvMGl6cElJV1BXVnlVcTFq?=
 =?utf-8?B?d0trWmVBTjFZY1c4bGFjNkFZTVp0Z0xlTVBxUUkxd01ZYXdpM0JzbVhyOTFW?=
 =?utf-8?B?ODlDZ0MrNDFhVHRGUldZNVB4Z3hlSkdUN1BITHF2bU5wQ1ozQkxORHFVZVRi?=
 =?utf-8?B?bW9QMS9RRVU5RFhWL0JqN3lWTTRFb2RjQzhndUZjTzZuYXBuVlp3bk1TbWt6?=
 =?utf-8?B?amMrd0xGZHZUWUphdElyYUMvdWFPcEFJamFsUGdrRC9Yc2xnK3c0bHNoZ0xR?=
 =?utf-8?B?Q29ZZnQzZnA0WjJ0ek5jRGVPWXQyZWRyYlN2K0xOZUdHV2dnK1hoakZtY2Qz?=
 =?utf-8?B?cm1hYlBPYmJmK3ZTTDZqSnVmeFY0YVZaeVJJNS9WNXRLaFMvMXdVV0xCeWQ0?=
 =?utf-8?B?SEpNTUN6Vmtaams3OGRsV1NUUHNFVWNsYlFoQ1Z5MnpkY2ppRVpqU3NzTktu?=
 =?utf-8?B?WFU3a29CK3FSWExEUHc1cmViTzRPREdTTmkydTR4bVBsUm1uMFp0MlQxMGhW?=
 =?utf-8?B?Y2h5L053MnROdWxmZWZoNG1ldVZxZWpMNjl1dmhyWjZQSDR4THBCWUgvQjZk?=
 =?utf-8?B?VXBpMzBwcWgvZVpWZWIybXpxbkpxWEEvN3hjK1NwLzlvT2lydWlObEgzWEoy?=
 =?utf-8?B?RzRGRVhLbSs2U2Y2aTI3Y2NHbUxtSjZ0aDZwTUhuMDRiOTlyeTQ3bWQ5SEtv?=
 =?utf-8?B?VExmQ2hKNzJ1SlJsdUFmRlhSUHN6VGZDUWczaGRoMmRjbUxTU2tPM1VnaUNo?=
 =?utf-8?B?d0I5bG5xM2RhaVZqRUl6dDBtdDJTWG05KzZVNmtkWjhNTHZJZ3c0Q0F0dEF2?=
 =?utf-8?B?NnZCV2RJRTBQOWhiTFlwOG5nY2Z3UmFINjBMZnZTd2o4dXducU5PYmR3U2RU?=
 =?utf-8?B?bHpYOGo3ZUNpQVd2Qzk1WTgwZ1pVTk81eUd0YW5UMjFRRXlHWHdnbXc1T1Nl?=
 =?utf-8?B?cm8xTmNEckM2VmF0ZzBUTHlhWm94RkxJbkZremdnTzZiUmR6ZmJmSWVLNEFI?=
 =?utf-8?B?SitPbjVsOENQWEIraDVxTENMUHlPU1MvMUdTc3BTVFJMTG9ucVlKYTEvVXdw?=
 =?utf-8?B?VmZGUUtjRHZpdWRHc0dMTTVMcVpMTGZFQmY4ZCthcjlrTjN0MHowbGxqeFZn?=
 =?utf-8?B?QU9tQ0hPWHhpUzJXTlBWTWNKVm9TMnpyVWdkcklLM2RrYXh4V0tSNWJNU0JD?=
 =?utf-8?B?NndESVR4bXRZMVpFemF1SkZCeVhET0xjSk81dGxqYnZHNkY1cFFmdEZ1QUpJ?=
 =?utf-8?B?Ymc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 38933d47-bc1f-48d1-20ce-08ddb2fb3675
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 08:43:37.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQ5usSsV4KsGu2rFRyvXODyQWdF7iqefcDyj+03uhMVXoJ8AHb+kPFSfz0PPnUm8z4jjeQuG6mrbzs6ruTxvyJnX42YhlZkEVUh8SEgKE/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1474
X-Proofpoint-GUID: hQWDzekfGmK095oVIv-mmouSNK9BjVOh
X-Proofpoint-ORIG-GUID: hQWDzekfGmK095oVIv-mmouSNK9BjVOh
X-Authority-Analysis: v=2.4 cv=NLTV+16g c=1 sm=1 tr=0 ts=685a6540 cx=c_pps
 a=ifGnS8FzKiJE9eBes/PZrg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=IpJZQVW2AAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=jaRhVm8neebnxPZV8oUA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA3NCBTYWx0ZWRfX/kJmaY0Whepu
 q/x0+Dt46xiy49RhzIwuW4iuAMey+RLCY4hFyfZmKn3zP7EYRl6wl++aM9R+anQmfvA7t7LyDoF
 WuafsR5GlLRl6WBCY1hdFORSmoC8fQ4xonlWDQyBlZEd1XvorUvHJPw0zVrklaDWx76sdYa6eBo
 BrASoF/8IwRoT2jRv+BVJSbMOxGwSaqtiqyoy6oAUekQEOT6Ox+4jYCIZSQsf5z59x6zHuzQoGi
 31A2LTDW+bS/BQcjQ77xdGglKuQmbG8fjMRFlP5aEhIf1LlbMaq/Rj13WPU2kXGZ0c/GRdjCMmN
 iXeiQMGa9Sjb3gQKX8/kLSEDIeeQtVHFVSGO6+H0Q0eKwdMs0BWeE06jbecuy5sPCsrEl/uSa9D
 gAGkZngFUA6/uy6CH2e0yN2jkb/WeyEAcTsIWwoRHEqifUL0MNgvqpbu1WPrdEGYUM1A+RuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_03,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240074

Pgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+RnJvbTrCoERhdmlk
IExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4KPlNlbnQ6wqBUdWVzZGF5LCBKdW5lIDI0
LCAyMDI1IDAwOjEzCj5UbzrCoEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPEplYW4tQmFwdGlzdGUu
TWFuZXlyb2xAdGRrLmNvbT4KPkNjOsKgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9y
Zz47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsgTnVubyBTw6EgPG51bm8u
c2FAYW5hbG9nLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsgbGludXgt
aWlvQHZnZXIua2VybmVsLm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Cj5TdWJq
ZWN0OsKgUmU6IFtQQVRDSCB2NSAxLzNdIGlpbzogaW11OiBpbnZfaWNtNDI2MDA6IG1vdmUgc3Ry
dWN0dXJlIERNQSBidWZmZXJzIGF0IHRoZSBlbmQKPsKgCj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBh
biBFeHRlcm5hbCBTZW5kZXIKPlRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9y
Z2FuaXphdGlvbi4KPsKgCj5PbiBNb24sIEp1biAyMywgMjAyNSBhdCA2OjU24oCvQU0gSmVhbi1C
YXB0aXN0ZSBNYW5leXJvbCB2aWEgQjQgUmVsYXkKPjxkZXZudWxsK2plYW4tYmFwdGlzdGUubWFu
ZXlyb2wudGRrLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPj4KPj4gRnJvbTogSmVhbi1CYXB0aXN0
ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS5tYW5leXJvbEB0ZGsuY29tPgo+Pgo+PiBNb3ZlIERN
QSBidWZmZXJzIGF0IHRoZSBlbmQgb2YgdGhlIHN0cnVjdHVyZSB0byBhdm9pZCBvdmVyZmxvdwo+
PiBidWdzIHdpdGggdW5leHBlY3RlZCBlZmZlY3QuCj4KPklmIHRoZXJlIGlzIGFuIG92ZXJmbG93
IGJ1Zywgd2Ugc2hvdWxkIGZpeCB0aGF0IHJhdGhlciB0aGFuIGhpZGluZyBpdC4KPgo+SWYgSSBt
aXN1bmRlcnN0b29kIHRoZSBwcm9ibGVtIGFuZCB0aW1lc3RhbXAgYW5kIGZpZm8gc2hvdWxkIG5v
dCBiZSBpbgo+dGhlIERNQSBhbGlnbmVkIGFyZWEgYW5kIHRoZXJlIGlzIGEgcHJvYmxlbSB3aXRo
IERNQSBjYWNoZSB3cml0aW5nCj5vdmVyIHRoZW0sIHRoZW4gSSB0aGluayB3ZSBzaG91bGQgcmV3
b3JkIHRoZSBjb21taXQgbWVzc2FnZS4KPgpIZWxsbyBEYXZpZCwKCnRoaXMgY2hhbmdlIHdhcyBh
c2tlZCBieSBKb25hdGhhbiBzbyB0aGF0IHBvdGVudGlhbCBETUEgb3ZlcmZsb3cgd291bGQgYmUg
bW9yZQplYXNpbHkgY2F1Z2h0IGJ5IHdyaXRpbmcgb3V0c2lkZSBvZiB0aGUgc3RydWN0dXJlIHJh
dGhlciB0aGFuIHdyaXRpbmcgaW5zaWRlCmFuZCBkbyB1bmV4cGVjdGVkIGJlaGF2aW9yLgoKPj4K
Pj4gc3RydWN0IGludl9pY200MjYwMF9maWZvIGhhcyBhIERNQSBidWZmZXIgYXQgdGhlIGVuZC4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0
ZS5tYW5leXJvbEB0ZGsuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2
MDAvaW52X2ljbTQyNjAwLmggfCA4ICsrKystLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
aW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDAuaCBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNt
NDI2MDAvaW52X2ljbTQyNjAwLmgKPj4gaW5kZXggNTVlZDFkZGFhOGNiNWRkNDEwZDE3ZGIzODY2
ZmEwZjIyZjE4ZTlkMi4uOWIyY2NlMTcyNjcwYzU1MTNmMThkNTk3OWE1ZmY1NjNlOWFmNGNiMyAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDAu
aAo+PiArKysgYi9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMC5oCj4+
IEBAIC0xNDgsOSArMTQ4LDkgQEAgc3RydWN0IGludl9pY200MjYwMF9zdXNwZW5kZWQgewo+PiAg
ICogIEBzdXNwZW5kZWQ6ICAgICAgICAgICAgICAgIHN1c3BlbmRlZCBzZW5zb3JzIGNvbmZpZ3Vy
YXRpb24uCj4+ICAgKiAgQGluZGlvX2d5cm86ICAgICAgIGd5cm9zY29wZSBJSU8gZGV2aWNlLgo+
PiAgICogIEBpbmRpb19hY2NlbDogICAgICBhY2NlbGVyb21ldGVyIElJTyBkZXZpY2UuCj4+IC0g
KiAgQGJ1ZmZlcjogICAgICAgICAgIGRhdGEgdHJhbnNmZXIgYnVmZmVyIGFsaWduZWQgZm9yIERN
QS4KPj4gLSAqICBAZmlmbzogICAgICAgICAgICAgRklGTyBtYW5hZ2VtZW50IHN0cnVjdHVyZS4K
Pj4gICAqICBAdGltZXN0YW1wOiAgICAgICAgICAgICAgICBpbnRlcnJ1cHQgdGltZXN0YW1wcy4K
Pj4gKyAqICBAZmlmbzogICAgICAgICAgICAgRklGTyBtYW5hZ2VtZW50IHN0cnVjdHVyZS4KPj4g
KyAqICBAYnVmZmVyOiAgICAgICAgICAgZGF0YSB0cmFuc2ZlciBidWZmZXIgYWxpZ25lZCBmb3Ig
RE1BLgo+PiAgICovCj4+ICBzdHJ1Y3QgaW52X2ljbTQyNjAwX3N0YXRlIHsKPj4gICAgICAgICBz
dHJ1Y3QgbXV0ZXggbG9jazsKPj4gQEAgLTE2NCwxMiArMTY0LDEyIEBAIHN0cnVjdCBpbnZfaWNt
NDI2MDBfc3RhdGUgewo+PiAgICAgICAgIHN0cnVjdCBpbnZfaWNtNDI2MDBfc3VzcGVuZGVkIHN1
c3BlbmRlZDsKPj4gICAgICAgICBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZ3lybzsKPj4gICAgICAg
ICBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fYWNjZWw7Cj4+IC0gICAgICAgdTggYnVmZmVyWzJdIF9f
YWxpZ25lZChJSU9fRE1BX01JTkFMSUdOKTsKPj4gLSAgICAgICBzdHJ1Y3QgaW52X2ljbTQyNjAw
X2ZpZm8gZmlmbzsKPj4gICAgICAgICBzdHJ1Y3Qgewo+PiAgICAgICAgICAgICAgICAgczY0IGd5
cm87Cj4+ICAgICAgICAgICAgICAgICBzNjQgYWNjZWw7Cj4+ICAgICAgICAgfSB0aW1lc3RhbXA7
Cj4+ICsgICAgICAgc3RydWN0IGludl9pY200MjYwMF9maWZvIGZpZm87Cj4KPkkgZGlkbid0IGxv
b2sgYXQgaG93IHRoZSBkcml2ZXJzIHVzZSB0aW1lc3RhbXAgYW5kIGZpZm8sIGJ1dCBpZiB0aGV5
Cj5hcmUgcGFzc2VkIGFzIGEgYnVmZmVyIHRvIFNQSSwgdGhlbiB0aGV5IG5lZWQgdG8gc3RheSBp
biB0aGUgRE1BCj5hbGlnbmVkIGFyZWEgb2YgdGhlIHN0cnVjdC4KCnN0cnVjdCBpbnZfaWNtNDI2
MDBfZmlmbyBoYXMgYSBidWZmZXIgYXQgaXRzIGVuZCB0aGF0IGlzIHBhc3NlZCB0byBTUEkuClNh
bWUgdGhpbmdzIGZvciBidWZmZXIgYmVsb3cuIFRoYXQncyB3aHkgYm90aCBidWZmZXJzIGFyZSBE
TUEKYWxpZ25lZC4KCj4KPj4gKyAgICAgICB1OCBidWZmZXJbMl0gX19hbGlnbmVkKElJT19ETUFf
TUlOQUxJR04pOwo+PiAgfTsKPj4KPj4KPj4KPj4gLS0KPj4gMi40OS4wCj4+Cj4+Cj4KClRoYW5r
cywKSkI=

