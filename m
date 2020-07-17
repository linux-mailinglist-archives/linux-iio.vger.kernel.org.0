Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7679F224104
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgGQQ45 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgGQQ43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75652C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so15954134wmi.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HA5KB0sL+kEMYPMfqRb/LMvZqE0HiKOu7GwHruCFgr8=;
        b=XYmAwbiceHH7jCfIcdW9ZdUBAKaLcD2MIwfgwFhIF7hoj781v/vZfidaXkIS3u7G/z
         LGK74R9BA+p931oPHmCKsFSQT/9Le7zJsVIhecUcsFC3tF3GBhERnuo7AyNPoGTshMuN
         DvxMvtHNy064UBqjC3eGlTL7HyKl7Bw6EZ+dnsddW0ngKs3QrZWGWFx/x4LmYlmcHggg
         6p9spcXFsX+7E4AKzyakXst+lzt/e0Bk8hH9Tocpwujhjs5dc7pXZEDF6LosYeMn2sMP
         uBmlAekKAF1qAeKtkvXIml7kAyT6CmKgxkCpTSF4/rqD+df0W9nWcoP+ROzG25xOlX39
         M6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HA5KB0sL+kEMYPMfqRb/LMvZqE0HiKOu7GwHruCFgr8=;
        b=lfcawG9XdTs4udfcT/MC3J2XI5v1ghTeVbDhxb4vBXhxoWNxaF9z63+TrNESc00APl
         a1sVldJk+e+5URw9LCzPxYnDPV+wnYbvyxmnGQvUncZypNss0vgE0kwAPftHhzNIasiW
         5we7/35vcK6ozZrnFtVOUyKiGCQszfFh14A29b6KcTgtBRRGh2FJi8xcYW41xWN2q/Y3
         hU4mhqdvhd7J7UDZd0YUer4wOMELq3r7zqTpnD7ywog7efXQNtHJstuH8VoNX6qt2VQv
         FkXsUpdEXNYOo2B2IkPcMWdZZ9WZDnPGtyRjOGFtGTTceWVPXqJhcDqgJ+h8Uu81hObG
         fdGQ==
X-Gm-Message-State: AOAM530gyWvOSKs3EUnOTGxJbg7J9nAEJI9oYJoR5SGa9HpnfZ3pe/Ev
        N5+09R62pTceUEMzatFYWgVsWQ==
X-Google-Smtp-Source: ABdhPJwk96D/etDyzrzif8dB+/0xJfCPzpvzLJ6j9vx1QxRMZQs/rb8F3g2zzaRoqCFrli23m0pveg==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr10556037wma.46.1595004988192;
        Fri, 17 Jul 2020 09:56:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 27/30] iio: magnetometer: ak8974: Add description for ak8974's 'scan' attribute
Date:   Fri, 17 Jul 2020 17:55:35 +0100
Message-Id: <20200717165538.3275050-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/magnetometer/ak8974.c:200: warning: Function parameter or member 'scan' not described in 'ak8974'

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/ak8974.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 91c39352fba26..4d6d8b699f037 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -180,6 +180,7 @@
  * @drdy_irq: uses the DRDY IRQ line
  * @drdy_complete: completion for DRDY
  * @drdy_active_low: the DRDY IRQ is active low
+ * @scan: timestamps
  */
 struct ak8974 {
 	struct i2c_client *i2c;
-- 
2.25.1

