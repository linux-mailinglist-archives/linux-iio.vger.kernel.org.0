Return-Path: <linux-iio+bounces-17722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013EAA7D59D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C8E3BF090
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 07:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44F22A7EC;
	Mon,  7 Apr 2025 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0EQnU2HO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41222A4E9
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010296; cv=none; b=CoEwpG2WM3rnH77PN2mFHZWMIe/si2L2LAm6B9ZcLsdpQPBgVHHUqKtJBvGk5YfWyAjU3kqqY1bX/DwCUqFlXnICy7RqPbap0xJan4Kr9MaD4z4IcJWi7+nM0oY4LAqE8yuK+ybBP10t3zOBSvVb1VRTpQf4hGsWXGxuhhEY1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010296; c=relaxed/simple;
	bh=AxvTgPG/08SVbPx+P2b7i+Lqy2PqiHtAE+nknCQ9/HA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AEvryy91tSAEpMewI5EDKLIO83z14fTUuX3rs70+Q685BTzkkWiak/F2RJw6cyGEov5diGQX1Yardh1xbujbgkSbMStX8HTRgJ1igo1kHrsbvZwq5BAPtPbC5o1p2opgvZw8VO5iJjOsKDxu7Z1lRPxI9JrDK9c+emyh4f00W7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0EQnU2HO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso2232637f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744010293; x=1744615093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cc1N6pLgiIuAchfND5sDfdbE3yslYziafjrXEdXiVw4=;
        b=0EQnU2HOzGJ7qX8rKr7LgeBkidOX/Ker53VpxdMUGFWv9B23TYkkPNJFHQas7hfa1F
         9bs30S8PmeykXy+0UES5px2TBsZ2AG92GJWpHvYbU5wSkcwgLIubYL3Ke4iXJtE2258s
         D/EkwLrFK6TM+nJ48s3DAIM3GAhDqyItt1LlGe8Z4xUPFmWEQFQllPtn3taQw6JmdP6J
         j4t6Z8njJkwngmb1cuU6eRAA8H/w/Fwm4m9PS+EfDc+IX4jfbyvso2kVTyaxmltEi3tB
         Coy35TeNIcAEDxv1EFGlZijqkCUWwptH5nhmdUnz6XRrfyMAyY7LPtI9VETlASpxeShR
         NbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744010293; x=1744615093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc1N6pLgiIuAchfND5sDfdbE3yslYziafjrXEdXiVw4=;
        b=hjZKLg5ae0EM1SkjZePRvnCRnlpRU1SNwy3YwZpaM0WFJ6kKbls1r/lvG0oTboiY37
         +WIAyrVcKgFmZ+OGpUeIr7iHAMDghA0U8ZmtHp9ke/D2EGh3uFopkt3UxU8EHC7UV5Ep
         5lhYOFsJ2MZmFKhe5a16FDQvSkX0J3Q014OrBBqRW4IZMPKcSMMyeqsrfSP4QwstcSTl
         aEWPVrmJ8qnpx9MjiDRM3KfbYwiaa8Ol2wJRQU+8zA2BUjfbeNvq9dr818SkHzN/+/Ld
         kDZRF++7uSDKMtr/aJE7azW/oQsNYZ4R+KZQ1lvqs2Z2q3A3M6U+wth7jM4dr0UWa0bb
         Wnkg==
X-Gm-Message-State: AOJu0YyDr6aLhP0Rv1vmqjodnl9njOWGetTB3WbIUliVSchr9+wcPyuA
	qSMYxV/fnmSqKbIn04rbwFbszax8MMInA9tV82Vrd2spJAIP2o3zC0P+3nrAA0o=
X-Gm-Gg: ASbGncs7AMjLwnmi24sKwT26QAy29o6zOJXn5f4l8jMYyL2OY7rUbbTMEeR4jdpyBHo
	PJP4ipOUaYgp1U3lmIqCKoAVldDT+hx/0qzcVMmJZxD2Qk6YQwRMCOASyqS1tiD8QqbkBMumok5
	iijFeGhvEKKD7XAk7EymkEc16/4HgcobQbRff5gSfwm6bp8dagVVFopkpdVgufO+WDZ3Gq8VC3R
	+qKurAruCxkhPq9JDIRNOy/Ewt1UnGVmV/4vS18og6+/2yxH+ze4733ZA2pMP5t2QwHlkWdCtXD
	/RBlqUiyfPv9+6mHm+6SiER78ByETsmggHAy7hYwdy+2DWe0
