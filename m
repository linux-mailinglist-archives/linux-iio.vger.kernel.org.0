Return-Path: <linux-iio+bounces-18562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E53A98DB1
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A28445959
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026E28466E;
	Wed, 23 Apr 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr2Y/Dpn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709C2820DD;
	Wed, 23 Apr 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419642; cv=none; b=HMWrijEO8bliZ5x5RPu9K4zhsttRfLddXVfRsiyVC2oIej5ho9V5URRC801Oj2RyeBYgNhLH98eYMuxOtlJcyXhXR8C7cbXHOttH6kiedh9mj4gXUzyxShG6+8CcrQPps493fDeILNub6oB/rE4Sm4f3psUQZDbJpulOEweFUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419642; c=relaxed/simple;
	bh=UpDIKY3pJjsg0tL/o3e50SZvQnX44SMqdMbYkaQ+iwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoGLJ5F7BR4OHoJNTXarVQjvDPSYKQYAGc53q7PiMUgTpnRNe0JbVLPaBQgVfWra9r2Q6qUThqXNC9/snsbqvpW3KYJwU37RJwQpI/jVLXnK9k2xwhcaN6kvmXBTVwxu7Vj5/7ZWu5EamW/czz8FZ12Nlp3Vz7ebRC15qDaVyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr2Y/Dpn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54e6788d07eso1155647e87.1;
        Wed, 23 Apr 2025 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419637; x=1746024437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/4KyKt81RB7ipxIrYqCX2EK4rEQVNxxzLPICBaL9Jc=;
        b=dr2Y/DpnqJXKvghs8DfqasBsMChgRyo+nKj3bS5qSI+SFf0grhwNVuJX5z3/5jKSnc
         NLCyvUOtQtaaO4j3jXmykXHfaGUdVWQSMmizbkJnghqM8XO4DvK6hpyJ+7cuVgbr9E7J
         UsuPaA5teNAckHLgYeSL7loW5HK8B2aqmBjs+r/3K4joJNVxGwk09Ec1luok9dbp5nzb
         C8kHtf63oy5zlr4v6NL8Rg/l6BFkN4P6OGyz5ZGLnSKZxaDI31pSHUF/SaWMhB2TXD0Y
         pEu7kteKLPxZHiunOFPoNY84GYo9TdUatdZNIwhmSgMP5dsW3nFIpJ9pxSIxVa59eNMc
         OFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419637; x=1746024437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/4KyKt81RB7ipxIrYqCX2EK4rEQVNxxzLPICBaL9Jc=;
        b=CoOGyDAXERNA1+KaFToIOQGjATEct8YNaKlS/SyUELsiLNB9pAevhW8gFzYvo0G21W
         u04g3DV6gC8U2nzWGnia+uNf7O2wYwk+UbXXPEfW5V/7vIxgn/scTnY7XYdMdnDXBu+J
         Wvm64tjmMJuyVuCjJAEJyLbdVSR9F5wyWwAvS9S+0iLG5QtbV59hDKonaah6bmtTKtmB
         7NNCcjYfjXgI6KSBTksvrRtZJTjM+SdtUZWsgZQIt31eqhzxhxa75fE71uq3wPtmioKg
         +yPj68c5wj8oKSztQiZOS/S/HmS49LGuQfYFeLvubfhTpAD98KZBYD+Pu4aFvJ7LXPHU
         9KAw==
X-Forwarded-Encrypted: i=1; AJvYcCUheimo8ZVJYJR/5hRkmyr3Bm5sudILwwsdewcLB17zrzpo47TAkbO3Sn+y1RG76wEDePMGlBmpqQDISz+R@vger.kernel.org, AJvYcCVnEdCW5JnEKnL52kiHk5UMuokfpoKSquwZS3ClE3MCxVmAzK6oenKaZS/cIDsfScgxqREF7luW4rmJ@vger.kernel.org, AJvYcCXMdKdreQ++6Axqp0RrJBnMS3ECuTCKZZrdgKdQfWl3K7EUEHMzdRqJdIiUiVw6LE+bTXAQHyioL0jf@vger.kernel.org
X-Gm-Message-State: AOJu0YwEsi2q/A64bCWU7Gd5Sil4DF9a8s5HGf5F2lN8YrZMZFP/V8r1
	CtrREt3qkuwkFr/2UKcQNyfgU/qnX8BuRh+9mV58rY4Qk23pzcDydalJWUGcPGA=
