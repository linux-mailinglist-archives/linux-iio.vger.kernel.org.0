Return-Path: <linux-iio+bounces-12712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C989D9F03
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 22:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1816BB2300E
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 21:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8571DFE13;
	Tue, 26 Nov 2024 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcldWTee"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9651AE009;
	Tue, 26 Nov 2024 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657936; cv=none; b=iqTwxTMw24S/pl1RsOSZfspxFdMv3rZnDe6K1RChW7zye3A1OBKzK07bFyhlMG7GR3qzk12oEsUImWDZIGGf1XzyBX74ZnGaXtELHTlM/kEZEEpw6nY+QV2+HLzxaG1mlfZokTmiQFon5P9Ip153lsw78A6J1lBi5NDEeVlgJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657936; c=relaxed/simple;
	bh=fxZJnHqWV5TFUfGk7BJsIchjMpt1tkg5hJq7UEPX+pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1PnkyWsHOq1NyYrmpUeGoHxqRZ3jjM6chrzy7GVBJzcR6GX1eR33WBicpbMhsaFVGpgtAMBVQ2wupn4iYukiV2V7Ut/wAIGEvYrFJN7EdamGTOEnLq80k32qs/e7lixOC7wnQDUryjHSA0058Wh4Jb/1q+Adu3gD3qULy5Jyho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcldWTee; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3824038142aso3920875f8f.2;
        Tue, 26 Nov 2024 13:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732657933; x=1733262733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdDxPG45f8xEG3kBTgtcToT+G4B82UHVdmd0iF67qpY=;
        b=ZcldWTeedovCRvu4VuSdiFReGLHEXwU3bwGJMf9BjKfNAFxeNpRysu5ufvvPUhoA6m
         3My6X2ntythiHWsyf7Yty+/3CaoIHQLoGcjPV2MSgeXsGRKvwqi980Ts4nLYgwn3Os+P
         XBKUUvagvLBG9f+xZzVPGhR5UiWKooX2FYMQgJWELs+aeF39EdXD9l8CyXHIOb0wiUxd
         h+v2Y9lyLxGzwR1M/N3//3pThSkADfTAJsyhF/at61Vl6YirlTE+VHYkNYIw+Q+FLx3J
         IHiZAg+5xsayKCi3lmI1UQ6+x2OOtgFFQUF7IQtvZN5u/+1LagsoX/P9tuPGTzzRKutb
         K21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657933; x=1733262733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdDxPG45f8xEG3kBTgtcToT+G4B82UHVdmd0iF67qpY=;
        b=bm55OatyKSkBGWxs+4pyBcQTVFSv89K0Ueg9Dm6u9ZHquxcYMHQH986GbP7dIHpZyy
         OQWY+IIKLXh6M5YSo55HR5qp9kh+OT6hk/EGzuUh7718Ke3fkU5UZhuCKgJRxdgzkt9G
         4hjlpdKti1E027R1XvAYkPBwXUVCcoWb84QBM9385ESKd8wkeTKcofqiNzn6eDvuHkY7
         yddTpoWakeSXBnevW0pOLhJkdXPuiDEwyRJLFWon/1isusb3PegKgTudD4h0QoxokZAQ
         y2ejSbZrpxjYB/4rRv9/yEqiAbzB2r0heBp0GVsHRanRpTvalaJsUmXOz+flccb9lKh7
         T9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWmKT0DuzPol4Ak8x1Svjs8RlVGdP7aUlsoP9fpv/gApbqJHv0M3tVNPf51YsRw9my++gy064vuNZEh@vger.kernel.org, AJvYcCXX4syT+RH77UwXkT2DAxRw5zNWDAbmWKWwKv9KnIqlCeVq6jdXbuBRR6vZvlRYeQ3jWFN9ETRNfsrySODe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+llGa4/GBaLFpaknan2f702kb8AgPBTTt61SXaCtJ5gujE7lW
	cVVBW3pBRoB4ps0wbsU/NxBM8KUs8cDMtK2RUKAmy1RdFVhyPqHs
