Return-Path: <linux-iio+bounces-25379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA0FC02182
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175361895465
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD0337116;
	Thu, 23 Oct 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fSz8Wz0I"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720D2EAB65;
	Thu, 23 Oct 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233057; cv=fail; b=jNrx32ac46nASdqkFBYB8bEYVsvOEJRps6daIqZCKXu7O76qA0ZrCNNxf/5LHd/PD3hncdn0f9ucY4oVWZ66CA+RuBcshAlYBtqNCmW107i/SsTht7xw1pb9jxEHWdk6fW2rFyfCioRFE/Af28v+InSwyPXjYXT+hx11m9+xGDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233057; c=relaxed/simple;
	bh=CIIfygyf7EpIr2BerPsECWEnG+bvfug2icz+50kzQ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LtfsXFbDkUpu9HnBQyrht2koXTabdNb8VfzZcklE+url0sRUiXLPNbxs9RteRJ+rjATHaZEDw0NFyvW7SuqB0Jvl0+638gjM01t0eg9uuP3DbNCjOObtls/QVtexmcBChzl7t+eyqkTSCHhxiH4nJk22U+bUT09cCqbR3UITeYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fSz8Wz0I; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6NLVlknzWLpLhJXZgq5Qxo/KzpXIRoP6CS9+2EeM+N9+DjGKxPJxqsnCUY8l4Iscwnvq+W4L7maMPMTFT61shPcZdwjYdqkIhDDz8dtf3JeLwpjtZZn3gC3RNDSVMz+7g0l9gzpCah9FSrcju0zZusaF3RFEp4c7GosprdAyzQTtdmFHO8/y6FdRuI3Xxe0zjnQuJLxIW1G2uRnemJPFN/wKSsZdX9F/H4Zdnx85CwY4R7Bz5uwpgErKx3ByRJ6T6mlQyC0RHki6Q7+JjoT9JdFSEpWjmV74DunicCEyZSrxsly4c5imViNhERBguPqysqPSq6P47lxOavu/h35ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RvplgLTVQwLO+ybBb/UwLPWobthGYKmc6idramY17w=;
 b=Brs/O6f2BlvE5wTw6PFq9lJ+3805q7b9RKl0bVBPm+TgHkzgX7tlGACNie+JgS4BvTpEQ148kOZMPgiY1kuoxybM45tWGaK8ZgVTQCRTLBgwHVyMCOiigG/iWpglVaZxPmtuORVDxMOupFk9zt7MUiwFsM4/cMLYiMB4pbApWAlqBZyrKSYjh9ss61op8DknVmYMw4LwFst6EgwmADd3dKYboo5ZuT/LbizK/KPJHWqYbvRWdGzVNkpCXm6fgBwnBkarL6vEPKSB1V6B7GUdvrADeKA/3B/4Ovym8a9L2z+6Nf593C7GEpSQ6S72oqQogVLq50aJnLOVVJDmKoYPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RvplgLTVQwLO+ybBb/UwLPWobthGYKmc6idramY17w=;
 b=fSz8Wz0IKQhdokwLjDnPKa1VNTPOVa6CkE6WfPOywT2QTObkCq87pYzmwaToV5nxjszb/1GSe3oXZJHjP6VTfjh7wwWMKmZRx3KZLqNhDfORY5xOfH2Qi7zORLq6i+4ols+t0hsjyhmo/lOjikAWVV7tg7X6Y6KlayDU407m+M5f1osGk7/Uiph4AJa7u5L06srFB8vwrM2WCcUZIuJ4bwR/5vekSooPAfNaS7zknlnsGP50bQXtVlBXoUHhUtjc9VvBeoM5wG2zMXo+VOdgQZhl4Y0YZumaSfED9V/QCx145T7FcRLDC5GJzNCscVBGJCcf+Qu58CEo/yIF55dQaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS5PR04MB10018.eurprd04.prod.outlook.com (2603:10a6:20b:67e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:24:12 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:24:12 +0000
Date: Thu, 23 Oct 2025 11:24:02 -0400
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
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v6 3/5] i3c: master: svc: Add basic HDR mode support
Message-ID: <aPpIkqjeWsi7xAAn@lizhi-Precision-Tower-5810>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-3-3afe49773107@nxp.com>
 <aPnngQdwEqHgPc7R@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPnngQdwEqHgPc7R@smile.fi.intel.com>
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS5PR04MB10018:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f28c195-cb31-4991-32c9-08de124837ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqNR3EbJrPnaSTp8kmKU3xMFxy1ZHYiKDgOPgiPC9Vhj5se8sE9wlBYTeFR5?=
 =?us-ascii?Q?OevbNu1rX1K4GGc///2tdVTyJg0/lCZopwtRtBbdQq5IVkehgLFaEXNA1skb?=
 =?us-ascii?Q?ERUq+nFTJutqI+9UWm57MkZRtpIkZfyS1wjP967/v3SuzQrmvbaIw9PtKJvJ?=
 =?us-ascii?Q?isTfyWNzXTMK8qPIqXPtP0bwKgAxHDMi8HWtr578ImtnBuoUjJ9T0X17bDcz?=
 =?us-ascii?Q?/gdlDKkuGPvBO7y2nPzwVm7R/7rOQFrLJcyQCbuEi5IBOyJDVPvRtTaFuajD?=
 =?us-ascii?Q?FNj92w3X3ECCOpmZ1NXDNE9H4Rfi1JUyu9GFaE/kaNda+DegH0iCFwGrNas8?=
 =?us-ascii?Q?+LM1IpB44eDzSgsaPiJtiZMI131FsVdIOlGwKFDeJynSs62YkgR8mCZMHRRB?=
 =?us-ascii?Q?I+dUW6sV8Nit3knbsUlMfwCv4zrpuqLk3hUXwR6t5DFXFiVCFSqNPDkte2kK?=
 =?us-ascii?Q?E/E0zRy/lUPHtyBtR8DSnG70uwsXRmf9VWxRzMGDQe6dmDfJAyWPHsQSWxIT?=
 =?us-ascii?Q?8arpUHBtG0kT5jfBgOXPjNUfc1TeZCCWVKT/FIT7YA0zqzJYz/3SR5EHeoXj?=
 =?us-ascii?Q?A80vcr0lOUxRO7nuSqeeDmhK4RFvlXuNTj6T/03/mEU9Y2ocY/jpz9lCpLDj?=
 =?us-ascii?Q?UjqbwCFliMU3Mkx3cxHPKZnsIyd00ybOMcy31vhFLmZrtIaNQYo6+YConqbv?=
 =?us-ascii?Q?zty/v//Q/UAaIwLzyBLAuz7xEPG0DW6+ngO2n2sP2eXQ+HAEvDS7D/1eIlGm?=
 =?us-ascii?Q?b4DXx0tmS7G+Pdb1ZxP7QhsQxskRpY+k6xyrAEo4imwKV0xlJHor8LhzYAKm?=
 =?us-ascii?Q?/GIfzC4GSDvGFMe9XAweWZkwWYd7zAN7vXu9xaPcYTpX3WPwC5sSw8IGH3hF?=
 =?us-ascii?Q?517LLqY6o0zDJuHVXTQozJ8XBkILIJ4TaVPM02WIajtD54WhGkZng+qhQ6pU?=
 =?us-ascii?Q?/nBHmVT0EzHjsNoqPGPXEiTc35i7ctJ9ERw/pgGVOrlXR3ja7ASg/VaBrpJN?=
 =?us-ascii?Q?APy04MM28o5FzAkI38VeNGtRxACvEf2zA6TM1IWlb7J+EDfd+wAcOdYD+aob?=
 =?us-ascii?Q?aQm7AkDnEF0NpAi0LikQOup4Inpi4cquWLIJ8zIGHLyT18VxSgV++D3uGVqJ?=
 =?us-ascii?Q?xZXzOUOWKYUWkpJTA1reMJ2DHdsDAyThmlMo0xiW0qS+tf/+T9OAU2DDW/yC?=
 =?us-ascii?Q?KnqHFMDafsOUZyVM7gAe6okXq2GbtC3aH1Ho426IC+AkY2HRiJqTo7XP5CwI?=
 =?us-ascii?Q?HwNCzU2l1SNPFVzDQw8/N0txVrAoHnFC/WIcoLSfsGOgsqfaS59TMDitpHk7?=
 =?us-ascii?Q?iW/yZklu08byc0ACKuLt/1XENDo22G8S3tr+1RurFEJYIqIQrWjXbtx5wfAt?=
 =?us-ascii?Q?QoyzJ71283XKaAv/NIfbT0S8fejH2MgAKjJ9b9gs2mfRo9tWEafs9TnD108P?=
 =?us-ascii?Q?RSsP+lc1bpLkDmpKRh3dNg2Xk3V5ht3H9ewaa4KawazTE3cr/r8vYS3N6ZVB?=
 =?us-ascii?Q?XTA/ynu6SeQUI1NLZHl5ibOP6Wg/61zcPmzv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R6GYEpuwj8MKYcOB0rBHICh0Xh7EJIA1N3rJVqGPXHUDeNuO6j8M5ecVv0nX?=
 =?us-ascii?Q?cinmCbDUYOtDBFp8//Nhs2ghTJGt1dgSONgNYL4wK/dWpjy7d8nPHYGcKj3E?=
 =?us-ascii?Q?YIlMquheTXYTLx39NrBS4GOyx7cu3xe/IF6UNTw3Y4HAIlKBKCMCiQg6VObJ?=
 =?us-ascii?Q?4HPGVfXWX2WCgg5QaFsQESATOP6T7wFzOGtdY5RVpi3RcY3nPRZIjxbuQCJu?=
 =?us-ascii?Q?kAVLDXSTCm3wZkZKmUgf1Z9+WbcbUXQj7G4qeozcW5rkLP5fgzEVBAhXEYS9?=
 =?us-ascii?Q?y6m3hYVf7uC1mfUx3HHf8ZZKX6GX6FJ1EkXK3bqLMECNDr4BsxD28Z633tMB?=
 =?us-ascii?Q?SXQy3/Y3t6xg7JTB0e+3qmhTCjUHHJmgI3Ch3h4DONAmeFKakeuRe0jzErQO?=
 =?us-ascii?Q?uG/Y4sjr4p2MQknSAvXYifnD4NwAdau6ayRu2Iw3o206QeTQQvwHxxwMv6/j?=
 =?us-ascii?Q?/LIcGNK8c/p51/C4D88Uiybylj/Jw0IAIPkt3eZxlKPmn/x2phyeB1R8/AG5?=
 =?us-ascii?Q?09fdWlzyzdGWKbzTEieJmNjGVgTA3xaDghqzmX3wSdYGk4JVjVPWxPeXVXJO?=
 =?us-ascii?Q?PBUIr0z2zJYMq8zwOa+NyGVT4z/0G/KX8stXwIyUV4HHsBNahsCiNqySiaqg?=
 =?us-ascii?Q?shlX/JUNr3NrX6KM+isrzTuMKrvFgbsXWEFj/3SkLBZOPYMgiAh5WAC2e/jN?=
 =?us-ascii?Q?B+eeVYz+nhaJMgyy4Bld9Og7+YOQ0CGja4o/nSBeKRr9pRQwXjrDAXJKXJ3e?=
 =?us-ascii?Q?ZIjrNalRy2h+wWMEGoO3UXOKUfg/JnY0ETacGlggW10z3WRdskdlVLdEafeH?=
 =?us-ascii?Q?GaMjzcYcM2qcZRctH3bQm02m3Sm1pGcotw1NWOVSD2bPJyJkRYMoyJdc0ut0?=
 =?us-ascii?Q?G3weBZALTWxn9w7ULWpKlFNRAJ5aC0AdPiUVdNZMNlvWM/3IVW+gNk70ybK6?=
 =?us-ascii?Q?95A7Wq56pUsWDJAH15VA1udq+wxXej0fb8jCtxMD+0w27AhsDGfAAz/w6lFS?=
 =?us-ascii?Q?n/ifV+R57DudMfwmeMDWvmgBZG5A1TZ2oVmwyMAraVov72wHWwU6elPBRZdu?=
 =?us-ascii?Q?uAt9+R0Tnj/alcgnt0KjKPcvzzMG88gCr/dhu9cOrqq2sraQazDgYhNBhJqm?=
 =?us-ascii?Q?e0qaEptq2wa7171BBdf8Or4Umd9i333YM7my6r0+tbxMqT77K7Hh7komtJrL?=
 =?us-ascii?Q?ywGi3Jt8YzHNFUDnu8KbC0FEOJ5UpkHtSYEKC+zVINIEehNDozeFarAS6G3U?=
 =?us-ascii?Q?fCpQPxRgXP8J3R0k10VkZlZjzaI5hfsTfES6Pz3Ye45d6oDccUmm3hHoM57f?=
 =?us-ascii?Q?6xHnJz01/L44T4TRZXPn6zjvChdxWq0dc73HOSYH5pOOrUfVNl0hFv9kaPGp?=
 =?us-ascii?Q?Xfai8GZVlwGoKOd23gcqjwAUqU37LOAOCJnynBriqEnaHbSdNlQJE04sP7Qu?=
 =?us-ascii?Q?bBSxHzXo1SGkqomBgGR89R3MOSHmUPGehDu0JAzWtB3HO2lawEx691POpDaC?=
 =?us-ascii?Q?Rj2CRdg5Wcn9Y4gkT7j98JFuCckCFlp7cklVILFgP+OhWGiS21/ZQ3FhS0ZG?=
 =?us-ascii?Q?Lm7vGSlExrmrC6+/TJc1cI0PTOr6h12z2BkGDDCr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f28c195-cb31-4991-32c9-08de124837ec
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:24:11.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qui4IJBLk8kNZlAADwIvKNA0th+3VAyEVzL5D/5YLBkXBj6DLxd0nSnsTxO1CLIZQGP3cpRcX0Yn7y5eoYYWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10018

