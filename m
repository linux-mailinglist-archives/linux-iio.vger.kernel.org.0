Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45AFB3047
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfIONjU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:39:20 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:58530 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfIONjU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 09:39:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id B1D829E79B4;
        Sun, 15 Sep 2019 14:39:18 +0100 (BST)
Date:   Sun, 15 Sep 2019 14:39:17 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC 1/4] counter: Simplify the count_read and count_write
 callbacks
Message-ID: <20190915143917.61385369@archlinux>
In-Reply-To: <20190915055759.408690-2-vilhelm.gray@gmail.com>
References: <20190915055759.408690-1-vilhelm.gray@gmail.com>
        <20190915055759.408690-2-vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Sep 2019 14:57:56 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The count_read and count_write callbacks are simplified to pass val as
> unsigned long rather than as an opaque data structure. The opaque
> counter_count_read_value and counter_count_write_value structures,
> counter_count_value_type enum, and relevant counter_count_read_value_set
> and counter_count_write_value_get functions, are removed as they are no
> longer used.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Seems like a sensible bit of excessive abstraction removal to me.  I'm not
totally sure why these got so complex in the first place though.

Can you recall the reason as it might help to judge why we no longer
think the same?

Thanks,

Jonathan
> ---
>  drivers/counter/counter.c | 66 +++++----------------------------------
>  include/linux/counter.h   | 43 +++----------------------
>  2 files changed, 12 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> index 106bc7180cd8..1d08f1437b1b 100644
> --- a/drivers/counter/counter.c
> +++ b/drivers/counter/counter.c
> @@ -246,60 +246,6 @@ void counter_signal_read_value_set(struct counter_signal_read_value *const val,
>  }
>  EXPORT_SYMBOL_GPL(counter_signal_read_value_set);
>  
> -/**
> - * counter_count_read_value_set - set counter_count_read_value data
> - * @val:	counter_count_read_value structure to set
> - * @type:	property Count data represents
> - * @data:	Count data
> - *
> - * This function sets an opaque counter_count_read_value structure with the
> - * provided Count data.
> - */
> -void counter_count_read_value_set(struct counter_count_read_value *const val,
> -				  const enum counter_count_value_type type,
> -				  void *const data)
> -{
> -	switch (type) {
> -	case COUNTER_COUNT_POSITION:
> -		val->len = sprintf(val->buf, "%lu\n", *(unsigned long *)data);
> -		break;
> -	default:
> -		val->len = 0;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(counter_count_read_value_set);
> -
> -/**
> - * counter_count_write_value_get - get counter_count_write_value data
> - * @data:	Count data
> - * @type:	property Count data represents
> - * @val:	counter_count_write_value structure containing data
> - *
> - * This function extracts Count data from the provided opaque
> - * counter_count_write_value structure and stores it at the address provided by
> - * @data.
> - *
> - * RETURNS:
> - * 0 on success, negative error number on failure.
> - */
> -int counter_count_write_value_get(void *const data,
> -				  const enum counter_count_value_type type,
> -				  const struct counter_count_write_value *const val)
> -{
> -	int err;
> -
> -	switch (type) {
> -	case COUNTER_COUNT_POSITION:
> -		err = kstrtoul(val->buf, 0, data);
> -		if (err)
> -			return err;
> -		break;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(counter_count_write_value_get);
> -
>  struct counter_attr_parm {
>  	struct counter_device_attr_group *group;
>  	const char *prefix;
> @@ -788,13 +734,13 @@ static ssize_t counter_count_show(struct device *dev,
>  	const struct counter_count_unit *const component = devattr->component;
>  	struct counter_count *const count = component->count;
>  	int err;
> -	struct counter_count_read_value val = { .buf = buf };
> +	unsigned long val;
>  
>  	err = counter->ops->count_read(counter, count, &val);
>  	if (err)
>  		return err;
>  
> -	return val.len;
> +	return sprintf(buf, "%lu\n", val);
>  }
>  
>  static ssize_t counter_count_store(struct device *dev,
> @@ -806,9 +752,13 @@ static ssize_t counter_count_store(struct device *dev,
>  	const struct counter_count_unit *const component = devattr->component;
>  	struct counter_count *const count = component->count;
>  	int err;
> -	struct counter_count_write_value val = { .buf = buf };
> +	unsigned long val;
> +
> +	err = kstrtoul(buf, 0, &val);
> +	if (err)
> +		return err;
>  
> -	err = counter->ops->count_write(counter, count, &val);
> +	err = counter->ops->count_write(counter, count, val);
>  	if (err)
>  		return err;
>  
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index a061cdcdef7c..7e40796598a6 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -300,24 +300,6 @@ struct counter_signal_read_value {
>  	size_t len;
>  };
>  
> -/**
> - * struct counter_count_read_value - Opaque Count read value
> - * @buf:	string representation of Count read value
> - * @len:	length of string in @buf
> - */
> -struct counter_count_read_value {
> -	char *buf;
> -	size_t len;
> -};
> -
> -/**
> - * struct counter_count_write_value - Opaque Count write value
> - * @buf:	string representation of Count write value
> - */
> -struct counter_count_write_value {
> -	const char *buf;
> -};
> -
>  /**
>   * struct counter_ops - Callbacks from driver
>   * @signal_read:	optional read callback for Signal attribute. The read
> @@ -328,15 +310,10 @@ struct counter_count_write_value {
>   *			signal_read callback.
>   * @count_read:		optional read callback for Count attribute. The read
>   *			value of the respective Count should be passed back via
> - *			the val parameter. val points to an opaque type which
> - *			should be set only by calling the
> - *			counter_count_read_value_set function from within the
> - *			count_read callback.
> + *			the val parameter.
>   * @count_write:	optional write callback for Count attribute. The write
>   *			value for the respective Count is passed in via the val
> - *			parameter. val points to an opaque type which should be
> - *			accessed only by calling the
> - *			counter_count_write_value_get function.
> + *			parameter.
>   * @function_get:	function to get the current count function mode. Returns
>   *			0 on success and negative error code on error. The index
>   *			of the respective Count's returned function mode should
> @@ -357,11 +334,9 @@ struct counter_ops {
>  			   struct counter_signal *signal,
>  			   struct counter_signal_read_value *val);
>  	int (*count_read)(struct counter_device *counter,
> -			  struct counter_count *count,
> -			  struct counter_count_read_value *val);
> +			  struct counter_count *count, unsigned long *val);
>  	int (*count_write)(struct counter_device *counter,
> -			   struct counter_count *count,
> -			   struct counter_count_write_value *val);
> +			   struct counter_count *count, unsigned long val);
>  	int (*function_get)(struct counter_device *counter,
>  			    struct counter_count *count, size_t *function);
>  	int (*function_set)(struct counter_device *counter,
> @@ -486,19 +461,9 @@ enum counter_signal_value_type {
>  	COUNTER_SIGNAL_LEVEL = 0
>  };
>  
> -enum counter_count_value_type {
> -	COUNTER_COUNT_POSITION = 0,
> -};
> -
>  void counter_signal_read_value_set(struct counter_signal_read_value *const val,
>  				   const enum counter_signal_value_type type,
>  				   void *const data);
> -void counter_count_read_value_set(struct counter_count_read_value *const val,
> -				  const enum counter_count_value_type type,
> -				  void *const data);
> -int counter_count_write_value_get(void *const data,
> -				  const enum counter_count_value_type type,
> -				  const struct counter_count_write_value *const val);
>  
>  int counter_register(struct counter_device *const counter);
>  void counter_unregister(struct counter_device *const counter);

