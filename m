Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035C823EF1F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGOi7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 10:38:59 -0400
Received: from mail-db8eur05on2090.outbound.protection.outlook.com ([40.107.20.90]:48321
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgHGOi6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Aug 2020 10:38:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G49qo0ijcnnoJZdTlU8TSFu0Cbm8VamgTgfuZj+PJyp629MP/5znTtpB3C8Ru2D3Byrhot5K02jqUdOAKxuPBVKtqYKdfxNea7S3O6E/n+2prnljDv/VWIKWTSJ+EKQTIrtQ9lArw/XZuokOBVd336yJeinmwL+tJQPuLHW0WbQtucFtXtjHRDEXfvKAuZTcFf4u23hLdstLR3bAJSvcmG7aEH3eDQM/bgDraMJcohtjxlQ4/aS1800piIQAaaT1pveIcPkBN7OKkWp8krpfPYgE8SDW1Wj9rITYh+n5fsQCiXwVtVr9xBrdPZnOirq7/1EU0bposV0zUgeJgumhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfhjvn5IuNHZjE8+obWvBJxwuYixsypLAqlvwrCiwgo=;
 b=I9/X35kjZnhsG6E4h5onfspHCNyxzhNit60Zdc2Pa/ivTkDDxhqZZxViaLVnfxg/EFy4v2gBqRZTFt2iyHxQFNCMhhvX+QkEQLJf5dpFKPieIGDzJKhy48BJwitl0hcRYN9muXAAXYOiTRxeds9a/IjVWm0KnfQviTAIsLlW9Mg3LmTtTO7wmbfvhxhg+IgFkIrZURNVhZdxqvznp7qawFQXNGuDGHoQfMFfMWwbPPrLs1Wd8Vj8E5j95fDY9O2GSISPnWh3Hr69V1HGuA7mLLq5y226jlIVUtbM3nSgJlRq1uurHhnG/Fxdpxc2jF8zA6LP1NbVtj1dKXUrNjLkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfhjvn5IuNHZjE8+obWvBJxwuYixsypLAqlvwrCiwgo=;
 b=UUaGbLatL8eKM+Eqi86VZjvWQTdCPG59U0ifDvbqVVwrfma9+dYtXGn6jbjUn4K/7DJI6RmfXrL1sYevdGgcSpnugr3LWOtpLF42X1mRVx6EI/8TOx4IIvBod1uH/6Byv7OfNvecU7A/3zJvCG0jrybrZACvnR3iMGGqC1s29gw=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB6262.eurprd06.prod.outlook.com (2603:10a6:20b:f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Fri, 7 Aug
 2020 14:38:55 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d%6]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 14:38:55 +0000
References: <86imdu35gs.fsf@norphonic.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v10 2/2] dt-bindings: iio: humidity: Add TI HDC20x0 support
In-reply-to: <86imdu35gs.fsf@norphonic.com>
Date:   Fri, 07 Aug 2020 16:38:53 +0200
Message-ID: <86h7te34hu.fsf@norphonic.com>
Content-Type: text/plain
X-ClientProxiedBy: SV0P279CA0071.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:f10:14::22) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by SV0P279CA0071.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Fri, 7 Aug 2020 14:38:55 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 947bc515-1c43-4ebe-a218-08d83adf9cbe
X-MS-TrafficTypeDiagnostic: AM6PR06MB6262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB6262CAA114526048873AE2F6CA490@AM6PR06MB6262.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rH2aTkbNZ95IyJnp0prW70KZug5yZ0IVpXzwDlc4M/6iQY8N75efTT0I4qaXZ/tKl69He6fhnQ9EswhIh2sJ2nwa4wUkC8Ip3/4AZCiSYjJHVMaoM92s8NnltJKc8CEr/8oicZpHr3ca4aulOk1HRsxe3FZs6xbKVO6IiEHI6zU8hbcQAIxn2WI6wL4aOiGjgeDpFVPT8xk+UmgrDi5eF6g8ri5zH+xK3u8QyP3Qk/EsB0WL5xIWhEKdQ96F8cZU1HcCDg8fGuJnA0hBbtSLUC08L3OvOu8pTME5bMHRTDg/OEuCtyDC9TDwRdjSagaJ6DD3SzoTwgcFvwufFf/qg994duWvYQiAeupdjosq6m7Wzb1SgFAF0LUZoASl0OCmM0ac+0xLc0kg10I1TgikA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39830400003)(376002)(346002)(136003)(366004)(4326008)(54906003)(186003)(966005)(316002)(2616005)(8676002)(52116002)(8936002)(26005)(7696005)(2906002)(16526019)(86362001)(66476007)(66946007)(66556008)(6486002)(5660300002)(508600001)(956004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hnzSfZMy9gs+BJd7DJKqfe3kIxy7SyiomOxz5SBsM0eyKRCucfhfPgj8ba9thMmyIBpN/13xZkDrb3h11Ns5hDGm5GybJuwIw+HxmajnmlbzlUA+6PSs2PMTTzn3oQPoCthT+DGlXXCoMUKle47jv8JdvtnBnlDUp9UhtrXs6WYER4xsPweCjn2PwTl13AWARoIzPwJ09pVajI23xPHHe2+7X83Snw8ROLsvD3HHfzfcl9GYDNeGF7yI/XPvm32toIcoJJq/SVFhHfNqEpTP9XQn7K8w+5NIGLgUNU7dTS7d096DxIU5BIt3iHb/duTqvlvv5elnAwk4ki2T6tRdPigWF3K0kVnlWvDZtDZVO3UZLloLUun1kQg9RrKQxyihDeZH6HLLi5G8l3T2NyTqn4HGc2sMUU9eqT0+jwQOsLG3IL3/2LP5O1Bn+lkYZyKVSWzdRHsI02D4eGXHXekdqEglOO5hKg7k19oUzI9j8ce1RF6eeePR4w5flIlYKGxa9lgdijC0bcFHg4DYE9AX8e2/9rX7wdLBLXXYeoXrMUhbT82z4ez63rvb4GQ6o2UpCeNkOw5WfUyTUqB6saMPKN7Uav/lkCLW71OHVD9ICfNpTmhTUav/wnIZz0bvT5zHr1nofKd4q50cwqlF71u2cQ==
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947bc515-1c43-4ebe-a218-08d83adf9cbe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 14:38:55.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZwzoNxQnB3UgPLXdluIUq7WojqPn4X9wAasDreqWEda1NnHui6v0rva4asdd7hSLH490A4LZmE3s3ak/MyyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB6262
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for HDC2010/HDC2080 family of humidity and
temperature sensors.

Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

No changes since v9.

Changes since v8:
- document the use of reg
- change the license terms to GPL-2.0-only or BSD-2-clause

diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
--- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	2020-07-10 13:08:46.818076734 +0200
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/ti,hdc2010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDC2010/HDC2080 humidity and temperature iio sensors
+
+maintainers:
+  - Eugene Zaikonnikov <ez@norophonic.com>
+
+description: |
+  Relative humidity and tempereature sensors on I2C bus
+
+  Datasheets are available at:
+    http://www.ti.com/product/HDC2010/datasheet
+    http://www.ti.com/product/HDC2080/datasheet
+
+properties:
+  compatible:
+    enum:
+      - ti,hdc2010
+      - ti,hdc2080
+
+  vdd-supply:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      humidity@40 {
+          compatible = "ti,hdc2010";
+          reg = <0x40>;
+      };
+    };
