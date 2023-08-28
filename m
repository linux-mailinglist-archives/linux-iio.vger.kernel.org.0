Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3211878A91E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 11:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjH1JoZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjH1JoD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 05:44:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D02AA;
        Mon, 28 Aug 2023 02:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D70660B86;
        Mon, 28 Aug 2023 09:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE7C433C7;
        Mon, 28 Aug 2023 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693215839;
        bh=xjAeVP31obttB8Bvi53bbgjrxVQcHlvWuSepU2NlDME=;
        h=From:To:Cc:Subject:Date:From;
        b=cugJG4/qmTzGMC+Vw/+V6jdhsSzRJYf5aTW+RzXw16WEBCoNdKtICGoQhshJSlf7T
         /eRYxRYHMpIBqtR2h8LHiUdBUDfovOX1ikseHoXzTxTZSHz8l8owiHIHNibcZw52ib
         7aZpQ17gDxL9eELUHU1EA/xD4tCSW8x9aV6/Ayag42oGoYrc9iIsGQzaSm+wEltO0r
         60XkHU0adZ4Vws8/NX2UcADa71iL6R81R7QWEQjPddvosNAvrE8GvK7YpOdwC8JPSi
         g9CW5DMZNeXlpmONXxf8SPlFBk89b0udzvfZMlDNGHUU4Y88VMgtUo3iaKJdc9CmRD
         75vhN5QMpRyAw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
        lars@metafoo.de
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        gwendal@chromium.org, linux-iio@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org, stable@vger.kernel.org
Subject: [PATCH] iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()
Date:   Mon, 28 Aug 2023 17:43:39 +0800
Message-ID: <20230828094339.1248472-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

cros_ec_sensors_push_data() reads some `indio_dev` states (e.g.
iio_buffer_enabled() and `indio_dev->active_scan_mask`) without holding
the `mlock`.

An use-after-free on `indio_dev->active_scan_mask` was observed.  The
call trace:
[...]
 _find_next_bit
 cros_ec_sensors_push_data
 cros_ec_sensorhub_event
 blocking_notifier_call_chain
 cros_ec_irq_thread

It was caused by a race condition: one thread just freed
`active_scan_mask` at [1]; while another thread tried to access the
memory at [2].

Fix it by acquiring the `mlock` before accessing the `indio_dev` states.

[1]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/industrialio-buffer.c#L1189
[2]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c#L198

Cc: stable@vger.kernel.org
Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b72d39fc2434..a514d0dbafc7 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -182,17 +182,20 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 			      s16 *data,
 			      s64 timestamp)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 	s16 *out;
 	s64 delta;
 	unsigned int i;
 
+	mutex_lock(&iio_dev_opaque->mlock);
+
 	/*
 	 * Ignore samples if the buffer is not set: it is needed if the ODR is
 	 * set but the buffer is not enabled yet.
 	 */
 	if (!iio_buffer_enabled(indio_dev))
-		return 0;
+		goto exit;
 
 	out = (s16 *)st->samples;
 	for_each_set_bit(i,
@@ -210,6 +213,8 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
 					   timestamp + delta);
 
+exit:
+	mutex_unlock(&iio_dev_opaque->mlock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
-- 
2.42.0.rc1.204.g551eb34607-goog

