Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CE13BD3A9
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhGFL6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 07:58:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:54311 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240630AbhGFLrC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Jul 2021 07:47:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="209053296"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="209053296"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 04:40:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="427558993"
Received: from mylly.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2021 04:40:14 -0700
Subject: Re: [PATCH v12 15/17] counter: Implement events_queue_size sysfs
 attribute
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <e298043c880b350a42bdc40452376a3708bf533b.1625471640.git.vilhelm.gray@gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <1a624011-0b43-ac42-be53-a42f81923e5a@linux.intel.com>
Date:   Tue, 6 Jul 2021 14:40:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e298043c880b350a42bdc40452376a3708bf533b.1625471640.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 7/5/21 11:19 AM, William Breathitt Gray wrote:
> The events_queue_size sysfs attribute provides a way for users to
> dynamically configure the Counter events queue size for the Counter
> character device interface. The size is in number of struct
> counter_event data structures. The number of elements will be rounded-up
> to a power of 2 due to a requirement of the kfifo_alloc function called
> during reallocation of the queue.
> 
...
> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> index 92805b1f65b8..13644c87d02a 100644
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -323,6 +323,9 @@ static int counter_chrdev_open(struct inode *inode, struct file *filp)
>   							    typeof(*counter),
>   							    chrdev);
>   
> +	if (!mutex_trylock(&counter->chrdev_lock))
> +		return -EBUSY;
> +
>   	get_device(&counter->dev);
>   	filp->private_data = counter;
>   
> @@ -339,6 +342,7 @@ static int counter_chrdev_release(struct inode *inode, struct file *filp)
>   		return err;
>   
>   	put_device(&counter->dev);
> +	mutex_unlock(&counter->chrdev_lock);
>   
>   	return 0;
>   }

I got two separate mutex warnings from counter_chrdev_open() by doing 
blind "cat /dev/counter0". First one due mutex being uninitialized:

[  441.057342] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[  441.057355] WARNING: CPU: 2 PID: 366 at kernel/locking/mutex.c:1416 
mutex_trylock+0xf2/0x130
...
[  441.217331] Call Trace:
[  441.220062]  counter_chrdev_open+0x21/0x60 [counter]
...

which I fixed trivially by (please be free to use it)

--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -364,6 +364,7 @@ int counter_chrdev_add(struct counter_device *const 
counter)
         spin_lock_init(&counter->events_list_lock);
         init_waitqueue_head(&counter->events_wait);
         mutex_init(&counter->events_lock);
+       mutex_init(&counter->chrdev_lock);

         /* Initialize character device */
         cdev_init(&counter->chrdev, &counter_fops);

and after that

[   16.564403] ================================================
[   16.570725] WARNING: lock held when returning to user space!
[   16.577044] 5.13.0-next-20210706+ #4 Not tainted
[   16.582198] ------------------------------------------------
[   16.588507] cat/331 is leaving the kernel with locks still held!
[   16.595214] 1 lock held by cat/331:
[   16.599103]  #0: ffff888102bb3630 
(&counter->chrdev_lock){+.+.}-{3:3}, at: counter_chrdev_open+0x21/0x60 
[counter]

Jarkko
