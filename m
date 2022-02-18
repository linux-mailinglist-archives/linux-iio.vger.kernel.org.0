Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5FD4BB860
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 12:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiBRLkc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 06:40:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiBRLkQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 06:40:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9732C29F5;
        Fri, 18 Feb 2022 03:38:57 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IAR9jt012876;
        Fri, 18 Feb 2022 11:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=1hLFI1R0AWvuny9xIyikvS+n818n17pnPmPwx2B4P0U=;
 b=vwAM/oZ+y2KHFUJZroF1RCFkpx+s8JHXI5mBe2CozFire5KluvzBdcl/AWftEHLClkwZ
 BsCkPkIYbfBmRn/e36GL/DUJkWOYmuCmAvaHPKjAEJHYZKfJvnoCx4cOuKntGqgBJ1R7
 /4fbM6h4/KAPkhCYljGIbMw9uicmHUMf8Q1PfFJfESQ2IMkUxZAnZhMKl+UjE/5oQEEb
 wkNks/6O8cUJsU8DtxXre1f/lcEtT9JJxyc/YaPa/LCD7kzjwySjEPmjlSCRvoqXf+kU
 EKWmTFHOK13jGQQZG8f+7Mb7TqKS+dF2SCWF7/ywGUCCZe7DYuM5ECRS7RMwihzQnVHv gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nb3rs2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 11:38:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IBUd6j033167;
        Fri, 18 Feb 2022 11:38:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3030.oracle.com with ESMTP id 3e9brdnt59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 11:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGJF8gbj8TY04G1npudj1dxrROGI1+DjprgMFXOQWOfyxNl3kyfJUvxRbQo5eItvNd0bBDlbM63YqvjGjOoJRO4lxylx2KC+FC2elrfWkrHd+Hq1Vw144K9o63uuc3uelE2wUAuAgFZMTxiAdAkrKd5phlvEvxNYIKhMV/+cbtCOpKCQujH0MJYhy0hyeoQgnHUvfBPqxR7Bt8WLHKu1sd8ql63VijP0oW7AcaMmnn+VM9Zc7zYvFdsu8fLTH1RFYWwiO+vKWR46vMCf7Bw0RgdzbY2r/vkaiqefzpYdYdKtWND82vGWXzv5ZqBywAkeTcOrrbEXpG1UTqaxkhYAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hLFI1R0AWvuny9xIyikvS+n818n17pnPmPwx2B4P0U=;
 b=AAFtYeV8K+0Pcfdf+pJzkYLJlKmJ7+8UouyviLYF7ZYujCK1c3nF5UuQECLemHGa/7z+7yaV/dSj4XpJCscellY9DQSV2TpfoHMdPPdh7tEbl1VJ+/yeDCng7KYcsKZpD/7fFPGkBKylachDFTRRyaoZYfe15AAnv7NR+6RFpTwoYrv8PbjbLV7+FqMMsFRNEkPuy70NzyReVb2peyVJZxvatbluYhFc2DvqZoXOINiymxRKJ8q0GdvSvJ8rAiQn8mK/AF+8a2Z7p/fNLKDg5t5AWOmb4g3Wf4wqZm0SC6dGSVIaWjaxBdyT2fOtO80bT2iYhoqYMz+tSaiK450BHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hLFI1R0AWvuny9xIyikvS+n818n17pnPmPwx2B4P0U=;
 b=zaHTiuLjYAFItKKPXE+obiMxCX4dF2Bm2KgfcsLviP2yxf4soSXwsGX93AnpIA5aP45WGEkXU+1Rm5cLRDmhsTfpZgLFnbddlHItIjZDTKJTpcARiwvrvciHhABghDU/7m0ub3UVN44tGTS5S+JZA+Lv+TWBtKc1Eh5TXumhb2Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1842.namprd10.prod.outlook.com
 (2603:10b6:404:fb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 11:38:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 11:38:33 +0000
Date:   Fri, 18 Feb 2022 14:38:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Subject: Re: [PATCH v7 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <202202180412.YwXgb5WR-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216134920.239989-3-caleb.connolly@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 254c2d23-98ba-4feb-8379-08d9f2d3319a
X-MS-TrafficTypeDiagnostic: BN6PR10MB1842:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1842A7049F610255C9FB0E858E379@BN6PR10MB1842.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1UbRNZ3rLBwqMqUMxZ4dhL0poRwX9R/Sbi7ZEOZ6ZDzdh6KdRxvEVTYMQvuKE5O9bZaEzjjCrdOi3a1BfTpDCaqUi5MWCAeYVU8V4Hl2OMowjbixowzZqaCAfnXTUVGYG+WSk5paYvUHG4FqMjba4PlHgQ1y3Z8N+QhShjHi9QdpiAv7K1yydXWlw4GjzijokIjg4UTlfBRim4SiyrEQpr0dyRvnIzu0WYgGZtFJB2ChlhDalOmNqwYf3PkzJL7hYTr4hDsyDtiMm8HyKGJtDufnza3oA/IKWzXK1JB+iOHZZIXOyKjhAlOKGwjawFs6CfEZl6VeCpNX6JO5rvLCfqYM8UL/4QZcS3f5ukZ4ud0yqll6xMC9ngYpXa25+cIGRaWvRbPx7ZqwPP6VZazRHfXMpWZiCUKJC3POyx6s3SrKm0afF/o3fZdetrj6zFhoL2QfvuXignzpEVbgFLFDIw0sqHO4u+KU0DgoFxr85geFcvNrmSQ+82AcDix/UH463NEyVJ0jYxlw8WpkT/4u99rkWMkjDNy92xaGb6XpqnCXQ+gGUlaoZvaTTPZTXgi/vtT95beXRkQKWvZ9eYoKl87BxAv55Zxajys01sghP4KfOl8kyBDWgVLBKMGq6kehOuV8YiHXi4fU7ZSOGXFfnBl+fUb9yLVQlQH8qarclH1K6HOIju3l2vZE9B0C9O8jfPmxc2I6eSwNb9yT/W4bOhc5SFqZRQlBfAgduXAuZ8gW+cIe5JF0binOZq+ajZu/auJU/A/yZzH1yebXs9eEvomlUvtyScRdBh0W1p++gf2iS+wx4UbkjQ4A9sJvcSfi9CLwkSG0mNqcCvUmxmpcUfG0F4K5jI/zhZm57qN4wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(26005)(52116002)(2906002)(38350700002)(1076003)(38100700002)(6512007)(6506007)(6666004)(36756003)(9686003)(7416002)(8936002)(44832011)(966005)(5660300002)(86362001)(6486002)(508600001)(8676002)(316002)(110136005)(66946007)(4326008)(66556008)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvACfu28Cc5b5hsi3V63LwDszaxrL+b9hLGJXjdkUlg+Q41E9MGdQuTr/V0z?=
 =?us-ascii?Q?A8fFnl/B8RF8ovGftWxT/B4WAqTy0haqjbQ7qOG4auMaB/YPU0KMsfWpHXB+?=
 =?us-ascii?Q?BXoSMjwcGWfxmH5gHY+Gz9X/TSW3Ze8q/U91blQlOOexsN1NfMVvkznuC6yo?=
 =?us-ascii?Q?2o6gihGNmDiM1QdNnPWMIijv5DyuQ12rMgv5b2QuLcSh8jHrSecEmwTgcTfl?=
 =?us-ascii?Q?5cvcgptpjMfvkx6m0MRRD6c6/GT481ISkbXAnLu4KkvMBP9QfnvajN9SpX4S?=
 =?us-ascii?Q?13geQdxxOgSwVf6q1xhQ8QY+5D7mx23iMxG9jQwKV1ouS/s6KfRyiz+rT+iX?=
 =?us-ascii?Q?OQUlbGpkXjk23DDHeBRPpT2MkLbbDeM8QE4Qal5a+SgkdjBthxqTomsINYe0?=
 =?us-ascii?Q?3mfoI+SGK8jwYrJanWkVzMUxhqhxNzeAMwCMVoHVlyekf3hqEhiEaFnWJ72C?=
 =?us-ascii?Q?dJzt0nywW7jx7FCSitnrKm1xXxYLyAQAvM5pwTPuBYL7UR3E5CQxoCZA/Ueu?=
 =?us-ascii?Q?x66Fp1tFR7cPxilxnGsBFpNkS1qe/0dJhk7aAaTxOy6m3i623PN5ypkPWXfa?=
 =?us-ascii?Q?x0fS7XvRZMy+PmdVjvoOIxDm57TS8g7cM/yrvrSfWAr/xU4NKLS5wFAfNqBV?=
 =?us-ascii?Q?dne79hxfxkOYpPBAqnumIdK32TiTcFo32PEvQ2zsTRf7+1Ox6IaU4nfJB7Ny?=
 =?us-ascii?Q?MoO1kJ8RQO8EP2yILYUluJKHYJUcLRhMK9omMqXxhINDhUgMo9smI4cAk687?=
 =?us-ascii?Q?WNK6zQa+v8qBHl752A6l36aByuIdgMgENE2oFfh0UOKv1vzTK91H7RJyJRQI?=
 =?us-ascii?Q?k0NNBimuZ3ht+fnkOTBXMBvf44ezJALYdlO67FNlJPMsDdIcQMAVxlWq5TY0?=
 =?us-ascii?Q?ycXYJgevOjUGfo0g82EKt+ZDpfknEhLq2OITKTPcsgNQaQFFvJyuPb3YBsQb?=
 =?us-ascii?Q?IO1MvG9zoyyq8K46C6iZQMp+rv3jRB4O8QidaV9osyhp5KM8EQveLe6Y4FxE?=
 =?us-ascii?Q?7+GoqcO319gAYHzIsgnZJTtsTN86xRoUpoB9+5C7l9HoERn03spKxa/6tSUP?=
 =?us-ascii?Q?lFa1F9T0p0QYRncvbkH2rLB0bKyrBbAy1cyfBeEmflyWVNKUEOnVqcTOncHD?=
 =?us-ascii?Q?X1I8c3ypAsgl5tRpR2TXTujwJ69fsYVjJEX2qqvbN6JmpY7bZjqZMeYye2l3?=
 =?us-ascii?Q?nNCXLB0Fs950iFI46Z4xED2cIW0aImYLwy24WaJlYm0sxjNnH27PatGvtfMj?=
 =?us-ascii?Q?hEpcn+oLGdyGK56Iq1yo74TCuW9XtnvZ/kQMAKBtFrS1SyAYH7NfDS189Mfm?=
 =?us-ascii?Q?z0D26ivsXy3STtnLCxt8I6hzGR6jg1mdkaZ5G4WYPJyKV3wcBxg9bfyaEZ6i?=
 =?us-ascii?Q?oMlP0gIsabrsGch+KAqi2ljWkWd8BNJoh0tGaECxnjfQTe17+ToRD7E4c9Xx?=
 =?us-ascii?Q?788naAeX2pj7M0zAY7bJ5zXYlVRZ9+/ycuYHOS8Til34RHKuciluDJwrCkjx?=
 =?us-ascii?Q?xyYj7a854EanDJRupaloVu/SnGeo2LQ3cSKC57zgLQtw2gGHGQI+Ad5B80nI?=
 =?us-ascii?Q?1hau+rPgAhZnbtwu3aXR3+kEnkGA5g33JvGZdLMhFPPh84yFmSMiAx0e79CI?=
 =?us-ascii?Q?/Ftk/2wuksrJsefm8okiGw2rEYAukLC24RfVUYZWceQ0quSumuJzy9Mk4asZ?=
 =?us-ascii?Q?6sYuow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254c2d23-98ba-4feb-8379-08d9f2d3319a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 11:38:33.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNeE9mIiTruw5FZfaffmTlkLDKOq9XdFZfHWtJUG/K+lDaiW3PEnXpRubnu7MbLoOTXLsifgUM9bSEfMDD1q7hk2QOy0bFl/6+q6v/mNtHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1842
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180074
X-Proofpoint-GUID: iBNQKn-QzYY3D6p7CUpHfR6HzOfcMJ5k
X-Proofpoint-ORIG-GUID: iBNQKn-QzYY3D6p7CUpHfR6HzOfcMJ5k
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Caleb,

url:    https://github.com/0day-ci/linux/commits/Caleb-Connolly/iio-adc-introduce-Qualcomm-SPMI-Round-Robin-ADC/20220216-215127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-randconfig-m031-20220217 (https://download.01.org/0day-ci/archive/20220218/202202180412.YwXgb5WR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/mfd/qcom-spmi-pmic.c:104 qcom_pmic_get() error: uninitialized symbol 'other_usid'.

vim +/other_usid +104 drivers/mfd/qcom-spmi-pmic.c

0e7c7a6e235e61 Caleb Connolly 2022-02-16   72  const struct qcom_spmi_pmic *qcom_pmic_get(struct device *dev)
0e7c7a6e235e61 Caleb Connolly 2022-02-16   73  {
0e7c7a6e235e61 Caleb Connolly 2022-02-16   74  	struct spmi_device *sdev;
0e7c7a6e235e61 Caleb Connolly 2022-02-16   75  	struct device_node *spmi_bus;
0e7c7a6e235e61 Caleb Connolly 2022-02-16   76  	struct device_node *other_usid;
0e7c7a6e235e61 Caleb Connolly 2022-02-16   77  	int function_parent_usid, ret;
0e7c7a6e235e61 Caleb Connolly 2022-02-16   78  	u32 reg[2];
0e7c7a6e235e61 Caleb Connolly 2022-02-16   79  
0e7c7a6e235e61 Caleb Connolly 2022-02-16   80  	if (!of_match_device(pmic_spmi_id_table, dev->parent))
0e7c7a6e235e61 Caleb Connolly 2022-02-16   81  		return ERR_PTR(-EINVAL);
0e7c7a6e235e61 Caleb Connolly 2022-02-16   82  
0e7c7a6e235e61 Caleb Connolly 2022-02-16   83  	sdev = to_spmi_device(dev->parent);
0e7c7a6e235e61 Caleb Connolly 2022-02-16   84  	if (!sdev)
0e7c7a6e235e61 Caleb Connolly 2022-02-16   85  		return ERR_PTR(-EINVAL);
0e7c7a6e235e61 Caleb Connolly 2022-02-16   86  
0e7c7a6e235e61 Caleb Connolly 2022-02-16   87  	/*
0e7c7a6e235e61 Caleb Connolly 2022-02-16   88  	 * Quick return if the function device is already in the right
0e7c7a6e235e61 Caleb Connolly 2022-02-16   89  	 * USID
0e7c7a6e235e61 Caleb Connolly 2022-02-16   90  	 */
0e7c7a6e235e61 Caleb Connolly 2022-02-16   91  	if (sdev->usid % 2 == 0)
0e7c7a6e235e61 Caleb Connolly 2022-02-16   92  		return spmi_device_get_drvdata(sdev);
0e7c7a6e235e61 Caleb Connolly 2022-02-16   93  
0e7c7a6e235e61 Caleb Connolly 2022-02-16   94  	function_parent_usid = sdev->usid;
0e7c7a6e235e61 Caleb Connolly 2022-02-16   95  
0e7c7a6e235e61 Caleb Connolly 2022-02-16   96  	/*
0e7c7a6e235e61 Caleb Connolly 2022-02-16   97  	 * Walk through the list of PMICs until we find the sibling USID.
0e7c7a6e235e61 Caleb Connolly 2022-02-16   98  	 * The goal is the find to previous sibling. Assuming there is no
0e7c7a6e235e61 Caleb Connolly 2022-02-16   99  	 * PMIC with more than 2 USIDs. We know that function_parent_usid
0e7c7a6e235e61 Caleb Connolly 2022-02-16  100  	 * is one greater than the base USID.
0e7c7a6e235e61 Caleb Connolly 2022-02-16  101  	 */
0e7c7a6e235e61 Caleb Connolly 2022-02-16  102  	spmi_bus = of_get_parent(sdev->dev.parent->of_node);
0e7c7a6e235e61 Caleb Connolly 2022-02-16  103  	do {
0e7c7a6e235e61 Caleb Connolly 2022-02-16 @104  		other_usid = of_get_next_child(spmi_bus, other_usid);
                                                                                                 ^^^^^^^^^^
Uninitialized.

0e7c7a6e235e61 Caleb Connolly 2022-02-16  105  		ret = of_property_read_u32_array(other_usid, "reg", reg, 2);
0e7c7a6e235e61 Caleb Connolly 2022-02-16  106  		if (ret)
0e7c7a6e235e61 Caleb Connolly 2022-02-16  107  			return ERR_PTR(ret);
0e7c7a6e235e61 Caleb Connolly 2022-02-16  108  		sdev = spmi_device_from_of(other_usid);
0e7c7a6e235e61 Caleb Connolly 2022-02-16  109  		if (sdev == NULL) {
0e7c7a6e235e61 Caleb Connolly 2022-02-16  110  			/*
0e7c7a6e235e61 Caleb Connolly 2022-02-16  111  			 * If the base USID for this PMIC hasn't probed yet
0e7c7a6e235e61 Caleb Connolly 2022-02-16  112  			 * but the secondary USID has, then we need to defer
0e7c7a6e235e61 Caleb Connolly 2022-02-16  113  			 * the function driver so that it will attempt to
0e7c7a6e235e61 Caleb Connolly 2022-02-16  114  			 * probe again when the base USID is ready.
0e7c7a6e235e61 Caleb Connolly 2022-02-16  115  			 */
0e7c7a6e235e61 Caleb Connolly 2022-02-16  116  			if (reg[0] == function_parent_usid - 1)
0e7c7a6e235e61 Caleb Connolly 2022-02-16  117  				return ERR_PTR(-EPROBE_DEFER);
0e7c7a6e235e61 Caleb Connolly 2022-02-16  118  
0e7c7a6e235e61 Caleb Connolly 2022-02-16  119  			continue;
0e7c7a6e235e61 Caleb Connolly 2022-02-16  120  		}
0e7c7a6e235e61 Caleb Connolly 2022-02-16  121  
0e7c7a6e235e61 Caleb Connolly 2022-02-16  122  		if (reg[0] == function_parent_usid - 1)
0e7c7a6e235e61 Caleb Connolly 2022-02-16  123  			return spmi_device_get_drvdata(sdev);
0e7c7a6e235e61 Caleb Connolly 2022-02-16  124  	} while (other_usid->sibling);
0e7c7a6e235e61 Caleb Connolly 2022-02-16  125  
0e7c7a6e235e61 Caleb Connolly 2022-02-16  126  	return ERR_PTR(-ENODATA);
0e7c7a6e235e61 Caleb Connolly 2022-02-16  127  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

