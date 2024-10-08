Return-Path: <linux-iio+bounces-10346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E304C99544D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 18:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9770C1F268AE
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4151E0B96;
	Tue,  8 Oct 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yiy30Jw6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6271DF75D;
	Tue,  8 Oct 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404533; cv=none; b=I5c+TQp5KgmQNqJ9eS+a9HwMcELWvYJac78rOCYTPw0+RGWZ6l5iN5XgnP+ZZUJB5Vudy8ob/2jftJ+t9l/lmtvDnGxhHk4QcAqcKfY53TWpOdpHn7OCtQMs7I9IGurPVMPR5A7rtv3rl8yNDHakgJ3lMLGRfb3vMddMMCJeS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404533; c=relaxed/simple;
	bh=u0Dlk29ojt7FyAYm6TPiAOTpdcKAmNt82mSwLKuFL7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O3kQTkMnnFVvRFLodsVieeQPjpcXimTHS3S/ZsXr6JOy/pEYUWL74ZtHWw0vJXl1dyyKnndSB/L9LtdHVkRPyMrLER1pZAcGqPbw6fiTKKYEBJLMM3jwr7i4m8ju0ZCuIXPZOSdCTknb189sV5a49I3Oi2y2l88BRPN3lAlhi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yiy30Jw6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso3838549f8f.1;
        Tue, 08 Oct 2024 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728404530; x=1729009330; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2kK7aKs+6wtV/GhoLl7wKBv9eDb/gVTJx9G+FlyEwQ=;
        b=Yiy30Jw6xnxkyxl1xyZoL3zhWAkxIZ5pvVJYE4Kk1E8SRJAKo4LUtE6sSseds0vGtO
         cMck9A/ij+ww1jG0VYlVPWRrFa4UBlgskrCSaf0W7IdP0OOum5TIYOIyHpsN4mvaavEj
         5yV4hAskGZ3xe07YyTvjqo/qqGkB0XG9AmeSzTmFIOtDZPUAiSALv/FdH+eEzXEDzcp9
         9zOxqhOS1ND2XoVXYvLozRdsztkdm812KeBvGyw422QmHxY/db+hAYDFgHFbvCXX2rUz
         1BcIpQES63YX6J+NRLfWuhWAHlbqVhzPtOpp1eNVIhoMdurM/lWY+HWSDfr5RtTlza5h
         77aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728404530; x=1729009330;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2kK7aKs+6wtV/GhoLl7wKBv9eDb/gVTJx9G+FlyEwQ=;
        b=KXZjV6Tvee1vopGI8yGOA5tCiYo+FQaq8uQB6GiCI8cZPIIl+G9+ERr5yzLl8EY87s
         gvRGE7YTpQ78uDS19NQQt4Exm7wrRsKXjw/YiDKQWmxu9qJskSYDKiRnKwLyFXVMuX9n
         h5VvszlRF/J9JBJVx7raQk9qZ5tzKoCrdvWuEc44oPgAr8ZTbB47q+3tLw8SZcUGE8xO
         rL5ipqwVClELyHRYRFtRExgqJyqCek04rTHp1SR+TWnV9/tnHvV7GI2Ksr6J5U14wONL
         LzE9t/l9J0blNnoQz+0gWcZ7GLPGGTZQfXomnBqtNwC34l2/N2SNSoXD7rHfrdYVbQKR
         QnFA==
X-Forwarded-Encrypted: i=1; AJvYcCXDxTIre3u4P7yE1r8QrQSPDC3+V7Vbm/NZkt+BJEl/m/62pzR8pPBbTqfd2RWng92YQ+sRoEWEoMC6NCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3SjYk18NUEYhDRa73UTibSjr3Vu9NPvadD1d/4p4qRgoyZ8i
	AYZkV/goiVAHcVTPv0ktpJ2MvwY9sxl6K5sNC1F8V8Tip8QApuJK
X-Google-Smtp-Source: AGHT+IHOrQjo+BpaCxZmKEUToky4f2Uj+c2bKffLr/dwHTZhv/IsjtvFRZSKE9re7y3e2fO/eDxkNw==
X-Received: by 2002:adf:f005:0:b0:37d:377f:da50 with SMTP id ffacd0b85a97d-37d377fdb22mr909876f8f.35.1728404530038;
        Tue, 08 Oct 2024 09:22:10 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f2f2-fc2e-cc91-5c72.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f2f2:fc2e:cc91:5c72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f24fsm8453609f8f.1.2024.10.08.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:22:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 08 Oct 2024 18:22:07 +0200
Subject: [PATCH] MAINTAINERS: add entry for VEML6030 ambient light sensor
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-veml6030-maintainer-v1-1-701accdba961@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC5cBWcC/x2MywqAIBAAfyX2nLCW9PqV6FC61UJaaEgQ/nvSY
 Q5zmHkhkGcKMBQveIoc+HRZZFmA3me3kWCTHSqslETsRCR7NFijsDO7O0NeKG2M7kxL/bJCLi9
 PKz//dZxS+gCNPI4OZQAAAA==
To: Jonathan Cameron <jic23@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728404528; l=1088;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=u0Dlk29ojt7FyAYm6TPiAOTpdcKAmNt82mSwLKuFL7U=;
 b=Q0tRMZY5Tx4xA2sCdaFdHz7g6DV9lGJIeHVsKk6M3eTLW7spFPINWuDYHPoigy6lBiWCzqg7G
 Sv97ASxsf4iBtV4EauwydUZvZoU4tFKF5iW/5EsXb3LAgWV06KMPZmV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Add an entry in the MAINTAINERS file for this driver after contributing
to it.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Maintenance of this driver has been agreed with the original author,
who has been added to the recipients.
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed1921f6bf2..7beb8e6656ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24732,6 +24732,12 @@ S:	Maintained
 F:	drivers/input/serio/userio.c
 F:	include/uapi/linux/userio.h
 
+VISHAY VEML6030 AMBIENT LIGHT SENSOR DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+F:	drivers/iio/light/veml6030.c
+
 VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained

---
base-commit: 33ce24234fca4c083e6685a18b460a18ebb5d5c1
change-id: 20241008-veml6030-maintainer-4cddc8d7e9bf

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


