Return-Path: <linux-iio+bounces-17334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F725A75986
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 12:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA3C188B8BA
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064361BD50C;
	Sun, 30 Mar 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RBBSKdwq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5D1B85F8;
	Sun, 30 Mar 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329985; cv=none; b=jGs7pTgXjPsIrsyePdu8M8aywSZ3in/7LcHKP8ynGRE3/X2J/SCqq3YQY9g8I9vv1vFzqJY43i8MiGeT7Hizza6lzayQL04V0txGCHYgxBTdWgmX1yLhe9ZbMXYtMM8zDFqjgjpwpRMnDAwXd1YREYQenRYOvAWp3wXgjSjHrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329985; c=relaxed/simple;
	bh=soifStI+WxONiG2bNGHD9Az/E2Gwh/v0QzBMy6IXjaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNcSv9dJN59StA8y44E8e8tihxaqx+Vbe7aDNXX1XM3g1QCRVBsD5AcQzB90TXlTvVm3XiDH7cXtUpmHGhKOZENuuBaI8E2shx0uD3GDtn1rfBwZZ5XS2kpsI1OcX7gcM+N54szJ4Hh0xeW7k5r+301RJNgk5bPvTE3HICeuQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RBBSKdwq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3b12e8518so681589966b.0;
        Sun, 30 Mar 2025 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743329981; x=1743934781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLkKZXokD8bZjd5ogLbKwW1Zw/6XdqzYpLIZPmwH8bk=;
        b=RBBSKdwqkW7/2wmOUA6hJSC5tkUnipE/gqOcziyZWF1BPYzWfwhxLI643g61FEUBTU
         rWys2syiyRvsujXv6r/cP5wn2AlAeeOsN72OmvYhA5zB65DrGzSd7TLmRnNoLFhIPfwB
         JPNvjVKr/0QPX0rk1NM3FZ69v58TVolaYJnZnoC5gISwB6vjja0KCUMoVmyd8Y90RC82
         jzyO/HB/KAzHQCBIc24yjuqgaw7r7t7eYn+Bn5ofbRatvk375uOIZvhYdfLh7cE/91iC
         lVHl/HVorD2GOSi1BWDn2vrHf2j+my3REk/YC20uJUlnTUbATEwaQBn0UQeTMnPNWfUm
         auIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329981; x=1743934781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLkKZXokD8bZjd5ogLbKwW1Zw/6XdqzYpLIZPmwH8bk=;
        b=vyWOqLAGyOqcXVD6QX0r/YuTib57sYimoQerMCNBSGgg43ap0TV0K6NLDfxJ+nxI+q
         vfSB2lAHr+0BV2XqSERHW0KBx/+DOAtMhcjBQiM57/cXlyeI+ZcaMtXaxq1ra0LU7y+t
         gLpAlenj45A6Pb81eMY9GMHOG//BTyrBX3n4S/TaEXyxZeJChxJ4okz7+ZFOm0SHHilF
         gYqcTk9F4l7ILKNBMApz029QPNic8A0jbgXxCu1X5GNMFSyCBtIDIzhzSr3Fpq+d+t4d
         f/7BIEi3MfeoW6cfjS6VCOnWL6Q4KD5wf9v0oZeyewfyDldfLofvuyCsVfqorn+HicAw
         ZCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPq9oEXEWWmAYUZ1IQEMInHBGOW6ElNDdz/y6pFSg8RpXDQkgaKUcsbDecAFKe4pqXarXgHSWhjjwYDfUC@vger.kernel.org, AJvYcCW5cwxDvgOIKvfAibUq2lfHbtJo3QbxB7jnESRzMVrl8nIW2LHoR0pMBkx3G95dEKH+8YCY8twh6Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HoJfk5cYqBy+LhU4cnwuaHCOfNLuTm21SCrrma9wRBy4fpLy
	PWWsFsHuaTLr1AmWtSfxbKJdLji2Fd1Wy8oy1PcfQ7vt36pFe/yo
X-Gm-Gg: ASbGnctZq2RRTF+gKLHdI8LJx2cUI0m24jms09/N6ZzYrnOZdwxRCVGwcCCz3W/CpWE
	jVOeTP1OXQAFkahyrc4vdlnSkrOGCcfHpYn5TCOLVxq7aFEjl+pYSldyQx208F2RI2Ujig8L6uY
	Es20wOav3zdaS5erUmfvwRS6nTPP8rzoHm3VptWqctd1CF4jD8Aqg3qAnbuHSbflka1pQvqJDMk
	wpOnP95mn+VWDFBYbdxt97d+1NMl1sIEuJssDH+8z6dv4+WqJokBJeQWfbyOegc4xXNT0usDxE0
	SS/jry/RSt6konLw90YdewQVY3gUcXM/52D4kUwXeYKSAV+pjONJJxtYgig9r8gWJvebWDguSxR
	Whahsyx17Ory7BpndFsgDEdJ8UkOO/MhaPFJ2hfDbS4PTFvvqZYAm1sEK7/WuppNklz7PbfO70m
	3+2I6O
X-Google-Smtp-Source: AGHT+IG1NOPASTZyke3wRafrQqzhy6Ty6ySHJJEPPfVYz7wlAQdJfI+jHXfQl/zLq9/QGC1snlwecw==
X-Received: by 2002:a17:907:3d9f:b0:ac3:bb5a:8758 with SMTP id a640c23a62f3a-ac7389e79acmr409616266b.16.1743329981073;
        Sun, 30 Mar 2025 03:19:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad73-6800-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:ad73:6800::e63])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac71922bb65sm459288866b.34.2025.03.30.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:19:39 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	christianshewitt@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: amlogic,meson-saradc: Add GXLX SoC compatible
Date: Sun, 30 Mar 2025 12:19:21 +0200
Message-ID: <20250330101922.1942169-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330101922.1942169-1-martin.blumenstingl@googlemail.com>
References: <20250330101922.1942169-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the GXLX SoC. It's very similar to GXL but
has three additional bits in MESON_SAR_ADC_REG12 for the three MPLL
clocks.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
index b0962a4583ac..bb9825e7346d 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
@@ -23,6 +23,7 @@ properties:
               - amlogic,meson8m2-saradc
               - amlogic,meson-gxbb-saradc
               - amlogic,meson-gxl-saradc
+              - amlogic,meson-gxlx-saradc
               - amlogic,meson-gxm-saradc
               - amlogic,meson-axg-saradc
               - amlogic,meson-g12a-saradc
-- 
2.49.0


