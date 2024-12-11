Return-Path: <linux-iio+bounces-13375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E39EDAF1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 00:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A741887F7C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6211F4E24;
	Wed, 11 Dec 2024 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK82DZmo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5F1F37D2;
	Wed, 11 Dec 2024 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958427; cv=none; b=QnJLVCc3EcsOhnJyL2cUBohYEhBPzZXyxc0qwH8wc94oBdSfTq43/XPdGoOBIkAxxT4cdT5RMQIo4zeSn8BMbzSuo0n59jdlsXbdbpm9kau+gMtGVjdNE8arcKpW44M9iJSSM0XLhJnxc9ooN3Ox9jPS40OMyZxECof+ODS6XR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958427; c=relaxed/simple;
	bh=cDAHLzux6aHRWWnsY3+0U/aloJ8h3SyTDyFzxnTYKJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4KNixbpgregGZBLrB68z+MyxlSKB86n1Va0mm+iemt+/4fK4HfhajXuVAG4G4sQx8FZnILMrgYcKxeDVQAGkK8GZ8iELy0Nih+L9H5teEEFsrvyVAoKxuCxl5H5+d3LdxNGXgtCltvgXPpdcBKPgWuwnxCrdmVZJTqH+rBqR6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK82DZmo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6965ad2a5so54131466b.3;
        Wed, 11 Dec 2024 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958424; x=1734563224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRX2NGc6xiJDIFTWsff7g/BwiHLtEz3Oya0LbXKu14E=;
        b=bK82DZmoszPT8viLTe8XK7RskK96Ct5DIfRXE8TB52fXeI7X4hHZIZv90w4IuN+J6o
         BS07CbtCUUi66s4R4YBskt8n7NHi0LgT7Ak2rc2ICr6Gjf7gYveAAzBWIcVqqbTkMtyh
         f40WgUXt8EgA01XhLtcsmMIs8aEQ9wkMUk3/eYqK5de3LjJya30ZbOcRmHZuVulkJ6IY
         BTGYqOnE524MRBG0OUDKY2x8lzGgZz3grO4pmmNzfLqJjHRfrK1Jom9x6kcd7p8xM5AH
         TCG0Ynle5wmUSbCNwKrrn9LQ2vTJ5CvKwYviyqBBM21b/PnG9ty9IcLTGGR8B9+oLZ/c
         niMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958424; x=1734563224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRX2NGc6xiJDIFTWsff7g/BwiHLtEz3Oya0LbXKu14E=;
        b=qCsZ9tojpWDpLhVVxcHILQnPXcWal4jGAPsj7cbK2k0G7WRZn/CPF7985vC36hUkQO
         2ymxZCg+P9SwL+xFuqux/G6MnJBTA95ivWySzRYPQAvU/8LPjhu9S6Ec/AEAscBTOJsJ
         tmF1p68rz2cxaH/20H4OnY7tQNKqNfzbgiIqWTsoeeNhrbsK/dC9S4S4nv1Ni7vShxTU
         vFpj2QmOxaxtsfqD0US9i8pLdU5D3EYFOioB838I+s1uFD3Xr1sLG1Cc/oakBjKJDLS7
         YT+twdzAh57ti/S5En4APz2Ei1UTl6vdVnPUQ4jee1eFF6LPuEhUk5ffnrcc71PWgaoF
         tm5g==
X-Forwarded-Encrypted: i=1; AJvYcCUeb3hgBW+8vmiAVu1Mb4YlWWDBi8oJgTh6gIt2aVy54XY6DQZZgRNA5ZHAZ4pJ3dwyjNmri7Lp/kU=@vger.kernel.org, AJvYcCWJvzTQazu2GBqKgRp++tHbQu2htttPbiLMpIWNbg8SrJEB3HKlJ+kMe8PCIVFNFv2/n54vbiEbehDMK0l2@vger.kernel.org
X-Gm-Message-State: AOJu0YymglDUM3thmPrTJhHENt+8cF+1HFidDQII1bwlL8BwYV4EoPvW
	B8Q9QDue8udgSnDWq67R+WN1uVj+Gw/TQ2KmaYalZBnCt7pA/xfM
X-Gm-Gg: ASbGncurz+ZOY2xLyBU/jWk49agIgEH4txaziQ9rlBh8XLNn3/v/yRU6BWj5QRgUMd3
	xJknDv3Rie9/8Amx1hb4iIFhSawWn5rzvUQqfIltEm579qAV1KLHKNg81ce+IzUZ0iO+Utttlvy
	U5hXMAfj3LbYHS+yJH9Fcfhtjt4aPP1aXuQgF/G2mtIEoeekdackaHRMeL9119dh/V4jV70ylHV
	g1QJlFfoQALAe3wxUtZ8Jzv9SjfPlDJI1UGCwtChuvnnKNgShirbumOAsvhdE012Pt7KHw84bsj
	iwiB48lwWT/Z939Xs8YBfiQ5yxqUUZmw
X-Google-Smtp-Source: AGHT+IFCajiOnKG0joD/Pc72pLzJNIcC7CVEAUzytwko3T9q+T0Yj3qsLLg5w1Fd1b59uL/0bJtFcA==
X-Received: by 2002:a17:907:94c7:b0:aa5:a36c:88f0 with SMTP id a640c23a62f3a-aa6b13b9a75mr165068166b.12.1733958424307;
        Wed, 11 Dec 2024 15:07:04 -0800 (PST)
Received: from 34fd2088d136.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa655653d96sm747350366b.185.2024.12.11.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:07:03 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 4/7] dt-bindings: iio: accel: adxl345: make interrupts not a required property
Date: Wed, 11 Dec 2024 23:06:45 +0000
Message-Id: <20241211230648.205806-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211230648.205806-1-l.rubusch@gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove interrupts from the list of required properties. The ADXL345
provides two interrupt lines. Anyway, the interrupts are an option, to
be used for additional event features. The driver can measure without
interrupts. Hence, interrupts should never have been required for the
ADXL345. Thus having interrupts required can be considered to be a
mistake.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 0fe878473..30ba4d3fb 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -44,7 +44,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
-- 
2.39.5


