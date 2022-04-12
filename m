Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD504FE0B4
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 14:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353183AbiDLMoN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353418AbiDLMmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 08:42:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925AD65422
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 05:06:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c7so27493491wrd.0
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VUNIvOH0UxcSQdlvvYQi1jxk7kTq1IM51QbQ2H6sRzI=;
        b=IhYoozhHAHVEiVJuwXkBA1N5aYWQEZegdZwF4s8Ugu5EO63qhaSk8OAisR2pgVtQHA
         ONmzdH3dNmB5c6SEXow8CBNX7o7g3CAbSIHqdIZAZjUvv9j4I901F571kFt+nlIsKj++
         NclXm2jGlqIHR1/w0M8Bj5lD41SD+dg8MD/xecy3EtSHIEsedhiuLc9OSgvByDAN7k/H
         B6p+bI5VRqYaWHa9CnY5BK1yyy8Ra3glX2aa0HaJ4dQkRA8KCUJtap8/KaNtTcDnQ9C/
         vMBFZTZXFj+r0mW1owyHZpKKp3UY3ee8rFYECN5wCgk+iL7CE0bPk/UaP/hHV7KCcIuy
         VDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VUNIvOH0UxcSQdlvvYQi1jxk7kTq1IM51QbQ2H6sRzI=;
        b=bnAtX9tgtzOqoZaCrbZgDjUtWDZPK9BzKpJR/61nt7ehjN9wkxN7vPqVaVMHf33LDE
         +wG7VB4X1bjSPTnVlCmQO1XQitMrFHySRyY8xCJMPMHo5j8iL2wBZJJwSXYhJqo9Jobp
         7GQYlJS9REC/iFuG/zZLkmOUIQMNMDyfp53tS7VDBmHC9oOyC2JxKRI7i/Kt4wDtMf6u
         Eg5+6v7D0u5J8pZQ84JAELw3K3nCEt2KCdslxmZ7A2Ul+4O9mtey9XBy0jI3XO264LRA
         okpY6zNXAYeLBKMgseRyJsu4jwFkm8gG6RBirbAoQ2Rr4WPbxO7Fss/JnhgZzunBfM7j
         PMwg==
X-Gm-Message-State: AOAM533osyAeL17XjVbjk9O6J7fR/c8CMuwVO28l5NZPoAAZ0AJueK4Q
        X3DOIM0UiePmZpTueH9uTlo=
X-Google-Smtp-Source: ABdhPJzsX4U2YEyWXWHxG3yOWrYWrf9yXZaP7widptbfWWgSU5bjLDkJEdfQ0LqIQaOXDeaS0njieA==
X-Received: by 2002:adf:b195:0:b0:207:986c:2a3c with SMTP id q21-20020adfb195000000b00207986c2a3cmr16003636wra.447.1649765182992;
        Tue, 12 Apr 2022 05:06:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b0b:9901:a42c:cba6:f5ae:31f5? ([2001:a61:2b0b:9901:a42c:cba6:f5ae:31f5])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d4e07000000b002079a418430sm10482048wrt.85.2022.04.12.05.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:06:22 -0700 (PDT)
Message-ID: <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
Subject: Re: GSoC Proposal 2022
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Date:   Tue, 12 Apr 2022 14:06:21 +0200
In-Reply-To: <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
         <20220410182819.23967855@jic23-huawei> <YlNcQEAZVGYBkdy5@fedora>
         <20220411095219.000058a8@Huawei.com> <YlQpcZvwZuabMsz+@fedora>
         <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2022-04-12 at 11:48 +0300, Andy Shevchenko wrote:
> On Tue, Apr 12, 2022 at 10:43 AM Maíra Canal <maira.canal@usp.br>
> wrote:
> > On 04/11, Jonathan Cameron wrote:
> 
> ...
> 
> > I took another look at the Analog Devices Inc. catalog and choose
> > another
> > couple of options:
> > 
> >     - ADPD188BI and ADPD410x: are optical devices based on SPI/I2C.
> > I guess they
> >     might be too bold for a GSoC project.
> >     - MAX31875: is a Temperature Sensor based on I2C. Different
> > than the optical
> >     devices, this one might be too simple.
> 
> >     - LTC2499: is a multiplexed ADC sensor. For now, it is my best
> > option.
> 
> Have you checked if it has similarities to 2496 and 2497 variants? We
> already have drivers for those, it makes sense to double check.
> 

Yeah, after a quick look on the datasheet, they look very similar...

The MAX31875 looks to be a fairly simple one (maybe a good candidate
for a first driver) but, IMO, having it in IIO boils down to have
support for continuos mode which would mean triggered buffer support.

And this brings me to something that already crossed my mind...
Jonathan, would it make sense to be able to change the trigger
"sampling frequency" depending on some device configuration? In this
case, if we want to have continous mode, I guess a hrtimer trigger
would be, for example, one good candidate of a trigger to attach.
And, as we can have different SPS, we would want to have the trigger
fireing depending on that... This could also be an additional "task"
for you (if it makes sense of course).

All the above said, if we do not support continuous mode, this device
also falls nicely in the hwmon domain (with all the hyst and over
temperature stuff).

The ADPD188BI looks to be more complicated which might be too much for
GSOC? Not sure here... That said, it looks like you can have some fun
with it.

- Nuno Sá

