Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0AB33E9E2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 07:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCQGjc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 02:39:32 -0400
Received: from mail-eopbgr150125.outbound.protection.outlook.com ([40.107.15.125]:46304
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229795AbhCQGjK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Mar 2021 02:39:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbtNZmmwXvniInG3HATiZRqAg6xENTVuUASGnhBKxLiYLjWf/6X0J4obJUtJ+sd+9OVrgCHjBlLsq2Pwn75jvEaTaycC4PxHVpdg12RNexe8WXG3Qi7l7gyRoSKC4FFfNYk7vuVfuKrO5DJc6QADlV+tCcwcA/dC3nQekgae1/tIDFLR5juZIEp+BowHxiT50haRKI+Fiij3aOR3x4UfebEJb34vdGLJWQplqaq007j+PVz9mAn1G4Rv6SAyJyYn8peS8bCcmnzobaCcquyJPy5kpF0Z+eH8SjIiJuGv+qFpU5UwMEIcOsmMaAjUhtEbIv5l17rEYhABFNO9VPNTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e6C3l1vbL5obxbRUqnOn2S15jLAsmoYFmqCr2oIDGY=;
 b=oSyaIADzDNNFAnbBkU/7lC4bgCF7o+7mu8vmaofBoAFFVjbOVrSQbkxKDA0pu9kWP5LnlSaFiPNUZ/+MJTlG3sFwNQWb7FWK/iRUrW35yhLAYkiEBVI+OY5bE243IB60evfKXagbCORE10fdbC1NSxBK1hVcPcA9tcINHj2ruR5jeE/712gI4i6KYNLlQw29AtjTmy/PNvh8RaGugpYezQNrxY1ZEn03BPY/RSkSCJFoVee8HPR1JE5L4vpIfDyvkOI6f2LAEDj0AMD8rbxog0Yz28mBZg/Gh2avqEpG/gMSPBr1wIf3LeCGL5pnJocR4yn3lvW8Sb3Ciuj9mMvGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e6C3l1vbL5obxbRUqnOn2S15jLAsmoYFmqCr2oIDGY=;
 b=WucQFOD3G0OyMCTe3xS4wAk2+vCO7kkx7wincLCR8hLjyikssv5OgcQfg6F+JNF01XezVFZ73/c+KDVJs03KQj0aqH7wmcJNR0U797FY1WHrNzjIrshLYLmx0ScztPqw9QP4bmul31uTmf6pjCPzguA6Xu6Jxqrk0VNv1Byx1ec=
Received: from AM6P193CA0063.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::40)
 by AM0PR06MB4851.eurprd06.prod.outlook.com (2603:10a6:208:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 06:39:08 +0000
Received: from VE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::df) by AM6P193CA0063.outlook.office365.com
 (2603:10a6:209:8e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 06:39:07 +0000
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
 15.20.3933.31 via Frontend Transport; Wed, 17 Mar 2021 06:39:07 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V3 0/2] Add support for ST magnetometer IIS2MDC
Date:   Wed, 17 Mar 2021 06:39:00 +0000
Message-Id: <20210317063902.19300-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1590d7e3-1383-4dd2-a988-08d8e90f5da4
X-MS-TrafficTypeDiagnostic: AM0PR06MB4851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR06MB48513815191BD9B3129DDB01D76A9@AM0PR06MB4851.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMB6sOpJefH2Omle64X2OVhwwa+r5jqIFFuOZaAZKTiAjcHbyFc9E7ENN4FevihtHZMc/7xnydUZxkoZJJRJx08XSA7IhhAIYjQdOvrj0rrcTtsRZEmQ8HHeihtkB9M/hhFTwL36QUA05tYPJ6+nFhQ8Y+DEUY30vcUyeCwPlbdbQaM4XFFs/lRXdbWiDTCGvIzejEdLqkyafnfxfwBAXBlt+pUdG951IR/viNHAx947WMTrtdHVI3BTS8jdsRPXxqQrtby7+ZdSS68/p5lYTWRX2wKdLTdYp05cZtx63HSX+dDBoWKbwCpleEXLOhMJ8Pg1IH2v5dAHWG7MVbcgtSiffz4W75ydW6g7Q81xdI2PcAimvzGgS0mYDRsn+FcHZDfpY3uLItEaQxCJQCeV/k62tGKXbRlKEpCJRqFtEbEFlFFgd2PsPyvY+waykOjjTbxFLzWOJknoFluF9eiPR/9NgRF6fIoSuv2Jkwp0EBHmDbYiNOTH0wgnuSuVnLv+ypf4q+vnBqHHAiaHEtkuuG+XI6VeacSfIS6slrgnDIgVeCgNnYcsVaJF1E41VOmGtQFmpT1EuNZqVC59acu1/9QzN60zmTJ30/UgW29VcLDeHFDtz8FusKG4CYNDqpnxil0FECzWvu1UdQc4iTn0JtvobawGdKCNpsu3Uy00wvY=
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(107886003)(82310400003)(36756003)(8676002)(4326008)(336012)(6486002)(186003)(86362001)(356005)(478600001)(26005)(70206006)(81166007)(6666004)(83380400001)(2906002)(316002)(956004)(70586007)(118246002)(6512007)(5660300002)(2616005)(82740400003)(36860700001)(36736006)(4744005)(8936002)(47076005)(1076003)(6506007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 06:39:07.5153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1590d7e3-1383-4dd2-a988-08d8e90f5da4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4851
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in V3:

Reword the commit message, add "Acked-by: Rob Herring"

LI Qingwu (2):
  dt-bindings: iio: st,st-sensors add IIS2MDC.
  iio:magnetometer: Add Support for ST IIS2MDC

 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 drivers/iio/magnetometer/st_magn.h                       | 1 +
 drivers/iio/magnetometer/st_magn_core.c                  | 1 +
 drivers/iio/magnetometer/st_magn_i2c.c                   | 5 +++++
 drivers/iio/magnetometer/st_magn_spi.c                   | 5 +++++
 5 files changed, 13 insertions(+)

-- 
2.17.1

