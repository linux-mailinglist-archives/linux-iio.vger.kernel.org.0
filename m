Return-Path: <linux-iio+bounces-7181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC2C924787
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 20:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDD41C21B21
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D81C0DD9;
	Tue,  2 Jul 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQBsbbYL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30317442F
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946097; cv=none; b=N37E9fwL57ldN9ghD/DTxF7hY2Hg37CtuqxBT7b44J+ZxjxRKfOIodsMjaEmg4WDnp8RsgQNaRU9Phptf291oTVu23wJu2UgT/zb85c9eYzLCgCs6lQD07ilS7rrTxusDmPLoIhW/Xjil8xwv8YZT3I5T/3XEne9sBSMhGegUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946097; c=relaxed/simple;
	bh=nmkalRVdPTlmZrEy1vL3vGU7/b2GIkdQaVIXNODUqqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCei3Qe5xRPmtlLzQaBVAC95QDi72F8cjOa69NBJY+tkbmsxasGMh5dLmoyTOeqLUTNMeHxjLScYMiA8z8DDzpVkGeaJBjhP1brHMcAfgJd4MgKVrmCLkRBcDZ1wu9DL9AkrQdWZ9jjHqjhHgWTiNeY2DBJOOu4OIPHUrpC8jYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQBsbbYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7226C116B1;
	Tue,  2 Jul 2024 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719946096;
	bh=nmkalRVdPTlmZrEy1vL3vGU7/b2GIkdQaVIXNODUqqI=;
	h=From:To:Cc:Subject:Date:From;
	b=sQBsbbYLCbVE12qhyn+6VLmTsFfK1gvvGAdboCyjz8pgTw3FUjApopskU27d1/BgU
	 rzE9C/EX/BDTZx0F5FbJMFUiM0wi0L1fIJn6TGOo1Zn3F6EkCL7Hwog4Q4mo+jbnSg
	 JAgy169YcM0Y6uhTy6pIlOd62jpIWGbERF/Uy2/0hcebXKJhRaX/TIShBZYEEwoy7K
	 Zoy572J4cTnPPFB9v+Ll6ImafZJP2r5+q2CPRoSA10NRK0P0ahcmVlrIsDXaBeX0ja
	 GkEBNti+jTKzLQ1d1kKm/0B3uECVAFJI6rOskQnTjW6Ridcpxsr4XZb/Yp1BteuxOZ
	 hC3bITYwdBolA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] iio: adc: ad7173: Fix uninitialized symbol is_current_chan
Date: Tue,  2 Jul 2024 19:48:04 +0100
Message-ID: <20240702184804.579341-1-jic23@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Move the definition down and make it a boolean that is initialized
to false.

Fixes: 13d12e3ad12d ("iio: adc: ad7173: Add support for AD411x devices")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202406232046.DKfBJq6o-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
I applied this directly to the togreg branch of iio.git.
Normally I'd have squashed this with the patch, but it is a long way
back in the history under a couple of merges.

 drivers/iio/adc/ad7173.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 7da70b7422bb..9544bf7142ad 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1188,7 +1188,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
-	int ref_sel, ret, is_current_chan, num_channels;
+	int ref_sel, ret, num_channels;
 
 	num_channels = device_get_child_node_count(dev);
 
@@ -1234,6 +1234,8 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	}
 
 	device_for_each_child_node_scoped(dev, child) {
+		bool is_current_chan = false;
+
 		chan = &chan_arr[chan_index];
 		*chan = ad7173_channel_template;
 		chan_st_priv = &chans_st_arr[chan_index];
-- 
2.45.2


