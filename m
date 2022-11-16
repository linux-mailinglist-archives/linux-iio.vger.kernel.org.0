Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34C262CEA8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 00:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKPXUw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 18:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiKPXUt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 18:20:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC0967138
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 15:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668640837; bh=TcO94Z8nJH9mtnQDt0N40k7lEnO2Vze6eUJiZsgph7E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ILaYqu5ezMtYvGcJ9y05fk/TGIn81KXml/obiFQ35BMaxkS3wDeRpiQEp7ulwtZ1s
         QXM0WG5PZ7JXnUPHtvpyUb1XehHQpkrmSDeLR4LPXJklT3iL3MOYy/ynu5rVfaC2Q6
         RXVfWlLe3GHqCysLTAdEtCy694RZo2wznGtc5ZUKvO88OWXqS+po1KSi+swrFK5OOw
         vUS7Oq4qFQ6r/ZyHQXq8Px4NdSLZ6VTQkTwvYOXIgeatKFPnXVBmTF/7FnONmz6wI2
         6AHSxlwRuHKwxMvISkDb4QXrd355gODd+AqqxgEPSczpwPYgOu7/dh04LeYnAg0f4+
         TRL1oh2f1/VZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.44.107]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1wlv-1p6DN619z7-012JBV; Thu, 17 Nov 2022 00:20:37 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH 3/3] IIO: hid-sensor-prox: Use generic usage
Date:   Thu, 17 Nov 2022 00:19:47 +0100
Message-Id: <20221116231947.18031-3-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116231947.18031-1-p.jungkamp@gmx.net>
References: <b1980cb048a77428971ddfc3bde238b66c540a1f.camel@gmx.net>
 <20221116231947.18031-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9wBR7jrC/Lf3Jjt57h1uXycSpVR2VuTVgxZMAv4Lljxl614fODW
 hKlO+Zv7IoM981o+EXoqeEQ7SarA7EJ9jshNicJ+VW78+OOCxnrSjzduCrIbmEb+tawBjrW
 ZIXIqiekm2xVmhPzpMNHoBAw5ruRgaE9JxcWY/GcmYQX/y+WsWjt6HiWdD+IjxOf6srOZto
 Wzrssu1h1M+J7K7Fjfoig==
UI-OutboundReport: notjunk:1;M01:P0:gHhA4aHBoM4=;KyHzld/pT3aApvLSA4T8vGFm8N3
 1eXk4ShNwSKUd0MV6ze5BfNlkk8HFIjVHiwLHcX40PCOMTOEiuej34cKCca5QWG+Zv4L+s+eL
 sVv1GlYwxYmLuJ+X7G98M4htlhmbM/V8tInciiZAFoFQeIqaFwz4DihX73G/OzpJAFk8SjfqR
 jjT0Zv0CenHG8VbNo0RSb0UVy0Pm7TXIp+Hcmr/3YbhkVdtbtyD7LK0ij/x50t2sm84Z6Zkir
 y7X3z9YdFPm2FOlvbh3x7csiUbkjbzUZ2xZZ9dPAolUP2UGjOAnCQRnddQTdvrPyFl69I2s5e
 TBhb91PHIO1whf5Bo+hAfuGb7n4c9kDBJRVAMKqumcIcHR5X9ppm4+/ZvSYET6EEMWm0emPVy
 yXjZ2z7GZvmwpAxAkOYLMx0TxeBy5kLtC30QIHqRGK0TAIx/d7kpwbF8LLTggYzNIBc4s6S03
 PtsCl6T6lDyeftmWeOdg0q7JpA/oYMRl9OPKnEHKZ0Cg6k7Su1IMWCrnmXJ3K8RQsbtq4uabS
 qPI1hhxlhq+lTAf4M+dGXs/g55lUs3esqYAEwd7xW0IBjiVq+6laqDWJ6i1NVfChWftdxccsr
 UA5se87CLD/po13iyTzKHqGPeyFc0hxkVZxgazk1ZPuS/nEUSsKIb348Jof3NwJxODVZe8dHP
 Cbj2AT/d2/5XtSygShNqPfHU9Xud0i+YTy5rDsxbOqxsaBXzAJV/8k54Mx0vhE4SfBfW6J/VZ
 9eIhxlX8qlgc0pa1zohgp6heA/52KpsQo1UE6m0AUd0l0At+7sgcs/2yWKruaLn8wu5SY/GI0
 WVTxCZh6WNyt4HLCF7HZ6mq3fKIPpTumGoU+wR+VGgi6AXfWQmpqMtJVJGBzbsT2Atd4EUhBQ
 iw4TK+ey0qPfykH1yOHqLd9V5HMz3yfrTvhMY0juIB8PNZ9nvY9Ox/qsOCZzZ8ga6rZqpRWlc
 ic/yjg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_PROX to
