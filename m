Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1185F44524C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 12:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhKDLje (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 07:39:34 -0400
Received: from www381.your-server.de ([78.46.137.84]:41236 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDLjd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 07:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=olemnntpwY3zMU4uUrb7V6ihXdPom88Ox/r94Kcg/L8=; b=QfCGPeGD7U5i5MKndzfMbato15
        zygiLI+RGDTH8rNfa73KEQ8l8QDMXJYmWrdfm5XioaTrOCjO0f+wWD1KBLb94/LAvnLceH9+ZGo9k
        JOKUjxK1ch5j0hsD0hCIQJ24lOcQNEPFoT4h+GNfoFVNJgyY8Jb2ALOx0CbWGqXqag13k2POxlhDi
        yiDdwFLb4biHh44QveCBu7lBvVXx0B5547+zs7ToJLktCRgAidonj3+k8ZogdnMgMk26BFbYY0Z3G
        HaNdkfrStqj84orFqbL9saYELXwmWagGYzgZAIMUpWsYYUPxbtVXMKU5agNh3dv7D6M+8NWiqq7gW
        bLPtUeQw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mib37-0008Bz-Hd; Thu, 04 Nov 2021 12:36:53 +0100
Received: from [82.135.83.112] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mib37-000I8x-Cy; Thu, 04 Nov 2021 12:36:53 +0100
Subject: Re: [PATCH] iio: dln2: Check return value of
 devm_iio_trigger_register()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jack Andersen <jackoalan@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20211101133043.6974-1-lars@metafoo.de>
 <CAHp75VeZgi6CS6c67pHUARDLp_oR4ek9ctBiAy7=1KMC6q932w@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <652a3724-0312-0b4f-5969-86707f553613@metafoo.de>
Date:   Thu, 4 Nov 2021 12:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeZgi6CS6c67pHUARDLp_oR4ek9ctBiAy7=1KMC6q932w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26343/Thu Nov  4 09:22:31 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/4/21 11:35 AM, Andy Shevchenko wrote:
> On Mon, Nov 1, 2021 at 3:31 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>> Registering a trigger can fail and the return value of
>> devm_iio_trigger_register() must be checked. Otherwise undefined behavior
>> can occur when the trigger is used.
> ...
>
>> +       ret = devm_iio_trigger_register(dev, dln2->trig);
>> +       if (ret) {
>> +               dev_err(dev, "failed to register trigger: %d\n", ret);
>> +               return ret;
> It's fine to use dev_err_ptobe() in ->probe() even for known error codes.
> Hence,
>
> if (ret)
>   return dev_err_probe(dev, ret, "failed to register trigger\n");
>
>> +       }
> Should it be a separate patch?
>
I'm a big fan of dev_err_probe() using it in all my new drivers for 
everything.

But here I'm trying to stay with the style of the existing driver. And 
we also want to have this as a fix that can potentially be backported.

The conversion to dev_err_probe() is best done for the whole driver in a 
separate feature patch.

