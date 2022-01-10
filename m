Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E587489038
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jan 2022 07:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiAJGcL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jan 2022 01:32:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3052 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239036AbiAJGcJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jan 2022 01:32:09 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A0Dcba007189;
        Mon, 10 Jan 2022 06:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=lKIF9P0N5qFcounMpWbAj8py6HbJTgP+PdHUj4UW4Cc=;
 b=gIH3anGMRofNZMrqtydRMrsNdnZs5yoFE5TZulP+2/POdKm66Rd/dScKOedkxWYyTJff
 ZwT+u5QTl978+8Ia/htcbRw92gkNYYAzZ2uF3k5HvnmfnzZwc4YDdq4ls5/ZbagAW+JM
 yNBKEADhn4AJbZe/BTEDSw40esmdGb+T9PR0bthcxI/MKC5N4jabY/jwFqqhMithYJ5e
 mGj+YkoqN+dBkoEDggVESLVj1WVEr0dULLVqKQHB7xHfyPu37N5tVVwVcbOffUZRU2Xu
 r9xjB6UnP9LxW3HIDDgOAWKtwhO7g6uAfLYT6vvicv4ZLR3O4896tlQR9vK22RJUGYjR eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df17129yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:31:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A6U5NJ101902;
        Mon, 10 Jan 2022 06:31:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3deyquu0uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYOqT/FPkdEECjG98QTLoEIosx/5zc4dDDhWJdPunrKJBHF+G2YZawhiBQtFW0kPzEPDvCr2WkVtwKQb/IHil5bmX8nYydCrYkCzNuYtNK9FNyxrI06DkEyEO3O3lK7g1FStuXYaCWUIQUT+TcvQk9ZKRAriQaWWf8aCzkcxMxXM8puYUg6R/PJaTMYFoaRkpxfkzbC/gN+KrFbEz6QOpNoA0DAviR8aSEtrzJ4ymV+Q8qo4m5kwLNRPoOm7NRT3g2+JYFw+2/9+XtiUN9bkRjJRmpMxU5NNrxlnXyz0zVmzaoV3PXeMM/SM9JPoG1mvhzaEccgGdBFrmt87FP7ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKIF9P0N5qFcounMpWbAj8py6HbJTgP+PdHUj4UW4Cc=;
 b=JU4ebAPQc0Uf2hhwKQCGbVE3xdSqoB/p0zN2UVIuxTC99H4BLCBQUnWUL496ppPaIC5p0AQUVGj9YJqCGzQGwxG8mjWnBSsBHZVbim6zJ3YmSmQCxCk7uTNKG+ZATGjgr8NDltDxlvFq7EdHK7Ha7/oIw7z4q5+sOp9VMhk4SfcRrOs48aS4aTGN13D7LtsKQTKLo9OpV/GLRo3S+jgKLNUJb43/1uXX02rqhM+6X/3atfjPqqnLm8zgn51RZYBGandlJ0BlrSXe+xvKjdVg77xLdc9GgpnFtvowOyLCzqGK8wjF8pIXE/3pCWLiusFuySBrJfERK/5AMW/VNOaWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKIF9P0N5qFcounMpWbAj8py6HbJTgP+PdHUj4UW4Cc=;
 b=VJPOSvku5sucFpWAUuwggSr4StYzBw1ReufVo+qNfNIz33XXyYXipzVYrcQlRnPhPpIHZpMabx0bRjN7/6Mc2ZEsBoiNTD8XSNX3bJC+4dyEyKU9UKNi3X8dypCOhKBH1ZKSI3J+IlpyRXunRyTXu5dG8IyAVhO7ImoRA/gJvOg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5850.namprd10.prod.outlook.com
 (2603:10b6:303:19c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 06:31:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 06:31:05 +0000
Date:   Mon, 10 Jan 2022 09:30:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Cixi Geng <gengcixi@gmail.com>,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: adc: sc27xx: add support for PMIC ump9620
Message-ID: <202201080313.70ZrhufR-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106125947.139523-7-gengcixi@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4e694a6-1720-4399-8e7f-08d9d402c55b
X-MS-TrafficTypeDiagnostic: MW5PR10MB5850:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5850042DC6EDFC040D06D1128E509@MW5PR10MB5850.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUi1dYRr/ojYP4xcMY8FcPXTZ/TUNQDrKq5/c6I2TWJJ9Oi/vD1gu4EKmM+PJONQL4UyPO2AmTv0IoK89/wfslqC/3KZtMTU56yCPDVLXtuFNDKBNJvnIslfCNDiBkrEk1ThWIFs/HeiaTz6vrdinHhsbHjx28Tak7wKyg07KYEqmrcl0A0ZUwtHR02JauK6Lu5mUs0tBaZpqprIu97HtkdnNGg1NcWrZrWo/sVV0Irn6HsRx0dg/g6icIFSwzFk1jgPE2hctslItu+MCTrZ6qx/xvEseZ1VzIEodhmX6DF0GCm9+gbB4fqNzpAL9yMMUCKcraTGETKt9dObWcoszs/bIGDak+pP27yvqewM/6ucEV4GdY8hcXwjC98xZBv6YUI9S3qrt//PRp6h1mT7d4f52pgjTVHGNJv1joIFoeOUG9vRx5ObPsGAo7b1FLHEiLzO3V7AOc9+RvDLXCcGyt1AA6qU2E3XXL5FDiqn8bWOQrUzSqmJjhSSzdK9KaOJWFbzrTrxQLWTsZYJ1cnpQgisuejT+EeOjjbd/40W3Zre9thism3JRZZY+aUcr+jzepHgJZSuisrCU51+4gp5pSb9KQSijG7NudWMLdj4IX0AzRcukshmFnmAe67aAEN/izBHgaHiQgd67shNZvvzdUXliEtt/Sqa4Omv6uenXWcdaDmX3tA1ou+UQSwXYP1LKLb04QMEVAu2phvLOG+TcdwIMlFx7+2U8kLjP2B6+gkWSiioMuTAJIyQY89KK1X2myVhALSAd5ggVotRo8RhTdKFts48HUL+zYxSJzLM+3c4j7FgHizuy+EDryiBbq+1ZQZbXSaugV9YGfCXlj0Wt2szLYUePGWDTgkwnYQA7Mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(6486002)(966005)(26005)(508600001)(1076003)(66946007)(38350700002)(2906002)(9686003)(6512007)(6666004)(36756003)(86362001)(7416002)(186003)(6506007)(66476007)(66556008)(83380400001)(52116002)(921005)(38100700002)(316002)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6soJs16dpxWZ1WhliHlAX65JvSOWBi2X7MQ0/mhMrIgbOFXuE2mgvNSoRc4/?=
 =?us-ascii?Q?jUFDjRzg16nKsOCASqvuLFjpC2WAyF8oOviPh5rSNBrpk9uZFJeAMKCBbfKB?=
 =?us-ascii?Q?8CCRwhQ5Q2BmT/A8oeGyxIUFAKjgfiorYLsVmbdpSff+jWHz+c/brUcHQF5f?=
 =?us-ascii?Q?BEOcaVUH8XYgGamCYSuIRMdhEX/0tnFydAi3v+2q6ILOPBmZbiZVxVoBkwis?=
 =?us-ascii?Q?IjSayPjueqrkbAKAUa7JoiWyZTlOwf40+ZCAv0q2BHNcBbwVBcF93tA6D7+9?=
 =?us-ascii?Q?ZWE8OD3yL+FNCGdEQiYwd9H9fJz1DUh5HiT7Ai8IpfrC3D79zaA+nlo+yUgo?=
 =?us-ascii?Q?lxVRU/Qad9n7xmiuo1g2JZZY29kFlVxcqdRnNCzjhuQfFw3G7O4jhoL3tWVO?=
 =?us-ascii?Q?yZp+pjJGH8QIWD2M1p65iAspwUxZEVJi/Wy8HBAPGz0Bqy0gYm2UCZ0ttz+G?=
 =?us-ascii?Q?/Y4pK4QNDUwiwZGz58bPw+vY2pURPF8Xa+VdGO8b6Hwt4KMHwSvPPobNNoKG?=
 =?us-ascii?Q?l0saMhWkA+xuMqxbAlCnT6ktIh54LC0g0cBamh4tGpDo97DORa60uWYDrjjH?=
 =?us-ascii?Q?aVF4/V/ULX9hfetVyuPMwjLSe/7l1PhArNQUApslGidZrAYVziPvHTkrpnb6?=
 =?us-ascii?Q?m5MfDZNhhcGSwDdJf7wlOAuWx+ZLZ/I4IUoxYc4BBWssLaTgRUDps0041iL9?=
 =?us-ascii?Q?pA7PnOozKMIIgwYOzVlGAxajBTo/A69fZ9EhfxAxLmN75ih3LDtYW4FtW/SV?=
 =?us-ascii?Q?ywnJhP8ytqtCdtM/epaPfnRlbLrbvQXV0RLcNAC5Qy0k5uuygvn9/Zte/u/s?=
 =?us-ascii?Q?K3ZhnW+FG/RvWQBhIir7ZcurE+n2GclcZnwsxK79haBEuQqiCsGwCV+NhppO?=
 =?us-ascii?Q?ftFIBEBPRgjLkl5sJrS57CUfro67SIVmQB4z/5f8dziyoWAV97b9ZYt4msbU?=
 =?us-ascii?Q?BlYu2p20aMLsPXJ/5ZIHJLp9VWxm9BZym1+n+Fs5B2EjAFJAa09Iifpola18?=
 =?us-ascii?Q?WhQa4zLGg+zLpOIuLEHZWTuzWNaRJ00use356Tm831C7FQBP/Sdm6EbF1gWt?=
 =?us-ascii?Q?PERn29liyhtZj/18D+aIRf8ZiOoHsTEVQydXcXQk9Z/RCRKAQibBQtAyYtSo?=
 =?us-ascii?Q?iOZd1GJaid3LqiBDv0c9py6yR1P208EbJjv4ohw48EDANDyRaqMv/HnOEqHT?=
 =?us-ascii?Q?DC0KyCTxH9avYJ3BV95l2mMOz+S8W20gv1Cg1798KLGGaeeEpIjIQSpzCXjW?=
 =?us-ascii?Q?ZfPhwVpF0ukYIuUGElhi+rd2laz5JjaqbzUzEej+JddiayPoRzcVvC4Q++Rh?=
 =?us-ascii?Q?s2Fbu2DL0eM4X9kELk3MIl3NHUub0fSMqX9Fa1ZYc5j1+GPxUoXXo5dwYrj+?=
 =?us-ascii?Q?hw1bb6GbygD3PEWLLdiUqZ7bTINQDvNr+MBvie2LG9VwEwBTRjZl29KDuyPc?=
 =?us-ascii?Q?LnEaEGfEFJGvAb0OoQVgtOEZscUT3KFij2TMPaw8Yf0ynsTZ73s6xyjGrHF9?=
 =?us-ascii?Q?nvGQp290VUzTfjra+nP4JSw5zWDj0iBy7q2M1fOu2CFD7UepeOO4J8Af/qoq?=
 =?us-ascii?Q?IPbiBcdzw8BUfiu580tUj66uTvVSp8qa6HC6xbeF28A2fCNtQnbFs/UGUI4k?=
 =?us-ascii?Q?vXDmVJrTRDIwc8YIKPHuFui7qBzpKobiTnP4teqxQzBVpDw9W49t2Vc+XPkN?=
 =?us-ascii?Q?SkxLtIehnQ3HuOmogAmq4PCVk6U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e694a6-1720-4399-8e7f-08d9d402c55b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:31:05.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86C7ZTTsMtkainBSKEmH5TSYL+mJH7GXmedhzdBvqkzHCbOeEL6ClPa3gCOnt4Qnq5qUqCjv89TTsf2u3z4rFGtc6dbvMrmaMnksRrYuhCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100044
X-Proofpoint-GUID: buXIcbENAeimnXKz-Zc7qyvPo0vcjUV_
X-Proofpoint-ORIG-GUID: buXIcbENAeimnXKz-Zc7qyvPo0vcjUV_
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Cixi,

url:    https://github.com/0day-ci/linux/commits/Cixi-Geng/iio-adc-sc27xx-adjust-structure-and-add-PMIC-s-support/20220106-210151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: openrisc-randconfig-m031-20220106 (https://download.01.org/0day-ci/archive/20220108/202201080313.70ZrhufR-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/iio/adc/sc27xx_adc.c:196 adc_nvmem_cell_calib_data() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +196 drivers/iio/adc/sc27xx_adc.c

87da8dcc76b4aa Cixi Geng   2022-01-06  184  static int adc_nvmem_cell_calib_data(struct sc27xx_adc_data *data, const char *cell_name)
87da8dcc76b4aa Cixi Geng   2022-01-06  185  {
87da8dcc76b4aa Cixi Geng   2022-01-06  186  	struct nvmem_cell *cell;
87da8dcc76b4aa Cixi Geng   2022-01-06  187  	void *buf;
87da8dcc76b4aa Cixi Geng   2022-01-06  188  	u32 calib_data = 0;
87da8dcc76b4aa Cixi Geng   2022-01-06  189  	size_t len = 0;
87da8dcc76b4aa Cixi Geng   2022-01-06  190  
87da8dcc76b4aa Cixi Geng   2022-01-06  191  	if (!data)
87da8dcc76b4aa Cixi Geng   2022-01-06  192  		return -EINVAL;
87da8dcc76b4aa Cixi Geng   2022-01-06  193  
87da8dcc76b4aa Cixi Geng   2022-01-06  194  	cell = nvmem_cell_get(data->dev, cell_name);
87da8dcc76b4aa Cixi Geng   2022-01-06  195  	if (IS_ERR_OR_NULL(cell))
87da8dcc76b4aa Cixi Geng   2022-01-06 @196  		return PTR_ERR(cell);

When functions return a both error pointers and NULL, then the NULL
return means that the feature has been deliberately disabled by the
admin.

nvmem_cell_get() cannot be disabled and never returns NULL so this code
should just be:

	if (IS_ERR(cell))
		return PTR_ERR(cell);

Otherwise we have to create the whole infrastructure to disable it.  We
can't just create random sprinklings of dead code to half way support
disabling the feature.

87da8dcc76b4aa Cixi Geng   2022-01-06  197  
87da8dcc76b4aa Cixi Geng   2022-01-06  198  	buf = nvmem_cell_read(cell, &len);
87da8dcc76b4aa Cixi Geng   2022-01-06  199  	if (IS_ERR_OR_NULL(buf)) {
87da8dcc76b4aa Cixi Geng   2022-01-06  200  		nvmem_cell_put(cell);
87da8dcc76b4aa Cixi Geng   2022-01-06  201  		return PTR_ERR(buf);

Same.

87da8dcc76b4aa Cixi Geng   2022-01-06  202  	}
87da8dcc76b4aa Cixi Geng   2022-01-06  203  
87da8dcc76b4aa Cixi Geng   2022-01-06  204  	memcpy(&calib_data, buf, min(len, sizeof(u32)));
87da8dcc76b4aa Cixi Geng   2022-01-06  205  
87da8dcc76b4aa Cixi Geng   2022-01-06  206  	kfree(buf);
87da8dcc76b4aa Cixi Geng   2022-01-06  207  	nvmem_cell_put(cell);
87da8dcc76b4aa Cixi Geng   2022-01-06  208  	return calib_data;
87da8dcc76b4aa Cixi Geng   2022-01-06  209  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

