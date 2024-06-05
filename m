Return-Path: <linux-iio+bounces-5859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA068FD51C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EB52810E3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 18:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354014EC65;
	Wed,  5 Jun 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zceh7r4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78714E2E6
	for <linux-iio@vger.kernel.org>; Wed,  5 Jun 2024 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610575; cv=none; b=VBljVrE+z6AuzpvLiHfNFsi2+4gciBbDoeYe93T7usWKpFMpwjJ//cc7JOQ03U7Lsr8ubKJK44kLd59ZUac+5dN9+AQTlaLZe2tqaURE6598tDrhEPWkbXjxbjUhmB1a2+RjS4bpHeo2WgYKplLujY6cJXDkQWszfegpvAMO/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610575; c=relaxed/simple;
	bh=3NTGVyytdVyzcHP8txKlFB9YPPGxIJEVxCzu2cUQr1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WyDd2/iVUeMEaJnpsXlxYtKOFZjOEKaANz/jEhOuK6biHnPw+LexIqfu7W/4M2D1n21gRdjxmOhhQQ5wC0CqLADZTE2HhTN4j4ZTYOsvt7ijQSbyGAiR5VSH9KJYYFu6d3YadB+wqjuTzIPRuObNGhvul1w3o/jn1jZNoaYvVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zceh7r4D; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627dd6a56caso319927b3.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Jun 2024 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717610573; x=1718215373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDI8h7ZoQYy75CqD6I2McYIto2hpIA5emU6fq1I3LPI=;
        b=Zceh7r4DKjZxj+a9nK/QaXDX6PywKjBJO0UZV1S/xJdKXimp/nnCI0wZvsZf0UJhwK
         7Q1RjJdda7ewUbgf1avKIEw/IlHVV0/kuQYnDpbGWhedQ8/BTcIzW73L2EnJUWVZdmg+
         PZ9u65qivhbL3++hcgSBbL4DG4bWaaEbCO+dFoE8ACY4vUfP6RaLzkkrbcCyH5XWZISy
         wDGKnK9ja1EPb9k9WJHVTZJ5qM0WWQfoT1vIvHa7kLuHD+Sqbr7dPNAVmelsUyhgUAwX
         A2L8gG3AW7S8JXvOWrFgHP2ygYbSqPQRbESNpKB37Y6rSBH6lpRPJcUdj1DyHb9Jg1wz
         zX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610573; x=1718215373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDI8h7ZoQYy75CqD6I2McYIto2hpIA5emU6fq1I3LPI=;
        b=TigmSTZvHw1r6ugG2JJ/ym0EEl61gFbKWDoiNS6tY3jBLsGiTioayt6hwjMmquiP9S
         znjG9XqO18SB7L7v3mzhrybMRqRGvStfwhhPm6+5rxkz+hKLc3iJQIAlhIDUaWMTARxY
         3bqvYmGJVsJDhzUMBuXm8dUBs/rVZP8rmHn8ukpjdpkusbnp/0fX4fB1vE4LigpS5sDO
         tr73t50pUhv/0N2A8mTxgQPYKGE6OVZ0uV2V6q835m3Ikz2W5X8W0VUz0jgA2tTAQErf
         /iAUgb4dI+nSGVDQyfAvlr5ceOGmeKjxOLvBg5aBrCmwn3HbuClfFY59IXfzSJsFymyk
         3Fxw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Vs7hLOy9ehCEA5dTn3l8f0ZZa6/pq4dD2Lrd158hjiHvSrR7SJ8/jp6rR+CVuUe5xUL1GbOyH5t8SoBZMlF9jLiahdKTkkFY
X-Gm-Message-State: AOJu0Yy9Yv3QkTXvO8vfpqe3sUhG6ZPiF7dIZjtcq64/ueJZgFQaFbbf
	mgpIGmo6wsyb9O5o+9SxORLSrXSClKCRUMm/7kz6ZmpIPZLTMGfYV8bOTbLntYVhMsiG7xvSxxS
	3AqQ1cjT+1Q==
X-Google-Smtp-Source: AGHT+IHsHtY+bAgPNOkcmVi64EeRKQimO371NMHALyHppPPqEXYX97pSerbED4x3JFp6tor3148MLJe9OAqS8w==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:690c:39c:b0:627:96bd:b2b with SMTP id
 00721157ae682-62cbb596fc6mr8780427b3.6.1717610573043; Wed, 05 Jun 2024
 11:02:53 -0700 (PDT)
Date: Wed,  5 Jun 2024 18:02:33 +0000
In-Reply-To: <20240605180238.2617808-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605180238.2617808-1-joychakr@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605180238.2617808-3-joychakr@google.com>
Subject: [PATCH v1 12/17] soc: atmel: sfr: Change nvmem reg_read/write return type
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

Change nvmem read/write function definition return type to ssize_t.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/soc/atmel/sfr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/atmel/sfr.c b/drivers/soc/atmel/sfr.c
index cc94ca1b494c..c1c8e59cf6fc 100644
--- a/drivers/soc/atmel/sfr.c
+++ b/drivers/soc/atmel/sfr.c
@@ -20,13 +20,16 @@ struct atmel_sfr_priv {
 	struct regmap			*regmap;
 };
 
-static int atmel_sfr_read(void *context, unsigned int offset,
-			  void *buf, size_t bytes)
+static ssize_t atmel_sfr_read(void *context, unsigned int offset,
+			      void *buf, size_t bytes)
 {
 	struct atmel_sfr_priv *priv = context;
+	int ret;
+
+	ret = regmap_bulk_read(priv->regmap, SFR_SN0 + offset,
+			       buf, bytes / 4);
 
-	return regmap_bulk_read(priv->regmap, SFR_SN0 + offset,
-				buf, bytes / 4);
+	return ret < 0 ? ret : bytes;
 }
 
 static struct nvmem_config atmel_sfr_nvmem_config = {
-- 
2.45.1.467.gbab1589fc0-goog


