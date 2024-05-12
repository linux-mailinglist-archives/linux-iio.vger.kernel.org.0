Return-Path: <linux-iio+bounces-4993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6E8C386E
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF75D280F35
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59056459;
	Sun, 12 May 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pok3IKH+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684156473;
	Sun, 12 May 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547904; cv=none; b=R6QvnJFmNlyfH/zamNo70Tdy0vwcqNlBOM5oeBpuGaNj40mBR8VFIlKPTxlmIlcV8V2JlWkcHCdE6QzosU8ASNFLBw4VrPld4yIGps4R1B6lrD6HqogVU4uMzwkKd/5wtE4gy2dh+xDDLdGrxoa+Uok3EmexPxeyIsBAyFAkVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547904; c=relaxed/simple;
	bh=eNCbQdkbZRQTv4it/CHzS69PqM1iDiTyRI9hWIn6rbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPtk4eFqsdzkNtcj7DxM3Kq85jDq7d9m4q1IfZtyHkEDJg5jVPSelZMrrBrzyphjmPZVL9Lg6MVfyscvqraOMMQZH7/HLWXriGgfbRIcJapLga8OGevbm9CXEVfEkTET1l23w7xn+i9QlyD8O1l7iib1H3hBOWbfVoFffl4bwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pok3IKH+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36d93568a58so2412945ab.3;
        Sun, 12 May 2024 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715547902; x=1716152702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2LHEU7ALcPZaT6+Eu+rgS8qTDRtkBCD1M+k0pO0CB8=;
        b=Pok3IKH+22XzwDd4cZ1RDMfrd0bKKiguQzME8gyVq8BGKJ5CMt8m504ApCNLc3UICf
         CcK4rwYXp4cMImLHs5c6EHgnupxPiH6YjManf4GkTNBysiwSNbMiw5dm0lK45rQxe9nU
         A5B5vNHKmN4Wn7127/nc0VHU5+n2OvUJAQFNM5+QFSQ1oD/kOuu/6zdpU9jGZA0R2oD2
         bA2T/fHDpnUGk7lgnDfkwJ2h1cNXFWqm0iySCDpXdh7Gi0T+FzjgJ4atFjLAN+nSjT2c
         78DFDPkAY65NL7dBjDZatphrftKz6IrPYXKWUAGNdpotU+C3es+dUcDf81Z/vGeNFT8K
         00CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715547902; x=1716152702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2LHEU7ALcPZaT6+Eu+rgS8qTDRtkBCD1M+k0pO0CB8=;
        b=TYYZVgqo1OZRont5B0TA1ta9AYWaJ2WaLxtn9DDXFeHPxOGw+SBSfEzvWdBT75w9Qs
         HwmTZSMYmvYSMVrHiXDYSUFwAA2/Z2dSslV5UFKcckYZ+UgJSS1PGuo9uSwt6nwauen7
         ayEkfRv/nT2pQ5WOdrAwkTfffqtuhnpTXXgHBgWgh78+2yuhQrErjDwi52W2SKJVqQd1
         npYFt2Z0SLD5cUecgpp3hJPT6zkxl+QHqEY+QLXikgyBi9vY3KqG9IDpV5DyzwflNwI9
         12o1nVksYlmGoT3MIJ8v1KzV6I/Iy/fVqKoVUZyL0Z2+/Cq2c3IwIm5M6/CAsfYAdD/N
         kGig==
X-Forwarded-Encrypted: i=1; AJvYcCWr3nWjJ2OnXV3JqVAVXuScdDdOhZvX7trirk89V/8mkE1EjsHqPvaXEMNCCfEcH7AhBHHDtugAoGrYlRKvq8ejeP/Ob5hJeZ7aY+ZmMnZ2gCXowzbdutdDIeF9dOjREEwjZe5eWo/tq+mjKmWsqoScRUAjTGh8fsJNY9c6CLZ9AbajcA==
X-Gm-Message-State: AOJu0YxajPzRwT8E2w+NjFoKP42N7fy1GSugL8NYmBZ+nBovRk3Ga0Zq
	o8nwtWVpbNya6mhd4LUQoa4mbuFfZGLY2MfFqrE2IknKgKsBugpf
X-Google-Smtp-Source: AGHT+IF5Jhz+iJTAsyqGz81tbiUho3n60SmNEJCjGaGenjnx8nj2ZC025FJaY+ek/SLcqbIqqRKHNg==
X-Received: by 2002:a05:6e02:1c8e:b0:36b:39b2:31f1 with SMTP id e9e14a558f8ab-36cc1503065mr86631445ab.31.1715547901767;
        Sun, 12 May 2024 14:05:01 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a447391sm6534865a12.3.2024.05.12.14.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 14:05:01 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: Add ENS160 as trivial device
Date: Sun, 12 May 2024 18:04:38 -0300
Message-ID: <20240512210444.30824-3-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512210444.30824-1-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ScioSense ENS160 is a multi-gas sensor.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e07be7bf8..cdd7f0b46 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -318,6 +318,8 @@ properties:
           - samsung,24ad0xd1
             # Samsung Exynos SoC SATA PHY I2C device
           - samsung,exynos-sataphy-i2c
+            # ScioSense ENS160 multi-gas sensor
+          - sciosense,ens160
             # Semtech sx1301 baseband processor
           - semtech,sx1301
             # Sensirion multi-pixel gas sensor with I2C interface
-- 
2.45.0


