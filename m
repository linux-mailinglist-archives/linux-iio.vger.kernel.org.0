Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776D1AD849
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfIILvi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 07:51:38 -0400
Received: from first.geanix.com ([116.203.34.67]:55064 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730794AbfIILvi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 07:51:38 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 524DC2D7;
        Mon,  9 Sep 2019 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568029868; bh=iSmbzEpRX8D/j9V0akorRevVymbTUB4yealXaieclRs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZSpKUPF5us4TTUo2ey84LxAj5XxFizKC+nn+c78tRO2px/i8s99ZIEOM/zy3Mi3HY
         eGQwByt94ChNfgE4y+MIRqnr1jAhJbHmhllWzfEGJxX1GFNHbEqM6PJAbJWzXGRHOj
         ZblAT9B67c83cElEBYvugXsz81wKx4osLEucyUck7OyuhztIU4jQyf7T6lf6+vMfOb
         tBRpOb1kBFNFiwLLYT4q2IcD4CxIbbMFUiUx1Cjn6zTePX4sVw3Pf8ntfuAFuTVpLC
         6ZpwAo5ehpC0QQZBDAnjcOwz00Hn4Gc8xPWZ4TMpiPjAcmjgqQZaagoPC0jHmOdPCS
         ZQxl6ElEZPvDg==
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <4167d81f-6136-f9f9-cb6b-02b423799762@geanix.com>
Date:   Mon, 9 Sep 2019 13:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909112846.55280-5-sean@geanix.com>
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



On 09/09/2019 13.28, Sean Nyekjaer wrote:
> Report iio motion events to iio subsystem
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v4:
>   * Updated bitmask as pr Jonathans comments
> 
> Changes since v5:
>   * None
> 
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
>   2 files changed, 75 insertions(+)
> 
[...]
>   
> +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> +{
> +	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Y,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +}
> +

I was looking at this again, and if the user enables events for channel 
x, we continue to report events for y, z.
Is it okay or is it better to filter them out?

/Sean
