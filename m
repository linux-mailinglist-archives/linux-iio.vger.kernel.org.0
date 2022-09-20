Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835565BE478
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiITL3q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiITL3n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 07:29:43 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9EB488
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 04:29:37 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K854bc006301;
        Tue, 20 Sep 2022 07:28:54 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jn835muw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 07:28:53 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 28KBSqoi062692
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 07:28:52 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Sep 2022 07:28:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Sep 2022 07:28:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Sep 2022 07:28:51 -0400
Received: from nsa.ad.analog.com ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28KBR4Ub021723;
        Tue, 20 Sep 2022 07:28:42 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>
CC:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: [PATCH 15/15] iio: core: move 'mlock' to 'struct iio_dev_opaque'
Date:   Tue, 20 Sep 2022 13:28:21 +0200
Message-ID: <20220920112821.975359-16-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920112821.975359-1-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: PI2tSrG_HxtC8yaE5GfGmSjwPc5PQt0T
X-Proofpoint-GUID: PI2tSrG_HxtC8yaE5GfGmSjwPc5PQt0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200068
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that there are no more users accessing 'mlock' directly, we can move
it to the iio_dev private structure. Hence, it's now explicit that new
driver's should not directly this lock.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/TODO                   |  3 ---
 drivers/iio/industrialio-buffer.c  | 29 +++++++++++++++++------------
 drivers/iio/industrialio-core.c    | 18 ++++++++++--------
 drivers/iio/industrialio-event.c   |  4 ++--
 drivers/iio/industrialio-trigger.c | 12 ++++++------
 include/linux/iio/iio-opaque.h     |  2 ++
 include/linux/iio/iio.h            |  3 ---
 7 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/TODO b/drivers/iio/TODO
index 7d7326b7085a..2ace27d1ac62 100644
--- a/drivers/iio/TODO
+++ b/drivers/iio/TODO
@@ -7,9 +7,6 @@ tree
   - ABI Documentation
   - Audit driviers/iio/staging/Documentation
 
-- Replace iio_dev->mlock by either a local lock or use
-iio_claim_direct.(Requires analysis of the purpose of the lock.)
-
 - Converting drivers from device tree centric to more generic
 property handlers.
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 228598b82a2f..9cd7db549fcb 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -507,13 +507,14 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	int ret;
 	bool state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_buffer *buffer = this_attr->buffer;
 
 	ret = kstrtobool(buf, &state);
 	if (ret < 0)
 		return ret;
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&iio_dev_opaque->mlock);
 	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 		goto error_ret;
@@ -532,7 +533,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	}
 
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return ret < 0 ? ret : len;
 
@@ -554,6 +555,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	bool state;
 
@@ -561,14 +563,14 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&iio_dev_opaque->mlock);
 	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
 	buffer->scan_timestamp = state;
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return ret ? ret : len;
 }
@@ -642,6 +644,7 @@ static ssize_t length_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	unsigned int val;
 	int ret;
@@ -653,7 +656,7 @@ static ssize_t length_store(struct device *dev, struct device_attribute *attr,
 	if (val == buffer->length)
 		return len;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&iio_dev_opaque->mlock);
 	if (iio_buffer_is_active(buffer)) {
 		ret = -EBUSY;
 	} else {
@@ -665,7 +668,7 @@ static ssize_t length_store(struct device *dev, struct device_attribute *attr,
 	if (buffer->length && buffer->length < buffer->watermark)
 		buffer->watermark = buffer->length;
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return ret ? ret : len;
 }
@@ -1256,7 +1259,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&iio_dev_opaque->mlock);
 
 	if (insert_buffer && iio_buffer_is_active(insert_buffer))
 		insert_buffer = NULL;
@@ -1277,7 +1280,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 	ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
 
 out_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 	mutex_unlock(&iio_dev_opaque->info_exist_lock);
 
 	return ret;
@@ -1296,6 +1299,7 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	int ret;
 	bool requested_state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	bool inlist;
 
@@ -1303,7 +1307,7 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&iio_dev_opaque->mlock);
 
 	/* Find out if it is in the list */
 	inlist = iio_buffer_is_active(buffer);
@@ -1317,7 +1321,7 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 		ret = __iio_update_buffers(indio_dev, NULL, buffer);
 
 done:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 	return (ret < 0) ? ret : len;
 }
 
