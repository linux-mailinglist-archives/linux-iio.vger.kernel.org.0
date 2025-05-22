Return-Path: <linux-iio+bounces-19808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E5BAC115F
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324CB4E1757
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 16:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B1224886F;
	Thu, 22 May 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IVdXWbYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C352288F7
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932547; cv=none; b=O4qtTPui3+PhPjDfdBc+IjmAQUWZSgnax3sc84J9OY52P4uIYcZlbDS95VCv58DTezmDgfHHKYsSybTARZkKtEvt2GN5drMopZ/5jDcNOpQSwo1+T6F5YtSuj0VLcyJ4zZ3bEIEMjjF9DNGgYhSuyVq9ukBndWolN+kAzLypcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932547; c=relaxed/simple;
	bh=G3Cpj1xQBKnGsb7tyi3ON1q5bKD7o+VrGEeyArpRq6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LraORPPyBdNOdq0sCbHvK4U+REDmIVCZqUKZG13vZz8CkhtTmpUs8kVYnmjWCCgdk6CJBSB3iMwuvV4HpO0HoeeMSt7z8lecQV+gwiSBImpz12lSo/A3Usjvo276Q2xYj+u87CWPUBQ+TZqDbzL9UgDFiVkylFODPwpPqPhvpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IVdXWbYf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441c99459e9so55187345e9.3
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747932542; x=1748537342; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5gqrpK4LLv8bvpfPMOZaO6bNExWS7LE9ydsQkkyKP8=;
        b=IVdXWbYfdmFPxglo3DGw5Z4t6lRsOL7jupKt4RKJmU+BBBXfli9CyGgpbv89Rt0GQG
         obDC4MqEchMUoGXKwn03tLlBh80rMZMJA3GVjV/r1NsFS+YPp37y5NaOzvewO2pwARqC
         dlHy+Oja98KWWmD2oPEatfT7uGNCiNwLC0nQ55/fHbi02bZGb6sMQDf0SI7TS4EwjHAA
         FKQ6MAWqj2uPfZ1H87dkUloBe5H6dc7zbNC1HxddxyefCtcE0PI12R5izyQXQ6Wy0x83
         CEzsMMmdx0/E3+sz/Aomstk/LceDapon+uIBRx1i/G940sJKnqLlEDH0i9dkWoeO2WHp
         ZA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932542; x=1748537342;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5gqrpK4LLv8bvpfPMOZaO6bNExWS7LE9ydsQkkyKP8=;
        b=eUPkTIiJzYSLamgFi1XS00OdNA0WcnImBJXc4hsjHXZ4BpWbjaaIDj+KrUd441IAeM
         WGyFi+ms0iE8pPyPLrd2OFeuOzRk3xz0jUvjjQTYXkiRWhiPAvtpnxoqFiKBN6ZgeJK2
         tnxw1xENjbwbk6sdXBtLZrxIV82zqkQa+4YoVHwz5kGZ4iXHQStS4ZOrfLnJZwJALMSF
         rnJ2Iv7/CcU9yBbyNfO166q9vtdfQzWUgR88xZFZqEDUDq5SRcLjYfGcdbtw93FDO3t8
         OwMs9mZNQyud4TL1ek4+5mNy51g+UYEIWH9Ya/4JNWWOmJt9+A/wxsmnNbV+t2fqmyYD
         Sd7g==
X-Gm-Message-State: AOJu0YztpxPB7hwAEeuHvAFp+YvQByo40Nf//aI2TkmkYFojhKn/Kvph
	Y/OAbEfQE+MvfXIA4nTsZUr4f2ZUyRo47wBcVyVaxmGTo9Wz4w6MhZypJD/QVaoMZ9c=
X-Gm-Gg: ASbGncuygyEN8POpGWYSMVbPzG4HELkYSltjiXmuNsvhn6hFphU4KZ3MIUYmEr1jaWi
	1qrRqPuSaJ5Y1iXnOr5NCay5d1zWj31trFTN4eBzOFOW/vOwAeg5JTtfHIrMB5LqSRswkc2vqw9
	zNkpBTNq5V+/JJ51iw2D5qSj4Ezlr55u0NqQSL8mHMn33JXeWp8W+fZvYqcEZEupzTd0JulqjgM
	P7qd9WdrMxYp3MrSi/gJ9h9mt1cvWR1yqqN3cEfTx1xdIVB43B/L1+HPcDL+YdGdQMzoiwbYby2
	mK336paqXs44qoC6WF274XwK4OqCpdHKd1jejgglh0H1LojK5GK9iWo1wJ3Kg3BTNX+jrH/YoO2
	YT9RYAqxqVcMR5ollt8voRGcvW5zkQmk=
X-Google-Smtp-Source: AGHT+IEg48bGTV2ct67Aek6JY+HvankpKczUH7hplBNjJa3RunoOa/MAveHG5wn1OKX8yBjYaDhEJw==
X-Received: by 2002:a05:600c:a00b:b0:441:d437:ed19 with SMTP id 5b1f17b1804b1-442fd625914mr240755165e9.11.1747932542358;
        Thu, 22 May 2025 09:49:02 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd6fe86sm237826965e9.0.2025.05.22.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:49:00 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 22 May 2025 18:47:31 +0200
Subject: [PATCH] iio: dac: adi-axi-dac: fix bus free check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-iio-dac-adi-axi-dac-fix-bus-read-v1-1-26ec358c57bf@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACJVL2gC/x2NQQqAMAwEvyI5G6hREfyKeIht1L2otCiC+HeLt
 xkGdh9KFmGJ+uKhaBcS9i1LVRbkV90WY4TsJE5a14owsHNQzxrAeuPnGTdPZ+JoGliaZp686+q
 q9pRnjmi5/xfD+L4f5IN97HIAAAA=
X-Change-ID: 20250522-iio-dac-adi-axi-dac-fix-bus-read-244fbc07313c
To: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=CBPNkXDDNKLJ+wZICyoMYKylN03cbX+DDGSxmDI4mKY=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQD1WN0luhP71j04Rt7o9N9/a91a2VUXu29s9Jn8m1P
 zcddj1zqaOUhUGMi0FWTJGlLjHCJPR2qJTyAsbZMHNYmUCGMHBxCsBEDFsYGTr25CvX38kuOGPZ
 veJP2M+MPxtfGzr7O4c+DNLk/X34y3qGv5L+uqUnNrPHipznzttwft7s5wZ/uERyPly+fE9W5FV
 NLDsA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

This patch is intended to fix [1] that looks not yet accepted in any
upstream branch.

Poll function must check for a value equal to 0 (bus free condition).

[1] https://lore.kernel.org/linux-iio/l6vu54ltxd7pydkzl6xbbq55gedumzbsllfxnljyngwcg4c6zd@w6qxgn2vby75/

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index b6cfe07701d47440df478f7b9b4c579434b99a25..a0e546dba3680371e00dc4c8973d4f450c18cf2d 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -641,7 +641,7 @@ static int axi_dac_wait_bus_free(struct axi_dac_state *st)
 	int ret;
 
 	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, val,
-		FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == -1, 10,
+		FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0, 10,
 		100 * KILO);
 	if (ret == -ETIMEDOUT)
 		dev_err(st->dev, "AXI bus timeout\n");

---
base-commit: 50b8b618e598468e35551003d7e5cc5db14ee113
change-id: 20250522-iio-dac-adi-axi-dac-fix-bus-read-244fbc07313c

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


