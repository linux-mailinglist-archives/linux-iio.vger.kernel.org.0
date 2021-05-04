Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0341D372F53
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhEDSBv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEDSBu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 14:01:50 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C58C061574;
        Tue,  4 May 2021 11:00:54 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t8so9648108oij.0;
        Tue, 04 May 2021 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bpTYLerbs3cpRxBsZQ7Tcbkhz3/56YeGJR+b1srqXs=;
        b=fcnQHpLNhWtBuuCEYrp0PH1b8GC7R3GkfvdeDYO6gUm6AFjhggcaFO91lwWkeTT4kU
         8APqqgBHUifbpjNY8CvIPnMg+ZBHbRD712XrbR0MoFIm1aTFHF1Fi5/VShHIUBGOqLv4
         1WQXh3qimYX1ijeB+RGxCeY/Xn47yrIe1DCl2EgZmuMYgoVphJQoBuvnb+tbH9V0JgzR
         995KPejlsDg5B7OJXiismiT75Z3Eyjqg0UUgQUkFAgXjr8mg1KiYOFYm+BYO817IpxtH
         k7qv3snSiT28R7TGnspvg3lwXqaDiDwpt6cLfJ79AInTcMoxYAKAThC9YxQHL60d/LlM
         C6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bpTYLerbs3cpRxBsZQ7Tcbkhz3/56YeGJR+b1srqXs=;
        b=o3/HIRsZN8WYJUYCUQYduAJV09mpp461a9Z3PFiis4c7sZK6vT3k1v4LXKubafPk0M
         sD8ryiwygE3UwizQopLAASYTgmjUZv1CYP1FWtK4I+cYvb7px9/RWSHho7qZjglx5+U/
         urSHxXbdXBO/cChUelDhPdEIV78yoKgbPQdpfKJXx1o24XC2hIFRKR9PV/g95+3S9WHm
         96bCoKnqIfZj6M1PbxIojG62Yk1n+HkTkNOuuJ0wXODB1GP2vAatTOGJwSOhKPb51UgB
         /rWqCGIvWTVx+gm+1URL5sG1KncJKQJKraX8kZYQ29tuGideC1+/GcKYYS85jcnjEdOh
         0Q8A==
X-Gm-Message-State: AOAM533lu98As5S0GIs37iGZxd2ijQsWJWiqI6Y13u8TQTzq+j8KRd34
        yzMLZNQnMq2TOTfSKHI7/h0=
X-Google-Smtp-Source: ABdhPJxTrZJiF8p7/PYS2bSHASwFR4SWealjCGj8Y1PViDt9tXVWwdTNscQKxnU/rRBAAK1TUE2Ysg==
X-Received: by 2002:aca:39c1:: with SMTP id g184mr4032192oia.120.1620151254235;
        Tue, 04 May 2021 11:00:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q26sm977071otn.0.2021.05.04.11.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 11:00:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on
 CONFIG_ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210504174019.2134652-1-linux@roeck-us.net>
 <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net>
Date:   Tue, 4 May 2021 11:00:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/4/21 10:44 AM, Andy Shevchenko wrote:
> On Tue, May 4, 2021 at 8:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> With CONFIG_ACPI=n and -Werror, 0-day reports:
>>
>> drivers/iio/chemical/bme680_i2c.c:46:36: error:
>>         'bme680_acpi_match' defined but not used
> 
>> Given the other patch, question of course is if this ACPI ID
>> is real. A Google search suggests that this might not be the case.
>> Should we remove it as well ? STK8312 has the same problem.
> 
> For this one definitely removal. Looking into the code it suggests a
> cargo cult taken that time by a few contributors to invent fake ACPI
> IDs while submitting new drivers.
> Feel free to add my tag or if you wish me I'll add it explicitly.
> 

I'll resend and let you add the tag, and send a similar patch
for STK8312. I'll wait until tomorrow, though - I sent a number of
patches today already, and I want to avoid yet another "account
suspended" notice from gmail.

Thanks,
Guenter
