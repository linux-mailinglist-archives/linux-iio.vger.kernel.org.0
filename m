Return-Path: <linux-iio+bounces-15671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C86A38565
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B0818927E3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5811722259D;
	Mon, 17 Feb 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdv2T8vQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D75221575;
	Mon, 17 Feb 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801044; cv=none; b=SnC9jrSSs+2T7cr+GYrCeIqM6UquDutmTHmVFyi3ayxWuu19bzPBIy9iHmNaKoi0w0IVzmFp4xZ5Vq3vkCRiZ12XMCMx505Hs4vcb++cedfZ7i9fxESPXIe6Iep96jnwBMOgizoEypM56HKmzY/qYEk9Gf6X0++7coHEGp6PJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801044; c=relaxed/simple;
	bh=9aREkL79Xsxr+96x5qn8It6s9YMe1H0v50kaLPRH6JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2sBy5pqrFQAgqMc2J17aTza+2xQtfHKVxfFP2oS1HocVZvOqsd1dqPxK1zFF6ZO514MTLX63Nrm5npcUZ+L6VOAZ0jIYb0T5OFoM+2K7D0HpE6J8HIni/6yFBdzIfLxaEiKrWOGBZ4EXESru08W+dg0a7Ub+JGCu3DliZTY9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdv2T8vQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so2704842e87.0;
        Mon, 17 Feb 2025 06:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739801040; x=1740405840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wiMhV2MLOmdVTuzdxdM8/it2VeMkuWUBOlinnhDCGM=;
        b=Zdv2T8vQ6g+vXjX0iy+U1eFUmxp9Y+lbt5r6+ynbQV90PfBWJfkGo0p+w/X+cjGVCC
         rvcY1gEi6o1I7WRYpxSMkKkyHMAJ9r/9HaF4YGFMt4NziK7MIr7GZJKjuAm79aZmSoAX
         IbQft953fpDb0Idhu1/sLzQv8Pehw24ukJ8CxzUX0UEjyAgV7pSI50seyRAZB6RvDv2U
         Dddlht+gTrn1IUNEI20qS6XRxI0RnYi+2ckMBfxfG5sk3lFimXb0dqePfrNtOmyuJoNa
         foyOgSlVpQky8hMWTodNUVYjJu7746EXB1Qp700c8ma3hul7bVZwxLtPC0F5QRc2ab8K
         7Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801040; x=1740405840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wiMhV2MLOmdVTuzdxdM8/it2VeMkuWUBOlinnhDCGM=;
        b=nBIiJaIwRxWK79+GpnJ0k1hIiBd9yrmFepGPopW4GFji8713mouLz9n2hlyPvNmjCK
         fF6LG6f79BAtXtbPKAqfoyoS2+mr50gRj+3655WOlkaTBOmfYa7Fn/H8+i/SJ2IHyYK2
         IAwkdMmfZ8kEHm9EYAJQJkjYRh1MVoJgpy0BE4Qe6j/uXTKY9bb4/YA/6CPZfgzRs4vl
         IjJsh05bi9P/N9SZ5MqmNzZ1DjbRI+mtyTisod1ym7WPB3zrVaw7/TnlZD3aMvfEsHl3
         61NM85QnhIX0z5M/NxIgAN/sUd8UQglnmCTnzMHhaM5z7gOEtg/+asL/Rp0oj2sIG13M
         sQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUFfY8bVWh/JQWjCOacgQ/EtTgrgr6I0t0Rcr6heIDJOebJKe81qEnIrGKvFQdPr6KIkW8z4u2VG8kH@vger.kernel.org, AJvYcCWeSbf5k3poEfrkQbSFRqoKcR+bK7dTjYHV3bZiwl9rB7djvCF1mPD0TCKsgfpVrHk3v3NtbI1G3wJzyIo=@vger.kernel.org, AJvYcCXQ1hZM4V46gyNuNWyoujBLC1rRRyMVFfKi4W0dLEET93mMSI4dajubFsrL2WKBLBkKW2ltHNLO0sX79MGL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dPbqWewTkwa3umw9f99SpP1L+KxE2lui4FwcVK7oy5kgBILc
	i9npU+06pnUAdIEQTLODqC82MuC/oEt/Ki5sl0fft2QUsCR6LhXH
X-Gm-Gg: ASbGncuxkYcajfWlDGA7p2gu6tLIKs+XhtFWZP6LsTwxOMxrmf5f+LQE0LCbvOuaHJv
	augYgkH1tY2T8WTI4C9Ko5AzRoFHmUP12nRWlUm2W7yKLXVx0VA+0KX8WAmErtwP/ODJsl/HA8O
	2Kdy12wc38hezeoI7eA/guWeDyTImmefgPnec9JEyPRe9i24dj67WyWrQCr8zjcgawY6HM+nrFd
	eL40jxSDGthZlrp5imYXtqGJNB9N66wPt0l7U9pS3ocWqaRNEGKyAFD9I2b02Dqhj00ZKzBqmKg
	H+s2vww=
X-Google-Smtp-Source: AGHT+IE2I2XaCaDXYttBWppjwztZE3XPtmV+/ckyma+vkI0gasU124OBkpUB+WCyZpcQozD76oi6mg==
X-Received: by 2002:a05:6512:b12:b0:545:ea9:1a24 with SMTP id 2adb3069b0e04-5452fe2e78cmr2849929e87.14.1739801040284;
        Mon, 17 Feb 2025 06:04:00 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309306d5f48sm8919601fa.57.2025.02.17.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:03:59 -0800 (PST)
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
Subject: [PATCH v4 3/3] ARM: tegra: tf101: Add al3000a illuminance sensor node
Date: Mon, 17 Feb 2025 16:03:36 +0200
Message-ID: <20250217140336.107476-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140336.107476-1-clamor95@gmail.com>
References: <20250217140336.107476-1-clamor95@gmail.com>
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


