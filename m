Return-Path: <linux-iio+bounces-9901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F1698975D
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 22:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550C01C20BD4
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B301C185940;
	Sun, 29 Sep 2024 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1upLxD9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5020184533;
	Sun, 29 Sep 2024 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642344; cv=none; b=PnImZaRrQLRnGkvFI214dnbRJNRGXjqIZ9+QascL46gt7tdoelp5LajIxP88A3Lwj6L43XUsaAKY9WmIAIwKx3vxSadBgeBeNwgU1YiWU+PLb55m+SgKIrFWh5uUlmFGikPro+Ocd4SxVmVlJDCS7+ByXGjCVFXjo98iAQf9QWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642344; c=relaxed/simple;
	bh=2fxmLED2bkXw7zJnbmJoNk12B0MjZHuktZkG9RBX83s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bz8vKyxjLfb2OUzlJqoCOGSDNby7EIJkEl6ChE9+prM0EgIFrb4js2HQQ5BAiPJQRmFt5vg3Sp+lDnixUCOAYpb6jZGnmAbbuFlbS2TOH9lVkrC/p9V9UcD7VovzTqyrCk1Kd0XQT5/nDtrjkTvkCnoDhi3R7VV2Pda5FFB5sW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1upLxD9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c89668464cso795101a12.1;
        Sun, 29 Sep 2024 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727642341; x=1728247141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMysew5K9lnvvjxpQ58+D4vAE5LMvIeMSdI3Jzv40Ow=;
        b=S1upLxD9qOH5GUyfZ4keiUt9ndzVW0wQk47hOXrbMeD+XTJhzxuNaqOuR7+Weg3b9F
         6HPox1Dw/vHtX5e6EfvqNtTLf3EBNeBpTKF4oS0Kaa1ov5PD892e6KOjv+GKhy2g2+8O
         q99LSUYSj1QXsJEitJw6oIGhsFxNiHt3pNohAA2cUJB6Cwk8d/BeCQrWFfyv7Gs8nZl2
         NDCXjmK8AUl3koWHqem713svzCaa2xP2EWSEsdi9ITe8Mb+WGjbqyZAjFTpRc3lh15iS
         QM3vvZZh+P9NhhmSpKc1hGZLFjVapb+ieP+FT+DNq96DWU0FzaLbMRF0OQs8TydFTku6
         S6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642341; x=1728247141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMysew5K9lnvvjxpQ58+D4vAE5LMvIeMSdI3Jzv40Ow=;
        b=wr5lxBfVVo4z075syBU2wX6aaXte+oOjbq3GPZLw7U1hh1IZ6/OOseZYp9z7q1mQB1
         dmLBzLSRxbHh7WK4zp69EGWAPztZFYL3BzcIjiFG8U7xD+xX4Xc1EPbe2Dxl0pat8DKJ
         DHSYqeX+LRnmFSj2xtl0Zk7kLfqLQYqKdUJRs+RnrWYfXgGVB5TCYbiR40iL4grT0P+O
         n0PuRSJYQSS2chrUcWhcdCzdP8eMfF97rtChigYh+ouLENVedMLc4GUIh6LO9qAJgOPK
         5dfMx0x6/JvFmTHI1Y8/eCZC7Mr/zO4rkcIW80HM30Oymoj3mJObkTJ7rsVQ9P2O5swy
         Y1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/n1ZUComubJaPNo54qON6VP+sw55rxw8QZ6K5UnU1luG9jiFIyMMOJyK5sM/j2hPrIG6nb5sNKozeqRV6@vger.kernel.org, AJvYcCWwu0fEY8GBJYjskFTToX6xIVWcTLX6uEE33HTr05z0WxBCv8qw00GBuHfQ4HaQ80AeXHMd7UtcDaOi@vger.kernel.org
X-Gm-Message-State: AOJu0YytRuikteue4ofeni7akoaYn88r6dK7rH18s2XLjj9rgxp760Ux
	t77LTSgbIsRBHmBXd2UoVDaAVGglcFE/dVsbscfheBOep7O10Xbh
X-Google-Smtp-Source: AGHT+IEBQfuYQ/crL7twzbTKCaCyZNl9oZB9cDvm5zTmCR8cMnKI7PlQRCJ0ITmjW3+07cP0sTGIbQ==
X-Received: by 2002:a05:6402:51cc:b0:5c8:9459:b9f1 with SMTP id 4fb4d7f45d1cf-5c89459bbb1mr2280288a12.13.1727642341164;
        Sun, 29 Sep 2024 13:39:01 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm3487985a12.19.2024.09.29.13.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 13:38:59 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 29 Sep 2024 22:38:50 +0200
Subject: [PATCH 5/7] dt-bindings: iio: light: vishay,veml6075: add
 vishay,veml6070
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-veml6070-cleanup-v1-5-a9350341a646@gmail.com>
References: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
In-Reply-To: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727642327; l=1151;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=2fxmLED2bkXw7zJnbmJoNk12B0MjZHuktZkG9RBX83s=;
 b=Kv6YXGSFet1aI7iyDokB6Nm6g6T9lPqgnCr23bOgJ4/r9g5hdi+NmwXX5OxDGAM1yfumDeysE
 tgg5JSZb4MJB8MRS0Tc8pwzLgFaVRbrkwIxnyLVxemhgWZMrN71x7sP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This UVA device with I2C has the same properties as the veml6075, and
the same dt-bindings can cover it too.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
index ecf2339e02f6..96c1317541fa 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6075.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Vishay VEML6075 UVA/B and VEML6040 RGBW sensors
+title: Vishay VEML6070 UVA, VEML6075 UVA/B and VEML6040 RGBW sensors
 
 maintainers:
   - Javier Carrasco <javier.carrasco.cruz@gmail.com>
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - vishay,veml6040
+      - vishay,veml6070
       - vishay,veml6075
 
   reg:

-- 
2.43.0


