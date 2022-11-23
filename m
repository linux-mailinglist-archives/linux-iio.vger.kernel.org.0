Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A196369F2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 20:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiKWTgt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 14:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKWTgr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 14:36:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B0C8A152
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 11:36:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA8CAB821F4
        for <linux-iio@vger.kernel.org>; Wed, 23 Nov 2022 19:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6BDC433C1;
        Wed, 23 Nov 2022 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669232204;
        bh=QHLmlMZOzSB3g4QNdtPvzlruwQ6OH3bIhJJuwzRZj6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dCqmK5qAwIeiVhhhOixIVpiLxowKURdQkDyC4NwRAcYU/AKJup1hAjZaQ2jgwM0m4
         wt4kUhmJrb6wb53uBIAAnmN0WZSecHBLh4XnkI3QvckTEqJoiv9NcsT8xyV8r/JFZK
         C1NIPBGJSoSUrpuzP0PyNBJZgNhBuLpo/56lIffQKotTZW5lDQotvRQuZtX+tpzxVO
         hcVEzXGKBGoSWrjktSuhzE6roDUo/p5csOF+ORqFcQP02vPpI4rofDDm4uT+3zEtQg
         VVtFbFPeRQBt+se5+NF0XjIiTm6xi2kQdYgqUoZheWOY7f9cfp3jWiXaVYLuo3Pnv5
         EdbjA+TBNp7AA==
Date:   Wed, 23 Nov 2022 19:49:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support, features and
 cleanup for 6.2
Message-ID: <20221123194918.3d523e97@jic23-huawei>
In-Reply-To: <Y35pOOLEW8mtxnxa@kroah.com>
References: <20221116190308.76cfba5a@jic23-huawei>
        <Y35pOOLEW8mtxnxa@kroah.com>
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

On Wed, 23 Nov 2022 19:40:56 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Nov 16, 2022 at 07:03:08PM +0000, Jonathan Cameron wrote:
> > The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:
> > 
> >   Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.2a  
> 
> I get the following error when trying to push these out:
> 
> Commit: 3acdb4a11517 ("iio: adc: ad_sigma_delta: do not use internal iio_dev lock")
> 	Fixes tag: Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Deltadevices")
> 	Has these problem(s):
> 		- Subject does not match target commit subject
> 		 Just use
> 			git log -1 --format='Fixes: %h ("%s")'
> 
> 
> linux-next should have also warned of this, right?

It didn't... Or the email got eaten by something (maybe me)
Sorry about that.

Jonathan
> 
> Can you fix this up and resend?

Coming right up - assuming I don't mess up rebasing.

> 
> thanks,
> 
> greg k-h

