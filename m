Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC73A368F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 23:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhFJVs3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 17:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231492AbhFJVsC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 17:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623361565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EskfVdmEpVOex3IAfBnti5Wx89Q+wzN0Zpd/qsC+eCM=;
        b=gVHGJHnsN/wkoVH0BNzslrOltTWz1FSaXr4Sy5uHFzRYE7TkSQ6TmP9PpSwOaS2i9oRXgd
        t3lgLeHnSvr3d9mGulmMFWdIznywBOTJV3I8jPhuLpB30Uuetb8MzGuH3TRwzhRC6Is9zL
        emWdusV4f4GBEf8DZNDWBRR2JFJ/aIU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-62wxyrxVMQm3tSafByloBQ-1; Thu, 10 Jun 2021 17:46:04 -0400
X-MC-Unique: 62wxyrxVMQm3tSafByloBQ-1
Received: by mail-oi1-f197.google.com with SMTP id j1-20020aca65410000b02901f1d632e208so1893288oiw.16
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 14:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EskfVdmEpVOex3IAfBnti5Wx89Q+wzN0Zpd/qsC+eCM=;
        b=Ca08NRRhUt9RtefdGGRsGAohH7U61hMfOXeLHuWXuBYQtyKjZz8VSysgdA4IXxJGem
         7aZwb/2Spq53jtevuAdqe84Qfg+gnWd6VZJ1400ODhHDktAf2QKf7/k5tZgxuyHyw36H
         R8GD62Mb0SgegdzW9unJMjvmyKP9WXfNT5ZoukQ4B/zZADfm9/uTMfV5S5gOaQtD2WoN
         WL70s9YFltezory8HTCykh5nKUBG9biIrAPisnXUiBo6esWji3WaCspI1ErLaSZuVHcz
         Cgr+6zmD/cIK6DR5T8HiLpGHMIyc4zqjLOkltCWbwKuh/s8pTTOeLGinDLYWuSUNQucA
         BzRg==
X-Gm-Message-State: AOAM531DgSrZ5a3KicKTVWc0WZImz7dpLXQQ74Hs5PIpgpkKDhW9R0LY
        SwT3NfaqZpWBT3DQInhFw3SPi7DVczMiTUJzMk636lya3mvno4TCasP/IIRSxkO7wWaAeP38Kme
        qZQnq2GvXrv2O8LxVu67p
X-Received: by 2002:a4a:b2ca:: with SMTP id l10mr508306ooo.30.1623361563882;
        Thu, 10 Jun 2021 14:46:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7SVUzlSK/f1fDrHG5iNpljzriPnaeQkhfspBLGN6ijrDdm2MtUq40WVdJ5HgW0VGYiWYtFg==
X-Received: by 2002:a4a:b2ca:: with SMTP id l10mr508277ooo.30.1623361563723;
        Thu, 10 Jun 2021 14:46:03 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i15sm881839ots.39.2021.06.10.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:46:03 -0700 (PDT)
From:   trix@redhat.com
To:     robh+dt@kernel.org, tsbogend@alpha.franken.de, jic23@kernel.org,
        lars@metafoo.de, tomas.winkler@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, nbd@nbd.name,
        lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        matthias.bgg@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        zhangqing@loongson.cn, jbhayana@google.com, sean.wang@mediatek.com,
        shayne.chen@mediatek.com, Soul.Huang@mediatek.com,
        shorne@gmail.com, gsomlo@gmail.com,
        pczarnecki@internships.antmicro.com, mholenko@antmicro.com,
        davidgow@google.com
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, Tom Rix <trix@redhat.com>
Subject: [PATCH 6/7] mt76: add a space between comment char and SPDX tag
Date:   Thu, 10 Jun 2021 14:44:37 -0700
Message-Id: <20210610214438.3161140-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610214438.3161140-1-trix@redhat.com>
References: <20210610214438.3161140-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

checkpatch expects a space between '#' and 'SPDX...'
Add a space.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index e8fc4a7ae9bc2..83f9861ff5226 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -1,4 +1,4 @@
-#SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: ISC
 
 obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
index 40c8061787e94..80e49244348e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
@@ -1,4 +1,4 @@
-#SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: ISC
 
 obj-$(CONFIG_MT7915E) += mt7915e.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index e531666f9fb43..0ebb59966a083 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -1,4 +1,4 @@
-#SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: ISC
 
 obj-$(CONFIG_MT7921E) += mt7921e.o
 
-- 
2.26.3

