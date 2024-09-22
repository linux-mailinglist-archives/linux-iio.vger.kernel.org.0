Return-Path: <linux-iio+bounces-9708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F097E3EC
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F145828127F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A57DA8B;
	Sun, 22 Sep 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE8SLfxM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2321A28D;
	Sun, 22 Sep 2024 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043479; cv=none; b=ba9yCDrslS3aJUBQjld1RnOlWtB4cC2pkto3OGSbtQ7tC+bI9Tf+1PEiyU0pmCCi71xodQWVNj61tSjSTBtvfRrS75qyDdfsBY5i5DMmx+sHXiAHZ1HsY/P/QpVwl+VjNpW/U/QM+zH+kpzGUeLY07exUxdOjQSvyc567bUu3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043479; c=relaxed/simple;
	bh=zRfTlsewnL1gK1p7evRw5lN7oPTz7Qc3Kk9b9YTEMvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VSq6HOq1BDDLYy0hdxgUzc1QUOfmOSDk9QQ52Okw1T5d2KkkaKItoFkeAZj+1MzH8hG+hwUIRV+y8k8iSkvXe/MC7bip6yl6xFV/qHzIjsR/B5TAZSMsWshvDLPq2TmW4MssO8nz4yveb/BI8Fi0lBY+9FA9L2S6yvmxZQvirWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE8SLfxM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so870569666b.1;
        Sun, 22 Sep 2024 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043476; x=1727648276; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXK3DVY3ahAKT/DIqxZKZqCTgkhuDK8+IBLRUjvJckg=;
        b=EE8SLfxMYEjbc47L45ryMSZiyXLmVOxrJSejmReis2c1Zn8bfIEw2j81H4vXtu1iNT
         wCWhRlWn8O9+P4XLyMo4oCfG40jRI9tmebeOBnO2Nr/1GzMv8iH0byWA9Q7PE5XnunwF
         aem6TYivHBKCuf6FQDd5U0Bq7FXEZuW6IFNlIbq3vew0eDEL8xAwlipgbowGMMU3Dvtd
         TAud+ae4+SoQsFIgfhaJ+x2K3fj0PuNWnHo8XjIBCU3ROwyDt0oGMlTXeAW+Nw/Vp/w9
         dOybPanPg+hlMeBAStpabNPObeJlkqzs/fmpHfj4XxSzUFfldgOjgl6JZJjtL911XRQN
         ByFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043476; x=1727648276;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXK3DVY3ahAKT/DIqxZKZqCTgkhuDK8+IBLRUjvJckg=;
        b=G/l4TbipvpRXQr5XHLc+7eVTx3DaOTJYrxGTpnQez6UviptoJko20nq85CXddIc9Wp
         wfrPcW2VLp8Kx/iZWtRh2H+RLxctcT0Cfcx0Br4xAwGs0ZJvpFg0+6irW2PsiFl0h4ch
         QzSTeh5hp/q1/tyCmz/BVrqfGNThr9GjYw5w6GxtdTHxsyCb/xRAqeg0VElUsjIVdBog
         gQ2vsklu3q4DnzxsvOAYntaPjmTbGd1bWcR0BKLMB/MLARpRKgRACiztcPP9x5UDJnBr
         TvGndVVqML1qfRA2e+XCpNCeRoOdZJVW9r7ehwgTScSTXmYc6iBnQrzZcl3AmCzrTN/X
         CtzA==
X-Forwarded-Encrypted: i=1; AJvYcCVCNNfqbF/p6dWxCeLz9J/AKkrJTJcyyHWLotDS0x78nmTw2J9PVDQ31EZuW8CVdgVJEvy1Hber@vger.kernel.org, AJvYcCWJPE9Zi94ynYNO0ib92u5tuBPUqa4X4W2xAlfcTYzLcqxyJssIkm+4gXD5AumYJhXj2Drbj5nguxkyhMtY@vger.kernel.org, AJvYcCWXdWOVMd2Vo4AK2qsIW9AC5J5NAbw4TzA+aXQSBEYK0zFfAYAhNNie0fsdD9mCoi/KhLNhhSn4VP9M@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXJkXfaNBNUj/3hBWrCB9WiIe8ducLCHVuGEOtlk0ylcGg16W
	Hj/GL+XqM3fipE3Nf9iU+XsyvIidW4dHslICVc0+bb8Tcpac1Okr
