Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8A6381CA
	for <lists+linux-iio@lfdr.de>; Fri, 25 Nov 2022 00:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKXXjX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 18:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKXXjW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 18:39:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851592F9
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2022 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669333152; bh=jYFyA1DmUfz2aXpmxHrhCM1pqCU+obmDBNXSh3HwCME=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Stw2tDYWiN9WgYA7Bhuu7KXZ/L5Rb/gr2A7cWoxmdptrVTc3lLJWr5G7XYVl8dBko
         WPGaGYJ2kEkC6BA/mdE/hvMpPwlyd0zetknF7N2WfvZKXAYXTWmCaTe/AXoCJ006vS
         PBUkMlptHw2ttQDfSoRHwULCO9cUYmurizL+qA12GxBwT1LGgmltissvGe0bZBnfi0
         xSzEvqugwIDKhO7McCLBiI+AeL2KlTn2dDh6nzLWRDI9UmlceJJjYqG2GqZ/BkrT2s
         xCD9IL3Ro0Gf2EVApRW6+U7nMFt9yPnsrFlABfPSo3FZJSkZlCtGE8tBlgRKDWvgr6
         bD32NNxQ/HqKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.67]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N8XU1-1ouU744Bn7-014WlK; Fri, 25 Nov 2022 00:39:12 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v4 4/4] IIO: hid-sensor-prox: Use generic usage
Date:   Fri, 25 Nov 2022 00:38:41 +0100
Message-Id: <20221124233841.3103-5-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124233841.3103-1-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v+Q9krQIN+bt2RJ+P5lrH8OAzRUDHYWbUfSY3ncJiY96HaIssMR
 rLLwT7yPuNs6evL6peGTfWNtLNWGU4FrHwvUMVrTOuJHnXYFo0hjSstDYgv6+Seqc+0oQXg
 e8SnwzN29g829OOYwnGgPM7rxYtN97v8RAGC5s1DRuQyOSwKp30ru6Jb0cZ5eW/D6YtT0z2
 pDMLq8JYisHkJXzQ83BXA==
UI-OutboundReport: notjunk:1;M01:P0:lPEGU2h3B/o=;m4TPMssJtroqdwITYxg6Uec7TLJ
 bVo+1J40k262Qw+dclfdHYTV45Q5t/PVDUSGTI8hSr7yhhl7kmSDb3Ann2jqHdbX+g5tFX7+l
 raAOyGDBLcwX3NYWDLcGuSHZELoX91MoYbgk8VvKvjbkXN4VtY3k/OjYzNAuuzMufmJEAjxf7
 pb2UKoGmLk3cueV+hizRfcRmn0cfYnM8yWCtkGFnpAcba113arg6NXkg7GtLsS3OQCWoRGEPO
 1PAWy9Jgzsal+H3R/3zTxawsCtLdrs8/+F8pOa1qSDpnN22vmXU5MBe1/zH+qYjzgTZbQcnyG
 5Ya+UFGtyhlCeW7Mdqy8UyJ/4+uPu92ADqqF5r1ZozwwEcKMpmnLmmmEgfrM3awNs3MELLiKa
 Erfu5KVU5X3D1tuwixyC8ji8llPRFbr4u8rP6NoXoid+nuDLLU1JAqrBLjXBMmQ1eVlms5Fe6
 8S2P7zr5rIacWF86P0+7SBXDUbcMb/w//gGG/lkTt60QgSJ1Gk1WEPRptvkA+XVtWZFbanBxo
 gNQE86+6m1/VGvHZL6+Yzoyz9tbuyeGA6KVdvDiHEx3Kg6BKwmHSWtAfd8SWKGhEngmnIH+OB
 h0mmImQjHyswYG4nrTFzsx+w5AzTUFs1VwvbktNIBEVyqRgEEIfrdd61H96mrfmStHUlt0DaJ
 kE9KK3E8YgmURe9kl3tNnwQ57m2SMs4jPs2mORLDVrqbjcjgpMACpI7WBhWO30TocRpE7Ev4U
 7gTz0PFoE5mF0zeqs5x5CNjMZJErcjpiTxkCD9ypgewODAjW9NxzYpMkxM0/Re75Ea8EocSnj
 RcOpmLUXJUsekuo+HBJ18ujkEQDBI02+//6JFEhKS/77RwFtpw5/2Wi6ijbGgaMaJwFYIzGOE
 byygXyc8Z5E5VyiJOe297fSU4BXfe7iYRybGdCL0fu3wzjcN35H0M67IM2bj8ZgF76uCoJvXt
 gRnGjA==
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_PROX to
allow this driver to drive the Lenvo custom proximity sensor, which is
registered under a 'custom' usage and not HID_USAGE_SENSOR_PROX.

Add the Lenovo Intelligent Sensing Solution (LISS) human presence sensor
to the platform device ids.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--

v2:
- Remove some unnecessary newlines in function calls.

v3:
- No change.

v4:
- Clean up switch statement.

 drivers/iio/light/hid-sensor-prox.c | 37 ++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-s=
ensor-prox.c
index f10fa2abfe72..a47591e1bad9 100644
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
@@ -84,11 +86,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 			hid_sensor_power_state(&prox_state->common_attributes,
 						true);
 			*val =3D sensor_hub_input_attr_get_raw_value(
-				prox_state->common_attributes.hsdev,
-				HID_USAGE_SENSOR_PROX, address,
-				report_id,
-				SENSOR_HUB_SYNC,
-				min < 0);
+				hsdev, hsdev->usage, address, report_id,
+				SENSOR_HUB_SYNC, min < 0);
 			hid_sensor_power_state(&prox_state->common_attributes,
 						false);
 		} else {
@@ -191,10 +190,16 @@ static int prox_capture_sample(struct hid_sensor_hub=
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
+			return 0;
+		case 4:
+			prox_state->human_presence =3D *(u32 *)raw_data;
+			return 0;
+		default:
+			break;
+		}
 		break;
 	}

@@ -244,7 +249,7 @@ static int hid_prox_probe(struct platform_device *pdev=
)
 	prox_state->common_attributes.hsdev =3D hsdev;
 	prox_state->common_attributes.pdev =3D pdev;

-	ret =3D hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_PROX,
+	ret =3D hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
 					&prox_state->common_attributes,
 					prox_sensitivity_addresses,
 					ARRAY_SIZE(prox_sensitivity_addresses));
@@ -262,7 +267,7 @@ static int hid_prox_probe(struct platform_device *pdev=
)

 	ret =3D prox_parse_report(pdev, hsdev,
 				(struct iio_chan_spec *)indio_dev->channels,
-				HID_USAGE_SENSOR_PROX, prox_state);
+				hsdev->usage, prox_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
@@ -291,8 +296,8 @@ static int hid_prox_probe(struct platform_device *pdev=
)
 	prox_state->callbacks.send_event =3D prox_proc_event;
 	prox_state->callbacks.capture_sample =3D prox_capture_sample;
 	prox_state->callbacks.pdev =3D pdev;
-	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PROX,
-					&prox_state->callbacks);
+	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage,
+					   &prox_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
 		goto error_iio_unreg;
@@ -314,7 +319,7 @@ static int hid_prox_remove(struct platform_device *pde=
v)
 	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
 	struct prox_state *prox_state =3D iio_priv(indio_dev);

-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
+	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);

@@ -326,6 +331,10 @@ static const struct platform_device_id hid_prox_ids[]=
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

