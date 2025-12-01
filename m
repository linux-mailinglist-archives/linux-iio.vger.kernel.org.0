Return-Path: <linux-iio+bounces-26581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B08C9685A
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6BB3A143A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E23019D9;
	Mon,  1 Dec 2025 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iJvgpq3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276A1E0DCB
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583226; cv=none; b=tP1SxN6kXVy0kEofuEtBsBtMQ5FEUuvsQz05ostLIjprywya17wSgKL0CynRnGbyf/m0BbkFUDujD2UmCtus9vWx3NmT9Uoea+nroSSrEU0hPdCbM5mYqXSjphEN7ENuNWXvgb7WFpON2FQ7g8FZXzO9/45KTZaZylFqTkqffcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583226; c=relaxed/simple;
	bh=9Q2kCetJBspvXEjVrZNjLnp6UqBrBYcYFATmzPfcsfA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=s/okZ1Ld3LWCh3F3Qs4i/+6mPef3CfDdJfxj478+hpO1BtRgrcJU/WnXv1qWGZiovX5nVDbxhpKLUTPr7rKFPt/EP5P6X2IqTeEQnn78KHPkmfToLL+sOin0eMB2gN3rVNUlRCTSSiQ2IIbC6dWA2grs4cJWd1nZBMsTLlrjonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iJvgpq3C; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b735ce67d1dso659879566b.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583222; x=1765188022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3EOy5/Vs1lxCsDjXUXvZcQx7XzjV6m4h4yl0RiepsOI=;
        b=iJvgpq3C7nnW5dfrEUbzJv/RLcuVNG8QthS5+jWRqlF/niXcnYFH7bQCh1xecZMo6s
         ihRzUBjwY7OrrO2f3qeCXpjyAyJswpm3ujZKriIjlO16TkGoNhv/tHF4YHV8BM4bTQ6B
         i59obk1ecGYy2XJpqUza4fPYn1fZTNjs16WOjY92HrDhbS7TifONfXMye37jm35ycIGs
         lcfjPsYJh3ligkqbDPM6D2YKIyzJomUL14Mi7ebyH65nYFjwcifHOby1gLK+egND/v52
         flO5cIq5Iz9bauoPgBvQsWY4ZvnXKAl7Y0DllPss7psFTTg4rZUG2NzGQpVf5809+7dq
         LAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583222; x=1765188022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EOy5/Vs1lxCsDjXUXvZcQx7XzjV6m4h4yl0RiepsOI=;
        b=wHSyoxR5DdKkZMkcwhq9QWz84uOKrBin+/sF+/DpUM4ojLtlLfeP5vvj0iUnJ/HMQs
         ZqLvhOKKVqdHSSSoXSEqlF9MK6bk8ogVdLc12J3SkTAXcqlrwHLu6CCPxfiQa4ejvnYn
         VpcvpSLuMpPdcc/c1jnGhkcQ482L4J0Or1yPbS1jlmpdYgfeOYArvSroPgeOTsblmQ6b
         OchOlzhdxK8fOP96pUWlv+kEOfFihdJdACghiTk97TUiN5PWiDLi1x6GzUG6vRxX5U9l
         vov2NqlEDt/InTLNPRfS3sr8vu3oGZtIpItO8I5H528WodS1L6tCuIkUf7ItdtIJjzRt
         WJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpadcu1RofMFvcrAsm9Y4xbYbB6Geb5gjeu4i+/dUZnk6StE0U+AzOhjuPAGS0fbYJsrDsa/fBPIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8+Pnelny4GkuWihjHNhCz24Lh4fVh+c8ZDHuoZdxLOB136ps
	pLEzar+OgGmJb4+YWDbV0wR49Hf+DnaMzXSvCli5DDYgwYvrXvh1yhLHS1fPDap4yNb0wmsjowT
	sFQt6
X-Gm-Gg: ASbGncvEH8BnI9F2qv5D1Fd2QI4Z4gwz5ZjQAVExF5r84BQQGzvjyOO5/qIBfhiODY9
	tU7+UHyvo/zA6FDgn0AFx+p0p6qpuwh5dsLBKG+YatZHWK/RcR/lKP0ylPu5NBeTimYXn6IQwMy
	gEty0DLMj4QZSLEksif59wru7XAN3k1WGnaGH7McbqT6UEKZjd9m83LiD4EAAmbGkXx8gFHaJEt
	DktbcF7UL+9CUfIwpwcA3HItaZxFIK8KmrE/bMJiRWoIgQRjgpIhDGwowQxWmESLji/NTjn6FSk
	1iRg5Mo05UbtV4x7fJrqB1ghuVGKhGEhe3J2RPlcjN5jmqiWI9BtCePffGnwbya3T/bv0PSrEFW
	EpfY68iv9PptbUZL+yMYSQt05IzG1GZ0QhniaxYQyM1OnVcSQRzG/p9Gp
