Return-Path: <linux-iio+bounces-3398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E95877090
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61561C20D0B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1E374F9;
	Sat,  9 Mar 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="TSwGxwqy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DF2D044
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709981517; cv=none; b=BWFnb/XoLyNbRnWniSnIJLSjNh5M1H4XdnbuYu/5OBVsK16uiOejSDaz4W/tSl7ltR2ywC+PNxSGcbXhuyj51hi4sVLI4i5iOVeLWucWdOmUNbpcf8nD+GoUh57Z/GmfTjX8AQfXXPjik8iH+k/pBrh3I7Vu6p3j+kgjijopn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709981517; c=relaxed/simple;
	bh=MJurD3lQkgJh/SJjO1IdmDA0nZhea/ItLzC5yip7HFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWheytRzM7fIuE3Ixs2nt2gj2vG0/nnbFLFPquAOlB3OAOYdJJ/9ySRTefjEGQYGJef5VxC+LJkT5dPA5uuAZ3ayCLqLtqZEqLW9VFG6uqjCQ22wuB3S7cq0yPXQ2Cj+WcMp1G4MlsHkP7LPbAAovfydGm+e6xICh4k3xHwu7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=TSwGxwqy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd6198c4e2so17802805ad.2
        for <linux-iio@vger.kernel.org>; Sat, 09 Mar 2024 02:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709981515; x=1710586315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR1+ke7p4Q047/hy23eOGK+2iosx9giTHTVTkeIgf/o=;
        b=TSwGxwqyvI69fRdrhuj1eISIwoog5kn5ejCNLjq1qod5BXW4UBfrZNdXv6oSy6XE9n
         IAa/ySkFnOQf3oPKL8bcJFBtOxw1zCWBJdpMFcZNbKMh1rHPJPRM3sVpkFH2YU/FBxVn
         4QKx+M+izqZ+DlFxlEEhPuz+NVgopcU0Xmk+Bl/fULzXXYnKw2hiHzUgeKQuDtPWiWMy
         Aqp/1MR5pev1bn9A8aiXGGUEfDp2IgTgPVZG6xQhtFUyBCc5edZUzQV74eR3u2hKDY+I
         gfJFjR+gdGd/SwscYNOc0v3fMZj6h4ZohvLO+yZicBVB4hJQv2RVBRdJrqTKVZzUjdTI
         eAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709981515; x=1710586315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR1+ke7p4Q047/hy23eOGK+2iosx9giTHTVTkeIgf/o=;
        b=eu3bbsnzBPKxK+qZh2x77VKW3lUrGsJdaC0wUd6AaPOWw1hAal+oadUKL3IkruwKhr
         hy1YmnuH4z7hcHS0ybG26/oPlDJaWtimLSEV/IMv6fgA2o8xOWIFs/rhs4LBasAbD4BX
         JoNyDOQ+vcYdnAgh5gNAQBS5whs0nxMqs3e1h/deb+jYK5hfH5dt2ZiR6Qte8aHkFlGE
         EpaMXw8Egt+DvB1tcNArwA7oJoOv2nNQBHBjbj1ROUd6JZ9EGh1lRbHfngB4Ps37cTOR
         tcEUjyx21uOO+oMrYmsPodEuNZEjIj+HCXZQf96lo6h9LsfExkr4CEtxhpL2BMxImLWZ
         FWjw==
X-Forwarded-Encrypted: i=1; AJvYcCVVbFW9QfCKl1yFUVSWg3U3aR0LDo/yCcF0nYQhPPJrtkXQHY+LACI56xBXZOd2nBqBgvpnXWI+TDrSdDaKk7bpx4yFdPjwVrBI
X-Gm-Message-State: AOJu0YyGxmclpNJl0AUnF3Oqp4u4Evga6bA4taAfgVp/PtNFsFJ+qWQL
	TRICPTbyDocsdgTanKSCW7MVEFF9JANlb5sM362QfuSW0COGA1u7s7hPQyQODsw=
X-Google-Smtp-Source: AGHT+IGgUOcJTk+1DFpfJo4xiOdVcORTwRLx+V25p/IGRHIEuRlbFRy6K5fuiu/UTsxyDzfLtS7n/w==
X-Received: by 2002:a17:902:e542:b0:1dd:6420:847d with SMTP id n2-20020a170902e54200b001dd6420847dmr2085384plf.2.1709981515355;
        Sat, 09 Mar 2024 02:51:55 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001dcf7d03824sm1070608plh.55.2024.03.09.02.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 02:51:55 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 2/5] dt-bindings: iio: light: adps9300: Add missing vdd-supply
Date: Sat,  9 Mar 2024 21:20:28 +1030
Message-Id: <20240309105031.10313-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
References: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All devices covered by the binding have a vdd supply.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v8 -> v9:
 - No change

v7 -> v8:
 - No change

v6 -> v7:
 - Changed the subject line of the commit
 - Updated commit message
 - Removed wrong patch dependency statement
 - Added tag
   https://lore.kernel.org/all/20240210170112.6528a3d4@jic23-huawei/
   https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/

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


