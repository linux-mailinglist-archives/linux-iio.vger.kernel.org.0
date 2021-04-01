Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB68351866
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhDARps (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhDARkV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 13:40:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01351C02D54E;
        Thu,  1 Apr 2021 08:44:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4895877pjb.1;
        Thu, 01 Apr 2021 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7OE5i32xqp2hZR46nimIfKkiwZGHT1inF3gekHLXDk=;
        b=SpKmHRTJB0YwvLzZBV4ng2u4aIRSqa4wlNadMwbL7IhXlN+i18QZ6diB1fjjiHOceW
         aIpzOwMcBjM5ES/kjU6jx5jzDma2XZ3BVs9TSzmATxp+EMBXftIalt3Gvc8WAVinFobE
         iStmjpV2+nN4Lu4MLIXbzcBwwFXxP7U8vc2GHguS4sXg9h8sQC9/mOTy1NrJ+/jLesqn
         qr1bUm611OxLeYRYQT0F+tWy+ApLN13ULwVcWLmF2rWWKY9hXdlwz0bVDXBE6AVyQkGk
         jtqQZc1KQXss738+jFsKYQv4DX43l2QEGLYMCrmlkJ8jbQhmyPHkqXD3mPATz/WOQvAh
         FE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7OE5i32xqp2hZR46nimIfKkiwZGHT1inF3gekHLXDk=;
        b=K3wEG3geCOD7Bi1MTzv9fgMgHKTBT6BKvl2gPXP5wqv6lGtw6XRX1j4cMam+cXLuqt
         Pba3tJzRsPishJM39rcBNoHNqMx+HwbW7+rlzJZXAGxXEoCzDQtISzVNQ9MUyBXrRPEu
         3+lIOMK9thcw8Z5SZ7T+aT5mbdLcWWKa0sHU8d5zNQ1JHsI8/7W9f9x4oils/MPwtu6E
         uKiMkbH3oXBQAppilnPCB+ugHTc47aAAUMfTKc0b9eeLmT5yb0aMYCGeSguLRpdjauSp
         tRiNUdxE96BQk+rITFmQSf1KaEK6Y0luxBT2nk5X9/BE6FDYSRxYeobGoukDy+beZkB5
         Oh0w==
X-Gm-Message-State: AOAM532S3PlX74J7B16S/taLGyEB9FgS5HST74VnaA/eYZ89VLfJRi1F
        jkorje1IkolTpbzBzsJbxXI=
X-Google-Smtp-Source: ABdhPJyhownPWGsKaGGfB9TosD1NuukP+16rbvj9ZGpkWFPybd+q/Fjmx9cmapGv3WhXWBtPuZJIig==
X-Received: by 2002:a17:90a:bb02:: with SMTP id u2mr9676740pjr.175.1617291863249;
        Thu, 01 Apr 2021 08:44:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6307:8389:a773:d07f:cd55:994a])
        by smtp.googlemail.com with ESMTPSA id i8sm5957174pjl.32.2021.04.01.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:44:22 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: stm32-dfsdm: drop __func__ while using Dynamic debug
Date:   Thu,  1 Apr 2021 21:13:43 +0530
Message-Id: <20210401154343.41527-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

dropped __func__ while using dev_dbg() and pr_debug()

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 76a60d93fe23..95ec5f3c3126 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -198,7 +198,7 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
 	unsigned int p = fl->ford;	/* filter order (ford) */
 	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fast];
 
-	pr_debug("%s: Requested oversampling: %d\n",  __func__, oversamp);
+	pr_debug("Requested oversampling: %d\n", oversamp);
 	/*
 	 * This function tries to compute filter oversampling and integrator
 	 * oversampling, base on oversampling ratio requested by user.
@@ -294,8 +294,8 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
 				}
 				flo->max = (s32)max;
 
-				pr_debug("%s: fast %d, fosr %d, iosr %d, res 0x%llx/%d bits, rshift %d, lshift %d\n",
-					 __func__, fast, flo->fosr, flo->iosr,
+				pr_debug("fast %d, fosr %d, iosr %d, res 0x%llx/%d bits, rshift %d, lshift %d\n",
+					 fast, flo->fosr, flo->iosr,
 					 flo->res, bits, flo->rshift,
 					 flo->lshift);
 			}
@@ -858,7 +858,7 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
 	 * support in IIO.
 	 */
 
-	dev_dbg(&indio_dev->dev, "%s: pos = %d, available = %d\n", __func__,
+	dev_dbg(&indio_dev->dev, "pos = %d, available = %d\n",
 		adc->bufi, available);
 	old_pos = adc->bufi;
 
@@ -912,7 +912,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 	if (!adc->dma_chan)
 		return -EINVAL;
 
-	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
+	dev_dbg(&indio_dev->dev, "size=%d watermark=%d\n",
 		adc->buf_sz, adc->buf_sz / 2);
 
 	if (adc->nconv == 1 && !indio_dev->trig)
-- 
2.25.1

