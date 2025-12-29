Return-Path: <linux-iio+bounces-27415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5774CE72DD
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 16:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B89D300B938
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128E329E49;
	Mon, 29 Dec 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IeQDypXT"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76626CE2F;
	Mon, 29 Dec 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021281; cv=fail; b=aze2tdXnbXD36C2YX6jxEJVxZcGw1F0S9SmiasFLG+ws2pYJ0ZpEECOmShN5a79gGb8+UlMsp58qLq/KxzzVyj8V6YGJJbUQmY70jatfBSxRZhnJakmvhaE9O7V81YksvAmrlEkMtBGbITpnZS+mK4IQUb3ZAyTrvE8COjo4tlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021281; c=relaxed/simple;
	bh=ZHJVRyW6Avl5zhvYmbbRke+DeAIBQt9lLaxPWGQsdDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A0blIlVgIeMiVdQyaJ92QixmO1v+4GEI52S1Tsy2kPd0xhyii8qLzBiZZTv9NhE0YN6q2oQb3cG/duaH9Au55/vJUO7mCXP+zBAKo4COkixVBtIplDnVDG/ZKbnTRm3MrNn+A/80HwkeQeUeeA4jp8tg6SFfyqO1ED/J2Ik6UXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IeQDypXT; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmONT/e0nM5X146S+NPWGXuLeQOAR4chOXX1et8K7Z2cZfyvacyMh6QQOhb7NgVk03/hAXEdFs+q6sLxzcuVD9/QjSeE3WY8iAPKBqDr7gDtKMoO6CPU/TfCGMHXMVI/qXFO0zS6laF6YfCJ6RFaqysl7QT7zZ4N3vBBWpipJKr6s+OTdAG/ODs9XKcVr0Cw/PnE71RlkNEWmkP2FKU1SbQ1NGlQ1X2+jjPHp/T9JdqTOIxpgtNlMr4ivdxZ3T1FTlvhK7NQVwft3/pQcOCxuMPGNPLjS9FPDP5rKKXi1WnIdDCV4CHTA2ZGVAQs3exoR+5R5+NV/y1Dd/7FnhSTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnZiUZsVcJt//uM9NS50fyS6bR00QF8W3BeMaFyMPWM=;
 b=jq/tXqp94H8rvnlovb8JITEH5rnvk60jWkgQ7eGE7RINqDH2xMOqSA6DN+2BxfDRdW4ppOZX5OTUB5S4DNxkzRtDjcjlF6C1f52B4BQj/kLyJ1JTOtiKjyJAHN2gHNTovdF4omTqbPBFuQLftoOz/CvyngOAkFWi5wJ8MSN15mhCQdU06LzuxziU6y2zuvBdObCyZP3fC5sNhToVZ5cApWYwbMY/y3eXSmlPXLFWVUImuFyTnQ6X5GFgfZGPTsODhKfrEnly9LMv31W8WNNeFIJyXmoZb0JoHyyUJY6bUbyxNkFXTJyBmrpj487JPXCZ3KKdk0USWS3Zp0j4RvKSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnZiUZsVcJt//uM9NS50fyS6bR00QF8W3BeMaFyMPWM=;
 b=IeQDypXTN4CAh/Zo+9qQvxn1R1lzwBu5rQW7N3ukPfD/RrNOxkiSBSZQgibQuyMwDpTjymaMFN4dMAPLxZHcsyrWlhHD2A7l2P3ypEcwoa+Qbgw1+PCZy9KeaBsHV0Drzd84e+WB+B9epF6Ij7gyg9fWgtEBxkfiH86H+D5jQRndteMfkvfMwMs9T+ZRzkh7Q3mZTQzfJxnx1iDAi7vomwL2Q0wRkgbA+KekxNoF2bioSVfCJpvkkdt0EJTKRCA8MUo0qNIcQLiMcaNEfheHBa3L5SvqBBE/a+q1ZcYO/lzgYy9YW9eGWxiOCcvKqKTB03c/a6gVdtoD+k1RgLgn7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV2PR04MB11165.eurprd04.prod.outlook.com (2603:10a6:150:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 15:14:34 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 15:14:34 +0000
Date: Mon, 29 Dec 2025 10:14:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, linux@roeck-us.net,
	Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v12 2/2] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aVKaz7XglkFbxMOr@lizhi-Precision-Tower-5810>
