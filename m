Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4626914B4E8
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1Nb1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 08:31:27 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:38982 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgA1Nb1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 08:31:27 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 70F5F251E0;
        Tue, 28 Jan 2020 14:31:23 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/7] iio: light: AL3010 introduction
Date:   Tue, 28 Jan 2020 14:30:45 +0100
Message-Id: <20200128133052.201587-1-david@ixit.cz>
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

David Heidelberg (7):
  dt-bindings: iio: light: add support for Dyna-Image AL3320A
  dt-bindings: iio: light: add support for Dyna-Image AL3010
  iio: light: al3320a slightly improve code formatting
  iio: light: add Dyna-Image AL3010 driver
  iio: light: al3010 implement suspend support
  iio: light: al3320a implement suspend support
  iio: light: al3320a allow module autoload and polish

 .../devicetree/bindings/iio/light/al3010.yaml |  40 +++
 .../bindings/iio/light/al3320a.yaml           |  40 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/al3010.c                    | 237 ++++++++++++++++++
 drivers/iio/light/al3320a.c                   |  63 +++--
 7 files changed, 379 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml
 create mode 100644 drivers/iio/light/al3010.c

-- 
2.25.0

