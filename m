Return-Path: <linux-iio+bounces-22965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399EFB2BC4F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 10:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C8C1BA5693
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4767531576F;
	Tue, 19 Aug 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b="VBAg3JOJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00015a02.pphosted.com (mx0a-00015a02.pphosted.com [205.220.166.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305E1F0E2E
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593929; cv=none; b=NwnZHmzkBYdOI3c9j5G+D3M+qGRPIgCAgNdP6BbXbR7FPO9m6rgZQ166qTdByQ3HgJJDi6UWRM/HbLqSkoc85wq72Ac/hObIQfkGTpCIfRJB4RuDDkQ64R7CkQdsp9nt1R7GVgueG075mc61pIz0neCr0F7VMvNOqGqPJc3ztSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593929; c=relaxed/simple;
	bh=Lf82Tf6D2vSjlRRvBexcKCQeXAj4wos5FNpmGMeHql0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PSwstjwwGjqkoHkS9vEQpvGPUY+tQvGJ5MsbmSzgNe3MyZ4c+qZ3pocZH4f3cn3p0lUrYbhA0hgOYHjDzj+U+0OwmpJMXR6VhmouHZDy9jSSUz3lIlkD7zytKvTZx3O9AO06iGr0SBcWYsznXFTJu31SLCpYiEZ9fbvDvW8Gd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com; spf=pass smtp.mailfrom=belden.com; dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b=VBAg3JOJ; arc=none smtp.client-ip=205.220.166.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=belden.com
Received: from pps.filterd (m0264209.ppops.net [127.0.0.1])
	by mx0a-00015a02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J71URU032302;
	Tue, 19 Aug 2025 04:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=podpps1; bh=fF
	nWbBDXgGSJqvys9MRULAv2VKAkt5ieM/8qhCXuiOk=; b=VBAg3JOJbRms7IVQTZ
	TKamCa3Ut7WNk7sJIqKBo4HHSMZcgvnGRlol85OzFdyLpsTQYPUfvegfIPELNpWb
	sqe7F8/VtcXsfsLJbpE2N6emUH2H8tCqiRm69bKB8MqwT2fluBMC2lgffyso2b30
	DWeYe2RIDksp62BCyg1daTiB1y4Q/84AQ9u9fQMxffn8eVVuQyNH6ey57C5k6ezx
	+ntbdSCCkXNL+OitWN3K6+o/tOHeoFc6AZjjm3y8RWznwAga25E/jTAd40SUMTAB
	i5Zr+EEa6Iehcukk+9N9TXcWyOjEDe6vXz3FNepS3s3LVpcUVIaIueBd+by6sBNU
	/Snw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2094.outbound.protection.outlook.com [40.107.223.94])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 48jpaamykp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 04:58:43 -0400 (EDT)
Received: from SA1PR18MB5692.namprd18.prod.outlook.com (2603:10b6:806:3a8::9)
 by LV3PR18MB5662.namprd18.prod.outlook.com (2603:10b6:408:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 08:57:40 +0000
Received: from SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::1b82:7cf8:55cf:35e3]) by SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::1b82:7cf8:55cf:35e3%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:57:40 +0000
From: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "marius.cristea@microchip.com" <marius.cristea@microchip.com>,
        Rene Straub
	<Rene.Straub@belden.com>
Subject: RE: [PATCH] iio/adc/pac1934: fix channel disable configuration
Thread-Topic: [PATCH] iio/adc/pac1934: fix channel disable configuration
Thread-Index: AQHcCsEkPwmfwU9r6EyB33LmET6FlLRlUhgAgAL3x1CAAHNrgIAA+XoA
Date: Tue, 19 Aug 2025 08:57:40 +0000
Message-ID:
 <SA1PR18MB5692ACF39BF4B1E3BC32D9549930A@SA1PR18MB5692.namprd18.prod.outlook.com>
