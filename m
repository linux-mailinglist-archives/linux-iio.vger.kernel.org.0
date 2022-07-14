Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28798574EB1
	for <lists+linux-iio@lfdr.de>; Thu, 14 Jul 2022 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiGNNJV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Jul 2022 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiGNNJV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2022 09:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE82EE15
        for <linux-iio@vger.kernel.org>; Thu, 14 Jul 2022 06:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2E916203C
        for <linux-iio@vger.kernel.org>; Thu, 14 Jul 2022 13:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B016C34114;
        Thu, 14 Jul 2022 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657804159;
        bh=bPNnrgaZjw8UJq6Uce2HZm39xA1YOIvmqx86duUuQzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uq4RmbVgYy0vs/1OHXIA0YyEkTUG/gmarLOVfJVXfTCLhxzZsLlZruAZF26OkjPBK
         Keg1WwVrOwc2GIgnA08nxyChii/nO8OeU8QkIcBbfU2qqfevvGU+IccLcF2oJMcmjg
         /t3zJCu/bpTpWHz1Iqyd2KEC+IkF+NCjdDkxHnII=
Date:   Thu, 14 Jul 2022 15:09:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features, cleanup and minor
 fixes for 5.20
Message-ID: <YtAVdD2sSG5JeuPX@kroah.com>
References: <20220714131247.4e07146f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714131247.4e07146f@jic23-huawei>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 14, 2022 at 01:12:47PM +0100, Jonathan Cameron wrote:
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> 
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.20a
> 
> for you to fetch changes up to 568f6869e680c7492c5e38df9094af86fe9d6364:
> 
>   iio: adc: xilinx-xadc: Drop duplicate NULL check in xadc_parse_dt() (2022-07-13 17:11:43 +0100)

Pulled and pushed out, thanks.

greg k-h
