Return-Path: <linux-iio+bounces-4875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F155E8BFE0F
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE2C285C8D
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CA6BFB3;
	Wed,  8 May 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug0M6oM+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9224C618;
	Wed,  8 May 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173997; cv=none; b=uCQgsTkXwW/NtddI9VsvQezk/qOCsNgi3+1ce0ZKs315MRfRawVK7k2LXaHgRPLNTV6JWiI/yth3XlsRF4Qw9PjHlI1f/6mIhG+RlMgvJFlThi9N7Ji3lqwE1Ydk+V59W3jizV04WIJQIv0B8TLUvd0aCyvDmQ591gLuabCHPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173997; c=relaxed/simple;
	bh=s4+jwxvucCgGq4o9hy5KJX4OlFghxV95VWecVFpPVl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=roM+wjx1/s/cqTwfeXLtF8B0+BW9BjF3IgGm9AaEPXUrpLrIMESWQKhNh5HSJvw4S19fyn8vMy9rtgyCqRzH1TvwhAAv0xrmCWcH/wKquLNCj1G/hCKuQUtJuT5TAMz9XJGu0VTScDD0LyU/b5mlggmnyJ+lM/UiUdcYwyW+UVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug0M6oM+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41b782405d5so44631225e9.2;
        Wed, 08 May 2024 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715173993; x=1715778793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3LX4u8uNCRFKMn2gAI3NJNCZjckbbpgXxZwbEiNE7c=;
        b=Ug0M6oM+ruaPIYeLHt1LPlNm/32Gj3OTzimhkve6MlG0OPJIFzA20t0CQByPZohXit
         Ob38I0lMqmMHChZjIojsq+7TOtdVxzxMDLPtbcPPnn9Z6t5JbtSqD4XESCiOwBJR6T58
         NVOzcUQ7dCSqAv6O+6sudOaQZap9IhVjEZUuJKLkVllKOXLMW6NoY4rpiEE1gKnLz5Fe
         3Zsrgx7Prc3Hu1tuZk5GLVWWjHxrKwr11TZTKjnn91ZXn11Uxb0T4x+nWRdtn5Ca5Mop
         JOtCi5A9BX+9epGAS2IsyMRTZSObI9PWwQ6wDWGOl5KRA3Jx6oxAE8IhS1z6/QAdSyYV
         im7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715173993; x=1715778793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3LX4u8uNCRFKMn2gAI3NJNCZjckbbpgXxZwbEiNE7c=;
        b=hSs4HnkiS/Y7T1v+Wk2/je5Gj0+t2uR7iVem279Ry9V5Lkr/mJbkTgxxwtl5bUnjSN
         zo+QiLni+DLkqPTFGuQn+gn1qSYJP11SK0JjPXk0jfJolqUiW1fqP5A/QKGrLZc50iqw
         PwqkBiFZf5cuHtbwsp+kDo9l7jER60Uk0fnJnZfB296mNhBAChcvs5yNIaLM9cIhPmRy
         Yt7JfRiQY7D0eJP+zzYFB0scK85mRH+Fe9n8oBRDkoTjCjE9Kc/zCmEfW0Qhs6g9nXZc
         eYO2tFj28/6yJO5QVjd8sRcl9qjUVZ43AeHJrF5PfKz3waCfIKqkfwh7HfX0bx0KuYPm
         oPVw==
X-Forwarded-Encrypted: i=1; AJvYcCVa4DUt/sQQonnGpgyAsT4AVxaZe/6ErkBK5f+h45Ghtz5aaWk6ITGDXc3zx6U4i+9xTTjGcnH/GvP8ih9ftzswEzEZt3+ysxLrT/xpY1MZEkaYhWKDymf9y8IKyWU5ka8uyAiV3Q==
X-Gm-Message-State: AOJu0YwARdWJOIdVkqcZzqG5SupLCMbDkaeaNyt8J4ZdLdv/9NQetzkY
	gD4zgrIYqqg1ezFJMaDKBglEYGWCBwJ3ZY/dBxD5bLmqIjonxmnYm9Dbj/ut1CI=
X-Google-Smtp-Source: AGHT+IFVbnWe69hthLsmbdk4AqLyqzR/JiDNfVgJh1l9VgKkIvJDR25ngeNkbJlu2iz0/A4rK19cPQ==
X-Received: by 2002:a05:600c:1f81:b0:419:a3f:f4f6 with SMTP id 5b1f17b1804b1-41f71302dbdmr22590485e9.8.1715173993226;
        Wed, 08 May 2024 06:13:13 -0700 (PDT)
Received: from rbolboac.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm22848365e9.29.2024.05.08.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:13:12 -0700 (PDT)
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
Subject: [PATCH v2 0/8] adis16501 and adis1657x support
Date: Wed,  8 May 2024 16:13:02 +0300
Message-Id: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add adis16501 and adis1657x support in adis16475.

Ramona Gradinariu (8):
  dt-bindings: iio: imu: Add ADIS16501 compatibles
  drivers: iio: imu: Add support for ADIS16501
  iio: imu: adis16475: Re-define ADIS16475_DATA
  iio: imu: adis_buffer: Add buffer setup API with buffer attributes
  iio: imu: adis16475: Create push single sample API
  drivers: iio: imu: adis16475: generic computation for sample rate
  dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
  drivers: iio: imu: Add support for adis1657x family

 .../bindings/iio/imu/adi,adis16475.yaml       |  31 +
 drivers/iio/imu/Kconfig                       |   4 +-
 drivers/iio/imu/adis16475.c                   | 712 ++++++++++++++++--
 drivers/iio/imu/adis_buffer.c                 |  32 +-
 include/linux/iio/imu/adis.h                  |  18 +-
 5 files changed, 694 insertions(+), 103 deletions(-)

--
2.34.1