X-Gm-Gg: ASbGnctI8fbbpmtnHamDjpo9TXaM1e7eGHNsqRTavbYnENGJMgZ+p79ehn8vOBjINeE
	Na6L2T231svgHb87EXVOzH8o6t8a08Y6dW8cPZgkJycdeGcsLfpqFv+bbRgjvB8BRohVZ6v62mA
	AVsup9AOgVE92CuSTA5HWoR9B1iRXzOzxFHB7TqV1VaSdvAk3thCCMkVJDAKGd4yTCyz3ElY6d8
	JCEje0GJQT71cDkhTpsl+d9UZyOhEMTFt+ed3RJDC2ta1AiJjAcrzIr/7pHdW1xpwMNsxN/1W+4
	Q02QW6KLFoAg8D8WT1YbREpOR08c5lWfAw8mqRjIrWiFlN616+Tuk0dQ11Qjtb8WiaOknWpLhe2
	as+LUkSRq
X-Google-Smtp-Source: AGHT+IHnDzj73iLzEb58SlUWFmg6xf1a/E/lQ+kOp35/ROokHGBXj6Iy7ifS1ZLJcyWBdltcQwOuag==
X-Received: by 2002:a05:6512:b88:b0:549:7c5f:d961 with SMTP id 2adb3069b0e04-54e76ae206cmr910207e87.17.1745419636769;
        Wed, 23 Apr 2025 07:47:16 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5f61afsm1598498e87.246.2025.04.23.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:47:15 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 23 Apr 2025 16:46:51 +0200
Subject: [PATCH 3/3] iio: adc: mcp3911: add reset management
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-mcp3911-fixes-v1-3-5bd0b68ec481@gmail.com>
References: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
In-Reply-To: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
To: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Lukas Rauber <lukas.rauber@janitza.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=UpDIKY3pJjsg0tL/o3e50SZvQnX44SMqdMbYkaQ+iwM=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBoCP1pLQMzyHv0fQVeyz2yQ8hdUUwCDYdyMnaFh
 aaInEzSlpyJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaAj9aQAKCRCIgE5vWV1S
 MkhnD/9hyCNEiqQYXS+q6i3QjhSGxp/gQmtES0AwjvABp16rlTWw3jA8r8Ma9EpvWQM+MH5WdEu
 w4fZOcuiGSo650MoleCgESLJ9BUm6ukFBJiKM25+EmeMLpApJc+ZzKj9bgVUJQU2bISblVLi+3I
 Aw9nPGtUsrN0VCLgG/GvjXu++Bffkd7qU+lnetnHOOrDwlSGz31CGAmyCBkLrfGdDCLTmcBXPkb
 /QchArToogdXt/QmMUnZTGbrvemF9B6d8ivsoA11S69902lWFq830XrLCdMMwAQC2CXbhfJcBvh
 LeSAJmpx2SnfMALK7sfC/Ozpyz+5Amg0xvd0piEz2d6vOy+9FzD5PniNMC/783Ygq6XABHrAbSx
 obImB54pdCMDfAjC2sq30HjZmHjjCTaz0kHNK1ifjETjpML/NlGBmBN5uMN+ng/8ncrwBldX0WS
 B9iR1vzUFyYV33LCoQasYWiR9wZrl1friyugjNDCgRRv9zBcTxUUVeo7OX90ufBH34CSZNF8vjg
 9+jSeuKhKMfxC1BkzxDXP0HpqNV7UplyAJ24UAG2+NNW33F06aPtCyEmhkLMYOKST/niso3DtAY
 gs7Mq1ddPqnHqQUxXjpRu7pD+/gvZ96/Y5ZHtzaAus571zkIa8MUVsS8cxKnWygqVCK7C++8V3Q
 tT0yx/nz3W5XoVw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add support for optional HW reset.
If specified, a reset will be asserted during driver probe.

Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index b72ed4928da88664a00dc143ebf218cb4a7be421..4c04ce1b3982d84286355ee427a92aa55ff2fc51 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -11,6 +11,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
@@ -706,6 +707,7 @@ static const struct iio_trigger_ops mcp3911_trigger_ops = {
 static int mcp3911_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct gpio_desc *gpio_reset;
 	struct iio_dev *indio_dev;
 	struct mcp3911 *adc;
 	bool external_vref;
@@ -750,6 +752,21 @@ static int mcp3911_probe(struct spi_device *spi)
 	}
 	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
 
+	gpio_reset = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio_reset))
+		return dev_err_probe(dev, PTR_ERR(gpio_reset),
+				     "Cannot get reset GPIO\n");
+
+	if (gpio_reset) {
+		gpiod_set_value_cansleep(gpio_reset, 0);
+		dev_dbg(dev, "gpio reset de-asserted.\n");
+
+		/* Settling time after Hard Reset Mode (determined experimentally):
+		 *  330 micro-seconds are too few; 470 micro-seconds are sufficient.
+		 * Just in case, we add some safety factor... */
+		fsleep(680);
+	}
+
 	ret = adc->chip->config(adc, external_vref);
 	if (ret)
 		return ret;

-- 
2.49.0


