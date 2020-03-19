Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296F318B9A0
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 15:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCSOmH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 10:42:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36244 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbgCSOmH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 10:42:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id s1so1847014lfd.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2020 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g+BTddEx1NN4cFPIIl+hX0iTZkTBTd5H3UKyC7KzW3k=;
        b=Ji3ePBzoyhwT9jbT9lY3zvgVr/2IQ4uSujj5ngQoFzLj+0I1Fz21ZnPofD6Bge4o3v
         9n6Da6iHiUYTv5XoeHVXdA0TK9g4p2FU1pIud5lpbT1YfPxksJuhyBIPEG4Cfzr7WyF3
         3a+p1A0iUvO53eneFRLNiRhUpfVCSUh7BzxycQH+1gmfeuGNioHjv9qUVBdIqGzn+Zh5
         9QGc5sx3ZcIhO+sLwRKarUYpplbh2YmjKnNNGYNWXmiSnjbFNRfmHXC38X0lp6de9RaY
         P+tR747W+zOMbGLvPw9BhdzxUrJwmjmzWAz5i5TretwrK8+hGEu4d8l9+2WNI0ttj8pn
         cEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g+BTddEx1NN4cFPIIl+hX0iTZkTBTd5H3UKyC7KzW3k=;
        b=gO24l7Jky6KIvuFKOhJLsxPuvejWlx62B1iA2jb+E/G1QMjsfz5yILTZrqGktYxA57
         VFa6NZ+nhlIfmmrtaF6jeB2f8wG2aX3urPcp2xY+ExfKt8EEvnSpXoFXuGFwHpTU/ZYa
         TsasrVRK3ZR6yeHbdvsMVi15CwDmMhJ58ByPr+5PTnJMz3XudFup8v58xXE1ER79vBxS
         I2nunswul1sxDShJwOEmxwMmhAkU3kXvk76edOorhGzk7ezMJl9S8uC4j7RjHw6oyVuH
         Zk2y+oOT4AIyB5ncSzJU1wMbNSIgUVBXej1TveY/HCHFLDS5e2s/l4dYBY1LGKH9dhAf
         MSEA==
X-Gm-Message-State: ANhLgQ3DcF7d+UvdXr5s3FeGX7HIPbCgPG58qMIQKZ35kfs8JjA9GdGL
        K8QoFl80lBVdA8oDWVD71J7S4DLj
X-Google-Smtp-Source: ADFU+vvxTqwwx0/592YzUbRODD9G9pLRjK4+ugZ9kuVTwvD0p1sjVP0//0MJN2jouJopxx0U23PCKA==
X-Received: by 2002:a19:2353:: with SMTP id j80mr2256439lfj.4.1584628921200;
        Thu, 19 Mar 2020 07:42:01 -0700 (PDT)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id k23sm1620630ljk.40.2020.03.19.07.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:42:00 -0700 (PDT)
Subject: Re: Use LIS3MDL with LSM6DSM sensor-hub
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org
References: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
 <20200314124324.GA144176@lore-desk-wlan>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <217cb6b1-d3b3-bccf-b081-d4beb0888615@gmail.com>
Date:   Thu, 19 Mar 2020 15:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200314124324.GA144176@lore-desk-wlan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-03-14 13:43, Lorenzo Bianconi wrote:
> On Mar 11, Jimmy Assarsson wrote:
>> Hi,
>>
>> We are working on a project where we want to connect LS6DSM (via SPI), and
>> connect LIS3MDL via the sensor hub, as I2C slave device.
>>
>> We would like to add settings/configuration for LIS3MDL, to the shub
>> source, since currently only LIS2MDL is supported. We've made an attempt,
>> see diff at end of this mail.
>>
>> 1. LIS2MDL only got a single full scale setting, hence it is not possible
>>     to change. While LIS3MDL got four possible settings. Is it enough to add
>>     a corresponding function like st_lsm6dsx_shub_set_fs_val() and call it
>>     from st_lsm6dsx_shub_write_raw(), when mask == IIO_CHAN_INFO_SCALE?
>> 2. LIS3MDL got 8 possible ODR settings, however ST_LSM6DSX_ODR_LIST_SIZE is
>>     defined to 6 (st_lsm6dsx.h). Is it fine to increase
>>     ST_LSM6DSX_ODR_LIST_SIZE to 8? This will also affect odr_table in
>>     struct st_lsm6dsx_settings.
>> 3. In the patch, we've tried to copy the correct registers and values from
>>     magnetometer/st_magn_core.c, does it look ok?
>>
>> The IIO subsystem is new to use, we possibly miss fundamental knowledge.
>>
>> Regards,
>> jimmy
> 
> Hi Jimmy,
> 
> in order to set the full scale on LIS3MDL you can try the following patch (just
> compiled, not tested)
> 
> Regards,
> Lorenzo

