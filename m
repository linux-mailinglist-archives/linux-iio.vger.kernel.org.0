Return-Path: <linux-iio+bounces-27423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A3CEA9DB
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 21:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10BE4300986F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 20:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752D270ED2;
	Tue, 30 Dec 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQoyASGb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0111C4A24
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126926; cv=none; b=tii0x4oTCFhklfTHw8pkPEp0RKWxnAA9GgJ6aph7wW+kv2rGlHokkJvlPyKOYHWX8jKvnq2E7oZkzJ2Kl9l/KagVMIU2CNf4L6yBrMIGxL45ZLcO4MHFh02cuG+LxX7ltLSc/fXTBI+XO6GgWpYiPGkMoFkgcj+8EDKxQUiLwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126926; c=relaxed/simple;
	bh=CbItiog4aTyaR66/Bi0CyZs2xrK8CcY9DaAkws1e7Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pE1sL0qyXr2/HrcDgBFWBomzku4Err4L0DpdTnb64joOQ5UvL8sZZmF/XaNaD/P3VDF2jDq5CmAuxaqmFv7vo+DwHktO6Cj4uDvi7oRVaYyArCpJi1m2K50LxuPYsiEQsBeR3MgXrwrIpLG4g5zMM/YHBpKexpN+sH3qHVNYnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQoyASGb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d52768ccso128298165ad.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767126924; x=1767731724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2rBxETRpqLD6kWS1oH6536/f0tgd7mu7KA/9ELTSvE=;
        b=SQoyASGbK+r+gP8nf2PkfaiWsjXpnAEKqxMXfSQqfFEk+uUceCbGHjAoxyCukDJsFn
         0VjQsPMUpA1s4sLrwXhyiK2vNIGe22F3/EMe9P9/10yLt/4TcDGZXP7neHiW6dveRixc
         TT6LGJSIm1TvVT8dYSn/b/NO5tChfOzDebG4eRkr56t89GkV5tQxD1Bc2/CrOLxAyNc8
         nNbrjrZ/c1BCxlXBSA7n9IQcotdtgj1WrtID0XABHJFEonvTSs8NaN/GhykEyJM9PcAe
         /0T7BUzE1JsR+S0MSd1zpxqxmtEBg9e4ZaleYg16y6FesWgodMNG3BO1Bzh+zztwUo+9
         2w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767126924; x=1767731724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2rBxETRpqLD6kWS1oH6536/f0tgd7mu7KA/9ELTSvE=;
        b=VDH34GGDSeX8wrkN/XRsWVm7rXgxlfjIZlCYF8d+gXYRkhISDUgNrHwxDLwmOirQpE
         jiakZsq/Zm2eBkmy7c4/M14qieBZzVz+dvAChJfSm+F8Hwa9yTvfNMHhK94jzD0LkG0a
         H7mvZ97f43ZwQuqRFRDZ2vCDST8fjzsIcT+4X2x6szueGm+sNy71pKQ+pfOxvgPqu7Iv
         F9sxpMBQaBJ91UQs9yemh1C2EpEfvop4B0mqNR07lu3qY3/JySlEDKqn35HSIO7D8jn5
         rYOiOlXBFnnrA/RP1QTXWCU8i3NqSfNsLLGuyxGpNgZ4ptlrhGBQF96ibUb8DGCMKoBt
         HHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtvdBwm+DdDtMgTBF2tFy380RXtnVMrH0jvoafPd6JJRbgAS/Oqty9XKVPdEx8/QQK0zN1GiqNo4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpzV58u8bdgTjTKJg5SQWTxkjy2CxjLsy5aBbeEUN7gZsIv8ay
	RnmhlogTe4tr8yNhcnlRurMzEVI3ksH/Zr5stQFfFRI9QpgcgeIERnAr
