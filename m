Return-Path: <linux-iio+bounces-15884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D4A3E296
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 18:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7775F4206BC
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC82116E1;
	Thu, 20 Feb 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxkzFZ2Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955611D63D9;
	Thu, 20 Feb 2025 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072882; cv=none; b=grysV01fq0+zAuA9TVgjckFJIFhHXJQWm1qpJDzV1wCikj0PVoCNd7CFgnRfTNgEbLuW4i3evYF6/zeWEaAedjkhaYdA9FywzORobhIm+YUrofWcRQsmjmKfvB9nMFhHTuPEovI9UJslI3i+cGQaJPm7vtQwN9nePFMuqn/VTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072882; c=relaxed/simple;
	bh=05wQ9sfrQsEjtwaq9axL/DzVM2WzvUyqUAyTfXyAzPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ANRDySYZwOKARxNJebME9OJpf9RATqWW6N7aQkNhFbiISk16JdKxJ0Z8sslw3Aog7ibYUWD/EQFwVjMBTG6Hl/7Tu3xDi9wxuCci/wUM81cFrtF2j4Soh7iazuR0Cr41RL/XsFy8QL6hDbAQFFOpR6PaAIzj4aMM5u/PP/7fKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxkzFZ2Q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so2547394a91.0;
        Thu, 20 Feb 2025 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740072881; x=1740677681; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OU9Eujl0xKDOpFO6qQE/GZagT7lVu3bO4cc4G/N/cFk=;
        b=gxkzFZ2QlqhxTMxtz2boYojz6WxZb9251iBQgtu05kaX0o0z0t2rmuu5/Mmk1K160p
         ItcVq3vV4A0aGDo/nkxsSr1dH6cKGiB65t0yHWQvM4tpUQJeBv+YfNLtB74qKLVfSzXs
         4Yy82cUYPg/UaBJwbwK4WJDvlPXnSgs99k4R2hK+sVh3qHg16LjNk8GRTbJfnyk/UTlE
         IBGa6jIaQhglPShwBqLkvZhQrNvmNCPLG+tESxYbOc6XUCDvappwulrT1WzWH17EPtcy
         F9R5CU+V9LPCfQHElo4JYWY7iq2ELTqzxzXF21c4PrjDsJGBvMa7t2jMQU9NqdkVoE2p
         rBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072881; x=1740677681;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OU9Eujl0xKDOpFO6qQE/GZagT7lVu3bO4cc4G/N/cFk=;
        b=gUO7Ffs0Otpr1iS7NrILa8hunCbkisB4RNrAu4WdYvQBwbflWAFF3q9yTM1q1pZfrO
         LgyxvIalMTBVByBU6uy0uhd58qhwQMYbBHxeTLboXSp5lFAOIgNKX7r3j2os7oUfcE7y
         8rNhZH0R/jSdh3YMmAbw6cZAQvB+SUOy/3l154KAEwzDpaA8FHq7BNwQq1Hnuk7HzSQr
         eDYB15RamfTDpGHn+5n7/PlTZOROlFao5FBCNFpxgZx357rqDn51eQ4+wQsuCi6mCmt/
         /ttyvcLUwKvQ7l46iaJojvek62DUpB3ryBsXGaVOvvN2f7Q8lM3ZuihWTRqTzJgWedfU
         Aglg==
X-Forwarded-Encrypted: i=1; AJvYcCUJvZudW3UCfR35HZGIYWC+OsvfivP+4X3zQX/SYDoR3VtYZr4dlDsYeiA8jamMu3RLf2WD51bJekRBEqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVjm/GQlieFofwZI5s3NrL+2Sm+BVL+3JJlFg50hR5MmFIF37
	JY6+zB8tBe18wISDeMkln6yZI4i3VdRBsyiLMnlDnn4sAq1gVkzz
X-Gm-Gg: ASbGncu7eFH7t+mTYYqNSi3dl62a1YZuxKcAevdTpq/b4eDod+NjpfcutI8UDzrGKNq
	GG9DzxcS6qVUKCCJIglJhcD4HzRMwrHh0gBIRHiNV9ub9sX7kyxfOAiDfUJXrPWKjJ6H2AQ7Eve
	O4Q8nhKlecGzaIgE2higIyIHIrX0PgBmNtZidvUanU/KlCr4+8ubthx349Xsa4thYfHplpcTzLL
	SD2y+c46YHWjKDr0/lSmVoGHAA0/DS7t5U/zmfuNe+RC8ZiKZrOncTKx67F73/I3cMaYsrWbZkD
	YM5oRvCZ7AwgEs5aLIbTd0e3
X-Google-Smtp-Source: AGHT+IEKS5ZIhQ/Gxp9hLtckbsidsLZKx/wIMICMnKQLLCTfyBSUgYEnE6b7mvTrsLfZfSO28KHeCg==
X-Received: by 2002:a17:90a:dfc5:b0:2ee:cd83:8fe6 with SMTP id 98e67ed59e1d1-2fcb5ac074amr13552163a91.35.1740072880659;
        Thu, 20 Feb 2025 09:34:40 -0800 (PST)
Received: from Emma ([110.226.178.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5cesm15564943a91.34.2025.02.20.09.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:34:40 -0800 (PST)
Date: Thu, 20 Feb 2025 17:34:36 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH v3] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Message-ID: <Z7dnrEpKQdRZ2qFU@Emma>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The array contains only 5 elements, but the index calculated by
veml6075_read_int_time_index can range from 0 to 7,
which could lead to out-of-bounds access. The check prevents this issue.

Coverity Issue
CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
elements at element index 7 (byte offset 31) using
index int_index (which evaluates to 7)

Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor driver")
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 drivers/iio/light/veml6075.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index 05d4c0e9015d..5dd951f6e989 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -201,7 +201,12 @@ static int veml6075_read_int_time_index(struct veml6075_data *data)
 	if (ret < 0)
 		return ret;
 
-	return FIELD_GET(VEML6075_CONF_IT, conf);
+	int int_index = FIELD_GET(VEML6075_CONF_IT, conf);
+
+	if (int_index >= ARRAY_SIZE(veml6075_it_ms))
+		return -EINVAL;
+
+	return int_index;
 }
 
 static int veml6075_read_int_time_ms(struct veml6075_data *data, int *val)
-- 
2.43.0