References: <20251215-i3c_ddr-v12-2-1ae31225b4d9@nxp.com>
 <202512202141.aAwyC19D-lkp@intel.com>
 <20251221190742.4162108b@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221190742.4162108b@jic23-huawei>
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV2PR04MB11165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3503b287-1d2e-4b36-27c4-08de46ecf934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a3j0zckOUdFp7AkcPkE8ws/6XywjVkrj44GBSmscrgI3Mm0CXigp9gjM8VG7?=
 =?us-ascii?Q?hBE8oOgV68H89a7bEkZuMYwvcvNXqFMQzjixAXEcuPnGPdCAjgOb+B7Aqhon?=
 =?us-ascii?Q?/LRBdZV8qFGVwu88Tp1oXPjgPC6ybp6YomRRaoWe5d+9CND2W28aonhCXL80?=
 =?us-ascii?Q?bER63Hr+S6ay2y0K+5GMORjBIOwhaE+uqxQKkF4VRuGbBClsMTUc5Eg7ZBea?=
 =?us-ascii?Q?khVhQCvsBcZtoen/MEaHvZTysAd+cThM6mQjOo5Jol47WkUeWlsAAKeEeOuK?=
 =?us-ascii?Q?71glSzj1JxwOJ/ebCEMcP4AdTBFLAvvLaMfPFAB9nsd2qmFi1BWCvAR+PHJS?=
 =?us-ascii?Q?VBZVgfHxISGm2EUfml6FVQFMB1Wl7ROhpF+s2oABAkLf/3ZzltwP3pSHoxdt?=
 =?us-ascii?Q?o+cyVog6/V0jfbG3RG+CxyH36COSWhiBf06cBn8Kun/mjEd6/QNBZeIKfu/Z?=
 =?us-ascii?Q?38X9/LMI9qs0Eujpqr92sj+TPBWcfqboh09DEj/qnlF3ZnvxPhtTrBZY5zYH?=
 =?us-ascii?Q?aDpaExcvyzqKEF9oO99e7zMozHJ09viiZl5yqdf8v5A+aNhMmxxBuIUjUvPS?=
 =?us-ascii?Q?nMT/6OtZ8ggvC/lfMhOx1x2xMMDFgGQZGULExnO2OdrRc6iF1lQdW7MO5Vsl?=
 =?us-ascii?Q?sx/e36aJYE2+8pfymcmx+M2JbvKF6XXeiBHzWsFTNgzWJRHPH0vAC99ohE4j?=
 =?us-ascii?Q?D6JQZVc5DKqyIUhlOCt5Ko/jQTGsOx205T6tocKHudWKLRjnIM1QqEMvSQms?=
 =?us-ascii?Q?6c8no8WOEr7IXFqmjSxjiuXvedGYdh+c1WE8WKzZ1bbEKZiGQ1JXSMCIzaFG?=
 =?us-ascii?Q?lVP4lmahFejo7253q2DArXNHRDIt7g8UOCdE7/WEeNkJQBH5v7bBIaWCLItI?=
 =?us-ascii?Q?nc19IkHnggB5l1ZIuehUff/geCb/C5+Zeh9+4lNBVVVzfW7R3KdVuqkD0ODF?=
 =?us-ascii?Q?Tv1895mJTcJlISHlCALLeOc8NGkuJWS5hhY9PRGQaV/SWSC4c82MATz6xWf/?=
 =?us-ascii?Q?NQkDq2Y0HCF4FkEx+BFo/9h+8tUb4XYviyTOrdyqZS8ecZQlaf8qaiJXAxuu?=
 =?us-ascii?Q?rpbtMRAYtJt3F2Ie4f0zKh7PbEKvU+DHhmUjIc79RHl3StIHPTes/dSFvGZc?=
 =?us-ascii?Q?GpUkbHaTAQvG6YZyhZ0TogizKjAJi64RRsrNq8CRdcq/HN4np8JRkdkmqCsS?=
 =?us-ascii?Q?QmWEEBbyi1guVXwE8gc9nrV+3qKlr6N/6XR5dwMjcoSxcQYZtfEvuDP4Mu33?=
 =?us-ascii?Q?ltoZ0i3zC2H1WS6bNA4oUGQ0zFvZ8+KAjVASiejmckDFjo/HqyDbCsLooF5O?=
 =?us-ascii?Q?v6KDjyk2aK7cc37q5mt21c/Fln906cgvOMPodnIjn2ND+SC7qEklR9RFapf7?=
 =?us-ascii?Q?25U42PwDCOCHOSNl3k3J6QH3O1LJS1EYwAWPS2PTPb1pwB09pz/mzsP0PGp0?=
 =?us-ascii?Q?arQyUZKPJjDPjkM77uktqfYt0aQ5W9w3IZqkWvDus1FNlgCpxgA94tUoRwF3?=
 =?us-ascii?Q?V24Oo0TAWiL8xXDsLy/8UtrhYxLo/xOUlAGJ2x0B1w1LWXwpAzuuvmxdVQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6qMQTBOePAspKwii1of9V/9TSY9pQxBPwgwLWFamMe6t5U0TTlmjW5TUTZKJ?=
 =?us-ascii?Q?D5b2bM2uMBQc099GKkdmMf/wBMsHFzv2BpHYmOAEy1Tl829JUNGuRjF7JIMQ?=
 =?us-ascii?Q?a0UKxkf8HFIb+4Z6OXpR1WVbb6Fz2+Lftmyt8kD1lchGYmDwkK2tkwct2Lbv?=
 =?us-ascii?Q?iKlQmvXSe+yHPnz0pzQod9kreI2Qyqu+Pg7TJp5vHuf9pEAHnowbzwxlPyyc?=
 =?us-ascii?Q?kGxnkkb30kvjPCegYwvfigkD95Z+YIZYIbmpGt87LzVW2hSch5gDHwm/ZsU6?=
 =?us-ascii?Q?TGyLu0LcgYKIB9uT9uXWnMhsHRssGca4BgjgWKHSSyNvIE7AaY7LI9+c7FzJ?=
 =?us-ascii?Q?vZ8HlZTdMTpzELmVGEpJXwlsjvoT1fzb50p7dwB57lbzjEqfdKij+R/zzGq2?=
 =?us-ascii?Q?Ky+oIyxH3dZfkGTB60DNNzg06AXsA2l+TVHS1aDr3hh2ToZaHLEb6xatNuOP?=
 =?us-ascii?Q?Lpz+z3S9GF12pOIEUYYBC3beLE5nm5H5sbEMD4WMBNTI95/6xP7tTpYxjgXs?=
 =?us-ascii?Q?KWOCoNbFFOTSoe+hRwL29m2WReRNlVXzzSPEOknQjf3xVhR4XYQDFuEt0n/c?=
 =?us-ascii?Q?5lE/LUOyGbH2L8kkBOo/7QA6EiuWB9prqFmTQyQtxYHP00/0GxQvh8fi7yWt?=
 =?us-ascii?Q?9jYezkbhABx2vT9DN1nJiU7GTSWrFW9FCESXJrl0ry8gqBno4HTfYXfohxWM?=
 =?us-ascii?Q?VYK0iHCeVENxxZ3IV0Zy0HopRBjT0v89b6aOgI4AqtIFCCrMg8e/klHVTYOH?=
 =?us-ascii?Q?4Cxah+I8IOnNW5NtmKY5Z/i0+sfHwhwXeLbbEdJBmXEaHcwWjWbSbhF5kzpu?=
 =?us-ascii?Q?Kan1uQjMCKJVe5BMLpo5nuCN1QGMQJbcFDaWwxA71zFiyoIUUqDimxPMxSGv?=
 =?us-ascii?Q?/0YDdskj73fiQLpKYNmm83fpd/XgkplhkfI7v1oMzXIAtXOempVzsRwtzsXT?=
 =?us-ascii?Q?WTB6BPXBj6C6EPcMIJowkbStlCPslr+3PxQSTN7UADkmCjF2ua5qov6/3auw?=
 =?us-ascii?Q?yzPgELNtOID4Vh5ay7UVdihlsZ/jysJsuJ1OHHqIolJNowwZH+dAfTAmprQD?=
 =?us-ascii?Q?6uD/sDmv5mSERzYLyoB/J9BwDTFW5LH4knvqmdbtA0bVPp0GuqsERkEz50YP?=
 =?us-ascii?Q?kPJyOAfGWrrh7xcHTZqLdX51sWIycSGzX+8Rt3XmkzK6mWeO/oRnZCrQ9bu0?=
 =?us-ascii?Q?96rju09Wa4Wy7mE1cxZvUUTv8Y9ClisJtBte0mjLwpPjv2nhaai83lejd1pY?=
 =?us-ascii?Q?dlMkNFy6F7uzbxArSY6PbFirG6ML1pOZWBnpmvNM/3bLqYR6eEwKuvIZ/kjL?=
 =?us-ascii?Q?txBXi8sWg/HQli9sUF9a2KxJ9Cr4Nsb79Jbq7Dvc9P3OqCE83NwRYzuvO/Ep?=
 =?us-ascii?Q?JsG9YDt08KFqTGcPnPHkAuW2571MkIrls4D3X0fJlzvvQ0DQOHzGOEcg5TYr?=
 =?us-ascii?Q?a4Nd4sp2pzNpW6qvw9LegZTV813GxZrY6gdP2R7QyTzLdFMPEie2n9WLMDzR?=
 =?us-ascii?Q?KP3/Fv4OZNrwk3lyKrvsjzoYutRudCQKFKVf5L79S5nIbye9CP/p1ngIXvWR?=
 =?us-ascii?Q?zQnYCjPSMQo+z1ZMd1gB2Z8awdeOscz/OrKd2Ghge2L0fTPnWSPnOvkIQLFY?=
 =?us-ascii?Q?SajmoJaaa0EiaU313gltF5bMj705ni3FuINloabnCC05OIfynOwY6PAMSnsk?=
 =?us-ascii?Q?o0jihuYGcMxgUdq/eP4Pip/8a/l0ua1yv/USkNZnS9zdbCUt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3503b287-1d2e-4b36-27c4-08de46ecf934
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 15:14:34.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoOZNJFbN9yEXI3gHr7L2FGS8OfsbhUdBHOUbswQevTh3yhgXt1B5mNYlMOEYU2u/dVVJ0DNexcmf4nMUb24ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11165

