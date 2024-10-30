Return-Path: <linux-iio+bounces-11624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759799B67E2
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212831F22298
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1301EABA2;
	Wed, 30 Oct 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWo1ZbUT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4403EA9A
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302232; cv=none; b=cH98GZY0XLODaF7eVd94NkYAdLHpiV+oZ/vbU0LpVgP8BERbrxsFEMz1fI18KZ9jdf7OpszXvP3ESswCmfQpBnz5Qv/cdC3UXwE/sfxIGtJ1uB0zV02lzAmR9cTzuP2QBgHn//KhcqCr4561ur9ztzZdbZVToEaVoRFo1mn/NpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302232; c=relaxed/simple;
	bh=AXp9R9SIchOWcn52tYxCXMRJHbP1cxB3uaJJrIOcnfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHWB0Wyujfcsu2JlFXIowfbVXaungsK2Tg8laP80+yTPOvwzhqos+7qS9zT37DguUXWGxz+HTUfuU/0QS2ewSz7ktOTdEYGQKII76Cco68S3f2T7+kjSzNAENv/muccH4kZKBYBUOtY7SoxB7i+4e93zwnHpMHamWO5f2RyGObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZWo1ZbUT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so4520f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730302228; x=1730907028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRMi/UaCb3Fk6BdW82ihmAT7XSEnqkfXgGS7TLc7snw=;
        b=ZWo1ZbUT85ZHDoJYncj6d3A9Gr//peFQr9lHTiOX7TnyVQBi/OAbuu0NdTj9e79P32
         bHhgbzCq4lfCTZDLZ3IiFqvv3IiKBGjuH1qAu9EL1NAqdpq3ukv2qXMqg0o/WDIwPb8c
         QzvF1C5gC8AhxLjWBVd3BbJz+GWMTgHRXz0/mN7+rL/R/gtYnT6ifPvV6Q/HOT5ChT5w
         U3Nzoa/fE9iQWXCSFRGagSzYLNBuoRaV1IcloenWjMUzY/qCfPNTUnKrKVIUl7aRWJ7w
         kNtWX61Or2I7tg1htecYJ58J0j/K0dg1ozFNF5EUm6KA3SGG3uIEe5yYDPCMpyS7JaqM
         yiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302228; x=1730907028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRMi/UaCb3Fk6BdW82ihmAT7XSEnqkfXgGS7TLc7snw=;
        b=qIaBxxjXZjOHQ4ci+tIAiyFLMykQjKS4zXUfdp2ls8PP4X/JRPAai2+aCyLUwqxS/n
         ZFPmyeemA1ZnAPxHdIzOWVz7Q92y3ddf5Qd5WpIbQToXgUvTMfBex2U9s3rXabdt0HwS
         opDLv1sinVK/qG0Her79EsDe5n1Qp4yMfyIlEMs7vqOLQCvEil+vOsFXflyj3OjtaUnb
         NZkShHYDDoOSUvilg3FJGCiHB6QDVToi/CnFRG9kRT+kBzkL9KJjsdmWdGmGS4uvUVVz
         TttmOxZqoZ6X08m6SBfVD8w3kGuZmdup+IbI9RtBT7Ir0Y+lnb6DyULMtwUfJXBczyfZ
         9CwA==
X-Forwarded-Encrypted: i=1; AJvYcCUFfn53Zs9Usi5DZLf7BpxttwcBQxQudW56eGuAKalG0/UtJlqfI3NC0C9MXp98e4E/vHm5laW/VD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IvyCFRKI723WL7Djkv9rgq7MAunQvA0TDzMLj7aly0yuTYOf
	Z6YAlHLkN4c68r2XL89R896YKtueAm9l5BqTk/WwwT4V3dSKA6k2uHHAbQnm06U=
X-Google-Smtp-Source: AGHT+IHoRp+AdkV7muEM98FjpmsQbqUcxsFuiT8bojj04qgoJZnxfDR3JyQ/xauio6JUyi0Vrf9CtQ==
X-Received: by 2002:a5d:59a2:0:b0:37d:5129:f454 with SMTP id ffacd0b85a97d-381be776c81mr12116f8f.15.1730302228060;
        Wed, 30 Oct 2024 08:30:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c236sm15604040f8f.35.2024.10.30.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:30:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 30 Oct 2024 16:30:22 +0100
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add Allegro
 MicroSystems, Inc
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-topic-input-upstream-als31300-v4-1-494297c9e50a@linaro.org>
References: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
In-Reply-To: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AXp9R9SIchOWcn52tYxCXMRJHbP1cxB3uaJJrIOcnfc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnIlERgWKlWKr/QYDLiS94tIIuQ28hSEKf/QKE4h+o
 ljU27P+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZyJREQAKCRB33NvayMhJ0fsUD/
 9NlYyVfmCDfpCI+AViO8eI3UNt/HOm7t3yz2OZ/HVqdJq4YRcCYtmeOucCLpW2mIxarptNqaqUEQUZ
 QTHE/J3S1WEh/oUtrsExS9V5phxjyBdLu0VKWZFT5Ru+GWiS1vv8GKFVAHxOTYXfETCfhp57ZhPByl
 pyKahQapTopn4gurnbn9WKc9X/VPyJ7lN6PJBm8ftwWhMoLzaxtJNttO8CbRTv8aUwxdsjYfAMgrhv
 qlB0yBj8iFpugYYscZ6TjnUTmHUF7Gpb6J8dJorjIPjSbDVgOL5bA73WMHbRsm8JTNmWGdo6GRPRV5
 OQZCuMHTk6uuVlqsZFQO6S2ZT7izcbWnQkKUhsAlekOVdQK5EIGcquZjJTnIYpJH2wnF0IgaM0yvGa
 Ifr3Pmn+NaMc0m1EjdNUYbevnFDPcCKajahGBgTLoASld7D9Cb6fOvj56ij61+/fIgPSDt4H238kuz
 r7gdCU0D0P3xQuS3sa8f+hAhYGi3AhQVoZWCjPxakXAybdaJx89CJprke7qucoeV9HE07rIgxg8Wwl
 LM15BFsM5nQr9e4AKlbCgGeftmp2Ikek8NoplvWbpI85AAmvO467C9KkAROt5LO1UpI/S8qAIUqaat
 RYlM+qaoLK+kGG0IAPNzjIQ2Vixkq5PyuUMKbRqRj429AUS8BNA+W+BQ52ig==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Link: https://www.allegromicro.com/en/about-allegro
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 15877574a4172cbd9395bed531555cfb009ff010..b90355c2b45ada6e20335cd5bb2aace9410e4d3a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -83,6 +83,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^allegro,.*":
     description: Allegro DVT
+  "^allegromicro,.*":
+    description: Allegro MicroSystems, Inc.
   "^alliedvision,.*":
     description: Allied Vision Technologies GmbH
   "^allo,.*":

-- 
2.34.1


