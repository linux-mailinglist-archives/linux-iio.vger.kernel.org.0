Return-Path: <linux-iio+bounces-5327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D48D04E9
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3B028ADAE
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF25E172BC4;
	Mon, 27 May 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9346zTe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC0171660;
	Mon, 27 May 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819987; cv=none; b=ebj/RR/PrukfBUtxYCwQihz2OFQS4ydcaLF9frcq9EvzXLvI1oZncLshQZbA95seoSIfgeAyWqI/kjpXYAikA0NIO1c1MIdJzvi4UhwiGmRSf1jPok3YK4fzwn1ukQwdLi68zFy76/xnoqpH1NHEwy7xr5RsFb9LK7taeg5HoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819987; c=relaxed/simple;
	bh=CfLh9yu54xuTSwlbf9xMLzFnPHFmKJW9PS9bvEukrAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q1qb2Rr+ITthtxxSGoTh8gfFpehYeQH9XJ0+omLSgmgyYkSHovzhjjFgrnl2rzPtcg35Wgu7goNIEg7pbl1kw66M4xf7HnYE6djr5ENBECVUdPQah3Qg6jlsoYQz6h9VOJzdJHHJtyuRcJWNWwUfvINF7BQmiIGiJB4z24wW97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9346zTe; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295f012748so3686094e87.1;
        Mon, 27 May 2024 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819984; x=1717424784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rk4/vnQZ81wjUO4Em5QwJ+7FetQF6/nmn1oakCi33wg=;
        b=m9346zTeTEu9OVZca01hweNTgXqw95kl1ORfCalGgBtY12qVJFglyZHTD+PvWBtO1s
         TCf3ms3g998t8JMq34cdfzC2bFICRhytpV9r5mv3jltSTjKSarjymNBQhYCFdChAjKXK
         xQVYlrLr8UqQuk7WSelLk86+ZIvMBhvPk4sxP59VTQfSgieH/SECSeHJDhHS74XcaiZ3
         j8yLHBjCFoNKXv5OxwTA6yzZBlKq5Tf7/HcPbm5OCkZMwO8L78WAyfnKcLGI59I3Y1tx
         gXiZnYU8IptbLUFkMJ7jw/UnLbBGDRwryZaks+OanjJin5Fek8DbVFwDE78JLwkmshi5
         s5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819984; x=1717424784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rk4/vnQZ81wjUO4Em5QwJ+7FetQF6/nmn1oakCi33wg=;
        b=Hbbusj8Dziu2CnTjDsIVo+HEPOxLOGzzUgdQ4kxsiD7IKjEL5XQxuMNWCvdHtjOT1o
         F5RrduayoXssFm+EojSGyicv9L8s+vsUdHWazq3b0F5oJ+iWWYRXQhtwIYqBUFSyNM+v
         weWsbkhTrDXOpAd3ipiNIK+y3RGUytQdQKIS+cW9WEViMhFHj0T/4daxPGTnjmcuEWr6
         Q0CbxP8r29U+AJTW7JcY9Mh9abq0Rf1B/U2J2+IDkjB6dy6HDRoJ8IvNNgzgkBetSPF+
         0k9aZAcWlYXW5Pb2bhzLJw9grVLJPKVWVwvZDscQbBjvbngzh3KCciA+XOV5OG8m0y7b
         iePA==
X-Forwarded-Encrypted: i=1; AJvYcCUBmRYJM78mFCLwe4dbwbv1Bc0L42RCzx1bUqFv7G6ebmr/ohwM9Vlpy+qYt3kVUlL7gpvFg8kxppFSGHgyz4z3GjZAKhyErprbIKWxXqjAT9p9HbYR/+aygVyaCRaA23egatdxlQ==
X-Gm-Message-State: AOJu0YzdvhslMzP9rxUJV7YBVVLPXxuP1d06ksrnita9ti8O9LdzYEKS
	4JeDyDeU/uWkwPV58keWcPDa6cPAVcsEKYGQQpbnAM2/QdU/dVC//cMHadJ/Px4=
X-Google-Smtp-Source: AGHT+IH9aeVp4nH4rJ8R5xTCubFecyNbrZ4z7lTqCru+xj6DucdB6UUebshpKC+AjuP0+S43uco8yQ==
X-Received: by 2002:a05:6512:94b:b0:51d:d4e8:c71c with SMTP id 2adb3069b0e04-5296556f23amr5575585e87.36.1716819983682;
        Mon, 27 May 2024 07:26:23 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:23 -0700 (PDT)
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
Subject: [PATCH v5 0/9] adis16501 and adis1657x support
Date: Mon, 27 May 2024 17:26:09 +0300
Message-Id: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add adis16501 and adis1657x support in adis16475.

Ramona Gradinariu (9):
  dt-bindings: iio: imu: Add ADIS16501 compatibles
  drivers: iio: imu: Add support for ADIS16501
  iio: imu: adis_buffer: Add buffer setup API with buffer attributes
  iio: imu: adis16475: Create push single sample API
  drivers: iio: imu: adis16475: generic computation for sample rate
  iio: imu: adis_trigger: Allow level interrupts for FIFO readings
  iio: imu: adis16475: Re-define ADIS16475_DATA
  dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
  drivers: iio: imu: Add support for adis1657x family

 .../bindings/iio/imu/adi,adis16475.yaml       |  31 +
 drivers/iio/imu/Kconfig                       |   4 +-
 drivers/iio/imu/adis16475.c                   | 807 +++++++++++++++---
 drivers/iio/imu/adis_buffer.c                 |  32 +-
 drivers/iio/imu/adis_trigger.c                |  37 +-
 include/linux/iio/imu/adis.h                  |  21 +-
 6 files changed, 792 insertions(+), 140 deletions(-)

--
2.34.1


