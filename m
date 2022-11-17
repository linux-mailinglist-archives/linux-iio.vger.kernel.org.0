Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DF62E9CE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 00:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiKQXoQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 18:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbiKQXnn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 18:43:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B65CBC9E
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 15:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668728607; bh=ai5UiNsV7FiIEdXOfAcFEua4IHE3CLfMJ3MgziZRV6Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CM1wXFSo6WCfwZV67/cCYE7PDNs6IUAUFy7QY6Vni97DSrwCQWIM2/2QRUscAvEZl
         janqupW87/RCEGV2ALgUx0R5tPNuwKY36tGTb/x+WkTYz1Le/e/zbW5/OyoeVqtF3q
         Ezkcv1WyNwW/3rxJ3rjkYUqGqK+VGg4teNyjcYpXxqM4kRh4ZhDuAq/ng94NtN2+JA
         a2E+2+Zt34/+A6Fe+l6ZSMYFAhCkJyGlmJAsmUGR3TGDjDFFu9+ke5+HahX/VLHaYR
         wdP+oxt/O5k1VQWRB4Dd82F2b8cH2tIyI/px+5kQ/xLgG06AqI0tPj1ri4RTqtf5qB
         5UVQ3bMEFH1Zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.31]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MhlGk-1pQUaU3UoK-00druC; Fri, 18 Nov 2022 00:43:26 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v2 1/4] HID: hid-sensor-custom: Allow more custom iio sensors
Date:   Fri, 18 Nov 2022 00:42:59 +0100
Message-Id: <20221117234302.3875-1-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117150508.00002704@Huawei.com>
References: <20221117150508.00002704@Huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IFPdek38SeVXmEN4QKBCNos3T1mniBtocUfXf6RrbRxKF/LtSit
 M4QeL9LlhNm0b4+3/rQdQHcQvuiAZmtfLQhoAhiunUAXLr/KuOm2Lil7Xqy8UQCom9LLMm6
 QHTqcqGq5qC6EeOx21DA07mec/au0cNZiV2mWo23SVHyFCBov//KvcGIwsBdgbRK0X3+JXC
 U8ugdKulo1iUiu1XUUwuA==
UI-OutboundReport: notjunk:1;M01:P0:WcJzogOkqrc=;zVBbIlOhc5RA7sUAWrZ5t6s2RTj
 QTjlNT3KzEaMJrWDifELJ+gR3No19/Z3tA/r9X5xT1035FjP2Bmlpo8cegwRVkmC127PjvzOS
 yuXi64NZfvOdHQNJySfT4TdDczfKsNvjTTMECksuZqKZuf4Ielk4jzCbkWenzZmuCRLwIOZp4
 ccaiHax747AI3RRjQmD2ZJAFsRDga+CCTECsSkpu6ogzyx61gPyFUlYo3+etS5EKJYUi6Hiq1
 2l9x6NOYP1i7slsLh8NPbRG+WA+bAovuIWBPfX9woEAcsQtPbFmkM63Qqpj1yVXrSvu7ycjpr
 G7PVpXU3UPd+fXvBSy18rHVuLx/frsmwf5p76Mf9epln0cjVTHwXNeJzADBQsX8Q+un2EYeiu
 PstMImN3svY5R991ry5/bK1qbJwqFY36gotggIjPHs1QI6WkuvJXhufIktZPT0RyylRWht5k3
 5ohNcLyV7uoyAbU3InaAIOEqSHsDT8il+acgdyuGh0JZTnmlsCwSvC/2rEBx0XoEzc98KvXxl
 cM5AwhqKCDH6Gw/H8zxFpFo+fupHjoNsXAPDYxQJ7wgrutESruBPyrkaKP1HsjyVOCO1eNtyj
 328Ar9Jhs/FG/C4APFehVBID/FL56psLbMfAFh6SMFUUPOQy10+hO4jwfnz6T8mShWmeiXQ1B
 3Di2yzzTU9YUqea2MBFp0VdkH2MZP7zcIfETa5iboQdFq3L2H6ya1/K5zZednQy4fosiSbFmI
 6wXUb3dlfjOJE5MWsq2XIOdo2c3/OttA1Q8piPQdKbYDttwYC43vYl/VS/5msP758j80Sr8pj
 dBcN9/wIVXORh9pZWRhHypab53/JvktAFP6IUAFI7GyVh8USBrptZyxq8c11YpWLAK1h+w28t
 7SRq5m1jfcVj4nGbEXe8TwUI/X60+oX0SfeqUM6dKGLMd2NR/Nx6CI78gKBTyTzcFP8ZH4VXw
 OPVcvj7gLO+vkV5oMZuoX1Y4m4s=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The known LUID table for established/known custom HID sensors was
