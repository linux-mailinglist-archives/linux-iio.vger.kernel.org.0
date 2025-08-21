Return-Path: <linux-iio+bounces-23092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E332B2F267
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4943A614A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A142EBB9E;
	Thu, 21 Aug 2025 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+ztkYLX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0226B09A
	for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765122; cv=none; b=fYe1zmE488ktR649B45Tq9+KA76TWcAq3p0Nh9IDxWqWfGqC5Xqyu6sK09PZOYLrhHniKaGIcno9AWSBOs7m4veN6jll4TGpdsKowTUw17YRDu+rDvlx9Fe2HlGkMjnC1sr6nBByC6N9MiI9Fetzm5bnLgbQnSvGeqbNb7W8j3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765122; c=relaxed/simple;
	bh=o6wtN3783MnhTkItU8+Bf3YpWdPfZYyFxZjqmDsrBMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y62/NLWZ68hI1H9ZlQyDL4w4pD9U3IDpIEe5YVAPC8R9N+scACZZkEdkIWCooajUY2FMLH2AI4HReYqOdsfhMMuX4ZgLLAs4fi6Jc1MoTn9TKloFOqKqgYR+aqZbXkVbvY4uihxSZWDh81oumfLUk62F476/mdRVZEDt6mdPNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+ztkYLX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a01426so8311666b.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765118; x=1756369918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T72UFcH6AjzcUCkgHZUc2QAiLeOpR0se8y/86dUUmFw=;
        b=s+ztkYLX7rWS1IAvosc3Ypql6bqLQYnMOnJoQrGNNKZVIC6/g8DQhSWS4NkLHc6jKT
         RJALzxzy3apiN6VrlTJOedOkQiqNujd2eMI5WIYMrBDQ9VNKTnK3L/G+AxksOHJE4+fl
         yKYRg7lM1hnyefHiCwETye6j4SZ9ay7uP5ZpyRP3GNKv+zZMHvx38OzdQsHtKFOdWUA8
         Zmd9yHoIxuBzQQjhLeXLsCIgzjPW9bA1wqLCfgeInyaInoFB4jFp3WnAVKAiM3WcBkrN
         xOzoLES1ePpHne60p0kB0Y6r/6md4IZ9WBG7GlFn45kxLwL5pdoVN/epUUwz1JBeNUDT
         nzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765118; x=1756369918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T72UFcH6AjzcUCkgHZUc2QAiLeOpR0se8y/86dUUmFw=;
        b=O09VVqbA6dXWBEHHu3nMVialtGVAA2/Lo0QMhroZMiBOryVAFbQgFBr/x7W7DgYa+9
         IQOjP6CCles2bmSzTcpcGs8/uEcipwmyPEpUYjFqjURcaiSJF4dMmDRgbceqi5Vx9mBc
         P08UK86KZsMUl76hqB7x3+Zjr3CuTJ1VlzeKrLnHRffJQCztLrGzmVJYyqFGebhB5vtu
         vcUGOXHmktrN6RnNgPw1ZwL39Jjjaha+WYnTC6bkeZTBb2yv19IACjpD6XpRA3YvsPXl
         8oI5OfgUkFOaFSYr61HkMplQYvrn8DUUguTh7dZ9aeP/TPm1spZCT/msKbM/VdoaQw6H
         l4iA==
X-Forwarded-Encrypted: i=1; AJvYcCWEwueLp8TBB0q5t4jNsHnuiWMbS6T622nrMeek6gkdOZ0u0YztuPxDwYUsb/QJxj7IT+UWKCe3Lp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYrD+zpns0sGRofrgVSrKgvGPMv0GTpbPdXZHPGBg9wsb3QJ4
	u0O1/dmxsfKzEv5M6h7qwxGoP5GAwPrqwVcniBeiiANnYLetc0ex399T4Rg5bCmxxvw=
