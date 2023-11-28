Return-Path: <linux-iio+bounces-455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32607FB8EE
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 12:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA3E1C2138B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D389C4D13F;
	Tue, 28 Nov 2023 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="WmB+7bvc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444FA1FCC
	for <linux-iio@vger.kernel.org>; Tue, 28 Nov 2023 03:05:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54bb5ebbb35so411965a12.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Nov 2023 03:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701169516; x=1701774316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZErotTciFh+W4EIUk/jK7VwlzHqyAHTYt/8Z9M3bwy0=;
        b=WmB+7bvc0AI//kI5Yk+uioBlenkszXC3fMviF6oE4RyBhksmbogyUfPB5KAA+8ekGo
         0vDcIN/j/NDAAN3mg2sKRBeBowSmCmcy9dYRjYlBeQAjrmfQpqqWD8Vbqtp9xG+tT1T6
         7x/L+6ek8rpEXw7+uyE1Hcxydr9/BqmeDnfRahDavVo6wVl2lqUYN+er8FNBJpnmB0wa
         aG4UqrH6qFo7TftS42urB8keYRmZFkxSWMD4+zrtGTdm39ZWSPnZt1dt1W3KXujfAkQH
         ijktlzdmEDwpQ+mgnqanaV+mm6nr/YT2qUp9heW4IBKyRe+xMiSeaio/cBjiBLpDL9J3
         xDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169516; x=1701774316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZErotTciFh+W4EIUk/jK7VwlzHqyAHTYt/8Z9M3bwy0=;
        b=deTjpEhRg333hk1agk5BmnkfIgJ3f+DmmvGmAetcXkIQeBeM0BF3jpz1melWkc84r6
         I/oquDbJZT3r/QQNBeu/X3lCh4pubqM3XoU5U2j6l1HvOs53bnBFnjg38qfjF7PogkSW
         fLYq7lWW4wMco2Zn9WNNcvDi+JKPNrTSzPQT8iawuQqv8HloaOZ1yFDoPyDGhDMypwwM
         yNJ+JHamgud3WgELdHHJg8vkV1PSLsaA3IG4+lKmY46AVn2KpLaBcy+gwfdDMVLCavFp
         Kdgc7F0hwdTFT5fUmuP3BOUOadjkRlLzGTMUbBEejFIoxoxHOi9XTghEsSnwyygr96V9
         /aWA==
X-Gm-Message-State: AOJu0YyHlz2koVoQq3IBP2gH32GG3d41lhyFN2WKm51rrurUs06osynz
	ZuAL7aFxIT0bh0ys+NWabl6YGw==
X-Google-Smtp-Source: AGHT+IF88graGsp2EiQI3DeNW7yBOyI3PBwjZMG5ecHagJ7rlExos2CVPUI+aemtEVMhr8ijiIc6Cw==
X-Received: by 2002:a17:906:b20a:b0:9e6:4410:2993 with SMTP id p10-20020a170906b20a00b009e644102993mr6893876ejz.18.1701169515620;
        Tue, 28 Nov 2023 03:05:15 -0800 (PST)
Received: from localhost.localdomain (d54C3956F.access.telenet.be. [84.195.149.111])
        by smtp.gmail.com with ESMTPSA id lv20-20020a170906bc9400b00a0f78db91c3sm2236936ejb.95.2023.11.28.03.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:05:15 -0800 (PST)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: temperature: add MLX90635 device
Date: Tue, 28 Nov 2023 12:02:52 +0100
Message-Id: <f8cb0afb2966540dd266da09e832eab22604347b.1701168726.git.cmo@melexis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1701168726.git.cmo@melexis.com>
References: <cover.1701168726.git.cmo@melexis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for MLX90635 Infra Red contactless temperature
sensor.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 .../iio/temperature/melexis,mlx90632.yaml     | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
index 4a55e7f25ae7..03bb5d4fa8b5 100644
--- a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90632.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Melexis MLX90632 contactless Infra Red temperature sensor
+title: Melexis MLX90632 and MLX90635 contactless Infra Red temperature sensor
 
 maintainers:
   - Crt Mori <cmo@melexis.com>
@@ -27,9 +27,24 @@ description: |
   Since measured object emissivity effects Infra Red energy emitted,
   emissivity should be set before requesting the object temperature.
 
+  https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90635
+
+  MLX90635 is most suitable for consumer applications where
+  measured object temperature is in range between -20 to 100 degrees
+  Celsius with relative error of measurement 2 degree Celsius in
+  object temperature range for industrial applications, while just 0.2
+  degree Celsius for human body measurement applications. Since it can
+  operate and measure ambient temperature in range of -20 to 85 degrees
+  Celsius it is suitable also for outdoor use.
+
+  Since measured object emissivity effects Infra Red energy emitted,
+  emissivity should be set before requesting the object temperature.
+
 properties:
   compatible:
-    const: melexis,mlx90632
+    enum:
+      - melexis,mlx90632
+      - melexis,mlx90635
 
   reg:
     maxItems: 1
-- 
2.40.1


