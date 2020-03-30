Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7403C197F88
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgC3PYr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 11:24:47 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:50141 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728666AbgC3PYq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 11:24:46 -0400
X-Greylist: delayed 1518 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 11:24:46 EDT
Received: from DAG2EX1.mxp2.local (unknown [10.109.156.148])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 989C4321A41D;
        Mon, 30 Mar 2020 16:59:26 +0200 (CEST)
Received: from gaetanandre.eu (37.59.142.99) by DAG2EX1.mxp2.local
 (172.16.2.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 30 Mar
 2020 16:59:26 +0200
From:   =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>
Subject: [PATCH] iio: st_sensors: make scale channels also shared by type
Date:   Mon, 30 Mar 2020 16:59:20 +0200
Message-ID: <20200330145920.441528-1-rvlander@gaetanandre.eu>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG6EX2.mxp2.local (172.16.2.12) To DAG2EX1.mxp2.local
 (172.16.2.3)
X-Ovh-Tracer-GUID: 11d227e3-49fb-45d4-b500-33cc3a15d870
X-Ovh-Tracer-Id: 670473397238907104
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofggtgfgihesthekredtredtjeenucfhrhhomhepifgrtohtrghnucetnhgurhoruceorhhvlhgrnhguvghrsehgrggvthgrnhgrnhgurhgvrdgvuheqnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopefftefivdfgigdurdhmgihpvddrlhhotggrlhdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhhvlhgrnhguvghrsehgrggvthgrnhgrnhgurhgvrdgvuhdprhgtphhtthhopehrvhhlrghnuggvrhesghgrvghtrghnrghnughrvgdrvghu
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
 include/linux/iio/common/st_sensors.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 33e939977444..f31e309f0fd1 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -52,6 +52,7 @@
 	.type = device_type, \
 	.modified = mod, \
 	.info_mask_separate = mask, \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.scan_index = index, \
 	.channel2 = ch2, \

base-commit: b723e9431b77976b83efb90178dfcada3405321c
-- 
2.26.0

