Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6934D1164E1
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 02:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLIB76 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 8 Dec 2019 20:59:58 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17883 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfLIB76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Dec 2019 20:59:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575856777; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nx/Z+X629+q2nyX4BFllfyG+e+ORROPqmDFfEU+0loJIHo/ybj1ulm2q9UksTxNqhqZo6BNEIFP6kmLU4gygo2wO8pGCf2EF5boPyXb8WNeL8I3MyeVokbZnfThdybAFs2Z94OH0vOF6SQKccz2gB7jfmbH76qgjRKrzOtD6N5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1575856777; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ESf2SzK4n1rGhfuHWUdei9+0zhGWSY6S3zGH3rZPrs8=; 
        b=AIhBWSIIfoo4jElND5MEI+s6wqQIXy4+ehjMFfewaQLeWdPKmKMWLjO/AE0yCou17o4nVTvunVTrGIjCV/5BGV30YC/nnaWjmqL3e8uiOtxJiAz9f1r7XM7AJsF3s4YmRRNmhGegHrrkDuhyJMPGqmuc1dcMWC4unQ/IjPlO3go=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1575856775769662.3246858379019; Sun, 8 Dec 2019 17:59:35 -0800 (PST)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191209014320.13149-1-dan@dlrobertson.com>
Subject: [PATCH v5 0/2] iio: add driver for Bosch BMA400 accelerometer
Date:   Mon,  9 Dec 2019 01:43:18 +0000
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds a IIO driver for the Bosch BMA400 3-axes ultra low-power
accelerometer. The initial implementation of the driver adds read support for
the acceleration and temperature data registers. The driver also has support
for reading and writing to the output data rate, oversampling ratio, and scale
configuration registers.

The major update in this patchset version is the move from using tables
to convert user input to/from the raw register value to using a
function.

Tests run:
 - Various tests with libiio and i2c-dev
 - dtbs_check and dt_binding_check

Thanks again for the reviews of patches v4! If I missed anything please
let me know.

Cheers,

 - Dan


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

 .../bindings/iio/accel/bosch,bma400.yaml      |  39 +
 drivers/iio/accel/Kconfig                     |  16 +
 drivers/iio/accel/Makefile                    |   2 +
 drivers/iio/accel/bma400.h                    |  95 ++
 drivers/iio/accel/bma400_core.c               | 823 ++++++++++++++++++
 drivers/iio/accel/bma400_i2c.c                |  62 ++
 6 files changed, 1037 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c