X-Google-Smtp-Source: AGHT+IG9qeopRd4C78uB2wWAtr8cWA2Ma5YJbHKJewHULosUL/5/iVc2DQEkm0crIXcSRbCD1fp3Cw==
X-Received: by 2002:a17:906:7951:b0:a7a:acae:340b with SMTP id a640c23a62f3a-a90d364468bmr935185366b.31.1727043476131;
        Sun, 22 Sep 2024 15:17:56 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:17:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 00/10] iio: light: veml6030: fix issues and add support
 for veml6035
Date: Mon, 23 Sep 2024 00:17:48 +0200
Message-Id: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyX8GYC/03MQQ6CMBCF4auQWVszLYitK+9hWJQ6wCRATWsaD
 endrcSFy//l5dsgUmCKcKk2CJQ4sl9LqEMFbrLrSILvpUGhatBgLRItc4v1SZytkb1DrV07QLk
 /Ag382qlbV3ri+PThvctJftcfIv+QJAUK7NE4dAYbqa/jYnk+Or9Al3P+AO4gu0agAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=2726;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=zRfTlsewnL1gK1p7evRw5lN7oPTz7Qc3Kk9b9YTEMvw=;
 b=9B0SznKXvbzDhytqyeV3UxnP+6MXKYHz/aR5mGwyxvD9QwQyDCAlq090BxugIjHvBDx7uFwDM
 45JrP6dNiAhA4Odw5smL6fzOZEH6L7rXwQSGG/4IDfWc88p4YHJTi4b
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series updates the driver for the veml6030 ALS and adds support for
the veml6035, which shares most of its functionality with the former.

The most relevant updates for the veml6030 are the resolution correction
to meet the datasheet update that took place with Rev 1.7, 28-Nov-2023,
a fix to avoid a segmentation fault when reading the
in_illuminance_period_available attribute, and the removal of the
processed value for the WHITE channel, as it uses the ALS resolution.

Vishay does not host the Product Information Notification where the
resolution correction was introduced, but it can still be found
online[1], and the corrected value is the one listed on the latest
version of the datasheet[2] (Rev. 1.7, 28-Nov-2023) and application
note[3] (Rev. 17-Jan-2024).

Link: https://www.farnell.com/datasheets/4379688.pdf [1]
Link: https://www.vishay.com/docs/84366/veml6030.pdf [2]
Link: https://www.vishay.com/docs/84367/designingveml6030.pdf [3]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Rebase to iio/testing, dropping applied patches [1/7], [4/7].
- Drop [3/7] (applied to iio/fixes-togreg).
- Add patch to use dev_err_probe() in probe error paths.
- Add patch to use read_avail() for available attributes.
- Add patches to use to support a regulator.
- Add patch to ensure that the device is powered off in error paths
  after powering it on.
- Add patch to drop processed values from the WHITE channel.
- Use fsleep() instead of usleep_range() in veml6030_als_pwr_on()
- Link to v1: https://lore.kernel.org/r/20240913-veml6035-v1-0-0b09c0c90418@gmail.com

---
Javier Carrasco (10):
      iio: light: veml6030: fix ALS sensor resolution
      iio: light: veml6030: add set up delay after any power on sequence
      iio: light: veml6030: use dev_err_probe()
      dt-bindings: iio: light: veml6030: add vdd-supply property
      iio: light: veml6030: add support for a regulator
      iio: light: veml6030: use read_avail() for available attributes
      iio: light: veml6030: drop processed info for white channel
      iio: light: veml6030: power off device in probe error paths
      dt-bindings: iio: light: veml6030: add veml6035
      iio: light: veml6030: add support for veml6035

 .../bindings/iio/light/vishay,veml6030.yaml        |  43 +-
 drivers/iio/light/Kconfig                          |   4 +-
 drivers/iio/light/veml6030.c                       | 453 ++++++++++++++++-----
 3 files changed, 391 insertions(+), 109 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20240903-veml6035-7a91bc088c6f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


