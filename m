Return-Path: <linux-iio+bounces-24989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C17BD088A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 520DB4E4E87
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4072ED855;
	Sun, 12 Oct 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRZ0NBWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790682EC097
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290262; cv=none; b=lrg+7/e8rj76kdsqQtXVQt4O5nYcgtKDIPXFVTVu8TDFDJ47S+A1hTgDE030gVGB20e3oCoqU0AIlllw9JukuDoQXoiSDaJIxu+o5xPrJU4dIL13leQrSFwkxcc3IPVoF+qhFX4Oxuy3kWEBCY4NFzGiYIntUF99FqeV1w+PNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290262; c=relaxed/simple;
	bh=ARkCzPQRazCvQ8f08+IPMyTBKBhnxWBajxH9X4PKlgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4/N638dM5BzyVGXiVc3Udr19ag+OnBt6Au90kbk+fZ/B/bdzvWpHo8nmSIBz842IyrjX3WXzJhhJoN5D9sA4Qonx/u3Z16H534Y0C0tJ3t0Rrl0rCg4Ux9G1Zdgc01IpMhMWwvmRT6xCXbAd1dPdemqpErIRBzQqJdlq5Q/oPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRZ0NBWH; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-793021f348fso3104280b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760290260; x=1760895060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJi/0aYLKJUb+ptER4OpoR5lNkPbRGPGuiPKjV49HE0=;
        b=IRZ0NBWHF/9aknK+mKO5Urw7Sz7TjS31E1tTHlK8OAW7N78aSr0CtDk015tXJ9Ccis
         3T84pkuI8R01pZ2ojn9CoZ0bxF0jEhv4qzo42ouX9bPd8j0Jdmjv0LAodEv7DhjEY205
         uIP34t34MMAKM4gXg7pqRtIv5CP5qA6MNgfqugyf4IAWcqxluY9kqafoR8oiKMW6fP20
         hCyeqvX9quwQ8zZviX+l1FizjHHoL9dtPgNfyIgDphSmuSsf6uYlDjGuNuaxd7qsl66U
         aEeheveowajuzENlQfAxulIx37QHGZlOmeuHBaJtbyNLG5OcWdYlOuv7OgTkF71mYtgH
         W7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760290260; x=1760895060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJi/0aYLKJUb+ptER4OpoR5lNkPbRGPGuiPKjV49HE0=;
        b=X0jT/wE5GPCh/RA72YiRyrKac5b19O1h4hZsy8K5+RaSYdary+7Zfql2ZKY1BQzbSk
         4lqnfk0gC0C/O3GJnV8IALcFlx3iZrTQxyWESHLE/+s3oToqisJZNVQKz5jF8KII+zfc
         4ajKIk53HPfgOFwrU5p83VaNA6uHbOgcNaQ3ygB7NTpIvqsb+AmDO6MxtO3uwJrGvpcC
         irSl5Hr8JoL4Z579Zxke4O/KxAc/Lh3ddUeyCXCez3Sb0+/KcFC9N2nmp45NKraRxIxD
         jmqWCr+gMzLzGAnnYBp6sEv0Ol2jO8gm7iG1IFBlfxgnYXVLC1dPUCOYac/s31sZJyWc
         9ipQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLbx7YZ3cEpTEjpHEYEeFblffwwRasr7IArwbKrqo8NR42l8eURYBltWN2UYbrZdLM6PrCUdO2Yus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJoS5TPfbbOPdvP2SvqNqeN91wTS1FIUo3bCZrWS7kIAYRsgp
	+Tz6dyd5Tetu2aQECsEHPqiXyyqbHHc41KIhiizoRIkThJBMFOkg3CDy
X-Gm-Gg: ASbGncvWEA0m+p+ICz98kJ/jk3REMnhBXIOnd2Z/CBU1/FgRXz5jec9gd6fFtUYbp+h
	S6SQOED5hbP+vTd68rA10pisZn2Vx0nre1wUIGkQJcAFKe6jS9jNDNr8dJCd/00hOaRmY0hcjDb
	gpx62dN30UhD0+Ya8bhuSBbZLMAmqCn1NZ5D+bLbyDvw3jrRHvII6OPG+jgHf1QL2BPJUF39Ui2
	kZbdZk0a5x+SSmxQ3QNQX6ggtj0tpN+R0Fx+w1wItHNqKn+t3GWy2rMpAHZKxRmVzkGVU78p0CO
	mldN0Oa0tT+pDMh0mBiROYpJpt5nSU8r+KbfwNK+dU37JHjJi4S8+Po+KQtQQDHZqa36iGNVUQG
	yKA6XHi5DWUAhCwj2An3qzIEiIu8Rj+3oROPfERZ/VRDi
X-Google-Smtp-Source: AGHT+IH6WVw6lNFlaFo8leOVXftMalOkuj/RAP/gLjDml0YRSInreJYPwyeM+ctX/cJcQNamB4qqpw==
X-Received: by 2002:a05:6a20:7d8a:b0:263:4717:53d with SMTP id adf61e73a8af0-32da84627d3mr24963297637.48.1760290259711;
        Sun, 12 Oct 2025 10:30:59 -0700 (PDT)
Received: from Ubuntu24.. ([103.187.64.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09ace5sm9030616b3a.53.2025.10.12.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:30:59 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	matt@ranostay.sg,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: health: max30100: Add LED pulse-width property
Date: Sun, 12 Oct 2025 23:00:34 +0530
Message-ID: <20251012173035.12536-2-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012173035.12536-1-raskar.shree97@gmail.com>
References: <20251012173035.12536-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED pulse width on the MAX30100 sensor determines how long the
IR/Red LEDs are driven during each sample, directly affecting the
emitted optical energy and hence the received signal amplitude.

This parameter is highly dependent on the mechanical and optical
integration of the sensor, such as:
- The type and thickness of the optical window or lens covering
  the sensor.
- The distance between the LED and photodiode.
- The reflectivity of the target surface.

For example:
- A smartwatch or wearable ring with a thin glass window can operate
  with shorter pulses (200-400 us) to save power.
- A medical-grade pulse oximeter or sensor mounted behind a thicker
  protective layer may require longer pulses (800-1600 us) for
  reliable signal amplitude.

Because this configuration is determined by hardware design rather than
by runtime conditions, it is appropriate to describe it in the DT.

If not specified, the driver defaults to 1600 us to maintain
existing behavior.

Tested on: Raspberry Pi 3B + MAX30100 breakout board.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
Changelog:
Changes since v2:
- Fix DT binding schema for maxim,pulse-width-us
- Remove maxItems
- Update description with additional details
- Add default value to specify fallback pulse width when property is omitted
- Remove redundant changelog from commit message

Link to v2:
https://lore.kernel.org/all/20251008031737.7321-2-raskar.shree97@gmail.com/
---
 .../devicetree/bindings/iio/health/maxim,max30100.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
index 967778fb0ce8..d4753c85ecc3 100644
--- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
@@ -27,6 +27,14 @@ properties:
       LED current whilst the engine is running. First indexed value is
       the configuration for the RED LED, and second value is for the IR LED.
 
+  maxim,pulse-width-us:
+    description: |
+      LED pulse width in microseconds. Appropriate pulse width depends on
+      factors such as optical window absorption, LED-to-sensor distance,
+      and expected reflectivity of the skin or contact surface.
+    enum: [200, 400, 800, 1600]
+    default: 1600
+
 additionalProperties: false
 
 required:
-- 
2.43.0


