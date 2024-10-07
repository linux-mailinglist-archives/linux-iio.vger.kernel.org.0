Return-Path: <linux-iio+bounces-10273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABF992CD5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD54B241A1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77081D414B;
	Mon,  7 Oct 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcNeiUxw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A4189BAA
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306893; cv=none; b=uW8rsqXhD2OAeFtgGBob0+P1aZmxpBY0kPcUginrnXLRcNkb+G9be6qyqmAC67TBZhlq4U7IZJiQywpqIhfshxInFefmkTHFY47uxtHD1pRjUVCeTulf22gcIeTwBXUDQHyTCnbYEwjohj3timo93KJB6+60pozKBWsy32Isw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306893; c=relaxed/simple;
	bh=qsO+H2iuRs4/4dzuzkVkArIq8Mi3kTN2oim08yBLYko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyDgvggum4WkJm8Nzf0TrHoqORHUEhKr2tn2Pci4JBVv9H5lVwYwlXkRFL5Lc4y7pCzuKK0995iCQ/VD5rfcY2MDvAGkeE6lwpOyUHJRz/q1eBjy9ZFjznjuM05D68Pc41VVtK0U+WVoof7fi52SGe2jWjxX21f27kq2JgUBj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BcNeiUxw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so34537315e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728306890; x=1728911690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3bR6Smf/UO517J4TN34G0PKQ/q7aS2HKbYINm8myF8=;
        b=BcNeiUxwo96KdjGcljELVK6RSv7/luSOPTkWM0WwuGTR51goNTafmAh66KG3lru+X4
         i9AHBcEn3cAcOxJnvj1oLMbltSCagRqS5JwNsN76LQ4EFcACUJrut/GFviGCs2UUS7HR
         btYahIaeywdO+wP+ztyjVlO5zsDuAao9klWDoO6Pvr9BfF6kTQ8RnoieH8EtpLZGvzpC
         VYlgnsPrWb5L0H0hVoWqRQZwS/XB27792sE8whApzegEIb5HO3pxV8RHg8EMyDPxNQ4S
         fm29tkkn6EbAw8BlXJ4EgyIJKDVijP8iOta0dR8jzOCq+QMzy7kQAQJMCYdAx8lITlsS
         /V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306890; x=1728911690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3bR6Smf/UO517J4TN34G0PKQ/q7aS2HKbYINm8myF8=;
        b=Jgl+zKua9plLU9t8+8hjhPB5zprDPYQ8ezUCqetu51B6m8BmL6Xszo3xt1zfn63YAV
         AigUOLjNcz3Ukz6gKcahtv9h06kg1U2AB/dyqtrf6Qxgwz/D5KaHROsYC3frcc+RjJ6R
         x65h6d21pXDbkm5/f37l80wejgEWRNiK8rixoZl0m9sEyGayjorr8Nel2Vo1CHQ+sgY5
         /lRnezCdizgKs2m2ovLxXSizGVO3cJt01iQ9Zs5tn247ffiz6SLA5uNYJABpaGfuqPB1
         tljthVdFoolBSe06FiGYHnWhcDSzQ62eVm7tx0a7bTDVJGFKiFggJqzAsttRCJJjY6rC
         mBPg==
X-Forwarded-Encrypted: i=1; AJvYcCUP70hsS85f6l2pcqAJKQF394fI3pnBQWnE4aVftcvCb9qdNpfJ8PGfPBMEnfvE5a9e9nQRcuLWPfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXtWKyDSRF4MOq6ufptka0syzNaSETqoA+DZSVdhoClHoxJIx
	uq7V4+yP1gxSdMwR/lP0C2g14Tjdnss/X4JsWynDGyIrM0aiW8bMURmTeLoP0bs=
X-Google-Smtp-Source: AGHT+IGc7tslgPi49wTcri9quQiODjbt0azlnXNS8MWOZXpFmrGeSbg4OryvpxVtvDGg9lRWxTQudw==
X-Received: by 2002:a05:600c:5125:b0:429:a05:32fb with SMTP id 5b1f17b1804b1-42f85ab370amr82672055e9.10.1728306890165;
        Mon, 07 Oct 2024 06:14:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec6396sm73916475e9.30.2024.10.07.06.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:14:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 07 Oct 2024 15:14:38 +0200
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Allegro
 MicroSystems, Inc
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-topic-input-upstream-als31300-v1-1-2c240ea5cb77@linaro.org>
References: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
In-Reply-To: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=809;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qsO+H2iuRs4/4dzuzkVkArIq8Mi3kTN2oim08yBLYko=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA97GS81vT2Gj6Q5uRCP11ncEubhwY9NlYC4vHG32
 N+a/FvSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPexgAKCRB33NvayMhJ0ZDJD/
 90N2lR2ZA1XJsUnCa910qcWgpcxY1vsC7EsmRq34zyBQisax9PXlMPnbd05VEOUDlUFsEQPZ/579YI
 fxCMhYi0K/1V/b5dZpGK4PFzZ+dx/JKCjAub7Bd2voT9kYFvpWNzADuzQIzPeX96rBEImXCrYTumOR
 H04A1btQHYVwQl2fSAQhCfaMVQdHEmTCM2UouHWZurR7zSi1kaIFXtUPzJZ+WKH4kJePoSBeaAeMWb
 qXaB2IsqzybDc8KavVblKjSlEuGpKfnbIFsb3QyvZcmB3cocu5kYciKaIgm1LAWlSL1TdHHRXk7ENx
 Kj5IMsFvHlKK4+xAWZK1T31Xj2e61gOmCzUi6Ca05LI04zPhvIj/Kj339y8gsp2WqZQikjYgB93TTD
 /UYceB6KnnlvVipKWIjQu/Njj0sxHntAz5Kwbm0rA9fkHmCS/Nv6lSlUEqd0VxR+2L/z3mPhGbcb4h
 S/uM8oYwWrFu2HTm4KzeVl7lK2QKs2EEB7/cYb21QCP4gt0X9WkQRv6qM1fE+SLiG077AJe8KAER+D
 f4TuLRMqzNMVXh7UHyzgk2V5AscEkEuqdcgtyFr6gwG6O0Ig4TlVbwBwYRQQBwUUcwD+zXU5KMfBcX
 uTPw/+Kqwz7fMfynBX6zgGeJmZTfBSLcT828ONHAZxy9lsYCaUnxnSVFqn7w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Link: https://www.allegromicro.com/en/about-allegro
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe..2f5b67572ef4 100644
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


