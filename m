Return-Path: <linux-iio+bounces-12737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF39DAA41
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF772826BD
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A98D1CCB4B;
	Wed, 27 Nov 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N5JTYIF9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FED2110E
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719612; cv=none; b=NzBNvgBvTveI0dKkp2CGX+l8fQPTCeP438QmDG1iyEjjVk3dGmnN17UphpFewyaQKlIW10v4YxT7a/Ntlh2ZRQkavM4tJFZyc9a8XnB33STO36tELSuH9+tK4lK6my4tkf7Bhig3w/eBu2hF3W2jKxZmX8/COHsM6XeZHn65kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719612; c=relaxed/simple;
	bh=UpCDFbHiLoBrphP0ZQ6Ni+CRtV5VYT4LknAceCYNRfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fu0TchTWerBuYWtHNtFbqOq5jAVkaVbpi+lAJsUSCXhuAzR2PBqfjHm66R38ze6KdPsRFLfcX6pSJAtq7HM9af5E25NtmftpF0kY3qfxKoBG3Q5kdh9/MTvzEntfkPXttMCVE/R8Q/2FKGWDGDP9I71jCa6hBJK0JuRnPmpUbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N5JTYIF9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38232cebb0cso5191218f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732719609; x=1733324409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RITSuX/h//gaahWszdW0fpwFRnABn01F981JW4yCXNU=;
        b=N5JTYIF960rX+xKrmdU+030IVgiZ2LCEEePiGfpyZvWElc5mW8X0p16V2/zLOesPSo
         HpLzf8JVPbsgkkU02SBlYxiYyERk5zHZ04VNxi9OUwKvka9ntjI/wj8PKpbe4W2RijLv
         9SAuIDZcpjEyFy0CP17wnEB3bKUljGla2y2L/Ai+XOtuV836bnPPdkw7QQpKQmSc9pzt
         UsiuJpMYFcthDcnIOLYiiZ/mIcNh3+jSBy1FrprCXdYMt7X6EzxUbyNQhmJIm9DlAgao
         RHCM3PRMCJhw0UZXACI+Rqx1vTPWGZPfFG7ViYyoI0cx3i56kqZRVHIy3vL3LyBJc+7F
         +jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719609; x=1733324409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RITSuX/h//gaahWszdW0fpwFRnABn01F981JW4yCXNU=;
        b=loQtzxAEE/4l/sp0bYPwrYaJEd9fI6ftn4ZSdGD8hJP+bNGjA0fagVMZqaE/gFSzsY
         TT99IlUuUqA74Jl/eUWcMjtkeA67jXZ+rEOrrRn08lFuzjhi8UkccdyskpS6/svuli3m
         VEOWi7WjUi0A1gRPsbk8N0LMfbzkAiAft25+zmupP6i26cx+BdIgfyOi6LfeBrZiQzDt
         1TFhCPHfC8KsZG1RsjA7xV6om037kJaEI3CTKOxcdM2RsrGbsY30ukS1yTntFVQjnUYN
         9xcb7MvEDGxd96aunTSGlaNJl3hjX6TiXQgmwWorXV6I1wYVQhiWwJqkMHivawEICs3P
         NrQw==
X-Forwarded-Encrypted: i=1; AJvYcCULfJR8WhtjviEuQqsp3ZviJfjcu4hcAzNR0IiZ5KA95tmjg7HlyRLWdWq8hk5eIGMjDM85qVPX7Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGopm5SJdZuwa8fN/ZSUDLhP9nRNZCotv7kpyQR/bYm6MjFk+
	/5IsbPs4meq3npUUi5nYh/OpDG0h7ecXzG87cYKid3vcO++/SdLc2tBvwIW9Cao=
