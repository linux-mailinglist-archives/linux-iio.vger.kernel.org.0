Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A698411E726
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 16:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfLMP5f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 10:57:35 -0500
Received: from mail-eopbgr10133.outbound.protection.outlook.com ([40.107.1.133]:61571
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbfLMP5e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Dec 2019 10:57:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFAZBG4NVMOWTS+M7YgOPMzreiVoIoadHuKmZL57WiBt4MiO7hyTYZpf5NCMA8E6Qqidz1cJQ53rotgosIX3xLu6S7SLN0v6YJUq141Zl6PTpXj2qRmP6g0x6mj00kZtUnrE91b5lR3XO7yNY5n66NWYhjCEKOYsOaksCBuIcheNNrA8agYNEYVbfhGzY4Y3dKLTKw0VYiH+8wP9D5ZdvZDra2x1zIETzIVcJ9pIUhMw49Xaljju0ISMuy1vRaCv+X7ImyQEYZ5P42RReCCa3uqtMJkArf4rVCmr58fv5GBN0dneuRUDZW7PtyyuRfSDT6YlGTL1IF17bLTixqKYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9D7G2PAc3eBqw7ZZdGrj21vxZIY9SjcWMpWhZsNrWw=;
 b=eobdiNQgo66o9l/8CTP4OK8Wirm89Mezl4rejAFTFDsp32VR1Qti36u1CeoJP1gzeCLTeax1U/taE+4nYFYa14MInD0DLgQ5zWFvs17nAc7szB0rWVAKC51hLly/936BFxi9dfhBkLDEXVk/qyzKen3Tuhwp7tGHpGREDj41f69rNnvtmK6dEeTXCkGmo6WDyb26GRj8d9L7KEh+m/EbtJHqYUEViUrIaJ6XqCXhBOJ6PsLwpUuG6afGk86otF4nQzbsZ0owUL+mgJmQ4fmmi+N4PZq6oH8ayxbuRz78y9OkEZvuGMFvqUgFnzfqkIbV7VCWtYuOWcKYuZ4YNL4l0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9D7G2PAc3eBqw7ZZdGrj21vxZIY9SjcWMpWhZsNrWw=;
 b=KhgLdelc6kq0NM1kVWyNhCwsH/NqIkdi+laSDRDyooxSe6r5W0jL+uMoRvTWOIqNENMnUcsB7C+aRRWJOveZnVF/oOyBsAK2vnYXYSNqkT37kOqKJGgzw05pP/bspXscPTudH9b6eIPALm2vyR9NH3rlOz05Hwk/Ei9XbA2yD9w=
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com (20.177.202.94) by
 VI1PR06MB4655.eurprd06.prod.outlook.com (20.178.12.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 15:57:30 +0000
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::a56e:b59e:d95f:c568]) by VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::a56e:b59e:d95f:c568%4]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 15:57:30 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH v3 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors 
Thread-Topic: [PATCH v3 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors 
Thread-Index: AQHVsc4Gytr7x7X/eUavMykfYM9BXg==
Date:   Fri, 13 Dec 2019 15:57:30 +0000
Message-ID: <05D5E061-47A3-4446-BC4C-558B2DA054D3@norphonic.com>
References: <B0A4F7BA-0D41-4DA0-985E-F2603D66C48F@norphonic.com>
In-Reply-To: <B0A4F7BA-0D41-4DA0-985E-F2603D66C48F@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [62.97.226.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f2c36ae-4bff-454e-297e-08d77fe528e1
x-ms-traffictypediagnostic: VI1PR06MB4655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR06MB4655EE3505DB43F2F59448DCCA540@VI1PR06MB4655.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39840400004)(136003)(199004)(189003)(76116006)(66476007)(6916009)(91956017)(66556008)(36756003)(66946007)(66446008)(86362001)(2906002)(508600001)(64756008)(81166006)(81156014)(6512007)(4743002)(54906003)(5660300002)(8676002)(4326008)(316002)(2616005)(71200400001)(33656002)(26005)(8936002)(186003)(966005)(6486002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR06MB4655;H:VI1PR06MB5790.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bg17JrXLsimyXxsiBMWFuIqzRHiEQJVjYcABGtabnQHRjg20CPWcFJ+h1f9z4s0JMSbsxsfnjfQ98qjSX3AvT8rNa4JYrybLJn6jfsiytSpIQCgibkmwvsZ8cN24wr1dQDEr6AaR8q5Wt8FzXu28MiZDE2EHRz0JjvFEojcQ+kihfkUTTldFUJ5GAPdar6/jiPWXVeW23sp+qo7ibI3bfUh4Xgy2TDqwlGgxE8hfaMhDTcQW6B8z/k6Aqq0QfVfeju+g5o67JOWt85VdVvjeWyAnflNu9q+mtawlq30pZ7gsSLOTwFkNh03C0UD0bFatonuPOP0XX5fUYvig8KLM9zFn3Wv0cs1Egot5SI0c4UWxUJ5gvuqHfV9zzqNtorlJY+5k1s16AM7Smd6uAY72QFq3hdeuSX/5qJs2PW7a34vzNdE70rjp+L4E3u61da+ppQvKAdS+lFWv5/OTUXE+JMK6LdLd1NEjENKAmWZNlMM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7BEE4D7BFF5874E95D99F3F502FF76C@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2c36ae-4bff-454e-297e-08d77fe528e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 15:57:30.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0pQjYdHky232QoqLf+lj1QUsrp/O8hEjfkHITD6s/nwHHSjCUyQxPioJTpTpdy/tWTz99delihyKUWaxjKR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4655
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>

diff -uprN linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc=
2010 linux-5.3.8_docs/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2=
010
--- linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	19=
70-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_docs/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc20=
10	2019-12-02 11:09:25.803326999 +0100
@@ -0,0 +1,9 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
+KernelVersion:	5.3.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Controls the heater device within the humidity sensor to get
+		rid of excess condensation.
+
+		Valid control values are 0 =3D OFF, and 1 =3D ON.
diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc20=
10.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc=
2010.yaml
--- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml=
	1970-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010=
.yaml	2019-12-02 08:43:32.508277082 +0100
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

