Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796E81930BF
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 19:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCYS5Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 14:57:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33565 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYS5Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 14:57:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id f20so3753684ljm.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2020 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AM9JRTVmuwb4of4Lx8z673J9cp23w437LqTHG6dpT30=;
        b=s6FxMbYoKa4BAY4CbNLSQ2i2zB5y2N3N+qW/ocIYe6XfusU4uk1VnpoWCBKmvo3Z3o
         gil/1n+YoItk+0x1MzOdZi6iEegMD8s6FnbvAn2hAfLkdUEI7Y3y2yDubfQirgwGH1Rf
         7dR/YvZApsc/ajoEq0QdvrtkccARt9KK2SVMUsbFsdi6toSWnWc7dUXPo3mB+K0uKaHo
         xTNVnP3OTOCitgo9sMvXU99yjPPK+KzRcKt0x3ceG4QzKLLs7k+XC3lqiSfj1p1KRB3t
         2AkCdP5N5jchVuZgjkECtpzkvfIwIZY1V0maDyT3hbAjr0zQaUZS02ua3nZKQjtq/Vv2
         rFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AM9JRTVmuwb4of4Lx8z673J9cp23w437LqTHG6dpT30=;
        b=soCs9aAsJl37cnqlvoehgve1XlhIPZXgmKfUHhrhI9SO4Kv59BY+1zCteOyGR+Ens4
         5xdXeUH3t0cAOsZKFuYZevV+ksuXNYMir6vhQdOtPPuNeQDfmH5V0d4CP9BIsuMANEXh
         dwSEIni68QdtqRV1eH2pJOFuwt4C1zJUsQhlzQ2SEpEHB6Y4RSK/0Fe5s26rlM1DuK/n
         7o8YDlMToaoe1I8Mn6BepLPafBrYf2I9I2L4d/buoZF+zXpg/mFbNFNWcDe0GbucjHyF
         SQvygrjeLnOGzCVgc1k3dnKq81wWlLknIF5TJoTREUyb6FAHF7bZT6cyVCirkJ5doS6E
         c9ZA==
X-Gm-Message-State: AGi0PuYnQKzuZSgRHruyB77sYoOZyrHNxLLm9mD6KmbQm5mUsG6aoJ+g
        ovf5dX25d+XFmMLNiV8ZBX8=
X-Google-Smtp-Source: ADFU+vtlb4Tb33+oyHtEY/NS7J9UUSI6w+79ixP9vJbNovf5e+k0WKOfqvdY1dsQXmTLfsa8a3PQMw==
X-Received: by 2002:a2e:97d7:: with SMTP id m23mr2960150ljj.122.1585162643467;
        Wed, 25 Mar 2020 11:57:23 -0700 (PDT)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id f26sm2625207lfc.76.2020.03.25.11.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 11:57:22 -0700 (PDT)
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Add sensor hub device LIS3MDL
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <20200324215226.1711659-1-jimmyassarsson@gmail.com>
 <20200324215226.1711659-2-jimmyassarsson@gmail.com>
 <9f984a4d-b8df-2459-c330-409277b14c3e@gmail.com>
 <CAHp75VcoVpPvhGQR6D5riLN7DUr+n9FdC-qDwvTHZNF5fnYp7g@mail.gmail.com>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <0986b77a-db9c-8f04-be54-5541eb508fd7@gmail.com>
Date:   Wed, 25 Mar 2020 19:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcoVpPvhGQR6D5riLN7DUr+n9FdC-qDwvTHZNF5fnYp7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-03-25 12:02, Andy Shevchenko wrote:
> On Tue, Mar 24, 2020 at 11:59 PM Jimmy Assarsson
> <jimmyassarsson@gmail.com> wrote:
>> On 2020-03-24 22:52, Jimmy Assarsson wrote:
> 
> ...
> 
>>> +             .wai = {
>>> +                     .addr = 0x0f,
>>
>> In st_magn_core.c this is ST_SENSORS_DEFAULT_WAI_ADDRESS
>> (from linux/iio/common/st_sensors.h). Is this OK, our should I change it?
> 
> I would rather use macro, Easier to grep what is being used with ST sensors.

Sure, will fix it in v2.

>>
>>> +                     .val = 0x3d,
>>> +             },
