Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF197636A69
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 21:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiKWUBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 15:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiKWUAk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 15:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD44366C82
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 11:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5855EB82476
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 19:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A7BC433D6;
        Wed, 23 Nov 2022 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669233596;
        bh=Dx8bb7/vPJ4JQ+i0AX692GHloSr53kS6mqAlZoANc0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y2+vYglZsn9P+quQhgUjjLrATqj9JFfNXAIkmtMmJnBoQJVflIydCUJ3k9uE1yHLO
         PItv4XyKMp4J+s5auMpCZXykPTmhzAhiPnU7tMZisCEMISoLcdIMInPGx2PyQoB398
         qFfoCJq629KL67wRDhmHBn9KDeIwSVoXcd+5uasI3gI0dyIkx1ANBXsgCZ6mcoWRII
         9mvXpDYscin0wnv0rUpZTdTY9U4qe4aHKa9oRVFnxFmhLqSxcilT82rYqPbhcQkgmw
         AKJLPkOTsjzwB625z0BQbC4j91Z4RoXELY8KZuHipmb/tc9MCT1V2JWj8aQokOStUf
         CX4jjwiOnho1g==
Date:   Wed, 23 Nov 2022 20:12:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support, features and
 cleanup for 6.2
Message-ID: <20221123201229.225964a0@jic23-huawei>
In-Reply-To: <20221123194918.3d523e97@jic23-huawei>
References: <20221116190308.76cfba5a@jic23-huawei>
        <Y35pOOLEW8mtxnxa@kroah.com>
        <20221123194918.3d523e97@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Nov 2022 19:49:18 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 23 Nov 2022 19:40:56 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Nov 16, 2022 at 07:03:08PM +0000, Jonathan Cameron wrote:  
> > > The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:
> > > 
> > >   Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.2a    
> > 
> > I get the following error when trying to push these out:
> > 
> > Commit: 3acdb4a11517 ("iio: adc: ad_sigma_delta: do not use internal iio_dev lock")
> > 	Fixes tag: Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Deltadevices")
> > 	Has these problem(s):
> > 		- Subject does not match target commit subject
> > 		 Just use
> > 			git log -1 --format='Fixes: %h ("%s")'
> > 
> > 
> > linux-next should have also warned of this, right?  
> 
> It didn't... Or the email got eaten by something (maybe me)
> Sorry about that.
> 
> Jonathan
> > 
> > Can you fix this up and resend?  
> 
> Coming right up - assuming I don't mess up rebasing.

Gah. I hate fixes tags sometimes (on the plus side I do like your script
for checking them which I'd obviously failed to run on the very first patch
on my tree for some reason). 6 others were broken as a result of the
rebase to fix this one and needed manual repair.

Anyhow, fingers crossed v2 is in better shape. Thankfully everything I have
queued for a second pull request so far hasn't had fixes tags.
I plan to let the second set have a few days in Linux next before sending
another (hopefully better!) final pull request for 6.2 stuff.

Thanks as ever for your help and one day I'll get this right first time every
time :(

Jonathan

> 
> > 
> > thanks,
> > 
> > greg k-h  
> 

