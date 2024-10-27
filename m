Return-Path: <linux-iio+bounces-11401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87EE9B1DAD
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 13:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8774281B4E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498AD15573A;
	Sun, 27 Oct 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpqyCvFo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12420210FB;
	Sun, 27 Oct 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730032023; cv=none; b=WZ7KYdjFIr0froR7BOY673azt1cIo/CVRJ6I7V97Kt1m9Vjlth8BA4aNU3JZe7FKPOoe5oe+2CqSczwPE0NcT9Mbz6wDlmjUKfiE/iNIu243sGFct7YrnnOrET3a+nWZbcN45PzCBt8CzDLtcrSUaZFTHwIVplu2PrkmL+/izuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730032023; c=relaxed/simple;
	bh=2VfQ2wflpZ8ggu3Rv8nU1yTN7fzoGtQvbu+rKsfAeS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hazEnoAgMB+nwS01nQ3OtqQSDXGx1DxX2GwtTmAadl/ZJwX73FUi7Pf6hLyfGQlkjvb21stIEQOJVY1oX9fYp77CHl5Wb4fp7NLb2OY6hzQovBKyDbLSlJuQSxEAhPMxSSBEz/lxO0hyN5AC3Lu5+NSIc75FBYdBe1e076rRrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpqyCvFo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d5689eea8so2351020f8f.1;
        Sun, 27 Oct 2024 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730032019; x=1730636819; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUox4fpqeo/zDddrp/d5ARvM/uTsS9cEvM95lpoNCeU=;
        b=EpqyCvFoG1pUDmNns2s5cuG4NSxmPTGaGQHnLeoMctcCGdHJMJZKn7kPdn9zmdnB8A
         +9X657NfZWGKjH6i41iemAM1Kk2D7Q4J+2lvKmehBqCvYKY6UvIAeX0zkuJ4giMF86Kr
         Im5bycZTfFSlcrlWwo1/9cVrhjRHv/l1NyPYPPcWcCSnXKCr4whaqD0XeolWycQFl3lt
         8c55nwX8gPvGvlsbE661dyhXxi7h4+cGg+n4ANki2/e4FzhWnYn2MS1NhVyLnCOFDZeT
         Wsc0t4UHPfig3UlzamVhRVT1bQtt8BDyoraEnl7ndyQs4TiGu6DppUArvnXef+tslsaH
         WYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730032019; x=1730636819;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUox4fpqeo/zDddrp/d5ARvM/uTsS9cEvM95lpoNCeU=;
        b=rAjuqMq6pvTHyaf0KUwGLNrrDICTqkrnVV6RkqWBW7oBgimgm92MLXFVlEGsRIdWLZ
         rrDFhKai2hLV1bBh/OLEeKsu5ZLejzIZiiSoYAyP6Te2X0xGKJbsYGXn8gQ/qYe2yhBm
         G4PWUVGxbsMH2bAnc3dffP/y6xfELmbzQgQjGhjIXcB7a9nwUkCt57ZDlSM4mwgZ787S
         dM0Kjh4k4f5Su8I7kgQrlt7TvKIBs/1US2eziDCwQeUfAV0mEeeXw5Mac03TCk0TsF87
         8qh1z9eYNInGlHMk8PsdNWZC+2xjZJWMMLmLTbiTdK3Va2of3Pr1Tk5eyys4fbsbBmqz
         JdkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTtMgbXhrHoazvVb6ERCghlTIW3frEMjJyMPpZgUOHkGJf7a9g6cVdz54uEL7+22GMW4XsKTrO@vger.kernel.org, AJvYcCUmii/WSBcsgTrP0a+we8ehjqyenMwlxyNNdspzA3Gia7UA6oOBEDK6/sW84K6qP/BoMsWtJ5YqOgU=@vger.kernel.org, AJvYcCWLhERZcD/X6HN8tyayGgv2eeUS9IoTC06yzZiu1XRHZd3PDikRwWYrvQlbPs70Jdp51fkxZA1sTaLenQYP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/38CnTMc2Lioo2K/6JnF8AuYaXF9Oe8W7IzdQHiMbWFVJkmm
	vstI7eKxaqyKrbysMd1XBXK8Qku8Je0FiUP3UnbfFYhzQNv666U3
X-Google-Smtp-Source: AGHT+IFXSjarOOyrm9SCHyLOkxePmegV6ax6tAQ2bgxrY3uY5BPagoFhiBo/T1Tejx8BUQyXMnKozw==
X-Received: by 2002:adf:e3c9:0:b0:37d:4a80:c395 with SMTP id ffacd0b85a97d-3806113ce39mr3910403f8f.21.1730032019083;
        Sun, 27 Oct 2024 05:26:59 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a7df-fd2d-69ec-cea7.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a7df:fd2d:69ec:cea7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm6660329f8f.49.2024.10.27.05.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 05:26:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 27 Oct 2024 13:26:49 +0100
Subject: [PATCH] counter: stm32-timer-cnt: fix device_node handling in
 probe_encoder()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-stm32-timer-cnt-of_node_put-v1-1-ebd903cdf7ac@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIgxHmcC/x3MQQ5AMBAAwK/Inm1Ci+IrIo3UYg9aaUsk4u8ax
 7nMA4E8U4A+e8DTxYGdTSjzDMw22ZWQ52QQhajKQigMcZcCI+/k0diIbtHWzaSPM2JrmqarSU1
 SSUjD4Wnh+9+H8X0/eZHNJ20AAAA=
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: William Breathitt Gray <william.gray@linaro.org>, 
 linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730032017; l=1276;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=2VfQ2wflpZ8ggu3Rv8nU1yTN7fzoGtQvbu+rKsfAeS4=;
 b=ttxCObxsybWJIgkp3t2xxh4Xm7JGzXtW4FHFxWo2OkmZrk/DpI+wSsrsoHQjA49VdenYI1+Ym
 ccrTBxMRZYCDzDOzYdTjD9iZQqPc25zxaGhNPKBePtPyyGRlsA3UUMT
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Device nodes accessed via of_get_compatible_child() require
of_node_put() to be called when the node is no longer required to avoid
leaving a reference to the node behind, leaking the resource.

In this case, the usage of 'tnode' is straightforward and there are no
error paths, allowing for a single of_node_put() when 'tnode' is no
longer required.

Cc: stable@vger.kernel.org
Fixes: 29646ee33cc3 ("counter: stm32-timer-cnt: add checks on quadrature encoder capability")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 186e73d6ccb4..0d8206adccb3 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -694,6 +694,7 @@ static int stm32_timer_cnt_probe_encoder(struct device *dev,
 	}
 
 	ret = of_property_read_u32(tnode, "reg", &idx);
+	of_node_put(tnode);
 	if (ret) {
 		dev_err(dev, "Can't get index (%d)\n", ret);
 		return ret;

---
base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
change-id: 20241027-stm32-timer-cnt-of_node_put-8c6695e7a373

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


