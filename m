Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8406A1911EB
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 14:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCXNr6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 09:47:58 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:41999 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgCXNrw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 09:47:52 -0400
Received: by mail-lj1-f182.google.com with SMTP id q19so18587463ljp.9
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7sPUO3nKuWyw3u4EPckU3OQ1+tz2YBvaiK7jw8BfyAY=;
        b=FARO73PFVzpOwufSle+uAUuc/63y8nK3yRAB9Pnof91vl5dg/wad9Kt5lAngsSQQ+s
         cJHhBpu/v/niAdnpsSfp2QPQEcNNF519iw58HVBStuGttWtPrQwHNXXzpdh91Em8pl+S
         5CVd5lUiQci7ev9FnrrgZpv9If8WxaSoUhkiYvJWOy3zaIeclPYJdmAEeYCTnNuXgfAM
         6JRqmP3xRVBLnmJYxtkIwDAGZQNcGym+rIVE1q2JwqcnoxxKej1IqlKGNv+zS9PleUt4
         OxCR1r8YaQQLFO4I6IiJpN8OjdCjrATZ/61r426EhY6cWWS6M+lQEgXgMI4Ecw6RxU9j
         gqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7sPUO3nKuWyw3u4EPckU3OQ1+tz2YBvaiK7jw8BfyAY=;
        b=R7Ino6uT+xx3Qz39BuwhMEx4kJkvadmb5opm+vTvLrG5fi/lJhU0m/rSguofJ1DPSo
         A8OfNblSSCFSML2GSKu1JI9qaTGKONAFtfJWqMrRuPytwmnJ6ZJ6SHz+O3uSurj+kKR/
         jy9/BXu1fdggUk900tp7H/Wuq2tAagPVuxnYEAIgITU31KP1w0hOYol8ezMmhRRYsUU+
         RrsErNmvpE2LmmgIlx5J+C2VpWXSNYu1jB2uL9eD602XrjynSCL9YvUMIjd3PJl0+ifC
         5mI60NhDzMhYAVaVXNumFBBIKIdjw39l8WGIYQbV4h3m2tpAmIk7wTObmaZ761N9WeEB
         Mcag==
X-Gm-Message-State: ANhLgQ1q0HEn34kx4ztyrp7VdISGuh1wr2jvp3NPuL0MtkBekt8GGmAE
        c6THSOeCbcfWN3GocWc7wVQPAnzx
X-Google-Smtp-Source: ADFU+vswnj2ms5CIXyL/o4V6DJXc5/yRX1W41Rya3MFA9Fz+vHOaHt2Wg0Z8bpxl0BAnR51RQiH8dQ==
X-Received: by 2002:a2e:7a0c:: with SMTP id v12mr16995478ljc.274.1585057669052;
        Tue, 24 Mar 2020 06:47:49 -0700 (PDT)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id c4sm8248690lfm.37.2020.03.24.06.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 06:47:48 -0700 (PDT)
Subject: Re: Use LIS3MDL with LSM6DSM sensor-hub
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org
References: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
 <20200314124324.GA144176@lore-desk-wlan>
 <217cb6b1-d3b3-bccf-b081-d4beb0888615@gmail.com>
 <20200319174039.GA1564882@lore-desk-wlan>
 <ef4aa50f-4aa6-cb87-06b6-913e2abbb23c@gmail.com>
 <20200319204937.GB1564882@lore-desk-wlan>
 <37e50d0e-0618-eeba-8cf9-7c1272097a62@gmail.com>
 <20200324082017.GA1387749@lore-desk-wlan>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <9e34cc2a-dd62-f915-6e82-02af151a26d9@gmail.com>
