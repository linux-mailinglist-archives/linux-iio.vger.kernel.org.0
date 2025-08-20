Return-Path: <linux-iio+bounces-23031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F744B2D80B
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 11:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC3A5C29F6
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C42DAFBD;
	Wed, 20 Aug 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OypSmZ26"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C22DAFA9;
	Wed, 20 Aug 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681090; cv=fail; b=JM13AixGXNfC5UUjjRl4EoKBWfQNDYQ8LZHIyjVF7mnwMWGA6oBadPum3/HXnf4/cK1DyjAl0dv2/5fFEuYho29dTz0tU5ygtryZq6E4y9X5Kejezns3eFQ7HQRG806a7dos1D6ERn7Kvye31UqMf6kdPnT6oXWe3U5XXVP7AV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681090; c=relaxed/simple;
	bh=FU5RRIzVtUriuewq9D99hGg1WXNUhlwakc14s8ylpuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kUcikBCLSFLEJP1khR2vU7FnFgLe/rkNwnz9qApMuajuwr26J7FgJf5y9VV95g/MzeiNZVbQIqpTaehaQzfqaot89w6Y0A2eS++P9JtLh8rBMBHaWz0tVD/ZuNgVpR3yfyWONFakuGsvcn1XIdz+Tr3p/Yotx1KIU43/USLjIoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OypSmZ26; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDsuM7ikREanJjnDNtj56LFXR0Uur2FIs7uX+LrlDeph6LNnvm2wq0xQkHlBj2oVMU5Qa5tqZMO27MOD14MRcb5rd0AUfCzivLQcwbeCPWJecf2n0QMT5Ft7bYLdL2OVx+hrG5X512kQOrHNqfy997YqNy6UPnfhyRIhwVxSGlyw688nZbj8NqeFEU3wKGgBT7z0YRx4+Rfwc5GJwM4kKzxLs6HOAHSJukUFpIDD0/Duln9RWXFm+hZRcZBYi4wxBtckNV6Qs8fVdvFoAwNADuVcMaic8/OKZNx7VhXZTfngujM87jABf01f9xMpBxKO5bz92IlWPoTIH0PCdafYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU5RRIzVtUriuewq9D99hGg1WXNUhlwakc14s8ylpuU=;
 b=FbE+yYpGDLPGd7BVKT2kpfYA1GQ6sz60PYUhP78CpzYrCYkXyKd29PqkmQHPNrtxrrRR7IjqShf47ZOvZF7w18YUV+mJHWnwRI87kLqS6AXJKWEOLX5Ft0Ycag36k+VBxLuhxTzxnvgNsFlrEbs5tQorXIjSzKj0b0Q1HQXSq2mQIqgDTpfipQnyDdOnCLU2Wu81IJJN2qagyaTG4/XI1K5LT+96RFNRHecx8VIaOjEIy0UEz4Qg4+uKL/ySM73yJbMh3zAd4TNgkLWsD5E6FDA54/a5dK/3HluAaOnXH0j76ePupZpjnzIWIeWAUcmzL57O4741LQxFUADNgTvFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU5RRIzVtUriuewq9D99hGg1WXNUhlwakc14s8ylpuU=;
 b=OypSmZ260KJPbfsWt89X3eLoKTD7fie2xs3cAep7GCOWWC6/13siM7YFIM8ggg4BgSGsx0UbuTtTKoVF4sv5bzKfI+MxvZYlWt+dkhoR7Krwmqf3FZFeOlZ4rs2Ln2OP+KBSIeGuchuSfyHSKhwxWMJyRtM1juaponNgCC/b7k0=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 09:10:53 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 09:10:52 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "O'Griofa, Conall"
	<conall.ogriofa@amd.com>, "jic23@kernel.org" <jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
