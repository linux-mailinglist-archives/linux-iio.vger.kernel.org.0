Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D54139BE5
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 22:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgAMVws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 16:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgAMVws (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 16:52:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C75E2072B;
        Mon, 13 Jan 2020 21:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578952367;
        bh=y/quTnYmZGTS27+O38X4tlnva7g60jbcU+J8Q/9IIU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SnJPC7PdLWSQoEi05Jo5/rEQfdw9L392TKb5EAUP92qHOvU+UDNk8pr50fEjrJPZy
         1B04MQlQXtFiSrzKHWoauFRoIVnbpqgE/Py5fOoV/Z8nS0BtWik8bmg+eAuX0DjXPP
         WsOVc96e0A7lgP7wRitAmJCswU7wtsEYknToq8K8=
Date:   Mon, 13 Jan 2020 21:52:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH v1 8/9] iio: st_sensors: Drop redundant parameter from
 st_sensors_of_name_probe()
Message-ID: <20200113215240.32cc42b3@archlinux>
In-Reply-To: <20200113135810.GO32742@smile.fi.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
        <20191216173853.75797-8-andriy.shevchenko@linux.intel.com>
        <20191223162810.26637345@archlinux>
        <20200113135810.GO32742@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 15:58:10 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Dec 23, 2019 at 04:28:10PM +0000, Jonathan Cameron wrote:
> > On Mon, 16 Dec 2019 19:38:52 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Since we have access to the struct device_driver and thus to the ID table,
> > > there is no need to supply special parameters to st_sensors_of_name_probe().
> > > 
> > > Besides that we have a common API to get driver match data, there is
> > > no need to do matching separately for OF and ACPI.
> > > 
> > > Taking into consideration above, simplify the ST sensors code.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > This looks good to me, but its big enough that purely on that basis I'd
> > like to leave it a little longer to let Denis / Lorezo or someone else have time
> > to take a look.
> > 
> > If I seem to have lost it by the end of the first week in January, give
> > me a poke.  I may have drunk a few things before then ;)  
> 
> Gentle ping.
> 
Thanks.  Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan

