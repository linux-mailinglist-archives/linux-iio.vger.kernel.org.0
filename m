Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49D23A7EC9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jun 2021 15:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFONOw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Jun 2021 09:14:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:49916 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFONOw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Jun 2021 09:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=GLjgBlrMwUErlGDu+NQ+HL+RZFrEPBxS5nfsMMG91qA=; b=bGD2exljDFh+iFEjqRP4rCq8Gq
        S2RGg1nfkqKtvdm0C657SrQ96DKGmqgXr/owMcT7+UZMifoAYWTbnnP3Ui9YwA9COeBZPE7N6p8ZR
        h66n5tNsh5g+h3bp+EvgixAiy8suGXSXTrE0jvmHAjCdhaFDL12k936mDky3jtogsBXJoDhwASb9T
        WN47DmHCDikyp80nr6ylHpzmcTyFmUlGa76OTaQ81m873PmcGrwBdKv/IVe00RUMO7ZfmCeKJWKov
        /OqXPeFgbsP1axciTS3ibCFle63VWYoF9swJPMk70fUNXsBcXI9Hdnv79771QdbrUiAk3e6yIl5Np
        skZrlyeg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lt8s0-000CS4-W6; Tue, 15 Jun 2021 15:12:45 +0200
Received: from [2001:a61:2bdf:6601:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lt8s0-000Jd9-Is; Tue, 15 Jun 2021 15:12:44 +0200
Subject: Re: [PATCH 00/12] iio:accel: Header Cleanups.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Harinath Nampally <harinath922@gmail.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Tomas Melin <tomas.melin@vaisala.com>
References: <20210611171355.202903-1-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3522a59e-2ce3-75e5-be83-c0f5487b6208@metafoo.de>
Date:   Tue, 15 Jun 2021 15:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26202/Tue Jun 15 13:21:24 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/11/21 7:13 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> 0-day recently started running the include-what-you-use checker with LLVM builds.
> After it identified a header we should have dropped in a particular patch,
> I decided to experiment with it a little and see if it was useful for tidying
> up includes that have gotten rather out of sync with the code over the years.
Oh, that's nice! I've always been looking for something like that.
