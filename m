Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3518F873
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgCWPVz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 11:21:55 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45533 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCWPVz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 11:21:55 -0400
Received: by mail-wr1-f52.google.com with SMTP id t7so12895855wrw.12
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2020 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vXdvpTkOmEglHmM2yHjsDxxC5nrdm8XvoMKCOYdLBlA=;
        b=urWfSTCUjHV6ukVnb7VLozoUJNnGOv1Sjlr6lyuDO1Il5pCj6VWzJApPKxv1bLgXvi
         Htli9o5YxIj4qTmKlz42e61LbGs+r9FDSgYffIGIq2Wj2YwS074ox4F4kDuYuuFgSZch
         ASd9qtHBd1kbdtddFNQT6nuyFOH9bYgwPUja+GJJ0OG5EJgrrPsIzirJmPvwqesx9Et4
         AjDw1wE2uuAaSg6qzfh5Y8KHWo7GYhPB9R1+EV3VXTWdV/utn1jr1RPyPZEx3KFIiIZK
         UatwYNhaj8poKvyZ0E2pRsil+nyOz+Xfe8OQE0EyFRR50yubJToxlxdhldP4yJYfVO+s
         DJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vXdvpTkOmEglHmM2yHjsDxxC5nrdm8XvoMKCOYdLBlA=;
        b=ENNX/yZ/86GabvpwWU1xvDnAe9jsDPIhy6YhKXQqlyTMbbbcQui80pqjH3/7AG4tB3
         KPUuiFiYkOTMDV3orINIjKYUOD7J9GkaG8BFRcd8wsI4EipkE+HT0BND6QVnroL52zSI
         nEXtGbEWO9nnxJg1vRTfRetJ7uYy8D72emz64E/3CkKX6Q0kYs5mhpTR3pa31kRn0ro/
         +F5Q277BzVllwxMaALdxUX17Eq0d90DbsON+ZgqGw7P09FH9nIvqoqS4AMP1qigy8kOy
         zaDfIWBQeL3piDpS+Xc5WENAnqqkhwvGiK0VMEXW+1DFrGQKkW8txB3onFfzhmWx4BWj
         /C/Q==
X-Gm-Message-State: ANhLgQ3JFoQwU/9ClxUafZSvAlv7+8Ox7DFbJM+rb31+irOU7A+QQU25
        2afz70UDcY4DvsMtplViAe7Ns0mI
X-Google-Smtp-Source: ADFU+vsosS/+fiq1gFBUcvi1frH2Fuu4wSBRLmlj3B432c3aM44mTApd4Ybw316Ky4DPJJkf87JpNg==
X-Received: by 2002:adf:e48c:: with SMTP id i12mr30654626wrm.173.1584976912507;
        Mon, 23 Mar 2020 08:21:52 -0700 (PDT)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id b187sm22633716wmb.42.2020.03.23.08.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 08:21:51 -0700 (PDT)
Subject: Re: Use LIS3MDL with LSM6DSM sensor-hub
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org
References: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
 <20200314124324.GA144176@lore-desk-wlan>
 <217cb6b1-d3b3-bccf-b081-d4beb0888615@gmail.com>
 <20200319174039.GA1564882@lore-desk-wlan>
 <ef4aa50f-4aa6-cb87-06b6-913e2abbb23c@gmail.com>
 <20200319204937.GB1564882@lore-desk-wlan>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <37e50d0e-0618-eeba-8cf9-7c1272097a62@gmail.com>
Date:   Mon, 23 Mar 2020 16:21:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319204937.GB1564882@lore-desk-wlan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-03-19 21:49, Lorenzo Bianconi wrote:
>> On 2020-03-19 18:40, Lorenzo Bianconi wrote:
>>>> On 2020-03-14 13:43, Lorenzo Bianconi wrote:
>>>>> On Mar 11, Jimmy Assarsson wrote:
>>>>>> Hi,
>>>>>>
> 
> [...]
> 
>>>>> Hi Jimmy,
>>>>>
>>>>> in order to set the full scale on LIS3MDL you can try the following patch (just
>>>>> compiled, not tested)
>>>>>
>>>>> Regards,
>>>>> Lorenzo
>>>>
>>>> Hi Lorenzo,
>>>>
>>>> Sorry for the late response and thanks for the patch!
>>>
>>> Hi Jimmy,
>>>
>>> ok, I will post the patch, thx for testing.
>>
>> Great, you can add
>> Tested-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
>>
>>>> The patches seems to work.
>>>> Are there any specific tests that we should carry out?
>>>> Via the sysfs interface, we've tested reading raw values of each channel and
>>>> configuring ODR and full scale.
>>>
>>> you can try to enable batching in the hw FIFO doing something like:
>>>
>>> $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_x_en
>>> $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_y_en
>>> $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_z_en
>>> $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_timestamp_en
>>>
>>> $watermark=64
>>> $echo $((2*watermark)) > /sys/bus/iio/devices/<iio-magn>/buffer/length
>>> $echo $watermark > /sys/bus/iio/devices/<iio-magn>/buffer/watermark
>>>
>>> $generic_buffer -gn lsm6dsm_magn -c <# of samples>
>>
>> Ok. I don't got any scan_elements nor buffer directory, for any of the devices.
>> I guess it is not possible to use the FIFO without configuring any interrupt?
>> We got the following dts:
>> &spi1 {
>> 	#address-cells = <1>;
>> 	#size-cells = <0>;
>> 	lsm6dsm@0 {
>> 		compatible = "st,lsm6dsm";
>> 		reg = <0x0>;
>>
>> 		spi-max-frequency = <500000>;
>> 		st,pullups = "true";
> 
> yes, you need to provide the interrupt line doing something like (this is from
> the dts on my rpi):
> 
> 	lsm6dsm@0 {
> 		...
> 		interrupt-parent = <&gpio>;
> 		interrupts = <21 0x4>;
> 		...
> 	};
> 
>> 	};
>> };
>>
>> I'll look into this tomorrow or in the beginning of next week, thanks for the help.

Now I've tested this. It looks fine, except for the very first sample:
$ ./iio_generic_buffer -gn lsm6dsm_magn -c 1
iio device number being used is 3
trigger-less mode selected
-3.250836 -2.796192 10.212408 1584976428879020199
1.893036 2.343738 -0.853224 1584976428917070199
1.888218 2.343300 -0.852786 1584976428955095199
1.888218 2.343300 -0.852786 1584976428993145199
1.889532 2.345490 -0.851472 1584976429031170199

Is this expected?

Regards,
jimmy
