Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3700E3D4F0F
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhGYQmI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 12:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhGYQmI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 12:42:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D292D60F23;
        Sun, 25 Jul 2021 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627233758;
        bh=z9P0wpDzneyLHgDABBdsFR+B/22PlA5IQL2nE993VhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpj9WhRPhttQ31VCP/tAiyHmH5xtkYV/eCJMsxvlQXJcYaO9ewRKz0ZxaMU9v3fqB
         M9qvTItMNLrpwTRhqhpuqPMIXjqRZ7PQ9QmJsuMsPO3XOmVkV6Yg/MXYA0D43gzJvW
         /zDVuEsiDAC1ByNyQwFgOgKdh4t38dUhDBe4OVYgEhxnxcLg6lZ/05qOjSR3ZHA7yr
         mQl7DzdakOx3ovLqUY+n6hHvaW0N12v2MoGHFes9S4sHtO8hi4PFmSO36/tefAyQPl
         1oCL2yuIR+PBVgryPy6/GrJxgxedQOY4+YG7ZAwwa8Qq8nmmQ/KnhYuhH1HMSaZ2IC
         lSbmpeadCtAcg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio:adc:ad7124: Parse configuration into correct local config structure.
Date:   Sun, 25 Jul 2021 18:24:57 +0100
Message-Id: <20210725172458.487343-2-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210725172458.487343-1-jic23@kernel.org>
References: <20210725172458.487343-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The channel index is used before it's been read from the device tree
child node.  Move it down a few lines so it reflects the correct setting.

Noticed by inspection, so test appreciated.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index e45c600fccc0..b2e49386d7dc 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -765,7 +765,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	st->channels = channels;
 
 	for_each_available_child_of_node(np, child) {
-		cfg = &st->channels[channel].cfg;
 
 		ret = of_property_read_u32(child, "reg", &channel);
 		if (ret)
@@ -778,6 +777,8 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 			goto err;
 		}
 
+		cfg = &st->channels[channel].cfg;
+
 		ret = of_property_read_u32_array(child, "diff-channels",
 						 ain, 2);
 		if (ret)
-- 
2.32.0

