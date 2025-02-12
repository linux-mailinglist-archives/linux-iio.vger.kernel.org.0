Return-Path: <linux-iio+bounces-15413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A56A31F69
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96BA3A99B4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2EE1FF7D9;
	Wed, 12 Feb 2025 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2uGZ1+2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032151FF1BD;
	Wed, 12 Feb 2025 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342866; cv=none; b=u0+ejwUB4IbaHlXRwf4He6olA7QGxUDzJ6sBPtJiHk8LXxrPlZ8HAXxNkcaY7H4AXZqOmviaAgaNDvAsOPJzwGQZvVkwgTty1FfVE444M7O1p4lQZ3YZMDqJtuVkXwkiQYaL2JxWUH5CKNh9ZK2SJnZA536s6QoFDgonHIiDfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342866; c=relaxed/simple;
	bh=ovU/udmsQruAG4JxrqrP/u7hpQFzVvlamOYHihmO89k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ld0ksuWMskSHpy6LepertjDrpL8UKyaKU7HNQlD9//+ZsF4CCl5xQARLv7eMJ8qciOmOHTgaJKCe73q5j1VlMEyRuTLFGZ3q5PplLLi5T+eAeac5vZqgOc43Znwyc9ion9aPSB2G90UevamkFSd+qDL3d9P2rXWs2f/iJ37kBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2uGZ1+2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450408455dso4573605e87.0;
        Tue, 11 Feb 2025 22:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739342863; x=1739947663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6NGjbfzadf2K5Cwn0Cq99wst66ulH2eoNJ3X3i+jmY=;
        b=a2uGZ1+2aEMsMaAj0HPm0tUE8PavWZ1hhnLjH58Mppf4vc6u+zwM9iVQR3IjOKt25m
         uGbqwtqukKyrijNGbEgTfBE3x7O8CAE1beCS0XjnOTzFaMqHwmd2NnKh3mhlECoCZGyL
         +znKYHgar3gCpAkMbXAeHLUGJ6ndluIG2djotIZnKiIghyCJiH87YW5RCKNGw/3hWFe5
         gOcq21q8kpIB3A4JYk3Dek+HjghLeXrIEcjOYORM5egvnlB2QwCm5U21bDPbV3flvznO
         3P6jnfhK+IYeJY9enGmghhfauqYj+6xu4kQz4vXhmcBlekfo8C0X7jooxcecIEJiMDHf
         82Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342863; x=1739947663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6NGjbfzadf2K5Cwn0Cq99wst66ulH2eoNJ3X3i+jmY=;
        b=p8aDgPBQfTvZjIgkRR5AMajtbUThLKGtP54wSyIjuJeYC0sfEQuU0O2uSl4tEprxRj
         7Ih9LQSHumEQMZFJU0ql5oCnARYTeoMhvM7aeHN595UuAJINDMNWZq8vTrBUcXvhxKa0
         4lbaeBolgd6QUguA5Ne+YbfoFdqal5LWc5dI65/Yjt/DT7hto30Ft5WSn0pHb8nDjjAB
         IspsuA6o6/eTd2NC7O9QLmhbozeGcpEDsnsmmIBkWQs/by/qx9otEiPQWZAv0YILwT1H
         PoFOmAQFucRlXUEZ7s+elxqGnc2l7YKq+dyMiP5C3keVlKYTCV2VGxzz5WKEm8FgWO/4
         SWlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+gIY4YZWkVAtFp3nr2wc1A7lttPJN/GnOmHXBi7+urE4TKdTPIXlphQfpscEYEelpQVLNYp7OuWVHpQI=@vger.kernel.org, AJvYcCUefI3ZblljGGMYhW5IHBU8tJTNJjUE/Y3jlA+c1vRdZ572OXdUN/l+wVnXv+ClW9WZXNtbBq4xGHWa@vger.kernel.org, AJvYcCWbs57fv5VjakukMngxvUHvU1mh5NbuMIeXu3z2o+o+AosZ/YlLoVk3vUU3uR+72m0fmNv3PBk+aBu/9gX9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KjoUBMM3uLmJenDXuEf5XdM0P+EAN69WQ0rvBLUIqdeZtn2v
	1kAUFUioCZc3dkgA/9QeTsmCPK7B+08ms5+t05beTP0v+HeEWwdZ
X-Gm-Gg: ASbGncuXbu0ovXdGPcd7Iqk0Z6HmPUYI0DUIbiDHGvhzC0wRQwQDR4MIuRxazgbJjG8
	5RAqWCu9L4YU/4D2AZRHrELMKnwO4W+MteSbz/l8QuiQtq8GQrudfl/y8DPj8AKAvcqHnYnN5oJ
	uKtlOjzHmNrb8xJq0+0lt8hKTu+kP1NoIKRHQcAQILkkoeQmk/95ozFKc/IFOZHnFyUyfYQGrop
	ZT9sNt2QEIUi8vgWqfIw05c5Hs7Xz5Hwm1PJBZsBJebIaxU8PT8ccAKVtasjo0Vb3YNmNE6XwXu
	YA1O7/Q=
X-Google-Smtp-Source: AGHT+IFmLXpB5BtWUTLh56HMNQRGF3ZCTxYlUO3FcBClfxvAp+XnImAN2NNoF7+jXL7C3b9XpA9nJA==
X-Received: by 2002:a05:6512:3054:b0:545:b49:f96d with SMTP id 2adb3069b0e04-54517f86bf8mr570289e87.0.1739342862926;
        Tue, 11 Feb 2025 22:47:42 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450e09e9dbsm748600e87.120.2025.02.11.22.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:47:42 -0800 (PST)
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
Subject: [PATCH v1 3/3] ARM: tegra: tf101: Add al3000a illuminance sensor node
Date: Wed, 12 Feb 2025 08:46:57 +0200
Message-ID: <20250212064657.5683-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212064657.5683-1-clamor95@gmail.com>
References: <20250212064657.5683-1-clamor95@gmail.com>
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


