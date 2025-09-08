Return-Path: <linux-iio+bounces-23882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A4DB48BDE
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 13:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5B617A145
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6A3081CF;
	Mon,  8 Sep 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1orCNWbG"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3D302148;
	Mon,  8 Sep 2025 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330044; cv=fail; b=T2LzfGKSlscKwwyxD3KBhYnRtwewO6Kg3nNEjb1eu0/6MSlFcrhy47B/vMfHuROvQ5ZOlNe+J0kMl08YdDWrpynHb9UkKGdMt9evqeG33OmeqGbnGb4WfO/nUoqk2poLc8nI3/qnzFK6x5oU+IWJ+oZ/kjdQzbSxX7OM+Leg010=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330044; c=relaxed/simple;
	bh=30krfiUSsyuEZ3PpAk41KdSF2NBqLSMKQPAaAKXpCFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P5wI7sdw0ZnL0D+R/60zE2YyHTLpo4GlJb9oZm7MWOg4oZk7GBO/AdkbMmavQOpN8qVXvaYck8BvE2CgLhtK4KI0U1uSPV6Y3lIaxh+uAfQwUWOcDyi/g4DzaV1BboKZabPFwOXPN4lOS3mSwNtXleKx0ULRJaol/LVtLrkVzsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1orCNWbG; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGxMvx9dGRFyox800EzY9+FEUjzxn8Ptktp3xoXA/9xSDWRJbEbym7tHFyLN80eoHP3kAEf3bp8eynbK5CIRQGbn+d4NlWGW187pfy0itMvuTxDVyhhTEoZk2Jk86rc6wn+4D5QVfv139z3mIV5XUQpxeRhRGokoFgqHIOpybZWq0YiF7LkqWCGSG60GjlLQy9zdPxT7fsCBnZsSe8vYh0qZB3yhKqyrgq9pELKvaAFSi0h1keJI+DxZ1K1IF065LieqdZvAVlAWp//RdRfRdx/yFEKVqdDx8KhILStt94igP674+8RGRgTg5CkWBBBBaqGpEAlSPlW6IpTJKKi8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNfduKTBLzEtlU2Mk4KYFYDDK+chQdphQFn5rEHY0Eo=;
 b=MiuYiF/KuU6WTKvgRdehui8IdBD0L6OcLfONd4yz3yHg4ctMuJ/x1ifbf5aTVTj3lvYgYQNwXotFlGE9hJQTKQxbgH0PoDsf1iSyKG3+OjL5NBfUEc/EgMvn5SfBRZvGTz10p72JspekZKz5PEPPmnh/ys9qIdxtyqx620eOqpTPHiJeGd0oC/3FVB2ZFqmTuyXG7ty4xlEjM+A4uFA3k+SyV/75Gv5yuDirnsDrEWbRfNuBxi0XTKaLAdUz+4Qy0ewyjJz1kgu4tE0fVHUTKLOEqTRZiDhPT3paqcwC7dInSWcQBLt2wD7Rhh3K4wh80ji8U3mDV5er+vR/hvPNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNfduKTBLzEtlU2Mk4KYFYDDK+chQdphQFn5rEHY0Eo=;
 b=1orCNWbG1gblpA6nI6YWIdguNleM8ro2KrljpR9qD10gj8k/9StByizS6vCIu8e4dWrF8x5Sa9I8q+fqFxv9w3HnuJGivj8hwMWa2G2CAJRr9fRDo9Zv31o+ZSEuCx2jMVfpBJv3B0MZwnZFzfXCv9RlNg/DYN3H5n+lvRRhOfU=
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:13:58 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::af21:b877:699d:43b0%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:13:58 +0000
From: "Erim, Salih" <Salih.Erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
CC: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>,
	"michal.simek@xilinx.com" <michal.simek@xilinx.com>, "git@xilinx.com"
	<git@xilinx.com>, Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	"Kadamathikuttiyil Karthikeyan Pillai, Anish"
	<anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>, Andy Shevchenko
	<andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for
 Sysmon
Thread-Topic: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for
 Sysmon
Thread-Index:
 AQHcHkD8jMtoPjo/1UafQBuEC5tFH7SEdFkAgAAQrgCAAB6IAIAAa6QAgAJ+64CAAZaYMA==
Date: Mon, 8 Sep 2025 11:13:57 +0000
Message-ID:
 <IA1PR12MB7736694ACC2207E7F7A630D29F0CA@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <cover.1757061697.git.michal.simek@amd.com>
	<610690b9cc4ab3854b56df550b688b4cc72a5653.1757061697.git.michal.simek@amd.com>
	<20250905123006.000031a9@huawei.com>
	<5f21169b-39b8-4fcd-b7d7-e5bcb1885549@amd.com>
	<IA1PR12MB7736D056E505103AC246DC2E9F03A@IA1PR12MB7736.namprd12.prod.outlook.com>
	<fec12cd9-4709-42ca-b0e5-38f67b63a41c@baylibre.com>
 <20250907115107.03aeb8d0@jic23-huawei>