On Sun, Dec 21, 2025 at 07:07:42PM +0000, Jonathan Cameron wrote:
> On Sat, 20 Dec 2025 22:34:47 +0800
> kernel test robot <lkp@intel.com> wrote:
>
> > Hi Frank,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-trivial-devices-add-MEMSIC-3-axis-magnetometer/20251216-010451
> > base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > patch link:    https://lore.kernel.org/r/20251215-i3c_ddr-v12-2-1ae31225b4d9%40nxp.com
> > patch subject: [PATCH v12 2/2] iio: magnetometer: Add mmc5633 sensor
> > config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512202141.aAwyC19D-lkp@intel.com/config)
> > compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202141.aAwyC19D-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202512202141.aAwyC19D-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/iio/magnetometer/mmc5633.c:362:2: error: cannot jump from switch statement to this case label
> >      362 |         default:
> >          |         ^
> >    drivers/iio/magnetometer/mmc5633.c:357:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >      357 |                 guard(mutex)(&data->mutex);
> >          |                 ^
> >    include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
> >      414 |         CLASS(_name, __UNIQUE_ID(guard))
> >          |                      ^
> >    include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
> >      168 |         __PASTE(__UNIQUE_ID_,                                   \
> >          |         ^
> >    include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
> >       16 | #define __PASTE(a, b) ___PASTE(a, b)
> >          |                       ^
> >    include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
> >       15 | #define ___PASTE(a, b) a##b
> >          |                        ^
> >    <scratch space>:9:1: note: expanded from here
> >        9 | __UNIQUE_ID_guard_966
> >          | ^
> >    1 error generated.
> >
> >
> > vim +362 drivers/iio/magnetometer/mmc5633.c
> >
> >    343
> >    344	static int mmc5633_write_raw(struct iio_dev *indio_dev,
> >    345				     struct iio_chan_spec const *chan, int val,
> >    346				     int val2, long mask)
> >    347	{
> >    348		struct mmc5633_data *data = iio_priv(indio_dev);
> >    349		int ret;
> >    350
> >    351		switch (mask) {
> >    352		case IIO_CHAN_INFO_SAMP_FREQ:
> {
> >    353			ret = mmc5633_get_samp_freq_index(data, val, val2);
> >    354			if (ret < 0)
> >    355				return ret;
> >    356
> >    357			guard(mutex)(&data->mutex);
> >    358
> >    359			return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> >    360						  MMC5633_CTRL1_BW_MASK,
> >    361						  FIELD_PREP(MMC5633_CTRL1_BW_MASK, ret));
> }
> Needed to add scope for the guard to apply to.
> If this is all that comes up I'll fix it whilst applying.

Yes, thank you for your fix. If need respin patch, let me know.

Frank

>
> thanks,
>
> Jonathan
>
> >  > 362		default:
> >    363			return -EINVAL;
> >    364		}
> >    365	}
> >    366
> >
>

