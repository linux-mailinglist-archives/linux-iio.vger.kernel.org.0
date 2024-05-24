Return-Path: <linux-iio+bounces-5250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3261A8CE2BA
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A91C211B9
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3961292F8;
	Fri, 24 May 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8TFXnfQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862891D54D;
	Fri, 24 May 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541242; cv=none; b=cAJRhSisbJrX/oOBii5T2PXdJosDlJg28/AsT6sAU7Na/un76OmdpdQhXjBJMk3l3QbhxAnUirq+2bWqn6eRWafoDuuUAprVT/Y1ASuab35tm5n5YIdpC3JA1SMQi+oshI/tOhNKWxBYMt3btYwu2nz5jCUJbAVWJnxxQAQc1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541242; c=relaxed/simple;
	bh=Ndc1ZOTSc3HE60JBg1s0bP8GySv9wslKlje95u3jiOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DG8AhllXehQQ0WltukHruatJx4ThexMpheY+PrYQZX8UXxCIJ9LGowLiBKcpAhwSw+K47tqjnhbBafejfhzN42focQPZrceuqeMnGsFy0kGlFE8KlKFXThLxKkn8mLRRnzHhm8Nq2Bz7jKpmbL6ZyfLpsk+wF4KC8YoJqx2+lYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8TFXnfQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57851788450so852138a12.2;
        Fri, 24 May 2024 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541238; x=1717146038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAjoDwv+nuxA5R+xwHfwe17PEr8mDnmdJPuKHL0+yys=;
        b=f8TFXnfQRKTl7ietflyhvJ87fdTvqgr3uiFxf0qONNXrafgY5it6bTwe1chdrGuiBj
         lpSASd8efjciORQsjojY0PrCS7CQ2N65ASh0z1C8peoQ2bgVQ9JMO12JcqGIi/iweODX
         AaAegqQ+rISXm0Wjg5hcatooSK163wVSH+mbctvt3oQtldB1VLh1c/eKww313Vt/GNa8
         6NhvlPVYuCwBMO7brxU+pKpatMfOcx4mefCffOgaGFNWbgMLtZNhcFe7UQA1EcznFHi4
         ujhUiK202b3b8RQcH23pMdm2O5f6OEz7v/2p2jAZJpuKQ/h3rL86kO8gWeDyuVY0jTX2
         Pc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541238; x=1717146038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAjoDwv+nuxA5R+xwHfwe17PEr8mDnmdJPuKHL0+yys=;
        b=AmhEiydgUPKvi80S/EDbmqgWHHQQK88xZpMIKOGQss38rs/xxXdIRHrDZbzPo6wUL6
         hZmQZday93LjVEgByNQ4Bvr+fzeQvFmGxXqQ/gwzCC3v0qUx57ox9TGrtWuAVjN6xD7k
         uXsJeroItpuSJvzD1ggPsnciXtOFlft4ENTwxCzyji7RLHWdlG68BXbq45pi113wBT5t
         43C3gXw/EaTiDFW/ZczAUNzksY5a/qoe71hNS8v/bMlWXSK28MX+ufCgYHbqdLgmYmC+
         cqmELw4qsbJ13AZvncLqk3Cq4nAcZhHY9l66S7tIyLdxkTd4mJDFD1OlE4BCXGQGZc4E
         b4wA==
X-Forwarded-Encrypted: i=1; AJvYcCVxpz4odRTBez61HrksQJ419V+vt46E83vWCF5qnk4viSx9awM25SCNF4w6kDdYRyCi1XOmnwsd7P+J/SICoWkF/k1kJFu1lnQKl/85S+6WaepHBrhYUIetCW8hnzIUMV5HlhGZ/g==
X-Gm-Message-State: AOJu0Yxks+o4IqSwHKPuMZNZSJ4I5m3eDhlNwXg8DBnrHrXS0pkLRWjQ
	v5MgYNaVr8Ose4Zrt7nYskjrAPUM3pkkteCHf379eSvUDgJdNKXboCEMont2jWU=
X-Google-Smtp-Source: AGHT+IFIHJ5yG0dlv43AcToWv7U3z1W6V+gd7KJL85LgZHIHN2D/RfHCRkuNzETZAikxYg2vWubBeQ==
X-Received: by 2002:a17:906:478c:b0:a59:cdc9:6fdf with SMTP id a640c23a62f3a-a62641c4376mr115375866b.4.1716541238040;
        Fri, 24 May 2024 02:00:38 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:37 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v4 00/10] adis16501 and adis1657x support
Date: Fri, 24 May 2024 12:00:21 +0300
Message-Id: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add adis16501 and adis1657x support in adis16475.

Ramona Gradinariu (10):
  dt-bindings: iio: imu: Add ADIS16501 compatibles
  drivers: iio: imu: Add support for ADIS16501
  iio: imu: adis16475: Re-define ADIS16475_DATA
  iio: imu: adis_buffer: Add buffer setup API with buffer attributes
  iio: imu: adis16475: Create push single sample API
  drivers: iio: imu: adis16475: generic computation for sample rate
  iio: imu: adis_trigger: Allow level interrupts for FIFO readings
  iio: imu: adis16475: Re-define ADIS16475_DATA
  dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
  drivers: iio: imu: Add support for adis1657x family

 .../bindings/iio/imu/adi,adis16475.yaml       |  31 +
 drivers/iio/imu/Kconfig                       |   4 +-
 drivers/iio/imu/adis16475.c                   | 810 +++++++++++++++---
 drivers/iio/imu/adis_buffer.c                 |  32 +-
 drivers/iio/imu/adis_trigger.c                |  37 +-
 include/linux/iio/imu/adis.h                  |  20 +-
 6 files changed, 792 insertions(+), 142 deletions(-)

--
2.34.1


