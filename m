Return-Path: <linux-iio+bounces-21624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E84B031F8
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4100717C19E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F27285C97;
	Sun, 13 Jul 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFwkzPKX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C24283FCB
	for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422409; cv=none; b=qMR2QB0rzuGcqAaSKG9aemEyhbSSxh0exgGvPzbNX/ni64qhY2jItwLDKy44Jv0U9UdcR9uYOjsoCpKtB9bd4SzehMe7hsXcYK9S8vG46bAj2u3Zzy2WHckGf5OEz6AzVyY8jrDtXPWPZuCNinRBfjz0+DNRZxfdbFr9lyX42Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422409; c=relaxed/simple;
	bh=p8WbJMTQXTpcyFXQoeonBjRu5VB4adZRBDdQSBJJ8qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBp5UIpA/zCMH2U1QNK4kF7ylGFNERKiOGYcQO26Y4AlCSOmIj0cZ5IYLxWHcc9optLNEeK9J+pSMxWL2D4kvA5F9q+0cpQWfi3PkkRvdTKgc6F9kG4PTE7AzIloNQ+gxIDEy+QeVN7bp4rUgcQGXSNDpiwc1yaeZWy0AwAz0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFwkzPKX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso4188275e9.0
        for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752422406; x=1753027206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpU8zwXevfQNdwCxf75aBhRLsiqDAYoYwL8iUT+xCKo=;
        b=rFwkzPKXDNyUEFkTVsTS2B+kGxXvahIpplRe/6ksBY2TKGIa61UFaYJmKcPuC0AHmH
         w3gCsqMLuhP0k/Wx/XZCI+45t1m16CIxNHzINaJ3NTnTgfDtgEg8KhbMEZW95xoU/Vb8
         mMcpjspc9ZX8Ty9sdjHfQeRyoEMgfE8tysTW+3XMA5Fq4uo1n/TOgjC/6+AOR4etHOMW
         djdKy7d9832uWQWT0GurJAxUwSZ9DMLVvg9GH6RwL0a7/AcO2KVQIIwenlQPmYvLR9Lh
         t2o0uTEFT0GeFTqERT+5OSnL12ZU6kIDlNPJUGOS+nafwQQPivjPekhUwiv3qRjV7hRz
         wxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422406; x=1753027206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpU8zwXevfQNdwCxf75aBhRLsiqDAYoYwL8iUT+xCKo=;
        b=SfrgZJRGQd+aN3VA+x0egeUZHKfeeJD0/EWBAa2AW/p/ex7nb8mIQBpSWOMBul6WiV
         RyoNrqgEhIlQ0dFNkyT6TPsM1RfMSrL65HCnkvZIBPtk63QNLCfclDMBY2GiphOAqXcS
         ecI6dt9z4FfjJW9Xf3M1QIU57CTu+BUOUqatHMilEbFuU1MHxM/AJhy0LLbe05Ob+8qs
         0IqKYw0dPii6Py+DcbRLFKlRBK5IO6olaX44H52zxffO7cqYL9JSOcXI6TEGAE9RCYSk
         DyoJOpeP7RWpTzpTX7KQEG9gp6y8zSpQM3/I9bDUQ2ycdU5onUWg61n8wKcT1E2AklIY
         o1Vg==
X-Gm-Message-State: AOJu0YySThtg5te1237fxhjkOuA2AKlHIs5E6P7iDUpT4rmkKJ+rfJ4E
	yVdZlqQADBw9FQHid2NFJ79b+jNLowFIBrdAcAh3I7FrIBChFHGHpPvyEBRgb+Gn6dE=
X-Gm-Gg: ASbGncty7GcEml84HwPHO/DEUiB1hUy79qMdG5MhzArEg4K2SXkc/CdGfdtb2YskfeJ
	oXncMVJlEcrMPs+3WiW7EqL9uAJuCWMpfAdhwj1xOKyaHAG+zVt5AoSmrXgR5ZFoFcf5SN9o+d/
	WjaHnmnJrqdnxmOxvJJjy5H4rPJGFOnUYMwcvB9ISSs/2qGuOzOXiLn0GnDQlOEF3AEaguWgged
	fZWVRxjG1rVRzIu4DcuBB3yFKdM+VmYbKW0RzAn4VUr1+BCAlQ8i9BspUk5mA3bUoJJ11zFrqbe
	aICS5G8Om/zTVj8Ag6EYQYCgAuXacriYh7UlRYQu+z7QlAOVbGJKn8TE69TVT0mHZitwnnigXO8
	a976ge1VH5NUxMT8Y38DfbDDFbiEexFlWhwb9
