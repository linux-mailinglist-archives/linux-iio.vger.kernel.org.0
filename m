Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4656529D34F
	for <lists+linux-iio@lfdr.de>; Wed, 28 Oct 2020 22:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgJ1Vm1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Oct 2020 17:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgJ1VmX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Oct 2020 17:42:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF0B247F3;
        Wed, 28 Oct 2020 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603904065;
        bh=wHOOQ68Dht3JUM0PmZ/p1O1vLvrJcv6F07gE0vDYiuU=;
        h=Date:From:To:Subject:From;
        b=IDwytevgtHkkQ+SG1TrgW1g2hYyuTWsce2VjCWQDXDPQTB0nXPfwCV+AujaycOmcZ
         ma2WOgwVWZUkO6K+QsThjIL2lWj90fdGZYzzQ7iqp1SPSAL2FVxrPM35s49KisqBKg
         MIWHZbn6WTgLI0K6r82m2Zf3Bda3FI3nEVKA3pew=
Date:   Wed, 28 Oct 2020 16:54:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: iio: dt-schema addtiions. Pull request on github.
Message-ID: <20201028165420.1c229ea2@archlinux>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All / Rob,

I'm not 100% sure on the process Rob uses for these, but I've just created
a github pull request.

https://github.com/devicetree-org/dt-schema/pull/48

Patches to convert over all the users of these bits of schema will follow
just as soon as I've had time to do appropriate checks etc.  Just under 100
patches including v2 of the last set :)

I may break up the full set, but have patches for all IIO yaml with the
exception of xilinx-xadc (and a few more below) because I believe that
is already under way and don't want to duplicate work.

Been an interesting process and in particular it is amazing how many of
the examples in the txt file don't pass tests due to typos etc.

A few exceptions that we need to figure out what to do with:
lis302:  This is a ancient binding for the old misc driver.  I can just
         blindly convert it to yaml, but I'd like to consider dropping it
         in favour of the more modern st-sensors binding.

mount-matrix:  This is in the github pull above, but there is a 'huge'
         amount of documentation that I don't want to hid in that repo.
         Perhaps the best plan is to add a page to the iio docs to
         talk through both the binding and the userspace interface for this.

io-channel-mux:  I might do this one at somepoint but it needs the
         rest of the mux subsystem bindings to be converted at the same
         time.

One fun bit is we are likely to find warnings on the dts/dtsi files in mainline
as a result of doing this. I will need some help cleaning those out as often
it is a question of filling a missing value for some ancient board.  What fun :)

Jonathan


