Return-Path: <linux-iio+bounces-27927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E2D39908
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8799300E034
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790071AF0AF;
	Sun, 18 Jan 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOiWEStD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104451D5CC6
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760453; cv=none; b=i5ogiZDUDw6eE3YHkMZsBL/ZMAZdeY3oZCZe0etsPRf8g1zZ+fqqKQiDNvQoFmoU+ZnbBhYPqUkJNZJG5CGLSzX2JHtHY0pITSbZOn56XZJPpZR7ZePZkkDII6Uue8JiY2G3FUnriji+PBUQd4Yz7gccSm5+YDWH0WbEVPCoFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760453; c=relaxed/simple;
	bh=JccskNRXh7B1nG6UWZdVIZGFB09h04n6evXkEmKHlHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5JPcyt9LuCQ6MxGNqak92ZVFV4y5dRTpigsMKBKXlxePyWbvIvAemJhprfM190UYVuE9GzF4qPnBcEcund64ylqYqyWHgDfy/CLN2knQ6cJ56bnXerN/wtxbInTCMQwfyUeaVvQrOVGnTAPlpqIE605D5/4Q2j0QZHTymC+MHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOiWEStD; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so2237010eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760450; x=1769365250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/ENJ7X6jznAaB9H64Rnz4gLknSm6IAjIuLCrh0TyIk=;
        b=iOiWEStDFxipHNNnZRlkjUhGSQ1oxpTuaz+bzFe09o9wFV+6GKHgoNDUx1xH/PFnlE
         Y5smZJgXC+T+HLlyguEFhPhs60eRakejkTZQAl3mNBCjzSqW7lgV2/rD2iX5yooyaByP
         EouCQXKniuDAZSzmFY/eC17yiZv+MKmDrGLSINhkQ0Yf/FjE/k6c23L9UvU4Pc+rwKDI
         bP5fPwAWcwO5y7lIHVqRVZqJghlgbCigwI45wpCgQhwaSwFqPbomIYHOqQ2jf+/N7Z4W
         eaRDN+nlAeUodwPYVccm7p8m8MXbJk5Fc25pfed9npUh8xpePIQXRJKx4p8HQwBVgEwI
         LDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760450; x=1769365250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/ENJ7X6jznAaB9H64Rnz4gLknSm6IAjIuLCrh0TyIk=;
        b=ar3tPDlgyKyPoAkviyQKPLFo76qZoM8p9/A0851668Ocng+SbxtJhP8K3OB45Mq1q5
         pNPVTBKqRGAnubdQjXNwDh5/FzmgeBKXrViHXCH6xAzbC8L4UPeuJuIHobYQeZWFQqwC
         1r2TLzXWYFoKYVsGCZIz8SrOI2uF0FEtJAycQcgBAofnTpTBOFbssYZ0CIYzh5WoComs
         t7pFm1DNASEsyH2FTMrZAgeoR7HL5LMKRKAdR4JLqkdxB6qbGZDjdFvB1SUujPSR8mMx
         /1hvhTJkj4bhNNs4g7HZNrLSPuIW/4k2niaTALm+ey8gp3z+YQy6zNFL9NibYPFSPd6j
         DoAQ==
X-Gm-Message-State: AOJu0Yw3USfX0QVpthFy+QNKT7SlgKS3ACuOCglSW8miVZqc1dBU6k7Y
	jUMquweov6DEXUpRFm+Oj+6GkOeW4RHAimcJZc/KzUOEt1SWIjXJmULRSFoxOAKV
X-Gm-Gg: AY/fxX7ZrkCHrK/okIaoOUsnOAk0Z2N+KY2jlZi+3GlZ8TYsHrKnR1VjlMfC6wPK+iL
	xsWAIdVOvttVRGYO2erC3z7R9kf6sqpvK5ruLSw6qr9v4NjmDKakEsu/eY/IcOvP6RcUeG79osV
	Z+XTzzCvq5NeDR0LWoBPy+qMb4bqpG+CyIfgAT/F5O+1tCGOgNjPKUAXgzU2F1uR/PrRdo+5n30
	TSKNs6Vz0KtF+6JMN+sV8rr5U5mVBHuIs7EnTY8fT1gyHO89mEX5MJ0IBZoz7ZepKL3sRdYwy64
	pm/pWvdq426+gx58hW252E516AKLYU405CktftMcWpgFhzz61ZGHS0PuxORmL4e8lfJnQaSeVNF
	GCnFZ4ugMQBTdOLCG3kV7AH9wg58DlHBSwCK8Wiy9JQ+UUw9/6VcSHK5Z3Val+w47KGNqw2rkVg
	40v5XsPeN/P8qAaMGqQeM=
X-Received: by 2002:a05:693c:40c4:b0:2b6:bd8c:48f4 with SMTP id 5a478bee46e88-2b6bd8c4caamr4621397eec.10.1768760449651;
        Sun, 18 Jan 2026 10:20:49 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b333ccc5sm11088649eec.0.2026.01.18.10.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:20:48 -0800 (PST)
Date: Sun, 18 Jan 2026 15:22:39 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 9/9] iio: adc: ad7091r-base: Update to event unit
 expanded interface
Message-ID: <9c69a99f02428b6a3ff15adb1613c0da9d377691.1768759292.git.marcelo.schmitt1@gmail.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768759292.git.marcelo.schmitt1@gmail.com>

The IIO events interface has been expanded with an additional parameter,
enabling drivers to handle values in real-world units for IIO event
configuration. Update to the expanded IIO event interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/iio/adc/ad7091r-base.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 647a7852dd8d..b3c6f6e5053d 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -27,6 +27,7 @@ const struct iio_event_spec ad7091r_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
+		.unit = IIO_EV_UNIT_RAW,
 		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 				 BIT(IIO_EV_INFO_ENABLE),
 	},
@@ -183,7 +184,8 @@ static int ad7091r_read_event_value(struct iio_dev *indio_dev,
 				    const struct iio_chan_spec *chan,
 				    enum iio_event_type type,
 				    enum iio_event_direction dir,
-				    enum iio_event_info info, int *val, int *val2)
+				    enum iio_event_info info,
+				    enum iio_event_unit unit, int *val, int *val2)
 {
 	struct ad7091r_state *st = iio_priv(indio_dev);
 	int ret;
@@ -224,7 +226,8 @@ static int ad7091r_write_event_value(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir,
-				     enum iio_event_info info, int val, int val2)
+				     enum iio_event_info info,
+				     enum iio_event_unit unit, int val, int val2)
 {
 	struct ad7091r_state *st = iio_priv(indio_dev);
 
-- 
2.51.0


