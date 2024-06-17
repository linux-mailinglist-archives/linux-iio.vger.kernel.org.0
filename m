Return-Path: <linux-iio+bounces-6433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52790BD41
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E477284193
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043187492;
	Mon, 17 Jun 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esK0aLvb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF919146C;
	Mon, 17 Jun 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661963; cv=none; b=cG9LCoX5lQVhL7+ty/jdg9MX16PO2HU5JaS/K8SySFlK2V5ymfGjah825bol5g7xhFoZRm21Sk5Tsn40iudgWJ1YZffp7ArAUgTHZVivq3u6ONlXoc24a1gx4rBaqUsGjmn2iWKdcc4w0yn0X7EQLUDdUPGvyC+87/CkA8D9Vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661963; c=relaxed/simple;
	bh=vSX80ON8QT7Jk17w76m3OpTB/4ybhhptsr9QuMGNPIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5NvWgVDXuN/F1Uf4aez4S/FOqNlNegEHRBlia09f1+GVpFc584vXM8GZdrWUm5NhuMiIPES8FgFro8JFsEXFPmuzjvN/t78EXrWsQ8QB118mtgU3hSbu3SkB+sbp4toJptESsn19kcDjGWUKy8ELHbB9F7I3TKsV41VLjL4HVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esK0aLvb; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8ffe1b65dso2273167a34.0;
        Mon, 17 Jun 2024 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661961; x=1719266761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72c1oCxCl3E9fFtbjzZp2Yxwgd19L9zndmRoUlwxJeE=;
        b=esK0aLvbuvK0zuFQZuEuW1E9S84iI2NcFLc3bZOmZcv/WSggutgqq7Xi/eHdizfZvR
         4Q/2KpcnPgdDQjk7ysqyOGz5VOEAjgvOlwf3fkTOM66OFKS8aQarUKozD8AuF3uJq/01
         ZzQC00ttXRySQjqycntGwtbEhX1OScUzG1FfHVCqd1yfuPdVV9gAzwDIZebRg+bC8Mev
         TNwP2rctfat+C5Lzs7013G27/PaF8TDPECIqCrYOTbET4R/KptLpzX8nnWU5tG43MKzE
         MhyKnopBBwafyHUF/TbXwHAV5a9i92gVd3hVvcwy+9NrTsSVs+YzUjFDUoGo+qeaAu7O
         eNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661961; x=1719266761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72c1oCxCl3E9fFtbjzZp2Yxwgd19L9zndmRoUlwxJeE=;
        b=WazS3zqUnDSl0E5KIPlPlzv01NIqurKY1RdBf0Rx3izUVKvZ5MWhwFF/yd3zHJQarl
         nO0VGe3Cnakh9YPRZoVk0KXk/tUyBXiPBRCDjjKB9GVgDaJ0IB/Xwue27+olqEjoKWNW
         LPJtDpirhnIbiSAgWeFg977Hj5xXtYH02yYwR8iKmhVKfVoYtBAlA3ngyTa66qTjv2Sx
         UCA5EJE6e0baI/kQwTrrJTq2M8E2wmd/8CCkOihEvmq7/n+zMpZ7Rlk2ygyrWGiejDQ8
         NCkGD5TMb5r6woVkTtTwjToJ2amn3DOC3ZcYD87uljdOVI5AXqAAcRGB1Ojli2sL9sDG
         kqew==
X-Forwarded-Encrypted: i=1; AJvYcCXijt8I5ZZ+WDR7SHn5CsdosfHal5gLAhj0gmeZ37OHkZ96KLIoYO5Gq/kXwnPx7M7Mdrid9iQmkluV9bD6Xb70iqbwP7MpD0zQinn8gsxCnbpMgSd6s2gW3rvIx47M61l12ha+lQ==
X-Gm-Message-State: AOJu0YxOnDCYSpwmiFf21qSHDg33o7SEIpDUQbyc3Ydp7DQAE9NXSubU
	SiCo2FegQ6BswK/2s0ls/dfbDtp/MyKV/k4Wp5doWU9Ma72qhj7O
X-Google-Smtp-Source: AGHT+IE9x7T2l+/foUb1Q9R5OJWa5Z1pPLXeYGeinTqk3kSXkdgHG61T0IPf6oTedgA4/lrD6wlwRA==
X-Received: by 2002:a05:6830:349f:b0:6f9:9d6a:2c84 with SMTP id 46e09a7af769-6ff15cd3226mr625445a34.4.1718661961372;
        Mon, 17 Jun 2024 15:06:01 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0fa8sm1664232a34.28.2024.06.17.15.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:06:01 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/8] dt-bindings: iio: adc: Add AXP717 compatible
Date: Mon, 17 Jun 2024 17:05:28 -0500
Message-Id: <20240617220535.359021-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617220535.359021-1-macroalpha82@gmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add compatible binding for the axp717.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/iio/adc/x-powers,axp209-adc.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
index d40689f233f2..267c74fa2d0c 100644
--- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
@@ -37,6 +37,15 @@ description: |
    3 | batt_dischrg_i
    4 | ts_v
 
+  AXP717
+  ------
+   0 | batt_v
+   1 | ts_v
+   2 | vbus_v
+   3 | vsys_v
+   4 | pmic_temp
+   5 | batt_chrg_i
+
   AXP813
   ------
    0 | pmic_temp
@@ -52,6 +61,7 @@ properties:
     oneOf:
       - const: x-powers,axp209-adc
       - const: x-powers,axp221-adc
+      - const: x-powers,axp717-adc
       - const: x-powers,axp813-adc
 
       - items:
-- 
2.34.1


