Return-Path: <linux-iio+bounces-23996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BB2B53DFC
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 23:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9581B2200F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9B2E0907;
	Thu, 11 Sep 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VWcaKkOb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075E2DF71E
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626975; cv=none; b=u5TbWcHpxzUSFD3f4hmbYPyCNSaylaq6R6gc2Lp1UEXrA3ZeDJ2dSzdkLymaOYH2NHgT2SgtDoUbdmCaqBWp7MC0mpWP918Q1Us/CAFLixwIBcKpB/GV/lJf4Dm2v3j7AEjOpNRFD06HCO3HZMP5gK/noKCwQZs7SA317/5qpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626975; c=relaxed/simple;
	bh=gDn9YPJHyqGcki3xUliu4EoJ+ebT/H69rs47+Giddfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yn/xQEGvtaOcFxqE7ezSj1Y9c6RTemHhrCxPFDrcVsYvBfCXXFmSd3KW7EmjLROmT2tlOfEVMY6L9h2n/H0MZMEs8sZAtxJWUoUd9MwwrL8GkZFWLnP7Qv69OY9knea7SLM21zh6+DLtJvZKLhM+d4ayVgXSCnYB7AGyGUHzZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VWcaKkOb; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-750e52fb2deso1110159a34.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757626972; x=1758231772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhUpT+YwVFW5P8lRHWLBHFBotGvvsI+OkEJy2qzTADE=;
        b=VWcaKkObqZVdma6bZAUFRdzI0B8L0OoxA9W08cYwFkq0St26NcOH5fb6nmt5k+4mMi
         HPxUJ0JEl18uDUJzi0XR31U0bq/2yjcUi2PYGcLrypeS9CIuYDxdpBobESiDgwo9tNOI
         PkgZ6So+ef4Qm5nZmYehuDVcNk8j6WXoHl3IA7x+Il6V72t18RrmsfGgrF5/XHA4WYDY
         9X1/e0+vHjvGkVtkRc1ATziHO/YaxibMs5Dm18/p43Zz86j/uE6JT5x9rTSTGK/bRF+2
         HZ5Kth/7ViS27prDXb/20ISVdcKNayE7qAVweCXrV9ChiyBk8zU/rsF6e3R6vIciGL7O
         l7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626972; x=1758231772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhUpT+YwVFW5P8lRHWLBHFBotGvvsI+OkEJy2qzTADE=;
        b=d9aAh2999N21gtcwA0Xg5vf/kGLMdanBpgKl9b3fp/bZj7rBFUMaxEH9Io+uDFrcOb
         t1W53TxswnR8aujruSP7Uiqg/vLfivL2w16iRFQi+rEnoHl3pvXx1PCNk+H/FFNsjS6N
         Pdk4tqUId4V8swf41eUiR3jjRXfmjsLHc5fmIZi4eF534cuk3KsQ26kbK+8KGEaW6MfH
         AJNKpfQM6XoL97cVzLA3kNRvcxc5IzipczFuksRh4DiKhC23QkPjfyS7aEyvkFmvctZf
         oi9CRXuNPUl78+GjrWATprsIb9cNnLuCmVw2NL5hoAeHnCgh7wJbGpKC+xfKUpLRABdp
         u0RA==
X-Gm-Message-State: AOJu0YyGuZAUUEtUnvw2TzNMV2ySEmWT+jzKsbKiVwqLm748C0+AwA9H
	IEwB4ooDr9IMekblNACyJatRSdNlkDWb4J3YtJH2qtaNTn5aZvgYxV3I+E4geT/9o93MEeb5+oH
	rsH9fHQE=
X-Gm-Gg: ASbGncssJIZGYqiu7voc7aM6gIT7WOYoZ+lckKTfiVaO6uJ/4SXuyecYnYMABZJHzU6
	MXeGIxHHZIzRHqqPBerP9zxK7jI6MXaY7dY/16biFiOTzAfDCrz20fTmfk9iLRWWiYMtnzshr/D
	Jxqzk5nlRwFX3KGwiK0UkIiK8JD9E6ZkC00dZlKR41Zq+yEVdQj5mRD2pwipYn0PUhcfzlM4O9o
	Kc0s6WnwAaIIJErlwh5CNLqqGVFYuulxMICdEUVdzsbcDeGNhdjHk3Rh4DlUl7WSIS5tguUqHrM
	zDMWRQB7Y0LUNGUY6rluFCM6hCagzmHFWzKZQzppCFJA39Y17E1wDkXzyuMkf7cYX1V+pU4juV9
	k7+HBt51tGqQGnlJKJH3Avwf3Yh7x/IsEEd+FV1apwur5W9cAtw==
X-Google-Smtp-Source: AGHT+IE5Y8tGyYb81WyBJWOVCKQNxEz6s6NWWbKX1L8PE0XbC812+1aNvMndegimJX7QCIUF1eaqFw==
X-Received: by 2002:a05:6830:498e:b0:745:6166:bb5b with SMTP id 46e09a7af769-753551dbd6bmr521082a34.29.1757626972648;
        Thu, 11 Sep 2025 14:42:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7c3sm604188a34.10.2025.09.11.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:42:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Sep 2025 16:42:00 -0500
Subject: [PATCH v2 1/6] iio: adc: ad7124: use clamp()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-iio-adc-ad7124-add-filter-support-v2-1-b09f492416c7@baylibre.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=gDn9YPJHyqGcki3xUliu4EoJ+ebT/H69rs47+Giddfw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBow0IxdY7aUq+FuVQrVan1CCmcsp5qV1yThM2YA
 UaQyXpVw4KJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMNCMQAKCRDCzCAB/wGP
 wEz2CACBl7sATJvtRYDPwiq53Mo2XdgBAw1/FzB3uQ9IL343V7EiRygrXtB1YnDkAdKdHx0zf9x
 jDA3qsfODH7HOJFB/M5G8UhY3gG5XSVh+ERUShWTQ/BAoPrMP7fU2MG3gjCIX32HBuvZ/6PV9G/
 vcg3wlwCv584EZ924HhqhC3Y/4xn3coN9uQFJpxJHRlHQak8czI0+qbpHeUWsCZxRxkxJ4Gx+Bd
 B8A5SKVRMYiC5HoD+G96Of0ZaOu7u9v68w4bSTMgaIJYDcbZqFoDecUrrBwOblkoFMYUqXafEKy
 F27jgAt8dG0cICoL9Aef4uH5++N+jOUuVYmyMBoIL5tTV9AR
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use clamp() instead of open-coding clamping.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 15d98b78ec2709e14c354a64f14e7deefc3bcb56..8f6ca33d0c902be4ada103a32f37855c82a5f2fc 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -299,11 +300,7 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 	 * FS[10:0] can have a value from 1 to 2047
 	 */
 	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
-	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
-	if (odr_sel_bits < 1)
-		odr_sel_bits = 1;
-	else if (odr_sel_bits > 2047)
-		odr_sel_bits = 2047;
+	odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, 2047);
 
 	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
 		st->channels[channel].cfg.live = false;

-- 
2.43.0


