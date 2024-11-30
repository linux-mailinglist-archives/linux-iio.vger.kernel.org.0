Return-Path: <linux-iio+bounces-12839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204A9DEDC9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 01:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3443A28158B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A6DDBB;
	Sat, 30 Nov 2024 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGHBPj9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7608821;
	Sat, 30 Nov 2024 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926446; cv=none; b=KoZyLM5sMoSENYSnjV8YzJGHIuaB6w7H5HlMdYLmZ5o3GShKoG7UqGlIugliogNfoLUPIwrejrVxBDJ9FQLCFELxuU8Cr5cDYGMbL6NePNNBciaIPTLJA8HWoCaWKO8fl5hQ0PCaOvzcA5FPjnyjQd6DDXVGX9Xl9U5JlT5+p0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926446; c=relaxed/simple;
	bh=P6hWT0kcgMtgu1oQYVYn2k9rblTy6Bz6ABZJIRKT+eY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJVcFuOnZuCl9PV0DeUTE9NWaLBN+59jefZykpYuxMBbJETFyc34akJLnQwqtJptXOP9PRw7yXk1FK2v+VIY+oPsJpziOA3hC1tUSb8tHfWzBKA45Am5FlWGJXhShmlkLpvBJmsnVFZScdpVfkYQMpG9ZBrf+iB28qyOphaF/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGHBPj9p; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e3621518so152389f8f.1;
        Fri, 29 Nov 2024 16:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732926443; x=1733531243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtVBtdGJyciV8tL5BS6KSR2h7PyV6Ue0OUcK1A3bXLc=;
        b=kGHBPj9p80chYpiuoxLHidWY9whXWlfmiZc6D3YE4O5Yhxcfah0w1q87sLzzqQpw/1
         ycqodNXtg8Eg/usuwbGEX8J/J4TntfBSk6gXdWWcEzT97ZbBnJvRoasmmiUhSbbAtPAA
         +JLOqdFfKCyyoL2QSvy/2UqllAdvnI8KFrtacpZZzw34osd6Mobr0G7fpKj4ZZX38YeW
         ukOV+bHtJGR3jMHWPxqIyyVvbp85NebBp/l4RBCrcaMhstH2wI+d58z96qgQIpHg3W7n
         seFjzCBXMp+jwS1LyzH2MJGoqx4YL24l4jig3+TLhhEUH0EVJZjf9/RN9po9WQUzfRpT
         BkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926443; x=1733531243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtVBtdGJyciV8tL5BS6KSR2h7PyV6Ue0OUcK1A3bXLc=;
        b=jvhKjf4dbWdBOO11ivPSR2wO4QIdVcq2s6nMNY9vMyuN1qiMS+dpbEvqhanKmiOKQT
         hXrgQO6HoHtn+r5GFp5rWjEVbGk1JARwN2yN+J1d+LGGoQd+SyHKrVNqAAH2mLyr5RZs
         aCx8FGUmYi92GnOnQZ+fyKQmyzFBp0+Hge75hECnP0lX0aZJImA6XRMkycmguSH5Dcbr
         7N46Z+CAbbAilqPWTxkgHVqauR/Zy21CSb3CHwqVJutagH5ikrL27mPhhAAq2XCXUKtf
         t6TgeCe0CHFIPb2PB+K8r4LtmINBizO1fnLPcq1uAoh1YVB4KfeAcg9GKT7aE9meE1XQ
         +M7g==
X-Forwarded-Encrypted: i=1; AJvYcCUDBC3KL2oD9OoGK0PwgeipkqXrCzDhZ98rXUdGU0UgiFOsHOO7T0hoUYpsd1Dfz/jgebo/paeq2mCivi/M@vger.kernel.org, AJvYcCUsCHkn+TmuIRjJYB+jlIZKTpnzLMP6Gw6N9dVIXBZVyj4v3uoDB65A0G6s2Fs9vHnOVB5UCtxlkBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmO2YcWP0HmNwfv71mWVFlIx6ysbRHpGAUFuzDoDOOpVnEqc1
	spDLHGWcwmoZ0YcwULXfRs/Eym7Ub4j1wDpmAjTKgTa8lsqMggNU
X-Gm-Gg: ASbGncuj5R+mNFA/r7u3bNGp8QidCOpOJ6/l/SILWNOu1s9wFjp5g3cIo7CX7oANnld
	yinVZH/TD41k7Mi6H5dycNxiJVtx+rqy+fR3idnUPPd7/apTT9v5WiCp7z03Mcyy5+m3rq3mpA1
	5crxOKMVHeVhbm2xJoYBH3YruYa4pnvT6WOTvuxhzn4f15rtCsFpO/W+Dxjrk9dzB6ZMAtg/u7N
	zBnwyWyOklBkFU+iyDu6VkH4FciLTimmO6s9IXRk2hubl6imXFNMIfq7HmF7A==
X-Google-Smtp-Source: AGHT+IEsoSdhliUETdtE3akjnLXuhq0LGm32Pb5d2kr2eiBzY9ylY8Z9QemPyClKWUwJkMlMesWvaQ==
X-Received: by 2002:a5d:64c6:0:b0:382:424b:d0a6 with SMTP id ffacd0b85a97d-385c6ee2285mr11467060f8f.55.1732926442519;
        Fri, 29 Nov 2024 16:27:22 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm5873345f8f.7.2024.11.29.16.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:27:22 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH RFC 0/6] iio: mark scan_timestamp __private
Date: Sat, 30 Nov 2024 01:27:04 +0100
Message-ID: <20241130002710.18615-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scan_timestamp value of the struct iio_dev, even though is an
internal variable, it is being used in some drivers. To avoid any
unwanted overwrites of this value, create a getter and when all the
drivers are converted, mark the variable as __private.

The patch is an RFC because the added value might not be considered
high enough by someone to be implemented and/or it might need to be
done in a different way since it touches multiple drivers.

Vasileios Amoiridis (6):
  iio: create accessor for iio_dev->scan_timestamp
  iio: make use of iio_is_soft_ts_enabled()
  iio: adc: dln2-adc: make use of iio_is_soft_ts_enabled()
  iio: adc: max1363: make use of iio_is_soft_ts_enabled()
  iio: common: ssp_sensors: make use of iio_is_soft_ts_enabled()
  iio: core: mark scan_timestamp as __private

 drivers/iio/adc/dln2-adc.c               |  2 +-
 drivers/iio/adc/max1363.c                |  2 +-
 drivers/iio/common/ssp_sensors/ssp_iio.c |  2 +-
 drivers/iio/industrialio-buffer.c        |  2 +-
 include/linux/iio/buffer.h               |  2 +-
 include/linux/iio/iio.h                  | 11 ++++++++++-
 6 files changed, 15 insertions(+), 6 deletions(-)


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
-- 
2.43.0


