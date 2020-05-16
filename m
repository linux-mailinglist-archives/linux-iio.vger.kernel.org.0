Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2691D5DE3
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 04:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgEPC1J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 22:27:09 -0400
Received: from mail-bn8nam11olkn2034.outbound.protection.outlook.com ([40.92.20.34]:30556
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbgEPC1I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 May 2020 22:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXv5PWSsPzoPoWk9XjwihKO46ns1CIiB7DWDzpPrWEeB7/+8DehZpBpS0Qnvl7waz86mjcyEejfq9EszAUE47nhtm0FKJcoiWiEm06tECTVXNGMYcsy6ocRUS6jiBh2TExaK7yB7DpLtcTtrWA3YGOoCj34CWP/7OC+JBDNG1elFWRrRyBfm9NLWIEW45gdOHVP0Ftq8xUFLNtJnsXviNe3FrYFZB+x2rzfkAkIgaXhfyHHLJ0woM0YaQzFWYfh/vDoH16t43wen6wqEayPOz7F828CplC5mr5czBjx7BKiPFEseSHxSEoOVfUYpH9KXmbxIUsXh11e/do8roIKK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxFuj5KU11ViVvMqI47ymWkaSuLf06hZHDQSKEk3ClU=;
 b=RR5e83bxo679bKi+OaismIOl/z8Fz3Huu16T/MzBr8HXjMqSoCxFR0TnATRhLw9pUSoZvUBBmPW+I5I624mIkYBuA6NRZ96xCV0mkt2GQJ+dudHAWyUDOwezvDHjizVbm7YJelw0QnfF4xfCEagIH5euezDQdR4BGgB5e/b1lFFe6NLOBl2aUJ1+VCa6iNkKFiAOqLNZPkMjzWIAnHjDYNGCSobnzTex0yLxz9C25BQY8zN1YfwJFIkGE2UJCBgVDLXV53EVh14JaMDWvXX72vJaAYlqpVJ6vGZAipQLuysWihGXd840sy4F0MVHW+O9rIrHDepI4VdtJFufbp/+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::4a) by
 DM6NAM11HT082.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::295)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sat, 16 May
 2020 02:27:06 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT026.mail.protection.outlook.com
 (2a01:111:e400:fc4d::161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sat, 16 May 2020 02:27:06 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:74A74E2C999E9C9AC04283234609FE53F567BE6EE4F6F13BC13834EED6F78B15;UpperCasedChecksum:D71D1321451C5CF711848FEE41749C4470742A43E2B765A51CC7ACE37B0BA1A2;SizeAsReceived:7839;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 02:27:06 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linus.walleij@linaro.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add binding for current-from-voltage
Date:   Fri, 15 May 2020 19:26:18 -0700
Message-ID: <BN6PR04MB06600A3AFE160C6E07BF5B2CA3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516022619.30779-1-xc-racer2@live.ca>
References: <20200516022619.30779-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:301:4c::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200516022619.30779-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR15CA0057.namprd15.prod.outlook.com (2603:10b6:301:4c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Sat, 16 May 2020 02:27:04 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200516022619.30779-2-xc-racer2@live.ca>
X-TMN:  [SdY10yUZSsfjdaLmlVjMOEx1jaIPY4zOntK4aS9KuwYVZYVgigM8k1IacgljYtus]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d0c99099-6306-4704-41d0-08d7f940a054
X-MS-TrafficTypeDiagnostic: DM6NAM11HT082:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wHW200IMqpp4CZmna6+FD5N21AOTm93v9/w4szsoCLOqY0E+tfLQRVc0UxdyHhp4dexbfJOemTVM838benzDLgPJFUzGUb0/TyWnNhMCoCe+JUTMxZWbkECzjP8r1WFE1Ykjs+vuILyC/fmw0cuXDg+mlvoqAPFIJcozsH9vRWBRHPKxFH+h98tujDQuocpHig0Tw2Wh+Nc8IeBpXMCCdvL4u2FPUBXDCy/GV2jTeIYWJF6JrlQQWSnz6o5Ne3n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: WXCpau3bIv6AR92Gs8Ercbj29j9FevqjvVvDSXuQppTARsomW4CEE94Kv58DVGBtPRisJ7z1X+ZPfSDoaOvg8WTGC6VQ6OK4S4Dc6/krLBENwAsEDg21IWtoEBeM9qkN2PgiTx9GqjA3r+Gzy6zF45Baah216MjmR5GxfGm8/PT/1jYH+Zu5sIXblKLo/ZakNsODaaNZRsbzvDMXBCqwMA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c99099-6306-4704-41d0-08d7f940a054
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 02:27:06.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices may require a current adc, but only have a voltage
ADC onboard.  In order to read the current, they have a resistor
connected to the ADC.  Add bindings for this possibility.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 .../iio/adc/linux,current-from-voltage.yaml   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml b/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
new file mode 100644
index 000000000000..385d317607c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/linux,current-from-voltage.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Current ADC from voltage ADC and resistor
+
+maintainers:
+  - Jonathan Bakker <xc-racer2@live.ca>
+
+properties:
+  compatible:
+    const: linux,current-from-voltage
+
+  io-channel-names:
+    const: adc
+
+  io-channels:
+    maxItems: 1
+    description: Voltage ADC channel
+
+  linux,resistor-ohms:
+    description: Strength of resistor connected to voltage ADC
+
+  "#io-channel-cells":
+    const: 0
+
+required:
+  - compatible
+  - io-channel-names
+  - io-channels
+  - linux,resistor-ohms
+  - "#io-channel-cells"
+
+examples:
+  - |
+    current-from-voltage {
+      compatible = "linux,current-from-voltage";
+      io-channel-names = "adc";
+      io-channels = <&adc 9>;
+      linux,resistor-ohms = <47>;
+      #io-channel-cells = <0>;
+      io-channel-ranges;
+    };
+
+...
-- 
2.20.1

