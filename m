Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B21715843
	for <lists+linux-iio@lfdr.de>; Tue, 30 May 2023 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjE3IVH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 May 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjE3IVG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 May 2023 04:21:06 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79365CD
        for <linux-iio@vger.kernel.org>; Tue, 30 May 2023 01:21:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af1822b710so43301311fa.1
        for <linux-iio@vger.kernel.org>; Tue, 30 May 2023 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685434860; x=1688026860;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sq5UJ5VD5FFrHC0YZ5uFF/dLpiCEM6LfUOX8UlmrkfA=;
        b=lOnbxdBn0FwBs+q+Y6bDlil09i09BNdj9eZuTIpqZAm8cdZukohsmeMp4jEyS+kEIR
         DIFidgmmvnxp5Pc83XIwdfcgHJKwA0/CBNrikbfgeh3LBeyj8xEqVvI8yZFnnTX0Pnm6
         GXQbdHPat9p2QcdTHq6FXb8rXn1f7pH7KniKKpt28XvO2VZTt9zrTqduRaqAI45Mp6bn
         tdA7DdTacE9Y3sk5KmnQ/QO0a/yzglsi/SiXt7WTsPZBob9e5yz26/1PWH8zHz3jndb4
         e0WWJa2Kn+YHxRlaW2HNbGa60W3F2OIJt7W2JgVvnBGp5/xVAFGYs1MaL9VWeoWU9zi2
         EZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434860; x=1688026860;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sq5UJ5VD5FFrHC0YZ5uFF/dLpiCEM6LfUOX8UlmrkfA=;
        b=VG9R41D7Rd7Hr7a58URf3BYwc0Y4ZVBcOmfqFwwwmZd/kGnvrtPRBiBiNSKqg6i9uA
         fPMkG6ghoem/f21QvEMJODV8buK4dIzbKa2Dep5mv3gvh3VmiPmrmf/0YdhosbDNmM6O
         X4d1wRLLroBlNY85HasGqIhyHwVd80tjOnmt1+myR9MRzRUTjUrpGDSdZczXp3SEmNwp
         4GGNIkJl3YCaDL+aTFrCHOXDNujIK+YD9gCCQ0Z870i/tG6ZRZk77FY6or7K+qwOKvco
         ZAO7LQpDHjO/H4ZEkJFW0ZK5v7GXRS8XTRSqIz916rxizE0CfTdXkAk6GPSqaN2cbAU7
         IYgg==
X-Gm-Message-State: AC+VfDz6piO3gM3/kSulTzFso55X56GBFTJxXMwsCBfP3fnW3ZjWmlph
        amq0gRWDz4TyesXTn/0gC9UdABI5Xvk=
X-Google-Smtp-Source: ACHHUZ63+w4IrcNIGTPt1NJX1GK55Dxep22XH3zqEYcoHkA5ABrONHwrlZyMU6Hjw9ClhQYzT3mxYQ==
X-Received: by 2002:a2e:2c06:0:b0:2af:18c3:8bd5 with SMTP id s6-20020a2e2c06000000b002af18c38bd5mr434441ljs.14.1685434860239;
        Tue, 30 May 2023 01:21:00 -0700 (PDT)
Received: from [172.16.196.201] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y24-20020a05651c021800b002aa458a7a46sm2779820ljn.123.2023.05.30.01.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:20:59 -0700 (PDT)
Message-ID: <2e722c05-9548-f8da-2d72-1ba76a1e2508@gmail.com>
Date:   Tue, 30 May 2023 11:20:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: ROHM BM1390 support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi dee Ho peeps,

Once again I am trying to learn from more experienced sensor folks :)

I am currently working (also) on ROHM BM1390 pressure sensor. The sensor 
can measure pressure ranging 300 - 1300 hPa. Measurement times can be 
around 20 - 160 mS depending on the amount of samples being averaged. 
There is also an IIR filter included in sensor with 3 different settings 
titled as "weak", "middle" and "strong". Unfortunately the exact maths 
is not explained. Furthermore, the sensor can be configured to store 
maximum of 4 measured pressure samples in a HW FIFO.

The sensor can also measure temperature and error for temperature 
measurement is told to be +/- 2C when temperature is in a range of 25 C 
- 85 C. On the other hand, operating temperature for the device is said 
to be -40 C - 85 C.

Now, the temperature measurements are not stored in a FIFO.

Here comes my question - what do you see as the typical use-cases for 
such a sensor? Or, to be more exact, do you think "quick" changes in 
temperature are expected to be measured with this type of sensor? I am 
asking this because I would like to support using the hardware FIFO and 
I am wondering if reading the temperature at FIFO flush and populating 
also the temperature channel values corresponding to all (up to 4) 
pressure measurements would be the best approach?

Other options is to not support using FIFO when temperature is scanned.

I have a gut feeling that the users who measure pressure are often also 
interested in getting the temperatures. Hence I would like to allow 
getting both. "Cheating" by using the same temperature value (measured 
when FIFO is flushed) should be Ok if temperature is not changing 
rapidly as even with the slowest measurement speed collecting 4 samples 
should finish in well under a second - and mentioned accuracy for the 
temperature sensor is such that small temperature changes are probably 
going unnoticed anyways.

Here I would love to have an opinion from more experienced IIO 
developers/users - and potentially a hint how similar sensors have been 
handled previously. (I would assume not storing some slowly changing 
values in a HW FIFO is quite common because HW FIFOs won't come without 
a cost).

Yours,
  -- Matti

Oh, in case someone wants to see the data sheet:
https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/pressure/bm1390glv-z-e.pdf


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
