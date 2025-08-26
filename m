Return-Path: <linux-iio+bounces-23312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594AB372C5
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 20:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F18D1882848
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61A371EA5;
	Tue, 26 Aug 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOkhu02F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E62F3603
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234777; cv=none; b=q1CqFITN9MGzHyuUJazNR2BoBzo+7RgKZIaiOPcgn8DIok5Jl/T/JZLQzEJFI4TipXSaTaZuD/C8ltUznvhxVJZaAVDdA/o70gjbrAI00rC48WJNROE5tN6+/+eKZh+sDBSUuqg6za90ieQ/N0GcZmiTrhBsv9qlmj7CP+kwCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234777; c=relaxed/simple;
	bh=PXhHRnVdWtjBaKmSaYCtoLI6A0W2o5SRma4C+6touTU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JQeA3OV9m/0U5X6XgaxhZ3tSLq1BPR9UbjSCHuXujsTtL6iqgnbwfkt06k5GFlWH+Wv+pobyxPPrzZK/LdqaVsd2VxAdSxzfTLy0skt0gz/loxCKdU/zgIShMG22Qp6N43LziiUNR6FbY7ipVFJL+M4Q0DO18oQJb2RrfPS2fec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOkhu02F; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61caf8fc422so362285a12.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756234774; x=1756839574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DKtEbCA2vknB1KJWr9VH3PpUW8aBLTZhAjkkk2SmOZg=;
        b=IOkhu02FvOswMD0ZNF1MyKjtXEE/Hboki+mGQu7l++CG2CWLg2mshvrCuQVDKOeRrN
         fBfJ2tqESLrhIq/sVTOS3AEFXUOqM7QBCrcfCQhK20woYmVyEdPT27DlxqpHDmrv1gX/
         LyifT4IrK6AjccNXHYSbsRI9LILW3dIigy/vlWoxWl5J0FRAOK9T24LBQEZzbJSXhSca
         7i1Lv5HQDXIj+tB4UJbSU/+jKwNytHMGd4q8bMlLGSMK0nM/LrjBGhJ6sYYOBmybJpHg
         xAETT5kNWsknn4CHwXTAGGb4ZtoA0uHb8TCLZlG6uWfs8cHIXnoi+JetUiU4sHiYdPUn
         NqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234774; x=1756839574;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKtEbCA2vknB1KJWr9VH3PpUW8aBLTZhAjkkk2SmOZg=;
        b=s7w7y1y9x7FJ47XjMRDLtUoDix8WO7/NeK007y3k8XW+l7nF/fQ0x6Q6Aq962mhUmi
         CrSR6DBRlXDpgj0p8xZc20QgY5RCc5gRLNppknekjICHXPes80wWzLq1hDBdiuqzp9x1
         f+WqXCAjWbUChyKjoZsZ4+q/jiqxeWu208pd0UEtywbDoRo8J/oh5zOE8wz1mqT6LS3H
         j8syH8mkfHMjKNpN8gUEbjcSP7uYLW4fdmcxXfyxHGMzaj/iQHb+sotEcnN3idy6LLR5
         mvh8kbTngYLa5aBT9BmdmmW/Jxm4PDPOReo5ovyKZRDdoQkynPkXxl7lu2VB/ZuMLyuB
         mM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtRMQq0SRF5NkmstAC2eNlVoGMKdTJ4oiIeqsYodCE7cXvfEvzNfbSfgNmgmjIxRINFXEwcCHHep8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPHullhksfDtMsaGU8vgtuSAeqiAo1ITxEu5hBg7fIUeYi5BN
	PgcjT6eamxhOy8mt6IlpTa5NTUsL5AqiK00XZLW11WUNCIMMVB1XTnHB98F4Rj5kzMdBgwA16fH
	XuDbNsxU4qP5rTsQ0oMDFHcHIyUjevRc=
X-Gm-Gg: ASbGnctwkgL/Rsw9R4RQ8Ux68euGE9SnSSFTQGCjD3W8dUH31VFt7W7FO158JMiormj
	tusvxBjyrVfSYDBHiWSFsBNFQsmWMWyxdxQl1/M867Mzr8DLE0pxIYTb8h+XE+BoX3Vm7sdntFb
	5AU520R+OQVuoW+Fm6cI7txu+b/lZR8AaNgEDxWUYUmzR8ICMqGOHCdeq4vo73JY+3p1sT3S/r4
	O4XGMHBVxUFKvloRzZic2zCFUIucJtB0Qc0tiR7nw==
X-Google-Smtp-Source: AGHT+IGfgAqHYDatvKqLbESii2a0AQ5a8M1036uMntISg6ij3AsW7eEWZvrAc8vyHm7qBNqWjU+ipC7HKfWEYLBertc=
X-Received: by 2002:a05:6402:1d49:b0:61c:926e:24fd with SMTP id
 4fb4d7f45d1cf-61c926e25dfmr2702995a12.34.1756234773551; Tue, 26 Aug 2025
 11:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 27 Aug 2025 00:29:22 +0530
X-Gm-Features: Ac12FXyY9CLw58IHIPNzy-h7bUmDUoEwizCgPPXQR0eGGMnoF2Tbt978pnhYCM0
Message-ID: <CAJE-K+D_U3F_61vzXPHDZV_Rm4Jzd--nO3yf083g7-0=Hh7OFw@mail.gmail.com>
Subject: [PATCH] chemical/mhz19b.c: Replaced datasheet reference to new revision.
To: "gye976@gmail.com" <gye976@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Gyeyoung,
The previous reference was to datasheet's v1.0, newer revision at
winsen-sensor's website is at v1.7.
Hence made changes accordingly.
Thanks
Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---

diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
index 3c64154918b1..05e739e962f0 100644
--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
  *
  * Datasheet:
- * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
+ * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-manual(ver1_7).pdf
  */

 #include <linux/array_size.h>
-- 
2.47.2

