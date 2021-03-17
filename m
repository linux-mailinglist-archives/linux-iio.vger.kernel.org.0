Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3492333E9E0
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 07:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCQGjd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 02:39:33 -0400
Received: from mail-eopbgr150125.outbound.protection.outlook.com ([40.107.15.125]:46304
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230196AbhCQGjL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Mar 2021 02:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwJpQG9684ocMrzZ9bh5Kr+ObQ+wG1zUoVVS/WVeCIkoK+GeH5qZRLtvT0QYt3eqkdqjn/9bJLbiljD0Tqx9cFz7iyP7K3ny9EATq+eIv7GNFnA/M4CksyGCtKtmeYsT5FDX+2QKOzrlZGz8G/Ti1cCLRI/U905wcbqmdhrNRVqhROsaruTVWbQwJO6IfHlsIudmSJGZ54zK+hl+u7vg73jCZ7CS+Z2ftqxMLxiNIJgrdGVkGfIVu8tQsveDVrNhfdL5qphCSHiGM5q1nIPOZ4P23G+Mx90kjpZui75hVz0tM/Bsp+23qUIcDgSPvFp+OYbQn4kvQ1hJZfAad5jO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSUWR3+HerGp3HdOLqv02zRanAc9eQ3tnGcL95ToD1A=;
 b=cgB/9Zj7Q6sHBp1lYP9QxGgRvfdQ87Ui32akM+QenUon8r6N6c+hFBm9DGQ476T1T5b0NAsg3OLKB7B3np2HsUguk6Uf2kV47JvoFV0Ykrc5jSr6TwPH2MW43j0DzZ2e84Cqzr3/NAaZV9QX01YLC+OvKp4i47k6TqG/1gSUS/QS/R+g5N3yHYsskwnR9v9E88Y1ik2pLVsQ6u+P5Hof3vVmxc3z2AKZHJ1+shNDA1Xh3v+1ipq3L8usq0jrbvj2USvJ1iW86IZsEE+qIW/6TppT2XmYMHzM2OcNfrQ8q/RNkGtH7oKbolLSDb/JNw4/jfHgsR/qnlVwSEYk0H5joA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSUWR3+HerGp3HdOLqv02zRanAc9eQ3tnGcL95ToD1A=;
 b=dVNQtr2/pHZY7UOSP+j8g9Xip+2E3mpXmKyfYPVk4Fzs6eUD6AUew+KNx3b0bDJ0N2tMs3KvkBe1JV7HFZpQx2gxmkELICNGNaE1cg5O/Ikfp6tKnf4rNyQgOkCgpuX0K0mnxyxdHK6Xtd5KtiFrQRqgeBkh4wJJUvjuKCrNcY4=
Received: from AM6P193CA0063.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::40)
 by AM0PR06MB4851.eurprd06.prod.outlook.com (2603:10a6:208:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 06:39:09 +0000
Received: from VE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::24) by AM6P193CA0063.outlook.office365.com
 (2603:10a6:209:8e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 06:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 VE1EUR02FT041.mail.protection.outlook.com (10.152.13.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Wed, 17 Mar 2021 06:39:09 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V3 1/2] dt-bindings: iio: st,st-sensors add IIS2MDC.
Date:   Wed, 17 Mar 2021 06:39:01 +0000
Message-Id: <20210317063902.19300-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317063902.19300-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210317063902.19300-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cbf246d1-43c1-4567-9768-08d8e90f5ecf
X-MS-TrafficTypeDiagnostic: AM0PR06MB4851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR06MB48511DDE8666AB6F2B49A0CDD76A9@AM0PR06MB4851.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bh14sHgt8h349aDorVini0Pybmn7S3oWnZZ33O77WsOEAfl4tcllzQlA42AKTgzgzih0cX6f4mTRuMcLDLIgjkRCY9a5ZwBQDz4aQNzF6Icu1/MEAiHVBkCq4spaGf9wgSmrA38PnSccoHYxBoijA7DyuWVQQLizb3MS+21AnPw6rx5gJCKW4JffxOxZ4YwiCqWfpi8ojc68qUhwPGGxH2MhoNk1upHt0G+gTq8MTd2dsJXPYbaCi3pVYdGXOF0kG/3/HBCuFaX78SDM+atFlCyh2hZ6TCXqpCmJW+PzoRchKIiMFb3Fu/uk64ohTwjm7NjHqlgMQDGDD58F68vLuiJHhobaWdVBQ3a6uiLPATMOMIPwkiL+lopyUS+Sj8O9MwCpCPsOSn5YVdq1jAqrdQLED2kc/w49HhtqgnGDL4+M4YyxL2nGJlmjqKKqEk0YK0+ZSComkBtvBatviFF0/gIhA5KSz2KztOJUYNTcdcC47rz4dnXQrt15eaB9HYHSNJBo74D7gGk1/BZus9uszbJ5aDq01aK7mpzd+3iGcnhc3svBssKRK+20ISR79ga121zR1z9blKtw2Y8Y9e7uEdrEpUZTWxetqpQJNel4Y+Bd0etcOFRPXN8sUdaqf3sjtON0v+2ows7hkD3NhP7LyVs6lTFDznSrHGQjNeNVN4k=
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(107886003)(82310400003)(36756003)(8676002)(4326008)(336012)(6486002)(186003)(86362001)(356005)(478600001)(26005)(70206006)(81166007)(6666004)(2906002)(316002)(956004)(70586007)(118246002)(6512007)(5660300002)(2616005)(82740400003)(36860700001)(36736006)(4744005)(8936002)(47076005)(1076003)(6506007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 06:39:09.4729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf246d1-43c1-4567-9768-08d8e90f5ecf
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4851
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for ST magnetometer IIS2MDC,
an I2C/SPI interface 3-axis magnetometer sensor.
The patch was tested on the instrument with IIS2MDC via I2C interface.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index db291a9390b7..7e98f47987dc 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -66,6 +66,7 @@ properties:
       - st,lis3mdl-magn
       - st,lis2mdl
       - st,lsm9ds1-magn
+      - st,iis2mdc
         # Pressure sensors
       - st,lps001wp-press
       - st,lps25h-press
-- 
2.17.1

