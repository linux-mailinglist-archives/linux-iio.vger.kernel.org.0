Return-Path: <linux-iio+bounces-10081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B598F55D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BF11F22AAA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4522E1AF4EE;
	Thu,  3 Oct 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx2d8os3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758871AD3E1;
	Thu,  3 Oct 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976897; cv=none; b=u31Y4HvysKfzbCDbAnfBVuDV8pcQ6C5aDQ0vhYckMl32JyovGxtinaV5kb1nyIA4sZcQeOZuNEtSOsNe0vOdP3QesPNsnib4TPzKEdBUHb5OoOcNBjCr5gzIMu3Z3hJDTuYx58/kabJHiw9WpyWsegqHIwahynXPT/JqvYVT1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976897; c=relaxed/simple;
	bh=3D2UcZCozg5mtziUUk5vTYahXBxocqjYckSdyK5dx/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qTsV0VFzJmDNRJzxyrQhq0E9AIJnrE3pSDLW5FXfBXcsXqcpHMDVw2gTCt+ngxbt1bA85D3nNkivi8nX0r2pm566OogG5ZucO88KKaQ6Bda2PB0O9h/sygOZHzbWFSmjzkZWW9tJd0qkwPYWOgVDXmSa8boUU0674fcUtfqgWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx2d8os3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso11867655e9.0;
        Thu, 03 Oct 2024 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976894; x=1728581694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wz8mn2zxSXqsVq5jkg3nHNCDHyd967M2Mt/0lSJOZUc=;
        b=hx2d8os36c9WcoaPIIQpCCfFRu9j2513p4LAPlx+tjy/RPnlSjZxF28RLShzVsDDvt
         FLFdNFFAVLqnpE1ze2ykP6Qgkz0VogVCYy+JZ7QjKWHsHo47cCOqO837VrUcjXRCRPOT
         /IWcxZJT6RKY+aCQcAfrik1r1BeHYf4EjlOVRVttlcHK5dsabRNpdAC86i4FBeFMVeVt
         3dXUCMIxrAGSsdIzKF2f+Ys9et4I0oUgZfB5SdzfZCu9i8+wnqdfgQDzhGZbeMQGat5q
         +z8Qo/BRbbZF7/ir0VnKz01tBz1RNOoH5cB4JO4+cWjRYv/O801Hqy8uLo0mrxtPrBOI
         ejXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976894; x=1728581694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz8mn2zxSXqsVq5jkg3nHNCDHyd967M2Mt/0lSJOZUc=;
        b=JwK4pet0odxR0Ytu6n7IcMzFJDdIpfsUNcBT5AJ2l0zQlUBMEBw4DWlzSXAacp/1DP
         HsnfnDx4PajJlAHw2EDi8+NARsnvugdOPzoCgd/uGGbpD4J/T51r9URA91OgWZ9XLSwC
         z9pZfDZq4xP80nhug/udJMqkP3qa1a9yiIHSIniVeMrLMTbqgvJGt3AZ9mloYCSguwXQ
         IBK/EiVa/KQNwzW9LPeTZdsvX4BabSpveA/VrRDlDK4yYXpEz5jAGVTCSnfg/kcWwtcb
         8RZrCsVeSPH5QHftfBNMoc5dpez+8hCRZKQ/+H/DKgkh4IFGPETypLeLmkEkhqbkYjkH
         Ky8w==
X-Forwarded-Encrypted: i=1; AJvYcCUKyyiQfRnjyZ7VVpGUvdlzl1JTO6QtaOrx0v0ClgpJHY7cZdqlWe8kuPfdmr7t43XFyV3qsOyShIKnXwY=@vger.kernel.org, AJvYcCWa98UxnJfNcdhnM0FaaHWtgUErgD9EcqOMak2pFU1cPmTOhntisYLhPdnjFGNvh600CfP7btpoLF/cDg==@vger.kernel.org, AJvYcCXVR8RV6ciOxAYdeP7BUMl0MTiuOgeq3sfZmdx6quh7kPWb1rLUgW6kBt8PS3xYgZ30fH9AayC6YCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWVcwvLoMnEzcufdSYOaZB6U1kScQYlx5BD/t1d3ZoWyg2TPM
	nAP6zuDQZfdnvC2vKtg2zMFV8HNNCQmQH4J9bMjjH3xXBZn8HbLl
X-Google-Smtp-Source: AGHT+IHo+APz86h00PjtGq6DOnGX3/XEFKhnzXvT9fk7SgBeKfuGQG+33H6UlRik9DhMNcXPUe6fzA==
X-Received: by 2002:a05:600c:1d25:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42f778f2bb8mr66032595e9.25.1727976893476;
        Thu, 03 Oct 2024 10:34:53 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eadd8csm49640315e9.16.2024.10.03.10.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:34:52 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 03 Oct 2024 19:34:12 +0200
Subject: [PATCH 7/7] power: supply: ingenic-battery: free scale buffer
 after use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-read-avail-release-v1-7-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
In-Reply-To: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

The iio_read_avail_channel_attribute() iio interface now allocates a
copy of the available info buffer that must be freed after use.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/power/supply/ingenic-battery.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..fa6d6898f8722cc8e06a888a762a3edeb0474a6e 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -79,8 +79,10 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 		dev_err(bat->dev, "Unable to read channel avail scale\n");
 		return ret;
 	}
-	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
-		return -EINVAL;
+	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	max_mV = bat->info->voltage_max_design_uv / 1000;
 
@@ -99,7 +101,8 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 
 	if (best_idx < 0) {
 		dev_err(bat->dev, "Unable to find matching voltage scale\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* Only set scale if there is more than one (fractional) entry */
@@ -109,10 +112,13 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 						  scale_raw[best_idx + 1],
 						  IIO_CHAN_INFO_SCALE);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(scale_raw);
+	return ret;
 }
 
 static enum power_supply_property ingenic_battery_properties[] = {

-- 
2.46.2


