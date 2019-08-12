Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7CB89BA7
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfHLKh5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 06:37:57 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:37820 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfHLKh5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Aug 2019 06:37:57 -0400
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1hx7i3-0000Gn-7t; Mon, 12 Aug 2019 12:37:51 +0200
Date:   Mon, 12 Aug 2019 12:37:51 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: Is storing output values to non volatile registers
 something we should do automatically or leave to userspace action.  [was Re:
 [PATCH] iio: potentiometer: max5432: update the non-volatile position]
Message-ID: <20190812103751.gumfzgazlytq5zqm@viti.kaiser.cx>
References: <20190809160617.21035-1-martin@kaiser.cx>
 <20190811101137.5bd495e9@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811101137.5bd495e9@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thus wrote Jonathan Cameron (jic23@kernel.org):

> The patch is fine, but I'm wondering about whether we need some element
> of policy control on this restore to current value.

> A few things to take into account.

> * Some devices don't have a non volatile store.  So userspace will be
>   responsible for doing the restore on reboot.
> * This may be one of several related devices, and it may make no sense
>   to restore this one if the others aren't going to be in the same
>   state as before the reboot.
> * Some devices only have non volatile registers for this sort of value
>   (or save to non volatile on removal of power). Hence any policy to
>   not store the value can't apply to this class of device.

I see your point. You'd like a consistent bahaviour across all
potentiometer drivers. Or at least a way for user space to figure out
whether a chip uses non-volatile storage or not.
This property doesn't quite fit into the channel info that are defined
in the arrays in drivers/iio/industrialio-core.c. Is there any other way
to set such a property?

> My initial thought is that these probably don't matter that much and
> we should apply this, but I would like to seek input from others!

> I thought there were some other drivers doing similar store to no
> volatile but I can't find one.

drivers/iio/potentiometer/max5481.c and max5487.c do something similar.

They use a command to transfer the setting from volatile to non-volatile
register in the spi remove function. I guess that the intention is to
save the current setting when the system is rebooted. However, my
understanding is that the remove function is called only when a module
is unloaded or when user space does explicitly unbind the device from
the bus via sysfs. That's why I tried using the shutdown function
instead.

Still, this approach has some disadvantages. For many systems, there's a
soft reboot (shutdown -r) where the driver's shutdown function is called
and a "hard reboot" where the power from the CPU and the potentiometer
chip is removed and reapplied. In this case, the current value would not
be transfered to the non-volatile register. 

At least for the max5432 family, there's no way to read the current
setting. The only option for user space to have a well-defined setting
is to set the wiper position explicitly at startup.

I guess the only sensible way to use a non-volatile register would be a
write operation where user space gets a response about successful
completion.

We could have two channels to write to the volatile or to non-volatile
register. Or we stick to one channel and update both volatile and
non-volatile registers when user space changes the value. This assumes
that the setting does not change frequently, which is prabably not true
for all applications...

Whatever we come up with, we should at least make the max* chips behave
the same way.

Best regards,
Martin
