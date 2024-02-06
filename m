Return-Path: <linux-iio+bounces-2242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530384B5D9
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 14:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B691C24772
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E4130E44;
	Tue,  6 Feb 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="gsatYP78"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951812FF94
	for <linux-iio@vger.kernel.org>; Tue,  6 Feb 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224460; cv=none; b=FdgLmS48OFWJrwEzX8R+2z4T63bQe8CGa8bqvBrj3U0zJ65lP8fUYU6S4shlaqifNaa/36uBp7vp1ZakuqPPomeIP6i6sh1We3DSMm0t8v7R0Jzpwhq+483HHVZwRpnJlObYAgcL9mPP5WeOasQq9MVavkJzO8bDW3TDm7QtNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224460; c=relaxed/simple;
	bh=t2VkaMkevBwQFepnvP2MubbWodHysWbjZTpvnHx6UNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqYR4qLtryig3jIQVQAzhbRsrsdutLOwDaZhIGHwao1rHmFt6y1GVu7G2nK1xseJ7XOVPQJc3k1sc6j908SLILXEvyKpO05HqVts2FqHqNmVeyzmEMjrhHak+mwv/tIOzaipPqGBXnGg6SiVYckoBLwmrI09m8Y8JHW8Plikdfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=gsatYP78; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7354ba334so48415485ad.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Feb 2024 05:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707224458; x=1707829258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o9COTEV2bYOzl/Iqcm/zhYhM78MeO/kZatJcokDs1E=;
        b=gsatYP78W7hkRnNhHL/9bXgjPwNGpyfA4jeZwxXgN913ORtCzZECJ6cYFQyT4V3rMw
         nvcNrPWIdJQ+quS+x19Y+/VGyibNCwCnMvmYGJOFecF9GE/bXKRvo4RXkE8mNZpy1A50
         AMrIWyjzipByqRf6MWIh81AQIZ39AGOHiHWk6aAy2PTLyuupKcJ4aBlR7OuUspXlIOZe
         sDrGieMqdnPOcVamleDoyPuPiJdvGWxEjeyrkYwCkBqKpiGAAxtqeo2lHa/7JJkI12tb
         Bh69e3JwHTkMKf7bBULRKoaZSHq4iivKejs1NJroSd1y9OTkOcN+jKnN2kgefYwQvM6O
         5AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224458; x=1707829258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o9COTEV2bYOzl/Iqcm/zhYhM78MeO/kZatJcokDs1E=;
        b=KXrpxZ2StCp/6KsXCmYF3MYuXaT53fJ9zCbIlLSG4HvBIhqy8PwwShXfcisdl+yJsv
         Ojm9UjOioXLQzivUsTI0K1Acs3lIzImaa1Y67MPvtGuE49owiGAZ5YM++3OghPejuOZz
         Rqa0SrKWVSyEVWBRX4c5I2+jQe0BMDNMdrG/8qjlfb2T7ECKBXdZp9dl+RAmSeWfDWpb
         u0MAkmso+YKUiflC3UHQXJncdK5FCF72JjEr4g4KmX/ZY2guJCa7o/YJlpvuFezEBWIv
         cXKKYXk+yOS/i8gW+vVgwI/VrJ+7LU2bCRcrRR6+XaXvA3RvOiWMN5ThCr15L7w+PMni
         ZN3A==
X-Gm-Message-State: AOJu0YzxBVsHgg6XfVexTkUBkHvM5jFzrMtmQLS0zwqoeblKq972zH3u
	v5L7ijOdo2WjkOCtrG+hWpUxZzTCB0sJup947uINV15ZBBx5WuZtTFmfgbWJIQo=
X-Google-Smtp-Source: AGHT+IFJKZ84DsUTFIW7z09SM/XolOxhBIXknyjXr5P0qKdSWiGKzHB3JJVRh5mjkS6C+ftBVXN/5Q==
X-Received: by 2002:a17:902:d550:b0:1d9:a148:49c with SMTP id z16-20020a170902d55000b001d9a148049cmr1962809plf.57.1707224457137;
        Tue, 06 Feb 2024 05:00:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1hX/IZBA8GnFd2p44/zmVh1meywAscFi3SUeBnf+a4ogukr+ONiJMftkTFIb0uX3bLZ1m4rqs26f3+E70hc36ZhZCjcFnuANaNMO6XbujIBTfu44iLkwShC0wJyxOO7oDpypB9jMCXCbv8KoZqyyPUxatUG7Ald6UX1Ou1VC5S1yomuGMi8UpPKDryaqHqyff8HX+NsoENV813T61muGE1rliJDLoEYCA4TVQ9NdghNISSTgDCJLGzZQKOvdrZtSZDfCfD/DCHbSfv2vZ17vIMn+8loqMqBub+kZx9ZAFu8JZiZZEXGZYqbGkH/rAerkZAyi8w9t759zReAwmFg8JruxJCinAjzXHiGumz+TubcYSphKdZBVY8J0dIAk3iAhH2wAM857PzokeVc6GTvMLff2++/auXhx0qUsoNpeA5y2p3iFejMEfG+bQFs/M6gWIVg3rfful8hulfklD3ENjaE0u25igWmU7n1XtJ/Q2nL1YubAnm4tiiuLc7YUXvBGqyJPagkXsxFFFkxyNUcEjJ/LGCQ==
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001d958f8ab2bsm1782167plg.107.2024.02.06.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:00:56 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] dt-bindings: iio: light: adps9300: Add property vdd-supply
Date: Tue,  6 Feb 2024 23:30:14 +1030
Message-Id: <20240206130017.7839-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vdd-supply property which is valid and useful for all the
devices in this schema.

this patch depends on patch:
"dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas"

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v5 -> v6:
 - Separate commit for individual change as per below review:
   Link: https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/
---
 .../devicetree/bindings/iio/light/avago,apds9300.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index c610780346e8..a328c8a1daef 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -25,6 +25,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
 additionalProperties: false
 
 required:
@@ -42,6 +44,7 @@ examples:
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
             interrupts = <29 8>;
+            vdd-supply = <&regulator_3v3>;
         };
     };
 ...
-- 
2.34.1


