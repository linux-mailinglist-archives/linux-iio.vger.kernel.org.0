Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88A2CDCA9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfJGHzp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 03:55:45 -0400
Received: from first.geanix.com ([116.203.34.67]:47820 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfJGHzp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 03:55:45 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id D23C550530;
        Mon,  7 Oct 2019 07:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1570434863; bh=1XuqaOTTP6oFe9uFQAho+fd0HHnDGFHwWpGJ2mCEQVo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V722vGm2tQdGVQcuUhvFqFLFQBBwruGlKz6H6vvbpA6K6fboNgBMahrQaPzq7Jf6l
         1apwy+Y1KN/GLpqYv3kL7+rsyVGp4uZkJTrEKZS1SxBRgUQG8H1jmMZdXFysXaHwiH
         EzndppKeGE9S8Hh191p0eeFQ59j3Zro29x6fRY06ZgidcXK7YrL+ryjhOkQAUUYkC2
         Q/ppI+N7YfBFplpRaP0DOLEiLV2CYGE1jhwY2ky2b1gD36IpZUm+kG8PhTOYVwdnBh
         Xq1L3wC0qZHHuajUqNjaR/AgIDC+5EIOL95kERl4JYdBXq+uU9vb3LP5CXTOa8l5V1
         ylHyYbeYxStiw==
Subject: Re: [PATCH 06/13] iio: imu: st_lsm6dsx: always check enable_reg in
 st_lsm6dsx_event_setup
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, martin@geanix.com, rjones@gateworks.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
References: <cover.1570367532.git.lorenzo@kernel.org>
 <837ea533a4094d6da572999e8f863687fa4cae1b.1570367532.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <6a689d5a-1b35-01fe-92c5-9ac271814ad0@geanix.com>
Date:   Mon, 7 Oct 2019 09:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <837ea533a4094d6da572999e8f863687fa4cae1b.1570367532.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=disabled
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b8b5098bc1bc
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 06/10/2019 15.22, Lorenzo Bianconi wrote:
> Check if enable_reg of event_settings data structure is defined before
> writing on it
> 
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 23 ++++++++++----------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 5df382b9d8f9..7e9e1ef81742 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1482,26 +1482,25 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>   
>   static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
>   {
> +	const struct st_lsm6dsx_reg *reg;
>   	int err;
> -	u8 enable = 0;
>   
>   	if (!hw->settings->irq_config.irq1_func.addr)
>   		return -ENOTSUPP;
>   
> -	enable = state ? hw->settings->event_settings.enable_reg.mask : 0;
> -
> -	err = regmap_update_bits(hw->regmap,
> -				 hw->settings->event_settings.enable_reg.addr,
> -				 hw->settings->event_settings.enable_reg.mask,
> -				 enable);
> -	if (err < 0)
> -		return err;
> -
> -	enable = state ? hw->irq_routing->mask : 0;
> +	reg = &hw->settings->event_settings.enable_reg;
> +	if (reg->addr) {
> +		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
> +		if (err < 0)
> +			return err;
> +	}
>   
>   	/* Enable wakeup interrupt */
>   	return regmap_update_bits(hw->regmap, hw->irq_routing->addr,
> -				  hw->irq_routing->mask, enable);
> +				  hw->irq_routing->mask,
> +				  ST_LSM6DSX_SHIFT_VAL(state,
> +					hw->irq_routing->mask));
>   }
>   
>   static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> 
