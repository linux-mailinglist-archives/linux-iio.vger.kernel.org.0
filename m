Return-Path: <linux-iio+bounces-6244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC284907732
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 17:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711E928D2B6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EC5156C7B;
	Thu, 13 Jun 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="lBfuccTX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A214F106
	for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293221; cv=none; b=rz1/Edon0IeDTDZdTY4GF4yeokOkWd+GYS1e/fsmdNX4mphvGruYZ+YDvvIHN3ANCNo/GEA3VE3Pkj5Erq80h0k6dTUpL+IjLkPLJuXFwp1a+K9a3IJpIlb9K7v89sUGAIToRSV/QaUMaXXCNO+7UYDkyixxBu4NB61iw7NpBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293221; c=relaxed/simple;
	bh=IijKA3D+a6Ck6QFUmUSSDA4GuCjoOG6/L7B6oXI9/xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G9Ka5dnh1EnNCuE7D9vu+7pO/cudrdzFnQBjb3N/GB2EDzWm9mwfYjsmwvScW+uQSswMUUHByavN4LlKchPU4/7jDtXRd52DIqZyzPXKz2N3ISJsYv9ATx8aoLVd33aOYPDtQdxXYgwF0AVRA+6Rlr8KVEbDYvpAwvslzuWRZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=lBfuccTX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6559668e1so10613155ad.3
        for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1718293217; x=1718898017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3qrbNSpEHhzlXzlPZZe6eTX+nvvDfnBMz6EY1ye6j4=;
        b=lBfuccTXYNSkbrYpbxAONlhJaxaZZWf8exBPoVBUxerxSviBETgHIDT0kSVVP9i1fJ
         4frIYGiW6djWzz5i/rMyHdlI/++e07fuOKATk7Hiz1Dzwlq4jiNYJgaO2QH0SEdeS9R2
         s1QuO3hko3ZQifwccW7xVlzYlguAvsI+QalpY9f5AyUQac0XnJwWmamyeTJXeNZQLL6v
         rkLxRWvQJ04iRzoW4qVr6eGvJtS2ax1Sqk3gOGpCt1Vau2OH4eYEeLok2Xa+WySQiJ0M
         NF1bYgz+lXq6tMWTvbk3tD3VsHj9BmEOdewwwo4rDhNqAER8D6XiN3D8b4Qno1AxLkS1
         fc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293217; x=1718898017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3qrbNSpEHhzlXzlPZZe6eTX+nvvDfnBMz6EY1ye6j4=;
        b=xI6GKZhgg1fyffLKIXy5pmlUBecC8ImSY5bg/v/l56LbUMJbXA7zEEp6HwrKSr9Sx7
         qn8p3b+feypdP2C0ZugLpcvzqftKbqsqxGZFJMLwcj6RuvvdJdHd85byrdpiSokKL9HV
         FlDOlXdc5LxBrqEgL/HRUxnL1f+VjiypLCQVAjCKWtJQoLCIiR0oZuZDPMrkZ0sppUIC
         aepM9T0bZckAKXUqMOgJgFtbr1RG2hs+9E3Nny40Wp6U+atx0qoeEysW0iIdFEg4TgHU
         9R2K+hGRHG57pbJ2qZOIyL+mLrwUi5Hr/GZyMFf9fWa0fPCsvdGbKrGg784jg/uolPpl
         JyNQ==
X-Gm-Message-State: AOJu0YxU74oQoS6Zdhh6gNkYnI/DyYP7mCBdcM/Alq2I7v39HgvZdUUE
	MSS0hu84pvPD2Kj35viBQLIZQSj15oC/8oneUzmDm1wD/eWSIqqyI5h9xJaIk1maW807L7iOVfR
	q2VQ98g==
X-Google-Smtp-Source: AGHT+IFGVd7Eqsq5Lidnq9043TqViln5ArQJjTd9K5d0RhdruuJ5+u+FDIVfWBHmOyYUPYpa0CKB+Q==
X-Received: by 2002:a17:902:a9c1:b0:1f3:2e31:f83a with SMTP id d9443c01a7336-1f8629feae3mr140715ad.46.1718293217008;
        Thu, 13 Jun 2024 08:40:17 -0700 (PDT)
Received: from hagisf.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55d7dsm15372295ad.14.2024.06.13.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:40:16 -0700 (PDT)
From: Fernando Yang <hagisf@usp.br>
To: linux-iio@vger.kernel.org
Cc: Fernando Yang <hagisf@usp.br>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Eduardo Figueredo <eduardofp@usp.br>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 2/3] iio: adc: ad7266: Use iio_device_claim_direct_scoped()
Date: Thu, 13 Jun 2024 12:39:19 -0300
Message-Id: <20240613153920.14647-3-hagisf@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613153920.14647-1-hagisf@usp.br>
References: <20240613153920.14647-1-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to the _scoped() version can make the error handling more
natural instead of delayed until direct mode was released.

Signed-off-by: Fernando Yang <hagisf@usp.br>
---
 drivers/iio/adc/ad7266.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 13ea8a107..356c2fe07 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -151,20 +151,19 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-		ret = ad7266_read_single(st, val, chan->address);
-		iio_device_release_direct_mode(indio_dev);
-
-		if (ret < 0)
-			return ret;
-		*val = (*val >> 2) & 0xfff;
-		if (chan->scan_type.sign == 's')
-			*val = sign_extend32(*val,
-					     chan->scan_type.realbits - 1);
-
-		return IIO_VAL_INT;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = ad7266_read_single(st, val, chan->address);
+			
+			if (ret < 0)
+				return ret;
+			*val = (*val >> 2) & 0xfff;
+			if (chan->scan_type.sign == 's')
+				*val = sign_extend32(*val,
+							 chan->scan_type.realbits - 1);
+
+			return IIO_VAL_INT;
+		}
+		unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		scale_mv = st->vref_mv;
 		if (st->mode == AD7266_MODE_DIFF)
-- 
2.34.1


