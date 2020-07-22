Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A622A25B
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 00:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGVWbV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVWbU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 18:31:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E099C0619DC;
        Wed, 22 Jul 2020 15:31:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so2058915pgm.2;
        Wed, 22 Jul 2020 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4YOZZgtCojO4ca/OukR4xZac6mF9k4JTg400bAU78OQ=;
        b=Nv+pojPj6i8MY605jfaB9m9dYskmgBYNQQBuSGuw15I1ZTU9m6Lt+ix94GE6Y2bqv3
         M/z4wk5SItqqu7qr6uVAbMogWV8z4uTz7Rt2ddO5d+Al4FLfdbXd8KjIPfuTrjR4Xiom
         JTG+CYpC/e2ar+aMo10lrUbrsFRrQIBiwTmPy/K2gd92gkda8k/1lTUE1kaQOdTIVZ75
         6uLtakTPzdkpqc3pQKDCf3E/vTSWgHKQ4eVmjgGdJWsHbHvA5MvlFfPUoqqobSWKUMqU
         3eoLCkeA+eTz7g1iM6G7k1Db6TlFr3s/VfIbtK4/57gUSq8LzohRSQLuCUU4ra/weu9V
         88Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4YOZZgtCojO4ca/OukR4xZac6mF9k4JTg400bAU78OQ=;
        b=sxOjmNXkglu2GhyYsdf9D3GJ0hwvZmslUY6jyrYdOM54ScPRiHEolpZZ2Cu4RXWGs1
         ue+vzwk49ClIPGKcmSWM/wR+4AzBsAijObmIKZ3zduC43eq2iivesBATsaaEol7HWroY
         HlzWNdBcpku7W2SeLGqqposag6DQxPtRQRMJHcfDc5iItM55828BxioCnoABxfkSonrN
         7yFjYv0bE6XF3wEYRQlLD3LgAc7vK3QiUWZwAK1O84/Ye/nKf10nAc5zPXrt9YWZ+HnY
         SnUVrn2/e03LVQnKcP/a3vvWdOj6C8JGRKbdQ+wBrKnUbZNBsR3Id2BNGwA0k3NRD4wP
         InSw==
X-Gm-Message-State: AOAM530muheCDsOYo2EkLJ0xnGM37JynC4Zd9GM97hbPr6M8kwUx7F5G
        dRXvCg3N15H/Ra55sUTjdV8=
X-Google-Smtp-Source: ABdhPJyWHgGWqQnq6V1AuPJ1NC3xi5jMST6BrnDZ4cslWLUWIWF1t1KLZOZ1gsmNhV0m7snqyYeCsQ==
X-Received: by 2002:a62:1958:: with SMTP id 85mr1615947pfz.246.1595457079868;
        Wed, 22 Jul 2020 15:31:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 9sm593148pfx.131.2020.07.22.15.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 15:31:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
References: <20200720202243.180230-1-linux@roeck-us.net>
 <20200722220301.GB2137556@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <30e48c84-8a51-55bf-8727-39872efd026b@roeck-us.net>
Date:   Wed, 22 Jul 2020 15:31:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722220301.GB2137556@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Brian,

On 7/22/20 3:03 PM, Brian Norris wrote:
> Hi Guenter,
> 
> On Mon, Jul 20, 2020 at 01:22:39PM -0700, Guenter Roeck wrote:
>> The EC reports a variety of error codes. Most of those, with the exception
>> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
>> error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
>> to Linux error codes to report a more meaningful error to the caller to aid
>> debugging.
>>
>> To prepare for this change, handle error codes other than -EPROTO for all
>> callers of cros_ec_cmd_xfer_status(). Specifically, no longer assume that
>> -EPROTO reflects an error from the EC and all other error codes reflect a
>> transfer error.
>>
>> v2: Add patches 1/4 to 3/4 to handle callers of cros_ec_cmd_xfer_status()
> 
> I did a rough grep to see what you might be missing:
> 
>   git grep -n EPROTO | grep -e cros -e '-ec'
> 
> I think cros-ec-pwm / cros_ec_num_pwms() might need fixing too? Boy, I

Yes, you are correct. And there was me thinking I got them all. Thanks a lot !

> wrote that, but it sure ain't easy to read...(*checks watch*)...4 years
> later.
> 
Usually I am quite embarrassed by code I wrote more than a couple of years
ago :-)

> Apart from the notes already made, I think the series looks good:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> > Feel free to CC me on v3, if you want another look
> 
I'll be happy to do that. I did make a couple of changes, so I'll add
your Reviewed-by: only to unchanged patches.

Thanks,
Guenter
