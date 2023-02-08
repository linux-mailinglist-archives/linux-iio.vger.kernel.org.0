Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14968F456
	for <lists+linux-iio@lfdr.de>; Wed,  8 Feb 2023 18:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjBHRX0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Feb 2023 12:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBHRXZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Feb 2023 12:23:25 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 235B293D8
        for <linux-iio@vger.kernel.org>; Wed,  8 Feb 2023 09:23:21 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 08E06DF00A8; Wed,  8 Feb 2023 18:15:23 +0100 (CET)
Date:   Wed, 8 Feb 2023 18:15:23 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
        settling time
Message-ID: <20230208171523.GA28208@frolo.macqel>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org> <20230208162331.GA27875@frolo.macqel> <Y+PPD3iWlw9tdfHS@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PPD3iWlw9tdfHS@lore-desk>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello again Lorenzo,

On Wed, Feb 08, 2023 at 05:34:23PM +0100, Lorenzo Bianconi wrote:

> Date: Wed, 8 Feb 2023 17:34:23 +0100
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> To: Philippe De Muyter <phdm@macq.eu>
> Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
> 	lorenzo.bianconi@redhat.com
> Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
> 	settling time
> 
> > Hello Lorenzo,
> > 
> > thank you for your patch.
> > 
> > I had successfully applied the previous one, but not yet had time
> > to test it, but this one I cannot apply.
> > 
> > On which branch/tag does it apply ?
> 
> I am using testing branch from linux-iio tree:
> 
> git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> 
> Regards,
> Lorenzo

I have fetched it with :

  git fetch https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git +testing

git am complains with :
 $ git am ~/st_lsm6dsx-real.patch
 Applying: iio: imu: st_lsm6dsx: discard samples during filters settling time
 error: patch failed: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h:137
 error: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h: patch does not apply
 error: patch failed: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:457
 error: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c: patch does not apply
 error: patch failed: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:634
 error: drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c: patch does not apply
 Patch failed at 0001 iio: imu: st_lsm6dsx: discard samples during filters settling time
 hint: Use 'git am --show-current-patch=diff' to see the failed patch
 When you have resolved this problem, run "git am --continue".
 If you prefer to skip this patch, run "git am --skip" instead.
 To restore the original branch and stop patching, run "git am --abort".

and patch -p1 with :
 $ patch -p1 < ~/st_lsm6dsx-real.patch
 patching file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
 Hunk #1 succeeded at 144 with fuzz 2 (offset 7 lines).
 Hunk #2 FAILED at 298.
 Hunk #3 FAILED at 330.
 Hunk #4 FAILED at 360.
 Hunk #5 FAILED at 374.
 4 out of 5 hunks FAILED -- saving rejects to file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h.rej
 patching file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
 Hunk #1 FAILED at 457.
 Hunk #2 FAILED at 541.
 Hunk #3 succeeded at 673 with fuzz 1 (offset 19 lines).
 Hunk #4 FAILED at 692.
 3 out of 4 hunks FAILED -- saving rejects to file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c.rej
 patching file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
 Hunk #1 FAILED at 634.
 1 out of 1 hunk FAILED -- saving rejects to file drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c.rej


Could it be something caused by your or my mail-transfer-agent ?

Best regards

Philippe
