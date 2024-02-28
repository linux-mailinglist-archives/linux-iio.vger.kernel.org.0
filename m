Return-Path: <linux-iio+bounces-3155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEDE86AF11
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE80A281FF2
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814313BBF7;
	Wed, 28 Feb 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="bXoler+Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278D3BBF1
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123081; cv=none; b=a93OtKyGnTbgbQCpkr0/h9ie/zYEdoKX/BKhQ+/ryUz2ApXqT5mnawPEaZ6jzBOsNP4LQr4C7MNwX2cKIx5+ak0WEl/Xphj1xKDL9V8H4y6ioQkjjwsaHOgRap4V60NjVj2ciaTenfi42qnP810P/1p7dG5Mh+GfeptmuNqdHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123081; c=relaxed/simple;
	bh=CTZbyXg9S9AX+oEYj3aHRVAdUgGL0rW1cy4Kv5jd+ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEPRlVKxrc8qrsRL4MD+V1L2+fdwIJdQmd5tHDDow4g2l96qu0O5kPjsiAQHXJgzSHwGIfOniyhBhOms5nabYHhr6ZTWB2Imq6Bwl4YQ5ZetUIqfuk2LZcU1jFpTkm9kVpBdXdaDdUUh1hrub6oKoBg1nsk60FrQFrSBcewFjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=bXoler+Z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e55afcf513so574699b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709123079; x=1709727879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktbEv2HBKU+FIl5Q5UO06Xj865znEiKjlaXdZSuLHQU=;
        b=bXoler+Z5lEK3q8vvTY5M9B6akZ3Q19pNGqkfcIoBBvjxHcIW2nmywEIZpxFzzwU79
         4JvR8ISOAj7iP1KFsl8OVdudlAhepKn9WG6cUvdVh8tVxD8gK1eivUey48P1UtiTpIO/
         EunDEs/QqHnV9HQar2MUg4mcqoVkHWy3rCrAw2yzKOXFYUfGpI6tQ6e6OJ+wLZZSOYEc
         79xELNgA4O6ExjQArC/k/1P63h5OncmdBlkkFq26EcYsciizLKURVD2/UARnMN3IIA9I
         wJM/ehboYWd+1y3ygXoxyybazJW/9s80jP7p4ZFWELna/CnNP8pIY0mmsgQAlbKXTJgE
         KOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123079; x=1709727879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktbEv2HBKU+FIl5Q5UO06Xj865znEiKjlaXdZSuLHQU=;
        b=uk9Zwky/Mp4jN3QAdMT1JLm0urYkIbkp7zaU6L8GLHOkUnn7zGmaXcMNoFFhre+eeB
         ktWY0Z33kzP/D0bV6A5zz9Tf4qQsbkqMMws9lH5E7f5mqQ+FBodYcbcJWR5/PNyXh3N2
         /ZKeafbb+Rt15nA6aRYqt5zziqHykDVFYPh35tNLNETCC5v0slMiV95g+yXQOjDDQc2A
         c8sYYcWqo08SDOls1V0LMdgI7ftPx+la05TFQ/u0/PrgutTyFKFxZX8906It2hQ1wVgx
         Waqw2+OKWmx0A8dUcs5oSQSS7kMeO60bXbG9CWL8TY+j+n1QwoPaSBKT2dUBHAI6WxHQ
         N+GA==
X-Forwarded-Encrypted: i=1; AJvYcCVOu0ThGv85pbzhuHmaZBIXEAbAhk2AKjFZ+63hAMD5V6WSwr0/hr+gJvCjfcStOdOLBKz5nhOzNpIiaA9m1BME2+Y4NlucqE8T
X-Gm-Message-State: AOJu0Yxs2BZ6rUMBNQel5EUsC3jyphhbqPXzZlnmCeaQ2lPMP9NMAyEE
	nE64LmoH49hxTOnBDbAcE5vdJjE0MoL9DywwMibRsv6nJ6QxoflVrq5uBI9PTI8=
X-Google-Smtp-Source: AGHT+IHjGJ9oMwFjIqWvSNwyLApCrstJUqaioh0jUT77oUgIL32U0cp1vUqteozDB/pr9PQLQOGT0Q==
X-Received: by 2002:a05:6a00:1826:b0:6e5:602b:92e8 with SMTP id y38-20020a056a00182600b006e5602b92e8mr1996534pfa.31.1709123079533;
        Wed, 28 Feb 2024 04:24:39 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id m3-20020a62f203000000b006dde0724247sm7857587pfh.149.2024.02.28.04.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:24:39 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 3/5] dt-bindings: iio: light: adps9300: Update interrupt definitions
Date: Wed, 28 Feb 2024 22:54:06 +1030
Message-Id: <20240228122408.18619-4-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include irq.h and irq level macro in the example for readability

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v7 -> v8:
 - No change

v6 -> v7:
 - Removed wrong patch dependency statement
 - Added tag
   https://lore.kernel.org/all/20240210170258.17fd1099@jic23-huawei/
   https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/

v5 -> v6:
 - Separate commit for individual change as per below review:
   Link: https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/
---
 .../devicetree/bindings/iio/light/avago,apds9300.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index a328c8a1daef..e07a074f6acf 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -35,6 +35,8 @@ required:
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -43,7 +45,7 @@ examples:
             compatible = "avago,apds9300";
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
-            interrupts = <29 8>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
             vdd-supply = <&regulator_3v3>;
         };
     };
-- 
2.34.1


