Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7FA1E30DE
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391619AbgEZVCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391617AbgEZVCv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 17:02:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0AC061A0F;
        Tue, 26 May 2020 14:02:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z6so26261632ljm.13;
        Tue, 26 May 2020 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfsjZT426GKLsEKLOHm0vE4g7kNwoUqMKolXj8tX534=;
        b=UYfdLIFiF0TBj26Y6CXXL6PlhSM4MXzndI50oF6mJOStBsg70LU8TVUhTvvar5tLxl
         u9Iy8BLVgJvAjKVA8F/RHQxkb2Z5rgr5OTTzNqdV1wtGdYlTrKm5YdDb8eEPqL1v+Ej1
         ZKSFKoTW6RgFJ+hr9eZck239uXWXXIHKyRqy+DSg0mFoKwZqYd4wRlXjTTZqtynDVnvw
         uc909ij9JzLYXhTf4cHEf8yJ/9zNBpFKnWINyWivrkMd1+FeOlVZ+LHEk4dPuvVOdsjN
         KDfUPMjqg+LHxQ+VBpqBWkOWhttpMIylE1Ech5UEczVl/OuaTFDuyoDCsQ5c6xf4wac9
         aVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfsjZT426GKLsEKLOHm0vE4g7kNwoUqMKolXj8tX534=;
        b=qUCYjqFJbQrC68M06ESkoLomxYI6ke0r5gj8Lt6Wl/L+ScwgdyQmMw8WB5Hs+C/tMq
         fPxKGn1z5wA4y6GZ9NMkesxAmayd4wmAk+zYKHfpG9jSWGhiHiYgqLQcrlZ5MmEpwg1R
         FXMJEPc2aK+6DvMUU31fiK7UGn1HS0NusqmWutbZHP9XOWI3FKUIZnZOl79guU3cLPHn
         ThyL4fHdgAY+etN5ZscgZ3xDcT0b28Klo+T7zhtr4r7ntHYCUUGtL+XqlpMAJIGuHeTp
         /4qhNda9LG2x78ehhJGf0TPDbFntrldNbQn5s9wSNr4+mlZALL+MwIIT4LEKhBGOZS11
         MEWg==
X-Gm-Message-State: AOAM5333hYAnrECRX7mGmYV7ME9a9noTQUUdEz/DLnlvhhCNw+K+xXEN
        ZtOX1juWvIGHQjVyAX0kLYpyOCWlXeA=
X-Google-Smtp-Source: ABdhPJzOPnQEwPIP4LdvZgD5d14UmeD+LVhP76Cy57jge574gl/aorWTKpOBohC/DxzVspisSzgsCw==
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr1447604ljj.43.1590526969284;
        Tue, 26 May 2020 14:02:49 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id z133sm240443lfa.41.2020.05.26.14.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:02:48 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 3/6] iio: dac: ad5592r-base: Constify struct iio_chan_spec_ext_info
Date:   Tue, 26 May 2020 23:02:20 +0200
Message-Id: <20200526210223.1672-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ad5592r_ext_info is not modified and can be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  13293    2088     256   15637    3d15 drivers/iio/dac/ad5592r-base.o

After:
   text    data     bss     dec     hex filename
  13421    1960     256   15637    3d15 drivers/iio/dac/ad5592r-base.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iio/dac/ad5592r-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 410e90e5f75f..7402f67a551d 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -484,7 +484,7 @@ static ssize_t ad5592r_show_scale_available(struct iio_dev *iio_dev,
 		st->scale_avail[1][0], st->scale_avail[1][1]);
 }
 
-static struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
+static const struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
 	{
 	 .name = "scale_available",
 	 .read = ad5592r_show_scale_available,
-- 
2.26.2

