Return-Path: <linux-iio+bounces-11925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D673D9BD1C1
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 17:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055901C24941
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6681B15CD74;
	Tue,  5 Nov 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I43rbfkx"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE91514CC;
	Tue,  5 Nov 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822926; cv=fail; b=Qgz7ORec2rAgJehqB7jHgtTYjdvN6s23gIHRMP2SF0wA7kJ6yTbaYh6unEHnVwZXinMABq8L6wHQm7TS2nEx6XCbc+4QCuRZXPy9nNVqhVweeeUlgUjnKFOsUiq9A4ctr6egvFqN6o3ML+pn/aPSTH+nnSW7bTCzB56r045vHb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822926; c=relaxed/simple;
	bh=qFtJfP6a/se9EE+ETvxBNryfW7htF9Q+VQ14nX1Dgr4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NP0ZHP01mT6fkQ18neimP2vATQEBTMFIJpgoqEBZiWyWhgpJnZrtEam0jEgOlhs51VfZZki3zYBfGk92O2Rj/hIpvLLKH645JjtN/ekec1WePjUI3lhZOWQz+tyNZLaYTYq4Z79/g8EO8We0eK2gCG1CUY5IXlK5/TPcmt8WCuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I43rbfkx; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4U4GN4PB0PS7sotse5K0ZWaCdOn8Pghw03ieUgzmQsc6cENgrSZ/PWeJ2aNLrFYDoWtdxRW1z6Wh+iC6cNg02wzKVWWPlWeOYcftt8aQ02FidNZSGKfZDZ/PPrOGleXfv/JZCA6a/Nj+ovk/zzeQuHpV4nx9+M3Yi69CI1cc101DEbb/eU4aPHIRULCWRq7SeMsdjJA+HzP0nSv4DOqBbR5JfnTsXjnLFuTNqcX2H5r729l8m9c5NvzlVufanHTa0Bb0AOTZY7ueLZtA2kaPm2Lm3E8FlQsHSOZzivFDrCi0wXfE388rQNsZLvNMKP/fMXr28ypLMyqelh9AVEsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LfPY5OmZyA1fsxkEDnh7rLCuAzi3d70xUbAghqSQ+Q=;
 b=WlgRNSafRM3vssAlUQknxQTZ76vc8BL2XYEhXB/Ehzjhl9I9kVPUFMEjsHABvIzTolhdldm9vOlAv5g8wNWK5oszC3FAkcgeRU2zjOetQvAcAtws76aZw4HYShJJGPRh6hxtHDFDKIzSV7f/p1ZQNbGNOMGvzpmN16gQzvxXNm6pdWL/bEL2scg6WjDrRSJ2grPXx2/WhLO/u49g+U0qOP88T4EEt4z+10c4Mzm/1WIw8TPE15kwOfgs0qSozxUZrjP5RKiPkIDO+wWBPwkw7flqplJvrMrQB29As2MJLpnIyDcjqdjuD32xfHUNn2j8FPRJONMWcWCc+2mPOprVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LfPY5OmZyA1fsxkEDnh7rLCuAzi3d70xUbAghqSQ+Q=;
 b=I43rbfkxkTbhqi0AoRj/HUSqtV3lDAH0fakf2c3LkC2FWWOkNH4Lg+7W+iHfLE2XPHfR8pEdAWKDnxSIoebFJLW0aTUDn0f0tZBRQygyVco6ubP5Nov6IUDW17y+rQSDXr1xVq+E+GvNCo5Z5ryTWjVhqYdJiK3o7w8wn7QgDjsIbhQyl5m++kiOOX2QqRSFmMvYHTTEnEEiOerLaK9ygcH5/3wUGKf49tiXJ674b5Sl6CalLYQIEzFS40uMBmxBxedjs/mmTmw8DUbzoUmhK7w8c9iQy5foe0anGIffeKeIK8Bk8fmi58JTY3tbfFtmZ5G02X1YexKn45IaMekTKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8225.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 16:08:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 16:08:40 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number to 4
