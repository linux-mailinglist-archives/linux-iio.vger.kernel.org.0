Return-Path: <linux-iio+bounces-13189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE89E7C0F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 23:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B567A2840A0
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12555213E99;
	Fri,  6 Dec 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LOllkyBF"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2257213E7F;
	Fri,  6 Dec 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525822; cv=fail; b=QaEJDSz52Wtdjss+80xi/FYSwh8LGYK6Ys1UZpK5FpmFJqpTBa4D4koBsqCj56YhFx0ML1FYBhiC2rqP1gtg6355eDJSV3fWGjlL4hNAsuzFC7eS7jJdZFeqgDgWktHk78i/q8i7tjuaMhgcbRcdwzHAYS/pwE/dkRw8DKVAcE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525822; c=relaxed/simple;
	bh=uXbp0XllZwIzvbFqkk5iMzXc+aKoGQmSbAy7pv4AWs4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9Q5xQxZhsQEbhZkAxScgsKq0DdM5i8kByc6U8cFG/YY1JUJnBCTsIqA2IKWthZrYpM2PZhsbeD4CJUdvk07JCzTQmOtC5U25DWUFYQzfZyEkGJd2ZKVBZGjoVRo3dNrVIAR9n/6WuSb4VkBbhYwakXLFH+nNCY23Sd/ohqLIlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LOllkyBF; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj1jloDodM+mLHYH3zVq7p2ohzZQkW02mhS798BQHVKaX2dYRwUBsNmrUCm5TJhyaKozjtJq6Bf9Mg2bhDKSv+RbDVm1JiGcHpIxJaTKCTirW2mdmrkxxfgrb8NF3U7AhRr+unOmjv0MufJ1UaIQ+E8Pq2WQfhls7EKzMntLxX/cPeeXRwheZVownSiGh6lziorzBovgAEAXieKPjtFHdJA8CeZekSrWluwkmRXs2mR3JPP1ob2pGSlun4HUePsdLwSntRDefNe4F42d7pCQgG6DZtagjDXYnVZuCIBjR6udYXaU7Wy/cA1jMTA/lwGDr+e1Q521i1ZQ/y8yDoB7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uFaRLh6BdwDuJ8Mwv8gLyiNqir4PRNnz1HrBunXk94=;
 b=rkshQJP4TP3KSio35KraOOsif9HHxyuAktNTqV9KoVIC9YRg5xDJf3k3OWGNCAgjS8/MgCvFRp/JHYCqCUx2COW1wzKnZXoZ0AsQAimDgpH+7W8xeL8Hf67t4RB3eKfvHCBiKPXYsh9jsTKZahhmssB96SVj/FLo9aPl/yPLS/45K+0tmMMV+kjZTN4WeXctaY51slNzg2XFfPkg2ugirm9eKfGmmcdGv3HP04f/cDwMsJW7vbMPGwV+HOKcxTVECv3izOEQ4fEJlnTnDxj7CKX5QlNtuFyepbrpqkcLucSnyls6DA+S6/nlg2wJCgr1UUB8lOdmH09P7h64ELkaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uFaRLh6BdwDuJ8Mwv8gLyiNqir4PRNnz1HrBunXk94=;
 b=LOllkyBFgLuKP/T8OVwnDkf2KVvJglZIxQKwLwv19Cvc1Bjl/kSxwXR4kDViZ6CdiwX/b73UOt1l6UmJ5ORe6bRtIoTcBwzRxpmd92BjPpmyK+5ymI3yBu6ONPymapVIhZCxdTz5giZy+/Jp9zvRzbqz+278DY1d6lbh8TZmM78g39aW0khUcg8iSs4gqMx/85cE+d9B/Zi2B6o5z5vhWVm6+BLNcT/xx7fJbjwn2NwKvZFQpFFN1fzRmMyWGJs10oiiN+/es05GgdgFDCWk6vRT61sVIOVk1RizrV8k6rRWIkYB2FG53p5L9gQmDPukyxBWHTM/DDGZKJZFiI8jJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10709.eurprd04.prod.outlook.com (2603:10a6:800:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 22:56:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 22:56:57 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number to 4
Date: Fri,  6 Dec 2024 17:56:24 -0500
Message-Id: <20241206225624.3744880-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206225624.3744880-1-Frank.Li@nxp.com>
References: <20241206225624.3744880-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10709:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4750bb-5696-414f-8be4-08dd164948e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JNeIkx1T1106ycWubX+2QTneCZM3uWnSCAxQ3Gf5oQSY3yDsRMCPEGLPVYi6?=
 =?us-ascii?Q?SLmHPwvfyOnx68/2drm/hfiRvj8oZzgUMl44hndCKpbCn+0OwJlaVSLZTZ28?=
 =?us-ascii?Q?eKBZV1YHbLjQJvDdk8SeCK86keqUiDOWwlbcl469NZIyn00oow+sKAk35dzs?=
 =?us-ascii?Q?YUJJHRuQjY00j29GdqHeJK7jMfu9RdEzbPcFe61yLk9by8MmzWnhqA6c//LD?=
 =?us-ascii?Q?1jqygu7pDPGM/n8fTztFsZKlnwYE06b+2v6hoU5cJO7IlgQqVfXUIuQKkW0q?=
 =?us-ascii?Q?I/SsYpALLuhzWich1uOW0cVUJFNUx1sj9ACBG2WL9/g7Rl+p6DarB3XuRuaw?=
 =?us-ascii?Q?ExOP8/CX/FlzRmYBpC1XFw6WL550hyH6Mz0jRrqUDtvUrFXrjZEKDwHvZxnZ?=
 =?us-ascii?Q?V2cMLmGlEkW0eMbkRUyslRsALsNPQo22J80UZOTQXvDBer8WutOvB+xFXy4W?=
 =?us-ascii?Q?nECSJjTgy9XOB51ynOFfp4hCJNZiAuSBWQtFxa90XnzbKleQNOdDVLMH514B?=
 =?us-ascii?Q?/WJPYGOf3fu0iJ+BQHLXZGxC0RVO18aqAP9U89Q0gJCclTwPYfP8JisduJi1?=
 =?us-ascii?Q?Nuu6zqH02xEm87o4upwsv0ol2Ok6fmX70Nvzas2BouITAt3TXpQ8mpiM2a6o?=
 =?us-ascii?Q?eEp74L0ajLsp5lu88iMRujwkJoPnPDokYt0FooiOFS6Z9B1FY/E61nSyGvDF?=
 =?us-ascii?Q?jta9O2CkQNFRvhB2ntPRIVMYZvIXmvt7ve1HT2QewMDXMJdrF+LZrFBkmULL?=
 =?us-ascii?Q?UQqaPplHIBh/8P3HmKBpooVosVvvsy3+v5b3uiPHITg/J3JtSUbkE4G/zz/7?=
 =?us-ascii?Q?EpNrcqAY5RPCNNPhrz1GfdoYoDGhJHi1tcUhucwvclqP1EczKTFGhz452ukl?=
 =?us-ascii?Q?/QWhshQcCc8CFYXlkLJ/1iUO53BWXc9kl+XSIP4YtS2xBbbizAK9rh+Xdkiu?=
 =?us-ascii?Q?pm/RgnRM1vscx8VlEYLxmm9YtwrMp0jKi4t3LCJIx/gMCrAqOk/06eCt/kYt?=
 =?us-ascii?Q?tPbVoIhAAK292linxc0Z+1dRF/i/EfpGvEHzhkPoLTD7jamiEzyNnemwcrpy?=
 =?us-ascii?Q?m87dtjlUiSlBefN+23pWEyucI3LUFd/aOF6O896khLjYKGg5F8EffM2ZRwvm?=
 =?us-ascii?Q?p3CRY48y6KeGvOlbyaLGh/zvppFzCsjWmBMuA8DaEWRDcJ2jgfIf8Go1ryHN?=
 =?us-ascii?Q?6PfQwiwpC+3oxdiG8/ww8477TPnxjPODherw4D3W3+72uWKivLpAMusoTo7F?=
 =?us-ascii?Q?+2gL8TNLAV6fapoN3DajyFRBV9Hos+PCT2uphJcw7UjGwcEOQpMitSEqY4Wx?=
 =?us-ascii?Q?yWq5qxOe2mghDjcK21Nd33qPDMZeVoBetalUtRASvLE1ZcP8IAtXzGBQxmVp?=
 =?us-ascii?Q?ZLhipftfdlaLEaJ2EEGkm17mpHXbdtSrTbKz64bzqQLhX6T9Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJCAc1ekxY+ml8/gZwAnAmxA59zoI4/WRGXwRDtyAi7lS2k+obC5VgH12OV1?=
 =?us-ascii?Q?DcFAY+euGK46N/unPCXh0DRT+wHqdP3GGHYoqvinzNzBD6h8ALC49Kz2j40w?=
 =?us-ascii?Q?vLP/mQ83olrd1QrnV5UBxz8c2DRjJ0w/e2Sbf5V/mP1lV1Caf7GMzyfxfGrM?=
 =?us-ascii?Q?mQURRL2s1xaB/cYPvwLJD56JPGDuPWgDQlumFrP2B7HmG0gTitCyGrIsp1Z2?=
 =?us-ascii?Q?R4HpFzmmK+aZsbQlFRqiO+YuxShhAGPY3RHH9emjIadjgJFn46+IMfPsAtX2?=
 =?us-ascii?Q?yR7w7YdSYmhurYerD6B8Wr4e0B26V2Q6m4LAPauW3WDAyzw3TEl2PlQ/Vt4p?=
 =?us-ascii?Q?DasQvnHVsQ2yLhl4rMw8qadR3fq+EbVNw0U1fXmo6YfVUbq2Z3DZmSoJmL/j?=
 =?us-ascii?Q?gBMElruNwFVDDAB7yBY3BR8J0/QqulS3y5fOaWXEbsFNjWI+V28GF98g3q71?=
 =?us-ascii?Q?aP5ARUm8QJU1v2RzIeN+czAvbkIknYXfDEM17GmtusiglaBRwxSrq/KH4/y6?=
 =?us-ascii?Q?8PCxJVvL2O/MyWaU/I/8ELtJBoDea9nO9sbtN88+PIuq5viEFtFkulp9UxIX?=
 =?us-ascii?Q?p3b2cqX/r5NIa7k/+3wJUfIgR6N7C9jLchM5vJzNvBDJ8cEs8F1eO/L2MU2X?=
 =?us-ascii?Q?vrCbSqIw9fZoGU19ISrKeLA+Px29uEpnJXipl02SZaFZicvmE5wPlyjmBHgi?=
 =?us-ascii?Q?Qgmwk/L8IdLRsbE19VVcp1RLvRZAKsgH6rD2zkUKqd3/gDEKkbN3ZLLVjy3C?=
 =?us-ascii?Q?75cUum1QZpR44nHS80mYmten6F0KTmN/X8FXHAr+DiG+AvXcmXDruMQ5oK4k?=
 =?us-ascii?Q?vzxrggmTrox+uYdsU1ik5GvoMp7VsMAvbrxBeqJ9rtohiwu58jed0fmOciGd?=
 =?us-ascii?Q?NUc+KkcbEdoHGa3WaUiArDa114q7j7DPZDSnvJbDxsZehcP76NLofuRgtPaH?=
 =?us-ascii?Q?d3O6ObxzTUUH4il1UOyiVb0k9Sb4aaaIhPhwOZKpydbM740MjSZYiDoz2kum?=
 =?us-ascii?Q?Q7K95xjSWkQaVwD4LTKxgTPqIgwrc1EkSPOIS8OikZjWAYsoZge58cGkvTaI?=
 =?us-ascii?Q?U85fw1eXrcLGeaAEzI4Qf6NBJcK8/+nMkhSY7In+lW92goCzz4JtXMr8vqEU?=
 =?us-ascii?Q?57qJ8FEwqSSBqt9StOAJTF5LONVwes0TvraGI9Kr2RlFqLGM7nuIAQM9ODOU?=
 =?us-ascii?Q?JNXqavIcXxcFnksoSaqvh6aMwToilbdsCGOh7nykn6fTRG4ktV2TOZ2sHsWQ?=
 =?us-ascii?Q?42GQsyN1BC7vCiQ92q8eYHQETGAMSq1bGT7qLjD4C4oT7oSLmdE81mwKqQbS?=
 =?us-ascii?Q?BPdAN1mh/LQCtf+eu41g4Nj18enojDl1s2NwQqxJQK5h0VZNXWm/UJnotE/R?=
 =?us-ascii?Q?zyjcHBvZi1kTz0NhgwIhWtr2IDKlu0N2qaNs2ydUQXIl3FjebIHL1VZ7Y5PP?=
 =?us-ascii?Q?8iK7Ppwn+w1YpjS3dLKBQYbDuaYF9iY7kPEHrHaOmxW24u6ii6nDnhCZURc/?=
 =?us-ascii?Q?x4OuRwsUBs5bkrzqd/wCFXK8qp0l6MVcIZmOqFKIZu+wJXSnwfAJAw6RW4u9?=
 =?us-ascii?Q?gqBHma2hdE0mW1rOWjZhYY591TwdfIfVRdMBkIfS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4750bb-5696-414f-8be4-08dd164948e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:56:56.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VG90F8PP5pcnY0lsqDhKeBQdVEaHXXuyQvbCeuxGSNCqGT0EuwrUwqSCSSaPThIicf3hG7j7MvaPaQioktfoug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10709

i.MX6SX only has 4 ADC channels, so limit channel numbers to 4 for
compatible string 'fsl,imx6sx-adc'.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
compatible string 'fsl,imx6sx-adc' already document in
Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
Change from v5 to v6
- remove return value check of device_get_match_data() and move it to
declare place.

Change from v4 to v5
- none

Change from v3 to v4
- Add struct vf610_chip_info to avoid cast int to void*

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
 drivers/iio/adc/vf610_adc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index fb7afa91151f2..850453be7a8a4 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -177,6 +177,10 @@ struct vf610_adc {
 	} scan;
 };
 
