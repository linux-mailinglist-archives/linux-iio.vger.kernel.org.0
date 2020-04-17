Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC351ADBB1
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 12:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgDQK46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 06:56:58 -0400
Received: from www381.your-server.de ([78.46.137.84]:55522 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgDQK46 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 06:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j+cEgbwCSj5I0F+f9tOfnSu7VZ50eB1wG2coGkbb6Zc=; b=VCPgZQK+tCpseUS8lA5ORgNM8B
        vEz9p4GsBsvFB9QW51fnBm43zIJsX4ImBZBvKPUZapov2sd9mIJjiVTFl3uOTSGjzeeTAwec3ckEw
        bdAeUeLgRffNatGv1NGelKMylqPQqMpvEREuXXZM8wHub0c1kDQc+GfIAIJHTwj6EzPAKMNA/TsNW
        BNn3EWJh7Np/5RaY7sYJ+1AfSTcMGrXOcmJbNfBPyoZ677lVJHehEfhplJuU1RZrivJny31csYEm4
        cBgyNdPrfFDq6hQVIVSZdxcHnfGIz/EqgbKpFOBZNh5K96ArKEbabWBnlpS5KpqNP1827iUK5P55k
        GE6QgsGQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jPOfx-0007Qi-Ke; Fri, 17 Apr 2020 12:56:49 +0200
Received: from [82.135.79.46] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jPOfx-000Eah-4j; Fri, 17 Apr 2020 12:56:49 +0200
Subject: Re: [PATCH v4 2/3] iio: DAC extension for ltc2634-12/10/8
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Steve Winslow <swinslow@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200416012016.21422-1-chris.ruehl@gtsys.com.hk>
 <20200416012016.21422-3-chris.ruehl@gtsys.com.hk>
 <20200416065655.cxy67hlj267dpjrw@pengutronix.de>
 <e4a6af21-a8ec-e9b5-2c5e-1e109888f0c7@gtsys.com.hk>
 <CAHp75VfN4Fj0J4n2xKmK8fDKACT0epo_xXQnMzKDW-Y1XH46Pw@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <cdea4538-ef75-f000-8b9c-db10a9bdd173@metafoo.de>
Date:   Fri, 17 Apr 2020 12:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfN4Fj0J4n2xKmK8fDKACT0epo_xXQnMzKDW-Y1XH46Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25784/Thu Apr 16 13:58:59 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/17/20 12:27 PM, Andy Shevchenko wrote:
> On Thu, Apr 16, 2020 at 10:15 AM Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>> On 16/4/2020 2:56 pm, Uwe Kleine-König wrote:
>>> dropped stefan.popa@analog.com from recipents as the address bounces for
>>> me.
>> the maintainer script added this email automatically , I will remove it
>> in the future mails.
> Somebody from Analog Devs should sent a patch as an urgent fix.
> I also suffered from very same bounces.
https://lkml.org/lkml/2020/3/21/63


