Return-Path: <linux-iio+bounces-13122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A59E5CB4
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE516B9CB
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201922B8A1;
	Thu,  5 Dec 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avzACSvN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988D229B08;
	Thu,  5 Dec 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418842; cv=none; b=WhGmPaqqIaNYL5azFDQqbZE5oTYDygQ550YVBbnAxOXtFgHpICt5OpCb6E/s82to313gQUhoSDJzlD9alh/vch8RhJHSvq6QojUVpZUOY+i4ZMhYmE74udZm3H/jMUgSc26zWPKBwp3vizIDSdTQpSKPPZeKss972S7agCP4eSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418842; c=relaxed/simple;
	bh=DsRIegOFuHGSg0vE7VksllcTePQRArPVTkkMqQna8f4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUUagjO4pGNAEhdpMIhw1OZGPl1M33hPJJLCvCNnkeOyxy10k44uYLJG9IjE2wi3HZpuJPTzklQdcA3YR682CjKHNqSHyE4hyUO8HwwcKsybrMp3HwS5pbg9fXxwbtHLDcaTw7HgEHhqGL3xQBZhooSsNmMxb4l9lAEqjcGCQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avzACSvN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0e4f60251so179380a12.2;
        Thu, 05 Dec 2024 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418839; x=1734023639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8lsmxVB2omsrMm6z/32rsJzuI9/t8xsIVZSIv9D1K0=;
        b=avzACSvNP42MrtHmWOTa8h9LOpFGWSGE/rfqDiw45AsDJkxfM6hDkfhRbvo5T1UIda
         J0mNXZLbir0QvftJ7qvGQQqccHra7+DMNqXpvzE/o6bbxtgwe233IEkIhie6SMvuHEXY
         TQtf0rVi350tS7lA/VtuTZiGSgybHkGUzV/JOEH0PKKWyq2u/YeutHlpdAviME7Ls8hf
         Wg1driRg8fj+nYmJ8idwXWUp3bBALGOi9LlRB0TcHygT45JhDJeg7x7nZkGPE9LdBrMz
         NPWFqycAn7u2fBCye6WOzePpBDBzyqctq5uX4F/kb1iqZuDH4HgFG1Po6pTjsD5vJ21m
         ff8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418839; x=1734023639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8lsmxVB2omsrMm6z/32rsJzuI9/t8xsIVZSIv9D1K0=;
        b=bl2RrUazxhgyd7y+TC387NrioAseY6X/i4L75v9s80QsXjSv/kMnHWyRuKFjz4frNl
         rM9XleLOTmYDKwvfUPbuQE0IywW8tKbFeWEb6yrobaQ3vxYRW3Wv+sqt2FJJmXhBvQnE
         P4v5tacUHidKayeEa0/IED7I7fEu5BGp/fZ/L3wOSLXOquKtYBnvuUyujYcw+akcIbv3
         YyR7CJInxmBGR2ca0WdSG7rDyddYnz/Qaxk5vPkZ6Cga0SiFHdfZHhxRSAcgbInY72VS
         Ghonxe2bIIGjxiriviJyLLBAGeIjl6AdmLQnecV0DZGrht6FRL8JiWh0kz3OeQ8/kj7T
         xtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFndIoy6v7Ma1FRPTsZp6Xxa29QgrLIi0RdnmOEgFBoCr1QOV03mhPe5pIsnr5Q60SohDEaPM031DqZRE6@vger.kernel.org, AJvYcCXbr+CAuNHLTmG9KWecqoESuCHEDy0FeuvsYHOMeAalrrnrtpehmUXeVISjU5qNqhEwQGWJO5fVWqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZrifyiax7CJDazwlfiYO/aJnhFlr2YNL5QuxheLpbZUb13XR
	Uito3F/D3VzyU0+6zLOGIBDldomwWGqzuM3SmMtUvezgTInTvmBD
X-Gm-Gg: ASbGnctNDwjN1ta6MF6eCEcME+tfhWujZ/Fx/m7TBP1e6UXrBHKDWggeWxxcvMJlUE0
	c8SM6YTZi1BKjHFyQpm7v2D9qNde5c/WZzk9O5Nk9fAgiFt3m9qWWnY1Pr9rW/ZrLPM/aQ7LAHQ
	vZjk9nY4z4I9Zg2IVQYhMifBwxD51J/Vb5j4XaODaxf6nuAUaI7CXuJfrDgniMzrxJ0BggSQdds
	8ncN1hLh/A1qK/iVKTfwA7k4I3rYdY7/bxhSG0pMau8x9BjR78R0XVN1BC1bXy7brKKjPRBWnDK
	j6MAqWqULObFJDcxb476Dwq59umwiY4D
X-Google-Smtp-Source: AGHT+IHjtbMgzH2r69k9e8KVIJIcxquU81vmNXpGebYBAFGvp3+JuN7wqUYI0bksK2pkRjWi3J5Uog==
X-Received: by 2002:a05:6402:849:b0:5d2:7262:9492 with SMTP id 4fb4d7f45d1cf-5d2726295dfmr819469a12.2.1733418839176;
        Thu, 05 Dec 2024 09:13:59 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:58 -0800 (PST)
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
Subject: [PATCH v5 06/10] dt-bindings: iio: accel: add interrupt-names
Date: Thu,  5 Dec 2024 17:13:39 +0000
Message-Id: <20241205171343.308963-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241205171343.308963-1-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt-names INT1 and INT2 for the two interrupt lines of the
sensor. Only one line will be connected for incoming events. The driver
needs to be configured accordingly. If no interrupt line is set up, the
sensor will still measure, but no events are possible.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 280ed479ef5..67e2c029a6c 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -37,6 +37,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    description: Use either INT1 or INT2 for events, or ignore events.
+    items:
+      - enum: [INT1, INT2]
+
 required:
   - compatible
   - reg
@@ -61,6 +66,7 @@ examples:
             reg = <0x2a>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
         };
     };
   - |
@@ -79,5 +85,6 @@ examples:
             spi-cpha;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT2";
         };
     };
-- 
2.39.2


