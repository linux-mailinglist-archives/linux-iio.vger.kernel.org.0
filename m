Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8187912FFF3
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2020 02:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgADB3S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jan 2020 20:29:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35202 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgADB3S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jan 2020 20:29:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so32975343lfr.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Jan 2020 17:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVxgu+/EfYLObpBxPj9J/FBH19M1cScn1yRwBkxvlrI=;
        b=DcjsNOTyTspyQy8E6jHkzOhLyGUWSv74IfFXSbLpv8s83KdGenQjQH2ryCSWvlSDv0
         Wq66sjEX2le5Ioz7iaDFBWiP4e5+J+71udIHgL/k7H4CcATclc7I0rI5pEYTDbH1AtRS
         fwZEDaZwV8iDr1ad5hE6zAGPNOf8r0o1jhksM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVxgu+/EfYLObpBxPj9J/FBH19M1cScn1yRwBkxvlrI=;
        b=meLfbROQhgxg4h0wxpB8z9XBvwY6Vyb9a/jz0pGe5ewpMz1VGqOaJyT0/N4rpBjcsX
         y4vBH5IQE2v9lUr6W7QwszzcR4ezyEuOGIDioiq+WXjMuC8pqDmw22OYVONLtMsU11Fd
         uJUP766oWJrZgviaRCzZzIJt6k70wwMKxU7oQz562DkCNW1BLZY3XmFPEsJ9eD7jCVoq
         B2Un6xiMx8s4cWFZUyfUKTgfRwo1SAwsBoF07eBs1ia1/Iv16TCxz+9rURT0vaNaxQr5
         xU8xc73EyGNzXiPIACzHYgjA/y7QjZrI1Kokfd2l1cz0cVjWu6OhFhG+4AwkTghTOJ90
         5d3g==
X-Gm-Message-State: APjAAAV9nFKOll8eQkFe7uFyANXfmEXQN3sD4Y9R3X6tinM+2yYXnYlu
        XvTBgRb/vqY1ybeU2nIrA8fU4z95v5FgXUom
X-Google-Smtp-Source: APXvYqx8k1eY2Nl+7zs4z/Lq28ZYEAc3L34TKJAnLXPbhPXngymKqg1/nRAmld8bEobs7pphMwyotA==
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr52148980lfp.106.1578101356465;
        Fri, 03 Jan 2020 17:29:16 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-208.vpn.ipredator.se. [46.246.49.208])
        by smtp.gmail.com with ESMTPSA id d24sm25731710lfb.94.2020.01.03.17.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:29:14 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: chemical: atlas-sensor: add helper function atlas_buffer_num_channels()
Date:   Fri,  3 Jan 2020 17:29:08 -0800
Message-Id: <20200104012908.17020-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add helper function to detect the number of channels to output
in trigger handler. This is based on IIO_TIMESTAMP channel being the
delimiter between input and output channels.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 99095c80531b..2f0a6fed2589 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -86,6 +86,16 @@ static const struct regmap_config atlas_regmap_config = {
 	.val_bits = 8,
 };
 
+static int atlas_buffer_num_channels(const struct iio_chan_spec *spec)
+{
+	int idx = 0;
+
+	for (; spec->type != IIO_TIMESTAMP; spec++)
+		idx++;
+
+	return idx;
+};
+
 static const struct iio_chan_spec atlas_ph_channels[] = {
 	{
 		.type = IIO_PH,
@@ -354,11 +364,12 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct atlas_data *data = iio_priv(indio_dev);
+	int channels = atlas_buffer_num_channels(data->chip->channels);
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, data->chip->data_reg,
 			      (u8 *) &data->buffer,
-			      sizeof(__be32) * (data->chip->num_channels - 2));
+			      sizeof(__be32) * channels);
 
 	if (!ret)
 		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-- 
2.20.1

