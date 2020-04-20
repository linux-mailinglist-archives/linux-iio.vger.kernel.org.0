Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558EE1B00B3
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 06:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDTE0v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 00:26:51 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:54980 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgDTE0v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 00:26:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 92BAE2007EB3;
        Mon, 20 Apr 2020 12:26:45 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yN9VBUDXXj0o; Mon, 20 Apr 2020 12:26:45 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 6C05D20038D0;
        Mon, 20 Apr 2020 12:26:45 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 59F26C01F9E;
        Mon, 20 Apr 2020 12:26:45 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 2DC87201602; Mon, 20 Apr 2020 12:26:45 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] iio: patch set ltc2632
Date:   Mon, 20 Apr 2020 12:26:05 +0800
Message-Id: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Patchset to extend ltc2632 spi driver to support the similar chip set
ltc2634.
* Patch v2 1/3 update documentation struct ltc2632_chip_info
* Patch v2 2/3 patch ltc2632.c,Kconfig,ltc2632.txt(devtree)
* Patch v2 3/3 convert ltc2632.txt to yaml format named lltc,ltc2632.yaml

* Patch v3 2/3 : correct help text

* Patch v4 1/3 : correct spelling in commit
           */3  hide change history below --- 

* Patch v5 : 1/3,2/3 add Accept-by and fixed tag,
             3/3   maintainer & correct required seciton

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---

