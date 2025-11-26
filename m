Return-Path: <linux-iio+bounces-26484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45FDC8A700
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 15:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BDD3A7420
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5D304BCA;
	Wed, 26 Nov 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="apnJSRAJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E1303A19
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168390; cv=none; b=O546ytlAQ/itMwPvHGEGn+ZDZ/NiLFUt8EwpdRNj6da7vqoZKCEj2Bet6fq9CR+SGpoJNQWee3qlzKfi0RK7o/UxdvXXwcnEQ1Ebs2/yA/D/yJpBgvzvK3d+uxqIorGpSdmwOYZBkGeJLj5a0+bB6g0XemXskA485nA5GaqEgnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168390; c=relaxed/simple;
	bh=RHITrrrdL1KbRz+2OaiqC7ND4MsOJXoquLMuZzaPSJo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=c8K+MQmbgV2C+BHxFY+32TigZCAccANWp+2UEja2b2jPDz4l2FpoCDcUFWwqDhSp+Ep6y9TZ/G89LFwNoAPFBJdSehMGmFRatTjY2ytS0OL/o2+YPnXwPq+PqAxjhwtzOXN5MWpJcAgUabRIEJFHbF4CF9V5pHQQouav8rl7tcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=apnJSRAJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so10960777a12.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764168386; x=1764773186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOokJ1rU/lLLJdG3g/RrG7wYNXdIC/v1Pmh7qqiWggo=;
        b=apnJSRAJR6KR/MUf6YPgdr39l3Y93cGQ1Id55EKjZDzDYKtWwO2l4YNrw0Bbggjcbu
         aUpXPhYfZ1l5gKjOVoMMlqwGzFvCocbOtBvBT4QddqBYPL+VgyCYlpFML+RgQJW9dNq0
         /kFtN6pcjmGMWpiQ8E48qLmbc275TxrfJ33KLorAP9TGJt+W86MxCCuk1d4N/0eeY5E7
         9C91WXH9z8TkKj51iutM0dlJJglCeemZKI8VqJHwGX2nUTN/GpBwupdC4N9eznUrD3Ch
         YbBoQRSKzttMIo+UbKEkWaMLsmNXsoaqAVgHZY8Az2VtrGNQfcVNhmact3z0WHZCqnlm
         UtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764168386; x=1764773186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOokJ1rU/lLLJdG3g/RrG7wYNXdIC/v1Pmh7qqiWggo=;
        b=nFqXTUGupTIFWMVAZJgwdk7dbGiyeKr9VBBNpJBMfWXn5t/VTcAChiQrUpK4s2kY7L
         DzZu1MQdadK7YCV5HOWYfGlNU2lGIqPHJScvI8Df5+ju2ASqwSJJvyUy0R+/J1BAqFCa
         YnUX6BHmhO9ZAzxJmRymNbhYiH0FPXlAsy6YiXAhPHGp0PR6lRh2J5O7IAdTOBa2cP4Q
         cxEy7FTElj4VHaS53lONGaadIXVreopIqEZK9NIZaWwIxspxBEjADNIUlW8adDusc0v/
         cFIgM4Tyda9PQegkLxE4tg1ptFQRBmQSNzaNX26Nr5uJ/rdse17XVN/NZ90uN2d16qje
         lh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuQwe9JyhC2sMgZOr3sWL9lvU2pUVmlmW7Fj/nPD9PkAs3RENyGzGSIHc9GLIo6pBGDTQynekZBjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZ3+B/ge+0TOv5hnYpFIW4KAGXF7hZy9VnYFdxnCO+UOUHlO0
	D4YycWiDQRgbwpRwl+zKDpMPvxL/ThXLjgvEZ8kTxxESrrUUq/6cDeh/3CPYkSbPoXg=
