Return-Path: <linux-iio+bounces-8127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC9694444B
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 08:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80486B2536F
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B31A38C2;
	Thu,  1 Aug 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJLx9RXB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3391A2551;
	Thu,  1 Aug 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492847; cv=none; b=JFT/Z1dKTCNIpBIQ5g/Zr76x0S2TobmfbvuDpancIVKN3LcJQOzjd+li4aHgznUDwXHAJhSu8e5p6dvfyBiz5bp7xadm3F0UiBQQapenXCOp0gRvW7DApQfrNCpRF8JEexm2PpFZ6KKdogD/dS35YSgVO7+mAYFsbgZPK4VOYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492847; c=relaxed/simple;
	bh=n9RPwA0mKwp8E3yrA5e5bskfywWjPvxynbcgRtP66H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWCkX3kE+7YAKoAFCCScEtJeBFiQR7sBs8uUG1JOP/WKqtu/Nsmpna4gm/OHRx5lMGXaUTfeWHKjT57Xp0Gb9sB0kCc+r5eaGjfZV4TvugUT9OqGJlgV5uKPLt2AeOTyWk8x5C95ZJqoF1O8MsjGFrgieLa2FmT55RyCNASvX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJLx9RXB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso40591235e9.1;
        Wed, 31 Jul 2024 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722492844; x=1723097644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+L8YiRjBiJi2NiFbZ6hVKOuXnOLL1u0RNfoOt4ZnPSw=;
        b=MJLx9RXB/tEWuFUnLEWIY7qOzlSfhPjAyqSo935TOPngNRW8QSIHi7w/tKs6MPy9UA
         DFHFQVkWZ0/dQD/Ri3j4Yum1yXgYaLOsJJ8vFtxYjjdFBUbu4tIUtQZtyuBMHE6aYYCr
         NktHzgc/FroMEucVPOZ2lAzMKOagsnhEjGV6MUqQhKF5G5wPxzmpUibL0VQueQG3WCI/
         YyifT7GAAxaCXp5LZtp6iDRxeJ4n2Ym/SQ05Wdb8xyIY0FHE1HyYJ+uPyi4sbbphEVBS
         j8anh+cXEv9zBnzQmpo1+3xJcPjAJRODIfolzFZ8FNTRFUHPpGEHO9abQI4IeiBbve7X
         rlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492844; x=1723097644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+L8YiRjBiJi2NiFbZ6hVKOuXnOLL1u0RNfoOt4ZnPSw=;
        b=LRjHaZbbo6O7qc2emuEXBYQVi/Cx0MB6DTotYLOSSxd4Xen82Jjy9UVkfjvdsifw0P
         3U8lxhO7f3sTePFgFCmKJwyYDDvnmcVGj/Ru3cDm9t5odQffpFLKjvt/2l30blsUAF5+
         mE3JTBjrlcdKSVoaCXhEMjHX6P0lGNYDGju9HTQsRJj04jeVOLTR/eu91BKuIiUuQBwn
         B7DW3H7zSgC27MKw+ko7WxKyGXQsf3bynCOatmJ01NsBLDpcoFR7nr28xkbZ1AHLSrbU
         vr1iQU/jo9+lXTvriOkYiITjILPqII1DaH2Jyow+4likJMUF69wJjqAncZgA2m1hjq4o
         FTCw==
X-Forwarded-Encrypted: i=1; AJvYcCW2iWvRd64WrDS1RezTEi6CuIrYg5dCo61azx0spX5ZQzSQGZRN5lZb6gpDShxFqS9JpCkKn6EGy9hxJbkp1ZzZAHyRydELhUpiW9BQtiZMWOTVoqaN4/w3rzwXQKMWrKjuhDwbCUtZc8Aj/xt1wK3ArgXdhJ0GACQ4+40PsBl5V3Fwcg==
X-Gm-Message-State: AOJu0YzHmLZhi0GcmOrVtty3mt3bE2mNOYXHMDg+QAoTcaUKJ8Or/GTo
	tSGsYOR/B7kvL59UItrn1vJXCBO/qttHNiiG5KHYKyBagz/VAfqxiGHbB67R
X-Google-Smtp-Source: AGHT+IG6tOf0ZuCj66jBUdpJ75hyTaGQvDe8snbMCEnWWBBmA6qrhcWqvsDkB9zYFI73n7i+mB+l3Q==
X-Received: by 2002:a05:600c:46c6:b0:425:7c95:75d0 with SMTP id 5b1f17b1804b1-428afa57c17mr11596585e9.18.1722492843548;
        Wed, 31 Jul 2024 23:14:03 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c032bsm18696455f8f.12.2024.07.31.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:14:03 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 01 Aug 2024 08:13:53 +0200
Subject: [PATCH 4/4] leds: as3645a: use device_* to iterate over device
 child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-device_child_node_access-v1-4-ddfa21bef6f2@gmail.com>
References: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
In-Reply-To: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722492833; l=1626;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=n9RPwA0mKwp8E3yrA5e5bskfywWjPvxynbcgRtP66H4=;
 b=KKQapzC7/u9Jck7tT1Y5QlkimkoXnQapCJf6536uEU1HbJu0a4w+37OvHj4efHxY128VYMVz3
 D/ifXMyfdkhChw8FAcWBd4j29NwiDIeLsBB2IVdOHzin6zUKRqB2DRV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Drop the manual access to the fwnode of the device to iterate over its
child nodes. `device_for_each_child_node` macro provides direct access
to the child nodes, and given that the `child` variable is only required
within the loop, the scoped variant of the macro can be used.

Use the `device_for_each_child_node_scoped` macro to iterate over the
direct child nodes of the device.

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


