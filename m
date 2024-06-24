Return-Path: <linux-iio+bounces-6806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC00914B0C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DEBB2464A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC713D51D;
	Mon, 24 Jun 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBDRUvg+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93413D603;
	Mon, 24 Jun 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233421; cv=none; b=d3uHEbn9AA3LoasEMCJXfwdz6+PJJB8IYLRH5gV0LxUnoTw1rHXc7zloGa53o2lJnixuA7Suz7m7baVy/4oJX85SCAbk+sH3w+lMdSmtCu30wnSyKJ6yufwGboRG1LbNAe8YJlwhz8OUw2qCYnzuBfl01uiJDFXMtAFKhQMdDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233421; c=relaxed/simple;
	bh=1RfKCKRM/QHk1sWWcHeNZ9DVL0BehZVSe3/VONNmJOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNJCD7+PaBrsLwiJNFW4TKGXwypgTfhK7wYLRi3OfzMdPzNB3fJNud0RIeT2nKk1F/QYRdYGB4SWwE+Spi2FmVDCBW68ACKXKEoC2e3ACBK5EaqTOCBIZVcpmYOae9jKbUVagJGiQ9vbMlh2OncMqudeii+e3zO50IRO+rkddEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBDRUvg+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4218008c613so35706145e9.2;
        Mon, 24 Jun 2024 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233418; x=1719838218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgBScQw99cAyuq+khOD513QlHP8xLsoTlTlZ97Pvf2M=;
        b=nBDRUvg+cNKSzzvhs4lCTdl8fNDwu7SGRmAHMFi8j4xeGERp3MaTHGGnu7qgWcoE2G
         lN44CUtRVAlCu2HhFIX2QAq3//Pum5J75CgpeXKpK9aHw2l7SmwBgCyZoJ0jV8JFmt8C
         C+Td7+7d8CbI7QABqdX/nL1VOx6Uzatnb++sT8q1fu5IOQGGgem6Ok9czH6F4srnDYY6
         yyJBajXKwDq6WJoL4zeuGYVK3zg4oHYad4QVDOQ4vWjP5JhtKJr+EPcXeBWx3BmtLrFl
         4+aRdiZeei4arahapzXMw0P09akrkOKplLc2Qsig9shtTVxlbcP4pUoQCbBgDggJMuzy
         u05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233418; x=1719838218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgBScQw99cAyuq+khOD513QlHP8xLsoTlTlZ97Pvf2M=;
        b=vp6JZLm/zqoJthmQ+ePTODea+GRSPaQKqmOOxL4y/6n5LgQ0uLFgWhRCG3UkUnLF5i
         aYF+7XoagdroY7fJNV5wH3hECx5tiXBulj+Z/vbb9iLkE5/ySuG1ZMWydN4Bio9y9UC2
         unDvbWluYT51LcLpgT6NMcDS54ZYb4mh5/9NyBho1ZZ1iF7Gy2dTG0sr0F3cFlpW48f2
         SMz+YfjrpMNSV+5yoJ+EXDgA9OJ+2Nyr/EtgKxiaVsoApMOiKI5bc/0E2ycOty6nwLp7
         Ac8XSJPd+weYXqNthsB22cwI+2yEYN/EmzWzP8XXYkUjHrs4pAXTG4ce8pOCsVFwvD0C
         KRAw==
X-Forwarded-Encrypted: i=1; AJvYcCV9FzaCK01xJs5la/MOWBNdxO8z6NT8k1CWg+9Qi5SbtbyIeZnNbA+1Z8GFLZoytVAZjkCR6MSv/MVcBKinn7tHIygITzMx0AiFOiNJGKbz3YTK9eFZhAQXpMv6FUCY++PSEx9eNJycKAVYzV22F0seomoUANsWP7bYdvkbcW8J+3JO7g==
X-Gm-Message-State: AOJu0YyOHmiTriUwtbub/nUx59sgbWn0dfg5bUfXcjcOsQuXLoZv+TT2
	sIgEDvXsQ+EentZ2VPFJCBq51vGcCniGuaJkpVcFlgj8FLHcBCTI
