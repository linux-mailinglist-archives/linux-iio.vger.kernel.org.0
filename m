Return-Path: <linux-iio+bounces-8611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9A9570D3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2918D1F22A0E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3351187FFE;
	Mon, 19 Aug 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnBFzyXA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDE813BAE7;
	Mon, 19 Aug 2024 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086132; cv=none; b=akMzaQsSjPZKigND9KYUVu/dcmMMVuy0nlzK8bIfH9flv9FsxZL2Wq+0Sk9SnuvNj/cqE/9Llp/NdAqzO0srnZV1dkAnYAAUXH7VrbeIz6dB6cpSmMYia6YlRAjfyUSqda86FAEQ7UCsEjzbd3MRFgpfwrLV1fNT2EFkms9l8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086132; c=relaxed/simple;
	bh=GPNtceU9n0sus1iux3lVcrLHESPwqmwfNTmzMjysvTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4VRTV+RGKqxy6uW4qIbMIkSGtx7T4gRmXFIIFevPGMqPc0ZpAR9CyCiyZsjZIP012WSsUAdX6hnegVmXEsQsuqGs/qf9+Af8rz8zLIYuKSYHQt7OnjBjUr11OdARR/m2LerUAjlVwFwe6Cu5bSXqT/KDSjoskCWgmDhHPA0pSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnBFzyXA; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70941cb73e9so2258124a34.2;
        Mon, 19 Aug 2024 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086130; x=1724690930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mLcghtORtpXHj8P4yh8LryhEIqNeq4orRne8D1uG+I=;
        b=gnBFzyXAHC8MJCOMTj6uBAbwXNTymIZ/wXdNBgGJZ/2CCNViRs0ZR+gT3D58C3aWBC
         NS+noG4I8dw5ymYMwNh7RSPzGqPoGWiiKOhoeL2dg5RFMp9TKU1fSxBTPo4lJs6oNezt
         NeJmygeXEPgHsJ7PO73vedeIoiAWYHtrSCXT581FAsEZpBOZc+XYctgZ61uFl97vtgiN
         UlOt1WN+nYJmQPySe7f5Q8bTocMK9TypGM/7TJ4ccbGNQotrinBYk4ImrZ9cpyKueCSq
         8cydr5qF3vMTAsVfZIGSflCQV2w1uQKOiffBEfuFGsyHnUZnLMvCk3us08575DmOa47r
         cEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086130; x=1724690930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mLcghtORtpXHj8P4yh8LryhEIqNeq4orRne8D1uG+I=;
        b=iO5t9F4mjbvs8wtkec3ocGMxtsvp9A5F9Pe+g7Dnl0nSsP9fHQuAPN+RBHGOwa5qod
         b1ArxD1GXdxW6uiR+PVuUFTNtGBOtf1fFJmdIO6I6TV2BOKdprhpi0WL5jWBSZCGIBfr
         X0nFA+9q5zDCv39ENIYAZvdbNERhnh2epVmz2QsCq4iXSLzng3DqAiUgcbZiKI867PWg
         FRp7EBwg51wE8WAf92aYGCfTUTjWOeRWTVcOUnVXZy0avJrRpEinKbmf62YXOi8FY78Y
         xRJFhQ/+TRugRxFCAB7zsXKbdgXdKnblT5zVgwHcUttiW9cLpV8W0zw5PlRI/Bi07u1v
         F9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpuNGUSd+CdwmGw3aQqNtPgHI31AJTU7EYpyAIyjFRIuv38TVC7e5zy0qpriO29GOSIkuZIlh957C7gSsFGAg2lE9GS++yO6oXdDS2ezcI40Exkc9vEZqpHnwJ4xKi23pC+gKClA==
X-Gm-Message-State: AOJu0YyQPOOD2uGzIhNQ9yfpfCNNbGVdVJINJwTw48XLq1nsMC94bTQ1
	XukrLqH+389y296a7nsd0v/NEVm3X1iD80PqWoNwrWDzTtIWMh9I
X-Google-Smtp-Source: AGHT+IGp0ZQPhwFlK9c0BFOFa4wuvrcDIPz31Bx64gvzmcJWhJHbsHHHQ++VNkm4g7m2Xj8Yo/IWaw==
X-Received: by 2002:a05:6830:440f:b0:703:64c6:305b with SMTP id 46e09a7af769-70cac8491demr14520708a34.2.1724086130315;
        Mon, 19 Aug 2024 09:48:50 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:50 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 09/15] dt-bindings: power: supply: axp20x: Add AXP717 compatible
Date: Mon, 19 Aug 2024 11:46:13 -0500
Message-Id: <20240819164619.556309-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the AXP717. It has BC 1.2 detection like the AXP813
and uses ADC channels like all other AXP devices, but otherwise is
very different requiring new registers for most functions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 9cc300e78f60..0a3b3d743d71 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -23,6 +23,7 @@ properties:
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
+          - x-powers,axp717-usb-power-supply
           - x-powers,axp813-usb-power-supply
       - items:
           - const: x-powers,axp803-usb-power-supply
-- 
2.34.1


