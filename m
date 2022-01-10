Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B62488F8B
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jan 2022 06:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiAJFTi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jan 2022 00:19:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8244 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230407AbiAJFTh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jan 2022 00:19:37 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A1E82C008421;
        Mon, 10 Jan 2022 05:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=CxFwU+KQ7uz3bpzLPdlgcENKOhxD6ReI75yJaDCUw30=;
 b=HHz6TIzfc+V/0uvavWjuxB1TUx8iMgy8qXoegaF4xqeqXAGWFHruuKdU1QXdOrcIrhEN
 ZYQtogUrWxxUI5fHHfIrn614amoiSkz/n43Z0YS9rr1qx994C4Tk0xP2Bx0hS1QsZTkY
 aH54L007XvWt1TcRkvS1sSQ1BbWVVlgmZd81Oml9oiB6sdvgz3WhsJxCOoi/QGU2LRyT
 CiDiqSLD0VOgqtP2bkJrQLIN72orjmwE5pTp7pVsXJbC5r4LLWhAnOsmTBv4mQEj2Bv6
 86NY0J4tBqfwL19DXlYHcl3eWH/1wBIkZBFQpyrhFjLAApDtsF2+SmvOP/QHHkpkYW65 Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df35u24ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 05:18:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A5AN2R195891;
        Mon, 10 Jan 2022 05:18:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 3df0nc3vdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 05:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDOSkwWMe3YYqoT51BGV2BSV+/R6D+nuMHnE0W19RLuSzJhA63LGVFaQEB0wWyxKwyxMjBBi+w+TRRxUEsryR7bEG3jswfUNtRmVsW98ENI/1g51U6BArLOW8kAaEBGSKcSjx1n4W2ypm4gBGkE3BhlQTlglyzD35bwPITJ7XTdrmdbgAmRe8Qahg1Lsqu2uVV3Em+C48XIOceB/PnIIIljioPsXCm2RL1wgvnV1FVwGkt+CI30/xoFKqZjTJbjNhweZBChjn+iYZq2AMekz/33I6fUG2HOjOldLD1EQfTp2ZO8Pxu6bJaXD/t0MuLrRRvXJhqsdS33XyuwuItfbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxFwU+KQ7uz3bpzLPdlgcENKOhxD6ReI75yJaDCUw30=;
 b=MfckfTIecqrc5z3qtiyiqxark9uS3l60lanLhhQjca/BGkQBTJg7vqu9Bn6r75xLbayliYxHn+p+7hTfT9n+CitJelSDGt3X32qoQRIZvdE813ZhfC3QjraptyR3yU/6pJ0c5prnjmhL9rhTX5fXu9ulurdme1x54g2JAyU4WA/dZ0y7WzSRnhzYNlViruwom7cnPJS0AYlS1sOPKQAEvvEeB0uLvdcfUw+hQRKxD9VdHbl7qf0jjhd0yTLwAiQRDPWGT82YLujQNGJxS8VJNvnPJ6Gqdsdgm//e7DYC6yBgXpRhTvNvdbkBEqOSjVVVAfMSO4GmwdVWsrbB9GHLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxFwU+KQ7uz3bpzLPdlgcENKOhxD6ReI75yJaDCUw30=;
 b=gC6bY3cE/t4Zl7dGV3w9l1aof970K2UGDv/fKw+2lIWXpVil8IxZ4Oy9/dMA9QXfIULnpaT0oNLKhFRa5pc07NHWk6uKHtUCRA/FJFA4VHJ8rbVRPA6EDuXydfWAEqGYkbQw7KFP+F3ma2Lq4uHtT8feCjmIJW7GHbE090WEpC0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1294.namprd10.prod.outlook.com
 (2603:10b6:300:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 05:18:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 05:18:32 +0000
Date:   Mon, 10 Jan 2022 08:17:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Cixi Geng <gengcixi@gmail.com>,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/7] iio: adc: sc27xx: add support for PMIC sc2720 and
 sc2721
