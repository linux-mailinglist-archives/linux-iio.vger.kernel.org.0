Return-Path: <linux-iio+bounces-19943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD67BAC3F46
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 14:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAC218880E2
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427E200B8B;
	Mon, 26 May 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Bsk4MkA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73720296D
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748262085; cv=none; b=hGwWRIsWgWN4RYQpeewNnRhpuWkkVGDsq62jqwn+d/Gr3EPw/IDf2rEiVb6idVO3hYzY0Vi/ic8/OORY00OUuHhYlynR2QzxZAIfSBl8qgez4hA9ADXKUs8QDrJpD3+pl2FpgRNfjTyI4FGdl4x5286TAAiyUlntNmmSanJ8V34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748262085; c=relaxed/simple;
	bh=0ngO20W7VIXOPPIpKLH9V0T5vSnlC+XP/HDxogKEcvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzGszkDQzk82JhPbPd1SjcR+1L9RONcYaBjEoC54fJdWnLfea7+9XH6PaamNelsyUJqzIQo10utmF/nMsbjCbq8rxulhq1NzXkQRuuCxyu2VCrmliA0ymhKJWBYLCbUsPhZj1hDj5Nx4V6JKYNbOtvb2B8AnZRicoZrW/+30GGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Bsk4MkA0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso3611814a12.1
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748262081; x=1748866881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTKtxx+v02w/uCQvxtiKHkLQ6WbqMeNJ42C/cOEagi4=;
        b=Bsk4MkA0sOfIaC1ZLPxwhW9B1uEY8d+j0fZJAjLzUZwm/kCS+hnglaEBszbAfgXslP
         in/gibIuW5OXP0lr8WEG4x4QPgopSajeFCpvXREwXqLhQJVvQPWiasoMOEckDvDi3Ryi
         3eLvduSEMvtg+BNZMGIhDcW8Hy6F7BpYXbA55VL6PGt21UyRPrQqLSlP7M3mGzdMSZVO
         4ddTi4XANae7mepb4Xj30xm8hHpCcMiXPyZCB0oHZ/Gi/XpAkR02G6rA3fMtmz4oAjAA
         eZ3NhuQ1BO0xiD+FssUtvLESwRWWwkureqAoM+zBvFMoe0FybxDhzLFR8NkfsNC+KWzP
         6Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748262081; x=1748866881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTKtxx+v02w/uCQvxtiKHkLQ6WbqMeNJ42C/cOEagi4=;
        b=m5JQrU1ekLCXdKb0SijTwo3yutV8qplql/gLabYYPWNfL3NQ7wMmWLIF2d0clISd5b
         hd/AANdsZdRzriXN4xymqoY4zUBe9whaloXZTDHA5F0x5f34epgZaB8yDoUjBzfr6T8k
         26u2kH396DzBpr7yGJk0m5zkviEMTSyd8Q2G1WgJJ9p6jQSmAuf8bS3G1OSOEFunlgtE
         7WzhIW0tyiFmAnDSrAAuUP2KI7bFh3oq7Who0SDr6mUZ2PpyJBBIBXa7IK3vB/VZri72
         k1A3tGgVa9d7ky6VG4In7krNvCTLCdroq/Xt70W6pUVK05m8FTt8+RXYNaBOhLXmzl0n
         aQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXB+5La2jFMk+N5yHX8brJmvwweNMER73U0WGKWo6mEKGMiXgGprAZHHqOe5qBDOO5UAK9PXfsius4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2oK+YUxw7/vCzszbYADXXqY4eVU6G4QkDGJppQaPFdtSTfpz
	S/B01ySw1/JBa742g12auJn+3S2lVYIW5rXocgZI+ca+ZwB88d4Qkf6fSHSJkztRi0I=
X-Gm-Gg: ASbGncup79gRFx/J+9vDZdwiJqhCMqU0+7KmIIYFH3NwCbqWmN3ezWPGfv2Yi2gyBds
	9YmUeqtUuUiU6OLkMugrc4ObYsWyuPnwJR4V9V15jmN3rLLkrUFI5QyVLLBxP8kqjlmQlwbOaSk
	eU3e7boSr2ZIH3bTiDeubrHs2l3zGc5KY/MC94XBCUaA4J+sa6oLCB+lhnpurydOmhoKscfBMUp
	SJqDYHKTe9IzmOg4krJ8FQaV0MFmZhDvZXHsx8JJ8Du6SoAgVa8JB4D94VQgCPa92FkwZw+hv6e
	7LGpzPWvw4raXaQI22DYdY3qq97nZyEhZK6MOmoHGx4YqTbzL9S8GZLbaSL5TEUFIvozwOHtyQz
	UmTAP
