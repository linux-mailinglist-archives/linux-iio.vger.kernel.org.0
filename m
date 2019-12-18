Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9FE124D2B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfLRQYN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:24:13 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:45033 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfLRQYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:11 -0500
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
IronPort-SDR: X33QiihNNKs7F4+foQ29/DEejNCjDaoL/50JbvcYpgriX0FfPuvQ4aNEOUJvvDVYGh7UvOaPnI
 A5Ed500AE83W4JHdeBo82W/xHdxvEEkyyg84tCbqAJo0OvlSuG+TKQKN+WwW/44Iu8Cv6n2FEC
 vAplqMRAEYBwB/CkMy+RKtbP0LfS94ssnN2fdodsMZc//nsOVIY9SDpNtNjNCoRb40r/XyOeM0
 EhiGt3WetmpDLTrUuu8Beo399akue2Toal8JkeDLFOD1Zc1IEoSEuaAJxh/ls0JSs/yAnMe5XI
 kU0=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="58926949"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 09:23:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW8bfEy9kGyQhdttVa1fINRKOx63agWETMwVXkXfGAsyVpM7ZC4rHngrSKjZToYc4VynT8PX2lFozcT8ygf1A6vN49+MqjOU+z0iajQrTnYAg8ku5xWFa/s1rgwUOd0iG8ye1tZ4TYZA1Udzx5He8pGWwZHIG38vchNt13ETKFjQkltuo5iDr1WmMwr/aAknKlk/BMPclOtF8V8RC4fnb3lCnHTNGSokuBYt636pgiWMBImrwAY23LVdUX+u6MHvZauVoYm6JxtW+NL+J8d/HEkaZuAfMLk4JH5fcdRAOjRc5fF06m4OL/M8eAoHAFJElt0K8WB+bKbCj/nIjwVA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6iiaTiNAGwMTwukhS+6u4KwtuaSg3VgDPHNQ5aNYQM=;
 b=ibh4hSZ+b2eInPftmfsxf0mpTYwpCITMVAZxjf98SWbT85TQ3MEuvLtrZ2HNu+W7J7L7OiauWPFzVI1ehvcr0XmQNct9+WJXQJeIiSUdy7VMXQtdqT3Yehzjk8Y65kRcCZ2xx+wWCOFyYIjhKE44sVxWUarHRZ0Z2eE73c0IuAjYsMSrhG4JsCwfxr4dFcLkIP5eO/x4BFJCs5LeOPzI0yIBvD8L9gXLCzW1WKzLOJ7yAMdSxlWKAMOOgLokHXHemchSYmPJjOqiyfRWdxEhQhkV4wHBHnpCzTEKNYLY6kllSB2V0kvtg4E9ExvX2Wh8J1abtW95QT1OMxidpOlghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6iiaTiNAGwMTwukhS+6u4KwtuaSg3VgDPHNQ5aNYQM=;
 b=kVX7lYSOB9EOUh6bRuthkTkJWCmXkHr6fvzGxMOS8CWUF4LrGN2+qVqq6s0rojzogupEdpGpdyAyHfPplx+wqa7pjU77K/u6tY+bv2AhWFd1fpMF5Z8078tTpA2GWJX/0dsXEnWbwIHxJ0HQCTHrJ+LHDcUVJtteJFDJxP4RVNc=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1913.namprd11.prod.outlook.com (10.175.87.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 16:23:59 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:23:59 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 01/10] iio: adc: at91-sama5d2_adc: update for other trigger
 usage
Thread-Topic: [PATCH 01/10] iio: adc: at91-sama5d2_adc: update for other
 trigger usage
