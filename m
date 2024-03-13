Return-Path: <linux-iio+bounces-3495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7587B2E0
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 21:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D851C2220F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3851C4B;
	Wed, 13 Mar 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oRLgsPtD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A84D108
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361705; cv=none; b=j4zlW2omTtpYNM8W5rauWROvCi5BBgW8Ao3t8DB9McoYQOcR58OdbE1ysNwptW0OSk+Pe18TEzK2T0eOwZjbFk+y19qXNehicVeTdQhtlK5bzI8Krff+w4CXtPvyWH9h3fN6jkPRc0SUc5bt5UHYi6ZZRoblydVc99AZpXpHKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361705; c=relaxed/simple;
	bh=iMCRzKCwtOFIDF9hmdcyBiISQPSwyJVzWj1dCAmbdA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GfNmRWnrIn+j8vu/OarHCxS8oXsQJQMwNuEA1cdZLjpFPxbgHl1sUt3SZOzw/9xpochC3/VDstS1mFEaOCSq88W+VNb1KR3YPtL6nwgb2Dd6ESUcrnpm0e9wo7ORKOLrLUE8rwUOJSXjey+krqvym/Vyk0xj2WHh9/YVE/PF8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oRLgsPtD; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c19e18470aso254169b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710361702; x=1710966502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAWRgWU6WLEXQVBoGzfJEbXOKTd+ZWBJGPDK+Tp7qSI=;
        b=oRLgsPtD1jgq5FFcuvFAyA9vruYinPqt5BIzo5MdfSVG4FqBlNzn+UBg6ucGg53hoD
         pv3uFOzuEbGxX5XjGEZpmKEfQAcwUsE3vFb86la4RwxKLu4rJPqP1NRcS9JaW80ax6CR
         1pCGb7pnf3uJdaL1UmMzF7eGFdbul8sWX0eYcNzjzB+JOTxzX27Fc1YdXZAIKonvDMSW
         2cqGUEAUvEFY82ECMRGmqWw9y5O0esewP4gf4c9OnhtbkK7CxgS1R7zKbZyCe0fM0DaN
         SIbhmV6Rgn22oxztjlRXyRNJUgrD74XHmKnG1eUyKpg2+zJJQlfEq2RNLHBeriW6Mgv0
         kqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361702; x=1710966502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAWRgWU6WLEXQVBoGzfJEbXOKTd+ZWBJGPDK+Tp7qSI=;
        b=KJokLhQYDr9wLcf7e91s2/lEAfLj4we6INB8n/+6I0JCWQoBKClfPHoSVLR2vPjrOG
         tJoQNO1kxzIOelTKV4SaOIfNDJa+SaozrTPTc1zaIFSm0RlDlUkeVx90yP/1GXPK0ysZ
         vSZ4P4HmiwhCcDo/s3vHaz/9VAavH/fiYvXZZ98QGluMyP8+zrLMuiAczzOkRmZ82XnJ
         +ODXdYD8bUOz7Gv+wdqgZmbs5omLBLsKvZ61Z0zFQWm4UkhnP8zeshyWY28yHMfZ1Tne
         YX0PoNlXggXqi9yjnqgM7NNVjSpfzA9YgX1dHeK7slcqGbOs1o8yAQP8wxM4tV8YickH
         cm/A==
X-Forwarded-Encrypted: i=1; AJvYcCUkCRKECudqI2od+aNhVhIhVB+z0TtDyV/UB2Ec12bVMCoHrYsW6kBmJr5WdquCu+Ho2e7H34rPLKLXExSxhhWpJ/GFRx9zqDyc
X-Gm-Message-State: AOJu0YxwejQ5XyDFjGevPDR6u5eIJpIYBDhK1OYM2agRDyLGJzPHKDia
	QkTa+lSi3o8MUkG7rb79+IteYKGOJDj8TOXFg2toOKm8VuklE93wxO8RIK4NeR0=
X-Google-Smtp-Source: AGHT+IEOPc5OEL968XGI9Srb8DwBFMxD/2mugMqwuczh3UoC7IERpmKsonAhCJ+UnsiA3uICMUraLA==
X-Received: by 2002:a05:6808:ecd:b0:3c1:d184:98c9 with SMTP id q13-20020a0568080ecd00b003c1d18498c9mr964366oiv.13.1710361701855;
        Wed, 13 Mar 2024 13:28:21 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id s8-20020a9d58c8000000b006e4eaa4ba7esm21520oth.61.2024.03.13.13.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:28:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] docs: iio: new docs for ad7944 driver
Date: Wed, 13 Mar 2024 15:21:50 -0500
Message-ID: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Adding documentation for the recently applied ad7944 driver.

Note: this also covers the features added in [1] that hasn't been
applied yet.

[1]: https://lore.kernel.org/linux-iio/20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com/

Also updating the MAINTAINERS file to catch iio documentation since this
seems to have been overlooked.

---
David Lechner (2):
      MAINTAINERS: add Documentation/iio/ to IIO subsystem
      docs: iio: new docs for ad7944 driver

 Documentation/iio/ad7944.rst | 227 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   2 +
 3 files changed, 230 insertions(+)
---
base-commit: bbafdb305d6b00934cc09a90ec1bb659d43e5171
change-id: 20240313-mainline-ad7944-doc-285b47ed6d35

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


