Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B8C188EB8
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 21:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQUJx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 16:09:53 -0400
Received: from mail-eopbgr140112.outbound.protection.outlook.com ([40.107.14.112]:11254
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbgCQUJw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 16:09:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fanKrfbOiQoC9lUg3Zk727iE0G7ZZx6GHoNO0BHxH2lvHYxM/ZM0cQbmbwh6QRd5PlTtFkBNnaYQXGdFjK3q+7UZkJM40RRcysZS0F0grsK3wCyCW7UVx/PKypBAUkKNeZDDNfEUubqq3uxyAxbLNHBPBoeIeKoACmA/DfZkVFPKsURGOgTxuMlA+Faj3+q060sRuwyqNXrABz5NrGjmMtWbXcQU4R7S0WMHp4GhuQS0fxABypLWsfTtn4CrA+XAlARdHSE1W6GrKg7GMe9eU7nB2Mk4Gf5DoOYIUNVWtMjd6osganHGNF3vXv40BwAPnDTxsXsHbBDCeyt7pxzB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw2/0j+TvFz+vfEGHbEesqhtikbBIOQULdQ1PUPYlEE=;
 b=CsrmsQCcE1RMDwATPy5rRrheZoTmhl9M+AAzRO7hv/sd8NvAYnX/YCdfmS7QR/Up4EJ9kZIwTWNvxqA5zikpaOD+YP2xEhhzbfrS4lDnuok/nA/KBm5ExcIc+GlM5mnH5MEzkBgEJUQSHugG7P1P9JSvLczhZbQ63S10RVIfg8e8ym7GuDGlX+/bUaF63sqS8TMs2uAs/VIjEFqT58hsjxS1df1d9o6iSY21/X/fw3LF3hEBFwkTxHRqXiwUQv3WUtWu55fmH9m3uJpPBxEHth2jxo8DDerLZKVaKGhC8Fmtt+q488KrNYY622MnodEfX2EyPs7w8t3pp4+N6DVe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw2/0j+TvFz+vfEGHbEesqhtikbBIOQULdQ1PUPYlEE=;
 b=QdqTuqaatc+TL6GwVce+Te6sV6sGzvV7fIREIqFwWSjuPR/a7KakTR95pmsUQLCBr4nVpBm9VQN9c3spbecfghRncbdoig88SqPuEL7C4gh55W1IBKBQS81UsHZyo6CV8OLeJUxkJpFquuvIYMdhYzm7EqtQ5wgxLLf1nMGR56g=
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com (10.170.210.140) by
 DB6PR06MB4022.eurprd06.prod.outlook.com (10.168.22.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Tue, 17 Mar 2020 20:09:48 +0000
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::c9cc:78ea:1bdd:5094]) by DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::c9cc:78ea:1bdd:5094%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 20:09:48 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v6 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors 
Thread-Topic: [PATCH v6 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors 
Thread-Index: AQHV/JgCK4brNl3820yH+6y5mOL1hQ==
Date:   Tue, 17 Mar 2020 20:09:48 +0000
Message-ID: <1C2C8CD5-4BF0-40AE-932A-4AD506664B9D@norphonic.com>
References: <84EE5291-D8C4-40D3-A75C-92362BF9DF8B@norphonic.com>
In-Reply-To: <84EE5291-D8C4-40D3-A75C-92362BF9DF8B@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [85.166.70.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db729323-e5e8-4674-6df0-08d7caaf24bd
x-ms-traffictypediagnostic: DB6PR06MB4022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR06MB4022EFEE03DB8A71B77CFC3ECAF60@DB6PR06MB4022.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(199004)(91956017)(76116006)(66946007)(6506007)(71200400001)(33656002)(8676002)(81166006)(81156014)(66446008)(66476007)(66556008)(64756008)(36756003)(2616005)(54906003)(86362001)(8936002)(5660300002)(26005)(6486002)(4743002)(6916009)(6512007)(2906002)(508600001)(4326008)(966005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR06MB4022;H:DB6PR06MB3048.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQzGVi15YgX33mojMX0BG05qPIi3De7lHFdrzntCrzrJ9bxvbxJTALtK7abhzRKA1P57HzMqUxEAbp8vkNwrc+RAYZi/kWBT1h5/agxAXwIZBmM7W8/PWCsvvBZVS/ZJO5JqX7sGCxuCNZlT4VeyCb4i9BvdI2LslvecV7VcSfbvXwUotzTAXfZrOxjxXEnEejuwrRnr5jT6UPvnF+h3sUzujoiQ+Rp7QjqzKZxFZNjwJetAocsGn3q/ABa2BjW2XyMxveosPsMatk67wiMCOmrcI9v9F5I5KC4q0bemY0oH60H/L/AKY0A4F5jKXUGQxgcswYEmxb3+LXa746qM/m1eWg5AZEBglg1I0kASCPhaBr+8ragffJWvkoB5pqvPBCBTkacf4IVIErTsLTvJmNuUv9syvWucdQAzxZUx9pXOem+/Yg8/iDzkVF5P/sqwVguoILGi0nc7hhAeH/YMDm2iDnzteZomosPD1hxbB1CfHgy31nJxjpvmangxX5fasgRTgMXznIujkFYtLM5CMQ==
x-ms-exchange-antispam-messagedata: etovlWk8CevpUoSlYDKW2mMfsHJaatZSFtSmJZRv8gPB+2mVklhlhf7jFpJpR6KXFpMDjDXX0mUnnHRkhDgP9brQgtiB3HHDmlGlNFBQYYHJk1d/zoKMk38gTYFSpbDQy84m6/qNL35Tn8g6eQ96Pg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A479F18FEBC5A46BFE84B5E87D23497@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db729323-e5e8-4674-6df0-08d7caaf24bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 20:09:48.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRHIQqJmvQqlRHbHU2BmEx7B5eb3FiKKkClW074PabNJs1RidI7JcsUHsqYpNCHJibrAMA8kW93u7wEiO0gVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR06MB4022
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

