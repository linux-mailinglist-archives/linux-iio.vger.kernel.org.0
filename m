Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16B51B9483
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgDZW0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 18:26:33 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com ([40.107.7.120]:8817
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbgDZW0c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 18:26:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhQgI9YAdhE/EyEr0HZoxKSd+Yb3KOd6O7qrhp0xKwpfkFAGveMb07QUc4u0BCUi9Bq9a+pUDtRciTyH7bjS1qTCfTtBBzxYfDrG+AryW7nu6ZUSV6FHzRBcoqtHDWdIDm1psSldAWZeM8XdPfDa/9Hn8Zk4u87+ow7kVyy15F1/1Q/CUW7CkRflnyqXX8vnaj4njaKSszkBKMbKSSV/5jxSEYAciuwJv0NpSbXnsfQVoIHzp+URt3xsFk/GdLlQsnGF9a07gnmikzq6CbUzufhozn11hFrrO6TwZcS4kLKfQR2rr1C4H1tm5P/z0LzkfiCtxGumfxdaRqHCD3R20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPJL9FHU1d0ugKFn3LhsfycM00py/EoJdhFCPXtEnsc=;
 b=YhdUSC4zTGHutoxAvep98wvVA8bNVdNmcaVfLPy3b8pxmRMLNCq9DzbgXbzc0H+E4jqxzomKhIu4a9sxbo2M8NicqwBOF8vBh72zAnkm+zK9m48V/lekdvpJbEWgHQagvCqVJj1MTDl6giLSOg5SuWF7ci+hbfrwevYlHFCRKWTpf3h9efONW6IAM0uvvvYQ/tqlCkAeEH8JvWsR7kBKzhS4O0/A9eiN8tjOiiH9nLYIdmDB2L2wR4bfLVArrjh9VHtDU3YfRKSxdjFZHqB+/rU3TC7b/fDZiJBWHA7CnPQE2jpDhz1Q3Ytur+J3wuFoMC6r2vKCus+EzkmehVfxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPJL9FHU1d0ugKFn3LhsfycM00py/EoJdhFCPXtEnsc=;
 b=QZIT/VEJoVNZV6v2zTEXTGDbUT2yXAQLQxB3o9betI1VtKVwncQN2PcwVw0SkBCAYrUE5djWpq0rFmuxLIRBaHsmZHQAH+K6m9ep9rR0goxuKQ9VXUo95hvi0A6oQ6PjHFYQ9p3jn2x3cR7WziPgCwf66yh4B67Wb5xvKuASFXo=
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB5975.eurprd06.prod.outlook.com (2603:10a6:20b:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 22:26:28 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::9814:8ea:8170:5678]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::9814:8ea:8170:5678%5]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 22:26:28 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 2/2] dt-bindings for TI HDC20x0 humidity and
 temperature sensors
Thread-Topic: [PATCH v7 2/2] dt-bindings for TI HDC20x0 humidity and
 temperature sensors
