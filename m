Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD41B5B51
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDWMYU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Apr 2020 08:24:20 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:46737 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726117AbgDWMYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Apr 2020 08:24:20 -0400
Received: from DAG2EX1.mxp2.local (unknown [10.108.4.188])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 83ACA3147BA3;
        Thu, 23 Apr 2020 14:24:17 +0200 (CEST)
Received: from gaetanandre.eu (37.59.142.96) by DAG2EX1.mxp2.local
 (172.16.2.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 14:24:17 +0200
From:   =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>
Subject: [PATCH v2] iio: st_sensors: make scale channels also shared by type
Date:   Thu, 23 Apr 2020 14:17:15 +0200
Message-ID: <20200423121714.607262-1-rvlander@gaetanandre.eu>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG9EX2.mxp2.local (172.16.2.18) To DAG2EX1.mxp2.local
 (172.16.2.3)
X-Ovh-Tracer-GUID: a6aac81f-cdac-45c6-b9b1-9e9122fb5ddb
X-Ovh-Tracer-Id: 9867668262799687904
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffogggtgfhisehtkeertdertdejnecuhfhrohhmpefirgotthgrnhcutehnughrrocuoehrvhhlrghnuggvrhesghgrvghtrghnrghnughrvgdrvghuqeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepffetifdvgfgiuddrmhigphdvrdhlohgtrghlpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrvhhlrghnuggvrhesghgrvghtrghnrghnughrvgdrvghupdhrtghpthhtoheprhhvlhgrnhguvghrsehgrggvthgrnhgrnhgurhgvrdgvuh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Scale channels are available by axis. For example for accelerometers,
in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are available.

However, they should be shared by type as documented in
Documentation/ABI/testing/sysfs-bus-iio.

For each sensor (acceleros, gyros and magnetos) only one value is specified
for all the axes.

Existing, by axis, entries are preserved in order to to leave the old ABI
untouched.

Signed-off-by: Gaëtan André <rvlander@gaetanandre.eu>
---
v1->v2: add comment explaining why we are doing both.

 include/linux/iio/common/st_sensors.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 33e939977444..42663fbab085 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -46,12 +46,19 @@
 #define ST_SENSORS_MAX_NAME			17
 #define ST_SENSORS_MAX_4WAI			8
 
+/*
+ * Scale channels are configured both by type and by axis.
+ * - By axis to keep the previous ABI and flexibility.
+ * - By type because it is how some userland
+ * applications are expecting them (ex: iio-sensor-proxy).
+ */
 #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
 					ch2, s, endian, rbits, sbits, addr) \
 { \
 	.type = device_type, \
 	.modified = mod, \
 	.info_mask_separate = mask, \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.scan_index = index, \
 	.channel2 = ch2, \

base-commit: 2de8c02349f02d014e51b43f306d28fc7a23ea6e
-- 
2.26.1

