Return-Path: <linux-iio+bounces-24282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C3FB88897
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F1568142
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 09:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C72E3B00;
	Fri, 19 Sep 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="feNg21w2"
X-Original-To: linux-iio@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F482C0F81;
	Fri, 19 Sep 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273759; cv=fail; b=UD4RWjbV0ku/N+sqBZEf/Wjb1rIJEW4aKSHCgoGUyZalmOiVOwx8c6644HfsMI4ZExdhTSKmzm4vQ24NUkB2TqjNQEM3/YZRwrZe6vLFnDvoWvSbgE1PUF1VbTnr/XYSLqVSzD+Mvx3Ln9DpVtWlEPpGXS1YWrkcNGH6RNz4GYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273759; c=relaxed/simple;
	bh=/+aNw0j7VROPAZN2BHju16u+90hz+ikVggLaWWPpPkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pk0UrcLNEAswmgRGzmOyqeA/iNDlbMS0XqcjJRIHUxrPD4Vlh/l6L5E16advwWIvLGDIYaRINAzIlwujtI6Cua+rJR+Irn1/P2WXEv10IvL//FBeK0Au9P3R9Kyux6frjtSBJGG2s2g4PCjDD+W75jueq57H2bL3Sg3iuygKLx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=feNg21w2; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq7/TCcKABz3u5EyeVI84p8mwX3sQvKXesKXgwrJhsg3E2lAluRj+jbbo23WYiXmeFTHuR3TtLk3FU+r0Dvijoj2JAHNLKQIpizD4nbBDHSAhLuN7RIf09vw+0N9dMv7gorXWWr3/AIaZ12cs5KEOtGuZv/+EAqLv9EtEWaKSWcjKJtrTkFKnAFmfLQ1mSvva+dPt5X/+gtL6QEhMRZxY9pic9hiyaChoajyB1KR9Pg43k9o3jBIRx8hMqJLIaxMohRRkKQJgOEUtFb9ZSmBlVdcCsT/CfNwMRHqK/EtrXgIIlbxSFp6L7GHEy303JSwAnQYU21xxlF28uLhC+iYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3pCVUCiJr0kvWFSNLPTmLjZ7aUo+32iynLpERRZE7M=;
 b=kGZoJ6IAZnsjbvM+7kxDqE1eNOj2vL4gxiw2hX63dZOf4Gg5QNW9Rhqfq1H9/9atfjkFoYoZ3M0/SWAwjW62/kRy03lyRnalFxQr/ArbV6SNTqK98GPY/zi2xBUrpTAo5lhIrFKQmrKos/AZmV9qEZQZ3OuwwCOJtY8UPbqCBsCg7CoW5424msK2x8zKALgtWnQ5oXd6fqQbPpB8o+NW586ImtsiMIVUhCc/pBWH3w09nmR54c+Ke1IpKbx+VCv6Bv4gRZceYu8wti3qnf6H99xjj/ILmht4cI6uVfriDeM/lP812aCpS/KPnEyNCoz5nkwDUL0v7v3DD1H4+CD8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3pCVUCiJr0kvWFSNLPTmLjZ7aUo+32iynLpERRZE7M=;
 b=feNg21w2CqkaWv5cCA/6+h8vIwLeDxaVtXwTXKlJQbr/atq43asuHDZG86joBj2aKDGSuTkRsm7JhOtcwE1lDQn7OZuFx6Vmbc4OkAjnNh0GpwRvC4RNpnPELwPszJS2uRBorKDnI58BZMPcHw/yv5u1j5RyrJy9YljOot8pohw=
Received: from IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 09:22:32 +0000
Received: from IA1PR12MB6092.namprd12.prod.outlook.com
 ([fe80::6501:100:1d7:8136]) by IA1PR12MB6092.namprd12.prod.outlook.com
 ([fe80::6501:100:1d7:8136%3]) with mapi id 15.20.9094.021; Fri, 19 Sep 2025
 09:22:32 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Mario TESI <mario.tesi@st.com>, Jorge Marques <gastmaier@gmail.com>
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
Thread-Index:
 AQHb+i+8xK2s1GBMXUK4mOoG9AwzB7Q8c6QAgACdMwCAAK9QQIAAB8qAgAmwZzCAAaGzgIABJMYggDoMRICAFJpPooABr7+A
