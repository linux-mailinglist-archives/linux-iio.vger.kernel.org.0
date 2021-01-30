Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC83092CC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 10:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhA3JBA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 04:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhA3FFK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2021 00:05:10 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3089C06178C;
        Fri, 29 Jan 2021 18:37:24 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z21so7886404pgj.4;
        Fri, 29 Jan 2021 18:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPXNniK0cP00K5qLPpxAIbnbN3Q+mjeyNaHpzJ+KH3k=;
        b=RbYhZsnL4VMKvm6QpPE/9G5QwNofOtuZ2iZea/SqI/1PIK7tpakwr8tZ8Krt/CKNW8
         zagDeMeo37feTz6xRE9KY5zredG/1FS6UoSX7wsdVvmqKwj1+sLZgad5QBS7euop4LfV
         xkYuDNbA1JiZ/6nhNqHYFfTLexpOa8b5JiFMS0lKENeuZyNU/wwcwAuolQ5aCBsN9va+
         AKeNQ1+R+nuYmhEz1ay2JpVasxT5ZD6qIvHrr3xz0wID+/kq1ObJN2CjDyJHMFcuqWSd
         cA9CWzNVcf3x6I9BQ7Wa7Fmyr6f/fZBWzCg7RdqxtuKnfDKisqy0U2WovmhO4Ob+giA2
         xMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPXNniK0cP00K5qLPpxAIbnbN3Q+mjeyNaHpzJ+KH3k=;
        b=ANIAj7rNygOoe5GZps+LMUw8xm87a3+WWnj0NKfGaUONNzhRXlEXQTmCbqEvjVQ2eu
         dbLy0FydpuP+B+oJKNFuoyAIqel9K+RHaoxwuDISORDxuKe8+nZQsqKifSDC5y5wONCs
         PmMiWis33gU0Q6yqNspca0cF6UVGKfyPXwHEvT0+I2rC3DotmsXf0TZcbTjYgV6UYf1A
         Znb1zhw5wxWej7fIsN9CyMtK8snE/77gQ++o9TdrcC0VfWHB+DdNsZuKeMHf9cP5w6xr
         077cU0A9vLig5+3wyN8Zx83n+HJOggAIQxv+ApVX1I4Brx5kt5FVzKHhdtXHT0aa5h8k
         jsSA==
X-Gm-Message-State: AOAM531kqJ3dCd3ToqcQwM6BMH5/bM/UrQzSEnzK9a3qGfiGTFBmolMN
        KrhNfckqb6uHMAtz5vbK7A0=
X-Google-Smtp-Source: ABdhPJxmNYQ2xRyefxv6olIx9Kxeslfjhpr7Ldrxjn6aGFQNCSavhb6L7VIkYSQ9scZQiLiUA1IHrQ==
X-Received: by 2002:a63:844:: with SMTP id 65mr7198863pgi.371.1611974244452;
        Fri, 29 Jan 2021 18:37:24 -0800 (PST)
Received: from localhost.localdomain (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id s21sm8872169pjz.13.2021.01.29.18.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 18:37:23 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org, fabrice.gasnier@foss.st.com
Cc:     fabrice.gasnier@st.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, benjamin.gaignard@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 2/2] iio: Remove the IIO counter ABI documentation
Date:   Sat, 30 Jan 2021 11:37:04 +0900
Message-Id: <bc8b5b759592b013c197a98428c3f0141bedd54d.1611973018.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611973018.git.vilhelm.gray@gmail.com>
References: <cover.1611973018.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO counter driver has been superseded by the Counter subsystem as
discussed in [1]. This patch removes the IIO counter ABI documentation.

[1] https://lore.kernel.org/lkml/20210119104105.000010df@Huawei.com/

Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 40 -------------------------
 1 file changed, 40 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d957f5da5c04..c207484a86d0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1704,46 +1704,6 @@ Description:
 		Raw (unscaled no offset etc.) electric conductivity reading that
 		can be processed to siemens per meter.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Raw counter device counts from channel Y. For quadrature
-		counters, multiplication by an available [Y]_scale results in
-		the counts of a single quadrature signal phase from channel Y.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Raw counter device index value from channel Y. This attribute
-		provides an absolute positional reference (e.g. a pulse once per
-		revolution) which may be used to home positional systems as
-		required.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
-KernelVersion:	4.12
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		A list of possible counting directions which are:
-
-		- "up"	: counter device is increasing.
-		- "down": counter device is decreasing.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
-KernelVersion:	4.12
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Raw counter device counters direction for channel Y.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_label
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_label
 KernelVersion:	5.8
-- 
2.30.0

