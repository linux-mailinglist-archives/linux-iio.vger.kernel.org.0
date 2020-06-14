Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA92D1F889D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 13:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFNLbN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 07:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgFNLbM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 07:31:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD01720714;
        Sun, 14 Jun 2020 11:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592134271;
        bh=90W/P6QW8uB82PO6NywzrVOdYdun3FBmMc3k97uoSHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DSGlDJvy3ohcBhhaLg5HLkxpLMAebNS0T3rWoGyIC+fAvot4ehjEqY2HkKTBa4ohd
         IkCIDZicg1qcndmxezw8bVx94mIds3wDhxK2C6NbAVekRGHXwyWtketeF5N8nxWMoa
         YjKi8J2IdhBahFY2z94sSZnEqd+Tg4xRfiBpt9h0=
Date:   Sun, 14 Jun 2020 12:31:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zaikonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development\@norphonic.com" <development@norphonic.com>,
        "linux-iio\@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20200614123107.474ef908@archlinux>
In-Reply-To: <863671oiwi.fsf@norphonic.com>
References: <5489E47F-47D4-421A-A7EA-E11B0205A842@norphonic.com>
        <20200519191103.00004489@Huawei.com>
        <863671oiwi.fsf@norphonic.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Jun 2020 15:02:05 +0200
Eugene Zaikonnikov <ez@norphonic.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> 
> > On Mon, 18 May 2020 19:15:27 +0000
> > Eugene Zalkonnikov <ez@norphonic.com> wrote:
> >
> > Hi Eugene
> >  
> >> HDC2010/2080 driver and sysfs documentation for its heater element.
> >>   
> >
> > Would be nice to have a little more info on the device for anyone reading
> > the log after we commit this.
> >  
> Ok I'll expand the description.
> 
> > There is a potential double free in the remove path due to mix of
> > devm_iio_device_register and iio_device_unregister.
> >  
> Right, overlooked this. Will changine the unregister to the managed
> version suffice?
Whilst that would work it would be a bad idea.

You need the unmanaged unregister before disabling auto measurement
(to remove the userspace interfaces before changing things so they won't
work).

So just use unmanaged iio_device_register in probe (and reorder to
put the unregister before the sensor stop).  I think that will also
mirror the ordering in probe which should always be the case unless
there is a very good reason to do otherwise.

Jonathan



> 
> > Also, the error paths in probe don't undo the various bits of setup
> > that it feels like they should.  This might not matter in reality
> > but the code will be more obviously correct if it is fine to reset
> > the amm bit.
> >  
> I'll add that.
> 