Date: Fri, 19 Sep 2025 09:22:32 +0000
Message-ID:
 <IA1PR12MB60927419E6B5D17332EBFAC08C11A@IA1PR12MB6092.namprd12.prod.outlook.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
 <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>
 <5pmqumpue7h4us265co6pya37434t4jvf3b655gtjcohlyhash@3ggx7e2maud6>
 <DM4PR12MB6109B8CCEBF5D334662E6CEE8C24A@DM4PR12MB6109.namprd12.prod.outlook.com>,<IA1PR12MB6092EC3ADBEC4032CF52000E8C03A@IA1PR12MB6092.namprd12.prod.outlook.com>
 <2fb3ffd8fbf54a6c960e25bce4613e5a@st.com>
In-Reply-To: <2fb3ffd8fbf54a6c960e25bce4613e5a@st.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mario.tesi@st.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-19T09:07:34.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6092:EE_|PH7PR12MB7988:EE_
x-ms-office365-filtering-correlation-id: 4e49ee41-8719-4dcb-fb3d-08ddf75e0ff1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Ssb8ZN5tqYvYD/K+fHiGxNcZormKVoNBhMkbkEQQZ3nfx2y4B+RXsiYIO3?=
 =?iso-8859-1?Q?wEDRoGQQ/yJAMWqZA3BXOSEkGmnn/mrihTmDbutev+ADVJICYMFuRXN5XK?=
 =?iso-8859-1?Q?wlHLR08eA8Mo9CS914YeBGCca8r9kuCzQ6zclxFq2wmxppn4uLz04aeh+5?=
 =?iso-8859-1?Q?R9mJrPyMHlrNlt/NZcAecKFvf2hk+4hZKARdYwySkzxvZAZBSKrs0LNZLZ?=
 =?iso-8859-1?Q?mdpjn7S83+Ym8LE0QDNDExLGCq8798kYJ+Eq21hOdsI8PzetGrhK+nzsbF?=
 =?iso-8859-1?Q?ULjDoW+EXbB61QvGSy4fbTGaaodEIX4zR52qlrTESUZI89WCMsItahwvVO?=
 =?iso-8859-1?Q?r9rej79lcPwQl+osKdgAYTzGNBCka5SJurdjYiHjmj0+lLdjs0ccKfZEH2?=
 =?iso-8859-1?Q?FHulET6SpB7sTEsdJfNO3w+yS0+NksZHRP/ckjYF94HIKSBWMvDqAouitp?=
 =?iso-8859-1?Q?2U67f0b0NaoYZmeO3STx0eHqAs6bEtNGS2Yq7nskJIUCdrP8AokmgapWk/?=
 =?iso-8859-1?Q?pNlSQzNeEl0dC0I3g4aK/40f54hpR34rKKFcs/y5+ekVvb/JJnd87G2rX5?=
 =?iso-8859-1?Q?H6s26yGxHaf7FeeR9e+GvX7Z44sHNFFDcT7+xVIG03amDYWUAuGku/FhFm?=
 =?iso-8859-1?Q?E/8WKqbZuTiQc9engccORslKif8Ij3pF98n9M0A0wK8etXGBZPbRNPvbl+?=
 =?iso-8859-1?Q?9W8ti09bNXIqQQKL3i5EgzlkzLQO9h1Yjbb9qf76befUsrEiQiAw0jnFSQ?=
 =?iso-8859-1?Q?EfzmTYN5ataL+TYWj410vj18jNPMgjPepTPNlC1AagPX74v61LUHIdNKsA?=
 =?iso-8859-1?Q?ZOao7d1ImEQeo0W7S/Vqzz6+jq/MzpPJTNRkIAcIV+vn0l/ae0pcDLtsSR?=
 =?iso-8859-1?Q?qWUrgKyQWb7RIeEqy2odl8MqQSO2FRK0FZ8axXQ49dNE37yONEWa+dYXvF?=
 =?iso-8859-1?Q?IjmTK0qA4GwT6qWsibJOob+xnw3MlQKZmRt4zBzfVdECGcKyefCjN0az7W?=
 =?iso-8859-1?Q?b2+WdmPWfSf948l/9LTTo9zy6q2HKF/Mmd78NJbNiK5azB0aBRT/UyVhx7?=
 =?iso-8859-1?Q?FWa75bD5eZhKlalOVvkU9yvaxLTaRuublKlDxxbIfe0n+0dzfupZljEoqS?=
 =?iso-8859-1?Q?e1Vh7fO5Pni7dgYriB0t0NZRscPowHPxBg4BmU+vSdqYrmZqD+Sx9dHVSL?=
 =?iso-8859-1?Q?lcJiSJxxj3+IXoZ8A42ecP6NKliTGbazCf4LNb6sp8wnAH21WDCr3w3AKU?=
 =?iso-8859-1?Q?KWscPFJ5sSR+Kgj1De1jg8yOpxkv6eZPUffTtvvFGoHoyc6pSV0sRdPnTq?=
 =?iso-8859-1?Q?LR8VqxygzJV3pH+uwTnS0O2Mj2UTzYNMHFVIqewyY5X0yeo5PwwmzTbRla?=
 =?iso-8859-1?Q?JaixauEw277heKTEaPsoM9t0eBjIc2M2qkKEAIk3N51Gcu+NVGi4sHaVJt?=
 =?iso-8859-1?Q?tT14y2korKQs2eCu+nG6a+o/WO7TnqyWRsMyPUGE5j3Dsh8pebhNlUaAkO?=
 =?iso-8859-1?Q?xsrrLbMYUHS/sxypoS3WL86urSMXEiacEe0oj3d7GTeg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6092.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nDqY90x6nz1LmYeTlosSvgMrXjVouVCrSnthdIoyrSKpfMFEBtx/CqkUdK?=
 =?iso-8859-1?Q?1nAZZe5a4imJ0hd3lkwHXQb6rItHqu5Lj1k0PnE/ObD0rZdSazOFKYhSdf?=
 =?iso-8859-1?Q?+pwzPUVPOd8mHK4AzcxkEgS3BK69o7H0luh6zE5VPmI4DOS3NQJfabF7m6?=
 =?iso-8859-1?Q?pE9PW2+JO1IK/QeHi8MTycQth8ZHPWraXeewrWJ5tkyC0ZIrQdsheC9vSh?=
 =?iso-8859-1?Q?ccwoZAGS4IEs4uTxCBrgINZ/XT7mJn8WV+xLG0ajcTYwffMHObXUEsgAqL?=
 =?iso-8859-1?Q?5+1+vYHOUkbMAvmDyy/CynfkW9IKGzgV8DEHSpUlG1a+R+v2tAycXHWbpy?=
 =?iso-8859-1?Q?jydR2rU8rYup7IR82khACfX1qFmO17mxZCEyT8yvxi9x0T+xj9uctq3Ewl?=
 =?iso-8859-1?Q?Vn59hHY+n/ka4TEIDH8unOxRZebb46JUBEM+rAA2EfwLK9u0jnd/W9jfzh?=
 =?iso-8859-1?Q?6bpvEHYWu9k14nKUU2DpzF4NglG6Q5kIZgFe1mhrGPrlBzh/8TGPPgfwFA?=
 =?iso-8859-1?Q?XYudycTuv8idYyerP3ft6yRRPNCck4eZkTb7tzn6yGUBswwJQaho8X52Mv?=
 =?iso-8859-1?Q?SQK7ug6pLl4XsFPILc4Rk7TqdovzGRkz7cr8GnvgQ+8wq9dzNMLd6N/Q/l?=
 =?iso-8859-1?Q?5NzKvw57sI9Q8JTMd2gfFqQrTfBUuYATj9Q7Tt9FZIk4Hadmaxxu8U5iwD?=
 =?iso-8859-1?Q?pvB8jM+jfwf9uBufxmKFss0vefuTPSvbHg8WY0pB2uoA+KncPkGR3wqli2?=
 =?iso-8859-1?Q?doIqH9FIXojzQ2+qcnyZaUuVBbcFqsZ0T9SeLOK32Ug/iXTSFsb7/a/Hxp?=
 =?iso-8859-1?Q?DWSH7Y0qrg2j1QjWV11LHSSApfv0e61SC2pccGgdXqOtdN29rSxdBenTja?=
 =?iso-8859-1?Q?BIenyZUdAYDPnAj+u9s24t2nzoDU2xnPzSm4oJIfghCXp0SsJCG7vGvM79?=
 =?iso-8859-1?Q?M4+D+OzTzFs6mSI7+8KW2kMc3N0eNtQknQgnJhPSyd48acirqzA70gUrBS?=
 =?iso-8859-1?Q?o7/6YKmaer+gAwPeykwy7A+KsMqIUg/U0oSUxhviXQIxj5gMnJS3SNv10A?=
 =?iso-8859-1?Q?bMVD6wIompHheuIpWGRsSDgFvF3rSqwIhPR19tDvda6YXr/p9zHruW6JDF?=
 =?iso-8859-1?Q?QsuiPVpaXh4IkQddPA/zaE+rxmLKYcDCkjaCya34UODRRXPl116BJS3I2l?=
 =?iso-8859-1?Q?np5RoDvXEsvOxJw/x2MaQqAgiITJl5UYBFEYfIpzoa3v44RgmeGnqUpMNl?=
 =?iso-8859-1?Q?3DSxYr3nMMg/qTtuQ7Fx+wNutF2sij+sJYtLBcK2opgNaFhb0JjSjk7nOa?=
 =?iso-8859-1?Q?cCBukZB1D5lRUykQkVUsg2YrQhwTyDv+8XHzIlaYwICmKHQYlBc9sInsSB?=
 =?iso-8859-1?Q?rnBrYDLoqbe5ZPQUdmsDwWS6omAsgkWjbMOk6uFfgNHrKvKuvsThxBRIFo?=
 =?iso-8859-1?Q?tH2FbdvxJByraKhvZb52Wscq54mgKXdIwcwHELBqR5CsWEr8yTzDWVqsqV?=
 =?iso-8859-1?Q?W17fXd99gzQbZk3/SU2rehiK3nnkbmegkpwIhStkQZH6TPab2U80iC4i73?=
 =?iso-8859-1?Q?C3royG7BJFwJ8PVLywbZpcnAgDvGyXDHR0qtcVQmMqn2Q5sfBD57LnFKcU?=
 =?iso-8859-1?Q?r2M1cdZUh13ro=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6092.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e49ee41-8719-4dcb-fb3d-08ddf75e0ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 09:22:32.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DddxwGN2dZKtyN7GiO3MScK1C1wK3Db7VmJRmCe8kS5A8plwflIwE0u9k5e+FjBi7A3LqN0skfBHmR9DPw00YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988

