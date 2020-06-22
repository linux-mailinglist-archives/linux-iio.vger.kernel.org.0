Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271AE203B1D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgFVPiZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:25 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:8204 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729776AbgFVPiT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:19 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFaLZl021513;
        Mon, 22 Jun 2020 08:38:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=MHpK3KpBI5HFazc9yGkFuEHR+MVVUd+m8NSjI6iqEgY=;
 b=afeZuzGoKQl+PxcO1u0VtpPy3Mbtvaa4YnqytXsbSokET/P2PYlNl8M+uxrMn092MLOH
 iU9OlQtKoD7OQweZK7vciLAHyNG1FO8L+lr/i1fTGWdpxQ1ZwelQHXwIv/mz1qFgJTmR
 JcUHXJFvT8GehV4grD+8Zu+ajl6hELXJgifrWL/QsG2s/QRPp6FBBCvK+00hX3pNTnEX
 wRi8qfo6DDtq+Warlyv2HwdRSdY56dC9/Us2AmclVLGB5VnXi/aswdx4AB2Ak+KMXeI+
 H+6VrsF2wq4aS36J5o4lfs3RT8nkSswWoo3TvnzUtIF8qkxWL3UaUFtUc5WrnLiUylg7 CQ== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by mx0a-00328301.pphosted.com with ESMTP id 31sdxnrty6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JODoiyzfAD2I5eB4t3mRjV+CnwP1VyFdxi+kGkP7V+GY112owdm9w18BeN8g9YfeLZXWLsKHsLWfPW3vhWerMOZf4SU0klt0lx5OXwL48bhEv+KiVUUIaOF5P/Xx7hNrTIwTczUzqaagZC8mkhKXoKa3RQwQTIoLkuIujhlpuAXGMR+Hd46RD6gw1U8iJQsj5WcEAfDiphNupeItJgZ1gmD/6kdPme1jImmAip/rKdqUDGxoyhFMAdYdrYtc7JaHLgMJzXVPHDHPHxpq05wfm0aiJebdVw5CZcWpStEKDtaQwd+9f1sUDpEDYIc1itqvoYPrRjdjH05dzYNoCFG7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHpK3KpBI5HFazc9yGkFuEHR+MVVUd+m8NSjI6iqEgY=;
 b=ektfnJ/XeDBhevFETYhAR5HtKdudEaCf90wyZp8RRft7+4ykL7oa5hVtNW5ZcOPhTDIiTYKGyXK51WGwr6VMQ7pn/VIgGOZBdFOYGVA3vMhhBoZZ3tRgkB7uz/xlbyP0sstWiPSfaL9kPoK/B7BWSuCFKmU1NxVBDqFXngqRGTiMxIh6PGopeNEPsbEXBtKOWW5f9O3s7zzIMaSUVPkzpStSLQFozm17lN99BfIiofnhy0W3oUibGbpZ7MuZpMWGVkfanFT4PugiHUqsNthZFn7t/j1WEkdnP/oomMby4qSnPRvDYfQKv7pFXje8oME53TzD48HuwrUf8ZUKbccvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHpK3KpBI5HFazc9yGkFuEHR+MVVUd+m8NSjI6iqEgY=;
 b=lvvTpdpydaFST0CyadwDOIDDXTiGW6kv0uLG3suIo9u5auD83HLk8Alwsf6fCc+ZG7EnJpHW9dE79SXWfEGNOrxuWWMuhRClp8SHju+gMf2XwRjv/KktnndrG/s4kQXwQtd/OZsyBZlhpyQ5BhoqA3KU/GSITt4GYmyP71CS9+Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by BL0PR12MB2338.namprd12.prod.outlook.com (2603:10b6:207:4c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:38:16 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:38:16 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 13/13] MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor
Date:   Mon, 22 Jun 2020 17:37:29 +0200
Message-Id: <20200622153729.12702-14-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:38:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c67dde2a-ea1a-4b78-1c94-08d816c247c4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB233873633C9136FEC60DD023C4970@BL0PR12MB2338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gyr68mGUANOQ5Grm3iRx/MKfXVb1VGAebiBoG8nyJQ391pJxiAF9ANVzTpkziEN6NUBMCvXHIjlRowubdaFhNnOPMHpHbU1pwrrpNg1Twm6ig0pXIiP83gdx94O8qU+//vhkstLtKFfJhkw0ao9vURNZUTDGsEjN7cOhp9eeBmG0sr8riYPmZrEx8H0n/kCvbCsc7K6yFY6o2v5ny1xQJMi6ZVe1+A06pI5KMYPBaPLkVt2kfOALO9FzWAKME+QdAjtF9XEB7+BqzOaV7aqUe7yWZr4t9K20Q4tFWAstnGEd5YwTAnYRXwkDPmyZfX68UvWG7F4DReh7faQ+XEzxRBLcZWHdP/eg64xXXj1vNWiTPhGiwQsz3toTTfq/JpO4NQiK+0Qfuaq68DFB7jVvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(366004)(136003)(376002)(39850400004)(6486002)(36756003)(2906002)(107886003)(16526019)(4744005)(186003)(8936002)(956004)(2616005)(26005)(8676002)(6666004)(478600001)(86362001)(1076003)(66556008)(966005)(52116002)(7696005)(66476007)(5660300002)(4326008)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Jyvil5/gNHUksUUNHWZdOwo8VG3vq2TB3xrV5fpubShEEfZRjJOO6dow7HpV/dJXUpPkJjOiuoVNxb+rvSUqOLChvDA5xEFijb4Qsqn7+hLi4ukoFUO/R1OBn/VjKfUVafMtd6M+rgt57/e2gXC9n1y5VEWtZWDgsU61Fcl9SG2fVRZ2M0l9OlYIdOfIcB1/3q/qMasWOm484jxwUcL8MBMKj6VE53Oth46GUtJwiD4NkKAWudD7FNJiHhue5q9VMbQtvFLRCeKhx6aDHsCo1N9TW2pw6Im/f7OYRPk6juqCbHmyPQbdtXhlAyU2/vZ0+W2QojHlY5X1pA/z46vOsqGsAS91apIHXtzErBhqm9PoUqO1XWvWXmHWBcdZg52hUwjKgjlgScUzQaxzcaoqsCjkCqPhDJ8eGnku905HZitoiGoQaZ7g2/STaLQtm6W9sL1n2rPoT8aydg5usPUmmGtoH98MQFHVXXDVs7/h92Q=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67dde2a-ea1a-4b78-1c94-08d816c247c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:38:15.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPpHXpph1k3x2NZX4oLjHyfqTPhAOQpDQQ+ysOUf2uYadShW9s0GMHiiCkTnAI/8gdmx+q23qVuQO6JG5u4cbeGDAsywscRUpBwVAo7qsWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2338
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 bulkscore=0 cotscore=-2147483648 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220116
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
index 510fa7f7c756..a65771cfc506 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8979,6 +8979,14 @@ F:	include/dt-bindings/interconnect/
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

