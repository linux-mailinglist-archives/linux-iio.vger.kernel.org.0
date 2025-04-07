Return-Path: <linux-iio+bounces-17734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB7A7D89F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18353B6215
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842A228CB7;
	Mon,  7 Apr 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e9x+mz3k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656721D011
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016009; cv=none; b=jkde1n6q5ZpdvKjUtccUZUbfIxM/aoPwX/+2Yl1GabxUlCvq3P99SVMRLcIQTSlJlDo5vHFQme6Th1i104kfWYgbGqpQWy2y5DwvimIxCihXA14EcKZmcFi7gOMcAT9Mlw2xfHEMlkeGfrUlwh9kC/klqY+XBfBhPqgkGL6XP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016009; c=relaxed/simple;
	bh=QPHh8N4sbhjKwZMK7xvZJUBdpo9mG11VcIyhWlrXKk4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QhQjV3jRS3HS51QD8vRk++ZzEdI/amJzcaefCJEQ9Rq8Y0SZ1CBRnTfx11ImYVO3g47c7YDVPwdKM9az/kIhn1DPTj0L0HnRqfnyxoR4n73mc0TSfHVf9OvwO0/FKZ3TNPxSSG9ftHScCbxS0bJHFWxzb3wEG+FBGJYa7U4+WOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e9x+mz3k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so45786595e9.3
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744016004; x=1744620804; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTlY5GezUXHh/ytz6WGIA1+pAcc+7slCnrxJejlItUg=;
        b=e9x+mz3kS2BVS1g38LWAYaOk64I2SwhrjW3oJPWUAnNZtVAAgLSHTkNLJKvLKdS2IU
         gMvH8qYALfNxLjvyRIRZmUEwv2FqNJ+706Q2dlhFqRBqByu1L20eLzQvEzT9endtKFzu
         g8150BrjrpFPFbRU3U42s58mvqrjnBAkIZ7zSsHmuc3bVjnfQwypurHm+4hjYiiTIT95
         JuZ4/ADSHhPzSrQ3pViOztJDoTmnsktxHAvws8ciAxoVAW2y+sbq4/9QvaHzEYjbmEsd
         g4Fr39Hd1+83PWplQur/P3Oky+Vnz/cokRniFCYN3xvXQMNTZwda8Ye2rA4l2peXbBOg
         aYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016004; x=1744620804;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTlY5GezUXHh/ytz6WGIA1+pAcc+7slCnrxJejlItUg=;
        b=sRJNnWPPOK99+0oDojYmsG8iKMFH9z+tSpuRmj2wFOd8fkqYhgV4tTWll8rJIF55FF
         KbcjRo2WK/rVfjX+xrHG+BX4X7xagfi0/qaI9wPXbFkj0VKrOq6RFpKHdgt3OnSYMfZO
         yxy70NxsJYqYPVbb2XPGEQcuXHN3eR2LKQ8YCZY0KGVA45UxqNH8F4Whtx+A3lZTRkYW
         5N0BN0rQPDMyFy3odPNPnwdKZQ5D6rMhu8NMpu42IyHFJQLI5BmpiatpWGWWI9oLIkB2
         qmbt13WqNPgej4Ni2Qe3U3HRnPun8IQxuaRznKuQJMI4PR+ecwY+p6p5jTACMrtgTZ83
         cqDA==
X-Gm-Message-State: AOJu0Yz02WedZPj0mMLYtUmpwyW2OyASqrNr43kK44vi/3zDuYAlbR4a
	tDXWfOCY11A54Tac9U68ECpvTzrNda49KxDvqi0Xb/67FCDu31HJE7GEo6n9CrywwOOnwVNg1lW
	m
X-Gm-Gg: ASbGnctH5CONGiPgvxUH9Fv8rRqpP+4kk7EFuPOhpFvqwlCV2dwedu3+c7DcHanSLoh
	W4l5HEZyyjaqQzOYyyyc2AkVxWl+O4mBieggWEs7rchdWp6wfJrVCe4FqzNkmoVKdyEV7Ifav/8
	1utPbO/Ya84/kmVFWRJFHMsA/bkzNDjdAkl69ggNYbtXUYZL90HL5Vw2eGM8s0B6No5sO6Ln5+z
	SbrYq/5/LuRf/UBtwKCSf5m164mQD7T+yOiqVu30ln9IJl1fkMStvb3bgB3abdWXeWYh/I19vXp
	HgRpOXUsM6pi+yRWLRNctH07ur1F7oinQ5WMzblvUpY8ikWHx3sAQGeKctW0UMAmxtYJaseLS7N
	Gh9ykiiinNB9UP67VBgNUFQ==
