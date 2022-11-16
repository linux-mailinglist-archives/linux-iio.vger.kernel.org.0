Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF11D62CEA7
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 00:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiKPXUt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 18:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiKPXUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 18:20:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AFF67F6D
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 15:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668640835; bh=1y+8rZE7q0ABSXY9muV0WeS/+08Tcvy1TbPfZoxaXkw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aveEc14nW8eGIdPS/C1NLvRpbOgAbTbJm7Me+qwJ6mgqDkpTL2M5yd5/ev5ac/4Ky
         2ci4klyHXcj27n5H1n0QZjtjXQcjSVYi01/GyBAEReGLYN/+4BGV1BIhOhq3Ya2OKy
         LCmBuCAjkc92Q4OQfQnaRTiSiryv+HsmuDI16hRDZ0YdT+03b+lA+P163DMqlgNx06
         EqgcE9Ht7UaQM0NCJuPPogHQZGwDeLZ0gCyo+bcwp4JONYgjfY7MbO7Ncl6zSKX44H
         1tXg+yqlGTOOyLGgJRRdgjpKVJHKtLM9SkjFCq5mGnREes44OmNaFXsH55+ECVZ3ql
         xjx3di9DxuV2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.44.107]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M1Hdw-1oyCrY44ny-002ocA; Thu, 17 Nov 2022 00:20:35 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH 2/3] IIO: hid-sensor-als: Use generic usage
Date:   Thu, 17 Nov 2022 00:19:46 +0100
Message-Id: <20221116231947.18031-2-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116231947.18031-1-p.jungkamp@gmx.net>
References: <b1980cb048a77428971ddfc3bde238b66c540a1f.camel@gmx.net>
 <20221116231947.18031-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bfAPTdK3LER8BL5f7TXnwR55+T4GIbVySgScXmvsm8W7p+Oon07
 VCmKRGZcCARJUQQGYvsP4wWWId1JoIwBDhx8PSUYxxg0Zr5rVBi24OUzAK/Doe1Cyo62NrF
 01e2SQmLDi3yAClzHmiF0NybOVoJmMongWK9Xxm1iZgqdwaQWlF2f3+LVSw9/7zBA+TyYTL
 CFDLd9exx/gO0ErEuyzwQ==
UI-OutboundReport: notjunk:1;M01:P0:hdURPqeR9O8=;s/hcK9P0p2qTplVtYJj0ut1sYpt
 DOZcSLvP0m0DAnfBTE/rUUkfeM6REj/ZBB9DO1ihtjiIOyGBtyDBPQ6z+ms2lFdvui6EyzHts
 ev0F6tT9UFE9PQtQfCKKsMbRAoHB9nceWNA+GuEqk44blC+gpnRWETYEssvkBKU91UtEsebmz
 omjgCalka+wsoc7YfWpeOoHNReEyfEvPconZsRxwe9jcuEcMc7Go/oRY6zDEEt7EcG10RxHnf
 GSe0Qpmc0rJblxsKCaGFYrd4ESdB8TjxLghrq0TLsf+QFC33qEXqoBhVCKD7WkJYuAaaSqIic
 pIIg1phGkbceoseYfLL8dmcjQUniNAa0yvgo9/OF3ZvMQInSNtw+rk4rr9Shpy7RDwPTp2NjG
 YfbzKOUDVj10QJMVrUDS1vwZXzOcOzWOVO7OkWH1YeuFF8HY+w2lJ5uhMkhpNtKWhQvirjdTc
 K4wg4Zas0703k1BOAybVfnvUWBz3QiQaYLw55tZcswElr2peUsAMbwWT0lCktKiI+I+WCm1Ic
 MJC50do24zWRvjsV4R4wbskh2jYJlz2zUNBjBqiRtszHOGjON6KC1NdAu0io/+7BuFsKr/yrz
 Ns3PHEfYuFE/ZXdf7jW3+rlpOryPgRE2ukfEvSARUIy3hkzk3vFHFIQzgWjeZfttD3KOqUAdl
 MCK4dyxo56510KM57BrPIwGFobqxIhBHDxLxqfIytH2oMx/GlrznL20w/AfXzL0PZnKHesqro
 IU5QgGAdSN6oAtyTBbDQjuqTHdgjRvTbPQRaAmFRIAmNujWqBjZwRcurUDd8OL8yAF9N+OUAp
 miIqD7lQeeqJp2iVYTHTO9xfGM3JqObhL2HApMazEmxJPGtEpJcNoq43DkDnxIHK/xujBwuuL
 w7qkrez1FefZ8Pv7zodfRNGM96MP58rYJiXAy/XQrxqh5JJKAt6a2vOJWdIlxIezlYjSLwLab
 DG3JkYGFfjBpFjsRiO+v7+0FXrQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_ALS to
