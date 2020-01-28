Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94E14B48C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 13:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgA1M5n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 07:57:43 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:30906 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgA1M5m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 07:57:42 -0500
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
IronPort-SDR: mJeT8Udi9U9MmAA0D2IVps1hnznChJtOfxQ28M54HjbwFwAieV5HOG92xD5qF/jqXFeNtHPDF0
 MCZmcNKbpmKuvUyLQ2Fo9UWImsn29aKcMo6FWoJwjEA+f5BLsl5HYAf+mEfSfo/PEcsFOt0kZs
 ks45iuVEJhNwEnXz2oZC7w/rjzo1DGsvQO6vVv9XwV1twKAhG4AmNukx/TdIKT0ybsMae/P9Iw
 FFtISsvv06a8EPXHOma4Bu3a7/73gSjRHUrOcjMdWYpIOt47/jbKoJJnik0bKvcv9MCMyRDK9E
 rZA=
X-IronPort-AV: E=Sophos;i="5.70,373,1574146800"; 
   d="scan'208";a="63960358"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jan 2020 05:57:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Jan 2020 05:57:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 28 Jan 2020 05:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKLHdfz2ymNCXXIM/2rmv40eHWe85guqhByvmeLOIKnnbSJ8oF+0uRT93VPls/4ZWMmcwVnXDDcY1TbF3gzcYHQqcPyQzStBWo9SO+qIda9a8XoXqdzbfDBxtTvktQXYAw3wICONp1NOZJpnMbCnSk3e/WNB0XLEYG2nagBfqWftzKeS2ezoR12euBWfEp9NCKUi/JNGKXR9CAsejvFmyKLP1ufKRptQs4sR1WRHnkcAdiXVgqWa36Xtpf4i3R0w1LOErZqFBiMQufSF9Im/lYx4kWZH0eZEVswIFfIl+QlF3uxsP/a3ECNnICH7GlKagZ7t/ISTDUGBTTmoVSoBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhs6f7oQUwU0gOwRfNxmUhiZW5v8xRmmgy/AsreIpWU=;
 b=ctQDbKL5058coOWiLITdIg+VTUOHWtNK8chWD6LC9acWiUM/hy5N1RYDgNs18cMrDTxxMHIa2wmCMowJAl5b9ZXAFRIanHmDpUcSRdMRNeCLg53R2g3Xe/YfboZePBT3OwT13j4a8lT5oKtEcLXPbt+ze+Wou60bG7wm8lOz/ul1RZmq9ce+GpxYtNg/iaG3FTiLJ2o5upzlUTMD1VhhcA612lJ4Z/18NfTm/21TbR2UsnHSptFPi/kTCEv+2bUx0O+UjvbwwBqr5NpQv4G+zJSAN3bX00iPPdAYEyiq0W7P6xthDjlWHMcp+nQCEkN542qlbKUHhP0BziU95lAs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhs6f7oQUwU0gOwRfNxmUhiZW5v8xRmmgy/AsreIpWU=;
 b=U2/Uk32QKkqTxDr6LVKNWNgjKaaWupUGCXzai3+WqXLVoONa7T7LlgBVyziDIonmkmOseQWxPPDAzFxjMHJS4q0lRrwEK4B3gKoe/nxzLaMwRbGPReIj1YRhnFKpGDi8a9zBaR7e+aySENdXix9yRt6+reCYzfKr5VAxEbxFGkI=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1852.namprd11.prod.outlook.com (10.175.90.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 12:57:39 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79%6]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 12:57:39 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <alexandru.ardelean@analog.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 1/3] iio: adc: at91-sama5d2_adc: fix differential channels
 in triggered mode
Thread-Topic: [PATCH v3 1/3] iio: adc: at91-sama5d2_adc: fix differential
 channels in triggered mode
