Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879D6124D51
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLRQYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:24:06 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:27743 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLRQYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:05 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: fKogZKkZGN2LeBqOmQklDURmD7Nxas8Ukg8RhT5qU/m1hl5ZFOKV0Ne14RXtFjWhBA8VG9UMvy
 hFF3xvBf84db/EdmKkFDNw3R4lFrPWSBEn71/7npuBuQBl7QM4EzaYqvtSL8yZzP1IBNWgh9wQ
 /rs5tLXxYJuBXdoNCVG7xfSEFRmUIGM+3ykk7ITu4rjFosDFwp2e+ue8q1DAV3Y4mw0mFrunWu
 /zsmYYAgLmjY/2b2LvVkCnDxB5/T9cCdVpmL0ejjHs8lVlwqOfnwX3Cni3DwGPiCRcTeMtVw0c
 1eg=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="58200035"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 09:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyRe8T409vT+nswIuZTXL1AtevXCETMoSkMNIzAicpKLwF+lcpU9skLCAyc+Z53B9ZYQNbQ/6maDGf0Pph2xyPLh1ls60tHlBPkypS+dGa7kmVTZeKlYvxPp4Gqc27w5F8A2D7IrONvWwhAhoK0mq/RCrx6/6/cvoNKj03GuTYa1bftrqt743XgADzE6oOe8tkW4SPYUxsI7zvVvjVXp7ptK6/PEMKwiSoSBnVSU4bk6hJoPt6h1FBfcgW0pn9YfjDL18dB3bN5+tD8sw+nv22A0lzpCH2xfnCt31SP2mjw/RpiR5iF0hSKW5qW1hJIry5YXn9tmZmzHx2r2Kp9VpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVVpupUKHMcVEMlJDeBxmxYOFsVo4OQlonFFmWJl410=;
 b=GOYY9bTiq46CWWe+q5EQJlIHDUDqSr8y3WB9+mnfY62r1xRx/OR/iCSha9pv9gcEVGn5zRl5vwEsunSPLNwD28Ge9fEOknMhwLFZgP6WLNQAq6V4uTLqYy5x9G/wF1lnF3W0OL8lqwYhwbO8JUQ97abLBUhxlnFljOTMmLgp7XW3RcaqDBWjnS07vV2VfhKEmlDa8I1iC4Lpug/lLhPnyNhIFBrtJucadtUebks7lIZYCQk8A6QL4FBEt4lGs/qkN+jv+3/154H7qtnO1VzFYsF6aoo5fli9X+bdWEocJ94DjDBtdUpMvwdFowzoQxPa/Cnwn/QiSe6tNKFOlEqObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVVpupUKHMcVEMlJDeBxmxYOFsVo4OQlonFFmWJl410=;
 b=XQagWMFpAAihScx4mlA7IjN0qPPUVRHt3Mo15mJ2BsnBEOb8zWaOOkJjOsqopCt2G5f0gQ2h1ElzWp8QkP4garTR5MLs0WR04zsgwwwavJZ6hKp5lvgxLm3YQrY9pqQG2iYidOOKx8wCHWkVIWjMUQZYAS71srjaRx9YurItpd8=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1769.namprd11.prod.outlook.com (10.175.87.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Wed, 18 Dec 2019 16:24:01 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:24:01 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 03/10] dt-bindings: iio: trigger: at91-rtc-trigger: add
 bindings
Thread-Topic: [PATCH 03/10] dt-bindings: iio: trigger: at91-rtc-trigger: add
 bindings
Thread-Index: AQHVtb+NaJqoAh7pvkOjOkr/UgCULg==
Date:   Wed, 18 Dec 2019 16:23:59 +0000
Message-ID: <1576686157-11939-4-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05dbfc0d-742c-4a2c-3c75-08d783d6b0e1
x-ms-traffictypediagnostic: DM5PR11MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1769FCC29B12D03C406740AFE8530@DM5PR11MB1769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(66476007)(66946007)(66446008)(76116006)(91956017)(2616005)(64756008)(66556008)(86362001)(966005)(186003)(316002)(110136005)(8676002)(54906003)(8936002)(71200400001)(81166006)(478600001)(2906002)(6512007)(26005)(81156014)(36756003)(4326008)(6506007)(5660300002)(6486002)(107886003)(562404015);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1769;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrukAJWux2FigqaecMF4sE8v/wrwsDRO36zajMIItx/8QsifCNPsdU4UoeivuvIEAhjrrN9hR24p61pv+OIYG5Ke5UhAwHmS/j+fMKOFqynGsVAMqYSTeHVTluJjiNgDNNPhExlmlKCdOYbYFg9vL1UBCGtZAYwNnDVVnqp+Q50DMY7vlf1+rB6nLjzpi/bAZiObwMvJO9ibm/1fuEX2EB9tdVz5vFbM1NXPlr3w12Q3bL1B49+HsvW8HAyvNpN5Z14Q+gpvVEIAS0N8DrvqdgxMzspe9uTxDXku6iCnrRz5MPukhHNWVABtcw2KDZ2sWcUnbzv4UysFoHzKqF8juJQAz/4JTcBPpAKJ8CL5EvAtpmxgbNxrDFDvJsC5ZtLerzKp1PHHPvgI8c/uVQSnepUsfzIMDyOvRytvuPmu4Ce6PuOtHzRkCcjFlhbcaDIssvyM4ooTQ2Dwn2IQkF+YJuHj9/SsVIh61aNKgZkPAXswhlYKftG4Qx7lnaDLJLDSkMfI/xS2rTNTSnYOF0H8dQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dbfc0d-742c-4a2c-3c75-08d783d6b0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:23:59.8381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGxd2A/B9HsdDBDrb864ZQOq8Jha3kmxqpwwy7e6qkth4N5Iel+ywdCai6BNXoeoJsIhjmx/kV9j37G6vG3tWB4wGyyvPJKxOMDicc6Dxik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1769
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add bindings for AT91 RTC ADC Trigger hardware node.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../bindings/iio/trigger/at91-rtc-trigger.yaml     | 44 ++++++++++++++++++=
++++
 1 file changed, 44 insertions(+)
 create mode 040000 Documentation/devicetree/bindings/iio/trigger
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/at91-rtc-=
trigger.yaml

diff --git a/Documentation/devicetree/bindings/iio/trigger/at91-rtc-trigger=
.yaml b/Documentation/devicetree/bindings/iio/trigger/at91-rtc-trigger.yaml
new file mode 100644
index 0000000..c8c5886
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/trigger/at91-rtc-trigger.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Eugen Hristev <eugen.hristev@gmail.com>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/bindings/iio/trigger/microchip,rtc-adc=
-trigger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microchip AT91 RTC ADC Trigger (Real Time Clock to Analog to Digita=
l Converter)
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@microchip.com>
+
+description: |
+  Bindings for the Microchip AT91 RTC ADC Trigger.
+  The Real Time Clock block inside AT91 SoCs can be connected with a direc=
t
+  hardware line to the ADC. This line can be raised at a specific time
+  interval in order to trigger the ADC to perform conversions.
+  Datasheet can be found here: http://ww1.microchip.com/downloads/en/devic=
edoc/ds60001476b.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,rtc-adc-trigger
+
+  reg:
+    description: |
+      Register map address (start address, size).
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    {
+      #address_cells =3D <1>;
+      #size-cells =3D <1>;
+
+      rtc_adc_trigger: rtc-adc-trigger {
+        reg =3D <0x0 0x10>;
+        compatible =3D "microchip,rtc-adc-trigger";
+      };
+    };
--=20
2.7.4
