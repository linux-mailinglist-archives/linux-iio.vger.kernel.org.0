Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F4124D1F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLRQYC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:24:02 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32906 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfLRQYC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:02 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Pj4dhcNBKEnadabKBkLJr6CQTYxW7OjkSOB1cANzjHJsAmlKJ9Qpl88AoCoae1+piF1VYbw+0X
 Y4Sf+mm81IdiJyAHK2PhBPQ0N2hZCX2Rs2t1EMtI8k6PWA/IaqcD79ries6v8Knu6eSdMvybm1
 2+4EXdqc+hZpEqWqnXByMR3PGDoC+L5LrCpcHTes2cVQO4jmEcCMEhOwIvv/YYHa1mss21kxsC
 i7NEYtCwznZo11l6rUF5kJjCQCg1LExMY64ewX5wuoAZniwqFAvalTMZ5YAAa5djiUW6xvr5px
 xB0=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="59426779"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:23:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 09:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP/A+6l5W3Si9Lm4L+KmNhsrAiSJXA+PT0Z8jcibzEp4djtcW5QrovElkDbX6V9GM3VCHbxWnmHgAk1HKMevCNKB6rH31L/S57KIYtEAG6IbGKh1mytEXEe/NBn1jEJ1HvsSbg3WifV/2UPR2ewn+M+WLOkUJFA4OTgw3ao5lNm/ZMkKoodJ70Y01SUvPjmbQXOuwM1in1PKdZExyjmJiA44vlol1P9bTHt6uAeDnP6N6jTDDfNeShgpYJEo4S3eGwSJ4i2y14JP26sxDC0X1OH9DWloFZS6RPJ/PHIfeUlf3NJiPabjkkL/+J6wIl28kJ5tw62C69pPffB7IVZ78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkbxb1EvYc7ZEC/RY7x0LhCxXUt8pumOzfafB8ahW5s=;
 b=dGc1194ZqhltYd2KaGUyBmQDF0XeAV/R8A78XHcVWes0zFS69Si1ZEBD7qMke5cMHyyMdhF29y23DJM/x8bClqwchvhYzgYB4rwESiLW60UmSGOkPutQkj8CC/+Sli3HqQz+b+ERL00z50jHVRMR6i1BVveD08AzzAFBwZyElc6fGXG61e1vloxHszNvy9zoCK2QwBpxkJ5bnrQR0yyD3gaCAL6PDpamRdTKamuSfihXpDTiSEafmkQjlakbLdtUhmJi6yY/6KoyE0DZZTNujEL5AEJodNhCw6nnBYVB4GouuCbTIMl4ubDiAjUtr30KTt8xksqPW665J4ePhud8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkbxb1EvYc7ZEC/RY7x0LhCxXUt8pumOzfafB8ahW5s=;
 b=qjM3J37Kkb62vMVODHhSHORGb1h9sckkp+O/puCV4dOd7WO6/ISJrO5QB+kPiI5aVyjhQPuktrW1R5bhIir8CKFfA15RExTFlG2WuI2BP36Qy0XgtVlLGKDVTMMnErgyrf8f2ARfQKiImkMN/07BOmEsJr8V6IvESGhDzsVmJAs=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1913.namprd11.prod.outlook.com (10.175.87.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 16:23:58 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:23:58 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 00/10] Enhancements to at91-sama5d2_adc and rtc trigger
Thread-Topic: [PATCH 00/10] Enhancements to at91-sama5d2_adc and rtc trigger
Thread-Index: AQHVtb+MrR5owibMB0+1LePacD8d5g==
Date:   Wed, 18 Dec 2019 16:23:57 +0000
Message-ID: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80a705b2-8144-4f9d-da0c-08d783d6af27
x-ms-traffictypediagnostic: DM5PR11MB1913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1913D99BDE223D6267EBE2A1E8530@DM5PR11MB1913.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(2616005)(66556008)(316002)(107886003)(8676002)(71200400001)(8936002)(66476007)(26005)(6506007)(2906002)(64756008)(66446008)(66946007)(81156014)(76116006)(81166006)(5660300002)(478600001)(36756003)(54906003)(186003)(4326008)(86362001)(6512007)(110136005)(91956017)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1913;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMd3B5gmnN3fqJ49NdX1qCNxxpFCfRvTH3vsBDAA/WJ5z1sPhFvaE3/tCGahu8HSlHRvkchL0BU7x8YeqVNSsGBGd3+U6b63590fTylC5TYLlI/jEsU0GWZ6IbISKy8R115RX3Mb1d8bJn742UD6BlB14vqS1rutCrA8i/O8Wj+T0rUkuMKVfXAbYDCCzsQTc0T+eGBdspDlta0sKoE4hkBJb7rvWXK8OvVM/jzM0Gm8SLWr4WmAlXI0wpRJMc1sElDpgh8oUuvB1z5MQqm0jBEISCgTLSChI2oAJZSUn0do6esVxWrx0F/9WKXc3OmPyJeuZBDyFL1NXY1sE5G4nVvkmw7Y3wcx6e8kkXXpvETL4C13MThm4TMQwEeCE7R9aOoA70XELPtaqI4SuykZ/ZsZ4S5qA5euXUoHsB9ZTfhFZdhdzxvAgCpxAYu46g1M
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a705b2-8144-4f9d-da0c-08d783d6af27
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:23:57.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxzwzGRzhd5qNdDoHeVBwY42NsFXqV+qYWTyiux1yXFaof4+LjpdIqkE+/SbGLLECTcfTW7rk1XzoufHgkHvDQB5GnpPGwWpN1jVjPbaTFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1913
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

