Return-Path: <linux-iio+bounces-27948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39871D3A503
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FF5930C62E0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066963016E5;
	Mon, 19 Jan 2026 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W4ClVlhP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DBB2D839B
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818202; cv=none; b=SBi1sqDCFsbfoctm+ay4/UTpRXdjbhnrn1VlerCxmPc/qXTRNukBM0tzLZcNZsh45+gBnEFpTny6NbQ5w7scrgdzYIz8UxKe+3njs+EcFMDKvXLyn2u4fpkJVviEx//tyHAYuXRmvgwTM4paPrYwtZ+u3Rg8jt91ldcDjS/dT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818202; c=relaxed/simple;
	bh=2BNgD7iR2Q9/HS6VBWEFWjcwEzW6/5nVyyIR7pF8ciE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PzSXe2Nj4V2rVeZX20a8/P3CfCAEb+obQsMK29G9DtAfxxMww0JYzxFTfm0eIfbZqwedv6uG+BepipfL4Gz9XXypvq9Q0oE2fURzqW5YU4VclijkvYUxW/IRMLSchC3ZvuEopLil+Peiq4ag98FnUFMLsmECj8eF88+7fnkHVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W4ClVlhP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso551838866b.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 02:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768818198; x=1769422998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=74b+U46eL5lzvB0uO5H9TUJ1nFdc4RAgp2qGCYfxwUY=;
        b=W4ClVlhP1MyOKADs2+UTsZiqUuy36Q8I+jKe9gwqG3DShsOVWI3rMTFrT2vh54tEPM
         fNpN3nHgh7pAso5Zt0ZtcpETLUwgVcL/dyatsbOV6HnCf9VUx0WYm/hjWAwnK99zmM3X
         lprb2ylrzsYYRVONEB2A53EyfYuvjXQcPdQLOF5Ip4LomI33NDvm09jSwF5g28D5rNz2
         mJ1RoSwG0mZ7sXvXYRHMXs6K41DsOZ2si3DMuuDnzUVrDst+85f5AKbPCpi2rDSV5F8/
         THIRwd8IzYw1SVQjPW4pKnPb0S2fK9zwF+KkLXRSvBbD9o/8I6s99D+FgLDbllGmCl1m
         7pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818198; x=1769422998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74b+U46eL5lzvB0uO5H9TUJ1nFdc4RAgp2qGCYfxwUY=;
        b=YBHhdsdrlRJAtt7EpM4YzfC3zwNwcZU7mGQ5SREA91QRd5iZc0UGED7KqYH7si53p4
         Nj3DFW41dRla5hqcZYjFwHx8hKygK1oh0slCbDPD8ftLhO806V6b/fxW8zDOxtFd5bo8
         uC2ugcvQNVjuH9Zwmok9DiHgmObTg/1SOJcVKDIzHLsSZCEj6wIhp72d7ZjAEPcC4k4x
         3oFZmwsbeIG+dfcHD87p497r1EULlLml2jZvoMa1w05VdlfjXf0qrBhly22t7A+CaB61
         O5kvQNV0D/Ob5l2q3q7xY+OyvNmEg2Q8ez4n2qNce2TCr0f5zePO2ASqg19uEssC1WmG
         JBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCIWsmkkzuwZnq/1NaLjKOtpM3zEuaWITK+ZSTzLkl75x4NZSocsghm0/hX3vll8Wow8lQoHddflg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaF7sRP8PEPIFTsHv2+IlzP8ja8UzEQSGk7Sk/dzn1zjjvmAiO
	qmlihF0a/mN56A5S3WvDZ73bLMKCXQr8d1E96lsdkVP1ytfApyvzGASTyZ1sB9EWQC0=
X-Gm-Gg: AY/fxX6kFdyikPWYZj5370Y6dJDdYwR5G1EDUMLcsuz9b7jSJe1mewy9Q1F5T7t/n/w
	PWvrPYumlNz+L6wYCPkKc3ec+rXVVvFjFJvluXNAontHkpaQ55HHFCoqDX91uSsE7WjpH4gzOMO
	pdVLaxmcaSCz7Vhx2oAB1F7jOn19s6AXsfQbN1GZM18ZXpM0CupVa/EGVt1iuoR+5OK5SZpG9FB
	1+2keLQbisBrOS0sYLFObYfYHuYxGMOxMYUQomBByneLcXQmj+QYJv3XhZcMEzKvXBlFUd+Ys9m
	+zNJHdLeqybaPAzoIE5M8t4YTU52MgX/fADKwRjGA5NjlMkA2ZLffdq9kL7uGRk5VV8K3shPIzo
	AhHRo7+KwsZcC4ViFBp6/GOyzOBPXK4S68KCPhka+hMMjjpWBz9vvFF28atGPBWeMMw==
X-Received: by 2002:a17:907:9689:b0:b87:965:9078 with SMTP id a640c23a62f3a-b87968b7de1mr818664866b.7.1768818198570;
        Mon, 19 Jan 2026 02:23:18 -0800 (PST)
Received: from localhost ([151.37.196.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e735sm1074217166b.13.2026.01.19.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:23:18 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] accel: adxl380: Improve data reading from FIFO
Date: Mon, 19 Jan 2026 11:23:15 +0100
Message-Id: <20260119102317.1565417-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=flavra@baylibre.com; h=from:subject; bh=2BNgD7iR2Q9/HS6VBWEFWjcwEzW6/5nVyyIR7pF8ciE=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpbgX5FUc7KzOC97GujQ36W/rihipvLGY/32W33 vlTVxKadFeJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaW4F+QAKCRDt8TtzzpQ2 X2+KC/wMU7X9Ac9WkgcVlpCNSGwE/ocVOqK7V5MwooLTcb1MWND5/EJaxeCLB6GJpnVVNk7x1/y gJAve0pJl1mpdKXmhX35BPBE3ficD94NDpD9zKETgxtIyIxrb64pBGJGJdDSCgcS5WUsfiQ2XAE qr/cYuZx182PkrHRdn636Z31flOwlDyj4qUgS80QXjDMm32R7jDOi7lHB6IP7vUrC55+S1TdLQ7 R5m3XaR8+sFGiqtqeNNNsNYUAPlGv+c/OpWt/2bEevad1UU9X4bpDLay39Mx49LzxlWsOWTur8d E2FHXdMy7seyMSPMm4f5TVYBoEJDWaZwJdyhAHFxZrBRVosQMeDjPnEN6fadRheAuTuFqwsaocK 7P4NJjuy5TDQ+Kw3hI+17SuvxIos7To/bTn5OJQOxZt3S22K8XLbh4u2Oig+3J6ZMXp9EJsK45f eco3CeLsWbkqfFdfesGsIjEAw6LNt6y96lKb7j2zKYtucQIuNaSnQVpr1rWRz37+1VTdM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

Patch 1 fixes a bug that might cause the adxl380 interrupt handler
to read from the sensor FIFO more entries than actually present.
Patch 2 optimizes transfer of FIFO data by minimizing transport protocol
overhead.

Changes from v1 [1]:
- replaced 2 with sizeof(*st->fifo_buf) in adxl380_irq_handler (Jonathan)

[1] https://lore.kernel.org/linux-iio/20260106193627.3989930-1-flavra@baylibre.com/T/

Francesco Lavra (2):
  iio: accel: adxl380: Avoid reading more entries than present in FIFO
  iio: accel: adxl380: Optimize reading of FIFO entries in interrupt
    handler

 drivers/iio/accel/adxl380.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.39.5


