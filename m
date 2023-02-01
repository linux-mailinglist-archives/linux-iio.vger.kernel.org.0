Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC27685F4C
	for <lists+linux-iio@lfdr.de>; Wed,  1 Feb 2023 06:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjBAFzS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Feb 2023 00:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBAFzR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2023 00:55:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF7A24B;
        Tue, 31 Jan 2023 21:55:16 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mf7so29445973ejc.6;
        Tue, 31 Jan 2023 21:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S+H5SYc0nIdzMynDkQ9HqKI/ognTOvTuBLyhVNPH+U=;
        b=MLlcGRhcqMEGtS3Dzadm3gAu5izBe+Jdl2wD1MJy5blaxWCuNY8rImFzS2gx9T/mgp
         1HrvkPuWo9NEBDlobGaJ65b/jRIH2MFgUtEcHXW1TmgHw90qYsbfMNhcvJDu7hPwEJ1s
         BK5h2jcicotkhgGQxAxVC0h3047QLjyb2J63ieO1nXBXzdljpVIaO0lBgugWA6wceAWR
         fBCiNNrSPavpuen72kcRpEBZqpzlxPJeC/13/kprMVLpqgtjRHhEVAyxAUAUXodXz0o0
         F7F8m7jbuYNo5SiNK01EDcWKgTF2vz55sK3gMhYNREMiPa3zP2Xv7YKNyqAxMvBA1wmu
         RyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4S+H5SYc0nIdzMynDkQ9HqKI/ognTOvTuBLyhVNPH+U=;
        b=11ZbpCgh+Y+hVg4keXFLce7CaGddyJ0vGHY4uCGxtLxb+mFyGSlSxBjvnWJEmI3PIV
         vR5r7B1igpYlO+D0HkUToxSSBF19gTP6Xe4vhkAZdzfL6NH30MQNwZPW1OEFoVzGJRR9
         ej7ZJnb0zGcRPvcntar9xkQSJcS2fwL04+Ff0e4TsLa6aTspbjz+RQF+I0PODhpFcSX3
         Ikf1HkgR2KZu01I1NpxmZxWLZgGD7mA+E2vpMngYD3AIpK2tw3bTJ/GK1Uo57kJ5d4/7
         FYmPclgWacEWe6m1oQ8lUl9qBNQcLpZsmdwpSVbljerq+zYcSo30alXrJJIB53Ue6F/B
         mCpQ==
X-Gm-Message-State: AO0yUKWDMlgs/ppCxK7isVNo3abnyyn+84X+ckoBZRjBoCa2eA5dPDAq
        Hf3zJR01kA/V1A2Bb2fNHks=
X-Google-Smtp-Source: AK7set+lnrNdOuhoBKrNuNPjh3BZ67UDGiyEX9iF6J9/8hbZo3BuzDlIgiz+lH3kjdKQlks35F+TEw==
X-Received: by 2002:a17:907:362:b0:88d:697d:a3d2 with SMTP id rs2-20020a170907036200b0088d697da3d2mr1056793ejb.54.1675230915001;
        Tue, 31 Jan 2023 21:55:15 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906311500b0087045ae5935sm9479248ejx.1.2023.01.31.21.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 21:55:14 -0800 (PST)
Message-ID: <1e93f48b-57b8-f55a-8e49-9cebfeaca32a@gmail.com>
Date:   Wed, 1 Feb 2023 07:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, en-GB
To:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
 <20230130130231.000013b6@Huawei.com>
 <9b3dcc7a-a0f8-38ee-4381-d330004d436f@fi.rohmeurope.com>
 <20230130171218.00007802@Huawei.com>
 <0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com>
 <20230130201929.52c93ee5@jic23-huawei> <877cx24gsj.fsf@meer.lwn.net>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: ROHM ALS, integration time
In-Reply-To: <877cx24gsj.fsf@meer.lwn.net>
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

On 1/31/23 21:58, Jonathan Corbet wrote:
> Jonathan Cameron <jic23@kernel.org> writes:
> 
>> Both the kernel-doc for this header and the ABI docs end up in
>> the kernel html docs.  I wonder if a link is possible...
>> https://docs.kernel.org/driver-api/iio/core.html#industrial-i-o-devices
>> would have the iio_chan_type docs I think if there were any.
>> https://docs.kernel.org/admin-guide/abi-testing.html?highlight=abi#abi-sys-iio-devicex-in-intensityy-raw
>> is the matching ABI doc.
>>
>> Mauro, Jon, other docs system experts...
>>
>> I couldn't immediately find a way to link to a specific ABI docs entry,
>> is there a means to do it from kernel-doc in a header?
> 
> It should just be possible to write out the type or function name and
> have the links generated automatically.  Have you tried just putting
> "enum iio_chan_type" into the text?  If the automarkup code doesn't pick
> it up, please let me know.

As far as I understand - the problem here is that we would like to have 
a link from the enum/definition doc to a specific place in the ABI 
document. The ABI document does not have the enum / define / function 
"link _target_". (I think adding the enum/function name in the ABI doc 
would generate link from ABI doc to enum/function doc - which would be 
helpful - but in this case we would like to have a link to opposite 
direction. From function/enum doc to specific position in a (sysfs) ABI 
documentation. Please, bear with me if this was what your suggestion 
should achieve. I'd just like to ensure we are ton a same page with this.)

Yours,
	--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

