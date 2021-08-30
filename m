Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDF43FB91A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhH3PjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 11:39:12 -0400
Received: from mail.kernelconcepts.de ([188.40.83.200]:59968 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbhH3PjM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2021 11:39:12 -0400
X-Greylist: delayed 2299 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2021 11:39:12 EDT
Received: from [217.146.132.69] (helo=yoda.kc.loc)
        by mail.kernelconcepts.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <florian.boor@kernelconcepts.de>)
        id 1mKilN-0007Sb-Uz; Mon, 30 Aug 2021 16:59:54 +0200
From:   Florian Boor <florian.boor@kernelconcepts.de>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, Michael.Hennerich@analog.com,
        Florian Boor <florian.boor@kernelconcepts.de>
Subject: [PATCH] iio: adc: ad799x: Implement selecting external reference voltage input on AD7991, AD7995 and AD7999.
Date:   Mon, 30 Aug 2021 16:59:34 +0200
Message-Id: <20210830145934.11024-1-florian.boor@kernelconcepts.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of the AD7991_REF_SEL bit and support using the external
reference voltage by setting the 'vref-external' property in devicetree.

Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
---
 drivers/iio/adc/ad799x.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 18bf8386d50a..3ae7ec72caa3 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -770,6 +770,7 @@ static int ad799x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	int ret;
+	int extra_config = 0;
 	struct ad799x_state *st;
 	struct iio_dev *indio_dev;
 	const struct ad799x_chip_info *chip_info =
@@ -806,6 +807,17 @@ static int ad799x_probe(struct i2c_client *client,
 	if (ret)
 		goto error_disable_reg;
 
+
+	/* allow to use external reference voltage */
+	if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
+		unsigned int vref_external = 0;
+	        of_property_read_u32(client->dev.of_node, "vref-external",
+			&vref_external);
+
+		if (vref_external)
+			extra_config |= AD7991_REF_SEL;
+	}
+
 	st->client = client;
 
 	indio_dev->name = id->name;
@@ -815,7 +827,7 @@ static int ad799x_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_config->channel;
 	indio_dev->num_channels = chip_info->num_channels;
 
-	ret = ad799x_update_config(st, st->chip_config->default_config);
+	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
 	if (ret)
 		goto error_disable_vref;
 
-- 
2.20.1

