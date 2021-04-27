Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4726036C0C0
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhD0IZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:25:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2920 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhD0IZ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:25:29 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FTvkP3KZlz6xhVc;
        Tue, 27 Apr 2021 16:17:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 10:24:45 +0200
Received: from localhost (10.52.123.122) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Apr
 2021 09:24:44 +0100
Date:   Tue, 27 Apr 2021 09:23:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Frank Zago <frank@zago.net>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: core: fix list breakage in
 iio_device_unregister()
Message-ID: <20210427092311.00000cb5@Huawei.com>
In-Reply-To: <20210427022017.19314-1-frank@zago.net>
References: <20210427022017.19314-1-frank@zago.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.122]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Apr 2021 21:20:16 -0500
Frank Zago <frank@zago.net> wrote:

> From: frank zago <frank@zago.net>
> 
> The ioctl handlers are unlinked and freed in
> iio_buffers_free_sysfs_and_mask(). Do not break the list prematurely.
> 
> This fixes the following GPF when a client module is removed:
> 
> [  157.007865] general protection fault, probably for non-canonical address 0xdead000000000100: 0000 [#1] SMP NOPTI
> [  157.007876] CPU: 6 PID: 2353 Comm: rmmod Not tainted 5.12.0+ #29
> [  157.007882] ...
> [  157.007886] RIP: 0010:iio_device_ioctl_handler_unregister+0xd/0x30 [industrialio]
> [  157.007904] Code: 00 48 89 77 08 48 89 3e 48 89 e5 48 89 46 08 48 89 30 5d c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 08 48 8b 17 55 <48> 89 42 08 48 89 10 48 89 e5 48 b8 00 01
>  00 00 00 00 ad de 5d 48
> [  157.007910] RSP: 0018:ffffa9b840a57d70 EFLAGS: 00010202
> [  157.007916] RAX: dead000000000122 RBX: ffff95484e9a8000 RCX: 0000000000000000
> [  157.007920] RDX: dead000000000100 RSI: 0000000000000246 RDI: ffff9548489a2360
> [  157.007923] RBP: ffffa9b840a57da0 R08: 0000000000000000 R09: ffffa9b840a57d18
> [  157.007926] R10: 0000000000000000 R11: ffff95489f3e5180 R12: ffff95484e9a8000
> [  157.007929] R13: ffff95484e9a8390 R14: ffff95484e9a8000 R15: 0000000000000000
> [  157.007933] FS:  00007fd35bd18540(0000) GS:ffff954b4eb80000(0000) knlGS:0000000000000000
> [  157.007937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  157.007941] CR2: 000055e1e29d4818 CR3: 000000010ae76000 CR4: 00000000003506e0
> [  157.007945] Call Trace:
> [  157.007950]  ? iio_buffers_free_sysfs_and_mask+0x2a/0xb0 [industrialio]
> [  157.007965]  iio_device_unregister+0xba/0xc0 [industrialio]
> [  157.007978]  tcs3472_remove+0x1e/0x90 [tcs3472]
> [  157.007984]  i2c_device_remove+0x2b/0xa0
> [  157.007993]  __device_release_driver+0x181/0x240
> [  157.008000]  driver_detach+0xd5/0x120
> [  157.008005]  bus_remove_driver+0x5c/0xe0
> [  157.008010]  driver_unregister+0x31/0x50
> [  157.008014]  i2c_del_driver+0x46/0x70
> [  157.008020]  tcs3472_driver_exit+0x10/0x5dd [tcs3472]
> [  157.008026]  __do_sys_delete_module.constprop.0+0x183/0x290
> [  157.008033]  ? exit_to_user_mode_prepare+0x37/0x1c0
> [  157.008041]  __x64_sys_delete_module+0x12/0x20
> [  157.008045]  do_syscall_64+0x40/0xb0
> [  157.008052]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  157.008058] RIP: 0033:0x7fd35be5aceb
> [  157.008063] Code: 73 01 c3 48 8b 0d 7d 91 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 91 0c 00 f7 d8 64 89 01 48
> [  157.008068] RSP: 002b:00007ffe90b07478 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [  157.008073] RAX: ffffffffffffffda RBX: 000055e1e29ca770 RCX: 00007fd35be5aceb
> [  157.008076] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055e1e29ca7d8
> [  157.008079] RBP: 00007ffe90b074d8 R08: 0000000000000000 R09: 0000000000000000
> [  157.008081] R10: 00007fd35bed5ac0 R11: 0000000000000206 R12: 00007ffe90b076b0
> [  157.008084] R13: 00007ffe90b08807 R14: 000055e1e29ca2a0 R15: 000055e1e29ca770
> [  157.008089] Modules linked in: tcs3472(-) industrialio_triggered_buffer kfifo_buf industrialio ch341_buses binfmt_misc snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_pcm wmi_bmof snd_seq snd_timer snd_seq_device input_leds rapl snd ccp k10temp soundcore wmi mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 dm_crypt hid_generic usbhid hid radeon i2c_algo_bit drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core drm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel r8169 crypto_simd cryptd ahci i2c_piix4 xhci_pci realtek libahci xhci_pci_renesas gpio_amdpt gpio_generic [last unloaded: tcs3472]
> [  157.008167] ---[ end trace c8eef7a3c5a40ff0 ]---
> 
> Signed-off-by: frank zago <frank@zago.net>

Hi Frank,

Already have a patch queued up that is identical to this one.
It just came in a tiny bit late wrt to merge window so will go
upstream in a week or two.

Thanks,

Jonathan



> ---
>  drivers/iio/industrialio-core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d92c58a94fe4..9e59f5da3d28 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1926,9 +1926,6 @@ EXPORT_SYMBOL(__iio_device_register);
>   **/
>  void iio_device_unregister(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	struct iio_ioctl_handler *h, *t;
> -
>  	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>  
>  	mutex_lock(&indio_dev->info_exist_lock);
> @@ -1939,9 +1936,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  
>  	indio_dev->info = NULL;
>  
> -	list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
> -		list_del(&h->entry);
> -
>  	iio_device_wakeup_eventset(indio_dev);
>  	iio_buffer_wakeup_poll(indio_dev);
>  

