Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C782010FC97
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 12:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfLCLlY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 06:41:24 -0500
Received: from mail-eopbgr140093.outbound.protection.outlook.com ([40.107.14.93]:20753
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCLlY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Dec 2019 06:41:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEKLRGB+0T2tsPRgHLFkvxuG1dA1bBXU7cjfY7W+p0onTshYRS9nmP9aG5LF/rDo3mVN6mDRuiESrAQApawQ/RYcEe2mgQfgnBiHVOi2EdxQfOHrRSKdbFZYU7FzmjYjMYStoZahe6Btx54xfXOdTe2ffwNx2F8i+/4OnIcWcoOTpdUMDeBEABOXSXb7or7GOt1airdC2hji+q/DCJmCbhjfMlMPusHoOUaowqsuya13gRLjztXKPNHEKl9gSoegxTeW/mWKwBUjUVK70Ic9ydLxs2FEYCCUNiq3LPkrETIQIjpQIdeStqsAvZDhMuwkrf6bngoawbXkJilTuN/zdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ltHlSSGTTv9gBlvFtXOLq6F3PYfdrwjpDJqDw/Me5c=;
 b=gAluNVxDY1oKL95T09/zLewx5RkKXIS2VtEeV0Alcjy1swUEUpmbP1QC0QUsFUvbi5Iq2iMnjBXVbIXMXGAQ/q4Lq4AwZ9+9PPeVcwK6g69lr2x2oHNQv30Ksi56IDtINyplXKRQT8Qi7nFWaWPplHRIIFkbj2jvxUXLCFYe2IE+mI9j/k9r/Sw/EhK9/s3qFFFKA8++xIIHHcAN6yI5n3Ik5SJbJ/OHkxpEBR54I7XRCURtyDdpAeduu2f8IuLvtVrbQkWLr2Ihq9AIfYuauM6jmcwSU6WaDJaZQDpMO10uFOvkiCey4h7OArBFjy2v4KEief94zOm4mXtyTMNCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ltHlSSGTTv9gBlvFtXOLq6F3PYfdrwjpDJqDw/Me5c=;
 b=qFl7P7ck/5DWtpEbNnABbhpW4mr5oI4YM1anXM1aATJmQqEa7rBtXdwmP5bYkeG8JGBf1kZ3e6djpWPVX0JY1GMWi/yArrwDMCdUa+L5EG6edIA/Slwk24UPjSVt1T8QgyxWlrsKuzE2k9MOfoVaQTs1biIZ3RtFRIhTXiGyfsQ=
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com (20.177.202.94) by
 VI1PR06MB4926.eurprd06.prod.outlook.com (20.177.202.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 11:41:20 +0000
Received: from VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::a56e:b59e:d95f:c568]) by VI1PR06MB5790.eurprd06.prod.outlook.com
 ([fe80::a56e:b59e:d95f:c568%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 11:41:20 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Topic: [PATCH v2 2/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Index: AQHVqbJMfpKrRQ8I0EaPCVpapGu9uaeoQRYAgAAIrYA=
Date:   Tue, 3 Dec 2019 11:41:20 +0000
Message-ID: <76F5F343-49E1-4D7D-9A7C-FB5A3C1C5862@norphonic.com>
References: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
 <E9781938-9BFB-4978-83AB-B17B0BE01BC3@norphonic.com>
 <20191201123807.41f62181@archlinux>
 <EF648C3D-28B1-4509-AE3D-F24668A6849B@norphonic.com>
In-Reply-To: <EF648C3D-28B1-4509-AE3D-F24668A6849B@norphonic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [2a02:2121:34a:d3d5:58e0:9a3:8cfd:acfc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 563e0367-2276-4a11-d596-08d777e5b76a
x-ms-traffictypediagnostic: VI1PR06MB4926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR06MB492669A3FF3C4E33A9EDAF30CA420@VI1PR06MB4926.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(189003)(199004)(6436002)(6486002)(46003)(6246003)(4326008)(229853002)(6306002)(6512007)(99286004)(36756003)(54906003)(11346002)(6506007)(86362001)(102836004)(186003)(76176011)(2616005)(14454004)(25786009)(33656002)(508600001)(966005)(256004)(2906002)(7736002)(446003)(305945005)(71190400001)(71200400001)(8936002)(5660300002)(81166006)(66446008)(66946007)(76116006)(91956017)(64756008)(66556008)(66476007)(6916009)(6116002)(81156014)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR06MB4926;H:VI1PR06MB5790.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JH/mS+NJMXtI7flOBJujw+qvBIbfsGbuyfpZ1DjvYOC8DlOQOpxC1kJmbyDS9GnSgutntOXhFPn6c1vAJQFW0iUr9lLSWv0yC4U3Y2gGovFX5RD7kVlS8cPpzLsLhZgGmvMfCmBhTEEPG9Y4lHKDs1wMkjbi7RL1+Tog1UakNZdKXGMIUJklcQXzQExHq8bWj5jA437VR0Dw659WelSNhKd5twRfBr8TKgmXxsILt5l7vI2r7QjOtWm4nPkayN97UPua3kZtI6nosTGJSruPKFm2Ky83iK+GIZNHrLoyT3nlE0by8xgW/UWPC+yxcmTYuIXx+rBBLskzFhwcL+yABTPHhgPz5dN3Zf8tN4tqUDI+ptJZA/DC1v3oNijCDXFscAzF09zgVN0eYmQ39P1QnSoq1vMu67/NjJYgkd9UCYuaNHaV+fU/1tlAmyPANloL3KDLY9VjhymJuf5rDA4vgIaIdSfi7fnITPJR0t5is9I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE6457950D7B7D4E8B14B702AC021923@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563e0367-2276-4a11-d596-08d777e5b76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 11:41:20.3603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbYG7V4cRWqQSq484Qf7eSS58sH2OFLcG3N5p1z8SNU4s/hvShSBJc52VPyxknTLUeFzkTp436UP0XFNO8UpOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4926
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The previous was mis-formatted, sorry for that.

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

