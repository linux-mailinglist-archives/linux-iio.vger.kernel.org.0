Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8604F2F93A3
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbhAQPmM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 10:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbhAQPmI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 10:42:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A22F22581;
        Sun, 17 Jan 2021 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610898046;
        bh=511L6ckSwiNDDQRBcmWCxQ1LLUM+LfU7sXVbTf6eAuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=COXNGRTVvt+0nzModA3O4c7Yd5fjklBkyRwg8cVXXmEJ8T2Vw9XYVLqu9ERbf4Dfn
         NvoMqJF4YTSQ+75EzHsAEp7R9c0LA5H6x/W4CF2oNZvfVlR+6lRg6kfSto1i7b7LEj
         IEIpxujZTT9e3yLvtrlKLm/hUbOTA8u0de6B4i+K2DhTVzcptsgl/vaqcXoKfVzsxy
         PKeHmpLSpY59AodJ0HWriLlM78bSNunawxMPr5/HnUDf5EvjaOzNpPddVnuBZ0eWpq
         LfPZT/LrHHdIBbgyJYkUqlpY5FVE//Karg2A+vH+wfz4S6xwKThr5dvOFAcVhxL1Dw
         qno8CmojFjiNA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 7/7] iio:ABI docs: Move specific description of out_altvoltageX_frequency to main docs.
Date:   Sun, 17 Jan 2021 15:38:16 +0000
Message-Id: <20210117153816.696693-8-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117153816.696693-1-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The adf4371 has channels that are very closely coupled, so additional
documentation is needed to express these constraints.
Unfortunately having the same sysfs filename in multiple documentation
does not work well when generating automated documentation.
To avoid this issue, we add a new device specific description to the
main docs and remove the one in the device specific file.

Fixes:
$ scripts/get_abi.pl validate
Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:0  ./Documentation/ABI/testing/sysfs-bus-iio:599

Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio       | 19 ++++++++++++++
 .../testing/sysfs-bus-iio-frequency-adf4371   | 25 -------------------
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ed50f4b21dcc..515c4290d43d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -620,6 +620,25 @@ Description:
 		Output frequency for channel Y in Hz. The number must always be
 		specified and unique if the output corresponds to a single
 		channel.
+		Some drivers have additional constraints:
+		ADF4371 has an integrated VCO with fundamendal output
+		frequency ranging from 4000000000 Hz 8000000000 Hz.
+
+		out_altvoltage0_frequency:
+			A divide by 1, 2, 4, 8, 16, 32 or circuit generates
+			frequencies from 62500000 Hz to 8000000000 Hz.
+		out_altvoltage1_frequency:
+			This channel duplicates the channel 0 frequency
+		out_altvoltage2_frequency:
+			A frequency doubler generates frequencies from
+			8000000000 Hz to 16000000000 Hz.
+		out_altvoltage3_frequency:
+			A frequency quadrupler generates frequencies from
+			16000000000 Hz to 32000000000 Hz.
+
+		Note: writes to one of the channels will affect the frequency of
+		all the other channels, since it involves changing the VCO
+		fundamental output frequency.
 
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
 KernelVersion:	3.4.0
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
index 457f75903963..7fe6935d1448 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
@@ -1,28 +1,3 @@
-What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
-KernelVersion:
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Stores the PLL frequency in Hz for channel Y.
-		Reading returns the actual frequency in Hz.
-		The ADF4371 has an integrated VCO with fundamendal output
-		frequency ranging from 4000000000 Hz 8000000000 Hz.
-
-		out_altvoltage0_frequency:
-			A divide by 1, 2, 4, 8, 16, 32 or circuit generates
-			frequencies from 62500000 Hz to 8000000000 Hz.
-		out_altvoltage1_frequency:
-			This channel duplicates the channel 0 frequency
-		out_altvoltage2_frequency:
-			A frequency doubler generates frequencies from
-			8000000000 Hz to 16000000000 Hz.
-		out_altvoltage3_frequency:
-			A frequency quadrupler generates frequencies from
-			16000000000 Hz to 32000000000 Hz.
-
-		Note: writes to one of the channels will affect the frequency of
-		all the other channels, since it involves changing the VCO
-		fundamental output frequency.
-
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_name
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
-- 
2.30.0

