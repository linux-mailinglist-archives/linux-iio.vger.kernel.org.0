Return-Path: <linux-iio+bounces-8125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DE8944442
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 08:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496611C21B4A
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0FE1A0AF2;
	Thu,  1 Aug 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqQd41u2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B2170A2F;
	Thu,  1 Aug 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492843; cv=none; b=iRn17Yf7jDfoykRjWgrf5CDsBAlSf/jQ5O89JqSCd6G47zOt3iU4DQsMIEr2QAmYRfVFzbIL0hAUNWDmuR+xGemO+ZWTZxlNa109bB2RtG/UYv+BRF9K3Kq/+DV6iw3E+Ac3/9Vhgm7+zth8Nd2Pl2SLyFVfK1dXmAnTAnRP/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492843; c=relaxed/simple;
	bh=yyQNHjFv6OaCNbO9wuo6ZoLCj4JK3H1u8HwFjN8qxho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bj7Dh3Czl80JwKMYT0ObmvOqxBwcf43tVTBR2U/b0iA6/MuiVCflt4myieSgdxZ9xa8HzHzPYrS8cqc7TyRym+SgsPYtyE2UmEDxWirS9zFd7MepyZYSacV2bM0sR27gCnClXWfh/nvIq12TUItx6L9DEYRpJCDEu69i6+Z7pQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqQd41u2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04c29588so11410551e87.3;
        Wed, 31 Jul 2024 23:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722492840; x=1723097640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enx9v8ZRoRb0TNxn5/5uQkDbor2QF+9a6iuc6VG5jiY=;
        b=dqQd41u2ovAeeOdENvLN8+kEvkNlwaqugIl+/VxPbEGOtLY4v5g9eStY6L0F9QYhSU
         uKLJHksJjNtvb1ZkZd9Cun8EQNtyA7Y/DQSrmwvxeHEh+pfPeawvgJ8GpfdWjNhjViU8
         q6hS2V/cYrmpXHA5HFUaMNMjGPykNfNXQ8Nvf2lmB11CcNjoCKSOTG640ynBEfzDUaNN
         kY+2xWsaGeXrSglDWZefBsnpHAUHrbHpKVTg7rWdd15UbzD7dzxE7iIZk+iwTN06+aFG
         rUEoZ0jufFXP7Y2FRXPGMOYRlMr8Qj0oH+YX3PdhlOANNEP3kp0s8GWjGK4WKi8hZKfV
         8tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492840; x=1723097640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enx9v8ZRoRb0TNxn5/5uQkDbor2QF+9a6iuc6VG5jiY=;
        b=qxzw/OmThCM4MrKe3ZSbV0PyCwwhdXNTuNM/n5jJFVnIIsvSBAfukD36KxrRqJePnq
         Gtiz4Y7DBsbqzBvY+yRg+Gl6qn8WQucRcWFDeHE6L4a6j1EFUcpH5XntvHcJ28CbiOB8
         YEhWdd6NIawB3wm535MFaLfrujJ1nqnN9EaUmPjqYuRD5m+b8n6zf6UpURkuysQC4o9E
         W7fftGwe5LfDtdxuEyrbAvt5hqxuxSQ8O7qx/H8u8jGUsRmhzXvUixmBXJiygKp2PFxD
         WoxsI67pqlmwYfHH8BYLmV3I00AK4xE65r1pzDWMTHCZZ0czIbv2ZDJvB4ZX0NQ3VDlB
         saSw==
X-Forwarded-Encrypted: i=1; AJvYcCVH3mZvqLvjfjxm/kfI1fTc34KGwRtuOSwj8gvuGl3w9lpGbBeHaERU3oLr3u0UPfCRFspR62reRPjm+TLbJ68IHvUVEFDXpeCI9FVfSREoxsYER8NXMYLimfHWqRwQHVPH1Dybo3NGBojM2MlY8iiFED4dSHmi0c7YZ0Sq1pRbXTGX0w==
X-Gm-Message-State: AOJu0YzKBednYT4AQ7quraKoBLmuDbvKjWboD4OgtNDXuCbyMZViHYF5
	SRJuGyRxNaciKs7JjsSoEEKgfHpD4ng78BHolqqLK1Kf4JJa9bOGFH1PX06k
X-Google-Smtp-Source: AGHT+IHQ5i0GroWo5AeLzUxGRqZlnfM9Dsi09xbpsd44bG5iNXixHisdHZvKayig69C53T7CfBFZJQ==
X-Received: by 2002:a05:6512:3e14:b0:52c:dc57:868b with SMTP id 2adb3069b0e04-530b61aa001mr839626e87.13.1722492839474;
        Wed, 31 Jul 2024 23:13:59 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c032bsm18696455f8f.12.2024.07.31.23.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:13:59 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 01 Aug 2024 08:13:51 +0200
Subject: [PATCH 2/4] iio: adc: ad7768-1: use device_* to iterate over
 device child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-device_child_node_access-v1-2-ddfa21bef6f2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722492833; l=1237;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=yyQNHjFv6OaCNbO9wuo6ZoLCj4JK3H1u8HwFjN8qxho=;
 b=oiQRLvjRafZ6kChiVJ1SXsWmSE4ZPM8Bzb8wvKCGEJJKYDspf8vhiz7JFcKhI2WNCnGKJSsdP
 w0X7lZ8NT9fBHmm9TcOg7g6kH5uj3CiLje7PopravaIDQy3sFa+0VMB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Drop the manual access to the fwnode of the device to iterate over its
child nodes. `device_for_each_child_node` macro provides direct access
to the child nodes, and given that they are only required within the
loop, the scoped variant of the macro can be used.

Use the `device_for_each_child_node_scoped` macro to iterate over the
direct child nodes of the device.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/ad7768-1.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 70a25949142c..721672fe84ab 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -544,13 +544,10 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	struct device *device = indio_dev->dev.parent;
-	struct fwnode_handle *fwnode;
-	struct fwnode_handle *child;
 	const char *label;
 	int crt_ch = 0;
 
-	fwnode = dev_fwnode(device);
-	fwnode_for_each_child_node(fwnode, child) {
+	device_for_each_child_node_scoped(device, child) {
 		if (fwnode_property_read_u32(child, "reg", &crt_ch))
 			continue;
 

-- 
2.43.0


