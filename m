Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D851926D0
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 12:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCYLJU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 07:09:20 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:37726 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgCYLJQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Mar 2020 07:09:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1A088FB05;
        Wed, 25 Mar 2020 12:09:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bp-iItKMyRHl; Wed, 25 Mar 2020 12:09:13 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 78BA740208; Wed, 25 Mar 2020 12:09:08 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v3 4/4] Documentation: ABI: document IIO in_proximity_near_level file
Date:   Wed, 25 Mar 2020 12:09:08 +0100
Message-Id: <bffa50e16f64df2a97913d9a9e87481c6e7e4852.1585134362.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1585134362.git.agx@sigxcpu.org>
References: <cover.1585134362.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The vcnl4000 IIO driver introduced a new attribute
"in_proximity_near_level".  This adds it to the list of documented ABI
for sysfs-bus-iio.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 Documentation/ABI/testing/sysfs-bus-iio-proximity | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-proximity

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity b/Documentation/ABI/testing/sysfs-bus-iio-proximity
new file mode 100644
index 000000000000..2172f3bb9c64
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity
@@ -0,0 +1,10 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_nearlevel
+Date:		March 2020
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Near level for proximity sensors. This is a single integer
+		value that tells user space when an object should be
+		considered close to the device. If the value read from the
+		sensor is above or equal to the value in this file an object
+		should typically be considered near.
-- 
2.23.0

