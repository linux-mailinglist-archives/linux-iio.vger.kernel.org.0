Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7486310CF18
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 21:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK1UMW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 15:12:22 -0500
Received: from mail-eopbgr80097.outbound.protection.outlook.com ([40.107.8.97]:59566
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbfK1UMW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Nov 2019 15:12:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo31AOxisqWTe85txhMI1nOThpyZvBbDbJJhJ7xTfiV5bSedLzkRwzGTYRe6pVYVg7tAQbBvuCXuKGZsy7DT/Q35JYEooOd4EufMGChRXcH1MxeRoW8Tc7+cDosQe/gJoI3k1FcnygMc/Jso6W+Ti7C8NlboKzpkxWEuQHLXZvCxM10iqrEIuQa1a8Mw+FKfrGzwmLFcV7uCRkybG7EV4eiTboKy27sAn7QKXcjuXhTB0pGAzusqHoTZq2jwW/nqsn9EneH+Rj2uQgX9wwM1hxNz3QW9x1lk5dp8yT+C+NmdWGFM1M/n+8gmV1LZb4a0yJKkTUpukwisqf/vc00EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToQ8N25uV5B/3GHzcSHWEIuPJHk8T68iaR6pG/FIqEk=;
 b=mlvdm7O0uyLIIfTKnT2JgMhxseJV4HvLWQX78fZ8y1IYk5GerfxmfRpjqpybFbZEMH1s62noz6GJdHRBTv4zTKHCjBSzdkGxTOoh9zSRt8drgnNcTOf+wRcFW4Ax5E5vVaxJF7n3YnEGOpwF8M9MXoaSd8zPtpuw4G8MhvUMguail7FMJY7S7JHHie8MGn3xqP0z6C8fwrc5jaS5vzvOWGUdMHpOSM8S6OmdlarSCt+As6hZ5n8Z2t7NRXZdlKw3nRnjHE+k+nkeIr7FZMYyfg0oIy214WvJr6QFQr6mTOy8IeqwKlKPcAoPl+XKRvrxWzSKDXoHMb+GCfEuvl6/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToQ8N25uV5B/3GHzcSHWEIuPJHk8T68iaR6pG/FIqEk=;
 b=E43gea6Jgikz25z32iTGfOd0WchYHvDhUISJELjEsAP51Ue0pV4cCuOFQV86grhTkcXjqI3GQEGMNByF9qc9NGSRLHb70ZAQpUzaukZRIlMsTOd78Co4nIN6eymclrGXsSoqyw2WxfCe3qu/Mc5Dx516/SYXc4MFAwmychuhPIU=
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com (20.177.202.94) by
 VI1PR06MB5807.eurprd06.prod.outlook.com (20.177.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 20:12:17 +0000
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::5438:c401:b17e:c0b1]) by VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::5438:c401:b17e:c0b1%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 20:12:17 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: =?iso-8859-1?Q?[PATCH_v2_2/2]=A0Driver_for_TI_HDC20x0_humidity_and_temper?=
 =?iso-8859-1?Q?ature_sensors_?=
Thread-Topic: =?iso-8859-1?Q?[PATCH_v2_2/2]=A0Driver_for_TI_HDC20x0_humidity_and_temper?=
 =?iso-8859-1?Q?ature_sensors_?=
Thread-Index: AQHVpighrsZiMTi7hECz01/XRd2T1w==
Date:   Thu, 28 Nov 2019 20:12:17 +0000
Message-ID: <E9781938-9BFB-4978-83AB-B17B0BE01BC3@norphonic.com>
References: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
In-Reply-To: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [62.97.226.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97b1402a-5810-4d28-1f3e-08d7743f4466
x-ms-traffictypediagnostic: VI1PR06MB5807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR06MB5807CAD9A736CE2207C7608ECA470@VI1PR06MB5807.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(396003)(376002)(366004)(136003)(199004)(189003)(7736002)(71190400001)(5660300002)(2616005)(6512007)(3846002)(6306002)(11346002)(71200400001)(86362001)(66476007)(91956017)(76116006)(446003)(26005)(102836004)(6506007)(186003)(76176011)(64756008)(25786009)(6116002)(66556008)(66446008)(66946007)(256004)(2906002)(81166006)(33656002)(81156014)(8936002)(305945005)(966005)(508600001)(4326008)(66066001)(54906003)(99286004)(14454004)(110136005)(6436002)(36756003)(316002)(4743002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR06MB5807;H:VI1PR06MB5790.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ON4TZdMKlI23baO64Tfkkfx9XkYJD3HM7Oo4TocrCpoKxTzsQAfebpBfCYno++YmZGfjwy11a6wPWKtDS0I6C0n8PrFeg8sS6uHnBuXtba1zSrjHiPphwo/b7kig3Y+c2DfHuvHm5qoImxl5HqP0zjSqYv+2ymVgIelC+s+gxnu4wtD5nCcGjL68Bgxcri0DfMta6hM1WrlF7JsDfVsMRXcMtL1E+4+S1pAvyxRh/Z2xDxrFDEuNLAvxuPukuwz+uUuUt+aRBBFYAgbUOjnaxx3gFTlw3doEYXyeghaFDQuRBrQvq1V+8O+YyRnwX5zprxdgcHtXR1gzMhKpQsF7AHMBdVCkOw+tV/42XUyWmxQqAceIhXWHan0SxQpBjqe6NlOiboZcu2QywZCjWunplCSQIi6EdFLHattQOUMle/2KJO8elJXQ06u6VozY5LmquagEvXT4Eg0AuzUpSPnxNF7obpa8DhLHCe6F0WgMIZg=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2DC2B02D94785E4EAC5B65E7D4C703C8@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b1402a-5810-4d28-1f3e-08d7743f4466
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 20:12:17.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYg0rdTU5Akc2PMu7UUzWylVK8u9Cc1IMucaSnBCo0G+EdBxAtzyYjOcJ0NzvoEDXZCuRUi8MQvkI+74L8C1Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5807
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Device tree bindings for HDC2010/HDC2080 driver.

Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc20=
10.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc=
2010.yaml
--- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml=
	1970-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010=
.yaml	2019-11-28 15:35:17.874477013 +0100
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
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

