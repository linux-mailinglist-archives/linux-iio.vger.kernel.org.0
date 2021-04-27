Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49536CA42
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhD0RXA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235777AbhD0RW7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 13:22:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F7660FF3;
        Tue, 27 Apr 2021 17:22:14 +0000 (UTC)
Date:   Tue, 27 Apr 2021 18:23:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Frank Zago <frank@zago.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: light: tcs3472: do not free unallocated IRQ
Message-ID: <20210427182300.331bda00@jic23-huawei>
In-Reply-To: <20210427022017.19314-2-frank@zago.net>
References: <20210427022017.19314-1-frank@zago.net>
        <20210427022017.19314-2-frank@zago.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Apr 2021 21:20:17 -0500
Frank Zago <frank@zago.net> wrote:

> From: frank zago <frank@zago.net>
> 
> Allocating an IRQ is conditional to the IRQ existence, but freeing it
> was not. If no IRQ was allocate, the driver would still try to free
> IRQ 0. Add the missing checks.
> 
> This fixes the following trace when the driver is removed:
> 
> [  100.667788] Trying to free already-free IRQ 0
> [  100.667793] WARNING: CPU: 0 PID: 2315 at kernel/irq/manage.c:1826 free_irq+0x1fd/0x370
> [  100.667804] Modules linked in: tcs3472(-) industrialio_triggered_buffer kfifo_buf industrialio ch341_buses binfmt_misc snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core wmi_bmof snd_pcm snd_seq rapl input_leds snd_timer snd_seq_device snd k10temp ccp soundcore wmi mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 dm_crypt hid_generic usbhid hid radeon i2c_algo_bit drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core drm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd r8169 cryptd ahci i2c_piix4 xhci_pci realtek libahci xhci_pci_renesas gpio_amdpt gpio_generic
> [  100.667874] CPU: 0 PID: 2315 Comm: rmmod Not tainted 5.12.0+ #29
> [  100.667878] ...
> [  100.667881] RIP: 0010:free_irq+0x1fd/0x370
> [  100.667887] Code: e8 c8 d8 1b 00 48 83 c4 10 4c 89 f8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 8b 75 d0 48 c7 c7 40 8b 36 93 4c 89 4d c8 e8 d1 2c a2 00 <0f> 0b 4c 8b 4d c8 4c 89 f7 4c 89 ce e8 72 c7 a8 00 49 8b 47 40 48
> [  100.667891] RSP: 0018:ffff9f44813b7d88 EFLAGS: 00010082
> [  100.667895] RAX: 0000000000000000 RBX: ffff8e50caf47800 RCX: ffff8e53cea185c8
> [  100.667897] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8e53cea185c0
> [  100.667900] RBP: ffff9f44813b7dc0 R08: 0000000000000000 R09: ffff9f44813b7b50
> [  100.667902] R10: ffff9f44813b7b48 R11: ffffffff93b53848 R12: ffff8e50c0125080
> [  100.667903] R13: ffff8e50c0136f60 R14: ffff8e50c0136ea4 R15: ffff8e50c0136e00
> [  100.667906] FS:  00007fa28b899540(0000) GS:ffff8e53cea00000(0000) knlGS:0000000000000000
> [  100.667909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  100.667911] CR2: 0000561851777818 CR3: 000000010633a000 CR4: 00000000003506f0
> [  100.667914] Call Trace:
> [  100.667920]  tcs3472_remove+0x3a/0x90 [tcs3472]
> [  100.667927]  i2c_device_remove+0x2b/0xa0
> [  100.667934]  __device_release_driver+0x181/0x240
> [  100.667940]  driver_detach+0xd5/0x120
> [  100.667944]  bus_remove_driver+0x5c/0xe0
> [  100.667947]  driver_unregister+0x31/0x50
> [  100.667951]  i2c_del_driver+0x46/0x70
> [  100.667955]  tcs3472_driver_exit+0x10/0x5dd [tcs3472]
> [  100.667960]  __do_sys_delete_module.constprop.0+0x183/0x290
> [  100.667965]  ? exit_to_user_mode_prepare+0x37/0x1c0
> [  100.667971]  __x64_sys_delete_module+0x12/0x20
> [  100.667974]  do_syscall_64+0x40/0xb0
> [  100.667981]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  100.667985] RIP: 0033:0x7fa28b9dbceb
> [  100.667989] Code: 73 01 c3 48 8b 0d 7d 91 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 91 0c 00 f7 d8 64 89 01 48
> [  100.667992] RSP: 002b:00007ffe02ea7068 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [  100.667995] RAX: ffffffffffffffda RBX: 000056185176d750 RCX: 00007fa28b9dbceb
> [  100.667997] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000056185176d7b8
> [  100.667999] RBP: 00007ffe02ea70c8 R08: 0000000000000000 R09: 0000000000000000
> [  100.668001] R10: 00007fa28ba56ac0 R11: 0000000000000206 R12: 00007ffe02ea72a0
> [  100.668003] R13: 00007ffe02ea8807 R14: 000056185176d2a0 R15: 000056185176d750
> [  100.668007] ---[ end trace b21b0811931d933c ]---
> 
> Signed-off-by: frank zago <frank@zago.net>

Looks correct to me. +CC Peter in case he wants to take a look.

This is going to wait for a week or so anyway because next lot of fixes
will only go out towards the end of the merge window or just after rc1.

Thanks

Jonathan
> ---
>  drivers/iio/light/tcs3472.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index a0dc447aeb68..b41068492338 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -531,7 +531,8 @@ static int tcs3472_probe(struct i2c_client *client,
>  	return 0;
>  
>  free_irq:
> -	free_irq(client->irq, indio_dev);
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
>  buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	return ret;
> @@ -559,7 +560,8 @@ static int tcs3472_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
>  	iio_device_unregister(indio_dev);
> -	free_irq(client->irq, indio_dev);
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	tcs3472_powerdown(iio_priv(indio_dev));
>  

