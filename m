Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1657AE2C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jul 2022 04:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiGTCyb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 22:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiGTCya (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 22:54:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73E51A3E
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 19:54:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j12so13727151plj.8
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 19:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pV2PK4IRNNoN436aOhjsbS02QghTKGZu5j3Ld5RmU4Q=;
        b=hhUL9Nx0yKmzFib65DEfzFCXGpbrk9EtEKtyvevJPVU7pfyR+cbOisKT6eOPAuB6ER
         slHHre9IKSJ9xzCi7/4ZdIbWXkRWj4E5x6J/JVIT7DH/HYT7/YNLfqE+ykIgl1xiFIBc
         rjGdOJ9ILZ7gVHtTtXgPHrQ6m63ebITz/AOnYrS6olp+vmVTFDy6gMkPZxuWVE4hUBI9
         3+vbX29eiRcbuINd9l36LUjzHdq7R+9P9nIylqYIb5tEjOIGZyiMPbuaiEj1ljEDZ1hm
         igIhISYtAKojkfpAQ6BxpodIIm+o6H9cAlwCL/ME9hpIDNHCNBCRI7O2eaNY1dI/R/vB
         yiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pV2PK4IRNNoN436aOhjsbS02QghTKGZu5j3Ld5RmU4Q=;
        b=qFWpUK4s/3C+PFduAdrA7ffOI0ynqQuHwwxPbDHEV9wMWAiO0BgGHzr+zEzgKbMU3Y
         BZZmzxveDaPIO5q9lsJrMhjhrlTVtGP9ebMk/ArSDpNPMQOPsSGXIqqb3AtKSA2/2CRI
         6MAzgE033Qd6IFvIwH1LQAz0XCVmzEWxnygksHLfDX7nh0bYElGQ2U6iyL381mm63oC1
         YnF9GMZrdkuEyXEplQaYBhE8rJziDA+5TPikIKTi2opNicziD1FVuQqvVcJS8r8z59Jt
         oESG04aUFOu6wd9KFTkuEvNspdkx1nmUL2wlwFBs+xrE6fVK6Bz6lv8iXJnF/papS+yA
         2zHQ==
X-Gm-Message-State: AJIora/YGqEtosBqvdDRMwy0YK970VUkS/2BTehkcHBSdbbo2MmaPX+v
        Je8W3JvFw/3SiG0WOnE+oTw8N/0xvot8Zh972FY=
X-Google-Smtp-Source: AGRyM1tWOJAPYc7djIFnMJKlYXqZ2M0wUswurqc72bApE2PBNTHTerVWKG4RoywRtNG/RUoSRzSr8V9et/x902NxYkc=
X-Received: by 2002:a17:903:1208:b0:16b:81f6:e992 with SMTP id
 l8-20020a170903120800b0016b81f6e992mr37181752plh.55.1658285668786; Tue, 19
 Jul 2022 19:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220719150317.67156-1-martin.larsson@actia.se>
In-Reply-To: <20220719150317.67156-1-martin.larsson@actia.se>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 19 Jul 2022 23:54:16 -0300
Message-ID: <CAOMZO5ApeP50=McC1=YmUPXNtBYkJ+72M=yXsFCpPrk0g8hvFw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: imx8qxp-adc: propagate regulator_get_voltage error
To:     Martin Larsson <martin.larsson@actia.se>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Martin,

On Tue, Jul 19, 2022 at 12:03 PM Martin Larsson <martin.larsson@actia.se> wrote:
>
> If the ADC vref regulator returns an error, for example, if CONFIG_REGULATOR
> is not set, the error will be used as a reference voltage.
>
> Introduce a guard for negative return values instead of unconditionally
> casting it to u32.

You missed your Signed-off-by line.