Thread-Index: AQHVtb+MG4wZCflqBkexX/EL1yry8g==
Date:   Wed, 18 Dec 2019 16:23:58 +0000
Message-ID: <1576686157-11939-2-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5c95de6-49ca-41c9-dc03-08d783d6afc5
x-ms-traffictypediagnostic: DM5PR11MB1913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB19139DD6195BE81220FDB8D5E8530@DM5PR11MB1913.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(52314003)(2616005)(66556008)(316002)(30864003)(107886003)(8676002)(71200400001)(8936002)(66476007)(26005)(6506007)(2906002)(64756008)(66446008)(66946007)(81156014)(76116006)(81166006)(5660300002)(478600001)(36756003)(54906003)(186003)(4326008)(86362001)(6512007)(110136005)(91956017)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1913;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: daJiZ+OpQoiN0coafOld1xWmoB8HdZdm1YhzzNz5PLRBU9q2aunekoHUWme5quCu6Ft6mysJQ5B3aRTVilXgdchaTsb/qPceHQxcencP89eMyE730T/c5edfnpesy7N4n2WAdcjtFhNHj5lB/NNP5iKzHwVq7Px9WoaBMAT9k6WPSBZWqx8cUCgYVzY+Wn1hH7xMLBkWa5HBx8AOJmVLlBOrlpAapGrARVf7QzJMV95O23S0zOKWnJWDecRsqW9gUsF90F2K4UvPhM+H2u733aDIeUKhduVTRiDu90PJwWwpmv6OrJrhoKylaKPIIxaPv/yAOouwq8BsTBvIz2oLQx4uTL1Porpzpl5jRiYMM+RGA+5greMoJZ6gj4KSBKFh0CXtj9rGAxOSirqmR+xoj13Dhd5+csy/8LaBRTdyqNX18OvbfUTPpel9BjY/FtKuHp3kZ3rBtWJtodB4H8jf3CdEb8s/4ytBmpvVXD3KRegVZuWzwR2Oa/JebtuFhiDH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c95de6-49ca-41c9-dc03-08d783d6afc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:23:58.4137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Lu40e0ykQPQoiwkOd+scIXNydcVr986/hByzjzip/Z/9WJQKWxGjiSrLnqk9uyHoBRqV+nVXSSvw7TOtDYSBrBsaDPUXfPrZ5rmEoX0bVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1913
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

This change will allow the at91-sama5d2_adc driver to use other triggers
than it's own.
In particular, tested with the sysfs trigger.
To be able to achieve this functionality, some changes were required:
1) Do not enable/disable channels when enabling/disabling the trigger.
This is because the trigger is enabled/disabled only for our trigger
(obviously). We need channels enabled/disabled regardless of what trigger i=
s
being used.
2) Cope with DMA : DMA cannot be used when using another type of trigger.
Other triggers work through pollfunc, so we get polled anyway on every trig=
ger.
Thus we have to obtain data at every trigger.
3) When to start conversion? The usual pollfunc (store time from subsystem)
is replaced with specific at91 code, that will start the software conversio=
n
on the poll action(if it's not our trigger).
4) When is the conversion done ? Usually it should be done at EOC (end of
channel) interrupt. But we start the conversion in pollfunc. So, in the han=
dler
for this pollfunc, check if data is ready. If not ready, cannot busywait, s=
o,
start the workq to get the data later.
5) Buffer config: we need to setup buffer regardless of our own device's
trigger. We may get one attached later.
6) IRQ handling: we use our own device IRQ only if it's our own trigger
and we do not use DMA . If we use DMA, we use the DMA controller's IRQ.
7) Touchscreen workq: the workq is now also used with other triggers. So, m=
ove
this from the touchscreen state struct to the at91_adc_state.
8) Timestamp: the timestamp is kept in the pollfunc. However if in the hand=
ler
we start a workq, the timestamp is no longer accessible. Copy it to our sta=
te
struct.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 212 ++++++++++++++++++++++-----------=
----
 1 file changed, 127 insertions(+), 85 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index e1850f3..c575970 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -378,7 +378,6 @@ struct at91_adc_touch {
 	bool				touching;
 	u16				x_pos;
 	unsigned long			channels_bitmask;
-	struct work_struct		workq;
 };
