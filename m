Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B458164736
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSOkh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:40:37 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:49324 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBSOkh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:40:37 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEdZT5016941;
        Wed, 19 Feb 2020 06:40:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=uwM2Uo4f+8hMl3XDl9A1AOaH0DZAuv5Qo/R2efzX4uI=;
 b=OR2lXFLzpTNzCXy4hCMWpsZHZqF3/hwMH6My/sZcEH1CB5kGNdoWHb9YcKIE05zzt0Eo
 yfjdTa3HQuS9XFMDoGooJNtcsBEnJdncoEXzAZrCl1DDAYAXbOV/dY8Yjg2yXbo0lnMn
 gcKfGzyMTPma+jReBywUNUUJj1cVj8yTwVULRmD1pzicxX+7B6lvv6WE0g2zrUfCMGT8
 IrqPJ4LQn0s4Pr7De48XU8n8c+4gLe8LmLoP3nXpT5HqesMzMZvlFY9JfT+mlw6gKShp
 zISYCihCcITQqZoCSXx81cQvwV1UV+Bw8FViLyS34y8PiO4fE8xsAFOLt+zxconwC+0Y eA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00328301.pphosted.com with ESMTP id 2y8uem892d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:40:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvAnuo4TzaoKCFKEcnT5/asrYQr5T74hYg6k+lnKBEaUcDgJbw/g+WJdMxGeIPOk8uXq652s3xwCeF6wPpdSTE4V3y2WfVfuQLEL6rxRjsIyt8a0GiHKELiPmsNZ88hQEKMaR5Hk3Wrg/XQZ2MV111rvbbZKzPmV3RzkXw7lgtKztYSwzpFr4hSqkdl4elxPRgPW9DcrRLv+DSVWzZEJ01cX+lpA2Z6lP+2Yt/lIbSfa/KSWyDHOs6UhH39E3ew1jMWR0AkW5DAvVpY+znZnves1fnFkrpwB+14otO32/KthVeQi+spRnFCh8enYTcXQRDjusYvMitvrom8C2W7QVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwM2Uo4f+8hMl3XDl9A1AOaH0DZAuv5Qo/R2efzX4uI=;
 b=POTh6l9nOs7zgKrvjv2s5wjSIV6NHhzf9fHCPUyWnY7aR1tnQ3xQxAnTLCGoG6luQlPv22fR1sFMKQKE9L1xnMariOfJaT1/oIBNUQCdp6AV1qI8vTyYHxgKP77/CfZg9yhgp1+9WUkVzGkUtxLXEnMoZ4RLe0qV/A9Nh1LYX+baiP25E5InW7jphHSjwU6dctgOoDZEN5CxfYPV4WKXDW8RqmmA/xNsUIxq2M3jRutPgdxleKNuBqmNSme2Rabklh/RGkHj/v0PrPW2nh1uM2RS45+JO1fpagTiGHmCf3nujINw89MKUzpXq3+tF+oFEbDrkYQPJtXkNWVkzEyQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwM2Uo4f+8hMl3XDl9A1AOaH0DZAuv5Qo/R2efzX4uI=;
 b=Y76h44GKsCdRakza4h+pEzOWIEPQr+EOLFjDpATONS9jlZAO7ZMjVljp0hV4JyIdIvLKhj6YsqtOgMNSIqzFm+IOzc6ZduFgtnnw8+0xT056KHUrQFAdLVZzs1Qi+IPX3QdzyfW2Wly9ahiSCgZCgRxsb4qgBVdDtnAPvJNULiE=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3878.namprd12.prod.outlook.com (52.132.245.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 14:40:35 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:40:35 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 02/13] iio: imu: inv_mpu6050: delete useless check
Date:   Wed, 19 Feb 2020 15:39:47 +0100
Message-Id: <20200219143958.3548-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:40:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7155a64-ebf2-4ca1-6d75-08d7b549adb5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3878859EEB0468DE11EB132EC4100@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39850400004)(136003)(366004)(189003)(199004)(2906002)(5660300002)(7696005)(36756003)(16526019)(6666004)(81166006)(26005)(956004)(2616005)(52116002)(186003)(1076003)(81156014)(8936002)(86362001)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(107886003)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3878;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsEoDLr1QK1+saYwLkbC7QjRCAlUJKxq6sEyMROMgEgzn1j3C3YmmisfbLrpRVvtGuuf82eVQOP6Syyj7Q682bMHs4AIQzisTvoWWI1AuWUkHbmlJQF80cFz9xDm8qoMSAwkCHsH65kT8bSzCZCM33eT0dXlsBUI8OwjEAdSkzyWykubviUSweIOzvaYuJQ//h5j7A7aZiaaHzlUviacy+e6ksH3jOScoO6NszGwTQ3htmH4fnM5zzh2m3nh4g7aiZEIpZIElv9n4b/kdMKGGlyOY5uVvSH0kFMnT7VreYgEk6RxZoaCL2DgO+otIXnhVScNUmhtJtVkcrldkcn8aR66Yue/oS2WGHUGDJwl4x7QF4R0+m16Vz5GgAMZDyfjdvRxiGghyDgpLAdCc9wh8RLk5QAJaNirFLjLq7Nbm8v3R85GfXtPQwbVewxQfd/a
X-MS-Exchange-AntiSpam-MessageData: Vk6ysr6Dz3YzHBpmgwk00nRSweFmKN/zAxNGt/Z9plEDGwPyd/Li1rML1WioyL8pK2F0f04hgq8P2SGK7ATJ8jhtoi0jGXWIRKoYqG1xm1rSkB+obH7V+TP9VgurwZ3p7n4JkgQIXW+u3PTEWKLRnQ==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7155a64-ebf2-4ca1-6d75-08d7b549adb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:40:35.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQ3z1htIHqntjN/Lh9uofbAZJmEzA9fKPmRYLBpKjc5I562j6mDO8YK1r01yro2rBmj5p+of4PaJy9COCepyjT6AiaRay2AZ33OpdtSsk38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=834 suspectscore=0
 adultscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190113
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

