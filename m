Return-Path: <linux-iio+bounces-15276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED45A2F2D2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A23A614D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019052566F3;
	Mon, 10 Feb 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FPHLrmhX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529C259495
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203980; cv=none; b=hAFmz5v9fixaK1JIMMvPAgR5LMqz1l4H2ZSQqe8al/yIsKxvGxHBRHVFwB11LJm9xt9EFHRAtFMIEwfMU7XfjfFmYv3Fd16p9EAPRt0Vn4f/sK5hOSaH8YcWLlW2vljONp/JfIR2fbFoNgLE+ghCW/wAGGEOaqR6qs/rYK6iCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203980; c=relaxed/simple;
	bh=EYN2jmjQpt0Relr6D6FUdK13M4l5zeXDuBWC3e77YUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bkrk4E+BuL2DBDCWe7YyeRoRV1GGXEWyRzL79peQKz2FX0JZH/XvnwkJiIQxmpVOWk3LyQNs9FrAU52kZXpY6AN/dO5LSKq6PMmpb7MhzjkvlYxrB5aOuTGt1o9h85e1WjqMJgVKdK7lS3+666VEryLmdBipRUAf90Ewiq6Xpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FPHLrmhX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43937cf2131so12259545e9.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203977; x=1739808777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIjPfuFGXuMmM5B5bh3vlcOXqvUxOsdFQdpkLRhWYHE=;
        b=FPHLrmhX4ts/LCgk7/x3bYH2HAsnyNptf+3hs4tl/l0O/vXV98N6bdaJEht7+q2MHd
         3wv3vg7xXFzhXXQHV7y/pMariaIkHuHrQAlYbBXr9/uFmnIJlTyBw7hOLguJNEp555MS
         cq8woka8YhtXvjRiC+n2PPo3OhHyKy3EuFB2UnSZTkrZfmaIUKnQS8cX3Xe3P5JGVFju
         3l6xIk6/c34RuOSrdbu1N51TKCxYrhSLz+elkzbExhfvWjax/zRQPt+Vs7pFXaixf0wD
         JG5KmNcKQyhAVDSbRGnkzNrA3+2b69hwxcDFdAusbkM67pmSjar7GnH8oqb/0oc/mvN0
         NDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203977; x=1739808777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIjPfuFGXuMmM5B5bh3vlcOXqvUxOsdFQdpkLRhWYHE=;
        b=TV+BaZL2BUANvfWA8FNUDA7q2WL4f30yWc2xIBQrHESKZuV2bsWBIPAvgZbubVm5x1
         U+wbyosXvxwxDFrg2TdcBQWEcDqeQUBqZ+kZGiv/OGdkplv6mhTCI+6oG3U8VmaHwed1
         FXl0TRiy9RT0ae7KHi84gJHgCSvXOa9orJVp+J41jDAX1OXTllPwkPzYrcy0CQ7fh0px
         EIoofEZitER90aL8vOdgKoDYpvIdu3aplVd3HWpISRC1p+sQFZpc/rb0cy+fWKRFLAZW
         bKvCQtEzmODXzcfcECIzx2x/D8dtzMZsmzNXJ7fR3RS97NrXo3OeJbvZRmc14aA8gWXC
         o1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9iHac5r4bKjWS7Jhp/fSYm1uealfDf36cdOMIkijGe14828Q+slW2nd+z3iVIntOEfzl9lGS/QaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0G3RhX4ewNldaMkfbR3KF37kn10lA9hTF0J/bq5kHx+/LXYP
	7ns5ecD2G5t0acqRakvYqd6WU6iwEwYisMOPFzspCGKmrMbyA3ZvD427TKzo+vE=
X-Gm-Gg: ASbGncvLzQSW/h24iY/ogaLKHgprn/xnJJQvjG8w6YsQ2pIugkYBvvqc25ous65Pdiw
	QwNwhwNHHNGByImLDIgDLQGv1mg+Ni9BF4paD8U9WGxVAcnD50nS5vuVQ9A4kFy4ctkwxp9Z//H
	Y5M+FsmJgQ5ZznUxjXtn0pePkGRDzzh5t8DsSX1FYALNKteWEELdrL4l/DZstNHS+Zvw4xF5/5c
	ZpgTze8HIlQxPHfEPnngeHkfc6l0+DL8AkrHYSjxahZTCU6FzS/52Sc3pipyR+M93X60+qALl8I
	c0eYqP5D9JpdorTQmowymP0021/h6qUFbDENCiXMJLbA75RFQC+HGufJvU3jEAM=
X-Google-Smtp-Source: AGHT+IF8U4g+gzBJ/cIqcckdV7LgaRgLDwbSHf1t/ZRLRiATW6wIMx/g/+6UZw2NAefFPk2iWnxLJw==
X-Received: by 2002:a05:6000:1787:b0:38d:ae82:e5ed with SMTP id ffacd0b85a97d-38de41c3d17mr166768f8f.51.1739203976810;
        Mon, 10 Feb 2025 08:12:56 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:56 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Feb 2025 17:10:57 +0100
Subject: [PATCH v4 7/9] iio: adc: ad7606: protect register access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-7-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Protect register (and bus) access from concurrent
read / write. Needed in the backend operating mode.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 7985570ed152..07656fdd602e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -862,7 +862,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		}
 		val = (val * MICRO) + val2;
 		i = find_closest(val, scale_avail_uv, cs->num_scales);
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
 		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		cs->range = i;
@@ -873,7 +878,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		i = find_closest(val, st->oversampling_avail,
 				 st->num_os_ratios);
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
 		ret = st->write_os(indio_dev, i);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		st->oversampling = st->oversampling_avail[i];

-- 
2.47.0


