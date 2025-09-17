Return-Path: <linux-iio+bounces-24227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F12B81CC2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14D9188FE27
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8A2DC339;
	Wed, 17 Sep 2025 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e3XM9DLZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0134BA30
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141598; cv=none; b=IWo9V7GzxyurU+upZB9KKzZFMk27g/ujzVPnQXdr9e6xJPe+uUKQ3d1dRePwLvVobPtKDW2IV+OeGzt1fLuGXOetl8baYFhcTQaphOUTMtrl667q0p+4TZWHHYavT83L13Y5kqN5CoLQPVlIhcwj96KOgsM0TZ8WlvqQkcGbZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141598; c=relaxed/simple;
	bh=2/x+dYKZD6xa55/pvqHmtfVR8DzJxYmPYe7A+Nsj6hY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=enD0/wBfOglGlNlcZ8ExLRq4cMgUFQgM+Dv3oDGQKzTLrkLZEyRnMxZTTK79lcRwa7XXz5YnoCwdhtjFCcWpah2r/3Ay5keuO/2OwfnM/AW9ACMHhlXnAXL+yGhkf0NXQIkMnqH3dcwk2D0ni7oe8jRrfs1/zKb5Lc4PpCXouV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e3XM9DLZ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74572fb94b3so218138a34.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758141595; x=1758746395; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqKSWWYdk1ThAAlpvWMO6xg5YbcTBt+NMlfYP6MQcwk=;
        b=e3XM9DLZKMqsodlMpWAKVFmlIo/Oe7cHZ/brhfOHTBqBB5QDnkZ1UjwqQvQq3nGt5D
         zYtU79KnCPbAqalXNaGNO+n7f6Dj+cx7dRyllMGCEiqb3ZfKYPo7FIw/Cr7FfDCSAkHI
         OAjcCawR5h5zG4lf6+8LFDuD/0JdoIWnR4T9Bv5aaBgO2qqCx5WmWIeNADRCbVAQNa5t
         r7NrY2uNXsWa2zm4Mz1/qpuLejuWVgR8SQI39cEX6tE37qnQIZn5uF+77+H6mKus6vNH
         kt2ztT7P3ZW5zMmLY+8SSxhjaRZzmA6XpsikrVGe4QrogTo3xx5V8bo3qAfnrAaodt7R
         WChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141595; x=1758746395;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqKSWWYdk1ThAAlpvWMO6xg5YbcTBt+NMlfYP6MQcwk=;
        b=EHqkIYQ9kdab/EU1SEV7kRCujO6S9dmNj4B/PKq3YCvuBh6kBZZZ6uYZQCVCycF2RU
         4ADQOaA00cEyueTATIUqxuKUA0zPAswkWfuK5ua2dJjDMpqFPIcBJWpkNE/U5bfZCsF6
         atH5f1Sd+s4LpQgo92xmyNtb0Pa+q4VYrwBPhpLql+DVEUtrIWuwOaqZnOtnQ7ytHLlD
         hcxyC0G+Dh6PateAK3WuPQIeznSWpjNxJZNrCk2Z294WKwkhX0rRD5fmxgNb2USKftLG
         +Iu8Kmx710KZdIEZdBDXFNqN9dvcJZjIfUjLjGepxFx7CSkejZWmBMbvgFPxCGS2dHgj
         Mq6w==
X-Gm-Message-State: AOJu0YyCN7qcZdnlEcznW8RQKRaHi5tsoUIrs+Zbo+V1uAhsqP530e7t
	v4mDYlNpHGE7o2xrYdftOX9XF22wmdA2TeqkngtI18H8gW4HcvfmfarQdkUMJrGl32o=
