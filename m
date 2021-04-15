Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3642D361173
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhDORx3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 13:53:29 -0400
Received: from first.geanix.com ([116.203.34.67]:35476 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233052AbhDORx3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Apr 2021 13:53:29 -0400
Received: from [192.168.16.66] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id E86244633E2;
        Thu, 15 Apr 2021 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1618509184; bh=d/GFrnKnmc5rFzC7uCDXeDSBdAQl0DzSoGqfq7W0Pwc=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=k78rt5KuFq4qC1qo227g4ecs6eIXxRlwhYh0LsYDrkxcq2qv8g3JAR27bb6yA5jL0
         x8sUrfW65we8+HMehQFhTfqiRkYNze3jmo0to7IRK9z/ypUZQ/EB+9aBlpEl8aIGjM
         9Es4f2/2eZeVSC1K0zW9dEaFCXTy9E6fAyo6yA9PD3IQJuEcMZKPj0GoOGnVWcSE9u
         dmXuWdOX/InHo/huU3w9N169kfhVeOK3gNsACfCOow1c+QzD6X/3OHpjsEC7zB+uqa
         X3k+GDAtsadq184ROzQnkj+/7d+fLWc3r9LkpCt1R2Tg5ZONH6HgM2bde8JjS5VjGE
         NreumYWiz/3qg==
Subject: Re: [RFC PATCH 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
To:     Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20210415114614.1071928-1-sean@geanix.com>
 <11adb882-1af8-ab08-fcd9-47bedad02699@metafoo.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <31ecc4b0-d09b-a0c4-531a-3c0c28bac46f@geanix.com>
Date:   Thu, 15 Apr 2021 19:53:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <11adb882-1af8-ab08-fcd9-47bedad02699@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 15/04/2021 14.50, Lars-Peter Clausen wrote:
> On 4/15/21 1:46 PM, Sean Nyekjaer wrote:
>> Add basic support for NXP FXLS8962AF/FXLS8964AF Automotive
>> accelerometers.
>> It will allow setting up scale/gain and reading x,y,z
>> axis.
>
> Hi,
>
> Thanks for the patch. This looks very good! 
Thanks for the review :)
I have addressed the comments in my local tree.
It took quite some time to implement the read_avail callback, it's not 
that compatible with what I have done :/

/Sean
