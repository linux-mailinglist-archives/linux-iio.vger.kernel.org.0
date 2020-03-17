Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6467188813
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 15:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCQOwC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 10:52:02 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:55798 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgCQOwC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 10:52:02 -0400
X-Greylist: delayed 3274 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 10:52:02 EDT
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HEp6LF007670;
        Tue, 17 Mar 2020 09:51:39 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00010702.pphosted.com with ESMTP id 2yrvsv1p9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 09:51:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzux5D0U9tW6s7scOnfUrCzicowYE/VSmhd+CisoTAxoGt1WWJm5p6rCnCsuC/mx6VYje5dCQTQtpjb3YpgjwPkUbdxvPp+FRPGG/smM3U8hujOeuThJDVpQ3Zs9JJ5XUrRgPJxdd/3kciIlsEJ3e+S2Mb8lsKhCAOqIN6OQHYM/ddwhEsmk+VYrJg//1VAXv6HgAvO8PsvxBbSxSYjZ3KqzXnPdcI2P+lbCX/Qn9mGyjG6jUKT1aJU4cwo4SIc64Kj3X3cQriotSyW+jYbvEYctSDsMUY7IUZaY3IQ0sW03otmZpuygwA+0SwJWJzPgMeXmzGFPKeAhclQ2JE6ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTc1M08uh4ajhnLJSGyCpHmDMmV/ESEmtH376gDBt14=;
 b=CfNsNUDQqVrV3k7AzHcsBSTon49p0Cn8P1RmwABJu5SoNE8GYVzfawpBfMgfuM9ZZKu76NAqr1pXRXPZZPDIqdyaGcwoBLj5HP5QWWnESOhtceVYewqjib/IqM9FzDJzCCh3WrwWdkrc62OoBkkg56HWlnWAKbiAX+20WrAwLClu6VNusV1+yPImSXezsV8K26m39pn/CBT010kp5RL/BjyXs2JUfgvP1GmEbfk2NHHTiecsxB79f/wUyF6Gu2nndwLrVWHV2ZaJZw4kfCEDnu5lW6ESJBvk5y4NWHie6QpIlitn2vHoPkqKWVtG5IbOJlyAj0zKYfB+OrGJpBjlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTc1M08uh4ajhnLJSGyCpHmDMmV/ESEmtH376gDBt14=;
 b=iAehwnDfChKECjAvlp9kCcY8s4CbPrviolwj++uiD5mWwLbcrpzVyJMdC6GOJDbZFibi+rER/Me3d2M0onJ7TdyDLpXToct7d2PA/4fquxItMP6wYrxt2f0thMtxTlKBtkS/npLY/WFFgpfyg6N6KdqSB064dcYkRdT+XJxA/jc=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3519.namprd04.prod.outlook.com
 (2603:10b6:803:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 17 Mar
 2020 14:51:37 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4%5]) with mapi id 15.20.2793.023; Tue, 17 Mar 2020
 14:51:37 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: ad7291: add binding
Date:   Tue, 17 Mar 2020 09:51:13 -0500
Message-Id: <20200317145113.12413-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317145113.12413-1-michael.auchter@ni.com>
References: <20200317135649.8876-1-michael.auchter@ni.com>
 <20200317145113.12413-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:3:115::17) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.phire.org (66.90.216.181) by DM5PR11CA0007.namprd11.prod.outlook.com (2603:10b6:3:115::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 14:51:36 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c933a5-d111-4c89-5405-08d7ca82b17e
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3519:|SN4PR0401MB3519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3519219D5286CF194F4C8C5887F60@SN4PR0401MB3519.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(199004)(4326008)(110136005)(478600001)(81156014)(6666004)(6486002)(2906002)(16526019)(186003)(36756003)(26005)(956004)(316002)(8936002)(44832011)(66946007)(86362001)(1076003)(5660300002)(6506007)(8676002)(52116002)(6512007)(81166006)(2616005)(66556008)(66476007)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3519;H:SN4PR0401MB3646.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUcGZn6q6nvvrMwXWxaBheuXxmr/Myxd0h68OM90cRavg7D4JlIrLDsU15GVjdukDYmtIZXb0W/BLRZ7NsIqbr6MVWmhb6qQiwlZx3MoHcPm3hJPJ29mNMyjrQkg//s7EMefrYh1aE6grZFNRHJMYSk25DjOBo8qr1YpWsKErSDew5oY8xGKsI4UIkIJmitdlLZXmRNMIDGjK/Oo9MpogAp8L+wBQe/tT/AA8P6dwBOw9T6ujBL1DGmIflDXlNWIMdiencoEgeaESaHxTciiI6oVLt7WvYIjyLfdj6pZHxOqUkpqri40sAKLE6CF1O726so+ukl+WWAlLtNnp91qIJ4Yv/z7wTA/PofbcWR0S61RbNn0nhjxTWxnKr8U/PuSV2vXOehjSgk2eo88pyeX99jdgPivp9Uo5zgv8zKd+1OPf2hgnkVmHR5DIxF+6zIdx2oShk9dLJhcbRHrHvChMGN5ycTDfjvU4uDdA1e35yGwcUoMc086pF7fPJ+B53lbjETIp3ePnc/MQ62QSvzX8Q==
X-MS-Exchange-AntiSpam-MessageData: ZQ5Z8rcfZbLCJPJvJUfM7G2PATF69rncFJxSrG9nHewsDKAY+8eDf7FcdVAX3oZpQlRnfLqzsA0mVi53bdaY5Cz/lpEoqw0pe9lq15OIGZH0oyUnuNqR2fJtFwS3S9z/aQLc5TQM/Nn1sn50mR6HbA==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c933a5-d111-4c89-5405-08d7ca82b17e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 14:51:37.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nde0UY+2/9EK714DT7ZruH8XFt1+oUZ64Ct0MOO3sX5rd/XeP67D/FgtziHJfdSwHeHV2r/yAc8jPE5HHQFow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_06:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003170062
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree binding for ADI AD7291 ADC.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 .../bindings/iio/adc/adi,ad7291.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
new file mode 100644
index 000000000000..93aa29413049
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7291.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AD7291 8-Channel, I2C, 12-Bit SAR ADC with Temperature Sensor
+
+maintainers:
+  - Michael Auchter <michael.auchter@ni.com>
+
+description: |
+  Analog Devices AD7291 8-Channel I2C 12-Bit SAR ADC with Temperature Sensor
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7291
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: |
+      The regulator supply for ADC reference voltage.
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
+      ad7291: adc@0 {
+        compatible = "adi,ad7291";
+        reg = <0>;
+        vref-supply = <&adc_vref>;
+      };
+    };
+
-- 
2.24.1

