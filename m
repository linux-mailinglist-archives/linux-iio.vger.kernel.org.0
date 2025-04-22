Return-Path: <linux-iio+bounces-18514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C27A971BC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131A83B85FB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 15:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD328FFF0;
	Tue, 22 Apr 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt7QWzD5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1327BF7F;
	Tue, 22 Apr 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337218; cv=none; b=JK+LAumLh2bEUy4UgvnQzWP43Jf8AHmHPSC/KLYo2fm6jFlE+6Q4oUzKewZqydp8QsYKWJ2CiZNEiGfZ7Kh7bUg7snGfmAefwl7fGCmZ5jHgen23Gm1QVGdI6DQqdosHHLqxPtSUcl0qzCw3TbkPe8Fw8IrS6wj0k4+XXxAKlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337218; c=relaxed/simple;
	bh=/E0EO+RMPCLWe0n9DvGXcNqxis0WymELc05enWsVUNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A17JWnG7lUL48xRQ/8x9aUlLZjIUo68gR99TcEyWILjyVuKKZtI2RbzoOM8FxWnBgHpEWXGj2VtW4ZDHdW5GNgw7V4IU9UGCoDFENcNlAWaCpJTR1Tf4pgiv8D8Ln2s5KXpXuNQaVVKLPsJSB+FkwASaHxaTZkMgbAmjnQ31mXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt7QWzD5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227a8cdd241so60383035ad.3;
        Tue, 22 Apr 2025 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745337215; x=1745942015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTIK98tab5rOndKkCc1l9dIPtMDYdx9Q4AKn3Dm0cyY=;
        b=Tt7QWzD5pMdnEIXGvwjReTaGIp/oxVCYTeUOap5vE4wD5ylFJxMjFbbTmxPWGateDc
         GSsrp8jMT1mO1Uti/MlIck6PUMbiaCC1SxykW+1zhKBvZMdTS/qfF4qtpw+5IlAiBHdP
         L2hvKZWJBHo4SDnsluM0Cqkotsac2zsE8/QXaCj1gICW6kcRXMsQaFKkI2qk1c2OZ/iD
         1KFQRV9/KHOeFg0ZbsH2sn33yWnlM+8EF/2OgXB9vwlqhMtxh0KRaLFwji0yzlgg7Az0
         ECMZDYgOX7H8SydgLO3ocSiep20XG5jOYWr1SIKlj8kJXW5cwW9mutOSQYNd8IYFbBU9
         Jv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337215; x=1745942015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTIK98tab5rOndKkCc1l9dIPtMDYdx9Q4AKn3Dm0cyY=;
        b=teTsszW2CXvbKHlUu8hkAHK7OAbtaucJAq+fXSYEk7oo/YKRTcdC7vGOhpAA9soiF3
         Grzd3l1WYyd5xBk90AKtclD9CFP/fK8pDTRjKM70omgRbqQk6bCe0vKili261L8QpKn7
         STKS6SABnePf3uWNL7nYOitpZl5DCBg4YkiOVgII5rEMGsg+Tk+6SUyxLALbkjyFbuVC
         Z5Fq+gMXEaI+/9VT4x46UAQUjuttc33rUblzvFiPyc9L+QlEhE/2MzN5h2XG4md0moCR
         KAel84655TdolXaYgTvnW2+JqNvJN4a0VonScxEWP6pT9lz0Klf6j4brGmb9QVuHDO3T
         /XqA==
X-Forwarded-Encrypted: i=1; AJvYcCWAGYTu6i4YNovos0/rg4XYYfZy66EBjElMZa1Fb5zZzTZD5Zxkz0l7ue0JwPfI64CRafn/hGpz5XrG@vger.kernel.org, AJvYcCXCT9XvcmdCKZFThrC/TW+rZNuwHWxSkVOkbfOVGgHSjOq4BHG67OL00N4+mZ3fUPgYtTfKE0LrZJzk@vger.kernel.org
X-Gm-Message-State: AOJu0YxmjFFVMnxq9m4r29upn7cVV0hBRLemRELkWrQfGkZ7a6/ppRCw
	t6WyLpEATZaEDA4cxNfyNkGx/6vN5fvxeGCrR1n8WDLCCuKORmHH
X-Gm-Gg: ASbGnctXuYCUnoGMihjRVMmcwj45kuzwoCKGtUteLpU/J0u+kHqMDHEjbM1wUhmYjmB
	aT/kbPi5f0ri7jA7e0AdkJWdXlYXPmXZ6FITYy+YTjYz6/fSkVxa1GFXA+/4r3uT4ezLQrgsgWn
	fZYKwPjfqbXh2BmLvYIOb+8pVoILReOzw8Qw9Av9XsVuVef9drOgbNvsby8/61FCRAJwM1Sh6u3
	N+Y/MCAtvuEmUgDoOgWJBtsaDlINENBjPusC/8tdLdvtHAKZqVgMp+CkK5oHME2XmZFLLiDhWkJ
	09WGXYoAagConJHiL8oZaQNbp1ojUSOfq5UN3e+g8YeF9/E=
X-Google-Smtp-Source: AGHT+IFKMCemr4LeC/jglsJ72yGCSaFJfMAinE1oR1e+fXSBwosonUsSwP7Fic+HT+AmkV/bTUXvqw==
X-Received: by 2002:a17:902:d4cd:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-22c5364235fmr203026975ad.45.1745337215555;
        Tue, 22 Apr 2025 08:53:35 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c50bdda46sm87078705ad.3.2025.04.22.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:53:35 -0700 (PDT)
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
	conor+dt@kernel.org
Subject: [PATCH v5 4/4] MAINTAINERS: Add WINSEN MHZ19B
Date: Wed, 23 Apr 2025 00:53:02 +0900
Message-Id: <20250422155302.669960-5-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422155302.669960-1-gye976@gmail.com>
References: <20250422155302.669960-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add undersigned as a maintainer for the WINSEN MHZ19B.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01079a189c93..4a0089db6670 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26015,6 +26015,12 @@ M:	David Härdeman <david@hardeman.nu>
 S:	Maintained
 F:	drivers/media/rc/winbond-cir.c
 
+WINSEN MHZ19B
+M:	Gyeyoung Baek <gye976@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
+F:	drivers/iio/chemical/mhz19b.c
+
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
 L:	linux-watchdog@vger.kernel.org
 S:	Orphan
-- 
2.34.1


