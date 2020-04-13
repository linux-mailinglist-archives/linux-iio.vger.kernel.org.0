Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABC1A6B6E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbgDMRhQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732876AbgDMRhN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 13:37:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7BC0A3BDC;
        Mon, 13 Apr 2020 10:37:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so10055794wmc.0;
        Mon, 13 Apr 2020 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJvsfKsMnt/X9Nzxg++jYAolf7LD+g/Z1b76iH73i3U=;
        b=PgWv9D4ExGDMpPseahRf3wQBBneUgnagl8ib7Au1jBonjNWWeQYRa9rvuBjmY5773T
         +AWCD4yUY5JogNkwgCK5zoq8ZA948YmtUq/+9pBqy33uNWdFZeUEPHLPQTKpNT2OFb+5
         WQDYZfd/LwX6coTmog3RvV/xwe2MOQaF81pGeMJI7xskRyJQwMqB9sYZ6Zd3kEHH88fw
         FUY3Kt3DrxvJOTO5GJBy5rDfDMvZSaptj+7jJtQtNT19XoJOFsMbXMQBXq43gRnrqyW6
         mCabi7S7R1LbvlzW7rm/5qz5URSFlQADee6o55A4q++X9S4zWizP7fkp0jpaXRUFztdm
         Q/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJvsfKsMnt/X9Nzxg++jYAolf7LD+g/Z1b76iH73i3U=;
        b=UluiBoquM1mWEEdqrqIcLurCFKatJmX/OjYuSvSn/qGft4hCL6dvD+U3fbaYhefkPC
         RKI5wHqFxw3+rwXXV6FPg2D3bCicZKI7Fke0Q9LVARJL0/iM4D5EyJn5MbQa9rJNFnx5
         Mt8SPOrJJdrp8eWndgCrXpayWbda4zIyfZnYLKzEtfXYoSemqbOLgyFsVs+D40Q1LPut
         f3Pi1xrMTs+bLmItxqRQSYI7u/QozTt+4K+PODBIBNlXcERB3lydb3ex0LBzEE9EMpfW
         5WWhB/zmrLT6Vc94JIqUgshzbhY5u0WsDr1T59kXKb5em9QTVwgSIJPmLDt47bfNOSf+
         z02w==
X-Gm-Message-State: AGi0PuYqwaL9xEc2DZ90uDmVax6moeFtxDMGK3DE4siFoxVvCxcI8vWc
        yVV1thk/u9P+yA3+cdsObxA=
X-Google-Smtp-Source: APiQypILyrh7qXLb2k9CC4tX3cyTdg/9b2XUdW3iGtIm0qwRBy1+ocTtQxm5GzEsfW97jEbvmLIzsg==
X-Received: by 2002:a05:600c:14d4:: with SMTP id i20mr8653509wmh.118.1586799431406;
        Mon, 13 Apr 2020 10:37:11 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6AD5.dip0.t-ipconnect.de. [91.63.106.213])
        by smtp.gmail.com with ESMTPSA id a205sm11141465wmh.29.2020.04.13.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:37:10 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v8 5/6] power: supply: mp2629: Add impedance compenstation config
Date:   Mon, 13 Apr 2020 19:36:55 +0200
Message-Id: <20200413173656.28522-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413173656.28522-1-sravanhome@gmail.com>
References: <20200413173656.28522-1-sravanhome@gmail.com>
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

