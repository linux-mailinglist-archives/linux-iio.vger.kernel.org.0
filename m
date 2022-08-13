Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49832591BDB
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbiHMQDu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbiHMQDt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 12:03:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D269BE2D;
        Sat, 13 Aug 2022 09:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA3F60F08;
        Sat, 13 Aug 2022 16:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46418C433D7;
        Sat, 13 Aug 2022 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406627;
        bh=QQwdY6p7w1wMhEXqTepk2n31Fjq2crRd2b0/8WnaKBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R5kpBqqgt35ep/hRe67kTfHD2AATAoDyu36Z/UZx4QVp0T3z6KPxD/74Wn/HSdfOh
         6I5mNNkToJrTbZJSNljmmWS9i2K0FOQrksLKb0yOOTA3+4orspT0PVYcPyGt5B3vea
         HJDjp/J1XP5Fbm6xg72olhVwC0F2HlOtSEroj9uUFUNg2B1asqBwO+HVZ02EKCQYu4
         cXdGt3p8wqWGoiiBHAozcY4wb1+BImzlQz6JRCJrt2O4UPH66Q7I1bEWAoVG1LK5UE
         UCuIDkbCN8FinijBAu3XJyCTEUZqlEl7LpumYBjgiwnJDxWoqx69+8a3xcYQXtMyEv
         WKVsKmiKcr9Cw==
Date:   Sat, 13 Aug 2022 17:14:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/5] PM: core: Add EXPORT_NS_GPL_DEV_PM_OPS to avoid
 drivers rolling own.
Message-ID: <20220813171414.17f32f21@jic23-huawei>
In-Reply-To: <PLNAGR.UBLC121G9UCD2@crapouillou.net>
References: <20220807192038.1039771-1-jic23@kernel.org>
        <20220807192038.1039771-2-jic23@kernel.org>
        <PLNAGR.UBLC121G9UCD2@crapouillou.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 08 Aug 2022 13:22:37 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> If you can wait a day or two - I would like to submit my own version of 
> EXPORT_NS_GPL_DEV_PM_OPS, which should be more versatile than your 
> version.
Thanks. Yours approach is indeed preferable, I'll respin this on top of your
patch.

Its a bit enough change I'll probably not take any of the
existing tags forwards to v2.

Jonathan
 
> 
> Cheers,
> -Paul
> 
> 
> Le dim., ao_t 7 2022 at 20:20:34 +0100, Jonathan Cameron 
> <jic23@kernel.org> a _crit :
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > A driver wishing to export a struct dev_pm_ops with both suspend and
> > runtime ops provided could use _EXPORT_DEV_PM_OPS() directly but
> > that macro is not intended for use in drivers and requires non
> > intuitive aspect such as passing "_gpl" as one parameter and the
> > namespace as a string.  As such just provide a macro to cover
> > the GPL and NS case in a fashion that is in line with similar macros.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  include/linux/pm.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 871c9c49ec9d..18856e0d23ac 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -407,6 +407,11 @@ static __maybe_unused 
> > _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
> >  #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, 
> > ns)	\
> >  	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, 
> > "_gpl", #ns)
> > 
> > +#define EXPORT_NS_GPL_DEV_PM_OPS(name, suspend_fn, resume_fn, 
> > runtime_suspend_fn, \
> > +			   runtime_resume_fn, idle_fn, ns) \
> > +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, 
> > \
> > +			   runtime_resume_fn, idle_fn, "_gpl", #ns)
> > +
> >  /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
> >  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> >  const struct dev_pm_ops __maybe_unused name = { \
> > --
> > 2.37.1
> >   
> 
> 

