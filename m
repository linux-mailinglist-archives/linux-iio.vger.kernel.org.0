Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2CB7C6E46
	for <lists+linux-iio@lfdr.de>; Thu, 12 Oct 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbjJLMhQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Oct 2023 08:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbjJLMhP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2023 08:37:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8477C0
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 05:37:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692c02adeefso648895b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697114232; x=1697719032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aexicFbdDCYmTu1M5aMUX7ZGZvAOrhK/tLq4zb9YLzo=;
        b=N3uwbLD1ARjGEZgsohlFCwZUAOl0s3iscATZNW9kMTSuZ6YxEBQt7wcLp+7Avy+Idb
         LD5T5Sl90HwoFomF59Z45LvD7GThU66liaFmbIexlV1rsqvVdalSuTf5+G4nXiqEixhK
         87DEAzpSCVxUtur0s5Ni4chUFe+zO8V4dgOpe6kLxRmbymx3A+jnB1U5Qo7kK7EiM/z2
         VGzMt2EveHrL61KH4lOt1E1MYFUm0V6qzYCbQDj7Ot2Xxxr4GPL/kNI7BTsg3m5qlSpD
         zg9TfVsCUhmrrz9Ynuope51FHqdDRPiyGTcfoUQlH2yDyOxLm2C7Pkkt/YxngsMD32fA
         pHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697114232; x=1697719032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aexicFbdDCYmTu1M5aMUX7ZGZvAOrhK/tLq4zb9YLzo=;
        b=MaMW9X7/1g676B6jhJftpyrE7sKLYqZvqsvM/xVLWJxsc3+g2UyPbSkC0cDz0Zmsi/
         ppyL1UCjU+qZIKv0gj7FsU04By6G01pB+u0frzYXb6MDOhaLh1OPrv3ajNo8pMmfcY1x
         I91kjqVEGcILMj+VXPgIfkyKkLxJKlJjTm/+5qy1QapbVwvZgbdfivNEfhEx1A6NmjpB
         l9nmBCO6LmOdk//m/RUW3myNv1dC/kvukFo50HQnVb1vjF2QRZ/RAZXY8+d1i2AxGcbF
         JOlhrZTIeFx6MHnuWICc/ic3j9qUjS4kao0LHjDaC/IohSjbyjlsYgPFcBANClIaAFXb
         rNDg==
X-Gm-Message-State: AOJu0YybB2Kmeh6qB6se5LvRQCScOfNHrbQhw2YIKyjKUzn5TfM2mBOU
        aBym/IQ31X5DiZFXaBxthWL8aA==
X-Google-Smtp-Source: AGHT+IGs9Wj89Up6oViepT7y+Xzyy4PMXcU5oQRUce1BNiVIsTWkztmcWJOStZh6TJCchYgkT5YR7Q==
X-Received: by 2002:a05:6a00:190e:b0:693:3dcd:ecad with SMTP id y14-20020a056a00190e00b006933dcdecadmr25191994pfi.21.1697114232237;
        Thu, 12 Oct 2023 05:37:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:67c0:38ec:cbef:5570? (2403-580d-82f4-0-67c0-38ec-cbef-5570.ip6.aussiebb.net. [2403:580d:82f4:0:67c0:38ec:cbef:5570])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b00692cb1224casm11792782pfo.183.2023.10.12.05.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 05:37:11 -0700 (PDT)
Message-ID: <0590a1f5-5be0-2edd-d586-cecc01c67c9e@tweaklogic.com>
Date:   Thu, 12 Oct 2023 23:07:04 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-3-subhajit.ghosh@tweaklogic.com>
 <20231010153807.6335a043@jic23-huawei>
 <07761a6c-85a8-c7bd-a0af-28d0f29b3e5d@tweaklogic.com>
 <20231012085427.5f0fa4a3@jic23-huawei>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231012085427.5f0fa4a3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>> Thank you Jonathan for the review. I'll get the changes done in the next version.
>>
> No problem.   As a side note, feel free to just crop out any responses where
> you agree with a review.  Default assumption is that if you don't comment that
> is the case and it cuts down on scrolling when reviewer next looks.
> They are also much more likely to take a look at a short reply than a long one!
> 
> Jonathan
>
Understood. Thank you Jonathan.

Regards,
Subhajit Ghosh