Date:   Tue, 24 Mar 2020 14:47:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324082017.GA1387749@lore-desk-wlan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-03-24 09:20, Lorenzo Bianconi wrote:
>> On 2020-03-19 21:49, Lorenzo Bianconi wrote:
>>>> On 2020-03-19 18:40, Lorenzo Bianconi wrote:
>>>>>> On 2020-03-14 13:43, Lorenzo Bianconi wrote:
>>>>>>> On Mar 11, Jimmy Assarsson wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>
>>> [...]
>>>
>>>>>>> Hi Jimmy,
>>>>>>>
>>>>>>> in order to set the full scale on LIS3MDL you can try the following patch (just
>>>>>>> compiled, not tested)
>>>>>>>
>>>>>>> Regards,
>>>>>>> Lorenzo
>>>>>>
>>>>>> Hi Lorenzo,
>>>>>>
>>>>>> Sorry for the late response and thanks for the patch!
>>>>>
>>>>> Hi Jimmy,
>>>>>
>>>>> ok, I will post the patch, thx for testing.
>>>>
>>>> Great, you can add
>>>> Tested-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
>>>>
>>>>>> The patches seems to work.
>>>>>> Are there any specific tests that we should carry out?
>>>>>> Via the sysfs interface, we've tested reading raw values of each channel and
>>>>>> configuring ODR and full scale.
>>>>>
>>>>> you can try to enable batching in the hw FIFO doing something like:
>>>>>
>>>>> $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_x_en
>>>>> $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_y_en
>>>>> $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_z_en
>>>>> $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_timestamp_en
>>>>>
>>>>> $watermark=64
>>>>> $echo $((2*watermark)) > /sys/bus/iio/devices/<iio-magn>/buffer/length
>>>>> $echo $watermark > /sys/bus/iio/devices/<iio-magn>/buffer/watermark
>>>>>
>>>>> $generic_buffer -gn lsm6dsm_magn -c <# of samples>
>>>>
>>>> Ok. I don't got any scan_elements nor buffer directory, for any of the devices.
>>>> I guess it is not possible to use the FIFO without configuring any interrupt?
>>>> We got the following dts:
>>>> &spi1 {
>>>> 	#address-cells = <1>;
>>>> 	#size-cells = <0>;
>>>> 	lsm6dsm@0 {
>>>> 		compatible = "st,lsm6dsm";
>>>> 		reg = <0x0>;
>>>>
>>>> 		spi-max-frequency = <500000>;
>>>> 		st,pullups = "true";
>>>
>>> yes, you need to provide the interrupt line doing something like (this is from
>>> the dts on my rpi):
>>>
>>> 	lsm6dsm@0 {
>>> 		...
>>> 		interrupt-parent = <&gpio>;
>>> 		interrupts = <21 0x4>;
>>> 		...
>>> 	};
>>>
>>>> 	};
>>>> };
>>>>
>>>> I'll look into this tomorrow or in the beginning of next week, thanks for the help.
>>
>> Now I've tested this. It looks fine, except for the very first sample:
>> $ ./iio_generic_buffer -gn lsm6dsm_magn -c 1
>> iio device number being used is 3
>> trigger-less mode selected
>> -3.250836 -2.796192 10.212408 1584976428879020199
>> 1.893036 2.343738 -0.853224 1584976428917070199
>> 1.888218 2.343300 -0.852786 1584976428955095199
>> 1.888218 2.343300 -0.852786 1584976428993145199
>> 1.889532 2.345490 -0.851472 1584976429031170199
> 
> values seems reasonable but I guess it depends on sensor calibration and how is
> oriented. Do you have any app to test it?

I think the values are correct. If I rotate the sensor the values change.
And I get similar values when the sensor reach the same orientation as before.
The only thing that looks strange, is the very first sample (-3.250836 -2.796192 10.212408),
which is not close to any of the other samples. When I plot the samples, the other samples
form a circle, while the first sample is way outside of the circle.

What about calibration? Is there any functionality in iio for calibration, or in libiio, or will
this always be part of the application?

Unfortunately we don't got any app for this yet.

Regards,
jimmy

> Regards,
> Lorenzo
> 
>>
>> Is this expected?
>>
>> Regards,
>> jimmy
