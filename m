Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D855F2EBC
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 14:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbfKGNBt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 08:01:49 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGNBt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 08:01:49 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPoTl-1iGNUE2fiN-00MvAj; Thu, 07 Nov 2019 14:01:17 +0100
Date:   Thu, 7 Nov 2019 14:01:11 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        davem@davemloft.net, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iio: add ping sensors to kernel configuration
Message-ID: <20191107130108.p6maggrs2m7va5pf@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:YnPKCWkI+oAHGK0oBCaxn9+OMKi/PZRgpNNf4njdogAkiOtTNnG
 nIU9ZLRabqjm6ssy5vI3auwnqlfrU4Vnd/LTcJd+DnZd+XYzsCMvCvzSiggzVypuSPsVT2z
 UYlViD2P9SzwGGn1e4enBckIzmythSqrSHekYYdo9wgWB+dAxNxTlwEeTWN8H5GcV5KFACt
 XSwoFP3jiNK40N0279tJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vXoEMobgM+k=:NzkB7c1Kh44XwZRNWoRiRq
 dCXV8pFhpFi8/S5WW3ZkAOC15NTIb1EEzi2+I+ddhefBe/CZN7jkasMjA01Git3bGUj7ltsYW
 ni/B1+S1upIOR0++NYhurkvRpbMNKJnrdiIPhATyWBdP84ic/aU1P9mEIPbLfWx5745xR+FNt
 bue6SIR7DNeT8TmjzZ40RbLw8TYJ63ShDGrPhMzKE7Q/gjNVNYDyN9J2VnFi4tbz5uMYNLQzz
 NJAffcjXU4+9fKeXh+WddIgC5YcEkz02C9PzzdNA1HrKftGrBaS51LbuR6v7y5Uq5MqZsf40r
 At/NRRjN8hMjPcqSmNgIFdRJI/ajl/V0qg+NM7ZxSkzmnl3VKMKBr/T4v1PYQa2neYPL3IaRW
 MPwZAYsN6Gb3okFvkRVud5+83nVcUyWsac7xibNg4sxgmGjno2l/ITavUn1HOCJkcx2WURNli
 7VslmVubSyoPp76zrkm1Xwu0JDNY/5rI+kWI2PVRMWDMgYD98NwSaDbSC/idNNpXGA+TSIcZ3
 VuCebnFRCZHJ8et2VnGV2vy06xoK9IaxPMygs3ID77nP23G8zUayXVRPfEQZzBFknXOSBreJP
 +44WsmuRkcWQAcQuvEDsz4Elwl24mMN8UXn6WYiWXb956CIGgDCRylGTDj2BC1+AqR2cJr0qf
 GAJS8bkM5ZZKDpjXVw5rhfMkKfJJGhkPMl33u7FgnV37aBJ2duY+Gg64JswUXM2hEDGjl2NVb
 yEHVyaRC1oNI3rp7lzUjeepmG3K8LWrXS7ohNCNqAreoSlq1+kmPmSngnWGegXknJRCeUio/z
 Hibu8Bu1489U8ddZUDNh/UPncHpyJkQ2mSBADIA+aMUQA4CvE1PfBf1lZpNxhRxvPLHPI/PQP
 gJOvN57SIs77985jP6vA==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new configuration variable CONFIG_PING for the newly supported
parallax ping sensors.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/Kconfig  | 15 +++++++++++++++
 drivers/iio/proximity/Makefile |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index d53601447da4..37606d400805 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -58,6 +58,21 @@ config MB1232
 	  To compile this driver as a module, choose M here: the
 	  module will be called mb1232.
 
+config PING
+	tristate "Parallax GPIO bitbanged ranger sensors"
+	depends on GPIOLIB
+	help
+	  Say Y here to build a driver for GPIO bitbanged ranger sensors
+	  with just one GPIO for the trigger and echo. This driver can be
+	  used to measure the distance of objects.
+
+	  Actually supported are:
+	  - Parallax PING))) (ultrasonic)
+	  - Parallax LaserPING (time-of-flight)
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ping.
+
 config RFD77402
 	tristate "RFD77402 ToF sensor"
 	depends on I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 0bb5f9de13d6..c591b019304e 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_ISL29501)		+= isl29501.o
 obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
 obj-$(CONFIG_MB1232)		+= mb1232.o
+obj-$(CONFIG_PING)		+= ping.o
 obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
-- 
2.11.0
