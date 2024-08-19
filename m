Return-Path: <linux-iio+bounces-8612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EE79570D8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA4C283284
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF6188010;
	Mon, 19 Aug 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOn0h4zt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F360F166F39;
	Mon, 19 Aug 2024 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086133; cv=none; b=IvpGM8tc1fgr+u+m20avROlGkUZ0NWh9frwUzT8zDHukU4PTocxEgTrlqq8xvyAum+pK0yzTp0/IBMpG8cKMqhU5FuyTLxKooSVJDmY6IGwg+aXT0qomzSAOr0oArshPrGls9vrMog2Q3M06Au2W8k3zRekKifBmMI677izYYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086133; c=relaxed/simple;
	bh=2N5vSF/orr/5lpFq7UMO/MLBrEUsCTaeamXg7ihD/v8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DbJr3OSv07SjMAFaobElU83Hxp/3CCNnDpGfiW0rIPUkUgfTLh1qtlyAo7LjZldBYnEXmAjLUXh6RONgI2pyeUtGWQK9XtebIGZqJye11oGmAkBowRSJXPmNmMnFNwjkmQlHk2hdBxutJGi6gd/94212Iv+2Jn2nBx4Ii5Yo+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOn0h4zt; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093997dffdso1735832a34.2;
        Mon, 19 Aug 2024 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086131; x=1724690931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBLcUKDVkwPFiYRJqjb28cNXraCEW6YLxwgaARvC0lA=;
        b=jOn0h4ztQxonsIjIgJy6UGgwUty4ulrVZQyhOUrsxB5CvpuWSkll4w7wyzLpEYzTSJ
         dtUmjl6QOgYAGDbm/m22huHARytSg21q5j1K1Qvgddlvc/R4RTy/CRI9CX8QJIgS7bW5
         ccrDfSgUX18OZdsL3pnDxkELJOZHG8cLtgqB+wd6GW8Wh4nj7BT6+YidIA37MV7RY8cc
         6yFhvRcFwkxeVUROj7T039TlpO2SjrtvlkHnJhXtox/LJ/6+CQHE5VMYibWTBkcfwndI
         nFjU92VYJhgJVMHe+vR5TM0JEORY88+XVK65rq/j+9Xx/dyYahxvAxCjUgnh0HU+lbRP
         lVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086131; x=1724690931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBLcUKDVkwPFiYRJqjb28cNXraCEW6YLxwgaARvC0lA=;
        b=iWHt2xdURY1/TKmJITWeVZnpGOjelLTsl8tjJZJmsKxWL+OJiBxTGcHUGutLWPr+3K
         BB583NEFVCgEA6dsoDu2dYrw+GNXuHhVG/v5rSNt2Ow32vQMOi/6hMYfMLVNKx2mvGKx
         98bk619CtVtTxSaUe+wBULuFX3E80GImPulOuJDrEoHS/7lmm/uRQPt/QjogsFTB/7Ij
         vZUQ+DRLKIHoR8njGrgYn9jth7ikz5/GwBC8GcbSeVJqBEvZ947VUGwZ5eG6aQ+dVK/s
         NmkrmnmyPgOdfFGjak34wGZAnvG7aKya4yFXpzf31yyqGp3YUXxP/4NLJ64jkQyEleDO
         6ofg==
X-Forwarded-Encrypted: i=1; AJvYcCX8yokov0gNZ/0cGpGSTYJEXvxr1Iktb+w9KCk/DamzDVLV6xi90a1oVGGmJJf0lYlSXPbRljuZsbRbSKQK8JGzWzi93RH2lIUEZmyC92ROW7Qe5p9oxfH5kzaoSkZNFPK5akrP7w==
X-Gm-Message-State: AOJu0YyRhtkiOn0mICw3/K99JQC5mMJC1Ruf5rcI8xQjRJm1GGHOuwI5
	a1dvl/+ImqcFe992JyWkn8MX/CXUznwnPxcT2lNoQznkNxzDlnxI
X-Google-Smtp-Source: AGHT+IHClbSOtCizxu1DG+0TB0TXivck4+Ecm64YXTso2ATTPsQvJwx6/bvdNWCmxd6MYlrtFa74pQ==
X-Received: by 2002:a05:6830:6787:b0:709:35ae:e793 with SMTP id 46e09a7af769-70cac8c1e30mr13425508a34.33.1724086131001;
        Mon, 19 Aug 2024 09:48:51 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:50 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 10/15] dt-bindings: power: supply: axp20x: Add AXP717 compatible
Date: Mon, 19 Aug 2024 11:46:14 -0500
Message-Id: <20240819164619.556309-11-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add binding information for AXP717.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index f196bf70b248..5ccd375eb294 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -23,6 +23,7 @@ properties:
       - const: x-powers,axp202-battery-power-supply
       - const: x-powers,axp209-battery-power-supply
       - const: x-powers,axp221-battery-power-supply
+      - const: x-powers,axp717-battery-power-supply
       - items:
           - const: x-powers,axp803-battery-power-supply
           - const: x-powers,axp813-battery-power-supply
-- 
2.34.1


