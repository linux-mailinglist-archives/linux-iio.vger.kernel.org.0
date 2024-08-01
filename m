Return-Path: <linux-iio+bounces-8124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC294443E
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 08:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A35FB25DA9
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 06:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE41A0712;
	Thu,  1 Aug 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1foEVOA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606EF16D9CC;
	Thu,  1 Aug 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492841; cv=none; b=mzyKooZ1pG9kk4B2QwlovoLqzfzFByHpIZh22j4V2Df7Oazwa6jaq8LJe968fp5ECB1ZMJEs1wj6mHVq9brWIaYuL6Hb07BOtQJoqIjv89xvTlmyzoFbdjRK95rcaGS7htCjywlmFdkxYyVvPKyrz6PIA714NQ2aNXlFubM7wu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492841; c=relaxed/simple;
	bh=QFolg12C6V7SfGr1X/Q07nrFu7zCcR/xL99lde/5xoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBV/a9NA3eA8K1I+HooYNyaYPt9hsAE1iW34qjm2QJz9f6/qYrt+m6sI0/4Hl+CLGRoa90XY+/7tiU+TLMgxI486hNOaEyjwlsOtsCSRX9yJ+PQiOyQoIUakwrKGlsCvgZ07y+GE3DjbXh8dhuSvZvG7nWtKeUnlEjGjlwYIG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1foEVOA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3684407b2deso3294794f8f.1;
        Wed, 31 Jul 2024 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722492837; x=1723097637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZB0CSSKP7vKOy+3pwEVaiFc3nb6WEPjBuqxABKIpgI=;
        b=A1foEVOAZwu71P2Di3Iw//nZMpZ1EoMYh41DlfHJXChAft2EhgfRdo4PnQn74TSg5t
         hwsZE0WoSzo9F5XmughfeHfHK+JAPIaaXqFxVNmsR3bwfpf9jitQs/kzDKykh4cEo3hF
         hYaDS2HkfXAAfuq9VryRs25UGMXACc+HEoSIozO1ZKf9t/QnNUVEFA9Blv4AqgdY1t25
         UIkHEP50dC7afypVWqp1fU4EH+Oeel6pPnv3DlLhCjTkiqeGXSLnOKREP4TqimNc+6IM
         jFAe1MBhpJW05xUK1gaX0zX7oG4Ta0qp+CEmv9U1YlMW9oHA7FMlH23gtvgRYnaUh2pq
         vKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492837; x=1723097637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZB0CSSKP7vKOy+3pwEVaiFc3nb6WEPjBuqxABKIpgI=;
        b=m4VTROotavASzJUJoMUK94h/ULINTI2yAJgtovuOtDDma0b7yzBeeZPlzVXfZ+qK0k
         fKDhWIvH7iii1bcuMPUIhv04xMg7XGNZGiKak12wEnPtv/s9MF112wSqJt4iGeYuyVOw
         B9/7qm5iglpAlVpx7DWOc6eC5g4XLhA4N9qC5UUybc4O6H2ObvScTY+L3ZUB+oerDbSb
         EpK5+cuXkoO4+h6vp1mTDiTRFjnapg6xPnZbY8sUe7e/V+qHsF0TT1uYzLH6a3KjUig0
         ukfMfuKpUEqfR9122Zefdn3YOKSkP2kAHpLPkUVfUP2G4FRdSbPdigcCaZLTlZWF8uIi
         4eEA==
X-Forwarded-Encrypted: i=1; AJvYcCVV0690kTQkJjq62flpopiPX3QD8HZwIu73Tvtc3/T5iyCEi+qXtxCGLgAb45dUYaWCaBQMB9soVlM=@vger.kernel.org, AJvYcCWFjcw8Y+G1felDH4MRJE0/NrxBWN/1fVUD+jGcZT1195vWuPFlripcqkHc5fWSC1ku/QOyXLJBwmahKg==@vger.kernel.org, AJvYcCWzgxi0pDtUC8lhAw8dHKLSi9haBvA5xRWP8GXv4afI+Wo0+CaDNF64O6NZTCi8jRSE/KQ2J0pu+wC/Wx3y@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrywe7OP1xPvzsEUVyX5jbNTi5AO1breJAZ+crHfn/L2KWRA6U
	hYJCf2W1UGg3MMI3+pkX0ZwKMWytnetPeuuKFBN5+J7XMqXg9TzPmF38s9Db
X-Google-Smtp-Source: AGHT+IEDx1lFFvhyLYrfDWOf/SFm9wlq+0bhXem0FcY/UH1bEa05NtFSrSKuMhziSZBt3G1nrSYMEQ==
X-Received: by 2002:adf:e7cc:0:b0:368:3f56:b24a with SMTP id ffacd0b85a97d-36baacd2ec4mr945016f8f.15.1722492837171;
        Wed, 31 Jul 2024 23:13:57 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c032bsm18696455f8f.12.2024.07.31.23.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:13:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 01 Aug 2024 08:13:50 +0200
Subject: [PATCH 1/4] coresight: cti: use device_* to iterate over device
 child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-device_child_node_access-v1-1-ddfa21bef6f2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722492833; l=1565;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=QFolg12C6V7SfGr1X/Q07nrFu7zCcR/xL99lde/5xoQ=;
 b=o1NXng6xwZU2bsAiSqsuCOR2/JS3PHQwTAD/8n1zoxZLZQalnqVR3k0a7inWk8yVvTao6fOkF
 Ftyxo1QzuLrBzMoP0hIJSns2cTyVWLJ3s25EZVaOxbH6HTl1dTm64K8
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
 drivers/hwtracing/coresight/coresight-cti-platform.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index ccef04f27f12..d0ae10bf6128 100644
--- a/drivers/hwtracing/coresight/coresight-cti-platform.c
+++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
@@ -416,20 +416,16 @@ static int cti_plat_create_impdef_connections(struct device *dev,
 					      struct cti_drvdata *drvdata)
 {
 	int rc = 0;
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct fwnode_handle *child = NULL;
 
-	if (IS_ERR_OR_NULL(fwnode))
+	if (IS_ERR_OR_NULL(dev_fwnode(dev)))
 		return -EINVAL;
 
-	fwnode_for_each_child_node(fwnode, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		if (cti_plat_node_name_eq(child, CTI_DT_CONNS))
-			rc = cti_plat_create_connection(dev, drvdata,
-							child);
+			rc = cti_plat_create_connection(dev, drvdata, child);
 		if (rc != 0)
 			break;
 	}
-	fwnode_handle_put(child);
 
 	return rc;
 }

-- 
2.43.0