[Public]

Hi @Mario TESI,
Thanks for the response.

We don't have the flexibility to provide traces or register dumps. However,=
 the issue is straightforward to reproduce with a kexec reboot.

On the first boot, everything works fine: the sensor responds to the full e=
numeration sequence, including RSTDAA to reset the dynamic address and ENTD=
AA for assigning a new dynamic address. At this point, the sensor driver pr=
obe is called successfully.

On the subsequent boot via kexec reboot, the sensor driver probe is not cal=
led because the sensor does not respond to the enumeration process (RSTDAA =
and ENTDAA).

When we add a software reset in the shutdown handler of the sensor driver, =
the sensor once again responds correctly to RSTDAA and ENTDAA, and the driv=
er probe is called as expected during kexec reboot.

Note: We don't observe this behavior with other I3C devices, which helps is=
olate the issue to this specific sensor.

I hope this provides better clarity.

Thanks,
Manikanta.

> -----Original Message-----
> From: Mario TESI <mario.tesi@st.com>
> Sent: Thursday, September 18, 2025 12:53 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>; Jorge Marques
> <gastmaier@gmail.com>
> Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>; Simek, Mic=
hal
> <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> manion05gk@gmail.com
> Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for=
 I3C
> interface
>
> Hi Manikanta,
>
> The mainline lsm6dsx driver supports several IMUs, but on the I3C bus, it=
 supports
