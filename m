Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8492C1AADC9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415585AbgDOQUu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415580AbgDOQUs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 12:20:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4F3C061A0E;
        Wed, 15 Apr 2020 09:20:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so251467wmc.0;
        Wed, 15 Apr 2020 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJvsfKsMnt/X9Nzxg++jYAolf7LD+g/Z1b76iH73i3U=;
        b=UXbwG7VwWcDYrb3qn54jULbA/wpblCCK5887+/nEnxIbfM4bi45vlyxZbrrV9CxWRn
         cgLmpw99ql0grrb6uIJ0/LSmF3jjwO/JjKa8EI7y4QcDfP32NDJzugDshCmANcoKTCVX
         GSu/AR5YjvwEr/rVyVpJKQrO068ADW2ttJdiYgCBoQpmxdi+WZY7lUdiyMrwmz2HfrFU
         tuE5xzXmYu+1bRrTuMNqfbQhNQYSJyhSuXFLOMw05C1rsfm0bCBu/PjRa4OtjHF21qBt
         gxH1bwFu8kXvTY1kMYcZHxktL1pJSRp4baWzoA9AdNdDGwhYqCWBNWWaRqxSkpPjia0J
         s+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJvsfKsMnt/X9Nzxg++jYAolf7LD+g/Z1b76iH73i3U=;
        b=t4P+9n6CRw+E3a38A0q0hthP/pKlmiCBwc36eXeWIdGqDeDI8qhzRY0ysT0s6IM+ly
         miZsJe0CnJvwCSoESKDfHI+LxllWpCoRqq7aGkr7AM/OYurSStISlVQC/Mt217tRB7GG
         BOko3NohW+FPKI6GAIsWONVBYlYEE6CBiG+PQB6aRkoliPNGWIrqwFAPM0TEziAjmjt2
         z5GuG3DzDwcRJHPIPBVEQC2OnmxmsMzFV2pvH9geBkkwgTlJcXE+AcidqdZc6or53pAl
         NjTRFT3MK0bxdJ7QtggKouCWEzjdf1wQxreanuGh2RbhvZoBs9xESyWS1JN5EPvXETuy
         6UZQ==
X-Gm-Message-State: AGi0PubBakebP2rXZM3oDZ9CmCwegox+6c95FqTUeY3BkBou7bA4zgOM
        Ye4dtCzKwM3b8LahtLS5vmg=
X-Google-Smtp-Source: APiQypLLN/feeTEuTQwED/+O8MgvTjyWtZYdNyYVTVyJk9IBRvqqxvfCIALXnWeOEGSR9H1Ui9pS+w==
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr6226769wml.151.1586967644953;
        Wed, 15 Apr 2020 09:20:44 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6CCC.dip0.t-ipconnect.de. [91.63.108.204])
        by smtp.gmail.com with ESMTPSA id 17sm102526wmo.2.2020.04.15.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:20:44 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v9 5/6] power: supply: mp2629: Add impedance compenstation config
Date:   Wed, 15 Apr 2020 18:20:29 +0200
Message-Id: <20200415162030.16414-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415162030.16414-1-sravanhome@gmail.com>
References: <20200415162030.16414-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allows the user to compensate the intrinsic resistance of the battery
to accelerate the charging cycle.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-power-mp2629 | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629

diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
new file mode 100644
index 000000000000..7b7c0e7a7c45
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
@@ -0,0 +1,8 @@
+What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compen
+Date:		April 2020
+KernelVersion:	5.7
+Description:
+		Represents a battery impedance compenstation to accelerate charging.
+
+                Access: Read, Write
+                Valid values: Represented in milli-ohms. Valid range is [0, 140].
-- 
2.17.1

