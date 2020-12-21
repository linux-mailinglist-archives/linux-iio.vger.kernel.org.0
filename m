Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0DC2DFD88
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 16:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgLUP0s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 10:26:48 -0500
Received: from vern.gendns.com ([98.142.107.122]:42826 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgLUP0s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Dec 2020 10:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z6HZk7Rcqf/SkkBth/RgoLSQOT9bXljXp/uxtQNS6ns=; b=VS2TDpRcdGQLF321oOjoUZ4XUk
        kLC+WLwnckx544GfvwqbtUK+XbjuQD2Lqg5ClmYKa8a8abcE1vHT6ubwCMd1D3Vtjsbrz3MCgd9gm
        OaG3jo514MZvUqVxx8JJ4OVzkptKFnrRlb0dGjgN5Nq1bY8mBvhbatRaCrLgXFwVEwJIy+aeexuD5
        22oINfR3rFXfUIWpDKPZQlnvyn4yNHbPiPd10PQhXVaDzQn/1PaXP5ZpWfvciRuPMBbshKcRnWg+F
        kpRztksPyt0aoDYDRLcTJ3iZMbFpwqDS5a3FQEDGux6D63+1FKjyK8rKuX4P6qxbyHdCAspd254a6
        l6DSNWJQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51348 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1krN4V-0006ij-Sq; Mon, 21 Dec 2020 10:26:03 -0500
Subject: Re: [PATCH v6 1/5] counter: Internalize sysfs interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
 <950660d49af7d12b09bc9d3b1db6f8ff74209c26.1606075915.git.vilhelm.gray@gmail.com>
 <9fe4090e-2780-31b8-8ffa-2c665c6a2a4e@lechnology.com>
 <X9/MBla990ctfpL4@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <11343644-dd98-37db-0480-3b8e9c88c631@lechnology.com>
Date:   Mon, 21 Dec 2020 09:26:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9/MBla990ctfpL4@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/20/20 4:11 PM, William Breathitt Gray wrote:
> On Sun, Dec 13, 2020 at 05:15:00PM -0600, David Lechner wrote:
>> On 11/22/20 2:29 PM, William Breathitt Gray wrote:
>>
>>>    14 files changed, 1806 insertions(+), 2546 deletions(-)
>>
>> It would be really nice if we could break this down into smaller
>> pieces and start getting it merged. It is really tough to keep
>> reviewing this much code in one patch over and over again.
> 
> Yes, this is a pretty massive patch. I could break this across the
> individual files affected to make it simpler to review, but in the end
> all those patches would need to end up squashed together before merge
> again (for the sake of git bisect), so the effort feels somewhat moot.
> 
> Luckily, I don't think there will be much change in the next revision
> since it's looking like it'll mainly be a few bug fixes; hopefully this
> coming version 7 will be the final revision before merge.
> 
>> Here are some initial findings from testing:
>>
>>
>>> +static void counter_device_release(struct device *dev)
>>> +{
>>> +	struct counter_device *const counter = dev_get_drvdata(dev);
>>> +
>>> +	counter_chrdev_remove(counter);
>>> +	ida_simple_remove(&counter_ida, counter->id);
>>> +}
>>
>>
>> I got the following error after `modprobe -r ti-eqep`:
>>
>> [ 1186.045766] ------------[ cut here ]------------
>> [ 1186.050647] WARNING: CPU: 0 PID: 2625 at lib/refcount.c:28 counter_device_release+0x10/0x24 [counter]
>> [ 1186.059976] refcount_t: underflow; use-after-free.
>> [ 1186.064790] Modules linked in: aes_arm_bs(+) crypto_simd cryptd ccm usb_f_mass_storage usb_f_acm u_serial usb_f_ecm rfcomm usb_f_rndis u_ether libcomposite aes_arm aes_generic cmac bnep wl18xx wlcore mac80211 libarc4 sha256_generic libsha256 sha256_arm cfg80211 ti_am335x_adc kfifo_buf omap_aes_driver omap_crypto omap_sham crypto_engine pm33xx ti_emif_sram hci_uart omap_rng btbcm rng_core ti_eqep(-) counter bluetooth c_can_platform c_can ecdh_generic bmp280_spi ecc can_dev libaes bmp280_i2c bmp280 industrialio omap_mailbox musb_dsps wlcore_sdio musb_hdrc udc_core usbcore wkup_m3_ipc at24 omap_wdt phy_am335x watchdog phy_am335x_control ti_am335x_tscadc phy_generic wkup_m3_rproc usb_common cppi41 rtc_omap leds_gpio led_class cpufreq_dt pwm_tiehrpwm autofs4
>> [ 1186.132376] CPU: 0 PID: 2625 Comm: modprobe Not tainted 5.10.0-rc7bone-counter+ #23
>> [ 1186.140070] Hardware name: Generic AM33XX (Flattened Device Tree)
>> [ 1186.146225] [<c0110d70>] (unwind_backtrace) from [<c010b640>] (show_stack+0x10/0x14)
>> [ 1186.154017] [<c010b640>] (show_stack) from [<c09a0c98>] (dump_stack+0xc4/0xe4)
>> [ 1186.161285] [<c09a0c98>] (dump_stack) from [<c0137ba0>] (__warn+0xd8/0x100)
>> [ 1186.168284] [<c0137ba0>] (__warn) from [<c099c8e4>] (warn_slowpath_fmt+0x94/0xbc)
>> [ 1186.175814] [<c099c8e4>] (warn_slowpath_fmt) from [<bf10b0e8>] (counter_device_release+0x10/0x24 [counter])
>> [ 1186.185632] [<bf10b0e8>] (counter_device_release [counter]) from [<c0667118>] (device_release+0x30/0xa4)
>> [ 1186.195163] [<c0667118>] (device_release) from [<c057f73c>] (kobject_put+0x94/0x104)
>> [ 1186.202944] [<c057f73c>] (kobject_put) from [<c057f73c>] (kobject_put+0x94/0x104)
>> [ 1186.210472] [<c057f73c>] (kobject_put) from [<bf19004c>] (ti_eqep_remove+0x10/0x30 [ti_eqep])
>> [ 1186.219047] [<bf19004c>] (ti_eqep_remove [ti_eqep]) from [<c066f390>] (platform_drv_remove+0x24/0x3c)
>> [ 1186.228313] [<c066f390>] (platform_drv_remove) from [<c066d934>] (device_release_driver_internal+0xfc/0x1d0)
>> [ 1186.238187] [<c066d934>] (device_release_driver_internal) from [<c066da78>] (driver_detach+0x58/0xa8)
>> [ 1186.247456] [<c066da78>] (driver_detach) from [<c066c5ec>] (bus_remove_driver+0x4c/0xa0)
>> [ 1186.255594] [<c066c5ec>] (bus_remove_driver) from [<c01dd150>] (sys_delete_module+0x180/0x264)
>> [ 1186.264250] [<c01dd150>] (sys_delete_module) from [<c0100080>] (ret_fast_syscall+0x0/0x54)
>> [ 1186.272551] Exception stack(0xd247ffa8 to 0xd247fff0)
>> [ 1186.277629] ffa0:                   004fb478 004fb478 004fb4b4 00000800 b3bfcf00 00000000
>> [ 1186.285847] ffc0: 004fb478 004fb478 004fb478 00000081 00000000 be974900 be974a55 004fb478
>> [ 1186.294062] ffe0: 004f8f5c be97352c 004ddd97 b6d11d68
>> [ 1186.299253] ---[ end trace e1c61dea091f1078 ]---
> 
> I noticed that I'm calling counter_chrdev_remove() twice: once in
> counter_unregister(), and again in counter_device_release(). I suspect
> this is what's causing the refcount to underflow. I'll test and verify
> that this is the culprit.
> 
> In fact, I don't think I need to define a counter_device_release()
> callback at all, would I? These cleanup function calls could be moved to
> counter_unregister() instead.

As long as a user program keeps a chrdev open, it holds a reference to
the device, so I think it needs to be the other way around. (Unless it
is impossible to call counter_unregister() before all references have
been released - but I don't think that is the case - not 100% sure.)