X-Google-Smtp-Source: AGHT+IG5YNKjZqhHog2I0iPPEGrLUyUpKJkLY+0bfoyvN7keWvp3qfXcJRPY2cyo13nzZl7LZIjKaA==
X-Received: by 2002:a05:600c:a282:b0:43b:c844:a4ba with SMTP id 5b1f17b1804b1-4556f8ab34dmr24637715e9.3.1752422406424;
        Sun, 13 Jul 2025 09:00:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm10244123f8f.37.2025.07.13.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:00:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 13 Jul 2025 17:59:58 +0200
Subject: [PATCH 4/4] iio: dac: vf610: Simplify with devm_clk_get_enabled()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-iio-clk-get-enabled-v1-4-70abc1f9ce6c@linaro.org>
References: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
In-Reply-To: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=p8WbJMTQXTpcyFXQoeonBjRu5VB4adZRBDdQSBJJ8qc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc9f/nJnWqoIZFv0TVxMoXT1uTpNZexIaWYCMY
 T9bcB5I28KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHPX/wAKCRDBN2bmhouD
 1/lMEACXwoKGERdErxwsixlXNej/c6D6qA/gYIx6+Dhgig+oLosi13YqPOlcNpACIQVSVaQuGSF
 BmRoBiekTzBJZoBO+oPCCH7hYt+3Axj1btziEMw8kSdPg8E6tFg1c5CmS218o6qapYzn6hABKFy
 j48YTjU7vLijhyQidS48+CIB19UXBMi46ugk3fe8TMpbzZD94jnusBgmItvUUu0lW26JjhBJUMN
 JFba0FmKSiFN3q3mcQRRpwd+F3IYBiQD+aEdb/QGOM/1U18kWBfpwHJOvtPq0Nj/8DsqHQM3NvP
 g+A46QuvYcNAaOTs6U2FU2MxTtbqQNzgFEagUt+lLqSHhTliVXVOOWY8CoZy98nObDRgtFBUTJv
 CmQtGt8D+s97fFDndS3ZDA/kTdpnqXa/S2Sp7oUmY1XnFCmW7BnqCxRcIjOT638sCsppbJZfPVL
 EDzmWbTqtqK/6+c+ypbZf7P1yT3Qk724xai7iyF1Mmgv40oHs1j5W2AaIo0joqigDUlSZmtRPhn
 balmM2JBRblyA2TC7NP0dEAOR1XkzNUt1kfTFMycLyCPZrwkJPbBTFgJ87phJJGvad69RGdOtoO
 zg0u7WL0n63zt/Z3Cg2gqtlUI6/vlAh+Nb8pNIw8ITTrBQh3460moBa3ij2UxNrYJ8ZgLWdfNHp
 Q9fQgRdxrIeq0JA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver is getting clock and almost immediately enabling it, with no
relevant code executed between, thus the probe path and cleanups can be
simplified with devm_clk_get_enabled().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.
---
 drivers/iio/dac/vf610_dac.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index ddf90ae65a2c2458ccd4fa855f3dc56b923aaaa6..93639599b2b9895ed3307907216697d05cbc2d79 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -188,7 +188,7 @@ static int vf610_dac_probe(struct platform_device *pdev)
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-	info->clk = devm_clk_get(&pdev->dev, "dac");
+	info->clk = devm_clk_get_enabled(&pdev->dev, "dac");
 	if (IS_ERR(info->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
 				     "Failed getting clock\n");
@@ -203,13 +203,6 @@ static int vf610_dac_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 
-	ret = clk_prepare_enable(info->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Could not prepare or enable the clock\n");
-		return ret;
-	}
-
 	vf610_dac_init(info);
 
 	ret = iio_device_register(indio_dev);
@@ -222,7 +215,6 @@ static int vf610_dac_probe(struct platform_device *pdev)
 
 error_iio_device_register:
 	vf610_dac_exit(info);
-	clk_disable_unprepare(info->clk);
 
 	return ret;
 }
@@ -234,7 +226,6 @@ static void vf610_dac_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	vf610_dac_exit(info);
-	clk_disable_unprepare(info->clk);
 }
 
 static int vf610_dac_suspend(struct device *dev)

-- 
2.43.0


