Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237A3ED357
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 13:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKCMeT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 07:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfKCMeT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 07:34:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22002080F;
        Sun,  3 Nov 2019 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572784457;
        bh=CbppErcBTE6nG5exiq8z+jGJFklIUTseI70fbNuNY3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OYNQGiEry4cypzq/D855kGtQ/zDzdNjtuHcSe6dR1zAMyNzSyTYo/4yOtiKOciK4/
         yhlEyX13U4KhHlUFHfEWtguk89O0e4YmyPIApioY9CSEGQ2jomoFVwP8FGMID3rdcO
         27MRlXjbaUjqHIy3sLZy8aNS2XPoplEUjZjrZG74=
Date:   Sun, 3 Nov 2019 12:34:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 01/18] platform: chrome: Put docs with the code
Message-ID: <20191103123411.61827bb8@archlinux>
In-Reply-To: <20191027230921.205251-2-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
        <20191027230921.205251-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Oct 2019 16:09:04 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> To avoid doc rot, put function documentations with code, not header.
> Use kernel-doc style comments for exported functions.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Please pick up Acks from earlier versions if no substantial changes.
Also, this one already got applied by Enric!

Thanks,

Jonathan

> ---
> No changes in v3.
> New in v2.
> 
>  drivers/platform/chrome/cros_ec.c           |  33 +++++++
>  drivers/platform/chrome/cros_ec_proto.c     |  70 +++++++++++++
>  include/linux/platform_data/cros_ec_proto.h | 103 --------------------
>  3 files changed, 103 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index fd77e6fa74c2c..9b2d07422e175 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -104,6 +104,15 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>  	return ret;
>  }
>  
> +/**
> + * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
> + * @ec_dev: Device to register.
> + *
> + * Before calling this, allocate a pointer to a new device and then fill
> + * in all the fields up to the --private-- marker.
> + *
> + * Return: 0 on success or negative error code.
> + */
>  int cros_ec_register(struct cros_ec_device *ec_dev)
>  {
>  	struct device *dev = ec_dev->dev;
> @@ -198,6 +207,14 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  }
>  EXPORT_SYMBOL(cros_ec_register);
>  
> +/**
> + * cros_ec_unregister() - Remove a ChromeOS EC.
> + * @ec_dev: Device to unregister.
> + *
> + * Call this to deregister a ChromeOS EC, then clean up any private data.
> + *
> + * Return: 0 on success or negative error code.
> + */
>  int cros_ec_unregister(struct cros_ec_device *ec_dev)
>  {
>  	if (ec_dev->pd)
> @@ -209,6 +226,14 @@ int cros_ec_unregister(struct cros_ec_device *ec_dev)
>  EXPORT_SYMBOL(cros_ec_unregister);
>  
>  #ifdef CONFIG_PM_SLEEP
> +/**
> + * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
> + * @ec_dev: Device to suspend.
> + *
> + * This can be called by drivers to handle a suspend event.
> + *
> + * Return: 0 on success or negative error code.
> + */
>  int cros_ec_suspend(struct cros_ec_device *ec_dev)
>  {
>  	struct device *dev = ec_dev->dev;
> @@ -243,6 +268,14 @@ static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
>  					     1, ec_dev);
>  }
>  
> +/**
> + * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
> + * @ec_dev: Device to resume.
> + *
> + * This can be called by drivers to handle a resume event.
> + *
> + * Return: 0 on success or negative error code.
> + */
>  int cros_ec_resume(struct cros_ec_device *ec_dev)
>  {
>  	int ret;
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index f659f96bda128..7db58771ec77c 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -117,6 +117,17 @@ static int send_command(struct cros_ec_device *ec_dev,
>  	return ret;
>  }
>  
> +/**
> + * cros_ec_prepare_tx() - Prepare an outgoing message in the output buffer.
> + * @ec_dev: Device to register.
> + * @msg: Message to write.
> + *
> + * This is intended to be used by all ChromeOS EC drivers, but at present
> + * only SPI uses it. Once LPC uses the same protocol it can start using it.
> + * I2C could use it now, with a refactor of the existing code.
> + *
> + * Return: 0 on success or negative error code.
> + */
>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>  		       struct cros_ec_command *msg)
>  {
> @@ -141,6 +152,16 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_prepare_tx);
>  
> +/**
> + * cros_ec_check_result() - Check ec_msg->result.
> + * @ec_dev: EC device.
> + * @msg: Message to check.
> + *
> + * This is used by ChromeOS EC drivers to check the ec_msg->result for
> + * errors and to warn about them.
> + *
> + * Return: 0 on success or negative error code.
> + */
>  int cros_ec_check_result(struct cros_ec_device *ec_dev,
>  			 struct cros_ec_command *msg)
>  {
> @@ -326,6 +347,13 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
>  	return ret;
>  }
>  
> +/**
> + * cros_ec_query_all() -  Query the protocol version supported by the
> + *         ChromeOS EC.
> + * @ec_dev: Device to register.
> + *
> + * Return: 0 on success or negative error code.
> + */
>  int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  {
>  	struct device *dev = ec_dev->dev;
> @@ -453,6 +481,16 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  }
>  EXPORT_SYMBOL(cros_ec_query_all);
>  
> +/**
> + * cros_ec_cmd_xfer() - Send a command to the ChromeOS EC.
> + * @ec_dev: EC device.
> + * @msg: Message to write.
> + *
> + * Call this to send a command to the ChromeOS EC.  This should be used
> + * instead of calling the EC's cmd_xfer() callback directly.
> + *
> + * Return: 0 on success or negative error code.
> + */
>  int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  		     struct cros_ec_command *msg)
>  {
> @@ -500,6 +538,18 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
>  
> +/**
> + * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
> + * @ec_dev: EC device.
> + * @msg: Message to write.
> + *
> + * This function is identical to cros_ec_cmd_xfer, except it returns success
> + * status only if both the command was transmitted successfully and the EC
> + * replied with success status. It's not necessary to check msg->result when
> + * using this function.
> + *
> + * Return: The number of bytes transferred on success or negative error code.
> + */
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  			    struct cros_ec_command *msg)
>  {
> @@ -584,6 +634,16 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
>  	return ec_dev->event_size;
>  }
>  
> +/**
> + * cros_ec_get_next_event() - Fetch next event from the ChromeOS EC.
> + * @ec_dev: Device to fetch event from.
> + * @wake_event: Pointer to a bool set to true upon return if the event might be
> + *              treated as a wake event. Ignored if null.
> + *
> + * Return: negative error code on errors; 0 for no data; or else number of
> + * bytes received (i.e., an event was retrieved successfully). Event types are
> + * written out to @ec_dev->event_data.event_type on success.
> + */
>  int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
>  {
>  	u8 event_type;
> @@ -628,6 +688,16 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
>  }
>  EXPORT_SYMBOL(cros_ec_get_next_event);
>  
> +/**
> + * cros_ec_get_host_event() - Return a mask of event set by the ChromeOS EC.
> + * @ec_dev: Device to fetch event from.
> + *
> + * When MKBP is supported, when the EC raises an interrupt, we collect the
> + * events raised and call the functions in the ec notifier. This function
> + * is a helper to know which events are raised.
> + *
> + * Return: 0 on error or non-zero bitmask of one or more EC_HOST_EVENT_*.
> + */
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>  {
>  	u32 host_event;
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index eab7036cda090..0d4e4aaed37af 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -187,133 +187,30 @@ struct cros_ec_platform {
>  	u16 cmd_offset;
>  };
>  
> -/**
> - * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
> - * @ec_dev: Device to suspend.
> - *
> - * This can be called by drivers to handle a suspend event.
> - *
> - * Return: 0 on success or negative error code.
> - */
>  int cros_ec_suspend(struct cros_ec_device *ec_dev);
>  
> -/**
> - * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
> - * @ec_dev: Device to resume.
> - *
> - * This can be called by drivers to handle a resume event.
> - *
> - * Return: 0 on success or negative error code.
> - */
>  int cros_ec_resume(struct cros_ec_device *ec_dev);
>  
> -/**
> - * cros_ec_prepare_tx() - Prepare an outgoing message in the output buffer.
> - * @ec_dev: Device to register.
> - * @msg: Message to write.
> - *
> - * This is intended to be used by all ChromeOS EC drivers, but at present
> - * only SPI uses it. Once LPC uses the same protocol it can start using it.
> - * I2C could use it now, with a refactor of the existing code.
> - *
> - * Return: 0 on success or negative error code.
> - */
>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>  		       struct cros_ec_command *msg);
>  
> -/**
> - * cros_ec_check_result() - Check ec_msg->result.
> - * @ec_dev: EC device.
> - * @msg: Message to check.
> - *
> - * This is used by ChromeOS EC drivers to check the ec_msg->result for
> - * errors and to warn about them.
> - *
> - * Return: 0 on success or negative error code.
> - */
>  int cros_ec_check_result(struct cros_ec_device *ec_dev,
>  			 struct cros_ec_command *msg);
>  
> -/**
> - * cros_ec_cmd_xfer() - Send a command to the ChromeOS EC.
> - * @ec_dev: EC device.
> - * @msg: Message to write.
> - *
> - * Call this to send a command to the ChromeOS EC.  This should be used
> - * instead of calling the EC's cmd_xfer() callback directly.
> - *
> - * Return: 0 on success or negative error code.
> - */
>  int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  		     struct cros_ec_command *msg);
>  
> -/**
> - * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
> - * @ec_dev: EC device.
> - * @msg: Message to write.
> - *
> - * This function is identical to cros_ec_cmd_xfer, except it returns success
> - * status only if both the command was transmitted successfully and the EC
> - * replied with success status. It's not necessary to check msg->result when
> - * using this function.
> - *
> - * Return: The number of bytes transferred on success or negative error code.
> - */
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  			    struct cros_ec_command *msg);
>  
> -/**
> - * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
> - * @ec_dev: Device to register.
> - *
> - * Before calling this, allocate a pointer to a new device and then fill
> - * in all the fields up to the --private-- marker.
> - *
> - * Return: 0 on success or negative error code.
> - */
>  int cros_ec_register(struct cros_ec_device *ec_dev);
>  
> -/**
> - * cros_ec_unregister() - Remove a ChromeOS EC.
> - * @ec_dev: Device to unregister.
> - *
> - * Call this to deregister a ChromeOS EC, then clean up any private data.
> - *
> - * Return: 0 on success or negative error code.
> - */
>  int cros_ec_unregister(struct cros_ec_device *ec_dev);
>  
> -/**
> - * cros_ec_query_all() -  Query the protocol version supported by the
> - *         ChromeOS EC.
> - * @ec_dev: Device to register.
> - *
> - * Return: 0 on success or negative error code.
> - */
>  int cros_ec_query_all(struct cros_ec_device *ec_dev);
>  
> -/**
> - * cros_ec_get_next_event() - Fetch next event from the ChromeOS EC.
> - * @ec_dev: Device to fetch event from.
> - * @wake_event: Pointer to a bool set to true upon return if the event might be
> - *              treated as a wake event. Ignored if null.
> - *
> - * Return: negative error code on errors; 0 for no data; or else number of
> - * bytes received (i.e., an event was retrieved successfully). Event types are
> - * written out to @ec_dev->event_data.event_type on success.
> - */
>  int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
>  
> -/**
> - * cros_ec_get_host_event() - Return a mask of event set by the ChromeOS EC.
> - * @ec_dev: Device to fetch event from.
> - *
> - * When MKBP is supported, when the EC raises an interrupt, we collect the
> - * events raised and call the functions in the ec notifier. This function
> - * is a helper to know which events are raised.
> - *
> - * Return: 0 on error or non-zero bitmask of one or more EC_HOST_EVENT_*.
> - */
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>  
>  #endif /* __LINUX_CROS_EC_PROTO_H */