This series includes support for having the Real Time Clock trigger
capability for the Analog to Digital Converter in sama5d2-based SoCs
(RTC ADC Trigger)

The first patch of the series has been already submitted on the iio mailing=
 list
as
[PATCH] iio: adc: at91-sama5d2_adc: update for other trigger usage
But I also include here for reference since the other commits on the driver
use this as a base commit.

In short, the RTC block can trigger the ADC block to perform a conversion.
To solve this, I created a driver named rtc-adc-trigger that shares the
register map with the RTC. It's done in devicetree as a subnode.
This driver will register a separate trigger inside the iio subsystem.
This trigger can then be associated to the ADC driver (sysfs current_trigge=
r).
However, this is not enough. The ADC has to be aware that it;s being
triggered by the RTC (TRGMOD and TRGSEL). So, this hardware link between
the two IPs has been described as a phandle reference in the ADC node to th=
e
RTC trigger node.
At runtime (trigger selection), the ADC will check if the assigned trigger
is the RTC one given by the phandle link. If so, it will configure
accordingly.
The RTC trigger driver will also register to sysfs two attributes for
selecting the desired trigger frequency.
One attribute is RO : list of possible frequencies.
Another attribute is RW: current set frequency.

To achieve all this, had to make a small patch on the RTC to populate
child nodes platform data to probe them.

Fixed other issues with the adc driver: unfinished conversions on IRQ in
triggered mode, and differential channels missing configurations in
triggered mode.

For exercising this, created DT patches for sama5d2/sama5d2_xplained.

Here is a sample of how it works in sysfs:

 # cat /sys/bus/iio/devices/trigger0/trigger_frequency_hz
 1
 # echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage4_en
 # cat /sys/bus/iio/devices/
 iio:device0/        iio_sysfs_trigger/  trigger0/           trigger1/
 # cat /sys/bus/iio/devices/trigger0/name
 f80480b0.at91_rtc_adc
 # iio_generic_buffer -n fc030000.adc -t f80480b0.at91_rtc_adc -c 5
 iio device number being used is 0
 iio trigger number being used is 0
 /sys/bus/iio/devices/iio:device0 f80480b0.at91_rtc_adc
 3298.388672
 3294.360352
 3291.943359
 3294.360352
 3291.943359


Future work:
In the future the node would have to be enabled for other sama5d2 based
boards as well, and MAINTAINERS to be updated if this driver is accepted.


Eugen Hristev (10):
  iio: adc: at91-sama5d2_adc: update for other trigger usage
  dt-bindings: iio: adc: at91-sama5d2: add rtc-trigger optional property
  dt-bindings: iio: trigger: at91-rtc-trigger: add bindings
  rtc: at91rm9200: use of_platform_populate as return value
  iio: trigger: at91-rtc-trigger: introduce at91 rtc adc trigger driver
  iio: adc: at91-sama5d2_adc: handle unfinished conversions
  iio: adc: at91-sama5d2_adc: fix differential channels in triggered
    mode
  iio: adc: at91-sama5d2_adc: implement RTC triggering
  ARM: dts: at91: sama5d2: add rtc_adc_trigger node
  ARM: dts: at91: sama5d2_xplained: enable rtc_adc_trigger

 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   4 +
 .../bindings/iio/trigger/at91-rtc-trigger.yaml     |  44 +++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   4 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  11 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 336 ++++++++++++++++-=
----
 drivers/iio/trigger/Kconfig                        |  10 +
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/at91-rtc-trigger.c             | 213 +++++++++++++
 drivers/rtc/rtc-at91rm9200.c                       |   2 +-
 9 files changed, 543 insertions(+), 82 deletions(-)
 create mode 040000 Documentation/devicetree/bindings/iio/trigger
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/at91-rtc-=
trigger.yaml
 create mode 100644 drivers/iio/trigger/at91-rtc-trigger.c

--=20
2.7.4
