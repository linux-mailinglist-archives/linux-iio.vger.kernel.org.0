Return-Path: <linux-iio+bounces-18382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8575A948C4
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 20:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1D53A8A3B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3D20D4F4;
	Sun, 20 Apr 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2KP7HDC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534031E98FE;
	Sun, 20 Apr 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172638; cv=none; b=U+IhsrXXE8clwd+k/6qtI2zZbBz/ukuKZBdmE4relJC7ZvzLIWJK6cxSHcKdeo0btXvhniHeQbBZ+uuADy8iToi4HjJ58VE0pOu0lueh077V4Jl0StfFzpojWPyNHuEe55M4SD4v+t7+b3lHj9qdJQO0YLXx9rFMR+Lsr52jAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172638; c=relaxed/simple;
	bh=7K5WdTr0Su7eehKUV+hGjfBgc29I7BKerhOxeBxIL0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5yaZwcB8BhjCdNQFojQQZbTIAj21E7PVxqI7KDbcqCuRAUReIQgEHwZfW+YA1qIfGta1XodVHZVjBNMJyKDbMifpHqMgs6V6t/0fwRpuCC0tRI4V0jAXnqZWrTnNXSspqrIZJLwdhCGsNr/6Z07xwL8m+DzIsbiz5nlz/BN9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2KP7HDC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73712952e1cso3067947b3a.1;
        Sun, 20 Apr 2025 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172636; x=1745777436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj8kpmYrdiK9mCxsMqgrjwEIay8Sc6Z78TIqN3FAEJ0=;
        b=H2KP7HDC03Io1ZAkcTKlRjQKIcmZlUip1tbAyaf7t7ffvXNl6+bvL6tJNAxQq0hzC/
         fEnbR+kNkcUAFQ9JCoxOExmd7A8ZzTkp7f2VbJo/s8z+Bhcb9XQPNJWgZXsMtuy+2jZG
         drdfOPMXuGel4vvQq0IraMznIeRt/mPaX5v9d1JTMwP8ZyPs1nbcI3DCRZBOOYNeMZWP
         4WCfwXkmOjWwl7AmvCP8ySkHNaQeCKb4LAXUbB+lBdAXuaqLlXaICxJZij8KxM6D1yK4
         2Hs4tXN1zXe7HpVViq6gEDFI0yO9sbo0SeQgbPLblb7oSVEG5Ec3DDNMXMjZchO+VWW+
         wErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172636; x=1745777436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj8kpmYrdiK9mCxsMqgrjwEIay8Sc6Z78TIqN3FAEJ0=;
        b=qAheX9TJPnWlWjDXh9/3EgYf6gbhSo4VwkDznq58dciwxcZmKRKVOwIjWaJyFn7EsV
         oTRI02N16hh1+zBaJ0Q6whqQkHpun+LgDa+DRvHVFLO8w7MnqbMrI3dvHvXlJRHTyTzK
         /B7IK0I0nqqIk3vlsZ/pBWX4QvTPk4zpniWyLAflDzgyP44buRf9TGBXhEeGhXMFnvvI
         4LFeWwFaZvjbKAJiGJXFsV6igK/UBKfLsTe0nePQrVviwsvInQg50485Rxr6h+HWQbtP
         f5rdZlsxtbhNg1ALnhBHHVR+by2ymkQEBJE9dV2V+5mSCYCM0bBftxqIu+BFrABMWM2R
         opdw==
X-Forwarded-Encrypted: i=1; AJvYcCXHlLMRF+IJ9n1THCbjqNcMAdfa37xIMygiFRhgRr+LcHhn6oVkYGFjke080vdk74dbXVFm6JXuvLDR@vger.kernel.org, AJvYcCXLXFGOTMkwtDKf3GrNe5ZFvzrMuVKxD1G1HgMngIajmjBnfcqMVZXyYSoHFM2s2hcrGIYoaOjzyMrc@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkSAcG7McxcT7zORZLqFK8PStIPAKbiO4fAu4pFtZS81WrKpz
	T4pjX387jpqy2qjDg69/0u/a34klNTHkbjltYPQRdJJ1PZ/TBeUD
X-Gm-Gg: ASbGncta41cw1iqbnz6P3jTRBCB/6HsOeEzGkPdQqWmwop/JW0n7QZwgxqtMUGH/2C9
	BfeNps8aAHuO7QKo85b4qVqof09fq18sf1u/mp3yMP+wj3us2la0wMm3Mwh75hY1zcj/Kbkr9wY
	3ADC0c3ws8AQ7ecHh0ncDYB05TuVaiI3oplNytgm4b15OsaJGGjfDporyj2/L7wv1BvXmWjfuya
	LA78cXic1t2viSN8W6tftDl9kKo//Db9kTtKEsvS8WOiNhtNJl+gM0C2TMqgwghmLNzetrcOmY9
	ejB7LBOExlnQCZ5MetBVXFBOgWX+SpfP+Q3tWxIoRB8/LqaL/MEHI1yAow==
X-Google-Smtp-Source: AGHT+IEha1VAMXI8Egbe1QxtYcC3DqntL/BhVYnjHGUOa+D0xRLx+ds9/TdxCDOfQNf2Z1KP+tB9rw==
X-Received: by 2002:aa7:930d:0:b0:736:476b:fccf with SMTP id d2e1a72fcca58-73dc15d7fdcmr11259795b3a.18.1745172636492;
        Sun, 20 Apr 2025 11:10:36 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf8c05b0sm5009347b3a.35.2025.04.20.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:10:36 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: add winsen to the vendor prefixes
Date: Mon, 21 Apr 2025 03:10:12 +0900
Message-Id: <20250420181015.492671-2-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420181015.492671-1-gye976@gmail.com>
References: <20250420181015.492671-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add winsen to the vendor prefixes.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 86f6a19b28ae..6d35549d2e4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1689,6 +1689,8 @@ patternProperties:
     description: Wingtech Technology Co., Ltd.
   "^winlink,.*":
     description: WinLink Co., Ltd
+  "^winsen,.*":
+    description: Winsen Corp.
   "^winstar,.*":
     description: Winstar Display Corp.
   "^wirelesstag,.*":
-- 
2.34.1


