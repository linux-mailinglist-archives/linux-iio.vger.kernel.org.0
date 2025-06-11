Return-Path: <linux-iio+bounces-20518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0EBAD62F1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C1818987C1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541442C031D;
	Wed, 11 Jun 2025 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bAhKF5nS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F322BF3D3
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681791; cv=none; b=CIcI8dNHzFpLcAubG+aFyKsGwLBofToG8bQhgqsQ8YNSXjyFd6KHYBhNDRzA2krYAUghaVltCnzlNgHvcIeay7Yl99/JNNQ76dJKZKmqMUFnJS0Rp4DnIq7DstPT3Nm5J1T3pMWbNuBX1edA0r6EiIpQ891H8jPqy6O30EazifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681791; c=relaxed/simple;
	bh=H2LBBJsUJiIc60MPGSJU2UBb5KBWsOEZhj5u9YgC6RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqtIYlFbPLk2GWUsMLflQsiPZ0pZBjKszZUxz3CQoeFoDluLncRpyf9TSUUy7spJuWyfuaD1HfH/lx7tSgEr6bPlK5dYe09813vQyLHJNr/7wxDXyZo+bDKZO2MPefY4VtG7v6AA+GObKRA48w8/xuLyjjiAe7HOldNUeipcwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bAhKF5nS; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4067ac8f6cdso245681b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681788; x=1750286588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFtBqHig8Fed23T8+cfJndFoBL4sOX9Nb3YXu3tizw8=;
        b=bAhKF5nSF7/zh753RywiVD3wYcxamqEY4T14Ir080lwz3CDVS3mT0czYrHbHfCQgk/
         sNBEBLDtkarkNPtwxG454AUBr7FJwN5TO5BvppLK3YI+2Nqbg/ekz6mQ6I+zuBIcX23s
         o7NZakcsVWeH2eg+WXlrRXAZ95vuYZxPVVwrJ4ikNrbL9872xvUPOWdcp+dq3PT4Twi9
         q7zHq1b6o2yjyUec6dYBTfrckYMEKisKJ5tsXOXopRrP46WB/AkR4pZ7nrs9z0UHETIO
         ECXxDvSt9ZaqvkNmBJGk2WMhLVPyR/yC6ojyzNDMc4lnzEWuYQlnr6SN+qTeaaxC/Ndg
         Wb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681788; x=1750286588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFtBqHig8Fed23T8+cfJndFoBL4sOX9Nb3YXu3tizw8=;
        b=H+OszX7DaabGC8yDvw+8lVQoMPCMrGvFLDsGNZeADUBEdwLgAyqVMD56JD7rzWJUHT
         rSwOXBmWSvUQalKKAmQdFPU2T0AkkeHcgcSOeL9o5dEQ7ckLGCgivE8F/pfYC8ks+clC
         pvvTNB5t47UIy5gcjtLvwMDffu9ydovMW5E4Ei7SLlwRIWP3IafC77H0iM7xpumWHHEr
         pYm2qhTW75Gi8Pv2JWtAjRLEx7SDDlWcqPggFwgrWc3fw7OlHAlaY6vPw2QwqzwYJZhJ
         G23s+8U5xYM3RnV8mhk8US0CvTUsDtcsoDl7ypomR717c7AUWaahQZw4BtdnKcJ7xY2Z
         E+pg==
X-Gm-Message-State: AOJu0YyYsNmdCN+O0Mz6e86aCT21ea3ua9VkMQ3L07cmV9sW/4tuzIjQ
	/mNKZF+3BJdy7wtCZ/L1w/E2qqPasRBqH3MYWxb4qcKIDPVMJuJXFnWm4wvjqynYgRs=
X-Gm-Gg: ASbGncsD/mJ7FnYwZ+0gYBv4xAfZfT5i+odWSVdNBnI9WNOVAwOdqb/vomenc/iyRdG
	W/ZXx3kTfPHZtC2QzOIQ6BLrrqetwXkPf2+DvmniaufdW/BHnKPUhye7TvGxRHKI6aU0JtMLBVw
	+XkTqPgsmk1QaDXXt6TUL0vXYeYlq5Tvejug2Z9yde4l3uZDgY5IKOkXYi+OWmX6TD6+cmX4vWQ
	8x7VbfQ7eS2Jw70d1XVCNjaejE1mU304GwzcnaCM9t503KUF9y6mEAN/1B+xqpOH6+F+1A7hJro
	JGAxfAWqIWqytXQl01dCydrgLvtuYgrGpne7NlbrBv8pec/G5/xfjIwL8SHfwothqPDP
X-Google-Smtp-Source: AGHT+IG5W7kH4+hxgdGC5cYojtw65mnpGPuM8rfmDxflahn9sv2QuWNjrWb24/1rv7CIa/pXKjlkYg==
X-Received: by 2002:a05:6808:238c:b0:406:72ad:bb6b with SMTP id 5614622812f47-40a66adbc50mr575420b6e.37.1749681788466;
        Wed, 11 Jun 2025 15:43:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:43:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:19 -0500
Subject: [PATCH 27/28] iio: proximity: irsd200: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-27-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=H2LBBJsUJiIc60MPGSJU2UBb5KBWsOEZhj5u9YgC6RQ=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGhKBjfIgQfT+NI7ZBHF6EqEZASLyMpQI6Xmjd023Z/HVL55R
 YkBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJoSgY3AAoJEMLMIAH/AY/A1PwH/1/i
 g0gWTD7ZaRxp/hx7awW+jIFoQGzh6qTEbYue/UlgwqG8WG/qXLGJtE2TMNEr4xak/0DjEmHUQi0
 6TuTAR57tOQGCcFyvgFcpEHWGzydpL1M2UuzsT6SrTEkw8xRBk1Sjru/5SPcKg3fG0YQNSV0u/u
 y6b5ToQ6S7Fyrp/CQ9iLat82yU2B4m6UeVvKbVnUqQKf5W6irfzYAIiHsGm0U6Vt2JB0bw/xENa
 0AvOII7wKZ+yCTn68OJNIUuuO2GriVCbnOFFVj9k1xyiFlL1+f/o9rELPgpsoL23p4rJAR11ciY
 NhG+Uu1ETT3wLhRDyyFvmrfMPWxajwsHHsexQU0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/irsd200.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 5e751fb0b12fb2167f4d11e814915cb2761ab9bf..253e4aef22fbdca84a0f8393d6f423385c8dcda8 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -763,10 +763,9 @@ static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
 	struct {
 		s16 channel;
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int ret;
 
-	memset(&scan, 0, sizeof(scan));
 	ret = irsd200_read_data(data, &scan.channel);
 	if (ret)
 		goto end;

-- 
2.43.0


