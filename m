Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF623B177
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgHCX7J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgHCX60 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:58:26 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052ECC061757
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:58:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z6so40449661iow.6
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rN/d/4Ztn21EkbHD6dVPT8VsDxw/yLn4xET1uonrRo=;
        b=mOTd5An1Z+sPuy/vpHw9OIndbv2Qr1Ixek2fEEqWq9M8glS/doo0hBw070w8rHtDEB
         cJjEveE7pN/yBVmSOkC76eK0NhJJXQqkWYQNSfwPgT44M/ar/GngHyrhu5PCMf/2gTan
         gnHaXcNPfy2yhWKG3elyNK/qzSxDMGDaK8kMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2rN/d/4Ztn21EkbHD6dVPT8VsDxw/yLn4xET1uonrRo=;
        b=I6ChlKXUrQ50Z5ApHwk1ofTUDv8zuhsCOW+PasCFQVJbvdCqgHYjsJw/xDUZ5mOnf3
         k9UZDtURvBT3Kk2CPrTvGDwfuS3KNF09S8colQTLBWlyTPmdvhueqwv0abKKdpwKBEKB
         PnmY5B7NW0+LyvIltSc+jHwMjhjAAmkNi8XT8VvDgrpTEVsDwxo0hEtrzfTpTvqAH2A+
         Hy5HAJ7pdeUNa7gYM36s5BQq80t1fBZ999zK6Gb7LuQhO6PF4sddpScI/ymYq68Mfz+J
         bx7aTWOylwaLMRb8TjD8PqEAvvLXETuZnbuSP5BwReOqPDpC4QrbtA3y5IOVPqRK6qZo
         E3Wg==
X-Gm-Message-State: AOAM531iGz3xtBWm3zWVn1W9AZoPJAiFcXe1eLDnevDm6Xf4kYknx+5H
        jlrN2R2BX4Iob8JktarUXuy5uQ==
X-Google-Smtp-Source: ABdhPJyMFpx3vadGuvlAiinOybtGhpTSrLbfBcMLBRI2fj0uFKksxd/X3CrB6Za8JNA+hQZa/StRIw==
X-Received: by 2002:a5d:9b05:: with SMTP id y5mr2415091ion.59.1596499105355;
        Mon, 03 Aug 2020 16:58:25 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:25 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v5 06/15] iio: sx9310: Fixes various memory handling
Date:   Mon,  3 Aug 2020 17:58:06 -0600
Message-Id: <20200803175559.v5.6.I8accffd77d616cb55b29bc3021cb0f5e1da3b68a@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Makes use __aligned(8) to ensure that the timestamp is correctly aligned
when we call io_push_to_buffers_with_timestamp().
Also makes use of sizeof() for regmap_bulk_read instead of static value.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v5:
 - Really use a pointer to buffer struct on
iio_push_to_buffers_with_timestamp().

Changes in v4:
 - Use pointer to buffer struct on iio_push_to_buffers_with_timestamp().

Changes in v3:
 - Changed buffer to struct type to align timestamp memory properly.

Changes in v2:
 - Fixed commit message from "iio: sx9310: Align memory"

 drivers/iio/proximity/sx9310.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 66ecdd309e0ddc..127b1ba79e2dea 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -132,8 +132,11 @@ struct sx9310_data {
 	 */
 	bool prox_stat[SX9310_NUM_CHANNELS];
 	bool trigger_enabled;
-	__be16 buffer[SX9310_NUM_CHANNELS +
-		      4]; /* 64-bit data + 64-bit timestamp */
+	/* Ensure correct alignment of timestamp when present. */
+	struct {
+		__be16 channels[SX9310_NUM_CHANNELS];
+		s64 ts __aligned(8);
+	} buffer;
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
@@ -344,7 +347,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
 	if (ret < 0)
 		return ret;
 
-	return regmap_bulk_read(data->regmap, chan->address, val, 2);
+	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
 }
 
 /*
@@ -694,10 +697,10 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
 		if (ret < 0)
 			goto out;
 
-		data->buffer[i++] = val;
+		data->buffer.channels[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   pf->timestamp);
 
 out:
-- 
2.28.0.163.g6104cc2f0b6-goog

