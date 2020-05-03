Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0C1C2DAA
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgECPvL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 11:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgECPvL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 11:51:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584EF206EB;
        Sun,  3 May 2020 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588521070;
        bh=MoYkt8nJNSYHxeNV4ctvv8LFowIxDvxKKgf3MIzhfcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hiDzOyLI23KoKwV6kZszpJJDvJURTVrqGvMNbf4WeHS9st6i18dVI0EmLTcd7qFMN
         lrSXhUvBnf1DfoNUqWa9SubjBBBoc0eHDY0Sg6eJnfL76eudfLBhuwfBi6Wa+fh/FI
         1aMoaOElwL6H9giB6XBPqUh9U6Cluvorc7Dp9QJU=
Date:   Sun, 3 May 2020 16:51:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v6 0/6] iio: core,buffer: re-organize chardev creation
Message-ID: <20200503165105.74047af8@archlinux>
In-Reply-To: <20200427131100.50845-1-alexandru.ardelean@analog.com>
References: <20200427131100.50845-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 16:10:54 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The main intent is to be able to add more chardevs per IIO device, one
> for each buffer. To get there, some rework is needed.
> This tries to re-organize the init of the chardev.

Hmm. I'd like this set to sit and ideally gather a few acks before
I move ahead with it.

The protections against problems around remove have always been
somewhat fiddly and I suspect don't cover everything.

I'm fairly sure taking the exist lock is 'sufficient' but I'm not
actually sure it's necessary.   We only otherwise take it for
place where the inkern interface is in use so we can race
against removal of a provider driver.

We don't have such heavy weight protections in the buffer code
and I'll be honest I can't remember why. Original patch mentions
that it was about avoiding taking additional new references to the
struct iio_dev.  We aren't doing that as such here so perhaps
we don't need to take the lock..

Lars, I suspect you may have been involved in that stuff originally
so I'd appreciate you taking a quick look at this if you have
time!

Thanks,

Jonathan

> 
>  
> Changelog v5 -> v6:
> - patch 'iio: core: register chardev only if needed'
>   - sort file_operations fields for iio_event_fileops
> - patch 'iio: buffer,event: duplicate chardev creation for buffers & events'
>   - fixed-up '**/' -> '*/' for 2 block comments
>   - sorted file_operations for iio_buffer_fileops, after move
>   - removed 'indio_dev->chrdev = NULL' on IIO device unregister
>   - added comment about 'indio_dev->info' NULL check in
>     iio_device_event_ioctl()
> - patch 'iio: core: add simple centralized mechanism for ioctl() handlers'
>   - re-using lock 'indio_dev->info_exist_lock' for new ioctl register
>     mechanism in iio_device_ioctl()
>   - simplified exit condition from the loop; only need to check
>     `ret != IIO_IOCTL_UNHANDLED` to continue looping;
>     everything else is just return/break
> - patch 'iio: core: use new common ioctl() mechanism'
>   - the comment for 'indio_dev->info' NULL check is being moved here to
>     highlight why the null-check is being removed; or where it's being
>     moved
> 
> Changelog v4 -> v5:
> - dropped patch 'iio: Use an early return in iio_device_alloc to simplify code.'
>   is applied upstream
> 
> Changelog v3 -> v4:
> - added patch [1] 'iio: Use an early return in iio_device_alloc to simplify code.'
>   it's main purpose is so that this patch applies:
>      [2]'iio: core: add simple centralized mechanism for ioctl() handlers'
>   depending on the final version of patch [1], patch [2] needs some
>   minor fixup
> - added patch 'iio: core,buffer: wrap iio_buffer_put() call into iio_buffers_put()'
> - patch 'iio: core: register buffer fileops only if buffer present'
>   is now: 'iio: core: register chardev only if needed'
> - dropped 'iio: buffer: move sysfs alloc/free in industrialio-buffer.c'
>   it's likely we won't be doing this patch anymore
> - patches:
>     'iio: buffer: move iio buffer chrdev in industrialio-buffer.c'
>     'iio: event: move event-only chardev in industrialio-event.c'
>   have been merged into 'iio: buffer,event: duplicate chardev creation for buffers & events'
>   since now, the logic is a bit different, and 'indio_dev->chrdev' is
>   now a reference to either the buffer's chrdev & or the events-only
>   chrdev
> - added simple mechanism to register ioctl() handlers for IIO device
>   which is currently used only by events mechanism
> 
> Changelog v2 -> v3:
> * removed double init in
>   'iio: event: move event-only chardev in industrialio-event.c'
> 
> Changelog v1 -> v2:
> * re-reviewed some exit-paths and cleanup some potential leaks on those
>   exit paths:
>   - for 'iio: buffer: move iio buffer chrdev in industrialio-buffer.c'
>     add iio_device_buffers_put() helper and calling iio_buffers_uninit()
>     on device un-regsiter
>   - for 'move sysfs alloc/free in industrialio-buffer.c'
>     call 'iio_buffer_free_sysfs_and_mask()' on exit path if
>     cdev_device_add() fails
>   - for 'move event-only chardev in industrialio-event.c'
>     check if event_interface is NULL in
>     iio_device_unregister_event_chrdev()
> 
> Alexandru Ardelean (6):
>   iio: buffer: add back-ref from iio_buffer to iio_dev
>   iio: core,buffer: wrap iio_buffer_put() call into iio_buffers_put()
>   iio: core: register chardev only if needed
>   iio: buffer,event: duplicate chardev creation for buffers & events
>   iio: core: add simple centralized mechanism for ioctl() handlers
>   iio: core: use new common ioctl() mechanism
> 
>  drivers/iio/iio_core.h            |  29 +++++---
>  drivers/iio/industrialio-buffer.c | 102 ++++++++++++++++++++++++--
>  drivers/iio/industrialio-core.c   | 116 +++++++++++++-----------------
>  drivers/iio/industrialio-event.c  | 100 +++++++++++++++++++++++++-
>  include/linux/iio/buffer_impl.h   |  10 +++
>  include/linux/iio/iio.h           |   8 +--
>  6 files changed, 276 insertions(+), 89 deletions(-)
> 

