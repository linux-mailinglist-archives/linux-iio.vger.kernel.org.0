Return-Path: <linux-iio+bounces-1449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB0F82616B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jan 2024 21:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C718B21B13
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jan 2024 20:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E2EF4EA;
	Sat,  6 Jan 2024 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Brxac2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40AF9CE;
	Sat,  6 Jan 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3606ebda57cso4700685ab.2;
        Sat, 06 Jan 2024 12:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704571716; x=1705176516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXNxkr3v4Aky/lEHFcXkSVjC8sUXM+X/50CODylpRWY=;
        b=E1Brxac2wwMiSY9G0ClyQm575xy+ekeAjbILcIfoIRiOqNtC67fpC6aA+XCm+x6a6w
         Hd7zPBchCMDIUyJIhFcz7/1qX6zkzOuvYT9NGZIUw84AozGQzyJL6HyN/b01geOqOSS7
         zu+6NqtTbj4Yq4Y4lNauPDTJLJ1HRsdpQUQ7YYEwmYSyS0HMcrmn0GdoAHDnY5Zf++Lg
         nAuX9//81cpLuhz3meT/fGBAkbgd8fZ3Ih8lauqz7dqkAftlRfyMgWqQTjq/eS37gte2
         /os+RxMkpO2Rcjr5KtCGyS5wZyuPeyT7+5p0UHKBn4bSLoAt1a4wDNHLrLGaVBQ7eko1
         6v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704571716; x=1705176516;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXNxkr3v4Aky/lEHFcXkSVjC8sUXM+X/50CODylpRWY=;
        b=sT8zd1qY3y03V8RpIf4JxkQxxrN45z1mEUAMb8MDEuPQkXKbP5Av96kCdwgmulkYrJ
         CxXs7q3/h0jztEmdgLN9gR2vAw9d+K5P9CMqsCjWNv8aRtKncJGg9VKLr3zQVxamENQE
         6MLJbFQL0Vw4Bzj6n1AYFke10xTVCqQEhvURFU+kjKSJtumlZmcDWFzSNdG9+NArtYMZ
         6TOKZ/8rzpY1tI/jhNoooW+MNuX9H152gMuwBZPfaAhLH9pAFrTCAPz/DByx5JPlHGsG
         tFG3I7hZlTyv0Dwh87qCkMHMvR8/uXnxDJru2w44nO53vwJMHcwv87dcbhhwHso4LVZq
         c3ug==
X-Gm-Message-State: AOJu0Ywau+pLFPO/6wYFQItR9SXH75zY01P+jdm/9dAxSUnGOgWSe0sR
	FErBxPzdO7q2EYaYBwYnGyFxDI+WTKDkHSdJYYk=
X-Google-Smtp-Source: AGHT+IEOd/bSFvEMbezynf8++AlkczOl16jAacq29PwVAsQFkJ51JFqNSzR1xnKjJzp6LqnBU1lE7eXCBj/fHa/dgp8=
X-Received: by 2002:a05:6e02:216f:b0:360:e7f:119c with SMTP id
 s15-20020a056e02216f00b003600e7f119cmr2463525ilv.34.1704571716148; Sat, 06
 Jan 2024 12:08:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 6 Jan 2024 12:08:35 -0800
From: Amit Dhingra <mechanicalamit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 6 Jan 2024 12:08:35 -0800
Message-ID: <CAO=gReEUr4B+E2mQsSrncHf41f0A915SuoWgA522_2Ts-dZbSg@mail.gmail.com>
Subject: [PATCH] MAINTAINERS: correct file entry for AD7091R
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

File entry has driver/iio/adc two times. Fix the file entry

Found by ./scripts/get_maintainer.pl --self-test=patterns

Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
---
Patch based on jic23/iio.git:togreg branch

I don't think fixes applies here since its not in the mainline yet.

Original patch series Lore link:
https://lore.kernel.org/linux-iio/20231226154509.450c5e40@jic23-huawei/T/#me0d2b8d5ba2f9c46dc8e72ba49b7e6ff14b761c1

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35147477e8e4..ff61be50e82e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1128,7 +1128,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
-F:	drivers/iio/adc/drivers/iio/adc/ad7091r*
+F:	drivers/iio/adc/ad7091r*

 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
-- 
2.43.0

