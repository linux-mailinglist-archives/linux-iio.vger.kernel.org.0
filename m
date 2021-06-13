Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4AE3A57EF
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhFMLSW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 07:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhFMLSV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 07:18:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EBB561279;
        Sun, 13 Jun 2021 11:16:19 +0000 (UTC)
Date:   Sun, 13 Jun 2021 12:18:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Huang <whuang8933@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Can't find trigger_now for sysfs-based triggering
Message-ID: <20210613121818.6d287a00@jic23-huawei>
In-Reply-To: <CADa-vC0c4_0XiLd6GQto6f0h2BZi0CvWiP7v9NTjG9cgXTGoLw@mail.gmail.com>
References: <CADa-vC0c4_0XiLd6GQto6f0h2BZi0CvWiP7v9NTjG9cgXTGoLw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Jun 2021 12:43:12 -0400
William Huang <whuang8933@gmail.com> wrote:

> Hi everyone,
> 
> I hope this is the right place to ask my noob question.
> I'm trying to learn how to write an IIO driver and using a couple
> books as my resource. I managed to write a simple one and perform
> oneshot-based data reads (e.g. cat iio:device0/in_temp_raw).
> 
> Now, I'm trying to set up a trigger-buffered data read. I believe I
> set up the triggers correctly:
> cat trigger0/name > iio:device0/trigger/current_trigger

Sounds like you have a trigger which is not a sysfs trigger
(probably dataready signal from some other sensor).

> echo 1 > iio:device0/scan_elements/in_temp_en
> echo 1 > iio:device0/buffer/enable
> cat /dev/iio\:device0 | xxd -
> 
> Now, I'm not understanding how I should actually perform the trigger.
> From my books, there should be a trigger_now file where I can echo 1
> to trigger, but it's not available in my trigger0/ directory. Also,
> the book references a add_trigger in /sys/devices/iio_sysfs_trigger/
> directory, but that's nowhere to be found as well.
> 
> My .config also has CONFIG_IIO_SYSFS_TRIGGER=m.

You will need to manually probe that module

modprobe iio-sysfs-trig

There is no simple way of autoloading that module as it's not associated
with any actual hardware.

Then you should find the /sys/devices/iio_sysfs_trigger/ directory and
can create a new instance of the sysfs trigger which should work as you
expect.

Jonathan
> 
> Any help/advice would be appreciated!
> 
> Thanks,
> William Huang

