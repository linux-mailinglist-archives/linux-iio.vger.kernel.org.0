Return-Path: <linux-iio+bounces-12047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123E9C24C5
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A181C243C3
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ADA1AA1CA;
	Fri,  8 Nov 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kc4Pa0qT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC78197A7C
	for <linux-iio@vger.kernel.org>; Fri,  8 Nov 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089916; cv=none; b=FayoapkLxooRDAeMJwAj8epp58b+hbwso63NmuKC3B5N1fI30waosdrDJmNi/pR9+jSMW/vXGg/hGwm3dmvFob6hZg21RyW+D0PqKe9Z0A8wwf+DeWAXWQIe5NLJxXWlCkUX4qkJbaFQCejby907zdFjaFRfzG1wyz8VZRwL4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089916; c=relaxed/simple;
	bh=pJreQhjM31yTDdfw3j02Er/E1QYTkBhpsxxxhs4aEZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urEyA7UNyJUmGQ8HwQrzL//ncgKKa6j87U4K/QgsaCZ7yjN11tc+uQSMlXo5uNXnJ+W3Dpud4g5U08bCdXSs8Dy/x89ylaDwoowlyFa3t+5oEwMEg5+Q7vYPoSk/3sF4O2cmDmm/PrcIe1Gjiq25MWgELKo9/OHnId5CxHdQius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kc4Pa0qT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314b316495so20298405e9.2
        for <linux-iio@vger.kernel.org>; Fri, 08 Nov 2024 10:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731089912; x=1731694712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqf/i7NkwQQgUe1Y7/o4ldH6H8HVukNPCHUaw9BQ7ow=;
        b=Kc4Pa0qTxwxkXZRkjsq4GHFym3+gLfjxnx5Ft2cyMrOzTujYoOKNATVPrOdiAu8SNX
         GQNVWEPyaTEVo+qevwPFA1XFgKfVYlD1Sf8t/cA+mx36OHCBAwBqVzX+iSWGSyHgTffa
         iZpjV3NbL5LEyZCUofPzSrJiyeQvnS5djCiKqqIDDLiVrMUHH1zZKhZrTeFRZjwPlQ57
         U3xG3wLxux/NEZKcqG8Qwn0jSRcMwhUtzGRU8LWdB9HMyAERTzPJIGD+7Zgcla5WdcDM
         +RFma1w5JJ0jEOaHpof/Ey15xgcwfgbGJiImfX88swDqVm+sqM2RX4b84R0C2s6nfaZr
         BKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089912; x=1731694712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aqf/i7NkwQQgUe1Y7/o4ldH6H8HVukNPCHUaw9BQ7ow=;
        b=RgkgCsTgvyIbPDCEZTEp6zB+X8RfqVfXCPnoBsCQSUEJcGcKBP/DV8XiIaY7l1pAYz
         CgLf+wwfF8lyGJ7yc3CkFQ7o+Wo6GofGkCiFmlOOpENwBW4ZK+kaeDBBk31iw0GZsQXd
         ZiHte/F8NeRVRcWHs4oGmrwpmqHIMQDX6wXzxcZF/7EZbvzn41CQNCtwH4YWvK5f2Uhp
         PQWm8gLjrzARgBhU6MX3BfqZaLNlL/kmqsTpPci/LWYqEz3eHMEqVoC48KS1F2E2dpcP
         PTWu1kdMbFYYdkuPhUDdRjx6yumRS3VROmqKrlHgh1wpP+sJXkc0aWtCqNohKva6fP60
         Y7YA==
X-Forwarded-Encrypted: i=1; AJvYcCW4toGGyuzBoEBAdlr/gEdKxJtXe8qa/dHoUaGh2MkIaQVokhKmk68SKu8O0YSf6xJ7i/vqrt24D1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIcx+9nbEvr3l0y9qgz2hHsBEAQcVkRUntsFGjBp+dwhLWx8/4
	NJrRyUASSU3e/k39tW6Yw+Km9RSRIIH1I94KkBGxWfLqv6NE9OcJWbeQk6U0Gvs=
X-Google-Smtp-Source: AGHT+IH8xPdn7AUpzWkBfFFmIbfbCMmbMdP6oSIKbGuHab87sobedzdvs3GGm0r9dyCOFD8gVAKHWA==
X-Received: by 2002:a05:600c:524d:b0:431:5d89:646e with SMTP id 5b1f17b1804b1-432b751d00dmr28200755e9.32.1731089912508;
        Fri, 08 Nov 2024 10:18:32 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e46bsm5490421f8f.30.2024.11.08.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:18:32 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Mircea Caprioru <mircea.caprioru@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibe.com>
Subject: [PATCH 2/2] iio: adc: ad7124: Refuse invalid input specifiers
Date: Fri,  8 Nov 2024 19:18:04 +0100
Message-ID: <20241108181813.272593-6-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=pJreQhjM31yTDdfw3j02Er/E1QYTkBhpsxxxhs4aEZE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnLlXsC16VCmzjVuWD5yB6MZDfmJ9dRM5PpOjyR /E6c4qdiPqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZy5V7AAKCRCPgPtYfRL+ TmGDB/9XloFsptjASnI26f3gM4plPUV74dzpp8NetDE1zbUDapw7DnUafUruMKwl/3k1OQ4cZ1W Cs0qSxiFKzJefml0q4djruQB90qTyfe/F6CcdsKc/VQYdiBrweLL82RI3mWGnMzcX7HgD1519SS 9zDX3i6/UbYgpqS8Txp8tn9qegnvPwAbBuKGxg7KLIBs8j+rlsGav/Ap0xgpXruIL/pAeDrWEMZ +0Vk25LTh2crEudB12KZud69Qa7BxM97zimQ85fyBH5QADHNErNPh7Olin2eKURtd7gOeib7qQm dyitjBmkcV1TMxirfmBjAxaUISBmCnK9o+9SZnQ6kNPL3pQN
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
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibe.com>
---
 drivers/iio/adc/ad7124.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 7473bcef7bc6..bd5c0dbc0239 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -808,6 +808,19 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
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
@@ -855,6 +868,11 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
+		if (!ad7124_valid_input_select(ain[0], st->chip_info) ||
+		    !ad7124_valid_input_select(ain[1], st->chip_info))
+			return dev_err_probe(dev, ret,
+					     "diff-channels property of %pfwP contains invalid data\n", child);
+
 		st->channels[channel].nr = channel;
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
-- 
2.45.2


