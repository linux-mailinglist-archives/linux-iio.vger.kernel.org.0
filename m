Return-Path: <linux-iio+bounces-27419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 524FBCE9B12
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 13:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87E03024D67
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB42EC0A2;
	Tue, 30 Dec 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6qNy417"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C832EBB83
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767098195; cv=none; b=hzcDIUnVekRzwCy7WMJeDBoso3A2MzLmxmcV2l06ja3y+MfKDgo60yqielR+K3sW2BB9l9KpnVQecH4W9Us0ruuzjBioBX0INjP2g7odg/yZIkvVOM5UiTKR8GhCcQsjWBqrrFAWrkVcSAMHSdJRIOLLK/skrSbqxxgY74tKNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767098195; c=relaxed/simple;
	bh=9DCQzBso+GCIboAvZ0ya2UwssmqDM5cX+9jKbtxrHws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fcjk9XpQDak4jiPLqXZxEIv490iYw7R8FCUE9lHajOdgGaVmPMt2S2BSzzJ6AhQRMmnSQBMV8FH6bQ0dpVCSiSdywuNibvhYzttVxkR7/Ka8S7iYaGO92YOY2HySTBxRL+VDPjX2kgAlrFDTicx0H/epxT5XF2qpKqd2qLHZvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6qNy417; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7f216280242so3050780b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 04:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767098193; x=1767702993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhhiK0xcWfiyJgNckVzm/v52M0Ou4o7EOyxj2vd317Y=;
        b=c6qNy417F2B77XzM4NMLL4+EIaU2tXAGuh56nWOcz9JdRuCY5DG4WTgPf5TWPmH6JI
         nwPiY3S1px+C6t3S9LNN6Trgmn/CNGLVrFA0ojqKqJSBfjaapwFDNeI7kh2sQZ4TfQ0u
         yc1KkI8P41hZ59eWNZhiOzNwkaReQeeCCiyaQkMVA4gNVgvvQyhdVNvXJ1bd5e5NKcwC
         PG+NHfBeFQiDW865WaZwosFkrX0aWeAMYxyRsd/RMUd8cJXZYnulyXewtxrvnW6StPVi
         h+55DFa3W3Fu6XjBzstWnFaV0h5izQIw4uPzPm/4954Bzf2HQF88nr7Fls2O46+p9JPB
         cESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767098193; x=1767702993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhhiK0xcWfiyJgNckVzm/v52M0Ou4o7EOyxj2vd317Y=;
        b=T8t6lyeUMRnJRavOWXpyYzQkez2QTFs81WcQXCG34ejB2f7WCT+2qQVn+aS5gnnlci
         bH6I4TMDTK1Kbfld1GsKN/A8t9GC8RhB0z7W0KHxj4hLmG1S8ATr9KXBAt31nVS9Um8w
         LtKRwNMutf3kdWmCF+KVcWEKWonbKKUegUhsO94e40YH9WJoIiEo4E1ux+oy78AtdxeY
         m5P8sTJ9EK/8RxrQ9WPvsnlVWZq6xVI8kxN9EmXmVJsqUThiKRvhWQF0TwA/5s4h/m0V
         vnEnWpwQshFO6gLjCXdZwO1bXzFxkE3rUpcGv/qwb7aTZoyUq8KdQx0OuOjispNcXhq1
         RLCA==
X-Forwarded-Encrypted: i=1; AJvYcCU6TrbpwTqE9p1NY6z5PLLtu0aDoScQbRqkSQvKlXYYb5fcei5lBLIP8vVbHw9WHe0RfRkxAA55/H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJ8dEj5Ibq72EMjTJUlv18D8RghvYyRG9BrK0myj+J6vWX5Lo
	2NWbiataNt4VTmhP5R7vo+C9vY2yCG96I1XoBB6sgiMyrdrTdNJWScLXICXZxflV
X-Gm-Gg: AY/fxX65drbZDcQw5oGmRm7n8WH7sKYr+RZD+8ZRCHWgqZWECf5tvEEyzSA0mXKnHW4
	q/IKcxKTjWbozOX4lWBE4tGjk1UHugH6vkBVTPkK5H9egah72dTMyvnXKvvCHK277jMQRYPpDNn
	Mo/WvC/4c6ItUSbiR6iH0R7zUd1DDYgK4V3OFtl6rc9XGLE2hB9mJ8mdaOMCPOfK6tg/LxB2A6h
	v/JIuBLM5l8aGHAbbp2hGrzJD2EWtwSjUunl64BzRzMsRCHpC4fq3OoExUY1JBD7Sgpn2tcKYAb
	QNMw0Fg+AqQ3vLZkBwWt8QxWXXQ2f+RWbe4qKTIvIJwL0tXM9L0l13wJA3EmlaRK/Ve2uKR+54N
	7DT2dA5YKB/ORVa0MNWdUVhRR57V17h994SP1t9yZgjov59qpruG9DUaB17f4g3pePr6B0vYHTp
	DKHKggWzlIcrMqtxwY3+LV7EwjppPtyhxukKeDjy0duiDrfw==
X-Google-Smtp-Source: AGHT+IEH8yhQjn3j7JG2PZNVaXqBitiPhc9y4QgpIjdfKrhPwREUhsvyC2sPKWDzu+ryi5dDC6ikqQ==
X-Received: by 2002:a05:6a20:431f:b0:366:14b0:4b19 with SMTP id adf61e73a8af0-3769ff1be71mr34653108637.36.1767098193105;
        Tue, 30 Dec 2025 04:36:33 -0800 (PST)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c3a4deb6f17sm2758041a12.22.2025.12.30.04.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 04:36:32 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH] iio:frequency:adf4377: Fix duplicated soft reset mask
Date: Tue, 30 Dec 2025 21:36:09 +0900
Message-ID: <20251230123609.210454-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
twice instead of checking both SOFT_RESET_MSK (bit 0) and
SOFT_RESET_R_MSK (bit 7). This causes incomplete reset status check.

Fix by using both masks as done in regmap_update_bits() above.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 drivers/iio/frequency/adf4377.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 08833b7035e4..48aa4b015a14 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -501,7 +501,7 @@ static int adf4377_soft_reset(struct adf4377_state *st)
 		return ret;
 
 	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
-					!(read_val & (ADF4377_0000_SOFT_RESET_R_MSK |
+					!(read_val & (ADF4377_0000_SOFT_RESET_MSK |
 					ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 * 100);
 }
 
-- 
2.52.0


