Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0A595852
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiHPKcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiHPKbp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 06:31:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840B513D8DD
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 01:26:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b96so12571587edf.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QDEve6J+FvXDoisqTMwo0p9DvKs3kysq/xhm5KZN/F8=;
        b=x4ZT5feLMaQ/Wgubwh3Hh3K6rOaF0UpMyoMCMsyXRfALVt3fukFYV+LUVN6RHT+xvq
         m+bvgD40p+GdrNbsmiAFwUnNF45m8BefjVWh5rFYs4sYghVcojRrHKbt6xnsFP4uR9s7
         zBGNFPk0IRSVVUHqKkQWeXn8hWJeeT3PLXt84DqBo4V9PYzyqmnittq/BuOxY5nP2Zi7
         XH1vgqDIMD3efS2lg16k2VP8dWtr1pUxTmlR/+CyrnzfSbN+XCHkwMRZqK/OI40x1ud+
         bssuky03t4h6u280TM3PF9/mO/K+YNuzS75HiT/SGo5SppwUlc3GHmDDrnQOJ7Br5xFx
         O0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QDEve6J+FvXDoisqTMwo0p9DvKs3kysq/xhm5KZN/F8=;
        b=sHe5QryGK7xl8M56VM1ESuA/oHD4N6H51/wLyHZq4MV/gD3tl7iriWz7vV/wXKMy+4
         tgM0oyXzf17qCap70ElWmwcLiflTsf6ItT9j8V2/GHo1ny/jODzZkBAc8QmoNGk8rCNA
         TuRzk6jR5gzF7/esTeP+hBFmfZQV0WtObAUGJRC4UcJDUzC8lA9BDwMpxSUBzj0TQCJy
         +qokQsta19xn1SZh8lsDlGG7DUJyUbbBdtEn24X0qYnz07lSpVZUh4W8QH8cFzmjrcQe
         6LOkySQVmMDK4Vulc6OnBRJra20xj7A2+j6T05XRhzbflxiwTiForCgE8O9Q+viO0CH1
         9XLw==
X-Gm-Message-State: ACgBeo2azsWZ+X3UAZKcgkpLSAHDiIGv9wFeuD0vswx5yRNnLrn2WhBg
        qusGIYLIY2hxyCw/SD1gc7uwhQ==
X-Google-Smtp-Source: AA6agR67zf10EbPitdqUQl3FsEBWXIw/eieDrOVQ5oSnllulorwU6g/JwdIB55zfcvWNvkr+S7Q5pw==
X-Received: by 2002:a05:6402:448b:b0:43b:5ec6:8863 with SMTP id er11-20020a056402448b00b0043b5ec68863mr17413054edb.377.1660638414930;
        Tue, 16 Aug 2022 01:26:54 -0700 (PDT)