limited to sensors with "INTEL" as manufacturer. But some vendors such
as Lenovo also include fairly standard iio sensors (e.g. ambient light)
in their custom sensors.

Expand the known custom sensors table by a tag used for the platform
device name and match sensors based on the LUID as well as optionally
on model and manufacturer properties.
Introduce sensors from Lenovo's "Intelligent Sensing Solution" on the
Lenovo Yoga 9 14IAP7 as an example.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
Hello,

here's a short summary of changes compared to v1:

 Added an additional commit which adds the LISS entries to the known
 custom sensors.

 Removed all unnecessary linebreaks from modified function calls and staye=
d
 below the 80 columns.

 Revisited the matching logic and removed the explicit error codes
 in favor of bools and forwarding the inner error.

 I noticed that the strange ENODATA return code was already redundant with
 the **known out parameter. So I removed it.

Regards,
Philipp Jungkamp

 drivers/hid/hid-sensor-custom.c | 211 +++++++++++++++++++++-----------
 include/linux/hid-sensor-ids.h  |   1 +
 2 files changed, 142 insertions(+), 70 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cust=
om.c
index 32c2306e240d..89e56913c92e 100644
=2D-- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -5,6 +5,7 @@
  */

 #include <linux/ctype.h>
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -750,114 +751,184 @@ static void hid_sensor_custom_dev_if_remove(struct=
 hid_sensor_custom

 }

-/* luid defined in FW (e.g. ISH).  Maybe used to identify sensor. */
-static const char *const known_sensor_luid[] =3D { "020B000000000000" };
+/*
+ * Match a known custom sensor.
+ * tag and luid is mandatory.
+ */
+struct hid_sensor_custom_match {
+	const char *tag;
+	const char *luid;
+	const char *model;
+	const char *manufacturer;
+	bool check_dmi;
+	struct dmi_system_id dmi;
+};

