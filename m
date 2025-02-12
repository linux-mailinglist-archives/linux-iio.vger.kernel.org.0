Return-Path: <linux-iio+bounces-15434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FD7A323F9
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E6F3A6551
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2086A209696;
	Wed, 12 Feb 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HVpMA+aT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD8208961
	for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357625; cv=none; b=udHIkl4MJZI8OeAnCX6y00+YAiCEe14QQAggO0YNuKomgHeB4BnyCkN6wKURGq8YEKOsf0jNq1tRejhtbrDIdCkboltuTwM9DHJqbvLpXoXb5oG0y/1reHlkXgf+9MIhB6WgxAgBFQVXC0i/El/lWo5NZuHz+i07WOFivcuaW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357625; c=relaxed/simple;
	bh=7tAI6l8EISC5KTpcJdTrqugkgi78VgtOpt715HVaYas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pOry9vihXqS4wwlQfCEL3cqXBLPmGSb05Fv3GIzpPwJOu8Dm4gVUJ/3tnuEZXNs8/4qIc6G5QPvMqhdbN3FYh2fsIciohR2MeugtCUk3c3N+zBKCDf00wz0e+pJ+gqSNXdq18c2b3s+RYoq8V0Q+Oqefx2T6HLvFn5O6+fBIDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HVpMA+aT; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38dc0cd94a6so3184630f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 02:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739357621; x=1739962421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=op/e0jmwBDjq1rYYp2qwwvuUSqAv1cfNIju+1/Ry0e0=;
        b=HVpMA+aT4zqjfDAxOZ1V+M4xVngbsK3+dEtCr5juiRflz3FWUT0KMx7NK3xFddKhxo
         tJ8CmmX7oOMdbLc0/W/JbosmHXHuMMDgahsS3gYWc4zMsa2YPC1+MTbVtvt9TmgYn6rb
         Vqg2CJjuzfWy1gBzwhQuwVdCVI7cp4Wk2UFiZpuwaOoWGTaFw7e6I1z4b4vkJ58VSElb
         iYOiRV1/HGATwLjkAgTHbIxOdfsj3VB3UbVOglxLJ62iClAkhGj/h+UvTD4YuzkIFWcS
         NfVhWOqxWAJ3nrFShB8aUAHsZ0/vuf0lZ9FIuI1I7qtqDhHmWzXpy/ckDRfeMlNMoiCH
         X+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357621; x=1739962421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=op/e0jmwBDjq1rYYp2qwwvuUSqAv1cfNIju+1/Ry0e0=;
        b=CkwqKRN4PKUiXCWmAvkQVQshRhmccPUPOEh5MZM6fwqhzPr7AYCraCnhGgpobVdEAt
         YiSYv3fTj+PT+F05mYVpdl77TBflRmnTQYQVoAl6Y3m4gVxfp8B9KedfOkaMGZ2beS2d
         gkuTd9hlCQlBRcrLWVXuqZ1etxZ58+ldIgM0PfERCyw53ELdVxTM4/9eZR8ZCchfDwmo
         w9Cx2zaydd0e2olwHvAGEJt5yOsdiT4n4pweBhnj0nCXcTDdIEoPT7JP+sdbSIDZnRCb
         QVC/6MpSS/JkFRPbJprFygDnBesBWmAFFvMU+sQytvoWCUfD4uOpehSuiL2X37EmxE2b
         KRUg==
X-Gm-Message-State: AOJu0YxdapEPurBqvx2N06H6nR1eggPR7PMM7vq8ktRVGtVci1epfepj
	GGho4vxKXjcm30JByTY3HJhdoVkQ+2A43Kl4br7KHzKZDbBtCW12GBLzn3FR8f4=
