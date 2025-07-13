Return-Path: <linux-iio+bounces-21620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D1B031EF
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 18:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ACA189A82C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671372625;
	Sun, 13 Jul 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apHS9M+2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5827F4D9
	for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422405; cv=none; b=fo2ua3UdYF/Sfkoh9mZkpOjxuAFMv9uXIbCh/pXYBBxC5iXJdjtA0QNd9qnb6YD09D9d3eaV3KFz9N95aGAGFHmrd16IjpfgR4VEmTSXK021E3maCPI7fgjdqcq0mIPOtzdXrohF1iNFYpqfUFldq1t3aOhWYmF77h/7Ku3GXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422405; c=relaxed/simple;
	bh=RNZM7VeiSwJuf1WuWy49f5M7lHoQJIMon8g4vnZ5KpY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kdz+fzl8X+VgR32KGO56iBt/DVe9KPxSkVZI033ouYWXTyXQSIaDG4Ggpl9qORy3H4gbAnT2LaJTqEmJaTbDdeIlxcImihzzVnZb4B9FJ8sQE+9miQHtQpOZwABD/Uq06cfjUB9gVgtG6yyxBVfbOjaN0UjsEilGlBpWjHJ8PlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=apHS9M+2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a577ab8c34so362324f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752422402; x=1753027202; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKkQ/ZqJDOz7LPkwRdAo8RGpwjZ41PyPdFDVt4/XaZs=;
        b=apHS9M+20pNvlxb9eMqiI2zbKEGuOZ1gRPJd6RB/L9nvPhdnulpyr5afVHIpEOoQiW
         n1zVYmIQ8UoEa84r5lvnpXVtAyI+KIrxEz5xYb+WznZnm32phNJOV60++VJcJZmTL3k7
         /V1iI8gm6oiZZtwYMCCgbgQuoR3JIF4YMRVT2N7pJapjtZfzoUl/7Tp4wwdLq0iLPV4Z
         z967WDoyn1ZpDEP71tLSVR0mTakSh8+UhGEQFqUQ8JqfcWAVP7LKYjr1fE97Aqc6LG7Q
         kYRxcYfxkD4zkE+BkEmW9g5DLywTus60hb1Ds0R/BV2MGmXRAbi6ZKI8oFiyBeeU/Yu1
         +mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422402; x=1753027202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKkQ/ZqJDOz7LPkwRdAo8RGpwjZ41PyPdFDVt4/XaZs=;
        b=I0w5PSslAeiRdDG89yflZMY/OkFf7MyNGRqkYejXOwgFqdlQSZXl2qiESs/Q34s7L1
         FSJC4Jo5czflzw+Jxslx4xvxscp2UZRRKfrO5al69SCSjwKKHBdi5K1dgGpOD8q15SPz
         eFHRY3sX/kWW9oxfLRhRUb3uWtaYIr1fn3B2jvS2a76RDri3QHxxvu7IkUmYyBYqFnFo
         +z0ur2pXL667zIZElTC/Kvyh42bsNQ3vCvvWGC9u97Ds4maZusqup0MO4HDGwtRIZnyB
         r3iLVhJGCVqvxXIOecNbc7hmCYjiY9PPcniqYjU5uNITiYm5aFAHRUIJTEL63sKuBiKQ
         M7LA==
X-Gm-Message-State: AOJu0Yx5KvnSrxiSxntM4IIvx5RoRkiiz/XwJZ1eJb8ESHKZ8E5oFllK
	44ySa+KcaJYJdOjzsKt+8vyWMoLjrjrA6cwNtLmA9jctoFA3Lq8BK+xvfuMPd8xDQaQ=
X-Gm-Gg: ASbGncvY8bG6Mlz8JFkrf3abko35GfzlWsiOPtyJSaCtkt7tPAwegNms2Yz2A75RrZ6
	6QjEBLKKDhVXVD/+KT86HveEG4QldSq/iUwF45bz7sCsvhsplEuvoS3lPNCO6iTNiKxMd8teLvb
	7mk8J5I49agVMiFqGCnHwHJFuXs4f+nv7P3P2YKFeczN/SggPLt5/Eg90O5pTB6uhM+MAUgsSfb
	ftXSB8ixCmFHhQw3SR07h8kPxa8X3niOgOi8jWCDpFrGHGWeO/vOtyH1Gro1APyZRpdbOI9AUGL
	6KyUndbjEF67atjYt19bflDi2MqkHzUxvnJcI6pBFzCR4ApifW8fQjAnpl79dYQSqQ/cBBtM2CL
	XtvX2Butv+tUm3WccRRdKh8SwZBRJdGI3eDvm
