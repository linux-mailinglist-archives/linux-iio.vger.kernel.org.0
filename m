Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2115FC7C2
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJLOvs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJLOvr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 10:51:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA1AE070D;
        Wed, 12 Oct 2022 07:51:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CE3tJH020023;
        Wed, 12 Oct 2022 14:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=j24UsUcIGEj+le290AOYB0hncqHci+GUo1e7PP6frJg=;
 b=o7bkCYo2ks3rWgtegHNe1RPRpGM9Z0U0JNIDG7vRNPQc8/aSuTSLDbfhYpnzpKH9YaFl
 RFvI8bhuxkEsDyoJgcokcNQohL9gcYC2ZA4UiqICxG4cBA5sEdjcqZKlV5GZs2eJqsDr
 MGAaJJD0EE63Fu44TCok1mFEW6aY3v22UhE40g/hjS8K0OK49PSjwBG9YhZgQPnFxN1Q
 OmtgQSIcJ7cgnQ0n4Y17T1+pc61h1iw/L3mbIBp8kQL4Gfulxrw13269KBDDAVqcuin3
 HlOdXuCTcT2yQ8hefgE4qRDHt6WuCzSVUnG41kcOV9XZ3t4pOzkgl4yPN2H2vBE5uXLz Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2ymd1whq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 14:51:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CEM36B027589;
        Wed, 12 Oct 2022 14:51:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynb997a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 14:51:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCxp20rSo3snur1KcUmZ5/wgLF/8Jlztx0BstlF1HFmmIswxcJIe/mi6dmwscVkrJh2H2LqmTbNWCLhXxTMS5lxYyQy23me/wXedWylACSDnyEcDMppcwmZ/rmm1AKjF8ZMKHj54hMr/I01e6f+DqKQzSrWxMZYlSub47Jgkt2qs7HdbvpDPtmcbQWwxZFvq4MnfrXHTFZP1jwcEJckM97B0Mq9lAnWGJFaqWpqbKPS1J7GQXkc8djIcG6aAHm5jB7Rg0IWWsuU+UiNrgATSJi7EYSZQJDtWbOD+XdF/NlH7QHSLyFUm9Fe5iKZPjrpl1S5UfoxI/2zDjH8QDFJODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j24UsUcIGEj+le290AOYB0hncqHci+GUo1e7PP6frJg=;
 b=IMqVSMwuHHrqrzmOXrvEngNNtLaEaC8z7Oit0dovPHR3OZh4H8hYnfzfWfF2yDvOWvgASnEx8h7LpPeX0j9UOBq5PUWT4ACwXigjcnLsxigen8BzU56bNqsxasSOTfGILvc2B6tlgiJs6Yxsf6EX6BUul4ULY5VONmIr8KKZdjzAX2Po+vMaHExbpoK/OF9uhb05UIBrdefe4YvR6HQfHADTbb5soQEhYbsUlLwtRsygkKy8aLF5NJIIOx2zAAhngOzxfL4BjVxNBSlMnAFkYFEtHrLficdeWERykmEckhzTfzp4zm01iownxihKZt7EvWkNKZVaPy8O8WjGPQGKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j24UsUcIGEj+le290AOYB0hncqHci+GUo1e7PP6frJg=;
 b=bg3pSZaHei32cAEaA8rp68RY+Te1SGUK/wBcnFVgi10nDuInlLgZV36bdp0x9Q1a2+zbzIzC6aAu/Sriy9UWQ8QHgVa5W2OuxxgSO8TJGz6nwZbct7BQygV35P9v1WeSmVK1G16pt65y6sPBEs7Y6AQqs2CsOHtYoAFQv0Cwvhg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5581.namprd10.prod.outlook.com
 (2603:10b6:a03:3d7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 14:51:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 12 Oct 2022
 14:51:34 +0000
Date:   Wed, 12 Oct 2022 17:51:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] counter: ti-ecap-capture: fix IS_ERR() vs NULL check
Message-ID: <Y0bUbZvfDJHBG9C6@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SJ0PR10MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: 54eae71a-0a9b-4e0b-4095-08daac6141c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMZiWI05J6vgfA2j3B59Vb4xo6bRNcQdx0dZtMDs8s4E86UfjMlk8sbOp8lNMpbbb7/zsEPNT995oGh8i9+2msutc5TaN/zPb8tKMOKDeSeiev4Qn15+wU5GUGmCOz8U6i8a3xoCt4IHelPymGWmmzt6ep8lBIaiSYYdZziYe8mnY6Lux8G/I9ylqPO637kMqI/B5upiTTilS/TIBMABO09PVn0OPTKhkCuO4Ihq0dC7XBw9nlwi3w/IzTyMMmqCi6wPmV3dWZrQIZ0nEZl6Z6He28fQsLSCNNKqziGjtnbRZSLRsWR48SY1LMNQIe8mhIU1Ne5l2OtT8KjnzXzHdnwscVcAxm/QIewrIN691wUpnw/ZExtDbrPGfuTDLYTWkIrmwfPUBu0y8OHfellWo1H0jjw/JGAFwC3MCGXEBwKfFJ6Y96ziJNLvazln6O+OnhyIBCNhowRbFMCSLhgTumTpBnUZO6oca+LFitJKvpYAXV08pXUZad+7fpmivhFIb3LBPAPSgQRH2MrCV+2LbR8l0/QyrmNatDW4YgXeo3Xm/MGrGWxZIRmxs0Ucercd7T0i9R1a/r/vzOGiWJILJA6iKEaDoio4hqq8dTxn8KShiQuaxcdR3Qbxbbn18To6Fqj9MN1gmKt5ZJOZ8lINkV4UpUApgGLl2ibWOgIMvDDgw8LtGcCcGveKVxjFoZ0dhynJQse7Wxodzs1h8UZ5IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(316002)(33716001)(54906003)(6486002)(110136005)(478600001)(83380400001)(186003)(5660300002)(38100700002)(41300700001)(86362001)(66476007)(6666004)(66946007)(6506007)(2906002)(6512007)(8936002)(9686003)(26005)(44832011)(4326008)(4744005)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VbRBk7wCt0ZQ4y9Y+2uwozuDzWw+kHUPu0AIz4YaYQHjIFWa0y0zulMRYRe?=
 =?us-ascii?Q?Bcdkiv4GAi0dNxbzyC1vWu9rJe/RI/FRCdCsZ6J4XJCWczYecxne7wXJqZvU?=
 =?us-ascii?Q?8kJ3Pgp+dspXD7+NRDvektTJcgwTaOYWISumpbh84CHG7BZH4vRw3JrlS3Yv?=
 =?us-ascii?Q?duhXqqBm1w1GH8pe/Ic3Ax5ysj+NmKzv6xsXdNNQ7TomOqs/uVShip96Lhbl?=
 =?us-ascii?Q?VemcWJs0/mjfazhHPvmqW8RYzor/Nl/owY5wD5Oe7a/OLlHDZIbFDO/sZxSZ?=
 =?us-ascii?Q?kyZNNHnGgdXomCKRB0DzWPojBIIS+1HoDUxopQn2DYGz1jvr3OdynS3FvEaY?=
 =?us-ascii?Q?63uaj9BSawL+AqDeBlV9wxft0XrCcj43C52C6huN4yvkfuE7yVYwfjgP//7G?=
 =?us-ascii?Q?1k2qH365HSOwofW0nleSUomEWNrnv+7QQ9e5xEYkjQPB1jesHfn7jZ1Q1eyj?=
 =?us-ascii?Q?RA9cVaXZxRV12OkqwYIZrMQGIoAZzpSk7rRRnFk6f50jAeik0UM9NI+jovNj?=
 =?us-ascii?Q?XyrbrhWSkEN00TSPCp8YVkaVWCtWh9A2ZB5PuosDg8MS6fHT94mzSUGq2x1d?=
 =?us-ascii?Q?0vjixESAhsmtxkLz7Ui9RboZOXHgihXceskrrMJX8QwUcnN+ESAeoLkXwRjw?=
 =?us-ascii?Q?0drw/0GaxGnPh/9O02NwR6surTFYptpcvyng+L/8yaX7ICSHRxQib6OFDTok?=
 =?us-ascii?Q?6+AGvUHqCQDeTgPM3VZMAsiL3M1a+jvnvXzr1o+rwlGJy+UFnibtBo4pejd/?=
 =?us-ascii?Q?bWBKc9o9J+E0Pdky/2lNJV3FmMtWBbCw/cEqqM1SBkUJqMHfcTN3CpJzMuCw?=
 =?us-ascii?Q?K/WkpL51pQDBgXP4PGkzI08wu5Jp2DlyqpEAXbwOZ1XvIQ8z5w68Gdlz6lLv?=
 =?us-ascii?Q?BynRtPo2UE2vti9sqDwdSC72a/FOOhR2QELIizBJ1emf1NLsEtZDOD7WTFis?=
 =?us-ascii?Q?2niPpT1U3fPEgDJVNW0aYinhUiP13KyRA323AyulvFkvE7G/lWM/8KvgbEH0?=
 =?us-ascii?Q?+uJwjovz/Z9GAI0e1qJhrPtf07yDyxfhuaQ3rLBdGrUdkQLyfqb5F9rwuKo5?=
 =?us-ascii?Q?uQyBhp86hN5BILy3F0EqXbbMz6KpFQ7Kjae4KUXxfPTWv1EICL4fjTaaLzFx?=
 =?us-ascii?Q?US509tbJ5sbtA+FZkQR5RxUGpB6ybv+HxLN6o5ipNhJszvzwYAWLW3UVCeO1?=
 =?us-ascii?Q?VEytlS9idU+f/zVZczZjMwiVpvsuY3A1gN9dCu4uuMZJfGqUKgjLQHXXvOV+?=
 =?us-ascii?Q?Fpt+tyV7Ae42MC9cmeOCaAD44iPzYodZHwb5tIz9ppi55o+LT7hZdFHuRJEc?=
 =?us-ascii?Q?bG4ss4hUqdJPjN16OTKDMZd8qBwAGPSkOQNeS+9WE48PmxqLTGQElEBCSBiO?=
 =?us-ascii?Q?LrMO5EgSi+KRF8R/NpQNVyUnZU82K8Cq8rn8vrusFYIKVxKbaT4CZSEV7p8g?=
 =?us-ascii?Q?Vr3jXl42tZVBM+VTLdJjvCfMTZxUdHdj1yBOG0JTuo51KlKICDQjwJ5mSLdY?=
 =?us-ascii?Q?Zu9QbF1wz0vZwD/SxC+Zuyv8UBAC8zKwEduagRocuEnm9QwzBuRefow0nDrN?=
 =?us-ascii?Q?uy0CRiN9Vy8oEeMQvB4AmevNIUbqKb39JdCJxFv5RNM9KlHXXbxMRjzCBDzO?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eae71a-0a9b-4e0b-4095-08daac6141c3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 14:51:34.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+gh4dpNSnAa2TkUiqV8Vd+lre1uu17rgRc6ZkAil0rjM01/yDha/R52ryFy9U2PdWbsR0zvTFjpJxpiIsWaazFUgjoOX0JBiBqeSncAsvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120097
X-Proofpoint-GUID: OZnx0tKw5soApXyXG5htI6sEStMzPhQW
X-Proofpoint-ORIG-GUID: OZnx0tKw5soApXyXG5htI6sEStMzPhQW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The devm_counter_alloc() function returns NULL on error.  It doesn't
return error pointers.

Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support for ECAP")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/counter/ti-ecap-capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index af10de30aba5..8104d02bb5a4 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -479,8 +479,8 @@ static int ecap_cnt_probe(struct platform_device *pdev)
 	int ret;
 
 	counter_dev = devm_counter_alloc(dev, sizeof(*ecap_dev));
-	if (IS_ERR(counter_dev))
-		return PTR_ERR(counter_dev);
+	if (!counter_dev)
+		return -ENOMEM;
 
 	counter_dev->name = ECAP_DRV_NAME;
 	counter_dev->parent = dev;
-- 
2.35.1