=20
 struct at91_adc_state {
@@ -405,6 +404,8 @@ struct at91_adc_state {
 	 * sysfs.
 	 */
 	struct mutex			lock;
+	struct work_struct		workq;
+	s64				timestamp;
 };
=20
 static const struct at91_adc_trigger at91_adc_trigger_list[] =3D {
@@ -710,7 +711,6 @@ static int at91_adc_configure_trigger(struct iio_trigge=
r *trig, bool state)
 	struct iio_dev *indio =3D iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st =3D iio_priv(indio);
 	u32 status =3D at91_adc_readl(st, AT91_SAMA5D2_TRGR);
-	u8 bit;
=20
 	/* clear TRGMOD */
 	status &=3D ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
@@ -721,35 +721,6 @@ static int at91_adc_configure_trigger(struct iio_trigg=
er *trig, bool state)
 	/* set/unset hw trigger */
 	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
=20
-	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
-		struct iio_chan_spec const *chan =3D at91_adc_chan_get(indio, bit);
-
-		if (!chan)
-			continue;
-		/* these channel types cannot be handled by this trigger */
-		if (chan->type =3D=3D IIO_POSITIONRELATIVE ||
-		    chan->type =3D=3D IIO_PRESSURE)
-			continue;
-
-		if (state) {
-			at91_adc_writel(st, AT91_SAMA5D2_CHER,
-					BIT(chan->channel));
-			/* enable irq only if not using DMA */
-			if (!st->dma_st.dma_chan) {
-				at91_adc_writel(st, AT91_SAMA5D2_IER,
-						BIT(chan->channel));
-			}
-		} else {
-			/* disable irq only if not using DMA */
-			if (!st->dma_st.dma_chan) {
-				at91_adc_writel(st, AT91_SAMA5D2_IDR,
-						BIT(chan->channel));
-			}
-			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
-					BIT(chan->channel));
-		}
-	}
-
 	return 0;
 }
=20
@@ -873,69 +844,90 @@ static int at91_adc_dma_start(struct iio_dev *indio_d=
ev)
 	return 0;
 }
