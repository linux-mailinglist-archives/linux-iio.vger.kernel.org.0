Return-Path: <linux-iio+bounces-22127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF5B14D54
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 14:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56E718A2B69
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B016528EA4F;
	Tue, 29 Jul 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2udMbF1u"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96013C3F6;
	Tue, 29 Jul 2025 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790585; cv=fail; b=DNQSdQ9ImL8ldWBAMSilYgcyCGtvYCwdZqpXxlc33Fot6UoHL0os3EskWmqrABiMSJzcyNLosByuzW1iTwANCS5et+1333h7bF4m54WqacAhwUjnhGZxgZpPlsT4VrUwQrAnLsEY7+aIHdSK5wVMinDDy/rUjb+Mg78BRkI0IS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790585; c=relaxed/simple;
	bh=ePhZnOyUochwG3J03pG8jcs2Oy6DIx8EoAI5q0N2024=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nMoqPC8VV+0jtlKgP+FMhO1LHmtxR5A06svudZZ1E6fa733PQe4rW+mhRI2/HjD36IBeUBFd0fr5Ewtaoi8GzxnaAWyhHRHDcDVk3LzGRtTVCYNAQB8KH+YUPyfSPj9eR/FofO/0bviqdRFNHu5VlsO+9BnCpjxwIGONzNbRl48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2udMbF1u; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do9tkrWWrF93D4Xx2YMxmyHcCBU8s7QIT0G4CAquL5Fm35R/PXQ7qD3N9ufUgap7WIF7LZLC0jvd4Hpqxq9eGzEZw+t5H4vWqGfJpCI4IaG9F0OBEgPzKEfiQgtUweznJiP495nSlXb85rN/UM3SRmpFJDfnuV+y4plx8BiWdl+Wg/6AE0Ss7KXzlQbnY+t2ljaW4ueHOWuBuQhd3SAP/VWwoAqIKkxahULC/hEZQD0ZuOTN0EX287P8sn7qLBf/kHALAR13IlB2XyDd4N2HTDAYIkKgZMROUuxcAHCxYbpUYFtqzxEJ2dqzwJBaSyi0Qf2uTewrdiUSZSB19pUT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePhZnOyUochwG3J03pG8jcs2Oy6DIx8EoAI5q0N2024=;
 b=MCrOXRgLx2iy+HcSNWw6Bx6kzfhiPXsbr9czN/LDxoepwl49FHL5zRD7sY6jS/Qq6YyUaUIm20CTv67xpG+eJcpwUYFphYDKNsz7iU1WgmzbKpBi+s1lavgEvT7lF1H0eqTg8sKvvIGc7DI8Xh1/ek8Q1VOZlbGI7sMRDx8nwXEfggUcvNTsaUyGNOLj3yrfIVHQ9TbnTwxaaYNs0K+shqUN/fIyIZRJqMHizX/IpNJ44Kuw9ybz8FMklZhZJQhvrMHk9plbT2M3RCGci81FwmiCdy2jRgo2LhzaywidfsOvJGLN1Q+ELzjkMk8PJuy+apkwUv4BzNKr5tzQmW+f0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePhZnOyUochwG3J03pG8jcs2Oy6DIx8EoAI5q0N2024=;
 b=2udMbF1uxB4LDmTwHPoElvM7WhY9+Nvu1OW08ZxdVEYp7ZF/lB+Xt3TIFTFGM4/Vko8JD92RlnaetozNssTzWTlIDPqhm68grO/+T1LTpRB3WlA+9gLq3dl2B1D9GVGPPZyXNIsvOSi9wgo2UxgS7K+5drtItufxABCzUFbbkKA=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Tue, 29 Jul
 2025 12:02:56 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 12:02:56 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Jorge Marques <gastmaier@gmail.com>
CC: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pandey,
 Radhey Shyam" <radhey.shyam.pandey@amd.com>, "Goud, Srinivas"
	<srinivas.goud@amd.com>, "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Topic: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Index: AQHb+i+8xK2s1GBMXUK4mOoG9AwzB7Q8c6QAgACdMwCAAK9QQIAAB8qAgAmwZzA=
