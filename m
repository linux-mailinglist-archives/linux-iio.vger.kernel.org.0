Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40040661410
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 08:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjAHHsD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 02:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAHHsC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 02:48:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF7E23
        for <linux-iio@vger.kernel.org>; Sat,  7 Jan 2023 23:48:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so6223104plr.10
        for <linux-iio@vger.kernel.org>; Sat, 07 Jan 2023 23:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfZB2DF2HuhLEqSWwQJSiuUccC91huEpYPuVlI5VTIs=;
        b=JOvq0ZSpcE2cvSuaUwUdLcIJNgVX+S1KYgF5rynImmz0P93/1WZU0wccqgNVqadpVo
         azZTySpwyBOkGcCB+skVRaVcV1zL/IVRmMV90x5KbInPo7RwIKYSSWoPz8uSIqde4GsY
         m05ntoCqbYdlwkZPBKiYmuAIIdaRVaTTTFxl+EnenMEVNvsaO19urcSlrHk7hA7Ew4za
         JPRngVO+04KgZqNe57taYEfyR4xMJC2f6pMekck189rVqP050gaR58TD106Y9IuDhl7V
         gAOL1ztjxkFSCqW+uUwlHG7mlmGZtZH6gd/8nw3OK8uecYb798sYOB2wuS0HJbsFq182
         /FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfZB2DF2HuhLEqSWwQJSiuUccC91huEpYPuVlI5VTIs=;
        b=AJ95Rk1sY/juBPlo1cPUtDZUlQIwOvh56weKPN1MF3rJNISEqUnQmoMng+9qhvv+IY
         5RQ1dmbuV39o60o0XHebCOIygDzCISmuU55SIt51+7+6JnM28HGpToe/Z6uZU/BaYa0S
         Rc1cyco+kf8WJzJfuBlFwziBVQ/NINLAoaUCQyPuD2wxx3d+vmv8U/TOc/XW8o7XI5Q2
         8JHB8BG5GExyF//Q64mF5qBD39c9el0UShh6Ybd3iS4FctPJ+hS5Cfl+UxYoj1fEDweY
         NDDVk1dyHWuri5mfjL7jvWAEJylUhlAxG/UgOQwhc8lnSzZows7gKhzOvbkiL8qiW0p6
         id9g==
X-Gm-Message-State: AFqh2kqaHfaA3897DQgLJt/rUVJv9NAWwIv9TWTDPPt9vQzAmVcTuLSE
        UEGx7ZvlfodJ1alMLBtJGco=
X-Google-Smtp-Source: AMrXdXvVFDxYS7X+nm1X62pwou6xvLlNRMe+C2vCiSf28D9rH4S3HYxgpApSywuGdX8ClMihcJ7RWg==
X-Received: by 2002:a17:902:c189:b0:189:d0f7:dfbe with SMTP id d9-20020a170902c18900b00189d0f7dfbemr37521266pld.30.1673164081032;
        Sat, 07 Jan 2023 23:48:01 -0800 (PST)
Received: from morpheus.lan (106-69-189-37.dyn.iinet.net.au. [106.69.189.37])
        by smtp.googlemail.com with ESMTPSA id h5-20020a170902680500b00189348ab156sm3672212plk.283.2023.01.07.23.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 23:48:00 -0800 (PST)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 2/4] counter: intel: Depend on X86
Date:   Sun,  8 Jan 2023 07:47:48 +0000
Message-Id: <20230108074750.443705-2-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230108074750.443705-1-pbrobinson@gmail.com>
References: <20230108074750.443705-1-pbrobinson@gmail.com>
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

Limite the Intel counter driver to X86, it doesn't
make sense to build it for all arches if the couner
subsystem is enabled.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/counter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 508d857808e9..011e6af840fc 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -41,6 +41,7 @@ config FTM_QUADDEC
 
 config INTEL_QEP
 	tristate "Intel Quadrature Encoder Peripheral driver"
+	depends on X86
 	depends on PCI
 	help
 	  Select this option to enable the Intel Quadrature Encoder Peripheral
-- 
2.39.0

