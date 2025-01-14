Return-Path: <linux-iio+bounces-14353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018EEA10ADA
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F603A8931
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDA1553B7;
	Tue, 14 Jan 2025 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e7JV9p+Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF1232424
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868708; cv=none; b=g4xZi3/m1e2JwcbWgz2AMrVa9WerjJyucolKIG3flL1uSPL8LtK5AGssmZMbH8WfsU2spHLpGxXm9mkIMsWPFcab2IEKqnUb75vdZsFYApRex2lcF+0/94Tn6UM9f3baqPFjtI9RuzykKVfJ6S8C6CFuLMRQyowZ4ICPEN3C5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868708; c=relaxed/simple;
	bh=Es1TVOWfwx/4p7p158C9kQa+LEYGq+RP7fWb+hVn5fo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nNtrY570b5/CLrDzfHQoXHD0KuqDlcDEyp7Q1gKLeTlNUwnN0ByLJqYDT6ST1yAWPc94x1VY0l1xSqf/jWGGe1tLMAJmJzrZdyRsGcgyRjQrws1wWts3XvPzX0C+UQPxog7ln7HzxGbAELk5eQ5pu66cmm7OyLh0rCPUfzQncTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e7JV9p+Y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38be3bfb045so414455f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868703; x=1737473503; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igel2vkgoJCVoyLP4FetoF3UVHu5u77x1nH2iiW7UGI=;
        b=e7JV9p+YEcl2dGmQLSegPxof6R84VOgW2P+rKyT1IQl5yGt8QOigtZySadYW21Aqk+
         Cz++RglM/P949uF1mbP08uDHyfYYKrg44yRdOsJ1pegb7KkkVCScDx2WByaNTuikl/g7
         4Q8O3BJrbdCf6y4u5qnJ+/CRG8TOARDu7FaBoelaJzG2COB5AiPj/gfVBIlV8Eu74OsS
         YsPmGTP+9zg1dAFt3zLlUqaVHqeGqoGRPp9kSwmxyaI2zlQXIobEwkqbUArPqscJGkPX
         bWCECJd9TcgrMbiVQ3G2xj6gpM/JujIYWvpfQchTwTK4w5AM31/qXGi/1YZLFe6hePtM
         Xyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868703; x=1737473503;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igel2vkgoJCVoyLP4FetoF3UVHu5u77x1nH2iiW7UGI=;
        b=lheRGuDitvmSIpJRtWI2ruuTGUMz+hti7iYwmBn/+557ZZo0qgMT8+wgjaaChIJY0I
         rtAK5qYqR2zABvqrn5iK+LbL0XObPgZ7rkijPEoWC8zdaW4ZxaJ5ErENUq5ixeuQ1Ji3
         dEkztfDefWQU2xXeMBlD3EVWMiQfJPoNenE1Z9dKk4eCCFLx9JAo4B1/MAWPHhT/M0lM
         P7fivfxT0V9lwbgr8C9/Yp/7dicRYZnN8ialPWS+1u6gduEE6dVRstGYtqy1XyKMhMGp
         IrRnkqLJtyr7prou9+ZBYGYUPZk3P9/Qd9REz3Pa5/7yQD5tQ4AG9o/kcFqlyX1H9p3W
         Gqkw==
X-Forwarded-Encrypted: i=1; AJvYcCUVEAmS5s15bzVC9hTppe3/8zCFdASnviyCAR5Xiw/4hRldyVmJkoLetR17R6oPzUZeF0sT/scuwzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyT/FstLLcHfq6T8TLfNASrLQE/51fk+e7QEjnzlA0Jf26YbSj
	P3C2gK3rW3aCNPDJxjAN/cJ35gNfs8mTka+iuOiyyNTOCtrLYRtzX8Bd21a3o/k=
