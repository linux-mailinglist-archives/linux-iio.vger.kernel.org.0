Return-Path: <linux-iio+bounces-9701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2AC97E25F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0309B2810BF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB126AC3;
	Sun, 22 Sep 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX81Ug5F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F89EEDB;
	Sun, 22 Sep 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727020996; cv=none; b=p6zlOoYP/F+pperBJAkUnC3YFYCflEKuco4ZyAt9nKEQ8DwbRySXyI1fTMQq4h4CZhRVIGdLYY7ssT03eKSnq2+5JXeRnhRzZJl+dmAAj4Ho3KSOMxLsKLmUA6AgrLUvuv1J8q0C4V+GsrDBJ7/mYZIx2VLMHIGCNROFZWi2h/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727020996; c=relaxed/simple;
	bh=5ZAONY/2YZa6LbtX9P4cPS9Wn5GiycMrZXelyEAmaV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aeUcOgp6jiGOUx5udRYMndEvPHv9PKUAZxlxVy0In48dSGqKTNybb9eShWr9CYF6wvrLEaIFtmtIDViI3LUeaQP85jVP30rpqP3nRZcXEbBsBqFDJWMbMg/Cin/NC6kYVOjSVzT7oQgGkJ8LOBUwd62D3Ie03RcMa+VsVEyYOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX81Ug5F; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cafda818aso34064865e9.2;
        Sun, 22 Sep 2024 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727020993; x=1727625793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIjf3SvAC5WB7BMY96R0vC28WViotpy7Atdgw/pNXeU=;
        b=VX81Ug5FV3FwzmqCYeTibJ6hzHz0HLWmD7jr3uP2ies7A9oBslCEwOTRKeUPIX8SR6
         cIifITroNGvqlQK9hKabuqHe2kHE52JO6u/sPtFyv1CpubTecT6ea0qI2Y3HmacTm6vY
         z442jz5rBuS2/DHVp5c4sRGdUCFDG+NVyeKR7MfCIqisfktq0DHGVPrbE6GxKz7ALeWJ
         nQBuUtdvr0MJwffT6ZqY0v9dbTVippPaFhyHmhWCcu/qDyRipU9xGW0MlGAGdBGzyPx2
         UANh8ksOySy9FK6hMsO932qRfSPuHGoAyHrB5VXGQNecnp6BcyqTeX8YpJRrlDVS6oup
         nnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727020993; x=1727625793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIjf3SvAC5WB7BMY96R0vC28WViotpy7Atdgw/pNXeU=;
        b=DPeLVs6FJJBVoZ1duNSwxPezVNvaFuB30iBeRGe++55eY44SG7KEOygANsMIkCpqUx
         do+B9y8bfhBYoAxsxZuzdGcwq676iyuc9qBk25q1q8JD2ISP3XjqGrnU4K0T5DzPksug
         F6ByjfQGwBwMbdDcTO7e3hcstYmCeCVfR8ombMMj6nmJGoFezIR+hucOHc6hTvPKb0Sg
         RII6N8+2xBu0xGJ8VdutWcKpT1Ps0+g0SIcZty8p/h6O1+HJKw0urUpkmre4an0zcVOv
         MoXGjRseU6PTnsBEHrCRHSLRuLLRvKqMCVtGT/RUQURJqm8XCc+aUmcyQGQ4l7zZDYvn
         PsNA==
X-Forwarded-Encrypted: i=1; AJvYcCVk9jF6bt9LKDrnQrP+sFh3jkLlnI0D3ZRqtnBg/g1RghwtbUqV3lR63Tv6gm3hO0PpNh7/GnVyMlbTNIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTIm5Om9TDwX/lP5a17IbxwdfnKo/eO4xjWv2iMJ4us8C9VQ7q
	EV+3AD449GH1zjW3sfW/DilAoTdux+sGfKUVkCrvKfB39NuwMHYp
X-Google-Smtp-Source: AGHT+IHdqf9zorXWwJYjtLJ552AZMdReJDwo3DRTKzIboeaSH7WkVnWUeI5q/dBMwlA/4PfyCNTOzw==
X-Received: by 2002:a05:600c:a49:b0:42c:b95c:65b7 with SMTP id 5b1f17b1804b1-42e7c163ef0mr68491175e9.8.1727020992477;
        Sun, 22 Sep 2024 09:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:7367:3ea8:c47e:88f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm22310719f8f.49.2024.09.22.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:03:11 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 1/1] iio: acpi-als: Use elvis operator to simplify if statement
Date: Sun, 22 Sep 2024 18:03:04 +0200
Message-Id: <20240922160304.520613-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240922160304.520613-1-vassilisamir@gmail.com>
References: <20240922160304.520613-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By using the elvis operator here, we can get rid of the if statement
and simplify the code.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/light/acpi-als.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2d91caf24dd0..cea3499c3af3 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -171,10 +171,8 @@ static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
 	 *
 	 * If the timestamp was actually 0, the timestamp is set one more time.
 	 */
-	if (!pf->timestamp)
-		pf->timestamp = iio_get_time_ns(indio_dev);
-
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+					   pf->timestamp ?: iio_get_time_ns(indio_dev));
 out:
 	mutex_unlock(&als->lock);
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.25.1


