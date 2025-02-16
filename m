Return-Path: <linux-iio+bounces-15585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF837A375BA
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B563A1EFD
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7C19E7F7;
	Sun, 16 Feb 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TokiceHE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA519ABAB;
	Sun, 16 Feb 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723269; cv=none; b=L0B/oOqjChJIhP+S9cWXoaC04swgPrtA0HpkBjQhWaU17mX2VeAFhqM2aFbsEbD398g0qrWGYhBsM4Zn8+x4d9t4Ervb+y2V4AB6I2PL9uk/Gbv6vgZV8rT2K8i1n8ZdcNouZYID63BNXHbCaSqigE7yrgfq0w/H0ToSAr/I6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723269; c=relaxed/simple;
	bh=9aREkL79Xsxr+96x5qn8It6s9YMe1H0v50kaLPRH6JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWKMZWanw2rFWB767nHF5UKS9OP5hmFJl2kNIMK7GYO9vVvvWgmlCCx68+EvbilNojSm2mXHCKldJbtmwEg0E/921cK69hzmQMdYNDWVG1/XUN3OFEzyvyntvOUQjmRQmAhkbEzya7hStLdAwZi/7t3Q1MF75GcQoisfN/vhT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TokiceHE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-543d8badc30so4297995e87.0;
        Sun, 16 Feb 2025 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723266; x=1740328066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wiMhV2MLOmdVTuzdxdM8/it2VeMkuWUBOlinnhDCGM=;
        b=TokiceHE7R5gOX8QYwjvoubRjjAGGvnABMjKvhVpm7Iowd/tmTtt8UxX85Ve95pz9L
         WbcIai562zuzE4dSSe1phvliZ4LkbTthqxDP7zAFfyqZGz/zvBu91WudRW7iz9QisZq/
         tdWETazBBkv5KUNBG/sYpvFLrb9GUvxfHG/08g2JVjp67J3n22SzTZ+dMkPWij+ILLp8
         kDpgxdDH81hXDODddLnBGd1yKgFWhapN09phueqZ33FWp1wSRbG6eLurTmzW6ow+lSa8
         gI/43Hd3KdHStXwzN54F8f+OuBv4KC0BP1OhaNG0cgJ90EVKrpir3FBmYTKpV7kcBf6E
         2apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723266; x=1740328066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wiMhV2MLOmdVTuzdxdM8/it2VeMkuWUBOlinnhDCGM=;
        b=FGVqQCDJ3bIQ/tffqHCqxhUH+thovrCzqxGXeLnE4b6ankHhdezMq2zwYUYeedUFnG
         8oFrfb0vYOADl6gcqrYVe5xW07SrOhq7j7GLzbLSUA4NXLOndT8yRSWYGXoZp+kYwlR6
         LJzeZ0nj8VyyEScMWcg5HJbvQD7KZ928QpUUHVAyG9ghp1QaOtsIk5O5tl4nmNfyAgMI
         HCwiQW0ptflnZdGYms0EjUSkDBLyq1tLdS6XNHlOHqjQgpaXAAk98/AYG2EPyBmkWpzi
         ZYwp+0tZvZj/EeoYDj3fUfc6crK5UfVABbWwUyLYi9a3haI8OcLc8LMkNXoxt4V8PK+z
         XyUg==
X-Forwarded-Encrypted: i=1; AJvYcCU/CBRuV9jP/xoVm6hdQ+yiQco4Bt3f/IiWET27BX8OTVLQPq6dMRWQzldzxbehiXowR9WcGWC/lqZqgA0=@vger.kernel.org, AJvYcCX2ziP6pNAuyHHl4Y82nWG3b5YeyVjXE0EInxYkN6jPO0mRZYtTFdbVdKiv34If4KGSrAvIRPL4Oa224SI8@vger.kernel.org, AJvYcCXJnB3WbktIh1T3i9zx7gpe8q+Gkaynxzevsv4cLtPACZO8PEoTnOx2P90EGF0MZSCW0llFfEwPhM3V@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIXMBroaDPUW3w6ed98DJ5vtGw6HAYbDgruvt+rBytIlrr9za
	fCE2RoJQhpHlhhQcaMfcZPKD87q5XlAuzZOdhnC7avyif6HBkU/0
X-Gm-Gg: ASbGncuOcN1AyTeYU2/RjunvOW8mEbbGPZgBWKSc/8CuVoqc00kH/x7S+2lhJ/q2TQ1
	A52u2x+YsGswojvUo96Le2xuCCqW6BdZsiMyUhRXiEXD+inZKdrm53RGMAjYDVqcrU4Ll7ljePM
	HK4NfdkLukwJJpA49yaNpjhHbL0DLI4AmsKN/6+5huDWPjk/k+OXhmpkm+lnZzd3yO3ljQC6dF3
	cIrWQfC65bIDUiVZKgm06Ls9eOoKHrLEnBXZfov7ZTMjihr7sJ+z8trnQScxIuoihe1zit9z0+T
	Wn2tAQ==
X-Google-Smtp-Source: AGHT+IEdjgouKib0AgPMWaDFmEfAgEr9C6RElTsmJmpV4mqrKSx/ZKTXzalOVkAs5U+y1NuhW4XL5g==
X-Received: by 2002:a05:6512:a91:b0:545:2302:6835 with SMTP id 2adb3069b0e04-5452fe2e483mr1689683e87.2.1739723265540;
        Sun, 16 Feb 2025 08:27:45 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5456468c28csm481835e87.122.2025.02.16.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:27:45 -0800 (PST)
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
Subject: [PATCH v3 3/3] ARM: tegra: tf101: Add al3000a illuminance sensor node
Date: Sun, 16 Feb 2025 18:27:21 +0200
Message-ID: <20250216162721.124834-4-clamor95@gmail.com>
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

Bind al3000a illuminance sensor found in ASUS TF101

Tested-by: Robert Eckelmann <longnoserob@gmail.com>
Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
index 975ec24195ca..fcf3d6dd64a2 100644
--- a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
@@ -1123,6 +1123,17 @@ smart-battery@b {
 				sbs,poll-retry-count = <10>;
 				power-supplies = <&mains>;
 			};
+
+			/* Dynaimage ambient light sensor */
+			light-sensor@1c {
+				compatible = "dynaimage,al3000a";
+				reg = <0x1c>;
+
+				interrupt-parent = <&gpio>;
+				interrupts = <TEGRA_GPIO(Z, 2) IRQ_TYPE_LEVEL_HIGH>;
+
+				vdd-supply = <&vdd_1v8_sys>;
+			};
 		};
 	};
 
-- 
2.43.0


