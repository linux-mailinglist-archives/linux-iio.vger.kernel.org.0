Return-Path: <linux-iio+bounces-26189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B85C54C33
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 23:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CADB4E0616
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1B2E2EE7;
	Wed, 12 Nov 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeyGCtIp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8302D193F
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988245; cv=none; b=rRzscbkyDVoUEArx761+1hgy2UnLIsfIlwk3OEDFth0iTp28kvawam5EC0txxK2IYwjP6O6NF63Lp7fLo82poDKExc8HVRv6qW6SHzBwKLYY8GxiaH6V2IEuLkwnhx7UhFnS+XJp4DozB3Y9h/uWiMkQ4Lr7uo2B0ExlVaSmfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988245; c=relaxed/simple;
	bh=vGkHHaiy3MOyxLXpItzTUmCw6cPMAJKBLTMBmp9fJvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kam8z3odVFW6huG/a82KxFoKKNihi07wgMMXf3tAoWdo5DpOwU4Z0E/lvJRMWsincmKv35nOcqaegBDcoaB44XxZVnOa9yw3xTTH+T4ewzNYvWbk5bmrIltoq6mJ8sdQ7saQ2GpNtxUrNsu3lm3CYUVJCxlAMt8by58QIhBRAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeyGCtIp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso165933f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 14:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762988242; x=1763593042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XAHcY8QOlmnRNr0WHp8n4Z1UHEJ+UhQLLpBoP3WxWw=;
        b=BeyGCtIpgA3XcAhPQz9KGsqYJNAeHzi6h1fefetCMgNeNyOATyWpFrv+fM7QkM348b
         iYMmaAjIwcRNYNf1Ve9xR6HgQhHkq6DbNSVf4JkKQ3TCWdoX/zS+fVpXkJLnA4nNVrKZ
         Qux0H4jI6jLjbRuE8ZXolNsXo2FvCFJcUdHt7aE5+mwm1VVMAd+YTrqBt+KS9QGwEj5l
         enqcuMQvL5zm+sZVTFyAFsqRakmrNMN2zUhHl+ohBGQrs/Whk4u/HmzqdaeQJkUkQXFv
         Ib0t8FR/HAxCHJzY/j57oKVCY6kDJMMd45x3TO5D8SZ/V+XZAT1wB38bgIVqsBWaW6J2
         sJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988242; x=1763593042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XAHcY8QOlmnRNr0WHp8n4Z1UHEJ+UhQLLpBoP3WxWw=;
        b=GmFotHO5AJ6Sxg/5uD7AWNmGudOKkT6DPsvGukCu4TA460ExCUQ+eFBwQz15+7Avwg
         AMRFwDN4C0+Rg1kBCsMHDjmiGWRipVEH8UMI1ZKIplUHKx1BbdQ/oEoVYRpz2SxLy9cV
         8dMdxKjD7seKm5JeCrwZRC2hLoTQcH5SfwRmjMj7pC3clD+iwC1WTmPR+C7uXRFrfuS3
         laUy1Zozi++SP92y7V/rIDPPp7tFhYfDqLiRRPV0qOHMlfKrcAdVLcEnZZDqHiZK2c1T
         m7IIuijaNYPRKHjBx+pMWsqF4QPm3Ihv/FmITUc0BukmEhz2Mq5r3KRDiVGV/EyeomTo
         C/CQ==
X-Gm-Message-State: AOJu0Yw8fcC/wOaDWDJbyTzJYeGWYkB+rpXpwtlAZ9YMoJOwLdb8j26o
	jR/8NxbsQ5NFKejcj/+m26iBlmNShWeS80FbYmMx5VLfyJBNbhZn87lX