In-Reply-To: <20250907115107.03aeb8d0@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=83c15428-cfd5-4f2d-a165-20f38be54d5c;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-09-08T11:06:43Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7736:EE_|BL1PR12MB5753:EE_
x-ms-office365-filtering-correlation-id: 7f116e44-6506-4a22-9440-08ddeec8ce61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?P9d690p6R7f8ldXH2EMCY0wzzvYqbiR4WhB+XQHC/Z4tid2RKfbUNpzQSc?=
 =?iso-8859-1?Q?Q9bV8PV5RIVOUIretr5hypA2kwm5UkSvTWIZsY9iGNYrUuX4bvqXG6DWhV?=
 =?iso-8859-1?Q?fmPdjcolRqyXz+5v592NEzzappwDF5NoWd5Xkm4JLeJzBR2NSXrla9Xrqp?=
 =?iso-8859-1?Q?B9eKffADUoB79QjQdFUXzaVP3XsbFvqytu3wZh4oTUQLImQaNISo+RulXU?=
 =?iso-8859-1?Q?QrsjUV4jRZRgWS5ucaBKxU//9fFEykMf2/Y1Q0R3RqPND2VKeK5MJthAeM?=
 =?iso-8859-1?Q?E7Kuv140J8AbnW9AVQxM2XxMtdA86BMTowweXsU5QDiKDT0nmp3ft76663?=
 =?iso-8859-1?Q?abqZcduA+kxTGHCnZzopK0WASFWYnxvgSa0nudkRdnZYdw7RSIqKDCieB+?=
 =?iso-8859-1?Q?w6KPnWo9tKO7FePvXwUwCGK1ldTMQbodeuNADkmh0anDttKnLj1hCHshLl?=
 =?iso-8859-1?Q?JR/NduXbRdh8pfoT0Rqez064XbMd4oaTuL1Hm7b1YPlZB9jnNscCIb9k5G?=
 =?iso-8859-1?Q?2ltMMz20m2fMIV6zdpXv5tLNdo0n1g2ArvxGtCkEBb6eS8iD0nEHDsftLy?=
 =?iso-8859-1?Q?0/1mTdw3oJuqwWEuniI4bVUE9y2nSkyWj+As2+xy1jPv98EaPywzLOoci0?=
 =?iso-8859-1?Q?10VHqhiwgSuwx3n3gL01NhYOp8pC13vuHBVeusQgItsNEqPY4iaBFjWk5+?=
 =?iso-8859-1?Q?wKJmdnfAsYUi5daWMhYmHC3clQqlZP0ztTwCvp86QwOXGISGWvbxCTlpGm?=
 =?iso-8859-1?Q?CVAB04SpbMJMdbiHGlIxT5xx5t63Mz0EgmycDKYT4G/YJ7PX+cM5ei2g4B?=
 =?iso-8859-1?Q?ZPxjOmT2594C72Pg7AsnvZDewBQcBy7VdadroP4Pcp7kSFv0yPJV8b0fGd?=
 =?iso-8859-1?Q?CjCpfBfJFVxt4GNLjvEIV7e1mST8eGpF9xVIIdvCdd0hbwMJykA/B81HA4?=
 =?iso-8859-1?Q?MipN4fkiAqOJf+zfXplQk87lk6k4XDUBDMLNIIl4SNvun9ehEDXSMsGJ2F?=
 =?iso-8859-1?Q?nuNbUayyarkWotSNLUKadCYGUgvj0+ddPyGIcdxblSTijBNlXXcV80ZmRt?=
 =?iso-8859-1?Q?KFjf/I64+xqd9Q4BlbwLpYVHXZfXWoRzTC2fMuQ1+OI+BWTpHh9Fiel3IU?=
 =?iso-8859-1?Q?SVQ5gEomomI75sTuwkBuw2IOwrNdGQzNXji0ANWMoXQS6GUgqvRQXuwdIm?=
 =?iso-8859-1?Q?XH7TzbPzZVhaCc3vEIxaeBDq7tWLsCtaaYLLd8/YxpupUWihd1lLHI+tZb?=
 =?iso-8859-1?Q?1DY1o79MstaUstJm/o84+rZ7qgHPfXZ9IQWlHc/SiK9uFauwh43SAia1Or?=
 =?iso-8859-1?Q?5BoSi+lqiNZpWcz+RjPdDlhQ26n/Hqs79TrLCoC/vPPJ2h/sHD5I8aHgGB?=
 =?iso-8859-1?Q?4jwuLFsXtlby1GjuqPFFy1Ba8RnsyeajI40DGDpdguvZO647bRAjv6RC7N?=
 =?iso-8859-1?Q?QScGnDgi2V+jk3gkuYCTNN3DgBULGYbjQddhWK8UbgmiwkwbRQ/wQaLimV?=
 =?iso-8859-1?Q?Y71h7MDV09oUdv7CALkw/p5BROaUoPKN+HlO4fJJW1Rg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DBrYlPbLFWja81AGwL3KA+DA8LmenB2rN0qsm8eTYvbvnwQiLMg+ZzHgSb?=
 =?iso-8859-1?Q?GqT+c7PGw1fMiHH3pvVLt5tjGjlHIOI1RCJNE7HrUvZoXocVayLocQASVZ?=
 =?iso-8859-1?Q?q3oq1fv+sQhRhJdXfy5hmjGv/lOhoRPHeGYQuzYrtlrR3/IBgu8oOxcjqj?=
 =?iso-8859-1?Q?apL9Yw04FVojxSksISB97s6RD/l0uAyEMU3t8s0pPRyYRYO8CsHhp7wQOw?=
 =?iso-8859-1?Q?GpVUOcO399K9tE2tkyfbLL3/5lyEFCdCCxo8bI+CR4utIfTaRjvztskdG/?=
 =?iso-8859-1?Q?DvgTl8rZas4JqHdMkv3S44AVwdgMQATuCKfVoo6seKfEEAf5Cn2TYQBAlA?=
 =?iso-8859-1?Q?BJ/3hA8iSGOIxk3Fe6AfJm5MnFlIGJnNykfMybfEBJI8O3gh3uuz9SeX3O?=
 =?iso-8859-1?Q?VNA0Y8kqFfXmCVoT9Wu/mFDKbsRemdPqtUabvBSLDL7TFuhMBgabIkhi4i?=
 =?iso-8859-1?Q?dOm9lQ6MPTsyPuObxumy0fRq5Dwxd6UUuXYMiXIB1txu7RDoXpKJG78uB4?=
 =?iso-8859-1?Q?LW0FvnCy8ZFURmP28GhdmY7TFqbaPPSv4f4ObZGhxAb2or42rtpuHCGCWe?=
 =?iso-8859-1?Q?elisliwhwFJBwNcrgcJb7uJ60BmGsxIIPqY2sfP6KGTA0+qt7ZenmKtB9v?=
 =?iso-8859-1?Q?NAFCJBo90Deh5pDAJr6/Gxj1AYJFBKinSbq/SBQNP6Z2bDIUchK0EwBHh+?=
 =?iso-8859-1?Q?h1qIS+mWCJs4jyhRX0/+yqae9F8VMS9rpA3tuyeN7dnc68fPAy6yf15deK?=
 =?iso-8859-1?Q?NDl4sdgy9s5UlabHk2aNbbLvY3XBtxC5YfsksWOn+6GcHwdr5ZUSOiEuU/?=
 =?iso-8859-1?Q?QJ97V9CuiqogpiYLgXwjHxL+/dBusmC3pecM2lo491iwUYseWOFrIeBY2B?=
 =?iso-8859-1?Q?OlAWEd7HyZIW7DuPy7u4dRKu2xOB0vTUIDUsk0GLatwJyEB3QmD0g3uHSz?=
 =?iso-8859-1?Q?mRRmGMFgj3INk1ZEb17qXCd0Iw+BSRvVkCAd+odn/5roalLwjrpsvXhTjP?=
 =?iso-8859-1?Q?XbC5L9kUzstA+yRTrjy3lKURgjWRPASRZ3P9l9ypSvrufTLXFxhsicU426?=
 =?iso-8859-1?Q?ArcHoUMQ8ssssaMXwfnZe74IPPkjLQ4NlKvgqOFeWdlnegS48MwE4NsYkF?=
 =?iso-8859-1?Q?JRch1A16kLxXv552brp82Fb4djtBRWzo8d1IuEIs0f4G2O0Q50aK++DX8r?=
 =?iso-8859-1?Q?wMRbqaR/1iztp92k8DiJ4BruvRAWsy73YPjzaFx9hvI0ztNkd/QLfSx9iY?=
 =?iso-8859-1?Q?s+Ac/H6lk8o98hpnItyts80XUcF5JU4jpIS7M7tRyty3eoIvmTJ4KuY7iT?=
 =?iso-8859-1?Q?MmPHpBL5U+AOetUBrr5EhgEZF9DQhQGnn92jssKpF/kybKTDFGCdbn7jwU?=
 =?iso-8859-1?Q?e4L/PS0jCVG2oZQUvGj/iPFK6+r21wxdQvsgZ72ClAanFFjnvK8TArk0SZ?=
 =?iso-8859-1?Q?ATKIeG4igyjg5+iRnnqQOwsSBr7eCtX/GblqkDsvDiijzQXC/kCIzOPyvS?=
 =?iso-8859-1?Q?cKqdDGRRBqF6NUFvbv7O3g9akzujD+2uUNE0wGRYAzK8hWFY7aQ/d3/mqc?=
 =?iso-8859-1?Q?/oa/F++tBJj/aibCqtXGA2bRMBuKB38t0kjGGlGGn7wv7eD9kjlZj7JWz5?=
 =?iso-8859-1?Q?tGIq/L4VCO+sA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f116e44-6506-4a22-9440-08ddeec8ce61
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 11:13:57.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGrTFEcC3UA39Wqojij8e/c/9fEWwEFfzQ5ymRseq9Llsk5BoRRPfHmgE1kwrpVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753