References: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
	<20250816144352.53e61562@jic23-huawei>
	<SA1PR18MB5692ED633F65FF2361A30AC59931A@SA1PR18MB5692.namprd18.prod.outlook.com>
 <20250818185619.289f1ab3@jic23-huawei>
In-Reply-To: <20250818185619.289f1ab3@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB5692:EE_|LV3PR18MB5662:EE_
x-ms-office365-filtering-correlation-id: 2ecae648-71c5-473d-842e-08dddefe7400
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFRsdk9TREE5Rm1PaDduVDh5RzBXMkZLbFNIVm5wU0h4T0hQZmVJUHFJeWpJ?=
 =?utf-8?B?bU1iYkR0WkNjT29ZM2xFaTV4QldNT3dua0Y5Skg4TkNQWU1xOTNqYVRMdlZn?=
 =?utf-8?B?NWhtbHVINnNKNUFreEV0VmkvZUU5NHlnUkVNdWsxUUcyemdESDNTZDh6Nm1I?=
 =?utf-8?B?SFFYaW9rT2FuYzgxRDkxL0M4a3UrMlpHcW1MRDZ3OHZEanV2Ync1T0JtZlNh?=
 =?utf-8?B?ZG5hdjFIRG9qYzdlVjBFM3dKVTRnajB1SW9ycVIvWFJQRHBxN0VJTlJsTHp5?=
 =?utf-8?B?bGR0bmVSa1pOenJad2RtaE1uT3AwR2ZnSklpY0tTcUJMOFpkL3k5ZS84WTRY?=
 =?utf-8?B?Ujl5WkljOFE0WXk0NTBKMkJGbDVHcEN0c0E3TGw2M2tSeGx2VVFSZjk3c2Nx?=
 =?utf-8?B?dVpOdXZ5K0oyU2M3QmxVWFFIdi9qUnU5UklaRTZHOG1GNE9SSFpZdTR1Z0Zy?=
 =?utf-8?B?Z3ljSlhabSt4OWdLaUtkUHRJdnZVSTM1eWpHZjhOSngyN3NSeEIxdmpBTHR2?=
 =?utf-8?B?VDcwdDJSdmtBWWcrWE5qOVpIWE1ZM0NVM3FpTm81eTZTYnJXaTlxWHZpOHdZ?=
 =?utf-8?B?ZkxLSU1OQ3pORGplMEdjVzJRZnQ3QjFQQzFqejNqL2VUMTU5NmViV0xKQWo1?=
 =?utf-8?B?b3BWQ2I2U0RZTURnYXdCUDY1dnhFam1DV0p4K29xOGwzZW9Wa09ZSW94cVRF?=
 =?utf-8?B?SnpSQUlHdCs4dUJFQ09wRkt1R1FJRjJ4L0haQllJd0JEdS9ONkR1NlBuUWtu?=
 =?utf-8?B?TUt3OGE5bWRodGF5c1A5RzdtbVRWVEhTcC9oUzdXd3h2UE11b21ucVFDV2Qx?=
 =?utf-8?B?UWxNekU0eWYyM3lmWjFaU21rYXpuUmRKdmhrM0pkM1Vtay9hZE1yWFdoRUNU?=
 =?utf-8?B?M0VxaXI0UXpYeG4xOVNNa3pKZ0JhNjlUZlRCcjZxZHFZTU9aaGdYY1B2UDQ1?=
 =?utf-8?B?aXBYaGNmYVhsMXovYVZWSTk0RHVpdkNnOXorbUk4ZkV0VzVNU2JkdkNwVytB?=
 =?utf-8?B?eDZ1RWdabndkVW9rM3EzbW1HVU5kQkhlaE9yd1Q3TVMwNnJzbGRNU2ZNV2hI?=
 =?utf-8?B?dCt0WEllKzloN0FPYkpMMVdNTThXZzlIMEtnWEplVDFiKzhIaFRlVmx6OTd6?=
 =?utf-8?B?aUV2SFdoS0Qvb2VnRkswZE55ZU9LRHpWQ0ltd25TSGt2dVo4cXdKTE1uMEIr?=
 =?utf-8?B?a2UzNGcxVS8zd1dqeWVsbTdyUmRseTM0YzJQNkU1UWl4U2plU3p6d2JlUlBB?=
 =?utf-8?B?VGtOTithNEdEUVQ0WkxRYWp6a2xCT2h3M0hJUkppanFzaGJ6UFRIbDU4NUha?=
 =?utf-8?B?S1RaRnZEdHY4Vmp3M0pHOExHQ2ZocDAzVllDTEJhalFxYTBuOEtJNU4rYTVw?=
 =?utf-8?B?M3pRV2pqbUttWmdxSVRlVUhLOFJaQXAxWW1UdXQyVndGYVNMNEFwN0JLZ2h4?=
 =?utf-8?B?TUFVS3NnTGNlVWQ3NFczZ3ZIM1FDTzFldzhONXU2SWhydll5K3Y4K212T2hX?=
 =?utf-8?B?YXUzeXlrQjJjcTlYQW9pUG1mWXhCNEF5VU43QTFtRno5NXJPUVRHNjByL1di?=
 =?utf-8?B?b1pGc1AxTHJzeWJYdEtDYklEb0FJTjdHZ05LZEp2ditlaDVVQStmVzQ0dlF3?=
 =?utf-8?B?VVNnSkg1UmN5R0tWaGtidS9ocVJpUmpNdTNuMmZZbXZzMXBNcG9OYkVZNHEw?=
 =?utf-8?B?bGtEd1hDekFFbXhTZVo1VzVKSlNjMnlKT1NBKytFVndYVjR5LzVPYWwrNkNa?=
 =?utf-8?B?aUVTcjd0bUNjT3dWTEpjN0RpOWhkL0hKdDNoSUZGelJBZXVJOFJoaG41Vldl?=
 =?utf-8?B?anhBNGlFY3ViMkxVd1kxckZ6Sm5IZlYxYTlETjNHTk9wK2p4RmxlWjZqTjhI?=
 =?utf-8?B?bjhnMzdKYnBLVGN6d1NQMUp6bGRyUUQrSmtHZ2dKa29hZm9uYXlnazhZVjNR?=
 =?utf-8?Q?3gQjjc+FkPo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB5692.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1pzM0RwRjkxRUxQUXNQVzVzbGlMcVVxT3ZHU1ZiQnYrZmZZSzBNVjdtUTFy?=
 =?utf-8?B?S244Rk9wcE9CckJyV1ppa2lzeTJlQXp3Q3lTdGNBM1JZeFU0Q0poa25aOXFC?=
 =?utf-8?B?VWFqSGtEOElqVk9xU0VsWU9mcllIdmtZbCtXemdRNDRSSTN4RlVOZWdwajVl?=
 =?utf-8?B?R3VJc3JXcU4zZnl0SHAxZVgwL0M2N1hFejVnSElqZExHbmZ4RDdkMWJvOVFL?=
 =?utf-8?B?Z1B2RVllcDVFMG9PTHdKSGVCRjVHdXdlODFLa25MTmRKdEwzYzhOSzBoczhQ?=
 =?utf-8?B?cExLRmNVd1cybUxRWmQyQVBhbkw0V29odlMyRWNVRkUzN3R5dHZ6UmtBUGJ0?=
 =?utf-8?B?RzRvaytPbDJpUDQwSDU1TnhrMDZVSWs2YXN2SnZ2bElyUjEwRDk1aXpncXRX?=
 =?utf-8?B?MVpTbFpoWmt5Y3dtNXFhNzU2Wmh2elVSbzNWbi9rbmY2a2RwQmNmdm5pb0xR?=
 =?utf-8?B?dEFIbGgzTGNkOGdNckEraTI4eThoZjNCSHBBb0ZJc1BSdjFSb2RTR1N6cFNh?=
 =?utf-8?B?Y2NtRkVXWUs5NGEwcFd5OHZ6ZDdhT04xcFBrMTUxZWpxTmFPc0p1dkNVbFFr?=
 =?utf-8?B?eGlRWmZEUFlvWjYwTTZxNkNGMjdPdG9qWGdEQ2xJL2V2TmYvdjlxU1cwSGtx?=
 =?utf-8?B?Mm1GVXJwOEVVNEFycXZ5K1BOcHo5TGR6blVrUGtGV2w0MmpQalJadGh6bWZi?=
 =?utf-8?B?L1J0TnlETTJEZXYyVmFMS01MUHB5ajFKUktRNXFlTkFCU0RwTzFQcFBsQmx4?=
 =?utf-8?B?S3ZjVU9hTmxvSlBWUXRxRWdIUEkzRXFobU5qYlFiQ0FiQ0lRM2JOL01xcVRZ?=
 =?utf-8?B?ZUhmbHVTa0hpd2R0aG9sSnMvWVRjY2N4MzNINFFlMVRzNzRoTmxQR2JEd2hW?=
 =?utf-8?B?REdmUFlrb2owYXJ3ckJLOW5GekdIakNJUERmUGIyN25nSTlxM0FCa1lIcXRR?=
 =?utf-8?B?WGU5UGJFVGtLTWw0a2dmY1VqMUxQcHlJVkVSZkg2N0ljSHdPZk9mRXpZYTQx?=
 =?utf-8?B?NmlKdWlqUjJLNDVPSUZTNkhFd0pOQmtQMlpvZWN2d1FacU9EbVREOWZvSXNF?=
 =?utf-8?B?a0hBVmF4Z2p6T3NveEVqKzRsaDlVbExDcDF1WFNjV1NVd0puU2RkbFZ3MkpR?=
 =?utf-8?B?TkcybC9hTFN6R2RRWWxwekVEQUpFTXA1THJlOHZBLzFOR3dZcWt1Q2t4UHBR?=
 =?utf-8?B?NnNSR1E5VkNCT1pNcUpiWEdQK2hyTG91WHNqaHlDZEJ3bzFCMHFBRDF2YjRw?=
 =?utf-8?B?ZHZveVYrNFZDY3hyNHhiYTNJU3owL2NoYTV0d1dGSWZ3K2FFbWllRDVreXQz?=
 =?utf-8?B?VjBqYmM2Y2JOY1NLSXhLQnF5YXZiNklSQzY1TFkzZUNnOXdKYWNDSkVyYmpX?=
 =?utf-8?B?VzdsaTVtUFpnRFR5NjdoOFRpUmd4RENmQ3YzZWVRVlhDT3hGL0Q5T1pLUGc3?=
 =?utf-8?B?RjhYZmQ0SkF0SDBCTWgyTlo3UTROQU1iUTl6Y2dYUER0TGtVeWR0b0NMcW5x?=
 =?utf-8?B?elhFSWNQakVORFJtK3BNdzg2RGRWSXlxUWdFRWhROURzaEI3cDg3YW5lNEJU?=
 =?utf-8?B?bDIxOVliUjAzemZ4aUloVjVLcGxSMWI2TUlwWE10SE4xRGx4a2J6QVEvM21M?=
 =?utf-8?B?TGx1WXBnNXJHOEc1MW94QWVQK01RY3R0RC8rbWw0RmZVMWY0c2F3WUFISnY2?=
 =?utf-8?B?dlBnTjhBUTNrd1FDUndYYWNmOVQ2TXIxd3RrbERwdEQzdXUwNGpUQzMxUFZj?=
 =?utf-8?B?L0VFa0lmOEthTWN0eEtqT3hEaTdHbEY5dE1FOURXVHBZUFBXeFFNNEdVQSta?=
 =?utf-8?B?WXJ1SVV0QkR3SXZtYjM5YWtHdzNteXQxMlVLUWpYeStCZlJwaHQ2RTRBaGlN?=
 =?utf-8?B?MFplMzBYMDJ3OTRpWnpjMXJGcEkrK3YrSHBEcnFQc1RFV1o4ZWZMek8veHpn?=
 =?utf-8?B?dVFaTFpYR05TMzJQd1ZNa0JjalpNamdGOVlpU1hmNWlBOWFtaXRjU0FWblds?=
 =?utf-8?B?UXNDbktzbEowMGY2Z3R1b2ROMktVa0hsZGNlWGJXamVpazBNVE4yUUUvMTVv?=
 =?utf-8?B?NmNFS0t4a1NHWmR6Q2Uxa0o4RkxiUW1ZaGt5cUZuQnNpRmFLUDhHN0t0ZmNO?=
 =?utf-8?B?YWdsdkJzMTQveGdpb0l1b1NLeVpDdkpWMS9Iems4S3Zid284NUhpTWFrZ1p4?=
 =?utf-8?B?UHc9PQ==?=
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P+XaARidso4x3aiJUbh+do/O8DfcmDNL4eZPUWpl80mkKdqmoBj2v/BFu4guxk6rRMIEtbJUX/8SjsATGITEGsVaxOrxS2Bl82VNFKm8GycLxE2woeKgmOYihFD3HDGwk5ZTI/V/ES0kaNd9y9YEiqi9bolyn2rlABbnuQrbuClfA41HPlK9OLK4KSBQMwU6i3qonLFhv1/eVtscYyYPGf1/ZIBIbdIIHQxutMqJdMQK72BkE6pSTYod52gokVd6UC4XQr+GS2QHr4TKew6F/UZGEucnC92qVslncBdwNck5lz2SBex3S2l2xgAQdzOAFgCnME6RWJK6ne/cK6X4s84Kwc+UfXnIlZCJSsIwR55LLjozLOzKKyxzA0sMP0kNCjEc8ykx+3A+YHKIW5u/emT0m7AyYGH3BZhNtsC8mNyet+yz57QN9AmWVmo3x5yVbLiHp15tXjreSjyshlguZ2i1tZbVaqgppzJ1nVdzDME+9JkQ/RcgKC0XmmFJdOUKm6OJiEbDS0LK1kUmnL7rWp1R7d3RxF5yfAoD/C3clm9YHlwfozRX9zBs0NHAvWOxfHYAhZ676gQEc/1Ez/OMgWu9axYVtJEV27ydTnDQg4eqyAj1OE6IT+/hclF3VlZpm39irO6/O2/i8Ds2YihvCA==
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB5692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecae648-71c5-473d-842e-08dddefe7400
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 08:57:40.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRyOg4PufMOluk7kgY2HXZedI7q29ZyrvPM5nodKbc5txvX4BvHiGQZ4T6RZHyDNfkHqq0MDwr/qmA2hK6TtTIu6hX97N8DGuSDpjPOh7mTTJwTkITDiMzkOsJ0BwN7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5662
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: f2bmq2vXdqNzXg9D3g0wXPNPSE2Bstqm
X-Proofpoint-ORIG-GUID: f2bmq2vXdqNzXg9D3g0wXPNPSE2Bstqm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA4MiBTYWx0ZWRfX4xHoYfQ6DZtZ
 GqwqA/yuOpg1L/36A10T7WsYYaQKG9wHVajNyUuJJT7CgOBB2bKEb4pp5yAVJVzBISWIYccpqbZ
 FcECEYzfStQD45YSaieQrGYiNvc9mi8USi8BA+oSJrVZkoyYB4TDrK3gBaWxeiME2Ub741nglpE
 vSkTh5oKf5zbjIZ0QPR40qud9lS9H7vlg/lVgyeBrAB3OdLfJ6Nf7OQqvI/Vspflfz6Tov2Rpud
 rCh0wJL7s4tMZ1zVDEzf7PpDJ/ZqZ4Haa4cI05Skb/OCH4DvtJtpDBCaZLCwtrSWd1RDHgrFJPV
 Z0TERqavB35+ckPYV1DVgaxO/Yz3PE2+Ys9D/oX3nbmTU2pXYRfjuvVuiWccGQ4Fdz276I9SuDN
 SQbe3p0O