X-Gm-Gg: ASbGncv9RTD/CInfSBiGW37/TGgGygs4bT0yMl4rHlnlzHlmixwbtYkDvtEpktZ3d6q
	D+KjPKZo90ny43LvtjtzGgDB1xZ36D8cWaUs+1UfEy98q/xtHU0Ww4p9S6rzLM8eHOaQCK217LJ
	vynBJl04afMTfsH+EGSEQZAvz8RVIurq2ZCbawQjm4fcutUyWsrw8E+LbH5U1dncB5pw1YCtsgp
	UdgkXD2r5oKn31TJciFuADFw7YpVQYbfgFYS18vTIDhr4ZVahgM+9C0feY5Irrr8eF0YN5wyUtg
	fK2x4/zkE/KwyKxmo05N+XAYMCZMA0j29QoNBOL8kyhw/8qx6TpiTlf/t3H+VhP7DF8g9HmNxp7
	ZT/IGjg3pP919zdS4RVy26Xb5mflwWBwN1A==
X-Google-Smtp-Source: AGHT+IEmYCB7RoXV5cO6L40St+lRMNzSQSwZc09J9Wq+5CcfC6nThev98ei1pp0ECHLQKecQGw45HQ==
X-Received: by 2002:a17:907:2d9f:b0:af8:fb0a:45d4 with SMTP id a640c23a62f3a-afe07a20215mr76866066b.5.1755765114658;
        Thu, 21 Aug 2025 01:31:54 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded35547esm341911366b.50.2025.08.21.01.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:31:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: adi,ltc2664: Minor whitespace cleanup in example
Date: Thu, 21 Aug 2025 10:31:51 +0200
Message-ID: <20250821083150.46554-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=o6wtN3783MnhTkItU8+Bf3YpWdPfZYyFxZjqmDsrBMk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoptl2dxU42hCXeG4lO8ny/fQClzik9KbgZZ8H9
 s00I/xTaxeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbZdgAKCRDBN2bmhouD
 17AQD/9+lWAFaa/J1oRYmRcHyrNtykXAnAF63nJwJijngp+Hh+IlrctA0x26TBH7oWarxZFvN9E
 El2wORkEIhLkESFL+VoEVRRiHMjNehb2mjsbNUzs/wTGHd6iaY06OSSGjWOkByG0R4VmxVDngG1
 kcbxhjjcCtcyFmcxtopvwAKKYi6uXPLjspAFcKdOwtV7UJn2q8u3tr+LMrsoQlkL6DGdvMyGK2d
 c8AYYH2fDGDaPySi3GDkX1hwEfBaPXGzjrPKGnqmuzaH/8W7dlLw+kJ5j8ZKiMa+87cRFG/oFPU
 srzBjpMNVMFmYxeYqmGIkcwlLcMobAYRA3jAXEYCBICCmBQ7WS15yr+sLXoB7aTljGOl52aq97l
 o315K5aww3EufdswS7ppqpFCQjqpbT+uWo+XhBBsRRyy9aY2HiHb1/cY3t+tNWutUxDAfhTsCqd
 /nlgtBaP55lRokisyLf3D6GLR+KvugC4knuMh+ZPFlexxDwxzqEEOwmq+yYCWiUKOBXk6T1Up3k
 DbXRiONLDHtgS/WRzW/GAvtN6i0QPB9qPZj/AOQ3beKRmwK2MdYNpX9Mlyr0yvw/vcGfP82jSpx
 p3IWuIm31c2XGI6RIiIVE3CLvvy9qE4ZWb76sRg/HraVWtS3JN/oeGmtaOLMM3ej2VbuOqpd++X fM/oa2Jdefzs+3w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
index 1aece3392b77..4688eccfeb89 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
@@ -174,7 +174,7 @@ examples:
 
             channel@1 {
                 reg = <1>;
-                output-range-microvolt= <0 10000000>;
+                output-range-microvolt = <0 10000000>;
             };
         };
     };
-- 
2.48.1


