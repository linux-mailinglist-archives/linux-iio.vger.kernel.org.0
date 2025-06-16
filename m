Return-Path: <linux-iio+bounces-20714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCDAADB2C0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74557A2D5B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F112EBDFF;
	Mon, 16 Jun 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mJs5kc8D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6A2DBF5C
	for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082052; cv=none; b=nbCyvW3ZhfDQRhp5Uq4n9aYbNaf96hYv3JHBkn47JO8A4HeFTWP9Gle/cuvyNuBKtrjPu4ghaNh7/m01YfT5z6sMqJfHsK3gQ00RO86OTuxann2+f7fBHbnvlN0b1cmzIQhGCx6op+HGWFbGg0GBjA3/OIWfh9P6Mbm7ymfLb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082052; c=relaxed/simple;
	bh=KPy0qoeJ/cuWg3FcjfVl4wS9jR9Yuixd3J4F+C/TP+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNwAngikDL+yYPZ6EZ8w16hQYxgDnjnnYWshdSn/CKDZ2iaOGV8dTV96D3lFnVW7GUJ8Nfwuy0eWHo0xhd5o/L72MQKyKQpKEN2JMaO8PxxcerHa3ucXViJ54ckadzs7OjoEZyMLg3hjmosm5Pl0y6uECxkxl4J7yp+KKnvwTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mJs5kc8D; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad89ee255easo835258066b.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1750082048; x=1750686848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+LFH2EJZ/euycVAsLwJhPX7xP3RrLri+PWxKx7UufA=;
        b=mJs5kc8DGArf70tD7LKTbk2Ch48YO19BuG6jqGQLEKfPMUgBoELXMEnEu8Fa3syHrh
         H/9ZVlHsa7iTsefFDIdNsb4vPKHD/HwM0pjuNoC/h5lj8sNKMwOgliOryxvY7/jNPyvp
         ASflURqaqPVoGKw/rFQ17bue4hvqJGMundVBTFM+5+XN16fe8EZgDAtAh1/Bsn812eOD
         CqtRKG/FlSInBHaGHRL2nBJjoahuvEmpkQRC2JESossWbJXfWyiZav/0NJ1kLe2rZ6sI
         sH5VUbV2vdI7i4CSTko3v0p2ur78t/BHfsJ74QpTGcvXr/507HnnSlwLWByQ+NHYli03
         xdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082048; x=1750686848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+LFH2EJZ/euycVAsLwJhPX7xP3RrLri+PWxKx7UufA=;
        b=nl6LFNtraMpbHnoxzl02WuKZsFlITShZZ2Nb2NUHBnqWyMBiuaBd5GqALkIop+9M18
         LidTg5cgosTVEWhPi0N15sDIMB/4/QrBSkXjBK8nSI2B46E3b7x/l4d7Uu+0M2tG/CTT
         wT1tBXHMgyIN5k3wDi8jTBdgSVm47pUqGJOpEqMp4gsi2/0Gg5QDxoH7W7mMjmCmiNj+
         LBKpa3dAYVlTjn4UgpIlejvklEoekFDPeq3TxgQPt179aoSf/KA0Zler/1YAqLBkNQVY
         ++7kZnuZjVyeiKuOmGpJU3KotVLKwCh5HvDVRbSZH8GYt7z2uI1qV6aUcS687GnTdyLS
         Yr/w==
X-Forwarded-Encrypted: i=1; AJvYcCWfkxWd3sGgqX9bRh8TpJqNCX3O6QSjMSWMKdKqdF53y5PJlbSY8KOO8fXXuRCvve0Ow/VjMIm2YVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDuxnv2UpZ0JqA72V6uIF6wkAkN83mUSRkeGSWvsh3PMHVsc7
	MCl1No2cllI6PSKhp9gZ08R5LVPsWXB+AwxmBHozLiVGd9X4hF81bunBPX3mHibZtvo=
X-Gm-Gg: ASbGncsWklOTuVgq8Sas03LzsDVfGvb5xuURMpLbaWXld+JdcLMxJPpRFy5CtlxtNF9
	ilTo4xNppD2uUkVhhfM7ZlxeqKCYI86lZs+JJKCfGZZ2xrQxcm4bXal6MCtyYR3Y8aNU55rU8QO
	ss9KwHHhOriy8OvYkmSG3EdoL7fGo3c9sSmXCgNuW0PbNrBg6Ei/DTqUC+ea69JfjxAR4NOsTud
	uzohzLm1JojGGbL/rYuG0rdrmMq9AFejzpBSO1sRzjQsFh9KT72XbaBzl84rrxw8jNmnjKOY8as
	uWTCAPUKBsjBd8pqamCREWuFHP+qncIkizumgnskONpjMWSdXoGCI3JPWd3oceA6MWAutvqMymL
	MaO/4YVQR3bfGZ0KmCnDTwUQN1KY=
X-Google-Smtp-Source: AGHT+IGkfVytZQOP8rOyQhNTtUZWr9IH2eDQVY0gZwL9P8IewAvv89wj+c+jpi7sVu7bmVbj99zUhQ==
X-Received: by 2002:a17:907:94cb:b0:ad4:d9b2:6ee4 with SMTP id a640c23a62f3a-adfad65f792mr840462566b.49.1750082048005;
        Mon, 16 Jun 2025 06:54:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec897a70bsm662748966b.154.2025.06.16.06.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:54:07 -0700 (PDT)
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
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 2/2] driver core: platform: Drop dev_pm_domain_detach() call
Date: Mon, 16 Jun 2025 16:53:57 +0300
Message-ID: <20250616135357.3929441-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
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

Drop the call to dev_pm_domain_detach() from the platform bus remove
function and rely on the newly introduced call in device_unbind_cleanup().
This ensures the same effect, but the call now occurs after all
driver-specific devres resources have been freed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- dropped devm_pm_domain_attach() approach
- adjusted patch description to reflect this

Changes in v3:
- adjusted the call to devm_pm_domain_attach() as it now gets
  2 parameters

Changes in v2:
- dropped the devres group open/close approach and use
  devm_pm_domain_attach()
- adjusted patch description to reflect the new approach

 drivers/base/platform.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 075ec1d1b73a..2459be6aecf4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1400,11 +1400,8 @@ static int platform_probe(struct device *_dev)
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


