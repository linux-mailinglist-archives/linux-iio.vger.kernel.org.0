Return-Path: <linux-iio+bounces-22380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1844EB1D3B4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432E558090C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE27231C8D;
	Thu,  7 Aug 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgFz7S02"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3411DF258;
	Thu,  7 Aug 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553034; cv=none; b=iNmQCJPRHwoslwJGyRJdqETKzTFtYxKCUUTnuTRWy+UrlJvERfuF9Za/aLaMIoguoADM0Zk/NCZGzbl/EAjMmK1/nkRJAdHG5kTIN/1xYoLTprxGSTXL663UGkV6q7dtjASugDZF+DlQWPnUjDWXiJnUQH9V8d8kxrVVW5hWJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553034; c=relaxed/simple;
	bh=ZZZnBp9xWeQ6smT018/B/e2eSg53IiK5tyGbGbS7TMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oa9Ov6EZ0j770fiqaToIJ6KCObQUYyq9Wp26QZvfR0lebjboKbhaFJKuT9c4PA40km/wFr7EBYF8mcw0NOHZnDagnYwQbPTBc3tGHDWyEe9IXTjB7yguPDNiVt12iMVD+vjENk4x3Y9bVkizm1jE35Lh8CKoem0LY5PW97a0eL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgFz7S02; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso863073f8f.1;
        Thu, 07 Aug 2025 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553031; x=1755157831; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vE1Ew+5PrW0nrBONcPPkLQR+Kon8/dpKRYy4qBokinQ=;
        b=FgFz7S02nCEgYghw2dXhNmwIDTLeMCMF4HPYl9wmiPdHKUY06maoahLgaPyiQltQmU
         mFWG1vaj4pgvq+dNwW1Hlxz8DpqRoBn9Nj9k8FDftnbwI721/06KPCQWq2oN6rYTWVre
         tvs28Qb3DDBh9F6teNIMnW9LMAi2IjS6AUZ2jbnAlcrw+kop4Z+ylFf6BL6gXjA3E8gS
         pvMi+5t8pSSFaoxF+o1GR6exNXEL5edkzaQ/ma/pwYlxynNH4KVaTZEspmniA67sLrgc
         YbMRrqCun/XsUn5j8GQRef0sOwrgJTe+WA061uVP9GoT7/eoIszhh8Ju4Z6PNiN9f5hg
         ulFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553031; x=1755157831;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE1Ew+5PrW0nrBONcPPkLQR+Kon8/dpKRYy4qBokinQ=;
        b=ea8tARqLW+tbIxSv5Bc6Pj8byHkjBM5PObbCQjUqPqAWs3aY9nWFPk80vIKl+JxZCY
         Ey0gPtxYG+jTIwXlhohPn2nhVz9DejEu0QG/nJnyk8509NxbMqmrZZFVwvQWL9QHFj86
         Mtoh/PlInrYIps3d3weny8W8DMmUjDf04NtaciQ7mpOkw3cEvUcwV+XWQDWlw45TwHgt
         vDoLEGp+d4hzOriauGkupjSBMzE1J5JsEPQUTVC3XRSDZsCRDcz1UZiYefQt+/D+2vwv
         Z2SIo8P9nPhwbksKKq0dNxwJ5P3seOy5A2lotcGTmBDn3zOifg/01sZ4XHhouGwwTT2+
         tOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2jpS0wWgejscfdFoKXovNt7CMVpBD37fEqjC+4PBIew+oUxErgArX+mTPnU+wciNlkK6L08crzTF9wLvS@vger.kernel.org, AJvYcCWE88e0ISU9L0tT+kQlDwXM8HK9UZxKV+9NZg90e8hL2xei31hhFam3hp+KiIOYZ+hummp6IR/eBQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tHC8G/+nmDGa2Ksu1G8vCTTtaEZB2/49oDnO2NaIYc3vi50Y
	KdwWxJhJ0Ron1IOKEsRR5UI7CBKHMI9CfSy61c9bnrjax88mXfo0sBypbirANRdZ
X-Gm-Gg: ASbGncvJ7XTEs9qtIaGppzMxuWuHFo80XSHTC0+o+DCnUKuVrXs+zCpUnqgAMAiKo8V
	jwGJD1dEHqPwMgnIwybypMgS9rGTIDDRMH4ul5v/slKQ+4EK5cmmKpOfTzha7vfeVIra1/HjxHR
	zVdLOVNY1JnhqcVUo+TYsPm5Myi5WHZ/wQxIxkdOROy1bBv82PGVIfYOflEPf1axLoPrrHln9Sp
	jTuyi8ceOHpdIOXT3UvMFebYP6N1E5+mlESt3ZMlgDjKrhBkwEz3a8ri7+ydKz1KaCPq9KeuLOP
	qXAEypnGR7+Wvxv0Xjh7VKXzSdE4RT0FqBy2B+K/LvUnwKFQ7rIRgR3jxrDR9T/EghsOvcpO+aJ
	2M5imq7/Sg63g0Q==
X-Google-Smtp-Source: AGHT+IHOLpwkt/HxAfu7/viPowRy2GQCUyvBVDKV8p48TOv0zTHZiLYbixYim7uMYQpoJJYbZRUsFg==
X-Received: by 2002:a05:6000:1a45:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3b8f97d9397mr1495027f8f.14.1754553030895;
        Thu, 07 Aug 2025 00:50:30 -0700 (PDT)
Received: from pc ([196.235.182.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm25133415f8f.57.2025.08.07.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:50:30 -0700 (PDT)
Date: Thu, 7 Aug 2025 08:50:27 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] iio: adc: ad4170-4: Use ERR_PTR() in ad4170_read_sample()
Message-ID: <aJRaw57_P8pRxRNN@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use ERR_PTR(ret) with %pe in ad4170_read_sample() to properly display
symbolic error codes (e.g. -ENOMEM) instead of raw integers (e.g. -12),
improving readability and debug clarity.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/adc/ad4170-4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 6cd84d6fb08b..6296b5dc930b 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -1253,11 +1253,11 @@ static int ad4170_read_sample(struct iio_dev *indio_dev,
 
 	ret = __ad4170_read_sample(indio_dev, chan, val);
 	if (ret) {
-		dev_err(dev, "failed to read sample: %d\n", ret);
+		dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(ret));
 
 		ret2 = ad4170_set_channel_enable(st, chan->address, false);
 		if (ret2)
-			dev_err(dev, "failed to disable channel: %d\n", ret2);
+			dev_err(dev, "failed to disable channel: %pe\n", ERR_PTR(ret2));
 
 		return ret;
 	}
-- 
2.43.0


