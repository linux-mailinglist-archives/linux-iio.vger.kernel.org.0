Return-Path: <linux-iio+bounces-15583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C532A375B8
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993107A398E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D719D090;
	Sun, 16 Feb 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev/CMn6G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE819C554;
	Sun, 16 Feb 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723267; cv=none; b=VtpG/2s4+dW7loRGOQo5MF8PVe0FfgHwZAuLdzp0oRtJCzj3tjfmp7wnYPpDFTNNoJ0mjZRi+Jhm/kk9pBcLcVKLoxM+cKMD7LUljZYFFvgXh1AfKtmW5X8s6aViskwzhbtbCdY4yoMwKEUlME7NQV6PnmD1CNKps6/NeidDl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723267; c=relaxed/simple;
	bh=YWbWWsIv3mMI03pwpX5IuXVcOxaKbV7lgKMiX7Ez3lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1R9E5qeodRv7uuR/lswrIIhwrk9qX3AWlVyO5NUEZOKfX0KBbrFbM6UBbHe5pnfKm1trRtwXdF6jm/E42KJGJFFdk9l4Myv+eV8u6K4ySrNTzXpjpx3x5Rp6behlmsVFMh5so2qveO8f23bJfEjhHas1Ilss5wMk0XsPvTq6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev/CMn6G; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5439e331cceso4297683e87.1;
        Sun, 16 Feb 2025 08:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723262; x=1740328062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L330aLnl7KlKZL4XMYjiJT58mG5vZbDUVYOzSIQvANU=;
        b=Ev/CMn6Gua8nci0p4FeorvzJ/VUs2kh/Vv3sIFV2RXOvQF66qx5lvLluwXNFtjuZ+t
         2GmFRse26k9Ixue8FxgWG5MkGQaMP4KPE7bVFX8bCAfKbHsSB1+6sO3hf8yczOFHI858
         9mabEdueg7u0YGffCXVw6MICc/wbjvrsKlnrrlpfW7g5tQe/UN2r7jwNVcIH/ZdIkrRF
         z9/WsH3EZOO2IlbBbL/IV8mWS1c3M5BhpWKt3g/HkwfoyjP7PZ9hN4BrTEBfc0i2Qtyy
         DXOhHDjLqeZ0Kh8hLr+rVNLZMSXs84IrfW8TSEJAj9XpcARC+NwY1mw+5pVuC3/7lFAb
         vQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723262; x=1740328062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L330aLnl7KlKZL4XMYjiJT58mG5vZbDUVYOzSIQvANU=;
        b=fsdQFYGiRrcNp/LTg0QkF1HZ8oqhC3Tk744cuCwPWam9RfSR+rl03fYc60/jqPlW1H
         gebm7gglDWYj5q3fSCqDxcCHZkh7JgZ4V0H6qGjFSlyNdfrYHCY1DWyCCrlKNHO863Hz
         IRpjmC1Nc51lrqo+euaHsNKrHKlXXFBppW957YNe0j/JC7T4et7+4G1smTIELiTk6AQ9
         diJ2XDTT1Elvd+8DYAXlOyg6ns92AVRyCL9YU5HNZ+ZwBefY6rZSGT5OeEh3SA/NYYpp
         6WT/yo6UaMFU47B/JekvYuv3Hq3Mz2xl6m3GJNaZGoAQf6DfZKpzIgUxTXjbXCiZrB2+
         NEZg==
X-Forwarded-Encrypted: i=1; AJvYcCV+uYmhSoY3AmZsnPcfRzw4kAyXgK5bo1doM3BSEIUcvRqKtrVEnFVgVpgLKjCrjEbP05curaiBefuULkM=@vger.kernel.org, AJvYcCXCMFPA9c0mxE+S8o3MrytqmoFjg7aMhWdGstrWqXmPlWlzaC6U0NuT/K1RHUt7z8ngZN0obBVe0RR5@vger.kernel.org, AJvYcCXJUFH760JcbGIUKcDRlkg08YsUr5AGr0IORYDoODGTZL6HfUFsmE2KbihVZXnDgF8crBhmM/jWfbCWTKjT@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGhBiuhpcRaSY+jUWEAxALq76VFlB2MC88Iwx4FW0ufVCEW0s
	JZVxcGXTCGBvG6qA/OVgVfj9MKGRJRELumlTxuBLLY8J+YB572vV
X-Gm-Gg: ASbGnct28vGnm3zsYbpLvUrdVjUE7RGnaAO1ATdqyS+87zY4EsEXqVRq03f1qp/AcJd
	ClbK7SoIXv+/xPVWfkP22YHfrJAgIDpCu0W6G+hfqSKY/Hdd/2qxK/jLBZJmz89NgoDN4nVF470
	J7V61Bv4VbchPAHLwA2DHVDXiGOrpWAEdbLtRaSK0UpGlt0x9Hn6BPqP5Miez8RJjtfBzvWK1PA
	ARuWNNZuadZGrmN9H6qn2ehpFU+0lbdMByy22cK+UKBAt/oyybFFkyRUW+nIbuVq0WZwuhXIZ0f
	99+jxw==
X-Google-Smtp-Source: AGHT+IGsVECOcXf/GnH4esfgFc9S5Ky3/CL424dkvM2iiuT01z1xZRmbsblV2YbW5Syzf18tO+DPXA==
X-Received: by 2002:a05:6512:1092:b0:542:6d01:f55c with SMTP id 2adb3069b0e04-5452fe2ba2bmr2174383e87.3.1739723262099;
        Sun, 16 Feb 2025 08:27:42 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5456468c28csm481835e87.122.2025.02.16.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:27:41 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: light: al3010: add al3000a support
Date: Sun, 16 Feb 2025 18:27:19 +0200
Message-ID: <20250216162721.124834-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216162721.124834-1-clamor95@gmail.com>
References: <20250216162721.124834-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AL3000a is an ambient light sensor quite closely related to
exising AL3010 and can reuse exising schema for AL3010.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
index a3a979553e32..f1048c30e73e 100644
--- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
+++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
@@ -4,14 +4,16 @@
 $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Dyna-Image AL3010 sensor
+title: Dyna-Image AL3000a/AL3010 sensor
 
 maintainers:
   - David Heidelberg <david@ixit.cz>
 
 properties:
   compatible:
-    const: dynaimage,al3010
+    enum:
+      - dynaimage,al3000a
+      - dynaimage,al3010
 
   reg:
     maxItems: 1
-- 
2.43.0


