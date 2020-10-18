Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3902917FC
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgJRPGL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 11:06:11 -0400
Received: from first.geanix.com ([116.203.34.67]:55400 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRPGK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 11:06:10 -0400
Received: from [192.168.100.10] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id D34E7F41ECC;
        Sun, 18 Oct 2020 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1603033563; bh=PPgyaGfIcTVU2khuBuMuuMVpu9BWmP6CSexm4zkpF84=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hpvd00Fnre9r0kps0xMvpWrxw0+tNwaLw3FHssUxP4cOkrh2Osdo+XWCkp9lXf9xR
         u6Ec4MXJLv7guSCXu/ZjpSVMusXrw7jY3fOajCztLcODQHaN5aRjLZ766VpOjo2q/4
         t/dhRNyvpv1h4SLo1AW8Nkif5GNtDaDXnfYizFMIgfZsXZWg8oMkyVopxFx5hTTFry
         jCoXJySKP2i5Bo7sjIaSshTPY/L0Vza7SLNaHkijLRT+0OWSkVyQkixetOOefATPkq
         I3ON5rOGT6TfMENjHJFT4gcKiSjIG72yrVIURM4FfClonoZXsPpxQ/dzwI6HDOqjK7
         BqbUfPjtLnuhQ==
Subject: Re: [PATCH 12/29] dt-bindings:iio:dac:ti,dac5571 yaml conversion.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201011170749.243680-1-jic23@kernel.org>
 <20201011170749.243680-13-jic23@kernel.org>
 <3812d0a0-7a70-d30c-7fd5-705e2fdef89c@geanix.com>
 <20201018105839.442666ee@archlinux>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <706ef6f1-d01c-3059-a6cf-be60f0e74130@geanix.com>
Date:   Sun, 18 Oct 2020 17:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201018105839.442666ee@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 18/10/2020 11.58, Jonathan Cameron wrote:
> On Sun, 11 Oct 2020 19:47:19 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>
>> On 11/10/2020 19.07, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> A few tweaks in this conversion.
>>> * The example didn't have the I2C address of 4C in the node name so
>>>     fixed that.
>>> * The reference voltage in the txt file is an optional binding, but
>>>     the driver is making use of it to provide the scaling of the output
>>>     channels.  As such I have made it required going forwards.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: Sean Nyekjaer <sean@geanix.com>
>>>   
>> Looks good :)
> Hi Sean,  Good to know, but if you are happy to give a formal
> Acked-by, or Reviewed-by always appreciated!
Acked-by: Sean Nyekjaer <sean@geanix.com>
Sure :)
I just thought it would be weird then I already had the Cc...

/Sean
