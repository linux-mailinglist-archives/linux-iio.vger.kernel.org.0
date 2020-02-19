Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FA16473B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBSOk6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:40:58 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:8006 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgBSOk6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:40:58 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEdvML017413;
        Wed, 19 Feb 2020 06:40:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=qxUlRkH1AH40ywDEC6scD2Q7UYYGY/mICPPAw/oBUiA=;
 b=baUeUK7lxPR9cKvo8rP4LBMzQKQxseuV/wr+y82ICKBB3J1rTDCFjxp4R/anxB7jX6EJ
 4ZiwtnwnIGm0YJw+bcEYfNLqKmemp4vPFFxsTg6nrdeGq0Dp/wJAHNvBr1LBEpKsEA6/
 Zl5m7FUKqsiGN6LxbekbyUjQ48DXZEDM7BpGrZJJ3RTsT4lSaLK3LbMioCNiOu6fdB+F
 2/TyJILXqjnvAoLBhg71nfLWFxfE4b/u+r+Vxixm7DbLqVZldzRsmtajzsDQ0pMqV5ou
 Ca2AeCVr8s8Bll40+y9Xy119JKe6JnGXtkIRtD1ardrXwoYhfv9zlWkgrChTUcbTRI9V iA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00328301.pphosted.com with ESMTP id 2y8uem892x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:40:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0YNrinrNFTYV8yGaGA4PmdONOhwZfcYx4VsAgXuFZfjmaQBmDB9amNtF9SNHTcK7LlxoPl4SxDNcOiwnaS4Omskq1l5+TfM8fCLedmUrpw3kSyCDp5bcjfLK9z9/YufV9kAyVDgpldkyQuzmmBxLkiecaApfx/l/ySG3atHp4WFbvsLOFswbN6/9oiwRx2RtsHmwVAO2mDbjRtH3yYa/ZCcqBQF62pQtxFqnhMvZiZA/tmR4BjW9ujBRk2nnPs4igQwLc0TZLPEXYDCry8JpJz86HvVeYGzqfnXsjcp/n5vQdx8DTHcJ5D9/zqq0Jet4zqvnGQImzMyUHcHu2d0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxUlRkH1AH40ywDEC6scD2Q7UYYGY/mICPPAw/oBUiA=;
 b=hIO0vWYahC33U120dqM3ftf+vFgDw8Dk0na2aS9lKopAngSirN1dHOZ/EXR2FQF1JWnSrbxF4ugcP7Fu90NlK4AAH7b03yTaw+NL5H7hjTcfmxNNAYC3GGrVVEjzU8pAZbKlk4R6Ntb3L+5fw2Sq+gQWqqllq7CvEfY3INgEJPlex+GiMACxL1nHbwz2SKLbOIBDWkyn27sbJUbFhroiZqvpB3bRc4GutEJBJjZDOieSqszw6nPFRf8RCSkGeWuc/So0B8RULUV0It3OitZsdE4Nnl3CyJxY2hoK7EabN+eKRTJ+Wd/tA5J7cEQGV2wRKJ1R/yWWbdWbktRpSCvjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxUlRkH1AH40ywDEC6scD2Q7UYYGY/mICPPAw/oBUiA=;
 b=TxSm/LuqT04cDcuGy8bLXbim3IuDhw2Z7fGHmpbrCScCIMPHeBT8/TkwOmXti7W10lN/UtIreEd6I3xOwpENUR1+Rvkqk4YbEdu9ZnyNrh+j5D4TTcZoornnIoQdKGnOodbyJ1MI1NK/qEc22aazjadGxP/jOWNN/L6hzWN6S4w=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4213.namprd12.prod.outlook.com (20.180.5.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:40:55 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:40:55 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 07/13] iio: imu: inv_mpu6050: fix sleep time when turning regulators on
Date:   Wed, 19 Feb 2020 15:39:52 +0100
Message-Id: <20200219143958.3548-8-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:40:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80fd47a1-10a2-47f4-211d-08d7b549b9c8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42137CB381C7C9674086340FC4100@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(199004)(2906002)(36756003)(16526019)(26005)(86362001)(107886003)(2616005)(66556008)(66476007)(4326008)(5660300002)(66946007)(81166006)(186003)(478600001)(81156014)(7696005)(8936002)(1076003)(8676002)(6486002)(52116002)(316002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4213;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baYkajMIwKRSVIrW35YrEyIr+Xi3ZIu0IV85DXil2yujs50h5yGwikihAYMyX6hu9tyJI+GtYCYAdj/yl16UA2sFSLKYCgiSst/O91El+hBltopsYneD5s9xPAqE1eiLTmwwQZdnlFkg1y1fJHx1yFhSJPrgEbdQ8lr+fhZExdbSxZhB2fniACpf0AMLt0nyvBy2NdaLyNYeO1I5gzCq1rMZ9sLB0EkZSn5e4mhqy+3svt3KuZq+dve9gQWlJ3TJ7YUKJeSaCYC5WoGXmFLkUyGyatjs0JXbU+Ujc53sL8B7JcpmXKCLQTdyNPKiZE3uyxxedrfNcs9fKkW9R3F//a0euFwEn+qtZeKF6+DZKejQz+9xj2Of0dN3WBSsoQiKzqMgdNyY7oyv0UfO53e+UiszJM1HlYos2d/iIMTdAc4Tr9T3fDn8MB9g1kK1+yz7
X-MS-Exchange-AntiSpam-MessageData: nULEUKBaBQBge2dC9TReqQ9tm3ekYGRqzDTygRxii0SxKdmgmR4kUlKpbcCdMHoEUZTZy7aQBsromUWLCspnsVeFdgwIw51dFi1QlsiKshklz6A0c5uM0XyqiYDl3CpePohRe7Z0Vi8ojB/I1JXdbA==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fd47a1-10a2-47f4-211d-08d7b549b9c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:40:55.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P95NuD7AKTHGHDTeeXaO/ubBltq6pGJKhxi3CmJxQ2SzYlskGP11f8Zn8LiA7GdWujghec+4y9+Ay/FlDm/5GVrLiSeTFRKzgUf8ItwQDkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=885 suspectscore=0
 adultscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Turning vdd regulator on requires a consequent sleep for the
chip to power on correctly.
Turning vddio regulator is much faster.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 3502b996671c..63cdde20df7e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1201,7 +1201,7 @@ static int inv_mpu_core_enable_regulator_vddio(struct inv_mpu6050_state *st)
 			"Failed to enable vddio regulator: %d\n", result);
 	} else {
 		/* Give the device a little bit of time to start up. */
-		usleep_range(35000, 70000);
+		usleep_range(3000, 5000);
 	}
 
 	return result;
@@ -1321,6 +1321,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		dev_err(dev, "Failed to enable vdd regulator: %d\n", result);
 		return result;
 	}
+	msleep(INV_MPU6050_POWER_UP_TIME);
 
 	result = inv_mpu_core_enable_regulator_vddio(st);
 	if (result) {
-- 
2.17.1

