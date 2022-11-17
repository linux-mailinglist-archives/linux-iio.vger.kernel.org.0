Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA062E9DA
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 00:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKQXtL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 18:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiKQXtJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 18:49:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E79532EE
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 15:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668728938; bh=zIOolA9952zV+6SNTVjguhB5zc/PxoGHuNoxiOEklMc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CYaQrexCPWkvB4K7HCCUV70u0D3YqgBR9ePeefEWUt/a2lX3vobK2PxB18atbEDQx
         9XnSlvoTQxI3BFMTpJMMzytIIicsLhpwg6AM/4HQqUf2pqxL6efeYmKswjQiu8ic3N
         6+14lR8hOleqczgYTEgKUyjhPDCEG+5IMCU/rt7cS/SFje49BOjbbckNxCvG7MEVOt
         SMdzaOISqzHi5uiIXSTCTZ4R0oz75Cynnx9X95/Cj3GpbjLsaP1F79DQNUqmI6W2IN
         HpEmuE6gIZfPj5F6VYNHUTCGZdy4kCNX5/PomFj9Szrdo3XxQ7j1tNOz7CkqRCat1E
         xPchfsxStDi0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.31]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MybGh-1pACJj2Eyj-00z1HI; Fri, 18 Nov 2022 00:48:58 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v3 3/4] IIO: hid-sensor-als: Use generic usage
Date:   Fri, 18 Nov 2022 00:48:23 +0100
Message-Id: <20221117234824.6227-3-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117234824.6227-1-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
 <20221117234824.6227-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+Lw3Kwaq4T7WZF5qjT0PDZusoXKQWzpeLqJv+wKjWrRyglIep+
 v7sv9Jg+zuYrbV+EBIG1rgmmesi96KLIjsv2hVF/KkhKcFf9x1KDW9AN0EVCWloZydkRiQL
 3ix8iOI2MivV6Y0v+fTFfDLdVylJV2Y5KrbsDICIfR/3nUnyA99ZvR0683dhseVgqLfmRsE
 OMMEwxBA+Zwhxp9CqbvVQ==
UI-OutboundReport: notjunk:1;M01:P0:DYjvMxMyr5Q=;Wn0xAxIj0+QMZhFRsk8RHl73DzT
 dlWZcp+8DBmhIvJHTF7+ZyJxpU+t1JvWtsFYv7C9u9+SjSTmRu36CNZrfV1axwIRthB6ns07s
 YpeFFvY7UKE7eBMIBgSQIDCZI1JE8uk4oaXmCG3FpcdBodC0oezKx5NvujNXPektiD0cyQQjk
 1Cj40ELLKf2ccnFUzYh7Csvl9PJwYpsW3uu2/H2mSe0D66gXtaCz382gswK1EzZHNjn6vOJ9O
 5+9DYzr3ou52OIq2/RVbVmyfAjPOTOF09NBMRCxEVWHSna3PZqsdkJcLVMqsJt2tGqUDmNJ+G
 yoNcrO9dA0/hGCga8HWqiUHYDFGMRTcgahZ0YdRzMs8X73d874Hn2BaOcWH+LcdimDJEZ7122
 vEuNkppsZZ38Dc8z2QtvBal+S/nDv8tTkJzSIVVivCNIiRo6hlkJxK49Tj48bxSqJ/nci5ISq
 Res09snEEUU4Iet2V7SrcJI5v0SzG+feTu078seLEhrlL0LzsJqKfQ6C8eMIKSywpl+EacFP5
 hU0PRW0Jp9ecpzCs9zFzYqS/xenuop+hf1an0frOzWq497/3fy0WLmgDmiFBtdfEACuP4mUmE
 k2HrpfEkWQZWbacmUC/v1EeRuMWx/EPmJXY8nFzumpjzKbT8KyGx1H9+5Ay+XV3t5880E5S6E
 QMrOoR5QoVSSAxlGarMp3Vw1UnBt4BDodkd9Tx4evgNs9Ii0knpo7JZPH2VPNaDK4ZBTnH/Bm
 qRG9Ul7l60dIuVoHvHC6hGQDcrVvLcMfiy2zosRRHYQCh5df+UZf3r9X0kmpudqQQen3MeYzn
 2O9IqrFN3sx9opGHwm9PtRqMg3wku7LDIGbCgdSP0BSpjHnY8244NUCev/ZsWBhkTtsNKtaeu
 LeHcBeQMB8IF1pSwy9dHRK1TIltBgNae4M97hMxdr/wJFXyly9RFrM3GUdj671u1NqBbfp3fi
 Dp5DfO/VysfrNVHJdETqHJD79Uo=
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
allow this driver to drive the Lenovo custom ambient light sensor,
which is registered under a 'custom' usage and not HID_USAGE_SENSOR_ALS.

Add the Lenovo Intelligent Sensing Solution (LISS) ambient light sensor
to the platform device ids.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
Less unnecessary line breaks in function calls.

 drivers/iio/light/hid-sensor-als.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-se=
nsor-als.c
index 5a1a625d8d16..eb1aedad7edc 100644
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
@@ -110,11 +111,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			hid_sensor_power_state(&als_state->common_attributes,
 						true);
 			*val =3D sensor_hub_input_attr_get_raw_value(
-					als_state->common_attributes.hsdev,
-					HID_USAGE_SENSOR_ALS, address,
-					report_id,
-					SENSOR_HUB_SYNC,
-					min < 0);
+					hsdev, hsdev->usage, address, report_id,
+					SENSOR_HUB_SYNC, min < 0);
 			hid_sensor_power_state(&als_state->common_attributes,
 						false);
 		} else {
@@ -259,9 +257,7 @@ static int als_parse_report(struct platform_device *pd=
ev,
 	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
 			st->als_illum.report_id);

-	st->scale_precision =3D hid_sensor_format_scale(
-				HID_USAGE_SENSOR_ALS,
-				&st->als_illum,
+	st->scale_precision =3D hid_sensor_format_scale(usage_id, &st->als_illum=
,
 				&st->scale_pre_decml, &st->scale_post_decml);

 	return ret;
@@ -285,7 +281,8 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->common_attributes.hsdev =3D hsdev;
 	als_state->common_attributes.pdev =3D pdev;

-	ret =3D hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_ALS,
+	ret =3D hid_sensor_parse_common_attributes(hsdev,
+					hsdev->usage,
 					&als_state->common_attributes,
 					als_sensitivity_addresses,
 					ARRAY_SIZE(als_sensitivity_addresses));
@@ -303,7 +300,8 @@ static int hid_als_probe(struct platform_device *pdev)

 	ret =3D als_parse_report(pdev, hsdev,
 			       (struct iio_chan_spec *)indio_dev->channels,
-			       HID_USAGE_SENSOR_ALS, als_state);
+			       hsdev->usage,
+			       als_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
@@ -333,8 +331,7 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->callbacks.send_event =3D als_proc_event;
 	als_state->callbacks.capture_sample =3D als_capture_sample;
 	als_state->callbacks.pdev =3D pdev;
-	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ALS,
-					&als_state->callbacks);
+	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->ca=
llbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
 		goto error_iio_unreg;
@@ -356,7 +353,7 @@ static int hid_als_remove(struct platform_device *pdev=
)
 	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
 	struct als_state *als_state =3D iio_priv(indio_dev);

-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);

@@ -368,6 +365,10 @@ static const struct platform_device_id hid_als_ids[] =
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

