Return-Path: <linux-iio+bounces-24001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BCB53E06
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 23:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2834B1894E45
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B252E5B36;
	Thu, 11 Sep 2025 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gkUS0WyN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654102E2DDC
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626983; cv=none; b=j/8BDs5oCBFECWHqvxGJok3vYzTZX/I61/RSNfJvUbdiMLj5BuxkgIYme4doTE/quaAGyr+J9ogMyupzUmIVFkqIxgnWpiFi6vKNluNqURDv0GQV9jDsMMTNfozN9IVMI3vzKpBYBdfoCu4W3MQxiuwt7x9JE3hZ+AHFCVCIm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626983; c=relaxed/simple;
	bh=BMUZul4w2Wdqu3+6ZxGgii/wI/FeYD/KgRdlY83CvQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4VdFAwXrjmvxv98JIKzCBZ7szzbx6pmfOWed9ypUDf/45UoqrHYTOJW7eBKC8KMNZ5qWWX5PkW4fh48NGGp38gVHjsccOZ/nrJWL6urpdBlg9ON8m3YP0GDDQ/QvVPzsfyZcpP2fGNUQNRUTE51z7QQLWzd2wVH7xykADZ6bQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gkUS0WyN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74572fb94b3so1196503a34.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757626979; x=1758231779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcSrjebCEmD8D7u4qyd0fiTNVHOhu3JhXWISUNqvRUw=;
        b=gkUS0WyNy7NGXBQs0bzGgeceZNEjQFEwjZ3DGP/QodTUDc2ZU7aq2ggbYnxqmroyFM
         LkS+Nzf+RFumzbCHJmUn7ufvpeFFuCOs3NByZTD83tguhj08N/AxibYZpZaxn7I8TYyO
         GJJL5PtsoY9ZIvCsHnjcIP/dGOLZOzPRJGq6lJ82cAgKMna+CVfYwFzD4FG7s/BfF5W1
         OLFpFNoqIJKuq5Ur83MJq6UjQhMU5tPlZdF2wZ9I0vda7z3J89/s400nIXxKqXBE1Tk+
         mfAsduUIFc9t0XhwavD5y80j4J2rnjcN1/EG50YAbhCo2dQBgStOq/KgsO5dfCORNRKU
         6Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626979; x=1758231779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcSrjebCEmD8D7u4qyd0fiTNVHOhu3JhXWISUNqvRUw=;
        b=un3K3GXoOLppZ6kdSyJEcRAVuOf/i0MZRuiNDCIl2yBpd/CS3EgPvg/5qQfwKv+hj6
         YtXpmefVcE9gZJ5ZywIh9ZNYPx9wOKBREFHDbM6//Zmn/koa+++ux5efhmpqarZ+XCBC
         K4c/vqKQk16vsnpSfteHvPiMm1EtunCdIS+yQNeFCkXQ8jbblpNiWDJVkWrei0DDD9dK
         KhmiEu4urX/KGf1uy+hXQukbDBNmlJ4Phx0NIEVZMg2Bw6nbcMV9D1daH0FkjyJrKWoe
         ACGnqE27tU0289i9DZo8XeKinqTwQZoKXThCDAUlenQzbNK4WPL8TVNzwYZuM61epe+z
         YSEw==
X-Gm-Message-State: AOJu0Yx2Me+HOKydVamG/eQTzZHs1iMWmySh+8fn0BisHv2EYTxbGJBw
	D4Tv/cx6dKAckDtKHVwK6q7iEg5N7haV4WpTCRvYa15ans9w+i2A5D7gc6CtFEguST0=
X-Gm-Gg: ASbGncvcA75EOC9ePTeSMvWyhgaXMhKeHSn5BIKMKo6Op20Qwv7e8o20yxSHzc9kDhh
	kgPTjQf3CIubnt8zodvrFasU8Y8slWhcfr/ZeaNIJ0DZQMNZZg8Ptds/J3EQKR9xjSHZYbduFQY
	kCwpX/SuuazgwRnSmmnshjHmSz5JZ3NtIBIXlnBcxbvo1Daz7hIMYBKkSBdTt/6uzmQz7ARhKp/
	KLz32RMuR58B7VxdCIaOAXmFIv5KFc6zoDqIvlCyu1nf2CE8zgliBqKm6tiqOnLIhP34Mbqjpwi
	/vBGgAImzWn93+S1MqvBfU2imixZcXYb0RS5lfJ6vHSV5yA0fbR1icBGYaDtfdH6PTky8SRR1NK
	P/wm+0wPlrQuQkDY++P5S1Z+9NP2bj8NnDF/l3pk=
X-Google-Smtp-Source: AGHT+IF6EmKy/M6sMmOkz7IT/ipRKY0iTQyQA6+wygNDE7llSpDWhnsTp4ifJ4gi9JoybvuSYwiLLg==
X-Received: by 2002:a05:6808:218e:b0:438:25e0:bf82 with SMTP id 5614622812f47-43b8d72c7d9mr315007b6e.0.1757626979315;
        Thu, 11 Sep 2025 14:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7c3sm604188a34.10.2025.09.11.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:42:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Sep 2025 16:42:05 -0500
Subject: [PATCH v2 6/6] iio: ABI: document "sinc4+rej60" filter_type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-iio-adc-ad7124-add-filter-support-v2-6-b09f492416c7@baylibre.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=BMUZul4w2Wdqu3+6ZxGgii/wI/FeYD/KgRdlY83CvQU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBow0JTtu85rjP1ShuAEpkAIG3qtLVmQ4OyaDOKe
 XucV62AfSiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMNCUwAKCRDCzCAB/wGP
 wABlCACF0wJCj9x2/tTQzrpNuclD6Z9nH9qotv5HHDdleCHFdeZi6nwrliqg8flSyLEy7Y8h+Az
 X3x5dejvhWgmkYkKpQpFZlISbIVtDKAC4gPeSBdabbdZNcyEepoMJzb3EgJF4+VkkMSOJeLxI8D
 xgqsnhNBwnmuCLSgLleYj7Ftw8YPHoB9mwf+ckHaBuqDGPGfW0TEz2XSqyLYT2yzRyfXdB12Sbj
 sRLDJJfzQPsMeWcwpPk9Oka1PJ3lOLNpi5yjH0jD0EIkbZcRoks799PXGyeQqFv0NdNNcYtrj0+
 W/Mbv0b5NQsZB6oZM/bEHRok+TKC0QpRu6nzilDnvF3npSQb
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a bullet point for "sinc4+rej60" filter_type that is used in the
ad7124 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b19249743398b1ff0b538b03ced0340b..829ccfd902f2ca4e5ae38ca025eb3c4a9fe1389d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2292,6 +2292,7 @@ Description:
 		  1st conversion time.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
+		* "sinc4+rej60" - Sinc4 + 60Hz rejection.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
 		  performance
 		* "sinc5+avg" - Sinc5 + averaging by 4.

-- 
2.43.0