X-Google-Smtp-Source: AGHT+IH78NCUlzVjgglGHThnEAS1j66jKtmv3BfBRuSfPf9oa5qyEFqDD7AlIw7uaMlRAnUpKpJF7Q==
X-Received: by 2002:a05:6000:430a:b0:3a4:dbdf:7152 with SMTP id ffacd0b85a97d-3b5f2e45924mr2722298f8f.14.1752422401675;
        Sun, 13 Jul 2025 09:00:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm10244123f8f.37.2025.07.13.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:00:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] iio: Few cleanups to vf610 and ti-adc12138
Date: Sun, 13 Jul 2025 17:59:54 +0200
Message-Id: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPrXc2gC/x3MQQqAIBBA0avErBtIs5KuEi3KxhoSDY0IorsnL
 d/i/wcSRaYEffFApIsTB58hygLMNvmVkJdskJVsqk7UyBzQuB1XOpH8NDtaUHWtUloabW0NuTw
 iWb7/6zC+7wffaXsNZQAAAA==
X-Change-ID: 20250713-iio-clk-get-enabled-4764482c8ff3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RNZM7VeiSwJuf1WuWy49f5M7lHoQJIMon8g4vnZ5KpY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc9f8v8yLMk2vBXgG1Tj0AT6qGXDzTlR5fo1RF
 5gjZSjUj5CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHPX/AAKCRDBN2bmhouD
 18EZD/wIW/wgLIgyWy/YLErgNmhID0SdIWiATp+qMtjml/jCl6IsPp52oBM1Uwyk5wUPkDddL/Y
 6nktnZgskh/9XD6fKNmvHJujDgVewueutwoCFt2Zzm36+YlSHbt+rqVEpsD5b9xNcoJZkhUydnA
 5bFdse3dy/UKpT9vH1QxmPLE6zQFlq4S5CRvEC8rIXtUIPsqBt+WkpDSlinfc4fgeXhdPMVdJKs
 hCsvzYoOQBf9PK4CmpDUyys9Izb5CKAEhSmmmTAsXeFl96V7CvPH+IGwpqIdbNpAuAcO191n8VN
 k4yb36EJm+ToiEZp7Cbi9xokQjTsAX6U+9hkJfld6wOAzBg4+8cxZSbU7q0s2CeDaFh475Ywg10
 J9l6qRF53etJCt6/iGza6wxxfKsf3ZCeEJ41DIdFsyEgrHeCklYS9mr2KcSl+3rb9tX3GnqY6cV
 3bkIRCnmfmAxyGCchSEXfNBvvTOpAiXGjkPtSWCbZ+LsMEAnCNY/nQxpQBHm2Adztidn024b8Jt
 m03uvxvIa6njYZE+89AI7lD5umAaZyoSHkXI6QPxvXPGfexlhrtgOnTnWQikVjx+Gb1RMCF25Lv
 vJc1JsSOOl5E72YucWKxy4dMThT248xuvO+FkGaiFj8uSFNJycaRTFrBy7IbHEoTKMV8L6to74O
 +QYnF8IugQI7EuQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just few cleanups.  Not tested on hardware.  Only the first patch could
have an observable effect.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      iio: adc: ti-adc12138: Simplify with devm_clk_get_enabled()
      iio: adc: vf610: Drop -ENOMEM error message
      iio: adc: vf610: Simplify with dev_err_probe
      iio: dac: vf610: Simplify with devm_clk_get_enabled()

 drivers/iio/adc/ti-adc12138.c | 30 +++++++++++-------------------
 drivers/iio/dac/vf610_dac.c   | 23 +++++------------------
 2 files changed, 16 insertions(+), 37 deletions(-)
---
base-commit: a62b7a37e6fcf4a675b1548e7c168b96ec836442
change-id: 20250713-iio-clk-get-enabled-4764482c8ff3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


