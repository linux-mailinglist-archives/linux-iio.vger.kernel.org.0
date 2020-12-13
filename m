Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8327F2D9130
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 00:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgLMXgc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 18:36:32 -0500
Received: from vern.gendns.com ([98.142.107.122]:53890 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgLMXgc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 18:36:32 -0500
X-Greylist: delayed 1244 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Dec 2020 18:36:30 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R7V4MLduBEFhpLTGn2FAZimfL7QOVlaM/Xne+lB6Whs=; b=0j4WemgLDwYJTkB1oyf2JCWWOG
        0w8ZArsWhMy9lF79Sg7Kg01VXuuDCwiP53zD8d6D2Gcyx/wHx3N6Y+Q4qTKx2uHiyLLNHU/d+Zz+n
        +3o2UtF5qWqOQ4VKhAlQ+gt0lbngjOADQ3pH84x1nazw5l5AYhanbu9cn98/AEsf30XQzh/E2eqDZ
        fLfwXaSx+CSTeNWKWjMXzHqsAV4WqdIDVwm/HY/64Gg1UBVIoXdF50vPY1wvVWmx5kxQwFOjmZ0k3
        +6C5nopXZa5Z9dYHx5JhXsImeD9KzAvId/M38zQ52MGxEN7a2gLt3Xeg75Pj2qJ04OA6Mu3nKaFmw
        YM2Munmw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:38098 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1koaZx-0008MT-AK; Sun, 13 Dec 2020 18:15:01 -0500
Subject: Re: [PATCH v6 1/5] counter: Internalize sysfs interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
 <950660d49af7d12b09bc9d3b1db6f8ff74209c26.1606075915.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <9fe4090e-2780-31b8-8ffa-2c665c6a2a4e@lechnology.com>
Date:   Sun, 13 Dec 2020 17:15:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <950660d49af7d12b09bc9d3b1db6f8ff74209c26.1606075915.git.vilhelm.gray@gmail.com>
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

On 11/22/20 2:29 PM, William Breathitt Gray wrote:

>   14 files changed, 1806 insertions(+), 2546 deletions(-)

It would be really nice if we could break this down into smaller
pieces and start getting it merged. It is really tough to keep
reviewing this much code in one patch over and over again.

Here are some initial findings from testing:


> +static void counter_device_release(struct device *dev)
> +{
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +
> +	counter_chrdev_remove(counter);
> +	ida_simple_remove(&counter_ida, counter->id);
> +}


I got the following error after `modprobe -r ti-eqep`:

[ 1186.045766] ------------[ cut here ]------------
[ 1186.050647] WARNING: CPU: 0 PID: 2625 at lib/refcount.c:28 counter_device_release+0x10/0x24 [counter]
[ 1186.059976] refcount_t: underflow; use-after-free.
[ 1186.064790] Modules linked in: aes_arm_bs(+) crypto_simd cryptd ccm usb_f_mass_storage usb_f_acm u_serial usb_f_ecm rfcomm usb_f_rndis u_ether libcomposite aes_arm aes_generic cmac bnep wl18xx wlcore mac80211 libarc4 sha256_generic libsha256 sha256_arm cfg80211 ti_am335x_adc kfifo_buf omap_aes_driver omap_crypto omap_sham crypto_engine pm33xx ti_emif_sram hci_uart omap_rng btbcm rng_core ti_eqep(-) counter bluetooth c_can_platform c_can ecdh_generic bmp280_spi ecc can_dev libaes bmp280_i2c bmp280 industrialio omap_mailbox musb_dsps wlcore_sdio musb_hdrc udc_core usbcore wkup_m3_ipc at24 omap_wdt phy_am335x watchdog phy_am335x_control ti_am335x_tscadc phy_generic wkup_m3_rproc usb_common cppi41 rtc_omap leds_gpio led_class cpufreq_dt pwm_tiehrpwm autofs4
[ 1186.132376] CPU: 0 PID: 2625 Comm: modprobe Not tainted 5.10.0-rc7bone-counter+ #23
[ 1186.140070] Hardware name: Generic AM33XX (Flattened Device Tree)
[ 1186.146225] [<c0110d70>] (unwind_backtrace) from [<c010b640>] (show_stack+0x10/0x14)
[ 1186.154017] [<c010b640>] (show_stack) from [<c09a0c98>] (dump_stack+0xc4/0xe4)
[ 1186.161285] [<c09a0c98>] (dump_stack) from [<c0137ba0>] (__warn+0xd8/0x100)
[ 1186.168284] [<c0137ba0>] (__warn) from [<c099c8e4>] (warn_slowpath_fmt+0x94/0xbc)
[ 1186.175814] [<c099c8e4>] (warn_slowpath_fmt) from [<bf10b0e8>] (counter_device_release+0x10/0x24 [counter])
[ 1186.185632] [<bf10b0e8>] (counter_device_release [counter]) from [<c0667118>] (device_release+0x30/0xa4)
[ 1186.195163] [<c0667118>] (device_release) from [<c057f73c>] (kobject_put+0x94/0x104)
[ 1186.202944] [<c057f73c>] (kobject_put) from [<c057f73c>] (kobject_put+0x94/0x104)
[ 1186.210472] [<c057f73c>] (kobject_put) from [<bf19004c>] (ti_eqep_remove+0x10/0x30 [ti_eqep])
[ 1186.219047] [<bf19004c>] (ti_eqep_remove [ti_eqep]) from [<c066f390>] (platform_drv_remove+0x24/0x3c)
[ 1186.228313] [<c066f390>] (platform_drv_remove) from [<c066d934>] (device_release_driver_internal+0xfc/0x1d0)
[ 1186.238187] [<c066d934>] (device_release_driver_internal) from [<c066da78>] (driver_detach+0x58/0xa8)
[ 1186.247456] [<c066da78>] (driver_detach) from [<c066c5ec>] (bus_remove_driver+0x4c/0xa0)
[ 1186.255594] [<c066c5ec>] (bus_remove_driver) from [<c01dd150>] (sys_delete_module+0x180/0x264)
[ 1186.264250] [<c01dd150>] (sys_delete_module) from [<c0100080>] (ret_fast_syscall+0x0/0x54)
[ 1186.272551] Exception stack(0xd247ffa8 to 0xd247fff0)
[ 1186.277629] ffa0:                   004fb478 004fb478 004fb4b4 00000800 b3bfcf00 00000000
[ 1186.285847] ffc0: 004fb478 004fb478 004fb478 00000081 00000000 be974900 be974a55 004fb478
[ 1186.294062] ffe0: 004f8f5c be97352c 004ddd97 b6d11d68
[ 1186.299253] ---[ end trace e1c61dea091f1078 ]---

> +static ssize_t counter_comp_u8_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	const struct counter_attribute *const a = to_counter_attribute(attr);
> +	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_count *const count = a->parent;
> +	struct counter_synapse *const synapse = a->comp.priv;
> +	const struct counter_available *const avail = a->comp.priv;
> +	int err;
> +	bool bool_data;
> +	int idx;
> +	u8 data;
> +
> +	switch (a->comp.type) {
> +	case COUNTER_COMP_BOOL:
> +		err = kstrtobool(buf, &bool_data);
> +		data = bool_data;
> +		break;
> +	case COUNTER_COMP_FUNCTION:
> +		err = find_in_string_array(&data, count->functions_list,
> +					   count->num_functions, buf,
> +					   counter_function_str);
> +		break;
> +	case COUNTER_COMP_SYNAPSE_ACTION:
> +		err = find_in_string_array(&data, synapse->actions_list,
> +					   synapse->num_actions, buf,
> +					   counter_synapse_action_str);
> +		break;
> +	case COUNTER_COMP_ENUM:
> +		idx = __sysfs_match_string(avail->strs, avail->num_items, buf);
> +		if (idx < 0)
> +			return idx;
> +		data = idx;
> +		break;
> +	case COUNTER_COMP_COUNT_MODE:
> +		err = find_in_string_array(&data, avail->enums,
> +					   avail->num_items, buf,
> +					   counter_count_mode_str);
> +		break;
> +	default:
> +		err = kstrtou8(buf, 0, &data);
> +		break;
> +	}
> +	if (err)

This needs to be `if (err < 0)`. There are cases where the functions
above return positive values. (And to be overly safe, it probably wouldn't
hurt to use err < 0 everywhere - not just in this function.)

> +		return err;
> +
> +	switch (a->scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		err = a->comp.device_u8_write(counter, data);
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		err = a->comp.signal_u8_write(counter, a->parent, data);
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		if (a->comp.type == COUNTER_COMP_SYNAPSE_ACTION)
> +			err = a->comp.action_write(counter, count, synapse,
> +						   data);
> +		else
> +			err = a->comp.count_u8_write(counter, count, data);
> +		break;
> +	}
> +	if (err)
> +		return err;
> +
> +	return len;
> +}