Received: from [192.168.1.69] (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906328500b00731219a2797sm4929454ejw.210.2022.08.16.01.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 01:26:54 -0700 (PDT)
Message-ID: <47fdb798-b66e-3d30-dcbe-a3d15dc45619@baylibre.com>
Date:   Tue, 16 Aug 2022 10:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v4 0/3] ECAP support on TI AM62x SoC
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     robh+dt@kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <Yvk4OijjBj+Wa7fT@fedora>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <Yvk4OijjBj+Wa7fT@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 14/08/2022 20:00, William Breathitt Gray wrote:
> On Wed, Aug 10, 2022 at 04:07:21PM +0200, Julien Panis wrote:
>> The Enhanced Capture (ECAP) module can be used to timestamp events
>> detected on signal input pin. It can be used for time measurements
>> of pulse train signals.
>>
>> ECAP module includes 4 timestamp capture registers. For all 4 sequenced
>> timestamp capture events (1->2->3->4->1->...), edge polarity (falling/rising
>> edge) can be selected.
>>
>> This driver leverages counter subsystem to :
>> - select edge polarity for all 4 capture events (event mode)
>> - log timestamps for each capture event
>> Event polarity, and CAP1/2/3/4 timestamps give all the information
>> about the input pulse train. Further information can easily be computed :
>> period and/or duty cycle if frequency is constant, elapsed time between
>> pulses, etc...
>>
>> Modifications since v3:
>> 	- Migrate driver from IIO to Counter subsystem
>> 	- Minor modification in yaml ($id) to match Counter subsystem
>> 	- Add ABI documentation
>>
>> Userspace commands :
>> 	### SIGNAL ###
>> 	cd /sys/bus/counter/devices/counter0/signal0
>>
>> 	# Get available polarities for each capture event
>> 	cat polarity1_available
>> 	cat polarity2_available
>> 	cat polarity3_available
>> 	cat polarity4_available
>>
>> 	# Get polarity for each capture event
>> 	cat polarity1
>> 	cat polarity2
>> 	cat polarity3
>> 	cat polarity4
>>
>> 	# Set polarity for each capture event
>> 	echo rising > polarity1
>> 	echo falling > polarity2
>> 	echo rising > polarity3
>> 	echo falling > polarity4
>>
>> 	### COUNT ###
>> 	cd /sys/bus/counter/devices/counter0/count0
>>
>> 	# Run ECAP
>> 	echo 1 > enable
>>
>> 	# Get current timebase counter value
>> 	cat count
>>
>> 	# Get captured timestamps
>> 	cat capture1
>> 	cat capture2
>> 	cat capture3
>> 	cat capture4
>>
>> 	# Note that counter watches can also be used to get
>> 	# data from userspace application
>> 	# -> see tools/counter/counter_example.c
>>
>> 	# Stop ECAP
>> 	echo 0 > enable
>>
>> Julien Panis (3):
>>    dt-binding: counter: add ti,am62-ecap-capture.yaml
>>    Documentation: ABI: add sysfs-bus-counter-ecap
>>    counter: capture-tiecap: capture driver support for ECAP
>>
>>   .../ABI/testing/sysfs-bus-counter-ecap        |  64 ++
>>   .../counter/ti,am62-ecap-capture.yaml         |  61 ++
>>   drivers/counter/Kconfig                       |  14 +
>>   drivers/counter/Makefile                      |   1 +
>>   drivers/counter/capture-tiecap.c              | 634 ++++++++++++++++++
>>   include/uapi/linux/counter.h                  |   2 +
>>   6 files changed, 776 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ecap
>>   create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
>>   create mode 100644 drivers/counter/capture-tiecap.c
>>
>> -- 
>> 2.25.1
> Something that has become apparent to me is the code repetition in this
> driver in order to support the capture buffer. Buffers are common
> components in devices, so it'll be good for us to standardize some of
> what we're exploring here into an interface that other drivers can also
> use. We have two ABIs to consider: the driver interface and the sysfs
> interface.
>
> For the sysfs interface, I think we'll have to expose each element
> individually (e.g. capture1, capture2, etc.) because sysfs attributes
> are suppose to expose only a single datum for any given attribute.
>
> For the driver side, we might want to introduce a new Counter component
> type for buffers and respective macros to streamline some of the code
> for driver authors. For example, a new COUNTER_COMP_BUFFER_U64 enum
> counter_comp_type constant could be introduced to represent a u64 buffer
> element; respective struct counter_comp read callbacks could be
> introduced::
>
>      int (*count_buffer_u64_read)(struct counter_device *counter,
>                                   struct counter_count *count,
> 				 size_t index, u64 *val);
>
> So a driver author can use the "index" parameter to locate the buffer
> element and pass back its value via the "val" parameter.To define the
> buffer, maybe helper macros like this could be introduced::
>
>      COUNTER_COMP_COUNT_BUFFER_U64("capture", ecap_cnt_cap_read, 4)
>
> This would define four u64 buffer elements each named prefixed with
> "capture" and with their read callbacks set to ecap_cnt_cap_read().

Somehow, this "index" parameter would make things much easier for driver 
author.
Besides, defining all these similar functions (cap1_read, ..., 
cap4_read) does not really
make sense for ECAP driver.
So, accessing this index parameter through callback and having the 
possibility to use
the same function (cap_read) for several attributes would be great for 
my driver,
and probably for future ones.

>
> One problem however is that I'm not sure if the C preprocessor would be
> able to unroll the COUNTER_COMP_COUNT_BUFFER_U64 to a dynamic number of
> elements based on a macro parameter (maybe there is a GCC extension).
>
> I'm just throwing out ideas, so I'd like to hear some comments and
> suggestions from others about how we should add buffer support to the
> Counter subsystem.
>
> William Breathitt Gray

