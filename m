Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3903C1E1DEC
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbgEZJH1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbgEZJHR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:07:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C3BC03E97E;
        Tue, 26 May 2020 02:07:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z5so23018541ejb.3;
        Tue, 26 May 2020 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gzEuLfFr2Wjs95fYZslmPG3Xyc/Bgbx9OTSru/pSe2k=;
        b=PkRvqCOaFREZUk8gLbv3Us4ZkOg3l9OE5HPZcal4kaM1HIM6mqzt6s+iKh14CoYZ0s
         xo/DiSkEU17sZ6icVpANrdzg7vKZgkTOng8xvJF0mLwDRiD0ydT7mVPu+e1ubT2odUbu
         KLsVGlNpOaFCgCiaMYSFoMrdPkmMaa3/xAV+L4/4w/ZjmEr+FPPmoaeaQS1ZhEIPM2dj
         pbObtEhcLRvv9XdmmFVkGxRThtXTrW6Xl0OECeLj4tQjHV9mHP1kTiWvOPztpGUw9xJC
         Y74eXzK3jAmK8Mffk6Xiq0FtOLvYb6uYmCtgoQ+4bhMqfUHvqqbnLneOdqRxmZhYXdHm
         QNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gzEuLfFr2Wjs95fYZslmPG3Xyc/Bgbx9OTSru/pSe2k=;
        b=N1ums+DDIv6KLUDLuJya1JaEoKOdTtBXws93iqbhweVdecCfKr0xxQvQIj6Byzjfaa
         92sOcEVLf+by2p3BXmLjhxSaGau+Q+A6+VmLXJ04lhJRRHmd03HBSIGdpCMfwhhKSd1K
         vdWOQE+fz3ErPcnxeoGPuyFwHIayyoUuUgY2Va/pgB47knvVjLCV5ztt0gyZREbNLm78
         VODYUOk2qSRmJ+QjAFa0cTq0Jyy6LB28Pz5D2cCiETtA/m+P/TPPEFtaWbMuJLwwneeF
         /NmQMStlkYpzZYmOwOfQlvszCNRsyNeiHMItZx7f/6H0lrQ6v7kd0L9CoW1RfMPYltxo
         9MYA==
X-Gm-Message-State: AOAM5311olDuzbmT6DonVOte7wiGBgknKVIPK3R5iPZPbMdexC8T5zLc
        gMG4vVmi7pADSp7j3gFDA48=
X-Google-Smtp-Source: ABdhPJwODaPkJiuguuh2+j7FRF49SSw0Rt0HucdH0U3PQ6WTM/j3YCsPOAIGu7vlRFjjwTwayZM7Qg==
X-Received: by 2002:a17:906:b79a:: with SMTP id dt26mr228324ejb.121.1590484034689;
        Tue, 26 May 2020 02:07:14 -0700 (PDT)
Received: from localhost.localdomain (p5b3f6e09.dip0.t-ipconnect.de. [91.63.110.9])
        by smtp.gmail.com with ESMTPSA id c7sm17870535edj.54.2020.05.26.02.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:07:14 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        sravanhome@gmail.com
Subject: [PATCH v12 5/6] power: supply: mp2629: Add impedance compensation config
Date:   Tue, 26 May 2020 11:06:45 +0200
Message-Id: <20200526090646.25827-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526090646.25827-1-sravanhome@gmail.com>
References: <20200526090646.25827-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allows the user to compensate the intrinsic resistance of the battery
to accelerate the charging cycle.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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

