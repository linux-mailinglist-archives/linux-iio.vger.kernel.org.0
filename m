Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF74348CD1C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jan 2022 21:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357639AbiALUe7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jan 2022 15:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiALUe7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jan 2022 15:34:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BD0C061751
        for <linux-iio@vger.kernel.org>; Wed, 12 Jan 2022 12:34:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso14707223pje.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Jan 2022 12:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jDDgCX9OvErfDo0sNKvxQeO5BPJwOLC25cUpXEISow=;
        b=WEJrrjrDGKgN6WKHJvR22ZzEZZYMQWoAuiJsHjNOTmPXQJJM1hu50yzxEL2mJwbKMj
         kuskicM94dyirD2g8djy+mSjkwiuI3j9CnWbgRKPQvN1iuQGg4CRo9t+MpCQ1+Tljajt
         Upm8H14dDk9BxCalC9yifPIz7zZZlHSVS3pNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jDDgCX9OvErfDo0sNKvxQeO5BPJwOLC25cUpXEISow=;
        b=mItNV/NOAotXZe66+4v1zMrTdGGB0O7PUCI0iIltf5jVUa/uDHV5qV9At7vqVlILpo
         S0Cm2G2Ay96rGuUV5wEv8cxwR/qWSBqqXDNYG9ZHCPIQ6kgFygAsVMLsF9BpCpTDGk8r
         TvnRJD9YYIRfoeGO9akFzdebzkR3622sYHIHjNF03I84xYKw/7xISoClu+mSQmjsu/pB
         2Ua/jx/Er43OAJL3Z0DPrv3R87GfDp4iEpVrNvVOrgD5cDHIgW4EbhmxT9OwUz6e7EVI
         uBcMv0ngFESxU6EwQHk/foUcJXDELj4M7yiOSmzsrs1WA6F7j7L8X92wTOXISLQP3Shj
         yVMw==
X-Gm-Message-State: AOAM5315PNuucocoLJs+s8/H3HGVIzlHBw1WxWB3xT67W3W+9Nn8q7+W
        p/PiRLG8TKVzTUI5hdDMzpkaPA==
X-Google-Smtp-Source: ABdhPJyc986VGK1/tWy2VwCYPK+iZqHGOPSkQ8Ke2/L3TXwh0uC6VuS/ix0bPpwYTXODQDwren+DvQ==
X-Received: by 2002:aa7:85c7:0:b0:4bc:ac23:64a2 with SMTP id z7-20020aa785c7000000b004bcac2364a2mr1069592pfn.20.1642019698324;
        Wed, 12 Jan 2022 12:34:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id om3sm6560331pjb.49.2022.01.12.12.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:34:58 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] iio: addac: ad74413r: Do not reference negative array offsets
Date:   Wed, 12 Jan 2022 12:34:56 -0800
Message-Id: <20220112203456.3950884-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254; h=from:subject; bh=T/VuYtrE+Zt/PY/+kp4xexy+JkQW2hb1pk9GvgcIsOs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh3ztv7XuKKcljesSZX4Nm689wxj+gHrJWsAVcQijC JPh7ZrGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYd87bwAKCRCJcvTf3G3AJu3DD/ 4qVt7NtX1kbPTQ6jg8hM60eZkMdnsSM455gEWBym18G3rPYTM/wOUQXJ66qL9o88an8M4aGT+eWyXo pTibOQuTpb+e/8kn1qzw/a/bWjYIXv6W+/gpDYIhoe21V74qp1mqmkr/m0Dkuynbalhoq6Lhvuesty 2/qbxwSh4SldgirghIV6mA3zqLcd6qsVuSEF2vtq7JtAw92YRof4AMXLv2FyPUMFsMpPy7lOg+5NMF z6Af/vEq9plw41Iw1Ubgh41JBl3zkRJbHN8PshqrkAwE02qzE5NDtHhXr6QXNP8WcYSQL2c7QuICb7 FvRfgg0JvBQgutuw9W2q197GL4oYIKRHZ5hxcouqZHwdnUHQmxzF1dDzZGhXaGe/7YtW7BLzUeBlfA petKfrz1IHl95Mth9ZMinCcZmdIc3y8ojuU5/RUD7ej3Mw/oVxMoJ2uXI20OhVjG62Y+B/e8Rmtb2A A9D/c1IqtoSwssLUX39UXzNJk/z8aYH6khqc8BGKVrVp3ZytYDFh8q0oMkULvXyBJpCUtB0TBADy4b zn1sEEqMUYcK31VF6NeKNYFzPdB4Ed3gvmZHW51xG8GpFoVzn1GjQnFNO7rfDE19J3PbWuTUO/dEtm X0L730AOgjU4Zdchml3N/3mVJ5iLP6diCvN+8TZbUEEjTkIWrWfIRee8R1vQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of aiming rx_buf at an invalid array-boundary-crossing location,
just skip the first increment. Seen when building with -Warray-bounds:

drivers/iio/addac/ad74413r.c: In function 'ad74413r_update_scan_mode':
drivers/iio/addac/ad74413r.c:843:22: warning: array subscript -4 is below array bounds of 'u8[16]' { aka 'unsigned char[16]'} [-Warray-bounds]
  843 |         u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 * AD74413R_FRAME_SIZE];
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iio/addac/ad74413r.c:84:20: note: while referencing 'rx_buf'
   84 |                 u8 rx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
      |                    ^~~~~~

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/linux-hardening/20220105180214.2435001-1-keescook@chromium.org/
v2:
 - Update commit Subject prefix
 - add Reviewed-by
---
 drivers/iio/addac/ad74413r.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 5271073bb74e..aba9a643a4ca 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -840,7 +840,7 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
 	struct spi_transfer *xfer = st->adc_samples_xfer;
-	u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 * AD74413R_FRAME_SIZE];
+	u8 *rx_buf = st->adc_samples_buf.rx_buf;
 	u8 *tx_buf = st->adc_samples_tx_buf;
 	unsigned int channel;
 	int ret = -EINVAL;
@@ -894,9 +894,10 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 
 		spi_message_add_tail(xfer, &st->adc_samples_msg);
 
-		xfer++;
 		tx_buf += AD74413R_FRAME_SIZE;
-		rx_buf += AD74413R_FRAME_SIZE;
+		if (xfer != st->adc_samples_xfer)
+			rx_buf += AD74413R_FRAME_SIZE;
+		xfer++;
 	}
 
 	xfer->rx_buf = rx_buf;
-- 
2.30.2

