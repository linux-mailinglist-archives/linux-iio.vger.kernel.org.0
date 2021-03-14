Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0B33A703
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCNQvw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233710AbhCNQv0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:51:26 -0400
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F9BD64E10;
        Sun, 14 Mar 2021 16:51:25 +0000 (UTC)
Date:   Sun, 14 Mar 2021 16:51:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Mugil Raj <dmugil2000@gmail.com>,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: iio: TODO Clean up W=1 warnings in staging drivers.
Message-ID: <20210314165122.2ac5a72a@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Given we've had a few requests recently for useful tasks in IIO I thought I'd
post the bits I'm not touching in a clean up series today.

If you build the kernel with W=1 it will run kernel-doc tests on all the
files.   That tends to show up places where the docs are in some sense not
compliant with the kernel-doc format. See
Documentation/doc-guide/kernel-doc.rst

I'm cleaning up a few that have sneaked into the drivers and core outside

https://lore.kernel.org/linux-iio/20210314164655.408461-1-jic23@kernel.org/T/#t

However, I haven't done the staging drivers

drivers/staging/iio/frequency/ad9832.c:119: warning: Function parameter or member 'lock' not described in 'ad9832_state'
drivers/staging/iio/frequency/ad9832.c:255: warning: Function parameter or member '0200' not described in 'IIO_DEV_ATTR_FREQ'
drivers/staging/iio/frequency/ad9832.c:255: warning: Function parameter or member 'NULL' not described in 'IIO_DEV_ATTR_FREQ'
drivers/staging/iio/frequency/ad9832.c:255: warning: Function parameter or member 'ad9832_write' not described in 'IIO_DEV_ATTR_FREQ'
drivers/staging/iio/frequency/ad9832.c:255: warning: Function parameter or member 'AD9832_FREQ0HM' not described in 'IIO_DEV_ATTR_FREQ'
drivers/staging/iio/frequency/ad9832.c:255: warning: expecting prototype for h for further information(). Prototype was for IIO_DEV_ATTR_FREQ() instead
  CHECK   drivers/staging/iio/meter/ade7854-i2c.c
drivers/staging/iio/frequency/ad9834.c:87: warning: Function parameter or member 'devid' not described in 'ad9834_state'
drivers/staging/iio/frequency/ad9834.c:93: warning: cannot understand function prototype: 'enum ad9834_supported_device_ids '
drivers/staging/iio/frequency/ad9834.c:323: warning: Function parameter or member '0200' not described in 'IIO_DEV_ATTR_FREQ'
drivers/staging/iio/frequency/ad9834.c:323: warning: Function parameter or member 'NULL' not described in 'IIO_DEV_ATTR_FREQ'
drivers/staging/iio/frequency/ad9834.c:323: warning: Function parameter or member 'ad9834_write' not described in 'IIO_DEV_ATTR_FREQ'
drivers/staging/iio/frequency/ad9834.c:323: warning: Function parameter or member 'AD9834_REG_FREQ0' not described in 'IIO_DEV_ATTR_FREQ'
drivers/staging/iio/frequency/ad9834.c:323: warning: expecting prototype for h for further information(). Prototype was for IIO_DEV_ATTR_FREQ() instead

I've not even glanced at the code, so it will be a case of figuring
out what needs fixing :)

Thanks,

Jonathan
