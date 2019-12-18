Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAAB124D75
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLRQ0O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:26:14 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:12945 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfLRQYH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:07 -0500
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
IronPort-SDR: PcQEKEfSyTfD+XhAm0uOOD5LGVV+SiqiT71XH9TdgR2Wrbugw2KE4w/ElpY92XDKLUIrcdF92F
 pjJdO31HdRg7qYhH3DYyl0d89WKtElFybZDjJpVODXqdKn07moBj31wPEqmJxFT1HRbtU/gGbj
 5r7So9UyBeGE4t+Vt7QSPiDn0WfYrko2R8jWowINaH5ufIhndHAVV2vx2ZPvhHpOHM6gP8ly26
 wAOcoWA3Zb8lJ9a6rsDfiz/RbPigIi6HBBKE4FSp9nqu6+gMujL9pHpqgatGNMRg3XfQF2Sp4E
 W6A=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="60223176"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 09:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOeP6BA/qVSPQqBZv6UjNPM5Fehxc4fhb247rnTjDVC+BDuas9ex33HMKfPE9AkRMsUlmqKXgvrcnlfhbaxz1bCNOhZ9Ab/CY7ErlBOKkeQePtvG6a5WC1azSQDmbt7qcaXaOHM4EowA322BwsR69nEBs48n3f3Ua4m0FNqcoDBoOQPOiKnYhtqi/52Qv1YlgNrLjWdWrv7aC404z7x+3NIiekMmUNzzRpBO+z/0IJbBuoU28oiAJ/sURPIXk0edeJg2+q5xm/qwJetQ1iIIpNxBrp3WU8Ve0oRINJnis1hW0JcOERI3icugk6KyUOvemdLIUEfpR52UEutyW+K5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJqTrSHZ7TbZm2JF06kDVV71UCjwadk6kmq23nwf1Xo=;
 b=ZAiUHH4SuBp6Grw+HcBWX8IO+D6BRwEKKM9bGSKseKcR3ZI91yZdCbLjnaFnFzK6k/xu5AaXgbMKmO0UWUyhHiJ3G2dUqr3jjsY94RnN1MFK8Qj/n07h+333d7H/5fF1ggXjxUlXj9ESqmM5MuxXYXHQms/OXFtJ/iFQjzHBjevwq2R9WBH/0ax5wQ1lZ/+VfxcQnaBxuyWSJfio+lcizSQm5R1BLlw6xeBqjF/LzwlOchBqQIaPY8gb73R5k0O1V0Y4KbWM/S/zDFCr0lnbznFGt/LocMveUIahAJ3dboJx/5qzZnuNyMSORoKrNYC6FqbkXVLcHlj57/YT8x0MsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJqTrSHZ7TbZm2JF06kDVV71UCjwadk6kmq23nwf1Xo=;
 b=T8Qio/2xqykdAtJHWqn4JfGEPXTWG1WEIgswCK83wnYw+3Jb2ytX+/p/mAz1VS0i7KvTmY/ANlIvOQ8tgr0KHeiEabjILa3dZysrXryuTr7o2U0VXLAQIiHDVSgSu4AhY0GMdE47K31oq84VndO9HCMMpJUScxw5/jT5olHI6Bg=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1769.namprd11.prod.outlook.com (10.175.87.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Wed, 18 Dec 2019 16:24:04 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:24:04 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 08/10] iio: adc: at91-sama5d2_adc: implement RTC triggering
Thread-Topic: [PATCH 08/10] iio: adc: at91-sama5d2_adc: implement RTC
 triggering
