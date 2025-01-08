Return-Path: <linux-iio+bounces-14014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F2A05703
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 10:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A263A2996
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96B31F37D9;
	Wed,  8 Jan 2025 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbvLTg1b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672FB1F1307
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329050; cv=none; b=cb4ojXqWLXoJMqcE3yrPIAdRnn31+zxaj4PZrY6Ury2cMtEBUtgsq5ur0SsIFduXq2cWePgtoK9Gd6RG/+AFI89j5wN4TrFLmTGCy+89jpiwgoTIaWsB715/AxFfM/weGI4F5zonpOg0MppCvsMVaRCQQHLTTflUo7sqZR+wtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329050; c=relaxed/simple;
	bh=tN5okRrYoBGpX5AHsBFQyTsnw6M+opkwftx20mNQmpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q6+lNk1M7NdLjijRoxgfl+58CISfO07AbJgjSUYI7Rejbm68CHB3IL6FykmylLK4ab3ml2sMI4e6mlFS4Uuit71z85Hf+RlQVY7B0aZeXOHzD06YUZU58IDWxWOCt0+/MGnDMdYzrYijuA5ebhI6FrtP/jE8zXQCX0jrZ3WGjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WbvLTg1b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43621d27adeso114216685e9.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 01:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736329046; x=1736933846; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7qr+xH74BUjb8c6klWG/dnkZsYFFWd8nuIpiiYr2Do=;
        b=WbvLTg1bOmHUScDAg6n3Jcf72LV0C4F5BaYbkrNhVv4Etq9SwL2YtmmHXcKRsSC9iO
         DjaNjiCcM72pgH47QUAfRfTDrupjZQVAfjogC3S+8m4AfHjSHbo/LQpRew+zCbLEdC/m
         BKKmQCehxIRxSwXoZQLaydQ/v5m1yEcuwIrBSeR62YjD2UVU7lSt5eAryNusF669Erii
         zFigFZO2fUso82hFFzgRDfOpJSvRvNSFhh9uG5X2P+hnda5umM0BXPxsAWpDMXJXFU5x
         TfqPz7vhHT5DG5ufWAMLZvV10qVS5i3qKCxWEuLYZOBky7giI4ybkruhZyW2UN1RE1T+
         Kmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736329046; x=1736933846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7qr+xH74BUjb8c6klWG/dnkZsYFFWd8nuIpiiYr2Do=;
        b=k0G9AiTHB0Isi8xuXW0YT59WjrcNHSuYKgX5WkunhJ8WSjFrfqZx9ZRkAlzVPNGufp
         3alxP314nasucNnJ8DgldNzrekY8gOU1Wc/2nVzJZ8YDhdvf4wksZCINPJ62IXATw4WV
         ts9dEcTmCNvyRTJdpn9gIRe2K+pltS5eqiktYiPaBFWmWeAKZHhYfO0ve9PYHlWsrr6A
         Pkh03hth8AeN4WbI3QEqitJdLEZGNvXTPAh6NSsJ9XZ1gKJWSDbp1ebBEqWOGOzlZtpT
         p/RfCsKLuLMlukkRJ6yjc5JTyfHDvy5w0jBgIRk7WkD6qlUWTzJdCd0ifSy3yeNC9qT6
         Njtg==
X-Forwarded-Encrypted: i=1; AJvYcCVmzNht4NHa7NdNN+3sUxgD9IozLTz+h5BNz465azKUWRZYsy2Z1mhccmvJFKAqTEcXyhO2WhiM67w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq1BejChRMacZTFzvu23jbqRSAOzya521YwHa0jlG+E9hvmSTm
	vqfiFd0S8wyXITmN15MU1vuwN2/BIW3ioiLhqnx7B0PEDaxFvEJ/RMSFAF6BSXA=
X-Gm-Gg: ASbGncvfXQ4hEH0OE2I8t8cTg4J2dxFVUiXaP0N/9zUmNsTJ09ULZ1V0XzdkW6hEqyQ
	1kKAX+zncD3yV/pQJQCFFzlnBOkdUVPJ6BWy+2F4TUCIwYcRWdpllpNaxv+4aC2ME++Iu/7BBHF
	vAk2pi9ZpumKN+Ex0u/EfW0oCpHGhzoYpzz2NLZvepHpXqQlE8J5PAOb+YnvZGTqnur1PqDZHZa
	SYUPVXuxVLDGalM74j8VVoHT1slb/RnaAZdoiyKyB+8oHmR2wOJNLDWejrliA==
X-Google-Smtp-Source: AGHT+IErnSBFhYxUJzsggddRVs3RbCystP6n1/ZQ4IX9uvuRMpjYqQBmS+F0oGJazwIWYP0YaTEAwQ==
X-Received: by 2002:a05:6000:18a7:b0:385:f220:f798 with SMTP id ffacd0b85a97d-38a872c93eemr1482892f8f.6.1736329045814;
        Wed, 08 Jan 2025 01:37:25 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb17sm51765404f8f.97.2025.01.08.01.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:37:25 -0800 (PST)
Date: Wed, 8 Jan 2025 12:37:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: chemical: bme680: Fix uninitialized variable in
 __bme680_read_raw()
Message-ID: <4addb68c-853a-49fc-8d40-739e78db5fa1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The bme680_read_temp() function takes a pointer to s16 but we're passing
an int pointer to it.  This will not work on big endian systems and it
also means that the other 16 bits are uninitialized.

Pass an s16 type variable.

Fixes: f51171ce2236 ("iio: chemical: bme680: Add SCALE and RAW channels")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 26eb0fa77a43..9d73fd2cf52c 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -879,11 +879,11 @@ static int __bme680_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_TEMP:
-			ret = bme680_read_temp(data, (s16 *)&chan_val);
+			ret = bme680_read_temp(data, &temp_chan_val);
 			if (ret)
 				return ret;
 
-			*val = chan_val;
+			*val = temp_chan_val;
 			return IIO_VAL_INT;
 		case IIO_PRESSURE:
 			ret = bme680_read_press(data, &chan_val);
-- 
2.45.2


