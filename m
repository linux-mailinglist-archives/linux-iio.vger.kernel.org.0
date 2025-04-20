Return-Path: <linux-iio+bounces-18385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED4A948CA
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FA9171547
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D30220D4F9;
	Sun, 20 Apr 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne8denad"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC801E98FE;
	Sun, 20 Apr 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172648; cv=none; b=R9IjuZNH4z0lHP/5dyABfTf6n3XaUOn9y1mAeVxlJC7u2QZ2CbltUIlCsQURsdroiwylI6pLLUoSWrujO9FpS9E3QwGcepssmRVO/ZipjPOdOxOkxOfpIGh3HS3p36/C19czDpY7SCaynL3apqkBbdVWhFbTHDk2z3CLZxPoMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172648; c=relaxed/simple;
	bh=/E0EO+RMPCLWe0n9DvGXcNqxis0WymELc05enWsVUNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPMNiyrGB/400XP+zaK9TqnUqKt/Dy01yde8aBWjMxZ9SSjPv8642Cf03kAxMDNSTh7yCzD2Fmj5/6qSuYrEPn6uUcecmfglVEy8dv1pUB/d5fo+5GHLR+VK/Tk8xNjEeZxnl1YSm5VYfCnkt555HRFqCzM/a+N2zHcC7dXmris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne8denad; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso2920989b3a.2;
        Sun, 20 Apr 2025 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172646; x=1745777446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTIK98tab5rOndKkCc1l9dIPtMDYdx9Q4AKn3Dm0cyY=;
        b=Ne8denadB762TeyQt5E5cD7SZebyG9NfiJR3FSbyqjUjErVJlPLtTLRgQhXj8NUbxm
         3xBEAK/HtY9UaMo9pM5sKv6LNYv/DUIIzvIJmu3WFLZQjZqseu3GWLANuSr26AJLNzxS
         1gU2DmP8EAVV0HysuUG3mkO5HKxmZbY0wX4/jOp6a6fqdRd/f23B80xS1xCFxD5fnNWH
         iXbnjAAPkwKSMoGcuHQJ+vNLbkfJF3/a+6K0X1sa4Fn5RKV1iirc/gy6d5s0c09aQeyJ
         lVeTgzPFpA6/f4E4wA8JrnClymJfkFVdHaVlFxAbU72xo6wOdBDb+qlg6OR5j/X9VSnJ
         /8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172646; x=1745777446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTIK98tab5rOndKkCc1l9dIPtMDYdx9Q4AKn3Dm0cyY=;
        b=WFnwHTLRI6Lf8j0VFkXeNmYwQ25+o5LXdfSjgNVygxgqAEUQOfEex5SBVqyYrZ0NeZ
         PXquOOglZu165UVV5KdbBFA1Xuh3RR1+KRcjJ7Kl0lM/Z3dYiXukE3onVj2JnWG5OIkr
         fu7PxJOtlH/XfBQWFB45GPRSitSLZpMS/N/NCH6OJbT86jAJygi9o6xzrlSI1C8ESr0f
         Jysqma+zuxdhQcdbD/t+rIxFoI+/c7mCY+KaDAJRwtyjssjdxtjgR2VHiqA5i8gegeMM
         5Fb3oGnPcm/iE7RhBh6AqB3zZNVlHSMpHwZBooEQJHAVgl1jUlt2fyBYEhtMeOVlZ26W
         c6MA==
X-Forwarded-Encrypted: i=1; AJvYcCVuUxUnjuJ5+I2tiscxWqbmE6TTDmlEJUfkYkje/qepVM3OYYJi97DNPRWLuU1OjNeAygiRZaNbu4my@vger.kernel.org, AJvYcCWIT6gby0jLVH3jRCibD0UQ4YX/XkpHxdoivKd+vP5v+KzqX+n2m2HZI3chKDtGwS4A41AO7mZUbuR7@vger.kernel.org
X-Gm-Message-State: AOJu0YzUy7DYQdYVznv/x7pz1mx4LLfNBYAgpf9e1u58Tt8z9Rnu3qyh
	AZqGEKKAHlLE7cTm6c+d46Ff5Wybk1wtsB3sOZklg/rZvtrDCMnv
X-Gm-Gg: ASbGnct8Nm8vCLauvMKtOkG/vHgvNwOvpXLd94at9TOZ/BP9SXrQFM0Rk155rFOtQru
	VbZLDuwPGlzS4xuMbhT63Mf5z/1HD1Ig1ZxJeZ6wddAjDHFS98jQfDsXSAX4pGAl5HurmCmtLEW
	UO6bvgl5uR4w4xNzXxT3SDT4At2kKYYOLN1TTWdgZqrpfvoDZ2aoPZuORt/cHjRqyWfxMXa+FLR
	2TN6hl/coNGUhd3gx2VKDXMjZQuw2+DEd/Jt8DtvEdXpWMfZjWdvEow89kg50YhrbZCF69+KdYx
	k/sik6jxekkZz3ZC+y6ouqdjZOno5b0y+KfvfRbaabfAF34=
X-Google-Smtp-Source: AGHT+IEYqB4eMMP8CBLHl/wmGfa6rxsQTach7+xCAcAoQWMxGfKFxrHwHC8yy8bV6ZYa2mEGbfnkNQ==
X-Received: by 2002:a05:6a00:4285:b0:737:9b:582a with SMTP id d2e1a72fcca58-73dc15d8d78mr13422614b3a.24.1745172645739;
        Sun, 20 Apr 2025 11:10:45 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf8c05b0sm5009347b3a.35.2025.04.20.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:10:45 -0700 (PDT)
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
Subject: [PATCH v4 4/4] MAINTAINERS: Add WINSEN MHZ19B
Date: Mon, 21 Apr 2025 03:10:15 +0900
Message-Id: <20250420181015.492671-5-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420181015.492671-1-gye976@gmail.com>
References: <20250420181015.492671-1-gye976@gmail.com>
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