@@ -1334,6 +1338,7 @@ static ssize_t watermark_store(struct device *dev,
 			       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	unsigned int val;
 	int ret;
@@ -1344,7 +1349,7 @@ static ssize_t watermark_store(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&iio_dev_opaque->mlock);
 
 	if (val > buffer->length) {
 		ret = -EINVAL;
@@ -1358,7 +1363,7 @@ static ssize_t watermark_store(struct device *dev,
 
 	buffer->watermark = val;
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return ret ? ret : len;
 }
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 151ff3993354..fca7dcc4be29 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -285,16 +285,16 @@ int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	const struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
 
-	ret = mutex_lock_interruptible(&indio_dev->mlock);
+	ret = mutex_lock_interruptible(&iio_dev_opaque->mlock);
 	if (ret)
 		return ret;
 	if ((ev_int && iio_event_enabled(ev_int)) ||
 	    iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&iio_dev_opaque->mlock);
 		return -EBUSY;
 	}
 	iio_dev_opaque->clock_id = clock_id;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return 0;
 }
@@ -1674,7 +1674,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	indio_dev->dev.type = &iio_device_type;
 	indio_dev->dev.bus = &iio_bus_type;
 	device_initialize(&indio_dev->dev);
-	mutex_init(&indio_dev->mlock);
+	mutex_init(&iio_dev_opaque->mlock);
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
@@ -1696,7 +1696,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
-	lockdep_set_class(&indio_dev->mlock, &iio_dev_opaque->mlock_key);
+	lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 
 	return indio_dev;
 }
@@ -2058,10 +2058,12 @@ EXPORT_SYMBOL_GPL(__devm_iio_device_register);
  */
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev)
 {
-	mutex_lock(&indio_dev->mlock);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	mutex_lock(&iio_dev_opaque->mlock);
 
 	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&iio_dev_opaque->mlock);
 		return -EBUSY;
 	}
 	return 0;
@@ -2079,7 +2081,7 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
  */
 void iio_device_release_direct_mode(struct iio_dev *indio_dev)
 {
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
 }
 EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
 
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 3d78da2531a9..1a26393a7c0c 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -198,7 +198,7 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 	if (ev_int == NULL)
 		return -ENODEV;
 
-	fd = mutex_lock_interruptible(&indio_dev->mlock);
+	fd = mutex_lock_interruptible(&iio_dev_opaque->mlock);
 	if (fd)
 		return fd;
 
@@ -219,7 +219,7 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 	}
 
 unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 	return fd;
 }
 
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 6885a186fe27..a2f3cc2f65ef 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -120,12 +120,12 @@ int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *tri
 		return -EINVAL;
 
 	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&iio_dev_opaque->mlock);
 	WARN_ON(iio_dev_opaque->trig_readonly);
 
 	indio_dev->trig = iio_trigger_get(trig);
 	iio_dev_opaque->trig_readonly = true;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return 0;
 }
@@ -438,16 +438,16 @@ static ssize_t current_trigger_store(struct device *dev,
 	struct iio_trigger *trig;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&iio_dev_opaque->mlock);
 	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED) {
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&iio_dev_opaque->mlock);
 		return -EBUSY;
 	}
 	if (iio_dev_opaque->trig_readonly) {
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&iio_dev_opaque->mlock);
 		return -EPERM;
 	}
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&iio_dev_opaque->mlock);
 
 	trig = iio_trigger_acquire_by_name(buf);
 	if (oldtrig == trig) {
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index d1f8b30a7c8b..5aec3945555b 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -11,6 +11,7 @@
  *				checked by device drivers but should be considered
  *				read-only as this is a core internal bit
  * @driver_module:		used to make it harder to undercut users
+ * @mlock:			lock used to prevent simultaneous device state changes
  * @mlock_key:			lockdep class for iio_dev lock
  * @info_exist_lock:		lock to prevent use during removal
  * @trig_readonly:		mark the current trigger immutable
@@ -43,6 +44,7 @@ struct iio_dev_opaque {
 	int				currentmode;
 	int				id;
 	struct module			*driver_module;
+	struct mutex			mlock;
 	struct lock_class_key		mlock_key;
 	struct mutex			info_exist_lock;
 	bool				trig_readonly;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f0ec8a5e5a7a..b27ae8c7b59e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -548,8 +548,6 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @buffer:		[DRIVER] any buffer present
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
- * @mlock:		[INTERN] lock used to prevent simultaneous device state
- *			changes
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
  * @masklength:		[INTERN] the length of the mask established from
  *			channels
@@ -574,7 +572,6 @@ struct iio_dev {
 
 	struct iio_buffer		*buffer;
 	int				scan_bytes;
-	struct mutex			mlock;
 
 	const unsigned long		*available_scan_masks;
 	unsigned			masklength;
-- 
2.37.3

