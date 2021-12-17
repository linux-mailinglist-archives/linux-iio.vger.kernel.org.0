Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1B478863
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 11:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhLQKIy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 05:08:54 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56881 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhLQKIx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 05:08:53 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 872EA1C000E;
        Fri, 17 Dec 2021 10:08:48 +0000 (UTC)
Date:   Fri, 17 Dec 2021 11:09:41 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/13] iio: max9611: Use sysfs_emit()
Message-ID: <20211217100941.kj3oofhbvdnohibt@uno.localdomain>
References: <20211216185217.1054495-1-lars@metafoo.de>
 <20211216185217.1054495-11-lars@metafoo.de>
 <20211217090543.4w3n6nfxxbemqnhb@uno.localdomain>
 <485ca749-57d4-89c6-d19e-05b1cf5fb108@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <485ca749-57d4-89c6-d19e-05b1cf5fb108@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Fri, Dec 17, 2021 at 10:17:58AM +0100, Lars-Peter Clausen wrote:
> On 12/17/21 10:05 AM, Jacopo Mondi wrote:
> > Hi Lars-Peter,
> >
> > On Thu, Dec 16, 2021 at 07:52:14PM +0100, Lars-Peter Clausen wrote:
> > > sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> > > knows about the sysfs buffer specifics and has some built-in checks for
> > > size and alignment.
> > >
> > > Use sysfs_emit() to format the custom `in_power_shunt_resistor` and
> > > `in_current_shunt_resistor` device attributes of the max9611 driver.
> > >
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Looks good, I just wonder if a dependency on the CONFIG_SYSFS symbol
> > should now be added...
> >
> I don't think anything has changed in this regard. The function is called
> from a sysfs attribute callback. If SYSFS is disabled the callback will not
> be called. At the same time sysfs_emit() is stubbed out when SYSFS is
> disabled, so no compile error either.

You're right, nothing changes, we won't have any attribute to call the
function on :)

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks!
   j
