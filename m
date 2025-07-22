Return-Path: <linux-iio+bounces-21853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB77B0D28D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 09:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C0D1C24493
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700782C1594;
	Tue, 22 Jul 2025 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Su7Cme7c"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E12D9494;
	Tue, 22 Jul 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168768; cv=fail; b=K08SIcv6Zml7Ob31lDdji8EbY5zw2/uKPfpSjMSQesTh1NQGPZhZUvbLjkc56XaTkJN6xRy9E4tSjV1K9Z0nXSKaBB8cLpYIGIif6EY2745V1XUrd+hP6GmP2PDcIjF99tbzxjJ0UWNv5fOyoVj1zB4HI2vJWjdQrezS5aFTcFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168768; c=relaxed/simple;
	bh=bB188WfTDqjXU/Y9XWod94Fy41uDorFm3rMEB3qs9IQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ltuU5M2uZa1vVbzz1lnHxsGHRDxGUCf5IgU1FyeSGJshZu+SR3eFOwaxsKJ6Pboyx0phk8rvr8YNmEhG02k0HJ6N2Q7Ogo/f+vgLmMG9oXAuwlw298m/9+ameJboVlJro8JSCuY1VKVSVhxuppQQqxMrznXpojY1AV4BBycoBM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Su7Cme7c; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu8kQiHUZvxI1rPL0U7oyo/+dkCcT0A7V5oadkbfpoh9UCQplgDPsHGL4sOfIbN37fq6luLcBd7f23p0KmtGhqmcOEEEzHVbREmCCadldOGdvV3xMtkGfS+Lh03e7cS7evGIzUGkOu18YAJfZamEZ8d9bBInUWvsO84VV24y37vqlSOJVSJFTDK5eNfw23KVdZHtKX/O+CJPxvxbiHTIpg+hs5XFLXHDAyPCHrPoGL+qwM+0SbaQmuuQKk7R7l11AZ8/AXMVg7/y0BKTnbUjN2EaKGwsU/x4PrI5U/xKWb5rMTGB0yctM/c+diamaSk4gDfVVh6KdHaQis1b/NdwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1uZHpEBf7vjugXUd4+tJm0L7l1HZUwYyU2qu/gaO6k=;
 b=eYiN8tWaoyR6/Lk2kou0RVjrPiNXgPkDZJji7s1Mpm8z92I00xHKgELYU9xMp9s6P5oW2A0gY/nreKXvDUA5VMuf/7VQ1BGXrXAL5lWgPZMX25uHjEyAOn1ukEb/nUgGl4EJJR0jYZ5I4sJackcsdttZSbF1c0nf8BquzXdeFMC4fQbD0JWFrDcO0dMSkV3MlP3CXd3BVJQ+z3mDvmmqDpWr91ApNOn6M4N6BsW4NwDFvfhYqZ6dZQWEcN9+1aw9HnpNlpWPLZbmsgT2jxB5EKPXNKP/mHOXVgqhPGMPufBHxke+tX0d0mpOfaoNyLnn/mw8C1Wpf9DLo6yRhNd/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1uZHpEBf7vjugXUd4+tJm0L7l1HZUwYyU2qu/gaO6k=;
 b=Su7Cme7cMFfuWSOKVM7bT4LmH7b2sALuCSHtfg3D155l0byV9UBM50P1yuxQbH6Ce89Bb4wtx6nW4qaBGrMnD8zT7lSAfiT+vVFcE7xUEtMr5IDBEQeR9PmbYbtXMzvvaGBdf1PZCZ6vH/YIVxeSrQ7OqurpXsSXnNa1q9wGuMQ=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:19:19 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 07:19:19 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org"
	<andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pandey,
 Radhey Shyam" <radhey.shyam.pandey@amd.com>, "Goud, Srinivas"
	<srinivas.goud@amd.com>, "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Topic: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Thread-Index: AQHb+i+8xK2s1GBMXUK4mOoG9AwzB7Q8c6QAgAAAO4CAAUOJEA==