X-Gm-Gg: ASbGncsFDX2vAZHUY6xD8KXK4uwBC8RKGbq9vQw2RFD2OU7x3ElUB2lusjUZIGO3t7n
	6180WzJKqCIemYnc5JOUtF/ZlM0lwVvvkWdZ7JQvRb9l6JnsX//OPetaOAB8z4nG4p+LDvZ2fXX
	HcDPD1ZZ1iS28E/M6RT6r42MUx8bjiHje8/+shaEWy5I+FfMlAR6/hfo4u1+mzY2WiuG2Sw05WQ
	lffo44yGG0aYzFvwBY0/z4FG2Ah9dQCy/CxeWYrqScqSMlFjU8f8cjEDdpDtNPssbzXN8Ac78xX
	cOosGi1Osw8j2fV9FTKwXlhMo5DfqzmmLiEvns+GZYDa82EUOy7wb4yWR/2nGmYC6+MIyowUmzb
	Kl0QFle/8e6tmtHByC+K7r3L7DgEjdxXbD4isiOWgUjMzPb3yCvuA9jvLCnyUiQfGy+w8fDRV
X-Google-Smtp-Source: AGHT+IFXMDCLxFuuc4wUyJhDEvYIta/DJd7NNDT/1TjJrbWKKGa/j3geMAGKKaRYDGMbM1sA9IzI/Q==
X-Received: by 2002:a05:6000:459a:b0:42b:2dfd:5350 with SMTP id ffacd0b85a97d-42b4bdd90e1mr3323681f8f.56.1762988241533;
        Wed, 12 Nov 2025 14:57:21 -0800 (PST)
Received: from localhost.localdomain ([78.209.131.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm236979f8f.17.2025.11.12.14.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:57:21 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 0/3] iio: mpl3115: support for events
Date: Wed, 12 Nov 2025 23:56:58 +0100
Message-Id: <20251112225701.32158-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The mpl3115 device can raise interrupts when a pressure or temperature
threshold is crossed, this patchset adds support for them using IIO's
events interface.

In v4 mostly some minor variable rename changes and a comment in
read_info_raw according to the review in v3.

Kind regards,
Antoni Pokusinski

---
Changes since v3:
(patch 1/3 "use get_unaligned_be24() to retrieve pressure data")
* commit msg: "get_unaligned_be24" -> "get_unaligned_be24()"
* read_info_raw: renamed "tmp[3]" -> "press_be24[3]"
* read_info_raw: added comment at pressure val computation
(patch 2/3 "add threshold support")
* interrupt_handler: added sizeof() in a i2c_read_i2c_block call
* read_thresh: renamed "tmp" -> "press_tgt"
* write_thresh: renamed "tmp" -> "press_tgt"

Changes since v2:
(general)
* added the patch tidying up the pressure data retrieval (u8[3] used)
(patch 2/3 "add threshold support")
* includes: removed unused linux/units.h
* read_thresh: fixed comment formatting
* interrupt_handler: val_press is now u8[3] instead of __be32

Changes since v1:
(general)
* squashed the cleanup patch
* added the patch with the documentation update
(patch 1/2 "add threshold event support")
* patch description: explained changes in locking
* read_event_config: replaced switch with ifs
* read_event_config: return as early as possible, got rid of int_en_mask
* read/write_thresh: pressure: calculation changes to comply with raw ABI
* interrupt_handler: reordered the INT_SRC_* bits in if condition
* read/write_thresh: used sizeof() and values from limits.h
* write_thresh: replaced `u8 tmp[2]` with `__be16 tmp`
* dropped the space between casting `(u8 *) &tmp`


Antoni Pokusinski (3):
  iio: mpl3115: use get_unaligned_be24() to retrieve pressure data
  iio: mpl3115: add threshold events support
  iio: ABI: document pressure event attributes

 Documentation/ABI/testing/sysfs-bus-iio |   2 +
 drivers/iio/pressure/mpl3115.c          | 234 ++++++++++++++++++++++--
 2 files changed, 223 insertions(+), 13 deletions(-)


base-commit: 1d09cf18cc91d29f650ad9811ed4868d9304d6c7
-- 
2.25.1


