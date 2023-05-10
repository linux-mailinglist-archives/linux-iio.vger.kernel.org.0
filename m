Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A419E6FE26F
	for <lists+linux-iio@lfdr.de>; Wed, 10 May 2023 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEJQ0L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjEJQZh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 12:25:37 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF22173D;
        Wed, 10 May 2023 09:25:07 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 48EB8847D4;
        Wed, 10 May 2023 18:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683735904;
        bh=NCLDsi2NcXwzSeZFFUNrHRyYtpcKm8r8dA5C5aNmZdM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gLQW3l0UDnEfFq0uDtQQmasGj3mI/NjFQqx1Otic5J2ckHYcHOAenkzYmPpvsqM7H
         lCg2ZnimMjWho/0mSuGelVu2EolFEN92kEbNS4E/7yrZiFDO7NHSpCuuQ9kN5YeocU
         AxPUcL1l7+tTnNMtaNAR+vWg5SC52FFkqfaNNOlvpyc6QgpW15CIGwvV48/mfXfReB
         ySaac2wTLhDPCjydesUNwKyNxWYOtdxz36m0ucDfl0bfKyoh2VwJsxIKqPBcIOpFq4
         Ug6VyvwhLI75IEOqjQFtWiorQuZnO3/GEUwJCktqE9kEdtw7Aq1gq0FNjaBkWCVkCX
         XxIpTVi0ylbUg==
Message-ID: <8e1ef090-3d75-6ccb-4708-c006923afc73@denx.de>
Date:   Wed, 10 May 2023 18:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/5] iio: mlx90614: Add MLX90615 support
Content-Language: en-US
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20230507184649.39290-1-marex@denx.de>
 <20230507184649.39290-5-marex@denx.de>
 <CAKv63utbVqRjmyP_cN=d2Jewpp6hgVHzSJdm4gjKBkaHKb2LuQ@mail.gmail.com>
 <189306ca-dbd9-508c-a6ca-32199dbaeb79@denx.de>
 <CAKv63uscjBSfkBMLR1gBRsu3=R7Quu1aReuGjnfQvh=aRsc6gw@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAKv63uscjBSfkBMLR1gBRsu3=R7Quu1aReuGjnfQvh=aRsc6gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/10/23 09:33, Crt Mori wrote:
> On Mon, 8 May 2023 at 13:32, Marek Vasut <marex@denx.de> wrote:
>>
>> On 5/8/23 12:10, Crt Mori wrote:
>>
>> [...]
>>
>>>> @@ -666,14 +678,43 @@ static const struct mlx_chip_info mlx90614_chip_info = {
>>>>           },
>>>>    };
>>>>
>>>> +static const struct mlx_chip_info mlx90615_chip_info = {
>>>> +       .op_eeprom_emissivity           = MLX90615_OP_EEPROM | 0x03,
>>>> +       .op_eeprom_config1              = MLX90615_OP_EEPROM | 0x02,
>>>> +       .op_ram_ta                      = MLX90615_OP_RAM | 0x06,
>>>> +       .op_ram_tobj1                   = MLX90615_OP_RAM | 0x07,
>>>> +       .op_ram_tobj2                   = MLX90615_OP_RAM | 0x08,
>>>> +       .op_sleep                       = MLX90615_OP_SLEEP,
>>>> +       .dual_channel                   = false,
>>>> +       .wakeup_delay_ms                = MLX90615_TIMING_WAKEUP,
>>>> +       .emissivity_max                 = 16383,
>>>> +       .emissivity_res                 = 1000 000 000 / 16383,
>>> This makes me wonder if we could just drop the emissivity_res and have
>>> it calculate it using emissivity_max, since both chips will do it.
>>
>> We can do that (i.e. change done locally now).
>>
>>>> +       .fir_config_mask                = 0,    /* MLX90615 FIR is fixed */
>>>> +       .iir_config_mask                = MLX90615_CONFIG_IIR_MASK,
>>>> +       /* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
>>>> +       .iir_valid_offset               = 1,
>>>> +       .iir_values                     = { 723, 77, 42, 31, 28, 20, 18 },
>>>> +       .iir_freqs                      = {
>>>> +               { 0, 180000 },  /* 14% ~= 0.18 Hz */
>>>> +               { 0, 200000 },  /* 17% ~= 0.20 Hz */
>>>> +               { 0, 280000 },  /* 20% ~= 0.28 Hz */
>>>> +               { 0, 310000 },  /* 25% ~= 0.31 Hz */
>>>> +               { 0, 420000 },  /* 33% ~= 0.42 Hz */
>>>> +               { 0, 770000 },  /* 50% ~= 0.77 Hz */
>>>> +               { 7, 230000 },  /* 100% ~= 7.23 Hz */
>>
>> Before I send a V3, can you please double-check these ^ IIR coefficients
>> ? I approximated those, but I suspect my approximation might not be
>> accurate.
>>
> I have reached out to the developer for the 90615 and here is his message:
> 
> 0b0000 - Forbidden value
> 0b0001 - 100% - settling time = refresh rate = 205ms (around 5Hz)
> 0b0010 - 50% - settling time = 2050ms (around 0.5Hz)
> 0b0011 - 33% - settling time = 36900ms (around 0.3Hz)
> 0b0100 - 25% - settling time = 5125ms (around 0.2Hz)
> 0b0101 - 20% - settling time = 6355ms (around 0.15Hz)
> 0b0110 - 17% - settling time = 7790ms (around 0.13Hz)
> 0b0111 - 14% - settling time = 9225ms (around 0.1Hz)
> 
> It does differ to yours, so what was your source?

Approximation, really ... clearly they were wrong, so thanks for checking !

Fixed in V3.
