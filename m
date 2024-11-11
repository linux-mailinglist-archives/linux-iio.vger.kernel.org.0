Return-Path: <linux-iio+bounces-12165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A347A9C483F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F381F226A7
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1781BD4F1;
	Mon, 11 Nov 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fGdbY2c+"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06551BCA16;
	Mon, 11 Nov 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361165; cv=fail; b=ORou67yZTAtYwf5CBzgi7OzZXSi0qMRUia2LXcnVIoqCadjdWPALMpuE7J4bPkIAMQf7bc6DhgVAbHDBFg5343BzKTpMjhOjKHHYaGBxTzjbZ0Iu2p13X0ilFNDzSGoltvqMrdUsYQ/LpfLe7w4aAnDKjZP8YfYr9l1nydetD5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361165; c=relaxed/simple;
	bh=TC6ECWjUyutwuSLCUvmGPD+KBN7OSGrn0D8wCIVbohk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gpoAkElverbXTo7TJRQp+jyKv7HmKIZqDq4yvpWn9WLxb7KBJxCX+KLYqmeti/lvrgUqGQ9AxqNN6eFWGEeDhcQlk6CESyTOFElx9eLe5U4w4nhTaT+fixnfG7feISXzwId6rQaFghjouyOnTVLt1p+HCBdgx9x5pkrsKqpOUoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fGdbY2c+; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtlY426y4IVjJVGUSKJbV4WOE5sb6A/1ffY4zd3OEE/1GXv9NL+jmGooP8SuhZcs83IiiDaqevSRbQ8WDqoHy5lIZnQP49vWBzuHQhzdWdEyq68Kyq8kCmdsEIs1KUTHVAa8vIBSq8ob1SVRhNwMf0ygF55YmPK4I34gERVQd05RBy9Dr+81SZHGrraylZzpU2ANSNZmKTmkit+SLYnyPmVA3c45R8KYouHwnNtL1mg5thLEArnU/8S6NPCaUyc2PqE7vJ87tW1B3kfQnPXOAAIBcExD6CgBjN3lpx7lwQEsHYKtOiOrGiTHAVZH8kMzdtRECxeghaU5HC8KRJqyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk0QytXGXOBAwOjegdCPUYkku/3sr6mJ/aD6VCApn7M=;
 b=UpH+oR9XkZodNgt6zyrxjrMDGKFs7d5PEeOp6L2PLPUj7FzZxcGKHL+E6jk/raLkwc/AyumbJLb2bZcqgOmmFLrXjT4SkjqqVWfSLnhjk1/0w97cZUCcQhD6OiCEuNB9NwggcWLQHJ/agsH+W91nKE7QGEj2YRGNiHSvY/eYCxgyUwrrnjpSRJyNyBZ8MVOCLBM2V9sBgniDstVhhLNpuhyxwc/Sc4TB0KXXF6cFMsMekD9tLrzlZ0oR2qI9ECchGaROWC0MX4ZSvGxHnqx/EtyG5Xan53WYuXFaMjXCo+R8dclYmymPMWsah9K5Dwq5eqCJXtGAKA8EbIS+WgD8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk0QytXGXOBAwOjegdCPUYkku/3sr6mJ/aD6VCApn7M=;
 b=fGdbY2c+quAZDW/tj7HrvgflNjOevGlkgyyaixEQcALHZvSYrZI6hWhJH/8f1LDdDJZgu2CwURhX0wpqwgCloI8kRa+YkvQswc2B21rYTBpJwkfHUjsjIVAzXgW857fHRIJ7ypgm87Bm48q6vTjP7GTA0G64PnDz8jdVu8IhXzmVtd+xMADZvshfncPQUwh3MMuJ5FYoEw9i1RYJirXR8NKfwJhwbc9sSIcrghyROQlbFVJX1haZuRhrCKnQchhzBZrepve6hsR3qsEHOZh2c9OY5dRHg8eVdlrBqfBGYZkVBr2hGa/+WVNv0+oe+pRJpra6yE1uZto45e3+jeXpSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9738.eurprd04.prod.outlook.com (2603:10a6:800:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 21:39:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 21:39:17 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number to 4
Date: Mon, 11 Nov 2024 16:38:59 -0500
Message-Id: <20241111213859.3317909-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111213859.3317909-1-Frank.Li@nxp.com>
References: <20241111213859.3317909-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: ab92004e-d529-4519-cede-08dd02994b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hubzI68HTU5utsSO6TlkmSolgsH97031HBI4+oqyp1p2ohxZb3gpboLbdmh0?=
 =?us-ascii?Q?F7YqWKzHAkuVRgw6+NbhsPojwjh0qM8H4xFOiG/WNrzZps/EEXVryTMe5DIj?=
 =?us-ascii?Q?QxVU8dXM2GEFX1BJNgJVQO0CO3lPh+3pCddVT/dg4GK0z0lzK9zutAsZ5EJ/?=
 =?us-ascii?Q?0UDjAM+06yfTn6kdygByswXdcHc/id8cFgFXbWq+PbF6G5REmTAR3Jc+zo5n?=
 =?us-ascii?Q?+8gBNdFPMhvZytgYEtNwA/oLHKHz6r6dmtXn6Y3E7nI7+ZsCcTgnLZM+MHT2?=
 =?us-ascii?Q?l9jxuMT2f+EHJxc/ksP5mLoyPiRybkDZkcHCbvJhrIJ2WSeM94abwzH2efhm?=
 =?us-ascii?Q?Cxfncl2TCKOuKqY5MV4fAOkA/t25vn2j7YHQov2nr13cEjEhWMe4fj7oAyYn?=
 =?us-ascii?Q?HWTbx3jDvxmXEWOj773ac4hPotCrhpLm+AAmyZbK/p0yFRL79geJPMIqI9fp?=
 =?us-ascii?Q?x3q1+HlphBlirdLp7YqfAfUe6n4hQ/2dvPvjswWVVGgT+VqmItzz3129BK27?=
 =?us-ascii?Q?5QkwPFcZZQhKrwQEdOpps/6HfWiF7R0tdkCZQbBpVdZ4ASY8/kC/bvBN3TSP?=
 =?us-ascii?Q?f7zVNNCek0Xae95ldh1dZF78oKGjcK+8cAD8OGnFH9PM1aIwlXKFr/thke49?=
 =?us-ascii?Q?k6n6PYfdUIPx/dKvYJ3FmDQZarr62A4TFOmFKe5qeBCB5/ggkRryIYKG2n0g?=
 =?us-ascii?Q?YHO5AUAYEJ1q+5XJM5XKfQpkPMfzR3ZLtkOvAuEqBqYt8dpLXShRbZj4JQbr?=
 =?us-ascii?Q?PIlmytoBdXcKt/D3WYkVpF3iTxjdNe+K1ER7qc6uyVb2+ItlJWxwVYteEWPR?=
 =?us-ascii?Q?2MQVa1G1+VsPaDtKfJ85Jvz5975kEbktFKtmwZTBjLydgAZ5CY+oOQdqtSRF?=
 =?us-ascii?Q?djGHLCy3HJOhOPeEv0ZP3tMDsXtQA6Lf798zC3q4sG+/6t39FjYR1Mq7umPH?=
 =?us-ascii?Q?JGBWWJi2XPmQpOfGbx6b6+je1CgWL3+f5VyzyBmzyZm4CGm7TRSssQY37uks?=
 =?us-ascii?Q?g3IQYeZ2Z41zh8aCsrzsXEB5U60HTHRzC0ZM2pd5Z4K62Fb9X2iH8Sol12R6?=
 =?us-ascii?Q?gguV6uvnC3A2isSddQ0kcpXp3ewKnfjBl5m3b7vyLfKPw7x8oFjwEfJCuDq3?=
 =?us-ascii?Q?eStaWA1X1P7Fz/w+kIOG7uoZ6qeXJRGnCVEF+n6Q7BS3P9V6N+c7JPGi8qjM?=
 =?us-ascii?Q?mZNsHt1aq4qF36UkNmYCaStjucgPm+cPmuxyc1Yp/uoqd51gaY6Z87/q8k7O?=
 =?us-ascii?Q?62ZbiBef+BhXVwNMuc3odsRsGPeqaSqJ5WCELN+wF3P+Le0WYc68uUOppo6a?=
 =?us-ascii?Q?IWBQGYTGHXsy43iJwTkRHgd2fO1M9VYbfmxqn3gKX8yUYFH3DayhGzDCYCqk?=
 =?us-ascii?Q?n0dO/firWvXPDy77FCFauftK8Z+I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coSen/HRNW4ibk09d3/w57LZ9w7swMOrf/G2NlYPbGoxxb5FIZwT7I3A3vkR?=
 =?us-ascii?Q?JEaN9J3i8gZqZ3kxO4vhLJmmdMjtCkfyW+70DDwn2ufLoAseWep9GN6f8n3i?=
 =?us-ascii?Q?OqnZ1C11JZwyw9dPTFkHhJGtW3nQTs5/ZokoiABtOVirXtfiGFUM0/BEI0Ep?=
 =?us-ascii?Q?/8UveUQFxVJftVSiX6ul2NK+IbdVAfxLt+S/hp2m3z/ztJh2cp5phIfvzjKK?=
 =?us-ascii?Q?cTTHTVEJqbTCgdmDnWSX9Mt4DStGLoHLhZyY9rgiFeUhU5Pz1BU02Oo1H0Iy?=
 =?us-ascii?Q?El1xjgIBgyzTYIh02KIB90b8kC6TF25s43gvbYCGtw2Qkg1MCVMzM2749Eyn?=
 =?us-ascii?Q?gCarrgbFVgnyuge3WAULwyfCyrCDocImJ9UzMSDtzJkFZQhspj093cJt380b?=
 =?us-ascii?Q?dZjMZDGS4AT0YymPM6qZJhzlVsrN6LthKfYliqxXk/bRu7onFJ2OtFfJAEqd?=
 =?us-ascii?Q?nLCFXYvNx9lJlzbJw3gQotJmfYKH1Z26fqxED2WOzs4qKkRiOZss94fOQbZQ?=
 =?us-ascii?Q?wbiGlLMq+hHlLF1FBghWD/qgAzBn85XYio4A7mO+pzcNHQZ8edBW0VT+9aq2?=
 =?us-ascii?Q?Ts8HSNq2BIqWh36CKfxjYLVECQo77AVuIhA6/8RHrUzG4ElSvZ719ElDa2v6?=
 =?us-ascii?Q?zUvFiKBrM+xtKsnufSaNT/9yEW+nHg27Z9+EhSTuYAU5ZaiV/0KNzcKDGsFn?=
 =?us-ascii?Q?nAJLiX1yjexBzMRMmm9X1curh1zKq2s8vWf8YwrYs/j9+2NDrawwfo1PvAvW?=
 =?us-ascii?Q?IKKaVJWV/E2+PY6cwEC2O4/14bWbJXlxik1UEOsLtL2MGfohfjDPRWOs+46B?=
 =?us-ascii?Q?pWtkg4hscg5uZ7BS3bUtDr3SldoZSxOf1bJXHYUXCgPdGpn7Mp7oRJNRF5ix?=
 =?us-ascii?Q?HoZDciml73mOMI9kQv89mZ7UtT97FEuIMlBLGKrYfTgpsvHQxTmTdQlUjZ8H?=
 =?us-ascii?Q?9IgSLQSpdz1CcL8ZFBYe55h298EZhHi5Db0eVzsJBovsqLugQKqHiVrV/d5L?=
 =?us-ascii?Q?biNU/KFy7TZtcGIOVp5CKF/uIqKBOvydHvuro2zcEnz7+lMTN/qXYzXeag20?=
 =?us-ascii?Q?7zEyyPeqhPGz/LFAWwKTprDMH2ECnlXw8v3fIZPSEqWTTxadqaBuoChUJERl?=
 =?us-ascii?Q?CB7Jxh6Z7py7xIesXxGDb16GUI5vQ+Nuj5paNNpq8ngEFLSvywxxRlkCnksl?=
 =?us-ascii?Q?EsqpiNirWhgWZMBS0yhcbIjrLhdcVaTbe/HM0dhnijGloft6ipx1CK4sjp/X?=
 =?us-ascii?Q?Vff+3V9czBhOce/gqrzhUbl+feLfmZ0wyZkjzRIfPrlKdB+ENIzuisai1Elv?=
 =?us-ascii?Q?U3mC8gf0U1KwRVdrDGRvR+LcS0LDTzxsmHekha4mXY23QtwA+qqV8OMYGe5C?=
 =?us-ascii?Q?xKAdhaQG9OdAllpgukIuFlQPAdGC+fzF/TBjZG0LxrxIaJVqh4f9COlhwB39?=
 =?us-ascii?Q?LAgsy3kIhhP6kC/LHZSFbaT2ZMLmksjIr2AI/r7sfq0nZUtxXQ8RCtmEM4dr?=
 =?us-ascii?Q?mXDCFV/aM2RBP6f5tBPSBInIojyyidJkVi9DJDbg/tvlMO5BHraClwDcvWCL?=
 =?us-ascii?Q?9Vy+5KeJEzpg8nUTiSaWLT3Fm/DhGU2A/xPqU9rU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab92004e-d529-4519-cede-08dd02994b00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 21:39:16.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmoTZbFw16bXyDnNthFjnKgwYYMjqTUCqRA7kxyh2NwC4478PNrjfdkEqbS8oipg8E0pLAotI83mlBxvRJTjfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9738

i.MX6SX only has 4 ADC channels, so limit channel numbers to 4 for
compatible string 'fsl,imx6sx-adc'.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
compatible string 'fsl,imx6sx-adc' already document in
Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
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
 drivers/iio/adc/vf610_adc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index d4b778799755b..6f66bd7ff8eca 100644
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
+	const struct vf610_chip_info *chip_info;
 	struct device *dev = &pdev->dev;
 	struct vf610_adc *info;
 	struct iio_dev *indio_dev;
@@ -841,6 +855,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
+	chip_info = device_get_match_data(dev);
+	if (!chip_info)
+		return -EINVAL;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -882,7 +900,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	indio_dev->info = &vf610_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = vf610_adc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
+	indio_dev->num_channels = chip_info->num_channels;
 
 	vf610_adc_cfg_init(info);
 	vf610_adc_hw_init(info);
-- 
2.34.1