X-Authority-Analysis: v=2.4 cv=I7hlRMgg c=1 sm=1 tr=0 ts=68a43cc4 cx=c_pps
 a=fxbcSSzt6U1YglO7xsTYVg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=mCf63rc527wA:10 a=RpNjiQI2AAAA:8 a=WDlp8lUfAAAA:8
 a=VwQbUJbxAAAA:8 a=XYAwZIGsAAAA:8 a=OEGPpH_TtYWBAnkCRVwA:9 a=PRpDppDLrCsA:10
 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160082
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam
Content-Type: text/plain; charset="utf-8"

Hi Jonathan,

Both Rene and I was investigating the problem in first place, I come with t=
he patch afterwards.
So, the sign would be then:

Suggested-by: Rene Straub <mailto:rene.straub@belden.com>
Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>

Thanks for following up!

From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Monday, August 18, 2025 7:56 PM
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Cc: linux-iio@vger.kernel.org; marius.cristea@microchip.com; Rene Straub <R=
ene.Straub@belden.com>
Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration

On Mon, 18 Aug 2025 11:=E2=80=8A08:=E2=80=8A33 +0000 Aleksandar Gerasimovsk=
i <Aleksandar.=E2=80=8AGerasimovski@=E2=80=8Abelden.=E2=80=8Acom> wrote: > =
Hi Jonathan, and sorry for the previous non-plain text message: > > Fixes: =
0fb528c8255b (iio: adc: adding support for PAC193x)

