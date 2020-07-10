Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37AB21B4E5
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jul 2020 14:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgGJMVG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jul 2020 08:21:06 -0400
Received: from mail-eopbgr10107.outbound.protection.outlook.com ([40.107.1.107]:57827
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbgGJMVF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 10 Jul 2020 08:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZIknXnZHZ8/jBwOm8HnuqBzOI31RzRvroi0GcUMipiBN2eZw3MXXYfYZzio/dXnwf3iPcCDjhNbiWzCQfLmQ/7snpjDIoxCblb9UzeKBcizkGxkH1vaLrwSqHpvS3WjxDZ/HymTAcoj2wnNOerw5FdHPC+Ue8KqpKNpLs+9SIKQrSzeDccSKmMfQ1zvx/dJafY6ueZBedd24oyIBcBLA+TmYe39gTyovc0HWfRYo/zbc/0O0Mv6FsU9eHAASNKCuUxFBmP81piLtyiKaxDKk8jjqC8WGgB1Jy04rYjxrECajlZ2OUoWLoh/CmNd6RGGwbfuNjEaFHufoaoZ0FY0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa/fsf0GrV1QsW3pLLNCVCmpi4HZyo6GvefOfR5UN3U=;
 b=HqOozpDLrAwK2tRVyaYHnip3O1dpZQLhxKj0WrbhsEdvbOiISPf37ZSBx4W+JrlQPlkaJzMF7tsDkaP3QEjcv0noP8uKx39uEiDKCW0cC5uZfZ5H+wYZFAg+qMclEKGQ/Apo9Pnte2u7DVlW18C2pP9Ua0ylpUdFbsyLr2iL3rVkx0OxbsU0iv1Z3hb+yyji0BqRijHK4krA/0+yCL0da69Hz9s5jmFDPlRu19xdcehXSrkEqzNlPo7TQbZCwclB/do9nlekdujecgZZIcXkOSo3GHYac10aVCeEXJgdabpWioW8tB+aS7vGTMtOeQ27IopMTRPSIAPcC3YUyhxSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa/fsf0GrV1QsW3pLLNCVCmpi4HZyo6GvefOfR5UN3U=;
 b=oGH51ZspdXdmRBotvnwKZRaUQdNpznsqyf5MK0SsfENmGUAVO7vxSi6xcBtoYA4UchlAjrpYHmT8/0wImFqW7lho5tsedHa0zHzARNYYK0Pc7/DVA2m2Zqq5UuneWaBK1bKqRAikPYDQqnX0jxxejr+lhgcmDjGRee+6iHI/jzk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR0602MB3399.eurprd06.prod.outlook.com (2603:10a6:209:c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 12:21:00 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::98d7:2b02:1f27:e8e0]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::98d7:2b02:1f27:e8e0%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 12:21:00 +0000
References: <86d053d1re.fsf@norphonic.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v9 2/2] dt-bindings: iio: humidity: Add TI HDC20x0 support
In-reply-to: <86d053d1re.fsf@norphonic.com>
Date:   Fri, 10 Jul 2020 14:20:58 +0200
Message-ID: <86blknd0id.fsf@norphonic.com>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: OL1P279CA0048.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::17) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by OL1P279CA0048.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 12:20:59 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844f3b55-b283-4081-83b5-08d824cbb4d8
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0602MB33990D77B910BF4168BAB99CCA650@AM6PR0602MB3399.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJaOsBMKLnDnyPcQnzJs7fW3kiHwDGy0Oi9uv6DuCKD/5ZCQ1pN6CyXt0WAuiewDOUwsKnFNJjkgoo8GGMhRhTZN0pk2WD+92e75Cuj1ZaMqRoxjMXU3KkEDRM+R9No02APyuPl0E9GwDHqqUSBwaD6LrWh9789tNekHH9HzOTmhod2shbFoNjm/C823umQts8NuAjJJQF+LUtM9D/GTqcDC2cIs+qosLmVwdyHUTp1EbnBAgJMslSp/25H6SD9+sshSZxCa104ATsi0Ilu+IQ+DzXPH7x51UfibkFxgDeXUSKyDoTdNvUoOqdneKXg7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(396003)(376002)(346002)(136003)(366004)(86362001)(36756003)(7696005)(5660300002)(956004)(2616005)(66556008)(66476007)(66616009)(8676002)(966005)(508600001)(2906002)(16526019)(4326008)(186003)(316002)(6486002)(26005)(52116002)(54906003)(66946007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hlDuc5MdrTIJCndwR0m+C3K1o2ATtHwul4dVwCfltmdmn85EZUov6fXsILwAgJOV1fPEdy4vfpYETRBrVwIOlfUYkrvgVtWFRpk+48rDTuLLTZ5fbelKgET4X0VMq2S0APMKvC3a1tSkff53NQAhFvudDkjI/aLlr24fCfYSF5oYPjHZuBIVvkoqTTXmYI/qqvCktzkbEaFZu7+1D0MBck305AhjBlVgxK2taDvCnRNDfh4JGIcH6iFSq307ZHWnaRCCt/N9CexK3VuK2VQiheWZz7/SjYnQqe2uSRGelYMH5KhqlNtxaruKfn//Lr1ylJ4a1ealoLlBfMaHVUdLkszdg6ERz1XcGPzjXTmABBdCnTCPPGSM7A3X0jP0kLFb+YDLMO4aGon8LKscnvLbcQQPndvJM8bujFIZehmQhwNsRI8hGLsmI+Ahez1nI7zMsdeQIuSHa/6zQm+3BNdeTbqP+TpYGWGIQOLPZ3zcQ5U=
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844f3b55-b283-4081-83b5-08d824cbb4d8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 12:21:00.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS1nJGGmS7KDJZ+ND2TQNovuSHt4wZh5T+Plae+yV9utUn7Zrr6F8/cVoOoteHLO86JBsBBA41i23iyUymd+eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3399
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-=-=
Content-Type: text/plain

Add device tree bindings for HDC2010/HDC2080 family of humidity and
temperature sensors.

Changes from v8:
- document the use of reg
- change the license terms to GPL-2.0-only

Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=iio-hdc2010-driver-docs.patch

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

--=-=-=--
