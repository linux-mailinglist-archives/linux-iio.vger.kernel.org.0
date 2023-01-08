Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94A661412
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 08:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjAHHsI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 02:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAHHsH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 02:48:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8766D113
        for <linux-iio@vger.kernel.org>; Sat,  7 Jan 2023 23:48:06 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c4so6249943plc.5
        for <linux-iio@vger.kernel.org>; Sat, 07 Jan 2023 23:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmwbTz4RA59zmnnHe5FcsOF1iYy0DkCMIQNRas3zggE=;
        b=GV+ZrTFZWSy/7amzFxr+lD7l5oNfc1OL6R9WNBc4FXNfnn8gaqrpXqjB7aSnDOODM2
         D0h7nSvKOwgiOlLT3YK8cQP/myoglQhCirnUrW1xYIiqIVOBd+47pI+Y6bV5hKLW5iOF
         r33lEmUivQyDoC02/QhI4t38xRgPOvrZp4CNKyVtok0GvLhfDKDpAXKx0etVFUW2BryD
         g0Rt7NHoGX6iMD3WByFiBFFCIQvopheTkqisGoLbnufHYUTuekR3XODDCNZs1+XQjNXG
         2Enw73vBzXBu2oistbywv4aKvn02eZwYAK2cMcyrJLdtcViVBYLXi5yyUlat/kJR8OHv
         H+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmwbTz4RA59zmnnHe5FcsOF1iYy0DkCMIQNRas3zggE=;
        b=sl3x96/237BPdIY+Hf2p0vaeezKri38YBfIcgX8DXwn5DiljxhPFF3DuifnmLjHuFs
         6i4EWDWZXl9HQa5vosYVdWPhd8VBsWIi37k/SreZDfN1u/EsnRZi1l2T0O0F/4V5ALTp
         OlPsjVDmDNF6tNx0HmGstDwHVaBJiKtMXz9C3gzYWyhtOjuxRva90WHRttJnecTx0DyB
         r1rwdz+IVKAPHuUKyb3ArZRW5O/ganK3LZiMiH0KIsRvrlA6WsqASgG1A1IoKjjqz+Xu
         a+hccliHj4eV5VC3RF7zR/e/3ZjaB27Ub3rvIB1ICUcSfs9H04YBbvux/NM9WpCAQud7
         E99Q==
X-Gm-Message-State: AFqh2koaa5LG11zUSnT3jWD2n4OmU/8u/t2F6GDuRwCX8tqAfnHxavxb
        UanIBfgedL9ARL0NPJsq5L0=
X-Google-Smtp-Source: AMrXdXtEAPhuieht2VGPlAJaSFf2BPXhS0OU+yAz6DU2Tc6WBlkhA6Y7CRFgXW8Eeu1J/1TgKJ1LPA==
X-Received: by 2002:a17:903:186:b0:188:d2b3:26c1 with SMTP id z6-20020a170903018600b00188d2b326c1mr81832206plg.10.1673164086443;
        Sat, 07 Jan 2023 23:48:06 -0800 (PST)
Received: from morpheus.lan (106-69-189-37.dyn.iinet.net.au. [106.69.189.37])
        by smtp.googlemail.com with ESMTPSA id h5-20020a170902680500b00189348ab156sm3672212plk.283.2023.01.07.23.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 23:48:05 -0800 (PST)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 4/4] counter: microchip: Add appropriate arch deps for TCP driver
Date:   Sun,  8 Jan 2023 07:47:50 +0000
Message-Id: <20230108074750.443705-4-pbrobinson@gmail.com>
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

Add the CONFIG_SOC_AT91SAM9 and CONFIG_SOC_SAM_V7 deps for the
Microchip SoCs that support this IP block/driver plus compile
time testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/counter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index ef78386ccd2e..90602536fb13 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -63,6 +63,7 @@ config INTERRUPT_CNT
 
 config MICROCHIP_TCB_CAPTURE
 	tristate "Microchip Timer Counter Capture driver"
+	depends on CONFIG_SOC_AT91SAM9 || CONFIG_SOC_SAM_V7 || COMPILE_TEST
 	depends on HAS_IOMEM && OF
 	select REGMAP_MMIO
 	help
-- 
2.39.0

