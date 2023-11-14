Return-Path: <linux-iio+bounces-64-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC3E7EB731
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 21:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A36F1F25A9A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 20:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19C35EE8;
	Tue, 14 Nov 2023 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLDLQY+p"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C035EE3;
	Tue, 14 Nov 2023 20:06:05 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341ACA7;
	Tue, 14 Nov 2023 12:06:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d242846194so889417966b.1;
        Tue, 14 Nov 2023 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992359; x=1700597159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEOYqIoJdVSkU55czPwf7r14EQRegDnx+cT+pdey7ME=;
        b=KLDLQY+pfZEOmG86b/6qicCtNLU2yo8gGVovIVcR9D5HYS60stJozyQGM6TSey/Q/3
         liuDNeHoWb5a2ooHVJiPtgoKmTwSbELhMhXCrb/gmnXv+SBmFKpFl1hDOH35nW6nfA5v
         PY2RQpCB0LQz+rA4P1UC1/sZPEoGs2N51+b8EWpZ237XG8yjGDi8Ufb4OIv3tJZr1BtP
         s1XExsahW1Hl2gdiNtCH3/3CeBgmgYbuz2+oMRWNu4ruZbvrZlLF6e37mFSM7SqsfNE0
         DPFZ7eAIfOHv3m6v3j7y2BKNg6y6z+9ZDfGZhg/EblFTF2vex5awy+NlCfJz41ZrvOzq
         M5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992359; x=1700597159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEOYqIoJdVSkU55czPwf7r14EQRegDnx+cT+pdey7ME=;
        b=geQhgoN3hS4SuJBwsCMUIK5FUCRzAF50oTr0BGI6ZJMX3vAlQtoG8QhbGzpwyCIEVP
         nruB2tg//3a3uOyJK8FG9xRUDIZnhUG/AGqoOY64Bg6X21AwvcgYUvQQv5Cuowv9LVIY
         J+1gzLkMvPiymoQEtuHQ/ytjx6lOXGHzoawhxOvZ/5sqJOzkTEtTlQZrygafBOYvWl7+
         yiG/m3gc7gHxgmc98TRhmNhZuGsgWSwsaSF9iNvEGvtPdy9dj7+6qUuUspmR3FZ/6JxF
         ECquOcu3n2gLy1SHMCN64/Fp/YPNSiMKWR555/FbURiVB1lgRAliMPY/iGPoDXH+hTIW
         rRUQ==
X-Gm-Message-State: AOJu0YxDCy2nQykoqxHvaJ2kEBbJI3EjzHRgy7hQM1epsvRnOFIrkRg+
	Rus/wHhmcPgxRNpy4YGbgj8=
X-Google-Smtp-Source: AGHT+IGO7xk8qyDNVRUJnURRx+A/R/f81R+s7A2poSDsiwOfsrandMhDTXba7YI0/JIGJ99ZPPEpRg==
X-Received: by 2002:a17:906:6009:b0:9c2:2d0a:320c with SMTP id o9-20020a170906600900b009c22d0a320cmr6690935ejj.46.1699992359409;
        Tue, 14 Nov 2023 12:05:59 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id me19-20020a170906aed300b009ae587ce133sm5984429ejb.188.2023.11.14.12.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:05:58 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: 
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iio: adc: ad7192: Add support for AD7194
Date: Tue, 14 Nov 2023 22:05:29 +0200
Message-Id: <20231114200533.137995-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Thank you very much for your feedback!

I am submitting the upgraded series of patches for the ad7192 driver.

Please consider applying the last 3 patches in order.

Thank you!

v1 -> v2
	- new commit with missing documentation for properties
	- add constraint for channels in binding
	- correct pattern for channels
	- correct commit message by adding "()" to functions
	- use in_range
	- use preferred structure in Kconfig

Kind regards,

Alisa-Dariana Roman (4):
  dt-bindings: iio: adc: ad7192: Add properties
  iio: adc: ad7192: Use device api
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../bindings/iio/adc/adi,ad7192.yaml          |  84 +++++++++
 drivers/iio/adc/Kconfig                       |  11 +-
 drivers/iio/adc/ad7192.c                      | 176 ++++++++++++++++--
 3 files changed, 249 insertions(+), 22 deletions(-)

-- 
2.34.1


