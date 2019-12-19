Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA66125A3F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 05:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLSE1D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 18 Dec 2019 23:27:03 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17185 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfLSE1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 23:27:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576729605; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Bfvipe28iSjA/0DHsIfMGyD/9/Y64CSVOTmOHlqrvtzoDisrpqy1g0xGSX0WnSeQnTx1pN/p12ph8wqrxUylcY7YAKOeCK6ybAqpWG2nZbwzg/6V3p9WbdA8BiDHw61/+uni245EI4XwLV+Iqs3L7aooX1fM54wbB3c/lNlTXTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576729605; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=duNU73H4R5uWGP6GXL35vUT6rH5cyahfRVcoHH9IXpM=; 
        b=NpS4vX8QfkIhnLNHdkt1lNo52uRnYXVwOB96sFo/X+w1T3W82wz1OsgJlxqEr+mFxZnNQsSzEVoNM/uK4MtYdxeoJke/Ya5gOFrhslTccljbm5w2ugUdGMPlFUCXSl+v6T00Dnu/64hgom+aSB5VZ10WjXBIkK+Hx+vsy0CHw+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576729604446982.8922166091726; Wed, 18 Dec 2019 20:26:44 -0800 (PST)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191219041039.23396-1-dan@dlrobertson.com>
Subject: [PATCH v7 0/3] iio: add driver for Bosch BMA400 accelerometer
Date:   Thu, 19 Dec 2019 04:10:36 +0000
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I added basic support for the vdd and vddio regulators in this patchset
version. I also added a MAINTAINERS entry for this driver as I do plan
to submit some follow-up patchsets and I'd like to stay up to date on
changes others make to this driver. If this is not the right time to
add this or if there is a better way, please let me know.

Cheers,

 - Dan

Changes in v7:

 * Added MAINTAINERS entry
 * Added basic vddio and vdd regulator support
 * Added vddio and vdd supply to devicetree bindings
 * Added interrupts to devicetree bindings

Changes in v6:

 * Improve readability Kconfig options

Changes in v5:

 * Move to using a function instead of lookup tables for scale and
   frequency conversions.
 * Rename DT bindings to bosch,bma400.yaml
 * Fixed other errors and improvements found by reviewers

Changes in v4:

 * Fix error in DT bindings
 * Fix typo when setting the OSR
 * Simplified the cached sample frequency
 * Fix the MODULE_LICENSE

Changes in v3:

 * Use yaml format for DT bindings
 * Remove strict dependency on OF
 * Tidy Kconfig dependencies
 * Stylistic changes
 * Do not soft-reset device on remove

Changes in v2:

 * Implemented iio_info -> read_avail
 * Stylistic changes
 * Implemented devicetree bindings


Dan Robertson (2):
  dt-bindings: iio: accel: bma400: add bindings
  iio: (bma400) add driver for the BMA400

Dan Robertson (3):
  dt-bindings: iio: accel: bma400: add bindings
  iio: (bma400) add driver for the BMA400
  iio: (bma400) basic regulator support

 .../bindings/iio/accel/bosch,bma400.yaml      |  54 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/accel/Kconfig                     |  17 +
 drivers/iio/accel/Makefile                    |   2 +
 drivers/iio/accel/bma400.h                    |  95 ++
 drivers/iio/accel/bma400_core.c               | 860 ++++++++++++++++++
 drivers/iio/accel/bma400_i2c.c                |  62 ++
 7 files changed, 1097 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c



