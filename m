Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC21B4723
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgDVOWO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 10:22:14 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:38519 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbgDVOWN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 10:22:13 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.146.85])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id D40504F477F1;
        Wed, 22 Apr 2020 16:13:07 +0200 (CEST)
Received: from arch.lan (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Apr
 2020 16:13:07 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 4/6] Documentation: ABI: testing: scd30: document iio attributes
Date:   Wed, 22 Apr 2020 16:11:33 +0200
Message-ID: <20200422141135.86419-5-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 5833005944528591895
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for sensor specific iio attributes.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-scd30 | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-scd30 b/Documentation/ABI/testing/sysfs-bus-iio-scd30
new file mode 100644
index 000000000000..0431a718447d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-scd30
@@ -0,0 +1,97 @@
+What:		/sys/bus/iio/devices/iio:deviceX/pressure_comp
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Given that sensor's CO2 measurement chamber has fixed volume
+		pressure changes will affect concentration readings. Writing
+		current ambient pressure here will allow senor to make necessary
+		adjustments. Upon reading previously set value is returned.
+		Units are millibars.
+
+What:		/sys/bus/iio/devices/iio:deviceX/pressure_comp_available
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The range of available values in millibars represented as the
+		minimum value, the step and the maximum value, all enclosed in
+		square brackets.
+
+What:		/sys/bus/iio/devices/iio:deviceX/meas_interval
+Date:		January 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Amount of time between subsequent measurements. Writing this
+		attribute will change measurement interval. Upon reading
+		current measurement interval is returned. Units are seconds.
+
+What:		/sys/bus/iio/devices/iio:deviceX/meas_interval_available
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The range of available values in seconds represented as the
+		minimum value, the step and the maximum value, all enclosed in
+		square brackets.
+
+What:		/sys/bus/iio/devices/iio:deviceX/asc
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Writing 1 or 0 to this attribute will respectively activate or
+		deactivate automatic self calibration procedure. Upon reading 1
+		is returned if asc is ongoing, 0 otherwise.
+
+What:		/sys/bus/iio/devices/iio:deviceX/frc
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Forced recalibration is used to compensate for sensor drifts
+		when a reference value of CO2 concentration in close proximity
+		to the sensor is available. Writing attribute will set frc
+		value. Upon reading current frc is returned. Units are
+		millibars.
+
+What:		/sys/bus/iio/devices/iio:deviceX/frc_available
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The range of available values in millibars represented as the
+		minimum value, the step and the maximum value, all enclosed in
+		square brackets.
+
+What:		/sys/bus/iio/devices/iio:deviceX/temp_offset
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Sensor readings may be affected by ambient temperature.
+		Writing temperature offset will compensate for unwanted changes.
+		Note that written offset gets multiplied by a factor of 100
+		by a sensor internally.
+
+		For example, writing 10 here will correspond to 0.1 degree
+		Celsius.
+
+What:		/sys/bus/iio/devices/iio:deviceX/temp_offset_available
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The range of available values in degrees Celsius represented as
+		the minimum value, the step and the maximum value, all enclosed
+		in square brackets.
+
+What:		/sys/bus/iio/devices/iio:deviceX/reset
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Software reset mechanism forces sensor into the same state
+		as after powering up without the need for removing power supply.
+		Writing any value will reset sensor.
-- 
2.26.1

