Return-Path: <linux-iio+bounces-6207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E679054E2
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42BB1C20E6E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350C17DE1E;
	Wed, 12 Jun 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un9XR3un"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F24537F8;
	Wed, 12 Jun 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201831; cv=none; b=urEZOwY4Qrvr00N6Z/2lSN1Z5MBQwY3zajCd7EAsqXB2SNBDBwB2tCZsRSMYdgRH/WoFCbVrcPjRo+lJEHTZxvUAuc/q8EhORP9Awg9bi9KLTZnQY5pbONINlobt76RKh6wbABbgNpjhwvv4Ult2drdgbGLsXflPysYm+Xk/B90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201831; c=relaxed/simple;
	bh=qbIPRYnyZGhF7xViW68hm4SHaRMwBauK1+ojB+XEcwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZQA+PI+ZodlExt5q5xzVIbPlA6+bJuI5t7BN0mwWhXqm7z5dKqP6bu0dV3QbW66wyLTdhLWov8JseyJ7bBelZfwRbioRf05AY4J1lnC4HEpElY+muMz1EvjjWCSqjFVtT/gd75bVStNB81+Mz1nNFtz0Tjf/gvc6bgEurq8xG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un9XR3un; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e72224c395so22628611fa.3;
        Wed, 12 Jun 2024 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718201828; x=1718806628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=spyLnB7qZ3YQPzkCd6Fxx3pPcQHJ/lEc1AThjKTsvPM=;
        b=Un9XR3un0StTvINPeNlt/ed0mSGA2KmqQqNwrdgZO/OxfgSIbyU8NKr2L7F44OD30F
         4infKm2iqNi0tGvaFk/IY9bN/+CbgtyQFmd9YQbRiMjQiQ/7TbjXL7ibeI+n5aNoFtl/
         i8sZicL6Ej6hB040qy5cKA/Te8KeAy6mHFgEwRCqehvBPT4BQQyE6DUt+zSiS+j/16Ud
         7ZfO2r/cmlua4N5Xdj4x6d7m2PMDnJJY/Ib32WyaOz8J2LlZ3T6dga26VQxiZUeA0Mlf
         RXw/sED697fJ+Y2p4Hc14pFA+IE2acRrf9D10BfU4ccntFGyhkd7c0N2FkecnikO7GbO
         QnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201828; x=1718806628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spyLnB7qZ3YQPzkCd6Fxx3pPcQHJ/lEc1AThjKTsvPM=;
        b=Ayr5nKWixBXu+LfWS4s9ACsGv1HLivSkKVza3E8aojEMOom5TzJNXbd7EJ5jnsMw0H
         hthDF96Swzj3fCe/w/h+hwCJZR9x/d01u44y0vtbDJNEup+h5d6pE7VEFhhCjmdqrcHK
         xhKjJ6jFGKuWgcmKjLF+E8dw/1ndUbZIc++q4ofaM6+dIpS7zz9unuO2EY7o4anFMo4t
         h674EpSO3y4jDPw+1xWRKNK12KZprggdYZ8PuHPSEZZHDZg9OHuEdJNAv/RI1r9lqa3G
         uH2hqpljgVATEQkvcno1QhwqBGitXwKxRMUeC3IugyCjiamXk0z6WZDUeg7HNWeFcg2O
         3bDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbAfE5DOXfd8tCkcFfO7Pf7UpIshPO6UBMn8AZjbxfH4hCEXGArNPbXIfCTa+DGQ9Ch/OqRzYWQV+lQV7F7gAAPSkCe8rhG/NMDYJR6wHZ00wpV07OHQ1x/WkEzbR8G6UFHzxTqdZgAfsjsnO74+7LlK0rG2yLM9RMIfWe7udNHkVVBg==
X-Gm-Message-State: AOJu0Yyhw3hs8zdA66aEySwsxYkA06dG7GL2RkgxGtgrY1+xpGkJpjK/
	y7MFYx5j+OOw4YLSD5FCGesF6+2anr3koe//oj+/9TTYv2tT8aKp
X-Google-Smtp-Source: AGHT+IE8rB2Uo89G98SAm8buwFxQVgCiqk8FRbd59f7SxkuOyJXgrRp/2ihXz/Ys91n8zYSKO3Z+VA==
X-Received: by 2002:a2e:854f:0:b0:2eb:dbc6:da84 with SMTP id 38308e7fff4ca-2ebfc949a21mr12145791fa.53.1718201827662;
        Wed, 12 Jun 2024 07:17:07 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75ebsm27876655e9.9.2024.06.12.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:17:07 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 0/2] iio: adc: ad7192: Fix clock config
Date: Wed, 12 Jun 2024 17:16:35 +0300
Message-Id: <20240612141637.175709-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Thank you very much for your feedback!

Here is the series of only fixes. I will create another series for the
other patches.

King regards,
Alisa-Dariana Roman.

v2 -> v3
  - remove clean up patch
  - remove clk provider part
  - keep name mclk
  - organize in function ad7192_clock_setup
  - change commit messages accordingly