X-Gm-Gg: AY/fxX6iJMxyGmZbBYfJVqa3QjPdabXiXJsblXm7XZI0o7m/esbg0XjFYnB+H9xogfG
	V3xtQf+Uuom0yAJorHk5lKf8FlJMg0PKSg8tWCS6Dc0kDNFr9JDFWhyorG5JptrjSNtx04Meh93
	xk9dsGaj/Og0EfDQUOU0JRscKp7alwpl+6yzC9c/4CouW/h+PJRrrtBqCInkS1RwglTtgqXUgbe
	7T0TWmwou261fGeoTbT3AYvyeMAvVbSgncKLgjXMFuJcxlXRLSVZ3+2OlZyxu7sMHH2aKvm/E2P
	43GuBXiSvuFRFhghpnGcSm168hsMIdlm4r6j0w24WtPjnppoc5uVtRu6MRtu0EAM/rEmTJ140Ee
	87MscjAjx5A4ul+5cVteMWsU8TgH/pripobLCTZE4o1dIKKJEvUqRCasT8xOh3FtJ61VT1/WHMA
	uiqgLW+0PF3utiJ3c/U/Km6kKm46JbqaeOK8MERaR31OJoFgR0L77vxprX0BkOP8Hub5IHkpUf8
	qPVv/Q7lE9m+aImyBOiL+BxMZe2NQTzX/IYcWGymGH6gUE4Pqs8/kAJ1cCW9CtjVo4pZNAM
X-Google-Smtp-Source: AGHT+IEGL2XYMAsNK4VpRBoc9NwepNxFvNhHj/SDESLAKzn3GV8wgXPvi4ENCyD+EXPUrxmAHJzigw==
X-Received: by 2002:a05:7022:7e87:b0:11b:9386:8261 with SMTP id a92af1059eb24-1217231479emr30088641c88.46.1767126924010;
        Tue, 30 Dec 2025 12:35:24 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm128074981c88.9.2025.12.30.12.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 12:35:23 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH v2 0/6] staging: ad9832: driver cleanup
Date: Tue, 30 Dec 2025 17:34:53 -0300
Message-ID: <20251230203459.28935-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the ad9832 driver with the goal of (eventually)
graduating it from staging. The main change is converting custom sysfs
attributes to IIO channel interface and adding sysfs documentation.

Changes since v1:
  - Reordered patches: moved dev_err_probe cleanup before guard(mutex)
    conversion (Marcelo)
  - Split channel conversion into two patches: 
      - dds.h removal
      - channel interface conversion (ABI change) (Jonathan)
  - Added devm_mutex_init() conversion as separate patch (Marcelo)
  - Used MICRO macro for phase calculations instead of hardcoded values
    for better readability (Marcelo)
  - Fixed FIELD_PREP usage in pinctrl_en for consistency (Marcelo)
  - Renamed ext_info macro parameter from _channel to _select since
    it represents register selection not channel number (Marcelo)
  - Ensured patches apply cleanly on top of IIO testing branch
  - Made sysfs ABI documentation generic using capital letters for
    channel and symbol indices (Marcelo, Jonathan)
  - Changed attribute naming to hierarchical structure 
    (out_altcurrentY_frequency_symbolZ) (Marcelo)
  - Made descriptions hardware-agnostic and removed chip-specific
    implementation details (Jonathan)
  - Renamed documentation file to sysfs-bus-iio-frequency instead of
    chip-specific name (Jonathan)

Tomas Borquez (6):
  staging: iio: ad9832: cleanup dev_err_probe()
  staging: iio: ad9832: convert to guard(mutex)
  staging: iio: ad9832: convert to devm_mutex_init()
  staging: iio: ad9832: remove dds.h dependency
  staging: iio: ad9832: convert to iio channels and ext_info attrs
  staging: iio: ad9832: add sysfs documentation

 .../iio/Documentation/sysfs-bus-iio-frequency |  40 +++
 drivers/staging/iio/frequency/ad9832.c        | 327 +++++++++++++-----
 2 files changed, 279 insertions(+), 88 deletions(-)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-frequency

-- 
2.43.0


