Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280A03400B5
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 09:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCRIQL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 04:16:11 -0400
Received: from mail.ispras.ru ([83.149.199.84]:52348 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhCRIPn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Mar 2021 04:15:43 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 04:15:43 EDT
Received: from [192.168.1.48] (unknown [185.13.112.205])
        by mail.ispras.ru (Postfix) with ESMTPSA id 02BA940D4004;
        Thu, 18 Mar 2021 08:07:11 +0000 (UTC)
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, ldv-project@linuxtesting.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Pavel Andrianov <andrianov@ispras.ru>
Subject: A potential data race in drivers/iio/adc/berlin2-adc.ko
Message-ID: <e11a245e-95ed-eff0-05a8-264f7598672f@ispras.ru>
Date:   Thu, 18 Mar 2021 11:07:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

berlin2_adc_probe [1] registers two interrupt handlers: berlin2_adc_irq [2]
and berlin2_adc_tsen_irq [3]. The interrupt handlers operate with the 
same data, for example, modify
priv->data with different masks:

priv->data &= BERLIN2_SM_ADC_MASK;
and
priv->data &= BERLIN2_SM_TSEN_MASK;

If the two interrupt handlers are executed simultaneously, a potential 
data race takes place. So, the question is if the situation is possible. 
For example, in the case of the handlers are executed on different CPU 
cores.

Best regards,
Pavel

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L283 

[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L239 

[3] 
https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L259

