Return-Path: <linux-iio+bounces-15548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED6A36D54
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 11:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7B318931A8
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3D1A7262;
	Sat, 15 Feb 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDNLU00v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F41A316F;
	Sat, 15 Feb 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615549; cv=none; b=rpBBjOWPJWiTrQKY6v6HWt7l3t5lWtnHLphvDPiB4EJw41sfAnqJbBGeUe7+EQgM7kC0xGHkkLzGnSYchKsvM5YqmKYqtFbmWlwnGAmhcgJXChrKuuIicCED2sMdGCIdXBeguGnsQ0AGu6jPsZztU02BlzrXDENsspidYvv4SDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615549; c=relaxed/simple;
	bh=ZDUMsjmo75Y9STqMDs2I/FG+a3gZTRX85+elzjyo4s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3glHvjT47kNyMSuz+IftCnVjvZP/knEMkMrLpTiW3gkT+ZWKZiHYHZqpwLBBmncMZsj69tXj1/THT08rDTC95T9wfbXs22rsQMEYtZxaI3lHiq9GM9ijdabth+Of9f2/wqweZ1fWCWY9tJrTfAEyjItpaLJ2SsbtftwgQAR26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDNLU00v; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5450475df18so3008281e87.2;
        Sat, 15 Feb 2025 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739615546; x=1740220346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgygo/iB0cU+FYRPxKeAja8hd0RTJCHWFazvBj9cQrI=;
        b=fDNLU00vHhtoIPEIJxuKUiqGceHnW1abxd0Cj6DqzPkmW/3b2EOVhqtQul8P0IHlb0
         z0qFa60UxuqLdO9jMgqpnV0V/KdwLZez+puwfIZvrAHWs+hcpWMrtzrunAA0hBCH1xMR
         iz78+FLK+UQQMRRVAz5YBDPVWajRyRCvEfLHc9o0jbqVBGFO/Y4aN7cxW3XhhHvqsM1O
         eXgE25n6k3hHkegLPsDk+QTde1Sd8H/q8TArLjLzQI6zcdBCWZbFMcMUnAdi5ppf4bOg
         DPr4gQXW4NBLqlNsAmRoLQvBJ0XkcTc373x/km7XmYHMHtzqTF5NDAG/yP0SSa1WwqK5
         sc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739615546; x=1740220346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgygo/iB0cU+FYRPxKeAja8hd0RTJCHWFazvBj9cQrI=;
        b=v1hK2tOYfViCGLI6kXIs/2Hil9fuDeiYx6dppUKI4152AhjPH0N4Wr85EAB00KYnvM
         In9gtK30G9ELKOs9Y2PfuBQzxx0pzmrGZRfW1q9dclE+R9vDRy3tmIMwytDhUNT699U6
         tU/WOA1mifWdtPCXXi/xc96q+5fy/3FGJKs3RE0LegdxxlyxKGyaZCCB6AiizOQn4X7u
         aZWI1emPH1FBymnn8xk1vRDwp3MqpHXtOpjlr86XQl+VSXDhjxuifBRrQ1iB+2rj5xe/
         nVhGjqUNMQ3Prxki7P/rXL+nfsw/LB0Hw3Rh1IMUZ5WMNGUGrWYiwco+4mBan6KtnSI5
         whKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUME+p1SkFTAQYt1hpyoZ3IeRvDbSkB9E9A7yjeJ9LR0kzgJouOJ8ULN9ItcEhcBVzHTaZVtpBv9a10@vger.kernel.org, AJvYcCVFG2P/oS28kml64vHuZB5rA4ivgPPskb0/nlzH0kAUrnoS+rDvTRfQQ6O3daBqVAjrcEoPp4WazQlTBKQ=@vger.kernel.org, AJvYcCXZg7NS4K+bsR7WjpfYGPkAixDgqRxqGFou7zV8seVV7ARmAm3VkIoaw9PMx7rI32EwmVUGC2ELjjd6AF5h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Ldxs8SaKycScIwdTQIxQ5JputQzrCPWNze2uMdD8OJLQ1X7u
	r53qOsK0SPdbytQKwU/N0TnD+dG0arV7YTKIqkr6JAIMKMjp3Qp6
X-Gm-Gg: ASbGnctZyB5mVnWwID/n1oVmVRwI1NhaQD+BEp4u92ozu+JZH1o33oku04osMX9MG1h
	xGKHDBU+nbIZ8jLlA0Zw3uTUSjyzfHx9jdQLhzoYAYHG+5fIqkD1UvccC4UBCEYwCOSP7raPiNF
	iMNGF9aPoTwDaHbNFzHBI4OpmzjfOpK3db1nTAQrNehoufI/HJ1lqwhrMhxc1nFqYblzRQ1JP4D
	X4id2ZxIf83paRs1mhmRr5/b5BSaYPjFP6KueTKgZBMl1xpPr35sJbk591cQqonwBF/okeb74q+
	dtkPaWs=
X-Google-Smtp-Source: AGHT+IEC12XXfHdsAEOZXJh2h/gPfige6sCvK5UTAswy5RQfBb4fITdeXYCWxXDIPlTS/3VZsIFJxA==
X-Received: by 2002:a05:6512:6ce:b0:545:2f9b:7589 with SMTP id 2adb3069b0e04-5452fe8fd91mr728897e87.50.1739615545726;
        Sat, 15 Feb 2025 02:32:25 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309298dc5eesm2201571fa.95.2025.02.15.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 02:32:25 -0800 (PST)
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
Subject: [PATCH v2 1/3] dt-bindings: iio: light: al3010: add al3000a support
Date: Sat, 15 Feb 2025 12:31:57 +0200
Message-ID: <20250215103159.106343-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215103159.106343-1-clamor95@gmail.com>
References: <20250215103159.106343-1-clamor95@gmail.com>
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


