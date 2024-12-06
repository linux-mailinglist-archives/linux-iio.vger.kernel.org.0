Return-Path: <linux-iio+bounces-13145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B379E6CFC
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277B9168A53
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBDB2010E4;
	Fri,  6 Dec 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pgN8r8/z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69D201006
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483651; cv=none; b=eu5VKpWsbt0EnQFcqAtSdYszpeNxXQ4r8CKsEaRCnILvdDkaOp2evkgRjqW83ymZLTIUxLHqm8NwCZ9fvOp+W3slJRb8VwrOOYTUH+laEfxNKEfSYYHngD8Gbg/L0zZ4QG95OrQRu9bEP8+XVIJcD08ta6nOEpY1yrWl/NNrW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483651; c=relaxed/simple;
	bh=a0X4aOYvG3pTfNgIEESajz8KrdCPF4/aLinqArXPrIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsyX7wiN28HZ+d7nSKKTDLkTdLxa04jzDbuB9Q6U2dmGZH4Ngt1Gr6cvIpI1VFBrhfdZVZ4TuGqPpUdoc8r8egD1+Dtj8Wp/r7mn8X5LQrxMGpCnchJkve3FithvSbrUHNZwo8FDOzruKhVGxc3VuSydy99rXy1LiHmwjqIKrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pgN8r8/z; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so198247666b.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483648; x=1734088448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcFmoPRqWug/wF9N6rxPklzROiRzJUhH8R20dFRmNrI=;
        b=pgN8r8/zwM6QCbeVS/nKYXVqlIWc4HYobrPKAgRlsRchnq65qWHTmAfRn1gkIKgNQz
         YYPRUg/BmEcW0yfhOzPghaZ8BvOSjz14VaiKumjXY+1m/I5U/G3ulCSFZVmtrj9WDwJr
         A2uAkoZA6MrJTt/KnGwJNmpz35QCk3Azc2KdY1/xUW0Kq7KHbVjZp31yUgLZO0TsHdcj
         7IrjROxweNebSkQOibunqR2EFmQnpvfH53BXDd/G+ssXqPegTdQBHeTXiOVcTUyjeWqF
         8DxCYvdDaFsu4+bZaru6XgqVsDVdsKLVGKtgygyDB2l/jdC1wR6mFL7BdxZXebuL5rHh
         zV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483648; x=1734088448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcFmoPRqWug/wF9N6rxPklzROiRzJUhH8R20dFRmNrI=;
        b=QKa7/0S2Al1xbnQ9dyxKEKXBdJqsWnjzNUMLskesN6t78nVYmn3Hx7THSDznJPHNOO
         pkGrQu+YCGCYSqUvDinQpJy22Nnvpt0wwDEhsaQ/3IRcHoiZkqygh53dlHNKdGbhQWf/
         nhePbs/ObKdhuICXEXIFbkdIQRKSbCIPd1V+Ikbfw7T/whvxjN35VHdvjnoNigXPm3xK
         3Z9n6zIFx1zYMl5RTdKVOoUPVD3oPAQ5pgJBuhcSkSwX2cLSPkHPpfIdhaH6MZ3RlqBj
         OzCx526LmN7qfPOU5G20AVsQFj1PtvJlNU5DPwISwUayzZBHmvmhlULU+aVdIbhbonEd
         X4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2b7dhAKJ9RWuApKLqd+csvrLOymMCkQipQSV37ksU9NvQpmPP6Lo03mNzZSKTY5v/qOueU2I6oR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIido9+hMgy4D7uHEZWz08Nyyyyv5fE5EqXsynvvFLbK8Qij+A
	DqU9pk8eVi4Prh5yX3DoO2/2GPubEqRxYyAwxxS8XRBmMuryHz2ldiW6Dg5WxCw=
X-Gm-Gg: ASbGncsxob5Z9xDfOYAd9AvzSJbFH31lEf45lWJLGmxBTbCGhP+Jtk9IgqSC6vA9oky
	cXRNILzW5Jqlr/69d8pttzjoY21pXizenO3w4URbRWJg8tij4pZGnMtrF3QD/f/FSi4EvtdwCTT
	mG2Sqt5/DT5zAgM1ZUa9MKQsk46P8YIgAgM94JjI7zQMCjSBDVN6ikZ4m9veDwmPiTDjE17cc3a
	LbKSeHPLl0yqdJagf3EVzo+nqIuXgVUVWJC0Tsr5pmAFWt/cMBxW/CvHtxhbZapixB1koO8YMO1
	N7pi
X-Google-Smtp-Source: AGHT+IHiSsJnrO9WOBGpjGpJxD2jcZJI3sgccO1J+MWdvjykKFu0VlpAlkqINSQOhBcrCp7fpOjTGQ==
X-Received: by 2002:a17:907:6194:b0:aa6:3e97:f9d8 with SMTP id a640c23a62f3a-aa63e9814ffmr105149766b.54.1733483647971;
        Fri, 06 Dec 2024 03:14:07 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:07 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 08/15] iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
Date: Fri,  6 Dec 2024 13:13:30 +0200
Message-Id: <20241206111337.726244-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable runtime PM autosuspend support for the rzg2l_adc driver. With this
change, consecutive conversion requests will no longer cause the device to
be runtime-enabled/disabled after each request. Instead, the device will
transition based on the delay configured by the user.

This approach reduces the frequency of hardware register access during
runtime PM suspend/resume cycles, thereby saving CPU cycles.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- used a non-zero default autosusped delay
- adjusted the patch description to reflect that the default autosuspend
  delay has been changed

 drivers/iio/adc/rzg2l_adc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 953511191eac..c3f9f95cdbba 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -208,7 +208,8 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 	rzg2l_adc_start_stop(adc, false);
 
 rpm_put:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -372,7 +373,8 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -410,6 +412,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 				     "failed to get/deassert presetn\n");
 	}
 
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
-- 
2.39.2


