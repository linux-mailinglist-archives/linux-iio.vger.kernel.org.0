Return-Path: <linux-iio+bounces-4927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0068C2696
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A45A1C21ACE
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ECC16EBFA;
	Fri, 10 May 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="omrWThs4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339012C47F
	for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350760; cv=none; b=HgWUHJblK1QN41YB9MaQdqOIMRFHJTUjtKgYtQnRBt7c4echZSnG4vSe8xp0M9ZYgQhW9ouDo5+SLkXtB6xYEq4Thas3rwNkqzwmFCKfa+ZNG1LK6fU6PPLzu5o5IVB7iTI3iiG1l8Y4y6cL/FARGCKfHWbqJF7OYoxOalOu7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350760; c=relaxed/simple;
	bh=xxx4t59lacJdCYKqV1TwqAC4SVodzhIeAGYW6khLtXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upp10eqhDk5aoexgtCaGuSkTPBUNuA1gYEkk7jUdK8FtQJHwvmV3CjS5GuXToLwVDP2xfqq5hUtNxEZkYLurpeiFO/H9se1h82GOlz0NuZOl/XRTPhvf3BY6SPh84r0BdJzKHUo59Ao709vDmuDO4DzhePfLx52aZuum/14egTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=omrWThs4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so20834171fa.1
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715350754; x=1715955554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Vlnws5FiAdjm8Du8XlBvr/Ou/c9kQRn48QLmV0BFs=;
        b=omrWThs4Nv+j/ZDfWNiUKVjk9RZL2eE494DUT6Pj2My0lTtFxCzxmuLdZNTlGjdUJ8
         LVchddRJ/OrsdmsSu7esGYAWu3T9YGgxZ9FoYkt8b5865ReoQQrK8rz2lg+OXBSite/4
         A6g9Ui3X61sPnSzzTa9jlP0oPU/F59p9iMQl74z8aIZUbb9j8imdRolMC5Q4eagfsxO0
         182U5SFXkYr0vftFrkq5bY4SuwKMjjqE66IQRaB/UHtwGBYbU2n7Pmh6GjEtM16h8vaG
         BXY2KCfpb34EXjEFPZnBhasXY3nBKJSfmeezhkS8seYrPxQ6KQTXmsVm8xzoWCjK7vJX
         6ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350754; x=1715955554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2Vlnws5FiAdjm8Du8XlBvr/Ou/c9kQRn48QLmV0BFs=;
        b=aEgnpk7yswpzS1VehbHu4YaBdx3FvwqG125ZVCk3oFnhBMDSPXSEQgPG0XCtnBrsgZ
         Z7YMJPd76JD6ad7sBB7wyy8y5/yj3Y6rFv2Z2mE6feNpD+yRLfyU1oyoY+eesM8fH7Q1
         Z+vGqb5a2t1rihEpMliz2CjIg5BGWG9muH39JmBWkNopYBxKMlufGS1HcXrMtnB+9MlG
         4NrgHNSCiDfS1+G11JdiJnOD+tQhjEzSPUf9FZ1d6lVz9GV1ID+PRyFrNbEhsohZRE3T
         GG0ghExB5h5lh7lp8q+kSFI6F9tMfC3QHFecYn16IzivaG3z/toyFnq0aNjpBzvRVB/L
         9dGA==
X-Forwarded-Encrypted: i=1; AJvYcCVdl8NHzDHCLAyZrHnnxfQZXEPa/ngb7yW1/fCLakGq6t9kijZYy4jShevnz9JmJRfwhgGyyxvcj1UcdlIkKkHe2LRWZAUMoKol
X-Gm-Message-State: AOJu0Yx1OVfNUB/+kOvlZX/T1GKesN2S5XL1+6NiLbh1P6gfv6rLaSLD
	aQ3uismPdxmRNlzUHKtdSmC8b/7JCAR6Z+Rcr7BtKvjUfFp/mFtA0GNpU6c/gDQ=
X-Google-Smtp-Source: AGHT+IGpJWrJsfoOoQk4zUMuiUHP+YlLGjm6rvptjOJOKUVTGe3fh/K/iMDcN0xqxLz1thXwhYEQOg==
X-Received: by 2002:a2e:b0d9:0:b0:2d6:c43e:f0b3 with SMTP id 38308e7fff4ca-2e5203a50a2mr16994981fa.50.1715350754136;
        Fri, 10 May 2024 07:19:14 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-39-74.retail.telecomitalia.it. [79.47.39.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd97e842csm56111875e9.24.2024.05.10.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:19:13 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: iio: dac: add ad35xxr single output variants
Date: Fri, 10 May 2024 16:18:34 +0200
Message-ID: <20240510141836.1624009-1-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for ad3541r and ad3551r single output variants.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml       | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 8265d709094d..17442cdfbe27 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -19,7 +19,9 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad3541r
       - adi,ad3542r
+      - adi,ad3551r
       - adi,ad3552r
 
   reg:
@@ -128,7 +130,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ad3542r
+            enum:
+              - adi,ad3541r
+              - adi,ad3542r
     then:
       patternProperties:
         "^channel@([0-1])$":
@@ -158,7 +162,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ad3552r
+            enum:
+              - adi,ad3551r
+              - adi,ad3552r
     then:
       patternProperties:
         "^channel@([0-1])$":
-- 
2.45.0.rc1


