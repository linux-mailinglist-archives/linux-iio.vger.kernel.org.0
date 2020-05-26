Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92D1E30DB
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbgEZVCu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391600AbgEZVCu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 17:02:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE8C03E96D;
        Tue, 26 May 2020 14:02:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so3830474ljn.4;
        Tue, 26 May 2020 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpnokN0i6iCHNbK3Hq2vncfPsrhaFuH0/YJmD+o8wI4=;
        b=VxLVlL2uJgD4tEuJ8HJ+1wJG6gimbOIOkNBoSiNo56Zxq6cx5bVNYR3llSszhnkNzR
         GWC8MtdB/XsZYCrrOxgFMNWnwJhoa/zeDbYM6BTdBD2huTi9BMsANoA5oETumPKoVidv
         xN10EHuwJ7jjzU8ZbF9+eSkx9HlhHDt9FhueIoda+ZK4BkFBA4Nz/WmGTBDSTXYuy9qE
         GPrEFJqHm4GRT6xpVdoVeQgvDKLoV92ziZi3dqc3MPvtYSlhWDuk2+3JID+ChavP/9CC
         rCtxBKLM4kNLLsrkgVhmd8YFGN2/3G0SLLSZd1h8tTLn1T487iztCSQ1ePnygCiGlQQ4
         G0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpnokN0i6iCHNbK3Hq2vncfPsrhaFuH0/YJmD+o8wI4=;
        b=Kf7vYYVI47S565o63NrUSbrklAIq7nXiftzWsaGIT78/x36NqAcRbD8a6tfvB6AVPJ
         MHLMXQ8VxhynausZ5+ID2W3aVRZL8kVcNpwK9zZ31R7WC+tcXfGI7NzXhDfBcSJAq3ZJ
         P5pmYZZpFCZsKjLBFiQ7/mMRdgK8wcjmbLoBzT5xAczHdIdNdieYRkprrvfEqNN0e3Cl
         WmVHvZbrsTqx2cwrv4szmHkS88r05uv3QhMhx8YoF98kCdboK1/DvJePgARxmze4Mcs9
         yTdA6GfW6dQSnGcK+w/SNt8yVhyAMwAgGtRRcrI+vCE2R6t9Evx7zWh5YUhRMt1UlEDL
         kAhQ==
X-Gm-Message-State: AOAM531m7GApuqqR68Ho9O7kT95Apst7vnyrzBvHzntGSGfijWsSm6c0
        lauEklcyylHsgW2UfdwGcLs=
X-Google-Smtp-Source: ABdhPJzaQJBzXvQP3qF409CnTmdMdRKLGVplXwhvZ1kkB03s4LC2Tn+VxTcyf3Kv+ChjZ+wnSeUTxQ==
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr1440534ljk.186.1590526967087;
        Tue, 26 May 2020 14:02:47 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id z133sm240443lfa.41.2020.05.26.14.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:02:46 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/6] iio: adc: max11100: Constify struct iio_chan_spec
Date:   Tue, 26 May 2020 23:02:18 +0200
Message-Id: <20200526210223.1672-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

max11100_channels is not modified and can therefore be made const to
allow the compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   3776    1168       0    4944    1350 drivers/iio/adc/max11100.o

After:
   text    data     bss     dec     hex filename
   3968     976       0    4944    1350 drivers/iio/adc/max11100.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iio/adc/max11100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 3440539cfdba..b121ca78f851 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -37,7 +37,7 @@ struct max11100_state {
 	u8 buffer[3] ____cacheline_aligned;
 };
 
-static struct iio_chan_spec max11100_channels[] = {
+static const struct iio_chan_spec max11100_channels[] = {
 	{ /* [0] */
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-- 
2.26.2

