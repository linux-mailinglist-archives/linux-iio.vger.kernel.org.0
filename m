Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F401E4DA9
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgE0S6Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:58:24 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:19064 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387507AbgE0S6J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:58:09 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIw4r4009036;
        Wed, 27 May 2020 11:58:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=W5thYSFLHQBsEKsgqJfZTnjul6HJtPAMqubvEftwanY=;
 b=oxg85JOyKAK2kJNxf8I/zRKCzh5JZRu+3KH7jQbu5nkN8bcrg5q21PW9px86ZfeXjoX+
 TWl65+1XtOMK8CwS7R/DnkCqCSEmrycwf7nJONZgiGinAy8d+ly46Lz+oM1ZiTNFC8lW
 VTIng8V5E3B9k4gghyiWF3hJUabS5NMM6mJo0EF0ryH1UctiGWy2F9hRsLPrxHBaQF7s
 jZzWnxpJUrMsPS8eC/MZzZG0CPlPOh4HMMF1UQgpkUqG0EVu+L3sgtp7xo5xzOoIQBgN
 C/zDgDkwRWhQBXIyk4Iy7G2TlZzfGShI4+FQL0ux3t0nkdxTtVs3Er2WYuO2oSzkKy7a YQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00328301.pphosted.com with ESMTP id 3185ap9ewx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:58:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCXboOGIP5XI1cQ33KHZIYHwYyBgYpqVOsg3o4urlfVVoxW+ofpDXVG8/ln/5sLrMsiwWGGpzRqESKxAn1hXsrnG6gDo5biwGJ4Buvx1ufgxcHMCB09Q7e3PreVxGbcWAf+glxzrJbGovFN6RmJtWIs11lE/QJoYrDhvg3O5fLsiOmf1SQOERB7WthcqlDhMHJUO8MB/gx4S6dK7qlX0NlepSCFlwKCelOyrtRVwMh5U9IcSejE8izFjUnBIoevD0FauyutKHp6aAi9Pqf9VkKLtvLlfBDVaF1MYaFC3BZ3DTRJMc0lOz4MqWYH6loQ2ZkAhHM+mnQn0yyzqYYEWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5thYSFLHQBsEKsgqJfZTnjul6HJtPAMqubvEftwanY=;
 b=UkuZfL/T6OuB2pm+EVRGkBM887arm5feAGNG0XcGbNNJJioHvBzeSK5tPupDTQid0NZ8/BcIFjG3YfDPPVp9buGFFcWHqja5h0jt0k0le2MozjHV2MM10hb8VtBSEK5dNz//8+8QPpGi81ccf2mFtdcogva7okDCP0wr9CDIqzm13XE817xhN4aJD/cKNkHR0g20jxDGYcM2cyuvjBJs48KuQvZXaEuTvz8XDfEIDsupRWzm+xbea9F2RgKpiVFDD7vg36THPv1pKILh6R0gAjHkdNl4QSuoANIhy3ReqRa4hc/VnuNKIq1EQStmi60KDaMVJtTuWNTMp/Pthy9THQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5thYSFLHQBsEKsgqJfZTnjul6HJtPAMqubvEftwanY=;
 b=NsbYOdmzr/gStxiyE+2AwMcUURNnd2N2x/EHTyUcwcCHydL6k5FRjwydczzEqdPBd7f4mLqIe6Ync3j8+PwwA3SrflLyXZ8MJvCzPFkdWZFQXy7GaDm85vQm4rcjjqypp2/6Z4ivuBR4Cb6MYzB+hhLVxOe4Ud0rLcBDReYchwc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 18:58:00 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:58:00 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 12/12] MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor
Date:   Wed, 27 May 2020 20:57:11 +0200
Message-Id: <20200527185711.21331-13-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb9f349d-0d77-45b2-8544-08d8026fe015
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31518A5F1C52ADA312B9C9B2C4B10@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLiBJqKCB3EiIfMvCVIqjMzi86d6ZzWTj/g/kfFhyeRXx0fb4uyz+ZXwmX1/EFSC+ZOuMauFtdqusoI9HH2qDGDaGvvY+xSyMIEVJvlBapYu9cJzDbia76ulo6bZeu9/p3oxSTvi2HRatXvZE1D94EbynIQ1QbH03jkfa8ji0JDOURua8mm1LgtrjPakXuGZiAG0q1lI5+NTU99FO31eLeCdruck7ny9HbS7tkgGOJbeohD58wbfxUgo6CzRnpsi8/IFLi7dZdzgwof77YRw6RVwImvCt9i6581VAtAZ6zVqDwMC76/jTzSTqtiEqRmD6S4cO0epTe7OskCHmg+vd6TqCshOokhtbceQBof2OVCMCO04pKKsC1hSuRDPfYYDUOA+SF1laztK553P7gcZFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(346002)(366004)(396003)(376002)(966005)(16526019)(478600001)(107886003)(8676002)(5660300002)(186003)(8936002)(316002)(4744005)(6666004)(6486002)(1076003)(7696005)(66946007)(26005)(2616005)(956004)(2906002)(86362001)(36756003)(52116002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AVhl9lr5i156ZuVQpu2jDMkwUM2OMfqpHosGXnS4/ypAAYsmw3eCfRN/YOOBw1bdmR07tGM2C3LVXkZDP8uI8BfNF/mvz2taEVp8+u+TL/gIcGKSasW4BNqqXhigw0C89LqJe6U1ugRWc8+2gnntqHBsatUI400baH33dFoHxFxRU6OBbSoU78HGUcMcOL/o3wOLNIYSTMpV5VZVKIEHOFdoMkfPTTJp0yLzklRwxJetLnqraaMoxwijjZ5ncQTWbo4WKSAu6QwWO7GXlauWCO8fwC6sqg43yv/gSX92kaphUv1Ueox2vgg75ZVHsg4Du5STJtZjfAH2ToEAKubQozqmxc0E80KbdT2I8BclldRrFSq/P48p1T+WH3/iWIYLnkXl7Yv7Y0i74KlvBCGghIJqLqHxImdqcLyemF5o2L6SrUXW4rU6lrT2wnieFl1sJy27SWtrPgPYo2+bmz16J4f0w+I9UsqnhWupX5bL80s=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9f349d-0d77-45b2-8544-08d8026fe015
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:58:00.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSG5X/KlsY/HYrzD4X3B1/Y3+0WcltuPqEHesjjiOqsb6g6HTBJ8Ufb/rkmPQWYv0oEd8EFb1cWTHiQXmuEPkB259kBKwSm6Y5b/Tw0MfIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270145
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MAINTAINERS entry for InvenSense ICM-426xx IMU device.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60ed2963efaa..cd8b5fece94d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8861,6 +8861,14 @@ F:	include/dt-bindings/interconnect/
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
 
+INVENSENSE ICM-426xx IMU DRIVER
+M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W	https://invensense.tdk.com/
+F:	Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+F:	drivers/iio/imu/inv_icm42600/
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

