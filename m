Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB531EB8B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhBRP0o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231805AbhBRNVC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 08:21:02 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6B46023C;
        Thu, 18 Feb 2021 13:19:45 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:19:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Ye Xiang <xiang.ye@intel.com>, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: Add relative sensitivity support
Message-ID: <20210218131941.0ac3b1f5@archlinux>
In-Reply-To: <nycvar.YFH.7.76.2102171255250.28696@cbobk.fhfr.pm>
References: <20210207070048.23935-1-xiang.ye@intel.com>
        <20210207070048.23935-2-xiang.ye@intel.com>
        <20210212182809.2cc90cfd@archlinux>
        <nycvar.YFH.7.76.2102171255250.28696@cbobk.fhfr.pm>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Feb 2021 12:55:41 +0100 (CET)
Jiri Kosina <jikos@kernel.org> wrote:

> On Fri, 12 Feb 2021, Jonathan Cameron wrote:
> 
> > > Some hid sensors may use relative sensitivity such as als sensor.
> > > This patch adds relative sensitivity checking for all hid sensors.
> > > 
> > > Signed-off-by: Ye Xiang <xiang.ye@intel.com>  
> > Hi,
> > 
> > One totally trivial extra line below.  I'll fix that whilst applying
> > unless you need to respin for some reason.
> > 
> > I'm fine with the series, but looking for an Ack from Jiri
> > for the HID header changes.  
> 
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> Thanks,
>
Thanks, series (and precursor series that also had a tiny addition
to those headers) applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to poke at it and see if they can find
anything we missed.

THanks,

Jonathan
 

