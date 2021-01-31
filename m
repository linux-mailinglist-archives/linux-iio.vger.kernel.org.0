Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771BD309C3B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhAaM6x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 07:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhAaLB5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 06:01:57 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB71D64E1F;
        Sun, 31 Jan 2021 10:58:48 +0000 (UTC)
Date:   Sun, 31 Jan 2021 10:58:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity
 driver
Message-ID: <20210131105844.2dfe9380@archlinux>
In-Reply-To: <161159998973.76967.1213998704222248070@swboyd.mtv.corp.google.com>
References: <20210122225443.186184-1-swboyd@chromium.org>
        <20210122225443.186184-4-swboyd@chromium.org>
        <20210124173820.4528b9c9@archlinux>
        <161159998973.76967.1213998704222248070@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
> > > +
> > > +#ifdef CONFIG_OF  
> > 
> > As a general rule, we are trying to clear out protections on CONFIG_OF etc
> > and use of of_match_ptr() on the basis they don't really gain us anything
> > and prevent use of some other firmware types.  Here I guess you know what
> > your firmware looks like, but I'm still keen to drop it in the interests
> > of there being fewer places to copy it from.
> > 
> > It may be a good idea to give this a more specific name as well given
> > we already have cros-ec-prox as a platform device id from
> > the cros_ec_light_prox driver.  
> 
> Alright. I renamed it to cros_ec_mkbp_proximity throughout this driver.
> I'm concerned about dropping CONFIG_OF because of_match_ptr() and
> CONFIG_OF=n makes it unused but I suppose that will be OK as long as
> compilation passes.

It's a trivial overhead + note that it can be used by certain ACPI
tables.  Lookup the delights of PRP0001 which lets ACPI use
device-tree descriptions.  It may well be that no one uses that for
this driver, but it's nice not to exclude it and that works with
CONFIG_OF=n.

Jonathan
