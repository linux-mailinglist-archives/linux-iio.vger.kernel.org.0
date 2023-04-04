Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DC6D5FEE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjDDMLG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Apr 2023 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbjDDMJD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2023 08:09:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4934682
        for <linux-iio@vger.kernel.org>; Tue,  4 Apr 2023 05:04:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g17so42119113lfv.4
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2023 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680609880;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu5VDauqP8depTNSoX6oNFQsBkzOflNt/ALUKtkv7K4=;
        b=BMLZ7TK+zv/CVlzf9HuKfp2MLnMwRiqPhQ/bSViKYUmEWtyF7RI8z5iZzg5oXN7oVQ
         aBiSOOCQGQGyXws4Y23zC1JhOCNBQvjEnBNcz1ejA6Dewj/XUGa4+UH2DToVX4DFR2i2
         O6akgmoeWVArNwRYBBxqFezjmQi17pweMcgd+Dr6llxHJF3vRGwiWT56hR9l+whgtmMJ
         gKlhPanyeOnxpJmX39jW1WC3DEMMCzXhX23zEvu/cifEAIvDti/ZbEfp8oWK8jAEPE86
         gWC470ORE7RfNRBkto4JNx6UnPCqlJbvm8i5ug77Ie+DEkKGJAvEww1tbfQdpxN3DN07
         ld7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609880;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tu5VDauqP8depTNSoX6oNFQsBkzOflNt/ALUKtkv7K4=;
        b=nBr3yQKTc2DOBd2ighqRe1mEJOddYB+DM0Vn+IgvWghscI+yT8kxj3QH7VqjRvqngX
         A3VUnjCOhnCGh9Tn+tf0FfHIQVOMekNtO9Yl71XBa0/Zo83jWV3DrvpsJy7HtNp6UJt/
         gnhdCz37Lc8+COi+7QrFe4a7gw0+g5ALGZtBbL0tI1eVYfhzxJOPsl3eYTsjh5SL6z4s
         XxvikDkm3PXvJOEU3LkUulZ62haBzOIuQ9xHyQQWNhz/ryvnrzdr2ApH71E5ZXGcU4Je
         8XxnnY3NeJUMh8LjqXWVxJUV9+/0OSXLxxcTDeZZP8usOqseu2rwsF5suaEvDetI0Xjb
         u0yg==
X-Gm-Message-State: AAQBX9d2Ka5cYq5x2ebtQ6HHjA0RVP7Vubq7oFLY1MYOJicFVEBECQAh
        yaoLrooC6HiioHn6AqZn18E=
X-Google-Smtp-Source: AKy350Ygc85bBV5sJXRsG8iNiQdnRk+s1t2Z/MczWnBoSnRsMrLUFBP3EHrMpiH02oKyzGO/+/ma9Q==
X-Received: by 2002:a05:6512:218f:b0:4e7:fa8a:886e with SMTP id b15-20020a056512218f00b004e7fa8a886emr535789lft.51.1680609879730;
        Tue, 04 Apr 2023 05:04:39 -0700 (PDT)
Received: from [172.16.196.130] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y3-20020ac255a3000000b004dafde0e7b7sm2303762lfg.279.2023.04.04.05.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 05:04:39 -0700 (PDT)
Message-ID: <5942c0c2-3997-e10f-0872-30d201bc52ae@gmail.com>
Date:   Tue, 4 Apr 2023 15:04:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: ROHM BU27008 RGB sensor
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi deeee Ho peeps,

The ROHM BU27034 work seems to be slowly converging :) So, it is a good 
time to start working with the next sensor sitting on my table.

This time I am dealing with an RGB+c+IR sensor, which once again has 
some peculiarities. I would again be very grateful for any and all 
pointers so I could head to the right direction.

The IC has 4 data channels. First two being always RED and GREEN. Third 
can be configured to BLUE or CLEAR and fourth can be set to CLEAR or IR.

I think I have the basic driver done. I expose all of the RGBC and IR as 
own channels. Raw read is supported for all, and channels 3 and 4 are 
configured for the read depending on channel to be read being B, C or IR.

The device has a "data ready" IRQ, which is used for a trigger. 
Triggered buffer is supported and channel configuration is written at 
buffer enable, based on the active_scan_mask. The available_scan_masks 
field is populated to prevent enabling all of the B, C and IR at same 
time (because only 2 of them can be measured at same time as only 2 
channels can be configured for B, C and IR).


I have following questions:

1) I have no good knowledge as to what units the register values 
represent. I know the greater value informs greater color intensity - 
but that's about it. I currently just send out the raw register values 
via IIO_INTENSITY raw channel - but I don't know if this is usual or if 
typical user-space would expect the values to be some how 'normalized'? 
With the current setup user-space needs to either just compare the 
different channel values to each other to decide which colour dominates 
- or perform some manual calibration using known light sources. I have 
no idea if this is usual approach with RGB sensors? It seems to me that 
for example the adjd_s311.c just returns raw register values - but I 
don't know what the format is. Any insight on if the values should 
represent some 'units' or if they can really just be 'register values 
proportional to intensity of measured colour'.

2) The gain setting is once again ... eh ... complicated. The RGB and C 
channels are sharing gain setting. There are a few supported gain values 
- ranging from 1X to 1024X. The IR channel _shares_ again the high bits 
of GAIN setting with the RGBC channels. Two lowest bits can be set 
independently - but again, quite a few gain 'selector' field values are 
marked as forbidden.

To make it worse, the IR gain values matching the selector field are 
same as for RGBC - except the first selector. The sel 0 equals to gain 
1X on RGBC, but gain 2X for IR. (1X is not supported for IR). So, 
changing gain selector from 0 => 1 will cause gain to jump from 1X => 4X 
for RGBC but from 2X => 4X for IR channel.

I see two options:

1) Use fixed high bits which means supporting only 4X and 16X gains - 
for which changing the low selector bits is enough. In this case the 
RGBC would have own gain setting, IR would have own and there would be 
no shared bits.

2) Allow full range of supported gains to be set for RGBC - and disallow 
setting gain for IR. However, change the IR gain to have same selector 
as RGBC gain when RGBC gain is changed. (This prevents IR gain selector 
from changing to an unsupported value when RGBC gain is changed). This 
means that if user-space changes the gain for RGBC, it should also 
read-back the gain for IR to detect the change. I have no idea if 
existing user-space apps do this.

I think that no matter if we select option 1) or option 2) - we must 
have own scale entries for all channels. This is needed for option 2) 
because of the 1X vs 2X difference mentioned above.

I have currently implemented the option 2) because it supports wider 
variety of gains - but I am unsure if this is "the right thing to do".

Any insight is appreciated!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
