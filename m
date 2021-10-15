Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467D942EC03
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhJOIZK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 15 Oct 2021 04:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhJOIYz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:24:55 -0400
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Oct 2021 01:22:40 PDT
Received: from smtprelay.restena.lu (smtprelay.restena.lu [IPv6:2001:a18:1::62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE55C061768;
        Fri, 15 Oct 2021 01:22:40 -0700 (PDT)
Received: from hemera.lan.sysophe.eu (unknown [IPv6:2001:a18:1:11::1])
        by smtprelay.restena.lu (Postfix) with ESMTPS id 852AD4337A;
        Fri, 15 Oct 2021 10:13:23 +0200 (CEST)
Date:   Fri, 15 Oct 2021 10:13:18 +0200
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] hid: replace snprintf in show functions with sysfs_emit
Message-ID: <20211015101318.0d14f394@hemera.lan.sysophe.eu>
In-Reply-To: <1634280506-4477-1-git-send-email-wangqing@vivo.com>
References: <1634280506-4477-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Oct 2021 23:48:26 -0700 Qing Wang <wangqing@vivo.com> wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> Fix the coccicheck warnings:
> WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Looks good to me, but I have a few remarks:

- No need to talk about "must not use" in detailled commit message.
  Mentioning introduction of the newish sysfs_emit() functions (in
  commit 2efc459d06f1630001e3984854848a5647086232 a Year ago) and thus
  switching over to those would be sufficient for code predating their
  introduction.

- I'm wondering why picolcd_fb_update_rate_show() in
    drivers/hid/hid-picolcd_fb.c:446
  is not updated as well in this same patch.
  There scnprintf() calls should be replaced with sysfs_emit_at() calls
  according to the intent of this patch!

- Not sure if the patch should be split into a 5-patch series with one
  patch per HID driver (each driver can be updated independently).


Acked-by: Bruno Prémont <bonbons@linux-vserver.org>
  (for picolcd code)

> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/hid/hid-lenovo.c          | 16 ++++++++--------
>  drivers/hid/hid-picolcd_core.c    |  6 +++---
>  drivers/hid/hid-roccat-isku.c     |  2 +-
>  drivers/hid/hid-roccat-kone.c     | 12 ++++++------
>  drivers/hid/hid-roccat-koneplus.c |  4 ++--
>  drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
>  drivers/hid/hid-roccat-pyra.c     |  6 +++---
>  drivers/hid/hid-sensor-custom.c   |  2 +-
>  drivers/hid/hid-sony.c            |  6 +++---
>  9 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 93b1f93..086a7ae 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -400,7 +400,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
> +	return sysfs_emit(buf, "%u\n", data->fn_lock);
>  }
>  
>  static ssize_t attr_fn_lock_store(struct device *dev,
> @@ -442,7 +442,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		cptkbd_data->sensitivity);
>  }
>  
> @@ -603,7 +603,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
> +	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
>  }
>  
>  static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
> @@ -633,7 +633,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
> +	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
>  }
>  
>  static ssize_t attr_dragging_store_tpkbd(struct device *dev,
> @@ -663,7 +663,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
> +	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
>  }
>  
>  static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
> @@ -693,7 +693,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
> +	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
>  }
>  
>  static ssize_t attr_select_right_store_tpkbd(struct device *dev,
> @@ -723,7 +723,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		data_pointer->sensitivity);
>  }
>  
> @@ -752,7 +752,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		data_pointer->press_speed);
>  }
>  
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
> index bbda231..fa46fb6 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -256,9 +256,9 @@ static ssize_t picolcd_operation_mode_show(struct device *dev,
>  	struct picolcd_data *data = dev_get_drvdata(dev);
>  
>  	if (data->status & PICOLCD_BOOTLOADER)
> -		return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
> +		return sysfs_emit(buf, "[bootloader] lcd\n");
>  	else
> -		return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
> +		return sysfs_emit(buf, "bootloader [lcd]\n");
>  }
>  
>  static ssize_t picolcd_operation_mode_store(struct device *dev,
> @@ -301,7 +301,7 @@ static ssize_t picolcd_operation_mode_delay_show(struct device *dev,
>  {
>  	struct picolcd_data *data = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%hu\n", data->opmode_delay);
> +	return sysfs_emit(buf, "%hu\n", data->opmode_delay);
>  }
>  
>  static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
> diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
> index ce5f225..58eb4b0 100644
> --- a/drivers/hid/hid-roccat-isku.c
> +++ b/drivers/hid/hid-roccat-isku.c
> @@ -63,7 +63,7 @@ static ssize_t isku_sysfs_show_actual_profile(struct device *dev,
>  {
>  	struct isku_device *isku =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", isku->actual_profile);
> +	return sysfs_emit(buf, "%d\n", isku->actual_profile);
>  }
>  
>  static ssize_t isku_sysfs_set_actual_profile(struct device *dev,
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index 1ca6448..66a7625 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c
> @@ -403,7 +403,7 @@ static ssize_t kone_sysfs_show_actual_profile(struct device *dev,
>  {
>  	struct kone_device *kone =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_profile);
> +	return sysfs_emit(buf, "%d\n", kone->actual_profile);
>  }
>  static DEVICE_ATTR(actual_profile, 0440, kone_sysfs_show_actual_profile, NULL);
>  
> @@ -412,7 +412,7 @@ static ssize_t kone_sysfs_show_actual_dpi(struct device *dev,
>  {
>  	struct kone_device *kone =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kone->actual_dpi);
> +	return sysfs_emit(buf, "%d\n", kone->actual_dpi);
>  }
>  static DEVICE_ATTR(actual_dpi, 0440, kone_sysfs_show_actual_dpi, NULL);
>  
> @@ -435,7 +435,7 @@ static ssize_t kone_sysfs_show_weight(struct device *dev,
>  
>  	if (retval)
>  		return retval;
> -	return snprintf(buf, PAGE_SIZE, "%d\n", weight);
> +	return sysfs_emit(buf, "%d\n", weight);
>  }
>  static DEVICE_ATTR(weight, 0440, kone_sysfs_show_weight, NULL);
>  
> @@ -444,7 +444,7 @@ static ssize_t kone_sysfs_show_firmware_version(struct device *dev,
>  {
>  	struct kone_device *kone =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kone->firmware_version);
> +	return sysfs_emit(buf, "%d\n", kone->firmware_version);
>  }
>  static DEVICE_ATTR(firmware_version, 0440, kone_sysfs_show_firmware_version,
>  		   NULL);
> @@ -454,7 +454,7 @@ static ssize_t kone_sysfs_show_tcu(struct device *dev,
>  {
>  	struct kone_device *kone =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.tcu);
> +	return sysfs_emit(buf, "%d\n", kone->settings.tcu);
>  }
>  
>  static int kone_tcu_command(struct usb_device *usb_dev, int number)
> @@ -556,7 +556,7 @@ static ssize_t kone_sysfs_show_startup_profile(struct device *dev,
>  {
>  	struct kone_device *kone =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kone->settings.startup_profile);
> +	return sysfs_emit(buf, "%d\n", kone->settings.startup_profile);
>  }
>  
>  static ssize_t kone_sysfs_set_startup_profile(struct device *dev,
> diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
> index 0316edf..9c39b17 100644
> --- a/drivers/hid/hid-roccat-koneplus.c
> +++ b/drivers/hid/hid-roccat-koneplus.c
> @@ -244,7 +244,7 @@ static ssize_t koneplus_sysfs_show_actual_profile(struct device *dev,
>  {
>  	struct koneplus_device *koneplus =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", koneplus->actual_profile);
> +	return sysfs_emit(buf, "%d\n", koneplus->actual_profile);
>  }
>  
>  static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
> @@ -311,7 +311,7 @@ static ssize_t koneplus_sysfs_show_firmware_version(struct device *dev,
>  			&info, KONEPLUS_SIZE_INFO);
>  	mutex_unlock(&koneplus->koneplus_lock);
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
> +	return sysfs_emit(buf, "%d\n", info.firmware_version);
>  }
>  static DEVICE_ATTR(firmware_version, 0440,
>  		   koneplus_sysfs_show_firmware_version, NULL);
> diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
> index 9600128..17581c4 100644
> --- a/drivers/hid/hid-roccat-kovaplus.c
> +++ b/drivers/hid/hid-roccat-kovaplus.c
> @@ -274,7 +274,7 @@ static ssize_t kovaplus_sysfs_show_actual_profile(struct device *dev,
>  {
>  	struct kovaplus_device *kovaplus =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_profile);
> +	return sysfs_emit(buf, "%d\n", kovaplus->actual_profile);
>  }
>  
>  static ssize_t kovaplus_sysfs_set_actual_profile(struct device *dev,
> @@ -327,7 +327,7 @@ static ssize_t kovaplus_sysfs_show_actual_cpi(struct device *dev,
>  {
>  	struct kovaplus_device *kovaplus =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_cpi);
> +	return sysfs_emit(buf, "%d\n", kovaplus->actual_cpi);
>  }
>  static DEVICE_ATTR(actual_cpi, 0440, kovaplus_sysfs_show_actual_cpi, NULL);
>  
> @@ -336,7 +336,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_x(struct device *dev,
>  {
>  	struct kovaplus_device *kovaplus =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_x_sensitivity);
> +	return sysfs_emit(buf, "%d\n", kovaplus->actual_x_sensitivity);
>  }
>  static DEVICE_ATTR(actual_sensitivity_x, 0440,
>  		   kovaplus_sysfs_show_actual_sensitivity_x, NULL);
> @@ -346,7 +346,7 @@ static ssize_t kovaplus_sysfs_show_actual_sensitivity_y(struct device *dev,
>  {
>  	struct kovaplus_device *kovaplus =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", kovaplus->actual_y_sensitivity);
> +	return sysfs_emit(buf, "%d\n", kovaplus->actual_y_sensitivity);
>  }
>  static DEVICE_ATTR(actual_sensitivity_y, 0440,
>  		   kovaplus_sysfs_show_actual_sensitivity_y, NULL);
> @@ -367,7 +367,7 @@ static ssize_t kovaplus_sysfs_show_firmware_version(struct device *dev,
>  			&info, KOVAPLUS_SIZE_INFO);
>  	mutex_unlock(&kovaplus->kovaplus_lock);
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
> +	return sysfs_emit(buf, "%d\n", info.firmware_version);
>  }
>  static DEVICE_ATTR(firmware_version, 0440,
>  		   kovaplus_sysfs_show_firmware_version, NULL);
> diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
> index 989927d..9cfa003 100644
> --- a/drivers/hid/hid-roccat-pyra.c
> +++ b/drivers/hid/hid-roccat-pyra.c
> @@ -286,7 +286,7 @@ static ssize_t pyra_sysfs_show_actual_cpi(struct device *dev,
>  {
>  	struct pyra_device *pyra =
>  			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
> -	return snprintf(buf, PAGE_SIZE, "%d\n", pyra->actual_cpi);
> +	return sysfs_emit(buf, "%d\n", pyra->actual_cpi);
>  }
>  static DEVICE_ATTR(actual_cpi, 0440, pyra_sysfs_show_actual_cpi, NULL);
>  
> @@ -303,7 +303,7 @@ static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
>  			&settings, PYRA_SIZE_SETTINGS);
>  	mutex_unlock(&pyra->pyra_lock);
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", settings.startup_profile);
> +	return sysfs_emit(buf, "%d\n", settings.startup_profile);
>  }
>  static DEVICE_ATTR(actual_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
>  static DEVICE_ATTR(startup_profile, 0440, pyra_sysfs_show_actual_profile, NULL);
> @@ -324,7 +324,7 @@ static ssize_t pyra_sysfs_show_firmware_version(struct device *dev,
>  			&info, PYRA_SIZE_INFO);
>  	mutex_unlock(&pyra->pyra_lock);
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
> +	return sysfs_emit(buf, "%d\n", info.firmware_version);
>  }
>  static DEVICE_ATTR(firmware_version, 0440, pyra_sysfs_show_firmware_version,
>  		   NULL);
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 32c2306..a46481d6 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -371,7 +371,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
>  				     sizeof(struct hid_custom_usage_desc),
>  				     usage_id_cmp);
>  		if (usage_desc)
> -			return snprintf(buf, PAGE_SIZE, "%s\n",
> +			return sysfs_emit(buf, "%s\n",
>  					usage_desc->desc);
>  		else
>  			return sprintf(buf, "not-specified\n");
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index b3722c5..709595e 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -696,7 +696,7 @@ static ssize_t ds4_show_poll_interval(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct sony_sc *sc = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%i\n", sc->ds4_bt_poll_interval);
> +	return sysfs_emit(buf, "%i\n", sc->ds4_bt_poll_interval);
>  }
>  
>  static ssize_t ds4_store_poll_interval(struct device *dev,
> @@ -733,7 +733,7 @@ static ssize_t sony_show_firmware_version(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct sony_sc *sc = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->fw_version);
> +	return sysfs_emit(buf, "0x%04x\n", sc->fw_version);
>  }
>  
>  static DEVICE_ATTR(firmware_version, 0444, sony_show_firmware_version, NULL);
> @@ -745,7 +745,7 @@ static ssize_t sony_show_hardware_version(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct sony_sc *sc = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "0x%04x\n", sc->hw_version);
> +	return sysfs_emit(buf, "0x%04x\n", sc->hw_version);
>  }
>  
>  static DEVICE_ATTR(hardware_version, 0444, sony_show_hardware_version, NULL);