Date: Tue, 22 Jul 2025 07:19:18 +0000
Message-ID:
 <DM4PR12MB6109997B928B39D878B12FB68C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com> <aH4m84n5UbCsktCM@smile.fi.intel.com>
In-Reply-To: <aH4m84n5UbCsktCM@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: andriy.shevchenko@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-22T06:57:29.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|PH8PR12MB7448:EE_
x-ms-office365-filtering-correlation-id: 41c8d21c-b9b1-47a9-c89f-08ddc8f012dc
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gEmSf91zjhfQlMfnTEV2OarVZt9nkeIOAbODYSOIsNV0t9JfmcWzdLh68FqO?=
 =?us-ascii?Q?l273N2gyyFRKZQwaSx6l5T5Gxr3L8VptdN5M4puXvrTd+gVvp6/FqvVRfpp+?=
 =?us-ascii?Q?+7K9K1HlxvNqha9wR6PySUiNfXoZ48hC5V45+KpDTpkMF7wjMVVU+v0nLAcv?=
 =?us-ascii?Q?6v4AKhb0ICY/IMMyWph7qC0zIzwyDfBnOTrYZrf75I64uu83whWoOUC/8KvC?=
 =?us-ascii?Q?cnc6D9wWyqaLrr8NehYGJoWqKpMs3zOSMa2CTmMFD4Cj/PzBWRibEYAywzcL?=
 =?us-ascii?Q?Xz4SQsV9hWksz95+Lsw+u8EVd859uolmET7BLkSI0bmGPtDX8gD1KEzIfA2x?=
 =?us-ascii?Q?gDrw97gK5/vPiDN6bThBFBa+2slZJIHn7JQee9URMsKgNatQu5zL95oU1kiC?=
 =?us-ascii?Q?fzcoqNACf7fcn6CjB1LAK8H/mYCNNBrsCCZhp78GVY4z+deUtjMGVKyRqtk7?=
 =?us-ascii?Q?uiIRIdEQPE3W5iHvPx3f54GQQz5OpX2mt2nEARNs+HJQiafmiKiUaUCmQDfd?=
 =?us-ascii?Q?to4XE970NgnSl1C5RLDJJxZaq980YN0d05IUvvEBWLclipfqRE60TtWpAhaI?=
 =?us-ascii?Q?mQ6ObzgbB/JXXFhixDdHBCqtVT96KcCoNkfIpAts8APHyDDfK4jpsDa3Qd9w?=
 =?us-ascii?Q?wZN/Y3IPgCQiOfgXKRAeHCQVkw8dgu3hu3bNVyU/b726W80LB7bgELBpkEUY?=
 =?us-ascii?Q?Wo2s3LTxuFKadUmSg4I70E4cjyVtifpbM++95naW/sCpilC4fna367v6q9wV?=
 =?us-ascii?Q?pRQ9sysTa7HZiLFZWxNvJ+1f9h1qd/cKo/y8JzSm0GrGY3N5hr9H1V/C11PU?=
 =?us-ascii?Q?88E3jnnvMTN5Fm+H6CTHNanFslNN1whUPG5Hk02tON7BfMchPnp84w/rall7?=
 =?us-ascii?Q?lPty/AdSyuEqMIoh+ToFH+CojBS+k8vjA+OyKUhV2YQCpxWV6qcggf581R0k?=
 =?us-ascii?Q?lzAgsjw6234zpzXMuLUaBEmxDWdUf2qa9bIrz4tU83JESkM3wg0NUUEIZvaq?=
 =?us-ascii?Q?UnExRDrOZFKz7jN2PgIghPQ1g1CV5vDkyBBme/4cMyr88aN1UoQE9+V9BaBt?=
 =?us-ascii?Q?0TtgxrzBXFEitWvT2NJYe07tyDe5AVB1i9tQwMMfRbO+10x2115pZf0TpqvJ?=
 =?us-ascii?Q?vMgn68jXf1YIimLHf4ym3j1dXI31FU68O+EznAuwFEK2vRLnVTjXhHFjhjqV?=
 =?us-ascii?Q?9g24NmqAXReloTw0kR767Zc1DX+fi9oVLdDs6o8kfwlH4HCCvVfJbEXlmWtx?=
 =?us-ascii?Q?I47VPPTFDvsu/IhqCStJjkobchTLiR+Pkzjhy8ut/2JgWvfzbmKsV9gEZfR1?=
 =?us-ascii?Q?SEvo+/7R6GGEkYdN9wLEJqbTLmhkIdfO2cnNMaRfM2UTgztdW11FNbpyLV2B?=
 =?us-ascii?Q?dZypGVBWq7HmdYrCxugvj8LJolgEF9Wq5gY4XvW7uWbFYOyuQkOCNDxNE1wB?=
 =?us-ascii?Q?aZXuo3YQSAzIIuj4tH8L+a7TOagNedElMUVm8mZvWtQj2FzaluADFQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q3xZfabHzpgI6t4cH+Dy0HaAYNxqJgGircf+1hD6z54agGeRw6tFjY9k0tMe?=
 =?us-ascii?Q?szyjfMtHSrEAS80JOBl8o6yBzblQKe28yeAKw9INvNVs/6ktQDnMTy4WzbAg?=
 =?us-ascii?Q?acAe5yebO1COVUxhIASlzumbZUi8U3m+lEfVeZQaHQ+3IHnuaySPI7qGvXdP?=
 =?us-ascii?Q?ZD+4ZOYiJUmAgPbg+CStv4Yc0MxDPwXb0+9L9qCYk2vdRwCDsHLLtdLmuAPE?=
 =?us-ascii?Q?ekY7twMMINswB/d3kAuf3cIwFm6nnzmkMKKCa3YVYKueNKQ3HCaRcYtzWHZQ?=
 =?us-ascii?Q?Xoqu5CySJh3ZKAekP+WVVe/iKRXoS/gsNnwozKZt6MLkH5c2HjdB6FfF+Ky5?=
 =?us-ascii?Q?yeMkN6T1xbBpVQXLvR9j1XvX8s0f0qyxkyFUCo63G/bIikTEa+xqp7UuA0RU?=
 =?us-ascii?Q?m0YqUavm0HHGjJrLnDYuDEFoRJuxSUdjEaajBBQFDdaNwxMolCQQkdlm/r2e?=
 =?us-ascii?Q?euNOx2c0svxrZYGBaileBOFUbxPsxATmdQNHiJVWobZr1IJqn8mpgPChEbi1?=
 =?us-ascii?Q?dUtAeA9Y5Z2dH2FtLhV40TqBt6N6141HCHddJe1yqPFxIYTtxFuDMj5PCLSV?=
 =?us-ascii?Q?O/p5N8uEjDoEtutsb1ZoydO1FTsv1gvEpzfdNiXsANmL9WqzuD+AQZwzmDn4?=
 =?us-ascii?Q?q0FSfxWau1lGfCxoCkyn+OhMy9Z37RWrKxrans3PmDmizV/XbRarvfLa6s7b?=
 =?us-ascii?Q?N8a6o0YkItCcdNhu+yR/logQslleU76uDn/Q4x91bihUMPdmAXjXeBZ66LsE?=
 =?us-ascii?Q?W2Y2rNbH5cr+pPsoBORkvsSR+r4Jw4o6P0bekwEdUCbdLbIsbbu97xNF11vG?=
 =?us-ascii?Q?f1qWU7F27HjiFNrgpxg9pBJLC3WPZm/lEoJkxG9Am2A8zbdbRXFvuVIXPNDr?=
 =?us-ascii?Q?qzCzVAJDoAZ1ey1jaP60QeWOo1tQ0ZWib/YKdMAJughbAOdAkEcEgopHGp0V?=
 =?us-ascii?Q?A0XvYRjBPhH4/I0eWFPpgNDIu+GK0Rhnl5uoxMbrd+1mvKToJhu1S8+lIeA5?=
 =?us-ascii?Q?soAyA3Gh0SW/g0oQFX6cq9wSejpcl7biW4UOBjQ+o4w0TqubFbyD00FE9jRO?=
 =?us-ascii?Q?cIyd82ryacn85bokmdQ2+TS707hRLHnentOvfTRZz/GUSHP8wlfvdD15MnMM?=
 =?us-ascii?Q?H0OYRMvwHlzAzyO72AIG6kL7n8njMbO4tKE92aFuwaMbQoc6bKkqLEvYxkVw?=
 =?us-ascii?Q?6Q0n6J1BVCmeBX3H8mC/NIxtf3hjT2rW0GWZlswDeD1G/hh+KRnnbmdOJ/lT?=
 =?us-ascii?Q?t4JihjlfaOPPsxcNFMtdS+1tWCrgcQH8nJLnMNfbakLy0zCiWaohFhjE3+Y5?=
 =?us-ascii?Q?czVom2kRgHA8lKjqsH2FHNQf+W2J6L1P+rl5FmEW2FdvIHTLnuZ69jMJA4av?=
 =?us-ascii?Q?39F6AuFdF5VKq3epQPYYuTBUniUmtMXk/RK9ZUiWp1toKXxZFKEII6WfQpf0?=
 =?us-ascii?Q?9jUWATVQRm754zGBBsvPDuq1e2cufCf6qCMhUk+tY/Qv++qJ1MjwyPEbRyIv?=
 =?us-ascii?Q?qxkI693wwv1cge1Z+U5QHa5AxRXMCGmYYg7ImOThKQiLi1dmSmKkkohvgsAq?=
 =?us-ascii?Q?6+oAAcwekvAWmPAI/WI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c8d21c-b9b1-47a9-c89f-08ddc8f012dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 07:19:19.0267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z26uBS18qPBJcApavzWaOZyAOHUekCf93rSU/lTpldi1Q3fTnz+q6icjQxo6HOA5x7fNOl/Y937eZFqx7xOfNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Andy Shevchenko,

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Monday, July 21, 2025 5:10 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> lorenzo@kernel.org; jic23@kernel.org; dlechner@baylibre.com;
> nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> manion05gk@gmail.com
> Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for=
 I3C