Message-ID: <202201080030.L51zYw0G-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106125947.139523-5-gengcixi@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5e977c7-09b9-4aa5-a465-08d9d3f8a45a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1294:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1294A6D6A42EDEF6109541798E509@MWHPR10MB1294.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVPmHNAzUKqTSOXZBQdtmZu2JAlnlF9HqI7KSLZzRdLGlWkmX/PrEu+Ew0qdo1U9lRq4NDuVEoVPnQLAsWrXRv+10qJI3uBN6nnNz2LqUuiLRw2GAZJkZelg1D8N8MhMeO6YlE9HoJLyGqXlA9BzGQUYPWzrC6oNU5YuUGvpwb4jNDBhACdrkkXdX30HlRz6looyb6L0H9q/bKJFnzDu6muGidEq4g1LahCSRt4BrJ3U7Rrnc91LRdKZnmsa5WN4fGOeDkSqKuox5IUqK+ZdsZL9K5DxEIHTB8RUPT/t7fsQQKlbBXJ6rQgEAJQ89vUGITBAEgVODmBtYkXpvnfC145wIZIScfRrBvHPViQM1BRfyEj7xwCg++Gnidnl/tYRQjjHEVnJbpM0tvPQ7XGFUa4XcDqHdvOgyAwWyhUBqNDtaYdUfVPCkaSuT0+p0FMd2ey1ORiFoFneyTg9RX6U1uQ0Hm/BXJpRgEhs67OqWPQhkJDHkzhscwdU4AzT9AwcZ/GHrK0tyo6LzGyEZa1cSzCRSQTg3BtEgnA6v7+fGC/gT4KuF521+ALAqohCbtkqlBG1KFWYKWFIAbIrRPhczRXWrDZ81/TV1zlKMPP6Xoh2Y4TCsqTy4pnF6kdXBKjgJy4cSw533uN+1W6YU1NN/5qx6vUoVNv1qqHY0NvMZVATVOb0xRrbH9ph9jFkzWDX62Y5rI+rg777WhlxAKa1VtU1W97Xj4wETUgHmI0vYtqCK2O7leFFNBXZI3E68/uCYE0K5gbs1HJdT3fqBkrbbO6yt45CSf0jOSqWQNE52xuIeHOKquSYdsp2PdhbABrPV1QthNqqlgmWF1wjmhyo8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(7416002)(5660300002)(83380400001)(316002)(6486002)(66946007)(921005)(66556008)(8676002)(38350700002)(38100700002)(6666004)(52116002)(36756003)(186003)(6506007)(26005)(86362001)(8936002)(2906002)(966005)(6512007)(9686003)(4326008)(1076003)(508600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGoAxtp6KALXRDcpFvBXnICL+6nXrqHaUoWMyYeMaovy59YBEt38IY6aj2z+?=
 =?us-ascii?Q?xahC/Xd2LqZiaSK/hToG71B25Zi4lKdMsv6KzfZi5KcGi7P+WrbDkE/pgc0l?=
 =?us-ascii?Q?AdytUkoYGkGJaTqhn2NlXgKBXiHCM71WUyFw0hCWiLjHAtWkHGGNB/8M4K15?=
 =?us-ascii?Q?anDrqAQ959QszrXzhKS9MfiyMN2SeX3KDbBQFmqVGah+GdBlDm7oyI5Uj0C4?=
 =?us-ascii?Q?xFNLsuXq3v0wmcj0OGsFTOaiPVdo5H9JzwowIqZtx/1/7UCpQ8ZvfACk4SUY?=
 =?us-ascii?Q?QY168p6AqUhHiCWRg6cOxHfN9JuzP8vH41kFS1fci/GxZTXlA4SdlCfLvAiS?=
 =?us-ascii?Q?atTKxFxIG/z9VgShgQKvZT4Q4Z5o19IaDhEtcckLGCaOqaGEk+9oQC46GEx7?=
 =?us-ascii?Q?VSG27hLx5Cw/k1x76fJAzlXqrlZgv/KXZVBUFweQD3A8/Armpd12oNcKtfXY?=
 =?us-ascii?Q?UeweYt8P3LDLzgjJOHp8slFtgJqjMAeD1hi7MkYoYpOO6yJPoAPvltPiyR3H?=
 =?us-ascii?Q?XUUGSQpHksYMpVB0iJahQXlZ7upjoMer4F5xGj58IZ3LpFzTt1eu3EDXgf8W?=
 =?us-ascii?Q?U5RfHkuBc5w/CxEp0lHnMtavv2xLOV05286QLDIFUKfCBPwl4XCWbKSlv8DE?=
 =?us-ascii?Q?H8tcPwkuSrYBFXFeaqDbIGjeW3I5aSItLhpqmjybdXbyNPJ7+8n3tA6tZAdy?=
 =?us-ascii?Q?l4prtjKG7HLZ8/otPb1imh+5o79uLrB05mUVPAlEpGOHK0YDnf79V17kSZW8?=
 =?us-ascii?Q?7Q3w3W0LrCX7RAJXNclTHAuRNrmKA1qhsMbYgCmmO7X7GQAXV5LiqwS0LCfq?=
 =?us-ascii?Q?SmEfp8BWxeStn05d3S5eDj5theVPnaZm1jPxmKqHghU/bUUz9aElgjLnIera?=
 =?us-ascii?Q?SYbCGUITpqZwENgDp1dkeL7FBIfcUTT3F/uPJPpp+QgnAhclgyjkrv0tNV71?=
 =?us-ascii?Q?hiqNMx8JnpOeKie042rD5FJi4N2Ll6kfkXIS0liCzP1OkOp6u+LZYjn+E8nF?=
 =?us-ascii?Q?SRJSaTigEg+jptbdcs0dD3f9+Pv1++t/mo86P22j6zaqWtfTzu8LERjZ83Wo?=
 =?us-ascii?Q?df9uUNQAg7At2JAaLlTWnmTs7TJIjQCyLerD0ItuifPWMPs1+UusSMYdr8IN?=
 =?us-ascii?Q?37owUkKELAwlyw1eBsf5zu4ynAQzxJcf/7mprdozHmsXt/Rw/Qt8rttdVcBe?=
 =?us-ascii?Q?5UmkXVoj2mNc19H4bTnVtNS8K7GB6pocBOSIqo9vMSN21w/XsZ5pPuQOJxGK?=
 =?us-ascii?Q?AFEG+GDZy+noY0KpN+VA5y5yB7WL11DpP3BoQbODtYz8oG7iogS0a0bUl/MN?=
 =?us-ascii?Q?iahKtOQ+lC/4p5evC6oyuAhUunK4r8SPDpbvum2sc1lkTidLR1oLS5ZpOdej?=
 =?us-ascii?Q?jVSdXkwHg7312qNQe0jQRXcZaS4DFibMOoM1CwVyZglSemh2nBmepidA/dQO?=
 =?us-ascii?Q?fTqvN4cMaScsE3OV1MLW5ho0wf0RAU5kiRSQWCbhk7i3yaPWmKCyDzvLks5h?=
 =?us-ascii?Q?ym5CCQx6TPvYn0O5R2gGIZ0NdzNy0Fvr+0bZRRf/xG/i+nwe+vsrskBpxnvP?=
 =?us-ascii?Q?Yw/qPKAVImTWN7Amxc7AX5ZmKTeYgm9FIKJVI/cwvSs4y74Jb471V10RIoYV?=
 =?us-ascii?Q?vG6zp/XvKLUc886c238+OzpiYL5v9WGn7RtV7OO5e/eJQ6vbm7n46aDpvXq8?=
 =?us-ascii?Q?dfM1AA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e977c7-09b9-4aa5-a465-08d9d3f8a45a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 05:18:31.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /y2mJvLP2EfU72t8WcfYemugv3v8f5UUMkcx4+KjMsIiH3hmtov2o7T2u8tspP7zlMiTlD3Ac11KYHyi+692VGKTJc+ebVesZwmOyHvD/V0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1294
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100035
X-Proofpoint-ORIG-GUID: apxS1imqBUxkLsp2V5OKoappU9wx-Fks
X-Proofpoint-GUID: apxS1imqBUxkLsp2V5OKoappU9wx-Fks
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Cixi,

url:    https://github.com/0day-ci/linux/commits/Cixi-Geng/iio-adc-sc27xx-adjust-structure-and-add-PMIC-s-support/20220106-210151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: openrisc-randconfig-m031-20220106 (https://download.01.org/0day-ci/archive/20220108/202201080030.L51zYw0G-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iio/adc/sc27xx_adc.c:461 sc27xx_adc_read() error: uninitialized symbol 'value'.

vim +/value +461 drivers/iio/adc/sc27xx_adc.c

5df362a6cf49ca Freeman Liu 2018-06-21  364  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
5df362a6cf49ca Freeman Liu 2018-06-21  365  			   int scale, int *val)
5df362a6cf49ca Freeman Liu 2018-06-21  366  {
5df362a6cf49ca Freeman Liu 2018-06-21  367  	int ret;
8de877d2bba5c3 Freeman Liu 2019-07-25  368  	u32 tmp, value, status;
5df362a6cf49ca Freeman Liu 2018-06-21  369  
5df362a6cf49ca Freeman Liu 2018-06-21  370  	ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
5df362a6cf49ca Freeman Liu 2018-06-21  371  	if (ret) {
5df362a6cf49ca Freeman Liu 2018-06-21  372  		dev_err(data->dev, "timeout to get the hwspinlock\n");
5df362a6cf49ca Freeman Liu 2018-06-21  373  		return ret;
5df362a6cf49ca Freeman Liu 2018-06-21  374  	}
5df362a6cf49ca Freeman Liu 2018-06-21  375  
cd6ab0edd81be2 Cixi Geng   2022-01-06  376  	/*
cd6ab0edd81be2 Cixi Geng   2022-01-06  377  	 * According to the sc2721 chip data sheet, the reference voltage of
cd6ab0edd81be2 Cixi Geng   2022-01-06  378  	 * specific channel 30 and channel 31 in ADC module needs to be set from
cd6ab0edd81be2 Cixi Geng   2022-01-06  379  	 * the default 2.8v to 3.5v.
cd6ab0edd81be2 Cixi Geng   2022-01-06  380  	 */
cd6ab0edd81be2 Cixi Geng   2022-01-06  381  	if (data->var_data->pmic_type == SC2721_ADC) {
cd6ab0edd81be2 Cixi Geng   2022-01-06  382  		if ((channel == 30) || (channel == 31)) {
cd6ab0edd81be2 Cixi Geng   2022-01-06  383  			ret = regulator_set_voltage(data->volref,
cd6ab0edd81be2 Cixi Geng   2022-01-06  384  						SC27XX_ADC_REFVOL_VDD35,
cd6ab0edd81be2 Cixi Geng   2022-01-06  385  						SC27XX_ADC_REFVOL_VDD35);
cd6ab0edd81be2 Cixi Geng   2022-01-06  386  			if (ret) {
cd6ab0edd81be2 Cixi Geng   2022-01-06  387  				dev_err(data->dev, "failed to set the volref 3.5V\n");
cd6ab0edd81be2 Cixi Geng   2022-01-06  388  				hwspin_unlock_raw(data->hwlock);
cd6ab0edd81be2 Cixi Geng   2022-01-06  389  				return ret;
cd6ab0edd81be2 Cixi Geng   2022-01-06  390  			}
cd6ab0edd81be2 Cixi Geng   2022-01-06  391  		}
cd6ab0edd81be2 Cixi Geng   2022-01-06  392  	}
cd6ab0edd81be2 Cixi Geng   2022-01-06  393  
5df362a6cf49ca Freeman Liu 2018-06-21  394  	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
5df362a6cf49ca Freeman Liu 2018-06-21  395  				 SC27XX_ADC_EN, SC27XX_ADC_EN);
5df362a6cf49ca Freeman Liu 2018-06-21  396  	if (ret)
5df362a6cf49ca Freeman Liu 2018-06-21  397  		goto unlock_adc;
5df362a6cf49ca Freeman Liu 2018-06-21  398  
8de877d2bba5c3 Freeman Liu 2019-07-25  399  	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
8de877d2bba5c3 Freeman Liu 2019-07-25  400  				 SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
8de877d2bba5c3 Freeman Liu 2019-07-25  401  	if (ret)
8de877d2bba5c3 Freeman Liu 2019-07-25  402  		goto disable_adc;

