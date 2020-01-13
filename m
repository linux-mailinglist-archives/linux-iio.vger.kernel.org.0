Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD60C1390BD
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMMHU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 07:07:20 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:48181 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgAMMHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 07:07:20 -0500
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
IronPort-SDR: fVJd0b1CloIcHjHJPApKxKNMuM9bVv8Z3YH9zpjpFEfVegyPCR63ApH/ZdyQPIO62O6OsnQc4X
 +6Y744YPClMM2BrpFCNZXrJvLdc4MsX0/aeGzIPuUhrVkKvlaFkzK0g76nVp1XFwEgzju9Kvbj
 DM0bbGveehVNLBP1zSnNbiTG25lMzCghRMXK4UjarYugx3I572C247jYP1aUEvkJ4szIeAU447
 7p6NiNB5Cd+85X/4gPlpqY/h7KnkgqME3dEa8yEG6GnTHI6VpyyO/0BSm1kJhh/TJ+BLufKiUf
 XCY=
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="60892615"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2020 05:07:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 05:07:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 05:07:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk0nH+n5Cbv9ZeVC7nwOKsso/GxNl61QKiEfjspbTToqL3JQ6cz39zYYWEJJBGN7g3nMVmqaS7vqbAP54qBE2Pt/LQj3Nk+C7cPQubRqwn4sYLGAbCmrC7jM882SvJ+BGV+mhp2XTTPB2UsKi5MUDXfK7YQ2EV+8xdd1p3NabkA9ifvaQpNCPqq3TAX3t/pODJowBzbuWtst83fwVB/zXIBet+06857SiL+NN/6feqVQLVoqX61Gn0WADDRmpF3eqSuCdkJxa8ynNPXFgrtC2RFdDdAAoiZjLYbeTCQxyxa6bznQEoKhq0DEDLIZbbPkLLpJ/1nKx15QxDIhz68isA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhs6f7oQUwU0gOwRfNxmUhiZW5v8xRmmgy/AsreIpWU=;
 b=GNZPXt3rM1qDSSkpHPOno1kf669k7IRbhjqxGtQ4bgRAcwVR78t9LXZlMJ29u5BKptAIh+wN6XYIdi40sKZpSf41+KQPcnp+mO3r+YHGeAsgdiqvwS27fMul9hJMrETQ1QUs4qqml47qFW4DJWjEFTn7r+w5u4MeDops27QF+GzcijbYlDN29PMRvOHO2xSDuVUD55cyfI37C5piQ6BrjmQ5WNtUPoY9/TccQHJdWTZkkOOjQe/quu8GbO0q5oZcLZANGrQEqAw4ArrnaR4mxCwIx6EMgWNZGtLXqRvNwZuMgNquhMy8bjpwmwwZdLGZCgaM20tZP2jaVlxne4zg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhs6f7oQUwU0gOwRfNxmUhiZW5v8xRmmgy/AsreIpWU=;
 b=UpulOZ/DK8bL2AEp7eg9x2pTpJLy/mWMpX78G2/wOli5qXUnVqJlyrIB9PHQj6O6dhVKfOgqgqXb8ueb1CzScDeCk5GQGMexTRErSfPsDdglUoXBxybEc7aot4OQ1PJG3FVswumSUIFd+XfYqdK9VSiGQ+gUl8GlCtW8LouhHu8=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0011.namprd11.prod.outlook.com (10.164.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Mon, 13 Jan 2020 12:07:09 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 12:07:09 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v2 1/3] iio: adc: at91-sama5d2_adc: fix differential channels
 in triggered mode
Thread-Topic: [PATCH v2 1/3] iio: adc: at91-sama5d2_adc: fix differential
 channels in triggered mode
Thread-Index: AQHVygn64v98utrynU+d9NR0RxZ56Q==
Date:   Mon, 13 Jan 2020 12:07:09 +0000
Message-ID: <1578917098-9674-2-git-send-email-eugen.hristev@microchip.com>
References: <1578917098-9674-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1578917098-9674-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0b41806-c7a0-45e4-58f0-08d798211dad
x-ms-traffictypediagnostic: DM5PR11MB0011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0011676305A150B7318D481EE8350@DM5PR11MB0011.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(8936002)(4326008)(71200400001)(8676002)(81166006)(81156014)(5660300002)(91956017)(478600001)(86362001)(76116006)(66946007)(6506007)(54906003)(110136005)(6486002)(186003)(316002)(36756003)(26005)(2906002)(107886003)(66446008)(6512007)(66476007)(66556008)(64756008)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0011;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LgDJQNNd3KiwO5xLeb6rASKkkBrmeCHhUco0jh2YVk4xM5130wJn0gZ66M1F4MiB1Pc+4ls+ZBbK8qsPhMDFSKlg5zzyC/gKmNrxUk56cYZ7aL93YehLWaIiDR7T4WaZEjZTFc6X+WzdN7IRExCOHjCU571lcr7SZJIW46W4h3GjcrpeaZwn3nMaqbXgDUPHdZw5ETVVvxo0fTuJojjWWmwIgkOymnhULG8qgQLTvD7BLKsLNz70g1KO+E7FbyX/Ot7wFxuG3886VoWjRV2E8OObSXQK/Yqo1yDGLdADWgfxKRqrDCFH8EvltgjClYfE9BjsfhPWiYoKJU/0qUVDGQ9vyWGPon+D4sTX5wEcU0dx27Cqm0d/P6k6mLE0WodXb+9VMiC6JZ9wfcqil/cvWAqBuUx7SxXU2NJADpn65fEwDIh0fS/2qNsIJJf75MwQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b41806-c7a0-45e4-58f0-08d798211dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 12:07:09.0479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3L22SPLk5w/983hIWbDBlRcImC1ULPpf9U0qjWHBsOqpY7OCLTbR7ll50MhrQeWsIzozDkV64KpfbQze5VJmIAS7fHNg0djSLu3PXJl7aaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0011
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
