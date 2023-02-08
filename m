Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC868F31D
	for <lists+linux-iio@lfdr.de>; Wed,  8 Feb 2023 17:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBHQXo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Feb 2023 11:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjBHQXn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Feb 2023 11:23:43 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D11F1457C4
        for <linux-iio@vger.kernel.org>; Wed,  8 Feb 2023 08:23:34 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 2AC41DF00A8; Wed,  8 Feb 2023 17:23:31 +0100 (CET)
Date:   Wed, 8 Feb 2023 17:23:32 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
        settling time
Message-ID: <20230208162331.GA27875@frolo.macqel>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
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

thank you for your patch.

On Wed, Feb 08, 2023 at 03:42:31PM +0100, Lorenzo Bianconi wrote:
> 
> During digital filters settling time the driver is expected to drop
> samples since they can be corrupted. Introduce the capability to drop
> a given number of samples according to the configured ODR.
> Add the sample_to_discard data for LSM6DSM sensor.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 11 ++++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 58 +++++++++++++++----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 18 ++++++
>  3 files changed, 77 insertions(+), 10 deletions(-)
> 

I had successfully applied the previous one, but not yet had time
to test it, but this one I cannot apply.

On which branch/tag does it apply ?

Best regards

Philippe
