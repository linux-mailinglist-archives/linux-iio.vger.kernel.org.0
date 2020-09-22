Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EA5274517
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 17:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgIVPSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 11:18:17 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48194 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726566AbgIVPSQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 11:18:16 -0400
X-Greylist: delayed 1908 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 11:18:16 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08MEd7CG010733;
        Tue, 22 Sep 2020 09:46:09 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-00010702.pphosted.com with ESMTP id 33ne10g2sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 09:46:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRs49q/adcGFfZE+bKd3z16Vwv9ebe1WVQnQzRY6NtmNjUFS5OGjjYhh1Hu2vY7P3z41abdNTamypkqGcryIpwBtY3f51LJUATKMWralTCryENlVo1qP1dYEgPpTorFKAMNwtskEvWbSCI4pMNzp4ZcTwoc7lHHzKhLOzI/aaQf13WMsEzo2HmA2crPG0a/+W0EFCmDYmMRvQAv3P4pDOAJkVn7wLnCIcM4Y7OSLj23PynQJykv9FeS/oCjloFR6SnC8yC2hX6Q+chwjqLpgJSScdBb63m5mgNx4mt4G5pyOEmFlZSgh9zqF8Cf4XgQ4wP0hesdxN5Ro/SsLGIzOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhUg8ZcjktFjLXCW8uu2969bAUi1gob0BHF3cxYzmI=;
 b=ke/MAGjJqfWYcYcYT7GL+eVpjb2WOb0lEgaheva7A6LJAMYZXTggSSiMQ6StoIOnS2SrmUOT+aYIZhv/WNKGtK6Po0ixcvlPg+t67+4lr6Q4ohSbhtfdouupLpyeGT/ZkuGoxbLfqAwscrjzkxLvxAe9rQB0r/h/uZDbuOOMjofoNeXYm9YwLj4dGROCuuZnPiCB5uKrbndeUtd7ZN1m78nW8F8QU+1Sa6WQbBuzY/Rvi54OmHbGadSlePX2lID0qalIO6IhhiVZBZ8DZD0b76svdR43KxUD9aY/B9Tc2LH02uHsUmOQogp7KmJTI3yQNXLZdm78soHfs8rOrOUwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhUg8ZcjktFjLXCW8uu2969bAUi1gob0BHF3cxYzmI=;
 b=N4+yaGhDRTt/qLX4lteEe0WVplgpJ9q4V/pD60dpGGvD5ZK7WbQEvjhv/d+0v0kWgPFfdPeLpMiTYofA/4RQq1GA3RR59KgtDqeFuAor6bBCtEh/7x5zHg06ifAcDdpxMrYecCOUVvaXPRBvGYOTqFT2fc6RQQ2e3tQo2/Y2YK8=
Authentication-Results: rocketlab.co.nz; dkim=none (message not signed)
 header.d=none;rocketlab.co.nz; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB3856.namprd04.prod.outlook.com
 (2603:10b6:805:3f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 14:46:05 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3391.023; Tue, 22 Sep 2020
 14:46:05 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     j.lamorie@rocketlab.co.nz, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Auchter <michael.auchter@ni.com>
Cc:     Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: iio: adc: ad7291: add binding
Date:   Tue, 22 Sep 2020 09:44:21 -0500
Message-Id: <20200922144422.542669-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922144422.542669-1-michael.auchter@ni.com>
References: <20200922144422.542669-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR20CA0031.namprd20.prod.outlook.com
 (2603:10b6:3:13d::17) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by DM5PR20CA0031.namprd20.prod.outlook.com (2603:10b6:3:13d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 22 Sep 2020 14:46:04 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80321534-42cf-4726-7224-08d85f063bdb
X-MS-TrafficTypeDiagnostic: SN6PR04MB3856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB3856CF7A484B619ECDDD09FA873B0@SN6PR04MB3856.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: welqMwD3gCrjo4G4V2ODTwA0cDsgDgyTfxJu/a5HKmKk1Jc5zZtf1327Y7wwCca/mnhc+l8pvqPooEdPhEvl+T3B8L1hbO3ZXNfcpFOP8cN29Od2bC7UXtb+TTVSbT2LmEVN7A2w8v1TEX0BtEauoacrr8YPFs3NMf82TUEinq4TIOiUDSvyZuBPXQi1v2ynoyVDwlQOLnjS0b1hXRhrkRt2GSL28A4EX0RYKXKMXgNzLqs6fJ/9uKQ27GxsTCbdk2/sufe89qcuU8aGjgS2gkzWfiGT62OgrU09ZjYSnspSdWKu4t6lpW2iLuwxVfJaD8A6xEBwOTwWkGTCEc9rfsB0oR2lFPfZhfe4tpuDPvg4rS6qOzwqYsdJvRG7sdqBkDQfZ5DvC0MbggTHRzqgQxzgYbrEKbEIZQVb3towErdyTqtS5PTR5w+QoMlQ+0rweP4abRhZdBu/HULNtFawMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(478600001)(6512007)(186003)(16526019)(66946007)(2906002)(1076003)(6486002)(86362001)(66476007)(66556008)(6666004)(36756003)(5660300002)(316002)(8676002)(7049001)(8936002)(4326008)(110136005)(44832011)(2616005)(69590400008)(52116002)(966005)(7416002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RK55ESIE7N8luLvehzOiDjIpfRH6ivlajXWhvbAu3pSIOXFBx4WJPyNOfa29XXE1sJgNFMWrFNPK8sXD/cWQN1nRMrLH21H68t2obTjQIebR3zlQMzTvTcms98UW1mvcuz7OP1s+gxPTH6C+Z/o0ZkOT9a+0YZTpkw7dFKjAl3ZQnqUj3jSgom0WszU//q7o4XXexENzt2Sk/r+rTLlwHxONs7g3ThJWCjzddrz3py/3A3BBR5L7oPrqDNXc2shSyxoBcY6nEtd5iNOwXvAJ4U6yjvGazLhohLhDJdcIcYutKBA+IO8mYJhNrFIHoHuQ74Nx6/0ecfRtpwOxwDiZa0PlllfcdMebMA4BL/FsDvehtofYEYY8dg09b0o1q8SR7m3keHKF4N+2X50VMC1ITf3DxWtMHqgHRsEXclK8CKG8LRS55w8wLz7D0Fm9N8ecEdXwfehFBKsS8zZ5jhvfnhsua25TX+vqkHP1wd5z46eHOquDBlhMD+j0GE9KhiEKNwZTJKWVzHd/jelI/CpAm8Gi3ZcKAxHRS1ONLxUUJuGFibPdhnVy9imgAw0+g/vL7BGqLBpSe2fiLdUyDxkZoZwcLjmZoPHhQPX66kp2cNRNrseq1kUtK9IALITv7yxz2U0qdgcEVOWp7xAQVATpXddvGjarAUH4AKkeKT2I10h10n588Qvtovy2vPmyRqsX8obhgs+d7n0cdc5OMFPypA==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80321534-42cf-4726-7224-08d85f063bdb
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 14:46:05.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhDTMQP7r1QbxQ1M/nFEeYiNzmXWrinDSB/YNJwDXBwAQm90Le6B42/cKg8tHnWdqqcmenPNZJGU9w1wiqan2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3856
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_13:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 phishscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009220117
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree binding for ADI AD7291 ADC.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.25.1

