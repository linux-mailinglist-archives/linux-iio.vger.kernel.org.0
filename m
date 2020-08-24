Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E3024F6E1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Aug 2020 11:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgHXJG4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbgHXJGy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 05:06:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19CDC061573;
        Mon, 24 Aug 2020 02:06:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f193so4480120pfa.12;
        Mon, 24 Aug 2020 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kUkHyWifMBTnLUKfuOlzPEWC4L6WTYZmfRcQtW7YpF0=;
        b=Z7JfQloKaTjiT0H4ASAyjMkzOVg0yvKyOhrTwAaHBfJbVfCJcgfcC/td6BJwaNPz4C
         ff9ViiFoPralIJ8iinxqg7EGJesq/N2dB6tFIsnDAyq1IwXuvT2ySJe6YoK0eLBEko46
         0gfp6pg5DKGU5U+h2TigbaH1m/PVqGMqTfJSkcgUAduItvIzaIFLJ9uX00Yh2EHCHyBh
         YcrWAACm2yCl8VSUoxJh+oo406KRROv9VENVUPjD/59wOX2eXxvtyBY80Y7yo6BqS4t1
         fbMGY+0drYrqVOB04LqRnl/lgluQ/L7NZMK1/3dMZH0sBEJwYUeuJh0342DPyCrTr+I2
         kjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kUkHyWifMBTnLUKfuOlzPEWC4L6WTYZmfRcQtW7YpF0=;
        b=Z7BH/W7901IBeO8jFQIaCnkPYhpOXgrHkVlMOjOCGqoXdm65gdFUHgtHuXVjYvMGfd
         g6trMIUw779RuyvScIJOWzjIHKsdwwo2W2GjmlaR5z63i7YhLu1mR6SswSOsYlsSG/ZJ
         CMTRYlLQeGvT5/5feosdmPbJtLAOxcvW3xe9n626S+XCFJ+rkxLXYWvGbzma5apM9vkv
         URhe8YeN/Fd73D7WGdyyyAGC93zuWvex/3W+4Ef/mKbWu4Dn8XmUO+oeToNg1pPnHZz/
         gpuFv20XuJif6SNt0LoIYR7SGFy4lGSgI8oJhCuGXJ0XsVjAHBkrggZMp11R+3dTPoQt
         Hbig==
X-Gm-Message-State: AOAM5321WX/9h9g0JCHWwyQuAyHsJ7tM6WuMkONUol5UWXTuLznHff+2
        DvLZ4IRexeiwpPBX8RwpQdw=
X-Google-Smtp-Source: ABdhPJw14xcNmXa1rR9IVlAIv+z1Xu6egOA/ZqBXZ3+NIiQOsygfcNGkj27A9h4zWhIQbWn+tiZxpQ==
X-Received: by 2002:a63:5c08:: with SMTP id q8mr2956738pgb.222.1598260013533;
        Mon, 24 Aug 2020 02:06:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:484:931d:1b34:35e8:fe10:8c7a])
        by smtp.gmail.com with ESMTPSA id c20sm9220988pjv.31.2020.08.24.02.06.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:06:53 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v3 2/2] Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
Date:   Mon, 24 Aug 2020 17:06:25 +0800
Message-Id: <1598259985-12517-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add ABI documentation for mt6360 ADC sysfs interfaces.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
new file mode 100644
index 0000000..9dab17e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
@@ -0,0 +1,83 @@
+What:		/sys/bus/iio/devices/iio:deviceX/usbid_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 USBID ADC
+		Reading returns current voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/vbusdiv5_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBUS ADC with high accuracy
+		Reading returns current voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/vbusdiv2_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBUS ADC with low accuracy
+		Reading returns current voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/vsys_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VSYS ADC
+		Reading returns current voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/vbat_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBAT ADC
+		Reading returns current voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/ibus_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IBUS ADC
+		Reading returns current in uA
+
+What:		/sys/bus/iio/devices/iio:deviceX/ibat_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IBAT ADC
+		Reading returns current in uA
+
+What:		/sys/bus/iio/devices/iio:deviceX/chg_vddp_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 CHG_VDDP ADC
+		Reading returns current voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/temp_jc_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IC junction temperature
+		Reading returns current temperature in degree
+
+What:		/sys/bus/iio/devices/iio:deviceX/vref_ts_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VREF_TS ADC
+		Reading returns current voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/ts_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 TS ADC
+		Reading returns current voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/timestamp
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 timestamp
+		Reading returns current timestamp in ms
-- 
2.7.4

