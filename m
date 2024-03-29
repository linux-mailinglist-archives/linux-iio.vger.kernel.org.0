Return-Path: <linux-iio+bounces-3929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5F8924D1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 21:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847861C21841
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1F413B58F;
	Fri, 29 Mar 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVkB5qu4"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B91DFC4
	for <linux-iio@vger.kernel.org>; Fri, 29 Mar 2024 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742731; cv=none; b=Nfi/xBBXS5zWMcQvXhY+g2Eyg921dxKL7wqxLcJlT6hTrGjnRAbLw3jTKkTBhvrHa+mXEWYqrSJjjx8hp3X5pI5b9f93rgSofw6ogTyfB6VLSpDtdxkESVt17UY9CZgxMIaZ+sqjqiyyqJjWgvPwqHBZTzLmOek2l72lhKHtoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742731; c=relaxed/simple;
	bh=x17cpD0ssTnsMTSeMcB6KMh78X6RtLqdVZUufL1mCUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaPdfBXBfF5ikjyIN/WTSxnIgWWAIgva5/fqdsoD4isF2wgQU2hAMup8qMsOpymxM1bLWrN21izHMonl26Zwl/Mcz4xXSAdDy5o61+z0lUukztEJw4x3yn9GXlcGuoollu7JxV6W+W7zEB4kn6Hi/nQHDLRfeqBGkUgksAlvNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVkB5qu4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711742729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnNZnWrnFQuL9z8tKMfOjE6Als92KSQE2PBtCEWHcNY=;
	b=IVkB5qu4P08PtOZm5L+TrXq8vy4N42zYOild8LVJbRHIrch9JUJx5oGYpbQzuqSxXrQo44
	HGQFASk+WgqNJGnWrMAZ3iOcOFOFf4aP3w5Q4gGiBdTKqKJl89XEY2TauRD3U5xw/Y4wkV
	VshfBeQf5dXhJza8liiAyPGUNupI/tk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-vVLK3jgBMtupcR9Lntb4Jw-1; Fri, 29 Mar 2024 16:05:27 -0400
X-MC-Unique: vVLK3jgBMtupcR9Lntb4Jw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e6c5b1377fso2648025b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 29 Mar 2024 13:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742726; x=1712347526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnNZnWrnFQuL9z8tKMfOjE6Als92KSQE2PBtCEWHcNY=;
        b=nblXD0MjnCFWNzD9dQsNpqfYbJFnFYx6LzTMgPL/+LXh59fF2cLY8NQ/Xy4wHRQ+JT
         go+tHuqrcOtPUgCMSu8T8RkWL1DLhE+B94W6+S3F24d7EC2pyfbc5vhgjqzBAgw41VSZ
         nRwwn8f/UiaiM5zqC3lvg0z0BtWfTWm5cK3ifg86M4IKpgxf5cfohhWwl4l/fbhisVy6
         oSi7f1Jv+isPOHjZEO6VX5ltl2a2JSOGLga70SZ0Exc3lnIUPMg1OfJBJfMg6A9q+OsC
         ViMoXJ8AGFPc/1FXMDK7QbgwdMXxghG074KT1EkTCai8Iy4L0qphJukZkGTT2k9pHgkl
         8w9g==
X-Forwarded-Encrypted: i=1; AJvYcCUjQ+LcyqQp/2ZttGrfFWh/w4416yGaSQIiMKwXtvdlp1ayg+f3nf0YK7uPTqCHHQl4cTZhkG0w0dfUlRhy/YtgMIy1dxzOS70R
X-Gm-Message-State: AOJu0Yz6BhRtPdYJcui7wpLaGDDXLupzusrND1xXs1PwWjML6xsYGiBI
	WcEgDeROxnM6fz0QWn3rC16NDZiYxNLHKAoKAfFaXWYq4DmtFOS7lvwcF5X73WNLHbSwOdVNQvZ
	VtEoidAmlqDjaWk4aQTjYrjVTCvE/xXxO+rDXPDHTBGIqLeO1k9JYMW3kEg==
X-Received: by 2002:a17:902:d511:b0:1dd:8ed:997d with SMTP id b17-20020a170902d51100b001dd08ed997dmr9174642plg.3.1711742726540;
        Fri, 29 Mar 2024 13:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJYw4jR0YEnb8pmE90nAgE4U0L687WOcBXmCkEU8q6jh3nVskf4AhRBUJH/lIDQYZgDuFnCA==
X-Received: by 2002:a17:902:d511:b0:1dd:8ed:997d with SMTP id b17-20020a170902d51100b001dd08ed997dmr9174602plg.3.1711742726167;
        Fri, 29 Mar 2024 13:05:26 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dd6ebd88b0sm3830017plh.198.2024.03.29.13.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:05:25 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	guoren@kernel.org,
	conor@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jic23@kernel.org,
	lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	marius.cristea@microchip.com,
	fr0st61te@gmail.com,
	okan.sahin@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	lee@kernel.org,
	mike.looijmans@topic.nl
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 3/3] dt-bindings: adc: Document XuanTie TH1520 ADC
Date: Sat, 30 Mar 2024 04:01:26 +0800
Message-ID: <20240329200241.4122000-4-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329200241.4122000-1-wefu@redhat.com>
References: <20240329200241.4122000-1-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

Document devicetree bindings for the XuanTie TH1520 AP sub-system ADC.

Signed-off-by: Wei Fu <wefu@redhat.com>
---
 .../bindings/iio/adc/thead,th1520.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml b/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml
new file mode 100644
index 000000000000..80890ce62810
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/thead,th1520.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: XuanTie TH1520 Analog to Digital Converter (ADC)
+
+maintainers:
+  - Fugang Duan <duanfugang.dfg@linux.alibaba.com>
+  - Wei Fu <wefu@redhat.com>
+
+description: |
+  12-Bit Analog to Digital Converter (ADC) on XuanTie TH1520
+
+properties:
+  compatible:
+    const: thead,th1520
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: adc
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - status
+
+additionalProperties: false
+
+examples:
+  - |
+    adc: adc@0xfffff51000 {
+	compatible = "thead,th1520-adc";
+	reg = <0xff 0xfff51000 0x0 0x1000>;
+	interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&aonsys_clk>;
+	clock-names = "adc";
+	/* ADC pin is proprietary,no need to config pinctrl */
+	status = "disabled";
+    };
-- 
2.44.0