X-Gm-Gg: ASbGnctOGkT5s6MY5B12iF84mbo8hPASZKTsk7gq2GKvE1kGqUF/3A4jueuNoOtKmh3
	4fubRlDGrnqjCV1KFsfQ7zVB4iJH5Z9okyJAEfMF2z1EVaT1zIy5Rp67x0Vdh1QkZXKXsKo15V6
	o9SRjAkL61pmJIXzOveKI7DbQxgILg0oBUuvHOExZFbVq2ATE6pm0f22sYHQNg6dsW33OfGN++s
	v9+ohfzqQ3jMTBYpG0eFKLdjVdj3YdVWmPpEANK6BxM5miWvgDAcxnJveR4q7wTzXlKAgu0aCOz
	PebyZ08/B7ZJv6GRUc8ldpuVwUot84DesyVRkkpAvGVnokgxvp4FiXp3ouyBuuP4Mk8Mlasi8mB
	IHQ==
X-Google-Smtp-Source: AGHT+IHtd2NbmqjDHASw8baIWDINB/BqxUxkPptoqKZN3Mw+d9GAhJh64/v6I4t8EYmb8dNBFuDSNw==
X-Received: by 2002:adf:e40f:0:b0:38d:df70:23e7 with SMTP id ffacd0b85a97d-38dea286d28mr1894614f8f.31.1739357621605;
        Wed, 12 Feb 2025 02:53:41 -0800 (PST)
Received: from localhost (p200300f65f083b04d1ced5eed56c82e8.dip0.t-ipconnect.de. [2003:f6:5f08:3b04:d1ce:d5ee:d56c:82e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc6b89ef5sm15347681f8f.31.2025.02.12.02.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:53:41 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v1 0/3] iio: adc: ad7124: Implement calibration at probe time
Date: Wed, 12 Feb 2025 11:53:21 +0100
Message-ID: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=7tAI6l8EISC5KTpcJdTrqugkgi78VgtOpt715HVaYas=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnrH2iS39c8qWOJz7PrKB5uZfPpcDQC1wTg6+Nn rnyL1sFku6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6x9ogAKCRCPgPtYfRL+ ThtuB/96yoour1y+LxpIvrL+P+wkVF4F0lB2B1vvh9p495E6uvNv+WKlxH7ofZoKLwupFOhH+gL HMZNluXUKBGaShiXKsFQE78jHT6kLaIBQacS5TnSD81EEKFepQSMloICzwdse1VGFaJ/dsPzUCQ oa91ay0gtiRZsCoKVd2jB7dHPnise82L8/5cTFkQr2Mb5fQtJLmEAQMGVCn31z7LvnJc3GBGjF/ QDXcoFB+GoD1di60pxgb5h1TQOQftSlLPLMiqKAIxVUbg3qVfL15d2DyttXtBFS5S8O4Xs05zyv dBlYZQYU8PcU0LYZfYSi81ukPUsbjrAFgb70jG8B3+9+mRUX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series aims to implement calibration of the ad7124 ADC. The first
patch was already sent separately, and got some feedback. I include it
here (yet unmodified) as it conflicts with this series. The second patch
is a change that I need on ad7124 because channels left enabled confuse
the driver logic. I didn't check if other drivers are also affected. The
last patch actually implements the desired calibration. Missing here
(and the next quest) is to implement runtime calibration to fix
measurements e.g. after the gain was changed. Have to learn a few things
for that first though (or find the right driver where I can copy that
from).

This is based on
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
.

Best regards
Uwe

Uwe Kleine-König (3):
  iio: adc: ad7124: Fix comparison of channel configs
  iio: adc: ad_sigma_delta: Disable channel after calibration
  iio: adc: ad7124: Implement calibration at probe time

 drivers/iio/adc/ad7124.c         | 126 +++++++++++++++++++++++++++++--
 drivers/iio/adc/ad_sigma_delta.c |   1 +
 2 files changed, 122 insertions(+), 5 deletions(-)


base-commit: 0c5d8af2a5fd5e5a9d17ad41e81501a12245bfc8
-- 
2.47.1


