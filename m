Return-Path: <linux-iio+bounces-8154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0849463C0
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B23B223F5
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883BE165F09;
	Fri,  2 Aug 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfZX7GMx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67B165EE8;
	Fri,  2 Aug 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626576; cv=none; b=nmaiWfxm94D8IdowC3DLTSIJ2DM90nya0/Obj0ZYyo28P6VaVgdpiblZVflbpb24Onf3fmyrsFoOQsjRiq8CFjS1hLD/tvZiVTbEXJcbK0NjmJ67gL5NmvPWmh+IvWX8To1/KGl4DjjqjVu2DJ5wxrnW7ukEV2XDkwxgQOUaCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626576; c=relaxed/simple;
	bh=CwabAuQrozbIc2WF23RTg7OF1MIHY7LWz/n7DhKVozA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXFa9vpIRSgUjQ2RiFn96us5m6MAUaWmzr3X9Up3yYJaNV/wIyq7HCbhREIYjUgIqGP74A3uLa//haTMZFJTlD1bvi0BR5zb7Q8ZUp42D74t7Uukj4VJylKuoo4GJ7b4CeBLnfPbl/nkdLrVokXAaIE+7BF1X4gvSN92RW3icV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfZX7GMx; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db23a608eeso5595786b6e.1;
        Fri, 02 Aug 2024 12:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626574; x=1723231374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKF6Zi/1m6aLjcN04yV3BkCZRPPdlRv2r0+D/Gsd088=;
        b=DfZX7GMxCkGKOuTquM0Kp9yeujM+uSZqcu7RDeA+oJPSklUTYdqAmMgyIihJ/exEmT
         34dUmhpjPctPyp8pZ0vfJv1E0ckfyT7UPVRaPLhQwm9oa7g5iNPA9CfH37ML0jWbSdVO
         zKj2kVnIWmOqE/qSkQL5jltdSzidtnLcsxDKRWUl+uQxGJcLqCXPsIWYFVtxFvKAm578
         qerDATZHXTwz0J+zBueZIuo17Smas0CemUSoK26KYVOdpsEaZbkdoeHYmKFRW0KSddAz
         L6CcLA6bgtlZgAuvpz15NxprkMiO4uv93l4zuPTnfeZohG1JtGks9o9kLSjzCIKxOJef
         gEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626574; x=1723231374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKF6Zi/1m6aLjcN04yV3BkCZRPPdlRv2r0+D/Gsd088=;
        b=C0Mrx4SxnV6zvk518uZTLf5ynx9HojU/qv1puEIJUKo0Z82A+6pzufv4rHkd/AJs7g
         UpalBsLXf/f56PadwL144ecXNKO7+5QCkLhTDu5jALmGiasMhkSnhtCZXwS+1Xb5OXQg
         /Xl3hrOkqvwExSTkJGO2vMRFM2QsCIgbXh3XoAGWSDolPG5jAWiYkNPrPALF+U5p65Jr
         3exU6Rvpq3W3VyEFpGmde8MWZtKxS0waK5vV4+RrSFAUVNjrrE8Eg4Kl1dESTggfl8yB
         dEhlbIbRxlg4JcBf+VgdXRILa07Zs34sOKhg491PTvM76frqPyUgTmo+SvmZ6ElFYj+v
         /0yg==
X-Forwarded-Encrypted: i=1; AJvYcCVPd2u3MDF11i7l6BCsDYmOu64W0Ky7oWZUoo2v+GYr8m9peHIJzWIx7S3zbKuIK8nvofK9BjBP6yo5zPJM87qmS07CaZQvrrlosyqlDtNX1Mpry8HyKI8qJ98Gc/3rL5bxmjHn4Q==
X-Gm-Message-State: AOJu0YyP1FRC6cvJg7tHqjzBU02N/ac9NT/qbEBXzjL3+Uh3vQnoaUgn
	hmtb8jkHp9VitX7+h51L027O1tHOtFF8l16Y7FpjC1XkpiRXeNMhRVsvHg==
X-Google-Smtp-Source: AGHT+IH1wc5hz1GvQtj4riUZkn6QJtAKThKL3VwHHxx5uvWODtXToZinS1qoo41MQ31LwphZAMvO6w==
X-Received: by 2002:a05:6808:3094:b0:3d5:802c:9056 with SMTP id 5614622812f47-3db557fded5mr5335578b6e.2.1722626574006;
        Fri, 02 Aug 2024 12:22:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:53 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 05/15] dt-bindings: power: supply: axp20x: Add input-current-limit-microamp
Date: Fri,  2 Aug 2024 14:20:16 -0500
Message-Id: <20240802192026.446344-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802192026.446344-1-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Allow specifying a hard limit of the maximum input current. Some PMICs
such as the AXP717 can pull up to 3.25A, so allow a value to be
specified that clamps this in the event the hardware is not designed
for it.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../power/supply/x-powers,axp20x-usb-power-supply.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 34b7959d6772..903e0bac24a0 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -31,6 +31,11 @@ properties:
           - const: x-powers,axp803-usb-power-supply
           - const: x-powers,axp813-usb-power-supply
 
+  input-current-limit-microamp:
+    description:
+      Optional value to clamp the maximum input current limit to for
+      the device. The supported min and max values will vary based on
+      the PMIC revision, consult the datasheet for supported values.
 
 required:
   - compatible
-- 
2.34.1


