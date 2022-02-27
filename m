Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D214C5AAC
	for <lists+linux-iio@lfdr.de>; Sun, 27 Feb 2022 12:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiB0LkE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Feb 2022 06:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiB0LkD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Feb 2022 06:40:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21BA24F31;
        Sun, 27 Feb 2022 03:39:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D65760E76;
        Sun, 27 Feb 2022 11:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3270FC340E9;
        Sun, 27 Feb 2022 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645961966;
        bh=RaHv/tbCTPFcJkyrq9jbKLwZnrSbRDyLy/HShbnR3DY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EYMnLfkXjHVZi5w3T/eLc6H8OVn1YpHTfaFqv15stJj/fUgmIV7E+p7YDvvQm+v/m
         s7oG0sWjHuvJDruH9lifdU2bxg1ZjEeeXvOk/ZwLvATrridL/1/AubXp8nOgWbKWpj
         PyA6eh6xT7ildmcrdErmv+ifCEeTcjsB57oHyUARBB/K8GelAlMkUDqT5INSxfTk0n
         JMTrVwXGo9Snrih5T2tTGFxVh/Ydaq6ZMcQRVb9hCGpYJG7pOMaJTRknxlVb7++sUt
         eAovG0fvdIEgoam70BM/Q1MJ2EbUOzBAb4//GMPc0Q6A1raMJSM+GmP1Ka9YRG5ujk
         r5Lfm2Q+9KHSg==
Date:   Sun, 27 Feb 2022 11:46:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     <linux-iio@vger.kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/8] PM: core: Add NS varients of
 EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and runtime pm equiv
Message-ID: <20220227114628.219c7055@jic23-huawei>
In-Reply-To: <6cd17744-d060-1094-098d-e30a10f96600@intel.com>
References: <20220220181522.541718-1-jic23@kernel.org>
        <20220220181522.541718-3-jic23@kernel.org>
        <6cd17744-d060-1094-098d-e30a10f96600@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Feb 2022 20:37:57 +0100
"Rafael J. Wysocki" <rafael.j.wysocki@intel.com> wrote:

Hi Rafael,
> CC: linux-pm

Oops. Stupid omission on my part, sorry about that!

> 
> On 2/20/2022 7:15 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > As more drivers start to use namespaces, we need to have varients of these
> > useful macros that allow the export to be in a particular namespace.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>  
> 
> I'd rather route this through linux-pm unless you have dependent changes.

Ok. 

The kxsd9 patch (4) is dependent on other changes queued for
the merge window in IIO. If we want to do it through linux-pm I'd
love it if we can manage to get the ground work in for the coming merge window.

So options are:

1) This patch alone via linux-pm and I queue the users up for next cycle
   Fine by me but always awkward to have infrastructure with no users.
2) First 3 patches via linux-pm so we have a user (scd30) in a low churn
   driver and I'll queue the rest for 5.19.  Fine by me as well.
   That goes on cleanly on 5.17-rc1 and there is nothing else in my review
   queue touching that driver.

I'm also interested to hear your view on the discussion going on in reply
to the cover letter. Specifically Paul suggested we 'only' have the
namespaced versions of these macros.

Thanks,

Jonathan


> 
> 
> > ---
> >   include/linux/pm.h         | 14 +++++++++-----
> >   include/linux/pm_runtime.h | 10 ++++++++--
> >   2 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index f7d2be686359..112b8125d4be 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -368,13 +368,13 @@ const struct dev_pm_ops name = { \
> >   
> >   #ifdef CONFIG_PM
> >   #define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> > -			   runtime_resume_fn, idle_fn, sec) \
> > +			   runtime_resume_fn, idle_fn, sec, ns)		\
> >   	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> >   			   runtime_resume_fn, idle_fn); \
> > -	_EXPORT_SYMBOL(name, sec)
> > +	__EXPORT_SYMBOL(name, sec, ns)
> >   #else
> >   #define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
> > -			   runtime_resume_fn, idle_fn, sec) \
> > +			   runtime_resume_fn, idle_fn, sec, ns) \
> >   static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
> >   					 resume_fn, runtime_suspend_fn, \
> >   					 runtime_resume_fn, idle_fn)
> > @@ -391,9 +391,13 @@ static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
> >   	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
> >   
> >   #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> > -	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "")
> > +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", "")
> >   #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> > -	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl")
> > +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", "")
> > +#define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
> > +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "", #ns)
> > +#define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
> > +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl", #ns)
> >   
> >   /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
> >   #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 9f09601c465a..6a8b9551ecad 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -41,10 +41,16 @@
> >   
> >   #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> >   	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> > -			   suspend_fn, resume_fn, idle_fn, "")
> > +			   suspend_fn, resume_fn, idle_fn, "", "")
> >   #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> >   	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> > -			   suspend_fn, resume_fn, idle_fn, "_gpl")
> > +			   suspend_fn, resume_fn, idle_fn, "_gpl", "")
> > +#define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
> > +	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> > +			   suspend_fn, resume_fn, idle_fn, "", #ns)
> > +#define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
> > +	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> > +			   suspend_fn, resume_fn, idle_fn, "_gpl", #ns)
> >   
> >   #ifdef CONFIG_PM
> >   extern struct workqueue_struct *pm_wq;  
> 
> 