Thread-Topic: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
Thread-Index: AQHcERqvcBHG1EuWpUKnQp2WApQG/rRrEEmAgAAxEWA=
Date: Wed, 20 Aug 2025 09:10:52 +0000
Message-ID:
 <IA1PR12MB7736460C9ACC449D58F992559F33A@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20250819150448.1979170-1-salih.erim@amd.com>
 <6048713c-9be8-4078-b612-b67c7bd39103@kernel.org>
In-Reply-To: <6048713c-9be8-4078-b612-b67c7bd39103@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T09:06:57.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|IA0PR12MB8349:EE_
x-ms-office365-filtering-correlation-id: 44fcb3a2-0046-4760-7e86-08dddfc97694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkdZWTljUU1laURwYk5hd3NydUtWeU5RVmVjV3N3Y2NPVWllc1JWWkhER2wy?=
 =?utf-8?B?bFRCN1llN1hoTGVnRkxzUUx1S2hvUitXc2NPUiswUmdEM1F6cVNQcEwxOG1t?=
 =?utf-8?B?TXpEYk5USVB6M2NSN2FnMCtlTUx6d0RkVlFZQ04zS05rSjIxNE1HL0VKYzdy?=
 =?utf-8?B?NXQ3dklKN1dPVzR2dmdEMlUxU0lseHV1M0hpWjlHc1BsWkJCY2lqQXlHblNV?=
 =?utf-8?B?SGtzVC8zMXA0SDZBbUZ3SVZlOGszQ0R0cmx2TEFGNWlYcmszY0dMT3JVOHZ3?=
 =?utf-8?B?WHZ3RktsdXhUUnY1OFMrOWc1QkRWYVhuT3hNSERoL3MwZmQ5NFN5UGNSWW5T?=
 =?utf-8?B?T09xRkZGc0JTNmtLUnB4a1A4VHRsUkJqK2pzTG9GZCtlZFlUUjhLaG9mRXFI?=
 =?utf-8?B?Rnh1bVhGdlVLV3pqNCtFK1lOUFF1NTQzOGxEbXJ3VHd6VEZQbW5PemFkckJa?=
 =?utf-8?B?QmNGc1FGbEwvZ2hQQ1dlaU9yTk5xMW1mMndTRWI2akNFck9pak1qdTdiL09n?=
 =?utf-8?B?UVJvb0FkOExrYnUzRWFFVlliK2luZEZRbHJZbkxRMldxdkZXUU9hOW1nU3Rl?=
 =?utf-8?B?aFhuZ0U4ZjYwWkYwOU9WNVBZcnpGa1N6T092eG04V2NVYXY1b2QwelZvVTZm?=
 =?utf-8?B?RUxUc29nQ1JsTlp2NStOTnJXeit1SVhTQ2x3eENKa0dxWnBzb21uYjg0ZGxo?=
 =?utf-8?B?QTN6emUwUG5qS0VKenF2TkF5cHN5QzVWRllZbW1DK2FBaU9UbnhMTU12bEE5?=
 =?utf-8?B?RkJBdHFOS2VvcWdIL3FJWndacHMrVVFjS3NhVDZHdHBzR0VFb1FRMGZ0cm1q?=
 =?utf-8?B?VEM0cXh1c3F0T1Q1K2ozOERuYmtORllxeGQvMmtDZzI1U3Z3di9lZDJPVGpl?=
 =?utf-8?B?K0RkdVNrSjhkL1hldEJJMTNOQ3NKMFlRYkNDbzdhczlIOUM1WVJXUXhtYlkz?=
 =?utf-8?B?V2ZiTnY0OXYxN2RPcXdCNXc4eHNFZnJNWW9KQm5uY1h3NEs0VUpTMFJldkcw?=
 =?utf-8?B?akFnN2dFRnlKb0poMXg3cEtGdmZpNE5RNE5XMHdLV2V3cklLT0c4WG5wNVBi?=
 =?utf-8?B?WG0rMHRaa0NLelptSlZWN1Rxc082cTBJSHczVWFlT1JjdlJsbzcza05pWmZU?=
 =?utf-8?B?THN2Nlg2aXF5L04xRDFrUXhBdXEweXdIOVUvNDBQOTl2MHE1T3BNWVZIUFNB?=
 =?utf-8?B?dzNxZUt0VGU4a0VCS1lPVHhjVE9FZ2Q2Wm56TjFtZmY0bTV0SVFSamlGZXh0?=
 =?utf-8?B?QnlJNzJiR0JoNjVxYTdFWlRSdDdKZmNEZHNVQlhNZ2J1cEEzeW5vMUxmOXJG?=
 =?utf-8?B?UkpZUjRjTjlUMlhERlNNdlF6L1BBandLVUkrdUI5d0p6ODBpTlpHT2dWTlFY?=
 =?utf-8?B?ekdiL0dza0FFVzdONUtTM1NadnR4OXlXb3FXOFA4MXpYRklOQUJPY2dUM1RE?=
 =?utf-8?B?WnIrVGlWdGlycnNWcjczQndHYXI1VWMvNjhtU0x6SnY1dG5qR2pTVHN2Zzg1?=
 =?utf-8?B?Y2tkcTErQnoyWTZ4S3BsM1k2R2tOQmNOOGx0SllJWFBYTjBwTUk2UU1WRjhG?=
 =?utf-8?B?eTM3L1hBRnJNcFJsdnVIUE5rRlFMMmluU1dRQW9KZ0dlNGRyQ0NxMzhnelIz?=
 =?utf-8?B?d3o3ZTBwMGVWNERyTTloR2IyOEpQZkxMVDZXVkNaZUtYUE1NWlNURlpkZ1NX?=
 =?utf-8?B?UDY0VndxY2x2RWlQajNNd05BRVA4b2x5ci9QRzZ5dFlRaUNqQ2dBd1h2MzdD?=
 =?utf-8?B?QVdBc05rbFVkUEtBUFJ4eDB4eTdEQmxGNnZ4WFZOY0M1bHl4N3VGN0I1djc5?=
 =?utf-8?B?aDA5U1J5d25Mb2NSSEN0RHpFNU9Sb2VDbVE4ejlsTFV5U3kzWE40Wm5lYWVW?=
 =?utf-8?B?dFNVdWJDWU02MW90bmtSTkttK0cyM2RrNlYrRi9OMGRCNEtLZHhxZjBObUs3?=
 =?utf-8?B?RU8rYnlYaTduS2lZSmZQbW1QMW9MV2VGV1M5MUdyNjBidWZDajQxdFd0TEtr?=
 =?utf-8?Q?gqtN/sCLgVbDx/kychTmJDn8Rwp8qM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WElETzZ1QUtnaEhRVVV0RkFIcFVVb1BiTlI2bGkzZUNPRm1tNnNMUUJTRkdX?=
 =?utf-8?B?TmlIbllTY2RhZzZPUjBPRnAzYzZRaHY4RjROSmQ2U09ka2h5c0dhVmNta2Vm?=
 =?utf-8?B?cnh6YnZ0V2ZOVlVLdHVibnEraEJ2dm95L29vS0lxR1BLWEJWVjlua1JWZjIy?=
 =?utf-8?B?RFdhNU1od093YkZTU3lUbG9IeStaZ2NJS25QNFhLZGFrMDNSVm03MkxMbG45?=
 =?utf-8?B?Ujc4MzB5NEJDL2ExdWhpODZobG5rNXl1ZlFHMjB2TURHV2wyekF1eTFhUkhW?=
 =?utf-8?B?MUM3cThEQk0za1VBeHlrQnBvSm1JRnR3cUFsTVQyQkhrZUU4ejZmY2dpZ1h0?=
 =?utf-8?B?NDJxQ1hMYTZqTnZzNW1sczRHUngwRHAxQitYZ3lrdjMxL3VtdzZrSUY3YnpX?=
 =?utf-8?B?c09nelI2K2dQQnMydENQVTI2dDZEL1J5NEU5U3YvS0gzSXdNU0FlWkR6ZWV0?=
 =?utf-8?B?Mk5nNEh2NFUwdXZxUFBENENleURqMWh2dlRSMXd3cEw1VG91dDhlNmVvVmZX?=
 =?utf-8?B?VFd3ekxRV2xqQ0RSb1JlQkRsai9wdGZ6eUNiMU1YblJFeUdyUkh1VGMzTWpY?=
 =?utf-8?B?ZXV4a1dwL3hJb043eDNOQkg1OFdVZUl2WEJYREFqRWpLVzZhMFdFZW5nMmZX?=
 =?utf-8?B?YVU5aEZ4TzBGZWsvTWNsMFJGQmovY1hmQ2VpejNETjFsbUxYYmVkRy9sd3dW?=
 =?utf-8?B?OVJ4c0l6YjlCcjZULy9wc2s4MG5nRnJiSHVkaEJrSEdWUEpVOEJjb0dTbU5q?=
 =?utf-8?B?dXZNL3lMWWZQQmZudjA0K2MrVHdJRVNQZ0VpclZOWFhGSHVhL2MvdGhxLzRh?=
 =?utf-8?B?eTNtT0JLUkpjTlFqNUNJZjhCNVlJMkhxdHU0c2RoQ25NdWg0YjZ4M3p0bVFk?=
 =?utf-8?B?ZmtlUlRMaUt0UFVkMzZPa1NodHpESnA5bmxaVGVPQVhNcDRSRStWSVpPMWFl?=
 =?utf-8?B?aWRzcGFCMFRUQXZ4bnAxOGM1OWJTUi9jUkNxeTlkTkRKVmpyb3pmeTAvYy9B?=
 =?utf-8?B?dTFiMmxIZkhSMmJYbFlQbHdPWnkzdnNXYkpMdE5ac0V5OW9relRGTWZ5Smsw?=
 =?utf-8?B?UE83Y0FEMnBNeEtwNnRieUFBaVdmRXRvbVlHN0VYRzlFQW54eThzZDlpTFRs?=
 =?utf-8?B?UUkzK1hTcEUyd0Z2RXhTYkhyeEVLbHl0SldYNDMzMk9Sd0YvNXZnejNQL1hk?=
 =?utf-8?B?a3BVOVc0Nm5naGNkbzcxOUdTQkFCVkxHNWdTVDBpTG5IeTBzRzNVRTRaY2to?=
 =?utf-8?B?Q0xYZ3VFU2ZVUXA4Z1MySzFEZko1cG1zMkQzL3VWZVJ3Ym5jdVpmVXgzZ09D?=
 =?utf-8?B?czZVMitDT3pKNTA4SHJodzBUS3VIbTJKeFZjUU45MlRCZm5qM29IWkxtc2lJ?=
 =?utf-8?B?ZzFpb0JlZjdFekFkeUI2MjRwaUo5NkgwaFh2K1dBMzJ4UkY4VlVPb1YzZThE?=
 =?utf-8?B?SjlQbFRpbk5YNnJpSTlFeVZPRlJpR1FJWUR6d3FrQ2FRalkyOC9veGZpVUdt?=
 =?utf-8?B?QmhKanFhclIxTEhEWlFidU5iWXdCUXhxbEk4VVhKbjQxYjh0WU9QdGpUY0c2?=
 =?utf-8?B?ckZnbTBHRk1ndTNMWWp3QWNVK0d6YU5mM1FsWU4vbGVrZTJwdktRelBaYk9E?=
 =?utf-8?B?c013RmhrcDhPTnNZOElKWEhsT2dIV2lhQ2h5eUNkNlRCbHg5MGw3YjJkS204?=
 =?utf-8?B?K1FnTFNUemV0aFFtZk11T1V5dlZPUHB2Z3oveXBVS2FRS251UGs1MG40NGFT?=
 =?utf-8?B?WElkNzlEZWlIa21QS0cvNXJZdFJLbmdvcksvRFZUNC9DaGtvMXZVSHhoUzAr?=
 =?utf-8?B?amVuUlJ2R0V0bUpYNkZERjg3UUtwKzBNMEE0TGFFL1BCZ3pIRERYNWpwaHZq?=
 =?utf-8?B?MEFkbUVsbkxPOVRyVG1KeWpnVXBwL3ZpRXo2aGN6c1hNSzQ1M1lVcFJMd3B0?=
 =?utf-8?B?aUtwUjVSMkh0YmZqUnNYckRpUmN2ZWhORHpvZzNNaFNEREJTOW91a0hMVXR5?=
 =?utf-8?B?ODJUbVVNVXNnbllaSUZZU2RwbFBjVW51TGo4S0F5UzZjbllFY3NLcEc5T0Fy?=
 =?utf-8?B?dHIxU2JSTC9oNUlXRWtvdUJ3WTJ3STBKQzBNc09YY2VBckxVWFNlTkVpci9Q?=
 =?utf-8?Q?7uz0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fcb3a2-0046-4760-7e86-08dddfc97694
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 09:10:52.7233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lb9Ot08JUz42ZG3Tbi3M0ZV43hGZqlJAZUGYBif06KhlAwS4IIc8/tlxPOR2shiE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5
LCBBdWd1c3QgMjAsIDIwMjUgNzoxMSBBTQ0KPiBUbzogRXJpbSwgU2FsaWggPFNhbGloLkVyaW1A
YW1kLmNvbT47IE8nR3Jpb2ZhLCBDb25hbGwNCj4gPGNvbmFsbC5vZ3Jpb2ZhQGFtZC5jb20+OyBq
aWMyM0BrZXJuZWwub3JnDQo+IENjOiBkbGVjaG5lckBiYXlsaWJyZS5jb207IG51bm8uc2FAYW5h
bG9nLmNvbTsgYW5keUBrZXJuZWwub3JnOyBTaW1laywNCj4gTWljaGFsIDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIE1BSU5UQUlO
RVJTOiBVcGRhdGUgeGlsaW54LWFtcyBkcml2ZXIgbWFpbnRhaW5lcnMNCj4NCj4gQ2F1dGlvbjog
VGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9w
ZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBv
ciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiAxOS8wOC8yMDI1IDE3OjA0LCBTYWxpaCBFcmltIHdy
b3RlOg0KPiA+IFJlbW92ZXMgQW5hbmQgQXNob2sgZnJvbSBtYWludGFpbmVycyBhbmQgYWRkcyBT
YWxpaCBhbmQgQ29uYWxsIGFzIG5ldw0KPiA+IG1haW50YWluZXJzLg0KPg0KPiBXZSBzZWUgdGhh
dCBmcm9tIHRoZSBkaWZmLiBEb24ndCB3cml0ZSB3aGF0IGlzIG9idmlvdXMuIEV4cGxhaW4gd2hh
dCBpcyBub3Qgb2J2aW91czoNCj4gd2h5IHlvdSBhcmUgZG9pbmcgdGhpcy4NCg0KQXMgTWljaGFs
IGV4cGxhaW5lZCwgQW5hbmQgbGVmdCBBTUQgd2hpbGUgYWdvLiBNZSBhbmQgQ29uYWxsIGNvbnRp
bnVlIHRvIG1haW50YWluIHRoZSBkcml2ZXIuDQoNClRoYW5rcyBmb3Igd2FybmluZywgSSB3aWxs
IGJlIGNhcmVmdWwgYWJvdXQgZnV0dXJlIGNvbW1lbnRzIGFuZCBjb21tdW5pY2F0aW9ucy4NCg0K
UmVnYXJkcywNClNhbGloLg0K

