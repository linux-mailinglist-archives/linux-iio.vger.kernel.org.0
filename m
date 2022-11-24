Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA29D6381CB
	for <lists+linux-iio@lfdr.de>; Fri, 25 Nov 2022 00:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKXXjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 18:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXXjW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 18:39:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852A3C23
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2022 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669333151; bh=55itiq0RJA/gxMewSN5EVTJB0VSsjVh4MwDDftTJCHc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ct7sODvzcc6lUcU+4J2DrSJg1hQ5HdScdcDC1n5WsGfBO4XvTpTyYCdKTT1rcyEa1
         rVHLCnbriEPl0W4Kg4mYP+0LuaktlNDGf4nvWD3guBaJmpUSiaGYycQhFaEXHSktsS
         uGx1v8ABZJAy9mkXzLZCtf1KdUk2+5E/wAycXhrlNzs/SLC1iwH08QJLE7Ajoa7QvD
         nKksrTri5smRftO6zu0XbHIwRRyhiIY93yGUOaaovIX7sfC82n/Z0zAN3UJ9HjPbEv
         oEW0G02eLKASIh9v1XLdsAGytFNDpOxKPdwCOKKUbMe8oX61einYuIxcADcfZBuPP6
         ExFsypNVlOIgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.67]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MfHEJ-1oWk9U36lv-00glTQ; Fri, 25 Nov 2022 00:39:11 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v4 3/4] IIO: hid-sensor-als: Use generic usage
Date:   Fri, 25 Nov 2022 00:38:40 +0100
Message-Id: <20221124233841.3103-4-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124233841.3103-1-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sBvQL6Dpxk25xDSZUudnIHMVTu/cwEuuJZZvFjvLhYmwXHQrSoj
 7C0NjUWx7wrnF6birau46JiG8CLOjydYmYn4gQlvsbyT5Io83g03PTpVTsuHbdHnBq27DkL
 3wWC741ZLgUH+aCBx7tyOQSR7OcDyvy7vjhcxGEXgAastLx2W3nGYhrRiRx0gkobQOHls29
 tLxys+GWL7PcSaRUzZrYw==
UI-OutboundReport: notjunk:1;M01:P0:LrRSrmRpVxk=;8dbPUAO0b5ZHbtWMQjdCnVidmmr
 rDk1VDPGiV/w9SXRDt4uCoYEUXf+ArCLpQk+IUmurKOMMQWcOzXHR8EVmM7HRfrhfHTky6gJP
 xJaOh5h713dBYNNiQKQkq8MsmHHP6ptyfBtOIKfw23rNzX2pjRG4qYZ7MMLPN1p7mydU0Gri6
 Gq5+zGVhtMRbaf8LCu7uFTQIbmHbsrEd5+PYxOn/3WsIS0KJ1bakC5GV8HQHDCZlx07jo9/en
 FGztvh5vZzmjSK7bQwODBPKAmkikI/NlT2o0KsSV0u/C8JLRwP6v5tDM3AuU9ZKVgJC70b9nz
 23QOiqxE/h3i41lIwu3im4eFHy3pDffjMzlOVtwCU7xkcuAl+g0SCApWo+PtLxUEJq4vbh/la
 ma8/fmcaYW9iiSFG26BU9Pga0Jq/6V6ZP8Twrvy3612OzvBJHNCUKx7s8EFVyFXRrbIxLE326
 7klPDD3ydl5jlYoRBCiHhuBt/GcGiDr2zI01RH+zY9MoepRUWlXL+qVE9K4ywyv6A/DwyaMMG
 ri7lpqM3oLo+5S9f6MZqsbd8sWrFQCKtQEmviGkB30O8bYVsf+zMMXIaziVFEpOLHikayPbNl
 zo7IVHDGhy8wZBEBH4mtmuh/quICqN3klyx5GYscRdOIcBBj1wYOVWGxWtzkFpHUlmh/3f/TV
 Zq80pz0EYapOIuBXXP99Jo3Htdfz9VoW6rhYEG6dcZOVj4Xzxn517lJnp0WOAT+vlZvyOER4u
 FXTF6Top+IDOGB3MDJm3flZfjuOkIJXgkOtsrm9rIA9BjJZHYf/M6eCPc2/asBdBVHs0knnRM
 KRLUXMHEwraMXAmC2SQC+/5g1krF08Xy7n/wj+qcbN3wpWC9WIlSUz9shRzH8E/kdtdfnJHR8
 N+KZh0DTfqivlu+V3cJEqXNv530T7vJuPKsr9tgxA9tEhM6wZLRhFsUIjTGT+g1RDfBk6Kvn6
 MPUCRA==
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
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

v2:
- Remove some unnecessary newlines in function calls.

v3:
- No change.

v4:
- No change.

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