+struct vf610_chip_info {
+	u8 num_channels;
+};
+
 static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
 static const u32 vf610_lst_adder[] = { 3, 5, 7, 9, 13, 17, 21, 25 };
 
@@ -808,8 +812,17 @@ static const struct iio_info vf610_adc_iio_info = {
 	.attrs = &vf610_attribute_group,
 };
 
+static const struct vf610_chip_info vf610_chip_info = {
+	.num_channels = ARRAY_SIZE(vf610_adc_iio_channels),
+};
+
+static const struct vf610_chip_info imx6sx_chip_info = {
+	.num_channels = 4,
+};
+
 static const struct of_device_id vf610_adc_match[] = {
-	{ .compatible = "fsl,vf610-adc", },
+	{ .compatible = "fsl,imx6sx-adc", .data = &imx6sx_chip_info},
+	{ .compatible = "fsl,vf610-adc", .data = &vf610_chip_info},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, vf610_adc_match);
@@ -824,6 +837,7 @@ static void vf610_adc_action_remove(void *d)
 static int vf610_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct vf610_chip_info *chip_info = device_get_match_data(dev);
 	struct vf610_adc *info;
 	struct iio_dev *indio_dev;
 	int irq;
@@ -881,7 +895,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	indio_dev->info = &vf610_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = vf610_adc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
+	indio_dev->num_channels = chip_info->num_channels;
 
 	vf610_adc_cfg_init(info);
 	vf610_adc_hw_init(info);
-- 
2.34.1


