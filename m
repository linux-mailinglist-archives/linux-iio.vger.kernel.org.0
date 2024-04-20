Return-Path: <linux-iio+bounces-4408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF428ABCB4
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 20:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA7A1F21408
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 18:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555583BB21;
	Sat, 20 Apr 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="gSnOQz/I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B6625
	for <linux-iio@vger.kernel.org>; Sat, 20 Apr 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637688; cv=none; b=gJyLyK1UXFFBJGZGwnlIzQRMrF6hqH5qwBMBLlWysH8RbkBXz6bHDgq5hQRJjEoFmeej7h5Qtyzpyjg4C87UPEohGcsekhIT54oKaZ2qhS9p836Cvb1xIm10TPuHMOfleJKZbuezTTByntkqz5/Vci6n43WBoAScI132V25Kk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637688; c=relaxed/simple;
	bh=JsEtwO0QhnNPgrhfWqDV173hFJJoHn9UM1rmuDSCixk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vs8F/xDRopsZoZmZ8ju3KynfzkI2z91xz7DYAx073n8FSRaktwUBZxQTRrAHfV9viXJjJ05PEbFDWLf8IYgVYUda2XuYext70TQpmTCrWsvhxAVd5LJO5q7S9v0BY51LP37Yu66SDdcQMLJk39lb6gbQh/qVZ+DQJSb1b8npAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=gSnOQz/I; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso1741774b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Apr 2024 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1713637685; x=1714242485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hw2tpjItj5qpEByvQjklDiR7qMcQPE3hbGL35pj8os=;
        b=gSnOQz/I/HviZwJPbsKs5GZ9N3d57PS10ZD+BZ6ouKUE3603FQuVOH5MRnNH9/zZ70
         42/2CQk3n36/XdqTpWjOaRFMuPn6N1g5LNZ1a+niN2FSQAI2cJf3nJK6qyLIpadw+YcU
         kdpeHQg+EfH7StLTz2tRkAQ/f0KrgqK5fmEzGtvNYRxmaxyGZ5Rt1vIyqqa1StNoTsN/
         rtNQUZBqiyUHYMD0Z7oq92BLgnv1jyloAkLcNf5gma8x4LR0xmhMz5Gak8YhmrPKLFHh
         5um8GtFC1O5aY99xIymFHkcSGRCKTV89gNkWovI0tSBjgDHY9yNCpdgzZfJi/AAOz9Q6
         OofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713637685; x=1714242485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hw2tpjItj5qpEByvQjklDiR7qMcQPE3hbGL35pj8os=;
        b=JHCxUNoFeKUk4xVG56Xp5vtFykUOmJvkjMTP3F66ny3TDunh7ja2Y4CQazmOq3PpKA
         iQ8eTTuhg7mSm/n8wV2EC+rD6/VsZDKGQ779gbxtbjm3pmgEQxhynSaeho395iffSEAc
         0mEHzNzaHlZIGjcxir8laadz4DUoBRqyXO0Y+9uJoS/sL4y1jEUpnVIxcNVT4t/07HRq
         zOsCefoMLxoYFFEUZV9389JJCKe2oHO4XfpHJZsKsBcaa4znOUAqK8BqKnwwToZx8W04
         zpVBR2DfYF9sj0Zfu7RwdYCJWN9eHZ+AW0s2Fvw4Jo9xEJ3GMoEkV1QvIo019JNJ7YeP
         k0vg==
X-Forwarded-Encrypted: i=1; AJvYcCWhG9b4q9x2iXxNfUGlnJlGlHyvdQEkdVnbwzAmUGKTnnzV0Vx6LSsx2txko+yPN5BnAGQqBgx0D3h0i9rUXOnNu6EzFrRqYOMw
X-Gm-Message-State: AOJu0YxXa+vouhYylNj2PhqMlbCWTwtC3apCQwI+ka3640YEObIAEdhL
	2pWpGkp+/qebifyNvM9PoIGQX6QWrUdLslFg7cci8/Wt3bDlDfv5iqnKt3rl15o=
X-Google-Smtp-Source: AGHT+IFchco6gvcpFuqQFG2b98YmTEyvCk4wMyF+I7IYqRIAB2Q1UOfYe46citIHng6IFgztb8ZKjA==
X-Received: by 2002:a05:6a00:23d3:b0:6ea:be74:a228 with SMTP id g19-20020a056a0023d300b006eabe74a228mr6828482pfc.28.1713637685256;
        Sat, 20 Apr 2024 11:28:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7c7:8fac:7a0b:df1b:26da:f824])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b006ecbcbd2293sm5325268pfn.173.2024.04.20.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 11:28:05 -0700 (PDT)
From: Lorenzo Bertin Salvador <lorenzobs@usp.br>
To: jic23@kernel.org
Cc: Lorenzo Bertin Salvador <lorenzobs@usp.br>,
	Briza Mel Dias de Sousa <brizamel.dias@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped() to simplify error paths.
Date: Sat, 20 Apr 2024 15:27:43 -0300
Message-Id: <20240420182744.153184-2-lorenzobs@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240420182744.153184-1-lorenzobs@usp.br>
References: <20240420182744.153184-1-lorenzobs@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This loop definition automatically releases the handle on early exit
reducing the chance of bugs that cause resource leaks.

Co-developed-by: Briza Mel Dias de Sousa <brizamel.dias@usp.br>
Signed-off-by: Briza Mel Dias de Sousa <brizamel.dias@usp.br>
Signed-off-by: Lorenzo Bertin Salvador <lorenzobs@usp.br>
---
 drivers/iio/adc/ti-ads131e08.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index fcfc46254..cb04a29b3 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -694,7 +694,6 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 	struct ads131e08_channel_config *channel_config;
 	struct device *dev = &st->spi->dev;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *node;
 	unsigned int channel, tmp;
 	int num_channels, i, ret;
 
@@ -736,10 +735,10 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	i = 0;
-	device_for_each_child_node(dev, node) {
+	device_for_each_child_node_scoped(dev, node) {
 		ret = fwnode_property_read_u32(node, "reg", &channel);
 		if (ret)
-			goto err_child_out;
+			return ret;
 
 		ret = fwnode_property_read_u32(node, "ti,gain", &tmp);
 		if (ret) {
@@ -747,7 +746,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 		} else {
 			ret = ads131e08_pga_gain_to_field_value(st, tmp);
 			if (ret < 0)
-				goto err_child_out;
+				return ret;
 
 			channel_config[i].pga_gain = tmp;
 		}
@@ -758,7 +757,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 		} else {
 			ret = ads131e08_validate_channel_mux(st, tmp);
 			if (ret)
-				goto err_child_out;
+				return ret;
 
 			channel_config[i].mux = tmp;
 		}
@@ -785,9 +784,6 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 
 	return 0;
 
-err_child_out:
-	fwnode_handle_put(node);
-	return ret;
 }
 
 static void ads131e08_regulator_disable(void *data)
-- 
2.25.1