Hi Lorenzo,

Sorry for the late response and thanks for the patch!

The patches seems to work.
Are there any specific tests that we should carry out?
Via the sysfs interface, we've tested reading raw values of each channel and
configuring ODR and full scale.

Regards,
jimmy

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 64ef07a30726..fec1dbd5f00d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -518,6 +518,36 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
>   	return ret;
>   }
>   
> +static int
> +st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_sensor *sensor,
> +			       u32 gain)
> +{
> +	const struct st_lsm6dsx_fs_table_entry *fs_table;
> +	int i, err;
> +
> +	fs_table = &sensor->ext_info.settings->fs_table;
> +	if (!fs_table->reg.addr)
> +		return -ENOTSUPP;
> +
> +	for (i = 0; i < fs_table->fs_len; i++) {
> +		if (fs_table->fs_avl[i].gain == gain)
> +			break;
> +	}
> +
> +	if (i == fs_table->fs_len)
> +		return -EINVAL;
> +
> +	err = st_lsm6dsx_shub_write_with_mask(sensor, fs_table->reg.addr,
> +					      fs_table->reg.mask,
> +					      fs_table->fs_avl[i].val);
> +	if (err < 0)
> +		return err;
> +
> +	sensor->gain = gain;
> +
> +	return 0;
> +}
> +
>   static int
>   st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>   			  struct iio_chan_spec const *chan,
> @@ -552,6 +582,9 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>   		}
>   		break;
>   	}
> +	case IIO_CHAN_INFO_SCALE:
> +		err = st_lsm6dsx_shub_set_full_scale(sensor, val2);
> +		break;
>   	default:
>   		err = -EINVAL;
>   		break;
> 
>>
>> ---
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
>> index eea5556..8621dba 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
>> @@ -88,6 +88,69 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>>   			.len = 6,
>>   		},
>>   	},
>> +	/* LIS3MDL */
>> +	{
>> +		.i2c_addr = { 0x1e },
>> +		.wai = {
>> +			.addr = 0x0f,
>> +			.val = 0x3d,
>> +		},
>> +		.id = ST_LSM6DSX_ID_MAGN,
>> +		.odr_table = {
>> +			.reg = {
>> +				.addr = 0x20,
>> +				.mask = GENMASK(4, 2),
>> +			},
>> +			.odr_avl[0] = {  1000, 0x0 },
>> +			.odr_avl[1] = {  2000, 0x1 },
>> +			.odr_avl[2] = {  3000, 0x2 },
>> +			.odr_avl[3] = {  5000, 0x3 },
>> +			.odr_avl[4] = { 10000, 0x4 },
>> +			.odr_avl[5] = { 20000, 0x5 },
>> +			.odr_avl[6] = { 40000, 0x6 },
>> +			.odr_avl[7] = { 80000, 0x7 },
>> +			.odr_len = 8,
>> +		},
>> +		.fs_table = {
>> +			.reg = {
>> +				.addr = 0x21,
>> +				.mask = GENMASK(6, 5),
>> +			},
>> +			.fs_avl[0] = {
>> +				.gain = 146,
>> +				.val = 0x00,
>> +			}, /* 4000 uG/LSB */
>> +			.fs_avl[1] = {
>> +				.gain = 292,
>> +				.val = 0x01,
>> +			}, /* 8000 uG/LSB */
>> +			.fs_avl[2] = {
>> +				.gain = 438,
>> +				.val = 0x02,
>> +			}, /* 12000 uG/LSB */
>> +			.fs_avl[3] = {
>> +				.gain = 584,
>> +				.val = 0x03,
>> +			}, /* 16000 uG/LSB */
>> +			.fs_len = 4,
>> +		},
>> +		.pwr_table = {
>> +			.reg = {
>> +				.addr = 0x22,
>> +				.mask = GENMASK(1, 0),
>> +			},
>> +			.off_val = 0x2,
>> +			.on_val = 0x0,
>> +		},
>> +		.bdu = {
>> +			.addr = 0x24,
>> +			.mask = BIT(6),
>> +		},
>> +		.out = {
>> +			.addr = 0x28,
>> +			.len = 6,
>> +		},
>> +	},
>>   };