Hi David and Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, September 7, 2025 11:51 AM
> To: David Lechner <dlechner@baylibre.com>
> Cc: Erim, Salih <Salih.Erim@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; linux-kernel@vger.kernel.org;
> monstr@monstr.eu; michal.simek@xilinx.com; git@xilinx.com; Anand Ashok
> Dumbre <anand.ashok.dumbre@xilinx.com>; Kadamathikuttiyil Karthikeyan Pil=
lai,
> Anish <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>; Andy Shevchen=
ko
> <andy@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Krzysztof Kozlowsk=
i
> <krzk+dt@kernel.org>; Nuno S=E1 <nuno.sa@analog.com>; Rob Herring
> <robh@kernel.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE
> TREE BINDINGS <devicetree@vger.kernel.org>; open list:IIO SUBSYSTEM AND
> DRIVERS <linux-iio@vger.kernel.org>
> Subject: Re: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for =
Sysmon
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Fri, 5 Sep 2025 15:44:20 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 9/5/25 9:21 AM, Erim, Salih wrote:
> >
> > ...
> >
> > >>>
> > >>>> +
> > >>>> +      xlnx,bipolar:
> > >>>> +        $ref: /schemas/types.yaml#/definitions/flag
> > >>>> +        description:
> > >>>> +          If the supply has a bipolar type and the output will be=
 signed.
