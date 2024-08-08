Return-Path: <linux-iio+bounces-8330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE11794C09F
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D655B254E4
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475918F2FC;
	Thu,  8 Aug 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUCIZsYK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9018EFF1;
	Thu,  8 Aug 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129973; cv=none; b=pHr1fXrI5R4UJB8KOk0kwaGivjq2crO0O3R0NUPEjy3ix7He2LkWSIw8UJFXagOkNFlK3swTPH7DWKzQ1Nb3JTtec0rMTzb1DIdY+ZmrIKRFR60z800hqgzGv24XVhjt06HR7eGudZd+qgJm8F/plGAr9JqekMBpGMAgE8LQa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129973; c=relaxed/simple;
	bh=QFolg12C6V7SfGr1X/Q07nrFu7zCcR/xL99lde/5xoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KO3QS7smB4K9O7rJQ3RCV+X/vKuiVbn/9QRMDiPDUkTLuRN8zogcJoQ6MoKmZi6SO18/Gdf0x2sgOS/MDVX3FswgTiQOVGWlQasQQPoeMHn/iscekTV1dOtZUJnBiL2fVrkuru0ATIlApSDbk8GPly4Dy5k/l1z+yfVPSIxtfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUCIZsYK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367940c57ddso570315f8f.3;
        Thu, 08 Aug 2024 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723129970; x=1723734770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZB0CSSKP7vKOy+3pwEVaiFc3nb6WEPjBuqxABKIpgI=;
        b=PUCIZsYKUJZqP/02p6/ixevumQKvlVDJOSIKtWPBtSrl4de7RyWY5cWNeSnWFHcUxc
         f8BBrdcFfcqeuURz8LWFtsY7jutnU6LmjrQ1pRrkX32YP7jAPVnPjkCAONInsANjNbPN
         9v5jwAFrFPdH6xRynDTzYSjsZPMudDFPXpLt3b9bUyF9PQ4rudlcaVZZV+ZWvBaV4PP7
         NQRX7p7WcKtsn7W5lKIXNzSqPMFSIhSR6fw/hnJmwtXxIwqfDewOcvVzfFwIxTDLsC3k
         u9SABpDzdEs9rbr4r/zfDRtirxDpJV2rCDGRqlMANHojmQTemZk6F9ZYLhXnUbQro53v
         0HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129970; x=1723734770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZB0CSSKP7vKOy+3pwEVaiFc3nb6WEPjBuqxABKIpgI=;
        b=JdSj674A6RNL2PCeEpSc02uAiMjtXZFZh04FqhC6jTiQTTjwomJY21yfj82RcyoadK
         6+RL7BEx8+l72oKHsQaw/vJTV1XUYvEns9h+xmbnKOAGKEYSsA28YHy0/hlV9k6gyIPw
         bCtnsYBtJ7m6APuzOz0U+ooSTgG4093oYYKAPD4V0UIp4ghBI7HMrI5zNq4G9Bcadodd
         JNNQF59N4MpcMtkJVcJNvy6xZmItuEXMwyu8FzooBTfa5DWLB0HY7zJ1jtP0DUZvjte2
         vTNPwL5loJ+BydvifNaIvT9Pi3HWho55j0cDg9PEsEYqcx95A/RnUOkv5vlMIuIfLM0B
         RhRA==
X-Forwarded-Encrypted: i=1; AJvYcCVtHthq3Xqy6he8lJNyxErUVCfYmW33cFPx8WOcKpKWHnzboXayg6zkRIe3T0NiGSLnxjUiUpI75xxMkHASv9Ca3neb2qLrwLymSN0paGS+3a5aAmlc/OF6pDYWFe1Z1K/buUi4Hq0KBvXMrrsEbvFloDMF4D8H2+Jb6ztA9Yzlu5rMPw==
X-Gm-Message-State: AOJu0YwoQthBC6U1284lLsh93+0weGQung7w1Fztf+lw/dj8L+UU63+U
	Xd2M1NVSyu3/YY2N7id8LulDqXp/jmTCt0zRIuBp/Nsoacw4csQQ+h8jMMz4
X-Google-Smtp-Source: AGHT+IH9zltZpOm/sE0qkVmJak8o/Wd6bbjajrHZx2HdZPpfnPVfdKLBv3qix+FWpktAZofLhGYfmA==
X-Received: by 2002:a5d:4f11:0:b0:367:9851:4f22 with SMTP id ffacd0b85a97d-36d27582187mr1389045f8f.58.1723129969708;
        Thu, 08 Aug 2024 08:12:49 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27157145sm2179881f8f.12.2024.08.08.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:12:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 08 Aug 2024 17:12:37 +0200
Subject: [PATCH v2 1/3] coresight: cti: use device_* to iterate over device
 child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-device_child_node_access-v2-1-fc757cc76650@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723129965; l=1565;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=QFolg12C6V7SfGr1X/Q07nrFu7zCcR/xL99lde/5xoQ=;
 b=OW+baiBcFL4t7BSu+v4bQLudFJn9v9nSRRI71zmTA4BvickjiebvByENRZ1XCURLG1Rhe4A9B
 C8q8bxBiPIsBlxR8l+U43AGA6m1Sf04yGaJj/FB0pRVpgGoUKmRCvAA
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


