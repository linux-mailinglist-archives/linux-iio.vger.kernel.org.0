Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50C1AD900
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 10:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgDQIu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729941AbgDQIu0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 04:50:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E44C061A0F;
        Fri, 17 Apr 2020 01:50:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so890101wrw.7;
        Fri, 17 Apr 2020 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2W4UC3XoSBhMgKjDSt7PXbJ9u9A1KBNdB31+oU0yG+c=;
        b=LflP60nJ155kVwRRRRmvYgrxV+r4zteD1QlseoDQyql6JWMWisDG33oJ75/X7LZmNK
         EKVdX7wVS7mhtedNHvaEOPwRcEL1OjAvzo0KypfDAW8cRlj9me1YcmO0eXd336Ww/Ww1
         hCV+LTcOj+kItuxhiDr3pfiCXCE4K+0jf8Qi8VeHsdiPOC40FMUxHFoycNWQeqhKssp9
         BdUFV+FXmti4ypdc53XGfBftv4SCw+IrRQP7cxnNraY3dA5aSQpFMahltbnM2lhQ7K3T
         DoUaqI6lCSqT01DksEcfYHCiMNsNBx4LmylInYlrTqKbTfx/LzdrU51mWDrhyf6yRyd1
         iGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2W4UC3XoSBhMgKjDSt7PXbJ9u9A1KBNdB31+oU0yG+c=;
        b=HlV+Tf+kEBa5b9zI3vd1MJKB3UnJyGkIqSqTZ/klXyBM3mrHVkSWD3tR1F6iyDZm2N
         P827XvT6g11RZYpdyTZl9grKHguKQ81DWz60K8x/NGKchJQewbsCKnAupdyiFR5H+9zl
         ZPRT7AVZQegG9tEXFIVequ8qWx8cDLX+5fSfQtS1d3jCHCC74PCFoJnFCr+faOPE8Gf4
         arQt/fmwENtAuBXUaA1egVKYSP6uGEziSzl7cM2A3NbRO8xwYYlYOwA+DjjFKWaKwi5j
         wc8mQyD/y69XxyLdRXrzqPXiJSXpjTxo2bUEG20wLa9Lzd4UevLP1hBn2H0HwQpLiSFT
         njWA==
X-Gm-Message-State: AGi0PuauC7IwDrWC2t5D0iPQbVWh4a5RkxOq+AZEP1C6GufcjxmKPWQB
        yJcQoMe0jIngWxRzZ3SDX6s=
X-Google-Smtp-Source: APiQypJGknih8CDnfhLewE2PcY8h2h0cn7bLJCX+zTf7JzNGL4mUDgoi5LVeRl+QwZJnzBh8nEJZOg==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr2680761wrw.318.1587113424987;
        Fri, 17 Apr 2020 01:50:24 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7443.dip0.t-ipconnect.de. [91.63.116.67])
        by smtp.gmail.com with ESMTPSA id l5sm6807527wmi.22.2020.04.17.01.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:50:24 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v10 5/6] power: supply: mp2629: Add impedance compensation config
Date:   Fri, 17 Apr 2020 10:50:02 +0200
Message-Id: <20200417085003.6124-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417085003.6124-1-sravanhome@gmail.com>
References: <20200417085003.6124-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allows the user to compensate the intrinsic resistance of the battery
to accelerate the charging cycle.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-power-mp2629 | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629

diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
new file mode 100644
index 000000000000..327a07e22805
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
@@ -0,0 +1,8 @@
+What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compen
+Date:		April 2020
+KernelVersion:	5.7
+Description:
+		Represents a battery impedance compensation to accelerate charging.
+
+                Access: Read, Write
+                Valid values: Represented in milli-ohms. Valid range is [0, 140].
-- 
2.17.1

