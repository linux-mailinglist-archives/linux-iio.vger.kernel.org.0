Return-Path: <linux-iio+bounces-25401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E36C03E77
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 01:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB1034E3CE4
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 23:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22C2DA76A;
	Thu, 23 Oct 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOk0RqLY"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D1254876;
	Thu, 23 Oct 2025 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263612; cv=fail; b=ByHyiHsIvwQk7p/eQ+uvukaVQWRCSBda6l0CmRXniWZeIlcvpe1MS+ssBW9jlqbZEcF9JPj5otQqo+r+wXVR50nR6zOhN3qLb/BUyVX3qtlzKKU59O37aCOZGal9PXywQj//iKTAF5tHsEcAXe+ryF11IfUJ4bKxnGBHv9b5O/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263612; c=relaxed/simple;
	bh=t39Zk1TZHkcVTo3hRlE9aCYT5JCgxISFJuUZugtbWKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rxFFiRpPzcuKkWI6czOPb+NLnCb7/COemHxrkoLpiTNU3lLtYAj7ZOoboXpd7nWraFv1VBRpRlNZGgy/pJ6Vp1apIJlUZjodF3hJ/KD+9yTBMe9wORE+0u2H0gF9aUwcaVInYefoHnI5r1KvXFHNRNsgHIs+9cKO2wCEimxKakA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NOk0RqLY reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM+rVH4lfBNMmIBJwzIp69ZBaMLlM97kXKVE5g+3BzkJwoQ/lf1voqf1favTN+F02ytcZjrcD3J21ofr6p8JlS3XApaZ2W1JUAKvhkp/TvMs/94Iq0C6o08f1sBb60N4HLWzkNzfwrhlnqnGWcVn3bxTc07xzKzYsLGfwHoMC3xeMEGrHxz3h4mPBLj5aksK1DS15m5GfqqJmOz97WRLUMfu1vBRnnEBpsBmw6bKlUzvNDKBkBoL86EweNlNpeFwNYlLuyDXRoOzuaLwkUMvS7I7p7Wc88giDmzja/fZ9sS3WslI7RX15DYUByiZGvlXFcpqF08qHkzLTjgn2bcITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gduVNwcmQTsPrqm1ZRI3Pl5Rh53G6abkPDbOi7iaic=;
 b=P6jquStpGEhslJUtGMxCG28ViWpsPspn2JMW89IgX1Cj9Z90bjSa9iAoyA7UTz4l3kB8vU4AfukvCjcNxaCTA7yM8NyG+7a/npFqMgKQ+BsD1CuyKkxJMg3Zt93DwIc3QJBgodw7Xo1OfSElxantD+Fqpq1CQzfeifsxv6CE82AW9f8I10kNtOWiGClYOaJ+GKir+0e8oh+CdbtPsBAglboike2kftonvpVw1jFwqmZVKLLPIsGk9SUimrsY0M4aPxuqKYKnYvBR5Ct2oELWOQ/1ygZKHdVqPcxGzDKD+I+bH+MTtf/XZ8wNwr+D+nQyYKs3C4UzB0mYg7QqYzylBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gduVNwcmQTsPrqm1ZRI3Pl5Rh53G6abkPDbOi7iaic=;
 b=NOk0RqLYkRNv+3Vvf3kiN5OFAP9u2FAsq8Dm8/ty93R7aI0asLRqm4p2IzMMRwXXUyFLnw3Z97zCz/cxJQP5LUSRLISHKjG4T+6srWlzHv+4GElqH09tvr7vjTbd069ddP2gKYnRpS2/dloSK55Qqc4+WQE+JORVXncIz3r237EPjuXgn8+INMfofmSjEoXEE7LIl6mNivBaFhLpt+YlZS3QQ9Y3dZRoT9hIaxMolCWr6TXV86kRJ8D6LLSFY6qfycEe9DzniQU3wcaJNoOxQp05CZHLM3nFxu1RkEUG06rEVcw0O8xFvrv2yvWicFIbDam1VFoTpMwhfVKRs8TI9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10151.eurprd04.prod.outlook.com (2603:10a6:150:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 23:53:24 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:53:23 +0000
Date: Thu, 23 Oct 2025 19:53:15 -0400
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/5] i3c: Add HDR API support
Message-ID: <aPq/6/+63sHuq/qy@lizhi-Precision-Tower-5810>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
 <aPnmCwwZVZ5egqkP@smile.fi.intel.com>
 <aPpHTej/vKfiN68k@lizhi-Precision-Tower-5810>
 <aPpyf1xPmU_koEXH@smile.fi.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPpyf1xPmU_koEXH@smile.fi.intel.com>
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10151:EE_
X-MS-Office365-Filtering-Correlation-Id: 25482e0d-c622-4c6a-391a-08de128f5a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?VFLJ0L0ohFBd5K7xC8kW7g5Pnd7aLsMZAxCf9QbPfdcfwPMkTgGPgH5aha?=
 =?iso-8859-1?Q?gX8jt/MU26yEKE0BUlNzImZGtxMJ2aFbRfDdkU6fV/wxp1dyITHoEvq4oQ?=
 =?iso-8859-1?Q?ZFmlQdOl7qcpSiLmL39d/sRRlW/b5AVdtUxA4sXWGuexYVe5+LQgElm3+M?=
 =?iso-8859-1?Q?zP3ZGB9k1vdvzoFVJecVsPz/mOuMkFI8TqujjNSBLlJ8gAuOhXyrz0vAuR?=
 =?iso-8859-1?Q?k5/o67kQ5KywPKnP3/4IS6h3H9UmQDt8Gk/1bH6E0DSJFumL+BSFYItorQ?=
 =?iso-8859-1?Q?cvq0cKpOalT+Z/FYMEJpQiqZjNZvz7qGDLymzkLwRukwgJ5yYC3SyUSkA7?=
 =?iso-8859-1?Q?+cqb/1c7yNfyfhoAZZv9WnCkHIIhOS3bV1XuO3GufhtbJYyO+OjSvmtdys?=
 =?iso-8859-1?Q?M0x7cmYWZLSqF/rVjVFtyBb80j/n7veO3IOugT7Qq9jWv+bMALOYZQsBxL?=
 =?iso-8859-1?Q?tQjtQACLKGe3j9vFZUlzvJL522wrQmoBUF0mpLM0IuesheKQoFnc7EgqHs?=
 =?iso-8859-1?Q?3LeFAxPD4qnjYNo8fakFoVbEUHN2NYo89pzVvs52HQnllhp+Qh+y4QTVjX?=
 =?iso-8859-1?Q?OHX2WjiSs+Pq0vKE2UdL9ssdJgyexF7iXs9gI6X3P0YSqxmItr7rkgi5pz?=
 =?iso-8859-1?Q?pTsxn64FZOJGvA3Xf4FcfOS8bbgvI+E9QBTRgfxD4+lMpA+0sTuoN4C7R+?=
 =?iso-8859-1?Q?PjSTAp5jtrA6v074VhaSXZR2u6Q2mcIAYAfKDghlViRksOua68hdBusvQd?=
 =?iso-8859-1?Q?MGjkhtteuU6DK7oIUG1UzTrSeDFFArrlim9JdgQX6wlhr67nl3qNGd8BMl?=
 =?iso-8859-1?Q?iNdxufnvlP3MzStkTSLf/XjUWXHFEksVUSUJ+Qe2YpvRXaMFILBOtWqSoo?=
 =?iso-8859-1?Q?L7TmT4YCpzmxNeAUHnpXc5Mz5LL7iuPEbozjir/qAvWskTgfnSoEB9OBQE?=
 =?iso-8859-1?Q?L0QxlmmXEiYP2PISCVeRaakDasTwTGgrpjZ5xGSrkjv7G+F8MndOWkJNI+?=
 =?iso-8859-1?Q?9JTZ8PABUbISXlovd2uNP7yOTImF/Fw8HGUwJBJuJrT9aCVr6AU7OnzOH6?=
 =?iso-8859-1?Q?YXpe8X8CHRUvsXJz8QFqiw63zFWq//XJgkzAQwJ8vW2Z5JmJn8hLN3AOwc?=
 =?iso-8859-1?Q?qlR1Lnir9ywV9c7fTlsRQILskIS6fcjPNGFHbIrKmsfVOCKwd91+QoqUKO?=
 =?iso-8859-1?Q?FF2JTlw7kdUJ85/DOy01iulXbg6dY2tSQlHxyyWSPewLdKkKpSLQ7cw2F2?=
 =?iso-8859-1?Q?cKKIZRX+cZu7ll0J1CnV45T7CBz/5TRU5DVBJVkzabNWKMbUk2KVJ2FIJ+?=
 =?iso-8859-1?Q?hWOIfC+z6kJcX0vpw3IkQR19fnKfWV8TMiw/maGKz24/2A6y/cDKGyfOw4?=
 =?iso-8859-1?Q?FOqtJ7f60Fl/oQZyBm+EiMOjbTereAGEfhrjiuH1XBuSSetGP43urF24D1?=
 =?iso-8859-1?Q?s+tVACW2pWvvwc1GdCXA3ykDneReoe9KC5RBmv+bD9caL9rpWqB6Myj/8S?=
 =?iso-8859-1?Q?1HDXNsWzLZ0+gUffrZP50vqW5JMegetjEenuMFHmIr/tt9w3O7wNlb8vrw?=
 =?iso-8859-1?Q?Dxppch4ki/iWSHrtQN5oxnySDzdc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?P+MCD3XlXRIEiZESP4WBI2/imFm5gLV/TpE3yHWR8wyrwsXo33Vj3m3lmq?=
 =?iso-8859-1?Q?k+dLMe9xJQY0BC0XZZwmZiqmv497p/nWG/Bvl/OH+SjH3JAnwN/S2nwbCL?=
 =?iso-8859-1?Q?ZAbKhAKUdBjjdJ5ETUNJ7F50jgQ+7xkESsRH7DtY6dO2XVTy95/RGzS6i5?=
 =?iso-8859-1?Q?7H4oLgCrOzALZUX6T3+a8WJsPR+bZ48BFwI6WzSgSwRdBqNUGVhRVxeJS5?=
 =?iso-8859-1?Q?D33fIa3vvOgxE5wnNnPWfFVpvf99bwzsMrNNUxhL0cPYBdS5PVuhqPUcAn?=
 =?iso-8859-1?Q?s0MFwbYJDJjo+AG2K6jJmcfox+bZW36o8EzAkTjw6t6s8k3tNZO0dHuQS2?=
 =?iso-8859-1?Q?t/W0oCssO5h0vACSU+weSe7hoxl1LvKqs/SARcnAtgAMi74fl4Sl15Fn+z?=
 =?iso-8859-1?Q?uzRP5TUmL6J597IBEgcQHeHZLlnhnZNx/tfSPxeCtRazKS5KZCb4yuUTjt?=
 =?iso-8859-1?Q?cy+IqqZJ7rrHs0LmYprKbsDtIs8gZdCVJ92UkiIiRyIbJt8y7lHJfJo25f?=
 =?iso-8859-1?Q?w1VESUWzriaYu8odaL15EuBXqA55RmQAVGvo7/A0i+IF+OdppuUEo7Vw2G?=
 =?iso-8859-1?Q?XeqTPcs31/WF4dySM5w079qTH/hC6FEUZJuOBJFpuB1tGozCK9l2QPWrS3?=
 =?iso-8859-1?Q?zGa2oN3DYumHuLo9P3msg3vwpjsJerDJqdcnkz0HkOx8JBTEqZrLBqtF60?=
 =?iso-8859-1?Q?27huAEOsrfaadWyRu0US4evDjN61SgZhRGpa6mrVQR/xd7knExDL1SHU/M?=
 =?iso-8859-1?Q?5ruPR7CzgeGryQMqGWHvKR/0Oun/f8gPiRcuQMLQfUb+ovUPYGXolZPBYS?=
 =?iso-8859-1?Q?dac/wzCrNn5bneIFn0lqxj/a9EHAUR7EwvwNO5LUb1tF6PltcREojnB93V?=
 =?iso-8859-1?Q?rjG7eQw6nbGrju8L7eP4yGVpgcsr2Jo77tDu77QSMvGEX4ZSnQYn2gGJ9K?=
 =?iso-8859-1?Q?rxyr1TUpe4MNuInKa1Hw4WBIr0jbwg6itk8OE3zO2z7T/CntCRx+W336V8?=
 =?iso-8859-1?Q?SCD9u4G9Cvmh6L3Ler2KoMrC96h170l2gIDpbTCIDgvLtfI0tN8Drqokzg?=
 =?iso-8859-1?Q?BqJrWBCpQy1gd+NI2nUpPqU03JDJ+g7BpHgbBKjXPYjkk7CqJ7EEfwaLK+?=
 =?iso-8859-1?Q?Br/Id6LcCvx6Ly5BEMnB/0qHjLGZaQEQG7x6nKMZHwXwdhmwCVvNAaMsQb?=
 =?iso-8859-1?Q?qwegbH3MW51EBWeM9ErQdqi/vUL61NdELDugezR5qJ6+NaZisZOtXc62yV?=
 =?iso-8859-1?Q?+g6EzwxJE96vI8VW+Bz8M8iBMwoDtGXHWy8nlUMUJepTvqWp09i9uy/vvQ?=
 =?iso-8859-1?Q?c/wwfMM+hFGw8TA+0t4J9jdZxsMqPEJDhlGT+9V3IkyzCgtcNK1QVBAqPQ?=
 =?iso-8859-1?Q?uJvjnQD0bZ7ptSj9/pdDedpuH0BwMrAZvS9ulyjkk0r+svOflMWKmbRX0o?=
 =?iso-8859-1?Q?CDfQw5Fq0QhYVoiiEROipvhLQAvlbmhHWD9Zg18OA0oivbEo3j8hJuqn35?=
 =?iso-8859-1?Q?h1zXeeheawtGSwZ7vKRgAFTWvLXUJxPuAZ+UMZSQReeL801igCHOM6B07h?=
 =?iso-8859-1?Q?uh05jEGkddzMbHQCoHuH9O01sQbg9PurWOFbf+vpoAC3Cg6WOOR4wrNyVq?=
 =?iso-8859-1?Q?ly0ExmLeFN5IVBi7Vubx1hXi/iV/SMIs18?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25482e0d-c622-4c6a-391a-08de128f5a0e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:53:23.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOTbsbg6IhPnfXJJkm2Kzyis8mxngNlIRcSrR3rMTzVSpR/jG4ZIMuCJ7lD6U5cJ5cqYdz3fXcdCWLFZfUehsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10151

