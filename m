Return-Path: <linux-iio+bounces-10748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4AE9A48DD
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EF8282CD5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ECD205AD3;
	Fri, 18 Oct 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vfsVGrmw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3C204F7F
	for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286649; cv=none; b=Lz7UGAnojfsrqzk1lMKV3/ZRETd5+u/Dooj2uUsN34KG5eGSV8CCiObxf/+xwFVmdhw7uJ2gaN+PU2+Pvb8ZWHx02QpEi7qOVLIzzKJaSmqmNsUmV4h++OmHF2s1n0FusqyI+zx94iZEVmRcb1z0LRKfBmn0Ek0WwRPzdddGYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286649; c=relaxed/simple;
	bh=BBdrTo4hw8HK2E2yA2d+cEkf0HPodq5gdVba/Qop9iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=igPWVNwbi7xMblTgb6DZoDk9A1f+f2+jibRyIjCaUQT7fdSal5xH5JDOG4oyFn8QZecIhvgmhgVbXC6dsgCMC4Hgl1/8Vo9/itJx9zddqdOh5oXYTod5AQpB5Zo5qTzVH5ydpmrRlMU6nPZahMRCtDQ5ca+A3+yoy0e+m8PHg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vfsVGrmw; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2884910c846so1391133fac.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729286645; x=1729891445; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu3ywbeiueAiLpZlAoRlOExXhdy9SqJHCZ3asIlIMCc=;
        b=vfsVGrmwnPxfgarfd07e65/IIFOUJKs0goW19UPls3ATqdmX6LbxB1eH60mt/qW6yS
         526BRrAOp6S3GIqlXpnzaNswJaNaNlt4w+8t8rOFtt+tQjJavh3ilZX86YgeTGdCpHDU
         Gd23vkeK4aFLGSvcr4KmOyE3XfCbRWXVgjQm7dHjUo0Qv4grOMeY5a9KPpE4ow/XGAhb
         nsGtUGRlNaZLaiGOJiA0NErfc4Ef24CaJiB5fSOYq7vy2FGQIpxx6xqBJ64mS28CZUAv
         YQ90CTWMvdtOmoP2eb+1IZ/UvwVdDbD8pqocuW0uskxelPiYZ5uxn3ts4kL1WWE/y/Vd
         VTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286645; x=1729891445;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cu3ywbeiueAiLpZlAoRlOExXhdy9SqJHCZ3asIlIMCc=;
        b=Tw8PkbUI7+hpUuFF3DXyGu+8E/Ce7vXjQKCHlD+4spnVxm8wIhYIOR2ILhBMlN4p69
         iK169z4erA+e0W7JuRNTOozA/SO5g3niuahGyQ/ZFSroBBcyaEjuJpbxI8XslxGnnGhK
         BQnDmDy3ipjizimLmgPEf+wtaykfVzIb/fdCQe1rr/dhqnYPcM43zHb7y/CrA8uKUPmg
         yce5eL1okeGtLttXImDXgM/llA+y+nVQjhn1QRN8pT8tkJT2eXbidBebnN/s4D/XlS04
         SdTePp25H6CBRQRv+uPJjUqnbtTi0DCO/dT56I+GiTjre6lqiNt0jK1a3+cxUR+TuZx2
         sflg==
X-Forwarded-Encrypted: i=1; AJvYcCU8IGzhWFIMKGsN2CLxJnNefWWHcXn3h0JVQoXbzwUKv9NnhN55sIAaTx6X133Zr+5P1i+VdsdygKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWHfBgibmNSD8bOev+ujMdjJN1IoL3rKFpBy2WzVd5XuKxLzc
	tMRpDf5vtFowg273wG9eOTl+SjEWovTv907CzHf5c50/1WxsUIQOYhqCJ+zUhEuTVe1Gj6Bcbfg
	p
X-Google-Smtp-Source: AGHT+IG96hABqMhdjCx/0hJEiSV691+QsSLQw+YPEtTi9KNT3Z86pZV8qtEDnp5uMzq0c6TALZYKhw==
X-Received: by 2002:a05:6870:7183:b0:288:b7f0:f8fc with SMTP id 586e51a60fabf-2892c5a9404mr3647435fac.41.1729286645453;
        Fri, 18 Oct 2024 14:24:05 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2892af3f393sm683309fac.38.2024.10.18.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:24:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Oct 2024 16:24:01 -0500
Subject: [PATCH] iio: dac: ad8460: fix DT compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-iio-adc-ad8460-fix-dt-compatible-v1-1-058231638527@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPDREmcC/x2NQQqDMBBFryKzdiATojW9irhIk7EdaI0kIgXx7
 g4u3uLB4/8DKhfhCs/mgMK7VMmLCrUNxE9Y3oyS1MEa68jQgCIZQ4rK4HqDs/wxbRjzbw2bvL6
 MnubOeE8Pyw50Zi2s0X0xTud5AbBCE2NyAAAA
To: Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Fix the DT compatible string in the of_device_id table to match the
binding documentation. There should not be a space after the comma.

Fixes: a976ef24c625 ("iio: dac: support the ad8460 Waveform DAC")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad8460.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index dc8c76ba573d..6706c8112094 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -924,7 +924,7 @@ static int ad8460_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad8460_of_match[] = {
-	{ .compatible = "adi, ad8460" },
+	{ .compatible = "adi,ad8460" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad8460_of_match);

---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241018-iio-adc-ad8460-fix-dt-compatible-91f5099172e4

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


