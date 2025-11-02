Return-Path: <linux-iio+bounces-25811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B4C29848
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 23:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACA3F4E8C3A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F3246778;
	Sun,  2 Nov 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJWsYRZ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21624339D
	for <linux-iio@vger.kernel.org>; Sun,  2 Nov 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121819; cv=none; b=KJlHMKK603WHoaB3RUOBmYolbe42vMv/hmOq8pn5hroNG0eC1P/b5hkfGdh909lgfKm0F3pkUhEUdmMgWVj2kwdc6FC2HgXwhu3IZ/3UxTdUQ4r2QK22ztorFdcctRzFG2xIUqRQEwtZW9QXnXcS4Ms7GTngTCRfeNRLO/6+PnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121819; c=relaxed/simple;
	bh=PhZLtyuX6rsStPuOx2GzI5uvef40yRsEPWniw+A0HX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjqBNjRmNPJBJJbbJrssIi+A0Kl8o54bGRZQVJW2/Vt1v5ayNZzJZy1kD58zJWbR05cha7QEQMFx/tQHriPan1mleKclJPey3cxZbm8SmDPN+YEOZGJq6wr8aLJYm+72u9MpStjo35VHX6sESyBHK9ZcTxq9SOqj1vCTF1LwkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJWsYRZ8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so3022645a91.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Nov 2025 14:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762121817; x=1762726617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++a2qLFT2GMKZSkfaoicvFef3e/M9je5Z9y3CGUMY9M=;
        b=HJWsYRZ8wV+reWfkB/zKBhyOzaA5IIEitvFDrGUlG0CHlGVspNYpXKNSGEGKwQNgIz
         tGWHYtGOIRcpUDy2pbTXisvkvRUPPh8xpmqIBCcwGoJ8Djh/iUdSfaclohzxReOROa10
         Bnq4fwanDX0jNFhBktmXaVDNH0la5qJEe2CjpSY7mI7Bv0yjNdHsAWwkt9lfgT4XzuX2
         cXDv+gmtEKXcEWBH3bWMBzA6BovEPftS2+qcFScnNuthSEGR3BvaCSx5DzjQHc35YcV8
         tXVn1tJF0gcL69dqdszFgbSuBZrI6iVrjg6wboFNMc9AfZ1HKG25N+uI7ysXLWVPdejN
         Eumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762121817; x=1762726617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++a2qLFT2GMKZSkfaoicvFef3e/M9je5Z9y3CGUMY9M=;
        b=R9XTxbWnTv14uKbT1viVC+Ggu9eccf4CZ6TucNVizNphdnXl4r3ooaAIKa/00CL8oc
         UE5+kokLGoHLsvl4Fye25LfaMFkkDQJKkz+fcXhKvvaNf8k6N9bJQJ4Qgidz3ZIhy+Ut
         DBHeAvHpmU6HgCOTDPb2fOaanKnlsNaiGqiKfNIjP6kBVGPs7vZn3Yt5EJogEDFtQAxe
         qx+H2OEMGdWwlWvaHOuqGBghyZ4sKEjb9qezxZAnby7y5aQdceXlSmIgZJj82BL0HFnr
         lP71uHEFWQzscP2wMQUrtxQcHkQaHlMQ8jbPmxDs4+hIIr33qyUGubfRtdxt8O3/SlBa
         LF0w==
X-Forwarded-Encrypted: i=1; AJvYcCV3mMRbwkqwy50ygwrGW96Q4OcOa9G5TaBH2RWJdnam7jTjX/+jjGnseyo4wWV50mHE5wTJjU5SOP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05KYvMkYX3/qvImDL+nt5T7+gawECRzwE7Qgw5OFORGdJxWiI
	kILRVGVZsCrzQc5Ftgz/CQUhv3lIdw6taoIPI/O4861JOe8Gty4ZV7CT
X-Gm-Gg: ASbGncuZB3VrS8RTF+L/gA1JRjIbCBYq0AzvMJE99y0yrc+/B2RnIgarMncWVs1XfrT
	EiPEiOYwwElHQ2UquoHxNhtp616JfLjANPoMfRlrFnPyJfnndfC0f7NCconRJlrfte8hwwLFsd3
	ihX1+/0bQ5AaVTlz05CLRXI3XZ9RwDrHI+rZxJ1xaQAzu6zs7RpkOY0JLfc3rT45UCAI01PmZ1v
	y2velUoRuRzTIYeRzsnBnaJFBvBlJPTa+/1OgZs5Igl7ibjluWig7HVCVlAF8QdhnMV7hTTtxsc
	PPCv6QyK+r0RMgieeWIFB7ne19UY8xR2hSD6zBHSeqBqgbUknXD02oR830V8AxBr7+ouSfPROvJ
	Pfm1jWXiuGC7QNUar/LaaMFtJjp7xGDCUyAELtXee9nRjgX3GKjaY9xC4LJbWkzO+NX1ip5uZsM
	/3EnTmKJ4lpq49emvbyKKC3NQ=
X-Google-Smtp-Source: AGHT+IE/IJ7vHfMPuDFfKJz9U9NU8Ff7jxfU7dFthw7esoi33MHL4uL+OykKom/Ms2RJAZVJxbkMeQ==
X-Received: by 2002:a17:902:e84f:b0:295:507c:4b80 with SMTP id d9443c01a7336-295507c4c3cmr93301125ad.61.1762121816969;
        Sun, 02 Nov 2025 14:16:56 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:860f:2214:33ff:7c70:4d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295357a1851sm83362835ad.27.2025.11.02.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:16:56 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com,
	wbg@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: proximity: Remove Lidar-lite-v2 from trivial
Date: Sun,  2 Nov 2025 19:10:26 -0300
Message-ID: <20251102221643.9966-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
References: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lidar-lite-v2 IC is not a trivial device because it has a few more
pins like power-en, mode ctrl and supplies.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2eff6f274302..e344613aa265 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -357,8 +357,6 @@ properties:
           - onnn,adt7462
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
-            # Pulsedlight LIDAR range-finding sensor
-          - pulsedlight,lidar-lite-v2
             # Renesas HS3001 Temperature and Relative Humidity Sensors
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
-- 
2.48.1


