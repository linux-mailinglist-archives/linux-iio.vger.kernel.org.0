Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04523A3687
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 23:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFJVsE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 17:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhFJVrs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 17:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623361551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8OLwWcydmQrpMr98JXIDo8D3KC7riTE8VF0bgAOtZQ=;
        b=ZhXXbV2wwfaDRjVkHsl0mBJAEHAISM8iUHLVnXYyvxcmOn1fyfwlopf5eAYb5a5uueOlCz
        z8ee5KzU4SU5uwAP3jmbsB5D69ShsEJn3BKPztbY2jJhLdwsaxlqoPO3rkOzPoW8LkM6p8
        VAsQv6o22+20/Foqa6P1U3yw5sVNP8c=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-WRJUxNJVNUiK3UsqvdmiTA-1; Thu, 10 Jun 2021 17:45:50 -0400
X-MC-Unique: WRJUxNJVNUiK3UsqvdmiTA-1
Received: by mail-oi1-f197.google.com with SMTP id w12-20020aca490c0000b02901f1fdc1435aso1887871oia.14
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 14:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8OLwWcydmQrpMr98JXIDo8D3KC7riTE8VF0bgAOtZQ=;
        b=DInqPD6IeEpZ+qdh8OpKDtIOjaJo8WAY3wkUv77V5NgcPSsGcCRC09ihu8Im+SBi+x
         4/46/dhb3bumXziouWM6/yxxeOQkZvjZeav/PlbOCz4wsak73hF78Q5euPE6foKh8RBs
         7Wn/uBG49r6NyVGpR6jhACXqy7NDSc6WIRRldNCh1GVhi1m9/n1JNUgwic38K/BumDjP
         CCIhApmw0WQJdpYiXZmmU96G3KG+Z6GqUI0rb1GxXuA6LB94f2ZLcez5tS1hWor4jOhi
         GrAKEb53qRWCBcbDjS/JX+63MX3le2wll3VcNPUuq2P0mwSUE6PVtU7ewiOho0ODUU1O
         /shQ==
X-Gm-Message-State: AOAM5319ymy9qO1JXACfGh7T3CPFKnD0Uwbfu84rQz4T/Bih26nj9aDK
        wjdPQ2iato+gQc16shlNsnY38BjevW7Y7hS0PvbqA3OrFQYDMoYJyUgmSmIz9dki2gH7Gow2CYM
        iuKaSGehYA9L8hJNK3UJG
X-Received: by 2002:aca:e057:: with SMTP id x84mr5132574oig.8.1623361549808;
        Thu, 10 Jun 2021 14:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLlHvZFtWFFxENEp0wDljEClNcJJVqS2ZhXs5nt3LvfBJs1wbUwA8ID2fcLwIpQkKP9sNHPQ==
X-Received: by 2002:aca:e057:: with SMTP id x84mr5132562oig.8.1623361549673;
        Thu, 10 Jun 2021 14:45:49 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i15sm881839ots.39.2021.06.10.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:45:49 -0700 (PDT)
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
Subject: [PATCH 4/7] MIPS: Loongson64: fix spelling of SPDX tag
Date:   Thu, 10 Jun 2021 14:44:35 -0700
Message-Id: <20210610214438.3161140-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610214438.3161140-1-trix@redhat.com>
References: <20210610214438.3161140-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

checkpatch looks for SPDX-License-Identifier.
So change the '_' to '-'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/mips/boot/dts/loongson/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/loongson/Makefile
index 72267bfda9b41..5c6433e441ee4 100644
--- a/arch/mips/boot/dts/loongson/Makefile
+++ b/arch/mips/boot/dts/loongson/Makefile
@@ -1,4 +1,4 @@
-# SPDX_License_Identifier: GPL_2.0
+# SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64_2core_2k1000.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64c_4core_ls7a.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64c_4core_rs780e.dtb
-- 
2.26.3

