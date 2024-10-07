Return-Path: <linux-iio+bounces-10280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B49930F1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6903EB2552A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49CA1D7E31;
	Mon,  7 Oct 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwMsHWfj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA31D416B;
	Mon,  7 Oct 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314414; cv=none; b=BQVzpyYPMYDXfVsvU79n+ry2zPnKVL7/4XPSy11aSA+lxH3nGF5MHjmrSP/SAMH6AbaLlPv+uObSoZg9TmKY941KyzqUt0FraImdaW8iveAyeaa+Gsiaiu9YJahzSPZQurYPZ6eaXVAivctOHRCf560Wb1XNUXGNZNUz4/m4p5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314414; c=relaxed/simple;
	bh=GYjUqhszS3swcwjAEPJdrrXBYmevNdJdrAAlS+FqipE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVBxtLoaV4U41rxSZqaLcUIcii3GgjAC+uIBU2wqANNjEgX7+hwlncvbwKqLWXJr6UoQZZmISv9DtWQ6IYIEM5BwyX7bEJHFegm0P4Dyo6llq3NhVaLNwr9w0wO5qH7YoJUnvytf/GVA3Y05+xyOTelToitTpprNtZCo7b77bGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwMsHWfj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b84bfbdfcso36226605ad.0;
        Mon, 07 Oct 2024 08:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314412; x=1728919212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+CcRHljhkUW2TB+IYAsQDB0hc2Y6bfaHqr8n2L7nmA=;
        b=bwMsHWfjixb9QsI7xO7cQAo1Khvm7ZNDrzNTHMO9l+pm8v8tgWVndSlnyF9eqHGVXS
         MirTYRUUQ91Tl8abxSln/8GbbyUTivXwVVorRSpDyTVuhfQTXkSMY4K3MEIKYz9Ixrls
         LzR/3wT4Wi08i2dezwe5Qzs4FeQNCBwxR0xNk1t4dy6xNiYvRQeN652rgUNqEOu4ha+P
         oB3vUF6GIWKnZPjLyEyZ7v/ab+T+el6QBg6tIxWzwGhE7LwGgBnnWboqtg75+ERAkqHq
         rXXnm3zCoeUQmrYZ4Ire+MA+kK6KuhFwC+qRjDXyKJYsZSe3OV0D6bjef8fAac0PtfTR
         /few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314412; x=1728919212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+CcRHljhkUW2TB+IYAsQDB0hc2Y6bfaHqr8n2L7nmA=;
        b=p1/RN7/OvZvF3I+mqsNC/iwb0hl+NM1AkG8M5LYpZW4AJsDgfvtgs4VJlR2plADjZi
         Ys97QAZn3TPFzTDrOtsmeXsYLQpDhU2oahNVKFqeUZVSbaqcifW4ngworCJhi/pXOOJM
         3ZAS1IgmkNnc2tzHttUss6Z4eikBIBATlbZhNXvPgiTfI/0mjPJA/HC+gD7sIi60S9aY
         uJDGupZZJ4+sJt+sGcqc0xW+WU7A5ohcoqEPDYDV+LNSvf16nTvCV047HOrteKjTiBJQ
         EdBxvBPBI8Q0JQAhW4dZS4BUyAsIt6aIbVrSk1rBjgbYPuQVA3wEOjOX117A2OAKdvfk
         ItjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnl/3qrzCtnyPDBqup01Xqg4BZKMdqF/ZzJzaXvpcqlt+Zcl03Es8r3LqpWNlliXoQn06R0M7TwRaJLuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRCs2kOK7ynZN6h2Z+MkQdkKThb2b6NkAtBeAx61UGekfb3rm
	6CX85RlRv/mhinB4OOkWLt9Kk6I4buiwUpa4CaFuTStgv7DcZ+kuRpATLRV66Bs=
X-Google-Smtp-Source: AGHT+IHvcHOjaO6ExECXAdR6XAKyhZjAk5XhkPjBOKYXCx3ERHHOJLLcdn+cQSeMVPBlVcCzbK4S1w==
X-Received: by 2002:a17:902:d50d:b0:205:59b7:69c2 with SMTP id d9443c01a7336-20bff3912e8mr144352295ad.7.1728314411904;
        Mon, 07 Oct 2024 08:20:11 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c138b1395sm41000755ad.3.2024.10.07.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:20:11 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 0/3]
Date: Mon,  7 Oct 2024 20:49:44 +0530
Message-ID: <20241007151947.58828-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for configuring the Sampling frequency
(inter-measurement period) of the sensor. The values should be provided
in milihertz. The default value for the inter-measurement period for
ALS is 10ms or 100000 mHz and for Range is 50ms or 20000 mHz.

The second patch adds support for interrupt based single shot reading.
We registered an irq_handler that fires everytime the data is ready.
And then we read the appropriate value in the `vl6180_measure` routine.

The third patch adds support for continuous mode in the sensor by using
buffers. We enable the sensor's continuous mode in the buffer_postenable
function depending on the `active_scan_mask`.
The continuous mode can be disabled by disabling the buffer.
Added a trigger to the device for the continuous mode. Also validating that
the device uses the internal trigger provided by us.

Changes in v2:
- Fixed `label followed by a declaration is a C23 extension [-Wc23-extensions]`
  by moving the guard(mutex)(&data->lock) above the switch statement.

- The above error was pointed out during testing by kernel-test-robot

Changes in v3:
- Fixed race condition related to `reinit_completion`
- Used `iio_for_each_active_channel` instead of manually accessing `masklength`
- Accepting sampling frequency values in milihertz instead of miliseconds.
- Minor code refactoring.

Thanks,
Abhash Jha

Abhash Jha (3):
  iio: light: vl6180: Add configurable inter-measurement period support
  iio: light: vl6180: Added Interrupt support for single shot access
  iio: light: vl6180: Add support for Continuous Mode

 drivers/iio/light/vl6180.c | 255 ++++++++++++++++++++++++++++++++++---
 1 file changed, 238 insertions(+), 17 deletions(-)

-- 
2.43.0


