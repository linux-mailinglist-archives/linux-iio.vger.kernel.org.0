Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8238922044C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 07:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgGOFUL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 15 Jul 2020 01:20:11 -0400
Received: from sender4-op-o17.zoho.com ([136.143.188.17]:17760 "EHLO
        sender4-op-o17.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgGOFUK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 01:20:10 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 01:20:10 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1594789485; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KdRRlQ+15J8uDwpSj4pNh/LA/2TyU2Tszx3tld3gHUgYKqW/pr94eV/jQwmiI/oVgC511Dk9uACePqufH2d4u6Cc0DqQedmZXSKMsJ78C4doQ33AxC6oOI+ocfHRy57SwpvJbkxY8+Alk5IjKcudqLB4jgOGdZOWYV6dWaJNvI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1594789485; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Efbn+VN3vKueL5xqB7yCI8LQZ6zrgJA8fkqb7ejQDZk=; 
        b=GEnxiD9GXiUgzMhUQhGU/Uv+/ZnVHRm8m9InMFGU3w0CthXteAbsiTuzvpKbxd4zPViA5lsHLaT5hCrFkdQ6PIxybyViJBR/t/gVK4rB3wnjK6JJoPp1F83MqoUQ12DgZSXzOIJ2/F//4FTWPq8c+6tCqxvokAzyzEL+j/pujEE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-108-28-30-30.washdc.fios.verizon.net [108.28.30.30]) by mx.zohomail.com
        with SMTPS id 1594789483923610.7887498258865; Tue, 14 Jul 2020 22:04:43 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20200715050226.9751-1-dan@dlrobertson.com>
Subject: [PATCH 0/1] iio: accel: bma400: add PM_SLEEP support
Date:   Wed, 15 Jul 2020 01:02:25 -0400
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following patch adds support for PM_SLEEP. I also added an attribute
for manually setting the power mode similar to what the BMA180 driver
provides. Feedback on this would be appreciated.

Cheers,

 - Dan

Dan Robertson (1):
  iio: accel: bma400: add PM_SLEEP support

 drivers/iio/accel/bma400.h      |   3 +
 drivers/iio/accel/bma400_core.c | 132 ++++++++++++++++++++++++--------
 drivers/iio/accel/bma400_i2c.c  |   1 +
 drivers/iio/accel/bma400_spi.c  |   1 +
 4 files changed, 107 insertions(+), 30 deletions(-)


