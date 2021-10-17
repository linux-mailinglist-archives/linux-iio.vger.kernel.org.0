Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42E430618
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 03:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbhJQB6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 21:58:35 -0400
Received: from vern.gendns.com ([98.142.107.122]:48350 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244847AbhJQB6d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 21:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wPH2jK/OOV+TnEhd20yJJMhH7lEufQUYCOiUumD6kYQ=; b=YvEe9aC6fbNmSWJ46wHblq47Ty
        qdkQ1yht4qtkQA1U9k00ZBeR7d7uxViAXSYv+i5F74CkL0wdMOB7otLx2lHgzLI2UbKUiPnA2S2ia
        xk04PGz756bEMvfUnRFMxmt6JBA6N3UXAOP9By4H5VmrX7oar4yokGZCKo79iuGZjZZZ2Dh9LhlV+
        KMG7sngs1sc8GcKl1Vr1ye4v7aHhk0DF7pfTbhK2lr+1W/x+CoCL60G9M4AXFIDGuY4+FHBYC9aLM
        tByFwJlzH8iGR8gCoX0P8z4j1O1lFIr/IkNuqyy+X727kgSYbOz1L7aqNPgrsLAVTAqfUzuVgAZTw
        6OgvROZA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41624 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mbv49-0004D2-NG; Sat, 16 Oct 2021 21:34:23 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] docs: counter: add edge_capture_unit_* attributes
Date:   Sat, 16 Oct 2021 20:33:43 -0500
Message-Id: <20211017013343.3385923-9-david@lechnology.com>
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

This adds documentation for new counter subsystem edge_capture_unit_*
sysfs attributes.

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 78bb1a501007..6c192c8c2b55 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -59,6 +59,7 @@ What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
 What:		/sys/bus/counter/devices/counterX/countY/function_available
 What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
+What:		/sys/bus/counter/devices/counterX/edge_capture_unit_prescaler_available
 What:		/sys/bus/counter/devices/counterX/latch_mode_available
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
@@ -230,6 +231,10 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
+What:		/sys/bus/counter/devices/edge_capture_unit_enable_component_id
+What:		/sys/bus/counter/devices/edge_capture_unit_latched_period_component_id
+What:		/sys/bus/counter/devices/edge_capture_unit_max_period_component_id
+What:		/sys/bus/counter/devices/edge_capture_unit_prescaler_component_id
 What:		/sys/bus/counter/devices/latch_mode_component_id
 What:		/sys/bus/counter/devices/unit_timer_enable_component_id
 What:		/sys/bus/counter/devices/unit_timer_period_component_id
@@ -249,6 +254,38 @@ Description:
 		shorter or equal to configured value are ignored. Value 0 means
 		filter is disabled.
 
+What:		/sys/bus/counter/devices/edge_capture_unit_enable
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write attribute that starts or stops the Edge Capture Unit.
+		Valid values are boolean.
+
+What:		/sys/bus/counter/devices/edge_capture_unit_latched_period
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Latched period of the Edge Capture Unit represented as a string.
+		The value is latched in based on the trigger selected by the
+		counterX/latch_mode attribute. Units are nanoseconds.
+
+What:		/sys/bus/counter/devices/edge_capture_unit_max_period
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write attribute that selects the maximum period that can
+		be measured by the Edge Capture Unit. Units are nanoseconds.
+
+What:		/sys/bus/counter/devices/edge_capture_unit_prescaler
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write attribute that selects the how the
+		counterX/countY/count value is scaled coming in to the Edge
+		Capture Unit. This acts like a clock divider, e.g. if a value
+		of 4 is selected, the Edge Capture Unit will measure the period
+		between every 4 counts.
+
 What:		/sys/bus/counter/devices/counterX/events_queue_size
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
-- 
2.25.1

