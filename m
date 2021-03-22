Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD4343E66
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 11:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCVKwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 06:52:09 -0400
Received: from mail-dm6nam08on2071.outbound.protection.outlook.com ([40.107.102.71]:18941
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhCVKvy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Mar 2021 06:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm8l5hYeh60IcV5j7gxf6Y7vUyRBPTgqezIZUneiwS8lEXxrFhrisV35qyZbKgIMx7rpCwZmha5JG/6YhMuywXi+AbauZQwmesiKiEtB2DPOfphJeCfEUYJdyAEkdylrXOJ607fkJd0JjaECl+zq4h/r2iHIMTxZFwIKBuDvwy8HvC/kZJECpOsJILxJ3BNFxUBKq1QLfmPKR1ex71TA3cpjWebMT9zFtr+oUcKfvmER+uhhtgzk1Y/YmxjzVadGXaliHE26n54avX1wX6v45MpRiIcKPRvDUIJea3pyBi0CUYvLXb6aYtBKDpY7DjDi8AmY6MiR2GYHzm48LHz2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5apH1wMrPyp8D4cDGgM6WerkCM62/cfLRpaU/8xmuE=;
 b=MpJzknPRwbsQ7REqwdaJAQ0Dl4iAq/Z5QBsMXd0HsPtwRcQCE0mhngM/dsgxTDDvtqSZy3as7nS75NWrAOZMn3I4EQV4A9wfFEWOj2XNyqt/H3/VRAWzLAHBI6Dc4Y6o2gtDqHrq+0L3GT0fCZhYrUgzbqw47AgaejmVsN/836V/s6/JJwsK6YxLo8LyeZknD4Tk680Xa0qCNoTCML0NclEE4PSvUcJcCNcdnXFIsQZ0ulaMF6zaOtWwD98jBtlXP7N91eMatxZ9SJzTbGHNRa8k0Ny5XR/j1LxCwqNkAm67sPIuHkTWUVnPiW1QuZVO7qhVlVUjoYP5PQPaqIWAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5apH1wMrPyp8D4cDGgM6WerkCM62/cfLRpaU/8xmuE=;
 b=piU6LHgQFZu9Dja9iWZaugweAmkUs3FeplPs/3V8ax3wWHWWkJCp6iex0r7tQcxPkF84uQItq3cFwvYTPn1+Aj2BtlC/oZpEi8PYugAogfMe0Xi282lET1ACH1hwoNYvj5peMraA5ubrrTz/OfWWLa8z2cYoHbhmWSVK6+10N4g=
Received: from BL1PR13CA0264.namprd13.prod.outlook.com (2603:10b6:208:2ba::29)
 by BYAPR02MB3960.namprd02.prod.outlook.com (2603:10b6:a02:f5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Mon, 22 Mar
 2021 10:51:51 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2ba:cafe::37) by BL1PR13CA0264.outlook.office365.com
 (2603:10b6:208:2ba::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Mon, 22 Mar 2021 10:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Mon, 22 Mar 2021 10:51:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 03:51:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 22 Mar 2021 03:51:27 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.6] (port=46094 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1lOI9e-0007fI-Gf; Mon, 22 Mar 2021 03:51:26 -0700
From:   Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>
CC:     <michal.simek@xilinx.com>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add ti,ina260.yaml
Date:   Mon, 22 Mar 2021 16:20:55 +0530
Message-ID: <20210322105056.30571-2-raviteja.narayanam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322105056.30571-1-raviteja.narayanam@xilinx.com>
References: <20210322105056.30571-1-raviteja.narayanam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ede89a-a6c8-451e-98cd-08d8ed207f7f
X-MS-TrafficTypeDiagnostic: BYAPR02MB3960:
X-Microsoft-Antispam-PRVS: <BYAPR02MB39605D58D1F6F63F230A319DCA659@BYAPR02MB3960.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8LCjyNrwjta7P22tz5uutPc5ujmWSGFyvhljL+NWvKgbC5PxJz+inIhxoQT1IPkGvANIcHHVgy7pLRSOwfI2NN99XWLGKa58SglBuReRBq1Gj/sd2YBXz4Oi5P4F5HYVlWIijzry5NQnixykJo4tkn3sxJQmy7/CSoxKy+x0jJIgj8qyNuojwLpH64TrGrHF978qFqv/4q2HiZ0ti5EFMqDrxXstcUkGmfVgZ4SNRX5MaLB48ylrzurdZp20k1pnt/HPKKrJo2Zv94zx5ord3VK6QsUbdHmIzr7hYl4hI/6CsAfcXMGlZpjhLlwKcB+5qKqW79K+VBCmraf1v2EyTPLUi5Y060z8/1yCxckqfO3oqoJ3b68jxGMGOCjDGycY/fuxJ22pnduDGeZjv7UysFCag9woNJ9TJ1i3k0hZsi80Y9PkBhNBVA0f3GlUd5+VCFNSJVDNrSpSz3HmQYgoldP4eYKL3BJKTvdxSMD1mYs5bDFIIS6SdrcCuTfNebiL4aJQY89Hq0Yz1ahtCfdZw9c5oDQLTrxWHPJQH8tc92E95uCRYDWvCE0ay5Ay6LwkRDIemNttdLoZ5I27zBgpvY9PnlXmb9Sche3oHgL/NPiwrWQLBR967FLePZ1rE6/a+YuGr0uw8k2/s87VpUhZSxnymsl6c+x5x1VONhKXmKhcYjylNazq6pN3pAgrT3ZlgT4HYu8tKl7tp1Q0id6elhlfJpnr1ymeZznC3Tk/JDIxlW0eX/mIl3cOaLfYFiK9/veGcghVgpoA9DHIDv7EQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(336012)(8936002)(426003)(2616005)(44832011)(5660300002)(70586007)(82310400003)(478600001)(8676002)(36860700001)(1076003)(966005)(6666004)(9786002)(36906005)(316002)(7636003)(186003)(110136005)(70206006)(82740400003)(356005)(54906003)(107886003)(7696005)(47076005)(36756003)(4326008)(2906002)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 10:51:50.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ede89a-a6c8-451e-98cd-08d8ed207f7f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3960
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a binding for Texas Instruments INA260 power monitor device.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
---
 .../bindings/iio/adc/ti,ina260.yaml           | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml
new file mode 100644
index 000000000000..97c68188e53d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ina260.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments INA260 power monitor
+
+maintainers:
+  - Raviteja Narayanam <raviteja.narayanam@xilinx.com>
+
+description: |
+  The INA260 is a digital-output, current, power and voltage monitor
+  with an I2C and SMBUS compatible interface with an integrated shunt
+  resistor. It features up to 16 programmable addresses on I2C compatible
+  interface. Datasheet - https://www.ti.com/lit/ds/symlink/ina260.pdf?ts=1608607288391
+
+properties:
+  compatible:
+    enum:
+      - ti,ina260
+
+  reg:
+    description: |
+      The 7-bits long I2c address of the device
+
+  "#io-channel-cells":
+    const: 1
+
+  interrupts:
+    description: |
+      IRQ line for the device
+
+  label:
+    description: |
+      A symbolic name for the device
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ina260@40 {
+        compatible = "ti,ina260";
+        reg = <0x40>;
+        #io-channel-cells = <1>;
+      };
+    };
+...
-- 
2.17.1

