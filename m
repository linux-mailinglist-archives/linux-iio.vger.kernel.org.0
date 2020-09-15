Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9399D26AC44
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgIOSlc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgIORhm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 13:37:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4488CC061353;
        Tue, 15 Sep 2020 10:36:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s14so271214pju.1;
        Tue, 15 Sep 2020 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2sltQ7OKUQCVV9G6bV9rSI99zwdlgVY44oFadVRn2CI=;
        b=eW+2TlyI52Z2+6zFckoS9vSKzJQkTC8U3eGSz6j9TYGbXFJOkHEAuoCYJGN3+JxY0b
         XoNwtfI6M8RaJU+B1imCAwaKqH11dmXfKa/Oqm1dQlrXOHdPzYDo6bo68WwB+k0FnHqa
         R0oLQ6al9qZvD/Zje34CJUuoihUl0SWdn+W77zqydjpQZHVkeB06LBgashDJxz1dKSw2
         lIsPy20LfMPxKqMoRp2Y8+EOgNbGd2mT6aDrtG/O7eOqHBs5wvejGjFetZ1YKpXoEmla
         4EHPv1mFhUKNjzpYTe+9/C/uMb67VGZ8w4gviB26VVe+xtJTaPX9Fk+3lDV86911mtpP
         Hijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2sltQ7OKUQCVV9G6bV9rSI99zwdlgVY44oFadVRn2CI=;
        b=gYemTtjXbn74skc3JE9mn8+0aiYE0ibFsfuFbgvWbYOU5s4Res97Q0PSTAeHeSLM1a
         GHxZ3flbrxvGY/3GhT3miRwGEkRqUWz9QIUiKz8zRlkBZp+L9HnqF6PJ7kcHHloucB8q
         okb4ZOOX54I4TLEO4un4RzGy0frMSpCBEW65IhKojxSF79wxzc9vWc8DEOA2DVvg9jF8
         mwNQal6IppTCXZyEhBqcQZpF/mX3sWeiPr2D+QYHgudotkax3EC4jsyI6HSRKg1/C8Ty
         ulDxDx80m6pY9LD5YflQi5ue+d1dd+jD2twUGTzgqwcR8nG7etJ0Wngauq8lSN03lG9B
         qXoA==
X-Gm-Message-State: AOAM532CDB3nRQ/ShSNPsZGSq7xoWzZqnppn59svMJj3QWSa8gguVsP+
        2tDNK3yJikQ5Hir2+tEU+CyhYkxZ5Ro=
X-Google-Smtp-Source: ABdhPJxae65aUF7nfySsPxANLHHZDhUaN/afvD7KfK3E+LliiIToUIYO7E15PckHd4LN3F4q7vFYtg==
X-Received: by 2002:a17:90b:198:: with SMTP id t24mr407317pjs.107.1600191381819;
        Tue, 15 Sep 2020 10:36:21 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id x3sm14025926pfq.49.2020.09.15.10.36.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:36:21 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v4 2/3] Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
Date:   Wed, 16 Sep 2020 01:36:08 +0800
Message-Id: <1600191369-28040-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
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
index 0000000..4b1c270
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
@@ -0,0 +1,83 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_USBID_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 USBID ADC which connected to connector ID pin.
+		Reading returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VBUSDIV5_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBUS ADC with high accuracy
+		Reading returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VBUSDIV2_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBUS ADC with low accuracy
+		Reading returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VSYS_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VSYS ADC
+		Reading returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VBAT_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VBAT ADC
+		Reading returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current_IBUS_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IBUS ADC
+		Reading returns current in uA
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current_IBAT_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IBAT ADC
+		Reading returns current in uA
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_CHG_VDDP_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 CHG_VDDP ADC
+		Reading returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_TEMP_JC_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 IC junction temperature
+		Reading returns temperature in degree
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VREF_TS_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 VREF_TS ADC
+		Reading returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_TS_input
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 TS ADC
+		Reading returns voltage in uV
+
+What:		/sys/bus/iio/devices/iio:deviceX/timestamp
+KernelVersion:	5.8.0
+Contact:	gene_chen@richtek.com
+Description:
+		Indicated MT6360 timestamp
+		Reading returns current timestamp in ms
-- 
2.7.4