Thread-Index: AQHVtb+PY+2GOhnEgUmPI9B1JjcPqQ==
Date:   Wed, 18 Dec 2019 16:24:02 +0000
Message-ID: <1576686157-11939-9-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de9518a9-816d-4edd-7cd3-08d783d6b2f0
x-ms-traffictypediagnostic: DM5PR11MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB176945A1A774BFD9FD46B209E8530@DM5PR11MB1769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(66476007)(66946007)(66446008)(76116006)(91956017)(2616005)(64756008)(66556008)(86362001)(186003)(316002)(110136005)(8676002)(54906003)(8936002)(71200400001)(81166006)(478600001)(2906002)(6512007)(26005)(81156014)(36756003)(4326008)(6506007)(5660300002)(6486002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1769;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auXWNrOB7IiMQ6Qv3HJfkGHrvtg5CcOwKG8HCoUvXhr9C12luOXCnO7eI8j1+mdwSYrtAnPn1mQVIcE/v7xXLucIO9exLfhqJxliJMUMNhSR1qTnzAskSTFyZy3/n/ZuagUEVK3akN2iTOy6XSk/2WEaQnjcZzUMhXz/Yo/6Q+VzzOSHwietMXNvvHqQLvp8nTS10qac4u3d4q3wzegOfVSNvfNGD1fHs8TjxiATD2akOiKM1d6KDtVKMXTJo0cObipjUyJ3YsUtnmqmuvjmdQxapWelXUssF4IPIvJ/LKg6r4z3TTdHH7d2oem71AoJZCcGEcuoFm73aztMIQmDxm7RPBa1TxRl8VnzUEPp/o6GpfOkICqgnh0HnJ9REUmUwpJqeasi4xJXYTi8Kq3/cn/53Fhs0LraKYD/7m/6h0ToQJ7wfuj9OMPi8jWLABmm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de9518a9-816d-4edd-7cd3-08d783d6b2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:24:02.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0M66B1eUg1QrnZYRG2LpBybtxzJc7NO2O2LkE5DN0XBta2ZvbT4BLM2sN8WlJQJ1eA7DG/Iot0Z6One3E3gTVVUUCTvd1WWXvRjbSbyQJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1769
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Implement the property atmel,rtc-trigger which provides a phandle
to a RTC trigger.
To make it work, one has to check at buffer_postenable if the trigger
the device is using is the one we provide using the phandle link.
The trigger mode must be selected accordingly in the trigger mode selection
register.
The RTC trigger will use our IRQ. Dedicated hardware line inside the SoC
will actually trigger the ADC to make the conversion, and EOC irqs are fire=
d
when conversion is done.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 109 +++++++++++++++++++++++++++++++++=
++--
 1 file changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index ccffa48..ac97f4a 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -58,6 +58,8 @@
 #define	AT91_SAMA5D2_MR_TRGSEL_TRIG6	6
 /* RTCOUT0 */
 #define	AT91_SAMA5D2_MR_TRGSEL_TRIG7	7
+/* TRGSEL mask */
+#define AT91_SAMA5D2_MR_TRGSEL_MASK	GENMASK(3, 1)
 /* Sleep Mode */
 #define	AT91_SAMA5D2_MR_SLEEP		BIT(5)
 /* Fast Wake Up */
@@ -195,6 +197,8 @@
 #define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL 2
 /* Trigger Mode external trigger any edge */
 #define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY 3
+/* Trigger Mode RTC - must be any of the above 3 values */
+#define AT91_SAMA5D2_TRGR_TRGMOD_RTC AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RIS=
E
 /* Trigger Mode internal periodic */
 #define AT91_SAMA5D2_TRGR_TRGMOD_PERIODIC 5
 /* Trigger Mode - trigger period mask */
@@ -407,6 +411,8 @@ struct at91_adc_state {
 	struct mutex			lock;
 	struct work_struct		workq;
 	s64				timestamp;
+	struct device			*rtc_trig_dev;
+	bool				rtc_triggered;
 };
=20
 static const struct at91_adc_trigger at91_adc_trigger_list[] =3D {
@@ -737,6 +743,42 @@ static int at91_adc_configure_trigger(struct iio_trigg=
er *trig, bool state)
 	/* set/unset hw trigger */
 	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
=20
+	status =3D at91_adc_readl(st, AT91_SAMA5D2_MR);
+
+	status &=3D ~AT91_SAMA5D2_MR_TRGSEL_MASK;
+
+	/* set/unset TRGSEL to ADTRG */
+	if (state)
+		status |=3D AT91_SAMA5D2_MR_TRGSEL(AT91_SAMA5D2_MR_TRGSEL_TRIG0);
+
+	at91_adc_writel(st, AT91_SAMA5D2_MR, status);
+
+	return 0;
+}
+
+static int at91_adc_rtc_configure_trigger(struct at91_adc_state *st, bool =
state)
+{
+	u32 status =3D at91_adc_readl(st, AT91_SAMA5D2_TRGR);
+
+	/* clear TRGMOD */
+	status &=3D ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
+
+	if (state)
+		status |=3D AT91_SAMA5D2_TRGR_TRGMOD_RTC;
+
+	/* set/unset hw trigger */
+	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
+
+	status =3D at91_adc_readl(st, AT91_SAMA5D2_MR);
+
+	status &=3D ~AT91_SAMA5D2_MR_TRGSEL_MASK;
+
+	/* set/unset TRGSEL to RTCOUT0 */
+	if (state)
+		status |=3D AT91_SAMA5D2_MR_TRGSEL(AT91_SAMA5D2_MR_TRGSEL_TRIG7);
+
+	at91_adc_writel(st, AT91_SAMA5D2_MR, status);
+
 	return 0;
 }
=20
@@ -866,7 +908,8 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev=
)
 	if (st->dma_st.dma_chan) \
 		use_irq =3D false; \
 	/* if the trigger is not ours, then it has its own IRQ */ \
-	if (iio_trigger_validate_own_device(indio->trig, indio)) \
+	if (iio_trigger_validate_own_device(indio->trig, indio) && \
+		!st->rtc_triggered) \
 		use_irq =3D false; \
 	}
=20
@@ -884,6 +927,18 @@ static int at91_adc_buffer_postenable(struct iio_dev *=
indio)
 		/* touchscreen enabling */
 		return at91_adc_configure_touch(st, true);
 	}
