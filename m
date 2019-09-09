Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A10AD7BA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 13:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfIILOJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 07:14:09 -0400
Received: from first.geanix.com ([116.203.34.67]:53136 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbfIILOJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 07:14:09 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 8CC46641B1;
        Mon,  9 Sep 2019 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568027619; bh=CK2BTGR5IZV/TUJe6QUjd6PfMTUbBAKIcnujZK1rltE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LIn0Z/6qm4b+lbKkLYdsrGiTap/zKxiJ+SC90SAFarIO2oPLI2CeVkhqbtt+Uigrh
         BrObkzNYdTNxp0YKg4xIFjmrQP7kl3w497DKOWtyqnx+tITIGh9AvyYeY/tIRoQNrG
         OFSLpgl4cPYRbwyHOnjWxFiChoHNozb3Q6UOTG6jILVbD5Rm7OsJDEuG1V4KJb2oqH
         Xmzv1S3W3nHu3RcIORAUDvQO5v/IKZLXPG6XvJfj9v04RrTo+f2SUxKtn3zUEm+1/g
         OAQXULHIZHdTlZtnRHpkvXbP5PoDHybykTz7NGeLqqAdunway426wsbRx+ad7FCKf4
         5jypPSlah0siA==
Subject: Re: [PATCH v5 2/6] iio: imu: st_lsm6dsx: add motion events
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
References: <20190909094506.51792-1-sean@geanix.com>
 <20190909094506.51792-2-sean@geanix.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <e1fcfc59-d06a-8da2-99b2-b987afc4192e@geanix.com>
Date:   Mon, 9 Sep 2019 13:13:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909094506.51792-2-sean@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 09/09/2019 11.45, Sean Nyekjaer wrote:
> +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
> +{
> +	int err;
> +	u8 enable = 0;
> +
> +	if (!hw->settings->int1_func_addr)
> +		return -ENOTSUPP;
> +
> +	enable = state ? hw->settings->event_settings.enable_reg.mask : 0;
> +
> +	err = regmap_update_bits(hw->regmap,
> +				 hw->settings->event_settings.enable_reg.addr,
> +				 hw->settings->event_settings.enable_reg.mask,
> +				 enable);
> +	if (err < 0)
> +		return err;
> +
> +	enable = state ? hw->irq_routing.mask : 0;
> +
> +	/* Enable wakeup interrupt */
> +	return regmap_update_bits(hw->regmap, hw->irq_routing.addr,
> +				  hw->irq_routing.mask,
> +				  enable);
> +}
> +
> +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	*val2 = 0;
> +	*val = hw->event_threshold;
> +
> +	return IIO_VAL_INT;
> +}

For a device that not support wake events the user will get a:
root@board:/sys/bus/iio/devices/iio:device2# echo 1 > 
events/in_accel_x_thresh_either_en
-sh: echo: write error: Unknown error 524

/Sean