> two: lam6dso and lam6dsr.
> This is very strange because the software reset doesn't reset the dynamic=
 address
> on such devices; only an RSTDAA or a power cycle can reset it. Looking at=
 how the
> I3C master works, the first thing it requests during the probe phase is a=
n RSTDAA,
> which is sufficient to reset the I3C address. Therefore, the IMU sensors =
should then
> participate in the new assignment with the ENTDAA or SETDASA command (in =
case
> of assigned address). The software reset you perform during shutdown like=
ly
> deactivates the sensor, which solves any issues that may exist with the v=
arious I3C
> drivers (many of which are under development or debugging). It would be i=
nteresting
> to evaluate the I3C trace when the issue occurs and also a register dump =
to better
> understand where to focus.
>
> Best Regards,
> Mario
>
> ________________________________________
> Da: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Inviato: venerd=EC 5 settembre 2025 07:29:18
> A: Jorge Marques; Mario TESI
> Cc: David Lechner; Andy Shevchenko; git (AMD-Xilinx); Simek, Michal;
> lorenzo@kernel.org; jic23@kernel.org; nuno.sa@analog.com; andy@kernel.org=
;
> linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Pandey, Radhey S=
hyam;
> Goud, Srinivas; manion05gk@gmail.com
> Oggetto: RE: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for=
 I3C
