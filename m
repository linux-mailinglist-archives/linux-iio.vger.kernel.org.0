Return-Path: <linux-iio+bounces-16447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C7A53F10
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F2D16EE79
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D082B661;
	Thu,  6 Mar 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuU5VJIn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D415672;
	Thu,  6 Mar 2025 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220812; cv=none; b=ieIHdSXAimK6oR37LqTuLBQmn5UfYQFIOqlqY9amFJjIJFy5t8YiUKM6FsIi753Y1KcacRCzTsblnnKTLKHTcBas1xUVGfYq1t/xjslqz2iZi7qmour5yBPx/7yqrgHjOdPkWdz1EnLbGY09h34Di4yDObQo5JsZn+N5c1P/eJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220812; c=relaxed/simple;
	bh=yZ98bLrAKhuf14tkuG1jhA6uOEIAz+pZcMMQ8oJaCJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/HeTPj/uwKrfuXoIRWkmy7+lXiclTsw4r49HeGEHcsV+N1AkH7BfiecemMUdVOB/+OKssCWTnuEO8PIJ095u4E4lYal9MpxDBrORdOVL7+zdBUT2Azu86lp71kBHHx187jVlR46UAYQn7pqC5lCnmAhRsD6qgL8CClsJFy4L20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuU5VJIn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so258377a91.2;
        Wed, 05 Mar 2025 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741220810; x=1741825610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ98bLrAKhuf14tkuG1jhA6uOEIAz+pZcMMQ8oJaCJE=;
        b=BuU5VJInUsvc1VGZv5y+AHbXOtw7y4bwBebt1kEqSKFqmthx0An8i6fEaJxnQ9CEnG
         K521UE4WwhMzRCTvJBIH/gSvAPZbhpZaYFt5Aok2dMN0e8sF2U78hP7LBvvKtAJEofxF
         XY4EkOOuJ3ENhxEYOUFg+TTU68Wo9Sm26FvwsNRR892n3reArZpJG9lPEh50uNlnAP7Z
         WgbURR5x2Pv9QV6doLdSXxZE4cLCRckv02VOdAtVEx/eIiL3389rKhmQQf0OqO4pt3q7
         TdMGXbTG6fPuVKMNbGpO+wD3tmlbRyh8vSkdDv/NVtIqVafr9ZzfIm9m88rnC/1TLvca
         MS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220810; x=1741825610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZ98bLrAKhuf14tkuG1jhA6uOEIAz+pZcMMQ8oJaCJE=;
        b=E//4UJLBn5NG9MembOrh8zSkPMx5AiUYJaCcyhcqKQmZ0JOXmhV/9pVpN1bgDSBA/T
         jsUspux0jv18HI/ELCjJUp63yDT5grN/uquIre3FOzqXhEutyJumvlC16Y6xn38irHHr
         LYRMNw6EzNKM7c4QV08csoFh2iEO5SOXjMAs/oQEAUDoDXWscW3qKOaPRo4bNcXAmlcY
         z8ns3aMe+VPdwFaB41bfutn15kEaEsLKsI1HDlXv8ReNI5bwPXkB8/7amIWJr4trY+bu
         jURNofuRurGpBlo9Z3S2KXR9+6GLWdiuMYVTnECMyoAY/bLoGYPv4PZBmVuZ0gutb7n6
         lnOA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJETaoTw15ycqdeoo0dOrR427dBH1s3m6kXH7vkbFoMVrdpTD8AxVJt/Rxs6mh2SlMQGucjsqKZQ=@vger.kernel.org, AJvYcCVYfLZ5x3HsUd+jzLjhds6HgQ+fw5BEgCs4UvY1Yjd6J/NG/wT7MTxv6/OUepHGMqn277ZvZ7E7ckYykX+i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+MhuWs8FuuXk9HsyYdC4VhqLjNFxUtVeFAqgzfksiHBmYKrW
	4FxJ4Zg41guzxs4SYESanQ1znHLaKbp1MiQ2vrJPyxFxQ+JxqJR6
X-Gm-Gg: ASbGnctCI7I/HCfUllhYozzL68raZj2nliZdE8K9lNjhSmd4S+cZNlZ5qmjWr2c6nyd
	vXceshdkFhE/lARFwtSyyo8fI2rnTiHkzM7HCM3NeBRlAjQ1FDTd6V4G03O6Kasg05z9XZ3Icpk
	0PSVyXXbyaoBZ7mvZxsTEs91WughXStekotkj1SwtofS9PHGiDdc6SGty1fL2OsSM1km5s4GenC
	mj/cdemcMDG8K/kCHUsy7Zq7zxZNIIly+jG6T+6miZ6pmdy+YYtTtMFXkS+jM97kkHMSa4mWFUb
	n8iY5x9omTROJ9InGdssmRoR4rLzVNR8sXa8rHQR+UOabAPY0TUuAbk6kkhdJYuArS0=
X-Google-Smtp-Source: AGHT+IEWPHAFmZck3hGQPAHqipw2baiO89OR7YV8iIf976lkc/Lk939v272GzxvMmp80brDi5W/utw==
X-Received: by 2002:a17:90b:6cb:b0:2fa:17dd:6afa with SMTP id 98e67ed59e1d1-2ff49753458mr9642304a91.17.1741220809838;
        Wed, 05 Mar 2025 16:26:49 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:857:3077:7768:d8a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5166sm184395ad.219.2025.03.05.16.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:26:49 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [RFC]: Getting ADIS16203 out of staging
Date: Thu,  6 Mar 2025 05:56:45 +0530
Message-Id: <20250306002645.1555569-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADIS16203 and ADIS16201 are very similar in functionality whilst the
major difference between the accuracy in ADIS16201, I wonder if they
can be merged together into single driver, whilst also implementing
platform_device support in them.

I want to work on this, provided some opinions for me to work with
or to have a separate driver for both of them.

I see that there has been some discussion regarding the same at [1].

[1]: https://lore.kernel.org/linux-iio/20230124094450.0000272b@Huawei.com

Sincerely,
Saalim Quadri

