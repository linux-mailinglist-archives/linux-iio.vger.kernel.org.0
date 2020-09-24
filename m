Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DA5277AD9
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIXU57 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 16:57:59 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:62198 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725208AbgIXU57 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 16:57:59 -0400
X-Greylist: delayed 3895 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 16:57:59 EDT
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08OJiOD8028609;
        Thu, 24 Sep 2020 14:52:46 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00010702.pphosted.com with ESMTP id 33nfgtqwcy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 14:52:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN5Yvv1ZtaVSgyvHDLVoP6uqbuW8TgiLGLc2kKX/PmpiqklBhk0V894UUxm+s2KPelP1LZuXcJl8Aox20+SJrmlHkxGWxjhnPwwYS+vy6MaEU4L4jy9TFsNGdF7bIGyq6keo3F9pw0utQxffl+diIJeQIsL+YKxfaNv9HB9JaOFnU9jlnUz0aN3Yupjb8H3fJ8Df1fnEZRfzOUVd5GZp+3ecaES/KbY7s3kWEuETP+TxpFgDR/Wi0QntqfMchJUQk0VKUst25rJqJbGP6BuCF3C0JHo/deb9QplMP6z9a9IUjY6yck+CqV2OH2CMSnXoliGp2pmBP0BRF25517wdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGuSQrakTr0hux0wqDEEy+l0798btmiAouoN3RqTDpo=;
 b=cauJEqP4Xa0TKKrAbozdjLdQJt8/Alq8FlTx10NpjejoGM/0AQ1GXi9P8PFOt7HNsGU+faFGN7DvTC+MxH39oney8AZ1YLRnQqBXi1tJ4E2ECTJdp0r7HeSzU+7VQ0P/qABN+rnzBXpoQmZ5nIElhG/k4vQVw7SEYiOZYbSjFqj/B3lVqlDKIP5sjp3VlcH1JeBzzMmwZO94v8raNXbUvDPqLLrPDR37osbbmwBcpmLJHNWQFLOJ8NyYGR9iVqF4u1WYS6dxsPMwyVMQ5zHPpRq4yiy6mSbHef1yLAGVt9QuB6sn8MHyuIzanKKa8PcdrDqQzJTC0lT/L+4mxu8Q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGuSQrakTr0hux0wqDEEy+l0798btmiAouoN3RqTDpo=;
 b=OEfdlEmmSBjB3mVF/0BUfUATrrSYJuq2LhfcjilfR0xvafXDwCVdZfLkn1zbDjueQ4Z/dsfunMxwhRN3TDA0KoWJueX/IkkzvAyv6lu4ocjaWZc+yhrBi0dFy4RgcFUhdLEq/O0pdtCafOe6PbKacSzuRGS+OAqZOluXixnWLwc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3648.namprd04.prod.outlook.com
 (2603:10b6:803:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Thu, 24 Sep
 2020 19:52:42 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3391.023; Thu, 24 Sep 2020
 19:52:42 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Auchter <michael.auchter@ni.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: iio: dac: ad5686: add binding
Date:   Thu, 24 Sep 2020 14:52:14 -0500
Message-Id: <20200924195215.49443-3-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200924195215.49443-1-michael.auchter@ni.com>
References: <20200924195215.49443-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.natinst.com (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 19:52:40 +0000
X-Mailer: git-send-email 2.25.4
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7112c55-d08b-473b-8c28-08d860c3653a
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3648376CF00C55939895C8BE87390@SN4PR0401MB3648.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAV0urQyCckPZd9kDEupvvKNJuF5X/WsP+rp+O1paMMNjzwv/R2GCb6E8Yy7PLcj0YpmNw1HQYN/G/sCgFlgfaYgyEbuTJn51SIcAybSvD3lsZBzoTZoTqHViHET1QAwU+KdKUycFS/hBI7y0g3jn1RmBdA0SjAtdGlBmlxKMJYaoT2yRpJttjBtqHkOjGahezs34MjMbdW+kShrbVayxTDDuAOAV5K93WItBu6EV3s1g4AW32sxQdtO477/yYtnrQDRN25T/TuNeSY7Ye23TUqW9w7h4E1iFN1nk5BTEU9MIq+yTUE3bn+KWrn6Aezxi4V+mn2LKy+zhm/N4D8XyXR3m4uqc/XbCiRbDm3EeUuiHcIE92sSKModNYG8JTjlR35h963z+JiRvydtNOD7mUhI/QO0ajg4h5TPcteOL7o7QbTq4gaWMn98kSzzxVk7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(186003)(8676002)(8936002)(1076003)(5660300002)(44832011)(4326008)(316002)(6512007)(66476007)(66946007)(7049001)(6486002)(66556008)(6666004)(110136005)(478600001)(2906002)(16526019)(2616005)(86362001)(6506007)(52116002)(36756003)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: L5bHpFMl9/CE3Tc8lSMvPJC19jdzr5b8ButxpdLhApod8I0hOskeXOFwQ+QuhWP9sgSs6tDNJIq3yAdWUKxJaZKj9K8gm1/RWu4yEtzM25OjyN0pZ9QzAoc8LDfS/IV8BuHmmjScUolk9a7RDkHNEEuEVx2ESJmszJNTsO2g3QRWvb23apPwAYw1SQrraYSma+wksfOijsdL5OZAZrK9g09/otnJGgMKF/txGZi4il57Khe3I2Kd/RnShtErVFQZxnC0MebB7ZT49C8uWFrGjJAtDjO9vmjleFIw3iE0bPMuAMHGWOyFAYVu6Tq/8F4QrDzsO3akc3O45ALWnH+nts9LW73tIAIeRsg/1hLplhLjqgGnagmyO9wXypM/gDjRuhu8jpeCqkl3gBMrsuNZ+ARBH8NBoYo11xhP1I6B5Mp5qoX+Fjv2YlLAwYa8e4CSl/kAouqGlBaFpdB+tEy21VloezgRWIDppw0qNjtbDBJKpSTfEO0Tl4+seU7lUXM7EC6lV7y+i2tuUTbpWPHdJLl2vrrGi65gJbmbfT9z4UoGrzt2a5ARX+ZtMy6kAu5T4pZk2MreYVGwA3NULKrDS/nXWjplHF843q4OAjuJ6l7QJJkOLwxUYIxc6gFtPmiCboav+gBUVHkqjvdvp1gCUiXOv0Qcnmj+eHt5YxrgIEAuQBPAEHiuIeRQESqx1HlYyoxVELVmEBPcyvcy7GpkZw==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7112c55-d08b-473b-8c28-08d860c3653a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:52:40.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ehqun59rg2HbagvlUZaTL2IrV5zRRlrQ15M4ySyXvciAOKl0x3obP84yArKKKPdFU8H61ocOMJEuvJ+OdWbkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3648
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_14:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240143
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a binding for AD5686

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
Changes since v1:
- Keep supported device sorted
- fix adc -> dac typo in schema path
since v2:
- drop address-cells and size-cells from binding doc
- add "additionalProperties: false"
- end with ...

 .../bindings/iio/dac/adi,ad5686.yaml          | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
new file mode 100644
index 000000000000..8065228e5df8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -0,0 +1,57 @@
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
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
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
+...
-- 
2.25.4