> interface
>
> [Public]
>
> + @mario.tesi@st.com
>
> Hi @mario.tesi,
> We are observing an enumeration issue with the LSM6DSX sensor on I3C, sin=
ce
> enumeration occurs only there. During a kexec reboot, the LSM6DSX does no=
t
> respond to CCC commands during enumeration.
> Adding a software reset in shutdown() resolves this and allows enumeratio=
n to
> succeed.
>
> Could you please confirm this behavior of the LSM6DSX on I3C from your si=
de ?
> Your confirmation will help us decide whether to proceed with just the so=
ftware reset
> in the driver or consider additional steps.
>
> > -----Original Message-----
> > From: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > Sent: Wednesday, July 30, 2025 11:58 AM
> > To: Jorge Marques <gastmaier@gmail.com>
> > Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> > <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>; Simek,
> > Michal <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> > nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > manion05gk@gmail.com
> > Subject: RE: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support
> > for I3C interface
> >
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Jorge Marques <gastmaier@gmail.com>
> > > Sent: Tuesday, July 29, 2025 6:19 PM
> > > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > > Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> > > <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>;
> > > Simek, Michal <michal.simek@amd.com>; lorenzo@kernel.org;
> > > jic23@kernel.org; nuno.sa@analog.com; andy@kernel.org;
> > > linux-iio@vger.kernel.org; linux- kernel@vger.kernel.org; Pandey,
> > > Radhey Shyam <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > > <srinivas.goud@amd.com>; manion05gk@gmail.com
> > > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback
> > > support for I3C interface
> > >
> > > On Tue, Jul 29, 2025 at 12:02:56PM +0000, Guntupalli, Manikanta wrote=
:
> > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > >
> > > > Hi @Jorge Marques,
> > > >
> > > > > -----Original Message-----
> > > > > From: Jorge Marques <gastmaier@gmail.com>
> > > > > Sent: Tuesday, July 22, 2025 1:27 PM
> > > > > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > > > > Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>;
> > > > > Simek, Michal <michal.simek@amd.com>; lorenzo@kernel.org;
> > > > > jic23@kernel.org; nuno.sa@analog.com; andy@kernel.org;
> > > > > linux-iio@vger.kernel.org; linux- kernel@vger.kernel.org;
> > > > > Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Goud,
> > > > > Srinivas <srinivas.goud@amd.com>; manion05gk@gmail.com
> > > > > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback
> > > > > support for I3C interface
> > > > >
> > > > > On Tue, Jul 22, 2025 at 07:32:54AM +0000, Guntupalli, Manikanta w=
rote:
> > > > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > > > >
> > > > > > Hi @David Lechner,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: David Lechner <dlechner@baylibre.com>
> > > > > > > Sent: Tuesday, July 22, 2025 2:31 AM
> > > > > > > To: Andy Shevchenko <andriy.shevchenko@intel.com>;
> > > > > > > Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > > > > > > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > > > > > > <michal.simek@amd.com>; lorenzo@kernel.org;
> > > > > > > jic23@kernel.org; nuno.sa@analog.com; andy@kernel.org;
> > > > > > > linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > > > Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Goud,
> > > > > > > Srinivas <srinivas.goud@amd.com>; manion05gk@gmail.com
> > > > > > > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown
> > > > > > > callback support for I3C interface
> > > > > > >
> > > > > > > On 7/21/25 6:38 AM, Andy Shevchenko wrote:
> > > > > > > > On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta
> > > > > > > > Guntupalli
> > wrote:
> > > > > > > >> Add a shutdown handler for the ST LSM6DSx I3C driver to
> > > > > > > >> perform a hardware reset during system shutdown. This
> > > > > > > >> ensures the sensor is placed in a well-defined reset
> > > > > > > >> state, preventing issues during subsequent reboots, such
> > > > > > > >> as kexec, where the device may fail to respond correctly d=
uring
> enumeration.
> > > > > > > >
> > > > > > > > Do you imply that tons of device drivers missing this? I
> > > > > > > > don't think we have even 5% of the drivers implementing the=
 feature.