X-Gm-Gg: ASbGnct24xasqGj6RkmSAaOg81RzS11EUn4exKBmyi6DJ8qE35vSFwyN89sapeC7PCd
	b2t9fUPuxURqIT0h7wzPwwYuVa1k04xra+0huq8leiVAXq7h2FYLg/SUXMRj8pjYIPBE/Du/xot
	/Lx6xYOQO++/qBlGUGhMKVuQGfK/HWQc0a3CfI9N39vnaEgLswKTHrEXG5B+IrRsYyFnL6j4eJi
	NsPO/ZAq4E/S0M3BfCDjUIz3fnfmCvp0itoXoElnPNe23hNihy1zg5zVtYABFKkUy7gX6OUojNr
	Q3vfB+fK4r5gHCFR9e4ZQ7Q8UvJz1YQG5NaekvnI21DHeVCWH0u3S7wFAYFDFzcgC9vjcsE/pAH
	mZh1kImtmZPqpzgc6Tw3raA5Ap63CeW4HD84cdcvaKImelaNo8PvcHijA+A==
X-Google-Smtp-Source: AGHT+IE5yWkXABvswipNVZXmN6tVPNh052MdkWTxdNVoEsm070328SqRFqfnUO/w/vl1j0POH9k9wQ==
X-Received: by 2002:a17:906:fe46:b0:b73:aebe:e259 with SMTP id a640c23a62f3a-b7671a46916mr2110409866b.34.1764168386080;
        Wed, 26 Nov 2025 06:46:26 -0800 (PST)
Received: from localhost ([151.35.193.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cda956sm2040528866b.2.2025.11.26.06.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 06:46:25 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: adxl380: fix check for unavailable "INT1" interrupt
Date: Wed, 26 Nov 2025 15:46:24 +0100
Message-Id: <20251126144624.24512-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=flavra@baylibre.com; h=from:subject; bh=RHITrrrdL1KbRz+2OaiqC7ND4MsOJXoquLMuZzaPSJo=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJxKiloQZ86pGcooWVTtMMGV6CpaQ5B2CxeOdJ Ovn6ji2XKWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaScSogAKCRDt8TtzzpQ2 X5oIC/9wZOKr5AIFJH48gvWwjpGzJcV7oJ6je/l/ht2hiAr50aX3n/1hcyHO01q+rAM0+qIflX0 3rf0z/hImebNT1x076swhyaSTDeo4Fpa8vM0E4wtyCjxYrep+BzWNr4AgDY7R8ia5ZAXVcScXIl i6FoTgOK9s65KqPS9C1IVqtF7qmhju7TdiEUvKs/uz9DAPmrfqAWdyhgGGrvDscToZy7joElBmO UB6BiAijdJ0TU4cTH06B7B5QWBFzFXcAd926QT7XMCSjWAmw4HxeqPNsaZ6OjWkrdWetsM7yZie 0z4CTgiRvuVLTnd2rmDXVGHoVIkcKtUVKTg3iHMSg9W7yQ+dU0ynuzjqYLgKEzP4lKxuMTmDcZi rWRU4U5g5vHei3u+CPpQCh6yOkGQhB8DBGWGYjpqNzDqo0ZKOI3/ibJe7nmP4JctwAnDQT7yJ1c Q8nkiUIkwr69VZsUOgbXYQKIPq7BnMxbyA6OCvIICgDYgb1gV1HtDPBri69EO5kX94Ru0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

fwnode_irq_get_byname() returns a negative value on failure.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 0cf3c6815829..b553e69347b8 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1728,7 +1728,7 @@ static int adxl380_config_irq(struct iio_dev *indio_dev)
 		st->int_map[1] = ADXL380_INT0_MAP1_REG;
 	} else {
 		st->irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
-		if (st->irq > 0)
+		if (st->irq < 0)
 			return dev_err_probe(st->dev, -ENODEV,
 					     "no interrupt name specified");
 		st->int_map[0] = ADXL380_INT1_MAP0_REG;
-- 
2.39.5


