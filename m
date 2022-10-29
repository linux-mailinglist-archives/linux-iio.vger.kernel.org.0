Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D026121DA
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJ2JaQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 05:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJ2JaO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 05:30:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F75C961;
        Sat, 29 Oct 2022 02:30:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h9so9475681wrt.0;
        Sat, 29 Oct 2022 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkJrpxcP48TMk8lHsqey+h3jqmE5YwXV+ijLJdBnXvo=;
        b=HmwqAQG8Tk2v71b7VEjnQad2cz+Fk8YUMWxxRgn+QXvgJo1COCuAaQ62WwbZIAfVUE
         5wrax/x9Rp8ADIzqWJOfiKob74lIeLPIg5OqRohmQBhyFVq5LDEM78nPZSO13e1AQtHo
         lhY8mStRWxuunE/f5kFZZ2tg8yq17oP+8Iql0HZPpSztVLv6VsnLLNqjKBQ7ii51ecva
         skLeXirsN6TUMQi+hv4xx/v4vHVSK3Kpw8K1Ic8+rkasZMQjbLzYXPycwWo7otctY9+Y
         /T8MiLiMgopDjP29VHzWvS6/k9lVw9i/BKI5ccGRNyi5t6onpmPHeKP71xTMtFzmzyPP
         rJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkJrpxcP48TMk8lHsqey+h3jqmE5YwXV+ijLJdBnXvo=;
        b=FHvqAMyUdXDHzSP1JnEMNNerA+kEG5VwwwDfDBmmyAWk3WYx3PeagnxOlYyQEJyIZb
         xGKrrnJqG5NBzPFATgx6E3nNm88OQklFjZ5MREV/V46xEY6uX9/9k1nqMVWhhQ8CP41X
         wk9WR+w3ZtS/Wrz51LI0xgXcFlNNV/DxQZe8iZrZhKT1NqqGAANu2zfO8quWfOFXpjEG
         gWWUNwhJH1H5U6vQsw3ygEiUWrrGOkl1ST4GZHfPurxl8G9kEpBonss0qVZMszhkMJsY
         KUeHzDfD5bpjVuDRcTb8qaXFwTNdMikZKkCyx9LXAfY29EesBe1rEtL2Pb1LU/C8/z2L
         03xw==
X-Gm-Message-State: ACrzQf2ieCLUOHrbvcYDCuujf+Jlqd5YhhFYdcNyo+ZnL+9URaINP14z
        rzeVNW6XLI9eopLHwQD3uPc=
X-Google-Smtp-Source: AMsMyM4m0SgvZTbNuPJIGzE2zVDyx5FULFr7VqyeQN/rq6FUbBUwhynXpCEow9/e/64lsyj2yanGoA==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr1844035wrb.466.1667035811519;
        Sat, 29 Oct 2022 02:30:11 -0700 (PDT)
Received: from discovery.. (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm1068187wrr.8.2022.10.29.02.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:30:11 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v5 8/8] power: supply: mp2629: Add USB fast charge settings
Date:   Sat, 29 Oct 2022 11:30:00 +0200
Message-Id: <20221029093000.45451-9-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221029093000.45451-1-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allows the user to change the USB device fast charge setting to advertise
host on enumeration helps to accelerate the charging cycle. Altering this
value resets USB existing connection.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../ABI/testing/sysfs-class-power-mp2629         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
index 914d67caac0d..b386d02cb010 100644
--- a/Documentation/ABI/testing/sysfs-class-power-mp2629
+++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
@@ -1,3 +1,19 @@
+What:		/sys/class/power_supply/mp2629_battery/usb_fast_charge
+Date:		June 2022
+KernelVersion:	5.20
+Description:
+		Represents a USB device fast charge settings.Altering this
+		value resets USB existing connection
+		USB DP:DM[0:0] 0.6V : Hi-Z
+		USB DP:DM[0:1] 3.3V : 0.6V
+		USB DP:DM[1:0] 0.6V : 0.6V
+		USB DP:DM[1:1] 0.6V : 3.3V
+
+                Access: Read, Write
+
+                Valid values: Represented in bit DP & DM setting. Valid
+			      range is [0, 3].
+
 What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compen
 Date:		April 2020
 KernelVersion:	5.7
-- 
2.32.0