> interface
>
> On Mon, Jul 21, 2025 at 02:38:42PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wrote:
> > > Add a shutdown handler for the ST LSM6DSx I3C driver to perform a
> > > hardware reset during system shutdown. This ensures the sensor is
> > > placed in a well-defined reset state, preventing issues during
> > > subsequent reboots, such as kexec, where the device may fail to
> > > respond correctly during enumeration.
> >
> > Do you imply that tons of device drivers missing this? I don't think
> > we have even 5% of the drivers implementing the feature.
> >
> > > To support this, the previously static st_lsm6dsx_reset_device()
> > > function is now exported via EXPORT_SYMBOL_NS() under the
> > > IIO_LSM6DSX namespace, allowing it to be invoked from the I3C-specifi=
c driver.
> >
> > Why system suspend callback can't do this?
>
> Ah, and why only I3C is important? Doesn't I2C or SPI also broken in this=
 sense?

There is no device enumeration process involved for I2C and SPI, so they ar=
e not impacted.

However, for I3C, device enumeration does occur. During this process, the d=
evice PID and BCR/DCR values are compared against the entries defined in th=
e driver:

static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
        I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
        I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
        { }
};

Only if there is a match, the probe function will be called.

Additionally, the sensor reset logic is implemented inside the probe. There=
fore, to ensure the sensor responds correctly during device enumeration aft=
er a reboot (such as after kexec), it is necessary to reset the sensor duri=
ng the shutdown phase.

Thanks,
Manikanta.


