Return-Path: <linux-iio+bounces-23839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF1B47A5C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D22618996C8
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B46C23ABA7;
	Sun,  7 Sep 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QzaLoyG+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE623ABA1;
	Sun,  7 Sep 2025 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239571; cv=none; b=mpiQvfM66VsJKKZ0fxwJQOc1aqTq3BJfsuwbrg87tU8i908aauS3FkFxOUuHzQ8sThqxNjJGoFLUX7oHKsHG48nu0Iw4heZz5+QR9uqsY2HbqHKwyx+srqs+1zoXUrlKtMkq5AJbMsWr7OSjDWVkAHR3Pbma3vu2Bgd8Kp+fVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239571; c=relaxed/simple;
	bh=GHvhM9FlWUM6e6T7HPIc6H001Vx3itz71YXkr7+4R0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4YPs1/57nIn/G9hN4/O4p3uD2H51xgP11RbDXh16hZPhxvHbvyc2UJVg9HLKqIJuZDzDvmwWxgWW97zsBPyyZRExn4UqgYQID31fQDNOoUPEPutA2koY/Zxn7PkjymCDPzwMPE4Lo4uxR6Gjk0/aMxomTtdBF6ikmbFX8drNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QzaLoyG+; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id vCGTuurvoWnbbvCGTudBOG; Sun, 07 Sep 2025 12:04:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1757239495;
	bh=j4wszVsZ5LxEb9ANpI/eE3wRjtrAQfQYbcfmSy7KxFY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QzaLoyG+qgm965ILkTq9Oesv17nJZFeFb+6/2XfDdLQEH+yXhD1vg9mlKZwyworh7
	 oRKiXKHKHJR9lhGZm3MqDh5nqg40RBgGcwHEkkwXeqwZoDzot8F+buBynj1ajdNAMy
	 jEKllGPCy2vsf312zTCTe0CFb5thYiicwq41J5i7cRR9z3d5sP4cYj7ZeDEogbMHGC
	 gWBpkCGQLpnFNh+cEaO9Ce879Zk/4DOWpzWROP3V65FgIxuSPEn+Nq0/oxDGSk3HFW
	 rTBA0nSbNxM7V+g+ZZNYqZjT6miW9x1KLs8KkPXkj2AmKT/hbeVYzjTj0SqXBDzJka
	 +Yag+08hUc7Fg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Sep 2025 12:04:55 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: PAC1934: Use devm_mutex_init()
Date: Sun,  7 Sep 2025 12:04:48 +0200
Message-ID: <f92033415f43aa02fe862cb952e62b6ded949056.1757239464.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() instead of hand-writing it.

This saves some LoC, improves readability and saves some space in the
generated .o file.

Before:
======
   text	   data	    bss	    dec	    hex	filename
  50985	  23992	    192	  75169	  125a1	drivers/iio/adc/pac1934.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  50654	  23920	    192	  74766	  1240e	drivers/iio/adc/pac1934.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/adc/pac1934.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 2e442e46f679..48df16509260 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1471,13 +1471,6 @@ static int pac1934_prep_custom_attributes(struct pac1934_chip_info *info,
 	return 0;
 }
 
-static void pac1934_mutex_destroy(void *data)
-{
-	struct mutex *lock = data;
-
-	mutex_destroy(lock);
-}
-
 static const struct iio_info pac1934_info = {
 	.read_raw = pac1934_read_raw,
 	.write_raw = pac1934_write_raw,
@@ -1536,9 +1529,7 @@ static int pac1934_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret,
 				     "parameter parsing returned an error\n");
 
-	mutex_init(&info->lock);
-	ret = devm_add_action_or_reset(dev, pac1934_mutex_destroy,
-				       &info->lock);
+	ret = devm_mutex_init(dev, &info->lock);
 	if (ret < 0)
 		return ret;
 
-- 
2.51.0


