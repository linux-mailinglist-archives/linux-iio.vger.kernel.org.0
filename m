Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE41612631
	for <lists+linux-iio@lfdr.de>; Sun, 30 Oct 2022 00:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJ2WLj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 18:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ2WLi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 18:11:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A0326FB;
        Sat, 29 Oct 2022 15:11:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w14so10963724wru.8;
        Sat, 29 Oct 2022 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaTDChAqyQ5d+rIEIwuSrEAu/j0Qo2EjdE2A/RvRzFQ=;
        b=P/CUt1L/Jhqo8FlcxNm6qrEF2lvBq4LN2ZASMmBDw7kmh1iEwAkvsjgg1k5jH3SjVT
         Ou7J5phrT8KqfmW3a5FCYP9m0N1/7KIP9r5UGvv4ZuKcBFJ2J0GsrHkgyDWP5ATn6wqy
         w+1dIs/KEsGTii42zJ6Ral7SvSXpC3Gw1tLqaAK6AeicAXi0bzTdT8rf5vvsbVxQdN9G
         3jHxvfP8RUoC3gVtiiEGnDQmIip/9sAgD3027SUonND4pGTBZhEGygx/KTVmC18x385L
         PI5IjeGTGtT0RFfznYBstM8YYVfTJBTCBTrUzA8BygXyNpFTC9QUbYNiSN0gwmrkIhCU
         zBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaTDChAqyQ5d+rIEIwuSrEAu/j0Qo2EjdE2A/RvRzFQ=;
        b=yCC0Fq/hwSH9gQvEck1sZKtdXtZoLf09LtCiYqow4R4iZ4HTYNPJuTMrmbbvqARdRc
         7siWsUaAxD1BSU4E5YaHEOzKUU4v9DREu/SCjvmLsVtE0+Nj8lKXRxmqCYewz6NHHkEl
         F6bliC3yScACNXcjgJlQXYmp22NoQ862xTfiKk6eLyaMKxFliHvEh0Mkea8N9yImRBHw
         257ymKcL8ZEEhDFV2QEgwS4WU1L3RWVNtccmmizYc1qSyc94MZeaqZBU+eicK7IoobEa
         OtsWiTk+jnN8vCAFAvWxlwno1SAcSDfg1a9a0G3OSFQ87Xt0aONTuZjurDIvqtok/00R
         utiw==
X-Gm-Message-State: ACrzQf3iJ6PRGPYs1JAItC4NPnfO1Ssodx79y0nR21E/M0saiD9DDS/b
        /o5skXmaL9NVqeUQXfLRdhM=
X-Google-Smtp-Source: AMsMyM4qke3JhvghGxoR1zC3Go924ym1Ryt2YeeGGrKZkhh73yQkseU/RKDQnozqZKK3A3P0l9QEDg==
X-Received: by 2002:a5d:4441:0:b0:236:6c3e:efb4 with SMTP id x1-20020a5d4441000000b002366c3eefb4mr3262426wrr.539.1667081494976;
        Sat, 29 Oct 2022 15:11:34 -0700 (PDT)
Received: from [192.168.0.104] (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id ay19-20020a5d6f13000000b00236b2804d79sm2508455wrb.2.2022.10.29.15.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 15:11:34 -0700 (PDT)
Message-ID: <20115819-1006-8ccb-38b5-6cba8530dbba@gmail.com>
Date:   Sun, 30 Oct 2022 00:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 0/8] Add support for mp2733 battery charger
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20221029093000.45451-1-sravanhome@gmail.com>
 <20221029220250.pybesx2w4hslkrcp@mercury.elektranox.org>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <20221029220250.pybesx2w4hslkrcp@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/10/22 00:02, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Oct 29, 2022 at 11:29:52AM +0200, Saravanan Sekar wrote:
>> add support for mp2733 Battery charger control driver for
>> Monolithic Power System's MP2733 chipset.
> 
> I suppose you do not actually want to get this merged concidering
> you did not carry over the Acked-by you got in v4? :)
> 
> -- Sebastian

Sorry, my mistake I added your ack to v5-0005 instead of v5-0007

Thanks,
Saravanan
