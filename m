Return-Path: <linux-iio+bounces-13164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642E9E75C5
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D151116CFF2
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B72066EE;
	Fri,  6 Dec 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="fIIpO1WX"
X-Original-To: linux-iio@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020091.outbound.protection.outlook.com [52.101.189.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506B1FAC37;
	Fri,  6 Dec 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502041; cv=fail; b=DOF5lAOB4/Aj2+3+R9o6Zb198eApDbkk6ojI+gPx5bbiVScbUGvAVTCENGi2tQSejgVG3T5lqjfn3xKcmi9wvzlLq8uiCpkfIWdLkTZls+cMuzaggLKxe3m7y9HlFo82Jxq4z1FL8qdRr/Slt7z4dNqSpei7vmzj9cnzbfenBm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502041; c=relaxed/simple;
	bh=l1vhbpQlolnmomL1DL3db3X0ywIJqPK/SBHCHlYCDZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jGelSOgphK5PW+XB/y0RNAUKonXCOoVyRXPxF0btnNdnDc911xK2T6Vcu1P9/zr81oWZcbHGvmoipFLvgoQg+NbVsO2M/u5j0GTtlPRakJlE9vPp1pgXT5dHl89/Cc5qaDDxbgwtSsF1u8fQ8G/tYFzn5XpTOtri5YaQsNS4mUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=fail (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=fIIpO1WX reason="signature verification failed"; arc=fail smtp.client-ip=52.101.189.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2aWHOy0xca1G4bA6ecqU9w2IpzracxKGV4o2pNyUHpvVAaLS+em6VWXvSzdM1OEEYPBLg2XQ2bwG45u4tA4ZCKbz2BIBjAnTUAChQ6zVSuzNthpJ03bzmJgsmztS9pKMeK4UBx3TerwYiue+YvCZEqiWsetSgp1vlJEAWw71FdigE8czm8KjFn6MvJJH3wFuPycHZZgD6Nqg3/9NxVLofUWID9aKH4hAanJusNdckrDz9LV58Z4+TM5trV0qF22cmhoNUFiwTPYnvZjrGg/FONwcnrjSm3IDzSj+blAcCWRpKe4cg5A3lytYNPaGrycQE/H2YGX1frByqBzeA8l9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7j4FKfI4WLoMmKSIE+VKcE44edWp/8s9JXp1K8GTMM=;
 b=q2WNpp/52hpsSWD9FNwsO0ZHZTvWV6TYGUOP5iGQFAG6SdZBIDrFdbYyLbNqwvvnYKTq4A+BwhSjpgbHLyOB7cQwCFwfttpmbI3ConpGrqAaWAn9tPAcd/CDKNopAp+bSsUSzrHz1v152248ZwMStayLBDpArthkW4ymWbCKPaYxOI4fGhjUraQTt1WNkCxEuRDmSJei+7EoWtGYodY8Uxl/VNpqobusNETxf8gR4R15D/QeQO8quW2YUzmiEl6qvEmH3rC9bpSsovqAA+JKSz44wwG8mkKvmcl5v/nVeNGYSODUQqxtchrDVT+yB0kF8yHrX0o//bvbWSsCOsbjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7j4FKfI4WLoMmKSIE+VKcE44edWp/8s9JXp1K8GTMM=;
 b=fIIpO1WX15I9XNU8u941MiO4oiivvNtle0Vwzjujf9I7GLX4LKrMGR6l2K0RGtWCPTVtjDy1HZkdogEmGPiBbBohCVOhAaPTZQHWDLUmrMfI6+B/9VZ+J59cOYcYpDdIU6hi34EkzR8KBAog44wMszQtli6xGMBQOw2N7Wzsy20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YT3PR01MB8641.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:9e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.13; Fri, 6 Dec
 2024 16:20:36 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 16:20:36 +0000
Date: Fri, 6 Dec 2024 11:20:33 -0500
From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <Z1MkUcNPXmRpWD3A@uva.nl>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
 <20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>
 <20241124211545.194a9f87@jic23-huawei>
 <Z0eY+1X1ZSkNui9U@uva.nl>
 <20241201132054.0c063a11@jic23-huawei>
 <9d810e5c-c7a5-41e5-8073-b703717faf3d@gmail.com>
 <7194cce7-5082-4df5-8599-186c2e39c599@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7194cce7-5082-4df5-8599-186c2e39c599@gmail.com>
X-ClientProxiedBy: YQXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::49) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YT3PR01MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c6dcd3-aadc-4277-423f-08dd1611eab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?IY8E2nKr51sQdaeNlnWgdjwFGUBE5a+qv8dKZhcR+N3dSm1geK/6GpSyuL?=
 =?iso-8859-1?Q?NkmmTd9yQc/azgyS9ydSlUzTWqiX9IlSWi1FY0ssmSVZlkQaWm5F+ZKJYu?=
 =?iso-8859-1?Q?vV9kK3R1qBS//QK2rda30TONmwkt4YbjHBmHi9eY6ysx0ImYxr7UVihxaF?=
 =?iso-8859-1?Q?9pJhCuvWpxMZUNZgRty/1OxKScc6B7GMlQEze2k5mVJAdent3uPingvl83?=
 =?iso-8859-1?Q?q+LG8PW1HfosaadNj6qMiOL58DwnN0Of9ztxMlHthSpNf4oM3mg00N0yNU?=
 =?iso-8859-1?Q?KGrpanwNbCAbuYXqDoq2BuuhhPBHKbBxdiXACbyhoZ7hrlFSowZEwuck97?=
 =?iso-8859-1?Q?eMj5Ci5rbuNWKDESWUmIGkaClbMsDE2JRnCl2oHb6mVSMGficgwLsir0fh?=
 =?iso-8859-1?Q?NgJF8KY19czBQdGZ5EwjwoCJBNt1a57jXeLRV/QdCDYAmO+hvirHy1vRWY?=
 =?iso-8859-1?Q?dyiGT4JaeDz4aPfprAstuXOIPL1GOILMcLC6u2afk7VFCjSNY0b3KQDsp/?=
 =?iso-8859-1?Q?rtH7qzoR4/nFK2XCjylPQ7QyPMbBpnSiAYWy6b6QGh4p/w2i0drYr9mEN8?=
 =?iso-8859-1?Q?cNYu0qwTKA3TDqSxd3xv/8GkngMjynF/+/LKKeJuw/A4Fj7AvumW/VATjM?=
 =?iso-8859-1?Q?Zk0W3pmpoesWRwoKpUHTp/3FbFcyJNcVlHMpkJK8/UKmHkVqhk3MiTcw58?=
 =?iso-8859-1?Q?kBjzEKEqPH4bxWx/zin3Joc0u6x7uyhAItl3jHrBgYHjHLzKSbKypKSa0S?=
 =?iso-8859-1?Q?3DlHiaf/YsUs6Rdje01k7KPMCdlhvDRmi3JKkg5imXL78QMB6N1dwcNqj6?=
 =?iso-8859-1?Q?uJgYduNB5L5Vh7lMipWCTHF/r+nueT22syNUQyBbhVKL71dTTQs8WCS+yc?=
 =?iso-8859-1?Q?AHXFzc+sGj0oy+sOLiz+aalmLAc/bbXVTHmtL8iwzMXW3+5AwfBlX09I7P?=
 =?iso-8859-1?Q?m3/BwnDnpzg/plUBr3cDAMU3nCAMn9KKBkkayNvd1f3xZ6xDeRB/OIX+xc?=
 =?iso-8859-1?Q?F8Xl3D+9M8ms/UKrc/RwHwCSUWO8g+vgaWUACB8G3mhhRrr6IU7LbF18so?=
 =?iso-8859-1?Q?7z5cL6Nn1qTeOdDgLWXxxoJ2klC25+domG/jTBKrrgHq5KhpZbaOfvMumc?=
 =?iso-8859-1?Q?Jssj1s9RDE4kXTp3zPd8BEw/XruHWW+EB5J0T1dNRIItkgFuUupboUcmo5?=
 =?iso-8859-1?Q?eNRYBg3AoNV4N2skmFRIkg2MaOfn406Tjs1Lhi1pAba0sXxAzq/wg8EdL6?=
 =?iso-8859-1?Q?/vhDjDVXm302B4tQD6ieYaocU6+KdKvJ6dwQbstbuxjIAZWD8yY/ZhMAMp?=
 =?iso-8859-1?Q?Ok+q5WR3sDfNKbxizf3Qw3d9kcm1ipC5lsZbLHoRSbEhSB2o+fED2vGU7a?=
 =?iso-8859-1?Q?ep4K13ebMVuG40MCsG8lJ1Q9QEUIPyVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Y2zIzsw2oOXTxlzBtkaGxlAUFqxN1LnOq1XBwax2rLjhDHliLwwApNb0iB?=
 =?iso-8859-1?Q?/KF3UP9VK3SvmII3oPQzov5AUpIZj/32KPMZttCGVA4GKRVH3ftt062/Jd?=
 =?iso-8859-1?Q?qyEFKOFd7Eo2y/N2l/xIuooTqlU4LUU7ePq5mqiT5snlt1dQ3Gn+sDUw4o?=
 =?iso-8859-1?Q?FHKX/fyjy3gRYMh57tSd1S326UAI8trsv75ugB2Blh7MU8RFpYQHOIs1el?=
 =?iso-8859-1?Q?gDu5aAUIsjKhqvZCwN6k0y0zfJqHJYfDow2qxrKZC2P/y5SZI1YqdbKQ5I?=
 =?iso-8859-1?Q?uMtG+uMBp9Ba/wsWbU0J4qhdkAktLGTBSos9Aqayvbq2N4gvOmt+T6Qb0t?=
 =?iso-8859-1?Q?Hwqg39huGOSA7bNiXZ1Ma/8rVmWGUqAoFLnJc49Mf3fc69K40fPXIKfWtu?=
 =?iso-8859-1?Q?WqaKtAU90YjuDmYeJO/uX9TQeozvhp3JodXc/y5c9rSpDBUn/tDy1LIpyA?=
 =?iso-8859-1?Q?/ZUKPUv9ldIChIrSx03wvTnRa+YWFNrArMCmGAON+nX/xu+bHOUmy6OmcA?=
 =?iso-8859-1?Q?4uVaLhgSJFjGLqKCEHIwkRvy34Bg53pZqeCFLCcr7mw5PmZmRDWFNe0bUn?=
 =?iso-8859-1?Q?VJ284IFN/zjHjZntbmiUvrDEGlCpGHqfr1L7mluE+GXXhxeRA2wuE0RR8q?=
 =?iso-8859-1?Q?vjy4CwebJo1a6V2baM4OX64A3TwSAKuWe0/2j72GvH+RkoSFo3DR3F9puk?=
 =?iso-8859-1?Q?/t86ZBbqaZV6IJ/ydIgve0Ntf39OaXxlnhzuoaZAPYVvNeKJTS7TMxUHF/?=
 =?iso-8859-1?Q?X7lo6/b3y64/YV18o6eZUiM8fZh3WPTZ5t0fsIt/QT5/NAphehNKfnbhiQ?=
 =?iso-8859-1?Q?DdgNE15pna76VxZc4LHDmMa6lu9oI6YRGxt3BTYuMyv64BxPxov7O3ZdMD?=
 =?iso-8859-1?Q?jPjl7TX4/62hzxgJtK2AfqWDfHe8rVJmvDhYefnIKKOdmiMwrPjEOD5scz?=
 =?iso-8859-1?Q?LQB3oT+X5Hr131PXY6Jhmg5/VW/aMIHRDi5i5rGyshrNY9o7wDHH6oKk7W?=
 =?iso-8859-1?Q?DmbvpYD8eQUBA0MjkLGIDdWBCV1U7Z9HYvU8VSdQo1giLO3wP4nhzeLyrX?=
 =?iso-8859-1?Q?9YU7yoDvtFK+CJy6VEs3/wiSjCnIEgCg7doWbS59Nczyab1WzkoZYmgzqU?=
 =?iso-8859-1?Q?tL6QYeQICvUYqm6Y4v5aCHen+/KUrl3ZZenGmM05U9uIEb04+GYdvn5C2o?=
 =?iso-8859-1?Q?37FB1Wxw26q7OY3fHUHCgc7bN9nZ2y17u7/L8j4X635rX4NDfGtnQ6obWc?=
 =?iso-8859-1?Q?O+oy89x+SnUHmMTysRfh9HVdtATn1VrSSPokQz7JfbCmZ5ccBIe8HGX5f/?=
 =?iso-8859-1?Q?qjPJYLcQCFyyRxU4TWTiY3E+H1ofRxal1jQGf52I11yyR03DAyz0hWuXdT?=
 =?iso-8859-1?Q?+N+JHPdWrVQgETtFTOSw/4iD4Exyjv5sucva6Z4kpa5JYUE2hRER6rXXn2?=
 =?iso-8859-1?Q?Gw6Ew67oqBBkBKRfoaZonOpfgP7hOK79VA1xtWJE27y1Tho8WQgmVldGSC?=
 =?iso-8859-1?Q?+XemyTdFTuGXu11oboCYmBKE9MZ36J7SQ6/W3kjuNsr4S6fJsrpL9tjXIt?=
 =?iso-8859-1?Q?Xk3R/u0i7l43OQFVXbEx/1hLQuVXDyIlHZD/tlyJi9as34pLVPYYH9GOfj?=
 =?iso-8859-1?Q?qL2huDfL0z7btO6h9F2FDP+nEnsWC+9/VqByqrs7Xg9FoLpzGxcg7w3w?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c6dcd3-aadc-4277-423f-08dd1611eab1
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:20:36.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsFHCHtKX7vqBdZop+2mkv02ucKj3lEniTSY+uv5RDkkkZHR0nwQeuKYpM5Kkq8FsGYZafulPvdVX+ZaRGply/qmyLHVwCe8URtnC7nDxfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8641

On Thu, Dec 05, 2024 at 11:42:21AM +0200, Matti Vaittinen wrote:
> On 02/12/2024 10:22, Matti Vaittinen wrote:
> > Hi Jonathan & Mikael,
> > 
> > On 01/12/2024 15:20, Jonathan Cameron wrote:
> > > 
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(of, apds9160_of_match);
> > > > > > +
> > > > > > +static struct i2c_driver apds9160_driver = {
> > > > > > +    .driver      = {
> > > > > > +        .name    = APDS9160_DRIVER_NAME,
> > > > > > +        .owner = THIS_MODULE,
> > > > > > +        .of_match_table = apds9160_of_match,
> > > > > > +    },
> > > > > > +    .probe    = apds9160_probe,
> > > > > > +    .remove      = apds9160_remove,
> > > > > > +    .id_table = apds9160_id,
> > > > > > +};
> > > > First, regarding the integration time/gain/scale parameters. I
> > > > took a look at the datasheet again as there is a table
> > > > provided to get lux/count (scale?) for the ALS sensor depending
> > > > on gain and integration time.
> > > > 
> > > > It looks like the correlation in the table is almost linear but
> > > > it's not as there is a loss of precision.
> > > > For example, at 1x gain with integration time 100ms the
> > > > lux/count is 0.819 but at 3x the table is stating 0.269 instead
> > > > of exepected 0.273.
> > > > 
> > > > Is it still possible to use the gts helpers in that case?
> > > 
> > > Ah. Probably not if it goes non linear.  Matti? (+CC)
> > 
> > Disclaimer - I didn't go through the patch and I just respond from the
> > top of my head :) So, please take my words with a pinch of salt.
> > 
> > AFAIR, it is not required that the impact of integration time is
> > _linear_ through the range. The "multiplication factor" can be set for
> > each integration time separately. So, it is perfectly Ok to say:
> > 
> > time 1 => multiply by 1
> > time 2 => multiply by 2
> > time 10 => multiply by 9 <= not linear, as linear would be 10.
> > time 15 => multiply by 15
> > 
> > ...
> > 
> > The notable limitation of _current_ implementation is that the
> > "multiplication factor" needs to be integer. So, this may result loss of
> > accuracy.
> 
> // Snip.
> 
> I ended up re-reading this mail as a result of running some of my
> public-inbox scripts...
> 
> ...and I noticed that the non linear correlation was not about integration
> time, but about gain. Eg, if I now read you right, the integration time is
> kept constant 100mS, and gain is changed from 1x => 3x, which actually did
> not bring 3x gain to the lux/count values.
> 
> If this is the case, then the GTS helpers aren't likely to help you much.
> Sorry.
> 
> 
> Yours,
> 	-- Matti

Hi,

Thank you for the feedback.
The datasheet is not very clear on why exactly the correlation is almost linear.
I assume it is probably to compensate for some inaccuracies and that's why they
provide the table instead of a linear formula.

I took the approach to let the user control the integration time and I ajust
the available scales depending on the selected integration time.

I kept the hardware gain read-only, as you suggested, for debugging purposes.

See changes in v2.

Best regards,
Mikael