X-Google-Smtp-Source: AGHT+IGDheRzEIDWvy9jJjVetSnf3JmgBhH88wP2OMBcuwCzAIlUjPSEuV2XkMUSvUT2xeOCmyTN3g==
X-Received: by 2002:a7b:cb42:0:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-43edf4581d1mr45012985e9.33.1744016004661;
        Mon, 07 Apr 2025 01:53:24 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3174cf0sm126966995e9.0.2025.04.07.01.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:53:24 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v3 0/5] iio: ad3552r-hs: add support for internal ramp
 generator
Date: Mon, 07 Apr 2025 10:52:02 +0200
Message-Id: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADKS82cC/4XNTQ6CMBAF4KuQrh3TdgqIK+9hXPRnlCYIpDVVQ
 ri7hZUxMS7fm7xvZhYpeIrsWMwsUPLRD30OuCuYbXV/I/AuZya5LDlKAU8/gulAOyxLGeDqXxR
 BaTxUjVJW1Jzl6RhoO+Tl+ZJz6+NjCNP2JYm1/QMmARzQCq2lapyo8GT01HkTaG+HO1vNJD8c/
 OXI7FhHzijkqqnpy1mW5Q2hu+TnAwEAAA==
X-Change-ID: 20250321-wip-bl-ad3552r-fixes-4a386944c170
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=QPHh8N4sbhjKwZMK7xvZJUBdpo9mG11VcIyhWlrXKk4=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/PMn6s0PTYdHJSzQMT5X2HVmyLGTdNxX17+46TRWOz
 je37l63uqOUhUGMi0FWTJGlLjHCJPR2qJTyAsbZMHNYmUCGMHBxCsBEzBwZGaaeZQzKdMqf8ClV
 JEGvZgbz/7ijyXvb76/RkJvapGEk1MbIMONgjRiL7cZXbeY5PQXXeOvMzyWn2/ZHWXkffpxVmtH
 MDQA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Add support to enable the HDL IP core internal ramp generator,
actually managed by the adi-axi-dac backend. 

It works this way:

/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage0_en 
/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage1_en                                           
/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/enable 

Activating ramp generator:

/sys/kernel/debug/iio/iio:device0# echo -n backend-ramp-generator > data_source

Deactivating:

/sys/kernel/debug/iio/iio:device0# echo -n iio-buffer > data_source

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v3:
- add mutex description,
- use devm_mutex_init and check for return value.
- Link to v2: https://lore.kernel.org/r/20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com

Changes in v2:
- doc, add few words for generic spi driver version,
- axi-dac, add a separate patch to check cntrl chan validity,
- axi-dac, return EIO on a wrong source on get, 
- add a lock on debugfs file access,
- use const strings and strlen on file access.
- Link to v1: https://lore.kernel.org/r/20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com

---
Angelo Dureghello (5):
      iio: dac: adi-axi-dac: add cntrl chan check
      docs: iio: add documentation for ad3552r driver
      iio: backend: add support for data source get
      iio: dac: adi-axi-dac: add data source get
      iio: dac: ad3552r-hs: add support for internal ramp

 Documentation/iio/ad3552r.rst      |  72 +++++++++++++++++++++
 Documentation/iio/index.rst        |   1 +
 MAINTAINERS                        |   1 +
 drivers/iio/dac/ad3552r-hs.c       | 124 +++++++++++++++++++++++++++++++++++--
 drivers/iio/dac/adi-axi-dac.c      |  54 ++++++++++++++++
 drivers/iio/industrialio-backend.c |  28 +++++++++
 include/linux/iio/backend.h        |   5 ++
 7 files changed, 279 insertions(+), 6 deletions(-)
---
base-commit: eb870a5af7db1e5ca59330875125230b28e630f9
change-id: 20250321-wip-bl-ad3552r-fixes-4a386944c170

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


