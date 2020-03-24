Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08227191C5F
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 22:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCXV6u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 17:58:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32872 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgCXV6u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 17:58:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id f20so390507ljm.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a8uMMxWtWcptqrPP9ar6Pd67wlPHI8V4Js+mJNdO5d0=;
        b=azwz2LzgZyCILD48TciFgg7ijCKb/2X2tv+1twyzv6g6V1zpKBjMvVee1maKwJndfx
         EI2ahYLISiljd6RQnsszTPMMafQL3zaVI3iocxNOe5+pqvIWktOQyJsy/usrAbyZfq3M
         7SPCHAGBOO0s3k8jbUAhgXeEoLeW8yKTEJNLRhHOnN9pV1RztMK462BpHLz2mW+k6g8A
         cwS2giSYy+olvm+EpReat3oBZTYyTkZTzXaqdBZRtZU7HtNeCv0opCHKgQF/JorIFYC1
         RYRrNlYVLZqQL6D0DYO1uFyZu6q5988KOyadHpKJErlpr3YjwbrCzVuQu8SZvySlQW+H
         wVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8uMMxWtWcptqrPP9ar6Pd67wlPHI8V4Js+mJNdO5d0=;
        b=OPVj9EW398YRpT/NRmbwHIVXWbAzMAouh3uuVX5mKvqKEO/NVxb5ICbX2GEvzPNopj
         cmWrOSztH18itL67fPU2DIjdaRrlNsWB+fLTfKO35DvY9A3HqGo4Sh5SfeZgbI9QvFh3
         85WO/jY5v0vP4V7oySI9l220OSJ6yUfeWeJ/fbDyz56zfv1Xzr5r7bEdb6ccauT+10Qh
         S4IlNX0VdzezktIUzKbvUrbgE0NcoGQlAAYliTBcVf49Qa17BWaqIR/6VcPmSrg/VkT6
         7+Wc8falwv21AYfjvqoJugo+TM6Sobdq+fjyjcF3ameKQUIVdu283ugwPWBdWeYm/3yo
         BQQw==
X-Gm-Message-State: ANhLgQ3Howu4jNdummAp72S2G912H66YwavKBMS7ykdd2wVLKNTmwktc
        Miuu1ZO8jKv+sLBkmtk7XimDk4dq
X-Google-Smtp-Source: ADFU+vuwWH+u4EMXawwdMwPgHwSa9x2z2yH+HYdNrDyaf2BivhSVFHySDokAYJwSvI3gzdX5yEeuew==
X-Received: by 2002:a2e:7a0d:: with SMTP id v13mr18170697ljc.173.1585087128319;
        Tue, 24 Mar 2020 14:58:48 -0700 (PDT)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id u19sm10547901lfq.23.2020.03.24.14.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 14:58:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Add sensor hub device LIS3MDL
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>
References: <20200324215226.1711659-1-jimmyassarsson@gmail.com>
 <20200324215226.1711659-2-jimmyassarsson@gmail.com>
Message-ID: <9f984a4d-b8df-2459-c330-409277b14c3e@gmail.com>
Date:   Tue, 24 Mar 2020 22:58:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324215226.1711659-2-jimmyassarsson@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-03-24 22:52, Jimmy Assarsson wrote:
> Add LIS3MDL register map to sensor hub device table.
> Tested with LSM6DSM.
> 
> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 63 ++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 95ddd19d1aa7..20fdef7a6ea2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -88,6 +88,69 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>   			.len = 6,
>   		},
>   	},
> +	/* LIS3MDL */
> +	{
> +		.i2c_addr = { 0x1e },
> +		.wai = {
> +			.addr = 0x0f,

In st_magn_core.c this is ST_SENSORS_DEFAULT_WAI_ADDRESS
(from linux/iio/common/st_sensors.h). Is this OK, our should I change it?

> +			.val = 0x3d,
> +		},
> +		.id = ST_LSM6DSX_ID_MAGN,
> +		.odr_table = {
> +			.reg = {
> +				.addr = 0x20,
> +				.mask = GENMASK(4, 2),
> +			},
> +			.odr_avl[0] = {  1000, 0x0 },
> +			.odr_avl[1] = {  2000, 0x1 },
> +			.odr_avl[2] = {  3000, 0x2 },
> +			.odr_avl[3] = {  5000, 0x3 },
> +			.odr_avl[4] = { 10000, 0x4 },
> +			.odr_avl[5] = { 20000, 0x5 },
> +			.odr_avl[6] = { 40000, 0x6 },
> +			.odr_avl[7] = { 80000, 0x7 },
> +			.odr_len = 8,
> +		},
> +		.fs_table = {
> +			.reg = {
> +				.addr = 0x21,
> +				.mask = GENMASK(6, 5),
> +			},
> +			.fs_avl[0] = {
> +				.gain = 146,
> +				.val = 0x00,
> +			}, /* 4000 uG/LSB */
> +			.fs_avl[1] = {
> +				.gain = 292,
> +				.val = 0x01,
> +			}, /* 8000 uG/LSB */
> +			.fs_avl[2] = {
> +				.gain = 438,
> +				.val = 0x02,
> +			}, /* 12000 uG/LSB */
> +			.fs_avl[3] = {
> +				.gain = 584,
> +				.val = 0x03,
> +			}, /* 16000 uG/LSB */
> +			.fs_len = 4,
> +		},
> +		.pwr_table = {
> +			.reg = {
> +				.addr = 0x22,
> +				.mask = GENMASK(1, 0),
> +			},
> +			.off_val = 0x2,
> +			.on_val = 0x0,
> +		},
> +		.bdu = {
> +			.addr = 0x24,
> +			.mask = BIT(6),
> +		},
> +		.out = {
> +			.addr = 0x28,
> +			.len = 6,
> +		},
> +	},
>   };
>   
>   static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
>
