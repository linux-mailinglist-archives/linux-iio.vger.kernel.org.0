Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4069B27D
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 19:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBQSrH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 13:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBQSrH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 13:47:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3497A40CF
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 10:47:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id eg30so7553104edb.7
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 10:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tHFfVBJiecHV+7Xj9R8+SmQUbzmFB1drwweiodMr7A=;
        b=HikAEowLsiULYvL2GCAb+fr1822popQSFR3YvV/ISKx4kw2cc/vVvvYFsWFEwW4u9C
         R/aKdsAqxtGkrcLQXI/qFjxKmTSedTtAUtGhV3x2HlubJgdfK1OCc+guT2ZHzXYEvBcN
         /tSgUQ52GMg9418Y2ovuFkea2W/m4GqOAqbxIfNXpoCYgT7nKpuBg0FSVBjuPD9neuFk
         HXr0HnLXyJkO4oH2PEjK8G6yqfzvYN5M3zF0Xy5jOX9Znl9NUg3GnPXjjb3c7iT0nU9L
         naV6QWIGT22jTtJjFJhNRtUzTVQ2K76qDt8fclTKaYXBJrkw1gYgM5gbeOaMNGkxTp3r
         +psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tHFfVBJiecHV+7Xj9R8+SmQUbzmFB1drwweiodMr7A=;
        b=OOGrMiK83QhGigIfkwkbdHtovN1GPgN9woI4Jdhq1oYK3WTyhaRIbpw5fVAtCTVXn1
         sJi9KRAlz+CNYQcmp8oFCKquCf4PbZM92m/pwBDleCoweEc48a2PU2CARxo3Z0gMOoci
         j20xM5sXOhBO1AJxk+yGEgU94foaCd3IDuAnRs8eA85GoVmgFN9LFVxWKWz7GKkPf7kA
         bq83+OVrlN3kv1hYHdDbbl+K3R/p6eXpXkA1vQ+1zY144OiOKXc1L9BdJxNp7v5/aIgX
         4JDb1cnK4YSo4f16TunD63arK8K4d7dZ4OW0MYJ69hDOV5qCjEcMnhBha5vsNA7rNfnB
         jWUA==
X-Gm-Message-State: AO0yUKUZAoJj109uAxEH/S5GgC3Pqqh5/g/TW+yLrrXaMWIcr46VCe66
        ZVp1FzfUFrG08sbbZG5Yo/0JlnTIhFg=
X-Google-Smtp-Source: AK7set8p7gBYZ6WGW6H1+XLna2GUP5j/UYVKyNFzwZ6jamP/nCp/Zyugk6AgoQe95iHVIOchSKpABQ==
X-Received: by 2002:a17:906:4096:b0:8b1:238b:80ac with SMTP id u22-20020a170906409600b008b1238b80acmr1558534ejj.67.1676659624666;
        Fri, 17 Feb 2023 10:47:04 -0800 (PST)
Received: from carbian ([2a02:8109:aa3f:ead8::af9d])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906960900b0088091cca1besm2409173ejx.134.2023.02.17.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:47:03 -0800 (PST)
Date:   Fri, 17 Feb 2023 19:47:01 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan.Cameron@huawei.com
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: Questions: iio: accel: kionix-kx022a: timestamp when using the
 data-rdy trigger?
Message-ID: <Y+/Lpcc0Wa2VGsGO@carbian>
References: <Y+6QoBLh1k82cJVN@carbian>
 <de389f14-0c63-86ae-6718-e91fc9818fc6@gmail.com>
 <20230217114308.00004a31@Huawei.com>
 <a4e69c59-d5c5-be8e-da7c-1955cc8b0ad7@gmail.com>
 <20230217142828.00007ed8@Huawei.com>
 <Y++Sju++GBxLAoCH@carbian>
 <20230217152713.000007ee@Huawei.com>
 <cde24815-bfe4-9347-f950-ed8497edd4ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde24815-bfe4-9347-f950-ed8497edd4ca@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 17, 2023 at 07:02:07PM +0200, Matti Vaittinen wrote:
> On 2/17/23 17:27, Jonathan Cameron wrote:
> > On Fri, 17 Feb 2023 15:43:26 +0100
> > Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> > 
> > > On Fri, Feb 17, 2023 at 02:28:28PM +0000, Jonathan Cameron wrote:
> > > > On Fri, 17 Feb 2023 13:59:16 +0200
> > > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > > > > On 2/17/23 13:43, Jonathan Cameron wrote:
> > > > > > On Fri, 17 Feb 2023 07:56:22 +0200
> > > > > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > > > > > > Hi Mehdi,
> > > > > > > 
> > > > > > > On 2/16/23 22:22, Mehdi Djait wrote:
> 
> > > 
> > > So should I send a patch with data->timestamp as I suggested ?
> > 
> > I think so.
> 
> Please do! That would be very much appreciated :)
> 

I will send the patch today. 

--
Kind Regards
Mehdi Djait

> Yours,
> 	-- Matti
> 
> -- 
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~
> 
