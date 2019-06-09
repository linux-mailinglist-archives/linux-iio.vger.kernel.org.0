Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47EB3AC83
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 02:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfFJAAL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jun 2019 20:00:11 -0400
Received: from chill.innovation.ch ([216.218.245.220]:49098 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfFJAAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jun 2019 20:00:11 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 20:00:10 EDT
Date:   Sun, 9 Jun 2019 16:49:51 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch A26B764015B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1560124191;
        bh=BSS23tILDkVwboike2uZGQWESGv2m47oeGg1PaeJI3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UoEcJ4SmOat+geX/ToaeClL5OWUMOcZtQbilOeVHd/T3KEV2prnxw3sHL/4XYktm9
         GKpjhqoYfqq4lGYXAXp2lsrxSXPTVkMkCqae1cxD5mWaIfoFeod6lZpnLVjUh1T0Ky
         XO5CXtVyqXMNnQD6OZHOlh6kdpZge+mLheyEO9dCZnMEQKLDICjjBNX4Z6Gf0L+xn1
         syya05TH+Kdg2z8bwYmT0gswyZ4bJFCdxr5tHulQmJaueFl7mpGd0K3QVGhM6EsUc4
         DR75KXkogj1ASnws0GA66ImIuBuU7pluht3O2drCeKg816zdLIBrhS66bd1nwOBkyd
         JPezy840ZTCLw==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Message-ID: <20190609234951.GB16597@innovation.ch>
References: <20190422031251.11968-1-ronald@innovation.ch>
 <20190422031251.11968-2-ronald@innovation.ch>
 <20190507122415.GC29524@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507122415.GC29524@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Tue, May 07, 2019 at 01:24:15PM +0100, Lee Jones wrote:
> On Sun, 21 Apr 2019, Ronald Tschalär wrote:
> 
> > The iBridge device provides access to several devices, including:
> > - the Touch Bar
> > - the iSight webcam
> > - the light sensor
> > - the fingerprint sensor
> > 
> > This driver provides the core support for managing the iBridge device
> > and the access to the underlying devices. In particular, since the
> > functionality for the touch bar and light sensor is exposed via USB HID
> > interfaces, and the same HID device is used for multiple functions, this
> > driver provides a multiplexing layer that allows multiple HID drivers to
> > be registered for a given HID device. This allows the touch bar and ALS
> > driver to be separated out into their own modules.
> > 
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> > ---
> >  drivers/mfd/Kconfig               |  15 +
> >  drivers/mfd/Makefile              |   1 +
> >  drivers/mfd/apple-ibridge.c       | 883 ++++++++++++++++++++++++++++++
> 
> I haven't taken a thorough look through, but I can tell you that the
> vast majority of what you're trying to do here does not belong in
> MFD.  MFD drivers are used to register child devices.  Almost all
> functionality or 'real work' should be contained in the drivers the
> MFD registers, not in the MFD parent itself.  You will need to move
> all 'real work' out into the subordinate device drivers for
> acceptance.

Thanks for your feedback. That was/is the idea: the actual Touch Bar
and ALS driver code is in separate modules - what is left in the
appple-ibridge mfd driver is a fairly generic hid driver
demultiplexer. However, that could be moved out into it's own
helper/module.

Having said that, it looks like the preference is to do all of this as
a hid driver with virtual hid devices instead of as an mfd driver.


  Cheers,

  Ronald

