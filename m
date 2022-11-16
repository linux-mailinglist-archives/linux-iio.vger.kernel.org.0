Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4762CEA2
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 00:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiKPXUX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 18:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKPXUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 18:20:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6637A623A4
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 15:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668640804; bh=VZfj5fnV6z24fVIt9+oeclfarFXSxeQH3rhRQxKiCWk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=flxI9A+/xFaBfsIW8Trr7MSiLUK2Cry1Q9vTNxcq318tn8P8/PfNDuH/kagSWcOUo
         HjC/hAKHVJRuQra5flgBlfrL0rm5CCDKZuTeIHZG++XExcevSzi2lJ17OyQBj0Bw5j
         4iwBoqhjjDuN8nkeEENpNUWO3zw9rUtnbwJTO3tMk+HZNx6nXHR8Py/rxCL2fofIfs
         /DuRs6RmpJQY4d8WKIrP3ao+K/De2xRPKsdm6KReOFRu6lbEs4ktinpQFccFjUNydB
         5bQRIel+7vXWmN939ig77eRcgzwJFCfuOrERCI1LOyNfSNZbEz2BPSk4uQKczMnG0k
         9GCLCMpxQH5qA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.44.107]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MUosN-1oUfdV1ZWT-00QlVl; Thu, 17 Nov 2022 00:20:04 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH 1/3] HID: hid-sensor-custom: More custom iio sensors
Date:   Thu, 17 Nov 2022 00:19:45 +0100
Message-Id: <20221116231947.18031-1-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <b1980cb048a77428971ddfc3bde238b66c540a1f.camel@gmx.net>
References: <b1980cb048a77428971ddfc3bde238b66c540a1f.camel@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4R/iIz94O3mFHMRV+3ofHaYWvKebcSdr4iY+9ky7KOaS1a5O0lI
 flfBmMrGffYAAMYWmyhMZPKIQeHgZKVkujfZab/6LX2ppF8hLniQhMbRDrQ7OvlezGPo1iJ
 yx2JGIYMOZd10h3R/TiHBgqhe4m+xM+Z+bgLnQd0UmX0TixrDNjE14mU+3wxaii3aoSSJyX
 0MTh9IoXCVOSWYGYxt5Gw==
UI-OutboundReport: notjunk:1;M01:P0:eG8Z+1/02lA=;koYEnMh3G0CFdI4wolelkhQzJdw
 8yJvrdWTxYsdOo+wMbKcI/ep62H5yAlxrggu4AGoBnbrIw+4bsflG6y9pEaNc440SPrrsRP55
 50E2OTbhAJO7yS1+uy82reqj8Sknv0KuZK/iS3W0fNsozh9pPo55jxuRueW+dMMDRSaUnpvBP
 c4cmgEbQuQSN5SVag/W/EXW0QNfD5yfGPmkxtFQteQfRtExCKYTGCL69mwepGoLbrtKUqxfG7
 bxMpJAcISPvZ+q1iRgs1Auh8hvF2RpydzPYJPC2vI1v9uuaAyK/0MK41mWSFbE9+hDspqoWtj
 w8JeiccT05Ow74MAJ1vd2ya4jXlNIqIDdA+sI7EGTPKKiaUZdeU3Y6MmzOTO8rdFb4lHRs2Jg
 jtTVw38eIp1UkccMFd1SdhuefxlmtZn4quAADbfTqPz5BDCths9TcQH2LhA99oC/V5YBnyWQP
 w0JGIcsp8JSYCve6bdtfMrb9MKrom69SFgCJejEx+B6h0VKBSOEVPJALt7ckP5MqzwIPx/OBN
 2FRA5bTYwsHWDaL6bzKIHQRNZpjEjQ+oohp1o0w15TRDjzvYcjON59WMG9/T2+WENBUiJBMNM
 SxugiPPPlV8t0noq/eM52bfj6OFiXivE6qTueKaB8n6zO3FMur00ERTlK69IAbDMUft05UXKA
 08j5m9SL0Bp81n2RNMC7MKojaIvK3L3ZC767rBFo06070WKTpLZMIfr+sCnp7mgksClaxUxi/
 xaBknISQ95Iu1M+GCouWxRUrcj4CxsCEojjHBX9QDt2aFU9/lGqvzz4WmJu5yHG1xh7H6qvu/
 sNoRupjatyXMIye+4sv9C4VlxCpjCONUMpXs+YCE6Gu3tnovgvqR2czxdR14315TPAvW0wjFu
 XQ+5K+SSyiJhS/Fot0RZyv6/5Wi1tJd+bnwqvWS9Olyspbc+uz7o73ToToFOaTHo5JOTtfE7C
 +ngK50ZIxrpkZb/f70/q8foAlFA=
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

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
 drivers/hid/hid-sensor-custom.c | 225 +++++++++++++++++++++++---------
 include/linux/hid-sensor-ids.h  |   1 +
 2 files changed, 161 insertions(+), 65 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cust=
