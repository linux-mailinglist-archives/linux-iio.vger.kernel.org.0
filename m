Return-Path: <linux-iio+bounces-17713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D704A7D015
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF11E7A4996
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 20:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB32192F8;
	Sun,  6 Apr 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEYEa8r+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160E1B0F32
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743969718; cv=none; b=hkVd1h+AveK0zHmnQpuKJHp/1DF8l9WftweYXsahlELSWZPjoRLgWNEhSMKzAOWF1alTBDCO7B9w/O8tSlUSgGXBmXAHDYFdEPgqt2mHcfbvjwmIhQh/tIoKg0hPD+jl69tw7zxHVLou984RcwoOm97H1LWPlhxvIZ/3pm61MSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743969718; c=relaxed/simple;
	bh=VozTKdty23C6YF1YQQSfUpINCPfYLQLWcVgIyB0y+l8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iV45N4vWdPmFUPfKdqXiP82a1C1mUCW3Zoam8pF5vt5f18h00LwJ0ixkRInV9/sOS5Bs3iTQKT5bS2UiTKysvL4QP1TXjQHk7v5xKNDZGop13iMdETY3a1PUGdxCrk0KZb2aKBboejIbxvFlzaIpR6mTDf99CN7yhselj02HKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oEYEa8r+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf825f46bso3094985e9.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Apr 2025 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743969712; x=1744574512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJPjOgh8WB65h9CvEgp1vrBJ8vhfbj9Y4D8cf5G+Xh4=;
        b=oEYEa8r+lsceFZBEl7znzScAE7nc0X9NrJ5kAbgjyt7MQMva97Mpq+RLnFTYBbXsm+
         zGzYwIEwPB2bZs5E7MEbu8sYNKH1Z8jaJEVIdbDaIrBeOmk+rXV7BOGKQViAzCRRV6uL
         lMev7Ei1JzhSlTlJSHjRqv971FIVkjlpT34NJw/7jaYlSeN0XCx1VKGqBbP4dOUSC0Zc
         sueuXW1PZW7vdkzBtDvsigYWYAIA0ePaB4w3Q1DuhfjHzeW+fdXjE3PBmf3FgRWu1QpS
         MplDcdWw0mSUyfu7SmfP0cw2Hs4M5AmlAtMi0pBgaLrZ7za/hm0jRlX4yUwCOxCAoDVW
         jYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743969712; x=1744574512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJPjOgh8WB65h9CvEgp1vrBJ8vhfbj9Y4D8cf5G+Xh4=;
        b=oitJjDCj+xBk2LfMb7UVNJV+Esr0sNOClz+l+vaqq5oH7SFYeODeihvY/90quDeCey
         X3EkhYprGSnZofepuTG7nabkhl79BKeq4sylVvUKtywxjKPK4+AfaMmztvaED5juq/3v
         8+Rw8cf/si+KPN3huGtVk44OQScydPTd7aA9SXtYquXpvSYEI9fcZKu8i4SdS3X8SUPx
         6vy+30JHKpIcXzdbLkzuYkK2sGahnI1/h63ccX6PHejwBQajDv/oZOU/LGgkDaLpSXpx
         SOUDoCC9DOCHl1r+GRorm2Ik5Um5kgpA8Onsjr7d5jpctLZEt3GUssB4y2IaChuzfUhR
         xN8A==
X-Gm-Message-State: AOJu0YwoTqaSfS1HNPoCCyyXG57tTpwSvMCGFTOt5vxXpKwAc7a/cnRl
	RjX3BSBe9CGt2mzI2JMqI4mUBjJj71y4kThdwyZWWQOpUvUg+FJdvtujTr5gQYvVe2DdXkImaSw
	U
