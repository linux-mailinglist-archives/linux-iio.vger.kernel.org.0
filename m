Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353FC46C110
	for <lists+linux-iio@lfdr.de>; Tue,  7 Dec 2021 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhLGQ5i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 11:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhLGQ5i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Dec 2021 11:57:38 -0500
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E30C061574
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 08:54:07 -0800 (PST)
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 715D7601A1
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 16:54:05 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1638896044;
        bh=Nd6ihHiZ3IEUFgl9VhxaRo+e5RVoMApGXjxokQQLZFQ=;
        h=Subject:References:To:From:Date:In-Reply-To:From;
        b=bvhqXaU/E0+zl346tcYUJ/qCa+Wm1VgR4sQZdicNpFpnv0bFV547D19nlUgSlULU+
         JJ83jaxXq0Wgt/CUz9nDocZOTAr0QOdsf1iMJcoAMDzGb9ieUDtiiZ95f+KBtXdTV8
         q4VJYf6tCESAxKYwj9+hEQ1v+FxvaqRbjOBLsTQXbNSuba5xMG1fDAHgpSNqCdOAYQ
         tUVABrFwzJvtjXX9VMQGwj5YTMUWaRsc/N1GgQYmzQHL49NlSdnCMQ2NaypRNthpju
         jY31CuYaY55JsBuDAIlZiFl56b8ARJJFLzk/nFjIaBrxVf/Z/cOe2WLszFgUV+l8o4
         U+kMLF+lm2Cjg==
Subject: Re: iio display large numbers
References: <16f1078c-bbff-40ae-08b3-b1384aeb5313@deathstar2.nl>
To:     linux-iio <linux-iio@vger.kernel.org>
From:   Henk <yoda@deathstar2.nl>
Organization: DeathStar2
X-Forwarded-Message-Id: <16f1078c-bbff-40ae-08b3-b1384aeb5313@deathstar2.nl>
Message-ID: <47c9271c-7c6b-861a-3dc3-607be95893c9@deathstar2.nl>
Date:   Tue, 7 Dec 2021 17:54:01 +0100
MIME-Version: 1.0
In-Reply-To: <16f1078c-bbff-40ae-08b3-b1384aeb5313@deathstar2.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,


> Two options for this. If the thing we are controlling is the raw 
> channel then
> we have the option to provide _scale reflecting the fact that a large 
> value
> e.g. GHz is not normally controlled at a Hz granularity.

I agree although a lot of existing drivers already use this granularity.
It is commonly used in Analog Devices IIO drivers, especially the 
frequency generating products.

> Where that doesn't apply or the range is really very big we do have the
> slightly nasty option of IIO_VAL_INT_64
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=6bb835f3d00467c9a5e35f4955afa29df96a404e
>
> This is very new, so not in mainline yet, though it is queued up for the
> next merge window and should be linux-next.
Great!
I will probably patch my adi kernel sources to use this approach for the 
time being
>
> Hope that helps,
>
> Jonathan

Tnx,

Henk


