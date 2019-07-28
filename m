Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A377E7D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfG1HuT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 03:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfG1HuT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 03:50:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEE72070D;
        Sun, 28 Jul 2019 07:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564300218;
        bh=EMON1xbHxqhol4OWAY88eLLqBUAAabNCHjiC81S7aAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LGuaTLMhdwiDq+5oLIuAxK9XVoZ/s/80qS+cHolmJG5RNnmG2PLPJz4Pf/Deu627K
         TpevS7EwA6/OhT+f9EUq5V6GMBfT6WwAOUqxiMhtiPfnxsuPrteMMgXBGTAuXajEY4
         GayUnT2iTbqojCvckqMgVD/5ttGKUXIljAoRS7Es=
Date:   Sun, 28 Jul 2019 08:50:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
Message-ID: <20190728085010.36040cb2@archlinux>
In-Reply-To: <4C901747-1657-47AD-A9D7-10E41AFB35CB@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
        <CACRpkdZ5Z9VY457Fywt6X=K5XONgiPVcwbwSkwL_U+GCqZ+u5g@mail.gmail.com>
        <4C901747-1657-47AD-A9D7-10E41AFB35CB@goldelico.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Jul 2019 11:46:49 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Linus,
> 
> > Am 23.07.2019 um 09:42 schrieb Linus Walleij <linus.walleij@linaro.org>:
> > 
> > Hi H. Nikolaus,
> > 
> > On Thu, Feb 21, 2019 at 6:03 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >   
> >> From: Linus Walleij <linus.walleij@linaro.org>  
> > 
> > It is fair for you to change authorship to yourself at this point.
> > Just keeping my Signed-off-by is sufficient.  
> 
> Well, I think my contribution is less than yours :)
> 
> >   
> >> The mounting matrix for sensors was introduced in
> >> commit dfc57732ad38 ("iio:core: mounting matrix support")
> >> 
> >> However the device tree bindings are very terse and since this is
> >> a widely applicable property, we need a proper binding for it
> >> that the other bindings can reference. This will also be useful
> >> for other operating systems and sensor engineering at large.
> >> 
> >> I think all 3D sensors should support it, the current situation
> >> is probably that the mounting information is confined in magic
> >> userspace components rather than using the mounting matrix, which
> >> is not good for portability and reuse.
> >> 
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> >> Cc: Sebastian Reichel <sre@kernel.org>
> >> Cc: Samu Onkalo <samu.onkalo@intel.com>
> >> Cc: devicetree@vger.kernel.org
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>  
> > 
> > Did this patch fall off somewhere? I think it's really neat, even in this
> > form it is great help for developers. If you want I can try picking up the
> > comments and resend it.  
> 
> Well, I had planned to review it again and promised to send out a new
> version. But as usual this ToDo becomes hidden by always more important
> tasks.
> 
> So I am fine if you can pick comments and resend it. I think there will
> be others who help to make it even better in the future if the mount matrix
> is more widely used.
> 
> BR,
> Nikolaus
> 
Given the comments that 'need' any response are fairly minor, I've just
taken the view that the perfect is the enemy of the good and applied
it to the togreg branch of iio.git with some really small tweaks.

Thanks for offering to tidy this up Linus, but seems like it would be
a waste of your time for such trivial tweaks!

The only one outstanding that I haven't 'fixed' is the question I raised
on face down or face up when talking about flat on the ground.

That might want a clarifying comment.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it (or not as the case may be!)

Thanks,

Jonathan

