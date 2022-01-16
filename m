Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4143048FDEC
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiAPQo2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 11:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiAPQo2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 11:44:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A55C061574
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 08:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE6360C49
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 16:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85D9C36AE7;
        Sun, 16 Jan 2022 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642351466;
        bh=+KDcx0rsR8PRWMMMgHBL9/X6+do+4k9SIGprBl0uQ4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GD7LjVjmy9sLSDEdvAVdojAyLVY4+iJD6T7hL7/P8dLtzVolJshCXPsBZq1kUq+HT
         fZqwDaTtRzM/2owNB8fnhSWijKPi4Ze78Zx8B4GvLGQpIPXexlJSnzgawbNk2JN0pQ
         smVfu2+G2v/i88y2ZO498T5P5SdzQm3nc+6ESgM3HAaW+tOIFWAEOt64mFfmXzzfPn
         tlpXvUnXcVNZ3U/4c9rPJlZu0XHtOaD9SXYzIRWAOMeoIkWgdknYOxVYWsefqLEUbc
         vNA3dYO4HA7GRFxMQkMih6zvMo1i1v2BsoW9SkZUYsdftsu/bGkV4A7qlqed0KOiZ7
         o2VGqXm4SOowg==
Date:   Sun, 16 Jan 2022 16:50:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/13] iio: lm3533: Use sysfs_emit()
Message-ID: <20220116165025.2858b6d5@jic23-huawei>
In-Reply-To: <YbxVCcJgE55hOqPY@hovoldconsulting.com>
References: <20211216185217.1054495-1-lars@metafoo.de>
        <20211216185217.1054495-8-lars@metafoo.de>
        <YbxVCcJgE55hOqPY@hovoldconsulting.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Dec 2021 10:14:49 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Thu, Dec 16, 2021 at 07:52:11PM +0100, Lars-Peter Clausen wrote:
> > sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> > knows about the sysfs buffer specifics and has some built-in checks for
> > size and alignment.  
> 
> I realise that the above is some copy-paste boiler plate, but none of it
> is really relevant here when the driver uses the attribute buffer
> directly with scnprintf() and a PAGE_SIZE argument.
> 
> This should probably be rephrased in terms of consistency and the
> documentation now claiming that only sysfs_emit() should be used in
> show() functions (e.g. to avoid problems in drivers that would have
> failed to follow the previous instructions).
> 
I've added some stuff about best practice and chances of being copied into
new drives to this text.

> > Use sysfs_emit() to format the custom device attributes of the lm3533
> > driver.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> 
> That said, the change itself is otherwise fine even I'm not sure it's
> generally worth the churn to convert all existing show() functions:

Agreed it's not an activity I'd consider of high importance but there
is definitely advantage in updating drivers to current best practice
because it saves having to comment on it as often in reviews.

> 
> Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks,

Jonathan
> 
> > ---
> >  drivers/iio/light/lm3533-als.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> > index 8a621244dd01..827bc25269e9 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
> > @@ -417,7 +417,7 @@ static ssize_t show_thresh_either_en(struct device *dev,
> >  		enable = 0;
> >  	}
> >  
> > -	return scnprintf(buf, PAGE_SIZE, "%u\n", enable);
> > +	return sysfs_emit(buf, "%u\n", enable);
> >  }
> >  
> >  static ssize_t store_thresh_either_en(struct device *dev,
> > @@ -474,7 +474,7 @@ static ssize_t show_zone(struct device *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	return scnprintf(buf, PAGE_SIZE, "%u\n", zone);
> > +	return sysfs_emit(buf, "%u\n", zone);
> >  }
> >  
> >  enum lm3533_als_attribute_type {
> > @@ -530,7 +530,7 @@ static ssize_t show_als_attr(struct device *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> > +	return sysfs_emit(buf, "%u\n", val);
> >  }
> >  
> >  static ssize_t store_als_attr(struct device *dev,  
> 
> Johan

