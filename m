Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A976940BB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Feb 2023 10:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBMJUC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Feb 2023 04:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBMJUC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2023 04:20:02 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 797DCEB66
        for <linux-iio@vger.kernel.org>; Mon, 13 Feb 2023 01:20:00 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id EBA54DF00A8; Mon, 13 Feb 2023 10:19:57 +0100 (CET)
Date:   Mon, 13 Feb 2023 10:19:57 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
        settling time
Message-ID: <20230213091957.GA4925@frolo.macqel>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org> <Y+i9rImVqH7iVets@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+i9rImVqH7iVets@lore-desk>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lorenzo,

On Sun, Feb 12, 2023 at 11:21:32AM +0100, Lorenzo Bianconi wrote:
> Date: Sun, 12 Feb 2023 11:21:32 +0100
> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> To: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: jic23@kernel.org, phdm@macq.eu, linux-iio@vger.kernel.org
> Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
> 	settling time
> 
> > During digital filters settling time the driver is expected to drop
> > samples since they can be corrupted. Introduce the capability to drop
> > a given number of samples according to the configured ODR.
> > Add the sample_to_discard data for LSM6DSM sensor.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 11 ++++
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 58 +++++++++++++++----
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 18 ++++++
> >  3 files changed, 77 insertions(+), 10 deletions(-)
> 
> I forgot to say I tested this patch on my LSM6DSM and it works fine for me.
> 
> Regards,
> Lorenzo
> 

It works fine for me too, with a ism330dlc.

	Reported-by: Philippe De Muyter <phdm@macqel.be>
	Tested-by: Philippe De Muyter <phdm@macqel.be>

However I have another bug, with our without the patch : frequently
my test, using a loop around iio-generic-buffer, blocks on the poll syscall.
No value comes anymore.  This happens both with the gyro as with the accel
component.

More info follows.

Best regards

Philippe
