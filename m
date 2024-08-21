Return-Path: <linux-iio+bounces-8673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDE895A752
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088F9281AB6
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86117D366;
	Wed, 21 Aug 2024 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQu1qjKv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7617B501;
	Wed, 21 Aug 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277459; cv=none; b=mdbW+ldRu8nJVVGwFnMgB8zTnEgXvhaRnxChJOl4KuCA+NijnuBmsI80rcQ7b/dDOmshmN4dmWPotIw2vjGGD5UUTzSNweJi+aRNpY3hvV8n2NDWwB02OK/xOGneiQ98crN8NU6asH5MMCtCAHBLJRqSlBixtY7CZZwOx+o9Yqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277459; c=relaxed/simple;
	bh=2N5vSF/orr/5lpFq7UMO/MLBrEUsCTaeamXg7ihD/v8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A8+7q1fWtAnwq5+pFIpsjk1f7OKrsZlDfG5zTxAFHvohlm5tJk6n5Yt6pGdzo+9zFiMZ+24zH8Iqip/evyuaoR7vHbwIV+Jw9dQO0kuUut0hgW6R9FnHNC2MoEYMV3BQPHHwplCMSfIzyqAwV8skr0gcjMNgPZY5Ya9589lSysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQu1qjKv; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db145c8010so85825b6e.3;
        Wed, 21 Aug 2024 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277457; x=1724882257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBLcUKDVkwPFiYRJqjb28cNXraCEW6YLxwgaARvC0lA=;
        b=CQu1qjKvqlNrdVsY1kG3YYc4ieYrRN5IprUzGoPw2SaH655HjyRYRqK1WP+3YEPNqI
         iAUViDM6VmhUCV0vHjXadPlAi61+DUhfFtegSWaFxlKLDzhR/xRV8MXjNJbgWWpqqnLw
         qgE698o3a3sBJlSmKLL+ivh6DZpf8lEFHGYQnzGreS1PVgIgrkNX2MV9wL+lwGNE8eor
         +69hE2N9ax4nYdhNGHKuKNY1t1Y++6iF90o0MLwzUDltTQZ7WTrRMJgD6wPEuU4QOmbC
         stR3yAt4x0QzxpvW6YN2cWgBxDmAo4neYoE0Uhj374DgIjWFbnGENqAQ0w7BAtnEZPMw
         KAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277457; x=1724882257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBLcUKDVkwPFiYRJqjb28cNXraCEW6YLxwgaARvC0lA=;
        b=jSeUyGfaQxtLSnlq2RwM9RwwRSEHOci/RkEZ9u8OOCTIjyf6iT2O9HSCFO1rNfuPjA
         50biDlfD+lmcjPDa2zZKQ+hSsXRpL9whqhNl1Gw1xoddtzmXCLWGOrWi+babdm5P9Hk8
         gkyOdveAdvMiMV/7mwfh6wRvYU20FBEenqads1pYAiqNADLbhEyNEaqQTGQfe6X86TFK
         7Tt1Vj43eMvc/oW9deFWIaOFP/bAD6VXbjrEuk+WrrRtsILZ9FUzzxWjd9hEhUTw26Sm
         bY6kwdDKxpShLhAu3981jRVrpx4WK43BRgbF2ET1MMnuoXhtm1177ZxuZmX17rbcgDZc
         AVag==
X-Forwarded-Encrypted: i=1; AJvYcCVkXufu6xxe8zkso2ucqjJp/0m78xMpZoGGmmeYH5CqnACsHlJWgND3aHps3R1xn0PZu9pA0bhYjSmO@vger.kernel.org, AJvYcCXo3rg2eepWYscB9fqvVrQybTlZnwT5NVUqIad11CcRCFqEPcdcRi9Ey3DBbRm4qnDpIRMbL40TjcRw@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3qh8zpsSp9xcL3iasN2/zrZYg7ahNL9BFbjwEyPCbAXtIUmH
	dlSNEjsnMrKzNCsZGo8SQkTqu8bWWymD3UuWDKjRDjBX/EhXCe8W
X-Google-Smtp-Source: AGHT+IFBH/Id49Is4rvox6d7qJv1gU0KdeZpKbRB9tXQkrhso5+9Wd6ArhEi7XMb6kv3+haBhqqwxQ==
X-Received: by 2002:a05:6808:654b:b0:3da:ab89:a808 with SMTP id 5614622812f47-3de19510ef5mr3509342b6e.20.1724277456885;
        Wed, 21 Aug 2024 14:57:36 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:36 -0700 (PDT)
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
Subject: [PATCH V4 10/15] dt-bindings: power: supply: axp20x: Add AXP717 compatible
Date: Wed, 21 Aug 2024 16:54:51 -0500
Message-Id: <20240821215456.962564-11-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
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


