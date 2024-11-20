Return-Path: <linux-iio+bounces-12432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8296C9D437F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 22:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC58B22F68
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064FC1C75EB;
	Wed, 20 Nov 2024 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PpZ1AOlr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6C1C4A0F
	for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138446; cv=none; b=m286iWs0Yf9lbQvDvf67mtFTRJMfUeDDx/RPtjWludPY6TJB4zV+UpfxNo5VauaBGg7VXp1bISMJiF1evYFz24uu6QVDUQVPpGIo8ehBkQEPQ1yqYnmiDFxQNz7yNEXFNZx3YeartDlfXRh95MAEXq0Uyzl3xrTMNlUUH+Ftqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138446; c=relaxed/simple;
	bh=CDa4K/qMrZy2Vk2sOAtkcJn6wgLoYlOypmZEq0L+kMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/TOBHRr46l3UQNIQQrcleKiyCUT1UjTsoBx1s1ar17CpYS0NQkUFOL4QdRVhi9udAJhFulMyX2YAsbyhfgATQhC7HhWCiPn2JYG7ZGHlfiB0dTUTojaX/NNiRaxZxj3xb9o8cHZ65c5awbgGUiVrrmZtzcFT3vfNd8MCrTSB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PpZ1AOlr; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2964645d2b7so219920fac.2
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 13:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138444; x=1732743244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw+ajRa8KccOrwd0yiTrzG6Wjr5FRjEkQmVdFiXTvr8=;
        b=PpZ1AOlrfZcpa39ELZXWUwBllV9lPpzBuI4mRuUclngjPu3Ows2SBDzpcRj5XARE5o
         728I0JhdLyUj9CupRkWG+ec36eKSIsVGo5nEfm+0Z/AVdZgkE0rgtNv2Zslr8yZLA/vQ
         gCepM6Hg8so+gEgRyDsWDqmO2K8y4womYlqhMU5NV1KSDJueTxGMV0W1q1qatWrG5W4i
         QJgMyiF9PZ6BBz++Znm9+FgH1+uspHA3cjCupVj0N7KkIwKABFB9fyNWXoW+Crprpxsq
         Hn1xNcyXNQ0DLB2IAd329yFbmb9+xFQchJeIrobpFFpCWUxod60ncNgjxoNbzRRaPPd2
         PAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138444; x=1732743244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yw+ajRa8KccOrwd0yiTrzG6Wjr5FRjEkQmVdFiXTvr8=;
        b=bNJhAYpbsEeKc5CtysvGD4Upt7/5yDOSDhhAmnuZh6kKRa8SoODZRucg8uXkLRniPv
         Nagmy3qS+uJLhJ3aLdWeR9jfYuvgLYEhDOXN6CSNco5aiHHeb2HkrISdT4ve1RMWkoxF
         oQnJ/y6A0jorTnYkWVK1d3SqNuSCPLIBXaQkZyeAhq8XGQ0yPNt9ixkXFRJ3AyP0dE+4
         WiWXsjjevkHKdYJNL2BPu9XHHCgX8W6EygSk2Swwgg2dd5MItPktgXCyBzC+fKIBKGu6
         TwqjX1uUIeRHGdtMj9Snsjq9Huyug17EpvTqVE3I/klgLScDegcVrhJZme8x9zXwQI1K
         MKBA==
X-Forwarded-Encrypted: i=1; AJvYcCXdvhPrWuxPmj1BgAyQI1hwWQ7srp1TrfFMatmI+NM6tMrhtSoWhoZuY1+9tBmnjbHNSQeRsOrKjKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdk2krV7Z0MBJqKYwoBlk01daF+2SKgI4r2Eqd4Q1jAvWlGDTQ
	viq+VDdwID2tlRp3rTa45Sa5zDb5m48uZrLqGiolp3emWtFuM3iwlCDjbfAvUmE=
X-Gm-Gg: ASbGncsFt8imP46s7c4J5hFdfaX2Fyabkng2QZF1z+cPctI/TWVKOl4IqujguesD0sp
	5vzHF9+SpIB4oAVT8A/nxYCNu69d5IuYRxt2t2v5LrLKXZ7jNvH4OM5e8DGh6uWvvW7hzszq9w9
	OKiBi5YAJhRnU6UmDziwxhaU69UJttCBr+OCUFA+uWEOQoiqUn1e8Euv9xZ7vaflmGNbg91bLSa
	dsoMdBZrgBhC+mSCJ/JJNZqtIvdIkxBNKfMaWio8shSvZdusVFF4cTp9WincRUgP+UGWd9AZdKi
	aC0B6Q==
X-Google-Smtp-Source: AGHT+IFt3OYUTddzXeyXQxe7QYviNNpiS7sqQ7XHszAFayFyZfwLOK9wvkkKMZ1SNhQi+bvcF8zekA==
X-Received: by 2002:a05:6871:d084:b0:27b:55af:ca2b with SMTP id 586e51a60fabf-296d9b5cd91mr4192758fac.11.1732138444351;
        Wed, 20 Nov 2024 13:34:04 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:25 -0600
Subject: [PATCH 02/11] iio: dac: ad5686: fix struct name in doc comment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-2-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Fix a copy/paste mistake in the struct ad5686_state doc comment.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5686.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 760f852911df..5b150f344fda 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -115,7 +115,7 @@ struct ad5686_chip_info {
 };
 
 /**
- * struct ad5446_state - driver instance specific data
+ * struct ad5686_state - driver instance specific data
  * @spi:		spi_device
  * @chip_info:		chip model specific constants, available modes etc
  * @reg:		supply regulator

-- 
2.43.0


