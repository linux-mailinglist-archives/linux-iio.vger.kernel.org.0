Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC5124D6E
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfLRQ0B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:26:01 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:12945 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfLRQYK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:10 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: M7dHZ7vzpwx+AmVyyYJZAp5nH0LSNkR7LCqqju9Gfj5Q9ca8n/TAIyJpguxdUghERhb6HS7JOZ
 up9fyUYSDATd7csIAvcSWLtYBOfrKjk/GzRpHllTCa0Z1guJiwBtNq23SiTa/E9EDn4ssAfQwh
 ttg8wXmE8dz7T7dwwt3BVNXi6z+XVSrwv9HW5fIyU7RP1yoC3KsFJ/FbkjVQpPamqURWs3D6GM
 Mc1qjD335C2WLVaPXuund1t7oilta4WEhpZMP+UMN1eIaeXLeawO6QWbYpJ+1SZW3k1VCSoZHS
 joI=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="60223195"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 09:24:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3Ip8FAIcdXDLaylShXTGGIpCcdbftp2ydBGE2WX94sHwZsmTh0raOuVYqqH14wFEDEo3j+wb3Jnw9J9lSig3Xp99YAGBEE+L4gdYMmc1o00YmLkXFkDX9YEVNHBMi6Zrsu8dcU72AyXpvHjx3m9UVooIbFakEjWY2ZtGRQHT+LEthyIHCc8DQlMa6B4iuAYhcRFssIFatDP02QEc7S+HGuQG79jv7v4IE3fh7PXFl1jcDl8qt4wE90V/OdNHm0eEegOU0O7lgu5zwh58TL6k+jG8wqX3tRoALPovQ1nH78FXiIAO8+NLzivXeJd8txZ2cjHQFDt5yiqerHoIxTVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbaJagXmIYCqxQfjE3h38mvB/9lRN1J5e1UgEO7VEfQ=;
 b=UipG6lZAQeq781ZpQg9WiB2pu1x8/6tVQT/4zK0zAUgi8WygUB7IEBg9fwjnW9X7XaQIsvQEKyTkl39/43r56qbm+8az575Z5X3hP4BTMl2WQaxBxiOnrFmV2n9QbftYezT44vLDtIljT1Dw8GmhS2ymXb7jJlIeBkJzLNNnGqpfOGgVlNVSgKsEhbjljMG5jO3uBENvjF2MuFJvJf/oNBUjozMcJdkx18dg60gsOALFE5Y/c4OuwvYGAxlPjGgObxK6X5Y6wqHhw5moIfxaW3mLoI8B5ZFeV+C5C4/3j68EuLDXUseMxT5k9BkO/lSHV/MIzNdRksw61FC/Mgjn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbaJagXmIYCqxQfjE3h38mvB/9lRN1J5e1UgEO7VEfQ=;
 b=F3Dq4g4loMO+E7TfbIUHAqubZOSPIQlX9znExFzwR7ZR0GvrALg6lvoY3AY9BldqYuhH9WcMUTpzJrr2oTc8D5/qEfaad+HiH0alTTXaigoq+TvB0gzXyeKgZ33xElLVHTiDJ7rEg9Q7QDb4qDBHX79s7KEj57Prp49JRMCrDxs=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1913.namprd11.prod.outlook.com (10.175.87.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 16:24:05 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:24:05 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 09/10] ARM: dts: at91: sama5d2: add rtc_adc_trigger node
Thread-Topic: [PATCH 09/10] ARM: dts: at91: sama5d2: add rtc_adc_trigger node
Thread-Index: AQHVtb+PyD1+Bcfc7EmGzl4Waea2mg==
Date:   Wed, 18 Dec 2019 16:24:03 +0000
Message-ID: <1576686157-11939-10-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b54f1599-1f60-4706-5ee3-08d783d6b34d
x-ms-traffictypediagnostic: DM5PR11MB1913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1913843980ADEF59F1F46D5FE8530@DM5PR11MB1913.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(2616005)(66556008)(316002)(107886003)(8676002)(71200400001)(8936002)(66476007)(26005)(6506007)(2906002)(64756008)(66446008)(66946007)(81156014)(76116006)(81166006)(5660300002)(478600001)(36756003)(54906003)(186003)(4326008)(86362001)(6512007)(110136005)(91956017)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1913;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXQoCz8ms76O+8qQfZ8cGE6AlQWMaA7QQGQH/IwnmotL4hcUIWXcBFe/wtJNTOPQA9eXysoE2ZMgjyixLB2U43ZZa6B5ATEbFC1Sg+eiac+9020AT1Pb8ji7SXYTHM4FH2xOWhr2Cu1SzP+XTOM7XCRqLVOo8oFt3B3mhL5+VZ6ZNIBwBgMLc4cxP2uzrAujDT0ERR+vuQ+xtPBFBvJNmM//auQy7W9P+xhdfEMiCifQS3/31BflvjMoWhYBUv7csMOmzgPTaN31xru1zonB4+7ysCVwAfSOHRwzhi5n/QSCi6KaMkEJ1XD8W+JO8qBEc0fgYJWK7RNOC1eATtLhtkHUrHmkq5HfEOUfq6qAD+v8Pr/RbYxQpwKlJXKqu1kIBBHZqHDcLbRiCkHqSLUIaGtFHUAweNWzheJ43CXNQTe3QYDGjrhdS/4/oshCCS39
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b54f1599-1f60-4706-5ee3-08d783d6b34d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:24:03.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GO+1YVsRzx55QHoZyEFyE9DBKFLUlMEUlSzO/4MmJzv7fBdmkDy2qnO46EC3zp28aqvF5xd4yAiwulWvf8weDL+OGabpqQ7Ylx9/Wit0xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1913
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add node for the AT91 RTC ADC Trigger.
This is a child node of the RTC and uses the same register map.
Add a link in the ADC node to this new node. This represents the internal
hardware line that is connected from the ADC to the RTC device.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 5652048..c2df369 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -694,6 +694,16 @@
 				reg =3D <0xf80480b0 0x30>;
 				interrupts =3D <74 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks =3D <&clk32k>;
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+				ranges =3D <0 0xf80480b0 0x10>;
+
+				rtc_adc_trigger: rtc-adc-trigger {
+					reg =3D <0x0 0x10>;
+					compatible =3D "microchip,rtc-adc-trigger";
+					status =3D "disabled";
+				};
+
 			};
=20
 			i2s0: i2s@f8050000 {
@@ -856,6 +866,7 @@
 				atmel,max-sample-rate-hz =3D <20000000>;
 				atmel,startup-time-ms =3D <4>;
 				atmel,trigger-edge-type =3D <IRQ_TYPE_EDGE_RISING>;
+				atmel,rtc-trigger =3D <&rtc_adc_trigger>;
 				#io-channel-cells =3D <1>;
 				status =3D "disabled";
 			};
--=20
2.7.4
