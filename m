Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131936381CC
	for <lists+linux-iio@lfdr.de>; Fri, 25 Nov 2022 00:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKXXjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 18:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXXjX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 18:39:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066C114
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2022 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669333151; bh=0jrerNMb+e60kdB7M2+lqvJIkDKfWYsOH8tEzrP3zmE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=irXDHmkUkrwMLYojK0KbXAaqQcnXs7R4Cl4oewjaX4TVBkSgI0H8UQxKYHLkH0uUI
         DOvU39yWbNlE/9t3+zIqKVz7KBuUz+DPO54lBATeyZ4mLanuIqaIM1BZTDgrpqvzrC
         sYcoRDihJpxhBpCWMb+dKBtzS1hpsnM0bKHkT5B+DjXHCvmSXNyUXFgKHK0+0smAYB
         kMNu1VIpaQMKMmofA2hfJrga7yrMJX6Zow4o5KGQssWP5y53Sw5wSEVubas6FfgeoG
         9D2zlqwdY3kU8JLCVqW+v/55RRYwtU5+qZiigdp+FY9/J2MuuGR4I04+pmKgZ0+5Vl
         Ae6sKhuAVza0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.67]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mwwdf-1ooPYq0Zop-00yQsm; Fri, 25 Nov 2022 00:39:11 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v4 1/4] HID: hid-sensor-custom: Allow more custom iio sensors
Date:   Fri, 25 Nov 2022 00:38:38 +0100
Message-Id: <20221124233841.3103-2-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124233841.3103-1-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2vLAn9dx+ltvboXjwMBpxnZcHaoIP0ntkNx9HI4p1jOYtBbHyjk
 9jex34BSEty/BDBWrSzAIFyXOIjtgYE9hbALHbfmveATjvuphsfnvoGfClpVI4Unfelj83C
 3VqxVnpnnkP51v1kInsj7u/uWkcjbdGlnB2QWBgMP34d0mpKTQVJakmUheyC5ZQ/N2TBdBB
 NmP6tZ6+hn1KpRB0xDHmg==
UI-OutboundReport: notjunk:1;M01:P0:zn6TvUUtObA=;XtwIw3EqbgTT5SQ6RJSO9LeNwTl
 pvnuA79eDt9DJNQrIaJaOgNA35DGZgh9dCtbiNbzHo/Ox3ubhyDMCTIO8d7lbAkP38Agaf8nm
 cgnNHSogSAGMJuHdxOWudLdk2hbZcienCoS1L9yXx3wugF2Bv7LG26o8nmyzPnBg5VMsOrXJP
 4B4exyiEUr7m9DUQ3ybX/TjdM8MBHknCduZWAXCSh0ZRc7Bv+s9uaXPyTMUNLtLx/p9FA+FdE
 fCheTLAuoCSuP19eK6LI35GI0RYpV9vmtWT5Z3JRmiH+5xXBSH54xymdIBvI3IIvWr/BLWrKe
 3V7q5dIpK149Hbj39lVCdC+mbU3O2muPPAttaX3/5/WXN+EmV6xKUYWJzN9CHroT+h/ealTRD
 +FftlKpbG7QgeH1Zl1gtR1UgX4+5kCqr/Wce+zP2lrwj+/IMWkBeUezW1iWu8+ZDsunZi0ytV
 a1nmU2pddglp90rXBWHrFiG4p05QXLM+MAFGZyqaoKwbnUweTKADFDG/7y2qmHkcPkjJOhUAc
 2MTPy3ApJFETw6VDCrF/GJGU5H7PW9b8hfloQSGZSkc4fxHTPLQYuqpfECiboOpeVD3FM5D+C
 MxU5ApXdhV9+OqYYoNFu6YYjxOEojmgxBFjerN7H9t36kzaZFLq2gxo/iunqoQCD+jhxnmHnz
 yQ1x2KgqABjRRXUF6DXYFUrqej71D3kI9RHeAqfuwEXJ65ASiBB8HV3TBBSL+GVFVp0MnqEgt
 07dRsFwj7A7ag740fvxhmK/1je3slg1xbUSvibDwtYie3hgf3hnCfUWXua6RFEI53BCcbw/oQ
 7FWI0s9jKD1MBPLOR0ryOQ6xiNtErWerUBuo8K0Dp4R9gWXN6yWNaj5OGOdFH1wqvJ0s8Ik/F
 e8gJ7++nwjaLRv72RPHlJeWt5yy5oFLHyQgaiw344b8RAReUREu5lWGmYPl4lm18safbl0kKA
 P8hV5g==
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
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

v2:
- Remove unnecessary comments.
- Change return type of functions to bool. (introduced an error, fixed in =
v4)
- Swallows return value of a function. (fixed in v4)

v3:
- No change.

