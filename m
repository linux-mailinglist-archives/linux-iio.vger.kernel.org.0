Return-Path: <linux-iio+bounces-12990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802249E1800
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD0BB27F3F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF01DF272;
	Tue,  3 Dec 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auiwH6EY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409E1DDC25;
	Tue,  3 Dec 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217378; cv=none; b=bvQeKWtd4AB63HCnTY/3UozbbsDnXCYYMG6X3YFvG701zp1ytZHBFCKwzfzFyqmBHBTjB4DUqIx9WQd1rM0JPrjYQWDr2ot6wpO2ok7OrRmGw68ygDNt7uzzlmAfNq+P8mS+mkqoix+2Tv2nMXlK+W604aKvA41XEHHNZarqk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217378; c=relaxed/simple;
	bh=VJp49OkZzkMLWJxYnpXwGS7PnMfmBmq2gICryHRsx80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUKZjui5qRB4Am/kWM4rtegWjTdlAuiMLLD3cHZ2kozt0nwIHv5OVQYA+JM8r3sEs03s3dX/z9rxmGbqtNdwXSVdXvdrH+5gFhEQWKGM0PebcZ2UcB8qJ8QG0CSJIlePZGhAjQdmJDQ6mtND893zQ371ata2QhWUMBSiQ8crc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auiwH6EY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fc93152edcso3849623a12.0;
        Tue, 03 Dec 2024 01:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733217376; x=1733822176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=276MN0lUCnDhh8yYwi1XglLnelGlPnySlz4rfjZRHPo=;
        b=auiwH6EYyD0kI9HveHTc9cRkN2Z61YxAUKcRU/wBhQZD+jQR+AAWcuRpt0ZbKFoXFq
         bGun3qK9rs9TXzDlorrYJxNYKECKGy8TtOlI8tjZARlmWF2+3vYqH1xYh1zyZ+57QFeT
         4sJA39zNahL6IXuCb6vqZdEUBDu018tCWm2My3vHkP3Fc0nHl6+dbtVpMGJxF2El/Zv7
         CR1zCAZkfd/Iq4NP3/2K7qBswSxH9bC7JdPA3wAvwUW7UYKKXOm8yd8UtHaAHKdfNJ6H
         SYNbxijLLh7rxfnxYbPgkWjOl5BK6dU2RmKsyldJnli6QV/vRWMuIzljOxlSfUAZXcNu
         VcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217376; x=1733822176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=276MN0lUCnDhh8yYwi1XglLnelGlPnySlz4rfjZRHPo=;
        b=bIvJISgcJ5XgFRSPTuZtvExwLrJDrcW1hm9EPo0EzV01yaDheUeZIrJcqNxRzTp06G
         PNoLke0NCp3Fu/T2K6Z7RxGnli9GU6fvb+3nxmG0Tg7fQ/biGpv3SG7y9Ic6njzB+J+M
         CY8sLoxtpA42FH7DFVLWzhil7f6hxeKkknX1L3SBR6wOV0uwZIeV9xwQaqUgXjPTJJ+e
         9kpgQ3reNqFQ4nPvRI8SK9ABFdznFpYQhvlt64xCQ8kM4ypZcrp+M6/QjqOFYB4KO/jo
         YuZTuHNo5g+5d1jm75MSAbqV0ozryQZkpUXJZwcmp03FJSQMj9BER8G9mKj3bg1A/DKS
         HqIg==
X-Forwarded-Encrypted: i=1; AJvYcCW7e9fQ0aOXXWvmJ6XoeapMoWGekILdzOHJvEavW909MCUF1E4dcq4n+oQHBDlSRSgVeA1pSJGMKs/X@vger.kernel.org, AJvYcCWvvVxHtgyXpEKV/1+79ntXZod0cByUCzdU6MfGlmvJlmFGhOd2ZUev74NdMzOU9LshfAROM6QWjxy9@vger.kernel.org, AJvYcCXDpDKVmizSee84UIUi8vG4ZADj164ZSh5/QEGK9JpAUSz0d0Q/3yQDbGDsoovrlLMjNiCkil+nYqqq8fBr@vger.kernel.org
X-Gm-Message-State: AOJu0YxV794T41RNOLWzsZP6tVUKCaAOzuFPDz8KCFrlUJeG2+lp1xfq
	KBT31fMLj2cI6o6hXWJDppkf1Hm1w42DwCR4czBVYUEG6AfQAG39
X-Gm-Gg: ASbGnctFQQqAkif+UjIvPIj0S+BFbxljy3Ng+tk6DkokAzBjAnM42/SZaEqPQ1U3byf
	HMKXPBER5YNKMvLZBOP+3NkIhIGXaFsCBDgk1U8aQPHRSG+uq04kUmFsKWY5XcRTt8RNnpbl0AP
	lCEjrYPq0htNNdCNTZ1GdB8+kk4ZQ0KB7n/jer0vXE2NPQ1T6CCggyWQqhx0L7rBzP3mOhiiepG
	hpvzaHgaCPib3quRNBE+I1FfY+mVc7fSn9nnlCeAFbklEIapdmiLu7LNl5fppnHGHI+ZsM8RmZZ
	v2MiQpu23tc3ALo=
X-Google-Smtp-Source: AGHT+IEKIs/vZK2aRlRCleFIL9Zz7f7v59c9D6ZAF+KURJahAYSu7HJK/4STcPoClSH6IsGkOSZOYQ==
X-Received: by 2002:a17:90b:1c89:b0:2ee:1ae:a247 with SMTP id 98e67ed59e1d1-2ee25ade311mr31604823a91.8.1733217375685;
        Tue, 03 Dec 2024 01:16:15 -0800 (PST)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee566a9a34sm7713069a91.51.2024.12.03.01.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:16:15 -0800 (PST)
From: Eason Yang <j2anfernee@gmail.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com,
	andriy.shevchenko@linux.intel.com,
	marcelo.schmitt@analog.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	tgamblin@baylibre.com,
	matteomartelli3@gmail.com,
	alisadariana@gmail.com,
	gstols@baylibre.com,
	thomas.bonnefille@bootlin.com,
	ramona.nechita@analog.com,
	mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Add binding for Nuvoton NCT720x ADCs
Date: Tue,  3 Dec 2024 17:15:39 +0800
Message-Id: <20241203091540.3695650-2-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203091540.3695650-1-j2anfernee@gmail.com>
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a binding specification for the Nuvoton NCT7201/NCT7202

Signed-off-by: Eason Yang <j2anfernee@gmail.com>
---
 .../bindings/iio/adc/nuvoton,nct720x.yaml     | 40 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
new file mode 100644
index 000000000000..2ed1e15b953b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton nct7202 and similar ADCs
+
+maintainers:
+  - Eason Yang <j2anfernee@gmail.com>
+
+description: |
+   Family of ADCs with i2c interface.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7201
+      - nuvoton,nct7202
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nct7202@1d {
+            compatible = "nuvoton,nct7202";
+            reg = <0x1d>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..bea10a846475 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2792,6 +2792,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
 F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
-- 
2.34.1


