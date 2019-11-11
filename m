Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FABF77C6
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 16:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKKPfd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 10:35:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38130 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKKPfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 10:35:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so13652672wmk.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 07:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eHez3LVmY8wN8QMpZrIYxG6vJAf8iO7ChZMvarMrIp8=;
        b=n6VjNkTwftoRiLgnpc7NZ7GzA9334q8NArLP7iLmup0M2mR2CH9Lfs5H/J1AbHRy4o
         QTk9Cf1vsSJpiUvHObPJiuHH2Q9YaZCqg2447n35eAzhHiT9lfkL6BfUph8GxaoSU78e
         6/Gd7Rzjzmgz1ViVUSj82HLebkteoLGKkGxpXiulRnfxojONPyIB9LHexSfpgFcu6U0o
         4FpUY2I2VScd/sccAxOkQHHtpvrecXn0PxJhVTiuz7yX9gnwclu6Ksq0VNX0C1XWZLNQ
         IhK7hVEv3ebU2jueaBm2JoTVigiUcuPbbB3vC/6++FsL25ingc9TQN8VLRRXv2m7syc2
         Kipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eHez3LVmY8wN8QMpZrIYxG6vJAf8iO7ChZMvarMrIp8=;
        b=osaFHMirR+5pTfOzLI3EOrnc/y0GQRuUvqP2z0fnfJhYRTLhu3gqoqjIiLIHsNizV0
         44nOTyFfN2lKG9OKUxPKMgItK7gWGhBRpoVllRJzE2wD7Te4njyksptFLUEtrQ8ju3Pp
         Oku8xmVPylTcRQhjMTmYQItaE54RqNf9offLwfgOOvmEpnvkS8zgzfXCMbqCy5RWCbBL
         Q14gML7n2IAo+RxoQnKk874UAygrui9mid9GcKPeAOz5awQmWxkzFAzNawD29SQfRAJj
         4D5Ab2eSB6PORQdSsqiX2RDnNK0cN8YQYFJW59W0w9rnoDBv6Y8Nfx0LqRhaa8zloo/r
         gS3w==
X-Gm-Message-State: APjAAAX8l5sr55k6uRsjT2UGG9rBLcuZ0A4suK4kAJ5JUwckl7MwYssO
        AIvis5QjIXUZZNnGWg0Cas4=
X-Google-Smtp-Source: APXvYqw4Ple/rY/dHAlqNHUf+o2L0TI9mXejAG1I2gsZV3scxJSCat3y+wSSXZfmntethZAUjfe2xw==
X-Received: by 2002:a1c:23c1:: with SMTP id j184mr20339498wmj.83.1573486531180;
        Mon, 11 Nov 2019 07:35:31 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w81sm23965657wmg.5.2019.11.11.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:35:29 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v2 0/9] iio: max31856: provide more configuration options
Date:   Mon, 11 Nov 2019 16:35:08 +0100
Message-Id: <20191111153517.13862-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923121714.13672-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series was born in order to provide more configuration options for
max31856 devices. In this version, in order to do that, it also extends
the IIO core. While at it, I've also updates maxim_thermocouple driver
to take (little) advantage of the said change.

Two hardware features (power mains noise rejection and HW averaging)
were not previously configurable, and one (thermocouple type selection)
was only possible via DT, but in my experience this is quite limiting in
several scenario (see 3/3 commit message for complete explanation).

These patches have been tested backporting max31856 driver on a 4.19
upstream kernel (Xilinx mpsoc-based board), and then rebased on the
IIO testing git tree.

I have real HW for max31856, while for maxim_thermocouple I've tested my
changes as much as I could just spoofing in the DT (no real HW).

Changes in v2:
- 1/9 and 3/9: changed attribute name to better match IIO naming convention
- 2/9: added separate patch to document new attribute name introduced in 1/9
- 4/9, 5/9, 6/9: new patches to add support to IIO core for handling
  thermocouple_type addribute. Most notably 4/9 introduces support for
  handling 'char' type IIO sysfs attributes; RFC on this.
- 7/9: take advantage of just-added IIO thermocouple_type attribute instead
  of using extended custom attribute
- 8/9 and 9/9: new patches to make maxim_thermocouple driver to export
  (RO) thermocouple_type attribute

Andrea Merello (9):
  iio: max31856: add option for setting mains filter rejection frequency
  Documentation: ABI: document IIO in_temp_filter_notch_center_frequency
    file
  iio: max31856: add support for configuring the HW averaging
  RFC: iio: core: add char type for sysfs attributes
  iio: core: add thermocouple_type standard attribute
  Documentation: ABI: document IIO thermocouple_type file
  iio: max31856: add support for runtime-configuring the thermocouple
    type
  RFC/RFT: iio: maxim_thermocouple: add thermocouple_type sysfs
    attribute
  dt-bindings: iio: maxim_thermocouple: document new 'compatible'
    strings

 Documentation/ABI/testing/sysfs-bus-iio       |  13 ++
 .../iio/temperature/maxim_thermocouple.txt    |   7 +-
 drivers/iio/industrialio-core.c               |  23 ++-
 drivers/iio/temperature/max31856.c            | 133 +++++++++++++++++-
 drivers/iio/temperature/maxim_thermocouple.c  |  45 +++++-
 include/linux/iio/types.h                     |   2 +
 6 files changed, 212 insertions(+), 11 deletions(-)

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org

--
2.17.1
