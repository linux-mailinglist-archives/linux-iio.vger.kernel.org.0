Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B6430611
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 03:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244871AbhJQB6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 21:58:23 -0400
Received: from vern.gendns.com ([98.142.107.122]:48322 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244830AbhJQB6P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 21:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j9IRzaf6FPIjz8sK9QpS3IucQ9AuW3vUL2+PvONAE7Q=; b=JzXqxuxp6yXaSzaVmVVKboLWPi
        Db3CXQkDp0vT4VHVfx0rhfypHTNs0mQeIO+5BBDHZrfHcXvyd1leXn13M3WLNKYYkK0yU5eLkJRGE
        p8FbDyLGT+/HHR8ogfU+c2A5v/N/SUamgzUwsrbNHxkNBSzA1vfdC4tPi89VXYiT/j1nAkGPILhQH
        nf9y7qJS59povssq5ylqXaUaJgHOZzN60fzdltesIFRQKNnSBc7Ig+Np3tm6Z0M43o73yCn8kA6EI
        1PyUx4pfzviLgUguLo8SO/qOKLJV/pQhUA7Vo1OJxsktJozfDU23KTgX/8Ne3BDSlJ+0AXFAXb/+M
        2Tjj828g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41624 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mbv48-0004D2-52; Sat, 16 Oct 2021 21:34:22 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] docs: counter: add latch_mode and latched_count sysfs attributes
Date:   Sat, 16 Oct 2021 20:33:41 -0500
Message-Id: <20211017013343.3385923-7-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211017013343.3385923-1-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This documents new counterX/latch_mode* and
counterX/countY/latched_count* attributes.

The counterX/signalY/*_available are moved to the
counterX/countY/*_available section similar to the way we already have
The counterX/*_component_id and The counterX/signalY/*_component_id
grouped together so that we don't have to start a 3rd redundant section
for device-level *_available section.

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 39 ++++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 37d960a8cb1b..78bb1a501007 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -59,10 +59,13 @@ What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
 What:		/sys/bus/counter/devices/counterX/countY/function_available
 What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
+What:		/sys/bus/counter/devices/counterX/latch_mode_available
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Discrete set of available values for the respective Count Y
+		Discrete set of available values for the respective component
 		configuration are listed in this file. Values are delimited by
 		newline characters.
 
@@ -147,6 +150,14 @@ Description:
 			updates	the respective count. Quadrature encoding
 			determines the direction.
 
+What:		/sys/bus/counter/devices/counterX/countY/latched_count
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Latched count data of Count Y represented as a string. The value
+		is latched in based on the trigger selected by the
+		counterX/latch_mode attribute.
+
 What:		/sys/bus/counter/devices/counterX/countY/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -209,6 +220,7 @@ What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
 What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
 What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
+What:		/sys/bus/counter/devices/counterX/countY/latched_count_component_id
 What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
@@ -218,6 +230,7 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
+What:		/sys/bus/counter/devices/latch_mode_component_id
 What:		/sys/bus/counter/devices/unit_timer_enable_component_id
 What:		/sys/bus/counter/devices/unit_timer_period_component_id
 What:		/sys/bus/counter/devices/unit_timer_time_component_id
@@ -244,6 +257,22 @@ Description:
 		counter_event data structures. The number of elements will be
 		rounded-up to a power of 2.
 
+What:		/sys/bus/counter/devices/counterX/latch_mode
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write attribute that selects the trigger for latching
+		values. Valid values are device-specific (given by
+		latch_mode_available attribute) and may include:
+
+		"Read count":
+			Reading the countY/count attribute latches values.
+
+		"Unit timeout":
+			Unit timer timeout event latches values.
+
+		The latched values can be read from latched_* attributes.
+
 What:		/sys/bus/counter/devices/counterX/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -298,14 +327,6 @@ Description:
 		Active level of index input Signal Y; irrelevant in
 		non-synchronous load mode.
 
-What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
-What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
-KernelVersion:	5.2
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Discrete set of available values for the respective Signal Y
-		configuration are listed in this file.
-
 What:		/sys/bus/counter/devices/counterX/signalY/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
-- 
2.25.1

