Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B292D403C41
	for <lists+linux-iio@lfdr.de>; Wed,  8 Sep 2021 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhIHPFL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Sep 2021 11:05:11 -0400
Received: from mail.kernelconcepts.de ([188.40.83.200]:40632 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhIHPFK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Sep 2021 11:05:10 -0400
Received: from [217.146.132.69] (helo=[192.168.2.34])
        by mail.kernelconcepts.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <florian.boor@kernelconcepts.de>)
        id 1mNz7B-0000k6-7v; Wed, 08 Sep 2021 17:03:53 +0200
Subject: Re: [PATCH] iio: adc: ad799x: Implement selecting external reference
 voltage input on AD7991, AD7995 and AD7999.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com
References: <20210830145934.11024-1-florian.boor@kernelconcepts.de>
 <20210905122653.0e081ab2@jic23-huawei>
From:   Florian Boor <florian.boor@kernelconcepts.de>
Message-ID: <8734fb80-011d-cb07-8cfb-6a1c06417034@kernelconcepts.de>
Date:   Wed, 8 Sep 2021 17:03:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210905122653.0e081ab2@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 05.09.21 13:26, Jonathan Cameron wrote:
> On Mon, 30 Aug 2021 16:59:34 +0200
> Normal convention on this (not helped here by the complete lack of
> a binding document for this device) would be that the driver would
> use the external vref is vref-supply is present.
> 
> Currently the driver uses devm_regulator_get().  In this case it
> should be using devm_regulator_get_optional() as that will avoid a
> 'fake' regulator being provided.  

okay right - in this case we could get rid of the additional setting and only if
there is no vref-supply provided we need to get a dummy.

> The driver will need a few changes to handle the possible error return
> from that call, but it shouldn't be too complicated.

I'll send an updated patch...

> If you are willing it would be great to have a binding description for
> this driver. I'm no sure how it has slipped through the net for so long!

I'll add this as well.

Greetings

Florian

-- 
The dream of yesterday                  Florian Boor
is the hope of today                    Tel: +49(0) 271-338857-15
and the reality of tomorrow.		Fax: +49(0) 271-338857-29
[Robert Hutchings Goddard, 1904]        florian.boor@kernelconcepts.de
                                        http://www.kernelconcepts.de/en

kernel concepts GmbH
Hauptstraße 16
57074 Siegen
Deutschland
Geschäftsführer: Ole Reinhardt
HR Siegen, HR B 9613
