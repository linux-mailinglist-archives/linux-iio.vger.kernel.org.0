Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C775C77EDD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfG1JvT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 05:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfG1JvT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 05:51:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB2702075E;
        Sun, 28 Jul 2019 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564307477;
        bh=5yQReiQmlAjseeBhVWlGoY4KOLXKEM+D8WUu1QJqYEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P3BgThII09MSUvghzasHMTsURF5Vi87gDORjR4+4C/C2zJO1/6CzNg+JIBkWEqJe8
         osnDtdYNPntkv+pEES1v1gzfmXNCP8ioypb5XdMxxnazkWX2k0U+I4LWKuY1QeF3BQ
         losFXYjDh3zs2wLeWaa5vs6B2n821wAZk1plKdFI=
Date:   Sun, 28 Jul 2019 10:51:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] iio: dummy_evgen: check iio_evgen in
 iio_dummy_evgen_free()
Message-ID: <20190728105113.53b4efdf@archlinux>
In-Reply-To: <c691dfa4-4490-d643-e184-ea487bcbea94@huawei.com>
References: <20190509020447.20243-1-wangkefeng.wang@huawei.com>
        <20190511095855.1aaf056b@archlinux>
        <c691dfa4-4490-d643-e184-ea487bcbea94@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 May 2019 20:14:24 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> On 2019/5/11 16:58, Jonathan Cameron wrote:
> > On Thu, 9 May 2019 10:04:47 +0800
> > Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >  
> >> if iio_dummy_evgen_create() fails, iio_evgen should be NULL, when call
> >> iio_evgen_release() to cleanup, it throws some warning and could cause
> >> double free.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>  
> > Hi Kefeng,
> >
> > I'm not seeing a path to be able to trigger this.
> > iio_dummy_evgen_create is called only in the module_init.
> > If it fails, then the init fails before the device
> > initialization call is made.
> >
> > How would we then be running the device release call
> > in order to end up freeing this again?
> >
> > So I think this is a false positive but perhaps there is
> > a path that I am missing.  
> 
> Hi Jonathan,
> 
> Here is one of out inner test robot log, could you check it?

Sorry it's taking me an extremely long time to get to you on this!
This one always comes bottom of my heap as it's a demo driver
only so can't break anyone's real systems.

There is clearly an issue here as you identified. I actually think
it's worse than you have highlighted because that global pointer
is accessed from other modules and so could cause a more direct
problem.  For that we probably need to ensure we only set the
global pointer after we are sure we have succeeded. (so use a local
variable until that point).

I'm still a little confused on the path that leads to the dump
below, but given there is clearly a bug anyway so the
exact trigger doesn't really matter :)

My confusion is that a failure in a module_init should result
in the module being removed in do_init_module drivers/base/module.c.
So the question is are we triggering in that path or in an explicit
attempt to remove the module later.

My suspicion is that we are fixing this partly at the wrong level.

