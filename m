Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9535F124D29
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfLRQYN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:24:13 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:45033 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfLRQYM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:12 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: f0jPY7UzWK3uy5i4vWafTzmhqFjDVAg+qGCmk2nIwBESFp1eggXGvSwKLmrgrJOAEGLSGwYn7P
 fs5MyDsXEab3q0xdtlUA6xhjC7KaWGFxHY4Zs0oxrwHPmovAsCNJenka4bVt995RodsZMagKDY
 isoEPncwl3Lf0pcA8HU01QE6s0ZofU2GfxsNhTqut/Jc50WCRdLEKE1VXeWfOVhXoCNiM/JWPL
 4JcA92vRVN7K1K/Ca4vnPAIhB3T6ROy4/NRvs9VAvRYi7tlITuNNTiBWEOTr+0aDItWr8yiqsV
 xVE=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="58926955"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 09:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQsEXVYgkolQSY3/wudvrRNeDFuAFBhaQmPYECu1kn5bT7+2YIoDumjqfZ7lOI9VFiN5bzkGBVc00oBNC0F4i0HmdevbPQ66WoQY/1L9Aa9rNZ6pbpnm7cZzHdI3bp+HWRAt/uYL9ZndVC38zSx+rIiZfIVi/zakT0zyK1O/+5zUR+k192IqMteRvJBqPNPcRqh3S2Z6txQjEiq1qgLt3Es0VAzMeBGtsbc+grAknQ02F5RKvEuetf54zbY5MN/uoM6SRMJa67adBMiAnXKSnqJGKJBbsmBn6wbW3ib/JaHoXycVTderxfW4VOBYANC5x53f38nY6RsO0S5w83r9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgF5MxWy+kD9TgHOvNEM2fPe3tHmRhpvGCMtxK1eJ7w=;
 b=ClVgXeyr3+J2b9hUmaPLwe4MSursG3r8RuGh/KQl/G6jc9Rnd5eJHVc5GpSYYOy+hZTXGouulhIcDBDCyuLNLEFxUh00as9QHRh7jrpBwigTmtnpwEPtlzGCDOqSsXLgb/mBL47x+8goxKl/NCNK8Ys3LoZ8M77bCf1lBjPmQ9SOD3XLaUZd9OsoQQ6KzNwQr7WIzzzMm49xtYX12KSlcaOnZZLnLMMah+R2jV3GKsy/bEWCyOSGDXDt5BGmFPyQq90ZTautGf51WdI6VnRqenD87ey5GIHgopO1yZbeSnygSRWQ4yfkApFP2EvIzy9vrpvMEk5EBMh3l6EER6YIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgF5MxWy+kD9TgHOvNEM2fPe3tHmRhpvGCMtxK1eJ7w=;
 b=GXrfgLg0McboRS8iBYwCZjV1LsFLekAon/oWtjBgWZ6G+3NB3/6Xw4ICpvK4WRoalmTZijxQmyDmjZhvVJAufj6dqgCe4XoUTUlxT53bwStcACQXhcYkxSCIFY/pfLCOjhXHjGI2u0axRvnfQkjfvsqQc3E1xxQzSpmI1XSp6e0=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1769.namprd11.prod.outlook.com (10.175.87.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Wed, 18 Dec 2019 16:24:00 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:24:00 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 02/10] dt-bindings: iio: adc: at91-sama5d2: add rtc-trigger
 optional property
Thread-Topic: [PATCH 02/10] dt-bindings: iio: adc: at91-sama5d2: add
 rtc-trigger optional property
Thread-Index: AQHVtb+NqLUQmMTAWE2Je79GFXwa4Q==
Date:   Wed, 18 Dec 2019 16:23:58 +0000
Message-ID: <1576686157-11939-3-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f44049a-f87d-4ce5-5e78-08d783d6b08b
x-ms-traffictypediagnostic: DM5PR11MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB17692543481FF5CA3B4B8463E8530@DM5PR11MB1769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(66476007)(66946007)(66446008)(76116006)(91956017)(2616005)(64756008)(66556008)(86362001)(186003)(316002)(110136005)(8676002)(54906003)(8936002)(71200400001)(81166006)(478600001)(2906002)(6512007)(26005)(81156014)(36756003)(4326008)(6506007)(5660300002)(6486002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1769;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1DqkBM+wHpJ/qNxdyTgzawMlyo6knEOhhnqqxpEXL9MEo3b7IExrptCwMYK209tI8HNcUQP3RoV4GpzPujCvlEWHZTHE3rX/s81hmBXJe1gEI6OVUURS2G/TKiIwGxdzsQeuh8zdLBVPKA2OVM1nWHZ+gpEbQvjlNqsf1HXbKaZ0H8A3XDNQayd/vPJRy7QyhzvL4s9MNQy9IjfJV6TLxW8iSIr8AKVEKgHdvpYhdQsbBKCbZsf29LCbWlKPiPwkekBtgtLINIpjm9tNtLkqusljiFXdWGRiW8w2Xp0KG6yxETpDwFtSGdEY+QuV5F7eRIu1innfZVGDw5XbeNJZyNWGI9usDRaz3sUnADqYy5L6C3QlzgsLtfrJPvNAT8lQvHgap92RBQQVoc10Sja0Nf9djPLV0JfExydbhDzLoJtnXl0LKv4TC3tjsBa0srSm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f44049a-f87d-4ce5-5e78-08d783d6b08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:23:59.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Kf/72/Y6MchjDbrn5657HoIcH9mfjPwQ2UGhezKqxfhGEGOJq8edTlmYA8yHq+4VElWDQewvQxwRdMwlBfX3c21ssdAQDojvrkeHrW+C7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1769
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add property to connect RTC-type trigger to the ADC block.
The ADC is connected internally with a line to the RTC block.
The RTC can provide a trigger signal to the ADC to start conversions.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt=
 b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
index 4a3c1d4..1980f0e 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
@@ -23,6 +23,9 @@ Optional properties:
   See ../../dma/dma.txt for details.
   - #io-channel-cells: in case consumer drivers are attached, this must be=
 1.
   See <Documentation/devicetree/bindings/iio/iio-bindings.txt> for details=
.
+  - atmel,rtc-trigger: The ADC IP block can be triggered by the RTC block
+inside the SoC. This property is a phandle to a node that provides a
+trigger device, if the ADC block supports it.
=20
 Properties for consumer drivers:
   - Consumer drivers can be connected to this producer device, as specifie=
d
@@ -44,6 +47,7 @@ adc: adc@fc030000 {
 	vddana-supply =3D <&vdd_3v3_lp_reg>;
 	vref-supply =3D <&vdd_3v3_lp_reg>;
 	atmel,trigger-edge-type =3D <IRQ_TYPE_EDGE_BOTH>;
+	atmel,rtc-trigger =3D <&rtc_adc_trigger>;
 	dmas =3D <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91=
_XDMAC_DT_PERID(25))>;
 	dma-names =3D "rx";
 	#io-channel-cells =3D <1>;
--=20
2.7.4
