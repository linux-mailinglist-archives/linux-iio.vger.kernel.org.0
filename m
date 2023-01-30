Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3679468188A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 19:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbjA3STR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 13:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjA3STQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 13:19:16 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609162BEE2
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 10:19:11 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hx15so14812089ejc.11
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln6Nlsw0SaCXwV08Wc3XA/O3DxIrjhnGgSdhh99R3dU=;
        b=ZJ1z87llDdcJpgpy821pNNQdZN5wWzjwcjMURRTrTh5wvkIcRh937kkblG45y4Lb58
         ZfTZYnm0YNWixIKR4JnlgsPrOIRpYM+QPyagKHzLjk4XLrM2ZxH6+kcz/gVfkf0dC8ao
         KXwCqD14dLy/InNFeaJpMLW8vnKlBLSBDMoEbvhI94HMHE/1PhfpDPB41863W+kjVp6b
         ZcdQ3Qn0nimcFfp9n/N/LDygLc4nrmsFu7go9UelC/mIkE+8Jz/rF/Pa84eTRf5XurVM
         kguVKUo3XtTGpp2U1ybz+velV+PXE51bW+z9gzNINFj9oHf/lWiuKpj/BoE7Z+s6H3Qc
         YoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln6Nlsw0SaCXwV08Wc3XA/O3DxIrjhnGgSdhh99R3dU=;
        b=HJyzDRTM9dgYtd+UxHDpnkSDxV2ZRzSYSP56tLwtrvIBYSSxSx8VIrQbvk0rV+aUzu
         8Q3iulKvQ9hfDaUQqfkja1+jTvxEFoYWUkS/BYIrYARogI1KvYTn29IVbmGpw0NBzYsO
         sbmU9TByEyB03b1jJhR4i9YADbIZxw5Vh8sCD0v99y6Xovp/BP6GEtmG5afW3KA1+qAi
         A2yPY/6L9gRaVGTJ4y5Oq2p3osT8BNFeSwoJwQKrUa7c3FvyH5YhFpV5Fiz5p+CQjeV8
         ngMqkVMDynwVBteUWF3nAJwA36ng4iQObMcA7HU/2YxYheuJFIc3fa8Ux2sOCd9Xf89J
         LRjQ==
X-Gm-Message-State: AO0yUKVNd9X7PXze87HiL1GfPRQPU+4wLOQyHjWbC8s0cR14pkwq4Ioc
        No/QQg5iHKX4BublM5NYZTD3eUtf0sU=
X-Google-Smtp-Source: AK7set8zDh0RE5JcS47koOxjbk8/NtN7xHvxUxrp1vNTXEkMet3XOIy9gaNX5RobjVFIYYH1lheFWQ==
X-Received: by 2002:a17:906:7c06:b0:7c0:d609:6f9b with SMTP id t6-20020a1709067c0600b007c0d6096f9bmr430345ejo.27.1675102749862;
        Mon, 30 Jan 2023 10:19:09 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906c21200b0084ce5d5d21bsm7132106ejz.22.2023.01.30.10.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 10:19:09 -0800 (PST)
Message-ID: <0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com>
Date:   Mon, 30 Jan 2023 20:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
 <20230130130231.000013b6@Huawei.com>
 <9b3dcc7a-a0f8-38ee-4381-d330004d436f@fi.rohmeurope.com>
 <20230130171218.00007802@Huawei.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: ROHM ALS, integration time
In-Reply-To: <20230130171218.00007802@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/30/23 19:12, Jonathan Cameron wrote:
> On Mon, 30 Jan 2023 13:42:27 +0000
> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> 
>> On 1/30/23 15:02, Jonathan Cameron wrote:
>>> On Mon, 30 Jan 2023 14:04:53 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>> For an occasional contributor like me it could be helpful if the defines
>> like IIO_INTENSITY, IIO_LIGHT had documentation in headers explaining
>> for example the units. Maybe also some words about the
>> IIO_CHAN_INFO_INT_TIME and IIO_CHAN_INFO_SCALE as well ;) I guess I can
>> cook some doc - but only for couple of defines which I have discussed
>> with you this far. Do you think such comment docs would be welcome -
>> even if they covered only couple of defines? Maybe others would continue
>> from that.
> 
> I'd worry about the Docs disagreeing with the ABI docs
> in Documentation/ABI/testing/sysfs-bus-iio
> which needs to be the 'one true source' of this stuff.

Oh, right. It might've been just me - but I did overlook this golden 
documentation. I did actually land on this document but didn't really 
pay the required attention. I guess I allowed the kernel version in the 
page to distract me thinking it is some sort of 'history' stuff.

What would have been enough (even for me) would've been a short 
description of a define - and then the link to a entry which corresponds 
the define in this document. Something along the lines:

/**
  * iio_chan_type - Types of channel
  *
  * Please find the detailed documentation for reported values from the
  * Documentation/ABI/testing/sysfs-bus-iio. Pointer to correct keyword
  * in documentation is mentioned at the channel define description
  * below.
  *
  * IIO_INTENSITY:	Channel for unitless intensity.
  *			Doc keyword: in_intensityY_raw			
  *
  * IIO_LIGHT:		Channel for visible light intensity in lux
  * 			Doc keyword: in_illuminance_raw
  */

I have a feeling that this would already have helped me. Nevertheless, I 
would not mind seeing docs also for the iio_chan_info_enum values - but 
linking to the correct spot in sysfs-bus-iio might not be as easy.

Anyays, Thanks for the help once again :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

