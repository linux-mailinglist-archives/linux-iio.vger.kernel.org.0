Return-Path: <linux-iio+bounces-12708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A659D9E1A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 20:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E25EB2460E
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C911DE3A3;
	Tue, 26 Nov 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C58bUuF5"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013067.outbound.protection.outlook.com [52.101.67.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91411DACBB;
	Tue, 26 Nov 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650803; cv=fail; b=LS4EBZ+4ClhIYvLiY+M5VZOcWKzr9rMXMdCJ5xFO1FlY4X42C3qJ/Dav/8aWN9N9d614chDuZNHuAPtv8Le6sXa9iG1B/gesGM6mrcXkJY785v7tn/8shseRUGhv8MvDzS2zvrRDsG92jw2/64LHQeLUarno1HzOrua/492Fcqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650803; c=relaxed/simple;
	bh=lOH6uKgp4qocjXTGqI2DZ7uMpsB1hN0XNn3KR3ot/D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWKu/MsCJa0m6Ph/O04ziju2Jcp5To0wZS1vsGpJiHHmDt0h22d5pETn9IE/0tmJnYGdUf6jl6PLIZJOt3SBUFb6TCa55h9NHS4DAvFrx9MF9w33HzTUAF4iDhNQSpR5INF0c4y4ru9weR58UXAaR+0w7c/47+w3fmNShheyFBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C58bUuF5; arc=fail smtp.client-ip=52.101.67.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbOV45b4VSq+gvTpAVmCSkD98xYX4L++fmELxg2jzgN5SHuZlQvzXt5vfHaj98m2sLQqZ9wferOp4bhGWsEP/bOdAQzxy8lRKgs5m2N82IM8k5J0Xl0+yNOz8dI22i7jxHv3LqG7uZbwsi4UnQ3Q4mSQTsaPI21WjQMimv/pUt+IcWvYn04leO8TXn7WM1OvGQGJzhMPd0Woj0Y/fmec2iLdp8ek0oreGgkyxSdTXhkCs6sOsvgzNRDwREzF7KGjBQ2vQxzJ3DZCEGQzOeVe7nlf8aVbZFcptNg3ljU7I7Rwvufwhho/dWZwynJTgMgnKyuBvNfv0dg7bYmC0gB1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBQqwxMGjqwTIRtBIMH/Dslh28Cnyih9ZZXgeWnGIgQ=;
 b=Nk1foO4j6PCys57lj/3sm7IJhGflvuXbuPvunwBD4ID4NHUca8cpex6PYcA9Cirthm7dGslcGHPZwoJjI1jN/3YKZXxdVtDQ9YLxLwQN4v8grL/QS56Y8kUd5i+mVfjf4OlQiQTcCTtmIT8PAo9t5y6FepHPWLcbZqDl+mr1wy5Zi88KMt0JPBHoL9Y1ssQctCUuRcFbMshMXCsmmWsvDIBVPFEK+IyN7oQF7RCCYZD74zBmq337IQY1FX9ul9GD2Id6EjoxTWbcIpzn1a9/nK6EhMfSRZAtVU5t2SCDLkNQ0TbLbhMfO/KTQXS2ql2YhiuPJDdVdMjJEWVKUoGK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBQqwxMGjqwTIRtBIMH/Dslh28Cnyih9ZZXgeWnGIgQ=;
 b=C58bUuF53saPUdyDt5+MwQVqlbOxxfN/bQfRqPRXu6q9m8dsRg2+PFWfY8HmybBijd17M78V+AK6RCMZjJ5O3lt9uyrdMcYGi7Q3PdG3bGsZROlo0TR0A3rmXMAFf4TW9MWp7hdC3WiYm5/uV1a9ukIH05rJmkJqGFs+vIxK3/uiL0+fDDllY9hQqNFK6ck1muQgIwULiMC8x47KjDkpa0mpW3N9sP/Vr2m/oMa5xyPYW2IGc/6sdOJL7Upp4aFl6HX9RNzEswhnk080ZUC5nuhLXtz+BAEdsPo0gQ86jHHxlGb+6M/qMdhpEHTBUmFYj47A6UKGALta7Gph+4/eMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9831.eurprd04.prod.outlook.com (2603:10a6:150:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 19:53:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 19:53:13 +0000
From: Frank Li <Frank.Li@nxp.com>
To: jic23@kernel.org
Cc: Frank.Li@nxp.com,
	haibo.chen@nxp.com,
	imx@lists.linux.dev,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number to 4
Date: Tue, 26 Nov 2024 14:52:56 -0500
Message-Id: <20241126195256.2441622-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126195256.2441622-1-Frank.Li@nxp.com>
References: <20241126195256.2441622-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 8015b945-515a-4ef3-67a3-08dd0e53f665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ixM3cQ6Js6TrwdA1zrdQEvIJnbyUj9pScsFYpTPDSL0I7hKXSbKNiiCDfXQA?=
 =?us-ascii?Q?rmUkdT9Fut20XJr/s+bf5Zo3Z7Ogi2SYQv4MJgYQEaeXY49xN8BHB6Mz6PSJ?=
 =?us-ascii?Q?mQsv7juHZdzkkPCdqQ6kibsfKOGl/HVo2Ho0BJTd6XawBs1dICIRDccl9/FO?=
 =?us-ascii?Q?CjUEURLT/37WnYqRUsh/1hCqZBG78bKre5prwRZZTxvQHdE0ZGTEJurToiIR?=
 =?us-ascii?Q?Sw1YCH5H7D/++RnzWreydR6UTCN/HlwqiIh2G3sxdtBqXVrLaOWALo98YOt5?=
 =?us-ascii?Q?4Cbvp3gAU+6z9pX/Rh9P6WWYZmdSAThCN3Pyq3A/TKKKRsdTNgAObF2zh6wC?=
 =?us-ascii?Q?qSyTU0q/q5Poh+EFkfsqWDb/YGLoMIgW9+4nB4xSfyF3pvfNfbo5TVyeGGCa?=
 =?us-ascii?Q?kZmxM5CRbdpZG89JCGaw0D0Hl+Y3Kk7fjeIZZmRhXYWOTKBFFUOZ65n4woYW?=
 =?us-ascii?Q?yJYje8N/PSdgyVjN/wn3g/3vchCQEeB7d6KpgDxekuHaDaLimsblws8ZFZHk?=
 =?us-ascii?Q?8ufUKhiWE5ed7EjnJgjp7aZOMXG7vTrUO533on+lkpfM8stIqu0w0ShlphCt?=
 =?us-ascii?Q?Dd/a8V0CXa6M1lIbao/yAJdffttkqaqr1HeJ60jGsc0/4vLVoSQ8sDwI+HWr?=
 =?us-ascii?Q?z1ko+Jbi35IFArY5/9Gg+IJKAZVZPZhgBzGEEFDGkR0U1ZpoXLncM+vCjmUN?=
 =?us-ascii?Q?cayI8PZs0gPnxsaZouxgrJqCElOSHRLpowbPGjszlnlEQ/armeUtZx4Dm0HD?=
 =?us-ascii?Q?21FE/tqMMZJ1wf+wiIaeFX9RPTClnLEcjKt+dtMk1gylqv/m+Za4sOhjcfMc?=
 =?us-ascii?Q?4ZaCQjvnakDfabDilqwZg064XAoKKU3R9E/0NAudCdLzFHfbE3VunSE2zoas?=
 =?us-ascii?Q?+A7LVxUvvdsIkfxfmo7tLU+3qTvDS91LvA2oIJPVJCdwnSA9Aw4DkdPHwRQL?=
 =?us-ascii?Q?Qlqe2VhFMw8o+ftx/eW4LKZ57xx3lDnMmUT8KlxHMMVGDZBagqJ5qE08Xq0k?=
 =?us-ascii?Q?E3qQ6vrx7ijD5KYdFgRWlO5sLjhShT9z76IKLaVIRD5o7IprBDSygqOppruN?=
 =?us-ascii?Q?syZpFhFs5GBBVW2YvOGpBf0IKtr/qHy/YoWiFXAZt+SM7A4pmfJMn6GXwDEY?=
 =?us-ascii?Q?GBcDl7DsaGYVqH7jnaX1dXrOEp8/s8q2XLgJLjBK6lJYnCO6/guL9iqDX00U?=
 =?us-ascii?Q?aty8L6S5hchRHAhDUKBRraIp7rexNOUkzoMffADRxNr0AY66a7DiYCm4gFIr?=
 =?us-ascii?Q?YDM2ift6avlbqyzLSwQbcVrD7BCS71AgZuIZnatJq/YTBEPHcqShGHRR6Pnu?=
 =?us-ascii?Q?42fG2XueJ2eCj0eUxga8RibQK9a+SK9ADB+3Fjxv2/1Qs7I6vJjlqXqTVroX?=
 =?us-ascii?Q?klXYernpFXwL4qkhJ03JRUL4f/1RWKHyCA5oFejq8gexv/zitg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NiuXjXLmAIpaBHIsiH271hk1Zdf3zhMiPY+ToVafPJWg9eu1QHa3HLq8Chql?=
 =?us-ascii?Q?n6rzgYDH+0JvZ4PZJ6LqT3vZ0tGISbXwUs38inYuB522jh3YYRF16dj9pw7G?=
 =?us-ascii?Q?/EPoJuji1PmYf9UdbyNloZJ8aSTZ6epd9nfUbxZZsjNd2edshzZyZq1aNN9M?=
 =?us-ascii?Q?XjWlTQaagJRlDcRyYd/FetK519StsPsem+5tdnDoVZNOCH19K1+d5ZSsOS7s?=
 =?us-ascii?Q?twEzGm+FwCEP8u4Sp2AoVc05Ou0+j0ncBjh3FaD/VZIEUjMJzg7xYVpWmYwn?=
 =?us-ascii?Q?n9zDWaNfWcAbEnZaPohBVIUHnhJYFYD7jKrjfOKeHopbGO8sjf4lc9IvrzXf?=
 =?us-ascii?Q?um6K5Psupcz6Y4j8Gzjy0JZGap65wdpIpkBmcy/ZhY91xbYN1SM+YmVCCbjh?=
 =?us-ascii?Q?/qxSA3Pv9RATEVSmCsmcUQ8X6We9PiZTOUYadFyQ8a8V15EiQiAPMQCRLKw8?=
 =?us-ascii?Q?hdlHtCmIUkY41hP5exmj7qoTFyiMZB0m+tIvydrGGBSNBVUQzJQAJGrxau5Q?=
 =?us-ascii?Q?qvSUChzkc7lxBH56Vbf6BvS/CGvYhPObswDk9pXQJTR4dQEJOlkdt0d6NopB?=
 =?us-ascii?Q?KlkodqGGDTbH8siynzyPo5X8UycZW+LR5wyNAvqvWYBWYcyOH3n3bP5C/v7+?=
 =?us-ascii?Q?D6Z4wS1yM524b1mXpe3PJ8Iy1MCkAfBZZXStoFblTVmJOnP0VFhm7phuwuVA?=
 =?us-ascii?Q?YU90tu6TwwblB8hU83YiBurrTMYEbCCFF/yaCkCJJCYASp2XHnn1UlG9JTGO?=
 =?us-ascii?Q?cIQEJjDfn+jbzhc1rq1bmUFc9e4/NlljQXdj22pbvhIZWFpYsZO2AODmF3G0?=
 =?us-ascii?Q?uQUo3NJGz+kBVPvEmuOm2pLMcY3KIXMoFkN2QBzlfQoHvQE4blSYsLi60Qha?=
 =?us-ascii?Q?eWRK2IvcfPKhE6/9U0yAhiSY8ddM4GFmSKaRE1/Ryo/dxK8VR+ZREUkIvXk9?=
 =?us-ascii?Q?BQgCaKZi8965K5JHbHvcuWqavGtTToQ4N4238kgLFSPF5N4CsT18Byz8Q5U1?=
 =?us-ascii?Q?jlQi9FQ7r/7h3eRQojK9cROIcWgVUcqHnCHQs8NdQqOolqpFcoax7BW5/2oE?=
 =?us-ascii?Q?tIKj0DGkCKE3pW/eyJ0QoGb45R4G91yHXJfxpOS41XWk93Q7Pj2adz6S6WCQ?=
 =?us-ascii?Q?BtBlBm6tKsH6D0I4/fgDvXzlrPNT4YJd4J/YIDF99XYFZXC858m5HnE5D6ya?=
 =?us-ascii?Q?8W8V0H1agLyLG1/bWN/44Yu+9uxb4VgyVQ6+z5nuQyecCjqrrBqSIJQE2a3J?=
 =?us-ascii?Q?9J0fFBNKBQGVcnF+ZWOSdlTTAJFo/AAjeDi87Kuyo7LslZgFOIPe4nUHfDlJ?=
 =?us-ascii?Q?rYRXtlhU9hXyUqTbGwbaVPXli3H2FlnQkjLbVHW3v/G89ESKUVAvieKhRCLE?=
 =?us-ascii?Q?2gxoDjVyjhOnpj9Sr+ie2/hWGPzHvbJ7KWze57bux4Mhl0ElmuAd3fSupR2g?=
 =?us-ascii?Q?HNzzxr2A/Xluu4T/ncQyslCgPMYGwVwSDoxOYzxi2FqnBL2lwDBaa4DATg30?=
 =?us-ascii?Q?77aSmDZHlrRZ73TFrG3tYF8QGsTAw8ZQVHaiH05hY/YcgED7StfCdSiwW1sS?=
 =?us-ascii?Q?OHrVIiu86nxd+k2kdWOkUVJsM8LMT+yHcKdOW93x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8015b945-515a-4ef3-67a3-08dd0e53f665
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 19:53:13.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXRCFZ2Ch/UmxKKI5zWA/K2W2vniOFWcOiS0rnjqpjHp9yE/CbjJ1PZ0R2ObFAd1teaO2Xs3uf2WAfC90IWnMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9831

i.MX6SX only has 4 ADC channels, so limit channel numbers to 4 for
compatible string 'fsl,imx6sx-adc'.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
compatible string 'fsl,imx6sx-adc' already document in
Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
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
 drivers/iio/adc/vf610_adc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index fb7afa91151f2..ed05c2b3caeca 100644
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
@@ -823,6 +836,7 @@ static void vf610_adc_action_remove(void *d)
 
 static int vf610_adc_probe(struct platform_device *pdev)
 {
+	const struct vf610_chip_info *chip_info;
 	struct device *dev = &pdev->dev;
 	struct vf610_adc *info;
 	struct iio_dev *indio_dev;
@@ -840,6 +854,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
+	chip_info = device_get_match_data(dev);
+	if (!chip_info)
+		return -EINVAL;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -881,7 +899,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	indio_dev->info = &vf610_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = vf610_adc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
+	indio_dev->num_channels = chip_info->num_channels;
 
 	vf610_adc_cfg_init(info);
 	vf610_adc_hw_init(info);
-- 
2.34.1


