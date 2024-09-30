Return-Path: <linux-iio+bounces-9943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083698AE2E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 22:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539281C22748
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E601A0BCA;
	Mon, 30 Sep 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V34jMGF0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3199190482;
	Mon, 30 Sep 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727847; cv=none; b=mXxKdfFmT+uNmjBkhnGC0oU1qzk7bAJhmYZW0K2R21Yk3abg5cF3RZFqoRkcNeU7itzW6XAGsmBRtxnZWkfjE6TD7jBxiZuJIRzFsYv5ovXBKbOhYZRPqdO7bPjbiY6oYfbk/+vVPLRTUDlacKZYOMokuMIhg49g1GAmmbPTlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727847; c=relaxed/simple;
	bh=qLDNM9GKbd8txMFBsggRR49x09zsQBO5ttrzWdRdklY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g3XJZSplBvaONpU8lOu5lHiXVxqcnOnirN+Xz3tZP553lEZ2dLs3FwZLaBAKBmGcUiVIHu4KNGdrQW5+xtj3w0g28wJM4hku+/rtf4xH9osTq34lijsDSiTC8wg8r0RS0ZUyTasynZMyjgsTPFYTGTMcyND/Sv+ND1TUMUYnikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V34jMGF0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so44336555e9.0;
        Mon, 30 Sep 2024 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727844; x=1728332644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiUBJRi6M+3sxzVWh6NV1EeMCuFcrGWjJvpoROfvAes=;
        b=V34jMGF0vthZxGWAlEy7/BAgP6x8APuSGKb9oa8LxSOetC6LlDGlFCvIgtviVLl6wB
         bI5SGSWvojuQ11lZL8wd9RAA8DU05UJ47oSVczxBJF4FvzetuCHfUaLxlabgroUn0XqW
         /8HDQ6JQQXhvlflQc75/JkjMYho+GhqAiN1mok9hL9D1jMFwb2zwSafvJKV56C7M8lRL
         GSxClho0+Izr9EVQyE83Vayr/1WnfwnU2I2iu8YmRC1thGb2Pk8+/5OhHkgrC/mBcsLf
         kD1ecKiDoZCK6/f8QrXENSHZmrEevlbfverdyb5vvRdzpwwG6dR3E+qUw0ui5Yg+IrC+
         IQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727844; x=1728332644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiUBJRi6M+3sxzVWh6NV1EeMCuFcrGWjJvpoROfvAes=;
        b=fKVaGlf2pwjX6/nAvOowpxEn/6IDJ//WzqujaB+HD6jjIkUvI/RD1zIe0UANpVVdrp
         D9/d8A2d5JZ3XQdxofwdb87v1CYbmOdg/tZocNR9tzzp4IdsBEKmvpG9p0JR58a8rurS
         WB2ghd/1jU94SPKbQxygV+HkT6TpIYDnHmJ3Ad645FZQvKZlLsSLLKU+zwzxEhivFrm2
         psa8Va79DFM+tUFI7xFlZmFzHZZbnJOa94b80VhKD84ztXtDOI7zeCOTgjTvWM+xQTNp
         3ncXp9wUFlTjYM/+NNKILDbCJb2ql2hxcN/lSiYWt6g5FonxVYxh4Mi99zNX+lfb+50W
         ZmUg==
X-Forwarded-Encrypted: i=1; AJvYcCUaIQEHbbRrWmN3i2pMbMKA4ZBTG4xwwf2rFlFDPgDoYZC4G/DhIST0t7mOfPTppJWLUkc9K6wfZFw=@vger.kernel.org, AJvYcCWfaFAsjyzNxRYeVyxbfojlgQbpXdR2XF6tM/qsAN3BouOu4PFyHizioTrb6BowT6ZDWvddV6YSYkadiv1u@vger.kernel.org
X-Gm-Message-State: AOJu0YwZEei8wsHADW/izS0TS/XdJ6C6Bw/0WpoJDnNrvnrDE+4xd8Zv
	SKsHv051E2uYUGHbhF9GLX8MUxrdo+Ac0euMKsnA/BPcs2OCYZhu
X-Google-Smtp-Source: AGHT+IGKDoFA9oP1DF+c68XHBlJeAR76DbMAIaT0yvz4NwlWOfcTxniYGcxhRBI0YjJqkEARW7alVQ==
X-Received: by 2002:a5d:470f:0:b0:37c:cdb2:c4a4 with SMTP id ffacd0b85a97d-37cd5a831f1mr6002404f8f.7.1727727843742;
        Mon, 30 Sep 2024 13:24:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:89eb:9ac0:8a4a:319b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e65e4sm10064052f8f.61.2024.09.30.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:03 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 0/2] pressure: bmp280: Improve pushing of data to buffer
Date: Mon, 30 Sep 2024 22:23:51 +0200
Message-Id: <20240930202353.38203-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:

[PATCH v3 1/2]:
	- Remove fixes tag

[PATCH v3 2/2]:
	- Use internal s32 *chans variable to better visualize what is
	  taking place in the data->sensor_data.
	- Use proper size/alignment to the data->sensor_data.

P.S. After this patchseries is applied, I will rebase this [1] and resend it.

[1]: https://lore.kernel.org/linux-iio/20240914002900.45158-1-vassilisamir@gmail.com/

---
v2: https://lore.kernel.org/linux-iio/20240929112511.100292-1-vassilisamir@gmail.com/
v1: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com/

Vasileios Amoiridis (2):
  iio: pressure: bmp280: Use unsigned type for raw values
  iio: pressure: bmp280: Use char instead of s32 for data buffer

 drivers/iio/pressure/bmp280-core.c | 69 +++++++++++++++++++-----------
 drivers/iio/pressure/bmp280.h      |  4 +-
 2 files changed, 46 insertions(+), 27 deletions(-)

-- 
2.25.1


