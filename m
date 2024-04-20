Return-Path: <linux-iio+bounces-4409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8A8ABCB5
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 20:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB77281561
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A903BB4B;
	Sat, 20 Apr 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="qQNSOjXC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56AF625
	for <linux-iio@vger.kernel.org>; Sat, 20 Apr 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637691; cv=none; b=AmcE4EOcBtUbtkQwWLhnLE27+GknWKLw6tJZAXD7g1FB1nQX34rlPMvZmgMPHdTQ0faXrfSeZwLNOuswH/Up4lH/Lpjk+/xY4df4EGpRguakrYjtPI+Sn4E60/oQMquYR1LDX7Z3WpDfsjTLZhK+8D/4svJ4u9hrMQJkg6FPe+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637691; c=relaxed/simple;
	bh=QwvC8dzmtLw7kNmGEwZln9O5TbBdGY4Uxnvi1+xDIPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVwovAz7rrEXEyFk0iRC9THK0iva2MOViya6SdRbQgWQ5FcrYsP2rLxM0Jw4KRvkZSgF/jPfEmZnv5A6NqKQtYQk3tk91pDXJg8/aYyBxQCWiuTFfuz8ohYOjBOqA0OWWcmPShAdEPz63C2lzYv3uQyguOFjdboHqPc2OfIFP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=qQNSOjXC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ece8991654so2961979b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 20 Apr 2024 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1713637689; x=1714242489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZP4RGEHGJ6MKIhf1KQsZhdu7NBLvieulxlrGc9+noM=;
        b=qQNSOjXC5EGyiQl1kb9redSwnCKccJoM9ZMLlrTKStJpJR118Quzs0nvQaC5v9tnjd
         XTbd2IUj5AQOfBphs5pR7MfqWLFNF729mXzrNJjOP1w3xD8nvd4l01Mg6zL1rKlUKJoH
         oOhCMF0YV9OritcSljyK+Qek34i9VB3uaZfEp4P0yCnUKMuk/fFnM9ENE1pepbj+CPrg
         15Bu1EBfP126u5H28mz8Ve46Z+e/VJeiF6VUL47J7WbyNr6nYt0o8LZ/t23QCpw+XYU1
         Sy0GoeGeuYLAa0K27dRJ4f1xaxRwG/C+WKfKbeoagK9DvrLl/3F3l/kRlrPz5Zn/gl56
         UvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713637689; x=1714242489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZP4RGEHGJ6MKIhf1KQsZhdu7NBLvieulxlrGc9+noM=;
        b=ILAoZDReIWqJW18kFfrUkV2ELLMHpPEJYwY4byQfsAT/W/mCR1jAPLhsSdEwG59MBA
         9bbonqJGV+FyeicHZ774E1CmNkyZM7vwqErHcboYVBROEr0v1Idwl2tqGV6HWUoyf59W
         8ohsTBhM/sfAet3v9IObmkKM+NP5AVM6caTBGlkEftziEdAlvOeudmtWX62GcWqmvUcK
         5syqqy9CEw7yhgAa/48PP/sCdbo4jWXwYEeYbcO/Im4O59jOujKdh6XHfFvrgaUk3eMb
         P8fNYJ7NINJXbJQimhjFBg9MwZ6CCQBqJFL0oPpCMHi1CfvbZFiUdezFHmuJGpuMlP+N
         nuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU+YXoSyJKXD1bk4QKt9UeoZfrtiw0JKLC0AQeXbVPdyRqbE0LaIcdkBHXGyqKPco5v9GzS5X9cY3j9oR8piqUCHdnsy+W8TUM
X-Gm-Message-State: AOJu0Yzqg5SsrLarxhCKfW9fJWrCo3wxrmD6dTj47FGXXKs8LWR24SuQ
	MrJPwjE4ogZr3wAqVbna5U7vpQ9080iEha/LMrBplfsyi0g4fWWh11ULFQBH13s=
X-Google-Smtp-Source: AGHT+IGTavgvtzluzPGtlxJhqS1cdJG8d0sFgsx9kMaNj9A7dDBi9Et29J7HflGL/eo68TrY6V/rCg==
X-Received: by 2002:a05:6a21:6d86:b0:1aa:5fb4:86a9 with SMTP id wl6-20020a056a216d8600b001aa5fb486a9mr8111679pzb.26.1713637689138;
        Sat, 20 Apr 2024 11:28:09 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7c7:8fac:7a0b:df1b:26da:f824])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b006ecbcbd2293sm5325268pfn.173.2024.04.20.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 11:28:08 -0700 (PDT)
From: Lorenzo Bertin Salvador <lorenzobs@usp.br>
To: jic23@kernel.org
Cc: Lorenzo Bertin Salvador <lorenzobs@usp.br>,
	Briza Mel Dias de Sousa <brizamel.dias@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ti-ads131e08: Fix a style problem in struct declaration.
Date: Sat, 20 Apr 2024 15:27:44 -0300
Message-Id: <20240420182744.153184-3-lorenzobs@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240420182744.153184-1-lorenzobs@usp.br>
References: <20240420182744.153184-1-lorenzobs@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a blank line missing after declarations in struct tmp_buf.

Co-developed-by: Briza Mel Dias de Sousa <brizamel.dias@usp.br>
Signed-off-by: Briza Mel Dias de Sousa <brizamel.dias@usp.br>
Signed-off-by: Lorenzo Bertin Salvador <lorenzobs@usp.br>
---
 drivers/iio/adc/ti-ads131e08.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index cb04a29b3..fcc0276bf 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -102,6 +102,7 @@ struct ads131e08_state {
 	struct completion completion;
 	struct {
 		u8 data[ADS131E08_NUM_DATA_BYTES_MAX];
+
 		s64 ts __aligned(8);
 	} tmp_buf;
 
-- 
2.25.1


