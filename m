Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414BE3BE7C7
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 14:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhGGM2I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 08:28:08 -0400
Received: from www381.your-server.de ([78.46.137.84]:58420 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhGGM2D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 08:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=AH8xRiI3OTK7dAXuLthAzUyvJdmfUjJFmeXHpO6Zz8o=; b=BTFc4fOPVJeLleXGwHWUkkoH6h
        trRQ6csC9OwB2bPtqTRcNz/b5UItIu1911D34Op1Pz3oe0TIiqHL70f+HwNB839QW8dMCdMM5aKdx
        n9cmmTdC3n03H8GlgWJ5O/0C0KOgupmdKVW3aVKv4jm0cIFagY9vw+OchjQ8O7TgV6ek8VhbCB4A+
        mvzOpWs75ppF8zBdqZZhIqdKcFD5k6cnZDf4kyfFo5WWHGuTzfHQ2jX5DSBdgdCWf+FvaPxy32qU5
        RXgmO0Kgy+hV4+T6n+VQ6IWFX8QTijnhY7xB4DGlXUR6CrSiRObKgrONUC2YN5ArgeRMBVJp2Nj2X
        CpbWandA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1m16bz-000F8V-AX; Wed, 07 Jul 2021 14:25:07 +0200
Received: from [2001:a61:2b10:2e01:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1m16bz-0009ua-5i; Wed, 07 Jul 2021 14:25:07 +0200
Subject: Re: [RESEND PATCH] iio: adis: set GPIO reset pin direction
To:     Hannu Hartikainen <hannu@hrtk.in>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        =?UTF-8?Q?Antti_Ker=c3=a4nen?= <detegr@rbx.email>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
 <PH0PR03MB63661EDEE130924514602A84991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <60e595b9.1c69fb81.5284.9247@mx.google.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f82dcd9f-c7f1-1619-9ff2-95066b82c77f@metafoo.de>
Date:   Wed, 7 Jul 2021 14:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e595b9.1c69fb81.5284.9247@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26224/Wed Jul  7 13:08:29 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/7/21 1:53 PM, Hannu Hartikainen wrote:
> [...]
> GPIOD_OUT_LOW and GPIOD_OUT_HIGH have different semantics.[1] Is setting
> the pin to use wrong semantics to save one line of code and possibly
> toggle the pin one time less worth it? (The ADIS devices whose
> datasheets I've read have the RST pin as active low, ie. GPIOD_OUT_LOW
> is semantically correct.)

GPIOD_OUT_LOW does not mean that the GPIO is active low. OUT_LOW just 
means that the GPIO is configured as output in the non-asserted 
state[1]. Whether it is active low or active high is configured through 
the flags associated with the GPIO descriptor. E.g. when using 
devicetree this is typically the field after the GPIO offset.

>
> If we really want that, I think the better choice is to use GPIO_ASIS,
> gpiod_direction_output and gpiod_set_raw_value_cansleep and skip
> semantically describing the pin altogether.
Requesting as output is the right solution.


[1] 
https://www.kernel.org/doc/html/latest/driver-api/gpio/consumer.html#obtaining-and-disposing-gpios


