Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB41C0104
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgD3P63 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727841AbgD3P62 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 11:58:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2FCC035494;
        Thu, 30 Apr 2020 08:58:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so2527248wmc.5;
        Thu, 30 Apr 2020 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2W4UC3XoSBhMgKjDSt7PXbJ9u9A1KBNdB31+oU0yG+c=;
        b=Yz3hOTd/manN9dw9O4HKNvHUWFTSos0gEPtogcWOuq8F1cSFeLZxtO0kPiNh6F0yR1
         04CzvJfEV367cXG8OGTLb77uF1L4uSEq4GQvwAUyI6SA2lDeOqIhDfj0EQPTpNx17oes
         lS36+KbbLFCACIQu9FwmmX5HF6iYcXq+95TZk6mEvG1FneYlztaSFiEvs/2AL/aXZGi3
         yiPZz3VHgq3i6aKADg5nu1GoAb0EkgsE9b7Ak+WBQYAWaNyQNpVl/IqptSOidb+SI9ts
         8ehsYa3IluK0/qf/CzC06jsIESMzu0W35WJVzUVWb49FETadmlo4ZlzUNgouQimTYaoF
         8i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2W4UC3XoSBhMgKjDSt7PXbJ9u9A1KBNdB31+oU0yG+c=;
        b=eenF/MoepBIv260FihIwofnmYKIx82E7aWT2iAtNA7I677cddJ6NeJrrY8VHpuuGUV
         odzQGb/5KIBncy5Ys1kzu2+in2Vqi6ESMjrekSzeUKTnGekg7oLmzxEH28DV6jFzjeuC
         NACYaDwE9KhlAwR9XW703Bx00+IHmvFC0vjBrdinbddkdI7l+Uj7KSRVTKVvQan9CNMK
         s/uhBrQAxFi6ufjpor7j4CPdJ1n9OG3lTwMjj9BkJbtXv1qhw7Rcv57qelhv6+95F3nK
         2JrdtTyzBuuO+T9x5g+RkOGiX8QaSUPay+w4QVTRN9CRFd1FE/DK4kYpv4tJR5RCjHCs
         v9Bw==
X-Gm-Message-State: AGi0PuaBbbQ8cKFoaGcqu8a4JaQ5WsmZxPtFKEbsha5iDqZ6RXmhT7mA
        EdRq1X24X6HdTKMHRBeWVeU=
X-Google-Smtp-Source: APiQypLW9lUdht60B0V46uAQDEg50o1yM+LrDwVBJ7NTeJI9GFR5bdXexAi6yXzuh68NePZ79VRUUw==
X-Received: by 2002:a05:600c:1109:: with SMTP id b9mr3685870wma.116.1588262306502;
        Thu, 30 Apr 2020 08:58:26 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6E9D.dip0.t-ipconnect.de. [91.63.110.157])
        by smtp.gmail.com with ESMTPSA id w8sm265410wrs.25.2020.04.30.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:58:25 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v11 5/6] power: supply: mp2629: Add impedance compensation config
Date:   Thu, 30 Apr 2020 17:58:09 +0200
Message-Id: <20200430155810.21383-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430155810.21383-1-sravanhome@gmail.com>
References: <20200430155810.21383-1-sravanhome@gmail.com>
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