On Mon, 18 Aug 2025 11:08:33 +0000
Aleksandar Gerasimovski <mailto:Aleksandar.Gerasimovski@belden.com> wrote:

> Hi Jonathan, and sorry for the previous non-plain text message:
>=20
> Fixes: 0fb528c8255b (iio: adc: adding support for PAC193x)
Thanks.  I noticed one more thing when I was about to queue this up..

>=20
> Regards,
> Aleksandar
>=20
> From: Jonathan Cameron <mailto:jic23@kernel.org>=20
> Sent: Saturday, August 16, 2025 3:44 PM
> To: Aleksandar Gerasimovski <mailto:Aleksandar.Gerasimovski@belden.com>
> Cc: mailto:linux-iio@vger.kernel.org; mailto:marius.cristea@microchip.com=
; Rene Straub <mailto:Rene.Straub@belden.com>
> Subject: Re: [PATCH] iio/adc/pac1934: fix channel disable configuration
>=20
> On Mon, 11 Aug 2025 13:=E2=80=8A09:=E2=80=8A04 +0000 Aleksandar Gerasimov=
ski <aleksandar.=E2=80=8Agerasimovski@=E2=80=8Abelden.=E2=80=8Acom> wrote: =
> There are two problems with the chip configuration in this driver: > - Fi=
rst, is that writing 12 bytes (ARRAY_SIZE(regs)) would
>=20
> On Mon, 11 Aug 2025 13:09:04 +0000
> Aleksandar Gerasimovski <mailto:aleksandar.gerasimovski@belden.com> wrote:
>=20
> > There are two problems with the chip configuration in this driver:
> > - First, is that writing 12 bytes (ARRAY_SIZE(regs)) would anyhow
> >   lead to a config overflow due to HW auto increment implementation
> >   in the chip.
> > - Second, the i2c_smbus_write_block_data write ends up in writing
> >   unexpected value to the channel_dis register, this is because
> >   the smbus size that is 0x03 in this case gets written to the
> >   register. The PAC1931/2/3/4 data sheet does not really specify
> >   that block write is indeed supported.
> >=20
> > This problem is probably not visible on PAC1934 version where all
> > channels are used as the chip is properly configured by luck,
> > but in our case whenusing PAC1931 this leads to nonfunctional device.
> >=20
> > Signed-off-by: Rene Straub <mailto:rene.straub@belden.com>
This SoB chain doesn't comply with the normal requirements.
Given the author is Aleksandar (no From in the commit, so it's the email se=
nder)
my guess is either

