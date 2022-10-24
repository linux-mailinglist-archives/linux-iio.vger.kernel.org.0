Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B827B60B1B3
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiJXQd2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiJXQcy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 12:32:54 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D0BF5B2;
        Mon, 24 Oct 2022 08:19:45 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r14so17307803lfm.2;
        Mon, 24 Oct 2022 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOauOQqA15pGA1yiVR8SjVcAabhIPWsiPuETAcU24cE=;
        b=Us0r4OLNUf4DmjVrBsQjdQ00h8GEaGPZm+gSxV5+mY4PVewEcqKTIyPG6Mq9pjVoP6
         DBsMXCTmYXODrbCPGU9+Uv6//2DvEb9oIBTrqwJ8sEv86Yivj3krJ6SAujZy+OAh8jhR
         WTsRoJd4oDDzwpfi8URCQNX7OQbH3wPhGfSrgpoqv+G0eItV+2GnXM5FffTMlu7xabFg
         ZA7CzsO8XA0jotBNAMaXY8ghPaH9MoCaV2yO+gXO5ehiCBQo4QARwFq7yDJBQic3MI1G
         v50hjzR8JglDVMz+HeWqSfSqqplfLjhEwImHe3bRuVMBH5LbJieJwxo8Haa+QRnmyhYV
         yVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOauOQqA15pGA1yiVR8SjVcAabhIPWsiPuETAcU24cE=;
        b=gPiaU3/K6NFBaYGrL3qNniizdO5qvRGE9iI3LEq0F36T0XoxjMcKhjC3TPnmfog6t7
         e277JuTU69j27PtZL5bpPuQ2G5pEZsenEEAQ931kLic8OwljlCL0VoxS+n+uF0HlMAvj
         aHG4XSABidA13zxK2KbQGzHZ1vEpjJieFqFQ05rGpf0AMNyLEwt5gw7M1BpzDUno7XuQ
         rneT+QxEDQei4++crB1ausZxqQxvdw4uk6QHArYg6RY4OkPhwf3xyDeiFzyPbHt1wtES
         bj+MaAjlr7yWkJIK/BLSt1tz5CZT5I0e9JsM4PNAXk/d1s+o28JKy4/T3k0sxK+JZqMm
         UYGw==
X-Gm-Message-State: ACrzQf38MgKmiFnA24DWPKFYNrzXJZsQ/pgz4pl/SNgM9AtrMDFreqRe
        D99Kdt4gJ/F+Bj5lNJX7pmtMmQ+isEc=
X-Google-Smtp-Source: AMsMyM7zQgTjup/5+mQsX00g0CBboY8PB8EHRLws1fEkVApc4axNwo6+tHUEJ7ZF/uJRbrBY6ha3Yw==
X-Received: by 2002:a05:6402:2947:b0:451:32a:2222 with SMTP id ed7-20020a056402294700b00451032a2222mr30533851edb.376.1666620142601;
        Mon, 24 Oct 2022 07:02:22 -0700 (PDT)
Received: from [192.168.0.104] (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id c22-20020a170906155600b007081282cbd8sm15562000ejd.76.2022.10.24.07.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:02:22 -0700 (PDT)
Message-ID: <049e0cf3-49b9-ed25-c595-06de22117f1a@gmail.com>
Date:   Mon, 24 Oct 2022 16:02:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/8] power: supply: fix failed to get iio channel by
 device name
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
References: <20221024132757.3345400-1-sravanhome@gmail.com>
 <20221024132757.3345400-7-sravanhome@gmail.com>
 <CAHp75VcvZ9drkFfbpVJFz0UWQvOMgAu3+JmV4HvOG3dPKDoN5w@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <CAHp75VcvZ9drkFfbpVJFz0UWQvOMgAu3+JmV4HvOG3dPKDoN5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/10/22 15:49, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 4:28 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>>
>> The mfd cell devices name populated on sysfs entry is dynamically derived
>> from an auto instance which introduced a regression. As a result
>> mpc2629_charger driver failed to get adc channel because of iio consumer
>> name mismatch with the sysfs.
>>
>> /sys/class/i2c-adapter/i2c-1/mp2629_adc.0.auto/
>> /sys/class/i2c-adapter/i2c-1/mp2629_charger.1.auto/
>>
>> Fixes: 466a62d7642f(mfd: core: Make a best effort attempt to match devices)
> 
> Wrong Fixes tag format, moreover the fixes should be grouped at the
> beginning of the series, so it will be visible and splittable based on
> this property.

Thanks for quick review Andy, I will correct fixes tag format and group 
all the fixes beginning of series in v5.

Thanks,
Saravanan


