Return-Path: <linux-iio+bounces-5396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAFF8D1E8E
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8932A1F232F6
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43816F85D;
	Tue, 28 May 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMKx7CVe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D916F847;
	Tue, 28 May 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906281; cv=none; b=tUWqCDad4oQZjPX+lnbBEj6zD9DIp2yDrFi0s7h5YbW90F4j9gv9rKa6dBeyUfh/N7anv0O5XmAX0SvrKOBCzOjDj8aCpf/76CdLSfYPaC/1Vu2Dswxmon2eW4VWw/UAUtu5zWmnghrMyBTrzOISRb08zk8FQHpScKRL9a45RNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906281; c=relaxed/simple;
	bh=CpNig8i04u7yArz56+Pq3EY0WGXOcEaavla8yaV6nNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RPIefTxD3cuu5hgyariMNG21c4TTBjinfoQPnb6+Z33A8X64/WBPjoU5bFrcHs2hSPo2Me0K0QO1PfIpLxyYn9/Jo7BnpfO5wWwmA8YMv0a8dgA+UHrglMB8/H3zwxPnGHbINH+puwW2PtfRzDjpExaoDpI2PC9uAIdStKzaHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMKx7CVe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-578676a1b57so455935a12.3;
        Tue, 28 May 2024 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906278; x=1717511078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxA4xy7Sm7SYGJwpfTgxEx7SddTuAL9NNNge2TQxq9g=;
        b=iMKx7CVeHFPSo8UXn9Edvdk3bDwF869lAsnVjwFpxbxsmTdQzp2ug+ZYDgemqjyfjz
         E90a7sI41uFNQLmLaNU/3DDSKuzz9KcknOVIaoSHhhZFYjHG4Chjm/9gWrm5bH+uy/uD
         skeAMayzh1aNfCd6I5XSpFg8piz8JpPiWUerN/XR/JMtOvPxYWt6CAgCG6pLYLoBKWuf
         cn2NMkzlTmrNA1iNsjyAGOWM7ykdcfuNlpwGmuzXBP6zlUCCJ4UJ+zz5ZEwiVUhsBblt
         jZJjTYCvf4DzbhnO+KmkdmPSojSo8L2i0iqDhUZwxlfBB/toNvuQpzJryZ0CI2e+rl9r
         38aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906278; x=1717511078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxA4xy7Sm7SYGJwpfTgxEx7SddTuAL9NNNge2TQxq9g=;
        b=CWCvvHj3picXW14g6rtK2AHcXBtHVMBjsA5k/Nis42Z5I4PJQ9/vxOsAKpvIKIbbvu
         YL328stXbMBoHVxv+3a5y8PghiCqt4WVt1h9c3/lOzixwbcdj7KmrpzUwESg6Q3au96D
         qKTEtJdZPQbB9IJD5wTWWJZdS/+Z3UPe5lGiaQQVT81J2n0wmpjh08PYj0qXXswIfdfL
         bUbjkVVQT0O4pZSgQjoNOVCM/elY+COfeCyz3tg7yJYD0ZwO1J0z/TrZjpOTv2ctr6M3
         c9++kKEF4XEVoFj52FTb89i2vd/5PsoWTwneERLYv7Z7Jx8CGA1u3s4y4+UpDdZUIvfG
         TxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx5nT5As/ETnC0MhvvrUUfphkrF/zsdOlrcO0VW/nYITGYpXAoeEyOJAAIcD4NFStINifYa2O0tsawAefX24cJmCuxTwk1WwcOFd2+Vr3K0UZKj/gwsTysBoPwIm6d36pDu1lugZ487Td+Nh6q2WJTw95pLdJ8mzPuEWV9aki48g==
X-Gm-Message-State: AOJu0YyWcByMtokgH1Sj3f1H99FORUzkOqDHcGQnTjv9X9hsBKnKnNYq
	n5Vqcl0+jjY3M5W7A0xoCQZES4jss3i5qfmqLsPC9JJGkjul6tg9TmLtWEbgMuI=
X-Google-Smtp-Source: AGHT+IE8Lz5RyyighE7GKU2QlcjM001GtbOPd3AVNTQ1ZIurq+Ru0m+k3HReTwDzi/nkvE6Egp1GNw==
X-Received: by 2002:a50:9f47:0:b0:578:ac24:7f7c with SMTP id 4fb4d7f45d1cf-578ac33c79bmr7822680a12.19.1716906277498;
        Tue, 28 May 2024 07:24:37 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:3736:ef2a:a857:c911])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d7dc9efesm2495580a12.48.2024.05.28.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:24:37 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v2 0/6] Add support for adis16545/47
Date: Tue, 28 May 2024 17:24:03 +0300
Message-Id: <20240528142409.239187-1-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for delta angle and delta velocity channels in adis16480 driver.
Add support for ADIS16545/47 devices in already existing adis16480 driver.
Add documentation for adis16480 driver.

Ramona Gradinariu (6):
  iio: adis16480: make the burst_max_speed configurable
  iio: imu: adis16480.c: Add delta angle and delta velocity channels
  dt-bindings: iio: imu: Add ADIS16545/47 compatibles
  iio: adis16480: add support for adis16545/7 families
  docs: iio: add documentation for interfacing tools
  docs: iio: add documentation for adis16480 driver

 .../bindings/iio/imu/adi,adis16480.yaml       |   6 +
 Documentation/iio/adis16475.rst               |  23 +-
 Documentation/iio/adis16480.rst               | 445 ++++++++++++++++++
 Documentation/iio/iio_tools.rst               |  27 ++
 Documentation/iio/index.rst                   |   2 +
 drivers/iio/imu/adis16480.c                   | 393 ++++++++++++++--
 6 files changed, 825 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/iio/adis16480.rst
 create mode 100644 Documentation/iio/iio_tools.rst

--
2.34.1


