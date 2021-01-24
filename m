Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD81301A59
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 08:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbhAXHn3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 02:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbhAXHnZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2021 02:43:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFAC06174A;
        Sat, 23 Jan 2021 23:42:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d4so5724113plh.5;
        Sat, 23 Jan 2021 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPXNniK0cP00K5qLPpxAIbnbN3Q+mjeyNaHpzJ+KH3k=;
        b=Jex54WQcRlFTpZN2fwJa/QxKmlcEAhBXWpPtHA1NNAmCGM25P5myEu12w18g9oAjuR
         6tzbdBAM4HHxQsZFo6JLgfSR6dor+tQRLv1cSOq0iT1PKVwn3b1WlrCW2ACu00f7PNop
         7R4Tn8zPqw4glojBYRvi5/G8zAQuBOhO+kOmve9ASbDkp/CQcoLTDZABorc4enyvGxV6
         RnEzyxRrgu7bkt0WRlkbXJnubY75Tm8Xsz4kXZe2qSWam5BZ1VNvHY8R/JjNEKrdGZAH
         X/89iOvzt+bUBs9Y2sryI+yUNzI/ddgJewNWGA/pzjrE33zr/lXAKmeI4Rq2z1FPNZx/
         2Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPXNniK0cP00K5qLPpxAIbnbN3Q+mjeyNaHpzJ+KH3k=;
        b=Tc5l/npmSYXiSBmMhuaMPWL02c0ee2enVqDfQz+w9i6Y4OmVOe8AyiwpTRyu3RyjdF
         S6JVxDa0xQ2BFAUEZ0w2VB+Trpdvu+8q2GkCdxJYNH0WzNdAp7Hc+oknhs8cvVSEogto
         X5xmXS2tKBvH4r2C6LCrowuXDO4YfWvBK2fXyVOmWEUBruoQ1bJ6VfYOb0jroqyFH+HA
         b40lwCnXws9UpHafjK1Jt0Qxru8Vp6vXpMoMV+y/deGIBkBacFxzUSp4+8mYo+Gj7FC6
         FSLlv0SLvL/YAH17X96pw+CtVsje9rBw3aex1GFrDbWlA3Y51JEBqoohOIUOAti/aSr5
         HFBw==
X-Gm-Message-State: AOAM532zRfwFEewUzWb366N4a8ojzODuXcYiD+MPcMP1Sumlxg+zmm9O
        CnhguafqTM5MT0hWCF3DKZvQUFDTFlHXmQ==
X-Google-Smtp-Source: ABdhPJzZtcDRcHASZ5YH8aHBB/RHmBfED/RGpYRciFBOqTNClxvK3RsRAKJtGqCiS+SkTtnXIcYrVA==
X-Received: by 2002:a17:90a:bd8c:: with SMTP id z12mr15274220pjr.204.1611474164512;
        Sat, 23 Jan 2021 23:42:44 -0800 (PST)
Received: from localhost.localdomain (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id k3sm12642449pgm.94.2021.01.23.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 23:42:44 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org, fabrice.gasnier@foss.st.com
Cc:     fabrice.gasnier@st.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, benjamin.gaignard@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 2/2] iio: Remove the IIO counter ABI documentation
Date:   Sun, 24 Jan 2021 16:42:24 +0900
Message-Id: <7af76c61a216771b20c21433801b548caa080250.1611473891.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611473891.git.vilhelm.gray@gmail.com>
References: <cover.1611473891.git.vilhelm.gray@gmail.com>
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

