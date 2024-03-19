Return-Path: <linux-iio+bounces-3629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A68806B9
	for <lists+linux-iio@lfdr.de>; Tue, 19 Mar 2024 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A661F22C19
	for <lists+linux-iio@lfdr.de>; Tue, 19 Mar 2024 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E18F3FE47;
	Tue, 19 Mar 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emlf2rJ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63E3FB99
	for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883684; cv=none; b=phGRrem9b4p7dMWQ47nL1B4zyV2DihQNTaG6EuKdd//Y8tGMo4i23B8ejH3qxdATalZMgytinvGe7ctHtm38Dkqm9Tipn3taks3YOIXxG57oTM7MRjATuIvpswE/GpddFdS2vqf/6lwA0iGw1YmAoV4Z6hhESVo0sGc4mPK8A3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883684; c=relaxed/simple;
	bh=tqe8EJsv6sKCyhp0DfFjB8S0PwUP9NBM6laVyzpxzz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jwTndVXgBYghRv1m4giuTDUSjD9igsb/FtkPXP4tzOA3fyeW4LsNKjl0jSPjgpV9XdU7AtnrK/0COPajli7Dx2dMFJtatPKhnlhgJmYy0Y9IaCz9PV+c9m/PyMXIZ91MCSMA5bYRHUxrJ2JDDaOv2EHzEksAPlEm4WhWnWFvOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emlf2rJ6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a450bedffdfso744952566b.3
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2024 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710883680; x=1711488480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4HsEb3EXudst0pXWy+UxEKhNeQ3/rV2qI5TWzK7NTk=;
        b=emlf2rJ6UGY0sPk4V/qqpUA101GHVBhkc/EK4zSPaAYv339v3VVYkZRnnoqZO6CtdH
         Pkz3m72vkaxNKtrEhUhzZNvYCk7C56bujKHuEcSBq5PaRxoh/V302jfzgpg/jIspWFUO
         6xWIfXG9LdhZUDw1B/T0+F/Vf2Ww5CU/1YOiLlSnH7wVLP1N3rOJ1xGV5dSSoQ3ZqjOG
         vUKuIsilPr0PV02UtCHCt8yMSsLqmq2fmgW0NBcHMrN+y3PLDgKyXGFVsDnXkDgrnB0Z
         Hwid4FlTs7f/R/3Jve5ZYLT32B2CzTta5i775BXtkqm5NRnHJE4/JrdhfqEqmSpB2AOm
         2PGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710883680; x=1711488480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4HsEb3EXudst0pXWy+UxEKhNeQ3/rV2qI5TWzK7NTk=;
        b=aZIPKMc5vimJl0Ir+2HowgxDs4tIdV2U7ewAOJ1lj/Utu5z3cwiqBKmUKHVWwGAtV6
         JebMGF0ROlFAvxHqd4TI2VLlJS4JJaU10qgcVX0dlcZ7ZvLiQgiSk0WNERnbVDCK8fsG
         EmcyEPnPgnYvIJNzeG4waCD1MqBqVJVa/9PEWV9qpD9XP8b2pSGopEKg85l5N160g4y9
         fLIIWIPxP29VPQPOCtN51RwkUxv9MLF02F0lllmMwNg/uI8kbU/1PW7YgjEsIADbSzc/
         PzYXsaGBxV3IjKbY5aTWpDxnujKQ9cV3ZpeUY4ZApAmASACSkIKMijEBTveNOuaPYHN3
         fPVA==
X-Gm-Message-State: AOJu0YzJLOiclV3Lb7njZSBLv8wGbwF4cyIOzwjNm9hIFUpvvzUPPaY3
	twUm/axMcwlDMR/h53hApEiwvBmu5wTwgDYpjHeTVGCmeho/zD8R
X-Google-Smtp-Source: AGHT+IGQJ3WP0qU0dJo1RH5TufaNdS1Vt86wBX6/xR4SsldOUIHyfO0YLeeuv/vlPHRmY3ByvdQ7Gw==
X-Received: by 2002:a17:907:9453:b0:a45:f4d9:acc5 with SMTP id dl19-20020a170907945300b00a45f4d9acc5mr12518203ejc.29.1710883680488;
        Tue, 19 Mar 2024 14:28:00 -0700 (PDT)
Received: from a989ef099cc9.v.cablecom.net (46-126-232-210.dynamic.hispeed.ch. [46.126.232.210])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090640c300b00a46a4a14555sm4402518ejk.86.2024.03.19.14.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:28:00 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH 0/2] iio: adxl345: add spi-3wire and refac
Date: Tue, 19 Mar 2024 21:27:11 +0000
Message-Id: <20240319212713.257600-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds the spi-3wire feature and some refactoring to
the adxl345/375 accelerometer driver (iio). A separate patch
updates the DT binding.

Lothar Rubusch (2):
  iio: adxl345: add spi-3wire
  iio: adxl345: update documentation for spi-3wire

 .../bindings/iio/accel/adi,adxl345.yaml       |   2 +
 drivers/iio/accel/adxl345.h                   |  44 ++++++-
 drivers/iio/accel/adxl345_core.c              | 116 ++++++++++--------
 drivers/iio/accel/adxl345_i2c.c               |  30 ++---
 drivers/iio/accel/adxl345_spi.c               |  50 +++++---
 5 files changed, 155 insertions(+), 87 deletions(-)

-- 
2.25.1


