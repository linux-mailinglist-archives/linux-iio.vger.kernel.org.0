Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98441585CA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 23:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBJWy6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 17:54:58 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:37326 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJWy6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 17:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581375293; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z044sk3hLZQ6ZSqGOx0ChvqXO+I3kz/yWR8pymM1iJ4=;
        b=HGYgdwJ1kTFnf8DKC5LoXX9HYeKmRWzgX7UYqQQDduT1nimt2PO/w7Mh40ciwAXmvhUlPC
        S6w18lDNM0yGjAVAvwEbDuXcg4UxWgTAyZS4gddWR6Ze8k4qbY9dB6uXHm1f/PIo90/5yE
        3gIXYejReDjYhMyiKibzkJFC9OwgvPI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
Cc:     od@zcrc.me, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] iio: afe: rescale: Implement write_raw
Date:   Mon, 10 Feb 2020 19:54:38 -0300
Message-Id: <20200210225438.112660-2-paul@crapouillou.net>
In-Reply-To: <20200210225438.112660-1-paul@crapouillou.net>
References: <20200210225438.112660-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Implement write_raw by converting the value if writing the scale, or
just calling the managed channel driver's write_raw otherwise.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/afe/iio-rescale.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 95802d9ee25e..a48f6af9316d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -35,6 +35,27 @@ struct rescale {
 	int *scale_data;
 };
 
+static int rescale_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct rescale *rescale = iio_priv(indio_dev);
+	unsigned long long tmp;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		tmp = val * 1000000000LL;
+		do_div(tmp, rescale->numerator);
+		tmp *= rescale->denominator;
+		do_div(tmp, 1000000000LL);
+		return iio_write_channel_attribute(rescale->source, tmp, 0,
+						   IIO_CHAN_INFO_SCALE);
+	default:
+		return iio_write_channel_attribute(rescale->source,
+						   val, val2, mask);
+	}
+}
+
 static int rescale_convert(struct rescale *rescale, int type,
 			   const int val, const int val2,
 			   int *val_out, int *val2_out)
@@ -110,6 +131,7 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info rescale_info = {
+	.write_raw = rescale_write_raw,
 	.read_raw = rescale_read_raw,
 	.read_avail = rescale_read_avail,
 };
-- 
2.25.0

