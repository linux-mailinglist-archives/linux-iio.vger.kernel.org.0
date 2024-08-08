Return-Path: <linux-iio+bounces-8332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ACB94C0A5
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386101C21DA9
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632318FDD1;
	Thu,  8 Aug 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScWH6O+L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DD18FDA0;
	Thu,  8 Aug 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129977; cv=none; b=YEQyyXz6eYCLx5N4Qczs8nevrRi2q7JCxdwO3AKzeP1vXytFuCCxBwfihbTX3zx0m3TKFyULvipLmL4UiHu0GjyVYNG049a8QGYhKZG4/HR0vPXnZVymzl+gtBackyklZAyFCr70WiScXinB146vkmNHThr3/EROGFje2H5gJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129977; c=relaxed/simple;
	bh=nEcNIE1U7DZAocIwTQqOGm97es75K5AAksPENUTjEFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6FY4pUueSX9XdKfq7T8wX2/BbyLIBX8dc0/mwNEv96iqB1/5vMSXY5ycdUEmmH8kmSfX3yfRyYxJqdomC46zjhKPlHc1ZRVUEAvdj4riXJ6MSd4Mxf5Xl4aq4J1PCdI3QCYfliJhI+sIGfrNZRYOE3Ady7JCMZgvekkATiy3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScWH6O+L; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368380828d6so590247f8f.1;
        Thu, 08 Aug 2024 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723129974; x=1723734774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZh6tA0jiESoXoOtY5qAvIE49vo04MTxnTUHVFSqNH4=;
        b=ScWH6O+LzAyDokNzeXUQxwvD5uqOsOtWu5aw29m2KN+dIofjksNVksZ0IwFUnHCTPw
         VxQplMMHkD+waBsU+D8ncIcC0mq9jI9Q4Wgzib5TXy6wqyCpxNqjTsGT2ZimtQ5XBCBT
         Tzq/crS0vxAn0gCkEOe4Xt8gnG7x/s3kSUFFXUOw2q/s6oXvHn3xv+ZQlRRiha/Pt2Bz
         ywrfoT7/f+6G2JrEvHyA1lVfLb2GwXskMuEAaRc5Hr3wDFqtXQs4H3fUnFmajQBsR9n9
         UcJbnjgnzIi761fFgm3fJDR3WR/0aeS3sJu+LYSrarCg5TCBFkmNyhxEHG0uW8G3+kkF
         /8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129974; x=1723734774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZh6tA0jiESoXoOtY5qAvIE49vo04MTxnTUHVFSqNH4=;
        b=RUNSL9WjbSpVRekygDmqBt6XvLgl2p1wcfvC4kmPPExso27Ll471qs0vExYGLc9lS/
         I6huE1Mmb+wZebiFiFFFogFvvzae2FYMvy5BkbcZAkEbd4JahE2NQtIP9J7ZoF2Ctoh8
         TqFzPhMwGMD/h4+8K74Tg14lLU3E6Z1KKM/Z4KhdupVR2OIKBb88iAyYgEpvcIz3OGyG
         OpPVU8xjDPevv0n+7gXhu1dpYxEi0cfkFze1NAdOSz7++VEaOMWXkLzMsnJfCWSR9GzV
         2sypEuMTMzK2UH8Dtj/bU8EtofRRF2Zy1i1MyTHgM3q2pB2hgm7nvtu0jXARddGDw7zL
         wfbg==
X-Forwarded-Encrypted: i=1; AJvYcCVj9OBhNCM2oFzaZfmD35wk4WQfwgzmUeLqLQxymbgYmpiNC9NEA+KnwgWRc20Eso3j0WKDnfvhuUHd2bk+dWDMgzKE6NxT+JcsMJuQCnIJh3zkIezOKSg4dri/VtQHl3uTpzhM175i1KEL7Pu/1nwNUTZRG9M5Qh0f2RcgOap+vwLlig==
X-Gm-Message-State: AOJu0Yx7gL17+P4oZFrJCX62dv4CnxP8MxeaiutWul7NHZahnT4ZXH/5
	Kz3yBUUm9/YZNSvo7wKW80kNph47GXgH7QpFwhtL8Y2jHyC1hZzBsIKty6gD
X-Google-Smtp-Source: AGHT+IENRUZXk9+CpUdQ4r+iBA879/lG619Wzdm/977nxAbjK/6QNybTGmdaKvHJD6uVBnsY8QbpSQ==
X-Received: by 2002:a5d:58f2:0:b0:368:714e:5a5e with SMTP id ffacd0b85a97d-36d273d0673mr1662793f8f.2.1723129973764;
        Thu, 08 Aug 2024 08:12:53 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27157145sm2179881f8f.12.2024.08.08.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:12:53 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 08 Aug 2024 17:12:39 +0200
Subject: [PATCH v2 3/3] leds: as3645a: use device_* to iterate over device
 child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-device_child_node_access-v2-3-fc757cc76650@gmail.com>
References: <20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com>
In-Reply-To: <20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723129965; l=1681;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=nEcNIE1U7DZAocIwTQqOGm97es75K5AAksPENUTjEFw=;
 b=yK5A5zMeB7sJ1oAnNbYGRuh0S9Y0nLJS/9nl8xfh6aDTDvvJRaVGSdFyccjPSKkv0RBXsa9yn
 kTVocwI/IrBBGlgGPYpMb9nlcqZKE9bVZrGFgVSRkFl3eRsPBOtEwcU
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Drop the manual access to the fwnode of the device to iterate over its
child nodes. `device_for_each_child_node` macro provides direct access
to the child nodes, and given that the `child` variable is only required
within the loop, the scoped variant of the macro can be used.

Use the `device_for_each_child_node_scoped` macro to iterate over the
direct child nodes of the device.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/leds/flash/leds-as3645a.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/flash/leds-as3645a.c b/drivers/leds/flash/leds-as3645a.c
index 2c6ef321b7c8..8e6abedf6e00 100644
--- a/drivers/leds/flash/leds-as3645a.c
+++ b/drivers/leds/flash/leds-as3645a.c
@@ -478,14 +478,12 @@ static int as3645a_detect(struct as3645a *flash)
 	return as3645a_write(flash, AS_BOOST_REG, AS_BOOST_CURRENT_DISABLE);
 }
 
-static int as3645a_parse_node(struct as3645a *flash,
-			      struct fwnode_handle *fwnode)
+static int as3645a_parse_node(struct as3645a *flash, struct device *dev)
 {
 	struct as3645a_config *cfg = &flash->cfg;
-	struct fwnode_handle *child;
 	int rval;
 
-	fwnode_for_each_child_node(fwnode, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		u32 id = 0;
 
 		fwnode_property_read_u32(child, "reg", &id);
@@ -686,7 +684,7 @@ static int as3645a_probe(struct i2c_client *client)
 
 	flash->client = client;
 
-	rval = as3645a_parse_node(flash, dev_fwnode(&client->dev));
+	rval = as3645a_parse_node(flash, &client->dev);
 	if (rval < 0)
 		return rval;
 

-- 
2.43.0


