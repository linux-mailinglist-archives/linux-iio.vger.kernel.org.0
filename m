Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409BE245723
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgHPJkN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgHPJkM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 05:40:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A91206C0;
        Sun, 16 Aug 2020 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597570812;
        bh=vPpeiVud4FvYKTclYglm+JI/kvxIy5SLU23p5fkd89U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D49AnQq9rAXvMmcrYWPpYlAoRpW2BHstVnak7OedIoBaveTdCidXWLpBN8ow6X3K6
         dK6JkxgvPF0F2bf2C6kYqpM82mmbXPyd+H7bSXrlQRt7adstOlgMRf0h8jxpXDWN+m
         Gow+ldEc3HvHT1w5OZtZdFE6lNqoyj5JGzpbI+d4=
Date:   Sun, 16 Aug 2020 10:40:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and
 SC7A30E
Message-ID: <20200816104009.76cb3870@archlinux>
In-Reply-To: <CAFr9PXkPXOef1rSKbHSEFdSJiogwQN2hdM+fdEpkcfTa93igvg@mail.gmail.com>
References: <20200811134846.3981475-1-daniel@0x0f.com>
        <20200811134846.3981475-3-daniel@0x0f.com>
        <20200816095215.6f3513d2@archlinux>
        <CAFr9PXkPXOef1rSKbHSEFdSJiogwQN2hdM+fdEpkcfTa93igvg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Aug 2020 18:27:03 +0900
Daniel Palmer <daniel@0x0f.com> wrote:

> Hi Jonathan,
> 
> On Sun, 16 Aug 2020 at 17:52, Jonathan Cameron <jic23@kernel.org> wrote:
> > Same issue with sign off.  
> 
> I didn't think that was needed for an RFC. I'll add the sign off to the v1.

I'd always put them in anyway as RFCs sometimes get picked up if the
comments are all positive!

> 
> > + Needs to be added to the device tree documentation in
> > Documentation/devicetree/bindings/iio/st-sensors.txt  
> 
> I'll add that in. Other than that was the change OK? I wasn't sure a
> massive copy/paste
> would be acceptable.

It's always a trade off with cases like this on whether we want to
add complexity to the code to handle different WAI values, or just
have a bit more constant data and replicate stuff.

I'm fine with the replicating options, but of course others may not be.

Jonathan

> 
> Thanks,
> 
> Daniel

