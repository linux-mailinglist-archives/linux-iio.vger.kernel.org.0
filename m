Return-Path: <linux-iio+bounces-13871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6F9FF19D
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 20:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B4F1882482
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF681B4157;
	Tue, 31 Dec 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Kdebdm8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A41B0F35;
	Tue, 31 Dec 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735674161; cv=none; b=JHZF/3/rj2IgN/y7B/khX/jTWPNY5Ih7GJfaEhcKdjqjxQ3/Dg+SZJSSKFuyZdojHvkKdidrmPHAUOS2PM1oAtFn2tpAhSwDTD3bnNDPJFXrKI2DGF/eGcpnG84PNXtNXS5SQ17XX/8BsP4hY+CcYurOb7TjmwTUktCoAsSw0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735674161; c=relaxed/simple;
	bh=9v2/6N4wr7PRMWJ1LvsyBazBj1CpzuVJvhzem1a6nPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYlJUprkWVddLMziC5xr4SmOfgGU9H4/pTEyLfVLUFKKM8LHL/ZKWQznrZHZi9s+JAGt3LvJUH5FcmmVZ/DfQleXN4oOi2I8v0oNmBGU00Y+m0IjEVN04+GLTnwsR22U/32LbxKbXU7OL4ruFYcbNsYmB5fMYD+JOygFw+Ak4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Kdebdm8E; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d84179ef26so14277083a12.3;
        Tue, 31 Dec 2024 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735674158; x=1736278958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJabEfN2+g9M0aZrQH6TKNJnrlyzf+4a+JPNv5Pd2e4=;
        b=Kdebdm8Ek+tuYCpj1WIP97lRpTBBqrkmOuAB2aopRZsejYJIlysIjoRf/qiLNFMwDJ
         wsBvs+29iRJ14vlKZbTIAvlw1eCj4WEz+JJuU8rNK0CPUCa2SWRiYQiZNKVhnaV8imC+
         f3WIL76O7+S1+iLA9Ib8ZQQ94d5D6M0IhXp5Mu+J0AqimMXVk0ar5ZQfHY1IYSp/8AJI
         dXq5+lEf2oCDFyQl5fEOZq9gr3pZzkokyBdp8l08wDUY1IQJr8UXSEH9lhRmQ02//LJg
         ZUQh7R+WrJWbVVFaZFWIzaMWOFkFCWSgbKBrk68W1wh5xZA8Fx+6A0fdCwXUkSNUtil2
         K0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735674158; x=1736278958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJabEfN2+g9M0aZrQH6TKNJnrlyzf+4a+JPNv5Pd2e4=;
        b=rJ+sL5U9VNk2cN5SU5PftrVNJw0m1QLC6Vmae6wao56OLXSV285Kmsr4TQMiebUTU6
         5OFmH2NL6sbZbAaHF5kA7C5vxCdgdwLz/0/w6vi/M4ud8p2Ewr+L6yKqy806cy5iuxBX
         khpDCp9z2swJ0+ECbOPhgBgFg+O/IGrjdtndoht7hF1/M6qQ+hzdZzXMrm/vc6H8IYkB
         b8WCVtWIsyOxa6HDW7jV2voAfFDJOATqS4hBFNgT5ZwOMJwqhR/M/4LqAKggQe8kA6Fr
         fvNT1s32b3Le0g6VprErOCjBju+3AFyMsww6Okh2GFAy6QCWNAEVFs9fsOejXsn+V06W
         svZA==
X-Forwarded-Encrypted: i=1; AJvYcCW8iWQ6IVsfc2urMJBrhvn1SQ1jGddN7loWHtyUFI/NUzkb6MzI0lKbXTA1fy7mPH9UwH7gsQZqH+Q=@vger.kernel.org, AJvYcCX/RWmQ+gNSHB84o6I88peZ3nXpzSwJkl2C3IX1ueuTB8lq9gP5HGwIJVBEGTEFl3L7HnJcmIO6Bp6056rP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyv2GXMFh6qvYkhhU0Ey6Fe11QaM1tsG37DP4x8MqMP7hNLpjF
	hVPRDDZ0RmCbplSUPncRQ2Kcszxq6YitT2Kq3iHk2OUUd86dYTV6
X-Gm-Gg: ASbGncsu1p3Gtdgd06FgwRPvnAH0/BVb/b2a3/uBjDiGEDe+spjxp+3SR/xXA8x6wyo
	Ukaxl01tXqoMD0T5epdH4GMWW5mjA07L7T6p/SBJPmPh5uMF8sQFE9iz+HkzZm2Z0s+7YwhIEPB
	8asIKbTi6GwC8NYwy5eMevbaXuCJaZy9r3aJaHO8oy4VMLtjxhoFhMNFC0bZX4ytvn1ikb6WN2R
	lEO3aprjy6vTN6a9phjCR6JoduZaHlyLKPEMPwKmHf34PZ8dkrHesjkz6j93NXa5SHwm+mX6IbF
	IfqFVHjOkE2/XcWSTPczATBdioKQ6rETpbGafWwpiughgK3bl2R1tNQJJCgBAFO/n/PMlH9LizD
	gM1PFf/+OYIrBx41wyN+0HLJ8
X-Google-Smtp-Source: AGHT+IGLAO3oHae+wIlk3vvwlaXl9lbUWvi5ye/+DPKWzZhXsRBrXgPATNuW30UHumtg7UgSkV3uhQ==
X-Received: by 2002:a05:6402:4305:b0:5d0:e014:dee2 with SMTP id 4fb4d7f45d1cf-5d81de160f9mr40275201a12.27.1735674157641;
        Tue, 31 Dec 2024 11:42:37 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b300-ce00-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:b300:ce00:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f9acsm16237820a12.31.2024.12.31.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 11:42:36 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	christianshewitt@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v1 1/2] dt-bindings: iio: adc: amlogic,meson-saradc: Add GXLX SoC compatible
Date: Tue, 31 Dec 2024 20:42:06 +0100
Message-ID: <20241231194207.2772750-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
References: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the GXLX SoC. It's very similar to GXL but
has three additional bits in MESON_SAR_ADC_REG12 for the three MPLL
clocks.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
index b0962a4583ac..bb9825e7346d 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
@@ -23,6 +23,7 @@ properties:
               - amlogic,meson8m2-saradc
               - amlogic,meson-gxbb-saradc
               - amlogic,meson-gxl-saradc
+              - amlogic,meson-gxlx-saradc
               - amlogic,meson-gxm-saradc
               - amlogic,meson-axg-saradc
               - amlogic,meson-g12a-saradc
-- 
2.47.1


