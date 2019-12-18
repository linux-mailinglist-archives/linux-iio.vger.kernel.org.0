Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F60124D59
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLRQYH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:24:07 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32906 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLRQYG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:06 -0500
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
IronPort-SDR: 54t8XRM829Q2q/CWuqD/LrgHY2/4F1miElyj+WbnYMSQTkqDteWZLdC9VsgsmdD2lLDoS/bfq/
 wkUbM4GZeXTvdFW0YGmCnaRee/JgoBx7dhDJ8qjEBYHihfpi+XwMcp9nvpCpILn0T8RTf/wOfT
 ZgBFRhHOwBaGPi5MT0pGBo+kecAeIbrrGsLiwNQDKJ9MggGGSinoqDVOEifgOilWn682xgucjj
 HuXy6K6pTB+unqVg/QdGYUz7fbcf4uyS2N6VrPwUj+QW2moX0b78IdPI7V3h2YqXQp7WqdQPiF
 STM=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="59426831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 09:24:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofKReA+c+mO8H6rxGzY9S5ANOykX+6h5qyZgQnatylGxsv/1lvOHtQuyGcOTJTQMwQfzsnymTlAGn5+6E+BZGWOcxjIHSKzRRkBSeTd5eSnuIXiUOWSQfVYR3LjM4WRao3WLNMxn+npxIzsnYzGa91jwkAfaAnh7FmLDb1SaUS7QBLWgNktpZj0XZeUDsPkK+ERpmQT4ZaMnaVbNsJ6i/5o3U0okAcwFL94EnqHsI+cUNcIA9b2R/JmJTyCjA7xYCCMtLqsaKgpcXh3Gj8kau0NanlCpwVTe27EJ7LAk+V1nBBymx/ImF6Z1ixza2xBKmd+aEid+hEFEtSC1qM0/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McsuxWfwAiDTwpWDkwexX3EQK7P5A7czExPwE95bd/k=;
 b=hdozcbTDDTTaDss4rCRZVgVtblJnQiWSqdO026MOGQZr5PUHqTnRZgOU2WsDLKjauGYFkbg3h1RzGacTW8ciPnUaLySk7jwoV8N/VwSnRVT7zrFZJtJyPUKY5hr+Bsn8SD4vTTHDBqtGp/KfPMGGb+D9zXiYFCD9CG4N2JUdW1TAEqsdYTblMFSACaZxYGTvaGfvUIFVSitHA2HJfG9yRHbXM+Rnv1d5I1ZTL1jIB9fi8RmuIa/5W9qUrum/DHP17oIjM28rW5Bawp5H60vIhglu+zoeOWnjdJNi47uIjjh45oQCStrmhOSWkYij1H0OxT1y8PEiLnp95OCna29HEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McsuxWfwAiDTwpWDkwexX3EQK7P5A7czExPwE95bd/k=;
 b=WfbfkTHosP+S2fneiaHS/bZtoa/uOtBS08IxzmLCrUoJy6efVg9b/7xCVFw05j78IBmZIOXcNI6cDeFmLtL87/Zh7CsFs8XaaT257Yeihl+nDJrYvZIbcd1fRBcXM+gqIW2jjAKzkBQjoAjvJ2FyGyopKXljLcI/h/elmMPDfZI=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1769.namprd11.prod.outlook.com (10.175.87.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Wed, 18 Dec 2019 16:24:03 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:24:03 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 07/10] iio: adc: at91-sama5d2_adc: fix differential channels
 in triggered mode
Thread-Topic: [PATCH 07/10] iio: adc: at91-sama5d2_adc: fix differential
 channels in triggered mode
Thread-Index: AQHVtb+PmhwCEX7J1UOzKiW28GxaNQ==
Date:   Wed, 18 Dec 2019 16:24:02 +0000
Message-ID: <1576686157-11939-8-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52e8501c-9637-4c66-d7fd-08d783d6b289
x-ms-traffictypediagnostic: DM5PR11MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1769DD52BB85ED7A7DC70C78E8530@DM5PR11MB1769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(66476007)(66946007)(66446008)(76116006)(91956017)(2616005)(64756008)(66556008)(86362001)(186003)(316002)(110136005)(8676002)(54906003)(8936002)(71200400001)(81166006)(478600001)(2906002)(6512007)(26005)(81156014)(36756003)(4326008)(6506007)(5660300002)(6486002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1769;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Udr616FaIBeDmaSkpQNCsm7NPPt9RRG+WunS1+bI5x6eTtAsAyBQMqBEXxEFz7Un6h55ouGvPRwxdl9MYyE3+/i3V3Dd7WnZSzLjkaxyfgJh5Aey68AOJV/N4f8delzWXm5FYahECd1+y4hV17fM/vp71D5w9+FSBWfjHWAJ117D/xEeMm+/juP0hevnZPbkVQDxYN8jiiHKaKF8UwxA7BhISrxmtZwfRgxNwasAj2ZCRu8K58A3n2tDfv2EhqtD9NKlPu4QdrKzlHm5y2MTKb/Sd/9YwewL7pt9iW+E4qND4nPWhgxVAOtyU8T3QYIFmH0F7OBD1k7cbeC0hT8Kwv8kTnlpJCcJDNyXyX1n09fUtlc3WDAiQfdPxQ36wsc3XHvopIudjw2Y+0JhuPL9Fenwz72oQaQWC5pbk9ZUyASp5Y1VUjeUl316fz3lY5zT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e8501c-9637-4c66-d7fd-08d783d6b289
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:24:02.1770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL92VuJQSbOkmkVR5Or1deDyjvDpthl4dMu0WUQS9Oj0hk5/px4q1mAORgPOxHQ6lBYPrBUDuMicr8wO6IwHsJ29vJ+jPlFiyugDCsJBqfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1769
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The differential channels require writing the channel offset register (COR)=
.
Otherwise they do not work in differential mode.
The configuration of COR is missing in triggered mode.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index a6b4dff..ccffa48 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -900,6 +900,7 @@ static int at91_adc_buffer_postenable(struct iio_dev *i=
ndio)
=20
 	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
 		struct iio_chan_spec const *chan =3D at91_adc_chan_get(indio, bit);
+		u32 cor;
=20
 		if (!chan)
 			continue;
@@ -908,6 +909,17 @@ static int at91_adc_buffer_postenable(struct iio_dev *=
indio)
 		    chan->type =3D=3D IIO_PRESSURE)
 			continue;
=20
+		cor =3D at91_adc_readl(st, AT91_SAMA5D2_COR);
+
+		if (chan->differential)
+			cor |=3D (BIT(chan->channel) | BIT(chan->channel2)) <<
+			       AT91_SAMA5D2_COR_DIFF_OFFSET;
+		else
+			cor &=3D ~(BIT(chan->channel) <<
+			       AT91_SAMA5D2_COR_DIFF_OFFSET);
+
+		at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
+
 		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
 		if (use_irq) {
 			at91_adc_writel(st, AT91_SAMA5D2_IER,
--=20
2.7.4