X-Google-Smtp-Source: AGHT+IH6cP+dGxMkEd79P/s+melgqIZg9s18OULCjuF6GipMKdS+JgzGNm9ZJ1LK/SIaPr5JAhJdTg==
X-Received: by 2002:a05:600c:4295:b0:424:760d:75ce with SMTP id 5b1f17b1804b1-4248cc18c5amr30231745e9.7.1719233418198;
        Mon, 24 Jun 2024 05:50:18 -0700 (PDT)
Received: from spiri.. ([5.14.146.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm174127905e9.37.2024.06.24.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:50:17 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 3/6] iio: adc: ad7192: Update clock config
Date: Mon, 24 Jun 2024 15:49:38 +0300
Message-Id: <20240624124941.113010-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624124941.113010-1-alisa.roman@analog.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are actually 4 configuration modes of clock source for AD719X
devices. Either a crystal can be attached externally between MCLK1 and
MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
pin. The other 2 modes make use of the 4.92MHz internal clock.

Removed properties adi,int-clock-output-enable and adi,clock-xtal were
undocumented. Use cleaner alternative of configuring external clock by
using clock names mclk and xtal.

Removed functionality of AD7192_CLK_INT_CO restored in complementary
patch.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 56 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 334ab90991d4..940517df5429 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -396,25 +396,37 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
 		freq <= AD7192_EXT_FREQ_MHZ_MAX);
 }
 
-static int ad7192_clock_select(struct ad7192_state *st)
+static const char *const ad7192_clock_names[] = {
+	"xtal",
+	"mclk"
+};
+
+static int ad7192_clock_setup(struct ad7192_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
-	unsigned int clock_sel;
-
-	clock_sel = AD7192_CLK_INT;
+	int ret;
 
-	/* use internal clock */
-	if (!st->mclk) {
-		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
-			clock_sel = AD7192_CLK_INT_CO;
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad7192_clock_names,
+						    ARRAY_SIZE(ad7192_clock_names));
+	if (ret < 0) {
+		st->clock_sel = AD7192_CLK_INT;
+		st->fclk = AD7192_INT_FREQ_MHZ;
 	} else {
-		if (device_property_read_bool(dev, "adi,clock-xtal"))
-			clock_sel = AD7192_CLK_EXT_MCLK1_2;
-		else
-			clock_sel = AD7192_CLK_EXT_MCLK2;
+		st->clock_sel = AD7192_CLK_EXT_MCLK1_2 + ret;
+
+		st->mclk = devm_clk_get_enabled(dev, ad7192_clock_names[ret]);
+		if (IS_ERR(st->mclk))
+			return dev_err_probe(dev, PTR_ERR(st->mclk),
+					     "Failed to get mclk\n");
+
+		st->fclk = clk_get_rate(st->mclk);
+		if (!ad7192_valid_external_frequency(st->fclk))
+			return dev_err_probe(dev, -EINVAL,
+					     "External clock frequency out of bounds\n");
 	}
 
-	return clock_sel;
+	return 0;
 }
 
 static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
@@ -1275,21 +1287,9 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->fclk = AD7192_INT_FREQ_MHZ;
-
-	st->mclk = devm_clk_get_optional_enabled(dev, "mclk");
-	if (IS_ERR(st->mclk))
-		return PTR_ERR(st->mclk);
-
-	st->clock_sel = ad7192_clock_select(st);
-
-	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
-	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
-		st->fclk = clk_get_rate(st->mclk);
-		if (!ad7192_valid_external_frequency(st->fclk))
-			return dev_err_probe(dev, -EINVAL,
-					     "External clock frequency out of bounds\n");
-	}
+	ret = ad7192_clock_setup(st);
+	if (ret)
+		return ret;
 
 	ret = ad7192_setup(indio_dev, dev);
 	if (ret)
-- 
2.34.1


