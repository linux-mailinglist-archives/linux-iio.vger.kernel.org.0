Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99F1E76B2
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 09:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgE2HcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 03:32:10 -0400
Received: from first.geanix.com ([116.203.34.67]:50504 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgE2HcI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 03:32:08 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id D3B522023E91;
        Fri, 29 May 2020 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1590737525; bh=NqOtCXKPYOLg3CUzk322t/tL+gdzHl0wbUUlAMXbpmQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lu2u0LxoF3zjweXh5k0674ZaPi+1HWXUtOUsY5GqA8+e5vTFHnlF8WCep24LU8fEP
         c18gXYeSGK2Pin4MP2DuQVxZTUnJ3tbQz+8Hzq6iJQJKgKfGukSxqFlA4B4ceSUDDz
         BL2WaRle2wHmnqxYs6GnvT1n+hngOhAimEfO0Yi+hELKYM4acDaJaIRBOeyZ8c4Rgv
         tOqc51zuW4ypxyFuo7XFi6rhl6gDAaFx6io3HkbEOidfMGBXHbkGds02KlR8ZnIUxl
         GOcoIEb8JkoYZbyvCPG7rkt133j3Je4UNKaW0hC0bkD+t9Fi/wa4m+TZndsCitz/bD
         dSHaiDdNw9THw==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
 <20200528210711.GD5419@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <3c629741-43f1-3d3a-2b40-40ddfd773e86@geanix.com>
Date:   Fri, 29 May 2020 09:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528210711.GD5419@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on fdf6823a942a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


>>
>> Could a solution, be to call st_lsm6dsx_reset_hw_ts() in st_lsm6dsx_resume()
>> ?
> 
> yes, I think so. Could you please try to patch below? Thanks.
> 

Hi Lorenzo,

I have tried your patch, and the timestamp seems to behave like before.

https://gist.github.com/sknsean/959d3421f66cb49144e7841a8a08a2be
Sorry NTP have been connected for a while :)

I will enable some more debug to trace what is happening.

/Sean
