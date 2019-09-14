Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C309DB2BBA
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2019 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfINPBr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Sep 2019 11:01:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfINPBr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 11:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LshwHjHfnKRrYfaG1L0Rr+wy5xPBID8OqBoUb6Dif9Q=; b=CMxwCseeUEiWcJogmyKV1WI9I
        DsiZ8Uq6XyENo+CQenxCcU/+RWb3PHl5kbswv8qX6sO/85Tt6DxF+62qhPtv9yKrxqNJBMESLG+bP
        y9AiHnQM8vH1alZTLSxWgz8VIi95NA/cMG4z+jHJJ/t5d6GQpvVrIju8WsQRxjOOz+qheFSm41z9X
        3FiSKScgucTcHs9umjxRFDN3CoWjEN3DPpt+qVGv7hQGKOyIR2jdzikIqAZ1z+DRY7L36iQQInq+o
        Ejw70ZSyipKzL3NNcnKE8d0ELQvg8zoUAl0h1TFLI3aiKOhq1l2X/AE5yi+n+ozuspWRmYJcC4QED
        RnmcXOJ1g==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i99YX-0003Df-53; Sat, 14 Sep 2019 15:01:45 +0000
Subject: Re: Problems during compiling in kernel modules
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     Jay Aurabind <jay.aurabind@gmail.com>,
        linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20190913173821.GA5986@SARKAR> <20190913180103.GB5986@SARKAR>
 <CAOsEZoht6hWU1_pBp-GaRsNSDVj6D+vz0Z9MZRRVqR-HZgJoGg@mail.gmail.com>
 <alpine.DEB.2.21.1909140756470.5193@hadrien> <20190914142527.GA4158@SARKAR>
 <alpine.DEB.2.21.1909141632100.2490@hadrien>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <662f93f8-62f0-8ff2-4e04-1c4311f309c5@infradead.org>
Date:   Sat, 14 Sep 2019 08:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909141632100.2490@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/14/19 7:35 AM, Julia Lawall wrote:
> 
> 
> On Sat, 14 Sep 2019, Rohit Sarkar wrote:
> 
>> On Sat, Sep 14, 2019 at 07:57:48AM +0200, Julia Lawall wrote:
>>>
>>>
>>> On Sat, 14 Sep 2019, Jay Aurabind wrote:
>>>
>>>> Hi Rohit,
>>>>
>>>> The required config options need to the objects in that folder to be
>>>> build. Apparently there is no way to automatically set the required
>>>> configs. You can look at the Kconfig files inside drivers/iio/accel
>>>> and see what are the dependencies for building various drivers.
>>>
>>> It looks like some of the drivers are individual files.  So you can also
>>> just compile them one at a time make staging/drivers.iio/accel/foo.o.
>>>
>>> julia
>>>
>>
>> Hey julia,
>> I ran a `make clean` on that directory by mistake which I realised I
>> shouldn't have done. Hence no object files are there.
>>
>> Giving me this:
>>
>> `
>> make drivers/staging/iio/adis16240.o staging/git/remove-include
>>   CALL    scripts/checksyscalls.sh
>>   CALL    scripts/atomic/check-atomics.sh
>>   DESCEND  objtool
>> make[1]: *** No rule to make target 'drivers/staging/iio/adis16240.o'.  Stop.
>> Makefile:1772: recipe for target 'drivers/staging/iio/adis16240.o' failed
>> make: *** [drivers/staging/iio/adis16240.o] Error 2
>> `
> 
> OK
> 
>> I guess I will have to enable `CONFIG_IIO` and rebuild?
>> Although what I don't understand is if `CONFIG_IIO` was not enabled how
>> were there object files in the first place?
> 
> Perhaps the build system is just not very well designed here.
> 
> However, for me
> 
> make allyesconfig

That 'allyesconfig' enables CONFIG_IIO.

> make drivers/staging/iio/
> 
> works, and after that it is possible to do:
> 
> make drivers/staging/iio/accel/adis16203.o
> 
> I didn't do anything explicitly with CONFIG_IIO.
> 
> julia
> 


-- 
~Randy
