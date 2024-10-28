Return-Path: <linux-iio+bounces-11417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1AF9B286F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 08:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6BFB21000
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4802190063;
	Mon, 28 Oct 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s/lr+tPe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35E18FDD0
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099487; cv=none; b=icP58pFcJb2EytMgRNAhNFtTvPJYs/RkgYm/F6iSYE6prFMeo1o5suMOpOkpj6qn4qZ0SqM99Oa3onnyLFOmEJBivNgDBxX/SP/riU5bFHJd1Po6bIDfNsCNCLpNx4+28Ui06kM7MxxEyz7AdJFzB23r5+7uzknyQ0E9P/W9Vhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099487; c=relaxed/simple;
	bh=fW9BjtCU1UBH/gBt0JdW7sggQWu4UJ3wrVCF7tbLnnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=erb6AaybkRx3WQ6VAhgnqm77T2Nipr/hSXktf5n9QjdNQ/LHXzGWQTvLostAB2WKYYpUH5L5wtXajr/eiKOp+IHQCiOXQ+GAkuy8wzLPm+93x1zOCC/D+vj5Zbj1K2jjR6WC+fpN8DcZgYmuWyPIF9HfxTx2QaeBIR2sA4RztT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s/lr+tPe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d462c91a9so2949882f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730099482; x=1730704282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cH/L5owApX6eUPwGmMX6nfiTXivs8jOGxfI3TwHiRqA=;
        b=s/lr+tPeBe664W+oYjhsd24H1dqfwpjNJKgMNlMzLH6KLr5+Hj17Lt+EDOnDdkjQ4n
         8TtzrgndybEfClYuM74HMxrxen7kXJ+5fBdNn/B1lif3P5GY4GIMHViK3t0qreqU8T4M
         TCKMV+BYpMMq9mJ6TjrVSjAm9zk3k6Xo+9IMTX+HLLAV1P7dQMs92eyhaShW7Pim9yom
         aM1JRFRYjmSLOkhwW7uF+mn+dNJMEAl9q8v8Z50pGVZGg+J8C01ck5TR0aLcqChhURMY
         KBRRIpXV4eHNCddXyBMqb+8FUq7s3BY+KWM2s7FGDa5n5pm3hKUx8tlG98vx68ff3CPM
         L7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730099482; x=1730704282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cH/L5owApX6eUPwGmMX6nfiTXivs8jOGxfI3TwHiRqA=;
        b=VqZWBmpM9GpJfV68UK1kIlobs6KgO9aHbvabVQhRKZIDzl5dl+/1kg8XGx/8ULEQEV
         1soyaCWfeJAzGylPqSH5CJxENEvCaXU5eyGOYEJu17YlSKX0IaVw/gqYu46tkUAE+K14
         2sJtppo5JakhpdH6IVncymXjSimxcc3yQi1G8kYjroiaD/PzBKbdw4Tfh4rRplOkJfd2
         AOqK51G/YuwX2KiVo4zTl8BJgA/X8kRRrBagxSYKp/3k+uG6wtpGgA5qWSRQ+tH2mFYN
         BQVrZVCzT7OR2rWk6Q+P0aO5BuAgnFQ6JU+pwjGioxmoYMy7RCIWVrT+anft4wBJXXc8
         zvkw==
X-Gm-Message-State: AOJu0Yw5q3Y5oDYpmEg+pF4TKCNMB6qWfgIft2kL2j80y9HRfFiSIK8l
	ki38+IbfEeRaz1FBkAG6xI6PwJJsXKjPoKaRVrx7W+oqAilt4IKkJ1mCfDOZWqk=
X-Google-Smtp-Source: AGHT+IFAz/V+kTYAl9MyZyFYp1LFLDq27Jcel1EGnbTn977QSteD2kCYXpul8KJVR0jMytiKAt8MVw==
X-Received: by 2002:a5d:488f:0:b0:37c:d179:2f73 with SMTP id ffacd0b85a97d-3806111f422mr5271602f8f.13.1730099482525;
        Mon, 28 Oct 2024 00:11:22 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c236sm8615383f8f.35.2024.10.28.00.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:11:21 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH 0/6] Improvements and Enhancements for AD5791 DAC Driver
Date: Mon, 28 Oct 2024 08:11:12 +0100
Message-Id: <20241028071118.699951-1-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

These patches aim to improve on the ad5791 driver:
 - make use of chip_info / match tables, and drop device enum id.
 - Add reset, clr and ldac gpios that have to be set to the correct level in case they
   are not not hardwired on the setup/PCB.
 - simplify probe by using the devm_* functions to automatically free resources.

Axel Haslam (6):
  dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios
  dt-bindings: iio: dac: ad5791: Add required voltage supplies
  iio: dac: ad5791: Include chip_info in device match tables
  iio: dac: ad5791: Add reset, clr and ldac gpios
  iio: dac: ad5791: Use devm_regulator_get_enable_read_voltage
  iio: dac: ad5791: Use devm_iio_device_register

 .../bindings/iio/dac/adi,ad5791.yaml          |  39 ++++
 drivers/iio/dac/ad5791.c                      | 195 ++++++++----------
 2 files changed, 124 insertions(+), 110 deletions(-)

-- 
2.34.1


