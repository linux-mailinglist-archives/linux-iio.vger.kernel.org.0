Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21A3142760
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgATJhL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:37:11 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:19600 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgATJhL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:37:11 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9U2Wd008012;
        Mon, 20 Jan 2020 01:37:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=lxiXpkkAhk+dUrLv0lIopBcAtL+TlIQf+SgDzyovQD8=;
 b=IGMSrBHdOi89vhe0V1tNSD+6fJYOObSRmCoilafY9gw2yIwIt5D31pAACJLza1bDj3BU
 x2ZRTjaTkugOUDWWGjtYK6PXjrKfpP82YaO5kLj/zOpxk9s87lsfvVVQPj8F61awnagO
 ihgVp5p2YZNd5nbMnsnpqkB03lJ8z19rJHSPKEgElzRmPf8KRCfB6l1jo6c9fE675GYY
 /JlVuOreY+bO5dnrGbEHrbRBdnZjhtQye6WFA9gyS8Dr2Hyn6aQo35/j+30j7nMDHtBh
 gh+F4AfMA/SlOMxp+rWx1DqObnAoSg8cPJF+EwZ3bMzUCBMUAQty+/5ibBoIYVvlplx8 QA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00328301.pphosted.com with ESMTP id 2xm1gqrmt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:37:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHqZm9XdEShRMOInWMda7fjlDS52psCjqksj2L4MWwmiVToiakzZBl0wjI7ZKtdZlTKMxwHVKs3PzmfhwQQhtsZM3SUjwDyRBRl+rlczniVCr6FXBEmYmgIcxiP2+wHwU1blbdAUsqVEeqpeLfAB63QdlKAc8jNmoeeeKenr22h3GC9Ccr9zMe0+YbCsddjYCLjI+zz2RfS4kKGhk+MdJg60tInsBsmIu2Xax9s0PvTJnrWCtj4yr5TSZkDmhEC0n2TOi6uceK4kCwbKDvhbnEuOtdFtjNEE5Kn0wM+tmiNaU0RI67Tdkp/FKDczLxS4/h1lxTcyO8tk2aI/fG5GuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxiXpkkAhk+dUrLv0lIopBcAtL+TlIQf+SgDzyovQD8=;
 b=bLYkqgZzWzQAQRz2f+QkIkDiKv3D2MauHh9T2KfpTzPtUnApzNX2qMya0qE5rWNeYE6pT4j1RLVpqxyf0LnaYn4EgxonZBfplFKX7qC1uYccgjdSzjdUWSJFm9glYyFMzK4OYlJAgeZs8Ki5ZoxUHJCEJGwAZUSykPbyaa/FRAO1FFFUGAAYkTZG6S+0PK3cufFqT1jZtBnKWAOWbgE5FUwZtTVGRez4LAeaE0VSBEtVKBTdT5VvoffN/5N7oi0+loc8BzyD5r8Qy/bDEMaWS32KoZKNY3bBH2DotBZ3FHeO6V453ATW0i4kGYPr2e73cHAUyEYFh3zgfEBPZTIkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxiXpkkAhk+dUrLv0lIopBcAtL+TlIQf+SgDzyovQD8=;
 b=Gv4F2ZIv0/5sqJkuVbkl0qN1X0hlyNa0XF+wG5pUVqVWKvbeTGbBKzYHupfveTkCujnHsW+Tch4gLbY6vNZ6a2tgnWvQ4uMV8B6JZTzLARU5dhNGoZpghyS/Xj+iE5EjGjYd5zXoyNN25RNWaK5clH4g5V2Zho8omDezBx90l1A=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:37:06 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:37:06 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 8/9] dt-bindings: add description for icm20690
Date:   Mon, 20 Jan 2020 10:36:19 +0100
Message-Id: <20200120093620.9681-9-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:37:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6417c2a-0e50-4b1e-fa66-08d79d8c4fff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048800D820EC5902AFCBA21C4320@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(66946007)(66476007)(66556008)(7696005)(52116002)(4744005)(86362001)(36756003)(107886003)(5660300002)(6666004)(2906002)(8676002)(81166006)(186003)(81156014)(54906003)(1076003)(8936002)(478600001)(4326008)(16526019)(316002)(956004)(2616005)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pJdKgGeVG69RJp5DjKu45azaV9xvbh13YlVUsCpyl1ql7fQGBqRB7DQoY57GH29k5q7MvzPdGQpwLJqgm61jpOOZgGBar6vjNunKDBQRI5LaJjjuY437DIfV4XGrv72VHgwuMJfYzBwujkBadMxIxv+LpBYPZudv+lc0LgrWZi1DwxTOeU8lBGsVnvtqWhFmAwP+Cd6dUU7Hs7vN44P9IwAjUBHYbagh+3TOEpW3tURzWNheyFsIH2RtlYYnITt28GGUngN1Gr53hlyMx8rvr4vgaxT4bWxtNazZQPqoXnShAHCZ3uBSPY5pM1hQfHUOQiZv6DXF2c3/q0JOk2s+QrTA7LQ1ZyQYh9XVnMmT9jMkmyi4hSFM3Q++Oe3DAB8bIkC7zNtYlKFUAjiuymoMdtylvEBh6Kt3iX9LhToriL/Z5yoDJguEsRqlLdWU/H6
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6417c2a-0e50-4b1e-fa66-08d79d8c4fff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:37:06.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8O8T04/og/gAyGOx5+NzQpvdqJjd8RQ5LdE2U9kRk65U2oeIH+MQvknE6aiQfagN/3d+4dmUqwUCu7uFtdmUvrCjVK3j00tiQ128KXtJQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=723
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New supported chip.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index 29cec46e27ec..f2f64749e818 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -15,6 +15,7 @@ Required properties:
 		"invensense,icm20609"
 		"invensense,icm20689"
 		"invensense,icm20602"
+		"invensense,icm20690"
 		"invensense,iam20680"
  - reg : the I2C address of the sensor
  - interrupts: interrupt mapping for IRQ. It should be configured with flags
-- 
2.17.1

