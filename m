Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D8827224F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIULYX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgIULYW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 07:24:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A99C061755;
        Mon, 21 Sep 2020 04:24:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d9so8990225pfd.3;
        Mon, 21 Sep 2020 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QIq5NQbiNyJNm/We4OObc4q4pfsVdMirm2rHEjG4Osk=;
        b=ZXV0r5ujsfBgEEI1mQPi1uDFmiQWGZ2y6nflnAtdUj7oUDwMc01cIhgexwTptTXIb1
         DxnAnqtQa4C6Yx9AzxCUivwKU5bXaVy8YZ5U8ZJAipY6i8u2zTquar7Uyd+oqJkAWjdF
         oQm1+7bMKc4WZttqjl7tBUG/v98uYM/PmdCEvFvtM3jKUlyeE6YoiueH/YqE+KXyYthP
         hRS4wx8uNQxOH8N3AfJtumkQ7BlpOEY6SCJbTAUGq79LOKoDCF3pAyV/lFWKeyADZUPJ
         DvWlz2NAwvL8KfNFsREwIJpFcegfyhGClE9ShMZY+lZeFWh4aq8lltDck3XWCbTbpieh
         8g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QIq5NQbiNyJNm/We4OObc4q4pfsVdMirm2rHEjG4Osk=;
        b=iVY4LfBThzQUESQYKk1T8VX0u3EZvxq4PFtJlTrNdfV1VPtVk/86yxLbu7O4Xmsz30
         5Xu4d8AsrWxUL6PzCml+1l/Gzw8/gBZfgpigMyCqrIQaoSu2gNcaRriQO+ihq/6T1XwW
         SZSme1nmFUtspeknw7gDJcl9kcffxXUHWIhNwpgabMhSrsg/k++4It9AjAL8K5emZTqW
         IlVdN73SJOsP+nKe/u1szzsDGba0qliD2BPqetxuJEltXzJNISb0aKd5RU1p6mHtZyJJ
         o70yW+Daat1C7ee3cxWIMyCa/rbwAi8obkEE5DBrSbKv2mQtCeI0Xej3LiNkYA8XFiBn
         VDTg==
X-Gm-Message-State: AOAM530JRpSqIKviOpUakj4UaN+AJW5h6MIxPh9YZCExhayl0CqEXYo7
        gV7svOyEAPKrHKQSjYMqOiNSy2hy434=
X-Google-Smtp-Source: ABdhPJzpHl2i+Bs2FiYnb9x/88LedxgGsP9M0zGpxqxEF1D9DblywxDN8SqmtHED+a7Mw/T4Bm7zYw==
X-Received: by 2002:a17:902:9797:b029:d2:2a05:ceec with SMTP id q23-20020a1709029797b02900d22a05ceecmr2612801plp.4.1600687462135;
        Mon, 21 Sep 2020 04:24:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:8024:8a0d:5d5f:6f8a:a2bd])
        by smtp.gmail.com with ESMTPSA id x7sm9978663pjv.16.2020.09.21.04.24.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 04:24:21 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 2/3] Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
Date:   Mon, 21 Sep 2020 19:24:01 +0800
Message-Id: <1600687442-23658-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600687442-23658-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600687442-23658-1-git-send-email-gene.chen.richtek@gmail.com>
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

