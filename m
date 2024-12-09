Return-Path: <linux-iio+bounces-13293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC19EA2ED
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 00:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D472826E2
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641D224884;
	Mon,  9 Dec 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAP5qVYr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4796019B3EE;
	Mon,  9 Dec 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787544; cv=none; b=iu1r6kLYpXJRaXqZ71xdrDenuHwuz7PIrWafkIzFc5HmyPnC3Xsz7PIpqftZoZHZR9cyZvpm9Q/ikY/xV8lMxHsRv/Lx2dHg76JGTbXsJ7ie6dag0A4S41it1eXZxPxDtOPoI7/t/bx0s0QCo9D19P6rUDD4Twud9F7HGBDmn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787544; c=relaxed/simple;
	bh=/3u7q7xmqnBn1DlYlakaPaWC/gOYWB3Kv+1GMD2aKgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTlkd7JDq7U8vyI2vDKwnlfJ5e/IhngmkTtS7IDONdelDOPj4M2EsX7sUeCIA5iSYkkC7ORf94p3kwQhp8Hb46T6mz/RjH49x+BNcWzQgoBNNNhrr3QwJpeHh20UWEbpLgGdKs7b9N4/+CTyh7nAFtgDfojdUFFPjMG8rg2NL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAP5qVYr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a044dce2so54420925e9.2;
        Mon, 09 Dec 2024 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733787541; x=1734392341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqKyCTQCR1t78+ZEZSYXpwv+KDDwArFzytBEvqhSe8M=;
        b=gAP5qVYrZY1Q2GzqgFh1ZP+yW6ai2lQb6C6sAe/oO8LHsFjtvl7xZxYDg1tyr/hSsS
         8qqoqRU8MZxJzvL7/kqlquPY06AqptTDrpkjLi5QUiUvfk8aTIFF0nexzpyCqeB7Sk4S
         OQDd8RwLmLuBUhhpt40iEcfUSOl9SSzQe7FxcEPh30UGbRl20QtgES0qZDyRPkX/FUyS
         xNVrJ80llJn6TBSS+WjQwSi+77tRh0bhEUpoZr5CsDZk+IJj+m5HSYQsR7pohMuB3HDL
         cejdmgiXQxGQR4L8PZ5vhOEhqT4FY7jmCuYWNa4jV8jfTV02XOjIpqOMlD9d6tincJ1X
         sRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787541; x=1734392341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqKyCTQCR1t78+ZEZSYXpwv+KDDwArFzytBEvqhSe8M=;
        b=C7EdCxLCoq+qmxZuYWrVWyVSaH0jGTka7a8/PpNBoBbGRPvJble+SQj7NnHZORuW8A
         Z6FjdJqzTpFxXWH0k5FX0YH3WQ96VvuZP3NChPBZoXtMR1mnih3RtE16/3G3170YG5Yo
         Iww3jV/H/C9sRZllFjX4Z6DgLtDkBMg5hEv6ec5HM9SzEsG+qgfexMVHTa82m/rR9OG7
         67xAKZnZD8ON4D0Ps/1HI4w5cgczt7EjODZjHIyLDGJj4O7p9fjEBxP8VxgiJOvhjA1J
         QcbhoxRokuQt4xfNmVb78boqoG9SDjYKnWbJCmm9n+x+7FTmrhKQ1zGPlxv/PeU/hhXK
         gOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjnL/3jh1icxksR+nSqep2yUUTFF/1qHm9WGC6A8W7qOj6bjjh+L08q5lVFnCGZm3Wl5t/GopSkwJZA9uY@vger.kernel.org, AJvYcCV9s494MWrggmwaBZwLX/7aEXEdQddXjlTkh29tHR20Y2tsIpdUDGRmPzydVnKT2LQVhQB/MJ/PgPqd@vger.kernel.org, AJvYcCWOZjmqAGug8uG/c28tdCXyIjyp8XZhkrPMbTA5dqBsguBqbyWnC8fsIM24rCiDm1DaZ0mD3YYrmAOT@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGMN/TKupAX8+FAP6EIjlLrqNnJ2hxhzbQIxws/0hS6k5IuAd
	l1I6zJ6sjm1OAVq8Z1/7kyEUqk5qq5axylhMfNN7i/gnWVKbnbAU
X-Gm-Gg: ASbGncuOlfK4ob1qUWgmhPRef++R80Inzn++4LkDkjJTBEB0RnOLZ6dPxsoDs0txeaT
	7q9egYo0IWnNkTLgC3Yu/fExgeNoygWUYGB5RHnuq9FgaWnpPAXicTXi0bXXx+IXEtVtrvmRZ0N
	FanWynTDd1RQWJUw5QRrtomjhFHDBj/bX1MPIMS6V1eNCJHtgOT+Mc8kVyM2VFlnnxCRW1V0wbA
	6QJRRLv53JK7DZS4nCtQxxOFF+ACcMxekOEvQIBG5xeacrc5Pg2rELWKVfZT4eYTA==
X-Google-Smtp-Source: AGHT+IGbCF5h6QMTuhOHiBHYIFkON5yI1gRFKKYBWz7s1fmM4EiOI/uYcEdzBzkQ0jxQlx/6o18dtg==
X-Received: by 2002:a05:6000:716:b0:385:df73:2f42 with SMTP id ffacd0b85a97d-386453e1ed4mr2462325f8f.32.1733787541471;
        Mon, 09 Dec 2024 15:39:01 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:1688:29d6:6b3:2e70])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-386220b01c5sm14298564f8f.94.2024.12.09.15.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:39:00 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 0/1] iio: pressure: bmp280: Minor cleanup 
Date: Tue, 10 Dec 2024 00:38:44 +0100
Message-ID: <20241209233845.29539-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:

- Remove interrupts from  SPI example

---
v2: https://lore.kernel.org/linux-iio/20241202181907.21471-1-vassilisamir@gmail.com/
Changes in v2:

Patch 1/3:
	- Switch if case for better readability

Patch 2/3:
	- Reword commit message

---
v1: https://lore.kernel.org/linux-iio/20241128232450.313862-1-vassilisamir@gmail.com/

This series adds the SPI interface description on the device-tree file
of the sensor, adds proper self-described sized variables and performs
a minor optimization in time variable names.

Vasileios Amoiridis (1):
  dt-bindings: iio: pressure: bmp085: Add SPI interface

 .../bindings/iio/pressure/bmp085.yaml         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)


base-commit: 5ab39233382c621d3271cc274d1534e1b687f4d3
-- 
2.43.0


