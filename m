Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3541F3B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 10:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfFLIeL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 04:34:11 -0400
Received: from chill.innovation.ch ([216.218.245.220]:35508 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbfFLIeJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2019 04:34:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id E76D064018A;
        Wed, 12 Jun 2019 01:34:07 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ynWuYposjBek; Wed, 12 Jun 2019 01:34:06 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch E43566400E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1560328446;
        bh=cpbIwpjc0S7uU5oxd8Zrd5ncqR9RhfgakrkuHbEEQqo=;
        h=From:To:Cc:Subject:Date:From;
        b=ci7ykCT8CY23B45eSwtZDpc489RJ40VioN4w3aE0Rpi3BRVgYFnOgfW+cPNRjD9Jp
         1A1JLZfXldgmt2aLeSKI4h4pVpV25DTuiBjXFF62QlwnY8oVh8eB8HmC33CzRG8Tqa
         GAVgBRBvEHNYTy8Coyv4nFEkaUhq9+W1T8CsRlM8ZZ+moTW2DPiGttoloFOPGAb08v
         q3FrzJDR0kBKs90i67NlqtvtrkDK/rw67beMLxPpBGZh35xsoD4bkbTySw8PPngsjh
         j92JkQ2HUTJ9aA68PtBH3OMWj+uX2DlEpuaC8XMQRA5KD02zTtuUh5JO/K5T/QHIF9
         KBmIEo0DZztjg==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Apple iBridge support
Date:   Wed, 12 Jun 2019 01:33:57 -0700
Message-Id: <20190612083400.1015-1-ronald@innovation.ch>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

2016 and 2017 MacBook Pro's have a T1 chip that drives the Touch Bar,
ambient light sensor, webcam, and fingerprint sensor; this shows up
as an iBridge USB device in the system. These patches provide initial
support for the Touch Bar and ALS - the webcam is already handled by
existing drivers, and no information is currently known on how to access
the fingerprint sensor (other than it's apparently via one of the extra
interfaces available in the OS X USB configuration).

One thing of note here is that both the ALS and (some of) the Touch Bar
functionality are exposed via the same USB interface (and hence same
hid_device), so both drivers need to share this device. This is solved
by having the iBridge driver create multiple virtual HID devices for
each real HID device to which the Touch Bar and ALS drivers attach, and 
then forwarding the calls between the real and virtual HID devices, so
we end up with a structure like this:

    iBridge (HID) driver    Sub drivers

           --  vhdev0  --   (unbound)
          /
   hdev1  ---  vhdev1  ---  tb-drv
                         /
           --  vhdev2  --
          /
   hdev2  ---  vhdev3  ---  als-drv


Changes in v2:
  - Changed iBridge driver from an MFD driver to a HID driver. Instead
    of creating virtual HID drivers and (de)multiplexing their calls,
    this now create virtual HID devices and (de)multiplexing the
    operations on them. This is from the feedback by Benjamin Tissoires.
  - Applied all feedback on ALS driver from Jonathan Cameron
  - Applied all feedback on Touch Bar driver from Jonathan Cameron
    and Peter Meerwald-Stadler
  - various smaller cleanups

Ronald Tschalär (3):
  HID: apple-ibridge: Add Apple iBridge HID driver.
  HID: apple-ib-tb: Add driver for the Touch Bar on MacBook Pro's.
  iio: light: apple-ib-als: Add driver for ALS on iBridge chip.

 drivers/hid/Kconfig              |   24 +
 drivers/hid/Makefile             |    2 +
 drivers/hid/apple-ib-tb.c        | 1389 ++++++++++++++++++++++++++++++
 drivers/hid/apple-ibridge.c      |  588 +++++++++++++
 drivers/hid/hid-ids.h            |    1 +
 drivers/iio/light/Kconfig        |   12 +
 drivers/iio/light/Makefile       |    1 +
 drivers/iio/light/apple-ib-als.c |  607 +++++++++++++
 include/linux/apple-ibridge.h    |   23 +
 9 files changed, 2647 insertions(+)
 create mode 100644 drivers/hid/apple-ib-tb.c
 create mode 100644 drivers/hid/apple-ibridge.c
 create mode 100644 drivers/iio/light/apple-ib-als.c
 create mode 100644 include/linux/apple-ibridge.h

-- 
2.21.0

