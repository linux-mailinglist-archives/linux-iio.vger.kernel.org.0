Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543557D9926
	for <lists+linux-iio@lfdr.de>; Fri, 27 Oct 2023 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjJ0M7W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Oct 2023 08:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjJ0M7U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Oct 2023 08:59:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFDE1B3
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 05:59:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1caa371dcd8so17837945ad.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698411557; x=1699016357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnVvDYzrOiXXcLBIXZo998leFWypinKwSwwBh9B0Bhc=;
        b=YLuYvjPEiR+LNZoGyjZcHy5a7qZZTOCaR51sxH/HkChShJOcKfAgTBGPPlJTyYo063
         KTh1iDH0pPmb5nc8h4L+85XleWpIMz2JH38u2BLU1/QiEZadZbRocDnW0lI3gNdDouUD
         6ZKRTQe/CqSW/Id7ohrV/B3WphxTT3NPYnl3mWeK+K/H/EfyCgoYDPMUROisq2/FoRaz
         +YkrxRrgdg5xP3CwuAgxp2DpRGzP8toCBU9d5Vrl652wY3QIt/zgjlDdakpB1COOv6hf
         d39ms9DI7uWCe1TvZKg+Pxs9m7ZRZJJynjRjGsA3Wi9zLydQle5loZQ286vyKGHicVt6
         i1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698411557; x=1699016357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnVvDYzrOiXXcLBIXZo998leFWypinKwSwwBh9B0Bhc=;
        b=v/QnTC0FqLjUnctH7fYnL+w8m3xX3fAUeNOsBgWDT4e2/dqXGrKHbJLk2TJS3X25tG
         mkwoDv5ZdHv0/EDWLUwmY3EyjrU67FvGV38R+f1xbvRIqWj1Wb52AO0eAc+Iv+wc8O9y
         ZvxCgXYrvuNuPIHKg7V3L0lAQPAtEgpQZOUBwRsYczqhJiNHURFwN0KoXpB7o+bzDocD
         qfazZ6muZm9JLvisq6dkxe8asUx4+8l0uJCzS2uFhYJ0JSyCQMsGVUNww5TodFRR1HGy
         SClNhh/5NHruaJjLF9tUQtn8+dOa0QPgBEammZeVAkPuSxRGeefejuC7z0cmc5dx3zka
         Iezw==
X-Gm-Message-State: AOJu0YzQyfnOUukgauWRWgWwkQ9OIhRtkfn+ds07XQH7gA4YFQMEUpkF
        u2jwYEYvcUEpNWsPCIRQQiAxYFwIo6d6YiN3mvo=
X-Google-Smtp-Source: AGHT+IE/y41xbQGeI5wjC1sLH+pq9yHPsk4f4rnVQlyHxT5L0fSSnli72s6diRvbt22YhudFLgevQw==
X-Received: by 2002:a17:903:2306:b0:1c6:2f59:8c4d with SMTP id d6-20020a170903230600b001c62f598c4dmr2929514plh.28.1698411557571;
        Fri, 27 Oct 2023 05:59:17 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:c232:f53e:32d4:5510? (2403-580d-82f4-0-c232-f53e-32d4-5510.ip6.aussiebb.net. [2403:580d:82f4:0:c232:f53e:32d4:5510])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709027e8d00b001b9da42cd7dsm1515657pla.279.2023.10.27.05.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 05:59:17 -0700 (PDT)
Message-ID: <7524a9ef-c1c4-462e-8f9d-fc03c29ca092@tweaklogic.com>
Date:   Fri, 27 Oct 2023 23:29:08 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: light: Add support for APDS9306 Light Sensor
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026143532.39660-1-subhajit.ghosh@tweaklogic.com>
 <20231026143532.39660-3-subhajit.ghosh@tweaklogic.com>
 <ZTuuUl0PBklbVjb9@smile.fi.intel.com>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <ZTuuUl0PBklbVjb9@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27/10/23 23:04, Andy Shevchenko wrote:
> This will benefit from guard() or scoped_guard().
> And many other functions in your driver.
> I believe ~15% of LoCs can be dropped with help of cleanup.h.
Acknowledging all other comments. Jonathan commented earlier on using guard() and cleanup.h
Unfortunately I missed it. Like GTS, it will again be a brand new thing to understand!
Thank you for reviewing.

Regards,
Subhajit Ghosh

