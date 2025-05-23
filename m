Return-Path: <linux-iio+bounces-19839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC437AC2BCA
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BD79E351D
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6826921885D;
	Fri, 23 May 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ9eYhnu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADF214812;
	Fri, 23 May 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039758; cv=none; b=Q0xWBAOIZ6WBPzcLhE2Sm1OCC1UVO6ILfx2UAnJD+YasgkYu6NCE4ZuHuAH7u5MDDpSRZvAWqXbT9xiseyOoPuPYC4DiGB46+DyFGL8ar3emYO9Prh1IIbaIfbAosQJ5+i8CPaV42A+8Ut1v5LrbTGUdVXTQYOTAxUe4+zkzf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039758; c=relaxed/simple;
	bh=R9SpEhuEyq4ehpvwcZNQlf9/1GWukf4Pqc+Kz3sbR5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KrESBJVcCHmaY833FmyGi0mJ0JbqtvykxpayCLkfr1I8X9/+eSpOEeS+oKK/UiyjcloAgoYWJjmUBAi9e+gzKhd+IRGJE4XesPNzovVP1sQWDY2h/q/AMhvTc0dRYvrpLHY96f9p9RdHyeLKO/yigfQz2lNaOV5pGXONVadp77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ9eYhnu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441c0d42233so46195e9.0;
        Fri, 23 May 2025 15:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039755; x=1748644555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDb8HOZ4Hp1UhkfaoOAEXCBy8LyAOlXzYwG5CU8w1+M=;
        b=iJ9eYhnuH1W79xABL/L90CCPmjtmj3ygFGPunjGUE1EEOxmPWVb9dNpuWeulhxLmPl
         bMo7RvwOM5kITf236OmMe1WBHHoPbsG7J//55YWw4PrP93BOux2HqW0a9EwibvljjnB1
         oqGCrXC75jak/PKewpzpFJWhD6gcV+IjdjYr+U2IBispboleAoaZjrzwmw0SdcRPw+ao
         D+/FE0ccOcNCaOgv5IyRUSLCRfIAC+1bArrMerYZt0nmz5faKXJs/CIrZX+q2OPbbixe
         l27dN4iYv66UhnawpFK99GWNcnNh1RczcdgIVtfOdjB9sD34tIIEt7M2LMmMqgWuCq//
         OhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039755; x=1748644555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDb8HOZ4Hp1UhkfaoOAEXCBy8LyAOlXzYwG5CU8w1+M=;
        b=NTTK5upzeo1zg9vU7zJ/uy6RkPSvLF0jDP9gWKwr7INCKbczc6/Xl3cD4x8vjlCLNS
         hl9jQz/JnVSJAUCtDy4munNVjJ77uyE0RODiWkhIeA8El8b5GQ/+y+i0y/rOq1CLwDZv
         BBJhgQCBl94j+FYmYDztCux6hMLO4rlS5uftJm0Race8WhKbImU+axPsDdpS5NMJUQLj
         iYV26/1LBCXZqXlqaoAwvYQJacAN37Z0OhyLIfj6jBP+epDIxpDqVnWXuyRU8+5catqF
         vBxqXP/6ZKII6eOorYkAvV0dQWq7NhxSLMFJor+LhVLuKS/XNqKoDgsN0cBml7Nz4SCx
         IMGg==
X-Forwarded-Encrypted: i=1; AJvYcCVBgDnGoha2W0LJLQmcVwC2t6sa9wd8adT1xCvvMRcTDyNUFioYI8KYdvJChssTJrrIGR57wHltRag=@vger.kernel.org, AJvYcCWzpenTEBeazEOjedFI17BMR500HUvwEVuEy1icqUWopz3n3rD8mNNib+CB5QyIBnzHyq0o6LBePfZkuJek@vger.kernel.org, AJvYcCXRAiRDZ2iPRgrIG47sUeWISsS8lbgZTkrpeBPvZZY2npf1mmwVdCKFbZZWriraEsdwMpXy1x17LJ00@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfsnOW/23AVyT4eGXbC4Yea0kjnRKv4rvFKErtW828O2WG4wP
	C9SarB4z8tWfdY2QNxdfX2kxP3b8/VngONRk39WxcxIVhU/YonZT+N+2
X-Gm-Gg: ASbGncsYS5yWtiAaqdtgb3v0mHV4F7EEd3Sjy4IuXtPGgw8Twdhi+bNjG5fm9Bbf60O
	1XmZCOu09Ug0+6bESSeUOIVk9ccfxK3/xrctY1hlUXZjsioLzEUxY2E4IVMqCdx8cgMY0LAqYT2
	1Sceygst/8YYUXqOeP3Yk9nn5iOlV30RlGDXh5ZeyFuM9qlgoV0+MpxhAjbfD6wBYzbOKETMODW
	y3EZhTQBGsFny9sXaW8ldSZq6n+LQlHPuSGwJzBzNVSzC0l1RQMtaIk3xY8WiECJNoKweq3AGEZ
	hD7LFkO0R8QoyPLBhNHPeNCZ7Xmh602qtRxlK5m/aSgFQr1kOwBsLOP3+xtA+lVWC4Jj4NTHQSA
	znXmS8l67MR8lMKLoPJQUEg==
X-Google-Smtp-Source: AGHT+IHasaFyvwz7OBw3C+IEh/TTwBk+zDyFURKHmFCDeEDfTlp3VPhHyYrM3mW5qFJPxbvi6+SDyw==
X-Received: by 2002:a05:600c:1385:b0:43e:94fa:4aef with SMTP id 5b1f17b1804b1-44c93cae9acmr2170375e9.8.1748039754794;
        Fri, 23 May 2025 15:35:54 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:35:54 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/12] iio: accel: adxl313: configure scan type for buffer
Date: Fri, 23 May 2025 22:35:14 +0000
Message-Id: <20250523223523.35218-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet the ADXL313 uses 13 bit in full resolution.
Also, add signedness, storage bits and endianness.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 9c2f3af1d19f..06a771bb4726 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -184,7 +184,10 @@ static const int adxl313_odr_freqs[][2] = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 	.scan_type = {							\
+		.sign = 's',						\
 		.realbits = 13,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
 	},								\
 }
 
-- 
2.39.5


