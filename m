Return-Path: <linux-iio+bounces-453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E87FB8D1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 12:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34613B21967
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7554649F92;
	Tue, 28 Nov 2023 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="W2Trhb0J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06DA1B4
	for <linux-iio@vger.kernel.org>; Tue, 28 Nov 2023 03:02:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a02cc476581so716061966b.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Nov 2023 03:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701169331; x=1701774131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlZ7iRVbsbRidcAsAmtD7uKZxC1LTM8QUx5hPAqk8yg=;
        b=W2Trhb0JSVRC4Id5dnhE6AaKDRq/+PwC2mTMKfTcKwLmc8/W99ODvGQ4A+JrHZwZxs
         LSx/d+M/mjiM/QSwDQCeFYOywRW5ODXqeWAXzEqYFhp6iuzas5lUUCzZYM6eIJIb0Uoh
         2ssG1fib4MVVtq7S6eXqW1u9IQgLykrMw7LrxreACwxIKT46zdaIeawdqsUajkEPobwB
         nxq0QSAjef1FONMUKZJecjnXNvCs7kGGgzCmEPVQg69QYmBJFHKz+xg9XStKCGOjnUeG
         OXBRtjyz08Z8rJUxwKl/NQj7kHJyLXnxMRjIJKRQQstkR+sZSzEsrKFQdomwJmm6wXlt
         xd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169331; x=1701774131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlZ7iRVbsbRidcAsAmtD7uKZxC1LTM8QUx5hPAqk8yg=;
        b=Q+oPYz/StM7wOWIR2W6/1Gwq0oEqHfcAvm+sXOYeD3VmRqKxm66AUKm3+ZGCX7rNxU
         Pns2tS5IW19F9wwtxpbJhxkZhEv/E5AGmCSz2jwYU9BaCz7IfX0xxXIEjKNPAT5//odb
         I2hPP14nNPCgU04V6p1RP9Zwc/e/wJAfNghvbv+XEuk8x534FBD30feCRIUVNGoFWtk1
         Oza91ppl3EV/LYepdsIDNNX1yivkJDz9DXoRA0UgwiEsJIVePoEvLLRlTDLlQfsQbb1x
         3oCTmUQLqcSVrOOYriZWC+aWzMeO3uL2OjO5zOoX9M/82/1uJ9gcriw8KbGpkrm9eZdi
         gOLw==
X-Gm-Message-State: AOJu0YyF5GjOZf650D65fNRyEbPGa7X3A6fJ0VZz7gDcS9tmfOkLlMkW
	d4/P8Qih3CAwqWlVFYFzjIleYb1tOjhLOX/WwTU=
X-Google-Smtp-Source: AGHT+IFUj+xpwnpY3qS1pNq5O+DvIQpTB85bW2X9Y3htbbDBUWs40lSNUrXAQgbY77iHKyKck0o3ow==
X-Received: by 2002:a17:906:209e:b0:a0a:f9af:c159 with SMTP id 30-20020a170906209e00b00a0af9afc159mr8796679ejq.25.1701169331054;
        Tue, 28 Nov 2023 03:02:11 -0800 (PST)
Received: from localhost.localdomain (d54C3956F.access.telenet.be. [84.195.149.111])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906111900b00a0435148ed7sm6784897eja.17.2023.11.28.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:02:10 -0800 (PST)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 0/2] iio: temperature: mlx90635 Driver for MLX90635 IR temperature sensor
Date: Tue, 28 Nov 2023 11:59:22 +0100
Message-Id: <cover.1701168726.git.cmo@melexis.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everybody,

There is a new contactless sensor in Melexis portfolio. MLX90635 is just
1.8x1.8mm in size, but with factory calibration offers instant usage
in every project. It offers wide refresh rate range that is configurable
between 100ms and 4s.

Driver currently provides temperature calculations, power management and
changes to the refresh rate. Since sensor is aimed towards the consumer
market there is really low number of EEPROM write cycles available, so
driver changes refresh rate only in run time registers to avoid writing
to EEPROM. Reading EEPROM is not available in Sleep Step mode, so I am
using caching at the driver initialization to ensure that measurements
can still be taken in Sleep Step mode.

Changes v1 -> v2:
  - dt-bindings are now enum according to the comments from
    Krzysztof Kozlowski
  - expand the path recipient list for the patches using
    get_maintainers.pl
  - driver cache and probe (and some style) adjusted according to
    comments from Jonathan Cameron
  - improve DSP version detection (make it clearer)

Crt Mori (2):
  iio: temperature: mlx90635 MLX90635 IR Temperature sensor
  dt-bindings: iio: temperature: add MLX90635 device

 .../iio/temperature/melexis,mlx90632.yaml     |   19 +-
 MAINTAINERS                                   |    7 +
 drivers/iio/temperature/Kconfig               |   12 +
 drivers/iio/temperature/Makefile              |    1 +
 drivers/iio/temperature/mlx90635.c            | 1071 +++++++++++++++++
 5 files changed, 1108 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/temperature/mlx90635.c

-- 
2.40.1