> > > > > > > >
> > > > > > > In the IIO drivers I've worked on, we always do reset in the
> > > > > > > probe() function. The
> > > > > > > shutdown() function might not run, e.g. if the board loses
> > > > > > > power, so it doesn't fix 100% of the cases.
> > > > > >
> > > > > > Thank you for the input.
> > > > > >
> > > > > > You're absolutely right - shutdown() may not cover all cases
> > > > > > like power
> > loss.
> > > > > However, in scenarios such as a warm reboot (kexec), the situatio=
n is
> different.
> > > > > >
> > > > > > Before the probe is called in the next boot, device
> > > > > > enumeration takes place. During
> > > > > this process, the I3C framework compares the device's PID, BCR,
> > > > > and DCR values against the ones registered in the driver:
> > > > > >
> > > > > > static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
> > > > > >         I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
> > > > > >         I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
> > > > > >         { }
> > > > > > };
> > > > > >
> > > > > > Only if this matching succeeds, the probe will be invoked.
> > > > > >
> > > > > > Since the sensor reset logic is placed inside the probe, the
> > > > > > device must be in a
> > > > > responsive state during enumeration. In the case of kexec, we
> > > > > observed that the sensor does not respond correctly unless it is
> > > > > explicitly reset
> > > during shutdown().
> > > > > Hence, adding the reset in shutdown() addresses this specific
> > > > > case where the probe isn't reached due to failed enumeration.
> > > > > >
> > > > > Hi Manikanta,
> > > > >
> > > > > During i3c bus init, the CCC RSTDAA is emitted to reset all DAs
> > > > > of all devices in the bus
> > > > > (drivers/i3c/master.c@i3c_master_bus_init
> > > > > -> i3c_master_rstdaa_locked). Is the LSM6DSX not compliant with t=
hat?
> > > > LSM6DSX is compliant with RSTDAA CCC.
> > > >
> > > > >
> > > > > I get your solution but find odd to use the same method as in the=
 probe.
> > > > > In the probe, you would, in general, reset the device logic, but
> > > > > leave the i3c peripheral logic intact, because you don't want to
> > > > > undo whatever the controller has set-up for the current bus
> > > > > attached devices (ibi config, da, max devices speed, all the good=
 i3c stuff).
> > > > > For this device, the st_lsm6dsx_reset_device seems to flush a
> > > > > FIFO, do a software reset, and reload a trimming parameter;
> > > > > which are necessary to solve the bug you are observed?
> > > > Only software reset necessary to solve the bug.
> > > >
> > > > >
> > > > > If possible, please explain better why the device won't
> > > > > enumerate correctly after a reboot without the reset. If it is a
> > > > > device bug, explicitly state that and that it is not compliant.
> > > > > Also, take a look at fig.100 of the
> > > i3c spec basic 1.1.1.
> > > > >
> > > > > Thank you for looking into this, this type of corner case is usua=
lly overlooked.
> > > > It appears that the sensor device is entering a deep sleep or
> > > > low-power state and
> > > is not responding to CCC commands. However, after a software reset,
> > > the sensor starts responding to CCCs as expected.
> > > It should, from the silicon pov, definitely respond to CCCs, even on
> > > low-power
> > states.
> > > Could you confirm with stm32 the behaviour you are observing?
> > > Inform them if it occurs under under i2c/i3c dual support, only i3c, =
or both.
> > > It sounds a little the messages are being filtered by the spike
> > > filter when it
> > shouldn't?
> > > >
> > > > Shall we proceed with only the software reset changes along with
> > > > an improved
> > > description, or do you recommend any additional modifications?
> > > Confirm if this is a silicon issue first, if so, a note from st shoul=
d be issued also.
> > We are unable to verify the behavior on any silicon other than ours.
> > It would be helpful if someone with access to a different silicon could=
 confirm this
> behavior.
> >
>
> Thanks,
> Manikanta.


