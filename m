Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7B32E2C3
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 08:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEHFn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 02:05:43 -0500
Received: from mail-db8eur05on2115.outbound.protection.outlook.com ([40.107.20.115]:39392
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhCEHFn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Mar 2021 02:05:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+YCrNhuZOxQElJc6LwNcSGmB6eqedHHOQ4jBz0KpqY4iIq4AdPNFHRPZgkIhSsCR3VGxpIWLpMOL1Z9QxxS17RA1k+TGu3aN/XwWk0LHzfHZe0dDz+zaWJlPKzB/jqmf+ebgz9A1rIEL3R9zpv/FlI6JFVtHAf/OokZoofw2PLGUYoqJGyXK0qZZHGzyWoqk9Njffz95kV00gA1QGaSFJ8JyMuxzczsPDh4+MJ9KxiHHnibKT/AiUG1VcXdip6mxa2XfkuErIrdMLy4pRL3+vsisH4mywNqfq61Vir0a0HZZot9cIeiyMU2f+6QQOrCAkhjWVWi6YtiWZGDxeUJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PpDnolJJbe124umqt+lTcwY3h9VSxXbJK5EQ1As/1M=;
 b=fUY8k/6xxRtwF89B26/iCzHo2ejPxnPTO4APNnv+/8ox4KbixYD1UjojQpGy7DbrGySu+LeRKANojoHfRNbS/5O3LV4omwqub1QMvX5j6/wtltIWSubp/VdovP4ZVof6fl3I8PxyieZAS+QEGeH+hEY+aSNZBJ/kmJb7twrYWGHzOAsmNsYwwTrz8DMkqBz8B7nZhERMrTdb6O8BBiEI2R5iv7CwRIyD/OsJGGWdEVCeHLVWmFNoF8Fd4H1aOdaAkRJnNg6Eg2JXYJm/Oa9InBwv4pahZfjYLRUEKHzwa+y/ETFWlMqokE5xZtZeByOVuLh0+5Y3mqnZkCTmq5uf8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PpDnolJJbe124umqt+lTcwY3h9VSxXbJK5EQ1As/1M=;
 b=aLc97L3wEojcFvuzgRtLTqkE0ENh2n3pZbrpA52EuMiZZaVEfhrJ1Ln66DD2ClgZRJypW9pMp69mFeBs5CFZKxo8R9rusbJJ1XedfL0trOtFBNJgRaReil502ZfNW+5EmJUt+aZ6kyckYsmlTwpXcNKeu46Pc+Dmf0iNCbJMdnA=
Received: from AS8PR04CA0130.eurprd04.prod.outlook.com (2603:10a6:20b:127::15)
 by AM6PR06MB5000.eurprd06.prod.outlook.com (2603:10a6:20b:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 5 Mar
 2021 07:05:41 +0000
Received: from HE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::30) by AS8PR04CA0130.outlook.office365.com
 (2603:10a6:20b:127::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 07:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 HE1EUR02FT025.mail.protection.outlook.com (10.152.10.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 07:05:40 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH 1/2] dt-bindings: iio: st,st-sensors.yaml New iis2mdc bindings
Date:   Fri,  5 Mar 2021 07:05:35 +0000
Message-Id: <20210305070536.2880-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11cda72c-936d-4c56-8ed1-08d8dfa51603
X-MS-TrafficTypeDiagnostic: AM6PR06MB5000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB5000A5E3A70B067C9CF76421D7969@AM6PR06MB5000.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBMmWgCTRLX92go/012xhoDcCqCodIwM9ea08TsDgLDM2vmm3umUVwNavvtRSJ7Nwold0QTBaT1qQplJkDCZ7Is644BVRF6HVLjkwPs5AeZTTNXmVQ2T1Gsu5y9vzjZZ0CWCtnMSVEFdtN+SXgE+I67NX7vJ/KZdVG7a3nnwgIelCNk9XzLULBHeZTiw1Q9juD+Obb61iXCCHPUXXSByvLKqb0KR4bRP94gltUSjxRTQ35UQvQlOKvOfehyy4uDc2ORtobtOKYgkJ8o6/WFvcIICG4CIYOZ2YE0NoMjq3fwIFqyp/xFx/n4x9YSnpzJT/ML4ZNXUxb45dsDcjDVpajc2pFUSi1H/ro1GD0CAg9x9REhikzDMx3Puti19xxTgcqIBcpXjP2ytaD7Q1x0iW4AnGDwmv33ejJ8L7SxNekhtR2Aooyr1YQuDKd1iTh3PBpGfEa1rGIXD0jKSPG/7InB8Jf6VDML0pWb7itiKcaBMp6oMLQcozSdeGTUi+b82KnzIVZBz6puSkEXWKrSpX2AB6izDZvfKJ2owgVaILDg47ut9UlV0WCDScbhkmU3yzEmy9pdobuWurODe6+cjGzOpxdOvj9FSgwxdjuaSKVsetFwcMMCA83zkKnubKkYT9nu6i0hCv5p4czcnKltHZ26gTeWFVRrdt0QrVKGWlGRhmug4M3LUXD5jAuCOKP1e
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39850400004)(396003)(36840700001)(46966006)(316002)(6486002)(6506007)(8936002)(2616005)(70586007)(118246002)(478600001)(82310400003)(4744005)(336012)(70206006)(956004)(186003)(34020700004)(36756003)(81166007)(8676002)(82740400003)(4326008)(6666004)(356005)(5660300002)(6512007)(86362001)(47076005)(1076003)(26005)(107886003)(36736006)(2906002)(36860700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 07:05:40.0027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cda72c-936d-4c56-8ed1-08d8dfa51603
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5000
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for ST magnetometer lsm303ah,sm303dac and iis2mdc.
The patch tested with IIS2MDC instrument.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index db291a9390b7..6fd61ffde72b 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -66,6 +66,11 @@ properties:
       - st,lis3mdl-magn
       - st,lis2mdl
       - st,lsm9ds1-magn
+      - st,lsm303ah_magn
+      - st,ism303dac_magn
+      - st,iis2mdc_magn
+      - st,lsm303agr_magn
+      - st,lis2mdl_magn
         # Pressure sensors
       - st,lps001wp-press
       - st,lps25h-press
-- 
2.17.1

