Return-Path: <linux-iio+bounces-20751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E89DADE191
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 05:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FCF3AD290
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1281C6FFA;
	Wed, 18 Jun 2025 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExE6Hxjs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A2A932;
	Wed, 18 Jun 2025 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216646; cv=none; b=uLfV6AqvgSPKXn7fvBnrmHJ477Qf0Z9Y4Qi+YcWTdQdlmpwT5+kOB4z0LPz/twoqLYyLAsHQVUgcM8yVLWcQFWKrYnHMneVnLxdAVbh5dPc5cJbEr1XuXXLVwn3pJW6Ae3OAcPE+UJwRAqTQ1smqEx5pn7BBA6/JKn1KGs1/AXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216646; c=relaxed/simple;
	bh=PSC9uwFmqurhpZtLHXOgxkWlEluD6N2z6rNFS1ks+Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8asJDR8l5ltWYGLME256QxmMAEXFLlaOxqBrbz3QtJxQ46H2omNvj75Ge/rKvGVFPJlWohRnx3oJHp0skaAkToKpzgu8k32dxtee5C5n5LK6r5EvCrZiky3cypH2bMD9MVkxRsKuZ2AnROeA2h9Xxqh8m/txGjdpysXwzcH1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExE6Hxjs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235f9e87f78so67507255ad.2;
        Tue, 17 Jun 2025 20:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750216644; x=1750821444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQGaLq2baAwhJzTt92V9qBoLp4XNZKm0/A2Citd6R/U=;
        b=ExE6HxjsBWBW5+SftaDQPHIQJOTmZrokd+fr6Hff3py7nCXHAGf88fGj9DtmQBDwB4
         p+WUfRwczjOEM2Zg+OCCYU9IQZrb++LDFLkc+bnsHlqlYBJFEVjgFj930EkmypuKL0Vj
         8EZAHLzvixEEbxBypt30WWPyhh142SFTBl0XNxPFhanjWDozUSelucuP5Es/j3go03vo
         qUEPA7zxp9sTsCtcGoFvFmb/0gtM/I60Ykg+XaN7k6E9nW0vZid90J8KIGpqPf9VZm+K
         NIkhvKOYzx6HYp6iQlOfseTrjlG3LAPdAfMwPL88EziCYS5g+VC1h0l864NoZWKaRfVR
         /wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750216644; x=1750821444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQGaLq2baAwhJzTt92V9qBoLp4XNZKm0/A2Citd6R/U=;
        b=dKL+P9+1Ixba/Xle0im7MfeuqAgKzXZC254hlRNmFgid5vf+NC/XxZGzKuImH6m3VK
         jx+HZvmOpFQV2uc9kvS718zhxFsqnU5s6uxeT72ihAfTALsaaKYcL/All6emyo4fvcAd
         mK5dF43NTeLwOqDicq7HMvc4Fr+Pv+jboGflYAPjigL3eocLyF16THzGD/jkY7jZmDCO
         azQAdtZgPJ/ur/xYwumb/jZRcW3ptIA3LPbRRTXImpsUPLmKyny5sWLvL0YQnhOYlULR
         DlnAR8gMpQGlh1bV83FidaZj6Em8K5xp7RqzqgXy/ngZGqmso9nQhdR8FLZHrFfh9zzD
         bxBg==
X-Forwarded-Encrypted: i=1; AJvYcCX0JHUU9I8pHKOpDwI3hETfHZdpEEj3kXJbFW0fsl2E9acDkicIgQFRSd25Px4Pf/iXpqLkDnyZcpI=@vger.kernel.org, AJvYcCXTSLZHtgCNHv0kttuESq98QMmABWqbv2J8rnsyWv4lUj9H8EUzsgkQUEyrHpsLY+X2EBBes1wSpHelyMdU@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0iPXqvZ4+t1SDcaaO11sM2nWVGMwVAIJ7SpqXq190H18i09u
	wy1GXFvQrzezqoyv8+krjxlzXVSLKILvs7G2OL6MzghwMtlVepZDWHTz
X-Gm-Gg: ASbGnctKGYOP5jLUAzNeaCa//FSSbeZezX63nT2yqGwzwQj6tumaf5PKIiF9AjJhWjR
	iYFH66vaHycfbe9KQ5FbFaQRajK8ijFRY+5o03C4R3rln87uUjhPE+1UxhOwyGSbaMmBvTpI7v3
	Z6HWS/ieu4IDIEJSUEcAWTFnCvCTZt06iP9hQLzw4H0No2lwBsy3eaE1RBUuoMBXayFzyThHb6l
	vDWlMUgtoMGpg21Youk4xNeIvwHPz2OxEvWjac5glog6Un46CuyECB0r1GK330F2sCc4KHVfVrc
	VNmLWis/gnRxxUsfeCquu76UQLRfNhEYAQs54LkoQKGU66GbmqI8C65nVi8YZVXnLQ==
X-Google-Smtp-Source: AGHT+IEoChv6n+emNe4ei9eRrB5OBtaHmbTA5+MJDZ1rMtxjXRKiy/fmwd4ch4Ac3ZrpycCLvS+JPg==
X-Received: by 2002:a17:902:d510:b0:234:8ec1:4aec with SMTP id d9443c01a7336-2366afd3a0emr194909075ad.6.1750216644524;
        Tue, 17 Jun 2025 20:17:24 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:31:2ce1::1005])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm89179545ad.239.2025.06.17.20.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:17:24 -0700 (PDT)
From: Andrew Ijano <andrew.ijano@gmail.com>
X-Google-Original-From: Andrew Ijano <andrew.lopes@alumni.usp.br>
To: jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] iio: accel: sca3000: simplify by using newer infrastructure
Date: Wed, 18 Jun 2025 00:12:15 -0300
Message-ID: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sca3000 driver is old and could be simplified by using newer
infrastructure.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
v5 -> v6:
- break up changes related to read data helpers in two patches
- fix formatting
- add local scope for switch() cases that use guard()
- use sysfs_emit_at() instead of sprintf()

v4 -> v5:
- break up the changes in three patches
- replace error_ret labels by simple returns
- use spi_w8r16be() for be16 reads
- use guard(mutex) for handling mutex lock

v3 -> v4:
- clean the code and remove redundant operations

v2 -> v3:
- replace usages of internal read data helpers by spi helpers

v1 -> v2:
- simplify the return of the internal read data function
---
Andrew Ijano (4):
  iio: accel: sca3000: replace usages of internal read data helpers by
    spi helpers
  iio: accel: sca3000: clean sca3000_read_data()
  iio: accel: sca3000: use lock guards
  iio: accel: sca3000: use sysfs_emit_at() instead of sprintf()

 drivers/iio/accel/sca3000.c | 384 ++++++++++++++----------------------
 1 file changed, 145 insertions(+), 239 deletions(-)

-- 
2.49.0


