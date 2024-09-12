Return-Path: <linux-iio+bounces-9476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8289775A1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 01:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3235BB2494F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758A71C3F34;
	Thu, 12 Sep 2024 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW33UzEb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72891C3F25;
	Thu, 12 Sep 2024 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183969; cv=none; b=npP118zPASWV4nc/4vejLw8IXdVw8U7a2UcqZyOzWMlBNlnqaj5P2+2dd+oIAK+uGsFLzj9IBtblDf2gqIwiOY6dKQ0RKbz5AojouIRGRsqaMHykRmt9X0DI1e1ZRQYjeslTMJFE1uWoKM/Nftpvot2u8NW09zuZuI3g/ygQ8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183969; c=relaxed/simple;
	bh=4Zib+Gb/hQHqWXzxIVj/h9hq5O/XYqF/fMs8xGJqk98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2sIv3Egkz4+yEBtK+Ecx03tC3+/Y2y9Y8yQ+5/f8q3BhPZrJzQtgvPHFHBwL5HyL7cSzYBqkPlhq0Upk5uvDRkXswLi2HQm5QGOk++9k9RHhzeduKwMNU1oRsZSBdKSJyhkA7jrPg6/8gwoeq8PtoC5ZIrn4qNyTq4SG0WCN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW33UzEb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso5096250a12.0;
        Thu, 12 Sep 2024 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726183966; x=1726788766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGvQpULdNzcr76UYmbt1A1/lsWBEjEt4/IrCfIC30I4=;
        b=PW33UzEbZ/O7pdIsC/4IoUmOHdffijMk2Jve4BPCJJ1Wew1gIqQw8BP7kcrJaiUVBX
         iXjVvyhza9XqSvGVlY4Rw6OaY5Arn115bL+sontWpEPQjPeRGhOMHuN5oHhwJGASwVR4
         oxTQ2WbOjLScEPm4mIXEUl8UcZE8cElAD3mk70YreGQzxA4apFyKKOp9ceqfkPJy4qDc
         VTZhKdIdiJfjcnmp87dlAEEfMNEj2wzpLap5r85UvgwVkjvE7tCNkhEQhnKmZcbuqUVh
         EMY8bA4bgYkHQ7xwH+mAhq4+2A9C1mRCsDouKttCgkWp3qv25jD6NlRMBxS37wFr0k58
         z9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183966; x=1726788766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGvQpULdNzcr76UYmbt1A1/lsWBEjEt4/IrCfIC30I4=;
        b=T7+yOMaG9OnZgAYaZLpWcz1wftllfAVxL5qzotFsIhCdalVLQzUW1y8xKZ+U3Q4QRd
         VpfXLS9MdKf70aObdJCf91Lx/+/sIUnOr+6jwAb4OhPRETO2SlbOrj1Wl8dT2jeUgeT/
         Nn+EpWiGOhBk40ai6OeT6QtzHRH9WX2nvIzUhlt/aoGxID5GdMywr3rC+XM0cKiqRc7z
         h5OlbARQBrMFgZll4wJg+1WrVY+0C2xjd9zgn53t+bl0lA8GV3QLxH8xlxK8VVgxwD0Z
         bkdHiqjcz285iIfC5rE4HhEjVQmw7ugoUKpyIoOXnNGXu7IAiZdlVRVHP3WrZMZL4mem
         /KsA==
X-Forwarded-Encrypted: i=1; AJvYcCVLqpU8YKLTds89JryU7ksRgbyfiPDpjSozSz+r1B+xMnqK+eQB01thgT2gF5KXVDiS9Cbtos1WiUNM@vger.kernel.org, AJvYcCWGczGel8/u9XLQFg7zkR0aKaZXc0Z2CPR1Q/9S0EkKjW2ZIs1zdwgHENQHI7RaHO+UgtBv0HU14Ro1@vger.kernel.org, AJvYcCXN8rbJYOhd3BuU1ONHORQQdgf+vdYWSJaynsntHWRp/TehKufyz724+REf+cYfegR+DPH8ly5IXA2ZQnB/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JuBsGEMl3gfhQ4ayjEtfr2OUVhCAq11y6L4fQXLWiYuC9Qga
	hUXC7MVhwK4sbGbeckPmmwIVV3gtBjvZ9bukMGPre6cmZRzhHYCL
X-Google-Smtp-Source: AGHT+IF6nXvYYYOzkAuMVYzcgoB8+Q3HROdZ/YX9fy2WHR4M5/r74XzGdPToKmN0WIe0HZdzudQVlA==
X-Received: by 2002:a05:6402:34c8:b0:5c4:8bf:d709 with SMTP id 4fb4d7f45d1cf-5c408bfd8e3mr10087355a12.13.1726183964965;
        Thu, 12 Sep 2024 16:32:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c421aab306sm26693a12.73.2024.09.12.16.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:32:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v6 2/4] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Fri, 13 Sep 2024 01:32:32 +0200
Message-Id: <20240912233234.45519-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912233234.45519-1-vassilisamir@gmail.com>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt options for BMP3xx and BMP5xx devices as well.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 6fda887ee9d4..7c9d85be9008 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -48,14 +48,34 @@ properties:
 
   interrupts:
     description:
-      interrupt mapping for IRQ (BMP085 only)
+      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
     maxItems: 1
 
+  drive-open-drain:
+    description:
+      set if the interrupt pin should be configured as open drain.
+      If not set, defaults to push-pull configuration.
+    type: boolean
+
 required:
   - compatible
   - vddd-supply
   - vdda-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - bosch,bmp085
+                - bosch,bmp380
+                - bosch,bmp580
+    then:
+      properties:
+        interrupts: false
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


