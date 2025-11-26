Return-Path: <linux-iio+bounces-26474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3CBC87E9C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 04:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08A614E11DD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 03:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C630C620;
	Wed, 26 Nov 2025 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmUNB7jf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC13C1F
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126897; cv=none; b=c2Eyc0ws+5mPMqIU2xwKDeFY9qG8D5bd3+yN54xA+IAX0Jq9aIid1XwgY9UQJ0elZdD7NIVw34Of2W8EWRlc7lxfua6Vq20ur479JFax+Qxs7Qndob03hVY8YTEQl5tSs0ZnJK6klHAQW5XS9gA4Sj6HSt39WouGYjy9YiTLDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126897; c=relaxed/simple;
	bh=nFnsQY4oJTdm/LIKJ6pX4OGfndKb+lBEu1FbJxow3QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyboArwFpO+45Y7uG1fVMR08DQhR+syxF+q7g76xGkrKfE02kAZK5hbFl7UG9Kp/Y++PyjynWgUMQgm4B17lXXKbnVmLxZu7DSrZBDQJVYvrtYhIZNzjy8xPipempHWSLFzpn4bBmq8gDHWIsmtnTttZcbAy7U+zPDYHz4XmLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmUNB7jf; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-298144fb9bcso68925165ad.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 19:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764126896; x=1764731696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsF2vXY+Klwy65O0EIOP+EhiNUNtQTtwaMk3rE4EePs=;
        b=GmUNB7jf9IcAh+Pb5g4QV7rBsQux04TvYYp5aFYN64plaoLgIT7cQXRONQGC1OCVUM
         ab42tk2H6jyu0nFaSm6dXdxoN6OME+AV9J7WlG/zwFoERCfl7rPqgIVwv+fjqY98iTeV
         8FblKsX6ovrviT/EWHZNe18kaOilNq1CqSZQT5sI9xwBzJwlOZFhzHHlpc4dXEczVxq5
         XbCHjBQkv12ZZ+g9v+sqLviBAwfVzr9xNW7Wavzmnb01S9KdllqZD66AkLsYUrAvdTWF
         /BEE3BpJlqnA2RmOgHxteQmGpSffES1Xuv/eqG8oUQeVutJqtPdLzsFlc+yidYK+YKtJ
         hZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764126896; x=1764731696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsF2vXY+Klwy65O0EIOP+EhiNUNtQTtwaMk3rE4EePs=;
        b=vQgohxGGHZvVIaZJKnckEo3Xn0Rp+3mKkJQvmS181Hpxc3MRsoJDD/IsELkCQS1M4N
         aYDHQ37Z0I2FZeg2Lh9YqOHgxUx+jTp6VhU8eaC1bFGv4arX8aOLRcm/g+RydJU+qsrA
         An7xhg4sH6EGUDT9vaUlrS4FActv8FoKu8+wnt3k1CYzi25/xJTUlcl3SPFyRiPlMGCe
         2/GQg/lczN4QSCIxNJ8Nud6ArRRZUTaGaSQ7LgPr4bDYigopse3g7+TU5rOm4Hs6cMcf
         l7i7hMhHkyE5qqIrNEKtTCvtnKGw5rX7CGXXio/fN1Jgp0ZR14lNgXNAAI+qKOuWbi7a
         KGew==
X-Forwarded-Encrypted: i=1; AJvYcCXHQUmwR/hSsnd3Nb71xfzpEuBSBzFnDbEjgogjCkSzfbN/mj7aZGO+wyFaLEF1IGoAHkShshddvZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFr8s6p0Kknr0BZ0rx4r8kSJDPaIkxLT7fVJIw3FCbOeYAzFLb
	0/h2PYLvq1tc4SQGacpbIZSftMSJ7UEGSxiizCBYn838qsX8zZT0t4wd
X-Gm-Gg: ASbGncs6F85d3FVW0eGhP8mxfTyWdiU2JC6z2hmad/HVPhF10xXHo9EztU90fntP2J+
	gRwjpnXw1l7qx4gz5EBkw0+4f1n+9LDqk0eoT1jIskLgp14vUFj+wvEq7iyHjYL8PEHghGmzq+7
	0YT8/yXt5ERJIl4S/Bivc+EDvhEI9mJ2C9QDoK694Dr/IH6xy5aDdGGaaQq+oZH0TP5kC1LdCz7
	BBU3W+Ks1joc4q02gmIky6WtTfNi4BTp9kmxAweSqxAqZhvHtSN/BSxV+ycrjC/rb2tQ1yDjHRH
	V/4KBV+g55bF4TgmZwqdL3IvdvSdmJUWVX6xXHmpTrT9GVv55gjktmiKHyzfABhlB531uIBXrwv
	okXQhh2IPnh3z1aqtxL02QaKJbJZe/kM+ZBxxAzfj6m64/dGNO9KZEUG0WmSU/OUrTcSAUYqIIO
	aIaBurfaRFiPBh4Q==
X-Google-Smtp-Source: AGHT+IF3xZUV4fsW48z+Gn4ApB/08WmG2J9vbYXEbvQ68riEYO2xTIOuy/T/mjhjd646cUi6B+XNMA==
X-Received: by 2002:a17:903:3b87:b0:278:704:d6d0 with SMTP id d9443c01a7336-29baaf75e76mr50882165ad.19.1764126895717;
        Tue, 25 Nov 2025 19:14:55 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760ac62ecsm17935713a12.26.2025.11.25.19.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:14:55 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH 0/3] iio: proximity: Add DT and interrupt support for RFD77402
Date: Wed, 26 Nov 2025 08:44:37 +0530
Message-ID: <20251126031440.30065-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds:
 - Add RF Digital vendor prefix
 - YAML binding for RFD77402
 - Device Tree support in the driver
 - Interrupt handling support
 
These changes enable DT-based configuration and event-driven
operation for the RFD77402 Time-of-Flight sensor.

These changes are tested on RPi 3B.
1. Interrupt Mode logs:
pi@raspberrypi:~$ dmesg | grep rfd
[   26.907482] rfd77402 1-004c: Using interrupt mode 
pi@raspberrypi:~$ cat /sys/bus/iio/devices/iio:device0/in_distance_raw
51
1. Polling Mode logs:
pi@raspberrypi:~$ dmesg | grep rfd
[   26.760403] rfd77402 1-004c: No interrupt specified, using polling mode
pi@raspberrypi:~$ cat /sys/bus/iio/devices/iio:device0/in_distance_raw
1990

Shrikant Raskar (3):
  dt-bindings: iio: proximity: Add YAML binding for RFD77402 ToF sensor
  iio: proximity: rfd77402: Add Device Tree support
  iio: proximity: rfd77402: Add interrupt handling support

 .../iio/proximity/rfdigital,rfd77402.yaml     |  55 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/rfd77402.c              | 134 +++++++++++++++---
 3 files changed, 171 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml

-- 
2.43.0


