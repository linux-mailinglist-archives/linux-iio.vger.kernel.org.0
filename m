Return-Path: <linux-iio+bounces-27352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDB3CDD93D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Dec 2025 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8EB30194DA
	for <lists+linux-iio@lfdr.de>; Thu, 25 Dec 2025 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959513195F4;
	Thu, 25 Dec 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKMWslUl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB13195E0
	for <linux-iio@vger.kernel.org>; Thu, 25 Dec 2025 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766654752; cv=none; b=N4TJVjXAadisJQnXmHpnxw9XD4Y4DClQIwgc2yLi1nXxuZnvmQFWS5+CX7XwhcpJT3bqqfKVl6qv6iqEbAxvBblEnJ1lfo5AuDzxYKVS8YotBdh/f9Q8KxyRW2jUrwZpAytDF54/rj/BCDMrx4Lbqf4XHFrLz6HACemfb39/KOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766654752; c=relaxed/simple;
	bh=lpb9/3DK7ALY+1M/QPt26J7EyO42orqOgUYOaDKIbU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVWtorObO1C+G1j414++ElzQM9FKa5wpOfWosFPBAaS+idRF04cRNItSUfhqpxGaGrqu7dAZD8ESoKMEHHZtmjJUT6hvaayf/qvDBuTOk1M2Qs41hKdeiCYFnRuXPeOnIFbtZQVBEsOpjqqtmG7jACcS3roSDDvDNt6pM9Ou4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKMWslUl; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0c09bb78cso47197525ad.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Dec 2025 01:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766654750; x=1767259550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJdCkCbfYuG1MRzNXkV+YupMxNU5tXNQgZDynoVb6bo=;
        b=YKMWslUl9hTU0VHjNySSPA9pzIAVfChv5OfgPrQYuXjLsLr621sCK8CZ+X8gUDA8D9
         e82E3Qblf+WlQokg72mkoSB7km6XRYEkgmVYOqXAaIAAmxxDSJOyCL10TQ469YWzDnHj
         +/ZHjgiwJTX8PH4d14x4mSjHzn00NV8pnFUqEAttvhCEWAAUbsQ5nT4UkBUsbhUGOeQB
         XSpCNtVQinCcJMT/PS/dES+l0YTrxVMXnRA5V0JTaLtAhWuwftbiLjcfpMiP7b+aQd36
         iivw9DyTOdON4YOhUzJu/Mppjq7EVvTbgQhK887T423WyfrN9Tr/PGxCLF76Z/XVfcIQ
         mbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766654750; x=1767259550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJdCkCbfYuG1MRzNXkV+YupMxNU5tXNQgZDynoVb6bo=;
        b=bsuy8/l4NXB9LxLhcOgdz3pZXnQGm5yf/u8yxZXpF1+supIGt1kBq+0cYzD/iyo27r
         /hOhpTWowJnnQYOucG26wEVnCwhJFA4gBA2IOtnGLOUE09v66go7yn4dUi6GtAjGMwGG
         yPDIGGbUO0Yvj0w7wpJteMyBPr4GjvxYaXrJZ456THhZZzOHQg4z4Dy3asKp096yd/wA
         QcFsq55t+V+6qqlVIF4xZ3kKs7PAxAvvbKlRxbUme5rFO+YEaAE7qYbItZLrIc1mm8fz
         iiTSc6YdmHWpc1ECJlZtU3p253rsIVd/+A6zJdqP/QITti1Fnx4MuvTmWsFzfkClIu1u
         99Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWACGDHMx6pOsBFxciRrcx3gz5f0urVPoYKoveFWMNfkYMYfcPyIm7qvecnczSIQjnKEf7IOZ6q5LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU13ELC04P6rjE4w2cGyLBZF1gZ341R9hqLd8o1A9/5dqWGS92
	XEpXTk/W7Mm+ZmJTeBQkCuEili9WD2WDtnFkcDQE/BKn2i6B36IeKpSW
X-Gm-Gg: AY/fxX7qnT0xQS7glhhZg3QB0yYxCzn6BV3fGFnUHCxx4y7Pb3/E4ETHnTfTUt2uAoT
	KSnHPjgmv8OZbXq3JHZGmkLUBwx+KjFq6U0i4SuM8amo1WO5mzOiaetKeImwa30Wn1g+4tDWBnc
	RsKRRy0XJ8XOotUZ7hZBueuMEp7Cr5CtkQJNRQz9XKQqFMhtrIjldCxzEqhvFx0Tk1VnwsMg1AB
	eENWkEDyITi5GnUQ6iBZcLOlUojA5C68oObbUdfuJSgav9SCn8WhbyCCa+9awhmOxv0953LN12L
	bD9Aumi7dg5WIdTsDiYXrAPFZuQtmx+UrfDOe0r7dne4q09FbfMRKxInksmuJOAWOBrVaN5pDaz
	cVdGh2O5l3+Yd9N73AHKWcwu1VYRAvRxgg+yaTeq9AKOXFFs/4GCd9w9mPqrq1ZK6rz2pPxzNnN
	d3k9BVIaNMvx9yUQ==
X-Google-Smtp-Source: AGHT+IEgGuutywGEcx7A6zRarRYg29s1/vlspKVocesMq7EEjWyY7y18FGpFz7WOtxAgfWf2sx2Xlg==
X-Received: by 2002:a17:902:e78c:b0:2a0:d0ae:454d with SMTP id d9443c01a7336-2a2cab4335fmr203328535ad.22.1766654750230;
        Thu, 25 Dec 2025 01:25:50 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7736fsm178970115ad.92.2025.12.25.01.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 01:25:49 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v3 0/4] iio: proximity: Add interrupt support for RFD77402
Date: Thu, 25 Dec 2025 14:55:07 +0530
Message-ID: <20251225092511.9020-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds:
 - Add RF Digital vendor prefix
 - YAML binding for RFD77402
 - Add OF device ID for enumeration via DT
 - Use kernel helper for result polling
 - Interrupt handling support
 
These changes enable DT-based configuration and event-driven
operation for the RFD77402 Time-of-Flight sensor.

Changelog:
Changes since v2:
- Add 'Reviewed-by' tag to dt-binding patch.
- Update commit message in OF device ID patch.
- Update commit message in the third patch.
- Replace rfd77402_result_polling() with read_poll_timeout().
- Add 'struct rfd77402_data' details in kernel-doc format.
- Arrange includes in order.
- Add comment for completion timeout value.
- Remove blank lines.
- Indent the comments to code.
- Convert mutex_init() to devm_mutex_init().
- Remove 'IRQF_TRIGGER_FALLING' flag from devm_request_threaded_irq().
- Drop the duplicate message.
- Replace 'dev_info' with 'dev_dbg()'.
- Update 'dev_id' to 'pdata' in rfd77402_interrupt_handler().
- Drop 'interrupt mode' comment
- Use 'if(ret)' instead of 'if(ret < 0) for consistency.
- Use 'return i2c_smbus_write_byte_data()' in 'rfd77402_config_irq'.

Shrikant Raskar (4):
  dt-bindings: iio: proximity: Add RF Digital RFD77402 ToF sensor
  iio: proximity: rfd77402: Add OF device ID for enumeration via DT
  iio: proximity: rfd77402: Use kernel helper for result polling
  iio: proximity: rfd77402: Add interrupt handling support

 .../iio/proximity/rfdigital,rfd77402.yaml     |  53 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/rfd77402.c              | 149 +++++++++++++++---
 3 files changed, 183 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml


base-commit: d8ba32c5a460837a5f0b9619dac99fafb6faef07
-- 
2.43.0


