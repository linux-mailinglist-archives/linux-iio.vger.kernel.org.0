Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91844C2EDB
	for <lists+linux-iio@lfdr.de>; Thu, 24 Feb 2022 16:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiBXPDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Feb 2022 10:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiBXPDe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2022 10:03:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D12413CA21;
        Thu, 24 Feb 2022 07:03:05 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OCYKsK000960;
        Thu, 24 Feb 2022 15:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+QAOFon3Yt114UmL3xnJ+7BZ7fdSNSSRHROUVDL3bHQ=;
 b=Vcmomq2NJTm2l1JNQdHjuzK5VC+gZaRm0FSnGGCWbwDQU5xRWbQqBEl9GX4gZYseQJKA
 fAKED/1lt1xBjbd4D86Qkdmx98KzsZS7ZTdwsG5gvmaEZDw7R2Sii2szshHJQKXzJwQr
 O1w5lh3tnLNmh+LLwpmPPYF5VGc5nI6wtaPLIHU94eGnrtPgi5jGjA6EHpECj+cHXNau
 tiKfKWrc50xW+rXdlz5Lk0q56IFRyXwn4n5ZlOsPtthw7gA8YDZFGaphmJXfV/eD6v7m
 nhUOUxzYM3mSGbM+iv5NbpfNEKiBXNxdnwkfrWK0mdBVNkvX1AV+CNtrs5XHw5yjovqJ 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7aqn1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:02:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OF1faf180447;
        Thu, 24 Feb 2022 15:02:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3eannxk2ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsWT5x4nUKb3wWP8X2cDvlsOV093Auj0vkr5qe66/hufBo9pL4Tx/56nWXRx10WvoZmw22ANYpUVU6RbSuFsO94C5Gv5l7jHI7dl5zPOroRHwZh+ejCH3Ys141m3T9YlF3IaOsdACtIa9fO6eNj4V/vpORZuUKNIxF8r5GVhA98aJW9FApqFM/tW3L/OrAuVCaHoG7M9akk8ZGWTfH7P0TAS/Ag7exz1Sjejvgkkzb7iyE3FDwY8SJd9snjy3KrA+YWjG8Z8LvbswnjYTOoPlfQvcRhR3/Gmv3kLw5SzVUS/kIkhU3kI4SVgf0xHhMRk8oQglP+KVc2ma2wBPmgEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QAOFon3Yt114UmL3xnJ+7BZ7fdSNSSRHROUVDL3bHQ=;
 b=FqRtV4RfEn7N0wjhJs2uRx4d7UlVohwH4ukGYshdtydykVkOMHCivFRlCI5XvpLJI5Lr401mcFgkZXEmA26eX5UmI0UHuDvm7FU4UwdGsURa9w317M0gjQVNoNRujSGWI73G5ps2xHAVetGjWarL/REkS3lC3b1E9NaBPH19TqFQYD6PsdcSHJGw+VGzDkyFH01YlBW+et48fiYXYa36mwHTCu+0d7FohHIKiAXw/cWLsWR7Ij/HznkVnofgpjOcL/KJbu215Y5um+T3X0T8AsCBlJY6sTwXwLWmfg0n64GVlzZeN+t7GIrEIqyyeFzf7KjltUIZo4BnyJRrNv3T/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QAOFon3Yt114UmL3xnJ+7BZ7fdSNSSRHROUVDL3bHQ=;
 b=Sl5d3QD7okctBdLjHNe04kaqY7z5cmu/a4MSIHxoJdSMPx2OzCS05zMSYFnl0pDtC0BeRdfck7J2cx/xx5++2ButPnIJ9yhQKnBwe4R8JEy/sVlQ1J8T4YD15vVj+HLJpF1Q0szSnZZN5jWpT3B3tYWg8nwONISk1l6lanbMxAY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3790.namprd10.prod.outlook.com
 (2603:10b6:208:1b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 15:02:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 15:02:39 +0000
Date:   Thu, 24 Feb 2022 18:02:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: accel: adxl367: unlock on error in
 adxl367_buffer_predisable()
Message-ID: <20220224150228.GB6856@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8dea87e-ab32-49a5-4570-08d9f7a6b364
X-MS-TrafficTypeDiagnostic: MN2PR10MB3790:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB379024EB3BF09EAAC0E4B52A8E3D9@MN2PR10MB3790.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PzoJv1r7mTLNnNAeNXXIijY6umgHXstSWTK3xhlEaN3BlmWU54jjpFmVn34t/1eulR0xZ9mRNUKp+Gy8j3piHEDIUQgM4jeDRTR88XtVwms6fv4XLrdMkpuVCGTaNRLEh3aGb07TC6K2+RfX9dREWgbrMjAQUijjRD0vOO5ZML9RmhGPdngWHnHQqneLbMnVF2sYHS9aXqADKlQdnBEsfd+ucOWjnc4/RCp8tWTYehwnveZcMM2HNrpZxvAt14mEvO5BsvC00EqUV8nM9CWwx5SgzOHyqHxbqXD1tKpDgoIoiA+kn6H3UraL0jXYBWHFPXA85/DOtyoqzbUMhYbxmNhXsDaWthdNZd9J495Y/DCpzBPzOdQeszMHRaUVRB/36SbnCA8+JgTkO/+XJTyf5c3qK8Etg52PDmlP9mr8+OeCOp/lkKZQrgLU8Oz/uHm4U6/PzqWjjaljfnZnUonwAk74zeLbKZmdwrrTE1++6C0Xr6O7Fxb7tILrbd5gezt9HRwjOYo8LIIxwgO/An7PjVNFBcUvdNa0Fw4BobmcXPzM9vOX+VBIZ/Qy5PzKT1B/hGpne4eipOZegtZMH1/s+mVM6O0HQIMImGFbGnQwZqMTeSQqz9p8hqdL85Uy7uW45GAOZJgkFchnb6nXpx4vbMtq45GwD9AJ0kHQMl8P0tqNdY/HeLCxvZQY0m0X+qlLOgkQp3dfRWqCSGqr9B6DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(2906002)(316002)(8936002)(52116002)(1076003)(508600001)(110136005)(54906003)(83380400001)(6486002)(4326008)(8676002)(9686003)(33716001)(6512007)(26005)(186003)(33656002)(5660300002)(44832011)(6506007)(38350700002)(66946007)(66556008)(66476007)(4744005)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hbcqUct6WKSM7tQSrG6i0KYWom/TFkOED0QPok0h+za+E92uzyOc9LtFVpi1?=
 =?us-ascii?Q?YzKgBwRUpooE+Ms6bH4sd2HY8gGP/ZYEGV9tbU2gZBLvbjWeKfCBasdWAxvC?=
 =?us-ascii?Q?wxmeB6Q62ua+VozjYIobig9y4Z1kykjI0kJevgIgwMEAUD6an3vLNGb2X0U6?=
 =?us-ascii?Q?sMOfUpt1uA09nW5gXZrTvJ0a3IhWODYeXL3At3xlwYn8eBPX4H+L7vZP3V5b?=
 =?us-ascii?Q?4/NRZoSwF1BBVVUgTKpXyWZqhMzUUD0j7in/mYDrsYHtmfTunGVS2AzmcVJP?=
 =?us-ascii?Q?LirpHkAWu2DE9NbrKT7l/lx5x3o/CpFr9IzKOlxqolML0ERQLxf7PE5i3WeT?=
 =?us-ascii?Q?2jjEgdm5UTxdXtNFuR0AnYikgU+zrhpqak94oRuHU9uVFzVkfPeROunHYz/l?=
 =?us-ascii?Q?Mie4ZulqgBJ/M18W6VmzKpZNd/+591PNRlTRuFaZPXryMcEMA0K+8eOaRpq+?=
 =?us-ascii?Q?s6U3hWAM4O+CtBjULhhhdVHU+EznI1jZQFsa8ojah7cNewtN3g6reKQY9FDm?=
 =?us-ascii?Q?C3Sd8mwifrdvOLzCNyOiHZKtyB/prXoqd6R20WUgcCVK3Wbi8MhC780tChD3?=
 =?us-ascii?Q?hbAgsBy6NJLsDehLK+Iq+uuhQSbSBffelEFDGvTZS5I8hOFxBupKLLWF/Y++?=
 =?us-ascii?Q?chXOcpaHaQYqWxSGMFpuZBg6tvCRBnY9OGpofe1B7MhR+rG3cFdpidqlWl9C?=
 =?us-ascii?Q?b9dOkh5VTFfEJjrmX4JyapUS5gC+WCqy/nD2mxiZo/SpyQhFn1ZFdevv+wA0?=
 =?us-ascii?Q?0fSoVBuo2PozTxQOaNuFrGGj4P/HqSA3SeKTnQNBcqk857e6hmA5/m0KLrZe?=
 =?us-ascii?Q?gX6G9DzEu+Qq1oeJoqNuUMNo76C6o2g1N3XUWBhxrCaTEBWG7Ydf43m0tZtq?=
 =?us-ascii?Q?a+qk3ZyVWS+P5DOK9M3H1Y/N7id1oqjmOrTxMhAWVAEyYYKh68dcrHSLLdd6?=
 =?us-ascii?Q?m07UJ5ZuhymDf74FguF/SKwwQZoO+0Jy+ZokZlhm0EBzHplPgVZoWqwtSk1t?=
 =?us-ascii?Q?O8ab83cGkFwoYOncFZZNtzJwJkwThIFbkxkfvxGhWQpcxeR3ZMkmMk0gWbNx?=
 =?us-ascii?Q?iR/aiN92Tyjefkbum5CzU5FEolfn3eCQMiIScmi3lmUXEc/ptYwOZQFFGoit?=
 =?us-ascii?Q?EJFHVCe9FdQnzi79IQJ6HxydHLXp3bOkMTLyUZNP2iKC27IjcohbCvA5q1/M?=
 =?us-ascii?Q?u0Ay/WQv1OPkoo1nj/8MYi+NRhCwPAvZw3QxdG5qnIVuLoo/zg4K0eqElDwj?=
 =?us-ascii?Q?EiFxmDO//LgLH8XXKUEKsAcVpP6TuNEJ9CaCZZY06YD2BgAsYCkoSgCCkior?=
 =?us-ascii?Q?r/ktYQkTVPSbVj4nzxljPNbBUG7EYnQLVk4CC1iuiV2TVc29Xp2CZcjB9t0i?=
 =?us-ascii?Q?Al3tSUeNTHevCRjdGyvnf/BASrT0aDxKT4KAcwg+8AIT/bi1vQYQSFOqeJyt?=
 =?us-ascii?Q?zlHqZKxG8OMc/2+3xwx6vRMVKkyw0E2iHMwWiOM4GDA8SwIzIHQOqHSAA1DP?=
 =?us-ascii?Q?21xe+wDnQyTJ15TzJkDrX+0ugLzF9TA+ZFE5e0nom422XT9QCQCVG3ERRSdo?=
 =?us-ascii?Q?OYtXeN0rZ4zVoU7+Ioa0gt+XheeXKTHn/GNlpgCiS2+EZi+cM03ZpfcC01AB?=
 =?us-ascii?Q?xb3TeKbyYZF25BsgHYAxc01OsViKU8zDsC6jTDgCtRFF0QNMDLaqjP/hIrSD?=
 =?us-ascii?Q?4WDZRQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dea87e-ab32-49a5-4570-08d9f7a6b364
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:02:39.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLSUjYjMO6OQsIkHUhhEe3cBVudebsbPGViOiDOYW1pqc9FKltFAv1FsmSDC2zMdxokEDuJ9/Lqj9tyKHXliFo9rpBoemBVJzjHcuxsZoaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240090
X-Proofpoint-GUID: 2FL62C3kfTaN1gOgt7CZ-VY6FpGTZ9G6
X-Proofpoint-ORIG-GUID: 2FL62C3kfTaN1gOgt7CZ-VY6FpGTZ9G6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This error path needs to call the mutex_unlock(&st->lock) before
returning.

Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/accel/adxl367.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index b452d74b1d4d..bdc95409abed 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1359,7 +1359,7 @@ static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
 
 	ret = adxl367_set_measure_en(st, true);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = adxl367_set_temp_adc_mask_en(st, indio_dev->active_scan_mask,
 					   false);
-- 
2.20.1

