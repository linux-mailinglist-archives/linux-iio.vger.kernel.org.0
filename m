Return-Path: <linux-iio+bounces-3955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F2892CB7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CC21F22769
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79114405C6;
	Sat, 30 Mar 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p90SeOCR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B7200D9
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825760; cv=none; b=Gl68EkmUEZxLlzoUVZ5cz5OM3fMBy8De5wtbvaDqwirg+8Yl8+q24BjHyanDEIj4tqhUc6z8y3XE5tqyM+OLGGCzenZSs6SHIWqRBFrdfs3dHNBVZw5PN/Qo1Mqa+tgPzE+bVA3JPQ6gFeZQvX+ssBjMhVnfVbEeffCtnhdoMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825760; c=relaxed/simple;
	bh=bDFmcN+PEwQtVnUZbRbjcyvkGVvHlaTDyN9NrX0fpi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNnyAGI1ty5SI+DgIrquKCXNAkGs/SFPJZkqnaVyD80Vz6U8SRCf8mMd6zYBnMXMHbV5TppqXXgiep6SJHjLs3kvuq1eVjH6BboTaV+AK6jUq/vskdqOpCe8L2WicDj66mmjZi7+UtqUJBSZn/oXNUB9KSFzwDU7gxRKse12Muo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p90SeOCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFB2C43394;
	Sat, 30 Mar 2024 19:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825759;
	bh=bDFmcN+PEwQtVnUZbRbjcyvkGVvHlaTDyN9NrX0fpi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p90SeOCRKa+GQsTbeV/Oqonfrh7Muu6iLiYWoOxc4TL4XhcqyDXueRB2rNX3UmAf7
	 mPThFlw7FL6clcLNUhshW7e/c1s9FDS0hoY/AQo4pxMJ52wv0mvS9+3hU2VimcHcJg
	 14FXlxJwsmsuQJxDh5RYhRU3HSGirqAIRCav0h7E8ksvnaDHXiPlvgttDArmYS+/st
	 SEp7p6fjEYHL/d4JDD31xT6qcMVOd2wXbtgE+t/sQqWxIe0KDGKl+nToDicgF1gIuX
	 RslrlOWP01M7lNw+gGJn2ZKYkm/8PE6UGKRBnwpMvz1l2+W1ljbb+ztpr48VstHpWL
	 9bsdy1eKNs5uw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/8] iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify error paths.
Date: Sat, 30 Mar 2024 19:08:46 +0000
Message-ID: <20240330190849.1321065-6-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330190849.1321065-1-jic23@kernel.org>
References: <20240330190849.1321065-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This loop definition automatically releases the fwnode_handle on early
exit such as the error cases seen here.  This reducing boilerplate and
the chance of a resource leak being introduced in future.

Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7173.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 4ff6ce46b02c..f6d29abe1d04 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -910,7 +910,6 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[2], chan_index = 0;
-	struct fwnode_handle *child;
 	int ref_sel, ret;
 
 	chan_arr = devm_kcalloc(dev, sizeof(*indio_dev->channels),
@@ -940,23 +939,19 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_index++;
 	}
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		chan = &chan_arr[chan_index];
 		chan_st_priv = &chans_st_arr[chan_index];
 		ret = fwnode_property_read_u32_array(child, "diff-channels",
 						     ain, ARRAY_SIZE(ain));
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 
 		if (ain[0] >= st->info->num_inputs ||
-		    ain[1] >= st->info->num_inputs) {
-			fwnode_handle_put(child);
+		    ain[1] >= st->info->num_inputs)
 			return dev_err_probe(dev, -EINVAL,
 				"Input pin number out of range for pair (%d %d).\n",
 				ain[0], ain[1]);
-		}
 
 		ret = fwnode_property_match_property_string(child,
 							    "adi,reference-select",
@@ -968,24 +963,19 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 			ref_sel = ret;
 
 		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
-		    !st->info->has_int_ref) {
-			fwnode_handle_put(child);
+		    !st->info->has_int_ref)
 			return dev_err_probe(dev, -EINVAL,
 				"Internal reference is not available on current model.\n");
-		}
 
-		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2) {
-			fwnode_handle_put(child);
+		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
 			return dev_err_probe(dev, -EINVAL,
 				"External reference 2 is not available on current model.\n");
-		}
 
 		ret = ad7173_get_ref_voltage_milli(st, ref_sel);
-		if (ret < 0) {
-			fwnode_handle_put(child);
+		if (ret < 0)
 			return dev_err_probe(dev, ret,
 					     "Cannot use reference %u\n", ref_sel);
-		}
+
 		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF)
 			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		chan_st_priv->cfg.ref_sel = ref_sel;
-- 
2.44.0


