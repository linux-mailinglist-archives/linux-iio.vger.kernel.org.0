Return-Path: <linux-iio+bounces-6435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A390BD49
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEBEB21CBE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB4199E87;
	Mon, 17 Jun 2024 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0/1wTe0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A2199254;
	Mon, 17 Jun 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661965; cv=none; b=SbEm1nHNcP4F9aEHavXEu9lQyndR8cf37BX78/eWvtZcGpMjhoez8IfK/Q8LJ68AskkJUO/MHfJriQmTyzBWtZX9bAtB3MvKhbgcWkBRdo9K1uRFWHIcZ/x33WRtyB9cz81pdDpaXh+YUDw3EvUgHIyupIMdZFR7gE6U+jSxpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661965; c=relaxed/simple;
	bh=u4D8owzU03JtVL+E5P2c1MwoyOjbnAxavHybzY1+PB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WkppP8MUOxzEwmFEMjI4zAEsS5eblGbxNAGA30l9ssDbdjJTmzWLSSbf7XFH+mOVwHEg7QQm9TYd9YCvAqTd4swKVvuK0E9mNwd7xURwDXF7kgNy51HMWcefatKlUnTaq2CbPvOFA1Ie1kejw6wVF17E2xMeGMR/zHjiDLF5nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0/1wTe0; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6fb840d8ffdso2304972a34.1;
        Mon, 17 Jun 2024 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661963; x=1719266763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72y+9tHAatc4SLssayPtvrq36iX+xSvhsa+KDzNLInw=;
        b=c0/1wTe0LbC04a6jTMXhtJQpH74uh3wUIWWz2pQJ9IHix99XVpR7GPZJaWPQbCkrCu
         TCPX1rjKjTQuqw/Dc3X1KrP4uKxqQiro4HJXgE0JHdB24tbvoF2XELu9cK+Ho8j8H6FA
         ryIA3D9MPgScexf/ECC8kHO1b1RKuqih8gCo3/nCOFEwCMavID/xGJG2WgBhZbMACCuA
         barJADmiI2PG0LywFh+/MZj9W3shq6pASNQkU2U1MnIXqByTrjEZiqQ2xgxip7zPt1cI
         3Prj0rfYvlPa+HNHPTDNQTUdVftxXBuGSL3P1GWxBrlxx8u5oonKZc6WBeux8lwTqKLQ
         B48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661963; x=1719266763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72y+9tHAatc4SLssayPtvrq36iX+xSvhsa+KDzNLInw=;
        b=e1C0OPceCDoXOTOSDJYQmFd35JhEweOeNpRJxIlKje4/wOUpBK3vkARygGINtsCqOE
         t86h4UkEUmEnYCNlxPcggvEsujAqdfvZ3pB4CCCQSWtaQ8h/6oUrc2YPrwDyuFcuX5mC
         wY0R1h8g7+nWA0omtoa7GyO+sixUc4vKUOK0fG/Zg9W35lj3XI7sWAUY818zFohEEMMJ
         voe20hZrRz1faawNzSfH3GBoTLzxWSQPxSZXazMufEVgeH581s1LZbTYmClRy909tSya
         mcaGqot9VzXpVrSxC6I8guXhsQaf1lcugu1TNNcuPlIu0lUH6/BqVN18XIz5enFE8CS+
         E3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXz8jxVMEhG/6OY9NeDsJnEllkSZQZIyf5C0TdkmE0APigJP4tx1c1ngsOw9X5M4di0hsdJNWW4XVXDlichYa85GmWfQBWhWfet6X+z/E3vyrspPhlqkL3j5TnjlroqwN6zxIPcGg==
X-Gm-Message-State: AOJu0Yyb/7XY0sDqGsAK7Wmw+sBdoslhaVAR6+i95kNWa0EbPf7XIgEv
	AMsxWtLaxAPHbgKvaqb9rJcrI/dFIX67u0be9tbUGqx6v7C/wSVf
X-Google-Smtp-Source: AGHT+IEkIdSVBPwRxmz/C+oaPXire0Q9K/OttIwtYadST9Y56jqSPQuftFjwT3ICPganY+BWI4wfiw==
X-Received: by 2002:a05:6870:14cd:b0:255:1bb8:8603 with SMTP id 586e51a60fabf-25842882a51mr12202205fac.3.1718661962789;
        Mon, 17 Jun 2024 15:06:02 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0fa8sm1664232a34.28.2024.06.17.15.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:06:02 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/8] power: supply: axp20x_battery: add support for AXP717
Date: Mon, 17 Jun 2024 17:05:30 -0500
Message-Id: <20240617220535.359021-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617220535.359021-1-macroalpha82@gmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add binding information for AXP717. Also, as the driver can read
simple-battery parameters for the AXP717 and other batteries, define
the simple-battery parameter.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index e0b95ecbbebd..8d6b06117f6d 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -23,11 +23,18 @@ properties:
       - const: x-powers,axp202-battery-power-supply
       - const: x-powers,axp209-battery-power-supply
       - const: x-powers,axp221-battery-power-supply
+      - const: x-powers,axp717-battery-power-supply
       - items:
           - const: x-powers,axp803-battery-power-supply
           - const: x-powers,axp813-battery-power-supply
       - const: x-powers,axp813-battery-power-supply
 
+  monitored-battery:
+    description: |
+      Specifies the phandle of an optional simple-battery connected to
+      this gauge.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
 
-- 
2.34.1