X-Google-Smtp-Source: AGHT+IHCWOO0RTjiSPCdhaAdwwAHJp08f52xwZ0fQJ2PMKUV5lH+ZzCTORm7kAFQ3aUAQ3rCpIsWuQ==
X-Received: by 2002:a05:6000:2403:b0:391:9b2:f48d with SMTP id ffacd0b85a97d-39cb35a9bf5mr10149672f8f.33.1744010292920;
        Mon, 07 Apr 2025 00:18:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8c64:734d:705a:39a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630f21sm125224455e9.8.2025.04.07.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:18:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/7] iio: convert GPIO chips to using new value setters
Date: Mon, 07 Apr 2025 09:18:08 +0200
Message-Id: <20250407-gpiochip-set-rv-iio-v1-0-8431b003a145@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADB882cC/x3MQQ5AMBBG4avIrE3SUoSriAU1+DfatNJIxN01l
 t/ivYeiBEikoXgoSEKEOzN0WZA95nMXxppNlaoaZZTm3cPZA56jXBwSA44X1Rorpu56vVIufZA
 N938dp/f9ALfLZGRlAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=AxvTgPG/08SVbPx+P2b7i+Lqy2PqiHtAE+nknCQ9/HA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn83wyiF9eNcG9pcYjFYXO0nvnqmICDBdUhsLGF
 tiCIVJqOKOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/N8MgAKCRARpy6gFHHX
 cr01D/9cBNJG8dIVi5vVhhGlLzoHYUpOqFtbUbaQ5D/RgpGGyaPBptye2CxDZ4rXCs0BxFL7Joi
 9D6ZZgQX+7AIY8sHuBmMgGUL1Hi5kBq/JKE2RdI9wZAGn+7z/eGGzJgpcvzlGkH8S5N2HnY3d7D
 OgOyfjkd0CFmRUTwd5Y1r1nP/RoNE63WosR/RTbBbs1C2emRU8McPxg6sz0fy4UbYhZil7RGybt
 V8Px+Wpjn+f1YcsSKWLcP6hv1uPI9Luze5QMDK+GejkztK0Bgz5X6Kw2dXJQw7EN5dzN62fIgp6
 MXZG511YXRFxmU0P+9M26/Z0Enx+/7MXQEZYAz05nNGeDi0mj6hUMTnVovAITuUJAmpkLMVywV3
 El3bnX9Y2KoQkZ7LunbVGuWOP63jsdq1rk5+DqUbSo/AFySfD+6LgibaFiGn31ZUtJ/QbXK7qxT
 CohpiPpx65Ki6vc9y/8qHaOt0lOCMVwyVcJrXbz0jsoTe+Q10kVri2DxbNVgc/VcQAd9n/eqk9m
 jjt54ZA2Ehq3+ybllfeybfr3xiRtkp6ZpVxSvQngz+U57KSDZ24O3QPObQIwNmGUecRacSnXBQP
 62YwsaBYqIeZrezcMohXGilqH03MXeVnEt2mCoJfOVAZUg97/5590ulnDagNJukCb2SaPSsd5qT
 sbCmCjMoDLrg1Vw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. We're in the process of
converting all GPIO drivers to using the new API. This series converts
all the IIO GPIO controllers and also contains some additional
refactoring patches for ad5592r in preparation for the conversion.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (7):
      iio: dac: ad5592r: destroy mutexes in detach paths
      iio: dac: ad5592r: use lock guards
      iio: dac: ad5592r: use new GPIO line value setter callbacks
      iio: adc: ti-ads7950: use new GPIO line value setter callbacks
      iio: adc: ad4130: use new GPIO line value setter callbacks
      iio: addac: ad74413r: use new GPIO line value setter callbacks
      iio: addac: ad74115: use new GPIO line value setter callbacks

 drivers/iio/adc/ad4130.c       |  10 ++--
 drivers/iio/adc/ti-ads7950.c   |  17 ++++--
 drivers/iio/addac/ad74115.c    |  18 +++---
 drivers/iio/addac/ad74413r.c   |  28 ++++-----
 drivers/iio/dac/ad5592r-base.c | 132 +++++++++++++++++------------------------
 5 files changed, 95 insertions(+), 110 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250401-gpiochip-set-rv-iio-b064ce43791d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