Assume we hit a goto.

8de877d2bba5c3 Freeman Liu 2019-07-25  403  
5df362a6cf49ca Freeman Liu 2018-06-21  404  	/* Configure the channel id and scale */
b39db3bcbc9a96 Cixi Geng   2022-01-06  405  	tmp = (scale << data->var_data->scale_shift) & data->var_data->scale_mask;
5df362a6cf49ca Freeman Liu 2018-06-21  406  	tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
5df362a6cf49ca Freeman Liu 2018-06-21  407  	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CH_CFG,
b39db3bcbc9a96 Cixi Geng   2022-01-06  408  				 SC27XX_ADC_CHN_ID_MASK |
b39db3bcbc9a96 Cixi Geng   2022-01-06  409  				 data->var_data->scale_mask,
5df362a6cf49ca Freeman Liu 2018-06-21  410  				 tmp);
5df362a6cf49ca Freeman Liu 2018-06-21  411  	if (ret)
5df362a6cf49ca Freeman Liu 2018-06-21  412  		goto disable_adc;
5df362a6cf49ca Freeman Liu 2018-06-21  413  
5df362a6cf49ca Freeman Liu 2018-06-21  414  	/* Select 12bit conversion mode, and only sample 1 time */
5df362a6cf49ca Freeman Liu 2018-06-21  415  	tmp = SC27XX_ADC_12BIT_MODE;
5df362a6cf49ca Freeman Liu 2018-06-21  416  	tmp |= (0 << SC27XX_ADC_RUN_NUM_SHIFT) & SC27XX_ADC_RUN_NUM_MASK;
5df362a6cf49ca Freeman Liu 2018-06-21  417  	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
5df362a6cf49ca Freeman Liu 2018-06-21  418  				 SC27XX_ADC_RUN_NUM_MASK | SC27XX_ADC_12BIT_MODE,
5df362a6cf49ca Freeman Liu 2018-06-21  419  				 tmp);
5df362a6cf49ca Freeman Liu 2018-06-21  420  	if (ret)
5df362a6cf49ca Freeman Liu 2018-06-21  421  		goto disable_adc;
5df362a6cf49ca Freeman Liu 2018-06-21  422  
5df362a6cf49ca Freeman Liu 2018-06-21  423  	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
5df362a6cf49ca Freeman Liu 2018-06-21  424  				 SC27XX_ADC_CHN_RUN, SC27XX_ADC_CHN_RUN);
5df362a6cf49ca Freeman Liu 2018-06-21  425  	if (ret)
5df362a6cf49ca Freeman Liu 2018-06-21  426  		goto disable_adc;
5df362a6cf49ca Freeman Liu 2018-06-21  427  
8de877d2bba5c3 Freeman Liu 2019-07-25  428  	ret = regmap_read_poll_timeout(data->regmap,
8de877d2bba5c3 Freeman Liu 2019-07-25  429  				       data->base + SC27XX_ADC_INT_RAW,
8de877d2bba5c3 Freeman Liu 2019-07-25  430  				       status, (status & SC27XX_ADC_IRQ_RAW),
8de877d2bba5c3 Freeman Liu 2019-07-25  431  				       SC27XX_ADC_POLL_RAW_STATUS,
8de877d2bba5c3 Freeman Liu 2019-07-25  432  				       SC27XX_ADC_RDY_TIMEOUT);
8de877d2bba5c3 Freeman Liu 2019-07-25  433  	if (ret) {
8de877d2bba5c3 Freeman Liu 2019-07-25  434  		dev_err(data->dev, "read adc timeout, status = 0x%x\n", status);
8de877d2bba5c3 Freeman Liu 2019-07-25  435  		goto disable_adc;
750ac07eb2c856 Freeman Liu 2018-11-09  436  	}
5df362a6cf49ca Freeman Liu 2018-06-21  437  
8de877d2bba5c3 Freeman Liu 2019-07-25  438  	ret = regmap_read(data->regmap, data->base + SC27XX_ADC_DATA, &value);

