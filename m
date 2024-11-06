Return-Path: <linux-iio+bounces-11940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52B29BE46A
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 11:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7997928557F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769E91DE3B3;
	Wed,  6 Nov 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Edm/wyRZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E441DE2DA
	for <linux-iio@vger.kernel.org>; Wed,  6 Nov 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889514; cv=none; b=JErLmo9RaiFDJaKzBjuw0uXJtzfRAk2DOdvndH/tqOVHFd7qxEvckChoR8nwadlUNEBlH1k0hO/1lyG0A8DViJ5l2cnvzWKiPWDYyhtMf6quck2zYOvtxKbM3z5RNkb8re8zd+SPfxl631DWM1tXx3QsQuGefPcPwwZn+vtIkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889514; c=relaxed/simple;
	bh=xfVECVyPhstuVzixwnpeD2YetzBptltzs/LNlYU8a0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIsTmL0FGflGuPka+hkr03y+a1y5ilBU0n1c04wkj6ie9xEn+CnUWXAfVvzvWJeZES0bnMJIhJ+J2Y4pRTeOAPsJqYrBYYTw/nHhtjPxBZQDMaAsAhTs/azoVwMlUVWODhEsXmg3oL4F7sFnQZnJQrM9eNGxjCREUKj5i7LUIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Edm/wyRZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso51227415e9.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Nov 2024 02:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730889510; x=1731494310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VY6uZFvxEU5LyK6YK1tW8F5ABPl0h8dIQVI4hDIvL6U=;
        b=Edm/wyRZ3h2Z0upEfBE5EFTB2uqTUKD+iMYH1BJt8Bms242NbnzlEJt6ITQZmhnbzD
         bOGdG6IBt3OD0fdBHKKJnM7B8zXzAYknpX7KYm2kCsW+dgNp0qc2HpOeG9zfKtGyDg6W
         3VXMoUJz8wMPg0gMYZGJ3dr4xA5OZPCFjzJoF6fcpnQ62abHi2VWWbYUkM3HYAbLH7ih
         KbqHfWqLVbLbGn3R82EMTT1XAQHesiG15W1lv92Xl0Xz75mXzxseLDTUwzCD+KGq8Qao
         VNm5mQSBigR0heCmnbEaUlVHnkmjNozai+eRQrADHzTpImxTSf0E2N0MA8PnurJPo+EO
         6W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889510; x=1731494310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY6uZFvxEU5LyK6YK1tW8F5ABPl0h8dIQVI4hDIvL6U=;
        b=hKLZRA9ghsktNO1zVy9U4i0YyBUhY884fCcx97dnCRg1zknHeP6ycM/JdbZDcMaqq8
         EPK0N+aUBGJt0RHsiGs+6LZCAdBpHzqBI/LPZLDTLzM9ysuGq0s+zQvthtXO+OyVnD3Z
         +fxmAlaAs0psQmViXB5MVChELwDEz472GrHi5YUTz902U4nx3uSGoMe8an0dVMsbbvd5
         V3T95wiS0v2xUHGWsBV74DHlRdKZ587EG20WAkW4KIg3fhaSF03SHfwQ4x+Y4S2qE4y2
         K1JAb5QvVo3sbwi3Ce1kPbkEPgwjddAXqen7LGfXW6Tzp/ANcBU2cV1vderyPrBSouJD
         cmng==
X-Forwarded-Encrypted: i=1; AJvYcCWdm4iV5GEmLiz0BqPsNZKedC+E/eLn/wT2QWVItkg5K98ZDCyzQo2HGFtG8RWL6XAoLjBKSnXoXUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVK2tG/+qI6vCx3NjR09jCtqlATZJYu0tMVVkTCUisn05YTXKv
	Rt96RvMux5GsXFaQfSA5Q52d7PGZsfW5qwm5xZF3zIHBI3bjGfk0nkzA8sfcTzc=
X-Google-Smtp-Source: AGHT+IG0moN4/ZDGzWYlA0aTjJYKTQ0jeyFFEkAKoyArrCWMEt0WHKRL7KNUzqDgf3nMKBqq7+I6Ng==
X-Received: by 2002:a05:600c:2d81:b0:431:93dd:8e77 with SMTP id 5b1f17b1804b1-431b172b3bemr312880835e9.31.1730889509969;
        Wed, 06 Nov 2024 02:38:29 -0800 (PST)
Received: from axel-x1.baylibre (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6da89bsm17667715e9.30.2024.11.06.02.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:38:29 -0800 (PST)
From: ahaslam@baylibre.com
To: jic23@kernel.org,
	krzk+dt@kernel.org,
	dlechner@baylibre.com
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	ahaslam@baylibre.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: dac: ad5791: ldac gpio is active low
Date: Wed,  6 Nov 2024 11:38:24 +0100
Message-Id: <20241106103824.579292-1-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

On the example, the ldac gpio is flagged as active high, when in reality
its an active low gpio. Fix the example by using the active low flag for
the ldac gpio.

Fixes: baaa92d284d5 ("dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios")
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index 79cb4b78a88a..2bd89e0aa46b 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -91,7 +91,7 @@ examples:
             vrefn-supply = <&dac_vrefn>;
             reset-gpios = <&gpio_bd 16 GPIO_ACTIVE_LOW>;
             clear-gpios = <&gpio_bd 17 GPIO_ACTIVE_LOW>;
-            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_HIGH>;
+            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_LOW>;
         };
     };
 ...
-- 
2.34.1


