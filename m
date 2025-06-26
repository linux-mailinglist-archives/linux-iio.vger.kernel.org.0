Return-Path: <linux-iio+bounces-20983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D6AEA8D8
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 23:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FD57B52B3
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8725F967;
	Thu, 26 Jun 2025 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blMbvF+F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A717202990;
	Thu, 26 Jun 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973272; cv=none; b=JbqHbhQFp29DHS5tR1o36N7kLUV4WUfkldNCz8N7YLn3o6GA+CoJLBf7g18vBwCC9Xw0SKvTcEpllz9pYSiJUPZAHBWL+SOn+eb2sojsiffVXQDm0GEl4ybNqwYfjzRFNURnAO/yO4GvnBDLZkNCJp6PHE9hsawHFqvth1untC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973272; c=relaxed/simple;
	bh=ykeXd6ls3tnEV82l6ImWU/KsrXMtWOeQGKe8+LIKueQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uU/+zP+7tARCY9RQ58f0YG86S/zt1SSOcJmjX3qrhOzSqmauWP4xkHbJwEt5VYDXHPaudYirowYhpEHq1RuQYTcgS82XoaS9sN/rafuzPOuAu04VX2BhznwCBkfW8OTQXlDpTsM/2R+6Sh47Nk2+1mxuk7MqtCc0nHyN5IAWjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blMbvF+F; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2353a2bc210so15498275ad.2;
        Thu, 26 Jun 2025 14:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973271; x=1751578071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0s7KK7JU2bDuLIyFJ/GkGSEJsjX5YQL6lW6EbLOBJQ=;
        b=blMbvF+F6MLk5gd0jHFoSWq0eiijKVXonYQ1Y/e2HFtGxJRYw+X0hOlCxKKyDhkOiP
         WogOQUXUpk8OrpeN+X8cr3T7jgT/l3Ypd00CRDobrTvLGCaZZHMJCaj5ZObWGXDOWspI
         euqW6UGyox3gCqfZS4ROEFX8Fb3GmlkrxhG0pXLIPsgSktfe+DVDf43d9zke7piYgz3G
         1qkOTnMW13K0Q4lkwSjmN0apx2lc6CJLsGMvWXSvz2Q7scG5p7iFYbCSVeAz3jqDfGbb
         1R6poLdqo13+aFH6yqoubKyn/qB8n2xjM3ylhihDgoVn56NjvdU5ahFeoBTJvYOJmzQ9
         lY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973271; x=1751578071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0s7KK7JU2bDuLIyFJ/GkGSEJsjX5YQL6lW6EbLOBJQ=;
        b=aKYaV/OZd3Sb+73QpsewAzs6KcffYyuVCE6zr7DCuj8ujHv0iJglPpUWQEUCD0XN8F
         qUq6HU65xC86AV12kVW13426F2cVmSd+NhqDkDN69Qobmgj/eNStkmMrpKuganCbKCSg
         eUxwudoCQ3qxccAmCutQ34xFzjUN3rGugLwk4JwXuLWcrPt3mcPvAzd6HbNCRZxtfmKk
         H2elzrIbexUFGucWTmpOEe90AEwb4eCDd4zskr8NvAlR9osu5+Z7Nibum5BjwE/xc7tZ
         TfFeulW1kn4+lrM/4N5g7/Ey6ax5v1Yu9BV5pKWzRB6JrlTEdOU14rePFwB8GrlGtI5I
         oACA==
X-Forwarded-Encrypted: i=1; AJvYcCURFva6kSDIEDwCi3vNc/Z32SMcGpapjpLaM5gumvVCTcqSe/bYZO46rg6m3SBYWZ4vEGrMWrKMqUI=@vger.kernel.org, AJvYcCWIVZ+gYrepOKLQKpV3lv8GhCaIhkM3n+oSA9iwUHOKsjgd03l+AZmh36M8judIHrqzYGxdESH6sTJgY45U@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLcRDkYpfy9jJu5dMtg88Q3HENAMuLJHVJTNtr+8p25c49rpv
	mC7vScZqI5P8C8F7dUJ3UPQc26XMX3ZC0S4b9lEb13tWH1VfDVm9o58E
X-Gm-Gg: ASbGncs5SYg8dElxuTlvl20zL2IIXOgOMvhZVYFNzPaDS4nA3hs3w9MbPcwtXPgTdbk
	qDeWw9FO46lqtfi3EQucdZnDfhTaNjt8jcVfCMa5jDsAsstZ7GLPgJQrTSNU6B3u2kigK2ztf/c
	+X4fl6fpvwV7XhrMaawVfH/eghJokxbHtpFgs50wEfwMGRGBlPNWenGU3aDIMuO66sIHwgdddiK
	qqvWeNu+cDh1JFIMZ54+zddgj3yBKk3A8fBrQM0b5FSSX7+fwYt/8/PLLzzOA680A3B7Kf1BRtX
	GlZi6rjovS2nZPufJHyT6INqlyr1qbrZnvXjA61yfVkVjexL8myxUbG1DbN9bz6g4+VLXcOt1sK
	swkqrSv74
X-Google-Smtp-Source: AGHT+IFt22B8S/w/uHxF+/JhLbCBWrfUJv5NGtM9va65TQ9tCmxr7/6SqJzztotgo2sb+buNtWsiTw==
X-Received: by 2002:a17:903:60e:b0:234:c2e7:a103 with SMTP id d9443c01a7336-23ac4605976mr6973195ad.33.1750973270670;
        Thu, 26 Jun 2025 14:27:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4ff:1626:32b1:712a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b2esm153615ad.211.2025.06.26.14.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:27:50 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jmaneyrol@invensense.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: pressure: invensense,icp101xx: add binding
Date: Thu, 26 Jun 2025 18:12:25 -0300
Message-ID: <20250626212742.7986-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no txt file for it, add yaml for invensense,icp101xx family
which is already used in the driver.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Very simple yaml for a i2c device with psu. The pin out for the rest of
the family (the other PNs) doesn`t change anything here, since the diff
were RESV pins (unused).

This yaml file falls in the same `category` as others that I`ve submitted, the
driver author, which might be still interested at this hardware, is no long contributing
(at least for what I`ve looked). Also, it`s email is still "at invensense", not "at tdk", either
way I`ll ping him here due the mention at the "maintainers" field:

Dear @Jean-Baptiste Maneyrol, I`ve noticed that since the driver was added,
there was no binding doc for it and this is what this patch is addressing.
In this case, a maintainer ref is required inside the .yaml file and I would
like to ask if I can add you in this case.
I would appreciate your comment or suggestion over this topic.

Tks all and regards.
---
 .../iio/pressure/invensense,icp101xx.yaml     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx.yaml b/Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx.yaml
new file mode 100644
index 000000000000..439f8aaafbd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/invensense,icp101xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICP-101xx Barometric Pressure Sensors
+
+maintainers:
+  - Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
+
+description: |
+  Support for ICP-101xx family: ICP-10100, ICP-10101, ICP-10110, ICP-10111.
+  Those devices uses a simple I2C communication bus, measuring the pressure
+  in a ultra-low noise at the lowest power.
+  Datasheet: https://product.tdk.com/system/files/dam/doc/product/sensor/pressure/capacitive-pressure/data_sheet/ds-000186-icp-101xx.pdf
+
+properties:
+  compatible:
+    const: invensense,icp10100
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure@63 {
+            compatible = "invensense,icp10100";
+            reg = <0x63>;
+            vdd-supply = <&vdd_1v8>;
+        };
+    };
+...
-- 
2.49.0


