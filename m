Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33F35531CB
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344495AbiFUMTB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 08:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiFUMTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 08:19:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B56101F3
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 05:18:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cw10so3344857ejb.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inovex.de; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=HHGOfHfF3U4huvLvf6uJap0yVNjnDz1V61W/beJutGc=;
        b=JxPlirJEq5OQfzPvNCxQt51CJYd0spYZPwGY090UtLR07Vz2MUH4uYyYmorfoUR+2O
         0+QITzGCyqKVbHLVkllqXt+pLHV6EXbWLyV9QFjT0FWlUXzz7qWaNJI5Mzu3IKIgHbXR
         UmNoO7S3IQglYXN3Wvrahidwil56AarvpO1OWOhhuplw4Wj+bx3RO2u0ovPfSkQyLxaY
         GyKgTfLraqL10DJLZ8/dL4TChNgTgohMZLKSK+AISjFjtXCsS6ogbpaZVVeiy70ZFfxd
         xfIEx+19l7gdQSrTK82r3nulXrtVXKtLGFt5ASCvpZr2b/KMB78JOViUvQrQcHHhHMYn
         vNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=HHGOfHfF3U4huvLvf6uJap0yVNjnDz1V61W/beJutGc=;
        b=hkJ9kJXWywhsPWRCSoZjlNudSNKnZQULpfZwz8QJbwdYMSaSXE+zyiF7QDaX+Teg1o
         razjoQO3Y9D8LQieyZa89Y0ZocztzVARZPXCnL+a4y7GK8FLlJP+qpP9K8J9nxkR4ir6
         PI/Wn8DWIu0VzjBg926HQ2wJ9pEKpGaYY27dKZ5//1kiDKY7otbY8lWbc4YNsEBAur4+
         RDY4SNo74hts0tpsOWXTa7kfCTnhx8eak7PrKGHCmb7KHxEPP0Zvx6Qo7J2YZjpT/Mt4
         MAL3/WfhYHbi40sNWhvOCB1YqeqHYGK6mm1vZYsn9Lic1MxPMSv9uLXMTr/fmOuKqhKL
         c3TA==
X-Gm-Message-State: AJIora80P/8m7rm0lxKO3Vwavl4yBmKOx6EJuVfqhG6+ij9/hVIvCilm
        JfZZjpgmKyvUaDS/1btacBsd+bu69OLqoLUmCKlB4U/ueurTRyWuezSXjfqEKeAGz84ukqeX81G
        lcO9hFkHA+5aQpR4QpGYjiOKXP1FJFy6U5+oiRhrs52batT6B3/lckZdEVCGaa8V5ZMzjfu6UQE
        hi5M2mig==
X-Google-Smtp-Source: AGRyM1vn7jhQi46urLY8HzTsqi7amt8k4Z4rUptoQSpEOAffD7xjZbb/8sLKepkrIkwqZKNAg3bgAg==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr25405951ejc.762.1655813936702;
        Tue, 21 Jun 2022 05:18:56 -0700 (PDT)
Received: from gmail.com (2001-4dd4-c5f9-0-29de-67d-4ca2-7113.ipv6dyn.netcologne.de. [2001:4dd4:c5f9:0:29de:67d:4ca2:7113])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906538800b006feb479fcb4sm7481738ejo.44.2022.06.21.05.18.55
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:18:56 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:18:55 +0200
From:   Stefan Lengfeld <stefan.lengfeld@inovex.de>
To:     linux-iio@vger.kernel.org
Subject: Questions: IIO type for absorbance and float values in channels?
Message-ID: <20220621121855.ynnv5ckymbmmvjcm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

I'm currently working on a linux kernel driver for a new sensor design. It's a
special kind of light sensor that measures the reflection of emitted light.

I'm trying to fit this type of sensor into the IIO subsystem but I hit some
issues.


Question 1:

The sensor measures the absorbance[1] of a material. It's the negative
logarithmic quotient of the received and emitted light. It's a unit-less value.

As far as I can see there is currently no predefined IIO type in the kernel for
this.  I have search the list [2], but nothing matches.

Do I overlook something or what channel type should I use for this sensor
measurement value?


Question 2:

The sensor effectively returns a float value of the measurement. I grepped trough
the existing IIO drivers, but there seems only one driver that deals with float
values.  The sps30 driver[3] gets a float from the device, but converts it to a
integer value before passing it to the IIO subsystem.

I know that it's possible to provide a 'scale' attribute per channel to
userspace[4], which can be a float point number. So effectively the result of a
measurement can be a float-point value after it's computed in userspace.

Are floats really not supported as channel values? What is the recommend
approach to deal with these measurement values?


Question 3:

Is there another kernel subsystem/UAPI that fits this type of sensor
better?  (My guess would be: No, IIO is the correct subsystem.)


Thanks a lot for answering my question.


Kind regards,
Stefan

[1]: https://en.wikipedia.org/wiki/Absorbance
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/iio/types.h#n14
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/chemical/sps30.c#n39
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/dummy/iio_simple_dummy.c#n122