Date: Tue, 29 Jul 2025 12:02:56 +0000
Message-ID:
 <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
In-Reply-To: <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: gastmaier@gmail.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-28T11:54:23.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|SA5PPF50009C446:EE_
x-ms-office365-filtering-correlation-id: 252a0d91-cee3-4051-709b-08ddce97dac9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekRIM3lYbkFNVWVrNHZKL2RUVnNtbnRHeWc4cXE1VG9CeGp2aC9DdXQ5d0ds?=
 =?utf-8?B?ZW83U1JXOGtWbWxoN056dnd1YjhZZXRwNHd4cERHazd0ZHd2ZkdSL3ZkWmtV?=
 =?utf-8?B?TWc4RnpLQjhBbm9FdDlYZnVqbGszOWVUaWFrbnpOV2EzWjZVTmsrMUsrQVRJ?=
 =?utf-8?B?NlBMRU5TQnNMR1k4RmNPaWFRZ29TMmZrWktwUUk0anZ0b0NQNnYwcWZBY3FN?=
 =?utf-8?B?UnFveGF4VTdna0YzaXc5VlJiN0pRdmM3alFnelQ0K3RkQkhLeEJ1clF4c2Nw?=
 =?utf-8?B?b0R6cUErTFM1UEtxbjV5NUdadlBWQWwxVUNDTUZPZzVleVp6UHorWGpVR21h?=
 =?utf-8?B?bTRQc3NtaFVwWGErRi9XUlR1QjBUUmFLTjRaazl2eUg1Tjl4SEZYNU9veGVC?=
 =?utf-8?B?V1h2TnNFanVUbTRIQzZ2ZkQ2Q0dRZzRsZk1lenlzVldSalk4eCtvWnZQUVRx?=
 =?utf-8?B?NHVBUE9YWWR5OEpiazdSajNjY3NoS1ZsWWs4UU4zMm9la21TdFNiZGxScmlJ?=
 =?utf-8?B?S3QxaHBqMmhrclRNRStNT3lvOWZVYTYxOUNFdmtiUmswYWE1VUhId0s1T1pF?=
 =?utf-8?B?VWdHSkoxSTA3WFhIWldJOEpPOUMySFN1d1VEeVM1Y1RQQUpXVUJoQU82cmlD?=
 =?utf-8?B?ZDVhbVNzZFhxcFNLeGVMUlN1bDhNNFo3ay9WZktUY2E3R083d3NxQVp3YzRl?=
 =?utf-8?B?Z2dpNWNLWjQzWWVRR0JvUm1SMHpqOHRIK2kwSmFwTzk2cFFSWW1DMFVUdkNw?=
 =?utf-8?B?T0lQU3lic0wvN2t6aEZQS0xUS1lSSXZzL2hOSWpxTE94ZEdaQUU1QUhKNnN1?=
 =?utf-8?B?OEJ5dG1INThBcXF2UTdDNmlGTDY5M1Uvc2UwSGJob2xmRUd3RHlBV05hb1VU?=
 =?utf-8?B?cDlVY1hLZElUSmlwYU5kVkthbjV2TWlUN3FESmxtNnNRdTBRY0RIZXFSS1Jr?=
 =?utf-8?B?WWx1b2w1MDlpRGJRYkNWcXdseStxNW1NRmJqbjJySk5IZjdBaTNUWEdqSzdU?=
 =?utf-8?B?TlhBb1BQc0NWR3Zrc2tROCtvTkJDZERzSy92aWV2U1lybWlnTmFRdGFicEhz?=
 =?utf-8?B?MWtIc1YxVlhsb3BQbmlmYXM5cCs5UFU3dkxUdDZ0YW1mVUZVWis2b05VWXgv?=
 =?utf-8?B?RlZWR3lpaG1FZXVlOHZwOG1lVGF6NXJsaUVoRk5CK3hnTUViU2NIOUdBOHN3?=
 =?utf-8?B?RlY1WG13Qm1RdGZ0YTZiUGJEQUlVa0p4M3IwUkMyTlBobFdaa3MyYlVFalNm?=
 =?utf-8?B?ejQ5V24wOTd2RU1Zei9KUGZuQlRqcEFXNnZlT2luMlJ3RDF0dkVsUFgxbStp?=
 =?utf-8?B?bzd0ZXJxbW1Zdk9hUFNualpmbUo2ZG1jbVdNMGpNbHRyV2ZYOWxCNUVxUmV6?=
 =?utf-8?B?MUNIOHZkSFhwUWU4cXJIVmg1d0d4aVlmbkQxTDd1Ni9mWVFjUU5GRXpRQ2Jt?=
 =?utf-8?B?STlueE1SVkRBMUpURGNKQnFRYTV6T1NMbWdxTSt5RVowemZ6V0VlUTd0aGlt?=
 =?utf-8?B?cFo1QUQ2VFd5bXdGY21iczI5dklaZ0ZFbGJISFBvclRsb243RFI2YVFBdVpi?=
 =?utf-8?B?SDFBdlRwaEFRVU84ZHBNMEdBaXhrL3EvVGhoRHdTUGFCa3F4cHVwZ1lDdHh1?=
 =?utf-8?B?VnFzQ0VYQ2piOXQ5N0VOSlp3bEJsSGtJRERNWFlUb0xjcE9qSkN1bmZ2ditE?=
 =?utf-8?B?NGtvTWRnaElUcnFuV3JqL3E2WERNVlIyYVh1UUNBT2ZxZW53YWxQcklZUkUv?=
 =?utf-8?B?SVV6S0lISWdYVWRhQTRsaEhGQkhYdmlMVThCM0NNdlNVNmxZcHBvOXFWTHk1?=
 =?utf-8?B?RHJUSWUrS20xZGJKaWt0UlJFUVF3MjM4b3k4OHJwSHB6SzA2RjVQRWxxbSs4?=
 =?utf-8?B?S2pmTzFWVVUxN0FjNG9uTXNhbEJOZGJ5d1MzZnJNSWdoNXdObW1mam00Uytp?=
 =?utf-8?B?cnhsSmpnVVF5am9aWW10bGx2YmpCY243SWVINjM4L1ltNkpjT2hmREZlbG1T?=
 =?utf-8?Q?q3m2Hq/gEegYvHT3rCYOB4sVPVPXR8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZklqU01HZWNhWXpTaUREeWFQN2cxNnNaYktjYzNJamlpajRtYWpuTG9wRVo5?=
 =?utf-8?B?WHJidzRyLzdWYkZKdG5Wa3dBbmNhUzRZNlBXRnhPUEtIZThHeEpST2lneDkz?=
 =?utf-8?B?QWtSQS9TSEFrQ1JrU0NSY0NJUlkwNElKOHVUUGttZHFjTDlDV2xPOWtOaEZt?=
 =?utf-8?B?ejFkRHp6UEI1V1orKzR6WDBhSlh4Nys3Q2NmY0VOMlhOaFI3bExqdW5sWHhT?=
 =?utf-8?B?cXBuako3cjVmUDZ1NzNGczM3Z096TGZLc0psV3dPM2VLaGtRckxPQm9tRXRt?=
 =?utf-8?B?UE4wbzNzaGZGKy8zQ3pOZHpYTllzd3lLR1JDNzNMMFkvY05hdDFETFl4VVF6?=
 =?utf-8?B?NkZ1R041Zncwd3F2akNJWHFUNnlZM0ZPZFlIeVBsSHBBbnFweE5sa25QT1lk?=
 =?utf-8?B?aGdSelBTYk1IakVJUnF5b2ZILzV1OGs0ejVsN3FvbU9RTEZCQmlaTG5ZaG44?=
 =?utf-8?B?QnVKcnJqZTN3dWVHR0RxdFp3cEUvVDBlYi9hQWpRMWlyenFWcElPbWdoVGd0?=
 =?utf-8?B?YnUxNS9KVVNVVFZ1THJPMWM0SUNVTzFtQ3U3WW4wcllpYnNPMWdmam52OU9z?=
 =?utf-8?B?cXUwYlJqWDl5WGxiWTRVOWk1WnppZFhXSlZ3dUQ1cFBYYlFXUy8zNGtSa2Fm?=
 =?utf-8?B?cVdwN25vWkdvOU5IenI3andCMllISDgwZkVqMXkvd0xFbU5FdW0vbEs0TXNj?=
 =?utf-8?B?aEhvMDIvNHRqVDdCbHpIdTBBcW9aVXZSNUhJQ3VXNUVXLzJ1ZWNuM1UvNk9w?=
 =?utf-8?B?ZEc2SzhUTnhIZFFBeUNjb0xHZTZhajR1UGZFZ1RMOUkzT2JPZWlVY2s2ejVp?=
 =?utf-8?B?RmhsdkF4ZTY0aGQ0a3BnbEgzbWtMRnNDTDBGZ3oxbjNVM0tKMWxVZUgrQUlF?=
 =?utf-8?B?Njl4WlJJdElkZSs3YU5wdWI2aVhFUDZmbjVReVhUMG43SFBGa1lGellhRkVH?=
 =?utf-8?B?bGcrNnRjTmxVck5SVVVqY2owQkJ4TTd3dGQxM0FYSndMQmNuTXFhdjBQWkMy?=
 =?utf-8?B?TlVqb1Zxb04xUzlWUDVNbnpnQVUxZ2lGaDFXdVhhZVk2Y2hjRG52TjdpbmV4?=
 =?utf-8?B?OEFCK1l1ZDBEU1RNZTF5ZXVEOGJsV1FTQ0JtMUpLQkdUNk11bjhPM21KZk8y?=
 =?utf-8?B?WTcxdVpmMG84M09WY0N0Q3hwVEs0K1R5dkZGWWxaSTBwNHdQTWxJbmRYV1lO?=
 =?utf-8?B?ejQzMjJoL29XcjBWL0JHZXpNMG40QkQyZW5JTWNWaFZxNTNTQnlTTlZnY0hx?=
 =?utf-8?B?U1F4eVZmTE1ueFF0bEtLNVIzMVZUZERWZis2OXNhTmZpaUVLeWxLcFc2UVVU?=
 =?utf-8?B?MkdHQWQ3aFByaWJaRUdITDJreUVMNitWNnZYVHd5YnJrRzRLbUx5cDEwNzdK?=
 =?utf-8?B?b2RiNjhXc3ZPMFVIZ2M3OEJUS3h2SDY2bXdXSmZJZGpITGkrQlBha1VjbGRn?=
 =?utf-8?B?c28zbmxmaVc2MGlNTDl0SFYxN2NQcnk2OWVrNVZ4dm9KNXpTcVg1NjJJcDVh?=
 =?utf-8?B?NTk4RThWYmVaWkxWenNXU28ySXhpQmVZaFdiazVMQ09Od3V0S0VkN2JLa3VU?=
 =?utf-8?B?UGRqYjdFYWpNelJFYkhXZjhlZUNkcS9BdG1TTGI5dmNaSWtOeTUzQmk1SlFV?=
 =?utf-8?B?RUJDeWRTRFZsZFI4bkVJYVJncHRSUXVnb2lXaHZiUlh5ZVVpRXdIV0tFV2N5?=
 =?utf-8?B?aWl6ckRZU3U4ZHRlVTl3RU0zZGNldDJRMmNUaUJIRlg5U281ZVk0bkw4VnY5?=
 =?utf-8?B?UmxPNnJKYjc2cUFkWkl6cVpKam95d3NiV2hFTi92YXZvVDdFQlgzVGEvak1p?=
 =?utf-8?B?Z0ZwdDBzN0JQN1NIVGZuREdzNDBBT3hTRmkwWGNxeTlwckNEYmVYQTNvUk40?=
 =?utf-8?B?STF5S05KZWNkMVlyMEZDdml3QnBNSXBFUS9jQnlwTFlLR1F2UlFrV3FWbjE3?=
 =?utf-8?B?VEdpY0tPSDhkOVZVVkFPZTBHaDB3MkY4NUp2RHppNmMzRHZxeHQ3emVJRzdp?=
 =?utf-8?B?UDQ2d2VlZlVJdnhMbTU2Z3pOMjFjQUp1UWxFQnM1QVIvUWV4cWl1M2oyUStS?=
 =?utf-8?B?eWVTZXhRai9wbk8wa0FCSi9vMkRQZDVhQjNiVm45bGk1UkFlM1JHRG5lOU83?=
 =?utf-8?Q?p4gM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252a0d91-cee3-4051-709b-08ddce97dac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 12:02:56.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95PozxxD8GNPYXoBzdVXpqK7BMLGfb2kVb24QHTqBjcd8jo3Yoo//akRP1au9+L/zG2SVjnfSQq7V4MyYN/KaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQEpvcmdlIE1hcnF1ZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogSm9yZ2UgTWFycXVlcyA8Z2FzdG1haWVyQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSnVseSAyMiwgMjAyNSAxOjI3IFBNDQo+IFRvOiBHdW50dXBhbGxpLCBNYW5pa2FudGEgPG1h
