Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFDA55B2FB
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 18:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiFZQpz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 12:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiFZQpw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 12:45:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65992DFBE
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 09:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23CA3B80D39
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 16:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A2DC341CB;
        Sun, 26 Jun 2022 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656261947;
        bh=QQL2KzFC3RhSW4JT0GruPu+IOICbC8UOR45TlYI79rQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/tR+q6jodlsKK52Jmxem+7IpS5BRqSKtf3J2fhbl2t9ZM+je1IWYnySgSeN536mD
         mMHVlVbe3YRWHD9CZdcW9VVqqxKAMlWNxSpf1fpj/iGMThLMRvz/ZrE9dOVdKC0Uqc
         gHLReJG+pNzYcsLsvXHwmSTZl2/RkLUXbHAsUYRvR1bWeqc3GGdtAX/DPjBOh9SZ87
         JEzGnSqZAdLyMtEYWjavoiOk6PzW86QizjASTex/xmY8IwUbbRaqote0lFVieWFdwK
         URZAlbhin3MPk6A6oiChzyUaUaVsMA/Ev+2d+RUts30tjL1Odlt8qzi+NSHEAf3BT+
         devCnqxkcjoJg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Subject: [PATCH 1/4] iio: ABI: temperature: Unify documentation for thermocouple fault detection.
Date:   Sun, 26 Jun 2022 17:55:08 +0100
Message-Id: <20220626165511.602202-2-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626165511.602202-1-jic23@kernel.org>
References: <20220626165511.602202-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The kernel build docs do not support having multiple definitions for
the same sysfs filename.  Hence generalize the documentation a little
and pull it out of device specific files and into
sysfs-bus-iio-thermocouple

These may well be more general and need pulling into a more generic
file in the future, but we can do that when it is needed.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Navin Sankar Velliangiri <navin@linumiz.com>
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
---
 .../sysfs-bus-iio-temperature-max31856        | 31 -------------------
 .../sysfs-bus-iio-temperature-max31865        | 12 -------
 .../ABI/testing/sysfs-bus-iio-thermocouple    | 18 +++++++++++
 3 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
deleted file mode 100644
index e5ef6d8e5da1..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
+++ /dev/null
@@ -1,31 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
-KernelVersion:	5.1
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Open-circuit fault. The detection of open-circuit faults,
-		such as those caused by broken thermocouple wires.
-		Reading returns either '1' or '0'.
-
-		===  =======================================================
-		'1'  An open circuit such as broken thermocouple wires
-		     has been detected.
-		'0'  No open circuit or broken thermocouple wires are detected
-		===  =======================================================
-
-What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
-KernelVersion:	5.1
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Overvoltage or Undervoltage Input Fault. The internal circuitry
-		is protected from excessive voltages applied to the thermocouple
-		cables by integrated MOSFETs at the T+ and T- inputs, and the
-		BIAS output. These MOSFETs turn off when the input voltage is
-		negative or greater than VDD.
-
-		Reading returns either '1' or '0'.
-
-		===  =======================================================
-		'1'  The input voltage is negative or greater than VDD.
-		'0'  The input voltage is positive and less than VDD (normal
-		     state).
-		===  =======================================================
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
index 4b072da92218..349089e4f2d6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
+++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
@@ -1,15 +1,3 @@
-What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
-KernelVersion:	5.11
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Overvoltage or Undervoltage Input fault. The internal circuitry
-		is protected from excessive voltages applied to the thermocouple
-		cables at FORCE+, FORCE2, RTDIN+ & RTDIN-. This circuitry turn
-		off when the input voltage is negative or greater than VDD.
-
-		Reading returns '1' if input voltage is negative or greater
-		than VDD, otherwise '0'.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-thermocouple b/Documentation/ABI/testing/sysfs-bus-iio-thermocouple
new file mode 100644
index 000000000000..01259df297ca
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-thermocouple
@@ -0,0 +1,18 @@
+What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Overvoltage or Undervoltage Input Fault. The internal circuitry
+		is protected from excessive voltages applied to the thermocouple
+		cables. The device can also detect if such a condition occurs.
+
+		Reading returns '1' if input voltage is negative or greater
+		than VDD, otherwise '0'.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Open-circuit fault. The detection of open-circuit faults,
+		such as those caused by broken thermocouple wires.
+		Reading returns '1' if fault, '0' otherwise.
-- 
2.36.1

