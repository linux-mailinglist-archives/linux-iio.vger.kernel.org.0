Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819551A3168
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 11:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDIJAG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 05:00:06 -0400
Received: from mail-gv0che01on2111.outbound.protection.outlook.com ([40.107.23.111]:46656
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbgDIJAG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Apr 2020 05:00:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcTjd23p2hZniLkFKMU4BrDiq7m+HcQUizPehI+POEsApqtphCZsrDqvuo5+WcXevWpJX5LFA0PQuSnDNCiChMbpRwAhdtFg9DXcEXBFHGjnr38rDdsJhfI3oUyS68twNjooeFnRT4ZyqAGdRPBOzY1vWOp5ONi3ADlqfc+rVASoXq94d90nndvX/Spe/LXcPbizv6nnazQqCYLqz3ty+UZsklqV9nIWIoXabNhEu5eAwogSBd7dNSraw5P82WVOUbJpVPYRBLsWGnrtLpUKZLQvGVC1VG3iXYndJ/IyY6N2exD3PXqa+uA8Kvxjxx3XADzdlvMGeucbzzr+lRmVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WQFKfbq2ZMuKbKzT96MV42yrtH0SZoPmZFakw54vfE=;
 b=eBCFkl8oNiZzgo939+NdYKfq4Sab9VUO3jbPanXnuVZRqZtkxBmx9haacf88OBJdlY8m2mrQzYfO2SRDuF2lx3Scxr83gUwDNHWKD1kQwZOPNeQikFmlOjXKfoPMDaoTTc3b/FYKAh7jU4IJKo1w+BYxxyX3jJtyY7XIa+tuJU+b/dbZkCxuIKv2tjF0LoHtD1Z0HFJH2d6JnUXA1CNZ5d+4QQQkRMk8IAD0s2Zh0pAQIcXv4rVDbtRF73z3UJ2m+UzquQXT86bGSyCvrnEOmPUIDpgbl08as6rKAevemSoWP1q7Asg/ZmXOQrUurY6gSP0sf2TFjv2NJz4QPA7dog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netmodule.com; dmarc=pass action=none
 header.from=netmodule.com; dkim=pass header.d=netmodule.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector2-netmodule-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WQFKfbq2ZMuKbKzT96MV42yrtH0SZoPmZFakw54vfE=;
 b=TNQiYI135RC2TOb/m4shQa2/OIaJ/5QZ36uTue1bZSikKJyvEQSr2pXGOjyy+f8uMDtCKu8GxWXq+3qhuX9g4OY55W6FdAVh03d5VkYS6KtuWWtNvpXtGNIy2WsB8U2KA7U06jGLbegx0qSofNGX0ba3oCo6MCOzHbnBdAwK6iA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexandre.Bard@netmodule.com; 
Received: from GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM (10.186.181.138) by
 GV0P278MB0052.CHEP278.PROD.OUTLOOK.COM (10.186.181.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Thu, 9 Apr 2020 09:00:00 +0000
Received: from GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a945:c379:b39b:c6ea]) by GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a945:c379:b39b:c6ea%3]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 09:00:00 +0000
From:   Alexandre Bard <alexandre.bard@netmodule.com>
To:     lorenzo.bianconi83@gmail.com
Cc:     linux-iio@vger.kernel.org,
        Alexandre Bard <alexandre.bard@netmodule.com>
Subject: [PATCH] iio: imu: st_lsm6dsx: Fix reading array out of bounds
Date:   Thu,  9 Apr 2020 10:58:18 +0200
Message-Id: <20200409085818.9533-1-alexandre.bard@netmodule.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::15) To GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:1d::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from JULIA.netmodule.intranet (185.130.140.44) by ZR0P278CA0005.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 08:59:59 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [185.130.140.44]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c29480-d7ca-41bb-5281-08d7dc646246
X-MS-TrafficTypeDiagnostic: GV0P278MB0052:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <GV0P278MB00522F1FAA3FF90958A68D2687C10@GV0P278MB0052.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(39840400004)(346002)(396003)(366004)(376002)(6666004)(66946007)(66556008)(16526019)(66476007)(8676002)(1076003)(8936002)(6486002)(2616005)(44832011)(186003)(81156014)(956004)(508600001)(81166007)(36756003)(4326008)(6506007)(316002)(6512007)(6916009)(5660300002)(52116002)(26005)(107886003)(86362001)(2906002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSVLqzBWNTjjFkfAyAQtsJxTpVc2vNqpjetPqV2yzEsWnvPfh3nCNstodl2jyGrjWp+l3Gmj0Aykz3mou3pea20IL/Omf5qk5Uc7i7KCUkHx6Is87vmrWCeqQVaL5P2J3gXA+/K5YfK7MihOOhA6tt0l3l29kwQfCaC60sUVPygrYwGyFLjjlN6Pf/JhqtAKYopWov3WdpHE5/IFSjbUR69aCwsICeUkyJYBJR72n7QVR+oUC97Kl2Qxh/75W+eaf415iihvFKXOsVNY39o1GHrQXfA50pVid4HM82QnciN98xxTKOSPlQL7p8nyh6W4Wx4ZgqrvVVZXtNO1T1mzfvuis2T+r9BhkpcsO27CRL8FW2+cvkzq+2wkLtO5R7tjpuSM9QBK599gJk04a02EsFo6Yv/6oNg7lDFSiEWxSnuHXlugAZo9B8fnpimAjAMk
X-MS-Exchange-AntiSpam-MessageData: FQCMohPyk3nlC7EETYxF0/p5HeCKVx5lQTJt7r7yaz3/V6qqX5H5I3n8jp37faSCP6sA9QOt7tVXwvh/NY6Fl2hOmEixLhd0RJ5ZdCnjJyfwf4tF/OhqaLgukGn96PPIrMT/kie5q3Kh2ZGgD4rv6Q==
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c29480-d7ca-41bb-5281-08d7dc646246
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 09:00:00.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoXAtZfma7W7qg6PL3N+CReGJBR974aV05tG6haJXnmQx/UEF/NXRneISdNKimtumaI7vDSJg8CuJzroCGqT2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0052
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Former code was iterating through all possible IDs whereas only a few
per settings array are really available. Leading to several out of
bounds readings.

Line is now longer than 80 characters. But since it is a classic for
loop I think it is better to keep it like this than splitting it.

Signed-off-by: Alexandre Bard <alexandre.bard@netmodule.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 84d219ae6aee..be8882ff30eb 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1350,7 +1350,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 	int err, i, j, data;
 
 	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
-		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
+		for (j = 0; j < ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id); j++) {
 			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
 			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
 				break;
-- 
2.20.1

