Return-Path: <linux-iio+bounces-6236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6498B906B7A
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 13:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF320B21043
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FDF144D0E;
	Thu, 13 Jun 2024 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCqKee11"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746F14431C;
	Thu, 13 Jun 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278836; cv=none; b=Nz8YNXBBhOfKwAJjTqlMo5UOIyKBuGxF81faNwxX7D9J9b94QhpOBdVZAKngpCJvp8LMKEkmDbFK+oyNyAWr7GPxXbS0FdLn2RwcfqUp31kARh7YfiIV+WsWLoNJFa/7hlDqfkP/mHyUIwmvbejGFMxL6mZgm7Gh7MvNSH4/G9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278836; c=relaxed/simple;
	bh=KfgttE2wxTg7toHcpi3zBXo/ZcfOJEMJto09NGJtn4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDxlmvJ5WXNu1u3I0csee3mhdd4l87szOPVSvu8h7mclWxElROyc9PNjbE17rqhSgeeJaIW6RKWOd9OHF6FzAuVGtl6GljEyCWvfkisc63lXJ5xKElFbNX2lmXRST0HiiboaMwCuzDzEYr1RAGm65O+CgGy0IrZqNEPbuKi3sS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCqKee11; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso791222a12.3;
        Thu, 13 Jun 2024 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278833; x=1718883633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4vjbxP9TzabIkkUf/9mpHdXyF09ggIxO15d4HTT7aY=;
        b=VCqKee11W0dAlc/vFCQ6tii3UBjYhX2ALqQqzqNwh5koucUDOMEFpO1wJJ0MZ9/5m0
         6syvcmRTog5AxXkcWBbL4IgQoiV5I5gffQK507bIcwG70D+srMylOEhp2e+iJV9ignf8
         VCV5yUy4crRtoczQBQ4V73BTKn+O9QLAgmowcLvpLce3r+7eSB4k7dD7uwpC+DnaqwhC
         UqApjaXWL6UxZaKhvhPE0l0AEV0Uxra9x/AFkKob0lNFsVBiL2D0Q4292hTHegigMvB1
         rZ9S10VDqj+THBbUO1UxeK6NqrlBlBR9gbsdGJAmklzkdp5+6NdP/hAnJ8Wde3hI3jkv
         rf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278833; x=1718883633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4vjbxP9TzabIkkUf/9mpHdXyF09ggIxO15d4HTT7aY=;
        b=ajbqUbAp1410h42edvwvRgybQsXWi6Wel2kSZ1yxUpPYRoYStaj2+EnNQbe+DCBt44
         4wVMSm00BUED8TDokWSrSl4Mrl1mXz6uLluptjZiH1JswClvG0TVT4z2DN6cww4msnuI
         1okjE9KPREZxqOowE84G6AiQmtNTobGTV2PiS6d7yhRbkSMycl4SGwXOg1GOZvuOTtNz
         EaemExicgxMEIzky9TQ7D22QZayeaUc0TFqoQPSDsA/X1uMWOwV/bDa+AsNwt2TUWoVv
         i4SjiBBXFr3FCKC50YiNl/M6RYjRgJq/0W9Lz38RP4SvRFWUpaIsPY7jcoacU6299h0I
         qKpA==
X-Forwarded-Encrypted: i=1; AJvYcCUKuOGg7/Zuk7KottaKaECeVkfzsNSJiOWKuMaNXE2sgOUask4A5Qqwc8cLR4OWBoBE868/OCGtbPC+PEX68qYQFtaqOW4BADlpmAILFTQ5fJct/euS1MnY6deYboO7djZ8zN+N/LVC3O7bTFs+D9ecBy+CQZR5xsk4sUnvHqIaj4a/Ew==
X-Gm-Message-State: AOJu0YwPBPuoSSDvF882WXH9yoPoIL2ue10zgoRKSHOaANy/RFGWMpjY
	ptkINjLwREi+SbC5NipnAIFQ0BYm5uybmEm4vG3c5ic9Uqn2ctOy
