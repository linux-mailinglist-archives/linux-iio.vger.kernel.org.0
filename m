Return-Path: <linux-iio+bounces-25496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC8C0EE0F
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF626426BFB
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6D43093DF;
	Mon, 27 Oct 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbz1cVqZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9652E7645
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577655; cv=none; b=fRsbuXKOXJGewqL5EiPE1SdnrYNkfSUx7qyT2KtSOW5F61XLHvyaL/UMNSJU3Oo00INPpBZa0pHhoe7yM+PzAmxPRRUEkaRBs9ZavSioZSKBbUOy3J0P4LctXeYK1Rpyqq+h1DEwCFimNTfZXsdHYGPb6aV5DB20aoSo+I3Wlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577655; c=relaxed/simple;
	bh=4KYywOgTHGEIz3ZCocUr/rj1P+mUN7k7cfPlJwv4luk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rTkrMbh/ZfQ3h53TDZtW+WlF2qPYlRom8KzirFy14ltLdBkxNEZkZ3NT56jmsMIS3talA7PqTjJxRBQsRty1Weaew4xUTF7KZG8Bi3bhDIUMO3//ne2jW6YW1Vanq1amj8S6qOcDNRbQC+CsZPJz/yE5dRGdD9RmW+wq7mcbegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbz1cVqZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d3540a43fso48555215ad.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577654; x=1762182454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz3ecQyWxC7VNS5GAYBhcfKzMJ8mPoJ6wolDlF8Nh4U=;
        b=Tbz1cVqZGseSwkIvYl/wlayY15FjFoE2rDnTwV0OruwzSlj4x4LuWngEEAf3cMNaK4
         M/SCCf0W0Awo57RdGfDSyBh4L7DeUPJPkEB4KgV/okxGDwIp8imcBeNDmnw0JtDGLL4i
         Otj6XBGoOk1Tp0QNr2hkAyDRh3Aaw7DTBPlLj5DXcXnlVYyhUUTGJt2lpnoPB1QPf+Qp
         /bdKfs2N6qrJ5QCWNmpgQaNeYT+GrLLSz151I4TUNdxReaMpzsGt7Df0Mmu1rvYKlTA0
         V3YeB5qM5SaOvhOOkJ3xYgRH6sv1ffXOncYMPE8tKKY2lElCwfi+YTQRIx7nifmZ8Fc/
         NjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577654; x=1762182454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qz3ecQyWxC7VNS5GAYBhcfKzMJ8mPoJ6wolDlF8Nh4U=;
        b=JNqDbevgaHWOi74l1Jr+M7NnHsGuwjz+tAxKJ2qVKy1YayUUe9ZbQPlX7S14KI97fj
         MZfiaBPgnPjbjzsfDVftfk6FfKYrraXbr0fKCGsekBN5Rqh47HNEOAbLU8PrFlZxi84a
         nHjugIwPU+Jsti6YPdMxT4LnDPFHE3cfDTEUJLbl9sGqf5lU2tcWqUlp+g8UFoztBGX5
         72iR/cig6broyeooereSo2GeTU2zyb5wEW0Uhk2iZhumDYYxYhHh/1tGCJFkqMA4Ciog
         7/8NW6EhnSO6osWzLpa3x7rAXXU0xnjPzHZVMc62SlLUlqyTlwBkJW+WMSZCS4Xo4nBA
         Jedg==
X-Forwarded-Encrypted: i=1; AJvYcCXU0ewdyEJfnSZdWANlkpct/2/QYDZYv6898jwtDHiaffUmX7l3nhEt91NeIRWIVKCa2fRr5h3DJ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSaZydqMEBFqtYC0waoCrcR3SIgN0r+okr/jb8MkmiF/B0eTS
	Kr0zvsjJnjgSogrsPu0q1Z2UwN+1xbqYnLu++22aTX2nbQxTmve6qaHS
X-Gm-Gg: ASbGncvNLRIV0igzlBhZPx/oHQAtHiVUXECc4sIy1PFsh+JaM1SfHCa89IqlXZu8V/L
	MnP0BC31pCHr4ECNvfoNXaHjeVNbhrvIhJ/4T5/InheSfyMODR/nQ/WhEZsbykS2DKB49N4eLD5
	fp7u06rCqYWTswgACixIecCO2VEfIGHssB2MEHYn72hNJ+PcKvylFaqx9iYud7MMhl+3sBP/22T
	IjIpKMJ+m6YTVFjk5pZ+9kojsLk6UtxU7ufThHg8Wo02SKNh1fjlhEE6B04aqB0ki+gKlMRclga
	2p7C9JnB6R/8txs8AtxAAWw1cnxXtQpyvwkY+kaA9xTheNkEV+sho8Cnh85fdTRkWSHbaUyecco
	ZBl0DvMqeFRrTgJnUPLYPn4NxsE6+QMYO+GXkehQ7odZcAVpy9mu6GwPoKCat1vUgdDMNIvvycW
	cuDxgKM2h9LeJfmeuWF44CxXWhy8A5pPI3
X-Google-Smtp-Source: AGHT+IHFy+IMljdrhVQ66DQvOfteh6iHx3cumDuMAgc7JMxc9hldJM3AHM32ikGVgmmr//G+ptdz1g==
X-Received: by 2002:a17:902:e805:b0:24c:cc32:788b with SMTP id d9443c01a7336-294cb3693b5mr2991405ad.3.1761577653775;
        Mon, 27 Oct 2025 08:07:33 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d44db4sm86422035ad.86.2025.10.27.08.07.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:07:30 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_source
Date: Mon, 27 Oct 2025 23:07:13 +0800
Message-Id: <20251027150713.59067-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When simple_write_to_buffer() succeeds, it returns the number of bytes
actually copied to the buffer, which may be less than the requested
'count' if the buffer size is insufficient. However, the current code
incorrectly uses 'count' as the index for null termination instead of
the actual bytes copied, leading to out-of-bound write.

Add a check for the count and use the return value as the index.

Found via static analysis. This is similar to the
commit da9374819eb3 ("iio: backend: fix out-of-bound write")

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iio/dac/ad3552r-hs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 41b96b48ba98..a9578afa7015 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -549,12 +549,15 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
 
 	guard(mutex)(&st->lock);
 
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
 				     count);
 	if (ret < 0)
 		return ret;
 
-	buf[count] = '\0';
+	buf[ret] = '\0';
 
 	ret = match_string(dbgfs_attr_source, ARRAY_SIZE(dbgfs_attr_source),
 			   buf);
-- 
2.39.5 (Apple Git-154)


