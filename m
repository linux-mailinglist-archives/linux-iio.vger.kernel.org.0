Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B292227E439
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 10:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgI3Iye (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728805AbgI3Iye (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 04:54:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D76BC061755;
        Wed, 30 Sep 2020 01:54:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u3so558272pjr.3;
        Wed, 30 Sep 2020 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QIq5NQbiNyJNm/We4OObc4q4pfsVdMirm2rHEjG4Osk=;
        b=OQHAXcrzd8LKG1J6V1impLCbnRaHVbL7qYR9d0/Mjrf7JE9uHlsFYPaTmKzK8OIKvM
         wvUb4Cmh68mHeOonPe9bveNFrdQwLizIWVEjCZ/4TwEMBXc6I9ScHlEHz/gqcpannNrk
         TRUMf3q/dye/fK+nwktRIXM0JlPX9Q70emD2qqryaMfurw37lD09/ZV3HPGUtMmo/yo9
         hyZ8TgvIjpta4z8KQE0RfGrdFJ3sgh6nsnvBOwhUsWtwTOiISze954p2k16e7y1Xwvjk
         yrcmcSwJrQFTAdzET3OijUlQFvu/gxYLuM8B11c6hA67ehbelvLGuVlLVlC7SPWRD8YA
         KPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QIq5NQbiNyJNm/We4OObc4q4pfsVdMirm2rHEjG4Osk=;
        b=KvAVadMv3uS3+C679qNPJlreWTa1sXgUylkblLBFC+lAbeQPSyhVtxCmEMdrYLro1E
         NGVhnqJbXWsFIk5WugUx6gX1eySQI1bwCxokCFgdgdWPe+qcqGf6xlcc6QtBx4carihX
         Q5A0lz/saeb+wzEMrqU56Nb7x5xU7Bciiw2p0ud64Hv/RQK8oRPNPS0GfBMQ5n8WN1lq
         YVmeiyvKU3ybgWdoJV5tbCjOCJ5mDu/r2OBkZ8PYfXsO090UerSqqcluWaOzF/yTl1/w
         iudYEVOK9hrlxMOFRiU51GAHiHp030MT1Nx3Eq5R+zA0RSC9HlXICmMIarVAjAWcGrQf
         8vhw==
X-Gm-Message-State: AOAM533BpU8fFWzboiTUTXPFu/74ym6PpUCnQ1Bw8nR99v/byz4d3qMM
        Pyy55iAwddylKzAQQ8tj1GM=
X-Google-Smtp-Source: ABdhPJzctE4GAO7LVQF9oT1VdZhbDQAE3QngFnCJUtR2LAD1TOD4k2Tc5042Jx4xKxcErQJhkUiHXQ==
X-Received: by 2002:a17:902:9a8d:b029:d2:4ef:a1fb with SMTP id w13-20020a1709029a8db02900d204efa1fbmr1545988plp.4.1601456074097;
        Wed, 30 Sep 2020 01:54:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56b:d17:8c76:3dc4:5429:d7e4])
        by smtp.gmail.com with ESMTPSA id x13sm1513938pff.152.2020.09.30.01.54.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 01:54:33 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 2/3] Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
Date:   Thu,  1 Oct 2020 16:54:07 +0800
Message-Id: <1601542448-7433-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add ABI documentation for mt6360 ADC sysfs interfaces.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
new file mode 100644
index 0000000..e5a7b1c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
@@ -0,0 +1,78 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 USBID ADC which connected to connector ID pin.
+		Calculating with scale and offset returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBUS ADC with lower accuracy(+-75mA)
+		higher measure range(1~22mV)
+		Calculating with scale and offset returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBUS ADC with higher accuracy(+-30mA)
+		lower measure range(1~9.76V)
+		Calculating with scale and offset returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage3_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VSYS ADC
+		Calculating with scale and offset returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage4_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBAT ADC
+		Calculating with scale and offset returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current5_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IBUS ADC
+		Calculating with scale and offset returns voltage in uA
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current6_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IBAT ADC
+		Calculating with scale and offset returns voltage in uA
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current7_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 CHG_VDDP ADC
+		Calculating with scale and offset returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp8_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IC junction temperature
+		Calculating with scale and offset returns temperature in degree
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage9_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VREF_TS ADC
+		Calculating with scale and offset returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage10_raw
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 TS ADC
+		Calculating with scale and offset returns voltage in uV
-- 
2.7.4