X-Google-Smtp-Source: AGHT+IE+NK03i8O9vgp7i+x3wOWdBENGRA5PbWsY+dN9/g+VVyi3aZeog8Fks4ZoRKUDfFgX+sJrGg==
X-Received: by 2002:a50:d511:0:b0:57c:5b26:46e2 with SMTP id 4fb4d7f45d1cf-57caa9bad51mr3022527a12.31.1718278832711;
        Thu, 13 Jun 2024 04:40:32 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbb05b465sm308861a12.18.2024.06.13.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:40:32 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 5/5] iio: adc: ad7192: Add clock provider
Date: Thu, 13 Jun 2024 14:40:01 +0300
Message-Id: <20240613114001.270233-6-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613114001.270233-1-alisa.roman@analog.com>
References: <20240613114001.270233-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Internal clock of AD719X devices can be made available on MCLK2 pin. Add
clock provider to support this functionality.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 90 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index c30ffe47cd70..36e3fe50c455 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -203,6 +204,7 @@ struct ad7192_state {
 	struct regulator		*avdd;
 	struct regulator		*vref;
 	struct clk			*mclk;
+	struct clk_hw			int_clk_hw;
 	u16				int_vref_mv;
 	u32				aincom_mv;
 	u32				fclk;
@@ -403,6 +405,90 @@ static const char *const ad7192_clock_names[] = {
 	"mclk"
 };
 
+static struct ad7192_state *clk_hw_to_ad7192(struct clk_hw *hw)
+{
+	return container_of(hw, struct ad7192_state, int_clk_hw);
+}
+
+static unsigned long ad7192_clk_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return AD7192_INT_FREQ_MHZ;
+}
+
+static int ad7192_clk_output_is_enabled(struct clk_hw *hw)
+{
+	struct ad7192_state *st = clk_hw_to_ad7192(hw);
+
+	return st->clock_sel == AD7192_CLK_INT_CO;
+}
+
+static int ad7192_clk_prepare(struct clk_hw *hw)
+{
+	struct ad7192_state *st = clk_hw_to_ad7192(hw);
+	int ret;
+
+	st->mode &= ~AD7192_MODE_CLKSRC_MASK;
+	st->mode |= AD7192_CLK_INT_CO;
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+	if (ret)
+		return ret;
+
+	st->clock_sel = AD7192_CLK_INT_CO;
+
+	return 0;
+}
+
+static void ad7192_clk_unprepare(struct clk_hw *hw)
+{
+	struct ad7192_state *st = clk_hw_to_ad7192(hw);
+	int ret;
+
+	st->mode &= ~AD7192_MODE_CLKSRC_MASK;
+	st->mode |= AD7192_CLK_INT;
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+	if (ret)
+		return;
+
+	st->clock_sel = AD7192_CLK_INT;
+}
+
+static const struct clk_ops ad7192_int_clk_ops = {
+	.recalc_rate = ad7192_clk_recalc_rate,
+	.is_enabled = ad7192_clk_output_is_enabled,
+	.prepare = ad7192_clk_prepare,
+	.unprepare = ad7192_clk_unprepare,
+};
+
+static int ad7192_register_clk_provider(struct ad7192_state *st)
+{
+	struct device *dev = &st->sd.spi->dev;
+	struct clk_init_data init = {};
+	const char *clk_name;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	ret = device_property_read_string(dev, "clock-output-names", &clk_name);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get clock-output-names\n");
+
+	init.name = clk_name;
+	init.ops = &ad7192_int_clk_ops;
+
+	st->int_clk_hw.init = &init;
+	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &st->int_clk_hw);
+}
+
 static int ad7192_clock_setup(struct ad7192_state *st)
 {
 	struct device *dev = &st->sd.spi->dev;
@@ -414,6 +500,10 @@ static int ad7192_clock_setup(struct ad7192_state *st)
 	if (ret < 0) {
 		st->clock_sel = AD7192_CLK_INT;
 		st->fclk = AD7192_INT_FREQ_MHZ;
+
+		ret = ad7192_register_clk_provider(st);
+		if (ret)
+			return ret;
 	} else {
 		st->clock_sel = AD7192_CLK_EXT_MCLK1_2 + ret;
 
-- 
2.34.1