value is initialized here.

8de877d2bba5c3 Freeman Liu 2019-07-25  439  	if (ret)
8de877d2bba5c3 Freeman Liu 2019-07-25  440  		goto disable_adc;
8de877d2bba5c3 Freeman Liu 2019-07-25  441  
8de877d2bba5c3 Freeman Liu 2019-07-25  442  	value &= SC27XX_ADC_DATA_MASK;
8de877d2bba5c3 Freeman Liu 2019-07-25  443  
5df362a6cf49ca Freeman Liu 2018-06-21  444  disable_adc:
5df362a6cf49ca Freeman Liu 2018-06-21  445  	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
5df362a6cf49ca Freeman Liu 2018-06-21  446  			   SC27XX_ADC_EN, 0);
5df362a6cf49ca Freeman Liu 2018-06-21  447  unlock_adc:
cd6ab0edd81be2 Cixi Geng   2022-01-06  448  	if (data->var_data->pmic_type == SC2721_ADC) {
cd6ab0edd81be2 Cixi Geng   2022-01-06  449  		if ((channel == 30) || (channel == 31)) {
cd6ab0edd81be2 Cixi Geng   2022-01-06  450  			ret = regulator_set_voltage(data->volref,
cd6ab0edd81be2 Cixi Geng   2022-01-06  451  						    SC27XX_ADC_REFVOL_VDD28,
cd6ab0edd81be2 Cixi Geng   2022-01-06  452  						    SC27XX_ADC_REFVOL_VDD28);
cd6ab0edd81be2 Cixi Geng   2022-01-06  453  			if (ret)
cd6ab0edd81be2 Cixi Geng   2022-01-06  454  				dev_err(data->dev, "failed to set the volref 2.8V\n");

ret is reset here.

cd6ab0edd81be2 Cixi Geng   2022-01-06  455  		}
cd6ab0edd81be2 Cixi Geng   2022-01-06  456  	}
cd6ab0edd81be2 Cixi Geng   2022-01-06  457  
5df362a6cf49ca Freeman Liu 2018-06-21  458  	hwspin_unlock_raw(data->hwlock);
5df362a6cf49ca Freeman Liu 2018-06-21  459  
5df362a6cf49ca Freeman Liu 2018-06-21  460  	if (!ret)
8de877d2bba5c3 Freeman Liu 2019-07-25 @461  		*val = value;

Since ret is reset, it is no long connected to value.


5df362a6cf49ca Freeman Liu 2018-06-21  462  
5df362a6cf49ca Freeman Liu 2018-06-21  463  	return ret;
5df362a6cf49ca Freeman Liu 2018-06-21  464  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

