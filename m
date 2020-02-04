Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F981517DF
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 10:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgBDJck (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 04:32:40 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:49220 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgBDJck (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Feb 2020 04:32:40 -0500
Received: from localhost.localdomain (126.212-243-81.adsl-dyn.isp.belgacom.be [81.243.212.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A1F2C251E7;
        Tue,  4 Feb 2020 10:32:04 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org
Subject: [PATCH v4 0/7] AL3010 introduction
Date:   Tue,  4 Feb 2020 10:30:25 +0100
Message-Id: <20200204093031.616409-1-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These patches implement support for simple iio light sensor AL3010 and
also improves and align formating of AL3320a which is origin of al3010
driver.

AL3010 is used in many devices, mostly tegra2/3 based.
This effort is aimed for reducing number of out-of-tree patches for
tegra tablets and phones.

This sensor is tested on Nexus 7 (2012, grouper/tilapia).

v4
 - incorporated previously proposed changes

David Heidelberg (7):
  dt-bindings: iio: light: add support for Dyna-Image AL3320A
  dt-bindings: iio: light: add support for Dyna-Image AL3010
  iio: light: al3320a slightly improve code formatting
  iio: light: add Dyna-Image AL3010 driver
  iio: light: al3320a implement suspend support
  iio: light: al3320a implement devm_add_action_or_reset
  iio: light: al3320a allow module autoload and polish

 .../devicetree/bindings/iio/light/al3010.yaml |  45 ++++
 .../bindings/iio/light/al3320a.yaml           |  45 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/al3010.c                    | 240 ++++++++++++++++++
 drivers/iio/light/al3320a.c                   |  72 ++++--
 7 files changed, 398 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml
 create mode 100644 drivers/iio/light/al3010.c

-- 
2.25.0

