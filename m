Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F4FCD019
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfJFJkY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfJFJkY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:40:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 946672084B;
        Sun,  6 Oct 2019 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570354823;
        bh=FmDdCYTKJFTDT8o+LZ+i+/9g/IdCdn4YpxlkdnAg1K0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wTphoo4SWevsLU51LAWbeov6d2qsL0up4A/pNfNmqWlJs3r4NpwcoDOVVcWJ1WbtP
         xt21ycrt1XA4LoARFInd8Bu0Qcq0oDVEF4jNtMUVhPgsCB2ujl458JEJZ5HfUpq6xF
         AuF+grZ/O2IuxSkIRiM33VNnczUzLOyR+9UtH0So=
Date:   Sun, 6 Oct 2019 10:40:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Frey <dpfrey@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Adding "fault count" support to opt3001
Message-ID: <20191006104019.426638c7@archlinux>
In-Reply-To: <a3335ddc-6961-79fa-308d-868e156960d1@gmail.com>
References: <a3335ddc-6961-79fa-308d-868e156960d1@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Sep 2019 10:08:19 -0700
David Frey <dpfrey@gmail.com> wrote:

> Hi,
> 
> The TI opt3001 light sensor has a fault count field in its configuration
> register.  See http://www.ti.com/lit/ds/symlink/opt3001.pdf on page 23.
> Basically, this field controls how many samples must be above the high
> threshold or below the low threshold in order to trigger the interrupt.
> Currently the driver initializes this field to 0 meaning that one fault
> will trigger an interrupt.
> 
> 0b00 -> 1
> 0b01 -> 2
> 0b10 -> 4
> 0b11 -> 8
> 
> The driver has an IIO event which allows for the high/low threshold to
> be set and enabled/disabled.  I would like to add the ability to specify
> the fault count as well and I'm wondering how this should be done.  I
> believe it should be done by adding a .mask_shared_by_type =
> BIT(IIO_EV_INFO_???) definition within the struct iio_event_spec, but
> I'm not sure if any of the existing IIO_EV_INFO_ values are appropriate.
>  The only one that might be appropriate is IIO_EV_INFO_HYSTERESIS.

If I have understood what this is correctly...

IIO_EV_INFO_PERIOD is the right one.  From a userspace point of view
it really doesn't care how many samples it is, what it cares about is
how long it needs to break the threshold for.  So across different
sensor types it might want to ignore camera flashes for example.

This does mean it becomes dependent on the sampling frequency. Now
I can't actually work out from that datasheet what controls the sampling
frequency...  I suppose it might just start a new reading immediately
after the previous one, but there isn't anything that I can see that
documents that.  Any ideas?

> 
> Am I going about this the right way?
> Is IIO_EV_INFO_HYSTERESIS appropriate?
> Should a new enum value be defined?
> 
> Thanks,
> David