X-Gm-Gg: ASbGnctaBbApgWKTXUPyJgN2ffz+jn0TMPWHK+gFDB4LW0jPuC4lBooOiArOFJq+YFK
	gX7s7o5zQjJ80iAsj9OMTDHcEybbgbdCMqe/DTcNxDQYFa1HNKa3DNjJCEDjXEpkNEPuqU/BMZb
	I0mMr7R5VbxW8fmPUGPfAsDbm6oEWdPfesZoJsPLDuZqRQUT+LzO9d1JfA2Itb9kR+QavBLnwK2
	2zoaZc24FUNij+iIgr4IgPYDF7xVUDmCpbAX2fLybykmR5p6qQdGuGaYFAGYwhhdsfi6LRXTBwB
	LojzWHZVt4xUzx9prdHo+SyMS+9XKCrI4pFPOCKC0fSzliY/YPXF5o/eYR3YZ3Fyeo7y5wk=
X-Google-Smtp-Source: AGHT+IEl+H99wLjJqpqWPfF5VwzrsGZzHFMynQMllo83etsbI1Qk1o/mSBUv1XpGND8bLsWjSc6siw==
X-Received: by 2002:a5d:6484:0:b0:382:49ad:54df with SMTP id ffacd0b85a97d-385c6eb8de8mr362512f8f.2.1732657932416;
        Tue, 26 Nov 2024 13:52:12 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d42c-04c9-936b-d14b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d42c:4c9:936b:d14b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafedbcsm14570297f8f.41.2024.11.26.13.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:52:11 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 26 Nov 2024 22:51:54 +0100
Subject: [PATCH 1/2] dt-bindings: iio: light: veml6030: add veml6031x00 ALS
 series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-veml6031x00-v1-1-4affa62bfefd@gmail.com>
References: <20241126-veml6031x00-v1-0-4affa62bfefd@gmail.com>
In-Reply-To: <20241126-veml6031x00-v1-0-4affa62bfefd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732657929; l=2608;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=fxZJnHqWV5TFUfGk7BJsIchjMpt1tkg5hJq7UEPX+pE=;
 b=2n1UGwkJMixA021KNLYi2DHgIZvVZDbM8uL1h4+MOWooiib05AFwHDRsDJYMUOcTriGKB/lcc
 yI+jVGk1EBwA4EhrJABfIuwaYO/YZmqVPOGXPMR5Z6mZS0uIsyYuOpe
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These ambient light sensors share their properties with the ones
from the same manufacturer that are supported by this bindings.

Note that only two datasheets are provided as every one of them covers
two devices (veml6031x00/veml60311x00 and veml6031x01/veml60311x01).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/iio/light/vishay,veml6030.yaml        | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 4ea69f1fdd63..e01e8747e47c 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,9 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML3235, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title:
+  VEML3235, VEML6030, VEML6031x00 series, VEML6035 and VEML7700 Ambient
+  Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -22,12 +24,18 @@ description: |
   Specifications about the sensors can be found at:
     https://www.vishay.com/docs/80131/veml3235.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
+    https://www.vishay.com/docs/80007/veml6031x00.pdf
+    https://www.vishay.com/docs/80008/veml6031x01.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
 
 properties:
   compatible:
     enum:
+      - vishay,veml6031x00
+      - vishay,veml6031x01
+      - vishay,veml60311x00
+      - vishay,veml60311x01
       - vishay,veml3235
       - vishay,veml6030
       - vishay,veml6035
@@ -67,6 +75,8 @@ allOf:
       properties:
         compatible:
           enum:
+            - vishay,veml6031x00
+            - vishay,veml6031x01
             - vishay,veml6035
     then:
       properties:
@@ -79,12 +89,23 @@ allOf:
         compatible:
           enum:
             - vishay,veml3235
+            - vishay,veml60311x00
+            - vishay,veml60311x01
             - vishay,veml7700
     then:
       properties:
         reg:
           enum:
             - 0x10
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml3235
+            - vishay,veml7700
+    then:
+      properties:
         interrupts: false
 
 additionalProperties: false

-- 
2.43.0


