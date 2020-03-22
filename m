Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 811BE18EA9E
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCVQ5f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVQ5f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 12:57:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7018C206F8;
        Sun, 22 Mar 2020 16:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584896255;
        bh=Fdqxq266lPbGuDaZ/yl7AHdNhTLSHTmg63L7vb+eiTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xcTrgHu932AP0DbnZ1vvDF6/PoTrapK+LGnaRqhJ2hoWJ+P6ZAm8OkYTHpEsu7fcu
         S/KAOii/yQW2EJ4H2Z0Cby+tK5DREd6SuJETkrEinsGfHL5LuzJE3hx3SUhKe9zkVX
         Y/NcgIygxrIfMwrXR0D84rZqE/yuzAOORHgiwXyI=
Date:   Sun, 22 Mar 2020 16:57:30 +0000
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
Message-ID: <20200322165730.11fa376a@archlinux>
In-Reply-To: <20200322160604.GA222611@leena.republic>
References: <20200320150114.9297-1-alazar@startmail.com>
        <20200320150114.9297-2-alazar@startmail.com>
        <20200321173412.52548ef1@archlinux>
        <20200321193541.GA16892@leena.republic>
        <1e51c4079222858410e9fe94c9d7f21d99abfe15.camel@analog.com>
        <20200322095317.GA3099@leena.republic>
        <20200322152735.36cb3493@archlinux>
        <20200322160604.GA222611@leena.republic>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 18:06:04 +0200
Alexandru Lazar <alazar@startmail.com> wrote:

> > You'd be surprised how often this gets added to drivers precisely because
> > people will put it on a controllable supply.  It may well not have it's own
> > supply but it may share one with a bunch of other external chips and
> > all of them need to use the regulator framework controls to make sure it's
> > only disabled when they are all suspended etc.  
> 
> I figured it might be something like this :-). I've added the vdd-supply
> binding in v5.
> 
> If this isn't something that can be easily handled in the core, do you
> think we can document it somewhere as a convention/common idiom?
> (Assuming it's not already documented, of course). It seems like it's
> something that all IIO devices would need. I can do the writing part.

Hmm. We could do with a sort of 'things you'd normally find in a driver'
document.  We don't have such a document, but interesting to think about
what would be in it...  Perhaps a 'best practice' document would
be a better way of putting it.  I don't really want to see a huge
number of patches adding regulators to drivers that don't have them already
for example.  Clearly no one needed them yet :)

If you want to take a stab at such a document that would be great.

Jonathan


> 
> Thanks,
> Alex

