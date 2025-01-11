Return-Path: <linux-iio+bounces-14119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E19A09F3E
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 01:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FB53A1BBB
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 00:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D2A8F5C;
	Sat, 11 Jan 2025 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="06iMKko3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE607137E
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554949; cv=none; b=mqmT2VPjNZZvh8U0gsgqx6GsuGL9jP7mdOt7vd8x5xeM9IoL4fDDYzEdxSTL09MBH0kubXkgNZ5x5RgbAp70h4BT9f51Ynoea++aAtgfJDoJcHb27Qj5yRq2mLTzWUCDH53p2gVeNfNymVRhUD6fsfOT0i+yWoI9xnx2pMpII1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554949; c=relaxed/simple;
	bh=vVsJao09SSWQ3bDdl3NzByMcH3l/KrVPXfGUsydWWjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSP5hhvh+5MOh61boIFscS2ssQzg9rx3Gc4Aiy9l9ktsFSIgF3CoqyynDWyp65x3UanNJD5MzWYVnWiceGbCzZJBeRYn1DIxHghXi9iu90IW8nZ1eLvlrBCXwApVM84dX/hiq2RfJAITqrLxO1/dKF8fJx4IKfIwtgi5vz7SeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=06iMKko3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e163493efso1480312a34.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 16:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736554945; x=1737159745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOSrHqat25E3J2ntKwhDL3+ISPypujVEBEo062ZVv3k=;
        b=06iMKko3b1dqmF5PvxqgUmEw3Oh9/QC5dKZWpenmi2csqjrvAOWaNU1ODkAGqoMEPn
         J9etGkd7d3KaR3FN82B1HAqmW9/neFy/bOfxoZk0KDmt/uCxK0yvA3/cRBMMu5UavCHf
         zO3HETLIsleHdR+r+xeQJ4vMBT2V/6K29/KeWNz+sxNUNFS1Ni+vDChQIrnx9TPZNgX3
         +z1/3XcwnlCdtJhi2t5eOBBlIcAl1mLF1jqvFErxmAglHRsNkOf9sHHPl/+MLEzK/+t6
         hmDWsZHBD20sU39NGrUHriXKtzVoYXyEXasrIC8+B5zQEnKn5CT5FLjjBpbwCNXfpquB
         JsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736554945; x=1737159745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOSrHqat25E3J2ntKwhDL3+ISPypujVEBEo062ZVv3k=;
        b=SHnMkJIbdsY3rafUHqDaeNAjdhEu3ZYvMrCxDYWwZk7heYw1ZoqMPlUWs1MvT4sWmj
         VpCq3ofjL8wyRiitFhBu40/4YNrt6dmUcUTS0TjSFs8Zp8ePW2KwAt7z6CWKnJ/kStK0
         CUS9l7W4CTH5r4jGDUhcbDAMypehdldSmKpj02Y3KjOY2xXy50pnGlBf2H5/XZWq8EDY
         5l6Y7mft3i1Qz/9Dw6eq4Q2qhlQrxeHOkJ0rrAtwZnUiQDiID9xEp42mIWZQxUq7cnWA
         1ZlqzbU214jKjF3BE5lNqGTaX0v16phmyv+rJMYM3r5t74Etzh9ILIxlHOeSMj6t84y/
         sBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI+eQ6eVb3vvo9O8atHyzYPjwI90SeA9oQcBqjC+MqQpb5Zxrp9aMXziOJiIyePm9/hJwUd/VA33w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqUnkI+/61XDdXDyoXf6TppB59zypyCDqZ7iIc0BL3mstTpx/
	6i26GlcmtzfLxLHVqQBQJChP3cW6OCXxrAV0wIZDI/nvOOH2Eh+k4ItMz/DNS1w=
X-Gm-Gg: ASbGnctZLyl0mzUc0KSge05VvaYPKxTc5MEZYo0TCLsN1/nFbUjfhONJoBbaXY9eI9l
	BDbUB55uDn1T20y7AvJf83Orw8lG6awigQL2qiWA0tCMXAZ4jkNzLNiqzct/snFEeSkomf7suGn
	BktiIlCEM8kxEwW/POL5sSzB8KkkQ2gG9sCurKNbgRW1Xj5I71Uw6+olvdpHvoE8GrNZLShEVF+
	rIy56hnzYbThBCsa/8JITcVibZkRXoCnqn3Up7hFKhiyaU/l8xIgUakzMjRimoGhhJQI0E93WPt
	gOqfLPk3aJed
X-Google-Smtp-Source: AGHT+IEy12bmnfix4EdPD6eusw//tSIAVQKq6c50HTj3WJnQZoistgCQSMnwIKsbjXwwS8kUqOwKYA==
X-Received: by 2002:a05:6830:d16:b0:71e:17f2:26d8 with SMTP id 46e09a7af769-721e2e9a3cdmr7839798a34.22.1736554944790;
        Fri, 10 Jan 2025 16:22:24 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723186280easm1228941a34.59.2025.01.10.16.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 16:22:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jan 2025 18:22:04 -0600
Subject: [PATCH v2 1/4] tools/counter: gitignore counter_watch_events
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter-ti-eqep-add-direction-support-v2-1-c6b6f96d2db9@baylibre.com>
References: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
In-Reply-To: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Ignore the executable counter_watch_events when building in-tree.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 tools/counter/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/counter/.gitignore b/tools/counter/.gitignore
index 9fd290d4bf439bd39a918371d00617d0bfb75d8a..22d8727d2696a875845cce0542945b3e416648d5 100644
--- a/tools/counter/.gitignore
+++ b/tools/counter/.gitignore
@@ -1,2 +1,3 @@
 /counter_example
+/counter_watch_events
 /include/linux/counter.h

-- 
2.43.0


