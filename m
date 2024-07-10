Return-Path: <linux-iio+bounces-7483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82192D1E1
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73B81C2133D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80461922CD;
	Wed, 10 Jul 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="jtYmvQyr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E7190053
	for <linux-iio@vger.kernel.org>; Wed, 10 Jul 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615703; cv=none; b=k55tFMQ0a/5KvNmdtw+52xSpESPYOFZFz/gUG0+QLLEEffkTqtBsS3641+0WYnBxhIKPp27eOzbokuakZEV8d8Gw2qyYvSWY9m1/deYd0ZtPV0FzkMxJze5agGUn0eGKAVOqs4GJsNNuWrjGojTym9MVHHdYepHBKqBwPdQl/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615703; c=relaxed/simple;
	bh=XkKawTXNkr9e35hlksSQXhZj2vU1DccPKsmpkMabL58=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oOcVVgW6PYHXczMIOqOcpS7N08QjMHnIyLD20UR+id3bqF1xDe466rInOd2i95YFuvJ+h+Tc3K5Z5uuM/7H4QNoQ9KRofpIZ3JIZq1Q8suvjygUkIWpWaA45QEqEdM6tov/7O9Bs/oBNC5pOul5pJD7/ofPjJZ5rNWbTVBSMgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=jtYmvQyr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so15285105e9.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jul 2024 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1720615700; x=1721220500; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMjW8+JnhS2tqvpU5m0PS5hMKwILTqlyndwGa+6chdQ=;
        b=jtYmvQyr2rQcN0FIQMRea6cHUEhZ9GuY9g8ICWfdBZb40p7nuHaSAA+2bshtk0CF+L
         TRg9vlTDBRyl/FQx3/eYRZOW+bfvMYJapeSJ/nCb2ObKrKH955iAFyrLg3xYI6a+nt4H
         vC3sjQ2ahnqIEf4y0DSYCsUjzjgHT6deGBoYtf/vqqCELr1ncgKSnVb988DeywFiY4b8
         L++eQCjD5QsMtUar5JFHOkX0nz81NArN9sewVBz/W/e18mZI9gjJlrUKVKCwVt4nQaMb
         q5V/6UcIKFY8Z2T/IebuQ0eE2L83Nd61NOWrD9C946t5SqV4m25cw2+Kvh5/WVNlYDa1
         0LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720615700; x=1721220500;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMjW8+JnhS2tqvpU5m0PS5hMKwILTqlyndwGa+6chdQ=;
        b=YePHG3In51+4y/7KItwS3E+IexhKR5hAwiYljn6UovpPdXfKdy3jTZRwfxHxsACYWM
         rNtax9PTtpFZHMLgop4EknO6jRvL/IRMtAYOjF8if7VeSvXMxYATYUSHGFATIs9I+qO4
         87hyzpRw+XHM2XrFjMRf86BN4ore7B5h9q/wdkvT4exJUb291Q/lOjk/kdve8KNu8eKc
         J57mNONYdu3vMs+L4HvJfSFro/NEwl2gK9Sv4uvJscf2CATahR9Vw7G+BHeKyBUgmlc/
         1sXeWZt8BBGLRpz//6GUOajr22o1X9KFgIG8DhChEpZeKlGpyg6bo7Qr0ASWFeISgL9Z
         /8JQ==
X-Gm-Message-State: AOJu0Yxe1e+XPM0uRirTmfmZORbdIJNLgM/TpVvqFlvE+yTCW0ipa5CY
	AZhDdgtdApp88r7jSE1ii7vRRCEuqrI7T58RX5+zHCdQeEV1HKvcvDhX13/UfL8=
X-Google-Smtp-Source: AGHT+IGU3wyOu70iLnE10WTXbu3WyXPc8YQlpcgIXDdatuUSEXwtQ5cnejqwKz3gdx9JaDg/m+AFtw==
X-Received: by 2002:a05:600c:5753:b0:426:597c:7d4d with SMTP id 5b1f17b1804b1-426707e1f87mr37071165e9.18.1720615700304;
        Wed, 10 Jul 2024 05:48:20 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266ac156easm118051395e9.38.2024.07.10.05.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:48:20 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Subject: [PATCH v2 0/2] iio: humidity: Add support for en21x sensor family
Date: Wed, 10 Jul 2024 13:48:01 +0100
Message-Id: <20240710-ens21x-v2-0-a37c22018b0c@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGDjmYC/yWMywrCMBBFfyXM2kAcn+2vSBe13sZZNNFJlELpv
 zvY1eVcDmehAhUUat1Ciq8UycmAd46GZ58ivDyMiQMfwyU0HqnwfvbXkU+H0JxtQSa/FKPM/9C
 t21jx/livbifd+wI/5GmS2rqaoyJSt64/gX+8uIIAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720615699; l=1341;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=XkKawTXNkr9e35hlksSQXhZj2vU1DccPKsmpkMabL58=;
 b=mhn0nY4RgA6kJ170OA8JMoabc5QWAfWgkoBa5ZQulnsCXH2u0mH01YxNXWl9YS4zZLKiw0MrR
 7TaSrM9Km7MAQPa7I6ZZ41NcjnVFs+xIu9p5W2e0gm+c2/odNdAUks+
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

This patch series adds support for the
ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215 temperature and humidity
sensors.

Patch 1 adds the required device tree bindings.

Patch 2 adds the driver, providing the probe and read functions.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>

changelog v1 -> v2:
sciosense,ens21x.yaml: Add supply to documentation
sciosense,ens21x.yaml: Add fallback to compatible strings
ens21x.c: Move i2c_device_id next to of_device_id
ens21x.c: Use i2c_of_match_device() instead of of_match_device()

Link to V1: https://lore.kernel.org/all/20240709-ens21x-v1-2-678521433cdd@thegoodpenguin.co.uk/

Many thanks for taking the time to review my patch.

Thanks,
Josh

---
Joshua Felmeden (2):
      dt-bindings: iio: humidity: add ENS21x sensor family
      iio: humidity: Add support for ENS21x

 .../bindings/iio/humidity/sciosense,ens21x.yaml    |  55 ++++
 drivers/iio/humidity/Kconfig                       |  11 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/ens21x.c                      | 346 +++++++++++++++++++++
 4 files changed, 413 insertions(+)
---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240709-ens21x-8f2530968f2e

Best regards,
-- 
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>


