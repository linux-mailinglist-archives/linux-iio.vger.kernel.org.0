Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D2B1D8820
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 21:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgERTW6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 15:22:58 -0400
Received: from mail-vi1eur05on2120.outbound.protection.outlook.com ([40.107.21.120]:15098
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727856AbgERTW6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 May 2020 15:22:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtBkHrRthqvuiFsKAeZL26TXuVONqZbqmxujhxQRS0T/cFKQOKpGWr/+0ijsOtwQQ3UN8WJYyizeu5p+TeVtgeM45GoS0El/6GGIEXq1wWJY0BsGOxcQeAd6Ypjib3YxvDLeD3Pmrx5ybD8cjcQ7d3z3G/HafTO8/RSGQmE17PApZhE4BHVnHRzbapQ4hl694Utn7nLJZfTLUIt9VzFRY1x96+lMGE8lNXUusm7ScjCcjmq3IwvPCXWh0UWe3/T92qgRY5gpkMzC6IJZMi4ZXbN//cxeQ1EAkLUiUJ1Pt1ae59Oylb5W6tB7UVUtRnzVK448rz8LBjGVYjvGON1Kmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUrkj4Q1dURaGQ3fEBK33JWfwN6VesKujeCP8EaTMfk=;
 b=O+JLdBkycxyuZeqPkeilHbIkl8sKzxze1wFigAXnUKEY265FMcL4pye9HXrHm4F2JAhxK6J/ziNrpAOa7MJ6eNmdb7BQoofmIYkGny2bR20hxHNHWd1JkdeiS9hWLb45qiODg+ipaoPeHCNg2iiqt4Chra0oqX9IK9nLFeozqNyk0GFxmu1At1EjvgGKkX0XdL81qFaAepIngpD04uB8wd1BTIT3j1w3/RfO5x40uoW2jEKyJ5zWNSsn+SBqWs32gGZwbxGGxTi56pshyXiMCgkmavwGF0wjaidqEKFXu7umoCgVMvsqHPNPq3g6ICG+CDx3hr0vyJ3k/OWx4MxVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUrkj4Q1dURaGQ3fEBK33JWfwN6VesKujeCP8EaTMfk=;
 b=M080ZOWlIgL2KI8Av0x33mT/ppLDJhRq+R0REq52sHGQo81R50QIQebg+b9CcxexxDpcnPAmVdh9jwvxTNFTa8tVVzXsTKvZmsJeEf+jQQT3/iO6UQWuH3qQpzzKdkEPT1yvMcs3MhjKqt85qpTqvMpWQPFj+Gbn/zAHhTERwlE=
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB5304.eurprd06.prod.outlook.com (2603:10a6:20b:90::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 19:22:54 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::6505:f0e6:d0df:c1c0]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::6505:f0e6:d0df:c1c0%5]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 19:22:54 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v8 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Thread-Topic: [PATCH v8 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Thread-Index: AQHWLUm6dQJ/IYb/sUigWPgiv6JLvg==
Date:   Mon, 18 May 2020 19:22:54 +0000
Message-ID: <3309CDF6-5DED-44E4-972B-6D741ABE541E@norphonic.com>
References: <5489E47F-47D4-421A-A7EA-E11B0205A842@norphonic.com>
In-Reply-To: <5489E47F-47D4-421A-A7EA-E11B0205A842@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=norphonic.com;
x-originating-ip: [85.165.43.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4009c17b-15fb-4efa-5b8d-08d7fb60dd32
x-ms-traffictypediagnostic: AM6PR06MB5304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR06MB53045F260342BE1FA1B7B864CAB80@AM6PR06MB5304.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ckHwCAVKMz0NLapqnXIg6GGPZXUAMABNvLoeXXb7DIzR0NDTWLl2jtj3Wv7T8nSjMHsPm58j7ieyeNHG66rFN968S/cCJ2PTzEkJ62y93aE8lscLtdAegKMtZTYnEmfZHgsAYO6K2jbkqv8JSvp7YB+BV1C4KVoOVhzzsiJWKyFCTmLtEN5fhd9CH0v+nut0JX7NOJtLGNprawyHlWkazu8yzGxWi1qlhpbkU0bVyFP9npeY5/E4vcJGPmjwcpd5A6FVyTcMb+an7ueHFieYxq+IQK89SJ5njAjRUGbf/JVLnr7mokLiDkAsmNOhvY02AROgVcd4jsiyYUiX7ngwsru3SciJ0v8lrfFkUQRNzM8BWGmNYu7GA5TNgudbstzwdIqEKrRb6raQY6tIxhe+XHNalSzAUVTScj4imSYDvwD+zGNBlvxKEBbXudRXeVDkeZKDTgWdXJCFiVHL37/KYag2Vas6IdbvfOVcSjXdD14A9fN2PquDu753pVDxbpduK9xU5cZVq+rR2Sazua7hOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(39830400003)(376002)(136003)(396003)(54906003)(36756003)(71200400001)(6506007)(4326008)(8936002)(76116006)(66946007)(91956017)(66476007)(66556008)(6512007)(66446008)(64756008)(26005)(186003)(6486002)(508600001)(6916009)(86362001)(8676002)(316002)(2616005)(33656002)(5660300002)(966005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TuisSLoPRkyEf0jQwLoAtJVAlrf09bYfIMeg+f57GHATV4aOatiCO/ymKf3dkzwLDnoUTpMJdf4EI/jveeox8dmISn/mT0+EV3dyYTlw7xqTDQte+YQ3zVA8SIqvnar37MGjlL7C4bqGvsrqPoFFDQXjlj2S2M39RNsXQA2D7FKelhmAphViG2Nv1RuGlIv6iftPNW4TXJLNYAJDlZ8Q2uoRStDQSXGVSQMI3xPTZOItwvR/rRnuwvlWRljiF2M6VP6i9CYtSotGQPo7wUa8mUFC5BRQCbFxpLpJJaDQm1xmWZ8DzTxWVC5Zy2tG0HHV5VloDN3XE7Ujfac1YmiSj6GoWfvVO7vXlDw/lW8t/rhcLEo3/UXwjuQ4mGc7NjGoFsfBfvDFWzvbt/beci2F9KlmyVqlys1Yiyjk/NK7E/2hCVm9KrTiL15lZYqZ0pnCMTgndv8lkB8BlC0vYmTSimUMkxbty+MKntFfF0a/bh8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79DF71C84812A245B2F87C4CFD246EC1@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4009c17b-15fb-4efa-5b8d-08d7fb60dd32
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 19:22:54.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dB2tqMOWayBEXrpVDO3I+MF2oCCYcxtkI8z8qqK4UlwnkcxOTJ6KP0/XMCQazODZEGBYXdtjB8IQZ5UwzOJzOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5304
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Device tree bindings for HDC2010/HDC2080 driver.


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

