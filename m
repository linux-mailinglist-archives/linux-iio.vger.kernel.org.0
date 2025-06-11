Return-Path: <linux-iio+bounces-20517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0236AD62EA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4387A109F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07DD2BEC44;
	Wed, 11 Jun 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qeD/aIDU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205329AB16
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681788; cv=none; b=tjDG150n9CRXS5Il2kXHRPZnWhrYIoukizhGbmZ/GFcunvWcviYRFX+m/PAX0d9gGt6V2lib9yCgzjbtNQPDgKKgvGZDMg75xKayrO7C/enNAnLwZ5b5P28soPok+6af5Zh7DBed2RjAH964zI0H0YeAjbYM/xOMJYvIKt3Rf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681788; c=relaxed/simple;
	bh=UW7Bx8ZURpZRdKW8GhG9VQDYCD+6f2n+DIethjWGd1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czXkHBIKKr9ODrf52FkCTzzyFhC65wB/c/E4DK+VyW62lzR6SBj08kzE4vmTyQ3MMFOOG02QYiDD8kePqQa2Z10AsemN5r92EIKI1RoSKBBw6ltqUqWji/1hGuZw4g4GK+EdGHChMPnLp99/Ueqovn3CpIYHThxFRGFfwROxM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qeD/aIDU; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40a4bf1ebb7so195368b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681786; x=1750286586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bvfq/1PthJkt3QRBA4xnMMNhlIO3I3TLPySbwtnDOss=;
        b=qeD/aIDUBmXvPLCxwbtb9Xejrpw62py0kgsFRdjpFW1tuOEhRqgYPclxzwo502naFW
         8himGY7D9tHnZuRe6W2r1leZiQ6YdHBxbgXL97OnE1HFVTCj+9vY9ttHku6FPZxMTEoF
         qIiSOamzg4vf8D2JdZtjR5kJMr/k7ovYX7llewy7PdvJ6rKITeNV1GHhNRx48L4V/0WA
         tXtRgJaA6lucKYgrdocaMCy27jqeQr4uvVd11/RMJOS333mFpfKrTM22TEaeFW7gGpzC
         k0DaTeNBxiQAxm+JJyaD/hx15ZVo7IvOpV/aUjY9j3cnWsbH45ON3gzSlGCaN9EhD2ga
         gITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681786; x=1750286586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bvfq/1PthJkt3QRBA4xnMMNhlIO3I3TLPySbwtnDOss=;
        b=YpOt2UcZF2+hWiNmWJYkEvp9s74tIRVhhlWtFfSkry4z0siSImZhEhxNpsHc2k74dD
         IU2iuGKGO+Au9hJGq+JAH+FXi8gcygm5lh2OmwJHC/KOT+4uIHQrkrw/dhqQN/ovC2Uf
         F+4CyFhR3xQTDF8vEiFo0I4hkRox91R1px5v+M0V1bekjavemVbWYrA89UOjbsi7OOiW
         FjCaiRiDboDQDq4tuJk1xIL1XFnCMGj2N/qJKQnMRl3VmjjHPcchUZX7rmYa7zhqrCob
         aZ8jgv3Zy3zudCTUrd2yWxdFV9M/6VoE/U+7xkR/eNZJanYyh+N1UPdkXYHDqHDtGH1f
         7t0Q==
X-Gm-Message-State: AOJu0YzVufV8Wld+vP59EvLNtIlAd0IDOvInBwpyx8lqkzRo6QSQwYuR
	rJ/0UclX/CEpA8oqfJMrFpOtsD/YSvsNoznmhf7GYIDW1Y8pAKszX0N0UapUo0dlb7I=
X-Gm-Gg: ASbGncvMt4B3UHsbfJ2wMJF/u5KKeTLG/PTIblgiaQhV5elLFtfdMjicJzuPrdG9/GN
	juNK3f6BoilBpr9hmnxcBGq0p5nlVBjqakyTs7VtrEV0GrY07kjvyfZ2o3H06qUCuhLV1hnzsMG
	ZnzzFJLi7acprO5cd1TSEfIHPjolqIGVDFuYq3UPEctN8eh/FVcgBnuv02nXSLS9OJmSD++sDjk
	xgKE7JhMz8os65eWq/zQLiaDC623m2nj/IiWPcMi4+v+b71ZSY0Dg0lEWK4AbiOrG1jjTsUrZI3
	QmW6borK7tYt0JoNnO3rrNnnaG2LXCY4r1H/zY2d1c5o7h3kAZvXV/wfjbn6z/f0wzVi
X-Google-Smtp-Source: AGHT+IEzxA2Sz6qgNCiFhtXAvcRaONOijMvYTiFTuj8n/pknGpxJ7PSUYEWQmDmDDdoICgN5Se7ZKw==
X-Received: by 2002:a05:6808:3189:b0:403:31a4:f3fa with SMTP id 5614622812f47-40a66b562cbmr545614b6e.35.1749681786177;
        Wed, 11 Jun 2025 15:43:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:43:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:18 -0500
Subject: [PATCH 26/28] iio: pressure: zpa2326: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-26-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=UW7Bx8ZURpZRdKW8GhG9VQDYCD+6f2n+DIethjWGd1w=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDK82AxWczZcn9t22vxZreO96Ev3Hf1fuZXnZ25ICSzpP
 XO+89HZTkZjFgZGLgZZMUWWNxI35yXxNV+bcyNjBswgViaQKQxcnAIwkao77P/DT3lqzXe/zn1s
 h3e/z7q+bpFp7GeZuULWKl1hX6qm8k+l9c7Uus/9bWfDFaKXxB3Sf9bVp7PzdswS9ZB57fbd2bs
 9DN64lqm9C9hhL8usdXSC/UK1SIvH+gkLWi1jV5+9WXnOxz7DZAbPKa1ug4TndQ9vSd5b8HaCvL
 H71aO/c5o12+TDV7dUx03cXXby7LJjMXZGwZkZlrXvL894O2uN3Z2kraLbH5m+jZN5Zror4rxGk
 idH5xtfc5VfqxTF58pnWEt4TC9qus7BwvP5lZUuj4ugdWhJWFpJSs2GpkXrpm5k1W3Tt8+R3Bi2
 rjKXxaVg2sXJoUKyX2+y7S0LaN2e9Pslj3Dx05DQFe3SAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/zpa2326.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 1640aa3717eddc135dfac9d5e45d899ae2579f64..6eef37c0952d7c209478911413de2cf3d2552920 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -583,11 +583,9 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 		u32 pressure;
 		u16 temperature;
 		aligned_s64 timestamp;
-	}   sample;
+	} sample = { };
 	int err;
 
-	memset(&sample, 0, sizeof(sample));
-
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		/* Get current pressure from hardware FIFO. */
 		err = zpa2326_dequeue_pressure(indio_dev, &sample.pressure);

-- 
2.43.0


