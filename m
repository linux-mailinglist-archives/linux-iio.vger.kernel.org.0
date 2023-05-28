Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ECA713C24
	for <lists+linux-iio@lfdr.de>; Sun, 28 May 2023 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjE1TFT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 May 2023 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjE1TFS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 May 2023 15:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02206C4
        for <linux-iio@vger.kernel.org>; Sun, 28 May 2023 12:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88F29618C5
        for <linux-iio@vger.kernel.org>; Sun, 28 May 2023 19:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842DFC433A4;
        Sun, 28 May 2023 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300717;
        bh=a92p2VDbTvaTkbP5pCP7jp8gqsCGylVmJwMzCS48/sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7pGXFl06d/UZsx6vXmVTuR4fm+KH3ElfsLiBwLfDuQBvDdpaW1qRLV8Q41G5eirI
         z3M5DKhKA7E+I/Mgz9pcrswTkfikLhhMlaBeC2ScZ073J9xQciBWVNhrOq4unPI2pS
         YbwZwynEPXj25w+zHKieyvQqYEFjVTh/vKOHc5Xc=
Date:   Sun, 28 May 2023 20:04:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for the 6.4 cycle.
Message-ID: <2023052832-contact-reunite-4a85@gregkh>
References: <20230528200811.11b15e04@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528200811.11b15e04@jic23-huawei>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 28, 2023 at 08:08:11PM +0100, Jonathan Cameron wrote:
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.4a

Pulled and pushed out, thanks.

greg k-h
