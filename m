Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7711614B494
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 13:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgA1M5p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 07:57:45 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:10203 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgA1M5o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 07:57:44 -0500
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
IronPort-SDR: By85+VsfmKy+Hv10hUMGHNbaN8ANer1f9F42+SNL0dJ2ii2+7bgUCiZehE5Er2n+U0EsOjqoUY
 uDQ1XgjyBJ9koY4XJ+XbqtAwVsgHxrJBpbGjIUM9wU0YaRembIYg8eqaLYZpI3uHVoX2GjtHIT
 2hX/Wc492bD/gzofGnNsFgEJ2G5JzvJVor3aplImeAwECAKI6IFKXPFH4OA9B0kVQcdQ63CD1Z
 OpwO7/ElAJJ4YGF6RkZCD4qT99zXs3xCHjvw8lnovvTQXJeZpTJROzKXGKozzE80YuFiSEmsYn
 L3g=
X-IronPort-AV: E=Sophos;i="5.70,373,1574146800"; 
   d="scan'208";a="63324879"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jan 2020 05:57:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Jan 2020 05:57:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jan 2020 05:57:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr3VdBy8RROARs9ZrEQywcfRZU0VwD0IJq/6mzn4PvahDztV8hQcvFIyHW89L3wkz0rgB2rqC2qlGCoWF8y6gotzpFeYLLIITsnm4zw7U8Bkc6cokiAVhYbFqNx1mWlX6Y6sD+uN6oI4pVHJo4JPLRx89mdP3sdBxupC15nem01wr9Ct6QfFtnzcweQ1ck6nnwtjlVdCb6K4iv3qtGU/6LG6FFTBBIjnd/jVUX03HZZHtgHc2hdrgNgTs2nwGzT4ad4q339sc5fSwRWNz0WtCR5aZbObBbjSkysK1y4sgc7wAAFlqmZOhbxki42BDQXjIzZFS8BS4O829RsZN2wXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4jBKIuwOxmBMrknvGW6sroidfWtc4NmUdFm4P9iVT8=;
 b=Z6uCyAJNK80NwxcIQAXBizUT7dRzZ6t8x64hWH572v5HObWuVYWLIMpYAU35L1D01NE6m0Ec420Tr+mz2IHUygPwAO+CMTWoSgE0FU30CBJuWS074iS1CJubv8SudYoNXoG7w255g9m6TzdSXjQ8IcsQalUSviZkbqAYYBvJhOgTDLLOMx8WdXNo60GU36/6zWzajWDp/i/cXyyVW/39Q2iOHYOieI4HykyAmyv7rWz6uMMc+Xl3fHM8Yk4cHFvr/GG4ZPUZjMX3eFw9PMEU03p41ijWXwrKdkuBGZvxGDvudqekUTBlqCPx08KGB8ea9LNOZUSBTrM6AlpIDZBglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4jBKIuwOxmBMrknvGW6sroidfWtc4NmUdFm4P9iVT8=;
 b=MCb8WQmAM4eeHoQu9OYUcz8+TwPPnJezHy5jJDK7wic6F01cblfOD2/Ch2oQ8Y5JQ8UOjAklaDKE+Y9+rkil+7LSfx6cr8hYfjVGFoBCdgJWAfDUEErJmqHSY/mSK21USlkZ2DkxNe5/z40EdhV/RLVXBGZ5daWit41++Kyrnjw=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1612.namprd11.prod.outlook.com (10.172.37.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 12:57:41 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79%6]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 12:57:41 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <alexandru.ardelean@analog.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 3/3] iio: adc: at91-sama5d2_adc: update for other trigger
 usage
Thread-Topic: [PATCH v3 3/3] iio: adc: at91-sama5d2_adc: update for other
 trigger usage
