Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC23A3DC9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFKINx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:53 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:14489 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKINw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399110; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rJa0CXJtOpSU3lL0pYynb+ui++EASJ1G6AmKy0260etToyFvutnyoZaZF4zUS7uBXh
    J9gcTevKK1Sq6Azox6FB3TwhooJzc0zdsKp7l2OgHWWEZ164timtd/QSjW55nV19pfOd
    MlmoQg5KrjxroDv6EiLOairmLkqtmbHA0j5kwC0a16+pMy1T6GEvCJrIT6HQk4oC8u/U
    YvB40/AExeaNAznJA8nSZ9WQ3CPn74oL+TxrYwfyIUyJ0AEevVVCqpmTciQsIlspVLca
    Dytk4kbaTzwHR+nCm/LCWwJl00YSuwGQmkCLoUFfKqhJpEdTVE52mQKiFn43kZTzSruU
    NntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399109;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XVO1Fa7dnQ7VmFIdDutm31MOJ1IonHZYQtHo+zuFpGo=;
    b=rKUhzoIaxmJBanuFKZUWjGpvtTbekcInLHmty4aYVv7Vh4UVSLeWJ3J7Qy97iJ25TH
    vOa5to0AxURw1BohGZM5yMBeTl5pl9HnGRaK4JT2iWANHqYpCbJ8+Xhr2nZMqNOzowtX
    DxXUH4VSj+ffrGfB1L9wj2SW+RLR0EWIpJHrDA2dbWdfEEVwcZ80cOtefv8peHn2znZI
    KzviYnZqk2goLdSbL+J0kd6elDJZjP4Vkf8372qct3EshMICwo30y7cCLlawJ91sNn6o
    YZJGOAx2fjH9q1BjtACYOHfuWdqT8k3iMwRpcBsW1eKq5Jf5kKMLfXyVWY303rL0Zbya
    qq3w==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399109;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XVO1Fa7dnQ7VmFIdDutm31MOJ1IonHZYQtHo+zuFpGo=;
    b=hzaE7+q1J1josNiE/mHK7Cmt6L8/UInr+uIPhqOjo1jEZqi0dprB9M0BX11v9XQ8Yh
    gpb7/AWMX8qYdZ/xlDTunQk8Ajfuc4DC+Wu74QmXUuvTjkt+KEYA+/NxmMBESXth4SvB
    L5VaO858V8rlVi0aDlUBxuHGUkWplXKjZbl1RgbozB5XDxPZhogmqayO86AzdvcFgBfo
    TkrEIFqad8eLbR1yARrjoqEkYHSwRXq3k8mw7vOcXrh/Bq1F559eY8OiOELNvia4odmS
    92Bc7B9kDMzvIyBYsghBCt3kRiK3wkPLUyhTglpF+cc0mtBHglWmJo8zfYY27GVyhBtV
    wOQw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bn02e
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:49 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 02/10] iio: accel: bmc150: Clarify combo modules in Kconfig
Date:   Fri, 11 Jun 2021 10:08:55 +0200
Message-Id: <20210611080903.14384-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Kconfig option currently says that all Bosch accelerometers
supported by the bmc150-accel driver are combo chips with both
accelerometer and magnetometer. This is wrong: actually only BMC150
is such a combo. The BMA* variants only contain an accelerometer
and the BMI055 actually is a accelerometer + gyroscope combo.

Clarify this in the help text and also make the list of supported
variants complete and sorted for consistency.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
New patch in v3 after discussion in
[PATCH v2 4/9] iio: accel: bmc150: Sort all chip names alphabetically / by chip ID
---
 drivers/iio/accel/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 17f6bdcf1db3..cbca6ab7da88 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -143,9 +143,12 @@ config BMC150_ACCEL
 	select BMC150_ACCEL_SPI if SPI
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
-	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
+	  BMA222, BMA222E, BMA250E, BMA255, BMA280, BMC150, BMI055.
+
+	  Note that some of these are combo modules:
+	    - BMC150: accelerometer and magnetometer
+	    - BMI055: accelerometer and gyroscope
 
-	  This is a combo module with both accelerometer and magnetometer.
 	  This driver is only implementing accelerometer part, which has
 	  its own address and register map.
 
-- 
2.32.0

