Return-Path: <linux-iio+bounces-24668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785DBB4E7E
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32351759B2
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 18:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8082797AF;
	Thu,  2 Oct 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFPiZffk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE52798F0
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430506; cv=none; b=T9c6sm052QM/8D+yKs1Ole9QonbhZvsfrZkvAuSH/i2d018HZxeIp39Ay6QaH4rlNguHFrzmkkrs9ibHr67l2LiNiVJ/DczygehlufVRKtnx8iUqCUP5YmVHo8QKXe26I5DkcKIzkt5JcMmPgrY1iGRLf8nX1eycxKCIpE5jAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430506; c=relaxed/simple;
	bh=YWSdL9iHyEd726JhNHD7MN51UkV7bajCdSoTr99QOdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoauKQH/NoO5NZz/tS/pFGEkNmueAeHbnODYWN49V0R93430oMv3R4N+VJx//D71i+DQU6eBhjFkxE7/IDxfrlrrtt5SiXzHPg7dQQ4SamZDz4l/G63fsBHkK3OECZ50YybfXuRX1rJe1DY1lKFU/NOG5Sh5LgmsoVltqTsijHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFPiZffk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7811fa91774so1204280b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430504; x=1760035304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjJJ9Gi6XfvKg9Dd6D3t2op0cLjNPAyn06zdnW6N1oE=;
        b=VFPiZffkpl6W0wFmoaZW02UPqNEN2U2eFQjexbs4lPO82d47uOkJUqwXWU8Bybx49i
         OP2lidqGyrjQ8PbDixDP/nYW17fsnbW/TXTYRINIR9sDeVtSEGHEbHKaXBs7OFVUbGxO
         oeT9HG/MIfpqv//JkFt9qDmHZ3O1oLDiwNG/y5yRvW3BRA8dhoDnj0s8IgaBd7WMSpAm
         YauwT8ya/TD50XVMLJou+Ht+umrF2qybqbyayHRoCYELIrEUB54p3wLvmRfwIJO1kSAZ
         MHgwLMC4114vWAeAVO6RA8oPeetRgFF8l49KOISkbm8V53aE0+qFGk+hpcWerYuPFIZc
         xmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430504; x=1760035304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjJJ9Gi6XfvKg9Dd6D3t2op0cLjNPAyn06zdnW6N1oE=;
        b=PSit1J02bacgfAoPXNfx9MxtDOvLWI74vaI9vhqAcsKhk0Gg43C6PLUKMOGqvEZMCm
         rJZ+dGXxJjAytIODKi+aUAUYBXscTpUY1pMDT4+a5IbnxxIpeqhAZYJ7fLbFOt60E8+n
         iqkh8ERbW3In8VyPP1z7zJ7djDhEZhYKFltNAtwag8ZBeLsHTlM99cPVJm6CoMAPMRl2
         MUWuDju/jLwuPyIiRfHmp+LQSGIUW1PC0ylto/QXVXB8NrIv8DYUKuSvzfw/TWHYK3li
         RIktKCfDS7VKS0jHKBaNQDsigs930V5Rjv1HS78WiFFlneXaZfKuRBIIoD2zShirwAAz
         /6FA==
X-Forwarded-Encrypted: i=1; AJvYcCXXelig63azy1ask6l483AdTGj0X2ea+4IcHBuGnjiCuTBtHstuyR3DibTHI3vNkf/C55IBIUOg4Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbeSCb4Z4ZMt4T5oJjYKY7jaBijFSfrJDJfD/aFVbIV6AFS0k
	yBWq3K5bbGwEoEzHzJ5C2zmU87MOYRMe2EfkcITa/nIzQsNnDmcSVnfO
X-Gm-Gg: ASbGncvCmhf+tcQWWAq8dnUr5gpIbJcIJUz+qbTLO8ugpOZvCY5TBQyEqShEmyv9rMo
	LqR32zi3C/Hyz+Dri0hw1rSweturDeX+T5paQcOkSjduZgvP3Eka4bJIJzCXROr3RHrSzG4GmDa
	Y/cnLOocuUBYxszQghUYhmJ+JeQ5ykwChhwvp1gswin/GKpNgpwVGKMvWdIZGpy+Xd6kFFBFf9k
	WgddmFKFsfIS3pLbpZdnmS76qYLAEQjkAnlV74g+LZAYEZEP/BrFX3GxN1+WxijK70U+HahNvwb
	PEuPNUhLnrlqLoKeNwJ2oYyDyY3CxaiBTz/Axtcu0sJ18r2DGBX9mhNL3T5np1SLMxv9RWZ96EO
	X01lm/gTuyFyHEwpnrrTwTNLsdYZF7ucyTpRxjumeV8/DWsrrOFexfFEd
X-Google-Smtp-Source: AGHT+IGJdOUCo0q60wBqDv3QWu8P+anIHYeha8r7eEuxjSZYKXHFbGJVgkqXh7CMKVbMXH/oLFbqXQ==
X-Received: by 2002:a05:6a20:2584:b0:2ff:3752:8377 with SMTP id adf61e73a8af0-32b6212c522mr504856637.59.1759430503914;
        Thu, 02 Oct 2025 11:41:43 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:41:43 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] iio: accel: bma400: Refactor GENINTR config and register macros
Date: Fri,  3 Oct 2025 00:11:01 +0530
Message-ID: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the BMA400 driver with a focus on generic interrupt
configuration and related register usage. The main changes reduce
usage of hard-coded values by introducing macros and formula-based
register addressing, and add a centralized lookup indexed on iio event
direction.

Alongside these updates, the series also reorganizes and renames register
and field macros for consistency with the datasheet, and extends comments
for additional clarity.

All patches are pure refactoring. No functional changes are intended.

Akshay Jindal (5):
  iio: accel: bma400: Reorganize and rename register and field macros
  iio: accel: bma400: Use macros for generic event configuration values
  iio: accel: bma400: Use index-based register addressing and lookup
  iio: accel: bma400: Rename activity_event_en() to generic_event_en()
  iio: accel: bma400: Add detail to comments in GEN INTR configuration

Changes since v2:
- Split single patch into five smaller patches as suggested
- Addressed review comments related to trailing comma [Patch 2/5]
- Extended renaming of macros to TAP_CONFIG registers [Patch 1/5]
- Addressed review comment received regarding write then replace in
  activity_event_en() [Patch 3/5]

Testing Summary:
- Tested on raspberrypi 4b and 7-semi bma400 sensor breakout board.
- Since no functional impact is there, so before functionality is
  expected to be equal to after change functionality.
- Tested mapping of GEN1 and GEN2 both on INT1 pin as before.
- Tested both activity and inactivity detection by setting attributes
  events/in_accel_mag_falling_en as well as events/in_accel_mag_rising_en.
- Did read and writes on various attributes such that write_event_config(),
  write_event_value() and read_event_value() callbacks are triggered.

 drivers/iio/accel/bma400.h      | 151 ++++++++------
 drivers/iio/accel/bma400_core.c | 345 ++++++++++++++++++--------------
 2 files changed, 286 insertions(+), 210 deletions(-)

-- 
2.43.0


