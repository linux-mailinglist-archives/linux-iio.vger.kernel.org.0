Return-Path: <linux-iio+bounces-8331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8221E94C0A2
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414A4285EB3
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A2C18FC90;
	Thu,  8 Aug 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHMr7fUm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482018F2FB;
	Thu,  8 Aug 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129975; cv=none; b=t4nlwfbAgDqSfkWfxv7ZFc/ekDea+FGp0ow7qz2St1vkU7RsTBJ1A57jR1YVWFNq4Kp+jOM18i7NYzXiqa3YnUxxTdwDCqH7hseTq1XN/KvH28ZdVNiV5sTfu3kwnbR95zBvdeXssMNQvoXbfXJBUwn2ULeO5wgXDpqJ99ZT6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129975; c=relaxed/simple;
	bh=cl0OgwWFGj09y5TwwEPvN3u/Sy1PyJsfo8HSpKT7rW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5o9b0PeSyw3FXrJPtyeqqR6mhTpZovEWf0bwOukqTl12im0y2NhKOHfep53OXYZwOrjL2QycVKQucAPRFtwP/wN1NOWMKj6gqfytwJ23AC/qfkHar7vUl02LfMc1g0O04agpPSM6ohL/2Uo0p5q5Wc/lTxe3TlNUr+Em8Y49IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHMr7fUm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368712acb8dso606498f8f.2;
        Thu, 08 Aug 2024 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723129972; x=1723734772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlwKey+PJeZN0A9rh/S0vL1F8rX1MwKvwXZ2q25uwGA=;
        b=nHMr7fUmqJUGVdH3MWOl0SW2qJLHhU4fzlpZAZw8M7W/qTwQXuSkab+EIvhG6LSi4+
         rIPTQQEUK4V8k4xE6Y5wRaHQ8JVRn8adef/thS8K4Vj8oA9VWdmcgyRru2qF4CPKBf2E
         O9TMNOPZ70tCkUADaAmkRZ6rFd1nZul0T1rdkolzNCrt388hlxtYXu7sOLzf/fZEv/AP
         6c8QxYQ0DEPJVKXktVuK9ZzKCqjWZVpcmjyI7r9DqEP5o3sfzCdvuLaeaK0o/h8SQ/3S
         ZZZxJLAwhFqDjy9zZDjhcTxKWiVgZ9A2R4kFDltmM/rWEx9nWmodcUQwScJxkhw7Mj/a
         tVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129972; x=1723734772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlwKey+PJeZN0A9rh/S0vL1F8rX1MwKvwXZ2q25uwGA=;
        b=qCPZhtIxpi7n0W0s2rL/zDl206sAfMuLn3pG95gku2MOxYKaqZn44UcdjqCH0bDWu1
         pvia3Jhelp6KCxERJPdGnOVK2tUWs9QdPejXWXXEP4n4yippr2gpHo6p4F0LujnPDW1V
         euskBybKKYo4WUi40GX1Wi5H2XPxE504v6vyLWJ3E+/fkt/Y7BzHJrWeOJ8pxwfGkyY9
         /B057AVrdfDcmP5Q1cXFI9IXhnkskHTWwU//xfuyNciUN70OKS6wEtCp6uEWjb57Z+Lf
         RqSWKc2wxc23v5AFW20Rk0qrIup9teCO4o7sEqH979OA8wtUX08WsD1taTpXqSS2fZlC
         L9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWMlqUFxLD2AMS8CeuzfAl102mpZCAEAeQBNSZdUnUIP9Ir/cMGjja4QNrPftGJdPJaUm+3IzaCFASKv5uVASBRR5XeDB8twDaBaqXHkdw5SHECjFfWCv3twtZ2C41mAti469dAX1TCxlUMGQ9jK9pGCIm3RrWNGa/bh7UwwwMPy9q36g==
X-Gm-Message-State: AOJu0YwHi505VolTQ8QRHhV0BSeQMBTNmMCDaGqLEPyDIdvYaX2NGRPu
	i1pTEW/C9giqNVLyf34lV9ESvjgu9NcPqWa2uhm6dSXwZx/q1Rs9AxgYxfZO
X-Google-Smtp-Source: AGHT+IFzix7VIeZTIQg0zBbjhj5GUek1tgQE9LwRj9V7JHckkhnN4U9cHGMO4vhsBtlpWQ50/ywkIg==
X-Received: by 2002:a5d:5743:0:b0:368:6d75:1bde with SMTP id ffacd0b85a97d-36d274df3eamr1785039f8f.15.1723129971713;
        Thu, 08 Aug 2024 08:12:51 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27157145sm2179881f8f.12.2024.08.08.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:12:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 08 Aug 2024 17:12:38 +0200
Subject: [PATCH v2 2/3] iio: adc: xilinx-ams: use device_* to iterate over
 device child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-device_child_node_access-v2-2-fc757cc76650@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723129965; l=1584;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cl0OgwWFGj09y5TwwEPvN3u/Sy1PyJsfo8HSpKT7rW0=;
 b=Nr9fmxg24DocQ91AeftJ57YIQtrR9pYh1YfzOyKJzkowwMkDRORul2NZFUngK6AIViNcppMLe
 0oceNoCGid6Bb3ghyIr/zXz1d+2ydI/2tahKQ4WzdvYLIC0HsYJEnZz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use `device_for_each_child_node_scoped()` in `ams_parse_firmware()`
to explicitly state device child node access, and simplify the child
node handling as it is not required outside the loop.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/xilinx-ams.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index f051358d6b50..ebc583b07e0c 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1275,7 +1275,6 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	struct ams *ams = iio_priv(indio_dev);
 	struct iio_chan_spec *ams_channels, *dev_channels;
 	struct device *dev = indio_dev->dev.parent;
-	struct fwnode_handle *child = NULL;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	size_t ams_size;
 	int ret, ch_cnt = 0, i, rising_off, falling_off;
@@ -1297,16 +1296,12 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		num_channels += ret;
 	}
 
-	fwnode_for_each_child_node(fwnode, child) {
-		if (fwnode_device_is_available(child)) {
-			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
-			if (ret < 0) {
-				fwnode_handle_put(child);
-				return ret;
-			}
+	device_for_each_child_node_scoped(dev, child) {
+		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
+		if (ret < 0)
+			return ret;
 
-			num_channels += ret;
-		}
+		num_channels += ret;
 	}
 
 	for (i = 0; i < num_channels; i++) {

-- 
2.43.0


