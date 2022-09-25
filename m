Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95D5E91DC
	for <lists+linux-iio@lfdr.de>; Sun, 25 Sep 2022 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIYJ0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Sep 2022 05:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYJ03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2022 05:26:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E992B25E;
        Sun, 25 Sep 2022 02:26:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z97so5369353ede.8;
        Sun, 25 Sep 2022 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9HEGS3PUFvGV+HPDSQ5VcrO8+DrrZLZMGdpKd60CwSQ=;
        b=JKANrpNmC+nYToDhol9EgMolC67MLzASGIwBej5K+NGToivKgGlbXHSnv5yc3R6dpp
         rnK1b6FBMmwcNTqlwyu1gDrQI+ffh15IRi0d17a0QSHQi2nblDn02rE9l7VoV0K15JI3
         Qa5swFjSmxOg//T76Pdh4zgD1bA2//vN2IytMHmTbtj3QeW1MBmsA36IR54AxMn30DM9
         0wqllinAwiNDygpHg5yTT1F855IprOF9ROECurrk0Wwj9eFmtBvKFjcIvjsBUTRmS72p
         +PiwcQsHOVOD5czV5A7owZMqNzoEU5NgzdQPftoIkth52F2Oc+xNxoey8t2L3u7r//Az
         vzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9HEGS3PUFvGV+HPDSQ5VcrO8+DrrZLZMGdpKd60CwSQ=;
        b=hL3MxAgb9UOKihrWNVClu+3NZaKZC722GAt0V/twcsxMkK5dhIK6Z2lwGLjG1V4AeA
         r55+Fo8tPPSwSdvgKowl4yYs4+n6k7FOvdvEIMUaIMrz6GggjE6OdVHgVjIDYXtAqUFb
         gnPzpo1ytnmcw0CwOGA8PFa145VcJfWo2fJkVoUv6LYPPHh9o2F+DkoiJkeBbkTCT4j8
         Qs5T83bo1mN0dRAz+N7o8MTC7KE/Le5r7wG+CXMa7YLfH8n0nC8OxYeqhSYcQA4AL/O3
         zrldNuL3B3tkWguSjQZlH6EizMkNewBdpsb5SyUs0xBGBSDRwflHXKFvuP0FHWuzp8PV
         8whg==
X-Gm-Message-State: ACrzQf0pcydzkMq+FzRaUpaA1ZG+sKCAVTojRjq+iEflj1eCoys74miq
        MGV8n08tzsseEWOYwmsw7uo=
X-Google-Smtp-Source: AMsMyM5dSh6EO0qDpp05cBzOj4tUUphzaMN5hv5+rFj+/125d0U44sIY5PDkmFSRMpyy6kVoFuAvtg==
X-Received: by 2002:aa7:c9cf:0:b0:452:e416:644d with SMTP id i15-20020aa7c9cf000000b00452e416644dmr16623478edt.163.1664097987020;
        Sun, 25 Sep 2022 02:26:27 -0700 (PDT)
Received: from [192.168.0.104] (p5b3f7c6d.dip0.t-ipconnect.de. [91.63.124.109])
        by smtp.gmail.com with ESMTPSA id n16-20020a1709062bd000b00730bfe6adc4sm6678128ejg.37.2022.09.25.02.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 02:26:26 -0700 (PDT)
Message-ID: <77f13cfe-58dc-d150-18a9-cb14c82f222a@gmail.com>
Date:   Sun, 25 Sep 2022 11:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/6] power: supply: Add support for mp2733 battery
 charger
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <20220615145357.2370044-6-sravanhome@gmail.com>
 <20220911133101.7g6hnwp3dnnqrmgb@mercury.elektranox.org>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <20220911133101.7g6hnwp3dnnqrmgb@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Sebastian,

On 11/09/22 15:31, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jun 15, 2022 at 04:53:56PM +0200, Saravanan Sekar wrote:
>> mp2733 is updated version of mp2629 battery charge management
>> which supports USB fast-charge and higher range of input voltage.
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>> [...]
>>   	psy_cfg.drv_data = charger;
>> -	psy_cfg.attr_grp = mp2629_charger_sysfs_groups;
>> +	if (charger->chip_info->has_impedance)
>> +		psy_cfg.attr_grp = mp2629_charger_sysfs_groups;
>> +
>> +	if (charger->chip_info->has_fast_charge)
>> +		psy_cfg.attr_grp = mp2733_charger_sysfs_groups;
>> +
>>   	charger->battery = devm_power_supply_register(dev,
>>   					 &mp2629_battery_desc, &psy_cfg);
>>   	if (IS_ERR(charger->battery)) {
> 
> Instead of having has_impedance and has_fast_charge feature
> flag that are mutual exclusive, store the device type and
> use if/else or switch statement to chose the correct attr_grp.

these flags are not really mutual exclusive, limitation only for 
application between mp2629 and mp2629. In future another chipset on
same series shall have both or none, so I would consider to control 
flags with functionality rather than chipset !

Please feedback if still I have to consider your proposal.

> Other than that:
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> -- Sebastian

Thanks,
Saravanan

