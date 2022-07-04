Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA05C565011
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiGDIxc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 04:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiGDIxb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 04:53:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA24BC8C
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 01:53:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v14so12433674wra.5
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2022 01:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pIZhwpifJqOc8phnkh4a9ifyqfRsTCMKA0TsbzimolI=;
        b=xuxMyqwGh9S6fUqGbF4kU7MvcPPyj3gr/NaY7QgTr9lULKX4OojlkL4VK6v8qFG1Lg
         o4cb/1S6DdPn7uuQiqJafwZxA1iHLC5uSa4UKa23JRKgVt+BCzYHpFys3upJC0DfvpcM
         Oi4ayQ0kV5c4vq7lpdcfq6362T3W0o/JSVKktLefLr7z9K3GSER9SmU+QcRuOhiPHzP9
         ZfaN2xOBPLgbU9VjNrvZUnSvMEnab0SjnOYWZ/n12h9gN69dgwz9nL7vMt/gkFx6imKF
         C4rZ5WEYHtij3ss22KjIFfBs8manc3BquB06crrwewtlrIkoG3CVuejF4LIlwTYcSUM9
         YnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pIZhwpifJqOc8phnkh4a9ifyqfRsTCMKA0TsbzimolI=;
        b=O/EVfMtlkKznan5lefdE6SLLCsrOEQKpw7eW9ih/A69YaDXYtricd0+n0kVOZRC0Iv
         JnG91gtT/nbtXtxNiYwp1hD5pmuOE7ef2L8zRP0m/Rz7lFVkrczBjeFxJg9r9Q4yNR1P
         Dfq4Rlx+51IT2453kLlJPjXDMkHwnL4KYBih7LLP0QaqmbVsMlh0kmDh1r2Snq9k0GVQ
         8AQP5DIswEALhrbAJUVgtRzobTQbjwmjJGpbi223cAVihtU96umQsKw4tIKQpTRFo9Q0
         b2qyL1/jDWNWQlRfOsWMUPoNxp1xE8dVJ8wTe5bhpcAkcjVUfayaQRpVQMzU/Cn0VMXu
         jtqg==
X-Gm-Message-State: AJIora9xGvw64di+w6d6IEU6ZveoedCFcADegXskjhj5imJ50EYUrgBC
        mIEhxicpb9O5AgPoaPjaTzTcXw==
X-Google-Smtp-Source: AGRyM1tSHhOzmdD6Hr2s22fF4KammavgIRmSydrVMvER7ybYgJuqTt1fMOo3jf0dX7Ics7E3Fu2zyg==
X-Received: by 2002:a5d:58cc:0:b0:21d:6919:7daf with SMTP id o12-20020a5d58cc000000b0021d69197dafmr5135376wrf.434.1656924808790;
        Mon, 04 Jul 2022 01:53:28 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b0021d6433a7c3sm5999367wrv.72.2022.07.04.01.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:53:27 -0700 (PDT)
Date:   Mon, 4 Jul 2022 09:53:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," <andy.shevchenko@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: mfd: Add mp2733 compatible
Message-ID: <YsKqhaeMfPAb6Y+m@google.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <20220615145357.2370044-3-sravanhome@gmail.com>
 <YrnChlCiyzgcyyxl@google.com>
 <CAL_Jsq++_+rPj94notsUp8SMPLFvq+QG4o_Bm6i2f2HSySDT2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq++_+rPj94notsUp8SMPLFvq+QG4o_Bm6i2f2HSySDT2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 01 Jul 2022, Rob Herring wrote:

> On Mon, Jun 27, 2022 at 8:45 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 15 Jun 2022, Saravanan Sekar wrote:
> >
> > > Add new compatible for mp2733 mfd driver.
> > >
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Applied in place of v1, thanks.
> 
> Still failing, pushed out?

Of course not! :)

Please try again tomorrow.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
