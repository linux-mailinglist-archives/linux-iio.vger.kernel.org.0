Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78D1425495
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 15:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbhJGNsn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 09:48:43 -0400
Received: from smtp1.axis.com ([195.60.68.17]:31231 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241709AbhJGNsn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 09:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633614409;
  x=1665150409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkzjWmGgT/i1H38wRenFdkkBAjqNYA/xh9dv+VS8yO0=;
  b=WY79HO/0NG7FCAaZ3YUQAXA+dn6ZGnsJnIFWunV71DpEEikAoYchw4gc
   rrliTufvMH+/Zz/Zs0pM2qWA8B9tVj894CJZrD0w1bJVNrR0avlifx+EB
   CakNmXEYubYOVeBdaTc6UI542lVB/zIN0+6bozmQ5BHrl8c4/BnKavl5A
   z0dTdMC70V7V8i3rSzaDpuysnzdvdcj+bHqPOWK1B7uzsZP4P6wplMYhG
   wGHJNZE3PkhrW1NKwZw5uXlvckyQ1Tf6JngEesF66GRrhgUdOMs+OmbBu
   aZlYZHi3FpeNxC6ePtYvidqMVqXa0f45EHqZSLg2EHZ9puZpuzIFZEZ5R
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <peda@axentia.se>, <jic23@kernel.org>, <devicetree@vger.kernel.org>
CC:     <kernel@axis.com>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 3/3] iio: multiplexer: iio-mux: Support settle-time-us property
Date:   Thu, 7 Oct 2021 15:46:41 +0200
Message-ID: <20211007134641.13417-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211007134641.13417-1-vincent.whitchurch@axis.com>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If the devicetree specifies that the hardware requires a settle time,
pass this time on to the mux APIs.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/iio/multiplexer/iio-mux.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index d54ae5cbe51b..f422d44377df 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -33,6 +33,7 @@ struct mux {
 	struct iio_chan_spec *chan;
 	struct iio_chan_spec_ext_info *ext_info;
 	struct mux_child *child;
+	u32 delay_us;
 };
 
 static int iio_mux_select(struct mux *mux, int idx)
@@ -42,7 +43,8 @@ static int iio_mux_select(struct mux *mux, int idx)
 	int ret;
 	int i;
 
-	ret = mux_control_select(mux->control, chan->channel);
+	ret = mux_control_select_delay(mux->control, chan->channel,
+				       mux->delay_us);
 	if (ret < 0) {
 		mux->cached_state = -1;
 		return ret;
@@ -392,6 +394,9 @@ static int mux_probe(struct platform_device *pdev)
 	mux->parent = parent;
 	mux->cached_state = -1;
 
+	mux->delay_us = 0;
+	of_property_read_u32(np, "settle-time-us", &mux->delay_us);
+
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &mux_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.28.0