X-Gm-Gg: ASbGncvqBw64bhk+vdeWpUgQVe6dnjpG43QWLtnXN5p3vbZpfaoxAOfUcHBE3QJeeha
	/D8TmiOTBIw/ShAvwr7phHhg4va99/LnHcgBCsS7UdX1uuIkt2TVFTwtbmNEBNJcA4WvDeO0m03
	OwRKQLpgGNazt257eetQu4kf0k6O4VoT5fA5smvBsQKoOiNw5EfIiitA+4CCA6J1ZO6fpA+0uWS
	i9C6cbGo9wgOcXmjPPqz66Lo3wgxYr+sJukWpmm6CKsNiL8XBpyqWkAd7s=
X-Google-Smtp-Source: AGHT+IFrV91Q9URqMXe3k6dAepWiabO+RctfNkZD3jhf12WVPdGRnWwBQjtIqk8UMkgKTcVQ99nIJg==
X-Received: by 2002:a05:6000:1f8a:b0:385:faec:d945 with SMTP id ffacd0b85a97d-38a8b0d3202mr18931747f8f.9.1736868703053;
        Tue, 14 Jan 2025 07:31:43 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:42 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v4 0/9] iio: ad3552r-hs: add support for ad3541/42r
Date: Tue, 14 Jan 2025 16:30:09 +0100
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGDhmcC/x3NQQqDMBBA0avIrDuQpMbSXqW4iMnEDkgiM2IF8
 e4NXb7N/ycoCZPCqztBaGflWhr6WwfxE8pMyKkZnHHeWNvjl1ecFgzp7r0TDAfjbpC54ka6cZk
 xBlmq4mNwOQ/xaSlN0HKrUObjv3qP1/UDQPrcsHoAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

This patchset add support for ad3541/42r, 16MUPS, respectively
single and dual channel DACs, together with some minor fixes.

The ad354xr connect through a DSPI bus (while ad355xr through
QSPI), so a new fpga HDL supporting bus mode switch has been
developed to support them.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- reproposing the patchset using platform data for bus mode
  change functionality,
- improve commit messages,
- add separate patch for instruction mode,
- add separate patch for sharing model data structures,
- remove error on wrong id,
- fix id detection info message in case of wrong id.

Changes in v3:
- improve commit messages,
- removed some not useful dev_err, 
- comment syntax fixes,
- add lock guards for bus mode change,
- remove externs for range tables.

Changes in v4:
- keep in still patch 1 and 2/9, that was already picked up, in particular
  the patch 1/9 is the same as in v2, the 2/9 has a minimal change:
  removed dev_err() message, so can be eventually be re-picked up,
- fix commit messages,
- add mode validation in axi_dac_bus_set_io_mode,
- use dev_warn() on wrong chip ID,
- fix instruction mode patch to unwrap properly on error.
- rename ad3552r_update_reg_bits to ad3552r_hs_update_reg_bits,
  to respect module name in the function name.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

---
Angelo Dureghello (9):
      iio: dac: ad3552r-common: fix ad3541/2r ranges
      iio: dac: ad3552r-hs: clear reset status flag
      iio: dac: adi-axi-dac: modify stream enable
      iio: dac: adi-axi-dac: add bus mode setup
      iio: dac: ad3552r-hs: fix message on wrong chip id
      iio: dac: ad3552r-hs: use instruction mode for configuration
      iio: dac: ad3552r: share model data structures
      iio: dac: ad3552r-hs: add ad3541/2r support
      iio: dac: ad3552r-hs: update function name (non functional)

 drivers/iio/dac/ad3552r-common.c |  55 ++++++-
 drivers/iio/dac/ad3552r-hs.c     | 322 ++++++++++++++++++++++++++++++---------
 drivers/iio/dac/ad3552r-hs.h     |   8 +
 drivers/iio/dac/ad3552r.c        |  36 -----
 drivers/iio/dac/ad3552r.h        |  17 ++-
 drivers/iio/dac/adi-axi-dac.c    |  33 +++-
 6 files changed, 350 insertions(+), 121 deletions(-)
---
base-commit: d487a2869417596556c56b781f82ebeedaea6889
change-id: 20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-762ff6c91edb

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