Thread-Index: AQHV1dqFsAVAQA8Fs0errk5mUZMqBQ==
Date:   Tue, 28 Jan 2020 12:57:39 +0000
Message-ID: <1580216189-27418-2-git-send-email-eugen.hristev@microchip.com>
References: <1580216189-27418-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1580216189-27418-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a63857a-64e2-4f02-7487-08d7a3f1a828
x-ms-traffictypediagnostic: DM5PR11MB1852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB185236701DA1D1101CFA5CB9E80A0@DM5PR11MB1852.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(6512007)(2616005)(107886003)(76116006)(54906003)(91956017)(110136005)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(8936002)(6486002)(186003)(5660300002)(71200400001)(81156014)(4326008)(2906002)(81166006)(478600001)(36756003)(86362001)(6506007)(8676002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1852;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9v1GP1jHW7pkckk6TpB0x9xvNnqzZ0hqKcsjetnp6GSU0W7etIxqlDVzF78fwdMGYB+SuCfWqazvr1DlElqBW5E8+C9iAqeVVhlf2gF3YcudjLyv+FlSB+ruDDJHv6QgTAa4cmHeDV0+iYhL3PBFiNOHKgFYjhesyDYSwwhZ3rNR3JH3gWU49hkBHTlRkxFyxJart7LR/gjbb+gi+2mD0M6l535vbqCyNrAltvv0SusccfS3CwlI/P1MHUdwE9XzPMDwzIkolyQCJn2DRiNEZN28j6jJjHBTaKm5zihqMKKj+q6YObJX9cxjjJKTmxp+GbwXvxTT2yD2igI8Gp5/sbaH2zCaq8f93jgUCv7LJhlMYizb4gcu2ZZ/MdQTSdfqRJED9R1K22G3mqGw5gABew/P/iRNS/Ct1szTgSJI7XTHIIct0RlJzKmlqLCsQsr
x-ms-exchange-antispam-messagedata: 9AY+Bx5MYs+vHQ0q6HeILb6dkKCPdQ465C1VgesBGb6xtoo79RNZIF8dze1AMYa+KX5vNse7ARAdns+eYqvoJ8SttqWHv84w8OSMl6Y4Nkp0Was6ltLMt6lUD7wzjghaHBaXpORnIjye073QcKLRCA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a63857a-64e2-4f02-7487-08d7a3f1a828
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 12:57:39.5985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qk4/eNQTMfkWPQhlRuZ7uFm73d6K6Ra9C280mI7lnLxw8uyUEjNNwycKRdXJ52cIrNYmtcvXLuxr1NCVA7dTKZBkvLULZwhBKY50zxaFWnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1852
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The differential channels require writing the channel offset register (COR)=
.
Otherwise they do not work in differential mode.
The configuration of COR is missing in triggered mode.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer=
 support")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
- moved to the start of the list

 drivers/iio/adc/at91-sama5d2_adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index e1850f3..2a6950a 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -723,6 +723,7 @@ static int at91_adc_configure_trigger(struct iio_trigge=
r *trig, bool state)
=20
 	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
 		struct iio_chan_spec const *chan =3D at91_adc_chan_get(indio, bit);
+		u32 cor;
=20
 		if (!chan)
 			continue;
@@ -732,6 +733,20 @@ static int at91_adc_configure_trigger(struct iio_trigg=
er *trig, bool state)
 			continue;
=20
 		if (state) {
+			cor =3D at91_adc_readl(st, AT91_SAMA5D2_COR);
+
+			if (chan->differential)
+				cor |=3D (BIT(chan->channel) |
+					BIT(chan->channel2)) <<
+					AT91_SAMA5D2_COR_DIFF_OFFSET;
+			else
+				cor &=3D ~(BIT(chan->channel) <<
+				       AT91_SAMA5D2_COR_DIFF_OFFSET);
+
+			at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
+		}
+
+		if (state) {
 			at91_adc_writel(st, AT91_SAMA5D2_CHER,
 					BIT(chan->channel));
 			/* enable irq only if not using DMA */
--=20
2.7.4