om.c
index 32c2306e240d..cb21f9178830 100644
=2D-- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -5,6 +5,7 @@
  */

 #include <linux/ctype.h>
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -750,114 +751,208 @@ static void hid_sensor_custom_dev_if_remove(struct=
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

-	for (i =3D 0; i < ARRAY_SIZE(known_sensor_luid); i++) {
-		if (!strncmp(usage_str, known_sensor_luid[i],
-			     strlen(known_sensor_luid[i])))
-			return i;
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
+
+static int hid_sensor_custom_prop_match_str(const u16 *prop, const char *=
match,
+					    size_t max_count)
+{
+	while (max_count-- && *prop && *match) {
+		if (*prop & 0xFF00 ||
+		    *match !=3D (char) *prop)
+			return 0;
+		prop++;
+		match++;
 	}

-	return -ENODEV;
+	return 1;
 }

-static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hs=
dev)
+static int hid_sensor_custom_get_prop(struct hid_sensor_hub_device *hsdev=
,
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
+	/* get property info */
 	ret =3D sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, hsdev->usage,
-			HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
+						  HID_FEATURE_REPORT,
+						  hsdev->usage,
+						  prop_usage_id,
+						  &prop_attr);
+	/* property does not exist */
 	if (ret < 0)
-		return ret;
+		return -ENODATA;

 	report_size =3D
-		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
-				       sensor_manufacturer.index, sizeof(w_buf),
-				       w_buf);
+		sensor_hub_get_feature(hsdev, prop_attr.report_id,
+				       prop_attr.index, prop_size,
+				       prop);
 	if (report_size <=3D 0) {
 		hid_err(hsdev->hdev,
-			"Failed to get sensor manufacturer info %d\n",
+			"Failed to get sensor property %08x %d\n",
+			prop_usage_id,
 			report_size);
 		return -ENODEV;
 	}

-	/* convert from wide char to char */
-	for (i =3D 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
-		buf[i] =3D (char)w_buf[i];
+	return 0;
+}

-	/* ensure it's ISH sensor */
-	if (strncmp(buf, "INTEL", strlen("INTEL")))
-		return -ENODEV;
+static int
+hid_sensor_custom_do_match(struct hid_sensor_hub_device *hsdev,
+			   const struct hid_sensor_custom_match *match,
+			   const struct hid_sensor_custom_properties *prop)
+{
+	struct dmi_system_id dmi[] =3D { match->dmi, { 0 } };

-	memset(w_buf, 0, sizeof(w_buf));
-	memset(buf, 0, sizeof(buf));
+	/*
+	 * Match the LUID property.
+	 */
+	if (!hid_sensor_custom_prop_match_str(prop->serial_num, "LUID:", 5) ||
+	    !hid_sensor_custom_prop_match_str(prop->serial_num + 5,
+					      match->luid,
+					      HID_CUSTOM_MAX_FEATURE_BYTES - 5))
+		return 0;

-	/* get real usage id */
-	ret =3D sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, hsdev->usage,
-			HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
+	/*
+	 * Match the model property. (optional)
+	 */
+	if (match->model &&
+	    !hid_sensor_custom_prop_match_str(prop->model,
+					      match->model,
+					      HID_CUSTOM_MAX_FEATURE_BYTES))
+		return 0;
+
+	/*
+	 * Match the manufacturer property. (optional)
+	 */
+	if (match->manufacturer &&
+	    !hid_sensor_custom_prop_match_str(prop->manufacturer,
+					      match->manufacturer,
+					      HID_CUSTOM_MAX_FEATURE_BYTES))
+		return 0;
+
+	/*
+	 * Match DMI. (optional)
+	 */
+	if (match->check_dmi && !dmi_check_system(dmi))
+		return 0;
+
+	return 1;
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
+	if (ret < 0 && ret !=3D -ENODATA)
+		return ret;

-	/* convert from wide char to char */
-	for (i =3D 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
-		buf[i] =3D (char)w_buf[i];
+	ret =3D hid_sensor_custom_get_prop(hsdev,
+					 HID_USAGE_SENSOR_PROP_MANUFACTURER,
+					 HID_CUSTOM_MAX_FEATURE_BYTES,
+					 prop->manufacturer);
+	if (ret < 0 && ret !=3D -ENODATA)
+		return ret;

-	if (strlen(buf) !=3D strlen(known_sensor_luid[0]) + 5) {
-		hid_err(hsdev->hdev,
-			"%s luid length not match %zu !=3D (%zu + 5)\n", __func__,
-			strlen(buf), strlen(known_sensor_luid[0]));
+	return 0;
+}
+
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
 		return -ENODEV;
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
+	return -ENODEV;
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

 	/* copy real usage id */
-	memcpy(real_usage, known_sensor_luid[index], 4);
+	memcpy(real_usage, match->luid, 4);
+	real_usage[4] =3D '\0';

-	/* usage id are all lowcase */
+	/* usage ids are all lowcase */
 	for (c =3D real_usage; *c !=3D '\0'; c++)
 		*c =3D tolower(*c);

-	/* HID-SENSOR-INT-REAL_USAGE_ID */
-	dev_name =3D kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
+	/* HID-SENSOR-tag-real_usage */
+	dev_name =3D kasprintf(GFP_KERNEL, "HID-SENSOR-%s-%s",
+			     match->tag, real_usage);
 	if (!dev_name)
 		return ERR_PTR(-ENOMEM);

@@ -873,7 +968,7 @@ static int hid_sensor_custom_probe(struct platform_dev=
ice *pdev)
 	struct hid_sensor_custom *sensor_inst;
 	struct hid_sensor_hub_device *hsdev =3D pdev->dev.platform_data;
 	int ret;
-	int index;
+	const struct hid_sensor_custom_match *match =3D NULL;

 	sensor_inst =3D devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
 				   GFP_KERNEL);
@@ -888,10 +983,10 @@ static int hid_sensor_custom_probe(struct platform_d=
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

