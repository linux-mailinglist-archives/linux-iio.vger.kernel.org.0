Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805D01390C0
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMMHU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 07:07:20 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:38215 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMMHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 07:07:20 -0500
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
IronPort-SDR: 8aWN5G6meKVa7JsVJ3Ff67Cc9qKBajT2XRnRH0JxP6A9d7WiPJXNT1Rnz6gTZcmmmme/vzqyzf
 v0VwAAnV4fdkdtlD4eGbJ7h2smR5JNuFqbQkrqmV1nS3o9H+q4hd93GZKM24MZRIuWz2KwfxlU
 ivDTf/f+sXTbymPbbDTPOA51PZg6Kkvm83SLA2ZtgTX23sdZmOMXje8i8GMm19vwR3su9J3Ind
 +yYkMaOxy5Oed2H3ZpAbiuUVXYU/d/1+fnnEs+0qsEjk2emC/U5TZgj5mW0eOY8YbQIcwJARG0
 vvo=
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="61710734"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2020 05:07:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 05:07:11 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 13 Jan 2020 05:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYV6YozcXtV4RTHMbOlL7X2RbCXEq7br8y7uuAwBkFYytn3+rB1NkeHOnaSCeKhQKzwCwMtbr/JsjEbG0BOgQudcKAlRIzbY5iFOBW9hu01wBBZTVjq4UStjRKvfgVpnJDlhivG93IAq3Y5R50n9ct3Z2WNi65tPDT/kBxmE5JSG43dm95okXmhQI7m9nehckVsMINys3QURWNCkAJ/A4MPrpSORltcxUVkyANzPui3nSHVqOk0PLErQj6kywAJ7m4GarQIIlWWCjm+3PiqyIOVMEUoumsIVWonsC7CxjmGVKQq36gNNJxMlAQfVZbpJD/YXp0DyIuxLX852sEaw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJg5WVr18AtTM6Sf2grIxv9KqnZwhGCvyXv8KouozHw=;
 b=KLia3Zo0wLJ94bnryV5KMVlGExElAS6LM1vKW/XNb/cTXVeh21BGUgyf3bDIe5EOj+sODMO/Uld1tgPf28PAMTg9P/s2epRqPHdwOLSaFjW3jZUBg/DH8M1eUTNwQcINsOuD6SoYYBEtHSQdJlKuQ5Di1JsXaJpki8IcITABxdlJjNrdfKj/YyEhlqlUfwuPfwDpwT9wvAqbmeHpm4p1ZnNquPSzM6UbWjJapX1AB1LR4RwVUbbfzD+u7JycCULg+sruOLzjcY8shyFlPU72xzKq2LBoqnOzJcbFB0cF9xYWdeSZHrtGQ5BinERJvGEYehI07qEH8hTQWwmU4RM6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJg5WVr18AtTM6Sf2grIxv9KqnZwhGCvyXv8KouozHw=;
 b=OF45fcqQmzv/gwCaygxCOukESb8rBVMaEUsaNhhlkYu9fMec3xXdmXin6uSVVTxaPQPJNOFqDrYhu31hLyOXz48CyV6W31INjaGXW/85QcBS/XYwEe+KT2KAomrUXCsOOsBysWictpQEO8qQJcGkuifIY81IxZQUJTBT0K6V3Xo=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1498.namprd11.prod.outlook.com (10.172.36.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 12:07:10 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 12:07:10 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v2 3/3] iio: adc: at91-sama5d2_adc: update for other trigger
 usage
Thread-Topic: [PATCH v2 3/3] iio: adc: at91-sama5d2_adc: update for other
 trigger usage
Thread-Index: AQHVygn7rEZ0ai+1ZkerXwetHJ8ZDg==
Date:   Mon, 13 Jan 2020 12:07:10 +0000
Message-ID: <1578917098-9674-4-git-send-email-eugen.hristev@microchip.com>
References: <1578917098-9674-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1578917098-9674-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18bc91d8-529d-49d7-3928-08d798211e40
x-ms-traffictypediagnostic: DM5PR11MB1498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB14983D3DFAAE7FBF5BC49760E8350@DM5PR11MB1498.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(66446008)(316002)(54906003)(110136005)(2616005)(36756003)(86362001)(6486002)(478600001)(6506007)(6512007)(186003)(91956017)(76116006)(2906002)(26005)(4326008)(107886003)(5660300002)(8936002)(8676002)(81166006)(81156014)(71200400001)(66946007)(64756008)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1498;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3knBqUFcJNg+hqkdsEnZN/pKCUKUaqygxeIWVeuRdqasKfIQrdePJELBChlFQA0gtjZRIxKKrva54/2ntnx81GKISD1QcuVJpUdAC4VmyphlXNGvlN1b5+ad0lnGuN0szhWn1kK+1WwXmUadEAgoQzdTF5DW9MHCbxMxI74FRLAjsZOOz32zwCU8Na29RyQA3JPH6xCp27r7Z4rgBEFCF871Pi3qo4S28pFl0NFereiomhXi2LLhzhHSiSdHorWHWC8yvd/uNnwutyyv9QMDYLiv8VrqgfeRTxVGa2b/byHzpVzrmmep5mCz3U9CENFSZhBEGP6L4fcLIwfpDnWSC/qrShybQX1FBUB/Iw0vqoUW6r/syjY7VPvY9GDbyNzwyuugNw3BhmrsMklGnW5y6EuMN3gSpq1xKX4VCHwsU5zetwDDoDGWDlzFtVA2UJwf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bc91d8-529d-49d7-3928-08d798211e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 12:07:10.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPk5g9MYEL2o37BAehyysHgVTPfwl/kUumbV54amTU4J8b7gU4ltjrDolYFLBngzklM46CHApk1nNE7aV1J7/gzri1rGBZbUpdztp89CiRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1498
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
Changes in v2:
- adapt to the situation of having the previous two patches ahead in the se=
ries

 drivers/iio/adc/at91-sama5d2_adc.c | 140 +++++++++++++++++++--------------=
----
 1 file changed, 73 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index 454a493..34df043 100644
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
@@ -739,45 +738,6 @@ static int at91_adc_configure_trigger(struct iio_trigg=
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
-	/* enable irq only if not using DMA */
-	if (state && !st->dma_st.dma_chan)
-		at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_DRDY);
-	/* disable irq only if not using DMA */
-	if (!state && !st->dma_st.dma_chan)
-		at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
-
 	return 0;
 }
=20
@@ -901,9 +861,22 @@ static int at91_adc_dma_start(struct iio_dev *indio_de=
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
@@ -921,9 +894,40 @@ static int at91_adc_buffer_postenable(struct iio_dev *=
indio_dev)
 	ret =3D at91_adc_dma_start(indio_dev);
 	if (ret) {
 		dev_err(&indio_dev->dev, "buffer postenable failed\n");
+		iio_triggered_buffer_predisable(indio_dev);
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
@@ -944,21 +948,11 @@ static int at91_adc_buffer_predisable(struct iio_dev =
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
@@ -971,12 +965,28 @@ static int at91_adc_buffer_predisable(struct iio_dev =
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
@@ -1131,6 +1141,13 @@ static irqreturn_t at91_adc_trigger_handler(int irq,=
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
@@ -1143,20 +1160,9 @@ static irqreturn_t at91_adc_trigger_handler(int irq,=
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