> > >>>
> > >>> This is very generic.  We have it described for ADC channels
> > >>> already in bindings/iio/adc/adc.yaml.  Why can't we use that here?
> > >>
> > >> no issue with it.
> > >> And likely
> > >> Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > >> should deprecated it and start to use new one.
> > >>
> > >>
> > >>
> > >>> That binding does rely on matching against 'channel' for node names=
 though.
> > >>> Where a 'type of channel' has been relevant IIRC we've always
> > >>> added a separate property rather than using the child node name.
> > >>
> > >> Is this related to supply/temp channel name?
> > >>
> > >> I think one issue with the binding is that current schema allows to
> > >> define
> > >> supply@1  and also temp@1
> > >> but both of them have reg =3D <1> which is not allowed (duplicate un=
it-address).
> > >>
> > >> Salih: What does this reg value means? Is it physical address where
> > >> that sensor is placed?
> > >
> > > Reg is offset index to offset base of the memory addresses for each.
> > > Supplies and temp values are located in different offsets.
> > >
> >
> > Sounds like the .dts should looks like:
> >
> >       adc@f1270000 {
> >               compatible =3D "xlnx,versal-sysmon";
> >               reg =3D <0xf1270000 0x4000>;
> >               ...
> >
> >               supply-channels {
> >                       #size-cells =3D <0>;
> >                       #address-cells =3D <1>;
> >
> >                       channel@0 {
> >                               reg =3D <0>;
> >                               label =3D "vccint";
> >                       };
> >
> >                       ...
> >               };
> >
> >               temperature-channels {
> >                       #size-cells =3D <0>;
> >                       #address-cells =3D <1>;
> >
> >                       channel@0 {
> >                               reg =3D <0>;
> >                               label =3D "aie-temp-ch0";
> >                       };
> >
> >                       ...
> >               };
> >       };
>=20

This seems to logical to me as well, only I am not sure if there are any re=
strictions.

> This works for me. Alternative would be something similar to what we did =
for
> dt-bindings: iio: adc: Add AD4170-4
> Where there is an adi,sensor-type property in channels.
> There they two types of channels were the same underlying hardware, it ju=
st
> provided a way to constrain the other properties in the channel nodes.  T=
hat differs
> from here where, as I understand it (Salih?) they are different hardware =
blocks so
> 'reg' is an offset into a different set of registers.

Yes, there two types of channels, temperatures, and supplies(voltages) dist=
ributed across SoC
Connected to same hardware block but sets of sensor value registers are sep=
arately located (base offsets).
Reg is just offset to sensors memory addresses their base offsets.

I will check the AD4170 example how it manages.
>=20
> DT maintainers, I think this discussion would benefit from your guidance!
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20

Regards,
Salih.

