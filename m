Return-Path: <linux-iio+bounces-19242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBFEAAE13B
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 15:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972641C22886
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B987C2874F1;
	Wed,  7 May 2025 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l72D0P/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268A21A45D;
	Wed,  7 May 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625528; cv=none; b=iztcn1kDH4RD4d3mSL2G1ETekkAQimoJCJVNcXNH17RekY0piDGhwF0GkTk/Q5Rq2hCk7Er/RC+NhyD3KVWtTdOysyLXN7CEyP+boaMs6qh6IooTFCeT9cGX7BsR6JTli0kr4d8im1ulJEw0nn07e2r2yV9NQr45iUBcLkQqy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625528; c=relaxed/simple;
	bh=g4T9kAIxaau06WdaDWIxvG4bGpgE2CHk1+OaxmXKgvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E17QZPzgnpKqiQEJgsgqahDt7EgeCvMEM4ReBY8kDTQ2s4DLDQvKe/XXAFT8ZGB2FFXytzvlbR480FmxX0cesz+7xD3QMKXFZDT69msvXhyx3/P4yDwxLQeksXVorBCC1RDPiaTHJk0Bzci85XYi9INQmn2/z16H2mo1tRspjHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l72D0P/7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so8438665e87.1;
        Wed, 07 May 2025 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746625525; x=1747230325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUc7L2yHQUs5LzZV4DN3+nz/ORs1oWoWyN+HhNEWgkk=;
        b=l72D0P/7bG1u1QOYno6yPAXkibqoAsRftUjQfDt2Qy9mA+Eq1zglbc3TMrVBaFLaOo
         vUH60pTuFXDkLrbekdkuXrlADXf8gS2NLtd0Gew+zdinttNs7JmkCd/K0UdVxjehke9G
         HzgdIh++fgp/TOTuLJ1PJ5XwPjE/znbdR1FEhgJTl4aXsVNSUuXG+kXgYqYon2tZYw7r
         cqbqH7fj3Hkp+rRMaNAKhu6y1gQnEogLqUFi+4EygZ2gPlPqce1DtTRpOKYqs1wg8ROM
         0prr8nSaPCzBTf1qRBYUerxfaF2wRUkA/7m8NVuGTtT1lANS7cfd70RguZcpsypiZxar
         cpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625525; x=1747230325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUc7L2yHQUs5LzZV4DN3+nz/ORs1oWoWyN+HhNEWgkk=;
        b=IT4FZ/SlhA5grV5e/SK2nJU3tcmy0bQkJPgpjG9Y8YXJvrL5yRYgzWtth+u0eyoT38
         uvhSqmP5okVKOEMAA+AdlG4N3Mppdn6FYcB96BqysXBt75ZZKSgNgh+71uNJTOGfgZi5
         7N+SAdv5tqflPPcaWi/3soXyu1wrqg/q2w+R2QmJTAeykze4VunkLUTk7Q7cMeIH94Pe
         ZtzD6B48vZxZ+8Y3hIKY98YY3Efdnf+ozYDaPzDps6ynwjIApCqJSOAqFK4sQemxKWJ0
         3JkmDzPbFGUlvIN0WDRLRTIzw9EvPPAhUJ/9y01tgWh6hagHrEP3E6zFp4Z66Gv4jARe
         a9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9iYrgDF1fBcshJcfK8jvLZisRyL8PzuzYU9NqtaLEFEa2nxk0I6EihWYSmAdODrg97cv+qt0AzHs=@vger.kernel.org, AJvYcCXVfsyUiq7khYoZ0a/t058hkddDP6h082rKwwVcByhGmBB0Yi3oOFuMdnyDctKG0Ef7ottrEjAm7DzGS5J1@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzk0TEuXI6a7PUsXlRgCg1a5fTxommH3OhCceingkO6NvqNwC
	lquUW1c4SO+zcFJjcQH7u92EoDx8bEXOdov6kv6MRwfNbFVVjiP0+tm2TYZq4ircGg==
X-Gm-Gg: ASbGncupJ9xQOVLVQpelzuTDQK1AKQdl0Xuqb1MBGK8BMCz7pkbGl6yy5rY3Ng5/rkQ
	R2rZ9irhdrDQbf7UpqPIbuH9So2OLhdLGBOB4sg8YqmirhsgMkiX7ldsKn19mzg4mBiB5TP7i41
	XXo8ntP8zhqlzsEo0/1vi8S31vIBEt2u433HfvMIcy1jhPlNiBhqvF0ZP4C7A/vQjNC5iARidRP
	M13tkydJBJIJKaosVNBSO/t16dFC26Rq+JbrxIKSJ4TpHJauewhUr6CnS1dB2OZjTeAQcKZHxbL
	e1Tr1vSr2R8mloduIPBZ6jt+GVNfyTOpijb86R7cTmwh6X5sCw==
X-Google-Smtp-Source: AGHT+IHCq5FdRYkJoFRLmJ3sDtBFShyjm5Bp+2TWYqY6gE8quzmdVwLdHWL5wo6FC6p5ul3JIi/X0A==
X-Received: by 2002:a17:907:6b8e:b0:ace:6882:510d with SMTP id a640c23a62f3a-ad1e8bc9472mr358510766b.24.1746625513919;
        Wed, 07 May 2025 06:45:13 -0700 (PDT)
Received: from localhost ([87.254.1.131])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad18954112dsm909842966b.177.2025.05.07.06.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:45:13 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: admv1013: replace redundant ternary operator with just len
Date: Wed,  7 May 2025 14:45:02 +0100
Message-ID: <20250507134502.254736-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned a return value and non-zero error
return paths are taken at all stages. At the end of the function ret
is always zero, so the ternary operator checking for zero ret is
redundant and can be replaced with just len instead.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/frequency/admv1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 6f50884d7130..d8e8d541990f 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -319,7 +319,7 @@ static ssize_t admv1013_write(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	return ret ? ret : len;
+	return len;
 }
 
 static int admv1013_update_quad_filters(struct admv1013_state *st)
-- 
2.49.0


