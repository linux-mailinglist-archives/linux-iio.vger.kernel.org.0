Return-Path: <linux-iio+bounces-11886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8159BAE80
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02EB1C20F8D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F761AB517;
	Mon,  4 Nov 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arkw82XE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0B1AA7BE;
	Mon,  4 Nov 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710135; cv=none; b=Ur74W9pmczwgVi2SApsb/xarucIB7/8J/+oeKz4gW5BQGB1OHLzG2eMOk4w0QlnZDvxfEl/6zRf0BwqjzXJp7zFFY/GfjdQZd1XvPUBwD1y+we+Rv/brLZjV7IEXba3GFhebJvRSpVRbAJ8H6hUZKoF2I/8FldLPFf1yvyDsf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710135; c=relaxed/simple;
	bh=5+i72FmZ741eQj/KKoKDxRcngb3xinsXBjALXLspk8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZosqDKmurhGYI7Co3nmxI9l6w88aG5YvISjl/iB2U225QvsFsxGarAyT3P9S4OqljQiaYgyt+soO05e6vlWlIpR3+0eXeWZd3ZrHtYAAl8qIml3FQozz+N2DeNYSCHD88h5UVoF/lyNY0kbBqDEOmsaPhCFLpKRhzJb4/oqMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arkw82XE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cedea84d77so382036a12.1;
        Mon, 04 Nov 2024 00:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730710132; x=1731314932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZZ+0RjkzenRGrYKXv3Grrd59Lbf3Pn66/QGdrg4mvE=;
        b=arkw82XEU85j/VEAMfUyq29hPO4qx8mqs6zT/faDy7jpFz9XeNBEbvzfcRNFMP4YKD
         J6eLGiU11eGsrzwF9BWpsqJMoVhSlxedK+Df5ew70JuSriwpV7h/GymitSdw8Q/Zg01K
         SpExxsAwJixam4OOfyGkuAHa0zQxdkzGj8WN7jZ3JRSW0jP0597rpHlmlKHuEB9OroIu
         4OMKdNQYbOqpwFqkXk+s3rodyPuvszmFfnWnHjuqO1MNk0KtaDimEDkrKdzCzP/DiEVw
         FYvIKMphqSOkPT5KwQKj1ywC9j18Qxn5aV8aUGCjDV6xUtURDCQx51skSbKmeNBhIc3G
         KmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730710132; x=1731314932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZZ+0RjkzenRGrYKXv3Grrd59Lbf3Pn66/QGdrg4mvE=;
        b=NYt9nLzi6UCqGcA+abFCy3h55X1Z0Hrrxi94OrB2v4RKCyHBKCbhGYhaWb6K0VdRjS
         +O44HTlei2PuPM9gvCQXKIDoF8KDdphL7B5X38YjBPalpphDFR456ZeOhY/IlJ3rmInO
         ZoRdBYV2DRUQT8GfxenZw9NvNVn/AmgagD03e6WQ3Zc0RvCH0/yrQY7E3UU6HjfeOVyB
         NXv8Q5Gk8hMFAEaxK79RtqUcqEDw/J0dn/qFpvWaGudQfSIRwl/VEui3iKMprY+8s3L7
         iTAzILk3b2ELOLWSd9SWYzPu2ba10Ftlvr4DNuxeDRPpayUgOJ5g9FX2rl5L017wZlIx
         LWng==
X-Forwarded-Encrypted: i=1; AJvYcCUq8R7+k4sTI8388AVzyRud1w3P9bdOf0wFksvmYF0e6raIkd5BTluo4NcX+XaYsXVvV1mtKbuLajI=@vger.kernel.org, AJvYcCW9ozONZvKOPIx4trJ15bk1dV68MG6xFJN7uHPhhhm8c4d8i/8PPU887i0Qoeke+FZlg+rg9HGj2PuSBkR7@vger.kernel.org, AJvYcCWA1jF/GOC1fCAdTEm/e38/qTfms1C4/x8QqfGsZqaR7I9OQbVCSKMsDbyH0qxtg6D6AKzvTO9ooG0bqA==@vger.kernel.org, AJvYcCWnKIZmLudQPNh93zreF04wNJB3mNCcV7EdvzItixKOxSVsTy9huy5AieE8ySDI564qQRaMTsmkhA6U@vger.kernel.org, AJvYcCWxS/LyHlmb6OY72QaxmW8ItTfr195jopys/sNBqoFJ6V58VmL9nzkVfa14EJggdI1AhDFfk3XZvpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZqZIu96MWf1NGpB0aovczcP3UqVC1l4kmRZ1CBC66uv9BbTP
	WTizYsSDlcfvDKv8ae4JrYf2UTWf0YpKq01oM4s9dUGZLHN3DoaR
X-Google-Smtp-Source: AGHT+IGpRKouQd21becr4NL7JTcNVTWUEzIT1ATcrtRapmmpmOnf8sfq9N/NkZy3dwUV4Zteb6HUlw==
X-Received: by 2002:a05:6402:274b:b0:5ce:df46:70f4 with SMTP id 4fb4d7f45d1cf-5cedf467240mr505986a12.36.1730710131795;
        Mon, 04 Nov 2024 00:48:51 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac76fb46sm3957953a12.26.2024.11.04.00.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:48:51 -0800 (PST)
Date: Mon, 4 Nov 2024 09:48:49 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: mfd: sprd,sc2731: reference
 sprd,sc2731-efuse bindings
Message-ID: <cd8cc95b59c31418b174bba521dd2599a7929fda.1730709384.git.stano.jakubek@gmail.com>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>

Directly reference the sc2731-efuse bindings to simplify the schema.
Remove the duplicate example from the efuse bindings.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V3:
- new patch due to a missing dependency in the MFD tree 

Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/

 .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 10 +------
 .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 29 -------------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
index 8beec7e8e4c6..bd5f2504b44b 100644
--- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
@@ -67,15 +67,7 @@ patternProperties:
 
   "^efuse@[0-9a-f]+$":
     type: object
-    additionalProperties: true
-    properties:
-      compatible:
-        enum:
-          - sprd,sc2720-efuse
-          - sprd,sc2721-efuse
-          - sprd,sc2723-efuse
-          - sprd,sc2730-efuse
-          - sprd,sc2731-efuse
+    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
 
   "^fuel-gauge@[0-9a-f]+$":
     type: object
diff --git a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
index dc25fe3d1841..8672bde24a9b 100644
--- a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
@@ -36,33 +36,4 @@ allOf:
   - $ref: nvmem-deprecated-cells.yaml#
 
 unevaluatedProperties: false
-
-examples:
-  - |
-    pmic {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      efuse@380 {
-        compatible = "sprd,sc2731-efuse";
-        reg = <0x380>;
-        hwlocks = <&hwlock 12>;
-        #address-cells = <1>;
-        #size-cells = <1>;
-
-        /* Data cells */
-        fgu_calib: calib@6 {
-          reg = <0x6 0x2>;
-          bits = <0 9>;
-        };
-
-        adc_big_scale: calib@24 {
-          reg = <0x24 0x2>;
-        };
-
-        adc_small_scale: calib@26 {
-          reg = <0x26 0x2>;
-        };
-      };
-    };
 ...
-- 
2.43.0