The device_unregister is being called on a device that
was never registered (though I'm not certain why)

If it's correct that exit should be called after a failed init
via some path, then a level of indirection or a flag to say if the
device is registered yet should solve the particular case you hit.

Jonathan

> 
> 
> [ 2606.472327] FAULT_INJECTION: forcing a failure.
> [ 2606.472327] name failslab, interval 1, probability 0, space 0, times 0
> [ 2606.476620] CPU: 0 PID: 7076 Comm: syz-executor.0 Tainted: G         C        5.1.0+ #28
> [ 2606.477571] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [ 2606.477571] Call Trace:
> [ 2606.477571]  dump_stack+0xa9/0x10e
> [ 2606.477571]  should_fail+0x3ca/0x3f0
> [ 2606.477571]  ? fault_create_debugfs_attr+0x1c0/0x1c0
> [ 2606.477571]  ? lock_downgrade+0x2d0/0x2d0
> [ 2606.477571]  ? pageset_set_high_and_batch+0xd0/0xd0
> [ 2606.477571]  ? __kernfs_new_node+0xbb/0x3a0
> [ 2606.477571]  __should_failslab+0x88/0xa0
> [ 2606.477571]  should_failslab+0x5/0x10
> [ 2606.477571]  kmem_cache_alloc+0x3e/0x240
> [ 2606.493436]  __kernfs_new_node+0xbb/0x3a0
> [ 2606.493436]  ? kernfs_dop_revalidate+0x1b0/0x1b0
> [ 2606.493436]  ? __mutex_unlock_slowpath+0xb4/0x3f0
> [ 2606.493436]  ? wait_for_completion+0x240/0x240
> [ 2606.493436]  ? kernfs_next_descendant_post+0xbe/0x190
> [ 2606.493436]  kernfs_new_node+0x6c/0xc0
> [ 2606.493436]  __kernfs_create_file+0x56/0x1b0
> [ 2606.493436]  sysfs_add_file_mode_ns+0x160/0x300
> [ 2606.493436]  internal_create_group+0x255/0x6e0
> [ 2606.493436]  ? remove_files.isra.1+0xb0/0xb0
> [ 2606.493436]  ? sysfs_create_dir_ns+0x100/0x1e0
> [ 2606.493436]  ? sysfs_create_dir_ns+0x12b/0x1e0
> [ 2606.493436]  ? sysfs_create_mount_point+0x90/0x90
> [ 2606.493436]  sysfs_create_groups+0x6d/0xe0
> [ 2606.493436]  kobject_add_internal+0x355/0x530
> [ 2606.493436]  ? kfree_const+0x33/0x40
> [ 2606.493436]  kobject_add+0x101/0x1a0
> [ 2606.493436]  ? kobject_add_internal+0x530/0x530
> [ 2606.493436]  ? lockdep_init_map+0x98/0x2c0
> [ 2606.493436]  ? lockdep_init_map+0x98/0x2c0
> [ 2606.493436]  ? find_next_bit+0x80/0xb0
> [ 2606.493436]  ? kobject_init+0xa3/0x100
> [ 2606.493436]  irq_sysfs_add+0x39/0x60
> [ 2606.493436]  __irq_alloc_descs+0x242/0x2d0
> [ 2606.493436]  ? 0xffffffffc1920000
> [ 2606.493436]  irq_sim_init+0x6a/0x240
> [ 2606.493436]  ? 0xffffffffc1920000
> [ 2606.493436]  iio_dummy_evgen_init+0x57/0x1000 [iio_dummy_evgen]
> [ 2606.493436]  do_one_initcall+0xb9/0x3b5
> [ 2606.493436]  ? perf_trace_initcall_level+0x270/0x270
> [ 2606.493436]  ? kasan_unpoison_shadow+0x30/0x40
> [ 2606.493436]  ? kasan_unpoison_shadow+0x30/0x40
> [ 2606.493436]  do_init_module+0xe0/0x330
> [ 2606.493436]  load_module+0x38eb/0x4270
> [ 2606.493436]  ? module_frob_arch_sections+0x20/0x20
> [ 2606.493436]  ? kernel_read_file+0x188/0x3f0
> [ 2606.493436]  ? find_held_lock+0x6d/0xd0
> [ 2606.493436]  ? fput_many+0x1a/0xe0
> [ 2606.493436]  ? __do_sys_finit_module+0x162/0x190
> [ 2606.493436]  __do_sys_finit_module+0x162/0x190
> [ 2606.493436]  ? __ia32_sys_init_module+0x40/0x40
> [ 2606.493436]  ? __mutex_unlock_slowpath+0xb4/0x3f0
> [ 2606.493436]  ? wait_for_completion+0x240/0x240
> [ 2606.493436]  ? vfs_write+0x160/0x2a0
> [ 2606.493436]  ? lockdep_hardirqs_off+0xb5/0x100
> [ 2606.493436]  ? mark_held_locks+0x1a/0x90
> [ 2606.493436]  ? do_syscall_64+0x14/0x2a0
> [ 2606.493436]  do_syscall_64+0x72/0x2a0
> [ 2606.493436]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 2606.493436] RIP: 0033:0x463de9
> [ 2606.493436] Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> [ 2606.493436] RSP: 002b:00007fa67f828c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [ 2606.493436] RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000463de9
> [ 2606.493436] RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
> [ 2606.493436] RBP: 00007fa67f828c70 R08: 0000000000000000 R09: 0000000000000000
> [ 2606.493436] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> [ 2606.493436] R13: 00000000006f8748 R14: 00000000004bdeea R15: 00007fa67f8296bc
> [ 2606.569187] kobject_add_internal failed for 33 (error: -12 parent: irq)
> [ 2606.571027] Failed to add kobject for irq 33
> [ 2606.587831] ------------[ cut here ]------------
> [ 2606.589151] kernfs: can not remove 'per_cpu_count', no directory
> [ 2606.590937] WARNING: CPU: 0 PID: 7076 at fs/kernfs/dir.c:1505 kernfs_remove_by_name_ns+0x9d/0xb0
> [ 2606.591782] Kernel panic - not syncing: panic_on_warn set ...
> [ 2606.591782] CPU: 0 PID: 7076 Comm: syz-executor.0 Tainted: G         C        5.1.0+ #28
> [ 2606.591782] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [ 2606.599643] Call Trace:
> [ 2606.600427]  dump_stack+0xa9/0x10e
> [ 2606.600427]  panic+0x1bc/0x434
> [ 2606.602438]  ? refcount_error_report+0x10c/0x10c
> [ 2606.602438]  ? kmsg_dump_rewind_nolock+0x59/0x59
> [ 2606.602438]  ? __probe_kernel_read+0xc6/0xe0
> [ 2606.602438]  ? kernfs_remove_by_name_ns+0x9d/0xb0
> [ 2606.602438]  __warn+0x18e/0x190
> [ 2606.602438]  ? kernfs_remove_by_name_ns+0x9d/0xb0
> [ 2606.602438]  report_bug+0x12c/0x1b0
> [ 2606.602438]  ? kernfs_remove_by_name_ns+0x9d/0xb0
> [ 2606.602438]  fixup_bug.part.11+0x23/0x50
> [ 2606.602438]  do_error_trap+0xc8/0x110
> [ 2606.602438]  do_invalid_op+0x31/0x40
> [ 2606.602438]  ? kernfs_remove_by_name_ns+0x9d/0xb0
> [ 2606.602438]  invalid_op+0x14/0x20
> [ 2606.602438] RIP: 0010:kernfs_remove_by_name_ns+0x9d/0xb0
> [ 2606.602438] Code: c7 c0 5a 9d 8e e8 43 ea a5 00 e8 2e 9a cb ff 89 d8 5b 5d 41 5c c3 e8 22 9a cb ff 48 89 ee 48 c7 c7 c0 7b 31 8e e8 53 ec b2 ff <0f> 0b bb fe ff ff ff eb b5 66 2e 0f 1f 84 00 00 00 00 00 41 57 41
> [ 2606.602438] RSP: 0018:ffff8881be38fcc8 EFLAGS: 00010282
> [ 2606.602438] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81179529
> [ 2606.602438] RDX: 000000000000adf2 RSI: ffffc90001405000 RDI: ffff8881f742684c
> [ 2606.602438] RBP: ffffffff8e270d00 R08: ffffed103ee85e61 R09: ffffed103ee85e61
> [ 2606.602438] R10: 0000000000000000 R11: ffffed103ee85e60 R12: 0000000000000000
> [ 2606.602438] R13: ffffffff8e270b40 R14: 0000000000000000 R15: 0000000000000000
> [ 2606.602438]  ? kernfs_remove_by_name_ns+0x9d/0xb0
> [ 2606.602438]  remove_files.isra.1+0x3f/0xb0
> [ 2606.602438]  sysfs_remove_group+0x68/0xf0
> [ 2606.602438]  sysfs_remove_groups+0x41/0x70
> [ 2606.602438]  kobject_del+0x53/0xb0
> [ 2606.602438]  free_desc+0x33/0x60
> [ 2606.602438]  irq_free_descs+0x5d/0x90
> [ 2606.602438]  irq_sim_fini+0x43/0x60
> [ 2606.602438]  ? iio_dummy_evgen_release_irq+0x60/0x60 [iio_dummy_evgen]
> [ 2606.602438]  iio_evgen_release+0x18/0x30 [iio_dummy_evgen]
> [ 2606.602438]  device_release+0x46/0x100
> [ 2606.602438]  kobject_put+0x1a8/0x220
> [ 2606.602438]  device_unregister+0x23/0x30
> [ 2606.602438]  __x64_sys_delete_module+0x244/0x330
> [ 2606.602438]  ? __ia32_sys_delete_module+0x330/0x330
> [ 2606.602438]  ? __x64_sys_clock_gettime+0xe3/0x160
> [ 2606.602438]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> [ 2606.602438]  ? trace_hardirqs_off_caller+0x3e/0x130
> [ 2606.602438]  ? lockdep_hardirqs_off+0xb5/0x100
> [ 2606.602438]  ? mark_held_locks+0x1a/0x90
> [ 2606.602438]  ? do_syscall_64+0x14/0x2a0
> [ 2606.602438]  do_syscall_64+0x72/0x2a0
> [ 2606.602438]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 2606.602438] RIP: 0033:0x463de9
> [ 2606.602438] Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> [ 2606.602438] RSP: 002b:00007fa67f828c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000b0
> [ 2606.602438] RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000463de9
> [ 2606.602438] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
> [ 2606.602438] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> [ 2606.602438] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> [ 2606.602438] R13: 00000000006f82e0 R14: 00000000004bdc99 R15: 00007fa67f8296bc
> [ 2606.602438] Dumping ftrace buffer:
> [ 2606.602438]    (ftrace buffer empty)
> [ 2606.602438] Kernel Offset: 0xbe00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> 
> 
> 
> >
> > Jonathan  

