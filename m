Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4873C15CE00
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2020 23:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBMWSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Feb 2020 17:18:17 -0500
Received: from mail-db8eur05on2091.outbound.protection.outlook.com ([40.107.20.91]:60384
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727722AbgBMWSQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Feb 2020 17:18:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miENUNsRGWXW2OWXoqAQp59wMNyk54C9XeOkCaZTbA53Owh+hmwLW8RaKIeS4K9/PdpdV8YDItjpZzD56abtTI9ioNtJImgPtvfVI4vIHHVAyenRoa7399woSy+ASSIQhw1KhwPBNpB+Pe51g3r7k2tbWI6A4aXrtAA5YeFgo0C70Lq+86VaE8GEYA8ux7DECyHzAjKkAsDVfPcLf0Wtw9sWiU9k6iyiHir3Hw+lMQoIiNJHRs9+JAhlmKk5Aos49EUtqUnAzK2aTT+EeG6UNN9PsAmfwcUX4+vQ8X5yIXnNNAFC+AsVfUwf6dMggEKmf0X2m7hCkdQbsbAhSAlHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIci2+FaZulGdoFUjaFx9/APPXv66LLYFIb4U9xDi3w=;
 b=MTBerlVy+CLzVehQT7JCwSt+FPViguBUXcw29UG7Q/pnAaAy1U/YjL324k0RspuqalAGI0kIb3qnvITbeRxZvJvsjCjZhXKEGznBbRbA2pSg3k3LAw26HKxvm8pfFldZ5IXcLgpOI/h9Bnb1XAducknWOUuiQSukdQWNootilseBBfjBmn6ZgKHK/Kld54jlAheYKBYwxHxzLXJTOi7hhlAuOUOoSyQTv090L3OlFh6lKaSZAPAiTLDxuHEWWK9PY2wBWuFR7itLrxxXFI7BorAwvDhBlKZkOEGWCBo9hdzUPnAo1wucyVMUjkVjB5rBprAFncw0Bovbv3K7o14uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIci2+FaZulGdoFUjaFx9/APPXv66LLYFIb4U9xDi3w=;
 b=j8ne9EOKNn2MU/erbOeCW++L6LjQfSKGnQCFRBc52t1bzL/UipPqLWb2ba2BE/Q7LqT3Tg9svRUJRRt6UIJxMNPyT+nMqU7OLv437HGuCy016ufo+Zs01t8/4W3kBfevpnA414ZxNsSmoswG9U5XyTm9un0ifkRTes3s0+Z94Fc=
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com (10.170.210.140) by
 DB6PR06MB3960.eurprd06.prod.outlook.com (10.168.19.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 13 Feb 2020 22:18:13 +0000
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::d9df:8743:dbc9:e247]) by DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::d9df:8743:dbc9:e247%3]) with mapi id 15.20.2707.031; Thu, 13 Feb 2020
 22:18:13 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v5 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Thread-Topic: [PATCH v5 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Thread-Index: AQHV4rt7AAu36hdxykemm9XjidZh/w==
Date:   Thu, 13 Feb 2020 22:18:13 +0000
Message-ID: <90EF52F7-82A2-4617-95FF-CCF37E3FEAC6@norphonic.com>
References: <CF7736B3-95D6-43E4-BC69-DDB0DFE2A86A@norphonic.com>
In-Reply-To: <CF7736B3-95D6-43E4-BC69-DDB0DFE2A86A@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [85.166.70.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ff5f66a-96bf-4946-7573-08d7b0d29de3
x-ms-traffictypediagnostic: DB6PR06MB3960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR06MB39606CDCE3933471340A7790CA1A0@DB6PR06MB3960.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(110136005)(54906003)(6486002)(508600001)(26005)(33656002)(36756003)(186003)(6506007)(2616005)(64756008)(66446008)(66476007)(66556008)(81166006)(5660300002)(316002)(81156014)(71200400001)(66946007)(8936002)(8676002)(2906002)(91956017)(4326008)(6512007)(966005)(86362001)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR06MB3960;H:DB6PR06MB3048.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHti0sdMbd/a5Gdfhnt5K1A63wWDF4esU3y9iIxR2Xg1OuTzMqRw1Ie2TXKQzMH/OahDxyAhnRrP4TFV85A21hrBdUTMDuAKn0H9y+Ilgrvazh96HMzIH7IgxAG9d7d/L18AhYitvn837rLS1ohSFUdDZ48Sr3FNEsUy0NFGLa7fzUyReXLdYkewTBLK7bQOr+LKiFXlYnA75Fq/SEhd90HWd3UjFFo0PogQjiiH2QjyzA/0MB0O1OL/EFZmZ7/KYLS2M1dWgzuBtel1jQrLUV4CMDjt8A52UHK/PJYtOqXqXFmAJRV1VrwRYqibGyorkcXrOIjyUQfQOsf3TrcUq9vgPNrlO/+7puMmlwlUNVPLjxbKuRK7wd1PWgfwZBUKxwkoJKGBess+I9e7FOwf+tyI2i09DjDVZmYp/QiDRDSIsfh+vlhIzXCYCalWYHaeWQ1nHbG3XiVAs4rnIodRU4q1UJVlpifadk1lWEfBuL3hWpfcrY3I019kocfPN3fl/Mm/qDu7rguilzMrvovsrQ==
x-ms-exchange-antispam-messagedata: eJ1P4Gm2fWEKJLm67MmC5b+F3xH3NSlXjGZMYBrVbOcKgNQkswbcEyF19QJx4OpAk6D3chwmcgEikN4NiXgx4LZQx9VxcyqlbqsLXR0nw+57uvm8tKGsor/KSCNI3iH9RUUEb07hdmt7S26P/qwNDw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CCF2D6C85D1FC408616909C9D0D1D39@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff5f66a-96bf-4946-7573-08d7b0d29de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 22:18:13.2766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3hUGkjYSGrjlfIpimR+pOgsgj/ebQ6meinJSRMiaE2ffgLPcwZeyXrbCQ/f4Zazov2wPtcqq/SIc5Z3G3gLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR06MB3960
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Amended device tree bindings for the driver.

Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hd=
c2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/=
ti,hdc2010.yaml
--- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.y=
aml	1970-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2=
010.yaml	2020-02-12 14:28:42.562903814 +0100
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/hdc2010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HDC2010/HDC2080 humidity and temperature iio sensors
+
+maintainers:
+  - Eugene Zaikonnikov <eugene.zaikonnikov@norophonic.com>
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
+  vddd-supply:
+    description:
+      digital voltage regulator (see regulator/regulator.txt)
+    maxItems: 1
+
+required:
+  - compatible
+
+examples:
+  - |
+    i2c0 {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      hdc200x@40 {
+          compatible =3D "ti,hdc2010";
+          reg =3D <0x40>;
+      };
+    };