allow this driver to drive the Lenvo custom proximity sensor, which is
registered under a 'custom' usage and not HID_USAGE_SENSOR_PROX.

Check for raw_len to accomodate the ReportSize(8) field used on the
Lenovo Yoga 9 14IAP7.

Add the Lenovo Intelligent Sensing Solution (LISS) human presence sensor
to the platform device ids.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
 drivers/hid/hid-sensor-custom.c     | 10 ++++++++
 drivers/iio/light/hid-sensor-prox.c | 39 +++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cust=
om.c
index 124493b8abaf..ec49dc80f074 100644
=2D-- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -795,6 +795,16 @@ static const struct hid_sensor_custom_match hid_senso=
r_custom_known_table[] =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		}
 	},
+	{	/* human presence */
+		.tag =3D "LISS",
+		.luid =3D "0226000171AC0081",
+		.model =3D "VL53L1_HOD Sensor",
+		.manufacturer =3D "ST_MICRO",
+		.check_dmi =3D true,
+		.dmi.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		}
+	},
 	{}
 };

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-s=
ensor-prox.c
index f10fa2abfe72..cca6b75c44d5 100644
=2D-- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -61,6 +61,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct prox_state *prox_state =3D iio_priv(indio_dev);
+	struct hid_sensor_hub_device *hsdev;
 	int report_id =3D -1;
 	u32 address;
 	int ret_type;
@@ -75,6 +76,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 			report_id =3D prox_state->prox_attr.report_id;
 			min =3D prox_state->prox_attr.logical_minimum;
 			address =3D HID_USAGE_SENSOR_HUMAN_PRESENCE;
+			hsdev =3D prox_state->common_attributes.hsdev;
 			break;
 		default:
 			report_id =3D -1;
@@ -84,8 +86,9 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 			hid_sensor_power_state(&prox_state->common_attributes,
 						true);
 			*val =3D sensor_hub_input_attr_get_raw_value(
-				prox_state->common_attributes.hsdev,
-				HID_USAGE_SENSOR_PROX, address,
+				hsdev,
+				hsdev->usage,
+				address,
 				report_id,
 				SENSOR_HUB_SYNC,
 				min < 0);
@@ -191,10 +194,16 @@ static int prox_capture_sample(struct hid_sensor_hub=
_device *hsdev,

 	switch (usage_id) {
 	case HID_USAGE_SENSOR_HUMAN_PRESENCE:
-		prox_state->human_presence =3D *(u32 *)raw_data;
-		ret =3D 0;
-		break;
-	default:
+		switch (raw_len) {
+		case 1:
+			prox_state->human_presence =3D *(u8 *)raw_data;
+			ret =3D 0;
+			break;
+		case 4:
+			prox_state->human_presence =3D *(u32 *)raw_data;
+			ret =3D 0;
+			break;
+		}
 		break;
 	}

@@ -244,7 +253,8 @@ static int hid_prox_probe(struct platform_device *pdev=
)
 	prox_state->common_attributes.hsdev =3D hsdev;
 	prox_state->common_attributes.pdev =3D pdev;

-	ret =3D hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_PROX,
+	ret =3D hid_sensor_parse_common_attributes(hsdev,
+					hsdev->usage,
 					&prox_state->common_attributes,
 					prox_sensitivity_addresses,
 					ARRAY_SIZE(prox_sensitivity_addresses));
@@ -262,7 +272,8 @@ static int hid_prox_probe(struct platform_device *pdev=
)

 	ret =3D prox_parse_report(pdev, hsdev,
 				(struct iio_chan_spec *)indio_dev->channels,
-				HID_USAGE_SENSOR_PROX, prox_state);
+				hsdev->usage,
+				prox_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
@@ -291,8 +302,9 @@ static int hid_prox_probe(struct platform_device *pdev=
)
 	prox_state->callbacks.send_event =3D prox_proc_event;
 	prox_state->callbacks.capture_sample =3D prox_capture_sample;
 	prox_state->callbacks.pdev =3D pdev;
-	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PROX,
-					&prox_state->callbacks);
+	ret =3D sensor_hub_register_callback(hsdev,
+					   hsdev->usage,
+					   &prox_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
 		goto error_iio_unreg;
@@ -314,7 +326,8 @@ static int hid_prox_remove(struct platform_device *pde=
v)
 	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
 	struct prox_state *prox_state =3D iio_priv(indio_dev);

-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
+	sensor_hub_remove_callback(hsdev,
+				   hsdev->usage);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);

@@ -326,6 +339,10 @@ static const struct platform_device_id hid_prox_ids[]=
 =3D {
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name =3D "HID-SENSOR-200011",
 	},
+	{
+		/* Format: HID-SENSOR-tag-usage_id_in_hex_lowercase */
+		.name =3D "HID-SENSOR-LISS-0226",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, hid_prox_ids);
=2D-
2.38.1

