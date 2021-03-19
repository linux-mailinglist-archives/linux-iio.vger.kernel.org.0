Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCC341A97
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCSLBN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCSLBJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86E9C06174A;
        Fri, 19 Mar 2021 04:01:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ha17so4483725pjb.2;
        Fri, 19 Mar 2021 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqzGrUSHT2ODyc7JfjhfJrg9zplZK53Sny3wqrHE5Ek=;
        b=K/r/iTS/rRQFOSe8TdGfMXsdwK4GbGqFZpC6nQswW7ZOReIMo+qq2YMltfcUpTynIA
         bZhq07ygkFSkI6JvyePDNkpZbJX39hqrwrDtTExcjAHSQ3gDRFR4+K/oahrj/4reVDgR
         hTHHG/cVp25HO9OidHZPrZ9tU+OT9ToZWfz8Eb+Nvkd2slxt0hUVaAhWiritdT34y3rZ
         CWVl2ElXgav9a3HlCXKTgFDDYGD8/tnVXM1QD4iGaLEeILu+RrVHm42apjHXfcG1c5NC
         0CR2sU52nQbYFG0F5JfvDMD/D7td8+t6RDU7MD5tyNGF/0NKrDRLDcV4G17fbXMv/CL2
         g4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqzGrUSHT2ODyc7JfjhfJrg9zplZK53Sny3wqrHE5Ek=;
        b=DTAb2+B8CtFKz4+lEZHVQh73cGZvGGh+EQqnTyNSKiTWtzaEKhs6ALjxn4zVx12RSP
         huDm5EZVHSpL26NMheC+6waYSkid229a+lpURxTIS5vtGpPBgEVTPQ9Pkm2rX3Gaeo8q
         nAsYybYIDnwEBPo3Lp3D5XNTFWfkk9pn8Hgf0Dvxhc3R73+XI5ljHP7me/EGIp1Gljr1
         793Z2jqm/aWqk4Ocd3f9tig4eoLcT35G06e+DmCpFuk06f3vKBhgBvxg0uHwcYXE3yw6
         +8hLQJYgibrWeW2UusHFMyZLqI+PBn+lQIx4BWfQB8TJ/pWkwaMpnV2SjzBshY9B8OUf
         Rbtg==
X-Gm-Message-State: AOAM532celuhYBa4Ng2HCJAnnxmimD6WwJwmKiFPIJECIty9XByrBdfK
        adAr3235bHiIrap/GgA7bmI=
X-Google-Smtp-Source: ABdhPJxSPzwwwWvvlYz9H06c9bqwy0JIeXaHfcKYZ3niakgV/iHn3Cyw3BtXdgQ+ShT1h+CUBqkuUQ==
X-Received: by 2002:a17:902:8c8d:b029:e5:e1fc:a587 with SMTP id t13-20020a1709028c8db02900e5e1fca587mr14078217plo.12.1616151669181;
        Fri, 19 Mar 2021 04:01:09 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:08 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 01/33] docs: counter: Consolidate Counter sysfs attributes documentation
Date:   Fri, 19 Mar 2021 20:00:20 +0900
Message-Id: <50707642485aee45d6410a2dbd3e0b7ae420993b.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Duplicate ABIs are not valid, so let's consolidate these sysfs
attributes into the main sysfs-bus-counter documentation file.

Cc: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter   | 76 ++++++++++++++++++-
 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 61 ---------------
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec | 16 ----
 MAINTAINERS                                   |  4 +-
 4 files changed, 75 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 566bd99fe0a5..29f54484183f 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -57,6 +57,7 @@ Description:
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
 What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
 What:		/sys/bus/counter/devices/counterX/countY/function_available
+What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -154,6 +155,15 @@ Description:
 		Count Y. If possible, this should match the name of the
 		respective channel as it appears in the device datasheet.
 
+What:		/sys/bus/counter/devices/counterX/countY/prescaler
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the prescaler value associated with Count Y.
+		On the FlexTimer, the counter clock source passes through a
+		prescaler (i.e. a counter). This acts like a clock
+		divider.
+
 What:		/sys/bus/counter/devices/counterX/countY/preset
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -215,11 +225,45 @@ Description:
 		Read-only attribute that indicates the total number of Signals
 		belonging to the Counter.
 