=20
-static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
+#define AT91_ADC_BUFFER_CHECK_USE_IRQ(use_irq)  { \
+	use_irq =3D true; \
+	/* if using DMA, we do not use our own IRQ (we use DMA-controller) */ \
+	if (st->dma_st.dma_chan) \
+		use_irq =3D false; \
+	/* if the trigger is not ours, then it has its own IRQ */ \
+	if (iio_trigger_validate_own_device(indio->trig, indio)) \
+		use_irq =3D false; \
+	}
+
+static int at91_adc_buffer_postenable(struct iio_dev *indio)
 {
 	int ret;
-	struct at91_adc_state *st =3D iio_priv(indio_dev);
+	u8 bit;
+	bool use_irq;
+	struct at91_adc_state *st =3D iio_priv(indio);
=20
 	/* check if we are enabling triggered buffer or the touchscreen */
-	if (bitmap_subset(indio_dev->active_scan_mask,
+	if (bitmap_subset(indio->active_scan_mask,
 			  &st->touch_st.channels_bitmask,
 			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
 		/* touchscreen enabling */
 		return at91_adc_configure_touch(st, true);
 	}
 	/* if we are not in triggered mode, we cannot enable the buffer. */
-	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
+	if (!(indio->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
=20
 	/* we continue with the triggered buffer */
-	ret =3D at91_adc_dma_start(indio_dev);
+	ret =3D at91_adc_dma_start(indio);
 	if (ret) {
-		dev_err(&indio_dev->dev, "buffer postenable failed\n");
+		dev_err(&indio->dev, "buffer postenable failed\n");
+		iio_triggered_buffer_predisable(indio);
 		return ret;
 	}
=20
-	return iio_triggered_buffer_postenable(indio_dev);
+	AT91_ADC_BUFFER_CHECK_USE_IRQ(use_irq);
+
+	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
+		struct iio_chan_spec const *chan =3D at91_adc_chan_get(indio, bit);
+
+		if (!chan)
+			continue;
+		/* these channel types cannot be handled by this trigger */
+		if (chan->type =3D=3D IIO_POSITIONRELATIVE ||
+		    chan->type =3D=3D IIO_PRESSURE)
+			continue;
+
+		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
+		if (use_irq) {
+			at91_adc_writel(st, AT91_SAMA5D2_IER,
+					BIT(chan->channel));
+		}
+	}
+	return iio_triggered_buffer_postenable(indio);
 }
=20
-static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
+static int at91_adc_buffer_predisable(struct iio_dev *indio)
 {
-	struct at91_adc_state *st =3D iio_priv(indio_dev);
+	struct at91_adc_state *st =3D iio_priv(indio);
 	int ret;
 	u8 bit;
+	bool use_irq;
=20
 	/* check if we are disabling triggered buffer or the touchscreen */
-	if (bitmap_subset(indio_dev->active_scan_mask,
+	if (bitmap_subset(indio->active_scan_mask,
 			  &st->touch_st.channels_bitmask,
 			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
 		/* touchscreen disable */
 		return at91_adc_configure_touch(st, false);
 	}
 	/* if we are not in triggered mode, nothing to do here */
-	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
+	if (!(indio->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
=20
-	/* continue with the triggered buffer */
-	ret =3D iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		dev_err(&indio_dev->dev, "buffer predisable failed\n");
-
-	if (!st->dma_st.dma_chan)
-		return ret;
-
-	/* if we are using DMA we must clear registers and end DMA */
-	dmaengine_terminate_sync(st->dma_st.dma_chan);
-
+	AT91_ADC_BUFFER_CHECK_USE_IRQ(use_irq);
 	/*
-	 * For each enabled channel we must read the last converted value
+	 * For each enable channel we must disable it in hardware.
+	 * In the case of DMA, we must read the last converted value
 	 * to clear EOC status and not get a possible interrupt later.
-	 * This value is being read by DMA from LCDR anyway
+	 * This value is being read by DMA from LCDR anyway, so it's not lost.
 	 */
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->num_channels) {
-		struct iio_chan_spec const *chan =3D
-					at91_adc_chan_get(indio_dev, bit);
+	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
+		struct iio_chan_spec const *chan =3D at91_adc_chan_get(indio, bit);
=20
 		if (!chan)
 			continue;
@@ -943,12 +935,29 @@ static int at91_adc_buffer_predisable(struct iio_dev =
*indio_dev)
 		if (chan->type =3D=3D IIO_POSITIONRELATIVE ||
 		    chan->type =3D=3D IIO_PRESSURE)
 			continue;
+
+		if (use_irq) {
+			at91_adc_writel(st, AT91_SAMA5D2_IDR,
+					BIT(chan->channel));
+		}
+		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
+
 		if (st->dma_st.dma_chan)
 			at91_adc_readl(st, chan->address);
 	}
=20
 	/* read overflow register to clear possible overflow status */
 	at91_adc_readl(st, AT91_SAMA5D2_OVER);
+
+	/* continue with the triggered buffer */
+	ret =3D iio_triggered_buffer_predisable(indio);
+	if (ret < 0)
+		dev_err(&indio->dev, "buffer predisable failed\n");
+
+	/* if we are using DMA we must clear registers and end DMA */
+	if (st->dma_st.dma_chan)
+		dmaengine_terminate_sync(st->dma_st.dma_chan);
+
 	return ret;
 }
=20
@@ -993,8 +1002,8 @@ static int at91_adc_trigger_init(struct iio_dev *indio=
)
 	return 0;
 }
=20
-static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
-					   struct iio_poll_func *pf)
+static void at91_adc_read_and_push_channels(struct iio_dev *indio_dev,
+					    s64 timestamp)
 {
 	struct at91_adc_state *st =3D iio_priv(indio_dev);
 	int i =3D 0;
@@ -1028,11 +1037,30 @@ static void at91_adc_trigger_handler_nodma(struct i=
io_dev *indio_dev,
 		}
 		i++;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer, timestamp);
+}
+
+static int at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
+					  struct iio_poll_func *pf)
+{
+	struct at91_adc_state *st =3D iio_priv(indio_dev);
+
+	/*
+	 * Check if the conversion is ready. If not, schedule a work to
+	 * check again later.
+	 */
+	if (!(at91_adc_readl(st, AT91_SAMA5D2_ISR) & GENMASK(11, 0))) {
+		schedule_work(&st->workq);
+		return -EINPROGRESS;
+	}
+
+	/* we have data, so let's extract and push it */
+	at91_adc_read_and_push_channels(indio_dev, pf->timestamp);
+
+	return 0;
 }
=20
-static void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
+static int at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
 {
 	struct at91_adc_state *st =3D iio_priv(indio_dev);
 	int transferred_len =3D at91_adc_dma_size_done(st);
@@ -1079,6 +1107,8 @@ static void at91_adc_trigger_handler_dma(struct iio_d=
ev *indio_dev)
 	}
 	/* adjust saved time for next transfer handling */
 	st->dma_st.dma_ts =3D iio_get_time_ns(indio_dev);
+
+	return 0;
 }
=20
 static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
@@ -1086,33 +1116,41 @@ static irqreturn_t at91_adc_trigger_handler(int irq=
, void *p)
 	struct iio_poll_func *pf =3D p;
 	struct iio_dev *indio_dev =3D pf->indio_dev;
 	struct at91_adc_state *st =3D iio_priv(indio_dev);
+	int ret;
=20
+	st->timestamp =3D pf->timestamp;
 	if (st->dma_st.dma_chan)
-		at91_adc_trigger_handler_dma(indio_dev);
+		ret =3D at91_adc_trigger_handler_dma(indio_dev);
 	else
-		at91_adc_trigger_handler_nodma(indio_dev, pf);
+		ret =3D at91_adc_trigger_handler_nodma(indio_dev, pf);
=20
-	iio_trigger_notify_done(indio_dev->trig);
+	if (!ret)
+		iio_trigger_notify_done(indio_dev->trig);
=20
 	return IRQ_HANDLED;
 }
=20
-static int at91_adc_buffer_init(struct iio_dev *indio)
+irqreturn_t at91_adc_pollfunc(int irq, void *p)
 {
-	struct at91_adc_state *st =3D iio_priv(indio);
+	struct iio_poll_func *pf =3D p;
+	struct iio_dev *indio_dev =3D pf->indio_dev;
+	struct at91_adc_state *st =3D iio_priv(indio_dev);
=20
-	if (st->selected_trig->hw_trig) {
-		return devm_iio_triggered_buffer_setup(&indio->dev, indio,
-			&iio_pollfunc_store_time,
-			&at91_adc_trigger_handler, &at91_buffer_setup_ops);
-	}
 	/*
-	 * we need to prepare the buffer ops in case we will get
-	 * another buffer attached (like a callback buffer for the touchscreen)
+	 * If it's not our trigger, start a conversion now, as we are
+	 * actually polling the trigger now.
 	 */
-	indio->setup_ops =3D &at91_buffer_setup_ops;
+	if (iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
+		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
=20
-	return 0;
+	return iio_pollfunc_store_time(irq, p);
+}
+
+static int at91_adc_buffer_init(struct iio_dev *indio)
+{
+	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
+		&at91_adc_pollfunc,
+		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
 }
=20
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
@@ -1195,7 +1233,7 @@ static void at91_adc_touch_data_handler(struct iio_de=
v *indio_dev)
 	 * from our IRQ context. Which is something we better avoid.
 	 * Let's schedule it after our IRQ is completed.
 	 */
-	schedule_work(&st->touch_st.workq);
+	schedule_work(&st->workq);
 }
=20
 static void at91_adc_pen_detect_interrupt(struct at91_adc_state *st)
@@ -1228,13 +1266,17 @@ static void at91_adc_no_pen_detect_interrupt(struct=
 at91_adc_state *st)
=20
 static void at91_adc_workq_handler(struct work_struct *workq)
 {
-	struct at91_adc_touch *touch_st =3D container_of(workq,
-					struct at91_adc_touch, workq);
-	struct at91_adc_state *st =3D container_of(touch_st,
-					struct at91_adc_state, touch_st);
+	struct at91_adc_state *st =3D container_of(workq,
+					struct at91_adc_state, workq);
 	struct iio_dev *indio_dev =3D iio_priv_to_dev(st);
=20
-	iio_push_to_buffers(indio_dev, st->buffer);
+	if ((indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES) &&
+	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev)) {
+		at91_adc_read_and_push_channels(indio_dev, st->timestamp);
+		iio_trigger_notify_done(indio_dev->trig);
+	} else {
+		iio_push_to_buffers(indio_dev, st->buffer);
+	}
 }
=20
 static irqreturn_t at91_adc_interrupt(int irq, void *private)
@@ -1711,7 +1753,7 @@ static int at91_adc_probe(struct platform_device *pde=
v)
=20
 	init_waitqueue_head(&st->wq_data_available);
 	mutex_init(&st->lock);
-	INIT_WORK(&st->touch_st.workq, at91_adc_workq_handler);
+	INIT_WORK(&st->workq, at91_adc_workq_handler);
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
--=20
2.7.4
