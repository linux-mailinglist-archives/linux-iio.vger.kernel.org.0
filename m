Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0BB3951
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfIPL33 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 07:29:29 -0400
Received: from first.geanix.com ([116.203.34.67]:54290 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfIPL33 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 07:29:29 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 3C04D65942;
        Mon, 16 Sep 2019 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568633308; bh=IVI/wLM4tm6o8jzed/lD3p/GICDqwWKQW0PzExoMHbg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=REYoNsDf3zp/66Nr2fPftUm1Utf4kMcqxEVQI9mmNyxZmSUVpMtynrh0PV1NFWkyy
         NmYaZnp0kGMpQAP70F6y92QaOstRiwWA72nPXHZnazOj2Qn0y2SVg2TeFYTd7s38ig
         SvCWaOKp7sfM1cbXsmN5ZpkVfcSdSf+KUtowpgI6bbvKrZoxJG400T+iud/VkTCuDE
         3+ynys6gw6d+ocG43Dn+YfjVjigIQybrJgkfZ75Q52yLbhBRdofIsoZIWmljnaV3RX
         cB49zHpGqRHzBb+oJ4EL+Su2yJyqVgJttJlxR0uDtFDXKu1Nh22YWOwZ/vMc+mhRPu
         EsXgx0z2sJHTQ==
Subject: Re: [RFC PATCH] iio: imu: st_lsm6dsx: filter motion events in driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190915143548.25383eb4@archlinux>
 <20190916090222.597444-1-sean@geanix.com>
 <20190916091649.GA16063@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <07c96bca-f952-71c0-4608-30746fbbc055@geanix.com>
Date:   Mon, 16 Sep 2019 13:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916091649.GA16063@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
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



On 16/09/2019 11.16, Lorenzo Bianconi wrote:
>> +	if (hw->event_en_mask & BIT(chan->channel2))
>> +		goto out;
> Why do we need this?
> 

Guess we need to check if 0 < hw->enable_event before disabling the 
sensor...
>> +
>>   	/* do not enable events if they are already enabled */
>>   	if (state && hw->enable_event)
>> -		return 0;
>> +		goto out;
>>   

static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
                                            const struct iio_chan_spec 
*chan,
                                            enum iio_event_type type,
                                            enum iio_event_direction dir,
                                            int state)
{
         struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
         struct st_lsm6dsx_hw *hw = sensor->hw;
         u8 _enable_event;
         int err = 0;

         if (type != IIO_EV_TYPE_THRESH)
                 return -EINVAL;

         if (state) {
                 _enable_event = hw->enable_event | BIT(chan->channel2);

                 /* do not enable events if they are already enabled */
                 if (0 < hw->enable_event)
                         goto out;
         } else {
                 _enable_event = hw->enable_event & ~BIT(chan->channel2);

                 /* only turn off sensor if no events is enabled */ 
 
 
 

                 if (0 != _enable_event)
                         goto out;
         }

         /* stop here if no changes have been made */
         if (hw->enable_event == _enable_event)
                 return 0;

         err = st_lsm6dsx_event_setup(hw, state);
         if (err < 0)
                 return err;

         err = st_lsm6dsx_sensor_set_enable(sensor, state);
         if (err < 0)
                 return err;

out:
         hw->enable_event = _enable_event;

         return 0;
}

Is something like this better?