-What:		/sys/bus/counter/devices/counterX/signalY/signal
+What:		/sys/bus/counter/devices/counterX/signalY/cable_fault
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether a differential
+		encoder cable fault (not connected or loose wires) is detected
+		for the respective channel of Signal Y. Valid attribute values
+		are boolean. Detection must first be enabled via the
+		corresponding cable_fault_enable attribute.
+
+What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether detection of differential encoder cable faults for the
+		respective channel of Signal Y is enabled. Valid attribute
+		values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Filter clock factor for input Signal Y. This prescaler value
+		affects the inputs of both quadrature pair signals.
+
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Signal data of Signal Y represented as a string.
+		Active level of index input Signal Y; irrelevant in
+		non-synchronous load mode.
+
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Signal Y
+		configuration are listed in this file.
 
 What:		/sys/bus/counter/devices/counterX/signalY/name
 KernelVersion:	5.2
@@ -228,3 +272,31 @@ Description:
 		Read-only attribute that indicates the device-specific name of
 		Signal Y. If possible, this should match the name of the
 		respective signal as it appears in the device datasheet.
+
+What:		/sys/bus/counter/devices/counterX/signalY/signal
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signal data of Signal Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the counter associated with Signal Y for
+		non-synchronous or synchronous load mode. Synchronous load mode
+		cannot be selected in non-quadrature (Pulse-Direction) clock
+		mode.
+
+		non-synchronous:
+			A logic low level is the active level at this index
+			input. The index function (as enabled via preset_enable)
+			is performed directly on the active level of the index
+			input.
+
+		synchronous:
+			Intended for interfacing with encoder Index output in
+			quadrature clock mode. The active level is configured
+			via index_polarity. The index function (as enabled via
+			preset_enable) is performed synchronously with the
+			quadrature clock on the active level of the index input.
diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
deleted file mode 100644
index eac32180c40d..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
+++ /dev/null
@@ -1,61 +0,0 @@
-What:		/sys/bus/counter/devices/counterX/signalY/cable_fault
-KernelVersion:	5.7
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Read-only attribute that indicates whether a differential
-		encoder cable fault (not connected or loose wires) is detected
-		for the respective channel of Signal Y. Valid attribute values
-		are boolean. Detection must first be enabled via the
-		corresponding cable_fault_enable attribute.
-
-What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable
-KernelVersion:	5.7
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Whether detection of differential encoder cable faults for the
-		respective channel of Signal Y is enabled. Valid attribute
-		values are boolean.
-
-What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler
-KernelVersion:	5.7
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Filter clock factor for input Signal Y. This prescaler value
-		affects the inputs of both quadrature pair signals.
-
-What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
-KernelVersion:	5.2
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Active level of index input Signal Y; irrelevant in
-		non-synchronous load mode.
-
-What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
-What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
-KernelVersion:	5.2
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Discrete set of available values for the respective Signal Y
-		configuration are listed in this file.
-
-What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
-KernelVersion:	5.2
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Configure the counter associated with Signal Y for
-		non-synchronous or synchronous load mode. Synchronous load mode
-		cannot be selected in non-quadrature (Pulse-Direction) clock
-		mode.
-
-		non-synchronous:
-			A logic low level is the active level at this index
-			input. The index function (as enabled via preset_enable)
-			is performed directly on the active level of the index
-			input.
-
-		synchronous:
-			Intended for interfacing with encoder Index output in
-			quadrature clock mode. The active level is configured
-			via index_polarity. The index function (as enabled via
-			preset_enable) is performed synchronously with the
-			quadrature clock on the active level of the index input.
diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
deleted file mode 100644
index 7d2e7b363467..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
+++ /dev/null
@@ -1,16 +0,0 @@
-What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
-KernelVersion:	5.2
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Discrete set of available values for the respective Count Y
-		configuration are listed in this file. Values are delimited by
-		newline characters.
-
-What:		/sys/bus/counter/devices/counterX/countY/prescaler
-KernelVersion:	5.2
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Configure the prescaler value associated with Count Y.
-		On the FlexTimer, the counter clock source passes through a
-		prescaler (i.e. a counter). This acts like a clock
-		divider.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a9bf18bba00..ddabf7bb5246 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -299,7 +299,6 @@ M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 M:	Syed Nayyar Waris <syednwaris@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 F:	drivers/counter/104-quad-8.c
 
 ACCES PCI-IDIO-16 GPIO DRIVER
@@ -4578,7 +4577,7 @@ COUNTER SUBSYSTEM
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-counter*
+F:	Documentation/ABI/testing/sysfs-bus-counter
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
@@ -6960,7 +6959,6 @@ FLEXTIMER FTM-QUADDEC DRIVER
 M:	Patrick Havelange <patrick.havelange@essensium.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
 F:	drivers/counter/ftm-quaddec.c
 
-- 
2.30.2

