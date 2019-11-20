Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C5A103DA5
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfKTOtV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 09:49:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35058 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfKTOtU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id s5so140536wrw.2
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2019 06:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uadtiHrAGB0w2ONbDh5O4iq3e68f8szulGG1kmCgH1E=;
        b=iLoAHVCQx3009DDEKFXuWMs8yn73hhH9Gahz+adyjx+sa3KvTKyqmdk1JqDVzHdXEB
         q1RgPceuuvNFRdBTbvuUo6fVxhGjzhnEgraxI/NqAVd1HL734BnLRx957SJGhmpny1dM
         24H0Bi9XWJPiyFMNRLt3iSFxDzfEIG2RvgLkNS2cGZrtWfIuv4I+wn6Wq7dBOd3w7XV2
         DXe1K8BgrxRMLDPazk2rBVI9UuoAfreGW13K1jdaoRNLUk7pPs4jD4OzcFX40NKuJ1r1
         QOOlS28A1IbNcOU4qRjMTqu+e8f9Fab7896wac686EFYpPQ8ytrEt1+CWyQa2l8Gtu2y
         hfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uadtiHrAGB0w2ONbDh5O4iq3e68f8szulGG1kmCgH1E=;
        b=n3oXYAcx4Lm6T6TKtL3ywMk9h0DfooG0eLCTUqPg1TnKzbDyBdG9E6TkwqGJ89j1Uv
         h7jIDgAwRB84RVhqRkocNknUbkIQDuMY5lpLKdKj8mgYGsYX4V37REAv7XdSk4mHf5B/
         wUfQuLa0/UUfU7ONqS7U4kBuQlxO+RLRYkflG+gWSmdhXrh1BHGkZWMgoB0P2zbIVvWk
         lCB1b3xtF7rN+vRGA5KeV7SRTm4U++LHQRdo8wkkJf5EoSun7u3J2vly/3jhNESxGkri
         +FI2KMhnl8aN/4dqxcMT+gp1RrFQASuzRbTqt6+BJ4g+mw9dZ9Ol+flw8uJxc17CymnF
         CBGw==
X-Gm-Message-State: APjAAAXTMm0T1D/7UAHfcfPpYYuujk5/VH39wALfdzHGRNzSLi856zwd
        9rXOH4yMgGW5dpNv5g42O2eeyVtcls0=
X-Google-Smtp-Source: APXvYqwo0nnPyusmUIXaTkfYulMzfgz2Z8C4Ib4xjhW73DhHqszNPaD0TlgbTbhP3PyuV1QZ0stFsw==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr3848410wrq.40.1574261358335;
        Wed, 20 Nov 2019 06:49:18 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:17 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v3 0/9] iio: max31856: provide more configuration options
Date:   Wed, 20 Nov 2019 15:47:47 +0100
Message-Id: <20191120144756.28424-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111153517.13862-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


This series was born in order to provide more configuration options for
max31856 devices. In this version, in order to do that, it also extends
the IIO core. While at it, I've also updated maxim_thermocouple driver
to take (little) advantage of the said change.

Two hardware features (power mains noise rejection and HW averaging)
were not previously configurable, and one (thermocouple type selection)
was only possible via DT, but in my experience this is quite limiting in
several scenario (see 7/9 commit message for complete explanation).

These patches have been tested backporting max31856 driver on a 4.19
upstream kernel (Xilinx mpsoc-based board), and then rebased on the
IIO testing git tree.

I have real HW for max31856, while for maxim_thermocouple I've tested my
changes as much as I could just spoofing in the DT (no real HW).

Changes is v3:
- all: removed a always-failing e-mail address from CC list
- 3/9 and 7/9: fix: a change that should belong to 7/9 was actually contained in 3/9
- 6/9: explicitly list all thermocouple types
- 7/9 and 8/9: killed whitespace/newline stray changes
Beside that:
- 1/9: got a reviewed-by in commit comment
- 9/9: got an acked-by in commit comment
Other patches remained unchanged

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
 drivers/iio/temperature/max31856.c            | 134 +++++++++++++++++-
 drivers/iio/temperature/maxim_thermocouple.c  |  44 +++++-
 include/linux/iio/types.h                     |   2 +
 6 files changed, 213 insertions(+), 10 deletions(-)

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
--
2.17.1