On Thu, Oct 23, 2025 at 11:29:53AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 14, 2025 at 12:40:02PM -0400, Frank Li wrote:
> > Add basic HDR mode support for the svs I3C master driver.
> >
> > Only support for private transfers and does not support sending CCC
> > commands in HDR mode.
> >
> > Key differences:
> > - HDR uses commands (0x00-0x7F for write, 0x80-0xFF for read) to
> > distinguish transfer direction.
> > - HDR read/write commands must be written to FIFO before issuing the I3C
> > address command. The hardware automatically sends the standard CCC command
> > to enter HDR mode.
> > - HDR exit pattern must be sent instead of send a stop after transfer
> > completion.
> > - Read/write data size must be an even number.
>
> ...
>
> > +static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
> > +{
> > +	u32 reg = 0;
>
> Useless.
>
> > +	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
> > +	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> > +			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
>
> No error checks? Why is it okay?
> Why is the first parameter 0 while it's not an _atomic() call?
>
> > +	udelay(1);
>
> No explanations given. Also is it really need to be atomic? If not, use
> fsleep() and it will choose the best suitable API under the hood.

It is in atomic context. I will add comments.

Frank

>
> >  }
>
> ...
>
> > +	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
> > +		/* DDR command need prefill into FIFO */
> > +		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
> > +		if (!rnw) {
> > +			/* write data also need prefill into FIFO */
> > +			ret = svc_i3c_master_write(master, out, xfer_len);
> > +		if (ret)
> > +			goto emit_stop;
> > +		}
>
> The indentation here is a mess.
>
> > +	}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