X-Gm-Gg: ASbGncuCfIc9fczZk/V2fcw5l95Z9H0i3FxtBPyxDzppf72bT573Z553nrZfRtXw+fD
	pi2c1SakmS7WuD2hkbKRy6afsemv9m0EWRlaxuzC5TD6wr38n79rfEANFy6Z4Qy6iN5h8aNpzCW
	+vs014G7M8NywWSx4I782d+RB32tE9mxdbqA3xcGZPyEtTCqu9dBfozpCUp6HrdggnMWOt6An0Z
	1usLPApHYSB5yz00P04eoncVnUstyeqaftfM2GZk34pZEHtaDAc37EsltlamyySKtWKETjSM4GS
	vzAbn1Ofz3GREMkd9lfmuLQuUrCh/wOeyI9KFhCI2fNZRdb8VcmFxipS1CrSiX9UXnp3i7pbA1Q
	tZb8giNcweVc60nt6ucznF261e5F7Qqduo9zZ/p2H18y4rw==
X-Google-Smtp-Source: AGHT+IEUu0NPJGo7/24jdepvukIaSF6bqGHvzgQdGqc9oeg8vP5PXXtgt/hO9TAluNFy7pY2R2BM0w==
X-Received: by 2002:a05:6830:621a:b0:745:f1e:50c0 with SMTP id 46e09a7af769-7632178b440mr2224569a34.22.1758141595305;
        Wed, 17 Sep 2025 13:39:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625d8eec45csm124036eaf.10.2025.09.17.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:39:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad7124: drop nr field
Date: Wed, 17 Sep 2025 15:39:21 -0500
Message-Id: <20250917-iio-adc-ad7124-drop-nr-field-v1-0-5ef5cdc387c6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkcy2gC/yWNwQ6CQAxEf4X0bAPdiCC/YjisbMEmsotdNCaEf
 7eRQzN5M83MBplVOENXbKD8kSwpGtCpgOHh48QowRhc5erqSg2KJPRhsGvInTFoWjAqjsLPgDW
 1VDlHrb8QWMWiPMr3X3/rD1Z+vW1lPUy4+8w4pHmWtSvsO5fKc7K0tKHSdJU4Qb/vP3e3n0iqA
 AAA
X-Change-ID: 20250917-iio-adc-ad7124-drop-nr-field-518102218a61
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=2/x+dYKZD6xa55/pvqHmtfVR8DzJxYmPYe7A+Nsj6hY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoyxyBxjFa2lje7jnWOqd1Ba7jq+za43wXdNYoy
 z+NSjAWNLCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMscgQAKCRDCzCAB/wGP
 wJZiB/47ycfiFUBV95DuLZh5vTzYh5z5rvc/rm3Pi+Jq72zG33wxE78vrF4P0fpPJ9cXtjafIFU
 HtRB3dEnbQ6HJJj9WmW5NCrW6DlZnJu4oLEGbwx9nO1anyj5Mfit/sDCmN/ZBXgYogIyBlQ8sNg
 39GlUr4uQVdpj4tn3e1kEAtcMIYEPexgH2vwlfqOAFdv9Et25h+my6s6uZ+rU7OMRmOMvFQraW6
 gYKdF3UqtphfJ5BZ0QePj11i0KpgaV5pWwfO1nMi7BMMuz0X38HbEwY+HEYunbpJkE8GNi/mJ5F
 FUdy/gvDNS0p6axHX6S2oX0D7ra66y1xJ2NdmGEsIPqcAG53
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The motivation behind this series was to remove the `nr` field in struct
ad7124_channel since it is duplicating the same value as struct
iio_chan_spec.address (and duplicated again by .scan_index).

When it came to actually doing that though, I found that it was easier
to first clean things up by removing the ad7124_enable_channel()
function - which is a nice cleanup by itself. So ended up with 2 patches
that end with the same result without ever mentioning the duplication.

---
David Lechner (2):
      iio: adc: ad7124: inline ad7124_enable_channel()
      iio: adc: ad7124: remove unused `nr` field

 drivers/iio/adc/ad7124.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)
---
base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
change-id: 20250917-iio-adc-ad7124-drop-nr-field-518102218a61

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


