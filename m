Return-Path: <linux-iio+bounces-13695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B09F88B2
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 00:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5221889CA8
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7A1FCD00;
	Thu, 19 Dec 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk+fVooQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE71FBCBD;
	Thu, 19 Dec 2024 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734652080; cv=none; b=C97yMERRFQaeZzb5CH7beFXfCckYPzwDe5p0u1yJwG1V4ao1vy7O5X0hUh/pkkdHt7Fn8ByV80Pe+ES8rRky6Tna7YHXuejy9dR3JhDPy+xitDva7QY/hCpHpbrBRaEtg7JH5SeUgNDsOVdjC36ZfZWAKK76pLti7aDABHjdlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734652080; c=relaxed/simple;
	bh=x9qRdqGIhCaAuWRo+oOMzDL+2phsdCFzUR+//wE7H3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwFbtdvAXOeNc0HhgFXmBeuOAkycngq19JfruKtgCkfYUYQIJUOaniok/S1NMHUr9NBgxMuGh3erl3oXxxxyPq0kenIKB8ycXQym+GdVTBwdvWtHl+xTmB9KGDup5GsMTDo0yCY3azjY7RFLRQJbMXZF0ltu8G8u7ELWtdDGiRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk+fVooQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso233310166b.2;
        Thu, 19 Dec 2024 15:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734652077; x=1735256877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvF15Rz393YpMjvvv6M32rWW6iRblM6L4I6VGjr4yYY=;
        b=Mk+fVooQ6Bd1fq88xrZ9GZfU42DXZhCeoeSphr98X5j9/krEtDvedNLyeNmV8G/zUd
         fZaDGswJpZjl5iFOjK9CZBSAZv3TrwSK2oh0xkvxYtWVbAQhxI1MqUmNj066fvqFQC27
         HqVVs6rtzxFqGXb5+9KIIeCqM0pcJBpRX0TDsyvxPWluIOp4xyAJ8jPIekM3kScjCcfF
         jZTh8LRNVLgl+2z9KVzq7FSZvpNohmzJCaLFboaKvDt0MOurkM/Yp3VkfUnAdrseFQyH
         wux1R/L6ZLzjX8TaYA95aTM/uoS6ImvO17d+funf0kRimZ1tVxZUDMIs/1TQd0hFd4zZ
         nhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734652077; x=1735256877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvF15Rz393YpMjvvv6M32rWW6iRblM6L4I6VGjr4yYY=;
        b=pfA9k0HNHEBb8XC7miMIm+fnTpAc45SpybvLMmy3V3+utfNVS4mjzK/eliM5vUE6nR
         Y1XjOnr33HSbbgqnsY4s/cY4tTvNPsWYzZmnP5j/dSp8XVuBMZ60wyelzEppg9Jgz56j
         dfO0Co0ew1Yo2Oioi+C8BVzAfcCO4n1bVZc8295txao8U1ybZoFzEB9jsJrXDfJM1GPO
         WnAtWUCpf0XzUHSZMK80RpgSgmnS8BHAtQyamzqXNIsYU4pDSAS7IvzQEGfIxjnXNyNY
         4ZlawHpMm+d1op+gVcim9T9Rivwf5ooljgDh+fO1L5NPLcT8ARBm9h9T4zon0+aCF86m
         T4sw==
X-Forwarded-Encrypted: i=1; AJvYcCVnth/Lm9SKxK2DuTkOc3Y2AnzI9atrlJpVGvBSxli/AkjWAMW76AXJ6nPRTvGSVpb5q2EwCZlItc5r@vger.kernel.org, AJvYcCXg78tMRHRyPZO6hePyIjBq+hJWo9cCkKpYCtbxORTXjm4W/wGfoIdOPRLz0bLoO9k2IxN1tpwJl86F@vger.kernel.org, AJvYcCXzdYId/OKDrpfEhTavVAKnAk7Y4uDJDL+00amb7DN70ERGMIdfd+DmXoaVlIlewbA1teB1g/VI8L+7dJrJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kXqzAC90puZp9CqiSL+uM2oTDi9Jk9vxoyqfW2OLXj3rwghU
	uWwmqQ3apxDBhPnvH+i8vtTVE8j/leCS5Y7uqJ/3ffj6cCoesPTA
X-Gm-Gg: ASbGnctRrQIsvGnTkX2ExVzC1xJXJhYSsYAFg0ttcp+rYaSxOcH/Tbq/FYpOrXecqRz
	bHv4PvW5BHZXW9bSfLV8rhC/2YhkE2C1SzPBqMSatE35cYpM9ng38xi0eECrRU4Van60w7V5G9H
	25l63t97Nm9+nrte6eipKU/G53UCFWGxq2lN+wxjqqx+q+pa1HKD8MoPyfP3A7O4rFII3K5TTif
	57zmkkdd3/o26pjwXBcjAk3aW9XnpbzBnEqy0ctDgYYGh5brtc/rTaBoR0YQTa2uZNy
X-Google-Smtp-Source: AGHT+IFooLhlSWuE8YFuaRwlJkMtRF/jk9eCI4whcTgzDBQQjrXQStnjqOGQHhXHDZk/XzvnAfASSw==
X-Received: by 2002:a17:906:f59d:b0:aa6:9372:cac7 with SMTP id a640c23a62f3a-aac334c1628mr49804866b.31.1734652077110;
        Thu, 19 Dec 2024 15:47:57 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:6db1:ccfa:1b4:55ac])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f076d1dsm113244866b.204.2024.12.19.15.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 15:47:56 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lanzano.alex@gmail.com,
	jagathjog1996@gmail.com,
	vassilisamir@gmail.com,
	trabarni@gmail.com,
	danila@jiaxyga.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] dt-bindings: iio: imu: bmi323: add boolean type for drive-open-drain
Date: Fri, 20 Dec 2024 00:47:45 +0100
Message-ID: <20241219234745.58723-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219234745.58723-1-vassilisamir@gmail.com>
References: <20241219234745.58723-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing type description "boolean" for the drive-open-drain property.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
index 64ef26e19669..7bf8294a8f2e 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
@@ -38,6 +38,7 @@ properties:
         - INT2
 
   drive-open-drain:
+    type: boolean
     description:
       set if the specified interrupt pin should be configured as
       open drain. If not set, defaults to push-pull.
-- 
2.43.0


