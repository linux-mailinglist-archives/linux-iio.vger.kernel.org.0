Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056CB140A4
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfEEPc7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 11:32:59 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38516 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEEPc7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 May 2019 11:32:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 7BD209E8C78;
        Sun,  5 May 2019 16:32:57 +0100 (BST)
Date:   Sun, 5 May 2019 16:32:55 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC 0/1] Add new sysfs ABI for chromebook devices
Message-ID: <20190505163255.41c25c67@archlinux>
In-Reply-To: <cover.1556873525.git.fabien.lahoudere@collabora.com>
References: <cover.1556873525.git.fabien.lahoudere@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 May 2019 12:54:45 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> Chromebooks embedded controller (EC) provides new field in the 3rd version of 
> its protocol. Those values need to be exposed as sysfs entries.
> 
> Minimum and maximum frequencies may probably be a standard iio ABI.
> There is an existing ABI (sampling_frequency_available) but only for discrete 
> set of values.
> We have different possible solution and I want to ask interested people for the 
> best one:
> 1. we keep the ABI proposed in this RFC (in the chromebook specific code)
> 2. we move min and max freq as 2 different standard ABI
> 3. we add a new standard iio ABI to set a range (sampling_frequency_range)
> 4. we change the 'sampling_frequency_available' ABI to return discrete values 
> like '2 4 6 8' or a range like '[2 - 8]'
> 5. the solution I didn't think about
Gah, it's been on my todo list for far too long to put out proper docs for
it but we do have a way of doing this in IIO.

Best bet is too look at the code in
industrialio-core.c for iio_read_channel_info_avail, and specifically
iio_format_avail_range

That produces strings of the format [MIN STEP MAX] so more or less your
option 4, with the [] syntax indicating to userspace that it's a range
version.

We did this a while back to provide a single interface for consumer drivers
and for userspace.  If you poke around in the period around when that
patch was merged you'll find a discussion which was pretty much the
options you have above.

Note if anyone else wants to have a go at docs for this feature I would
definitely welcome it!

Jonathan

> 
> Thanks
> 
> Gwendal Grignou (1):
>   iio: common: cros_ec_sensors: add extra sensor API
> 
>  .../ABI/testing/sysfs-bus-iio-cros-ec         |  24 ++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 126 +++++++++++++++++-
>  .../linux/iio/common/cros_ec_sensors_core.h   |   7 +
>  include/linux/mfd/cros_ec_commands.h          |  21 +++
>  4 files changed, 177 insertions(+), 1 deletion(-)
> 