Thread-Index: AQHV1dqGOUCBlFaurEGFIEUerZ28kA==
Date:   Tue, 28 Jan 2020 12:57:41 +0000
Message-ID: <1580216189-27418-4-git-send-email-eugen.hristev@microchip.com>
References: <1580216189-27418-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1580216189-27418-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac2e5b73-d78e-448c-a971-08d7a3f1a8f6
x-ms-traffictypediagnostic: DM5PR11MB1612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1612DAB43A3BE937084D33F4E80A0@DM5PR11MB1612.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(6506007)(71200400001)(8676002)(5660300002)(2616005)(316002)(81166006)(26005)(81156014)(66446008)(4326008)(110136005)(54906003)(91956017)(478600001)(64756008)(2906002)(66556008)(6512007)(66946007)(86362001)(6486002)(107886003)(76116006)(8936002)(36756003)(66476007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1612;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NY0a1tcTLXIHOMUTV2pgLY9tMe58faWOrjHlPeoYa5IMTwjNHV+jl1iPHQWl1b+JAQT9dkG4f7xBgx71H61ATL+gZ+/4Dt88jOpIXKoYjnpj1czOGPIpiMK1peRwtut7MSwSlMRu+bRUXnJyzIyralE1k1e8rinONFSMuuZFFg/D2S5IQ/VxCi4a7lyehvbYucwDpIDIOuffPPa0rpY/ySkAp0ERM5tfTLPqz+UbCOkoiQgXPDfNomXvZmXzL8JCjrOSq+H+QyZLmfWaLGbK3moGLJsokNTF/t0ffKpFV3BPsS498xcvepzg7ENxCpFz9ryGpfo/nu6YHhdAer44P9CXzqggE5bQrpH/vZADf7eYv26hpPF7aQHwKW5CHTvW05JX/250+hHogbSzISgoIfvlSU4c8DbnA0U7I8lntH+R/zYhVXEXfTXX1cB14RJm
x-ms-exchange-antispam-messagedata: 87SABN5L4K3A7jp6M6x2DknTKi1/dEeWM37XvGPIXWjWeMRHc40SuG4U0bQmb7XWuVqIE/krTeJrQoMjo2h6QR3hja789CT34ukUbRtm69wM2iYZ97r/ctNiUO1SqOgaUEc2BxzJar3q+DlNkq6KKA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2e5b73-d78e-448c-a971-08d7a3f1a8f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 12:57:41.0859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuFA1br1xhP3i/Vi+bqJ8aH1SIR9RWpxz+WDl+g1xdCdWb1KCh69CYxfd9H0cRZjPrGMX7W1+J5LE812z37n5rzRKd7AtxNmAwN6jYhmPyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1612
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
would be in hard irq and this would be a good way, but current iio subsyste=
m
recommends to have it in the threaded irq. Thus adding software start
code in this handler.
4) Buffer config: we need to setup buffer regardless of our own device's
trigger. We may get one attached later.
5) IRQ handling: we use our own device IRQ only if it's our own trigger
and we do not use DMA . If we use DMA, we use the DMA controller's IRQ.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v3:
- remove useless call to iio_triggered_buffer_predisable

Changes in v2:
- adapt to the situation of having the previous two patches ahead in the se=
ries

 drivers/iio/adc/at91-sama5d2_adc.c | 142 +++++++++++++++++++--------------=
----
 1 file changed, 72 insertions(+), 70 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index 49c2b9d..03ceab4 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -728,7 +728,6 @@ static int at91_adc_configure_trigger(struct iio_trigge=
r *trig, bool state)
 	struct iio_dev *indio =3D iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st =3D iio_priv(indio);
 	u32 status =3D at91_adc_readl(st, AT91_SAMA5D2_TRGR);
-	u8 bit;
=20
 	/* clear TRGMOD */
 	status &=3D ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
@@ -739,48 +738,6 @@ static int at91_adc_configure_trigger(struct iio_trigg=
er *trig, bool state)
 	/* set/unset hw trigger */
 	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
=20
-	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
-		struct iio_chan_spec const *chan =3D at91_adc_chan_get(indio, bit);
-		u32 cor;
-
-		if (!chan)
-			continue;
-		/* these channel types cannot be handled by this trigger */
-		if (chan->type =3D=3D IIO_POSITIONRELATIVE ||
-		    chan->type =3D=3D IIO_PRESSURE)
-			continue;
-
-		if (state) {
-			cor =3D at91_adc_readl(st, AT91_SAMA5D2_COR);
-
-			if (chan->differential)
-				cor |=3D (BIT(chan->channel) |
-					BIT(chan->channel2)) <<
-					AT91_SAMA5D2_COR_DIFF_OFFSET;
-			else
-				cor &=3D ~(BIT(chan->channel) <<
-				       AT91_SAMA5D2_COR_DIFF_OFFSET);
-
-			at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
-		}
-
-		if (state)
-			at91_adc_writel(st, AT91_SAMA5D2_CHER,
-					BIT(chan->channel));
-		else
-			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
-					BIT(chan->channel));
-	}
-
-	/* Nothing to do if using DMA */
-	if (st->dma_st.dma_chan)
-		return 0;
-
-	if (state)
-		at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_DRDY);
-	else
-		at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
-
 	return 0;
 }
=20
@@ -905,9 +862,22 @@ static int at91_adc_dma_start(struct iio_dev *indio_de=
v)
 	return 0;
 }
