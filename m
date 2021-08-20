Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946BD3F2471
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 03:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhHTBxO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Aug 2021 21:53:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14247 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhHTBxN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Aug 2021 21:53:13 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GrPlD4dxLz1CYPF;
        Fri, 20 Aug 2021 09:52:08 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 09:52:34 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 09:52:34 +0800
Subject: Re: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in
 rzg2l_adc_pm_runtime_resume()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <jic23@kernel.org>
References: <20210819132416.175644-1-yangyingliang@huawei.com>
 <CAHp75Vd22aP098s9iXCGmBG505dW1vmZgvy3h9NoNA=J-eQ-CQ@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <9b848f1c-9acd-243e-2c5b-d489d2427464@huawei.com>
Date:   Fri, 20 Aug 2021 09:52:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd22aP098s9iXCGmBG505dW1vmZgvy3h9NoNA=J-eQ-CQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2021/8/20 1:20, Andy Shevchenko wrote:
> On Thu, Aug 19, 2021 at 4:19 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>> Add clk_disable_unprepare() on error path in rzg2l_adc_pm_runtime_resume().
> ...
>
>>          ret = clk_prepare_enable(adc->adclk);
>> -       if (ret)
>> +       if (ret) {
>> +               clk_disable_unprepare(adc->pclk);
>>                  return ret;
>> +       }
> Huh?!
The pclk need be disabled, when enable adclk failed.
       ^                                                         ^^
>
