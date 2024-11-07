Return-Path: <linux-iio+bounces-12005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BEA9C0EC5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 20:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509FB1F2809E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9242C2170D1;
	Thu,  7 Nov 2024 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtVWRKv5"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CD194C92;
	Thu,  7 Nov 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007149; cv=fail; b=IR56F7FaEsaUUqCC2wJZ8oY3yOMWXlLBMAgPkC4MxhnTlBHStaTsuN47Qa6yaOXbyoBzugTX/VwsLvm95X8t+XoIskg6k9gNPfa9XPmoje7F+q93pHG1vngAYbWv9qDEyhFlOIAZPmj1Oz41i6l4wX1jIVQExoRCVeilfAYTiUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007149; c=relaxed/simple;
	bh=dTYBp5yNo90AIFbbUBF2OWCu4o1mYpD7xLPWFMAw8kk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nq2pQ9Xw/Fm4jMooJh8T89j7qpxrQ2xB7ddU+UOIJELvsFhLvu+GxoQcPQQp1Z/g2xW3IVUiwRknIHSUQW4awAMFGxDSm6/sc9fDpVFjAZ8wXUzqTY+P2BVePkc8hHyMdeQ84iYeZsSEjesX+ezpAb/YSgNy4ixagokYe1yP0iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AtVWRKv5; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4v+QpbhSstc+ZV3Np2/mPSWVx5GZc9BbCUSSvqN5+p5YmMSYBDNFiF7UpvBpZgXx+/hSAsd5LCSwPT0SQaf4lc/vSkhMqbFljFTquiL+BIK0NT2L4XQKRvr8ChBmdMmoI/OCh/GLhUuNvtQSO8NJ82XkHYt4yLOkE2pEBzbPjYGy9IBEDqFOdW8FH16nGann0QQQvUJ/zK2NwGvuKq/TZAhXQL0NHTp+JEyxJLgf/4JES1F2t7kOqP+o9ARiENOujO6kmwvNxu69JupjYghRuJ1OWeL/BEHGvlm+WCGvdPnpB2zo0fWddiHGy9ePy3Cvsfy0RdEUvsF74yCT4zGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81gwbHlwd9a4GbiegJJ2Fg++MYkxPOY4fp/jDl9T7lY=;
 b=Dfe3ImJ5HmwYfgX0AYt/u2Iw/syoGDkvhh7M5JHlctpciGGTAjRlhjLXcMlStPz7qalNMk9qLe7jktNciGICkmGUASWP187fuuoluP1qwfIPgkiu2xkwPLcDh3/hoLlCFLqvmRtx2PK07TscqlVYF72dy9KtnumrHGdMhS7lH8RUUf5xwMz7Lox7y/Edzl0cSRYYh3ZczN/oY54dQveHCUf/aDB8vVD8si6l0lAQKJ/j62DqAuCWrlS+7hdK89a85yb3bz5RxkRpRy6O2tXz+qTonVHcd+ags2GvjfENfKQeipiuSbA3TzoeKRudbxOS4IV00OSB7fbuzEBC0kne4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81gwbHlwd9a4GbiegJJ2Fg++MYkxPOY4fp/jDl9T7lY=;
 b=AtVWRKv5ZSz1Dzi1zHtb1sw2Bo+2BG+HQBwVD+BmJIroN8jy1yUK55oU053tSEUei5QJYrdINfPx3jeJkIK22+SrDCONIoUPBKL0wIjN80CePf7FXhbYzMdTeoaI4UVt96v9JJ4mrXPcTIkUsVB5nFVs8blmDhaFsB+o1E6zP8hmlm78NCE8l2AOqfUasdkc8m5W56et0APxOgiuBdBEMpLU6F1aA1jMAqjUsHJC7OADYFHxr1DpiFzCOQVChneS9EkEDGgMqrg1dNCvj+WsbaWIcZStKRheqTHwg+2OJljCIg587GCl3oPaKKXa4rfALty0bzJ4Tmt49PVB5KvYrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:19:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 19:18:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number to 4
