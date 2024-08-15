Return-Path: <linux-iio+bounces-8506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A449538EC
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 19:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281AB281FC2
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716181BB6BC;
	Thu, 15 Aug 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DJvmMZsW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BED1B3F31
	for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742542; cv=none; b=fq0bySiMC5dgvWCffUfFy3YkxFgNXzeDQ9xDLObbgeHKgvC/qstYEWjF241wgpaP7P5Qx9U/KVa7A4B2mpbxYUhxCshqK5hT4Aw1mu1oUqOL+tMM+UI7qMihkXnwzV1xo9EtwZp1NNjL7CHHo689jpI0PQJ8lcEN/fEwFa+QRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742542; c=relaxed/simple;
	bh=D4UwZUQ81I5vLXXTS5znzAKk9dzOv8liLoig0hVVJqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwtH8ZtYOfvBTo/HDI+haSz7TI827Wjqehl8UQsPIlxBOdT0TLYqF6erTlcm6N3NULjBR0o9JfaCd+cSfsaWaMOn3b/IFVcIegYU+TXCgDzBpX2Hd8YrG3ECi6YaJgd2gK11UccWYPHgFt//MJLIZY+cCbBtYolk0543SwdQ99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DJvmMZsW; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5e97b8a22so683895eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723742538; x=1724347338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYo8NEWGJIdtw9pJBLY1QEQbt1FShFOkJGNXlVqgZP8=;
        b=DJvmMZsWjY7zmSE2CTJXf6WfAhFgwNCKgZYzd6OHd4SuhraCH22ZFkTNPmxLJW6pLr
         jRCZ3r6HHkJ5oPoRYg+uYFhyKAl8X+H+Y2FeZ+xzwyafkNKtsTvISz73jz41S/xAfLiO
         W90f/PElk2heyF27jozZDMsaMTy/frJ9WsFVmyWW552g5XuOIYwfHB8+PSfcqtallJES
         d4dS24rrr+WnuYqWiVCb7CZBYQoNGx274cZXnZFv43LMLWxLce4o2aZ6dr/DusxTQjeZ
         7ZNRietBb+xtd7J/S6JWzw7UBBi6e3L8sCkszt6sG/pzz/T3ri97oxLpgLSZ/pvfBIZu
         17rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742538; x=1724347338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYo8NEWGJIdtw9pJBLY1QEQbt1FShFOkJGNXlVqgZP8=;
        b=msCaWRdJ2gKUVKHL0iKLzEDqzp/CHUZ5uPgx0e1ufN8Fqo+XsrFrQVkcYVZxAgn9kM
         LA5lzfEq4WPcT3e9K0fABdeuQ5IrzaTqk9NG+QUZmA+3pj7Nf67MUQaHh8meh3RGxoxs
         7EBr4f+JCqPmeMQXMak4U40o3B9lK3yq+kEf7y7liE1T2gmfA/+6bixWQkbXI1I1C9IW
         9acA605tQVYIMLPdyAroGNeMeYIHCBXzZl5VEp2rb6kuII7bT57XBiqc1/+J4o3WIv5x
         /eKf5hXz0NgScB2SeNHfa5ugfu5K/MZXiBk8yQ3yh2w5Ri5L5Y9YgrGcdamS4HxF/LmI
         7C8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiU4r9j8koOH/sgtKmirFxtBRXuDCdFT+Jf62juSbzt1GavEf9Rw+zvML98Q3ogremaKNJbkFwZT+apldMlBaJolRl4GIBt3JP
X-Gm-Message-State: AOJu0YyM1vJaO9eb1KzOGkjizXgsTzmANKmG1qcqktUn/HkSOvAIKZvE
	4NY5/o78dRNNGwLzncQsgMQ7LmXq+gcQPKmPmlei4vlwSecOWuidf4ld4vnazaU=
X-Google-Smtp-Source: AGHT+IEr2pJX4B0DWbzhh7aV0O3Fjoo7uLRK/CK6MZwkprR+TAigHIXKquq4qfr36D6u7mbE2e606A==
X-Received: by 2002:a05:6870:d185:b0:25e:1edb:5bcf with SMTP id 586e51a60fabf-2701c34553emr282901fac.6.1723742537955;
        Thu, 15 Aug 2024 10:22:17 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca66297d0sm345327a34.68.2024.08.15.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:22:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iio: ABI: audit calibscal and calibbias attributes
Date: Thu, 15 Aug 2024 12:22:09 -0500
Message-ID: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

While preparing to add some new variants of the calib{scale,bias} and
calib{scale,bias}_available attributes, we noticed that quite a few
of the existing attributes were not documented.

---
David Lechner (4):
      iio: ABI: document calibscale_available attributes
      iio: ABI: sort calibscale attributes
      iio: ABI: add missing calibscale attributes
      iio: ABI: add missing calibbias attributes

 Documentation/ABI/testing/sysfs-bus-iio | 64 ++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 13 deletions(-)
---
base-commit: d505a9dc8de83df2a8ce8c9e780f7b29887f34af
change-id: 20240815-iio-abi-calib-audit-fcc21b1c6892

