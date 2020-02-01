Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC914F944
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2020 19:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgBASAw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Feb 2020 13:00:52 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:53938 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgBASAw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Feb 2020 13:00:52 -0500
Received: from localhost.localdomain (silversquare.silversquare.eu [185.174.184.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 280B3251DC;
        Sat,  1 Feb 2020 19:00:49 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH v3 0/7] iio: light: AL3010 introduction
Date:   Sat,  1 Feb 2020 19:00:17 +0100
Message-Id: <20200201180024.328700-1-david@ixit.cz>
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

 .../devicetree/bindings/iio/light/al3010.yaml |  45 ++++
 .../bindings/iio/light/al3320a.yaml           |  45 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/al3010.c                    | 237 ++++++++++++++++++
 drivers/iio/light/al3320a.c                   |  63 +++--
 7 files changed, 389 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml
 create mode 100644 drivers/iio/light/al3010.c

-- 
2.25.0

