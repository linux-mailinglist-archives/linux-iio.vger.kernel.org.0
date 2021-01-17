Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242A62F93A2
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbhAQPmJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 10:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbhAQPmH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 10:42:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C534E2253A;
        Sun, 17 Jan 2021 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610898043;
        bh=9AX5rf6EYSn7JDBBzPcWzczYLdWEL2zW6dyRs5ubigI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLEbJ6AbMUV6KTauzw6zu5dOJgvn3I41GrrcnzK3sYkVHMju2N9t0LdpmFTZ/8oqg
         ToH6HfJyTgavO4fir9p6WZq35J9qBAotM/2XFTvFftuQ3bVXAw+Hdj5F/JlhdwBeoa
         +T+ge2Tuum2hEbVAGCDkSEFLm79bMXH6eUO0fbAu9lSL7ffyE2wv8DE+wKofzdc76Q
         PgbYAiyPGMzfWdWqUe/UxKYhWzLS7/LTn6raZ0t7dLe2RMl0OMH2VDRedfoE05CAq6
         DDHQIJwVXjnb/SXsIuYHRh48g2lmNH3dmj8O+oD9hwdIASmiLUjP+OB+IxYHtlRbZi
         7AepbphI+ZTFQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugene Zaikonnikov <ez@norphonic.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [RFC PATCH 5/7] iio:ABI docs: Combine sysfs-bus-iio-humidity-hdc2010/hdc100x into one file
Date:   Sun, 17 Jan 2021 15:38:14 +0000
Message-Id: <20210117153816.696693-6-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117153816.696693-1-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These contain only one entry for out_current_heater_raw (_available).
Document this in a new sysfs-bus-iio-humidity file, and make it a little
more generic by allowing for non 0/1 values.

Fixes:
$ scripts/get_abi.pl validate
Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:0  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:0
Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:1  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:1

Cc: Eugene Zaikonnikov <ez@norphonic.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ...s-bus-iio-humidity-hdc2010 => sysfs-bus-iio-humidity} | 3 ++-
 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x | 9 ---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010 b/Documentation/ABI/testing/sysfs-bus-iio-humidity
similarity index 79%
rename from Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
rename to Documentation/ABI/testing/sysfs-bus-iio-humidity
index 5b78af5f341d..cb0d7e75d297 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
+++ b/Documentation/ABI/testing/sysfs-bus-iio-humidity
@@ -6,4 +6,5 @@ Description:
 		Controls the heater device within the humidity sensor to get
 		rid of excess condensation.
 
-		Valid control values are 0 = OFF, and 1 = ON.
+		In some devices, this is just a switch in which case 0 = OFF,
+		and 1 = ON.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x b/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
deleted file mode 100644
index b72bb62552cf..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
+++ /dev/null
@@ -1,9 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
-What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
-KernelVersion:	4.3
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Controls the heater device within the humidity sensor to get
-		rid of excess condensation.
-
-		Valid control values are 0 = OFF, and 1 = ON.
-- 
2.30.0