bmlrYW50YS5ndW50dXBhbGxpQGFtZC5jb20+DQo+IENjOiBEYXZpZCBMZWNobmVyIDxkbGVjaG5l
ckBiYXlsaWJyZS5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGlu
dGVsLmNvbT47IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsgU2ltZWssIE1pY2hhbA0K
PiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsb3JlbnpvQGtlcm5lbC5vcmc7IGppYzIzQGtlcm5l
bC5vcmc7DQo+IG51bm8uc2FAYW5hbG9nLmNvbTsgYW5keUBrZXJuZWwub3JnOyBsaW51eC1paW9A
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGFuZGV5
LCBSYWRoZXkgU2h5YW0NCj4gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IEdvdWQsIFNy
aW5pdmFzIDxzcmluaXZhcy5nb3VkQGFtZC5jb20+Ow0KPiBtYW5pb24wNWdrQGdtYWlsLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGltdTogbHNtNmRzeDogQWRkIHNodXRkb3duIGNh
bGxiYWNrIHN1cHBvcnQgZm9yIEkzQw0KPiBpbnRlcmZhY2UNCj4NCj4gT24gVHVlLCBKdWwgMjIs
IDIwMjUgYXQgMDc6MzI6NTRBTSArMDAwMCwgR3VudHVwYWxsaSwgTWFuaWthbnRhIHdyb3RlOg0K
PiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9u
bHldDQo+ID4NCj4gPiBIaSBARGF2aWQgTGVjaG5lciwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxp
YnJlLmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjIsIDIwMjUgMjozMSBBTQ0KPiA+
ID4gVG86IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgR3Vu
dHVwYWxsaSwNCj4gPiA+IE1hbmlrYW50YSA8bWFuaWthbnRhLmd1bnR1cGFsbGlAYW1kLmNvbT4N
Cj4gPiA+IENjOiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IFNpbWVrLCBNaWNoYWwN
Cj4gPiA+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGxvcmVuem9Aa2VybmVsLm9yZzsgamljMjNA
a2VybmVsLm9yZzsNCj4gPiA+IG51bm8uc2FAYW5hbG9nLmNvbTsgYW5keUBrZXJuZWwub3JnOyBs
aW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgUGFuZGV5LCBSYWRoZXkgU2h5YW0NCj4gPiA+IDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFt
ZC5jb20+OyBHb3VkLCBTcmluaXZhcw0KPiA+ID4gPHNyaW5pdmFzLmdvdWRAYW1kLmNvbT47IG1h
bmlvbjA1Z2tAZ21haWwuY29tDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGltdTog
bHNtNmRzeDogQWRkIHNodXRkb3duIGNhbGxiYWNrDQo+ID4gPiBzdXBwb3J0IGZvciBJM0MgaW50
ZXJmYWNlDQo+ID4gPg0KPiA+ID4gT24gNy8yMS8yNSA2OjM4IEFNLCBBbmR5IFNoZXZjaGVua28g
d3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgSnVsIDIxLCAyMDI1IGF0IDA0OjM3OjQxUE0gKzA1MzAs
IE1hbmlrYW50YSBHdW50dXBhbGxpIHdyb3RlOg0KPiA+ID4gPj4gQWRkIGEgc2h1dGRvd24gaGFu
ZGxlciBmb3IgdGhlIFNUIExTTTZEU3ggSTNDIGRyaXZlciB0byBwZXJmb3JtIGENCj4gPiA+ID4+
IGhhcmR3YXJlIHJlc2V0IGR1cmluZyBzeXN0ZW0gc2h1dGRvd24uIFRoaXMgZW5zdXJlcyB0aGUg
c2Vuc29yIGlzDQo+ID4gPiA+PiBwbGFjZWQgaW4gYSB3ZWxsLWRlZmluZWQgcmVzZXQgc3RhdGUs
IHByZXZlbnRpbmcgaXNzdWVzIGR1cmluZw0KPiA+ID4gPj4gc3Vic2VxdWVudCByZWJvb3RzLCBz
dWNoIGFzIGtleGVjLCB3aGVyZSB0aGUgZGV2aWNlIG1heSBmYWlsIHRvDQo+ID4gPiA+PiByZXNw
b25kIGNvcnJlY3RseSBkdXJpbmcgZW51bWVyYXRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IERvIHlv
dSBpbXBseSB0aGF0IHRvbnMgb2YgZGV2aWNlIGRyaXZlcnMgbWlzc2luZyB0aGlzPyBJIGRvbid0
DQo+ID4gPiA+IHRoaW5rIHdlIGhhdmUgZXZlbiA1JSBvZiB0aGUgZHJpdmVycyBpbXBsZW1lbnRp
bmcgdGhlIGZlYXR1cmUuDQo+ID4gPiA+DQo+ID4gPiBJbiB0aGUgSUlPIGRyaXZlcnMgSSd2ZSB3
b3JrZWQgb24sIHdlIGFsd2F5cyBkbyByZXNldCBpbiB0aGUgcHJvYmUoKQ0KPiA+ID4gZnVuY3Rp
b24uIFRoZQ0KPiA+ID4gc2h1dGRvd24oKSBmdW5jdGlvbiBtaWdodCBub3QgcnVuLCBlLmcuIGlm
IHRoZSBib2FyZCBsb3NlcyBwb3dlciwgc28NCj4gPiA+IGl0IGRvZXNuJ3QgZml4IDEwMCUgb2Yg
dGhlIGNhc2VzLg0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgaW5wdXQuDQo+ID4NCj4gPiBZ
b3UncmUgYWJzb2x1dGVseSByaWdodCDigJQgc2h1dGRvd24oKSBtYXkgbm90IGNvdmVyIGFsbCBj
YXNlcyBsaWtlIHBvd2VyIGxvc3MuDQo+IEhvd2V2ZXIsIGluIHNjZW5hcmlvcyBzdWNoIGFzIGEg
d2FybSByZWJvb3QgKGtleGVjKSwgdGhlIHNpdHVhdGlvbiBpcyBkaWZmZXJlbnQuDQo+ID4NCj4g
PiBCZWZvcmUgdGhlIHByb2JlIGlzIGNhbGxlZCBpbiB0aGUgbmV4dCBib290LCBkZXZpY2UgZW51
bWVyYXRpb24gdGFrZXMgcGxhY2UuIER1cmluZw0KPiB0aGlzIHByb2Nlc3MsIHRoZSBJM0MgZnJh
bWV3b3JrIGNvbXBhcmVzIHRoZSBkZXZpY2XigJlzIFBJRCwgQkNSLCBhbmQgRENSIHZhbHVlcw0K
PiBhZ2FpbnN0IHRoZSBvbmVzIHJlZ2lzdGVyZWQgaW4gdGhlIGRyaXZlcjoNCj4gPg0KPiA+IHN0
YXRpYyBjb25zdCBzdHJ1Y3QgaTNjX2RldmljZV9pZCBzdF9sc202ZHN4X2kzY19pZHNbXSA9IHsN
Cj4gPiAgICAgICAgIEkzQ19ERVZJQ0UoMHgwMTA0LCAweDAwNkMsICh2b2lkICopU1RfTFNNNkRT
T19JRCksDQo+ID4gICAgICAgICBJM0NfREVWSUNFKDB4MDEwNCwgMHgwMDZCLCAodm9pZCAqKVNU
X0xTTTZEU1JfSUQpLA0KPiA+ICAgICAgICAgeyB9DQo+ID4gfTsNCj4gPg0KPiA+IE9ubHkgaWYg
dGhpcyBtYXRjaGluZyBzdWNjZWVkcywgdGhlIHByb2JlIHdpbGwgYmUgaW52b2tlZC4NCj4gPg0K
PiA+IFNpbmNlIHRoZSBzZW5zb3IgcmVzZXQgbG9naWMgaXMgcGxhY2VkIGluc2lkZSB0aGUgcHJv
YmUsIHRoZSBkZXZpY2UgbXVzdCBiZSBpbiBhDQo+IHJlc3BvbnNpdmUgc3RhdGUgZHVyaW5nIGVu
dW1lcmF0aW9uLiBJbiB0aGUgY2FzZSBvZiBrZXhlYywgd2Ugb2JzZXJ2ZWQgdGhhdCB0aGUNCj4g
c2Vuc29yIGRvZXMgbm90IHJlc3BvbmQgY29ycmVjdGx5IHVubGVzcyBpdCBpcyBleHBsaWNpdGx5
IHJlc2V0IGR1cmluZyBzaHV0ZG93bigpLg0KPiBIZW5jZSwgYWRkaW5nIHRoZSByZXNldCBpbiBz
aHV0ZG93bigpIGFkZHJlc3NlcyB0aGlzIHNwZWNpZmljIGNhc2Ugd2hlcmUgdGhlIHByb2JlDQo+
IGlzbid0IHJlYWNoZWQgZHVlIHRvIGZhaWxlZCBlbnVtZXJhdGlvbi4NCj4gPg0KPiBIaSBNYW5p
a2FudGEsDQo+DQo+IER1cmluZyBpM2MgYnVzIGluaXQsIHRoZSBDQ0MgUlNUREFBIGlzIGVtaXR0
ZWQgdG8gcmVzZXQgYWxsIERBcyBvZiBhbGwgZGV2aWNlcyBpbiB0aGUNCj4gYnVzIChkcml2ZXJz
L2kzYy9tYXN0ZXIuY0BpM2NfbWFzdGVyX2J1c19pbml0IC0+IGkzY19tYXN0ZXJfcnN0ZGFhX2xv
Y2tlZCkuIElzIHRoZQ0KPiBMU002RFNYIG5vdCBjb21wbGlhbnQgd2l0aCB0aGF0Pw0KTFNNNkRT
WCBpcyBjb21wbGlhbnQgd2l0aCBSU1REQUEgQ0NDLg0KDQo+DQo+IEkgZ2V0IHlvdXIgc29sdXRp
b24gYnV0IGZpbmQgb2RkIHRvIHVzZSB0aGUgc2FtZSBtZXRob2QgYXMgaW4gdGhlIHByb2JlLg0K
PiBJbiB0aGUgcHJvYmUsIHlvdSB3b3VsZCwgaW4gZ2VuZXJhbCwgcmVzZXQgdGhlIGRldmljZSBs
b2dpYywgYnV0IGxlYXZlIHRoZSBpM2MNCj4gcGVyaXBoZXJhbCBsb2dpYyBpbnRhY3QsIGJlY2F1
c2UgeW91IGRvbid0IHdhbnQgdG8gdW5kbyB3aGF0ZXZlciB0aGUgY29udHJvbGxlciBoYXMNCj4g
c2V0LXVwIGZvciB0aGUgY3VycmVudCBidXMgYXR0YWNoZWQgZGV2aWNlcyAoaWJpIGNvbmZpZywg
ZGEsIG1heCBkZXZpY2VzIHNwZWVkLCBhbGwgdGhlDQo+IGdvb2QgaTNjIHN0dWZmKS4NCj4gRm9y
IHRoaXMgZGV2aWNlLCB0aGUgc3RfbHNtNmRzeF9yZXNldF9kZXZpY2Ugc2VlbXMgdG8gZmx1c2gg
YSBGSUZPLCBkbyBhIHNvZnR3YXJlDQo+IHJlc2V0LCBhbmQgcmVsb2FkIGEgdHJpbW1pbmcgcGFy
YW1ldGVyOyB3aGljaCBhcmUgbmVjZXNzYXJ5IHRvIHNvbHZlIHRoZSBidWcgeW91DQo+IGFyZSBv
YnNlcnZlZD8NCk9ubHkgc29mdHdhcmUgcmVzZXQgbmVjZXNzYXJ5IHRvIHNvbHZlIHRoZSBidWcu
DQoNCj4NCj4gSWYgcG9zc2libGUsIHBsZWFzZSBleHBsYWluIGJldHRlciB3aHkgdGhlIGRldmlj
ZSB3b24ndCBlbnVtZXJhdGUgY29ycmVjdGx5IGFmdGVyIGENCj4gcmVib290IHdpdGhvdXQgdGhl
IHJlc2V0LiBJZiBpdCBpcyBhIGRldmljZSBidWcsIGV4cGxpY2l0bHkgc3RhdGUgdGhhdCBhbmQg
dGhhdCBpdCBpcyBub3QNCj4gY29tcGxpYW50LiBBbHNvLCB0YWtlIGEgbG9vayBhdCBmaWcuMTAw
IG9mIHRoZSBpM2Mgc3BlYyBiYXNpYyAxLjEuMS4NCj4NCj4gVGhhbmsgeW91IGZvciBsb29raW5n
IGludG8gdGhpcywgdGhpcyB0eXBlIG9mIGNvcm5lciBjYXNlIGlzIHVzdWFsbHkgb3Zlcmxvb2tl
ZC4NCkl0IGFwcGVhcnMgdGhhdCB0aGUgc2Vuc29yIGRldmljZSBpcyBlbnRlcmluZyBhIGRlZXAg
c2xlZXAgb3IgbG93LXBvd2VyIHN0YXRlIGFuZCBpcyBub3QgcmVzcG9uZGluZyB0byBDQ0MgY29t
bWFuZHMuIEhvd2V2ZXIsIGFmdGVyIGEgc29mdHdhcmUgcmVzZXQsIHRoZSBzZW5zb3Igc3RhcnRz
IHJlc3BvbmRpbmcgdG8gQ0NDcyBhcyBleHBlY3RlZC4NCg0KU2hhbGwgd2UgcHJvY2VlZCB3aXRo
IG9ubHkgdGhlIHNvZnR3YXJlIHJlc2V0IGNoYW5nZXMgYWxvbmcgd2l0aCBhbiBpbXByb3ZlZCBk
ZXNjcmlwdGlvbiwgb3IgZG8geW91IHJlY29tbWVuZCBhbnkgYWRkaXRpb25hbCBtb2RpZmljYXRp
b25zPw0KDQpUaGFua3MsDQpNYW5pa2FudGEuDQo=

