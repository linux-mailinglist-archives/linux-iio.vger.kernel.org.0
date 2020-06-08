Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276E01F20E6
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgFHUow (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:44:52 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:16230 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbgFHUoQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:16 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KhpKO027834;
        Mon, 8 Jun 2020 13:44:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=W5thYSFLHQBsEKsgqJfZTnjul6HJtPAMqubvEftwanY=;
 b=LDUtm8mVOo967Bj/80EW/+ZBU5kZYUpbDg0dVxmubCgyeHRGatfYLuXZ7rDXiSQsS+Ic
 OAGysDv/Vc9sVzZLoSV62yvvxH97KxR/ZSlyxl5RtwfP4qQfOTP9msKX0U+wlBz8ggiq
 Z/O79mc+/67qbwJCcArM1yJeJNk75svwV0h/vJk3B1tJg+HtCt4qrhitwVYepEBF+QWy
 n1Cmt60j8jR8WMeThy3PTWDTBbdKhCMb6uX4JwMCUA1PDh3bd0EBpn2G2uTrrNcrrd1m
 eTzw/AM8/F5CZRGKDLIfidcfR5l5zdqV3CJLRfezMLza1ZmYe3PF5M7PILYabqxggNIw tw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00328301.pphosted.com with ESMTP id 31g867h0f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:44:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPjOfdrAdjUtlF+WZSAbhQYVTvVa+PsJnLpxvEGPrSPBOzAmbTrZ61EG2/AleyVKVogtFJWKtNp8Iz2+EfKCjBXVgWdOpYHo+qlhqNkKAVloSz1yCfCR8pNdUbAcfSANQJ3ik/Jaz9OcGmN3zTLx0wVZPfUMARRpgyQaIE3Dw6lb3bZEu64ASWF8tKdEYrx7i+nzcdor4gnmSqcar8M4yzfnwg/R0uKMWyQuUeVX0tPKzvHT89r1GIbZtkRzRwluzoSvJIgYcSBwIfPz5SC8JVz25fNhoIRv98dnFq2c+x4cGvqWoTlD2TahdmfBHAI/1hWveTaSE2tAJ7Obh+qfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5thYSFLHQBsEKsgqJfZTnjul6HJtPAMqubvEftwanY=;
 b=MdkhKKhDLTVesMALJtHq2eAtdkbcj22mY1FExFp6+MI+17deQh+ofg4F0qXz+XEtiYeHjb8gVCZ3vVeda8oZxxsmhyuV260py38KvGSi6SXkW3DK612tU3GjbaFJREdARgp4MPI4kB1rm6Eo9OMVD4No5sdQh6g9yHxtbnx6bxDyUVtpaK97Bs2SZpUo2E4QmKNPnFWJ8vWDi2NoRqiX2qdwlfGIiBykho7VkXl/tKvqGTAzzIv7mBprgeHQfDP4ZpxkaUi/2uimqHsqANA4hfPK0oNZ0tXpeCThT4XEDrP/9EKUVF78VtT9UOBYJbX1YEat5GvGMpOVqshGLDyl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5thYSFLHQBsEKsgqJfZTnjul6HJtPAMqubvEftwanY=;
 b=dSVcraHPMssBwGaud9TTLLcAgb02pjRstEnQhPRMUJVkBJA5NzEa0/xApBWmrQwMeJBz4ahD+wsqfJUFy26TgJ3Qzmj/y87TN2vQWeBHdid87Q9H2sI+8i804YcQgv/hkIKZwqRRinpD+tMSX6uIpuu5IA2CIX3tUwaSrVlv1nw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 20:44:11 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:44:11 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 13/13] MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor
Date:   Mon,  8 Jun 2020 22:42:50 +0200
Message-Id: <20200608204250.3291-14-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:44:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eebb79a0-9e51-4ca6-84dd-08d80becb2bc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB420556EF4EBED6E771E2DBACC4850@MN2PR12MB4205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5IV4b4Rhstbf4pu+2Z7d00518WuLVbaaHFWEsO3hHBlmnFDrybPx8GPU811JBbH/IVnkgwz+9BxqMosQ/hvOuV99YokbBK9H29kGefFKR8FYeSY0B70ZOizp7De8rwwE3mUrqmHOzy1PwQSB4MQ1c9zC39kpCVV65vLv6j7zQ3+tyv61waQXzTXSq0wW+Ng085nkdM4tEYx65oucf2nIYQRgFxZ8/mofUSrmLMXs1J3lA3qrZlGZ6MmZLZ7s6bmMnA/d8Jj2ffZ2OvAxaSmU/gnBz4Fn008GFG2y/502NYGuGiiUa3YqNb4cK6Xxb3/9DQNie06VjqxxqXAynAVT9Cd+vpx5ijvcRurhe259TPsYeZ4R+o9a9/JZskqfB5PvVjFJJxAsI1sDBc5vBU9sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(39850400004)(366004)(136003)(316002)(966005)(478600001)(107886003)(8936002)(956004)(2616005)(8676002)(7696005)(52116002)(66556008)(4744005)(6486002)(5660300002)(86362001)(66476007)(66946007)(26005)(2906002)(16526019)(4326008)(186003)(36756003)(1076003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NTMln7q93fB3V2UAjm7p8O9S7b7pyiGU6a6NeXF3kudqqvGcI/oD4CJj3YAqO7OgFAUty2TMUKdk1g4B9Ki0KjVn74FFCfT5tb3MDv8q87PfudB6WG3A1QCS3p8dwamnLQ374Jt6wBm+u+6JGq4d8Uvd82xsUAy9z3O4h4aRN2O+TaO7W3J6Q5TZEF/qfkHHdoAn5DXKtLEnaeSR2Try6/keOjgnx5oYc/1Hcx5nNPY87n+P9UD6PKBIeaxbXp1eo/ZQU4eUp2BTyZZleZV2X0JL+g2ioxcOX8m3AZtoJp1E2EXT2hnGu8g8C0AGlhZRrZuzoX8WNJQiVFP/Dn5limaHbr7hOGxBbeXuouSBJaEcNI0AJAgRljRb2f3AXQZClygPL1/GwLT+OPbb4DB70odC9gmVqgLawGXuNLo1TPuMnoR/V4QavZnQhp8uymEomG+Fbs5Ojl+8C5a/bfIceU9Vl5aMCCdtgW5yX/xZGFU=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebb79a0-9e51-4ca6-84dd-08d80becb2bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:44:11.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33MWJDgmmExMZwgeSTV8viyE2nheZrDN9MLDGtX1mukEEcmqEJ2LKAt5gcYiM0QmTG7vzn4zmyfhBrMwMp1Gpg0VsRXsB8zZRxkHOU5ydvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 cotscore=-2147483648 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080144
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