+
+	/*
+	 * If our rtc trigger link is identical to the current trigger,
+	 * then we are rtc-triggered.
+	 * Configure accordingly.
+	 */
+	if (!IS_ERR_OR_NULL(st->rtc_trig_dev) &&
+	    st->rtc_trig_dev =3D=3D indio->trig->dev.parent) {
+		at91_adc_rtc_configure_trigger(st, true);
+		st->rtc_triggered =3D true;
+	}
+
 	/* if we are not in triggered mode, we cannot enable the buffer. */
 	if (!(indio->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
@@ -947,6 +1002,17 @@ static int at91_adc_buffer_predisable(struct iio_dev =
*indio)
 	if (!(indio->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
=20
+	/*
+	 * If our rtc trigger link is identical to the current trigger,
+	 * then we are rtc-triggered.
+	 * Unconfigure accordingly.
+	 */
+	if (!IS_ERR_OR_NULL(st->rtc_trig_dev) &&
+	    st->rtc_trig_dev =3D=3D indio->trig->dev.parent) {
+		at91_adc_rtc_configure_trigger(st, false);
+		st->rtc_triggered =3D false;
+	}
+
 	AT91_ADC_BUFFER_CHECK_USE_IRQ(use_irq);
 	/*
 	 * For each enable channel we must disable it in hardware.
@@ -1153,8 +1219,15 @@ static irqreturn_t at91_adc_trigger_handler(int irq,=
 void *p)
 	else
 		ret =3D at91_adc_trigger_handler_nodma(indio_dev, pf);
=20
-	if (!ret)
+	if (!ret) {
 		iio_trigger_notify_done(indio_dev->trig);
+		/*
+		 * RTC trigger does not know how to reenable our IRQ.
+		 * So, we must do it.
+		 */
+		if (st->rtc_triggered)
+			enable_irq(st->irq);
+	}
=20
 	return IRQ_HANDLED;
 }
@@ -1166,10 +1239,13 @@ irqreturn_t at91_adc_pollfunc(int irq, void *p)
 	struct at91_adc_state *st =3D iio_priv(indio_dev);
=20
 	/*
-	 * If it's not our trigger, start a conversion now, as we are
-	 * actually polling the trigger now.
+	 * We need to start a software trigger if we are not using a trigger
+	 * that uses our own IRQ.
+	 * External trigger and RTC trigger do not not need software start
+	 * However the other triggers do.
 	 */
-	if (iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
+	if (iio_trigger_validate_own_device(indio_dev->trig, indio_dev) &&
+	    !st->rtc_triggered)
 		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
=20
 	return iio_pollfunc_store_time(irq, p);
@@ -1307,6 +1383,12 @@ static void at91_adc_workq_handler(struct work_struc=
t *workq)
=20
 		at91_adc_read_and_push_channels(indio_dev, st->timestamp);
 		iio_trigger_notify_done(indio_dev->trig);
+		/*
+		 * RTC trigger does not know how to reenable our IRQ.
+		 * So, we must do it.
+		 */
+		if (st->rtc_triggered)
+			enable_irq(st->irq);
 	} else {
 		iio_push_to_buffers(indio_dev, st->buffer);
 	}
@@ -1712,6 +1794,7 @@ static int at91_adc_probe(struct platform_device *pde=
v)
 	struct iio_dev *indio_dev;
 	struct at91_adc_state *st;
 	struct resource	*res;
+	struct device_node *rtc_trig_np;
 	int ret, i;
 	u32 edge_type =3D IRQ_TYPE_NONE;
=20
@@ -1737,6 +1820,8 @@ static int at91_adc_probe(struct platform_device *pde=
v)
=20
 	st->oversampling_ratio =3D AT91_OSR_1SAMPLES;
=20
+	st->rtc_trig_dev =3D ERR_PTR(-EINVAL);
+
 	ret =3D of_property_read_u32(pdev->dev.of_node,
 				   "atmel,min-sample-rate-hz",
 				   &st->soc_info.min_sample_rate);
@@ -1784,6 +1869,20 @@ static int at91_adc_probe(struct platform_device *pd=
ev)
 		return -EINVAL;
 	}
=20
+	rtc_trig_np =3D of_parse_phandle(pdev->dev.of_node, "atmel,rtc-trigger",
+				       0);
+	if (rtc_trig_np) {
+		struct platform_device *rtc_trig_plat_dev;
+
+		rtc_trig_plat_dev =3D of_find_device_by_node(rtc_trig_np);
+		if (rtc_trig_plat_dev) {
+			st->rtc_trig_dev =3D &rtc_trig_plat_dev->dev;
+			dev_info(&pdev->dev,
+				 "RTC trigger link set-up with %s\n",
+				 dev_name(st->rtc_trig_dev));
+		}
+	}
+
 	init_waitqueue_head(&st->wq_data_available);
 	mutex_init(&st->lock);
 	INIT_WORK(&st->workq, at91_adc_workq_handler);
--=20
2.7.4
