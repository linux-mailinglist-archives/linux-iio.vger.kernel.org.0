Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD317CF42
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCGQOR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 11:14:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGQOR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 11:14:17 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4D520656;
        Sat,  7 Mar 2020 16:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583597656;
        bh=2ZZOWMZNYi8nFq/v0UQDODXKAvclhwN228DdOWG6Kfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wf0v9vmnQYXB9DyXe+JBnB90AjSxdMLC5+ehwfPfb7+S4ON5WC7VsmENp0aO1lOf8
         aXuDOuNm261zDgjxYh/lnVPpLBkqe77lovXAOnXLnFXYmH+CVkRsGyUvEbZYRZtbHA
         zOwFB1wolY7Gx+cwdQ96OVLj2kqxSpb/zBmMkfvE=
Date:   Sat, 7 Mar 2020 16:14:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC] Open Source Contribution | GSoC 2020
Message-ID: <20200307161413.29949c19@archlinux>
In-Reply-To: <3bc4e978-3719-bbfc-2110-81601272a938@gmail.com>
References: <3bc4e978-3719-bbfc-2110-81601272a938@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 5 Mar 2020 00:41:40 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Hello, IIO!
> 
> This is Nishant Malpani, a fourth-year integrated Master's student, 
> majoring in Electronics and Communications (ECE) engineering, at 
> International Institute of Information Technology, Bangalore, India 
> (IIIT-B).

Hi Nishant and welcome to IIO.

> 
> Driven by my thirst to gain knowledge about the Linux kernel and its 
> various subsystems, I would like to be a part of the IIO community and 
> receive some insights on how to commence contributing.
> 
> Formally, I've done a course on 'Linux Device Driver Development' at my 
> institute wherein I learnt about the various subsystems in the Linux 
> kernel of which IIO was one of them. I learnt extensively about IIO 
> Channels, Triggers, Buffers, Events etc. and further concluded by taking 
> up MCP3008 ADC as a case-study. I'm familiar with the development 
> process and initiated my contribution by submitting a naive patch [1] 
> (although it does need an update). I've also invested some time 
> completing IIO-related tasks listed on what seems like an outdated page 
> [2]. I'm aware of the previous conversations undertaken in this mailing 
> list [3] but I wasn't sure if somebody is already working on it. I'd be 
> delighted to contribute to any of the open tasks!

In some ways it's great that we don't have quite so much low hanging fruit
for newbies in IIO as we had a few years back, but in others it's annoying
that we can't readily point at useful tasks when people ask like you and
Rohit have done.

One additional on going activity you could contribute to is yaml binding
conversions.   The effort that is ongoing to cleanup device tree bindings
and make them 'testable' is a huge task so additional help is welcome.

However, this puts a review burden on both the original authors of the
relevant binding (if still around) and DT maintainers so we should do
this slowly.

If you wanted to look at this, one to start with would be.

Documentation/devicetree/bindings/iio/light/tsl2563.txt

There is documentation in the kernel tree and examples of what it should
look like. 

Another option would be to look for drivers with dt bindings in the driver
that have no binding documents at all and fix that by adding one.
Note that for simple devices it may just be a case of an entry in the
trivial-device.yaml file.

Another project that has been on the todo list for a very long time would
be to look at doing some test development for IIO along the lines of
what Guenter has for i2c devices in hwmon.

https://github.com/groeck/module-tests

They would be fairly basic but might form the basis of regression tests.

If you really get interested in that sort of testing, there are options
like emulating a device in qemu that could be explored, but that isn't
a small project and would only be useful if we then started doing regular
regression testing.

Otherwise the best way to get familiar with IIO is to get some hardware
and start messing around.

Good luck.

Jonathan

> 
> Thank you all for your time.
> 
> With regards,
> Nishant Malpani
> 
> [1] https://marc.info/?l=linux-driver-devel&m=158326078122615&w=2
> [2] https://kernelnewbies.org/IIO_tasks
> [3] https://marc.info/?l=linux-iio&m=158257639113000&w=2