Date: Thu,  7 Nov 2024 14:18:41 -0500
Message-Id: <20241107191842.3002319-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107191842.3002319-1-Frank.Li@nxp.com>
References: <20241107191842.3002319-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8bb39e-f5cb-41a3-7380-08dcff6107dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pyg+wAKz8MXsWuPPGQh4Rv/rGnthYEdY/mknLFVI21MpS6R74IhcSZHkYnnW?=
 =?us-ascii?Q?a/50bredYvS+sbL+DZwWUM2+rL1IBp6TsDFPMwn2pI3ShvqSNrcXv4/lJcBW?=
 =?us-ascii?Q?64MyUVYGFYXbaptmZ5ZIi8AEGUbC/jmORQ9CBiauM0D39lrXD+K5IFQP1MB+?=
 =?us-ascii?Q?rDDZG7qfMdICzHNlF2PHSxU2xJKhkN8kStTLhkUX8xBR8Gm5NDCe4Q/QANb5?=
 =?us-ascii?Q?n+H0x2rvv2uf8My+qpQ3Fiv5Iz1X/UoHv5SuxsDsmNYQZ/aYJI5baE1Oo3C+?=
 =?us-ascii?Q?Fy39Am4fzKfwlwDtEq2EHGg/W+SspDWupUEP9s+C1cJW7Bid+U0qdzRBEeji?=
 =?us-ascii?Q?VaTXDhqa0KzknXKGcaPdoHeU4XUXMyegz2aVpSCL7rP7DnEL9vN+t5RITeCD?=
 =?us-ascii?Q?qA70kdjbnBxREQWhh9xM2EBG9DyUK7nqskNoAciHsMkTgTA1h5YCAe5vksdO?=
 =?us-ascii?Q?NA64EvjtgT8UaOPhvT/fnKyA533z+v1S/FmQIxo3yNjkl/cvyWex8S1P2Q5k?=
 =?us-ascii?Q?6YUGVpqLlrjwqFuFzA3caifJp7jx5dR5eMHR+rCZ0EMJVy/ObM7/qdn1iueo?=
 =?us-ascii?Q?MRROIJtFIING5yaWnv9+1He+vkqV/vsXizAr1S5ITSo1dXoTolovmtG3KYC2?=
 =?us-ascii?Q?BkJvah2sG7ITkQjTAlN5RzaE8wKQnRJqfo7fZoRChSFb8BHQ+XmjW8/5VU0C?=
 =?us-ascii?Q?kfkRdkJSp//ClxxZGaiAgjw1jfUICJgj9fYO5+DuDmA7bhbSLKyxzFUZBbJ3?=
 =?us-ascii?Q?w0DLJGdXOeE6nl3mdPH8NC/JVzlkU+oy5suHD3r8Mw0o9A0NdeNRJLRLWVMU?=
 =?us-ascii?Q?6Z/A1ibsmLB01id1P0XrpfpqQZ+RaoWlhBnc+osmV0zkXXJUHSmQBnQXXzL4?=
 =?us-ascii?Q?U0tCL7tBAdwq4mMJMCDZZjgyN05RDFr6UoX1JZ2aJvaSd4dRDPLLiO+ZHm8c?=
 =?us-ascii?Q?kJNgv103lNcwrk4jhbkBwmPTe6phobyVuU92LR2/x9tyosSo0zjpJucwCuG9?=
 =?us-ascii?Q?cTpv43wSWHaAiSu6puAzrNFgxGgx/CBastcx2xK+8dWoMwzR+N8a4N8nBeuK?=
 =?us-ascii?Q?3Mr9UFEqIN3o+OxDVCKY9btW9CHi0NsG0f9ecQMeZDYAogDA35i7h09SvC5F?=
 =?us-ascii?Q?o+1OUh/7EegMh6V44ZO+D8zd3mIJQ9gKRxrCtxZfJTxLDPwaZGXemDio2Jh5?=
 =?us-ascii?Q?whaIWbY2Vi++DPqmp68qiYbjqi8BkaKRTd5wT0koNwgyS3KWpuIq3v0kF6No?=
 =?us-ascii?Q?j0O5+uZizVzng5KO69cS2dZ/SIkhmC4UD9BJi/qQzh/c5wpxULO/ALtdIElq?=
 =?us-ascii?Q?mn9AWdfUp17Gy1WaU8LaEf5ZIqkn1lHvJnef+5GhGpkCMOT9eFz32S/zd4Gr?=
 =?us-ascii?Q?rURJu3DJeAj9fVaOV62fHFj6ReOR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Qe8Ej6gvf5v6hWJJRmA2pxvf0wu3Vt5FAg/n7fjZwzBnPa/UjNdmll0XJMM?=
 =?us-ascii?Q?KqWAeKQY5M0CwAJwct7r3EevrvH3PthFwvEAqj85YK33NS5ye0XcyL8+oMnr?=
 =?us-ascii?Q?gXNIhu5EwhS4jASoPDVON2fkVJMY0b5L84NLWqnpLAuNLEMolIx68cZX0eEW?=
 =?us-ascii?Q?wdIiV8LRtbt32nXSCXDSA5ZRLGs5/+0pnNtwdrWZ/5O8F23hN1B+5dQyJ8YZ?=
 =?us-ascii?Q?7M1acA/91VPf4aSx0zfPM4Zv7Co9lq4pdxlC8BwE4grfbZR1vsCiD3AcFSZ/?=
 =?us-ascii?Q?BHs7+AoWHuXvmWI2qQWk+WyX9upSb3xHZj6qCmNPd3lJv0tvgol7KIAwHdXs?=
 =?us-ascii?Q?Gpo3A8nZLVNPPL8mfiY7oTb7OHEvgLIOYwUC4PRCT1NedFswDv9wQcYNCJcW?=
 =?us-ascii?Q?Nd05JrqAQRznXd9x8NU+JLsBloDWCwaAByORsFuPVh44xEqM6vMfHUMADzCu?=
 =?us-ascii?Q?mBVMUL+lW+dvf2ZNbJ2vK04SADErDGcNIZNCbHvZnoX9GZIM4jYTZeokeMGr?=
 =?us-ascii?Q?UKI6wm5Vma6XUzVKE6/9UOYhFOD1j83tBVIXdHqC+zMPQcmMZxGNkJukmW6L?=
 =?us-ascii?Q?eXZKUKFtOW2hkuSD6K3jbsjqbHX92atXRYfSAIIXtPUMz5Ra+0mHs4ESZpCt?=
 =?us-ascii?Q?qA9T/yW0Dibbi32GFuvM0BNZ48ILPd4ZtaBMOcMPbNEBPMez3k3LE3RE7WcN?=
 =?us-ascii?Q?yWQiLqZ7xl6ai7ms8rcdlK3Tw9wZRhEYrDkVjSNHkXqJuuq4AsQet9KRMGLu?=
 =?us-ascii?Q?Fw4FJHchnmyQ9pHpOhka86j0T2zj4iyHxq+xomQS/dFlSi9jMJy5fNB3MEFS?=
 =?us-ascii?Q?Ax49TZYeh/91ikNtoilYpXgChLrj8aiS+/5IBYdz7AtnqfwARFKI1mDnB2zK?=
 =?us-ascii?Q?3FVQa7VO1x8NorSDiy9krYyP4YqsLAhIOswuxXMO4QAKXtK0ium95ous4oer?=
 =?us-ascii?Q?JFNEYAS7xdyVa8rcxo6LbBxNcpjmlGZFBBHaH4ne/ir/H1mpi78nkfyfkOci?=
 =?us-ascii?Q?0L3JseVlHC0dX3uzIWIqDnLFJ50sbeENUTzbwiPrSXDP/p8p729u4yHvIEnX?=
 =?us-ascii?Q?SGrkixfYUDfzwTVhEpWJ2Pwru5lvvYXuTEHiLfp3J30GxhASCjbeWDa/c5+x?=
 =?us-ascii?Q?3cWFXooptahpcl275spbat2wI0GH8HgFqdIsHbFcL9B5ByB6jS15yRtcgT6h?=
 =?us-ascii?Q?8WkzzLMsmsMk6jBiqxCRTmOSOHDZsuEQ979qjw/puntIY5XH19ZC5BThbypX?=
 =?us-ascii?Q?mXs28cccDoC81mTXIxLlIeE/FGWf2l+r3IGhIDkyJCBq8cY9wQxSYbQRdF2V?=
 =?us-ascii?Q?XIYOjHr/h9JJ4Fv9jDpIGVseqD3AaQUwYQGUFPFV/185ucaTWCu5BvjA/mLV?=
 =?us-ascii?Q?27SQ8tfz/isKMMpel//nK5UNZxezDezaUQ0p53dCULzKdFZ9clRNruM5GRNA?=
 =?us-ascii?Q?vPqzn6DzScI8E5qtGBlZGMHKxI9cqwamtbyDq/7ZiUy0zlv0MWiPKw7hiD+t?=
 =?us-ascii?Q?u9F0BcS+vmUOGp+VGsPOIMfRzx9W9QBcoyIh9a9lHLQhr63ucjjrLOcRHOIy?=
 =?us-ascii?Q?JDFWv/AIJuWvYeeRDUdT/hNuha8rFo+LaxsSOTVC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8bb39e-f5cb-41a3-7380-08dcff6107dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:18:59.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPVfPlZI31Fkrg2fpkNoJ9Amge5Y1rjcP9TW1B45tUPCn+eFgEd3UI7sg/LKUGgso9ioWHzuzrjuHvnTTuVSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344

