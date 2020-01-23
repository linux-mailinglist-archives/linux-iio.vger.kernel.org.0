Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5D147309
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2020 22:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgAWVTQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jan 2020 16:19:16 -0500
Received: from mail-eopbgr20102.outbound.protection.outlook.com ([40.107.2.102]:12418
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728992AbgAWVTQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Jan 2020 16:19:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2z6Zk/wyTVFe6/DezFqNKrgIR8Kbcw721JYAzMhe2LMFiLZqX0IuYi7XeVD/m3vjtABZjRmI3hhfqjcckzAurOTBpp++8dAxSfx/PdS8WjQE9UVGvSQq+4P0khEnu7b8elP1eLEk+DkuRPgCU6XwdhNBKpJsxMEgFVr4LTsibhGUCT3srGhb0cAiBsbQuJW963u5uRjgkzs79KdVedoK5uMgc6xMthKAQ/ErQxAxf2+9pRNeAvZUD4JG0OgZEJO+qlO62s4Unl5zsIuFqUP1LTOKuocERdV+UTDbQqGHxJYFQPuBA6h5UAo1Xlh4dEgLrqCs43r+BfaSuVLSwcyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q47/32MEvb3Zl/hKIzeSkSXOypWGf/w+kXdLDAgrsT4=;
 b=Oe3sYIH80K92E9i+0XBV6F9xadrykyLHd0m4Emqv9Urbj3aOOmwpFxDV0/eBoQT6lxLLKIGs2k3T5pRwVZkB7MvMtiIf18ubi/aAqGeXJckSD70GGBndl4CB5J+Msop4qfhbEnU//0zm0otJFrbx44NIuRPKTbqMTpWUsP+jg+YoBKthwTNC8W0u6788Z0/XwDHspt8Zq/WP++sV4fqg3UYIMKw6yKRLhjyUfzC7R8f3pXJS84xy52LLTwK6KWRaXvB3PvspWXjGtKnbUie3rR7v0XmH3MQ2Ifus+Kdhj9kFAn86vDNfxhVqTk/z5GUdKa4+Uq74k4prw7kkxyPDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q47/32MEvb3Zl/hKIzeSkSXOypWGf/w+kXdLDAgrsT4=;
 b=KygwPBGvXp4xmT/Qn9Eg1z0Sk5qbfQfI26RQ2HxGdSLdiPZPDbioSP/nWnK7UHqswHK8bh666QJVFW+6H+TPUaAqblCjcbc+IIkTM9RknV06uY1kGaS4xahcj2IpVBeRUCuVcnbDDzVdUJSyqfDRcb4pN0pyrwcc2RWBU2J8Hgc=
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com (10.170.210.140) by
 DB6PR06MB3128.eurprd06.prod.outlook.com (10.170.215.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 23 Jan 2020 21:19:12 +0000
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::8d7e:fadb:f6c5:a504]) by DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::8d7e:fadb:f6c5:a504%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 21:19:12 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Thread-Topic: [PATCH v4 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Thread-Index: AQHV0jLCjmO64vUcc0qMeUKOVOnC1Q==
Date:   Thu, 23 Jan 2020 21:19:12 +0000
Message-ID: <23805E09-AF91-4984-BF5D-29D989C2E48A@norphonic.com>
References: <101D4944-A6B0-4CF7-AF6E-A6196619E3CF@norphonic.com>
In-Reply-To: <101D4944-A6B0-4CF7-AF6E-A6196619E3CF@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [62.97.226.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1c39a59-abe8-4e4f-7ac5-08d7a049e498
x-ms-traffictypediagnostic: DB6PR06MB3128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR06MB3128803C1695258033659C28CA0F0@DB6PR06MB3128.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39830400003)(346002)(396003)(136003)(199004)(189003)(4326008)(8936002)(6506007)(81156014)(81166006)(966005)(54906003)(110136005)(66476007)(66446008)(66946007)(66556008)(91956017)(64756008)(86362001)(76116006)(6512007)(5660300002)(6486002)(2616005)(33656002)(8676002)(316002)(186003)(71200400001)(2906002)(26005)(36756003)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR06MB3128;H:DB6PR06MB3048.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHusSy1G5eYuNnRHdflxiC1/G11yQJB3IXpSHBn36ypuX1OAl83hJrzjHHIOVviM/4auVbOLddWynIyhfBcEwu5llhM9evDzmGt8fxiEpPYc0zNrxGNCzyoCmGNSJrXr1i6Mvxgb+dRYUMcBrWe4jpAjnr9L+WuGRTAPRmWvnAc8VenIf1kW5m0l8rrRnNSpnJHXeylb6y/7CRdybiiOTx2gvPlmjsI5Y/5SV6ieiHC72J5YZEbwaBWyJsp8cGl96DphMCwqqY9Pz5KQp1nPUSbg8n0CDH7m+1OM+JQ38wL2fEs9M60FEGxKokwoazYkqAmf+PUqivY8m5/PWJ7npKXjbogmzS7t10maPIZDHdplIpVhsrrkgwUImTo7yqHc8+xLh8MPgXXVN34+IiB7TPz/rRE3lm11kNVvvEefQPWpJ4kSYassXdHyuEpaTPpHMTmKyO85HvrMFvZ0SiDB7GOoD1cDAXtD+3lyOSBDDwI=
x-ms-exchange-antispam-messagedata: tiG/6mlVhyEbcQvoqf9IZrzPrsvDmmzQijfUNAx/Aye0vIaa+c3BeCRBdg7v/gGEP5tqiDw5mmNv+AP0tmYvvrovxYVOjO7iSmiYZk3TYlLov3pjJ+3Y/Kdr7kaEnh7LKEb64XuUvaERsdQl1y/20g==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AF3C8F63646AA4795D13A75590204F6@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c39a59-abe8-4e4f-7ac5-08d7a049e498
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 21:19:12.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVT/8UUi7C3CXMMAAX6q4mqWmxJmt71u1qCySBMyMIndmn+4/8JcEp6mjkxg5O9l7N5ipr6ZUDVw6Z1nAiN1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR06MB3128
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc20=
10.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc=
2010.yaml
--- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml=
	1970-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010=
.yaml	2020-01-23 17:13:51.573766898 +0100
@@ -0,0 +1,48 @@
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
+  interrupts:
+    description:
+      interrupt mapping for IRQ
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

