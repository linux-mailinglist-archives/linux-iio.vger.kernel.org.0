Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4944862FD
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jan 2022 11:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiAFKgH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jan 2022 05:36:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33540 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237815AbiAFKgG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jan 2022 05:36:06 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2067Xwnb017380;
        Thu, 6 Jan 2022 10:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=bmk2gvbYep6qmGKslLtc3y6oAd7jPrbuw/X4DRGrNZ0=;
 b=a2a4r77G1Kc8dbiWcnqx/vJ1cBFUSLc1F6Xgmvoi9GnZ+Bk76GF4iiUU61+GVAnclwHq
 JR/R52SE2QESgRgCahyLOpaoS7P6pHP4s2xWhgclx7kqFYIhMvyP1PTimFEPM/ISw4sM
 9Uj9gdyMZELwad4IxniR3Ga2cxsa6yxIds8dBRPePhAXW2hi6Xf4BpzjtJZNo9rdklOj
 GrVY8Tq7ulhbToUqj6guvwLTnPSeLhZcTfPJ+sdB8AzTJ600Jq7RPQ/9/2Z14SrAbAdf
 31mcJn+k/uDkb5QhYq1HHpxEJeTqonQT3na2x5YW6Gf/Q64VhBTH9Gn9JvP9BtOQrvFl IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpm1867-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:36:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206AVgag177163;
        Thu, 6 Jan 2022 10:36:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3ddmqanbp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:36:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQjV7N7iql3UeBKz23idaEveq7PZKQ/Qm/hdHbB+zgUNd6dsfkm+J2Yn6H2eY3DxPiHIQWtYGlstsPKIxIC4v+KIlariERIcLp26Ec6tFZ532qLe4/5E0r7tOMG7oyHw4JSV3K/xLDjqKVtN6OCtQOYq+rXThNp7h5/yqhNnTzaDXnoQ4Ig1VTn7/WYQ+OGL8cj1llYSl5q6rekprH8274rzJXWwrqXZd69MwQeP1GwOh+/HSuYkpI9ihhCvofakbPZjcRdZoYYkt57V3O6lslmsU7ECw0qNc/8L8aIz6NCXcYoGE7npq6zuio9F27SS+qKRWdUR12CDqrLAMESMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmk2gvbYep6qmGKslLtc3y6oAd7jPrbuw/X4DRGrNZ0=;
 b=YAZVVeEkTY8+RGuAZ7skno9IKtqLDlE9QF2FMvrCFhueNs2el3lm+XB/cNm2bar3VnAcErlI+7QLbPpkSMr6ggBykHXGHx9ICKRQiQ8E9LCJBqU879XxWIXhocelrPIm59YUb4bLQxQd04bKJacUWrM5HiWFCHvMZNRRvfxMIp+vKxv0fxvASS6BvIDfqz1+mtPvGEse7/q28MaEvKzSA80n+PNNx1Gq5ubzP6hIDgd8rVKCfidzTJPTNxa2hiK3XJBBmiGOsXrwiHeKX+NnO3c0JRLUILl8Qenp7uQgcbhplSLwWcBiaDzw1mgoGeHu6VfziZIvBQeZAii7gGtV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmk2gvbYep6qmGKslLtc3y6oAd7jPrbuw/X4DRGrNZ0=;
 b=NolLlNIoyb18Gmyive+ddTg9rPpN1l3E174M2ZAwQzW391n6+fXCge5vvyHqytesrv1QZfhFwNA0BXdFAbikzLanTRCSlOWTHtSq1yQ/rfOq1hmPn3t/v6MzgZVcm6ay7AfwlXwIHRM4/cBGHaMOMmy2gIY4Mt7PUjDGPW2qXJM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1485.namprd10.prod.outlook.com
 (2603:10b6:300:25::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 10:36:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 10:36:02 +0000
Date:   Thu, 6 Jan 2022 13:35:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mihail.chindris@analog.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] drivers:iio:dac: Add AD3552R driver support
Message-ID: <20220106103553.GA26440@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0127.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a64530e9-c2a7-44b8-e97c-08d9d10055c0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14859A340450F59BA6E498DE8E4C9@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOh3eyKt2fe/PpfCgVs/NlMzQ/4TQ83AHwF88F9ToCPuz/sbor35y6CMyIv/AupBHLlAlM1GEhSRhhSoBY5OFdumocywmI6HNbOmdQr2XBcE9iJXtdKEwbUTry6+FgGNrxNVQRxofkOfGOMVb3tgZHIKugPMStnFnQnLFJWXyb8t1PiKKuAiMKv8hJ6lzJdnIM6ZpK5yBoQKgTtz+UuFYU8igoClu1dfuDZGg7xOAdMZPW+noAoi3wndz71RXmiRLu3OrKqgpnEdrIo+9T5V51QyKppBVTOrzeY6tdubQ0VsEIdoypxkHVIKwb+f/jCNvNiAz3MtTm+wt173T7opAqkfGfx+W2GTzWfFj9xbsY9qhukd8aZO344ZevDEw4+k2z0nwnVFOLAj1uZHcclyYSVGmBWNsLFSEK6ZgQKDmOvD5UaPgiyoxIp7RaqS/P3CDuaov4f4A90kSpOwAVRAVU/MuVIPENGLMhLbR4GFORQFqqZYv262o2Ce3JUSwUr6UqexCYzz5/CEjJLTboSQE4qmsf9c9hQhxG4snqjA7OHLHGxijHIqdvwlWY+XfdL2ewR8pRWWHNsEumxDoiBZg1maKyiyiYpMGZV1lT5J1CqeQ+QsdL1FqbouNzFMCv37VDK3SxRewsNO/QKVtdbVXN+1esvCC0wkxQihCLSBUo7Dh2W5d4Bo3xqU5WlqazvFlQweztqGMOsyVDxNr0ns6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(6506007)(38350700002)(9686003)(6512007)(1076003)(86362001)(33656002)(6486002)(8936002)(6666004)(316002)(66476007)(66946007)(6916009)(5660300002)(83380400001)(33716001)(508600001)(2906002)(44832011)(186003)(52116002)(4326008)(8676002)(26005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdgeWaoIVt4S/C3F9tcf61ZGWhL0QiTWx1882DlVEKB0ZdWY/7vbrMNHnCEX?=
 =?us-ascii?Q?/wEmBVb+lwr5zeT5NlFls0FQwzOlvXtG8bxRTUCsYoHVoV1YHfn5uowccZse?=
 =?us-ascii?Q?S68+XpDesewX2eA+wvfvwyVTfb7fmWGWixp7MHWZyRFQpNfY9aASm3AnMbaB?=
 =?us-ascii?Q?tYar5H4aWuptRbOO1x+Uqb8diFn3cBe9LbHpUxoHTJLWIjQ6w11N8naT5UCg?=
 =?us-ascii?Q?MWdN4t5WtPEYxDQ1lrTw44/lxfSREQ/Gu6P3zVn4gmk+hd0ZvqMi60SgQt0/?=
 =?us-ascii?Q?E5sfjSrz5epLTMkbWYoes4qx/zLPrdosgRKGFwAkV+ygDn9cEjYbQq60WSR1?=
 =?us-ascii?Q?mcySvD5rz1Sja2pmgH8ltsU7se4vWGSUZAZlfUgXLG0HFkt3kwLBcL5xtjAC?=
 =?us-ascii?Q?Q0Hc7++4pUh+HoHwPaN1emOmiRfTidD+knMwIVU9ZcpAOwIN8YNcuq2u5sPk?=
 =?us-ascii?Q?knA8MJ2i7Z0QEcy1yNOmgkGE8miSUXVA4MLy6AXNnxR4hj5ALkCA8yncoDdw?=
 =?us-ascii?Q?bPdxOsaBM9Bf1xnR5LClsBzsPzyUxrt0toQnJTXIsBd6Gz2W4icLVnGdLh7A?=
 =?us-ascii?Q?SRTGRdJxZtnNbjN3uigq2owyqVGnTo875WJcObsHzbJJ0tZeCy3Tf4xRLdnS?=
 =?us-ascii?Q?w41l+ePKtOyCfv0BN5PvPXHavtiUDkocHAzS95O00Y1zCOqswzpk3IM9xI1R?=
 =?us-ascii?Q?CIZwIzk6oGbVcENPB/MEEcFK4IWc2nQX1GVbSnwYbdvEWOTv7ewKg5IsvE+b?=
 =?us-ascii?Q?+N2div8LuR+ZME5S03a9vBjUNaus91vPxaQ8MEaDo3jhxzzY7kz/FkOyTeN6?=
 =?us-ascii?Q?WDGQU9aDl8dLiHIJA5BjdXgpE9/oM7we0RY6gGNyWohrEwgr7zSXMTAS9d/E?=
 =?us-ascii?Q?+2V2nTAApQatZ5hbmi3lNQLjH3dGp6sDNLAvuzeywHFDuq6lGF3NrFEzinOp?=
 =?us-ascii?Q?o9zmh1ej7BmzXTZDzUxcA4Y8RjiEc+m46yFSwPGKYLGTPbXIQi5tkYYnsFqz?=
 =?us-ascii?Q?TvSkR1GhgHlf2t4g9PSeKJ8Qj9/h3WfTSw8tqzA9VERLoXgRNKrGGy4+fqMc?=
 =?us-ascii?Q?01B7g4Hug1pjlnTipHYrQBvXodbH1IqQu/6xYH3e6CSl3yNRb/pi9tnwo8u2?=
 =?us-ascii?Q?M7ZEoLwGQQClN0A29qLkg8HYhLCWDLRChVVEgWVw7n4juesLNopBWRT5xkhl?=
 =?us-ascii?Q?m0LcM5uL8/FsQr2Ljwioy0IyCIugVbTxp63Iye1vCoXhLth49KP6BwkgvL0f?=
 =?us-ascii?Q?Qiy6JJXc4LSaqgN2vS0N6m+F2XZHmLORYKnAJyC0GDsP4TusQt70iZ6VnHgJ?=
 =?us-ascii?Q?exKetbcWA7ZXI75NK5zdFrn+KchPHma3QF57q7g/Ptp5XelcPQrkq8l4mUE1?=
 =?us-ascii?Q?1mIgqgzlPVBTDav9EsNhDdOoNKelUraADQMGW/qCcexX340Ok062nFuClNhq?=
 =?us-ascii?Q?worQ5SKQslgttSBJVGWBW8i5TZXlbZVDIlsZ+9uOJARQHLyA7odJD0lnIoBA?=
 =?us-ascii?Q?baqHE0rqbHY9yWoxUiJjndWsDZUn/NDisiEr4KLm+2BYQNKCFGInt/31Mhst?=
 =?us-ascii?Q?bmlD6TNbJKgdt0JWkW987p1MPH6BtNm8bHOgcPlFfkbq8kyN7RWd3MEnZ8be?=
 =?us-ascii?Q?m/5kiXa8qbgRZKdG+1EpzCufrnitVgdfTmJONqNEQYgt9ZMM5oLzKfhv/HOg?=
 =?us-ascii?Q?K47cTn9XJYsfvMisFJ1wP3XZhMM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64530e9-c2a7-44b8-e97c-08d9d10055c0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 10:36:02.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVMYZ5jRdStqWxgzt74MNHF0tHHBfufVSHbok7FhoDYl+Nfcddw6u5lLW2DQG63JeTd7cdWJMztluqhhOIxgf6mYbUQK0TgGWajnU+YFirU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=896 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060074
X-Proofpoint-ORIG-GUID: oE_EQ4YAs7JdizTPoGF_DAwH6qNQJE8k
X-Proofpoint-GUID: oE_EQ4YAs7JdizTPoGF_DAwH6qNQJE8k
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Mihail Chindris,

The patch 8f2b54824b28: "drivers:iio:dac: Add AD3552R driver support"
from Dec 13, 2021, leads to the following Smatch static checker
warning:

    drivers/iio/dac/ad3552r.c:688 ad3552r_reset()
    warn: impossible condition '(val < 0) => (0-u16max < 0)'

    drivers/iio/dac/ad3552r.c:699 ad3552r_reset()
    warn: impossible condition '(val < 0) => (0-u16max < 0)'

drivers/iio/dac/ad3552r.c
    655 static int ad3552r_reset(struct ad3552r_desc *dac)
    656 {
    657         struct reg_addr_pool addr;
    658         int ret;
    659         u16 val;
                ^^^^^^^

    660 
    661         dac->gpio_reset = devm_gpiod_get_optional(&dac->spi->dev, "reset",
    662                                                   GPIOD_OUT_LOW);
    663         if (IS_ERR(dac->gpio_reset))
    664                 return dev_err_probe(&dac->spi->dev, PTR_ERR(dac->gpio_reset),
    665                                      "Error while getting gpio reset");
    666 
    667         if (dac->gpio_reset) {
    668                 /* Perform hardware reset */
    669                 usleep_range(10, 20);
    670                 gpiod_set_value_cansleep(dac->gpio_reset, 1);
    671         } else {
    672                 /* Perform software reset if no GPIO provided */
    673                 ret = ad3552r_update_reg_field(dac,
    674                                                AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
    675                                                AD3552R_MASK_SOFTWARE_RESET,
    676                                                AD3552R_MASK_SOFTWARE_RESET);
    677                 if (ret < 0)
    678                         return ret;
    679 
    680         }
    681 
    682         addr.dac = dac;
    683         addr.addr = AD3552R_REG_ADDR_INTERFACE_CONFIG_B;
    684         ret = readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
    685                                  val == AD3552R_DEFAULT_CONFIG_B_VALUE ||
    686                                  val < 0,
                                         ^^^^^^^
Unsigned can't be < 0.

    687                                  5000, 50000);
--> 688         if (val < 0)
                    ^^^^^^^

    689                 ret = val;
    690         if (ret) {
    691                 dev_err(&dac->spi->dev, "Error while resetting");
    692                 return ret;
    693         }
    694 
    695         ret = readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
    696                                  !(val & AD3552R_MASK_INTERFACE_NOT_READY) ||
    697                                  val < 0,
                                         ^^^^^^^

    698                                  5000, 50000);
    699         if (val < 0)
                    ^^^^^^^

    700                 ret = val;
    701         if (ret) {
    702                 dev_err(&dac->spi->dev, "Error while resetting");
    703                 return ret;
    704         }
    705 
    706         return ad3552r_update_reg_field(dac,
    707                                         addr_mask_map[AD3552R_ADDR_ASCENSION][0],
    708                                         addr_mask_map[AD3552R_ADDR_ASCENSION][1],
    709                                         val);
    710 }

regards,
dan carpenter
