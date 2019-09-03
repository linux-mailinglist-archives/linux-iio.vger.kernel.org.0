Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A71A68C9
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 14:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfICMnX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 08:43:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729169AbfICMnX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 08:43:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E990D41C36F8384B482D;
        Tue,  3 Sep 2019 20:43:18 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 20:43:13 +0800
Date:   Tue, 3 Sep 2019 13:43:03 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
CC:     <lorenzo.bianconi83@gmail.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: replace underscore with hyphen in
 device name
Message-ID: <20190903134303.000008be@huawei.com>
In-Reply-To: <20190903051802.22716-1-martin.kepplinger@puri.sm>
References: <20190903051802.22716-1-martin.kepplinger@puri.sm>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+CC Greg as fix for a patch in my outstanding pull request.

On Tue, 3 Sep 2019 07:18:02 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> With the underscore character in the lsm9ds1_imu device name, we get the
> following error below, so use a dash, just like the other device names do too.
> 
> [    3.961399] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
> [    4.010581] Mem abort info:
> [    4.013838]   ESR = 0x96000004
> [    4.023602]   Exception class = DABT (current EL), IL = 32 bits
> [    4.047993]   SET = 0, FnV = 0
> [    4.052690]   EA = 0, S1PTW = 0
> [    4.056015] Data abort info:
> [    4.059020]   ISV = 0, ISS = 0x00000004
> [    4.080106]   CM = 0, WnR = 0
> [    4.085237] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000e4f61000
> [    4.092194] [0000000000000018] pgd=0000000000000000
> [    4.097474] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    4.103286] Modules linked in: tcpci st_sensors st_lsm6dsx_i2c(+) tcpm st_lsm6dsx industrialio_triggered_buffer kfifo_buf vcnl4000 roles typec goodix snd_soc_sgtl5000 bq25890_charger snvs_pwrkey imx_sdma virt_dma qoriq_thermal imx2_wdt snd_soc_fsl_sai aes_ce_blk imx_pcm_dma crypto_simd watchdog crct10dif_ce ghash_ce sha2_ce snd_soc_simple_card snd_soc_gtm601 snd_soc_simple_card_utils sha1_ce snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd soundcore gpio_vibra usb_f_acm u_serial usb_f_rndis g_multi usb_f_mass_storage u_ether libcomposite ip_tables x_tables ipv6 nf_defrag_ipv6 xhci_plat_hcd xhci_hcd usbcore dwc3 ulpi udc_core usb_common phy_fsl_imx8mq_usb
> [    4.105389] bq25890-charger 0-006b: Capacity for 3784000 is 86%
> [    4.164061] CPU: 1 PID: 344 Comm: systemd-udevd Tainted: G        W         5.3.0-rc2-g24e3d989d49f-dirty #161
> [    4.164063] Hardware name: Purism Librem 5 devkit (DT)
> [    4.164067] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    4.164082] pc : st_lsm6dsx_i2c_probe+0x18/0x80 [st_lsm6dsx_i2c]
> [    4.164093] lr : i2c_device_probe+0x1f0/0x2b8
> [    4.164094] sp : ffff8000a499f970
> [    4.164097] x29: ffff8000a499f970 x28: 0000000000000000
> [    4.164100] x27: ffff000010b70000 x26: ffff8000a499fd68
> [    4.164104] x25: ffff000010860000 x24: ffff000008a8b038
> [    4.164108] x23: ffff000008a8b038 x22: ffff000008a8b000
> [    4.164111] x21: ffff8000a55b2400 x20: ffff000008a89000
> [    4.164115] x19: ffff8000a55b2400 x18: ffffffffffffffff
> [    4.164118] x17: 0000000000000000 x16: 0000000000000000
> [    4.164121] x15: 0000000000040000 x14: 00000000fffffff0
> [    4.164125] x13: ffff000010b6c898 x12: 0000000000000030
> [    4.164128] x11: 0000000000000000 x10: 0101010101010101
> [    4.260542] x9 : fffffffffffffffc x8 : 0000000000000008
> [    4.266073] x7 : 0000000000000004 x6 : 1e0e1a00f2ade4ef
> [    4.271605] x5 : 6f642d72001a0e1e x4 : 8080808000000000
> [    4.277136] x3 : 0000000000000000 x2 : ffff000008a8a000
> [    4.282667] x1 : 0000000000000000 x0 : ffff8000a55b2400
> [    4.288199] Call trace:
> [    4.290753]  st_lsm6dsx_i2c_probe+0x18/0x80 [st_lsm6dsx_i2c]
> [    4.296648]  i2c_device_probe+0x1f0/0x2b8
> [    4.300825]  really_probe+0x168/0x368
> [    4.304638]  driver_probe_device.part.2+0x10c/0x128
> [    4.309716]  device_driver_attach+0x74/0xa0
> [    4.314071]  __driver_attach+0x84/0x130
> [    4.318065]  bus_for_each_dev+0x68/0xc8
> [    4.322058]  driver_attach+0x20/0x28
> [    4.325780]  bus_add_driver+0xd4/0x1f8
> [    4.329683]  driver_register+0x60/0x110
> [    4.333677]  i2c_register_driver+0x44/0x98
> [    4.337944]  st_lsm6dsx_driver_init+0x1c/0x1000 [st_lsm6dsx_i2c]
> [    4.344200]  do_one_initcall+0x58/0x1a8
> [    4.348195]  do_init_module+0x54/0x1d4
> [    4.352098]  load_module+0x1998/0x1c40
> [    4.356001]  __se_sys_finit_module+0xc0/0xd8
> [    4.360446]  __arm64_sys_finit_module+0x14/0x20
> [    4.365166]  el0_svc_common.constprop.0+0xb0/0x168
> [    4.370154]  el0_svc_handler+0x18/0x20
> [    4.374056]  el0_svc+0x8/0xc
> [    4.377059] Code: d2800003 910003fd a90153f3 aa0003f3 (f9400c34)
> [    4.383406] ---[ end trace 6dfe010c028e3371 ]---
> 

> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Fixes: a106864fd667 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")

Thanks Martin.  This one is entirely my fault for messing up tweaking
that naming.  I should have bounced the patch back for another round
rather than thinking "it's trivial, what could possibly go wrong!"

On basis Greg may prefer to pick this one directly:

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Convenient lore.kernel.org link.

https://lore.kernel.org/linux-iio/20190903051802.22716-1-martin.kepplinger@puri.sm/T/#u


If not I'll pick it up for first set of fixes post rc1.

As for the question below, I've not taken a look yet and certainly seems
an odd result!

Thanks,

Jonathan



> ---
> 
> While this patch fixes my (formerly already mentioned) issue, it's
> a question actually: Why does is this underscore character a problem?
> 
> thanks,
> 
>                         martin
> 
> 
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 5e3cd96b0059..80e42c7dbcbe 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -24,7 +24,7 @@
>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
>  #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
>  #define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
> -#define ST_LSM9DS1_DEV_NAME	"lsm9ds1_imu"
> +#define ST_LSM9DS1_DEV_NAME	"lsm9ds1-imu"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,