a) Rene wrote the patch and the author of the commit accidentally got chang=
ed)
b) Rene and Aleksandar both wrote the patch in which case it is missing
Co-developed-by: Rene Straub <mailto:rene.straub@belden.com>
here

I can fix it up if you confirm if it was a or b or something else

Thanks,

Jonathan

> > Signed-off-by: Aleksandar Gerasimovski <mailto:aleksandar.gerasimovski@=
belden.com> =20
>=20
> Hi, Thanks for the patch.
>=20
> Needs a fixes tag so we know how far to back port it.
> You can just reply with one to this thread rather than sending a new
> version.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/adc/pac1934.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> > index 09fe88eb3fb0..2e442e46f679 100644
> > --- a/drivers/iio/adc/pac1934.c
> > +++ b/drivers/iio/adc/pac1934.c
> > @@ -88,6 +88,7 @@
> >  #define PAC1934_VPOWER_3_ADDR			0x19
> >  #define PAC1934_VPOWER_4_ADDR			0x1A
> >  #define PAC1934_REFRESH_V_REG_ADDR		0x1F
> > +#define PAC1934_SLOW_REG_ADDR			0x20
> >  #define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
> >  #define PAC1934_PID_REG_ADDR			0xFD
> >  #define PAC1934_MID_REG_ADDR			0xFE
> > @@ -1265,8 +1266,23 @@ static int pac1934_chip_configure(struct pac1934=
_chip_info *info)
> >  	/* no SLOW triggered REFRESH, clear POR */
> >  	regs[PAC1934_SLOW_REG_OFF] =3D 0;
> > =20
> > -	ret =3D  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_AD=
DR,
> > -					  ARRAY_SIZE(regs), (u8 *)regs);
> > +	/*
> > +	 * Write the three bytes sequentially, as the device does not support
> > +	 * block write.
> > +	 */
> > +	ret =3D i2c_smbus_write_byte_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
> > +					regs[PAC1934_CHANNEL_DIS_REG_OFF]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D i2c_smbus_write_byte_data(client,
> > +					PAC1934_CTRL_STAT_REGS_ADDR + PAC1934_NEG_PWR_REG_OFF,
> > +					regs[PAC1934_NEG_PWR_REG_OFF]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D i2c_smbus_write_byte_data(client, PAC1934_SLOW_REG_ADDR,
> > +					regs[PAC1934_SLOW_REG_OFF]);
> >  	if (ret)
> >  		return ret;
> >   =20
>=20
> **********************************************************************
> DISCLAIMER:
> Privileged and/or Confidential information may be contained in this messa=
ge. If you are not the addressee of this message, you may not copy, use or =
deliver this message to anyone. In such event, you should destroy the messa=
ge and kindly notify the sender by reply e-mail. It is understood that opin=
ions or conclusions that do not relate to the official business of the comp=
any are neither given nor endorsed by the company. Thank You.

**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message=
. If you are not the addressee of this message, you may not copy, use or de=
liver this message to anyone. In such event, you should destroy the message=
 and kindly notify the sender by reply e-mail. It is understood that opinio=
ns or conclusions that do not relate to the official business of the compan=
y are neither given nor endorsed by the company. Thank You.

