Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0713E8B9B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhHKIPu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 04:15:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:54956 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbhHKIPt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 04:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=dUpACG8aiUQKUG+rkp01YuOY1SDfByf1trncBtx1z7c=; b=ds9Nrz6zHCpeudTBYLZWmxaPs6
        XBTPus2B+JHGUjVVUrYMQGJb5tLCuIRZR7YqtCkAlJNzWNAYVQBDHqpswMrJEz+cq6lWpNXVCO5lH
        uGTohanqNiQRvqT5dKXLxFxPxJL4ZBtlUVidO4E4bepmSnZ6cCL/hCA/seUeYvvzG2y5OTu4/YHYJ
        dQVgi8TZ+k/W1KWL1gUP14kTQbR7K6ICcn/M6hV7f1IxALf6SpI8hK48ICQ9SwctLREwoACbBoIab
        alq3P6WVHT/Zkf737PKgKOHv13S3v9ACiQKdVviYh1Y8sq9vvPiVif04d4Lqu6rTFfQrhMVMZsCCe
        QE6e4lpw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mDjOH-00017W-Sp; Wed, 11 Aug 2021 10:15:09 +0200
Received: from [62.216.202.4] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mDjOH-0006Xj-HU; Wed, 11 Aug 2021 10:15:09 +0200
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver support for AD5110
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20210809075745.160042-1-dmugil2000@gmail.com>
 <20210809075745.160042-3-dmugil2000@gmail.com>
 <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <013bcb79-c496-44d8-2e93-57eb57834ee0@metafoo.de>
Date:   Wed, 11 Aug 2021 10:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve=D1d5wFZgNseP=wGpteEkZHnmAi7j9ykKC+u_NrR5xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26259/Tue Aug 10 10:19:56 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/10/21 2:49 PM, Andy Shevchenko wrote:
>
>> +       data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 10 / 8;
>> +       if (!(val & BIT(7)))
>> +               data->tol *= -1;
> Shouldn't you simple use corresponding sign_extend*()?
The data is encoded a sign-magnitude. sign_extend() works for two's 
complement numbers.


