Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F04FE118
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 14:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353818AbiDLMyf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 08:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355210AbiDLMxy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 08:53:54 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2012F26
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 05:24:46 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id b188so18804373oia.13
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wQD56wN2tJuRomqQg42XL5GuTSf7A4rH766lXxj+9rE=;
        b=WbibI5iIotI4XjGbnYfAQvz9LIJvJuHPFyMEFO9iMCZfpHzzSjdcjCB5dudGE2J4hm
         3zE799Z+mzKEAcao43tDlNRlYcsbhvZ7rs0WPIfq2/mS2v4G08jiX2S0Y1pCDM4/icHs
         1KPKViingHpTZTmirC8kWS1l3O7WXMtvzSzMLHgOXMDnIajvDdhvrOPIAHLRnkIYo/66
         pzLhRJV+skUDSi5fmDNLRFWxOGQfHZ4UNtLaNWQKCJWU6QyB/m6OTMrPIYrEBY+vZoD2
         azwREFZVIosk9g65XDwHHhkzkkt4LXHm+wglSzaQs+GJWdNNcRxYzFLN+1IgKnFirzd+
         wk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wQD56wN2tJuRomqQg42XL5GuTSf7A4rH766lXxj+9rE=;
        b=Ut6L14alqOsf+8Pef8jO8Wtu85v1fzkcO+cQ6mS61QvRv/O7HrJHJRRa8ET7m7bgjM
         hQhDL0CHwl3o0CrC/g15hgNmFT6fO1cvkoK7Bdqjw+JIyv6ok/BcqYjdK6jkxAsoi5RB
         z8xLJbuZB55GUI6/Pff357IsVIsBu9AMhReYN46iuDULWShW8b6tAnPlJpZAbmQ3y20A
         SWaMKA8Ez8DTbttV74xrbpQuV2Taq9OPNaNTwMWUUCiHkWDqXHm39wL+021acmfUyV2j
         M874KAGCwvbbQxjKr5UZ5YOfYMb/xrdHmaEagR4LSWYG6NxhPACF8NpZrUdD09czbbVx
         o+ZQ==
X-Gm-Message-State: AOAM530LgrJiQtvywlrBq2FX6Mwj/g5/m5Zd5k43xIqIMx1k+LL8FbCn
        rKMytBdQtBVOQcaPBs+h6qTpKA==
X-Google-Smtp-Source: ABdhPJwtcSX0elpq93y/UcT9EeKdLNZI9gTobKkYaKe/smFEAWdHwIlAEfvNCrQRc/zzppyJy70AXA==
X-Received: by 2002:a05:6808:f92:b0:2f9:7642:287f with SMTP id o18-20020a0568080f9200b002f97642287fmr1587945oiw.16.1649766286061;
        Tue, 12 Apr 2022 05:24:46 -0700 (PDT)
Received: from fedora ([187.64.132.161])
        by smtp.gmail.com with ESMTPSA id e22-20020a056870239600b000e2f0c69849sm1017620oap.11.2022.04.12.05.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:24:45 -0700 (PDT)
Date:   Tue, 12 Apr 2022 09:24:38 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: GSoC Proposal 2022
Message-ID: <YlVvhoBNap4Yip3O@fedora>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
 <20220410182819.23967855@jic23-huawei>
 <YlNcQEAZVGYBkdy5@fedora>
 <20220411095219.000058a8@Huawei.com>
 <YlQpcZvwZuabMsz+@fedora>
 <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
 <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59c37b67bbc4a24336e5220a7ad4f242d854fb76.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/12, Nuno Sá wrote:
> On Tue, 2022-04-12 at 11:48 +0300, Andy Shevchenko wrote:
> > On Tue, Apr 12, 2022 at 10:43 AM Maíra Canal <maira.canal@usp.br>
> > wrote:
> > > On 04/11, Jonathan Cameron wrote:
> 
> The MAX31875 looks to be a fairly simple one (maybe a good candidate
> for a first driver) but, IMO, having it in IIO boils down to have
> support for continuos mode which would mean triggered buffer support.

I took another look at the Maxim Integrated catalog and end up finding
the MAX31889 Temperature Sensor.

I guess this sensor has an interesting challenge level with the need to
implement FIFO and interrupts support. 

Have you guys some thoughts on this one?

> 
> The ADPD188BI looks to be more complicated which might be too much for
> GSOC? Not sure here... That said, it looks like you can have some fun
> with it.

P.S.: Although the ADPD188BI looks like a lot of fun, I was afraid to don't be
able to deliver a full driver at the end of 12-weeks. So, I'm trying to find
a safer choice.

Maíra Canal

> 
> - Nuno Sá
> 
