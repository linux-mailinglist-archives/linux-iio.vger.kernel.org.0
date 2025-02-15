Return-Path: <linux-iio+bounces-15550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B73A36D5A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B0316913A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229511C32EA;
	Sat, 15 Feb 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmYQ/P5K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C361A304A;
	Sat, 15 Feb 2025 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615553; cv=none; b=rS7PFDR5B/WKgq78V0sCrJTaMgI6/KJosUkWkURGZSGqZiN3Py1vHOlkvkfzsT+ir5jnyBMG/sLrZQYKbsDyaYJ9UL7NQ8WgJ2StejkDmqrmj22EoJKrM1P/M+c4Ks82LxVsX9XW3vLkYk0cPQYVMgWQsMPOqHYzSu5P9zHqqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615553; c=relaxed/simple;
	bh=ovU/udmsQruAG4JxrqrP/u7hpQFzVvlamOYHihmO89k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcKJgamDukPDjRYCxYXh4gXF44SzUC6CGlvR03adhUaEZdvOhzwsMqL8HHky2+EMrGe12cefodeiGCcn0D0GHa/FMqm4mcl96LlPZUqiT2p+FtVQXf/NdzD2gKdR101EHKbV2mIsZeTDdBrXyDI/sinBqji1+HrCoc3tP9/QgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmYQ/P5K; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307325f2436so23285361fa.0;
        Sat, 15 Feb 2025 02:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739615550; x=1740220350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6NGjbfzadf2K5Cwn0Cq99wst66ulH2eoNJ3X3i+jmY=;
        b=YmYQ/P5K85s4t9mw/JGtt3D4s+NHNMPKbwbsbixWWihiw2MyPW7RAIVc68qjkPPjD8
         6NB8mRh8a76vLXgw//yvOKbx+GSWjmk7l+Rg54EpTz181m731D91ra9T4mEFJeng7twB
         w1GOe5C6svn4KbmUonyChaWBWmOvhIHANAjmjZyGv+nOIUozQUI1dpnwhhEgoLudLhvF
         clNScepR0cCtsv2Tn4a/F2cgOc1wejZq+mmmaC6TMVaMZq/jw+v4WSmik91iHJniFCsj
         tryX4IyF4o2+t1oaHJmz8adADbI4wEvr5ESJATrK7djX9bqN+N0GI+BOvorS2Ag3HDy9
         Ka5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739615550; x=1740220350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6NGjbfzadf2K5Cwn0Cq99wst66ulH2eoNJ3X3i+jmY=;
        b=NS47y4BP1fGXFgsVUVg2hmPxtPBT+ZFDrw9+e5p+LSzmNobQ2OFe5S1VmP1OPxHuR9
         eBnVPKaumaIz0rjk4PmOl6TYjaQzn0bx8hR9huS28qlwlf6YEsEiOrRsb7Eha2Y7w+bA
         yum3IIJ1gJULAmVQG4c35BKZ08CTK/cSUMnrHEhhFMxs8mU8Q3l1aiy3hYebutv3N2TW
         wD2kpda52P9ib5FYFlH1vZP9ZxvtYNZ7PTBbVE48liPnpVd9E8B2NzI55fdVoSn925y4
         yxd5/dOq3/99eQ5txe27Y3EWMPD0cNuDzzkQs1eyMzmf1n6R0Jc2AANLEj6FpW+hYoQV
         LsNw==
X-Forwarded-Encrypted: i=1; AJvYcCUvgBqd50evsOPbarTtAjDfzTsasKs5/SUhxiQDvmAJXxtLZDuT8CFbOsKl5ZsSo9YgQg6jVB5J5322@vger.kernel.org, AJvYcCVBLpQ2Jce47dAsZPsdVepqqRSZH43hkz+0QGwpcInLjhb6rXEbvK6G5fEbquFROhtXpMDfQQ6oAEfpZMg=@vger.kernel.org, AJvYcCVtmAw9MHMvGq3ZCtyqLrbnqTP3yhY8e+y8fByJKw/FkduktYMSLRqemUFyML6Uya1wXgntzWLXFak5B7CX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeuj0RaSMy5O60CFKyPMe0wpWhIMnz79aOTsVs98GdIoGtGIiD
	c5/bHyNs0lMZ6pkgpBLgbumxH8rbvXE0xQcg1FqMMWqjAtq17Yco
X-Gm-Gg: ASbGnctp1mk/s3a8lMfNckyoebyRrxMCr0zfz7cakAWIvEK+uqvOBoNjBTuBjBVZXP8
	2V3duc1tNGJogHnXPGM9m9bY215FfJqxs3j/8zp5+/up88JrztVuqeCa+oTQUZ2TpuUbG3+f8pN
	H7IUa0Ydg69rdCpwR6wnPYoEkiyxQosH/IxMJ1cIkHvSd7YI9UN+zpKXtxgdCQF4OgmC2sRc8k8
	g90m0XEF1iHZGDLEPx2QgnWW4aAO2l5sqi+fEtla1Ja6Jh5PPKjZUi8vYgQoQu2lmr3222b1fgd
	oibodRI=
X-Google-Smtp-Source: AGHT+IGlZODZxzfWnXWmjNedtkY9w+OfCyI2jzRhZXwmK4f5UUnoDzov55he5Jn1/VTVxV0/aHd0VQ==
X-Received: by 2002:a2e:885a:0:b0:309:1e75:65b3 with SMTP id 38308e7fff4ca-30927b26f7cmr9044561fa.32.1739615549994;
        Sat, 15 Feb 2025 02:32:29 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309298dc5eesm2201571fa.95.2025.02.15.02.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 02:32:29 -0800 (PST)
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
Subject: [PATCH v2 3/3] ARM: tegra: tf101: Add al3000a illuminance sensor node
Date: Sat, 15 Feb 2025 12:31:59 +0200
Message-ID: <20250215103159.106343-4-clamor95@gmail.com>
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

Bind al3000a illuminance sensor found in ASUS TF101

Tested-by: Robert Eckelmann <longnoserob@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
index e118809dc6d9..67764afeb013 100644
--- a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
@@ -1085,6 +1085,17 @@ smart-battery@b {
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


