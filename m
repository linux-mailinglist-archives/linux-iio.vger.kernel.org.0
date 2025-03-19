Return-Path: <linux-iio+bounces-17116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DBA69A62
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768728A59CC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB621517B;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgsLD78H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9756A10E0;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=YlJ5QPgBrgj48lDfEznAv1AFRE77boRcdmlJ8sw7VCzo8g07zFzTPdAUY42COO6IAl3VW2N8yvMElRvU7/SaZLGfjAkdlPTALtEU3BrDHNzsiI4aZN1Fkc97olXWP6OlkMi0y6+CMSmpyos2oIi8hKoL8Noy6eS/daPN8t7C+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=8STHuFc23s5ULduJ7aYVu6n8GpJ8UmJn4qmi5rEoGew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FTz5zkaN2aPK3LBQTLc5lW9sS/athDX+/uyYaM58MucIRwKevj/OIduXucnxzuB3MG0A/vrWf1UAY3v4nufb+ywMoNQ6CjERqDVWu0XeXofcIzy9jOrS1VMkWnRigfsz6EHdwEyVQ5/7ugpaX+kI5oOij7CD1WiAjXPeWx+3G+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgsLD78H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ECA5C4CEE4;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=8STHuFc23s5ULduJ7aYVu6n8GpJ8UmJn4qmi5rEoGew=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tgsLD78HEArtyg/ox2BIB8wqjrZv48bVVcVPvbvRDVNikd6OsD1p0qybBV+WlC+52
	 AjV08aplqWcWiw22eXPJDDKrPC6hE1QbunNqFktFf2vfR6d/w10wrS/v8a6Na5JdF5
	 jGFia5NnqKe6rnV/9XCX/7XEH6PT2wm+cl+x0XZZEkwvh8sWVLu3tDzU2FNackJ2wf
	 UfU3hLAcoi55t/p3C6DPlcG1GUGDUY66bcaFZ6OlI6GtAI1Eyqb1XC/CmVzR3NntaV
	 SSWPHgEUERiPO2FAm+abtDKQ1LJ9n5aUCi3uX/QZxgH5MCbiSSiVNoko/p/ncrlGm7
	 mDuaYy0adEDFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0452C35FFA;
	Wed, 19 Mar 2025 20:59:44 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 00/13] iio: light: Modernize al3010 and al3320a codebase
Date: Wed, 19 Mar 2025 21:59:39 +0100
Message-Id: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADsw22cC/32NQQ6CMBBFr0Jm7Zhpm2p15T0Mi1oGmESBtISgp
 He3cgCX7yX//Q0SR+EE12qDyIskGYcC+lBB6P3QMUpTGDRpS4Yc+qchRSgyYuTu5Sck4wJ7c2m
 dbaDspsitrHvzXhfuJc1jfO8Xi/rZf7VFIeHjdNbWWHZamZusMh/DB+qc8xfyIQIDsAAAAA==
X-Change-ID: 20250308-al3010-iio-regmap-038cea39f85d
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=8STHuFc23s5ULduJ7aYVu6n8GpJ8UmJn4qmi5rEoGew=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA9dM2IigZ+WKdbs+x1m9BqHCcuqSmS8yQ45
 k8maostMXyJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPQAKCRBgAj/E00kg
 coxGEAC6OpsSBl0OPAGqFhuQO2RGtAEYNsZKTtBhofN18Xig/hHMPc78pQIC3cDs6IDaYsSxXQC
 eXvjJES2rQL+RzCRlY0BMPmQ0szDlcD+bmspi6CYyRDkDxcSAzL+1nKFHOkfutvf3YjzoLOvS+Y
 sCvky9NZI0zWS0tGxtO5wl3ax8yXrs1tdPlvswpAMiYmg1rY3UMW2bqmaxIJle+b9v/fQnv6neC
 yolZyCjcaJHxmreo0aVJ4z0f6CP47gpgM5OS1zTyMt5xNBfswKLrNkRZsCizG9NVJHFee3TpOL3
 eCXiHBHapm6HoP7UVYxLOW1jR6yUAb9/R9H6OiypB/W1Ot2Q7xGZx1jzFjv1hOPSU5ny1AbvdpI
 uUSbKsouLPDUHJ8GbCW1mY+f0FOI5hJ/XNA6ZBFFCNKZyaxV7MhQ45txevdBNj21ZTiuo1CyzyI
 VNGmXPRYNZZzLht2NFdDaEOFIngomFLsgpc/EV9rsgwbS1SDNV24Ast4fc4ft6mT0A9stH6I4fZ
 9jmsMWzOOt3dmBdMAnzX3T7rGQ07M3rGlDw1kbS1TFUZZjUtCBcvOuFXQoH5x/ssuQ39MESr6fw
 Ry+DB3FxXBGBlt8GfipmAKR79vNgMqNSJ3LoIusNTVQedHv6q9YuHXshNtRcUZc4SO7TnMP4xQA
 s78kdnblK2PnaVw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

This series targetting improved readability of code
and modernizing code to match AL3000a (recently upstreamed).

Except slightly improved error reporting,
there shouldn't be any function changes.

Module  before after
al3010  72 kB  58 kB
al3320a 72 kB  58 kB

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v2:
- Dropped Daniel's email update.
- Dropped DRV_NAME introduction for al3000a
- Added DRV_NAME define removal for al3010 and al3320a.
- Splitted unsigned int conversion into separate patches.
- Replaced generic value with specific raw and gain variable.
- Use dev_err_probe() for error handling.
- Separated devm_add_action_or_reset move from _init back to _probe.
- Dropped copyright update.
- Link to v1: https://lore.kernel.org/r/20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz

---
David Heidelberg (13):
      iio: light: al3010: Use unsigned int for the indexing
      iio: light: al3320a: Use unsigned int for the indexing
      iio: light: al3010: Remove DRV_NAME definition
      iio: light: al3320a: Remove DRV_NAME definition
      iio: light: al3010: Abstract device reference in the probe function
      iio: light: al3320a: Abstract device reference in the probe function
      iio: light: al3010: Split set_pwr function into set_pwr_on and _off
      iio: light: al3320a: Split set_pwr function into set_pwr_on and _off
      iio: light: al3010: Move devm_add_action_or_reset back to _probe
      iio: light: al3010: Improve al3010_init error handling with dev_err_probe
      iio: light: al3320a: Improve error handling with dev_err_probe
      iio: light: al3010: Implement regmap support
      iio: light: al3320a: Implement regmap support

 drivers/iio/light/al3010.c  | 103 +++++++++++++++++++++------------------
 drivers/iio/light/al3320a.c | 115 +++++++++++++++++++++++---------------------
 2 files changed, 116 insertions(+), 102 deletions(-)
---
base-commit: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
change-id: 20250308-al3010-iio-regmap-038cea39f85d

Best regards,
-- 
David Heidelberg <david@ixit.cz>



