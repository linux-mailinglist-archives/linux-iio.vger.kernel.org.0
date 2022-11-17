Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10B62E9CA
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 00:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKQXny (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 18:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbiKQXnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 18:43:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD3BA446
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 15:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668728607; bh=SBPi6rC4HYka5zDnNBrOrmm3M7oLCjGw6JXOetO9axc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Avbe71iwLkN14ehSSxASzbTXKyntKhTaQPLY8WK6CC92A0TyeezMbJSNbcDwvQGu0
         5iaSNcchaq0julE9JaMixa/kqcCNEpl1v700CCdwKSuniEwkOd7YFGuBRO6juZHXEK
         LaKvQHcMD/ZsvWj9kMjZuO+Dhe3gM7CW6lZimAzjBYL62GyJ6zfEChjecsoSEUPdFY
         3mS1JWe5aaZlli9+IYKpbJYGAaZ8b8vkYVklDwKaSSbm+FWZRIS/9Pw1nVBP/F88rJ
         Ap2fM5yVAwA0tL6PDjqhfyxEYskWu2vwoRH6Neb9M5it29Dof2oDf+aDxUnC1d5CBX
         q7WJegIYVPl7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.31]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M7sDg-1oqsaT2kh0-0055Ny; Fri, 18 Nov 2022 00:43:27 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v2 4/4] IIO: hid-sensor-prox: Use generic usage
Date:   Fri, 18 Nov 2022 00:43:02 +0100
Message-Id: <20221117234302.3875-4-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117234302.3875-1-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
 <20221117234302.3875-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JVm1vb18Tzaza31T2V6SyxPMTsNS+ggPW3YQjv2JuPbB1oKiu2h
 GwGr/vub19bgJO7v7NfXXZtjotuBSXndcJEBJilXX3+GI62TLqbKs3Ow6p+LZ4uKRhHqPcu
 UmIebIargp3MHaww6lkZUU1enqRihEVD3u5LJNEyLjWldh6cBdSGiBCtKHNvZ6HcKMH4DsE
 rAIWMolv0KauG0BpWxwzQ==
UI-OutboundReport: notjunk:1;M01:P0:ebtB5lg9GBA=;Lym7N47TWXi0xaTg9tioz+ndGiO
 OdMuw0JS4F+Nsmqz5d91/hyB6dQ8M3ywB4FqL0mDUeuSYqvpaLpbBeqzZvfO1uR9w+ZuxIz1S
 XNMRoY1L074aLsFizDldItHMyKaySoDTQ1nwRYZBi9L2DfE4sb4q1e7ZUGy+QkrKz4OKsU6im
 rEur22AnXNhaQKz8pYdFyfUCj+J6BixTA+trwRb4H7209xITu27zC/uRxynXKixSgAiXBBnf5
 WaCFLFanqoj1c/HCVSsjWxnbkN1iyRMGSUCCDiM+lx2tJwwSQM04SHJ6RJPX4S2P5KBbInJhH
 /+s3x8en1kZn2xvJZ38/kEkcf4jIcxgTbHk5meCd2x44uNmF8Ca4x30HPCmvOXhjyat8dovh7
 R2QKdumqvcuZkIkkN908FayzsAo03CH9qPXtc0/Ole0GtXIfgPng2oz3h1pmAEz9VzuRfDfri
 zPYhBoXpDPJuVEF65PgKIcgMHUY9Il6YHh8J+LOlOktKL21fF5GOtENPrNWHgxsDnrzJ7gxd7
 pVuYSISUz3m+uNmoWtIsbJlIFGQ0nqkTAvjGYztdFDoPToQ6XsojAjmDtsixTG92yvanT0NrL
 9yLnVPwmIk8IPoJ4wTp0cSduxjMSvfXg0ASNI93Iia3P4t9UUUUbkwIphN7Tw+bLem9c9oEBT
 ZPsx6Z3TnTrZ3fj0iX5Cyr5BjFIas8kYLoBu4/m2GpbDkhYZjs6QOXwN2eUFe6hX2l05Pnt6h
 NhiBZW3paAJzdooAdUxbntvlSClDNlsZ5RCEqu+uwJLsmvhN9kOs9TuOmiToMEVQeHRWFk71B
 tDPMy32hEWFgj+b/UPgViR4DdKEA2e/Cteud8xhQx8Z2sgX8NoWH3uEXEsLXWgOJDNEZNdiJy
 YlzdFOXT+pTCzH1LwA3kA7O9xfsSFN0BqbAvnewEzrPJFlJ8hbk85d6pDKolo/FIQw8cxrRey
 g9Xj69knJhlfmIiPvM0OyP6Za9A=
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

Add the Lenovo Intelligent Sensing Solution (LISS) human presence sensor
to the platform device ids.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
Lines are shorter and the switch statement for raw_len is cleaner.

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