=20
+static bool at91_adc_buffer_check_use_irq(struct iio_dev *indio,
+					  struct at91_adc_state *st)
+{
+	/* if using DMA, we do not use our own IRQ (we use DMA-controller) */
+	if (st->dma_st.dma_chan)
+		return false;
+	/* if the trigger is not ours, then it has its own IRQ */
+	if (iio_trigger_validate_own_device(indio->trig, indio))
+		return false;
+	return true;
+}
+
 static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	int ret;
+	u8 bit;
 	struct at91_adc_state *st =3D iio_priv(indio_dev);
=20
 	/* check if we are enabling triggered buffer or the touchscreen */
@@ -928,6 +898,36 @@ static int at91_adc_buffer_postenable(struct iio_dev *=
indio_dev)
 		return ret;
 	}
=20
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->num_channels) {
+		struct iio_chan_spec const *chan =3D
+					at91_adc_chan_get(indio_dev, bit);
+		u32 cor;
+
+		if (!chan)
+			continue;
+		/* these channel types cannot be handled by this trigger */
+		if (chan->type =3D=3D IIO_POSITIONRELATIVE ||
+		    chan->type =3D=3D IIO_PRESSURE)
+			continue;
+
+		cor =3D at91_adc_readl(st, AT91_SAMA5D2_COR);
+
+		if (chan->differential)
+			cor |=3D (BIT(chan->channel) | BIT(chan->channel2)) <<
+				AT91_SAMA5D2_COR_DIFF_OFFSET;
+		else
+			cor &=3D ~(BIT(chan->channel) <<
+			       AT91_SAMA5D2_COR_DIFF_OFFSET);
+
+		at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
+
+		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
+	}
+
+	if (at91_adc_buffer_check_use_irq(indio_dev, st))
+		at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_DRDY);
+
 	return iio_triggered_buffer_postenable(indio_dev);
 }
=20
@@ -948,21 +948,11 @@ static int at91_adc_buffer_predisable(struct iio_dev =
*indio_dev)
 	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
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
 	/*
-	 * For each enabled channel we must read the last converted value
+	 * For each enable channel we must disable it in hardware.
+	 * In the case of DMA, we must read the last converted value
 	 * to clear EOC status and not get a possible interrupt later.
-	 * This value is being read by DMA from LCDR anyway
+	 * This value is being read by DMA from LCDR anyway, so it's not lost.
 	 */
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->num_channels) {
@@ -975,12 +965,28 @@ static int at91_adc_buffer_predisable(struct iio_dev =
*indio_dev)
 		if (chan->type =3D=3D IIO_POSITIONRELATIVE ||
 		    chan->type =3D=3D IIO_PRESSURE)
 			continue;
+
+		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
+
 		if (st->dma_st.dma_chan)
 			at91_adc_readl(st, chan->address);
 	}
=20
+	if (at91_adc_buffer_check_use_irq(indio_dev, st))
+		at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
+
 	/* read overflow register to clear possible overflow status */
 	at91_adc_readl(st, AT91_SAMA5D2_OVER);
+
+	/* continue with the triggered buffer */
+	ret =3D iio_triggered_buffer_predisable(indio_dev);
+	if (ret < 0)
+		dev_err(&indio_dev->dev, "buffer predisable failed\n");
+
+	/* if we are using DMA we must clear registers and end DMA */
+	if (st->dma_st.dma_chan)
+		dmaengine_terminate_sync(st->dma_st.dma_chan);
+
 	return ret;
 }
=20
@@ -1135,6 +1141,13 @@ static irqreturn_t at91_adc_trigger_handler(int irq,=
 void *p)
 	struct iio_dev *indio_dev =3D pf->indio_dev;
 	struct at91_adc_state *st =3D iio_priv(indio_dev);
=20
+	/*
+	 * If it's not our trigger, start a conversion now, as we are
+	 * actually polling the trigger now.
+	 */
+	if (iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
+		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
+
 	if (st->dma_st.dma_chan)
 		at91_adc_trigger_handler_dma(indio_dev);
 	else
@@ -1147,20 +1160,9 @@ static irqreturn_t at91_adc_trigger_handler(int irq,=
 void *p)
=20
 static int at91_adc_buffer_init(struct iio_dev *indio)
 {
-	struct at91_adc_state *st =3D iio_priv(indio);
-
-	if (st->selected_trig->hw_trig) {
-		return devm_iio_triggered_buffer_setup(&indio->dev, indio,
-			&iio_pollfunc_store_time,
-			&at91_adc_trigger_handler, &at91_buffer_setup_ops);
-	}
-	/*
-	 * we need to prepare the buffer ops in case we will get
-	 * another buffer attached (like a callback buffer for the touchscreen)
-	 */
-	indio->setup_ops =3D &at91_buffer_setup_ops;
-
-	return 0;
+	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
+		&iio_pollfunc_store_time,
+		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
 }
=20
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
--=20
2.7.4
