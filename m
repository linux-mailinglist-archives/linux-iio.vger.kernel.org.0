Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CD3AEB2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 07:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbfFJFpx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 01:45:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40412 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387505AbfFJFpx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jun 2019 01:45:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so7780889wre.7
        for <linux-iio@vger.kernel.org>; Sun, 09 Jun 2019 22:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jFjgjSUEKRW8v/PBr8uM0Wg98cLQUz1sDSFbELuCUcE=;
        b=tNpoArwWtBlJJRHsX/hPjx3MAZiZF6YYEpBq1FZbegPrk37BcYygSrcUN8yzmYfKxE
         6Zn5krotmeemt02oNjpS09FXQzSJ/AaQGMigsNRiSIKwElOWrnlfhiCh4Spw1bskMiEe
         EJmLKrkXk4EXISbu6avfVBowRhv7a9FFpcW0Gmy8ICfOncRxrqmybcc56uyjnUMh9r1M
         z7RImAYTxvbh3xK5KtXDzSSlrpXFbCUfoyeD8xd12w6OFGO47uAjsS9CjR1YQj2uFmll
         ncarxHU9gZeKeAGz5xE6p6SPd70HwJ1cwAdTIajngGvCJvUaC5wO/XbqiCtD+NXeYMg9
         Fj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jFjgjSUEKRW8v/PBr8uM0Wg98cLQUz1sDSFbELuCUcE=;
        b=OxNfiV+G106t6YEr0rIL2om5MzSjwFrLCE2PNfDainCNyhCn1dliO5NibrLIXk+SUT
         ZkE8XvbkkeZoZ6eqOJzb474mMLO1oICXPvaVScVI/CNynjNeZ7hjqMJa7YhHm8ccJGBm
         I1HmUXliyXkkXFLTlxl2iIj/GYL0ipb72ns/ttThyJrIoY2DefVzWYKGq7uNpSZ0oCsp
         kGJVdUhsACOKI4by3VQ+GAvfpByr6RZ0+QqkplgW/gMC4fEqVh3kcg8KHH95zMHqyaEK
         fTqwV+HESWjSyL+v5X6jQkPdb73X7VOScAVoUa2GwesB4hJhwATFMYur1nChVjRiI/Hb
         z3mw==
X-Gm-Message-State: APjAAAW7qqAzNS1avMhjX9Vr6fuArAMPaVbhGpcVGXitdiEvWaui4U2D
        F+pCrg7ixaJFfsY9au8Ayi9PTQ==
X-Google-Smtp-Source: APXvYqwWAgRKMtFPjdeET26ZJToROEXxA9GoDg9vOGLp2D4Nt1NCIogxeYxfRJW2kRr04VqT4177zQ==
X-Received: by 2002:a5d:680a:: with SMTP id w10mr23479652wru.42.1560145551475;
        Sun, 09 Jun 2019 22:45:51 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id e13sm21851849wra.16.2019.06.09.22.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 22:45:50 -0700 (PDT)
Date:   Mon, 10 Jun 2019 06:45:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Message-ID: <20190610054548.GD4797@dell>
References: <20190422031251.11968-1-ronald@innovation.ch>
 <20190422031251.11968-2-ronald@innovation.ch>
 <20190507122415.GC29524@dell>
 <20190609234951.GB16597@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190609234951.GB16597@innovation.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Jun 2019, Life is hard, and then you die wrote:

> 
> On Tue, May 07, 2019 at 01:24:15PM +0100, Lee Jones wrote:
> > On Sun, 21 Apr 2019, Ronald Tschalär wrote:
> > 
> > > The iBridge device provides access to several devices, including:
> > > - the Touch Bar
> > > - the iSight webcam
> > > - the light sensor
> > > - the fingerprint sensor
> > > 
> > > This driver provides the core support for managing the iBridge device
> > > and the access to the underlying devices. In particular, since the
> > > functionality for the touch bar and light sensor is exposed via USB HID
> > > interfaces, and the same HID device is used for multiple functions, this
> > > driver provides a multiplexing layer that allows multiple HID drivers to
> > > be registered for a given HID device. This allows the touch bar and ALS
> > > driver to be separated out into their own modules.
> > > 
> > > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> > > ---
> > >  drivers/mfd/Kconfig               |  15 +
> > >  drivers/mfd/Makefile              |   1 +
> > >  drivers/mfd/apple-ibridge.c       | 883 ++++++++++++++++++++++++++++++
> > 
> > I haven't taken a thorough look through, but I can tell you that the
> > vast majority of what you're trying to do here does not belong in
> > MFD.  MFD drivers are used to register child devices.  Almost all
> > functionality or 'real work' should be contained in the drivers the
> > MFD registers, not in the MFD parent itself.  You will need to move
> > all 'real work' out into the subordinate device drivers for
> > acceptance.
> 
> Thanks for your feedback. That was/is the idea: the actual Touch Bar
> and ALS driver code is in separate modules - what is left in the
> appple-ibridge mfd driver is a fairly generic hid driver
> demultiplexer. However, that could be moved out into it's own
> helper/module.
> 
> Having said that, it looks like the preference is to do all of this as
> a hid driver with virtual hid devices instead of as an mfd driver.

Sounds like a better approach.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