X-Gm-Gg: ASbGnctkxiZK7OjxcL2qytEWX8FleMUpViE5f62NSgcx3DHEAUzX/w4ST8u/Y+e1Jaz
	3LfoYEh+COvmNaKb6OxsNjXuB3O9N6aVUtZ8tzoJV3o8Ljcs6VCdLCmiE9i7yUPteL0acvpW8Kz
	0fDliNnzTsSBaiJseq8TwMCvF6eJJYIeQfIr2JVmGz1caPbWWudUGQvIhvnwa49QUjNeXsOyLj4
	F1kIYKcf9US+oWJ13605Wy+oYU8Qc+LWzXdvubb4dAYIKjIE+7a1wXieUgiyMmwaOoArQoqJ4TP
	fl5i
X-Google-Smtp-Source: AGHT+IGORLPQpRh7vv2CdjslyQ02zjIg2bkEYo1NdQ+gj7PUhBJVCXY3Snm/nz9BkHcfEvGaz13+SQ==
X-Received: by 2002:a5d:5f53:0:b0:382:3be6:5502 with SMTP id ffacd0b85a97d-385c6ee11dcmr2568850f8f.51.1732719608768;
        Wed, 27 Nov 2024 07:00:08 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d25c5sm23413055e9.28.2024.11.27.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:08 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v4 02/10] iio: adc: ad7124: Refuse invalid input specifiers
Date: Wed, 27 Nov 2024 15:59:31 +0100
Message-ID: <20241127145929.679408-14-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=UpCDFbHiLoBrphP0ZQ6Ni+CRtV5VYT4LknAceCYNRfw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPX+1KZ5UiwNQ58Q3K97bSFf9BrVCEAt6t2k PM5wp0FvtGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz1wAKCRCPgPtYfRL+ Tjz4CACjHHVo+l9/VcYRQDnKfORqFYvMP8nD+d0iKLFNSwqCExEkt/LmCnUeIfU6zMDuNtVl4nZ lXq3uhWDF158WbuxaVkSeIdOqD8duPscvrCkqugupgL582DUiiqkEu273nRScnELACt7fvgUP+r GAT07eCS8KfRiZcBiP0DNZXI0mPKnC6T8zIMRNSkuMNv6hLrz+/e/MQuzAXTgTE8JDLmsOuyxGU YS75a3KtbiIOupj0/zvQ1XmVhG2RwHpcresJijijDCbN/y3vt/VtJUGxsjxHZo4+49eq4iM0YH2 3etfzBDSYA8AEt2jfY+Ovqe/eNE0bxUh7QojrTe5FoiNkoXz
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad7124-4 has 8 analog inputs; the input select values 8 to 15 are
reserved and not to be used. These are fine for ad7124-8. For both
ad7124-4 and ad7124-8 values bigger than 15 are internal channels that
might appear as inputs in the channels specified in the device
description according to the description of commit f1794fd7bdf7 ("iio:
adc: ad7124: Remove input number limitation"), values bigger than 31
don't fit into the respective register bit field and the driver masked
them to smaller values.

Check for these invalid input specifiers and fail to probe if one is
found.

Fixes: f1794fd7bdf7 ("iio: adc: ad7124: Remove input number limitation")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 5352b26bb391..1f3342373f1c 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -807,6 +807,19 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
+/*
+ * Input specifiers 8 - 15 are explicitly reserved for ad7124-4
+ * while they are fine for ad7124-8. Values above 31 don't fit
+ * into the register field and so are invalid for sure.
+ */
+static bool ad7124_valid_input_select(unsigned int ain, const struct ad7124_chip_info *info)
+{
+	if (ain >= info->num_inputs && ain < 16)
+		return false;
+
+	return ain <= FIELD_MAX(AD7124_CHANNEL_AINM_MSK);
+}
+
 static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 				       struct device *dev)
 {
@@ -859,6 +872,11 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
+		if (!ad7124_valid_input_select(ain[0], st->chip_info) ||
+		    !ad7124_valid_input_select(ain[1], st->chip_info))
+			return dev_err_probe(dev, -EINVAL,
+					     "diff-channels property of %pfwP contains invalid data\n", child);
+
 		st->channels[channel].nr = channel;
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
-- 
2.45.2