Date: Tue,  5 Nov 2024 11:08:22 -0500
Message-Id: <20241105160822.2761261-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105160822.2761261-1-Frank.Li@nxp.com>
References: <20241105160822.2761261-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ed05ec-55f4-4d23-5947-08dcfdb41d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QTDk3jYQUt39FSSMcuh1ng4JFoU45rZPKkBIx4LtgLTpW3dqNvMHLr+O2Ri?=
 =?us-ascii?Q?Sie+FRcuxmMtDkrsj6KB6gPMDx6WgCSdmJcFZkPLyg9r0Zk07tL52zZ8BdXq?=
 =?us-ascii?Q?YISc+Hu3OIMqTsR5hAbfbDyiLn/SsHSaDcDPtsLcoyOYlcFohN/yAwOOaZpU?=
 =?us-ascii?Q?YWE0dKPiE3pY4uvYjmMbJuREwBS21bdI6j80K33+ny90NdqAOVYhzDI4bTlf?=
 =?us-ascii?Q?Yq/B2/4zSFGrujrd97sonBYSx0KGfIot2I/8iN+tqc0eN+IrjCvj+jK3bu4o?=
 =?us-ascii?Q?Ll7yN3R7hk/XO3j86pMhxOAEy4Ismf+j8+PQrMfJm4R60c6ZbzKrp70A1TQ/?=
 =?us-ascii?Q?chYh6o8JwPtvgzUYzEvGw5e+qxnjHxrZMV9rNGZ1omZ1r3eskruYpGZuiJNf?=
 =?us-ascii?Q?yEHuIn/b224vMgh1jUy8XPArrWpq6rIqP6Xsp2qjpCNnSfKaMpbU7fK9GwW5?=
 =?us-ascii?Q?y4PkQtCBFYTog1BRTyXFDYdR9xYmXc/vQvzv6bb71z9l2zMJt6YglmGS0J4M?=
 =?us-ascii?Q?VUmNNu9uMNnw26vQhbj4B+Iav4ms/bHnth/17kYZ4o5Ml4M3qLsgsxx29QCT?=
 =?us-ascii?Q?9/ZEkSQW7TeLxR5Ka253OwkcTyJKlBZ7lSmDl/Zt+DnCt4JLnLoe5x3Pxo5e?=
 =?us-ascii?Q?JbyPlyboYyWQ+frUs60UuhP7Yre+IupX1TRoF1woBK8aNaxrNQHBn44Kq6i3?=
 =?us-ascii?Q?Solpa74207cCA1PgN2vNO3+Okqs5Y4/Xn2VZAbJeVpw+RcH/WF2nEpMfgCz/?=
 =?us-ascii?Q?93e00FJNS2yn7KtMuDj3oo3saZU3x/l2uCAqTUzGGkpRJVygVFkGqgbllWLc?=
 =?us-ascii?Q?26K9RVnvm28feWJs+Th1z2YY/SrpkdIs9K30RWOXkQdohXEXc/BikAVgxOFT?=
 =?us-ascii?Q?p2e4N0CXbO4JvTom13O934k+7YpzH5UhbRpC9B3JwBg1iV/1tukIcpq9sk9m?=
 =?us-ascii?Q?Cxjo0oTEg+Wy/+sshjsg9sgNKmAJMUV0c318vTwMRDhLcekMC/L1t20TzjIl?=
 =?us-ascii?Q?c7QHHOmu8Gx/RsjGtyI9NLYXCfE5veK1V8xUtMYAj16hKU0sq3dZLpm0OG3u?=
 =?us-ascii?Q?NTBtkF5AEZeiyVddf6F/PPcIttqfVOvrlLRxlITeHib/kfLuy8SztLIfFV6e?=
 =?us-ascii?Q?CgJq3bnMaBonQH7KbVBVJC+PGYlzvfA6uwx9U2WSu7jf6YjEH2UrxNWeRc1T?=
 =?us-ascii?Q?yhMgIMOYBBC75PsUfnF1qJWWmHcS3jPUcg7QfjdAPSE8bk4+AXDCsD95Ll48?=
 =?us-ascii?Q?m5q7k5hG769tzKUdERzFRHqIvZ+koeFUGNbriOnRh8LWuB8gJ1is6AT0nrGY?=
 =?us-ascii?Q?2EPnrkaOtghHtw6j9bx8AYkxolcjlI/nZsuUiJjyqw9srQn8fyRfT6WZ/4Da?=
 =?us-ascii?Q?cKg2LU3btJkCcfKJe4G9Xm6XMI6I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iSq/RdeZ6rpizFBW5N1/GlSzKYp+uGLnNHxFJoX9dNxuJaDw1k8t3ualH2h7?=
 =?us-ascii?Q?qYoBZdHvsgpLt+aHCzHp+y/MYye1pVthnWqmmcwKDRzRYSwhjFyJlbYhPBwY?=
 =?us-ascii?Q?Ls8kxdkasfsNADTN6cbvt6OxouH3Hq2BNvreKn/aL5bmdJFuJOcAAE1L5TRG?=
 =?us-ascii?Q?FJqSIApOhO/jSx/FMmL/AYXIcob4eWNu1fgdD71aIpqVQhqhmvUpuanhOmGb?=
 =?us-ascii?Q?v0PRhD26IrH1r/J6DmXUEWq9rTVg8dBrabMQhvfXAQWKaN0ONNc9yVnTbrcG?=
 =?us-ascii?Q?oXmpTUOPA2f7Vo0C0LMexeu5jzskOwsDKnKctW5FFpnRQjUBgOzLK2xM/6so?=
 =?us-ascii?Q?EiRyl93quiwghHnuPEcAhIQEt+jEZiUMviAUBRCv4dVEgwO38T/qchzXNZEz?=
 =?us-ascii?Q?bdsTX3qvwtqPECr6wzyMZWCrJ0ccp1r9ukDnwwG3eUJTjPnVtp3G39zwD9E8?=
 =?us-ascii?Q?TZIj5ZO02JHpaRGtXTOwNYP10TcFPAKh8tNZX1K0w2lGuSV79ZgbtzNSPyMx?=
 =?us-ascii?Q?S59D+BtP8kDPQSBOtdX42iPZRZ+/PuVPRu+/rl8iuQu5VPwWBiFzzxuq3Xl1?=
 =?us-ascii?Q?vpC0xQ2tHdVj1CW6uwO2Oc9bLB6L/hfQ7D1i49UpkUTpmJLDvMl1W9L3AkSz?=
 =?us-ascii?Q?aJZ/t/hDdm6CwOh2UWnr2sUYX1NaInyZqGZ4VkjfyISF7g+0z1269VZkR+0W?=
 =?us-ascii?Q?7QKJBEfWxg7mek1H7JEPL/y+ADDyOYxefIDOTiSLlL33v1aZfF9zxWd6vSFa?=
 =?us-ascii?Q?NAVX2/JW5FlhvCasoxD8lEz2xPgzWU8cvCLXj6m2K/lbTDujKGjlPssFXBRK?=
 =?us-ascii?Q?78Y7hwuKDRVgPa//bu5ylScASAhRkW8K4Y0vZd5553OimDFM/k53PRFhV7GX?=
 =?us-ascii?Q?XTGPV9x9/MkGtXeGJQvtpabds2aE3hxGimPQU12ljXt5TNvCK5fGoq2YpmLv?=
 =?us-ascii?Q?nmyQ/8c3hKPvevDEE/3K7CaocJYA6B9cbocg14Ittd6dMNZ5TUdrgQkci0/W?=
 =?us-ascii?Q?egkIiIZr+FIS8CdC4JxRaT4LAOTIM/ddhqipNjFhA1Evdzed3rvAuMR3bL9p?=
 =?us-ascii?Q?XSQP5ukCdUCAyAie8mBVYLIWNly70BnBL3DtNjtdmqe8dbrZBby9Q44ORcEq?=
 =?us-ascii?Q?AyPQDrDn0su5AR4T+rL7sl4U6XvEtBYh/gd2gFwed9uTgq24zEdfYvutOR7D?=
 =?us-ascii?Q?cYMD66TMcTiLkGItIqt7y0xkEivXcPM6fmMJngkE2GgA3p6zq1oWBNl2+J17?=
 =?us-ascii?Q?l+8ETw9tXGk7K03oWgZZEl4fQ+m/zpIzHb6u6VAC+HnMQbgyJs1N93mvy1aD?=
 =?us-ascii?Q?zqS+Dr8fcBqLNO9TxIzQNYkd/kbYQ0MtXncD8RkWPHTpG7QG1wzZTZibYcZc?=
 =?us-ascii?Q?tsP0i49om08QGvbIXWAU0EDP5fdkNrtTUGQfFnblGh5w80VKlqcqzRzPmhm1?=
 =?us-ascii?Q?Y1rCTnBicDIWfKm2M7CN6+uiFEhbL9tUs0D371cyDk0efoGzk7Ld7r48ZMbw?=
 =?us-ascii?Q?f3d1Vd7cH7ee38Q907ziTrpUA0n2mQTrQlTRmez1W6Kzad1C0wCwtOSYlz8C?=
 =?us-ascii?Q?cGkiZ9vcixygyW2lrQLf7O8EF10BXbS5rjWPUlVE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ed05ec-55f4-4d23-5947-08dcfdb41d3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:08:40.8302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1o+ijX7vvmmKw/jdif4KkRKWg2f5KsRSylp6ljz2aZJyqLuMi6gkQJh2i2ZW/jsMw16/rAz+TyBabooHPyVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8225

i.MX6SX only has 4 ADC channels, so limit channel numbers to 4 for
compatible string 'fsl,imx6sx-adc'.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
compatible string 'fsl,imx6sx-adc' already document in
Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml

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
index 4e737b193c012..b2e83da637ff0 100644
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


