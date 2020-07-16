Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA99E22248B
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGPN7r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 09:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgGPN7o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2607C08C5C0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so7172716wrv.9
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6tPdMdWiD4Qi1X6+E6dYGvKrP/4qwx+lTrQsk0OB80=;
        b=l1cUvi9DzNooWydgiwAXJ3EvdllfPdK81HJHQTfYJLuUsXl8Kf/fd8y6hFhg1Z1f0A
         45k/X2ml559Gbn6EYeF7uEC65VhHiartqH8lCVH8dkge+vslC+kU7GL8GA18R0tpmxC2
         iDJEU658Q3q39qK6nxXKGIXC5sorhMzi/Xm84CAlSdG8l+EoQQrj79HydyXJGt1jYEcx
         ovOx6fZLa2ASySNTpStzisxYspX7Fs8qWqESyw+/+pud0ygIrr/U6sIplTfF1dW1xrWA
         dXapNnMW6LxSokJ69c73pw5TN/S7YfTsPkNRzu544rAmvMNP9+vyhAKRnh1nDyYcjjCg
         VRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6tPdMdWiD4Qi1X6+E6dYGvKrP/4qwx+lTrQsk0OB80=;
        b=KpfZ5vI9hF+dKNTo3x/JwoT91fbNr7ZHBTTbRVlORRZUObpcicnqbrw9d5L+tuMLzy
         uQD4uVPYY/J9/pSCxCT6i84CfgZntvcoBd1Lz4pcZyIQFzawwMQ5bzaHjTUG23mAVRhy
         rTs1JuBFKq73ZmHunIk/A8FKj/odlBtggyhD4y+jqp5DJ2dR/1Lgi+Njq6InGTR3czAA
         fjj6OVcmDB/GNJYRI7Fh+481BWikyKtTSY4vYQsRYRqoIrSKp8iAeTeBPaEFwbuwgAlb
         Pv3On1k5QamrVqoXtQwo5+9A33yxy6SyPBoAes8qTQC03kmDWxgduGfIv3b90Ccp7/Jy
         s8RA==
X-Gm-Message-State: AOAM532doHxpLrG47q8w+QshEosALZq+K4c+sLjg02iDLb0LOze3wfLN
        mU47yJjfxioU6P7pOSpoY2/gzQ==
X-Google-Smtp-Source: ABdhPJwYTN/Ya6SFin5ezgh1ja8CD257ThAKP/2N7ElG9M405oMbsirgjkjS+mAPBxcvfsJAQ/dU2g==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr5162752wrw.244.1594907982569;
        Thu, 16 Jul 2020 06:59:42 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 08/30] iio: dac: ad5380: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:06 +0100
Message-Id: <20200716135928.1456727-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5380.c:64: warning: Function parameter or member 'lock' not described in 'ad5380_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index b37e5675f7162..fd3358cccc7c5 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -51,7 +51,7 @@ struct ad5380_chip_info {
  * @vref_reg:		vref supply regulator
  * @vref:		actual reference voltage used in uA
  * @pwr_down:		whether the chip is currently in power down mode
- * @lock		lock to protect the data buffer during regmap ops
+ * @lock:		lock to protect the data buffer during regmap ops
  */
 
 struct ad5380_state {
-- 
2.25.1

