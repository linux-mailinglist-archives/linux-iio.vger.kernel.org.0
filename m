Return-Path: <linux-iio+bounces-25626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDCC1BFA7
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E96C85E5613
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B733DEC8;
	Wed, 29 Oct 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h3cNv8MD"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CA2F6932;
	Wed, 29 Oct 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753295; cv=fail; b=iqlqBEzY2nCJmRoi7V9H1bkcbZVo7QDT8YqIKUoX8riGCrF+Of9hzPBkYWJmAULp4gb4q0I3O+fVDExR0Oypm5Z7n37B/a5Wh5hZ15cCfK7tsVzBtnesuRyANbD8cbINo2OhvDedSPhnbCSvPXbv9ZA16g6liwTf0IqRBev7E5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753295; c=relaxed/simple;
	bh=GqRGa/CYKLc5MpdCqpoPtHrDCRt01dP7f18aLvpKzhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qd2Lwm2VlO2Zg+g7l7E+Il1JfVXaIJO2gR+ClM+YBDoFkHwoMt8JfV+6DAXTAdySvTUFi3zob7OsNbL4VC+v/bkyRbpttk6NGciF6aZ9IL4CYSyhKQSE/0qEYNVxBBz32cxX4hCfBAkK57OmNL2HK1WnRmCreJ0hH2tZmWuVzzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h3cNv8MD; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE2xnnDlhdcELc+xypq92I2P6Ntvr0WF0yxtRb0/n2sl/Pn7hDuldaN+wiI2NAqESdfQUsKKtHmy13piXMjuO4hLnOObsAo3KJVWj2n+HdVZSAE6S0DpMcVqZLn/yIpw4JXG1s/kltyp6PVZJuyr7RY/p6kMTm02ADyQoibtEwnG2Qz8dQhFHqhrFsD9vIBsHO3yayhmM82/PnHRAbyE2IcI7TCq6kP2ienMwzw4/WOPazq4n1YmnRP2+G8Y9sSt6s/8e29iRo1RonDEoIqY6KqpnRJ9MMR+d/T6Qh/gpopnQHIuakDTCAuhR/eKLyGQAb/S+CInh7+VBLDF8bYf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLfG+9KrWtX0fjw5WBw21ZV6lBJChUzyO7XtILFosM8=;
 b=aeCmtRFAy1Qo57ybHA7KAhk39R6wfEjHNqGfKU2EX4U884IOCmHfHJvDhT8bfHEwWXgxyFlOVbtRnRXwDZk5ERTmgTnfykUUi33LGVLlDwca7JwGVym2vQOnohFVwpFnL9LoFEbASVy59gVowUzdvoBHfrak8my+noQcdKd4rATGGdWMA/QS8Oi+dU1vvZDP8razow9RetZH65H1HFWAq61yn6Dz/sAxMJgF59PML62dJrEWIaDLZtDFbQxpU6JTqcHaQYxVmD5Q+9wjEdnNkV8Pm7agi6nnxxxvZzcliBs8AhjsOsmaHvI6YKwcrk1lgaOL72pt0cIIya34anftFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLfG+9KrWtX0fjw5WBw21ZV6lBJChUzyO7XtILFosM8=;
 b=h3cNv8MD/g0LJBYrbl5C27sNVYdmuYjWLh/6MGO+DLv+hsBUkMI24Zbu/aBVdeSwmfio51/qxtJDWFIQOLLmxT5Z4vhyjqiIRs3xZk5vaF6p/tteMg9jOCg3qVZFSazoIr4ay8wuHyHZSf4Si39UCOK+nq7y5KSA+Gr18YWWyukk5ud1Y7hqXaLN0n52fwMWcFiL+Vlft53bPCF0ewFLZ3iNTgGK2GCDVs2KYbVowvueRZ028tcxI02i3VykvqM0n5JtnHGuO/OdUCQEgaixU73X1VdHKwokk5hrM160Ne8o3VFE5UmqvckisbrspTlS8gjbXXcn9SLW1YQ2waoDig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9195.eurprd04.prod.outlook.com (2603:10a6:10:2fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:54:49 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 15:54:49 +0000
Date: Wed, 29 Oct 2025 11:54:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v7 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQI4v1lVcagBWY3i@lizhi-Precision-Tower-5810>
References: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
 <20251027-i3c_ddr-v7-5-866a0ff7fc46@nxp.com>
 <aQCgD3iVOXoNr7uY@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQCgD3iVOXoNr7uY@smile.fi.intel.com>
X-ClientProxiedBy: PH0PR07CA0117.namprd07.prod.outlook.com
 (2603:10b6:510:4::32) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbab5de-db43-451f-ff8b-08de17037dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RcQTqWTpVd5CAQze0lRsuF2S4cLz/y0kB6ZDLEzOB+rGuxKxIL2DMxd6xTi7?=
 =?us-ascii?Q?GYMmXA5K1gGdkB3zdnKPNdmsSiiDv43dheyEqJrpbR1Nlk7etu39VQfAS43n?=
 =?us-ascii?Q?zaKB+OZupX7t5ekmGSl4lY+GrfOCqSiD5LM2gs2P88PtxDk1fVHSWvb/PMVX?=
 =?us-ascii?Q?2AS18JRL/JOcTfUxtllu1cSVK4VK9DY6dnEq+MOmhByJcsuE1xQHePELo3Fy?=
 =?us-ascii?Q?k8lpzDY3mOmRnsROkNCSN4MdbtuoZHhvHLVkfTRTsVUQOY+E4QlOv/Y5HT37?=
 =?us-ascii?Q?GUVVgcJS5BMVqBQGW/oTKIdYroZXNUFRiJ2wgNdVwe9rnZ494TcVG55DO/S0?=
 =?us-ascii?Q?uTHHjEK+rWDvbRe/prclbuSCrUAOnEZXWQK4sYXlheCkdZ6eYDBwwYD7sIc/?=
 =?us-ascii?Q?iNLv4Tv0660olxViOfsaVBlyXAGoyCOl9IfrIWsqj7KyH0FUeHspwrnVYktT?=
 =?us-ascii?Q?7EgyRs4fyaoFkwttj3k05SGqrSrs+Z0NEfCNsxU9WLjxOT5DsYDwR6RAFYFn?=
 =?us-ascii?Q?ZGwzoiaxE7dn5JH20XSgQnex7KuxCPciFwBdeSWkF+kBsmIcbxeFUqvN/hyG?=
 =?us-ascii?Q?0u8KRC5reeL45KY24ZggZUg2hYqEQNqyJG7TTJY/46h4S0xe1Y7cx7/vDPvd?=
 =?us-ascii?Q?oGg5zRSC/iy0nDciW04fVAIK4PScsm7qpu8es5vdXuWqkMUWnbMe0jgQorcb?=
 =?us-ascii?Q?4losYLcfRxTlgZsBNlSWE8r9a6L/LbbP3aGMsXLrhQvltzFT1hztZXO4vnR/?=
 =?us-ascii?Q?PIk/CW6Hvw1Xb47iWSBywVnKXQFDI4e9W5ND4ZJQqVMNx1LWI5C6XYDZi3n3?=
 =?us-ascii?Q?LFEMOvUjrajR+FawpSSukcMXiFFkJUSiUt1/TOPxGpQFRC7OQtlxhWtBwGaJ?=
 =?us-ascii?Q?+KOaYoo+9pPmVuQaG/2cymVIANwESNI78OewUh6Ct9olW8/Xs38rIuSrzQLc?=
 =?us-ascii?Q?Xk8WTrcIFK1YNYpkOJTfW7pjKmNwS3ptuStLHDBPFf0LGDI2M1uTASRXnIY5?=
 =?us-ascii?Q?yBixVUXFY6bErTwQE87hx2AgIdj40EkCYQotIwY5OF87gc8yOOhF7fZ01y3r?=
 =?us-ascii?Q?DMpA74d7GDETyrgdlOx78Sw9K3IbKU2rUH/5Ezlp9bqgMZFJ8iPE/kQYnvqg?=
 =?us-ascii?Q?cJ2KXPqJf8/RElEcbE0X2GSnz+7WWhshHxK9Om9rPRcSDPvxvAoZsFRc1lAz?=
 =?us-ascii?Q?p37sxRZDiTg+/d42hbQ07M0r9XOfNWoBcUlyJtfGmG/jaNZHM0UTKgTRDh2T?=
 =?us-ascii?Q?3N6MujEttPit277aKY0NOA++WAIEqoYsyCyrUzF0GQWZp1JPRwOZA33HEkNo?=
 =?us-ascii?Q?2uhcOTCSvnmQvuNPRObm33HxdBI8N2URLBpFZCsM1j2/ccDcXb/j3A48VimW?=
 =?us-ascii?Q?gwrO+yIFMHUcnhtxdM/xRQYQV3K1/WBTxt+svGRPLkfhiglKNfmnLuPFZrFc?=
 =?us-ascii?Q?HmGCVw0xYnJir28lfeK2rzRffiL/UT6fWXJW2PzzCj4T8mgB/WnVllNQ4+aK?=
 =?us-ascii?Q?R+A+Qc02ggOjtlvATft3D4YWTQG1i0lUi+GF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7OzvmhMveovcczK/f/9ZlQTNkFtGV/bGGHKzFOA9mNQ7C9JTgSMl/C0hpKkc?=
 =?us-ascii?Q?M4sHAgmvj75vM0LlllgKZeQNjisR8qUZrhHjDpIbhv1kHEKfrV4fZ7UyluZs?=
 =?us-ascii?Q?rZQjwmUMqV0hYvfmNHe7adfCYMzB8niEry/s13QQu/TQ68JvUZvhEdTyEgiE?=
 =?us-ascii?Q?dF37W+38H8RQuUkLns0oytCIxpunoZNdFwl3EZXntCAtW+8xiUFKcEQSNz1v?=
 =?us-ascii?Q?spDWgGrn8Ci/e92NW9+NJKbxRrpWTCPjYfHOgAhtLi1S5aCmQFL4AuT0+Y1b?=
 =?us-ascii?Q?rjo3neWmgc0rAycX6jjjCxQDvlpw6T0mDVDIzzT47IJ2DB5gluGnpZy1nNFY?=
 =?us-ascii?Q?12/6JzfXjHRYowJWpo8d5M8XKJ0UsIagOINSAkyHj3IAF72QMa018WBBA336?=
 =?us-ascii?Q?bas5NHjgfLJk5j7axv7+UJWwO1ZFVz3SL9PnuJx/eO5oPHRmoAsBzDGyHWcl?=
 =?us-ascii?Q?tUzhdoI6JbtQmdIF0z1hDRae5fIKdwVRUsaxFtuVW3iUhmtgxN8UCo3gYPJN?=
 =?us-ascii?Q?0wSPvr3OeIVHXJLA7X+kHlbqYODos8AcAnmvM1+5d60IVC4gPCaJzNRp6Qzx?=
 =?us-ascii?Q?7qnhjlo1mPRqr5j0IWx9lyTpL7hU7EJP2WSUQ+VgYLWpXMlFyHMROR3jB39/?=
 =?us-ascii?Q?psTMrEI/BC9BNN9QbnUL1mcFuFjtSp533hqcKlyLcebfvC5d8ZRItRhpWau8?=
 =?us-ascii?Q?KfRI0f46ThekXYFUBBxdEqWecl3gResU/xRAJRo1ACpcKDaapPEcJQwOkXUk?=
 =?us-ascii?Q?fgseJZw/rRlbIli17dExexgSVdfBzd8hMxkvSybyvc1Uz3E0qjm1zqe+ZmrN?=
 =?us-ascii?Q?y5eSVybQ0hwDnygOpq+UWke3p0tjW/NzjwVy98vxEdUQjpYNcBHCVhadgmnZ?=
 =?us-ascii?Q?kZ0C+sQ7kCTJfdFPR1ZqoaxS7JsVpfqc39sKxY1FJs8TPgvuP3zbnLVGPlUP?=
 =?us-ascii?Q?32ZU+03hzs58RgdvxVZ3QjwRs2b76CqvjyQnD1BBNCfovT7uGGmG8I2bsREp?=
 =?us-ascii?Q?dOdLucX/k5qti+PeK90a7q/U/OAtZgWEYbfsvt3qGrXZfXvfOayg56m/H9PM?=
 =?us-ascii?Q?n3xEs/NX8Z+N3vuCQAMfvHl6LY1mib0J6O8O1WWQuEGUsrQsl9aFXL7HU55b?=
 =?us-ascii?Q?f6ccsACDK4gEud9i3m6GCv4SjQqvpEotOZVvnhlTmIQNu7lrshLBHZp6rr1E?=
 =?us-ascii?Q?muml8BwhHyz3f3V9uFIShYwbTRStn2Yrg14vE4YRjU2zcmeLe5OydeOtFDo6?=
 =?us-ascii?Q?e0rdY/cuPtExPj+OZHfk9DXb7AmcUALTvCvKuKnBHR65gGn6UdxgoZV4l+J2?=
 =?us-ascii?Q?Qc2fv9B8w+2DRWe/+wyrFBCEzHbRwRIUV70oeHR0wWFAPph0ySLlQNlUe7EL?=
 =?us-ascii?Q?OzM3eAsCvjG6jzUg8s6jGpODafcSmM4Y71KakjMghjc5AdxssXlxjRHlFXUF?=
 =?us-ascii?Q?Qs6/sie2hBXRXRbFkY6fLqUJMKMawYR9Z+CG4/pjxhluYetAEJ/ahGErMB0M?=
 =?us-ascii?Q?7O84CjF2R0DFdQ5f3zY2uoJBfzrYRpJYX0vDkII62Dqn7i1R/3S602qqzsXp?=
 =?us-ascii?Q?ElXajJ0KIlpCRgZrues1eS7R1+PqksFnvnKbjcSU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbab5de-db43-451f-ff8b-08de17037dac
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:54:49.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toDX48Gr9lmEwkzQUhi8JrTnjYGmC7rR2RZp78IMW4k0ED3XaXL9J1XAwy+gNbxPb9tCMcPOUBLaSviuPbhUxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9195

On Tue, Oct 28, 2025 at 12:50:55PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 27, 2025 at 04:08:33PM -0400, Frank Li wrote:

After update patch, I met some problem, so reply at prevous your email.

> > +	struct device *dev;
> > +	struct i3c_device *i3cdev;
> > +	struct mutex mutex; /* protect to finish one whole measurement */
> > +	struct regmap *regmap;
>
> regmap has struct device, i3c_device presumable also, and here is struct
> device. Don't we have some overhead?

*dev already removed. i3cdev is kept as my reply at yesterday.

>
> > +static const struct {
> > +   int val;
> > +   int val2;
>
> No need. Just
>
> > +} mmc5633_samp_freq[] = {

There are some place will like

        if (mmc5633_samp_freq[i][0] == val &&
                mmc5633_samp_freq[i][1] == val2)

previous
        if (mmc5633_samp_freq[i].val == val &&
                mmc5633_samp_freq[i].val2 == val2)

Previous version seem have better readablity. But it is not big deal, if
you like, I change to [0][1].

>
> struct i3c_device doesn't have a name, does it?

It has name, but it is hexnumber (VID+PID), like 0-4a20000f000.
So use friend/readable name here.

Frank

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

