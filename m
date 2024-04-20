Return-Path: <linux-iio+bounces-4410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77DE8ABDC6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 01:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E361E1C20AD9
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 23:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430F481BF;
	Sat, 20 Apr 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="e38YgWF5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64AC101C5
	for <linux-iio@vger.kernel.org>; Sat, 20 Apr 2024 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713656375; cv=none; b=dZbbJSpLL03xHCY/Fk4BtzziKyZW2bsjFHgJlM8ZmbjH2ok26t2zv44nhDHofHl7IdkdCtGSxVD9YrGTorfPxC4cqzygIOTKkGwSeKfkddQGAG6BDbqAWP976yHKgUo+8Kf98JxoHfOagLSze3vO/gSbcH42BkyNoWeE/TifBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713656375; c=relaxed/simple;
	bh=7EtzUiHKnCQDt2kFzOzhDoGIX9Othoem2KPJy4Vvo2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lEi9j7hnx2XXTj2wX6ZHEiHeSWfcAK2/0C1GLNxC9kMZi97M3ncnJTkW6qxODgM5a48eWfarJ5iKUc2XitLoDs/8xq4S3YcTpONpuVWPxYSy0kjKv7rmAEb+JMehU+kzIXnctJHk2N0AwqYl/AvLcPyj4TnUfgpgscjyJdf1uLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=e38YgWF5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2003208a12.3
        for <linux-iio@vger.kernel.org>; Sat, 20 Apr 2024 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1713656372; x=1714261172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N05aYrX6Q3tDAXOPpRelCwqjJsBC30QQaVhOqU9tdMI=;
        b=e38YgWF5Re9P2bGkdckSZB3VtyJKym0Q1+1cnWebSjNuNApA/fKBaZNICUXdMizyXi
         AQzzH1Sy4FEvdnavhPx1J+jlZ6yHZTdVJB+soQxvIDFLiicEfFYNsZLnPvWxFLyGquir
         W+fCIIco2agQZT8p1JUJoCPxDezh6Y0r5ujJELG+AZ3kDSyaz2o99C1TFHRTvPwQsu2F
         OXz/8zZdV8jA7vEmGmPlHnAeJqTFL/+fHbsXa8M74nP7vtOd8i5+a1L6oj9CMEN6Uxle
         Nr9OkXqapYLN3A0VvVAA8vt0ueJ990hiF2nM1EkLPesFEBA4XZo3z0j6hyblV2gm9kin
         wL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713656372; x=1714261172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N05aYrX6Q3tDAXOPpRelCwqjJsBC30QQaVhOqU9tdMI=;
        b=QMcAuLu5klFiklFlZ0bfD1ZliwaaX/uCKxMSJq22a7pxYahzMkR7tUoKP/4mD8DzC4
         7c1ifL5RxNK5+sOj5CUsnANGnR/FrC0f60dg9vVvZoJd8HtV/SWgDWOyBDP2CYlJQFC3
         8g5i3WanHYC/M1134zRn32DYq7mYJ8BLP5YZp2d66mHT/zdgFP0loUECPgY8HeiatLDf
         6Xis7I68PLrD4mMzsD7jzghNAAT6bs/8PHz6FFyNV3bwOzbbj9UBiThFjW/Bu/GpW2hb
         h2u8UTqzKoHV6Qm6puftt8oSR5DThiPhtCgYwu2dWlJ6I2UCif2y6tQIWdYfBdOw0enw
         RoLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXApQ8kfrNoSxW/MpHjjvoK/vP9bGOxfwPFR1UQA8z41hemuvnsjdyQoJt51cdiNhpi4xSBG2YdcJ5C52C1lfXEaRSeIlBgqsCb
X-Gm-Message-State: AOJu0Yx0ZSK0dOY6NIq2EXFA2bJOIYKSfoaLiKaBkgOb+kxw0MvcAa/C
	jqNjjFlQJgcBcO58wOoTUSlJmpfvf8F1TrBUZ2qdd9vaQQpYLsvBernKEyYfTBw=
X-Google-Smtp-Source: AGHT+IG8LTplNMLWsU6szjPzyHSHn+WYeHi7i82JL4cBIUxi6RShHUEghQdtrNhE520V36tNak7ong==
X-Received: by 2002:a05:6a20:f3a8:b0:1ad:6fb:780d with SMTP id qr40-20020a056a20f3a800b001ad06fb780dmr737840pzb.51.1713656371888;
        Sat, 20 Apr 2024 16:39:31 -0700 (PDT)
Received: from tars.localdomain ([2804:14c:32:8eef::1000])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902c65200b001dddbb58d5esm5519156pls.109.2024.04.20.16.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 16:39:31 -0700 (PDT)
From: =?UTF-8?q?Ot=C3=A1vio=20Silva?= <otavio.ols@usp.br>
To: jic23@kernel.org
Cc: =?UTF-8?q?Ot=C3=A1vio=20Silva?= <otavio.ols@usp.br>,
	Thiago Duvanel <thiago.duvanel@usp.br>,
	=?UTF-8?q?Felipe=20An=C3=ADbal=20Brito?= <felipeanibal@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: use sign_extend32 to provide negative numbers conversion
Date: Sat, 20 Apr 2024 20:34:11 -0300
Message-ID: <20240420233836.24971-1-otavio.ols@usp.br>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This implements the use of the sign_extend32 function to handle the output
of negative numbers.

Co-developed-by: Thiago Duvanel <thiago.duvanel@usp.br>
Signed-off-by: Thiago Duvanel <thiago.duvanel@usp.br>
Co-developed-by: Felipe Aníbal Brito <felipeanibal@usp.br>
Signed-off-by: Felipe Aníbal Brito <felipeanibal@usp.br>
Signed-off-by: Otávio Silva <otavio.ols@usp.br>
---
 drivers/iio/adc/ltc2309.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 8b3a89c1b..cb93dbc94 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -124,7 +124,7 @@ static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 		return ret;
 	}
 
-	*val = be16_to_cpu(buf) >> 4;
+	*val = sign_extend32(be16_to_cpu(buf) >> 4, 11);
 
 	return ret;
 }
-- 
2.44.0


