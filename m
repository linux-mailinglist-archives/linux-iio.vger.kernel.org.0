Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A6A4FE3AA
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiDLO0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiDLO0P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 10:26:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4904DF56
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 07:23:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c7so28054516wrd.0
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=e6gpITP/aGZM2Pksopppq7kd5eH2UEekWtZGMMcXdb8=;
        b=VUhPZmUorLbUp12x8z8wU09pFW1NSPxr5MSgVYXxC1JNKlOXpP6+f7STr2xOyj7rhe
         rQjAIqemggYlZJXhtVm321Xfv735AFVrMRaMTsMLIq32Ub9iYJwZ+z8Bqa91FJGWcUtF
         ZPbuxvFPFCJNBgHDiE4K/7sggZ+VBM7y44asDS66gYqYhvGIja7RnI527Q5Gtknh5NQX
         9dGWHAxJirFnW+aunmQZm1/7uzNCwMrN5tVQY+Zhtsyo9OPOMfyraAh3pXxxVrh8g/nY
         nlAf58pqTiHLRcktrrT1uqWuG2ntN/Fwd3+u0paz+tt3BY93n6vVW55/OryWUQJyBCIJ
         Hs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=e6gpITP/aGZM2Pksopppq7kd5eH2UEekWtZGMMcXdb8=;
        b=M4ADYRrdyyCO01mGMyr3F5QDYd4TTPkWtxn+ZMt/7lJQ8TBNy5zP7tcwGL3/rZCsKR
         updTAyZC9AXARFSictgwxqKI/jNDem57zPUT4oSTwkqEFpisYNdKmPIhhkF/eGnjEZED
         Kx9Cx5c7fHSBPyLQxAmeU8YORh7vioy3Xcv90XYR04kgkRMmrVEMMdCaoLJZ/vTSeApZ
         X1umdTolXm5x75oN+8EalFutQIP5ObS9pc2/x8MIVH9rw2DUI1Fp0lK6RIY/5Avqr77B
         nXysBx8L/am8t3gyIx4+FXLUZY0765inJjx+UK1x5tlMPSSecHETEwpkVZcunrOcdbgk
         ubnQ==
X-Gm-Message-State: AOAM532hLQUcPH5HFjjApjpnJrUMSrJB2bR5fFOHQIRd1sJ1z4ZW/UJ/
        KnmFE43RECEkUEwXiyg3Ajw=
X-Google-Smtp-Source: ABdhPJwwAZdlKNPJriClSRgRQg15MP/tAAjxCh0oKyII0EVK6lD22L3a99QR7dUHPzXE24BRMGXmYg==
X-Received: by 2002:a5d:6208:0:b0:203:dde4:c76e with SMTP id y8-20020a5d6208000000b00203dde4c76emr29098008wru.273.1649773436449;
        Tue, 12 Apr 2022 07:23:56 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b0b:9901:a42c:cba6:f5ae:31f5? ([2001:a61:2b0b:9901:a42c:cba6:f5ae:31f5])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b0038eca3cdbb3sm1484045wmr.13.2022.04.12.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 07:23:55 -0700 (PDT)
Message-ID: <a5f002afb956c96b20c5f5589c34ecaa1bdfadc6.camel@gmail.com>
Subject: Re: GSoC Proposal 2022
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Date:   Tue, 12 Apr 2022 16:23:55 +0200
In-Reply-To: <YlVvhoBNap4Yip3O@fedora>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
         <20220410182819.23967855@jic23-huawei> <YlNcQEAZVGYBkdy5@fedora>
         <20220411095219.000058a8@Huawei.com> <YlQpcZvwZuabMsz+@fedora>
         <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
         <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
         <YlVvhoBNap4Yip3O@fedora>
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

On Tue, 2022-04-12 at 09:24 -0300, Maíra Canal wrote:
> On 04/12, Nuno Sá wrote:
> > On Tue, 2022-04-12 at 11:48 +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 12, 2022 at 10:43 AM Maíra Canal <maira.canal@usp.br>
> > > wrote:
> > > > On 04/11, Jonathan Cameron wrote:
> > 
> > The MAX31875 looks to be a fairly simple one (maybe a good
> > candidate
> > for a first driver) but, IMO, having it in IIO boils down to have
> > support for continuos mode which would mean triggered buffer
> > support.
> 
> I took another look at the Maxim Integrated catalog and end up
> finding
> the MAX31889 Temperature Sensor.
> 
> I guess this sensor has an interesting challenge level with the need
> to
> implement FIFO and interrupts support. 
> 
> Have you guys some thoughts on this one?
> 

At first glance, it looks like a better choice when compared with
MAX31875...

- Nuno Sá
> 
> > 

