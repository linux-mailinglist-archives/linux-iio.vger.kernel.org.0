Return-Path: <linux-iio+bounces-8672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2695A751
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35172B21FFD
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB4E17CA16;
	Wed, 21 Aug 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gor8Ogxx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5917BB3A;
	Wed, 21 Aug 2024 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277457; cv=none; b=TmO8sV6Oi29hXmWYaXahuSPZR3J1lGuc5SKEpdYU7EmcoGustXt4OAojBdX8dZdwe14drmVYW20jV8TcJT46o59wqhwAKcCB/ysBZD81kBiX3LH6hz8iVK3+Sn63vl00f8YWPmb4+U4bNwqIDOtW14gbUkAwnNMgchwPfKOVxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277457; c=relaxed/simple;
	bh=HEzJDDA7iAbH6s2K1+1fGk+8dut+cJutnjgJj/HWYcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7OdKlV9ZPgGvIjzQQPBKr87QM6SMh/S+WqDEVmyaKfZWXOtSpFCMQ/nPcHkxK59Bh6VX1P9R/hCpzC0OcPHzZcch6CpWnP6VYg+dxtaknVq4HGqa51tHTFuvtwBxU8Fzdjjx6ooqeNY+/AJJP/Pz4g/XDlbpucp++VJXHcPbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gor8Ogxx; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3dc16d00ba6so92503b6e.0;
        Wed, 21 Aug 2024 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277455; x=1724882255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGT2rYhH6YuMr14pdSYvfteEm0BRhaU6zPY4wR7HVp4=;
        b=gor8Ogxx3Y8i1+3tYlZpwob0N8d2r6gYl0GlxWO0NMe5UJRbngiRo7JDBPnDIxhFx1
         xNmv6n95CYtYcd5chtWlFtzpepTpR0sV8SnIwz0eT7rYg38qqHdnOpkRMfi4pE4YBI5T
         RmlrZXpAByPeh+r1twjxDSEHPl+n/cy/1FXHuoP3MtY1n5ASnW6kMHJYAitkCuq2u/YN
         6jcQTcrRUly/KWwsUe5zTWXrSoEenQfWuGs2gUT45ZBm2E2I8mP6/MOwAXQdVYEaFHPt
         zVD4tNonumYzUWvgTZPTzKevhI738H+vgcCoClw4UFV0xmvMl2cQGrGAX0ceTeEDP6+Y
         54Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277455; x=1724882255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGT2rYhH6YuMr14pdSYvfteEm0BRhaU6zPY4wR7HVp4=;
        b=cWYutHCY0xtfxDmxGevl2gwjrSEFVzE4lEyjPlFuIhOiyjC4Bh64PIrV8AxvTl3r4p
         1cHo7timK89VjvndUKRcjVhg0UawG1hnttMDZ1p4a3Gc4zNSP7bTLt4x0BM/1QQSAlQH
         6ThRa5pQYDcs0JBUGzglFaEgbSMO9sxS8PeC9zmWgTwbNivQLujorxCTZ6PzJDpb7FUQ
         /nB6sClqlmsaGndw2p7Jb4ZnldH/EAs84j0SzCo7rY1umrX6gDbJIOrjZDWrQdLk4QmX
         HMN6xJgu1YAhr4I6yKm7U68ImmM9DyUI2ZgL91l2e0QauLHtD77Id9UXHqXhwoYthaqW
         A4cA==
X-Forwarded-Encrypted: i=1; AJvYcCU2PSEQIlMfsqcSgFGmBM5jtjQ66elkKOOpQmfcl4Ckt1WXrVTsE+sB2OVFga17cybB2dln8+htyBUd@vger.kernel.org, AJvYcCULXdw3TJBL0zYmjcjuDfUd9/JYvHpHa09PK2J6iywTkENVOsebZhb4zCoZc2dTZqaXnDiOzZoJ6wh3@vger.kernel.org
X-Gm-Message-State: AOJu0YwadjPFJ3RN2D5KNiIfoDKiLlzfFJzXahWzcAphwTOF7rTd3gbu
	nxCoCXFMtBmrU75v7Ey908uZRXj/5nvCJpqKRp+FIMFTz9J27q4M
X-Google-Smtp-Source: AGHT+IEmT0SJ8vvDWIKk0B/Tu72b9Who0S3hIvcO8+XPXOzOeiFwLu8KNdeN2Ow74HXfM0m1vgZkQQ==
X-Received: by 2002:a05:6808:1203:b0:3d9:27fc:158f with SMTP id 5614622812f47-3de1951eed3mr4146574b6e.29.1724277455261;
        Wed, 21 Aug 2024 14:57:35 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:34 -0700 (PDT)
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 08/15] dt-bindings: iio: adc: Add AXP717 compatible
Date: Wed, 21 Aug 2024 16:54:49 -0500
Message-Id: <20240821215456.962564-9-macroalpha82@gmail.com>
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

Add compatible binding for the axp717.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/iio/adc/x-powers,axp209-adc.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
index d40689f233f2..1caa896fce82 100644
--- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
@@ -37,6 +37,17 @@ description: |
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
+   6 | vmid_v
+   7 | bkup_batt_v
+
   AXP813
   ------
    0 | pmic_temp
@@ -52,6 +63,7 @@ properties:
     oneOf:
       - const: x-powers,axp209-adc
       - const: x-powers,axp221-adc
+      - const: x-powers,axp717-adc
       - const: x-powers,axp813-adc
 
       - items:
-- 
2.34.1


