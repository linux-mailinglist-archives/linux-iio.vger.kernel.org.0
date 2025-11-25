Return-Path: <linux-iio+bounces-26462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ACAC87027
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2F7634DB49
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A633AD80;
	Tue, 25 Nov 2025 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NfLKCRYw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88712BD590
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102192; cv=none; b=SgA1A3bq1i9ftR8FzXAxfkXni+WhtaaPXxJD8uy6j9NI/ab/sqtvAVitYFLy1YwysXMMph8XZuqsucy1+100YGI8dfdOI4Yesva9MaOh+YD+0oL0v3W0wWSBr6W2WZmHs4fxw+CBWHtUjKZe0NrV6NuTBIv7wH5tGGl7CiIS33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102192; c=relaxed/simple;
	bh=NeqCVQGg5qT1aYQwYOfhby3FJklWkiVsbk0k6PcqOjU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CjCfyougEay+m5RBDLOtFNjsQH6YBkVVLynIdKNEuE5yVEWvvdxCq0ITxDBbY6xfe7wkytJsqbK3vIhTeJC3r1nOac+RLs+qkn0nMg8G9cu97JSEBtCjzCgUU2lr/Pms7x4x1UbnjhA3ZEjb4TUkyQ3mjCH8QO0fX0B2yLIpdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NfLKCRYw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so8366870a12.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102189; x=1764706989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DFe0G2+EmVdbEh2bmdGGxP4y2UuZO0CW3KK/wYTXjeY=;
        b=NfLKCRYwAWIE7u6ImKQU8NHc0bH/Bmog3ivduKIoXMDZFVYxWtlBdZLL1QKp72IoWJ
         O7XoGYJppKD7ZYCB3wzfXxFJFlqdH3XqweSK+iC5dMY2ggO6RC6iPl46HQ91BYjqUU0R
         v4VqxAudhIiZQCtMzNpqlN4Iwb0i499dI7uS1rJ1eKoQURAx6T75h7zJ40TMWt0CJD2R
         4RoTY/qEeGuFJZTOvcGYF4oWaScpmmXgjiPXFkCcmvwnyXU0D5qunkJX4PPE+Xc+ZcX0
         gz1xJOfNfSxA4Gk32zznM4yym1nJDeY4zf5piY3j5ZZBczm1FxRGBOpm6O09ASj5eTZX
         maBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102189; x=1764706989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFe0G2+EmVdbEh2bmdGGxP4y2UuZO0CW3KK/wYTXjeY=;
        b=KMBJvSLjW+Nuy9lZLYiQKVxwEPqfAav2LlefS3mnqmCqCZtPfYNcWXSpaQzD699MpQ
         Q55XQARaJrEWVvoxG74d0IOGFNbaeSFN7vqVRMeWG4oHUuqhnBgoxJZkOPPCXXdSvxeY
         9fE3DRnd9oAsSaoUaAyXR2FfgQpfZbHp/YHlLy69qU1TFmjzJ8q5jYEIPwiiBbqHKGJc
         olhwZgDEYrCxHSH0f+wyDju+tJ/OsJ2lSTtsDKW8DzD/im8DPaOK7FPiHx8DRvziLZq3
         EH7wKqSMOlfuVpTzaGhBGWdLaukd/lXujfB+rw2NkXf4dTgxkv5OTmysQEEWUBveUrdR
         v/+A==
X-Forwarded-Encrypted: i=1; AJvYcCXIrwL1DM21M4/s+/tJyVE+j23B6mGLheaJWRvFb8wjqfuJ5akp3HTs4W6k26zuIMVxuQVCIoWLCzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hg9Oz6JJNgoh9nTjx0w/p0UYhi6024nnwotXnuezzY8OG859
	78kckuuX95Jrz1M542is5bExXj8Tx2HX098l+2ZzpSMoMx8MNbiy3MFkRpAN5pgZ+8i+R26EVC2
	HKYAp
X-Gm-Gg: ASbGncvvWqcu/rYImwK1JczHoQXvWZCioO7H/GapOANOGwF5fuBzokS+f7/f2OMaxtW
	L4P/WSDM+DDgzouWqmsWx7U+b0CyGRMpkpsq9n7IbIJb1ivTCw+MyU/zOnZBOCji0ZMAq82vxeM
	lDVzv25+sJJEyuWgx76M/yQFR+Ru90dmwA66qBz/kImmM6/qlttNY06Z4s2hiOnmYLZi4IfGN/Z
	iHjPqgRGiar/+NVAQDqCsS+ixE5veAXivh53wbXMGhg5jlHhuP/fUjH9/4KPm403ol9V9L4XXsl
	u/0csrxPKnYqB+HeQpWt3EcMB30AbO5NGoOY2CSivXFBu4oegoYMqovr8p50av9heTJG9wBEr1n
	ustyhenhPEX18p+ZGHfNAQkpsEh726f/ed4rwco/mE/BF3bzM4nTYmNZH1H2UMLfGlMte3OLsJe
	MwfQ==
X-Google-Smtp-Source: AGHT+IF/z+2yeKjjDxF07ijR874tTzM0h2cLI9XrL/kaOfCtNyB3kX9BvQH3+Op7yW527F5YMffdEw==
X-Received: by 2002:a17:907:7248:b0:b76:23b0:7d6f with SMTP id a640c23a62f3a-b76718cef3amr1688216866b.56.1764102189036;
        Tue, 25 Nov 2025 12:23:09 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd60csm1677336566b.3.2025.11.25.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:08 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] st_lsm6dsx: add tap event detection
Date: Tue, 25 Nov 2025 21:22:58 +0100
Message-Id: <20251125202307.4033346-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2446; i=flavra@baylibre.com; h=from:subject; bh=NeqCVQGg5qT1aYQwYOfhby3FJklWkiVsbk0k6PcqOjU=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJg/9P/TX+7ynskpYl5KRVi1zx/MmtHcGM5b2y QVMDTfx+xmJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYP/QAKCRDt8TtzzpQ2 X1oCC/9ayrymZybUS8mTvGSveFbD5Z8zyvGAotHNY9rA55ek5/Q8rPj/uiq5DoeVlI7nG7L2oOC kJFNmK5fBreIepGFPdTnSf+fvFb9ZK8SiZTtssrKfXgomdZssYjixw3ZLACF9KawOXgEBcNZWOt 0W28viOptiK0a0NvdtVGqr+IUVNb+UnzpZRILd/sOlemnhVOyMt+BsO48NaDnj5h3sxpShxQJcE uVOoH3I/z6+jS20WYJFy67S4Dg48Iyrek5/4rQULdaA6mU40RX2cD6FjOlL8raZyofACQ1pllDL VxAmMgjBCWsbO3wK/twILmNrXfTm+SciTHaoaPvtC9A76Ygbb7psQVG7WzpZpXC3rFe1bddtR6x 1zjczluwrAPcieEGs4PsPkwqf167VxAyszahtz0ut3+YqPBkOx50lNvpt89ScF+0OCd/ZCCYQOd xAHftApGpNcTifMCVX+oqhTfvLZ3dUPTLNa46tD6F8vSvAmbI003YwxJvXlEJojThxRcA=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The bulk of this patch set consists of reworking the existing code for
event detection (which supports IIO_EV_TYPE_THRESH events only) in order to
make it generic to accommodate different event types. Actual support for
tap events is implemented in the last patch.
Tested on LSMDSV16X.

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


