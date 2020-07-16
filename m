Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6468422249C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgGPOAT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgGPOAK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 10:00:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F7C08C5DE
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so7130546wrw.12
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOHIdvlIidd+7p2sHDTKra83ef6B8ha7cc7/PdUBPbc=;
        b=Dx8Pbe1u4vM+hm4azGpSGHrCAbBXlqqYV05Tul1Kzq1JT3U54J/G6KRSVP6psj774j
         7oF9rHqwtNNlwsOEGGs5GQTJ/Jah2QI/U1HMKvR9lfK3lqmU4diL84p/6v76SPvJf4pT
         HuqqF+xlt7X2q2iLgC2m01XLwMZcZ9D31mgL5QdP3KrF1fAFnso5wW9jhZnOlQ4jO7zw
         RRGiQ8SPWNA0g7vRLZJFrccsYKdCNZCW9rwOrW+T/UiuU6J28Hlk5JiwGGLP8bRatMlI
         RxgJ3sqhtpQdQGak2/oAX3DJ8jv+AuzlgjMdzW5aLUluWovEMlFybQWPRcDj3Hs2qVWb
         DJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOHIdvlIidd+7p2sHDTKra83ef6B8ha7cc7/PdUBPbc=;
        b=MWlmhmyMQYRvMvSFN/bGUN3YaM0ANbrmvUWqUFQGDR6Oqs+WGcgToUxbEzo3pwPuqG
         jbH32QnzSBOPILsBTilSxkBDaNgcjxaD5JF84hSTPllIPdaSREhyYN75K3482bynZLwC
         OdcSQ1khXWijgqXDSSbauNZn/8eGoeQ3ABuUxRA6K8RY4dcOxS5ptP+LBJwrYPAjm8IX
         BNA2Bfj9nfPNNR3EkULjYVtOWv7OkaiZRjDXJNzegoXObJzUpiLySbb/NHUZQfoBFmPT
         FwoVJ5RmdzdwnG9Jcv4s5/IqYU/94UEm5kaAJiriie1EUJji6PiDdEz31Bwuc8DuuX+/
         RJiA==
X-Gm-Message-State: AOAM531WzqsHqc3bhZqv/RYDEraba4WnwCkV92IWCWcsXDtd84hWLMJM
        ZfLmmYLqQ9aqe3Lcm5cP8QmSSO8rPnI=
X-Google-Smtp-Source: ABdhPJwAX0gWGkhPX0tfMguJK7Zm8LpXZMXfhfkclKhURxrQJenM8r8bQA/v5LnHqNQaiAeripPq4A==
X-Received: by 2002:adf:8521:: with SMTP id 30mr5018695wrh.238.1594908009398;
        Thu, 16 Jul 2020 07:00:09 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 30/30] iio: dac: ad7303: Complete 'struct ad7303_state' doc and reorder compiler attribute
Date:   Thu, 16 Jul 2020 14:59:28 +0100
Message-Id: <20200716135928.1456727-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc gets confused if the variable does not follow the
type/attribute definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad7303.c:49: warning: Function parameter or member 'vdd_reg' not described in 'ad7303_state'
 drivers/iio/dac/ad7303.c:49: warning: Function parameter or member 'vref_reg' not described in 'ad7303_state'
 drivers/iio/dac/ad7303.c:49: warning: Function parameter or member 'lock' not described in 'ad7303_state'
 drivers/iio/dac/ad7303.c:49: warning: Function parameter or member '____cacheline_aligned' not described in 'ad7303_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad7303.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 15af8a1cce3eb..05d8dc88d4fad 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -29,6 +29,9 @@
  * @spi:		the device for this driver instance
  * @config:		cached config register value
  * @dac_cache:		current DAC raw value (chip does not support readback)
+ * @vdd_reg:		reference to VDD regulator
+ * @vref_reg:		reference to VREF regulator
+ * @lock:		protect writes and cache updates
  * @data:		spi transfer buffer
  */
 
@@ -45,7 +48,7 @@ struct ad7303_state {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	__be16 data ____cacheline_aligned;
+	__be16 ____cacheline_aligned data;
 };
 
 static int ad7303_write(struct ad7303_state *st, unsigned int chan,
-- 
2.25.1

