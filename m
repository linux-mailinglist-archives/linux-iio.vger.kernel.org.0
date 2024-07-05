Return-Path: <linux-iio+bounces-7347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517C9286F8
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E912831CE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3414A0AE;
	Fri,  5 Jul 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2j88sPp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2054149E0A
	for <linux-iio@vger.kernel.org>; Fri,  5 Jul 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176066; cv=none; b=sn8GuoT7K91UTihlu/Exle6UVcyF8d/W19sGgf0G5v9QZoIu4jHJ77ZyqoXelh1I1m7+bj24sJubU5oHBEO+X/yl4xPK1sulkBE1CMv0Y/iT555iKB4WN59eN3U8VlEvIB2SB5dHYxq2BsESz5FV+6pNgHL9ULgd1Q94Uw8P1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176066; c=relaxed/simple;
	bh=wAVpbgQ5bIpyCcGTaGFP8RLhuVeOqnrOwZ6oTfnW4nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRCXAyON5JVtriL8iXNywUsdzd+UDMwz9+5rTbYqkSuCOZAqMPTAK/FXidb9xAk8gAf/Rqt+MCWDuwewwbIVMME2Lx3v1cZbqDRuwmXmGacuo6tYejaOnSmFp8bigX8khBtxcXCTktYgns+TrE/dc+pxkO9n75Ie6Fzxel7QJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e2j88sPp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36799fb93baso1012945f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2024 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720176063; x=1720780863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9Np41486ZPQDGlzQweAJezAFo0bzffLP3y8AkeihYA=;
        b=e2j88sPpT2RQ3VOX7GWnDTllKD8AuIuBchKRXPZ0jGzcDtmZFcYknABYUolITP0BqK
         fIg4mi55vzxGNBqxRcupDh3ezgn7QIdZJp/dFB3w/n9W31YoaGTlVb74G//4Bir/eNsg
         K1j3TbeP4JAo1npaszj39xZHDQKwg+KULfHnfjlFYN2iLAenDglkHkJXveZES7QJzw8f
         tBqn6xGTzgTR9f+XB3lMVCg153w0WMHJ4TX/YZUk5WnYryjo1IgreC32zARESyynC9tf
         aiFHw6EbwFfxYE0aAVrNOQkUziBq2HKpo7iAje6lPSWrlmc1XbfCAzmH8yWS/PKTCvL6
         5DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176063; x=1720780863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9Np41486ZPQDGlzQweAJezAFo0bzffLP3y8AkeihYA=;
        b=pTcBNvVbIiuLOD9w0Ab6gPjHbN3lviobj2rhywBubIA/Nh0iZZ53CjP3pJRc4Th6xt
         tfea6pTdm53WnX6UbYApoA2Qth2nXINbkmtxbs8sf4AQEr5IPW/7InLJ6AigD/thMTUW
         sO3oLrtqU9lzsw6vIEFMEmtzjL+f1ibC8qvgUIwEgBITckDpLcaEvaX5lr7ZkvEfgvEK
         CJa40hBlbSQ3QefxGooEdlnKG16oSM4mhr/fkKVU2I/xl29MbxFdeekOsW0qsyqP3NMT
         ebsaoPs6/Np5tsn4iWelvr5ZsFgihNJa1RjUyAGHBWtRbQYtlKcBYGl83I20vzNIiW2Q
         IrPQ==
X-Gm-Message-State: AOJu0Yy80UJMHFaoaSIiHSA27t2e9/W7i24puKVjf5B1ewfNsOm1TlEl
	J/NnnNaNmdd3MeqwncSzGxOLuJTYXTnUDNrz4cBPt+DUq84R0/06D15NfIiI43g=
X-Google-Smtp-Source: AGHT+IGJmF2yz6CclwNaZobfkh+KzmhezsSI6pZ1+CVEOHBJkhN00D9Q5QVyJPreYMVR2oHvYBqtxQ==
X-Received: by 2002:a5d:6849:0:b0:367:9614:fb99 with SMTP id ffacd0b85a97d-3679dd31137mr2795078f8f.10.1720176063285;
        Fri, 05 Jul 2024 03:41:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm8680446f8f.37.2024.07.05.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:41:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 12:40:49 +0200
Subject: [PATCH 6/6] iio: adc: ad5755: drop redundant devm_kfree()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-cleanup-h-iio-v1-6-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
In-Reply-To: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
To: Dan Robertson <dan@dlrobertson.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=661;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wAVpbgQ5bIpyCcGTaGFP8RLhuVeOqnrOwZ6oTfnW4nw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh82yqE4WDfmxPDBzauwZ3Iq6vku5GtvtWvYVd
 MK7kTqYSIKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofNsgAKCRDBN2bmhouD
 1+4WD/0QMoTcaJIkRnw0sl/FKPn/9xu4+bNaTVtxm3Oxvxf02oev5VhaxB/RJzKUopuc9Cv9TPc
 t5V+qudWwmVC3/6vIMZGISLvYkNkpTBIg7SZs74tbZ//7NGVeYfC8s4ev8SJ9r5X3TvMgihmu32
 JDEMyQ0+klT275tvSKA+cYiaBmUDRGolzvO+uLc/ZMTdTrBOvajCSrjP1LNCSNVaCX7uc4gvXQ0
 I6VGNMb1glQMD+CqNQQ2/7wHcctG/vqmmMneeln6lYioC3njEV2NVJ7txWExIB3w4NhMQWyIswZ
 QzPh1o70THWr0Hv7KhbeC6o3777jFBthV8k66WA9cybDPF6SuNwzyFOAIhyuFrBv8q+NxhVeTDr
 +MUCHc90reVhXMlmtSxpU5I0apW01OHOThkXoKs6GE6/10879YqP4xAcpZYW1hIH52q4dsxmSzh
 2J0fts9TPugTQvZO1IU4U4i/1Sk8N/WbyjCzbCuNgjsRXigEtrDALzXboSrFCr4LEijx8y/t8OQ
 EeYHwqDY8qrVPGVsRCTIg2XARx/A/0pC5G5CEB7vHDQ2IKCDSQ0Bs1f6bSgGXhNI6x5QFVg8Z94
 zbF2g56BKULxngx2n4TgUEXShv3yzJR5xRh8rRncc0BIluerLglDleXmovbT3iCGLf4g/nWp/kE
 gfF4RCMThWVj7tQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The driver calls ad5755_parse_fw() only from probe() function, so
devm_kfree() during error path is not necessary and only makes code
weirder.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/dac/ad5755.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 0b24cb19ac9d..bfbfc3c1b6a5 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -803,7 +803,6 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 
  error_out:
 	fwnode_handle_put(pp);
-	devm_kfree(dev, pdata);
 	return NULL;
 }
 

-- 
2.43.0


