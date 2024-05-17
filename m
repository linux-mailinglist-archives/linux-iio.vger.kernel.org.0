Return-Path: <linux-iio+bounces-5076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB28C81A0
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9CB1C21117
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0423A182CC;
	Fri, 17 May 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcPjBpW4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F117BA7;
	Fri, 17 May 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932078; cv=none; b=aM07Pd6a2K7YGxQT2Ais7GkiMNO+pJBQ0e7KmJhlcYPZzIawGvDSiJmcjazN6JDIechPr5QOuv+ZIH0dcKFlGP34tpdbTUpPDvcGY+PFjPc3FBtkmZWniUldgTgnHUA3pcklBDsprj34p712G7EsZ8VWxYrXyreB5u5ZpxpGrqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932078; c=relaxed/simple;
	bh=E7teghd9UgYTd7WncT4pUtmGcWRd/YhPu17OO7Q8C+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPeEyvUmwx/Jtw1j4suNmXtgx6rwl6y4IHfDwk9wC+JRodqy2DmIKJ4Qho5g+8h4nWrZPWJkrft78p3kwtd4SCSHXMlALR0B66eqvcvNMkLW0ZFKYr9YyikSJA/6G82krEoDAVdN5s4O2YF+M0DOQvkIoHlB1NZ0kD5ufl3OAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcPjBpW4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420104e5336so38159015e9.1;
        Fri, 17 May 2024 00:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932075; x=1716536875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsT1QpILzlRok433ryllu1wJL1Nt/2cgUGbV3HvLFM8=;
        b=EcPjBpW4d6DY+Qj3pmO4mStEPx+o9s00qFDMDDlYo8s1/K6FrWPWpGgAwkjsDwj0h3
         /YVIiK19kSNVMrt4jSGULKf6zyVxIlXMYpegTdC7+pOs7VWaa39leQYzaOqXWSxyOikN
         sbd3wTYZKo4r0omMxjKNlvYfD4Y+GZKOawXKRM1ACLFX5QsbM5bURrg65TklHhqlxXM4
         i9zjV0nEJ2wd4bgI9Er+i5ZCFserTU9+PDB7Wnh6Eg/Zys7p6I3DDh0VM4nmr6QhggBH
         rXV2dd3V+ys9PCVrp8/CdUjXwVExV1f2gJsihbOnh26GKTOX5qJbWdrlAa4oWs8ekFn6
         rgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932075; x=1716536875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsT1QpILzlRok433ryllu1wJL1Nt/2cgUGbV3HvLFM8=;
        b=AIJNT8iigUUwi3AvUI3pGern7OJ/AAmN/ExdJrrEosBUgpNH5Oe8kFIpGbj9Oh9tDG
         NdGFZHc+Zs53YzpgIEvhyDhuVgyMXj07ZwrEC6/jC9/o0WvLw8iio+S6XBc0HjaRH6MF
         cwWdxuzoKXUZgy/nRH7SkDHdCy3m1DF4YWa7+TzEBts8W8EsDqmZav/KWimuRsuIpAVF
         SCiKNqLWiGxKOHZw18ykcFfFtmYzSbLuCESKvFUebjYgDXaSHB59R/ulkFVTFvuxIFV0
         kI1nT8STDoKvjww582IU2mjN0j0zGIuPOLeZmSUV5jdgZ0hA/4bQeUWktShsxyGocgNq
         ANvA==
X-Forwarded-Encrypted: i=1; AJvYcCX67e5cTu9RwmQlg4nOBTypMRq9Olw8v2IGi4DxIOwOGKCcRAhNpOfb0eaT4LggsO14bHktSc+dEXK9XKPBW60JByaUz1plKe3pNJbr2sMejPQtJ+AI9J02k3uTf1hpOtHonfp9MQ==
X-Gm-Message-State: AOJu0YzE49wcTpZfZNfp/ymLUXG8yIJBH2nt5DAwZU7rqyZnLolA2Ix2
	5tpMp5yDRQ9R4nXeWmLMZyhihqA85ZbYnuRXL1ZifFX6T/KQxG0U521lUWoEZz0=
X-Google-Smtp-Source: AGHT+IH+ovgyCScD27ABBS5vAvImdiIwnRhcWoVZabYPlq37Pwvgv0zEDQ0rPBXVFTRpXrAh2RWVxQ==
X-Received: by 2002:a05:600c:4754:b0:41f:ae5a:c72f with SMTP id 5b1f17b1804b1-41fbc91f419mr234160625e9.1.1715932074945;
        Fri, 17 May 2024 00:47:54 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:47:54 -0700 (PDT)
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
Subject: [PATCH v3 1/9] dt-bindings: iio: imu: Add ADIS16501 compatibles
Date: Fri, 17 May 2024 10:47:42 +0300
Message-Id: <20240517074750.87376-2-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
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
no changes in v3
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


