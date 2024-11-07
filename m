Return-Path: <linux-iio+bounces-12007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3899C0F4E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 20:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561511F22952
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5DB2178F6;
	Thu,  7 Nov 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eyuixVc8"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58545185B56;
	Thu,  7 Nov 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731009004; cv=fail; b=Ti3NTFxP96xIqowb4tsqu2osoSKtogZWIBx0XftQrrUf0/IbA97NiITkipXcN8Z+m6XOw11pbNO19GLFS2NV4h4aF+113vc+yvOJsPWg6yR4P0I5Km2WzSZJ4jg8qSRRXa5rRTIfaYq/p92tM4FsT8gwPlwCo2yHHfF3cC9mRkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731009004; c=relaxed/simple;
	bh=rwfumNMaqh3DhSpMjzwrnzawOVccfDh91izyjZIbnSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tc/7bM76pGGw5gTek5rPW0PbHcmzHpFSODgmzdoQhSXn2Xx5yzyQgZE/EUf0xy6bguG/SCxOxWe007Ug77a+EYnWZFa2s+XD5wTVh3eHZPypVCcNKrDar2KFBlC7qkQsrgluCR/CoDe937O1AOEdk2s2oigcRKYPEUP4UV4rlCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eyuixVc8 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE6JNcQIMbfSx7mynBrx4FniSKAqJQZjcSkEhSckKFPLeZa6iSKx7d/TYsGWXHH5IygnstUq/J3/0/CUiFvkjFvfr6IuRt+JiBbEaY4E3vZ4GK7AoddWmUpPjjRuTQs88NJXEsarPMEr6yMYWY1itnEkqY6hq/TP/pVZwQJ8bN8x0/f7E6piiNkifnOm2CwFntthewfSeEDf8dF4wkGGy3jmlX29ssthA1lG6cJlB6DB9w2e5scwhT0veaWCWyZ7072umZpijQdZ2WX2z3KtnBf5+/mKVc/eCyZNILElU2jIegg7VMsNrsm1JhDA4gkF57G1qW+Zh3pcE83OylA1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wapbMYny7AvakybNZI3omHQ6gZD0pMIOGa6AImrzfMM=;
 b=ZPbt/Od5h+EytZzwtmoZNjYKZWn+EkRuUuCEHhhYZyJ9mo886VByzk2H1YCCsS8g9QgSdULDW3elZ2QSIy0Ktn8O75rEUM5W4U0+s4JITutDlHEh14iNelb7umj/Tn3vgqUVvtgBwL/RW6T2xozGLoNwx8KYFglNt8PXC3oQj43Hv1OdE3p3ITr6s2B/X1qHOdfOXWLXF/bF+M0fYq0CxAhi49d8b+m2IZhALvFinE27h8jhS89nKmnLLW+KKnEiXaZN66YFF54jP8rm5fOtDpnD/h645uaxdUmyNpodT7gxHhmz9EYMgprjw+cV0FQLjZcdoqUAiQV4bOZZ5K/r6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wapbMYny7AvakybNZI3omHQ6gZD0pMIOGa6AImrzfMM=;
 b=eyuixVc85Ixez0Mh1R6CBMkkiTSiwdKFWSC4N5lcYYhQQ5+U9fhL8AOMLif7mLnmN5pE0qM614n93Xd0/LKGsMVNx/RYkG6ikEOnew8vwVvD5/zTseprCry5LNnNKVF1DAuAJh2sTXGc76xVmU4OA7PCpY7FQ9DTAGtBFdg/05TVbLSmaNy1RFOIw+lReGLQjnOIKJkUzoph/apKYQ2cXAoZqSnEZ48gBBeiWKH2OgZjxbO6e1Wrt5Hs6tIs0v4yAaSndTk5/IxISLNyaYUQiYL7KG6rncKtckZFgPTaQRP++ow6z96NMZt/BVszOWqyDihJkZdtHuAV7d4n4eWtHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7324.eurprd04.prod.outlook.com (2603:10a6:102:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:49:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 19:49:58 +0000
Date: Thu, 7 Nov 2024 14:49:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
Message-ID: <Zy0Z3wIsgX+O4DEw@lizhi-Precision-Tower-5810>
References: <20241107191842.3002319-1-Frank.Li@nxp.com>
 <4bd12695-075d-474c-b720-d295cc6028ce@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bd12695-075d-474c-b720-d295cc6028ce@wanadoo.fr>
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: b33a2389-0f3f-4d10-b067-08dcff655be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?qVu2RDZuK1cDdVcJ3PYNfJm4pSrPONcbMF9yHFSiTnJbyCklUmd8ei+5sN?=
 =?iso-8859-1?Q?s3paBc3735CdCw4FicBtDvdDvdo99OcQkVQVN63mPfliqVV4JdfTD+TrK+?=
 =?iso-8859-1?Q?hRBJ9IFLhq/fy7D6zghjZrrsXMAenO718jT3YfGKvwqPtebNqTiUlkRQuq?=
 =?iso-8859-1?Q?hflcWsZe5/GacZ9wUm0bAtqwtCeJdCqAg8C3bnzvv8bY9H2Dfj0fdUeZIc?=
 =?iso-8859-1?Q?w4sXquFbvRqZ7mpn+VCwAzEkTMmsKiTO8cr7H56mO9rTMjVHpOMktUeOEK?=
 =?iso-8859-1?Q?EwoGCEApwraE1g/YvMfS69+VPjpD8BE+GEilgEjdu63swLwC2t9rBwEAw2?=
 =?iso-8859-1?Q?HgvnMIp7++lPhQGtuOAu/P53vpMF/Quvnl3ctqGvrQR0yQ6H6g6orFB91y?=
 =?iso-8859-1?Q?dWYZu07rt9K1DUVwTyfyWTCGX7g+X49GXpmYWw8KYRbQVxioFipJesDw+N?=
 =?iso-8859-1?Q?jtQVOuNoVdaTiCmyp4EhCY2nH3/8uwTSp+b22kHRgyDaFBVW8QFGW7OMQE?=
 =?iso-8859-1?Q?FvUqvazY9CBLsuDYwXmvs0iKbnxhIxmv6Qa5B7+mL55izaWD/PEc4JD6Xj?=
 =?iso-8859-1?Q?VgHmezJm3DTzaU9wy2MjGWT13Anv5cTJ82NCwr3AtD/CrlBfBLxin6CWfW?=
 =?iso-8859-1?Q?TD+pxcMi8YYu+m2u0tsYUBF5QlUpPRUZcqTw3MBhuTlMMwNdQHOJBDalG7?=
 =?iso-8859-1?Q?Vwv0q/ZdghoghP5D2LnLAbmOYsSX+XQuxWPaHKlD19nhDprFN6dVIy1+cm?=
 =?iso-8859-1?Q?PSA2HpN8efUS+jm0KT2nca1YNFP0Lwrnb+AivMER/Y8WmykKCHI8E9DZGm?=
 =?iso-8859-1?Q?PvtqjSpBQ+lmh/WkR17zsAwLodklFTrpLeCoqtaWt/BiSb4cGpVZtSHqSr?=
 =?iso-8859-1?Q?Q21p1oOWnanPa7HVrtEO3n+ADGoGhX4IFONBGGKBDLA+JjfQ0BtBCBez9z?=
 =?iso-8859-1?Q?kpwUihSnBB214KhJ0KnGdD9NnycQWh/lpYznAvnqL1lz0CWuqglMvZHCYl?=
 =?iso-8859-1?Q?JF2XRQP4S2hN7ushpEHICZqeq3nnkZekOrrFu0SgSDNVmq0PJFeWP3jvbg?=
 =?iso-8859-1?Q?KGxPv+UmFe7DIzi9/koFd7AjXdhsy1HAzLrHqRMgE7hX35fEByAjS8bmJJ?=
 =?iso-8859-1?Q?VZDtuEuHAWaPTqGPR/0BDvPr5XrkzhDCmcYE6RX+ZhiJ4dK+TpLzXRe+tu?=
 =?iso-8859-1?Q?P5ED++LFWNjHrX5iFnCzuZyIDcrwYiHrS7VoEYccDmzdsPSZgAVv9z7pwa?=
 =?iso-8859-1?Q?o8NQ8PiUv+3Y8d+v+FKqbDRQFsCOChWJAT+1uOnMyD6ubR/gX2JFWb16GK?=
 =?iso-8859-1?Q?6aHAWQiLi9G56abBkKmdxcxNNk8M9oOos42jJtZIhhha9zAlJ+mPMfs2/M?=
 =?iso-8859-1?Q?c8bxMkN5kgfXJ9I/RaX7f6oWjviJTZwZVqpSE4RzFEfdeY9imYsH6iX3EE?=
 =?iso-8859-1?Q?+VYIn6X0QB7NXYbU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?LSXGi0b5aJAmMHL3ltnRgZHUtceEhZ9Qem17nu6J/mbF0DfAKCqoACKj6d?=
 =?iso-8859-1?Q?Kabo3Mo4HcNp24ewCoCi9QhHu7rhlqFq9me3CkiCNtYMLeK9cAMbBBgr3/?=
 =?iso-8859-1?Q?ZD6gkrNVd3Uzbqc6Hn52ys3EmxW8r2r0FFl16BvSdN0aKmskPlR01JhQj4?=
 =?iso-8859-1?Q?XAyITxW6uTWfv+ZTgIEyquEFbQOwOV5SUPOW639xJbuIzFmASwtFFkvVVN?=
 =?iso-8859-1?Q?ImzdQWkKhrMCi7pHx4OEZ//sNTQDpN2f5Qe4yzs6LExI/QZpehv9M6lNvv?=
 =?iso-8859-1?Q?S2kDaJqzHPKDkG4lxM5AA0MTMYKVq0Twld0eLDIfNLpS2hwaU+mmxKDApP?=
 =?iso-8859-1?Q?4DFbNh7b54FpRr0mzBS3rulMGYmjDrvffh1PLXxLbmAc/qZOWcnZMv+5eM?=
 =?iso-8859-1?Q?EAN9kokBS5XSccdeiz51uAZJWtZ1P7romx9lhGMLyYarXOmmfyS4HBZaTq?=
 =?iso-8859-1?Q?kcWiqk/AWAAApeTI5z8X2lNOr0oFpv6NrW4nYUe28ktz2KWV8ygqnmSapc?=
 =?iso-8859-1?Q?aMF3zP/YaQxn/fKYdvdoIuRsJpJKq1Ikm7K4WOHA5NKsNOycGPjjKlRe6K?=
 =?iso-8859-1?Q?X5/SpwJEA7PGCG+8C1kzXipzMm2EdZ4Uq3YP/ABpZ2XwK/hbXT5fLoVduh?=
 =?iso-8859-1?Q?pEVXiJqXndJ0L7ojG+TyhLnGSLv/zpQD57lDMQcWu5cvQwtVQViiv32hp3?=
 =?iso-8859-1?Q?OpmDT33br1fhhjNUOVcNrVB8WqPsl81MNky9IRIvJm3879FGAcevZCNgLZ?=
 =?iso-8859-1?Q?2BS5k77bA352CZYeG/vUDAZKCXnwU6uNYaUdKgtKY38UMb4sCHv6IySIfH?=
 =?iso-8859-1?Q?vvhiY0pDCehuCMht4WeNVMtikUFVCqgEOzgS3btWEQJV/li1ZQtTCrYCgI?=
 =?iso-8859-1?Q?HtdVxl4DB5C2sSb2zxTglDoZwOwrqm2/qajE8XifpDMXDWVJh6fyGMztw0?=
 =?iso-8859-1?Q?3v2veBrGY4WSs4rvLajC0OsPhdhU8xrLghZ46GChdWBWPKWmvroFg2gPAH?=
 =?iso-8859-1?Q?p+YHSgN2+QyWMGDKQCN6/+lWbk1Tsvd+qE/FfNplw2iLqDwjRv1oUmCwOH?=
 =?iso-8859-1?Q?uDun3jFxKpPdb89iggWpPgLMsgtERaoX65NjTDL4/v54Ujf7gEgw/WAw0s?=
 =?iso-8859-1?Q?M1XJg31DDjB2G7vyBUtVHbgH5QLzIWwxpZR7n/RvuSpwbAp7ahufqgzgMI?=
 =?iso-8859-1?Q?gS0ECbNpr++EzjkxgGx9k8jZnEt98nMo2dsIwcT/NKdDhp3Ziw62tT+ZKD?=
 =?iso-8859-1?Q?KHpH7n+ayq+uifqYG2O3g07gQmFCc4b6uwUply+EhOFlwsRicBzMnD3rWy?=
 =?iso-8859-1?Q?X19HpMecSK2PZZYGJN7gsBuSjPuLBgNR8+yBb/7NYYOa7fh8X4pkMFzIck?=
 =?iso-8859-1?Q?rMUbz+CvyD2KugmcA7Zumqd5HptZQtwx2lQ2Kt7ImTAgeftJwMDXgdkD58?=
 =?iso-8859-1?Q?24VTz7mEA9cdt/ELJZi+h64mTP4qhWO0ricpdBnUtPTaLr8EETUzAu/vCt?=
 =?iso-8859-1?Q?Zd/fPEbX3d97wmW/7EVxlboK4S7wqeBhTU+/64wIDk+6CilNUsmP6FQkJr?=
 =?iso-8859-1?Q?1cCf5LXqIplv5GyQbaJa2ojJJoot73iUzWejcnG7+w6BEYIgmEZPqYlnCw?=
 =?iso-8859-1?Q?7U0/jUGDIfMV8g8TvXgGFY5LMtEaS3w8G0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33a2389-0f3f-4d10-b067-08dcff655be0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:49:57.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXpSSla+jQos1UPPGC2JbUtChjzN4wR1basn+EagJ8e7Nn+XLlvA7YnNY+m2TrDgwWSGwGNehRK/TXEQjIT01A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7324

On Thu, Nov 07, 2024 at 08:38:20PM +0100, Christophe JAILLET wrote:
> Le 07/11/2024 à 20:18, Frank Li a écrit :
> > Use devm_* and dev_err_probe() simplify probe function and remove
> > vf610_adc_remove(). Change type of 'vref_uv' to int because
> > regulator_get_voltage() return type is int.
> >
> > Reviewed-by: Haibo Chen <haibo.chen-3arQi8VN3Tc@public.gmane.org>
> > Signed-off-by: Frank Li <Frank.Li-3arQi8VN3Tc@public.gmane.org>
> > ---
> > Change from v2 to v3
> > - change vref_uv to int from u32 to fix below warning
> > | Reported-by: kernel test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202411070633.NIrO7Ert-lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org/
> > smatch warnings:
> > drivers/iio/adc/vf610_adc.c:857 vf610_adc_probe() warn: unsigned 'info->vref_uv' is never less than zero.
> >
> > vim +857 drivers/iio/adc/vf610_adc.c
> >
> > Change from v1 to v2
> > - add Haibo's review tag
> > ---
> >   drivers/iio/adc/vf610_adc.c | 79 ++++++++++---------------------------
> >   1 file changed, 20 insertions(+), 59 deletions(-)
> >
> > diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> > index 4d83c12975c53..a6a0ada8a102f 100644
> > --- a/drivers/iio/adc/vf610_adc.c
> > +++ b/drivers/iio/adc/vf610_adc.c
> > @@ -160,7 +160,7 @@ struct vf610_adc {
> >   	/* lock to protect against multiple access to the device */
> >   	struct mutex lock;
> > -	u32 vref_uv;
> > +	int vref_uv;
> >   	u32 value;
> >   	struct regulator *vref;
> > @@ -823,10 +823,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >   	int ret;
> >   	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
> > -	if (!indio_dev) {
> > -		dev_err(&pdev->dev, "Failed allocating iio device\n");
> > -		return -ENOMEM;
> > -	}
> > +	if (!indio_dev)
> > +		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
> >   	info = iio_priv(indio_dev);
> >   	info->dev = &pdev->dev;
> > @@ -842,27 +840,22 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >   	ret = devm_request_irq(info->dev, irq,
> >   				vf610_adc_isr, 0,
> >   				dev_name(&pdev->dev), indio_dev);
> > -	if (ret < 0) {
> > -		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> > -		return ret;
> > -	}
> > +	if (ret < 0)
> > +		dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
>
> missing return?

Yes, thank you find it.

>
> > -	info->clk = devm_clk_get(&pdev->dev, "adc");
> > -	if (IS_ERR(info->clk)) {
> > -		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
> > -						PTR_ERR(info->clk));
> > -		return PTR_ERR(info->clk);
> > -	}
> > +	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
> > +	if (IS_ERR(info->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
> > +				     "failed getting clock, err = %ld\n",
> > +				     PTR_ERR(info->clk));
>
> No need to add an extra PTR_ERR(info->clk)

yes, dev_err_probe() already print error code. So "err= %ld" can be removed
also.

>
> >   	info->vref = devm_regulator_get(&pdev->dev, "vref");
>
> With the change to devm_regulator_get_enable_read_voltage(), is it still
> needed?

Suspend function need vref to disable regulator.

>
> CJ
>
> >   	if (IS_ERR(info->vref))
> >   		return PTR_ERR(info->vref);
> > -	ret = regulator_enable(info->vref);
> > -	if (ret)
> > -		return ret;
> > -
> > -	info->vref_uv = regulator_get_voltage(info->vref);
> > +	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
> > +	if (info->vref_uv < 0)
> > +		return info->vref_uv;
> >   	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
>
> ...
>

