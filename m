Return-Path: <linux-iio+bounces-5251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E540F8CE2BD
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428CFB2178C
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8264C129E86;
	Fri, 24 May 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1d0uDSA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFC374C3;
	Fri, 24 May 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541243; cv=none; b=lcQxWQLcxOvWE7Gwy3YRJPPG2Vkql6uNM0z6jqKyg7kuXcSSZm2pa2BIVYCZHLAOO6DZ2ELdxrWElUdI+brcHTmGYYtPNKILGtnNFunlUxREPiqORf40fcz5x7XuAZUEjwPjBENfSB0gtozqMhhd6F6BWHY4sx9QNYM7yvOYvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541243; c=relaxed/simple;
	bh=DH55fcmaNOq2kI1xU5HHJskJnixgzrClyDjfoipSr1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMtZl+KuG35CTZjGbEdljGJu9dzQUjvbiNKjb4mR08UlBOks8IrACGykDDWDnAQQayDpmdAzQWym2oEjIkOzGxytqwCrrb/zwuQ1khhlu65X/r8uHvq/ZIDG8PCOcvfGCreEQwRiANQZyNbfeGZZfl2Vu1vC/hfA6dbUjtRdLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1d0uDSA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295eb47b48so663438e87.1;
        Fri, 24 May 2024 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541240; x=1717146040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aElDc9sqOEi1cIJMCBy7Is1fxlHci7wvvU1HUBh0ZjY=;
        b=g1d0uDSAZTP3g7oIrsBp8w3hWcdso2oD0RyA14hGhuhHAUAaTPA19Kdq13d9yVMNQw
         ZNV2fw727ra947EtB8JYTa8moca6YYCaeA/S/CeQ3I4Jv2ZfGTD/gCrrHrjjEqZqQw6L
         O3yowGeS+YDiYLAi17VV53bHsj5G4SeGOGom7EURDSTqtfxRd8Tftxp8FJ4aDHplX7Ci
         w//YQqm4xjwUvdANJT5ywtMXwXbl9R5vrfaxMF37d9eSw4OIhdkqOk2FKOFlsRnKJs8g
         t2FNvVqXOyRdzZQD8++FBShO6HW2UEFkuoeidE9K25e8RhLpSLF8hdc5uzqMVkPyK66o
         TOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541240; x=1717146040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aElDc9sqOEi1cIJMCBy7Is1fxlHci7wvvU1HUBh0ZjY=;
        b=F0rrtK5GClO9fuEk89oHNq21lvDsJDOK+/TTX0wvG0dD1BHL4eUhdyBUJXZsQ0V9bN
         Ar0j2P1TNCQAHJVE5om+1hgkL2wP2DvcavzP0JQWop/lATY89/WkqqJq0qkWx55P1u4I
         3CH6psqt2CYDEPg6c3FzX8rXnJxAEBk7A56Zfuv+NCxygbJoHLASnelDkcO74hd3bafQ
         D5sRtcYpzrWfasbDNCwZ82Fr+0nLNGsOxGjaDc5qLAqBSYJ6rBTHzd79RuPZy1BySOLR
         XRMoQGxhVEc/plmnpRp++PKdwP4FxQEQYPbIqnXlGXBSYLflNmnXlUC7sPazDmYLbOwI
         l1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYagnaCBZk21PgCOpIVc34q35nZtybcAWIlMkzfsTr5qK+n4qZ4kfBiUyaUHkNGDNS2dBu38kkOAKEg7HgaUhrsvEMtVk/U9uk/sSMM8zxxh9FNI6h296RfcOibdwInfGU4OxYhg==
X-Gm-Message-State: AOJu0YxqB+ota4bk616rOPhyodowQOR59gGwHU8oT+Y5iWf5wzgZFqBF
	cNyyMU78eVMHnq3hCB6Z9h1YhgbTtdsJzZQjIYMRFFyKJTNyUM3TCxqv+M4Tbjo=
X-Google-Smtp-Source: AGHT+IHRPMELz1aX4XzqGVTqjQaq/HR0MMJMElbmk8MeCMPClM/mnKGSg+uud5IIo56KwJVypFbbsQ==
X-Received: by 2002:ac2:550d:0:b0:51d:aae8:646 with SMTP id 2adb3069b0e04-529645e2493mr788377e87.11.1716541239407;
        Fri, 24 May 2024 02:00:39 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:38 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 01/10] dt-bindings: iio: imu: Add ADIS16501 compatibles
Date: Fri, 24 May 2024 12:00:22 +0300
Message-Id: <20240524090030.336427-2-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADIS16501 compatible. Similarly to other ADIS1650X devices,
ADIS16501 supports sync-mode values [0,2].
There are two differences between ADIS16501 and ADIS16477-2:
- ADIS16501 does not support pulse sync mode
- the delta velocity scale value is different

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v4
 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index 9b7ad609f7db..db52e7063116 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -30,6 +30,7 @@ properties:
       - adi,adis16467-2
       - adi,adis16467-3
       - adi,adis16500
+      - adi,adis16501
       - adi,adis16505-1
       - adi,adis16505-2
       - adi,adis16505-3
@@ -90,6 +91,7 @@ allOf:
           contains:
             enum:
               - adi,adis16500
+              - adi,adis16501
               - adi,adis16505-1
               - adi,adis16505-2
               - adi,adis16505-3
--
2.34.1


