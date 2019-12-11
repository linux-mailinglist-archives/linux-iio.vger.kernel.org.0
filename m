Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9CA11A063
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 02:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfLKBUQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 10 Dec 2019 20:20:16 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17164 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLKBUP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 20:20:15 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576027194; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nBC/a8KgwAEFS8owKJPJteNGwqKKpZ9l/pwkdpn0hYabhMF2sWdKEU7AtMAzjtXy863uwAZBHDt7RiA/UIT8Cad4imwinPXuhx1JY0kg63LRmGGBLI6pLZottID3rigiZ7x4n0Px9MttjiMt2VGL4BiFzVYNE1MZdUPiPzKuCTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576027194; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=DuYLWfyJP9Xff1OS3yX3DZJn48FedLL4mZAzGQCoZrE=; 
        b=Wwyh+DhfYltvYfBZy2eveO0P5AYDvNf2uwNfLH6TkoyLY/a2eb6vNxnlFByCfW6xj+Db5r6swJyx+gQ8WI5maDG+uNf4zvYLPA/NfCk9LSTyQ5kEIDOWn09r8QqNvOLM+Xh0mDugnjBXK+XgjTefW3XHZezS/we7Y1dviFfqu/I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 157602719391847.389218584379364; Tue, 10 Dec 2019 17:19:53 -0800 (PST)
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
Message-ID: <20191211010308.1525-1-dan@dlrobertson.com>
Subject: [PATCH v6 0/2] iio: add driver for Bosch BMA400 accelerometer
Date:   Wed, 11 Dec 2019 01:03:06 +0000
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Only update from the last patchset are the changes to the Kconfig
options.

Cheers,

 - Dan


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



