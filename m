Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDA73A28D6
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJJ6b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 05:58:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:24844 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFJJ6a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 05:58:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623318983; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BK2XE32b28bl151qJ6mYts1F00gLkmy+z4Ympu1F5sKNmu0XSUi6Srov8Fb3LOGHvk
    M5ywrwYYG0Do8fXK7Lw3cpuss+T1oLUGluuMsQGpJ+8uvdg/Xv5/lAZz/2ydWEJ4Za5Q
    EojfYUL7++AxUAwLlGx8a1Xf1q0ApmGPkuCR7EoCGp6ExtTt3qWUybbdVS4xWvGaBcN0
    Pvu22R0MNMoEtrHMMP24kGVY5kdrD6aJ5BPVuIPH82IVvUoiTjXnp/tOQl9+unVYvspa
    4gMRAcBOmMj9xVbXR7D4Y+OH4CSP9Yka3qGu5AdMlMnyDjaLaAhoh/ciIU6gKfLjXOd6
    QWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318983;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=35NIel78eJ6G304Slr2xsLh5uFAOMCogIOGC0WBN7LQ=;
    b=YO+WPCGm9tXoQTyyl1m3y5MmkB3e3a9snv35OW9z1h/0zEdV2TUnXINNgSPLwaTAWG
    0m9OPM1yAomGL5LaAYsmLVHIQcpzCBf6EK/62A3Eo2D99jlkhnPEPLVszrrUJCqqyLN6
    jGFkxRys8g0AqocYjzKuSLEsiXHDX2xR+NP9+yVxUwQOuACII2lDq6XoJonk/1oFqKK1
    uAoJAOiCJ0CN+UN8tYx/90chWDNKZdpcIaqUzw9oy3A7YinJIGXuMh7LKEDJB+Oee1p0
    pDont4m2bVdz4nrjgtzQqscOqk4G6fc9R8lSTMIefpqqEbtDTkEeOXu+9Zdp8I0R69yx
    x2KQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623318983;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=35NIel78eJ6G304Slr2xsLh5uFAOMCogIOGC0WBN7LQ=;
    b=GJR/xn9WTlnHGNx1gR69ABWiuObYUGFv6hSXOH92yJIB8DtEm5rCLTL8wLYWHfnX4S
    R34v8digJLIKuAA+aEF3XW1ZeF66vm7LiAjvexb+kTojtkqIG4IdnUgRD2NuKPHcWW5K
    ZJbNqzoSCDu7rXwCpGsA8dJk0CsWZlupvFeLK+b2m/uHdzEDt/k95h1I6AXIXVsXDRCw
    5OItHGoGWR1SAKKu0VkFA2TT8nKN0LVfQEmr3JUfnhTTdkooPVA5PUbUuXNSaere5Z8z
    vd7Vqi5U6ajNGjDNN4i9MydVjEOkVcE9ZcCMH/JPQXWdojiYa98RY/gQsvjFVcvG9Az0
    xJ0A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5A9uNsny
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 11:56:23 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Laurentiu Palcu <laurentiu.palcu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/6] iio: accel: bmc150: Add support for BMA253/BMA254
Date:   Thu, 10 Jun 2021 11:52:54 +0200
Message-Id: <20210610095300.3613-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Bosch BMA253 accelerometer is very similar to both BMA254 and BMA255.
The current situation is very confusing: BMA254 is supported by the bma180
driver, but BMA255 is supported by the bmc150-accel driver.

It turns out the bma180 and bmc150-accel drivers have quite some overlap,
and BMA253/BMA254 would be a bit better supported in bmc150
(which has support for the motion trigger/interrupt).

This series adds BMA253 support to bmc150-accel and also moves BMA254
over to bmc150, removing some unnecessary code from the bma180 driver.

I asked Linus Walleij to test these patches on BMA254 a while ago
and he suggested that I already add his Reviewed-by.

Stephan Gerhold (6):
  iio: accel: bmc150: Drop misleading/duplicate chip identifiers
  dt-bindings: iio: accel: bma255: Document bosch,bma253
  iio: accel: bmc150: Add device IDs for BMA253
  dt-bindings: iio: bma255: Allow multiple interrupts
  dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
  iio: accel: bma180/bmc150: Move BMA254 to bmc150-accel driver

 .../bindings/iio/accel/bosch,bma180.yaml      |  3 +-
 .../bindings/iio/accel/bosch,bma255.yaml      |  9 +-
 drivers/iio/accel/Kconfig                     |  6 +-
 drivers/iio/accel/bma180.c                    | 91 +++----------------
 drivers/iio/accel/bmc150-accel-core.c         | 36 ++------
 drivers/iio/accel/bmc150-accel-i2c.c          | 34 ++++---
 drivers/iio/accel/bmc150-accel-spi.c          | 31 ++++---
 drivers/iio/accel/bmc150-accel.h              | 10 --
 8 files changed, 67 insertions(+), 153 deletions(-)

-- 
2.31.1

