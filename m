Return-Path: <linux-iio+bounces-9504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C337D9780FE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89119287A30
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163781DC1B1;
	Fri, 13 Sep 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7ric3eV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B11DC07C;
	Fri, 13 Sep 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233566; cv=none; b=b/l/Rpd42XCHA+7MDdH9MOHk+tfVFcMDpJ1aHuA0iJyXZwY2mQwty+SRcpvtSmTeZJeHfZz0aTYwsCnIq+IzCWkf9K4HKRQFcs8ng/WfrbFsxc/Ersb9vS4b25n6uYmnDhrvU7v+54SfltKDjhxlTZFZ8qtsYujFW0SxdQm3V+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233566; c=relaxed/simple;
	bh=c0ILQnyW+ImdjeGc6T+fx6mOz4Ws/4vgy5ONpaMk9/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4XagUcHshmehWkbeYk97h3Gr37aNPILVqJpn8hyFsiE20EGrEiH02d5Imy8qD7ctG0bNgwzWB/JZ+feEu/r3p6ZIQ/6wX6X7uAihD4LRfOfR59bOMu9OQ1xfTOpLW07H2XQDbz3GfMOAPrOHkbH5f3OFwJEsvqkHcTSP/DxBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7ric3eV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32971cso2663246a12.0;
        Fri, 13 Sep 2024 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726233563; x=1726838363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gg/pJfNPr78lVbZX5142nrf+6p/6HmhJkcXZ0Cm+gM4=;
        b=V7ric3eVMLQAfqw6IyIt99CBm0uBGQe1VKTXu9dBt9e1m6rlZroxnpcy0udtJ39tyF
         N1oRU8PT/TAb1iQoeXQPsJANz35URNR8fpxnHWv+gJfyMu4lpkLx5LBTCUl2S2UXHLq/
         sEnD1QqFcFxw6ca92TRAzZ2NDiD5jTdGARhSICwv5r1tAff3AOs8VYpwSUAPfG304v7G
         oEWQeFOw3dW1yqVzrnEN9adXtoXwpXzOQGxRZfbHjpk+48Xwj5SixFTOCtHnNvLCdXZZ
         w8iWCuDqzyGpWAE3DLiRHcy+CRMwHopl6+hcBOW304wDMumiR5LXN05IGmqCeUQYOd3v
         KuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233563; x=1726838363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg/pJfNPr78lVbZX5142nrf+6p/6HmhJkcXZ0Cm+gM4=;
        b=fKcVfM4+5VR5mM2tnvpAlBjO0CNTJZjyzgn78Mh0SuJQ0sNH58Tenw336x8dv7vYBH
         4UonylmqpQsVtU+fnaA9qVrqjUoepNSu14NoxC7w9syWq/1DJnQQnEJFsvRhaTdjm/nv
         VIcywYWI6onSph8/7F7b6oqx6zSfBYxIfwD4KjYfBy8rrsUgOA7BdbAuzHw4HfiRhzWt
         DoBcmlZOG3ZGBau9v3F3eVzHFmH5MGRqTVhL5j0R59ZuMlRUU19rDY+/wP/xfT8VzCQR
         ZREkiEmmgao5UCHxYbIUcQnjwhUKVAONR2lWuFhLhPoxT7+sn8RM16bJdZoJR0uAO6p1
         9/eA==
X-Forwarded-Encrypted: i=1; AJvYcCWuJkjgSDq4Uv0HNxrMTQqFtpdsfALrXzjGUE+Sl+ZBCCJm17Nk6Kpiu0x29KN8Rau1L0k0r+wIX6dU@vger.kernel.org, AJvYcCXLYDGGpJwFS+iOg6VqLp5+knKymcmcAAwk/VZ5VqYqsl64Ifbw9IpEUPHDENPYTyHt2upbi8UFz6aPZ0Re@vger.kernel.org
X-Gm-Message-State: AOJu0YyPR53AXwNrikxleV1aejfeEnxcRv7+RYWMMxP1wtdnj0NjRa1r
	VdSsctBveMwO97ejju2327ThfGna8/v4QtlaZKk+fCNeandoJzA4
X-Google-Smtp-Source: AGHT+IF+cjLWNh8boLkPYB/eCVfAxD4c2886l660M1ICrcArb9JFPIzj+brQd4wTCs9/QYdDW4NBWQ==
X-Received: by 2002:a17:907:e687:b0:a8d:2c3e:7ed3 with SMTP id a640c23a62f3a-a90295a6a66mr604263366b.35.1726233563551;
        Fri, 13 Sep 2024 06:19:23 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm865945666b.89.2024.09.13.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:19:23 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 13 Sep 2024 15:19:01 +0200
Subject: [PATCH 6/7] iio: light: veml6030: add set up delay after any power
 on sequence
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-veml6035-v1-6-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
In-Reply-To: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726233553; l=1500;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=c0ILQnyW+ImdjeGc6T+fx6mOz4Ws/4vgy5ONpaMk9/4=;
 b=6IYpwTsCFf+E/BhF9e8v/iPVGpBPPB7W8gcWpwjOVyGwNfs34nmf7TJ+VhiX+npkS3ph1q1ci
 jj4F7VF/ahXBgYZ1ugGPDJpJu5l61iQL0xJUchd+1avYEBLTwzdpnmo
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6030 requires a delay of 4 ms after activating the sensor. That
is done correctly during the hw initialization, but it's missing after
resuming.

Move the delay to the power on function to make sure that it is always
observerd.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index d5add040d0b3..2945cc1db599 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -143,8 +143,17 @@ static const struct attribute_group veml6030_event_attr_group = {
 
 static int veml6030_als_pwr_on(struct veml6030_data *data)
 {
-	return regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
+	int ret;
+
+	ret =  regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
 				 VEML6030_ALS_SD);
+	if (ret)
+		return ret;
+
+	/* Wait 4 ms to let processor & oscillator start correctly */
+	usleep_range(4000, 4002);
+
+	return 0;
 }
 
 static int veml6030_als_shut_down(struct veml6030_data *data)
@@ -766,9 +775,6 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	/* Wait 4 ms to let processor & oscillator start correctly */
-	usleep_range(4000, 4002);
-
 	/* Clear stale interrupt status bits if any during start */
 	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
 	if (ret < 0) {

-- 
2.43.0


