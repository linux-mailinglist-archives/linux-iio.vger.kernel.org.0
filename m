Return-Path: <linux-iio+bounces-18856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E06DAA112E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16631A85C68
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FB24290D;
	Tue, 29 Apr 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwlTK6LT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F423FC7D
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942770; cv=none; b=DgUUXbFJtukhGGb2ZeXbzLpNqucoDz2A2vF3wnKLM4SYtVOKwy6rXHJKHkvNLq6ZcsUDmG188640X1vVMJQBk19kyktB2JWfGQn0lxAX1mqXX/EJM9PhgxPGGkT8QGGEGcRIIP3+T9rATbELsFiuNiz0SgZ69mFnyw/6hpje7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942770; c=relaxed/simple;
	bh=+XNyaJJ0FOoVnsT81NUVSTseT9+PcHC6/FCLk3vsRuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj2cS1fc4Yl8dQxJEXyB2qlgDoi5Ook0WjyKo8qHuQQIjN/7I2V1nno2NEkXCwN8gDelFgchFm8hr8+5gCeB9r6tcxTqqx6Ez8izqhjsXy5493vkplBjlwJn6kCOTSkIosc6v89+9VZhvUn+JyFbF9kHIA3maPZForkO8uRYMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwlTK6LT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376e311086so8413333b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745942769; x=1746547569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3NqWJM+BfsqfAcQpLwqkhte8ypL3omcuI27Nb1eQec=;
        b=PwlTK6LTs8PlkPMSl5i5ztdJXE3M+1s43WA38TekWaNOgIC47UXnBUGjiwzxj+tlJv
         68C+GDJ8mOqcbhH6bh/AkgQxOUbvOFX4WpmwkPnzIltaCn6jWIckjrI7+UIeMt3N1kwK
         mYeFkSuMiptaKgkP34WLaAkAf+eQAK0j0ia60f3DI+0Chzx0aC81hcaKVDJ4R6ctjbbM
         Xg6yhrxCmOI3qieLTqBxDCh0WOmcslsycoh+5qJHXayOA/XK+7+y/c3XyW7szvKTvwWw
         Tji63ypOrvBOAPp6tUlX6Xi1PqHkxoD+yK4a2DYuZ34qy46EGp9pk8aqzwhYYuectesk
         op2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745942769; x=1746547569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3NqWJM+BfsqfAcQpLwqkhte8ypL3omcuI27Nb1eQec=;
        b=E0tUSQCMe3a/e1PJFcLPlMXlvwJqyIkZdeqVxV+CG16wkgxsHHo26LkWXAof55bWMx
         QfYrkS+fbQNvr0o0rxPcIkX6sml+q0kyVn4FHU9J/gThxRQiZ6gQYjcry8vAGfY69Zkw
         LsJbc1gZ4thhKER2DfAt+WiXSO5egnMycwqksdTfMDEmUdtKXSh0sORA9CCWywc6hmty
         LNOHM8j2xRhhVJ0qnzy0HQ97E7dN1sD3kCoz3ee/PbLOCO04MtE2/aUC63W0I21T5JM4
         R3Lr0ddG9LpQGVRz7+eZhsAeNdJujeUzTdP4dW1g7t6MzZ3lRcV98hqoYCasIACJUAFd
         tjDg==
X-Gm-Message-State: AOJu0Yw2DeqigIzIlBlO6RleE06PCnBF6HlkBpMeBofTgNqpvX3mQp+K
	D83idr6j2JeBCUEeBaLugLbAYIjKNkGpx1aWLhI+Qt2UiowhDDCZ
X-Gm-Gg: ASbGnct4iArRe+xbxM5PKj6nenIEGaK1y3NJHk723VUjsvwDlg/QzQ2aKLOn8CX2iKD
	IQOUqgDNUUKOd0Zj5HYdq2bn8a2cMNfe9IviaQzasA1pGcd3uCZYsL469cPCNtwfnffFoeNUG6m
	f+wF92QOj4dwbsgAR9cBYx08NFLQpY9kHL0hqxB/J8JeG5gZ6Q/buJQaZFFDbSXoTdgRsJkA7NE
	bjiVbXcP9gL/+Jtir6gJNQ9qrsEnBLBJFpP94FaMA5Qhu7pxxtzw59El0IwQffoMFnMh5I5oRwo
	C4s1qVaMHX5+bximNlsf0N56BacWNOdWsKg1kKF8x+y669y3zxphJCOBsWni3euW/XnTUhHqaK8
	=
X-Google-Smtp-Source: AGHT+IH9QFf5oGeuQHmt6HHymHc7rauUapYvfGuNAuOPuqGj1k9ECYRxkBylucdnQ770sb/SK/4b5g==
X-Received: by 2002:a05:6a00:21c6:b0:736:562b:9a9c with SMTP id d2e1a72fcca58-740271def72mr5831031b3a.18.1745942768624;
        Tue, 29 Apr 2025 09:06:08 -0700 (PDT)
Received: from c-sar-augusto-LOQ-15IRH8.. ([2804:14c:73:90b8:20f6:60ab:5d7f:2c50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6b18dsm10400888b3a.95.2025.04.29.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:06:08 -0700 (PDT)
From: Cesar Bispo <dm.cesaraugusto@gmail.com>
X-Google-Original-From: Cesar Bispo <cesar.bispo@ime.usp.br>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Cesar Bispo <cesar.bispo@ime.usp.br>,
	GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
Subject: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: modernize single regulator call
Date: Tue, 29 Apr 2025 13:05:19 -0300
Message-ID: <20250429160526.5934-3-cesar.bispo@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429160526.5934-1-cesar.bispo@ime.usp.br>
References: <20250429160526.5934-1-cesar.bispo@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace a single instance of legacy regulator handling in each driver
with devm_regulator_get_enable().
This change improves code clarity and aligns with modern kernel APIs.

Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
Co-developed-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
Signed-off-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 31f88cf7f7f1..c99d6acac059 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -911,7 +911,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 	adc->map = map;
 
 	/* Bring up regulator */
-	adc->vref = devm_regulator_get(dev, "xoadc-ref");
+	adc->vref = devm_regulator_get_enable(dev, "xoadc-ref");
 	if (IS_ERR(adc->vref))
 		return dev_err_probe(dev, PTR_ERR(adc->vref),
 				     "failed to get XOADC VREF regulator\n");
-- 
2.43.0