X-Google-Smtp-Source: AGHT+IFGyTBXRx1OP1elaikpqfnexAwlKW1XYqDCPwkgr0d6u1X7vnNpG3ig1OaG24SWaOx2VsJBvg==
X-Received: by 2002:a17:907:9812:b0:ac7:3817:d8da with SMTP id a640c23a62f3a-ad85b2121f6mr710370266b.52.1748262080705;
        Mon, 26 May 2025 05:21:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d071c36sm1687630066b.64.2025.05.26.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 05:21:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	ulf.hansson@linaro.org,
	jic23@kernel.org,
	daniel.lezcano@linaro.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 2/2] driver core: platform: Use devm_pm_domain_attach()
Date: Mon, 26 May 2025 15:20:54 +0300
Message-ID: <20250526122054.65532-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
clocks are managed through PM domains. These PM domains, registered on
behalf of the clock controller driver, are configured with
GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
clocks are enabled/disabled using runtime PM APIs. The power domains may
also have power_on/power_off support implemented. After the device PM
domain is powered off any CPU accesses to these domains leads to system
aborts.

During probe, devices are attached to the PM domain controlling their
clocks and power. Similarly, during removal, devices are detached from the
PM domain.

The detachment call stack is as follows:

device_driver_detach() ->
  device_release_driver_internal() ->
    __device_release_driver() ->
      device_remove() ->
        platform_remove() ->
	  dev_pm_domain_detach()

During driver unbind, after the device is detached from its PM domain,
the device_unbind_cleanup() function is called, which subsequently invokes
devres_release_all(). This function handles devres resource cleanup.

If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
cleanup process triggers the action or reset function for disabling runtime
PM. This function is pm_runtime_disable_action(), which leads to the
following call stack of interest when called:

pm_runtime_disable_action() ->
  pm_runtime_dont_use_autosuspend() ->
    __pm_runtime_use_autosuspend() ->
      update_autosuspend() ->
        rpm_idle()

The rpm_idle() function attempts to resume the device at runtime. However,
at the point it is called, the device is no longer part of a PM domain
(which manages clocks and power states). If the driver implements its own
runtime PM APIs for specific functionalities - such as the rzg2l_adc
driver - while also relying on the power domain subsystem for power
management, rpm_idle() will invoke the driver's runtime PM API. However,
since the device is no longer part of a PM domain at this point, the PM
domain's runtime PM APIs will not be called. This leads to system aborts on
Renesas SoCs.

Another identified case is when a subsystem performs various cleanups
using device_unbind_cleanup(), calling driver-specific APIs in the process.
A known example is the thermal subsystem, which may call driver-specific
APIs to disable the thermal device. The relevant call stack in this case
is:

device_driver_detach() ->
  device_release_driver_internal() ->
    device_unbind_cleanup() ->
      devres_release_all() ->
        devm_thermal_of_zone_release() ->
	  thermal_zone_device_disable() ->
	    thermal_zone_device_set_mode() ->
	      struct thermal_zone_device_ops::change_mode()

At the moment the driver-specific change_mode() API is called, the device
is no longer part of its PM domain. Accessing its registers without proper
power management leads to system aborts.

Use devm_pm_domain_attach(). This ensures that driver-specific devm actions
or reset functions are executed in sequence with PM domain attach
action or reset and the driver will not end up runtime resuming the device
when it is not anymore managed by it's PM domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- dropped the devres group open/close approach and use
  devm_pm_domain_attach()
- adjusted patch description to reflect the new approach

 drivers/base/platform.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 075ec1d1b73a..0b2036d4bf4b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1396,15 +1396,12 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, true);
+	ret = devm_pm_domain_attach(_dev, true, true);
 	if (ret)
 		goto out;
 
-	if (drv->probe) {
+	if (drv->probe)
 		ret = drv->probe(dev);
-		if (ret)
-			dev_pm_domain_detach(_dev, true);
-	}
 
 out:
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
@@ -1422,7 +1419,6 @@ static void platform_remove(struct device *_dev)
 
 	if (drv->remove)
 		drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
 }
 
 static void platform_shutdown(struct device *_dev)
-- 
2.43.0


