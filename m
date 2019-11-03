Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764D4ED365
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKCM46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 07:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfKCM46 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 07:56:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8526B20659
        for <linux-iio@vger.kernel.org>; Sun,  3 Nov 2019 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572785818;
        bh=4TogS9V8R/36GVnuhTyYnUrTxtNO+TC1SCU3z2iY7ls=;
        h=Date:From:To:Subject:From;
        b=C+ORtK+9zmXaB3iuoQZiwFmCZm7+SG3eZrUd/b7dH/HaNEWo1kncxJN3DK0UdLyjf
         Cvx7A4NeiEiGvPB3Icet3Br0q8ylrw83vgM191/U3nrSsEKOWlBPV/mabeUWiyfxyI
         0obqfcmPSVxL5kTm4YdMCWCafZUkNpQGoiesoWT0=
Date:   Sun, 3 Nov 2019 12:56:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: iio: Request for review.  Warning fix patches.
Message-ID: <20191103125653.57ccd98f@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Whilst I 'could' just take my own patches without review, I know
I can sometimes make stupid mistakes so would like to get some eyes
and formal tags on the following:

[PATCH] iio:adc:ti-adc084s021: Endian casting tidy ups.
[PATCH] iio: adc: aspeed: use devm_platform_ioremap_resource
[PATCH] iio: adc: mt6577_auxdac: use devm_platform_ioremap_resource
[PATCH] iio: adc: bcm_iproc_adc: drop a stray semicolon
[PATCH] iio: adc: cc10001: use devm_platform_ioremap_resource
[PATCH] iio: adc: ingenic: Use devm_platform_ioremap_resource
[PATCH] iio: adc: lpc18xx: use devm_platform_ioremap_resource
[PATCH] iio: adc: npcm: use devm_platform_ioremap_resource
[PATCH] iio: adc: rcar-gyroadc: use devm_platform_ioremap_resource
[PATCH] iio: adc: spear_adc: Use devm_platform_ioremap_resource
[PATCH] iio: adc: vf610: use devm_platform_ioremap_resource
[PATCH] iio: dac: lpc18xx: Use devm_platform_ioremap_resource
[PATCH] iio: dac: vf610: Use devm_platform_ioremap_resource

I suspect most if not all of the original authors are no longer
working with these.   Note that these are all simple patches,
so a good opportunity for less experienced reviewers to get
involved alongside the old hands!

I think getting all of those merged should give us clean builds
with sparse and coccicheck which will make it easier to spot
new issues in the future.  They are all nicely little cleanups
even without that target.

Thanks,

Jonathan
