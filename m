Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9691274863
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 20:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIVSln (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 14:41:43 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:25488 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726662AbgIVSll (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 14:41:41 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08MITEdo012681;
        Tue, 22 Sep 2020 13:41:23 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00010702.pphosted.com with ESMTP id 33ne10gtyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 13:41:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpvipjRR3o8MkPspcsWGhsXWVDVHHTnS1k1aPL9MVErwP2kaSu4qoOUU7WNw6QefjAmieYPMRYvh1rbmWfecQ0hHlOPcTtKNNao/GM3p1e0IhJqrU2aenxwsMoBlUMbMpm/qw6Q24VUkgNnPITRVdPRfsygZDPLxaW//SEG2oGOrrXRYuYVLGBGRUDQUqFVcCDeXKo1fbJ4fXiamg7iQDH/8JJkjU77AJ+IdbwRWGwB5hXISuvlsKFQpRyJ2xwlWOhYhQ4iphc/ggxEeA2+GhcZE10OOCJ3F9NVOKWn3RP1WisD/0G2OhHwXVeGln8w0nG1zV4BFXKPtKbLIkSnHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqpilKEkL8lh151YQ4fjOcwTx0bUvTNC5Tgm5SF2pWY=;
 b=AvVXlUq5/l2A9TtP2aAzndlUyWQf0HMZj3tzVJ5xN+If/lPySwib717WenNl6tphhKHrkCkmMlvDRqqWhvMrl7e6doGAwdVeiY0y75SRwvgjC5p2cDiANKY1abiC1IXFIHI0aZwDmQ6Yqe4ZRgzCAbdjAhiaoCA/5hw/N1Yxy+WP3QJ6taZBq4iCtINo9omMEBwg8QBcReBpnoBELE/bBvm9CO+4+2FGmLp+MAeYPeQM9DkEnddDptaBN2hM7634Vo0kiK6MRKlXI2VcRApoWM+UQWJk47R0HTf5LN5nAZhzGYQGKCcNbTEZITMfZuRtK/f7LC+ClRVVuoOyBqdXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqpilKEkL8lh151YQ4fjOcwTx0bUvTNC5Tgm5SF2pWY=;
 b=szRz1islj0a496qkLv4jUbQT9G4dbw5p5tP07bicfoTWD1VRWjf00QBSu1u3KzBLb/BjE6tt0T0yw/842QXx3HGfSMpKNxuyTPrDijT0F6Ybc5KJ+GnG/RXfk0FkjcviBKNlcXkR11449Ot7S8AToBb7l5CuMSveucHo46OmXjw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4909.namprd04.prod.outlook.com
 (2603:10b6:805:95::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 18:41:21 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3391.023; Tue, 22 Sep 2020
 18:41:21 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Auchter <michael.auchter@ni.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: iio: dac: ad5686: add binding
Date:   Tue, 22 Sep 2020 13:40:12 -0500
Message-Id: <20200922184012.557622-3-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922184012.557622-1-michael.auchter@ni.com>
References: <20200922184012.557622-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 22 Sep 2020 18:41:21 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50a44cf8-8ba7-4ba5-2d83-08d85f2719cc
X-MS-TrafficTypeDiagnostic: SN6PR04MB4909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB4909BEF5EA2C4FEE3F9A71C2873B0@SN6PR04MB4909.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DSLV0o6aSduN9e1480+huzul4qfGXwAQzKCIXBJ4H8GST045Y+0LOi/4np4MUagFG1hmk1L2NM57410B15uBCbgC0FmpIqDRQ9RLWo2Ip777W/UWRokTcKLLhnMVoMyfQHlT+DpSco4CDLJUWm/5dU0m4x4XQharNlSkVzBRdp4mv7FgZddGUYTlIAa/NGssbcdJ5G59b7C+/O/nfwQj5t5tvHV4I17aMohQqv3CLJBsebnLCONbd5LAvpMHph4K7caDtyEzSoUkKHn5Nk7h/cnwoMYKGA/PxvpG6CNinsP/kCrx3ht1O25SkCLhHqd6kal51TGuzSo4Pg1MjywsYN8GAxDGTwLY1GD85bS2cRdWo+MbMNR3aCOoOTfUMcQlJhJ3lG2KB3AAbUTfPl49ow6iSgJUtEFIUVKLLBe1CLwknupr4sVv31ZnPEOuMLovzM9NzHz/DIIgcO5KSFA+jJ5z+m2zfeV49xZB9JF5wVplWxv+yyr3Va8+5etR819
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(346002)(376002)(366004)(52116002)(66946007)(6512007)(44832011)(66556008)(478600001)(966005)(186003)(6486002)(5660300002)(6666004)(2616005)(8676002)(2906002)(7049001)(16526019)(4326008)(36756003)(6506007)(66476007)(8936002)(86362001)(69590400008)(1076003)(110136005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vJEF88BFqhoYEG7S1dISleMnrUcGN/9rZ9LHANr7BdXDkgyzdVDmbMYK/JTJhQ5U/7CCFu3FdOd5TitaluTlsMBG0giNqSnFU2MXXKguvn/4P/qgFzrrT4Nt1vcLtxF8pbsrt4JDTSLNrWMUQ4FojEidbD5KfApNuHXxt9MGKP3P83153oqO7ljn9xpwXs0GBFaLkuGLq8+kFP7c2L6ae3aSL1wLvB7DD490UPRGOpUjfZaDNTHIlmaMG+3IxTqT+ztsM50gzTqbu0ztC1rBDrVRhhqfEEkeorLK7dpiVXL02yL3TqSukNNDq8U8NPNfNlcdMnM3k1gIYt6JAUxRtmtJkJfyBtp1FJKeibaqt0FwQnTgDgbFooLnQb/Fxq3SfXIrN0oio/eVj+CuXsrP0agDO9b3EJLicprBAAT1yKuNB+VHSlBX9JZAPdX96xZ1a4Xxtzo2tm+XkfenTd4zoZC2ZcSqODH9H/238PPtauz7f8tQxVsCe/8yfd/wOgPDs2beZvmqbRBRDR+XAv5Olgo+3cI15fS1y8WyKAIYbOEXPm962BKodulGxsQj8MlmXw4SeVtQZVpKouqNvghkZwMXneZCclT/LBkVKUiKNiSzdwk8rBRXSiC3VRrkdgqnXpIkljSlwVCgxtJKSwfLjJ+pCBAVIKu2ADbrXS5iNUWM+5QVfbunupgfWuSs3yXk8zBqinI0ChAnFGmh52LX2A==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a44cf8-8ba7-4ba5-2d83-08d85f2719cc
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 18:41:21.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GG7e28/cwaVUzb1pZ0t4qTO26aZGjaTfzL8bz40WdbT5vKaQHSbW63X5iV0df7MZW23D2ws5I6EM7e6oSiVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_17:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 phishscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009220144
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a binding for AD5686

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
Changes since v1:
- Keep supported device sorted
- fix adc -> dac type in schema path

 .../bindings/iio/dac/adi,ad5686.yaml          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
new file mode 100644
index 000000000000..9ce76d75f31b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5686 and similar multi-channel DACs
+
+maintainers:
+  - Michael Auchter <michael.auchter@ni.com>
+
+description: |
+  Binding for Analog Devices AD5686 and similar multi-channel DACs
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5311r
+      - adi,ad5338r
+      - adi,ad5671r
+      - adi,ad5675r
+      - adi,ad5691r
+      - adi,ad5692r
+      - adi,ad5693
+      - adi,ad5693r
+      - adi,ad5694
+      - adi,ad5694r
+      - adi,ad5695r
+      - adi,ad5696
+      - adi,ad5696r
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: |
+      The regulator supply for DAC reference voltage.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad5686: dac@0 {
+        compatible = "adi,ad5686";
+        reg = <0>;
+        vcc-supply = <&dac_vref>;
+      };
+    };
+
-- 
2.25.1

