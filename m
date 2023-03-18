Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42276BFB82
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 17:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRQZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 12:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCRQZx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 12:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12D5126F3
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 09:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4366160E93
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 16:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D90C433EF;
        Sat, 18 Mar 2023 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679156751;
        bh=6R/1P2Quynr5mNcruOicXmQT70ahwWfQg9go4fzL1rM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EEKXFZNbwlRlDWj+6eh6KYWNvbbBAJ5OKPuPOFKPJVTmca9cY3liZ88vUi8zLFZ6/
         0EG3oNt0ZwytpF3MdlJ5SYhJbvQzHgu/vyuRI4GuR/bVAsiNsL1Gk+9jQKOJw8XV4V
         +n6aXHqXHI1aMPKd9//W2UnCzygPhOqPGjWEpzTptUNcnbraxeqptz9dD7F2WQwLqP
         BkQ+lEQjD6FcLk8CxzHa2YO/E3O8gej05TTw/1/7hh4wJ9/ioZ2ebX7BPEZS8JZ0QV
         YO0/iW7OtgFgODwDDSA/WcgFHCpJDFRBVV+b3nb1JuxQCIX9esz1zJetdPyJTWzdou
         JoBpkQ+Qqc+Wg==
Date:   Sat, 18 Mar 2023 16:40:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Justin Chen <justinpopo6@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: Set `can_sleep` flag for GPIO
 chip
Message-ID: <20230318164045.4a5f4d35@jic23-huawei>
In-Reply-To: <603a73ae-5c67-0837-ed26-9a98ad3fec74@lechnology.com>
References: <20230312210933.2275376-1-lars@metafoo.de>
        <603a73ae-5c67-0837-ed26-9a98ad3fec74@lechnology.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Mon, 13 Mar 2023 13:44:33 -0500
David Lechner <david@lechnology.com> wrote:

> On 3/12/23 4:09 PM, Lars-Peter Clausen wrote:
> > The ads7950 uses a mutex as well as SPI transfers in its GPIO callbacks.
> > This means these callbacks can sleep and the `can_sleep` flag should be
> > set.
> > 
> > Having the flag set will make sure that warnings are generated when calling
> > any of the callbacks from a potentially non-sleeping context.
> > 
> > Fixes: c97dce792dc8 ("iio: adc: ti-ads7950: add GPIO support")
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---  
> 
> Acked-by: David Lechner <david@lechnology.com>
> 
> 

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,
Jonathan
