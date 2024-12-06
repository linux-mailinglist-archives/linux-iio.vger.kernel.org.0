Return-Path: <linux-iio+bounces-13191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F7B9E7C20
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 00:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA0284098
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 23:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72E1F9EC6;
	Fri,  6 Dec 2024 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZTcd93jl"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DB13D516;
	Fri,  6 Dec 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526035; cv=fail; b=EBHr4zLlkbHUCYW2cgWTBjoCE/HxhUM6IaYf8/Q2g9pios2ujcaWgVJU5PFh20YL0KAyiJVitGvAASUbRpbcFYwBVr4Q/rathheN5YIKMZCnCBGus8+Ie94yo0rwgK7N+qs1SWTn8PhTNTpc4P8hdSOecD+NOU+bsrgdebbkLmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526035; c=relaxed/simple;
	bh=dZJywsB4N3MI/4LC4wUBARVW8mGKRcTbU/DQk0/5gzw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DrODq3GpLRqLBNaYBA60i+eJaGWhaPjY8cwL0OXYR7QosjYgQoaJjim5sbikSSL4+S7PadguyKO6MXqDkiNdwVnvPectLgDzr7nFes+ZqYHyD+D/mufX53KgDBfxHtL7rASFeXYNFp8cVhUk/9pLWej73Bw2anj5SIMfhaALarI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZTcd93jl; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO5WjH6yZq1fRm/FsohSsPOosZWLQODfA+5CHoBiO5KYaGwX5LqIQZuryXT/tObfW7LR7ylhAFgoGjeCnwD1yHPamE1Uw/U0hZ9Fuu4rhKVllou+BM5DLvPnYKNiZ8f4Wew3AtIMZVAOG9eM+tDVqlSRF3ETQL/UNoKpopHg/PNZ+42mxcw2lImIWpajJKtCMZEJ35/aOlGjv+eyTL1llWGmim1Uzhhnfg1pFuVZXh42hxpxhioDKJukOLEv398g93Abaa3Yc7heeesMMAIu+xLuguKrHeTWsxO1T1UelpzmHm78wwSbjODovc9FwNVDNvDIiekjDRQrzvFzqnG8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJRPE9yMtxQoTa+oFsW0fnF+ch+MiXdYSOd9R45zSpY=;
 b=BhA5w27sKLtzs5Jp5pgZFb3Fc796xnrYGkx+ETrm7wZTH6+VityeAomsQUf/p0a5CN+enXHMvo+WAjJe3Zhq8f3Da6dXRexgePtKYCn4NPRPjB2z+c8A5Luwm+6ibVNh2cPLYa7Dy6m0/vjxeOWmAoTVk7PUSZ7wuScxRFPVJuG0TB8/9CxROJ+w60wdY+a4OtGTLTayqfx0d330TNaAiWrOvz90SWgxJdTusRLkKtIL8BzBEHN78CSHIyeQf/W07lmlJc3gMgM1HSD2EYYxld67oVDXgc4fWj9PF6/n17LC8Ar7WhHgm2WASnACADGH2YOigQdvVjZcr6zKHHtGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJRPE9yMtxQoTa+oFsW0fnF+ch+MiXdYSOd9R45zSpY=;
 b=ZTcd93jlloWdj3GdR+5/wVki7nVXKvekD2QjUtYxgDoEJ2CS0UbMdBh69W3bDg+z71bqEvlRP9mDZSMfKRoAU17wxfm9HfI9XhZYCoJep0K2IwSClUso8ptTpHs/BfpVcH/R2avSO2dV0v7JcTP7dww9n+3nZH8JcZ3SRK3hxslX+4q0PcKooMqYPw/oPYXD4wjl8oNWkfykAMF8s7JXDXKBZ9eLeofFBaSBugkcSMiMlVSZTFOAb7Fja6emeUtuNsMoKMM6NgXXZSzUTTvJpZ08E5PYfeMuqengXE3XPaTHMpyuEgSRpfm2vjr/c2hF+w93fk63Fi57nzhM5YpqAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10709.eurprd04.prod.outlook.com (2603:10a6:800:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 23:00:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 23:00:30 +0000
Date: Fri, 6 Dec 2024 18:00:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <linux-iio@vger.kernel.org>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel
 number to 4
Message-ID: <Z1OCCP7MlucJ9F73@lizhi-Precision-Tower-5810>
References: <20241206225624.3744880-1-Frank.Li@nxp.com>
 <20241206225624.3744880-4-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206225624.3744880-4-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10709:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4685c2-c773-4930-5a35-08dd1649c831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jgmajr0CzdZM/jB4R+gTG10losE6xKPKL+JEaZORKqFJIUAit9tadRGjqVy?=
 =?us-ascii?Q?6BTNlx+y2NeSr2F3qU1Dz+Mb9PqRtoDHOSMKEVClx++S5sCx9V6/VuiQkzla?=
 =?us-ascii?Q?NZZ0dZlDHtG3bj8D8nK+Q1RmvkpIC5s7Cnrw9jH5dTyiwiMPUJtY7/t8hxgh?=
 =?us-ascii?Q?fUA9tYQ8aX+soDoe83kyVCWGPvj1XkYLPWRQk4h/ZhiXdTl6wa1xyJRg5HSv?=
 =?us-ascii?Q?/8lSm66NvvVHTw6UuV0haU5VVZJhvrSVWuDaapDYRV5tLPjohtNz8gxGC+m1?=
 =?us-ascii?Q?dt0VsE3ynS/T88WBTIXZImp12fYI+DPrursSbXsqdMPN+/8N0QvDKACp7TYK?=
 =?us-ascii?Q?r45qVyPVqF/TmWtDziXW9NCEL90j5Djzq3QEogIiQ48BxJozBpo3K9FdxD2v?=
 =?us-ascii?Q?MgDrXEUby4NlbHWNT4HXcm/tlszycqDZ1M2053O1yDGCdov0jSoFP4xaFIiQ?=
 =?us-ascii?Q?b8HvBPWV4EPpJcFs6VKG5Q3daQ1gus2AlTgvQHpUsPNdvLbUw+wmBWTXncSj?=
 =?us-ascii?Q?NEsGDZ68zHpguHL2PluxxmZnpKeDvzg/eQDPF3zfKdQYAPA9eDqq/JRhng4U?=
 =?us-ascii?Q?LNq3TsInW5xpJRfeFMAi74L9vy42CyMkb1YNmyCCf0qZ2d1QRFufvepqQ0UQ?=
 =?us-ascii?Q?ubWdzyLMfgbGm3c/Sz1Q/avDjkiajjikpdaFwnXGtN4M6MQqst1IlC7zrUPS?=
 =?us-ascii?Q?+NUM7ubm66x7f58MGTijzQ97lhAwybaSXiFcqwPafxqPJGmFWkkxdPnI5cSs?=
 =?us-ascii?Q?3cy4rsUE5Stzo3SuRKl8ErwQgJE62MidYnN5FBzcEsQT5CmCIsI+O7cqJxVY?=
 =?us-ascii?Q?AzjMjJNh0vP9O4acoUPEfJsjMXSEM7FCr5pqLuMJ8b/75I0uJ12MsjXBMyXI?=
 =?us-ascii?Q?Tas2+lkhSwaHq5FR3ZInTNfxeJt6Uyw3oid1NOMvtWQNLxylmiFEHZktk/+9?=
 =?us-ascii?Q?qNVDEBUlQhR9+fVg1xn+9JwkAIBH/9BnSf+cyETYNkM7h4NSLljShdLcumCF?=
 =?us-ascii?Q?5SbAhZKLpvNZD68AZSqyO9Nq3E/p1gvm+Sj5cUeYJSbk4LO9G68TJfCBRJqu?=
 =?us-ascii?Q?ZZZYPRNANHJZRdCPbvA4W5voS2MgLQFp7Y3d98O4ZJG6Sx6OwRpFlv1WqIFL?=
 =?us-ascii?Q?6dtID+/2C+PS4a1jAAunOTPW+DYts6b+YJchl7BA5rTmybTRQNMC8A0FZ7V2?=
 =?us-ascii?Q?RKxBWBkvR2kvABsORr8+8U4e5DZ9XUL2ZQJBuAJCQ5fUxgquIkwIfzCgW8wL?=
 =?us-ascii?Q?FgZfrRTVimJe3G1XQtV4fYI0hRHaeiJc0kT/0U55viPB3+Ze6lYXZuLLIULR?=
 =?us-ascii?Q?FcsNjMucTh0uTIHrSgrq/5xmOL+1/x9Jonfj57UrO3m4vdMqgSkrUAeha8CL?=
 =?us-ascii?Q?+HnS6WZ9IKnAJfXFfrshRqjD+J3vh7Q79NX5nW6mOr0nSmhLrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lEPr2huHq7dFaI20gDwuR50It0oLhfdZfTRsmcCBhAeg3HXQFT8jMFIbqGlQ?=
 =?us-ascii?Q?iVwPsf8DKXXX1NXc3+UkGKE1yvDpe9d2KbMKOjszUs/CWLhvXvgvJ9tRXulG?=
 =?us-ascii?Q?d2nnXmBAbX4HyJ70dhJXOCIqc3jGscwvC3pil6XrGcbfF4/bSq6bH9femEkT?=
 =?us-ascii?Q?vWHxJrHHz/CCwWpHf09dAPp+keRCTWs5CZo2jTMMCe4rYBC4+Ytw8GYOwMRu?=
 =?us-ascii?Q?Vj/qqgHcWNPi1vX3zqq4sluTg7OG3+NZN1MNpjf8QNoFMAsg/CIzWGCzDxgM?=
 =?us-ascii?Q?mNLzcHYlsDMbmZ1pquxM4h1sQfu65qSSBPqwPjwAz+4swNU5v0+Ppj6unQM1?=
 =?us-ascii?Q?OIMftJYNCwmrDHGc35M4uT6C6PDp2HCCVrHkes5x+HI1qq0fXH/u+T2HmZ/3?=
 =?us-ascii?Q?yEi1BM70e+6aCQZ4buFCMJ8HZ1nBOHuI+MsfVXLRqZS7LV+tiWRNvMlJSi4T?=
 =?us-ascii?Q?FHqm68sJ8HhKZDx4oyVzML3D2E20Tg68eZsCwRAGB1ANqb7vWKLyRvZp4LqB?=
 =?us-ascii?Q?dFupejVxG5kD4nbe2UHLOPoKu02PCujA5Pbbvkxo4BIDCS0Z5bgh8ewj5snw?=
 =?us-ascii?Q?CceuBE7Ds6bV8tgMQDYYLGkXnoQPyi+ErPUp+1clN1PBZhiWUt5KD7ZpIyBi?=
 =?us-ascii?Q?+gPJtBlMbM5JrJbVaX7cG4wo1zcj/iGy5qLzFkenah4k62atWxYkOSP/5X5s?=
 =?us-ascii?Q?+njIPeTtLs+XjMe4H/7xuF7jDgDnQers9+5n82vttUBtawyVWNhtYjHEcpap?=
 =?us-ascii?Q?ym76kAm0PZOeNro2421TVCxRlUbH+0xC88PN3JPzAU35A9oRm9iXwlS+e+1T?=
 =?us-ascii?Q?YndQ5YiBPY0vaB4HSWJUkWR9Pi9d4x+EHvo/iO2dxYrpW9ppVHwe+C4NDrWz?=
 =?us-ascii?Q?9FgFop5B0a7X0OfLA+UMwODCtqxAeWMqczinRvPqtGtBfkKfZp/knm2i67hl?=
 =?us-ascii?Q?82kTkM9XOoB3yniuHmON5XBh7ZNTUX+DwNhKrkMgaaQdbUnZES8YzW7/e7Zd?=
 =?us-ascii?Q?+8leDeViD1UJ15rZd5xzJHajL/pJq5Kfk+7afoyMfpdGzPzXI1F6sWrUoBs9?=
 =?us-ascii?Q?0cz9FyjgOwEf8CLOklj88wiVUzeI3YEyzjnbsabAqisjQW5rjHZxvGDHDjVE?=
 =?us-ascii?Q?M+lf021+a7TZxn+Muyrofh9/VodG/AAdJrAv+GSqdOHd4+y49biGofOoAoGe?=
 =?us-ascii?Q?QOsUNeZffQx329kMPgkkmO4B3mNfosZ31umcRTPqdZWuUgPLPsWUePBKGbBT?=
 =?us-ascii?Q?9ZL2vBJEsZL4GgeyajeLkXS8ocOIs85QLBMSiJAmPkAg2CGEsUPs/ng34oVx?=
 =?us-ascii?Q?Z0hE3Br0qbuM7Olpr6+/awy4QckulKgVY7iZARL5UU14nkYHNjJxJuggo3k3?=
 =?us-ascii?Q?xxMZqvT2cYBFkosxtPw2giBpg12hH9PrjkKn4zhhuESO25upD+W1iAuvXGaN?=
 =?us-ascii?Q?xo8uTdwuncdeFuGE20AmuhEre+jTdOVXGQwV5V/CICWdRt9BfOXVtZG1C59a?=
 =?us-ascii?Q?oAHLwNGLgHpUkzwE7BX4AO3Hl3VzvgWaDJlFWDuevZzFUpT3GJfUHUHMMM6V?=
 =?us-ascii?Q?oLwB8ZkNoM5G5hRKKc1ZcXDdPW1MPQlYL0k1ISMR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4685c2-c773-4930-5a35-08dd1649c831
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 23:00:30.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbL+N9JX+XiUDwjQxAzuO1b901VCy/2YdMDpXXAMTePSa1cuT2r9sU1nQRWmGuChet9xK1Li+IH0HdKRdtLSmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10709

On Fri, Dec 06, 2024 at 05:56:24PM -0500, Frank Li wrote:
> i.MX6SX only has 4 ADC channels, so limit channel numbers to 4 for
> compatible string 'fsl,imx6sx-adc'.

This patch already in linux-next, send out accidently. please forget it.
sorry for that.

Frank

>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> compatible string 'fsl,imx6sx-adc' already document in
> Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> Change from v5 to v6
> - remove return value check of device_get_match_data() and move it to
> declare place.
>
> Change from v4 to v5
> - none
>
> Change from v3 to v4
> - Add struct vf610_chip_info to avoid cast int to void*
>
> Change from v2 to v3
> - none
>
> Change from v1 to v2
> - Add Haibo Chen <haibo.chen@nxp.com>
> - change cast to uintptr_t to fix below warning
>
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411052345.gyJaM3h4-lkp@intel.com/
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/iio/adc/vf610_adc.c:20:   In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:21:
>    In file included from include/linux/mm.h:2213:
>    include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~>> drivers/iio/adc/vf610_adc.c:874:28: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'const void *' [-Wvoid-pointer-to-int-cast]
>      874 |         indio_dev->num_channels = (u32)device_get_match_data(dev);
>          |
> ---
>  drivers/iio/adc/vf610_adc.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index fb7afa91151f2..850453be7a8a4 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -177,6 +177,10 @@ struct vf610_adc {
>  	} scan;
>  };
>
> +struct vf610_chip_info {
> +	u8 num_channels;
> +};
> +
>  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
>  static const u32 vf610_lst_adder[] = { 3, 5, 7, 9, 13, 17, 21, 25 };
>
> @@ -808,8 +812,17 @@ static const struct iio_info vf610_adc_iio_info = {
>  	.attrs = &vf610_attribute_group,
>  };
>
> +static const struct vf610_chip_info vf610_chip_info = {
> +	.num_channels = ARRAY_SIZE(vf610_adc_iio_channels),
> +};
> +
> +static const struct vf610_chip_info imx6sx_chip_info = {
> +	.num_channels = 4,
> +};
> +
>  static const struct of_device_id vf610_adc_match[] = {
> -	{ .compatible = "fsl,vf610-adc", },
> +	{ .compatible = "fsl,imx6sx-adc", .data = &imx6sx_chip_info},
> +	{ .compatible = "fsl,vf610-adc", .data = &vf610_chip_info},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, vf610_adc_match);
> @@ -824,6 +837,7 @@ static void vf610_adc_action_remove(void *d)
>  static int vf610_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	const struct vf610_chip_info *chip_info = device_get_match_data(dev);
>  	struct vf610_adc *info;
>  	struct iio_dev *indio_dev;
>  	int irq;
> @@ -881,7 +895,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	indio_dev->info = &vf610_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = vf610_adc_iio_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
> +	indio_dev->num_channels = chip_info->num_channels;
>
>  	vf610_adc_cfg_init(info);
>  	vf610_adc_hw_init(info);
> --
> 2.34.1
>

