Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B5F570AD3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 21:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiGKTh0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGKTh0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 15:37:26 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336CA4D4E8
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2022 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657568241; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=h3hjTPBIDtHAaBH6EDPmGQQLUYmloNL/eXQns1FGG1c=;
        b=VPXQwFRQCfWbX+L57MNPLPir+y+1l3qL8Fi8+qS1zAY+sj+goWPrMeDxV5765EnW8QqPDq
        hqQaSeHHhgtFiI0TBC/1uMzG2jnnfbTBtUF0loYvTVlU5UzSbc3ZzAPMoU2w2i9d0RQa2F
        0DBDokl/t8Jsx4rZf13xpSqsDHPSW94=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [RFC] iio: afe: rescale: Add support for converting scale avail table
Date:   Mon, 11 Jul 2022 20:37:14 +0100
Message-Id: <20220711193714.50314-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the IIO channel has a scale_available attribute, we want the values
contained to be properly converted the same way the scale value is.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/afe/iio-rescale.c   | 75 +++++++++++++++++++++++++++++++++
 include/linux/iio/afe/rescale.h |  2 +
 2 files changed, 77 insertions(+)


 Hi Jonathan,

 I'm trying to add support for converting the scale_available attribute
 in the iio-rescale driver.

 The code below works fine… as long as all the possible scales returned
 by the underlying IIO device driver are translated to the exact same
 type. The problem then is that rescale_process_scale() can return many
 different types, while rescale_read_avail() only supports returning one
 type.

 I don't really know what would be the way forward. Should the
 .read_avail callback support returning multiple types? Should
 rescale_process_scale() have an option to force all the types to be
 converted to a specific one?

 Thoughts welcome.

 Cheers,
 -Paul


diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 6949d2151025..8b00ff3de733 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -232,6 +232,19 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT;
 		return iio_read_avail_channel_raw(rescale->source,
 						  vals, length);
+	case IIO_CHAN_INFO_SCALE:
+		if (rescale->chan_processed) {
+			return iio_read_avail_channel_attribute(rescale->source,
+								vals, type,
+								length,
+								IIO_CHAN_INFO_SCALE);
+		} else if (rescale->scale_len) {
+			*type = rescale->scale_type;
+			*length = rescale->scale_len;
+			*vals = rescale->scale_data;
+			return IIO_AVAIL_LIST;
+		}
+		fallthrough;
 	default:
 		return -EINVAL;
 	}
@@ -266,11 +279,63 @@ static ssize_t rescale_write_ext_info(struct iio_dev *indio_dev,
 					  buf, len);
 }
 
+static int rescale_init_scale_avail(struct device *dev, struct rescale *rescale)
+{
+	int ret, type, length, *data;
+	const int *scale_raw;
+	unsigned int i;
+
+	ret = iio_read_avail_channel_attribute(rescale->source, &scale_raw,
+					       &type, &length,
+					       IIO_CHAN_INFO_SCALE);
+	if (ret < 0)
+		return ret;
+
+	/* TODO: Support IIO_AVAIL_RANGE */
+	if (ret != IIO_AVAIL_LIST)
+		return -ENOTSUPP;
+
+	length <<= type == IIO_VAL_INT;
+
+	data = devm_kzalloc(dev, sizeof(*data) * length, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (type == IIO_VAL_INT) {
+		/* Convert from integer to fractional form to ease processing */
+		for (i = 0; i < length / 2; i++) {
+			data[i * 2] = scale_raw[i];
+			data[i * 2 + 1] = 1;
+		}
+
+		type = IIO_VAL_FRACTIONAL;
+	} else {
+		/* Copy raw scale info into our own buffer */
+		memcpy(data, scale_raw, sizeof(*scale_raw) * length);
+	}
+
+	for (i = 0; i < length; i += 2) {
+		ret = rescale_process_scale(rescale, type,
+					    &data[i], &data[i + 1]);
+		if (ret < 0)
+			return ret;
+
+		type = ret;
+	}
+
+	rescale->scale_type = type;
+	rescale->scale_len = length;
+	rescale->scale_data = data;
+
+	return 0;
+}
+
 static int rescale_configure_channel(struct device *dev,
 				     struct rescale *rescale)
 {
 	struct iio_chan_spec *chan = &rescale->chan;
 	struct iio_chan_spec const *schan = rescale->source->channel;
+	int ret;
 
 	chan->indexed = 1;
 	chan->output = schan->output;
@@ -303,6 +368,16 @@ static int rescale_configure_channel(struct device *dev,
 	    !rescale->chan_processed)
 		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
 
+	if (iio_channel_has_available(schan, IIO_CHAN_INFO_SCALE)) {
+		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_SCALE);
+
+		if (!rescale->chan_processed) {
+			ret = rescale_init_scale_avail(dev, rescale);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
index 6eecb435488f..8618955695df 100644
--- a/include/linux/iio/afe/rescale.h
+++ b/include/linux/iio/afe/rescale.h
@@ -26,6 +26,8 @@ struct rescale {
 	s32 numerator;
 	s32 denominator;
 	s32 offset;
+	int scale_type, scale_len;
+	int *scale_data;
 };
 
 int rescale_process_scale(struct rescale *rescale, int scale_type,
-- 
2.35.1

