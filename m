Return-Path: <linux-iio+bounces-8641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E0958E6D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 21:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4022E285C17
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60F316089A;
	Tue, 20 Aug 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1dY55eq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0B15A843;
	Tue, 20 Aug 2024 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180559; cv=none; b=CcS56lGlGFVyDdF73ZC+d6jhRHWzFaLCUueoqteiYIwmZIZvZjLrDMen+iX5rrBXTNcGwxq5A0zI0MCv4gyP5lvhcGNpFJv0L1mRVlOnUKU+IvEGBXRgAdenAPplDm9KW/OtYdMDxjt+xx2RuA9UeSZhPSMN8Gc3dYf3PV4uHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180559; c=relaxed/simple;
	bh=qaFPWD0RIQleYc4Ns6S0TI+inVjJZc6RI3ib63Jcn20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bn1eNfVlqGMIWFC2Wf41yqhxX/YyAmitOCSn2v7UZzrI6VgUi0XbJMEHwKpjqbABqqfzU5xRmU/zbXvtVvqgJGVfP8GfXHAS3jZktRjw6laVIb51XIJK1pndJoFGIhuMgfEmfVGuPvvfOmkNxyp+197IGTj+zvk3VKzyPIywzbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1dY55eq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso46428425e9.0;
        Tue, 20 Aug 2024 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724180556; x=1724785356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lk39EVwUYTe/PmJgHJ0o6ZUpvB1YLfN5vQiutxbSGPc=;
        b=S1dY55eqbRCskjN3hwGAE9ASJAz3TV0eLG49T6KGwxIXt6hSVVUHUdnv2mCwTxDxS4
         FvacgMMk1vGqecllVtXTy2VEQ5B7PcgQY6vAduE7ja5/FVXY46KXIr0zF+rYbKtIr7LL
         xe1RtNfR+OCXUYmmdIGad5dTyj5kawK7co0yI7DG/4tOutUtDee0ZVqN0DOoY6bLQzS4
         aPJxPMfauuwNTp/hGArSrxgZON3cdxiYUFwZdnNE2LSaxvE+D/Ju2bmnkE0B5RLYUE3i
         TV5+XZJ35frMaLr8s+BgpaU6HsLR1BXYMIJZvGsE67pBbHv4HPHmdH3aWX6GhvU1Fy+K
         Tr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724180556; x=1724785356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk39EVwUYTe/PmJgHJ0o6ZUpvB1YLfN5vQiutxbSGPc=;
        b=leVAstn6l0CXVpkwJjzP/yT3Zx/54wXtL3390zu1d4I1VvoJwnvlPouzX/moTq9mU9
         4wGXJ2+Iwsl96F9uEEtbgDBZa8vAitDzM3A4rH9mKm2iCeuXostIrmh0oYVcTCPBgdfw
         d4k+R4V55p5AjMGdADt9F5bXqT+oximn1E5T6Y5Sbx657aT8F1jNsTM3gCdUqP2cJQf8
         kynCexylJhA5G7xjcfC2GD2TXIm+C9pFH7OkmaGCH6RA+5LtGJwSElPENKZnW/qDRTcs
         h5GWDKygbOlQhbDEFofr+QxXYmpSe/VEn5XsiWVK57nm7KcwDEfrYcBCOA2cAVV/bJaq
         UW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP6ePNSvM7xbmGa4jmwkSeVnaIeRIQ9if2ASWmlfi5aEG+2kB9fZzYR11Yg8B5oqugcbgwANAmr+zSCQ==@vger.kernel.org, AJvYcCWN79wZLqbBp9Tt96+mrSF1rv18bBctzmFJC9B7b0M3yk2wilQ3mtcmH84Y44ohIYIZxjEfDi68WqR7wrng@vger.kernel.org, AJvYcCWrvb2thFjeDAVl8bu5T+cK8BVPCbyfnt5GnnumFQrXOSA9n0gDoWYfLeaI0l7Lhu0gXOw2xg/9wKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlciKYaOa/3DGntMsa0awQMqOJIkpD565eWLZ0ojLV9Vgk4DJZ
	mdhsMDLeBhlQyph0eQlRnRCIbczXkFeoF7KrzFP807gYbMRS8pgY
X-Google-Smtp-Source: AGHT+IGGBhANiB3W6Reo3NqccFS905Z9Dy+9c9h/ngG3KSuRWQLpJHFooauis3rHBSlP+NQHFkGnJQ==
X-Received: by 2002:a5d:408f:0:b0:368:5b80:b8d with SMTP id ffacd0b85a97d-37194456508mr8491898f8f.21.1724180556015;
        Tue, 20 Aug 2024 12:02:36 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497ffsm13685375f8f.27.2024.08.20.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:02:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 20 Aug 2024 21:02:27 +0200
Subject: [PATCH v3 2/2] leds: as3645a: use device_* to iterate over device
 child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-device_child_node_access-v3-2-1ee09bdedb9e@gmail.com>
References: <20240820-device_child_node_access-v3-0-1ee09bdedb9e@gmail.com>
In-Reply-To: <20240820-device_child_node_access-v3-0-1ee09bdedb9e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724180551; l=1681;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qaFPWD0RIQleYc4Ns6S0TI+inVjJZc6RI3ib63Jcn20=;
 b=+qLZOCM01OgoJCa1FolIUdEkTZVPRnhhGL5fjZKf4mR3vOOH/TFJIS15/h5JWDgs2cH1y1VCR
 DWLZrYfjvNEDnl2k7Je38HCKrH2jawUX/Nuze+0nKLtAA3SJllCcReB
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
index 2c6ef321b7c8..2f2d783c62c3 100644
--- a/drivers/leds/flash/leds-as3645a.c
+++ b/drivers/leds/flash/leds-as3645a.c
@@ -478,14 +478,12 @@ static int as3645a_detect(struct as3645a *flash)
 	return as3645a_write(flash, AS_BOOST_REG, AS_BOOST_CURRENT_DISABLE);
 }
 
-static int as3645a_parse_node(struct as3645a *flash,
-			      struct fwnode_handle *fwnode)
+static int as3645a_parse_node(struct device *dev, struct as3645a *flash)
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
+	rval = as3645a_parse_node(&client->dev, flash);
 	if (rval < 0)
 		return rval;
 

-- 
2.43.0


