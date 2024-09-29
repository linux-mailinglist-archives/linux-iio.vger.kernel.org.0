Return-Path: <linux-iio+bounces-9868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D313598950F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 13:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E5A28205A
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8015885E;
	Sun, 29 Sep 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO3YAk9c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90759184D;
	Sun, 29 Sep 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727609120; cv=none; b=WgNvNKjaged4nFOSu0QtSRQ3GKlBflSbTG/BHPvcyrxeNb5uSjqySN286mngEboYtdgaFED+/+Vy5Z32ic/1gq0m+9aw1Ap3/5fBfG6kKR5J4UzvPC7bljunfRHpE9D+69e4o09dcvfpqLpD+SB+S/DNytF3EO310jcBrSp9qpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727609120; c=relaxed/simple;
	bh=xv9NyiB6jqa0NALBI0EbUQmnEfaZIR//BucIfgqRK/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EiKpm9FmQjgz6hrlbhbVBfVeJfEw2c5+MXrDcRbT20GTLlxzIqw8b2jQtV64qQaiKBmsZdik8g6DYVjOZXm2XZuajJo1mh89/YnWhWUsQxQ7EH2EtWPyNN1O4AWGeVfdazn5T6A6bOs3YVMyiWb6O0PH1/aaENsCXUA0jICd/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO3YAk9c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cc8782869so32375365e9.2;
        Sun, 29 Sep 2024 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727609117; x=1728213917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BillE2h2UciyMb8JXKUq5M922cmgHc7mqKlw2opg0Gs=;
        b=aO3YAk9cIld/gNdFYRis9ng6yEoHrqfwlMQr6eVt2YMh8iNxAj2E1lATEuk01DCsFQ
         Fokw3H87swBdHL/r7sQXmNE+gWy8Snr+6uvtKRyJUBwDbPb8ulCa0LPaStB2Q6QmNmSK
         iVZdeyFKYRbjQKxZlqIhZxUeOKUmwe0wASdZn3y55JWLvdBFf+9cdzoTKCihzDqQhhDT
         NlbTDi6uzEtoy9swvE9Djomt6ZWc5wr9ohacZe6ZJce2kN8BglmVsUs18rMpeztQzqUE
         DvwxGshGUi9Sp5pwLCmYE5NVDvXcPyALkUgXL7jCMwBwEBC1lOXB5R3yEgmtwf8zQZNl
         Ba2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727609117; x=1728213917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BillE2h2UciyMb8JXKUq5M922cmgHc7mqKlw2opg0Gs=;
        b=DEL1w5E04BRKPRdESCs3eDllLwrlC99DxyP2tbKW9tHpMwbDKn7uU8E/gsJ2wdrAJV
         7pUEVcPjtred1jZVGqWbm/kJPSbz72ET84pqIwCQAKCx2WAB7lrlK8nPPydOHCuZ2qzE
         r863r3GH51Vsq7QSpS/6/fQrqNVt0Obe8vBPcFAFPn8qgQc9vTYM9tbSseMG3tLiNK3u
         YmjFi8pCd1ArJN+ccuyP6r1+IcSieNEVx6OV3hQdHGydww1Iqo0hu6zu0m7cgqwCbVKQ
         R8hnIZ6n+w9CYERxIxU8kIRTKaRqsfdJiWzUUs6Qbpxn30nrRaf/dMfaFt4fUyYrd1J8
         5IGA==
X-Forwarded-Encrypted: i=1; AJvYcCVq9+fuTGmx6yJ6vryygz2he0SZ6I/J2VyGIlVO/3tI7xZvVCSQIFtfp5q7c2ILR+fCzFQQXRrl1Mo1U7i2@vger.kernel.org, AJvYcCVyKkvFpK7ZUTWpM/TXRh9oSWp8bKwRv24dOBRPnTSTZQdVVAveYpiSQCFpEK5OJ1wQNFqqMiOwxMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wpIUkUFeGD1C58+JPkF79jgAPTzQh6FYELLdY0HdjsBOzUnH
	dIq7ucXBQs+AXNBH8oLw62NMSsVpd0Qim7QNZZpAPHz6bBd1XIYL
X-Google-Smtp-Source: AGHT+IHvkxxBPewJlcmBl3aR0qmBZnVpBk9oj8pDZ7DhhaeXLTabt7WrC8+bNaEoUp07sihEWDLcqg==
X-Received: by 2002:a05:600c:3c92:b0:42c:ba1f:543e with SMTP id 5b1f17b1804b1-42f58497f54mr63599845e9.26.1727609116615;
        Sun, 29 Sep 2024 04:25:16 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:df60:d786:cd5:d3c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57de1192sm74717325e9.14.2024.09.29.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 04:25:15 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 0/2]: pressure: bmp280: Improve pushing of data to buffer
Date: Sun, 29 Sep 2024 13:25:09 +0200
Message-Id: <20240929112511.100292-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
	- Add 1st commit with a small fix of some data types. Shouldn't pose a
	  problem.
	- In commit no.2 add logic with "offset" to make it more clear what we
	  are adding in the buffer. Also move the memcpy() operations after the
	  if() statements so the memcpy happens only if the data are correct to
	  avoid overhead for no reason.

P.S. After this patchseries is applied, I will rebase this [1] and resend it.

[1]: https://lore.kernel.org/linux-iio/20240914002900.45158-1-vassilisamir@gmail.com/

---
v1: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com/

Vasileios Amoiridis (2):
  iio: pressure: bmp280: Fix type for raw values
  iio: pressure: bmp280: Use char instead of s32 for data buffer

 drivers/iio/pressure/bmp280-core.c | 75 +++++++++++++++++++-----------
 drivers/iio/pressure/bmp280.h      |  5 +-
 2 files changed, 51 insertions(+), 29 deletions(-)

-- 
2.25.1


