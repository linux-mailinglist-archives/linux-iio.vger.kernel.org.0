Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17BB336A58
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 04:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCKDGf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 22:06:35 -0500
Received: from mail-am6eur05on2097.outbound.protection.outlook.com ([40.107.22.97]:23905
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229808AbhCKDGI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Mar 2021 22:06:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOIUh2VFunTt/Fh8knL3oSlLGLADy3dUbh7dJ2xvIPD0Bl45uVZhUGjY0WEE2dW01CMhfhn8JicdE80gQyk43pn96TKUs14HUdqjjKZU34dMF58AbgYFONrDR6WLZDd4yDpIBAE7L7P3Yy6xXd9zqPWBBWoNJurgZokxGRnYRhUQq8aBqJv5ZLXQAtAZCczkBfxlAnKUnDnaFDGO1vN5XqtZme4scixSPMqnKQqOphNWfs/SX973rgCEdte6MT5MAc9cpUVNUu5DxP9v29bTWf60aH+tU5wQ3+b7nl4e0Y5VPQD1+TqPbGo4qsVdeB4Qrv1KSFzv3eDvzQaZIUO2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO9ovqZ1rPbMVVy+N1XHhTdT9I2WEhdvrh18UoFY908=;
 b=WzPIaJUf5vll5my95MrsCOvO10LAQL+i8r3+9wfzMJpn1uxZTPqdV2g9OlemYy7T4Zkxb2R6g9KdOY1AEmIObfsWMWgmmdSajBaQhZ1lp2rS11HVRS133SH6ZfN4NwZwuJPtW4AHME49DT34fbhRmbk9Qfwi8jVH5auasQWuqdmY7N3UVNO1MW27tR2elCWhdkWv2WXSibpbYm6UlyrEAI/gINBGeqj18Jncge0CtliR2GlDLZctDUU+0eNJ59mulspenUKBykHD/dbP9ru44hK6YVWD5V8Sd8S/O3Bt5niPNGegs0Vzqs99+FFKTRBH8LdN6qmAYWzj2eqQGe9I5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO9ovqZ1rPbMVVy+N1XHhTdT9I2WEhdvrh18UoFY908=;
 b=rduvDNTFeoP5DfAtz5SgF5Y6qMKhL1Uz75qMAlHDFlOZ6P0r6Ea/9TLkH+MUU8XYC+oknsw94ZAStrBLvuR1+2X3fxHIEZiAza1szlUA9d4lZ/9B0tlX/nDr6mKrvE7oYWBbCD8RdMHtN6/rGaVMgRl1ScR4iNBD7QvY9U4IICY=
Received: from AM7PR03CA0011.eurprd03.prod.outlook.com (2603:10a6:20b:130::21)
 by VI1PR06MB3214.eurprd06.prod.outlook.com (2603:10a6:802:9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 03:06:05 +0000
Received: from AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::e6) by AM7PR03CA0011.outlook.office365.com
 (2603:10a6:20b:130::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 11 Mar 2021 03:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 AM5EUR02FT056.mail.protection.outlook.com (10.152.9.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Thu, 11 Mar 2021 03:06:04 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V2 1/2] dt-bindings: iio: st,st-sensors add IIS2MDC.
Date:   Thu, 11 Mar 2021 03:05:53 +0000
Message-Id: <20210311030554.6428-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311030554.6428-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210311030554.6428-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35b18620-d45c-4ee5-f95a-08d8e43a9bf4
X-MS-TrafficTypeDiagnostic: VI1PR06MB3214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB3214AA0324E71F3D9761575ED7909@VI1PR06MB3214.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtEbDFV3byHOXgWSl+RYJ+/oAD+UEOQqj48z5/kuRNj6ydDoQLkb/IZ9EMJj7k6D7qScf0HWa4xped1KJa4GEViglNT7PWuC7MKjKoQ5w3jQVEnvbghjpRJl0Q51glNtVfN0SPZD0Xu6y9xIt8NjCDkf6AyfoWyT1pNNvWK8VU+xOPZU2pi9OBWt2miDJiy53bH/w0y2m+UwN3SjeeiD9FuO36/g4RJi+bc4ZJB6R53hw3G35CiI7/GosyehZZDKbNcw1232jj0Asn8dnLw+snJBTut0icikYnfOTwEEqqWuPgwbIC34jMOSn6LkK/RzXJlgF+RwjKcx+LoS0slJwBxEWIvsm1V4qnMNJA6jr/rGty0me6664ybRNcD3NViZVTMI6TfALB2titVMqk/MonNWjDp4gZgP5z8jTamkyeL6c/3WK2Qxf0tLz1NEWE5DRj6TA4fHVowO2xwMx1Ze8QJNaSyU1XbtiqAMPVyeE5r0o24RnaYsHP4Bx7tdfT4BZCVGtFV3vqpvjkKkC6lZOHZRyzcFHl5eBzAUYxcIVCR+swvt3fY5KiYvV8Z204AJOszotwTj75bxaWzvngNqx5OKIt9wcUcLRblOuBqB7RFRtFeF3lt4vkBVak18mo7AGg41TpUaRhGsCDio2oeOkJjW1ob8vxSKHMNyDOa4JfaJCWQgj5KUAxXUWtU0JSmv
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(478600001)(82310400003)(34020700004)(356005)(4326008)(47076005)(6506007)(36756003)(107886003)(36736006)(8676002)(316002)(26005)(6666004)(36860700001)(86362001)(1076003)(8936002)(2906002)(6512007)(118246002)(186003)(70586007)(2616005)(5660300002)(70206006)(6486002)(82740400003)(81166007)(4744005)(336012)(956004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 03:06:04.6305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b18620-d45c-4ee5-f95a-08d8e43a9bf4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB3214
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for ST magnetometer IIS2MDC,
an I2C/SPI interface 3-axis magnetometer sensor.
The patch was tested on the instrument with IIS2MDC via I2C interface.

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

