Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAE4E3CA1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiCVKmn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 06:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiCVKmm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 06:42:42 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BAF81192;
        Tue, 22 Mar 2022 03:41:15 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id r22so15193942ejs.11;
        Tue, 22 Mar 2022 03:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=qKsgBbH9sIwu8qSu/STqDYAzfDFmWwxMdPPPch9rKoo=;
        b=YJtqJfb9YWQKxKRWY8XpJuB/us8RJ7zzZTuLakfyl0P2IbrYDeDEsQr31SS8uP0ivE
         DL51QkNZ2sLoDG6j/6m3ylZ3fenvGcJpyEmlAJOAcuU9N9gfgrNqJrpR1sIpWyUPT7w+
         4IJY7PUzPalcfj2PiD7O6IxFfD9PBq+zSgBe2QR6imcZYAzCbJzi7u6aG+gLGT/15jRE
         /LIYJW+q+sBhbTjORvK7ySjbDwBm2Xpia3+3CyFXYTWu9GPxVrjplIf36M55ZHDmJNcE
         iLCiATfy3O5GGGzjzb1FOnY+J2U7nyXz58TsVogsBO8sh/aoj93EB9Tgln8LFrQZUNVz
         mDwQ==
X-Gm-Message-State: AOAM533YalrMs+AEB+Zge3+nOfa9vPbu+pX82JEjtrQFEP0T9TF68gJ2
        8EceFXVyy1eYHN3xreK++jY=
X-Google-Smtp-Source: ABdhPJx3hmEoX2a/mq4nDJpm2NjVc9WqDd8OqoSNBqpEvjrjLfVZlO4te+uPT64JeyhAok2gWezbNw==
X-Received: by 2002:a17:907:7e8c:b0:6dc:b357:2f4 with SMTP id qb12-20020a1709077e8c00b006dcb35702f4mr25039728ejc.434.1647945673640;
        Tue, 22 Mar 2022 03:41:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm9404307eds.21.2022.03.22.03.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 03:41:12 -0700 (PDT)
Message-ID: <5709ab75-2c9e-d7d3-eaf7-4619583bb6c6@kernel.org>
Date:   Tue, 22 Mar 2022 11:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Michael Srba <Michael.Srba@seznam.cz>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220310133938.2495-1-michael.srba@seznam.cz>
 <20220310133938.2495-2-michael.srba@seznam.cz>
 <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
 <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
 <145bddd6-0a7e-95f4-5282-b1900f020d88@canonical.com>
 <20220320151223.3a9b13bd@jic23-huawei>
 <ca80bd79-338c-98a4-2f4d-4dcfc52ed538@kernel.org>
 <20220321150411.00002206@Huawei.com>
 <47d67c82-788e-2ced-54cc-4959c67922fc@kernel.org>
 <20220321174202.00007895@Huawei.com>
 <f8ba569f-d230-92a8-6a56-fbcaf620af36@seznam.cz>
 <20220322101916.0000759f@Huawei.com>
In-Reply-To: <20220322101916.0000759f@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22/03/2022 11:19, Jonathan Cameron wrote:
>>> Obviously it wouldn't work anyway with an old kernel, but
>>> without the fallback compatible at least there would be no error message
>>> saying that the device is not the icm20608 we expected to see.  
>> I'm not sure if that's really an issue?
>> The old kernel is clearly not handling the compatible "correctly",
>> since the compatible says that the interface is a superset of
>> the icm20608 interface, and that using the icm20608
>> interface will work.
>> If the driver makes the incorrect assumption that
>> the WHOAMI being different means the interface cannot
>> be icm20608 compatible, then that seems like an issue
>> with the driver?
>> And I believe the single reason for why catering to
>> a broken driver would ever be considered is if not doing
>> so would result in breaking the devicetree ABI promise,
>> which doesn't seem to happen here.
> 
> I'll be honest I no longer care that much either way.
> 
> If someone would point me to clear documentation of that
> DT ABI promise 

Documentation/devicetree/bindings/ABI.rst

> and how it describes things as being compatible
> that would be great and provide me with a clear statement
> to point others to in the future.

It's very concise, so let me decipher the first paragraph. It is safe to
add new compatibles to the chain (so exactly like here "icm20608d,
icm20608") because the system can bind:
1. against new compatible bringing all new features,
2. old compatible, working with "old" or limited set of features.

What I was explaining you in mails before, which you responded to with:
"Whilst I don't personally agree with the definition of "compatible"
and think you are making false distinctions between hardware and
software..."
we do not talk here about software, as in device driver. We talk about
bindings which describe the hardware, therefore the compatible should be
rather understood in the hardware model, not driver model.

The compatible field does not mean that one driver is compatible with
this or other hardware. It means that devices have a compatible
programming model or interface.

Now driver should be implemented in that way. If driver handles
"icm20608" compatible, it should nicely handle only icm20608 features,
regardless whether device is icm20608 or icm20608d.

Now let's imagine, that icm20608d is slightly different than icm20608 in
the basic feature set. Than it's not compatible and should deserve
another separate binding entry, regardless how driver handles it.

Keep in mind what Rob said - driver implementation can changed, but
device compatibility in bindings should stay the same. Specially that
bindings are used in other operating systems (*BSD) and software pieces
(u-boot).

> Perhaps I've just been missing that documentation or it
> needs writing.
> 
> I think that having to ignore a WHOAMI value that
> is unknown to the driver because there might be a future part
> which is compatible is a very bad way to support
> devices in a reliable fashion and going to lead to annoyed
> users and bug reports.

I see your point. It's a safer choice than just accepting any device.
However it's a designer/programmers fault to provide a DTB with a
matching compatible for a non-compatible device. Not driver programmer
fault. Usually you do not have to protect the driver from it.

> This is different to electing to
> using a shared compatible when two parts are introduced at
> the same time and we are doing detection in the driver of
> which variant we have.
> 
> I mentioned earlier that we have this type of defensive coding
> precisely because we have had false assessments about
> compatibility in the past. This manufacturer does not in
> general document compatibility across parts. I have no idea if
> they do for this particular part as there doesn't seem to be
> a public datasheet.

Kind of continuing my previous thought also here - it's not a problem of
driver developer, but DTB developer. If the devices are not compatible
(thus driver will not work correctly), the person using that compatible
in DTB made mistake. Bug reports should be sent to that person, not to
driver developer, not to you.

> It didn't work before, now it won't work and will complain about it
> which may lead to some bug reports that won't be resolved but
> I'll adopt the majority opinion which seems to be that we
> don't care about that.

Yes, we don't care but the DTB/DTS person should. :)

>  I'd also be happy to see us reduce
> the problem scope here by having a 'fix' for that rejection
> of unknown IDs that we can push back to stable kernels.
> Relaxing it to a warning should be sufficient, though we probably
> want to screen out whatever comes back from the bus if there
> is no device present at all as the WHOAMI check is also
> providing that protection.

A dev_warn() with a disclaimer might be actually better approach. Unless
it might be a safety-critical device.

Best regards,
Krzysztof
