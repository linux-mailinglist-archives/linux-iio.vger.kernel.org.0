Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB88B5A01
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 05:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfIRDJ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 23:09:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44187 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIRDJ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 23:09:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so3381999pfn.11;
        Tue, 17 Sep 2019 20:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+agu3MDztsPy7Mp12+9mhgwZeMLYpmGx4ANd9HSWmFs=;
        b=b4Bo4rvNCkrGPOXi4+0qltA3Bsl0SQ7/FA144iXXI97OjCjPGbwg6bd6ZssecHEJm3
         m1B6f2TB8GBQfNlLzVx30w7XW7HnXpBjpgx82ZtO/JEYoFsjQOCZeEPdigAzQdw2UeEP
         ac/1L0RrPl1FVkyf/t2bJ4uKxauvnI9BNBJVi2jYIWbdcfR9nL0m/UUMoKC5tLv3JHTs
         QXCob6kZXIVMh3mr5dTKgXoXDsWMnsJpxRgGuEcJCtRRoLh8deFk5B4t5qgDMJUXeijx
         SekLx0kW4pLafFj2GGV3uOandujncCThUu33x1pSBR+AYxdknpDDEX0ij07q533EnmML
         ct/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+agu3MDztsPy7Mp12+9mhgwZeMLYpmGx4ANd9HSWmFs=;
        b=ItSoQ8UYh/7zp6kEZ8GhQ8N2ajLG3mtpFPvSE2R+5CZUT3BstgplPnH1eKJlbfXSWh
         v0fed9CBG2a+8TLWpQDIjNItB6HolZe/HN2LMD4CbfJby+iKUHzOQHYrbOD7hgRWFmNp
         mOutH3KP1gWa+8AuFRLeQex6gFfzGT2BycL3A4y/bzm2uQHPb6HR0qionQBn5jW7vdd5
         KzjITH/ULt501GaIrvSz1R9yJswTdrE/r2pXBBw5hCzxej9IpCFKyXSS9VCSFQ0bHHAk
         6IwQEXIUG2nxXfoaat6wLrqpEScwUxuOVPGYnKihXufk/lsxklTEkvZJt3/F/tm8j+ev
         0QSw==
X-Gm-Message-State: APjAAAXHpmh/IXT90WWm6L16MxOn46i5r/+VspaFMhQRXCzho5ENCQQq
        2ENRGDPbG784mkqBLZzv5xs=
X-Google-Smtp-Source: APXvYqwWFi5i46DB8fZU+ZHMpANC/st45NBwVr6WDHlczuuFdGkDByfdYTIkaJKFz5TyVzoOtj6KRg==
X-Received: by 2002:aa7:953c:: with SMTP id c28mr1777003pfp.106.1568776168687;
        Tue, 17 Sep 2019 20:09:28 -0700 (PDT)
Received: from localhost.localdomain ([106.51.108.240])
        by smtp.gmail.com with ESMTPSA id x68sm4234116pfd.183.2019.09.17.20.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 20:09:28 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Add driver for veml6030 ambient light sensor
Date:   Wed, 18 Sep 2019 08:39:15 +0530
Message-Id: <1568776157-5373-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The veml6030 is an ambient light sensor from vishay and
is a different hardware from an existing hardware for which
driver currently exist, therefore this driver submission.

* All features; ALS, white channel & power management is
  supported.

* All configurable parameters are supported through standard
  iio sysfs entries. User space can get valid values of any
  parameter (xx_available) and then can write to appropriate
  sysfs entry.

* User space can get ALS & White channel readings through RAW
  IIO interface.

* IIO events are used to notify application whenever threshold
  is crossed. This uses IRQ pin of veml6030.

* Some registers in veml6030 are read only. For these registers
  read callback returns error to user space.

There are 2 patches for this submission:
[PATCH 1/2] iio: light: add driver for veml6030 ambient light sensor
[PATCH 2/2] dt-bindings: iio: light: add veml6030 ALS bindings

Regards,
Rishi
