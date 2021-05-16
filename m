Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0018381D7A
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhEPJA3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 05:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhEPJA2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 05:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621155553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOHEyrR61mNBlfkYRy6Es5ZkhPvaNiFTn2YEyB2DVCY=;
        b=IWAqUEzZspOODd8+yuujfGNc8vXiPmkTPAckTTOo6kJJEmKwUMq4R+7bfTGJklCqmFY2Bt
        uIeQVuIW9jD0pJB+oEPgc6qQgXvnzkCuASsWbpsxF/6hxjjRTC18RlvhOhEeBEpy6TbFXo
        CgiTOeuVxSZCbH0veOoWqnIWi+p0nkI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-AFeQDBtONDeMapmrcU2r3g-1; Sun, 16 May 2021 04:59:11 -0400
X-MC-Unique: AFeQDBtONDeMapmrcU2r3g-1
Received: by mail-ed1-f69.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso2080727edz.6
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 01:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOHEyrR61mNBlfkYRy6Es5ZkhPvaNiFTn2YEyB2DVCY=;
        b=NTEPpm99eb8iP3b6lwhji0ROJL+ayjLZsof1oYbVXHwVzYE6+ZIcYOExu2cNaM34HO
         OMjDfpS3DLXjVnxY2j5MfXHhLYvd/p3Q4izk/JbYDlj0wVFZeg3X6WPO1pziBzjn4wG7
         vHeq7ozDJM2UpqlM0/m8qKKOo6mO1bA1v8aOPvlF6F8owJmU2cHh06xFXe47w/8VvEhf
         Ff9sVOXG4pFryq9uO+IarDxn0lroI8Kj4AybxU2JRaPeymQ6AGKfPV2lc37ZtAzz48pb
         brmWStPlguZKznNYKznA414h9jKKMGkXmRQInTUTGpJ47TiXu6g5qmrmcrLBV3Anti4x
         BKJQ==
X-Gm-Message-State: AOAM530iuuIPOen6mTrtDmbwY+CHRcYSk3zbo+i09JMe9dvPltTgeuhS
        XX0Htmfo7lrR0Ht+I0kYhF7ZJMkPRTk1BP6D9G8R/vdQyURQVQGq/y5cb98sh3ksApVhYS4JNtr
        3YfW2dHdX/T4RLXLtSPAU
X-Received: by 2002:a50:ab06:: with SMTP id s6mr56142787edc.100.1621155550303;
        Sun, 16 May 2021 01:59:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBl8hheRj1skZwmwgI5hVbbwb673baqhMwhtl6w2WSRSwY3QoX3/4LBGbdMUgZ3Z8DUmGHHw==
X-Received: by 2002:a50:ab06:: with SMTP id s6mr56142772edc.100.1621155550096;
        Sun, 16 May 2021 01:59:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c3sm8725797edn.16.2021.05.16.01.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 01:59:09 -0700 (PDT)
Subject: Re: [PATCH] iio: core: Fix BUG() on rmmod of iio-drivers caused by
 double list_del()
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
References: <20210514195916.44232-1-hdegoede@redhat.com>
 <CA+U=DsqhkbSNDWvYH0O7gYFHZzj48BPpDt04=APm+fKTtyo14Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <99a4be3d-56a0-3699-884c-5431f7ff2701@redhat.com>
Date:   Sun, 16 May 2021 10:59:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CA+U=DsqhkbSNDWvYH0O7gYFHZzj48BPpDt04=APm+fKTtyo14Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/15/21 8:57 AM, Alexandru Ardelean wrote:
> On Fri, May 14, 2021 at 11:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Removing an iio-driver module (or unbinding the driver) causes a BUG() to
>> trigger when the kernel is build with list-debugging enabled. This is
>> caused by a double list_del() introduced by commit 8dedcc3eee3a ("iio:
>> core: centralize ioctl() calls to the main chardev").
>>
>> This patch introduces an ioctl_handlers list to which ioctl handlers are
>> added. The cleanup of these however happens twice.
>>
>> The 2 registration functions:
>> iio_device_ioctl_handler_register()
>> iio_device_register_eventset()
>>
>> Have matching unregister functions which do a list_del on the head added
>> to the list; and iio_device_unregister() has:
>>
>>     list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
>>         list_del(&h->entry);
> 
> This patch should already be in the fixes-togreg tree of IIO.
> I am not sure when/if it went in next.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=901f84de0e16bde10a72d7eb2f2eb73fcde8fa1a

Ah, interesting that 2 people managed to hit this issue at more or less
the same time, given that the bug has been present for a while now.

Anyways I'm happy that a fix for this is on its way already :)

Regards,

Hans




> 
>>
>> This is a problem because iio_device_unregister() does this before calling
>> iio_buffers_free_sysfs_and_mask() which calls
>> iio_device_ioctl_handler_unregister() which calls list_del on the entry
>> added by iio_buffers_alloc_sysfs_and_mask() a second time causing this:
>>
>> [root@fedora ~]# rmmod bmc150_accel_i2c
>> Segmentation fault
>>
>> [  160.627546] ------------[ cut here ]------------
>> [  160.627549] kernel BUG at lib/list_debug.c:45!
>> [  160.629125] invalid opcode: 0000 [#1] SMP PTI
>> [  160.629140] CPU: 0 PID: 1139 Comm: rmmod Tainted: G            E     5.13.0-rc1+ #341
>> [  160.629146] Hardware name: LENOVO 80M1/Mini, BIOS C7CN31WW 08/05/2016
>> [  160.629149] RIP: 0010:__list_del_entry_valid.cold+0xf/0x47
>> ...
>> [  160.629202] Call Trace:
>> [  160.629209]  iio_device_ioctl_handler_unregister+0xe/0x90 [industrialio]
>> [  160.629226]  iio_device_unregister_trigger_consumer+0x21d/0x2f0 [industrialio]
>> [  160.629239]  bmc150_accel_core_remove+0x20/0xd0 [bmc150_accel_core]
>> [  160.629246]  i2c_device_remove+0x25/0xb0
>> [  160.629254]  __device_release_driver+0x180/0x240
>> [  160.629261]  device_release_driver+0x26/0x40
>> [  160.629267]  bus_remove_device+0xf2/0x160
>> [  160.629272]  device_del+0x18c/0x3e0
>> [  160.629280]  device_unregister+0x16/0x60
>> ...
>>
>> Since iio_device_ioctl_handler_unregister/iio_device_unregister_eventset()
>> already do the list_del() there is no need for the
>> list_for_each_entry_safe() in iio_device_unregister() which also does the
>> list_del(). Remove the list_for_each_entry_safe() to fix the double
>> list_del() issue.
>>
>> Fixes: 8dedcc3eee3a ("iio: core: centralize ioctl() calls to the main chardev")
>> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/iio/industrialio-core.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index d92c58a94fe4..9e59f5da3d28 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1926,9 +1926,6 @@ EXPORT_SYMBOL(__iio_device_register);
>>   **/
>>  void iio_device_unregister(struct iio_dev *indio_dev)
>>  {
>> -       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>> -       struct iio_ioctl_handler *h, *t;
>> -
>>         cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>>
>>         mutex_lock(&indio_dev->info_exist_lock);
>> @@ -1939,9 +1936,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>>
>>         indio_dev->info = NULL;
>>
>> -       list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
>> -               list_del(&h->entry);
>> -
>>         iio_device_wakeup_eventset(indio_dev);
>>         iio_buffer_wakeup_poll(indio_dev);
>>
>> --
>> 2.31.1
>>
> 

