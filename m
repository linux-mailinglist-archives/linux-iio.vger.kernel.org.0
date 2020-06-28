Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA36F20C7ED
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgF1MgL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgF1MgL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:36:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421E820738
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 12:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347770;
        bh=ogPaP2fhjsQkguPyUOMg24PXA8hfGI0+6RhV6F8c8xM=;
        h=Date:From:To:Subject:From;
        b=jGj3CyCYoJTGi9YjPLUHiKmw6dvQd1n5qMTDt8npv4+GhVxvw3djrT13us7Yb+Rdb
         Jwh+ZQzTAhDJEHPs23azki9OjlpQuabMozcd1+EQEjUyleDI/wJ0ds6Gh6RjvunDRT
         NJtuIthiYIdElQ+7nTJGG9zRqalN8M/4GMFP3NEQ=
Date:   Sun, 28 Jun 2020 13:36:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: Interest in a virtual IIO microconf?
Message-ID: <20200628133607.61d31ed1@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All

Summary:

Is there enough IIO developer interest in spending a few hours talking about
IIO topics?  Note we may go deep in places but other topics need a wide range
of people and experience to be useful!

So, I have thought about trying to organize a workshop / microconf at one of the
big Linux conferences in the past.  However, I've not done anything about it
because :

1. Active IIO developers are geographically spread out, so chances are we
   would only get a small subset of people.  Whilst that's fine for having
   a few beers/coffee and a chat, it is not so good on an inclusive / useful basis
   for making any progress.  Whilst the Linux foundation and others do their
   best to encourage a wide range of people to attend these events, the reality
   is that going to a conference is expensive in money and/or time.

2. Whilst I have personally been going to more conferences in recent times than
   I did a few years back, they aren't always 'the right ones' for this sort
   of meeting.

3. It wasn't obvious that we would actually have a enough to talk about.
   This is more of an issue if it involved people jumping on planes with all
   the issues that brings.

4. I've mulled trying something virtual in the past but was unconvinced we could
   do it in fashion that would make it more productive than email exchanges.

Anyhow, a huge amount has changed this year.  I'm sure everyone is getting more
used to doing things online and it's clear that useful meetings of this type
can occur without getting everyone sat around a table.

Clearly lots of open questions around this:

* What would we talk about?

* Are enough people interested? 

* When?  Can we actually find a timezone or date that works for enough people?
  Particularly true given mixture of people who do IIO for their day jobs and
  those who do it out of work time!

  Note that, for a first such event I'd suggest we are looking at around 3 hours.

* Platform: We could try and associate with an existing event, but as it will be small
  we probably don't need the heavy weight logistics of something like Plumbers
  (side note - their online conferencing setup is very impressive).

  My personal preference is Zoom as it seems more reliable than alternatives
  (even though it's closed source etc... :( Video optional!

I have a few thoughts on topics (in no particular order)

1. Generic process stuff.  Should we change how the IIO subsystem is maintained?
   I know I have a few things I'd like to briefly discuss.  Note this is standard
   feature in pretty much every open source project microconf!

2. Major out of tree patches.  
   - What is out there?  Perhaps there is room to collaborate around some of this.
   - Do we have a path to upstream them?

3. Topics on the horizon?  Where should we go?
   - One topic in here is potentially around virtualization on embedded
     platforms and how IIO might fit within that.

4. Mentorship / support of new developers.
   - Would love to get some inputs on this from both people who do a lot of
     this and from those who have recently been on the 'newbie' side of things!

5. Usecases.  I'd personally love to hear a bit about what people are actually
   doing with all these devices!  I'd also be interested in pain points etc.

6. Userspace stacks.  More discussion around pain points etc than an overview of
   what there is.

7. Testing / emulation?  What do people have in place, and what can we do to
   improve it?

8+ What do other people want to talk about?

Some of these topics pretty much require particular people, so we may not be
able to do them usefully this time. Note the above list may well be
too many topics already so chances are we won't get through everything people
want to talk about.

Anyhow, thoughts?

We can leave the "when" question until we have an idea of whether it makes
sense to do this at all.  

Jonathan

p.s. As ever ideally keep discussion on list but if anyone wants to raise anything
privately feel free to email me directly.