X-Gm-Gg: ASbGncusP5MV/beiTKFpY7JFyu4VCUglnsGRHLLYVxQSVp5m7AC3Jyd8+E7HM2trrEq
	DkeEsX045eh9ryj8VnrcQEpwMwLfce0uabc1b1+4kv0l1PIxpbQoaX+ly3Fby3wCB9SRV99XKK0
	D4ASi01qBalBR12jxzEC0GG4/bomtbIxeNKX0j8sBO2h461tAPojLgdUNPv9XPE9S7u/B4YG0n7
	i2iHsSAhasKDLDval1phEVoD0D43aKvmfZ6yQQxoGWpyACeXgYdOijxzrTGRu/OmAsUOajpkNr3
	MW5g+LlCMHxHyujoSDta5TOq0Z15nGbIW7ML6o8rdjB9TA8UYlQHQqDI5ULtCkE=
X-Google-Smtp-Source: AGHT+IHuFOr4FLO+ZFNr82BE66IFExmH2hKlpvb7d+u4Xph9Bl+U6z0MmCsuokMDRZ1xyVizHupCiQ==
X-Received: by 2002:a05:600c:3147:b0:43d:77c5:9c0e with SMTP id 5b1f17b1804b1-43ecf83e90cmr31132795e9.1.1743969712486;
        Sun, 06 Apr 2025 13:01:52 -0700 (PDT)
Received: from [192.168.1.26] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d98bsm10199924f8f.76.2025.04.06.13.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:01:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 06 Apr 2025 22:01:43 +0200
Subject: [PATCH 2/3] iio: adc: qcom-spmi-iadc: Fix wakeup source leaks on
 device unbind
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250406-b4-device-wakeup-leak-iio-v1-2-2d7d322a4a93@linaro.org>
References: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
In-Reply-To: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=849;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=VozTKdty23C6YF1YQQSfUpINCPfYLQLWcVgIyB0y+l8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn8t2qc8HDmx9nNJlk5gIrngYPXgOifgyNrR5ta
 S9A5mrqeHaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ/LdqgAKCRDBN2bmhouD
 17McD/9Z5hQHHH5TdFolh63i65wIz6oukBik7uolmyj7mHCtpZzO8Su5fTPql5M3W5zRK7dbsBB
 qPzpwPLVs38r19ObcYYxInJ1ASt9wuAxzg7sLFjuJ3r8Sy4mYEHoS3ln8hJoUIWxLBOHQJGrDoU
 nrKxkRnOEgdhTHSx3GZ5xnxzr/kjpj6F53zh+iwHJLkdQjpMGkQ8Vv4+UI0UN1ga9AMH+rak2zN
 0YQgn39od572BCBlORKql6Ak/LAGIiYKFEhrJJqujL4sAiODZF5C5E6ntAh+c99M+VMw166IMAx
 Qx6XNH3V4Io2/BaXyVlaRhNI1iQk/t1BgVtF7o4hrf3pACErakEscg0hw2dv74vB3eELcfkIoxu
 gpG7o5Q4FPPFx14yNFMFoGKN6C5t+O8lDZxNbqDkmMxDPBKD2/aDjCWIX4dnk4GPG48fq/CUTkN
 D6FtTFoRSBe4QN+8sIv2VFCmZvdv9zX6G8jvSQhu4vJbOXljK9kRZjLbOXFbL9d6i0AXpIE4Cq2
 xwfFbojMHsf296WshWkPNVjHgAFusDINpte4MX3gmGZ1EtvOcEBqsF1Xk1rt9qeOBQgLjY/eA27
 Mkp1VKsiFRm0dc/uWTInvlZoxiPp0y2tQW2Hw63YANLJLFAlB0O1izOi7maBiksjva+CjWk0mHM
 Luu0A3KZbQO0NwQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/qcom-spmi-iadc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index 7fb8b2499a1d00e4a020da893181e693650726bd..b64a8a407168bbc109e6ea9a63b8c4e492ac5bf4 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -543,7 +543,9 @@ static int iadc_probe(struct platform_device *pdev)
 		else
 			return ret;
 	} else {
-		device_init_wakeup(iadc->dev, 1);
+		ret = devm_device_init_wakeup(iadc->dev);
+		if (ret)
+			return dev_err_probe(iadc->dev, ret, "Failed to init wakeup\n");
 	}
 
 	ret = iadc_update_offset(iadc);

-- 
2.45.2