X-Google-Smtp-Source: AGHT+IE8NA7QQWwTh1aXf6jzSsKy5HNJTQSxLoVpgErH0gR/cugKZVg4bGIpSkGpvSkKDaz4WK6pEA==
X-Received: by 2002:a17:907:6d10:b0:b77:1964:1881 with SMTP id a640c23a62f3a-b7719642737mr1210853066b.58.1764583222212;
        Mon, 01 Dec 2025 02:00:22 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a265d4sm1175348066b.60.2025.12.01.02.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:21 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] st_lsm6dsx: add tap event detection
Date: Mon,  1 Dec 2025 11:00:09 +0100
Message-Id: <20251201100018.426749-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645; i=flavra@baylibre.com; h=from:subject; bh=9Q2kCetJBspvXEjVrZNjLnp6UqBrBYcYFATmzPfcsfA=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWbxaR7WOMFd8J5PF/JeNwBaKCgXQO6kw+r/I rnNDLrdBE6JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m8QAKCRDt8TtzzpQ2 X4lgC/0aqsJEf9WJar3L7LNM5eUo2x8Aa542hnfBARPckweJogg3ua2l7rHbwai6B9oSjlAru8A dX78G6Gfe0lhSmrMypLzRHJgHUMDlYutHNslIgbUFfAH45dPKQdBHZi60CiM4WmiSmkOhoXvzi4 ezo8CfmbrLfFW3iXaI/dq2hipwmJ2/KVs2I9VPGxZxn2vdfM395qoqoDikX0cL7BcidNpwvVQkd mCHBlo5fWWgboeb9z19JVOk/nPjWZktvIytpnTkceygr6Y6bcIjndPxNAlfvmU6S2y7ANzLsrt7 EvSwAP4hHU2QBkOiRKc9XaAHaA/3ppCo9aoJLpEyhSZMi1Y//gJPkSx2XKl6SfXwoSL3pqvS/1G 4dw5u0nANBWC4NMW6O3rNNtqOzIWm47arR7JFG647n1h73pOYWIKVq+7ohy2CZbwkEwbLtUIRCT PItm1h7GAN+f8BjD+vlDrUHhh6RYGP/IoElyeb91g2EJTEIGjHnDirRHU5eAiFnoQo9Ks=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The bulk of this patch set consists of reworking the existing code for
event detection (which supports IIO_EV_TYPE_THRESH events only) in order to
make it generic to accommodate different event types. Actual support for
tap events is implemented in the last patch.
Tested on LSMDSV16X.

Changes from v3 [3]:
- replaced double negation with single negation in 
  st_lsm6dsx_event_setup() (Andy)

Changes from v2 [2]:
- replaced status_reg and status_mask in struct st_lsm6dsx_event_src with a
  struct st_lsm6dsx_reg field (Lorenzo)
- dropped new local variables in favor of directly using fields of existing
  struct variables (Lorenzo)
- added blank line after return statements (Lorenzo)
- added Andy's Reviewed-by tag to patches 1-6,8-9
- added Lorenzo's Acked-by tag to patches 1-3,6,9

Changes from v1 [1]:
- added Fixes tag to patch 1/9 (Andy, Lorenzo)
- added st_lsm6dsx_field_get() temporary macro, to be removed once the
  generic FIELD_GET() macro lands (Andy)
- refactored st_lsm6dsx_write_event_config() with the addition of two
  helper functions st_lsm6dsx_check_other_events() and
  st_lsm6dsx_events_enable() (Andy)
- replaced dynamic allocation of iio_chan_spec and iio_event_spec arrays
  with the addition of new static arrays (Jonathan)
- changed line wrapping to 80 characters (Lorenzo, Andy)
- changed line wrapping for commit messages to 75 characters (Jonathan)
- added comments to st_lsm6dsx_event_setup() and st_lsm6dsx_get_event_reg()
  (Andy)
- miscellaneous stylistic changes (Andy)

[1] https://lore.kernel.org/linux-iio/20251030072752.349633-1-flavra@baylibre.com/T/
[2] https://lore.kernel.org/linux-iio/20251120082615.3263892-1-flavra@baylibre.com/T/
[3] https://lore.kernel.org/linux-iio/20251125202307.4033346-1-flavra@baylibre.com/T/

Francesco Lavra (9):
  iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event
    detection
  iio: imu: st_lsm6dsx: make event_settings more generic
  iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
  iio: imu: st_lsm6dsx: rework code to check for enabled events
  iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
  iio: imu: st_lsm6dsx: make event management functions generic
  iio: imu: st_lsm6dsx: add event configurability on a per axis basis
  iio: imu: st_lsm6dsx: add event spec parameter to iio_chan_spec
    initializer
  iio: imu: st_lsm6dsx: add tap event detection

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  56 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 538 +++++++++++++------
 2 files changed, 395 insertions(+), 199 deletions(-)

-- 
2.39.5


