Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA62F9394
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 16:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbhAQPl1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 10:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbhAQPlZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 10:41:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 519222255F;
        Sun, 17 Jan 2021 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610898038;
        bh=8s+alTuwm7/hKtRMvDxP7RkD1eUO+qnS3pAay4zrGIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipcv4uo+KkhSLMAxISwP16imVgPa7y2f5yfpOw6UyRBWhyQyCkv5z/WQaCCWdKb3T
         TIiVBWfXvScZ6t+5HJH4JMgUeFMPnA1PFXW3E0fMGqh0wsp1IwrT/ND3MvYBlafu0F
         KockJ5P5+ya7WuZrCk4g8cVCSvRgIjltbOkmY27gpKtpoeLTJADptyxh15rjq/5DGP
         +cmjjI/poIgNMEtgSqlvG0k3Qea/LnZqQEhA3rRCFcnxiKpd8hqVto6wz0Y0zufqIi
         ifkFJbBk+eGMWsCDIPMXa0oGju0I08PXQla2qew7IkTVAvRaW0Fia0R0ECxNWVExhG
         ya4+vh9vk7pFg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RFC PATCH 2/7] iio:ABI docs: Avoid repitition of triggerX/sampling_frequency
Date:   Sun, 17 Jan 2021 15:38:11 +0000
Message-Id: <20210117153816.696693-3-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117153816.696693-1-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The timer-stm32 provided a little more specific information than the main
docs about the value of 0 corresponding to stopping sampling.  Given that
this makes sense in general, move that statement over to the main docs
and drop the version in sysfs-bus-iio-timer-stm32

Fixes
$ scripts/get_abi.pl validate
/sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  ./Documentation/ABI/testing/sysfs-bus-iio:45

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio             | 2 ++
 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d2dd9cc280f9..9b5ceb22363d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -55,6 +55,8 @@ Description:
 		direct access interfaces, it may be found in any of the
 		relevant directories.  If it affects all of the above
 		then it is to be found in the base device directory.
+		Note a value 0 where supported, will correspond to sampling
+		stopping.
 
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
index c4a4497c249a..05074c4a65e2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
@@ -90,14 +90,6 @@ Description:
 		Reading returns the current master modes.
 		Writing set the master mode
 
-What:		/sys/bus/iio/devices/triggerX/sampling_frequency
-KernelVersion:	4.11
-Contact:	benjamin.gaignard@st.com
-Description:
-		Reading returns the current sampling frequency.
-		Writing an value different of 0 set and start sampling.
-		Writing 0 stop sampling.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
 KernelVersion:	4.12
 Contact:	benjamin.gaignard@st.com
-- 
2.30.0

