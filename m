Return-Path: <linux-iio+bounces-17568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47980A79B4F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0F63B5E92
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36D19DF49;
	Thu,  3 Apr 2025 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8vEwVx5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC0156C72;
	Thu,  3 Apr 2025 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658459; cv=none; b=kMRciJcY5hzpDfk+y2ewPUKtkQ08J6+OIzP7xG9u6vm3MLCNnLm2MA45hqIuz+VVw1DN2eY3eggsrmyZ27Ia6wb422unEFIXpC1rBla/tAYjfOSLtU+N3bJCRB3HIIGLfmmKj64pfeOPkxtDTU2Xr4BRYkQ+QPQ/fS5304yOWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658459; c=relaxed/simple;
	bh=Zc950WA+vES0d5LaJupaHH0s6pTQfhPPaJY75H8ygug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okKrgN8GBFHwPej00Cf/RgQpbbWHi11L3Ct+lO7ceUjoNk9MWP/BczR8VltKe2/PU9lckH2W085I8UtrCt4pzSydYFXjaFk3cFpXp6imtY6HHtOP5NOzt9IQfehTZJQKMIKYezZ7yPCKbY7TtxEcdgTQl3zPkGxn/XenOWX9RVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8vEwVx5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-301302a328bso545816a91.2;
        Wed, 02 Apr 2025 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743658457; x=1744263257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBw6C0ziFRnbZ9N8eAluNk0SPMVQX2BRjnDnpLWinvM=;
        b=M8vEwVx5Ckulm518Fc56ta2+wJRmo3L+MmgAjYW5PsZX1cJJ7RtOty68wz0QhH62Rg
         /BVTCpilaPdFgP3VCbZdNyU0u/xZziDWVtS5P1X14pvBG8opDyBs7H5Uj6cVzIUPp1oR
         p8vGH4HI0NjXqqhWWVOffUqNPFmaGlXVthUTNM574yoFzeFXVV7e4GV/Tpl7/CsB7mBH
         jhyesZajpVRHwT5b1wyNxN9DZxGcyEnBotWo1VLK4Z6193uYInye9EJKmFsLin+eLG1/
         /xnt9i3ZmX7h3Rgd9P8yAUhEW7mFvv2EFr0X+3la4K3Ap5d4F85iSemAu/xM/xSSf2bO
         rYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743658457; x=1744263257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBw6C0ziFRnbZ9N8eAluNk0SPMVQX2BRjnDnpLWinvM=;
        b=kxLnyUdKpqmYZexoKVNcObW5JJ8DYCKmRdzJYwKklXZ9ofsFh7oiLPqJ7a7lTKQpok
         VpHBjdt+bMtLc/GGtfm9ezPuJcPLcRkYCVLJTtKtc3XV6QRsV2nLQ+4NGiBMSGSjOs5Y
         kFXHmxhbJVB8KTSFq5fluqeNjDGiql5rrEblqeycwMMDnVjD4M5cf3DGBwgDcntwa+xy
         MDqQUy/Ulk8uYXV3st7pow+G9MIRPy3W5Ch73/vLKjdp3M4u6lXGFO7BNHk945RiL/H9
         Q6FXnXSYFlBRZ8+MSu7RA5k2quNuJRAbMh/xL9+NSiMjkq8uoxQkvh/YhnriAYtAsWYx
         Kojg==
X-Forwarded-Encrypted: i=1; AJvYcCVsi+h+xc0cBK8FBvMP4oRhebygtBhacsyrMDA91oMKFoiWgqjV14Dw+EjK75kXq6cCbFihOTtS64s0@vger.kernel.org, AJvYcCWEXaDp4PjkQL522e+qinTKbaeQZy+AIM5fIwB1fobuEgZaT++WFC+b3UqEutRUFaLnxW7D5xy6Pg4T@vger.kernel.org
X-Gm-Message-State: AOJu0YxhksyTAKfnmRwweSxwPZIrM2GRr0XF3vBeA9G9V+qYHE3SMsvR
	JMn5zzsj3LB7nzsN4ja5P3FakOWIAI0EqRQDgU/NFc/mVkAiqXzmW8X6sD3j
X-Gm-Gg: ASbGncumU8Vzk3q/wOiQCAUgUhMhCmaXaxTS04jJmLMvvmFEI3YE10RlgPuw+mAL+Ny
	RgpTfoQW6h0HT7Q32ivpM/06SWcpH2SNWhTt3mfDGyEmeO3GgOYdGGLToZemHCPwifcBaTEPeIi
	zi8UZ+fcSD0vqHZpSuuWG0GM2gNpRQiYHgARjv+eP3R8T66s1IWMqr9JLRvTaBSwT6ZUfnUMT2R
	QzyJBlenGlTkYUBx8fgOSWGtF8yISPvfwWmU0S3OJIYz8hOhORpOiF1OW2FCOER2BwKL8AMmy3r
	dE3aEllyGt+w2WUWNV7EcVX/R0nCKLOhg6u20VPEQG0wH7BCfA==
X-Google-Smtp-Source: AGHT+IGAxxeQPKZeai7NtCSWi1XQXLt1ZcqEyfeMtWqZgeNCRrH1RoMVCWvvNVgwTiFWkcFJitT6IQ==
X-Received: by 2002:a17:90b:51c5:b0:2fc:3264:3657 with SMTP id 98e67ed59e1d1-30531e89d22mr32987624a91.0.1743658457275;
        Wed, 02 Apr 2025 22:34:17 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22978776601sm5537575ad.237.2025.04.02.22.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 22:34:17 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v1 1/5] dt-bindings: add winsen to the vendor prefixes
Date: Thu,  3 Apr 2025 14:32:21 +0900
Message-Id: <20250403053225.298308-2-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403053225.298308-1-gye976@gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add winsen to the vendor prefixes.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..ee7f6100c432 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1679,6 +1679,8 @@ patternProperties:
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


