Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A261D336A5F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 04:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCKDGg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 22:06:36 -0500
Received: from mail-eopbgr60114.outbound.protection.outlook.com ([40.107.6.114]:33497
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229803AbhCKDGI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Mar 2021 22:06:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlfK5xo1V7BWpdrXEAXFNDmdCY1mUzFj34kJQLbmUMN9z+P7JeGBh+lZj2LJ6MCgAmmH67hzcr3aYvKEqpxaWbzqZv9DW2s8vi6FPpRgoIZyJV+lNny7E4yNDDIvGPldR/Qvadqomd3CRD2EBd/4Ij2J4yTHgb3Dbrvtb/OTAapPubdejEGsSdhSbW1xU+7QuV9GSWMHn6D7YBrCdFAEvVEndkgMu9diXk/lt+9DUoklPERg9MYtbxGXIksrYyi+zv/FGdekACjVzdoLpYRG4Es0COJiRQ6MB8k990/ZFYI7kIkC+TsdobI+tfZfhKpc6zqQiaJzVUT4CkZL1vn0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2ZtaVVrHEls8fv3W65kFdm0Vl8liSTqkMEOhY6f14M=;
 b=USw6SHSRpS9X/8s2gTd66m36GvYjZkwDzFAMcn7HsmbPAReO9XMR53KOq/woM+lxV6agobkxJH8vL5RWuJAi1S79Kzz+vxu+BmHO54EM+xg1tBwz4KZUzBCjVzWtQw7eU1Ew0I4bTEt6BtpGVaqLA0yoeL7qnoI2MVpUWEdCkWX6AqQjrmlI0KoyHQEn/XimAfHWgsngD0/CF23hANrNv4So9KzcrjFDW310TDsshNq6NQIHtvbaYO1yPcIhiRPenoVTNmh5VqQCg4VM2S1Qz4xFpB2HTJXTZJJohXh3IXjIt/1Fy5mw1l1lRZk3BAzKvKBsjHl9xROd8ljjm/58BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2ZtaVVrHEls8fv3W65kFdm0Vl8liSTqkMEOhY6f14M=;
 b=sxS3c6GsOVOLNZs+Yq32k6a0ZkrUm4AgwT8Z/wwsSjDnjNfxlFCiHN1INC2Zxoet8ZURdrlPCNvgsPFSiMQowrI5DDbzXJKtwIkIGY/zuXvP1CcprqBAi4QtG3RbuJz2SdNqjIrltVCneDWZeggPfR7+evD7+XNgkrjCNHiC3dg=
Received: from AM7PR03CA0020.eurprd03.prod.outlook.com (2603:10a6:20b:130::30)
 by AM5PR0601MB2657.eurprd06.prod.outlook.com (2603:10a6:203:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Thu, 11 Mar
 2021 03:06:03 +0000
Received: from AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::60) by AM7PR03CA0020.outlook.office365.com
 (2603:10a6:20b:130::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 11 Mar 2021 03:06:03 +0000
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
 15.20.3933.31 via Frontend Transport; Thu, 11 Mar 2021 03:06:02 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V2 0/2] Add support for ST magnetometer IIS2MDC
Date:   Thu, 11 Mar 2021 03:05:52 +0000
Message-Id: <20210311030554.6428-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6460603a-0522-463f-6c23-08d8e43a9aa7
X-MS-TrafficTypeDiagnostic: AM5PR0601MB2657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0601MB2657DED946063935648F3E90D7909@AM5PR0601MB2657.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1WAFfPx27ayjB9W6NkRxZBsqvEu2Kw2/NwMOQbqImeCPaZG3MkIUeMrbNPc5UGQn4kig14fbwz2ujcDMxPQ0Wr5iEjps8+I653E/BRyXU5hZuD9SEj3k0h/sZgjvUVi1mNj+MHwaVEV5I6nHI6NjiMC+6kRee8+jayMN2p41/dRzynnMGFDebl31tnmNMS/ZAxyRUbSh/fETYn7KnodWekqQ0KcimXOxZbLbm3TtKhEhGQL8E1BodXBawo1fszZ3Mr/ZKEc9HK7yd/VtsXie6O+lOUYFT4eZfkeGGXuAhAWRD43mGaDxa7Yqh1XzVIjRn4mUrQzmXoAOmZTmg+tKxesE72uzrkJfRf7KGM1zJhEmuCwTAgj0yHb1xp/rMcevh9EcGMkQJJqnO2KWSUfVHaCuy9VvVdXcj9fD0cZdXXOREuqEYi7yKlR1qY6IuZ8IdcVy+RKsgcEWDVsv21qPY9hsQBbfWDNZ4hNclvey1hETuJWnbQusYK5FsPEF634rTa/JetVhWvvMqUoDPZACL03hRJyFJ48elAEU+d9fgupHeZzpYp4ZUqk62yXcaEt6Ao2Gbq+qA2l45vH6Nz9b71MpmZLIeAH9av/J9vuk5Y9RQBZgyRxI5UDkwcQtPeFlc/ErTo9l48u6mQGY1t6rBu0uV4jXHxl9CUEUbvjEZn9HaTFXjHLvp++PyviO7gE
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(26005)(86362001)(186003)(118246002)(70586007)(70206006)(47076005)(6512007)(6666004)(478600001)(6486002)(4744005)(5660300002)(4326008)(1076003)(107886003)(8676002)(34020700004)(36860700001)(356005)(82740400003)(82310400003)(81166007)(2616005)(956004)(336012)(2906002)(6506007)(36756003)(316002)(36736006)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 03:06:02.4435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6460603a-0522-463f-6c23-08d8e43a9aa7
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0601MB2657
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in V2:

Extend the exist st_magn* to support IIS2MDC, instead of adding a new
driver.


LI Qingwu (2):
  dt-bindings: iio: st,st-sensors add IIS2MDC.
  iio:magnetometer: Add Support for ST IIS2MDC

 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 drivers/iio/magnetometer/st_magn.h                       | 2 ++
 drivers/iio/magnetometer/st_magn_core.c                  | 1 +
 drivers/iio/magnetometer/st_magn_i2c.c                   | 5 +++++
 drivers/iio/magnetometer/st_magn_spi.c                   | 5 +++++
 5 files changed, 14 insertions(+)

-- 
2.17.1

