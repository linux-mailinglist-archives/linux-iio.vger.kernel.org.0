Return-Path: <linux-iio+bounces-18511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56515A971B4
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C82188DCE9
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943832900B8;
	Tue, 22 Apr 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNcQNhfK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2728FFE4;
	Tue, 22 Apr 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337209; cv=none; b=enUVaYlLQWvm7Z/JG6nWelRDqf9H5xI2ZmwIw/ZRhi38hBDvIX/yPLbkUjjyXqR1iU2Rz7skc5KMJOKk98sDw1kj6K83ljhN7EVSzO9M/j0KtOeQiw6ThH8dW4r7KTEYPf8cx5Dy+qVuVrsa+wMFrpp/gKPUQJGcnwTSRrRvMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337209; c=relaxed/simple;
	bh=7K5WdTr0Su7eehKUV+hGjfBgc29I7BKerhOxeBxIL0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Na5zqXRDztEP1ae8rZtiLo7fe7JPuvou+4m/fV4jtFAVVyjMzMlqrO8BcZpQhsapKxRrOqYRXl/2OBqZR1/TqeKjwcuCvmMVpBef6qXdMveu39aIALUx31A2UH0Su1aziQ4PFS/RsOemD4nKm5bNddQVA38uJJtrw7gPHkIKNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNcQNhfK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22438c356c8so56488435ad.1;
        Tue, 22 Apr 2025 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745337207; x=1745942007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj8kpmYrdiK9mCxsMqgrjwEIay8Sc6Z78TIqN3FAEJ0=;
        b=PNcQNhfKuw6F4ppWNgvX2+EpE6gr2+MLgB5GzWw/Vohlsp2cVPS1OZsc5Lnt/fNyZ1
         JoLy8j0pQyK39snkDm7AWz43a5l8L/H9potuL4JwXgPWLarVu56jynfnPSAWBDx6YHuG
         3ZYAp98FZ4nOQs1rm9YJKdDiMGfsFsTMd818PlinZ2tCwKpHm+gK9P+hy0f4lKA1lI5r
         k5u8gwtxj9Y/9gAjw7Gazxjvzk3kmT07B7+nvghVgsDoQzPLRcAT6XqYEqpvF0Goqipf
         7Mvz4fdje2jVobWQLhR1A34iaSlUajIVuxsfIoeUPGR/ETKAkSvJW6KJwNm5iud6yMfa
         a8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337207; x=1745942007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj8kpmYrdiK9mCxsMqgrjwEIay8Sc6Z78TIqN3FAEJ0=;
        b=YjdlRul2PIyejW2YQqdX0NhwuG/ENdDms3r1rqM2hKaOhzWsHbNn19rbpQHnWZ8wWP
         T2cbP/HE1qwGcc68AxgxIpkZdW2tx9PtNPDQnLlbMwooGK63MuTBTLfjI32U57NsDWlx
         1GYPlzVzc/Rn4mzn8njoIdz5h4wOfUCSwRFngdArCoSI34ZcCjlNt1NdOAytZJcaSA1N
         M1VsLbicdbzEccwtxSWX//+U7iRZrmP++cBVhiHDdFqNLh2CsAE7FD7pA+0PdhRqS39P
         YcdnZwZMkJZtSnOWG6+NDKLeTSmqpYRSFGCmqBedP0EZY7/qMoc9axiMepHl7U9EmIWx
         iaaA==
X-Forwarded-Encrypted: i=1; AJvYcCVBGCGhdV4WxTNFDY4SGBUn78Nk8EVvrpj+38u2tbitPdhcAqezjEAlJOfGcA9GX93o8lwH7/9Yx+lh@vger.kernel.org, AJvYcCVhM/q7SoXbEcx1hHHPuTK7gGww8MjYW0J3jTM/LDenHD+0V7bJhmyitj7OAbJZehNoHvxAhxTAr56U@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvAnVqR9yo6T/wIOg4eBf6/DbrP/B2GlmVTlTrop3yw5yNjtU
	IEf+UHrIev5iqxjeeVklwVgGOLOvswQG+9uBNu+KIUMqItbBuF/3
X-Gm-Gg: ASbGnctZ0KRzF40wFmVdSYXbBTnBnfrsYdD3ssISpQ1vg/kCK8agtcGO0Z5dxj9LXi7
	qgqnyeLFE+dRBu4uOQL4ab6WtFzzPXEh2uGCVtNXPWa3lKem2Oep11v5iFqt1F9Qa+6Ekt8I1Fc
	MkFARfDmoqyyGZc8JfMCXskPC6+yP8WQqAgvW1KjETUnFhvq6Kk1OVvFSfECHb8YiNcFujChunG
	t/FEDrFeB6vHAB3grJYcYgcSnsE2UDAjhPg32mIuxUd5joqCmeKHsbsxg+/5z5BobtWw4EG9cVM
	lKr9aQXBgYumRZZOBzG/QDsnMYvIDw9JH8dq7e7OoPW9OYU=
X-Google-Smtp-Source: AGHT+IHmksWCwryals6+EhO8e1MlhITsJs7SvCTOY2hnhQmAna8pjxPWy6icosNpdbbr23vnJYCNkA==
X-Received: by 2002:a17:902:da88:b0:227:ac2a:1dd6 with SMTP id d9443c01a7336-22c535bfd40mr262598935ad.24.1745337207091;
        Tue, 22 Apr 2025 08:53:27 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c50bdda46sm87078705ad.3.2025.04.22.08.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:53:26 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: add winsen to the vendor prefixes
Date: Wed, 23 Apr 2025 00:52:59 +0900
Message-Id: <20250422155302.669960-2-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422155302.669960-1-gye976@gmail.com>
References: <20250422155302.669960-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add winsen to the vendor prefixes.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 86f6a19b28ae..6d35549d2e4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1689,6 +1689,8 @@ patternProperties:
     description: Wingtech Technology Co., Ltd.
   "^winlink,.*":
     description: WinLink Co., Ltd
+  "^winsen,.*":
+    description: Winsen Corp.
   "^winstar,.*":
     description: Winstar Display Corp.
   "^wirelesstag,.*":
-- 
2.34.1


