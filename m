Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75C18E99F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCVP1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 11:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVP1l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 11:27:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8736D20724;
        Sun, 22 Mar 2020 15:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584890861;
        bh=3CssCZF64v9fgPWSZK1WSg+HeERYSeMfmZIBUZnvokE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dAfTaQoQjFygU8FJt+8XuGHWfl/RXqWvDFJ9omvJpVpyT93XDCG2tMUASLvWQvpNl
         tX+3xbf+6rT3DXpIdkeo+mUFxGzBsMnT5CjxObFQC942M5GDuEjDkgXRN8+mtcKDyG
         IRWjP7kg38M+i/A91J/sBjwP2qe+7lBnbYT77lWQ=
Date:   Sun, 22 Mar 2020 15:27:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Message-ID: <20200322152735.36cb3493@archlinux>
In-Reply-To: <20200322095317.GA3099@leena.republic>
References: <20200320150114.9297-1-alazar@startmail.com>
        <20200320150114.9297-2-alazar@startmail.com>
        <20200321173412.52548ef1@archlinux>
        <20200321193541.GA16892@leena.republic>
        <1e51c4079222858410e9fe94c9d7f21d99abfe15.camel@analog.com>
        <20200322095317.GA3099@leena.republic>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 11:53:17 +0200
Alexandru Lazar <alazar@startmail.com> wrote:

> > Yep.
> > Jonathan refers to Vdd input/pin [on the chip] which is different from Vref [REF
> > pin].
> > Not all drivers define Vdd.
> > Some call it AVdd.
> > 
> > [...]
> > 
> > It's an idea to add it, and that can give control to the driver to power-up the
> > ADC, by defining a regulator [vdd-supply] in the device-tree.  
> 
> Hmm... I don't know how useful this would be for the 124x family (I
> doubt anyone who needs one of these will power it from its own,
> independent supply), 

You'd be surprised how often this gets added to drivers precisely because
people will put it on a controllable supply.  It may well not have it's own
supply but it may share one with a bunch of other external chips and
all of them need to use the regulator framework controls to make sure it's
only disabled when they are all suspended etc.

See the number of times Linus Walleij has added this for various sensors
and ADCs because he has boards where the control is needed.

Jonathan


> but it's a pretty harmless change. I can't think of
> any reason to say no :-).
> 
> Thanks,
> Alex

