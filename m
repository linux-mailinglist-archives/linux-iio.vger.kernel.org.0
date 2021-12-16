Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB24C477BF9
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhLPSw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 13:52:27 -0500
Received: from www381.your-server.de ([78.46.137.84]:47640 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhLPSwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=yd63Uuar7R9bVhU6VBQ6acM6BrVP2cx0ml6/ZCjWJkI=; b=UqRaLFU4VigRm2geGI9fSM/07j
        csNtW/eKkZxi40sOZ4dxv63mlTT7q0ybt4+Ho7Ta4xd5we6SHi5vn1Jn4gu7YjoOrpj72Wp/p8fMs
        0T1NaeKhlyOVxVF40wwx4xNNaRFGWtWg6FljUEkh68saSRBdCRsLm30T25VgHSpkNxPzCPhdpdJ99
        HfmxXJ3Cunwms2Pup3br9zJioWPSLisyFa1TWF9Z+4OuB8D/QmjXxiVOGgFS61vFvjWTCvcJ2Q7d8
        b/0JtARydDce+7DN+K0zlWgji0IFv9DJko2kVBdu8FSFmZNylPx+EqOxmmZRJoXM4srlUrwIVSKLZ
        kcZuS1Yw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000ARv-01; Thu, 16 Dec 2021 19:52:22 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrZ-000HSt-LE; Thu, 16 Dec 2021 19:52:21 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/13] iio: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:04 +0100
Message-Id: <20211216185217.1054495-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26389/Thu Dec 16 07:02:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I started the sysfs_emit() conversion during the last end-of-year break
starting with the IIO core. It is end-of-year break again, so here is a bit
more.

This series contains conversions for simple users which all follow the
pattern of `return sprintf(....)` or similar. The series also only covers
cases where the attributes are completely custom and can not be converted
to use iio_read_raw or iio_read_available. These other cases will be
handled seperately by converting them to use the IIO APIs rather than
device attributes. But this requires a bit more validation work than the
simple straigh forward conversions.

Lars-Peter Clausen (13):
  iio: core: Use sysfs_emit()
  iio: dmaengine-buffer: Use sysfs_emit()
  iio: ad7192: Use sysfs_emit()
  iio: ad9523: Use sysfs_emit()
  iio: as3935: Use sysfs_emit()
  iio: ina2xx-adc: sysfs_emit()
  iio: lm3533: Use sysfs_emit()
  iio: max31856: Use sysfs_emit()
  iio: max31865: Use sysfs_emit()
  iio: max9611: Use sysfs_emit()
  iio: ms_sensors: Use sysfs_emit()
  iio: scd4x: Use sysfs_emit()
  iio: sps30: Use sysfs_emit()

 drivers/iio/adc/ad7192.c                           | 4 ++--
 drivers/iio/adc/ina2xx-adc.c                       | 2 +-
 drivers/iio/adc/max9611.c                          | 2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 +-
 drivers/iio/chemical/scd4x.c                       | 2 +-
 drivers/iio/chemical/sps30.c                       | 2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     | 4 ++--
 drivers/iio/frequency/ad9523.c                     | 2 +-
 drivers/iio/industrialio-buffer.c                  | 4 ++--
 drivers/iio/industrialio-core.c                    | 2 +-
 drivers/iio/light/lm3533-als.c                     | 6 +++---
 drivers/iio/proximity/as3935.c                     | 4 ++--
 drivers/iio/temperature/max31856.c                 | 4 ++--
 drivers/iio/temperature/max31865.c                 | 4 ++--
 14 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.30.2