Thread-Index: AQHWHBm6dhBIb3K4EEaSenbAhFvBVg==
Date:   Sun, 26 Apr 2020 22:26:28 +0000
Message-ID: <D680EB45-9477-4105-9B14-ED7330F59D1F@norphonic.com>
References: <E372084A-C6C5-4261-90C5-B810ADAFDD73@norphonic.com>
In-Reply-To: <E372084A-C6C5-4261-90C5-B810ADAFDD73@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [88.88.123.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 690e1b8e-c05d-4519-649f-08d7ea30dd38
x-ms-traffictypediagnostic: AM6PR06MB5975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR06MB59753A69218EDF436A74276ACAAE0@AM6PR06MB5975.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(346002)(366004)(39830400003)(6916009)(4326008)(6506007)(2906002)(966005)(54906003)(316002)(5660300002)(26005)(33656002)(508600001)(6486002)(71200400001)(91956017)(76116006)(86362001)(66946007)(66556008)(64756008)(66446008)(66476007)(2616005)(8936002)(186003)(8676002)(81156014)(6512007)(36756003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0JCFW4pF4fwWTF9IkaBD0SdxNUlTR4znHXXaa5horMLOEpXDOnR3trDRZSrgPysXpmo/whBkrprWgCI1IH6hX+rKpmSlSopw1WRut5JUw/3f37Ur1upa7FVZzCSXUC3/KoaJMFAwzXL9tq91or8kUsw5md/A4G4748akielIuq0H6TctCEnw58kI7cIyxtk0gT+WXKACj3dnGRTIDH9FqhUCbuAv35Kv3fxfWegrKbJUSChKGqwh/fqjozSb3tVL7j2ZcXN0H86U9quisAzMeBThO3JVb77lbilZnWeP14S5ehkcicKywUxcSq/1BBgcHHoPNjMXfZhEI6v2OI2rtbZytLqCMG9G3eWf+H3lLvlAC9kDNCyvxjPanxjOG6+xcA8OfBjc7nxy9eM6Nwdu/p6OC/ThUsDG1Xc+IsmdDwWEWQiaB6qIzVHyFjTPXF4xwXZqsoNUiRhZQr7JofPe33srVWBwlkplrNiL8cWj6Jt3zu5BM5WYxbq8HRGuQOlc/vH74ehMum5i0BYk0lXpoA==
x-ms-exchange-antispam-messagedata: SwiziP0XSXDz3tA1lIgJffT0VogsYz3MOtfp6bhrw1Jzbktq2JRdkgmTKOwuwm/jUcaC5w89HOcm6MTIm2qmr86nMo3Q8YmTjtCmDjEz+pPKZH9/X4sJQ0Jck6Xe2/piHn3RlGT2BjbCON5N3Ac2dnHCRUD1itq0JY3IJaWCTXRfkqhbnxNX7HSsmoRM8MMn2a4dDEvxMxEKl6wa+Qr3DuqRW//NsM4eUVi+aowpWLBcYvvZNzZnrNkylc+l//rs9jEL0h92mk2+pJ0WNZ10zD8R7VQZRXyeHSObzXh6iB2cqiaEjQTUUOLGEns1NHZIA70uQ4S3cHThE8tmzQoyz1qBcqZOfdi6x9SHx6rtuVOexPUAyI6mPY24v4vAHMajEwyuMMjeILtU/BqiiftBQHwd5PTHNdPjOJNYBsuf7ViLfGEwpZE+6aXiC1PD39pnh8RuSbAKSzPQq7NZgydvewCYHtjxZXuchPuvRsdAEwfDk1YXZe7b3TGBeHNZnKZ9KnjMp9FSCo7w56h4T6ge1LpeEtYc8PcOVwEefnDOBWYEbN6u9vjt/AHmC8HVkVdeX36by/XHY8m9WypchF0EMNgAcaAgGnlfpxkxPhxXt7AfkjQ4zgrQEUxYaEoJxPvwrpOckr73TaqT/lTf7uZxiSxzEFRO+e8P5dLinbDhMABTZ2pEPiM3BFm4WPxeRg0H7eSFo7BP7P34ShNJtI8aLPWxg7AfImqJD5ySGmsiLWH3hdj8DuzhQvDhDPxn1dP+1aqGBJrBptJfIvfXRBWiV0AF7T9aVOCjB/9Zeh63Bvc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C71961D5F4B6A49BC17A01E17F8C55B@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690e1b8e-c05d-4519-649f-08d7ea30dd38
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 22:26:28.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3eJhmbYoQnW+AbhtRir2nChi1b8joKmB8Zqo+ns8BhN0wFN7y/VMVK4HailfNAx7SdL8HyT2DC/uj+za+LT0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5975
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Device tree bindings for the HDC2010/2080 driver.

Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hd=
c2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/=
ti,hdc2010.yaml
--- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.y=
aml	1970-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2=
010.yaml	2020-04-24 17:50:58.213007228 +0200
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/ti,hdc2010.yaml#
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
+  vdd-supply:
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
+      humidity@40 {
+          compatible =3D "ti,hdc2010";
+          reg =3D <0x40>;
+      };
+    };

