Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FD43060B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 03:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbhJQB6L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 21:58:11 -0400
Received: from vern.gendns.com ([98.142.107.122]:48316 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhJQB6L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 21:58:11 -0400
X-Greylist: delayed 1302 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Oct 2021 21:58:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GuLQdramhgwNgLru0VZHuyqgy4diYgMbyLCS1BF8hY0=; b=TY7bWJlnuR2Dj/U2gKCFrejilM
        jhImTXPYt9U9PPtUTSmUm0H+g3rPGZhHrFWwq81WTBc1quTtGoR6d1iK6VqXEaZEfhGm6KC2UXZRW
        3/uzF3nE6xwmDt9x9u0yT3byzuFtuVROtEm38PGXh+ipDG1zM7lMTDN2QZ8rVzAYMvDqQq1TMJylz
        6XOtKlDDalOX9yqyg1r/CCetarQT0Cswp9flY0cbNUpDHbI2gFJdivGe0U+1P2HW5evg28sSZZXbj
        cmoTAOD8mQ7Ut19UQYfM/BqakGT9DXfZkR6Q8gEtfGTP5OfHISL3BHnKMO00RJT4BFX0KzLP/fOvR
        70Xb6FpA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41624 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mbv46-0004D2-LO; Sat, 16 Oct 2021 21:34:20 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] docs: counter: add unit timer sysfs attributes
Date:   Sat, 16 Oct 2021 20:33:39 -0500
Message-Id: <20211017013343.3385923-5-david@lechnology.com>
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

This documents new unit timer sysfs attributes for the counter
subsystem.

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 24 +++++++++++++++++++++
 drivers/counter/ti-eqep.c                   |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 06c2b3e27e0b..37d960a8cb1b 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -218,6 +218,9 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
+What:		/sys/bus/counter/devices/unit_timer_enable_component_id
+What:		/sys/bus/counter/devices/unit_timer_period_component_id
+What:		/sys/bus/counter/devices/unit_timer_time_component_id
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -345,3 +348,24 @@ Description:
 			via index_polarity. The index function (as enabled via
 			preset_enable) is performed synchronously with the
 			quadrature clock on the active level of the index input.
+
+What:		/sys/bus/counter/devices/unit_timer_enable
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write attribute that starts or stops the unit timer. Valid
+		values are boolean.
+
+What:		/sys/bus/counter/devices/unit_timer_period
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write attribute that selects the unit timer timeout in
+		nanoseconds.
+
+What:		/sys/bus/counter/devices/unit_timer_time
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write attribute that indicates the current time of the
+		unit timer in nanoseconds.
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index a4a5a4486329..1ba7f3c7cb7e 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -680,7 +680,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	/*
-	 * We can end up with an interupt infinite loop (interrupts triggered
+	 * We can end up with an interrupt infinite loop (interrupts triggered
 	 * as soon as they are cleared) if we leave these at the default value
 	 * of 0 and events are enabled.
 	 */
-- 
2.25.1

