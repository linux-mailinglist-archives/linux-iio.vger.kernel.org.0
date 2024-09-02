Return-Path: <linux-iio+bounces-9020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06148968DB3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A311C202F9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF31AB6DE;
	Mon,  2 Sep 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm8N0XnR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905719CC0F;
	Mon,  2 Sep 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302549; cv=none; b=a5x23T9WmHPJyQeD3RPmviZA4kRCKr2xvCjxKzstNfuyH0V6rQ80PvCNxRbVjJjRroDlyW2V68k57QVmpT80DTZG7Dr8SBc26b/2yFBtnUOySIPtMoLrgdeYsKfa1AqyUYgIrHRCd3fPPqGcW3m2Kk7XQG2lh9z2zCSO42wWkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302549; c=relaxed/simple;
	bh=bQz9xf+pPGL5OqpltnVBq+aT2KWeee3GSeB1buycUrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nd0riLur83w5YlhaqfhG/uSUG9faNPcdMs9T9CSm5U/jn3DnPyxMzAkqcZtuc5K+nliuhFUX5Nunz25VGhqFGRvJ9f2RV/TX4W1IgyeBieJuY1VeqxwzKFVka6MXi/ONqoSHhA5zISbo1+bdZzG9Rlo3X+Z4+QZr00DIRsL9tzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm8N0XnR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86b46c4831so501679766b.1;
        Mon, 02 Sep 2024 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302546; x=1725907346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr+U4A9LOF3V0B8Uzz63vhDSa3JQBaHfk5al6j/3ezg=;
        b=Hm8N0XnRygZDGQI1AZCFdtKQ37mrAb920VzD8asryguExV9sEXztwFN5zXc7cfZT4d
         4MJANOLZzlTMEaxii0owZQnudjI3f6COGRLWkOb3ZX/iZRlmIdYudL+gdZfFqLovD4XY
         o+7JBMaHhYZHjkJxZi/DLulELcB08hMF/+2FL8n0QMPMdr85vRqaA94glRKFsXLeMk/w
         p0r66N8s6xNYc4VJx9x/tKYa91hdhuj/mIFFQV/YqcOQvhSAyf+I/mVxKafWOYzqIoSW
         cMdHOvF07t+WSR5GNdOkAdKVV1QQmsS41lSoJYaVmsaM0HBM/dw7uECTZnKu7EKUWsEZ
         /YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302546; x=1725907346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wr+U4A9LOF3V0B8Uzz63vhDSa3JQBaHfk5al6j/3ezg=;
        b=Bodt++g5u1d/m70TCBEKOxcyLiG9XhX+I8DGNnZb0f6fJ5/xF7sHSSQzjJSxM2L1/K
         bvwzWrBbs7RJengD/MbrZsRZ0ZthS2PXbHRuhZNqMVFgq3FuyVK8IFYVAq3zTEak0pFa
         K1E8G5QxBq+OCSKv1Rrk2s3YWftFXC58GpxxtIyiuvsbhxJvDfSp0qxjzmB9t5BiBRom
         X9qJOI01FdGw92aQksw0V/3evUf0daGDMOjOtt+KTXGYwJQ7on98eSSPJoxN1d2ooQ7O
         9I+vWol+x1RqbpYlc9QY7D0JRR6tjecTaDqP8MNfspmwY11nF2oEhmDWiqjKPE28aokz
         Bbcg==
X-Forwarded-Encrypted: i=1; AJvYcCUdkOghnKzTmwUfk1klGnu6EFSIxc6P5CE0B4VqG4WE4QwiTHi8SNXOgY+6PcoWBU33dQkm5jGFok2b@vger.kernel.org, AJvYcCVWESzo0A/iNJY6cED8d+4u+WLIz7dBJyj4KpYlyFnerc9P37WwFg1mKRkB1asq5Bo4nhy3Uu5IH2Fl@vger.kernel.org, AJvYcCWpKEifiXSYrskpx6glLWrTTurYcdFtk/oyV1DzRJ8cFev//vdy2Zx8p9KET4z94irgAui5I43ZVQ78eif8@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKv7jt6pXe5Ou5t1q+3tYkMbEeeLWWy824weM5G/2m+53/QQm
	byMoCMn3CBoGEvL+u9PFeqQxfvxqpDIyUzP+99ebWIBH061fFejp
X-Google-Smtp-Source: AGHT+IEsfApHWHAIvZyAJj5kEAdwUo7DC9JxcrGScIPXNWXd+3fSxUYcOUYmxE4/oOZRxOsYlmoEog==
X-Received: by 2002:a17:907:2d25:b0:a86:86d7:2890 with SMTP id a640c23a62f3a-a89d88494e1mr427526466b.50.1725302545369;
        Mon, 02 Sep 2024 11:42:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec0asm590537966b.53.2024.09.02.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:42:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v5 0/7] pressure: bmp280: Minor cleanup and interrupt support
Date: Mon,  2 Sep 2024 20:42:15 +0200
Message-Id: <20240902184222.24874-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com

Changes in v5:

[PATCH v5 1/7]:
	- Use local variable instead of direct assignment to improve
	  readability

[PATCH v5 2/7]:
	- Use local variable instead of direct assignment to improve
	  readability

[PATCH v5 4/7]:
	- Improve commit message
	- Use unit suffix in time variables
	- Use local variable instead of direct assignment to improve
	  readability
	- Use 8 elements per line in the const int array

[PATCH v5 5/7]:
	- Use not in the allOf:int: to reduce if cases
	- Use type:boolean

[PATCH v5 6/7]:
	- Use local variable instead of direct assignment to improve
	  readability
	- Use irq_get_trigger_type()
	- Make return paths consistent

[PATCH v5 7/7]:
	- Use local variable instead of direct assignment to improve
	  readbility

---
v4: https://lore.kernel.org/linux-iio/20240828205128.92145-1-vassilisamir@gmail.com
v3: https://lore.kernel.org/linux-iio/20240823181714.64545-1-vassilisamir@gmail.com
v2: https://lore.kernel.org/linux-iio/20240725231039.614536-1-vassilisamir@gmail.com
v1: https://lore.kernel.org/linux-iio/20240711211558.106327-1-vassilisamir@gmail.com

Vasileios Amoiridis (7):
  iio: pressure: bmp280: Use bulk read for humidity calibration data
  iio: pressure: bmp280: Add support for bmp280 soft reset
  iio: pressure: bmp280: Remove config error check for IIR filter
    updates
  iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
  dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
    BMP5xx devices
  iio: pressure: bmp280: Add data ready trigger support
  iio: pressure: bmp280: Move bmp085 interrupt to new configuration

 .../bindings/iio/pressure/bmp085.yaml         |  22 +-
 drivers/iio/pressure/bmp280-core.c            | 682 +++++++++++++++---
 drivers/iio/pressure/bmp280-i2c.c             |   4 +-
 drivers/iio/pressure/bmp280-spi.c             |   4 +-
 drivers/iio/pressure/bmp280.h                 |  52 ++
 5 files changed, 675 insertions(+), 89 deletions(-)


base-commit: 0f718e10da81446df0909c9939dff2b77e3b4e95
prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a
-- 
2.25.1