i.MX6SX only has 4 ADC channels, so limit channel numbers to 4 for
compatible string 'fsl,imx6sx-adc'.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
compatible string 'fsl,imx6sx-adc' already document in
Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml

Change from v2 to v3
- none

Change from v1 to v2
- Add Haibo Chen <haibo.chen@nxp.com>
- change cast to uintptr_t to fix below warning

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411052345.gyJaM3h4-lkp@intel.com/
All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/vf610_adc.c:20:   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~>> drivers/iio/adc/vf610_adc.c:874:28: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'const void *' [-Wvoid-pointer-to-int-cast]
     874 |         indio_dev->num_channels = (u32)device_get_match_data(dev);
         |
---
 drivers/iio/adc/vf610_adc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index a6a0ada8a102f..36f6132bf5ba4 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -809,7 +809,8 @@ static const struct iio_info vf610_adc_iio_info = {
 };
 
 static const struct of_device_id vf610_adc_match[] = {
-	{ .compatible = "fsl,vf610-adc", },
+	{ .compatible = "fsl,imx6sx-adc", .data = (void *)4},
+	{ .compatible = "fsl,vf610-adc", .data = (void *)ARRAY_SIZE(vf610_adc_iio_channels)},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, vf610_adc_match);
@@ -870,7 +871,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	indio_dev->info = &vf610_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = vf610_adc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
+	indio_dev->num_channels = (uintptr_t)device_get_match_data(dev);
 
 	vf610_adc_cfg_init(info);
 	vf610_adc_hw_init(info);
-- 
2.34.1


