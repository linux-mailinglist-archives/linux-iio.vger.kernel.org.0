Return-Path: <linux-iio+bounces-8504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA49538E9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8605283F0F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415F1BA868;
	Thu, 15 Aug 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="phoJ4P0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070129A1
	for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742541; cv=none; b=Ry77B+e43kjn7ZKs7z4sJVqeqFi0quP7fnT9/fFZ+E1Dy4K8mZAY5j5ne5qmAYwEldXZmsQ/N1H+sVP8JCAXYzDuuy2pcEEFbuYvZ+wwiMP4Yhbvv1sjUw9B8+wpeSuROytQoYaCxPyS5mb9USQUo5856gTfHSwNELjWDBY+hnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742541; c=relaxed/simple;
	bh=WmTXvE8G3cxrHN9egH1FEwZfFqBMr42bXrUWyWymz9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOpBafxm7nTWzg48n5Mqo0DExHD+w8gWaOamQ2WveoaWSxxde1zgsr8tn7qJI4YbGJCYMc49Vv8PKq03oVWeVhejyQ/Yr1luCak+vSWyuXKwgSm1C1eX7LCUrwlhtkxwTTS4jr8mh992wiqh2osU5IRr/yZ6alIStauaAkJQZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=phoJ4P0K; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2681941eae0so728367fac.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723742538; x=1724347338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHRAF7kmvflKalOLusR4Jap2GAzcBGxuZVBcpBXyMtQ=;
        b=phoJ4P0K8j6n4/N4EzFIsouNk3DVItQOlq8BE/0KzYBYllYpdmJxZArS2dhUELXU/o
         H+Gra2erSzkxiv0wqLep1dmTjbQxS0UUY7Oe6v87qI72FHGVx6HP1lEuHQl9HaQte425
         SXbttOTupTt2YgTFqmaOEWLC6a6uBUQapn9rcG1K/myQEVeYnE1j+lKFgXzxVbkeqmrH
         qXwOeS32E73gfpdXsd4cBJweG0ZDeuWB0wkNH/Nylp2QWnXiaU0b1R6KIR16M7LMge0M
         OXJbritqW0V8rqfircrwN3peMMYBYYHthDRW2tvgUP9YDZAIpSz6GslRmm4aEhtQNL/d
         9YcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742538; x=1724347338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHRAF7kmvflKalOLusR4Jap2GAzcBGxuZVBcpBXyMtQ=;
        b=Osph0E8VVpy8yZ0Euq0kNrATIT3k/r3nZ87u7DMSEQvJiBJ1xfZLgnwaUych9St0Fj
         2P2S+DgYatOIxJtiZM7vmsTU5R9C/0ixVA/EnQ2MACG66Ppu60L9+T3u4u4N4nZL6fY7
         hI2eWnZlZLYvuXpLugywWfNLGkqOibRNQX81l3N3vU3j1SDMEYUAokNIkqpbrXx5Kgh+
         9gQTUy3ReFaz9MlV2/FyfOMsiKCMTVXRO8TAioJdGriKfVqRes/zWsRgPK0+hdcClJn9
         WeUHtwOs9xE4XSybskvnfYkSCZmFV2hlJZLEnpzVLGCUdE74mYhef4PqwnCJM+PAK4cz
         6ULQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6tSJrJrvnaTEPzhmAbzHhcFOyvqvBdxF2Dhxd+iP+FKN+xGG4//OZfKmprZf9lzJq2kFxYphJoUfXWMMVzIv6Grkn2Z4PL2xl
X-Gm-Message-State: AOJu0YxqxLlMmmLJ6m6PINgfpVSpVGlOsXmDTCT55dSFuoWqKLgjHeOY
	nVrGYFGec8HHkyGaLOA8m+iwra7G3DDD9rRrI9LQPnq7dvcUtdLsNzMUSFvWd8M=
X-Google-Smtp-Source: AGHT+IEh4WplaZ1SJtcdjCsOA0FNThgn+ugIMMYYb8x0r3LFGNuPLS8DWjeiURI22hPEwttiGS0L4w==
X-Received: by 2002:a05:6870:6c18:b0:261:39d:afa1 with SMTP id 586e51a60fabf-2701c3db78cmr207494fac.22.1723742538620;
        Thu, 15 Aug 2024 10:22:18 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca66297d0sm345327a34.68.2024.08.15.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:22:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iio: ABI: document calibscale_available attributes
Date: Thu, 15 Aug 2024 12:22:10 -0500
Message-ID: <20240815-iio-abi-calib-audit-v1-1-536b2fea8620@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
References: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

There are a number of light sensor drivers that have various
calibscale_available attributes. Up to now, these were missing from
the documentation.

Kernel version 4.8 is used since the first use appears to be in
commit eb869ade30a6 ("iio: Add tcs3472 color light sensor driver").

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 78eca1698123..67d8d1df23d4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -575,6 +575,19 @@ Description:
 		production inaccuracies).  If shared across all channels,
 		<type>_calibscale is used.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminanceY_calibscale_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensityY_calibscale_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximityY_calibscale_available
+KernelVersion:	4.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available values of calibscale. Maybe expressed as either of:
+
+		- a small discrete set of values like "1 8 16"
+		- a range specified as "[min step max]"
+
+		If shared across all channels, <type>_calibscale_available is used.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_activity_calibgender
 What:		/sys/bus/iio/devices/iio:deviceX/in_energy_calibgender
 What:		/sys/bus/iio/devices/iio:deviceX/in_distance_calibgender

-- 
2.43.0


