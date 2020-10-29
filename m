Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69629EEA1
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 15:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgJ2OoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgJ2OoM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 10:44:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174CC0613D2;
        Thu, 29 Oct 2020 07:44:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r10so1403193plx.3;
        Thu, 29 Oct 2020 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F2veZZJSq3DocBjLKyefRgKHa5wllxVXQll/nwjlSWk=;
        b=Op8SBRcPqL/SZEVejO88Styz7/vwYq3Y9GrhamWquhddcSmFRkXJGuLx8Jwo3n6Zb8
         y+JR9bsFe9Pm2pg46VvIjMoZ0wKtc3grHT5QnHNK9lDDzvNQ+0+D2T7uMMMbfZGydqC1
         f+l7ZyxQCjb8opFWDdln5C0/2SuADifVj9UO+qGkRCkjk94AtkWPF3poI4JmCVVnWVmo
         uB5ZbdZh4YKRnqwsTiFryhIo8aW4/1TOb4poBEdWR2zO3O+XnnQmbrTQaXOcIivMi1Ii
         rvc3HJFfritwib9V0MkWWbIx39gB5IWBPN7ccOT/UO8HEZXTsKhNWRoBwdoAHkkeqLiZ
         lAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2veZZJSq3DocBjLKyefRgKHa5wllxVXQll/nwjlSWk=;
        b=j5tMYd4PE72NDzq+tuKvtTYpMKwwqppzXPtIl9UXC3F+cpSNESFUiN/YHXql6NjE1c
         3ISI3XHf3KFJag4GG0e4xEVdJrFY4qaeT+oETKEL/IgZKglj1D9eZx1HAZri8xCksL82
         sFMORP9I1V7tsVDGWLbLPAxnJ+nPHg7OSuXUc77KU9gX7TJ31Degao+3OAM0VCDjKbk4
         uw24GmFABIu4vop7MiC1GfrnXgkiinDmtVL1mYjk4eaX1YTU6OafWrK6vO9FM7Z9riGv
         aWKYLamjQt2OGNBSfelJQd4qraeovCbzk3Eg2h07huzVk9+BQcq86KfiD2PtuC17B0BU
         JLSA==
X-Gm-Message-State: AOAM530pN+DCP6vIbop/BV+GRHkLtyTWLQsjK8HP6XhAnM4c2/PfqRbH
        2Ch9cdtgowX/bWtpF0yuuogTreq0XiL5IOpz
X-Google-Smtp-Source: ABdhPJzzyQZgjI1o7fJu0pVNr/rdDX6EAgryLSwsrYc6sJ/cj+3FM2loyGdr3iPXbeM7Uwwvz2/fzQ==
X-Received: by 2002:a17:902:968a:b029:d5:a3a0:3c43 with SMTP id n10-20020a170902968ab02900d5a3a03c43mr4384648plp.70.1603982651300;
        Thu, 29 Oct 2020 07:44:11 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id 194sm3149912pfz.182.2020.10.29.07.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 07:44:10 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Thu, 29 Oct 2020 22:43:32 +0800
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201029144332.bnaoeztlydmob5jt@Rk>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
 <20201029144007.77d967b0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201029144007.77d967b0@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

HI Jonathan,

On Thu, Oct 29, 2020 at 02:40:07PM +0000, Jonathan Cameron wrote:
>On Thu, 29 Oct 2020 15:48:56 +0800
>Coiby Xu <coiby.xu@gmail.com> wrote:
>
>> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>Hi Coiby,
>
>Please put a cover letter on your next series explaining the context.
>In this particular case some of the replies you have gotten are
>general at it is a lot easier to find these sorts of things via
>replying to the cover letter.
>

I will do it in v2. Thank you for the suggestion!

>Jonathan
>
>> ---
>>  drivers/iio/accel/da311.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
>> index 3b3df620ba27..55d4891556ca 100644
>> --- a/drivers/iio/accel/da311.c
>> +++ b/drivers/iio/accel/da311.c
>> @@ -263,7 +263,6 @@ static int da311_remove(struct i2c_client *client)
>>  	return da311_enable(client, false);
>>  }
>>
>> -#ifdef CONFIG_PM_SLEEP
>>  static int da311_suspend(struct device *dev)
>>  {
>>  	return da311_enable(to_i2c_client(dev), false);
>> @@ -273,7 +272,6 @@ static int da311_resume(struct device *dev)
>>  {
>>  	return da311_enable(to_i2c_client(dev), true);
>>  }
>> -#endif
>>
>>  static SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
>>
>

--
Best regards,
Coiby
