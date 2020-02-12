Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF615AEE8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 18:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLRlY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 12:41:24 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:52762 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727548AbgBLRlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 12:41:23 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHKwnY003955;
        Wed, 12 Feb 2020 09:41:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=uwM2Uo4f+8hMl3XDl9A1AOaH0DZAuv5Qo/R2efzX4uI=;
 b=UAUVpGgkAoYSjRNZARznQTeHtTWXLKBV91+tJ1B9MleL5YrTNXJJQlo0T5Edub8JxTj8
 xT8yRlHD0ghtN+0QCqXOWqINDUUKho7HGyVwiRWtM9iV9ZyShZcHSv3hLc9C/oTA28W5
 1/qyo66I7OHHmOkghoE08NK44F/EqNoWlxCU3nsmMIi0ffQuRP3H5PnoDGPWaMYFmW64
 5dRYB3zMkx1CwsF/qeQcEsNnr/sjqmzFwIHeCZCYvf63q969b9qKelvRYZaLkBhMWmKe
 k7vrg+gU9zqrcvBtv15mSUqs4An+vajfJ0O93BDuY4+u8oHmDgP9G2J4JG0nPUGOQDcC LA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00328301.pphosted.com with ESMTP id 2y3urf9rvk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 09:41:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njgI5Y2F3Jv6ZIJEXwEGuwx2kLSsF4fshMoSGk8fElxF2D1p8sKzoe5sjBEYxUNv+ol2r1W3nD/AK74XRFI5C4dEK8q19rHbtlSvRU7Qack3ohyqiSFvFtoxJznQBwl2XpIVyVtFOkAH3XR5nxIGVJsqAYGfSqXBXrLAdTEvRKJjIhBUkXIspKbVuC6wjx/5vziUn9Md22pf2Zdlpf+TDQm+xcqYv8PyCa6AdVHUWtscKIEIUJiGkRCtvteDF2xNcPel9m+cBY1y19yA/7mAXB2+5Sva3Z6KiJQUqssQam0Pmxt7OjNJDa956e2tqZUauXz9KDJFM93AhJk8nmNliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwM2Uo4f+8hMl3XDl9A1AOaH0DZAuv5Qo/R2efzX4uI=;
 b=KCvx2RNd/bQUwTQa/xXYlGjrn3AFWz6FV+hGkG2DXMDsOVuiu7dF3yyw7spodhmo133+6/cSh9cPggJInAqpnnQ6nBrze+LfI8IW0uvMUk4XDT2JgDX9TzwZbtr7znX25PW8hRu+zDo8AvOucjh1YPhf74xh5B5A+eFBJTA+P2UP0d8426Fy+ynVZpySTwN4n753XEnymtIo4nivpotoT7BQxN3zl9c9udOTlpCG+Bx/oy9LzcBUjcoK0cLgD65/8eadUB93j6rSF5MNU7dvAOHeFbC80nuuMxFHqylknCdCIyiJ64kCiIH3vbRMhbSdSaT8hWQ2rgWyAoC1yiSBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwM2Uo4f+8hMl3XDl9A1AOaH0DZAuv5Qo/R2efzX4uI=;
 b=GNDfh9hOt6JujcDOZQlgnjT/5+rcta+t62q+ZqpW0Xm7R8PWMt2lu92qYrsNekms4wAtIFkpC0NmaN2NL/D8DlRTbG4imHLpYzlDOVWQhnyqgIfRL16TPqGoFsp6gRjUrSzgR+QhzLNdqtreoE4XCHkGjl67rJM9wKIMbbH5g5w=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3925.namprd12.prod.outlook.com (52.132.231.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 12 Feb 2020 17:41:19 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:41:19 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 02/13] iio: imu: inv_mpu6050: delete useless check
Date:   Wed, 12 Feb 2020 18:40:37 +0100
Message-Id: <20200212174048.1034-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212174048.1034-1-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Wed, 12 Feb 2020 17:41:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 070ffabc-a741-4da5-4ba8-08d7afe2c4bd
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925B4C9594232EEC779AAD7C41B0@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(26005)(36756003)(478600001)(66946007)(4326008)(186003)(66476007)(66556008)(107886003)(5660300002)(16526019)(52116002)(7696005)(956004)(8936002)(2906002)(86362001)(316002)(81166006)(2616005)(81156014)(8676002)(1076003)(6486002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3925;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JH1ySr5DXitQSJp/RztMf9Z7SOGnie8Bv/waCoq4RLsEqgA6WwZ4ckcQXlYCjPA72U7tIO+WcVjZfGJt4lQoUH9k2eQRTEaTX6LeRYaflP6SMRUvF4tNse4xwIEqwIgxPTiCcxcgwyAyS63Tj91tEuHNrJbVtj/WYOJhb114oJDl7h1l0QWLg/v41Jc1E6T/1wUscptCyjlHv8G3nA/qd8QFt2VSAOGVRsZkfiWVQqminH0TFv/l1vUISGUhLe7sTHvRZE+cym6ksVLhuWHOq3SATl95pq8qXH5t06SDwO0PEQJ5MlqqjjlZNaQrECMobkpS49Kuy4UYLAqV5z5lVgka+HBIJ4v7fUHHO+cTRH6adROizYdoCiWN7VI0LvMWyL+wq7P5hu5lxgApEkdIBxVJZM3Fg1CtN6LGHxAYaSxP2RMeYYEMh/BoD7yeA54
X-MS-Exchange-AntiSpam-MessageData: bngT6UrDAUyYkhctrCtOqFuNqol5jDF3E7mkSfWomUuWUWaHctWTKN8ElmKCA6I99lsZysfeKTdbdzuzO4Hc2oZxXM478I382XAol/Y/piFCItbzD168dONPUZeqBhffhrnL+OhSc2qGYAt+hQfAzg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070ffabc-a741-4da5-4ba8-08d7afe2c4bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:41:19.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGLbML/YVb9cF4tiRP35ubBIBLyud9v74x9ZdaCkg0Tn9kXGGmGo3uv1WLw279lHlFmaHjGU98GnBfHS90xorjMd2jKnhFrPg/cWXxOkFXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=826
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If we are here it means we have fifo enabled for 1 sensor
at least. And interrupt is always required for using trigger.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index f9fdf4302a91..d7397705974e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -123,14 +123,11 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 		goto reset_fifo_fail;
 
 	/* enable interrupt */
-	if (st->chip_config.accl_fifo_enable ||
-	    st->chip_config.gyro_fifo_enable ||
-	    st->chip_config.magn_fifo_enable) {
-		result = regmap_write(st->map, st->reg->int_enable,
-				      INV_MPU6050_BIT_DATA_RDY_EN);
-		if (result)
-			return result;
-	}
+	result = regmap_write(st->map, st->reg->int_enable,
+			      INV_MPU6050_BIT_DATA_RDY_EN);
+	if (result)
+		return result;
+
 	/* enable FIFO reading */
 	d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_EN;
 	result = regmap_write(st->map, st->reg->user_ctrl, d);
-- 
2.17.1