v4:
- Fix return value and error codes on property query.
- Document and ignore return values for queries of optionally matched
  properties.
- Don't modify *known in _get_known, return error when not matched.
- Remove comment on newly added sensors from commit message.


 drivers/hid/hid-sensor-custom.c | 210 +++++++++++++++++++++-----------
 include/linux/hid-sensor-ids.h  |   1 +
 2 files changed, 139 insertions(+), 72 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cust=
om.c
index 32c2306e240d..734c6bde68fe 100644
=2D-- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -5,6 +5,7 @@
  */

 #include <linux/ctype.h>
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -750,114 +751,179 @@ static void hid_sensor_custom_dev_if_remove(struct=
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
+static bool hid_sensor_custom_prop_match_str(const u16 *prop, const char =
*match,
+					     size_t count)
+{
+	while (count-- && *prop && *match) {
+		if (*prop !=3D (u16) *match)
+			return false;
+		prop++;
+		match++;
 	}

-	return -ENODEV;
+	return (count =3D=3D -1) || *prop =3D=3D (u16)*match;
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
-	int report_size;
+	struct hid_sensor_hub_attribute_info prop_attr =3D { 0 };
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
 		return ret;

-	report_size =3D
-		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
-				       sensor_manufacturer.index, sizeof(w_buf),
-				       w_buf);
-	if (report_size <=3D 0) {
-		hid_err(hsdev->hdev,
-			"Failed to get sensor manufacturer info %d\n",
-			report_size);
-		return -ENODEV;
+	ret =3D sensor_hub_get_feature(hsdev, prop_attr.report_id,
+				     prop_attr.index, prop_size, prop);
+	if (ret < 0) {
+		hid_err(hsdev->hdev, "Failed to get sensor property %08x %d\n",
+			prop_usage_id, ret);
+		return ret;
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
+
+	if (match->manufacturer &&
+	    !hid_sensor_custom_prop_match_str(prop->manufacturer, match->manufac=
turer,
+					      HID_CUSTOM_MAX_FEATURE_BYTES))
+		return false;

-	/* ensure it's ISH sensor */
-	if (strncmp(buf, "INTEL", strlen("INTEL")))
-		return -ENODEV;
+	if (match->check_dmi && !dmi_check_system(dmi))
+		return false;

-	memset(w_buf, 0, sizeof(w_buf));
-	memset(buf, 0, sizeof(buf));
+	return true;
+}

-	/* get real usage id */
-	ret =3D sensor_hub_input_get_attribute_info(hsdev,
-			HID_FEATURE_REPORT, hsdev->usage,
-			HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
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
+	/*
+	 * Ignore errors on the following model and manufacturer properties.
+	 * Because these are optional, it is not an error if they are missing.
+	 */
+
+	hid_sensor_custom_get_prop(hsdev, HID_USAGE_SENSOR_PROP_MODEL,
+				   HID_CUSTOM_MAX_FEATURE_BYTES,
+				   prop->model);

-	/* convert from wide char to char */
-	for (i =3D 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
-		buf[i] =3D (char)w_buf[i];
+	hid_sensor_custom_get_prop(hsdev, HID_USAGE_SENSOR_PROP_MANUFACTURER,
+				   HID_CUSTOM_MAX_FEATURE_BYTES,
+				   prop->manufacturer);

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
+	return -ENODATA;
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

 	/* usage id are all lowcase */
 	for (c =3D real_usage; *c !=3D '\0'; c++)
 		*c =3D tolower(*c);

-	/* HID-SENSOR-INT-REAL_USAGE_ID */
-	dev_name =3D kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
+	/* HID-SENSOR-TAG-REAL_USAGE_ID */
+	dev_name =3D kasprintf(GFP_KERNEL, "HID-SENSOR-%s-%s",
+			     match->tag, real_usage);
 	if (!dev_name)
 		return ERR_PTR(-ENOMEM);

@@ -873,7 +939,7 @@ static int hid_sensor_custom_probe(struct platform_dev=
ice *pdev)
 	struct hid_sensor_custom *sensor_inst;
 	struct hid_sensor_hub_device *hsdev =3D pdev->dev.platform_data;
 	int ret;
-	int index;
+	const struct hid_sensor_custom_match *match;

 	sensor_inst =3D devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
 				   GFP_KERNEL);
@@ -888,10 +954,10 @@ static int hid_sensor_custom_probe(struct platform_d=
evice *pdev)
 	mutex_init(&sensor_inst->mutex);
 	platform_set_drvdata(pdev, sensor_inst);

-	index =3D get_known_custom_sensor_index(hsdev);
-	if (index >=3D 0 && index < ARRAY_SIZE(known_sensor_luid)) {
+	ret =3D hid_sensor_custom_get_known(hsdev, &match);
+	if (!ret) {
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

