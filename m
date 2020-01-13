Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4005139BEC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 22:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgAMVyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 16:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbgAMVyE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 16:54:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 389E42187F;
        Mon, 13 Jan 2020 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578952443;
        bh=kfQAAn62u8ZZqrrTe/TOc/hs+DI5kwdph4j6r2PS11E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=14TaWRVVFY3Wd1dpc9ElOwpWK8ksdVwitGX43huRTxuIbDiNuvBhBa2bXemzGKm+d
         mGytemcvBGRbqyPF7Lh6ur1YUauNtZAa1K0hfGb4gue3YqIokcWvlVs2kPoE8OHtWg
         QUQNlXUgnXsnvl6xCcFtFrlWt4KeoLb33DRWC+Y8=
Date:   Mon, 13 Jan 2020 21:53:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com
Subject: Re: [PATCH v1 9/9] iio: st_sensors: Make use of device properties
Message-ID: <20200113215359.7c1983d4@archlinux>
In-Reply-To: <20200113135832.GP32742@smile.fi.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
        <20191216173853.75797-9-andriy.shevchenko@linux.intel.com>
        <20191223163033.1b48c0c7@archlinux>
        <20200113135832.GP32742@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 15:58:32 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Dec 23, 2019 at 04:30:33PM +0000, Jonathan Cameron wrote:
> > On Mon, 16 Dec 2019 19:38:53 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Device property API allows to gather device resources from different sources,
> > > such as ACPI. Convert the drivers to unleash the power of device property API.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > Also looks fine, but will allow a bit more time for others to take a look.  
> 
> Gentle ping.
> 

Applied.  Thanks for the reminder.

Jonathan