allow this driver to drive the Lenvo custom ambient light sensor,
which is registered under a 'custom' usage and not HID_USAGE_SENSOR_ALS.

Add the Lenovo Intelligent Sensing Solution (LISS) ambient light sensor
to the platform device ids.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
 drivers/hid/hid-sensor-custom.c    | 13 +++++++++++++
 drivers/iio/light/hid-sensor-als.c | 24 +++++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cust=
om.c
index cb21f9178830..124493b8abaf 100644
=2D-- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -782,6 +782,19 @@ static const struct hid_sensor_custom_match hid_senso=
r_custom_known_table[] =3D {
 		.luid =3D "020B000000000000",
 		.manufacturer =3D "INTEL",
 	},
+	/*
+	 * Lenovo Intelligent Sensing Solution (LISS)
+	 */
+	{	/* ambient light */
+		.tag =3D "LISS",
+		.luid =3D "0041010200000082",
+		.model =3D "STK3X3X Sensor",
+		.manufacturer =3D "Vendor 258",
+		.check_dmi =3D true,
+		.dmi.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		}
+	},
 	{}
 };

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-se=
nsor-als.c
index 5a1a625d8d16..0ada158582a9 100644
=2D-- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -86,6 +86,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct als_state *als_state =3D iio_priv(indio_dev);
+	struct hid_sensor_hub_device *hsdev =3D als_state->common_attributes.hsd=
ev;
 	int report_id =3D -1;
 	u32 address;
 	int ret_type;
@@ -110,8 +111,9 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			hid_sensor_power_state(&als_state->common_attributes,
 						true);
 			*val =3D sensor_hub_input_attr_get_raw_value(
-					als_state->common_attributes.hsdev,
-					HID_USAGE_SENSOR_ALS, address,
+					hsdev,
+					hsdev->usage,
+					address,
 					report_id,
 					SENSOR_HUB_SYNC,
 					min < 0);
@@ -260,7 +262,7 @@ static int als_parse_report(struct platform_device *pd=
ev,
 			st->als_illum.report_id);

 	st->scale_precision =3D hid_sensor_format_scale(
-				HID_USAGE_SENSOR_ALS,
+				usage_id,
 				&st->als_illum,
 				&st->scale_pre_decml, &st->scale_post_decml);

@@ -285,7 +287,8 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->common_attributes.hsdev =3D hsdev;
 	als_state->common_attributes.pdev =3D pdev;

-	ret =3D hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_ALS,
+	ret =3D hid_sensor_parse_common_attributes(hsdev,
+					hsdev->usage,
 					&als_state->common_attributes,
 					als_sensitivity_addresses,
 					ARRAY_SIZE(als_sensitivity_addresses));
@@ -303,7 +306,8 @@ static int hid_als_probe(struct platform_device *pdev)

 	ret =3D als_parse_report(pdev, hsdev,
 			       (struct iio_chan_spec *)indio_dev->channels,
-			       HID_USAGE_SENSOR_ALS, als_state);
+			       hsdev->usage,
+			       als_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
@@ -333,7 +337,8 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->callbacks.send_event =3D als_proc_event;
 	als_state->callbacks.capture_sample =3D als_capture_sample;
 	als_state->callbacks.pdev =3D pdev;
-	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ALS,
+	ret =3D sensor_hub_register_callback(hsdev,
+					hsdev->usage,
 					&als_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
@@ -356,7 +361,8 @@ static int hid_als_remove(struct platform_device *pdev=
)
 	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
 	struct als_state *als_state =3D iio_priv(indio_dev);

-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
+	sensor_hub_remove_callback(hsdev,
+				hsdev->usage);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);

@@ -368,6 +374,10 @@ static const struct platform_device_id hid_als_ids[] =
=3D {
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name =3D "HID-SENSOR-200041",
 	},
+	{
+		/* Format: HID-SENSOR-custom_sensor_tag-usage_id_in_hex_lowercase */
+		.name =3D "HID-SENSOR-LISS-0041",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, hid_als_ids);
=2D-
2.38.1