On Thu, Oct 23, 2025 at 09:22:55PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 23, 2025 at 11:18:37AM -0400, Frank Li wrote:
> > On Thu, Oct 23, 2025 at 11:23:39AM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 14, 2025 at 12:40:00PM -0400, Frank Li wrote:
>
> ...
>
> > > >  static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
> > > >  {
> > > > -	if (!ops || !ops->bus_init || !ops->priv_xfers ||
> > > > +	if (!ops || !ops->bus_init ||
> > > >  	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
> > > >  		return -EINVAL;
> > > >
> > > > +	if (!ops->priv_xfers && !ops->i3c_xfers)
> > > > +		return -EINVAL;
> > >
> > > I would find the logically coupled proto-based xfers:
> > >
> > > 	if (!ops->i2c_xfers && !ops->i3c_xfers)
> > > 		return -EINVAL;
> >
> > Not exactly, priv_xfers is old API, which supported now. I plan remove it
> > after remove all from i3c master controller driver after this patch merged.
> >
> > i2c_xfers: must be no NULL
> >
> > priv_xfers and i3c_xfers, one of both should be no NULL.
> >
> > i2c_xfer is NULL, should be return -EINVAL, but you logic may success if
> > i3c_xfers is not NULL.
>
> You are right. I misread && as ||. Can you add a summary of the above in the
> comment above the conditionals or kernel-doc of this function (if present)?
>
> > > >  	if (ops->request_ibi &&
> > > >  	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
> > > >  	     !ops->recycle_ibi_slot))
> > >
> > > >  }
>
> ...
>
> > > > -enum i3c_hdr_mode {
> > > > +enum i3c_xfer_mode {
> > > > +	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
> > > >  	I3C_HDR_DDR,
> > > >  	I3C_HDR_TSP,
> > > >  	I3C_HDR_TSL,
> > > > +	/* Use for default SDR transfer mode */
> > > > +	I3C_SDR = 0x31,
> > >
> > > Why has this a specific value, while the rest have not? If it's HW mandated,
> > > the all of them has to be assigned properly to avoid potential bugs.
> > >
> > > >  };
>
> Are you agree on this or disagree or...?
> If you agree, don't leave the unneeded context in the reply.
> Otherwise, please express your objections.

Sorry, I agree, It should assigned value to it. Actually, I have not
realized it tights to Hardware bits at beginning.

>
> ...
>
> > > >  /**
> > > > - * struct i3c_priv_xfer - I3C SDR private transfer
> > > > + * struct i3c_xfer - I3C data transfer
> > > >   * @rnw: encodes the transfer direction. true for a read, false for a write
> > > > + * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
> > > >   * @len: transfer length in bytes of the transfer
> > > >   * @actual_len: actual length in bytes are transferred by the controller
> > > >   * @data: input/output buffer
> > >
> > > >   * @data.out: output buffer. Must point to a DMA-able buffer
> > > >   * @err: I3C error code
> > > >   */
> > > > -struct i3c_priv_xfer {
> > > > -	u8 rnw;
> > > > +struct i3c_xfer {
> > > > +	union {
> > > > +		u8 rnw;
> > > > +		u8 cmd;
> > > > +	};
> > >
> > > What field is used to distinguish the union member in current use?
> > > In another word, union must be accompanied with a selector.
> >
> > This struct use only for i3c_device_do_xfers(), which pass i3c_xfer_mode
> > informaiton. argument 'mode' will distrigiush rnw/cmd.
>
> Then why that mode field is not present here?

Yes!

>
> > i3c_xfer[] array don't allow switch transfer mode during whole i3c
> > transcation. So doesn't put mode in here.
>
> I presume that this is the answer to my above Q? If so, I think this
> dislayering is not okay, because the struct effectively lost the crucial piece
> of information (for example, if you need to trace the contents of it, the mode
> also needs to be provided again, and so on). I think the data type must have
> this mode field as well (as long as union is in use).
>
> > > >  	u16 len;
> > > >  	u16 actual_len;
> > > >  	union {
> > >
> > > >  	enum i3c_error_code err;
> > > >  };
>
> ...
>
> > > > +/* keep back compatible */
> > > > +#define i3c_priv_xfer i3c_xfer
> > >
> > > How many of the current users do this? Can't we just rename treewide?
> >
> > git grep -r priv_xfer drivers/
>
> `git grep -lw ...` is a better approach :-)
>
> > drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[] = {
> > drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 1);
> > drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[2];
> > drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 2);
> > drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> > drivers/hwmon/lm75.c:   ret = i3c_device_do_priv_xfers(i3cdev, xfers, 2);
> > drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> > drivers/hwmon/lm75.c:   return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
> > drivers/i3c/device.c:int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
> > drivers/i3c/master.c:   if (!ops->priv_xfers && !ops->i3c_xfers)
> > drivers/i3c/master.c:   if (!master->ops->priv_xfers)
> > drivers/i3c/master.c:   return master->ops->priv_xfers(dev, xfers, nxfers);
> > drivers/i3c/master/dw-i3c-master.c:static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > drivers/i3c/master/dw-i3c-master.c:                                 struct i3c_priv_xfer *i3c_xfers,
> > drivers/i3c/master/dw-i3c-master.c:     .priv_xfers = dw_i3c_master_priv_xfers,
> > drivers/i3c/master/i3c-master-cdns.c:static int cdns_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > drivers/i3c/master/i3c-master-cdns.c:                                 struct i3c_priv_xfer *xfers,
> > drivers/i3c/master/i3c-master-cdns.c:   .priv_xfers = cdns_i3c_master_priv_xfers,
> > drivers/i3c/master/mipi-i3c-hci/core.c:static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
> > drivers/i3c/master/mipi-i3c-hci/core.c:                       struct i3c_priv_xfer *i3c_xfers,
> > drivers/i3c/master/mipi-i3c-hci/core.c: .priv_xfers             = i3c_hci_priv_xfers,
> > drivers/i3c/master/renesas-i3c.c:static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *i3c_xfers,
> > drivers/i3c/master/renesas-i3c.c:       .priv_xfers = renesas_i3c_priv_xfers,
> > drivers/i3c/master/svc-i3c-master.c:    struct i3c_priv_xfer *xfer;
> > drivers/i3c/master/svc-i3c-master.c:     * at svc_i3c_master_priv_xfers().
> > drivers/i3c/master/svc-i3c-master.c:static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
> > drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = 1, .len = mi->mrl };
> > drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> > drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = false };
> > drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> >
> > After this patch merged, I can clean up it at difference subsytem. After
> > all cleanup done, we can safely remove this define.
>
> I counted 9. I think it's not a big deal to convert all of them at once without
> leaving an intermediate state. But this is a call for the I³C subsystem maintaiiner.

There also are other cleanup works. The key point is that everyone agree my
HDR solution. Cleanup these is not big deal. I am not sure how to avoid
build broken at difference subsystem.

After this patch merge, cleanup will be easier and safer.

Frank

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

