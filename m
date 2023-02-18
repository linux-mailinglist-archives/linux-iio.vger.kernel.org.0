Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DD669BA2B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 14:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBRNRt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 08:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBRNRq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 08:17:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252EB18150
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:17:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cn9so2387898edb.7
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LyTq5v0SXCZCIE1ciOy01CE2/2q/D/C08ZbNlkG6R0=;
        b=K3T4b/OX6/fGvgyAaPi6luiIMYn4i/I5JCHUCJ1apxRMFwLki8gfUKh8aFkAtUyv49
         h074cR6ph/d9EjUP2RiH9VAEZuZxf0yB2IUQuVPcC0DKgkvuZQyFh5MreH2nxT8DN/Cq
         4xsN6p3+HIYeL08NrJkBjptmbgqdWRc3+6SJuPoDMpc4nccnZF7+wWbW1vk/fc9FRAzs
         GKMLhjeGwCNouClsQZDad5pIFla/IvtD8oe74695xkkSIMR4soBBQfopfau6g5ZYtfo9
         tpaTUhyxevFANUvOlUosoHdMWMePbb2/n4+C/G/XTTmrbLO+kfw6kObb1+2eKVVl1PfA
         GtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LyTq5v0SXCZCIE1ciOy01CE2/2q/D/C08ZbNlkG6R0=;
        b=KNp4yZ8yLN1QqLdYHlZ/GZJUF5mAvqcSvRWkwmXNXhbR9qK6IdsjneWF2cwSWPO6G/
         4K+B3PqeRbagKT4zP6QJXfxncfofur6VdwG3yLxm0pmJ9FC20htaxg2U2SkBj1hHShn9
         KHRPnyP5eREPPg24xeyU2u11gPfKPRukmHG4WRLl3LHianCrOn6ReZlKc7fCpeK0VxJB
         t6nmYaziG991mus+4pRXkXgAYAQKdTOhvfa2+AVhrYHmuyABe0ZIVegSNSVOrSWbOcXT
         TWHTj/WwEM4uM97H2OqBihrjIUVEtMNQyG7wGXc/1bSnlmPXI0fP2Z+mjqKIMxTkpZk6
         MI9w==
X-Gm-Message-State: AO0yUKU5MyzSyY7EP7kruLxRq17hsiHKLAgAgZqzpEAvwzskEUNIftwA
        TKTXC0MYlYDvXDf2l4X8lxA=
X-Google-Smtp-Source: AK7set8Bem4VjOcrAhke/EPLw0WT1q0bFDpuCExG7fIC/JfVrGBe8X/2P3iaQ2DRcqpr0lxdcUDkXA==
X-Received: by 2002:a17:907:764c:b0:88e:e498:109b with SMTP id kj12-20020a170907764c00b0088ee498109bmr3522454ejc.5.1676726263542;
        Sat, 18 Feb 2023 05:17:43 -0800 (PST)
Received: from carbian (dynamic-2a01-0c23-5c09-8a00-f386-7b22-bb9a-becb.c23.pool.telefonica.de. [2a01:c23:5c09:8a00:f386:7b22:bb9a:becb])
        by smtp.gmail.com with ESMTPSA id jz19-20020a17090775f300b008b17cc28d3dsm2481178ejc.20.2023.02.18.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 05:17:42 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:17:40 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: accel: kionix-kx022a: Get the timestamp from
 the driver's private data in the trigger_handler
Message-ID: <Y/DP9G7gngMoGnAF@carbian>
References: <cover.1676661174.git.mehdi.djait.k@gmail.com>
 <d81610c45af55b1c5eab5d0597f71650ff908203.1676661174.git.mehdi.djait.k@gmail.com>
 <1a565f66-7e2a-9ec5-441a-d33ef420cfab@gmail.com>
 <aba1ea66-b5cc-d43e-b1e6-5d5101da5e9a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba1ea66-b5cc-d43e-b1e6-5d5101da5e9a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Matti,

On Fri, Feb 17, 2023 at 09:55:33PM +0200, Matti Vaittinen wrote:
> On 2/17/23 21:52, Matti Vaittinen wrote:
> > On 2/17/23 21:19, Mehdi Djait wrote:
> > > The trigger_handler gets called from the IRQ thread handler using
> > > iio_trigger_poll_chained() which will only call the bottom half of the
> > > pollfunc and therefore pf->timestamp will not get set.
> > > 
> > > Use instead the timestamp from the driver's private data which is always
> > > set in the IRQ handler.
> > > 
> > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > 
> > Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> 
> Oh. I just noticed there is no Fixes tag. It'd be good to have one as it
> usually helps fixes like this being back-ported to stable.
> 

I will add the Fixes tag and send the patch again.

--
Kind Regards
Mehdi Djait