-static int get_luid_table_index(unsigned char *usage_str)
-{
-	int i;
+/*
+ * Custom sensor properties used for matching.
+ */
+struct hid_sensor_custom_properties {
+	u16 serial_num[HID_CUSTOM_MAX_FEATURE_BYTES];
+	u16 model[HID_CUSTOM_MAX_FEATURE_BYTES];
+	u16 manufacturer[HID_CUSTOM_MAX_FEATURE_BYTES];
+};
+
+static const struct hid_sensor_custom_match hid_sensor_custom_known_table=
[] =3D {
+	/*
+	 * Intel Integrated Sensor Hub (ISH)
+	 */
+	{	/* Intel ISH hinge */
+		.tag =3D "INT",
+		.luid =3D "020B000000000000",
+		.manufacturer =3D "INTEL",
+	},
+	{}
+};

-	for (i =3D 0; i < ARRAY_SIZE(known_sensor_luid); i++) {
-		if (!strncmp(usage_str, known_sensor_luid[i],
-			     strlen(known_sensor_luid[i])))
-			return i;
+static bool hid_sensor_custom_prop_match_str(const u16 *prop, const char =
*match,
+					     size_t count)
+{
+	while (count-- && *prop && *match) {
+		if (*prop & 0xFF00 ||
+		    *match !=3D (char) *prop)
+			return false;
+		prop++;
+		match++;
 	}

-	return -ENODEV;
+	return (count =3D=3D -1) || *prop =3D=3D (u16)*match;
 }

-static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hs=
dev)
+static bool hid_sensor_custom_get_prop(struct hid_sensor_hub_device *hsde=
v,
+				      u32 prop_usage_id, size_t prop_size,
+				      u16 *prop)
 {
-	struct hid_sensor_hub_attribute_info sensor_manufacturer =3D { 0 };
-	struct hid_sensor_hub_attribute_info sensor_luid_info =3D { 0 };
+	struct hid_sensor_hub_attribute_info prop_attr =3D { 0 };
 	int report_size;
 	int ret;
-	static u16 w_buf[HID_CUSTOM_MAX_FEATURE_BYTES];
-	static char buf[HID_CUSTOM_MAX_FEATURE_BYTES];
-	int i;

-	memset(w_buf, 0, sizeof(w_buf));
-	memset(buf, 0, sizeof(buf));
+	memset(prop, 0, prop_size);

-	/* get manufacturer info */
-	ret =3D sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, hsdev->usage,
-			HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
+	ret =3D sensor_hub_input_get_attribute_info(hsdev, HID_FEATURE_REPORT,
+						  hsdev->usage, prop_usage_id,
+						  &prop_attr);
 	if (ret < 0)
-		return ret;
+		return 0;

-	report_size =3D
-		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
-				       sensor_manufacturer.index, sizeof(w_buf),
-				       w_buf);
+	report_size =3D sensor_hub_get_feature(hsdev, prop_attr.report_id,
+					     prop_attr.index, prop_size, prop);
 	if (report_size <=3D 0) {
 		hid_err(hsdev->hdev,
-			"Failed to get sensor manufacturer info %d\n",
+			"Failed to get sensor property %08x %d\n",
+			prop_usage_id,
 			report_size);
-		return -ENODEV;
+		return report_size;
 	}

-	/* convert from wide char to char */
-	for (i =3D 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
-		buf[i] =3D (char)w_buf[i];
+	return 0;
+}
+
+static bool
+hid_sensor_custom_do_match(struct hid_sensor_hub_device *hsdev,
+			   const struct hid_sensor_custom_match *match,
+			   const struct hid_sensor_custom_properties *prop)
+{
+	struct dmi_system_id dmi[] =3D { match->dmi, { 0 } };
+
+	if (!hid_sensor_custom_prop_match_str(prop->serial_num, "LUID:", 5) ||
+	    !hid_sensor_custom_prop_match_str(prop->serial_num + 5, match->luid,
+					      HID_CUSTOM_MAX_FEATURE_BYTES - 5))
+		return false;
+
+	if (match->model &&
+	    !hid_sensor_custom_prop_match_str(prop->model, match->model,
+					      HID_CUSTOM_MAX_FEATURE_BYTES))
+		return false;

-	/* ensure it's ISH sensor */
-	if (strncmp(buf, "INTEL", strlen("INTEL")))
-		return -ENODEV;
+	if (match->manufacturer &&
+	    !hid_sensor_custom_prop_match_str(prop->manufacturer, match->manufac=
turer,
+					      HID_CUSTOM_MAX_FEATURE_BYTES))
+		return false;

-	memset(w_buf, 0, sizeof(w_buf));
-	memset(buf, 0, sizeof(buf));
+	if (match->check_dmi && !dmi_check_system(dmi))
+		return false;

-	/* get real usage id */
-	ret =3D sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, hsdev->usage,
-			HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
+	return true;
+}
+
+static int
+hid_sensor_custom_properties_get(struct hid_sensor_hub_device *hsdev,
+				 struct hid_sensor_custom_properties *prop)
+{
+	int ret;
+
+	ret =3D hid_sensor_custom_get_prop(hsdev,
+					 HID_USAGE_SENSOR_PROP_SERIAL_NUM,
+					 HID_CUSTOM_MAX_FEATURE_BYTES,
+					 prop->serial_num);
 	if (ret < 0)
 		return ret;

-	report_size =3D sensor_hub_get_feature(hsdev, sensor_luid_info.report_id=
,
-					     sensor_luid_info.index, sizeof(w_buf),
-					     w_buf);
-	if (report_size <=3D 0) {
-		hid_err(hsdev->hdev, "Failed to get real usage info %d\n",
-			report_size);
-		return -ENODEV;
-	}
+	ret =3D hid_sensor_custom_get_prop(hsdev,
+					 HID_USAGE_SENSOR_PROP_MODEL,
+					 HID_CUSTOM_MAX_FEATURE_BYTES,
+					 prop->model);
+	if (ret < 0)
+		return ret;

-	/* convert from wide char to char */
-	for (i =3D 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
-		buf[i] =3D (char)w_buf[i];
+	ret =3D hid_sensor_custom_get_prop(hsdev,
+					 HID_USAGE_SENSOR_PROP_MANUFACTURER,
+					 HID_CUSTOM_MAX_FEATURE_BYTES,
+					 prop->manufacturer);
+	if (ret < 0)
+		return ret;

-	if (strlen(buf) !=3D strlen(known_sensor_luid[0]) + 5) {
-		hid_err(hsdev->hdev,
-			"%s luid length not match %zu !=3D (%zu + 5)\n", __func__,
-			strlen(buf), strlen(known_sensor_luid[0]));
-		return -ENODEV;
+	return 0;
+}
+
+static int
+hid_sensor_custom_get_known(struct hid_sensor_hub_device *hsdev,
+			    const struct hid_sensor_custom_match **known)
+{
+	int ret;
+	const struct hid_sensor_custom_match *match =3D
+		hid_sensor_custom_known_table;
+	struct hid_sensor_custom_properties prop;
+
+	ret =3D hid_sensor_custom_properties_get(hsdev, &prop);
+	if (ret < 0)
+		return ret;
+
+	while (match->tag) {
+		if (hid_sensor_custom_do_match(hsdev, match, &prop)) {
+			*known =3D match;
+			return 0;
+		}
+		match++;
 	}

-	/* get table index with luid (not matching 'LUID: ' in luid) */
-	return get_luid_table_index(&buf[5]);
+	*known =3D NULL;
+	return 0;
 }

 static struct platform_device *
 hid_sensor_register_platform_device(struct platform_device *pdev,
 				    struct hid_sensor_hub_device *hsdev,
-				    int index)
+				    const struct hid_sensor_custom_match *match)
 {
-	char real_usage[HID_SENSOR_USAGE_LENGTH] =3D { 0 };
+	char real_usage[HID_SENSOR_USAGE_LENGTH];
 	struct platform_device *custom_pdev;
 	const char *dev_name;
 	char *c;

-	/* copy real usage id */
-	memcpy(real_usage, known_sensor_luid[index], 4);
+	memcpy(real_usage, match->luid, 4);
+	real_usage[4] =3D '\0';

-	/* usage id are all lowcase */
 	for (c =3D real_usage; *c !=3D '\0'; c++)
 		*c =3D tolower(*c);

-	/* HID-SENSOR-INT-REAL_USAGE_ID */
-	dev_name =3D kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
+	dev_name =3D kasprintf(GFP_KERNEL, "HID-SENSOR-%s-%s",
+			     match->tag, real_usage);
 	if (!dev_name)
 		return ERR_PTR(-ENOMEM);

@@ -873,7 +944,7 @@ static int hid_sensor_custom_probe(struct platform_dev=
ice *pdev)
 	struct hid_sensor_custom *sensor_inst;
 	struct hid_sensor_hub_device *hsdev =3D pdev->dev.platform_data;
 	int ret;
-	int index;
+	const struct hid_sensor_custom_match *match =3D NULL;

 	sensor_inst =3D devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
 				   GFP_KERNEL);
@@ -888,10 +959,10 @@ static int hid_sensor_custom_probe(struct platform_d=
evice *pdev)
 	mutex_init(&sensor_inst->mutex);
 	platform_set_drvdata(pdev, sensor_inst);

-	index =3D get_known_custom_sensor_index(hsdev);
-	if (index >=3D 0 && index < ARRAY_SIZE(known_sensor_luid)) {
+	ret =3D hid_sensor_custom_get_known(hsdev, &match);
+	if (!ret && match) {
 		sensor_inst->custom_pdev =3D
-			hid_sensor_register_platform_device(pdev, hsdev, index);
+			hid_sensor_register_platform_device(pdev, hsdev, match);

 		ret =3D PTR_ERR_OR_ZERO(sensor_inst->custom_pdev);
 		if (ret) {
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids=
.h
index ac631159403a..13b1e65fbdcc 100644
=2D-- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -132,6 +132,7 @@
 #define HID_USAGE_SENSOR_PROP_FRIENDLY_NAME			0x200301
 #define HID_USAGE_SENSOR_PROP_SERIAL_NUM			0x200307
 #define HID_USAGE_SENSOR_PROP_MANUFACTURER			0x200305
+#define HID_USAGE_SENSOR_PROP_MODEL				0x200306
 #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
 #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
 #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
=2D-
2.38.1

