Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CEF1A739A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405969AbgDNG1C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 02:27:02 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:34064 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2405926AbgDNG1C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 02:27:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id DBE58200FC84;
        Tue, 14 Apr 2020 14:26:58 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7s0gEgjn3c4C; Tue, 14 Apr 2020 14:26:58 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id B6B95200FC83;
        Tue, 14 Apr 2020 14:26:58 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id A5B96C01A1D;
        Tue, 14 Apr 2020 14:26:58 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 7F44C201602; Tue, 14 Apr 2020 14:26:58 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     chris.ruehl@gtsys.com.hk
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: patch set ltc2632
Date:   Tue, 14 Apr 2020 14:26:43 +0800
Message-Id: <20200414062648.19013-1-chris.ruehl@gtsys.com.hk>
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

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---

